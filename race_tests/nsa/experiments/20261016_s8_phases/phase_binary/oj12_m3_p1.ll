; ModuleID = 'experiments/20261016_s8_phases/phase_binary/oj12_m3_p1.bc'
source_filename = "/tmp/tmp_q2d97ya/tvm_kernels.maca"
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
  %cond.i.i2368 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64), !dbg !49
  %mul11 = shl nsw i32 %cond.i.i2368, 4, !dbg !52
  %4 = or disjoint i64 %2, 1, !dbg !53
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4, !dbg !43
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !dbg !43, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2368.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64), !dbg !49
  %mul11.1 = shl nsw i32 %cond.i.i2368.1, 4, !dbg !52
  %6 = or disjoint i64 %2, 2, !dbg !53
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6, !dbg !43
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !dbg !43, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2368.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64), !dbg !49
  %mul11.2 = shl nsw i32 %cond.i.i2368.2, 4, !dbg !52
  %8 = or disjoint i64 %2, 3, !dbg !53
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8, !dbg !43
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !dbg !43, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2368.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64), !dbg !49
  %mul11.3 = shl nsw i32 %cond.i.i2368.3, 4, !dbg !52
  %10 = or disjoint i64 %2, 4, !dbg !53
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10, !dbg !43
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !dbg !43, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2368.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64), !dbg !49
  %mul11.4 = shl nsw i32 %cond.i.i2368.4, 4, !dbg !52
  %12 = or disjoint i64 %2, 5, !dbg !53
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12, !dbg !43
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !dbg !43, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2368.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64), !dbg !49
  %mul11.5 = shl nsw i32 %cond.i.i2368.5, 4, !dbg !52
  %14 = or disjoint i64 %2, 6, !dbg !53
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14, !dbg !43
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !dbg !43, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2368.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64), !dbg !49
  %mul11.6 = shl nsw i32 %cond.i.i2368.6, 4, !dbg !52
  %16 = or disjoint i64 %2, 7, !dbg !53
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16, !dbg !43
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !dbg !43, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2368.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64), !dbg !49
  %mul11.7 = shl nsw i32 %cond.i.i2368.7, 4, !dbg !52
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
  %or.cond2500 = or i1 %or.cond, %cmp47.not, !dbg !58
  br i1 %or.cond2500, label %if.end, label %for.cond48.preheader, !dbg !58

for.cond48.preheader:                             ; preds = %entry
  %mul54 = shl nsw i32 %0, 16
  %22 = shl nsw i32 %cond.i.i2368, 10
  %mul56 = and i32 %22, 64512
  %mul61 = shl nuw nsw i32 %18, 3
  %add57 = or disjoint i32 %mul61, %mul54
  %add59 = add nuw nsw i32 %add57, %mul56
  %23 = zext nneg i32 %add59 to i64, !dbg !59
  %add.ptr64 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %23, !dbg !60
  %K_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr64, align 16, !dbg !61
  %K_reg.sroa.10.0.add.ptr64.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr64, i64 8, !dbg !61
  %K_reg.sroa.10.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg.sroa.10.0.add.ptr64.sroa_idx, align 8, !dbg !61
  %24 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %23, !dbg !60
  %add.ptr64.1 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 1024, !dbg !60
  %K_reg.sroa.14.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr64.1, align 16, !dbg !61
  %K_reg.sroa.22.16.add.ptr64.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %24, i64 1032, !dbg !61
  %K_reg.sroa.22.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg.sroa.22.16.add.ptr64.1.sroa_idx, align 8, !dbg !61
  br label %if.end, !dbg !62

if.end:                                           ; preds = %for.cond48.preheader, %entry
  %K_reg.sroa.22.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.22.16.copyload, %for.cond48.preheader ]
  %K_reg.sroa.14.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.14.16.copyload, %for.cond48.preheader ]
  %K_reg.sroa.10.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.10.0.copyload, %for.cond48.preheader ]
  %K_reg.sroa.0.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.0.0.copyload, %for.cond48.preheader ]
  %or.cond2501 = icmp ugt i32 %mul11.1, 1023, !dbg !63
  %cmp78.not = icmp sgt i32 %mul11.1, %1
  %or.cond2502 = or i1 %or.cond2501, %cmp78.not, !dbg !63
  br i1 %or.cond2502, label %if.end104, label %for.cond80.preheader, !dbg !63

for.cond80.preheader:                             ; preds = %if.end
  %mul86 = shl nsw i32 %0, 16
  %25 = shl nsw i32 %cond.i.i2368.1, 10
  %mul88 = and i32 %25, 64512
  %mul93 = shl nuw nsw i32 %18, 3
  %add89 = or disjoint i32 %mul93, %mul86
  %add91 = add nuw nsw i32 %add89, %mul88
  %26 = zext nneg i32 %add91 to i64, !dbg !64
  %add.ptr96 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %26, !dbg !65
  %K_reg1.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr96, align 16, !dbg !66
  %K_reg1.sroa.10.0.add.ptr96.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr96, i64 8, !dbg !66
  %K_reg1.sroa.10.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.10.0.add.ptr96.sroa_idx, align 8, !dbg !66
  %27 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %26, !dbg !65
  %add.ptr96.1 = getelementptr inbounds i8, ptr addrspace(4) %27, i64 1024, !dbg !65
  %K_reg1.sroa.14.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr96.1, align 16, !dbg !66
  %K_reg1.sroa.22.16.add.ptr96.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %27, i64 1032, !dbg !66
  %K_reg1.sroa.22.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.22.16.add.ptr96.1.sroa_idx, align 8, !dbg !66
  br label %if.end104, !dbg !67

if.end104:                                        ; preds = %for.cond80.preheader, %if.end
  %K_reg1.sroa.22.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.22.16.copyload, %for.cond80.preheader ]
  %K_reg1.sroa.14.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.14.16.copyload, %for.cond80.preheader ]
  %K_reg1.sroa.10.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.10.0.copyload, %for.cond80.preheader ]
  %K_reg1.sroa.0.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.0.0.copyload, %for.cond80.preheader ]
  %or.cond2503 = icmp ult i32 %mul11, 1024, !dbg !67
  br i1 %or.cond2503, label %land.lhs.true108, label %if.end210, !dbg !67

land.lhs.true108:                                 ; preds = %if.end104
  br i1 %cmp47.not, label %if.end210, label %if.then111, !dbg !68

if.then111:                                       ; preds = %land.lhs.true108
  %add113 = or disjoint i32 %mul11, 15, !dbg !69
  %cmp114 = icmp ult i32 %1, %add113, !dbg !70
  br i1 %cmp114, label %for.cond116.preheader, label %if.end140, !dbg !71

for.cond116.preheader:                            ; preds = %if.then111
  %28 = lshr i32 %18, 2
  %mul123 = and i32 %28, 252
  %add124 = add nuw nsw i32 %mul11, %mul123
  %cmp127.not = icmp sgt i32 %add124, %1, !dbg !72
  %fneg. = select i1 %cmp127.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2984 = insertelement <4 x float> poison, float %fneg., i64 0, !dbg !73
  %cmp127.not.1.not = icmp slt i32 %add124, %1, !dbg !72
  %fneg..1 = select i1 %cmp127.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3077 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2984, float %fneg..1, i64 1, !dbg !73
  %add125.2 = or disjoint i32 %add124, 2, !dbg !74
  %cmp127.not.2 = icmp sgt i32 %add125.2, %1, !dbg !72
  %fneg..2 = select i1 %cmp127.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3170 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3077, float %fneg..2, i64 2, !dbg !73
  %add125.3 = or disjoint i32 %add124, 3, !dbg !74
  %cmp127.not.3 = icmp sgt i32 %add125.3, %1, !dbg !72
  %fneg..3 = select i1 %cmp127.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3263 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3170, float %fneg..3, i64 3, !dbg !73
  br label %if.end140

if.end140:                                        ; preds = %if.then111, %for.cond116.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3263, %for.cond116.preheader ], [ zeroinitializer, %if.then111 ], !dbg !75
  %29 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !dbg !76, !call_argsrelate !77
  %30 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.10.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %29), !dbg !76, !call_argsrelate !77
  %31 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.14.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %30), !dbg !76, !call_argsrelate !77
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.22.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %31), !dbg !76, !call_argsrelate !77
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %32, i64 0, !dbg !78
  %mul176 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !79
  %33 = tail call contract noundef float @llvm.minnum.f32(float %mul176, float 0x4024CB5EC0000000), !dbg !80
  %34 = tail call contract noundef float @llvm.exp.f32(float %33), !dbg !83
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %32, i64 1, !dbg !78
  %mul176.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !79
  %35 = tail call contract noundef float @llvm.minnum.f32(float %mul176.1, float 0x4024CB5EC0000000), !dbg !80
  %36 = tail call contract noundef float @llvm.exp.f32(float %35), !dbg !83
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %32, i64 2, !dbg !78
  %mul176.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !79
  %37 = tail call contract noundef float @llvm.minnum.f32(float %mul176.2, float 0x4024CB5EC0000000), !dbg !80
  %38 = tail call contract noundef float @llvm.exp.f32(float %37), !dbg !83
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %32, i64 3, !dbg !78
  %mul176.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !79
  %39 = tail call contract noundef float @llvm.minnum.f32(float %mul176.3, float 0x4024CB5EC0000000), !dbg !80
  %40 = tail call contract noundef float @llvm.exp.f32(float %39), !dbg !83
  %41 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %34), !dbg !86
  %42 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %36), !dbg !86
  %43 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %38), !dbg !86
  %44 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %40), !dbg !86
  br label %if.end210, !dbg !95

if.end210:                                        ; preds = %if.end140, %land.lhs.true108, %if.end104
  %sum_acc.sroa.56.0 = phi float [ 0.000000e+00, %land.lhs.true108 ], [ %40, %if.end140 ], [ 0.000000e+00, %if.end104 ], !dbg !75
  %sum_acc.sroa.38.0 = phi float [ 0.000000e+00, %land.lhs.true108 ], [ %38, %if.end140 ], [ 0.000000e+00, %if.end104 ], !dbg !75
  %sum_acc.sroa.20.0 = phi float [ 0.000000e+00, %land.lhs.true108 ], [ %36, %if.end140 ], [ 0.000000e+00, %if.end104 ], !dbg !75
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %land.lhs.true108 ], [ %34, %if.end140 ], [ 0.000000e+00, %if.end104 ], !dbg !75
  %phase_weights.sroa.8.0 = phi i16 [ undef, %land.lhs.true108 ], [ %44, %if.end140 ], [ undef, %if.end104 ]
  %phase_weights.sroa.6.0 = phi i16 [ undef, %land.lhs.true108 ], [ %43, %if.end140 ], [ undef, %if.end104 ]
  %phase_weights.sroa.4.0 = phi i16 [ undef, %land.lhs.true108 ], [ %42, %if.end140 ], [ undef, %if.end104 ]
  %phase_weights.sroa.0.0 = phi i16 [ undef, %land.lhs.true108 ], [ %41, %if.end140 ], [ undef, %if.end104 ]
  %or.cond2504 = icmp ult i32 %mul11.1, 1024, !dbg !95
  br i1 %or.cond2504, label %land.lhs.true214, label %if.end316, !dbg !95

land.lhs.true214:                                 ; preds = %if.end210
  br i1 %cmp78.not, label %if.end316, label %if.then217, !dbg !96

if.then217:                                       ; preds = %land.lhs.true214
  %add219 = or disjoint i32 %mul11.1, 15, !dbg !97
  %cmp220 = icmp ult i32 %1, %add219, !dbg !98
  br i1 %cmp220, label %for.cond222.preheader, label %if.end246, !dbg !99

for.cond222.preheader:                            ; preds = %if.then217
  %45 = lshr i32 %18, 2
  %mul228 = and i32 %45, 252
  %add229 = add nuw nsw i32 %mul11.1, %mul228
  %cmp232.not = icmp sgt i32 %add229, %1, !dbg !100
  %fneg.2353 = select i1 %cmp232.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2993 = insertelement <4 x float> poison, float %fneg.2353, i64 0, !dbg !101
  %cmp232.not.1.not = icmp slt i32 %add229, %1, !dbg !100
  %fneg.2353.1 = select i1 %cmp232.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3086 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2993, float %fneg.2353.1, i64 1, !dbg !101
  %add230.2 = or disjoint i32 %add229, 2, !dbg !102
  %cmp232.not.2 = icmp sgt i32 %add230.2, %1, !dbg !100
  %fneg.2353.2 = select i1 %cmp232.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3179 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3086, float %fneg.2353.2, i64 2, !dbg !101
  %add230.3 = or disjoint i32 %add229, 3, !dbg !102
  %cmp232.not.3 = icmp sgt i32 %add230.3, %1, !dbg !100
  %fneg.2353.3 = select i1 %cmp232.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3272 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3179, float %fneg.2353.3, i64 3, !dbg !101
  br label %if.end246

if.end246:                                        ; preds = %if.then217, %for.cond222.preheader
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3272, %for.cond222.preheader ], [ zeroinitializer, %if.then217 ], !dbg !75
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.2), !dbg !103, !call_argsrelate !77
  %47 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.10.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %46), !dbg !103, !call_argsrelate !77
  %48 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.14.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %47), !dbg !103, !call_argsrelate !77
  %49 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.22.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %48), !dbg !103, !call_argsrelate !77
  %acc_s.sroa.0.0.vec.extract2995 = extractelement <4 x float> %49, i64 0, !dbg !104
  %mul281 = fmul contract float %acc_s.sroa.0.0.vec.extract2995, 0x3FB99999A0000000, !dbg !105
  %50 = tail call contract noundef float @llvm.minnum.f32(float %mul281, float 0x4024CB5EC0000000), !dbg !106
  %51 = tail call contract noundef float @llvm.exp.f32(float %50), !dbg !108
  %acc_s.sroa.0.4.vec.extract3088 = extractelement <4 x float> %49, i64 1, !dbg !104
  %mul281.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3088, 0x3FB99999A0000000, !dbg !105
  %52 = tail call contract noundef float @llvm.minnum.f32(float %mul281.1, float 0x4024CB5EC0000000), !dbg !106
  %53 = tail call contract noundef float @llvm.exp.f32(float %52), !dbg !108
  %acc_s.sroa.0.8.vec.extract3181 = extractelement <4 x float> %49, i64 2, !dbg !104
  %mul281.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3181, 0x3FB99999A0000000, !dbg !105
  %54 = tail call contract noundef float @llvm.minnum.f32(float %mul281.2, float 0x4024CB5EC0000000), !dbg !106
  %55 = tail call contract noundef float @llvm.exp.f32(float %54), !dbg !108
  %acc_s.sroa.0.12.vec.extract3274 = extractelement <4 x float> %49, i64 3, !dbg !104
  %mul281.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3274, 0x3FB99999A0000000, !dbg !105
  %56 = tail call contract noundef float @llvm.minnum.f32(float %mul281.3, float 0x4024CB5EC0000000), !dbg !106
  %57 = tail call contract noundef float @llvm.exp.f32(float %56), !dbg !108
  %add297 = fadd contract float %sum_acc.sroa.0.0, %51, !dbg !110
  %add297.1 = fadd contract float %sum_acc.sroa.20.0, %53, !dbg !110
  %add297.2 = fadd contract float %sum_acc.sroa.38.0, %55, !dbg !110
  %add297.3 = fadd contract float %sum_acc.sroa.56.0, %57, !dbg !110
  %58 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %51), !dbg !111
  %59 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %53), !dbg !111
  %60 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %55), !dbg !111
  %61 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %57), !dbg !111
  br label %if.end316, !dbg !115

if.end316:                                        ; preds = %if.end246, %land.lhs.true214, %if.end210
  %sum_acc.sroa.56.1 = phi float [ %sum_acc.sroa.56.0, %land.lhs.true214 ], [ %add297.3, %if.end246 ], [ %sum_acc.sroa.56.0, %if.end210 ], !dbg !75
  %sum_acc.sroa.38.1 = phi float [ %sum_acc.sroa.38.0, %land.lhs.true214 ], [ %add297.2, %if.end246 ], [ %sum_acc.sroa.38.0, %if.end210 ], !dbg !75
  %sum_acc.sroa.20.1 = phi float [ %sum_acc.sroa.20.0, %land.lhs.true214 ], [ %add297.1, %if.end246 ], [ %sum_acc.sroa.20.0, %if.end210 ], !dbg !75
  %sum_acc.sroa.0.1 = phi float [ %sum_acc.sroa.0.0, %land.lhs.true214 ], [ %add297, %if.end246 ], [ %sum_acc.sroa.0.0, %if.end210 ], !dbg !75
  %phase_weights.sroa.16.0 = phi i16 [ undef, %land.lhs.true214 ], [ %61, %if.end246 ], [ undef, %if.end210 ]
  %phase_weights.sroa.14.0 = phi i16 [ undef, %land.lhs.true214 ], [ %60, %if.end246 ], [ undef, %if.end210 ]
  %phase_weights.sroa.12.0 = phi i16 [ undef, %land.lhs.true214 ], [ %59, %if.end246 ], [ undef, %if.end210 ]
  %phase_weights.sroa.10.0 = phi i16 [ undef, %land.lhs.true214 ], [ %58, %if.end246 ], [ undef, %if.end210 ]
  %or.cond2505 = icmp ugt i32 %mul11.2, 1023, !dbg !116
  %cmp323.not = icmp sgt i32 %mul11.2, %1
  %or.cond2506 = or i1 %or.cond2505, %cmp323.not, !dbg !116
  br i1 %or.cond2506, label %if.end348, label %for.cond325.preheader, !dbg !116

