; ModuleID = '/home/nacho/Documentos/LLVM/course3/ex/test/detect_inject_profile.c'
source_filename = "/home/nacho/Documentos/LLVM/course3/ex/test/detect_inject_profile.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [10 x i8] c"on main!\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @unused_function() #0 !prof !29 {
entry:
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !prof !30 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str, i32 0, i32 0))
  ret i32 0
}

declare dso_local i32 @printf(i8*, ...) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0, !27}
!llvm.ident = !{!28}

!0 = !{i32 1, !"ProfileSummary", !1}
!1 = !{!2, !3, !4, !5, !6, !7, !8, !9}
!2 = !{!"ProfileFormat", !"InstrProf"}
!3 = !{!"TotalCount", i64 3}
!4 = !{!"MaxCount", i64 3}
!5 = !{!"MaxInternalCount", i64 0}
!6 = !{!"MaxFunctionCount", i64 3}
!7 = !{!"NumCounts", i64 2}
!8 = !{!"NumFunctions", i64 2}
!9 = !{!"DetailedSummary", !10}
!10 = !{!11, !12, !13, !14, !15, !16, !17, !18, !19, !20, !21, !22, !23, !24, !25, !26}
!11 = !{i32 10000, i64 0, i32 0}
!12 = !{i32 100000, i64 0, i32 0}
!13 = !{i32 200000, i64 0, i32 0}
!14 = !{i32 300000, i64 0, i32 0}
!15 = !{i32 400000, i64 3, i32 1}
!16 = !{i32 500000, i64 3, i32 1}
!17 = !{i32 600000, i64 3, i32 1}
!18 = !{i32 700000, i64 3, i32 1}
!19 = !{i32 800000, i64 3, i32 1}
!20 = !{i32 900000, i64 3, i32 1}
!21 = !{i32 950000, i64 3, i32 1}
!22 = !{i32 990000, i64 3, i32 1}
!23 = !{i32 999000, i64 3, i32 1}
!24 = !{i32 999900, i64 3, i32 1}
!25 = !{i32 999990, i64 3, i32 1}
!26 = !{i32 999999, i64 3, i32 1}
!27 = !{i32 1, !"wchar_size", i32 4}
!28 = !{!"clang version 8.0.1 "}
!29 = !{!"function_entry_count", i64 0}
!30 = !{!"function_entry_count", i64 3}
