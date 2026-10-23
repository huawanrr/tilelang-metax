; ModuleID = 'experiments/20261015_goal8933/complete_binary/oj12_m2_p1.bc'
source_filename = "/tmp/tmpkje91kx0/tvm_kernels.maca"
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
  %cond.i.i1897 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64), !dbg !49
  %mul11 = shl nsw i32 %cond.i.i1897, 4, !dbg !52
  %4 = or disjoint i64 %2, 1, !dbg !53
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4, !dbg !43
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !dbg !43, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i1897.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64), !dbg !49
  %mul11.1 = shl nsw i32 %cond.i.i1897.1, 4, !dbg !52
  %6 = or disjoint i64 %2, 2, !dbg !53
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6, !dbg !43
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !dbg !43, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i1897.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64), !dbg !49
  %mul11.2 = shl nsw i32 %cond.i.i1897.2, 4, !dbg !52
  %8 = or disjoint i64 %2, 3, !dbg !53
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8, !dbg !43
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !dbg !43, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i1897.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64), !dbg !49
  %mul11.3 = shl nsw i32 %cond.i.i1897.3, 4, !dbg !52
  %10 = or disjoint i64 %2, 4, !dbg !53
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10, !dbg !43
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !dbg !43, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i1897.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64), !dbg !49
  %mul11.4 = shl nsw i32 %cond.i.i1897.4, 4, !dbg !52
  %12 = or disjoint i64 %2, 5, !dbg !53
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12, !dbg !43
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !dbg !43, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i1897.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64), !dbg !49
  %mul11.5 = shl nsw i32 %cond.i.i1897.5, 4, !dbg !52
  %14 = or disjoint i64 %2, 6, !dbg !53
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14, !dbg !43
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !dbg !43, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i1897.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64), !dbg !49
  %mul11.6 = shl nsw i32 %cond.i.i1897.6, 4, !dbg !52
  %16 = or disjoint i64 %2, 7, !dbg !53
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16, !dbg !43
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !dbg !43, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i1897.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64), !dbg !49
  %mul11.7 = shl nsw i32 %cond.i.i1897.7, 4, !dbg !52
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
  %invariant.op = add nsw i32 %1, -15, !dbg !58
  %invariant.smin = tail call i32 @llvm.smin.i32(i32 %invariant.op, i32 1008), !dbg !58
  %mul125 = shl nsw i32 %0, 16
  %mul132 = shl nuw nsw i32 %18, 3
  %add128 = or disjoint i32 %mul132, %mul125
  %22 = lshr i32 %18, 2
  %mul827 = and i32 %22, 252
  %or.cond2030 = icmp ugt i32 %mul11, 1008, !dbg !59
  %cmp95.not = icmp sgt i32 %mul11, %invariant.op
  %or.cond2031.not2054.not2056.not2058.not2062.not2066.not2072 = select i1 %or.cond2030, i1 true, i1 %cmp95.not
  %cmp97 = icmp slt i32 %5, 0
  %or.cond = icmp sgt i32 %mul11.1, %invariant.smin
  %.not2059.not2063.not2067.not2073 = or i1 %cmp97, %or.cond
  %or.cond2033.not2057.not2061.not2065.not2071 = select i1 %or.cond2031.not2054.not2056.not2058.not2062.not2066.not2072, i1 true, i1 %.not2059.not2063.not2067.not2073
  %cmp105 = icmp slt i32 %7, 0
  %or.cond1904 = icmp sgt i32 %mul11.2, %invariant.smin
  %.not2068.not2074 = or i1 %cmp105, %or.cond1904, !dbg !59
  %or.cond2035.not2064.not2070 = select i1 %or.cond2033.not2057.not2061.not2065.not2071, i1 true, i1 %.not2068.not2074
  %cmp113 = icmp slt i32 %9, 0
  %or.cond1905 = icmp sgt i32 %mul11.3, %invariant.smin
  %23 = or i1 %cmp113, %or.cond1905, !dbg !59
  %or.cond2037 = select i1 %or.cond2035.not2064.not2070, i1 true, i1 %23, !dbg !59
  br i1 %or.cond2037, label %if.else, label %for.cond120.preheader, !dbg !59

for.cond120.preheader:                            ; preds = %entry
  %24 = shl nsw i32 %cond.i.i1897, 10
  %mul127 = and i32 %24, 64512
  %add130 = add nuw nsw i32 %add128, %mul127
  %25 = zext nneg i32 %add130 to i64, !dbg !60
  %add.ptr135 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %25, !dbg !61
  %K_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr135, align 16, !dbg !62
  %K_reg.sroa.10.0.add.ptr135.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr135, i64 8, !dbg !62
  %K_reg.sroa.10.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg.sroa.10.0.add.ptr135.sroa_idx, align 8, !dbg !62
  %26 = add nuw nsw i64 %25, 512, !dbg !63
  %add.ptr135.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %26, !dbg !61
  %K_reg.sroa.14.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr135.1, align 16, !dbg !62
  %K_reg.sroa.22.16.add.ptr135.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr135.1, i64 8, !dbg !62
  %K_reg.sroa.22.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg.sroa.22.16.add.ptr135.1.sroa_idx, align 8, !dbg !62
  %27 = shl nuw nsw i32 %cond.i.i1897.1, 10
  %add153 = add nuw nsw i32 %add128, %27
  %28 = zext nneg i32 %add153 to i64, !dbg !64
  %add.ptr158 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %28, !dbg !65
  %K_reg1.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr158, align 16, !dbg !66
  %K_reg1.sroa.10.0.add.ptr158.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr158, i64 8, !dbg !66
  %K_reg1.sroa.10.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.10.0.add.ptr158.sroa_idx, align 8, !dbg !66
  %29 = add nuw nsw i64 %28, 512, !dbg !67
  %add.ptr158.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %29, !dbg !65
  %K_reg1.sroa.14.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr158.1, align 16, !dbg !66
  %K_reg1.sroa.22.16.add.ptr158.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr158.1, i64 8, !dbg !66
  %K_reg1.sroa.22.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.22.16.add.ptr158.1.sroa_idx, align 8, !dbg !66
  %30 = shl nuw nsw i32 %cond.i.i1897.2, 10
  %add176 = add nuw nsw i32 %add128, %30
  %31 = zext nneg i32 %add176 to i64, !dbg !68
  %add.ptr181 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %31, !dbg !69
  %K_reg2.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr181, align 16, !dbg !70
  %K_reg2.sroa.10.0.add.ptr181.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr181, i64 8, !dbg !70
  %K_reg2.sroa.10.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.10.0.add.ptr181.sroa_idx, align 8, !dbg !70
  %32 = add nuw nsw i64 %31, 512, !dbg !71
  %add.ptr181.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %32, !dbg !69
  %K_reg2.sroa.14.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr181.1, align 16, !dbg !70
  %K_reg2.sroa.22.16.add.ptr181.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr181.1, i64 8, !dbg !70
  %K_reg2.sroa.22.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.22.16.add.ptr181.1.sroa_idx, align 8, !dbg !70
  %33 = shl nuw nsw i32 %cond.i.i1897.3, 10
  %add199 = add nuw nsw i32 %add128, %33
  %34 = zext nneg i32 %add199 to i64, !dbg !72
  %add.ptr204 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %34, !dbg !73
  %K_reg3.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr204, align 16, !dbg !74
  %K_reg3.sroa.10.0.add.ptr204.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr204, i64 8, !dbg !74
  %K_reg3.sroa.10.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.10.0.add.ptr204.sroa_idx, align 8, !dbg !74
  %35 = add nuw nsw i64 %34, 512, !dbg !75
  %add.ptr204.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %35, !dbg !73
  %K_reg3.sroa.14.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr204.1, align 16, !dbg !74
  %K_reg3.sroa.22.16.add.ptr204.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr204.1, i64 8, !dbg !74
  %K_reg3.sroa.22.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.22.16.add.ptr204.1.sroa_idx, align 8, !dbg !74
  %add.ptr227 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %25, !dbg !76
  %V_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr227, align 16, !dbg !77
  %V_reg.sroa.34.0.add.ptr227.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr227, i64 8, !dbg !77
  %V_reg.sroa.34.0.copyload = load <4 x half>, ptr addrspace(4) %V_reg.sroa.34.0.add.ptr227.sroa_idx, align 8, !dbg !77
  %add.ptr227.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %26, !dbg !76
  %V_reg.sroa.50.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr227.1, align 16, !dbg !77
  %V_reg.sroa.82.16.add.ptr227.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr227.1, i64 8, !dbg !77
  %V_reg.sroa.82.16.copyload = load <4 x half>, ptr addrspace(4) %V_reg.sroa.82.16.add.ptr227.1.sroa_idx, align 8, !dbg !77
  %36 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !78, !call_argsrelate !79
  %37 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.10.0.copyload, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %36), !dbg !78, !call_argsrelate !79
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.14.16.copyload, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %37), !dbg !78, !call_argsrelate !79
  %39 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.22.16.copyload, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %38), !dbg !78, !call_argsrelate !79
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %39, i64 0, !dbg !80
  %mul273 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !81
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul273, float 0x4024CB5EC0000000), !dbg !82
  %41 = tail call contract noundef float @llvm.exp.f32(float %40), !dbg !85
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %39, i64 1, !dbg !80
  %mul273.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !81
  %42 = tail call contract noundef float @llvm.minnum.f32(float %mul273.1, float 0x4024CB5EC0000000), !dbg !82
  %43 = tail call contract noundef float @llvm.exp.f32(float %42), !dbg !85
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %39, i64 2, !dbg !80
  %mul273.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !81
  %44 = tail call contract noundef float @llvm.minnum.f32(float %mul273.2, float 0x4024CB5EC0000000), !dbg !82
  %45 = tail call contract noundef float @llvm.exp.f32(float %44), !dbg !85
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %39, i64 3, !dbg !80
  %mul273.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !81
  %46 = tail call contract noundef float @llvm.minnum.f32(float %mul273.3, float 0x4024CB5EC0000000), !dbg !82
  %47 = tail call contract noundef float @llvm.exp.f32(float %46), !dbg !85
  %48 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %41), !dbg !88
  %49 = insertelement <4 x i16> poison, i16 %48, i64 0, !dbg !97
  %50 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %43), !dbg !88
  %51 = insertelement <4 x i16> %49, i16 %50, i64 1, !dbg !97
  %52 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %45), !dbg !88
  %53 = insertelement <4 x i16> %51, i16 %52, i64 2, !dbg !97
  %54 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %47), !dbg !88
  %55 = insertelement <4 x i16> %53, i16 %54, i64 3, !dbg !97
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %55 to <4 x half>, !dbg !97
  %56 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !98, !call_argsrelate !99
  %57 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.34.0.copyload, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !98, !call_argsrelate !99
  %58 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.50.16.copyload, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !98, !call_argsrelate !99
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.82.16.copyload, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !98, !call_argsrelate !99
  %add.ptr340 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %28, !dbg !100
  %V_reg.sroa.0.0.copyload3101 = load <4 x half>, ptr addrspace(4) %add.ptr340, align 16, !dbg !101
  %V_reg.sroa.34.0.add.ptr340.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr340, i64 8, !dbg !101
  %V_reg.sroa.34.0.copyload3116 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.34.0.add.ptr340.sroa_idx, align 8, !dbg !101
  %add.ptr340.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %29, !dbg !100
  %V_reg.sroa.50.16.copyload3161 = load <4 x half>, ptr addrspace(4) %add.ptr340.1, align 16, !dbg !101
  %V_reg.sroa.82.16.add.ptr340.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr340.1, i64 8, !dbg !101
  %V_reg.sroa.82.16.copyload3176 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.82.16.add.ptr340.1.sroa_idx, align 8, !dbg !101
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !102, !call_argsrelate !79
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.10.0.copyload, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %60), !dbg !102, !call_argsrelate !79
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.14.16.copyload, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %61), !dbg !102, !call_argsrelate !79
  %63 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.22.16.copyload, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %62), !dbg !102, !call_argsrelate !79
  %acc_s.sroa.0.0.vec.extract2416 = extractelement <4 x float> %63, i64 0, !dbg !103
  %mul386 = fmul contract float %acc_s.sroa.0.0.vec.extract2416, 0x3FB99999A0000000, !dbg !104
  %64 = tail call contract noundef float @llvm.minnum.f32(float %mul386, float 0x4024CB5EC0000000), !dbg !105
  %65 = tail call contract noundef float @llvm.exp.f32(float %64), !dbg !107
  %acc_s.sroa.0.4.vec.extract2605 = extractelement <4 x float> %63, i64 1, !dbg !103
  %mul386.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2605, 0x3FB99999A0000000, !dbg !104
  %66 = tail call contract noundef float @llvm.minnum.f32(float %mul386.1, float 0x4024CB5EC0000000), !dbg !105
  %67 = tail call contract noundef float @llvm.exp.f32(float %66), !dbg !107
  %acc_s.sroa.0.8.vec.extract2778 = extractelement <4 x float> %63, i64 2, !dbg !103
  %mul386.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2778, 0x3FB99999A0000000, !dbg !104
  %68 = tail call contract noundef float @llvm.minnum.f32(float %mul386.2, float 0x4024CB5EC0000000), !dbg !105
  %69 = tail call contract noundef float @llvm.exp.f32(float %68), !dbg !107
  %acc_s.sroa.0.12.vec.extract2951 = extractelement <4 x float> %63, i64 3, !dbg !103
  %mul386.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2951, 0x3FB99999A0000000, !dbg !104
  %70 = tail call contract noundef float @llvm.minnum.f32(float %mul386.3, float 0x4024CB5EC0000000), !dbg !105
  %71 = tail call contract noundef float @llvm.exp.f32(float %70), !dbg !107
  %add402 = fadd contract float %41, %65, !dbg !109
  %add402.1 = fadd contract float %43, %67, !dbg !109
  %add402.2 = fadd contract float %45, %69, !dbg !109
  %add402.3 = fadd contract float %47, %71, !dbg !109
  %72 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %65), !dbg !110
  %73 = insertelement <4 x i16> poison, i16 %72, i64 0, !dbg !114
  %74 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %67), !dbg !110
  %75 = insertelement <4 x i16> %73, i16 %74, i64 1, !dbg !114
  %76 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %69), !dbg !110
  %77 = insertelement <4 x i16> %75, i16 %76, i64 2, !dbg !114
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %71), !dbg !110
  %79 = insertelement <4 x i16> %77, i16 %78, i64 3, !dbg !114
  %acc_s_cast.sroa.0.6.vec.insert2349 = bitcast <4 x i16> %79 to <4 x half>, !dbg !114
  %80 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload3101, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2349, <4 x float> zeroinitializer), !dbg !115, !call_argsrelate !99
  %81 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.34.0.copyload3116, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2349, <4 x float> zeroinitializer), !dbg !115, !call_argsrelate !99
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.50.16.copyload3161, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2349, <4 x float> zeroinitializer), !dbg !115, !call_argsrelate !99
  %83 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.82.16.copyload3176, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2349, <4 x float> zeroinitializer), !dbg !115, !call_argsrelate !99
  %add.ptr453 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %31, !dbg !116
  %V_reg.sroa.0.0.copyload3102 = load <4 x half>, ptr addrspace(4) %add.ptr453, align 16, !dbg !117
  %V_reg.sroa.34.0.add.ptr453.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr453, i64 8, !dbg !117
  %V_reg.sroa.34.0.copyload3117 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.34.0.add.ptr453.sroa_idx, align 8, !dbg !117
  %add.ptr453.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %32, !dbg !116
  %V_reg.sroa.50.16.copyload3162 = load <4 x half>, ptr addrspace(4) %add.ptr453.1, align 16, !dbg !117
  %V_reg.sroa.82.16.add.ptr453.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr453.1, i64 8, !dbg !117
  %V_reg.sroa.82.16.copyload3177 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.82.16.add.ptr453.1.sroa_idx, align 8, !dbg !117
  %84 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !118, !call_argsrelate !79
  %85 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.10.0.copyload, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %84), !dbg !118, !call_argsrelate !79
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.14.16.copyload, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %85), !dbg !118, !call_argsrelate !79
  %87 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.22.16.copyload, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %86), !dbg !118, !call_argsrelate !79
  %acc_s.sroa.0.0.vec.extract2424 = extractelement <4 x float> %87, i64 0, !dbg !119
  %mul499 = fmul contract float %acc_s.sroa.0.0.vec.extract2424, 0x3FB99999A0000000, !dbg !120
  %88 = tail call contract noundef float @llvm.minnum.f32(float %mul499, float 0x4024CB5EC0000000), !dbg !121
  %89 = tail call contract noundef float @llvm.exp.f32(float %88), !dbg !123
  %acc_s.sroa.0.4.vec.extract2613 = extractelement <4 x float> %87, i64 1, !dbg !119
  %mul499.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2613, 0x3FB99999A0000000, !dbg !120
  %90 = tail call contract noundef float @llvm.minnum.f32(float %mul499.1, float 0x4024CB5EC0000000), !dbg !121
  %91 = tail call contract noundef float @llvm.exp.f32(float %90), !dbg !123
  %acc_s.sroa.0.8.vec.extract2786 = extractelement <4 x float> %87, i64 2, !dbg !119
  %mul499.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2786, 0x3FB99999A0000000, !dbg !120
  %92 = tail call contract noundef float @llvm.minnum.f32(float %mul499.2, float 0x4024CB5EC0000000), !dbg !121
  %93 = tail call contract noundef float @llvm.exp.f32(float %92), !dbg !123
  %acc_s.sroa.0.12.vec.extract2959 = extractelement <4 x float> %87, i64 3, !dbg !119
  %mul499.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2959, 0x3FB99999A0000000, !dbg !120
  %94 = tail call contract noundef float @llvm.minnum.f32(float %mul499.3, float 0x4024CB5EC0000000), !dbg !121
  %95 = tail call contract noundef float @llvm.exp.f32(float %94), !dbg !123
  %add515 = fadd contract float %add402, %89, !dbg !125
  %add515.1 = fadd contract float %add402.1, %91, !dbg !125
  %add515.2 = fadd contract float %add402.2, %93, !dbg !125
  %add515.3 = fadd contract float %add402.3, %95, !dbg !125
  %96 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %89), !dbg !126
  %97 = insertelement <4 x i16> poison, i16 %96, i64 0, !dbg !130
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %91), !dbg !126
  %99 = insertelement <4 x i16> %97, i16 %98, i64 1, !dbg !130
  %100 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %93), !dbg !126
  %101 = insertelement <4 x i16> %99, i16 %100, i64 2, !dbg !130
  %102 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %95), !dbg !126
  %103 = insertelement <4 x i16> %101, i16 %102, i64 3, !dbg !130
  %acc_s_cast.sroa.0.6.vec.insert2351 = bitcast <4 x i16> %103 to <4 x half>, !dbg !130
  %104 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload3102, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2351, <4 x float> %56), !dbg !131, !call_argsrelate !99
  %105 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.34.0.copyload3117, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2351, <4 x float> %57), !dbg !131, !call_argsrelate !99
  %106 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.50.16.copyload3162, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2351, <4 x float> %58), !dbg !131, !call_argsrelate !99
  %107 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.82.16.copyload3177, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2351, <4 x float> %59), !dbg !131, !call_argsrelate !99
  %add.ptr566 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %34, !dbg !132
  %V_reg.sroa.0.0.copyload3103 = load <4 x half>, ptr addrspace(4) %add.ptr566, align 16, !dbg !133
  %V_reg.sroa.34.0.add.ptr566.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr566, i64 8, !dbg !133
  %V_reg.sroa.34.0.copyload3118 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.34.0.add.ptr566.sroa_idx, align 8, !dbg !133
  %add.ptr566.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %35, !dbg !132
  %V_reg.sroa.50.16.copyload3163 = load <4 x half>, ptr addrspace(4) %add.ptr566.1, align 16, !dbg !133
  %V_reg.sroa.82.16.add.ptr566.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr566.1, i64 8, !dbg !133
  %V_reg.sroa.82.16.copyload3178 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.82.16.add.ptr566.1.sroa_idx, align 8, !dbg !133
  %108 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !134, !call_argsrelate !79
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.10.0.copyload, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %108), !dbg !134, !call_argsrelate !79
  %110 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.14.16.copyload, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %109), !dbg !134, !call_argsrelate !79
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.22.16.copyload, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %110), !dbg !134, !call_argsrelate !79
  %acc_s.sroa.0.0.vec.extract2432 = extractelement <4 x float> %111, i64 0, !dbg !135
  %mul612 = fmul contract float %acc_s.sroa.0.0.vec.extract2432, 0x3FB99999A0000000, !dbg !136
  %112 = tail call contract noundef float @llvm.minnum.f32(float %mul612, float 0x4024CB5EC0000000), !dbg !137
  %113 = tail call contract noundef float @llvm.exp.f32(float %112), !dbg !139
  %acc_s.sroa.0.4.vec.extract2621 = extractelement <4 x float> %111, i64 1, !dbg !135
  %mul612.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2621, 0x3FB99999A0000000, !dbg !136
  %114 = tail call contract noundef float @llvm.minnum.f32(float %mul612.1, float 0x4024CB5EC0000000), !dbg !137
  %115 = tail call contract noundef float @llvm.exp.f32(float %114), !dbg !139
  %acc_s.sroa.0.8.vec.extract2794 = extractelement <4 x float> %111, i64 2, !dbg !135
  %mul612.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2794, 0x3FB99999A0000000, !dbg !136
  %116 = tail call contract noundef float @llvm.minnum.f32(float %mul612.2, float 0x4024CB5EC0000000), !dbg !137
  %117 = tail call contract noundef float @llvm.exp.f32(float %116), !dbg !139
  %acc_s.sroa.0.12.vec.extract2967 = extractelement <4 x float> %111, i64 3, !dbg !135
  %mul612.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2967, 0x3FB99999A0000000, !dbg !136
  %118 = tail call contract noundef float @llvm.minnum.f32(float %mul612.3, float 0x4024CB5EC0000000), !dbg !137
  %119 = tail call contract noundef float @llvm.exp.f32(float %118), !dbg !139
  %add628 = fadd contract float %add515, %113, !dbg !141
  %add628.1 = fadd contract float %add515.1, %115, !dbg !141
  %add628.2 = fadd contract float %add515.2, %117, !dbg !141
  %add628.3 = fadd contract float %add515.3, %119, !dbg !141
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %113), !dbg !142
  %121 = insertelement <4 x i16> poison, i16 %120, i64 0, !dbg !146
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %115), !dbg !142
  %123 = insertelement <4 x i16> %121, i16 %122, i64 1, !dbg !146
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %117), !dbg !142
  %125 = insertelement <4 x i16> %123, i16 %124, i64 2, !dbg !146
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %119), !dbg !142
  %127 = insertelement <4 x i16> %125, i16 %126, i64 3, !dbg !146
  %acc_s_cast.sroa.0.6.vec.insert2353 = bitcast <4 x i16> %127 to <4 x half>, !dbg !146
  %128 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload3103, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2353, <4 x float> %80), !dbg !147, !call_argsrelate !99
  %129 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.34.0.copyload3118, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2353, <4 x float> %81), !dbg !147, !call_argsrelate !99
  %130 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.50.16.copyload3163, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2353, <4 x float> %82), !dbg !147, !call_argsrelate !99
  %131 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.82.16.copyload3178, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2353, <4 x float> %83), !dbg !147, !call_argsrelate !99
  br label %if.end1371, !dbg !148