for.cond325.preheader:                            ; preds = %if.end316
  %mul330 = shl nsw i32 %0, 16
  %62 = shl nsw i32 %cond.i.i2368.2, 10
  %mul332 = and i32 %62, 64512
  %mul337 = shl nuw nsw i32 %18, 3
  %add333 = or disjoint i32 %mul337, %mul330
  %add335 = add nuw nsw i32 %add333, %mul332
  %63 = zext nneg i32 %add335 to i64, !dbg !117
  %add.ptr340 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %63, !dbg !118
  %K_reg.sroa.0.0.copyload3368 = load <4 x half>, ptr addrspace(4) %add.ptr340, align 16, !dbg !119
  %K_reg.sroa.10.0.add.ptr340.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr340, i64 8, !dbg !119
  %K_reg.sroa.10.0.copyload3371 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.10.0.add.ptr340.sroa_idx, align 8, !dbg !119
  %64 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %63, !dbg !118
  %add.ptr340.1 = getelementptr inbounds i8, ptr addrspace(4) %64, i64 1024, !dbg !118
  %K_reg.sroa.14.16.copyload3380 = load <4 x half>, ptr addrspace(4) %add.ptr340.1, align 16, !dbg !119
  %K_reg.sroa.22.16.add.ptr340.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %64, i64 1032, !dbg !119
  %K_reg.sroa.22.16.copyload3383 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.22.16.add.ptr340.1.sroa_idx, align 8, !dbg !119
  br label %if.end348, !dbg !120

if.end348:                                        ; preds = %for.cond325.preheader, %if.end316
  %K_reg.sroa.22.1 = phi <4 x half> [ %K_reg.sroa.22.0, %if.end316 ], [ %K_reg.sroa.22.16.copyload3383, %for.cond325.preheader ]
  %K_reg.sroa.14.1 = phi <4 x half> [ %K_reg.sroa.14.0, %if.end316 ], [ %K_reg.sroa.14.16.copyload3380, %for.cond325.preheader ]
  %K_reg.sroa.10.1 = phi <4 x half> [ %K_reg.sroa.10.0, %if.end316 ], [ %K_reg.sroa.10.0.copyload3371, %for.cond325.preheader ]
  %K_reg.sroa.0.1 = phi <4 x half> [ %K_reg.sroa.0.0, %if.end316 ], [ %K_reg.sroa.0.0.copyload3368, %for.cond325.preheader ]
  %or.cond2507 = icmp ugt i32 %mul11.3, 1023, !dbg !121
  %cmp355.not = icmp sgt i32 %mul11.3, %1
  %or.cond2508 = or i1 %or.cond2507, %cmp355.not, !dbg !121
  br i1 %or.cond2508, label %if.end380, label %for.cond357.preheader, !dbg !121

for.cond357.preheader:                            ; preds = %if.end348
  %mul362 = shl nsw i32 %0, 16
  %65 = shl nsw i32 %cond.i.i2368.3, 10
  %mul364 = and i32 %65, 64512
  %mul369 = shl nuw nsw i32 %18, 3
  %add365 = or disjoint i32 %mul369, %mul362
  %add367 = add nuw nsw i32 %add365, %mul364
  %66 = zext nneg i32 %add367 to i64, !dbg !122
  %add.ptr372 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %66, !dbg !123
  %K_reg1.sroa.0.0.copyload3344 = load <4 x half>, ptr addrspace(4) %add.ptr372, align 16, !dbg !124
  %K_reg1.sroa.10.0.add.ptr372.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr372, i64 8, !dbg !124
  %K_reg1.sroa.10.0.copyload3347 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.10.0.add.ptr372.sroa_idx, align 8, !dbg !124
  %67 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %66, !dbg !123
  %add.ptr372.1 = getelementptr inbounds i8, ptr addrspace(4) %67, i64 1024, !dbg !123
  %K_reg1.sroa.14.16.copyload3356 = load <4 x half>, ptr addrspace(4) %add.ptr372.1, align 16, !dbg !124
  %K_reg1.sroa.22.16.add.ptr372.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %67, i64 1032, !dbg !124
  %K_reg1.sroa.22.16.copyload3359 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.22.16.add.ptr372.1.sroa_idx, align 8, !dbg !124
  br label %if.end380, !dbg !125

if.end380:                                        ; preds = %for.cond357.preheader, %if.end348
  %K_reg1.sroa.22.1 = phi <4 x half> [ %K_reg1.sroa.22.0, %if.end348 ], [ %K_reg1.sroa.22.16.copyload3359, %for.cond357.preheader ]
  %K_reg1.sroa.14.1 = phi <4 x half> [ %K_reg1.sroa.14.0, %if.end348 ], [ %K_reg1.sroa.14.16.copyload3356, %for.cond357.preheader ]
  %K_reg1.sroa.10.1 = phi <4 x half> [ %K_reg1.sroa.10.0, %if.end348 ], [ %K_reg1.sroa.10.0.copyload3347, %for.cond357.preheader ]
  %K_reg1.sroa.0.1 = phi <4 x half> [ %K_reg1.sroa.0.0, %if.end348 ], [ %K_reg1.sroa.0.0.copyload3344, %for.cond357.preheader ]
  %or.cond2509 = icmp ult i32 %mul11.2, 1024, !dbg !125
  br i1 %or.cond2509, label %land.lhs.true384, label %if.end486, !dbg !125

land.lhs.true384:                                 ; preds = %if.end380
  br i1 %cmp323.not, label %if.end486, label %if.then387, !dbg !126

if.then387:                                       ; preds = %land.lhs.true384
  %add389 = or disjoint i32 %mul11.2, 15, !dbg !127
  %cmp390 = icmp ult i32 %1, %add389, !dbg !128
  br i1 %cmp390, label %for.cond392.preheader, label %if.end416, !dbg !129

for.cond392.preheader:                            ; preds = %if.then387
  %68 = lshr i32 %18, 2
  %mul398 = and i32 %68, 252
  %add399 = add nuw nsw i32 %mul11.2, %mul398
  %cmp402.not = icmp sgt i32 %add399, %1, !dbg !130
  %fneg.2354 = select i1 %cmp402.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3003 = insertelement <4 x float> poison, float %fneg.2354, i64 0, !dbg !131
  %cmp402.not.1.not = icmp slt i32 %add399, %1, !dbg !130
  %fneg.2354.1 = select i1 %cmp402.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3096 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3003, float %fneg.2354.1, i64 1, !dbg !131
  %add400.2 = or disjoint i32 %add399, 2, !dbg !132
  %cmp402.not.2 = icmp sgt i32 %add400.2, %1, !dbg !130
  %fneg.2354.2 = select i1 %cmp402.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3189 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3096, float %fneg.2354.2, i64 2, !dbg !131
  %add400.3 = or disjoint i32 %add399, 3, !dbg !132
  %cmp402.not.3 = icmp sgt i32 %add400.3, %1, !dbg !130
  %fneg.2354.3 = select i1 %cmp402.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3282 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3189, float %fneg.2354.3, i64 3, !dbg !131
  br label %if.end416

if.end416:                                        ; preds = %if.then387, %for.cond392.preheader
  %acc_s.sroa.0.4 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3282, %for.cond392.preheader ], [ zeroinitializer, %if.then387 ], !dbg !75
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.4), !dbg !133, !call_argsrelate !77
  %70 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.10.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %69), !dbg !133, !call_argsrelate !77
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.14.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %70), !dbg !133, !call_argsrelate !77
  %72 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.22.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %71), !dbg !133, !call_argsrelate !77
  %acc_s.sroa.0.0.vec.extract3005 = extractelement <4 x float> %72, i64 0, !dbg !134
  %mul451 = fmul contract float %acc_s.sroa.0.0.vec.extract3005, 0x3FB99999A0000000, !dbg !135
  %73 = tail call contract noundef float @llvm.minnum.f32(float %mul451, float 0x4024CB5EC0000000), !dbg !136
  %74 = tail call contract noundef float @llvm.exp.f32(float %73), !dbg !138
  %acc_s.sroa.0.4.vec.extract3098 = extractelement <4 x float> %72, i64 1, !dbg !134
  %mul451.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3098, 0x3FB99999A0000000, !dbg !135
  %75 = tail call contract noundef float @llvm.minnum.f32(float %mul451.1, float 0x4024CB5EC0000000), !dbg !136
  %76 = tail call contract noundef float @llvm.exp.f32(float %75), !dbg !138
  %acc_s.sroa.0.8.vec.extract3191 = extractelement <4 x float> %72, i64 2, !dbg !134
  %mul451.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3191, 0x3FB99999A0000000, !dbg !135
  %77 = tail call contract noundef float @llvm.minnum.f32(float %mul451.2, float 0x4024CB5EC0000000), !dbg !136
  %78 = tail call contract noundef float @llvm.exp.f32(float %77), !dbg !138
  %acc_s.sroa.0.12.vec.extract3284 = extractelement <4 x float> %72, i64 3, !dbg !134
  %mul451.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3284, 0x3FB99999A0000000, !dbg !135
  %79 = tail call contract noundef float @llvm.minnum.f32(float %mul451.3, float 0x4024CB5EC0000000), !dbg !136
  %80 = tail call contract noundef float @llvm.exp.f32(float %79), !dbg !138
  %add467 = fadd contract float %sum_acc.sroa.0.1, %74, !dbg !140
  %add467.1 = fadd contract float %sum_acc.sroa.20.1, %76, !dbg !140
  %add467.2 = fadd contract float %sum_acc.sroa.38.1, %78, !dbg !140
  %add467.3 = fadd contract float %sum_acc.sroa.56.1, %80, !dbg !140
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %74), !dbg !141
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %76), !dbg !141
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %78), !dbg !141
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %80), !dbg !141
  br label %if.end486, !dbg !145

if.end486:                                        ; preds = %if.end416, %land.lhs.true384, %if.end380
  %sum_acc.sroa.56.2 = phi float [ %sum_acc.sroa.56.1, %land.lhs.true384 ], [ %add467.3, %if.end416 ], [ %sum_acc.sroa.56.1, %if.end380 ], !dbg !75
  %sum_acc.sroa.38.2 = phi float [ %sum_acc.sroa.38.1, %land.lhs.true384 ], [ %add467.2, %if.end416 ], [ %sum_acc.sroa.38.1, %if.end380 ], !dbg !75
  %sum_acc.sroa.20.2 = phi float [ %sum_acc.sroa.20.1, %land.lhs.true384 ], [ %add467.1, %if.end416 ], [ %sum_acc.sroa.20.1, %if.end380 ], !dbg !75
  %sum_acc.sroa.0.2 = phi float [ %sum_acc.sroa.0.1, %land.lhs.true384 ], [ %add467, %if.end416 ], [ %sum_acc.sroa.0.1, %if.end380 ], !dbg !75
  %phase_weights.sroa.24.0 = phi i16 [ undef, %land.lhs.true384 ], [ %84, %if.end416 ], [ undef, %if.end380 ]
  %phase_weights.sroa.22.0 = phi i16 [ undef, %land.lhs.true384 ], [ %83, %if.end416 ], [ undef, %if.end380 ]
  %phase_weights.sroa.20.0 = phi i16 [ undef, %land.lhs.true384 ], [ %82, %if.end416 ], [ undef, %if.end380 ]
  %phase_weights.sroa.18.0 = phi i16 [ undef, %land.lhs.true384 ], [ %81, %if.end416 ], [ undef, %if.end380 ]
  %or.cond2510 = icmp ult i32 %mul11.3, 1024, !dbg !145
  br i1 %or.cond2510, label %land.lhs.true490, label %if.end592, !dbg !145

land.lhs.true490:                                 ; preds = %if.end486
  br i1 %cmp355.not, label %if.end592, label %if.then493, !dbg !146

if.then493:                                       ; preds = %land.lhs.true490
  %add495 = or disjoint i32 %mul11.3, 15, !dbg !147
  %cmp496 = icmp ult i32 %1, %add495, !dbg !148
  br i1 %cmp496, label %for.cond498.preheader, label %if.end522, !dbg !149

for.cond498.preheader:                            ; preds = %if.then493
  %85 = lshr i32 %18, 2
  %mul504 = and i32 %85, 252
  %add505 = add nuw nsw i32 %mul11.3, %mul504
  %cmp508.not = icmp sgt i32 %add505, %1, !dbg !150
  %fneg.2355 = select i1 %cmp508.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3013 = insertelement <4 x float> poison, float %fneg.2355, i64 0, !dbg !151
  %cmp508.not.1.not = icmp slt i32 %add505, %1, !dbg !150
  %fneg.2355.1 = select i1 %cmp508.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3106 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3013, float %fneg.2355.1, i64 1, !dbg !151
  %add506.2 = or disjoint i32 %add505, 2, !dbg !152
  %cmp508.not.2 = icmp sgt i32 %add506.2, %1, !dbg !150
  %fneg.2355.2 = select i1 %cmp508.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3199 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3106, float %fneg.2355.2, i64 2, !dbg !151
  %add506.3 = or disjoint i32 %add505, 3, !dbg !152
  %cmp508.not.3 = icmp sgt i32 %add506.3, %1, !dbg !150
  %fneg.2355.3 = select i1 %cmp508.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3292 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3199, float %fneg.2355.3, i64 3, !dbg !151
  br label %if.end522

if.end522:                                        ; preds = %if.then493, %for.cond498.preheader
  %acc_s.sroa.0.6 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3292, %for.cond498.preheader ], [ zeroinitializer, %if.then493 ], !dbg !75
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.6), !dbg !153, !call_argsrelate !77
  %87 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.10.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %86), !dbg !153, !call_argsrelate !77
  %88 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.14.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %87), !dbg !153, !call_argsrelate !77
  %89 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.22.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %88), !dbg !153, !call_argsrelate !77
  %acc_s.sroa.0.0.vec.extract3015 = extractelement <4 x float> %89, i64 0, !dbg !154
  %mul557 = fmul contract float %acc_s.sroa.0.0.vec.extract3015, 0x3FB99999A0000000, !dbg !155
  %90 = tail call contract noundef float @llvm.minnum.f32(float %mul557, float 0x4024CB5EC0000000), !dbg !156
  %91 = tail call contract noundef float @llvm.exp.f32(float %90), !dbg !158
  %acc_s.sroa.0.4.vec.extract3108 = extractelement <4 x float> %89, i64 1, !dbg !154
  %mul557.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3108, 0x3FB99999A0000000, !dbg !155
  %92 = tail call contract noundef float @llvm.minnum.f32(float %mul557.1, float 0x4024CB5EC0000000), !dbg !156
  %93 = tail call contract noundef float @llvm.exp.f32(float %92), !dbg !158
  %acc_s.sroa.0.8.vec.extract3201 = extractelement <4 x float> %89, i64 2, !dbg !154
  %mul557.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3201, 0x3FB99999A0000000, !dbg !155
  %94 = tail call contract noundef float @llvm.minnum.f32(float %mul557.2, float 0x4024CB5EC0000000), !dbg !156
  %95 = tail call contract noundef float @llvm.exp.f32(float %94), !dbg !158
  %acc_s.sroa.0.12.vec.extract3294 = extractelement <4 x float> %89, i64 3, !dbg !154
  %mul557.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3294, 0x3FB99999A0000000, !dbg !155
  %96 = tail call contract noundef float @llvm.minnum.f32(float %mul557.3, float 0x4024CB5EC0000000), !dbg !156
  %97 = tail call contract noundef float @llvm.exp.f32(float %96), !dbg !158
  %add573 = fadd contract float %sum_acc.sroa.0.2, %91, !dbg !160
  %add573.1 = fadd contract float %sum_acc.sroa.20.2, %93, !dbg !160
  %add573.2 = fadd contract float %sum_acc.sroa.38.2, %95, !dbg !160
  %add573.3 = fadd contract float %sum_acc.sroa.56.2, %97, !dbg !160
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %91), !dbg !161
  %99 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %93), !dbg !161
  %100 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %95), !dbg !161
  %101 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %97), !dbg !161
  br label %if.end592, !dbg !165

if.end592:                                        ; preds = %if.end522, %land.lhs.true490, %if.end486
  %sum_acc.sroa.56.3 = phi float [ %sum_acc.sroa.56.2, %land.lhs.true490 ], [ %add573.3, %if.end522 ], [ %sum_acc.sroa.56.2, %if.end486 ], !dbg !75
  %sum_acc.sroa.38.3 = phi float [ %sum_acc.sroa.38.2, %land.lhs.true490 ], [ %add573.2, %if.end522 ], [ %sum_acc.sroa.38.2, %if.end486 ], !dbg !75
  %sum_acc.sroa.20.3 = phi float [ %sum_acc.sroa.20.2, %land.lhs.true490 ], [ %add573.1, %if.end522 ], [ %sum_acc.sroa.20.2, %if.end486 ], !dbg !75
  %sum_acc.sroa.0.3 = phi float [ %sum_acc.sroa.0.2, %land.lhs.true490 ], [ %add573, %if.end522 ], [ %sum_acc.sroa.0.2, %if.end486 ], !dbg !75
  %phase_weights.sroa.32.0 = phi i16 [ undef, %land.lhs.true490 ], [ %101, %if.end522 ], [ undef, %if.end486 ]
  %phase_weights.sroa.30.0 = phi i16 [ undef, %land.lhs.true490 ], [ %100, %if.end522 ], [ undef, %if.end486 ]
  %phase_weights.sroa.28.0 = phi i16 [ undef, %land.lhs.true490 ], [ %99, %if.end522 ], [ undef, %if.end486 ]
  %phase_weights.sroa.26.0 = phi i16 [ undef, %land.lhs.true490 ], [ %98, %if.end522 ], [ undef, %if.end486 ]
  %or.cond2511 = icmp ugt i32 %mul11.4, 1023, !dbg !166
  %cmp599.not = icmp sgt i32 %mul11.4, %1
  %or.cond2512 = or i1 %or.cond2511, %cmp599.not, !dbg !166
  br i1 %or.cond2512, label %if.end624, label %for.cond601.preheader, !dbg !166

for.cond601.preheader:                            ; preds = %if.end592
  %mul606 = shl nsw i32 %0, 16
  %102 = shl nsw i32 %cond.i.i2368.4, 10
  %mul608 = and i32 %102, 64512
  %mul613 = shl nuw nsw i32 %18, 3
  %add609 = or disjoint i32 %mul613, %mul606
  %add611 = add nuw nsw i32 %add609, %mul608
  %103 = zext nneg i32 %add611 to i64, !dbg !167
  %add.ptr616 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %103, !dbg !168
  %K_reg.sroa.0.0.copyload3369 = load <4 x half>, ptr addrspace(4) %add.ptr616, align 16, !dbg !169
  %K_reg.sroa.10.0.add.ptr616.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr616, i64 8, !dbg !169
  %K_reg.sroa.10.0.copyload3372 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.10.0.add.ptr616.sroa_idx, align 8, !dbg !169
  %104 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %103, !dbg !168
  %add.ptr616.1 = getelementptr inbounds i8, ptr addrspace(4) %104, i64 1024, !dbg !168
  %K_reg.sroa.14.16.copyload3381 = load <4 x half>, ptr addrspace(4) %add.ptr616.1, align 16, !dbg !169
  %K_reg.sroa.22.16.add.ptr616.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %104, i64 1032, !dbg !169
  %K_reg.sroa.22.16.copyload3384 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.22.16.add.ptr616.1.sroa_idx, align 8, !dbg !169
  br label %if.end624, !dbg !170

