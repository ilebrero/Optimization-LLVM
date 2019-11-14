; ModuleID = '/home/nacho/Documentos/LLVM/_build/course3/ex/test/Output/detect_inject_profile.c.tmp.ll'
source_filename = "/home/nacho/Documentos/LLVM/course3/ex/test/detect_inject_profile.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [10 x i8] c"on main!\0A\00", align 1
@.str.1 = private unnamed_addr constant [13 x i8] c"/proc/%d/exe\00", align 1
@.str.1.2 = private unnamed_addr constant [4 x i8] c"gdb\00", align 1
@.str.2 = private unnamed_addr constant [5 x i8] c"lldb\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @unused_function() #0 !prof !29 {
entry:
  %0 = call i32 @detect_readlink()
  %CualquierCosa = add i32 0, %0
  ret i32 %CualquierCosa
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !prof !30 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str, i32 0, i32 0))
  %0 = call i32 @detect_readlink()
  %CualquierCosa = add i32 0, %0
  ret i32 %CualquierCosa
}

declare dso_local i32 @printf(i8*, ...) #1

; Function Attrs: nounwind uwtable
define private i32 @detect_readlink() local_unnamed_addr #2 {
entry:
  %dbg_path = alloca [128 x i8], align 16
  %path = alloca [32 x i8], align 16
  %call = tail call i32 @getppid() #6
  %0 = getelementptr inbounds [128 x i8], [128 x i8]* %dbg_path, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 128, i8* nonnull %0) #6
  %1 = getelementptr inbounds [32 x i8], [32 x i8]* %path, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 32, i8* nonnull %1) #6
  %call1 = call i32 (i8*, i8*, ...) @sprintf(i8* nonnull %1, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.1, i64 0, i64 0), i32 %call) #6
  %call4 = call i64 @readlink(i8* nonnull %1, i8* nonnull %0, i64 128) #6
  %call6 = call i8* @strstr(i8* nonnull %0, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1.2, i64 0, i64 0)) #7
  %tobool = icmp eq i8* %call6, null
  br i1 %tobool, label %lor.lhs.false, label %cleanup

lor.lhs.false:                                    ; preds = %entry
  %call8 = call i8* @strstr(i8* nonnull %0, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.2, i64 0, i64 0)) #7
  %tobool9 = icmp ne i8* %call8, null
  %spec.select = zext i1 %tobool9 to i32
  br label %cleanup

cleanup:                                          ; preds = %lor.lhs.false, %entry
  %retval.0 = phi i32 [ 1, %entry ], [ %spec.select, %lor.lhs.false ]
  call void @llvm.lifetime.end.p0i8(i64 32, i8* nonnull %1) #6
  call void @llvm.lifetime.end.p0i8(i64 128, i8* nonnull %0) #6
  ret i32 %retval.0
}

; Function Attrs: nounwind
declare dso_local i32 @getppid() local_unnamed_addr #3

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #4

; Function Attrs: nounwind
declare dso_local i32 @sprintf(i8* nocapture, i8* nocapture readonly, ...) local_unnamed_addr #3

; Function Attrs: nounwind
declare dso_local i64 @readlink(i8* nocapture readonly, i8* nocapture, i64) local_unnamed_addr #3

; Function Attrs: nounwind readonly
declare dso_local i8* @strstr(i8*, i8* nocapture) local_unnamed_addr #5

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #4

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { argmemonly nounwind }
attributes #5 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind }
attributes #7 = { nounwind readonly }

!llvm.module.flags = !{!0, !27}
!llvm.ident = !{!28, !28}

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