if.else:                                          ; preds = %entry
  %or.cond2038 = icmp ugt i32 %mul11, 1023, !dbg !149
  %cmp669.not = icmp sgt i32 %mul11, %1
  %or.cond2039 = or i1 %or.cond2038, %cmp669.not, !dbg !149
  br i1 %or.cond2039, label %if.end, label %for.cond671.preheader, !dbg !149

for.cond671.preheader:                            ; preds = %if.else
  %132 = shl nsw i32 %cond.i.i1897, 10
  %mul678 = and i32 %132, 64512
  %add681 = add nuw nsw i32 %add128, %mul678
  %133 = zext nneg i32 %add681 to i64, !dbg !150
  %add.ptr686 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %133, !dbg !151
  %K_reg.sroa.0.0.copyload3281 = load <4 x half>, ptr addrspace(4) %add.ptr686, align 16, !dbg !152
  %K_reg.sroa.10.0.add.ptr686.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr686, i64 8, !dbg !152
  %K_reg.sroa.10.0.copyload3284 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.10.0.add.ptr686.sroa_idx, align 8, !dbg !152
  %134 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %133, !dbg !151
  %add.ptr686.1 = getelementptr inbounds i8, ptr addrspace(4) %134, i64 1024, !dbg !151
  %K_reg.sroa.14.16.copyload3293 = load <4 x half>, ptr addrspace(4) %add.ptr686.1, align 16, !dbg !152
  %K_reg.sroa.22.16.add.ptr686.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %134, i64 1032, !dbg !152
  %K_reg.sroa.22.16.copyload3296 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.22.16.add.ptr686.1.sroa_idx, align 8, !dbg !152
  br label %if.end, !dbg !153

if.end:                                           ; preds = %for.cond671.preheader, %if.else
  %K_reg.sroa.22.0 = phi <4 x half> [ undef, %if.else ], [ %K_reg.sroa.22.16.copyload3296, %for.cond671.preheader ]
  %K_reg.sroa.14.0 = phi <4 x half> [ undef, %if.else ], [ %K_reg.sroa.14.16.copyload3293, %for.cond671.preheader ]
  %K_reg.sroa.10.0 = phi <4 x half> [ undef, %if.else ], [ %K_reg.sroa.10.0.copyload3284, %for.cond671.preheader ]
  %K_reg.sroa.0.0 = phi <4 x half> [ undef, %if.else ], [ %K_reg.sroa.0.0.copyload3281, %for.cond671.preheader ]
  %or.cond2040 = icmp ugt i32 %mul11.1, 1023, !dbg !153
  %cmp699.not = icmp sgt i32 %mul11.1, %1
  %or.cond2041 = or i1 %or.cond2040, %cmp699.not, !dbg !153
  br i1 %or.cond2041, label %if.end724, label %for.cond701.preheader, !dbg !153

for.cond701.preheader:                            ; preds = %if.end
  %135 = shl nsw i32 %cond.i.i1897.1, 10
  %mul708 = and i32 %135, 64512
  %add711 = add nuw nsw i32 %add128, %mul708
  %136 = zext nneg i32 %add711 to i64, !dbg !154
  %add.ptr716 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %136, !dbg !155
  %K_reg1.sroa.0.0.copyload3257 = load <4 x half>, ptr addrspace(4) %add.ptr716, align 16, !dbg !156
  %K_reg1.sroa.10.0.add.ptr716.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr716, i64 8, !dbg !156
  %K_reg1.sroa.10.0.copyload3260 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.10.0.add.ptr716.sroa_idx, align 8, !dbg !156
  %137 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %136, !dbg !155
  %add.ptr716.1 = getelementptr inbounds i8, ptr addrspace(4) %137, i64 1024, !dbg !155
  %K_reg1.sroa.14.16.copyload3269 = load <4 x half>, ptr addrspace(4) %add.ptr716.1, align 16, !dbg !156
  %K_reg1.sroa.22.16.add.ptr716.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %137, i64 1032, !dbg !156
  %K_reg1.sroa.22.16.copyload3272 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.22.16.add.ptr716.1.sroa_idx, align 8, !dbg !156
  br label %if.end724, !dbg !157

if.end724:                                        ; preds = %for.cond701.preheader, %if.end
  %K_reg1.sroa.22.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.22.16.copyload3272, %for.cond701.preheader ]
  %K_reg1.sroa.14.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.14.16.copyload3269, %for.cond701.preheader ]
  %K_reg1.sroa.10.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.10.0.copyload3260, %for.cond701.preheader ]
  %K_reg1.sroa.0.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.0.0.copyload3257, %for.cond701.preheader ]
  %or.cond2042 = icmp ugt i32 %mul11.2, 1023, !dbg !157
  %cmp730.not = icmp sgt i32 %mul11.2, %1
  %or.cond2043 = or i1 %or.cond2042, %cmp730.not, !dbg !157
  br i1 %or.cond2043, label %if.end755, label %for.cond732.preheader, !dbg !157

for.cond732.preheader:                            ; preds = %if.end724
  %138 = shl nsw i32 %cond.i.i1897.2, 10
  %mul739 = and i32 %138, 64512
  %add742 = add nuw nsw i32 %add128, %mul739
  %139 = zext nneg i32 %add742 to i64, !dbg !158
  %add.ptr747 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %139, !dbg !159
  %K_reg2.sroa.0.0.copyload3233 = load <4 x half>, ptr addrspace(4) %add.ptr747, align 16, !dbg !160
  %K_reg2.sroa.10.0.add.ptr747.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr747, i64 8, !dbg !160
  %K_reg2.sroa.10.0.copyload3236 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.10.0.add.ptr747.sroa_idx, align 8, !dbg !160
  %140 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %139, !dbg !159
  %add.ptr747.1 = getelementptr inbounds i8, ptr addrspace(4) %140, i64 1024, !dbg !159
  %K_reg2.sroa.14.16.copyload3245 = load <4 x half>, ptr addrspace(4) %add.ptr747.1, align 16, !dbg !160
  %K_reg2.sroa.22.16.add.ptr747.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %140, i64 1032, !dbg !160
  %K_reg2.sroa.22.16.copyload3248 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.22.16.add.ptr747.1.sroa_idx, align 8, !dbg !160
  br label %if.end755, !dbg !161

if.end755:                                        ; preds = %for.cond732.preheader, %if.end724
  %K_reg2.sroa.22.0 = phi <4 x half> [ undef, %if.end724 ], [ %K_reg2.sroa.22.16.copyload3248, %for.cond732.preheader ]
  %K_reg2.sroa.14.0 = phi <4 x half> [ undef, %if.end724 ], [ %K_reg2.sroa.14.16.copyload3245, %for.cond732.preheader ]
  %K_reg2.sroa.10.0 = phi <4 x half> [ undef, %if.end724 ], [ %K_reg2.sroa.10.0.copyload3236, %for.cond732.preheader ]
  %K_reg2.sroa.0.0 = phi <4 x half> [ undef, %if.end724 ], [ %K_reg2.sroa.0.0.copyload3233, %for.cond732.preheader ]
  %or.cond2044 = icmp ugt i32 %mul11.3, 1023, !dbg !161
  %cmp761.not = icmp sgt i32 %mul11.3, %1
  %or.cond2045 = or i1 %or.cond2044, %cmp761.not, !dbg !161
  br i1 %or.cond2045, label %if.end786, label %for.cond763.preheader, !dbg !161

for.cond763.preheader:                            ; preds = %if.end755
  %141 = shl nsw i32 %cond.i.i1897.3, 10
  %mul770 = and i32 %141, 64512
  %add773 = add nuw nsw i32 %add128, %mul770
  %142 = zext nneg i32 %add773 to i64, !dbg !162
  %add.ptr778 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %142, !dbg !163
  %K_reg3.sroa.0.0.copyload3209 = load <4 x half>, ptr addrspace(4) %add.ptr778, align 16, !dbg !164
  %K_reg3.sroa.10.0.add.ptr778.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr778, i64 8, !dbg !164
  %K_reg3.sroa.10.0.copyload3212 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.10.0.add.ptr778.sroa_idx, align 8, !dbg !164
  %143 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %142, !dbg !163
  %add.ptr778.1 = getelementptr inbounds i8, ptr addrspace(4) %143, i64 1024, !dbg !163
  %K_reg3.sroa.14.16.copyload3221 = load <4 x half>, ptr addrspace(4) %add.ptr778.1, align 16, !dbg !164
  %K_reg3.sroa.22.16.add.ptr778.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %143, i64 1032, !dbg !164
  %K_reg3.sroa.22.16.copyload3224 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.22.16.add.ptr778.1.sroa_idx, align 8, !dbg !164
  br label %if.end786, !dbg !165

if.end786:                                        ; preds = %for.cond763.preheader, %if.end755
  %K_reg3.sroa.22.0 = phi <4 x half> [ undef, %if.end755 ], [ %K_reg3.sroa.22.16.copyload3224, %for.cond763.preheader ]
  %K_reg3.sroa.14.0 = phi <4 x half> [ undef, %if.end755 ], [ %K_reg3.sroa.14.16.copyload3221, %for.cond763.preheader ]
  %K_reg3.sroa.10.0 = phi <4 x half> [ undef, %if.end755 ], [ %K_reg3.sroa.10.0.copyload3212, %for.cond763.preheader ]
  %K_reg3.sroa.0.0 = phi <4 x half> [ undef, %if.end755 ], [ %K_reg3.sroa.0.0.copyload3209, %for.cond763.preheader ]
  br i1 %or.cond2039, label %if.end932, label %for.cond794.preheader, !dbg !165

for.cond794.preheader:                            ; preds = %if.end786
  %144 = shl nsw i32 %cond.i.i1897, 10
  %mul801 = and i32 %144, 64512
  %add804 = add nuw nsw i32 %add128, %mul801
  %145 = zext nneg i32 %add804 to i64, !dbg !166
  %add.ptr809 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %145, !dbg !167
  %V_reg.sroa.0.0.copyload3104 = load <4 x half>, ptr addrspace(4) %add.ptr809, align 16, !dbg !168
  %V_reg.sroa.34.0.add.ptr809.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr809, i64 8, !dbg !168
  %V_reg.sroa.34.0.copyload3119 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.34.0.add.ptr809.sroa_idx, align 8, !dbg !168
  %146 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %145, !dbg !167
  %add.ptr809.1 = getelementptr inbounds i8, ptr addrspace(4) %146, i64 1024, !dbg !167
  %V_reg.sroa.50.16.copyload3164 = load <4 x half>, ptr addrspace(4) %add.ptr809.1, align 16, !dbg !168
  %V_reg.sroa.82.16.add.ptr809.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %146, i64 1032, !dbg !168
  %V_reg.sroa.82.16.copyload3179 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.82.16.add.ptr809.1.sroa_idx, align 8, !dbg !168
  br i1 %cmp95.not, label %for.cond821.preheader, label %if.end845, !dbg !169

for.cond821.preheader:                            ; preds = %for.cond794.preheader
  %add828 = add nuw nsw i32 %mul11, %mul827
  %cmp831.not = icmp sgt i32 %add828, %1, !dbg !170
  %fneg. = select i1 %cmp831.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2440 = insertelement <4 x float> poison, float %fneg., i64 0, !dbg !171
  %cmp831.not.1.not = icmp slt i32 %add828, %1, !dbg !170
  %fneg..1 = select i1 %cmp831.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2629 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2440, float %fneg..1, i64 1, !dbg !171
  %add829.2 = or disjoint i32 %add828, 2, !dbg !172
  %cmp831.not.2 = icmp sgt i32 %add829.2, %1, !dbg !170
  %fneg..2 = select i1 %cmp831.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2802 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2629, float %fneg..2, i64 2, !dbg !171
  %add829.3 = or disjoint i32 %add828, 3, !dbg !172
  %cmp831.not.3 = icmp sgt i32 %add829.3, %1, !dbg !170
  %fneg..3 = select i1 %cmp831.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2975 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2802, float %fneg..3, i64 3, !dbg !171
  br label %if.end845

if.end845:                                        ; preds = %for.cond794.preheader, %for.cond821.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2975, %for.cond821.preheader ], [ zeroinitializer, %for.cond794.preheader ], !dbg !173
  %147 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !dbg !174, !call_argsrelate !175
  %148 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.10.0, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %147), !dbg !174, !call_argsrelate !175
  %149 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.14.0, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %148), !dbg !174, !call_argsrelate !175
  %150 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.22.0, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %149), !dbg !174, !call_argsrelate !175
  %acc_s.sroa.0.0.vec.extract2442 = extractelement <4 x float> %150, i64 0, !dbg !176
  %mul880 = fmul contract float %acc_s.sroa.0.0.vec.extract2442, 0x3FB99999A0000000, !dbg !177
  %151 = tail call contract noundef float @llvm.minnum.f32(float %mul880, float 0x4024CB5EC0000000), !dbg !178
  %152 = tail call contract noundef float @llvm.exp.f32(float %151), !dbg !180
  %acc_s.sroa.0.4.vec.extract2631 = extractelement <4 x float> %150, i64 1, !dbg !176
  %mul880.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2631, 0x3FB99999A0000000, !dbg !177
  %153 = tail call contract noundef float @llvm.minnum.f32(float %mul880.1, float 0x4024CB5EC0000000), !dbg !178
  %154 = tail call contract noundef float @llvm.exp.f32(float %153), !dbg !180
  %acc_s.sroa.0.8.vec.extract2804 = extractelement <4 x float> %150, i64 2, !dbg !176
  %mul880.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2804, 0x3FB99999A0000000, !dbg !177
  %155 = tail call contract noundef float @llvm.minnum.f32(float %mul880.2, float 0x4024CB5EC0000000), !dbg !178
  %156 = tail call contract noundef float @llvm.exp.f32(float %155), !dbg !180
  %acc_s.sroa.0.12.vec.extract2977 = extractelement <4 x float> %150, i64 3, !dbg !176
  %mul880.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2977, 0x3FB99999A0000000, !dbg !177
  %157 = tail call contract noundef float @llvm.minnum.f32(float %mul880.3, float 0x4024CB5EC0000000), !dbg !178
  %158 = tail call contract noundef float @llvm.exp.f32(float %157), !dbg !180
  %159 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %152), !dbg !182
  %160 = insertelement <4 x i16> poison, i16 %159, i64 0, !dbg !186
  %161 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %154), !dbg !182
  %162 = insertelement <4 x i16> %160, i16 %161, i64 1, !dbg !186
  %163 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %156), !dbg !182
  %164 = insertelement <4 x i16> %162, i16 %163, i64 2, !dbg !186
  %165 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %158), !dbg !182
  %166 = insertelement <4 x i16> %164, i16 %165, i64 3, !dbg !186
  %acc_s_cast.sroa.0.6.vec.insert2355 = bitcast <4 x i16> %166 to <4 x half>, !dbg !186
  %167 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload3104, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2355, <4 x float> zeroinitializer), !dbg !187, !call_argsrelate !99
  %168 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.34.0.copyload3119, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2355, <4 x float> zeroinitializer), !dbg !187, !call_argsrelate !99
  %169 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.50.16.copyload3164, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2355, <4 x float> zeroinitializer), !dbg !187, !call_argsrelate !99
  %170 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.82.16.copyload3179, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2355, <4 x float> zeroinitializer), !dbg !187, !call_argsrelate !99
  br label %if.end932, !dbg !188

if.end932:                                        ; preds = %if.end845, %if.end786
  %acc_o.sroa.122.0 = phi <4 x float> [ zeroinitializer, %if.end786 ], [ %170, %if.end845 ], !dbg !173
  %acc_o.sroa.82.0 = phi <4 x float> [ zeroinitializer, %if.end786 ], [ %169, %if.end845 ], !dbg !173
  %acc_o.sroa.42.0 = phi <4 x float> [ zeroinitializer, %if.end786 ], [ %168, %if.end845 ], !dbg !173
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end786 ], [ %167, %if.end845 ], !dbg !173
  %sum_acc.sroa.104.0 = phi float [ 0.000000e+00, %if.end786 ], [ %158, %if.end845 ], !dbg !173
  %sum_acc.sroa.70.0 = phi float [ 0.000000e+00, %if.end786 ], [ %156, %if.end845 ], !dbg !173
  %sum_acc.sroa.36.0 = phi float [ 0.000000e+00, %if.end786 ], [ %154, %if.end845 ], !dbg !173
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %if.end786 ], [ %152, %if.end845 ], !dbg !173
  br i1 %or.cond2041, label %if.end1078, label %for.cond940.preheader, !dbg !188

for.cond940.preheader:                            ; preds = %if.end932
  %171 = shl nsw i32 %cond.i.i1897.1, 10
  %mul947 = and i32 %171, 64512
  %add950 = add nuw nsw i32 %add128, %mul947
  %172 = zext nneg i32 %add950 to i64, !dbg !189
  %add.ptr955 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %172, !dbg !190
  %V_reg.sroa.0.0.copyload3105 = load <4 x half>, ptr addrspace(4) %add.ptr955, align 16, !dbg !191
  %V_reg.sroa.34.0.add.ptr955.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr955, i64 8, !dbg !191
  %V_reg.sroa.34.0.copyload3120 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.34.0.add.ptr955.sroa_idx, align 8, !dbg !191
  %173 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %172, !dbg !190
  %add.ptr955.1 = getelementptr inbounds i8, ptr addrspace(4) %173, i64 1024, !dbg !190
  %V_reg.sroa.50.16.copyload3165 = load <4 x half>, ptr addrspace(4) %add.ptr955.1, align 16, !dbg !191
  %V_reg.sroa.82.16.add.ptr955.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %173, i64 1032, !dbg !191
  %V_reg.sroa.82.16.copyload3180 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.82.16.add.ptr955.1.sroa_idx, align 8, !dbg !191
  %cmp965 = icmp sgt i32 %mul11.1, %invariant.op, !dbg !192
  br i1 %cmp965, label %for.cond967.preheader, label %if.end991, !dbg !193

for.cond967.preheader:                            ; preds = %for.cond940.preheader
  %add974 = add nuw nsw i32 %mul11.1, %mul827
  %cmp977.not = icmp sgt i32 %add974, %1, !dbg !194
  %fneg.1886 = select i1 %cmp977.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2450 = insertelement <4 x float> poison, float %fneg.1886, i64 0, !dbg !195
  %cmp977.not.1.not = icmp slt i32 %add974, %1, !dbg !194
  %fneg.1886.1 = select i1 %cmp977.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2639 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2450, float %fneg.1886.1, i64 1, !dbg !195
  %add975.2 = or disjoint i32 %add974, 2, !dbg !196
  %cmp977.not.2 = icmp sgt i32 %add975.2, %1, !dbg !194
  %fneg.1886.2 = select i1 %cmp977.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2812 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2639, float %fneg.1886.2, i64 2, !dbg !195
  %add975.3 = or disjoint i32 %add974, 3, !dbg !196
  %cmp977.not.3 = icmp sgt i32 %add975.3, %1, !dbg !194
  %fneg.1886.3 = select i1 %cmp977.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2985 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2812, float %fneg.1886.3, i64 3, !dbg !195
  br label %if.end991

