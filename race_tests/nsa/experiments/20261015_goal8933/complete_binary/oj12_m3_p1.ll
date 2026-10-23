; ModuleID = 'experiments/20261015_goal8933/complete_binary/oj12_m3_p1.bc'
source_filename = "/tmp/tmpac45_e93/tvm_kernels.maca"
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
  %cond.i.i2318 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64), !dbg !49
  %mul11 = shl nsw i32 %cond.i.i2318, 4, !dbg !52
  %4 = or disjoint i64 %2, 1, !dbg !53
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4, !dbg !43
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !dbg !43, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2318.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64), !dbg !49
  %mul11.1 = shl nsw i32 %cond.i.i2318.1, 4, !dbg !52
  %6 = or disjoint i64 %2, 2, !dbg !53
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6, !dbg !43
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !dbg !43, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2318.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64), !dbg !49
  %mul11.2 = shl nsw i32 %cond.i.i2318.2, 4, !dbg !52
  %8 = or disjoint i64 %2, 3, !dbg !53
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8, !dbg !43
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !dbg !43, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2318.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64), !dbg !49
  %mul11.3 = shl nsw i32 %cond.i.i2318.3, 4, !dbg !52
  %10 = or disjoint i64 %2, 4, !dbg !53
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10, !dbg !43
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !dbg !43, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2318.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64), !dbg !49
  %mul11.4 = shl nsw i32 %cond.i.i2318.4, 4, !dbg !52
  %12 = or disjoint i64 %2, 5, !dbg !53
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12, !dbg !43
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !dbg !43, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2318.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64), !dbg !49
  %mul11.5 = shl nsw i32 %cond.i.i2318.5, 4, !dbg !52
  %14 = or disjoint i64 %2, 6, !dbg !53
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14, !dbg !43
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !dbg !43, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2318.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64), !dbg !49
  %mul11.6 = shl nsw i32 %cond.i.i2318.6, 4, !dbg !52
  %16 = or disjoint i64 %2, 7, !dbg !53
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16, !dbg !43
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !dbg !43, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2318.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64), !dbg !49
  %mul11.7 = shl nsw i32 %cond.i.i2318.7, 4, !dbg !52
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
  %cond.i.i.i = tail call noundef i32 @llvm.umax.i32(i32 %mul11, i32 %mul11.1), !dbg !58
  %cond.i.i.i2319 = tail call noundef i32 @llvm.umax.i32(i32 %mul11.2, i32 %mul11.3), !dbg !61
  %cond.i.i.i2320 = tail call noundef i32 @llvm.umax.i32(i32 %cond.i.i.i, i32 %cond.i.i.i2319), !dbg !63
  %cond.i.i.i2321 = tail call noundef i32 @llvm.umax.i32(i32 %mul11.4, i32 %mul11.5), !dbg !65
  %cond.i.i.i2322 = tail call noundef i32 @llvm.umax.i32(i32 %mul11.6, i32 %mul11.7), !dbg !67
  %cond.i.i.i2323 = tail call noundef i32 @llvm.umax.i32(i32 %cond.i.i.i2321, i32 %cond.i.i.i2322), !dbg !69
  %cond.i.i.i2324 = tail call noundef i32 @llvm.umax.i32(i32 %cond.i.i.i2320, i32 %cond.i.i.i2323), !dbg !71
  %add86 = add nuw nsw i32 %1, 1, !dbg !73
  %shr87 = and i32 %add86, 2147483632, !dbg !74
  %cmp89 = icmp ult i32 %cond.i.i.i2324, %shr87, !dbg !75
  br i1 %cmp89, label %for.cond90.preheader, label %for.cond900.preheader, !dbg !76

for.cond900.preheader:                            ; preds = %entry
  %invariant.op = add nsw i32 %1, -15, !dbg !77
  %mul931 = shl nsw i32 %0, 16
  %mul938 = shl nuw nsw i32 %18, 3
  %add934 = or disjoint i32 %mul938, %mul931
  %22 = lshr i32 %18, 2
  %mul1083 = and i32 %22, 252
  %or.cond = icmp ugt i32 %mul11, 1023, !dbg !78
  %cmp924.not = icmp sgt i32 %mul11, %1
  %or.cond2518 = or i1 %or.cond, %cmp924.not, !dbg !78
  br i1 %or.cond2518, label %if.end949, label %for.cond926.preheader, !dbg !78

for.cond90.preheader:                             ; preds = %entry
  %conv = zext nneg i32 %0 to i64
  %23 = shl nuw nsw i32 %18, 3
  %mul128 = zext nneg i32 %23 to i64
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %mul128
  %invariant.gep2454 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %mul128
  %cmp114 = icmp sgt i32 %3, -1
  %cmp115 = icmp slt i32 %3, 64
  %24 = and i32 %cond.i.i2318, 268435455
  %shr120 = zext nneg i32 %24 to i64
  %cmp114.not = xor i1 %cmp114, true, !dbg !79
  %cmp115.not = xor i1 %cmp115, true, !dbg !79
  %brmerge = or i1 %cmp114.not, %cmp115.not, !dbg !79
  br i1 %brmerge, label %if.end, label %if.then116, !dbg !79

if.then116:                                       ; preds = %for.cond90.preheader
  %.idx = shl nuw nsw i64 %shr120, 11, !dbg !80
  %25 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx, !dbg !80
  %.idx2533 = shl nuw nsw i64 %conv, 17, !dbg !80
  %26 = getelementptr inbounds i8, ptr addrspace(4) %25, i64 %.idx2533, !dbg !80
  %27 = load <4 x half>, ptr addrspace(4) %26, align 16, !dbg !81, !tbaa !30
  %condval.sroa.6.0.add.ptr130.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %26, i64 8, !dbg !81
  %28 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr130.sroa_idx, align 8, !dbg !81, !tbaa !30
  br label %if.end, !dbg !82

if.end:                                           ; preds = %for.cond90.preheader, %if.then116
  %29 = phi <4 x half> [ %28, %if.then116 ], [ zeroinitializer, %for.cond90.preheader ], !dbg !83
  %30 = phi <4 x half> [ %27, %if.then116 ], [ zeroinitializer, %for.cond90.preheader ], !dbg !83
  %cmp114.not4464 = xor i1 %cmp114, true, !dbg !79
  %cmp115.not4465 = xor i1 %cmp115, true, !dbg !79
  %brmerge4466 = or i1 %cmp114.not4464, %cmp115.not4465, !dbg !79
  br i1 %brmerge4466, label %if.end.1, label %if.then116.1, !dbg !79

if.then116.1:                                     ; preds = %if.end
  %.idx.1 = shl nuw nsw i64 %shr120, 11, !dbg !80
  %31 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx.1, !dbg !80
  %.idx2533.1 = shl nuw nsw i64 %conv, 17, !dbg !80
  %32 = getelementptr inbounds i8, ptr addrspace(4) %31, i64 %.idx2533.1, !dbg !80
  %gep.1 = getelementptr inbounds i8, ptr addrspace(4) %32, i64 1024, !dbg !80
  %33 = load <4 x half>, ptr addrspace(4) %gep.1, align 16, !dbg !81, !tbaa !30
  %condval.sroa.6.0.add.ptr130.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %32, i64 1032, !dbg !81
  %34 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr130.sroa_idx.1, align 8, !dbg !81, !tbaa !30
  br label %if.end.1, !dbg !82

if.end.1:                                         ; preds = %if.end, %if.then116.1
  %35 = phi <4 x half> [ %34, %if.then116.1 ], [ zeroinitializer, %if.end ], !dbg !83
  %36 = phi <4 x half> [ %33, %if.then116.1 ], [ zeroinitializer, %if.end ], !dbg !83
  %cmp162 = icmp sgt i32 %5, -1
  %cmp164 = icmp slt i32 %5, 64
  %37 = and i32 %cond.i.i2318.1, 268435455
  %shr170 = zext nneg i32 %37 to i64
  %cmp162.not = xor i1 %cmp162, true, !dbg !84
  %cmp164.not = xor i1 %cmp164, true, !dbg !84
  %brmerge4467 = or i1 %cmp162.not, %cmp164.not, !dbg !84
  br i1 %brmerge4467, label %if.end204, label %if.then165, !dbg !84

if.then165:                                       ; preds = %if.end.1
  %.idx2534 = shl nuw nsw i64 %shr170, 11, !dbg !85
  %38 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2534, !dbg !85
  %.idx2535 = shl nuw nsw i64 %conv, 17, !dbg !85
  %39 = getelementptr inbounds i8, ptr addrspace(4) %38, i64 %.idx2535, !dbg !85
  %40 = load <4 x half>, ptr addrspace(4) %39, align 16, !dbg !86, !tbaa !30
  %condval_1.sroa.6.0.add.ptr180.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %39, i64 8, !dbg !86
  %41 = load <4 x half>, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr180.sroa_idx, align 8, !dbg !86, !tbaa !30
  br label %if.end204, !dbg !87

if.end204:                                        ; preds = %if.end.1, %if.then165
  %42 = phi <4 x half> [ %41, %if.then165 ], [ zeroinitializer, %if.end.1 ], !dbg !83
  %43 = phi <4 x half> [ %40, %if.then165 ], [ zeroinitializer, %if.end.1 ], !dbg !83
  %cmp162.not4468 = xor i1 %cmp162, true, !dbg !84
  %cmp164.not4469 = xor i1 %cmp164, true, !dbg !84
  %brmerge4470 = or i1 %cmp162.not4468, %cmp164.not4469, !dbg !84
  br i1 %brmerge4470, label %if.end204.1, label %if.then165.1, !dbg !84

if.then165.1:                                     ; preds = %if.end204
  %.idx2534.1 = shl nuw nsw i64 %shr170, 11, !dbg !85
  %44 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2534.1, !dbg !85
  %.idx2535.1 = shl nuw nsw i64 %conv, 17, !dbg !85
  %45 = getelementptr inbounds i8, ptr addrspace(4) %44, i64 %.idx2535.1, !dbg !85
  %gep2446.1 = getelementptr inbounds i8, ptr addrspace(4) %45, i64 1024, !dbg !85
  %46 = load <4 x half>, ptr addrspace(4) %gep2446.1, align 16, !dbg !86, !tbaa !30
  %condval_1.sroa.6.0.add.ptr180.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %45, i64 1032, !dbg !86
  %47 = load <4 x half>, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr180.sroa_idx.1, align 8, !dbg !86, !tbaa !30
  br label %if.end204.1, !dbg !87

if.end204.1:                                      ; preds = %if.end204, %if.then165.1
  %48 = phi <4 x half> [ %47, %if.then165.1 ], [ zeroinitializer, %if.end204 ], !dbg !83
  %49 = phi <4 x half> [ %46, %if.then165.1 ], [ zeroinitializer, %if.end204 ], !dbg !83
  %cmp216 = icmp sgt i32 %7, -1
  %cmp218 = icmp slt i32 %7, 64
  %50 = and i32 %cond.i.i2318.2, 268435455
  %shr224 = zext nneg i32 %50 to i64
  %cmp216.not = xor i1 %cmp216, true, !dbg !88
  %cmp218.not = xor i1 %cmp218, true, !dbg !88
  %brmerge4471 = or i1 %cmp216.not, %cmp218.not, !dbg !88
  br i1 %brmerge4471, label %if.end258, label %if.then219, !dbg !88

if.then219:                                       ; preds = %if.end204.1
  %.idx2536 = shl nuw nsw i64 %shr224, 11, !dbg !89
  %51 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2536, !dbg !89
  %.idx2537 = shl nuw nsw i64 %conv, 17, !dbg !89
  %52 = getelementptr inbounds i8, ptr addrspace(4) %51, i64 %.idx2537, !dbg !89
  %53 = load <4 x half>, ptr addrspace(4) %52, align 16, !dbg !90, !tbaa !30
  %condval_2.sroa.6.0.add.ptr234.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %52, i64 8, !dbg !90
  %54 = load <4 x half>, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr234.sroa_idx, align 8, !dbg !90, !tbaa !30
  br label %if.end258, !dbg !91

if.end258:                                        ; preds = %if.end204.1, %if.then219
  %55 = phi <4 x half> [ %54, %if.then219 ], [ zeroinitializer, %if.end204.1 ], !dbg !83
  %56 = phi <4 x half> [ %53, %if.then219 ], [ zeroinitializer, %if.end204.1 ], !dbg !83
  %cmp216.not4472 = xor i1 %cmp216, true, !dbg !88
  %cmp218.not4473 = xor i1 %cmp218, true, !dbg !88
  %brmerge4474 = or i1 %cmp216.not4472, %cmp218.not4473, !dbg !88
  br i1 %brmerge4474, label %if.end258.1, label %if.then219.1, !dbg !88

if.then219.1:                                     ; preds = %if.end258
  %.idx2536.1 = shl nuw nsw i64 %shr224, 11, !dbg !89
  %57 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2536.1, !dbg !89
  %.idx2537.1 = shl nuw nsw i64 %conv, 17, !dbg !89
  %58 = getelementptr inbounds i8, ptr addrspace(4) %57, i64 %.idx2537.1, !dbg !89
  %gep2449.1 = getelementptr inbounds i8, ptr addrspace(4) %58, i64 1024, !dbg !89
  %59 = load <4 x half>, ptr addrspace(4) %gep2449.1, align 16, !dbg !90, !tbaa !30
  %condval_2.sroa.6.0.add.ptr234.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %58, i64 1032, !dbg !90
  %60 = load <4 x half>, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr234.sroa_idx.1, align 8, !dbg !90, !tbaa !30
  br label %if.end258.1, !dbg !91

if.end258.1:                                      ; preds = %if.end258, %if.then219.1
  %61 = phi <4 x half> [ %60, %if.then219.1 ], [ zeroinitializer, %if.end258 ], !dbg !83
  %62 = phi <4 x half> [ %59, %if.then219.1 ], [ zeroinitializer, %if.end258 ], !dbg !83
  %cmp270 = icmp sgt i32 %9, -1
  %cmp272 = icmp slt i32 %9, 64
  %63 = and i32 %cond.i.i2318.3, 268435455
  %shr278 = zext nneg i32 %63 to i64
  %cmp270.not = xor i1 %cmp270, true, !dbg !92
  %cmp272.not = xor i1 %cmp272, true, !dbg !92
  %brmerge4475 = or i1 %cmp270.not, %cmp272.not, !dbg !92
  br i1 %brmerge4475, label %if.end312, label %if.then273, !dbg !92

if.then273:                                       ; preds = %if.end258.1
  %.idx2538 = shl nuw nsw i64 %shr278, 11, !dbg !93
  %64 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2538, !dbg !93
  %.idx2539 = shl nuw nsw i64 %conv, 17, !dbg !93
  %65 = getelementptr inbounds i8, ptr addrspace(4) %64, i64 %.idx2539, !dbg !93
  %66 = load <4 x half>, ptr addrspace(4) %65, align 16, !dbg !94, !tbaa !30
  %condval_3.sroa.6.0.add.ptr288.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %65, i64 8, !dbg !94
  %67 = load <4 x half>, ptr addrspace(4) %condval_3.sroa.6.0.add.ptr288.sroa_idx, align 8, !dbg !94, !tbaa !30
  br label %if.end312, !dbg !95

if.end312:                                        ; preds = %if.end258.1, %if.then273
  %68 = phi <4 x half> [ %67, %if.then273 ], [ zeroinitializer, %if.end258.1 ], !dbg !83
  %69 = phi <4 x half> [ %66, %if.then273 ], [ zeroinitializer, %if.end258.1 ], !dbg !83
  %cmp270.not4476 = xor i1 %cmp270, true, !dbg !92
  %cmp272.not4477 = xor i1 %cmp272, true, !dbg !92
  %brmerge4478 = or i1 %cmp270.not4476, %cmp272.not4477, !dbg !92
  br i1 %brmerge4478, label %if.end312.1, label %if.then273.1, !dbg !92

if.then273.1:                                     ; preds = %if.end312
  %.idx2538.1 = shl nuw nsw i64 %shr278, 11, !dbg !93
  %70 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2538.1, !dbg !93
  %.idx2539.1 = shl nuw nsw i64 %conv, 17, !dbg !93
  %71 = getelementptr inbounds i8, ptr addrspace(4) %70, i64 %.idx2539.1, !dbg !93
  %gep2452.1 = getelementptr inbounds i8, ptr addrspace(4) %71, i64 1024, !dbg !93
  %72 = load <4 x half>, ptr addrspace(4) %gep2452.1, align 16, !dbg !94, !tbaa !30
  %condval_3.sroa.6.0.add.ptr288.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %71, i64 1032, !dbg !94
  %73 = load <4 x half>, ptr addrspace(4) %condval_3.sroa.6.0.add.ptr288.sroa_idx.1, align 8, !dbg !94, !tbaa !30
  br label %if.end312.1, !dbg !95

if.end312.1:                                      ; preds = %if.end312, %if.then273.1
  %74 = phi <4 x half> [ %73, %if.then273.1 ], [ zeroinitializer, %if.end312 ], !dbg !83
  %75 = phi <4 x half> [ %72, %if.then273.1 ], [ zeroinitializer, %if.end312 ], !dbg !83
  %cmp114.not4479 = xor i1 %cmp114, true, !dbg !96
  %cmp115.not4480 = xor i1 %cmp115, true, !dbg !96
  %brmerge4481 = or i1 %cmp114.not4479, %cmp115.not4480, !dbg !96
  br i1 %brmerge4481, label %if.end366, label %if.then327, !dbg !96

if.then327:                                       ; preds = %if.end312.1
  %.idx2540 = shl nuw nsw i64 %shr120, 11, !dbg !97
  %76 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2540, !dbg !97
  %.idx2541 = shl nuw nsw i64 %conv, 17, !dbg !97
  %77 = getelementptr inbounds i8, ptr addrspace(4) %76, i64 %.idx2541, !dbg !97
  %78 = load <4 x half>, ptr addrspace(4) %77, align 16, !dbg !98, !tbaa !30
  %condval_4.sroa.6.0.add.ptr342.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %77, i64 8, !dbg !98
  %79 = load <4 x half>, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr342.sroa_idx, align 8, !dbg !98, !tbaa !30
  br label %if.end366, !dbg !99

if.end366:                                        ; preds = %if.end312.1, %if.then327
  %80 = phi <4 x half> [ %79, %if.then327 ], [ zeroinitializer, %if.end312.1 ], !dbg !83
  %81 = phi <4 x half> [ %78, %if.then327 ], [ zeroinitializer, %if.end312.1 ], !dbg !83
  %cmp114.not4482 = xor i1 %cmp114, true, !dbg !96
  %cmp115.not4483 = xor i1 %cmp115, true, !dbg !96
  %brmerge4484 = or i1 %cmp114.not4482, %cmp115.not4483, !dbg !96
  br i1 %brmerge4484, label %if.end366.1, label %if.then327.1, !dbg !96

if.then327.1:                                     ; preds = %if.end366
  %.idx2540.1 = shl nuw nsw i64 %shr120, 11, !dbg !97
  %82 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2540.1, !dbg !97
  %.idx2541.1 = shl nuw nsw i64 %conv, 17, !dbg !97
  %83 = getelementptr inbounds i8, ptr addrspace(4) %82, i64 %.idx2541.1, !dbg !97
  %gep2455.1 = getelementptr inbounds i8, ptr addrspace(4) %83, i64 1024, !dbg !97
  %84 = load <4 x half>, ptr addrspace(4) %gep2455.1, align 16, !dbg !98, !tbaa !30
  %condval_4.sroa.6.0.add.ptr342.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %83, i64 1032, !dbg !98
  %85 = load <4 x half>, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr342.sroa_idx.1, align 8, !dbg !98, !tbaa !30
  br label %if.end366.1, !dbg !99

if.end366.1:                                      ; preds = %if.end366, %if.then327.1
  %86 = phi <4 x half> [ %85, %if.then327.1 ], [ zeroinitializer, %if.end366 ], !dbg !83
  %87 = phi <4 x half> [ %84, %if.then327.1 ], [ zeroinitializer, %if.end366 ], !dbg !83
  %88 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %30, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !100, !call_argsrelate !101
  %89 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %29, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %88), !dbg !100, !call_argsrelate !101
  %90 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %36, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %89), !dbg !100, !call_argsrelate !101
  %91 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %35, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %90), !dbg !100, !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract3097 = extractelement <4 x float> %91, i64 0, !dbg !102
  %mul412 = fmul contract float %acc_s.sroa.0.0.vec.extract3097, 0x3FB99999A0000000, !dbg !103
  %92 = tail call contract noundef float @llvm.minnum.f32(float %mul412, float 0x4024CB5EC0000000), !dbg !104
  %93 = tail call contract noundef float @llvm.exp.f32(float %92), !dbg !107
  %acc_s.sroa.0.4.vec.extract3278 = extractelement <4 x float> %91, i64 1, !dbg !102
  %mul412.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3278, 0x3FB99999A0000000, !dbg !103
  %94 = tail call contract noundef float @llvm.minnum.f32(float %mul412.1, float 0x4024CB5EC0000000), !dbg !104
  %95 = tail call contract noundef float @llvm.exp.f32(float %94), !dbg !107
  %acc_s.sroa.0.8.vec.extract3451 = extractelement <4 x float> %91, i64 2, !dbg !102
  %mul412.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3451, 0x3FB99999A0000000, !dbg !103
  %96 = tail call contract noundef float @llvm.minnum.f32(float %mul412.2, float 0x4024CB5EC0000000), !dbg !104
  %97 = tail call contract noundef float @llvm.exp.f32(float %96), !dbg !107
  %acc_s.sroa.0.12.vec.extract3624 = extractelement <4 x float> %91, i64 3, !dbg !102
  %mul412.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3624, 0x3FB99999A0000000, !dbg !103
  %98 = tail call contract noundef float @llvm.minnum.f32(float %mul412.3, float 0x4024CB5EC0000000), !dbg !104
  %99 = tail call contract noundef float @llvm.exp.f32(float %98), !dbg !107
  %100 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %93), !dbg !110
  %101 = insertelement <4 x i16> poison, i16 %100, i64 0, !dbg !119
  %102 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %95), !dbg !110
  %103 = insertelement <4 x i16> %101, i16 %102, i64 1, !dbg !119
  %104 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %97), !dbg !110
  %105 = insertelement <4 x i16> %103, i16 %104, i64 2, !dbg !119
  %106 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %99), !dbg !110
  %107 = insertelement <4 x i16> %105, i16 %106, i64 3, !dbg !119
  %acc_s_cast.sroa.0.6.vec.insert2964 = bitcast <4 x i16> %107 to <4 x half>, !dbg !119
  %108 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %81, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2964, <4 x float> zeroinitializer), !dbg !120
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %80, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2964, <4 x float> zeroinitializer), !dbg !120
  %110 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %87, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2964, <4 x float> zeroinitializer), !dbg !120
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %86, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2964, <4 x float> zeroinitializer), !dbg !120
  %cmp162.not4485 = xor i1 %cmp162, true, !dbg !121
  %cmp164.not4486 = xor i1 %cmp164, true, !dbg !121
  %brmerge4487 = or i1 %cmp162.not4485, %cmp164.not4486, !dbg !121
  br i1 %brmerge4487, label %if.end510, label %if.then471, !dbg !121

if.then471:                                       ; preds = %if.end366.1
  %.idx2542 = shl nuw nsw i64 %shr170, 11, !dbg !122
  %112 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2542, !dbg !122
  %.idx2543 = shl nuw nsw i64 %conv, 17, !dbg !122
  %113 = getelementptr inbounds i8, ptr addrspace(4) %112, i64 %.idx2543, !dbg !122
  %114 = load <4 x half>, ptr addrspace(4) %113, align 16, !dbg !123, !tbaa !30
  %condval_5.sroa.6.0.add.ptr486.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %113, i64 8, !dbg !123
  %115 = load <4 x half>, ptr addrspace(4) %condval_5.sroa.6.0.add.ptr486.sroa_idx, align 8, !dbg !123, !tbaa !30
  br label %if.end510, !dbg !124

if.end510:                                        ; preds = %if.end366.1, %if.then471
  %116 = phi <4 x half> [ %115, %if.then471 ], [ zeroinitializer, %if.end366.1 ], !dbg !83
  %117 = phi <4 x half> [ %114, %if.then471 ], [ zeroinitializer, %if.end366.1 ], !dbg !83
  %cmp162.not4488 = xor i1 %cmp162, true, !dbg !121
  %cmp164.not4489 = xor i1 %cmp164, true, !dbg !121
  %brmerge4490 = or i1 %cmp162.not4488, %cmp164.not4489, !dbg !121
  br i1 %brmerge4490, label %if.end510.1, label %if.then471.1, !dbg !121

if.then471.1:                                     ; preds = %if.end510
  %.idx2542.1 = shl nuw nsw i64 %shr170, 11, !dbg !122
  %118 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2542.1, !dbg !122
  %.idx2543.1 = shl nuw nsw i64 %conv, 17, !dbg !122
  %119 = getelementptr inbounds i8, ptr addrspace(4) %118, i64 %.idx2543.1, !dbg !122
  %gep2468.1 = getelementptr inbounds i8, ptr addrspace(4) %119, i64 1024, !dbg !122
  %120 = load <4 x half>, ptr addrspace(4) %gep2468.1, align 16, !dbg !123, !tbaa !30
  %condval_5.sroa.6.0.add.ptr486.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %119, i64 1032, !dbg !123
  %121 = load <4 x half>, ptr addrspace(4) %condval_5.sroa.6.0.add.ptr486.sroa_idx.1, align 8, !dbg !123, !tbaa !30
  br label %if.end510.1, !dbg !124

