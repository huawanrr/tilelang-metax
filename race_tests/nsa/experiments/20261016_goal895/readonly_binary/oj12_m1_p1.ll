; ModuleID = 'experiments/20261016_goal895/readonly_binary/oj12_m1_p1.bc'
source_filename = "/tmp/tmp1phl10fr/tvm_kernels.maca"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "mxc-metax-macahca"

%struct.mcDevMallocInfo.0 = type { i32, i32, ptr }
%struct.__half = type { i16 }

@buf_dyn_shmem = external protected local_unnamed_addr addrspace(3) global [0 x i8], align 1024
@mcDeviceMemoryInfo = weak protected addrspace(1) externally_initialized global [1 x %struct.mcDevMallocInfo.0] zeroinitializer, align 8
@llvm.compiler.used = appending addrspace(1) global [1 x ptr] [ptr addrspacecast (ptr addrspace(1) @mcDeviceMemoryInfo to ptr)], section "llvm.metadata"

; Function Attrs: mustprogress noreturn nounwind
define weak void @__cxa_pure_virtual() local_unnamed_addr #0 !dbg !5 {
entry:
  tail call void @llvm.trap(), !dbg !9
  unreachable, !dbg !10
}

; Function Attrs: cold noreturn nounwind memory(inaccessiblemem: write)
declare void @llvm.trap() #1

; Function Attrs: mustprogress noreturn nounwind
define weak void @__cxa_deleted_virtual() local_unnamed_addr #0 !dbg !11 {
entry:
  tail call void @llvm.trap(), !dbg !12
  unreachable, !dbg !13
}

; Function Attrs: mustprogress nounwind
define weak protected void @__mcImplicitDeviceSynchronize() local_unnamed_addr #2 !dbg !14 {
entry:
  %0 = tail call ptr addrspace(4) @llvm.mxc.implicitarg.ptr(), !dbg !16
  %arrayidx.i.i = getelementptr inbounds i8, ptr addrspace(4) %0, i64 32, !dbg !16
  %1 = load i64, ptr addrspace(4) %arrayidx.i.i, align 8, !dbg !16, !tbaa !17
  %2 = inttoptr i64 %1 to ptr, !dbg !16
  %arrayidx.i32.i = getelementptr inbounds i8, ptr addrspace(4) %0, i64 40, !dbg !16
  %3 = load i64, ptr addrspace(4) %arrayidx.i32.i, align 8, !dbg !16, !tbaa !17
  %4 = inttoptr i64 %3 to ptr, !dbg !16
  %current_counter.i = getelementptr inbounds i8, ptr %4, i64 12, !dbg !16
  %thread_counter.i = getelementptr inbounds i8, ptr %4, i64 16, !dbg !16
  %5 = load ptr, ptr %thread_counter.i, align 8, !dbg !16, !tbaa !21
  %cmp.not.i = icmp eq ptr %5, null, !dbg !16
  br i1 %cmp.not.i, label %if.end.i, label %if.then.i, !dbg !16

if.then.i:                                        ; preds = %entry
  %6 = tail call align 4 dereferenceable(64) ptr addrspace(4) @llvm.mxc.dispatch.ptr(), !dbg !16
  %7 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 12, !dbg !16
  %8 = load i32, ptr addrspace(4) %7, align 4, !dbg !16, !range !28, !invariant.load !8
  %9 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 4, !dbg !16
  %10 = load i32, ptr addrspace(4) %9, align 4, !dbg !16, !invariant.load !8
  %conv.i14.i.i = and i32 %10, 65535, !dbg !16
  %div.i15.i.i = udiv i32 %8, %conv.i14.i.i, !dbg !16
  %mul.i16.i.i = mul i32 %div.i15.i.i, %conv.i14.i.i, !dbg !16
  %cmp.i17.i.i = icmp ugt i32 %8, %mul.i16.i.i, !dbg !16
  %conv2.i18.i.i = zext i1 %cmp.i17.i.i to i32, !dbg !16
  %add.i19.i.i = add nuw i32 %div.i15.i.i, %conv2.i18.i.i, !dbg !16
  %11 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 16, !dbg !16
  %12 = load i32, ptr addrspace(4) %11, align 4, !dbg !16, !range !28, !invariant.load !8
  %13 = lshr i32 %10, 16, !dbg !16
  %div.i.i.i = udiv i32 %12, %13, !dbg !16
  %mul.i.i.i = mul i32 %div.i.i.i, %13, !dbg !16
  %cmp.i.i.i = icmp ugt i32 %12, %mul.i.i.i, !dbg !16
  %conv2.i.i.i = zext i1 %cmp.i.i.i to i32, !dbg !16
  %add.i.i.i = add nuw i32 %div.i.i.i, %conv2.i.i.i, !dbg !16
  %14 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !dbg !16, !range !29
  %mul.i.i = mul i32 %add.i.i.i, %14, !dbg !16
  %15 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !dbg !16, !range !29
  %mul320.i.i = add i32 %mul.i.i, %15, !dbg !16
  %add.i.i = mul i32 %mul320.i.i, %add.i19.i.i, !dbg !16
  %16 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !dbg !16, !range !29
  %add8.i.i = add i32 %add.i.i, %16, !dbg !16
  %conv.i.i = zext i32 %add8.i.i to i64, !dbg !16
  %arrayidx.i = getelementptr inbounds i32, ptr %5, i64 %conv.i.i, !dbg !16
  %17 = tail call i1 @llvm.mxc.is.private(ptr nonnull %arrayidx.i), !dbg !16
  br label %while.cond.i, !dbg !16

while.cond.i:                                     ; preds = %while.body.i, %if.then.i
  br i1 %17, label %if.then.i.i, label %if.end.i.i, !dbg !16

if.then.i.i:                                      ; preds = %while.cond.i
  %18 = load i32, ptr %arrayidx.i, align 4, !dbg !16, !tbaa !30
  br label %_Z9atomicAddPii.exit.i, !dbg !16

if.end.i.i:                                       ; preds = %while.cond.i
  %19 = atomicrmw or ptr %arrayidx.i, i32 0 syncscope("device-one-as") monotonic, align 4, !dbg !16
  br label %_Z9atomicAddPii.exit.i, !dbg !16

_Z9atomicAddPii.exit.i:                           ; preds = %if.end.i.i, %if.then.i.i
  %retval.0.i.i = phi i32 [ %18, %if.then.i.i ], [ %19, %if.end.i.i ], !dbg !16
  %cmp6.i = icmp sgt i32 %retval.0.i.i, 0, !dbg !16
  br i1 %cmp6.i, label %while.body.i, label %if.end.i, !dbg !16

while.body.i:                                     ; preds = %_Z9atomicAddPii.exit.i
  tail call void @llvm.mxc.sleep(i32 1), !dbg !16
  br label %while.cond.i, !dbg !16, !llvm.loop !31

if.end.i:                                         ; preds = %_Z9atomicAddPii.exit.i, %entry
  %20 = tail call i1 @llvm.mxc.is.private(ptr nonnull %current_counter.i), !dbg !16
  br i1 %20, label %if.then.i36.i, label %if.end.i34.i, !dbg !16

if.then.i36.i:                                    ; preds = %if.end.i
  %21 = load i32, ptr %current_counter.i, align 4, !dbg !16, !tbaa !30
  %add.i37.i = add nsw i32 %21, -1, !dbg !16
  store i32 %add.i37.i, ptr %current_counter.i, align 4, !dbg !16, !tbaa !30
  br label %_Z9atomicAddPii.exit38.i, !dbg !16

if.end.i34.i:                                     ; preds = %if.end.i
  %22 = atomicrmw add ptr %current_counter.i, i32 -1 syncscope("device-one-as") monotonic, align 4, !dbg !16
  br label %_Z9atomicAddPii.exit38.i, !dbg !16

_Z9atomicAddPii.exit38.i:                         ; preds = %if.end.i34.i, %if.then.i36.i
  %retval.0.i35.i = phi i32 [ %21, %if.then.i36.i ], [ %22, %if.end.i34.i ], !dbg !16
  %call_deep.i = getelementptr inbounds i8, ptr %4, i64 4, !dbg !16
  %23 = load i32, ptr %call_deep.i, align 4, !dbg !16, !tbaa !33
  %cmp8.i = icmp eq i32 %23, 0, !dbg !16
  br i1 %cmp8.i, label %if.then9.i, label %if.else.i, !dbg !16

if.then9.i:                                       ; preds = %_Z9atomicAddPii.exit38.i
  %cmp10.i = icmp slt i32 %retval.0.i35.i, 2, !dbg !16
  br i1 %cmp10.i, label %if.then11.i, label %__mcImplicitDeviceSynchronizeImpl.exit, !dbg !16

if.then11.i:                                      ; preds = %if.then9.i
  tail call void @llvm.mxc.sleep(i32 30), !dbg !16
  br label %__mcImplicitDeviceSynchronizeImpl.exit, !dbg !16

if.else.i:                                        ; preds = %_Z9atomicAddPii.exit38.i
  %parent_wrap13.i = getelementptr inbounds i8, ptr %4, i64 24, !dbg !16
  %24 = load ptr, ptr %parent_wrap13.i, align 8, !dbg !16, !tbaa !34
  %25 = load i32, ptr %4, align 8, !dbg !16, !tbaa !35
  %thread_counter15.i = getelementptr inbounds i8, ptr %24, i64 16, !dbg !16
  %26 = load ptr, ptr %thread_counter15.i, align 8, !dbg !16, !tbaa !21
  %idxprom.i = zext i32 %25 to i64, !dbg !16
  %arrayidx16.i = getelementptr inbounds i32, ptr %26, i64 %idxprom.i, !dbg !16
  %cmp17.i = icmp slt i32 %retval.0.i35.i, 2, !dbg !16
  br i1 %cmp17.i, label %if.then18.i, label %if.end20.i, !dbg !16

if.then18.i:                                      ; preds = %if.else.i
  %mqlwrap_slots.i = getelementptr inbounds i8, ptr %2, i64 24, !dbg !16
  %27 = load ptr, ptr %mqlwrap_slots.i, align 8, !dbg !16, !tbaa !36
  %sub.ptr.rhs.cast.i = ptrtoint ptr %27 to i64, !dbg !16
  %sub.ptr.sub.i = sub i64 %3, %sub.ptr.rhs.cast.i, !dbg !16
  %sub.ptr.div.i = sdiv exact i64 %sub.ptr.sub.i, 96, !dbg !16
  %mqlwrap_slot_mask.i = getelementptr inbounds i8, ptr %2, i64 80, !dbg !16
  %28 = load i64, ptr %mqlwrap_slot_mask.i, align 8, !dbg !16, !tbaa !38
  %29 = inttoptr i64 %28 to ptr, !dbg !16
  %idx.ext.i.i = and i64 %sub.ptr.div.i, 4294967295, !dbg !16
  %add.ptr.i.i = getelementptr inbounds i32, ptr %29, i64 %idx.ext.i.i, !dbg !16
  %30 = tail call i1 @llvm.mxc.is.private(ptr %add.ptr.i.i), !dbg !16
  br i1 %30, label %if.then.i.i.i, label %if.end.i.i.i, !dbg !16

if.then.i.i.i:                                    ; preds = %if.then18.i
  %31 = load i32, ptr %add.ptr.i.i, align 4, !dbg !16, !tbaa !30
  %and.i.i.i = and i32 %31, 2147483647, !dbg !16
  store i32 %and.i.i.i, ptr %add.ptr.i.i, align 4, !dbg !16, !tbaa !30
  br label %if.end20.i, !dbg !16

if.end.i.i.i:                                     ; preds = %if.then18.i
  %32 = atomicrmw and ptr %add.ptr.i.i, i32 2147483647 syncscope("device-one-as") monotonic, align 4, !dbg !16
  br label %if.end20.i, !dbg !16

if.end20.i:                                       ; preds = %if.end.i.i.i, %if.then.i.i.i, %if.else.i
  %33 = tail call i1 @llvm.mxc.is.private(ptr %arrayidx16.i), !dbg !16
  br i1 %33, label %if.then.i41.i, label %if.end.i39.i, !dbg !16

if.then.i41.i:                                    ; preds = %if.end20.i
  %34 = load i32, ptr %arrayidx16.i, align 4, !dbg !16, !tbaa !30
  %add.i42.i = add nsw i32 %34, -1, !dbg !16
  store i32 %add.i42.i, ptr %arrayidx16.i, align 4, !dbg !16, !tbaa !30
  br label %__mcImplicitDeviceSynchronizeImpl.exit, !dbg !16

if.end.i39.i:                                     ; preds = %if.end20.i
  %35 = atomicrmw add ptr %arrayidx16.i, i32 -1 syncscope("device-one-as") monotonic, align 4, !dbg !16
  br label %__mcImplicitDeviceSynchronizeImpl.exit, !dbg !16

__mcImplicitDeviceSynchronizeImpl.exit:           ; preds = %if.then9.i, %if.then11.i, %if.then.i41.i, %if.end.i39.i
  ret void, !dbg !39
}

; Function Attrs: convergent mustprogress norecurse nounwind willreturn
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %BlockIndices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V.coerce) local_unnamed_addr #3 !dbg !40 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul = shl nsw i32 %0, 13
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul7 = shl nsw i32 %1, 3
  %add = add nuw nsw i32 %mul, %mul7
  %2 = zext nneg i32 %add to i64, !dbg !42
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %2, !dbg !43
  %arrayidx.val = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !44, !tbaa !30
  %cond.i.i = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %arrayidx.val, i32 -1), !dbg !45, !call_argsrelate !49
  %cond.i.i1173 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64), !dbg !50
  %mul12 = shl nsw i32 %cond.i.i1173, 4, !dbg !53
  %3 = or disjoint i64 %2, 1, !dbg !54
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %3, !dbg !43
  %arrayidx.val.1 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !dbg !44, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %arrayidx.val.1, i32 -1), !dbg !45, !call_argsrelate !49
  %cond.i.i1173.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64), !dbg !50
  %mul12.1 = shl nsw i32 %cond.i.i1173.1, 4, !dbg !53
  %4 = or disjoint i64 %2, 2, !dbg !54
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4, !dbg !43
  %arrayidx.val.2 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !dbg !44, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %arrayidx.val.2, i32 -1), !dbg !45, !call_argsrelate !49
  %cond.i.i1173.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64), !dbg !50
  %mul12.2 = shl nsw i32 %cond.i.i1173.2, 4, !dbg !53
  %5 = or disjoint i64 %2, 3, !dbg !54
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %5, !dbg !43
  %arrayidx.val.3 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !dbg !44, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %arrayidx.val.3, i32 -1), !dbg !45, !call_argsrelate !49
  %cond.i.i1173.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64), !dbg !50
  %mul12.3 = shl nsw i32 %cond.i.i1173.3, 4, !dbg !53
  %6 = or disjoint i64 %2, 4, !dbg !54
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6, !dbg !43
  %arrayidx.val.4 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !dbg !44, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %arrayidx.val.4, i32 -1), !dbg !45, !call_argsrelate !49
  %cond.i.i1173.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64), !dbg !50
  %mul12.4 = shl nsw i32 %cond.i.i1173.4, 4, !dbg !53
  %7 = or disjoint i64 %2, 5, !dbg !54
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %7, !dbg !43
  %arrayidx.val.5 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !dbg !44, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %arrayidx.val.5, i32 -1), !dbg !45, !call_argsrelate !49
  %cond.i.i1173.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64), !dbg !50
  %mul12.5 = shl nsw i32 %cond.i.i1173.5, 4, !dbg !53
  %8 = or disjoint i64 %2, 6, !dbg !54
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8, !dbg !43
  %arrayidx.val.6 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !dbg !44, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %arrayidx.val.6, i32 -1), !dbg !45, !call_argsrelate !49
  %cond.i.i1173.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64), !dbg !50
  %mul12.6 = shl nsw i32 %cond.i.i1173.6, 4, !dbg !53
  %9 = or disjoint i64 %2, 7, !dbg !54
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %9, !dbg !43
  %arrayidx.val.7 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !dbg !44, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %arrayidx.val.7, i32 -1), !dbg !45, !call_argsrelate !49
  %cond.i.i1173.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64), !dbg !50
  %mul12.7 = shl nsw i32 %cond.i.i1173.7, 4, !dbg !53
  %mul21 = shl nsw i32 %0, 20
  %mul23 = shl nsw i32 %1, 10
  %add24 = add nuw nsw i32 %mul21, %mul23
  %10 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !55
  %and = shl nuw nsw i32 %10, 6
  %mul26 = and i32 %and, 960
  %add27 = or disjoint i32 %add24, %mul26
  %11 = lshr i32 %10, 1
  %mul31 = and i32 %11, 504
  %add29 = add nuw nsw i32 %add27, %mul31
  %12 = zext nneg i32 %add29 to i64, !dbg !56
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %12, !dbg !57
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16, !dbg !58
  %Q_reg.sroa.11.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !58
  %Q_reg.sroa.11.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.11.0.add.ptr.sroa_idx, align 8, !dbg !58
  %13 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %12, !dbg !57
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %13, i64 64, !dbg !57
  %Q_reg.sroa.19.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16, !dbg !58
  %Q_reg.sroa.28.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %13, i64 72, !dbg !58
  %Q_reg.sroa.28.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.28.16.add.ptr.1.sroa_idx, align 8, !dbg !58
  %mul101 = shl nsw i32 %0, 16
  %mul108 = shl nuw nsw i32 %10, 3
  %add104 = or disjoint i32 %mul108, %mul101
  %invariant.op = add nsw i32 %1, -15, !dbg !59
  %14 = lshr i32 %10, 2
  %mul252 = and i32 %14, 252
  %or.cond = icmp ugt i32 %mul12, 1023, !dbg !60
  %cmp95.not = icmp sgt i32 %mul12, %1
  %or.cond1249 = or i1 %or.cond, %cmp95.not, !dbg !60
  br i1 %or.cond1249, label %if.end, label %for.cond96.preheader, !dbg !60

