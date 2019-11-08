#include "llvm/Pass.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/IR/CFG.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Transforms/Utils/ValueMapper.h"
#include "llvm/Transforms/Utils/Local.h"
#include "llvm/Transforms/Utils/PromoteMemToReg.h"
#include "llvm/Support/raw_ostream.h"

#include <algorithm>
#include <numeric>
#include <random>

using namespace llvm;

namespace {

unsigned constexpr ipow(unsigned x, unsigned i) {
  if(i == 0)
    return 1;
  return x*ipow(x,i-1);
}

class Whitebox {
  unsigned _seed;
  std::vector<uint8_t> _EncodeVals; 
  GlobalVariable *_Encode;
  GlobalVariable *_Decode;
  std::map<unsigned, GlobalVariable*> _Op2Table;
  std::map<unsigned, GlobalVariable*> _Cmp2Table;

  public:

  Whitebox(Module &M, unsigned seed) {
    _seed = seed;

    // build encode and decode tables
    _EncodeVals.resize(256);
    std::iota(_EncodeVals.begin(), _EncodeVals.end(), 0);
    std::shuffle(_EncodeVals.begin(), _EncodeVals.end(), 
                 std::default_random_engine(seed));

    using xvec = ArrayRef<uint8_t>;

    // init the handlers of operations
    _Encode = CreateTable(M, "__encode_" + std::to_string(seed), 1, false, true, [](xvec x) -> uint8_t { return x[0]; });
    _Decode = CreateTable(M, "__decode_" + std::to_string(seed), 1, true, false, [](xvec x) -> uint8_t { return x[0]; });

    _Op2Table[Instruction::Add] = CreateTable(M, "__add_" + std::to_string(seed), 2, true, true, [](xvec x) -> uint8_t { return x[0]+x[1]; });
    _Op2Table[Instruction::Sub] = CreateTable(M, "__sub_" + std::to_string(seed), 2, true, true, [](xvec x) -> uint8_t { return x[0]-x[1]; });
    _Op2Table[Instruction::Mul] = CreateTable(M, "__mul_" + std::to_string(seed), 2, true, true, [](xvec x) -> uint8_t { return x[0]*x[1]; });
    _Op2Table[Instruction::And] = CreateTable(M, "__and_" + std::to_string(seed), 2, true, true, [](xvec x) -> uint8_t { return x[0]&x[1]; });
    _Op2Table[Instruction::Or] = CreateTable(M, "__or_" + std::to_string(seed), 2, true, true, [](xvec x) -> uint8_t { return x[0]|x[1]; });
    _Op2Table[Instruction::Xor] = CreateTable(M, "__xor_" + std::to_string(seed), 2, true, true, [](xvec x) -> uint8_t { return x[0]^x[1]; });
    _Op2Table[Instruction::Shl] = CreateTable(M, "__shl_" + std::to_string(seed), 2, true, true, [](xvec x) -> uint8_t { return x[0]<<x[1]; });
    _Op2Table[Instruction::LShr] = CreateTable(M, "__lshr_" + std::to_string(seed), 2, true, true, [](xvec x) -> uint8_t { return x[0]>>x[1]; });

    _Cmp2Table[CmpInst::ICMP_EQ] = CreateTable(M, "__eq_" + std::to_string(seed), 2, true, true, [](xvec x) -> uint8_t { return x[0] == x[1]; });
    _Cmp2Table[CmpInst::ICMP_NE] = CreateTable(M, "__ne_" + std::to_string(seed), 2, true, true, [](xvec x) -> uint8_t { return x[0] != x[1]; });
    _Cmp2Table[CmpInst::ICMP_ULT] = CreateTable(M, "__lt_" + std::to_string(seed), 2, true, true, [](xvec x) -> uint8_t { return x[0] < x[1]; });
    _Cmp2Table[CmpInst::ICMP_ULE] = CreateTable(M, "__le_" + std::to_string(seed), 2, true, true, [](xvec x) -> uint8_t { return x[0] <= x[1]; });
    _Cmp2Table[CmpInst::ICMP_UGT] = CreateTable(M, "__gt_" + std::to_string(seed), 2, true, true, [](xvec x) -> uint8_t { return x[0] > x[1]; });
    _Cmp2Table[CmpInst::ICMP_UGE] = CreateTable(M, "__ge_" + std::to_string(seed), 2, true, true, [](xvec x) -> uint8_t { return x[0] >= x[1]; });
  }