if.end510.1:                                      ; preds = %if.end510, %if.then471.1
  %122 = phi <4 x half> [ %121, %if.then471.1 ], [ zeroinitializer, %if.end510 ], !dbg !83
  %123 = phi <4 x half> [ %120, %if.then471.1 ], [ zeroinitializer, %if.end510 ], !dbg !83
  %124 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %43, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !125, !call_argsrelate !101
  %125 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %42, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %124), !dbg !125, !call_argsrelate !101
  %126 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %49, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %125), !dbg !125, !call_argsrelate !101
  %127 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %48, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %126), !dbg !125, !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract3105 = extractelement <4 x float> %127, i64 0, !dbg !126
  %mul556 = fmul contract float %acc_s.sroa.0.0.vec.extract3105, 0x3FB99999A0000000, !dbg !127
  %128 = tail call contract noundef float @llvm.minnum.f32(float %mul556, float 0x4024CB5EC0000000), !dbg !128
  %129 = tail call contract noundef float @llvm.exp.f32(float %128), !dbg !130
  %acc_s.sroa.0.4.vec.extract3286 = extractelement <4 x float> %127, i64 1, !dbg !126
  %mul556.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3286, 0x3FB99999A0000000, !dbg !127
  %130 = tail call contract noundef float @llvm.minnum.f32(float %mul556.1, float 0x4024CB5EC0000000), !dbg !128
  %131 = tail call contract noundef float @llvm.exp.f32(float %130), !dbg !130
  %acc_s.sroa.0.8.vec.extract3459 = extractelement <4 x float> %127, i64 2, !dbg !126
  %mul556.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3459, 0x3FB99999A0000000, !dbg !127
  %132 = tail call contract noundef float @llvm.minnum.f32(float %mul556.2, float 0x4024CB5EC0000000), !dbg !128
  %133 = tail call contract noundef float @llvm.exp.f32(float %132), !dbg !130
  %acc_s.sroa.0.12.vec.extract3632 = extractelement <4 x float> %127, i64 3, !dbg !126
  %mul556.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3632, 0x3FB99999A0000000, !dbg !127
  %134 = tail call contract noundef float @llvm.minnum.f32(float %mul556.3, float 0x4024CB5EC0000000), !dbg !128
  %135 = tail call contract noundef float @llvm.exp.f32(float %134), !dbg !130
  %add572 = fadd contract float %93, %129, !dbg !132
  %add572.1 = fadd contract float %95, %131, !dbg !132
  %add572.2 = fadd contract float %97, %133, !dbg !132
  %add572.3 = fadd contract float %99, %135, !dbg !132
  %136 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %129), !dbg !133
  %137 = insertelement <4 x i16> poison, i16 %136, i64 0, !dbg !137
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %131), !dbg !133
  %139 = insertelement <4 x i16> %137, i16 %138, i64 1, !dbg !137
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %133), !dbg !133
  %141 = insertelement <4 x i16> %139, i16 %140, i64 2, !dbg !137
  %142 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %135), !dbg !133
  %143 = insertelement <4 x i16> %141, i16 %142, i64 3, !dbg !137
  %acc_s_cast.sroa.0.6.vec.insert2966 = bitcast <4 x i16> %143 to <4 x half>, !dbg !137
  %144 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %117, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2966, <4 x float> zeroinitializer), !dbg !138
  %145 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %116, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2966, <4 x float> zeroinitializer), !dbg !138
  %146 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %123, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2966, <4 x float> zeroinitializer), !dbg !138
  %147 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %122, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2966, <4 x float> zeroinitializer), !dbg !138
  %cmp216.not4491 = xor i1 %cmp216, true, !dbg !139
  %cmp218.not4492 = xor i1 %cmp218, true, !dbg !139
  %brmerge4493 = or i1 %cmp216.not4491, %cmp218.not4492, !dbg !139
  br i1 %brmerge4493, label %if.end654, label %if.then615, !dbg !139

if.then615:                                       ; preds = %if.end510.1
  %.idx2544 = shl nuw nsw i64 %shr224, 11, !dbg !140
  %148 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2544, !dbg !140
  %.idx2545 = shl nuw nsw i64 %conv, 17, !dbg !140
  %149 = getelementptr inbounds i8, ptr addrspace(4) %148, i64 %.idx2545, !dbg !140
  %150 = load <4 x half>, ptr addrspace(4) %149, align 16, !dbg !141, !tbaa !30
  %condval_6.sroa.6.0.add.ptr630.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %149, i64 8, !dbg !141
  %151 = load <4 x half>, ptr addrspace(4) %condval_6.sroa.6.0.add.ptr630.sroa_idx, align 8, !dbg !141, !tbaa !30
  br label %if.end654, !dbg !142

if.end654:                                        ; preds = %if.end510.1, %if.then615
  %152 = phi <4 x half> [ %151, %if.then615 ], [ zeroinitializer, %if.end510.1 ], !dbg !83
  %153 = phi <4 x half> [ %150, %if.then615 ], [ zeroinitializer, %if.end510.1 ], !dbg !83
  %cmp216.not4494 = xor i1 %cmp216, true, !dbg !139
  %cmp218.not4495 = xor i1 %cmp218, true, !dbg !139
  %brmerge4496 = or i1 %cmp216.not4494, %cmp218.not4495, !dbg !139
  br i1 %brmerge4496, label %if.end654.1, label %if.then615.1, !dbg !139

if.then615.1:                                     ; preds = %if.end654
  %.idx2544.1 = shl nuw nsw i64 %shr224, 11, !dbg !140
  %154 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2544.1, !dbg !140
  %.idx2545.1 = shl nuw nsw i64 %conv, 17, !dbg !140
  %155 = getelementptr inbounds i8, ptr addrspace(4) %154, i64 %.idx2545.1, !dbg !140
  %gep2481.1 = getelementptr inbounds i8, ptr addrspace(4) %155, i64 1024, !dbg !140
  %156 = load <4 x half>, ptr addrspace(4) %gep2481.1, align 16, !dbg !141, !tbaa !30
  %condval_6.sroa.6.0.add.ptr630.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %155, i64 1032, !dbg !141
  %157 = load <4 x half>, ptr addrspace(4) %condval_6.sroa.6.0.add.ptr630.sroa_idx.1, align 8, !dbg !141, !tbaa !30
  br label %if.end654.1, !dbg !142

if.end654.1:                                      ; preds = %if.end654, %if.then615.1
  %158 = phi <4 x half> [ %157, %if.then615.1 ], [ zeroinitializer, %if.end654 ], !dbg !83
  %159 = phi <4 x half> [ %156, %if.then615.1 ], [ zeroinitializer, %if.end654 ], !dbg !83
  %160 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %56, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !143, !call_argsrelate !101
  %161 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %55, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %160), !dbg !143, !call_argsrelate !101
  %162 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %62, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %161), !dbg !143, !call_argsrelate !101
  %163 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %61, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %162), !dbg !143, !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract3113 = extractelement <4 x float> %163, i64 0, !dbg !144
  %mul700 = fmul contract float %acc_s.sroa.0.0.vec.extract3113, 0x3FB99999A0000000, !dbg !145
  %164 = tail call contract noundef float @llvm.minnum.f32(float %mul700, float 0x4024CB5EC0000000), !dbg !146
  %165 = tail call contract noundef float @llvm.exp.f32(float %164), !dbg !148
  %acc_s.sroa.0.4.vec.extract3294 = extractelement <4 x float> %163, i64 1, !dbg !144
  %mul700.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3294, 0x3FB99999A0000000, !dbg !145
  %166 = tail call contract noundef float @llvm.minnum.f32(float %mul700.1, float 0x4024CB5EC0000000), !dbg !146
  %167 = tail call contract noundef float @llvm.exp.f32(float %166), !dbg !148
  %acc_s.sroa.0.8.vec.extract3467 = extractelement <4 x float> %163, i64 2, !dbg !144
  %mul700.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3467, 0x3FB99999A0000000, !dbg !145
  %168 = tail call contract noundef float @llvm.minnum.f32(float %mul700.2, float 0x4024CB5EC0000000), !dbg !146
  %169 = tail call contract noundef float @llvm.exp.f32(float %168), !dbg !148
  %acc_s.sroa.0.12.vec.extract3640 = extractelement <4 x float> %163, i64 3, !dbg !144
  %mul700.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3640, 0x3FB99999A0000000, !dbg !145
  %170 = tail call contract noundef float @llvm.minnum.f32(float %mul700.3, float 0x4024CB5EC0000000), !dbg !146
  %171 = tail call contract noundef float @llvm.exp.f32(float %170), !dbg !148
  %add716 = fadd contract float %add572, %165, !dbg !150
  %add716.1 = fadd contract float %add572.1, %167, !dbg !150
  %add716.2 = fadd contract float %add572.2, %169, !dbg !150
  %add716.3 = fadd contract float %add572.3, %171, !dbg !150
  %172 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %165), !dbg !151
  %173 = insertelement <4 x i16> poison, i16 %172, i64 0, !dbg !155
  %174 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %167), !dbg !151
  %175 = insertelement <4 x i16> %173, i16 %174, i64 1, !dbg !155
  %176 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %169), !dbg !151
  %177 = insertelement <4 x i16> %175, i16 %176, i64 2, !dbg !155
  %178 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %171), !dbg !151
  %179 = insertelement <4 x i16> %177, i16 %178, i64 3, !dbg !155
  %acc_s_cast.sroa.0.6.vec.insert2968 = bitcast <4 x i16> %179 to <4 x half>, !dbg !155
  %180 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %153, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2968, <4 x float> %108), !dbg !156
  %181 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %152, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2968, <4 x float> %109), !dbg !156
  %182 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %159, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2968, <4 x float> %110), !dbg !156
  %183 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %158, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2968, <4 x float> %111), !dbg !156
  %cmp270.not4497 = xor i1 %cmp270, true, !dbg !157
  %cmp272.not4498 = xor i1 %cmp272, true, !dbg !157
  %brmerge4499 = or i1 %cmp270.not4497, %cmp272.not4498, !dbg !157
  br i1 %brmerge4499, label %if.end798, label %if.then759, !dbg !157

if.then759:                                       ; preds = %if.end654.1
  %.idx2546 = shl nuw nsw i64 %shr278, 11, !dbg !158
  %184 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2546, !dbg !158
  %.idx2547 = shl nuw nsw i64 %conv, 17, !dbg !158
  %185 = getelementptr inbounds i8, ptr addrspace(4) %184, i64 %.idx2547, !dbg !158
  %186 = load <4 x half>, ptr addrspace(4) %185, align 16, !dbg !159, !tbaa !30
  %condval_7.sroa.6.0.add.ptr774.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %185, i64 8, !dbg !159
  %187 = load <4 x half>, ptr addrspace(4) %condval_7.sroa.6.0.add.ptr774.sroa_idx, align 8, !dbg !159, !tbaa !30
  br label %if.end798, !dbg !160

if.end798:                                        ; preds = %if.end654.1, %if.then759
  %188 = phi <4 x half> [ %187, %if.then759 ], [ zeroinitializer, %if.end654.1 ], !dbg !83
  %189 = phi <4 x half> [ %186, %if.then759 ], [ zeroinitializer, %if.end654.1 ], !dbg !83
  %cmp270.not4500 = xor i1 %cmp270, true, !dbg !157
  %cmp272.not4501 = xor i1 %cmp272, true, !dbg !157
  %brmerge4502 = or i1 %cmp270.not4500, %cmp272.not4501, !dbg !157
  br i1 %brmerge4502, label %if.end798.1, label %if.then759.1, !dbg !157

if.then759.1:                                     ; preds = %if.end798
  %.idx2546.1 = shl nuw nsw i64 %shr278, 11, !dbg !158
  %190 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2546.1, !dbg !158
  %.idx2547.1 = shl nuw nsw i64 %conv, 17, !dbg !158
  %191 = getelementptr inbounds i8, ptr addrspace(4) %190, i64 %.idx2547.1, !dbg !158
  %gep2494.1 = getelementptr inbounds i8, ptr addrspace(4) %191, i64 1024, !dbg !158
  %192 = load <4 x half>, ptr addrspace(4) %gep2494.1, align 16, !dbg !159, !tbaa !30
  %condval_7.sroa.6.0.add.ptr774.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %191, i64 1032, !dbg !159
  %193 = load <4 x half>, ptr addrspace(4) %condval_7.sroa.6.0.add.ptr774.sroa_idx.1, align 8, !dbg !159, !tbaa !30
  br label %if.end798.1, !dbg !160

if.end798.1:                                      ; preds = %if.end798, %if.then759.1
  %194 = phi <4 x half> [ %193, %if.then759.1 ], [ zeroinitializer, %if.end798 ], !dbg !83
  %195 = phi <4 x half> [ %192, %if.then759.1 ], [ zeroinitializer, %if.end798 ], !dbg !83
  %196 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %69, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !161, !call_argsrelate !101
  %197 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %68, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %196), !dbg !161, !call_argsrelate !101
  %198 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %75, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %197), !dbg !161, !call_argsrelate !101
  %199 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %74, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %198), !dbg !161, !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract3121 = extractelement <4 x float> %199, i64 0, !dbg !162
  %mul844 = fmul contract float %acc_s.sroa.0.0.vec.extract3121, 0x3FB99999A0000000, !dbg !163
  %200 = tail call contract noundef float @llvm.minnum.f32(float %mul844, float 0x4024CB5EC0000000), !dbg !164
  %201 = tail call contract noundef float @llvm.exp.f32(float %200), !dbg !166
  %acc_s.sroa.0.4.vec.extract3302 = extractelement <4 x float> %199, i64 1, !dbg !162
  %mul844.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3302, 0x3FB99999A0000000, !dbg !163
  %202 = tail call contract noundef float @llvm.minnum.f32(float %mul844.1, float 0x4024CB5EC0000000), !dbg !164
  %203 = tail call contract noundef float @llvm.exp.f32(float %202), !dbg !166
  %acc_s.sroa.0.8.vec.extract3475 = extractelement <4 x float> %199, i64 2, !dbg !162
  %mul844.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3475, 0x3FB99999A0000000, !dbg !163
  %204 = tail call contract noundef float @llvm.minnum.f32(float %mul844.2, float 0x4024CB5EC0000000), !dbg !164
  %205 = tail call contract noundef float @llvm.exp.f32(float %204), !dbg !166
  %acc_s.sroa.0.12.vec.extract3648 = extractelement <4 x float> %199, i64 3, !dbg !162
  %mul844.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3648, 0x3FB99999A0000000, !dbg !163
  %206 = tail call contract noundef float @llvm.minnum.f32(float %mul844.3, float 0x4024CB5EC0000000), !dbg !164
  %207 = tail call contract noundef float @llvm.exp.f32(float %206), !dbg !166
  %add860 = fadd contract float %add716, %201, !dbg !168
  %add860.1 = fadd contract float %add716.1, %203, !dbg !168
  %add860.2 = fadd contract float %add716.2, %205, !dbg !168
  %add860.3 = fadd contract float %add716.3, %207, !dbg !168
  %208 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %201), !dbg !169
  %209 = insertelement <4 x i16> poison, i16 %208, i64 0, !dbg !173
  %210 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %203), !dbg !169
  %211 = insertelement <4 x i16> %209, i16 %210, i64 1, !dbg !173
  %212 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %205), !dbg !169
  %213 = insertelement <4 x i16> %211, i16 %212, i64 2, !dbg !173
  %214 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %207), !dbg !169
  %215 = insertelement <4 x i16> %213, i16 %214, i64 3, !dbg !173
  %acc_s_cast.sroa.0.6.vec.insert2970 = bitcast <4 x i16> %215 to <4 x half>, !dbg !173
  %216 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %189, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2970, <4 x float> %144), !dbg !174
  %217 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %188, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2970, <4 x float> %145), !dbg !174
  %218 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %195, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2970, <4 x float> %146), !dbg !174
  %219 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %194, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2970, <4 x float> %147), !dbg !174
  %cmp114.1 = icmp sgt i32 %11, -1
  %cmp115.1 = icmp slt i32 %11, 64
  %220 = and i32 %cond.i.i2318.4, 268435455
  %shr120.1 = zext nneg i32 %220 to i64
  %cmp114.1.not = xor i1 %cmp114.1, true, !dbg !79
  %cmp115.1.not = xor i1 %cmp115.1, true, !dbg !79
  %brmerge4503 = or i1 %cmp114.1.not, %cmp115.1.not, !dbg !79
  br i1 %brmerge4503, label %if.end.12680, label %if.then116.12672, !dbg !79

if.then116.12672:                                 ; preds = %if.end798.1
  %.idx.12663 = shl nuw nsw i64 %shr120.1, 11, !dbg !80
  %221 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx.12663, !dbg !80
  %.idx2533.12664 = shl nuw nsw i64 %conv, 17, !dbg !80
  %222 = getelementptr inbounds i8, ptr addrspace(4) %221, i64 %.idx2533.12664, !dbg !80
  %223 = load <4 x half>, ptr addrspace(4) %222, align 16, !dbg !81, !tbaa !30
  %condval.sroa.6.0.add.ptr130.sroa_idx.12668 = getelementptr inbounds i8, ptr addrspace(4) %222, i64 8, !dbg !81
  %224 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr130.sroa_idx.12668, align 8, !dbg !81, !tbaa !30
  br label %if.end.12680, !dbg !82

if.end.12680:                                     ; preds = %if.end798.1, %if.then116.12672
  %225 = phi <4 x half> [ %224, %if.then116.12672 ], [ zeroinitializer, %if.end798.1 ], !dbg !83
  %226 = phi <4 x half> [ %223, %if.then116.12672 ], [ zeroinitializer, %if.end798.1 ], !dbg !83
  %cmp114.1.not4504 = xor i1 %cmp114.1, true, !dbg !79
  %cmp115.1.not4505 = xor i1 %cmp115.1, true, !dbg !79
  %brmerge4506 = or i1 %cmp114.1.not4504, %cmp115.1.not4505, !dbg !79
  br i1 %brmerge4506, label %if.end.1.1, label %if.then116.1.1, !dbg !79

if.then116.1.1:                                   ; preds = %if.end.12680
  %.idx.1.1 = shl nuw nsw i64 %shr120.1, 11, !dbg !80
  %227 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx.1.1, !dbg !80
  %.idx2533.1.1 = shl nuw nsw i64 %conv, 17, !dbg !80
  %228 = getelementptr inbounds i8, ptr addrspace(4) %227, i64 %.idx2533.1.1, !dbg !80
  %gep.1.1 = getelementptr inbounds i8, ptr addrspace(4) %228, i64 1024, !dbg !80
  %229 = load <4 x half>, ptr addrspace(4) %gep.1.1, align 16, !dbg !81, !tbaa !30
  %condval.sroa.6.0.add.ptr130.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %228, i64 1032, !dbg !81
  %230 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr130.sroa_idx.1.1, align 8, !dbg !81, !tbaa !30
  br label %if.end.1.1, !dbg !82

if.end.1.1:                                       ; preds = %if.end.12680, %if.then116.1.1
  %231 = phi <4 x half> [ %230, %if.then116.1.1 ], [ zeroinitializer, %if.end.12680 ], !dbg !83
  %232 = phi <4 x half> [ %229, %if.then116.1.1 ], [ zeroinitializer, %if.end.12680 ], !dbg !83
  %cmp162.1 = icmp sgt i32 %13, -1
  %cmp164.1 = icmp slt i32 %13, 64
  %233 = and i32 %cond.i.i2318.5, 268435455
  %shr170.1 = zext nneg i32 %233 to i64
  %cmp162.1.not = xor i1 %cmp162.1, true, !dbg !84
  %cmp164.1.not = xor i1 %cmp164.1, true, !dbg !84
  %brmerge4507 = or i1 %cmp162.1.not, %cmp164.1.not, !dbg !84
  br i1 %brmerge4507, label %if.end204.12699, label %if.then165.12691, !dbg !84

if.then165.12691:                                 ; preds = %if.end.1.1
  %.idx2534.12682 = shl nuw nsw i64 %shr170.1, 11, !dbg !85
  %234 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2534.12682, !dbg !85
  %.idx2535.12683 = shl nuw nsw i64 %conv, 17, !dbg !85
  %235 = getelementptr inbounds i8, ptr addrspace(4) %234, i64 %.idx2535.12683, !dbg !85
  %236 = load <4 x half>, ptr addrspace(4) %235, align 16, !dbg !86, !tbaa !30
  %condval_1.sroa.6.0.add.ptr180.sroa_idx.12687 = getelementptr inbounds i8, ptr addrspace(4) %235, i64 8, !dbg !86
  %237 = load <4 x half>, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr180.sroa_idx.12687, align 8, !dbg !86, !tbaa !30
  br label %if.end204.12699, !dbg !87

if.end204.12699:                                  ; preds = %if.end.1.1, %if.then165.12691
  %238 = phi <4 x half> [ %237, %if.then165.12691 ], [ zeroinitializer, %if.end.1.1 ], !dbg !83
  %239 = phi <4 x half> [ %236, %if.then165.12691 ], [ zeroinitializer, %if.end.1.1 ], !dbg !83
  %cmp162.1.not4508 = xor i1 %cmp162.1, true, !dbg !84
  %cmp164.1.not4509 = xor i1 %cmp164.1, true, !dbg !84
  %brmerge4510 = or i1 %cmp162.1.not4508, %cmp164.1.not4509, !dbg !84
  br i1 %brmerge4510, label %if.end204.1.1, label %if.then165.1.1, !dbg !84

if.then165.1.1:                                   ; preds = %if.end204.12699
  %.idx2534.1.1 = shl nuw nsw i64 %shr170.1, 11, !dbg !85
  %240 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2534.1.1, !dbg !85
  %.idx2535.1.1 = shl nuw nsw i64 %conv, 17, !dbg !85
  %241 = getelementptr inbounds i8, ptr addrspace(4) %240, i64 %.idx2535.1.1, !dbg !85
  %gep2446.1.1 = getelementptr inbounds i8, ptr addrspace(4) %241, i64 1024, !dbg !85
  %242 = load <4 x half>, ptr addrspace(4) %gep2446.1.1, align 16, !dbg !86, !tbaa !30
  %condval_1.sroa.6.0.add.ptr180.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %241, i64 1032, !dbg !86
  %243 = load <4 x half>, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr180.sroa_idx.1.1, align 8, !dbg !86, !tbaa !30
  br label %if.end204.1.1, !dbg !87

if.end204.1.1:                                    ; preds = %if.end204.12699, %if.then165.1.1
  %244 = phi <4 x half> [ %243, %if.then165.1.1 ], [ zeroinitializer, %if.end204.12699 ], !dbg !83
  %245 = phi <4 x half> [ %242, %if.then165.1.1 ], [ zeroinitializer, %if.end204.12699 ], !dbg !83
  %cmp216.1 = icmp sgt i32 %15, -1
  %cmp218.1 = icmp slt i32 %15, 64
  %246 = and i32 %cond.i.i2318.6, 268435455
  %shr224.1 = zext nneg i32 %246 to i64
  %cmp216.1.not = xor i1 %cmp216.1, true, !dbg !88
  %cmp218.1.not = xor i1 %cmp218.1, true, !dbg !88
  %brmerge4511 = or i1 %cmp216.1.not, %cmp218.1.not, !dbg !88
  br i1 %brmerge4511, label %if.end258.12718, label %if.then219.12710, !dbg !88

if.then219.12710:                                 ; preds = %if.end204.1.1
  %.idx2536.12701 = shl nuw nsw i64 %shr224.1, 11, !dbg !89
  %247 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2536.12701, !dbg !89
  %.idx2537.12702 = shl nuw nsw i64 %conv, 17, !dbg !89
  %248 = getelementptr inbounds i8, ptr addrspace(4) %247, i64 %.idx2537.12702, !dbg !89
  %249 = load <4 x half>, ptr addrspace(4) %248, align 16, !dbg !90, !tbaa !30
  %condval_2.sroa.6.0.add.ptr234.sroa_idx.12706 = getelementptr inbounds i8, ptr addrspace(4) %248, i64 8, !dbg !90
  %250 = load <4 x half>, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr234.sroa_idx.12706, align 8, !dbg !90, !tbaa !30
  br label %if.end258.12718, !dbg !91

if.end258.12718:                                  ; preds = %if.end204.1.1, %if.then219.12710
  %251 = phi <4 x half> [ %250, %if.then219.12710 ], [ zeroinitializer, %if.end204.1.1 ], !dbg !83
  %252 = phi <4 x half> [ %249, %if.then219.12710 ], [ zeroinitializer, %if.end204.1.1 ], !dbg !83
  %cmp216.1.not4512 = xor i1 %cmp216.1, true, !dbg !88
  %cmp218.1.not4513 = xor i1 %cmp218.1, true, !dbg !88
  %brmerge4514 = or i1 %cmp216.1.not4512, %cmp218.1.not4513, !dbg !88
  br i1 %brmerge4514, label %if.end258.1.1, label %if.then219.1.1, !dbg !88

if.then219.1.1:                                   ; preds = %if.end258.12718
  %.idx2536.1.1 = shl nuw nsw i64 %shr224.1, 11, !dbg !89
  %253 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2536.1.1, !dbg !89
  %.idx2537.1.1 = shl nuw nsw i64 %conv, 17, !dbg !89
  %254 = getelementptr inbounds i8, ptr addrspace(4) %253, i64 %.idx2537.1.1, !dbg !89
  %gep2449.1.1 = getelementptr inbounds i8, ptr addrspace(4) %254, i64 1024, !dbg !89
  %255 = load <4 x half>, ptr addrspace(4) %gep2449.1.1, align 16, !dbg !90, !tbaa !30
  %condval_2.sroa.6.0.add.ptr234.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %254, i64 1032, !dbg !90
  %256 = load <4 x half>, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr234.sroa_idx.1.1, align 8, !dbg !90, !tbaa !30
  br label %if.end258.1.1, !dbg !91

