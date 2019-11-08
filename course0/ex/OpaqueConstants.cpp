#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Constant.h"
#include "llvm/ADT/DenseMap.h"
#include "llvm/ADT/SetVector.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/Support/raw_ostream.h"

#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"
#include "llvm/Transforms/Utils/Cloning.h"

#include "llvm/Support/CommandLine.h"

#include "AbstractFilterFactory.h"
#include "MBAHandlers.h"

#include <random>
#include <algorithm>

using namespace llvm;

namespace {

bool InlineFunction(CallSite CS) {
  InlineFunctionInfo IFI;
  return llvm::InlineFunction(CS, IFI, nullptr, true);
}

bool IsBinopWithConstantOperand(Instruction &I) {
  // TODO check if it is a BinaryOperator with a ConstantInt operand
  // see isa<> dyn_cast<>, BinaryOperator
  if (isa<BinaryOperator>(I)) {
    return isa<ConstantInt>(I.getOperand(0)) || isa<ConstantInt>(I.getOperand(1));
  } 
  
  //TODO: dyn_cast?

  return false;
}

Value* GetLiveValue(Instruction &I, AbstractFilterFactory::FilterTy Filter) {
  BasicBlock &B = *I.getParent();
  Function &F = *B.getParent();

  SetVector<Value*> Values;

  auto AddValue = [&](Value &V) {
    if(!isa<Constant>(V) && V.getType()->isIntegerTy() && Filter(V)) 
      Values.insert(&V);
  };

  // TODO this function returns a variable from the context, 
  //   pick a variable that is :
  //   * an argument of the function (see arg_begin, arg_end) 
  //   * an instruction in the same basic block as I
  //   * or an operand of a non-phi instruction in the same basic block () 
  //
  // To avoid problems in the future, use AddValue above to add things to the set of possible values (Values)

  std::for_each(F.arg_begin(), F.arg_end(), AddValue);
  std::for_each(B.getInstList().begin(), I.getIterator(), AddValue);

  // TODO: falta el ultimo caso

  if(Values.empty())
    return ConstantInt::get(Type::getInt64Ty(I.getContext()), 0);

  // keep the random engine initialized with a fixed seed
  static std::mt19937 engine(0);
  std::uniform_int_distribution<size_t> random_dist{0, Values.size()-1};

  size_t idx = random_dist(engine);
  return Values[idx];
}

Function* GetFAbs(Module &M) {
  Type* Double = Type::getDoubleTy(M.getContext());
  return Intrinsic::getDeclaration(&M, Intrinsic::fabs, {Double});
}

Function* GetLog2(Module &M) {
  Type* Double = Type::getDoubleTy(M.getContext());
  return Intrinsic::getDeclaration(&M, Intrinsic::log2, {Double});
}

Function* GetLog10(Module &M) {
  Type* Double = Type::getDoubleTy(M.getContext());
  return Intrinsic::getDeclaration(&M, Intrinsic::log10, {Double});
}

Function* GetLeibiniz(Module &M) {
  if(Function *F = M.getFunction("internal.leibiniz")) {
    return F;
  }

  LLVMContext &C = M.getContext();

  Type* Double = Type::getDoubleTy(C);
  Type* I8 = Type::getInt8Ty(C);
  FunctionType* FTy = FunctionType::get(Double, I8, false);
  Function* F = Function::Create(FTy, GlobalValue::PrivateLinkage, "internal.leibiniz", &M);

  BasicBlock* Entry = BasicBlock::Create(C, "entry", F);
  BasicBlock* LoopHead = BasicBlock::Create(C, "loop_head", F);
  BasicBlock* LoopBody = BasicBlock::Create(C, "loop_body", F);
  BasicBlock* Exit = BasicBlock::Create(C, "exit", F);

  IRBuilder<> B(C);

  Value* N_Arg = F->arg_begin();
  Type* I64 = Type::getInt64Ty(C);
  Type* Bool = Type::getInt1Ty(C);

  Constant* Zero= ConstantInt::get(I64, 0);
  Constant* One = ConstantInt::get(I64, 1);
  Constant* Two = ConstantInt::get(I64, 2);
  Constant* FPZero = ConstantFP::get(Double, 0.0);
  Constant* FPOne = ConstantFP::get(Double, 1.0);
  Constant* FPmOne = ConstantFP::get(Double, -1.0);
  Constant* FPTwo = ConstantFP::get(Double, 2.0);
  Constant* FPFour = ConstantFP::get(Double, 4.0);

  // entry:
  //   sum = 0.0
  //   sign = (n%2 == 0) ? -1.0 : 1.0
  //   i = 2*n-1
  B.SetInsertPoint(Entry);
  Value* Sum_Init = FPZero;
  Value* N_Init = B.CreateIntCast(N_Arg, I64, false, "n.init");
  Value* I_Init = B.CreateSub(B.CreateShl(N_Init, One), One, "i.init");
  Value* Sign_InitCond = B.CreateICmpEQ(B.CreateURem(N_Init, Two), Zero, "sign.cond");
  Value* Sign_Init = B.CreateSelect(Sign_InitCond, FPmOne, FPOne, "sign.init");
  B.CreateBr(LoopHead);

  // loop_head:
  //   phis
  //   n-- > 0
  B.SetInsertPoint(LoopHead);
  PHINode* N = B.CreatePHI(I64, 2, "n");
  PHINode* Sum = B.CreatePHI(Double, 2, "sum");
  PHINode* I = B.CreatePHI(I64, 2, "i");
  PHINode* Sign = B.CreatePHI(Double, 2, "sign");

  Value* N_Update = B.CreateSub(N, One, "n.update");
  Value* LoopCond = B.CreateICmpNE(N, Zero, "loop_cond");
  B.CreateCondBr(LoopCond, LoopBody, Exit);

  // loop_body:
  //   sum += sign/i;
  //   sign = -sign;
  //   i -= 2;
  B.SetInsertPoint(LoopBody);
  Value* Sum_Update = B.CreateFAdd(Sum, B.CreateFDiv(Sign, B.CreateUIToFP(I, Double)), "sum.update");
  Value* Sign_Update = B.CreateFMul(Sign, FPmOne, "sign.update");
  Value* I_Update = B.CreateSub(I, Two, "i.update");
  B.CreateBr(LoopHead);

  // exit:
  //   return 4*sum 
  B.SetInsertPoint(Exit);
  B.CreateRet(B.CreateFMul(FPFour, Sum));

  // set the phi nodes
  N->addIncoming(N_Init, Entry);
  Sum->addIncoming(Sum_Init, Entry);
  I->addIncoming(I_Init, Entry);
  Sign->addIncoming(Sign_Init, Entry);

  N->addIncoming(N_Update, LoopBody);
  Sum->addIncoming(Sum_Update, LoopBody);
  I->addIncoming(I_Update, LoopBody);
  Sign->addIncoming(Sign_Update, LoopBody);

  return F;
}

Value* wrapHandleAdd(Value* V) {
  Instruction* IA = dyn_cast<Instruction>(V);

  if (IA != NULL) {
    return HandleAdd(*IA);
  }

  return V;
}

void HandleMBA(Instruction &I) {
  std::mt19937 RandomEngine(0);
  std::uniform_int_distribution<size_t> random_dist{0, I.getNumOperands() - 1};
  
  size_t rand_operand = random_dist(RandomEngine);
  
  unsigned constant_op_rand = isa<ConstantInt>(I.getOperand(rand_operand)) ? rand_operand : 0;
  unsigned constant_op_idx  = isa<ConstantInt>(I.getOperand(0)) ? 0 : 1;

  Value* C  = I.getOperand(constant_op_rand);
  Value* C2 = I.getOperand(constant_op_idx); // this has to be assigned to a random constant different from C
  Value* X  = GetLiveValue(I, AbstractFilterFactory::get().createFilter(I));

  IRBuilder<> B(&I);

  // TODO if necessary, cast everything to a big integer type
  // see IRBuilder<>::CreateIntCast
  // X puede no tener el tipo de C
  X = B.CreateIntCast(X, C->getType(), false);
  
  // TODO do  (-X+(C-C'))+(X+C') where X is a live variable, C is the original operand, C' is a new random operand. Use RandomEngine() to get a new random int
  // 1) -X
  Value* XNeg = B.CreateNeg(X);

  // 2) C - C'
  Value* CMinC2 = B.CreateSub(C, C2);

  // TODO obfuscate the three different adds using MBA
  // 3) X + C'
  Value* XPlusC2 = wrapHandleAdd(B.CreateAdd(X, C2));
  Value* OnePlusTwo = wrapHandleAdd(B.CreateAdd(XNeg, CMinC2));
  Value* Result = wrapHandleAdd(B.CreateAdd(OnePlusTwo, XPlusC2));

  I.setOperand(constant_op_rand, Result);
}

void HandleSoft(Instruction &I) {
  Module &M = *I.getModule();
  Function* Log2 = GetLog2(M);
  Function* Log10 = GetLog10(M);
  Function* FAbs = GetFAbs(M);

  Type *T = I.getType();

  unsigned constant_op_idx = isa<ConstantInt>(I.getOperand(0)) ? 0 : 1;
  Value* C = I.getOperand(constant_op_idx);
  Value* X = GetLiveValue(I, AbstractFilterFactory::get().createFilter(I));

  IRBuilder<> B(&I);

  // CallInst* llamadalog10 = B.createCall(Log10, X)

  // TODO P(x) = (l2(x) == log10(x) / log10(2)) . consider using a certain error instead of equality
  // casts from int to float must be used: IRBuilder<>::CreateUIToFP
  // TODO the new operand C' is equal to C^0x1. So C'^P(x) == C^0x1^P(x) and since P(x) returns always 1, C'^P(x) == C
  // Type* Floating = Log2->getFunctionType()->getReturnType();

}

void HandleHard(Instruction &I) {
  IRBuilder<> B(&I);

  Module &M = *I.getModule();
  Type *T = I.getType();

  unsigned constant_op_idx = isa<ConstantInt>(I.getOperand(0)) ? 0 : 1;
  Value* C = I.getOperand(constant_op_idx);
  Value* X = GetLiveValue(I, AbstractFilterFactory::get().createFilter(I));

  Function* FAbs = GetFAbs(M);
  Function* Leibiniz = GetLeibiniz(M);

  // TODO Use the leibiniz series to approximate Pi. 
  // The leibiniz series, after 10 iterations gives an error smaller than 0.2 
  // Bound the number of iteratons using some mask ! 
  // TODO Compare the approximation given by the leibiniz series to pi 
  // TODO Inline the leibiniz function 
  
}

static cl::opt<double> Ratio("opaque-constants-ratio", 
    cl::init(1.0), cl::desc("Ratio to control the OpaqueConstants pass"));

enum OCAlgo { MBA=0, Light, Heavy };

static cl::opt<unsigned> UseAlgo("opaque-constants-algo", 
    cl::init(OCAlgo::MBA), cl::desc("Choose between algorithm types (values between 0-2)."));

struct OpaqueConstants : public ModulePass {

