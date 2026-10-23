; ModuleID = 'experiments/20261015_goal8933/complete_binary/oj12_m1_p1.bc'
source_filename = "/tmp/tmp8jr_tuv_/tvm_kernels.maca"
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
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %BlockIndices.coerce, ptr addrspace(4) noalias noundef readonly %K.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias noundef readonly %V.coerce) local_unnamed_addr #3 !dbg !40 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul = shl nsw i32 %0, 13
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul7 = shl nsw i32 %1, 3
  %add = add nuw nsw i32 %mul, %mul7
  %2 = zext nneg i32 %add to i64, !dbg !42
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %2, !dbg !43
  %3 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !43, !tbaa !30
  %cond.i.i = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %3, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2393 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64), !dbg !49
  %mul11 = shl nsw i32 %cond.i.i2393, 4, !dbg !52
  %4 = or disjoint i64 %2, 1, !dbg !53
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4, !dbg !43
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !dbg !43, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2393.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64), !dbg !49
  %mul11.1 = shl nsw i32 %cond.i.i2393.1, 4, !dbg !52
  %6 = or disjoint i64 %2, 2, !dbg !53
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6, !dbg !43
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !dbg !43, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2393.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64), !dbg !49
  %mul11.2 = shl nsw i32 %cond.i.i2393.2, 4, !dbg !52
  %8 = or disjoint i64 %2, 3, !dbg !53
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8, !dbg !43
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !dbg !43, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2393.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64), !dbg !49
  %mul11.3 = shl nsw i32 %cond.i.i2393.3, 4, !dbg !52
  %10 = or disjoint i64 %2, 4, !dbg !53
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10, !dbg !43
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !dbg !43, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2393.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64), !dbg !49
  %mul11.4 = shl nsw i32 %cond.i.i2393.4, 4, !dbg !52
  %12 = or disjoint i64 %2, 5, !dbg !53
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12, !dbg !43
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !dbg !43, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2393.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64), !dbg !49
  %mul11.5 = shl nsw i32 %cond.i.i2393.5, 4, !dbg !52
  %14 = or disjoint i64 %2, 6, !dbg !53
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14, !dbg !43
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !dbg !43, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2393.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64), !dbg !49
  %mul11.6 = shl nsw i32 %cond.i.i2393.6, 4, !dbg !52
  %16 = or disjoint i64 %2, 7, !dbg !53
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16, !dbg !43
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !dbg !43, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2393.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64), !dbg !49
  %mul11.7 = shl nsw i32 %cond.i.i2393.7, 4, !dbg !52
  %mul20 = shl nsw i32 %0, 20
  %mul22 = shl nsw i32 %1, 10
  %add23 = add nuw nsw i32 %mul20, %mul22
  %18 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !54
  %and = shl nuw nsw i32 %18, 6
  %mul25 = and i32 %and, 960
  %add26 = or disjoint i32 %add23, %mul25
  %19 = lshr i32 %18, 1
  %mul30 = and i32 %19, 504
  %add28 = add nuw nsw i32 %add26, %mul30
  %20 = zext nneg i32 %add28 to i64, !dbg !55
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %20, !dbg !56
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16, !dbg !57
  %Q_reg.sroa.19.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !57
  %Q_reg.sroa.19.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.19.0.add.ptr.sroa_idx, align 8, !dbg !57
  %21 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %20, !dbg !56
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %21, i64 64, !dbg !56
  %Q_reg.sroa.35.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16, !dbg !57
  %Q_reg.sroa.52.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %21, i64 72, !dbg !57
  %Q_reg.sroa.52.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.52.16.add.ptr.1.sroa_idx, align 8, !dbg !57
  %or.cond2593 = icmp ult i32 %mul11, 1009, !dbg !58
  %add76 = or disjoint i32 %mul11, 15
  %cmp78.not = icmp ule i32 %add76, %1
  %or.cond4541.not4549 = select i1 %or.cond2593, i1 %cmp78.not, i1 false, !dbg !58
  %cmp81 = icmp sgt i32 %5, -1
  %or.cond4542 = select i1 %or.cond4541.not4549, i1 %cmp81, i1 false, !dbg !58
  br i1 %or.cond4542, label %land.lhs.true82, label %if.else966, !dbg !58

land.lhs.true82:                                  ; preds = %entry
  %cmp84 = icmp ult i32 %5, 64, !dbg !59
  %add87 = or disjoint i32 %mul11.1, 15
  %cmp89.not = icmp sle i32 %add87, %1
  %or.cond.not4550 = select i1 %cmp84, i1 %cmp89.not, i1 false, !dbg !60
  %cmp92 = icmp sgt i32 %7, -1
  %or.cond4543 = select i1 %or.cond.not4550, i1 %cmp92, i1 false, !dbg !60
  br i1 %or.cond4543, label %land.lhs.true93, label %if.else966, !dbg !60

land.lhs.true93:                                  ; preds = %land.lhs.true82
  %cmp95 = icmp ult i32 %7, 64, !dbg !61
  %add98 = or disjoint i32 %mul11.2, 15
  %cmp100.not = icmp sle i32 %add98, %1
  %or.cond2452.not4551 = select i1 %cmp95, i1 %cmp100.not, i1 false, !dbg !62
  %cmp103 = icmp sgt i32 %9, -1
  %or.cond4544 = select i1 %or.cond2452.not4551, i1 %cmp103, i1 false, !dbg !62
  br i1 %or.cond4544, label %land.lhs.true104, label %if.else966, !dbg !62

land.lhs.true104:                                 ; preds = %land.lhs.true93
  %cmp106 = icmp ult i32 %9, 64, !dbg !63
  %add109 = or disjoint i32 %mul11.3, 15
  %cmp111.not = icmp sle i32 %add109, %1
  %or.cond2453.not4552 = select i1 %cmp106, i1 %cmp111.not, i1 false, !dbg !64
  %cmp114 = icmp sgt i32 %11, -1
  %or.cond4545 = select i1 %or.cond2453.not4552, i1 %cmp114, i1 false, !dbg !64
  br i1 %or.cond4545, label %land.lhs.true115, label %if.else966, !dbg !64

land.lhs.true115:                                 ; preds = %land.lhs.true104
  %cmp117 = icmp ult i32 %11, 64, !dbg !65
  %add120 = or disjoint i32 %mul11.4, 15
  %cmp122.not = icmp sle i32 %add120, %1
  %or.cond2454.not4553 = select i1 %cmp117, i1 %cmp122.not, i1 false, !dbg !66
  %cmp125 = icmp sgt i32 %13, -1
  %or.cond4546 = select i1 %or.cond2454.not4553, i1 %cmp125, i1 false, !dbg !66
  br i1 %or.cond4546, label %land.lhs.true126, label %if.else966, !dbg !66

land.lhs.true126:                                 ; preds = %land.lhs.true115
  %cmp128 = icmp ult i32 %13, 64, !dbg !67
  %add131 = or disjoint i32 %mul11.5, 15
  %cmp133.not = icmp sle i32 %add131, %1
  %or.cond2455.not4554 = select i1 %cmp128, i1 %cmp133.not, i1 false, !dbg !68
  %cmp136 = icmp sgt i32 %15, -1
  %or.cond4547 = select i1 %or.cond2455.not4554, i1 %cmp136, i1 false, !dbg !68
  br i1 %or.cond4547, label %land.lhs.true137, label %if.else966, !dbg !68

land.lhs.true137:                                 ; preds = %land.lhs.true126
  %cmp139 = icmp ult i32 %15, 64, !dbg !69
  %add142 = or disjoint i32 %mul11.6, 15
  %cmp144.not = icmp sle i32 %add142, %1
  %or.cond2456.not4555 = select i1 %cmp139, i1 %cmp144.not, i1 false, !dbg !70
  %cmp147 = icmp sgt i32 %17, -1
  %or.cond4548 = select i1 %or.cond2456.not4555, i1 %cmp147, i1 false, !dbg !70
  br i1 %or.cond4548, label %land.lhs.true148, label %if.else966, !dbg !70

land.lhs.true148:                                 ; preds = %land.lhs.true137
  %cmp150 = icmp ugt i32 %17, 63, !dbg !71
  %add153 = or disjoint i32 %mul11.7, 15
  %cmp155.not = icmp sgt i32 %add153, %1
  %or.cond2457 = select i1 %cmp150, i1 true, i1 %cmp155.not, !dbg !72
  br i1 %or.cond2457, label %if.else966, label %for.cond156.preheader, !dbg !72

for.cond156.preheader:                            ; preds = %land.lhs.true148
  %conv = zext nneg i32 %0 to i64
  %22 = shl nuw nsw i32 %18, 3
  %mul195 = zext nneg i32 %22 to i64
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %mul195
  %invariant.gep2474 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %mul195
  %23 = and i32 %cond.i.i2393, 268435455
  %shr187 = zext nneg i32 %23 to i64
  %.idx = shl nuw nsw i64 %shr187, 11, !dbg !73
  %24 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx, !dbg !73
  %.idx2610 = shl nuw nsw i64 %conv, 17, !dbg !73
  %25 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 %.idx2610, !dbg !73
  %26 = load <4 x half>, ptr addrspace(4) %25, align 16, !dbg !74, !tbaa !30
  %condval.sroa.6.0.add.ptr197.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %25, i64 8, !dbg !74
  %27 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr197.sroa_idx, align 8, !dbg !74, !tbaa !30
  %.idx.1 = shl nuw nsw i64 %shr187, 11, !dbg !73
  %28 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx.1, !dbg !73
  %.idx2610.1 = shl nuw nsw i64 %conv, 17, !dbg !73
  %29 = getelementptr inbounds i8, ptr addrspace(4) %28, i64 %.idx2610.1, !dbg !73
  %gep.1 = getelementptr inbounds i8, ptr addrspace(4) %29, i64 1024, !dbg !73
  %30 = load <4 x half>, ptr addrspace(4) %gep.1, align 16, !dbg !74, !tbaa !30
  %condval.sroa.6.0.add.ptr197.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %29, i64 1032, !dbg !74
  %31 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr197.sroa_idx.1, align 8, !dbg !74, !tbaa !30
  %cmp231 = icmp slt i32 %5, 64
  %shr237 = zext nneg i32 %cond.i.i2393.1 to i64
  br i1 %cmp231, label %if.then232, label %if.end271, !dbg !75

if.then232:                                       ; preds = %for.cond156.preheader
  %.idx2611 = shl nuw nsw i64 %shr237, 11, !dbg !76
  %32 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2611, !dbg !76
  %.idx2612 = shl nuw nsw i64 %conv, 17, !dbg !76
  %33 = getelementptr inbounds i8, ptr addrspace(4) %32, i64 %.idx2612, !dbg !76
  %34 = load <4 x half>, ptr addrspace(4) %33, align 16, !dbg !77, !tbaa !30
  %condval_1.sroa.6.0.add.ptr247.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %33, i64 8, !dbg !77
  %35 = load <4 x half>, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr247.sroa_idx, align 8, !dbg !77, !tbaa !30
  br label %if.end271, !dbg !78

if.end271:                                        ; preds = %for.cond156.preheader, %if.then232
  %36 = phi <4 x half> [ %35, %if.then232 ], [ zeroinitializer, %for.cond156.preheader ], !dbg !79
  %37 = phi <4 x half> [ %34, %if.then232 ], [ zeroinitializer, %for.cond156.preheader ], !dbg !79
  br i1 %cmp231, label %if.then232.1, label %if.end271.1, !dbg !75

if.then232.1:                                     ; preds = %if.end271
  %.idx2611.1 = shl nuw nsw i64 %shr237, 11, !dbg !76
  %38 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2611.1, !dbg !76
  %.idx2612.1 = shl nuw nsw i64 %conv, 17, !dbg !76
  %39 = getelementptr inbounds i8, ptr addrspace(4) %38, i64 %.idx2612.1, !dbg !76
  %gep2466.1 = getelementptr inbounds i8, ptr addrspace(4) %39, i64 1024, !dbg !76
  %40 = load <4 x half>, ptr addrspace(4) %gep2466.1, align 16, !dbg !77, !tbaa !30
  %condval_1.sroa.6.0.add.ptr247.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %39, i64 1032, !dbg !77
  %41 = load <4 x half>, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr247.sroa_idx.1, align 8, !dbg !77, !tbaa !30
  br label %if.end271.1, !dbg !78

if.end271.1:                                      ; preds = %if.then232.1, %if.end271
  %42 = phi <4 x half> [ %41, %if.then232.1 ], [ zeroinitializer, %if.end271 ], !dbg !79
  %43 = phi <4 x half> [ %40, %if.then232.1 ], [ zeroinitializer, %if.end271 ], !dbg !79
  %cmp285 = icmp slt i32 %7, 64
  %shr291 = zext nneg i32 %cond.i.i2393.2 to i64
  br i1 %cmp285, label %if.then286, label %if.end325, !dbg !80

if.then286:                                       ; preds = %if.end271.1
  %.idx2613 = shl nuw nsw i64 %shr291, 11, !dbg !81
  %44 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2613, !dbg !81
  %.idx2614 = shl nuw nsw i64 %conv, 17, !dbg !81
  %45 = getelementptr inbounds i8, ptr addrspace(4) %44, i64 %.idx2614, !dbg !81
  %46 = load <4 x half>, ptr addrspace(4) %45, align 16, !dbg !82, !tbaa !30
  %condval_2.sroa.6.0.add.ptr301.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %45, i64 8, !dbg !82
  %47 = load <4 x half>, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr301.sroa_idx, align 8, !dbg !82, !tbaa !30
  br label %if.end325, !dbg !83

if.end325:                                        ; preds = %if.end271.1, %if.then286
  %48 = phi <4 x half> [ %47, %if.then286 ], [ zeroinitializer, %if.end271.1 ], !dbg !79
  %49 = phi <4 x half> [ %46, %if.then286 ], [ zeroinitializer, %if.end271.1 ], !dbg !79
  br i1 %cmp285, label %if.then286.1, label %if.end325.1, !dbg !80

if.then286.1:                                     ; preds = %if.end325
  %.idx2613.1 = shl nuw nsw i64 %shr291, 11, !dbg !81
  %50 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2613.1, !dbg !81
  %.idx2614.1 = shl nuw nsw i64 %conv, 17, !dbg !81
  %51 = getelementptr inbounds i8, ptr addrspace(4) %50, i64 %.idx2614.1, !dbg !81
  %gep2469.1 = getelementptr inbounds i8, ptr addrspace(4) %51, i64 1024, !dbg !81
  %52 = load <4 x half>, ptr addrspace(4) %gep2469.1, align 16, !dbg !82, !tbaa !30
  %condval_2.sroa.6.0.add.ptr301.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %51, i64 1032, !dbg !82
  %53 = load <4 x half>, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr301.sroa_idx.1, align 8, !dbg !82, !tbaa !30
  br label %if.end325.1, !dbg !83

if.end325.1:                                      ; preds = %if.then286.1, %if.end325
  %54 = phi <4 x half> [ %53, %if.then286.1 ], [ zeroinitializer, %if.end325 ], !dbg !79
  %55 = phi <4 x half> [ %52, %if.then286.1 ], [ zeroinitializer, %if.end325 ], !dbg !79
  %cmp339 = icmp slt i32 %9, 64
  %shr345 = zext nneg i32 %cond.i.i2393.3 to i64
  br i1 %cmp339, label %if.then340, label %if.end379, !dbg !84

if.then340:                                       ; preds = %if.end325.1
  %.idx2615 = shl nuw nsw i64 %shr345, 11, !dbg !85
  %56 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2615, !dbg !85
  %.idx2616 = shl nuw nsw i64 %conv, 17, !dbg !85
  %57 = getelementptr inbounds i8, ptr addrspace(4) %56, i64 %.idx2616, !dbg !85
  %58 = load <4 x half>, ptr addrspace(4) %57, align 16, !dbg !86, !tbaa !30
  %condval_3.sroa.6.0.add.ptr355.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %57, i64 8, !dbg !86
  %59 = load <4 x half>, ptr addrspace(4) %condval_3.sroa.6.0.add.ptr355.sroa_idx, align 8, !dbg !86, !tbaa !30
  br label %if.end379, !dbg !87

if.end379:                                        ; preds = %if.end325.1, %if.then340
  %60 = phi <4 x half> [ %59, %if.then340 ], [ zeroinitializer, %if.end325.1 ], !dbg !79
  %61 = phi <4 x half> [ %58, %if.then340 ], [ zeroinitializer, %if.end325.1 ], !dbg !79
  br i1 %cmp339, label %if.then340.1, label %if.end379.1, !dbg !84

if.then340.1:                                     ; preds = %if.end379
  %.idx2615.1 = shl nuw nsw i64 %shr345, 11, !dbg !85
  %62 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2615.1, !dbg !85
  %.idx2616.1 = shl nuw nsw i64 %conv, 17, !dbg !85
  %63 = getelementptr inbounds i8, ptr addrspace(4) %62, i64 %.idx2616.1, !dbg !85
  %gep2472.1 = getelementptr inbounds i8, ptr addrspace(4) %63, i64 1024, !dbg !85
  %64 = load <4 x half>, ptr addrspace(4) %gep2472.1, align 16, !dbg !86, !tbaa !30
  %condval_3.sroa.6.0.add.ptr355.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %63, i64 1032, !dbg !86
  %65 = load <4 x half>, ptr addrspace(4) %condval_3.sroa.6.0.add.ptr355.sroa_idx.1, align 8, !dbg !86, !tbaa !30
  br label %if.end379.1, !dbg !87

if.end379.1:                                      ; preds = %if.then340.1, %if.end379
  %66 = phi <4 x half> [ %65, %if.then340.1 ], [ zeroinitializer, %if.end379 ], !dbg !79
  %67 = phi <4 x half> [ %64, %if.then340.1 ], [ zeroinitializer, %if.end379 ], !dbg !79
  %.idx2617 = shl nuw nsw i64 %shr187, 11, !dbg !88
  %68 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2617, !dbg !88
  %.idx2618 = shl nuw nsw i64 %conv, 17, !dbg !88
  %69 = getelementptr inbounds i8, ptr addrspace(4) %68, i64 %.idx2618, !dbg !88
  %70 = load <4 x half>, ptr addrspace(4) %69, align 16, !dbg !89, !tbaa !30
  %condval_4.sroa.6.0.add.ptr409.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %69, i64 8, !dbg !89
  %71 = load <4 x half>, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr409.sroa_idx, align 8, !dbg !89, !tbaa !30
  %.idx2617.1 = shl nuw nsw i64 %shr187, 11, !dbg !88
  %72 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2617.1, !dbg !88
  %.idx2618.1 = shl nuw nsw i64 %conv, 17, !dbg !88
  %73 = getelementptr inbounds i8, ptr addrspace(4) %72, i64 %.idx2618.1, !dbg !88
  %gep2475.1 = getelementptr inbounds i8, ptr addrspace(4) %73, i64 1024, !dbg !88
  %74 = load <4 x half>, ptr addrspace(4) %gep2475.1, align 16, !dbg !89, !tbaa !30
  %condval_4.sroa.6.0.add.ptr409.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %73, i64 1032, !dbg !89
  %75 = load <4 x half>, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr409.sroa_idx.1, align 8, !dbg !89, !tbaa !30
  %76 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %26, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !90, !call_argsrelate !91
  %77 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %27, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %76), !dbg !90, !call_argsrelate !91
  %78 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %30, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %77), !dbg !90, !call_argsrelate !91
  %79 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %31, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %78), !dbg !90, !call_argsrelate !91
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %79, i64 0, !dbg !92
  %mul479 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !93
  %80 = tail call contract noundef float @llvm.minnum.f32(float %mul479, float 0x4024CB5EC0000000), !dbg !94
  %81 = tail call contract noundef float @llvm.exp.f32(float %80), !dbg !97
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %79, i64 1, !dbg !92
  %mul479.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !93
  %82 = tail call contract noundef float @llvm.minnum.f32(float %mul479.1, float 0x4024CB5EC0000000), !dbg !94
  %83 = tail call contract noundef float @llvm.exp.f32(float %82), !dbg !97
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %79, i64 2, !dbg !92
  %mul479.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !93
  %84 = tail call contract noundef float @llvm.minnum.f32(float %mul479.2, float 0x4024CB5EC0000000), !dbg !94
  %85 = tail call contract noundef float @llvm.exp.f32(float %84), !dbg !97
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %79, i64 3, !dbg !92
  %mul479.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !93
  %86 = tail call contract noundef float @llvm.minnum.f32(float %mul479.3, float 0x4024CB5EC0000000), !dbg !94
  %87 = tail call contract noundef float @llvm.exp.f32(float %86), !dbg !97
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %81), !dbg !100
  %89 = insertelement <4 x i16> poison, i16 %88, i64 0, !dbg !109
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %83), !dbg !100
  %91 = insertelement <4 x i16> %89, i16 %90, i64 1, !dbg !109
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %85), !dbg !100
  %93 = insertelement <4 x i16> %91, i16 %92, i64 2, !dbg !109
  %94 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %87), !dbg !100
  %95 = insertelement <4 x i16> %93, i16 %94, i64 3, !dbg !109
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %95 to <4 x half>, !dbg !109
  %96 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %70, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !110, !call_argsrelate !111
  %97 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %71, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !110, !call_argsrelate !111
  %98 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %74, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !110, !call_argsrelate !111
  %99 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %75, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !110, !call_argsrelate !111
  br i1 %cmp231, label %if.then538, label %if.end577, !dbg !112

if.then538:                                       ; preds = %if.end379.1
  %.idx2619 = shl nuw nsw i64 %shr237, 11, !dbg !113
  %100 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2619, !dbg !113
  %.idx2620 = shl nuw nsw i64 %conv, 17, !dbg !113
  %101 = getelementptr inbounds i8, ptr addrspace(4) %100, i64 %.idx2620, !dbg !113
  %102 = load <4 x half>, ptr addrspace(4) %101, align 16, !dbg !114, !tbaa !30
  %condval_5.sroa.6.0.add.ptr553.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %101, i64 8, !dbg !114
  %103 = load <4 x half>, ptr addrspace(4) %condval_5.sroa.6.0.add.ptr553.sroa_idx, align 8, !dbg !114, !tbaa !30
  br label %if.end577, !dbg !115

if.end577:                                        ; preds = %if.end379.1, %if.then538
  %104 = phi <4 x half> [ %103, %if.then538 ], [ zeroinitializer, %if.end379.1 ], !dbg !79
  %105 = phi <4 x half> [ %102, %if.then538 ], [ zeroinitializer, %if.end379.1 ], !dbg !79
  br i1 %cmp231, label %if.then538.1, label %if.end577.1, !dbg !112

if.then538.1:                                     ; preds = %if.end577
  %.idx2619.1 = shl nuw nsw i64 %shr237, 11, !dbg !113
  %106 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2619.1, !dbg !113
  %.idx2620.1 = shl nuw nsw i64 %conv, 17, !dbg !113
  %107 = getelementptr inbounds i8, ptr addrspace(4) %106, i64 %.idx2620.1, !dbg !113
  %gep2487.1 = getelementptr inbounds i8, ptr addrspace(4) %107, i64 1024, !dbg !113
  %108 = load <4 x half>, ptr addrspace(4) %gep2487.1, align 16, !dbg !114, !tbaa !30
  %condval_5.sroa.6.0.add.ptr553.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %107, i64 1032, !dbg !114
  %109 = load <4 x half>, ptr addrspace(4) %condval_5.sroa.6.0.add.ptr553.sroa_idx.1, align 8, !dbg !114, !tbaa !30
  br label %if.end577.1, !dbg !115