if.end624:                                        ; preds = %for.cond601.preheader, %if.end592
  %K_reg.sroa.22.2 = phi <4 x half> [ %K_reg.sroa.22.1, %if.end592 ], [ %K_reg.sroa.22.16.copyload3384, %for.cond601.preheader ]
  %K_reg.sroa.14.2 = phi <4 x half> [ %K_reg.sroa.14.1, %if.end592 ], [ %K_reg.sroa.14.16.copyload3381, %for.cond601.preheader ]
  %K_reg.sroa.10.2 = phi <4 x half> [ %K_reg.sroa.10.1, %if.end592 ], [ %K_reg.sroa.10.0.copyload3372, %for.cond601.preheader ]
  %K_reg.sroa.0.2 = phi <4 x half> [ %K_reg.sroa.0.1, %if.end592 ], [ %K_reg.sroa.0.0.copyload3369, %for.cond601.preheader ]
  %or.cond2513 = icmp ugt i32 %mul11.5, 1023, !dbg !171
  %cmp631.not = icmp sgt i32 %mul11.5, %1
  %or.cond2514 = or i1 %or.cond2513, %cmp631.not, !dbg !171
  br i1 %or.cond2514, label %if.end656, label %for.cond633.preheader, !dbg !171

for.cond633.preheader:                            ; preds = %if.end624
  %mul638 = shl nsw i32 %0, 16
  %105 = shl nsw i32 %cond.i.i2368.5, 10
  %mul640 = and i32 %105, 64512
  %mul645 = shl nuw nsw i32 %18, 3
  %add641 = or disjoint i32 %mul645, %mul638
  %add643 = add nuw nsw i32 %add641, %mul640
  %106 = zext nneg i32 %add643 to i64, !dbg !172
  %add.ptr648 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %106, !dbg !173
  %K_reg1.sroa.0.0.copyload3345 = load <4 x half>, ptr addrspace(4) %add.ptr648, align 16, !dbg !174
  %K_reg1.sroa.10.0.add.ptr648.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr648, i64 8, !dbg !174
  %K_reg1.sroa.10.0.copyload3348 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.10.0.add.ptr648.sroa_idx, align 8, !dbg !174
  %107 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %106, !dbg !173
  %add.ptr648.1 = getelementptr inbounds i8, ptr addrspace(4) %107, i64 1024, !dbg !173
  %K_reg1.sroa.14.16.copyload3357 = load <4 x half>, ptr addrspace(4) %add.ptr648.1, align 16, !dbg !174
  %K_reg1.sroa.22.16.add.ptr648.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %107, i64 1032, !dbg !174
  %K_reg1.sroa.22.16.copyload3360 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.22.16.add.ptr648.1.sroa_idx, align 8, !dbg !174
  br label %if.end656, !dbg !175

if.end656:                                        ; preds = %for.cond633.preheader, %if.end624
  %K_reg1.sroa.22.2 = phi <4 x half> [ %K_reg1.sroa.22.1, %if.end624 ], [ %K_reg1.sroa.22.16.copyload3360, %for.cond633.preheader ]
  %K_reg1.sroa.14.2 = phi <4 x half> [ %K_reg1.sroa.14.1, %if.end624 ], [ %K_reg1.sroa.14.16.copyload3357, %for.cond633.preheader ]
  %K_reg1.sroa.10.2 = phi <4 x half> [ %K_reg1.sroa.10.1, %if.end624 ], [ %K_reg1.sroa.10.0.copyload3348, %for.cond633.preheader ]
  %K_reg1.sroa.0.2 = phi <4 x half> [ %K_reg1.sroa.0.1, %if.end624 ], [ %K_reg1.sroa.0.0.copyload3345, %for.cond633.preheader ]
  %or.cond2515 = icmp ult i32 %mul11.4, 1024, !dbg !175
  br i1 %or.cond2515, label %land.lhs.true660, label %if.end762, !dbg !175

land.lhs.true660:                                 ; preds = %if.end656
  br i1 %cmp599.not, label %if.end762, label %if.then663, !dbg !176

if.then663:                                       ; preds = %land.lhs.true660
  %add665 = or disjoint i32 %mul11.4, 15, !dbg !177
  %cmp666 = icmp ult i32 %1, %add665, !dbg !178
  br i1 %cmp666, label %for.cond668.preheader, label %if.end692, !dbg !179

for.cond668.preheader:                            ; preds = %if.then663
  %108 = lshr i32 %18, 2
  %mul674 = and i32 %108, 252
  %add675 = add nuw nsw i32 %mul11.4, %mul674
  %cmp678.not = icmp sgt i32 %add675, %1, !dbg !180
  %fneg.2356 = select i1 %cmp678.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3023 = insertelement <4 x float> poison, float %fneg.2356, i64 0, !dbg !181
  %cmp678.not.1.not = icmp slt i32 %add675, %1, !dbg !180
  %fneg.2356.1 = select i1 %cmp678.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3116 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3023, float %fneg.2356.1, i64 1, !dbg !181
  %add676.2 = or disjoint i32 %add675, 2, !dbg !182
  %cmp678.not.2 = icmp sgt i32 %add676.2, %1, !dbg !180
  %fneg.2356.2 = select i1 %cmp678.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3209 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3116, float %fneg.2356.2, i64 2, !dbg !181
  %add676.3 = or disjoint i32 %add675, 3, !dbg !182
  %cmp678.not.3 = icmp sgt i32 %add676.3, %1, !dbg !180
  %fneg.2356.3 = select i1 %cmp678.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3302 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3209, float %fneg.2356.3, i64 3, !dbg !181
  br label %if.end692

if.end692:                                        ; preds = %if.then663, %for.cond668.preheader
  %acc_s.sroa.0.8 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3302, %for.cond668.preheader ], [ zeroinitializer, %if.then663 ], !dbg !75
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.2, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.8), !dbg !183, !call_argsrelate !77
  %110 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.10.2, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %109), !dbg !183, !call_argsrelate !77
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.14.2, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %110), !dbg !183, !call_argsrelate !77
  %112 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.22.2, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %111), !dbg !183, !call_argsrelate !77
  %acc_s.sroa.0.0.vec.extract3025 = extractelement <4 x float> %112, i64 0, !dbg !184
  %mul727 = fmul contract float %acc_s.sroa.0.0.vec.extract3025, 0x3FB99999A0000000, !dbg !185
  %113 = tail call contract noundef float @llvm.minnum.f32(float %mul727, float 0x4024CB5EC0000000), !dbg !186
  %114 = tail call contract noundef float @llvm.exp.f32(float %113), !dbg !188
  %acc_s.sroa.0.4.vec.extract3118 = extractelement <4 x float> %112, i64 1, !dbg !184
  %mul727.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3118, 0x3FB99999A0000000, !dbg !185
  %115 = tail call contract noundef float @llvm.minnum.f32(float %mul727.1, float 0x4024CB5EC0000000), !dbg !186
  %116 = tail call contract noundef float @llvm.exp.f32(float %115), !dbg !188
  %acc_s.sroa.0.8.vec.extract3211 = extractelement <4 x float> %112, i64 2, !dbg !184
  %mul727.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3211, 0x3FB99999A0000000, !dbg !185
  %117 = tail call contract noundef float @llvm.minnum.f32(float %mul727.2, float 0x4024CB5EC0000000), !dbg !186
  %118 = tail call contract noundef float @llvm.exp.f32(float %117), !dbg !188
  %acc_s.sroa.0.12.vec.extract3304 = extractelement <4 x float> %112, i64 3, !dbg !184
  %mul727.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3304, 0x3FB99999A0000000, !dbg !185
  %119 = tail call contract noundef float @llvm.minnum.f32(float %mul727.3, float 0x4024CB5EC0000000), !dbg !186
  %120 = tail call contract noundef float @llvm.exp.f32(float %119), !dbg !188
  %add743 = fadd contract float %sum_acc.sroa.0.3, %114, !dbg !190
  %add743.1 = fadd contract float %sum_acc.sroa.20.3, %116, !dbg !190
  %add743.2 = fadd contract float %sum_acc.sroa.38.3, %118, !dbg !190
  %add743.3 = fadd contract float %sum_acc.sroa.56.3, %120, !dbg !190
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %114), !dbg !191
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %116), !dbg !191
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %118), !dbg !191
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %120), !dbg !191
  br label %if.end762, !dbg !195

if.end762:                                        ; preds = %if.end692, %land.lhs.true660, %if.end656
  %sum_acc.sroa.56.4 = phi float [ %sum_acc.sroa.56.3, %land.lhs.true660 ], [ %add743.3, %if.end692 ], [ %sum_acc.sroa.56.3, %if.end656 ], !dbg !75
  %sum_acc.sroa.38.4 = phi float [ %sum_acc.sroa.38.3, %land.lhs.true660 ], [ %add743.2, %if.end692 ], [ %sum_acc.sroa.38.3, %if.end656 ], !dbg !75
  %sum_acc.sroa.20.4 = phi float [ %sum_acc.sroa.20.3, %land.lhs.true660 ], [ %add743.1, %if.end692 ], [ %sum_acc.sroa.20.3, %if.end656 ], !dbg !75
  %sum_acc.sroa.0.4 = phi float [ %sum_acc.sroa.0.3, %land.lhs.true660 ], [ %add743, %if.end692 ], [ %sum_acc.sroa.0.3, %if.end656 ], !dbg !75
  %phase_weights.sroa.40.0 = phi i16 [ undef, %land.lhs.true660 ], [ %124, %if.end692 ], [ undef, %if.end656 ]
  %phase_weights.sroa.38.0 = phi i16 [ undef, %land.lhs.true660 ], [ %123, %if.end692 ], [ undef, %if.end656 ]
  %phase_weights.sroa.36.0 = phi i16 [ undef, %land.lhs.true660 ], [ %122, %if.end692 ], [ undef, %if.end656 ]
  %phase_weights.sroa.34.0 = phi i16 [ undef, %land.lhs.true660 ], [ %121, %if.end692 ], [ undef, %if.end656 ]
  %or.cond2516 = icmp ult i32 %mul11.5, 1024, !dbg !195
  br i1 %or.cond2516, label %land.lhs.true766, label %if.end868, !dbg !195

land.lhs.true766:                                 ; preds = %if.end762
  br i1 %cmp631.not, label %if.end868, label %if.then769, !dbg !196

if.then769:                                       ; preds = %land.lhs.true766
  %add771 = or disjoint i32 %mul11.5, 15, !dbg !197
  %cmp772 = icmp ult i32 %1, %add771, !dbg !198
  br i1 %cmp772, label %for.cond774.preheader, label %if.end798, !dbg !199

for.cond774.preheader:                            ; preds = %if.then769
  %125 = lshr i32 %18, 2
  %mul780 = and i32 %125, 252
  %add781 = add nuw nsw i32 %mul11.5, %mul780
  %cmp784.not = icmp sgt i32 %add781, %1, !dbg !200
  %fneg.2357 = select i1 %cmp784.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3033 = insertelement <4 x float> poison, float %fneg.2357, i64 0, !dbg !201
  %cmp784.not.1.not = icmp slt i32 %add781, %1, !dbg !200
  %fneg.2357.1 = select i1 %cmp784.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3126 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3033, float %fneg.2357.1, i64 1, !dbg !201
  %add782.2 = or disjoint i32 %add781, 2, !dbg !202
  %cmp784.not.2 = icmp sgt i32 %add782.2, %1, !dbg !200
  %fneg.2357.2 = select i1 %cmp784.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3219 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3126, float %fneg.2357.2, i64 2, !dbg !201
  %add782.3 = or disjoint i32 %add781, 3, !dbg !202
  %cmp784.not.3 = icmp sgt i32 %add782.3, %1, !dbg !200
  %fneg.2357.3 = select i1 %cmp784.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3312 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3219, float %fneg.2357.3, i64 3, !dbg !201
  br label %if.end798

if.end798:                                        ; preds = %if.then769, %for.cond774.preheader
  %acc_s.sroa.0.10 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3312, %for.cond774.preheader ], [ zeroinitializer, %if.then769 ], !dbg !75
  %126 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.2, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.10), !dbg !203, !call_argsrelate !77
  %127 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.10.2, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %126), !dbg !203, !call_argsrelate !77
  %128 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.14.2, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %127), !dbg !203, !call_argsrelate !77
  %129 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.22.2, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %128), !dbg !203, !call_argsrelate !77
  %acc_s.sroa.0.0.vec.extract3035 = extractelement <4 x float> %129, i64 0, !dbg !204
  %mul833 = fmul contract float %acc_s.sroa.0.0.vec.extract3035, 0x3FB99999A0000000, !dbg !205
  %130 = tail call contract noundef float @llvm.minnum.f32(float %mul833, float 0x4024CB5EC0000000), !dbg !206
  %131 = tail call contract noundef float @llvm.exp.f32(float %130), !dbg !208
  %acc_s.sroa.0.4.vec.extract3128 = extractelement <4 x float> %129, i64 1, !dbg !204
  %mul833.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3128, 0x3FB99999A0000000, !dbg !205
  %132 = tail call contract noundef float @llvm.minnum.f32(float %mul833.1, float 0x4024CB5EC0000000), !dbg !206
  %133 = tail call contract noundef float @llvm.exp.f32(float %132), !dbg !208
  %acc_s.sroa.0.8.vec.extract3221 = extractelement <4 x float> %129, i64 2, !dbg !204
  %mul833.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3221, 0x3FB99999A0000000, !dbg !205
  %134 = tail call contract noundef float @llvm.minnum.f32(float %mul833.2, float 0x4024CB5EC0000000), !dbg !206
  %135 = tail call contract noundef float @llvm.exp.f32(float %134), !dbg !208
  %acc_s.sroa.0.12.vec.extract3314 = extractelement <4 x float> %129, i64 3, !dbg !204
  %mul833.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3314, 0x3FB99999A0000000, !dbg !205
  %136 = tail call contract noundef float @llvm.minnum.f32(float %mul833.3, float 0x4024CB5EC0000000), !dbg !206
  %137 = tail call contract noundef float @llvm.exp.f32(float %136), !dbg !208
  %add849 = fadd contract float %sum_acc.sroa.0.4, %131, !dbg !210
  %add849.1 = fadd contract float %sum_acc.sroa.20.4, %133, !dbg !210
  %add849.2 = fadd contract float %sum_acc.sroa.38.4, %135, !dbg !210
  %add849.3 = fadd contract float %sum_acc.sroa.56.4, %137, !dbg !210
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %131), !dbg !211
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %133), !dbg !211
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %135), !dbg !211
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %137), !dbg !211
  br label %if.end868, !dbg !215

if.end868:                                        ; preds = %if.end798, %land.lhs.true766, %if.end762
  %sum_acc.sroa.56.5 = phi float [ %sum_acc.sroa.56.4, %land.lhs.true766 ], [ %add849.3, %if.end798 ], [ %sum_acc.sroa.56.4, %if.end762 ], !dbg !75
  %sum_acc.sroa.38.5 = phi float [ %sum_acc.sroa.38.4, %land.lhs.true766 ], [ %add849.2, %if.end798 ], [ %sum_acc.sroa.38.4, %if.end762 ], !dbg !75
  %sum_acc.sroa.20.5 = phi float [ %sum_acc.sroa.20.4, %land.lhs.true766 ], [ %add849.1, %if.end798 ], [ %sum_acc.sroa.20.4, %if.end762 ], !dbg !75
  %sum_acc.sroa.0.5 = phi float [ %sum_acc.sroa.0.4, %land.lhs.true766 ], [ %add849, %if.end798 ], [ %sum_acc.sroa.0.4, %if.end762 ], !dbg !75
  %phase_weights.sroa.48.0 = phi i16 [ undef, %land.lhs.true766 ], [ %141, %if.end798 ], [ undef, %if.end762 ]
  %phase_weights.sroa.46.0 = phi i16 [ undef, %land.lhs.true766 ], [ %140, %if.end798 ], [ undef, %if.end762 ]
  %phase_weights.sroa.44.0 = phi i16 [ undef, %land.lhs.true766 ], [ %139, %if.end798 ], [ undef, %if.end762 ]
  %phase_weights.sroa.42.0 = phi i16 [ undef, %land.lhs.true766 ], [ %138, %if.end798 ], [ undef, %if.end762 ]
  %or.cond2517 = icmp ugt i32 %mul11.6, 1023, !dbg !216
  %cmp875.not = icmp sgt i32 %mul11.6, %1
  %or.cond2518 = or i1 %or.cond2517, %cmp875.not, !dbg !216
  br i1 %or.cond2518, label %if.end900, label %for.cond877.preheader, !dbg !216

for.cond877.preheader:                            ; preds = %if.end868
  %mul882 = shl nsw i32 %0, 16
  %142 = shl nsw i32 %cond.i.i2368.6, 10
  %mul884 = and i32 %142, 64512
  %mul889 = shl nuw nsw i32 %18, 3
  %add885 = or disjoint i32 %mul889, %mul882
  %add887 = add nuw nsw i32 %add885, %mul884
  %143 = zext nneg i32 %add887 to i64, !dbg !217
  %add.ptr892 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %143, !dbg !218
  %K_reg.sroa.0.0.copyload3370 = load <4 x half>, ptr addrspace(4) %add.ptr892, align 16, !dbg !219
  %K_reg.sroa.10.0.add.ptr892.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr892, i64 8, !dbg !219
  %K_reg.sroa.10.0.copyload3373 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.10.0.add.ptr892.sroa_idx, align 8, !dbg !219
  %144 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %143, !dbg !218
  %add.ptr892.1 = getelementptr inbounds i8, ptr addrspace(4) %144, i64 1024, !dbg !218
  %K_reg.sroa.14.16.copyload3382 = load <4 x half>, ptr addrspace(4) %add.ptr892.1, align 16, !dbg !219
  %K_reg.sroa.22.16.add.ptr892.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %144, i64 1032, !dbg !219
  %K_reg.sroa.22.16.copyload3385 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.22.16.add.ptr892.1.sroa_idx, align 8, !dbg !219
  br label %if.end900, !dbg !220

