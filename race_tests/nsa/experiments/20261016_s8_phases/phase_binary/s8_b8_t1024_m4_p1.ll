; ModuleID = 'experiments/20261016_s8_phases/phase_binary/s8_b8_t1024_m4_p1.bc'
source_filename = "/tmp/tmpssciq6h3/tvm_kernels.maca"
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
  %3 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !43, !tbaa !30
  %cond.i.i = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %3, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2378 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64), !dbg !49
  %mul11 = shl nsw i32 %cond.i.i2378, 4, !dbg !52
  %4 = or disjoint i64 %2, 1, !dbg !53
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4, !dbg !43
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !dbg !43, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2378.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64), !dbg !49
  %mul11.1 = shl nsw i32 %cond.i.i2378.1, 4, !dbg !52
  %6 = or disjoint i64 %2, 2, !dbg !53
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6, !dbg !43
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !dbg !43, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2378.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64), !dbg !49
  %mul11.2 = shl nsw i32 %cond.i.i2378.2, 4, !dbg !52
  %8 = or disjoint i64 %2, 3, !dbg !53
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8, !dbg !43
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !dbg !43, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2378.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64), !dbg !49
  %mul11.3 = shl nsw i32 %cond.i.i2378.3, 4, !dbg !52
  %10 = or disjoint i64 %2, 4, !dbg !53
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10, !dbg !43
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !dbg !43, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2378.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64), !dbg !49
  %mul11.4 = shl nsw i32 %cond.i.i2378.4, 4, !dbg !52
  %12 = or disjoint i64 %2, 5, !dbg !53
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12, !dbg !43
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !dbg !43, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2378.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64), !dbg !49
  %mul11.5 = shl nsw i32 %cond.i.i2378.5, 4, !dbg !52
  %14 = or disjoint i64 %2, 6, !dbg !53
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14, !dbg !43
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !dbg !43, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2378.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64), !dbg !49
  %mul11.6 = shl nsw i32 %cond.i.i2378.6, 4, !dbg !52
  %16 = or disjoint i64 %2, 7, !dbg !53
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16, !dbg !43
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !dbg !43, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2378.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64), !dbg !49
  %mul11.7 = shl nsw i32 %cond.i.i2378.7, 4, !dbg !52
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
  %Q_reg.sroa.11.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !57
  %Q_reg.sroa.11.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.11.0.add.ptr.sroa_idx, align 8, !dbg !57
  %21 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %20, !dbg !56
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %21, i64 64, !dbg !56
  %Q_reg.sroa.19.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16, !dbg !57
  %Q_reg.sroa.28.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %21, i64 72, !dbg !57
  %Q_reg.sroa.28.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.28.16.add.ptr.1.sroa_idx, align 8, !dbg !57
  %or.cond = icmp ugt i32 %mul11, 1023, !dbg !58
  %cmp47.not = icmp sgt i32 %mul11, %1
  %or.cond2526 = or i1 %or.cond, %cmp47.not, !dbg !58
  br i1 %or.cond2526, label %if.end, label %for.cond48.preheader, !dbg !58

for.cond48.preheader:                             ; preds = %entry
  %mul54 = shl nsw i32 %0, 16
  %22 = shl nsw i32 %cond.i.i2378, 10
  %mul56 = and i32 %22, 64512
  %mul61 = shl nuw nsw i32 %18, 3
  %add57 = or disjoint i32 %mul61, %mul54
  %add59 = add nuw nsw i32 %add57, %mul56
  %23 = zext nneg i32 %add59 to i64, !dbg !59
  %add.ptr64 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %23, !dbg !60
  %K_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr64, align 16, !dbg !61
  %K_reg.sroa.6.0.add.ptr64.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr64, i64 8, !dbg !61
  %K_reg.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg.sroa.6.0.add.ptr64.sroa_idx, align 8, !dbg !61
  %24 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %23, !dbg !60
  %add.ptr64.1 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 1024, !dbg !60
  %K_reg.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr64.1, align 16, !dbg !61
  %K_reg.sroa.12.16.add.ptr64.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %24, i64 1032, !dbg !61
  %K_reg.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg.sroa.12.16.add.ptr64.1.sroa_idx, align 8, !dbg !61
  br label %if.end, !dbg !62

if.end:                                           ; preds = %for.cond48.preheader, %entry
  %K_reg.sroa.12.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.12.16.copyload, %for.cond48.preheader ]
  %K_reg.sroa.8.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.8.16.copyload, %for.cond48.preheader ]
  %K_reg.sroa.6.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.6.0.copyload, %for.cond48.preheader ]
  %K_reg.sroa.0.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.0.0.copyload, %for.cond48.preheader ]
  %or.cond2527 = icmp ugt i32 %mul11.1, 1023, !dbg !63
  %cmp78.not = icmp sgt i32 %mul11.1, %1
  %or.cond2528 = or i1 %or.cond2527, %cmp78.not, !dbg !63
  br i1 %or.cond2528, label %if.end104, label %for.cond80.preheader, !dbg !63

for.cond80.preheader:                             ; preds = %if.end
  %mul86 = shl nsw i32 %0, 16
  %25 = shl nsw i32 %cond.i.i2378.1, 10
  %mul88 = and i32 %25, 64512
  %mul93 = shl nuw nsw i32 %18, 3
  %add89 = or disjoint i32 %mul93, %mul86
  %add91 = add nuw nsw i32 %add89, %mul88
  %26 = zext nneg i32 %add91 to i64, !dbg !64
  %add.ptr96 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %26, !dbg !65
  %K_reg1.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr96, align 16, !dbg !66
  %K_reg1.sroa.6.0.add.ptr96.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr96, i64 8, !dbg !66
  %K_reg1.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.6.0.add.ptr96.sroa_idx, align 8, !dbg !66
  %27 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %26, !dbg !65
  %add.ptr96.1 = getelementptr inbounds i8, ptr addrspace(4) %27, i64 1024, !dbg !65
  %K_reg1.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr96.1, align 16, !dbg !66
  %K_reg1.sroa.12.16.add.ptr96.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %27, i64 1032, !dbg !66
  %K_reg1.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.12.16.add.ptr96.1.sroa_idx, align 8, !dbg !66
  br label %if.end104, !dbg !67

if.end104:                                        ; preds = %for.cond80.preheader, %if.end
  %K_reg1.sroa.12.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.12.16.copyload, %for.cond80.preheader ]
  %K_reg1.sroa.8.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.8.16.copyload, %for.cond80.preheader ]
  %K_reg1.sroa.6.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.6.0.copyload, %for.cond80.preheader ]
  %K_reg1.sroa.0.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.0.0.copyload, %for.cond80.preheader ]
  %or.cond2529 = icmp ugt i32 %mul11.2, 1023, !dbg !68
  %cmp111.not = icmp sgt i32 %mul11.2, %1
  %or.cond2530 = or i1 %or.cond2529, %cmp111.not, !dbg !68
  br i1 %or.cond2530, label %if.end137, label %for.cond113.preheader, !dbg !68

for.cond113.preheader:                            ; preds = %if.end104
  %mul119 = shl nsw i32 %0, 16
  %28 = shl nsw i32 %cond.i.i2378.2, 10
  %mul121 = and i32 %28, 64512
  %mul126 = shl nuw nsw i32 %18, 3
  %add122 = or disjoint i32 %mul126, %mul119
  %add124 = add nuw nsw i32 %add122, %mul121
  %29 = zext nneg i32 %add124 to i64, !dbg !69
  %add.ptr129 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %29, !dbg !70
  %K_reg2.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr129, align 16, !dbg !71
  %K_reg2.sroa.6.0.add.ptr129.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr129, i64 8, !dbg !71
  %K_reg2.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.6.0.add.ptr129.sroa_idx, align 8, !dbg !71
  %30 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %29, !dbg !70
  %add.ptr129.1 = getelementptr inbounds i8, ptr addrspace(4) %30, i64 1024, !dbg !70
  %K_reg2.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr129.1, align 16, !dbg !71
  %K_reg2.sroa.12.16.add.ptr129.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %30, i64 1032, !dbg !71
  %K_reg2.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.12.16.add.ptr129.1.sroa_idx, align 8, !dbg !71
  br label %if.end137, !dbg !72

if.end137:                                        ; preds = %for.cond113.preheader, %if.end104
  %K_reg2.sroa.12.0 = phi <4 x half> [ undef, %if.end104 ], [ %K_reg2.sroa.12.16.copyload, %for.cond113.preheader ]
  %K_reg2.sroa.8.0 = phi <4 x half> [ undef, %if.end104 ], [ %K_reg2.sroa.8.16.copyload, %for.cond113.preheader ]
  %K_reg2.sroa.6.0 = phi <4 x half> [ undef, %if.end104 ], [ %K_reg2.sroa.6.0.copyload, %for.cond113.preheader ]
  %K_reg2.sroa.0.0 = phi <4 x half> [ undef, %if.end104 ], [ %K_reg2.sroa.0.0.copyload, %for.cond113.preheader ]
  %or.cond2531 = icmp ugt i32 %mul11.3, 1023, !dbg !73
  %cmp144.not = icmp sgt i32 %mul11.3, %1
  %or.cond2532 = or i1 %or.cond2531, %cmp144.not, !dbg !73
  br i1 %or.cond2532, label %if.end170, label %for.cond146.preheader, !dbg !73

for.cond146.preheader:                            ; preds = %if.end137
  %mul152 = shl nsw i32 %0, 16
  %31 = shl nsw i32 %cond.i.i2378.3, 10
  %mul154 = and i32 %31, 64512
  %mul159 = shl nuw nsw i32 %18, 3
  %add155 = or disjoint i32 %mul159, %mul152
  %add157 = add nuw nsw i32 %add155, %mul154
  %32 = zext nneg i32 %add157 to i64, !dbg !74
  %add.ptr162 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %32, !dbg !75
  %K_reg3.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr162, align 16, !dbg !76
  %K_reg3.sroa.6.0.add.ptr162.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr162, i64 8, !dbg !76
  %K_reg3.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.6.0.add.ptr162.sroa_idx, align 8, !dbg !76
  %33 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %32, !dbg !75
  %add.ptr162.1 = getelementptr inbounds i8, ptr addrspace(4) %33, i64 1024, !dbg !75
  %K_reg3.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr162.1, align 16, !dbg !76
  %K_reg3.sroa.12.16.add.ptr162.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %33, i64 1032, !dbg !76
  %K_reg3.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.12.16.add.ptr162.1.sroa_idx, align 8, !dbg !76
  br label %if.end170, !dbg !77

if.end170:                                        ; preds = %for.cond146.preheader, %if.end137
  %K_reg3.sroa.12.0 = phi <4 x half> [ undef, %if.end137 ], [ %K_reg3.sroa.12.16.copyload, %for.cond146.preheader ]
  %K_reg3.sroa.8.0 = phi <4 x half> [ undef, %if.end137 ], [ %K_reg3.sroa.8.16.copyload, %for.cond146.preheader ]
  %K_reg3.sroa.6.0 = phi <4 x half> [ undef, %if.end137 ], [ %K_reg3.sroa.6.0.copyload, %for.cond146.preheader ]
  %K_reg3.sroa.0.0 = phi <4 x half> [ undef, %if.end137 ], [ %K_reg3.sroa.0.0.copyload, %for.cond146.preheader ]
  %or.cond2533 = icmp ult i32 %mul11, 1024, !dbg !77
  br i1 %or.cond2533, label %land.lhs.true174, label %if.end279, !dbg !77

land.lhs.true174:                                 ; preds = %if.end170
  br i1 %cmp47.not, label %if.end279, label %if.then177, !dbg !78

if.then177:                                       ; preds = %land.lhs.true174
  %add179 = or disjoint i32 %mul11, 15, !dbg !79
  %cmp180 = icmp ult i32 %1, %add179, !dbg !80
  br i1 %cmp180, label %for.cond182.preheader, label %if.end206, !dbg !81

for.cond182.preheader:                            ; preds = %if.then177
  %34 = lshr i32 %18, 2
  %mul189 = and i32 %34, 252
  %add190 = add nuw nsw i32 %mul11, %mul189
  %cmp193.not = icmp sgt i32 %add190, %1, !dbg !82
  %fneg. = select i1 %cmp193.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3098 = insertelement <4 x float> poison, float %fneg., i64 0, !dbg !83
  %cmp193.not.1.not = icmp slt i32 %add190, %1, !dbg !82
  %fneg..1 = select i1 %cmp193.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3191 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3098, float %fneg..1, i64 1, !dbg !83
  %add191.2 = or disjoint i32 %add190, 2, !dbg !84
  %cmp193.not.2 = icmp sgt i32 %add191.2, %1, !dbg !82
  %fneg..2 = select i1 %cmp193.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3284 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3191, float %fneg..2, i64 2, !dbg !83
  %add191.3 = or disjoint i32 %add190, 3, !dbg !84
  %cmp193.not.3 = icmp sgt i32 %add191.3, %1, !dbg !82
  %fneg..3 = select i1 %cmp193.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3377 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3284, float %fneg..3, i64 3, !dbg !83
  br label %if.end206

if.end206:                                        ; preds = %if.then177, %for.cond182.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3377, %for.cond182.preheader ], [ zeroinitializer, %if.then177 ], !dbg !85
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !dbg !86, !call_argsrelate !87
  %36 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %35), !dbg !86, !call_argsrelate !87
  %37 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %36), !dbg !86, !call_argsrelate !87
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %37), !dbg !86, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %38, i64 0, !dbg !88
  %mul242 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !89
  %39 = tail call contract noundef float @llvm.minnum.f32(float %mul242, float 0x4024CB5EC0000000), !dbg !90
  %40 = tail call contract noundef float @llvm.exp.f32(float %39), !dbg !93
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %38, i64 1, !dbg !88
  %mul242.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !89
  %41 = tail call contract noundef float @llvm.minnum.f32(float %mul242.1, float 0x4024CB5EC0000000), !dbg !90
  %42 = tail call contract noundef float @llvm.exp.f32(float %41), !dbg !93
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %38, i64 2, !dbg !88
  %mul242.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !89
  %43 = tail call contract noundef float @llvm.minnum.f32(float %mul242.2, float 0x4024CB5EC0000000), !dbg !90
  %44 = tail call contract noundef float @llvm.exp.f32(float %43), !dbg !93
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %38, i64 3, !dbg !88
  %mul242.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !89
  %45 = tail call contract noundef float @llvm.minnum.f32(float %mul242.3, float 0x4024CB5EC0000000), !dbg !90
  %46 = tail call contract noundef float @llvm.exp.f32(float %45), !dbg !93
  %47 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %40), !dbg !96
  %arrayidx275.idx = shl nuw nsw i32 %18, 3, !dbg !105
  %arrayidx275 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %arrayidx275.idx, !dbg !105
  store i16 %47, ptr addrspace(3) %arrayidx275, align 8, !dbg !106, !tbaa !107
  %48 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %42), !dbg !96
  %arrayidx275.1 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2), i32 %arrayidx275.idx, !dbg !105
  store i16 %48, ptr addrspace(3) %arrayidx275.1, align 2, !dbg !106, !tbaa !107
  %49 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %44), !dbg !96
  %arrayidx275.2 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4), i32 %arrayidx275.idx, !dbg !105
  store i16 %49, ptr addrspace(3) %arrayidx275.2, align 4, !dbg !106, !tbaa !107
  %50 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %46), !dbg !96
  %arrayidx275.3 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 6), i32 %arrayidx275.idx, !dbg !105
  store i16 %50, ptr addrspace(3) %arrayidx275.3, align 2, !dbg !106, !tbaa !107
  br label %if.end279, !dbg !108

if.end279:                                        ; preds = %if.end206, %land.lhs.true174, %if.end170
  %sum_acc.sroa.56.0 = phi float [ 0.000000e+00, %land.lhs.true174 ], [ %46, %if.end206 ], [ 0.000000e+00, %if.end170 ], !dbg !85
  %sum_acc.sroa.38.0 = phi float [ 0.000000e+00, %land.lhs.true174 ], [ %44, %if.end206 ], [ 0.000000e+00, %if.end170 ], !dbg !85
  %sum_acc.sroa.20.0 = phi float [ 0.000000e+00, %land.lhs.true174 ], [ %42, %if.end206 ], [ 0.000000e+00, %if.end170 ], !dbg !85
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %land.lhs.true174 ], [ %40, %if.end206 ], [ 0.000000e+00, %if.end170 ], !dbg !85
  %or.cond2534 = icmp ult i32 %mul11.1, 1024, !dbg !108
  br i1 %or.cond2534, label %land.lhs.true283, label %if.end388, !dbg !108

land.lhs.true283:                                 ; preds = %if.end279
  br i1 %cmp78.not, label %if.end388, label %if.then286, !dbg !109

if.then286:                                       ; preds = %land.lhs.true283
  %add288 = or disjoint i32 %mul11.1, 15, !dbg !110
  %cmp289 = icmp ult i32 %1, %add288, !dbg !111
  br i1 %cmp289, label %for.cond291.preheader, label %if.end315, !dbg !112

for.cond291.preheader:                            ; preds = %if.then286
  %51 = lshr i32 %18, 2
  %mul297 = and i32 %51, 252
  %add298 = add nuw nsw i32 %mul11.1, %mul297
  %cmp301.not = icmp sgt i32 %add298, %1, !dbg !113
  %fneg.2363 = select i1 %cmp301.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3107 = insertelement <4 x float> poison, float %fneg.2363, i64 0, !dbg !114
  %cmp301.not.1.not = icmp slt i32 %add298, %1, !dbg !113
  %fneg.2363.1 = select i1 %cmp301.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3200 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3107, float %fneg.2363.1, i64 1, !dbg !114
  %add299.2 = or disjoint i32 %add298, 2, !dbg !115
  %cmp301.not.2 = icmp sgt i32 %add299.2, %1, !dbg !113
  %fneg.2363.2 = select i1 %cmp301.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3293 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3200, float %fneg.2363.2, i64 2, !dbg !114
  %add299.3 = or disjoint i32 %add298, 3, !dbg !115
  %cmp301.not.3 = icmp sgt i32 %add299.3, %1, !dbg !113
  %fneg.2363.3 = select i1 %cmp301.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3386 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3293, float %fneg.2363.3, i64 3, !dbg !114
  br label %if.end315