if.end577.1:                                      ; preds = %if.then538.1, %if.end577
  %110 = phi <4 x half> [ %109, %if.then538.1 ], [ zeroinitializer, %if.end577 ], !dbg !79
  %111 = phi <4 x half> [ %108, %if.then538.1 ], [ zeroinitializer, %if.end577 ], !dbg !79
  %112 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %37, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !116, !call_argsrelate !117
  %113 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %36, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %112), !dbg !116, !call_argsrelate !117
  %114 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %43, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %113), !dbg !116, !call_argsrelate !117
  %115 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %42, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %114), !dbg !116, !call_argsrelate !117
  %acc_s.sroa.0.0.vec.extract3094 = extractelement <4 x float> %115, i64 0, !dbg !118
  %mul623 = fmul contract float %acc_s.sroa.0.0.vec.extract3094, 0x3FB99999A0000000, !dbg !119
  %116 = tail call contract noundef float @llvm.minnum.f32(float %mul623, float 0x4024CB5EC0000000), !dbg !120
  %117 = tail call contract noundef float @llvm.exp.f32(float %116), !dbg !122
  %acc_s.sroa.0.4.vec.extract3283 = extractelement <4 x float> %115, i64 1, !dbg !118
  %mul623.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3283, 0x3FB99999A0000000, !dbg !119
  %118 = tail call contract noundef float @llvm.minnum.f32(float %mul623.1, float 0x4024CB5EC0000000), !dbg !120
  %119 = tail call contract noundef float @llvm.exp.f32(float %118), !dbg !122
  %acc_s.sroa.0.8.vec.extract3456 = extractelement <4 x float> %115, i64 2, !dbg !118
  %mul623.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3456, 0x3FB99999A0000000, !dbg !119
  %120 = tail call contract noundef float @llvm.minnum.f32(float %mul623.2, float 0x4024CB5EC0000000), !dbg !120
  %121 = tail call contract noundef float @llvm.exp.f32(float %120), !dbg !122
  %acc_s.sroa.0.12.vec.extract3629 = extractelement <4 x float> %115, i64 3, !dbg !118
  %mul623.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3629, 0x3FB99999A0000000, !dbg !119
  %122 = tail call contract noundef float @llvm.minnum.f32(float %mul623.3, float 0x4024CB5EC0000000), !dbg !120
  %123 = tail call contract noundef float @llvm.exp.f32(float %122), !dbg !122
  %add639 = fadd contract float %81, %117, !dbg !124
  %add639.1 = fadd contract float %83, %119, !dbg !124
  %add639.2 = fadd contract float %85, %121, !dbg !124
  %add639.3 = fadd contract float %87, %123, !dbg !124
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %117), !dbg !125
  %125 = insertelement <4 x i16> poison, i16 %124, i64 0, !dbg !129
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %119), !dbg !125
  %127 = insertelement <4 x i16> %125, i16 %126, i64 1, !dbg !129
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %121), !dbg !125
  %129 = insertelement <4 x i16> %127, i16 %128, i64 2, !dbg !129
  %130 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %123), !dbg !125
  %131 = insertelement <4 x i16> %129, i16 %130, i64 3, !dbg !129
  %acc_s_cast.sroa.0.6.vec.insert3027 = bitcast <4 x i16> %131 to <4 x half>, !dbg !129
  %132 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %105, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3027, <4 x float> zeroinitializer), !dbg !130
  %133 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %104, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3027, <4 x float> zeroinitializer), !dbg !130
  %134 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %111, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3027, <4 x float> zeroinitializer), !dbg !130
  %135 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %110, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3027, <4 x float> zeroinitializer), !dbg !130
  br i1 %cmp285, label %if.then682, label %if.end721, !dbg !131

if.then682:                                       ; preds = %if.end577.1
  %.idx2621 = shl nuw nsw i64 %shr291, 11, !dbg !132
  %136 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2621, !dbg !132
  %.idx2622 = shl nuw nsw i64 %conv, 17, !dbg !132
  %137 = getelementptr inbounds i8, ptr addrspace(4) %136, i64 %.idx2622, !dbg !132
  %138 = load <4 x half>, ptr addrspace(4) %137, align 16, !dbg !133, !tbaa !30
  %condval_6.sroa.6.0.add.ptr697.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %137, i64 8, !dbg !133
  %139 = load <4 x half>, ptr addrspace(4) %condval_6.sroa.6.0.add.ptr697.sroa_idx, align 8, !dbg !133, !tbaa !30
  br label %if.end721, !dbg !134

if.end721:                                        ; preds = %if.end577.1, %if.then682
  %140 = phi <4 x half> [ %139, %if.then682 ], [ zeroinitializer, %if.end577.1 ], !dbg !79
  %141 = phi <4 x half> [ %138, %if.then682 ], [ zeroinitializer, %if.end577.1 ], !dbg !79
  br i1 %cmp285, label %if.then682.1, label %if.end721.1, !dbg !131

if.then682.1:                                     ; preds = %if.end721
  %.idx2621.1 = shl nuw nsw i64 %shr291, 11, !dbg !132
  %142 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2621.1, !dbg !132
  %.idx2622.1 = shl nuw nsw i64 %conv, 17, !dbg !132
  %143 = getelementptr inbounds i8, ptr addrspace(4) %142, i64 %.idx2622.1, !dbg !132
  %gep2500.1 = getelementptr inbounds i8, ptr addrspace(4) %143, i64 1024, !dbg !132
  %144 = load <4 x half>, ptr addrspace(4) %gep2500.1, align 16, !dbg !133, !tbaa !30
  %condval_6.sroa.6.0.add.ptr697.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %143, i64 1032, !dbg !133
  %145 = load <4 x half>, ptr addrspace(4) %condval_6.sroa.6.0.add.ptr697.sroa_idx.1, align 8, !dbg !133, !tbaa !30
  br label %if.end721.1, !dbg !134

if.end721.1:                                      ; preds = %if.then682.1, %if.end721
  %146 = phi <4 x half> [ %145, %if.then682.1 ], [ zeroinitializer, %if.end721 ], !dbg !79
  %147 = phi <4 x half> [ %144, %if.then682.1 ], [ zeroinitializer, %if.end721 ], !dbg !79
  %148 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %49, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !135, !call_argsrelate !117
  %149 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %48, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %148), !dbg !135, !call_argsrelate !117
  %150 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %55, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %149), !dbg !135, !call_argsrelate !117
  %151 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %54, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %150), !dbg !135, !call_argsrelate !117
  %acc_s.sroa.0.0.vec.extract3102 = extractelement <4 x float> %151, i64 0, !dbg !136
  %mul767 = fmul contract float %acc_s.sroa.0.0.vec.extract3102, 0x3FB99999A0000000, !dbg !137
  %152 = tail call contract noundef float @llvm.minnum.f32(float %mul767, float 0x4024CB5EC0000000), !dbg !138
  %153 = tail call contract noundef float @llvm.exp.f32(float %152), !dbg !140
  %acc_s.sroa.0.4.vec.extract3291 = extractelement <4 x float> %151, i64 1, !dbg !136
  %mul767.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3291, 0x3FB99999A0000000, !dbg !137
  %154 = tail call contract noundef float @llvm.minnum.f32(float %mul767.1, float 0x4024CB5EC0000000), !dbg !138
  %155 = tail call contract noundef float @llvm.exp.f32(float %154), !dbg !140
  %acc_s.sroa.0.8.vec.extract3464 = extractelement <4 x float> %151, i64 2, !dbg !136
  %mul767.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3464, 0x3FB99999A0000000, !dbg !137
  %156 = tail call contract noundef float @llvm.minnum.f32(float %mul767.2, float 0x4024CB5EC0000000), !dbg !138
  %157 = tail call contract noundef float @llvm.exp.f32(float %156), !dbg !140
  %acc_s.sroa.0.12.vec.extract3637 = extractelement <4 x float> %151, i64 3, !dbg !136
  %mul767.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3637, 0x3FB99999A0000000, !dbg !137
  %158 = tail call contract noundef float @llvm.minnum.f32(float %mul767.3, float 0x4024CB5EC0000000), !dbg !138
  %159 = tail call contract noundef float @llvm.exp.f32(float %158), !dbg !140
  %add783 = fadd contract float %add639, %153, !dbg !142
  %add783.1 = fadd contract float %add639.1, %155, !dbg !142
  %add783.2 = fadd contract float %add639.2, %157, !dbg !142
  %add783.3 = fadd contract float %add639.3, %159, !dbg !142
  %160 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %153), !dbg !143
  %161 = insertelement <4 x i16> poison, i16 %160, i64 0, !dbg !147
  %162 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %155), !dbg !143
  %163 = insertelement <4 x i16> %161, i16 %162, i64 1, !dbg !147
  %164 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %157), !dbg !143
  %165 = insertelement <4 x i16> %163, i16 %164, i64 2, !dbg !147
  %166 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %159), !dbg !143
  %167 = insertelement <4 x i16> %165, i16 %166, i64 3, !dbg !147
  %acc_s_cast.sroa.0.6.vec.insert3029 = bitcast <4 x i16> %167 to <4 x half>, !dbg !147
  %168 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %141, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3029, <4 x float> %96), !dbg !148
  %169 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %140, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3029, <4 x float> %97), !dbg !148
  %170 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %147, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3029, <4 x float> %98), !dbg !148
  %171 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %146, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3029, <4 x float> %99), !dbg !148
  br i1 %cmp339, label %if.then826, label %if.end865, !dbg !149

if.then826:                                       ; preds = %if.end721.1
  %.idx2623 = shl nuw nsw i64 %shr345, 11, !dbg !150
  %172 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2623, !dbg !150
  %.idx2624 = shl nuw nsw i64 %conv, 17, !dbg !150
  %173 = getelementptr inbounds i8, ptr addrspace(4) %172, i64 %.idx2624, !dbg !150
  %174 = load <4 x half>, ptr addrspace(4) %173, align 16, !dbg !151, !tbaa !30
  %condval_7.sroa.6.0.add.ptr841.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %173, i64 8, !dbg !151
  %175 = load <4 x half>, ptr addrspace(4) %condval_7.sroa.6.0.add.ptr841.sroa_idx, align 8, !dbg !151, !tbaa !30
  br label %if.end865, !dbg !152

if.end865:                                        ; preds = %if.end721.1, %if.then826
  %176 = phi <4 x half> [ %175, %if.then826 ], [ zeroinitializer, %if.end721.1 ], !dbg !79
  %177 = phi <4 x half> [ %174, %if.then826 ], [ zeroinitializer, %if.end721.1 ], !dbg !79
  br i1 %cmp339, label %if.then826.1, label %if.end865.1, !dbg !149

if.then826.1:                                     ; preds = %if.end865
  %.idx2623.1 = shl nuw nsw i64 %shr345, 11, !dbg !150
  %178 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2623.1, !dbg !150
  %.idx2624.1 = shl nuw nsw i64 %conv, 17, !dbg !150
  %179 = getelementptr inbounds i8, ptr addrspace(4) %178, i64 %.idx2624.1, !dbg !150
  %gep2513.1 = getelementptr inbounds i8, ptr addrspace(4) %179, i64 1024, !dbg !150
  %180 = load <4 x half>, ptr addrspace(4) %gep2513.1, align 16, !dbg !151, !tbaa !30
  %condval_7.sroa.6.0.add.ptr841.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %179, i64 1032, !dbg !151
  %181 = load <4 x half>, ptr addrspace(4) %condval_7.sroa.6.0.add.ptr841.sroa_idx.1, align 8, !dbg !151, !tbaa !30
  br label %if.end865.1, !dbg !152

if.end865.1:                                      ; preds = %if.then826.1, %if.end865
  %182 = phi <4 x half> [ %181, %if.then826.1 ], [ zeroinitializer, %if.end865 ], !dbg !79
  %183 = phi <4 x half> [ %180, %if.then826.1 ], [ zeroinitializer, %if.end865 ], !dbg !79
  %184 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %61, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !153, !call_argsrelate !117
  %185 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %60, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %184), !dbg !153, !call_argsrelate !117
  %186 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %67, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %185), !dbg !153, !call_argsrelate !117
  %187 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %66, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %186), !dbg !153, !call_argsrelate !117
  %acc_s.sroa.0.0.vec.extract3110 = extractelement <4 x float> %187, i64 0, !dbg !154
  %mul911 = fmul contract float %acc_s.sroa.0.0.vec.extract3110, 0x3FB99999A0000000, !dbg !155
  %188 = tail call contract noundef float @llvm.minnum.f32(float %mul911, float 0x4024CB5EC0000000), !dbg !156
  %189 = tail call contract noundef float @llvm.exp.f32(float %188), !dbg !158
  %acc_s.sroa.0.4.vec.extract3299 = extractelement <4 x float> %187, i64 1, !dbg !154
  %mul911.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3299, 0x3FB99999A0000000, !dbg !155
  %190 = tail call contract noundef float @llvm.minnum.f32(float %mul911.1, float 0x4024CB5EC0000000), !dbg !156
  %191 = tail call contract noundef float @llvm.exp.f32(float %190), !dbg !158
  %acc_s.sroa.0.8.vec.extract3472 = extractelement <4 x float> %187, i64 2, !dbg !154
  %mul911.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3472, 0x3FB99999A0000000, !dbg !155
  %192 = tail call contract noundef float @llvm.minnum.f32(float %mul911.2, float 0x4024CB5EC0000000), !dbg !156
  %193 = tail call contract noundef float @llvm.exp.f32(float %192), !dbg !158
  %acc_s.sroa.0.12.vec.extract3645 = extractelement <4 x float> %187, i64 3, !dbg !154
  %mul911.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3645, 0x3FB99999A0000000, !dbg !155
  %194 = tail call contract noundef float @llvm.minnum.f32(float %mul911.3, float 0x4024CB5EC0000000), !dbg !156
  %195 = tail call contract noundef float @llvm.exp.f32(float %194), !dbg !158
  %add927 = fadd contract float %add783, %189, !dbg !160
  %add927.1 = fadd contract float %add783.1, %191, !dbg !160
  %add927.2 = fadd contract float %add783.2, %193, !dbg !160
  %add927.3 = fadd contract float %add783.3, %195, !dbg !160
  %196 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %189), !dbg !161
  %197 = insertelement <4 x i16> poison, i16 %196, i64 0, !dbg !165
  %198 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %191), !dbg !161
  %199 = insertelement <4 x i16> %197, i16 %198, i64 1, !dbg !165
  %200 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %193), !dbg !161
  %201 = insertelement <4 x i16> %199, i16 %200, i64 2, !dbg !165
  %202 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %195), !dbg !161
  %203 = insertelement <4 x i16> %201, i16 %202, i64 3, !dbg !165
  %acc_s_cast.sroa.0.6.vec.insert3031 = bitcast <4 x i16> %203 to <4 x half>, !dbg !165
  %204 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %177, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3031, <4 x float> %132), !dbg !166
  %205 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %176, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3031, <4 x float> %133), !dbg !166
  %206 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %183, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3031, <4 x float> %134), !dbg !166
  %207 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %182, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3031, <4 x float> %135), !dbg !166
  %cmp182.1 = icmp slt i32 %11, 64
  %shr187.1 = zext nneg i32 %cond.i.i2393.4 to i64
  br i1 %cmp182.1, label %if.then183.12673, label %if.end.12681, !dbg !167

if.then183.12673:                                 ; preds = %if.end865.1
  %.idx.12664 = shl nuw nsw i64 %shr187.1, 11, !dbg !73
  %208 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx.12664, !dbg !73
  %.idx2610.12665 = shl nuw nsw i64 %conv, 17, !dbg !73
  %209 = getelementptr inbounds i8, ptr addrspace(4) %208, i64 %.idx2610.12665, !dbg !73
  %210 = load <4 x half>, ptr addrspace(4) %209, align 16, !dbg !74, !tbaa !30
  %condval.sroa.6.0.add.ptr197.sroa_idx.12669 = getelementptr inbounds i8, ptr addrspace(4) %209, i64 8, !dbg !74
  %211 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr197.sroa_idx.12669, align 8, !dbg !74, !tbaa !30
  br label %if.end.12681, !dbg !168

if.end.12681:                                     ; preds = %if.then183.12673, %if.end865.1
  %212 = phi <4 x half> [ %211, %if.then183.12673 ], [ zeroinitializer, %if.end865.1 ], !dbg !79
  %213 = phi <4 x half> [ %210, %if.then183.12673 ], [ zeroinitializer, %if.end865.1 ], !dbg !79
  br i1 %cmp182.1, label %if.then183.1.1, label %if.end.1.1, !dbg !167

if.then183.1.1:                                   ; preds = %if.end.12681
  %.idx.1.1 = shl nuw nsw i64 %shr187.1, 11, !dbg !73
  %214 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx.1.1, !dbg !73
  %.idx2610.1.1 = shl nuw nsw i64 %conv, 17, !dbg !73
  %215 = getelementptr inbounds i8, ptr addrspace(4) %214, i64 %.idx2610.1.1, !dbg !73
  %gep.1.1 = getelementptr inbounds i8, ptr addrspace(4) %215, i64 1024, !dbg !73
  %216 = load <4 x half>, ptr addrspace(4) %gep.1.1, align 16, !dbg !74, !tbaa !30
  %condval.sroa.6.0.add.ptr197.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %215, i64 1032, !dbg !74
  %217 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr197.sroa_idx.1.1, align 8, !dbg !74, !tbaa !30
  br label %if.end.1.1, !dbg !168

if.end.1.1:                                       ; preds = %if.then183.1.1, %if.end.12681
  %218 = phi <4 x half> [ %217, %if.then183.1.1 ], [ zeroinitializer, %if.end.12681 ], !dbg !79
  %219 = phi <4 x half> [ %216, %if.then183.1.1 ], [ zeroinitializer, %if.end.12681 ], !dbg !79
  %cmp231.1 = icmp slt i32 %13, 64
  %shr237.1 = zext nneg i32 %cond.i.i2393.5 to i64
  br i1 %cmp231.1, label %if.then232.12692, label %if.end271.12700, !dbg !75

if.then232.12692:                                 ; preds = %if.end.1.1
  %.idx2611.12683 = shl nuw nsw i64 %shr237.1, 11, !dbg !76
  %220 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2611.12683, !dbg !76
  %.idx2612.12684 = shl nuw nsw i64 %conv, 17, !dbg !76
  %221 = getelementptr inbounds i8, ptr addrspace(4) %220, i64 %.idx2612.12684, !dbg !76
  %222 = load <4 x half>, ptr addrspace(4) %221, align 16, !dbg !77, !tbaa !30
  %condval_1.sroa.6.0.add.ptr247.sroa_idx.12688 = getelementptr inbounds i8, ptr addrspace(4) %221, i64 8, !dbg !77
  %223 = load <4 x half>, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr247.sroa_idx.12688, align 8, !dbg !77, !tbaa !30
  br label %if.end271.12700, !dbg !78

if.end271.12700:                                  ; preds = %if.then232.12692, %if.end.1.1
  %224 = phi <4 x half> [ %223, %if.then232.12692 ], [ zeroinitializer, %if.end.1.1 ], !dbg !79
  %225 = phi <4 x half> [ %222, %if.then232.12692 ], [ zeroinitializer, %if.end.1.1 ], !dbg !79
  br i1 %cmp231.1, label %if.then232.1.1, label %if.end271.1.1, !dbg !75

if.then232.1.1:                                   ; preds = %if.end271.12700
  %.idx2611.1.1 = shl nuw nsw i64 %shr237.1, 11, !dbg !76
  %226 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2611.1.1, !dbg !76
  %.idx2612.1.1 = shl nuw nsw i64 %conv, 17, !dbg !76
  %227 = getelementptr inbounds i8, ptr addrspace(4) %226, i64 %.idx2612.1.1, !dbg !76
  %gep2466.1.1 = getelementptr inbounds i8, ptr addrspace(4) %227, i64 1024, !dbg !76
  %228 = load <4 x half>, ptr addrspace(4) %gep2466.1.1, align 16, !dbg !77, !tbaa !30
  %condval_1.sroa.6.0.add.ptr247.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %227, i64 1032, !dbg !77
  %229 = load <4 x half>, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr247.sroa_idx.1.1, align 8, !dbg !77, !tbaa !30
  br label %if.end271.1.1, !dbg !78

if.end271.1.1:                                    ; preds = %if.then232.1.1, %if.end271.12700
  %230 = phi <4 x half> [ %229, %if.then232.1.1 ], [ zeroinitializer, %if.end271.12700 ], !dbg !79
  %231 = phi <4 x half> [ %228, %if.then232.1.1 ], [ zeroinitializer, %if.end271.12700 ], !dbg !79
  %cmp285.1 = icmp slt i32 %15, 64
  %shr291.1 = zext nneg i32 %cond.i.i2393.6 to i64
  br i1 %cmp285.1, label %if.then286.12711, label %if.end325.12719, !dbg !80

if.then286.12711:                                 ; preds = %if.end271.1.1
  %.idx2613.12702 = shl nuw nsw i64 %shr291.1, 11, !dbg !81
  %232 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2613.12702, !dbg !81
  %.idx2614.12703 = shl nuw nsw i64 %conv, 17, !dbg !81
  %233 = getelementptr inbounds i8, ptr addrspace(4) %232, i64 %.idx2614.12703, !dbg !81
  %234 = load <4 x half>, ptr addrspace(4) %233, align 16, !dbg !82, !tbaa !30
  %condval_2.sroa.6.0.add.ptr301.sroa_idx.12707 = getelementptr inbounds i8, ptr addrspace(4) %233, i64 8, !dbg !82
  %235 = load <4 x half>, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr301.sroa_idx.12707, align 8, !dbg !82, !tbaa !30
  br label %if.end325.12719, !dbg !83

if.end325.12719:                                  ; preds = %if.then286.12711, %if.end271.1.1
  %236 = phi <4 x half> [ %235, %if.then286.12711 ], [ zeroinitializer, %if.end271.1.1 ], !dbg !79
  %237 = phi <4 x half> [ %234, %if.then286.12711 ], [ zeroinitializer, %if.end271.1.1 ], !dbg !79
  br i1 %cmp285.1, label %if.then286.1.1, label %if.end325.1.1, !dbg !80

if.then286.1.1:                                   ; preds = %if.end325.12719
  %.idx2613.1.1 = shl nuw nsw i64 %shr291.1, 11, !dbg !81
  %238 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2613.1.1, !dbg !81
  %.idx2614.1.1 = shl nuw nsw i64 %conv, 17, !dbg !81
  %239 = getelementptr inbounds i8, ptr addrspace(4) %238, i64 %.idx2614.1.1, !dbg !81
  %gep2469.1.1 = getelementptr inbounds i8, ptr addrspace(4) %239, i64 1024, !dbg !81
  %240 = load <4 x half>, ptr addrspace(4) %gep2469.1.1, align 16, !dbg !82, !tbaa !30
  %condval_2.sroa.6.0.add.ptr301.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %239, i64 1032, !dbg !82
  %241 = load <4 x half>, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr301.sroa_idx.1.1, align 8, !dbg !82, !tbaa !30
  br label %if.end325.1.1, !dbg !83

if.end325.1.1:                                    ; preds = %if.then286.1.1, %if.end325.12719
  %242 = phi <4 x half> [ %241, %if.then286.1.1 ], [ zeroinitializer, %if.end325.12719 ], !dbg !79
  %243 = phi <4 x half> [ %240, %if.then286.1.1 ], [ zeroinitializer, %if.end325.12719 ], !dbg !79
  %cmp339.1 = icmp slt i32 %17, 64
  %shr345.1 = zext nneg i32 %cond.i.i2393.7 to i64
  br i1 %cmp339.1, label %if.then340.12730, label %if.end379.12738, !dbg !84

if.then340.12730:                                 ; preds = %if.end325.1.1
  %.idx2615.12721 = shl nuw nsw i64 %shr345.1, 11, !dbg !85
  %244 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2615.12721, !dbg !85
  %.idx2616.12722 = shl nuw nsw i64 %conv, 17, !dbg !85
  %245 = getelementptr inbounds i8, ptr addrspace(4) %244, i64 %.idx2616.12722, !dbg !85
  %246 = load <4 x half>, ptr addrspace(4) %245, align 16, !dbg !86, !tbaa !30
  %condval_3.sroa.6.0.add.ptr355.sroa_idx.12726 = getelementptr inbounds i8, ptr addrspace(4) %245, i64 8, !dbg !86
  %247 = load <4 x half>, ptr addrspace(4) %condval_3.sroa.6.0.add.ptr355.sroa_idx.12726, align 8, !dbg !86, !tbaa !30
  br label %if.end379.12738, !dbg !87

if.end379.12738:                                  ; preds = %if.then340.12730, %if.end325.1.1
  %248 = phi <4 x half> [ %247, %if.then340.12730 ], [ zeroinitializer, %if.end325.1.1 ], !dbg !79
  %249 = phi <4 x half> [ %246, %if.then340.12730 ], [ zeroinitializer, %if.end325.1.1 ], !dbg !79
  br i1 %cmp339.1, label %if.then340.1.1, label %if.end379.1.1, !dbg !84

if.then340.1.1:                                   ; preds = %if.end379.12738
  %.idx2615.1.1 = shl nuw nsw i64 %shr345.1, 11, !dbg !85
  %250 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2615.1.1, !dbg !85
  %.idx2616.1.1 = shl nuw nsw i64 %conv, 17, !dbg !85
  %251 = getelementptr inbounds i8, ptr addrspace(4) %250, i64 %.idx2616.1.1, !dbg !85
  %gep2472.1.1 = getelementptr inbounds i8, ptr addrspace(4) %251, i64 1024, !dbg !85
  %252 = load <4 x half>, ptr addrspace(4) %gep2472.1.1, align 16, !dbg !86, !tbaa !30
  %condval_3.sroa.6.0.add.ptr355.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %251, i64 1032, !dbg !86
  %253 = load <4 x half>, ptr addrspace(4) %condval_3.sroa.6.0.add.ptr355.sroa_idx.1.1, align 8, !dbg !86, !tbaa !30
  br label %if.end379.1.1, !dbg !87

if.end379.1.1:                                    ; preds = %if.then340.1.1, %if.end379.12738
  %254 = phi <4 x half> [ %253, %if.then340.1.1 ], [ zeroinitializer, %if.end379.12738 ], !dbg !79
  %255 = phi <4 x half> [ %252, %if.then340.1.1 ], [ zeroinitializer, %if.end379.12738 ], !dbg !79
  br i1 %cmp182.1, label %if.then394.12749, label %if.end433.12757, !dbg !169