for.cond96.preheader:                             ; preds = %entry
  %15 = shl nsw i32 %cond.i.i1173, 10
  %mul103 = and i32 %15, 64512
  %add106 = add nuw nsw i32 %add104, %mul103
  %16 = zext nneg i32 %add106 to i64, !dbg !61
  %add.ptr111 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %16, !dbg !62
  %K_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr111, align 16, !dbg !63
  %K_reg.sroa.6.0.add.ptr111.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr111, i64 8, !dbg !63
  %K_reg.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg.sroa.6.0.add.ptr111.sroa_idx, align 8, !dbg !63
  %17 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %16, !dbg !62
  %add.ptr111.1 = getelementptr inbounds i8, ptr addrspace(4) %17, i64 1024, !dbg !62
  %K_reg.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr111.1, align 16, !dbg !63
  %K_reg.sroa.12.16.add.ptr111.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %17, i64 1032, !dbg !63
  %K_reg.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg.sroa.12.16.add.ptr111.1.sroa_idx, align 8, !dbg !63
  br label %if.end, !dbg !64

if.end:                                           ; preds = %for.cond96.preheader, %entry
  %K_reg.sroa.12.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.12.16.copyload, %for.cond96.preheader ]
  %K_reg.sroa.8.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.8.16.copyload, %for.cond96.preheader ]
  %K_reg.sroa.6.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.6.0.copyload, %for.cond96.preheader ]
  %K_reg.sroa.0.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.0.0.copyload, %for.cond96.preheader ]
  %or.cond1250 = icmp ugt i32 %mul12.1, 1023, !dbg !64
  %cmp124.not = icmp sgt i32 %mul12.1, %1
  %or.cond1251 = or i1 %or.cond1250, %cmp124.not, !dbg !64
  br i1 %or.cond1251, label %if.end149, label %for.cond126.preheader, !dbg !64

for.cond126.preheader:                            ; preds = %if.end
  %18 = shl nsw i32 %cond.i.i1173.1, 10
  %mul133 = and i32 %18, 64512
  %add136 = add nuw nsw i32 %add104, %mul133
  %19 = zext nneg i32 %add136 to i64, !dbg !65
  %add.ptr141 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %19, !dbg !66
  %K_reg1.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr141, align 16, !dbg !67
  %K_reg1.sroa.6.0.add.ptr141.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr141, i64 8, !dbg !67
  %K_reg1.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.6.0.add.ptr141.sroa_idx, align 8, !dbg !67
  %20 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %19, !dbg !66
  %add.ptr141.1 = getelementptr inbounds i8, ptr addrspace(4) %20, i64 1024, !dbg !66
  %K_reg1.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr141.1, align 16, !dbg !67
  %K_reg1.sroa.12.16.add.ptr141.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %20, i64 1032, !dbg !67
  %K_reg1.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.12.16.add.ptr141.1.sroa_idx, align 8, !dbg !67
  br label %if.end149, !dbg !68

if.end149:                                        ; preds = %for.cond126.preheader, %if.end
  %K_reg1.sroa.12.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.12.16.copyload, %for.cond126.preheader ]
  %K_reg1.sroa.8.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.8.16.copyload, %for.cond126.preheader ]
  %K_reg1.sroa.6.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.6.0.copyload, %for.cond126.preheader ]
  %K_reg1.sroa.0.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.0.0.copyload, %for.cond126.preheader ]
  %or.cond1252 = icmp ugt i32 %mul12.2, 1023, !dbg !68
  %cmp155.not = icmp sgt i32 %mul12.2, %1
  %or.cond1253 = or i1 %or.cond1252, %cmp155.not, !dbg !68
  br i1 %or.cond1253, label %if.end180, label %for.cond157.preheader, !dbg !68

for.cond157.preheader:                            ; preds = %if.end149
  %21 = shl nsw i32 %cond.i.i1173.2, 10
  %mul164 = and i32 %21, 64512
  %add167 = add nuw nsw i32 %add104, %mul164
  %22 = zext nneg i32 %add167 to i64, !dbg !69
  %add.ptr172 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %22, !dbg !70
  %K_reg2.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr172, align 16, !dbg !71
  %K_reg2.sroa.6.0.add.ptr172.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr172, i64 8, !dbg !71
  %K_reg2.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.6.0.add.ptr172.sroa_idx, align 8, !dbg !71
  %23 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %22, !dbg !70
  %add.ptr172.1 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 1024, !dbg !70
  %K_reg2.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr172.1, align 16, !dbg !71
  %K_reg2.sroa.12.16.add.ptr172.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %23, i64 1032, !dbg !71
  %K_reg2.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.12.16.add.ptr172.1.sroa_idx, align 8, !dbg !71
  br label %if.end180, !dbg !72

if.end180:                                        ; preds = %for.cond157.preheader, %if.end149
  %K_reg2.sroa.12.0 = phi <4 x half> [ undef, %if.end149 ], [ %K_reg2.sroa.12.16.copyload, %for.cond157.preheader ]
  %K_reg2.sroa.8.0 = phi <4 x half> [ undef, %if.end149 ], [ %K_reg2.sroa.8.16.copyload, %for.cond157.preheader ]
  %K_reg2.sroa.6.0 = phi <4 x half> [ undef, %if.end149 ], [ %K_reg2.sroa.6.0.copyload, %for.cond157.preheader ]
  %K_reg2.sroa.0.0 = phi <4 x half> [ undef, %if.end149 ], [ %K_reg2.sroa.0.0.copyload, %for.cond157.preheader ]
  %or.cond1254 = icmp ugt i32 %mul12.3, 1023, !dbg !72
  %cmp186.not = icmp sgt i32 %mul12.3, %1
  %or.cond1255 = or i1 %or.cond1254, %cmp186.not, !dbg !72
  br i1 %or.cond1255, label %if.end211, label %for.cond188.preheader, !dbg !72

for.cond188.preheader:                            ; preds = %if.end180
  %24 = shl nsw i32 %cond.i.i1173.3, 10
  %mul195 = and i32 %24, 64512
  %add198 = add nuw nsw i32 %add104, %mul195
  %25 = zext nneg i32 %add198 to i64, !dbg !73
  %add.ptr203 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %25, !dbg !74
  %K_reg3.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr203, align 16, !dbg !75
  %K_reg3.sroa.6.0.add.ptr203.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr203, i64 8, !dbg !75
  %K_reg3.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.6.0.add.ptr203.sroa_idx, align 8, !dbg !75
  %26 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %25, !dbg !74
  %add.ptr203.1 = getelementptr inbounds i8, ptr addrspace(4) %26, i64 1024, !dbg !74
  %K_reg3.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr203.1, align 16, !dbg !75
  %K_reg3.sroa.12.16.add.ptr203.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %26, i64 1032, !dbg !75
  %K_reg3.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.12.16.add.ptr203.1.sroa_idx, align 8, !dbg !75
  br label %if.end211, !dbg !76

if.end211:                                        ; preds = %for.cond188.preheader, %if.end180
  %K_reg3.sroa.12.0 = phi <4 x half> [ undef, %if.end180 ], [ %K_reg3.sroa.12.16.copyload, %for.cond188.preheader ]
  %K_reg3.sroa.8.0 = phi <4 x half> [ undef, %if.end180 ], [ %K_reg3.sroa.8.16.copyload, %for.cond188.preheader ]
  %K_reg3.sroa.6.0 = phi <4 x half> [ undef, %if.end180 ], [ %K_reg3.sroa.6.0.copyload, %for.cond188.preheader ]
  %K_reg3.sroa.0.0 = phi <4 x half> [ undef, %if.end180 ], [ %K_reg3.sroa.0.0.copyload, %for.cond188.preheader ]
  br i1 %or.cond1249, label %if.end356, label %for.cond219.preheader, !dbg !76

for.cond219.preheader:                            ; preds = %if.end211
  %27 = shl nsw i32 %cond.i.i1173, 10
  %mul226 = and i32 %27, 64512
  %add229 = add nuw nsw i32 %add104, %mul226
  %28 = zext nneg i32 %add229 to i64, !dbg !77
  %add.ptr234 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %28, !dbg !78
  %V_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr234, align 16, !dbg !79
  %V_reg.sroa.18.0.add.ptr234.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr234, i64 8, !dbg !79
  %V_reg.sroa.18.0.copyload = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr234.sroa_idx, align 8, !dbg !79
  %29 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %28, !dbg !78
  %add.ptr234.1 = getelementptr inbounds i8, ptr addrspace(4) %29, i64 1024, !dbg !78
  %V_reg.sroa.26.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr234.1, align 16, !dbg !79
  %V_reg.sroa.42.16.add.ptr234.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %29, i64 1032, !dbg !79
  %V_reg.sroa.42.16.copyload = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr234.1.sroa_idx, align 8, !dbg !79
  %cmp244 = icmp sgt i32 %mul12, %invariant.op, !dbg !80
  br i1 %cmp244, label %for.cond246.preheader, label %if.end269, !dbg !81

for.cond246.preheader:                            ; preds = %for.cond219.preheader
  %add253 = add nuw nsw i32 %mul12, %mul252
  %cmp256.not = icmp sgt i32 %add253, %1, !dbg !82
  %fneg. = select i1 %cmp256.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1437 = insertelement <4 x float> poison, float %fneg., i64 0, !dbg !83
  %cmp256.not.1.not = icmp slt i32 %add253, %1, !dbg !82
  %fneg..1 = select i1 %cmp256.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1538 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1437, float %fneg..1, i64 1, !dbg !83
  %add254.2 = or disjoint i32 %add253, 2, !dbg !84
  %cmp256.not.2 = icmp sgt i32 %add254.2, %1, !dbg !82
  %fneg..2 = select i1 %cmp256.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1631 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1538, float %fneg..2, i64 2, !dbg !83
  %add254.3 = or disjoint i32 %add253, 3, !dbg !84
  %cmp256.not.3 = icmp sgt i32 %add254.3, %1, !dbg !82
  %fneg..3 = select i1 %cmp256.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1724 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1631, float %fneg..3, i64 3, !dbg !83
  br label %if.end269

if.end269:                                        ; preds = %for.cond219.preheader, %for.cond246.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1724, %for.cond246.preheader ], [ zeroinitializer, %for.cond219.preheader ], !dbg !85
  %30 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !dbg !86, !call_argsrelate !87
  %31 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %30), !dbg !86, !call_argsrelate !87
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %31), !dbg !86, !call_argsrelate !87
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %32), !dbg !86, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %33, i64 0, !dbg !88
  %mul304 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !89
  %34 = tail call contract noundef float @llvm.minnum.f32(float %mul304, float 0x4024CB5EC0000000), !dbg !90
  %35 = tail call contract noundef float @llvm.exp.f32(float %34), !dbg !93
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %33, i64 1, !dbg !88
  %mul304.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !89
  %36 = tail call contract noundef float @llvm.minnum.f32(float %mul304.1, float 0x4024CB5EC0000000), !dbg !90
  %37 = tail call contract noundef float @llvm.exp.f32(float %36), !dbg !93
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %33, i64 2, !dbg !88
  %mul304.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !89
  %38 = tail call contract noundef float @llvm.minnum.f32(float %mul304.2, float 0x4024CB5EC0000000), !dbg !90
  %39 = tail call contract noundef float @llvm.exp.f32(float %38), !dbg !93
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %33, i64 3, !dbg !88
  %mul304.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !89
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul304.3, float 0x4024CB5EC0000000), !dbg !90
  %41 = tail call contract noundef float @llvm.exp.f32(float %40), !dbg !93
  %42 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %35), !dbg !96
  %43 = insertelement <4 x i16> poison, i16 %42, i64 0, !dbg !105
  %44 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %37), !dbg !96
  %45 = insertelement <4 x i16> %43, i16 %44, i64 1, !dbg !105
  %46 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %39), !dbg !96
  %47 = insertelement <4 x i16> %45, i16 %46, i64 2, !dbg !105
  %48 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %41), !dbg !96
  %49 = insertelement <4 x i16> %47, i16 %48, i64 3, !dbg !105
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %49 to <4 x half>, !dbg !105
  %50 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !106, !call_argsrelate !107
  %51 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !106, !call_argsrelate !107
  %52 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !106, !call_argsrelate !107
  %53 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !106, !call_argsrelate !107
  br label %if.end356, !dbg !108

if.end356:                                        ; preds = %if.end269, %if.end211
  %acc_o.sroa.98.0 = phi <4 x float> [ zeroinitializer, %if.end211 ], [ %53, %if.end269 ], !dbg !85
  %acc_o.sroa.66.0 = phi <4 x float> [ zeroinitializer, %if.end211 ], [ %52, %if.end269 ], !dbg !85
  %acc_o.sroa.34.0 = phi <4 x float> [ zeroinitializer, %if.end211 ], [ %51, %if.end269 ], !dbg !85
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end211 ], [ %50, %if.end269 ], !dbg !85
  %sum_acc.sroa.56.0 = phi float [ 0.000000e+00, %if.end211 ], [ %41, %if.end269 ], !dbg !85
  %sum_acc.sroa.38.0 = phi float [ 0.000000e+00, %if.end211 ], [ %39, %if.end269 ], !dbg !85
  %sum_acc.sroa.20.0 = phi float [ 0.000000e+00, %if.end211 ], [ %37, %if.end269 ], !dbg !85
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %if.end211 ], [ %35, %if.end269 ], !dbg !85
  br i1 %or.cond1251, label %if.end502, label %for.cond364.preheader, !dbg !108

for.cond364.preheader:                            ; preds = %if.end356
  %54 = shl nsw i32 %cond.i.i1173.1, 10
  %mul371 = and i32 %54, 64512
  %add374 = add nuw nsw i32 %add104, %mul371
  %55 = zext nneg i32 %add374 to i64, !dbg !109
  %add.ptr379 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %55, !dbg !110
  %V_reg.sroa.0.0.copyload1809 = load <4 x half>, ptr addrspace(4) %add.ptr379, align 16, !dbg !111
  %V_reg.sroa.18.0.add.ptr379.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr379, i64 8, !dbg !111
  %V_reg.sroa.18.0.copyload1816 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr379.sroa_idx, align 8, !dbg !111
  %56 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %55, !dbg !110
  %add.ptr379.1 = getelementptr inbounds i8, ptr addrspace(4) %56, i64 1024, !dbg !110
  %V_reg.sroa.26.16.copyload1837 = load <4 x half>, ptr addrspace(4) %add.ptr379.1, align 16, !dbg !111
  %V_reg.sroa.42.16.add.ptr379.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %56, i64 1032, !dbg !111
  %V_reg.sroa.42.16.copyload1844 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr379.1.sroa_idx, align 8, !dbg !111
  %cmp389 = icmp sgt i32 %mul12.1, %invariant.op, !dbg !112
  br i1 %cmp389, label %for.cond391.preheader, label %if.end415, !dbg !113