if.end900:                                        ; preds = %for.cond877.preheader, %if.end868
  %K_reg.sroa.22.3 = phi <4 x half> [ %K_reg.sroa.22.2, %if.end868 ], [ %K_reg.sroa.22.16.copyload3385, %for.cond877.preheader ]
  %K_reg.sroa.14.3 = phi <4 x half> [ %K_reg.sroa.14.2, %if.end868 ], [ %K_reg.sroa.14.16.copyload3382, %for.cond877.preheader ]
  %K_reg.sroa.10.3 = phi <4 x half> [ %K_reg.sroa.10.2, %if.end868 ], [ %K_reg.sroa.10.0.copyload3373, %for.cond877.preheader ]
  %K_reg.sroa.0.3 = phi <4 x half> [ %K_reg.sroa.0.2, %if.end868 ], [ %K_reg.sroa.0.0.copyload3370, %for.cond877.preheader ]
  %or.cond2519 = icmp ugt i32 %mul11.7, 1023, !dbg !221
  %cmp907.not = icmp sgt i32 %mul11.7, %1
  %or.cond2520 = or i1 %or.cond2519, %cmp907.not, !dbg !221
  br i1 %or.cond2520, label %if.end932, label %for.cond909.preheader, !dbg !221

for.cond909.preheader:                            ; preds = %if.end900
  %mul914 = shl nsw i32 %0, 16
  %145 = shl nsw i32 %cond.i.i2368.7, 10
  %mul916 = and i32 %145, 64512
  %mul921 = shl nuw nsw i32 %18, 3
  %add917 = or disjoint i32 %mul921, %mul914
  %add919 = add nuw nsw i32 %add917, %mul916
  %146 = zext nneg i32 %add919 to i64, !dbg !222
  %add.ptr924 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %146, !dbg !223
  %K_reg1.sroa.0.0.copyload3346 = load <4 x half>, ptr addrspace(4) %add.ptr924, align 16, !dbg !224
  %K_reg1.sroa.10.0.add.ptr924.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr924, i64 8, !dbg !224
  %K_reg1.sroa.10.0.copyload3349 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.10.0.add.ptr924.sroa_idx, align 8, !dbg !224
  %147 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %146, !dbg !223
  %add.ptr924.1 = getelementptr inbounds i8, ptr addrspace(4) %147, i64 1024, !dbg !223
  %K_reg1.sroa.14.16.copyload3358 = load <4 x half>, ptr addrspace(4) %add.ptr924.1, align 16, !dbg !224
  %K_reg1.sroa.22.16.add.ptr924.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %147, i64 1032, !dbg !224
  %K_reg1.sroa.22.16.copyload3361 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.22.16.add.ptr924.1.sroa_idx, align 8, !dbg !224
  br label %if.end932, !dbg !225

if.end932:                                        ; preds = %for.cond909.preheader, %if.end900
  %K_reg1.sroa.22.3 = phi <4 x half> [ %K_reg1.sroa.22.2, %if.end900 ], [ %K_reg1.sroa.22.16.copyload3361, %for.cond909.preheader ]
  %K_reg1.sroa.14.3 = phi <4 x half> [ %K_reg1.sroa.14.2, %if.end900 ], [ %K_reg1.sroa.14.16.copyload3358, %for.cond909.preheader ]
  %K_reg1.sroa.10.3 = phi <4 x half> [ %K_reg1.sroa.10.2, %if.end900 ], [ %K_reg1.sroa.10.0.copyload3349, %for.cond909.preheader ]
  %K_reg1.sroa.0.3 = phi <4 x half> [ %K_reg1.sroa.0.2, %if.end900 ], [ %K_reg1.sroa.0.0.copyload3346, %for.cond909.preheader ]
  %or.cond2521 = icmp ult i32 %mul11.6, 1024, !dbg !225
  br i1 %or.cond2521, label %land.lhs.true936, label %if.end1038, !dbg !225

land.lhs.true936:                                 ; preds = %if.end932
  br i1 %cmp875.not, label %if.end1038, label %if.then939, !dbg !226

if.then939:                                       ; preds = %land.lhs.true936
  %add941 = or disjoint i32 %mul11.6, 15, !dbg !227
  %cmp942 = icmp ult i32 %1, %add941, !dbg !228
  br i1 %cmp942, label %for.cond944.preheader, label %if.end968, !dbg !229

for.cond944.preheader:                            ; preds = %if.then939
  %148 = lshr i32 %18, 2
  %mul950 = and i32 %148, 252
  %add951 = add nuw nsw i32 %mul11.6, %mul950
  %cmp954.not = icmp sgt i32 %add951, %1, !dbg !230
  %fneg.2358 = select i1 %cmp954.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3043 = insertelement <4 x float> poison, float %fneg.2358, i64 0, !dbg !231
  %cmp954.not.1.not = icmp slt i32 %add951, %1, !dbg !230
  %fneg.2358.1 = select i1 %cmp954.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3136 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3043, float %fneg.2358.1, i64 1, !dbg !231
  %add952.2 = or disjoint i32 %add951, 2, !dbg !232
  %cmp954.not.2 = icmp sgt i32 %add952.2, %1, !dbg !230
  %fneg.2358.2 = select i1 %cmp954.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3229 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3136, float %fneg.2358.2, i64 2, !dbg !231
  %add952.3 = or disjoint i32 %add951, 3, !dbg !232
  %cmp954.not.3 = icmp sgt i32 %add952.3, %1, !dbg !230
  %fneg.2358.3 = select i1 %cmp954.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3322 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3229, float %fneg.2358.3, i64 3, !dbg !231
  br label %if.end968

if.end968:                                        ; preds = %if.then939, %for.cond944.preheader
  %acc_s.sroa.0.12 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3322, %for.cond944.preheader ], [ zeroinitializer, %if.then939 ], !dbg !75
  %149 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.3, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.12), !dbg !233, !call_argsrelate !77
  %150 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.10.3, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %149), !dbg !233, !call_argsrelate !77
  %151 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.14.3, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %150), !dbg !233, !call_argsrelate !77
  %152 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.22.3, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %151), !dbg !233, !call_argsrelate !77
  %acc_s.sroa.0.0.vec.extract3045 = extractelement <4 x float> %152, i64 0, !dbg !234
  %mul1003 = fmul contract float %acc_s.sroa.0.0.vec.extract3045, 0x3FB99999A0000000, !dbg !235
  %153 = tail call contract noundef float @llvm.minnum.f32(float %mul1003, float 0x4024CB5EC0000000), !dbg !236
  %154 = tail call contract noundef float @llvm.exp.f32(float %153), !dbg !238
  %acc_s.sroa.0.4.vec.extract3138 = extractelement <4 x float> %152, i64 1, !dbg !234
  %mul1003.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3138, 0x3FB99999A0000000, !dbg !235
  %155 = tail call contract noundef float @llvm.minnum.f32(float %mul1003.1, float 0x4024CB5EC0000000), !dbg !236
  %156 = tail call contract noundef float @llvm.exp.f32(float %155), !dbg !238
  %acc_s.sroa.0.8.vec.extract3231 = extractelement <4 x float> %152, i64 2, !dbg !234
  %mul1003.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3231, 0x3FB99999A0000000, !dbg !235
  %157 = tail call contract noundef float @llvm.minnum.f32(float %mul1003.2, float 0x4024CB5EC0000000), !dbg !236
  %158 = tail call contract noundef float @llvm.exp.f32(float %157), !dbg !238
  %acc_s.sroa.0.12.vec.extract3324 = extractelement <4 x float> %152, i64 3, !dbg !234
  %mul1003.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3324, 0x3FB99999A0000000, !dbg !235
  %159 = tail call contract noundef float @llvm.minnum.f32(float %mul1003.3, float 0x4024CB5EC0000000), !dbg !236
  %160 = tail call contract noundef float @llvm.exp.f32(float %159), !dbg !238
  %add1019 = fadd contract float %sum_acc.sroa.0.5, %154, !dbg !240
  %add1019.1 = fadd contract float %sum_acc.sroa.20.5, %156, !dbg !240
  %add1019.2 = fadd contract float %sum_acc.sroa.38.5, %158, !dbg !240
  %add1019.3 = fadd contract float %sum_acc.sroa.56.5, %160, !dbg !240
  %161 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %154), !dbg !241
  %162 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %156), !dbg !241
  %163 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %158), !dbg !241
  %164 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %160), !dbg !241
  br label %if.end1038, !dbg !245

if.end1038:                                       ; preds = %if.end968, %land.lhs.true936, %if.end932
  %sum_acc.sroa.56.6 = phi float [ %sum_acc.sroa.56.5, %land.lhs.true936 ], [ %add1019.3, %if.end968 ], [ %sum_acc.sroa.56.5, %if.end932 ], !dbg !75
  %sum_acc.sroa.38.6 = phi float [ %sum_acc.sroa.38.5, %land.lhs.true936 ], [ %add1019.2, %if.end968 ], [ %sum_acc.sroa.38.5, %if.end932 ], !dbg !75
  %sum_acc.sroa.20.6 = phi float [ %sum_acc.sroa.20.5, %land.lhs.true936 ], [ %add1019.1, %if.end968 ], [ %sum_acc.sroa.20.5, %if.end932 ], !dbg !75
  %sum_acc.sroa.0.6 = phi float [ %sum_acc.sroa.0.5, %land.lhs.true936 ], [ %add1019, %if.end968 ], [ %sum_acc.sroa.0.5, %if.end932 ], !dbg !75
  %phase_weights.sroa.56.0 = phi i16 [ undef, %land.lhs.true936 ], [ %164, %if.end968 ], [ undef, %if.end932 ]
  %phase_weights.sroa.54.0 = phi i16 [ undef, %land.lhs.true936 ], [ %163, %if.end968 ], [ undef, %if.end932 ]
  %phase_weights.sroa.52.0 = phi i16 [ undef, %land.lhs.true936 ], [ %162, %if.end968 ], [ undef, %if.end932 ]
  %phase_weights.sroa.50.0 = phi i16 [ undef, %land.lhs.true936 ], [ %161, %if.end968 ], [ undef, %if.end932 ]
  %or.cond2522 = icmp ult i32 %mul11.7, 1024, !dbg !245
  br i1 %or.cond2522, label %land.lhs.true1042, label %if.end1144, !dbg !245

land.lhs.true1042:                                ; preds = %if.end1038
  br i1 %cmp907.not, label %if.end1144, label %if.then1045, !dbg !246

if.then1045:                                      ; preds = %land.lhs.true1042
  %add1047 = or disjoint i32 %mul11.7, 15, !dbg !247
  %cmp1048 = icmp slt i32 %1, %add1047, !dbg !248
  br i1 %cmp1048, label %for.cond1050.preheader, label %if.end1074, !dbg !249

for.cond1050.preheader:                           ; preds = %if.then1045
  %165 = lshr i32 %18, 2
  %mul1056 = and i32 %165, 252
  %add1057 = add nuw nsw i32 %mul11.7, %mul1056
  %cmp1060.not = icmp sgt i32 %add1057, %1, !dbg !250
  %fneg.2359 = select i1 %cmp1060.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3053 = insertelement <4 x float> poison, float %fneg.2359, i64 0, !dbg !251
  %cmp1060.not.1.not = icmp slt i32 %add1057, %1, !dbg !250
  %fneg.2359.1 = select i1 %cmp1060.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3146 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3053, float %fneg.2359.1, i64 1, !dbg !251
  %add1058.2 = or disjoint i32 %add1057, 2, !dbg !252
  %cmp1060.not.2 = icmp sgt i32 %add1058.2, %1, !dbg !250
  %fneg.2359.2 = select i1 %cmp1060.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3239 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3146, float %fneg.2359.2, i64 2, !dbg !251
  %add1058.3 = or disjoint i32 %add1057, 3, !dbg !252
  %cmp1060.not.3 = icmp sgt i32 %add1058.3, %1, !dbg !250
  %fneg.2359.3 = select i1 %cmp1060.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3332 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3239, float %fneg.2359.3, i64 3, !dbg !251
  br label %if.end1074

if.end1074:                                       ; preds = %if.then1045, %for.cond1050.preheader
  %acc_s.sroa.0.14 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3332, %for.cond1050.preheader ], [ zeroinitializer, %if.then1045 ], !dbg !75
  %166 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.3, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.14), !dbg !253, !call_argsrelate !77
  %167 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.10.3, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %166), !dbg !253, !call_argsrelate !77
  %168 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.14.3, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %167), !dbg !253, !call_argsrelate !77
  %169 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.22.3, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %168), !dbg !253, !call_argsrelate !77
  %acc_s.sroa.0.0.vec.extract3055 = extractelement <4 x float> %169, i64 0, !dbg !254
  %mul1109 = fmul contract float %acc_s.sroa.0.0.vec.extract3055, 0x3FB99999A0000000, !dbg !255
  %170 = tail call contract noundef float @llvm.minnum.f32(float %mul1109, float 0x4024CB5EC0000000), !dbg !256
  %171 = tail call contract noundef float @llvm.exp.f32(float %170), !dbg !258
  %acc_s.sroa.0.4.vec.extract3148 = extractelement <4 x float> %169, i64 1, !dbg !254
  %mul1109.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3148, 0x3FB99999A0000000, !dbg !255
  %172 = tail call contract noundef float @llvm.minnum.f32(float %mul1109.1, float 0x4024CB5EC0000000), !dbg !256
  %173 = tail call contract noundef float @llvm.exp.f32(float %172), !dbg !258
  %acc_s.sroa.0.8.vec.extract3241 = extractelement <4 x float> %169, i64 2, !dbg !254
  %mul1109.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3241, 0x3FB99999A0000000, !dbg !255
  %174 = tail call contract noundef float @llvm.minnum.f32(float %mul1109.2, float 0x4024CB5EC0000000), !dbg !256
  %175 = tail call contract noundef float @llvm.exp.f32(float %174), !dbg !258
  %acc_s.sroa.0.12.vec.extract3334 = extractelement <4 x float> %169, i64 3, !dbg !254
  %mul1109.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3334, 0x3FB99999A0000000, !dbg !255
  %176 = tail call contract noundef float @llvm.minnum.f32(float %mul1109.3, float 0x4024CB5EC0000000), !dbg !256
  %177 = tail call contract noundef float @llvm.exp.f32(float %176), !dbg !258
  %add1125 = fadd contract float %sum_acc.sroa.0.6, %171, !dbg !260
  %add1125.1 = fadd contract float %sum_acc.sroa.20.6, %173, !dbg !260
  %add1125.2 = fadd contract float %sum_acc.sroa.38.6, %175, !dbg !260
  %add1125.3 = fadd contract float %sum_acc.sroa.56.6, %177, !dbg !260
  %178 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %171), !dbg !261
  %179 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %173), !dbg !261
  %180 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %175), !dbg !261
  %181 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %177), !dbg !261
  br label %if.end1144, !dbg !265

if.end1144:                                       ; preds = %if.end1074, %land.lhs.true1042, %if.end1038
  %sum_acc.sroa.56.7 = phi float [ %sum_acc.sroa.56.6, %land.lhs.true1042 ], [ %add1125.3, %if.end1074 ], [ %sum_acc.sroa.56.6, %if.end1038 ], !dbg !75
  %sum_acc.sroa.38.7 = phi float [ %sum_acc.sroa.38.6, %land.lhs.true1042 ], [ %add1125.2, %if.end1074 ], [ %sum_acc.sroa.38.6, %if.end1038 ], !dbg !75
  %sum_acc.sroa.20.7 = phi float [ %sum_acc.sroa.20.6, %land.lhs.true1042 ], [ %add1125.1, %if.end1074 ], [ %sum_acc.sroa.20.6, %if.end1038 ], !dbg !75
  %sum_acc.sroa.0.7 = phi float [ %sum_acc.sroa.0.6, %land.lhs.true1042 ], [ %add1125, %if.end1074 ], [ %sum_acc.sroa.0.6, %if.end1038 ], !dbg !75
  %phase_weights.sroa.64.0 = phi i16 [ undef, %land.lhs.true1042 ], [ %181, %if.end1074 ], [ undef, %if.end1038 ]
  %phase_weights.sroa.62.0 = phi i16 [ undef, %land.lhs.true1042 ], [ %180, %if.end1074 ], [ undef, %if.end1038 ]
  %phase_weights.sroa.60.0 = phi i16 [ undef, %land.lhs.true1042 ], [ %179, %if.end1074 ], [ undef, %if.end1038 ]
  %phase_weights.sroa.58.0 = phi i16 [ undef, %land.lhs.true1042 ], [ %178, %if.end1074 ], [ undef, %if.end1038 ]
  br i1 %or.cond2500, label %if.end1202, label %for.cond1179.preheader, !dbg !266

for.cond1179.preheader:                           ; preds = %if.end1144
  %mul1184 = shl nsw i32 %0, 16
  %182 = shl nsw i32 %cond.i.i2368, 10
  %mul1186 = and i32 %182, 64512
  %mul1191 = shl nuw nsw i32 %18, 3
  %add1187 = or disjoint i32 %mul1191, %mul1184
  %add1189 = add nuw nsw i32 %add1187, %mul1186
  %183 = zext nneg i32 %add1189 to i64, !dbg !267
  %add.ptr1194 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %183, !dbg !268
  %V_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr1194, align 16, !dbg !269
  %V_reg.sroa.10.0.add.ptr1194.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1194, i64 8, !dbg !269
  %V_reg.sroa.10.0.copyload = load <4 x half>, ptr addrspace(4) %V_reg.sroa.10.0.add.ptr1194.sroa_idx, align 8, !dbg !269
  %184 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %183, !dbg !268
  %add.ptr1194.1 = getelementptr inbounds i8, ptr addrspace(4) %184, i64 1024, !dbg !268
  %V_reg.sroa.14.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr1194.1, align 16, !dbg !269
  %V_reg.sroa.22.16.add.ptr1194.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %184, i64 1032, !dbg !269
  %V_reg.sroa.22.16.copyload = load <4 x half>, ptr addrspace(4) %V_reg.sroa.22.16.add.ptr1194.1.sroa_idx, align 8, !dbg !269
  br label %if.end1202, !dbg !270