if.end258.1.1:                                    ; preds = %if.end258.12718, %if.then219.1.1
  %257 = phi <4 x half> [ %256, %if.then219.1.1 ], [ zeroinitializer, %if.end258.12718 ], !dbg !83
  %258 = phi <4 x half> [ %255, %if.then219.1.1 ], [ zeroinitializer, %if.end258.12718 ], !dbg !83
  %cmp270.1 = icmp sgt i32 %17, -1
  %cmp272.1 = icmp slt i32 %17, 64
  %259 = and i32 %cond.i.i2318.7, 268435455
  %shr278.1 = zext nneg i32 %259 to i64
  %cmp270.1.not = xor i1 %cmp270.1, true, !dbg !92
  %cmp272.1.not = xor i1 %cmp272.1, true, !dbg !92
  %brmerge4515 = or i1 %cmp270.1.not, %cmp272.1.not, !dbg !92
  br i1 %brmerge4515, label %if.end312.12737, label %if.then273.12729, !dbg !92

if.then273.12729:                                 ; preds = %if.end258.1.1
  %.idx2538.12720 = shl nuw nsw i64 %shr278.1, 11, !dbg !93
  %260 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2538.12720, !dbg !93
  %.idx2539.12721 = shl nuw nsw i64 %conv, 17, !dbg !93
  %261 = getelementptr inbounds i8, ptr addrspace(4) %260, i64 %.idx2539.12721, !dbg !93
  %262 = load <4 x half>, ptr addrspace(4) %261, align 16, !dbg !94, !tbaa !30
  %condval_3.sroa.6.0.add.ptr288.sroa_idx.12725 = getelementptr inbounds i8, ptr addrspace(4) %261, i64 8, !dbg !94
  %263 = load <4 x half>, ptr addrspace(4) %condval_3.sroa.6.0.add.ptr288.sroa_idx.12725, align 8, !dbg !94, !tbaa !30
  br label %if.end312.12737, !dbg !95

if.end312.12737:                                  ; preds = %if.end258.1.1, %if.then273.12729
  %264 = phi <4 x half> [ %263, %if.then273.12729 ], [ zeroinitializer, %if.end258.1.1 ], !dbg !83
  %265 = phi <4 x half> [ %262, %if.then273.12729 ], [ zeroinitializer, %if.end258.1.1 ], !dbg !83
  %cmp270.1.not4516 = xor i1 %cmp270.1, true, !dbg !92
  %cmp272.1.not4517 = xor i1 %cmp272.1, true, !dbg !92
  %brmerge4518 = or i1 %cmp270.1.not4516, %cmp272.1.not4517, !dbg !92
  br i1 %brmerge4518, label %if.end312.1.1, label %if.then273.1.1, !dbg !92

if.then273.1.1:                                   ; preds = %if.end312.12737
  %.idx2538.1.1 = shl nuw nsw i64 %shr278.1, 11, !dbg !93
  %266 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep, i64 %.idx2538.1.1, !dbg !93
  %.idx2539.1.1 = shl nuw nsw i64 %conv, 17, !dbg !93
  %267 = getelementptr inbounds i8, ptr addrspace(4) %266, i64 %.idx2539.1.1, !dbg !93
  %gep2452.1.1 = getelementptr inbounds i8, ptr addrspace(4) %267, i64 1024, !dbg !93
  %268 = load <4 x half>, ptr addrspace(4) %gep2452.1.1, align 16, !dbg !94, !tbaa !30
  %condval_3.sroa.6.0.add.ptr288.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %267, i64 1032, !dbg !94
  %269 = load <4 x half>, ptr addrspace(4) %condval_3.sroa.6.0.add.ptr288.sroa_idx.1.1, align 8, !dbg !94, !tbaa !30
  br label %if.end312.1.1, !dbg !95

if.end312.1.1:                                    ; preds = %if.end312.12737, %if.then273.1.1
  %270 = phi <4 x half> [ %269, %if.then273.1.1 ], [ zeroinitializer, %if.end312.12737 ], !dbg !83
  %271 = phi <4 x half> [ %268, %if.then273.1.1 ], [ zeroinitializer, %if.end312.12737 ], !dbg !83
  %cmp114.1.not4519 = xor i1 %cmp114.1, true, !dbg !96
  %cmp115.1.not4520 = xor i1 %cmp115.1, true, !dbg !96
  %brmerge4521 = or i1 %cmp114.1.not4519, %cmp115.1.not4520, !dbg !96
  br i1 %brmerge4521, label %if.end366.12756, label %if.then327.12748, !dbg !96

if.then327.12748:                                 ; preds = %if.end312.1.1
  %.idx2540.12739 = shl nuw nsw i64 %shr120.1, 11, !dbg !97
  %272 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2540.12739, !dbg !97
  %.idx2541.12740 = shl nuw nsw i64 %conv, 17, !dbg !97
  %273 = getelementptr inbounds i8, ptr addrspace(4) %272, i64 %.idx2541.12740, !dbg !97
  %274 = load <4 x half>, ptr addrspace(4) %273, align 16, !dbg !98, !tbaa !30
  %condval_4.sroa.6.0.add.ptr342.sroa_idx.12744 = getelementptr inbounds i8, ptr addrspace(4) %273, i64 8, !dbg !98
  %275 = load <4 x half>, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr342.sroa_idx.12744, align 8, !dbg !98, !tbaa !30
  br label %if.end366.12756, !dbg !99

if.end366.12756:                                  ; preds = %if.end312.1.1, %if.then327.12748
  %276 = phi <4 x half> [ %275, %if.then327.12748 ], [ zeroinitializer, %if.end312.1.1 ], !dbg !83
  %277 = phi <4 x half> [ %274, %if.then327.12748 ], [ zeroinitializer, %if.end312.1.1 ], !dbg !83
  %cmp114.1.not4522 = xor i1 %cmp114.1, true, !dbg !96
  %cmp115.1.not4523 = xor i1 %cmp115.1, true, !dbg !96
  %brmerge4524 = or i1 %cmp114.1.not4522, %cmp115.1.not4523, !dbg !96
  br i1 %brmerge4524, label %if.end366.1.1, label %if.then327.1.1, !dbg !96

if.then327.1.1:                                   ; preds = %if.end366.12756
  %.idx2540.1.1 = shl nuw nsw i64 %shr120.1, 11, !dbg !97
  %278 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2540.1.1, !dbg !97
  %.idx2541.1.1 = shl nuw nsw i64 %conv, 17, !dbg !97
  %279 = getelementptr inbounds i8, ptr addrspace(4) %278, i64 %.idx2541.1.1, !dbg !97
  %gep2455.1.1 = getelementptr inbounds i8, ptr addrspace(4) %279, i64 1024, !dbg !97
  %280 = load <4 x half>, ptr addrspace(4) %gep2455.1.1, align 16, !dbg !98, !tbaa !30
  %condval_4.sroa.6.0.add.ptr342.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %279, i64 1032, !dbg !98
  %281 = load <4 x half>, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr342.sroa_idx.1.1, align 8, !dbg !98, !tbaa !30
  br label %if.end366.1.1, !dbg !99

if.end366.1.1:                                    ; preds = %if.end366.12756, %if.then327.1.1
  %282 = phi <4 x half> [ %281, %if.then327.1.1 ], [ zeroinitializer, %if.end366.12756 ], !dbg !83
  %283 = phi <4 x half> [ %280, %if.then327.1.1 ], [ zeroinitializer, %if.end366.12756 ], !dbg !83
  %284 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %226, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !100, !call_argsrelate !101
  %285 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %225, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %284), !dbg !100, !call_argsrelate !101
  %286 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %232, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %285), !dbg !100, !call_argsrelate !101
  %287 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %231, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %286), !dbg !100, !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract3131 = extractelement <4 x float> %287, i64 0, !dbg !102
  %mul412.12760 = fmul contract float %acc_s.sroa.0.0.vec.extract3131, 0x3FB99999A0000000, !dbg !103
  %288 = tail call contract noundef float @llvm.minnum.f32(float %mul412.12760, float 0x4024CB5EC0000000), !dbg !104
  %289 = tail call contract noundef float @llvm.exp.f32(float %288), !dbg !107
  %acc_s.sroa.0.4.vec.extract3310 = extractelement <4 x float> %287, i64 1, !dbg !102
  %mul412.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3310, 0x3FB99999A0000000, !dbg !103
  %290 = tail call contract noundef float @llvm.minnum.f32(float %mul412.1.1, float 0x4024CB5EC0000000), !dbg !104
  %291 = tail call contract noundef float @llvm.exp.f32(float %290), !dbg !107
  %acc_s.sroa.0.8.vec.extract3483 = extractelement <4 x float> %287, i64 2, !dbg !102
  %mul412.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3483, 0x3FB99999A0000000, !dbg !103
  %292 = tail call contract noundef float @llvm.minnum.f32(float %mul412.2.1, float 0x4024CB5EC0000000), !dbg !104
  %293 = tail call contract noundef float @llvm.exp.f32(float %292), !dbg !107
  %acc_s.sroa.0.12.vec.extract3656 = extractelement <4 x float> %287, i64 3, !dbg !102
  %mul412.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3656, 0x3FB99999A0000000, !dbg !103
  %294 = tail call contract noundef float @llvm.minnum.f32(float %mul412.3.1, float 0x4024CB5EC0000000), !dbg !104
  %295 = tail call contract noundef float @llvm.exp.f32(float %294), !dbg !107
  %add428.12761 = fadd contract float %add860, %289, !dbg !175
  %add428.1.1 = fadd contract float %add860.1, %291, !dbg !175
  %add428.2.1 = fadd contract float %add860.2, %293, !dbg !175
  %add428.3.1 = fadd contract float %add860.3, %295, !dbg !175
  %296 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %289), !dbg !110
  %297 = insertelement <4 x i16> poison, i16 %296, i64 0, !dbg !119
  %298 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %291), !dbg !110
  %299 = insertelement <4 x i16> %297, i16 %298, i64 1, !dbg !119
  %300 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %293), !dbg !110
  %301 = insertelement <4 x i16> %299, i16 %300, i64 2, !dbg !119
  %302 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %295), !dbg !110
  %303 = insertelement <4 x i16> %301, i16 %302, i64 3, !dbg !119
  %acc_s_cast.sroa.0.6.vec.insert2972 = bitcast <4 x i16> %303 to <4 x half>, !dbg !119
  %304 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %277, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2972, <4 x float> %180), !dbg !120
  %305 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %276, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2972, <4 x float> %181), !dbg !120
  %306 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %283, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2972, <4 x float> %182), !dbg !120
  %307 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %282, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2972, <4 x float> %183), !dbg !120
  %cmp162.1.not4525 = xor i1 %cmp162.1, true, !dbg !121
  %cmp164.1.not4526 = xor i1 %cmp164.1, true, !dbg !121
  %brmerge4527 = or i1 %cmp162.1.not4525, %cmp164.1.not4526, !dbg !121
  br i1 %brmerge4527, label %if.end510.12780, label %if.then471.12772, !dbg !121

if.then471.12772:                                 ; preds = %if.end366.1.1
  %.idx2542.12763 = shl nuw nsw i64 %shr170.1, 11, !dbg !122
  %308 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2542.12763, !dbg !122
  %.idx2543.12764 = shl nuw nsw i64 %conv, 17, !dbg !122
  %309 = getelementptr inbounds i8, ptr addrspace(4) %308, i64 %.idx2543.12764, !dbg !122
  %310 = load <4 x half>, ptr addrspace(4) %309, align 16, !dbg !123, !tbaa !30
  %condval_5.sroa.6.0.add.ptr486.sroa_idx.12768 = getelementptr inbounds i8, ptr addrspace(4) %309, i64 8, !dbg !123
  %311 = load <4 x half>, ptr addrspace(4) %condval_5.sroa.6.0.add.ptr486.sroa_idx.12768, align 8, !dbg !123, !tbaa !30
  br label %if.end510.12780, !dbg !124

if.end510.12780:                                  ; preds = %if.end366.1.1, %if.then471.12772
  %312 = phi <4 x half> [ %311, %if.then471.12772 ], [ zeroinitializer, %if.end366.1.1 ], !dbg !83
  %313 = phi <4 x half> [ %310, %if.then471.12772 ], [ zeroinitializer, %if.end366.1.1 ], !dbg !83
  %cmp162.1.not4528 = xor i1 %cmp162.1, true, !dbg !121
  %cmp164.1.not4529 = xor i1 %cmp164.1, true, !dbg !121
  %brmerge4530 = or i1 %cmp162.1.not4528, %cmp164.1.not4529, !dbg !121
  br i1 %brmerge4530, label %if.end510.1.1, label %if.then471.1.1, !dbg !121

if.then471.1.1:                                   ; preds = %if.end510.12780
  %.idx2542.1.1 = shl nuw nsw i64 %shr170.1, 11, !dbg !122
  %314 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2542.1.1, !dbg !122
  %.idx2543.1.1 = shl nuw nsw i64 %conv, 17, !dbg !122
  %315 = getelementptr inbounds i8, ptr addrspace(4) %314, i64 %.idx2543.1.1, !dbg !122
  %gep2468.1.1 = getelementptr inbounds i8, ptr addrspace(4) %315, i64 1024, !dbg !122
  %316 = load <4 x half>, ptr addrspace(4) %gep2468.1.1, align 16, !dbg !123, !tbaa !30
  %condval_5.sroa.6.0.add.ptr486.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %315, i64 1032, !dbg !123
  %317 = load <4 x half>, ptr addrspace(4) %condval_5.sroa.6.0.add.ptr486.sroa_idx.1.1, align 8, !dbg !123, !tbaa !30
  br label %if.end510.1.1, !dbg !124

if.end510.1.1:                                    ; preds = %if.end510.12780, %if.then471.1.1
  %318 = phi <4 x half> [ %317, %if.then471.1.1 ], [ zeroinitializer, %if.end510.12780 ], !dbg !83
  %319 = phi <4 x half> [ %316, %if.then471.1.1 ], [ zeroinitializer, %if.end510.12780 ], !dbg !83
  %320 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %239, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !125, !call_argsrelate !101
  %321 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %238, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %320), !dbg !125, !call_argsrelate !101
  %322 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %245, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %321), !dbg !125, !call_argsrelate !101
  %323 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %244, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %322), !dbg !125, !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract3141 = extractelement <4 x float> %323, i64 0, !dbg !126
  %mul556.12784 = fmul contract float %acc_s.sroa.0.0.vec.extract3141, 0x3FB99999A0000000, !dbg !127
  %324 = tail call contract noundef float @llvm.minnum.f32(float %mul556.12784, float 0x4024CB5EC0000000), !dbg !128
  %325 = tail call contract noundef float @llvm.exp.f32(float %324), !dbg !130
  %acc_s.sroa.0.4.vec.extract3318 = extractelement <4 x float> %323, i64 1, !dbg !126
  %mul556.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3318, 0x3FB99999A0000000, !dbg !127
  %326 = tail call contract noundef float @llvm.minnum.f32(float %mul556.1.1, float 0x4024CB5EC0000000), !dbg !128
  %327 = tail call contract noundef float @llvm.exp.f32(float %326), !dbg !130
  %acc_s.sroa.0.8.vec.extract3491 = extractelement <4 x float> %323, i64 2, !dbg !126
  %mul556.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3491, 0x3FB99999A0000000, !dbg !127
  %328 = tail call contract noundef float @llvm.minnum.f32(float %mul556.2.1, float 0x4024CB5EC0000000), !dbg !128
  %329 = tail call contract noundef float @llvm.exp.f32(float %328), !dbg !130
  %acc_s.sroa.0.12.vec.extract3664 = extractelement <4 x float> %323, i64 3, !dbg !126
  %mul556.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3664, 0x3FB99999A0000000, !dbg !127
  %330 = tail call contract noundef float @llvm.minnum.f32(float %mul556.3.1, float 0x4024CB5EC0000000), !dbg !128
  %331 = tail call contract noundef float @llvm.exp.f32(float %330), !dbg !130
  %add572.12785 = fadd contract float %add428.12761, %325, !dbg !132
  %add572.1.1 = fadd contract float %add428.1.1, %327, !dbg !132
  %add572.2.1 = fadd contract float %add428.2.1, %329, !dbg !132
  %add572.3.1 = fadd contract float %add428.3.1, %331, !dbg !132
  %332 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %325), !dbg !133
  %333 = insertelement <4 x i16> poison, i16 %332, i64 0, !dbg !137
  %334 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %327), !dbg !133
  %335 = insertelement <4 x i16> %333, i16 %334, i64 1, !dbg !137
  %336 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %329), !dbg !133
  %337 = insertelement <4 x i16> %335, i16 %336, i64 2, !dbg !137
  %338 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %331), !dbg !133
  %339 = insertelement <4 x i16> %337, i16 %338, i64 3, !dbg !137
  %acc_s_cast.sroa.0.6.vec.insert2974 = bitcast <4 x i16> %339 to <4 x half>, !dbg !137
  %340 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %313, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2974, <4 x float> %216), !dbg !138
  %341 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %312, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2974, <4 x float> %217), !dbg !138
  %342 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %319, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2974, <4 x float> %218), !dbg !138
  %343 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %318, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2974, <4 x float> %219), !dbg !138
  %cmp216.1.not4531 = xor i1 %cmp216.1, true, !dbg !139
  %cmp218.1.not4532 = xor i1 %cmp218.1, true, !dbg !139
  %brmerge4533 = or i1 %cmp216.1.not4531, %cmp218.1.not4532, !dbg !139
  br i1 %brmerge4533, label %if.end654.12804, label %if.then615.12796, !dbg !139

if.then615.12796:                                 ; preds = %if.end510.1.1
  %.idx2544.12787 = shl nuw nsw i64 %shr224.1, 11, !dbg !140
  %344 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2544.12787, !dbg !140
  %.idx2545.12788 = shl nuw nsw i64 %conv, 17, !dbg !140
  %345 = getelementptr inbounds i8, ptr addrspace(4) %344, i64 %.idx2545.12788, !dbg !140
  %346 = load <4 x half>, ptr addrspace(4) %345, align 16, !dbg !141, !tbaa !30
  %condval_6.sroa.6.0.add.ptr630.sroa_idx.12792 = getelementptr inbounds i8, ptr addrspace(4) %345, i64 8, !dbg !141
  %347 = load <4 x half>, ptr addrspace(4) %condval_6.sroa.6.0.add.ptr630.sroa_idx.12792, align 8, !dbg !141, !tbaa !30
  br label %if.end654.12804, !dbg !142

if.end654.12804:                                  ; preds = %if.end510.1.1, %if.then615.12796
  %348 = phi <4 x half> [ %347, %if.then615.12796 ], [ zeroinitializer, %if.end510.1.1 ], !dbg !83
  %349 = phi <4 x half> [ %346, %if.then615.12796 ], [ zeroinitializer, %if.end510.1.1 ], !dbg !83
  %cmp216.1.not4534 = xor i1 %cmp216.1, true, !dbg !139
  %cmp218.1.not4535 = xor i1 %cmp218.1, true, !dbg !139
  %brmerge4536 = or i1 %cmp216.1.not4534, %cmp218.1.not4535, !dbg !139
  br i1 %brmerge4536, label %if.end654.1.1, label %if.then615.1.1, !dbg !139

if.then615.1.1:                                   ; preds = %if.end654.12804
  %.idx2544.1.1 = shl nuw nsw i64 %shr224.1, 11, !dbg !140
  %350 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2544.1.1, !dbg !140
  %.idx2545.1.1 = shl nuw nsw i64 %conv, 17, !dbg !140
  %351 = getelementptr inbounds i8, ptr addrspace(4) %350, i64 %.idx2545.1.1, !dbg !140
  %gep2481.1.1 = getelementptr inbounds i8, ptr addrspace(4) %351, i64 1024, !dbg !140
  %352 = load <4 x half>, ptr addrspace(4) %gep2481.1.1, align 16, !dbg !141, !tbaa !30
  %condval_6.sroa.6.0.add.ptr630.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %351, i64 1032, !dbg !141
  %353 = load <4 x half>, ptr addrspace(4) %condval_6.sroa.6.0.add.ptr630.sroa_idx.1.1, align 8, !dbg !141, !tbaa !30
  br label %if.end654.1.1, !dbg !142

if.end654.1.1:                                    ; preds = %if.end654.12804, %if.then615.1.1
  %354 = phi <4 x half> [ %353, %if.then615.1.1 ], [ zeroinitializer, %if.end654.12804 ], !dbg !83
  %355 = phi <4 x half> [ %352, %if.then615.1.1 ], [ zeroinitializer, %if.end654.12804 ], !dbg !83
  %356 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %252, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !143, !call_argsrelate !101
  %357 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %251, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %356), !dbg !143, !call_argsrelate !101
  %358 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %258, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %357), !dbg !143, !call_argsrelate !101
  %359 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %257, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %358), !dbg !143, !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract3151 = extractelement <4 x float> %359, i64 0, !dbg !144
  %mul700.12808 = fmul contract float %acc_s.sroa.0.0.vec.extract3151, 0x3FB99999A0000000, !dbg !145
  %360 = tail call contract noundef float @llvm.minnum.f32(float %mul700.12808, float 0x4024CB5EC0000000), !dbg !146
  %361 = tail call contract noundef float @llvm.exp.f32(float %360), !dbg !148
  %acc_s.sroa.0.4.vec.extract3326 = extractelement <4 x float> %359, i64 1, !dbg !144
  %mul700.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3326, 0x3FB99999A0000000, !dbg !145
  %362 = tail call contract noundef float @llvm.minnum.f32(float %mul700.1.1, float 0x4024CB5EC0000000), !dbg !146
  %363 = tail call contract noundef float @llvm.exp.f32(float %362), !dbg !148
  %acc_s.sroa.0.8.vec.extract3499 = extractelement <4 x float> %359, i64 2, !dbg !144
  %mul700.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3499, 0x3FB99999A0000000, !dbg !145
  %364 = tail call contract noundef float @llvm.minnum.f32(float %mul700.2.1, float 0x4024CB5EC0000000), !dbg !146
  %365 = tail call contract noundef float @llvm.exp.f32(float %364), !dbg !148
  %acc_s.sroa.0.12.vec.extract3672 = extractelement <4 x float> %359, i64 3, !dbg !144
  %mul700.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3672, 0x3FB99999A0000000, !dbg !145
  %366 = tail call contract noundef float @llvm.minnum.f32(float %mul700.3.1, float 0x4024CB5EC0000000), !dbg !146
  %367 = tail call contract noundef float @llvm.exp.f32(float %366), !dbg !148
  %add716.12809 = fadd contract float %add572.12785, %361, !dbg !150
  %add716.1.1 = fadd contract float %add572.1.1, %363, !dbg !150
  %add716.2.1 = fadd contract float %add572.2.1, %365, !dbg !150
  %add716.3.1 = fadd contract float %add572.3.1, %367, !dbg !150
  %368 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %361), !dbg !151
  %369 = insertelement <4 x i16> poison, i16 %368, i64 0, !dbg !155
  %370 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %363), !dbg !151
  %371 = insertelement <4 x i16> %369, i16 %370, i64 1, !dbg !155
  %372 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %365), !dbg !151
  %373 = insertelement <4 x i16> %371, i16 %372, i64 2, !dbg !155
  %374 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %367), !dbg !151
  %375 = insertelement <4 x i16> %373, i16 %374, i64 3, !dbg !155
  %acc_s_cast.sroa.0.6.vec.insert2976 = bitcast <4 x i16> %375 to <4 x half>, !dbg !155
  %376 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %349, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2976, <4 x float> %304), !dbg !156
  %377 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %348, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2976, <4 x float> %305), !dbg !156
  %378 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %355, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2976, <4 x float> %306), !dbg !156
  %379 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %354, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2976, <4 x float> %307), !dbg !156
  %cmp270.1.not4537 = xor i1 %cmp270.1, true, !dbg !157
  %cmp272.1.not4538 = xor i1 %cmp272.1, true, !dbg !157
  %brmerge4539 = or i1 %cmp270.1.not4537, %cmp272.1.not4538, !dbg !157
  br i1 %brmerge4539, label %if.end798.12828, label %if.then759.12820, !dbg !157

if.then759.12820:                                 ; preds = %if.end654.1.1
  %.idx2546.12811 = shl nuw nsw i64 %shr278.1, 11, !dbg !158
  %380 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2546.12811, !dbg !158
  %.idx2547.12812 = shl nuw nsw i64 %conv, 17, !dbg !158
  %381 = getelementptr inbounds i8, ptr addrspace(4) %380, i64 %.idx2547.12812, !dbg !158
  %382 = load <4 x half>, ptr addrspace(4) %381, align 16, !dbg !159, !tbaa !30
  %condval_7.sroa.6.0.add.ptr774.sroa_idx.12816 = getelementptr inbounds i8, ptr addrspace(4) %381, i64 8, !dbg !159
  %383 = load <4 x half>, ptr addrspace(4) %condval_7.sroa.6.0.add.ptr774.sroa_idx.12816, align 8, !dbg !159, !tbaa !30
  br label %if.end798.12828, !dbg !160