for.cond391.preheader:                            ; preds = %for.cond364.preheader
  %add398 = add nuw nsw i32 %mul12.1, %mul252
  %cmp401.not = icmp sgt i32 %add398, %1, !dbg !114
  %fneg.1162 = select i1 %cmp401.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1446 = insertelement <4 x float> poison, float %fneg.1162, i64 0, !dbg !115
  %cmp401.not.1.not = icmp slt i32 %add398, %1, !dbg !114
  %fneg.1162.1 = select i1 %cmp401.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1547 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1446, float %fneg.1162.1, i64 1, !dbg !115
  %add399.2 = or disjoint i32 %add398, 2, !dbg !116
  %cmp401.not.2 = icmp sgt i32 %add399.2, %1, !dbg !114
  %fneg.1162.2 = select i1 %cmp401.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1640 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1547, float %fneg.1162.2, i64 2, !dbg !115
  %add399.3 = or disjoint i32 %add398, 3, !dbg !116
  %cmp401.not.3 = icmp sgt i32 %add399.3, %1, !dbg !114
  %fneg.1162.3 = select i1 %cmp401.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1733 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1640, float %fneg.1162.3, i64 3, !dbg !115
  br label %if.end415

if.end415:                                        ; preds = %for.cond364.preheader, %for.cond391.preheader
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1733, %for.cond391.preheader ], [ zeroinitializer, %for.cond364.preheader ], !dbg !85
  %57 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.2), !dbg !117, !call_argsrelate !87
  %58 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %57), !dbg !117, !call_argsrelate !87
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %58), !dbg !117, !call_argsrelate !87
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %59), !dbg !117, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract1448 = extractelement <4 x float> %60, i64 0, !dbg !118
  %mul450 = fmul contract float %acc_s.sroa.0.0.vec.extract1448, 0x3FB99999A0000000, !dbg !119
  %61 = tail call contract noundef float @llvm.minnum.f32(float %mul450, float 0x4024CB5EC0000000), !dbg !120
  %62 = tail call contract noundef float @llvm.exp.f32(float %61), !dbg !122
  %acc_s.sroa.0.4.vec.extract1549 = extractelement <4 x float> %60, i64 1, !dbg !118
  %mul450.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1549, 0x3FB99999A0000000, !dbg !119
  %63 = tail call contract noundef float @llvm.minnum.f32(float %mul450.1, float 0x4024CB5EC0000000), !dbg !120
  %64 = tail call contract noundef float @llvm.exp.f32(float %63), !dbg !122
  %acc_s.sroa.0.8.vec.extract1642 = extractelement <4 x float> %60, i64 2, !dbg !118
  %mul450.2 = fmul contract float %acc_s.sroa.0.8.vec.extract1642, 0x3FB99999A0000000, !dbg !119
  %65 = tail call contract noundef float @llvm.minnum.f32(float %mul450.2, float 0x4024CB5EC0000000), !dbg !120
  %66 = tail call contract noundef float @llvm.exp.f32(float %65), !dbg !122
  %acc_s.sroa.0.12.vec.extract1735 = extractelement <4 x float> %60, i64 3, !dbg !118
  %mul450.3 = fmul contract float %acc_s.sroa.0.12.vec.extract1735, 0x3FB99999A0000000, !dbg !119
  %67 = tail call contract noundef float @llvm.minnum.f32(float %mul450.3, float 0x4024CB5EC0000000), !dbg !120
  %68 = tail call contract noundef float @llvm.exp.f32(float %67), !dbg !122
  %add466 = fadd contract float %sum_acc.sroa.0.0, %62, !dbg !124
  %add466.1 = fadd contract float %sum_acc.sroa.20.0, %64, !dbg !124
  %add466.2 = fadd contract float %sum_acc.sroa.38.0, %66, !dbg !124
  %add466.3 = fadd contract float %sum_acc.sroa.56.0, %68, !dbg !124
  %69 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %62), !dbg !125
  %70 = insertelement <4 x i16> poison, i16 %69, i64 0, !dbg !129
  %71 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %64), !dbg !125
  %72 = insertelement <4 x i16> %70, i16 %71, i64 1, !dbg !129
  %73 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %66), !dbg !125
  %74 = insertelement <4 x i16> %72, i16 %73, i64 2, !dbg !129
  %75 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %68), !dbg !125
  %76 = insertelement <4 x i16> %74, i16 %75, i64 3, !dbg !129
  %acc_s_cast.sroa.0.6.vec.insert1409 = bitcast <4 x i16> %76 to <4 x half>, !dbg !129
  %77 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1809, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1409, <4 x float> zeroinitializer), !dbg !130, !call_argsrelate !107
  %78 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1816, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1409, <4 x float> zeroinitializer), !dbg !130, !call_argsrelate !107
  %79 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1837, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1409, <4 x float> zeroinitializer), !dbg !130, !call_argsrelate !107
  %80 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1844, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1409, <4 x float> zeroinitializer), !dbg !130, !call_argsrelate !107
  br label %if.end502, !dbg !131

if.end502:                                        ; preds = %if.end415, %if.end356
  %acc_o_alt.sroa.50.0 = phi <4 x float> [ zeroinitializer, %if.end356 ], [ %80, %if.end415 ], !dbg !85
  %acc_o_alt.sroa.34.0 = phi <4 x float> [ zeroinitializer, %if.end356 ], [ %79, %if.end415 ], !dbg !85
  %acc_o_alt.sroa.18.0 = phi <4 x float> [ zeroinitializer, %if.end356 ], [ %78, %if.end415 ], !dbg !85
  %acc_o_alt.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end356 ], [ %77, %if.end415 ], !dbg !85
  %sum_acc.sroa.56.1 = phi float [ %sum_acc.sroa.56.0, %if.end356 ], [ %add466.3, %if.end415 ], !dbg !85
  %sum_acc.sroa.38.1 = phi float [ %sum_acc.sroa.38.0, %if.end356 ], [ %add466.2, %if.end415 ], !dbg !85
  %sum_acc.sroa.20.1 = phi float [ %sum_acc.sroa.20.0, %if.end356 ], [ %add466.1, %if.end415 ], !dbg !85
  %sum_acc.sroa.0.1 = phi float [ %sum_acc.sroa.0.0, %if.end356 ], [ %add466, %if.end415 ], !dbg !85
  br i1 %or.cond1253, label %if.end648, label %for.cond510.preheader, !dbg !131

for.cond510.preheader:                            ; preds = %if.end502
  %81 = shl nsw i32 %cond.i.i1173.2, 10
  %mul517 = and i32 %81, 64512
  %add520 = add nuw nsw i32 %add104, %mul517
  %82 = zext nneg i32 %add520 to i64, !dbg !132
  %add.ptr525 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %82, !dbg !133
  %V_reg.sroa.0.0.copyload1810 = load <4 x half>, ptr addrspace(4) %add.ptr525, align 16, !dbg !134
  %V_reg.sroa.18.0.add.ptr525.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr525, i64 8, !dbg !134
  %V_reg.sroa.18.0.copyload1817 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr525.sroa_idx, align 8, !dbg !134
  %83 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %82, !dbg !133
  %add.ptr525.1 = getelementptr inbounds i8, ptr addrspace(4) %83, i64 1024, !dbg !133
  %V_reg.sroa.26.16.copyload1838 = load <4 x half>, ptr addrspace(4) %add.ptr525.1, align 16, !dbg !134
  %V_reg.sroa.42.16.add.ptr525.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %83, i64 1032, !dbg !134
  %V_reg.sroa.42.16.copyload1845 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr525.1.sroa_idx, align 8, !dbg !134
  %cmp535 = icmp sgt i32 %mul12.2, %invariant.op, !dbg !135
  br i1 %cmp535, label %for.cond537.preheader, label %if.end561, !dbg !136

for.cond537.preheader:                            ; preds = %for.cond510.preheader
  %add544 = add nuw nsw i32 %mul12.2, %mul252
  %cmp547.not = icmp sgt i32 %add544, %1, !dbg !137
  %fneg.1163 = select i1 %cmp547.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1456 = insertelement <4 x float> poison, float %fneg.1163, i64 0, !dbg !138
  %cmp547.not.1.not = icmp slt i32 %add544, %1, !dbg !137
  %fneg.1163.1 = select i1 %cmp547.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1557 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1456, float %fneg.1163.1, i64 1, !dbg !138
  %add545.2 = or disjoint i32 %add544, 2, !dbg !139
  %cmp547.not.2 = icmp sgt i32 %add545.2, %1, !dbg !137
  %fneg.1163.2 = select i1 %cmp547.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1650 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1557, float %fneg.1163.2, i64 2, !dbg !138
  %add545.3 = or disjoint i32 %add544, 3, !dbg !139
  %cmp547.not.3 = icmp sgt i32 %add545.3, %1, !dbg !137
  %fneg.1163.3 = select i1 %cmp547.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1743 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1650, float %fneg.1163.3, i64 3, !dbg !138
  br label %if.end561

if.end561:                                        ; preds = %for.cond510.preheader, %for.cond537.preheader
  %acc_s.sroa.0.4 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1743, %for.cond537.preheader ], [ zeroinitializer, %for.cond510.preheader ], !dbg !85
  %84 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.4), !dbg !140, !call_argsrelate !87
  %85 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %84), !dbg !140, !call_argsrelate !87
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %85), !dbg !140, !call_argsrelate !87
  %87 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %86), !dbg !140, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract1458 = extractelement <4 x float> %87, i64 0, !dbg !141
  %mul596 = fmul contract float %acc_s.sroa.0.0.vec.extract1458, 0x3FB99999A0000000, !dbg !142
  %88 = tail call contract noundef float @llvm.minnum.f32(float %mul596, float 0x4024CB5EC0000000), !dbg !143
  %89 = tail call contract noundef float @llvm.exp.f32(float %88), !dbg !145
  %acc_s.sroa.0.4.vec.extract1559 = extractelement <4 x float> %87, i64 1, !dbg !141
  %mul596.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1559, 0x3FB99999A0000000, !dbg !142
  %90 = tail call contract noundef float @llvm.minnum.f32(float %mul596.1, float 0x4024CB5EC0000000), !dbg !143
  %91 = tail call contract noundef float @llvm.exp.f32(float %90), !dbg !145
  %acc_s.sroa.0.8.vec.extract1652 = extractelement <4 x float> %87, i64 2, !dbg !141
  %mul596.2 = fmul contract float %acc_s.sroa.0.8.vec.extract1652, 0x3FB99999A0000000, !dbg !142
  %92 = tail call contract noundef float @llvm.minnum.f32(float %mul596.2, float 0x4024CB5EC0000000), !dbg !143
  %93 = tail call contract noundef float @llvm.exp.f32(float %92), !dbg !145
  %acc_s.sroa.0.12.vec.extract1745 = extractelement <4 x float> %87, i64 3, !dbg !141
  %mul596.3 = fmul contract float %acc_s.sroa.0.12.vec.extract1745, 0x3FB99999A0000000, !dbg !142
  %94 = tail call contract noundef float @llvm.minnum.f32(float %mul596.3, float 0x4024CB5EC0000000), !dbg !143
  %95 = tail call contract noundef float @llvm.exp.f32(float %94), !dbg !145
  %add612 = fadd contract float %sum_acc.sroa.0.1, %89, !dbg !147
  %add612.1 = fadd contract float %sum_acc.sroa.20.1, %91, !dbg !147
  %add612.2 = fadd contract float %sum_acc.sroa.38.1, %93, !dbg !147
  %add612.3 = fadd contract float %sum_acc.sroa.56.1, %95, !dbg !147
  %96 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %89), !dbg !148
  %97 = insertelement <4 x i16> poison, i16 %96, i64 0, !dbg !152
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %91), !dbg !148
  %99 = insertelement <4 x i16> %97, i16 %98, i64 1, !dbg !152
  %100 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %93), !dbg !148
  %101 = insertelement <4 x i16> %99, i16 %100, i64 2, !dbg !152
  %102 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %95), !dbg !148
  %103 = insertelement <4 x i16> %101, i16 %102, i64 3, !dbg !152
  %acc_s_cast.sroa.0.6.vec.insert1411 = bitcast <4 x i16> %103 to <4 x half>, !dbg !152
  %104 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1810, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1411, <4 x float> %acc_o.sroa.0.0), !dbg !153, !call_argsrelate !107
  %105 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1817, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1411, <4 x float> %acc_o.sroa.34.0), !dbg !153, !call_argsrelate !107
  %106 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1838, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1411, <4 x float> %acc_o.sroa.66.0), !dbg !153, !call_argsrelate !107
  %107 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1845, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1411, <4 x float> %acc_o.sroa.98.0), !dbg !153, !call_argsrelate !107
  br label %if.end648, !dbg !154

if.end648:                                        ; preds = %if.end561, %if.end502
  %acc_o.sroa.98.1 = phi <4 x float> [ %acc_o.sroa.98.0, %if.end502 ], [ %107, %if.end561 ], !dbg !85
  %acc_o.sroa.66.1 = phi <4 x float> [ %acc_o.sroa.66.0, %if.end502 ], [ %106, %if.end561 ], !dbg !85
  %acc_o.sroa.34.1 = phi <4 x float> [ %acc_o.sroa.34.0, %if.end502 ], [ %105, %if.end561 ], !dbg !85
  %acc_o.sroa.0.1 = phi <4 x float> [ %acc_o.sroa.0.0, %if.end502 ], [ %104, %if.end561 ], !dbg !85
  %sum_acc.sroa.56.2 = phi float [ %sum_acc.sroa.56.1, %if.end502 ], [ %add612.3, %if.end561 ], !dbg !85
  %sum_acc.sroa.38.2 = phi float [ %sum_acc.sroa.38.1, %if.end502 ], [ %add612.2, %if.end561 ], !dbg !85
  %sum_acc.sroa.20.2 = phi float [ %sum_acc.sroa.20.1, %if.end502 ], [ %add612.1, %if.end561 ], !dbg !85
  %sum_acc.sroa.0.2 = phi float [ %sum_acc.sroa.0.1, %if.end502 ], [ %add612, %if.end561 ], !dbg !85
  br i1 %or.cond1255, label %if.end794, label %for.cond656.preheader, !dbg !154

for.cond656.preheader:                            ; preds = %if.end648
  %108 = shl nsw i32 %cond.i.i1173.3, 10
  %mul663 = and i32 %108, 64512
  %add666 = add nuw nsw i32 %add104, %mul663
  %109 = zext nneg i32 %add666 to i64, !dbg !155
  %add.ptr671 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %109, !dbg !156
  %V_reg.sroa.0.0.copyload1811 = load <4 x half>, ptr addrspace(4) %add.ptr671, align 16, !dbg !157
  %V_reg.sroa.18.0.add.ptr671.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr671, i64 8, !dbg !157
  %V_reg.sroa.18.0.copyload1818 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr671.sroa_idx, align 8, !dbg !157
  %110 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %109, !dbg !156
  %add.ptr671.1 = getelementptr inbounds i8, ptr addrspace(4) %110, i64 1024, !dbg !156
  %V_reg.sroa.26.16.copyload1839 = load <4 x half>, ptr addrspace(4) %add.ptr671.1, align 16, !dbg !157
  %V_reg.sroa.42.16.add.ptr671.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %110, i64 1032, !dbg !157
  %V_reg.sroa.42.16.copyload1846 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr671.1.sroa_idx, align 8, !dbg !157
  %cmp681 = icmp sgt i32 %mul12.3, %invariant.op, !dbg !158
  br i1 %cmp681, label %for.cond683.preheader, label %if.end707, !dbg !159

for.cond683.preheader:                            ; preds = %for.cond656.preheader
  %add690 = add nuw nsw i32 %mul12.3, %mul252
  %cmp693.not = icmp sgt i32 %add690, %1, !dbg !160
  %fneg.1164 = select i1 %cmp693.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1466 = insertelement <4 x float> poison, float %fneg.1164, i64 0, !dbg !161
  %cmp693.not.1.not = icmp slt i32 %add690, %1, !dbg !160
  %fneg.1164.1 = select i1 %cmp693.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1567 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1466, float %fneg.1164.1, i64 1, !dbg !161
  %add691.2 = or disjoint i32 %add690, 2, !dbg !162
  %cmp693.not.2 = icmp sgt i32 %add691.2, %1, !dbg !160
  %fneg.1164.2 = select i1 %cmp693.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1660 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1567, float %fneg.1164.2, i64 2, !dbg !161
  %add691.3 = or disjoint i32 %add690, 3, !dbg !162
  %cmp693.not.3 = icmp sgt i32 %add691.3, %1, !dbg !160
  %fneg.1164.3 = select i1 %cmp693.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1753 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1660, float %fneg.1164.3, i64 3, !dbg !161
  br label %if.end707