if.then394.12749:                                 ; preds = %if.end379.1.1
  %.idx2617.12740 = shl nuw nsw i64 %shr187.1, 11, !dbg !88
  %256 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2617.12740, !dbg !88
  %.idx2618.12741 = shl nuw nsw i64 %conv, 17, !dbg !88
  %257 = getelementptr inbounds i8, ptr addrspace(4) %256, i64 %.idx2618.12741, !dbg !88
  %258 = load <4 x half>, ptr addrspace(4) %257, align 16, !dbg !89, !tbaa !30
  %condval_4.sroa.6.0.add.ptr409.sroa_idx.12745 = getelementptr inbounds i8, ptr addrspace(4) %257, i64 8, !dbg !89
  %259 = load <4 x half>, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr409.sroa_idx.12745, align 8, !dbg !89, !tbaa !30
  br label %if.end433.12757, !dbg !170

if.end433.12757:                                  ; preds = %if.then394.12749, %if.end379.1.1
  %260 = phi <4 x half> [ %259, %if.then394.12749 ], [ zeroinitializer, %if.end379.1.1 ], !dbg !79
  %261 = phi <4 x half> [ %258, %if.then394.12749 ], [ zeroinitializer, %if.end379.1.1 ], !dbg !79
  br i1 %cmp182.1, label %if.then394.1.1, label %if.end433.1.1, !dbg !169

if.then394.1.1:                                   ; preds = %if.end433.12757
  %.idx2617.1.1 = shl nuw nsw i64 %shr187.1, 11, !dbg !88
  %262 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2617.1.1, !dbg !88
  %.idx2618.1.1 = shl nuw nsw i64 %conv, 17, !dbg !88
  %263 = getelementptr inbounds i8, ptr addrspace(4) %262, i64 %.idx2618.1.1, !dbg !88
  %gep2475.1.1 = getelementptr inbounds i8, ptr addrspace(4) %263, i64 1024, !dbg !88
  %264 = load <4 x half>, ptr addrspace(4) %gep2475.1.1, align 16, !dbg !89, !tbaa !30
  %condval_4.sroa.6.0.add.ptr409.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %263, i64 1032, !dbg !89
  %265 = load <4 x half>, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr409.sroa_idx.1.1, align 8, !dbg !89, !tbaa !30
  br label %if.end433.1.1, !dbg !170

if.end433.1.1:                                    ; preds = %if.then394.1.1, %if.end433.12757
  %266 = phi <4 x half> [ %265, %if.then394.1.1 ], [ zeroinitializer, %if.end433.12757 ], !dbg !79
  %267 = phi <4 x half> [ %264, %if.then394.1.1 ], [ zeroinitializer, %if.end433.12757 ], !dbg !79
  %268 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %213, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !90, !call_argsrelate !117
  %269 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %212, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %268), !dbg !90, !call_argsrelate !117
  %270 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %219, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %269), !dbg !90, !call_argsrelate !117
  %271 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %218, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %270), !dbg !90, !call_argsrelate !117
  %acc_s.sroa.0.0.vec.extract3120 = extractelement <4 x float> %271, i64 0, !dbg !92
  %mul479.12761 = fmul contract float %acc_s.sroa.0.0.vec.extract3120, 0x3FB99999A0000000, !dbg !93
  %272 = tail call contract noundef float @llvm.minnum.f32(float %mul479.12761, float 0x4024CB5EC0000000), !dbg !94
  %273 = tail call contract noundef float @llvm.exp.f32(float %272), !dbg !97
  %acc_s.sroa.0.4.vec.extract3307 = extractelement <4 x float> %271, i64 1, !dbg !92
  %mul479.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3307, 0x3FB99999A0000000, !dbg !93
  %274 = tail call contract noundef float @llvm.minnum.f32(float %mul479.1.1, float 0x4024CB5EC0000000), !dbg !94
  %275 = tail call contract noundef float @llvm.exp.f32(float %274), !dbg !97
  %acc_s.sroa.0.8.vec.extract3480 = extractelement <4 x float> %271, i64 2, !dbg !92
  %mul479.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3480, 0x3FB99999A0000000, !dbg !93
  %276 = tail call contract noundef float @llvm.minnum.f32(float %mul479.2.1, float 0x4024CB5EC0000000), !dbg !94
  %277 = tail call contract noundef float @llvm.exp.f32(float %276), !dbg !97
  %acc_s.sroa.0.12.vec.extract3653 = extractelement <4 x float> %271, i64 3, !dbg !92
  %mul479.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3653, 0x3FB99999A0000000, !dbg !93
  %278 = tail call contract noundef float @llvm.minnum.f32(float %mul479.3.1, float 0x4024CB5EC0000000), !dbg !94
  %279 = tail call contract noundef float @llvm.exp.f32(float %278), !dbg !97
  %add495.12762 = fadd contract float %add927, %273, !dbg !171
  %add495.1.1 = fadd contract float %add927.1, %275, !dbg !171
  %add495.2.1 = fadd contract float %add927.2, %277, !dbg !171
  %add495.3.1 = fadd contract float %add927.3, %279, !dbg !171
  %280 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %273), !dbg !100
  %281 = insertelement <4 x i16> poison, i16 %280, i64 0, !dbg !109
  %282 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %275), !dbg !100
  %283 = insertelement <4 x i16> %281, i16 %282, i64 1, !dbg !109
  %284 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %277), !dbg !100
  %285 = insertelement <4 x i16> %283, i16 %284, i64 2, !dbg !109
  %286 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %279), !dbg !100
  %287 = insertelement <4 x i16> %285, i16 %286, i64 3, !dbg !109
  %acc_s_cast.sroa.0.6.vec.insert3033 = bitcast <4 x i16> %287 to <4 x half>, !dbg !109
  %288 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %261, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3033, <4 x float> %168), !dbg !110
  %289 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %260, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3033, <4 x float> %169), !dbg !110
  %290 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %267, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3033, <4 x float> %170), !dbg !110
  %291 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %266, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3033, <4 x float> %171), !dbg !110
  br i1 %cmp231.1, label %if.then538.12773, label %if.end577.12781, !dbg !112

if.then538.12773:                                 ; preds = %if.end433.1.1
  %.idx2619.12764 = shl nuw nsw i64 %shr237.1, 11, !dbg !113
  %292 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2619.12764, !dbg !113
  %.idx2620.12765 = shl nuw nsw i64 %conv, 17, !dbg !113
  %293 = getelementptr inbounds i8, ptr addrspace(4) %292, i64 %.idx2620.12765, !dbg !113
  %294 = load <4 x half>, ptr addrspace(4) %293, align 16, !dbg !114, !tbaa !30
  %condval_5.sroa.6.0.add.ptr553.sroa_idx.12769 = getelementptr inbounds i8, ptr addrspace(4) %293, i64 8, !dbg !114
  %295 = load <4 x half>, ptr addrspace(4) %condval_5.sroa.6.0.add.ptr553.sroa_idx.12769, align 8, !dbg !114, !tbaa !30
  br label %if.end577.12781, !dbg !115

if.end577.12781:                                  ; preds = %if.then538.12773, %if.end433.1.1
  %296 = phi <4 x half> [ %295, %if.then538.12773 ], [ zeroinitializer, %if.end433.1.1 ], !dbg !79
  %297 = phi <4 x half> [ %294, %if.then538.12773 ], [ zeroinitializer, %if.end433.1.1 ], !dbg !79
  br i1 %cmp231.1, label %if.then538.1.1, label %if.end577.1.1, !dbg !112

if.then538.1.1:                                   ; preds = %if.end577.12781
  %.idx2619.1.1 = shl nuw nsw i64 %shr237.1, 11, !dbg !113
  %298 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2619.1.1, !dbg !113
  %.idx2620.1.1 = shl nuw nsw i64 %conv, 17, !dbg !113
  %299 = getelementptr inbounds i8, ptr addrspace(4) %298, i64 %.idx2620.1.1, !dbg !113
  %gep2487.1.1 = getelementptr inbounds i8, ptr addrspace(4) %299, i64 1024, !dbg !113
  %300 = load <4 x half>, ptr addrspace(4) %gep2487.1.1, align 16, !dbg !114, !tbaa !30
  %condval_5.sroa.6.0.add.ptr553.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %299, i64 1032, !dbg !114
  %301 = load <4 x half>, ptr addrspace(4) %condval_5.sroa.6.0.add.ptr553.sroa_idx.1.1, align 8, !dbg !114, !tbaa !30
  br label %if.end577.1.1, !dbg !115

if.end577.1.1:                                    ; preds = %if.then538.1.1, %if.end577.12781
  %302 = phi <4 x half> [ %301, %if.then538.1.1 ], [ zeroinitializer, %if.end577.12781 ], !dbg !79
  %303 = phi <4 x half> [ %300, %if.then538.1.1 ], [ zeroinitializer, %if.end577.12781 ], !dbg !79
  %304 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %225, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !116, !call_argsrelate !117
  %305 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %224, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %304), !dbg !116, !call_argsrelate !117
  %306 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %231, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %305), !dbg !116, !call_argsrelate !117
  %307 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %230, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %306), !dbg !116, !call_argsrelate !117
  %acc_s.sroa.0.0.vec.extract3130 = extractelement <4 x float> %307, i64 0, !dbg !118
  %mul623.12785 = fmul contract float %acc_s.sroa.0.0.vec.extract3130, 0x3FB99999A0000000, !dbg !119
  %308 = tail call contract noundef float @llvm.minnum.f32(float %mul623.12785, float 0x4024CB5EC0000000), !dbg !120
  %309 = tail call contract noundef float @llvm.exp.f32(float %308), !dbg !122
  %acc_s.sroa.0.4.vec.extract3315 = extractelement <4 x float> %307, i64 1, !dbg !118
  %mul623.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3315, 0x3FB99999A0000000, !dbg !119
  %310 = tail call contract noundef float @llvm.minnum.f32(float %mul623.1.1, float 0x4024CB5EC0000000), !dbg !120
  %311 = tail call contract noundef float @llvm.exp.f32(float %310), !dbg !122
  %acc_s.sroa.0.8.vec.extract3488 = extractelement <4 x float> %307, i64 2, !dbg !118
  %mul623.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3488, 0x3FB99999A0000000, !dbg !119
  %312 = tail call contract noundef float @llvm.minnum.f32(float %mul623.2.1, float 0x4024CB5EC0000000), !dbg !120
  %313 = tail call contract noundef float @llvm.exp.f32(float %312), !dbg !122
  %acc_s.sroa.0.12.vec.extract3661 = extractelement <4 x float> %307, i64 3, !dbg !118
  %mul623.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3661, 0x3FB99999A0000000, !dbg !119
  %314 = tail call contract noundef float @llvm.minnum.f32(float %mul623.3.1, float 0x4024CB5EC0000000), !dbg !120
  %315 = tail call contract noundef float @llvm.exp.f32(float %314), !dbg !122
  %add639.12786 = fadd contract float %add495.12762, %309, !dbg !124
  %add639.1.1 = fadd contract float %add495.1.1, %311, !dbg !124
  %add639.2.1 = fadd contract float %add495.2.1, %313, !dbg !124
  %add639.3.1 = fadd contract float %add495.3.1, %315, !dbg !124
  %316 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %309), !dbg !125
  %317 = insertelement <4 x i16> poison, i16 %316, i64 0, !dbg !129
  %318 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %311), !dbg !125
  %319 = insertelement <4 x i16> %317, i16 %318, i64 1, !dbg !129
  %320 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %313), !dbg !125
  %321 = insertelement <4 x i16> %319, i16 %320, i64 2, !dbg !129
  %322 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %315), !dbg !125
  %323 = insertelement <4 x i16> %321, i16 %322, i64 3, !dbg !129
  %acc_s_cast.sroa.0.6.vec.insert3035 = bitcast <4 x i16> %323 to <4 x half>, !dbg !129
  %324 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %297, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3035, <4 x float> %204), !dbg !130
  %325 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %296, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3035, <4 x float> %205), !dbg !130
  %326 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %303, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3035, <4 x float> %206), !dbg !130
  %327 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %302, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3035, <4 x float> %207), !dbg !130
  br i1 %cmp285.1, label %if.then682.12797, label %if.end721.12805, !dbg !131

if.then682.12797:                                 ; preds = %if.end577.1.1
  %.idx2621.12788 = shl nuw nsw i64 %shr291.1, 11, !dbg !132
  %328 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2621.12788, !dbg !132
  %.idx2622.12789 = shl nuw nsw i64 %conv, 17, !dbg !132
  %329 = getelementptr inbounds i8, ptr addrspace(4) %328, i64 %.idx2622.12789, !dbg !132
  %330 = load <4 x half>, ptr addrspace(4) %329, align 16, !dbg !133, !tbaa !30
  %condval_6.sroa.6.0.add.ptr697.sroa_idx.12793 = getelementptr inbounds i8, ptr addrspace(4) %329, i64 8, !dbg !133
  %331 = load <4 x half>, ptr addrspace(4) %condval_6.sroa.6.0.add.ptr697.sroa_idx.12793, align 8, !dbg !133, !tbaa !30
  br label %if.end721.12805, !dbg !134

if.end721.12805:                                  ; preds = %if.then682.12797, %if.end577.1.1
  %332 = phi <4 x half> [ %331, %if.then682.12797 ], [ zeroinitializer, %if.end577.1.1 ], !dbg !79
  %333 = phi <4 x half> [ %330, %if.then682.12797 ], [ zeroinitializer, %if.end577.1.1 ], !dbg !79
  br i1 %cmp285.1, label %if.then682.1.1, label %if.end721.1.1, !dbg !131

if.then682.1.1:                                   ; preds = %if.end721.12805
  %.idx2621.1.1 = shl nuw nsw i64 %shr291.1, 11, !dbg !132
  %334 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2621.1.1, !dbg !132
  %.idx2622.1.1 = shl nuw nsw i64 %conv, 17, !dbg !132
  %335 = getelementptr inbounds i8, ptr addrspace(4) %334, i64 %.idx2622.1.1, !dbg !132
  %gep2500.1.1 = getelementptr inbounds i8, ptr addrspace(4) %335, i64 1024, !dbg !132
  %336 = load <4 x half>, ptr addrspace(4) %gep2500.1.1, align 16, !dbg !133, !tbaa !30
  %condval_6.sroa.6.0.add.ptr697.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %335, i64 1032, !dbg !133
  %337 = load <4 x half>, ptr addrspace(4) %condval_6.sroa.6.0.add.ptr697.sroa_idx.1.1, align 8, !dbg !133, !tbaa !30
  br label %if.end721.1.1, !dbg !134

if.end721.1.1:                                    ; preds = %if.then682.1.1, %if.end721.12805
  %338 = phi <4 x half> [ %337, %if.then682.1.1 ], [ zeroinitializer, %if.end721.12805 ], !dbg !79
  %339 = phi <4 x half> [ %336, %if.then682.1.1 ], [ zeroinitializer, %if.end721.12805 ], !dbg !79
  %340 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %237, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !135, !call_argsrelate !117
  %341 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %236, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %340), !dbg !135, !call_argsrelate !117
  %342 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %243, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %341), !dbg !135, !call_argsrelate !117
  %343 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %242, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %342), !dbg !135, !call_argsrelate !117
  %acc_s.sroa.0.0.vec.extract3140 = extractelement <4 x float> %343, i64 0, !dbg !136
  %mul767.12809 = fmul contract float %acc_s.sroa.0.0.vec.extract3140, 0x3FB99999A0000000, !dbg !137
  %344 = tail call contract noundef float @llvm.minnum.f32(float %mul767.12809, float 0x4024CB5EC0000000), !dbg !138
  %345 = tail call contract noundef float @llvm.exp.f32(float %344), !dbg !140
  %acc_s.sroa.0.4.vec.extract3323 = extractelement <4 x float> %343, i64 1, !dbg !136
  %mul767.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3323, 0x3FB99999A0000000, !dbg !137
  %346 = tail call contract noundef float @llvm.minnum.f32(float %mul767.1.1, float 0x4024CB5EC0000000), !dbg !138
  %347 = tail call contract noundef float @llvm.exp.f32(float %346), !dbg !140
  %acc_s.sroa.0.8.vec.extract3496 = extractelement <4 x float> %343, i64 2, !dbg !136
  %mul767.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3496, 0x3FB99999A0000000, !dbg !137
  %348 = tail call contract noundef float @llvm.minnum.f32(float %mul767.2.1, float 0x4024CB5EC0000000), !dbg !138
  %349 = tail call contract noundef float @llvm.exp.f32(float %348), !dbg !140
  %acc_s.sroa.0.12.vec.extract3669 = extractelement <4 x float> %343, i64 3, !dbg !136
  %mul767.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3669, 0x3FB99999A0000000, !dbg !137
  %350 = tail call contract noundef float @llvm.minnum.f32(float %mul767.3.1, float 0x4024CB5EC0000000), !dbg !138
  %351 = tail call contract noundef float @llvm.exp.f32(float %350), !dbg !140
  %add783.12810 = fadd contract float %add639.12786, %345, !dbg !142
  %add783.1.1 = fadd contract float %add639.1.1, %347, !dbg !142
  %add783.2.1 = fadd contract float %add639.2.1, %349, !dbg !142
  %add783.3.1 = fadd contract float %add639.3.1, %351, !dbg !142
  %352 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %345), !dbg !143
  %353 = insertelement <4 x i16> poison, i16 %352, i64 0, !dbg !147
  %354 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %347), !dbg !143
  %355 = insertelement <4 x i16> %353, i16 %354, i64 1, !dbg !147
  %356 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %349), !dbg !143
  %357 = insertelement <4 x i16> %355, i16 %356, i64 2, !dbg !147
  %358 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %351), !dbg !143
  %359 = insertelement <4 x i16> %357, i16 %358, i64 3, !dbg !147
  %acc_s_cast.sroa.0.6.vec.insert3037 = bitcast <4 x i16> %359 to <4 x half>, !dbg !147
  %360 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %333, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3037, <4 x float> %288), !dbg !148
  %361 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %332, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3037, <4 x float> %289), !dbg !148
  %362 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %339, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3037, <4 x float> %290), !dbg !148
  %363 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %338, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3037, <4 x float> %291), !dbg !148
  br i1 %cmp339.1, label %if.then826.12821, label %if.end865.12829, !dbg !149

if.then826.12821:                                 ; preds = %if.end721.1.1
  %.idx2623.12812 = shl nuw nsw i64 %shr345.1, 11, !dbg !150
  %364 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2623.12812, !dbg !150
  %.idx2624.12813 = shl nuw nsw i64 %conv, 17, !dbg !150
  %365 = getelementptr inbounds i8, ptr addrspace(4) %364, i64 %.idx2624.12813, !dbg !150
  %366 = load <4 x half>, ptr addrspace(4) %365, align 16, !dbg !151, !tbaa !30
  %condval_7.sroa.6.0.add.ptr841.sroa_idx.12817 = getelementptr inbounds i8, ptr addrspace(4) %365, i64 8, !dbg !151
  %367 = load <4 x half>, ptr addrspace(4) %condval_7.sroa.6.0.add.ptr841.sroa_idx.12817, align 8, !dbg !151, !tbaa !30
  br label %if.end865.12829, !dbg !152

if.end865.12829:                                  ; preds = %if.then826.12821, %if.end721.1.1
  %368 = phi <4 x half> [ %367, %if.then826.12821 ], [ zeroinitializer, %if.end721.1.1 ], !dbg !79
  %369 = phi <4 x half> [ %366, %if.then826.12821 ], [ zeroinitializer, %if.end721.1.1 ], !dbg !79
  br i1 %cmp339.1, label %if.then826.1.1, label %if.end865.1.1, !dbg !149

if.then826.1.1:                                   ; preds = %if.end865.12829
  %.idx2623.1.1 = shl nuw nsw i64 %shr345.1, 11, !dbg !150
  %370 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2474, i64 %.idx2623.1.1, !dbg !150
  %.idx2624.1.1 = shl nuw nsw i64 %conv, 17, !dbg !150
  %371 = getelementptr inbounds i8, ptr addrspace(4) %370, i64 %.idx2624.1.1, !dbg !150
  %gep2513.1.1 = getelementptr inbounds i8, ptr addrspace(4) %371, i64 1024, !dbg !150
  %372 = load <4 x half>, ptr addrspace(4) %gep2513.1.1, align 16, !dbg !151, !tbaa !30
  %condval_7.sroa.6.0.add.ptr841.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %371, i64 1032, !dbg !151
  %373 = load <4 x half>, ptr addrspace(4) %condval_7.sroa.6.0.add.ptr841.sroa_idx.1.1, align 8, !dbg !151, !tbaa !30
  br label %if.end865.1.1, !dbg !152

if.end865.1.1:                                    ; preds = %if.then826.1.1, %if.end865.12829
  %374 = phi <4 x half> [ %373, %if.then826.1.1 ], [ zeroinitializer, %if.end865.12829 ], !dbg !79
  %375 = phi <4 x half> [ %372, %if.then826.1.1 ], [ zeroinitializer, %if.end865.12829 ], !dbg !79
  %376 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %249, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !153, !call_argsrelate !117
  %377 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %248, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %376), !dbg !153, !call_argsrelate !117
  %378 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %255, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %377), !dbg !153, !call_argsrelate !117
  %379 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %254, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %378), !dbg !153, !call_argsrelate !117
  %acc_s.sroa.0.0.vec.extract3150 = extractelement <4 x float> %379, i64 0, !dbg !154
  %mul911.12833 = fmul contract float %acc_s.sroa.0.0.vec.extract3150, 0x3FB99999A0000000, !dbg !155
  %380 = tail call contract noundef float @llvm.minnum.f32(float %mul911.12833, float 0x4024CB5EC0000000), !dbg !156
  %381 = tail call contract noundef float @llvm.exp.f32(float %380), !dbg !158
  %acc_s.sroa.0.4.vec.extract3331 = extractelement <4 x float> %379, i64 1, !dbg !154
  %mul911.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3331, 0x3FB99999A0000000, !dbg !155
  %382 = tail call contract noundef float @llvm.minnum.f32(float %mul911.1.1, float 0x4024CB5EC0000000), !dbg !156
  %383 = tail call contract noundef float @llvm.exp.f32(float %382), !dbg !158
  %acc_s.sroa.0.8.vec.extract3504 = extractelement <4 x float> %379, i64 2, !dbg !154
  %mul911.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3504, 0x3FB99999A0000000, !dbg !155
  %384 = tail call contract noundef float @llvm.minnum.f32(float %mul911.2.1, float 0x4024CB5EC0000000), !dbg !156
  %385 = tail call contract noundef float @llvm.exp.f32(float %384), !dbg !158
  %acc_s.sroa.0.12.vec.extract3677 = extractelement <4 x float> %379, i64 3, !dbg !154
  %mul911.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3677, 0x3FB99999A0000000, !dbg !155
  %386 = tail call contract noundef float @llvm.minnum.f32(float %mul911.3.1, float 0x4024CB5EC0000000), !dbg !156
  %387 = tail call contract noundef float @llvm.exp.f32(float %386), !dbg !158
  %add927.12834 = fadd contract float %add783.12810, %381, !dbg !160
  %add927.1.1 = fadd contract float %add783.1.1, %383, !dbg !160
  %add927.2.1 = fadd contract float %add783.2.1, %385, !dbg !160
  %add927.3.1 = fadd contract float %add783.3.1, %387, !dbg !160
  %388 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %381), !dbg !161
  %389 = insertelement <4 x i16> poison, i16 %388, i64 0, !dbg !165
  %390 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %383), !dbg !161
  %391 = insertelement <4 x i16> %389, i16 %390, i64 1, !dbg !165
  %392 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %385), !dbg !161
  %393 = insertelement <4 x i16> %391, i16 %392, i64 2, !dbg !165
  %394 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %387), !dbg !161
  %395 = insertelement <4 x i16> %393, i16 %394, i64 3, !dbg !165
  %acc_s_cast.sroa.0.6.vec.insert3039 = bitcast <4 x i16> %395 to <4 x half>, !dbg !165
  %396 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %369, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3039, <4 x float> %324), !dbg !166
  %397 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %368, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3039, <4 x float> %325), !dbg !166
  %398 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %375, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3039, <4 x float> %326), !dbg !166
  %399 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %374, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3039, <4 x float> %327), !dbg !166
  %.pre = lshr i32 %18, 2
  br label %if.end1697, !dbg !172

if.else966:                                       ; preds = %land.lhs.true148, %land.lhs.true137, %land.lhs.true126, %land.lhs.true115, %land.lhs.true104, %land.lhs.true93, %land.lhs.true82, %entry
  %mul998 = shl nsw i32 %0, 16
  %mul1005 = shl nuw nsw i32 %18, 3
  %add1001 = or disjoint i32 %mul1005, %mul998
  %invariant.op = add nsw i32 %1, -15, !dbg !173
  %400 = lshr i32 %18, 2
  %mul1150 = and i32 %400, 252
  %or.cond2594 = icmp ugt i32 %mul11, 1023, !dbg !174
  %cmp991.not = icmp sgt i32 %mul11, %1
  %or.cond2595 = or i1 %or.cond2594, %cmp991.not, !dbg !174
  br i1 %or.cond2595, label %if.end1016, label %for.cond993.preheader, !dbg !174