if.end315:                                        ; preds = %if.then286, %for.cond291.preheader
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3386, %for.cond291.preheader ], [ zeroinitializer, %if.then286 ], !dbg !85
  %52 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.2), !dbg !116, !call_argsrelate !87
  %53 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %52), !dbg !116, !call_argsrelate !87
  %54 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %53), !dbg !116, !call_argsrelate !87
  %55 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %54), !dbg !116, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract3109 = extractelement <4 x float> %55, i64 0, !dbg !117
  %mul350 = fmul contract float %acc_s.sroa.0.0.vec.extract3109, 0x3FB99999A0000000, !dbg !118
  %56 = tail call contract noundef float @llvm.minnum.f32(float %mul350, float 0x4024CB5EC0000000), !dbg !119
  %57 = tail call contract noundef float @llvm.exp.f32(float %56), !dbg !121
  %acc_s.sroa.0.4.vec.extract3202 = extractelement <4 x float> %55, i64 1, !dbg !117
  %mul350.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3202, 0x3FB99999A0000000, !dbg !118
  %58 = tail call contract noundef float @llvm.minnum.f32(float %mul350.1, float 0x4024CB5EC0000000), !dbg !119
  %59 = tail call contract noundef float @llvm.exp.f32(float %58), !dbg !121
  %acc_s.sroa.0.8.vec.extract3295 = extractelement <4 x float> %55, i64 2, !dbg !117
  %mul350.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3295, 0x3FB99999A0000000, !dbg !118
  %60 = tail call contract noundef float @llvm.minnum.f32(float %mul350.2, float 0x4024CB5EC0000000), !dbg !119
  %61 = tail call contract noundef float @llvm.exp.f32(float %60), !dbg !121
  %acc_s.sroa.0.12.vec.extract3388 = extractelement <4 x float> %55, i64 3, !dbg !117
  %mul350.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3388, 0x3FB99999A0000000, !dbg !118
  %62 = tail call contract noundef float @llvm.minnum.f32(float %mul350.3, float 0x4024CB5EC0000000), !dbg !119
  %63 = tail call contract noundef float @llvm.exp.f32(float %62), !dbg !121
  %add366 = fadd contract float %sum_acc.sroa.0.0, %57, !dbg !123
  %add366.1 = fadd contract float %sum_acc.sroa.20.0, %59, !dbg !123
  %add366.2 = fadd contract float %sum_acc.sroa.38.0, %61, !dbg !123
  %add366.3 = fadd contract float %sum_acc.sroa.56.0, %63, !dbg !123
  %64 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %57), !dbg !124
  %gep.idx = shl nuw nsw i32 %18, 3, !dbg !128
  %gep = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 512), i32 %gep.idx, !dbg !128
  store i16 %64, ptr addrspace(3) %gep, align 8, !dbg !129, !tbaa !107
  %65 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %59), !dbg !124
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 514), i32 %gep.idx, !dbg !128
  store i16 %65, ptr addrspace(3) %gep.1, align 2, !dbg !129, !tbaa !107
  %66 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %61), !dbg !124
  %gep.2 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 516), i32 %gep.idx, !dbg !128
  store i16 %66, ptr addrspace(3) %gep.2, align 4, !dbg !129, !tbaa !107
  %67 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %63), !dbg !124
  %gep.3 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 518), i32 %gep.idx, !dbg !128
  store i16 %67, ptr addrspace(3) %gep.3, align 2, !dbg !129, !tbaa !107
  br label %if.end388, !dbg !130

if.end388:                                        ; preds = %if.end315, %land.lhs.true283, %if.end279
  %sum_acc.sroa.56.1 = phi float [ %sum_acc.sroa.56.0, %land.lhs.true283 ], [ %add366.3, %if.end315 ], [ %sum_acc.sroa.56.0, %if.end279 ], !dbg !85
  %sum_acc.sroa.38.1 = phi float [ %sum_acc.sroa.38.0, %land.lhs.true283 ], [ %add366.2, %if.end315 ], [ %sum_acc.sroa.38.0, %if.end279 ], !dbg !85
  %sum_acc.sroa.20.1 = phi float [ %sum_acc.sroa.20.0, %land.lhs.true283 ], [ %add366.1, %if.end315 ], [ %sum_acc.sroa.20.0, %if.end279 ], !dbg !85
  %sum_acc.sroa.0.1 = phi float [ %sum_acc.sroa.0.0, %land.lhs.true283 ], [ %add366, %if.end315 ], [ %sum_acc.sroa.0.0, %if.end279 ], !dbg !85
  %or.cond2535 = icmp ult i32 %mul11.2, 1024, !dbg !130
  br i1 %or.cond2535, label %land.lhs.true392, label %if.end497, !dbg !130

land.lhs.true392:                                 ; preds = %if.end388
  br i1 %cmp111.not, label %if.end497, label %if.then395, !dbg !131

if.then395:                                       ; preds = %land.lhs.true392
  %add397 = or disjoint i32 %mul11.2, 15, !dbg !132
  %cmp398 = icmp ult i32 %1, %add397, !dbg !133
  br i1 %cmp398, label %for.cond400.preheader, label %if.end424, !dbg !134

for.cond400.preheader:                            ; preds = %if.then395
  %68 = lshr i32 %18, 2
  %mul406 = and i32 %68, 252
  %add407 = add nuw nsw i32 %mul11.2, %mul406
  %cmp410.not = icmp sgt i32 %add407, %1, !dbg !135
  %fneg.2364 = select i1 %cmp410.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3117 = insertelement <4 x float> poison, float %fneg.2364, i64 0, !dbg !136
  %cmp410.not.1.not = icmp slt i32 %add407, %1, !dbg !135
  %fneg.2364.1 = select i1 %cmp410.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3210 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3117, float %fneg.2364.1, i64 1, !dbg !136
  %add408.2 = or disjoint i32 %add407, 2, !dbg !137
  %cmp410.not.2 = icmp sgt i32 %add408.2, %1, !dbg !135
  %fneg.2364.2 = select i1 %cmp410.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3303 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3210, float %fneg.2364.2, i64 2, !dbg !136
  %add408.3 = or disjoint i32 %add407, 3, !dbg !137
  %cmp410.not.3 = icmp sgt i32 %add408.3, %1, !dbg !135
  %fneg.2364.3 = select i1 %cmp410.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3396 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3303, float %fneg.2364.3, i64 3, !dbg !136
  br label %if.end424

if.end424:                                        ; preds = %if.then395, %for.cond400.preheader
  %acc_s.sroa.0.4 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3396, %for.cond400.preheader ], [ zeroinitializer, %if.then395 ], !dbg !85
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.4), !dbg !138, !call_argsrelate !87
  %70 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %69), !dbg !138, !call_argsrelate !87
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %70), !dbg !138, !call_argsrelate !87
  %72 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %71), !dbg !138, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract3119 = extractelement <4 x float> %72, i64 0, !dbg !139
  %mul459 = fmul contract float %acc_s.sroa.0.0.vec.extract3119, 0x3FB99999A0000000, !dbg !140
  %73 = tail call contract noundef float @llvm.minnum.f32(float %mul459, float 0x4024CB5EC0000000), !dbg !141
  %74 = tail call contract noundef float @llvm.exp.f32(float %73), !dbg !143
  %acc_s.sroa.0.4.vec.extract3212 = extractelement <4 x float> %72, i64 1, !dbg !139
  %mul459.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3212, 0x3FB99999A0000000, !dbg !140
  %75 = tail call contract noundef float @llvm.minnum.f32(float %mul459.1, float 0x4024CB5EC0000000), !dbg !141
  %76 = tail call contract noundef float @llvm.exp.f32(float %75), !dbg !143
  %acc_s.sroa.0.8.vec.extract3305 = extractelement <4 x float> %72, i64 2, !dbg !139
  %mul459.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3305, 0x3FB99999A0000000, !dbg !140
  %77 = tail call contract noundef float @llvm.minnum.f32(float %mul459.2, float 0x4024CB5EC0000000), !dbg !141
  %78 = tail call contract noundef float @llvm.exp.f32(float %77), !dbg !143
  %acc_s.sroa.0.12.vec.extract3398 = extractelement <4 x float> %72, i64 3, !dbg !139
  %mul459.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3398, 0x3FB99999A0000000, !dbg !140
  %79 = tail call contract noundef float @llvm.minnum.f32(float %mul459.3, float 0x4024CB5EC0000000), !dbg !141
  %80 = tail call contract noundef float @llvm.exp.f32(float %79), !dbg !143
  %add475 = fadd contract float %sum_acc.sroa.0.1, %74, !dbg !145
  %add475.1 = fadd contract float %sum_acc.sroa.20.1, %76, !dbg !145
  %add475.2 = fadd contract float %sum_acc.sroa.38.1, %78, !dbg !145
  %add475.3 = fadd contract float %sum_acc.sroa.56.1, %80, !dbg !145
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %74), !dbg !146
  %gep2419.idx = shl nuw nsw i32 %18, 3, !dbg !150
  %gep2419 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 1024), i32 %gep2419.idx, !dbg !150
  store i16 %81, ptr addrspace(3) %gep2419, align 8, !dbg !151, !tbaa !107
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %76), !dbg !146
  %gep2419.1 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 1026), i32 %gep2419.idx, !dbg !150
  store i16 %82, ptr addrspace(3) %gep2419.1, align 2, !dbg !151, !tbaa !107
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %78), !dbg !146
  %gep2419.2 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 1028), i32 %gep2419.idx, !dbg !150
  store i16 %83, ptr addrspace(3) %gep2419.2, align 4, !dbg !151, !tbaa !107
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %80), !dbg !146
  %gep2419.3 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 1030), i32 %gep2419.idx, !dbg !150
  store i16 %84, ptr addrspace(3) %gep2419.3, align 2, !dbg !151, !tbaa !107
  br label %if.end497, !dbg !152

if.end497:                                        ; preds = %if.end424, %land.lhs.true392, %if.end388
  %sum_acc.sroa.56.2 = phi float [ %sum_acc.sroa.56.1, %land.lhs.true392 ], [ %add475.3, %if.end424 ], [ %sum_acc.sroa.56.1, %if.end388 ], !dbg !85
  %sum_acc.sroa.38.2 = phi float [ %sum_acc.sroa.38.1, %land.lhs.true392 ], [ %add475.2, %if.end424 ], [ %sum_acc.sroa.38.1, %if.end388 ], !dbg !85
  %sum_acc.sroa.20.2 = phi float [ %sum_acc.sroa.20.1, %land.lhs.true392 ], [ %add475.1, %if.end424 ], [ %sum_acc.sroa.20.1, %if.end388 ], !dbg !85
  %sum_acc.sroa.0.2 = phi float [ %sum_acc.sroa.0.1, %land.lhs.true392 ], [ %add475, %if.end424 ], [ %sum_acc.sroa.0.1, %if.end388 ], !dbg !85
  %or.cond2536 = icmp ult i32 %mul11.3, 1024, !dbg !152
  br i1 %or.cond2536, label %land.lhs.true501, label %if.end606, !dbg !152

land.lhs.true501:                                 ; preds = %if.end497
  br i1 %cmp144.not, label %if.end606, label %if.then504, !dbg !153

if.then504:                                       ; preds = %land.lhs.true501
  %add506 = or disjoint i32 %mul11.3, 15, !dbg !154
  %cmp507 = icmp ult i32 %1, %add506, !dbg !155
  br i1 %cmp507, label %for.cond509.preheader, label %if.end533, !dbg !156

for.cond509.preheader:                            ; preds = %if.then504
  %85 = lshr i32 %18, 2
  %mul515 = and i32 %85, 252
  %add516 = add nuw nsw i32 %mul11.3, %mul515
  %cmp519.not = icmp sgt i32 %add516, %1, !dbg !157
  %fneg.2365 = select i1 %cmp519.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3127 = insertelement <4 x float> poison, float %fneg.2365, i64 0, !dbg !158
  %cmp519.not.1.not = icmp slt i32 %add516, %1, !dbg !157
  %fneg.2365.1 = select i1 %cmp519.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3220 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3127, float %fneg.2365.1, i64 1, !dbg !158
  %add517.2 = or disjoint i32 %add516, 2, !dbg !159
  %cmp519.not.2 = icmp sgt i32 %add517.2, %1, !dbg !157
  %fneg.2365.2 = select i1 %cmp519.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3313 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3220, float %fneg.2365.2, i64 2, !dbg !158
  %add517.3 = or disjoint i32 %add516, 3, !dbg !159
  %cmp519.not.3 = icmp sgt i32 %add517.3, %1, !dbg !157
  %fneg.2365.3 = select i1 %cmp519.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3406 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3313, float %fneg.2365.3, i64 3, !dbg !158
  br label %if.end533

if.end533:                                        ; preds = %if.then504, %for.cond509.preheader
  %acc_s.sroa.0.6 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3406, %for.cond509.preheader ], [ zeroinitializer, %if.then504 ], !dbg !85
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.6), !dbg !160, !call_argsrelate !87
  %87 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %86), !dbg !160, !call_argsrelate !87
  %88 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %87), !dbg !160, !call_argsrelate !87
  %89 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %88), !dbg !160, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract3129 = extractelement <4 x float> %89, i64 0, !dbg !161
  %mul568 = fmul contract float %acc_s.sroa.0.0.vec.extract3129, 0x3FB99999A0000000, !dbg !162
  %90 = tail call contract noundef float @llvm.minnum.f32(float %mul568, float 0x4024CB5EC0000000), !dbg !163
  %91 = tail call contract noundef float @llvm.exp.f32(float %90), !dbg !165
  %acc_s.sroa.0.4.vec.extract3222 = extractelement <4 x float> %89, i64 1, !dbg !161
  %mul568.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3222, 0x3FB99999A0000000, !dbg !162
  %92 = tail call contract noundef float @llvm.minnum.f32(float %mul568.1, float 0x4024CB5EC0000000), !dbg !163
  %93 = tail call contract noundef float @llvm.exp.f32(float %92), !dbg !165
  %acc_s.sroa.0.8.vec.extract3315 = extractelement <4 x float> %89, i64 2, !dbg !161
  %mul568.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3315, 0x3FB99999A0000000, !dbg !162
  %94 = tail call contract noundef float @llvm.minnum.f32(float %mul568.2, float 0x4024CB5EC0000000), !dbg !163
  %95 = tail call contract noundef float @llvm.exp.f32(float %94), !dbg !165
  %acc_s.sroa.0.12.vec.extract3408 = extractelement <4 x float> %89, i64 3, !dbg !161
  %mul568.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3408, 0x3FB99999A0000000, !dbg !162
  %96 = tail call contract noundef float @llvm.minnum.f32(float %mul568.3, float 0x4024CB5EC0000000), !dbg !163
  %97 = tail call contract noundef float @llvm.exp.f32(float %96), !dbg !165
  %add584 = fadd contract float %sum_acc.sroa.0.2, %91, !dbg !167
  %add584.1 = fadd contract float %sum_acc.sroa.20.2, %93, !dbg !167
  %add584.2 = fadd contract float %sum_acc.sroa.38.2, %95, !dbg !167
  %add584.3 = fadd contract float %sum_acc.sroa.56.2, %97, !dbg !167
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %91), !dbg !168
  %gep2430.idx = shl nuw nsw i32 %18, 3, !dbg !172
  %gep2430 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 1536), i32 %gep2430.idx, !dbg !172
  store i16 %98, ptr addrspace(3) %gep2430, align 8, !dbg !173, !tbaa !107
  %99 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %93), !dbg !168
  %gep2430.1 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 1538), i32 %gep2430.idx, !dbg !172
  store i16 %99, ptr addrspace(3) %gep2430.1, align 2, !dbg !173, !tbaa !107
  %100 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %95), !dbg !168
  %gep2430.2 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 1540), i32 %gep2430.idx, !dbg !172
  store i16 %100, ptr addrspace(3) %gep2430.2, align 4, !dbg !173, !tbaa !107
  %101 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %97), !dbg !168
  %gep2430.3 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 1542), i32 %gep2430.idx, !dbg !172
  store i16 %101, ptr addrspace(3) %gep2430.3, align 2, !dbg !173, !tbaa !107
  br label %if.end606, !dbg !174

if.end606:                                        ; preds = %if.end533, %land.lhs.true501, %if.end497
  %sum_acc.sroa.56.3 = phi float [ %sum_acc.sroa.56.2, %land.lhs.true501 ], [ %add584.3, %if.end533 ], [ %sum_acc.sroa.56.2, %if.end497 ], !dbg !85
  %sum_acc.sroa.38.3 = phi float [ %sum_acc.sroa.38.2, %land.lhs.true501 ], [ %add584.2, %if.end533 ], [ %sum_acc.sroa.38.2, %if.end497 ], !dbg !85
  %sum_acc.sroa.20.3 = phi float [ %sum_acc.sroa.20.2, %land.lhs.true501 ], [ %add584.1, %if.end533 ], [ %sum_acc.sroa.20.2, %if.end497 ], !dbg !85
  %sum_acc.sroa.0.3 = phi float [ %sum_acc.sroa.0.2, %land.lhs.true501 ], [ %add584, %if.end533 ], [ %sum_acc.sroa.0.2, %if.end497 ], !dbg !85
  %or.cond2537 = icmp ugt i32 %mul11.4, 1023, !dbg !175
  %cmp613.not = icmp sgt i32 %mul11.4, %1
  %or.cond2538 = or i1 %or.cond2537, %cmp613.not, !dbg !175
  br i1 %or.cond2538, label %if.end638, label %for.cond615.preheader, !dbg !175

for.cond615.preheader:                            ; preds = %if.end606
  %mul620 = shl nsw i32 %0, 16
  %102 = shl nsw i32 %cond.i.i2378.4, 10
  %mul622 = and i32 %102, 64512
  %mul627 = shl nuw nsw i32 %18, 3
  %add623 = or disjoint i32 %mul627, %mul620
  %add625 = add nuw nsw i32 %add623, %mul622
  %103 = zext nneg i32 %add625 to i64, !dbg !176
  %add.ptr630 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %103, !dbg !177
  %K_reg.sroa.0.0.copyload3480 = load <4 x half>, ptr addrspace(4) %add.ptr630, align 16, !dbg !178
  %K_reg.sroa.6.0.add.ptr630.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr630, i64 8, !dbg !178
  %K_reg.sroa.6.0.copyload3481 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.6.0.add.ptr630.sroa_idx, align 8, !dbg !178
  %104 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %103, !dbg !177
  %add.ptr630.1 = getelementptr inbounds i8, ptr addrspace(4) %104, i64 1024, !dbg !177
  %K_reg.sroa.8.16.copyload3484 = load <4 x half>, ptr addrspace(4) %add.ptr630.1, align 16, !dbg !178
  %K_reg.sroa.12.16.add.ptr630.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %104, i64 1032, !dbg !178
  %K_reg.sroa.12.16.copyload3485 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.12.16.add.ptr630.1.sroa_idx, align 8, !dbg !178
  br label %if.end638, !dbg !179