if.end798.12828:                                  ; preds = %if.end654.1.1, %if.then759.12820
  %384 = phi <4 x half> [ %383, %if.then759.12820 ], [ zeroinitializer, %if.end654.1.1 ], !dbg !83
  %385 = phi <4 x half> [ %382, %if.then759.12820 ], [ zeroinitializer, %if.end654.1.1 ], !dbg !83
  %cmp270.1.not4540 = xor i1 %cmp270.1, true, !dbg !157
  %cmp272.1.not4541 = xor i1 %cmp272.1, true, !dbg !157
  %brmerge4542 = or i1 %cmp270.1.not4540, %cmp272.1.not4541, !dbg !157
  br i1 %brmerge4542, label %if.end798.1.1, label %if.then759.1.1, !dbg !157

if.then759.1.1:                                   ; preds = %if.end798.12828
  %.idx2546.1.1 = shl nuw nsw i64 %shr278.1, 11, !dbg !158
  %386 = getelementptr inbounds i8, ptr addrspace(4) %invariant.gep2454, i64 %.idx2546.1.1, !dbg !158
  %.idx2547.1.1 = shl nuw nsw i64 %conv, 17, !dbg !158
  %387 = getelementptr inbounds i8, ptr addrspace(4) %386, i64 %.idx2547.1.1, !dbg !158
  %gep2494.1.1 = getelementptr inbounds i8, ptr addrspace(4) %387, i64 1024, !dbg !158
  %388 = load <4 x half>, ptr addrspace(4) %gep2494.1.1, align 16, !dbg !159, !tbaa !30
  %condval_7.sroa.6.0.add.ptr774.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %387, i64 1032, !dbg !159
  %389 = load <4 x half>, ptr addrspace(4) %condval_7.sroa.6.0.add.ptr774.sroa_idx.1.1, align 8, !dbg !159, !tbaa !30
  br label %if.end798.1.1, !dbg !160

if.end798.1.1:                                    ; preds = %if.end798.12828, %if.then759.1.1
  %390 = phi <4 x half> [ %389, %if.then759.1.1 ], [ zeroinitializer, %if.end798.12828 ], !dbg !83
  %391 = phi <4 x half> [ %388, %if.then759.1.1 ], [ zeroinitializer, %if.end798.12828 ], !dbg !83
  %392 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %265, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !161, !call_argsrelate !101
  %393 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %264, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %392), !dbg !161, !call_argsrelate !101
  %394 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %271, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %393), !dbg !161, !call_argsrelate !101
  %395 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %270, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %394), !dbg !161, !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract3161 = extractelement <4 x float> %395, i64 0, !dbg !162
  %mul844.12832 = fmul contract float %acc_s.sroa.0.0.vec.extract3161, 0x3FB99999A0000000, !dbg !163
  %396 = tail call contract noundef float @llvm.minnum.f32(float %mul844.12832, float 0x4024CB5EC0000000), !dbg !164
  %397 = tail call contract noundef float @llvm.exp.f32(float %396), !dbg !166
  %acc_s.sroa.0.4.vec.extract3334 = extractelement <4 x float> %395, i64 1, !dbg !162
  %mul844.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3334, 0x3FB99999A0000000, !dbg !163
  %398 = tail call contract noundef float @llvm.minnum.f32(float %mul844.1.1, float 0x4024CB5EC0000000), !dbg !164
  %399 = tail call contract noundef float @llvm.exp.f32(float %398), !dbg !166
  %acc_s.sroa.0.8.vec.extract3507 = extractelement <4 x float> %395, i64 2, !dbg !162
  %mul844.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3507, 0x3FB99999A0000000, !dbg !163
  %400 = tail call contract noundef float @llvm.minnum.f32(float %mul844.2.1, float 0x4024CB5EC0000000), !dbg !164
  %401 = tail call contract noundef float @llvm.exp.f32(float %400), !dbg !166
  %acc_s.sroa.0.12.vec.extract3680 = extractelement <4 x float> %395, i64 3, !dbg !162
  %mul844.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3680, 0x3FB99999A0000000, !dbg !163
  %402 = tail call contract noundef float @llvm.minnum.f32(float %mul844.3.1, float 0x4024CB5EC0000000), !dbg !164
  %403 = tail call contract noundef float @llvm.exp.f32(float %402), !dbg !166
  %add860.12833 = fadd contract float %add716.12809, %397, !dbg !168
  %add860.1.1 = fadd contract float %add716.1.1, %399, !dbg !168
  %add860.2.1 = fadd contract float %add716.2.1, %401, !dbg !168
  %add860.3.1 = fadd contract float %add716.3.1, %403, !dbg !168
  %404 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %397), !dbg !169
  %405 = insertelement <4 x i16> poison, i16 %404, i64 0, !dbg !173
  %406 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %399), !dbg !169
  %407 = insertelement <4 x i16> %405, i16 %406, i64 1, !dbg !173
  %408 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %401), !dbg !169
  %409 = insertelement <4 x i16> %407, i16 %408, i64 2, !dbg !173
  %410 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %403), !dbg !169
  %411 = insertelement <4 x i16> %409, i16 %410, i64 3, !dbg !173
  %acc_s_cast.sroa.0.6.vec.insert2978 = bitcast <4 x i16> %411 to <4 x half>, !dbg !173
  %412 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %385, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2978, <4 x float> %340), !dbg !174
  %413 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %384, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2978, <4 x float> %341), !dbg !174
  %414 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %391, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2978, <4 x float> %342), !dbg !174
  %415 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %390, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2978, <4 x float> %343), !dbg !174
  %.pre = lshr i32 %18, 2
  br label %if.end1630, !dbg !176

for.cond926.preheader:                            ; preds = %for.cond900.preheader
  %416 = shl nsw i32 %cond.i.i2318, 10
  %mul933 = and i32 %416, 64512
  %add936 = add nuw nsw i32 %add934, %mul933
  %417 = zext nneg i32 %add936 to i64, !dbg !177
  %add.ptr941 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %417, !dbg !178
  %K_reg.sroa.0.0.copyload4421 = load <4 x half>, ptr addrspace(4) %add.ptr941, align 16, !dbg !179
  %K_reg.sroa.12.0.add.ptr941.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr941, i64 8, !dbg !179
  %K_reg.sroa.12.0.copyload4423 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.12.0.add.ptr941.sroa_idx, align 8, !dbg !179
  %418 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %417, !dbg !178
  %add.ptr941.1 = getelementptr inbounds i8, ptr addrspace(4) %418, i64 1024, !dbg !178
  %K_reg.sroa.20.16.copyload4425 = load <4 x half>, ptr addrspace(4) %add.ptr941.1, align 16, !dbg !179
  %K_reg.sroa.30.16.add.ptr941.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %418, i64 1032, !dbg !179
  %K_reg.sroa.30.16.copyload4427 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.30.16.add.ptr941.1.sroa_idx, align 8, !dbg !179
  br label %if.end949, !dbg !180

if.end949:                                        ; preds = %for.cond926.preheader, %for.cond900.preheader
  %419 = phi <4 x half> [ undef, %for.cond900.preheader ], [ %K_reg.sroa.30.16.copyload4427, %for.cond926.preheader ]
  %420 = phi <4 x half> [ undef, %for.cond900.preheader ], [ %K_reg.sroa.20.16.copyload4425, %for.cond926.preheader ]
  %421 = phi <4 x half> [ undef, %for.cond900.preheader ], [ %K_reg.sroa.12.0.copyload4423, %for.cond926.preheader ]
  %422 = phi <4 x half> [ undef, %for.cond900.preheader ], [ %K_reg.sroa.0.0.copyload4421, %for.cond926.preheader ]
  %or.cond2519 = icmp ugt i32 %mul11.1, 1023, !dbg !180
  %cmp955.not = icmp sgt i32 %mul11.1, %1
  %or.cond2520 = or i1 %or.cond2519, %cmp955.not, !dbg !180
  br i1 %or.cond2520, label %if.end980, label %for.cond957.preheader, !dbg !180

for.cond957.preheader:                            ; preds = %if.end949
  %423 = shl nsw i32 %cond.i.i2318.1, 10
  %mul964 = and i32 %423, 64512
  %add967 = add nuw nsw i32 %add934, %mul964
  %424 = zext nneg i32 %add967 to i64, !dbg !181
  %add.ptr972 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %424, !dbg !182
  %K_reg1.sroa.0.0.copyload4433 = load <4 x half>, ptr addrspace(4) %add.ptr972, align 16, !dbg !183
  %K_reg1.sroa.12.0.add.ptr972.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr972, i64 8, !dbg !183
  %K_reg1.sroa.12.0.copyload4435 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.12.0.add.ptr972.sroa_idx, align 8, !dbg !183
  %425 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %424, !dbg !182
  %add.ptr972.1 = getelementptr inbounds i8, ptr addrspace(4) %425, i64 1024, !dbg !182
  %K_reg1.sroa.20.16.copyload4437 = load <4 x half>, ptr addrspace(4) %add.ptr972.1, align 16, !dbg !183
  %K_reg1.sroa.30.16.add.ptr972.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %425, i64 1032, !dbg !183
  %K_reg1.sroa.30.16.copyload4439 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.30.16.add.ptr972.1.sroa_idx, align 8, !dbg !183
  br label %if.end980, !dbg !184

if.end980:                                        ; preds = %for.cond957.preheader, %if.end949
  %426 = phi <4 x half> [ undef, %if.end949 ], [ %K_reg1.sroa.30.16.copyload4439, %for.cond957.preheader ]
  %427 = phi <4 x half> [ undef, %if.end949 ], [ %K_reg1.sroa.20.16.copyload4437, %for.cond957.preheader ]
  %428 = phi <4 x half> [ undef, %if.end949 ], [ %K_reg1.sroa.12.0.copyload4435, %for.cond957.preheader ]
  %429 = phi <4 x half> [ undef, %if.end949 ], [ %K_reg1.sroa.0.0.copyload4433, %for.cond957.preheader ]
  %or.cond2521 = icmp ugt i32 %mul11.2, 1023, !dbg !184
  %cmp986.not = icmp sgt i32 %mul11.2, %1
  %or.cond2522 = or i1 %or.cond2521, %cmp986.not, !dbg !184
  br i1 %or.cond2522, label %if.end1011, label %for.cond988.preheader, !dbg !184

for.cond988.preheader:                            ; preds = %if.end980
  %430 = shl nsw i32 %cond.i.i2318.2, 10
  %mul995 = and i32 %430, 64512
  %add998 = add nuw nsw i32 %add934, %mul995
  %431 = zext nneg i32 %add998 to i64, !dbg !185
  %add.ptr1003 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %431, !dbg !186
  %K_reg2.sroa.0.0.copyload4445 = load <4 x half>, ptr addrspace(4) %add.ptr1003, align 16, !dbg !187
  %K_reg2.sroa.12.0.add.ptr1003.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1003, i64 8, !dbg !187
  %K_reg2.sroa.12.0.copyload4447 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.12.0.add.ptr1003.sroa_idx, align 8, !dbg !187
  %432 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %431, !dbg !186
  %add.ptr1003.1 = getelementptr inbounds i8, ptr addrspace(4) %432, i64 1024, !dbg !186
  %K_reg2.sroa.20.16.copyload4449 = load <4 x half>, ptr addrspace(4) %add.ptr1003.1, align 16, !dbg !187
  %K_reg2.sroa.30.16.add.ptr1003.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %432, i64 1032, !dbg !187
  %K_reg2.sroa.30.16.copyload4451 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.30.16.add.ptr1003.1.sroa_idx, align 8, !dbg !187
  br label %if.end1011, !dbg !188

if.end1011:                                       ; preds = %for.cond988.preheader, %if.end980
  %433 = phi <4 x half> [ undef, %if.end980 ], [ %K_reg2.sroa.30.16.copyload4451, %for.cond988.preheader ]
  %434 = phi <4 x half> [ undef, %if.end980 ], [ %K_reg2.sroa.20.16.copyload4449, %for.cond988.preheader ]
  %435 = phi <4 x half> [ undef, %if.end980 ], [ %K_reg2.sroa.12.0.copyload4447, %for.cond988.preheader ]
  %436 = phi <4 x half> [ undef, %if.end980 ], [ %K_reg2.sroa.0.0.copyload4445, %for.cond988.preheader ]
  %or.cond2523 = icmp ugt i32 %mul11.3, 1023, !dbg !188
  %cmp1017.not = icmp sgt i32 %mul11.3, %1
  %or.cond2524 = or i1 %or.cond2523, %cmp1017.not, !dbg !188
  br i1 %or.cond2524, label %if.end1042, label %for.cond1019.preheader, !dbg !188

for.cond1019.preheader:                           ; preds = %if.end1011
  %437 = shl nsw i32 %cond.i.i2318.3, 10
  %mul1026 = and i32 %437, 64512
  %add1029 = add nuw nsw i32 %add934, %mul1026
  %438 = zext nneg i32 %add1029 to i64, !dbg !189
  %add.ptr1034 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %438, !dbg !190
  %K_reg3.sroa.0.0.copyload4457 = load <4 x half>, ptr addrspace(4) %add.ptr1034, align 16, !dbg !191
  %K_reg3.sroa.12.0.add.ptr1034.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1034, i64 8, !dbg !191
  %K_reg3.sroa.12.0.copyload4459 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.12.0.add.ptr1034.sroa_idx, align 8, !dbg !191
  %439 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %438, !dbg !190
  %add.ptr1034.1 = getelementptr inbounds i8, ptr addrspace(4) %439, i64 1024, !dbg !190
  %K_reg3.sroa.20.16.copyload4461 = load <4 x half>, ptr addrspace(4) %add.ptr1034.1, align 16, !dbg !191
  %K_reg3.sroa.30.16.add.ptr1034.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %439, i64 1032, !dbg !191
  %K_reg3.sroa.30.16.copyload4463 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.30.16.add.ptr1034.1.sroa_idx, align 8, !dbg !191
  br label %if.end1042, !dbg !192

if.end1042:                                       ; preds = %for.cond1019.preheader, %if.end1011
  %440 = phi <4 x half> [ undef, %if.end1011 ], [ %K_reg3.sroa.30.16.copyload4463, %for.cond1019.preheader ]
  %441 = phi <4 x half> [ undef, %if.end1011 ], [ %K_reg3.sroa.20.16.copyload4461, %for.cond1019.preheader ]
  %442 = phi <4 x half> [ undef, %if.end1011 ], [ %K_reg3.sroa.12.0.copyload4459, %for.cond1019.preheader ]
  %443 = phi <4 x half> [ undef, %if.end1011 ], [ %K_reg3.sroa.0.0.copyload4457, %for.cond1019.preheader ]
  br i1 %or.cond2518, label %if.end1188, label %for.cond1050.preheader, !dbg !192

for.cond1050.preheader:                           ; preds = %if.end1042
  %444 = shl nsw i32 %cond.i.i2318, 10
  %mul1057 = and i32 %444, 64512
  %add1060 = add nuw nsw i32 %add934, %mul1057
  %445 = zext nneg i32 %add1060 to i64, !dbg !193
  %add.ptr1065 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %445, !dbg !194
  %V_reg.sroa.0.0.copyload4400 = load <4 x half>, ptr addrspace(4) %add.ptr1065, align 16, !dbg !195
  %V_reg.sroa.42.0.add.ptr1065.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1065, i64 8, !dbg !195
  %V_reg.sroa.42.0.copyload4401 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1065.sroa_idx, align 8, !dbg !195
  %446 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %445, !dbg !194
  %add.ptr1065.1 = getelementptr inbounds i8, ptr addrspace(4) %446, i64 1024, !dbg !194
  %V_reg.sroa.74.16.copyload4402 = load <4 x half>, ptr addrspace(4) %add.ptr1065.1, align 16, !dbg !195
  %V_reg.sroa.114.16.add.ptr1065.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %446, i64 1032, !dbg !195
  %V_reg.sroa.114.16.copyload4403 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1065.1.sroa_idx, align 8, !dbg !195
  %cmp1075 = icmp sgt i32 %mul11, %invariant.op, !dbg !196
  br i1 %cmp1075, label %for.cond1077.preheader, label %if.end1101, !dbg !197

for.cond1077.preheader:                           ; preds = %for.cond1050.preheader
  %add1084 = add nuw nsw i32 %mul11, %mul1083
  %cmp1087.not = icmp sgt i32 %add1084, %1, !dbg !198
  %fneg. = select i1 %cmp1087.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3010 = insertelement <4 x float> poison, float %fneg., i64 0, !dbg !199
  %cmp1087.not.1.not = icmp slt i32 %add1084, %1, !dbg !198
  %fneg..1 = select i1 %cmp1087.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3199 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3010, float %fneg..1, i64 1, !dbg !199
  %add1085.2 = or disjoint i32 %add1084, 2, !dbg !200
  %cmp1087.not.2 = icmp sgt i32 %add1085.2, %1, !dbg !198
  %fneg..2 = select i1 %cmp1087.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3372 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3199, float %fneg..2, i64 2, !dbg !199
  %add1085.3 = or disjoint i32 %add1084, 3, !dbg !200
  %cmp1087.not.3 = icmp sgt i32 %add1085.3, %1, !dbg !198
  %fneg..3 = select i1 %cmp1087.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3545 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3372, float %fneg..3, i64 3, !dbg !199
  br label %if.end1101

if.end1101:                                       ; preds = %for.cond1050.preheader, %for.cond1077.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3545, %for.cond1077.preheader ], [ zeroinitializer, %for.cond1050.preheader ], !dbg !83
  %447 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %422, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !dbg !201, !call_argsrelate !101
  %448 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %421, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %447), !dbg !201, !call_argsrelate !101
  %449 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %420, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %448), !dbg !201, !call_argsrelate !101
  %450 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %419, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %449), !dbg !201, !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %450, i64 0, !dbg !202
  %mul1136 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !203
  %451 = tail call contract noundef float @llvm.minnum.f32(float %mul1136, float 0x4024CB5EC0000000), !dbg !204
  %452 = tail call contract noundef float @llvm.exp.f32(float %451), !dbg !206
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %450, i64 1, !dbg !202
  %mul1136.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !203
  %453 = tail call contract noundef float @llvm.minnum.f32(float %mul1136.1, float 0x4024CB5EC0000000), !dbg !204
  %454 = tail call contract noundef float @llvm.exp.f32(float %453), !dbg !206
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %450, i64 2, !dbg !202
  %mul1136.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !203
  %455 = tail call contract noundef float @llvm.minnum.f32(float %mul1136.2, float 0x4024CB5EC0000000), !dbg !204
  %456 = tail call contract noundef float @llvm.exp.f32(float %455), !dbg !206
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %450, i64 3, !dbg !202
  %mul1136.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !203
  %457 = tail call contract noundef float @llvm.minnum.f32(float %mul1136.3, float 0x4024CB5EC0000000), !dbg !204
  %458 = tail call contract noundef float @llvm.exp.f32(float %457), !dbg !206
  %459 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %452), !dbg !208
  %460 = insertelement <4 x i16> poison, i16 %459, i64 0, !dbg !212
  %461 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %454), !dbg !208
  %462 = insertelement <4 x i16> %460, i16 %461, i64 1, !dbg !212
  %463 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %456), !dbg !208
  %464 = insertelement <4 x i16> %462, i16 %463, i64 2, !dbg !212
  %465 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %458), !dbg !208
  %466 = insertelement <4 x i16> %464, i16 %465, i64 3, !dbg !212
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %466 to <4 x half>, !dbg !212
  %467 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload4400, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !213, !call_argsrelate !214
  %468 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload4401, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !213, !call_argsrelate !214
  %469 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload4402, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !213, !call_argsrelate !214
  %470 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload4403, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !213, !call_argsrelate !214
  br label %if.end1188, !dbg !215

if.end1188:                                       ; preds = %if.end1101, %if.end1042
  %acc_o.sroa.122.0 = phi <4 x float> [ zeroinitializer, %if.end1042 ], [ %470, %if.end1101 ], !dbg !83
  %acc_o.sroa.82.0 = phi <4 x float> [ zeroinitializer, %if.end1042 ], [ %469, %if.end1101 ], !dbg !83
  %acc_o.sroa.42.0 = phi <4 x float> [ zeroinitializer, %if.end1042 ], [ %468, %if.end1101 ], !dbg !83
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1042 ], [ %467, %if.end1101 ], !dbg !83
  %sum_acc.sroa.104.0 = phi float [ 0.000000e+00, %if.end1042 ], [ %458, %if.end1101 ], !dbg !83
  %sum_acc.sroa.70.0 = phi float [ 0.000000e+00, %if.end1042 ], [ %456, %if.end1101 ], !dbg !83
  %sum_acc.sroa.36.0 = phi float [ 0.000000e+00, %if.end1042 ], [ %454, %if.end1101 ], !dbg !83
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %if.end1042 ], [ %452, %if.end1101 ], !dbg !83
  br i1 %or.cond2520, label %if.end1334, label %for.cond1196.preheader, !dbg !215

for.cond1196.preheader:                           ; preds = %if.end1188
  %471 = shl nsw i32 %cond.i.i2318.1, 10
  %mul1203 = and i32 %471, 64512
  %add1206 = add nuw nsw i32 %add934, %mul1203
  %472 = zext nneg i32 %add1206 to i64, !dbg !216
  %add.ptr1211 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %472, !dbg !217
  %V_reg.sroa.0.0.copyload37174404 = load <4 x half>, ptr addrspace(4) %add.ptr1211, align 16, !dbg !218
  %V_reg.sroa.42.0.add.ptr1211.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1211, i64 8, !dbg !218
  %V_reg.sroa.42.0.copyload37384405 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1211.sroa_idx, align 8, !dbg !218
  %473 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %472, !dbg !217
  %add.ptr1211.1 = getelementptr inbounds i8, ptr addrspace(4) %473, i64 1024, !dbg !217
  %V_reg.sroa.74.16.copyload38194406 = load <4 x half>, ptr addrspace(4) %add.ptr1211.1, align 16, !dbg !218
  %V_reg.sroa.114.16.add.ptr1211.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %473, i64 1032, !dbg !218
  %V_reg.sroa.114.16.copyload38404407 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1211.1.sroa_idx, align 8, !dbg !218
  %cmp1221 = icmp sgt i32 %mul11.1, %invariant.op, !dbg !219
  br i1 %cmp1221, label %for.cond1223.preheader, label %if.end1247, !dbg !220

for.cond1223.preheader:                           ; preds = %for.cond1196.preheader
  %add1230 = add nuw nsw i32 %mul11.1, %mul1083
  %cmp1233.not = icmp sgt i32 %add1230, %1, !dbg !221
  %fneg.2183 = select i1 %cmp1233.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3019 = insertelement <4 x float> poison, float %fneg.2183, i64 0, !dbg !222
  %cmp1233.not.1.not = icmp slt i32 %add1230, %1, !dbg !221
  %fneg.2183.1 = select i1 %cmp1233.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3208 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3019, float %fneg.2183.1, i64 1, !dbg !222
  %add1231.2 = or disjoint i32 %add1230, 2, !dbg !223
  %cmp1233.not.2 = icmp sgt i32 %add1231.2, %1, !dbg !221
  %fneg.2183.2 = select i1 %cmp1233.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3381 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3208, float %fneg.2183.2, i64 2, !dbg !222
  %add1231.3 = or disjoint i32 %add1230, 3, !dbg !223
  %cmp1233.not.3 = icmp sgt i32 %add1231.3, %1, !dbg !221
  %fneg.2183.3 = select i1 %cmp1233.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3554 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3381, float %fneg.2183.3, i64 3, !dbg !222
  br label %if.end1247

if.end1247:                                       ; preds = %for.cond1196.preheader, %for.cond1223.preheader
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3554, %for.cond1223.preheader ], [ zeroinitializer, %for.cond1196.preheader ], !dbg !83
  %474 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %429, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.2), !dbg !224, !call_argsrelate !101
  %475 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %428, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %474), !dbg !224, !call_argsrelate !101
  %476 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %427, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %475), !dbg !224, !call_argsrelate !101
  %477 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %426, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %476), !dbg !224, !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract3021 = extractelement <4 x float> %477, i64 0, !dbg !225
  %mul1282 = fmul contract float %acc_s.sroa.0.0.vec.extract3021, 0x3FB99999A0000000, !dbg !226
  %478 = tail call contract noundef float @llvm.minnum.f32(float %mul1282, float 0x4024CB5EC0000000), !dbg !227
  %479 = tail call contract noundef float @llvm.exp.f32(float %478), !dbg !229
  %acc_s.sroa.0.4.vec.extract3210 = extractelement <4 x float> %477, i64 1, !dbg !225
  %mul1282.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3210, 0x3FB99999A0000000, !dbg !226
  %480 = tail call contract noundef float @llvm.minnum.f32(float %mul1282.1, float 0x4024CB5EC0000000), !dbg !227
  %481 = tail call contract noundef float @llvm.exp.f32(float %480), !dbg !229
  %acc_s.sroa.0.8.vec.extract3383 = extractelement <4 x float> %477, i64 2, !dbg !225
  %mul1282.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3383, 0x3FB99999A0000000, !dbg !226
  %482 = tail call contract noundef float @llvm.minnum.f32(float %mul1282.2, float 0x4024CB5EC0000000), !dbg !227
  %483 = tail call contract noundef float @llvm.exp.f32(float %482), !dbg !229
  %acc_s.sroa.0.12.vec.extract3556 = extractelement <4 x float> %477, i64 3, !dbg !225
  %mul1282.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3556, 0x3FB99999A0000000, !dbg !226
  %484 = tail call contract noundef float @llvm.minnum.f32(float %mul1282.3, float 0x4024CB5EC0000000), !dbg !227
  %485 = tail call contract noundef float @llvm.exp.f32(float %484), !dbg !229
  %add1298 = fadd contract float %sum_acc.sroa.0.0, %479, !dbg !231
  %add1298.1 = fadd contract float %sum_acc.sroa.36.0, %481, !dbg !231
  %add1298.2 = fadd contract float %sum_acc.sroa.70.0, %483, !dbg !231
  %add1298.3 = fadd contract float %sum_acc.sroa.104.0, %485, !dbg !231
  %486 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %479), !dbg !232
  %487 = insertelement <4 x i16> poison, i16 %486, i64 0, !dbg !236
  %488 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %481), !dbg !232
  %489 = insertelement <4 x i16> %487, i16 %488, i64 1, !dbg !236
  %490 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %483), !dbg !232
  %491 = insertelement <4 x i16> %489, i16 %490, i64 2, !dbg !236
  %492 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %485), !dbg !232
  %493 = insertelement <4 x i16> %491, i16 %492, i64 3, !dbg !236
  %acc_s_cast.sroa.0.6.vec.insert2950 = bitcast <4 x i16> %493 to <4 x half>, !dbg !236
  %494 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload37174404, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2950, <4 x float> zeroinitializer), !dbg !237, !call_argsrelate !214
  %495 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload37384405, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2950, <4 x float> zeroinitializer), !dbg !237, !call_argsrelate !214
  %496 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload38194406, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2950, <4 x float> zeroinitializer), !dbg !237, !call_argsrelate !214
  %497 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload38404407, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2950, <4 x float> zeroinitializer), !dbg !237, !call_argsrelate !214
  br label %if.end1334, !dbg !238