if.end707:                                        ; preds = %for.cond656.preheader, %for.cond683.preheader
  %acc_s.sroa.0.6 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1753, %for.cond683.preheader ], [ zeroinitializer, %for.cond656.preheader ], !dbg !85
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.6), !dbg !163, !call_argsrelate !87
  %112 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %111), !dbg !163, !call_argsrelate !87
  %113 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %112), !dbg !163, !call_argsrelate !87
  %114 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %113), !dbg !163, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract1468 = extractelement <4 x float> %114, i64 0, !dbg !164
  %mul742 = fmul contract float %acc_s.sroa.0.0.vec.extract1468, 0x3FB99999A0000000, !dbg !165
  %115 = tail call contract noundef float @llvm.minnum.f32(float %mul742, float 0x4024CB5EC0000000), !dbg !166
  %116 = tail call contract noundef float @llvm.exp.f32(float %115), !dbg !168
  %acc_s.sroa.0.4.vec.extract1569 = extractelement <4 x float> %114, i64 1, !dbg !164
  %mul742.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1569, 0x3FB99999A0000000, !dbg !165
  %117 = tail call contract noundef float @llvm.minnum.f32(float %mul742.1, float 0x4024CB5EC0000000), !dbg !166
  %118 = tail call contract noundef float @llvm.exp.f32(float %117), !dbg !168
  %acc_s.sroa.0.8.vec.extract1662 = extractelement <4 x float> %114, i64 2, !dbg !164
  %mul742.2 = fmul contract float %acc_s.sroa.0.8.vec.extract1662, 0x3FB99999A0000000, !dbg !165
  %119 = tail call contract noundef float @llvm.minnum.f32(float %mul742.2, float 0x4024CB5EC0000000), !dbg !166
  %120 = tail call contract noundef float @llvm.exp.f32(float %119), !dbg !168
  %acc_s.sroa.0.12.vec.extract1755 = extractelement <4 x float> %114, i64 3, !dbg !164
  %mul742.3 = fmul contract float %acc_s.sroa.0.12.vec.extract1755, 0x3FB99999A0000000, !dbg !165
  %121 = tail call contract noundef float @llvm.minnum.f32(float %mul742.3, float 0x4024CB5EC0000000), !dbg !166
  %122 = tail call contract noundef float @llvm.exp.f32(float %121), !dbg !168
  %add758 = fadd contract float %sum_acc.sroa.0.2, %116, !dbg !170
  %add758.1 = fadd contract float %sum_acc.sroa.20.2, %118, !dbg !170
  %add758.2 = fadd contract float %sum_acc.sroa.38.2, %120, !dbg !170
  %add758.3 = fadd contract float %sum_acc.sroa.56.2, %122, !dbg !170
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %116), !dbg !171
  %124 = insertelement <4 x i16> poison, i16 %123, i64 0, !dbg !175
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %118), !dbg !171
  %126 = insertelement <4 x i16> %124, i16 %125, i64 1, !dbg !175
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %120), !dbg !171
  %128 = insertelement <4 x i16> %126, i16 %127, i64 2, !dbg !175
  %129 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %122), !dbg !171
  %130 = insertelement <4 x i16> %128, i16 %129, i64 3, !dbg !175
  %acc_s_cast.sroa.0.6.vec.insert1413 = bitcast <4 x i16> %130 to <4 x half>, !dbg !175
  %131 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1811, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1413, <4 x float> %acc_o_alt.sroa.0.0), !dbg !176, !call_argsrelate !107
  %132 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1818, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1413, <4 x float> %acc_o_alt.sroa.18.0), !dbg !176, !call_argsrelate !107
  %133 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1839, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1413, <4 x float> %acc_o_alt.sroa.34.0), !dbg !176, !call_argsrelate !107
  %134 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1846, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1413, <4 x float> %acc_o_alt.sroa.50.0), !dbg !176, !call_argsrelate !107
  br label %if.end794, !dbg !177

if.end794:                                        ; preds = %if.end707, %if.end648
  %acc_o_alt.sroa.50.1 = phi <4 x float> [ %acc_o_alt.sroa.50.0, %if.end648 ], [ %134, %if.end707 ], !dbg !85
  %acc_o_alt.sroa.34.1 = phi <4 x float> [ %acc_o_alt.sroa.34.0, %if.end648 ], [ %133, %if.end707 ], !dbg !85
  %acc_o_alt.sroa.18.1 = phi <4 x float> [ %acc_o_alt.sroa.18.0, %if.end648 ], [ %132, %if.end707 ], !dbg !85
  %acc_o_alt.sroa.0.1 = phi <4 x float> [ %acc_o_alt.sroa.0.0, %if.end648 ], [ %131, %if.end707 ], !dbg !85
  %sum_acc.sroa.56.3 = phi float [ %sum_acc.sroa.56.2, %if.end648 ], [ %add758.3, %if.end707 ], !dbg !85
  %sum_acc.sroa.38.3 = phi float [ %sum_acc.sroa.38.2, %if.end648 ], [ %add758.2, %if.end707 ], !dbg !85
  %sum_acc.sroa.20.3 = phi float [ %sum_acc.sroa.20.2, %if.end648 ], [ %add758.1, %if.end707 ], !dbg !85
  %sum_acc.sroa.0.3 = phi float [ %sum_acc.sroa.0.2, %if.end648 ], [ %add758, %if.end707 ], !dbg !85
  %or.cond.1 = icmp ugt i32 %mul12.4, 1023, !dbg !60
  %cmp95.not.1 = icmp sgt i32 %mul12.4, %1
  %or.cond1249.1 = or i1 %or.cond.1, %cmp95.not.1, !dbg !60
  br i1 %or.cond1249.1, label %if.end.1, label %for.cond96.preheader.1, !dbg !60

for.cond96.preheader.1:                           ; preds = %if.end794
  %135 = shl nsw i32 %cond.i.i1173.4, 10
  %mul103.1 = and i32 %135, 64512
  %add106.1 = add nuw nsw i32 %add104, %mul103.1
  %136 = zext nneg i32 %add106.1 to i64, !dbg !61
  %add.ptr111.11313 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %136, !dbg !62
  %K_reg.sroa.0.0.copyload1883 = load <4 x half>, ptr addrspace(4) %add.ptr111.11313, align 16, !dbg !63
  %K_reg.sroa.6.0.add.ptr111.11313.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr111.11313, i64 8, !dbg !63
  %K_reg.sroa.6.0.copyload1884 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.6.0.add.ptr111.11313.sroa_idx, align 8, !dbg !63
  %137 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %136, !dbg !62
  %add.ptr111.1.1 = getelementptr inbounds i8, ptr addrspace(4) %137, i64 1024, !dbg !62
  %K_reg.sroa.8.16.copyload1887 = load <4 x half>, ptr addrspace(4) %add.ptr111.1.1, align 16, !dbg !63
  %K_reg.sroa.12.16.add.ptr111.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %137, i64 1032, !dbg !63
  %K_reg.sroa.12.16.copyload1888 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.12.16.add.ptr111.1.1.sroa_idx, align 8, !dbg !63
  br label %if.end.1, !dbg !64

if.end.1:                                         ; preds = %for.cond96.preheader.1, %if.end794
  %K_reg.sroa.12.1 = phi <4 x half> [ %K_reg.sroa.12.0, %if.end794 ], [ %K_reg.sroa.12.16.copyload1888, %for.cond96.preheader.1 ]
  %K_reg.sroa.8.1 = phi <4 x half> [ %K_reg.sroa.8.0, %if.end794 ], [ %K_reg.sroa.8.16.copyload1887, %for.cond96.preheader.1 ]
  %K_reg.sroa.6.1 = phi <4 x half> [ %K_reg.sroa.6.0, %if.end794 ], [ %K_reg.sroa.6.0.copyload1884, %for.cond96.preheader.1 ]
  %K_reg.sroa.0.1 = phi <4 x half> [ %K_reg.sroa.0.0, %if.end794 ], [ %K_reg.sroa.0.0.copyload1883, %for.cond96.preheader.1 ]
  %or.cond1250.1 = icmp ugt i32 %mul12.5, 1023, !dbg !64
  %cmp124.not.1 = icmp sgt i32 %mul12.5, %1
  %or.cond1251.1 = or i1 %or.cond1250.1, %cmp124.not.1, !dbg !64
  br i1 %or.cond1251.1, label %if.end149.1, label %for.cond126.preheader.1, !dbg !64

for.cond126.preheader.1:                          ; preds = %if.end.1
  %138 = shl nsw i32 %cond.i.i1173.5, 10
  %mul133.1 = and i32 %138, 64512
  %add136.1 = add nuw nsw i32 %add104, %mul133.1
  %139 = zext nneg i32 %add136.1 to i64, !dbg !65
  %add.ptr141.11314 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %139, !dbg !66
  %K_reg1.sroa.0.0.copyload1875 = load <4 x half>, ptr addrspace(4) %add.ptr141.11314, align 16, !dbg !67
  %K_reg1.sroa.6.0.add.ptr141.11314.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr141.11314, i64 8, !dbg !67
  %K_reg1.sroa.6.0.copyload1876 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.6.0.add.ptr141.11314.sroa_idx, align 8, !dbg !67
  %140 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %139, !dbg !66
  %add.ptr141.1.1 = getelementptr inbounds i8, ptr addrspace(4) %140, i64 1024, !dbg !66
  %K_reg1.sroa.8.16.copyload1879 = load <4 x half>, ptr addrspace(4) %add.ptr141.1.1, align 16, !dbg !67
  %K_reg1.sroa.12.16.add.ptr141.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %140, i64 1032, !dbg !67
  %K_reg1.sroa.12.16.copyload1880 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.12.16.add.ptr141.1.1.sroa_idx, align 8, !dbg !67
  br label %if.end149.1, !dbg !68

if.end149.1:                                      ; preds = %for.cond126.preheader.1, %if.end.1
  %K_reg1.sroa.12.1 = phi <4 x half> [ %K_reg1.sroa.12.0, %if.end.1 ], [ %K_reg1.sroa.12.16.copyload1880, %for.cond126.preheader.1 ]
  %K_reg1.sroa.8.1 = phi <4 x half> [ %K_reg1.sroa.8.0, %if.end.1 ], [ %K_reg1.sroa.8.16.copyload1879, %for.cond126.preheader.1 ]
  %K_reg1.sroa.6.1 = phi <4 x half> [ %K_reg1.sroa.6.0, %if.end.1 ], [ %K_reg1.sroa.6.0.copyload1876, %for.cond126.preheader.1 ]
  %K_reg1.sroa.0.1 = phi <4 x half> [ %K_reg1.sroa.0.0, %if.end.1 ], [ %K_reg1.sroa.0.0.copyload1875, %for.cond126.preheader.1 ]
  %or.cond1252.1 = icmp ugt i32 %mul12.6, 1023, !dbg !68
  %cmp155.not.1 = icmp sgt i32 %mul12.6, %1
  %or.cond1253.1 = or i1 %or.cond1252.1, %cmp155.not.1, !dbg !68
  br i1 %or.cond1253.1, label %if.end180.1, label %for.cond157.preheader.1, !dbg !68

for.cond157.preheader.1:                          ; preds = %if.end149.1
  %141 = shl nsw i32 %cond.i.i1173.6, 10
  %mul164.1 = and i32 %141, 64512
  %add167.1 = add nuw nsw i32 %add104, %mul164.1
  %142 = zext nneg i32 %add167.1 to i64, !dbg !69
  %add.ptr172.11315 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %142, !dbg !70
  %K_reg2.sroa.0.0.copyload1867 = load <4 x half>, ptr addrspace(4) %add.ptr172.11315, align 16, !dbg !71
  %K_reg2.sroa.6.0.add.ptr172.11315.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr172.11315, i64 8, !dbg !71
  %K_reg2.sroa.6.0.copyload1868 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.6.0.add.ptr172.11315.sroa_idx, align 8, !dbg !71
  %143 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %142, !dbg !70
  %add.ptr172.1.1 = getelementptr inbounds i8, ptr addrspace(4) %143, i64 1024, !dbg !70
  %K_reg2.sroa.8.16.copyload1871 = load <4 x half>, ptr addrspace(4) %add.ptr172.1.1, align 16, !dbg !71
  %K_reg2.sroa.12.16.add.ptr172.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %143, i64 1032, !dbg !71
  %K_reg2.sroa.12.16.copyload1872 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.12.16.add.ptr172.1.1.sroa_idx, align 8, !dbg !71
  br label %if.end180.1, !dbg !72

if.end180.1:                                      ; preds = %for.cond157.preheader.1, %if.end149.1
  %K_reg2.sroa.12.1 = phi <4 x half> [ %K_reg2.sroa.12.0, %if.end149.1 ], [ %K_reg2.sroa.12.16.copyload1872, %for.cond157.preheader.1 ]
  %K_reg2.sroa.8.1 = phi <4 x half> [ %K_reg2.sroa.8.0, %if.end149.1 ], [ %K_reg2.sroa.8.16.copyload1871, %for.cond157.preheader.1 ]
  %K_reg2.sroa.6.1 = phi <4 x half> [ %K_reg2.sroa.6.0, %if.end149.1 ], [ %K_reg2.sroa.6.0.copyload1868, %for.cond157.preheader.1 ]
  %K_reg2.sroa.0.1 = phi <4 x half> [ %K_reg2.sroa.0.0, %if.end149.1 ], [ %K_reg2.sroa.0.0.copyload1867, %for.cond157.preheader.1 ]
  %or.cond1254.1 = icmp ugt i32 %mul12.7, 1023, !dbg !72
  %cmp186.not.1 = icmp sgt i32 %mul12.7, %1
  %or.cond1255.1 = or i1 %or.cond1254.1, %cmp186.not.1, !dbg !72
  br i1 %or.cond1255.1, label %if.end211.1, label %for.cond188.preheader.1, !dbg !72

for.cond188.preheader.1:                          ; preds = %if.end180.1
  %144 = shl nsw i32 %cond.i.i1173.7, 10
  %mul195.1 = and i32 %144, 64512
  %add198.1 = add nuw nsw i32 %add104, %mul195.1
  %145 = zext nneg i32 %add198.1 to i64, !dbg !73
  %add.ptr203.11316 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %145, !dbg !74
  %K_reg3.sroa.0.0.copyload1859 = load <4 x half>, ptr addrspace(4) %add.ptr203.11316, align 16, !dbg !75
  %K_reg3.sroa.6.0.add.ptr203.11316.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr203.11316, i64 8, !dbg !75
  %K_reg3.sroa.6.0.copyload1860 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.6.0.add.ptr203.11316.sroa_idx, align 8, !dbg !75
  %146 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %145, !dbg !74
  %add.ptr203.1.1 = getelementptr inbounds i8, ptr addrspace(4) %146, i64 1024, !dbg !74
  %K_reg3.sroa.8.16.copyload1863 = load <4 x half>, ptr addrspace(4) %add.ptr203.1.1, align 16, !dbg !75
  %K_reg3.sroa.12.16.add.ptr203.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %146, i64 1032, !dbg !75
  %K_reg3.sroa.12.16.copyload1864 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.12.16.add.ptr203.1.1.sroa_idx, align 8, !dbg !75
  br label %if.end211.1, !dbg !76

if.end211.1:                                      ; preds = %for.cond188.preheader.1, %if.end180.1
  %K_reg3.sroa.12.1 = phi <4 x half> [ %K_reg3.sroa.12.0, %if.end180.1 ], [ %K_reg3.sroa.12.16.copyload1864, %for.cond188.preheader.1 ]
  %K_reg3.sroa.8.1 = phi <4 x half> [ %K_reg3.sroa.8.0, %if.end180.1 ], [ %K_reg3.sroa.8.16.copyload1863, %for.cond188.preheader.1 ]
  %K_reg3.sroa.6.1 = phi <4 x half> [ %K_reg3.sroa.6.0, %if.end180.1 ], [ %K_reg3.sroa.6.0.copyload1860, %for.cond188.preheader.1 ]
  %K_reg3.sroa.0.1 = phi <4 x half> [ %K_reg3.sroa.0.0, %if.end180.1 ], [ %K_reg3.sroa.0.0.copyload1859, %for.cond188.preheader.1 ]
  br i1 %or.cond1249.1, label %if.end356.1, label %for.cond219.preheader.1, !dbg !76

