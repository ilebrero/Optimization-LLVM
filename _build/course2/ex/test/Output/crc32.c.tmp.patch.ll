; ModuleID = '/home/nacho/Documentos/LLVM/_build/course2/ex/test/Output/crc32.c.tmp.enum.ll'
source_filename = "/home/nacho/Documentos/LLVM/course2/ex/test/crc32.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str.1 = private unnamed_addr constant [11 x i8] c"0x%04x-%s\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 %argc, i8** nocapture readonly %argv) local_unnamed_addr #0 {
entry:
  %arrayidx1 = getelementptr inbounds i8*, i8** %argv, i64 1
  %0 = load i8*, i8** %arrayidx1, align 8, !tbaa !2
  %1 = load i8, i8* %0, align 1, !tbaa !6, !instr.id !7
  br label %while.body.i

while.body.i:                                     ; preds = %entry, %while.body.i
  %indvars.iv.i = phi i64 [ %Result906, %while.body.i ], [ 0, %entry ]
  %2 = phi i8 [ %4, %while.body.i ], [ %1, %entry ]
  %crc.024.i = phi i32 [ %xor8.7.i, %while.body.i ], [ -1, %entry ]
  %conv.i = zext i8 %2 to i32, !instr.id !8
  %xor.i = xor i32 %crc.024.i, %conv.i, !instr.id !9
  %and.i = and i32 %xor.i, 1, !instr.id !10
  %sub.i = sub nsw i32 0, %and.i, !instr.id !11
  %shr.i = lshr i32 %xor.i, 1, !instr.id !12
  %and7.i = and i32 %sub.i, -306674912, !instr.id !13
  %xor8.i = xor i32 %and7.i, %shr.i, !instr.id !14
  %and.1.i = and i32 %shr.i, 1, !instr.id !15
  %sub.1.i = sub nsw i32 0, %and.1.i, !instr.id !16
  %shr.1.i = lshr i32 %xor8.i, 1, !instr.id !17
  %and7.1.i = and i32 %sub.1.i, -306674912, !instr.id !18
  %xor8.1.i = xor i32 %shr.1.i, %and7.1.i, !instr.id !19
  %and.2.i = and i32 %shr.1.i, 1, !instr.id !20
  %sub.2.i = sub nsw i32 0, %and.2.i, !instr.id !21
  %shr.2.i = lshr i32 %xor8.1.i, 1, !instr.id !22
  %and7.2.i = and i32 %sub.2.i, -306674912, !instr.id !23
  %xor8.2.i = xor i32 %and7.2.i, %shr.2.i, !instr.id !24
  %and.3.i = and i32 %shr.2.i, 1, !instr.id !25
  %sub.3.i = sub nsw i32 0, %and.3.i, !instr.id !26
  %shr.3.i = lshr i32 %xor8.2.i, 1, !instr.id !27
  %and7.3.i = and i32 %sub.3.i, -306674912, !instr.id !28
  %xor8.3.i = xor i32 %and7.3.i, %shr.3.i, !instr.id !29
  %and.4.i = and i32 %shr.3.i, 1, !instr.id !30
  %3 = sub i32 0, %xor8.2.i, !instr.id !31
  %XAndY45 = and i32 %xor8.2.i, %3, !instr.id !32
  %shift146 = shl i32 %XAndY45, 1, !instr.id !33
  %XXorY47 = xor i32 %xor8.2.i, %3, !instr.id !34
  %XAndY512 = and i32 %shift146, %XXorY47, !instr.id !35
  %shift1513 = shl i32 %XAndY512, 1
  %XXorY514 = xor i32 %shift146, %XXorY47, !instr.id !36
  %Result515 = sub i32 %XXorY514, %and.4.i
  %sub.4.i = add i32 %Result515, %shift1513, !instr.id !37
  %shr.4.i = lshr i32 %xor8.3.i, 1, !instr.id !38
  %and7.4.i = and i32 %sub.4.i, -306674912, !instr.id !39
  %xor8.4.i = xor i32 %and7.4.i, %shr.4.i, !instr.id !40
  %and.5.i = and i32 %shr.4.i, 1, !instr.id !41
  %sub.5.i = sub nsw i32 0, %and.5.i, !instr.id !42
  %shr.5.i = lshr i32 %xor8.4.i, 1, !instr.id !43
  %and7.5.i = and i32 %sub.5.i, -306674912, !instr.id !44
  %xor8.5.i = xor i32 %shr.5.i, %and7.5.i, !instr.id !45
  %and.6.i = and i32 %shr.5.i, 1, !instr.id !46
  %sub.6.i = sub nsw i32 0, %and.6.i, !instr.id !47
  %shr.6.i = lshr i32 %xor8.5.i, 1, !instr.id !48
  %and7.6.i = and i32 %sub.6.i, -306674912, !instr.id !49
  %xor8.6.i = xor i32 %shr.6.i, %and7.6.i, !instr.id !50
  %and.7.i = and i32 %shr.6.i, 1, !instr.id !51
  %sub.7.i = sub nsw i32 0, %and.7.i
  %shr.7.i = lshr i32 %xor8.6.i, 1, !instr.id !52
  %and7.7.i = and i32 %sub.7.i, -306674912, !instr.id !53
  %xor8.7.i = xor i32 %shr.7.i, %and7.7.i, !instr.id !54
  %XAndY = shl i64 %indvars.iv.i, 1
  %shift1 = and i64 %XAndY, 2
  %XXorY = xor i64 %indvars.iv.i, 1, !instr.id !55
  %XAndY903 = and i64 %shift1, %indvars.iv.i
  %shift1904 = shl nuw nsw i64 %XAndY903, 1, !instr.id !56
  %XXorY905 = xor i64 %XXorY, %shift1, !instr.id !57
  %Result906 = add i64 %shift1904, %XXorY905, !instr.id !58
  %arrayidx.i = getelementptr inbounds i8, i8* %0, i64 %Result906
  %4 = load i8, i8* %arrayidx.i, align 1, !tbaa !6, !instr.id !59
  %cmp.i = icmp eq i8 %4, 0, !instr.id !60
  br i1 %cmp.i, label %crc32.exit, label %while.body.i