if.end1334:                                       ; preds = %if.end1247, %if.end1188
  %acc_o_alt.sroa.74.0 = phi <4 x float> [ zeroinitializer, %if.end1188 ], [ %497, %if.end1247 ], !dbg !83
  %acc_o_alt.sroa.50.0 = phi <4 x float> [ zeroinitializer, %if.end1188 ], [ %496, %if.end1247 ], !dbg !83
  %acc_o_alt.sroa.26.0 = phi <4 x float> [ zeroinitializer, %if.end1188 ], [ %495, %if.end1247 ], !dbg !83
  %acc_o_alt.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1188 ], [ %494, %if.end1247 ], !dbg !83
  %sum_acc.sroa.104.1 = phi float [ %sum_acc.sroa.104.0, %if.end1188 ], [ %add1298.3, %if.end1247 ], !dbg !83
  %sum_acc.sroa.70.1 = phi float [ %sum_acc.sroa.70.0, %if.end1188 ], [ %add1298.2, %if.end1247 ], !dbg !83
  %sum_acc.sroa.36.1 = phi float [ %sum_acc.sroa.36.0, %if.end1188 ], [ %add1298.1, %if.end1247 ], !dbg !83
  %sum_acc.sroa.0.1 = phi float [ %sum_acc.sroa.0.0, %if.end1188 ], [ %add1298, %if.end1247 ], !dbg !83
  br i1 %or.cond2522, label %if.end1480, label %for.cond1342.preheader, !dbg !238

for.cond1342.preheader:                           ; preds = %if.end1334
  %498 = shl nsw i32 %cond.i.i2318.2, 10
  %mul1349 = and i32 %498, 64512
  %add1352 = add nuw nsw i32 %add934, %mul1349
  %499 = zext nneg i32 %add1352 to i64, !dbg !239
  %add.ptr1357 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %499, !dbg !240
  %V_reg.sroa.0.0.copyload37184408 = load <4 x half>, ptr addrspace(4) %add.ptr1357, align 16, !dbg !241
  %V_reg.sroa.42.0.add.ptr1357.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1357, i64 8, !dbg !241
  %V_reg.sroa.42.0.copyload37394409 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1357.sroa_idx, align 8, !dbg !241
  %500 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %499, !dbg !240
  %add.ptr1357.1 = getelementptr inbounds i8, ptr addrspace(4) %500, i64 1024, !dbg !240
  %V_reg.sroa.74.16.copyload38204410 = load <4 x half>, ptr addrspace(4) %add.ptr1357.1, align 16, !dbg !241
  %V_reg.sroa.114.16.add.ptr1357.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %500, i64 1032, !dbg !241
  %V_reg.sroa.114.16.copyload38414411 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1357.1.sroa_idx, align 8, !dbg !241
  %cmp1367 = icmp sgt i32 %mul11.2, %invariant.op, !dbg !242
  br i1 %cmp1367, label %for.cond1369.preheader, label %if.end1393, !dbg !243

for.cond1369.preheader:                           ; preds = %for.cond1342.preheader
  %add1376 = add nuw nsw i32 %mul11.2, %mul1083
  %cmp1379.not = icmp sgt i32 %add1376, %1, !dbg !244
  %fneg.2184 = select i1 %cmp1379.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3029 = insertelement <4 x float> poison, float %fneg.2184, i64 0, !dbg !245
  %cmp1379.not.1.not = icmp slt i32 %add1376, %1, !dbg !244
  %fneg.2184.1 = select i1 %cmp1379.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3218 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3029, float %fneg.2184.1, i64 1, !dbg !245
  %add1377.2 = or disjoint i32 %add1376, 2, !dbg !246
  %cmp1379.not.2 = icmp sgt i32 %add1377.2, %1, !dbg !244
  %fneg.2184.2 = select i1 %cmp1379.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3391 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3218, float %fneg.2184.2, i64 2, !dbg !245
  %add1377.3 = or disjoint i32 %add1376, 3, !dbg !246
  %cmp1379.not.3 = icmp sgt i32 %add1377.3, %1, !dbg !244
  %fneg.2184.3 = select i1 %cmp1379.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3564 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3391, float %fneg.2184.3, i64 3, !dbg !245
  br label %if.end1393

if.end1393:                                       ; preds = %for.cond1342.preheader, %for.cond1369.preheader
  %acc_s.sroa.0.4 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3564, %for.cond1369.preheader ], [ zeroinitializer, %for.cond1342.preheader ], !dbg !83
  %501 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %436, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.4), !dbg !247, !call_argsrelate !101
  %502 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %435, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %501), !dbg !247, !call_argsrelate !101
  %503 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %434, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %502), !dbg !247, !call_argsrelate !101
  %504 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %433, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %503), !dbg !247, !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract3031 = extractelement <4 x float> %504, i64 0, !dbg !248
  %mul1428 = fmul contract float %acc_s.sroa.0.0.vec.extract3031, 0x3FB99999A0000000, !dbg !249
  %505 = tail call contract noundef float @llvm.minnum.f32(float %mul1428, float 0x4024CB5EC0000000), !dbg !250
  %506 = tail call contract noundef float @llvm.exp.f32(float %505), !dbg !252
  %acc_s.sroa.0.4.vec.extract3220 = extractelement <4 x float> %504, i64 1, !dbg !248
  %mul1428.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3220, 0x3FB99999A0000000, !dbg !249
  %507 = tail call contract noundef float @llvm.minnum.f32(float %mul1428.1, float 0x4024CB5EC0000000), !dbg !250
  %508 = tail call contract noundef float @llvm.exp.f32(float %507), !dbg !252
  %acc_s.sroa.0.8.vec.extract3393 = extractelement <4 x float> %504, i64 2, !dbg !248
  %mul1428.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3393, 0x3FB99999A0000000, !dbg !249
  %509 = tail call contract noundef float @llvm.minnum.f32(float %mul1428.2, float 0x4024CB5EC0000000), !dbg !250
  %510 = tail call contract noundef float @llvm.exp.f32(float %509), !dbg !252
  %acc_s.sroa.0.12.vec.extract3566 = extractelement <4 x float> %504, i64 3, !dbg !248
  %mul1428.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3566, 0x3FB99999A0000000, !dbg !249
  %511 = tail call contract noundef float @llvm.minnum.f32(float %mul1428.3, float 0x4024CB5EC0000000), !dbg !250
  %512 = tail call contract noundef float @llvm.exp.f32(float %511), !dbg !252
  %add1444 = fadd contract float %sum_acc.sroa.0.1, %506, !dbg !254
  %add1444.1 = fadd contract float %sum_acc.sroa.36.1, %508, !dbg !254
  %add1444.2 = fadd contract float %sum_acc.sroa.70.1, %510, !dbg !254
  %add1444.3 = fadd contract float %sum_acc.sroa.104.1, %512, !dbg !254
  %513 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %506), !dbg !255
  %514 = insertelement <4 x i16> poison, i16 %513, i64 0, !dbg !259
  %515 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %508), !dbg !255
  %516 = insertelement <4 x i16> %514, i16 %515, i64 1, !dbg !259
  %517 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %510), !dbg !255
  %518 = insertelement <4 x i16> %516, i16 %517, i64 2, !dbg !259
  %519 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %512), !dbg !255
  %520 = insertelement <4 x i16> %518, i16 %519, i64 3, !dbg !259
  %acc_s_cast.sroa.0.6.vec.insert2952 = bitcast <4 x i16> %520 to <4 x half>, !dbg !259
  %521 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload37184408, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2952, <4 x float> %acc_o.sroa.0.0), !dbg !260, !call_argsrelate !214
  %522 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload37394409, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2952, <4 x float> %acc_o.sroa.42.0), !dbg !260, !call_argsrelate !214
  %523 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload38204410, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2952, <4 x float> %acc_o.sroa.82.0), !dbg !260, !call_argsrelate !214
  %524 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload38414411, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2952, <4 x float> %acc_o.sroa.122.0), !dbg !260, !call_argsrelate !214
  br label %if.end1480, !dbg !261

if.end1480:                                       ; preds = %if.end1393, %if.end1334
  %acc_o.sroa.122.1 = phi <4 x float> [ %acc_o.sroa.122.0, %if.end1334 ], [ %524, %if.end1393 ], !dbg !83
  %acc_o.sroa.82.1 = phi <4 x float> [ %acc_o.sroa.82.0, %if.end1334 ], [ %523, %if.end1393 ], !dbg !83
  %acc_o.sroa.42.1 = phi <4 x float> [ %acc_o.sroa.42.0, %if.end1334 ], [ %522, %if.end1393 ], !dbg !83
  %acc_o.sroa.0.1 = phi <4 x float> [ %acc_o.sroa.0.0, %if.end1334 ], [ %521, %if.end1393 ], !dbg !83
  %sum_acc.sroa.104.2 = phi float [ %sum_acc.sroa.104.1, %if.end1334 ], [ %add1444.3, %if.end1393 ], !dbg !83
  %sum_acc.sroa.70.2 = phi float [ %sum_acc.sroa.70.1, %if.end1334 ], [ %add1444.2, %if.end1393 ], !dbg !83
  %sum_acc.sroa.36.2 = phi float [ %sum_acc.sroa.36.1, %if.end1334 ], [ %add1444.1, %if.end1393 ], !dbg !83
  %sum_acc.sroa.0.2 = phi float [ %sum_acc.sroa.0.1, %if.end1334 ], [ %add1444, %if.end1393 ], !dbg !83
  br i1 %or.cond2524, label %if.end1626, label %for.cond1488.preheader, !dbg !261

for.cond1488.preheader:                           ; preds = %if.end1480
  %525 = shl nsw i32 %cond.i.i2318.3, 10
  %mul1495 = and i32 %525, 64512
  %add1498 = add nuw nsw i32 %add934, %mul1495
  %526 = zext nneg i32 %add1498 to i64, !dbg !262
  %add.ptr1503 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %526, !dbg !263
  %V_reg.sroa.0.0.copyload37194412 = load <4 x half>, ptr addrspace(4) %add.ptr1503, align 16, !dbg !264
  %V_reg.sroa.42.0.add.ptr1503.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1503, i64 8, !dbg !264
  %V_reg.sroa.42.0.copyload37404413 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1503.sroa_idx, align 8, !dbg !264
  %527 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %526, !dbg !263
  %add.ptr1503.1 = getelementptr inbounds i8, ptr addrspace(4) %527, i64 1024, !dbg !263
  %V_reg.sroa.74.16.copyload38214414 = load <4 x half>, ptr addrspace(4) %add.ptr1503.1, align 16, !dbg !264
  %V_reg.sroa.114.16.add.ptr1503.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %527, i64 1032, !dbg !264
  %V_reg.sroa.114.16.copyload38424415 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1503.1.sroa_idx, align 8, !dbg !264
  %cmp1513 = icmp sgt i32 %mul11.3, %invariant.op, !dbg !265
  br i1 %cmp1513, label %for.cond1515.preheader, label %if.end1539, !dbg !266

for.cond1515.preheader:                           ; preds = %for.cond1488.preheader
  %add1522 = add nuw nsw i32 %mul11.3, %mul1083
  %cmp1525.not = icmp sgt i32 %add1522, %1, !dbg !267
  %fneg.2185 = select i1 %cmp1525.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3039 = insertelement <4 x float> poison, float %fneg.2185, i64 0, !dbg !268
  %cmp1525.not.1.not = icmp slt i32 %add1522, %1, !dbg !267
  %fneg.2185.1 = select i1 %cmp1525.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3228 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3039, float %fneg.2185.1, i64 1, !dbg !268
  %add1523.2 = or disjoint i32 %add1522, 2, !dbg !269
  %cmp1525.not.2 = icmp sgt i32 %add1523.2, %1, !dbg !267
  %fneg.2185.2 = select i1 %cmp1525.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3401 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3228, float %fneg.2185.2, i64 2, !dbg !268
  %add1523.3 = or disjoint i32 %add1522, 3, !dbg !269
  %cmp1525.not.3 = icmp sgt i32 %add1523.3, %1, !dbg !267
  %fneg.2185.3 = select i1 %cmp1525.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3574 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3401, float %fneg.2185.3, i64 3, !dbg !268
  br label %if.end1539

if.end1539:                                       ; preds = %for.cond1488.preheader, %for.cond1515.preheader
  %acc_s.sroa.0.6 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3574, %for.cond1515.preheader ], [ zeroinitializer, %for.cond1488.preheader ], !dbg !83
  %528 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %443, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.6), !dbg !270, !call_argsrelate !101
  %529 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %442, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %528), !dbg !270, !call_argsrelate !101
  %530 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %441, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %529), !dbg !270, !call_argsrelate !101
  %531 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %440, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %530), !dbg !270, !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract3041 = extractelement <4 x float> %531, i64 0, !dbg !271
  %mul1574 = fmul contract float %acc_s.sroa.0.0.vec.extract3041, 0x3FB99999A0000000, !dbg !272
  %532 = tail call contract noundef float @llvm.minnum.f32(float %mul1574, float 0x4024CB5EC0000000), !dbg !273
  %533 = tail call contract noundef float @llvm.exp.f32(float %532), !dbg !275
  %acc_s.sroa.0.4.vec.extract3230 = extractelement <4 x float> %531, i64 1, !dbg !271
  %mul1574.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3230, 0x3FB99999A0000000, !dbg !272
  %534 = tail call contract noundef float @llvm.minnum.f32(float %mul1574.1, float 0x4024CB5EC0000000), !dbg !273
  %535 = tail call contract noundef float @llvm.exp.f32(float %534), !dbg !275
  %acc_s.sroa.0.8.vec.extract3403 = extractelement <4 x float> %531, i64 2, !dbg !271
  %mul1574.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3403, 0x3FB99999A0000000, !dbg !272
  %536 = tail call contract noundef float @llvm.minnum.f32(float %mul1574.2, float 0x4024CB5EC0000000), !dbg !273
  %537 = tail call contract noundef float @llvm.exp.f32(float %536), !dbg !275
  %acc_s.sroa.0.12.vec.extract3576 = extractelement <4 x float> %531, i64 3, !dbg !271
  %mul1574.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3576, 0x3FB99999A0000000, !dbg !272
  %538 = tail call contract noundef float @llvm.minnum.f32(float %mul1574.3, float 0x4024CB5EC0000000), !dbg !273
  %539 = tail call contract noundef float @llvm.exp.f32(float %538), !dbg !275
  %add1590 = fadd contract float %sum_acc.sroa.0.2, %533, !dbg !277
  %add1590.1 = fadd contract float %sum_acc.sroa.36.2, %535, !dbg !277
  %add1590.2 = fadd contract float %sum_acc.sroa.70.2, %537, !dbg !277
  %add1590.3 = fadd contract float %sum_acc.sroa.104.2, %539, !dbg !277
  %540 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %533), !dbg !278
  %541 = insertelement <4 x i16> poison, i16 %540, i64 0, !dbg !282
  %542 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %535), !dbg !278
  %543 = insertelement <4 x i16> %541, i16 %542, i64 1, !dbg !282
  %544 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %537), !dbg !278
  %545 = insertelement <4 x i16> %543, i16 %544, i64 2, !dbg !282
  %546 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %539), !dbg !278
  %547 = insertelement <4 x i16> %545, i16 %546, i64 3, !dbg !282
  %acc_s_cast.sroa.0.6.vec.insert2954 = bitcast <4 x i16> %547 to <4 x half>, !dbg !282
  %548 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload37194412, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2954, <4 x float> %acc_o_alt.sroa.0.0), !dbg !283, !call_argsrelate !214
  %549 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload37404413, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2954, <4 x float> %acc_o_alt.sroa.26.0), !dbg !283, !call_argsrelate !214
  %550 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload38214414, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2954, <4 x float> %acc_o_alt.sroa.50.0), !dbg !283, !call_argsrelate !214
  %551 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload38424415, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2954, <4 x float> %acc_o_alt.sroa.74.0), !dbg !283, !call_argsrelate !214
  br label %if.end1626, !dbg !284

if.end1626:                                       ; preds = %if.end1539, %if.end1480
  %acc_o_alt.sroa.74.1 = phi <4 x float> [ %acc_o_alt.sroa.74.0, %if.end1480 ], [ %551, %if.end1539 ], !dbg !83
  %acc_o_alt.sroa.50.1 = phi <4 x float> [ %acc_o_alt.sroa.50.0, %if.end1480 ], [ %550, %if.end1539 ], !dbg !83
  %acc_o_alt.sroa.26.1 = phi <4 x float> [ %acc_o_alt.sroa.26.0, %if.end1480 ], [ %549, %if.end1539 ], !dbg !83
  %acc_o_alt.sroa.0.1 = phi <4 x float> [ %acc_o_alt.sroa.0.0, %if.end1480 ], [ %548, %if.end1539 ], !dbg !83
  %sum_acc.sroa.104.3 = phi float [ %sum_acc.sroa.104.2, %if.end1480 ], [ %add1590.3, %if.end1539 ], !dbg !83
  %sum_acc.sroa.70.3 = phi float [ %sum_acc.sroa.70.2, %if.end1480 ], [ %add1590.2, %if.end1539 ], !dbg !83
  %sum_acc.sroa.36.3 = phi float [ %sum_acc.sroa.36.2, %if.end1480 ], [ %add1590.1, %if.end1539 ], !dbg !83
  %sum_acc.sroa.0.3 = phi float [ %sum_acc.sroa.0.2, %if.end1480 ], [ %add1590, %if.end1539 ], !dbg !83
  %or.cond.1 = icmp ugt i32 %mul11.4, 1023, !dbg !78
  %cmp924.not.1 = icmp sgt i32 %mul11.4, %1
  %or.cond2518.1 = or i1 %or.cond.1, %cmp924.not.1, !dbg !78
  br i1 %or.cond2518.1, label %if.end949.1, label %for.cond926.preheader.1, !dbg !78

for.cond926.preheader.1:                          ; preds = %if.end1626
  %552 = shl nsw i32 %cond.i.i2318.4, 10
  %mul933.1 = and i32 %552, 64512
  %add936.1 = add nuw nsw i32 %add934, %mul933.1
  %553 = zext nneg i32 %add936.1 to i64, !dbg !177
  %add.ptr941.12602 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %553, !dbg !178
  %K_reg.sroa.0.0.copyload40054420 = load <4 x half>, ptr addrspace(4) %add.ptr941.12602, align 16, !dbg !179
  %K_reg.sroa.12.0.add.ptr941.12602.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr941.12602, i64 8, !dbg !179
  %K_reg.sroa.12.0.copyload40084422 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.12.0.add.ptr941.12602.sroa_idx, align 8, !dbg !179
  %554 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %553, !dbg !178
  %add.ptr941.1.1 = getelementptr inbounds i8, ptr addrspace(4) %554, i64 1024, !dbg !178
  %K_reg.sroa.20.16.copyload40234424 = load <4 x half>, ptr addrspace(4) %add.ptr941.1.1, align 16, !dbg !179
  %K_reg.sroa.30.16.add.ptr941.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %554, i64 1032, !dbg !179
  %K_reg.sroa.30.16.copyload40264426 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.30.16.add.ptr941.1.1.sroa_idx, align 8, !dbg !179
  br label %if.end949.1, !dbg !180

if.end949.1:                                      ; preds = %for.cond926.preheader.1, %if.end1626
  %555 = phi <4 x half> [ %419, %if.end1626 ], [ %K_reg.sroa.30.16.copyload40264426, %for.cond926.preheader.1 ]
  %556 = phi <4 x half> [ %420, %if.end1626 ], [ %K_reg.sroa.20.16.copyload40234424, %for.cond926.preheader.1 ]
  %557 = phi <4 x half> [ %421, %if.end1626 ], [ %K_reg.sroa.12.0.copyload40084422, %for.cond926.preheader.1 ]
  %558 = phi <4 x half> [ %422, %if.end1626 ], [ %K_reg.sroa.0.0.copyload40054420, %for.cond926.preheader.1 ]
  %or.cond2519.1 = icmp ugt i32 %mul11.5, 1023, !dbg !180
  %cmp955.not.1 = icmp sgt i32 %mul11.5, %1
  %or.cond2520.1 = or i1 %or.cond2519.1, %cmp955.not.1, !dbg !180
  br i1 %or.cond2520.1, label %if.end980.1, label %for.cond957.preheader.1, !dbg !180

for.cond957.preheader.1:                          ; preds = %if.end949.1
  %559 = shl nsw i32 %cond.i.i2318.5, 10
  %mul964.1 = and i32 %559, 64512
  %add967.1 = add nuw nsw i32 %add934, %mul964.1
  %560 = zext nneg i32 %add967.1 to i64, !dbg !181
  %add.ptr972.12603 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %560, !dbg !182
  %K_reg1.sroa.0.0.copyload39694432 = load <4 x half>, ptr addrspace(4) %add.ptr972.12603, align 16, !dbg !183
  %K_reg1.sroa.12.0.add.ptr972.12603.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr972.12603, i64 8, !dbg !183
  %K_reg1.sroa.12.0.copyload39724434 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.12.0.add.ptr972.12603.sroa_idx, align 8, !dbg !183
  %561 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %560, !dbg !182
  %add.ptr972.1.1 = getelementptr inbounds i8, ptr addrspace(4) %561, i64 1024, !dbg !182
  %K_reg1.sroa.20.16.copyload39874436 = load <4 x half>, ptr addrspace(4) %add.ptr972.1.1, align 16, !dbg !183
  %K_reg1.sroa.30.16.add.ptr972.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %561, i64 1032, !dbg !183
  %K_reg1.sroa.30.16.copyload39904438 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.30.16.add.ptr972.1.1.sroa_idx, align 8, !dbg !183
  br label %if.end980.1, !dbg !184

if.end980.1:                                      ; preds = %for.cond957.preheader.1, %if.end949.1
  %562 = phi <4 x half> [ %426, %if.end949.1 ], [ %K_reg1.sroa.30.16.copyload39904438, %for.cond957.preheader.1 ]
  %563 = phi <4 x half> [ %427, %if.end949.1 ], [ %K_reg1.sroa.20.16.copyload39874436, %for.cond957.preheader.1 ]
  %564 = phi <4 x half> [ %428, %if.end949.1 ], [ %K_reg1.sroa.12.0.copyload39724434, %for.cond957.preheader.1 ]
  %565 = phi <4 x half> [ %429, %if.end949.1 ], [ %K_reg1.sroa.0.0.copyload39694432, %for.cond957.preheader.1 ]
  %or.cond2521.1 = icmp ugt i32 %mul11.6, 1023, !dbg !184
  %cmp986.not.1 = icmp sgt i32 %mul11.6, %1
  %or.cond2522.1 = or i1 %or.cond2521.1, %cmp986.not.1, !dbg !184
  br i1 %or.cond2522.1, label %if.end1011.1, label %for.cond988.preheader.1, !dbg !184

for.cond988.preheader.1:                          ; preds = %if.end980.1
  %566 = shl nsw i32 %cond.i.i2318.6, 10
  %mul995.1 = and i32 %566, 64512
  %add998.1 = add nuw nsw i32 %add934, %mul995.1
  %567 = zext nneg i32 %add998.1 to i64, !dbg !185
  %add.ptr1003.12604 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %567, !dbg !186
  %K_reg2.sroa.0.0.copyload39334444 = load <4 x half>, ptr addrspace(4) %add.ptr1003.12604, align 16, !dbg !187
  %K_reg2.sroa.12.0.add.ptr1003.12604.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1003.12604, i64 8, !dbg !187
  %K_reg2.sroa.12.0.copyload39364446 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.12.0.add.ptr1003.12604.sroa_idx, align 8, !dbg !187
  %568 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %567, !dbg !186
  %add.ptr1003.1.1 = getelementptr inbounds i8, ptr addrspace(4) %568, i64 1024, !dbg !186
  %K_reg2.sroa.20.16.copyload39514448 = load <4 x half>, ptr addrspace(4) %add.ptr1003.1.1, align 16, !dbg !187
  %K_reg2.sroa.30.16.add.ptr1003.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %568, i64 1032, !dbg !187
  %K_reg2.sroa.30.16.copyload39544450 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.30.16.add.ptr1003.1.1.sroa_idx, align 8, !dbg !187
  br label %if.end1011.1, !dbg !188