for.cond219.preheader.1:                          ; preds = %if.end211.1
  %147 = shl nsw i32 %cond.i.i1173.4, 10
  %mul226.1 = and i32 %147, 64512
  %add229.1 = add nuw nsw i32 %add104, %mul226.1
  %148 = zext nneg i32 %add229.1 to i64, !dbg !77
  %add.ptr234.11317 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %148, !dbg !78
  %V_reg.sroa.0.0.copyload1812 = load <4 x half>, ptr addrspace(4) %add.ptr234.11317, align 16, !dbg !79
  %V_reg.sroa.18.0.add.ptr234.11317.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr234.11317, i64 8, !dbg !79
  %V_reg.sroa.18.0.copyload1819 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr234.11317.sroa_idx, align 8, !dbg !79
  %149 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %148, !dbg !78
  %add.ptr234.1.1 = getelementptr inbounds i8, ptr addrspace(4) %149, i64 1024, !dbg !78
  %V_reg.sroa.26.16.copyload1840 = load <4 x half>, ptr addrspace(4) %add.ptr234.1.1, align 16, !dbg !79
  %V_reg.sroa.42.16.add.ptr234.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %149, i64 1032, !dbg !79
  %V_reg.sroa.42.16.copyload1847 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr234.1.1.sroa_idx, align 8, !dbg !79
  %cmp244.1 = icmp sgt i32 %mul12.4, %invariant.op, !dbg !80
  br i1 %cmp244.1, label %for.cond246.preheader.1, label %if.end269.1, !dbg !81

for.cond246.preheader.1:                          ; preds = %for.cond219.preheader.1
  %add253.1 = add nuw nsw i32 %mul12.4, %mul252
  %cmp256.not.11318 = icmp sgt i32 %add253.1, %1, !dbg !82
  %fneg..11319 = select i1 %cmp256.not.11318, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1478 = insertelement <4 x float> poison, float %fneg..11319, i64 0, !dbg !83
  %cmp256.not.1.1.not = icmp slt i32 %add253.1, %1, !dbg !82
  %fneg..1.1 = select i1 %cmp256.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1577 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1478, float %fneg..1.1, i64 1, !dbg !83
  %add254.2.1 = or disjoint i32 %add253.1, 2, !dbg !84
  %cmp256.not.2.1 = icmp sgt i32 %add254.2.1, %1, !dbg !82
  %fneg..2.1 = select i1 %cmp256.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1670 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1577, float %fneg..2.1, i64 2, !dbg !83
  %add254.3.1 = or disjoint i32 %add253.1, 3, !dbg !84
  %cmp256.not.3.1 = icmp sgt i32 %add254.3.1, %1, !dbg !82
  %fneg..3.1 = select i1 %cmp256.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1763 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1670, float %fneg..3.1, i64 3, !dbg !83
  br label %if.end269.1

if.end269.1:                                      ; preds = %for.cond219.preheader.1, %for.cond246.preheader.1
  %acc_s.sroa.0.8 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1763, %for.cond246.preheader.1 ], [ zeroinitializer, %for.cond219.preheader.1 ], !dbg !85
  %150 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.8), !dbg !86, !call_argsrelate !87
  %151 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %150), !dbg !86, !call_argsrelate !87
  %152 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %151), !dbg !86, !call_argsrelate !87
  %153 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %152), !dbg !86, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract1480 = extractelement <4 x float> %153, i64 0, !dbg !88
  %mul304.11323 = fmul contract float %acc_s.sroa.0.0.vec.extract1480, 0x3FB99999A0000000, !dbg !89
  %154 = tail call contract noundef float @llvm.minnum.f32(float %mul304.11323, float 0x4024CB5EC0000000), !dbg !90
  %155 = tail call contract noundef float @llvm.exp.f32(float %154), !dbg !93
  %acc_s.sroa.0.4.vec.extract1579 = extractelement <4 x float> %153, i64 1, !dbg !88
  %mul304.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1579, 0x3FB99999A0000000, !dbg !89
  %156 = tail call contract noundef float @llvm.minnum.f32(float %mul304.1.1, float 0x4024CB5EC0000000), !dbg !90
  %157 = tail call contract noundef float @llvm.exp.f32(float %156), !dbg !93
  %acc_s.sroa.0.8.vec.extract1672 = extractelement <4 x float> %153, i64 2, !dbg !88
  %mul304.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1672, 0x3FB99999A0000000, !dbg !89
  %158 = tail call contract noundef float @llvm.minnum.f32(float %mul304.2.1, float 0x4024CB5EC0000000), !dbg !90
  %159 = tail call contract noundef float @llvm.exp.f32(float %158), !dbg !93
  %acc_s.sroa.0.12.vec.extract1765 = extractelement <4 x float> %153, i64 3, !dbg !88
  %mul304.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1765, 0x3FB99999A0000000, !dbg !89
  %160 = tail call contract noundef float @llvm.minnum.f32(float %mul304.3.1, float 0x4024CB5EC0000000), !dbg !90
  %161 = tail call contract noundef float @llvm.exp.f32(float %160), !dbg !93
  %add320.11324 = fadd contract float %sum_acc.sroa.0.3, %155, !dbg !178
  %add320.1.1 = fadd contract float %sum_acc.sroa.20.3, %157, !dbg !178
  %add320.2.1 = fadd contract float %sum_acc.sroa.38.3, %159, !dbg !178
  %add320.3.1 = fadd contract float %sum_acc.sroa.56.3, %161, !dbg !178
  %162 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %155), !dbg !96
  %163 = insertelement <4 x i16> poison, i16 %162, i64 0, !dbg !105
  %164 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %157), !dbg !96
  %165 = insertelement <4 x i16> %163, i16 %164, i64 1, !dbg !105
  %166 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %159), !dbg !96
  %167 = insertelement <4 x i16> %165, i16 %166, i64 2, !dbg !105
  %168 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %161), !dbg !96
  %169 = insertelement <4 x i16> %167, i16 %168, i64 3, !dbg !105
  %acc_s_cast.sroa.0.6.vec.insert1415 = bitcast <4 x i16> %169 to <4 x half>, !dbg !105
  %170 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1812, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1415, <4 x float> %acc_o.sroa.0.1), !dbg !106, !call_argsrelate !107
  %171 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1819, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1415, <4 x float> %acc_o.sroa.34.1), !dbg !106, !call_argsrelate !107
  %172 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1840, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1415, <4 x float> %acc_o.sroa.66.1), !dbg !106, !call_argsrelate !107
  %173 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1847, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1415, <4 x float> %acc_o.sroa.98.1), !dbg !106, !call_argsrelate !107
  br label %if.end356.1, !dbg !108

if.end356.1:                                      ; preds = %if.end269.1, %if.end211.1
  %acc_o.sroa.98.2 = phi <4 x float> [ %acc_o.sroa.98.1, %if.end211.1 ], [ %173, %if.end269.1 ], !dbg !85
  %acc_o.sroa.66.2 = phi <4 x float> [ %acc_o.sroa.66.1, %if.end211.1 ], [ %172, %if.end269.1 ], !dbg !85
  %acc_o.sroa.34.2 = phi <4 x float> [ %acc_o.sroa.34.1, %if.end211.1 ], [ %171, %if.end269.1 ], !dbg !85
  %acc_o.sroa.0.2 = phi <4 x float> [ %acc_o.sroa.0.1, %if.end211.1 ], [ %170, %if.end269.1 ], !dbg !85
  %sum_acc.sroa.56.4 = phi float [ %sum_acc.sroa.56.3, %if.end211.1 ], [ %add320.3.1, %if.end269.1 ], !dbg !85
  %sum_acc.sroa.38.4 = phi float [ %sum_acc.sroa.38.3, %if.end211.1 ], [ %add320.2.1, %if.end269.1 ], !dbg !85
  %sum_acc.sroa.20.4 = phi float [ %sum_acc.sroa.20.3, %if.end211.1 ], [ %add320.1.1, %if.end269.1 ], !dbg !85
  %sum_acc.sroa.0.4 = phi float [ %sum_acc.sroa.0.3, %if.end211.1 ], [ %add320.11324, %if.end269.1 ], !dbg !85
  br i1 %or.cond1251.1, label %if.end502.1, label %for.cond364.preheader.1, !dbg !108

for.cond364.preheader.1:                          ; preds = %if.end356.1
  %174 = shl nsw i32 %cond.i.i1173.5, 10
  %mul371.1 = and i32 %174, 64512
  %add374.1 = add nuw nsw i32 %add104, %mul371.1
  %175 = zext nneg i32 %add374.1 to i64, !dbg !109
  %add.ptr379.11325 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %175, !dbg !110
  %V_reg.sroa.0.0.copyload1813 = load <4 x half>, ptr addrspace(4) %add.ptr379.11325, align 16, !dbg !111
  %V_reg.sroa.18.0.add.ptr379.11325.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr379.11325, i64 8, !dbg !111
  %V_reg.sroa.18.0.copyload1820 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr379.11325.sroa_idx, align 8, !dbg !111
  %176 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %175, !dbg !110
  %add.ptr379.1.1 = getelementptr inbounds i8, ptr addrspace(4) %176, i64 1024, !dbg !110
  %V_reg.sroa.26.16.copyload1841 = load <4 x half>, ptr addrspace(4) %add.ptr379.1.1, align 16, !dbg !111
  %V_reg.sroa.42.16.add.ptr379.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %176, i64 1032, !dbg !111
  %V_reg.sroa.42.16.copyload1848 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr379.1.1.sroa_idx, align 8, !dbg !111
  %cmp389.1 = icmp sgt i32 %mul12.5, %invariant.op, !dbg !112
  br i1 %cmp389.1, label %for.cond391.preheader.1, label %if.end415.1, !dbg !113

for.cond391.preheader.1:                          ; preds = %for.cond364.preheader.1
  %add398.1 = add nuw nsw i32 %mul12.5, %mul252
  %cmp401.not.11326 = icmp sgt i32 %add398.1, %1, !dbg !114
  %fneg.1162.11327 = select i1 %cmp401.not.11326, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1490 = insertelement <4 x float> poison, float %fneg.1162.11327, i64 0, !dbg !115
  %cmp401.not.1.1.not = icmp slt i32 %add398.1, %1, !dbg !114
  %fneg.1162.1.1 = select i1 %cmp401.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1587 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1490, float %fneg.1162.1.1, i64 1, !dbg !115
  %add399.2.1 = or disjoint i32 %add398.1, 2, !dbg !116
  %cmp401.not.2.1 = icmp sgt i32 %add399.2.1, %1, !dbg !114
  %fneg.1162.2.1 = select i1 %cmp401.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1680 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1587, float %fneg.1162.2.1, i64 2, !dbg !115
  %add399.3.1 = or disjoint i32 %add398.1, 3, !dbg !116
  %cmp401.not.3.1 = icmp sgt i32 %add399.3.1, %1, !dbg !114
  %fneg.1162.3.1 = select i1 %cmp401.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1773 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1680, float %fneg.1162.3.1, i64 3, !dbg !115
  br label %if.end415.1

if.end415.1:                                      ; preds = %for.cond364.preheader.1, %for.cond391.preheader.1
  %acc_s.sroa.0.10 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1773, %for.cond391.preheader.1 ], [ zeroinitializer, %for.cond364.preheader.1 ], !dbg !85
  %177 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.10), !dbg !117, !call_argsrelate !87
  %178 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %177), !dbg !117, !call_argsrelate !87
  %179 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %178), !dbg !117, !call_argsrelate !87
  %180 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %179), !dbg !117, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract1492 = extractelement <4 x float> %180, i64 0, !dbg !118
  %mul450.11331 = fmul contract float %acc_s.sroa.0.0.vec.extract1492, 0x3FB99999A0000000, !dbg !119
  %181 = tail call contract noundef float @llvm.minnum.f32(float %mul450.11331, float 0x4024CB5EC0000000), !dbg !120
  %182 = tail call contract noundef float @llvm.exp.f32(float %181), !dbg !122
  %acc_s.sroa.0.4.vec.extract1589 = extractelement <4 x float> %180, i64 1, !dbg !118
  %mul450.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1589, 0x3FB99999A0000000, !dbg !119
  %183 = tail call contract noundef float @llvm.minnum.f32(float %mul450.1.1, float 0x4024CB5EC0000000), !dbg !120
  %184 = tail call contract noundef float @llvm.exp.f32(float %183), !dbg !122
  %acc_s.sroa.0.8.vec.extract1682 = extractelement <4 x float> %180, i64 2, !dbg !118
  %mul450.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1682, 0x3FB99999A0000000, !dbg !119
  %185 = tail call contract noundef float @llvm.minnum.f32(float %mul450.2.1, float 0x4024CB5EC0000000), !dbg !120
  %186 = tail call contract noundef float @llvm.exp.f32(float %185), !dbg !122
  %acc_s.sroa.0.12.vec.extract1775 = extractelement <4 x float> %180, i64 3, !dbg !118
  %mul450.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1775, 0x3FB99999A0000000, !dbg !119
  %187 = tail call contract noundef float @llvm.minnum.f32(float %mul450.3.1, float 0x4024CB5EC0000000), !dbg !120
  %188 = tail call contract noundef float @llvm.exp.f32(float %187), !dbg !122
  %add466.11332 = fadd contract float %sum_acc.sroa.0.4, %182, !dbg !124
  %add466.1.1 = fadd contract float %sum_acc.sroa.20.4, %184, !dbg !124
  %add466.2.1 = fadd contract float %sum_acc.sroa.38.4, %186, !dbg !124
  %add466.3.1 = fadd contract float %sum_acc.sroa.56.4, %188, !dbg !124
  %189 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %182), !dbg !125
  %190 = insertelement <4 x i16> poison, i16 %189, i64 0, !dbg !129
  %191 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %184), !dbg !125
  %192 = insertelement <4 x i16> %190, i16 %191, i64 1, !dbg !129
  %193 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %186), !dbg !125
  %194 = insertelement <4 x i16> %192, i16 %193, i64 2, !dbg !129
  %195 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %188), !dbg !125
  %196 = insertelement <4 x i16> %194, i16 %195, i64 3, !dbg !129
  %acc_s_cast.sroa.0.6.vec.insert1417 = bitcast <4 x i16> %196 to <4 x half>, !dbg !129
  %197 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1813, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1417, <4 x float> %acc_o_alt.sroa.0.1), !dbg !130, !call_argsrelate !107
  %198 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1820, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1417, <4 x float> %acc_o_alt.sroa.18.1), !dbg !130, !call_argsrelate !107
  %199 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1841, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1417, <4 x float> %acc_o_alt.sroa.34.1), !dbg !130, !call_argsrelate !107
  %200 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1848, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1417, <4 x float> %acc_o_alt.sroa.50.1), !dbg !130, !call_argsrelate !107
  br label %if.end502.1, !dbg !131

if.end502.1:                                      ; preds = %if.end415.1, %if.end356.1
  %acc_o_alt.sroa.50.2 = phi <4 x float> [ %acc_o_alt.sroa.50.1, %if.end356.1 ], [ %200, %if.end415.1 ], !dbg !85
  %acc_o_alt.sroa.34.2 = phi <4 x float> [ %acc_o_alt.sroa.34.1, %if.end356.1 ], [ %199, %if.end415.1 ], !dbg !85
  %acc_o_alt.sroa.18.2 = phi <4 x float> [ %acc_o_alt.sroa.18.1, %if.end356.1 ], [ %198, %if.end415.1 ], !dbg !85
  %acc_o_alt.sroa.0.2 = phi <4 x float> [ %acc_o_alt.sroa.0.1, %if.end356.1 ], [ %197, %if.end415.1 ], !dbg !85
  %sum_acc.sroa.56.5 = phi float [ %sum_acc.sroa.56.4, %if.end356.1 ], [ %add466.3.1, %if.end415.1 ], !dbg !85
  %sum_acc.sroa.38.5 = phi float [ %sum_acc.sroa.38.4, %if.end356.1 ], [ %add466.2.1, %if.end415.1 ], !dbg !85
  %sum_acc.sroa.20.5 = phi float [ %sum_acc.sroa.20.4, %if.end356.1 ], [ %add466.1.1, %if.end415.1 ], !dbg !85
  %sum_acc.sroa.0.5 = phi float [ %sum_acc.sroa.0.4, %if.end356.1 ], [ %add466.11332, %if.end415.1 ], !dbg !85
  br i1 %or.cond1253.1, label %if.end648.1, label %for.cond510.preheader.1, !dbg !131

