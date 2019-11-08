; ModuleID = '/home/nacho/Documentos/LLVM/_build/course2/ex/test/Output/crc32.c.tmp.enum.ll'
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
  %cmp = icmp slt i32 %argc, 2, !instr.id !2
  %0 = zext i1 %cmp to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 0, i64 %0) #2
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8, !tbaa !3
  %2 = load i8*, i8** %argv, align 8, !tbaa !3
  %call = tail call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %1, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str, i64 0, i64 0), i8* %2) #3, !instr.id !7
  %3 = zext i32 %call to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 1, i64 %3) #2
  br label %return

if.end:                                           ; preds = %entry
  %arrayidx1 = getelementptr inbounds i8*, i8** %argv, i64 1
  %4 = load i8*, i8** %arrayidx1, align 8, !tbaa !3
  %5 = load i8, i8* %4, align 1, !tbaa !8, !instr.id !9
  %6 = zext i8 %5 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 2, i64 %6) #2
  %cmp23.i = icmp eq i8 %5, 0, !instr.id !10
  %7 = zext i1 %cmp23.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 3, i64 %7) #2
  br i1 %cmp23.i, label %crc32.exit, label %while.body.i

while.body.i:                                     ; preds = %if.end, %while.body.i
  %indvars.iv.i = phi i64 [ %Result906, %while.body.i ], [ 0, %if.end ]
  %8 = phi i8 [ %316, %while.body.i ], [ %5, %if.end ]
  %crc.024.i = phi i32 [ %xor8.7.i, %while.body.i ], [ -1, %if.end ]
  %conv.i = zext i8 %8 to i32, !instr.id !11
  %9 = zext i8 %8 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 4, i64 %9) #2
  %xor.i = xor i32 %crc.024.i, %conv.i, !instr.id !12
  %10 = zext i32 %xor.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 5, i64 %10) #2
  %11 = sub nsw i32 0, %conv.i, !instr.id !13
  %12 = zext i32 %11 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 6, i64 %12) #2
  %XAndY396 = shl nuw nsw i32 %conv.i, 1, !instr.id !14
  %13 = zext i32 %XAndY396 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 7, i64 %13) #2
  %shift1397 = and i32 %XAndY396, 2, !instr.id !15
  %14 = zext i32 %shift1397 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 8, i64 %14) #2
  %XXorY398 = xor i32 %conv.i, 1, !instr.id !16
  %15 = zext i32 %XXorY398 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 9, i64 %15) #2
  %XAndY1126 = and i32 %shift1397, %conv.i, !instr.id !17
  %16 = zext i32 %XAndY1126 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 10, i64 %16) #2
  %shift11127 = shl nuw nsw i32 %XAndY1126, 1, !instr.id !18
  %17 = zext i32 %shift11127 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 11, i64 %17) #2
  %XXorY1128 = xor i32 %shift1397, %XXorY398, !instr.id !19
  %18 = zext i32 %XXorY1128 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 12, i64 %18) #2
  %Result1129 = add nuw nsw i32 %shift11127, %XXorY1128, !instr.id !20
  %19 = zext i32 %Result1129 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 13, i64 %19) #2
  %XAndY404 = and i32 %Result1129, %11, !instr.id !21
  %20 = zext i32 %XAndY404 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 14, i64 %20) #2
  %shift1405 = shl nuw nsw i32 %XAndY404, 1, !instr.id !22
  %21 = zext i32 %shift1405 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 15, i64 %21) #2
  %XXorY406 = xor i32 %Result1129, %11, !instr.id !23
  %22 = zext i32 %XXorY406 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 16, i64 %22) #2
  %XAndY687 = and i32 %shift1405, %XXorY406, !instr.id !24
  %23 = zext i32 %XAndY687 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 17, i64 %23) #2
  %shift1688 = shl i32 %XAndY687, 1
  %XXorY689 = xor i32 %shift1405, %XXorY406, !instr.id !25
  %24 = zext i32 %XXorY689 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 19, i64 %24) #2
  %Result690 = add i32 %shift1688, %XXorY689, !instr.id !26
  %25 = zext i32 %Result690 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 20, i64 %25) #2
  %and.i = and i32 %Result690, %xor.i, !instr.id !27
  %26 = zext i32 %and.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 21, i64 %26) #2
  %27 = sub i32 0, %xor.i, !instr.id !28
  %28 = zext i32 %27 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 22, i64 %28) #2
  %XAndY33 = and i32 %xor.i, %27, !instr.id !29
  %29 = zext i32 %XAndY33 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 23, i64 %29) #2
  %shift134 = shl i32 %XAndY33, 1, !instr.id !30
  %30 = zext i32 %shift134 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 24, i64 %30) #2
  %XXorY35 = xor i32 %xor.i, %27, !instr.id !31
  %31 = zext i32 %XXorY35 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 25, i64 %31) #2
  %XAndY1294 = and i32 %shift134, %XXorY35, !instr.id !32
  %32 = zext i32 %XAndY1294 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 26, i64 %32) #2
  %shift11295 = shl i32 %XAndY1294, 1, !instr.id !33
  %33 = zext i32 %shift11295 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 27, i64 %33) #2
  %XXorY1296 = xor i32 %shift134, %XXorY35, !instr.id !34
  %34 = zext i32 %XXorY1296 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 28, i64 %34) #2
  %Result1297 = add i32 %shift11295, %XXorY1296, !instr.id !35
  %35 = zext i32 %Result1297 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 29, i64 %35) #2
  %sub.i = sub nsw i32 %Result1297, %and.i, !instr.id !36
  %36 = zext i32 %sub.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 30, i64 %36) #2
  %XAndY276 = shl i32 %xor.i, 1, !instr.id !37
  %37 = zext i32 %XAndY276 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 31, i64 %37) #2
  %shift1277 = and i32 %XAndY276, 2, !instr.id !38
  %38 = zext i32 %shift1277 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 32, i64 %38) #2
  %XXorY278 = xor i32 %xor.i, 1, !instr.id !39
  %39 = zext i32 %XXorY278 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 33, i64 %39) #2
  %XAndY863 = and i32 %shift1277, %xor.i, !instr.id !40
  %40 = zext i32 %XAndY863 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 34, i64 %40) #2
  %shift1864 = shl nuw nsw i32 %XAndY863, 1, !instr.id !41
  %41 = zext i32 %shift1864 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 35, i64 %41) #2
  %XXorY865 = xor i32 %shift1277, %XXorY278, !instr.id !42
  %42 = zext i32 %XXorY865 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 36, i64 %42) #2
  %Result866 = add i32 %shift1864, %XXorY865, !instr.id !43
  %43 = zext i32 %Result866 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 37, i64 %43) #2
  %XAndY284 = and i32 %Result866, %27, !instr.id !44
  %44 = zext i32 %XAndY284 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 38, i64 %44) #2
  %shift1285 = shl i32 %XAndY284, 1, !instr.id !45
  %45 = zext i32 %shift1285 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 39, i64 %45) #2
  %XXorY286 = xor i32 %Result866, %27, !instr.id !46
  %46 = zext i32 %XXorY286 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 40, i64 %46) #2
  %XAndY632 = and i32 %shift1285, %XXorY286, !instr.id !47
  %47 = zext i32 %XAndY632 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 41, i64 %47) #2
  %shift1633 = shl i32 %XAndY632, 1
  %XXorY634 = xor i32 %shift1285, %XXorY286, !instr.id !48
  %48 = zext i32 %XXorY634 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 43, i64 %48) #2
  %Result635 = add i32 %shift1633, %XXorY634, !instr.id !49
  %49 = zext i32 %Result635 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 44, i64 %49) #2
  %shr.i = lshr i32 %xor.i, %Result635, !instr.id !50
  %50 = zext i32 %shr.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 45, i64 %50) #2
  %shift1337 = and i32 %XAndY396, 64, !instr.id !51
  %51 = zext i32 %shift1337 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 46, i64 %51) #2
  %XXorY338 = xor i32 %conv.i, -306674912, !instr.id !52
  %52 = zext i32 %XXorY338 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 47, i64 %52) #2
  %XAndY1182 = and i32 %shift1337, %conv.i, !instr.id !53
  %53 = zext i32 %XAndY1182 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 48, i64 %53) #2
  %shift11183 = shl nuw nsw i32 %XAndY1182, 1, !instr.id !54
  %54 = zext i32 %shift11183 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 49, i64 %54) #2
  %XXorY1184 = xor i32 %shift1337, %XXorY338, !instr.id !55
  %55 = zext i32 %XXorY1184 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 50, i64 %55) #2
  %Result1185 = add nsw i32 %shift11183, %XXorY1184, !instr.id !56
  %56 = zext i32 %Result1185 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 51, i64 %56) #2
  %XAndY344 = and i32 %Result1185, %11, !instr.id !57
  %57 = zext i32 %XAndY344 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 52, i64 %57) #2
  %shift1345 = shl nsw i32 %XAndY344, 1, !instr.id !58
  %58 = zext i32 %shift1345 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 53, i64 %58) #2
  %XXorY346 = xor i32 %Result1185, %11, !instr.id !59
  %59 = zext i32 %XXorY346 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 54, i64 %59) #2
  %XAndY592 = and i32 %shift1345, %XXorY346, !instr.id !60
  %60 = zext i32 %XAndY592 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 55, i64 %60) #2
  %shift1593 = shl i32 %XAndY592, 1
  %XXorY594 = xor i32 %shift1345, %XXorY346, !instr.id !61
  %61 = zext i32 %XXorY594 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 57, i64 %61) #2
  %Result595 = add i32 %shift1593, %XXorY594, !instr.id !62
  %62 = zext i32 %Result595 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 58, i64 %62) #2
  %and7.i = and i32 %sub.i, %Result595, !instr.id !63
  %63 = zext i32 %and7.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 59, i64 %63) #2
  %xor8.i = xor i32 %and7.i, %shr.i, !instr.id !64
  %64 = zext i32 %xor8.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 60, i64 %64) #2
  %and.1.i = and i32 %shr.i, 1, !instr.id !65
  %65 = zext i32 %and.1.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 61, i64 %65) #2
  %sub.1.i = sub nsw i32 %Result1297, %and.1.i, !instr.id !66
  %66 = zext i32 %sub.1.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 62, i64 %66) #2
  %shr.1.i = lshr i32 %xor8.i, 1, !instr.id !67
  %67 = zext i32 %shr.1.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 63, i64 %67) #2
  %and7.1.i = and i32 %sub.1.i, -306674912, !instr.id !68
  %68 = zext i32 %and7.1.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 64, i64 %68) #2
  %xor8.1.i = xor i32 %shr.1.i, %and7.1.i, !instr.id !69
  %69 = zext i32 %xor8.1.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 65, i64 %69) #2
  %70 = sub i32 0, %crc.024.i, !instr.id !70
  %71 = zext i32 %70 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 66, i64 %71) #2
  %XAndY181 = shl i32 %crc.024.i, 1, !instr.id !71
  %72 = zext i32 %XAndY181 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 67, i64 %72) #2
  %shift1182 = and i32 %XAndY181, 2, !instr.id !72
  %73 = zext i32 %shift1182 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 68, i64 %73) #2
  %XXorY183 = xor i32 %crc.024.i, 1, !instr.id !73
  %74 = zext i32 %XXorY183 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 69, i64 %74) #2
  %XAndY811 = and i32 %shift1182, %crc.024.i, !instr.id !74
  %75 = zext i32 %XAndY811 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 70, i64 %75) #2
  %shift1812 = shl nuw nsw i32 %XAndY811, 1, !instr.id !75
  %76 = zext i32 %shift1812 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 71, i64 %76) #2
  %XXorY813 = xor i32 %shift1182, %XXorY183, !instr.id !76
  %77 = zext i32 %XXorY813 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 72, i64 %77) #2
  %Result814 = add i32 %shift1812, %XXorY813, !instr.id !77
  %78 = zext i32 %Result814 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 73, i64 %78) #2
  %XAndY189 = and i32 %Result814, %70, !instr.id !78
  %79 = zext i32 %XAndY189 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 74, i64 %79) #2
  %shift1190 = shl i32 %XAndY189, 1, !instr.id !79
  %80 = zext i32 %shift1190 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 75, i64 %80) #2
  %XXorY191 = xor i32 %Result814, %70, !instr.id !80
  %81 = zext i32 %XXorY191 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 76, i64 %81) #2
  %XAndY827 = and i32 %shift1190, %XXorY191, !instr.id !81
  %82 = zext i32 %XAndY827 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 77, i64 %82) #2
  %shift1828 = shl i32 %XAndY827, 1
  %XXorY829 = xor i32 %shift1190, %XXorY191, !instr.id !82
  %83 = zext i32 %XXorY829 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 79, i64 %83) #2
  %Result830 = add i32 %shift1828, %XXorY829, !instr.id !83
  %84 = zext i32 %Result830 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 80, i64 %84) #2
  %and.2.i = and i32 %shr.1.i, %Result830, !instr.id !84
  %85 = zext i32 %and.2.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 81, i64 %85) #2
  %86 = sub i32 0, %shift134, !instr.id !85
  %87 = zext i32 %86 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 82, i64 %87) #2
  %shift158 = shl i32 %XAndY33, 2, !instr.id !86
  %88 = zext i32 %shift158 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 83, i64 %88) #2
  %XXorY59 = xor i32 %shift134, %86, !instr.id !87
  %89 = zext i32 %XXorY59 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 84, i64 %89) #2
  %XAndY1274 = and i32 %XXorY59, %shift158, !instr.id !88
  %90 = zext i32 %XAndY1274 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 85, i64 %90) #2
  %shift11275 = shl i32 %XAndY1274, 1, !instr.id !89
  %91 = zext i32 %shift11275 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 86, i64 %91) #2
  %XXorY1276 = xor i32 %XXorY59, %shift158, !instr.id !90
  %92 = zext i32 %XXorY1276 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 87, i64 %92) #2
  %Result1277 = add i32 %shift11275, %XXorY1276, !instr.id !91
  %93 = zext i32 %Result1277 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 88, i64 %93) #2
  %sub.2.i = sub nsw i32 %Result1277, %and.2.i, !instr.id !92
  %94 = zext i32 %sub.2.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 89, i64 %94) #2
  %95 = sub i32 0, %XXorY183, !instr.id !93
  %96 = zext i32 %95 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 90, i64 %96) #2
  %XAndY408 = shl i32 %XXorY183, 1, !instr.id !94
  %97 = zext i32 %XAndY408 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 91, i64 %97) #2
  %shift1409 = and i32 %XAndY408, 2, !instr.id !95
  %98 = zext i32 %shift1409 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 92, i64 %98) #2
  %XAndY488 = and i32 %shift1409, %crc.024.i, !instr.id !96
  %99 = zext i32 %XAndY488 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 93, i64 %99) #2
  %shift1489 = shl nuw nsw i32 %XAndY488, 1, !instr.id !97
  %100 = zext i32 %shift1489 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 94, i64 %100) #2
  %XXorY490 = xor i32 %shift1409, %crc.024.i, !instr.id !98
  %101 = zext i32 %XXorY490 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 95, i64 %101) #2
  %Result491 = add i32 %shift1489, %XXorY490, !instr.id !99
  %102 = zext i32 %Result491 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 96, i64 %102) #2
  %XAndY416 = and i32 %Result491, %95, !instr.id !100
  %103 = zext i32 %XAndY416 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 97, i64 %103) #2
  %shift1417 = shl i32 %XAndY416, 1, !instr.id !101
  %104 = zext i32 %shift1417 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 98, i64 %104) #2
  %XXorY418 = xor i32 %Result491, %95, !instr.id !102
  %105 = zext i32 %XXorY418 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 99, i64 %105) #2
  %XAndY1162 = and i32 %shift1417, %XXorY418, !instr.id !103
  %106 = zext i32 %XAndY1162 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 100, i64 %106) #2
  %shift11163 = shl i32 %XAndY1162, 1
  %XXorY1164 = xor i32 %shift1417, %XXorY418, !instr.id !104
  %107 = zext i32 %XXorY1164 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 102, i64 %107) #2
  %Result1165 = add i32 %shift11163, %XXorY1164, !instr.id !105
  %108 = zext i32 %Result1165 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 103, i64 %108) #2
  %shr.2.i = lshr i32 %xor8.1.i, %Result1165, !instr.id !106
  %109 = zext i32 %shr.2.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 104, i64 %109) #2
  %XAndY61 = and i32 %86, -306674912, !instr.id !107
  %110 = zext i32 %XAndY61 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 105, i64 %110) #2
  %shift162 = shl i32 %XAndY61, 1, !instr.id !108
  %111 = zext i32 %shift162 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 106, i64 %111) #2
  %XXorY63 = xor i32 %86, -306674912, !instr.id !109
  %112 = zext i32 %XXorY63 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 107, i64 %112) #2
  %XAndY1022 = and i32 %shift162, %XXorY63, !instr.id !110
  %113 = zext i32 %XAndY1022 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 108, i64 %113) #2
  %shift11023 = shl i32 %XAndY1022, 1, !instr.id !111
  %114 = zext i32 %shift11023 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 109, i64 %114) #2
  %XXorY1024 = xor i32 %shift162, %XXorY63, !instr.id !112
  %115 = zext i32 %XXorY1024 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 110, i64 %115) #2
  %Result1025 = add i32 %shift11023, %XXorY1024, !instr.id !113
  %116 = zext i32 %Result1025 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 111, i64 %116) #2
  %XAndY69 = and i32 %Result1025, %shift134, !instr.id !114
  %117 = zext i32 %XAndY69 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 112, i64 %117) #2
  %shift170 = shl i32 %XAndY69, 1, !instr.id !115
  %118 = zext i32 %shift170 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 113, i64 %118) #2
  %XXorY71 = xor i32 %Result1025, %shift134, !instr.id !116
  %119 = zext i32 %XXorY71 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 114, i64 %119) #2
  %XAndY1026 = and i32 %shift170, %XXorY71, !instr.id !117
  %120 = zext i32 %XAndY1026 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 115, i64 %120) #2
  %shift11027 = shl i32 %XAndY1026, 1
  %XXorY1028 = xor i32 %shift170, %XXorY71, !instr.id !118
  %121 = zext i32 %XXorY1028 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 117, i64 %121) #2
  %Result1029 = add i32 %shift11027, %XXorY1028, !instr.id !119
  %122 = zext i32 %Result1029 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 118, i64 %122) #2
  %and7.2.i = and i32 %sub.2.i, %Result1029, !instr.id !120
  %123 = zext i32 %and7.2.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 119, i64 %123) #2
  %xor8.2.i = xor i32 %and7.2.i, %shr.2.i, !instr.id !121
  %124 = zext i32 %xor8.2.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 120, i64 %124) #2
  %XXorY4221298 = or i32 %shift134, 1, !instr.id !122
  %125 = zext i32 %XXorY4221298 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 121, i64 %125) #2
  %XXorY430 = xor i32 %XXorY4221298, %86, !instr.id !123
  %126 = zext i32 %XXorY430 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 122, i64 %126) #2
  %XAndY636 = and i32 %XXorY430, %shift158, !instr.id !124
  %127 = zext i32 %XAndY636 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 123, i64 %127) #2
  %shift1637 = shl i32 %XAndY636, 1, !instr.id !125
  %128 = zext i32 %shift1637 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 124, i64 %128) #2
  %XXorY638 = xor i32 %XXorY430, %shift158, !instr.id !126
  %129 = zext i32 %XXorY638 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 125, i64 %129) #2
  %Result639 = add i32 %shift1637, %XXorY638, !instr.id !127
  %130 = zext i32 %Result639 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 126, i64 %130) #2
  %and.3.i = and i32 %shr.2.i, %Result639, !instr.id !128
  %131 = zext i32 %and.3.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 127, i64 %131) #2
  %sub.3.i = sub nsw i32 %Result1297, %and.3.i, !instr.id !129
  %132 = zext i32 %sub.3.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 128, i64 %132) #2
  %133 = sub i32 0, %shift158, !instr.id !130
  %134 = zext i32 %133 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 129, i64 %134) #2
  %XXorY2541299 = or i32 %shift158, 1, !instr.id !131
  %135 = zext i32 %XXorY2541299 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 130, i64 %135) #2
  %shift1261 = shl i32 %XAndY33, 3, !instr.id !132
  %136 = zext i32 %shift1261 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 131, i64 %136) #2
  %XXorY262 = xor i32 %XXorY2541299, %133, !instr.id !133
  %137 = zext i32 %XXorY262 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 132, i64 %137) #2
  %XAndY942 = and i32 %XXorY262, %shift1261, !instr.id !134
  %138 = zext i32 %XAndY942 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 133, i64 %138) #2
  %shift1943 = shl i32 %XAndY942, 1
  %XXorY944 = xor i32 %XXorY262, %shift1261, !instr.id !135
  %139 = zext i32 %XXorY944 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 135, i64 %139) #2
  %Result945 = add i32 %shift1943, %XXorY944, !instr.id !136
  %140 = zext i32 %Result945 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 136, i64 %140) #2
  %shr.3.i = lshr i32 %xor8.2.i, %Result945, !instr.id !137
  %141 = zext i32 %shr.3.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 137, i64 %141) #2
  %XAndY217 = shl i32 %27, 1, !instr.id !138
  %142 = zext i32 %XAndY217 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 138, i64 %142) #2
  %shift1218 = and i32 %XAndY217, -613349824, !instr.id !139
  %143 = zext i32 %shift1218 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 139, i64 %143) #2
  %XXorY219 = xor i32 %27, -306674912, !instr.id !140
  %144 = zext i32 %XXorY219 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 140, i64 %144) #2
  %XAndY1146 = and i32 %shift1218, %XXorY219, !instr.id !141
  %145 = zext i32 %XAndY1146 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 141, i64 %145) #2
  %shift11147 = shl i32 %XAndY1146, 1, !instr.id !142
  %146 = zext i32 %shift11147 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 142, i64 %146) #2
  %XXorY1148 = xor i32 %shift1218, %XXorY219, !instr.id !143
  %147 = zext i32 %XXorY1148 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 143, i64 %147) #2
  %Result1149 = add i32 %shift11147, %XXorY1148, !instr.id !144
  %148 = zext i32 %Result1149 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 144, i64 %148) #2
  %XAndY225 = and i32 %Result1149, %xor.i, !instr.id !145
  %149 = zext i32 %XAndY225 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 145, i64 %149) #2
  %shift1226 = shl i32 %XAndY225, 1, !instr.id !146
  %150 = zext i32 %shift1226 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 146, i64 %150) #2
  %XXorY227 = xor i32 %Result1149, %xor.i, !instr.id !147
  %151 = zext i32 %XXorY227 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 147, i64 %151) #2
  %XAndY572 = and i32 %shift1226, %XXorY227, !instr.id !148
  %152 = zext i32 %XAndY572 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 148, i64 %152) #2
  %shift1573 = shl i32 %XAndY572, 1
  %XXorY574 = xor i32 %shift1226, %XXorY227, !instr.id !149
  %153 = zext i32 %XXorY574 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 150, i64 %153) #2
  %Result575 = add i32 %shift1573, %XXorY574, !instr.id !150
  %154 = zext i32 %Result575 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 151, i64 %154) #2
  %and7.3.i = and i32 %sub.3.i, %Result575, !instr.id !151
  %155 = zext i32 %and7.3.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 152, i64 %155) #2
  %xor8.3.i = xor i32 %and7.3.i, %shr.3.i, !instr.id !152
  %156 = zext i32 %xor8.3.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 153, i64 %156) #2
  %and.4.i = and i32 %shr.3.i, %Result639, !instr.id !153
  %157 = zext i32 %and.4.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 154, i64 %157) #2
  %158 = sub i32 0, %xor8.2.i, !instr.id !154
  %159 = zext i32 %158 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 155, i64 %159) #2
  %XAndY45 = and i32 %xor8.2.i, %158, !instr.id !155
  %160 = zext i32 %XAndY45 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 156, i64 %160) #2
  %shift146 = shl i32 %XAndY45, 1, !instr.id !156
  %161 = zext i32 %shift146 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 157, i64 %161) #2
  %XXorY47 = xor i32 %xor8.2.i, %158, !instr.id !157
  %162 = zext i32 %XXorY47 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 158, i64 %162) #2
  %XAndY512 = and i32 %shift146, %XXorY47, !instr.id !158
  %163 = zext i32 %XAndY512 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 159, i64 %163) #2
  %shift1513 = shl i32 %XAndY512, 1
  %XXorY514 = xor i32 %shift146, %XXorY47, !instr.id !159
  %164 = zext i32 %XXorY514 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 161, i64 %164) #2
  %Result515 = sub i32 %XXorY514, %and.4.i
  %sub.4.i = add i32 %Result515, %shift1513, !instr.id !160
  %165 = zext i32 %sub.4.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 163, i64 %165) #2
  %166 = sub i32 0, %xor8.1.i, !instr.id !161
  %167 = zext i32 %166 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 164, i64 %167) #2
  %shift1134 = and i32 %xor8.i, 2, !instr.id !162
  %168 = zext i32 %shift1134 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 165, i64 %168) #2
  %XAndY1222 = and i32 %shift1134, %shr.1.i, !instr.id !163
  %169 = zext i32 %XAndY1222 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 166, i64 %169) #2
  %shift11223 = shl nuw nsw i32 %XAndY1222, 1, !instr.id !164
  %170 = zext i32 %shift11223 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 167, i64 %170) #2
  %XXorY1351303 = or i32 %shift1134, 1, !instr.id !165
  %171 = zext i32 %XXorY1351303 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 168, i64 %171) #2
  %XXorY1224 = xor i32 %XXorY1351303, %xor8.1.i, !instr.id !166
  %172 = zext i32 %XXorY1224 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 169, i64 %172) #2
  %Result1225 = add i32 %XXorY1224, %shift11223, !instr.id !167
  %173 = zext i32 %Result1225 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 170, i64 %173) #2
  %XAndY141 = and i32 %Result1225, %166, !instr.id !168
  %174 = zext i32 %XAndY141 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 171, i64 %174) #2
  %shift1142 = shl i32 %XAndY141, 1, !instr.id !169
  %175 = zext i32 %shift1142 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 172, i64 %175) #2
  %XXorY143 = xor i32 %Result1225, %166, !instr.id !170
  %176 = zext i32 %XXorY143 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 173, i64 %176) #2
  %XAndY867 = and i32 %shift1142, %XXorY143, !instr.id !171
  %177 = zext i32 %XAndY867 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 174, i64 %177) #2
  %shift1868 = shl i32 %XAndY867, 1
  %XXorY869 = xor i32 %shift1142, %XXorY143, !instr.id !172
  %178 = zext i32 %XXorY869 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 176, i64 %178) #2
  %Result870 = add i32 %shift1868, %XXorY869, !instr.id !173
  %179 = zext i32 %Result870 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 177, i64 %179) #2
  %shr.4.i = lshr i32 %xor8.3.i, %Result870, !instr.id !174
  %180 = zext i32 %shr.4.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 178, i64 %180) #2
  %XAndY193 = shl i32 %166, 1, !instr.id !175
  %181 = zext i32 %XAndY193 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 179, i64 %181) #2
  %shift1194 = and i32 %XAndY193, -613349824, !instr.id !176
  %182 = zext i32 %shift1194 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 180, i64 %182) #2
  %XXorY195 = xor i32 %166, -306674912, !instr.id !177
  %183 = zext i32 %XXorY195 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 181, i64 %183) #2
  %XAndY1210 = and i32 %shift1194, %XXorY195, !instr.id !178
  %184 = zext i32 %XAndY1210 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 182, i64 %184) #2
  %shift11211 = shl i32 %XAndY1210, 1, !instr.id !179
  %185 = zext i32 %shift11211 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 183, i64 %185) #2
  %XXorY1212 = xor i32 %shift1194, %XXorY195, !instr.id !180
  %186 = zext i32 %XXorY1212 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 184, i64 %186) #2
  %Result1213 = add i32 %shift11211, %XXorY1212, !instr.id !181
  %187 = zext i32 %Result1213 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 185, i64 %187) #2
  %XAndY201 = and i32 %Result1213, %xor8.1.i, !instr.id !182
  %188 = zext i32 %XAndY201 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 186, i64 %188) #2
  %shift1202 = shl i32 %XAndY201, 1, !instr.id !183
  %189 = zext i32 %shift1202 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 187, i64 %189) #2
  %XXorY203 = xor i32 %Result1213, %xor8.1.i, !instr.id !184
  %190 = zext i32 %XXorY203 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 188, i64 %190) #2
  %XAndY871 = and i32 %shift1202, %XXorY203, !instr.id !185
  %191 = zext i32 %XAndY871 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 189, i64 %191) #2
  %shift1872 = shl i32 %XAndY871, 1
  %XXorY873 = xor i32 %shift1202, %XXorY203, !instr.id !186
  %192 = zext i32 %XXorY873 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 191, i64 %192) #2
  %Result874 = add i32 %shift1872, %XXorY873, !instr.id !187
  %193 = zext i32 %Result874 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 192, i64 %193) #2
  %and7.4.i = and i32 %Result874, %sub.4.i, !instr.id !188
  %194 = zext i32 %and7.4.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 193, i64 %194) #2
  %xor8.4.i = xor i32 %and7.4.i, %shr.4.i, !instr.id !189
  %195 = zext i32 %xor8.4.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 194, i64 %195) #2
  %and.5.i = and i32 %shr.4.i, 1, !instr.id !190
  %196 = zext i32 %and.5.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 195, i64 %196) #2
  %197 = insertelement <2 x i32> undef, i32 %shr.4.i, i32 0
  %198 = insertelement <2 x i32> %197, i32 %Result1277, i32 1
  %199 = sub <2 x i32> zeroinitializer, %198
  %XAndY240 = shl i32 %shr.4.i, 1, !instr.id !191
  %200 = zext i32 %XAndY240 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 196, i64 %200) #2
  %shift1241 = and i32 %XAndY240, -613349824, !instr.id !192
  %201 = zext i32 %shift1241 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 197, i64 %201) #2
  %XXorY242 = xor i32 %shr.4.i, -306674912, !instr.id !193
  %202 = zext i32 %XXorY242 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 198, i64 %202) #2
  %XAndY1166 = and i32 %shift1241, %XXorY242, !instr.id !194
  %203 = zext i32 %XAndY1166 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 199, i64 %203) #2
  %shift11167 = shl i32 %XAndY1166, 1
  %XXorY1168 = xor i32 %shift1241, %XXorY242, !instr.id !195
  %204 = zext i32 %XXorY1168 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 201, i64 %204) #2
  %Result1169 = add i32 %shift11167, %XXorY1168, !instr.id !196
  %205 = zext i32 %Result1169 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 202, i64 %205) #2
  %206 = insertelement <2 x i32> undef, i32 %Result1169, i32 0
  %207 = insertelement <2 x i32> %206, i32 %Result1277, i32 1
  %208 = and <2 x i32> %207, %199
  %209 = shl <2 x i32> %208, <i32 1, i32 1>
  %210 = xor <2 x i32> %207, %199
  %211 = and <2 x i32> %209, %210
  %212 = shl <2 x i32> %211, <i32 1, i32 1>
  %213 = xor <2 x i32> %209, %210
  %214 = add <2 x i32> %212, %213
  %215 = extractelement <2 x i32> %214, i32 1, !instr.id !197
  %216 = zext i32 %215 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 203, i64 %216) #2
  %sub.5.i = sub i32 %215, %and.5.i, !instr.id !198
  %217 = zext i32 %sub.5.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 204, i64 %217) #2
  %shr.5.i = lshr i32 %xor8.4.i, 1, !instr.id !199
  %218 = zext i32 %shr.5.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 205, i64 %218) #2
  %219 = extractelement <2 x i32> %214, i32 0, !instr.id !200
  %220 = zext i32 %219 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 206, i64 %220) #2
  %and7.5.i = and i32 %sub.5.i, %219, !instr.id !201
  %221 = zext i32 %and7.5.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 207, i64 %221) #2
  %xor8.5.i = xor i32 %and7.5.i, %shr.5.i, !instr.id !202
  %222 = zext i32 %xor8.5.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 208, i64 %222) #2
  %223 = sub i32 0, %and.3.i, !instr.id !203
  %224 = zext i32 %223 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 209, i64 %224) #2
  %XAndY121 = shl i32 %and.3.i, 1, !instr.id !204
  %225 = zext i32 %XAndY121 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 210, i64 %225) #2
  %shift1122 = and i32 %XAndY121, 2, !instr.id !205
  %226 = zext i32 %shift1122 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 211, i64 %226) #2
  %XXorY123 = xor i32 %and.3.i, 1, !instr.id !206
  %227 = zext i32 %XXorY123 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 212, i64 %227) #2
  %XAndY751 = and i32 %shift1122, %and.3.i, !instr.id !207
  %228 = zext i32 %XAndY751 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 213, i64 %228) #2
  %shift1752 = shl nuw nsw i32 %XAndY751, 1, !instr.id !208
  %229 = zext i32 %shift1752 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 214, i64 %229) #2
  %XXorY753 = xor i32 %shift1122, %XXorY123, !instr.id !209
  %230 = zext i32 %XXorY753 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 215, i64 %230) #2
  %Result754 = add i32 %shift1752, %XXorY753, !instr.id !210
  %231 = zext i32 %Result754 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 216, i64 %231) #2
  %XAndY129 = and i32 %Result754, %223, !instr.id !211
  %232 = zext i32 %XAndY129 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 217, i64 %232) #2
  %shift1130 = shl i32 %XAndY129, 1, !instr.id !212
  %233 = zext i32 %shift1130 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 218, i64 %233) #2
  %XXorY131 = xor i32 %Result754, %223, !instr.id !213
  %234 = zext i32 %XXorY131 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 219, i64 %234) #2
  %XAndY966 = and i32 %shift1130, %XXorY131, !instr.id !214
  %235 = zext i32 %XAndY966 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 220, i64 %235) #2
  %shift1967 = shl i32 %XAndY966, 1
  %XXorY968 = xor i32 %shift1130, %XXorY131, !instr.id !215
  %236 = zext i32 %XXorY968 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 222, i64 %236) #2
  %Result969 = add i32 %shift1967, %XXorY968, !instr.id !216
  %237 = zext i32 %Result969 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 223, i64 %237) #2
  %and.6.i = and i32 %shr.5.i, %Result969, !instr.id !217
  %238 = zext i32 %and.6.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 224, i64 %238) #2
  %sub.6.i = sub nsw i32 %Result1297, %and.6.i, !instr.id !218
  %239 = zext i32 %sub.6.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 225, i64 %239) #2
  %shr.6.i = lshr i32 %xor8.5.i, 1, !instr.id !219
  %240 = zext i32 %shr.6.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 226, i64 %240) #2
  %shift12 = and i32 %XAndY121, -613349824, !instr.id !220
  %241 = zext i32 %shift12 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 227, i64 %241) #2
  %XXorY3 = xor i32 %and.3.i, -306674912, !instr.id !221
  %242 = zext i32 %XXorY3 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 228, i64 %242) #2
  %XAndY1170 = and i32 %shift12, %XXorY3, !instr.id !222
  %243 = zext i32 %XAndY1170 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 229, i64 %243) #2
  %shift11171 = shl i32 %XAndY1170, 1, !instr.id !223
  %244 = zext i32 %shift11171 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 230, i64 %244) #2
  %XXorY1172 = xor i32 %shift12, %XXorY3, !instr.id !224
  %245 = zext i32 %XXorY1172 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 231, i64 %245) #2
  %Result1173 = add i32 %shift11171, %XXorY1172, !instr.id !225
  %246 = zext i32 %Result1173 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 232, i64 %246) #2
  %XAndY9 = and i32 %Result1173, %223, !instr.id !226
  %247 = zext i32 %XAndY9 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 233, i64 %247) #2
  %shift110 = shl i32 %XAndY9, 1, !instr.id !227
  %248 = zext i32 %shift110 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 234, i64 %248) #2
  %XXorY11 = xor i32 %Result1173, %223, !instr.id !228
  %249 = zext i32 %XXorY11 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 235, i64 %249) #2
  %XAndY795 = and i32 %shift110, %XXorY11, !instr.id !229
  %250 = zext i32 %XAndY795 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 236, i64 %250) #2
  %shift1796 = shl i32 %XAndY795, 1
  %XXorY797 = xor i32 %shift110, %XXorY11, !instr.id !230
  %251 = zext i32 %XXorY797 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 238, i64 %251) #2
  %Result798 = add i32 %shift1796, %XXorY797, !instr.id !231
  %252 = zext i32 %Result798 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 239, i64 %252) #2
  %and7.6.i = and i32 %sub.6.i, %Result798, !instr.id !232
  %253 = zext i32 %and7.6.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 240, i64 %253) #2
  %xor8.6.i = xor i32 %shr.6.i, %and7.6.i, !instr.id !233
  %254 = zext i32 %xor8.6.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 241, i64 %254) #2
  %XAndY348 = shl i32 %70, 1, !instr.id !234
  %255 = zext i32 %XAndY348 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 242, i64 %255) #2
  %shift1349 = and i32 %XAndY348, 2, !instr.id !235
  %256 = zext i32 %shift1349 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 243, i64 %256) #2
  %XXorY350 = xor i32 %70, 1, !instr.id !236
  %257 = zext i32 %XXorY350 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 244, i64 %257) #2
  %XAndY831 = and i32 %shift1349, %70, !instr.id !237
  %258 = zext i32 %XAndY831 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 245, i64 %258) #2
  %shift1832 = shl nuw nsw i32 %XAndY831, 1, !instr.id !238
  %259 = zext i32 %shift1832 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 246, i64 %259) #2
  %XXorY833 = xor i32 %shift1349, %XXorY350, !instr.id !239
  %260 = zext i32 %XXorY833 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 247, i64 %260) #2
  %Result834 = add i32 %shift1832, %XXorY833, !instr.id !240
  %261 = zext i32 %Result834 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 248, i64 %261) #2
  %XAndY356 = and i32 %Result834, %crc.024.i, !instr.id !241
  %262 = zext i32 %XAndY356 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 249, i64 %262) #2
  %shift1357 = shl i32 %XAndY356, 1, !instr.id !242
  %263 = zext i32 %shift1357 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 250, i64 %263) #2
  %XXorY358 = xor i32 %Result834, %crc.024.i, !instr.id !243
  %264 = zext i32 %XXorY358 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 251, i64 %264) #2
  %XAndY484 = and i32 %shift1357, %XXorY358, !instr.id !244
  %265 = zext i32 %XAndY484 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 252, i64 %265) #2
  %shift1485 = shl i32 %XAndY484, 1
  %XXorY486 = xor i32 %shift1357, %XXorY358, !instr.id !245
  %266 = zext i32 %XXorY486 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 254, i64 %266) #2
  %Result487 = add i32 %shift1485, %XXorY486, !instr.id !246
  %267 = zext i32 %Result487 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 255, i64 %267) #2
  %and.7.i = and i32 %shr.6.i, %Result487, !instr.id !247
  %268 = zext i32 %and.7.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 256, i64 %268) #2
  %269 = sub i32 0, %XAndY61, !instr.id !248
  %270 = zext i32 %269 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 257, i64 %270) #2
  %XAndY308 = and i32 %XAndY61, %269, !instr.id !249
  %271 = zext i32 %XAndY308 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 258, i64 %271) #2
  %shift1309 = shl i32 %XAndY308, 1, !instr.id !250
  %272 = zext i32 %shift1309 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 259, i64 %272) #2
  %XXorY310 = xor i32 %XAndY61, %269, !instr.id !251
  %273 = zext i32 %XXorY310 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 260, i64 %273) #2
  %XAndY1154 = and i32 %shift1309, %XXorY310, !instr.id !252
  %274 = zext i32 %XAndY1154 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 261, i64 %274) #2
  %shift11155 = shl i32 %XAndY1154, 1
  %XXorY1156 = xor i32 %shift1309, %XXorY310, !instr.id !253
  %275 = zext i32 %XXorY1156 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 263, i64 %275) #2
  %Result1157 = add i32 %shift11155, %XXorY1156, !instr.id !254
  %276 = zext i32 %Result1157 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 264, i64 %276) #2
  %sub.7.i = sub i32 %Result1157, %and.7.i
  %277 = sub i32 0, %and7.5.i, !instr.id !255
  %278 = zext i32 %277 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 266, i64 %278) #2
  %XAndY13 = shl i32 %and7.5.i, 1, !instr.id !256
  %279 = zext i32 %XAndY13 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 267, i64 %279) #2
  %shift114 = and i32 %XAndY13, 2, !instr.id !257
  %280 = zext i32 %shift114 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 268, i64 %280) #2
  %XXorY15 = xor i32 %and7.5.i, 1, !instr.id !258
  %281 = zext i32 %XXorY15 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 269, i64 %281) #2
  %XAndY839 = and i32 %shift114, %and7.5.i, !instr.id !259
  %282 = zext i32 %XAndY839 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 270, i64 %282) #2
  %shift1840 = shl nuw nsw i32 %XAndY839, 1, !instr.id !260
  %283 = zext i32 %shift1840 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 271, i64 %283) #2
  %XXorY841 = xor i32 %shift114, %XXorY15, !instr.id !261
  %284 = zext i32 %XXorY841 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 272, i64 %284) #2
  %Result842 = add i32 %shift1840, %XXorY841, !instr.id !262
  %285 = zext i32 %Result842 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 273, i64 %285) #2
  %XAndY21 = and i32 %Result842, %277, !instr.id !263
  %286 = zext i32 %XAndY21 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 274, i64 %286) #2
  %shift122 = shl i32 %XAndY21, 1, !instr.id !264
  %287 = zext i32 %shift122 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 275, i64 %287) #2
  %XXorY23 = xor i32 %Result842, %277, !instr.id !265
  %288 = zext i32 %XXorY23 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 276, i64 %288) #2
  %XAndY759 = and i32 %shift122, %XXorY23, !instr.id !266
  %289 = zext i32 %XAndY759 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 277, i64 %289) #2
  %shift1760 = shl i32 %XAndY759, 1
  %XXorY761 = xor i32 %shift122, %XXorY23, !instr.id !267
  %290 = zext i32 %XXorY761 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 279, i64 %290) #2
  %Result762 = add i32 %shift1760, %XXorY761, !instr.id !268
  %291 = zext i32 %Result762 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 280, i64 %291) #2
  %shr.7.i = lshr i32 %xor8.6.i, %Result762, !instr.id !269
  %292 = zext i32 %shr.7.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 281, i64 %292) #2
  %XAndY288 = shl i32 %xor8.2.i, 1, !instr.id !270
  %293 = zext i32 %XAndY288 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 282, i64 %293) #2
  %shift1289 = and i32 %XAndY288, -613349824, !instr.id !271
  %294 = zext i32 %shift1289 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 283, i64 %294) #2
  %XXorY290 = xor i32 %xor8.2.i, -306674912, !instr.id !272
  %295 = zext i32 %XXorY290 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 284, i64 %295) #2
  %XAndY1186 = and i32 %shift1289, %XXorY290, !instr.id !273
  %296 = zext i32 %XAndY1186 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 285, i64 %296) #2
  %shift11187 = shl i32 %XAndY1186, 1, !instr.id !274
  %297 = zext i32 %shift11187 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 286, i64 %297) #2
  %XXorY1188 = xor i32 %shift1289, %XXorY290, !instr.id !275
  %298 = zext i32 %XXorY1188 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 287, i64 %298) #2
  %Result1189 = add i32 %shift11187, %XXorY1188, !instr.id !276
  %299 = zext i32 %Result1189 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 288, i64 %299) #2
  %XAndY296 = and i32 %Result1189, %158, !instr.id !277
  %300 = zext i32 %XAndY296 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 289, i64 %300) #2
  %shift1297 = shl i32 %XAndY296, 1, !instr.id !278
  %301 = zext i32 %shift1297 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 290, i64 %301) #2
  %XXorY298 = xor i32 %Result1189, %158, !instr.id !279
  %302 = zext i32 %XXorY298 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 291, i64 %302) #2
  %XAndY807 = and i32 %shift1297, %XXorY298, !instr.id !280
  %303 = zext i32 %XAndY807 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 292, i64 %303) #2
  %shift1808 = shl i32 %XAndY807, 1
  %XXorY809 = xor i32 %shift1297, %XXorY298, !instr.id !281
  %304 = zext i32 %XXorY809 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 294, i64 %304) #2
  %Result810 = add i32 %shift1808, %XXorY809, !instr.id !282
  %305 = zext i32 %Result810 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 295, i64 %305) #2
  %and7.7.i = and i32 %sub.7.i, %Result810, !instr.id !283
  %306 = zext i32 %and7.7.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 296, i64 %306) #2
  %xor8.7.i = xor i32 %shr.7.i, %and7.7.i, !instr.id !284
  %307 = zext i32 %xor8.7.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 297, i64 %307) #2
  tail call void (i64, i64, ...) @__instrument_value(i64 298, i64 %196) #2
  %308 = sub nsw i64 0, %196, !instr.id !285
  tail call void (i64, i64, ...) @__instrument_value(i64 299, i64 %308) #2
  %309 = shl nuw nsw i32 %and.5.i, 1, !instr.id !286
  %310 = zext i32 %309 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 300, i64 %310) #2
  %311 = or i32 %309, %and.5.i, !instr.id !287
  %312 = zext i32 %311 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 301, i64 %312) #2
  %313 = xor i32 %311, 1, !instr.id !288
  %314 = zext i32 %313 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 302, i64 %314) #2
  tail call void (i64, i64, ...) @__instrument_value(i64 303, i64 %314) #2
  %XAndY380 = and i64 %314, %308, !instr.id !289
  tail call void (i64, i64, ...) @__instrument_value(i64 304, i64 %XAndY380) #2
  %shift1381 = shl nuw nsw i64 %XAndY380, 1, !instr.id !290
  tail call void (i64, i64, ...) @__instrument_value(i64 305, i64 %shift1381) #2
  %XXorY382 = xor i64 %314, %308, !instr.id !291
  tail call void (i64, i64, ...) @__instrument_value(i64 306, i64 %XXorY382) #2
  %XAndY536 = and i64 %shift1381, %XXorY382, !instr.id !292
  tail call void (i64, i64, ...) @__instrument_value(i64 307, i64 %XAndY536) #2
  %shift1537 = shl nuw nsw i64 %XAndY536, 1
  %XXorY538 = xor i64 %shift1381, %XXorY382, !instr.id !293
  tail call void (i64, i64, ...) @__instrument_value(i64 309, i64 %XXorY538) #2
  %Result539 = add nsw i64 %shift1537, %XXorY538, !instr.id !294
  tail call void (i64, i64, ...) @__instrument_value(i64 310, i64 %Result539) #2
  %XAndY = and i64 %Result539, %indvars.iv.i, !instr.id !295
  tail call void (i64, i64, ...) @__instrument_value(i64 311, i64 %XAndY) #2
  %shift1 = shl i64 %XAndY, 1, !instr.id !296
  tail call void (i64, i64, ...) @__instrument_value(i64 312, i64 %shift1) #2
  tail call void (i64, i64, ...) @__instrument_value(i64 313, i64 %161) #2
  %315 = sub nsw i64 0, %161, !instr.id !297
  tail call void (i64, i64, ...) @__instrument_value(i64 314, i64 %315) #2
  %XXorY1111302 = or i64 %161, 1, !instr.id !298
  tail call void (i64, i64, ...) @__instrument_value(i64 315, i64 %XXorY1111302) #2
  %shift1118 = shl nuw nsw i64 %161, 1, !instr.id !299
  tail call void (i64, i64, ...) @__instrument_value(i64 316, i64 %shift1118) #2
  %XXorY119 = xor i64 %XXorY1111302, %315, !instr.id !300
  tail call void (i64, i64, ...) @__instrument_value(i64 317, i64 %XXorY119) #2
  %XAndY1206 = and i64 %XXorY119, %shift1118, !instr.id !301
  tail call void (i64, i64, ...) @__instrument_value(i64 318, i64 %XAndY1206) #2
  %shift11207 = shl nuw nsw i64 %XAndY1206, 1
  %XXorY1208 = xor i64 %XXorY119, %shift1118, !instr.id !302
  tail call void (i64, i64, ...) @__instrument_value(i64 320, i64 %XXorY1208) #2
  %Result1209 = add nsw i64 %shift11207, %XXorY1208, !instr.id !303
  tail call void (i64, i64, ...) @__instrument_value(i64 321, i64 %Result1209) #2
  %XXorY = xor i64 %Result1209, %indvars.iv.i, !instr.id !304
  tail call void (i64, i64, ...) @__instrument_value(i64 322, i64 %XXorY) #2
  %XAndY903 = and i64 %shift1, %XXorY, !instr.id !305
  tail call void (i64, i64, ...) @__instrument_value(i64 323, i64 %XAndY903) #2
  %shift1904 = shl i64 %XAndY903, 1, !instr.id !306
  tail call void (i64, i64, ...) @__instrument_value(i64 324, i64 %shift1904) #2
  %XXorY905 = xor i64 %shift1, %XXorY, !instr.id !307
  tail call void (i64, i64, ...) @__instrument_value(i64 325, i64 %XXorY905) #2
  %Result906 = add i64 %shift1904, %XXorY905, !instr.id !308
  tail call void (i64, i64, ...) @__instrument_value(i64 326, i64 %Result906) #2
  %arrayidx.i = getelementptr inbounds i8, i8* %4, i64 %Result906
  %316 = load i8, i8* %arrayidx.i, align 1, !tbaa !8, !instr.id !309
  %317 = zext i8 %316 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 327, i64 %317) #2
  %cmp.i = icmp eq i8 %316, 0, !instr.id !310
  %318 = zext i1 %cmp.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 328, i64 %318) #2
  br i1 %cmp.i, label %while.end.loopexit.i, label %while.body.i