if.end638:                                        ; preds = %for.cond615.preheader, %if.end606
  %K_reg.sroa.12.1 = phi <4 x half> [ %K_reg.sroa.12.0, %if.end606 ], [ %K_reg.sroa.12.16.copyload3485, %for.cond615.preheader ]
  %K_reg.sroa.8.1 = phi <4 x half> [ %K_reg.sroa.8.0, %if.end606 ], [ %K_reg.sroa.8.16.copyload3484, %for.cond615.preheader ]
  %K_reg.sroa.6.1 = phi <4 x half> [ %K_reg.sroa.6.0, %if.end606 ], [ %K_reg.sroa.6.0.copyload3481, %for.cond615.preheader ]
  %K_reg.sroa.0.1 = phi <4 x half> [ %K_reg.sroa.0.0, %if.end606 ], [ %K_reg.sroa.0.0.copyload3480, %for.cond615.preheader ]
  %or.cond2539 = icmp ugt i32 %mul11.5, 1023, !dbg !180
  %cmp645.not = icmp sgt i32 %mul11.5, %1
  %or.cond2540 = or i1 %or.cond2539, %cmp645.not, !dbg !180
  br i1 %or.cond2540, label %if.end670, label %for.cond647.preheader, !dbg !180

for.cond647.preheader:                            ; preds = %if.end638
  %mul652 = shl nsw i32 %0, 16
  %105 = shl nsw i32 %cond.i.i2378.5, 10
  %mul654 = and i32 %105, 64512
  %mul659 = shl nuw nsw i32 %18, 3
  %add655 = or disjoint i32 %mul659, %mul652
  %add657 = add nuw nsw i32 %add655, %mul654
  %106 = zext nneg i32 %add657 to i64, !dbg !181
  %add.ptr662 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %106, !dbg !182
  %K_reg1.sroa.0.0.copyload3472 = load <4 x half>, ptr addrspace(4) %add.ptr662, align 16, !dbg !183
  %K_reg1.sroa.6.0.add.ptr662.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr662, i64 8, !dbg !183
  %K_reg1.sroa.6.0.copyload3473 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.6.0.add.ptr662.sroa_idx, align 8, !dbg !183
  %107 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %106, !dbg !182
  %add.ptr662.1 = getelementptr inbounds i8, ptr addrspace(4) %107, i64 1024, !dbg !182
  %K_reg1.sroa.8.16.copyload3476 = load <4 x half>, ptr addrspace(4) %add.ptr662.1, align 16, !dbg !183
  %K_reg1.sroa.12.16.add.ptr662.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %107, i64 1032, !dbg !183
  %K_reg1.sroa.12.16.copyload3477 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.12.16.add.ptr662.1.sroa_idx, align 8, !dbg !183
  br label %if.end670, !dbg !184

if.end670:                                        ; preds = %for.cond647.preheader, %if.end638
  %K_reg1.sroa.12.1 = phi <4 x half> [ %K_reg1.sroa.12.0, %if.end638 ], [ %K_reg1.sroa.12.16.copyload3477, %for.cond647.preheader ]
  %K_reg1.sroa.8.1 = phi <4 x half> [ %K_reg1.sroa.8.0, %if.end638 ], [ %K_reg1.sroa.8.16.copyload3476, %for.cond647.preheader ]
  %K_reg1.sroa.6.1 = phi <4 x half> [ %K_reg1.sroa.6.0, %if.end638 ], [ %K_reg1.sroa.6.0.copyload3473, %for.cond647.preheader ]
  %K_reg1.sroa.0.1 = phi <4 x half> [ %K_reg1.sroa.0.0, %if.end638 ], [ %K_reg1.sroa.0.0.copyload3472, %for.cond647.preheader ]
  %or.cond2541 = icmp ugt i32 %mul11.6, 1023, !dbg !185
  %cmp677.not = icmp sgt i32 %mul11.6, %1
  %or.cond2542 = or i1 %or.cond2541, %cmp677.not, !dbg !185
  br i1 %or.cond2542, label %if.end702, label %for.cond679.preheader, !dbg !185

for.cond679.preheader:                            ; preds = %if.end670
  %mul684 = shl nsw i32 %0, 16
  %108 = shl nsw i32 %cond.i.i2378.6, 10
  %mul686 = and i32 %108, 64512
  %mul691 = shl nuw nsw i32 %18, 3
  %add687 = or disjoint i32 %mul691, %mul684
  %add689 = add nuw nsw i32 %add687, %mul686
  %109 = zext nneg i32 %add689 to i64, !dbg !186
  %add.ptr694 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %109, !dbg !187
  %K_reg2.sroa.0.0.copyload3464 = load <4 x half>, ptr addrspace(4) %add.ptr694, align 16, !dbg !188
  %K_reg2.sroa.6.0.add.ptr694.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr694, i64 8, !dbg !188
  %K_reg2.sroa.6.0.copyload3465 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.6.0.add.ptr694.sroa_idx, align 8, !dbg !188
  %110 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %109, !dbg !187
  %add.ptr694.1 = getelementptr inbounds i8, ptr addrspace(4) %110, i64 1024, !dbg !187
  %K_reg2.sroa.8.16.copyload3468 = load <4 x half>, ptr addrspace(4) %add.ptr694.1, align 16, !dbg !188
  %K_reg2.sroa.12.16.add.ptr694.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %110, i64 1032, !dbg !188
  %K_reg2.sroa.12.16.copyload3469 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.12.16.add.ptr694.1.sroa_idx, align 8, !dbg !188
  br label %if.end702, !dbg !189

if.end702:                                        ; preds = %for.cond679.preheader, %if.end670
  %K_reg2.sroa.12.1 = phi <4 x half> [ %K_reg2.sroa.12.0, %if.end670 ], [ %K_reg2.sroa.12.16.copyload3469, %for.cond679.preheader ]
  %K_reg2.sroa.8.1 = phi <4 x half> [ %K_reg2.sroa.8.0, %if.end670 ], [ %K_reg2.sroa.8.16.copyload3468, %for.cond679.preheader ]
  %K_reg2.sroa.6.1 = phi <4 x half> [ %K_reg2.sroa.6.0, %if.end670 ], [ %K_reg2.sroa.6.0.copyload3465, %for.cond679.preheader ]
  %K_reg2.sroa.0.1 = phi <4 x half> [ %K_reg2.sroa.0.0, %if.end670 ], [ %K_reg2.sroa.0.0.copyload3464, %for.cond679.preheader ]
  %or.cond2543 = icmp ugt i32 %mul11.7, 1023, !dbg !190
  %cmp709.not = icmp sgt i32 %mul11.7, %1
  %or.cond2544 = or i1 %or.cond2543, %cmp709.not, !dbg !190
  br i1 %or.cond2544, label %if.end734, label %for.cond711.preheader, !dbg !190

for.cond711.preheader:                            ; preds = %if.end702
  %mul716 = shl nsw i32 %0, 16
  %111 = shl nsw i32 %cond.i.i2378.7, 10
  %mul718 = and i32 %111, 64512
  %mul723 = shl nuw nsw i32 %18, 3
  %add719 = or disjoint i32 %mul723, %mul716
  %add721 = add nuw nsw i32 %add719, %mul718
  %112 = zext nneg i32 %add721 to i64, !dbg !191
  %add.ptr726 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %112, !dbg !192
  %K_reg3.sroa.0.0.copyload3456 = load <4 x half>, ptr addrspace(4) %add.ptr726, align 16, !dbg !193
  %K_reg3.sroa.6.0.add.ptr726.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr726, i64 8, !dbg !193
  %K_reg3.sroa.6.0.copyload3457 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.6.0.add.ptr726.sroa_idx, align 8, !dbg !193
  %113 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %112, !dbg !192
  %add.ptr726.1 = getelementptr inbounds i8, ptr addrspace(4) %113, i64 1024, !dbg !192
  %K_reg3.sroa.8.16.copyload3460 = load <4 x half>, ptr addrspace(4) %add.ptr726.1, align 16, !dbg !193
  %K_reg3.sroa.12.16.add.ptr726.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %113, i64 1032, !dbg !193
  %K_reg3.sroa.12.16.copyload3461 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.12.16.add.ptr726.1.sroa_idx, align 8, !dbg !193
  br label %if.end734, !dbg !194

if.end734:                                        ; preds = %for.cond711.preheader, %if.end702
  %K_reg3.sroa.12.1 = phi <4 x half> [ %K_reg3.sroa.12.0, %if.end702 ], [ %K_reg3.sroa.12.16.copyload3461, %for.cond711.preheader ]
  %K_reg3.sroa.8.1 = phi <4 x half> [ %K_reg3.sroa.8.0, %if.end702 ], [ %K_reg3.sroa.8.16.copyload3460, %for.cond711.preheader ]
  %K_reg3.sroa.6.1 = phi <4 x half> [ %K_reg3.sroa.6.0, %if.end702 ], [ %K_reg3.sroa.6.0.copyload3457, %for.cond711.preheader ]
  %K_reg3.sroa.0.1 = phi <4 x half> [ %K_reg3.sroa.0.0, %if.end702 ], [ %K_reg3.sroa.0.0.copyload3456, %for.cond711.preheader ]
  %or.cond2545 = icmp ult i32 %mul11.4, 1024, !dbg !194
  br i1 %or.cond2545, label %land.lhs.true738, label %if.end843, !dbg !194

land.lhs.true738:                                 ; preds = %if.end734
  br i1 %cmp613.not, label %if.end843, label %if.then741, !dbg !195

if.then741:                                       ; preds = %land.lhs.true738
  %add743 = or disjoint i32 %mul11.4, 15, !dbg !196
  %cmp744 = icmp ult i32 %1, %add743, !dbg !197
  br i1 %cmp744, label %for.cond746.preheader, label %if.end770, !dbg !198

for.cond746.preheader:                            ; preds = %if.then741
  %114 = lshr i32 %18, 2
  %mul752 = and i32 %114, 252
  %add753 = add nuw nsw i32 %mul11.4, %mul752
  %cmp756.not = icmp sgt i32 %add753, %1, !dbg !199
  %fneg.2366 = select i1 %cmp756.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3137 = insertelement <4 x float> poison, float %fneg.2366, i64 0, !dbg !200
  %cmp756.not.1.not = icmp slt i32 %add753, %1, !dbg !199
  %fneg.2366.1 = select i1 %cmp756.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3230 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3137, float %fneg.2366.1, i64 1, !dbg !200
  %add754.2 = or disjoint i32 %add753, 2, !dbg !201
  %cmp756.not.2 = icmp sgt i32 %add754.2, %1, !dbg !199
  %fneg.2366.2 = select i1 %cmp756.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3323 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3230, float %fneg.2366.2, i64 2, !dbg !200
  %add754.3 = or disjoint i32 %add753, 3, !dbg !201
  %cmp756.not.3 = icmp sgt i32 %add754.3, %1, !dbg !199
  %fneg.2366.3 = select i1 %cmp756.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3416 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3323, float %fneg.2366.3, i64 3, !dbg !200
  br label %if.end770

if.end770:                                        ; preds = %if.then741, %for.cond746.preheader
  %acc_s.sroa.0.8 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3416, %for.cond746.preheader ], [ zeroinitializer, %if.then741 ], !dbg !85
  %115 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.8), !dbg !202, !call_argsrelate !87
  %116 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %115), !dbg !202, !call_argsrelate !87
  %117 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %116), !dbg !202, !call_argsrelate !87
  %118 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %117), !dbg !202, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract3139 = extractelement <4 x float> %118, i64 0, !dbg !203
  %mul805 = fmul contract float %acc_s.sroa.0.0.vec.extract3139, 0x3FB99999A0000000, !dbg !204
  %119 = tail call contract noundef float @llvm.minnum.f32(float %mul805, float 0x4024CB5EC0000000), !dbg !205
  %120 = tail call contract noundef float @llvm.exp.f32(float %119), !dbg !207
  %acc_s.sroa.0.4.vec.extract3232 = extractelement <4 x float> %118, i64 1, !dbg !203
  %mul805.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3232, 0x3FB99999A0000000, !dbg !204
  %121 = tail call contract noundef float @llvm.minnum.f32(float %mul805.1, float 0x4024CB5EC0000000), !dbg !205
  %122 = tail call contract noundef float @llvm.exp.f32(float %121), !dbg !207
  %acc_s.sroa.0.8.vec.extract3325 = extractelement <4 x float> %118, i64 2, !dbg !203
  %mul805.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3325, 0x3FB99999A0000000, !dbg !204
  %123 = tail call contract noundef float @llvm.minnum.f32(float %mul805.2, float 0x4024CB5EC0000000), !dbg !205
  %124 = tail call contract noundef float @llvm.exp.f32(float %123), !dbg !207
  %acc_s.sroa.0.12.vec.extract3418 = extractelement <4 x float> %118, i64 3, !dbg !203
  %mul805.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3418, 0x3FB99999A0000000, !dbg !204
  %125 = tail call contract noundef float @llvm.minnum.f32(float %mul805.3, float 0x4024CB5EC0000000), !dbg !205
  %126 = tail call contract noundef float @llvm.exp.f32(float %125), !dbg !207
  %add821 = fadd contract float %sum_acc.sroa.0.3, %120, !dbg !209
  %add821.1 = fadd contract float %sum_acc.sroa.20.3, %122, !dbg !209
  %add821.2 = fadd contract float %sum_acc.sroa.38.3, %124, !dbg !209
  %add821.3 = fadd contract float %sum_acc.sroa.56.3, %126, !dbg !209
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %120), !dbg !210
  %gep2445.idx = shl nuw nsw i32 %18, 3, !dbg !214
  %gep2445 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %gep2445.idx, !dbg !214
  store i16 %127, ptr addrspace(3) %gep2445, align 8, !dbg !215, !tbaa !107
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %122), !dbg !210
  %gep2445.1 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2050), i32 %gep2445.idx, !dbg !214
  store i16 %128, ptr addrspace(3) %gep2445.1, align 2, !dbg !215, !tbaa !107
  %129 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %124), !dbg !210
  %gep2445.2 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2052), i32 %gep2445.idx, !dbg !214
  store i16 %129, ptr addrspace(3) %gep2445.2, align 4, !dbg !215, !tbaa !107
  %130 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %126), !dbg !210
  %gep2445.3 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2054), i32 %gep2445.idx, !dbg !214
  store i16 %130, ptr addrspace(3) %gep2445.3, align 2, !dbg !215, !tbaa !107
  br label %if.end843, !dbg !216

if.end843:                                        ; preds = %if.end770, %land.lhs.true738, %if.end734
  %sum_acc.sroa.56.4 = phi float [ %sum_acc.sroa.56.3, %land.lhs.true738 ], [ %add821.3, %if.end770 ], [ %sum_acc.sroa.56.3, %if.end734 ], !dbg !85
  %sum_acc.sroa.38.4 = phi float [ %sum_acc.sroa.38.3, %land.lhs.true738 ], [ %add821.2, %if.end770 ], [ %sum_acc.sroa.38.3, %if.end734 ], !dbg !85
  %sum_acc.sroa.20.4 = phi float [ %sum_acc.sroa.20.3, %land.lhs.true738 ], [ %add821.1, %if.end770 ], [ %sum_acc.sroa.20.3, %if.end734 ], !dbg !85
  %sum_acc.sroa.0.4 = phi float [ %sum_acc.sroa.0.3, %land.lhs.true738 ], [ %add821, %if.end770 ], [ %sum_acc.sroa.0.3, %if.end734 ], !dbg !85
  %or.cond2546 = icmp ult i32 %mul11.5, 1024, !dbg !216
  br i1 %or.cond2546, label %land.lhs.true847, label %if.end952, !dbg !216

land.lhs.true847:                                 ; preds = %if.end843
  br i1 %cmp645.not, label %if.end952, label %if.then850, !dbg !217

if.then850:                                       ; preds = %land.lhs.true847
  %add852 = or disjoint i32 %mul11.5, 15, !dbg !218
  %cmp853 = icmp ult i32 %1, %add852, !dbg !219
  br i1 %cmp853, label %for.cond855.preheader, label %if.end879, !dbg !220

for.cond855.preheader:                            ; preds = %if.then850
  %131 = lshr i32 %18, 2
  %mul861 = and i32 %131, 252
  %add862 = add nuw nsw i32 %mul11.5, %mul861
  %cmp865.not = icmp sgt i32 %add862, %1, !dbg !221
  %fneg.2367 = select i1 %cmp865.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3147 = insertelement <4 x float> poison, float %fneg.2367, i64 0, !dbg !222
  %cmp865.not.1.not = icmp slt i32 %add862, %1, !dbg !221
  %fneg.2367.1 = select i1 %cmp865.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3240 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3147, float %fneg.2367.1, i64 1, !dbg !222
  %add863.2 = or disjoint i32 %add862, 2, !dbg !223
  %cmp865.not.2 = icmp sgt i32 %add863.2, %1, !dbg !221
  %fneg.2367.2 = select i1 %cmp865.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3333 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3240, float %fneg.2367.2, i64 2, !dbg !222
  %add863.3 = or disjoint i32 %add862, 3, !dbg !223
  %cmp865.not.3 = icmp sgt i32 %add863.3, %1, !dbg !221
  %fneg.2367.3 = select i1 %cmp865.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3426 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3333, float %fneg.2367.3, i64 3, !dbg !222
  br label %if.end879