if.end991:                                        ; preds = %for.cond940.preheader, %for.cond967.preheader
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2985, %for.cond967.preheader ], [ zeroinitializer, %for.cond940.preheader ], !dbg !173
  %174 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.2), !dbg !197, !call_argsrelate !175
  %175 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.10.0, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %174), !dbg !197, !call_argsrelate !175
  %176 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.14.0, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %175), !dbg !197, !call_argsrelate !175
  %177 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.22.0, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %176), !dbg !197, !call_argsrelate !175
  %acc_s.sroa.0.0.vec.extract2452 = extractelement <4 x float> %177, i64 0, !dbg !198
  %mul1026 = fmul contract float %acc_s.sroa.0.0.vec.extract2452, 0x3FB99999A0000000, !dbg !199
  %178 = tail call contract noundef float @llvm.minnum.f32(float %mul1026, float 0x4024CB5EC0000000), !dbg !200
  %179 = tail call contract noundef float @llvm.exp.f32(float %178), !dbg !202
  %acc_s.sroa.0.4.vec.extract2641 = extractelement <4 x float> %177, i64 1, !dbg !198
  %mul1026.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2641, 0x3FB99999A0000000, !dbg !199
  %180 = tail call contract noundef float @llvm.minnum.f32(float %mul1026.1, float 0x4024CB5EC0000000), !dbg !200
  %181 = tail call contract noundef float @llvm.exp.f32(float %180), !dbg !202
  %acc_s.sroa.0.8.vec.extract2814 = extractelement <4 x float> %177, i64 2, !dbg !198
  %mul1026.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2814, 0x3FB99999A0000000, !dbg !199
  %182 = tail call contract noundef float @llvm.minnum.f32(float %mul1026.2, float 0x4024CB5EC0000000), !dbg !200
  %183 = tail call contract noundef float @llvm.exp.f32(float %182), !dbg !202
  %acc_s.sroa.0.12.vec.extract2987 = extractelement <4 x float> %177, i64 3, !dbg !198
  %mul1026.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2987, 0x3FB99999A0000000, !dbg !199
  %184 = tail call contract noundef float @llvm.minnum.f32(float %mul1026.3, float 0x4024CB5EC0000000), !dbg !200
  %185 = tail call contract noundef float @llvm.exp.f32(float %184), !dbg !202
  %add1042 = fadd contract float %sum_acc.sroa.0.0, %179, !dbg !204
  %add1042.1 = fadd contract float %sum_acc.sroa.36.0, %181, !dbg !204
  %add1042.2 = fadd contract float %sum_acc.sroa.70.0, %183, !dbg !204
  %add1042.3 = fadd contract float %sum_acc.sroa.104.0, %185, !dbg !204
  %186 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %179), !dbg !205
  %187 = insertelement <4 x i16> poison, i16 %186, i64 0, !dbg !209
  %188 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %181), !dbg !205
  %189 = insertelement <4 x i16> %187, i16 %188, i64 1, !dbg !209
  %190 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %183), !dbg !205
  %191 = insertelement <4 x i16> %189, i16 %190, i64 2, !dbg !209
  %192 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %185), !dbg !205
  %193 = insertelement <4 x i16> %191, i16 %192, i64 3, !dbg !209
  %acc_s_cast.sroa.0.6.vec.insert2357 = bitcast <4 x i16> %193 to <4 x half>, !dbg !209
  %194 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload3105, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2357, <4 x float> zeroinitializer), !dbg !210, !call_argsrelate !99
  %195 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.34.0.copyload3120, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2357, <4 x float> zeroinitializer), !dbg !210, !call_argsrelate !99
  %196 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.50.16.copyload3165, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2357, <4 x float> zeroinitializer), !dbg !210, !call_argsrelate !99
  %197 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.82.16.copyload3180, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2357, <4 x float> zeroinitializer), !dbg !210, !call_argsrelate !99
  br label %if.end1078, !dbg !211

if.end1078:                                       ; preds = %if.end991, %if.end932
  %acc_o_alt.sroa.74.0 = phi <4 x float> [ zeroinitializer, %if.end932 ], [ %197, %if.end991 ], !dbg !173
  %acc_o_alt.sroa.50.0 = phi <4 x float> [ zeroinitializer, %if.end932 ], [ %196, %if.end991 ], !dbg !173
  %acc_o_alt.sroa.26.0 = phi <4 x float> [ zeroinitializer, %if.end932 ], [ %195, %if.end991 ], !dbg !173
  %acc_o_alt.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end932 ], [ %194, %if.end991 ], !dbg !173
  %sum_acc.sroa.104.1 = phi float [ %sum_acc.sroa.104.0, %if.end932 ], [ %add1042.3, %if.end991 ], !dbg !173
  %sum_acc.sroa.70.1 = phi float [ %sum_acc.sroa.70.0, %if.end932 ], [ %add1042.2, %if.end991 ], !dbg !173
  %sum_acc.sroa.36.1 = phi float [ %sum_acc.sroa.36.0, %if.end932 ], [ %add1042.1, %if.end991 ], !dbg !173
  %sum_acc.sroa.0.1 = phi float [ %sum_acc.sroa.0.0, %if.end932 ], [ %add1042, %if.end991 ], !dbg !173
  br i1 %or.cond2043, label %if.end1224, label %for.cond1086.preheader, !dbg !211

for.cond1086.preheader:                           ; preds = %if.end1078
  %198 = shl nsw i32 %cond.i.i1897.2, 10
  %mul1093 = and i32 %198, 64512
  %add1096 = add nuw nsw i32 %add128, %mul1093
  %199 = zext nneg i32 %add1096 to i64, !dbg !212
  %add.ptr1101 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %199, !dbg !213
  %V_reg.sroa.0.0.copyload3106 = load <4 x half>, ptr addrspace(4) %add.ptr1101, align 16, !dbg !214
  %V_reg.sroa.34.0.add.ptr1101.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1101, i64 8, !dbg !214
  %V_reg.sroa.34.0.copyload3121 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.34.0.add.ptr1101.sroa_idx, align 8, !dbg !214
  %200 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %199, !dbg !213
  %add.ptr1101.1 = getelementptr inbounds i8, ptr addrspace(4) %200, i64 1024, !dbg !213
  %V_reg.sroa.50.16.copyload3166 = load <4 x half>, ptr addrspace(4) %add.ptr1101.1, align 16, !dbg !214
  %V_reg.sroa.82.16.add.ptr1101.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %200, i64 1032, !dbg !214
  %V_reg.sroa.82.16.copyload3181 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.82.16.add.ptr1101.1.sroa_idx, align 8, !dbg !214
  %cmp1111 = icmp sgt i32 %mul11.2, %invariant.op, !dbg !215
  br i1 %cmp1111, label %for.cond1113.preheader, label %if.end1137, !dbg !216

for.cond1113.preheader:                           ; preds = %for.cond1086.preheader
  %add1120 = add nuw nsw i32 %mul11.2, %mul827
  %cmp1123.not = icmp sgt i32 %add1120, %1, !dbg !217
  %fneg.1887 = select i1 %cmp1123.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2460 = insertelement <4 x float> poison, float %fneg.1887, i64 0, !dbg !218
  %cmp1123.not.1.not = icmp slt i32 %add1120, %1, !dbg !217
  %fneg.1887.1 = select i1 %cmp1123.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2649 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2460, float %fneg.1887.1, i64 1, !dbg !218
  %add1121.2 = or disjoint i32 %add1120, 2, !dbg !219
  %cmp1123.not.2 = icmp sgt i32 %add1121.2, %1, !dbg !217
  %fneg.1887.2 = select i1 %cmp1123.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2822 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2649, float %fneg.1887.2, i64 2, !dbg !218
  %add1121.3 = or disjoint i32 %add1120, 3, !dbg !219
  %cmp1123.not.3 = icmp sgt i32 %add1121.3, %1, !dbg !217
  %fneg.1887.3 = select i1 %cmp1123.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2995 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2822, float %fneg.1887.3, i64 3, !dbg !218
  br label %if.end1137

if.end1137:                                       ; preds = %for.cond1086.preheader, %for.cond1113.preheader
  %acc_s.sroa.0.4 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2995, %for.cond1113.preheader ], [ zeroinitializer, %for.cond1086.preheader ], !dbg !173
  %201 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.4), !dbg !220, !call_argsrelate !175
  %202 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.10.0, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %201), !dbg !220, !call_argsrelate !175
  %203 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.14.0, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %202), !dbg !220, !call_argsrelate !175
  %204 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.22.0, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %203), !dbg !220, !call_argsrelate !175
  %acc_s.sroa.0.0.vec.extract2462 = extractelement <4 x float> %204, i64 0, !dbg !221
  %mul1172 = fmul contract float %acc_s.sroa.0.0.vec.extract2462, 0x3FB99999A0000000, !dbg !222
  %205 = tail call contract noundef float @llvm.minnum.f32(float %mul1172, float 0x4024CB5EC0000000), !dbg !223
  %206 = tail call contract noundef float @llvm.exp.f32(float %205), !dbg !225
  %acc_s.sroa.0.4.vec.extract2651 = extractelement <4 x float> %204, i64 1, !dbg !221
  %mul1172.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2651, 0x3FB99999A0000000, !dbg !222
  %207 = tail call contract noundef float @llvm.minnum.f32(float %mul1172.1, float 0x4024CB5EC0000000), !dbg !223
  %208 = tail call contract noundef float @llvm.exp.f32(float %207), !dbg !225
  %acc_s.sroa.0.8.vec.extract2824 = extractelement <4 x float> %204, i64 2, !dbg !221
  %mul1172.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2824, 0x3FB99999A0000000, !dbg !222
  %209 = tail call contract noundef float @llvm.minnum.f32(float %mul1172.2, float 0x4024CB5EC0000000), !dbg !223
  %210 = tail call contract noundef float @llvm.exp.f32(float %209), !dbg !225
  %acc_s.sroa.0.12.vec.extract2997 = extractelement <4 x float> %204, i64 3, !dbg !221
  %mul1172.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2997, 0x3FB99999A0000000, !dbg !222
  %211 = tail call contract noundef float @llvm.minnum.f32(float %mul1172.3, float 0x4024CB5EC0000000), !dbg !223
  %212 = tail call contract noundef float @llvm.exp.f32(float %211), !dbg !225
  %add1188 = fadd contract float %sum_acc.sroa.0.1, %206, !dbg !227
  %add1188.1 = fadd contract float %sum_acc.sroa.36.1, %208, !dbg !227
  %add1188.2 = fadd contract float %sum_acc.sroa.70.1, %210, !dbg !227
  %add1188.3 = fadd contract float %sum_acc.sroa.104.1, %212, !dbg !227
  %213 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %206), !dbg !228
  %214 = insertelement <4 x i16> poison, i16 %213, i64 0, !dbg !232
  %215 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %208), !dbg !228
  %216 = insertelement <4 x i16> %214, i16 %215, i64 1, !dbg !232
  %217 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %210), !dbg !228
  %218 = insertelement <4 x i16> %216, i16 %217, i64 2, !dbg !232
  %219 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %212), !dbg !228
  %220 = insertelement <4 x i16> %218, i16 %219, i64 3, !dbg !232
  %acc_s_cast.sroa.0.6.vec.insert2359 = bitcast <4 x i16> %220 to <4 x half>, !dbg !232
  %221 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload3106, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2359, <4 x float> %acc_o.sroa.0.0), !dbg !233, !call_argsrelate !99
  %222 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.34.0.copyload3121, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2359, <4 x float> %acc_o.sroa.42.0), !dbg !233, !call_argsrelate !99
  %223 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.50.16.copyload3166, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2359, <4 x float> %acc_o.sroa.82.0), !dbg !233, !call_argsrelate !99
  %224 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.82.16.copyload3181, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2359, <4 x float> %acc_o.sroa.122.0), !dbg !233, !call_argsrelate !99
  br label %if.end1224, !dbg !234

if.end1224:                                       ; preds = %if.end1137, %if.end1078
  %acc_o.sroa.122.1 = phi <4 x float> [ %acc_o.sroa.122.0, %if.end1078 ], [ %224, %if.end1137 ], !dbg !173
  %acc_o.sroa.82.1 = phi <4 x float> [ %acc_o.sroa.82.0, %if.end1078 ], [ %223, %if.end1137 ], !dbg !173
  %acc_o.sroa.42.1 = phi <4 x float> [ %acc_o.sroa.42.0, %if.end1078 ], [ %222, %if.end1137 ], !dbg !173
  %acc_o.sroa.0.1 = phi <4 x float> [ %acc_o.sroa.0.0, %if.end1078 ], [ %221, %if.end1137 ], !dbg !173
  %sum_acc.sroa.104.2 = phi float [ %sum_acc.sroa.104.1, %if.end1078 ], [ %add1188.3, %if.end1137 ], !dbg !173
  %sum_acc.sroa.70.2 = phi float [ %sum_acc.sroa.70.1, %if.end1078 ], [ %add1188.2, %if.end1137 ], !dbg !173
  %sum_acc.sroa.36.2 = phi float [ %sum_acc.sroa.36.1, %if.end1078 ], [ %add1188.1, %if.end1137 ], !dbg !173
  %sum_acc.sroa.0.2 = phi float [ %sum_acc.sroa.0.1, %if.end1078 ], [ %add1188, %if.end1137 ], !dbg !173
  br i1 %or.cond2045, label %if.end1371, label %for.cond1232.preheader, !dbg !234

for.cond1232.preheader:                           ; preds = %if.end1224
  %225 = shl nsw i32 %cond.i.i1897.3, 10
  %mul1239 = and i32 %225, 64512
  %add1242 = add nuw nsw i32 %add128, %mul1239
  %226 = zext nneg i32 %add1242 to i64, !dbg !235
  %add.ptr1247 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %226, !dbg !236
  %V_reg.sroa.0.0.copyload3107 = load <4 x half>, ptr addrspace(4) %add.ptr1247, align 16, !dbg !237
  %V_reg.sroa.34.0.add.ptr1247.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1247, i64 8, !dbg !237
  %V_reg.sroa.34.0.copyload3122 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.34.0.add.ptr1247.sroa_idx, align 8, !dbg !237
  %227 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %226, !dbg !236
  %add.ptr1247.1 = getelementptr inbounds i8, ptr addrspace(4) %227, i64 1024, !dbg !236
  %V_reg.sroa.50.16.copyload3167 = load <4 x half>, ptr addrspace(4) %add.ptr1247.1, align 16, !dbg !237
  %V_reg.sroa.82.16.add.ptr1247.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %227, i64 1032, !dbg !237
  %V_reg.sroa.82.16.copyload3182 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.82.16.add.ptr1247.1.sroa_idx, align 8, !dbg !237
  %cmp1257 = icmp sgt i32 %mul11.3, %invariant.op, !dbg !238
  br i1 %cmp1257, label %for.cond1259.preheader, label %if.end1283, !dbg !239

for.cond1259.preheader:                           ; preds = %for.cond1232.preheader
  %add1266 = add nuw nsw i32 %mul11.3, %mul827
  %cmp1269.not = icmp sgt i32 %add1266, %1, !dbg !240
  %fneg.1888 = select i1 %cmp1269.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2470 = insertelement <4 x float> poison, float %fneg.1888, i64 0, !dbg !241
  %cmp1269.not.1.not = icmp slt i32 %add1266, %1, !dbg !240
  %fneg.1888.1 = select i1 %cmp1269.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2659 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2470, float %fneg.1888.1, i64 1, !dbg !241
  %add1267.2 = or disjoint i32 %add1266, 2, !dbg !242
  %cmp1269.not.2 = icmp sgt i32 %add1267.2, %1, !dbg !240
  %fneg.1888.2 = select i1 %cmp1269.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2832 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2659, float %fneg.1888.2, i64 2, !dbg !241
  %add1267.3 = or disjoint i32 %add1266, 3, !dbg !242
  %cmp1269.not.3 = icmp sgt i32 %add1267.3, %1, !dbg !240
  %fneg.1888.3 = select i1 %cmp1269.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3005 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2832, float %fneg.1888.3, i64 3, !dbg !241
  br label %if.end1283

if.end1283:                                       ; preds = %for.cond1232.preheader, %for.cond1259.preheader
  %acc_s.sroa.0.6 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3005, %for.cond1259.preheader ], [ zeroinitializer, %for.cond1232.preheader ], !dbg !173
  %228 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.6), !dbg !243, !call_argsrelate !175
  %229 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.10.0, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %228), !dbg !243, !call_argsrelate !175
  %230 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.14.0, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %229), !dbg !243, !call_argsrelate !175
  %231 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.22.0, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %230), !dbg !243, !call_argsrelate !175
  %acc_s.sroa.0.0.vec.extract2472 = extractelement <4 x float> %231, i64 0, !dbg !244
  %mul1318 = fmul contract float %acc_s.sroa.0.0.vec.extract2472, 0x3FB99999A0000000, !dbg !245
  %232 = tail call contract noundef float @llvm.minnum.f32(float %mul1318, float 0x4024CB5EC0000000), !dbg !246
  %233 = tail call contract noundef float @llvm.exp.f32(float %232), !dbg !248
  %acc_s.sroa.0.4.vec.extract2661 = extractelement <4 x float> %231, i64 1, !dbg !244
  %mul1318.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2661, 0x3FB99999A0000000, !dbg !245
  %234 = tail call contract noundef float @llvm.minnum.f32(float %mul1318.1, float 0x4024CB5EC0000000), !dbg !246
  %235 = tail call contract noundef float @llvm.exp.f32(float %234), !dbg !248
  %acc_s.sroa.0.8.vec.extract2834 = extractelement <4 x float> %231, i64 2, !dbg !244
  %mul1318.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2834, 0x3FB99999A0000000, !dbg !245
  %236 = tail call contract noundef float @llvm.minnum.f32(float %mul1318.2, float 0x4024CB5EC0000000), !dbg !246
  %237 = tail call contract noundef float @llvm.exp.f32(float %236), !dbg !248
  %acc_s.sroa.0.12.vec.extract3007 = extractelement <4 x float> %231, i64 3, !dbg !244
  %mul1318.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3007, 0x3FB99999A0000000, !dbg !245
  %238 = tail call contract noundef float @llvm.minnum.f32(float %mul1318.3, float 0x4024CB5EC0000000), !dbg !246
  %239 = tail call contract noundef float @llvm.exp.f32(float %238), !dbg !248
  %add1334 = fadd contract float %sum_acc.sroa.0.2, %233, !dbg !250
  %add1334.1 = fadd contract float %sum_acc.sroa.36.2, %235, !dbg !250
  %add1334.2 = fadd contract float %sum_acc.sroa.70.2, %237, !dbg !250
  %add1334.3 = fadd contract float %sum_acc.sroa.104.2, %239, !dbg !250
  %240 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %233), !dbg !251
  %241 = insertelement <4 x i16> poison, i16 %240, i64 0, !dbg !255
  %242 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %235), !dbg !251
  %243 = insertelement <4 x i16> %241, i16 %242, i64 1, !dbg !255
  %244 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %237), !dbg !251
  %245 = insertelement <4 x i16> %243, i16 %244, i64 2, !dbg !255
  %246 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %239), !dbg !251
  %247 = insertelement <4 x i16> %245, i16 %246, i64 3, !dbg !255
  %acc_s_cast.sroa.0.6.vec.insert2361 = bitcast <4 x i16> %247 to <4 x half>, !dbg !255
  %248 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload3107, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2361, <4 x float> %acc_o_alt.sroa.0.0), !dbg !256, !call_argsrelate !99
  %249 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.34.0.copyload3122, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2361, <4 x float> %acc_o_alt.sroa.26.0), !dbg !256, !call_argsrelate !99
  %250 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.50.16.copyload3167, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2361, <4 x float> %acc_o_alt.sroa.50.0), !dbg !256, !call_argsrelate !99
  %251 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.82.16.copyload3182, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2361, <4 x float> %acc_o_alt.sroa.74.0), !dbg !256, !call_argsrelate !99
  br label %if.end1371, !dbg !148