  bool CanTabulate(Instruction const &I) {
    IntegerType* IT = dyn_cast<IntegerType>(I.getType());
    if(!IT || IT->getPrimitiveSizeInBits() > 8)
      return false;
    if(_Op2Table.find(I.getOpcode()) != _Op2Table.end())
      return true;
    ICmpInst const* ICmp = dyn_cast<ICmpInst>(&I);
    if(ICmp && _Cmp2Table.find(ICmp->getPredicate()) != _Cmp2Table.end()) 
      return true;
    return false;
  }


  template<class Fx>
  void FillInitTable(Type* ElementTy, std::vector<Constant*> &Init, SmallVectorImpl<uint8_t> &X, unsigned dim, bool EncodedIn, bool EncodedOut, Fx &fx) {
    if(dim == X.size()) {
      // calculate the offset for x when it's encoded
      unsigned ExOffset = 0;
      unsigned DimSize = 1;
      for(unsigned i = 0; i != X.size(); ++i) {
        unsigned Ex = EncodedIn ? _EncodeVals[X[i]] : X[i];
        ExOffset = (DimSize * ExOffset) + Ex;
        DimSize *= 256;
      }

      // calculate the value of y when it's encoded
      unsigned y = fx(X);
      unsigned Ey = EncodedOut ? _EncodeVals[y] : y; 

      Init[ExOffset] = ConstantInt::get(ElementTy, Ey);
      return;
    }

    for(unsigned x = 0; x != 256; ++x) {
      X[dim] = x;
      FillInitTable(ElementTy, Init, X, dim+1, EncodedIn, EncodedOut, fx);
    }
  }

  template<class Fx>
  Constant* GetTableInit(LLVMContext &C, unsigned Dims, bool EncodedIn, bool EncodedOut, Fx &fx) {
    assert(Dims);

    std::vector<Constant*> Init(ipow(256, Dims));
    SmallVector<uint8_t, 4> X(Dims, 0);
    FillInitTable(Type::getInt8Ty(C), Init, X, 0, EncodedIn, EncodedOut, fx);

    // group in arrays of 256 elements until there is only one
    while(Init.size() != 1) {
      std::vector<Constant*> NewInit(Init.size() / 256);

      ArrayType *AT = ArrayType::get(Init.front()->getType(), 256);
      for(unsigned i = 0; i != (Init.size()/256); ++i) {
        NewInit[i] = 
          ConstantArray::get(AT, 
              ArrayRef<Constant*>(Init.data() + i*256, Init.data() + (i+1)*256));
      }

      Init = std::move(NewInit);
    }

    return Init[0];
  }

  template<class Fx>
  GlobalVariable* CreateTable(Module &M, Twine Name, unsigned Dims, bool EncodedIn, bool EncodedOut, Fx &&fx) {
    if(GlobalVariable *GV = M.getGlobalVariable(Name.str(), true))
      return GV;
    LLVMContext &C = M.getContext();

    Constant* Init = GetTableInit(C, Dims, EncodedIn, EncodedOut, fx);
    GlobalVariable *GV = new GlobalVariable(M, Init->getType(), true, 
                                            GlobalVariable::PrivateLinkage, 
                                            Init, Name);
    return GV;
  }

  Value* Encode(IRBuilder<> &B, Value &X) {
    Type* I8 = Type::getInt8Ty(X.getContext());
    if(ConstantInt* CX = dyn_cast<ConstantInt>(&X)) {
      return ConstantInt::get(I8, _EncodeVals[CX->getZExtValue()]);
    }
    Type* I32 = Type::getInt32Ty(X.getContext());
    Constant* Zero = ConstantInt::get(I8, 0);
    Value* Ptr = B.CreateGEP(nullptr, _Encode, {Zero, B.CreateIntCast(&X, I32, false)});
    Value* Load = B.CreateLoad(Ptr, "encode_" + X.getName());
    return Load;
  }

  Value* Decode(IRBuilder<> &B, Value &X, Type* T) {
    Type* I32 = Type::getInt32Ty(X.getContext());
    Constant* Zero = ConstantInt::get(Type::getInt8Ty(X.getContext()), 0);
    Value* Ptr = B.CreateGEP(nullptr, _Decode, {Zero, B.CreateIntCast(&X, I32, false)});
    Value* Load = B.CreateLoad(Ptr, "decode_" + X.getName());
    if(T != Load->getType())
      Load = B.CreateIntCast(Load, T, false);
    return Load;
  }