for.cond993.preheader:                            ; preds = %if.else966
  %401 = shl nsw i32 %cond.i.i2393, 10
  %mul1000 = and i32 %401, 64512
  %add1003 = add nuw nsw i32 %add1001, %mul1000
  %402 = zext nneg i32 %add1003 to i64, !dbg !175
  %add.ptr1008 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %402, !dbg !176
  %K_reg.sroa.0.0.copyload4498 = load <4 x half>, ptr addrspace(4) %add.ptr1008, align 16, !dbg !177
  %K_reg.sroa.12.0.add.ptr1008.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1008, i64 8, !dbg !177
  %K_reg.sroa.12.0.copyload4500 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.12.0.add.ptr1008.sroa_idx, align 8, !dbg !177
  %403 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %402, !dbg !176
  %add.ptr1008.1 = getelementptr inbounds i8, ptr addrspace(4) %403, i64 1024, !dbg !176
  %K_reg.sroa.20.16.copyload4502 = load <4 x half>, ptr addrspace(4) %add.ptr1008.1, align 16, !dbg !177
  %K_reg.sroa.30.16.add.ptr1008.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %403, i64 1032, !dbg !177
  %K_reg.sroa.30.16.copyload4504 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.30.16.add.ptr1008.1.sroa_idx, align 8, !dbg !177
  br label %if.end1016, !dbg !178

if.end1016:                                       ; preds = %for.cond993.preheader, %if.else966
  %404 = phi <4 x half> [ undef, %if.else966 ], [ %K_reg.sroa.30.16.copyload4504, %for.cond993.preheader ]
  %405 = phi <4 x half> [ undef, %if.else966 ], [ %K_reg.sroa.20.16.copyload4502, %for.cond993.preheader ]
  %406 = phi <4 x half> [ undef, %if.else966 ], [ %K_reg.sroa.12.0.copyload4500, %for.cond993.preheader ]
  %407 = phi <4 x half> [ undef, %if.else966 ], [ %K_reg.sroa.0.0.copyload4498, %for.cond993.preheader ]
  %or.cond2596 = icmp ugt i32 %mul11.1, 1023, !dbg !178
  %cmp1022.not = icmp sgt i32 %mul11.1, %1
  %or.cond2597 = or i1 %or.cond2596, %cmp1022.not, !dbg !178
  br i1 %or.cond2597, label %if.end1047, label %for.cond1024.preheader, !dbg !178

for.cond1024.preheader:                           ; preds = %if.end1016
  %408 = shl nsw i32 %cond.i.i2393.1, 10
  %mul1031 = and i32 %408, 64512
  %add1034 = add nuw nsw i32 %add1001, %mul1031
  %409 = zext nneg i32 %add1034 to i64, !dbg !179
  %add.ptr1039 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %409, !dbg !180
  %K_reg1.sroa.0.0.copyload4510 = load <4 x half>, ptr addrspace(4) %add.ptr1039, align 16, !dbg !181
  %K_reg1.sroa.12.0.add.ptr1039.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1039, i64 8, !dbg !181
  %K_reg1.sroa.12.0.copyload4512 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.12.0.add.ptr1039.sroa_idx, align 8, !dbg !181
  %410 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %409, !dbg !180
  %add.ptr1039.1 = getelementptr inbounds i8, ptr addrspace(4) %410, i64 1024, !dbg !180
  %K_reg1.sroa.20.16.copyload4514 = load <4 x half>, ptr addrspace(4) %add.ptr1039.1, align 16, !dbg !181
  %K_reg1.sroa.30.16.add.ptr1039.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %410, i64 1032, !dbg !181
  %K_reg1.sroa.30.16.copyload4516 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.30.16.add.ptr1039.1.sroa_idx, align 8, !dbg !181
  br label %if.end1047, !dbg !182

if.end1047:                                       ; preds = %for.cond1024.preheader, %if.end1016
  %411 = phi <4 x half> [ undef, %if.end1016 ], [ %K_reg1.sroa.30.16.copyload4516, %for.cond1024.preheader ]
  %412 = phi <4 x half> [ undef, %if.end1016 ], [ %K_reg1.sroa.20.16.copyload4514, %for.cond1024.preheader ]
  %413 = phi <4 x half> [ undef, %if.end1016 ], [ %K_reg1.sroa.12.0.copyload4512, %for.cond1024.preheader ]
  %414 = phi <4 x half> [ undef, %if.end1016 ], [ %K_reg1.sroa.0.0.copyload4510, %for.cond1024.preheader ]
  %or.cond2598 = icmp ugt i32 %mul11.2, 1023, !dbg !182
  %cmp1053.not = icmp sgt i32 %mul11.2, %1
  %or.cond2599 = or i1 %or.cond2598, %cmp1053.not, !dbg !182
  br i1 %or.cond2599, label %if.end1078, label %for.cond1055.preheader, !dbg !182

for.cond1055.preheader:                           ; preds = %if.end1047
  %415 = shl nsw i32 %cond.i.i2393.2, 10
  %mul1062 = and i32 %415, 64512
  %add1065 = add nuw nsw i32 %add1001, %mul1062
  %416 = zext nneg i32 %add1065 to i64, !dbg !183
  %add.ptr1070 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %416, !dbg !184
  %K_reg2.sroa.0.0.copyload4522 = load <4 x half>, ptr addrspace(4) %add.ptr1070, align 16, !dbg !185
  %K_reg2.sroa.12.0.add.ptr1070.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1070, i64 8, !dbg !185
  %K_reg2.sroa.12.0.copyload4524 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.12.0.add.ptr1070.sroa_idx, align 8, !dbg !185
  %417 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %416, !dbg !184
  %add.ptr1070.1 = getelementptr inbounds i8, ptr addrspace(4) %417, i64 1024, !dbg !184
  %K_reg2.sroa.20.16.copyload4526 = load <4 x half>, ptr addrspace(4) %add.ptr1070.1, align 16, !dbg !185
  %K_reg2.sroa.30.16.add.ptr1070.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %417, i64 1032, !dbg !185
  %K_reg2.sroa.30.16.copyload4528 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.30.16.add.ptr1070.1.sroa_idx, align 8, !dbg !185
  br label %if.end1078, !dbg !186

if.end1078:                                       ; preds = %for.cond1055.preheader, %if.end1047
  %418 = phi <4 x half> [ undef, %if.end1047 ], [ %K_reg2.sroa.30.16.copyload4528, %for.cond1055.preheader ]
  %419 = phi <4 x half> [ undef, %if.end1047 ], [ %K_reg2.sroa.20.16.copyload4526, %for.cond1055.preheader ]
  %420 = phi <4 x half> [ undef, %if.end1047 ], [ %K_reg2.sroa.12.0.copyload4524, %for.cond1055.preheader ]
  %421 = phi <4 x half> [ undef, %if.end1047 ], [ %K_reg2.sroa.0.0.copyload4522, %for.cond1055.preheader ]
  %or.cond2600 = icmp ugt i32 %mul11.3, 1023, !dbg !186
  %cmp1084.not = icmp sgt i32 %mul11.3, %1
  %or.cond2601 = or i1 %or.cond2600, %cmp1084.not, !dbg !186
  br i1 %or.cond2601, label %if.end1109, label %for.cond1086.preheader, !dbg !186

for.cond1086.preheader:                           ; preds = %if.end1078
  %422 = shl nsw i32 %cond.i.i2393.3, 10
  %mul1093 = and i32 %422, 64512
  %add1096 = add nuw nsw i32 %add1001, %mul1093
  %423 = zext nneg i32 %add1096 to i64, !dbg !187
  %add.ptr1101 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %423, !dbg !188
  %K_reg3.sroa.0.0.copyload4534 = load <4 x half>, ptr addrspace(4) %add.ptr1101, align 16, !dbg !189
  %K_reg3.sroa.12.0.add.ptr1101.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1101, i64 8, !dbg !189
  %K_reg3.sroa.12.0.copyload4536 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.12.0.add.ptr1101.sroa_idx, align 8, !dbg !189
  %424 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %423, !dbg !188
  %add.ptr1101.1 = getelementptr inbounds i8, ptr addrspace(4) %424, i64 1024, !dbg !188
  %K_reg3.sroa.20.16.copyload4538 = load <4 x half>, ptr addrspace(4) %add.ptr1101.1, align 16, !dbg !189
  %K_reg3.sroa.30.16.add.ptr1101.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %424, i64 1032, !dbg !189
  %K_reg3.sroa.30.16.copyload4540 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.30.16.add.ptr1101.1.sroa_idx, align 8, !dbg !189
  br label %if.end1109, !dbg !190

if.end1109:                                       ; preds = %for.cond1086.preheader, %if.end1078
  %425 = phi <4 x half> [ undef, %if.end1078 ], [ %K_reg3.sroa.30.16.copyload4540, %for.cond1086.preheader ]
  %426 = phi <4 x half> [ undef, %if.end1078 ], [ %K_reg3.sroa.20.16.copyload4538, %for.cond1086.preheader ]
  %427 = phi <4 x half> [ undef, %if.end1078 ], [ %K_reg3.sroa.12.0.copyload4536, %for.cond1086.preheader ]
  %428 = phi <4 x half> [ undef, %if.end1078 ], [ %K_reg3.sroa.0.0.copyload4534, %for.cond1086.preheader ]
  br i1 %or.cond2595, label %if.end1255, label %for.cond1117.preheader, !dbg !190

for.cond1117.preheader:                           ; preds = %if.end1109
  %429 = shl nsw i32 %cond.i.i2393, 10
  %mul1124 = and i32 %429, 64512
  %add1127 = add nuw nsw i32 %add1001, %mul1124
  %430 = zext nneg i32 %add1127 to i64, !dbg !191
  %add.ptr1132 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %430, !dbg !192
  %V_reg.sroa.0.0.copyload4477 = load <4 x half>, ptr addrspace(4) %add.ptr1132, align 16, !dbg !193
  %V_reg.sroa.42.0.add.ptr1132.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1132, i64 8, !dbg !193
  %V_reg.sroa.42.0.copyload4478 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1132.sroa_idx, align 8, !dbg !193
  %431 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %430, !dbg !192
  %add.ptr1132.1 = getelementptr inbounds i8, ptr addrspace(4) %431, i64 1024, !dbg !192
  %V_reg.sroa.74.16.copyload4479 = load <4 x half>, ptr addrspace(4) %add.ptr1132.1, align 16, !dbg !193
  %V_reg.sroa.114.16.add.ptr1132.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %431, i64 1032, !dbg !193
  %V_reg.sroa.114.16.copyload4480 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1132.1.sroa_idx, align 8, !dbg !193
  %cmp1142 = icmp sgt i32 %mul11, %invariant.op, !dbg !194
  br i1 %cmp1142, label %for.cond1144.preheader, label %if.end1168, !dbg !195

for.cond1144.preheader:                           ; preds = %for.cond1117.preheader
  %add1151 = add nuw nsw i32 %mul11, %mul1150
  %cmp1154.not = icmp sgt i32 %add1151, %1, !dbg !196
  %fneg. = select i1 %cmp1154.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3158 = insertelement <4 x float> poison, float %fneg., i64 0, !dbg !197
  %cmp1154.not.1.not = icmp slt i32 %add1151, %1, !dbg !196
  %fneg..1 = select i1 %cmp1154.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3339 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3158, float %fneg..1, i64 1, !dbg !197
  %add1152.2 = or disjoint i32 %add1151, 2, !dbg !198
  %cmp1154.not.2 = icmp sgt i32 %add1152.2, %1, !dbg !196
  %fneg..2 = select i1 %cmp1154.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3512 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3339, float %fneg..2, i64 2, !dbg !197
  %add1152.3 = or disjoint i32 %add1151, 3, !dbg !198
  %cmp1154.not.3 = icmp sgt i32 %add1152.3, %1, !dbg !196
  %fneg..3 = select i1 %cmp1154.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3685 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3512, float %fneg..3, i64 3, !dbg !197
  br label %if.end1168

if.end1168:                                       ; preds = %for.cond1117.preheader, %for.cond1144.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3685, %for.cond1144.preheader ], [ zeroinitializer, %for.cond1117.preheader ], !dbg !79
  %432 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %407, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !dbg !199, !call_argsrelate !117
  %433 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %406, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %432), !dbg !199, !call_argsrelate !117
  %434 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %405, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %433), !dbg !199, !call_argsrelate !117
  %435 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %404, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %434), !dbg !199, !call_argsrelate !117
  %acc_s.sroa.0.0.vec.extract3160 = extractelement <4 x float> %435, i64 0, !dbg !200
  %mul1203 = fmul contract float %acc_s.sroa.0.0.vec.extract3160, 0x3FB99999A0000000, !dbg !201
  %436 = tail call contract noundef float @llvm.minnum.f32(float %mul1203, float 0x4024CB5EC0000000), !dbg !202
  %437 = tail call contract noundef float @llvm.exp.f32(float %436), !dbg !204
  %acc_s.sroa.0.4.vec.extract3341 = extractelement <4 x float> %435, i64 1, !dbg !200
  %mul1203.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3341, 0x3FB99999A0000000, !dbg !201
  %438 = tail call contract noundef float @llvm.minnum.f32(float %mul1203.1, float 0x4024CB5EC0000000), !dbg !202
  %439 = tail call contract noundef float @llvm.exp.f32(float %438), !dbg !204
  %acc_s.sroa.0.8.vec.extract3514 = extractelement <4 x float> %435, i64 2, !dbg !200
  %mul1203.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3514, 0x3FB99999A0000000, !dbg !201
  %440 = tail call contract noundef float @llvm.minnum.f32(float %mul1203.2, float 0x4024CB5EC0000000), !dbg !202
  %441 = tail call contract noundef float @llvm.exp.f32(float %440), !dbg !204
  %acc_s.sroa.0.12.vec.extract3687 = extractelement <4 x float> %435, i64 3, !dbg !200
  %mul1203.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3687, 0x3FB99999A0000000, !dbg !201
  %442 = tail call contract noundef float @llvm.minnum.f32(float %mul1203.3, float 0x4024CB5EC0000000), !dbg !202
  %443 = tail call contract noundef float @llvm.exp.f32(float %442), !dbg !204
  %444 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %437), !dbg !206
  %445 = insertelement <4 x i16> poison, i16 %444, i64 0, !dbg !210
  %446 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %439), !dbg !206
  %447 = insertelement <4 x i16> %445, i16 %446, i64 1, !dbg !210
  %448 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %441), !dbg !206
  %449 = insertelement <4 x i16> %447, i16 %448, i64 2, !dbg !210
  %450 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %443), !dbg !206
  %451 = insertelement <4 x i16> %449, i16 %450, i64 3, !dbg !210
  %acc_s_cast.sroa.0.6.vec.insert3041 = bitcast <4 x i16> %451 to <4 x half>, !dbg !210
  %452 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload4477, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3041, <4 x float> zeroinitializer), !dbg !211, !call_argsrelate !111
  %453 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload4478, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3041, <4 x float> zeroinitializer), !dbg !211, !call_argsrelate !111
  %454 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload4479, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3041, <4 x float> zeroinitializer), !dbg !211, !call_argsrelate !111
  %455 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload4480, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3041, <4 x float> zeroinitializer), !dbg !211, !call_argsrelate !111
  br label %if.end1255, !dbg !212

if.end1255:                                       ; preds = %if.end1168, %if.end1109
  %acc_o.sroa.122.0 = phi <4 x float> [ zeroinitializer, %if.end1109 ], [ %455, %if.end1168 ], !dbg !79
  %acc_o.sroa.82.0 = phi <4 x float> [ zeroinitializer, %if.end1109 ], [ %454, %if.end1168 ], !dbg !79
  %acc_o.sroa.42.0 = phi <4 x float> [ zeroinitializer, %if.end1109 ], [ %453, %if.end1168 ], !dbg !79
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1109 ], [ %452, %if.end1168 ], !dbg !79
  %sum_acc.sroa.104.0 = phi float [ 0.000000e+00, %if.end1109 ], [ %443, %if.end1168 ], !dbg !79
  %sum_acc.sroa.70.0 = phi float [ 0.000000e+00, %if.end1109 ], [ %441, %if.end1168 ], !dbg !79
  %sum_acc.sroa.36.0 = phi float [ 0.000000e+00, %if.end1109 ], [ %439, %if.end1168 ], !dbg !79
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %if.end1109 ], [ %437, %if.end1168 ], !dbg !79
  br i1 %or.cond2597, label %if.end1401, label %for.cond1263.preheader, !dbg !212

for.cond1263.preheader:                           ; preds = %if.end1255
  %456 = shl nsw i32 %cond.i.i2393.1, 10
  %mul1270 = and i32 %456, 64512
  %add1273 = add nuw nsw i32 %add1001, %mul1270
  %457 = zext nneg i32 %add1273 to i64, !dbg !213
  %add.ptr1278 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %457, !dbg !214
  %V_reg.sroa.0.0.copyload37944481 = load <4 x half>, ptr addrspace(4) %add.ptr1278, align 16, !dbg !215
  %V_reg.sroa.42.0.add.ptr1278.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1278, i64 8, !dbg !215
  %V_reg.sroa.42.0.copyload38154482 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1278.sroa_idx, align 8, !dbg !215
  %458 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %457, !dbg !214
  %add.ptr1278.1 = getelementptr inbounds i8, ptr addrspace(4) %458, i64 1024, !dbg !214
  %V_reg.sroa.74.16.copyload38964483 = load <4 x half>, ptr addrspace(4) %add.ptr1278.1, align 16, !dbg !215
  %V_reg.sroa.114.16.add.ptr1278.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %458, i64 1032, !dbg !215
  %V_reg.sroa.114.16.copyload39174484 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1278.1.sroa_idx, align 8, !dbg !215
  %cmp1288 = icmp sgt i32 %mul11.1, %invariant.op, !dbg !216
  br i1 %cmp1288, label %for.cond1290.preheader, label %if.end1314, !dbg !217

for.cond1290.preheader:                           ; preds = %for.cond1263.preheader
  %add1297 = add nuw nsw i32 %mul11.1, %mul1150
  %cmp1300.not = icmp sgt i32 %add1297, %1, !dbg !218
  %fneg.2258 = select i1 %cmp1300.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3168 = insertelement <4 x float> poison, float %fneg.2258, i64 0, !dbg !219
  %cmp1300.not.1.not = icmp slt i32 %add1297, %1, !dbg !218
  %fneg.2258.1 = select i1 %cmp1300.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3349 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3168, float %fneg.2258.1, i64 1, !dbg !219
  %add1298.2 = or disjoint i32 %add1297, 2, !dbg !220
  %cmp1300.not.2 = icmp sgt i32 %add1298.2, %1, !dbg !218
  %fneg.2258.2 = select i1 %cmp1300.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3522 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3349, float %fneg.2258.2, i64 2, !dbg !219
  %add1298.3 = or disjoint i32 %add1297, 3, !dbg !220
  %cmp1300.not.3 = icmp sgt i32 %add1298.3, %1, !dbg !218
  %fneg.2258.3 = select i1 %cmp1300.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3695 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3522, float %fneg.2258.3, i64 3, !dbg !219
  br label %if.end1314

if.end1314:                                       ; preds = %for.cond1263.preheader, %for.cond1290.preheader
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3695, %for.cond1290.preheader ], [ zeroinitializer, %for.cond1263.preheader ], !dbg !79
  %459 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %414, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.2), !dbg !221, !call_argsrelate !117
  %460 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %413, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %459), !dbg !221, !call_argsrelate !117
  %461 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %412, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %460), !dbg !221, !call_argsrelate !117
  %462 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %411, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %461), !dbg !221, !call_argsrelate !117
  %acc_s.sroa.0.0.vec.extract3170 = extractelement <4 x float> %462, i64 0, !dbg !222
  %mul1349 = fmul contract float %acc_s.sroa.0.0.vec.extract3170, 0x3FB99999A0000000, !dbg !223
  %463 = tail call contract noundef float @llvm.minnum.f32(float %mul1349, float 0x4024CB5EC0000000), !dbg !224
  %464 = tail call contract noundef float @llvm.exp.f32(float %463), !dbg !226
  %acc_s.sroa.0.4.vec.extract3351 = extractelement <4 x float> %462, i64 1, !dbg !222
  %mul1349.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3351, 0x3FB99999A0000000, !dbg !223
  %465 = tail call contract noundef float @llvm.minnum.f32(float %mul1349.1, float 0x4024CB5EC0000000), !dbg !224
  %466 = tail call contract noundef float @llvm.exp.f32(float %465), !dbg !226
  %acc_s.sroa.0.8.vec.extract3524 = extractelement <4 x float> %462, i64 2, !dbg !222
  %mul1349.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3524, 0x3FB99999A0000000, !dbg !223
  %467 = tail call contract noundef float @llvm.minnum.f32(float %mul1349.2, float 0x4024CB5EC0000000), !dbg !224
  %468 = tail call contract noundef float @llvm.exp.f32(float %467), !dbg !226
  %acc_s.sroa.0.12.vec.extract3697 = extractelement <4 x float> %462, i64 3, !dbg !222
  %mul1349.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3697, 0x3FB99999A0000000, !dbg !223
  %469 = tail call contract noundef float @llvm.minnum.f32(float %mul1349.3, float 0x4024CB5EC0000000), !dbg !224
  %470 = tail call contract noundef float @llvm.exp.f32(float %469), !dbg !226
  %add1365 = fadd contract float %sum_acc.sroa.0.0, %464, !dbg !228
  %add1365.1 = fadd contract float %sum_acc.sroa.36.0, %466, !dbg !228
  %add1365.2 = fadd contract float %sum_acc.sroa.70.0, %468, !dbg !228
  %add1365.3 = fadd contract float %sum_acc.sroa.104.0, %470, !dbg !228
  %471 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %464), !dbg !229
  %472 = insertelement <4 x i16> poison, i16 %471, i64 0, !dbg !233
  %473 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %466), !dbg !229
  %474 = insertelement <4 x i16> %472, i16 %473, i64 1, !dbg !233
  %475 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %468), !dbg !229
  %476 = insertelement <4 x i16> %474, i16 %475, i64 2, !dbg !233
  %477 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %470), !dbg !229
  %478 = insertelement <4 x i16> %476, i16 %477, i64 3, !dbg !233
  %acc_s_cast.sroa.0.6.vec.insert3043 = bitcast <4 x i16> %478 to <4 x half>, !dbg !233
  %479 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload37944481, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3043, <4 x float> zeroinitializer), !dbg !234, !call_argsrelate !111
  %480 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload38154482, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3043, <4 x float> zeroinitializer), !dbg !234, !call_argsrelate !111
  %481 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload38964483, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3043, <4 x float> zeroinitializer), !dbg !234, !call_argsrelate !111
  %482 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload39174484, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3043, <4 x float> zeroinitializer), !dbg !234, !call_argsrelate !111
  br label %if.end1401, !dbg !235

if.end1401:                                       ; preds = %if.end1314, %if.end1255
  %acc_o_alt.sroa.74.0 = phi <4 x float> [ zeroinitializer, %if.end1255 ], [ %482, %if.end1314 ], !dbg !79
  %acc_o_alt.sroa.50.0 = phi <4 x float> [ zeroinitializer, %if.end1255 ], [ %481, %if.end1314 ], !dbg !79
  %acc_o_alt.sroa.26.0 = phi <4 x float> [ zeroinitializer, %if.end1255 ], [ %480, %if.end1314 ], !dbg !79
  %acc_o_alt.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1255 ], [ %479, %if.end1314 ], !dbg !79
  %sum_acc.sroa.104.1 = phi float [ %sum_acc.sroa.104.0, %if.end1255 ], [ %add1365.3, %if.end1314 ], !dbg !79
  %sum_acc.sroa.70.1 = phi float [ %sum_acc.sroa.70.0, %if.end1255 ], [ %add1365.2, %if.end1314 ], !dbg !79
  %sum_acc.sroa.36.1 = phi float [ %sum_acc.sroa.36.0, %if.end1255 ], [ %add1365.1, %if.end1314 ], !dbg !79
  %sum_acc.sroa.0.1 = phi float [ %sum_acc.sroa.0.0, %if.end1255 ], [ %add1365, %if.end1314 ], !dbg !79
  br i1 %or.cond2599, label %if.end1547, label %for.cond1409.preheader, !dbg !235

for.cond1409.preheader:                           ; preds = %if.end1401
  %483 = shl nsw i32 %cond.i.i2393.2, 10
  %mul1416 = and i32 %483, 64512
  %add1419 = add nuw nsw i32 %add1001, %mul1416
  %484 = zext nneg i32 %add1419 to i64, !dbg !236
  %add.ptr1424 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %484, !dbg !237
  %V_reg.sroa.0.0.copyload37954485 = load <4 x half>, ptr addrspace(4) %add.ptr1424, align 16, !dbg !238
  %V_reg.sroa.42.0.add.ptr1424.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1424, i64 8, !dbg !238
  %V_reg.sroa.42.0.copyload38164486 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1424.sroa_idx, align 8, !dbg !238
  %485 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %484, !dbg !237
  %add.ptr1424.1 = getelementptr inbounds i8, ptr addrspace(4) %485, i64 1024, !dbg !237
  %V_reg.sroa.74.16.copyload38974487 = load <4 x half>, ptr addrspace(4) %add.ptr1424.1, align 16, !dbg !238
  %V_reg.sroa.114.16.add.ptr1424.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %485, i64 1032, !dbg !238
  %V_reg.sroa.114.16.copyload39184488 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1424.1.sroa_idx, align 8, !dbg !238
  %cmp1434 = icmp sgt i32 %mul11.2, %invariant.op, !dbg !239
  br i1 %cmp1434, label %for.cond1436.preheader, label %if.end1460, !dbg !240

