; ModuleID = '/home/nacho/Documentos/LLVM/_build/course0/ex/test/Output/add_4.c.tmp.ll'
source_filename = "/home/nacho/Documentos/LLVM/course0/ex/test/add_4.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [22 x i8] c"%d + %d + stuff = %d\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #0 {
entry:
  br label %for.cond1.preheader

for.cond1.preheader:                              ; preds = %for.cond.cleanup3, %entry
  %i.018 = phi i32 [ 0, %entry ], [ %inc7, %for.cond.cleanup3 ]
  %0 = sub i32 0, %i.018
  %XAndY9 = and i32 %i.018, 1234
  %shift110 = shl i32 %XAndY9, 1
  %XXorY11 = xor i32 %i.018, 1234
  %Result12 = add i32 %shift110, %XXorY11
  %1 = add i32 %i.018, 1234
  %XAndY13 = and i32 %0, 0
  %shift114 = shl i32 %XAndY13, 1
  %XXorY15 = xor i32 %0, 0
  %Result16 = add i32 %shift114, %XXorY15
  %2 = add i32 %0, 0
  %XAndY17 = and i32 %Result16, %Result12
  %shift118 = shl i32 %XAndY17, 1
  %XXorY19 = xor i32 %Result16, %Result12
  %Result20 = add i32 %shift118, %XXorY19
  %3 = add i32 %Result16, %Result12
  %add = add nuw nsw i32 %i.018, %Result20
  br label %for.body4

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3
  ret i32 0

for.cond.cleanup3:                                ; preds = %for.body4
  %inc7 = add nuw nsw i32 %i.018, 1
  %cmp = icmp eq i32 %inc7, 256
  br i1 %cmp, label %for.cond.cleanup, label %for.cond1.preheader

for.body4:                                        ; preds = %for.body4, %for.cond1.preheader
  %j.017 = phi i32 [ 0, %for.cond1.preheader ], [ %inc, %for.body4 ]
  %add5 = add nuw nsw i32 %add, %j.017
  %call = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str, i64 0, i64 0), i32 %i.018, i32 %j.017, i32 %add5)
  %4 = sub i32 0, %add5
  %XAndY = and i32 %add5, 1
  %shift1 = shl i32 %XAndY, 1
  %XXorY = xor i32 %add5, 1
  %Result = add i32 %shift1, %XXorY
  %5 = add i32 %add5, 1
  %XAndY1 = and i32 %4, 0
  %shift12 = shl i32 %XAndY1, 1
  %XXorY3 = xor i32 %4, 0
  %Result4 = add i32 %shift12, %XXorY3
  %6 = add i32 %4, 0
  %XAndY5 = and i32 %Result4, %Result
  %shift16 = shl i32 %XAndY5, 1
  %XXorY7 = xor i32 %Result4, %Result
  %Result8 = add i32 %shift16, %XXorY7
  %7 = add i32 %Result4, %Result
  %inc = add nuw nsw i32 %j.017, %Result8
  %cmp2 = icmp eq i32 %inc, 256
  br i1 %cmp2, label %for.cond.cleanup3, label %for.body4
}

; Function Attrs: nounwind
declare dso_local i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #1

attributes #0 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 8.0.1 "}