if.end1011.1:                                     ; preds = %for.cond988.preheader.1, %if.end980.1
  %569 = phi <4 x half> [ %433, %if.end980.1 ], [ %K_reg2.sroa.30.16.copyload39544450, %for.cond988.preheader.1 ]
  %570 = phi <4 x half> [ %434, %if.end980.1 ], [ %K_reg2.sroa.20.16.copyload39514448, %for.cond988.preheader.1 ]
  %571 = phi <4 x half> [ %435, %if.end980.1 ], [ %K_reg2.sroa.12.0.copyload39364446, %for.cond988.preheader.1 ]
  %572 = phi <4 x half> [ %436, %if.end980.1 ], [ %K_reg2.sroa.0.0.copyload39334444, %for.cond988.preheader.1 ]
  %or.cond2523.1 = icmp ugt i32 %mul11.7, 1023, !dbg !188
  %cmp1017.not.1 = icmp sgt i32 %mul11.7, %1
  %or.cond2524.1 = or i1 %or.cond2523.1, %cmp1017.not.1, !dbg !188
  br i1 %or.cond2524.1, label %if.end1042.1, label %for.cond1019.preheader.1, !dbg !188

for.cond1019.preheader.1:                         ; preds = %if.end1011.1
  %573 = shl nsw i32 %cond.i.i2318.7, 10
  %mul1026.1 = and i32 %573, 64512
  %add1029.1 = add nuw nsw i32 %add934, %mul1026.1
  %574 = zext nneg i32 %add1029.1 to i64, !dbg !189
  %add.ptr1034.12605 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %574, !dbg !190
  %K_reg3.sroa.0.0.copyload38974456 = load <4 x half>, ptr addrspace(4) %add.ptr1034.12605, align 16, !dbg !191
  %K_reg3.sroa.12.0.add.ptr1034.12605.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1034.12605, i64 8, !dbg !191
  %K_reg3.sroa.12.0.copyload39004458 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.12.0.add.ptr1034.12605.sroa_idx, align 8, !dbg !191
  %575 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %574, !dbg !190
  %add.ptr1034.1.1 = getelementptr inbounds i8, ptr addrspace(4) %575, i64 1024, !dbg !190
  %K_reg3.sroa.20.16.copyload39154460 = load <4 x half>, ptr addrspace(4) %add.ptr1034.1.1, align 16, !dbg !191
  %K_reg3.sroa.30.16.add.ptr1034.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %575, i64 1032, !dbg !191
  %K_reg3.sroa.30.16.copyload39184462 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.30.16.add.ptr1034.1.1.sroa_idx, align 8, !dbg !191
  br label %if.end1042.1, !dbg !192

if.end1042.1:                                     ; preds = %for.cond1019.preheader.1, %if.end1011.1
  %576 = phi <4 x half> [ %440, %if.end1011.1 ], [ %K_reg3.sroa.30.16.copyload39184462, %for.cond1019.preheader.1 ]
  %577 = phi <4 x half> [ %441, %if.end1011.1 ], [ %K_reg3.sroa.20.16.copyload39154460, %for.cond1019.preheader.1 ]
  %578 = phi <4 x half> [ %442, %if.end1011.1 ], [ %K_reg3.sroa.12.0.copyload39004458, %for.cond1019.preheader.1 ]
  %579 = phi <4 x half> [ %443, %if.end1011.1 ], [ %K_reg3.sroa.0.0.copyload38974456, %for.cond1019.preheader.1 ]
  br i1 %or.cond2518.1, label %if.end1188.1, label %for.cond1050.preheader.1, !dbg !192

for.cond1050.preheader.1:                         ; preds = %if.end1042.1
  %580 = shl nsw i32 %cond.i.i2318.4, 10
  %mul1057.1 = and i32 %580, 64512
  %add1060.1 = add nuw nsw i32 %add934, %mul1057.1
  %581 = zext nneg i32 %add1060.1 to i64, !dbg !193
  %add.ptr1065.12606 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %581, !dbg !194
  %V_reg.sroa.0.0.copyload37204416 = load <4 x half>, ptr addrspace(4) %add.ptr1065.12606, align 16, !dbg !195
  %V_reg.sroa.42.0.add.ptr1065.12606.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1065.12606, i64 8, !dbg !195
  %V_reg.sroa.42.0.copyload37414417 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1065.12606.sroa_idx, align 8, !dbg !195
  %582 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %581, !dbg !194
  %add.ptr1065.1.1 = getelementptr inbounds i8, ptr addrspace(4) %582, i64 1024, !dbg !194
  %V_reg.sroa.74.16.copyload38224418 = load <4 x half>, ptr addrspace(4) %add.ptr1065.1.1, align 16, !dbg !195
  %V_reg.sroa.114.16.add.ptr1065.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %582, i64 1032, !dbg !195
  %V_reg.sroa.114.16.copyload38434419 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1065.1.1.sroa_idx, align 8, !dbg !195
  %cmp1075.1 = icmp sgt i32 %mul11.4, %invariant.op, !dbg !196
  br i1 %cmp1075.1, label %for.cond1077.preheader.1, label %if.end1101.1, !dbg !197

for.cond1077.preheader.1:                         ; preds = %for.cond1050.preheader.1
  %add1084.1 = add nuw nsw i32 %mul11.4, %mul1083
  %cmp1087.not.12607 = icmp sgt i32 %add1084.1, %1, !dbg !198
  %fneg..12608 = select i1 %cmp1087.not.12607, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3051 = insertelement <4 x float> poison, float %fneg..12608, i64 0, !dbg !199
  %cmp1087.not.1.1.not = icmp slt i32 %add1084.1, %1, !dbg !198
  %fneg..1.1 = select i1 %cmp1087.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3238 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3051, float %fneg..1.1, i64 1, !dbg !199
  %add1085.2.1 = or disjoint i32 %add1084.1, 2, !dbg !200
  %cmp1087.not.2.1 = icmp sgt i32 %add1085.2.1, %1, !dbg !198
  %fneg..2.1 = select i1 %cmp1087.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3411 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3238, float %fneg..2.1, i64 2, !dbg !199
  %add1085.3.1 = or disjoint i32 %add1084.1, 3, !dbg !200
  %cmp1087.not.3.1 = icmp sgt i32 %add1085.3.1, %1, !dbg !198
  %fneg..3.1 = select i1 %cmp1087.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3584 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3411, float %fneg..3.1, i64 3, !dbg !199
  br label %if.end1101.1

if.end1101.1:                                     ; preds = %for.cond1050.preheader.1, %for.cond1077.preheader.1
  %acc_s.sroa.0.8 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3584, %for.cond1077.preheader.1 ], [ zeroinitializer, %for.cond1050.preheader.1 ], !dbg !83
  %583 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %558, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.8), !dbg !201, !call_argsrelate !101
  %584 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %557, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %583), !dbg !201, !call_argsrelate !101
  %585 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %556, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %584), !dbg !201, !call_argsrelate !101
  %586 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %555, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %585), !dbg !201, !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract3053 = extractelement <4 x float> %586, i64 0, !dbg !202
  %mul1136.12612 = fmul contract float %acc_s.sroa.0.0.vec.extract3053, 0x3FB99999A0000000, !dbg !203
  %587 = tail call contract noundef float @llvm.minnum.f32(float %mul1136.12612, float 0x4024CB5EC0000000), !dbg !204
  %588 = tail call contract noundef float @llvm.exp.f32(float %587), !dbg !206
  %acc_s.sroa.0.4.vec.extract3240 = extractelement <4 x float> %586, i64 1, !dbg !202
  %mul1136.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3240, 0x3FB99999A0000000, !dbg !203
  %589 = tail call contract noundef float @llvm.minnum.f32(float %mul1136.1.1, float 0x4024CB5EC0000000), !dbg !204
  %590 = tail call contract noundef float @llvm.exp.f32(float %589), !dbg !206
  %acc_s.sroa.0.8.vec.extract3413 = extractelement <4 x float> %586, i64 2, !dbg !202
  %mul1136.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3413, 0x3FB99999A0000000, !dbg !203
  %591 = tail call contract noundef float @llvm.minnum.f32(float %mul1136.2.1, float 0x4024CB5EC0000000), !dbg !204
  %592 = tail call contract noundef float @llvm.exp.f32(float %591), !dbg !206
  %acc_s.sroa.0.12.vec.extract3586 = extractelement <4 x float> %586, i64 3, !dbg !202
  %mul1136.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3586, 0x3FB99999A0000000, !dbg !203
  %593 = tail call contract noundef float @llvm.minnum.f32(float %mul1136.3.1, float 0x4024CB5EC0000000), !dbg !204
  %594 = tail call contract noundef float @llvm.exp.f32(float %593), !dbg !206
  %add1152.12613 = fadd contract float %sum_acc.sroa.0.3, %588, !dbg !285
  %add1152.1.1 = fadd contract float %sum_acc.sroa.36.3, %590, !dbg !285
  %add1152.2.1 = fadd contract float %sum_acc.sroa.70.3, %592, !dbg !285
  %add1152.3.1 = fadd contract float %sum_acc.sroa.104.3, %594, !dbg !285
  %595 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %588), !dbg !208
  %596 = insertelement <4 x i16> poison, i16 %595, i64 0, !dbg !212
  %597 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %590), !dbg !208
  %598 = insertelement <4 x i16> %596, i16 %597, i64 1, !dbg !212
  %599 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %592), !dbg !208
  %600 = insertelement <4 x i16> %598, i16 %599, i64 2, !dbg !212
  %601 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %594), !dbg !208
  %602 = insertelement <4 x i16> %600, i16 %601, i64 3, !dbg !212
  %acc_s_cast.sroa.0.6.vec.insert2956 = bitcast <4 x i16> %602 to <4 x half>, !dbg !212
  %603 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload37204416, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2956, <4 x float> %acc_o.sroa.0.1), !dbg !213, !call_argsrelate !214
  %604 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload37414417, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2956, <4 x float> %acc_o.sroa.42.1), !dbg !213, !call_argsrelate !214
  %605 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload38224418, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2956, <4 x float> %acc_o.sroa.82.1), !dbg !213, !call_argsrelate !214
  %606 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload38434419, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2956, <4 x float> %acc_o.sroa.122.1), !dbg !213, !call_argsrelate !214
  br label %if.end1188.1, !dbg !215

if.end1188.1:                                     ; preds = %if.end1101.1, %if.end1042.1
  %acc_o.sroa.122.2 = phi <4 x float> [ %acc_o.sroa.122.1, %if.end1042.1 ], [ %606, %if.end1101.1 ], !dbg !83
  %acc_o.sroa.82.2 = phi <4 x float> [ %acc_o.sroa.82.1, %if.end1042.1 ], [ %605, %if.end1101.1 ], !dbg !83
  %acc_o.sroa.42.2 = phi <4 x float> [ %acc_o.sroa.42.1, %if.end1042.1 ], [ %604, %if.end1101.1 ], !dbg !83
  %acc_o.sroa.0.2 = phi <4 x float> [ %acc_o.sroa.0.1, %if.end1042.1 ], [ %603, %if.end1101.1 ], !dbg !83
  %sum_acc.sroa.104.4 = phi float [ %sum_acc.sroa.104.3, %if.end1042.1 ], [ %add1152.3.1, %if.end1101.1 ], !dbg !83
  %sum_acc.sroa.70.4 = phi float [ %sum_acc.sroa.70.3, %if.end1042.1 ], [ %add1152.2.1, %if.end1101.1 ], !dbg !83
  %sum_acc.sroa.36.4 = phi float [ %sum_acc.sroa.36.3, %if.end1042.1 ], [ %add1152.1.1, %if.end1101.1 ], !dbg !83
  %sum_acc.sroa.0.4 = phi float [ %sum_acc.sroa.0.3, %if.end1042.1 ], [ %add1152.12613, %if.end1101.1 ], !dbg !83
  br i1 %or.cond2520.1, label %if.end1334.1, label %for.cond1196.preheader.1, !dbg !215

for.cond1196.preheader.1:                         ; preds = %if.end1188.1
  %607 = shl nsw i32 %cond.i.i2318.5, 10
  %mul1203.1 = and i32 %607, 64512
  %add1206.1 = add nuw nsw i32 %add934, %mul1203.1
  %608 = zext nneg i32 %add1206.1 to i64, !dbg !216
  %add.ptr1211.12614 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %608, !dbg !217
  %V_reg.sroa.0.0.copyload37214428 = load <4 x half>, ptr addrspace(4) %add.ptr1211.12614, align 16, !dbg !218
  %V_reg.sroa.42.0.add.ptr1211.12614.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1211.12614, i64 8, !dbg !218
  %V_reg.sroa.42.0.copyload37424429 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1211.12614.sroa_idx, align 8, !dbg !218
  %609 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %608, !dbg !217
  %add.ptr1211.1.1 = getelementptr inbounds i8, ptr addrspace(4) %609, i64 1024, !dbg !217
  %V_reg.sroa.74.16.copyload38234430 = load <4 x half>, ptr addrspace(4) %add.ptr1211.1.1, align 16, !dbg !218
  %V_reg.sroa.114.16.add.ptr1211.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %609, i64 1032, !dbg !218
  %V_reg.sroa.114.16.copyload38444431 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1211.1.1.sroa_idx, align 8, !dbg !218
  %cmp1221.1 = icmp sgt i32 %mul11.5, %invariant.op, !dbg !219
  br i1 %cmp1221.1, label %for.cond1223.preheader.1, label %if.end1247.1, !dbg !220

for.cond1223.preheader.1:                         ; preds = %for.cond1196.preheader.1
  %add1230.1 = add nuw nsw i32 %mul11.5, %mul1083
  %cmp1233.not.12615 = icmp sgt i32 %add1230.1, %1, !dbg !221
  %fneg.2183.12616 = select i1 %cmp1233.not.12615, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3063 = insertelement <4 x float> poison, float %fneg.2183.12616, i64 0, !dbg !222
  %cmp1233.not.1.1.not = icmp slt i32 %add1230.1, %1, !dbg !221
  %fneg.2183.1.1 = select i1 %cmp1233.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3248 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3063, float %fneg.2183.1.1, i64 1, !dbg !222
  %add1231.2.1 = or disjoint i32 %add1230.1, 2, !dbg !223
  %cmp1233.not.2.1 = icmp sgt i32 %add1231.2.1, %1, !dbg !221
  %fneg.2183.2.1 = select i1 %cmp1233.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3421 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3248, float %fneg.2183.2.1, i64 2, !dbg !222
  %add1231.3.1 = or disjoint i32 %add1230.1, 3, !dbg !223
  %cmp1233.not.3.1 = icmp sgt i32 %add1231.3.1, %1, !dbg !221
  %fneg.2183.3.1 = select i1 %cmp1233.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3594 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3421, float %fneg.2183.3.1, i64 3, !dbg !222
  br label %if.end1247.1

if.end1247.1:                                     ; preds = %for.cond1196.preheader.1, %for.cond1223.preheader.1
  %acc_s.sroa.0.10 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3594, %for.cond1223.preheader.1 ], [ zeroinitializer, %for.cond1196.preheader.1 ], !dbg !83
  %610 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %565, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.10), !dbg !224, !call_argsrelate !101
  %611 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %564, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %610), !dbg !224, !call_argsrelate !101
  %612 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %563, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %611), !dbg !224, !call_argsrelate !101
  %613 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %562, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %612), !dbg !224, !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract3065 = extractelement <4 x float> %613, i64 0, !dbg !225
  %mul1282.12620 = fmul contract float %acc_s.sroa.0.0.vec.extract3065, 0x3FB99999A0000000, !dbg !226
  %614 = tail call contract noundef float @llvm.minnum.f32(float %mul1282.12620, float 0x4024CB5EC0000000), !dbg !227
  %615 = tail call contract noundef float @llvm.exp.f32(float %614), !dbg !229
  %acc_s.sroa.0.4.vec.extract3250 = extractelement <4 x float> %613, i64 1, !dbg !225
  %mul1282.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3250, 0x3FB99999A0000000, !dbg !226
  %616 = tail call contract noundef float @llvm.minnum.f32(float %mul1282.1.1, float 0x4024CB5EC0000000), !dbg !227
  %617 = tail call contract noundef float @llvm.exp.f32(float %616), !dbg !229
  %acc_s.sroa.0.8.vec.extract3423 = extractelement <4 x float> %613, i64 2, !dbg !225
  %mul1282.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3423, 0x3FB99999A0000000, !dbg !226
  %618 = tail call contract noundef float @llvm.minnum.f32(float %mul1282.2.1, float 0x4024CB5EC0000000), !dbg !227
  %619 = tail call contract noundef float @llvm.exp.f32(float %618), !dbg !229
  %acc_s.sroa.0.12.vec.extract3596 = extractelement <4 x float> %613, i64 3, !dbg !225
  %mul1282.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3596, 0x3FB99999A0000000, !dbg !226
  %620 = tail call contract noundef float @llvm.minnum.f32(float %mul1282.3.1, float 0x4024CB5EC0000000), !dbg !227
  %621 = tail call contract noundef float @llvm.exp.f32(float %620), !dbg !229
  %add1298.12621 = fadd contract float %sum_acc.sroa.0.4, %615, !dbg !231
  %add1298.1.1 = fadd contract float %sum_acc.sroa.36.4, %617, !dbg !231
  %add1298.2.1 = fadd contract float %sum_acc.sroa.70.4, %619, !dbg !231
  %add1298.3.1 = fadd contract float %sum_acc.sroa.104.4, %621, !dbg !231
  %622 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %615), !dbg !232
  %623 = insertelement <4 x i16> poison, i16 %622, i64 0, !dbg !236
  %624 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %617), !dbg !232
  %625 = insertelement <4 x i16> %623, i16 %624, i64 1, !dbg !236
  %626 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %619), !dbg !232
  %627 = insertelement <4 x i16> %625, i16 %626, i64 2, !dbg !236
  %628 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %621), !dbg !232
  %629 = insertelement <4 x i16> %627, i16 %628, i64 3, !dbg !236
  %acc_s_cast.sroa.0.6.vec.insert2958 = bitcast <4 x i16> %629 to <4 x half>, !dbg !236
  %630 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload37214428, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2958, <4 x float> %acc_o_alt.sroa.0.1), !dbg !237, !call_argsrelate !214
  %631 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload37424429, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2958, <4 x float> %acc_o_alt.sroa.26.1), !dbg !237, !call_argsrelate !214
  %632 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload38234430, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2958, <4 x float> %acc_o_alt.sroa.50.1), !dbg !237, !call_argsrelate !214
  %633 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload38444431, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2958, <4 x float> %acc_o_alt.sroa.74.1), !dbg !237, !call_argsrelate !214
  br label %if.end1334.1, !dbg !238

if.end1334.1:                                     ; preds = %if.end1247.1, %if.end1188.1
  %acc_o_alt.sroa.74.2 = phi <4 x float> [ %acc_o_alt.sroa.74.1, %if.end1188.1 ], [ %633, %if.end1247.1 ], !dbg !83
  %acc_o_alt.sroa.50.2 = phi <4 x float> [ %acc_o_alt.sroa.50.1, %if.end1188.1 ], [ %632, %if.end1247.1 ], !dbg !83
  %acc_o_alt.sroa.26.2 = phi <4 x float> [ %acc_o_alt.sroa.26.1, %if.end1188.1 ], [ %631, %if.end1247.1 ], !dbg !83
  %acc_o_alt.sroa.0.2 = phi <4 x float> [ %acc_o_alt.sroa.0.1, %if.end1188.1 ], [ %630, %if.end1247.1 ], !dbg !83
  %sum_acc.sroa.104.5 = phi float [ %sum_acc.sroa.104.4, %if.end1188.1 ], [ %add1298.3.1, %if.end1247.1 ], !dbg !83
  %sum_acc.sroa.70.5 = phi float [ %sum_acc.sroa.70.4, %if.end1188.1 ], [ %add1298.2.1, %if.end1247.1 ], !dbg !83
  %sum_acc.sroa.36.5 = phi float [ %sum_acc.sroa.36.4, %if.end1188.1 ], [ %add1298.1.1, %if.end1247.1 ], !dbg !83
  %sum_acc.sroa.0.5 = phi float [ %sum_acc.sroa.0.4, %if.end1188.1 ], [ %add1298.12621, %if.end1247.1 ], !dbg !83
  br i1 %or.cond2522.1, label %if.end1480.1, label %for.cond1342.preheader.1, !dbg !238

for.cond1342.preheader.1:                         ; preds = %if.end1334.1
  %634 = shl nsw i32 %cond.i.i2318.6, 10
  %mul1349.1 = and i32 %634, 64512
  %add1352.1 = add nuw nsw i32 %add934, %mul1349.1
  %635 = zext nneg i32 %add1352.1 to i64, !dbg !239
  %add.ptr1357.12622 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %635, !dbg !240
  %V_reg.sroa.0.0.copyload37224440 = load <4 x half>, ptr addrspace(4) %add.ptr1357.12622, align 16, !dbg !241
  %V_reg.sroa.42.0.add.ptr1357.12622.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1357.12622, i64 8, !dbg !241
  %V_reg.sroa.42.0.copyload37434441 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1357.12622.sroa_idx, align 8, !dbg !241
  %636 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %635, !dbg !240
  %add.ptr1357.1.1 = getelementptr inbounds i8, ptr addrspace(4) %636, i64 1024, !dbg !240
  %V_reg.sroa.74.16.copyload38244442 = load <4 x half>, ptr addrspace(4) %add.ptr1357.1.1, align 16, !dbg !241
  %V_reg.sroa.114.16.add.ptr1357.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %636, i64 1032, !dbg !241
  %V_reg.sroa.114.16.copyload38454443 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1357.1.1.sroa_idx, align 8, !dbg !241
  %cmp1367.1 = icmp sgt i32 %mul11.6, %invariant.op, !dbg !242
  br i1 %cmp1367.1, label %for.cond1369.preheader.1, label %if.end1393.1, !dbg !243

for.cond1369.preheader.1:                         ; preds = %for.cond1342.preheader.1
  %add1376.1 = add nuw nsw i32 %mul11.6, %mul1083
  %cmp1379.not.12623 = icmp sgt i32 %add1376.1, %1, !dbg !244
  %fneg.2184.12624 = select i1 %cmp1379.not.12623, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3075 = insertelement <4 x float> poison, float %fneg.2184.12624, i64 0, !dbg !245
  %cmp1379.not.1.1.not = icmp slt i32 %add1376.1, %1, !dbg !244
  %fneg.2184.1.1 = select i1 %cmp1379.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3258 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3075, float %fneg.2184.1.1, i64 1, !dbg !245
  %add1377.2.1 = or disjoint i32 %add1376.1, 2, !dbg !246
  %cmp1379.not.2.1 = icmp sgt i32 %add1377.2.1, %1, !dbg !244
  %fneg.2184.2.1 = select i1 %cmp1379.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3431 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3258, float %fneg.2184.2.1, i64 2, !dbg !245
  %add1377.3.1 = or disjoint i32 %add1376.1, 3, !dbg !246
  %cmp1379.not.3.1 = icmp sgt i32 %add1377.3.1, %1, !dbg !244
  %fneg.2184.3.1 = select i1 %cmp1379.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3604 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3431, float %fneg.2184.3.1, i64 3, !dbg !245
  br label %if.end1393.1

if.end1393.1:                                     ; preds = %for.cond1342.preheader.1, %for.cond1369.preheader.1
  %acc_s.sroa.0.12 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3604, %for.cond1369.preheader.1 ], [ zeroinitializer, %for.cond1342.preheader.1 ], !dbg !83
  %637 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %572, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.12), !dbg !247, !call_argsrelate !101
  %638 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %571, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %637), !dbg !247, !call_argsrelate !101
  %639 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %570, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %638), !dbg !247, !call_argsrelate !101
  %640 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %569, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %639), !dbg !247, !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract3077 = extractelement <4 x float> %640, i64 0, !dbg !248
  %mul1428.12628 = fmul contract float %acc_s.sroa.0.0.vec.extract3077, 0x3FB99999A0000000, !dbg !249
  %641 = tail call contract noundef float @llvm.minnum.f32(float %mul1428.12628, float 0x4024CB5EC0000000), !dbg !250
  %642 = tail call contract noundef float @llvm.exp.f32(float %641), !dbg !252
  %acc_s.sroa.0.4.vec.extract3260 = extractelement <4 x float> %640, i64 1, !dbg !248
  %mul1428.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3260, 0x3FB99999A0000000, !dbg !249
  %643 = tail call contract noundef float @llvm.minnum.f32(float %mul1428.1.1, float 0x4024CB5EC0000000), !dbg !250
  %644 = tail call contract noundef float @llvm.exp.f32(float %643), !dbg !252
  %acc_s.sroa.0.8.vec.extract3433 = extractelement <4 x float> %640, i64 2, !dbg !248
  %mul1428.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3433, 0x3FB99999A0000000, !dbg !249
  %645 = tail call contract noundef float @llvm.minnum.f32(float %mul1428.2.1, float 0x4024CB5EC0000000), !dbg !250
  %646 = tail call contract noundef float @llvm.exp.f32(float %645), !dbg !252
  %acc_s.sroa.0.12.vec.extract3606 = extractelement <4 x float> %640, i64 3, !dbg !248
  %mul1428.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3606, 0x3FB99999A0000000, !dbg !249
  %647 = tail call contract noundef float @llvm.minnum.f32(float %mul1428.3.1, float 0x4024CB5EC0000000), !dbg !250
  %648 = tail call contract noundef float @llvm.exp.f32(float %647), !dbg !252
  %add1444.12629 = fadd contract float %sum_acc.sroa.0.5, %642, !dbg !254
  %add1444.1.1 = fadd contract float %sum_acc.sroa.36.5, %644, !dbg !254
  %add1444.2.1 = fadd contract float %sum_acc.sroa.70.5, %646, !dbg !254
  %add1444.3.1 = fadd contract float %sum_acc.sroa.104.5, %648, !dbg !254
  %649 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %642), !dbg !255
  %650 = insertelement <4 x i16> poison, i16 %649, i64 0, !dbg !259
  %651 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %644), !dbg !255
  %652 = insertelement <4 x i16> %650, i16 %651, i64 1, !dbg !259
  %653 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %646), !dbg !255
  %654 = insertelement <4 x i16> %652, i16 %653, i64 2, !dbg !259
  %655 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %648), !dbg !255
  %656 = insertelement <4 x i16> %654, i16 %655, i64 3, !dbg !259
  %acc_s_cast.sroa.0.6.vec.insert2960 = bitcast <4 x i16> %656 to <4 x half>, !dbg !259
  %657 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload37224440, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2960, <4 x float> %acc_o.sroa.0.2), !dbg !260, !call_argsrelate !214
  %658 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload37434441, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2960, <4 x float> %acc_o.sroa.42.2), !dbg !260, !call_argsrelate !214
  %659 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload38244442, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2960, <4 x float> %acc_o.sroa.82.2), !dbg !260, !call_argsrelate !214
  %660 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload38454443, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2960, <4 x float> %acc_o.sroa.122.2), !dbg !260, !call_argsrelate !214
  br label %if.end1480.1, !dbg !261

