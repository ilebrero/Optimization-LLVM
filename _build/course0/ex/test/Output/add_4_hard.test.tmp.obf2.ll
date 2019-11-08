; ModuleID = '/home/nacho/Documentos/LLVM/_build/course0/ex/test/Output/add_4_hard.test.tmp.ll'
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
  %add = add nuw nsw i32 %i.018, 1234
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
  %inc = add nuw nsw i32 %j.017, 1
  %cmp2 = icmp eq i32 %inc, 256
  br i1 %cmp2, label %for.cond.cleanup3, label %for.body4
}

; Function Attrs: nounwind
declare dso_local i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #1

; Function Attrs: nounwind readnone speculatable
declare double @llvm.fabs.f64(double) #2

define private double @internal.leibiniz(i8) {
entry:
  %n.init = zext i8 %0 to i64
  %1 = shl i64 %n.init, 1
  %i.init = sub i64 %1, 1
  %2 = urem i64 %n.init, 2
  %sign.cond = icmp eq i64 %2, 0
  %sign.init = select i1 %sign.cond, double -1.000000e+00, double 1.000000e+00
  br label %loop_head

loop_head:                                        ; preds = %loop_body, %entry
  %n = phi i64 [ %n.init, %entry ], [ %n.update, %loop_body ]
  %sum = phi double [ 0.000000e+00, %entry ], [ %sum.update, %loop_body ]
  %i = phi i64 [ %i.init, %entry ], [ %i.update, %loop_body ]
  %sign = phi double [ %sign.init, %entry ], [ %sign.update, %loop_body ]
  %n.update = sub i64 %n, 1
  %loop_cond = icmp ne i64 %n, 0
  br i1 %loop_cond, label %loop_body, label %exit

loop_body:                                        ; preds = %loop_head
  %3 = uitofp i64 %i to double
  %4 = fdiv double %sign, %3
  %sum.update = fadd double %sum, %4
  %sign.update = fmul double %sign, -1.000000e+00
  %i.update = sub i64 %i, 2
  br label %loop_head

exit:                                             ; preds = %loop_head
  %5 = fmul double 4.000000e+00, %sum
  ret double %5
}

attributes #0 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone speculatable }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 8.0.1 "}