if.end1371:                                       ; preds = %for.cond120.preheader, %if.end1283, %if.end1224
  %acc_o.sroa.122.2 = phi <4 x float> [ %acc_o.sroa.122.1, %if.end1224 ], [ %acc_o.sroa.122.1, %if.end1283 ], [ %107, %for.cond120.preheader ], !dbg !173
  %acc_o.sroa.82.2 = phi <4 x float> [ %acc_o.sroa.82.1, %if.end1224 ], [ %acc_o.sroa.82.1, %if.end1283 ], [ %106, %for.cond120.preheader ], !dbg !173
  %acc_o.sroa.42.2 = phi <4 x float> [ %acc_o.sroa.42.1, %if.end1224 ], [ %acc_o.sroa.42.1, %if.end1283 ], [ %105, %for.cond120.preheader ], !dbg !173
  %acc_o.sroa.0.2 = phi <4 x float> [ %acc_o.sroa.0.1, %if.end1224 ], [ %acc_o.sroa.0.1, %if.end1283 ], [ %104, %for.cond120.preheader ], !dbg !173
  %acc_o_alt.sroa.74.1 = phi <4 x float> [ %acc_o_alt.sroa.74.0, %if.end1224 ], [ %251, %if.end1283 ], [ %131, %for.cond120.preheader ], !dbg !173
  %acc_o_alt.sroa.50.1 = phi <4 x float> [ %acc_o_alt.sroa.50.0, %if.end1224 ], [ %250, %if.end1283 ], [ %130, %for.cond120.preheader ], !dbg !173
  %acc_o_alt.sroa.26.1 = phi <4 x float> [ %acc_o_alt.sroa.26.0, %if.end1224 ], [ %249, %if.end1283 ], [ %129, %for.cond120.preheader ], !dbg !173
  %acc_o_alt.sroa.0.1 = phi <4 x float> [ %acc_o_alt.sroa.0.0, %if.end1224 ], [ %248, %if.end1283 ], [ %128, %for.cond120.preheader ], !dbg !173
  %sum_acc.sroa.104.3 = phi float [ %sum_acc.sroa.104.2, %if.end1224 ], [ %add1334.3, %if.end1283 ], [ %add628.3, %for.cond120.preheader ], !dbg !173
  %sum_acc.sroa.70.3 = phi float [ %sum_acc.sroa.70.2, %if.end1224 ], [ %add1334.2, %if.end1283 ], [ %add628.2, %for.cond120.preheader ], !dbg !173
  %sum_acc.sroa.36.3 = phi float [ %sum_acc.sroa.36.2, %if.end1224 ], [ %add1334.1, %if.end1283 ], [ %add628.1, %for.cond120.preheader ], !dbg !173
  %sum_acc.sroa.0.3 = phi float [ %sum_acc.sroa.0.2, %if.end1224 ], [ %add1334, %if.end1283 ], [ %add628, %for.cond120.preheader ], !dbg !173
  %K_reg.sroa.22.1 = phi <4 x half> [ %K_reg.sroa.22.0, %if.end1224 ], [ %K_reg.sroa.22.0, %if.end1283 ], [ %K_reg.sroa.22.16.copyload, %for.cond120.preheader ]
  %K_reg.sroa.14.1 = phi <4 x half> [ %K_reg.sroa.14.0, %if.end1224 ], [ %K_reg.sroa.14.0, %if.end1283 ], [ %K_reg.sroa.14.16.copyload, %for.cond120.preheader ]
  %K_reg.sroa.10.1 = phi <4 x half> [ %K_reg.sroa.10.0, %if.end1224 ], [ %K_reg.sroa.10.0, %if.end1283 ], [ %K_reg.sroa.10.0.copyload, %for.cond120.preheader ]
  %K_reg.sroa.0.1 = phi <4 x half> [ %K_reg.sroa.0.0, %if.end1224 ], [ %K_reg.sroa.0.0, %if.end1283 ], [ %K_reg.sroa.0.0.copyload, %for.cond120.preheader ]
  %K_reg1.sroa.22.1 = phi <4 x half> [ %K_reg1.sroa.22.0, %if.end1224 ], [ %K_reg1.sroa.22.0, %if.end1283 ], [ %K_reg1.sroa.22.16.copyload, %for.cond120.preheader ]
  %K_reg1.sroa.14.1 = phi <4 x half> [ %K_reg1.sroa.14.0, %if.end1224 ], [ %K_reg1.sroa.14.0, %if.end1283 ], [ %K_reg1.sroa.14.16.copyload, %for.cond120.preheader ]
  %K_reg1.sroa.10.1 = phi <4 x half> [ %K_reg1.sroa.10.0, %if.end1224 ], [ %K_reg1.sroa.10.0, %if.end1283 ], [ %K_reg1.sroa.10.0.copyload, %for.cond120.preheader ]
  %K_reg1.sroa.0.1 = phi <4 x half> [ %K_reg1.sroa.0.0, %if.end1224 ], [ %K_reg1.sroa.0.0, %if.end1283 ], [ %K_reg1.sroa.0.0.copyload, %for.cond120.preheader ]
  %K_reg2.sroa.22.1 = phi <4 x half> [ %K_reg2.sroa.22.0, %if.end1224 ], [ %K_reg2.sroa.22.0, %if.end1283 ], [ %K_reg2.sroa.22.16.copyload, %for.cond120.preheader ]
  %K_reg2.sroa.14.1 = phi <4 x half> [ %K_reg2.sroa.14.0, %if.end1224 ], [ %K_reg2.sroa.14.0, %if.end1283 ], [ %K_reg2.sroa.14.16.copyload, %for.cond120.preheader ]
  %K_reg2.sroa.10.1 = phi <4 x half> [ %K_reg2.sroa.10.0, %if.end1224 ], [ %K_reg2.sroa.10.0, %if.end1283 ], [ %K_reg2.sroa.10.0.copyload, %for.cond120.preheader ]
  %K_reg2.sroa.0.1 = phi <4 x half> [ %K_reg2.sroa.0.0, %if.end1224 ], [ %K_reg2.sroa.0.0, %if.end1283 ], [ %K_reg2.sroa.0.0.copyload, %for.cond120.preheader ]
  %K_reg3.sroa.22.1 = phi <4 x half> [ %K_reg3.sroa.22.0, %if.end1224 ], [ %K_reg3.sroa.22.0, %if.end1283 ], [ %K_reg3.sroa.22.16.copyload, %for.cond120.preheader ]
  %K_reg3.sroa.14.1 = phi <4 x half> [ %K_reg3.sroa.14.0, %if.end1224 ], [ %K_reg3.sroa.14.0, %if.end1283 ], [ %K_reg3.sroa.14.16.copyload, %for.cond120.preheader ]
  %K_reg3.sroa.10.1 = phi <4 x half> [ %K_reg3.sroa.10.0, %if.end1224 ], [ %K_reg3.sroa.10.0, %if.end1283 ], [ %K_reg3.sroa.10.0.copyload, %for.cond120.preheader ]
  %K_reg3.sroa.0.1 = phi <4 x half> [ %K_reg3.sroa.0.0, %if.end1224 ], [ %K_reg3.sroa.0.0, %if.end1283 ], [ %K_reg3.sroa.0.0.copyload, %for.cond120.preheader ]
  %or.cond2030.1 = icmp ugt i32 %mul11.4, 1008, !dbg !59
  %cmp95.not.1 = icmp sgt i32 %mul11.4, %invariant.op
  %or.cond2031.not2054.not2056.not2058.not2062.not2066.not2072.1 = select i1 %or.cond2030.1, i1 true, i1 %cmp95.not.1
  %cmp97.1 = icmp slt i32 %13, 0
  %or.cond.1 = icmp sgt i32 %mul11.5, %invariant.smin
  %.not2059.not2063.not2067.not2073.1 = or i1 %cmp97.1, %or.cond.1
  %or.cond2033.not2057.not2061.not2065.not2071.1 = select i1 %or.cond2031.not2054.not2056.not2058.not2062.not2066.not2072.1, i1 true, i1 %.not2059.not2063.not2067.not2073.1
  %cmp105.1 = icmp slt i32 %15, 0
  %or.cond1904.1 = icmp sgt i32 %mul11.6, %invariant.smin
  %.not2068.not2074.1 = or i1 %cmp105.1, %or.cond1904.1, !dbg !59
  %or.cond2035.not2064.not2070.1 = select i1 %or.cond2033.not2057.not2061.not2065.not2071.1, i1 true, i1 %.not2068.not2074.1
  %cmp113.1 = icmp slt i32 %17, 0
  %or.cond1905.1 = icmp sgt i32 %mul11.7, %invariant.smin
  %252 = or i1 %cmp113.1, %or.cond1905.1, !dbg !59
  %or.cond2037.1 = select i1 %or.cond2035.not2064.not2070.1, i1 true, i1 %252, !dbg !59
  br i1 %or.cond2037.1, label %if.else.1, label %for.cond120.preheader.1, !dbg !59

for.cond120.preheader.1:                          ; preds = %if.end1371
  %253 = shl nsw i32 %cond.i.i1897.4, 10
  %mul127.1 = and i32 %253, 64512
  %add130.1 = add nuw nsw i32 %add128, %mul127.1
  %254 = zext nneg i32 %add130.1 to i64, !dbg !60
  %add.ptr135.12169 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %254, !dbg !61
  %K_reg.sroa.0.0.copyload3282 = load <4 x half>, ptr addrspace(4) %add.ptr135.12169, align 16, !dbg !62
  %K_reg.sroa.10.0.add.ptr135.12169.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr135.12169, i64 8, !dbg !62
  %K_reg.sroa.10.0.copyload3285 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.10.0.add.ptr135.12169.sroa_idx, align 8, !dbg !62
  %255 = add nuw nsw i64 %254, 512, !dbg !63
  %add.ptr135.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %255, !dbg !61
  %K_reg.sroa.14.16.copyload3294 = load <4 x half>, ptr addrspace(4) %add.ptr135.1.1, align 16, !dbg !62
  %K_reg.sroa.22.16.add.ptr135.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr135.1.1, i64 8, !dbg !62
  %K_reg.sroa.22.16.copyload3297 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.22.16.add.ptr135.1.1.sroa_idx, align 8, !dbg !62
  %256 = shl nuw nsw i32 %cond.i.i1897.5, 10
  %add153.1 = add nuw nsw i32 %add128, %256
  %257 = zext nneg i32 %add153.1 to i64, !dbg !64
  %add.ptr158.12170 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %257, !dbg !65
  %K_reg1.sroa.0.0.copyload3258 = load <4 x half>, ptr addrspace(4) %add.ptr158.12170, align 16, !dbg !66
  %K_reg1.sroa.10.0.add.ptr158.12170.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr158.12170, i64 8, !dbg !66
  %K_reg1.sroa.10.0.copyload3261 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.10.0.add.ptr158.12170.sroa_idx, align 8, !dbg !66
  %258 = add nuw nsw i64 %257, 512, !dbg !67
  %add.ptr158.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %258, !dbg !65
  %K_reg1.sroa.14.16.copyload3270 = load <4 x half>, ptr addrspace(4) %add.ptr158.1.1, align 16, !dbg !66
  %K_reg1.sroa.22.16.add.ptr158.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr158.1.1, i64 8, !dbg !66
  %K_reg1.sroa.22.16.copyload3273 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.22.16.add.ptr158.1.1.sroa_idx, align 8, !dbg !66
  %259 = shl nuw nsw i32 %cond.i.i1897.6, 10
  %add176.1 = add nuw nsw i32 %add128, %259
  %260 = zext nneg i32 %add176.1 to i64, !dbg !68
  %add.ptr181.12171 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %260, !dbg !69
  %K_reg2.sroa.0.0.copyload3234 = load <4 x half>, ptr addrspace(4) %add.ptr181.12171, align 16, !dbg !70
  %K_reg2.sroa.10.0.add.ptr181.12171.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr181.12171, i64 8, !dbg !70
  %K_reg2.sroa.10.0.copyload3237 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.10.0.add.ptr181.12171.sroa_idx, align 8, !dbg !70
  %261 = add nuw nsw i64 %260, 512, !dbg !71
  %add.ptr181.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %261, !dbg !69
  %K_reg2.sroa.14.16.copyload3246 = load <4 x half>, ptr addrspace(4) %add.ptr181.1.1, align 16, !dbg !70
  %K_reg2.sroa.22.16.add.ptr181.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr181.1.1, i64 8, !dbg !70
  %K_reg2.sroa.22.16.copyload3249 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.22.16.add.ptr181.1.1.sroa_idx, align 8, !dbg !70
  %262 = shl nuw nsw i32 %cond.i.i1897.7, 10
  %add199.1 = add nuw nsw i32 %add128, %262
  %263 = zext nneg i32 %add199.1 to i64, !dbg !72
  %add.ptr204.12172 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %263, !dbg !73
  %K_reg3.sroa.0.0.copyload3210 = load <4 x half>, ptr addrspace(4) %add.ptr204.12172, align 16, !dbg !74
  %K_reg3.sroa.10.0.add.ptr204.12172.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr204.12172, i64 8, !dbg !74
  %K_reg3.sroa.10.0.copyload3213 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.10.0.add.ptr204.12172.sroa_idx, align 8, !dbg !74
  %264 = add nuw nsw i64 %263, 512, !dbg !75
  %add.ptr204.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %264, !dbg !73
  %K_reg3.sroa.14.16.copyload3222 = load <4 x half>, ptr addrspace(4) %add.ptr204.1.1, align 16, !dbg !74
  %K_reg3.sroa.22.16.add.ptr204.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr204.1.1, i64 8, !dbg !74
  %K_reg3.sroa.22.16.copyload3225 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.22.16.add.ptr204.1.1.sroa_idx, align 8, !dbg !74
  %add.ptr227.12173 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %254, !dbg !76
  %V_reg.sroa.0.0.copyload3108 = load <4 x half>, ptr addrspace(4) %add.ptr227.12173, align 16, !dbg !77
  %V_reg.sroa.34.0.add.ptr227.12173.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr227.12173, i64 8, !dbg !77
  %V_reg.sroa.34.0.copyload3123 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.34.0.add.ptr227.12173.sroa_idx, align 8, !dbg !77
  %add.ptr227.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %255, !dbg !76
  %V_reg.sroa.50.16.copyload3168 = load <4 x half>, ptr addrspace(4) %add.ptr227.1.1, align 16, !dbg !77
  %V_reg.sroa.82.16.add.ptr227.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr227.1.1, i64 8, !dbg !77
  %V_reg.sroa.82.16.copyload3183 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.82.16.add.ptr227.1.1.sroa_idx, align 8, !dbg !77
  %265 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.0.copyload3282, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !78, !call_argsrelate !79
  %266 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.10.0.copyload3285, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %265), !dbg !78, !call_argsrelate !79
  %267 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.14.16.copyload3294, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %266), !dbg !78, !call_argsrelate !79
  %268 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.22.16.copyload3297, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %267), !dbg !78, !call_argsrelate !79
  %acc_s.sroa.0.0.vec.extract2482 = extractelement <4 x float> %268, i64 0, !dbg !80
  %mul273.12177 = fmul contract float %acc_s.sroa.0.0.vec.extract2482, 0x3FB99999A0000000, !dbg !81
  %269 = tail call contract noundef float @llvm.minnum.f32(float %mul273.12177, float 0x4024CB5EC0000000), !dbg !82
  %270 = tail call contract noundef float @llvm.exp.f32(float %269), !dbg !85
  %acc_s.sroa.0.4.vec.extract2669 = extractelement <4 x float> %268, i64 1, !dbg !80
  %mul273.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2669, 0x3FB99999A0000000, !dbg !81
  %271 = tail call contract noundef float @llvm.minnum.f32(float %mul273.1.1, float 0x4024CB5EC0000000), !dbg !82
  %272 = tail call contract noundef float @llvm.exp.f32(float %271), !dbg !85
  %acc_s.sroa.0.8.vec.extract2842 = extractelement <4 x float> %268, i64 2, !dbg !80
  %mul273.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract2842, 0x3FB99999A0000000, !dbg !81
  %273 = tail call contract noundef float @llvm.minnum.f32(float %mul273.2.1, float 0x4024CB5EC0000000), !dbg !82
  %274 = tail call contract noundef float @llvm.exp.f32(float %273), !dbg !85
  %acc_s.sroa.0.12.vec.extract3015 = extractelement <4 x float> %268, i64 3, !dbg !80
  %mul273.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3015, 0x3FB99999A0000000, !dbg !81
  %275 = tail call contract noundef float @llvm.minnum.f32(float %mul273.3.1, float 0x4024CB5EC0000000), !dbg !82
  %276 = tail call contract noundef float @llvm.exp.f32(float %275), !dbg !85
  %add289.12178 = fadd contract float %sum_acc.sroa.0.3, %270, !dbg !257
  %add289.1.1 = fadd contract float %sum_acc.sroa.36.3, %272, !dbg !257
  %add289.2.1 = fadd contract float %sum_acc.sroa.70.3, %274, !dbg !257
  %add289.3.1 = fadd contract float %sum_acc.sroa.104.3, %276, !dbg !257
  %277 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %270), !dbg !88
  %278 = insertelement <4 x i16> poison, i16 %277, i64 0, !dbg !97
  %279 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %272), !dbg !88
  %280 = insertelement <4 x i16> %278, i16 %279, i64 1, !dbg !97
  %281 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %274), !dbg !88
  %282 = insertelement <4 x i16> %280, i16 %281, i64 2, !dbg !97
  %283 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %276), !dbg !88
  %284 = insertelement <4 x i16> %282, i16 %283, i64 3, !dbg !97
  %acc_s_cast.sroa.0.6.vec.insert2363 = bitcast <4 x i16> %284 to <4 x half>, !dbg !97
  %285 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload3108, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2363, <4 x float> %acc_o.sroa.0.2), !dbg !98, !call_argsrelate !99
  %286 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.34.0.copyload3123, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2363, <4 x float> %acc_o.sroa.42.2), !dbg !98, !call_argsrelate !99
  %287 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.50.16.copyload3168, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2363, <4 x float> %acc_o.sroa.82.2), !dbg !98, !call_argsrelate !99
  %288 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.82.16.copyload3183, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2363, <4 x float> %acc_o.sroa.122.2), !dbg !98, !call_argsrelate !99
  %add.ptr340.12179 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %257, !dbg !100
  %V_reg.sroa.0.0.copyload3109 = load <4 x half>, ptr addrspace(4) %add.ptr340.12179, align 16, !dbg !101
  %V_reg.sroa.34.0.add.ptr340.12179.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr340.12179, i64 8, !dbg !101
  %V_reg.sroa.34.0.copyload3124 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.34.0.add.ptr340.12179.sroa_idx, align 8, !dbg !101
  %add.ptr340.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %258, !dbg !100
  %V_reg.sroa.50.16.copyload3169 = load <4 x half>, ptr addrspace(4) %add.ptr340.1.1, align 16, !dbg !101
  %V_reg.sroa.82.16.add.ptr340.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr340.1.1, i64 8, !dbg !101
  %V_reg.sroa.82.16.copyload3184 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.82.16.add.ptr340.1.1.sroa_idx, align 8, !dbg !101
  %289 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.0.copyload3258, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !102, !call_argsrelate !79
  %290 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.10.0.copyload3261, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %289), !dbg !102, !call_argsrelate !79
  %291 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.14.16.copyload3270, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %290), !dbg !102, !call_argsrelate !79
  %292 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.22.16.copyload3273, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %291), !dbg !102, !call_argsrelate !79
  %acc_s.sroa.0.0.vec.extract2492 = extractelement <4 x float> %292, i64 0, !dbg !103
  %mul386.12183 = fmul contract float %acc_s.sroa.0.0.vec.extract2492, 0x3FB99999A0000000, !dbg !104
  %293 = tail call contract noundef float @llvm.minnum.f32(float %mul386.12183, float 0x4024CB5EC0000000), !dbg !105
  %294 = tail call contract noundef float @llvm.exp.f32(float %293), !dbg !107
  %acc_s.sroa.0.4.vec.extract2677 = extractelement <4 x float> %292, i64 1, !dbg !103
  %mul386.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2677, 0x3FB99999A0000000, !dbg !104
  %295 = tail call contract noundef float @llvm.minnum.f32(float %mul386.1.1, float 0x4024CB5EC0000000), !dbg !105
  %296 = tail call contract noundef float @llvm.exp.f32(float %295), !dbg !107
  %acc_s.sroa.0.8.vec.extract2850 = extractelement <4 x float> %292, i64 2, !dbg !103
  %mul386.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract2850, 0x3FB99999A0000000, !dbg !104
  %297 = tail call contract noundef float @llvm.minnum.f32(float %mul386.2.1, float 0x4024CB5EC0000000), !dbg !105
  %298 = tail call contract noundef float @llvm.exp.f32(float %297), !dbg !107
  %acc_s.sroa.0.12.vec.extract3023 = extractelement <4 x float> %292, i64 3, !dbg !103
  %mul386.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3023, 0x3FB99999A0000000, !dbg !104
  %299 = tail call contract noundef float @llvm.minnum.f32(float %mul386.3.1, float 0x4024CB5EC0000000), !dbg !105
  %300 = tail call contract noundef float @llvm.exp.f32(float %299), !dbg !107
  %add402.12184 = fadd contract float %add289.12178, %294, !dbg !109
  %add402.1.1 = fadd contract float %add289.1.1, %296, !dbg !109
  %add402.2.1 = fadd contract float %add289.2.1, %298, !dbg !109
  %add402.3.1 = fadd contract float %add289.3.1, %300, !dbg !109
  %301 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %294), !dbg !110
  %302 = insertelement <4 x i16> poison, i16 %301, i64 0, !dbg !114
  %303 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %296), !dbg !110
  %304 = insertelement <4 x i16> %302, i16 %303, i64 1, !dbg !114
  %305 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %298), !dbg !110
  %306 = insertelement <4 x i16> %304, i16 %305, i64 2, !dbg !114
  %307 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %300), !dbg !110
  %308 = insertelement <4 x i16> %306, i16 %307, i64 3, !dbg !114
  %acc_s_cast.sroa.0.6.vec.insert2365 = bitcast <4 x i16> %308 to <4 x half>, !dbg !114
  %309 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload3109, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2365, <4 x float> %acc_o_alt.sroa.0.1), !dbg !115, !call_argsrelate !99
  %310 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.34.0.copyload3124, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2365, <4 x float> %acc_o_alt.sroa.26.1), !dbg !115, !call_argsrelate !99
  %311 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.50.16.copyload3169, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2365, <4 x float> %acc_o_alt.sroa.50.1), !dbg !115, !call_argsrelate !99
  %312 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.82.16.copyload3184, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2365, <4 x float> %acc_o_alt.sroa.74.1), !dbg !115, !call_argsrelate !99
  %add.ptr453.12185 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %260, !dbg !116
  %V_reg.sroa.0.0.copyload3110 = load <4 x half>, ptr addrspace(4) %add.ptr453.12185, align 16, !dbg !117
  %V_reg.sroa.34.0.add.ptr453.12185.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr453.12185, i64 8, !dbg !117
  %V_reg.sroa.34.0.copyload3125 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.34.0.add.ptr453.12185.sroa_idx, align 8, !dbg !117
  %add.ptr453.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %261, !dbg !116
  %V_reg.sroa.50.16.copyload3170 = load <4 x half>, ptr addrspace(4) %add.ptr453.1.1, align 16, !dbg !117
  %V_reg.sroa.82.16.add.ptr453.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr453.1.1, i64 8, !dbg !117
  %V_reg.sroa.82.16.copyload3185 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.82.16.add.ptr453.1.1.sroa_idx, align 8, !dbg !117
  %313 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.0.0.copyload3234, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !118, !call_argsrelate !79
  %314 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.10.0.copyload3237, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %313), !dbg !118, !call_argsrelate !79
  %315 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.14.16.copyload3246, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %314), !dbg !118, !call_argsrelate !79
  %316 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.22.16.copyload3249, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %315), !dbg !118, !call_argsrelate !79
  %acc_s.sroa.0.0.vec.extract2502 = extractelement <4 x float> %316, i64 0, !dbg !119
  %mul499.12189 = fmul contract float %acc_s.sroa.0.0.vec.extract2502, 0x3FB99999A0000000, !dbg !120
  %317 = tail call contract noundef float @llvm.minnum.f32(float %mul499.12189, float 0x4024CB5EC0000000), !dbg !121
  %318 = tail call contract noundef float @llvm.exp.f32(float %317), !dbg !123
  %acc_s.sroa.0.4.vec.extract2685 = extractelement <4 x float> %316, i64 1, !dbg !119
  %mul499.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2685, 0x3FB99999A0000000, !dbg !120
  %319 = tail call contract noundef float @llvm.minnum.f32(float %mul499.1.1, float 0x4024CB5EC0000000), !dbg !121
  %320 = tail call contract noundef float @llvm.exp.f32(float %319), !dbg !123
  %acc_s.sroa.0.8.vec.extract2858 = extractelement <4 x float> %316, i64 2, !dbg !119
  %mul499.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract2858, 0x3FB99999A0000000, !dbg !120
  %321 = tail call contract noundef float @llvm.minnum.f32(float %mul499.2.1, float 0x4024CB5EC0000000), !dbg !121
  %322 = tail call contract noundef float @llvm.exp.f32(float %321), !dbg !123
  %acc_s.sroa.0.12.vec.extract3031 = extractelement <4 x float> %316, i64 3, !dbg !119
  %mul499.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3031, 0x3FB99999A0000000, !dbg !120
  %323 = tail call contract noundef float @llvm.minnum.f32(float %mul499.3.1, float 0x4024CB5EC0000000), !dbg !121
  %324 = tail call contract noundef float @llvm.exp.f32(float %323), !dbg !123
  %add515.12190 = fadd contract float %add402.12184, %318, !dbg !125
  %add515.1.1 = fadd contract float %add402.1.1, %320, !dbg !125
  %add515.2.1 = fadd contract float %add402.2.1, %322, !dbg !125
  %add515.3.1 = fadd contract float %add402.3.1, %324, !dbg !125
  %325 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %318), !dbg !126
  %326 = insertelement <4 x i16> poison, i16 %325, i64 0, !dbg !130
  %327 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %320), !dbg !126
  %328 = insertelement <4 x i16> %326, i16 %327, i64 1, !dbg !130
  %329 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %322), !dbg !126
  %330 = insertelement <4 x i16> %328, i16 %329, i64 2, !dbg !130
  %331 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %324), !dbg !126
  %332 = insertelement <4 x i16> %330, i16 %331, i64 3, !dbg !130
  %acc_s_cast.sroa.0.6.vec.insert2367 = bitcast <4 x i16> %332 to <4 x half>, !dbg !130
  %333 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload3110, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2367, <4 x float> %285), !dbg !131, !call_argsrelate !99
  %334 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.34.0.copyload3125, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2367, <4 x float> %286), !dbg !131, !call_argsrelate !99
  %335 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.50.16.copyload3170, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2367, <4 x float> %287), !dbg !131, !call_argsrelate !99
  %336 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.82.16.copyload3185, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2367, <4 x float> %288), !dbg !131, !call_argsrelate !99
  %add.ptr566.12191 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %263, !dbg !132
  %V_reg.sroa.0.0.copyload3111 = load <4 x half>, ptr addrspace(4) %add.ptr566.12191, align 16, !dbg !133
  %V_reg.sroa.34.0.add.ptr566.12191.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr566.12191, i64 8, !dbg !133
  %V_reg.sroa.34.0.copyload3126 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.34.0.add.ptr566.12191.sroa_idx, align 8, !dbg !133
  %add.ptr566.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %264, !dbg !132
  %V_reg.sroa.50.16.copyload3171 = load <4 x half>, ptr addrspace(4) %add.ptr566.1.1, align 16, !dbg !133
  %V_reg.sroa.82.16.add.ptr566.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr566.1.1, i64 8, !dbg !133
  %V_reg.sroa.82.16.copyload3186 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.82.16.add.ptr566.1.1.sroa_idx, align 8, !dbg !133
  %337 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.0.0.copyload3210, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !134, !call_argsrelate !79
  %338 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.10.0.copyload3213, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %337), !dbg !134, !call_argsrelate !79
  %339 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.14.16.copyload3222, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %338), !dbg !134, !call_argsrelate !79
  %340 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.22.16.copyload3225, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %339), !dbg !134, !call_argsrelate !79
  %acc_s.sroa.0.0.vec.extract2512 = extractelement <4 x float> %340, i64 0, !dbg !135
  %mul612.12195 = fmul contract float %acc_s.sroa.0.0.vec.extract2512, 0x3FB99999A0000000, !dbg !136
  %341 = tail call contract noundef float @llvm.minnum.f32(float %mul612.12195, float 0x4024CB5EC0000000), !dbg !137
  %342 = tail call contract noundef float @llvm.exp.f32(float %341), !dbg !139
  %acc_s.sroa.0.4.vec.extract2693 = extractelement <4 x float> %340, i64 1, !dbg !135
  %mul612.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2693, 0x3FB99999A0000000, !dbg !136
  %343 = tail call contract noundef float @llvm.minnum.f32(float %mul612.1.1, float 0x4024CB5EC0000000), !dbg !137
  %344 = tail call contract noundef float @llvm.exp.f32(float %343), !dbg !139
  %acc_s.sroa.0.8.vec.extract2866 = extractelement <4 x float> %340, i64 2, !dbg !135
  %mul612.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract2866, 0x3FB99999A0000000, !dbg !136
  %345 = tail call contract noundef float @llvm.minnum.f32(float %mul612.2.1, float 0x4024CB5EC0000000), !dbg !137
  %346 = tail call contract noundef float @llvm.exp.f32(float %345), !dbg !139
  %acc_s.sroa.0.12.vec.extract3039 = extractelement <4 x float> %340, i64 3, !dbg !135
  %mul612.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3039, 0x3FB99999A0000000, !dbg !136
  %347 = tail call contract noundef float @llvm.minnum.f32(float %mul612.3.1, float 0x4024CB5EC0000000), !dbg !137
  %348 = tail call contract noundef float @llvm.exp.f32(float %347), !dbg !139
  %add628.12196 = fadd contract float %add515.12190, %342, !dbg !141
  %add628.1.1 = fadd contract float %add515.1.1, %344, !dbg !141
  %add628.2.1 = fadd contract float %add515.2.1, %346, !dbg !141
  %add628.3.1 = fadd contract float %add515.3.1, %348, !dbg !141
  %349 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %342), !dbg !142
  %350 = insertelement <4 x i16> poison, i16 %349, i64 0, !dbg !146
  %351 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %344), !dbg !142
  %352 = insertelement <4 x i16> %350, i16 %351, i64 1, !dbg !146
  %353 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %346), !dbg !142
  %354 = insertelement <4 x i16> %352, i16 %353, i64 2, !dbg !146
  %355 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %348), !dbg !142
  %356 = insertelement <4 x i16> %354, i16 %355, i64 3, !dbg !146
  %acc_s_cast.sroa.0.6.vec.insert2369 = bitcast <4 x i16> %356 to <4 x half>, !dbg !146
  %357 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload3111, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2369, <4 x float> %309), !dbg !147, !call_argsrelate !99
  %358 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.34.0.copyload3126, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2369, <4 x float> %310), !dbg !147, !call_argsrelate !99
  %359 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.50.16.copyload3171, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2369, <4 x float> %311), !dbg !147, !call_argsrelate !99
  %360 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.82.16.copyload3186, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2369, <4 x float> %312), !dbg !147, !call_argsrelate !99
  br label %if.end1371.1, !dbg !148