crc32.exit:                                       ; preds = %while.body.i
  %phitmp.i = xor i32 %xor8.7.i, -1, !instr.id !61
  %call3 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i64 0, i64 0), i32 %phitmp.i, i8* nonnull %0), !instr.id !62
  ret i32 0
}

; Function Attrs: nounwind
declare dso_local i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #1

attributes #0 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 8.0.1 "}
!2 = !{!3, !3, i64 0}
!3 = !{!"any pointer", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
!6 = !{!4, !4, i64 0}
!7 = !{i64 2}
!8 = !{i64 4}
!9 = !{i64 5}
!10 = !{i64 21}
!11 = !{i64 30}
!12 = !{i64 45}
!13 = !{i64 59}
!14 = !{i64 60}
!15 = !{i64 61}
!16 = !{i64 62}
!17 = !{i64 63}
!18 = !{i64 64}
!19 = !{i64 65}
!20 = !{i64 81}
!21 = !{i64 89}
!22 = !{i64 104}
!23 = !{i64 119}
!24 = !{i64 120}
!25 = !{i64 127}
!26 = !{i64 128}
!27 = !{i64 137}
!28 = !{i64 152}
!29 = !{i64 153}
!30 = !{i64 154}
!31 = !{i64 155}
!32 = !{i64 156}
!33 = !{i64 157}
!34 = !{i64 158}
!35 = !{i64 159}
!36 = !{i64 161}
!37 = !{i64 163}
!38 = !{i64 178}
!39 = !{i64 193}
!40 = !{i64 194}
!41 = !{i64 195}
!42 = !{i64 204}
!43 = !{i64 205}
!44 = !{i64 207}
!45 = !{i64 208}
!46 = !{i64 224}
!47 = !{i64 225}
!48 = !{i64 226}
!49 = !{i64 240}
!50 = !{i64 241}
!51 = !{i64 256}
!52 = !{i64 281}
!53 = !{i64 296}
!54 = !{i64 297}
!55 = !{i64 322}
!56 = !{i64 324}
!57 = !{i64 325}
!58 = !{i64 326}
!59 = !{i64 327}
!60 = !{i64 328}
!61 = !{i64 343}
!62 = !{i64 344}