for.cond1436.preheader:                           ; preds = %for.cond1409.preheader
  %add1443 = add nuw nsw i32 %mul11.2, %mul1150
  %cmp1446.not = icmp sgt i32 %add1443, %1, !dbg !241
  %fneg.2259 = select i1 %cmp1446.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3178 = insertelement <4 x float> poison, float %fneg.2259, i64 0, !dbg !242
  %cmp1446.not.1.not = icmp slt i32 %add1443, %1, !dbg !241
  %fneg.2259.1 = select i1 %cmp1446.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3359 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3178, float %fneg.2259.1, i64 1, !dbg !242
  %add1444.2 = or disjoint i32 %add1443, 2, !dbg !243
  %cmp1446.not.2 = icmp sgt i32 %add1444.2, %1, !dbg !241
  %fneg.2259.2 = select i1 %cmp1446.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3532 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3359, float %fneg.2259.2, i64 2, !dbg !242
  %add1444.3 = or disjoint i32 %add1443, 3, !dbg !243
  %cmp1446.not.3 = icmp sgt i32 %add1444.3, %1, !dbg !241
  %fneg.2259.3 = select i1 %cmp1446.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3705 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3532, float %fneg.2259.3, i64 3, !dbg !242
  br label %if.end1460

if.end1460:                                       ; preds = %for.cond1409.preheader, %for.cond1436.preheader
  %acc_s.sroa.0.4 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3705, %for.cond1436.preheader ], [ zeroinitializer, %for.cond1409.preheader ], !dbg !79
  %486 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %421, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.4), !dbg !244, !call_argsrelate !117
  %487 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %420, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %486), !dbg !244, !call_argsrelate !117
  %488 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %419, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %487), !dbg !244, !call_argsrelate !117
  %489 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %418, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %488), !dbg !244, !call_argsrelate !117
  %acc_s.sroa.0.0.vec.extract3180 = extractelement <4 x float> %489, i64 0, !dbg !245
  %mul1495 = fmul contract float %acc_s.sroa.0.0.vec.extract3180, 0x3FB99999A0000000, !dbg !246
  %490 = tail call contract noundef float @llvm.minnum.f32(float %mul1495, float 0x4024CB5EC0000000), !dbg !247
  %491 = tail call contract noundef float @llvm.exp.f32(float %490), !dbg !249
  %acc_s.sroa.0.4.vec.extract3361 = extractelement <4 x float> %489, i64 1, !dbg !245
  %mul1495.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3361, 0x3FB99999A0000000, !dbg !246
  %492 = tail call contract noundef float @llvm.minnum.f32(float %mul1495.1, float 0x4024CB5EC0000000), !dbg !247
  %493 = tail call contract noundef float @llvm.exp.f32(float %492), !dbg !249
  %acc_s.sroa.0.8.vec.extract3534 = extractelement <4 x float> %489, i64 2, !dbg !245
  %mul1495.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3534, 0x3FB99999A0000000, !dbg !246
  %494 = tail call contract noundef float @llvm.minnum.f32(float %mul1495.2, float 0x4024CB5EC0000000), !dbg !247
  %495 = tail call contract noundef float @llvm.exp.f32(float %494), !dbg !249
  %acc_s.sroa.0.12.vec.extract3707 = extractelement <4 x float> %489, i64 3, !dbg !245
  %mul1495.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3707, 0x3FB99999A0000000, !dbg !246
  %496 = tail call contract noundef float @llvm.minnum.f32(float %mul1495.3, float 0x4024CB5EC0000000), !dbg !247
  %497 = tail call contract noundef float @llvm.exp.f32(float %496), !dbg !249
  %add1511 = fadd contract float %sum_acc.sroa.0.1, %491, !dbg !251
  %add1511.1 = fadd contract float %sum_acc.sroa.36.1, %493, !dbg !251
  %add1511.2 = fadd contract float %sum_acc.sroa.70.1, %495, !dbg !251
  %add1511.3 = fadd contract float %sum_acc.sroa.104.1, %497, !dbg !251
  %498 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %491), !dbg !252
  %499 = insertelement <4 x i16> poison, i16 %498, i64 0, !dbg !256
  %500 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %493), !dbg !252
  %501 = insertelement <4 x i16> %499, i16 %500, i64 1, !dbg !256
  %502 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %495), !dbg !252
  %503 = insertelement <4 x i16> %501, i16 %502, i64 2, !dbg !256
  %504 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %497), !dbg !252
  %505 = insertelement <4 x i16> %503, i16 %504, i64 3, !dbg !256
  %acc_s_cast.sroa.0.6.vec.insert3045 = bitcast <4 x i16> %505 to <4 x half>, !dbg !256
  %506 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload37954485, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3045, <4 x float> %acc_o.sroa.0.0), !dbg !257, !call_argsrelate !111
  %507 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload38164486, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3045, <4 x float> %acc_o.sroa.42.0), !dbg !257, !call_argsrelate !111
  %508 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload38974487, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3045, <4 x float> %acc_o.sroa.82.0), !dbg !257, !call_argsrelate !111
  %509 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload39184488, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3045, <4 x float> %acc_o.sroa.122.0), !dbg !257, !call_argsrelate !111
  br label %if.end1547, !dbg !258

if.end1547:                                       ; preds = %if.end1460, %if.end1401
  %acc_o.sroa.122.1 = phi <4 x float> [ %acc_o.sroa.122.0, %if.end1401 ], [ %509, %if.end1460 ], !dbg !79
  %acc_o.sroa.82.1 = phi <4 x float> [ %acc_o.sroa.82.0, %if.end1401 ], [ %508, %if.end1460 ], !dbg !79
  %acc_o.sroa.42.1 = phi <4 x float> [ %acc_o.sroa.42.0, %if.end1401 ], [ %507, %if.end1460 ], !dbg !79
  %acc_o.sroa.0.1 = phi <4 x float> [ %acc_o.sroa.0.0, %if.end1401 ], [ %506, %if.end1460 ], !dbg !79
  %sum_acc.sroa.104.2 = phi float [ %sum_acc.sroa.104.1, %if.end1401 ], [ %add1511.3, %if.end1460 ], !dbg !79
  %sum_acc.sroa.70.2 = phi float [ %sum_acc.sroa.70.1, %if.end1401 ], [ %add1511.2, %if.end1460 ], !dbg !79
  %sum_acc.sroa.36.2 = phi float [ %sum_acc.sroa.36.1, %if.end1401 ], [ %add1511.1, %if.end1460 ], !dbg !79
  %sum_acc.sroa.0.2 = phi float [ %sum_acc.sroa.0.1, %if.end1401 ], [ %add1511, %if.end1460 ], !dbg !79
  br i1 %or.cond2601, label %if.end1693, label %for.cond1555.preheader, !dbg !258

for.cond1555.preheader:                           ; preds = %if.end1547
  %510 = shl nsw i32 %cond.i.i2393.3, 10
  %mul1562 = and i32 %510, 64512
  %add1565 = add nuw nsw i32 %add1001, %mul1562
  %511 = zext nneg i32 %add1565 to i64, !dbg !259
  %add.ptr1570 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %511, !dbg !260
  %V_reg.sroa.0.0.copyload37964489 = load <4 x half>, ptr addrspace(4) %add.ptr1570, align 16, !dbg !261
  %V_reg.sroa.42.0.add.ptr1570.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1570, i64 8, !dbg !261
  %V_reg.sroa.42.0.copyload38174490 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1570.sroa_idx, align 8, !dbg !261
  %512 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %511, !dbg !260
  %add.ptr1570.1 = getelementptr inbounds i8, ptr addrspace(4) %512, i64 1024, !dbg !260
  %V_reg.sroa.74.16.copyload38984491 = load <4 x half>, ptr addrspace(4) %add.ptr1570.1, align 16, !dbg !261
  %V_reg.sroa.114.16.add.ptr1570.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %512, i64 1032, !dbg !261
  %V_reg.sroa.114.16.copyload39194492 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1570.1.sroa_idx, align 8, !dbg !261
  %cmp1580 = icmp sgt i32 %mul11.3, %invariant.op, !dbg !262
  br i1 %cmp1580, label %for.cond1582.preheader, label %if.end1606, !dbg !263

for.cond1582.preheader:                           ; preds = %for.cond1555.preheader
  %add1589 = add nuw nsw i32 %mul11.3, %mul1150
  %cmp1592.not = icmp sgt i32 %add1589, %1, !dbg !264
  %fneg.2260 = select i1 %cmp1592.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3188 = insertelement <4 x float> poison, float %fneg.2260, i64 0, !dbg !265
  %cmp1592.not.1.not = icmp slt i32 %add1589, %1, !dbg !264
  %fneg.2260.1 = select i1 %cmp1592.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3369 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3188, float %fneg.2260.1, i64 1, !dbg !265
  %add1590.2 = or disjoint i32 %add1589, 2, !dbg !266
  %cmp1592.not.2 = icmp sgt i32 %add1590.2, %1, !dbg !264
  %fneg.2260.2 = select i1 %cmp1592.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3542 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3369, float %fneg.2260.2, i64 2, !dbg !265
  %add1590.3 = or disjoint i32 %add1589, 3, !dbg !266
  %cmp1592.not.3 = icmp sgt i32 %add1590.3, %1, !dbg !264
  %fneg.2260.3 = select i1 %cmp1592.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3715 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3542, float %fneg.2260.3, i64 3, !dbg !265
  br label %if.end1606

if.end1606:                                       ; preds = %for.cond1555.preheader, %for.cond1582.preheader
  %acc_s.sroa.0.6 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3715, %for.cond1582.preheader ], [ zeroinitializer, %for.cond1555.preheader ], !dbg !79
  %513 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %428, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.6), !dbg !267, !call_argsrelate !117
  %514 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %427, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %513), !dbg !267, !call_argsrelate !117
  %515 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %426, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %514), !dbg !267, !call_argsrelate !117
  %516 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %425, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %515), !dbg !267, !call_argsrelate !117
  %acc_s.sroa.0.0.vec.extract3190 = extractelement <4 x float> %516, i64 0, !dbg !268
  %mul1641 = fmul contract float %acc_s.sroa.0.0.vec.extract3190, 0x3FB99999A0000000, !dbg !269
  %517 = tail call contract noundef float @llvm.minnum.f32(float %mul1641, float 0x4024CB5EC0000000), !dbg !270
  %518 = tail call contract noundef float @llvm.exp.f32(float %517), !dbg !272
  %acc_s.sroa.0.4.vec.extract3371 = extractelement <4 x float> %516, i64 1, !dbg !268
  %mul1641.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3371, 0x3FB99999A0000000, !dbg !269
  %519 = tail call contract noundef float @llvm.minnum.f32(float %mul1641.1, float 0x4024CB5EC0000000), !dbg !270
  %520 = tail call contract noundef float @llvm.exp.f32(float %519), !dbg !272
  %acc_s.sroa.0.8.vec.extract3544 = extractelement <4 x float> %516, i64 2, !dbg !268
  %mul1641.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3544, 0x3FB99999A0000000, !dbg !269
  %521 = tail call contract noundef float @llvm.minnum.f32(float %mul1641.2, float 0x4024CB5EC0000000), !dbg !270
  %522 = tail call contract noundef float @llvm.exp.f32(float %521), !dbg !272
  %acc_s.sroa.0.12.vec.extract3717 = extractelement <4 x float> %516, i64 3, !dbg !268
  %mul1641.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3717, 0x3FB99999A0000000, !dbg !269
  %523 = tail call contract noundef float @llvm.minnum.f32(float %mul1641.3, float 0x4024CB5EC0000000), !dbg !270
  %524 = tail call contract noundef float @llvm.exp.f32(float %523), !dbg !272
  %add1657 = fadd contract float %sum_acc.sroa.0.2, %518, !dbg !274
  %add1657.1 = fadd contract float %sum_acc.sroa.36.2, %520, !dbg !274
  %add1657.2 = fadd contract float %sum_acc.sroa.70.2, %522, !dbg !274
  %add1657.3 = fadd contract float %sum_acc.sroa.104.2, %524, !dbg !274
  %525 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %518), !dbg !275
  %526 = insertelement <4 x i16> poison, i16 %525, i64 0, !dbg !279
  %527 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %520), !dbg !275
  %528 = insertelement <4 x i16> %526, i16 %527, i64 1, !dbg !279
  %529 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %522), !dbg !275
  %530 = insertelement <4 x i16> %528, i16 %529, i64 2, !dbg !279
  %531 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %524), !dbg !275
  %532 = insertelement <4 x i16> %530, i16 %531, i64 3, !dbg !279
  %acc_s_cast.sroa.0.6.vec.insert3047 = bitcast <4 x i16> %532 to <4 x half>, !dbg !279
  %533 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload37964489, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3047, <4 x float> %acc_o_alt.sroa.0.0), !dbg !280, !call_argsrelate !111
  %534 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload38174490, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3047, <4 x float> %acc_o_alt.sroa.26.0), !dbg !280, !call_argsrelate !111
  %535 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload38984491, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3047, <4 x float> %acc_o_alt.sroa.50.0), !dbg !280, !call_argsrelate !111
  %536 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload39194492, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3047, <4 x float> %acc_o_alt.sroa.74.0), !dbg !280, !call_argsrelate !111
  br label %if.end1693, !dbg !281

if.end1693:                                       ; preds = %if.end1606, %if.end1547
  %acc_o_alt.sroa.74.1 = phi <4 x float> [ %acc_o_alt.sroa.74.0, %if.end1547 ], [ %536, %if.end1606 ], !dbg !79
  %acc_o_alt.sroa.50.1 = phi <4 x float> [ %acc_o_alt.sroa.50.0, %if.end1547 ], [ %535, %if.end1606 ], !dbg !79
  %acc_o_alt.sroa.26.1 = phi <4 x float> [ %acc_o_alt.sroa.26.0, %if.end1547 ], [ %534, %if.end1606 ], !dbg !79
  %acc_o_alt.sroa.0.1 = phi <4 x float> [ %acc_o_alt.sroa.0.0, %if.end1547 ], [ %533, %if.end1606 ], !dbg !79
  %sum_acc.sroa.104.3 = phi float [ %sum_acc.sroa.104.2, %if.end1547 ], [ %add1657.3, %if.end1606 ], !dbg !79
  %sum_acc.sroa.70.3 = phi float [ %sum_acc.sroa.70.2, %if.end1547 ], [ %add1657.2, %if.end1606 ], !dbg !79
  %sum_acc.sroa.36.3 = phi float [ %sum_acc.sroa.36.2, %if.end1547 ], [ %add1657.1, %if.end1606 ], !dbg !79
  %sum_acc.sroa.0.3 = phi float [ %sum_acc.sroa.0.2, %if.end1547 ], [ %add1657, %if.end1606 ], !dbg !79
  %or.cond2594.1 = icmp ugt i32 %mul11.4, 1023, !dbg !174
  %cmp991.not.1 = icmp sgt i32 %mul11.4, %1
  %or.cond2595.1 = or i1 %or.cond2594.1, %cmp991.not.1, !dbg !174
  br i1 %or.cond2595.1, label %if.end1016.1, label %for.cond993.preheader.1, !dbg !174

for.cond993.preheader.1:                          ; preds = %if.end1693
  %537 = shl nsw i32 %cond.i.i2393.4, 10
  %mul1000.1 = and i32 %537, 64512
  %add1003.1 = add nuw nsw i32 %add1001, %mul1000.1
  %538 = zext nneg i32 %add1003.1 to i64, !dbg !175
  %add.ptr1008.12875 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %538, !dbg !176
  %K_reg.sroa.0.0.copyload40824497 = load <4 x half>, ptr addrspace(4) %add.ptr1008.12875, align 16, !dbg !177
  %K_reg.sroa.12.0.add.ptr1008.12875.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1008.12875, i64 8, !dbg !177
  %K_reg.sroa.12.0.copyload40854499 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.12.0.add.ptr1008.12875.sroa_idx, align 8, !dbg !177
  %539 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %538, !dbg !176
  %add.ptr1008.1.1 = getelementptr inbounds i8, ptr addrspace(4) %539, i64 1024, !dbg !176
  %K_reg.sroa.20.16.copyload41004501 = load <4 x half>, ptr addrspace(4) %add.ptr1008.1.1, align 16, !dbg !177
  %K_reg.sroa.30.16.add.ptr1008.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %539, i64 1032, !dbg !177
  %K_reg.sroa.30.16.copyload41034503 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.30.16.add.ptr1008.1.1.sroa_idx, align 8, !dbg !177
  br label %if.end1016.1, !dbg !178

if.end1016.1:                                     ; preds = %for.cond993.preheader.1, %if.end1693
  %540 = phi <4 x half> [ %404, %if.end1693 ], [ %K_reg.sroa.30.16.copyload41034503, %for.cond993.preheader.1 ]
  %541 = phi <4 x half> [ %405, %if.end1693 ], [ %K_reg.sroa.20.16.copyload41004501, %for.cond993.preheader.1 ]
  %542 = phi <4 x half> [ %406, %if.end1693 ], [ %K_reg.sroa.12.0.copyload40854499, %for.cond993.preheader.1 ]
  %543 = phi <4 x half> [ %407, %if.end1693 ], [ %K_reg.sroa.0.0.copyload40824497, %for.cond993.preheader.1 ]
  %or.cond2596.1 = icmp ugt i32 %mul11.5, 1023, !dbg !178
  %cmp1022.not.1 = icmp sgt i32 %mul11.5, %1
  %or.cond2597.1 = or i1 %or.cond2596.1, %cmp1022.not.1, !dbg !178
  br i1 %or.cond2597.1, label %if.end1047.1, label %for.cond1024.preheader.1, !dbg !178

for.cond1024.preheader.1:                         ; preds = %if.end1016.1
  %544 = shl nsw i32 %cond.i.i2393.5, 10
  %mul1031.1 = and i32 %544, 64512
  %add1034.1 = add nuw nsw i32 %add1001, %mul1031.1
  %545 = zext nneg i32 %add1034.1 to i64, !dbg !179
  %add.ptr1039.12876 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %545, !dbg !180
  %K_reg1.sroa.0.0.copyload40464509 = load <4 x half>, ptr addrspace(4) %add.ptr1039.12876, align 16, !dbg !181
  %K_reg1.sroa.12.0.add.ptr1039.12876.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1039.12876, i64 8, !dbg !181
  %K_reg1.sroa.12.0.copyload40494511 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.12.0.add.ptr1039.12876.sroa_idx, align 8, !dbg !181
  %546 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %545, !dbg !180
  %add.ptr1039.1.1 = getelementptr inbounds i8, ptr addrspace(4) %546, i64 1024, !dbg !180
  %K_reg1.sroa.20.16.copyload40644513 = load <4 x half>, ptr addrspace(4) %add.ptr1039.1.1, align 16, !dbg !181
  %K_reg1.sroa.30.16.add.ptr1039.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %546, i64 1032, !dbg !181
  %K_reg1.sroa.30.16.copyload40674515 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.30.16.add.ptr1039.1.1.sroa_idx, align 8, !dbg !181
  br label %if.end1047.1, !dbg !182

if.end1047.1:                                     ; preds = %for.cond1024.preheader.1, %if.end1016.1
  %547 = phi <4 x half> [ %411, %if.end1016.1 ], [ %K_reg1.sroa.30.16.copyload40674515, %for.cond1024.preheader.1 ]
  %548 = phi <4 x half> [ %412, %if.end1016.1 ], [ %K_reg1.sroa.20.16.copyload40644513, %for.cond1024.preheader.1 ]
  %549 = phi <4 x half> [ %413, %if.end1016.1 ], [ %K_reg1.sroa.12.0.copyload40494511, %for.cond1024.preheader.1 ]
  %550 = phi <4 x half> [ %414, %if.end1016.1 ], [ %K_reg1.sroa.0.0.copyload40464509, %for.cond1024.preheader.1 ]
  %or.cond2598.1 = icmp ugt i32 %mul11.6, 1023, !dbg !182
  %cmp1053.not.1 = icmp sgt i32 %mul11.6, %1
  %or.cond2599.1 = or i1 %or.cond2598.1, %cmp1053.not.1, !dbg !182
  br i1 %or.cond2599.1, label %if.end1078.1, label %for.cond1055.preheader.1, !dbg !182

for.cond1055.preheader.1:                         ; preds = %if.end1047.1
  %551 = shl nsw i32 %cond.i.i2393.6, 10
  %mul1062.1 = and i32 %551, 64512
  %add1065.1 = add nuw nsw i32 %add1001, %mul1062.1
  %552 = zext nneg i32 %add1065.1 to i64, !dbg !183
  %add.ptr1070.12877 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %552, !dbg !184
  %K_reg2.sroa.0.0.copyload40104521 = load <4 x half>, ptr addrspace(4) %add.ptr1070.12877, align 16, !dbg !185
  %K_reg2.sroa.12.0.add.ptr1070.12877.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1070.12877, i64 8, !dbg !185
  %K_reg2.sroa.12.0.copyload40134523 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.12.0.add.ptr1070.12877.sroa_idx, align 8, !dbg !185
  %553 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %552, !dbg !184
  %add.ptr1070.1.1 = getelementptr inbounds i8, ptr addrspace(4) %553, i64 1024, !dbg !184
  %K_reg2.sroa.20.16.copyload40284525 = load <4 x half>, ptr addrspace(4) %add.ptr1070.1.1, align 16, !dbg !185
  %K_reg2.sroa.30.16.add.ptr1070.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %553, i64 1032, !dbg !185
  %K_reg2.sroa.30.16.copyload40314527 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.30.16.add.ptr1070.1.1.sroa_idx, align 8, !dbg !185
  br label %if.end1078.1, !dbg !186

if.end1078.1:                                     ; preds = %for.cond1055.preheader.1, %if.end1047.1
  %554 = phi <4 x half> [ %418, %if.end1047.1 ], [ %K_reg2.sroa.30.16.copyload40314527, %for.cond1055.preheader.1 ]
  %555 = phi <4 x half> [ %419, %if.end1047.1 ], [ %K_reg2.sroa.20.16.copyload40284525, %for.cond1055.preheader.1 ]
  %556 = phi <4 x half> [ %420, %if.end1047.1 ], [ %K_reg2.sroa.12.0.copyload40134523, %for.cond1055.preheader.1 ]
  %557 = phi <4 x half> [ %421, %if.end1047.1 ], [ %K_reg2.sroa.0.0.copyload40104521, %for.cond1055.preheader.1 ]
  %or.cond2600.1 = icmp ugt i32 %mul11.7, 1023, !dbg !186
  %cmp1084.not.1 = icmp sgt i32 %mul11.7, %1
  %or.cond2601.1 = or i1 %or.cond2600.1, %cmp1084.not.1, !dbg !186
  br i1 %or.cond2601.1, label %if.end1109.1, label %for.cond1086.preheader.1, !dbg !186

for.cond1086.preheader.1:                         ; preds = %if.end1078.1
  %558 = shl nsw i32 %cond.i.i2393.7, 10
  %mul1093.1 = and i32 %558, 64512
  %add1096.1 = add nuw nsw i32 %add1001, %mul1093.1
  %559 = zext nneg i32 %add1096.1 to i64, !dbg !187
  %add.ptr1101.12878 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %559, !dbg !188
  %K_reg3.sroa.0.0.copyload39744533 = load <4 x half>, ptr addrspace(4) %add.ptr1101.12878, align 16, !dbg !189
  %K_reg3.sroa.12.0.add.ptr1101.12878.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1101.12878, i64 8, !dbg !189
  %K_reg3.sroa.12.0.copyload39774535 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.12.0.add.ptr1101.12878.sroa_idx, align 8, !dbg !189
  %560 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %559, !dbg !188
  %add.ptr1101.1.1 = getelementptr inbounds i8, ptr addrspace(4) %560, i64 1024, !dbg !188
  %K_reg3.sroa.20.16.copyload39924537 = load <4 x half>, ptr addrspace(4) %add.ptr1101.1.1, align 16, !dbg !189
  %K_reg3.sroa.30.16.add.ptr1101.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %560, i64 1032, !dbg !189
  %K_reg3.sroa.30.16.copyload39954539 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.30.16.add.ptr1101.1.1.sroa_idx, align 8, !dbg !189
  br label %if.end1109.1, !dbg !190