if.end1202:                                       ; preds = %for.cond1179.preheader, %if.end1144
  %V_reg.sroa.22.0 = phi <4 x half> [ undef, %if.end1144 ], [ %V_reg.sroa.22.16.copyload, %for.cond1179.preheader ]
  %V_reg.sroa.14.0 = phi <4 x half> [ undef, %if.end1144 ], [ %V_reg.sroa.14.16.copyload, %for.cond1179.preheader ]
  %V_reg.sroa.10.0 = phi <4 x half> [ undef, %if.end1144 ], [ %V_reg.sroa.10.0.copyload, %for.cond1179.preheader ]
  %V_reg.sroa.0.0 = phi <4 x half> [ undef, %if.end1144 ], [ %V_reg.sroa.0.0.copyload, %for.cond1179.preheader ]
  br i1 %or.cond2502, label %if.end1234, label %for.cond1211.preheader, !dbg !270

for.cond1211.preheader:                           ; preds = %if.end1202
  %mul1216 = shl nsw i32 %0, 16
  %185 = shl nsw i32 %cond.i.i2368.1, 10
  %mul1218 = and i32 %185, 64512
  %mul1223 = shl nuw nsw i32 %18, 3
  %add1219 = or disjoint i32 %mul1223, %mul1216
  %add1221 = add nuw nsw i32 %add1219, %mul1218
  %186 = zext nneg i32 %add1221 to i64, !dbg !271
  %add.ptr1226 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %186, !dbg !272
  %phase_v1.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr1226, align 16, !dbg !273
  %phase_v1.sroa.10.0.add.ptr1226.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1226, i64 8, !dbg !273
  %phase_v1.sroa.10.0.copyload = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.10.0.add.ptr1226.sroa_idx, align 8, !dbg !273
  %187 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %186, !dbg !272
  %add.ptr1226.1 = getelementptr inbounds i8, ptr addrspace(4) %187, i64 1024, !dbg !272
  %phase_v1.sroa.14.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr1226.1, align 16, !dbg !273
  %phase_v1.sroa.22.16.add.ptr1226.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %187, i64 1032, !dbg !273
  %phase_v1.sroa.22.16.copyload = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.22.16.add.ptr1226.1.sroa_idx, align 8, !dbg !273
  br label %if.end1234, !dbg !274

if.end1234:                                       ; preds = %for.cond1211.preheader, %if.end1202
  %phase_v1.sroa.22.0 = phi <4 x half> [ undef, %if.end1202 ], [ %phase_v1.sroa.22.16.copyload, %for.cond1211.preheader ]
  %phase_v1.sroa.14.0 = phi <4 x half> [ undef, %if.end1202 ], [ %phase_v1.sroa.14.16.copyload, %for.cond1211.preheader ]
  %phase_v1.sroa.10.0 = phi <4 x half> [ undef, %if.end1202 ], [ %phase_v1.sroa.10.0.copyload, %for.cond1211.preheader ]
  %phase_v1.sroa.0.0 = phi <4 x half> [ undef, %if.end1202 ], [ %phase_v1.sroa.0.0.copyload, %for.cond1211.preheader ]
  br i1 %or.cond2500, label %if.end1271, label %for.body1245.preheader, !dbg !274

for.body1245.preheader:                           ; preds = %if.end1234
  %188 = insertelement <4 x i16> poison, i16 %phase_weights.sroa.0.0, i64 0, !dbg !275
  %189 = insertelement <4 x i16> %188, i16 %phase_weights.sroa.4.0, i64 1, !dbg !275
  %190 = insertelement <4 x i16> %189, i16 %phase_weights.sroa.6.0, i64 2, !dbg !275
  %191 = insertelement <4 x i16> %190, i16 %phase_weights.sroa.8.0, i64 3, !dbg !275
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %191 to <4 x half>, !dbg !275
  %192 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !276
  %193 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.10.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !276
  %194 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.14.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !276
  %195 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.22.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !276
  br label %if.end1271, !dbg !277

if.end1271:                                       ; preds = %for.body1245.preheader, %if.end1234
  %acc_o.sroa.98.0 = phi <4 x float> [ zeroinitializer, %if.end1234 ], [ %195, %for.body1245.preheader ], !dbg !75
  %acc_o.sroa.66.0 = phi <4 x float> [ zeroinitializer, %if.end1234 ], [ %194, %for.body1245.preheader ], !dbg !75
  %acc_o.sroa.34.0 = phi <4 x float> [ zeroinitializer, %if.end1234 ], [ %193, %for.body1245.preheader ], !dbg !75
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1234 ], [ %192, %for.body1245.preheader ], !dbg !75
  br i1 %or.cond2502, label %if.end1309, label %for.body1282.preheader, !dbg !277

for.body1282.preheader:                           ; preds = %if.end1271
  %196 = insertelement <4 x i16> poison, i16 %phase_weights.sroa.10.0, i64 0, !dbg !278
  %197 = insertelement <4 x i16> %196, i16 %phase_weights.sroa.12.0, i64 1, !dbg !278
  %198 = insertelement <4 x i16> %197, i16 %phase_weights.sroa.14.0, i64 2, !dbg !278
  %199 = insertelement <4 x i16> %198, i16 %phase_weights.sroa.16.0, i64 3, !dbg !278
  %acc_s_cast.sroa.0.6.vec.insert2708 = bitcast <4 x i16> %199 to <4 x half>, !dbg !278
  %200 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.0.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2708, <4 x float> zeroinitializer), !dbg !279
  %201 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.10.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2708, <4 x float> zeroinitializer), !dbg !279
  %202 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.14.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2708, <4 x float> zeroinitializer), !dbg !279
  %203 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.22.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2708, <4 x float> zeroinitializer), !dbg !279
  br label %if.end1309, !dbg !280

if.end1309:                                       ; preds = %for.body1282.preheader, %if.end1271
  %acc_o_alt.sroa.50.0 = phi <4 x float> [ zeroinitializer, %if.end1271 ], [ %203, %for.body1282.preheader ], !dbg !75
  %acc_o_alt.sroa.34.0 = phi <4 x float> [ zeroinitializer, %if.end1271 ], [ %202, %for.body1282.preheader ], !dbg !75
  %acc_o_alt.sroa.18.0 = phi <4 x float> [ zeroinitializer, %if.end1271 ], [ %201, %for.body1282.preheader ], !dbg !75
  %acc_o_alt.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1271 ], [ %200, %for.body1282.preheader ], !dbg !75
  br i1 %or.cond2506, label %if.end1341, label %for.cond1318.preheader, !dbg !280

for.cond1318.preheader:                           ; preds = %if.end1309
  %mul1323 = shl nsw i32 %0, 16
  %204 = shl nsw i32 %cond.i.i2368.2, 10
  %mul1325 = and i32 %204, 64512
  %mul1330 = shl nuw nsw i32 %18, 3
  %add1326 = or disjoint i32 %mul1330, %mul1323
  %add1328 = add nuw nsw i32 %add1326, %mul1325
  %205 = zext nneg i32 %add1328 to i64, !dbg !281
  %add.ptr1333 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %205, !dbg !282
  %V_reg.sroa.0.0.copyload2748 = load <4 x half>, ptr addrspace(4) %add.ptr1333, align 16, !dbg !283
  %V_reg.sroa.10.0.add.ptr1333.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1333, i64 8, !dbg !283
  %V_reg.sroa.10.0.copyload2751 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.10.0.add.ptr1333.sroa_idx, align 8, !dbg !283
  %206 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %205, !dbg !282
  %add.ptr1333.1 = getelementptr inbounds i8, ptr addrspace(4) %206, i64 1024, !dbg !282
  %V_reg.sroa.14.16.copyload2760 = load <4 x half>, ptr addrspace(4) %add.ptr1333.1, align 16, !dbg !283
  %V_reg.sroa.22.16.add.ptr1333.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %206, i64 1032, !dbg !283
  %V_reg.sroa.22.16.copyload2763 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.22.16.add.ptr1333.1.sroa_idx, align 8, !dbg !283
  br label %if.end1341, !dbg !284

if.end1341:                                       ; preds = %for.cond1318.preheader, %if.end1309
  %V_reg.sroa.22.1 = phi <4 x half> [ %V_reg.sroa.22.0, %if.end1309 ], [ %V_reg.sroa.22.16.copyload2763, %for.cond1318.preheader ]
  %V_reg.sroa.14.1 = phi <4 x half> [ %V_reg.sroa.14.0, %if.end1309 ], [ %V_reg.sroa.14.16.copyload2760, %for.cond1318.preheader ]
  %V_reg.sroa.10.1 = phi <4 x half> [ %V_reg.sroa.10.0, %if.end1309 ], [ %V_reg.sroa.10.0.copyload2751, %for.cond1318.preheader ]
  %V_reg.sroa.0.1 = phi <4 x half> [ %V_reg.sroa.0.0, %if.end1309 ], [ %V_reg.sroa.0.0.copyload2748, %for.cond1318.preheader ]
  br i1 %or.cond2508, label %if.end1373, label %for.cond1350.preheader, !dbg !284

for.cond1350.preheader:                           ; preds = %if.end1341
  %mul1355 = shl nsw i32 %0, 16
  %207 = shl nsw i32 %cond.i.i2368.3, 10
  %mul1357 = and i32 %207, 64512
  %mul1362 = shl nuw nsw i32 %18, 3
  %add1358 = or disjoint i32 %mul1362, %mul1355
  %add1360 = add nuw nsw i32 %add1358, %mul1357
  %208 = zext nneg i32 %add1360 to i64, !dbg !285
  %add.ptr1365 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %208, !dbg !286
  %phase_v1.sroa.0.0.copyload2724 = load <4 x half>, ptr addrspace(4) %add.ptr1365, align 16, !dbg !287
  %phase_v1.sroa.10.0.add.ptr1365.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1365, i64 8, !dbg !287
  %phase_v1.sroa.10.0.copyload2727 = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.10.0.add.ptr1365.sroa_idx, align 8, !dbg !287
  %209 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %208, !dbg !286
  %add.ptr1365.1 = getelementptr inbounds i8, ptr addrspace(4) %209, i64 1024, !dbg !286
  %phase_v1.sroa.14.16.copyload2736 = load <4 x half>, ptr addrspace(4) %add.ptr1365.1, align 16, !dbg !287
  %phase_v1.sroa.22.16.add.ptr1365.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %209, i64 1032, !dbg !287
  %phase_v1.sroa.22.16.copyload2739 = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.22.16.add.ptr1365.1.sroa_idx, align 8, !dbg !287
  br label %if.end1373, !dbg !288

if.end1373:                                       ; preds = %for.cond1350.preheader, %if.end1341
  %phase_v1.sroa.22.1 = phi <4 x half> [ %phase_v1.sroa.22.0, %if.end1341 ], [ %phase_v1.sroa.22.16.copyload2739, %for.cond1350.preheader ]
  %phase_v1.sroa.14.1 = phi <4 x half> [ %phase_v1.sroa.14.0, %if.end1341 ], [ %phase_v1.sroa.14.16.copyload2736, %for.cond1350.preheader ]
  %phase_v1.sroa.10.1 = phi <4 x half> [ %phase_v1.sroa.10.0, %if.end1341 ], [ %phase_v1.sroa.10.0.copyload2727, %for.cond1350.preheader ]
  %phase_v1.sroa.0.1 = phi <4 x half> [ %phase_v1.sroa.0.0, %if.end1341 ], [ %phase_v1.sroa.0.0.copyload2724, %for.cond1350.preheader ]
  br i1 %or.cond2506, label %if.end1411, label %for.body1384.preheader, !dbg !288

for.body1384.preheader:                           ; preds = %if.end1373
  %210 = insertelement <4 x i16> poison, i16 %phase_weights.sroa.18.0, i64 0, !dbg !289
  %211 = insertelement <4 x i16> %210, i16 %phase_weights.sroa.20.0, i64 1, !dbg !289
  %212 = insertelement <4 x i16> %211, i16 %phase_weights.sroa.22.0, i64 2, !dbg !289
  %213 = insertelement <4 x i16> %212, i16 %phase_weights.sroa.24.0, i64 3, !dbg !289
  %acc_s_cast.sroa.0.6.vec.insert2710 = bitcast <4 x i16> %213 to <4 x half>, !dbg !289
  %214 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2710, <4 x float> %acc_o.sroa.0.0), !dbg !290
  %215 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.10.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2710, <4 x float> %acc_o.sroa.34.0), !dbg !290
  %216 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.14.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2710, <4 x float> %acc_o.sroa.66.0), !dbg !290
  %217 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.22.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2710, <4 x float> %acc_o.sroa.98.0), !dbg !290
  br label %if.end1411, !dbg !291

if.end1411:                                       ; preds = %for.body1384.preheader, %if.end1373
  %acc_o.sroa.98.1 = phi <4 x float> [ %acc_o.sroa.98.0, %if.end1373 ], [ %217, %for.body1384.preheader ], !dbg !75
  %acc_o.sroa.66.1 = phi <4 x float> [ %acc_o.sroa.66.0, %if.end1373 ], [ %216, %for.body1384.preheader ], !dbg !75
  %acc_o.sroa.34.1 = phi <4 x float> [ %acc_o.sroa.34.0, %if.end1373 ], [ %215, %for.body1384.preheader ], !dbg !75
  %acc_o.sroa.0.1 = phi <4 x float> [ %acc_o.sroa.0.0, %if.end1373 ], [ %214, %for.body1384.preheader ], !dbg !75
  br i1 %or.cond2508, label %if.end1449, label %for.body1422.preheader, !dbg !291

for.body1422.preheader:                           ; preds = %if.end1411
  %218 = insertelement <4 x i16> poison, i16 %phase_weights.sroa.26.0, i64 0, !dbg !292
  %219 = insertelement <4 x i16> %218, i16 %phase_weights.sroa.28.0, i64 1, !dbg !292
  %220 = insertelement <4 x i16> %219, i16 %phase_weights.sroa.30.0, i64 2, !dbg !292
  %221 = insertelement <4 x i16> %220, i16 %phase_weights.sroa.32.0, i64 3, !dbg !292
  %acc_s_cast.sroa.0.6.vec.insert2712 = bitcast <4 x i16> %221 to <4 x half>, !dbg !292
  %222 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.0.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2712, <4 x float> %acc_o_alt.sroa.0.0), !dbg !293
  %223 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.10.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2712, <4 x float> %acc_o_alt.sroa.18.0), !dbg !293
  %224 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.14.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2712, <4 x float> %acc_o_alt.sroa.34.0), !dbg !293
  %225 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.22.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2712, <4 x float> %acc_o_alt.sroa.50.0), !dbg !293
  br label %if.end1449, !dbg !294

if.end1449:                                       ; preds = %for.body1422.preheader, %if.end1411
  %acc_o_alt.sroa.50.1 = phi <4 x float> [ %acc_o_alt.sroa.50.0, %if.end1411 ], [ %225, %for.body1422.preheader ], !dbg !75
  %acc_o_alt.sroa.34.1 = phi <4 x float> [ %acc_o_alt.sroa.34.0, %if.end1411 ], [ %224, %for.body1422.preheader ], !dbg !75
  %acc_o_alt.sroa.18.1 = phi <4 x float> [ %acc_o_alt.sroa.18.0, %if.end1411 ], [ %223, %for.body1422.preheader ], !dbg !75
  %acc_o_alt.sroa.0.1 = phi <4 x float> [ %acc_o_alt.sroa.0.0, %if.end1411 ], [ %222, %for.body1422.preheader ], !dbg !75
  br i1 %or.cond2512, label %if.end1481, label %for.cond1458.preheader, !dbg !294

for.cond1458.preheader:                           ; preds = %if.end1449
  %mul1463 = shl nsw i32 %0, 16
  %226 = shl nsw i32 %cond.i.i2368.4, 10
  %mul1465 = and i32 %226, 64512
  %mul1470 = shl nuw nsw i32 %18, 3
  %add1466 = or disjoint i32 %mul1470, %mul1463
  %add1468 = add nuw nsw i32 %add1466, %mul1465
  %227 = zext nneg i32 %add1468 to i64, !dbg !295
  %add.ptr1473 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %227, !dbg !296
  %V_reg.sroa.0.0.copyload2749 = load <4 x half>, ptr addrspace(4) %add.ptr1473, align 16, !dbg !297
  %V_reg.sroa.10.0.add.ptr1473.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1473, i64 8, !dbg !297
  %V_reg.sroa.10.0.copyload2752 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.10.0.add.ptr1473.sroa_idx, align 8, !dbg !297
  %228 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %227, !dbg !296
  %add.ptr1473.1 = getelementptr inbounds i8, ptr addrspace(4) %228, i64 1024, !dbg !296
  %V_reg.sroa.14.16.copyload2761 = load <4 x half>, ptr addrspace(4) %add.ptr1473.1, align 16, !dbg !297
  %V_reg.sroa.22.16.add.ptr1473.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %228, i64 1032, !dbg !297
  %V_reg.sroa.22.16.copyload2764 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.22.16.add.ptr1473.1.sroa_idx, align 8, !dbg !297
  br label %if.end1481, !dbg !298

if.end1481:                                       ; preds = %for.cond1458.preheader, %if.end1449
  %V_reg.sroa.22.2 = phi <4 x half> [ %V_reg.sroa.22.1, %if.end1449 ], [ %V_reg.sroa.22.16.copyload2764, %for.cond1458.preheader ]
  %V_reg.sroa.14.2 = phi <4 x half> [ %V_reg.sroa.14.1, %if.end1449 ], [ %V_reg.sroa.14.16.copyload2761, %for.cond1458.preheader ]
  %V_reg.sroa.10.2 = phi <4 x half> [ %V_reg.sroa.10.1, %if.end1449 ], [ %V_reg.sroa.10.0.copyload2752, %for.cond1458.preheader ]
  %V_reg.sroa.0.2 = phi <4 x half> [ %V_reg.sroa.0.1, %if.end1449 ], [ %V_reg.sroa.0.0.copyload2749, %for.cond1458.preheader ]
  br i1 %or.cond2514, label %if.end1513, label %for.cond1490.preheader, !dbg !298

