; ModuleID = '/home/nacho/Documentos/LLVM/_build/course3/ex/test/Output/just_inject.c.tmp.ll'
source_filename = "/home/nacho/Documentos/LLVM/course3/ex/test/just_inject.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [13 x i8] c"/proc/%d/exe\00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c"gdb\00", align 1
@.str.2 = private unnamed_addr constant [5 x i8] c"lldb\00", align 1
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 500, void ()* @__startup_check, i8* null }]

; Function Attrs: nounwind uwtable
define private i32 @detect_readlink() local_unnamed_addr #0 {
entry:
  %dbg_path = alloca [128 x i8], align 16
  %path = alloca [32 x i8], align 16
  %call = tail call i32 @getppid() #4
  %0 = getelementptr inbounds [128 x i8], [128 x i8]* %dbg_path, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 128, i8* nonnull %0) #4
  %1 = getelementptr inbounds [32 x i8], [32 x i8]* %path, i64 0, i64 0
  call void @llvm.lifetime.start.p0i8(i64 32, i8* nonnull %1) #4
  %call1 = call i32 (i8*, i8*, ...) @sprintf(i8* nonnull %1, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str, i64 0, i64 0), i32 %call) #4
  %call4 = call i64 @readlink(i8* nonnull %1, i8* nonnull %0, i64 128) #4
  %call6 = call i8* @strstr(i8* nonnull %0, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i64 0, i64 0)) #5
  %tobool = icmp eq i8* %call6, null
  br i1 %tobool, label %lor.lhs.false, label %cleanup

lor.lhs.false:                                    ; preds = %entry
  %call8 = call i8* @strstr(i8* nonnull %0, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.2, i64 0, i64 0)) #5
  %tobool9 = icmp ne i8* %call8, null
  %spec.select = zext i1 %tobool9 to i32
  br label %cleanup

cleanup:                                          ; preds = %lor.lhs.false, %entry
  %retval.0 = phi i32 [ 1, %entry ], [ %spec.select, %lor.lhs.false ]
  call void @llvm.lifetime.end.p0i8(i64 32, i8* nonnull %1) #4
  call void @llvm.lifetime.end.p0i8(i64 128, i8* nonnull %0) #4
  ret i32 %retval.0
}

; Function Attrs: nounwind
declare dso_local i32 @getppid() local_unnamed_addr #1

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.start.p0i8(i64, i8* nocapture) #2

; Function Attrs: nounwind
declare dso_local i32 @sprintf(i8* nocapture, i8* nocapture readonly, ...) local_unnamed_addr #1

; Function Attrs: nounwind
declare dso_local i64 @readlink(i8* nocapture readonly, i8* nocapture, i64) local_unnamed_addr #1

; Function Attrs: nounwind readonly
declare dso_local i8* @strstr(i8*, i8* nocapture) local_unnamed_addr #3

; Function Attrs: argmemonly nounwind
declare void @llvm.lifetime.end.p0i8(i64, i8* nocapture) #2

; Function Attrs: nounwind uwtable
define private i32 @detect_ptrace() local_unnamed_addr #0 {
entry:
  %call = tail call i64 (i32, ...) @ptrace(i32 0, i32 0, i32 0, i32 0) #4
  %cmp = icmp eq i64 %call, -1
  %. = zext i1 %cmp to i32
  ret i32 %.
}

; Function Attrs: nounwind
declare dso_local i64 @ptrace(i32, ...) local_unnamed_addr #1

define void @__startup_check() {
FailIfDebug:
  %0 = call i32 @detect_ptrace()
  %comparassion = icmp eq i32 %0, 0
  br i1 %comparassion, label %endBlock, label %crashBlock

endBlock:                                         ; preds = %FailIfDebug
  ret void

crashBlock:                                       ; preds = %FailIfDebug
  store i64 0, i64* null
  ret void
}

attributes #0 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { argmemonly nounwind }
attributes #3 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { nounwind readonly }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1, !1, !1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 8.0.1 "}