if.end1109.1:                                     ; preds = %for.cond1086.preheader.1, %if.end1078.1
  %561 = phi <4 x half> [ %425, %if.end1078.1 ], [ %K_reg3.sroa.30.16.copyload39954539, %for.cond1086.preheader.1 ]
  %562 = phi <4 x half> [ %426, %if.end1078.1 ], [ %K_reg3.sroa.20.16.copyload39924537, %for.cond1086.preheader.1 ]
  %563 = phi <4 x half> [ %427, %if.end1078.1 ], [ %K_reg3.sroa.12.0.copyload39774535, %for.cond1086.preheader.1 ]
  %564 = phi <4 x half> [ %428, %if.end1078.1 ], [ %K_reg3.sroa.0.0.copyload39744533, %for.cond1086.preheader.1 ]
  br i1 %or.cond2595.1, label %if.end1255.1, label %for.cond1117.preheader.1, !dbg !190

for.cond1117.preheader.1:                         ; preds = %if.end1109.1
  %565 = shl nsw i32 %cond.i.i2393.4, 10
  %mul1124.1 = and i32 %565, 64512
  %add1127.1 = add nuw nsw i32 %add1001, %mul1124.1
  %566 = zext nneg i32 %add1127.1 to i64, !dbg !191
  %add.ptr1132.12879 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %566, !dbg !192
  %V_reg.sroa.0.0.copyload37974493 = load <4 x half>, ptr addrspace(4) %add.ptr1132.12879, align 16, !dbg !193
  %V_reg.sroa.42.0.add.ptr1132.12879.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1132.12879, i64 8, !dbg !193
  %V_reg.sroa.42.0.copyload38184494 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1132.12879.sroa_idx, align 8, !dbg !193
  %567 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %566, !dbg !192
  %add.ptr1132.1.1 = getelementptr inbounds i8, ptr addrspace(4) %567, i64 1024, !dbg !192
  %V_reg.sroa.74.16.copyload38994495 = load <4 x half>, ptr addrspace(4) %add.ptr1132.1.1, align 16, !dbg !193
  %V_reg.sroa.114.16.add.ptr1132.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %567, i64 1032, !dbg !193
  %V_reg.sroa.114.16.copyload39204496 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1132.1.1.sroa_idx, align 8, !dbg !193
  %cmp1142.1 = icmp sgt i32 %mul11.4, %invariant.op, !dbg !194
  br i1 %cmp1142.1, label %for.cond1144.preheader.1, label %if.end1168.1, !dbg !195

for.cond1144.preheader.1:                         ; preds = %for.cond1117.preheader.1
  %add1151.1 = add nuw nsw i32 %mul11.4, %mul1150
  %cmp1154.not.12880 = icmp sgt i32 %add1151.1, %1, !dbg !196
  %fneg..12881 = select i1 %cmp1154.not.12880, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3200 = insertelement <4 x float> poison, float %fneg..12881, i64 0, !dbg !197
  %cmp1154.not.1.1.not = icmp slt i32 %add1151.1, %1, !dbg !196
  %fneg..1.1 = select i1 %cmp1154.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3379 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3200, float %fneg..1.1, i64 1, !dbg !197
  %add1152.2.1 = or disjoint i32 %add1151.1, 2, !dbg !198
  %cmp1154.not.2.1 = icmp sgt i32 %add1152.2.1, %1, !dbg !196
  %fneg..2.1 = select i1 %cmp1154.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3552 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3379, float %fneg..2.1, i64 2, !dbg !197
  %add1152.3.1 = or disjoint i32 %add1151.1, 3, !dbg !198
  %cmp1154.not.3.1 = icmp sgt i32 %add1152.3.1, %1, !dbg !196
  %fneg..3.1 = select i1 %cmp1154.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3725 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3552, float %fneg..3.1, i64 3, !dbg !197
  br label %if.end1168.1

if.end1168.1:                                     ; preds = %for.cond1117.preheader.1, %for.cond1144.preheader.1
  %acc_s.sroa.0.8 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3725, %for.cond1144.preheader.1 ], [ zeroinitializer, %for.cond1117.preheader.1 ], !dbg !79
  %568 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %543, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.8), !dbg !199, !call_argsrelate !117
  %569 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %542, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %568), !dbg !199, !call_argsrelate !117
  %570 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %541, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %569), !dbg !199, !call_argsrelate !117
  %571 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %540, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %570), !dbg !199, !call_argsrelate !117
  %acc_s.sroa.0.0.vec.extract3202 = extractelement <4 x float> %571, i64 0, !dbg !200
  %mul1203.12885 = fmul contract float %acc_s.sroa.0.0.vec.extract3202, 0x3FB99999A0000000, !dbg !201
  %572 = tail call contract noundef float @llvm.minnum.f32(float %mul1203.12885, float 0x4024CB5EC0000000), !dbg !202
  %573 = tail call contract noundef float @llvm.exp.f32(float %572), !dbg !204
  %acc_s.sroa.0.4.vec.extract3381 = extractelement <4 x float> %571, i64 1, !dbg !200
  %mul1203.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3381, 0x3FB99999A0000000, !dbg !201
  %574 = tail call contract noundef float @llvm.minnum.f32(float %mul1203.1.1, float 0x4024CB5EC0000000), !dbg !202
  %575 = tail call contract noundef float @llvm.exp.f32(float %574), !dbg !204
  %acc_s.sroa.0.8.vec.extract3554 = extractelement <4 x float> %571, i64 2, !dbg !200
  %mul1203.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3554, 0x3FB99999A0000000, !dbg !201
  %576 = tail call contract noundef float @llvm.minnum.f32(float %mul1203.2.1, float 0x4024CB5EC0000000), !dbg !202
  %577 = tail call contract noundef float @llvm.exp.f32(float %576), !dbg !204
  %acc_s.sroa.0.12.vec.extract3727 = extractelement <4 x float> %571, i64 3, !dbg !200
  %mul1203.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3727, 0x3FB99999A0000000, !dbg !201
  %578 = tail call contract noundef float @llvm.minnum.f32(float %mul1203.3.1, float 0x4024CB5EC0000000), !dbg !202
  %579 = tail call contract noundef float @llvm.exp.f32(float %578), !dbg !204
  %add1219.12886 = fadd contract float %sum_acc.sroa.0.3, %573, !dbg !282
  %add1219.1.1 = fadd contract float %sum_acc.sroa.36.3, %575, !dbg !282
  %add1219.2.1 = fadd contract float %sum_acc.sroa.70.3, %577, !dbg !282
  %add1219.3.1 = fadd contract float %sum_acc.sroa.104.3, %579, !dbg !282
  %580 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %573), !dbg !206
  %581 = insertelement <4 x i16> poison, i16 %580, i64 0, !dbg !210
  %582 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %575), !dbg !206
  %583 = insertelement <4 x i16> %581, i16 %582, i64 1, !dbg !210
  %584 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %577), !dbg !206
  %585 = insertelement <4 x i16> %583, i16 %584, i64 2, !dbg !210
  %586 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %579), !dbg !206
  %587 = insertelement <4 x i16> %585, i16 %586, i64 3, !dbg !210
  %acc_s_cast.sroa.0.6.vec.insert3049 = bitcast <4 x i16> %587 to <4 x half>, !dbg !210
  %588 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload37974493, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3049, <4 x float> %acc_o.sroa.0.1), !dbg !211, !call_argsrelate !111
  %589 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload38184494, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3049, <4 x float> %acc_o.sroa.42.1), !dbg !211, !call_argsrelate !111
  %590 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload38994495, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3049, <4 x float> %acc_o.sroa.82.1), !dbg !211, !call_argsrelate !111
  %591 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload39204496, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3049, <4 x float> %acc_o.sroa.122.1), !dbg !211, !call_argsrelate !111
  br label %if.end1255.1, !dbg !212

if.end1255.1:                                     ; preds = %if.end1168.1, %if.end1109.1
  %acc_o.sroa.122.2 = phi <4 x float> [ %acc_o.sroa.122.1, %if.end1109.1 ], [ %591, %if.end1168.1 ], !dbg !79
  %acc_o.sroa.82.2 = phi <4 x float> [ %acc_o.sroa.82.1, %if.end1109.1 ], [ %590, %if.end1168.1 ], !dbg !79
  %acc_o.sroa.42.2 = phi <4 x float> [ %acc_o.sroa.42.1, %if.end1109.1 ], [ %589, %if.end1168.1 ], !dbg !79
  %acc_o.sroa.0.2 = phi <4 x float> [ %acc_o.sroa.0.1, %if.end1109.1 ], [ %588, %if.end1168.1 ], !dbg !79
  %sum_acc.sroa.104.4 = phi float [ %sum_acc.sroa.104.3, %if.end1109.1 ], [ %add1219.3.1, %if.end1168.1 ], !dbg !79
  %sum_acc.sroa.70.4 = phi float [ %sum_acc.sroa.70.3, %if.end1109.1 ], [ %add1219.2.1, %if.end1168.1 ], !dbg !79
  %sum_acc.sroa.36.4 = phi float [ %sum_acc.sroa.36.3, %if.end1109.1 ], [ %add1219.1.1, %if.end1168.1 ], !dbg !79
  %sum_acc.sroa.0.4 = phi float [ %sum_acc.sroa.0.3, %if.end1109.1 ], [ %add1219.12886, %if.end1168.1 ], !dbg !79
  br i1 %or.cond2597.1, label %if.end1401.1, label %for.cond1263.preheader.1, !dbg !212

for.cond1263.preheader.1:                         ; preds = %if.end1255.1
  %592 = shl nsw i32 %cond.i.i2393.5, 10
  %mul1270.1 = and i32 %592, 64512
  %add1273.1 = add nuw nsw i32 %add1001, %mul1270.1
  %593 = zext nneg i32 %add1273.1 to i64, !dbg !213
  %add.ptr1278.12887 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %593, !dbg !214
  %V_reg.sroa.0.0.copyload37984505 = load <4 x half>, ptr addrspace(4) %add.ptr1278.12887, align 16, !dbg !215
  %V_reg.sroa.42.0.add.ptr1278.12887.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1278.12887, i64 8, !dbg !215
  %V_reg.sroa.42.0.copyload38194506 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1278.12887.sroa_idx, align 8, !dbg !215
  %594 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %593, !dbg !214
  %add.ptr1278.1.1 = getelementptr inbounds i8, ptr addrspace(4) %594, i64 1024, !dbg !214
  %V_reg.sroa.74.16.copyload39004507 = load <4 x half>, ptr addrspace(4) %add.ptr1278.1.1, align 16, !dbg !215
  %V_reg.sroa.114.16.add.ptr1278.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %594, i64 1032, !dbg !215
  %V_reg.sroa.114.16.copyload39214508 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1278.1.1.sroa_idx, align 8, !dbg !215
  %cmp1288.1 = icmp sgt i32 %mul11.5, %invariant.op, !dbg !216
  br i1 %cmp1288.1, label %for.cond1290.preheader.1, label %if.end1314.1, !dbg !217

for.cond1290.preheader.1:                         ; preds = %for.cond1263.preheader.1
  %add1297.1 = add nuw nsw i32 %mul11.5, %mul1150
  %cmp1300.not.12888 = icmp sgt i32 %add1297.1, %1, !dbg !218
  %fneg.2258.12889 = select i1 %cmp1300.not.12888, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3212 = insertelement <4 x float> poison, float %fneg.2258.12889, i64 0, !dbg !219
  %cmp1300.not.1.1.not = icmp slt i32 %add1297.1, %1, !dbg !218
  %fneg.2258.1.1 = select i1 %cmp1300.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3389 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3212, float %fneg.2258.1.1, i64 1, !dbg !219
  %add1298.2.1 = or disjoint i32 %add1297.1, 2, !dbg !220
  %cmp1300.not.2.1 = icmp sgt i32 %add1298.2.1, %1, !dbg !218
  %fneg.2258.2.1 = select i1 %cmp1300.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3562 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3389, float %fneg.2258.2.1, i64 2, !dbg !219
  %add1298.3.1 = or disjoint i32 %add1297.1, 3, !dbg !220
  %cmp1300.not.3.1 = icmp sgt i32 %add1298.3.1, %1, !dbg !218
  %fneg.2258.3.1 = select i1 %cmp1300.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3735 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3562, float %fneg.2258.3.1, i64 3, !dbg !219
  br label %if.end1314.1

if.end1314.1:                                     ; preds = %for.cond1263.preheader.1, %for.cond1290.preheader.1
  %acc_s.sroa.0.10 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3735, %for.cond1290.preheader.1 ], [ zeroinitializer, %for.cond1263.preheader.1 ], !dbg !79
  %595 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %550, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.10), !dbg !221, !call_argsrelate !117
  %596 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %549, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %595), !dbg !221, !call_argsrelate !117
  %597 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %548, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %596), !dbg !221, !call_argsrelate !117
  %598 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %547, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %597), !dbg !221, !call_argsrelate !117
  %acc_s.sroa.0.0.vec.extract3214 = extractelement <4 x float> %598, i64 0, !dbg !222
  %mul1349.12893 = fmul contract float %acc_s.sroa.0.0.vec.extract3214, 0x3FB99999A0000000, !dbg !223
  %599 = tail call contract noundef float @llvm.minnum.f32(float %mul1349.12893, float 0x4024CB5EC0000000), !dbg !224
  %600 = tail call contract noundef float @llvm.exp.f32(float %599), !dbg !226
  %acc_s.sroa.0.4.vec.extract3391 = extractelement <4 x float> %598, i64 1, !dbg !222
  %mul1349.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3391, 0x3FB99999A0000000, !dbg !223
  %601 = tail call contract noundef float @llvm.minnum.f32(float %mul1349.1.1, float 0x4024CB5EC0000000), !dbg !224
  %602 = tail call contract noundef float @llvm.exp.f32(float %601), !dbg !226
  %acc_s.sroa.0.8.vec.extract3564 = extractelement <4 x float> %598, i64 2, !dbg !222
  %mul1349.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3564, 0x3FB99999A0000000, !dbg !223
  %603 = tail call contract noundef float @llvm.minnum.f32(float %mul1349.2.1, float 0x4024CB5EC0000000), !dbg !224
  %604 = tail call contract noundef float @llvm.exp.f32(float %603), !dbg !226
  %acc_s.sroa.0.12.vec.extract3737 = extractelement <4 x float> %598, i64 3, !dbg !222
  %mul1349.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3737, 0x3FB99999A0000000, !dbg !223
  %605 = tail call contract noundef float @llvm.minnum.f32(float %mul1349.3.1, float 0x4024CB5EC0000000), !dbg !224
  %606 = tail call contract noundef float @llvm.exp.f32(float %605), !dbg !226
  %add1365.12894 = fadd contract float %sum_acc.sroa.0.4, %600, !dbg !228
  %add1365.1.1 = fadd contract float %sum_acc.sroa.36.4, %602, !dbg !228
  %add1365.2.1 = fadd contract float %sum_acc.sroa.70.4, %604, !dbg !228
  %add1365.3.1 = fadd contract float %sum_acc.sroa.104.4, %606, !dbg !228
  %607 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %600), !dbg !229
  %608 = insertelement <4 x i16> poison, i16 %607, i64 0, !dbg !233
  %609 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %602), !dbg !229
  %610 = insertelement <4 x i16> %608, i16 %609, i64 1, !dbg !233
  %611 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %604), !dbg !229
  %612 = insertelement <4 x i16> %610, i16 %611, i64 2, !dbg !233
  %613 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %606), !dbg !229
  %614 = insertelement <4 x i16> %612, i16 %613, i64 3, !dbg !233
  %acc_s_cast.sroa.0.6.vec.insert3051 = bitcast <4 x i16> %614 to <4 x half>, !dbg !233
  %615 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload37984505, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3051, <4 x float> %acc_o_alt.sroa.0.1), !dbg !234, !call_argsrelate !111
  %616 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload38194506, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3051, <4 x float> %acc_o_alt.sroa.26.1), !dbg !234, !call_argsrelate !111
  %617 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload39004507, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3051, <4 x float> %acc_o_alt.sroa.50.1), !dbg !234, !call_argsrelate !111
  %618 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload39214508, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3051, <4 x float> %acc_o_alt.sroa.74.1), !dbg !234, !call_argsrelate !111
  br label %if.end1401.1, !dbg !235

if.end1401.1:                                     ; preds = %if.end1314.1, %if.end1255.1
  %acc_o_alt.sroa.74.2 = phi <4 x float> [ %acc_o_alt.sroa.74.1, %if.end1255.1 ], [ %618, %if.end1314.1 ], !dbg !79
  %acc_o_alt.sroa.50.2 = phi <4 x float> [ %acc_o_alt.sroa.50.1, %if.end1255.1 ], [ %617, %if.end1314.1 ], !dbg !79
  %acc_o_alt.sroa.26.2 = phi <4 x float> [ %acc_o_alt.sroa.26.1, %if.end1255.1 ], [ %616, %if.end1314.1 ], !dbg !79
  %acc_o_alt.sroa.0.2 = phi <4 x float> [ %acc_o_alt.sroa.0.1, %if.end1255.1 ], [ %615, %if.end1314.1 ], !dbg !79
  %sum_acc.sroa.104.5 = phi float [ %sum_acc.sroa.104.4, %if.end1255.1 ], [ %add1365.3.1, %if.end1314.1 ], !dbg !79
  %sum_acc.sroa.70.5 = phi float [ %sum_acc.sroa.70.4, %if.end1255.1 ], [ %add1365.2.1, %if.end1314.1 ], !dbg !79
  %sum_acc.sroa.36.5 = phi float [ %sum_acc.sroa.36.4, %if.end1255.1 ], [ %add1365.1.1, %if.end1314.1 ], !dbg !79
  %sum_acc.sroa.0.5 = phi float [ %sum_acc.sroa.0.4, %if.end1255.1 ], [ %add1365.12894, %if.end1314.1 ], !dbg !79
  br i1 %or.cond2599.1, label %if.end1547.1, label %for.cond1409.preheader.1, !dbg !235

for.cond1409.preheader.1:                         ; preds = %if.end1401.1
  %619 = shl nsw i32 %cond.i.i2393.6, 10
  %mul1416.1 = and i32 %619, 64512
  %add1419.1 = add nuw nsw i32 %add1001, %mul1416.1
  %620 = zext nneg i32 %add1419.1 to i64, !dbg !236
  %add.ptr1424.12895 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %620, !dbg !237
  %V_reg.sroa.0.0.copyload37994517 = load <4 x half>, ptr addrspace(4) %add.ptr1424.12895, align 16, !dbg !238
  %V_reg.sroa.42.0.add.ptr1424.12895.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1424.12895, i64 8, !dbg !238
  %V_reg.sroa.42.0.copyload38204518 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1424.12895.sroa_idx, align 8, !dbg !238
  %621 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %620, !dbg !237
  %add.ptr1424.1.1 = getelementptr inbounds i8, ptr addrspace(4) %621, i64 1024, !dbg !237
  %V_reg.sroa.74.16.copyload39014519 = load <4 x half>, ptr addrspace(4) %add.ptr1424.1.1, align 16, !dbg !238
  %V_reg.sroa.114.16.add.ptr1424.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %621, i64 1032, !dbg !238
  %V_reg.sroa.114.16.copyload39224520 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1424.1.1.sroa_idx, align 8, !dbg !238
  %cmp1434.1 = icmp sgt i32 %mul11.6, %invariant.op, !dbg !239
  br i1 %cmp1434.1, label %for.cond1436.preheader.1, label %if.end1460.1, !dbg !240

for.cond1436.preheader.1:                         ; preds = %for.cond1409.preheader.1
  %add1443.1 = add nuw nsw i32 %mul11.6, %mul1150
  %cmp1446.not.12896 = icmp sgt i32 %add1443.1, %1, !dbg !241
  %fneg.2259.12897 = select i1 %cmp1446.not.12896, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3224 = insertelement <4 x float> poison, float %fneg.2259.12897, i64 0, !dbg !242
  %cmp1446.not.1.1.not = icmp slt i32 %add1443.1, %1, !dbg !241
  %fneg.2259.1.1 = select i1 %cmp1446.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3399 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3224, float %fneg.2259.1.1, i64 1, !dbg !242
  %add1444.2.1 = or disjoint i32 %add1443.1, 2, !dbg !243
  %cmp1446.not.2.1 = icmp sgt i32 %add1444.2.1, %1, !dbg !241
  %fneg.2259.2.1 = select i1 %cmp1446.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3572 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3399, float %fneg.2259.2.1, i64 2, !dbg !242
  %add1444.3.1 = or disjoint i32 %add1443.1, 3, !dbg !243
  %cmp1446.not.3.1 = icmp sgt i32 %add1444.3.1, %1, !dbg !241
  %fneg.2259.3.1 = select i1 %cmp1446.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3745 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3572, float %fneg.2259.3.1, i64 3, !dbg !242
  br label %if.end1460.1

if.end1460.1:                                     ; preds = %for.cond1409.preheader.1, %for.cond1436.preheader.1
  %acc_s.sroa.0.12 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3745, %for.cond1436.preheader.1 ], [ zeroinitializer, %for.cond1409.preheader.1 ], !dbg !79
  %622 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %557, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.12), !dbg !244, !call_argsrelate !117
  %623 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %556, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %622), !dbg !244, !call_argsrelate !117
  %624 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %555, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %623), !dbg !244, !call_argsrelate !117
  %625 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %554, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %624), !dbg !244, !call_argsrelate !117
  %acc_s.sroa.0.0.vec.extract3226 = extractelement <4 x float> %625, i64 0, !dbg !245
  %mul1495.12901 = fmul contract float %acc_s.sroa.0.0.vec.extract3226, 0x3FB99999A0000000, !dbg !246
  %626 = tail call contract noundef float @llvm.minnum.f32(float %mul1495.12901, float 0x4024CB5EC0000000), !dbg !247
  %627 = tail call contract noundef float @llvm.exp.f32(float %626), !dbg !249
  %acc_s.sroa.0.4.vec.extract3401 = extractelement <4 x float> %625, i64 1, !dbg !245
  %mul1495.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3401, 0x3FB99999A0000000, !dbg !246
  %628 = tail call contract noundef float @llvm.minnum.f32(float %mul1495.1.1, float 0x4024CB5EC0000000), !dbg !247
  %629 = tail call contract noundef float @llvm.exp.f32(float %628), !dbg !249
  %acc_s.sroa.0.8.vec.extract3574 = extractelement <4 x float> %625, i64 2, !dbg !245
  %mul1495.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3574, 0x3FB99999A0000000, !dbg !246
  %630 = tail call contract noundef float @llvm.minnum.f32(float %mul1495.2.1, float 0x4024CB5EC0000000), !dbg !247
  %631 = tail call contract noundef float @llvm.exp.f32(float %630), !dbg !249
  %acc_s.sroa.0.12.vec.extract3747 = extractelement <4 x float> %625, i64 3, !dbg !245
  %mul1495.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3747, 0x3FB99999A0000000, !dbg !246
  %632 = tail call contract noundef float @llvm.minnum.f32(float %mul1495.3.1, float 0x4024CB5EC0000000), !dbg !247
  %633 = tail call contract noundef float @llvm.exp.f32(float %632), !dbg !249
  %add1511.12902 = fadd contract float %sum_acc.sroa.0.5, %627, !dbg !251
  %add1511.1.1 = fadd contract float %sum_acc.sroa.36.5, %629, !dbg !251
  %add1511.2.1 = fadd contract float %sum_acc.sroa.70.5, %631, !dbg !251
  %add1511.3.1 = fadd contract float %sum_acc.sroa.104.5, %633, !dbg !251
  %634 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %627), !dbg !252
  %635 = insertelement <4 x i16> poison, i16 %634, i64 0, !dbg !256
  %636 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %629), !dbg !252
  %637 = insertelement <4 x i16> %635, i16 %636, i64 1, !dbg !256
  %638 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %631), !dbg !252
  %639 = insertelement <4 x i16> %637, i16 %638, i64 2, !dbg !256
  %640 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %633), !dbg !252
  %641 = insertelement <4 x i16> %639, i16 %640, i64 3, !dbg !256
  %acc_s_cast.sroa.0.6.vec.insert3053 = bitcast <4 x i16> %641 to <4 x half>, !dbg !256
  %642 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload37994517, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3053, <4 x float> %acc_o.sroa.0.2), !dbg !257, !call_argsrelate !111
  %643 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload38204518, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3053, <4 x float> %acc_o.sroa.42.2), !dbg !257, !call_argsrelate !111
  %644 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload39014519, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3053, <4 x float> %acc_o.sroa.82.2), !dbg !257, !call_argsrelate !111
  %645 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload39224520, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3053, <4 x float> %acc_o.sroa.122.2), !dbg !257, !call_argsrelate !111
  br label %if.end1547.1, !dbg !258