if.end879:                                        ; preds = %if.then850, %for.cond855.preheader
  %acc_s.sroa.0.10 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3426, %for.cond855.preheader ], [ zeroinitializer, %if.then850 ], !dbg !85
  %132 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.10), !dbg !224, !call_argsrelate !87
  %133 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %132), !dbg !224, !call_argsrelate !87
  %134 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %133), !dbg !224, !call_argsrelate !87
  %135 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %134), !dbg !224, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract3149 = extractelement <4 x float> %135, i64 0, !dbg !225
  %mul914 = fmul contract float %acc_s.sroa.0.0.vec.extract3149, 0x3FB99999A0000000, !dbg !226
  %136 = tail call contract noundef float @llvm.minnum.f32(float %mul914, float 0x4024CB5EC0000000), !dbg !227
  %137 = tail call contract noundef float @llvm.exp.f32(float %136), !dbg !229
  %acc_s.sroa.0.4.vec.extract3242 = extractelement <4 x float> %135, i64 1, !dbg !225
  %mul914.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3242, 0x3FB99999A0000000, !dbg !226
  %138 = tail call contract noundef float @llvm.minnum.f32(float %mul914.1, float 0x4024CB5EC0000000), !dbg !227
  %139 = tail call contract noundef float @llvm.exp.f32(float %138), !dbg !229
  %acc_s.sroa.0.8.vec.extract3335 = extractelement <4 x float> %135, i64 2, !dbg !225
  %mul914.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3335, 0x3FB99999A0000000, !dbg !226
  %140 = tail call contract noundef float @llvm.minnum.f32(float %mul914.2, float 0x4024CB5EC0000000), !dbg !227
  %141 = tail call contract noundef float @llvm.exp.f32(float %140), !dbg !229
  %acc_s.sroa.0.12.vec.extract3428 = extractelement <4 x float> %135, i64 3, !dbg !225
  %mul914.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3428, 0x3FB99999A0000000, !dbg !226
  %142 = tail call contract noundef float @llvm.minnum.f32(float %mul914.3, float 0x4024CB5EC0000000), !dbg !227
  %143 = tail call contract noundef float @llvm.exp.f32(float %142), !dbg !229
  %add930 = fadd contract float %sum_acc.sroa.0.4, %137, !dbg !231
  %add930.1 = fadd contract float %sum_acc.sroa.20.4, %139, !dbg !231
  %add930.2 = fadd contract float %sum_acc.sroa.38.4, %141, !dbg !231
  %add930.3 = fadd contract float %sum_acc.sroa.56.4, %143, !dbg !231
  %144 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %137), !dbg !232
  %gep2456.idx = shl nuw nsw i32 %18, 3, !dbg !236
  %gep2456 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2560), i32 %gep2456.idx, !dbg !236
  store i16 %144, ptr addrspace(3) %gep2456, align 8, !dbg !237, !tbaa !107
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %139), !dbg !232
  %gep2456.1 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2562), i32 %gep2456.idx, !dbg !236
  store i16 %145, ptr addrspace(3) %gep2456.1, align 2, !dbg !237, !tbaa !107
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %141), !dbg !232
  %gep2456.2 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2564), i32 %gep2456.idx, !dbg !236
  store i16 %146, ptr addrspace(3) %gep2456.2, align 4, !dbg !237, !tbaa !107
  %147 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %143), !dbg !232
  %gep2456.3 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2566), i32 %gep2456.idx, !dbg !236
  store i16 %147, ptr addrspace(3) %gep2456.3, align 2, !dbg !237, !tbaa !107
  br label %if.end952, !dbg !238

if.end952:                                        ; preds = %if.end879, %land.lhs.true847, %if.end843
  %sum_acc.sroa.56.5 = phi float [ %sum_acc.sroa.56.4, %land.lhs.true847 ], [ %add930.3, %if.end879 ], [ %sum_acc.sroa.56.4, %if.end843 ], !dbg !85
  %sum_acc.sroa.38.5 = phi float [ %sum_acc.sroa.38.4, %land.lhs.true847 ], [ %add930.2, %if.end879 ], [ %sum_acc.sroa.38.4, %if.end843 ], !dbg !85
  %sum_acc.sroa.20.5 = phi float [ %sum_acc.sroa.20.4, %land.lhs.true847 ], [ %add930.1, %if.end879 ], [ %sum_acc.sroa.20.4, %if.end843 ], !dbg !85
  %sum_acc.sroa.0.5 = phi float [ %sum_acc.sroa.0.4, %land.lhs.true847 ], [ %add930, %if.end879 ], [ %sum_acc.sroa.0.4, %if.end843 ], !dbg !85
  %or.cond2547 = icmp ult i32 %mul11.6, 1024, !dbg !238
  br i1 %or.cond2547, label %land.lhs.true956, label %if.end1061, !dbg !238

land.lhs.true956:                                 ; preds = %if.end952
  br i1 %cmp677.not, label %if.end1061, label %if.then959, !dbg !239

if.then959:                                       ; preds = %land.lhs.true956
  %add961 = or disjoint i32 %mul11.6, 15, !dbg !240
  %cmp962 = icmp ult i32 %1, %add961, !dbg !241
  br i1 %cmp962, label %for.cond964.preheader, label %if.end988, !dbg !242

for.cond964.preheader:                            ; preds = %if.then959
  %148 = lshr i32 %18, 2
  %mul970 = and i32 %148, 252
  %add971 = add nuw nsw i32 %mul11.6, %mul970
  %cmp974.not = icmp sgt i32 %add971, %1, !dbg !243
  %fneg.2368 = select i1 %cmp974.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3157 = insertelement <4 x float> poison, float %fneg.2368, i64 0, !dbg !244
  %cmp974.not.1.not = icmp slt i32 %add971, %1, !dbg !243
  %fneg.2368.1 = select i1 %cmp974.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3250 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3157, float %fneg.2368.1, i64 1, !dbg !244
  %add972.2 = or disjoint i32 %add971, 2, !dbg !245
  %cmp974.not.2 = icmp sgt i32 %add972.2, %1, !dbg !243
  %fneg.2368.2 = select i1 %cmp974.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3343 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3250, float %fneg.2368.2, i64 2, !dbg !244
  %add972.3 = or disjoint i32 %add971, 3, !dbg !245
  %cmp974.not.3 = icmp sgt i32 %add972.3, %1, !dbg !243
  %fneg.2368.3 = select i1 %cmp974.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3436 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3343, float %fneg.2368.3, i64 3, !dbg !244
  br label %if.end988

if.end988:                                        ; preds = %if.then959, %for.cond964.preheader
  %acc_s.sroa.0.12 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3436, %for.cond964.preheader ], [ zeroinitializer, %if.then959 ], !dbg !85
  %149 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.12), !dbg !246, !call_argsrelate !87
  %150 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %149), !dbg !246, !call_argsrelate !87
  %151 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %150), !dbg !246, !call_argsrelate !87
  %152 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %151), !dbg !246, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract3159 = extractelement <4 x float> %152, i64 0, !dbg !247
  %mul1023 = fmul contract float %acc_s.sroa.0.0.vec.extract3159, 0x3FB99999A0000000, !dbg !248
  %153 = tail call contract noundef float @llvm.minnum.f32(float %mul1023, float 0x4024CB5EC0000000), !dbg !249
  %154 = tail call contract noundef float @llvm.exp.f32(float %153), !dbg !251
  %acc_s.sroa.0.4.vec.extract3252 = extractelement <4 x float> %152, i64 1, !dbg !247
  %mul1023.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3252, 0x3FB99999A0000000, !dbg !248
  %155 = tail call contract noundef float @llvm.minnum.f32(float %mul1023.1, float 0x4024CB5EC0000000), !dbg !249
  %156 = tail call contract noundef float @llvm.exp.f32(float %155), !dbg !251
  %acc_s.sroa.0.8.vec.extract3345 = extractelement <4 x float> %152, i64 2, !dbg !247
  %mul1023.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3345, 0x3FB99999A0000000, !dbg !248
  %157 = tail call contract noundef float @llvm.minnum.f32(float %mul1023.2, float 0x4024CB5EC0000000), !dbg !249
  %158 = tail call contract noundef float @llvm.exp.f32(float %157), !dbg !251
  %acc_s.sroa.0.12.vec.extract3438 = extractelement <4 x float> %152, i64 3, !dbg !247
  %mul1023.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3438, 0x3FB99999A0000000, !dbg !248
  %159 = tail call contract noundef float @llvm.minnum.f32(float %mul1023.3, float 0x4024CB5EC0000000), !dbg !249
  %160 = tail call contract noundef float @llvm.exp.f32(float %159), !dbg !251
  %add1039 = fadd contract float %sum_acc.sroa.0.5, %154, !dbg !253
  %add1039.1 = fadd contract float %sum_acc.sroa.20.5, %156, !dbg !253
  %add1039.2 = fadd contract float %sum_acc.sroa.38.5, %158, !dbg !253
  %add1039.3 = fadd contract float %sum_acc.sroa.56.5, %160, !dbg !253
  %161 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %154), !dbg !254
  %gep2467.idx = shl nuw nsw i32 %18, 3, !dbg !258
  %gep2467 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 3072), i32 %gep2467.idx, !dbg !258
  store i16 %161, ptr addrspace(3) %gep2467, align 8, !dbg !259, !tbaa !107
  %162 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %156), !dbg !254
  %gep2467.1 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 3074), i32 %gep2467.idx, !dbg !258
  store i16 %162, ptr addrspace(3) %gep2467.1, align 2, !dbg !259, !tbaa !107
  %163 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %158), !dbg !254
  %gep2467.2 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 3076), i32 %gep2467.idx, !dbg !258
  store i16 %163, ptr addrspace(3) %gep2467.2, align 4, !dbg !259, !tbaa !107
  %164 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %160), !dbg !254
  %gep2467.3 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 3078), i32 %gep2467.idx, !dbg !258
  store i16 %164, ptr addrspace(3) %gep2467.3, align 2, !dbg !259, !tbaa !107
  br label %if.end1061, !dbg !260

if.end1061:                                       ; preds = %if.end988, %land.lhs.true956, %if.end952
  %sum_acc.sroa.56.6 = phi float [ %sum_acc.sroa.56.5, %land.lhs.true956 ], [ %add1039.3, %if.end988 ], [ %sum_acc.sroa.56.5, %if.end952 ], !dbg !85
  %sum_acc.sroa.38.6 = phi float [ %sum_acc.sroa.38.5, %land.lhs.true956 ], [ %add1039.2, %if.end988 ], [ %sum_acc.sroa.38.5, %if.end952 ], !dbg !85
  %sum_acc.sroa.20.6 = phi float [ %sum_acc.sroa.20.5, %land.lhs.true956 ], [ %add1039.1, %if.end988 ], [ %sum_acc.sroa.20.5, %if.end952 ], !dbg !85
  %sum_acc.sroa.0.6 = phi float [ %sum_acc.sroa.0.5, %land.lhs.true956 ], [ %add1039, %if.end988 ], [ %sum_acc.sroa.0.5, %if.end952 ], !dbg !85
  %or.cond2548 = icmp ult i32 %mul11.7, 1024, !dbg !260
  br i1 %or.cond2548, label %land.lhs.true1065, label %if.end1170, !dbg !260

land.lhs.true1065:                                ; preds = %if.end1061
  br i1 %cmp709.not, label %if.end1170, label %if.then1068, !dbg !261

if.then1068:                                      ; preds = %land.lhs.true1065
  %add1070 = or disjoint i32 %mul11.7, 15, !dbg !262
  %cmp1071 = icmp slt i32 %1, %add1070, !dbg !263
  br i1 %cmp1071, label %for.cond1073.preheader, label %if.end1097, !dbg !264

for.cond1073.preheader:                           ; preds = %if.then1068
  %165 = lshr i32 %18, 2
  %mul1079 = and i32 %165, 252
  %add1080 = add nuw nsw i32 %mul11.7, %mul1079
  %cmp1083.not = icmp sgt i32 %add1080, %1, !dbg !265
  %fneg.2369 = select i1 %cmp1083.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3167 = insertelement <4 x float> poison, float %fneg.2369, i64 0, !dbg !266
  %cmp1083.not.1.not = icmp slt i32 %add1080, %1, !dbg !265
  %fneg.2369.1 = select i1 %cmp1083.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3260 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3167, float %fneg.2369.1, i64 1, !dbg !266
  %add1081.2 = or disjoint i32 %add1080, 2, !dbg !267
  %cmp1083.not.2 = icmp sgt i32 %add1081.2, %1, !dbg !265
  %fneg.2369.2 = select i1 %cmp1083.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3353 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3260, float %fneg.2369.2, i64 2, !dbg !266
  %add1081.3 = or disjoint i32 %add1080, 3, !dbg !267
  %cmp1083.not.3 = icmp sgt i32 %add1081.3, %1, !dbg !265
  %fneg.2369.3 = select i1 %cmp1083.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3446 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3353, float %fneg.2369.3, i64 3, !dbg !266
  br label %if.end1097

if.end1097:                                       ; preds = %if.then1068, %for.cond1073.preheader
  %acc_s.sroa.0.14 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3446, %for.cond1073.preheader ], [ zeroinitializer, %if.then1068 ], !dbg !85
  %166 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.14), !dbg !268, !call_argsrelate !87
  %167 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %166), !dbg !268, !call_argsrelate !87
  %168 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %167), !dbg !268, !call_argsrelate !87
  %169 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %168), !dbg !268, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract3169 = extractelement <4 x float> %169, i64 0, !dbg !269
  %mul1132 = fmul contract float %acc_s.sroa.0.0.vec.extract3169, 0x3FB99999A0000000, !dbg !270
  %170 = tail call contract noundef float @llvm.minnum.f32(float %mul1132, float 0x4024CB5EC0000000), !dbg !271
  %171 = tail call contract noundef float @llvm.exp.f32(float %170), !dbg !273
  %acc_s.sroa.0.4.vec.extract3262 = extractelement <4 x float> %169, i64 1, !dbg !269
  %mul1132.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3262, 0x3FB99999A0000000, !dbg !270
  %172 = tail call contract noundef float @llvm.minnum.f32(float %mul1132.1, float 0x4024CB5EC0000000), !dbg !271
  %173 = tail call contract noundef float @llvm.exp.f32(float %172), !dbg !273
  %acc_s.sroa.0.8.vec.extract3355 = extractelement <4 x float> %169, i64 2, !dbg !269
  %mul1132.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3355, 0x3FB99999A0000000, !dbg !270
  %174 = tail call contract noundef float @llvm.minnum.f32(float %mul1132.2, float 0x4024CB5EC0000000), !dbg !271
  %175 = tail call contract noundef float @llvm.exp.f32(float %174), !dbg !273
  %acc_s.sroa.0.12.vec.extract3448 = extractelement <4 x float> %169, i64 3, !dbg !269
  %mul1132.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3448, 0x3FB99999A0000000, !dbg !270
  %176 = tail call contract noundef float @llvm.minnum.f32(float %mul1132.3, float 0x4024CB5EC0000000), !dbg !271
  %177 = tail call contract noundef float @llvm.exp.f32(float %176), !dbg !273
  %add1148 = fadd contract float %sum_acc.sroa.0.6, %171, !dbg !275
  %add1148.1 = fadd contract float %sum_acc.sroa.20.6, %173, !dbg !275
  %add1148.2 = fadd contract float %sum_acc.sroa.38.6, %175, !dbg !275
  %add1148.3 = fadd contract float %sum_acc.sroa.56.6, %177, !dbg !275
  %178 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %171), !dbg !276
  %gep2478.idx = shl nuw nsw i32 %18, 3, !dbg !280
  %gep2478 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 3584), i32 %gep2478.idx, !dbg !280
  store i16 %178, ptr addrspace(3) %gep2478, align 8, !dbg !281, !tbaa !107
  %179 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %173), !dbg !276
  %gep2478.1 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 3586), i32 %gep2478.idx, !dbg !280
  store i16 %179, ptr addrspace(3) %gep2478.1, align 2, !dbg !281, !tbaa !107
  %180 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %175), !dbg !276
  %gep2478.2 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 3588), i32 %gep2478.idx, !dbg !280
  store i16 %180, ptr addrspace(3) %gep2478.2, align 4, !dbg !281, !tbaa !107
  %181 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %177), !dbg !276
  %gep2478.3 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 3590), i32 %gep2478.idx, !dbg !280
  store i16 %181, ptr addrspace(3) %gep2478.3, align 2, !dbg !281, !tbaa !107
  br label %if.end1170, !dbg !282

if.end1170:                                       ; preds = %if.end1097, %land.lhs.true1065, %if.end1061
  %sum_acc.sroa.56.7 = phi float [ %sum_acc.sroa.56.6, %land.lhs.true1065 ], [ %add1148.3, %if.end1097 ], [ %sum_acc.sroa.56.6, %if.end1061 ], !dbg !85
  %sum_acc.sroa.38.7 = phi float [ %sum_acc.sroa.38.6, %land.lhs.true1065 ], [ %add1148.2, %if.end1097 ], [ %sum_acc.sroa.38.6, %if.end1061 ], !dbg !85
  %sum_acc.sroa.20.7 = phi float [ %sum_acc.sroa.20.6, %land.lhs.true1065 ], [ %add1148.1, %if.end1097 ], [ %sum_acc.sroa.20.6, %if.end1061 ], !dbg !85
  %sum_acc.sroa.0.7 = phi float [ %sum_acc.sroa.0.6, %land.lhs.true1065 ], [ %add1148, %if.end1097 ], [ %sum_acc.sroa.0.6, %if.end1061 ], !dbg !85
  fence syncscope("warp") release, !dbg !283
  tail call void @llvm.mxc.barrier.warp(), !dbg !289
  fence syncscope("warp") acquire, !dbg !290
  br i1 %or.cond2526, label %if.end1286, label %for.cond1231.preheader, !dbg !291

for.cond1231.preheader:                           ; preds = %if.end1170
  %mul1236 = shl nsw i32 %0, 16
  %182 = shl nsw i32 %cond.i.i2378, 10
  %mul1238 = and i32 %182, 64512
  %mul1243 = shl nuw nsw i32 %18, 3
  %add1239 = or disjoint i32 %mul1243, %mul1236
  %add1241 = add nuw nsw i32 %add1239, %mul1238
  %183 = zext nneg i32 %add1241 to i64, !dbg !292
  %add.ptr1246 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %183, !dbg !293
  %V_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr1246, align 16, !dbg !294
  %V_reg.sroa.18.0.add.ptr1246.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1246, i64 8, !dbg !294
  %V_reg.sroa.18.0.copyload = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr1246.sroa_idx, align 8, !dbg !294
  %184 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %183, !dbg !293
  %add.ptr1246.1 = getelementptr inbounds i8, ptr addrspace(4) %184, i64 1024, !dbg !293
  %V_reg.sroa.26.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr1246.1, align 16, !dbg !294
  %V_reg.sroa.42.16.add.ptr1246.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %184, i64 1032, !dbg !294
  %V_reg.sroa.42.16.copyload = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr1246.1.sroa_idx, align 8, !dbg !294
  %arrayidx1262 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %mul1243, !dbg !295
  %185 = load <4 x half>, ptr addrspace(3) %arrayidx1262, align 8, !dbg !296, !tbaa !107
  %186 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload, <4 x half> %185, <4 x float> zeroinitializer), !dbg !297, !call_argsrelate !298
  %187 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload, <4 x half> %185, <4 x float> zeroinitializer), !dbg !297, !call_argsrelate !298
  %188 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload, <4 x half> %185, <4 x float> zeroinitializer), !dbg !297, !call_argsrelate !298
  %189 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload, <4 x half> %185, <4 x float> zeroinitializer), !dbg !297, !call_argsrelate !298
  br label %if.end1286, !dbg !299