for.cond510.preheader.1:                          ; preds = %if.end502.1
  %201 = shl nsw i32 %cond.i.i1173.6, 10
  %mul517.1 = and i32 %201, 64512
  %add520.1 = add nuw nsw i32 %add104, %mul517.1
  %202 = zext nneg i32 %add520.1 to i64, !dbg !132
  %add.ptr525.11333 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %202, !dbg !133
  %V_reg.sroa.0.0.copyload1814 = load <4 x half>, ptr addrspace(4) %add.ptr525.11333, align 16, !dbg !134
  %V_reg.sroa.18.0.add.ptr525.11333.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr525.11333, i64 8, !dbg !134
  %V_reg.sroa.18.0.copyload1821 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr525.11333.sroa_idx, align 8, !dbg !134
  %203 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %202, !dbg !133
  %add.ptr525.1.1 = getelementptr inbounds i8, ptr addrspace(4) %203, i64 1024, !dbg !133
  %V_reg.sroa.26.16.copyload1842 = load <4 x half>, ptr addrspace(4) %add.ptr525.1.1, align 16, !dbg !134
  %V_reg.sroa.42.16.add.ptr525.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %203, i64 1032, !dbg !134
  %V_reg.sroa.42.16.copyload1849 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr525.1.1.sroa_idx, align 8, !dbg !134
  %cmp535.1 = icmp sgt i32 %mul12.6, %invariant.op, !dbg !135
  br i1 %cmp535.1, label %for.cond537.preheader.1, label %if.end561.1, !dbg !136

for.cond537.preheader.1:                          ; preds = %for.cond510.preheader.1
  %add544.1 = add nuw nsw i32 %mul12.6, %mul252
  %cmp547.not.11334 = icmp sgt i32 %add544.1, %1, !dbg !137
  %fneg.1163.11335 = select i1 %cmp547.not.11334, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1502 = insertelement <4 x float> poison, float %fneg.1163.11335, i64 0, !dbg !138
  %cmp547.not.1.1.not = icmp slt i32 %add544.1, %1, !dbg !137
  %fneg.1163.1.1 = select i1 %cmp547.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1597 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1502, float %fneg.1163.1.1, i64 1, !dbg !138
  %add545.2.1 = or disjoint i32 %add544.1, 2, !dbg !139
  %cmp547.not.2.1 = icmp sgt i32 %add545.2.1, %1, !dbg !137
  %fneg.1163.2.1 = select i1 %cmp547.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1690 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1597, float %fneg.1163.2.1, i64 2, !dbg !138
  %add545.3.1 = or disjoint i32 %add544.1, 3, !dbg !139
  %cmp547.not.3.1 = icmp sgt i32 %add545.3.1, %1, !dbg !137
  %fneg.1163.3.1 = select i1 %cmp547.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1783 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1690, float %fneg.1163.3.1, i64 3, !dbg !138
  br label %if.end561.1

if.end561.1:                                      ; preds = %for.cond510.preheader.1, %for.cond537.preheader.1
  %acc_s.sroa.0.12 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1783, %for.cond537.preheader.1 ], [ zeroinitializer, %for.cond510.preheader.1 ], !dbg !85
  %204 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.12), !dbg !140, !call_argsrelate !87
  %205 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %204), !dbg !140, !call_argsrelate !87
  %206 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %205), !dbg !140, !call_argsrelate !87
  %207 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %206), !dbg !140, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract1504 = extractelement <4 x float> %207, i64 0, !dbg !141
  %mul596.11339 = fmul contract float %acc_s.sroa.0.0.vec.extract1504, 0x3FB99999A0000000, !dbg !142
  %208 = tail call contract noundef float @llvm.minnum.f32(float %mul596.11339, float 0x4024CB5EC0000000), !dbg !143
  %209 = tail call contract noundef float @llvm.exp.f32(float %208), !dbg !145
  %acc_s.sroa.0.4.vec.extract1599 = extractelement <4 x float> %207, i64 1, !dbg !141
  %mul596.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1599, 0x3FB99999A0000000, !dbg !142
  %210 = tail call contract noundef float @llvm.minnum.f32(float %mul596.1.1, float 0x4024CB5EC0000000), !dbg !143
  %211 = tail call contract noundef float @llvm.exp.f32(float %210), !dbg !145
  %acc_s.sroa.0.8.vec.extract1692 = extractelement <4 x float> %207, i64 2, !dbg !141
  %mul596.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1692, 0x3FB99999A0000000, !dbg !142
  %212 = tail call contract noundef float @llvm.minnum.f32(float %mul596.2.1, float 0x4024CB5EC0000000), !dbg !143
  %213 = tail call contract noundef float @llvm.exp.f32(float %212), !dbg !145
  %acc_s.sroa.0.12.vec.extract1785 = extractelement <4 x float> %207, i64 3, !dbg !141
  %mul596.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1785, 0x3FB99999A0000000, !dbg !142
  %214 = tail call contract noundef float @llvm.minnum.f32(float %mul596.3.1, float 0x4024CB5EC0000000), !dbg !143
  %215 = tail call contract noundef float @llvm.exp.f32(float %214), !dbg !145
  %add612.11340 = fadd contract float %sum_acc.sroa.0.5, %209, !dbg !147
  %add612.1.1 = fadd contract float %sum_acc.sroa.20.5, %211, !dbg !147
  %add612.2.1 = fadd contract float %sum_acc.sroa.38.5, %213, !dbg !147
  %add612.3.1 = fadd contract float %sum_acc.sroa.56.5, %215, !dbg !147
  %216 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %209), !dbg !148
  %217 = insertelement <4 x i16> poison, i16 %216, i64 0, !dbg !152
  %218 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %211), !dbg !148
  %219 = insertelement <4 x i16> %217, i16 %218, i64 1, !dbg !152
  %220 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %213), !dbg !148
  %221 = insertelement <4 x i16> %219, i16 %220, i64 2, !dbg !152
  %222 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %215), !dbg !148
  %223 = insertelement <4 x i16> %221, i16 %222, i64 3, !dbg !152
  %acc_s_cast.sroa.0.6.vec.insert1419 = bitcast <4 x i16> %223 to <4 x half>, !dbg !152
  %224 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1814, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1419, <4 x float> %acc_o.sroa.0.2), !dbg !153, !call_argsrelate !107
  %225 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1821, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1419, <4 x float> %acc_o.sroa.34.2), !dbg !153, !call_argsrelate !107
  %226 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1842, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1419, <4 x float> %acc_o.sroa.66.2), !dbg !153, !call_argsrelate !107
  %227 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1849, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1419, <4 x float> %acc_o.sroa.98.2), !dbg !153, !call_argsrelate !107
  br label %if.end648.1, !dbg !154

if.end648.1:                                      ; preds = %if.end561.1, %if.end502.1
  %acc_o.sroa.98.3 = phi <4 x float> [ %acc_o.sroa.98.2, %if.end502.1 ], [ %227, %if.end561.1 ], !dbg !85
  %acc_o.sroa.66.3 = phi <4 x float> [ %acc_o.sroa.66.2, %if.end502.1 ], [ %226, %if.end561.1 ], !dbg !85
  %acc_o.sroa.34.3 = phi <4 x float> [ %acc_o.sroa.34.2, %if.end502.1 ], [ %225, %if.end561.1 ], !dbg !85
  %acc_o.sroa.0.3 = phi <4 x float> [ %acc_o.sroa.0.2, %if.end502.1 ], [ %224, %if.end561.1 ], !dbg !85
  %sum_acc.sroa.56.6 = phi float [ %sum_acc.sroa.56.5, %if.end502.1 ], [ %add612.3.1, %if.end561.1 ], !dbg !85
  %sum_acc.sroa.38.6 = phi float [ %sum_acc.sroa.38.5, %if.end502.1 ], [ %add612.2.1, %if.end561.1 ], !dbg !85
  %sum_acc.sroa.20.6 = phi float [ %sum_acc.sroa.20.5, %if.end502.1 ], [ %add612.1.1, %if.end561.1 ], !dbg !85
  %sum_acc.sroa.0.6 = phi float [ %sum_acc.sroa.0.5, %if.end502.1 ], [ %add612.11340, %if.end561.1 ], !dbg !85
  br i1 %or.cond1255.1, label %if.end794.1, label %for.cond656.preheader.1, !dbg !154

for.cond656.preheader.1:                          ; preds = %if.end648.1
  %228 = shl nsw i32 %cond.i.i1173.7, 10
  %mul663.1 = and i32 %228, 64512
  %add666.1 = add nuw nsw i32 %add104, %mul663.1
  %229 = zext nneg i32 %add666.1 to i64, !dbg !155
  %add.ptr671.11341 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %229, !dbg !156
  %V_reg.sroa.0.0.copyload1815 = load <4 x half>, ptr addrspace(4) %add.ptr671.11341, align 16, !dbg !157
  %V_reg.sroa.18.0.add.ptr671.11341.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr671.11341, i64 8, !dbg !157
  %V_reg.sroa.18.0.copyload1822 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr671.11341.sroa_idx, align 8, !dbg !157
  %230 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %229, !dbg !156
  %add.ptr671.1.1 = getelementptr inbounds i8, ptr addrspace(4) %230, i64 1024, !dbg !156
  %V_reg.sroa.26.16.copyload1843 = load <4 x half>, ptr addrspace(4) %add.ptr671.1.1, align 16, !dbg !157
  %V_reg.sroa.42.16.add.ptr671.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %230, i64 1032, !dbg !157
  %V_reg.sroa.42.16.copyload1850 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr671.1.1.sroa_idx, align 8, !dbg !157
  %cmp681.1 = icmp sgt i32 %mul12.7, %invariant.op, !dbg !158
  br i1 %cmp681.1, label %for.cond683.preheader.1, label %if.end707.1, !dbg !159

for.cond683.preheader.1:                          ; preds = %for.cond656.preheader.1
  %add690.1 = add nuw nsw i32 %mul12.7, %mul252
  %cmp693.not.11342 = icmp sgt i32 %add690.1, %1, !dbg !160
  %fneg.1164.11343 = select i1 %cmp693.not.11342, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1514 = insertelement <4 x float> poison, float %fneg.1164.11343, i64 0, !dbg !161
  %cmp693.not.1.1.not = icmp slt i32 %add690.1, %1, !dbg !160
  %fneg.1164.1.1 = select i1 %cmp693.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1607 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1514, float %fneg.1164.1.1, i64 1, !dbg !161
  %add691.2.1 = or disjoint i32 %add690.1, 2, !dbg !162
  %cmp693.not.2.1 = icmp sgt i32 %add691.2.1, %1, !dbg !160
  %fneg.1164.2.1 = select i1 %cmp693.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1700 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1607, float %fneg.1164.2.1, i64 2, !dbg !161
  %add691.3.1 = or disjoint i32 %add690.1, 3, !dbg !162
  %cmp693.not.3.1 = icmp sgt i32 %add691.3.1, %1, !dbg !160
  %fneg.1164.3.1 = select i1 %cmp693.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1793 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1700, float %fneg.1164.3.1, i64 3, !dbg !161
  br label %if.end707.1

if.end707.1:                                      ; preds = %for.cond656.preheader.1, %for.cond683.preheader.1
  %acc_s.sroa.0.14 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1793, %for.cond683.preheader.1 ], [ zeroinitializer, %for.cond656.preheader.1 ], !dbg !85
  %231 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.14), !dbg !163, !call_argsrelate !87
  %232 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %231), !dbg !163, !call_argsrelate !87
  %233 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %232), !dbg !163, !call_argsrelate !87
  %234 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %233), !dbg !163, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract1516 = extractelement <4 x float> %234, i64 0, !dbg !164
  %mul742.11347 = fmul contract float %acc_s.sroa.0.0.vec.extract1516, 0x3FB99999A0000000, !dbg !165
  %235 = tail call contract noundef float @llvm.minnum.f32(float %mul742.11347, float 0x4024CB5EC0000000), !dbg !166
  %236 = tail call contract noundef float @llvm.exp.f32(float %235), !dbg !168
  %acc_s.sroa.0.4.vec.extract1609 = extractelement <4 x float> %234, i64 1, !dbg !164
  %mul742.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1609, 0x3FB99999A0000000, !dbg !165
  %237 = tail call contract noundef float @llvm.minnum.f32(float %mul742.1.1, float 0x4024CB5EC0000000), !dbg !166
  %238 = tail call contract noundef float @llvm.exp.f32(float %237), !dbg !168
  %acc_s.sroa.0.8.vec.extract1702 = extractelement <4 x float> %234, i64 2, !dbg !164
  %mul742.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1702, 0x3FB99999A0000000, !dbg !165
  %239 = tail call contract noundef float @llvm.minnum.f32(float %mul742.2.1, float 0x4024CB5EC0000000), !dbg !166
  %240 = tail call contract noundef float @llvm.exp.f32(float %239), !dbg !168
  %acc_s.sroa.0.12.vec.extract1795 = extractelement <4 x float> %234, i64 3, !dbg !164
  %mul742.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1795, 0x3FB99999A0000000, !dbg !165
  %241 = tail call contract noundef float @llvm.minnum.f32(float %mul742.3.1, float 0x4024CB5EC0000000), !dbg !166
  %242 = tail call contract noundef float @llvm.exp.f32(float %241), !dbg !168
  %add758.11348 = fadd contract float %sum_acc.sroa.0.6, %236, !dbg !170
  %add758.1.1 = fadd contract float %sum_acc.sroa.20.6, %238, !dbg !170
  %add758.2.1 = fadd contract float %sum_acc.sroa.38.6, %240, !dbg !170
  %add758.3.1 = fadd contract float %sum_acc.sroa.56.6, %242, !dbg !170
  %243 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %236), !dbg !171
  %244 = insertelement <4 x i16> poison, i16 %243, i64 0, !dbg !175
  %245 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %238), !dbg !171
  %246 = insertelement <4 x i16> %244, i16 %245, i64 1, !dbg !175
  %247 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %240), !dbg !171
  %248 = insertelement <4 x i16> %246, i16 %247, i64 2, !dbg !175
  %249 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %242), !dbg !171
  %250 = insertelement <4 x i16> %248, i16 %249, i64 3, !dbg !175
  %acc_s_cast.sroa.0.6.vec.insert1421 = bitcast <4 x i16> %250 to <4 x half>, !dbg !175
  %251 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1815, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1421, <4 x float> %acc_o_alt.sroa.0.2), !dbg !176, !call_argsrelate !107
  %252 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1822, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1421, <4 x float> %acc_o_alt.sroa.18.2), !dbg !176, !call_argsrelate !107
  %253 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1843, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1421, <4 x float> %acc_o_alt.sroa.34.2), !dbg !176, !call_argsrelate !107
  %254 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1850, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1421, <4 x float> %acc_o_alt.sroa.50.2), !dbg !176, !call_argsrelate !107
  br label %if.end794.1, !dbg !177