if.end1547.1:                                     ; preds = %if.end1460.1, %if.end1401.1
  %acc_o.sroa.122.3 = phi <4 x float> [ %acc_o.sroa.122.2, %if.end1401.1 ], [ %645, %if.end1460.1 ], !dbg !79
  %acc_o.sroa.82.3 = phi <4 x float> [ %acc_o.sroa.82.2, %if.end1401.1 ], [ %644, %if.end1460.1 ], !dbg !79
  %acc_o.sroa.42.3 = phi <4 x float> [ %acc_o.sroa.42.2, %if.end1401.1 ], [ %643, %if.end1460.1 ], !dbg !79
  %acc_o.sroa.0.3 = phi <4 x float> [ %acc_o.sroa.0.2, %if.end1401.1 ], [ %642, %if.end1460.1 ], !dbg !79
  %sum_acc.sroa.104.6 = phi float [ %sum_acc.sroa.104.5, %if.end1401.1 ], [ %add1511.3.1, %if.end1460.1 ], !dbg !79
  %sum_acc.sroa.70.6 = phi float [ %sum_acc.sroa.70.5, %if.end1401.1 ], [ %add1511.2.1, %if.end1460.1 ], !dbg !79
  %sum_acc.sroa.36.6 = phi float [ %sum_acc.sroa.36.5, %if.end1401.1 ], [ %add1511.1.1, %if.end1460.1 ], !dbg !79
  %sum_acc.sroa.0.6 = phi float [ %sum_acc.sroa.0.5, %if.end1401.1 ], [ %add1511.12902, %if.end1460.1 ], !dbg !79
  br i1 %or.cond2601.1, label %if.end1697, label %for.cond1555.preheader.1, !dbg !258

for.cond1555.preheader.1:                         ; preds = %if.end1547.1
  %646 = shl nsw i32 %cond.i.i2393.7, 10
  %mul1562.1 = and i32 %646, 64512
  %add1565.1 = add nuw nsw i32 %add1001, %mul1562.1
  %647 = zext nneg i32 %add1565.1 to i64, !dbg !259
  %add.ptr1570.12903 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %647, !dbg !260
  %V_reg.sroa.0.0.copyload38004529 = load <4 x half>, ptr addrspace(4) %add.ptr1570.12903, align 16, !dbg !261
  %V_reg.sroa.42.0.add.ptr1570.12903.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1570.12903, i64 8, !dbg !261
  %V_reg.sroa.42.0.copyload38214530 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1570.12903.sroa_idx, align 8, !dbg !261
  %648 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %647, !dbg !260
  %add.ptr1570.1.1 = getelementptr inbounds i8, ptr addrspace(4) %648, i64 1024, !dbg !260
  %V_reg.sroa.74.16.copyload39024531 = load <4 x half>, ptr addrspace(4) %add.ptr1570.1.1, align 16, !dbg !261
  %V_reg.sroa.114.16.add.ptr1570.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %648, i64 1032, !dbg !261
  %V_reg.sroa.114.16.copyload39234532 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1570.1.1.sroa_idx, align 8, !dbg !261
  %cmp1580.1 = icmp sgt i32 %mul11.7, %invariant.op, !dbg !262
  br i1 %cmp1580.1, label %for.cond1582.preheader.1, label %if.end1606.1, !dbg !263

for.cond1582.preheader.1:                         ; preds = %for.cond1555.preheader.1
  %add1589.1 = add nuw nsw i32 %mul11.7, %mul1150
  %cmp1592.not.12904 = icmp sgt i32 %add1589.1, %1, !dbg !264
  %fneg.2260.12905 = select i1 %cmp1592.not.12904, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3236 = insertelement <4 x float> poison, float %fneg.2260.12905, i64 0, !dbg !265
  %cmp1592.not.1.1.not = icmp slt i32 %add1589.1, %1, !dbg !264
  %fneg.2260.1.1 = select i1 %cmp1592.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3409 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3236, float %fneg.2260.1.1, i64 1, !dbg !265
  %add1590.2.1 = or disjoint i32 %add1589.1, 2, !dbg !266
  %cmp1592.not.2.1 = icmp sgt i32 %add1590.2.1, %1, !dbg !264
  %fneg.2260.2.1 = select i1 %cmp1592.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3582 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3409, float %fneg.2260.2.1, i64 2, !dbg !265
  %add1590.3.1 = or disjoint i32 %add1589.1, 3, !dbg !266
  %cmp1592.not.3.1 = icmp sgt i32 %add1590.3.1, %1, !dbg !264
  %fneg.2260.3.1 = select i1 %cmp1592.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3755 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3582, float %fneg.2260.3.1, i64 3, !dbg !265
  br label %if.end1606.1

if.end1606.1:                                     ; preds = %for.cond1555.preheader.1, %for.cond1582.preheader.1
  %acc_s.sroa.0.14 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3755, %for.cond1582.preheader.1 ], [ zeroinitializer, %for.cond1555.preheader.1 ], !dbg !79
  %649 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %564, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.14), !dbg !267, !call_argsrelate !117
  %650 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %563, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %649), !dbg !267, !call_argsrelate !117
  %651 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %562, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %650), !dbg !267, !call_argsrelate !117
  %652 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %561, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %651), !dbg !267, !call_argsrelate !117
  %acc_s.sroa.0.0.vec.extract3238 = extractelement <4 x float> %652, i64 0, !dbg !268
  %mul1641.12909 = fmul contract float %acc_s.sroa.0.0.vec.extract3238, 0x3FB99999A0000000, !dbg !269
  %653 = tail call contract noundef float @llvm.minnum.f32(float %mul1641.12909, float 0x4024CB5EC0000000), !dbg !270
  %654 = tail call contract noundef float @llvm.exp.f32(float %653), !dbg !272
  %acc_s.sroa.0.4.vec.extract3411 = extractelement <4 x float> %652, i64 1, !dbg !268
  %mul1641.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3411, 0x3FB99999A0000000, !dbg !269
  %655 = tail call contract noundef float @llvm.minnum.f32(float %mul1641.1.1, float 0x4024CB5EC0000000), !dbg !270
  %656 = tail call contract noundef float @llvm.exp.f32(float %655), !dbg !272
  %acc_s.sroa.0.8.vec.extract3584 = extractelement <4 x float> %652, i64 2, !dbg !268
  %mul1641.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3584, 0x3FB99999A0000000, !dbg !269
  %657 = tail call contract noundef float @llvm.minnum.f32(float %mul1641.2.1, float 0x4024CB5EC0000000), !dbg !270
  %658 = tail call contract noundef float @llvm.exp.f32(float %657), !dbg !272
  %acc_s.sroa.0.12.vec.extract3757 = extractelement <4 x float> %652, i64 3, !dbg !268
  %mul1641.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3757, 0x3FB99999A0000000, !dbg !269
  %659 = tail call contract noundef float @llvm.minnum.f32(float %mul1641.3.1, float 0x4024CB5EC0000000), !dbg !270
  %660 = tail call contract noundef float @llvm.exp.f32(float %659), !dbg !272
  %add1657.12910 = fadd contract float %sum_acc.sroa.0.6, %654, !dbg !274
  %add1657.1.1 = fadd contract float %sum_acc.sroa.36.6, %656, !dbg !274
  %add1657.2.1 = fadd contract float %sum_acc.sroa.70.6, %658, !dbg !274
  %add1657.3.1 = fadd contract float %sum_acc.sroa.104.6, %660, !dbg !274
  %661 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %654), !dbg !275
  %662 = insertelement <4 x i16> poison, i16 %661, i64 0, !dbg !279
  %663 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %656), !dbg !275
  %664 = insertelement <4 x i16> %662, i16 %663, i64 1, !dbg !279
  %665 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %658), !dbg !275
  %666 = insertelement <4 x i16> %664, i16 %665, i64 2, !dbg !279
  %667 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %660), !dbg !275
  %668 = insertelement <4 x i16> %666, i16 %667, i64 3, !dbg !279
  %acc_s_cast.sroa.0.6.vec.insert3055 = bitcast <4 x i16> %668 to <4 x half>, !dbg !279
  %669 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload38004529, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3055, <4 x float> %acc_o_alt.sroa.0.2), !dbg !280, !call_argsrelate !111
  %670 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload38214530, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3055, <4 x float> %acc_o_alt.sroa.26.2), !dbg !280, !call_argsrelate !111
  %671 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload39024531, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3055, <4 x float> %acc_o_alt.sroa.50.2), !dbg !280, !call_argsrelate !111
  %672 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload39234532, <4 x half> %acc_s_cast.sroa.0.6.vec.insert3055, <4 x float> %acc_o_alt.sroa.74.2), !dbg !280, !call_argsrelate !111
  br label %if.end1697, !dbg !281