if.end1286:                                       ; preds = %for.cond1231.preheader, %if.end1170
  %acc_o.sroa.110.0 = phi <4 x float> [ zeroinitializer, %if.end1170 ], [ %189, %for.cond1231.preheader ], !dbg !85
  %acc_o.sroa.74.0 = phi <4 x float> [ zeroinitializer, %if.end1170 ], [ %188, %for.cond1231.preheader ], !dbg !85
  %acc_o.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end1170 ], [ %187, %for.cond1231.preheader ], !dbg !85
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1170 ], [ %186, %for.cond1231.preheader ], !dbg !85
  br i1 %or.cond2528, label %if.end1351, label %for.cond1295.preheader, !dbg !300

for.cond1295.preheader:                           ; preds = %if.end1286
  %mul1300 = shl nsw i32 %0, 16
  %190 = shl nsw i32 %cond.i.i2378.1, 10
  %mul1302 = and i32 %190, 64512
  %mul1307 = shl nuw nsw i32 %18, 3
  %add1303 = or disjoint i32 %mul1307, %mul1300
  %add1305 = add nuw nsw i32 %add1303, %mul1302
  %191 = zext nneg i32 %add1305 to i64, !dbg !301
  %add.ptr1310 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %191, !dbg !302
  %V_reg.sroa.0.0.copyload2738 = load <4 x half>, ptr addrspace(4) %add.ptr1310, align 16, !dbg !303
  %V_reg.sroa.18.0.add.ptr1310.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1310, i64 8, !dbg !303
  %V_reg.sroa.18.0.copyload2745 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr1310.sroa_idx, align 8, !dbg !303
  %192 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %191, !dbg !302
  %add.ptr1310.1 = getelementptr inbounds i8, ptr addrspace(4) %192, i64 1024, !dbg !302
  %V_reg.sroa.26.16.copyload2766 = load <4 x half>, ptr addrspace(4) %add.ptr1310.1, align 16, !dbg !303
  %V_reg.sroa.42.16.add.ptr1310.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %192, i64 1032, !dbg !303
  %V_reg.sroa.42.16.copyload2773 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr1310.1.sroa_idx, align 8, !dbg !303
  %gep2488 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 512), i32 %mul1307, !dbg !304
  %193 = load <4 x half>, ptr addrspace(3) %gep2488, align 8, !dbg !305, !tbaa !107
  %194 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload2738, <4 x half> %193, <4 x float> zeroinitializer), !dbg !306, !call_argsrelate !298
  %195 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload2745, <4 x half> %193, <4 x float> zeroinitializer), !dbg !306, !call_argsrelate !298
  %196 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload2766, <4 x half> %193, <4 x float> zeroinitializer), !dbg !306, !call_argsrelate !298
  %197 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload2773, <4 x half> %193, <4 x float> zeroinitializer), !dbg !306, !call_argsrelate !298
  br label %if.end1351, !dbg !307

if.end1351:                                       ; preds = %for.cond1295.preheader, %if.end1286
  %acc_o_1.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end1286 ], [ %197, %for.cond1295.preheader ], !dbg !85
  %acc_o_1.sroa.26.0 = phi <4 x float> [ zeroinitializer, %if.end1286 ], [ %196, %for.cond1295.preheader ], !dbg !85
  %acc_o_1.sroa.14.0 = phi <4 x float> [ zeroinitializer, %if.end1286 ], [ %195, %for.cond1295.preheader ], !dbg !85
  %acc_o_1.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1286 ], [ %194, %for.cond1295.preheader ], !dbg !85
  br i1 %or.cond2530, label %if.end1416, label %for.cond1360.preheader, !dbg !308

for.cond1360.preheader:                           ; preds = %if.end1351
  %mul1365 = shl nsw i32 %0, 16
  %198 = shl nsw i32 %cond.i.i2378.2, 10
  %mul1367 = and i32 %198, 64512
  %mul1372 = shl nuw nsw i32 %18, 3
  %add1368 = or disjoint i32 %mul1372, %mul1365
  %add1370 = add nuw nsw i32 %add1368, %mul1367
  %199 = zext nneg i32 %add1370 to i64, !dbg !309
  %add.ptr1375 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %199, !dbg !310
  %V_reg.sroa.0.0.copyload2739 = load <4 x half>, ptr addrspace(4) %add.ptr1375, align 16, !dbg !311
  %V_reg.sroa.18.0.add.ptr1375.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1375, i64 8, !dbg !311
  %V_reg.sroa.18.0.copyload2746 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr1375.sroa_idx, align 8, !dbg !311
  %200 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %199, !dbg !310
  %add.ptr1375.1 = getelementptr inbounds i8, ptr addrspace(4) %200, i64 1024, !dbg !310
  %V_reg.sroa.26.16.copyload2767 = load <4 x half>, ptr addrspace(4) %add.ptr1375.1, align 16, !dbg !311
  %V_reg.sroa.42.16.add.ptr1375.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %200, i64 1032, !dbg !311
  %V_reg.sroa.42.16.copyload2774 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr1375.1.sroa_idx, align 8, !dbg !311
  %gep2492 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 1024), i32 %mul1372, !dbg !312
  %201 = load <4 x half>, ptr addrspace(3) %gep2492, align 8, !dbg !313, !tbaa !107
  %202 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload2739, <4 x half> %201, <4 x float> zeroinitializer), !dbg !314, !call_argsrelate !298
  %203 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload2746, <4 x half> %201, <4 x float> zeroinitializer), !dbg !314, !call_argsrelate !298
  %204 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload2767, <4 x half> %201, <4 x float> zeroinitializer), !dbg !314, !call_argsrelate !298
  %205 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload2774, <4 x half> %201, <4 x float> zeroinitializer), !dbg !314, !call_argsrelate !298
  br label %if.end1416, !dbg !315

if.end1416:                                       ; preds = %for.cond1360.preheader, %if.end1351
  %acc_o_2.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end1351 ], [ %205, %for.cond1360.preheader ], !dbg !85
  %acc_o_2.sroa.26.0 = phi <4 x float> [ zeroinitializer, %if.end1351 ], [ %204, %for.cond1360.preheader ], !dbg !85
  %acc_o_2.sroa.14.0 = phi <4 x float> [ zeroinitializer, %if.end1351 ], [ %203, %for.cond1360.preheader ], !dbg !85
  %acc_o_2.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1351 ], [ %202, %for.cond1360.preheader ], !dbg !85
  br i1 %or.cond2532, label %if.end1481, label %for.cond1425.preheader, !dbg !316

for.cond1425.preheader:                           ; preds = %if.end1416
  %mul1430 = shl nsw i32 %0, 16
  %206 = shl nsw i32 %cond.i.i2378.3, 10
  %mul1432 = and i32 %206, 64512
  %mul1437 = shl nuw nsw i32 %18, 3
  %add1433 = or disjoint i32 %mul1437, %mul1430
  %add1435 = add nuw nsw i32 %add1433, %mul1432
  %207 = zext nneg i32 %add1435 to i64, !dbg !317
  %add.ptr1440 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %207, !dbg !318
  %V_reg.sroa.0.0.copyload2740 = load <4 x half>, ptr addrspace(4) %add.ptr1440, align 16, !dbg !319
  %V_reg.sroa.18.0.add.ptr1440.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1440, i64 8, !dbg !319
  %V_reg.sroa.18.0.copyload2747 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr1440.sroa_idx, align 8, !dbg !319
  %208 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %207, !dbg !318
  %add.ptr1440.1 = getelementptr inbounds i8, ptr addrspace(4) %208, i64 1024, !dbg !318
  %V_reg.sroa.26.16.copyload2768 = load <4 x half>, ptr addrspace(4) %add.ptr1440.1, align 16, !dbg !319
  %V_reg.sroa.42.16.add.ptr1440.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %208, i64 1032, !dbg !319
  %V_reg.sroa.42.16.copyload2775 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr1440.1.sroa_idx, align 8, !dbg !319
  %gep2496 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 1536), i32 %mul1437, !dbg !320
  %209 = load <4 x half>, ptr addrspace(3) %gep2496, align 8, !dbg !321, !tbaa !107
  %210 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload2740, <4 x half> %209, <4 x float> zeroinitializer), !dbg !322, !call_argsrelate !298
  %211 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload2747, <4 x half> %209, <4 x float> zeroinitializer), !dbg !322, !call_argsrelate !298
  %212 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload2768, <4 x half> %209, <4 x float> zeroinitializer), !dbg !322, !call_argsrelate !298
  %213 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload2775, <4 x half> %209, <4 x float> zeroinitializer), !dbg !322, !call_argsrelate !298
  br label %if.end1481, !dbg !323

if.end1481:                                       ; preds = %for.cond1425.preheader, %if.end1416
  %acc_o_3.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end1416 ], [ %213, %for.cond1425.preheader ], !dbg !85
  %acc_o_3.sroa.26.0 = phi <4 x float> [ zeroinitializer, %if.end1416 ], [ %212, %for.cond1425.preheader ], !dbg !85
  %acc_o_3.sroa.14.0 = phi <4 x float> [ zeroinitializer, %if.end1416 ], [ %211, %for.cond1425.preheader ], !dbg !85
  %acc_o_3.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1416 ], [ %210, %for.cond1425.preheader ], !dbg !85
  br i1 %or.cond2538, label %if.end1546, label %for.cond1490.preheader, !dbg !324

for.cond1490.preheader:                           ; preds = %if.end1481
  %mul1495 = shl nsw i32 %0, 16
  %214 = shl nsw i32 %cond.i.i2378.4, 10
  %mul1497 = and i32 %214, 64512
  %mul1502 = shl nuw nsw i32 %18, 3
  %add1498 = or disjoint i32 %mul1502, %mul1495
  %add1500 = add nuw nsw i32 %add1498, %mul1497
  %215 = zext nneg i32 %add1500 to i64, !dbg !325
  %add.ptr1505 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %215, !dbg !326
  %V_reg.sroa.0.0.copyload2741 = load <4 x half>, ptr addrspace(4) %add.ptr1505, align 16, !dbg !327
  %V_reg.sroa.18.0.add.ptr1505.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1505, i64 8, !dbg !327
  %V_reg.sroa.18.0.copyload2748 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr1505.sroa_idx, align 8, !dbg !327
  %216 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %215, !dbg !326
  %add.ptr1505.1 = getelementptr inbounds i8, ptr addrspace(4) %216, i64 1024, !dbg !326
  %V_reg.sroa.26.16.copyload2769 = load <4 x half>, ptr addrspace(4) %add.ptr1505.1, align 16, !dbg !327
  %V_reg.sroa.42.16.add.ptr1505.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %216, i64 1032, !dbg !327
  %V_reg.sroa.42.16.copyload2776 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr1505.1.sroa_idx, align 8, !dbg !327
  %gep2500 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %mul1502, !dbg !328
  %217 = load <4 x half>, ptr addrspace(3) %gep2500, align 8, !dbg !329, !tbaa !107
  %218 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload2741, <4 x half> %217, <4 x float> %acc_o.sroa.0.0), !dbg !330, !call_argsrelate !298
  %219 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload2748, <4 x half> %217, <4 x float> %acc_o.sroa.38.0), !dbg !330, !call_argsrelate !298
  %220 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload2769, <4 x half> %217, <4 x float> %acc_o.sroa.74.0), !dbg !330, !call_argsrelate !298
  %221 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload2776, <4 x half> %217, <4 x float> %acc_o.sroa.110.0), !dbg !330, !call_argsrelate !298
  br label %if.end1546, !dbg !331

if.end1546:                                       ; preds = %for.cond1490.preheader, %if.end1481
  %acc_o.sroa.110.1 = phi <4 x float> [ %acc_o.sroa.110.0, %if.end1481 ], [ %221, %for.cond1490.preheader ], !dbg !85
  %acc_o.sroa.74.1 = phi <4 x float> [ %acc_o.sroa.74.0, %if.end1481 ], [ %220, %for.cond1490.preheader ], !dbg !85
  %acc_o.sroa.38.1 = phi <4 x float> [ %acc_o.sroa.38.0, %if.end1481 ], [ %219, %for.cond1490.preheader ], !dbg !85
  %acc_o.sroa.0.1 = phi <4 x float> [ %acc_o.sroa.0.0, %if.end1481 ], [ %218, %for.cond1490.preheader ], !dbg !85
  br i1 %or.cond2540, label %if.end1611, label %for.cond1555.preheader, !dbg !332

for.cond1555.preheader:                           ; preds = %if.end1546
  %mul1560 = shl nsw i32 %0, 16
  %222 = shl nsw i32 %cond.i.i2378.5, 10
  %mul1562 = and i32 %222, 64512
  %mul1567 = shl nuw nsw i32 %18, 3
  %add1563 = or disjoint i32 %mul1567, %mul1560
  %add1565 = add nuw nsw i32 %add1563, %mul1562
  %223 = zext nneg i32 %add1565 to i64, !dbg !333
  %add.ptr1570 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %223, !dbg !334
  %V_reg.sroa.0.0.copyload2742 = load <4 x half>, ptr addrspace(4) %add.ptr1570, align 16, !dbg !335
  %V_reg.sroa.18.0.add.ptr1570.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1570, i64 8, !dbg !335
  %V_reg.sroa.18.0.copyload2749 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr1570.sroa_idx, align 8, !dbg !335
  %224 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %223, !dbg !334
  %add.ptr1570.1 = getelementptr inbounds i8, ptr addrspace(4) %224, i64 1024, !dbg !334
  %V_reg.sroa.26.16.copyload2770 = load <4 x half>, ptr addrspace(4) %add.ptr1570.1, align 16, !dbg !335
  %V_reg.sroa.42.16.add.ptr1570.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %224, i64 1032, !dbg !335
  %V_reg.sroa.42.16.copyload2777 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr1570.1.sroa_idx, align 8, !dbg !335
  %gep2504 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2560), i32 %mul1567, !dbg !336
  %225 = load <4 x half>, ptr addrspace(3) %gep2504, align 8, !dbg !337, !tbaa !107
  %226 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload2742, <4 x half> %225, <4 x float> %acc_o_1.sroa.0.0), !dbg !338, !call_argsrelate !298
  %227 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload2749, <4 x half> %225, <4 x float> %acc_o_1.sroa.14.0), !dbg !338, !call_argsrelate !298
  %228 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload2770, <4 x half> %225, <4 x float> %acc_o_1.sroa.26.0), !dbg !338, !call_argsrelate !298
  %229 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload2777, <4 x half> %225, <4 x float> %acc_o_1.sroa.38.0), !dbg !338, !call_argsrelate !298
  br label %if.end1611, !dbg !339

if.end1611:                                       ; preds = %for.cond1555.preheader, %if.end1546
  %acc_o_1.sroa.38.1 = phi <4 x float> [ %acc_o_1.sroa.38.0, %if.end1546 ], [ %229, %for.cond1555.preheader ], !dbg !85
  %acc_o_1.sroa.26.1 = phi <4 x float> [ %acc_o_1.sroa.26.0, %if.end1546 ], [ %228, %for.cond1555.preheader ], !dbg !85
  %acc_o_1.sroa.14.1 = phi <4 x float> [ %acc_o_1.sroa.14.0, %if.end1546 ], [ %227, %for.cond1555.preheader ], !dbg !85
  %acc_o_1.sroa.0.1 = phi <4 x float> [ %acc_o_1.sroa.0.0, %if.end1546 ], [ %226, %for.cond1555.preheader ], !dbg !85
  br i1 %or.cond2542, label %if.end1676, label %for.cond1620.preheader, !dbg !340

for.cond1620.preheader:                           ; preds = %if.end1611
  %mul1625 = shl nsw i32 %0, 16
  %230 = shl nsw i32 %cond.i.i2378.6, 10
  %mul1627 = and i32 %230, 64512
  %mul1632 = shl nuw nsw i32 %18, 3
  %add1628 = or disjoint i32 %mul1632, %mul1625
  %add1630 = add nuw nsw i32 %add1628, %mul1627
  %231 = zext nneg i32 %add1630 to i64, !dbg !341
  %add.ptr1635 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %231, !dbg !342
  %V_reg.sroa.0.0.copyload2743 = load <4 x half>, ptr addrspace(4) %add.ptr1635, align 16, !dbg !343
  %V_reg.sroa.18.0.add.ptr1635.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1635, i64 8, !dbg !343
  %V_reg.sroa.18.0.copyload2750 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr1635.sroa_idx, align 8, !dbg !343
  %232 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %231, !dbg !342
  %add.ptr1635.1 = getelementptr inbounds i8, ptr addrspace(4) %232, i64 1024, !dbg !342
  %V_reg.sroa.26.16.copyload2771 = load <4 x half>, ptr addrspace(4) %add.ptr1635.1, align 16, !dbg !343
  %V_reg.sroa.42.16.add.ptr1635.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %232, i64 1032, !dbg !343
  %V_reg.sroa.42.16.copyload2778 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr1635.1.sroa_idx, align 8, !dbg !343
  %gep2508 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 3072), i32 %mul1632, !dbg !344
  %233 = load <4 x half>, ptr addrspace(3) %gep2508, align 8, !dbg !345, !tbaa !107
  %234 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload2743, <4 x half> %233, <4 x float> %acc_o_2.sroa.0.0), !dbg !346, !call_argsrelate !298
  %235 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload2750, <4 x half> %233, <4 x float> %acc_o_2.sroa.14.0), !dbg !346, !call_argsrelate !298
  %236 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload2771, <4 x half> %233, <4 x float> %acc_o_2.sroa.26.0), !dbg !346, !call_argsrelate !298
  %237 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload2778, <4 x half> %233, <4 x float> %acc_o_2.sroa.38.0), !dbg !346, !call_argsrelate !298
  br label %if.end1676, !dbg !347