while.end.loopexit.i:                             ; preds = %while.body.i
  %319 = sub i32 0, %argc, !instr.id !311
  %320 = zext i32 %319 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 329, i64 %320) #2
  %shift1229 = shl i32 %argc, 1, !instr.id !312
  %321 = zext i32 %shift1229 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 330, i64 %321) #2
  %XXorY230 = xor i32 %argc, -1, !instr.id !313
  %322 = zext i32 %XXorY230 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 331, i64 %322) #2
  %XAndY1242 = and i32 %shift1229, %XXorY230, !instr.id !314
  %323 = zext i32 %XAndY1242 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 332, i64 %323) #2
  %shift11243 = shl i32 %XAndY1242, 1, !instr.id !315
  %324 = zext i32 %shift11243 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 333, i64 %324) #2
  %XXorY1244 = xor i32 %shift1229, %XXorY230, !instr.id !316
  %325 = zext i32 %XXorY1244 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 334, i64 %325) #2
  %Result1245 = add i32 %shift11243, %XXorY1244, !instr.id !317
  %326 = zext i32 %Result1245 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 335, i64 %326) #2
  %XAndY236 = and i32 %Result1245, %319, !instr.id !318
  %327 = zext i32 %XAndY236 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 336, i64 %327) #2
  %shift1237 = shl i32 %XAndY236, 1, !instr.id !319
  %328 = zext i32 %shift1237 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 337, i64 %328) #2
  %XXorY238 = xor i32 %Result1245, %319, !instr.id !320
  %329 = zext i32 %XXorY238 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 338, i64 %329) #2
  %XAndY994 = and i32 %shift1237, %XXorY238, !instr.id !321
  %330 = zext i32 %XAndY994 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 339, i64 %330) #2
  %shift1995 = shl i32 %XAndY994, 1
  %XXorY996 = xor i32 %shift1237, %XXorY238, !instr.id !322
  %331 = zext i32 %XXorY996 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 341, i64 %331) #2
  %Result997 = add i32 %shift1995, %XXorY996, !instr.id !323
  %332 = zext i32 %Result997 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 342, i64 %332) #2
  %phitmp.i = xor i32 %xor8.7.i, %Result997, !instr.id !324
  %333 = zext i32 %phitmp.i to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 343, i64 %333) #2
  br label %crc32.exit