if.else.1:                                        ; preds = %if.end1371
  %or.cond2038.1 = icmp ugt i32 %mul11.4, 1023, !dbg !149
  %cmp669.not.1 = icmp sgt i32 %mul11.4, %1
  %or.cond2039.1 = or i1 %or.cond2038.1, %cmp669.not.1, !dbg !149
  br i1 %or.cond2039.1, label %if.end.1, label %for.cond671.preheader.1, !dbg !149

for.cond671.preheader.1:                          ; preds = %if.else.1
  %361 = shl nsw i32 %cond.i.i1897.4, 10
  %mul678.1 = and i32 %361, 64512
  %add681.1 = add nuw nsw i32 %add128, %mul678.1
  %362 = zext nneg i32 %add681.1 to i64, !dbg !150
  %add.ptr686.12197 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %362, !dbg !151
  %K_reg.sroa.0.0.copyload3283 = load <4 x half>, ptr addrspace(4) %add.ptr686.12197, align 16, !dbg !152
  %K_reg.sroa.10.0.add.ptr686.12197.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr686.12197, i64 8, !dbg !152
  %K_reg.sroa.10.0.copyload3286 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.10.0.add.ptr686.12197.sroa_idx, align 8, !dbg !152
  %363 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %362, !dbg !151
  %add.ptr686.1.1 = getelementptr inbounds i8, ptr addrspace(4) %363, i64 1024, !dbg !151
  %K_reg.sroa.14.16.copyload3295 = load <4 x half>, ptr addrspace(4) %add.ptr686.1.1, align 16, !dbg !152
  %K_reg.sroa.22.16.add.ptr686.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %363, i64 1032, !dbg !152
  %K_reg.sroa.22.16.copyload3298 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.22.16.add.ptr686.1.1.sroa_idx, align 8, !dbg !152
  br label %if.end.1, !dbg !153

if.end.1:                                         ; preds = %for.cond671.preheader.1, %if.else.1
  %K_reg.sroa.22.2 = phi <4 x half> [ %K_reg.sroa.22.1, %if.else.1 ], [ %K_reg.sroa.22.16.copyload3298, %for.cond671.preheader.1 ]
  %K_reg.sroa.14.2 = phi <4 x half> [ %K_reg.sroa.14.1, %if.else.1 ], [ %K_reg.sroa.14.16.copyload3295, %for.cond671.preheader.1 ]
  %K_reg.sroa.10.2 = phi <4 x half> [ %K_reg.sroa.10.1, %if.else.1 ], [ %K_reg.sroa.10.0.copyload3286, %for.cond671.preheader.1 ]
  %K_reg.sroa.0.2 = phi <4 x half> [ %K_reg.sroa.0.1, %if.else.1 ], [ %K_reg.sroa.0.0.copyload3283, %for.cond671.preheader.1 ]
  %or.cond2040.1 = icmp ugt i32 %mul11.5, 1023, !dbg !153
  %cmp699.not.1 = icmp sgt i32 %mul11.5, %1
  %or.cond2041.1 = or i1 %or.cond2040.1, %cmp699.not.1, !dbg !153
  br i1 %or.cond2041.1, label %if.end724.1, label %for.cond701.preheader.1, !dbg !153

for.cond701.preheader.1:                          ; preds = %if.end.1
  %364 = shl nsw i32 %cond.i.i1897.5, 10
  %mul708.1 = and i32 %364, 64512
  %add711.1 = add nuw nsw i32 %add128, %mul708.1
  %365 = zext nneg i32 %add711.1 to i64, !dbg !154
  %add.ptr716.12198 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %365, !dbg !155
  %K_reg1.sroa.0.0.copyload3259 = load <4 x half>, ptr addrspace(4) %add.ptr716.12198, align 16, !dbg !156
  %K_reg1.sroa.10.0.add.ptr716.12198.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr716.12198, i64 8, !dbg !156
  %K_reg1.sroa.10.0.copyload3262 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.10.0.add.ptr716.12198.sroa_idx, align 8, !dbg !156
  %366 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %365, !dbg !155
  %add.ptr716.1.1 = getelementptr inbounds i8, ptr addrspace(4) %366, i64 1024, !dbg !155
  %K_reg1.sroa.14.16.copyload3271 = load <4 x half>, ptr addrspace(4) %add.ptr716.1.1, align 16, !dbg !156
  %K_reg1.sroa.22.16.add.ptr716.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %366, i64 1032, !dbg !156
  %K_reg1.sroa.22.16.copyload3274 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.22.16.add.ptr716.1.1.sroa_idx, align 8, !dbg !156
  br label %if.end724.1, !dbg !157

if.end724.1:                                      ; preds = %for.cond701.preheader.1, %if.end.1
  %K_reg1.sroa.22.2 = phi <4 x half> [ %K_reg1.sroa.22.1, %if.end.1 ], [ %K_reg1.sroa.22.16.copyload3274, %for.cond701.preheader.1 ]
  %K_reg1.sroa.14.2 = phi <4 x half> [ %K_reg1.sroa.14.1, %if.end.1 ], [ %K_reg1.sroa.14.16.copyload3271, %for.cond701.preheader.1 ]
  %K_reg1.sroa.10.2 = phi <4 x half> [ %K_reg1.sroa.10.1, %if.end.1 ], [ %K_reg1.sroa.10.0.copyload3262, %for.cond701.preheader.1 ]
  %K_reg1.sroa.0.2 = phi <4 x half> [ %K_reg1.sroa.0.1, %if.end.1 ], [ %K_reg1.sroa.0.0.copyload3259, %for.cond701.preheader.1 ]
  %or.cond2042.1 = icmp ugt i32 %mul11.6, 1023, !dbg !157
  %cmp730.not.1 = icmp sgt i32 %mul11.6, %1
  %or.cond2043.1 = or i1 %or.cond2042.1, %cmp730.not.1, !dbg !157
  br i1 %or.cond2043.1, label %if.end755.1, label %for.cond732.preheader.1, !dbg !157

for.cond732.preheader.1:                          ; preds = %if.end724.1
  %367 = shl nsw i32 %cond.i.i1897.6, 10
  %mul739.1 = and i32 %367, 64512
  %add742.1 = add nuw nsw i32 %add128, %mul739.1
  %368 = zext nneg i32 %add742.1 to i64, !dbg !158
  %add.ptr747.12199 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %368, !dbg !159
  %K_reg2.sroa.0.0.copyload3235 = load <4 x half>, ptr addrspace(4) %add.ptr747.12199, align 16, !dbg !160
  %K_reg2.sroa.10.0.add.ptr747.12199.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr747.12199, i64 8, !dbg !160
  %K_reg2.sroa.10.0.copyload3238 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.10.0.add.ptr747.12199.sroa_idx, align 8, !dbg !160
  %369 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %368, !dbg !159
  %add.ptr747.1.1 = getelementptr inbounds i8, ptr addrspace(4) %369, i64 1024, !dbg !159
  %K_reg2.sroa.14.16.copyload3247 = load <4 x half>, ptr addrspace(4) %add.ptr747.1.1, align 16, !dbg !160
  %K_reg2.sroa.22.16.add.ptr747.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %369, i64 1032, !dbg !160
  %K_reg2.sroa.22.16.copyload3250 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.22.16.add.ptr747.1.1.sroa_idx, align 8, !dbg !160
  br label %if.end755.1, !dbg !161

if.end755.1:                                      ; preds = %for.cond732.preheader.1, %if.end724.1
  %K_reg2.sroa.22.2 = phi <4 x half> [ %K_reg2.sroa.22.1, %if.end724.1 ], [ %K_reg2.sroa.22.16.copyload3250, %for.cond732.preheader.1 ]
  %K_reg2.sroa.14.2 = phi <4 x half> [ %K_reg2.sroa.14.1, %if.end724.1 ], [ %K_reg2.sroa.14.16.copyload3247, %for.cond732.preheader.1 ]
  %K_reg2.sroa.10.2 = phi <4 x half> [ %K_reg2.sroa.10.1, %if.end724.1 ], [ %K_reg2.sroa.10.0.copyload3238, %for.cond732.preheader.1 ]
  %K_reg2.sroa.0.2 = phi <4 x half> [ %K_reg2.sroa.0.1, %if.end724.1 ], [ %K_reg2.sroa.0.0.copyload3235, %for.cond732.preheader.1 ]
  %or.cond2044.1 = icmp ugt i32 %mul11.7, 1023, !dbg !161
  %cmp761.not.1 = icmp sgt i32 %mul11.7, %1
  %or.cond2045.1 = or i1 %or.cond2044.1, %cmp761.not.1, !dbg !161
  br i1 %or.cond2045.1, label %if.end786.1, label %for.cond763.preheader.1, !dbg !161

for.cond763.preheader.1:                          ; preds = %if.end755.1
  %370 = shl nsw i32 %cond.i.i1897.7, 10
  %mul770.1 = and i32 %370, 64512
  %add773.1 = add nuw nsw i32 %add128, %mul770.1
  %371 = zext nneg i32 %add773.1 to i64, !dbg !162
  %add.ptr778.12200 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %371, !dbg !163
  %K_reg3.sroa.0.0.copyload3211 = load <4 x half>, ptr addrspace(4) %add.ptr778.12200, align 16, !dbg !164
  %K_reg3.sroa.10.0.add.ptr778.12200.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr778.12200, i64 8, !dbg !164
  %K_reg3.sroa.10.0.copyload3214 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.10.0.add.ptr778.12200.sroa_idx, align 8, !dbg !164
  %372 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %371, !dbg !163
  %add.ptr778.1.1 = getelementptr inbounds i8, ptr addrspace(4) %372, i64 1024, !dbg !163
  %K_reg3.sroa.14.16.copyload3223 = load <4 x half>, ptr addrspace(4) %add.ptr778.1.1, align 16, !dbg !164
  %K_reg3.sroa.22.16.add.ptr778.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %372, i64 1032, !dbg !164
  %K_reg3.sroa.22.16.copyload3226 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.22.16.add.ptr778.1.1.sroa_idx, align 8, !dbg !164
  br label %if.end786.1, !dbg !165

if.end786.1:                                      ; preds = %for.cond763.preheader.1, %if.end755.1
  %K_reg3.sroa.22.2 = phi <4 x half> [ %K_reg3.sroa.22.1, %if.end755.1 ], [ %K_reg3.sroa.22.16.copyload3226, %for.cond763.preheader.1 ]
  %K_reg3.sroa.14.2 = phi <4 x half> [ %K_reg3.sroa.14.1, %if.end755.1 ], [ %K_reg3.sroa.14.16.copyload3223, %for.cond763.preheader.1 ]
  %K_reg3.sroa.10.2 = phi <4 x half> [ %K_reg3.sroa.10.1, %if.end755.1 ], [ %K_reg3.sroa.10.0.copyload3214, %for.cond763.preheader.1 ]
  %K_reg3.sroa.0.2 = phi <4 x half> [ %K_reg3.sroa.0.1, %if.end755.1 ], [ %K_reg3.sroa.0.0.copyload3211, %for.cond763.preheader.1 ]
  br i1 %or.cond2039.1, label %if.end932.1, label %for.cond794.preheader.1, !dbg !165

for.cond794.preheader.1:                          ; preds = %if.end786.1
  %373 = shl nsw i32 %cond.i.i1897.4, 10
  %mul801.1 = and i32 %373, 64512
  %add804.1 = add nuw nsw i32 %add128, %mul801.1
  %374 = zext nneg i32 %add804.1 to i64, !dbg !166
  %add.ptr809.12201 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %374, !dbg !167
  %V_reg.sroa.0.0.copyload3112 = load <4 x half>, ptr addrspace(4) %add.ptr809.12201, align 16, !dbg !168
  %V_reg.sroa.34.0.add.ptr809.12201.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr809.12201, i64 8, !dbg !168
  %V_reg.sroa.34.0.copyload3127 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.34.0.add.ptr809.12201.sroa_idx, align 8, !dbg !168
  %375 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %374, !dbg !167
  %add.ptr809.1.1 = getelementptr inbounds i8, ptr addrspace(4) %375, i64 1024, !dbg !167
  %V_reg.sroa.50.16.copyload3172 = load <4 x half>, ptr addrspace(4) %add.ptr809.1.1, align 16, !dbg !168
  %V_reg.sroa.82.16.add.ptr809.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %375, i64 1032, !dbg !168
  %V_reg.sroa.82.16.copyload3187 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.82.16.add.ptr809.1.1.sroa_idx, align 8, !dbg !168
  br i1 %cmp95.not.1, label %for.cond821.preheader.1, label %if.end845.1, !dbg !169

for.cond821.preheader.1:                          ; preds = %for.cond794.preheader.1
  %add828.1 = add nuw nsw i32 %mul11.4, %mul827
  %cmp831.not.12202 = icmp sgt i32 %add828.1, %1, !dbg !170
  %fneg..12203 = select i1 %cmp831.not.12202, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2522 = insertelement <4 x float> poison, float %fneg..12203, i64 0, !dbg !171
  %cmp831.not.1.1.not = icmp slt i32 %add828.1, %1, !dbg !170
  %fneg..1.1 = select i1 %cmp831.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2701 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2522, float %fneg..1.1, i64 1, !dbg !171
  %add829.2.1 = or disjoint i32 %add828.1, 2, !dbg !172
  %cmp831.not.2.1 = icmp sgt i32 %add829.2.1, %1, !dbg !170
  %fneg..2.1 = select i1 %cmp831.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2874 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2701, float %fneg..2.1, i64 2, !dbg !171
  %add829.3.1 = or disjoint i32 %add828.1, 3, !dbg !172
  %cmp831.not.3.1 = icmp sgt i32 %add829.3.1, %1, !dbg !170
  %fneg..3.1 = select i1 %cmp831.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3047 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2874, float %fneg..3.1, i64 3, !dbg !171
  br label %if.end845.1

if.end845.1:                                      ; preds = %for.cond794.preheader.1, %for.cond821.preheader.1
  %acc_s.sroa.0.8 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3047, %for.cond821.preheader.1 ], [ zeroinitializer, %for.cond794.preheader.1 ], !dbg !173
  %376 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.2, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.8), !dbg !174, !call_argsrelate !175
  %377 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.10.2, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %376), !dbg !174, !call_argsrelate !175
  %378 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.14.2, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %377), !dbg !174, !call_argsrelate !175
  %379 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.22.2, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %378), !dbg !174, !call_argsrelate !175
  %acc_s.sroa.0.0.vec.extract2524 = extractelement <4 x float> %379, i64 0, !dbg !176
  %mul880.12207 = fmul contract float %acc_s.sroa.0.0.vec.extract2524, 0x3FB99999A0000000, !dbg !177
  %380 = tail call contract noundef float @llvm.minnum.f32(float %mul880.12207, float 0x4024CB5EC0000000), !dbg !178
  %381 = tail call contract noundef float @llvm.exp.f32(float %380), !dbg !180
  %acc_s.sroa.0.4.vec.extract2703 = extractelement <4 x float> %379, i64 1, !dbg !176
  %mul880.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2703, 0x3FB99999A0000000, !dbg !177
  %382 = tail call contract noundef float @llvm.minnum.f32(float %mul880.1.1, float 0x4024CB5EC0000000), !dbg !178
  %383 = tail call contract noundef float @llvm.exp.f32(float %382), !dbg !180
  %acc_s.sroa.0.8.vec.extract2876 = extractelement <4 x float> %379, i64 2, !dbg !176
  %mul880.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract2876, 0x3FB99999A0000000, !dbg !177
  %384 = tail call contract noundef float @llvm.minnum.f32(float %mul880.2.1, float 0x4024CB5EC0000000), !dbg !178
  %385 = tail call contract noundef float @llvm.exp.f32(float %384), !dbg !180
  %acc_s.sroa.0.12.vec.extract3049 = extractelement <4 x float> %379, i64 3, !dbg !176
  %mul880.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3049, 0x3FB99999A0000000, !dbg !177
  %386 = tail call contract noundef float @llvm.minnum.f32(float %mul880.3.1, float 0x4024CB5EC0000000), !dbg !178
  %387 = tail call contract noundef float @llvm.exp.f32(float %386), !dbg !180
  %add896.12208 = fadd contract float %sum_acc.sroa.0.3, %381, !dbg !258
  %add896.1.1 = fadd contract float %sum_acc.sroa.36.3, %383, !dbg !258
  %add896.2.1 = fadd contract float %sum_acc.sroa.70.3, %385, !dbg !258
  %add896.3.1 = fadd contract float %sum_acc.sroa.104.3, %387, !dbg !258
  %388 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %381), !dbg !182
  %389 = insertelement <4 x i16> poison, i16 %388, i64 0, !dbg !186
  %390 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %383), !dbg !182
  %391 = insertelement <4 x i16> %389, i16 %390, i64 1, !dbg !186
  %392 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %385), !dbg !182
  %393 = insertelement <4 x i16> %391, i16 %392, i64 2, !dbg !186
  %394 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %387), !dbg !182
  %395 = insertelement <4 x i16> %393, i16 %394, i64 3, !dbg !186
  %acc_s_cast.sroa.0.6.vec.insert2371 = bitcast <4 x i16> %395 to <4 x half>, !dbg !186
  %396 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload3112, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2371, <4 x float> %acc_o.sroa.0.2), !dbg !187, !call_argsrelate !99
  %397 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.34.0.copyload3127, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2371, <4 x float> %acc_o.sroa.42.2), !dbg !187, !call_argsrelate !99
  %398 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.50.16.copyload3172, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2371, <4 x float> %acc_o.sroa.82.2), !dbg !187, !call_argsrelate !99
  %399 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.82.16.copyload3187, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2371, <4 x float> %acc_o.sroa.122.2), !dbg !187, !call_argsrelate !99
  br label %if.end932.1, !dbg !188