for.cond1490.preheader:                           ; preds = %if.end1481
  %mul1495 = shl nsw i32 %0, 16
  %229 = shl nsw i32 %cond.i.i2368.5, 10
  %mul1497 = and i32 %229, 64512
  %mul1502 = shl nuw nsw i32 %18, 3
  %add1498 = or disjoint i32 %mul1502, %mul1495
  %add1500 = add nuw nsw i32 %add1498, %mul1497
  %230 = zext nneg i32 %add1500 to i64, !dbg !299
  %add.ptr1505 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %230, !dbg !300
  %phase_v1.sroa.0.0.copyload2725 = load <4 x half>, ptr addrspace(4) %add.ptr1505, align 16, !dbg !301
  %phase_v1.sroa.10.0.add.ptr1505.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1505, i64 8, !dbg !301
  %phase_v1.sroa.10.0.copyload2728 = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.10.0.add.ptr1505.sroa_idx, align 8, !dbg !301
  %231 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %230, !dbg !300
  %add.ptr1505.1 = getelementptr inbounds i8, ptr addrspace(4) %231, i64 1024, !dbg !300
  %phase_v1.sroa.14.16.copyload2737 = load <4 x half>, ptr addrspace(4) %add.ptr1505.1, align 16, !dbg !301
  %phase_v1.sroa.22.16.add.ptr1505.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %231, i64 1032, !dbg !301
  %phase_v1.sroa.22.16.copyload2740 = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.22.16.add.ptr1505.1.sroa_idx, align 8, !dbg !301
  br label %if.end1513, !dbg !302

if.end1513:                                       ; preds = %for.cond1490.preheader, %if.end1481
  %phase_v1.sroa.22.2 = phi <4 x half> [ %phase_v1.sroa.22.1, %if.end1481 ], [ %phase_v1.sroa.22.16.copyload2740, %for.cond1490.preheader ]
  %phase_v1.sroa.14.2 = phi <4 x half> [ %phase_v1.sroa.14.1, %if.end1481 ], [ %phase_v1.sroa.14.16.copyload2737, %for.cond1490.preheader ]
  %phase_v1.sroa.10.2 = phi <4 x half> [ %phase_v1.sroa.10.1, %if.end1481 ], [ %phase_v1.sroa.10.0.copyload2728, %for.cond1490.preheader ]
  %phase_v1.sroa.0.2 = phi <4 x half> [ %phase_v1.sroa.0.1, %if.end1481 ], [ %phase_v1.sroa.0.0.copyload2725, %for.cond1490.preheader ]
  br i1 %or.cond2512, label %if.end1551, label %for.body1524.preheader, !dbg !302

for.body1524.preheader:                           ; preds = %if.end1513
  %232 = insertelement <4 x i16> poison, i16 %phase_weights.sroa.34.0, i64 0, !dbg !303
  %233 = insertelement <4 x i16> %232, i16 %phase_weights.sroa.36.0, i64 1, !dbg !303
  %234 = insertelement <4 x i16> %233, i16 %phase_weights.sroa.38.0, i64 2, !dbg !303
  %235 = insertelement <4 x i16> %234, i16 %phase_weights.sroa.40.0, i64 3, !dbg !303
  %acc_s_cast.sroa.0.6.vec.insert2714 = bitcast <4 x i16> %235 to <4 x half>, !dbg !303
  %236 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2714, <4 x float> %acc_o.sroa.0.1), !dbg !304
  %237 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.10.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2714, <4 x float> %acc_o.sroa.34.1), !dbg !304
  %238 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.14.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2714, <4 x float> %acc_o.sroa.66.1), !dbg !304
  %239 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.22.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2714, <4 x float> %acc_o.sroa.98.1), !dbg !304
  br label %if.end1551, !dbg !305

if.end1551:                                       ; preds = %for.body1524.preheader, %if.end1513
  %acc_o.sroa.98.2 = phi <4 x float> [ %acc_o.sroa.98.1, %if.end1513 ], [ %239, %for.body1524.preheader ], !dbg !75
  %acc_o.sroa.66.2 = phi <4 x float> [ %acc_o.sroa.66.1, %if.end1513 ], [ %238, %for.body1524.preheader ], !dbg !75
  %acc_o.sroa.34.2 = phi <4 x float> [ %acc_o.sroa.34.1, %if.end1513 ], [ %237, %for.body1524.preheader ], !dbg !75
  %acc_o.sroa.0.2 = phi <4 x float> [ %acc_o.sroa.0.1, %if.end1513 ], [ %236, %for.body1524.preheader ], !dbg !75
  br i1 %or.cond2514, label %if.end1589, label %for.body1562.preheader, !dbg !305

for.body1562.preheader:                           ; preds = %if.end1551
  %240 = insertelement <4 x i16> poison, i16 %phase_weights.sroa.42.0, i64 0, !dbg !306
  %241 = insertelement <4 x i16> %240, i16 %phase_weights.sroa.44.0, i64 1, !dbg !306
  %242 = insertelement <4 x i16> %241, i16 %phase_weights.sroa.46.0, i64 2, !dbg !306
  %243 = insertelement <4 x i16> %242, i16 %phase_weights.sroa.48.0, i64 3, !dbg !306
  %acc_s_cast.sroa.0.6.vec.insert2716 = bitcast <4 x i16> %243 to <4 x half>, !dbg !306
  %244 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.0.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2716, <4 x float> %acc_o_alt.sroa.0.1), !dbg !307
  %245 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.10.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2716, <4 x float> %acc_o_alt.sroa.18.1), !dbg !307
  %246 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.14.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2716, <4 x float> %acc_o_alt.sroa.34.1), !dbg !307
  %247 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.22.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2716, <4 x float> %acc_o_alt.sroa.50.1), !dbg !307
  br label %if.end1589, !dbg !308

if.end1589:                                       ; preds = %for.body1562.preheader, %if.end1551
  %acc_o_alt.sroa.50.2 = phi <4 x float> [ %acc_o_alt.sroa.50.1, %if.end1551 ], [ %247, %for.body1562.preheader ], !dbg !75
  %acc_o_alt.sroa.34.2 = phi <4 x float> [ %acc_o_alt.sroa.34.1, %if.end1551 ], [ %246, %for.body1562.preheader ], !dbg !75
  %acc_o_alt.sroa.18.2 = phi <4 x float> [ %acc_o_alt.sroa.18.1, %if.end1551 ], [ %245, %for.body1562.preheader ], !dbg !75
  %acc_o_alt.sroa.0.2 = phi <4 x float> [ %acc_o_alt.sroa.0.1, %if.end1551 ], [ %244, %for.body1562.preheader ], !dbg !75
  br i1 %or.cond2518, label %if.end1621, label %for.cond1598.preheader, !dbg !308

for.cond1598.preheader:                           ; preds = %if.end1589
  %mul1603 = shl nsw i32 %0, 16
  %248 = shl nsw i32 %cond.i.i2368.6, 10
  %mul1605 = and i32 %248, 64512
  %mul1610 = shl nuw nsw i32 %18, 3
  %add1606 = or disjoint i32 %mul1610, %mul1603
  %add1608 = add nuw nsw i32 %add1606, %mul1605
  %249 = zext nneg i32 %add1608 to i64, !dbg !309
  %add.ptr1613 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %249, !dbg !310
  %V_reg.sroa.0.0.copyload2750 = load <4 x half>, ptr addrspace(4) %add.ptr1613, align 16, !dbg !311
  %V_reg.sroa.10.0.add.ptr1613.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1613, i64 8, !dbg !311
  %V_reg.sroa.10.0.copyload2753 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.10.0.add.ptr1613.sroa_idx, align 8, !dbg !311
  %250 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %249, !dbg !310
  %add.ptr1613.1 = getelementptr inbounds i8, ptr addrspace(4) %250, i64 1024, !dbg !310
  %V_reg.sroa.14.16.copyload2762 = load <4 x half>, ptr addrspace(4) %add.ptr1613.1, align 16, !dbg !311
  %V_reg.sroa.22.16.add.ptr1613.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %250, i64 1032, !dbg !311
  %V_reg.sroa.22.16.copyload2765 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.22.16.add.ptr1613.1.sroa_idx, align 8, !dbg !311
  br label %if.end1621, !dbg !312

if.end1621:                                       ; preds = %for.cond1598.preheader, %if.end1589
  %V_reg.sroa.22.3 = phi <4 x half> [ %V_reg.sroa.22.2, %if.end1589 ], [ %V_reg.sroa.22.16.copyload2765, %for.cond1598.preheader ]
  %V_reg.sroa.14.3 = phi <4 x half> [ %V_reg.sroa.14.2, %if.end1589 ], [ %V_reg.sroa.14.16.copyload2762, %for.cond1598.preheader ]
  %V_reg.sroa.10.3 = phi <4 x half> [ %V_reg.sroa.10.2, %if.end1589 ], [ %V_reg.sroa.10.0.copyload2753, %for.cond1598.preheader ]
  %V_reg.sroa.0.3 = phi <4 x half> [ %V_reg.sroa.0.2, %if.end1589 ], [ %V_reg.sroa.0.0.copyload2750, %for.cond1598.preheader ]
  br i1 %or.cond2520, label %if.end1653, label %for.cond1630.preheader, !dbg !312

for.cond1630.preheader:                           ; preds = %if.end1621
  %mul1635 = shl nsw i32 %0, 16
  %251 = shl nsw i32 %cond.i.i2368.7, 10
  %mul1637 = and i32 %251, 64512
  %mul1642 = shl nuw nsw i32 %18, 3
  %add1638 = or disjoint i32 %mul1642, %mul1635
  %add1640 = add nuw nsw i32 %add1638, %mul1637
  %252 = zext nneg i32 %add1640 to i64, !dbg !313
  %add.ptr1645 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %252, !dbg !314
  %phase_v1.sroa.0.0.copyload2726 = load <4 x half>, ptr addrspace(4) %add.ptr1645, align 16, !dbg !315
  %phase_v1.sroa.10.0.add.ptr1645.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1645, i64 8, !dbg !315
  %phase_v1.sroa.10.0.copyload2729 = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.10.0.add.ptr1645.sroa_idx, align 8, !dbg !315
  %253 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %252, !dbg !314
  %add.ptr1645.1 = getelementptr inbounds i8, ptr addrspace(4) %253, i64 1024, !dbg !314
  %phase_v1.sroa.14.16.copyload2738 = load <4 x half>, ptr addrspace(4) %add.ptr1645.1, align 16, !dbg !315
  %phase_v1.sroa.22.16.add.ptr1645.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %253, i64 1032, !dbg !315
  %phase_v1.sroa.22.16.copyload2741 = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.22.16.add.ptr1645.1.sroa_idx, align 8, !dbg !315
  br label %if.end1653, !dbg !316

if.end1653:                                       ; preds = %for.cond1630.preheader, %if.end1621
  %phase_v1.sroa.22.3 = phi <4 x half> [ %phase_v1.sroa.22.2, %if.end1621 ], [ %phase_v1.sroa.22.16.copyload2741, %for.cond1630.preheader ]
  %phase_v1.sroa.14.3 = phi <4 x half> [ %phase_v1.sroa.14.2, %if.end1621 ], [ %phase_v1.sroa.14.16.copyload2738, %for.cond1630.preheader ]
  %phase_v1.sroa.10.3 = phi <4 x half> [ %phase_v1.sroa.10.2, %if.end1621 ], [ %phase_v1.sroa.10.0.copyload2729, %for.cond1630.preheader ]
  %phase_v1.sroa.0.3 = phi <4 x half> [ %phase_v1.sroa.0.2, %if.end1621 ], [ %phase_v1.sroa.0.0.copyload2726, %for.cond1630.preheader ]
  br i1 %or.cond2518, label %if.end1691, label %for.body1664.preheader, !dbg !316

for.body1664.preheader:                           ; preds = %if.end1653
  %254 = insertelement <4 x i16> poison, i16 %phase_weights.sroa.50.0, i64 0, !dbg !317
  %255 = insertelement <4 x i16> %254, i16 %phase_weights.sroa.52.0, i64 1, !dbg !317
  %256 = insertelement <4 x i16> %255, i16 %phase_weights.sroa.54.0, i64 2, !dbg !317
  %257 = insertelement <4 x i16> %256, i16 %phase_weights.sroa.56.0, i64 3, !dbg !317
  %acc_s_cast.sroa.0.6.vec.insert2718 = bitcast <4 x i16> %257 to <4 x half>, !dbg !317
  %258 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2718, <4 x float> %acc_o.sroa.0.2), !dbg !318
  %259 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.10.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2718, <4 x float> %acc_o.sroa.34.2), !dbg !318
  %260 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.14.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2718, <4 x float> %acc_o.sroa.66.2), !dbg !318
  %261 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.22.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2718, <4 x float> %acc_o.sroa.98.2), !dbg !318
  br label %if.end1691, !dbg !319

if.end1691:                                       ; preds = %for.body1664.preheader, %if.end1653
  %acc_o.sroa.98.3 = phi <4 x float> [ %acc_o.sroa.98.2, %if.end1653 ], [ %261, %for.body1664.preheader ], !dbg !75
  %acc_o.sroa.66.3 = phi <4 x float> [ %acc_o.sroa.66.2, %if.end1653 ], [ %260, %for.body1664.preheader ], !dbg !75
  %acc_o.sroa.34.3 = phi <4 x float> [ %acc_o.sroa.34.2, %if.end1653 ], [ %259, %for.body1664.preheader ], !dbg !75
  %acc_o.sroa.0.3 = phi <4 x float> [ %acc_o.sroa.0.2, %if.end1653 ], [ %258, %for.body1664.preheader ], !dbg !75
  br i1 %or.cond2520, label %if.end1729, label %for.body1702.preheader, !dbg !319

for.body1702.preheader:                           ; preds = %if.end1691
  %262 = insertelement <4 x i16> poison, i16 %phase_weights.sroa.58.0, i64 0, !dbg !320
  %263 = insertelement <4 x i16> %262, i16 %phase_weights.sroa.60.0, i64 1, !dbg !320
  %264 = insertelement <4 x i16> %263, i16 %phase_weights.sroa.62.0, i64 2, !dbg !320
  %265 = insertelement <4 x i16> %264, i16 %phase_weights.sroa.64.0, i64 3, !dbg !320
  %acc_s_cast.sroa.0.6.vec.insert2720 = bitcast <4 x i16> %265 to <4 x half>, !dbg !320
  %266 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.0.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2720, <4 x float> %acc_o_alt.sroa.0.2), !dbg !321
  %267 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.10.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2720, <4 x float> %acc_o_alt.sroa.18.2), !dbg !321
  %268 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.14.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2720, <4 x float> %acc_o_alt.sroa.34.2), !dbg !321
  %269 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.22.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2720, <4 x float> %acc_o_alt.sroa.50.2), !dbg !321
  br label %if.end1729, !dbg !322

