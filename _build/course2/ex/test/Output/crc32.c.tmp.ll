; ModuleID = '/home/nacho/Documentos/LLVM/course2/ex/test/crc32.c'
source_filename = "/home/nacho/Documentos/LLVM/course2/ex/test/crc32.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }

@stderr = external dso_local local_unnamed_addr global %struct._IO_FILE*, align 8
@.str = private unnamed_addr constant [19 x i8] c"Usage: %s message\0A\00", align 1
@.str.1 = private unnamed_addr constant [11 x i8] c"0x%04x-%s\0A\00", align 1

; Function Attrs: nounwind uwtable
define dso_local i32 @main(i32 %argc, i8** nocapture readonly %argv) local_unnamed_addr #0 {
entry:
  %cmp = icmp slt i32 %argc, 2
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %0 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8, !tbaa !2
  %1 = load i8*, i8** %argv, align 8, !tbaa !2
  %call = tail call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %0, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str, i64 0, i64 0), i8* %1) #2
  br label %return

if.end:                                           ; preds = %entry
  %arrayidx1 = getelementptr inbounds i8*, i8** %argv, i64 1
  %2 = load i8*, i8** %arrayidx1, align 8, !tbaa !2
  %3 = load i8, i8* %2, align 1, !tbaa !6
  %cmp23.i = icmp eq i8 %3, 0
  br i1 %cmp23.i, label %crc32.exit, label %while.body.i

while.body.i:                                     ; preds = %if.end, %while.body.i
  %indvars.iv.i = phi i64 [ %indvars.iv.next.i, %while.body.i ], [ 0, %if.end ]
  %4 = phi i8 [ %5, %while.body.i ], [ %3, %if.end ]
  %crc.024.i = phi i32 [ %xor8.7.i, %while.body.i ], [ -1, %if.end ]
  %conv.i = zext i8 %4 to i32
  %xor.i = xor i32 %crc.024.i, %conv.i
  %and.i = and i32 %xor.i, 1
  %sub.i = sub nsw i32 0, %and.i
  %shr.i = lshr i32 %xor.i, 1
  %and7.i = and i32 %sub.i, -306674912
  %xor8.i = xor i32 %and7.i, %shr.i
  %and.1.i = and i32 %shr.i, 1
  %sub.1.i = sub nsw i32 0, %and.1.i
  %shr.1.i = lshr i32 %xor8.i, 1
  %and7.1.i = and i32 %sub.1.i, -306674912
  %xor8.1.i = xor i32 %shr.1.i, %and7.1.i
  %and.2.i = and i32 %shr.1.i, 1
  %sub.2.i = sub nsw i32 0, %and.2.i
  %shr.2.i = lshr i32 %xor8.1.i, 1
  %and7.2.i = and i32 %sub.2.i, -306674912
  %xor8.2.i = xor i32 %and7.2.i, %shr.2.i
  %and.3.i = and i32 %shr.2.i, 1
  %sub.3.i = sub nsw i32 0, %and.3.i
  %shr.3.i = lshr i32 %xor8.2.i, 1
  %and7.3.i = and i32 %sub.3.i, -306674912
  %xor8.3.i = xor i32 %and7.3.i, %shr.3.i
  %and.4.i = and i32 %shr.3.i, 1
  %sub.4.i = sub nsw i32 0, %and.4.i
  %shr.4.i = lshr i32 %xor8.3.i, 1
  %and7.4.i = and i32 %sub.4.i, -306674912
  %xor8.4.i = xor i32 %and7.4.i, %shr.4.i
  %and.5.i = and i32 %shr.4.i, 1
  %sub.5.i = sub nsw i32 0, %and.5.i
  %shr.5.i = lshr i32 %xor8.4.i, 1
  %and7.5.i = and i32 %sub.5.i, -306674912
  %xor8.5.i = xor i32 %and7.5.i, %shr.5.i
  %and.6.i = and i32 %shr.5.i, 1
  %sub.6.i = sub nsw i32 0, %and.6.i
  %shr.6.i = lshr i32 %xor8.5.i, 1
  %and7.6.i = and i32 %sub.6.i, -306674912
  %xor8.6.i = xor i32 %and7.6.i, %shr.6.i
  %and.7.i = and i32 %shr.6.i, 1
  %sub.7.i = sub nsw i32 0, %and.7.i
  %shr.7.i = lshr i32 %xor8.6.i, 1
  %and7.7.i = and i32 %sub.7.i, -306674912
  %xor8.7.i = xor i32 %and7.7.i, %shr.7.i
  %indvars.iv.next.i = add nuw i64 %indvars.iv.i, 1
  %arrayidx.i = getelementptr inbounds i8, i8* %2, i64 %indvars.iv.next.i
  %5 = load i8, i8* %arrayidx.i, align 1, !tbaa !6
  %cmp.i = icmp eq i8 %5, 0
  br i1 %cmp.i, label %while.end.loopexit.i, label %while.body.i

while.end.loopexit.i:                             ; preds = %while.body.i
  %phitmp.i = xor i32 %xor8.7.i, -1
  br label %crc32.exit

crc32.exit:                                       ; preds = %if.end, %while.end.loopexit.i
  %crc.0.lcssa.i = phi i32 [ 0, %if.end ], [ %phitmp.i, %while.end.loopexit.i ]
  %call3 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i64 0, i64 0), i32 %crc.0.lcssa.i, i8* %2)
  br label %return

return:                                           ; preds = %crc32.exit, %if.then
  %retval.0 = phi i32 [ 1, %if.then ], [ 0, %crc32.exit ]
  ret i32 %retval.0
}

; Function Attrs: nounwind
declare dso_local i32 @fprintf(%struct._IO_FILE* nocapture, i8* nocapture readonly, ...) local_unnamed_addr #1

; Function Attrs: nounwind
declare dso_local i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #1

attributes #0 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { cold }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 8.0.1 "}
!2 = !{!3, !3, i64 0}
!3 = !{!"any pointer", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
!6 = !{!4, !4, i64 0}