  static char ID;
  OpaqueConstants() : ModulePass(ID) {}

  bool runOnModule(Module &M) override {
    SmallVector<std::reference_wrapper<Function>, 32> Functions(M.begin(), M.end());
    return std::accumulate(Functions.begin(), Functions.end(), false, 
        [this](bool modified, Function& F) { return runOnFunction(F) | modified; });
  }

  bool runOnFunction(Function &F) {

    SmallVector<Instruction*, 8> Candidates;

    for(BasicBlock &B : F) {
      for(Instruction &I : B) {
        if(IsBinopWithConstantOperand(I))
            Candidates.push_back(&I);
      }
    }

    // Keep only Candidates.size()*ratio candidates
    std::mt19937 RandomEngine(0);
    std::shuffle(Candidates.begin(), Candidates.end(), RandomEngine);
    size_t N = std::max<size_t>(std::min<size_t>(Ratio * Candidates.size(), Candidates.size()), 0);
    Candidates.erase(Candidates.begin()+N, Candidates.end());

    auto Handle = (UseAlgo == 2) ? HandleHard : ((UseAlgo == 1) ? HandleSoft : HandleMBA);
    for(Instruction *I : Candidates) {
      Handle(*I);
    }

    return !Candidates.empty();
  }
}; 
char OpaqueConstants::ID = 0;
} 

static RegisterPass<OpaqueConstants> X("opaque-constants", "OpaqueConstants", false, false);