if.end932.1:                                      ; preds = %if.end845.1, %if.end786.1
  %acc_o.sroa.122.3 = phi <4 x float> [ %acc_o.sroa.122.2, %if.end786.1 ], [ %399, %if.end845.1 ], !dbg !173
  %acc_o.sroa.82.3 = phi <4 x float> [ %acc_o.sroa.82.2, %if.end786.1 ], [ %398, %if.end845.1 ], !dbg !173
  %acc_o.sroa.42.3 = phi <4 x float> [ %acc_o.sroa.42.2, %if.end786.1 ], [ %397, %if.end845.1 ], !dbg !173
  %acc_o.sroa.0.3 = phi <4 x float> [ %acc_o.sroa.0.2, %if.end786.1 ], [ %396, %if.end845.1 ], !dbg !173
  %sum_acc.sroa.104.4 = phi float [ %sum_acc.sroa.104.3, %if.end786.1 ], [ %add896.3.1, %if.end845.1 ], !dbg !173
  %sum_acc.sroa.70.4 = phi float [ %sum_acc.sroa.70.3, %if.end786.1 ], [ %add896.2.1, %if.end845.1 ], !dbg !173
  %sum_acc.sroa.36.4 = phi float [ %sum_acc.sroa.36.3, %if.end786.1 ], [ %add896.1.1, %if.end845.1 ], !dbg !173
  %sum_acc.sroa.0.4 = phi float [ %sum_acc.sroa.0.3, %if.end786.1 ], [ %add896.12208, %if.end845.1 ], !dbg !173
  br i1 %or.cond2041.1, label %if.end1078.1, label %for.cond940.preheader.1, !dbg !188

for.cond940.preheader.1:                          ; preds = %if.end932.1
  %400 = shl nsw i32 %cond.i.i1897.5, 10
  %mul947.1 = and i32 %400, 64512
  %add950.1 = add nuw nsw i32 %add128, %mul947.1
  %401 = zext nneg i32 %add950.1 to i64, !dbg !189
  %add.ptr955.12209 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %401, !dbg !190
  %V_reg.sroa.0.0.copyload3113 = load <4 x half>, ptr addrspace(4) %add.ptr955.12209, align 16, !dbg !191
  %V_reg.sroa.34.0.add.ptr955.12209.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr955.12209, i64 8, !dbg !191
  %V_reg.sroa.34.0.copyload3128 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.34.0.add.ptr955.12209.sroa_idx, align 8, !dbg !191
  %402 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %401, !dbg !190
  %add.ptr955.1.1 = getelementptr inbounds i8, ptr addrspace(4) %402, i64 1024, !dbg !190
  %V_reg.sroa.50.16.copyload3173 = load <4 x half>, ptr addrspace(4) %add.ptr955.1.1, align 16, !dbg !191
  %V_reg.sroa.82.16.add.ptr955.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %402, i64 1032, !dbg !191
  %V_reg.sroa.82.16.copyload3188 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.82.16.add.ptr955.1.1.sroa_idx, align 8, !dbg !191
  %cmp965.1 = icmp sgt i32 %mul11.5, %invariant.op, !dbg !192
  br i1 %cmp965.1, label %for.cond967.preheader.1, label %if.end991.1, !dbg !193

for.cond967.preheader.1:                          ; preds = %for.cond940.preheader.1
  %add974.1 = add nuw nsw i32 %mul11.5, %mul827
  %cmp977.not.12210 = icmp sgt i32 %add974.1, %1, !dbg !194
  %fneg.1886.12211 = select i1 %cmp977.not.12210, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2534 = insertelement <4 x float> poison, float %fneg.1886.12211, i64 0, !dbg !195
  %cmp977.not.1.1.not = icmp slt i32 %add974.1, %1, !dbg !194
  %fneg.1886.1.1 = select i1 %cmp977.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2711 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2534, float %fneg.1886.1.1, i64 1, !dbg !195
  %add975.2.1 = or disjoint i32 %add974.1, 2, !dbg !196
  %cmp977.not.2.1 = icmp sgt i32 %add975.2.1, %1, !dbg !194
  %fneg.1886.2.1 = select i1 %cmp977.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2884 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2711, float %fneg.1886.2.1, i64 2, !dbg !195
  %add975.3.1 = or disjoint i32 %add974.1, 3, !dbg !196
  %cmp977.not.3.1 = icmp sgt i32 %add975.3.1, %1, !dbg !194
  %fneg.1886.3.1 = select i1 %cmp977.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3057 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2884, float %fneg.1886.3.1, i64 3, !dbg !195
  br label %if.end991.1

if.end991.1:                                      ; preds = %for.cond940.preheader.1, %for.cond967.preheader.1
  %acc_s.sroa.0.10 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3057, %for.cond967.preheader.1 ], [ zeroinitializer, %for.cond940.preheader.1 ], !dbg !173
  %403 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.2, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.10), !dbg !197, !call_argsrelate !175
  %404 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.10.2, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %403), !dbg !197, !call_argsrelate !175
  %405 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.14.2, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %404), !dbg !197, !call_argsrelate !175
  %406 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.22.2, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %405), !dbg !197, !call_argsrelate !175
  %acc_s.sroa.0.0.vec.extract2536 = extractelement <4 x float> %406, i64 0, !dbg !198
  %mul1026.12215 = fmul contract float %acc_s.sroa.0.0.vec.extract2536, 0x3FB99999A0000000, !dbg !199
  %407 = tail call contract noundef float @llvm.minnum.f32(float %mul1026.12215, float 0x4024CB5EC0000000), !dbg !200
  %408 = tail call contract noundef float @llvm.exp.f32(float %407), !dbg !202
  %acc_s.sroa.0.4.vec.extract2713 = extractelement <4 x float> %406, i64 1, !dbg !198
  %mul1026.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2713, 0x3FB99999A0000000, !dbg !199
  %409 = tail call contract noundef float @llvm.minnum.f32(float %mul1026.1.1, float 0x4024CB5EC0000000), !dbg !200
  %410 = tail call contract noundef float @llvm.exp.f32(float %409), !dbg !202
  %acc_s.sroa.0.8.vec.extract2886 = extractelement <4 x float> %406, i64 2, !dbg !198
  %mul1026.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract2886, 0x3FB99999A0000000, !dbg !199
  %411 = tail call contract noundef float @llvm.minnum.f32(float %mul1026.2.1, float 0x4024CB5EC0000000), !dbg !200
  %412 = tail call contract noundef float @llvm.exp.f32(float %411), !dbg !202
  %acc_s.sroa.0.12.vec.extract3059 = extractelement <4 x float> %406, i64 3, !dbg !198
  %mul1026.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3059, 0x3FB99999A0000000, !dbg !199
  %413 = tail call contract noundef float @llvm.minnum.f32(float %mul1026.3.1, float 0x4024CB5EC0000000), !dbg !200
  %414 = tail call contract noundef float @llvm.exp.f32(float %413), !dbg !202
  %add1042.12216 = fadd contract float %sum_acc.sroa.0.4, %408, !dbg !204
  %add1042.1.1 = fadd contract float %sum_acc.sroa.36.4, %410, !dbg !204
  %add1042.2.1 = fadd contract float %sum_acc.sroa.70.4, %412, !dbg !204
  %add1042.3.1 = fadd contract float %sum_acc.sroa.104.4, %414, !dbg !204
  %415 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %408), !dbg !205
  %416 = insertelement <4 x i16> poison, i16 %415, i64 0, !dbg !209
  %417 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %410), !dbg !205
  %418 = insertelement <4 x i16> %416, i16 %417, i64 1, !dbg !209
  %419 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %412), !dbg !205
  %420 = insertelement <4 x i16> %418, i16 %419, i64 2, !dbg !209
  %421 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %414), !dbg !205
  %422 = insertelement <4 x i16> %420, i16 %421, i64 3, !dbg !209
  %acc_s_cast.sroa.0.6.vec.insert2373 = bitcast <4 x i16> %422 to <4 x half>, !dbg !209
  %423 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload3113, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2373, <4 x float> %acc_o_alt.sroa.0.1), !dbg !210, !call_argsrelate !99
  %424 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.34.0.copyload3128, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2373, <4 x float> %acc_o_alt.sroa.26.1), !dbg !210, !call_argsrelate !99
  %425 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.50.16.copyload3173, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2373, <4 x float> %acc_o_alt.sroa.50.1), !dbg !210, !call_argsrelate !99
  %426 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.82.16.copyload3188, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2373, <4 x float> %acc_o_alt.sroa.74.1), !dbg !210, !call_argsrelate !99
  br label %if.end1078.1, !dbg !211

if.end1078.1:                                     ; preds = %if.end991.1, %if.end932.1
  %acc_o_alt.sroa.74.2 = phi <4 x float> [ %acc_o_alt.sroa.74.1, %if.end932.1 ], [ %426, %if.end991.1 ], !dbg !173
  %acc_o_alt.sroa.50.2 = phi <4 x float> [ %acc_o_alt.sroa.50.1, %if.end932.1 ], [ %425, %if.end991.1 ], !dbg !173
  %acc_o_alt.sroa.26.2 = phi <4 x float> [ %acc_o_alt.sroa.26.1, %if.end932.1 ], [ %424, %if.end991.1 ], !dbg !173
  %acc_o_alt.sroa.0.2 = phi <4 x float> [ %acc_o_alt.sroa.0.1, %if.end932.1 ], [ %423, %if.end991.1 ], !dbg !173
  %sum_acc.sroa.104.5 = phi float [ %sum_acc.sroa.104.4, %if.end932.1 ], [ %add1042.3.1, %if.end991.1 ], !dbg !173
  %sum_acc.sroa.70.5 = phi float [ %sum_acc.sroa.70.4, %if.end932.1 ], [ %add1042.2.1, %if.end991.1 ], !dbg !173
  %sum_acc.sroa.36.5 = phi float [ %sum_acc.sroa.36.4, %if.end932.1 ], [ %add1042.1.1, %if.end991.1 ], !dbg !173
  %sum_acc.sroa.0.5 = phi float [ %sum_acc.sroa.0.4, %if.end932.1 ], [ %add1042.12216, %if.end991.1 ], !dbg !173
  br i1 %or.cond2043.1, label %if.end1224.1, label %for.cond1086.preheader.1, !dbg !211

for.cond1086.preheader.1:                         ; preds = %if.end1078.1
  %427 = shl nsw i32 %cond.i.i1897.6, 10
  %mul1093.1 = and i32 %427, 64512
  %add1096.1 = add nuw nsw i32 %add128, %mul1093.1
  %428 = zext nneg i32 %add1096.1 to i64, !dbg !212
  %add.ptr1101.12217 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %428, !dbg !213
  %V_reg.sroa.0.0.copyload3114 = load <4 x half>, ptr addrspace(4) %add.ptr1101.12217, align 16, !dbg !214
  %V_reg.sroa.34.0.add.ptr1101.12217.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1101.12217, i64 8, !dbg !214
  %V_reg.sroa.34.0.copyload3129 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.34.0.add.ptr1101.12217.sroa_idx, align 8, !dbg !214
  %429 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %428, !dbg !213
  %add.ptr1101.1.1 = getelementptr inbounds i8, ptr addrspace(4) %429, i64 1024, !dbg !213
  %V_reg.sroa.50.16.copyload3174 = load <4 x half>, ptr addrspace(4) %add.ptr1101.1.1, align 16, !dbg !214
  %V_reg.sroa.82.16.add.ptr1101.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %429, i64 1032, !dbg !214
  %V_reg.sroa.82.16.copyload3189 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.82.16.add.ptr1101.1.1.sroa_idx, align 8, !dbg !214
  %cmp1111.1 = icmp sgt i32 %mul11.6, %invariant.op, !dbg !215
  br i1 %cmp1111.1, label %for.cond1113.preheader.1, label %if.end1137.1, !dbg !216

for.cond1113.preheader.1:                         ; preds = %for.cond1086.preheader.1
  %add1120.1 = add nuw nsw i32 %mul11.6, %mul827
  %cmp1123.not.12218 = icmp sgt i32 %add1120.1, %1, !dbg !217
  %fneg.1887.12219 = select i1 %cmp1123.not.12218, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2546 = insertelement <4 x float> poison, float %fneg.1887.12219, i64 0, !dbg !218
  %cmp1123.not.1.1.not = icmp slt i32 %add1120.1, %1, !dbg !217
  %fneg.1887.1.1 = select i1 %cmp1123.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2721 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2546, float %fneg.1887.1.1, i64 1, !dbg !218
  %add1121.2.1 = or disjoint i32 %add1120.1, 2, !dbg !219
  %cmp1123.not.2.1 = icmp sgt i32 %add1121.2.1, %1, !dbg !217
  %fneg.1887.2.1 = select i1 %cmp1123.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2894 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2721, float %fneg.1887.2.1, i64 2, !dbg !218
  %add1121.3.1 = or disjoint i32 %add1120.1, 3, !dbg !219
  %cmp1123.not.3.1 = icmp sgt i32 %add1121.3.1, %1, !dbg !217
  %fneg.1887.3.1 = select i1 %cmp1123.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3067 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2894, float %fneg.1887.3.1, i64 3, !dbg !218
  br label %if.end1137.1

if.end1137.1:                                     ; preds = %for.cond1086.preheader.1, %for.cond1113.preheader.1
  %acc_s.sroa.0.12 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3067, %for.cond1113.preheader.1 ], [ zeroinitializer, %for.cond1086.preheader.1 ], !dbg !173
  %430 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.0.2, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.12), !dbg !220, !call_argsrelate !175
  %431 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.10.2, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %430), !dbg !220, !call_argsrelate !175
  %432 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.14.2, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %431), !dbg !220, !call_argsrelate !175
  %433 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.22.2, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %432), !dbg !220, !call_argsrelate !175
  %acc_s.sroa.0.0.vec.extract2548 = extractelement <4 x float> %433, i64 0, !dbg !221
  %mul1172.12223 = fmul contract float %acc_s.sroa.0.0.vec.extract2548, 0x3FB99999A0000000, !dbg !222
  %434 = tail call contract noundef float @llvm.minnum.f32(float %mul1172.12223, float 0x4024CB5EC0000000), !dbg !223
  %435 = tail call contract noundef float @llvm.exp.f32(float %434), !dbg !225
  %acc_s.sroa.0.4.vec.extract2723 = extractelement <4 x float> %433, i64 1, !dbg !221
  %mul1172.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2723, 0x3FB99999A0000000, !dbg !222
  %436 = tail call contract noundef float @llvm.minnum.f32(float %mul1172.1.1, float 0x4024CB5EC0000000), !dbg !223
  %437 = tail call contract noundef float @llvm.exp.f32(float %436), !dbg !225
  %acc_s.sroa.0.8.vec.extract2896 = extractelement <4 x float> %433, i64 2, !dbg !221
  %mul1172.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract2896, 0x3FB99999A0000000, !dbg !222
  %438 = tail call contract noundef float @llvm.minnum.f32(float %mul1172.2.1, float 0x4024CB5EC0000000), !dbg !223
  %439 = tail call contract noundef float @llvm.exp.f32(float %438), !dbg !225
  %acc_s.sroa.0.12.vec.extract3069 = extractelement <4 x float> %433, i64 3, !dbg !221
  %mul1172.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3069, 0x3FB99999A0000000, !dbg !222
  %440 = tail call contract noundef float @llvm.minnum.f32(float %mul1172.3.1, float 0x4024CB5EC0000000), !dbg !223
  %441 = tail call contract noundef float @llvm.exp.f32(float %440), !dbg !225
  %add1188.12224 = fadd contract float %sum_acc.sroa.0.5, %435, !dbg !227
  %add1188.1.1 = fadd contract float %sum_acc.sroa.36.5, %437, !dbg !227
  %add1188.2.1 = fadd contract float %sum_acc.sroa.70.5, %439, !dbg !227
  %add1188.3.1 = fadd contract float %sum_acc.sroa.104.5, %441, !dbg !227
  %442 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %435), !dbg !228
  %443 = insertelement <4 x i16> poison, i16 %442, i64 0, !dbg !232
  %444 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %437), !dbg !228
  %445 = insertelement <4 x i16> %443, i16 %444, i64 1, !dbg !232
  %446 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %439), !dbg !228
  %447 = insertelement <4 x i16> %445, i16 %446, i64 2, !dbg !232
  %448 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %441), !dbg !228
  %449 = insertelement <4 x i16> %447, i16 %448, i64 3, !dbg !232
  %acc_s_cast.sroa.0.6.vec.insert2375 = bitcast <4 x i16> %449 to <4 x half>, !dbg !232
  %450 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload3114, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2375, <4 x float> %acc_o.sroa.0.3), !dbg !233, !call_argsrelate !99
  %451 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.34.0.copyload3129, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2375, <4 x float> %acc_o.sroa.42.3), !dbg !233, !call_argsrelate !99
  %452 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.50.16.copyload3174, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2375, <4 x float> %acc_o.sroa.82.3), !dbg !233, !call_argsrelate !99
  %453 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.82.16.copyload3189, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2375, <4 x float> %acc_o.sroa.122.3), !dbg !233, !call_argsrelate !99
  br label %if.end1224.1, !dbg !234

if.end1224.1:                                     ; preds = %if.end1137.1, %if.end1078.1
  %acc_o.sroa.122.4 = phi <4 x float> [ %acc_o.sroa.122.3, %if.end1078.1 ], [ %453, %if.end1137.1 ], !dbg !173
  %acc_o.sroa.82.4 = phi <4 x float> [ %acc_o.sroa.82.3, %if.end1078.1 ], [ %452, %if.end1137.1 ], !dbg !173
  %acc_o.sroa.42.4 = phi <4 x float> [ %acc_o.sroa.42.3, %if.end1078.1 ], [ %451, %if.end1137.1 ], !dbg !173
  %acc_o.sroa.0.4 = phi <4 x float> [ %acc_o.sroa.0.3, %if.end1078.1 ], [ %450, %if.end1137.1 ], !dbg !173
  %sum_acc.sroa.104.6 = phi float [ %sum_acc.sroa.104.5, %if.end1078.1 ], [ %add1188.3.1, %if.end1137.1 ], !dbg !173
  %sum_acc.sroa.70.6 = phi float [ %sum_acc.sroa.70.5, %if.end1078.1 ], [ %add1188.2.1, %if.end1137.1 ], !dbg !173
  %sum_acc.sroa.36.6 = phi float [ %sum_acc.sroa.36.5, %if.end1078.1 ], [ %add1188.1.1, %if.end1137.1 ], !dbg !173
  %sum_acc.sroa.0.6 = phi float [ %sum_acc.sroa.0.5, %if.end1078.1 ], [ %add1188.12224, %if.end1137.1 ], !dbg !173
  br i1 %or.cond2045.1, label %if.end1371.1, label %for.cond1232.preheader.1, !dbg !234

for.cond1232.preheader.1:                         ; preds = %if.end1224.1
  %454 = shl nsw i32 %cond.i.i1897.7, 10
  %mul1239.1 = and i32 %454, 64512
  %add1242.1 = add nuw nsw i32 %add128, %mul1239.1
  %455 = zext nneg i32 %add1242.1 to i64, !dbg !235
  %add.ptr1247.12225 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %455, !dbg !236
  %V_reg.sroa.0.0.copyload3115 = load <4 x half>, ptr addrspace(4) %add.ptr1247.12225, align 16, !dbg !237
  %V_reg.sroa.34.0.add.ptr1247.12225.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1247.12225, i64 8, !dbg !237
  %V_reg.sroa.34.0.copyload3130 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.34.0.add.ptr1247.12225.sroa_idx, align 8, !dbg !237
  %456 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %455, !dbg !236
  %add.ptr1247.1.1 = getelementptr inbounds i8, ptr addrspace(4) %456, i64 1024, !dbg !236
  %V_reg.sroa.50.16.copyload3175 = load <4 x half>, ptr addrspace(4) %add.ptr1247.1.1, align 16, !dbg !237
  %V_reg.sroa.82.16.add.ptr1247.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %456, i64 1032, !dbg !237
  %V_reg.sroa.82.16.copyload3190 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.82.16.add.ptr1247.1.1.sroa_idx, align 8, !dbg !237
  %cmp1257.1 = icmp sgt i32 %mul11.7, %invariant.op, !dbg !238
  br i1 %cmp1257.1, label %for.cond1259.preheader.1, label %if.end1283.1, !dbg !239