if.end1480.1:                                     ; preds = %if.end1393.1, %if.end1334.1
  %acc_o.sroa.122.3 = phi <4 x float> [ %acc_o.sroa.122.2, %if.end1334.1 ], [ %660, %if.end1393.1 ], !dbg !83
  %acc_o.sroa.82.3 = phi <4 x float> [ %acc_o.sroa.82.2, %if.end1334.1 ], [ %659, %if.end1393.1 ], !dbg !83
  %acc_o.sroa.42.3 = phi <4 x float> [ %acc_o.sroa.42.2, %if.end1334.1 ], [ %658, %if.end1393.1 ], !dbg !83
  %acc_o.sroa.0.3 = phi <4 x float> [ %acc_o.sroa.0.2, %if.end1334.1 ], [ %657, %if.end1393.1 ], !dbg !83
  %sum_acc.sroa.104.6 = phi float [ %sum_acc.sroa.104.5, %if.end1334.1 ], [ %add1444.3.1, %if.end1393.1 ], !dbg !83
  %sum_acc.sroa.70.6 = phi float [ %sum_acc.sroa.70.5, %if.end1334.1 ], [ %add1444.2.1, %if.end1393.1 ], !dbg !83
  %sum_acc.sroa.36.6 = phi float [ %sum_acc.sroa.36.5, %if.end1334.1 ], [ %add1444.1.1, %if.end1393.1 ], !dbg !83
  %sum_acc.sroa.0.6 = phi float [ %sum_acc.sroa.0.5, %if.end1334.1 ], [ %add1444.12629, %if.end1393.1 ], !dbg !83
  br i1 %or.cond2524.1, label %if.end1630, label %for.cond1488.preheader.1, !dbg !261

for.cond1488.preheader.1:                         ; preds = %if.end1480.1
  %661 = shl nsw i32 %cond.i.i2318.7, 10
  %mul1495.1 = and i32 %661, 64512
  %add1498.1 = add nuw nsw i32 %add934, %mul1495.1
  %662 = zext nneg i32 %add1498.1 to i64, !dbg !262
  %add.ptr1503.12630 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %662, !dbg !263
  %V_reg.sroa.0.0.copyload37234452 = load <4 x half>, ptr addrspace(4) %add.ptr1503.12630, align 16, !dbg !264
  %V_reg.sroa.42.0.add.ptr1503.12630.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1503.12630, i64 8, !dbg !264
  %V_reg.sroa.42.0.copyload37444453 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.0.add.ptr1503.12630.sroa_idx, align 8, !dbg !264
  %663 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %662, !dbg !263
  %add.ptr1503.1.1 = getelementptr inbounds i8, ptr addrspace(4) %663, i64 1024, !dbg !263
  %V_reg.sroa.74.16.copyload38254454 = load <4 x half>, ptr addrspace(4) %add.ptr1503.1.1, align 16, !dbg !264
  %V_reg.sroa.114.16.add.ptr1503.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %663, i64 1032, !dbg !264
  %V_reg.sroa.114.16.copyload38464455 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.114.16.add.ptr1503.1.1.sroa_idx, align 8, !dbg !264
  %cmp1513.1 = icmp sgt i32 %mul11.7, %invariant.op, !dbg !265
  br i1 %cmp1513.1, label %for.cond1515.preheader.1, label %if.end1539.1, !dbg !266

for.cond1515.preheader.1:                         ; preds = %for.cond1488.preheader.1
  %add1522.1 = add nuw nsw i32 %mul11.7, %mul1083
  %cmp1525.not.12631 = icmp sgt i32 %add1522.1, %1, !dbg !267
  %fneg.2185.12632 = select i1 %cmp1525.not.12631, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3087 = insertelement <4 x float> poison, float %fneg.2185.12632, i64 0, !dbg !268
  %cmp1525.not.1.1.not = icmp slt i32 %add1522.1, %1, !dbg !267
  %fneg.2185.1.1 = select i1 %cmp1525.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3268 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3087, float %fneg.2185.1.1, i64 1, !dbg !268
  %add1523.2.1 = or disjoint i32 %add1522.1, 2, !dbg !269
  %cmp1525.not.2.1 = icmp sgt i32 %add1523.2.1, %1, !dbg !267
  %fneg.2185.2.1 = select i1 %cmp1525.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3441 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3268, float %fneg.2185.2.1, i64 2, !dbg !268
  %add1523.3.1 = or disjoint i32 %add1522.1, 3, !dbg !269
  %cmp1525.not.3.1 = icmp sgt i32 %add1523.3.1, %1, !dbg !267
  %fneg.2185.3.1 = select i1 %cmp1525.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3614 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3441, float %fneg.2185.3.1, i64 3, !dbg !268
  br label %if.end1539.1

if.end1539.1:                                     ; preds = %for.cond1488.preheader.1, %for.cond1515.preheader.1
  %acc_s.sroa.0.14 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3614, %for.cond1515.preheader.1 ], [ zeroinitializer, %for.cond1488.preheader.1 ], !dbg !83
  %664 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %579, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.14), !dbg !270, !call_argsrelate !101
  %665 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %578, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %664), !dbg !270, !call_argsrelate !101
  %666 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %577, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %665), !dbg !270, !call_argsrelate !101
  %667 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %576, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %666), !dbg !270, !call_argsrelate !101
  %acc_s.sroa.0.0.vec.extract3089 = extractelement <4 x float> %667, i64 0, !dbg !271
  %mul1574.12636 = fmul contract float %acc_s.sroa.0.0.vec.extract3089, 0x3FB99999A0000000, !dbg !272
  %668 = tail call contract noundef float @llvm.minnum.f32(float %mul1574.12636, float 0x4024CB5EC0000000), !dbg !273
  %669 = tail call contract noundef float @llvm.exp.f32(float %668), !dbg !275
  %acc_s.sroa.0.4.vec.extract3270 = extractelement <4 x float> %667, i64 1, !dbg !271
  %mul1574.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3270, 0x3FB99999A0000000, !dbg !272
  %670 = tail call contract noundef float @llvm.minnum.f32(float %mul1574.1.1, float 0x4024CB5EC0000000), !dbg !273
  %671 = tail call contract noundef float @llvm.exp.f32(float %670), !dbg !275
  %acc_s.sroa.0.8.vec.extract3443 = extractelement <4 x float> %667, i64 2, !dbg !271
  %mul1574.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract3443, 0x3FB99999A0000000, !dbg !272
  %672 = tail call contract noundef float @llvm.minnum.f32(float %mul1574.2.1, float 0x4024CB5EC0000000), !dbg !273
  %673 = tail call contract noundef float @llvm.exp.f32(float %672), !dbg !275
  %acc_s.sroa.0.12.vec.extract3616 = extractelement <4 x float> %667, i64 3, !dbg !271
  %mul1574.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3616, 0x3FB99999A0000000, !dbg !272
  %674 = tail call contract noundef float @llvm.minnum.f32(float %mul1574.3.1, float 0x4024CB5EC0000000), !dbg !273
  %675 = tail call contract noundef float @llvm.exp.f32(float %674), !dbg !275
  %add1590.12637 = fadd contract float %sum_acc.sroa.0.6, %669, !dbg !277
  %add1590.1.1 = fadd contract float %sum_acc.sroa.36.6, %671, !dbg !277
  %add1590.2.1 = fadd contract float %sum_acc.sroa.70.6, %673, !dbg !277
  %add1590.3.1 = fadd contract float %sum_acc.sroa.104.6, %675, !dbg !277
  %676 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %669), !dbg !278
  %677 = insertelement <4 x i16> poison, i16 %676, i64 0, !dbg !282
  %678 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %671), !dbg !278
  %679 = insertelement <4 x i16> %677, i16 %678, i64 1, !dbg !282
  %680 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %673), !dbg !278
  %681 = insertelement <4 x i16> %679, i16 %680, i64 2, !dbg !282
  %682 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %675), !dbg !278
  %683 = insertelement <4 x i16> %681, i16 %682, i64 3, !dbg !282
  %acc_s_cast.sroa.0.6.vec.insert2962 = bitcast <4 x i16> %683 to <4 x half>, !dbg !282
  %684 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload37234452, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2962, <4 x float> %acc_o_alt.sroa.0.2), !dbg !283, !call_argsrelate !214
  %685 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.0.copyload37444453, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2962, <4 x float> %acc_o_alt.sroa.26.2), !dbg !283, !call_argsrelate !214
  %686 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.74.16.copyload38254454, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2962, <4 x float> %acc_o_alt.sroa.50.2), !dbg !283, !call_argsrelate !214
  %687 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.114.16.copyload38464455, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2962, <4 x float> %acc_o_alt.sroa.74.2), !dbg !283, !call_argsrelate !214
  br label %if.end1630, !dbg !284