if.end1729:                                       ; preds = %for.body1702.preheader, %if.end1691
  %acc_o_alt.sroa.50.3 = phi <4 x float> [ %acc_o_alt.sroa.50.2, %if.end1691 ], [ %269, %for.body1702.preheader ], !dbg !75
  %acc_o_alt.sroa.34.3 = phi <4 x float> [ %acc_o_alt.sroa.34.2, %if.end1691 ], [ %268, %for.body1702.preheader ], !dbg !75
  %acc_o_alt.sroa.18.3 = phi <4 x float> [ %acc_o_alt.sroa.18.2, %if.end1691 ], [ %267, %for.body1702.preheader ], !dbg !75
  %acc_o_alt.sroa.0.3 = phi <4 x float> [ %acc_o_alt.sroa.0.2, %if.end1691 ], [ %266, %for.body1702.preheader ], !dbg !75
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 0, !dbg !323
  %acc_o_alt.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 0, !dbg !324
  %add1738 = fadd contract float %acc_o.sroa.0.0.vec.extract, %acc_o_alt.sroa.0.0.vec.extract, !dbg !325
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 1, !dbg !323
  %acc_o_alt.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 1, !dbg !324
  %add1738.1 = fadd contract float %acc_o.sroa.0.4.vec.extract, %acc_o_alt.sroa.0.4.vec.extract, !dbg !325
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 2, !dbg !323
  %acc_o_alt.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 2, !dbg !324
  %add1738.2 = fadd contract float %acc_o.sroa.0.8.vec.extract, %acc_o_alt.sroa.0.8.vec.extract, !dbg !325
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 3, !dbg !323
  %acc_o_alt.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 3, !dbg !324
  %add1738.3 = fadd contract float %acc_o.sroa.0.12.vec.extract, %acc_o_alt.sroa.0.12.vec.extract, !dbg !325
  %acc_o.sroa.34.16.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 0, !dbg !323
  %acc_o_alt.sroa.18.16.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 0, !dbg !324
  %add1738.4 = fadd contract float %acc_o.sroa.34.16.vec.extract, %acc_o_alt.sroa.18.16.vec.extract, !dbg !325
  %acc_o.sroa.34.20.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 1, !dbg !323
  %acc_o_alt.sroa.18.20.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 1, !dbg !324
  %add1738.5 = fadd contract float %acc_o.sroa.34.20.vec.extract, %acc_o_alt.sroa.18.20.vec.extract, !dbg !325
  %acc_o.sroa.34.24.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 2, !dbg !323
  %acc_o_alt.sroa.18.24.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 2, !dbg !324
  %add1738.6 = fadd contract float %acc_o.sroa.34.24.vec.extract, %acc_o_alt.sroa.18.24.vec.extract, !dbg !325
  %acc_o.sroa.34.28.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 3, !dbg !323
  %acc_o_alt.sroa.18.28.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 3, !dbg !324
  %add1738.7 = fadd contract float %acc_o.sroa.34.28.vec.extract, %acc_o_alt.sroa.18.28.vec.extract, !dbg !325
  %acc_o.sroa.66.32.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 0, !dbg !323
  %acc_o_alt.sroa.34.32.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 0, !dbg !324
  %add1738.8 = fadd contract float %acc_o.sroa.66.32.vec.extract, %acc_o_alt.sroa.34.32.vec.extract, !dbg !325
  %acc_o.sroa.66.36.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 1, !dbg !323
  %acc_o_alt.sroa.34.36.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 1, !dbg !324
  %add1738.9 = fadd contract float %acc_o.sroa.66.36.vec.extract, %acc_o_alt.sroa.34.36.vec.extract, !dbg !325
  %acc_o.sroa.66.40.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 2, !dbg !323
  %acc_o_alt.sroa.34.40.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 2, !dbg !324
  %add1738.10 = fadd contract float %acc_o.sroa.66.40.vec.extract, %acc_o_alt.sroa.34.40.vec.extract, !dbg !325
  %acc_o.sroa.66.44.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 3, !dbg !323
  %acc_o_alt.sroa.34.44.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 3, !dbg !324
  %add1738.11 = fadd contract float %acc_o.sroa.66.44.vec.extract, %acc_o_alt.sroa.34.44.vec.extract, !dbg !325
  %acc_o.sroa.98.48.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 0, !dbg !323
  %acc_o_alt.sroa.50.48.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 0, !dbg !324
  %add1738.12 = fadd contract float %acc_o.sroa.98.48.vec.extract, %acc_o_alt.sroa.50.48.vec.extract, !dbg !325
  %acc_o.sroa.98.52.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 1, !dbg !323
  %acc_o_alt.sroa.50.52.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 1, !dbg !324
  %add1738.13 = fadd contract float %acc_o.sroa.98.52.vec.extract, %acc_o_alt.sroa.50.52.vec.extract, !dbg !325
  %acc_o.sroa.98.56.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 2, !dbg !323
  %acc_o_alt.sroa.50.56.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 2, !dbg !324
  %add1738.14 = fadd contract float %acc_o.sroa.98.56.vec.extract, %acc_o_alt.sroa.50.56.vec.extract, !dbg !325
  %acc_o.sroa.98.60.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 3, !dbg !323
  %acc_o_alt.sroa.50.60.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 3, !dbg !324
  %add1738.15 = fadd contract float %acc_o.sroa.98.60.vec.extract, %acc_o_alt.sroa.50.60.vec.extract, !dbg !325
  %add1752 = fadd contract float %sum_acc.sroa.0.7, 0.000000e+00, !dbg !326
  %add1752.1 = fadd contract float %add1752, %sum_acc.sroa.20.7, !dbg !326
  %add1752.2 = fadd contract float %add1752.1, %sum_acc.sroa.38.7, !dbg !326
  %add1752.3 = fadd contract float %add1752.2, %sum_acc.sroa.56.7, !dbg !326
  %270 = bitcast float %add1752.3 to i32, !dbg !327
  %271 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !339
  %272 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %271) #11, !dbg !344
  %xor.i.i = xor i32 %272, 32, !dbg !345
  %273 = and i32 %272, -64, !dbg !346
  %and.i.i = add nsw i32 %273, 64, !dbg !346
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !347
  %cond.i.i2369 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %272, !dbg !348
  %shl.i.i = shl i32 %cond.i.i2369, 2, !dbg !349
  %274 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %270), !dbg !350
  %275 = bitcast i32 %274 to float, !dbg !351
  %add.i = fadd contract float %add1752.3, %275, !dbg !352
  %276 = bitcast float %add.i to i32, !dbg !355
  %277 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !362
  %278 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %277) #11, !dbg !365
  %xor.i.i2370 = xor i32 %278, 16, !dbg !366
  %279 = and i32 %278, -64, !dbg !367
  %and.i.i2371 = add nsw i32 %279, 64, !dbg !367
  %cmp.not.i.i2372 = icmp slt i32 %xor.i.i2370, %and.i.i2371, !dbg !368
  %cond.i.i2373 = select i1 %cmp.not.i.i2372, i32 %xor.i.i2370, i32 %278, !dbg !369
  %shl.i.i2374 = shl i32 %cond.i.i2373, 2, !dbg !370
  %280 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i2374, i32 %276), !dbg !371
  %281 = bitcast i32 %280 to float, !dbg !372
  %add.i.i = fadd contract float %add.i, %281, !dbg !373
  %cmp1761 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !375
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !376
  %condval_8.0 = select i1 %cmp1761, float %div, float 0.000000e+00, !dbg !376
  %mul1774 = fmul contract float %condval_8.0, %add1738, !dbg !377
  %mul1774.1 = fmul contract float %condval_8.0, %add1738.1, !dbg !377
  %mul1774.2 = fmul contract float %condval_8.0, %add1738.2, !dbg !377
  %mul1774.3 = fmul contract float %condval_8.0, %add1738.3, !dbg !377
  %mul1774.4 = fmul contract float %condval_8.0, %add1738.4, !dbg !377
  %mul1774.5 = fmul contract float %condval_8.0, %add1738.5, !dbg !377
  %mul1774.6 = fmul contract float %condval_8.0, %add1738.6, !dbg !377
  %mul1774.7 = fmul contract float %condval_8.0, %add1738.7, !dbg !377
  %mul1774.8 = fmul contract float %condval_8.0, %add1738.8, !dbg !377
  %mul1774.9 = fmul contract float %condval_8.0, %add1738.9, !dbg !377
  %mul1774.10 = fmul contract float %condval_8.0, %add1738.10, !dbg !377
  %mul1774.11 = fmul contract float %condval_8.0, %add1738.11, !dbg !377
  %mul1774.12 = fmul contract float %condval_8.0, %add1738.12, !dbg !377
  %mul1774.13 = fmul contract float %condval_8.0, %add1738.13, !dbg !377
  %mul1774.14 = fmul contract float %condval_8.0, %add1738.14, !dbg !377
  %mul1774.15 = fmul contract float %condval_8.0, %add1738.15, !dbg !377
  %282 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1774), !dbg !378
  %O_reg.sroa.0.0.insert.ext = zext i16 %282 to i64, !dbg !382
  %283 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1774.1), !dbg !378
  %O_reg.sroa.0.2.insert.ext = zext i16 %283 to i64, !dbg !382
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !382
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !382
  %284 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1774.2), !dbg !378
  %O_reg.sroa.0.4.insert.ext = zext i16 %284 to i64, !dbg !382
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !382
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !382
  %285 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1774.3), !dbg !378
  %O_reg.sroa.0.6.insert.ext = zext i16 %285 to i64, !dbg !382
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !382
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !382
  %286 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1774.4), !dbg !378
  %O_reg.sroa.7.8.insert.ext = zext i16 %286 to i64, !dbg !382
  %287 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1774.5), !dbg !378
  %O_reg.sroa.7.10.insert.ext = zext i16 %287 to i64, !dbg !382
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !382
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !382
  %288 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1774.6), !dbg !378
  %O_reg.sroa.7.12.insert.ext = zext i16 %288 to i64, !dbg !382
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !382
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !382
  %289 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1774.7), !dbg !378
  %O_reg.sroa.7.14.insert.ext = zext i16 %289 to i64, !dbg !382
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !382
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !382
  %290 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1774.8), !dbg !378
  %O_reg.sroa.12.16.insert.ext = zext i16 %290 to i64, !dbg !382
  %291 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1774.9), !dbg !378
  %O_reg.sroa.12.18.insert.ext = zext i16 %291 to i64, !dbg !382
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !382
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !382
  %292 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1774.10), !dbg !378
  %O_reg.sroa.12.20.insert.ext = zext i16 %292 to i64, !dbg !382
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !382
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !382
  %293 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1774.11), !dbg !378
  %O_reg.sroa.12.22.insert.ext = zext i16 %293 to i64, !dbg !382
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !382
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !382
  %294 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1774.12), !dbg !378
  %O_reg.sroa.17.24.insert.ext = zext i16 %294 to i64, !dbg !382
  %295 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1774.13), !dbg !378
  %O_reg.sroa.17.26.insert.ext = zext i16 %295 to i64, !dbg !382
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !382
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !382
  %296 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1774.14), !dbg !378
  %O_reg.sroa.17.28.insert.ext = zext i16 %296 to i64, !dbg !382
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !382
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !382
  %297 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1774.15), !dbg !378
  %O_reg.sroa.17.30.insert.ext = zext i16 %297 to i64, !dbg !382
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !382
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !382
  %shr1816 = lshr i32 %18, 5
  %and1819 = and i32 %18, 7
  %298 = lshr i32 %18, 2
  %mul1825 = and i32 %298, 4
  %xor = xor i32 %shr1816, %and1819, !dbg !383
  %mul1820 = shl nuw nsw i32 %xor, 3, !dbg !384
  %add1821 = add nuw nsw i32 %mul1820, %mul25, !dbg !385
  %add1826 = or disjoint i32 %add1821, %mul1825, !dbg !386
  %add.ptr1828 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1826, !dbg !387
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr1828, align 8, !dbg !388
  %add1817.1 = add nuw nsw i32 %shr1816, 2, !dbg !389
  %xor.1 = xor i32 %add1817.1, %and1819, !dbg !383
  %mul1820.1 = shl nuw nsw i32 %xor.1, 3, !dbg !384
  %add1821.1 = add nuw nsw i32 %mul1820.1, %mul25, !dbg !385
  %add1826.1 = or disjoint i32 %add1821.1, %mul1825, !dbg !386
  %add.ptr1828.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1826.1, !dbg !387
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr1828.1, align 8, !dbg !388
  %add1817.2 = add nuw nsw i32 %shr1816, 4, !dbg !389
  %xor.2 = xor i32 %add1817.2, %and1819, !dbg !383
  %mul1820.2 = shl nuw nsw i32 %xor.2, 3, !dbg !384
  %add1821.2 = add nuw nsw i32 %mul1820.2, %mul25, !dbg !385
  %add1826.2 = or disjoint i32 %add1821.2, %mul1825, !dbg !386
  %add.ptr1828.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1826.2, !dbg !387
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr1828.2, align 8, !dbg !388
  %add1817.3 = add nuw nsw i32 %shr1816, 6, !dbg !389
  %xor.3 = xor i32 %add1817.3, %and1819, !dbg !383
  %mul1820.3 = shl nuw nsw i32 %xor.3, 3, !dbg !384
  %add1821.3 = add nuw nsw i32 %mul1820.3, %mul25, !dbg !385
  %add1826.3 = or disjoint i32 %add1821.3, %mul1825, !dbg !386
  %add.ptr1828.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1826.3, !dbg !387
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr1828.3, align 8, !dbg !388
  fence syncscope("warp") release, !dbg !390
  tail call void @llvm.mxc.barrier.warp(), !dbg !395
  fence syncscope("warp") acquire, !dbg !396
  %299 = shl nuw nsw i32 %18, 3
  %mul1839 = and i32 %299, 8128
  %xor18452351 = and i32 %299, 56
  %call1843.masked = and i32 %18, 1016
  %mul1846 = xor i32 %xor18452351, %call1843.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul1839, !dbg !397
  %invariant.gep2497 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul1846, !dbg !397
  %add1856 = add nuw nsw i32 %add23, %299
  %300 = zext nneg i32 %add1856 to i64, !dbg !398
  %add.ptr1861 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %300, !dbg !399
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1861, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep2497, i64 16, i1 false), !dbg !400, !tbaa.struct !401, !call_argsrelate !402
  %gep2498.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep2497, i32 1024, !dbg !403
  %301 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %300, !dbg !399
  %add.ptr1861.1 = getelementptr inbounds i8, ptr addrspace(1) %301, i64 1024, !dbg !399
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1861.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep2498.1, i64 16, i1 false), !dbg !400, !tbaa.struct !401, !call_argsrelate !402
  ret void, !dbg !404
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
!1 = !DIFile(filename: "/tmp/tmp_q2d97ya/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmp_q2d97ya/tvm_kernels.maca", directory: "")
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
!58 = !DILocation(line: 40, column: 33, scope: !40)
!59 = !DILocation(line: 42, column: 5, scope: !40)
!60 = !DILocation(line: 43, column: 50, scope: !40)
!61 = !DILocation(line: 43, column: 36, scope: !40)
!62 = !DILocation(line: 46, column: 27, scope: !40)
!63 = !DILocation(line: 47, column: 33, scope: !40)
!64 = !DILocation(line: 49, column: 5, scope: !40)
!65 = !DILocation(line: 50, column: 51, scope: !40)
!66 = !DILocation(line: 50, column: 37, scope: !40)
!67 = !DILocation(line: 53, column: 33, scope: !40)
!68 = !DILocation(line: 53, column: 7, scope: !40)
!69 = !DILocation(line: 54, column: 48, scope: !40)
!70 = !DILocation(line: 54, column: 27, scope: !40)
!71 = !DILocation(line: 54, column: 9, scope: !40)
!72 = !DILocation(line: 58, column: 76, scope: !40)
!73 = !DILocation(line: 63, column: 20, scope: !40)
!74 = !DILocation(line: 58, column: 69, scope: !40)
!75 = !DILocation(line: 0, scope: !40)
!76 = !DILocation(line: 72, column: 36, scope: !40)
!77 = !{i32 -1, i32 3, i32 -1}
!78 = !DILocation(line: 80, column: 30, scope: !40)
!79 = !DILocation(line: 80, column: 41, scope: !40)
!80 = !DILocation(line: 354, column: 10, scope: !81, inlinedAt: !82)
!81 = distinct !DISubprogram(name: "min", scope: !46, file: !46, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!82 = distinct !DILocation(line: 80, column: 25, scope: !40)
!83 = !DILocation(line: 288, column: 10, scope: !84, inlinedAt: !85)
!84 = distinct !DISubprogram(name: "expf", scope: !46, file: !46, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!85 = distinct !DILocation(line: 80, column: 20, scope: !40)
!86 = !DILocation(line: 75, column: 10, scope: !87, inlinedAt: !89)
!87 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !88, file: !88, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!88 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!89 = distinct !DILocation(line: 984, column: 9, scope: !90, inlinedAt: !92)
!90 = distinct !DISubprogram(name: "__float2half", scope: !91, file: !91, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!91 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!92 = distinct !DILocation(line: 133, column: 53, scope: !93, inlinedAt: !94)
!93 = distinct !DISubprogram(name: "__half", scope: !91, file: !91, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!94 = distinct !DILocation(line: 88, column: 36, scope: !40)
!95 = !DILocation(line: 91, column: 33, scope: !40)
!96 = !DILocation(line: 91, column: 7, scope: !40)
!97 = !DILocation(line: 92, column: 48, scope: !40)
!98 = !DILocation(line: 92, column: 27, scope: !40)
!99 = !DILocation(line: 92, column: 9, scope: !40)
!100 = !DILocation(line: 96, column: 76, scope: !40)
!101 = !DILocation(line: 101, column: 20, scope: !40)
!102 = !DILocation(line: 96, column: 69, scope: !40)
!103 = !DILocation(line: 110, column: 36, scope: !40)
!104 = !DILocation(line: 118, column: 30, scope: !40)
!105 = !DILocation(line: 118, column: 41, scope: !40)
!106 = !DILocation(line: 354, column: 10, scope: !81, inlinedAt: !107)
!107 = distinct !DILocation(line: 118, column: 25, scope: !40)
!108 = !DILocation(line: 288, column: 10, scope: !84, inlinedAt: !109)
!109 = distinct !DILocation(line: 118, column: 20, scope: !40)
!110 = !DILocation(line: 122, column: 36, scope: !40)
!111 = !DILocation(line: 75, column: 10, scope: !87, inlinedAt: !112)
!112 = distinct !DILocation(line: 984, column: 9, scope: !90, inlinedAt: !113)
!113 = distinct !DILocation(line: 133, column: 53, scope: !93, inlinedAt: !114)
!114 = distinct !DILocation(line: 126, column: 44, scope: !40)
!115 = !DILocation(line: 129, column: 27, scope: !40)
!116 = !DILocation(line: 130, column: 33, scope: !40)
!117 = !DILocation(line: 132, column: 5, scope: !40)
!118 = !DILocation(line: 133, column: 50, scope: !40)
!119 = !DILocation(line: 133, column: 36, scope: !40)
!120 = !DILocation(line: 136, column: 27, scope: !40)
!121 = !DILocation(line: 137, column: 33, scope: !40)
!122 = !DILocation(line: 139, column: 5, scope: !40)
!123 = !DILocation(line: 140, column: 52, scope: !40)
!124 = !DILocation(line: 140, column: 38, scope: !40)
!125 = !DILocation(line: 143, column: 33, scope: !40)
!126 = !DILocation(line: 143, column: 7, scope: !40)
!127 = !DILocation(line: 144, column: 48, scope: !40)
!128 = !DILocation(line: 144, column: 27, scope: !40)
!129 = !DILocation(line: 144, column: 9, scope: !40)
!130 = !DILocation(line: 148, column: 77, scope: !40)
!131 = !DILocation(line: 153, column: 21, scope: !40)
!132 = !DILocation(line: 148, column: 69, scope: !40)
!133 = !DILocation(line: 162, column: 36, scope: !40)
!134 = !DILocation(line: 170, column: 31, scope: !40)
!135 = !DILocation(line: 170, column: 43, scope: !40)
!136 = !DILocation(line: 354, column: 10, scope: !81, inlinedAt: !137)
!137 = distinct !DILocation(line: 170, column: 26, scope: !40)
!138 = !DILocation(line: 288, column: 10, scope: !84, inlinedAt: !139)
!139 = distinct !DILocation(line: 170, column: 21, scope: !40)
!140 = !DILocation(line: 174, column: 38, scope: !40)
!141 = !DILocation(line: 75, column: 10, scope: !87, inlinedAt: !142)
!142 = distinct !DILocation(line: 984, column: 9, scope: !90, inlinedAt: !143)
!143 = distinct !DILocation(line: 133, column: 53, scope: !93, inlinedAt: !144)
!144 = distinct !DILocation(line: 178, column: 44, scope: !40)
!145 = !DILocation(line: 181, column: 33, scope: !40)
!146 = !DILocation(line: 181, column: 7, scope: !40)
!147 = !DILocation(line: 182, column: 48, scope: !40)
!148 = !DILocation(line: 182, column: 27, scope: !40)
!149 = !DILocation(line: 182, column: 9, scope: !40)
!150 = !DILocation(line: 186, column: 77, scope: !40)
!151 = !DILocation(line: 191, column: 21, scope: !40)
!152 = !DILocation(line: 186, column: 69, scope: !40)
!153 = !DILocation(line: 200, column: 36, scope: !40)
!154 = !DILocation(line: 208, column: 31, scope: !40)
!155 = !DILocation(line: 208, column: 43, scope: !40)
!156 = !DILocation(line: 354, column: 10, scope: !81, inlinedAt: !157)
!157 = distinct !DILocation(line: 208, column: 26, scope: !40)
!158 = !DILocation(line: 288, column: 10, scope: !84, inlinedAt: !159)
!159 = distinct !DILocation(line: 208, column: 21, scope: !40)
!160 = !DILocation(line: 212, column: 38, scope: !40)
!161 = !DILocation(line: 75, column: 10, scope: !87, inlinedAt: !162)
!162 = distinct !DILocation(line: 984, column: 9, scope: !90, inlinedAt: !163)
!163 = distinct !DILocation(line: 133, column: 53, scope: !93, inlinedAt: !164)
!164 = distinct !DILocation(line: 216, column: 45, scope: !40)
!165 = !DILocation(line: 219, column: 27, scope: !40)
!166 = !DILocation(line: 220, column: 33, scope: !40)
!167 = !DILocation(line: 222, column: 5, scope: !40)
!168 = !DILocation(line: 223, column: 51, scope: !40)
!169 = !DILocation(line: 223, column: 37, scope: !40)
!170 = !DILocation(line: 226, column: 27, scope: !40)
!171 = !DILocation(line: 227, column: 33, scope: !40)
!172 = !DILocation(line: 229, column: 5, scope: !40)
!173 = !DILocation(line: 230, column: 52, scope: !40)
!174 = !DILocation(line: 230, column: 38, scope: !40)
!175 = !DILocation(line: 233, column: 33, scope: !40)
!176 = !DILocation(line: 233, column: 7, scope: !40)
!177 = !DILocation(line: 234, column: 48, scope: !40)
!178 = !DILocation(line: 234, column: 27, scope: !40)
!179 = !DILocation(line: 234, column: 9, scope: !40)
!180 = !DILocation(line: 238, column: 77, scope: !40)
!181 = !DILocation(line: 243, column: 21, scope: !40)
!182 = !DILocation(line: 238, column: 69, scope: !40)
!183 = !DILocation(line: 252, column: 36, scope: !40)
!184 = !DILocation(line: 260, column: 31, scope: !40)
!185 = !DILocation(line: 260, column: 43, scope: !40)
!186 = !DILocation(line: 354, column: 10, scope: !81, inlinedAt: !187)
!187 = distinct !DILocation(line: 260, column: 26, scope: !40)
!188 = !DILocation(line: 288, column: 10, scope: !84, inlinedAt: !189)
!189 = distinct !DILocation(line: 260, column: 21, scope: !40)
!190 = !DILocation(line: 264, column: 38, scope: !40)
!191 = !DILocation(line: 75, column: 10, scope: !87, inlinedAt: !192)
!192 = distinct !DILocation(line: 984, column: 9, scope: !90, inlinedAt: !193)
!193 = distinct !DILocation(line: 133, column: 53, scope: !93, inlinedAt: !194)
!194 = distinct !DILocation(line: 268, column: 45, scope: !40)
!195 = !DILocation(line: 271, column: 33, scope: !40)
!196 = !DILocation(line: 271, column: 7, scope: !40)
!197 = !DILocation(line: 272, column: 48, scope: !40)
!198 = !DILocation(line: 272, column: 27, scope: !40)
!199 = !DILocation(line: 272, column: 9, scope: !40)
!200 = !DILocation(line: 276, column: 77, scope: !40)
!201 = !DILocation(line: 281, column: 21, scope: !40)
!202 = !DILocation(line: 276, column: 69, scope: !40)
!203 = !DILocation(line: 290, column: 36, scope: !40)
!204 = !DILocation(line: 298, column: 31, scope: !40)
!205 = !DILocation(line: 298, column: 43, scope: !40)
!206 = !DILocation(line: 354, column: 10, scope: !81, inlinedAt: !207)
!207 = distinct !DILocation(line: 298, column: 26, scope: !40)
!208 = !DILocation(line: 288, column: 10, scope: !84, inlinedAt: !209)
!209 = distinct !DILocation(line: 298, column: 21, scope: !40)
!210 = !DILocation(line: 302, column: 38, scope: !40)
!211 = !DILocation(line: 75, column: 10, scope: !87, inlinedAt: !212)
!212 = distinct !DILocation(line: 984, column: 9, scope: !90, inlinedAt: !213)
!213 = distinct !DILocation(line: 133, column: 53, scope: !93, inlinedAt: !214)
!214 = distinct !DILocation(line: 306, column: 45, scope: !40)
!215 = !DILocation(line: 309, column: 27, scope: !40)
!216 = !DILocation(line: 310, column: 33, scope: !40)
!217 = !DILocation(line: 312, column: 5, scope: !40)
!218 = !DILocation(line: 313, column: 51, scope: !40)
!219 = !DILocation(line: 313, column: 37, scope: !40)
!220 = !DILocation(line: 316, column: 27, scope: !40)
!221 = !DILocation(line: 317, column: 33, scope: !40)
!222 = !DILocation(line: 319, column: 5, scope: !40)
!223 = !DILocation(line: 320, column: 52, scope: !40)
!224 = !DILocation(line: 320, column: 38, scope: !40)
!225 = !DILocation(line: 323, column: 33, scope: !40)
!226 = !DILocation(line: 323, column: 7, scope: !40)
!227 = !DILocation(line: 324, column: 48, scope: !40)
!228 = !DILocation(line: 324, column: 27, scope: !40)
!229 = !DILocation(line: 324, column: 9, scope: !40)
!230 = !DILocation(line: 328, column: 77, scope: !40)
!231 = !DILocation(line: 333, column: 21, scope: !40)
!232 = !DILocation(line: 328, column: 69, scope: !40)
!233 = !DILocation(line: 342, column: 36, scope: !40)
!234 = !DILocation(line: 350, column: 31, scope: !40)
!235 = !DILocation(line: 350, column: 43, scope: !40)
!236 = !DILocation(line: 354, column: 10, scope: !81, inlinedAt: !237)
!237 = distinct !DILocation(line: 350, column: 26, scope: !40)
!238 = !DILocation(line: 288, column: 10, scope: !84, inlinedAt: !239)
!239 = distinct !DILocation(line: 350, column: 21, scope: !40)
!240 = !DILocation(line: 354, column: 38, scope: !40)
!241 = !DILocation(line: 75, column: 10, scope: !87, inlinedAt: !242)
!242 = distinct !DILocation(line: 984, column: 9, scope: !90, inlinedAt: !243)
!243 = distinct !DILocation(line: 133, column: 53, scope: !93, inlinedAt: !244)
!244 = distinct !DILocation(line: 358, column: 45, scope: !40)
!245 = !DILocation(line: 361, column: 33, scope: !40)
!246 = !DILocation(line: 361, column: 7, scope: !40)
!247 = !DILocation(line: 362, column: 48, scope: !40)
!248 = !DILocation(line: 362, column: 27, scope: !40)
!249 = !DILocation(line: 362, column: 9, scope: !40)
!250 = !DILocation(line: 366, column: 77, scope: !40)
!251 = !DILocation(line: 371, column: 21, scope: !40)
!252 = !DILocation(line: 366, column: 69, scope: !40)
!253 = !DILocation(line: 380, column: 36, scope: !40)
!254 = !DILocation(line: 388, column: 31, scope: !40)
!255 = !DILocation(line: 388, column: 43, scope: !40)
!256 = !DILocation(line: 354, column: 10, scope: !81, inlinedAt: !257)
!257 = distinct !DILocation(line: 388, column: 26, scope: !40)
!258 = !DILocation(line: 288, column: 10, scope: !84, inlinedAt: !259)
!259 = distinct !DILocation(line: 388, column: 21, scope: !40)
!260 = !DILocation(line: 392, column: 38, scope: !40)
!261 = !DILocation(line: 75, column: 10, scope: !87, inlinedAt: !262)
!262 = distinct !DILocation(line: 984, column: 9, scope: !90, inlinedAt: !263)
!263 = distinct !DILocation(line: 133, column: 53, scope: !93, inlinedAt: !264)
!264 = distinct !DILocation(line: 396, column: 45, scope: !40)
!265 = !DILocation(line: 400, column: 3, scope: !40)
!266 = !DILocation(line: 410, column: 33, scope: !40)
!267 = !DILocation(line: 412, column: 5, scope: !40)
!268 = !DILocation(line: 413, column: 51, scope: !40)
!269 = !DILocation(line: 413, column: 37, scope: !40)
!270 = !DILocation(line: 417, column: 33, scope: !40)
!271 = !DILocation(line: 419, column: 5, scope: !40)
!272 = !DILocation(line: 420, column: 54, scope: !40)
!273 = !DILocation(line: 420, column: 40, scope: !40)
!274 = !DILocation(line: 423, column: 33, scope: !40)
!275 = !DILocation(line: 426, column: 32, scope: !40)
!276 = !DILocation(line: 430, column: 36, scope: !40)
!277 = !DILocation(line: 436, column: 33, scope: !40)
!278 = !DILocation(line: 439, column: 32, scope: !40)
!279 = !DILocation(line: 443, column: 42, scope: !40)
!280 = !DILocation(line: 450, column: 33, scope: !40)
!281 = !DILocation(line: 452, column: 5, scope: !40)
!282 = !DILocation(line: 453, column: 51, scope: !40)
!283 = !DILocation(line: 453, column: 37, scope: !40)
!284 = !DILocation(line: 457, column: 33, scope: !40)
!285 = !DILocation(line: 459, column: 5, scope: !40)
!286 = !DILocation(line: 460, column: 54, scope: !40)
!287 = !DILocation(line: 460, column: 40, scope: !40)
!288 = !DILocation(line: 463, column: 33, scope: !40)
!289 = !DILocation(line: 466, column: 33, scope: !40)
!290 = !DILocation(line: 470, column: 38, scope: !40)
!291 = !DILocation(line: 476, column: 33, scope: !40)
!292 = !DILocation(line: 479, column: 33, scope: !40)
!293 = !DILocation(line: 483, column: 42, scope: !40)
!294 = !DILocation(line: 490, column: 33, scope: !40)
!295 = !DILocation(line: 492, column: 5, scope: !40)
!296 = !DILocation(line: 493, column: 51, scope: !40)
!297 = !DILocation(line: 493, column: 37, scope: !40)
!298 = !DILocation(line: 497, column: 33, scope: !40)
!299 = !DILocation(line: 499, column: 5, scope: !40)
!300 = !DILocation(line: 500, column: 54, scope: !40)
!301 = !DILocation(line: 500, column: 40, scope: !40)
!302 = !DILocation(line: 503, column: 33, scope: !40)
!303 = !DILocation(line: 506, column: 33, scope: !40)
!304 = !DILocation(line: 510, column: 38, scope: !40)
!305 = !DILocation(line: 516, column: 33, scope: !40)
!306 = !DILocation(line: 519, column: 33, scope: !40)
!307 = !DILocation(line: 523, column: 42, scope: !40)
!308 = !DILocation(line: 530, column: 33, scope: !40)
!309 = !DILocation(line: 532, column: 5, scope: !40)
!310 = !DILocation(line: 533, column: 51, scope: !40)
!311 = !DILocation(line: 533, column: 37, scope: !40)
!312 = !DILocation(line: 537, column: 33, scope: !40)
!313 = !DILocation(line: 539, column: 5, scope: !40)
!314 = !DILocation(line: 540, column: 54, scope: !40)
!315 = !DILocation(line: 540, column: 40, scope: !40)
!316 = !DILocation(line: 543, column: 33, scope: !40)
!317 = !DILocation(line: 546, column: 33, scope: !40)
!318 = !DILocation(line: 550, column: 38, scope: !40)
!319 = !DILocation(line: 556, column: 33, scope: !40)
!320 = !DILocation(line: 559, column: 33, scope: !40)
!321 = !DILocation(line: 563, column: 42, scope: !40)
!322 = !DILocation(line: 570, column: 3, scope: !40)
!323 = !DILocation(line: 571, column: 20, scope: !40)
!324 = !DILocation(line: 571, column: 34, scope: !40)
!325 = !DILocation(line: 571, column: 32, scope: !40)
!326 = !DILocation(line: 576, column: 36, scope: !40)
!327 = !DILocation(line: 1018, column: 9, scope: !328, inlinedAt: !330)
!328 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !329, file: !329, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!329 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!330 = distinct !DILocation(line: 396, column: 10, scope: !331, inlinedAt: !333)
!331 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !332, file: !332, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!332 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!333 = distinct !DILocation(line: 129, column: 24, scope: !334, inlinedAt: !336)
!334 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !335, file: !335, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!335 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!336 = distinct !DILocation(line: 101, column: 14, scope: !337, inlinedAt: !338)
!337 = distinct !DISubprogram(name: "run<float>", scope: !335, file: !335, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!338 = distinct !DILocation(line: 578, column: 19, scope: !40)
!339 = !DILocation(line: 171, column: 37, scope: !340, inlinedAt: !341)
!340 = distinct !DISubprogram(name: "__lane_id", scope: !329, file: !329, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!341 = distinct !DILocation(line: 990, column: 14, scope: !342, inlinedAt: !343)
!342 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !329, file: !329, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!343 = distinct !DILocation(line: 1019, column: 11, scope: !328, inlinedAt: !330)
!344 = !DILocation(line: 171, column: 10, scope: !340, inlinedAt: !341)
!345 = !DILocation(line: 991, column: 20, scope: !342, inlinedAt: !343)
!346 = !DILocation(line: 992, column: 36, scope: !342, inlinedAt: !343)
!347 = !DILocation(line: 992, column: 17, scope: !342, inlinedAt: !343)
!348 = !DILocation(line: 992, column: 11, scope: !342, inlinedAt: !343)
!349 = !DILocation(line: 993, column: 43, scope: !342, inlinedAt: !343)
!350 = !DILocation(line: 993, column: 10, scope: !342, inlinedAt: !343)
!351 = !DILocation(line: 1020, column: 14, scope: !328, inlinedAt: !330)
!352 = !DILocation(line: 25, column: 14, scope: !353, inlinedAt: !354)
!353 = distinct !DISubprogram(name: "operator()<float>", scope: !335, file: !335, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!354 = distinct !DILocation(line: 129, column: 11, scope: !334, inlinedAt: !336)
!355 = !DILocation(line: 1018, column: 9, scope: !328, inlinedAt: !356)
!356 = distinct !DILocation(line: 396, column: 10, scope: !331, inlinedAt: !357)
!357 = distinct !DILocation(line: 129, column: 24, scope: !358, inlinedAt: !359)
!358 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !335, file: !335, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!359 = distinct !DILocation(line: 101, column: 14, scope: !360, inlinedAt: !361)
!360 = distinct !DISubprogram(name: "run<float>", scope: !335, file: !335, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!361 = distinct !DILocation(line: 134, column: 14, scope: !334, inlinedAt: !336)
!362 = !DILocation(line: 171, column: 37, scope: !340, inlinedAt: !363)
!363 = distinct !DILocation(line: 990, column: 14, scope: !342, inlinedAt: !364)
!364 = distinct !DILocation(line: 1019, column: 11, scope: !328, inlinedAt: !356)
!365 = !DILocation(line: 171, column: 10, scope: !340, inlinedAt: !363)
!366 = !DILocation(line: 991, column: 20, scope: !342, inlinedAt: !364)
!367 = !DILocation(line: 992, column: 36, scope: !342, inlinedAt: !364)
!368 = !DILocation(line: 992, column: 17, scope: !342, inlinedAt: !364)
!369 = !DILocation(line: 992, column: 11, scope: !342, inlinedAt: !364)
!370 = !DILocation(line: 993, column: 43, scope: !342, inlinedAt: !364)
!371 = !DILocation(line: 993, column: 10, scope: !342, inlinedAt: !364)
!372 = !DILocation(line: 1020, column: 14, scope: !328, inlinedAt: !356)
!373 = !DILocation(line: 25, column: 14, scope: !353, inlinedAt: !374)
!374 = distinct !DILocation(line: 129, column: 11, scope: !358, inlinedAt: !359)
!375 = !DILocation(line: 580, column: 32, scope: !40)
!376 = !DILocation(line: 580, column: 7, scope: !40)
!377 = !DILocation(line: 588, column: 32, scope: !40)
!378 = !DILocation(line: 75, column: 10, scope: !87, inlinedAt: !379)
!379 = distinct !DILocation(line: 984, column: 9, scope: !90, inlinedAt: !380)
!380 = distinct !DILocation(line: 133, column: 53, scope: !93, inlinedAt: !381)
!381 = distinct !DILocation(line: 594, column: 48, scope: !40)
!382 = !DILocation(line: 594, column: 45, scope: !40)
!383 = !DILocation(line: 599, column: 122, scope: !40)
!384 = !DILocation(line: 599, column: 150, scope: !40)
!385 = !DILocation(line: 599, column: 77, scope: !40)
!386 = !DILocation(line: 599, column: 156, scope: !40)
!387 = !DILocation(line: 599, column: 40, scope: !40)
!388 = !DILocation(line: 599, column: 199, scope: !40)
!389 = !DILocation(line: 599, column: 93, scope: !40)
!390 = !DILocation(line: 68, column: 3, scope: !391, inlinedAt: !392)
!391 = distinct !DISubprogram(name: "__barrier_warp", scope: !329, file: !329, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!392 = distinct !DILocation(line: 192, column: 3, scope: !393, inlinedAt: !394)
!393 = distinct !DISubprogram(name: "__syncwarp", scope: !329, file: !329, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!394 = distinct !DILocation(line: 601, column: 3, scope: !40)
!395 = !DILocation(line: 69, column: 3, scope: !391, inlinedAt: !392)
!396 = !DILocation(line: 70, column: 3, scope: !391, inlinedAt: !392)
!397 = !DILocation(line: 603, column: 8, scope: !40)
!398 = !DILocation(line: 603, column: 3, scope: !40)
!399 = !DILocation(line: 604, column: 22, scope: !40)
!400 = !DILocation(line: 604, column: 132, scope: !40)
!401 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!402 = !{i32 2, i32 -1, i32 -1, i32 -1}
!403 = !DILocation(line: 604, column: 169, scope: !40)
!404 = !DILocation(line: 606, column: 1, scope: !40)