if.end1697:                                       ; preds = %if.end1547.1, %if.end1606.1, %if.end865.1.1
  %.pre-phi4476 = phi i32 [ %22, %if.end865.1.1 ], [ %mul1005, %if.end1606.1 ], [ %mul1005, %if.end1547.1 ]
  %.pre-phi = phi i32 [ %.pre, %if.end865.1.1 ], [ %400, %if.end1606.1 ], [ %400, %if.end1547.1 ]
  %acc_o.sroa.122.4 = phi <4 x float> [ %363, %if.end865.1.1 ], [ %acc_o.sroa.122.3, %if.end1606.1 ], [ %acc_o.sroa.122.3, %if.end1547.1 ], !dbg !79
  %acc_o.sroa.82.4 = phi <4 x float> [ %362, %if.end865.1.1 ], [ %acc_o.sroa.82.3, %if.end1606.1 ], [ %acc_o.sroa.82.3, %if.end1547.1 ], !dbg !79
  %acc_o.sroa.42.4 = phi <4 x float> [ %361, %if.end865.1.1 ], [ %acc_o.sroa.42.3, %if.end1606.1 ], [ %acc_o.sroa.42.3, %if.end1547.1 ], !dbg !79
  %acc_o.sroa.0.4 = phi <4 x float> [ %360, %if.end865.1.1 ], [ %acc_o.sroa.0.3, %if.end1606.1 ], [ %acc_o.sroa.0.3, %if.end1547.1 ], !dbg !79
  %acc_o_alt.sroa.74.4 = phi <4 x float> [ %399, %if.end865.1.1 ], [ %672, %if.end1606.1 ], [ %acc_o_alt.sroa.74.2, %if.end1547.1 ], !dbg !79
  %acc_o_alt.sroa.50.4 = phi <4 x float> [ %398, %if.end865.1.1 ], [ %671, %if.end1606.1 ], [ %acc_o_alt.sroa.50.2, %if.end1547.1 ], !dbg !79
  %acc_o_alt.sroa.26.4 = phi <4 x float> [ %397, %if.end865.1.1 ], [ %670, %if.end1606.1 ], [ %acc_o_alt.sroa.26.2, %if.end1547.1 ], !dbg !79
  %acc_o_alt.sroa.0.4 = phi <4 x float> [ %396, %if.end865.1.1 ], [ %669, %if.end1606.1 ], [ %acc_o_alt.sroa.0.2, %if.end1547.1 ], !dbg !79
  %sum_acc.sroa.104.8 = phi float [ %add927.3.1, %if.end865.1.1 ], [ %add1657.3.1, %if.end1606.1 ], [ %sum_acc.sroa.104.6, %if.end1547.1 ], !dbg !79
  %sum_acc.sroa.70.8 = phi float [ %add927.2.1, %if.end865.1.1 ], [ %add1657.2.1, %if.end1606.1 ], [ %sum_acc.sroa.70.6, %if.end1547.1 ], !dbg !79
  %sum_acc.sroa.36.8 = phi float [ %add927.1.1, %if.end865.1.1 ], [ %add1657.1.1, %if.end1606.1 ], [ %sum_acc.sroa.36.6, %if.end1547.1 ], !dbg !79
  %sum_acc.sroa.0.8 = phi float [ %add927.12834, %if.end865.1.1 ], [ %add1657.12910, %if.end1606.1 ], [ %sum_acc.sroa.0.6, %if.end1547.1 ], !dbg !79
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.4, i64 0, !dbg !283
  %acc_o_alt.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.4, i64 0, !dbg !284
  %add1706 = fadd contract float %acc_o.sroa.0.0.vec.extract, %acc_o_alt.sroa.0.0.vec.extract, !dbg !285
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.4, i64 1, !dbg !283
  %acc_o_alt.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.4, i64 1, !dbg !284
  %add1706.1 = fadd contract float %acc_o.sroa.0.4.vec.extract, %acc_o_alt.sroa.0.4.vec.extract, !dbg !285
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.4, i64 2, !dbg !283
  %acc_o_alt.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.4, i64 2, !dbg !284
  %add1706.2 = fadd contract float %acc_o.sroa.0.8.vec.extract, %acc_o_alt.sroa.0.8.vec.extract, !dbg !285
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.4, i64 3, !dbg !283
  %acc_o_alt.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.4, i64 3, !dbg !284
  %add1706.3 = fadd contract float %acc_o.sroa.0.12.vec.extract, %acc_o_alt.sroa.0.12.vec.extract, !dbg !285
  %acc_o.sroa.42.16.vec.extract = extractelement <4 x float> %acc_o.sroa.42.4, i64 0, !dbg !283
  %acc_o_alt.sroa.26.16.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.26.4, i64 0, !dbg !284
  %add1706.4 = fadd contract float %acc_o.sroa.42.16.vec.extract, %acc_o_alt.sroa.26.16.vec.extract, !dbg !285
  %acc_o.sroa.42.20.vec.extract = extractelement <4 x float> %acc_o.sroa.42.4, i64 1, !dbg !283
  %acc_o_alt.sroa.26.20.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.26.4, i64 1, !dbg !284
  %add1706.5 = fadd contract float %acc_o.sroa.42.20.vec.extract, %acc_o_alt.sroa.26.20.vec.extract, !dbg !285
  %acc_o.sroa.42.24.vec.extract = extractelement <4 x float> %acc_o.sroa.42.4, i64 2, !dbg !283
  %acc_o_alt.sroa.26.24.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.26.4, i64 2, !dbg !284
  %add1706.6 = fadd contract float %acc_o.sroa.42.24.vec.extract, %acc_o_alt.sroa.26.24.vec.extract, !dbg !285
  %acc_o.sroa.42.28.vec.extract = extractelement <4 x float> %acc_o.sroa.42.4, i64 3, !dbg !283
  %acc_o_alt.sroa.26.28.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.26.4, i64 3, !dbg !284
  %add1706.7 = fadd contract float %acc_o.sroa.42.28.vec.extract, %acc_o_alt.sroa.26.28.vec.extract, !dbg !285
  %acc_o.sroa.82.32.vec.extract = extractelement <4 x float> %acc_o.sroa.82.4, i64 0, !dbg !283
  %acc_o_alt.sroa.50.32.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.4, i64 0, !dbg !284
  %add1706.8 = fadd contract float %acc_o.sroa.82.32.vec.extract, %acc_o_alt.sroa.50.32.vec.extract, !dbg !285
  %acc_o.sroa.82.36.vec.extract = extractelement <4 x float> %acc_o.sroa.82.4, i64 1, !dbg !283
  %acc_o_alt.sroa.50.36.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.4, i64 1, !dbg !284
  %add1706.9 = fadd contract float %acc_o.sroa.82.36.vec.extract, %acc_o_alt.sroa.50.36.vec.extract, !dbg !285
  %acc_o.sroa.82.40.vec.extract = extractelement <4 x float> %acc_o.sroa.82.4, i64 2, !dbg !283
  %acc_o_alt.sroa.50.40.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.4, i64 2, !dbg !284
  %add1706.10 = fadd contract float %acc_o.sroa.82.40.vec.extract, %acc_o_alt.sroa.50.40.vec.extract, !dbg !285
  %acc_o.sroa.82.44.vec.extract = extractelement <4 x float> %acc_o.sroa.82.4, i64 3, !dbg !283
  %acc_o_alt.sroa.50.44.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.4, i64 3, !dbg !284
  %add1706.11 = fadd contract float %acc_o.sroa.82.44.vec.extract, %acc_o_alt.sroa.50.44.vec.extract, !dbg !285
  %acc_o.sroa.122.48.vec.extract = extractelement <4 x float> %acc_o.sroa.122.4, i64 0, !dbg !283
  %acc_o_alt.sroa.74.48.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.74.4, i64 0, !dbg !284
  %add1706.12 = fadd contract float %acc_o.sroa.122.48.vec.extract, %acc_o_alt.sroa.74.48.vec.extract, !dbg !285
  %acc_o.sroa.122.52.vec.extract = extractelement <4 x float> %acc_o.sroa.122.4, i64 1, !dbg !283
  %acc_o_alt.sroa.74.52.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.74.4, i64 1, !dbg !284
  %add1706.13 = fadd contract float %acc_o.sroa.122.52.vec.extract, %acc_o_alt.sroa.74.52.vec.extract, !dbg !285
  %acc_o.sroa.122.56.vec.extract = extractelement <4 x float> %acc_o.sroa.122.4, i64 2, !dbg !283
  %acc_o_alt.sroa.74.56.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.74.4, i64 2, !dbg !284
  %add1706.14 = fadd contract float %acc_o.sroa.122.56.vec.extract, %acc_o_alt.sroa.74.56.vec.extract, !dbg !285
  %acc_o.sroa.122.60.vec.extract = extractelement <4 x float> %acc_o.sroa.122.4, i64 3, !dbg !283
  %acc_o_alt.sroa.74.60.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.74.4, i64 3, !dbg !284
  %add1706.15 = fadd contract float %acc_o.sroa.122.60.vec.extract, %acc_o_alt.sroa.74.60.vec.extract, !dbg !285
  %add1720 = fadd contract float %sum_acc.sroa.0.8, 0.000000e+00, !dbg !286
  %add1720.1 = fadd contract float %add1720, %sum_acc.sroa.36.8, !dbg !286
  %add1720.2 = fadd contract float %add1720.1, %sum_acc.sroa.70.8, !dbg !286
  %add1720.3 = fadd contract float %add1720.2, %sum_acc.sroa.104.8, !dbg !286
  %673 = bitcast float %add1720.3 to i32, !dbg !287
  %674 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !299
  %675 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %674) #11, !dbg !304
  %xor.i.i = xor i32 %675, 32, !dbg !305
  %676 = and i32 %675, -64, !dbg !306
  %and.i.i = add nsw i32 %676, 64, !dbg !306
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !307
  %cond.i.i2422 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %675, !dbg !308
  %shl.i.i = shl i32 %cond.i.i2422, 2, !dbg !309
  %677 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %673), !dbg !310
  %678 = bitcast i32 %677 to float, !dbg !311
  %add.i = fadd contract float %add1720.3, %678, !dbg !312
  %679 = bitcast float %add.i to i32, !dbg !315
  %680 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !322
  %681 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %680) #11, !dbg !325
  %xor.i.i2423 = xor i32 %681, 16, !dbg !326
  %682 = and i32 %681, -64, !dbg !327
  %and.i.i2424 = add nsw i32 %682, 64, !dbg !327
  %cmp.not.i.i2425 = icmp slt i32 %xor.i.i2423, %and.i.i2424, !dbg !328
  %cond.i.i2426 = select i1 %cmp.not.i.i2425, i32 %xor.i.i2423, i32 %681, !dbg !329
  %shl.i.i2427 = shl i32 %cond.i.i2426, 2, !dbg !330
  %683 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i2427, i32 %679), !dbg !331
  %684 = bitcast i32 %683 to float, !dbg !332
  %add.i.i = fadd contract float %add.i, %684, !dbg !333
  %cmp1729 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !335
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !336
  %condval_12.0 = select i1 %cmp1729, float %div, float 0.000000e+00, !dbg !336
  %mul1742 = fmul contract float %condval_12.0, %add1706, !dbg !337
  %mul1742.1 = fmul contract float %condval_12.0, %add1706.1, !dbg !337
  %mul1742.2 = fmul contract float %condval_12.0, %add1706.2, !dbg !337
  %mul1742.3 = fmul contract float %condval_12.0, %add1706.3, !dbg !337
  %mul1742.4 = fmul contract float %condval_12.0, %add1706.4, !dbg !337
  %mul1742.5 = fmul contract float %condval_12.0, %add1706.5, !dbg !337
  %mul1742.6 = fmul contract float %condval_12.0, %add1706.6, !dbg !337
  %mul1742.7 = fmul contract float %condval_12.0, %add1706.7, !dbg !337
  %mul1742.8 = fmul contract float %condval_12.0, %add1706.8, !dbg !337
  %mul1742.9 = fmul contract float %condval_12.0, %add1706.9, !dbg !337
  %mul1742.10 = fmul contract float %condval_12.0, %add1706.10, !dbg !337
  %mul1742.11 = fmul contract float %condval_12.0, %add1706.11, !dbg !337
  %mul1742.12 = fmul contract float %condval_12.0, %add1706.12, !dbg !337
  %mul1742.13 = fmul contract float %condval_12.0, %add1706.13, !dbg !337
  %mul1742.14 = fmul contract float %condval_12.0, %add1706.14, !dbg !337
  %mul1742.15 = fmul contract float %condval_12.0, %add1706.15, !dbg !337
  %685 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742), !dbg !338
  %O_reg.sroa.0.0.insert.ext = zext i16 %685 to i64, !dbg !342
  %686 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742.1), !dbg !338
  %O_reg.sroa.0.2.insert.ext = zext i16 %686 to i64, !dbg !342
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !342
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !342
  %687 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742.2), !dbg !338
  %O_reg.sroa.0.4.insert.ext = zext i16 %687 to i64, !dbg !342
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !342
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !342
  %688 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742.3), !dbg !338
  %O_reg.sroa.0.6.insert.ext = zext i16 %688 to i64, !dbg !342
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !342
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !342
  %689 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742.4), !dbg !338
  %O_reg.sroa.7.8.insert.ext = zext i16 %689 to i64, !dbg !342
  %690 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742.5), !dbg !338
  %O_reg.sroa.7.10.insert.ext = zext i16 %690 to i64, !dbg !342
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !342
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !342
  %691 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742.6), !dbg !338
  %O_reg.sroa.7.12.insert.ext = zext i16 %691 to i64, !dbg !342
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !342
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !342
  %692 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742.7), !dbg !338
  %O_reg.sroa.7.14.insert.ext = zext i16 %692 to i64, !dbg !342
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !342
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !342
  %693 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742.8), !dbg !338
  %O_reg.sroa.12.16.insert.ext = zext i16 %693 to i64, !dbg !342
  %694 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742.9), !dbg !338
  %O_reg.sroa.12.18.insert.ext = zext i16 %694 to i64, !dbg !342
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !342
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !342
  %695 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742.10), !dbg !338
  %O_reg.sroa.12.20.insert.ext = zext i16 %695 to i64, !dbg !342
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !342
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !342
  %696 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742.11), !dbg !338
  %O_reg.sroa.12.22.insert.ext = zext i16 %696 to i64, !dbg !342
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !342
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !342
  %697 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742.12), !dbg !338
  %O_reg.sroa.17.24.insert.ext = zext i16 %697 to i64, !dbg !342
  %698 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742.13), !dbg !338
  %O_reg.sroa.17.26.insert.ext = zext i16 %698 to i64, !dbg !342
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !342
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !342
  %699 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742.14), !dbg !338
  %O_reg.sroa.17.28.insert.ext = zext i16 %699 to i64, !dbg !342
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !342
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !342
  %700 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1742.15), !dbg !338
  %O_reg.sroa.17.30.insert.ext = zext i16 %700 to i64, !dbg !342
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !342
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !342
  %shr1784 = lshr i32 %18, 5
  %and1787 = and i32 %18, 7
  %mul1793 = and i32 %.pre-phi, 4
  %xor = xor i32 %shr1784, %and1787, !dbg !343
  %mul1788 = shl nuw nsw i32 %xor, 3, !dbg !344
  %add1789 = add nuw nsw i32 %mul1788, %mul25, !dbg !345
  %add1794 = or disjoint i32 %add1789, %mul1793, !dbg !346
  %add.ptr1796 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1794, !dbg !347
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr1796, align 8, !dbg !348
  %add1785.1 = add nuw nsw i32 %shr1784, 2, !dbg !349
  %xor.1 = xor i32 %add1785.1, %and1787, !dbg !343
  %mul1788.1 = shl nuw nsw i32 %xor.1, 3, !dbg !344
  %add1789.1 = add nuw nsw i32 %mul1788.1, %mul25, !dbg !345
  %add1794.1 = or disjoint i32 %add1789.1, %mul1793, !dbg !346
  %add.ptr1796.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1794.1, !dbg !347
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr1796.1, align 8, !dbg !348
  %add1785.2 = add nuw nsw i32 %shr1784, 4, !dbg !349
  %xor.2 = xor i32 %add1785.2, %and1787, !dbg !343
  %mul1788.2 = shl nuw nsw i32 %xor.2, 3, !dbg !344
  %add1789.2 = add nuw nsw i32 %mul1788.2, %mul25, !dbg !345
  %add1794.2 = or disjoint i32 %add1789.2, %mul1793, !dbg !346
  %add.ptr1796.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1794.2, !dbg !347
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr1796.2, align 8, !dbg !348
  %add1785.3 = add nuw nsw i32 %shr1784, 6, !dbg !349
  %xor.3 = xor i32 %add1785.3, %and1787, !dbg !343
  %mul1788.3 = shl nuw nsw i32 %xor.3, 3, !dbg !344
  %add1789.3 = add nuw nsw i32 %mul1788.3, %mul25, !dbg !345
  %add1794.3 = or disjoint i32 %add1789.3, %mul1793, !dbg !346
  %add.ptr1796.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1794.3, !dbg !347
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr1796.3, align 8, !dbg !348
  fence syncscope("warp") release, !dbg !350
  tail call void @llvm.mxc.barrier.warp(), !dbg !355
  fence syncscope("warp") acquire, !dbg !356
  %mul1807 = and i32 %.pre-phi4476, 8128
  %xor18132256 = and i32 %.pre-phi4476, 56
  %call1811.masked = and i32 %18, 1016
  %mul1814 = xor i32 %xor18132256, %call1811.masked
  %invariant.gep2588 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul1807, !dbg !357
  %invariant.gep2590 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep2588, i32 %mul1814, !dbg !357
  %add1824 = add nuw nsw i32 %add23, %.pre-phi4476
  %701 = zext nneg i32 %add1824 to i64, !dbg !358
  %add.ptr1829 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %701, !dbg !359
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1829, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep2590, i64 16, i1 false), !dbg !360, !tbaa.struct !361, !call_argsrelate !362
  %gep2591.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep2590, i32 1024, !dbg !363
  %702 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %701, !dbg !359
  %add.ptr1829.1 = getelementptr inbounds i8, ptr addrspace(1) %702, i64 1024, !dbg !359
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1829.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep2591.1, i64 16, i1 false), !dbg !360, !tbaa.struct !361, !call_argsrelate !362
  ret void, !dbg !364
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

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare i16 @llvm.convert.to.fp16.f32(float) #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp.f32(float) #7

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
declare i32 @llvm.smax.i32(i32, i32) #7

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smin.i32(i32, i32) #7

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.minnum.f32(float, float) #7

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #10

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #7 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #8 = { convergent nounwind willreturn }
attributes #9 = { nounwind willreturn }
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #11 = { nomerge }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmp8jr_tuv_/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmp8jr_tuv_/tvm_kernels.maca", directory: "")
!42 = !DILocation(line: 28, column: 3, scope: !40)
!43 = !DILocation(line: 29, column: 21, scope: !40)
!44 = !DILocation(line: 705, column: 10, scope: !45, inlinedAt: !47)
!45 = distinct !DISubprogram(name: "max", scope: !46, file: !46, line: 704, type: !7, scopeLine: 704, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!46 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!47 = distinct !DILocation(line: 30, column: 24, scope: !40)
!48 = !{i32 0, i32 -1}
!49 = !DILocation(line: 708, column: 10, scope: !50, inlinedAt: !51)
!50 = distinct !DISubprogram(name: "min", scope: !46, file: !46, line: 707, type: !7, scopeLine: 707, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!51 = distinct !DILocation(line: 30, column: 20, scope: !40)
!52 = !DILocation(line: 30, column: 48, scope: !40)
!53 = !DILocation(line: 29, column: 90, scope: !40)
!54 = !{i32 0, i32 1024}
!55 = !DILocation(line: 33, column: 3, scope: !40)
!56 = !DILocation(line: 34, column: 46, scope: !40)
!57 = !DILocation(line: 34, column: 32, scope: !40)
!58 = !DILocation(line: 49, column: 47, scope: !40)
!59 = !DILocation(line: 49, column: 154, scope: !40)
!60 = !DILocation(line: 49, column: 164, scope: !40)
!61 = !DILocation(line: 49, column: 246, scope: !40)
!62 = !DILocation(line: 49, column: 256, scope: !40)
!63 = !DILocation(line: 49, column: 338, scope: !40)
!64 = !DILocation(line: 49, column: 348, scope: !40)
!65 = !DILocation(line: 49, column: 430, scope: !40)
!66 = !DILocation(line: 49, column: 440, scope: !40)
!67 = !DILocation(line: 49, column: 522, scope: !40)
!68 = !DILocation(line: 49, column: 532, scope: !40)
!69 = !DILocation(line: 49, column: 614, scope: !40)
!70 = !DILocation(line: 49, column: 624, scope: !40)
!71 = !DILocation(line: 49, column: 706, scope: !40)
!72 = !DILocation(line: 49, column: 716, scope: !40)
!73 = !DILocation(line: 60, column: 33, scope: !40)
!74 = !DILocation(line: 60, column: 19, scope: !40)
!75 = !DILocation(line: 70, column: 13, scope: !40)
!76 = !DILocation(line: 71, column: 35, scope: !40)
!77 = !DILocation(line: 71, column: 21, scope: !40)
!78 = !DILocation(line: 72, column: 9, scope: !40)
!79 = !DILocation(line: 0, scope: !40)
!80 = !DILocation(line: 81, column: 13, scope: !40)
!81 = !DILocation(line: 82, column: 35, scope: !40)
!82 = !DILocation(line: 82, column: 21, scope: !40)
!83 = !DILocation(line: 83, column: 9, scope: !40)
!84 = !DILocation(line: 92, column: 13, scope: !40)
!85 = !DILocation(line: 93, column: 35, scope: !40)
!86 = !DILocation(line: 93, column: 21, scope: !40)
!87 = !DILocation(line: 94, column: 9, scope: !40)
!88 = !DILocation(line: 104, column: 35, scope: !40)
!89 = !DILocation(line: 104, column: 21, scope: !40)
!90 = !DILocation(line: 115, column: 36, scope: !40)
!91 = !{i32 1, i32 3, i32 -1}
!92 = !DILocation(line: 123, column: 32, scope: !40)
!93 = !DILocation(line: 123, column: 43, scope: !40)
!94 = !DILocation(line: 354, column: 10, scope: !95, inlinedAt: !96)
!95 = distinct !DISubprogram(name: "min", scope: !46, file: !46, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!96 = distinct !DILocation(line: 123, column: 27, scope: !40)
!97 = !DILocation(line: 288, column: 10, scope: !98, inlinedAt: !99)
!98 = distinct !DISubprogram(name: "expf", scope: !46, file: !46, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!99 = distinct !DILocation(line: 123, column: 22, scope: !40)
!100 = !DILocation(line: 75, column: 10, scope: !101, inlinedAt: !103)
!101 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !102, file: !102, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!102 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!103 = distinct !DILocation(line: 984, column: 9, scope: !104, inlinedAt: !106)
!104 = distinct !DISubprogram(name: "__float2half", scope: !105, file: !105, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!105 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!106 = distinct !DILocation(line: 133, column: 53, scope: !107, inlinedAt: !108)
!107 = distinct !DISubprogram(name: "__half", scope: !105, file: !105, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!108 = distinct !DILocation(line: 131, column: 34, scope: !40)
!109 = !DILocation(line: 131, column: 31, scope: !40)
!110 = !DILocation(line: 135, column: 36, scope: !40)
!111 = !{i32 4, i32 -1, i32 -1}
!112 = !DILocation(line: 144, column: 13, scope: !40)
!113 = !DILocation(line: 145, column: 35, scope: !40)
!114 = !DILocation(line: 145, column: 21, scope: !40)
!115 = !DILocation(line: 146, column: 9, scope: !40)
!116 = !DILocation(line: 156, column: 36, scope: !40)
!117 = !{i32 -1, i32 3, i32 -1}
!118 = !DILocation(line: 164, column: 33, scope: !40)
!119 = !DILocation(line: 164, column: 45, scope: !40)
!120 = !DILocation(line: 354, column: 10, scope: !95, inlinedAt: !121)
!121 = distinct !DILocation(line: 164, column: 28, scope: !40)
!122 = !DILocation(line: 288, column: 10, scope: !98, inlinedAt: !123)
!123 = distinct !DILocation(line: 164, column: 23, scope: !40)
!124 = !DILocation(line: 168, column: 40, scope: !40)
!125 = !DILocation(line: 75, column: 10, scope: !101, inlinedAt: !126)
!126 = distinct !DILocation(line: 984, column: 9, scope: !104, inlinedAt: !127)
!127 = distinct !DILocation(line: 133, column: 53, scope: !107, inlinedAt: !128)
!128 = distinct !DILocation(line: 172, column: 36, scope: !40)
!129 = !DILocation(line: 172, column: 33, scope: !40)
!130 = !DILocation(line: 176, column: 42, scope: !40)
!131 = !DILocation(line: 185, column: 13, scope: !40)
!132 = !DILocation(line: 186, column: 35, scope: !40)
!133 = !DILocation(line: 186, column: 21, scope: !40)
!134 = !DILocation(line: 187, column: 9, scope: !40)
!135 = !DILocation(line: 197, column: 36, scope: !40)
!136 = !DILocation(line: 205, column: 33, scope: !40)
!137 = !DILocation(line: 205, column: 45, scope: !40)
!138 = !DILocation(line: 354, column: 10, scope: !95, inlinedAt: !139)
!139 = distinct !DILocation(line: 205, column: 28, scope: !40)
!140 = !DILocation(line: 288, column: 10, scope: !98, inlinedAt: !141)
!141 = distinct !DILocation(line: 205, column: 23, scope: !40)
!142 = !DILocation(line: 209, column: 40, scope: !40)
!143 = !DILocation(line: 75, column: 10, scope: !101, inlinedAt: !144)
!144 = distinct !DILocation(line: 984, column: 9, scope: !104, inlinedAt: !145)
!145 = distinct !DILocation(line: 133, column: 53, scope: !107, inlinedAt: !146)
!146 = distinct !DILocation(line: 213, column: 36, scope: !40)
!147 = !DILocation(line: 213, column: 33, scope: !40)
!148 = !DILocation(line: 217, column: 38, scope: !40)
!149 = !DILocation(line: 226, column: 13, scope: !40)
!150 = !DILocation(line: 227, column: 35, scope: !40)
!151 = !DILocation(line: 227, column: 21, scope: !40)
!152 = !DILocation(line: 228, column: 9, scope: !40)
!153 = !DILocation(line: 238, column: 36, scope: !40)
!154 = !DILocation(line: 246, column: 33, scope: !40)
!155 = !DILocation(line: 246, column: 45, scope: !40)
!156 = !DILocation(line: 354, column: 10, scope: !95, inlinedAt: !157)
!157 = distinct !DILocation(line: 246, column: 28, scope: !40)
!158 = !DILocation(line: 288, column: 10, scope: !98, inlinedAt: !159)
!159 = distinct !DILocation(line: 246, column: 23, scope: !40)
!160 = !DILocation(line: 250, column: 40, scope: !40)
!161 = !DILocation(line: 75, column: 10, scope: !101, inlinedAt: !162)
!162 = distinct !DILocation(line: 984, column: 9, scope: !104, inlinedAt: !163)
!163 = distinct !DILocation(line: 133, column: 53, scope: !107, inlinedAt: !164)
!164 = distinct !DILocation(line: 254, column: 36, scope: !40)
!165 = !DILocation(line: 254, column: 33, scope: !40)
!166 = !DILocation(line: 258, column: 42, scope: !40)
!167 = !DILocation(line: 59, column: 13, scope: !40)
!168 = !DILocation(line: 61, column: 9, scope: !40)
!169 = !DILocation(line: 103, column: 13, scope: !40)
!170 = !DILocation(line: 105, column: 9, scope: !40)
!171 = !DILocation(line: 127, column: 38, scope: !40)
!172 = !DILocation(line: 493, column: 3, scope: !40)
!173 = !DILocation(line: 265, column: 5, scope: !40)
!174 = !DILocation(line: 270, column: 26, scope: !40)
!175 = !DILocation(line: 272, column: 9, scope: !40)
!176 = !DILocation(line: 273, column: 55, scope: !40)
!177 = !DILocation(line: 273, column: 41, scope: !40)
!178 = !DILocation(line: 276, column: 26, scope: !40)
!179 = !DILocation(line: 278, column: 9, scope: !40)
!180 = !DILocation(line: 279, column: 56, scope: !40)
!181 = !DILocation(line: 279, column: 42, scope: !40)
!182 = !DILocation(line: 282, column: 26, scope: !40)
!183 = !DILocation(line: 284, column: 9, scope: !40)
!184 = !DILocation(line: 285, column: 56, scope: !40)
!185 = !DILocation(line: 285, column: 42, scope: !40)
!186 = !DILocation(line: 288, column: 26, scope: !40)
!187 = !DILocation(line: 290, column: 9, scope: !40)
!188 = !DILocation(line: 291, column: 56, scope: !40)
!189 = !DILocation(line: 291, column: 42, scope: !40)
!190 = !DILocation(line: 294, column: 26, scope: !40)
!191 = !DILocation(line: 296, column: 9, scope: !40)
!192 = !DILocation(line: 297, column: 55, scope: !40)
!193 = !DILocation(line: 297, column: 41, scope: !40)
!194 = !DILocation(line: 299, column: 31, scope: !40)
!195 = !DILocation(line: 299, column: 13, scope: !40)
!196 = !DILocation(line: 303, column: 70, scope: !40)
!197 = !DILocation(line: 308, column: 25, scope: !40)
!198 = !DILocation(line: 303, column: 62, scope: !40)
!199 = !DILocation(line: 317, column: 36, scope: !40)
!200 = !DILocation(line: 325, column: 35, scope: !40)
!201 = !DILocation(line: 325, column: 47, scope: !40)
!202 = !DILocation(line: 354, column: 10, scope: !95, inlinedAt: !203)
!203 = distinct !DILocation(line: 325, column: 30, scope: !40)
!204 = !DILocation(line: 288, column: 10, scope: !98, inlinedAt: !205)
!205 = distinct !DILocation(line: 325, column: 25, scope: !40)
!206 = !DILocation(line: 75, column: 10, scope: !101, inlinedAt: !207)
!207 = distinct !DILocation(line: 984, column: 9, scope: !104, inlinedAt: !208)
!208 = distinct !DILocation(line: 133, column: 53, scope: !107, inlinedAt: !209)
!209 = distinct !DILocation(line: 333, column: 38, scope: !40)
!210 = !DILocation(line: 333, column: 35, scope: !40)
!211 = !DILocation(line: 337, column: 38, scope: !40)
!212 = !DILocation(line: 343, column: 26, scope: !40)
!213 = !DILocation(line: 345, column: 9, scope: !40)
!214 = !DILocation(line: 346, column: 55, scope: !40)
!215 = !DILocation(line: 346, column: 41, scope: !40)
!216 = !DILocation(line: 348, column: 31, scope: !40)
!217 = !DILocation(line: 348, column: 13, scope: !40)
!218 = !DILocation(line: 352, column: 70, scope: !40)
!219 = !DILocation(line: 357, column: 25, scope: !40)
!220 = !DILocation(line: 352, column: 62, scope: !40)
!221 = !DILocation(line: 366, column: 36, scope: !40)
!222 = !DILocation(line: 374, column: 35, scope: !40)
!223 = !DILocation(line: 374, column: 47, scope: !40)
!224 = !DILocation(line: 354, column: 10, scope: !95, inlinedAt: !225)
!225 = distinct !DILocation(line: 374, column: 30, scope: !40)
!226 = !DILocation(line: 288, column: 10, scope: !98, inlinedAt: !227)
!227 = distinct !DILocation(line: 374, column: 25, scope: !40)
!228 = !DILocation(line: 378, column: 42, scope: !40)
!229 = !DILocation(line: 75, column: 10, scope: !101, inlinedAt: !230)
!230 = distinct !DILocation(line: 984, column: 9, scope: !104, inlinedAt: !231)
!231 = distinct !DILocation(line: 133, column: 53, scope: !107, inlinedAt: !232)
!232 = distinct !DILocation(line: 382, column: 38, scope: !40)
!233 = !DILocation(line: 382, column: 35, scope: !40)
!234 = !DILocation(line: 386, column: 42, scope: !40)
!235 = !DILocation(line: 392, column: 26, scope: !40)
!236 = !DILocation(line: 394, column: 9, scope: !40)
!237 = !DILocation(line: 395, column: 55, scope: !40)
!238 = !DILocation(line: 395, column: 41, scope: !40)
!239 = !DILocation(line: 397, column: 31, scope: !40)
!240 = !DILocation(line: 397, column: 13, scope: !40)
!241 = !DILocation(line: 401, column: 70, scope: !40)
!242 = !DILocation(line: 406, column: 25, scope: !40)
!243 = !DILocation(line: 401, column: 62, scope: !40)
!244 = !DILocation(line: 415, column: 36, scope: !40)
!245 = !DILocation(line: 423, column: 35, scope: !40)
!246 = !DILocation(line: 423, column: 47, scope: !40)
!247 = !DILocation(line: 354, column: 10, scope: !95, inlinedAt: !248)
!248 = distinct !DILocation(line: 423, column: 30, scope: !40)
!249 = !DILocation(line: 288, column: 10, scope: !98, inlinedAt: !250)
!250 = distinct !DILocation(line: 423, column: 25, scope: !40)
!251 = !DILocation(line: 427, column: 42, scope: !40)
!252 = !DILocation(line: 75, column: 10, scope: !101, inlinedAt: !253)
!253 = distinct !DILocation(line: 984, column: 9, scope: !104, inlinedAt: !254)
!254 = distinct !DILocation(line: 133, column: 53, scope: !107, inlinedAt: !255)
!255 = distinct !DILocation(line: 431, column: 38, scope: !40)
!256 = !DILocation(line: 431, column: 35, scope: !40)
!257 = !DILocation(line: 435, column: 38, scope: !40)
!258 = !DILocation(line: 441, column: 26, scope: !40)
!259 = !DILocation(line: 443, column: 9, scope: !40)
!260 = !DILocation(line: 444, column: 55, scope: !40)
!261 = !DILocation(line: 444, column: 41, scope: !40)
!262 = !DILocation(line: 446, column: 31, scope: !40)
!263 = !DILocation(line: 446, column: 13, scope: !40)
!264 = !DILocation(line: 450, column: 70, scope: !40)
!265 = !DILocation(line: 455, column: 25, scope: !40)
!266 = !DILocation(line: 450, column: 62, scope: !40)
!267 = !DILocation(line: 464, column: 36, scope: !40)
!268 = !DILocation(line: 472, column: 35, scope: !40)
!269 = !DILocation(line: 472, column: 47, scope: !40)
!270 = !DILocation(line: 354, column: 10, scope: !95, inlinedAt: !271)
!271 = distinct !DILocation(line: 472, column: 30, scope: !40)
!272 = !DILocation(line: 288, column: 10, scope: !98, inlinedAt: !273)
!273 = distinct !DILocation(line: 472, column: 25, scope: !40)
!274 = !DILocation(line: 476, column: 42, scope: !40)
!275 = !DILocation(line: 75, column: 10, scope: !101, inlinedAt: !276)
!276 = distinct !DILocation(line: 984, column: 9, scope: !104, inlinedAt: !277)
!277 = distinct !DILocation(line: 133, column: 53, scope: !107, inlinedAt: !278)
!278 = distinct !DILocation(line: 480, column: 38, scope: !40)
!279 = !DILocation(line: 480, column: 35, scope: !40)
!280 = !DILocation(line: 484, column: 42, scope: !40)
!281 = !DILocation(line: 265, column: 40, scope: !40)
!282 = !DILocation(line: 329, column: 42, scope: !40)
!283 = !DILocation(line: 494, column: 20, scope: !40)
!284 = !DILocation(line: 494, column: 34, scope: !40)
!285 = !DILocation(line: 494, column: 32, scope: !40)
!286 = !DILocation(line: 499, column: 36, scope: !40)
!287 = !DILocation(line: 1018, column: 9, scope: !288, inlinedAt: !290)
!288 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !289, file: !289, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!289 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!290 = distinct !DILocation(line: 396, column: 10, scope: !291, inlinedAt: !293)
!291 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !292, file: !292, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!292 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!293 = distinct !DILocation(line: 129, column: 24, scope: !294, inlinedAt: !296)
!294 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !295, file: !295, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!295 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!296 = distinct !DILocation(line: 101, column: 14, scope: !297, inlinedAt: !298)
!297 = distinct !DISubprogram(name: "run<float>", scope: !295, file: !295, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!298 = distinct !DILocation(line: 501, column: 19, scope: !40)
!299 = !DILocation(line: 171, column: 37, scope: !300, inlinedAt: !301)
!300 = distinct !DISubprogram(name: "__lane_id", scope: !289, file: !289, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!301 = distinct !DILocation(line: 990, column: 14, scope: !302, inlinedAt: !303)
!302 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !289, file: !289, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!303 = distinct !DILocation(line: 1019, column: 11, scope: !288, inlinedAt: !290)
!304 = !DILocation(line: 171, column: 10, scope: !300, inlinedAt: !301)
!305 = !DILocation(line: 991, column: 20, scope: !302, inlinedAt: !303)
!306 = !DILocation(line: 992, column: 36, scope: !302, inlinedAt: !303)
!307 = !DILocation(line: 992, column: 17, scope: !302, inlinedAt: !303)
!308 = !DILocation(line: 992, column: 11, scope: !302, inlinedAt: !303)
!309 = !DILocation(line: 993, column: 43, scope: !302, inlinedAt: !303)
!310 = !DILocation(line: 993, column: 10, scope: !302, inlinedAt: !303)
!311 = !DILocation(line: 1020, column: 14, scope: !288, inlinedAt: !290)
!312 = !DILocation(line: 25, column: 14, scope: !313, inlinedAt: !314)
!313 = distinct !DISubprogram(name: "operator()<float>", scope: !295, file: !295, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!314 = distinct !DILocation(line: 129, column: 11, scope: !294, inlinedAt: !296)
!315 = !DILocation(line: 1018, column: 9, scope: !288, inlinedAt: !316)
!316 = distinct !DILocation(line: 396, column: 10, scope: !291, inlinedAt: !317)
!317 = distinct !DILocation(line: 129, column: 24, scope: !318, inlinedAt: !319)
!318 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !295, file: !295, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!319 = distinct !DILocation(line: 101, column: 14, scope: !320, inlinedAt: !321)
!320 = distinct !DISubprogram(name: "run<float>", scope: !295, file: !295, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!321 = distinct !DILocation(line: 134, column: 14, scope: !294, inlinedAt: !296)
!322 = !DILocation(line: 171, column: 37, scope: !300, inlinedAt: !323)
!323 = distinct !DILocation(line: 990, column: 14, scope: !302, inlinedAt: !324)
!324 = distinct !DILocation(line: 1019, column: 11, scope: !288, inlinedAt: !316)
!325 = !DILocation(line: 171, column: 10, scope: !300, inlinedAt: !323)
!326 = !DILocation(line: 991, column: 20, scope: !302, inlinedAt: !324)
!327 = !DILocation(line: 992, column: 36, scope: !302, inlinedAt: !324)
!328 = !DILocation(line: 992, column: 17, scope: !302, inlinedAt: !324)
!329 = !DILocation(line: 992, column: 11, scope: !302, inlinedAt: !324)
!330 = !DILocation(line: 993, column: 43, scope: !302, inlinedAt: !324)
!331 = !DILocation(line: 993, column: 10, scope: !302, inlinedAt: !324)
!332 = !DILocation(line: 1020, column: 14, scope: !288, inlinedAt: !316)
!333 = !DILocation(line: 25, column: 14, scope: !313, inlinedAt: !334)
!334 = distinct !DILocation(line: 129, column: 11, scope: !318, inlinedAt: !319)
!335 = !DILocation(line: 503, column: 32, scope: !40)
!336 = !DILocation(line: 503, column: 7, scope: !40)
!337 = !DILocation(line: 511, column: 32, scope: !40)
!338 = !DILocation(line: 75, column: 10, scope: !101, inlinedAt: !339)
!339 = distinct !DILocation(line: 984, column: 9, scope: !104, inlinedAt: !340)
!340 = distinct !DILocation(line: 133, column: 53, scope: !107, inlinedAt: !341)
!341 = distinct !DILocation(line: 517, column: 50, scope: !40)
!342 = !DILocation(line: 517, column: 47, scope: !40)
!343 = !DILocation(line: 522, column: 122, scope: !40)
!344 = !DILocation(line: 522, column: 150, scope: !40)
!345 = !DILocation(line: 522, column: 77, scope: !40)
!346 = !DILocation(line: 522, column: 156, scope: !40)
!347 = !DILocation(line: 522, column: 40, scope: !40)
!348 = !DILocation(line: 522, column: 199, scope: !40)
!349 = !DILocation(line: 522, column: 93, scope: !40)
!350 = !DILocation(line: 68, column: 3, scope: !351, inlinedAt: !352)
!351 = distinct !DISubprogram(name: "__barrier_warp", scope: !289, file: !289, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!352 = distinct !DILocation(line: 192, column: 3, scope: !353, inlinedAt: !354)
!353 = distinct !DISubprogram(name: "__syncwarp", scope: !289, file: !289, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!354 = distinct !DILocation(line: 524, column: 3, scope: !40)
!355 = !DILocation(line: 69, column: 3, scope: !351, inlinedAt: !352)
!356 = !DILocation(line: 70, column: 3, scope: !351, inlinedAt: !352)
!357 = !DILocation(line: 526, column: 8, scope: !40)
!358 = !DILocation(line: 526, column: 3, scope: !40)
!359 = !DILocation(line: 527, column: 22, scope: !40)
!360 = !DILocation(line: 527, column: 132, scope: !40)
!361 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!362 = !{i32 2, i32 -1, i32 -1, i32 -1}
!363 = !DILocation(line: 527, column: 169, scope: !40)
!364 = !DILocation(line: 529, column: 1, scope: !40)