if.end1630:                                       ; preds = %if.end1480.1, %if.end1539.1, %if.end798.1.1
  %.pre-phi4399 = phi i32 [ %23, %if.end798.1.1 ], [ %mul938, %if.end1539.1 ], [ %mul938, %if.end1480.1 ]
  %.pre-phi = phi i32 [ %.pre, %if.end798.1.1 ], [ %22, %if.end1539.1 ], [ %22, %if.end1480.1 ]
  %acc_o.sroa.122.4 = phi <4 x float> [ %379, %if.end798.1.1 ], [ %acc_o.sroa.122.3, %if.end1539.1 ], [ %acc_o.sroa.122.3, %if.end1480.1 ], !dbg !83
  %acc_o.sroa.82.4 = phi <4 x float> [ %378, %if.end798.1.1 ], [ %acc_o.sroa.82.3, %if.end1539.1 ], [ %acc_o.sroa.82.3, %if.end1480.1 ], !dbg !83
  %acc_o.sroa.42.4 = phi <4 x float> [ %377, %if.end798.1.1 ], [ %acc_o.sroa.42.3, %if.end1539.1 ], [ %acc_o.sroa.42.3, %if.end1480.1 ], !dbg !83
  %acc_o.sroa.0.4 = phi <4 x float> [ %376, %if.end798.1.1 ], [ %acc_o.sroa.0.3, %if.end1539.1 ], [ %acc_o.sroa.0.3, %if.end1480.1 ], !dbg !83
  %acc_o_alt.sroa.74.4 = phi <4 x float> [ %415, %if.end798.1.1 ], [ %687, %if.end1539.1 ], [ %acc_o_alt.sroa.74.2, %if.end1480.1 ], !dbg !83
  %acc_o_alt.sroa.50.4 = phi <4 x float> [ %414, %if.end798.1.1 ], [ %686, %if.end1539.1 ], [ %acc_o_alt.sroa.50.2, %if.end1480.1 ], !dbg !83
  %acc_o_alt.sroa.26.4 = phi <4 x float> [ %413, %if.end798.1.1 ], [ %685, %if.end1539.1 ], [ %acc_o_alt.sroa.26.2, %if.end1480.1 ], !dbg !83
  %acc_o_alt.sroa.0.4 = phi <4 x float> [ %412, %if.end798.1.1 ], [ %684, %if.end1539.1 ], [ %acc_o_alt.sroa.0.2, %if.end1480.1 ], !dbg !83
  %sum_acc.sroa.104.8 = phi float [ %add860.3.1, %if.end798.1.1 ], [ %add1590.3.1, %if.end1539.1 ], [ %sum_acc.sroa.104.6, %if.end1480.1 ], !dbg !83
  %sum_acc.sroa.70.8 = phi float [ %add860.2.1, %if.end798.1.1 ], [ %add1590.2.1, %if.end1539.1 ], [ %sum_acc.sroa.70.6, %if.end1480.1 ], !dbg !83
  %sum_acc.sroa.36.8 = phi float [ %add860.1.1, %if.end798.1.1 ], [ %add1590.1.1, %if.end1539.1 ], [ %sum_acc.sroa.36.6, %if.end1480.1 ], !dbg !83
  %sum_acc.sroa.0.8 = phi float [ %add860.12833, %if.end798.1.1 ], [ %add1590.12637, %if.end1539.1 ], [ %sum_acc.sroa.0.6, %if.end1480.1 ], !dbg !83
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.4, i64 0, !dbg !286
  %acc_o_alt.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.4, i64 0, !dbg !287
  %add1639 = fadd contract float %acc_o.sroa.0.0.vec.extract, %acc_o_alt.sroa.0.0.vec.extract, !dbg !288
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.4, i64 1, !dbg !286
  %acc_o_alt.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.4, i64 1, !dbg !287
  %add1639.1 = fadd contract float %acc_o.sroa.0.4.vec.extract, %acc_o_alt.sroa.0.4.vec.extract, !dbg !288
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.4, i64 2, !dbg !286
  %acc_o_alt.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.4, i64 2, !dbg !287
  %add1639.2 = fadd contract float %acc_o.sroa.0.8.vec.extract, %acc_o_alt.sroa.0.8.vec.extract, !dbg !288
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.4, i64 3, !dbg !286
  %acc_o_alt.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.4, i64 3, !dbg !287
  %add1639.3 = fadd contract float %acc_o.sroa.0.12.vec.extract, %acc_o_alt.sroa.0.12.vec.extract, !dbg !288
  %acc_o.sroa.42.16.vec.extract = extractelement <4 x float> %acc_o.sroa.42.4, i64 0, !dbg !286
  %acc_o_alt.sroa.26.16.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.26.4, i64 0, !dbg !287
  %add1639.4 = fadd contract float %acc_o.sroa.42.16.vec.extract, %acc_o_alt.sroa.26.16.vec.extract, !dbg !288
  %acc_o.sroa.42.20.vec.extract = extractelement <4 x float> %acc_o.sroa.42.4, i64 1, !dbg !286
  %acc_o_alt.sroa.26.20.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.26.4, i64 1, !dbg !287
  %add1639.5 = fadd contract float %acc_o.sroa.42.20.vec.extract, %acc_o_alt.sroa.26.20.vec.extract, !dbg !288
  %acc_o.sroa.42.24.vec.extract = extractelement <4 x float> %acc_o.sroa.42.4, i64 2, !dbg !286
  %acc_o_alt.sroa.26.24.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.26.4, i64 2, !dbg !287
  %add1639.6 = fadd contract float %acc_o.sroa.42.24.vec.extract, %acc_o_alt.sroa.26.24.vec.extract, !dbg !288
  %acc_o.sroa.42.28.vec.extract = extractelement <4 x float> %acc_o.sroa.42.4, i64 3, !dbg !286
  %acc_o_alt.sroa.26.28.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.26.4, i64 3, !dbg !287
  %add1639.7 = fadd contract float %acc_o.sroa.42.28.vec.extract, %acc_o_alt.sroa.26.28.vec.extract, !dbg !288
  %acc_o.sroa.82.32.vec.extract = extractelement <4 x float> %acc_o.sroa.82.4, i64 0, !dbg !286
  %acc_o_alt.sroa.50.32.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.4, i64 0, !dbg !287
  %add1639.8 = fadd contract float %acc_o.sroa.82.32.vec.extract, %acc_o_alt.sroa.50.32.vec.extract, !dbg !288
  %acc_o.sroa.82.36.vec.extract = extractelement <4 x float> %acc_o.sroa.82.4, i64 1, !dbg !286
  %acc_o_alt.sroa.50.36.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.4, i64 1, !dbg !287
  %add1639.9 = fadd contract float %acc_o.sroa.82.36.vec.extract, %acc_o_alt.sroa.50.36.vec.extract, !dbg !288
  %acc_o.sroa.82.40.vec.extract = extractelement <4 x float> %acc_o.sroa.82.4, i64 2, !dbg !286
  %acc_o_alt.sroa.50.40.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.4, i64 2, !dbg !287
  %add1639.10 = fadd contract float %acc_o.sroa.82.40.vec.extract, %acc_o_alt.sroa.50.40.vec.extract, !dbg !288
  %acc_o.sroa.82.44.vec.extract = extractelement <4 x float> %acc_o.sroa.82.4, i64 3, !dbg !286
  %acc_o_alt.sroa.50.44.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.4, i64 3, !dbg !287
  %add1639.11 = fadd contract float %acc_o.sroa.82.44.vec.extract, %acc_o_alt.sroa.50.44.vec.extract, !dbg !288
  %acc_o.sroa.122.48.vec.extract = extractelement <4 x float> %acc_o.sroa.122.4, i64 0, !dbg !286
  %acc_o_alt.sroa.74.48.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.74.4, i64 0, !dbg !287
  %add1639.12 = fadd contract float %acc_o.sroa.122.48.vec.extract, %acc_o_alt.sroa.74.48.vec.extract, !dbg !288
  %acc_o.sroa.122.52.vec.extract = extractelement <4 x float> %acc_o.sroa.122.4, i64 1, !dbg !286
  %acc_o_alt.sroa.74.52.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.74.4, i64 1, !dbg !287
  %add1639.13 = fadd contract float %acc_o.sroa.122.52.vec.extract, %acc_o_alt.sroa.74.52.vec.extract, !dbg !288
  %acc_o.sroa.122.56.vec.extract = extractelement <4 x float> %acc_o.sroa.122.4, i64 2, !dbg !286
  %acc_o_alt.sroa.74.56.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.74.4, i64 2, !dbg !287
  %add1639.14 = fadd contract float %acc_o.sroa.122.56.vec.extract, %acc_o_alt.sroa.74.56.vec.extract, !dbg !288
  %acc_o.sroa.122.60.vec.extract = extractelement <4 x float> %acc_o.sroa.122.4, i64 3, !dbg !286
  %acc_o_alt.sroa.74.60.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.74.4, i64 3, !dbg !287
  %add1639.15 = fadd contract float %acc_o.sroa.122.60.vec.extract, %acc_o_alt.sroa.74.60.vec.extract, !dbg !288
  %add1653 = fadd contract float %sum_acc.sroa.0.8, 0.000000e+00, !dbg !289
  %add1653.1 = fadd contract float %add1653, %sum_acc.sroa.36.8, !dbg !289
  %add1653.2 = fadd contract float %add1653.1, %sum_acc.sroa.70.8, !dbg !289
  %add1653.3 = fadd contract float %add1653.2, %sum_acc.sroa.104.8, !dbg !289
  %688 = bitcast float %add1653.3 to i32, !dbg !290
  %689 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !302
  %690 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %689) #11, !dbg !307
  %xor.i.i = xor i32 %690, 32, !dbg !308
  %691 = and i32 %690, -64, !dbg !309
  %and.i.i = add nsw i32 %691, 64, !dbg !309
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !310
  %cond.i.i2353 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %690, !dbg !311
  %shl.i.i = shl i32 %cond.i.i2353, 2, !dbg !312
  %692 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %688), !dbg !313
  %693 = bitcast i32 %692 to float, !dbg !314
  %add.i = fadd contract float %add1653.3, %693, !dbg !315
  %694 = bitcast float %add.i to i32, !dbg !318
  %695 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !325
  %696 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %695) #11, !dbg !328
  %xor.i.i2354 = xor i32 %696, 16, !dbg !329
  %697 = and i32 %696, -64, !dbg !330
  %and.i.i2355 = add nsw i32 %697, 64, !dbg !330
  %cmp.not.i.i2356 = icmp slt i32 %xor.i.i2354, %and.i.i2355, !dbg !331
  %cond.i.i2357 = select i1 %cmp.not.i.i2356, i32 %xor.i.i2354, i32 %696, !dbg !332
  %shl.i.i2358 = shl i32 %cond.i.i2357, 2, !dbg !333
  %698 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i2358, i32 %694), !dbg !334
  %699 = bitcast i32 %698 to float, !dbg !335
  %add.i.i = fadd contract float %add.i, %699, !dbg !336
  %cmp1662 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !338
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !339
  %condval_12.0 = select i1 %cmp1662, float %div, float 0.000000e+00, !dbg !339
  %mul1675 = fmul contract float %condval_12.0, %add1639, !dbg !340
  %mul1675.1 = fmul contract float %condval_12.0, %add1639.1, !dbg !340
  %mul1675.2 = fmul contract float %condval_12.0, %add1639.2, !dbg !340
  %mul1675.3 = fmul contract float %condval_12.0, %add1639.3, !dbg !340
  %mul1675.4 = fmul contract float %condval_12.0, %add1639.4, !dbg !340
  %mul1675.5 = fmul contract float %condval_12.0, %add1639.5, !dbg !340
  %mul1675.6 = fmul contract float %condval_12.0, %add1639.6, !dbg !340
  %mul1675.7 = fmul contract float %condval_12.0, %add1639.7, !dbg !340
  %mul1675.8 = fmul contract float %condval_12.0, %add1639.8, !dbg !340
  %mul1675.9 = fmul contract float %condval_12.0, %add1639.9, !dbg !340
  %mul1675.10 = fmul contract float %condval_12.0, %add1639.10, !dbg !340
  %mul1675.11 = fmul contract float %condval_12.0, %add1639.11, !dbg !340
  %mul1675.12 = fmul contract float %condval_12.0, %add1639.12, !dbg !340
  %mul1675.13 = fmul contract float %condval_12.0, %add1639.13, !dbg !340
  %mul1675.14 = fmul contract float %condval_12.0, %add1639.14, !dbg !340
  %mul1675.15 = fmul contract float %condval_12.0, %add1639.15, !dbg !340
  %700 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675), !dbg !341
  %O_reg.sroa.0.0.insert.ext = zext i16 %700 to i64, !dbg !345
  %701 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675.1), !dbg !341
  %O_reg.sroa.0.2.insert.ext = zext i16 %701 to i64, !dbg !345
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !345
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !345
  %702 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675.2), !dbg !341
  %O_reg.sroa.0.4.insert.ext = zext i16 %702 to i64, !dbg !345
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !345
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !345
  %703 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675.3), !dbg !341
  %O_reg.sroa.0.6.insert.ext = zext i16 %703 to i64, !dbg !345
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !345
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !345
  %704 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675.4), !dbg !341
  %O_reg.sroa.7.8.insert.ext = zext i16 %704 to i64, !dbg !345
  %705 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675.5), !dbg !341
  %O_reg.sroa.7.10.insert.ext = zext i16 %705 to i64, !dbg !345
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !345
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !345
  %706 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675.6), !dbg !341
  %O_reg.sroa.7.12.insert.ext = zext i16 %706 to i64, !dbg !345
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !345
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !345
  %707 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675.7), !dbg !341
  %O_reg.sroa.7.14.insert.ext = zext i16 %707 to i64, !dbg !345
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !345
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !345
  %708 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675.8), !dbg !341
  %O_reg.sroa.12.16.insert.ext = zext i16 %708 to i64, !dbg !345
  %709 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675.9), !dbg !341
  %O_reg.sroa.12.18.insert.ext = zext i16 %709 to i64, !dbg !345
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !345
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !345
  %710 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675.10), !dbg !341
  %O_reg.sroa.12.20.insert.ext = zext i16 %710 to i64, !dbg !345
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !345
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !345
  %711 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675.11), !dbg !341
  %O_reg.sroa.12.22.insert.ext = zext i16 %711 to i64, !dbg !345
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !345
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !345
  %712 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675.12), !dbg !341
  %O_reg.sroa.17.24.insert.ext = zext i16 %712 to i64, !dbg !345
  %713 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675.13), !dbg !341
  %O_reg.sroa.17.26.insert.ext = zext i16 %713 to i64, !dbg !345
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !345
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !345
  %714 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675.14), !dbg !341
  %O_reg.sroa.17.28.insert.ext = zext i16 %714 to i64, !dbg !345
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !345
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !345
  %715 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1675.15), !dbg !341
  %O_reg.sroa.17.30.insert.ext = zext i16 %715 to i64, !dbg !345
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !345
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !345
  %shr1717 = lshr i32 %18, 5
  %and1720 = and i32 %18, 7
  %mul1726 = and i32 %.pre-phi, 4
  %xor = xor i32 %shr1717, %and1720, !dbg !346
  %mul1721 = shl nuw nsw i32 %xor, 3, !dbg !347
  %add1722 = add nuw nsw i32 %mul1721, %mul25, !dbg !348
  %add1727 = or disjoint i32 %add1722, %mul1726, !dbg !349
  %add.ptr1729 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1727, !dbg !350
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr1729, align 8, !dbg !351
  %add1718.1 = add nuw nsw i32 %shr1717, 2, !dbg !352
  %xor.1 = xor i32 %add1718.1, %and1720, !dbg !346
  %mul1721.1 = shl nuw nsw i32 %xor.1, 3, !dbg !347
  %add1722.1 = add nuw nsw i32 %mul1721.1, %mul25, !dbg !348
  %add1727.1 = or disjoint i32 %add1722.1, %mul1726, !dbg !349
  %add.ptr1729.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1727.1, !dbg !350
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr1729.1, align 8, !dbg !351
  %add1718.2 = add nuw nsw i32 %shr1717, 4, !dbg !352
  %xor.2 = xor i32 %add1718.2, %and1720, !dbg !346
  %mul1721.2 = shl nuw nsw i32 %xor.2, 3, !dbg !347
  %add1722.2 = add nuw nsw i32 %mul1721.2, %mul25, !dbg !348
  %add1727.2 = or disjoint i32 %add1722.2, %mul1726, !dbg !349
  %add.ptr1729.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1727.2, !dbg !350
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr1729.2, align 8, !dbg !351
  %add1718.3 = add nuw nsw i32 %shr1717, 6, !dbg !352
  %xor.3 = xor i32 %add1718.3, %and1720, !dbg !346
  %mul1721.3 = shl nuw nsw i32 %xor.3, 3, !dbg !347
  %add1722.3 = add nuw nsw i32 %mul1721.3, %mul25, !dbg !348
  %add1727.3 = or disjoint i32 %add1722.3, %mul1726, !dbg !349
  %add.ptr1729.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1727.3, !dbg !350
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr1729.3, align 8, !dbg !351
  fence syncscope("warp") release, !dbg !353
  tail call void @llvm.mxc.barrier.warp(), !dbg !358
  fence syncscope("warp") acquire, !dbg !359
  %mul1740 = and i32 %.pre-phi4399, 8128
  %xor17462181 = and i32 %.pre-phi4399, 56
  %call1744.masked = and i32 %18, 1016
  %mul1747 = xor i32 %xor17462181, %call1744.masked
  %invariant.gep2513 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul1740, !dbg !360
  %invariant.gep2515 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep2513, i32 %mul1747, !dbg !360
  %add1757 = add nuw nsw i32 %add23, %.pre-phi4399
  %716 = zext nneg i32 %add1757 to i64, !dbg !361
  %add.ptr1762 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %716, !dbg !362
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1762, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep2515, i64 16, i1 false), !dbg !363, !tbaa.struct !364, !call_argsrelate !365
  %gep2516.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep2515, i32 1024, !dbg !366
  %717 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %716, !dbg !362
  %add.ptr1762.1 = getelementptr inbounds i8, ptr addrspace(1) %717, i64 1024, !dbg !362
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1762.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep2516.1, i64 16, i1 false), !dbg !363, !tbaa.struct !364, !call_argsrelate !365
  ret void, !dbg !367
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
declare i32 @llvm.umax.i32(i32, i32) #7

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
!1 = !DIFile(filename: "/tmp/tmpac45_e93/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpac45_e93/tvm_kernels.maca", directory: "")
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
!58 = !DILocation(line: 743, column: 10, scope: !59, inlinedAt: !60)
!59 = distinct !DISubprogram(name: "max", scope: !46, file: !46, line: 742, type: !7, scopeLine: 742, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!60 = distinct !DILocation(line: 49, column: 15, scope: !40)
!61 = !DILocation(line: 743, column: 10, scope: !59, inlinedAt: !62)
!62 = distinct !DILocation(line: 49, column: 60, scope: !40)
!63 = !DILocation(line: 743, column: 10, scope: !59, inlinedAt: !64)
!64 = distinct !DILocation(line: 49, column: 11, scope: !40)
!65 = !DILocation(line: 743, column: 10, scope: !59, inlinedAt: !66)
!66 = distinct !DILocation(line: 49, column: 110, scope: !40)
!67 = !DILocation(line: 743, column: 10, scope: !59, inlinedAt: !68)
!68 = distinct !DILocation(line: 49, column: 155, scope: !40)
!69 = !DILocation(line: 743, column: 10, scope: !59, inlinedAt: !70)
!70 = distinct !DILocation(line: 49, column: 106, scope: !40)
!71 = !DILocation(line: 743, column: 10, scope: !59, inlinedAt: !72)
!72 = distinct !DILocation(line: 49, column: 7, scope: !40)
!73 = !DILocation(line: 49, column: 231, scope: !40)
!74 = !DILocation(line: 49, column: 242, scope: !40)
!75 = !DILocation(line: 49, column: 201, scope: !40)
!76 = !DILocation(line: 49, column: 7, scope: !40)
!77 = !DILocation(line: 265, column: 5, scope: !40)
!78 = !DILocation(line: 270, column: 26, scope: !40)
!79 = !DILocation(line: 59, column: 26, scope: !40)
!80 = !DILocation(line: 60, column: 33, scope: !40)
!81 = !DILocation(line: 60, column: 19, scope: !40)
!82 = !DILocation(line: 61, column: 9, scope: !40)
!83 = !DILocation(line: 0, scope: !40)
!84 = !DILocation(line: 70, column: 26, scope: !40)
!85 = !DILocation(line: 71, column: 35, scope: !40)
!86 = !DILocation(line: 71, column: 21, scope: !40)
!87 = !DILocation(line: 72, column: 9, scope: !40)
!88 = !DILocation(line: 81, column: 26, scope: !40)
!89 = !DILocation(line: 82, column: 35, scope: !40)
!90 = !DILocation(line: 82, column: 21, scope: !40)
!91 = !DILocation(line: 83, column: 9, scope: !40)
!92 = !DILocation(line: 92, column: 26, scope: !40)
!93 = !DILocation(line: 93, column: 35, scope: !40)
!94 = !DILocation(line: 93, column: 21, scope: !40)
!95 = !DILocation(line: 94, column: 9, scope: !40)
!96 = !DILocation(line: 103, column: 26, scope: !40)
!97 = !DILocation(line: 104, column: 35, scope: !40)
!98 = !DILocation(line: 104, column: 21, scope: !40)
!99 = !DILocation(line: 105, column: 9, scope: !40)
!100 = !DILocation(line: 115, column: 36, scope: !40)
!101 = !{i32 -1, i32 3, i32 -1}
!102 = !DILocation(line: 123, column: 32, scope: !40)
!103 = !DILocation(line: 123, column: 43, scope: !40)
!104 = !DILocation(line: 354, column: 10, scope: !105, inlinedAt: !106)
!105 = distinct !DISubprogram(name: "min", scope: !46, file: !46, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!106 = distinct !DILocation(line: 123, column: 27, scope: !40)
!107 = !DILocation(line: 288, column: 10, scope: !108, inlinedAt: !109)
!108 = distinct !DISubprogram(name: "expf", scope: !46, file: !46, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!109 = distinct !DILocation(line: 123, column: 22, scope: !40)
!110 = !DILocation(line: 75, column: 10, scope: !111, inlinedAt: !113)
!111 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !112, file: !112, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!112 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!113 = distinct !DILocation(line: 984, column: 9, scope: !114, inlinedAt: !116)
!114 = distinct !DISubprogram(name: "__float2half", scope: !115, file: !115, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!115 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!116 = distinct !DILocation(line: 133, column: 53, scope: !117, inlinedAt: !118)
!117 = distinct !DISubprogram(name: "__half", scope: !115, file: !115, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!118 = distinct !DILocation(line: 131, column: 34, scope: !40)
!119 = !DILocation(line: 131, column: 31, scope: !40)
!120 = !DILocation(line: 135, column: 36, scope: !40)
!121 = !DILocation(line: 144, column: 26, scope: !40)
!122 = !DILocation(line: 145, column: 35, scope: !40)
!123 = !DILocation(line: 145, column: 21, scope: !40)
!124 = !DILocation(line: 146, column: 9, scope: !40)
!125 = !DILocation(line: 156, column: 36, scope: !40)
!126 = !DILocation(line: 164, column: 33, scope: !40)
!127 = !DILocation(line: 164, column: 45, scope: !40)
!128 = !DILocation(line: 354, column: 10, scope: !105, inlinedAt: !129)
!129 = distinct !DILocation(line: 164, column: 28, scope: !40)
!130 = !DILocation(line: 288, column: 10, scope: !108, inlinedAt: !131)
!131 = distinct !DILocation(line: 164, column: 23, scope: !40)
!132 = !DILocation(line: 168, column: 40, scope: !40)
!133 = !DILocation(line: 75, column: 10, scope: !111, inlinedAt: !134)
!134 = distinct !DILocation(line: 984, column: 9, scope: !114, inlinedAt: !135)
!135 = distinct !DILocation(line: 133, column: 53, scope: !117, inlinedAt: !136)
!136 = distinct !DILocation(line: 172, column: 36, scope: !40)
!137 = !DILocation(line: 172, column: 33, scope: !40)
!138 = !DILocation(line: 176, column: 42, scope: !40)
!139 = !DILocation(line: 185, column: 26, scope: !40)
!140 = !DILocation(line: 186, column: 35, scope: !40)
!141 = !DILocation(line: 186, column: 21, scope: !40)
!142 = !DILocation(line: 187, column: 9, scope: !40)
!143 = !DILocation(line: 197, column: 36, scope: !40)
!144 = !DILocation(line: 205, column: 33, scope: !40)
!145 = !DILocation(line: 205, column: 45, scope: !40)
!146 = !DILocation(line: 354, column: 10, scope: !105, inlinedAt: !147)
!147 = distinct !DILocation(line: 205, column: 28, scope: !40)
!148 = !DILocation(line: 288, column: 10, scope: !108, inlinedAt: !149)
!149 = distinct !DILocation(line: 205, column: 23, scope: !40)
!150 = !DILocation(line: 209, column: 40, scope: !40)
!151 = !DILocation(line: 75, column: 10, scope: !111, inlinedAt: !152)
!152 = distinct !DILocation(line: 984, column: 9, scope: !114, inlinedAt: !153)
!153 = distinct !DILocation(line: 133, column: 53, scope: !117, inlinedAt: !154)
!154 = distinct !DILocation(line: 213, column: 36, scope: !40)
!155 = !DILocation(line: 213, column: 33, scope: !40)
!156 = !DILocation(line: 217, column: 38, scope: !40)
!157 = !DILocation(line: 226, column: 26, scope: !40)
!158 = !DILocation(line: 227, column: 35, scope: !40)
!159 = !DILocation(line: 227, column: 21, scope: !40)
!160 = !DILocation(line: 228, column: 9, scope: !40)
!161 = !DILocation(line: 238, column: 36, scope: !40)
!162 = !DILocation(line: 246, column: 33, scope: !40)
!163 = !DILocation(line: 246, column: 45, scope: !40)
!164 = !DILocation(line: 354, column: 10, scope: !105, inlinedAt: !165)
!165 = distinct !DILocation(line: 246, column: 28, scope: !40)
!166 = !DILocation(line: 288, column: 10, scope: !108, inlinedAt: !167)
!167 = distinct !DILocation(line: 246, column: 23, scope: !40)
!168 = !DILocation(line: 250, column: 40, scope: !40)
!169 = !DILocation(line: 75, column: 10, scope: !111, inlinedAt: !170)
!170 = distinct !DILocation(line: 984, column: 9, scope: !114, inlinedAt: !171)
!171 = distinct !DILocation(line: 133, column: 53, scope: !117, inlinedAt: !172)
!172 = distinct !DILocation(line: 254, column: 36, scope: !40)
!173 = !DILocation(line: 254, column: 33, scope: !40)
!174 = !DILocation(line: 258, column: 42, scope: !40)
!175 = !DILocation(line: 127, column: 38, scope: !40)
!176 = !DILocation(line: 493, column: 3, scope: !40)
!177 = !DILocation(line: 272, column: 9, scope: !40)
!178 = !DILocation(line: 273, column: 55, scope: !40)
!179 = !DILocation(line: 273, column: 41, scope: !40)
!180 = !DILocation(line: 276, column: 26, scope: !40)
!181 = !DILocation(line: 278, column: 9, scope: !40)
!182 = !DILocation(line: 279, column: 56, scope: !40)
!183 = !DILocation(line: 279, column: 42, scope: !40)
!184 = !DILocation(line: 282, column: 26, scope: !40)
!185 = !DILocation(line: 284, column: 9, scope: !40)
!186 = !DILocation(line: 285, column: 56, scope: !40)
!187 = !DILocation(line: 285, column: 42, scope: !40)
!188 = !DILocation(line: 288, column: 26, scope: !40)
!189 = !DILocation(line: 290, column: 9, scope: !40)
!190 = !DILocation(line: 291, column: 56, scope: !40)
!191 = !DILocation(line: 291, column: 42, scope: !40)
!192 = !DILocation(line: 294, column: 26, scope: !40)
!193 = !DILocation(line: 296, column: 9, scope: !40)
!194 = !DILocation(line: 297, column: 55, scope: !40)
!195 = !DILocation(line: 297, column: 41, scope: !40)
!196 = !DILocation(line: 299, column: 31, scope: !40)
!197 = !DILocation(line: 299, column: 13, scope: !40)
!198 = !DILocation(line: 303, column: 70, scope: !40)
!199 = !DILocation(line: 308, column: 25, scope: !40)
!200 = !DILocation(line: 303, column: 62, scope: !40)
!201 = !DILocation(line: 317, column: 36, scope: !40)
!202 = !DILocation(line: 325, column: 35, scope: !40)
!203 = !DILocation(line: 325, column: 47, scope: !40)
!204 = !DILocation(line: 354, column: 10, scope: !105, inlinedAt: !205)
!205 = distinct !DILocation(line: 325, column: 30, scope: !40)
!206 = !DILocation(line: 288, column: 10, scope: !108, inlinedAt: !207)
!207 = distinct !DILocation(line: 325, column: 25, scope: !40)
!208 = !DILocation(line: 75, column: 10, scope: !111, inlinedAt: !209)
!209 = distinct !DILocation(line: 984, column: 9, scope: !114, inlinedAt: !210)
!210 = distinct !DILocation(line: 133, column: 53, scope: !117, inlinedAt: !211)
!211 = distinct !DILocation(line: 333, column: 38, scope: !40)
!212 = !DILocation(line: 333, column: 35, scope: !40)
!213 = !DILocation(line: 337, column: 38, scope: !40)
!214 = !{i32 4, i32 -1, i32 -1}
!215 = !DILocation(line: 343, column: 26, scope: !40)
!216 = !DILocation(line: 345, column: 9, scope: !40)
!217 = !DILocation(line: 346, column: 55, scope: !40)
!218 = !DILocation(line: 346, column: 41, scope: !40)
!219 = !DILocation(line: 348, column: 31, scope: !40)
!220 = !DILocation(line: 348, column: 13, scope: !40)
!221 = !DILocation(line: 352, column: 70, scope: !40)
!222 = !DILocation(line: 357, column: 25, scope: !40)
!223 = !DILocation(line: 352, column: 62, scope: !40)
!224 = !DILocation(line: 366, column: 36, scope: !40)
!225 = !DILocation(line: 374, column: 35, scope: !40)
!226 = !DILocation(line: 374, column: 47, scope: !40)
!227 = !DILocation(line: 354, column: 10, scope: !105, inlinedAt: !228)
!228 = distinct !DILocation(line: 374, column: 30, scope: !40)
!229 = !DILocation(line: 288, column: 10, scope: !108, inlinedAt: !230)
!230 = distinct !DILocation(line: 374, column: 25, scope: !40)
!231 = !DILocation(line: 378, column: 42, scope: !40)
!232 = !DILocation(line: 75, column: 10, scope: !111, inlinedAt: !233)
!233 = distinct !DILocation(line: 984, column: 9, scope: !114, inlinedAt: !234)
!234 = distinct !DILocation(line: 133, column: 53, scope: !117, inlinedAt: !235)
!235 = distinct !DILocation(line: 382, column: 38, scope: !40)
!236 = !DILocation(line: 382, column: 35, scope: !40)
!237 = !DILocation(line: 386, column: 42, scope: !40)
!238 = !DILocation(line: 392, column: 26, scope: !40)
!239 = !DILocation(line: 394, column: 9, scope: !40)
!240 = !DILocation(line: 395, column: 55, scope: !40)
!241 = !DILocation(line: 395, column: 41, scope: !40)
!242 = !DILocation(line: 397, column: 31, scope: !40)
!243 = !DILocation(line: 397, column: 13, scope: !40)
!244 = !DILocation(line: 401, column: 70, scope: !40)
!245 = !DILocation(line: 406, column: 25, scope: !40)
!246 = !DILocation(line: 401, column: 62, scope: !40)
!247 = !DILocation(line: 415, column: 36, scope: !40)
!248 = !DILocation(line: 423, column: 35, scope: !40)
!249 = !DILocation(line: 423, column: 47, scope: !40)
!250 = !DILocation(line: 354, column: 10, scope: !105, inlinedAt: !251)
!251 = distinct !DILocation(line: 423, column: 30, scope: !40)
!252 = !DILocation(line: 288, column: 10, scope: !108, inlinedAt: !253)
!253 = distinct !DILocation(line: 423, column: 25, scope: !40)
!254 = !DILocation(line: 427, column: 42, scope: !40)
!255 = !DILocation(line: 75, column: 10, scope: !111, inlinedAt: !256)
!256 = distinct !DILocation(line: 984, column: 9, scope: !114, inlinedAt: !257)
!257 = distinct !DILocation(line: 133, column: 53, scope: !117, inlinedAt: !258)
!258 = distinct !DILocation(line: 431, column: 38, scope: !40)
!259 = !DILocation(line: 431, column: 35, scope: !40)
!260 = !DILocation(line: 435, column: 38, scope: !40)
!261 = !DILocation(line: 441, column: 26, scope: !40)
!262 = !DILocation(line: 443, column: 9, scope: !40)
!263 = !DILocation(line: 444, column: 55, scope: !40)
!264 = !DILocation(line: 444, column: 41, scope: !40)
!265 = !DILocation(line: 446, column: 31, scope: !40)
!266 = !DILocation(line: 446, column: 13, scope: !40)
!267 = !DILocation(line: 450, column: 70, scope: !40)
!268 = !DILocation(line: 455, column: 25, scope: !40)
!269 = !DILocation(line: 450, column: 62, scope: !40)
!270 = !DILocation(line: 464, column: 36, scope: !40)
!271 = !DILocation(line: 472, column: 35, scope: !40)
!272 = !DILocation(line: 472, column: 47, scope: !40)
!273 = !DILocation(line: 354, column: 10, scope: !105, inlinedAt: !274)
!274 = distinct !DILocation(line: 472, column: 30, scope: !40)
!275 = !DILocation(line: 288, column: 10, scope: !108, inlinedAt: !276)
!276 = distinct !DILocation(line: 472, column: 25, scope: !40)
!277 = !DILocation(line: 476, column: 42, scope: !40)
!278 = !DILocation(line: 75, column: 10, scope: !111, inlinedAt: !279)
!279 = distinct !DILocation(line: 984, column: 9, scope: !114, inlinedAt: !280)
!280 = distinct !DILocation(line: 133, column: 53, scope: !117, inlinedAt: !281)
!281 = distinct !DILocation(line: 480, column: 38, scope: !40)
!282 = !DILocation(line: 480, column: 35, scope: !40)
!283 = !DILocation(line: 484, column: 42, scope: !40)
!284 = !DILocation(line: 265, column: 40, scope: !40)
!285 = !DILocation(line: 329, column: 42, scope: !40)
!286 = !DILocation(line: 494, column: 20, scope: !40)
!287 = !DILocation(line: 494, column: 34, scope: !40)
!288 = !DILocation(line: 494, column: 32, scope: !40)
!289 = !DILocation(line: 499, column: 36, scope: !40)
!290 = !DILocation(line: 1018, column: 9, scope: !291, inlinedAt: !293)
!291 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !292, file: !292, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!292 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!293 = distinct !DILocation(line: 396, column: 10, scope: !294, inlinedAt: !296)
!294 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !295, file: !295, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!295 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!296 = distinct !DILocation(line: 129, column: 24, scope: !297, inlinedAt: !299)
!297 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !298, file: !298, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!298 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!299 = distinct !DILocation(line: 101, column: 14, scope: !300, inlinedAt: !301)
!300 = distinct !DISubprogram(name: "run<float>", scope: !298, file: !298, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!301 = distinct !DILocation(line: 501, column: 19, scope: !40)
!302 = !DILocation(line: 171, column: 37, scope: !303, inlinedAt: !304)
!303 = distinct !DISubprogram(name: "__lane_id", scope: !292, file: !292, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!304 = distinct !DILocation(line: 990, column: 14, scope: !305, inlinedAt: !306)
!305 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !292, file: !292, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!306 = distinct !DILocation(line: 1019, column: 11, scope: !291, inlinedAt: !293)
!307 = !DILocation(line: 171, column: 10, scope: !303, inlinedAt: !304)
!308 = !DILocation(line: 991, column: 20, scope: !305, inlinedAt: !306)
!309 = !DILocation(line: 992, column: 36, scope: !305, inlinedAt: !306)
!310 = !DILocation(line: 992, column: 17, scope: !305, inlinedAt: !306)
!311 = !DILocation(line: 992, column: 11, scope: !305, inlinedAt: !306)
!312 = !DILocation(line: 993, column: 43, scope: !305, inlinedAt: !306)
!313 = !DILocation(line: 993, column: 10, scope: !305, inlinedAt: !306)
!314 = !DILocation(line: 1020, column: 14, scope: !291, inlinedAt: !293)
!315 = !DILocation(line: 25, column: 14, scope: !316, inlinedAt: !317)
!316 = distinct !DISubprogram(name: "operator()<float>", scope: !298, file: !298, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!317 = distinct !DILocation(line: 129, column: 11, scope: !297, inlinedAt: !299)
!318 = !DILocation(line: 1018, column: 9, scope: !291, inlinedAt: !319)
!319 = distinct !DILocation(line: 396, column: 10, scope: !294, inlinedAt: !320)
!320 = distinct !DILocation(line: 129, column: 24, scope: !321, inlinedAt: !322)
!321 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !298, file: !298, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!322 = distinct !DILocation(line: 101, column: 14, scope: !323, inlinedAt: !324)
!323 = distinct !DISubprogram(name: "run<float>", scope: !298, file: !298, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!324 = distinct !DILocation(line: 134, column: 14, scope: !297, inlinedAt: !299)
!325 = !DILocation(line: 171, column: 37, scope: !303, inlinedAt: !326)
!326 = distinct !DILocation(line: 990, column: 14, scope: !305, inlinedAt: !327)
!327 = distinct !DILocation(line: 1019, column: 11, scope: !291, inlinedAt: !319)
!328 = !DILocation(line: 171, column: 10, scope: !303, inlinedAt: !326)
!329 = !DILocation(line: 991, column: 20, scope: !305, inlinedAt: !327)
!330 = !DILocation(line: 992, column: 36, scope: !305, inlinedAt: !327)
!331 = !DILocation(line: 992, column: 17, scope: !305, inlinedAt: !327)
!332 = !DILocation(line: 992, column: 11, scope: !305, inlinedAt: !327)
!333 = !DILocation(line: 993, column: 43, scope: !305, inlinedAt: !327)
!334 = !DILocation(line: 993, column: 10, scope: !305, inlinedAt: !327)
!335 = !DILocation(line: 1020, column: 14, scope: !291, inlinedAt: !319)
!336 = !DILocation(line: 25, column: 14, scope: !316, inlinedAt: !337)
!337 = distinct !DILocation(line: 129, column: 11, scope: !321, inlinedAt: !322)
!338 = !DILocation(line: 503, column: 32, scope: !40)
!339 = !DILocation(line: 503, column: 7, scope: !40)
!340 = !DILocation(line: 511, column: 32, scope: !40)
!341 = !DILocation(line: 75, column: 10, scope: !111, inlinedAt: !342)
!342 = distinct !DILocation(line: 984, column: 9, scope: !114, inlinedAt: !343)
!343 = distinct !DILocation(line: 133, column: 53, scope: !117, inlinedAt: !344)
!344 = distinct !DILocation(line: 517, column: 50, scope: !40)
!345 = !DILocation(line: 517, column: 47, scope: !40)
!346 = !DILocation(line: 522, column: 122, scope: !40)
!347 = !DILocation(line: 522, column: 150, scope: !40)
!348 = !DILocation(line: 522, column: 77, scope: !40)
!349 = !DILocation(line: 522, column: 156, scope: !40)
!350 = !DILocation(line: 522, column: 40, scope: !40)
!351 = !DILocation(line: 522, column: 199, scope: !40)
!352 = !DILocation(line: 522, column: 93, scope: !40)
!353 = !DILocation(line: 68, column: 3, scope: !354, inlinedAt: !355)
!354 = distinct !DISubprogram(name: "__barrier_warp", scope: !292, file: !292, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!355 = distinct !DILocation(line: 192, column: 3, scope: !356, inlinedAt: !357)
!356 = distinct !DISubprogram(name: "__syncwarp", scope: !292, file: !292, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!357 = distinct !DILocation(line: 524, column: 3, scope: !40)
!358 = !DILocation(line: 69, column: 3, scope: !354, inlinedAt: !355)
!359 = !DILocation(line: 70, column: 3, scope: !354, inlinedAt: !355)
!360 = !DILocation(line: 526, column: 8, scope: !40)
!361 = !DILocation(line: 526, column: 3, scope: !40)
!362 = !DILocation(line: 527, column: 22, scope: !40)
!363 = !DILocation(line: 527, column: 132, scope: !40)
!364 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!365 = !{i32 2, i32 -1, i32 -1, i32 -1}
!366 = !DILocation(line: 527, column: 169, scope: !40)
!367 = !DILocation(line: 529, column: 1, scope: !40)