  GlobalVariable* GetTable(Instruction const &I) {
    assert(CanTabulate(I));
    CmpInst const* IAsCmp = dyn_cast<CmpInst const>(&I);
    GlobalVariable* Table = IAsCmp ? _Cmp2Table[IAsCmp->getPredicate()] : _Op2Table[I.getOpcode()]; 
    return Table;
  }
};

Instruction* WhitenInstr(Whitebox& WB, Instruction &I, BasicBlock &InsertAt, SmallPtrSetImpl<Instruction*> &Tabulated, ValueToValueMapTy &VMap) {
  IRBuilder<> Builder(&InsertAt);
  Instruction *New;
  if(WB.CanTabulate(I)) {
    Tabulated.insert(&I);  
    // TODO Create an access to the corresponding table. Be careful, if the operands is not already encoded it must be encoded 
    //   Use the GetElementPtr instruction to calculate the element on the offset (IRBuilder<>::CreateGEP). 
    //   The first operand must be 0 and the rest must be the encoded operands 
    //   Add instruction to Tabulate
  } else {
    // TODO Clone the instruction using Instruction::clone 
    //   If the operand is encoded it must be decoded
    //   Remember to fix the operands of the cloned instruction (they point to the ones in the original function)
    //   Remember to add the instruction to the basicblock IRBuilder<>::Insert 
  }
  VMap[&I] = New;
  return New; 
}

Function* Whiten(Function &F, LoopInfo &LI) {
  LLVMContext &C = F.getContext();
  Whitebox WB(*F.getParent(), 0);

  Function *WF = Function::Create(F.getFunctionType(), F.getLinkage(), 
                                  F.getAddressSpace(), "__whiteboxed_" + F.getName(), 
                                  F.getParent());

  // create new blocks and count the predecessors for the topological traversal
  ValueToValueMapTy VMap;
  SmallPtrSet<Instruction*, 32> Tabulated;
  DenseMap<BasicBlock*, unsigned> Preds;

  for(BasicBlock &B : F)
    while(PHINode* PHI = dyn_cast<PHINode>(B.begin())) 
      DemotePHIToStack(PHI);
  
  for(auto orig_arg = F.arg_begin(), wb_arg = WF->arg_begin(); orig_arg != F.arg_end(); ++orig_arg, ++wb_arg) {
    wb_arg->setName(orig_arg->getName());
    VMap[&*orig_arg] = &*wb_arg;
  }

  for(BasicBlock &B : F) {
    BasicBlock *WB = BasicBlock::Create(C, B.getName(), WF);
    VMap[&B] = WB;

    Preds[&B] = std::distance(pred_begin(&B), pred_end(&B));
  }

  // substract number of backedges if it is a loop header
  for(Loop* L : LI) {
    BasicBlock* H = L->getHeader();
    for(BasicBlock *PH : predecessors(H))
      if(L->contains(PH))
        --Preds[H];
  }

  // clone block by block content in topological order
  SmallVector<BasicBlock*, 8> Q;
  for(BasicBlock &B : F)
    if(Preds[&B] == 0)
      Q.push_back(&B);

  while(!Q.empty()) {
    BasicBlock *B = Q.pop_back_val();

    // clone every instruction
    for(Instruction &I : *B) {
      WhitenInstr(WB, I, *cast<BasicBlock>(VMap[B]), Tabulated, VMap);
    }

    for(BasicBlock* SB : successors(B)) {
      Preds[SB] = std::max<unsigned>(Preds[SB]-1, 0);
      if(!Preds[SB])
        Q.push_back(SB);
    }
  }

  return WF;
}

struct WhiteboxMe : public ModulePass {
  static char ID;
  WhiteboxMe() : ModulePass(ID) {}

  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.addRequired<LoopInfoWrapperPass>();
  }

  bool runOnModule(Module &M) override {
    SmallVector<Function*, 4> ToWhitebox;
    for(Function &F : M)
      if(F.getSection() == "whitebox.me")
        ToWhitebox.push_back(&F);

    for(Function *F : ToWhitebox) {
      Function* WB = Whiten(*F, getAnalysis<LoopInfoWrapperPass>(*F).getLoopInfo());
      F->replaceAllUsesWith(WB);
      WB->takeName(F);
      F->eraseFromParent();
    }

    return false;
  }
};
char WhiteboxMe::ID = 0;
} 

static RegisterPass<WhiteboxMe> X("whitebox-me", 
    "Transform a function of i8 into a whiteboxed version", 
    false, false);