if.end794.1:                                      ; preds = %if.end707.1, %if.end648.1
  %acc_o_alt.sroa.50.3 = phi <4 x float> [ %acc_o_alt.sroa.50.2, %if.end648.1 ], [ %254, %if.end707.1 ], !dbg !85
  %acc_o_alt.sroa.34.3 = phi <4 x float> [ %acc_o_alt.sroa.34.2, %if.end648.1 ], [ %253, %if.end707.1 ], !dbg !85
  %acc_o_alt.sroa.18.3 = phi <4 x float> [ %acc_o_alt.sroa.18.2, %if.end648.1 ], [ %252, %if.end707.1 ], !dbg !85
  %acc_o_alt.sroa.0.3 = phi <4 x float> [ %acc_o_alt.sroa.0.2, %if.end648.1 ], [ %251, %if.end707.1 ], !dbg !85
  %sum_acc.sroa.56.7 = phi float [ %sum_acc.sroa.56.6, %if.end648.1 ], [ %add758.3.1, %if.end707.1 ], !dbg !85
  %sum_acc.sroa.38.7 = phi float [ %sum_acc.sroa.38.6, %if.end648.1 ], [ %add758.2.1, %if.end707.1 ], !dbg !85
  %sum_acc.sroa.20.7 = phi float [ %sum_acc.sroa.20.6, %if.end648.1 ], [ %add758.1.1, %if.end707.1 ], !dbg !85
  %sum_acc.sroa.0.7 = phi float [ %sum_acc.sroa.0.6, %if.end648.1 ], [ %add758.11348, %if.end707.1 ], !dbg !85
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 0, !dbg !179
  %acc_o_alt.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 0, !dbg !180
  %add806 = fadd contract float %acc_o.sroa.0.0.vec.extract, %acc_o_alt.sroa.0.0.vec.extract, !dbg !181
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 1, !dbg !179
  %acc_o_alt.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 1, !dbg !180
  %add806.1 = fadd contract float %acc_o.sroa.0.4.vec.extract, %acc_o_alt.sroa.0.4.vec.extract, !dbg !181
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 2, !dbg !179
  %acc_o_alt.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 2, !dbg !180
  %add806.2 = fadd contract float %acc_o.sroa.0.8.vec.extract, %acc_o_alt.sroa.0.8.vec.extract, !dbg !181
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 3, !dbg !179
  %acc_o_alt.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 3, !dbg !180
  %add806.3 = fadd contract float %acc_o.sroa.0.12.vec.extract, %acc_o_alt.sroa.0.12.vec.extract, !dbg !181
  %acc_o.sroa.34.16.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 0, !dbg !179
  %acc_o_alt.sroa.18.16.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 0, !dbg !180
  %add806.4 = fadd contract float %acc_o.sroa.34.16.vec.extract, %acc_o_alt.sroa.18.16.vec.extract, !dbg !181
  %acc_o.sroa.34.20.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 1, !dbg !179
  %acc_o_alt.sroa.18.20.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 1, !dbg !180
  %add806.5 = fadd contract float %acc_o.sroa.34.20.vec.extract, %acc_o_alt.sroa.18.20.vec.extract, !dbg !181
  %acc_o.sroa.34.24.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 2, !dbg !179
  %acc_o_alt.sroa.18.24.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 2, !dbg !180
  %add806.6 = fadd contract float %acc_o.sroa.34.24.vec.extract, %acc_o_alt.sroa.18.24.vec.extract, !dbg !181
  %acc_o.sroa.34.28.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 3, !dbg !179
  %acc_o_alt.sroa.18.28.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 3, !dbg !180
  %add806.7 = fadd contract float %acc_o.sroa.34.28.vec.extract, %acc_o_alt.sroa.18.28.vec.extract, !dbg !181
  %acc_o.sroa.66.32.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 0, !dbg !179
  %acc_o_alt.sroa.34.32.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 0, !dbg !180
  %add806.8 = fadd contract float %acc_o.sroa.66.32.vec.extract, %acc_o_alt.sroa.34.32.vec.extract, !dbg !181
  %acc_o.sroa.66.36.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 1, !dbg !179
  %acc_o_alt.sroa.34.36.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 1, !dbg !180
  %add806.9 = fadd contract float %acc_o.sroa.66.36.vec.extract, %acc_o_alt.sroa.34.36.vec.extract, !dbg !181
  %acc_o.sroa.66.40.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 2, !dbg !179
  %acc_o_alt.sroa.34.40.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 2, !dbg !180
  %add806.10 = fadd contract float %acc_o.sroa.66.40.vec.extract, %acc_o_alt.sroa.34.40.vec.extract, !dbg !181
  %acc_o.sroa.66.44.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 3, !dbg !179
  %acc_o_alt.sroa.34.44.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 3, !dbg !180
  %add806.11 = fadd contract float %acc_o.sroa.66.44.vec.extract, %acc_o_alt.sroa.34.44.vec.extract, !dbg !181
  %acc_o.sroa.98.48.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 0, !dbg !179
  %acc_o_alt.sroa.50.48.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 0, !dbg !180
  %add806.12 = fadd contract float %acc_o.sroa.98.48.vec.extract, %acc_o_alt.sroa.50.48.vec.extract, !dbg !181
  %acc_o.sroa.98.52.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 1, !dbg !179
  %acc_o_alt.sroa.50.52.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 1, !dbg !180
  %add806.13 = fadd contract float %acc_o.sroa.98.52.vec.extract, %acc_o_alt.sroa.50.52.vec.extract, !dbg !181
  %acc_o.sroa.98.56.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 2, !dbg !179
  %acc_o_alt.sroa.50.56.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 2, !dbg !180
  %add806.14 = fadd contract float %acc_o.sroa.98.56.vec.extract, %acc_o_alt.sroa.50.56.vec.extract, !dbg !181
  %acc_o.sroa.98.60.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 3, !dbg !179
  %acc_o_alt.sroa.50.60.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 3, !dbg !180
  %add806.15 = fadd contract float %acc_o.sroa.98.60.vec.extract, %acc_o_alt.sroa.50.60.vec.extract, !dbg !181
  %add820 = fadd contract float %sum_acc.sroa.0.7, 0.000000e+00, !dbg !182
  %add820.1 = fadd contract float %add820, %sum_acc.sroa.20.7, !dbg !182
  %add820.2 = fadd contract float %add820.1, %sum_acc.sroa.38.7, !dbg !182
  %add820.3 = fadd contract float %add820.2, %sum_acc.sroa.56.7, !dbg !182
  %255 = bitcast float %add820.3 to i32, !dbg !183
  %256 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !195
  %257 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %256) #11, !dbg !200
  %xor.i.i = xor i32 %257, 32, !dbg !201
  %258 = and i32 %257, -64, !dbg !202
  %and.i.i = add nsw i32 %258, 64, !dbg !202
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !203
  %cond.i.i1174 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %257, !dbg !204
  %shl.i.i = shl i32 %cond.i.i1174, 2, !dbg !205
  %259 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %255), !dbg !206
  %260 = bitcast i32 %259 to float, !dbg !207
  %add.i = fadd contract float %add820.3, %260, !dbg !208
  %261 = bitcast float %add.i to i32, !dbg !211
  %262 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !218
  %263 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %262) #11, !dbg !221
  %xor.i.i1175 = xor i32 %263, 16, !dbg !222
  %264 = and i32 %263, -64, !dbg !223
  %and.i.i1176 = add nsw i32 %264, 64, !dbg !223
  %cmp.not.i.i1177 = icmp slt i32 %xor.i.i1175, %and.i.i1176, !dbg !224
  %cond.i.i1178 = select i1 %cmp.not.i.i1177, i32 %xor.i.i1175, i32 %263, !dbg !225
  %shl.i.i1179 = shl i32 %cond.i.i1178, 2, !dbg !226
  %265 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i1179, i32 %261), !dbg !227
  %266 = bitcast i32 %265 to float, !dbg !228
  %add.i.i = fadd contract float %add.i, %266, !dbg !229
  %cmp829 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !231
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !232
  %condval_4.0 = select i1 %cmp829, float %div, float 0.000000e+00, !dbg !232
  %mul842 = fmul contract float %condval_4.0, %add806, !dbg !233
  %mul842.1 = fmul contract float %condval_4.0, %add806.1, !dbg !233
  %mul842.2 = fmul contract float %condval_4.0, %add806.2, !dbg !233
  %mul842.3 = fmul contract float %condval_4.0, %add806.3, !dbg !233
  %mul842.4 = fmul contract float %condval_4.0, %add806.4, !dbg !233
  %mul842.5 = fmul contract float %condval_4.0, %add806.5, !dbg !233
  %mul842.6 = fmul contract float %condval_4.0, %add806.6, !dbg !233
  %mul842.7 = fmul contract float %condval_4.0, %add806.7, !dbg !233
  %mul842.8 = fmul contract float %condval_4.0, %add806.8, !dbg !233
  %mul842.9 = fmul contract float %condval_4.0, %add806.9, !dbg !233
  %mul842.10 = fmul contract float %condval_4.0, %add806.10, !dbg !233
  %mul842.11 = fmul contract float %condval_4.0, %add806.11, !dbg !233
  %mul842.12 = fmul contract float %condval_4.0, %add806.12, !dbg !233
  %mul842.13 = fmul contract float %condval_4.0, %add806.13, !dbg !233
  %mul842.14 = fmul contract float %condval_4.0, %add806.14, !dbg !233
  %mul842.15 = fmul contract float %condval_4.0, %add806.15, !dbg !233
  %267 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul842), !dbg !234
  %O_reg.sroa.0.0.insert.ext = zext i16 %267 to i64, !dbg !238
  %268 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul842.1), !dbg !234
  %O_reg.sroa.0.2.insert.ext = zext i16 %268 to i64, !dbg !238
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !238
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !238
  %269 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul842.2), !dbg !234
  %O_reg.sroa.0.4.insert.ext = zext i16 %269 to i64, !dbg !238
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !238
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !238
  %270 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul842.3), !dbg !234
  %O_reg.sroa.0.6.insert.ext = zext i16 %270 to i64, !dbg !238
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !238
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !238
  %271 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul842.4), !dbg !234
  %O_reg.sroa.7.8.insert.ext = zext i16 %271 to i64, !dbg !238
  %272 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul842.5), !dbg !234
  %O_reg.sroa.7.10.insert.ext = zext i16 %272 to i64, !dbg !238
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !238
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !238
  %273 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul842.6), !dbg !234
  %O_reg.sroa.7.12.insert.ext = zext i16 %273 to i64, !dbg !238
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !238
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !238
  %274 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul842.7), !dbg !234
  %O_reg.sroa.7.14.insert.ext = zext i16 %274 to i64, !dbg !238
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !238
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !238
  %275 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul842.8), !dbg !234
  %O_reg.sroa.12.16.insert.ext = zext i16 %275 to i64, !dbg !238
  %276 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul842.9), !dbg !234
  %O_reg.sroa.12.18.insert.ext = zext i16 %276 to i64, !dbg !238
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !238
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !238
  %277 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul842.10), !dbg !234
  %O_reg.sroa.12.20.insert.ext = zext i16 %277 to i64, !dbg !238
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !238
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !238
  %278 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul842.11), !dbg !234
  %O_reg.sroa.12.22.insert.ext = zext i16 %278 to i64, !dbg !238
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !238
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !238
  %279 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul842.12), !dbg !234
  %O_reg.sroa.17.24.insert.ext = zext i16 %279 to i64, !dbg !238
  %280 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul842.13), !dbg !234
  %O_reg.sroa.17.26.insert.ext = zext i16 %280 to i64, !dbg !238
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !238
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !238
  %281 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul842.14), !dbg !234
  %O_reg.sroa.17.28.insert.ext = zext i16 %281 to i64, !dbg !238
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !238
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !238
  %282 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul842.15), !dbg !234
  %O_reg.sroa.17.30.insert.ext = zext i16 %282 to i64, !dbg !238
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !238
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !238
  %shr884 = lshr i32 %10, 5
  %and887 = and i32 %10, 7
  %mul893 = and i32 %14, 4
  %xor = xor i32 %shr884, %and887, !dbg !239
  %mul888 = shl nuw nsw i32 %xor, 3, !dbg !240
  %add889 = add nuw nsw i32 %mul888, %mul26, !dbg !241
  %add894 = or disjoint i32 %add889, %mul893, !dbg !242
  %add.ptr896 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add894, !dbg !243
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr896, align 8, !dbg !244
  %add885.1 = add nuw nsw i32 %shr884, 2, !dbg !245
  %xor.1 = xor i32 %add885.1, %and887, !dbg !239
  %mul888.1 = shl nuw nsw i32 %xor.1, 3, !dbg !240
  %add889.1 = add nuw nsw i32 %mul888.1, %mul26, !dbg !241
  %add894.1 = or disjoint i32 %add889.1, %mul893, !dbg !242
  %add.ptr896.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add894.1, !dbg !243
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr896.1, align 8, !dbg !244
  %add885.2 = add nuw nsw i32 %shr884, 4, !dbg !245
  %xor.2 = xor i32 %add885.2, %and887, !dbg !239
  %mul888.2 = shl nuw nsw i32 %xor.2, 3, !dbg !240
  %add889.2 = add nuw nsw i32 %mul888.2, %mul26, !dbg !241
  %add894.2 = or disjoint i32 %add889.2, %mul893, !dbg !242
  %add.ptr896.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add894.2, !dbg !243
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr896.2, align 8, !dbg !244
  %add885.3 = add nuw nsw i32 %shr884, 6, !dbg !245
  %xor.3 = xor i32 %add885.3, %and887, !dbg !239
  %mul888.3 = shl nuw nsw i32 %xor.3, 3, !dbg !240
  %add889.3 = add nuw nsw i32 %mul888.3, %mul26, !dbg !241
  %add894.3 = or disjoint i32 %add889.3, %mul893, !dbg !242
  %add.ptr896.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add894.3, !dbg !243
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr896.3, align 8, !dbg !244
  fence syncscope("warp") release, !dbg !246
  tail call void @llvm.mxc.barrier.warp(), !dbg !251
  fence syncscope("warp") acquire, !dbg !252
  %mul907 = and i32 %mul108, 8128
  %xor9131160 = and i32 %mul108, 56
  %call911.masked = and i32 %10, 1016
  %mul914 = xor i32 %xor9131160, %call911.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul907, !dbg !253
  %invariant.gep1246 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul914, !dbg !253
  %add924 = add nuw nsw i32 %add24, %mul108
  %283 = zext nneg i32 %add924 to i64, !dbg !254
  %add.ptr929 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %283, !dbg !255
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr929, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep1246, i64 16, i1 false), !dbg !256, !tbaa.struct !257, !call_argsrelate !258
  %gep1247.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep1246, i32 1024, !dbg !259
  %284 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %283, !dbg !255
  %add.ptr929.1 = getelementptr inbounds i8, ptr addrspace(1) %284, i64 1024, !dbg !255
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr929.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep1247.1, i64 16, i1 false), !dbg !256, !tbaa.struct !257, !call_argsrelate !258
  ret void, !dbg !260
}

; Function Attrs: convergent nounwind willreturn memory(none)
declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.x() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.y() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.z() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.thread.id.x() #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp.f32(float) #6

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare i16 @llvm.convert.to.fp16.f32(float) #7

; Function Attrs: convergent nounwind willreturn
declare void @llvm.mxc.barrier.warp() #8

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i1 @llvm.mxc.is.private(ptr nocapture) #5