if.end1676:                                       ; preds = %for.cond1620.preheader, %if.end1611
  %acc_o_2.sroa.38.1 = phi <4 x float> [ %acc_o_2.sroa.38.0, %if.end1611 ], [ %237, %for.cond1620.preheader ], !dbg !85
  %acc_o_2.sroa.26.1 = phi <4 x float> [ %acc_o_2.sroa.26.0, %if.end1611 ], [ %236, %for.cond1620.preheader ], !dbg !85
  %acc_o_2.sroa.14.1 = phi <4 x float> [ %acc_o_2.sroa.14.0, %if.end1611 ], [ %235, %for.cond1620.preheader ], !dbg !85
  %acc_o_2.sroa.0.1 = phi <4 x float> [ %acc_o_2.sroa.0.0, %if.end1611 ], [ %234, %for.cond1620.preheader ], !dbg !85
  br i1 %or.cond2544, label %if.end1676.if.end1741_crit_edge, label %for.cond1685.preheader, !dbg !348

if.end1676.if.end1741_crit_edge:                  ; preds = %if.end1676
  %.pre = shl nuw nsw i32 %18, 3
  br label %if.end1741, !dbg !348

for.cond1685.preheader:                           ; preds = %if.end1676
  %mul1690 = shl nsw i32 %0, 16
  %238 = shl nsw i32 %cond.i.i2378.7, 10
  %mul1692 = and i32 %238, 64512
  %mul1697 = shl nuw nsw i32 %18, 3
  %add1693 = or disjoint i32 %mul1697, %mul1690
  %add1695 = add nuw nsw i32 %add1693, %mul1692
  %239 = zext nneg i32 %add1695 to i64, !dbg !349
  %add.ptr1700 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %239, !dbg !350
  %V_reg.sroa.0.0.copyload2744 = load <4 x half>, ptr addrspace(4) %add.ptr1700, align 16, !dbg !351
  %V_reg.sroa.18.0.add.ptr1700.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1700, i64 8, !dbg !351
  %V_reg.sroa.18.0.copyload2751 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr1700.sroa_idx, align 8, !dbg !351
  %240 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %239, !dbg !350
  %add.ptr1700.1 = getelementptr inbounds i8, ptr addrspace(4) %240, i64 1024, !dbg !350
  %V_reg.sroa.26.16.copyload2772 = load <4 x half>, ptr addrspace(4) %add.ptr1700.1, align 16, !dbg !351
  %V_reg.sroa.42.16.add.ptr1700.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %240, i64 1032, !dbg !351
  %V_reg.sroa.42.16.copyload2779 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr1700.1.sroa_idx, align 8, !dbg !351
  %gep2512 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 3584), i32 %mul1697, !dbg !352
  %241 = load <4 x half>, ptr addrspace(3) %gep2512, align 8, !dbg !353, !tbaa !107
  %242 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload2744, <4 x half> %241, <4 x float> %acc_o_3.sroa.0.0), !dbg !354, !call_argsrelate !298
  %243 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload2751, <4 x half> %241, <4 x float> %acc_o_3.sroa.14.0), !dbg !354, !call_argsrelate !298
  %244 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload2772, <4 x half> %241, <4 x float> %acc_o_3.sroa.26.0), !dbg !354, !call_argsrelate !298
  %245 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload2779, <4 x half> %241, <4 x float> %acc_o_3.sroa.38.0), !dbg !354, !call_argsrelate !298
  br label %if.end1741, !dbg !355