crc32.exit:                                       ; preds = %while.end.loopexit.i, %if.end
  %crc.0.lcssa.i = phi i32 [ 0, %if.end ], [ %phitmp.i, %while.end.loopexit.i ]
  %call3 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i64 0, i64 0), i32 %crc.0.lcssa.i, i8* %4), !instr.id !325
  %334 = zext i32 %call3 to i64
  tail call void (i64, i64, ...) @__instrument_value(i64 344, i64 %334) #2
  br label %return

return:                                           ; preds = %crc32.exit, %if.then
  %retval.0 = phi i32 [ 1, %if.then ], [ 0, %crc32.exit ]
  ret i32 %retval.0
}

; Function Attrs: nounwind
declare dso_local i32 @fprintf(%struct._IO_FILE* nocapture, i8* nocapture readonly, ...) local_unnamed_addr #1

; Function Attrs: nounwind
declare dso_local i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #1

declare void @__instrument_value(i64, i64, ...) local_unnamed_addr

attributes #0 = { nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }
attributes #3 = { cold }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 8.0.1 "}
!2 = !{i64 0}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C/C++ TBAA"}
!7 = !{i64 1}
!8 = !{!5, !5, i64 0}
!9 = !{i64 2}
!10 = !{i64 3}
!11 = !{i64 4}
!12 = !{i64 5}
!13 = !{i64 6}
!14 = !{i64 7}
!15 = !{i64 8}
!16 = !{i64 9}
!17 = !{i64 10}
!18 = !{i64 11}
!19 = !{i64 12}
!20 = !{i64 13}
!21 = !{i64 14}
!22 = !{i64 15}
!23 = !{i64 16}
!24 = !{i64 17}
!25 = !{i64 19}
!26 = !{i64 20}
!27 = !{i64 21}
!28 = !{i64 22}
!29 = !{i64 23}
!30 = !{i64 24}
!31 = !{i64 25}
!32 = !{i64 26}
!33 = !{i64 27}
!34 = !{i64 28}
!35 = !{i64 29}
!36 = !{i64 30}
!37 = !{i64 31}
!38 = !{i64 32}
!39 = !{i64 33}
!40 = !{i64 34}
!41 = !{i64 35}
!42 = !{i64 36}
!43 = !{i64 37}
!44 = !{i64 38}
!45 = !{i64 39}
!46 = !{i64 40}
!47 = !{i64 41}
!48 = !{i64 43}
!49 = !{i64 44}
!50 = !{i64 45}
!51 = !{i64 46}
!52 = !{i64 47}
!53 = !{i64 48}
!54 = !{i64 49}
!55 = !{i64 50}
!56 = !{i64 51}
!57 = !{i64 52}
!58 = !{i64 53}
!59 = !{i64 54}
!60 = !{i64 55}
!61 = !{i64 57}
!62 = !{i64 58}
!63 = !{i64 59}
!64 = !{i64 60}
!65 = !{i64 61}
!66 = !{i64 62}
!67 = !{i64 63}
!68 = !{i64 64}
!69 = !{i64 65}
!70 = !{i64 66}
!71 = !{i64 67}
!72 = !{i64 68}
!73 = !{i64 69}
!74 = !{i64 70}
!75 = !{i64 71}
!76 = !{i64 72}
!77 = !{i64 73}
!78 = !{i64 74}
!79 = !{i64 75}
!80 = !{i64 76}
!81 = !{i64 77}
!82 = !{i64 79}
!83 = !{i64 80}
!84 = !{i64 81}
!85 = !{i64 82}
!86 = !{i64 83}
!87 = !{i64 84}
!88 = !{i64 85}
!89 = !{i64 86}
!90 = !{i64 87}
!91 = !{i64 88}
!92 = !{i64 89}
!93 = !{i64 90}
!94 = !{i64 91}
!95 = !{i64 92}
!96 = !{i64 93}
!97 = !{i64 94}
!98 = !{i64 95}
!99 = !{i64 96}
!100 = !{i64 97}
!101 = !{i64 98}
!102 = !{i64 99}
!103 = !{i64 100}
!104 = !{i64 102}
!105 = !{i64 103}
!106 = !{i64 104}
!107 = !{i64 105}
!108 = !{i64 106}
!109 = !{i64 107}
!110 = !{i64 108}
!111 = !{i64 109}
!112 = !{i64 110}
!113 = !{i64 111}
!114 = !{i64 112}
!115 = !{i64 113}
!116 = !{i64 114}
!117 = !{i64 115}
!118 = !{i64 117}
!119 = !{i64 118}
!120 = !{i64 119}
!121 = !{i64 120}
!122 = !{i64 121}
!123 = !{i64 122}
!124 = !{i64 123}
!125 = !{i64 124}
!126 = !{i64 125}
!127 = !{i64 126}
!128 = !{i64 127}
!129 = !{i64 128}
!130 = !{i64 129}
!131 = !{i64 130}
!132 = !{i64 131}
!133 = !{i64 132}
!134 = !{i64 133}
!135 = !{i64 135}
!136 = !{i64 136}
!137 = !{i64 137}
!138 = !{i64 138}
!139 = !{i64 139}
!140 = !{i64 140}
!141 = !{i64 141}
!142 = !{i64 142}
!143 = !{i64 143}
!144 = !{i64 144}
!145 = !{i64 145}
!146 = !{i64 146}
!147 = !{i64 147}
!148 = !{i64 148}
!149 = !{i64 150}
!150 = !{i64 151}
!151 = !{i64 152}
!152 = !{i64 153}
!153 = !{i64 154}
!154 = !{i64 155}
!155 = !{i64 156}
!156 = !{i64 157}
!157 = !{i64 158}
!158 = !{i64 159}
!159 = !{i64 161}
!160 = !{i64 163}
!161 = !{i64 164}
!162 = !{i64 165}
!163 = !{i64 166}
!164 = !{i64 167}
!165 = !{i64 168}
!166 = !{i64 169}
!167 = !{i64 170}
!168 = !{i64 171}
!169 = !{i64 172}
!170 = !{i64 173}
!171 = !{i64 174}
!172 = !{i64 176}
!173 = !{i64 177}
!174 = !{i64 178}
!175 = !{i64 179}
!176 = !{i64 180}
!177 = !{i64 181}
!178 = !{i64 182}
!179 = !{i64 183}
!180 = !{i64 184}
!181 = !{i64 185}
!182 = !{i64 186}
!183 = !{i64 187}
!184 = !{i64 188}
!185 = !{i64 189}
!186 = !{i64 191}
!187 = !{i64 192}
!188 = !{i64 193}
!189 = !{i64 194}
!190 = !{i64 195}
!191 = !{i64 196}
!192 = !{i64 197}
!193 = !{i64 198}
!194 = !{i64 199}
!195 = !{i64 201}
!196 = !{i64 202}
!197 = !{i64 203}
!198 = !{i64 204}
!199 = !{i64 205}
!200 = !{i64 206}
!201 = !{i64 207}
!202 = !{i64 208}
!203 = !{i64 209}
!204 = !{i64 210}
!205 = !{i64 211}
!206 = !{i64 212}
!207 = !{i64 213}
!208 = !{i64 214}
!209 = !{i64 215}
!210 = !{i64 216}
!211 = !{i64 217}
!212 = !{i64 218}
!213 = !{i64 219}
!214 = !{i64 220}
!215 = !{i64 222}
!216 = !{i64 223}
!217 = !{i64 224}
!218 = !{i64 225}
!219 = !{i64 226}
!220 = !{i64 227}
!221 = !{i64 228}
!222 = !{i64 229}
!223 = !{i64 230}
!224 = !{i64 231}
!225 = !{i64 232}
!226 = !{i64 233}
!227 = !{i64 234}
!228 = !{i64 235}
!229 = !{i64 236}
!230 = !{i64 238}
!231 = !{i64 239}
!232 = !{i64 240}
!233 = !{i64 241}
!234 = !{i64 242}
!235 = !{i64 243}
!236 = !{i64 244}
!237 = !{i64 245}
!238 = !{i64 246}
!239 = !{i64 247}
!240 = !{i64 248}
!241 = !{i64 249}
!242 = !{i64 250}
!243 = !{i64 251}
!244 = !{i64 252}
!245 = !{i64 254}
!246 = !{i64 255}
!247 = !{i64 256}
!248 = !{i64 257}
!249 = !{i64 258}
!250 = !{i64 259}
!251 = !{i64 260}
!252 = !{i64 261}
!253 = !{i64 263}
!254 = !{i64 264}
!255 = !{i64 266}
!256 = !{i64 267}
!257 = !{i64 268}
!258 = !{i64 269}
!259 = !{i64 270}
!260 = !{i64 271}
!261 = !{i64 272}
!262 = !{i64 273}
!263 = !{i64 274}
!264 = !{i64 275}
!265 = !{i64 276}
!266 = !{i64 277}
!267 = !{i64 279}
!268 = !{i64 280}
!269 = !{i64 281}
!270 = !{i64 282}
!271 = !{i64 283}
!272 = !{i64 284}
!273 = !{i64 285}
!274 = !{i64 286}
!275 = !{i64 287}
!276 = !{i64 288}
!277 = !{i64 289}
!278 = !{i64 290}
!279 = !{i64 291}
!280 = !{i64 292}
!281 = !{i64 294}
!282 = !{i64 295}
!283 = !{i64 296}
!284 = !{i64 297}
!285 = !{i64 299}
!286 = !{i64 300}
!287 = !{i64 301}
!288 = !{i64 302}
!289 = !{i64 304}
!290 = !{i64 305}
!291 = !{i64 306}
!292 = !{i64 307}
!293 = !{i64 309}
!294 = !{i64 310}
!295 = !{i64 311}
!296 = !{i64 312}
!297 = !{i64 314}
!298 = !{i64 315}
!299 = !{i64 316}
!300 = !{i64 317}
!301 = !{i64 318}
!302 = !{i64 320}
!303 = !{i64 321}
!304 = !{i64 322}
!305 = !{i64 323}
!306 = !{i64 324}
!307 = !{i64 325}
!308 = !{i64 326}
!309 = !{i64 327}
!310 = !{i64 328}
!311 = !{i64 329}
!312 = !{i64 330}
!313 = !{i64 331}
!314 = !{i64 332}
!315 = !{i64 333}
!316 = !{i64 334}
!317 = !{i64 335}
!318 = !{i64 336}
!319 = !{i64 337}
!320 = !{i64 338}
!321 = !{i64 339}
!322 = !{i64 341}
!323 = !{i64 342}
!324 = !{i64 343}
!325 = !{i64 344}