; Function Attrs: nounwind willreturn
declare void @llvm.mxc.sleep(i32 immarg) #9

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smax.i32(i32, i32) #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smin.i32(i32, i32) #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.minnum.f32(float, float) #6

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #10

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #7 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #8 = { convergent nounwind willreturn }
attributes #9 = { nounwind willreturn }
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #11 = { nomerge }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmp1phl10fr/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{i32 8, !"PIC Level", i32 1}
!5 = distinct !DISubprogram(name: "__cxa_pure_virtual", scope: !6, file: !6, line: 38, type: !7, scopeLine: 38, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!6 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_runtime_wrapper.h", directory: "")
!7 = !DISubroutineType(types: !8)
!8 = !{}
!9 = !DILocation(line: 39, column: 3, scope: !5)
!10 = !DILocation(line: 40, column: 1, scope: !5)
!11 = distinct !DISubprogram(name: "__cxa_deleted_virtual", scope: !6, file: !6, line: 43, type: !7, scopeLine: 43, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!12 = !DILocation(line: 44, column: 3, scope: !11)
!13 = !DILocation(line: 45, column: 1, scope: !11)
!14 = distinct !DISubprogram(name: "__mcImplicitDeviceSynchronize", scope: !15, file: !15, line: 92, type: !7, scopeLine: 93, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!15 = !DIFile(filename: "/opt/maca/include/mckl/mc_device_runtime.h", directory: "")
!16 = !DILocation(line: 94, column: 5, scope: !14)
!17 = !{!18, !18, i64 0}
!18 = !{!"long", !19, i64 0}
!19 = !{!"omnipotent char", !20, i64 0}
!20 = !{!"Simple C++ TBAA"}
!21 = !{!22, !24, i64 16}
!22 = !{!"_ZTS21_DynamicParallMqlWrap", !23, i64 0, !23, i64 4, !23, i64 8, !23, i64 12, !24, i64 16, !24, i64 24, !25, i64 32}
!23 = !{!"int", !19, i64 0}
!24 = !{!"any pointer", !19, i64 0}
!25 = !{!"_ZTS28mxc_kernel_dispatch_packet_s", !26, i64 0, !26, i64 2, !26, i64 4, !26, i64 6, !26, i64 8, !26, i64 10, !23, i64 12, !23, i64 16, !23, i64 20, !23, i64 24, !23, i64 28, !18, i64 32, !24, i64 40, !18, i64 48, !27, i64 56}
!26 = !{!"short", !19, i64 0}
!27 = !{!"_ZTS12mxc_signal_s", !18, i64 0}
!28 = !{i32 1, i32 -2147483648}
!29 = !{i32 0, i32 2147483647}
!30 = !{!23, !23, i64 0}
!31 = distinct !{!31, !32}
!32 = !{!"llvm.loop.mustprogress"}
!33 = !{!22, !23, i64 4}
!34 = !{!22, !24, i64 24}
!35 = !{!22, !23, i64 0}
!36 = !{!37, !24, i64 24}
!37 = !{!"_ZTS28_DynamicParallSchedulerParam", !18, i64 0, !24, i64 8, !24, i64 16, !24, i64 24, !18, i64 32, !18, i64 40, !18, i64 48, !18, i64 56, !18, i64 64, !18, i64 72, !18, i64 80, !18, i64 88, !18, i64 96, !23, i64 104, !23, i64 108, !23, i64 112, !23, i64 116, !23, i64 120, !23, i64 124}
!38 = !{!37, !18, i64 80}
!39 = !DILocation(line: 95, column: 1, scope: !14)
!40 = distinct !DISubprogram(name: "kernel_kernel", scope: !41, file: !41, line: 10, type: !7, scopeLine: 10, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!41 = !DIFile(filename: "/tmp/tmp1phl10fr/tvm_kernels.maca", directory: "")
!42 = !DILocation(line: 28, column: 3, scope: !40)
!43 = !DILocation(line: 29, column: 29, scope: !40)
!44 = !DILocation(line: 29, column: 21, scope: !40)
!45 = !DILocation(line: 705, column: 10, scope: !46, inlinedAt: !48)
!46 = distinct !DISubprogram(name: "max", scope: !47, file: !47, line: 704, type: !7, scopeLine: 704, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!47 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!48 = distinct !DILocation(line: 30, column: 24, scope: !40)
!49 = !{i32 0, i32 -1}
!50 = !DILocation(line: 708, column: 10, scope: !51, inlinedAt: !52)
!51 = distinct !DISubprogram(name: "min", scope: !47, file: !47, line: 707, type: !7, scopeLine: 707, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!52 = distinct !DILocation(line: 30, column: 20, scope: !40)
!53 = !DILocation(line: 30, column: 48, scope: !40)
!54 = !DILocation(line: 29, column: 98, scope: !40)
!55 = !{i32 0, i32 1024}
!56 = !DILocation(line: 33, column: 3, scope: !40)
!57 = !DILocation(line: 34, column: 46, scope: !40)
!58 = !DILocation(line: 34, column: 32, scope: !40)
!59 = !DILocation(line: 49, column: 3, scope: !40)
!60 = !DILocation(line: 54, column: 22, scope: !40)
!61 = !DILocation(line: 56, column: 7, scope: !40)
!62 = !DILocation(line: 57, column: 52, scope: !40)
!63 = !DILocation(line: 57, column: 38, scope: !40)
!64 = !DILocation(line: 60, column: 22, scope: !40)
!65 = !DILocation(line: 62, column: 7, scope: !40)
!66 = !DILocation(line: 63, column: 53, scope: !40)
!67 = !DILocation(line: 63, column: 39, scope: !40)
!68 = !DILocation(line: 66, column: 22, scope: !40)
!69 = !DILocation(line: 68, column: 7, scope: !40)
!70 = !DILocation(line: 69, column: 53, scope: !40)
!71 = !DILocation(line: 69, column: 39, scope: !40)
!72 = !DILocation(line: 72, column: 22, scope: !40)
!73 = !DILocation(line: 74, column: 7, scope: !40)
!74 = !DILocation(line: 75, column: 53, scope: !40)
!75 = !DILocation(line: 75, column: 39, scope: !40)
!76 = !DILocation(line: 78, column: 22, scope: !40)
!77 = !DILocation(line: 80, column: 7, scope: !40)
!78 = !DILocation(line: 81, column: 52, scope: !40)
!79 = !DILocation(line: 81, column: 38, scope: !40)
!80 = !DILocation(line: 83, column: 29, scope: !40)
!81 = !DILocation(line: 83, column: 11, scope: !40)
!82 = !DILocation(line: 87, column: 65, scope: !40)
!83 = !DILocation(line: 92, column: 22, scope: !40)
!84 = !DILocation(line: 87, column: 58, scope: !40)
!85 = !DILocation(line: 0, scope: !40)
!86 = !DILocation(line: 101, column: 36, scope: !40)
!87 = !{i32 -1, i32 3, i32 -1}
!88 = !DILocation(line: 109, column: 32, scope: !40)
!89 = !DILocation(line: 109, column: 43, scope: !40)
!90 = !DILocation(line: 354, column: 10, scope: !91, inlinedAt: !92)
!91 = distinct !DISubprogram(name: "min", scope: !47, file: !47, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!92 = distinct !DILocation(line: 109, column: 27, scope: !40)
!93 = !DILocation(line: 288, column: 10, scope: !94, inlinedAt: !95)
!94 = distinct !DISubprogram(name: "expf", scope: !47, file: !47, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!95 = distinct !DILocation(line: 109, column: 22, scope: !40)
!96 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !99)
!97 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !98, file: !98, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!98 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!99 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !102)
!100 = distinct !DISubprogram(name: "__float2half", scope: !101, file: !101, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!101 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!102 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !104)
!103 = distinct !DISubprogram(name: "__half", scope: !101, file: !101, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!104 = distinct !DILocation(line: 117, column: 34, scope: !40)
!105 = !DILocation(line: 117, column: 31, scope: !40)
!106 = !DILocation(line: 121, column: 36, scope: !40)
!107 = !{i32 4, i32 -1, i32 -1}
!108 = !DILocation(line: 127, column: 22, scope: !40)
!109 = !DILocation(line: 129, column: 7, scope: !40)
!110 = !DILocation(line: 130, column: 53, scope: !40)
!111 = !DILocation(line: 130, column: 39, scope: !40)
!112 = !DILocation(line: 132, column: 29, scope: !40)
!113 = !DILocation(line: 132, column: 11, scope: !40)
!114 = !DILocation(line: 136, column: 66, scope: !40)
!115 = !DILocation(line: 141, column: 23, scope: !40)
!116 = !DILocation(line: 136, column: 58, scope: !40)
!117 = !DILocation(line: 150, column: 36, scope: !40)
!118 = !DILocation(line: 158, column: 33, scope: !40)
!119 = !DILocation(line: 158, column: 45, scope: !40)
!120 = !DILocation(line: 354, column: 10, scope: !91, inlinedAt: !121)
!121 = distinct !DILocation(line: 158, column: 28, scope: !40)
!122 = !DILocation(line: 288, column: 10, scope: !94, inlinedAt: !123)
!123 = distinct !DILocation(line: 158, column: 23, scope: !40)
!124 = !DILocation(line: 162, column: 40, scope: !40)
!125 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !126)
!126 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !127)
!127 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !128)
!128 = distinct !DILocation(line: 166, column: 36, scope: !40)
!129 = !DILocation(line: 166, column: 33, scope: !40)
!130 = !DILocation(line: 170, column: 42, scope: !40)
!131 = !DILocation(line: 176, column: 22, scope: !40)
!132 = !DILocation(line: 178, column: 7, scope: !40)
!133 = !DILocation(line: 179, column: 53, scope: !40)
!134 = !DILocation(line: 179, column: 39, scope: !40)
!135 = !DILocation(line: 181, column: 29, scope: !40)
!136 = !DILocation(line: 181, column: 11, scope: !40)
!137 = !DILocation(line: 185, column: 66, scope: !40)
!138 = !DILocation(line: 190, column: 23, scope: !40)
!139 = !DILocation(line: 185, column: 58, scope: !40)
!140 = !DILocation(line: 199, column: 36, scope: !40)
!141 = !DILocation(line: 207, column: 33, scope: !40)
!142 = !DILocation(line: 207, column: 45, scope: !40)
!143 = !DILocation(line: 354, column: 10, scope: !91, inlinedAt: !144)
!144 = distinct !DILocation(line: 207, column: 28, scope: !40)
!145 = !DILocation(line: 288, column: 10, scope: !94, inlinedAt: !146)
!146 = distinct !DILocation(line: 207, column: 23, scope: !40)
!147 = !DILocation(line: 211, column: 40, scope: !40)
!148 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !149)
!149 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !150)
!150 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !151)
!151 = distinct !DILocation(line: 215, column: 36, scope: !40)
!152 = !DILocation(line: 215, column: 33, scope: !40)
!153 = !DILocation(line: 219, column: 38, scope: !40)
!154 = !DILocation(line: 225, column: 22, scope: !40)
!155 = !DILocation(line: 227, column: 7, scope: !40)
!156 = !DILocation(line: 228, column: 53, scope: !40)
!157 = !DILocation(line: 228, column: 39, scope: !40)
!158 = !DILocation(line: 230, column: 29, scope: !40)
!159 = !DILocation(line: 230, column: 11, scope: !40)
!160 = !DILocation(line: 234, column: 66, scope: !40)
!161 = !DILocation(line: 239, column: 23, scope: !40)
!162 = !DILocation(line: 234, column: 58, scope: !40)
!163 = !DILocation(line: 248, column: 36, scope: !40)
!164 = !DILocation(line: 256, column: 33, scope: !40)
!165 = !DILocation(line: 256, column: 45, scope: !40)
!166 = !DILocation(line: 354, column: 10, scope: !91, inlinedAt: !167)
!167 = distinct !DILocation(line: 256, column: 28, scope: !40)
!168 = !DILocation(line: 288, column: 10, scope: !94, inlinedAt: !169)
!169 = distinct !DILocation(line: 256, column: 23, scope: !40)
!170 = !DILocation(line: 260, column: 40, scope: !40)
!171 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !172)
!172 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !173)
!173 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !174)
!174 = distinct !DILocation(line: 264, column: 36, scope: !40)
!175 = !DILocation(line: 264, column: 33, scope: !40)
!176 = !DILocation(line: 268, column: 42, scope: !40)
!177 = !DILocation(line: 49, column: 34, scope: !40)
!178 = !DILocation(line: 113, column: 40, scope: !40)
!179 = !DILocation(line: 277, column: 20, scope: !40)
!180 = !DILocation(line: 277, column: 34, scope: !40)
!181 = !DILocation(line: 277, column: 32, scope: !40)
!182 = !DILocation(line: 282, column: 36, scope: !40)
!183 = !DILocation(line: 1018, column: 9, scope: !184, inlinedAt: !186)
!184 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !185, file: !185, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!185 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!186 = distinct !DILocation(line: 396, column: 10, scope: !187, inlinedAt: !189)
!187 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !188, file: !188, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!188 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!189 = distinct !DILocation(line: 129, column: 24, scope: !190, inlinedAt: !192)
!190 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !191, file: !191, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!191 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!192 = distinct !DILocation(line: 101, column: 14, scope: !193, inlinedAt: !194)
!193 = distinct !DISubprogram(name: "run<float>", scope: !191, file: !191, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!194 = distinct !DILocation(line: 284, column: 19, scope: !40)
!195 = !DILocation(line: 171, column: 37, scope: !196, inlinedAt: !197)
!196 = distinct !DISubprogram(name: "__lane_id", scope: !185, file: !185, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!197 = distinct !DILocation(line: 990, column: 14, scope: !198, inlinedAt: !199)
!198 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !185, file: !185, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!199 = distinct !DILocation(line: 1019, column: 11, scope: !184, inlinedAt: !186)
!200 = !DILocation(line: 171, column: 10, scope: !196, inlinedAt: !197)
!201 = !DILocation(line: 991, column: 20, scope: !198, inlinedAt: !199)
!202 = !DILocation(line: 992, column: 36, scope: !198, inlinedAt: !199)
!203 = !DILocation(line: 992, column: 17, scope: !198, inlinedAt: !199)
!204 = !DILocation(line: 992, column: 11, scope: !198, inlinedAt: !199)
!205 = !DILocation(line: 993, column: 43, scope: !198, inlinedAt: !199)
!206 = !DILocation(line: 993, column: 10, scope: !198, inlinedAt: !199)
!207 = !DILocation(line: 1020, column: 14, scope: !184, inlinedAt: !186)
!208 = !DILocation(line: 25, column: 14, scope: !209, inlinedAt: !210)
!209 = distinct !DISubprogram(name: "operator()<float>", scope: !191, file: !191, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!210 = distinct !DILocation(line: 129, column: 11, scope: !190, inlinedAt: !192)
!211 = !DILocation(line: 1018, column: 9, scope: !184, inlinedAt: !212)
!212 = distinct !DILocation(line: 396, column: 10, scope: !187, inlinedAt: !213)
!213 = distinct !DILocation(line: 129, column: 24, scope: !214, inlinedAt: !215)
!214 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !191, file: !191, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!215 = distinct !DILocation(line: 101, column: 14, scope: !216, inlinedAt: !217)
!216 = distinct !DISubprogram(name: "run<float>", scope: !191, file: !191, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!217 = distinct !DILocation(line: 134, column: 14, scope: !190, inlinedAt: !192)
!218 = !DILocation(line: 171, column: 37, scope: !196, inlinedAt: !219)
!219 = distinct !DILocation(line: 990, column: 14, scope: !198, inlinedAt: !220)
!220 = distinct !DILocation(line: 1019, column: 11, scope: !184, inlinedAt: !212)
!221 = !DILocation(line: 171, column: 10, scope: !196, inlinedAt: !219)
!222 = !DILocation(line: 991, column: 20, scope: !198, inlinedAt: !220)
!223 = !DILocation(line: 992, column: 36, scope: !198, inlinedAt: !220)
!224 = !DILocation(line: 992, column: 17, scope: !198, inlinedAt: !220)
!225 = !DILocation(line: 992, column: 11, scope: !198, inlinedAt: !220)
!226 = !DILocation(line: 993, column: 43, scope: !198, inlinedAt: !220)
!227 = !DILocation(line: 993, column: 10, scope: !198, inlinedAt: !220)
!228 = !DILocation(line: 1020, column: 14, scope: !184, inlinedAt: !212)
!229 = !DILocation(line: 25, column: 14, scope: !209, inlinedAt: !230)
!230 = distinct !DILocation(line: 129, column: 11, scope: !214, inlinedAt: !215)
!231 = !DILocation(line: 286, column: 32, scope: !40)
!232 = !DILocation(line: 286, column: 7, scope: !40)
!233 = !DILocation(line: 294, column: 32, scope: !40)
!234 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !235)
!235 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !236)
!236 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !237)
!237 = distinct !DILocation(line: 300, column: 50, scope: !40)
!238 = !DILocation(line: 300, column: 47, scope: !40)
!239 = !DILocation(line: 305, column: 122, scope: !40)
!240 = !DILocation(line: 305, column: 150, scope: !40)
!241 = !DILocation(line: 305, column: 77, scope: !40)
!242 = !DILocation(line: 305, column: 156, scope: !40)
!243 = !DILocation(line: 305, column: 40, scope: !40)
!244 = !DILocation(line: 305, column: 199, scope: !40)
!245 = !DILocation(line: 305, column: 93, scope: !40)
!246 = !DILocation(line: 68, column: 3, scope: !247, inlinedAt: !248)
!247 = distinct !DISubprogram(name: "__barrier_warp", scope: !185, file: !185, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!248 = distinct !DILocation(line: 192, column: 3, scope: !249, inlinedAt: !250)
!249 = distinct !DISubprogram(name: "__syncwarp", scope: !185, file: !185, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!250 = distinct !DILocation(line: 307, column: 3, scope: !40)
!251 = !DILocation(line: 69, column: 3, scope: !247, inlinedAt: !248)
!252 = !DILocation(line: 70, column: 3, scope: !247, inlinedAt: !248)
!253 = !DILocation(line: 309, column: 8, scope: !40)
!254 = !DILocation(line: 309, column: 3, scope: !40)
!255 = !DILocation(line: 310, column: 22, scope: !40)
!256 = !DILocation(line: 310, column: 132, scope: !40)
!257 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!258 = !{i32 2, i32 -1, i32 -1, i32 -1}
!259 = !DILocation(line: 310, column: 169, scope: !40)
!260 = !DILocation(line: 312, column: 1, scope: !40)