for.cond1259.preheader.1:                         ; preds = %for.cond1232.preheader.1
  %add1266.1 = add nuw nsw i32 %mul11.7, %mul827
  %cmp1269.not.12226 = icmp sgt i32 %add1266.1, %1, !dbg !240
  %fneg.1888.12227 = select i1 %cmp1269.not.12226, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2558 = insertelement <4 x float> poison, float %fneg.1888.12227, i64 0, !dbg !241
  %cmp1269.not.1.1.not = icmp slt i32 %add1266.1, %1, !dbg !240
  %fneg.1888.1.1 = select i1 %cmp1269.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2731 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2558, float %fneg.1888.1.1, i64 1, !dbg !241
  %add1267.2.1 = or disjoint i32 %add1266.1, 2, !dbg !242
  %cmp1269.not.2.1 = icmp sgt i32 %add1267.2.1, %1, !dbg !240
  %fneg.1888.2.1 = select i1 %cmp1269.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2904 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2731, float %fneg.1888.2.1, i64 2, !dbg !241
  %add1267.3.1 = or disjoint i32 %add1266.1, 3, !dbg !242
  %cmp1269.not.3.1 = icmp sgt i32 %add1267.3.1, %1, !dbg !240
  %fneg.1888.3.1 = select i1 %cmp1269.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3077 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2904, float %fneg.1888.3.1, i64 3, !dbg !241
  br label %if.end1283.1

if.end1283.1:                                     ; preds = %for.cond1232.preheader.1, %for.cond1259.preheader.1
  %acc_s.sroa.0.14 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3077, %for.cond1259.preheader.1 ], [ zeroinitializer, %for.cond1232.preheader.1 ], !dbg !173
  %457 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.0.2, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.14), !dbg !243, !call_argsrelate !175
  %458 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.10.2, <4 x half> %Q_reg.sroa.19.0.copyload, <4 x float> %457), !dbg !243, !call_argsrelate !175
  %459 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.14.2, <4 x half> %Q_reg.sroa.35.16.copyload, <4 x float> %458), !dbg !243, !call_argsrelate !175
  %460 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.22.2, <4 x half> %Q_reg.sroa.52.16.copyload, <4 x float> %459), !dbg !243, !call_argsrelate !175
  %acc_s.sroa.0.0.vec.extract2560 = extractelement <4 x float> %460, i64 0, !dbg !244
  %mul1318.12231 = fmul contract float %acc_s.sroa.0.0.vec.extract2560, 0x3FB99999A0000000, !dbg !245
  %461 = tail call contract noundef float @llvm.minnum.f32(float %mul1318.12231, float 0x4024CB5EC0000000), !dbg !246
  %462 = tail call contract noundef float @llvm.exp.f32(float %461), !dbg !248
  %acc_s.sroa.0.4.vec.extract2733 = extractelement <4 x float> %460, i64 1, !dbg !244
  %mul1318.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2733, 0x3FB99999A0000000, !dbg !245
  %463 = tail call contract noundef float @llvm.minnum.f32(float %mul1318.1.1, float 0x4024CB5EC0000000), !dbg !246
  %464 = tail call contract noundef float @llvm.exp.f32(float %463), !dbg !248
  %acc_s.sroa.0.8.vec.extract2906 = extractelement <4 x float> %460, i64 2, !dbg !244
  %mul1318.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract2906, 0x3FB99999A0000000, !dbg !245
  %465 = tail call contract noundef float @llvm.minnum.f32(float %mul1318.2.1, float 0x4024CB5EC0000000), !dbg !246
  %466 = tail call contract noundef float @llvm.exp.f32(float %465), !dbg !248
  %acc_s.sroa.0.12.vec.extract3079 = extractelement <4 x float> %460, i64 3, !dbg !244
  %mul1318.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract3079, 0x3FB99999A0000000, !dbg !245
  %467 = tail call contract noundef float @llvm.minnum.f32(float %mul1318.3.1, float 0x4024CB5EC0000000), !dbg !246
  %468 = tail call contract noundef float @llvm.exp.f32(float %467), !dbg !248
  %add1334.12232 = fadd contract float %sum_acc.sroa.0.6, %462, !dbg !250
  %add1334.1.1 = fadd contract float %sum_acc.sroa.36.6, %464, !dbg !250
  %add1334.2.1 = fadd contract float %sum_acc.sroa.70.6, %466, !dbg !250
  %add1334.3.1 = fadd contract float %sum_acc.sroa.104.6, %468, !dbg !250
  %469 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %462), !dbg !251
  %470 = insertelement <4 x i16> poison, i16 %469, i64 0, !dbg !255
  %471 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %464), !dbg !251
  %472 = insertelement <4 x i16> %470, i16 %471, i64 1, !dbg !255
  %473 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %466), !dbg !251
  %474 = insertelement <4 x i16> %472, i16 %473, i64 2, !dbg !255
  %475 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %468), !dbg !251
  %476 = insertelement <4 x i16> %474, i16 %475, i64 3, !dbg !255
  %acc_s_cast.sroa.0.6.vec.insert2377 = bitcast <4 x i16> %476 to <4 x half>, !dbg !255
  %477 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload3115, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2377, <4 x float> %acc_o_alt.sroa.0.2), !dbg !256, !call_argsrelate !99
  %478 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.34.0.copyload3130, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2377, <4 x float> %acc_o_alt.sroa.26.2), !dbg !256, !call_argsrelate !99
  %479 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.50.16.copyload3175, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2377, <4 x float> %acc_o_alt.sroa.50.2), !dbg !256, !call_argsrelate !99
  %480 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.82.16.copyload3190, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2377, <4 x float> %acc_o_alt.sroa.74.2), !dbg !256, !call_argsrelate !99
  br label %if.end1371.1, !dbg !148

