; ModuleID = '/home/nacho/Documentos/LLVM/_build/course0/ex/test/Output/add.c.tmp.ll'
source_filename = "/home/nacho/Documentos/LLVM/course0/ex/test/add.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [14 x i8] c"%d + %d = %d\0A\00", align 1

; Function Attrs: norecurse nounwind readnone uwtable
define dso_local i32 @add(i32 %a, i32 %b) local_unnamed_addr #0 {
entry:
  %XAndY = and i32 %b, %a
  %shift1 = shl i32 %XAndY, 1
  %XXorY = xor i32 %b, %a
  %Result = add i32 %shift1, %XXorY
  ret i32 %Result
}

; Function Attrs: nounwind uwtable
define dso_local i32 @main() local_unnamed_addr #1 {
entry:
  br label %for.cond1.preheader

for.cond1.preheader:                              ; preds = %for.cond.cleanup3, %entry
  %i.018 = phi i32 [ 0, %entry ], [ %Result8, %for.cond.cleanup3 ]
  br label %for.body4

for.cond.cleanup:                                 ; preds = %for.cond.cleanup3
  ret i32 0

for.cond.cleanup3:                                ; preds = %for.body4
  %XAndY5 = and i32 %i.018, 1
  %shift16 = shl i32 %XAndY5, 1
  %XXorY7 = xor i32 %i.018, 1
  %Result8 = add i32 %shift16, %XXorY7
  %cmp = icmp eq i32 %Result8, 256
  br i1 %cmp, label %for.cond.cleanup, label %for.cond1.preheader

for.body4:                                        ; preds = %for.body4, %for.cond1.preheader
  %j.017 = phi i32 [ 0, %for.cond1.preheader ], [ %Result, %for.body4 ]
  %XAndY1 = and i32 %j.017, %i.018
  %shift12 = shl i32 %XAndY1, 1
  %XXorY3 = xor i32 %j.017, %i.018
  %Result4 = add i32 %shift12, %XXorY3
  %call5 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str, i64 0, i64 0), i32 %i.018, i32 %j.017, i32 %Result4)
  %XAndY = and i32 %j.017, 1
  %shift1 = shl i32 %XAndY, 1
  %XXorY = xor i32 %j.017, 1
  %Result = add i32 %shift1, %XXorY
  %cmp2 = icmp eq i32 %Result, 256
  br i1 %cmp2, label %for.cond.cleanup3, label %for.body4
}

; Function Attrs: nounwind
declare dso_local i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #2

attributes #0 = { norecurse nounwind readnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 8.0.1 "}