if.end1741:                                       ; preds = %if.end1676.if.end1741_crit_edge, %for.cond1685.preheader
  %.pre-phi = phi i32 [ %.pre, %if.end1676.if.end1741_crit_edge ], [ %mul1697, %for.cond1685.preheader ]
  %acc_o_3.sroa.38.1 = phi <4 x float> [ %acc_o_3.sroa.38.0, %if.end1676.if.end1741_crit_edge ], [ %245, %for.cond1685.preheader ], !dbg !85
  %acc_o_3.sroa.26.1 = phi <4 x float> [ %acc_o_3.sroa.26.0, %if.end1676.if.end1741_crit_edge ], [ %244, %for.cond1685.preheader ], !dbg !85
  %acc_o_3.sroa.14.1 = phi <4 x float> [ %acc_o_3.sroa.14.0, %if.end1676.if.end1741_crit_edge ], [ %243, %for.cond1685.preheader ], !dbg !85
  %acc_o_3.sroa.0.1 = phi <4 x float> [ %acc_o_3.sroa.0.0, %if.end1676.if.end1741_crit_edge ], [ %242, %for.cond1685.preheader ], !dbg !85
  fence syncscope("warp") release, !dbg !355
  tail call void @llvm.mxc.barrier.warp(), !dbg !358
  fence syncscope("warp") acquire, !dbg !359
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 0, !dbg !360
  %acc_o_1.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_1.sroa.0.1, i64 0, !dbg !361
  %add1750 = fadd contract float %acc_o.sroa.0.0.vec.extract, %acc_o_1.sroa.0.0.vec.extract, !dbg !362
  %acc_o_2.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_2.sroa.0.1, i64 0, !dbg !363
  %add1757 = fadd contract float %add1750, %acc_o_2.sroa.0.0.vec.extract, !dbg !364
  %acc_o_3.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_3.sroa.0.1, i64 0, !dbg !365
  %add1764 = fadd contract float %add1757, %acc_o_3.sroa.0.0.vec.extract, !dbg !366
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 1, !dbg !360
  %acc_o_1.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_1.sroa.0.1, i64 1, !dbg !361
  %add1750.1 = fadd contract float %acc_o.sroa.0.4.vec.extract, %acc_o_1.sroa.0.4.vec.extract, !dbg !362
  %acc_o_2.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_2.sroa.0.1, i64 1, !dbg !363
  %add1757.1 = fadd contract float %add1750.1, %acc_o_2.sroa.0.4.vec.extract, !dbg !364
  %acc_o_3.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_3.sroa.0.1, i64 1, !dbg !365
  %add1764.1 = fadd contract float %add1757.1, %acc_o_3.sroa.0.4.vec.extract, !dbg !366
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 2, !dbg !360
  %acc_o_1.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_1.sroa.0.1, i64 2, !dbg !361
  %add1750.2 = fadd contract float %acc_o.sroa.0.8.vec.extract, %acc_o_1.sroa.0.8.vec.extract, !dbg !362
  %acc_o_2.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_2.sroa.0.1, i64 2, !dbg !363
  %add1757.2 = fadd contract float %add1750.2, %acc_o_2.sroa.0.8.vec.extract, !dbg !364
  %acc_o_3.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_3.sroa.0.1, i64 2, !dbg !365
  %add1764.2 = fadd contract float %add1757.2, %acc_o_3.sroa.0.8.vec.extract, !dbg !366
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 3, !dbg !360
  %acc_o_1.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_1.sroa.0.1, i64 3, !dbg !361
  %add1750.3 = fadd contract float %acc_o.sroa.0.12.vec.extract, %acc_o_1.sroa.0.12.vec.extract, !dbg !362
  %acc_o_2.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_2.sroa.0.1, i64 3, !dbg !363
  %add1757.3 = fadd contract float %add1750.3, %acc_o_2.sroa.0.12.vec.extract, !dbg !364
  %acc_o_3.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_3.sroa.0.1, i64 3, !dbg !365
  %add1764.3 = fadd contract float %add1757.3, %acc_o_3.sroa.0.12.vec.extract, !dbg !366
  %acc_o.sroa.38.16.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1, i64 0, !dbg !360
  %acc_o_1.sroa.14.16.vec.extract = extractelement <4 x float> %acc_o_1.sroa.14.1, i64 0, !dbg !361
  %add1750.4 = fadd contract float %acc_o.sroa.38.16.vec.extract, %acc_o_1.sroa.14.16.vec.extract, !dbg !362
  %acc_o_2.sroa.14.16.vec.extract = extractelement <4 x float> %acc_o_2.sroa.14.1, i64 0, !dbg !363
  %add1757.4 = fadd contract float %add1750.4, %acc_o_2.sroa.14.16.vec.extract, !dbg !364
  %acc_o_3.sroa.14.16.vec.extract = extractelement <4 x float> %acc_o_3.sroa.14.1, i64 0, !dbg !365
  %add1764.4 = fadd contract float %add1757.4, %acc_o_3.sroa.14.16.vec.extract, !dbg !366
  %acc_o.sroa.38.20.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1, i64 1, !dbg !360
  %acc_o_1.sroa.14.20.vec.extract = extractelement <4 x float> %acc_o_1.sroa.14.1, i64 1, !dbg !361
  %add1750.5 = fadd contract float %acc_o.sroa.38.20.vec.extract, %acc_o_1.sroa.14.20.vec.extract, !dbg !362
  %acc_o_2.sroa.14.20.vec.extract = extractelement <4 x float> %acc_o_2.sroa.14.1, i64 1, !dbg !363
  %add1757.5 = fadd contract float %add1750.5, %acc_o_2.sroa.14.20.vec.extract, !dbg !364
  %acc_o_3.sroa.14.20.vec.extract = extractelement <4 x float> %acc_o_3.sroa.14.1, i64 1, !dbg !365
  %add1764.5 = fadd contract float %add1757.5, %acc_o_3.sroa.14.20.vec.extract, !dbg !366
  %acc_o.sroa.38.24.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1, i64 2, !dbg !360
  %acc_o_1.sroa.14.24.vec.extract = extractelement <4 x float> %acc_o_1.sroa.14.1, i64 2, !dbg !361
  %add1750.6 = fadd contract float %acc_o.sroa.38.24.vec.extract, %acc_o_1.sroa.14.24.vec.extract, !dbg !362
  %acc_o_2.sroa.14.24.vec.extract = extractelement <4 x float> %acc_o_2.sroa.14.1, i64 2, !dbg !363
  %add1757.6 = fadd contract float %add1750.6, %acc_o_2.sroa.14.24.vec.extract, !dbg !364
  %acc_o_3.sroa.14.24.vec.extract = extractelement <4 x float> %acc_o_3.sroa.14.1, i64 2, !dbg !365
  %add1764.6 = fadd contract float %add1757.6, %acc_o_3.sroa.14.24.vec.extract, !dbg !366
  %acc_o.sroa.38.28.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1, i64 3, !dbg !360
  %acc_o_1.sroa.14.28.vec.extract = extractelement <4 x float> %acc_o_1.sroa.14.1, i64 3, !dbg !361
  %add1750.7 = fadd contract float %acc_o.sroa.38.28.vec.extract, %acc_o_1.sroa.14.28.vec.extract, !dbg !362
  %acc_o_2.sroa.14.28.vec.extract = extractelement <4 x float> %acc_o_2.sroa.14.1, i64 3, !dbg !363
  %add1757.7 = fadd contract float %add1750.7, %acc_o_2.sroa.14.28.vec.extract, !dbg !364
  %acc_o_3.sroa.14.28.vec.extract = extractelement <4 x float> %acc_o_3.sroa.14.1, i64 3, !dbg !365
  %add1764.7 = fadd contract float %add1757.7, %acc_o_3.sroa.14.28.vec.extract, !dbg !366
  %acc_o.sroa.74.32.vec.extract = extractelement <4 x float> %acc_o.sroa.74.1, i64 0, !dbg !360
  %acc_o_1.sroa.26.32.vec.extract = extractelement <4 x float> %acc_o_1.sroa.26.1, i64 0, !dbg !361
  %add1750.8 = fadd contract float %acc_o.sroa.74.32.vec.extract, %acc_o_1.sroa.26.32.vec.extract, !dbg !362
  %acc_o_2.sroa.26.32.vec.extract = extractelement <4 x float> %acc_o_2.sroa.26.1, i64 0, !dbg !363
  %add1757.8 = fadd contract float %add1750.8, %acc_o_2.sroa.26.32.vec.extract, !dbg !364
  %acc_o_3.sroa.26.32.vec.extract = extractelement <4 x float> %acc_o_3.sroa.26.1, i64 0, !dbg !365
  %add1764.8 = fadd contract float %add1757.8, %acc_o_3.sroa.26.32.vec.extract, !dbg !366
  %acc_o.sroa.74.36.vec.extract = extractelement <4 x float> %acc_o.sroa.74.1, i64 1, !dbg !360
  %acc_o_1.sroa.26.36.vec.extract = extractelement <4 x float> %acc_o_1.sroa.26.1, i64 1, !dbg !361
  %add1750.9 = fadd contract float %acc_o.sroa.74.36.vec.extract, %acc_o_1.sroa.26.36.vec.extract, !dbg !362
  %acc_o_2.sroa.26.36.vec.extract = extractelement <4 x float> %acc_o_2.sroa.26.1, i64 1, !dbg !363
  %add1757.9 = fadd contract float %add1750.9, %acc_o_2.sroa.26.36.vec.extract, !dbg !364
  %acc_o_3.sroa.26.36.vec.extract = extractelement <4 x float> %acc_o_3.sroa.26.1, i64 1, !dbg !365
  %add1764.9 = fadd contract float %add1757.9, %acc_o_3.sroa.26.36.vec.extract, !dbg !366
  %acc_o.sroa.74.40.vec.extract = extractelement <4 x float> %acc_o.sroa.74.1, i64 2, !dbg !360
  %acc_o_1.sroa.26.40.vec.extract = extractelement <4 x float> %acc_o_1.sroa.26.1, i64 2, !dbg !361
  %add1750.10 = fadd contract float %acc_o.sroa.74.40.vec.extract, %acc_o_1.sroa.26.40.vec.extract, !dbg !362
  %acc_o_2.sroa.26.40.vec.extract = extractelement <4 x float> %acc_o_2.sroa.26.1, i64 2, !dbg !363
  %add1757.10 = fadd contract float %add1750.10, %acc_o_2.sroa.26.40.vec.extract, !dbg !364
  %acc_o_3.sroa.26.40.vec.extract = extractelement <4 x float> %acc_o_3.sroa.26.1, i64 2, !dbg !365
  %add1764.10 = fadd contract float %add1757.10, %acc_o_3.sroa.26.40.vec.extract, !dbg !366
  %acc_o.sroa.74.44.vec.extract = extractelement <4 x float> %acc_o.sroa.74.1, i64 3, !dbg !360
  %acc_o_1.sroa.26.44.vec.extract = extractelement <4 x float> %acc_o_1.sroa.26.1, i64 3, !dbg !361
  %add1750.11 = fadd contract float %acc_o.sroa.74.44.vec.extract, %acc_o_1.sroa.26.44.vec.extract, !dbg !362
  %acc_o_2.sroa.26.44.vec.extract = extractelement <4 x float> %acc_o_2.sroa.26.1, i64 3, !dbg !363
  %add1757.11 = fadd contract float %add1750.11, %acc_o_2.sroa.26.44.vec.extract, !dbg !364
  %acc_o_3.sroa.26.44.vec.extract = extractelement <4 x float> %acc_o_3.sroa.26.1, i64 3, !dbg !365
  %add1764.11 = fadd contract float %add1757.11, %acc_o_3.sroa.26.44.vec.extract, !dbg !366
  %acc_o.sroa.110.48.vec.extract = extractelement <4 x float> %acc_o.sroa.110.1, i64 0, !dbg !360
  %acc_o_1.sroa.38.48.vec.extract = extractelement <4 x float> %acc_o_1.sroa.38.1, i64 0, !dbg !361
  %add1750.12 = fadd contract float %acc_o.sroa.110.48.vec.extract, %acc_o_1.sroa.38.48.vec.extract, !dbg !362
  %acc_o_2.sroa.38.48.vec.extract = extractelement <4 x float> %acc_o_2.sroa.38.1, i64 0, !dbg !363
  %add1757.12 = fadd contract float %add1750.12, %acc_o_2.sroa.38.48.vec.extract, !dbg !364
  %acc_o_3.sroa.38.48.vec.extract = extractelement <4 x float> %acc_o_3.sroa.38.1, i64 0, !dbg !365
  %add1764.12 = fadd contract float %add1757.12, %acc_o_3.sroa.38.48.vec.extract, !dbg !366
  %acc_o.sroa.110.52.vec.extract = extractelement <4 x float> %acc_o.sroa.110.1, i64 1, !dbg !360
  %acc_o_1.sroa.38.52.vec.extract = extractelement <4 x float> %acc_o_1.sroa.38.1, i64 1, !dbg !361
  %add1750.13 = fadd contract float %acc_o.sroa.110.52.vec.extract, %acc_o_1.sroa.38.52.vec.extract, !dbg !362
  %acc_o_2.sroa.38.52.vec.extract = extractelement <4 x float> %acc_o_2.sroa.38.1, i64 1, !dbg !363
  %add1757.13 = fadd contract float %add1750.13, %acc_o_2.sroa.38.52.vec.extract, !dbg !364
  %acc_o_3.sroa.38.52.vec.extract = extractelement <4 x float> %acc_o_3.sroa.38.1, i64 1, !dbg !365
  %add1764.13 = fadd contract float %add1757.13, %acc_o_3.sroa.38.52.vec.extract, !dbg !366
  %acc_o.sroa.110.56.vec.extract = extractelement <4 x float> %acc_o.sroa.110.1, i64 2, !dbg !360
  %acc_o_1.sroa.38.56.vec.extract = extractelement <4 x float> %acc_o_1.sroa.38.1, i64 2, !dbg !361
  %add1750.14 = fadd contract float %acc_o.sroa.110.56.vec.extract, %acc_o_1.sroa.38.56.vec.extract, !dbg !362
  %acc_o_2.sroa.38.56.vec.extract = extractelement <4 x float> %acc_o_2.sroa.38.1, i64 2, !dbg !363
  %add1757.14 = fadd contract float %add1750.14, %acc_o_2.sroa.38.56.vec.extract, !dbg !364
  %acc_o_3.sroa.38.56.vec.extract = extractelement <4 x float> %acc_o_3.sroa.38.1, i64 2, !dbg !365
  %add1764.14 = fadd contract float %add1757.14, %acc_o_3.sroa.38.56.vec.extract, !dbg !366
  %acc_o.sroa.110.60.vec.extract = extractelement <4 x float> %acc_o.sroa.110.1, i64 3, !dbg !360
  %acc_o_1.sroa.38.60.vec.extract = extractelement <4 x float> %acc_o_1.sroa.38.1, i64 3, !dbg !361
  %add1750.15 = fadd contract float %acc_o.sroa.110.60.vec.extract, %acc_o_1.sroa.38.60.vec.extract, !dbg !362
  %acc_o_2.sroa.38.60.vec.extract = extractelement <4 x float> %acc_o_2.sroa.38.1, i64 3, !dbg !363
  %add1757.15 = fadd contract float %add1750.15, %acc_o_2.sroa.38.60.vec.extract, !dbg !364
  %acc_o_3.sroa.38.60.vec.extract = extractelement <4 x float> %acc_o_3.sroa.38.1, i64 3, !dbg !365
  %add1764.15 = fadd contract float %add1757.15, %acc_o_3.sroa.38.60.vec.extract, !dbg !366
  %add1778 = fadd contract float %sum_acc.sroa.0.7, 0.000000e+00, !dbg !367
  %add1778.1 = fadd contract float %add1778, %sum_acc.sroa.20.7, !dbg !367
  %add1778.2 = fadd contract float %add1778.1, %sum_acc.sroa.38.7, !dbg !367
  %add1778.3 = fadd contract float %add1778.2, %sum_acc.sroa.56.7, !dbg !367
  %246 = bitcast float %add1778.3 to i32, !dbg !368
  %247 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !379
  %248 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %247) #11, !dbg !384
  %xor.i.i = xor i32 %248, 32, !dbg !385
  %249 = and i32 %248, -64, !dbg !386
  %and.i.i = add nsw i32 %249, 64, !dbg !386
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !387
  %cond.i.i2379 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %248, !dbg !388
  %shl.i.i = shl i32 %cond.i.i2379, 2, !dbg !389
  %250 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %246), !dbg !390
  %251 = bitcast i32 %250 to float, !dbg !391
  %add.i = fadd contract float %add1778.3, %251, !dbg !392
  %252 = bitcast float %add.i to i32, !dbg !395
  %253 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !402
  %254 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %253) #11, !dbg !405
  %xor.i.i2380 = xor i32 %254, 16, !dbg !406
  %255 = and i32 %254, -64, !dbg !407
  %and.i.i2381 = add nsw i32 %255, 64, !dbg !407
  %cmp.not.i.i2382 = icmp slt i32 %xor.i.i2380, %and.i.i2381, !dbg !408
  %cond.i.i2383 = select i1 %cmp.not.i.i2382, i32 %xor.i.i2380, i32 %254, !dbg !409
  %shl.i.i2384 = shl i32 %cond.i.i2383, 2, !dbg !410
  %256 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i2384, i32 %252), !dbg !411
  %257 = bitcast i32 %256 to float, !dbg !412
  %add.i.i = fadd contract float %add.i, %257, !dbg !413
  %cmp1787 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !415
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !416
  %condval_8.0 = select i1 %cmp1787, float %div, float 0.000000e+00, !dbg !416
  %mul1800 = fmul contract float %condval_8.0, %add1764, !dbg !417
  %mul1800.1 = fmul contract float %condval_8.0, %add1764.1, !dbg !417
  %mul1800.2 = fmul contract float %condval_8.0, %add1764.2, !dbg !417
  %mul1800.3 = fmul contract float %condval_8.0, %add1764.3, !dbg !417
  %mul1800.4 = fmul contract float %condval_8.0, %add1764.4, !dbg !417
  %mul1800.5 = fmul contract float %condval_8.0, %add1764.5, !dbg !417
  %mul1800.6 = fmul contract float %condval_8.0, %add1764.6, !dbg !417
  %mul1800.7 = fmul contract float %condval_8.0, %add1764.7, !dbg !417
  %mul1800.8 = fmul contract float %condval_8.0, %add1764.8, !dbg !417
  %mul1800.9 = fmul contract float %condval_8.0, %add1764.9, !dbg !417
  %mul1800.10 = fmul contract float %condval_8.0, %add1764.10, !dbg !417
  %mul1800.11 = fmul contract float %condval_8.0, %add1764.11, !dbg !417
  %mul1800.12 = fmul contract float %condval_8.0, %add1764.12, !dbg !417
  %mul1800.13 = fmul contract float %condval_8.0, %add1764.13, !dbg !417
  %mul1800.14 = fmul contract float %condval_8.0, %add1764.14, !dbg !417
  %mul1800.15 = fmul contract float %condval_8.0, %add1764.15, !dbg !417
  %258 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1800), !dbg !418
  %O_reg.sroa.0.0.insert.ext = zext i16 %258 to i64, !dbg !422
  %259 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1800.1), !dbg !418
  %O_reg.sroa.0.2.insert.ext = zext i16 %259 to i64, !dbg !422
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !422
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !422
  %260 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1800.2), !dbg !418
  %O_reg.sroa.0.4.insert.ext = zext i16 %260 to i64, !dbg !422
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !422
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !422
  %261 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1800.3), !dbg !418
  %O_reg.sroa.0.6.insert.ext = zext i16 %261 to i64, !dbg !422
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !422
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !422
  %262 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1800.4), !dbg !418
  %O_reg.sroa.7.8.insert.ext = zext i16 %262 to i64, !dbg !422
  %263 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1800.5), !dbg !418
  %O_reg.sroa.7.10.insert.ext = zext i16 %263 to i64, !dbg !422
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !422
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !422
  %264 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1800.6), !dbg !418
  %O_reg.sroa.7.12.insert.ext = zext i16 %264 to i64, !dbg !422
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !422
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !422
  %265 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1800.7), !dbg !418
  %O_reg.sroa.7.14.insert.ext = zext i16 %265 to i64, !dbg !422
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !422
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !422
  %266 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1800.8), !dbg !418
  %O_reg.sroa.12.16.insert.ext = zext i16 %266 to i64, !dbg !422
  %267 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1800.9), !dbg !418
  %O_reg.sroa.12.18.insert.ext = zext i16 %267 to i64, !dbg !422
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !422
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !422
  %268 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1800.10), !dbg !418
  %O_reg.sroa.12.20.insert.ext = zext i16 %268 to i64, !dbg !422
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !422
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !422
  %269 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1800.11), !dbg !418
  %O_reg.sroa.12.22.insert.ext = zext i16 %269 to i64, !dbg !422
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !422
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !422
  %270 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1800.12), !dbg !418
  %O_reg.sroa.17.24.insert.ext = zext i16 %270 to i64, !dbg !422
  %271 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1800.13), !dbg !418
  %O_reg.sroa.17.26.insert.ext = zext i16 %271 to i64, !dbg !422
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !422
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !422
  %272 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1800.14), !dbg !418
  %O_reg.sroa.17.28.insert.ext = zext i16 %272 to i64, !dbg !422
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !422
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !422
  %273 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1800.15), !dbg !418
  %O_reg.sroa.17.30.insert.ext = zext i16 %273 to i64, !dbg !422
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !422
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !422
  %shr1842 = lshr i32 %18, 5
  %and1845 = and i32 %18, 7
  %274 = lshr i32 %18, 2
  %mul1851 = and i32 %274, 4
  %xor = xor i32 %shr1842, %and1845, !dbg !423
  %mul1846 = shl nuw nsw i32 %xor, 3, !dbg !424
  %add1847 = add nuw nsw i32 %mul1846, %mul25, !dbg !425
  %add1852 = or disjoint i32 %add1847, %mul1851, !dbg !426
  %add.ptr1854 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1852, !dbg !427
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr1854, align 8, !dbg !428
  %add1843.1 = add nuw nsw i32 %shr1842, 2, !dbg !429
  %xor.1 = xor i32 %add1843.1, %and1845, !dbg !423
  %mul1846.1 = shl nuw nsw i32 %xor.1, 3, !dbg !424
  %add1847.1 = add nuw nsw i32 %mul1846.1, %mul25, !dbg !425
  %add1852.1 = or disjoint i32 %add1847.1, %mul1851, !dbg !426
  %add.ptr1854.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1852.1, !dbg !427
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr1854.1, align 8, !dbg !428
  %add1843.2 = add nuw nsw i32 %shr1842, 4, !dbg !429
  %xor.2 = xor i32 %add1843.2, %and1845, !dbg !423
  %mul1846.2 = shl nuw nsw i32 %xor.2, 3, !dbg !424
  %add1847.2 = add nuw nsw i32 %mul1846.2, %mul25, !dbg !425
  %add1852.2 = or disjoint i32 %add1847.2, %mul1851, !dbg !426
  %add.ptr1854.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1852.2, !dbg !427
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr1854.2, align 8, !dbg !428
  %add1843.3 = add nuw nsw i32 %shr1842, 6, !dbg !429
  %xor.3 = xor i32 %add1843.3, %and1845, !dbg !423
  %mul1846.3 = shl nuw nsw i32 %xor.3, 3, !dbg !424
  %add1847.3 = add nuw nsw i32 %mul1846.3, %mul25, !dbg !425
  %add1852.3 = or disjoint i32 %add1847.3, %mul1851, !dbg !426
  %add.ptr1854.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1852.3, !dbg !427
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr1854.3, align 8, !dbg !428
  fence syncscope("warp") release, !dbg !430
  tail call void @llvm.mxc.barrier.warp(), !dbg !433
  fence syncscope("warp") acquire, !dbg !434
  %mul1865 = and i32 %.pre-phi, 8128
  %xor18712361 = and i32 %.pre-phi, 56
  %call1869.masked = and i32 %18, 1016
  %mul1872 = xor i32 %xor18712361, %call1869.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul1865, !dbg !435
  %invariant.gep2523 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul1872, !dbg !435
  %add1882 = add nuw nsw i32 %add23, %.pre-phi
  %275 = zext nneg i32 %add1882 to i64, !dbg !436
  %add.ptr1887 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %275, !dbg !437
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1887, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep2523, i64 16, i1 false), !dbg !438, !tbaa.struct !439, !call_argsrelate !440
  %gep2524.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep2523, i32 1024, !dbg !441
  %276 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %275, !dbg !437
  %add.ptr1887.1 = getelementptr inbounds i8, ptr addrspace(1) %276, i64 1024, !dbg !437
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1887.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep2524.1, i64 16, i1 false), !dbg !438, !tbaa.struct !439, !call_argsrelate !440
  ret void, !dbg !442
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
!1 = !DIFile(filename: "/tmp/tmpssciq6h3/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpssciq6h3/tvm_kernels.maca", directory: "")
!42 = !DILocation(line: 30, column: 3, scope: !40)
!43 = !DILocation(line: 31, column: 21, scope: !40)
!44 = !DILocation(line: 705, column: 10, scope: !45, inlinedAt: !47)
!45 = distinct !DISubprogram(name: "max", scope: !46, file: !46, line: 704, type: !7, scopeLine: 704, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!46 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!47 = distinct !DILocation(line: 32, column: 24, scope: !40)
!48 = !{i32 0, i32 -1}
!49 = !DILocation(line: 708, column: 10, scope: !50, inlinedAt: !51)
!50 = distinct !DISubprogram(name: "min", scope: !46, file: !46, line: 707, type: !7, scopeLine: 707, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!51 = distinct !DILocation(line: 32, column: 20, scope: !40)
!52 = !DILocation(line: 32, column: 48, scope: !40)
!53 = !DILocation(line: 31, column: 90, scope: !40)
!54 = !{i32 0, i32 1024}
!55 = !DILocation(line: 35, column: 3, scope: !40)
!56 = !DILocation(line: 36, column: 46, scope: !40)
!57 = !DILocation(line: 36, column: 32, scope: !40)
!58 = !DILocation(line: 42, column: 33, scope: !40)
!59 = !DILocation(line: 44, column: 5, scope: !40)
!60 = !DILocation(line: 45, column: 50, scope: !40)
!61 = !DILocation(line: 45, column: 36, scope: !40)
!62 = !DILocation(line: 48, column: 27, scope: !40)
!63 = !DILocation(line: 49, column: 33, scope: !40)
!64 = !DILocation(line: 51, column: 5, scope: !40)
!65 = !DILocation(line: 52, column: 51, scope: !40)
!66 = !DILocation(line: 52, column: 37, scope: !40)
!67 = !DILocation(line: 55, column: 27, scope: !40)
!68 = !DILocation(line: 56, column: 33, scope: !40)
!69 = !DILocation(line: 58, column: 5, scope: !40)
!70 = !DILocation(line: 59, column: 51, scope: !40)
!71 = !DILocation(line: 59, column: 37, scope: !40)
!72 = !DILocation(line: 62, column: 27, scope: !40)
!73 = !DILocation(line: 63, column: 33, scope: !40)
!74 = !DILocation(line: 65, column: 5, scope: !40)
!75 = !DILocation(line: 66, column: 51, scope: !40)
!76 = !DILocation(line: 66, column: 37, scope: !40)
!77 = !DILocation(line: 69, column: 33, scope: !40)
!78 = !DILocation(line: 69, column: 7, scope: !40)
!79 = !DILocation(line: 70, column: 48, scope: !40)
!80 = !DILocation(line: 70, column: 27, scope: !40)
!81 = !DILocation(line: 70, column: 9, scope: !40)
!82 = !DILocation(line: 74, column: 76, scope: !40)
!83 = !DILocation(line: 79, column: 20, scope: !40)
!84 = !DILocation(line: 74, column: 69, scope: !40)
!85 = !DILocation(line: 0, scope: !40)
!86 = !DILocation(line: 88, column: 36, scope: !40)
!87 = !{i32 -1, i32 3, i32 -1}
!88 = !DILocation(line: 96, column: 30, scope: !40)
!89 = !DILocation(line: 96, column: 41, scope: !40)
!90 = !DILocation(line: 354, column: 10, scope: !91, inlinedAt: !92)
!91 = distinct !DISubprogram(name: "min", scope: !46, file: !46, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!92 = distinct !DILocation(line: 96, column: 25, scope: !40)
!93 = !DILocation(line: 288, column: 10, scope: !94, inlinedAt: !95)
!94 = distinct !DISubprogram(name: "expf", scope: !46, file: !46, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!95 = distinct !DILocation(line: 96, column: 20, scope: !40)
!96 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !99)
!97 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !98, file: !98, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!98 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!99 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !102)
!100 = distinct !DISubprogram(name: "__float2half", scope: !101, file: !101, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!101 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!102 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !104)
!103 = distinct !DISubprogram(name: "__half", scope: !101, file: !101, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!104 = distinct !DILocation(line: 104, column: 76, scope: !40)
!105 = !DILocation(line: 104, column: 7, scope: !40)
!106 = !DILocation(line: 104, column: 73, scope: !40)
!107 = !{!26, !26, i64 0}
!108 = !DILocation(line: 107, column: 33, scope: !40)
!109 = !DILocation(line: 107, column: 7, scope: !40)
!110 = !DILocation(line: 108, column: 48, scope: !40)
!111 = !DILocation(line: 108, column: 27, scope: !40)
!112 = !DILocation(line: 108, column: 9, scope: !40)
!113 = !DILocation(line: 112, column: 76, scope: !40)
!114 = !DILocation(line: 117, column: 20, scope: !40)
!115 = !DILocation(line: 112, column: 69, scope: !40)
!116 = !DILocation(line: 126, column: 36, scope: !40)
!117 = !DILocation(line: 134, column: 30, scope: !40)
!118 = !DILocation(line: 134, column: 41, scope: !40)
!119 = !DILocation(line: 354, column: 10, scope: !91, inlinedAt: !120)
!120 = distinct !DILocation(line: 134, column: 25, scope: !40)
!121 = !DILocation(line: 288, column: 10, scope: !94, inlinedAt: !122)
!122 = distinct !DILocation(line: 134, column: 20, scope: !40)
!123 = !DILocation(line: 138, column: 38, scope: !40)
!124 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !125)
!125 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !126)
!126 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !127)
!127 = distinct !DILocation(line: 142, column: 86, scope: !40)
!128 = !DILocation(line: 142, column: 7, scope: !40)
!129 = !DILocation(line: 142, column: 83, scope: !40)
!130 = !DILocation(line: 145, column: 33, scope: !40)
!131 = !DILocation(line: 145, column: 7, scope: !40)
!132 = !DILocation(line: 146, column: 48, scope: !40)
!133 = !DILocation(line: 146, column: 27, scope: !40)
!134 = !DILocation(line: 146, column: 9, scope: !40)
!135 = !DILocation(line: 150, column: 77, scope: !40)
!136 = !DILocation(line: 155, column: 21, scope: !40)
!137 = !DILocation(line: 150, column: 69, scope: !40)
!138 = !DILocation(line: 164, column: 36, scope: !40)
!139 = !DILocation(line: 172, column: 31, scope: !40)
!140 = !DILocation(line: 172, column: 43, scope: !40)
!141 = !DILocation(line: 354, column: 10, scope: !91, inlinedAt: !142)
!142 = distinct !DILocation(line: 172, column: 26, scope: !40)
!143 = !DILocation(line: 288, column: 10, scope: !94, inlinedAt: !144)
!144 = distinct !DILocation(line: 172, column: 21, scope: !40)
!145 = !DILocation(line: 176, column: 38, scope: !40)
!146 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !147)
!147 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !148)
!148 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !149)
!149 = distinct !DILocation(line: 180, column: 86, scope: !40)
!150 = !DILocation(line: 180, column: 7, scope: !40)
!151 = !DILocation(line: 180, column: 83, scope: !40)
!152 = !DILocation(line: 183, column: 33, scope: !40)
!153 = !DILocation(line: 183, column: 7, scope: !40)
!154 = !DILocation(line: 184, column: 48, scope: !40)
!155 = !DILocation(line: 184, column: 27, scope: !40)
!156 = !DILocation(line: 184, column: 9, scope: !40)
!157 = !DILocation(line: 188, column: 77, scope: !40)
!158 = !DILocation(line: 193, column: 21, scope: !40)
!159 = !DILocation(line: 188, column: 69, scope: !40)
!160 = !DILocation(line: 202, column: 36, scope: !40)
!161 = !DILocation(line: 210, column: 31, scope: !40)
!162 = !DILocation(line: 210, column: 43, scope: !40)
!163 = !DILocation(line: 354, column: 10, scope: !91, inlinedAt: !164)
!164 = distinct !DILocation(line: 210, column: 26, scope: !40)
!165 = !DILocation(line: 288, column: 10, scope: !94, inlinedAt: !166)
!166 = distinct !DILocation(line: 210, column: 21, scope: !40)
!167 = !DILocation(line: 214, column: 38, scope: !40)
!168 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !169)
!169 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !170)
!170 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !171)
!171 = distinct !DILocation(line: 218, column: 86, scope: !40)
!172 = !DILocation(line: 218, column: 7, scope: !40)
!173 = !DILocation(line: 218, column: 83, scope: !40)
!174 = !DILocation(line: 221, column: 27, scope: !40)
!175 = !DILocation(line: 222, column: 33, scope: !40)
!176 = !DILocation(line: 224, column: 5, scope: !40)
!177 = !DILocation(line: 225, column: 51, scope: !40)
!178 = !DILocation(line: 225, column: 37, scope: !40)
!179 = !DILocation(line: 228, column: 27, scope: !40)
!180 = !DILocation(line: 229, column: 33, scope: !40)
!181 = !DILocation(line: 231, column: 5, scope: !40)
!182 = !DILocation(line: 232, column: 52, scope: !40)
!183 = !DILocation(line: 232, column: 38, scope: !40)
!184 = !DILocation(line: 235, column: 27, scope: !40)
!185 = !DILocation(line: 236, column: 33, scope: !40)
!186 = !DILocation(line: 238, column: 5, scope: !40)
!187 = !DILocation(line: 239, column: 52, scope: !40)
!188 = !DILocation(line: 239, column: 38, scope: !40)
!189 = !DILocation(line: 242, column: 27, scope: !40)
!190 = !DILocation(line: 243, column: 33, scope: !40)
!191 = !DILocation(line: 245, column: 5, scope: !40)
!192 = !DILocation(line: 246, column: 52, scope: !40)
!193 = !DILocation(line: 246, column: 38, scope: !40)
!194 = !DILocation(line: 249, column: 33, scope: !40)
!195 = !DILocation(line: 249, column: 7, scope: !40)
!196 = !DILocation(line: 250, column: 48, scope: !40)
!197 = !DILocation(line: 250, column: 27, scope: !40)
!198 = !DILocation(line: 250, column: 9, scope: !40)
!199 = !DILocation(line: 254, column: 77, scope: !40)
!200 = !DILocation(line: 259, column: 21, scope: !40)
!201 = !DILocation(line: 254, column: 69, scope: !40)
!202 = !DILocation(line: 268, column: 36, scope: !40)
!203 = !DILocation(line: 276, column: 31, scope: !40)
!204 = !DILocation(line: 276, column: 43, scope: !40)
!205 = !DILocation(line: 354, column: 10, scope: !91, inlinedAt: !206)
!206 = distinct !DILocation(line: 276, column: 26, scope: !40)
!207 = !DILocation(line: 288, column: 10, scope: !94, inlinedAt: !208)
!208 = distinct !DILocation(line: 276, column: 21, scope: !40)
!209 = !DILocation(line: 280, column: 38, scope: !40)
!210 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !211)
!211 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !212)
!212 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !213)
!213 = distinct !DILocation(line: 284, column: 87, scope: !40)
!214 = !DILocation(line: 284, column: 7, scope: !40)
!215 = !DILocation(line: 284, column: 84, scope: !40)
!216 = !DILocation(line: 287, column: 33, scope: !40)
!217 = !DILocation(line: 287, column: 7, scope: !40)
!218 = !DILocation(line: 288, column: 48, scope: !40)
!219 = !DILocation(line: 288, column: 27, scope: !40)
!220 = !DILocation(line: 288, column: 9, scope: !40)
!221 = !DILocation(line: 292, column: 77, scope: !40)
!222 = !DILocation(line: 297, column: 21, scope: !40)
!223 = !DILocation(line: 292, column: 69, scope: !40)
!224 = !DILocation(line: 306, column: 36, scope: !40)
!225 = !DILocation(line: 314, column: 31, scope: !40)
!226 = !DILocation(line: 314, column: 43, scope: !40)
!227 = !DILocation(line: 354, column: 10, scope: !91, inlinedAt: !228)
!228 = distinct !DILocation(line: 314, column: 26, scope: !40)
!229 = !DILocation(line: 288, column: 10, scope: !94, inlinedAt: !230)
!230 = distinct !DILocation(line: 314, column: 21, scope: !40)
!231 = !DILocation(line: 318, column: 38, scope: !40)
!232 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !233)
!233 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !234)
!234 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !235)
!235 = distinct !DILocation(line: 322, column: 87, scope: !40)
!236 = !DILocation(line: 322, column: 7, scope: !40)
!237 = !DILocation(line: 322, column: 84, scope: !40)
!238 = !DILocation(line: 325, column: 33, scope: !40)
!239 = !DILocation(line: 325, column: 7, scope: !40)
!240 = !DILocation(line: 326, column: 48, scope: !40)
!241 = !DILocation(line: 326, column: 27, scope: !40)
!242 = !DILocation(line: 326, column: 9, scope: !40)
!243 = !DILocation(line: 330, column: 77, scope: !40)
!244 = !DILocation(line: 335, column: 21, scope: !40)
!245 = !DILocation(line: 330, column: 69, scope: !40)
!246 = !DILocation(line: 344, column: 36, scope: !40)
!247 = !DILocation(line: 352, column: 31, scope: !40)
!248 = !DILocation(line: 352, column: 43, scope: !40)
!249 = !DILocation(line: 354, column: 10, scope: !91, inlinedAt: !250)
!250 = distinct !DILocation(line: 352, column: 26, scope: !40)
!251 = !DILocation(line: 288, column: 10, scope: !94, inlinedAt: !252)
!252 = distinct !DILocation(line: 352, column: 21, scope: !40)
!253 = !DILocation(line: 356, column: 38, scope: !40)
!254 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !255)
!255 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !256)
!256 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !257)
!257 = distinct !DILocation(line: 360, column: 87, scope: !40)
!258 = !DILocation(line: 360, column: 7, scope: !40)
!259 = !DILocation(line: 360, column: 84, scope: !40)
!260 = !DILocation(line: 363, column: 33, scope: !40)
!261 = !DILocation(line: 363, column: 7, scope: !40)
!262 = !DILocation(line: 364, column: 48, scope: !40)
!263 = !DILocation(line: 364, column: 27, scope: !40)
!264 = !DILocation(line: 364, column: 9, scope: !40)
!265 = !DILocation(line: 368, column: 77, scope: !40)
!266 = !DILocation(line: 373, column: 21, scope: !40)
!267 = !DILocation(line: 368, column: 69, scope: !40)
!268 = !DILocation(line: 382, column: 36, scope: !40)
!269 = !DILocation(line: 390, column: 31, scope: !40)
!270 = !DILocation(line: 390, column: 43, scope: !40)
!271 = !DILocation(line: 354, column: 10, scope: !91, inlinedAt: !272)
!272 = distinct !DILocation(line: 390, column: 26, scope: !40)
!273 = !DILocation(line: 288, column: 10, scope: !94, inlinedAt: !274)
!274 = distinct !DILocation(line: 390, column: 21, scope: !40)
!275 = !DILocation(line: 394, column: 38, scope: !40)
!276 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !277)
!277 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !278)
!278 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !279)
!279 = distinct !DILocation(line: 398, column: 87, scope: !40)
!280 = !DILocation(line: 398, column: 7, scope: !40)
!281 = !DILocation(line: 398, column: 84, scope: !40)
!282 = !DILocation(line: 402, column: 3, scope: !40)
!283 = !DILocation(line: 68, column: 3, scope: !284, inlinedAt: !286)
!284 = distinct !DISubprogram(name: "__barrier_warp", scope: !285, file: !285, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!285 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!286 = distinct !DILocation(line: 192, column: 3, scope: !287, inlinedAt: !288)
!287 = distinct !DISubprogram(name: "__syncwarp", scope: !285, file: !285, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!288 = distinct !DILocation(line: 421, column: 3, scope: !40)
!289 = !DILocation(line: 69, column: 3, scope: !284, inlinedAt: !286)
!290 = !DILocation(line: 70, column: 3, scope: !284, inlinedAt: !286)
!291 = !DILocation(line: 423, column: 33, scope: !40)
!292 = !DILocation(line: 425, column: 5, scope: !40)
!293 = !DILocation(line: 426, column: 51, scope: !40)
!294 = !DILocation(line: 426, column: 37, scope: !40)
!295 = !DILocation(line: 430, column: 34, scope: !40)
!296 = !DILocation(line: 430, column: 32, scope: !40)
!297 = !DILocation(line: 434, column: 36, scope: !40)
!298 = !{i32 4, i32 -1, i32 -1}
!299 = !DILocation(line: 440, column: 27, scope: !40)
!300 = !DILocation(line: 441, column: 33, scope: !40)
!301 = !DILocation(line: 443, column: 5, scope: !40)
!302 = !DILocation(line: 444, column: 51, scope: !40)
!303 = !DILocation(line: 444, column: 37, scope: !40)
!304 = !DILocation(line: 448, column: 34, scope: !40)
!305 = !DILocation(line: 448, column: 32, scope: !40)
!306 = !DILocation(line: 452, column: 40, scope: !40)
!307 = !DILocation(line: 458, column: 27, scope: !40)
!308 = !DILocation(line: 459, column: 33, scope: !40)
!309 = !DILocation(line: 461, column: 5, scope: !40)
!310 = !DILocation(line: 462, column: 51, scope: !40)
!311 = !DILocation(line: 462, column: 37, scope: !40)
!312 = !DILocation(line: 466, column: 35, scope: !40)
!313 = !DILocation(line: 466, column: 33, scope: !40)
!314 = !DILocation(line: 470, column: 40, scope: !40)
!315 = !DILocation(line: 476, column: 27, scope: !40)
!316 = !DILocation(line: 477, column: 33, scope: !40)
!317 = !DILocation(line: 479, column: 5, scope: !40)
!318 = !DILocation(line: 480, column: 51, scope: !40)
!319 = !DILocation(line: 480, column: 37, scope: !40)
!320 = !DILocation(line: 484, column: 35, scope: !40)
!321 = !DILocation(line: 484, column: 33, scope: !40)
!322 = !DILocation(line: 488, column: 40, scope: !40)
!323 = !DILocation(line: 494, column: 27, scope: !40)
!324 = !DILocation(line: 495, column: 33, scope: !40)
!325 = !DILocation(line: 497, column: 5, scope: !40)
!326 = !DILocation(line: 498, column: 51, scope: !40)
!327 = !DILocation(line: 498, column: 37, scope: !40)
!328 = !DILocation(line: 502, column: 35, scope: !40)
!329 = !DILocation(line: 502, column: 33, scope: !40)
!330 = !DILocation(line: 506, column: 38, scope: !40)
!331 = !DILocation(line: 512, column: 27, scope: !40)
!332 = !DILocation(line: 513, column: 33, scope: !40)
!333 = !DILocation(line: 515, column: 5, scope: !40)
!334 = !DILocation(line: 516, column: 51, scope: !40)
!335 = !DILocation(line: 516, column: 37, scope: !40)
!336 = !DILocation(line: 520, column: 35, scope: !40)
!337 = !DILocation(line: 520, column: 33, scope: !40)
!338 = !DILocation(line: 524, column: 40, scope: !40)
!339 = !DILocation(line: 530, column: 27, scope: !40)
!340 = !DILocation(line: 531, column: 33, scope: !40)
!341 = !DILocation(line: 533, column: 5, scope: !40)
!342 = !DILocation(line: 534, column: 51, scope: !40)
!343 = !DILocation(line: 534, column: 37, scope: !40)
!344 = !DILocation(line: 538, column: 35, scope: !40)
!345 = !DILocation(line: 538, column: 33, scope: !40)
!346 = !DILocation(line: 542, column: 40, scope: !40)
!347 = !DILocation(line: 548, column: 27, scope: !40)
!348 = !DILocation(line: 549, column: 33, scope: !40)
!349 = !DILocation(line: 551, column: 5, scope: !40)
!350 = !DILocation(line: 552, column: 51, scope: !40)
!351 = !DILocation(line: 552, column: 37, scope: !40)
!352 = !DILocation(line: 556, column: 35, scope: !40)
!353 = !DILocation(line: 556, column: 33, scope: !40)
!354 = !DILocation(line: 560, column: 40, scope: !40)
!355 = !DILocation(line: 68, column: 3, scope: !284, inlinedAt: !356)
!356 = distinct !DILocation(line: 192, column: 3, scope: !287, inlinedAt: !357)
!357 = distinct !DILocation(line: 566, column: 3, scope: !40)
!358 = !DILocation(line: 69, column: 3, scope: !284, inlinedAt: !356)
!359 = !DILocation(line: 70, column: 3, scope: !284, inlinedAt: !356)
!360 = !DILocation(line: 569, column: 20, scope: !40)
!361 = !DILocation(line: 569, column: 34, scope: !40)
!362 = !DILocation(line: 569, column: 32, scope: !40)
!363 = !DILocation(line: 570, column: 34, scope: !40)
!364 = !DILocation(line: 570, column: 32, scope: !40)
!365 = !DILocation(line: 571, column: 34, scope: !40)
!366 = !DILocation(line: 571, column: 32, scope: !40)
!367 = !DILocation(line: 576, column: 36, scope: !40)
!368 = !DILocation(line: 1018, column: 9, scope: !369, inlinedAt: !370)
!369 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !285, file: !285, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!370 = distinct !DILocation(line: 396, column: 10, scope: !371, inlinedAt: !373)
!371 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !372, file: !372, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!372 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!373 = distinct !DILocation(line: 129, column: 24, scope: !374, inlinedAt: !376)
!374 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !375, file: !375, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!375 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!376 = distinct !DILocation(line: 101, column: 14, scope: !377, inlinedAt: !378)
!377 = distinct !DISubprogram(name: "run<float>", scope: !375, file: !375, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!378 = distinct !DILocation(line: 578, column: 19, scope: !40)
!379 = !DILocation(line: 171, column: 37, scope: !380, inlinedAt: !381)
!380 = distinct !DISubprogram(name: "__lane_id", scope: !285, file: !285, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!381 = distinct !DILocation(line: 990, column: 14, scope: !382, inlinedAt: !383)
!382 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !285, file: !285, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!383 = distinct !DILocation(line: 1019, column: 11, scope: !369, inlinedAt: !370)
!384 = !DILocation(line: 171, column: 10, scope: !380, inlinedAt: !381)
!385 = !DILocation(line: 991, column: 20, scope: !382, inlinedAt: !383)
!386 = !DILocation(line: 992, column: 36, scope: !382, inlinedAt: !383)
!387 = !DILocation(line: 992, column: 17, scope: !382, inlinedAt: !383)
!388 = !DILocation(line: 992, column: 11, scope: !382, inlinedAt: !383)
!389 = !DILocation(line: 993, column: 43, scope: !382, inlinedAt: !383)
!390 = !DILocation(line: 993, column: 10, scope: !382, inlinedAt: !383)
!391 = !DILocation(line: 1020, column: 14, scope: !369, inlinedAt: !370)
!392 = !DILocation(line: 25, column: 14, scope: !393, inlinedAt: !394)
!393 = distinct !DISubprogram(name: "operator()<float>", scope: !375, file: !375, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!394 = distinct !DILocation(line: 129, column: 11, scope: !374, inlinedAt: !376)
!395 = !DILocation(line: 1018, column: 9, scope: !369, inlinedAt: !396)
!396 = distinct !DILocation(line: 396, column: 10, scope: !371, inlinedAt: !397)
!397 = distinct !DILocation(line: 129, column: 24, scope: !398, inlinedAt: !399)
!398 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !375, file: !375, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!399 = distinct !DILocation(line: 101, column: 14, scope: !400, inlinedAt: !401)
!400 = distinct !DISubprogram(name: "run<float>", scope: !375, file: !375, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!401 = distinct !DILocation(line: 134, column: 14, scope: !374, inlinedAt: !376)
!402 = !DILocation(line: 171, column: 37, scope: !380, inlinedAt: !403)
!403 = distinct !DILocation(line: 990, column: 14, scope: !382, inlinedAt: !404)
!404 = distinct !DILocation(line: 1019, column: 11, scope: !369, inlinedAt: !396)
!405 = !DILocation(line: 171, column: 10, scope: !380, inlinedAt: !403)
!406 = !DILocation(line: 991, column: 20, scope: !382, inlinedAt: !404)
!407 = !DILocation(line: 992, column: 36, scope: !382, inlinedAt: !404)
!408 = !DILocation(line: 992, column: 17, scope: !382, inlinedAt: !404)
!409 = !DILocation(line: 992, column: 11, scope: !382, inlinedAt: !404)
!410 = !DILocation(line: 993, column: 43, scope: !382, inlinedAt: !404)
!411 = !DILocation(line: 993, column: 10, scope: !382, inlinedAt: !404)
!412 = !DILocation(line: 1020, column: 14, scope: !369, inlinedAt: !396)
!413 = !DILocation(line: 25, column: 14, scope: !393, inlinedAt: !414)
!414 = distinct !DILocation(line: 129, column: 11, scope: !398, inlinedAt: !399)
!415 = !DILocation(line: 580, column: 32, scope: !40)
!416 = !DILocation(line: 580, column: 7, scope: !40)
!417 = !DILocation(line: 588, column: 32, scope: !40)
!418 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !419)
!419 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !420)
!420 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !421)
!421 = distinct !DILocation(line: 594, column: 48, scope: !40)
!422 = !DILocation(line: 594, column: 45, scope: !40)
!423 = !DILocation(line: 599, column: 122, scope: !40)
!424 = !DILocation(line: 599, column: 150, scope: !40)
!425 = !DILocation(line: 599, column: 77, scope: !40)
!426 = !DILocation(line: 599, column: 156, scope: !40)
!427 = !DILocation(line: 599, column: 40, scope: !40)
!428 = !DILocation(line: 599, column: 199, scope: !40)
!429 = !DILocation(line: 599, column: 93, scope: !40)
!430 = !DILocation(line: 68, column: 3, scope: !284, inlinedAt: !431)
!431 = distinct !DILocation(line: 192, column: 3, scope: !287, inlinedAt: !432)
!432 = distinct !DILocation(line: 601, column: 3, scope: !40)
!433 = !DILocation(line: 69, column: 3, scope: !284, inlinedAt: !431)
!434 = !DILocation(line: 70, column: 3, scope: !284, inlinedAt: !431)
!435 = !DILocation(line: 603, column: 8, scope: !40)
!436 = !DILocation(line: 603, column: 3, scope: !40)
!437 = !DILocation(line: 604, column: 22, scope: !40)
!438 = !DILocation(line: 604, column: 132, scope: !40)
!439 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!440 = !{i32 2, i32 -1, i32 -1, i32 -1}
!441 = !DILocation(line: 604, column: 169, scope: !40)
!442 = !DILocation(line: 606, column: 1, scope: !40)