if.end1371.1:                                     ; preds = %if.end1283.1, %if.end1224.1, %for.cond120.preheader.1
  %acc_o.sroa.122.5 = phi <4 x float> [ %acc_o.sroa.122.4, %if.end1224.1 ], [ %acc_o.sroa.122.4, %if.end1283.1 ], [ %336, %for.cond120.preheader.1 ], !dbg !173
  %acc_o.sroa.82.5 = phi <4 x float> [ %acc_o.sroa.82.4, %if.end1224.1 ], [ %acc_o.sroa.82.4, %if.end1283.1 ], [ %335, %for.cond120.preheader.1 ], !dbg !173
  %acc_o.sroa.42.5 = phi <4 x float> [ %acc_o.sroa.42.4, %if.end1224.1 ], [ %acc_o.sroa.42.4, %if.end1283.1 ], [ %334, %for.cond120.preheader.1 ], !dbg !173
  %acc_o.sroa.0.5 = phi <4 x float> [ %acc_o.sroa.0.4, %if.end1224.1 ], [ %acc_o.sroa.0.4, %if.end1283.1 ], [ %333, %for.cond120.preheader.1 ], !dbg !173
  %acc_o_alt.sroa.74.3 = phi <4 x float> [ %acc_o_alt.sroa.74.2, %if.end1224.1 ], [ %480, %if.end1283.1 ], [ %360, %for.cond120.preheader.1 ], !dbg !173
  %acc_o_alt.sroa.50.3 = phi <4 x float> [ %acc_o_alt.sroa.50.2, %if.end1224.1 ], [ %479, %if.end1283.1 ], [ %359, %for.cond120.preheader.1 ], !dbg !173
  %acc_o_alt.sroa.26.3 = phi <4 x float> [ %acc_o_alt.sroa.26.2, %if.end1224.1 ], [ %478, %if.end1283.1 ], [ %358, %for.cond120.preheader.1 ], !dbg !173
  %acc_o_alt.sroa.0.3 = phi <4 x float> [ %acc_o_alt.sroa.0.2, %if.end1224.1 ], [ %477, %if.end1283.1 ], [ %357, %for.cond120.preheader.1 ], !dbg !173
  %sum_acc.sroa.104.7 = phi float [ %sum_acc.sroa.104.6, %if.end1224.1 ], [ %add1334.3.1, %if.end1283.1 ], [ %add628.3.1, %for.cond120.preheader.1 ], !dbg !173
  %sum_acc.sroa.70.7 = phi float [ %sum_acc.sroa.70.6, %if.end1224.1 ], [ %add1334.2.1, %if.end1283.1 ], [ %add628.2.1, %for.cond120.preheader.1 ], !dbg !173
  %sum_acc.sroa.36.7 = phi float [ %sum_acc.sroa.36.6, %if.end1224.1 ], [ %add1334.1.1, %if.end1283.1 ], [ %add628.1.1, %for.cond120.preheader.1 ], !dbg !173
  %sum_acc.sroa.0.7 = phi float [ %sum_acc.sroa.0.6, %if.end1224.1 ], [ %add1334.12232, %if.end1283.1 ], [ %add628.12196, %for.cond120.preheader.1 ], !dbg !173
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.5, i64 0, !dbg !259
  %acc_o_alt.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 0, !dbg !260
  %add1383 = fadd contract float %acc_o.sroa.0.0.vec.extract, %acc_o_alt.sroa.0.0.vec.extract, !dbg !261
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.5, i64 1, !dbg !259
  %acc_o_alt.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 1, !dbg !260
  %add1383.1 = fadd contract float %acc_o.sroa.0.4.vec.extract, %acc_o_alt.sroa.0.4.vec.extract, !dbg !261
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.5, i64 2, !dbg !259
  %acc_o_alt.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 2, !dbg !260
  %add1383.2 = fadd contract float %acc_o.sroa.0.8.vec.extract, %acc_o_alt.sroa.0.8.vec.extract, !dbg !261
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.5, i64 3, !dbg !259
  %acc_o_alt.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 3, !dbg !260
  %add1383.3 = fadd contract float %acc_o.sroa.0.12.vec.extract, %acc_o_alt.sroa.0.12.vec.extract, !dbg !261
  %acc_o.sroa.42.16.vec.extract = extractelement <4 x float> %acc_o.sroa.42.5, i64 0, !dbg !259
  %acc_o_alt.sroa.26.16.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.26.3, i64 0, !dbg !260
  %add1383.4 = fadd contract float %acc_o.sroa.42.16.vec.extract, %acc_o_alt.sroa.26.16.vec.extract, !dbg !261
  %acc_o.sroa.42.20.vec.extract = extractelement <4 x float> %acc_o.sroa.42.5, i64 1, !dbg !259
  %acc_o_alt.sroa.26.20.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.26.3, i64 1, !dbg !260
  %add1383.5 = fadd contract float %acc_o.sroa.42.20.vec.extract, %acc_o_alt.sroa.26.20.vec.extract, !dbg !261
  %acc_o.sroa.42.24.vec.extract = extractelement <4 x float> %acc_o.sroa.42.5, i64 2, !dbg !259
  %acc_o_alt.sroa.26.24.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.26.3, i64 2, !dbg !260
  %add1383.6 = fadd contract float %acc_o.sroa.42.24.vec.extract, %acc_o_alt.sroa.26.24.vec.extract, !dbg !261
  %acc_o.sroa.42.28.vec.extract = extractelement <4 x float> %acc_o.sroa.42.5, i64 3, !dbg !259
  %acc_o_alt.sroa.26.28.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.26.3, i64 3, !dbg !260
  %add1383.7 = fadd contract float %acc_o.sroa.42.28.vec.extract, %acc_o_alt.sroa.26.28.vec.extract, !dbg !261
  %acc_o.sroa.82.32.vec.extract = extractelement <4 x float> %acc_o.sroa.82.5, i64 0, !dbg !259
  %acc_o_alt.sroa.50.32.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 0, !dbg !260
  %add1383.8 = fadd contract float %acc_o.sroa.82.32.vec.extract, %acc_o_alt.sroa.50.32.vec.extract, !dbg !261
  %acc_o.sroa.82.36.vec.extract = extractelement <4 x float> %acc_o.sroa.82.5, i64 1, !dbg !259
  %acc_o_alt.sroa.50.36.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 1, !dbg !260
  %add1383.9 = fadd contract float %acc_o.sroa.82.36.vec.extract, %acc_o_alt.sroa.50.36.vec.extract, !dbg !261
  %acc_o.sroa.82.40.vec.extract = extractelement <4 x float> %acc_o.sroa.82.5, i64 2, !dbg !259
  %acc_o_alt.sroa.50.40.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 2, !dbg !260
  %add1383.10 = fadd contract float %acc_o.sroa.82.40.vec.extract, %acc_o_alt.sroa.50.40.vec.extract, !dbg !261
  %acc_o.sroa.82.44.vec.extract = extractelement <4 x float> %acc_o.sroa.82.5, i64 3, !dbg !259
  %acc_o_alt.sroa.50.44.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 3, !dbg !260
  %add1383.11 = fadd contract float %acc_o.sroa.82.44.vec.extract, %acc_o_alt.sroa.50.44.vec.extract, !dbg !261
  %acc_o.sroa.122.48.vec.extract = extractelement <4 x float> %acc_o.sroa.122.5, i64 0, !dbg !259
  %acc_o_alt.sroa.74.48.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.74.3, i64 0, !dbg !260
  %add1383.12 = fadd contract float %acc_o.sroa.122.48.vec.extract, %acc_o_alt.sroa.74.48.vec.extract, !dbg !261
  %acc_o.sroa.122.52.vec.extract = extractelement <4 x float> %acc_o.sroa.122.5, i64 1, !dbg !259
  %acc_o_alt.sroa.74.52.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.74.3, i64 1, !dbg !260
  %add1383.13 = fadd contract float %acc_o.sroa.122.52.vec.extract, %acc_o_alt.sroa.74.52.vec.extract, !dbg !261
  %acc_o.sroa.122.56.vec.extract = extractelement <4 x float> %acc_o.sroa.122.5, i64 2, !dbg !259
  %acc_o_alt.sroa.74.56.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.74.3, i64 2, !dbg !260
  %add1383.14 = fadd contract float %acc_o.sroa.122.56.vec.extract, %acc_o_alt.sroa.74.56.vec.extract, !dbg !261
  %acc_o.sroa.122.60.vec.extract = extractelement <4 x float> %acc_o.sroa.122.5, i64 3, !dbg !259
  %acc_o_alt.sroa.74.60.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.74.3, i64 3, !dbg !260
  %add1383.15 = fadd contract float %acc_o.sroa.122.60.vec.extract, %acc_o_alt.sroa.74.60.vec.extract, !dbg !261
  %add1397 = fadd contract float %sum_acc.sroa.0.7, 0.000000e+00, !dbg !262
  %add1397.1 = fadd contract float %add1397, %sum_acc.sroa.36.7, !dbg !262
  %add1397.2 = fadd contract float %add1397.1, %sum_acc.sroa.70.7, !dbg !262
  %add1397.3 = fadd contract float %add1397.2, %sum_acc.sroa.104.7, !dbg !262
  %481 = bitcast float %add1397.3 to i32, !dbg !263
  %482 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !275
  %483 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %482) #11, !dbg !280
  %xor.i.i = xor i32 %483, 32, !dbg !281
  %484 = and i32 %483, -64, !dbg !282
  %and.i.i = add nsw i32 %484, 64, !dbg !282
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !283
  %cond.i.i1898 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %483, !dbg !284
  %shl.i.i = shl i32 %cond.i.i1898, 2, !dbg !285
  %485 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %481), !dbg !286
  %486 = bitcast i32 %485 to float, !dbg !287
  %add.i = fadd contract float %add1397.3, %486, !dbg !288
  %487 = bitcast float %add.i to i32, !dbg !291
  %488 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !298
  %489 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %488) #11, !dbg !301
  %xor.i.i1899 = xor i32 %489, 16, !dbg !302
  %490 = and i32 %489, -64, !dbg !303
  %and.i.i1900 = add nsw i32 %490, 64, !dbg !303
  %cmp.not.i.i1901 = icmp slt i32 %xor.i.i1899, %and.i.i1900, !dbg !304
  %cond.i.i1902 = select i1 %cmp.not.i.i1901, i32 %xor.i.i1899, i32 %489, !dbg !305
  %shl.i.i1903 = shl i32 %cond.i.i1902, 2, !dbg !306
  %491 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i1903, i32 %487), !dbg !307
  %492 = bitcast i32 %491 to float, !dbg !308
  %add.i.i = fadd contract float %add.i, %492, !dbg !309
  %cmp1406 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !311
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !312
  %condval_4.0 = select i1 %cmp1406, float %div, float 0.000000e+00, !dbg !312
  %mul1419 = fmul contract float %condval_4.0, %add1383, !dbg !313
  %mul1419.1 = fmul contract float %condval_4.0, %add1383.1, !dbg !313
  %mul1419.2 = fmul contract float %condval_4.0, %add1383.2, !dbg !313
  %mul1419.3 = fmul contract float %condval_4.0, %add1383.3, !dbg !313
  %mul1419.4 = fmul contract float %condval_4.0, %add1383.4, !dbg !313
  %mul1419.5 = fmul contract float %condval_4.0, %add1383.5, !dbg !313
  %mul1419.6 = fmul contract float %condval_4.0, %add1383.6, !dbg !313
  %mul1419.7 = fmul contract float %condval_4.0, %add1383.7, !dbg !313
  %mul1419.8 = fmul contract float %condval_4.0, %add1383.8, !dbg !313
  %mul1419.9 = fmul contract float %condval_4.0, %add1383.9, !dbg !313
  %mul1419.10 = fmul contract float %condval_4.0, %add1383.10, !dbg !313
  %mul1419.11 = fmul contract float %condval_4.0, %add1383.11, !dbg !313
  %mul1419.12 = fmul contract float %condval_4.0, %add1383.12, !dbg !313
  %mul1419.13 = fmul contract float %condval_4.0, %add1383.13, !dbg !313
  %mul1419.14 = fmul contract float %condval_4.0, %add1383.14, !dbg !313
  %mul1419.15 = fmul contract float %condval_4.0, %add1383.15, !dbg !313
  %493 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1419), !dbg !314
  %O_reg.sroa.0.0.insert.ext = zext i16 %493 to i64, !dbg !318
  %494 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1419.1), !dbg !314
  %O_reg.sroa.0.2.insert.ext = zext i16 %494 to i64, !dbg !318
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !318
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !318
  %495 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1419.2), !dbg !314
  %O_reg.sroa.0.4.insert.ext = zext i16 %495 to i64, !dbg !318
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !318
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !318
  %496 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1419.3), !dbg !314
  %O_reg.sroa.0.6.insert.ext = zext i16 %496 to i64, !dbg !318
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !318
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !318
  %497 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1419.4), !dbg !314
  %O_reg.sroa.7.8.insert.ext = zext i16 %497 to i64, !dbg !318
  %498 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1419.5), !dbg !314
  %O_reg.sroa.7.10.insert.ext = zext i16 %498 to i64, !dbg !318
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !318
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !318
  %499 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1419.6), !dbg !314
  %O_reg.sroa.7.12.insert.ext = zext i16 %499 to i64, !dbg !318
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !318
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !318
  %500 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1419.7), !dbg !314
  %O_reg.sroa.7.14.insert.ext = zext i16 %500 to i64, !dbg !318
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !318
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !318
  %501 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1419.8), !dbg !314
  %O_reg.sroa.12.16.insert.ext = zext i16 %501 to i64, !dbg !318
  %502 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1419.9), !dbg !314
  %O_reg.sroa.12.18.insert.ext = zext i16 %502 to i64, !dbg !318
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !318
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !318
  %503 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1419.10), !dbg !314
  %O_reg.sroa.12.20.insert.ext = zext i16 %503 to i64, !dbg !318
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !318
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !318
  %504 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1419.11), !dbg !314
  %O_reg.sroa.12.22.insert.ext = zext i16 %504 to i64, !dbg !318
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !318
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !318
  %505 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1419.12), !dbg !314
  %O_reg.sroa.17.24.insert.ext = zext i16 %505 to i64, !dbg !318
  %506 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1419.13), !dbg !314
  %O_reg.sroa.17.26.insert.ext = zext i16 %506 to i64, !dbg !318
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !318
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !318
  %507 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1419.14), !dbg !314
  %O_reg.sroa.17.28.insert.ext = zext i16 %507 to i64, !dbg !318
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !318
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !318
  %508 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1419.15), !dbg !314
  %O_reg.sroa.17.30.insert.ext = zext i16 %508 to i64, !dbg !318
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !318
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !318
  %shr1461 = lshr i32 %18, 5
  %and1464 = and i32 %18, 7
  %mul1470 = and i32 %22, 4
  %xor = xor i32 %shr1461, %and1464, !dbg !319
  %mul1465 = shl nuw nsw i32 %xor, 3, !dbg !320
  %add1466 = add nuw nsw i32 %mul1465, %mul25, !dbg !321
  %add1471 = or disjoint i32 %add1466, %mul1470, !dbg !322
  %add.ptr1473 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1471, !dbg !323
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr1473, align 8, !dbg !324
  %add1462.1 = add nuw nsw i32 %shr1461, 2, !dbg !325
  %xor.1 = xor i32 %add1462.1, %and1464, !dbg !319
  %mul1465.1 = shl nuw nsw i32 %xor.1, 3, !dbg !320
  %add1466.1 = add nuw nsw i32 %mul1465.1, %mul25, !dbg !321
  %add1471.1 = or disjoint i32 %add1466.1, %mul1470, !dbg !322
  %add.ptr1473.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1471.1, !dbg !323
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr1473.1, align 8, !dbg !324
  %add1462.2 = add nuw nsw i32 %shr1461, 4, !dbg !325
  %xor.2 = xor i32 %add1462.2, %and1464, !dbg !319
  %mul1465.2 = shl nuw nsw i32 %xor.2, 3, !dbg !320
  %add1466.2 = add nuw nsw i32 %mul1465.2, %mul25, !dbg !321
  %add1471.2 = or disjoint i32 %add1466.2, %mul1470, !dbg !322
  %add.ptr1473.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1471.2, !dbg !323
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr1473.2, align 8, !dbg !324
  %add1462.3 = add nuw nsw i32 %shr1461, 6, !dbg !325
  %xor.3 = xor i32 %add1462.3, %and1464, !dbg !319
  %mul1465.3 = shl nuw nsw i32 %xor.3, 3, !dbg !320
  %add1466.3 = add nuw nsw i32 %mul1465.3, %mul25, !dbg !321
  %add1471.3 = or disjoint i32 %add1466.3, %mul1470, !dbg !322
  %add.ptr1473.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1471.3, !dbg !323
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr1473.3, align 8, !dbg !324
  fence syncscope("warp") release, !dbg !326
  tail call void @llvm.mxc.barrier.warp(), !dbg !331
  fence syncscope("warp") acquire, !dbg !332
  %mul1484 = and i32 %mul132, 8128
  %xor14901884 = and i32 %mul132, 56
  %call1488.masked = and i32 %18, 1016
  %mul1491 = xor i32 %xor14901884, %call1488.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul1484, !dbg !333
  %invariant.gep2027 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul1491, !dbg !333
  %add1501 = add nuw nsw i32 %add23, %mul132
  %509 = zext nneg i32 %add1501 to i64, !dbg !334
  %add.ptr1506 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %509, !dbg !335
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1506, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep2027, i64 16, i1 false), !dbg !336, !tbaa.struct !337, !call_argsrelate !338
  %gep2028.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep2027, i32 1024, !dbg !339
  %510 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %509, !dbg !335
  %add.ptr1506.1 = getelementptr inbounds i8, ptr addrspace(1) %510, i64 1024, !dbg !335
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1506.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep2028.1, i64 16, i1 false), !dbg !336, !tbaa.struct !337, !call_argsrelate !338
  ret void, !dbg !340
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
!1 = !DIFile(filename: "/tmp/tmpkje91kx0/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpkje91kx0/tvm_kernels.maca", directory: "")
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
!58 = !DILocation(line: 49, column: 3, scope: !40)
!59 = !DILocation(line: 54, column: 31, scope: !40)
!60 = !DILocation(line: 56, column: 7, scope: !40)
!61 = !DILocation(line: 57, column: 52, scope: !40)
!62 = !DILocation(line: 57, column: 38, scope: !40)
!63 = !DILocation(line: 57, column: 124, scope: !40)
!64 = !DILocation(line: 60, column: 7, scope: !40)
!65 = !DILocation(line: 61, column: 53, scope: !40)
!66 = !DILocation(line: 61, column: 39, scope: !40)
!67 = !DILocation(line: 61, column: 125, scope: !40)
!68 = !DILocation(line: 64, column: 7, scope: !40)
!69 = !DILocation(line: 65, column: 53, scope: !40)
!70 = !DILocation(line: 65, column: 39, scope: !40)
!71 = !DILocation(line: 65, column: 125, scope: !40)
!72 = !DILocation(line: 68, column: 7, scope: !40)
!73 = !DILocation(line: 69, column: 53, scope: !40)
!74 = !DILocation(line: 69, column: 39, scope: !40)
!75 = !DILocation(line: 69, column: 125, scope: !40)
!76 = !DILocation(line: 73, column: 52, scope: !40)
!77 = !DILocation(line: 73, column: 38, scope: !40)
!78 = !DILocation(line: 80, column: 36, scope: !40)
!79 = !{i32 1, i32 3, i32 -1}
!80 = !DILocation(line: 88, column: 32, scope: !40)
!81 = !DILocation(line: 88, column: 43, scope: !40)
!82 = !DILocation(line: 354, column: 10, scope: !83, inlinedAt: !84)
!83 = distinct !DISubprogram(name: "min", scope: !46, file: !46, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!84 = distinct !DILocation(line: 88, column: 27, scope: !40)
!85 = !DILocation(line: 288, column: 10, scope: !86, inlinedAt: !87)
!86 = distinct !DISubprogram(name: "expf", scope: !46, file: !46, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!87 = distinct !DILocation(line: 88, column: 22, scope: !40)
!88 = !DILocation(line: 75, column: 10, scope: !89, inlinedAt: !91)
!89 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !90, file: !90, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!90 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!91 = distinct !DILocation(line: 984, column: 9, scope: !92, inlinedAt: !94)
!92 = distinct !DISubprogram(name: "__float2half", scope: !93, file: !93, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!93 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!94 = distinct !DILocation(line: 133, column: 53, scope: !95, inlinedAt: !96)
!95 = distinct !DISubprogram(name: "__half", scope: !93, file: !93, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!96 = distinct !DILocation(line: 96, column: 34, scope: !40)
!97 = !DILocation(line: 96, column: 31, scope: !40)
!98 = !DILocation(line: 100, column: 36, scope: !40)
!99 = !{i32 4, i32 -1, i32 -1}
!100 = !DILocation(line: 107, column: 53, scope: !40)
!101 = !DILocation(line: 107, column: 39, scope: !40)
!102 = !DILocation(line: 114, column: 36, scope: !40)
!103 = !DILocation(line: 122, column: 33, scope: !40)
!104 = !DILocation(line: 122, column: 45, scope: !40)
!105 = !DILocation(line: 354, column: 10, scope: !83, inlinedAt: !106)
!106 = distinct !DILocation(line: 122, column: 28, scope: !40)
!107 = !DILocation(line: 288, column: 10, scope: !86, inlinedAt: !108)
!108 = distinct !DILocation(line: 122, column: 23, scope: !40)
!109 = !DILocation(line: 126, column: 40, scope: !40)
!110 = !DILocation(line: 75, column: 10, scope: !89, inlinedAt: !111)
!111 = distinct !DILocation(line: 984, column: 9, scope: !92, inlinedAt: !112)
!112 = distinct !DILocation(line: 133, column: 53, scope: !95, inlinedAt: !113)
!113 = distinct !DILocation(line: 130, column: 36, scope: !40)
!114 = !DILocation(line: 130, column: 33, scope: !40)
!115 = !DILocation(line: 134, column: 42, scope: !40)
!116 = !DILocation(line: 141, column: 53, scope: !40)
!117 = !DILocation(line: 141, column: 39, scope: !40)
!118 = !DILocation(line: 148, column: 36, scope: !40)
!119 = !DILocation(line: 156, column: 33, scope: !40)
!120 = !DILocation(line: 156, column: 45, scope: !40)
!121 = !DILocation(line: 354, column: 10, scope: !83, inlinedAt: !122)
!122 = distinct !DILocation(line: 156, column: 28, scope: !40)
!123 = !DILocation(line: 288, column: 10, scope: !86, inlinedAt: !124)
!124 = distinct !DILocation(line: 156, column: 23, scope: !40)
!125 = !DILocation(line: 160, column: 40, scope: !40)
!126 = !DILocation(line: 75, column: 10, scope: !89, inlinedAt: !127)
!127 = distinct !DILocation(line: 984, column: 9, scope: !92, inlinedAt: !128)
!128 = distinct !DILocation(line: 133, column: 53, scope: !95, inlinedAt: !129)
!129 = distinct !DILocation(line: 164, column: 36, scope: !40)
!130 = !DILocation(line: 164, column: 33, scope: !40)
!131 = !DILocation(line: 168, column: 38, scope: !40)
!132 = !DILocation(line: 175, column: 53, scope: !40)
!133 = !DILocation(line: 175, column: 39, scope: !40)
!134 = !DILocation(line: 182, column: 36, scope: !40)
!135 = !DILocation(line: 190, column: 33, scope: !40)
!136 = !DILocation(line: 190, column: 45, scope: !40)
!137 = !DILocation(line: 354, column: 10, scope: !83, inlinedAt: !138)
!138 = distinct !DILocation(line: 190, column: 28, scope: !40)
!139 = !DILocation(line: 288, column: 10, scope: !86, inlinedAt: !140)
!140 = distinct !DILocation(line: 190, column: 23, scope: !40)
!141 = !DILocation(line: 194, column: 40, scope: !40)
!142 = !DILocation(line: 75, column: 10, scope: !89, inlinedAt: !143)
!143 = distinct !DILocation(line: 984, column: 9, scope: !92, inlinedAt: !144)
!144 = distinct !DILocation(line: 133, column: 53, scope: !95, inlinedAt: !145)
!145 = distinct !DILocation(line: 198, column: 36, scope: !40)
!146 = !DILocation(line: 198, column: 33, scope: !40)
!147 = !DILocation(line: 202, column: 42, scope: !40)
!148 = !DILocation(line: 49, column: 34, scope: !40)
!149 = !DILocation(line: 208, column: 24, scope: !40)
!150 = !DILocation(line: 210, column: 9, scope: !40)
!151 = !DILocation(line: 211, column: 55, scope: !40)
!152 = !DILocation(line: 211, column: 41, scope: !40)
!153 = !DILocation(line: 214, column: 24, scope: !40)
!154 = !DILocation(line: 216, column: 9, scope: !40)
!155 = !DILocation(line: 217, column: 56, scope: !40)
!156 = !DILocation(line: 217, column: 42, scope: !40)
!157 = !DILocation(line: 220, column: 24, scope: !40)
!158 = !DILocation(line: 222, column: 9, scope: !40)
!159 = !DILocation(line: 223, column: 56, scope: !40)
!160 = !DILocation(line: 223, column: 42, scope: !40)
!161 = !DILocation(line: 226, column: 24, scope: !40)
!162 = !DILocation(line: 228, column: 9, scope: !40)
!163 = !DILocation(line: 229, column: 56, scope: !40)
!164 = !DILocation(line: 229, column: 42, scope: !40)
!165 = !DILocation(line: 232, column: 24, scope: !40)
!166 = !DILocation(line: 234, column: 9, scope: !40)
!167 = !DILocation(line: 235, column: 55, scope: !40)
!168 = !DILocation(line: 235, column: 41, scope: !40)
!169 = !DILocation(line: 237, column: 13, scope: !40)
!170 = !DILocation(line: 241, column: 68, scope: !40)
!171 = !DILocation(line: 246, column: 25, scope: !40)
!172 = !DILocation(line: 241, column: 60, scope: !40)
!173 = !DILocation(line: 0, scope: !40)
!174 = !DILocation(line: 255, column: 36, scope: !40)
!175 = !{i32 -1, i32 3, i32 -1}
!176 = !DILocation(line: 263, column: 35, scope: !40)
!177 = !DILocation(line: 263, column: 47, scope: !40)
!178 = !DILocation(line: 354, column: 10, scope: !83, inlinedAt: !179)
!179 = distinct !DILocation(line: 263, column: 30, scope: !40)
!180 = !DILocation(line: 288, column: 10, scope: !86, inlinedAt: !181)
!181 = distinct !DILocation(line: 263, column: 25, scope: !40)
!182 = !DILocation(line: 75, column: 10, scope: !89, inlinedAt: !183)
!183 = distinct !DILocation(line: 984, column: 9, scope: !92, inlinedAt: !184)
!184 = distinct !DILocation(line: 133, column: 53, scope: !95, inlinedAt: !185)
!185 = distinct !DILocation(line: 271, column: 38, scope: !40)
!186 = !DILocation(line: 271, column: 35, scope: !40)
!187 = !DILocation(line: 275, column: 38, scope: !40)
!188 = !DILocation(line: 281, column: 24, scope: !40)
!189 = !DILocation(line: 283, column: 9, scope: !40)
!190 = !DILocation(line: 284, column: 55, scope: !40)
!191 = !DILocation(line: 284, column: 41, scope: !40)
!192 = !DILocation(line: 286, column: 31, scope: !40)
!193 = !DILocation(line: 286, column: 13, scope: !40)
!194 = !DILocation(line: 290, column: 68, scope: !40)
!195 = !DILocation(line: 295, column: 25, scope: !40)
!196 = !DILocation(line: 290, column: 60, scope: !40)
!197 = !DILocation(line: 304, column: 36, scope: !40)
!198 = !DILocation(line: 312, column: 35, scope: !40)
!199 = !DILocation(line: 312, column: 47, scope: !40)
!200 = !DILocation(line: 354, column: 10, scope: !83, inlinedAt: !201)
!201 = distinct !DILocation(line: 312, column: 30, scope: !40)
!202 = !DILocation(line: 288, column: 10, scope: !86, inlinedAt: !203)
!203 = distinct !DILocation(line: 312, column: 25, scope: !40)
!204 = !DILocation(line: 316, column: 42, scope: !40)
!205 = !DILocation(line: 75, column: 10, scope: !89, inlinedAt: !206)
!206 = distinct !DILocation(line: 984, column: 9, scope: !92, inlinedAt: !207)
!207 = distinct !DILocation(line: 133, column: 53, scope: !95, inlinedAt: !208)
!208 = distinct !DILocation(line: 320, column: 38, scope: !40)
!209 = !DILocation(line: 320, column: 35, scope: !40)
!210 = !DILocation(line: 324, column: 42, scope: !40)
!211 = !DILocation(line: 330, column: 24, scope: !40)
!212 = !DILocation(line: 332, column: 9, scope: !40)
!213 = !DILocation(line: 333, column: 55, scope: !40)
!214 = !DILocation(line: 333, column: 41, scope: !40)
!215 = !DILocation(line: 335, column: 31, scope: !40)
!216 = !DILocation(line: 335, column: 13, scope: !40)
!217 = !DILocation(line: 339, column: 68, scope: !40)
!218 = !DILocation(line: 344, column: 25, scope: !40)
!219 = !DILocation(line: 339, column: 60, scope: !40)
!220 = !DILocation(line: 353, column: 36, scope: !40)
!221 = !DILocation(line: 361, column: 35, scope: !40)
!222 = !DILocation(line: 361, column: 47, scope: !40)
!223 = !DILocation(line: 354, column: 10, scope: !83, inlinedAt: !224)
!224 = distinct !DILocation(line: 361, column: 30, scope: !40)
!225 = !DILocation(line: 288, column: 10, scope: !86, inlinedAt: !226)
!226 = distinct !DILocation(line: 361, column: 25, scope: !40)
!227 = !DILocation(line: 365, column: 42, scope: !40)
!228 = !DILocation(line: 75, column: 10, scope: !89, inlinedAt: !229)
!229 = distinct !DILocation(line: 984, column: 9, scope: !92, inlinedAt: !230)
!230 = distinct !DILocation(line: 133, column: 53, scope: !95, inlinedAt: !231)
!231 = distinct !DILocation(line: 369, column: 38, scope: !40)
!232 = !DILocation(line: 369, column: 35, scope: !40)
!233 = !DILocation(line: 373, column: 38, scope: !40)
!234 = !DILocation(line: 379, column: 24, scope: !40)
!235 = !DILocation(line: 381, column: 9, scope: !40)
!236 = !DILocation(line: 382, column: 55, scope: !40)
!237 = !DILocation(line: 382, column: 41, scope: !40)
!238 = !DILocation(line: 384, column: 31, scope: !40)
!239 = !DILocation(line: 384, column: 13, scope: !40)
!240 = !DILocation(line: 388, column: 68, scope: !40)
!241 = !DILocation(line: 393, column: 25, scope: !40)
!242 = !DILocation(line: 388, column: 60, scope: !40)
!243 = !DILocation(line: 402, column: 36, scope: !40)
!244 = !DILocation(line: 410, column: 35, scope: !40)
!245 = !DILocation(line: 410, column: 47, scope: !40)
!246 = !DILocation(line: 354, column: 10, scope: !83, inlinedAt: !247)
!247 = distinct !DILocation(line: 410, column: 30, scope: !40)
!248 = !DILocation(line: 288, column: 10, scope: !86, inlinedAt: !249)
!249 = distinct !DILocation(line: 410, column: 25, scope: !40)
!250 = !DILocation(line: 414, column: 42, scope: !40)
!251 = !DILocation(line: 75, column: 10, scope: !89, inlinedAt: !252)
!252 = distinct !DILocation(line: 984, column: 9, scope: !92, inlinedAt: !253)
!253 = distinct !DILocation(line: 133, column: 53, scope: !95, inlinedAt: !254)
!254 = distinct !DILocation(line: 418, column: 38, scope: !40)
!255 = !DILocation(line: 418, column: 35, scope: !40)
!256 = !DILocation(line: 422, column: 42, scope: !40)
!257 = !DILocation(line: 92, column: 38, scope: !40)
!258 = !DILocation(line: 267, column: 42, scope: !40)
!259 = !DILocation(line: 432, column: 20, scope: !40)
!260 = !DILocation(line: 432, column: 34, scope: !40)
!261 = !DILocation(line: 432, column: 32, scope: !40)
!262 = !DILocation(line: 437, column: 36, scope: !40)
!263 = !DILocation(line: 1018, column: 9, scope: !264, inlinedAt: !266)
!264 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !265, file: !265, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!265 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!266 = distinct !DILocation(line: 396, column: 10, scope: !267, inlinedAt: !269)
!267 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !268, file: !268, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!268 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!269 = distinct !DILocation(line: 129, column: 24, scope: !270, inlinedAt: !272)
!270 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !271, file: !271, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!271 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!272 = distinct !DILocation(line: 101, column: 14, scope: !273, inlinedAt: !274)
!273 = distinct !DISubprogram(name: "run<float>", scope: !271, file: !271, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!274 = distinct !DILocation(line: 439, column: 19, scope: !40)
!275 = !DILocation(line: 171, column: 37, scope: !276, inlinedAt: !277)
!276 = distinct !DISubprogram(name: "__lane_id", scope: !265, file: !265, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!277 = distinct !DILocation(line: 990, column: 14, scope: !278, inlinedAt: !279)
!278 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !265, file: !265, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!279 = distinct !DILocation(line: 1019, column: 11, scope: !264, inlinedAt: !266)
!280 = !DILocation(line: 171, column: 10, scope: !276, inlinedAt: !277)
!281 = !DILocation(line: 991, column: 20, scope: !278, inlinedAt: !279)
!282 = !DILocation(line: 992, column: 36, scope: !278, inlinedAt: !279)
!283 = !DILocation(line: 992, column: 17, scope: !278, inlinedAt: !279)
!284 = !DILocation(line: 992, column: 11, scope: !278, inlinedAt: !279)
!285 = !DILocation(line: 993, column: 43, scope: !278, inlinedAt: !279)
!286 = !DILocation(line: 993, column: 10, scope: !278, inlinedAt: !279)
!287 = !DILocation(line: 1020, column: 14, scope: !264, inlinedAt: !266)
!288 = !DILocation(line: 25, column: 14, scope: !289, inlinedAt: !290)
!289 = distinct !DISubprogram(name: "operator()<float>", scope: !271, file: !271, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!290 = distinct !DILocation(line: 129, column: 11, scope: !270, inlinedAt: !272)
!291 = !DILocation(line: 1018, column: 9, scope: !264, inlinedAt: !292)
!292 = distinct !DILocation(line: 396, column: 10, scope: !267, inlinedAt: !293)
!293 = distinct !DILocation(line: 129, column: 24, scope: !294, inlinedAt: !295)
!294 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !271, file: !271, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!295 = distinct !DILocation(line: 101, column: 14, scope: !296, inlinedAt: !297)
!296 = distinct !DISubprogram(name: "run<float>", scope: !271, file: !271, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!297 = distinct !DILocation(line: 134, column: 14, scope: !270, inlinedAt: !272)
!298 = !DILocation(line: 171, column: 37, scope: !276, inlinedAt: !299)
!299 = distinct !DILocation(line: 990, column: 14, scope: !278, inlinedAt: !300)
!300 = distinct !DILocation(line: 1019, column: 11, scope: !264, inlinedAt: !292)
!301 = !DILocation(line: 171, column: 10, scope: !276, inlinedAt: !299)
!302 = !DILocation(line: 991, column: 20, scope: !278, inlinedAt: !300)
!303 = !DILocation(line: 992, column: 36, scope: !278, inlinedAt: !300)
!304 = !DILocation(line: 992, column: 17, scope: !278, inlinedAt: !300)
!305 = !DILocation(line: 992, column: 11, scope: !278, inlinedAt: !300)
!306 = !DILocation(line: 993, column: 43, scope: !278, inlinedAt: !300)
!307 = !DILocation(line: 993, column: 10, scope: !278, inlinedAt: !300)
!308 = !DILocation(line: 1020, column: 14, scope: !264, inlinedAt: !292)
!309 = !DILocation(line: 25, column: 14, scope: !289, inlinedAt: !310)
!310 = distinct !DILocation(line: 129, column: 11, scope: !294, inlinedAt: !295)
!311 = !DILocation(line: 441, column: 32, scope: !40)
!312 = !DILocation(line: 441, column: 7, scope: !40)
!313 = !DILocation(line: 449, column: 32, scope: !40)
!314 = !DILocation(line: 75, column: 10, scope: !89, inlinedAt: !315)
!315 = distinct !DILocation(line: 984, column: 9, scope: !92, inlinedAt: !316)
!316 = distinct !DILocation(line: 133, column: 53, scope: !95, inlinedAt: !317)
!317 = distinct !DILocation(line: 455, column: 50, scope: !40)
!318 = !DILocation(line: 455, column: 47, scope: !40)
!319 = !DILocation(line: 460, column: 122, scope: !40)
!320 = !DILocation(line: 460, column: 150, scope: !40)
!321 = !DILocation(line: 460, column: 77, scope: !40)
!322 = !DILocation(line: 460, column: 156, scope: !40)
!323 = !DILocation(line: 460, column: 40, scope: !40)
!324 = !DILocation(line: 460, column: 199, scope: !40)
!325 = !DILocation(line: 460, column: 93, scope: !40)
!326 = !DILocation(line: 68, column: 3, scope: !327, inlinedAt: !328)
!327 = distinct !DISubprogram(name: "__barrier_warp", scope: !265, file: !265, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!328 = distinct !DILocation(line: 192, column: 3, scope: !329, inlinedAt: !330)
!329 = distinct !DISubprogram(name: "__syncwarp", scope: !265, file: !265, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!330 = distinct !DILocation(line: 462, column: 3, scope: !40)
!331 = !DILocation(line: 69, column: 3, scope: !327, inlinedAt: !328)
!332 = !DILocation(line: 70, column: 3, scope: !327, inlinedAt: !328)
!333 = !DILocation(line: 464, column: 8, scope: !40)
!334 = !DILocation(line: 464, column: 3, scope: !40)
!335 = !DILocation(line: 465, column: 22, scope: !40)
!336 = !DILocation(line: 465, column: 132, scope: !40)
!337 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!338 = !{i32 2, i32 -1, i32 -1, i32 -1}
!339 = !DILocation(line: 465, column: 169, scope: !40)
!340 = !DILocation(line: 467, column: 1, scope: !40)
