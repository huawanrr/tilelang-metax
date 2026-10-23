; ModuleID = 'experiments/20261015_goal8933/ring_binary/oj12_m1_p1.bc'
source_filename = "/tmp/tmputn1d82q/tvm_kernels.maca"
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
  %cond.i.i2150 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64), !dbg !49
  %mul11 = shl nsw i32 %cond.i.i2150, 4, !dbg !52
  %4 = or disjoint i64 %2, 1, !dbg !53
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4, !dbg !43
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !dbg !43, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2150.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64), !dbg !49
  %mul11.1 = shl nsw i32 %cond.i.i2150.1, 4, !dbg !52
  %6 = or disjoint i64 %2, 2, !dbg !53
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6, !dbg !43
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !dbg !43, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2150.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64), !dbg !49
  %mul11.2 = shl nsw i32 %cond.i.i2150.2, 4, !dbg !52
  %8 = or disjoint i64 %2, 3, !dbg !53
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8, !dbg !43
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !dbg !43, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2150.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64), !dbg !49
  %mul11.3 = shl nsw i32 %cond.i.i2150.3, 4, !dbg !52
  %10 = or disjoint i64 %2, 4, !dbg !53
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10, !dbg !43
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !dbg !43, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2150.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64), !dbg !49
  %mul11.4 = shl nsw i32 %cond.i.i2150.4, 4, !dbg !52
  %12 = or disjoint i64 %2, 5, !dbg !53
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12, !dbg !43
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !dbg !43, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2150.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64), !dbg !49
  %mul11.5 = shl nsw i32 %cond.i.i2150.5, 4, !dbg !52
  %14 = or disjoint i64 %2, 6, !dbg !53
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14, !dbg !43
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !dbg !43, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2150.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64), !dbg !49
  %mul11.6 = shl nsw i32 %cond.i.i2150.6, 4, !dbg !52
  %16 = or disjoint i64 %2, 7, !dbg !53
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16, !dbg !43
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !dbg !43, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2150.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64), !dbg !49
  %mul11.7 = shl nsw i32 %cond.i.i2150.7, 4, !dbg !52
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
  %cmp75.not = icmp sgt i32 %mul11, %1
  %or.cond2274 = or i1 %or.cond, %cmp75.not, !dbg !58
  br i1 %or.cond2274, label %if.end, label %for.cond76.preheader, !dbg !58

for.cond76.preheader:                             ; preds = %entry
  %mul82 = shl nsw i32 %0, 16
  %22 = shl nsw i32 %cond.i.i2150, 10
  %mul84 = and i32 %22, 64512
  %mul89 = shl nuw nsw i32 %18, 3
  %add85 = or disjoint i32 %mul89, %mul82
  %add87 = add nuw nsw i32 %add85, %mul84
  %23 = zext nneg i32 %add87 to i64, !dbg !59
  %add.ptr92 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %23, !dbg !60
  %K_ring0.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr92, align 16, !dbg !61
  %K_ring0.sroa.10.0.add.ptr92.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr92, i64 8, !dbg !61
  %K_ring0.sroa.10.0.copyload = load <4 x half>, ptr addrspace(4) %K_ring0.sroa.10.0.add.ptr92.sroa_idx, align 8, !dbg !61
  %24 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %23, !dbg !60
  %add.ptr92.1 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 1024, !dbg !60
  %K_ring0.sroa.14.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr92.1, align 16, !dbg !61
  %K_ring0.sroa.22.16.add.ptr92.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %24, i64 1032, !dbg !61
  %K_ring0.sroa.22.16.copyload = load <4 x half>, ptr addrspace(4) %K_ring0.sroa.22.16.add.ptr92.1.sroa_idx, align 8, !dbg !61
  br label %if.end, !dbg !62

if.end:                                           ; preds = %for.cond76.preheader, %entry
  %K_ring0.sroa.22.0 = phi <4 x half> [ undef, %entry ], [ %K_ring0.sroa.22.16.copyload, %for.cond76.preheader ]
  %K_ring0.sroa.14.0 = phi <4 x half> [ undef, %entry ], [ %K_ring0.sroa.14.16.copyload, %for.cond76.preheader ]
  %K_ring0.sroa.10.0 = phi <4 x half> [ undef, %entry ], [ %K_ring0.sroa.10.0.copyload, %for.cond76.preheader ]
  %K_ring0.sroa.0.0 = phi <4 x half> [ undef, %entry ], [ %K_ring0.sroa.0.0.copyload, %for.cond76.preheader ]
  %or.cond2275 = icmp ugt i32 %mul11.1, 1023, !dbg !63
  %cmp106.not = icmp sgt i32 %mul11.1, %1
  %or.cond2276 = or i1 %or.cond2275, %cmp106.not, !dbg !63
  br i1 %or.cond2276, label %if.end132, label %for.cond108.preheader, !dbg !63

for.cond108.preheader:                            ; preds = %if.end
  %mul114 = shl nsw i32 %0, 16
  %25 = shl nsw i32 %cond.i.i2150.1, 10
  %mul116 = and i32 %25, 64512
  %mul121 = shl nuw nsw i32 %18, 3
  %add117 = or disjoint i32 %mul121, %mul114
  %add119 = add nuw nsw i32 %add117, %mul116
  %26 = zext nneg i32 %add119 to i64, !dbg !64
  %add.ptr124 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %26, !dbg !65
  %K_ring1.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr124, align 16, !dbg !66
  %K_ring1.sroa.10.0.add.ptr124.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr124, i64 8, !dbg !66
  %K_ring1.sroa.10.0.copyload = load <4 x half>, ptr addrspace(4) %K_ring1.sroa.10.0.add.ptr124.sroa_idx, align 8, !dbg !66
  %27 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %26, !dbg !65
  %add.ptr124.1 = getelementptr inbounds i8, ptr addrspace(4) %27, i64 1024, !dbg !65
  %K_ring1.sroa.14.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr124.1, align 16, !dbg !66
  %K_ring1.sroa.22.16.add.ptr124.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %27, i64 1032, !dbg !66
  %K_ring1.sroa.22.16.copyload = load <4 x half>, ptr addrspace(4) %K_ring1.sroa.22.16.add.ptr124.1.sroa_idx, align 8, !dbg !66
  br label %if.end132, !dbg !67

if.end132:                                        ; preds = %for.cond108.preheader, %if.end
  %K_ring1.sroa.22.0 = phi <4 x half> [ undef, %if.end ], [ %K_ring1.sroa.22.16.copyload, %for.cond108.preheader ]
  %K_ring1.sroa.14.0 = phi <4 x half> [ undef, %if.end ], [ %K_ring1.sroa.14.16.copyload, %for.cond108.preheader ]
  %K_ring1.sroa.10.0 = phi <4 x half> [ undef, %if.end ], [ %K_ring1.sroa.10.0.copyload, %for.cond108.preheader ]
  %K_ring1.sroa.0.0 = phi <4 x half> [ undef, %if.end ], [ %K_ring1.sroa.0.0.copyload, %for.cond108.preheader ]
  br i1 %or.cond2274, label %if.end165, label %for.cond141.preheader, !dbg !67

for.cond141.preheader:                            ; preds = %if.end132
  %mul147 = shl nsw i32 %0, 16
  %28 = shl nsw i32 %cond.i.i2150, 10
  %mul149 = and i32 %28, 64512
  %mul154 = shl nuw nsw i32 %18, 3
  %add150 = or disjoint i32 %mul154, %mul147
  %add152 = add nuw nsw i32 %add150, %mul149
  %29 = zext nneg i32 %add152 to i64, !dbg !68
  %add.ptr157 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %29, !dbg !69
  %V_ring0.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr157, align 16, !dbg !70
  %V_ring0.sroa.18.0.add.ptr157.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr157, i64 8, !dbg !70
  %V_ring0.sroa.18.0.copyload = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.18.0.add.ptr157.sroa_idx, align 8, !dbg !70
  %30 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %29, !dbg !69
  %add.ptr157.1 = getelementptr inbounds i8, ptr addrspace(4) %30, i64 1024, !dbg !69
  %V_ring0.sroa.26.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr157.1, align 16, !dbg !70
  %V_ring0.sroa.42.16.add.ptr157.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %30, i64 1032, !dbg !70
  %V_ring0.sroa.42.16.copyload = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.42.16.add.ptr157.1.sroa_idx, align 8, !dbg !70
  br label %if.end165, !dbg !71

if.end165:                                        ; preds = %for.cond141.preheader, %if.end132
  %V_ring0.sroa.42.0 = phi <4 x half> [ undef, %if.end132 ], [ %V_ring0.sroa.42.16.copyload, %for.cond141.preheader ]
  %V_ring0.sroa.26.0 = phi <4 x half> [ undef, %if.end132 ], [ %V_ring0.sroa.26.16.copyload, %for.cond141.preheader ]
  %V_ring0.sroa.18.0 = phi <4 x half> [ undef, %if.end132 ], [ %V_ring0.sroa.18.0.copyload, %for.cond141.preheader ]
  %V_ring0.sroa.0.0 = phi <4 x half> [ undef, %if.end132 ], [ %V_ring0.sroa.0.0.copyload, %for.cond141.preheader ]
  %or.cond2279 = icmp ult i32 %mul11, 1024, !dbg !71
  br i1 %or.cond2279, label %land.lhs.true170, label %if.end290, !dbg !71

land.lhs.true170:                                 ; preds = %if.end165
  br i1 %cmp75.not, label %if.end290, label %if.then173, !dbg !72

if.then173:                                       ; preds = %land.lhs.true170
  %add175 = or disjoint i32 %mul11, 15, !dbg !73
  %cmp176 = icmp ult i32 %1, %add175, !dbg !74
  br i1 %cmp176, label %for.cond178.preheader, label %if.end202, !dbg !75

for.cond178.preheader:                            ; preds = %if.then173
  %31 = lshr i32 %18, 2
  %mul185 = and i32 %31, 252
  %add186 = add nuw nsw i32 %mul11, %mul185
  %cmp189.not = icmp sgt i32 %add186, %1, !dbg !76
  %fneg. = select i1 %cmp189.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2502 = insertelement <4 x float> poison, float %fneg., i64 0, !dbg !77
  %cmp189.not.1.not = icmp slt i32 %add186, %1, !dbg !76
  %fneg..1 = select i1 %cmp189.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2595 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2502, float %fneg..1, i64 1, !dbg !77
  %add187.2 = or disjoint i32 %add186, 2, !dbg !78
  %cmp189.not.2 = icmp sgt i32 %add187.2, %1, !dbg !76
  %fneg..2 = select i1 %cmp189.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2688 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2595, float %fneg..2, i64 2, !dbg !77
  %add187.3 = or disjoint i32 %add186, 3, !dbg !78
  %cmp189.not.3 = icmp sgt i32 %add187.3, %1, !dbg !76
  %fneg..3 = select i1 %cmp189.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2781 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2688, float %fneg..3, i64 3, !dbg !77
  br label %if.end202

if.end202:                                        ; preds = %if.then173, %for.cond178.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2781, %for.cond178.preheader ], [ zeroinitializer, %if.then173 ], !dbg !79
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !dbg !80, !call_argsrelate !81
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.10.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %32), !dbg !80, !call_argsrelate !81
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.14.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %33), !dbg !80, !call_argsrelate !81
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.22.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %34), !dbg !80, !call_argsrelate !81
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %35, i64 0, !dbg !82
  %mul238 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !83
  %36 = tail call contract noundef float @llvm.minnum.f32(float %mul238, float 0x4024CB5EC0000000), !dbg !84
  %37 = tail call contract noundef float @llvm.exp.f32(float %36), !dbg !87
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %35, i64 1, !dbg !82
  %mul238.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !83
  %38 = tail call contract noundef float @llvm.minnum.f32(float %mul238.1, float 0x4024CB5EC0000000), !dbg !84
  %39 = tail call contract noundef float @llvm.exp.f32(float %38), !dbg !87
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %35, i64 2, !dbg !82
  %mul238.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !83
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul238.2, float 0x4024CB5EC0000000), !dbg !84
  %41 = tail call contract noundef float @llvm.exp.f32(float %40), !dbg !87
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %35, i64 3, !dbg !82
  %mul238.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !83
  %42 = tail call contract noundef float @llvm.minnum.f32(float %mul238.3, float 0x4024CB5EC0000000), !dbg !84
  %43 = tail call contract noundef float @llvm.exp.f32(float %42), !dbg !87
  %44 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %37), !dbg !90
  %45 = insertelement <4 x i16> poison, i16 %44, i64 0, !dbg !99
  %46 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %39), !dbg !90
  %47 = insertelement <4 x i16> %45, i16 %46, i64 1, !dbg !99
  %48 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %41), !dbg !90
  %49 = insertelement <4 x i16> %47, i16 %48, i64 2, !dbg !99
  %50 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %43), !dbg !90
  %51 = insertelement <4 x i16> %49, i16 %50, i64 3, !dbg !99
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %51 to <4 x half>, !dbg !99
  %52 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.0.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !100
  %53 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.18.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !100
  %54 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.26.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !100
  %55 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.42.0, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !100
  br label %if.end290, !dbg !101

if.end290:                                        ; preds = %if.end202, %land.lhs.true170, %if.end165
  %acc_o.sroa.98.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true170 ], [ %55, %if.end202 ], [ zeroinitializer, %if.end165 ], !dbg !79
  %acc_o.sroa.66.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true170 ], [ %54, %if.end202 ], [ zeroinitializer, %if.end165 ], !dbg !79
  %acc_o.sroa.34.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true170 ], [ %53, %if.end202 ], [ zeroinitializer, %if.end165 ], !dbg !79
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true170 ], [ %52, %if.end202 ], [ zeroinitializer, %if.end165 ], !dbg !79
  %sum_acc.sroa.56.0 = phi float [ 0.000000e+00, %land.lhs.true170 ], [ %43, %if.end202 ], [ 0.000000e+00, %if.end165 ], !dbg !79
  %sum_acc.sroa.38.0 = phi float [ 0.000000e+00, %land.lhs.true170 ], [ %41, %if.end202 ], [ 0.000000e+00, %if.end165 ], !dbg !79
  %sum_acc.sroa.20.0 = phi float [ 0.000000e+00, %land.lhs.true170 ], [ %39, %if.end202 ], [ 0.000000e+00, %if.end165 ], !dbg !79
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %land.lhs.true170 ], [ %37, %if.end202 ], [ 0.000000e+00, %if.end165 ], !dbg !79
  %or.cond2280 = icmp ugt i32 %mul11.2, 1023, !dbg !102
  %cmp297.not = icmp sgt i32 %mul11.2, %1
  %or.cond2281 = or i1 %or.cond2280, %cmp297.not, !dbg !102
  br i1 %or.cond2281, label %if.end322, label %for.cond299.preheader, !dbg !102

for.cond299.preheader:                            ; preds = %if.end290
  %mul304 = shl nsw i32 %0, 16
  %56 = shl nsw i32 %cond.i.i2150.2, 10
  %mul306 = and i32 %56, 64512
  %mul311 = shl nuw nsw i32 %18, 3
  %add307 = or disjoint i32 %mul311, %mul304
  %add309 = add nuw nsw i32 %add307, %mul306
  %57 = zext nneg i32 %add309 to i64, !dbg !103
  %add.ptr314 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %57, !dbg !104
  %K_ring0.sroa.0.0.copyload2942 = load <4 x half>, ptr addrspace(4) %add.ptr314, align 16, !dbg !105
  %K_ring0.sroa.10.0.add.ptr314.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr314, i64 8, !dbg !105
  %K_ring0.sroa.10.0.copyload2945 = load <4 x half>, ptr addrspace(4) %K_ring0.sroa.10.0.add.ptr314.sroa_idx, align 8, !dbg !105
  %58 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %57, !dbg !104
  %add.ptr314.1 = getelementptr inbounds i8, ptr addrspace(4) %58, i64 1024, !dbg !104
  %K_ring0.sroa.14.16.copyload2954 = load <4 x half>, ptr addrspace(4) %add.ptr314.1, align 16, !dbg !105
  %K_ring0.sroa.22.16.add.ptr314.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %58, i64 1032, !dbg !105
  %K_ring0.sroa.22.16.copyload2957 = load <4 x half>, ptr addrspace(4) %K_ring0.sroa.22.16.add.ptr314.1.sroa_idx, align 8, !dbg !105
  br label %if.end322, !dbg !106

if.end322:                                        ; preds = %for.cond299.preheader, %if.end290
  %K_ring0.sroa.22.1 = phi <4 x half> [ %K_ring0.sroa.22.0, %if.end290 ], [ %K_ring0.sroa.22.16.copyload2957, %for.cond299.preheader ]
  %K_ring0.sroa.14.1 = phi <4 x half> [ %K_ring0.sroa.14.0, %if.end290 ], [ %K_ring0.sroa.14.16.copyload2954, %for.cond299.preheader ]
  %K_ring0.sroa.10.1 = phi <4 x half> [ %K_ring0.sroa.10.0, %if.end290 ], [ %K_ring0.sroa.10.0.copyload2945, %for.cond299.preheader ]
  %K_ring0.sroa.0.1 = phi <4 x half> [ %K_ring0.sroa.0.0, %if.end290 ], [ %K_ring0.sroa.0.0.copyload2942, %for.cond299.preheader ]
  br i1 %or.cond2276, label %if.end354, label %for.cond331.preheader, !dbg !106

for.cond331.preheader:                            ; preds = %if.end322
  %mul336 = shl nsw i32 %0, 16
  %59 = shl nsw i32 %cond.i.i2150.1, 10
  %mul338 = and i32 %59, 64512
  %mul343 = shl nuw nsw i32 %18, 3
  %add339 = or disjoint i32 %mul343, %mul336
  %add341 = add nuw nsw i32 %add339, %mul338
  %60 = zext nneg i32 %add341 to i64, !dbg !107
  %add.ptr346 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %60, !dbg !108
  %V_ring0.sroa.0.0.copyload2866 = load <4 x half>, ptr addrspace(4) %add.ptr346, align 16, !dbg !109
  %V_ring0.sroa.18.0.add.ptr346.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr346, i64 8, !dbg !109
  %V_ring0.sroa.18.0.copyload2873 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.18.0.add.ptr346.sroa_idx, align 8, !dbg !109
  %61 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %60, !dbg !108
  %add.ptr346.1 = getelementptr inbounds i8, ptr addrspace(4) %61, i64 1024, !dbg !108
  %V_ring0.sroa.26.16.copyload2894 = load <4 x half>, ptr addrspace(4) %add.ptr346.1, align 16, !dbg !109
  %V_ring0.sroa.42.16.add.ptr346.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %61, i64 1032, !dbg !109
  %V_ring0.sroa.42.16.copyload2901 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.42.16.add.ptr346.1.sroa_idx, align 8, !dbg !109
  br label %if.end354, !dbg !110

if.end354:                                        ; preds = %for.cond331.preheader, %if.end322
  %V_ring0.sroa.42.1 = phi <4 x half> [ %V_ring0.sroa.42.0, %if.end322 ], [ %V_ring0.sroa.42.16.copyload2901, %for.cond331.preheader ]
  %V_ring0.sroa.26.1 = phi <4 x half> [ %V_ring0.sroa.26.0, %if.end322 ], [ %V_ring0.sroa.26.16.copyload2894, %for.cond331.preheader ]
  %V_ring0.sroa.18.1 = phi <4 x half> [ %V_ring0.sroa.18.0, %if.end322 ], [ %V_ring0.sroa.18.0.copyload2873, %for.cond331.preheader ]
  %V_ring0.sroa.0.1 = phi <4 x half> [ %V_ring0.sroa.0.0, %if.end322 ], [ %V_ring0.sroa.0.0.copyload2866, %for.cond331.preheader ]
  %or.cond2284 = icmp ult i32 %mul11.1, 1024, !dbg !110
  br i1 %or.cond2284, label %land.lhs.true359, label %if.end478, !dbg !110

land.lhs.true359:                                 ; preds = %if.end354
  br i1 %cmp106.not, label %if.end478, label %if.then362, !dbg !111

if.then362:                                       ; preds = %land.lhs.true359
  %add364 = or disjoint i32 %mul11.1, 15, !dbg !112
  %cmp365 = icmp ult i32 %1, %add364, !dbg !113
  br i1 %cmp365, label %for.cond367.preheader, label %if.end391, !dbg !114

for.cond367.preheader:                            ; preds = %if.then362
  %62 = lshr i32 %18, 2
  %mul373 = and i32 %62, 252
  %add374 = add nuw nsw i32 %mul11.1, %mul373
  %cmp377.not = icmp sgt i32 %add374, %1, !dbg !115
  %fneg.2135 = select i1 %cmp377.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2511 = insertelement <4 x float> poison, float %fneg.2135, i64 0, !dbg !116
  %cmp377.not.1.not = icmp slt i32 %add374, %1, !dbg !115
  %fneg.2135.1 = select i1 %cmp377.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2604 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2511, float %fneg.2135.1, i64 1, !dbg !116
  %add375.2 = or disjoint i32 %add374, 2, !dbg !117
  %cmp377.not.2 = icmp sgt i32 %add375.2, %1, !dbg !115
  %fneg.2135.2 = select i1 %cmp377.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2697 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2604, float %fneg.2135.2, i64 2, !dbg !116
  %add375.3 = or disjoint i32 %add374, 3, !dbg !117
  %cmp377.not.3 = icmp sgt i32 %add375.3, %1, !dbg !115
  %fneg.2135.3 = select i1 %cmp377.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2790 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2697, float %fneg.2135.3, i64 3, !dbg !116
  br label %if.end391

if.end391:                                        ; preds = %if.then362, %for.cond367.preheader
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2790, %for.cond367.preheader ], [ zeroinitializer, %if.then362 ], !dbg !79
  %63 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.2), !dbg !118, !call_argsrelate !81
  %64 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.10.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %63), !dbg !118, !call_argsrelate !81
  %65 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.14.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %64), !dbg !118, !call_argsrelate !81
  %66 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.22.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %65), !dbg !118, !call_argsrelate !81
  %acc_s.sroa.0.0.vec.extract2513 = extractelement <4 x float> %66, i64 0, !dbg !119
  %mul426 = fmul contract float %acc_s.sroa.0.0.vec.extract2513, 0x3FB99999A0000000, !dbg !120
  %67 = tail call contract noundef float @llvm.minnum.f32(float %mul426, float 0x4024CB5EC0000000), !dbg !121
  %68 = tail call contract noundef float @llvm.exp.f32(float %67), !dbg !123
  %acc_s.sroa.0.4.vec.extract2606 = extractelement <4 x float> %66, i64 1, !dbg !119
  %mul426.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2606, 0x3FB99999A0000000, !dbg !120
  %69 = tail call contract noundef float @llvm.minnum.f32(float %mul426.1, float 0x4024CB5EC0000000), !dbg !121
  %70 = tail call contract noundef float @llvm.exp.f32(float %69), !dbg !123
  %acc_s.sroa.0.8.vec.extract2699 = extractelement <4 x float> %66, i64 2, !dbg !119
  %mul426.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2699, 0x3FB99999A0000000, !dbg !120
  %71 = tail call contract noundef float @llvm.minnum.f32(float %mul426.2, float 0x4024CB5EC0000000), !dbg !121
  %72 = tail call contract noundef float @llvm.exp.f32(float %71), !dbg !123
  %acc_s.sroa.0.12.vec.extract2792 = extractelement <4 x float> %66, i64 3, !dbg !119
  %mul426.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2792, 0x3FB99999A0000000, !dbg !120
  %73 = tail call contract noundef float @llvm.minnum.f32(float %mul426.3, float 0x4024CB5EC0000000), !dbg !121
  %74 = tail call contract noundef float @llvm.exp.f32(float %73), !dbg !123
  %add442 = fadd contract float %sum_acc.sroa.0.0, %68, !dbg !125
  %add442.1 = fadd contract float %sum_acc.sroa.20.0, %70, !dbg !125
  %add442.2 = fadd contract float %sum_acc.sroa.38.0, %72, !dbg !125
  %add442.3 = fadd contract float %sum_acc.sroa.56.0, %74, !dbg !125
  %75 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %68), !dbg !126
  %76 = insertelement <4 x i16> poison, i16 %75, i64 0, !dbg !130
  %77 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %70), !dbg !126
  %78 = insertelement <4 x i16> %76, i16 %77, i64 1, !dbg !130
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %72), !dbg !126
  %80 = insertelement <4 x i16> %78, i16 %79, i64 2, !dbg !130
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %74), !dbg !126
  %82 = insertelement <4 x i16> %80, i16 %81, i64 3, !dbg !130
  %acc_s_cast.sroa.0.6.vec.insert2466 = bitcast <4 x i16> %82 to <4 x half>, !dbg !130
  %83 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.0.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2466, <4 x float> zeroinitializer), !dbg !131
  %84 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.18.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2466, <4 x float> zeroinitializer), !dbg !131
  %85 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.26.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2466, <4 x float> zeroinitializer), !dbg !131
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.42.1, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2466, <4 x float> zeroinitializer), !dbg !131
  br label %if.end478, !dbg !132

if.end478:                                        ; preds = %if.end391, %land.lhs.true359, %if.end354
  %acc_o_alt.sroa.50.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true359 ], [ %86, %if.end391 ], [ zeroinitializer, %if.end354 ], !dbg !79
  %acc_o_alt.sroa.34.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true359 ], [ %85, %if.end391 ], [ zeroinitializer, %if.end354 ], !dbg !79
  %acc_o_alt.sroa.18.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true359 ], [ %84, %if.end391 ], [ zeroinitializer, %if.end354 ], !dbg !79
  %acc_o_alt.sroa.0.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true359 ], [ %83, %if.end391 ], [ zeroinitializer, %if.end354 ], !dbg !79
  %sum_acc.sroa.56.1 = phi float [ %sum_acc.sroa.56.0, %land.lhs.true359 ], [ %add442.3, %if.end391 ], [ %sum_acc.sroa.56.0, %if.end354 ], !dbg !79
  %sum_acc.sroa.38.1 = phi float [ %sum_acc.sroa.38.0, %land.lhs.true359 ], [ %add442.2, %if.end391 ], [ %sum_acc.sroa.38.0, %if.end354 ], !dbg !79
  %sum_acc.sroa.20.1 = phi float [ %sum_acc.sroa.20.0, %land.lhs.true359 ], [ %add442.1, %if.end391 ], [ %sum_acc.sroa.20.0, %if.end354 ], !dbg !79
  %sum_acc.sroa.0.1 = phi float [ %sum_acc.sroa.0.0, %land.lhs.true359 ], [ %add442, %if.end391 ], [ %sum_acc.sroa.0.0, %if.end354 ], !dbg !79
  %or.cond2285 = icmp ugt i32 %mul11.3, 1023, !dbg !133
  %cmp485.not = icmp sgt i32 %mul11.3, %1
  %or.cond2286 = or i1 %or.cond2285, %cmp485.not, !dbg !133
  br i1 %or.cond2286, label %if.end510, label %for.cond487.preheader, !dbg !133

for.cond487.preheader:                            ; preds = %if.end478
  %mul492 = shl nsw i32 %0, 16
  %87 = shl nsw i32 %cond.i.i2150.3, 10
  %mul494 = and i32 %87, 64512
  %mul499 = shl nuw nsw i32 %18, 3
  %add495 = or disjoint i32 %mul499, %mul492
  %add497 = add nuw nsw i32 %add495, %mul494
  %88 = zext nneg i32 %add497 to i64, !dbg !134
  %add.ptr502 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %88, !dbg !135
  %K_ring1.sroa.0.0.copyload2918 = load <4 x half>, ptr addrspace(4) %add.ptr502, align 16, !dbg !136
  %K_ring1.sroa.10.0.add.ptr502.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr502, i64 8, !dbg !136
  %K_ring1.sroa.10.0.copyload2921 = load <4 x half>, ptr addrspace(4) %K_ring1.sroa.10.0.add.ptr502.sroa_idx, align 8, !dbg !136
  %89 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %88, !dbg !135
  %add.ptr502.1 = getelementptr inbounds i8, ptr addrspace(4) %89, i64 1024, !dbg !135
  %K_ring1.sroa.14.16.copyload2930 = load <4 x half>, ptr addrspace(4) %add.ptr502.1, align 16, !dbg !136
  %K_ring1.sroa.22.16.add.ptr502.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %89, i64 1032, !dbg !136
  %K_ring1.sroa.22.16.copyload2933 = load <4 x half>, ptr addrspace(4) %K_ring1.sroa.22.16.add.ptr502.1.sroa_idx, align 8, !dbg !136
  br label %if.end510, !dbg !137

if.end510:                                        ; preds = %for.cond487.preheader, %if.end478
  %K_ring1.sroa.22.1 = phi <4 x half> [ %K_ring1.sroa.22.0, %if.end478 ], [ %K_ring1.sroa.22.16.copyload2933, %for.cond487.preheader ]
  %K_ring1.sroa.14.1 = phi <4 x half> [ %K_ring1.sroa.14.0, %if.end478 ], [ %K_ring1.sroa.14.16.copyload2930, %for.cond487.preheader ]
  %K_ring1.sroa.10.1 = phi <4 x half> [ %K_ring1.sroa.10.0, %if.end478 ], [ %K_ring1.sroa.10.0.copyload2921, %for.cond487.preheader ]
  %K_ring1.sroa.0.1 = phi <4 x half> [ %K_ring1.sroa.0.0, %if.end478 ], [ %K_ring1.sroa.0.0.copyload2918, %for.cond487.preheader ]
  br i1 %or.cond2281, label %if.end542, label %for.cond519.preheader, !dbg !137

for.cond519.preheader:                            ; preds = %if.end510
  %mul524 = shl nsw i32 %0, 16
  %90 = shl nsw i32 %cond.i.i2150.2, 10
  %mul526 = and i32 %90, 64512
  %mul531 = shl nuw nsw i32 %18, 3
  %add527 = or disjoint i32 %mul531, %mul524
  %add529 = add nuw nsw i32 %add527, %mul526
  %91 = zext nneg i32 %add529 to i64, !dbg !138
  %add.ptr534 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %91, !dbg !139
  %V_ring0.sroa.0.0.copyload2867 = load <4 x half>, ptr addrspace(4) %add.ptr534, align 16, !dbg !140
  %V_ring0.sroa.18.0.add.ptr534.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr534, i64 8, !dbg !140
  %V_ring0.sroa.18.0.copyload2874 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.18.0.add.ptr534.sroa_idx, align 8, !dbg !140
  %92 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %91, !dbg !139
  %add.ptr534.1 = getelementptr inbounds i8, ptr addrspace(4) %92, i64 1024, !dbg !139
  %V_ring0.sroa.26.16.copyload2895 = load <4 x half>, ptr addrspace(4) %add.ptr534.1, align 16, !dbg !140
  %V_ring0.sroa.42.16.add.ptr534.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %92, i64 1032, !dbg !140
  %V_ring0.sroa.42.16.copyload2902 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.42.16.add.ptr534.1.sroa_idx, align 8, !dbg !140
  br label %if.end542, !dbg !141

if.end542:                                        ; preds = %for.cond519.preheader, %if.end510
  %V_ring0.sroa.42.2 = phi <4 x half> [ %V_ring0.sroa.42.1, %if.end510 ], [ %V_ring0.sroa.42.16.copyload2902, %for.cond519.preheader ]
  %V_ring0.sroa.26.2 = phi <4 x half> [ %V_ring0.sroa.26.1, %if.end510 ], [ %V_ring0.sroa.26.16.copyload2895, %for.cond519.preheader ]
  %V_ring0.sroa.18.2 = phi <4 x half> [ %V_ring0.sroa.18.1, %if.end510 ], [ %V_ring0.sroa.18.0.copyload2874, %for.cond519.preheader ]
  %V_ring0.sroa.0.2 = phi <4 x half> [ %V_ring0.sroa.0.1, %if.end510 ], [ %V_ring0.sroa.0.0.copyload2867, %for.cond519.preheader ]
  %or.cond2289 = icmp ult i32 %mul11.2, 1024, !dbg !141
  br i1 %or.cond2289, label %land.lhs.true547, label %if.end666, !dbg !141

land.lhs.true547:                                 ; preds = %if.end542
  br i1 %cmp297.not, label %if.end666, label %if.then550, !dbg !142

if.then550:                                       ; preds = %land.lhs.true547
  %add552 = or disjoint i32 %mul11.2, 15, !dbg !143
  %cmp553 = icmp ult i32 %1, %add552, !dbg !144
  br i1 %cmp553, label %for.cond555.preheader, label %if.end579, !dbg !145

for.cond555.preheader:                            ; preds = %if.then550
  %93 = lshr i32 %18, 2
  %mul561 = and i32 %93, 252
  %add562 = add nuw nsw i32 %mul11.2, %mul561
  %cmp565.not = icmp sgt i32 %add562, %1, !dbg !146
  %fneg.2136 = select i1 %cmp565.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2521 = insertelement <4 x float> poison, float %fneg.2136, i64 0, !dbg !147
  %cmp565.not.1.not = icmp slt i32 %add562, %1, !dbg !146
  %fneg.2136.1 = select i1 %cmp565.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2614 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2521, float %fneg.2136.1, i64 1, !dbg !147
  %add563.2 = or disjoint i32 %add562, 2, !dbg !148
  %cmp565.not.2 = icmp sgt i32 %add563.2, %1, !dbg !146
  %fneg.2136.2 = select i1 %cmp565.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2707 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2614, float %fneg.2136.2, i64 2, !dbg !147
  %add563.3 = or disjoint i32 %add562, 3, !dbg !148
  %cmp565.not.3 = icmp sgt i32 %add563.3, %1, !dbg !146
  %fneg.2136.3 = select i1 %cmp565.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2800 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2707, float %fneg.2136.3, i64 3, !dbg !147
  br label %if.end579

if.end579:                                        ; preds = %if.then550, %for.cond555.preheader
  %acc_s.sroa.0.4 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2800, %for.cond555.preheader ], [ zeroinitializer, %if.then550 ], !dbg !79
  %94 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.4), !dbg !149, !call_argsrelate !81
  %95 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.10.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %94), !dbg !149, !call_argsrelate !81
  %96 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.14.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %95), !dbg !149, !call_argsrelate !81
  %97 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.22.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %96), !dbg !149, !call_argsrelate !81
  %acc_s.sroa.0.0.vec.extract2523 = extractelement <4 x float> %97, i64 0, !dbg !150
  %mul614 = fmul contract float %acc_s.sroa.0.0.vec.extract2523, 0x3FB99999A0000000, !dbg !151
  %98 = tail call contract noundef float @llvm.minnum.f32(float %mul614, float 0x4024CB5EC0000000), !dbg !152
  %99 = tail call contract noundef float @llvm.exp.f32(float %98), !dbg !154
  %acc_s.sroa.0.4.vec.extract2616 = extractelement <4 x float> %97, i64 1, !dbg !150
  %mul614.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2616, 0x3FB99999A0000000, !dbg !151
  %100 = tail call contract noundef float @llvm.minnum.f32(float %mul614.1, float 0x4024CB5EC0000000), !dbg !152
  %101 = tail call contract noundef float @llvm.exp.f32(float %100), !dbg !154
  %acc_s.sroa.0.8.vec.extract2709 = extractelement <4 x float> %97, i64 2, !dbg !150
  %mul614.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2709, 0x3FB99999A0000000, !dbg !151
  %102 = tail call contract noundef float @llvm.minnum.f32(float %mul614.2, float 0x4024CB5EC0000000), !dbg !152
  %103 = tail call contract noundef float @llvm.exp.f32(float %102), !dbg !154
  %acc_s.sroa.0.12.vec.extract2802 = extractelement <4 x float> %97, i64 3, !dbg !150
  %mul614.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2802, 0x3FB99999A0000000, !dbg !151
  %104 = tail call contract noundef float @llvm.minnum.f32(float %mul614.3, float 0x4024CB5EC0000000), !dbg !152
  %105 = tail call contract noundef float @llvm.exp.f32(float %104), !dbg !154
  %add630 = fadd contract float %sum_acc.sroa.0.1, %99, !dbg !156
  %add630.1 = fadd contract float %sum_acc.sroa.20.1, %101, !dbg !156
  %add630.2 = fadd contract float %sum_acc.sroa.38.1, %103, !dbg !156
  %add630.3 = fadd contract float %sum_acc.sroa.56.1, %105, !dbg !156
  %106 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %99), !dbg !157
  %107 = insertelement <4 x i16> poison, i16 %106, i64 0, !dbg !161
  %108 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %101), !dbg !157
  %109 = insertelement <4 x i16> %107, i16 %108, i64 1, !dbg !161
  %110 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %103), !dbg !157
  %111 = insertelement <4 x i16> %109, i16 %110, i64 2, !dbg !161
  %112 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %105), !dbg !157
  %113 = insertelement <4 x i16> %111, i16 %112, i64 3, !dbg !161
  %acc_s_cast.sroa.0.6.vec.insert2468 = bitcast <4 x i16> %113 to <4 x half>, !dbg !161
  %114 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.0.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2468, <4 x float> %acc_o.sroa.0.0), !dbg !162
  %115 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.18.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2468, <4 x float> %acc_o.sroa.34.0), !dbg !162
  %116 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.26.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2468, <4 x float> %acc_o.sroa.66.0), !dbg !162
  %117 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.42.2, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2468, <4 x float> %acc_o.sroa.98.0), !dbg !162
  br label %if.end666, !dbg !163

if.end666:                                        ; preds = %if.end579, %land.lhs.true547, %if.end542
  %acc_o.sroa.98.1 = phi <4 x float> [ %acc_o.sroa.98.0, %land.lhs.true547 ], [ %117, %if.end579 ], [ %acc_o.sroa.98.0, %if.end542 ], !dbg !79
  %acc_o.sroa.66.1 = phi <4 x float> [ %acc_o.sroa.66.0, %land.lhs.true547 ], [ %116, %if.end579 ], [ %acc_o.sroa.66.0, %if.end542 ], !dbg !79
  %acc_o.sroa.34.1 = phi <4 x float> [ %acc_o.sroa.34.0, %land.lhs.true547 ], [ %115, %if.end579 ], [ %acc_o.sroa.34.0, %if.end542 ], !dbg !79
  %acc_o.sroa.0.1 = phi <4 x float> [ %acc_o.sroa.0.0, %land.lhs.true547 ], [ %114, %if.end579 ], [ %acc_o.sroa.0.0, %if.end542 ], !dbg !79
  %sum_acc.sroa.56.2 = phi float [ %sum_acc.sroa.56.1, %land.lhs.true547 ], [ %add630.3, %if.end579 ], [ %sum_acc.sroa.56.1, %if.end542 ], !dbg !79
  %sum_acc.sroa.38.2 = phi float [ %sum_acc.sroa.38.1, %land.lhs.true547 ], [ %add630.2, %if.end579 ], [ %sum_acc.sroa.38.1, %if.end542 ], !dbg !79
  %sum_acc.sroa.20.2 = phi float [ %sum_acc.sroa.20.1, %land.lhs.true547 ], [ %add630.1, %if.end579 ], [ %sum_acc.sroa.20.1, %if.end542 ], !dbg !79
  %sum_acc.sroa.0.2 = phi float [ %sum_acc.sroa.0.1, %land.lhs.true547 ], [ %add630, %if.end579 ], [ %sum_acc.sroa.0.1, %if.end542 ], !dbg !79
  %or.cond2290 = icmp ugt i32 %mul11.4, 1023, !dbg !164
  %cmp673.not = icmp sgt i32 %mul11.4, %1
  %or.cond2291 = or i1 %or.cond2290, %cmp673.not, !dbg !164
  br i1 %or.cond2291, label %if.end698, label %for.cond675.preheader, !dbg !164

for.cond675.preheader:                            ; preds = %if.end666
  %mul680 = shl nsw i32 %0, 16
  %118 = shl nsw i32 %cond.i.i2150.4, 10
  %mul682 = and i32 %118, 64512
  %mul687 = shl nuw nsw i32 %18, 3
  %add683 = or disjoint i32 %mul687, %mul680
  %add685 = add nuw nsw i32 %add683, %mul682
  %119 = zext nneg i32 %add685 to i64, !dbg !165
  %add.ptr690 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %119, !dbg !166
  %K_ring0.sroa.0.0.copyload2943 = load <4 x half>, ptr addrspace(4) %add.ptr690, align 16, !dbg !167
  %K_ring0.sroa.10.0.add.ptr690.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr690, i64 8, !dbg !167
  %K_ring0.sroa.10.0.copyload2946 = load <4 x half>, ptr addrspace(4) %K_ring0.sroa.10.0.add.ptr690.sroa_idx, align 8, !dbg !167
  %120 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %119, !dbg !166
  %add.ptr690.1 = getelementptr inbounds i8, ptr addrspace(4) %120, i64 1024, !dbg !166
  %K_ring0.sroa.14.16.copyload2955 = load <4 x half>, ptr addrspace(4) %add.ptr690.1, align 16, !dbg !167
  %K_ring0.sroa.22.16.add.ptr690.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %120, i64 1032, !dbg !167
  %K_ring0.sroa.22.16.copyload2958 = load <4 x half>, ptr addrspace(4) %K_ring0.sroa.22.16.add.ptr690.1.sroa_idx, align 8, !dbg !167
  br label %if.end698, !dbg !168

if.end698:                                        ; preds = %for.cond675.preheader, %if.end666
  %K_ring0.sroa.22.2 = phi <4 x half> [ %K_ring0.sroa.22.1, %if.end666 ], [ %K_ring0.sroa.22.16.copyload2958, %for.cond675.preheader ]
  %K_ring0.sroa.14.2 = phi <4 x half> [ %K_ring0.sroa.14.1, %if.end666 ], [ %K_ring0.sroa.14.16.copyload2955, %for.cond675.preheader ]
  %K_ring0.sroa.10.2 = phi <4 x half> [ %K_ring0.sroa.10.1, %if.end666 ], [ %K_ring0.sroa.10.0.copyload2946, %for.cond675.preheader ]
  %K_ring0.sroa.0.2 = phi <4 x half> [ %K_ring0.sroa.0.1, %if.end666 ], [ %K_ring0.sroa.0.0.copyload2943, %for.cond675.preheader ]
  br i1 %or.cond2286, label %if.end730, label %for.cond707.preheader, !dbg !168

for.cond707.preheader:                            ; preds = %if.end698
  %mul712 = shl nsw i32 %0, 16
  %121 = shl nsw i32 %cond.i.i2150.3, 10
  %mul714 = and i32 %121, 64512
  %mul719 = shl nuw nsw i32 %18, 3
  %add715 = or disjoint i32 %mul719, %mul712
  %add717 = add nuw nsw i32 %add715, %mul714
  %122 = zext nneg i32 %add717 to i64, !dbg !169
  %add.ptr722 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %122, !dbg !170
  %V_ring0.sroa.0.0.copyload2868 = load <4 x half>, ptr addrspace(4) %add.ptr722, align 16, !dbg !171
  %V_ring0.sroa.18.0.add.ptr722.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr722, i64 8, !dbg !171
  %V_ring0.sroa.18.0.copyload2875 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.18.0.add.ptr722.sroa_idx, align 8, !dbg !171
  %123 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %122, !dbg !170
  %add.ptr722.1 = getelementptr inbounds i8, ptr addrspace(4) %123, i64 1024, !dbg !170
  %V_ring0.sroa.26.16.copyload2896 = load <4 x half>, ptr addrspace(4) %add.ptr722.1, align 16, !dbg !171
  %V_ring0.sroa.42.16.add.ptr722.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %123, i64 1032, !dbg !171
  %V_ring0.sroa.42.16.copyload2903 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.42.16.add.ptr722.1.sroa_idx, align 8, !dbg !171
  br label %if.end730, !dbg !172

if.end730:                                        ; preds = %for.cond707.preheader, %if.end698
  %V_ring0.sroa.42.3 = phi <4 x half> [ %V_ring0.sroa.42.2, %if.end698 ], [ %V_ring0.sroa.42.16.copyload2903, %for.cond707.preheader ]
  %V_ring0.sroa.26.3 = phi <4 x half> [ %V_ring0.sroa.26.2, %if.end698 ], [ %V_ring0.sroa.26.16.copyload2896, %for.cond707.preheader ]
  %V_ring0.sroa.18.3 = phi <4 x half> [ %V_ring0.sroa.18.2, %if.end698 ], [ %V_ring0.sroa.18.0.copyload2875, %for.cond707.preheader ]
  %V_ring0.sroa.0.3 = phi <4 x half> [ %V_ring0.sroa.0.2, %if.end698 ], [ %V_ring0.sroa.0.0.copyload2868, %for.cond707.preheader ]
  %or.cond2294 = icmp ult i32 %mul11.3, 1024, !dbg !172
  br i1 %or.cond2294, label %land.lhs.true735, label %if.end854, !dbg !172

land.lhs.true735:                                 ; preds = %if.end730
  br i1 %cmp485.not, label %if.end854, label %if.then738, !dbg !173

if.then738:                                       ; preds = %land.lhs.true735
  %add740 = or disjoint i32 %mul11.3, 15, !dbg !174
  %cmp741 = icmp ult i32 %1, %add740, !dbg !175
  br i1 %cmp741, label %for.cond743.preheader, label %if.end767, !dbg !176

for.cond743.preheader:                            ; preds = %if.then738
  %124 = lshr i32 %18, 2
  %mul749 = and i32 %124, 252
  %add750 = add nuw nsw i32 %mul11.3, %mul749
  %cmp753.not = icmp sgt i32 %add750, %1, !dbg !177
  %fneg.2137 = select i1 %cmp753.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2531 = insertelement <4 x float> poison, float %fneg.2137, i64 0, !dbg !178
  %cmp753.not.1.not = icmp slt i32 %add750, %1, !dbg !177
  %fneg.2137.1 = select i1 %cmp753.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2624 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2531, float %fneg.2137.1, i64 1, !dbg !178
  %add751.2 = or disjoint i32 %add750, 2, !dbg !179
  %cmp753.not.2 = icmp sgt i32 %add751.2, %1, !dbg !177
  %fneg.2137.2 = select i1 %cmp753.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2717 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2624, float %fneg.2137.2, i64 2, !dbg !178
  %add751.3 = or disjoint i32 %add750, 3, !dbg !179
  %cmp753.not.3 = icmp sgt i32 %add751.3, %1, !dbg !177
  %fneg.2137.3 = select i1 %cmp753.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2810 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2717, float %fneg.2137.3, i64 3, !dbg !178
  br label %if.end767

if.end767:                                        ; preds = %if.then738, %for.cond743.preheader
  %acc_s.sroa.0.6 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2810, %for.cond743.preheader ], [ zeroinitializer, %if.then738 ], !dbg !79
  %125 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.6), !dbg !180, !call_argsrelate !81
  %126 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.10.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %125), !dbg !180, !call_argsrelate !81
  %127 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.14.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %126), !dbg !180, !call_argsrelate !81
  %128 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.22.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %127), !dbg !180, !call_argsrelate !81
  %acc_s.sroa.0.0.vec.extract2533 = extractelement <4 x float> %128, i64 0, !dbg !181
  %mul802 = fmul contract float %acc_s.sroa.0.0.vec.extract2533, 0x3FB99999A0000000, !dbg !182
  %129 = tail call contract noundef float @llvm.minnum.f32(float %mul802, float 0x4024CB5EC0000000), !dbg !183
  %130 = tail call contract noundef float @llvm.exp.f32(float %129), !dbg !185
  %acc_s.sroa.0.4.vec.extract2626 = extractelement <4 x float> %128, i64 1, !dbg !181
  %mul802.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2626, 0x3FB99999A0000000, !dbg !182
  %131 = tail call contract noundef float @llvm.minnum.f32(float %mul802.1, float 0x4024CB5EC0000000), !dbg !183
  %132 = tail call contract noundef float @llvm.exp.f32(float %131), !dbg !185
  %acc_s.sroa.0.8.vec.extract2719 = extractelement <4 x float> %128, i64 2, !dbg !181
  %mul802.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2719, 0x3FB99999A0000000, !dbg !182
  %133 = tail call contract noundef float @llvm.minnum.f32(float %mul802.2, float 0x4024CB5EC0000000), !dbg !183
  %134 = tail call contract noundef float @llvm.exp.f32(float %133), !dbg !185
  %acc_s.sroa.0.12.vec.extract2812 = extractelement <4 x float> %128, i64 3, !dbg !181
  %mul802.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2812, 0x3FB99999A0000000, !dbg !182
  %135 = tail call contract noundef float @llvm.minnum.f32(float %mul802.3, float 0x4024CB5EC0000000), !dbg !183
  %136 = tail call contract noundef float @llvm.exp.f32(float %135), !dbg !185
  %add818 = fadd contract float %sum_acc.sroa.0.2, %130, !dbg !187
  %add818.1 = fadd contract float %sum_acc.sroa.20.2, %132, !dbg !187
  %add818.2 = fadd contract float %sum_acc.sroa.38.2, %134, !dbg !187
  %add818.3 = fadd contract float %sum_acc.sroa.56.2, %136, !dbg !187
  %137 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %130), !dbg !188
  %138 = insertelement <4 x i16> poison, i16 %137, i64 0, !dbg !192
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %132), !dbg !188
  %140 = insertelement <4 x i16> %138, i16 %139, i64 1, !dbg !192
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %134), !dbg !188
  %142 = insertelement <4 x i16> %140, i16 %141, i64 2, !dbg !192
  %143 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %136), !dbg !188
  %144 = insertelement <4 x i16> %142, i16 %143, i64 3, !dbg !192
  %acc_s_cast.sroa.0.6.vec.insert2470 = bitcast <4 x i16> %144 to <4 x half>, !dbg !192
  %145 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.0.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2470, <4 x float> %acc_o_alt.sroa.0.0), !dbg !193
  %146 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.18.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2470, <4 x float> %acc_o_alt.sroa.18.0), !dbg !193
  %147 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.26.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2470, <4 x float> %acc_o_alt.sroa.34.0), !dbg !193
  %148 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.42.3, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2470, <4 x float> %acc_o_alt.sroa.50.0), !dbg !193
  br label %if.end854, !dbg !194

if.end854:                                        ; preds = %if.end767, %land.lhs.true735, %if.end730
  %acc_o_alt.sroa.50.1 = phi <4 x float> [ %acc_o_alt.sroa.50.0, %land.lhs.true735 ], [ %148, %if.end767 ], [ %acc_o_alt.sroa.50.0, %if.end730 ], !dbg !79
  %acc_o_alt.sroa.34.1 = phi <4 x float> [ %acc_o_alt.sroa.34.0, %land.lhs.true735 ], [ %147, %if.end767 ], [ %acc_o_alt.sroa.34.0, %if.end730 ], !dbg !79
  %acc_o_alt.sroa.18.1 = phi <4 x float> [ %acc_o_alt.sroa.18.0, %land.lhs.true735 ], [ %146, %if.end767 ], [ %acc_o_alt.sroa.18.0, %if.end730 ], !dbg !79
  %acc_o_alt.sroa.0.1 = phi <4 x float> [ %acc_o_alt.sroa.0.0, %land.lhs.true735 ], [ %145, %if.end767 ], [ %acc_o_alt.sroa.0.0, %if.end730 ], !dbg !79
  %sum_acc.sroa.56.3 = phi float [ %sum_acc.sroa.56.2, %land.lhs.true735 ], [ %add818.3, %if.end767 ], [ %sum_acc.sroa.56.2, %if.end730 ], !dbg !79
  %sum_acc.sroa.38.3 = phi float [ %sum_acc.sroa.38.2, %land.lhs.true735 ], [ %add818.2, %if.end767 ], [ %sum_acc.sroa.38.2, %if.end730 ], !dbg !79
  %sum_acc.sroa.20.3 = phi float [ %sum_acc.sroa.20.2, %land.lhs.true735 ], [ %add818.1, %if.end767 ], [ %sum_acc.sroa.20.2, %if.end730 ], !dbg !79
  %sum_acc.sroa.0.3 = phi float [ %sum_acc.sroa.0.2, %land.lhs.true735 ], [ %add818, %if.end767 ], [ %sum_acc.sroa.0.2, %if.end730 ], !dbg !79
  %or.cond2295 = icmp ugt i32 %mul11.5, 1023, !dbg !195
  %cmp861.not = icmp sgt i32 %mul11.5, %1
  %or.cond2296 = or i1 %or.cond2295, %cmp861.not, !dbg !195
  br i1 %or.cond2296, label %if.end886, label %for.cond863.preheader, !dbg !195

for.cond863.preheader:                            ; preds = %if.end854
  %mul868 = shl nsw i32 %0, 16
  %149 = shl nsw i32 %cond.i.i2150.5, 10
  %mul870 = and i32 %149, 64512
  %mul875 = shl nuw nsw i32 %18, 3
  %add871 = or disjoint i32 %mul875, %mul868
  %add873 = add nuw nsw i32 %add871, %mul870
  %150 = zext nneg i32 %add873 to i64, !dbg !196
  %add.ptr878 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %150, !dbg !197
  %K_ring1.sroa.0.0.copyload2919 = load <4 x half>, ptr addrspace(4) %add.ptr878, align 16, !dbg !198
  %K_ring1.sroa.10.0.add.ptr878.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr878, i64 8, !dbg !198
  %K_ring1.sroa.10.0.copyload2922 = load <4 x half>, ptr addrspace(4) %K_ring1.sroa.10.0.add.ptr878.sroa_idx, align 8, !dbg !198
  %151 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %150, !dbg !197
  %add.ptr878.1 = getelementptr inbounds i8, ptr addrspace(4) %151, i64 1024, !dbg !197
  %K_ring1.sroa.14.16.copyload2931 = load <4 x half>, ptr addrspace(4) %add.ptr878.1, align 16, !dbg !198
  %K_ring1.sroa.22.16.add.ptr878.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %151, i64 1032, !dbg !198
  %K_ring1.sroa.22.16.copyload2934 = load <4 x half>, ptr addrspace(4) %K_ring1.sroa.22.16.add.ptr878.1.sroa_idx, align 8, !dbg !198
  br label %if.end886, !dbg !199

if.end886:                                        ; preds = %for.cond863.preheader, %if.end854
  %K_ring1.sroa.22.2 = phi <4 x half> [ %K_ring1.sroa.22.1, %if.end854 ], [ %K_ring1.sroa.22.16.copyload2934, %for.cond863.preheader ]
  %K_ring1.sroa.14.2 = phi <4 x half> [ %K_ring1.sroa.14.1, %if.end854 ], [ %K_ring1.sroa.14.16.copyload2931, %for.cond863.preheader ]
  %K_ring1.sroa.10.2 = phi <4 x half> [ %K_ring1.sroa.10.1, %if.end854 ], [ %K_ring1.sroa.10.0.copyload2922, %for.cond863.preheader ]
  %K_ring1.sroa.0.2 = phi <4 x half> [ %K_ring1.sroa.0.1, %if.end854 ], [ %K_ring1.sroa.0.0.copyload2919, %for.cond863.preheader ]
  br i1 %or.cond2291, label %if.end918, label %for.cond895.preheader, !dbg !199

for.cond895.preheader:                            ; preds = %if.end886
  %mul900 = shl nsw i32 %0, 16
  %152 = shl nsw i32 %cond.i.i2150.4, 10
  %mul902 = and i32 %152, 64512
  %mul907 = shl nuw nsw i32 %18, 3
  %add903 = or disjoint i32 %mul907, %mul900
  %add905 = add nuw nsw i32 %add903, %mul902
  %153 = zext nneg i32 %add905 to i64, !dbg !200
  %add.ptr910 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %153, !dbg !201
  %V_ring0.sroa.0.0.copyload2869 = load <4 x half>, ptr addrspace(4) %add.ptr910, align 16, !dbg !202
  %V_ring0.sroa.18.0.add.ptr910.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr910, i64 8, !dbg !202
  %V_ring0.sroa.18.0.copyload2876 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.18.0.add.ptr910.sroa_idx, align 8, !dbg !202
  %154 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %153, !dbg !201
  %add.ptr910.1 = getelementptr inbounds i8, ptr addrspace(4) %154, i64 1024, !dbg !201
  %V_ring0.sroa.26.16.copyload2897 = load <4 x half>, ptr addrspace(4) %add.ptr910.1, align 16, !dbg !202
  %V_ring0.sroa.42.16.add.ptr910.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %154, i64 1032, !dbg !202
  %V_ring0.sroa.42.16.copyload2904 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.42.16.add.ptr910.1.sroa_idx, align 8, !dbg !202
  br label %if.end918, !dbg !203

if.end918:                                        ; preds = %for.cond895.preheader, %if.end886
  %V_ring0.sroa.42.4 = phi <4 x half> [ %V_ring0.sroa.42.3, %if.end886 ], [ %V_ring0.sroa.42.16.copyload2904, %for.cond895.preheader ]
  %V_ring0.sroa.26.4 = phi <4 x half> [ %V_ring0.sroa.26.3, %if.end886 ], [ %V_ring0.sroa.26.16.copyload2897, %for.cond895.preheader ]
  %V_ring0.sroa.18.4 = phi <4 x half> [ %V_ring0.sroa.18.3, %if.end886 ], [ %V_ring0.sroa.18.0.copyload2876, %for.cond895.preheader ]
  %V_ring0.sroa.0.4 = phi <4 x half> [ %V_ring0.sroa.0.3, %if.end886 ], [ %V_ring0.sroa.0.0.copyload2869, %for.cond895.preheader ]
  %or.cond2299 = icmp ult i32 %mul11.4, 1024, !dbg !203
  br i1 %or.cond2299, label %land.lhs.true923, label %if.end1042, !dbg !203

land.lhs.true923:                                 ; preds = %if.end918
  br i1 %cmp673.not, label %if.end1042, label %if.then926, !dbg !204

if.then926:                                       ; preds = %land.lhs.true923
  %add928 = or disjoint i32 %mul11.4, 15, !dbg !205
  %cmp929 = icmp ult i32 %1, %add928, !dbg !206
  br i1 %cmp929, label %for.cond931.preheader, label %if.end955, !dbg !207

for.cond931.preheader:                            ; preds = %if.then926
  %155 = lshr i32 %18, 2
  %mul937 = and i32 %155, 252
  %add938 = add nuw nsw i32 %mul11.4, %mul937
  %cmp941.not = icmp sgt i32 %add938, %1, !dbg !208
  %fneg.2138 = select i1 %cmp941.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2541 = insertelement <4 x float> poison, float %fneg.2138, i64 0, !dbg !209
  %cmp941.not.1.not = icmp slt i32 %add938, %1, !dbg !208
  %fneg.2138.1 = select i1 %cmp941.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2634 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2541, float %fneg.2138.1, i64 1, !dbg !209
  %add939.2 = or disjoint i32 %add938, 2, !dbg !210
  %cmp941.not.2 = icmp sgt i32 %add939.2, %1, !dbg !208
  %fneg.2138.2 = select i1 %cmp941.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2727 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2634, float %fneg.2138.2, i64 2, !dbg !209
  %add939.3 = or disjoint i32 %add938, 3, !dbg !210
  %cmp941.not.3 = icmp sgt i32 %add939.3, %1, !dbg !208
  %fneg.2138.3 = select i1 %cmp941.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2820 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2727, float %fneg.2138.3, i64 3, !dbg !209
  br label %if.end955

if.end955:                                        ; preds = %if.then926, %for.cond931.preheader
  %acc_s.sroa.0.8 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2820, %for.cond931.preheader ], [ zeroinitializer, %if.then926 ], !dbg !79
  %156 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.0.2, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.8), !dbg !211, !call_argsrelate !81
  %157 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.10.2, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %156), !dbg !211, !call_argsrelate !81
  %158 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.14.2, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %157), !dbg !211, !call_argsrelate !81
  %159 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.22.2, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %158), !dbg !211, !call_argsrelate !81
  %acc_s.sroa.0.0.vec.extract2543 = extractelement <4 x float> %159, i64 0, !dbg !212
  %mul990 = fmul contract float %acc_s.sroa.0.0.vec.extract2543, 0x3FB99999A0000000, !dbg !213
  %160 = tail call contract noundef float @llvm.minnum.f32(float %mul990, float 0x4024CB5EC0000000), !dbg !214
  %161 = tail call contract noundef float @llvm.exp.f32(float %160), !dbg !216
  %acc_s.sroa.0.4.vec.extract2636 = extractelement <4 x float> %159, i64 1, !dbg !212
  %mul990.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2636, 0x3FB99999A0000000, !dbg !213
  %162 = tail call contract noundef float @llvm.minnum.f32(float %mul990.1, float 0x4024CB5EC0000000), !dbg !214
  %163 = tail call contract noundef float @llvm.exp.f32(float %162), !dbg !216
  %acc_s.sroa.0.8.vec.extract2729 = extractelement <4 x float> %159, i64 2, !dbg !212
  %mul990.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2729, 0x3FB99999A0000000, !dbg !213
  %164 = tail call contract noundef float @llvm.minnum.f32(float %mul990.2, float 0x4024CB5EC0000000), !dbg !214
  %165 = tail call contract noundef float @llvm.exp.f32(float %164), !dbg !216
  %acc_s.sroa.0.12.vec.extract2822 = extractelement <4 x float> %159, i64 3, !dbg !212
  %mul990.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2822, 0x3FB99999A0000000, !dbg !213
  %166 = tail call contract noundef float @llvm.minnum.f32(float %mul990.3, float 0x4024CB5EC0000000), !dbg !214
  %167 = tail call contract noundef float @llvm.exp.f32(float %166), !dbg !216
  %add1006 = fadd contract float %sum_acc.sroa.0.3, %161, !dbg !218
  %add1006.1 = fadd contract float %sum_acc.sroa.20.3, %163, !dbg !218
  %add1006.2 = fadd contract float %sum_acc.sroa.38.3, %165, !dbg !218
  %add1006.3 = fadd contract float %sum_acc.sroa.56.3, %167, !dbg !218
  %168 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %161), !dbg !219
  %169 = insertelement <4 x i16> poison, i16 %168, i64 0, !dbg !223
  %170 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %163), !dbg !219
  %171 = insertelement <4 x i16> %169, i16 %170, i64 1, !dbg !223
  %172 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %165), !dbg !219
  %173 = insertelement <4 x i16> %171, i16 %172, i64 2, !dbg !223
  %174 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %167), !dbg !219
  %175 = insertelement <4 x i16> %173, i16 %174, i64 3, !dbg !223
  %acc_s_cast.sroa.0.6.vec.insert2472 = bitcast <4 x i16> %175 to <4 x half>, !dbg !223
  %176 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.0.4, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2472, <4 x float> %acc_o.sroa.0.1), !dbg !224
  %177 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.18.4, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2472, <4 x float> %acc_o.sroa.34.1), !dbg !224
  %178 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.26.4, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2472, <4 x float> %acc_o.sroa.66.1), !dbg !224
  %179 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.42.4, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2472, <4 x float> %acc_o.sroa.98.1), !dbg !224
  br label %if.end1042, !dbg !225

if.end1042:                                       ; preds = %if.end955, %land.lhs.true923, %if.end918
  %acc_o.sroa.98.2 = phi <4 x float> [ %acc_o.sroa.98.1, %land.lhs.true923 ], [ %179, %if.end955 ], [ %acc_o.sroa.98.1, %if.end918 ], !dbg !79
  %acc_o.sroa.66.2 = phi <4 x float> [ %acc_o.sroa.66.1, %land.lhs.true923 ], [ %178, %if.end955 ], [ %acc_o.sroa.66.1, %if.end918 ], !dbg !79
  %acc_o.sroa.34.2 = phi <4 x float> [ %acc_o.sroa.34.1, %land.lhs.true923 ], [ %177, %if.end955 ], [ %acc_o.sroa.34.1, %if.end918 ], !dbg !79
  %acc_o.sroa.0.2 = phi <4 x float> [ %acc_o.sroa.0.1, %land.lhs.true923 ], [ %176, %if.end955 ], [ %acc_o.sroa.0.1, %if.end918 ], !dbg !79
  %sum_acc.sroa.56.4 = phi float [ %sum_acc.sroa.56.3, %land.lhs.true923 ], [ %add1006.3, %if.end955 ], [ %sum_acc.sroa.56.3, %if.end918 ], !dbg !79
  %sum_acc.sroa.38.4 = phi float [ %sum_acc.sroa.38.3, %land.lhs.true923 ], [ %add1006.2, %if.end955 ], [ %sum_acc.sroa.38.3, %if.end918 ], !dbg !79
  %sum_acc.sroa.20.4 = phi float [ %sum_acc.sroa.20.3, %land.lhs.true923 ], [ %add1006.1, %if.end955 ], [ %sum_acc.sroa.20.3, %if.end918 ], !dbg !79
  %sum_acc.sroa.0.4 = phi float [ %sum_acc.sroa.0.3, %land.lhs.true923 ], [ %add1006, %if.end955 ], [ %sum_acc.sroa.0.3, %if.end918 ], !dbg !79
  %or.cond2300 = icmp ugt i32 %mul11.6, 1023, !dbg !226
  %cmp1049.not = icmp sgt i32 %mul11.6, %1
  %or.cond2301 = or i1 %or.cond2300, %cmp1049.not, !dbg !226
  br i1 %or.cond2301, label %if.end1074, label %for.cond1051.preheader, !dbg !226

for.cond1051.preheader:                           ; preds = %if.end1042
  %mul1056 = shl nsw i32 %0, 16
  %180 = shl nsw i32 %cond.i.i2150.6, 10
  %mul1058 = and i32 %180, 64512
  %mul1063 = shl nuw nsw i32 %18, 3
  %add1059 = or disjoint i32 %mul1063, %mul1056
  %add1061 = add nuw nsw i32 %add1059, %mul1058
  %181 = zext nneg i32 %add1061 to i64, !dbg !227
  %add.ptr1066 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %181, !dbg !228
  %K_ring0.sroa.0.0.copyload2944 = load <4 x half>, ptr addrspace(4) %add.ptr1066, align 16, !dbg !229
  %K_ring0.sroa.10.0.add.ptr1066.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1066, i64 8, !dbg !229
  %K_ring0.sroa.10.0.copyload2947 = load <4 x half>, ptr addrspace(4) %K_ring0.sroa.10.0.add.ptr1066.sroa_idx, align 8, !dbg !229
  %182 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %181, !dbg !228
  %add.ptr1066.1 = getelementptr inbounds i8, ptr addrspace(4) %182, i64 1024, !dbg !228
  %K_ring0.sroa.14.16.copyload2956 = load <4 x half>, ptr addrspace(4) %add.ptr1066.1, align 16, !dbg !229
  %K_ring0.sroa.22.16.add.ptr1066.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %182, i64 1032, !dbg !229
  %K_ring0.sroa.22.16.copyload2959 = load <4 x half>, ptr addrspace(4) %K_ring0.sroa.22.16.add.ptr1066.1.sroa_idx, align 8, !dbg !229
  br label %if.end1074, !dbg !230

if.end1074:                                       ; preds = %for.cond1051.preheader, %if.end1042
  %K_ring0.sroa.22.3 = phi <4 x half> [ %K_ring0.sroa.22.2, %if.end1042 ], [ %K_ring0.sroa.22.16.copyload2959, %for.cond1051.preheader ]
  %K_ring0.sroa.14.3 = phi <4 x half> [ %K_ring0.sroa.14.2, %if.end1042 ], [ %K_ring0.sroa.14.16.copyload2956, %for.cond1051.preheader ]
  %K_ring0.sroa.10.3 = phi <4 x half> [ %K_ring0.sroa.10.2, %if.end1042 ], [ %K_ring0.sroa.10.0.copyload2947, %for.cond1051.preheader ]
  %K_ring0.sroa.0.3 = phi <4 x half> [ %K_ring0.sroa.0.2, %if.end1042 ], [ %K_ring0.sroa.0.0.copyload2944, %for.cond1051.preheader ]
  br i1 %or.cond2296, label %if.end1106, label %for.cond1083.preheader, !dbg !230

for.cond1083.preheader:                           ; preds = %if.end1074
  %mul1088 = shl nsw i32 %0, 16
  %183 = shl nsw i32 %cond.i.i2150.5, 10
  %mul1090 = and i32 %183, 64512
  %mul1095 = shl nuw nsw i32 %18, 3
  %add1091 = or disjoint i32 %mul1095, %mul1088
  %add1093 = add nuw nsw i32 %add1091, %mul1090
  %184 = zext nneg i32 %add1093 to i64, !dbg !231
  %add.ptr1098 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %184, !dbg !232
  %V_ring0.sroa.0.0.copyload2870 = load <4 x half>, ptr addrspace(4) %add.ptr1098, align 16, !dbg !233
  %V_ring0.sroa.18.0.add.ptr1098.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1098, i64 8, !dbg !233
  %V_ring0.sroa.18.0.copyload2877 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.18.0.add.ptr1098.sroa_idx, align 8, !dbg !233
  %185 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %184, !dbg !232
  %add.ptr1098.1 = getelementptr inbounds i8, ptr addrspace(4) %185, i64 1024, !dbg !232
  %V_ring0.sroa.26.16.copyload2898 = load <4 x half>, ptr addrspace(4) %add.ptr1098.1, align 16, !dbg !233
  %V_ring0.sroa.42.16.add.ptr1098.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %185, i64 1032, !dbg !233
  %V_ring0.sroa.42.16.copyload2905 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.42.16.add.ptr1098.1.sroa_idx, align 8, !dbg !233
  br label %if.end1106, !dbg !234

if.end1106:                                       ; preds = %for.cond1083.preheader, %if.end1074
  %V_ring0.sroa.42.5 = phi <4 x half> [ %V_ring0.sroa.42.4, %if.end1074 ], [ %V_ring0.sroa.42.16.copyload2905, %for.cond1083.preheader ]
  %V_ring0.sroa.26.5 = phi <4 x half> [ %V_ring0.sroa.26.4, %if.end1074 ], [ %V_ring0.sroa.26.16.copyload2898, %for.cond1083.preheader ]
  %V_ring0.sroa.18.5 = phi <4 x half> [ %V_ring0.sroa.18.4, %if.end1074 ], [ %V_ring0.sroa.18.0.copyload2877, %for.cond1083.preheader ]
  %V_ring0.sroa.0.5 = phi <4 x half> [ %V_ring0.sroa.0.4, %if.end1074 ], [ %V_ring0.sroa.0.0.copyload2870, %for.cond1083.preheader ]
  %or.cond2304 = icmp ult i32 %mul11.5, 1024, !dbg !234
  br i1 %or.cond2304, label %land.lhs.true1111, label %if.end1230, !dbg !234

land.lhs.true1111:                                ; preds = %if.end1106
  br i1 %cmp861.not, label %if.end1230, label %if.then1114, !dbg !235

if.then1114:                                      ; preds = %land.lhs.true1111
  %add1116 = or disjoint i32 %mul11.5, 15, !dbg !236
  %cmp1117 = icmp ult i32 %1, %add1116, !dbg !237
  br i1 %cmp1117, label %for.cond1119.preheader, label %if.end1143, !dbg !238

for.cond1119.preheader:                           ; preds = %if.then1114
  %186 = lshr i32 %18, 2
  %mul1125 = and i32 %186, 252
  %add1126 = add nuw nsw i32 %mul11.5, %mul1125
  %cmp1129.not = icmp sgt i32 %add1126, %1, !dbg !239
  %fneg.2139 = select i1 %cmp1129.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2551 = insertelement <4 x float> poison, float %fneg.2139, i64 0, !dbg !240
  %cmp1129.not.1.not = icmp slt i32 %add1126, %1, !dbg !239
  %fneg.2139.1 = select i1 %cmp1129.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2644 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2551, float %fneg.2139.1, i64 1, !dbg !240
  %add1127.2 = or disjoint i32 %add1126, 2, !dbg !241
  %cmp1129.not.2 = icmp sgt i32 %add1127.2, %1, !dbg !239
  %fneg.2139.2 = select i1 %cmp1129.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2737 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2644, float %fneg.2139.2, i64 2, !dbg !240
  %add1127.3 = or disjoint i32 %add1126, 3, !dbg !241
  %cmp1129.not.3 = icmp sgt i32 %add1127.3, %1, !dbg !239
  %fneg.2139.3 = select i1 %cmp1129.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2830 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2737, float %fneg.2139.3, i64 3, !dbg !240
  br label %if.end1143

if.end1143:                                       ; preds = %if.then1114, %for.cond1119.preheader
  %acc_s.sroa.0.10 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2830, %for.cond1119.preheader ], [ zeroinitializer, %if.then1114 ], !dbg !79
  %187 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.0.2, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.10), !dbg !242, !call_argsrelate !81
  %188 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.10.2, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %187), !dbg !242, !call_argsrelate !81
  %189 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.14.2, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %188), !dbg !242, !call_argsrelate !81
  %190 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.22.2, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %189), !dbg !242, !call_argsrelate !81
  %acc_s.sroa.0.0.vec.extract2553 = extractelement <4 x float> %190, i64 0, !dbg !243
  %mul1178 = fmul contract float %acc_s.sroa.0.0.vec.extract2553, 0x3FB99999A0000000, !dbg !244
  %191 = tail call contract noundef float @llvm.minnum.f32(float %mul1178, float 0x4024CB5EC0000000), !dbg !245
  %192 = tail call contract noundef float @llvm.exp.f32(float %191), !dbg !247
  %acc_s.sroa.0.4.vec.extract2646 = extractelement <4 x float> %190, i64 1, !dbg !243
  %mul1178.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2646, 0x3FB99999A0000000, !dbg !244
  %193 = tail call contract noundef float @llvm.minnum.f32(float %mul1178.1, float 0x4024CB5EC0000000), !dbg !245
  %194 = tail call contract noundef float @llvm.exp.f32(float %193), !dbg !247
  %acc_s.sroa.0.8.vec.extract2739 = extractelement <4 x float> %190, i64 2, !dbg !243
  %mul1178.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2739, 0x3FB99999A0000000, !dbg !244
  %195 = tail call contract noundef float @llvm.minnum.f32(float %mul1178.2, float 0x4024CB5EC0000000), !dbg !245
  %196 = tail call contract noundef float @llvm.exp.f32(float %195), !dbg !247
  %acc_s.sroa.0.12.vec.extract2832 = extractelement <4 x float> %190, i64 3, !dbg !243
  %mul1178.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2832, 0x3FB99999A0000000, !dbg !244
  %197 = tail call contract noundef float @llvm.minnum.f32(float %mul1178.3, float 0x4024CB5EC0000000), !dbg !245
  %198 = tail call contract noundef float @llvm.exp.f32(float %197), !dbg !247
  %add1194 = fadd contract float %sum_acc.sroa.0.4, %192, !dbg !249
  %add1194.1 = fadd contract float %sum_acc.sroa.20.4, %194, !dbg !249
  %add1194.2 = fadd contract float %sum_acc.sroa.38.4, %196, !dbg !249
  %add1194.3 = fadd contract float %sum_acc.sroa.56.4, %198, !dbg !249
  %199 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %192), !dbg !250
  %200 = insertelement <4 x i16> poison, i16 %199, i64 0, !dbg !254
  %201 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %194), !dbg !250
  %202 = insertelement <4 x i16> %200, i16 %201, i64 1, !dbg !254
  %203 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %196), !dbg !250
  %204 = insertelement <4 x i16> %202, i16 %203, i64 2, !dbg !254
  %205 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %198), !dbg !250
  %206 = insertelement <4 x i16> %204, i16 %205, i64 3, !dbg !254
  %acc_s_cast.sroa.0.6.vec.insert2474 = bitcast <4 x i16> %206 to <4 x half>, !dbg !254
  %207 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.0.5, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2474, <4 x float> %acc_o_alt.sroa.0.1), !dbg !255
  %208 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.18.5, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2474, <4 x float> %acc_o_alt.sroa.18.1), !dbg !255
  %209 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.26.5, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2474, <4 x float> %acc_o_alt.sroa.34.1), !dbg !255
  %210 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.42.5, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2474, <4 x float> %acc_o_alt.sroa.50.1), !dbg !255
  br label %if.end1230, !dbg !256

if.end1230:                                       ; preds = %if.end1143, %land.lhs.true1111, %if.end1106
  %acc_o_alt.sroa.50.2 = phi <4 x float> [ %acc_o_alt.sroa.50.1, %land.lhs.true1111 ], [ %210, %if.end1143 ], [ %acc_o_alt.sroa.50.1, %if.end1106 ], !dbg !79
  %acc_o_alt.sroa.34.2 = phi <4 x float> [ %acc_o_alt.sroa.34.1, %land.lhs.true1111 ], [ %209, %if.end1143 ], [ %acc_o_alt.sroa.34.1, %if.end1106 ], !dbg !79
  %acc_o_alt.sroa.18.2 = phi <4 x float> [ %acc_o_alt.sroa.18.1, %land.lhs.true1111 ], [ %208, %if.end1143 ], [ %acc_o_alt.sroa.18.1, %if.end1106 ], !dbg !79
  %acc_o_alt.sroa.0.2 = phi <4 x float> [ %acc_o_alt.sroa.0.1, %land.lhs.true1111 ], [ %207, %if.end1143 ], [ %acc_o_alt.sroa.0.1, %if.end1106 ], !dbg !79
  %sum_acc.sroa.56.5 = phi float [ %sum_acc.sroa.56.4, %land.lhs.true1111 ], [ %add1194.3, %if.end1143 ], [ %sum_acc.sroa.56.4, %if.end1106 ], !dbg !79
  %sum_acc.sroa.38.5 = phi float [ %sum_acc.sroa.38.4, %land.lhs.true1111 ], [ %add1194.2, %if.end1143 ], [ %sum_acc.sroa.38.4, %if.end1106 ], !dbg !79
  %sum_acc.sroa.20.5 = phi float [ %sum_acc.sroa.20.4, %land.lhs.true1111 ], [ %add1194.1, %if.end1143 ], [ %sum_acc.sroa.20.4, %if.end1106 ], !dbg !79
  %sum_acc.sroa.0.5 = phi float [ %sum_acc.sroa.0.4, %land.lhs.true1111 ], [ %add1194, %if.end1143 ], [ %sum_acc.sroa.0.4, %if.end1106 ], !dbg !79
  %or.cond2305 = icmp ugt i32 %mul11.7, 1023, !dbg !257
  %cmp1237.not = icmp sgt i32 %mul11.7, %1
  %or.cond2306 = or i1 %or.cond2305, %cmp1237.not, !dbg !257
  br i1 %or.cond2306, label %if.end1262, label %for.cond1239.preheader, !dbg !257

for.cond1239.preheader:                           ; preds = %if.end1230
  %mul1244 = shl nsw i32 %0, 16
  %211 = shl nsw i32 %cond.i.i2150.7, 10
  %mul1246 = and i32 %211, 64512
  %mul1251 = shl nuw nsw i32 %18, 3
  %add1247 = or disjoint i32 %mul1251, %mul1244
  %add1249 = add nuw nsw i32 %add1247, %mul1246
  %212 = zext nneg i32 %add1249 to i64, !dbg !258
  %add.ptr1254 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %212, !dbg !259
  %K_ring1.sroa.0.0.copyload2920 = load <4 x half>, ptr addrspace(4) %add.ptr1254, align 16, !dbg !260
  %K_ring1.sroa.10.0.add.ptr1254.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1254, i64 8, !dbg !260
  %K_ring1.sroa.10.0.copyload2923 = load <4 x half>, ptr addrspace(4) %K_ring1.sroa.10.0.add.ptr1254.sroa_idx, align 8, !dbg !260
  %213 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %212, !dbg !259
  %add.ptr1254.1 = getelementptr inbounds i8, ptr addrspace(4) %213, i64 1024, !dbg !259
  %K_ring1.sroa.14.16.copyload2932 = load <4 x half>, ptr addrspace(4) %add.ptr1254.1, align 16, !dbg !260
  %K_ring1.sroa.22.16.add.ptr1254.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %213, i64 1032, !dbg !260
  %K_ring1.sroa.22.16.copyload2935 = load <4 x half>, ptr addrspace(4) %K_ring1.sroa.22.16.add.ptr1254.1.sroa_idx, align 8, !dbg !260
  br label %if.end1262, !dbg !261

if.end1262:                                       ; preds = %for.cond1239.preheader, %if.end1230
  %K_ring1.sroa.22.3 = phi <4 x half> [ %K_ring1.sroa.22.2, %if.end1230 ], [ %K_ring1.sroa.22.16.copyload2935, %for.cond1239.preheader ]
  %K_ring1.sroa.14.3 = phi <4 x half> [ %K_ring1.sroa.14.2, %if.end1230 ], [ %K_ring1.sroa.14.16.copyload2932, %for.cond1239.preheader ]
  %K_ring1.sroa.10.3 = phi <4 x half> [ %K_ring1.sroa.10.2, %if.end1230 ], [ %K_ring1.sroa.10.0.copyload2923, %for.cond1239.preheader ]
  %K_ring1.sroa.0.3 = phi <4 x half> [ %K_ring1.sroa.0.2, %if.end1230 ], [ %K_ring1.sroa.0.0.copyload2920, %for.cond1239.preheader ]
  br i1 %or.cond2301, label %if.end1294, label %for.cond1271.preheader, !dbg !261

for.cond1271.preheader:                           ; preds = %if.end1262
  %mul1276 = shl nsw i32 %0, 16
  %214 = shl nsw i32 %cond.i.i2150.6, 10
  %mul1278 = and i32 %214, 64512
  %mul1283 = shl nuw nsw i32 %18, 3
  %add1279 = or disjoint i32 %mul1283, %mul1276
  %add1281 = add nuw nsw i32 %add1279, %mul1278
  %215 = zext nneg i32 %add1281 to i64, !dbg !262
  %add.ptr1286 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %215, !dbg !263
  %V_ring0.sroa.0.0.copyload2871 = load <4 x half>, ptr addrspace(4) %add.ptr1286, align 16, !dbg !264
  %V_ring0.sroa.18.0.add.ptr1286.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1286, i64 8, !dbg !264
  %V_ring0.sroa.18.0.copyload2878 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.18.0.add.ptr1286.sroa_idx, align 8, !dbg !264
  %216 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %215, !dbg !263
  %add.ptr1286.1 = getelementptr inbounds i8, ptr addrspace(4) %216, i64 1024, !dbg !263
  %V_ring0.sroa.26.16.copyload2899 = load <4 x half>, ptr addrspace(4) %add.ptr1286.1, align 16, !dbg !264
  %V_ring0.sroa.42.16.add.ptr1286.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %216, i64 1032, !dbg !264
  %V_ring0.sroa.42.16.copyload2906 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.42.16.add.ptr1286.1.sroa_idx, align 8, !dbg !264
  br label %if.end1294, !dbg !265

if.end1294:                                       ; preds = %for.cond1271.preheader, %if.end1262
  %V_ring0.sroa.42.6 = phi <4 x half> [ %V_ring0.sroa.42.5, %if.end1262 ], [ %V_ring0.sroa.42.16.copyload2906, %for.cond1271.preheader ]
  %V_ring0.sroa.26.6 = phi <4 x half> [ %V_ring0.sroa.26.5, %if.end1262 ], [ %V_ring0.sroa.26.16.copyload2899, %for.cond1271.preheader ]
  %V_ring0.sroa.18.6 = phi <4 x half> [ %V_ring0.sroa.18.5, %if.end1262 ], [ %V_ring0.sroa.18.0.copyload2878, %for.cond1271.preheader ]
  %V_ring0.sroa.0.6 = phi <4 x half> [ %V_ring0.sroa.0.5, %if.end1262 ], [ %V_ring0.sroa.0.0.copyload2871, %for.cond1271.preheader ]
  %or.cond2309 = icmp ult i32 %mul11.6, 1024, !dbg !265
  br i1 %or.cond2309, label %land.lhs.true1299, label %if.end1418, !dbg !265

land.lhs.true1299:                                ; preds = %if.end1294
  br i1 %cmp1049.not, label %if.end1418, label %if.then1302, !dbg !266

if.then1302:                                      ; preds = %land.lhs.true1299
  %add1304 = or disjoint i32 %mul11.6, 15, !dbg !267
  %cmp1305 = icmp ult i32 %1, %add1304, !dbg !268
  br i1 %cmp1305, label %for.cond1307.preheader, label %if.end1331, !dbg !269

for.cond1307.preheader:                           ; preds = %if.then1302
  %217 = lshr i32 %18, 2
  %mul1313 = and i32 %217, 252
  %add1314 = add nuw nsw i32 %mul11.6, %mul1313
  %cmp1317.not = icmp sgt i32 %add1314, %1, !dbg !270
  %fneg.2140 = select i1 %cmp1317.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2561 = insertelement <4 x float> poison, float %fneg.2140, i64 0, !dbg !271
  %cmp1317.not.1.not = icmp slt i32 %add1314, %1, !dbg !270
  %fneg.2140.1 = select i1 %cmp1317.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2654 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2561, float %fneg.2140.1, i64 1, !dbg !271
  %add1315.2 = or disjoint i32 %add1314, 2, !dbg !272
  %cmp1317.not.2 = icmp sgt i32 %add1315.2, %1, !dbg !270
  %fneg.2140.2 = select i1 %cmp1317.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2747 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2654, float %fneg.2140.2, i64 2, !dbg !271
  %add1315.3 = or disjoint i32 %add1314, 3, !dbg !272
  %cmp1317.not.3 = icmp sgt i32 %add1315.3, %1, !dbg !270
  %fneg.2140.3 = select i1 %cmp1317.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2840 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2747, float %fneg.2140.3, i64 3, !dbg !271
  br label %if.end1331

if.end1331:                                       ; preds = %if.then1302, %for.cond1307.preheader
  %acc_s.sroa.0.12 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2840, %for.cond1307.preheader ], [ zeroinitializer, %if.then1302 ], !dbg !79
  %218 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.0.3, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.12), !dbg !273, !call_argsrelate !81
  %219 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.10.3, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %218), !dbg !273, !call_argsrelate !81
  %220 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.14.3, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %219), !dbg !273, !call_argsrelate !81
  %221 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring0.sroa.22.3, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %220), !dbg !273, !call_argsrelate !81
  %acc_s.sroa.0.0.vec.extract2563 = extractelement <4 x float> %221, i64 0, !dbg !274
  %mul1366 = fmul contract float %acc_s.sroa.0.0.vec.extract2563, 0x3FB99999A0000000, !dbg !275
  %222 = tail call contract noundef float @llvm.minnum.f32(float %mul1366, float 0x4024CB5EC0000000), !dbg !276
  %223 = tail call contract noundef float @llvm.exp.f32(float %222), !dbg !278
  %acc_s.sroa.0.4.vec.extract2656 = extractelement <4 x float> %221, i64 1, !dbg !274
  %mul1366.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2656, 0x3FB99999A0000000, !dbg !275
  %224 = tail call contract noundef float @llvm.minnum.f32(float %mul1366.1, float 0x4024CB5EC0000000), !dbg !276
  %225 = tail call contract noundef float @llvm.exp.f32(float %224), !dbg !278
  %acc_s.sroa.0.8.vec.extract2749 = extractelement <4 x float> %221, i64 2, !dbg !274
  %mul1366.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2749, 0x3FB99999A0000000, !dbg !275
  %226 = tail call contract noundef float @llvm.minnum.f32(float %mul1366.2, float 0x4024CB5EC0000000), !dbg !276
  %227 = tail call contract noundef float @llvm.exp.f32(float %226), !dbg !278
  %acc_s.sroa.0.12.vec.extract2842 = extractelement <4 x float> %221, i64 3, !dbg !274
  %mul1366.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2842, 0x3FB99999A0000000, !dbg !275
  %228 = tail call contract noundef float @llvm.minnum.f32(float %mul1366.3, float 0x4024CB5EC0000000), !dbg !276
  %229 = tail call contract noundef float @llvm.exp.f32(float %228), !dbg !278
  %add1382 = fadd contract float %sum_acc.sroa.0.5, %223, !dbg !280
  %add1382.1 = fadd contract float %sum_acc.sroa.20.5, %225, !dbg !280
  %add1382.2 = fadd contract float %sum_acc.sroa.38.5, %227, !dbg !280
  %add1382.3 = fadd contract float %sum_acc.sroa.56.5, %229, !dbg !280
  %230 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %223), !dbg !281
  %231 = insertelement <4 x i16> poison, i16 %230, i64 0, !dbg !285
  %232 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %225), !dbg !281
  %233 = insertelement <4 x i16> %231, i16 %232, i64 1, !dbg !285
  %234 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %227), !dbg !281
  %235 = insertelement <4 x i16> %233, i16 %234, i64 2, !dbg !285
  %236 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %229), !dbg !281
  %237 = insertelement <4 x i16> %235, i16 %236, i64 3, !dbg !285
  %acc_s_cast.sroa.0.6.vec.insert2476 = bitcast <4 x i16> %237 to <4 x half>, !dbg !285
  %238 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.0.6, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2476, <4 x float> %acc_o.sroa.0.2), !dbg !286
  %239 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.18.6, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2476, <4 x float> %acc_o.sroa.34.2), !dbg !286
  %240 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.26.6, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2476, <4 x float> %acc_o.sroa.66.2), !dbg !286
  %241 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.42.6, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2476, <4 x float> %acc_o.sroa.98.2), !dbg !286
  br label %if.end1418, !dbg !287

if.end1418:                                       ; preds = %if.end1331, %land.lhs.true1299, %if.end1294
  %acc_o.sroa.98.3 = phi <4 x float> [ %acc_o.sroa.98.2, %land.lhs.true1299 ], [ %241, %if.end1331 ], [ %acc_o.sroa.98.2, %if.end1294 ], !dbg !79
  %acc_o.sroa.66.3 = phi <4 x float> [ %acc_o.sroa.66.2, %land.lhs.true1299 ], [ %240, %if.end1331 ], [ %acc_o.sroa.66.2, %if.end1294 ], !dbg !79
  %acc_o.sroa.34.3 = phi <4 x float> [ %acc_o.sroa.34.2, %land.lhs.true1299 ], [ %239, %if.end1331 ], [ %acc_o.sroa.34.2, %if.end1294 ], !dbg !79
  %acc_o.sroa.0.3 = phi <4 x float> [ %acc_o.sroa.0.2, %land.lhs.true1299 ], [ %238, %if.end1331 ], [ %acc_o.sroa.0.2, %if.end1294 ], !dbg !79
  %sum_acc.sroa.56.6 = phi float [ %sum_acc.sroa.56.5, %land.lhs.true1299 ], [ %add1382.3, %if.end1331 ], [ %sum_acc.sroa.56.5, %if.end1294 ], !dbg !79
  %sum_acc.sroa.38.6 = phi float [ %sum_acc.sroa.38.5, %land.lhs.true1299 ], [ %add1382.2, %if.end1331 ], [ %sum_acc.sroa.38.5, %if.end1294 ], !dbg !79
  %sum_acc.sroa.20.6 = phi float [ %sum_acc.sroa.20.5, %land.lhs.true1299 ], [ %add1382.1, %if.end1331 ], [ %sum_acc.sroa.20.5, %if.end1294 ], !dbg !79
  %sum_acc.sroa.0.6 = phi float [ %sum_acc.sroa.0.5, %land.lhs.true1299 ], [ %add1382, %if.end1331 ], [ %sum_acc.sroa.0.5, %if.end1294 ], !dbg !79
  br i1 %or.cond2306, label %if.end1450, label %for.cond1427.preheader, !dbg !287

for.cond1427.preheader:                           ; preds = %if.end1418
  %mul1432 = shl nsw i32 %0, 16
  %242 = shl nsw i32 %cond.i.i2150.7, 10
  %mul1434 = and i32 %242, 64512
  %mul1439 = shl nuw nsw i32 %18, 3
  %add1435 = or disjoint i32 %mul1439, %mul1432
  %add1437 = add nuw nsw i32 %add1435, %mul1434
  %243 = zext nneg i32 %add1437 to i64, !dbg !288
  %add.ptr1442 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %243, !dbg !289
  %V_ring0.sroa.0.0.copyload2872 = load <4 x half>, ptr addrspace(4) %add.ptr1442, align 16, !dbg !290
  %V_ring0.sroa.18.0.add.ptr1442.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1442, i64 8, !dbg !290
  %V_ring0.sroa.18.0.copyload2879 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.18.0.add.ptr1442.sroa_idx, align 8, !dbg !290
  %244 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %243, !dbg !289
  %add.ptr1442.1 = getelementptr inbounds i8, ptr addrspace(4) %244, i64 1024, !dbg !289
  %V_ring0.sroa.26.16.copyload2900 = load <4 x half>, ptr addrspace(4) %add.ptr1442.1, align 16, !dbg !290
  %V_ring0.sroa.42.16.add.ptr1442.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %244, i64 1032, !dbg !290
  %V_ring0.sroa.42.16.copyload2907 = load <4 x half>, ptr addrspace(4) %V_ring0.sroa.42.16.add.ptr1442.1.sroa_idx, align 8, !dbg !290
  br label %if.end1450, !dbg !291

if.end1450:                                       ; preds = %for.cond1427.preheader, %if.end1418
  %V_ring0.sroa.42.7 = phi <4 x half> [ %V_ring0.sroa.42.6, %if.end1418 ], [ %V_ring0.sroa.42.16.copyload2907, %for.cond1427.preheader ]
  %V_ring0.sroa.26.7 = phi <4 x half> [ %V_ring0.sroa.26.6, %if.end1418 ], [ %V_ring0.sroa.26.16.copyload2900, %for.cond1427.preheader ]
  %V_ring0.sroa.18.7 = phi <4 x half> [ %V_ring0.sroa.18.6, %if.end1418 ], [ %V_ring0.sroa.18.0.copyload2879, %for.cond1427.preheader ]
  %V_ring0.sroa.0.7 = phi <4 x half> [ %V_ring0.sroa.0.6, %if.end1418 ], [ %V_ring0.sroa.0.0.copyload2872, %for.cond1427.preheader ]
  %or.cond2312 = icmp ult i32 %mul11.7, 1024, !dbg !291
  br i1 %or.cond2312, label %land.lhs.true1455, label %if.end1574, !dbg !291

land.lhs.true1455:                                ; preds = %if.end1450
  br i1 %cmp1237.not, label %if.end1574, label %if.then1458, !dbg !292

if.then1458:                                      ; preds = %land.lhs.true1455
  %add1460 = or disjoint i32 %mul11.7, 15, !dbg !293
  %cmp1461 = icmp slt i32 %1, %add1460, !dbg !294
  br i1 %cmp1461, label %for.cond1463.preheader, label %if.end1487, !dbg !295

for.cond1463.preheader:                           ; preds = %if.then1458
  %245 = lshr i32 %18, 2
  %mul1469 = and i32 %245, 252
  %add1470 = add nuw nsw i32 %mul11.7, %mul1469
  %cmp1473.not = icmp sgt i32 %add1470, %1, !dbg !296
  %fneg.2141 = select i1 %cmp1473.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert2571 = insertelement <4 x float> poison, float %fneg.2141, i64 0, !dbg !297
  %cmp1473.not.1.not = icmp slt i32 %add1470, %1, !dbg !296
  %fneg.2141.1 = select i1 %cmp1473.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert2664 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert2571, float %fneg.2141.1, i64 1, !dbg !297
  %add1471.2 = or disjoint i32 %add1470, 2, !dbg !298
  %cmp1473.not.2 = icmp sgt i32 %add1471.2, %1, !dbg !296
  %fneg.2141.2 = select i1 %cmp1473.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert2757 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert2664, float %fneg.2141.2, i64 2, !dbg !297
  %add1471.3 = or disjoint i32 %add1470, 3, !dbg !298
  %cmp1473.not.3 = icmp sgt i32 %add1471.3, %1, !dbg !296
  %fneg.2141.3 = select i1 %cmp1473.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert2850 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert2757, float %fneg.2141.3, i64 3, !dbg !297
  br label %if.end1487

if.end1487:                                       ; preds = %if.then1458, %for.cond1463.preheader
  %acc_s.sroa.0.14 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert2850, %for.cond1463.preheader ], [ zeroinitializer, %if.then1458 ], !dbg !79
  %246 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.0.3, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.14), !dbg !299, !call_argsrelate !81
  %247 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.10.3, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %246), !dbg !299, !call_argsrelate !81
  %248 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.14.3, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %247), !dbg !299, !call_argsrelate !81
  %249 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_ring1.sroa.22.3, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %248), !dbg !299, !call_argsrelate !81
  %acc_s.sroa.0.0.vec.extract2573 = extractelement <4 x float> %249, i64 0, !dbg !300
  %mul1522 = fmul contract float %acc_s.sroa.0.0.vec.extract2573, 0x3FB99999A0000000, !dbg !301
  %250 = tail call contract noundef float @llvm.minnum.f32(float %mul1522, float 0x4024CB5EC0000000), !dbg !302
  %251 = tail call contract noundef float @llvm.exp.f32(float %250), !dbg !304
  %acc_s.sroa.0.4.vec.extract2666 = extractelement <4 x float> %249, i64 1, !dbg !300
  %mul1522.1 = fmul contract float %acc_s.sroa.0.4.vec.extract2666, 0x3FB99999A0000000, !dbg !301
  %252 = tail call contract noundef float @llvm.minnum.f32(float %mul1522.1, float 0x4024CB5EC0000000), !dbg !302
  %253 = tail call contract noundef float @llvm.exp.f32(float %252), !dbg !304
  %acc_s.sroa.0.8.vec.extract2759 = extractelement <4 x float> %249, i64 2, !dbg !300
  %mul1522.2 = fmul contract float %acc_s.sroa.0.8.vec.extract2759, 0x3FB99999A0000000, !dbg !301
  %254 = tail call contract noundef float @llvm.minnum.f32(float %mul1522.2, float 0x4024CB5EC0000000), !dbg !302
  %255 = tail call contract noundef float @llvm.exp.f32(float %254), !dbg !304
  %acc_s.sroa.0.12.vec.extract2852 = extractelement <4 x float> %249, i64 3, !dbg !300
  %mul1522.3 = fmul contract float %acc_s.sroa.0.12.vec.extract2852, 0x3FB99999A0000000, !dbg !301
  %256 = tail call contract noundef float @llvm.minnum.f32(float %mul1522.3, float 0x4024CB5EC0000000), !dbg !302
  %257 = tail call contract noundef float @llvm.exp.f32(float %256), !dbg !304
  %add1538 = fadd contract float %sum_acc.sroa.0.6, %251, !dbg !306
  %add1538.1 = fadd contract float %sum_acc.sroa.20.6, %253, !dbg !306
  %add1538.2 = fadd contract float %sum_acc.sroa.38.6, %255, !dbg !306
  %add1538.3 = fadd contract float %sum_acc.sroa.56.6, %257, !dbg !306
  %258 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %251), !dbg !307
  %259 = insertelement <4 x i16> poison, i16 %258, i64 0, !dbg !311
  %260 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %253), !dbg !307
  %261 = insertelement <4 x i16> %259, i16 %260, i64 1, !dbg !311
  %262 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %255), !dbg !307
  %263 = insertelement <4 x i16> %261, i16 %262, i64 2, !dbg !311
  %264 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %257), !dbg !307
  %265 = insertelement <4 x i16> %263, i16 %264, i64 3, !dbg !311
  %acc_s_cast.sroa.0.6.vec.insert2478 = bitcast <4 x i16> %265 to <4 x half>, !dbg !311
  %266 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.0.7, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2478, <4 x float> %acc_o_alt.sroa.0.2), !dbg !312
  %267 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.18.7, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2478, <4 x float> %acc_o_alt.sroa.18.2), !dbg !312
  %268 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.26.7, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2478, <4 x float> %acc_o_alt.sroa.34.2), !dbg !312
  %269 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_ring0.sroa.42.7, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2478, <4 x float> %acc_o_alt.sroa.50.2), !dbg !312
  br label %if.end1574, !dbg !313

if.end1574:                                       ; preds = %if.end1487, %land.lhs.true1455, %if.end1450
  %acc_o_alt.sroa.50.3 = phi <4 x float> [ %acc_o_alt.sroa.50.2, %land.lhs.true1455 ], [ %269, %if.end1487 ], [ %acc_o_alt.sroa.50.2, %if.end1450 ], !dbg !79
  %acc_o_alt.sroa.34.3 = phi <4 x float> [ %acc_o_alt.sroa.34.2, %land.lhs.true1455 ], [ %268, %if.end1487 ], [ %acc_o_alt.sroa.34.2, %if.end1450 ], !dbg !79
  %acc_o_alt.sroa.18.3 = phi <4 x float> [ %acc_o_alt.sroa.18.2, %land.lhs.true1455 ], [ %267, %if.end1487 ], [ %acc_o_alt.sroa.18.2, %if.end1450 ], !dbg !79
  %acc_o_alt.sroa.0.3 = phi <4 x float> [ %acc_o_alt.sroa.0.2, %land.lhs.true1455 ], [ %266, %if.end1487 ], [ %acc_o_alt.sroa.0.2, %if.end1450 ], !dbg !79
  %sum_acc.sroa.56.7 = phi float [ %sum_acc.sroa.56.6, %land.lhs.true1455 ], [ %add1538.3, %if.end1487 ], [ %sum_acc.sroa.56.6, %if.end1450 ], !dbg !79
  %sum_acc.sroa.38.7 = phi float [ %sum_acc.sroa.38.6, %land.lhs.true1455 ], [ %add1538.2, %if.end1487 ], [ %sum_acc.sroa.38.6, %if.end1450 ], !dbg !79
  %sum_acc.sroa.20.7 = phi float [ %sum_acc.sroa.20.6, %land.lhs.true1455 ], [ %add1538.1, %if.end1487 ], [ %sum_acc.sroa.20.6, %if.end1450 ], !dbg !79
  %sum_acc.sroa.0.7 = phi float [ %sum_acc.sroa.0.6, %land.lhs.true1455 ], [ %add1538, %if.end1487 ], [ %sum_acc.sroa.0.6, %if.end1450 ], !dbg !79
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 0, !dbg !314
  %acc_o_alt.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 0, !dbg !315
  %add1583 = fadd contract float %acc_o.sroa.0.0.vec.extract, %acc_o_alt.sroa.0.0.vec.extract, !dbg !316
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 1, !dbg !314
  %acc_o_alt.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 1, !dbg !315
  %add1583.1 = fadd contract float %acc_o.sroa.0.4.vec.extract, %acc_o_alt.sroa.0.4.vec.extract, !dbg !316
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 2, !dbg !314
  %acc_o_alt.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 2, !dbg !315
  %add1583.2 = fadd contract float %acc_o.sroa.0.8.vec.extract, %acc_o_alt.sroa.0.8.vec.extract, !dbg !316
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 3, !dbg !314
  %acc_o_alt.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 3, !dbg !315
  %add1583.3 = fadd contract float %acc_o.sroa.0.12.vec.extract, %acc_o_alt.sroa.0.12.vec.extract, !dbg !316
  %acc_o.sroa.34.16.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 0, !dbg !314
  %acc_o_alt.sroa.18.16.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 0, !dbg !315
  %add1583.4 = fadd contract float %acc_o.sroa.34.16.vec.extract, %acc_o_alt.sroa.18.16.vec.extract, !dbg !316
  %acc_o.sroa.34.20.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 1, !dbg !314
  %acc_o_alt.sroa.18.20.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 1, !dbg !315
  %add1583.5 = fadd contract float %acc_o.sroa.34.20.vec.extract, %acc_o_alt.sroa.18.20.vec.extract, !dbg !316
  %acc_o.sroa.34.24.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 2, !dbg !314
  %acc_o_alt.sroa.18.24.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 2, !dbg !315
  %add1583.6 = fadd contract float %acc_o.sroa.34.24.vec.extract, %acc_o_alt.sroa.18.24.vec.extract, !dbg !316
  %acc_o.sroa.34.28.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 3, !dbg !314
  %acc_o_alt.sroa.18.28.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 3, !dbg !315
  %add1583.7 = fadd contract float %acc_o.sroa.34.28.vec.extract, %acc_o_alt.sroa.18.28.vec.extract, !dbg !316
  %acc_o.sroa.66.32.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 0, !dbg !314
  %acc_o_alt.sroa.34.32.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 0, !dbg !315
  %add1583.8 = fadd contract float %acc_o.sroa.66.32.vec.extract, %acc_o_alt.sroa.34.32.vec.extract, !dbg !316
  %acc_o.sroa.66.36.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 1, !dbg !314
  %acc_o_alt.sroa.34.36.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 1, !dbg !315
  %add1583.9 = fadd contract float %acc_o.sroa.66.36.vec.extract, %acc_o_alt.sroa.34.36.vec.extract, !dbg !316
  %acc_o.sroa.66.40.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 2, !dbg !314
  %acc_o_alt.sroa.34.40.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 2, !dbg !315
  %add1583.10 = fadd contract float %acc_o.sroa.66.40.vec.extract, %acc_o_alt.sroa.34.40.vec.extract, !dbg !316
  %acc_o.sroa.66.44.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 3, !dbg !314
  %acc_o_alt.sroa.34.44.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 3, !dbg !315
  %add1583.11 = fadd contract float %acc_o.sroa.66.44.vec.extract, %acc_o_alt.sroa.34.44.vec.extract, !dbg !316
  %acc_o.sroa.98.48.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 0, !dbg !314
  %acc_o_alt.sroa.50.48.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 0, !dbg !315
  %add1583.12 = fadd contract float %acc_o.sroa.98.48.vec.extract, %acc_o_alt.sroa.50.48.vec.extract, !dbg !316
  %acc_o.sroa.98.52.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 1, !dbg !314
  %acc_o_alt.sroa.50.52.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 1, !dbg !315
  %add1583.13 = fadd contract float %acc_o.sroa.98.52.vec.extract, %acc_o_alt.sroa.50.52.vec.extract, !dbg !316
  %acc_o.sroa.98.56.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 2, !dbg !314
  %acc_o_alt.sroa.50.56.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 2, !dbg !315
  %add1583.14 = fadd contract float %acc_o.sroa.98.56.vec.extract, %acc_o_alt.sroa.50.56.vec.extract, !dbg !316
  %acc_o.sroa.98.60.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 3, !dbg !314
  %acc_o_alt.sroa.50.60.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 3, !dbg !315
  %add1583.15 = fadd contract float %acc_o.sroa.98.60.vec.extract, %acc_o_alt.sroa.50.60.vec.extract, !dbg !316
  %add1597 = fadd contract float %sum_acc.sroa.0.7, 0.000000e+00, !dbg !317
  %add1597.1 = fadd contract float %add1597, %sum_acc.sroa.20.7, !dbg !317
  %add1597.2 = fadd contract float %add1597.1, %sum_acc.sroa.38.7, !dbg !317
  %add1597.3 = fadd contract float %add1597.2, %sum_acc.sroa.56.7, !dbg !317
  %270 = bitcast float %add1597.3 to i32, !dbg !318
  %271 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !330
  %272 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %271) #11, !dbg !335
  %xor.i.i = xor i32 %272, 32, !dbg !336
  %273 = and i32 %272, -64, !dbg !337
  %and.i.i = add nsw i32 %273, 64, !dbg !337
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !338
  %cond.i.i2151 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %272, !dbg !339
  %shl.i.i = shl i32 %cond.i.i2151, 2, !dbg !340
  %274 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %270), !dbg !341
  %275 = bitcast i32 %274 to float, !dbg !342
  %add.i = fadd contract float %add1597.3, %275, !dbg !343
  %276 = bitcast float %add.i to i32, !dbg !346
  %277 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !353
  %278 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %277) #11, !dbg !356
  %xor.i.i2152 = xor i32 %278, 16, !dbg !357
  %279 = and i32 %278, -64, !dbg !358
  %and.i.i2153 = add nsw i32 %279, 64, !dbg !358
  %cmp.not.i.i2154 = icmp slt i32 %xor.i.i2152, %and.i.i2153, !dbg !359
  %cond.i.i2155 = select i1 %cmp.not.i.i2154, i32 %xor.i.i2152, i32 %278, !dbg !360
  %shl.i.i2156 = shl i32 %cond.i.i2155, 2, !dbg !361
  %280 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i2156, i32 %276), !dbg !362
  %281 = bitcast i32 %280 to float, !dbg !363
  %add.i.i = fadd contract float %add.i, %281, !dbg !364
  %cmp1606 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !366
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !367
  %condval_8.0 = select i1 %cmp1606, float %div, float 0.000000e+00, !dbg !367
  %mul1619 = fmul contract float %condval_8.0, %add1583, !dbg !368
  %mul1619.1 = fmul contract float %condval_8.0, %add1583.1, !dbg !368
  %mul1619.2 = fmul contract float %condval_8.0, %add1583.2, !dbg !368
  %mul1619.3 = fmul contract float %condval_8.0, %add1583.3, !dbg !368
  %mul1619.4 = fmul contract float %condval_8.0, %add1583.4, !dbg !368
  %mul1619.5 = fmul contract float %condval_8.0, %add1583.5, !dbg !368
  %mul1619.6 = fmul contract float %condval_8.0, %add1583.6, !dbg !368
  %mul1619.7 = fmul contract float %condval_8.0, %add1583.7, !dbg !368
  %mul1619.8 = fmul contract float %condval_8.0, %add1583.8, !dbg !368
  %mul1619.9 = fmul contract float %condval_8.0, %add1583.9, !dbg !368
  %mul1619.10 = fmul contract float %condval_8.0, %add1583.10, !dbg !368
  %mul1619.11 = fmul contract float %condval_8.0, %add1583.11, !dbg !368
  %mul1619.12 = fmul contract float %condval_8.0, %add1583.12, !dbg !368
  %mul1619.13 = fmul contract float %condval_8.0, %add1583.13, !dbg !368
  %mul1619.14 = fmul contract float %condval_8.0, %add1583.14, !dbg !368
  %mul1619.15 = fmul contract float %condval_8.0, %add1583.15, !dbg !368
  %282 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619), !dbg !369
  %O_reg.sroa.0.0.insert.ext = zext i16 %282 to i64, !dbg !373
  %283 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619.1), !dbg !369
  %O_reg.sroa.0.2.insert.ext = zext i16 %283 to i64, !dbg !373
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !373
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !373
  %284 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619.2), !dbg !369
  %O_reg.sroa.0.4.insert.ext = zext i16 %284 to i64, !dbg !373
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !373
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !373
  %285 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619.3), !dbg !369
  %O_reg.sroa.0.6.insert.ext = zext i16 %285 to i64, !dbg !373
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !373
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !373
  %286 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619.4), !dbg !369
  %O_reg.sroa.7.8.insert.ext = zext i16 %286 to i64, !dbg !373
  %287 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619.5), !dbg !369
  %O_reg.sroa.7.10.insert.ext = zext i16 %287 to i64, !dbg !373
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !373
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !373
  %288 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619.6), !dbg !369
  %O_reg.sroa.7.12.insert.ext = zext i16 %288 to i64, !dbg !373
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !373
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !373
  %289 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619.7), !dbg !369
  %O_reg.sroa.7.14.insert.ext = zext i16 %289 to i64, !dbg !373
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !373
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !373
  %290 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619.8), !dbg !369
  %O_reg.sroa.12.16.insert.ext = zext i16 %290 to i64, !dbg !373
  %291 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619.9), !dbg !369
  %O_reg.sroa.12.18.insert.ext = zext i16 %291 to i64, !dbg !373
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !373
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !373
  %292 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619.10), !dbg !369
  %O_reg.sroa.12.20.insert.ext = zext i16 %292 to i64, !dbg !373
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !373
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !373
  %293 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619.11), !dbg !369
  %O_reg.sroa.12.22.insert.ext = zext i16 %293 to i64, !dbg !373
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !373
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !373
  %294 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619.12), !dbg !369
  %O_reg.sroa.17.24.insert.ext = zext i16 %294 to i64, !dbg !373
  %295 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619.13), !dbg !369
  %O_reg.sroa.17.26.insert.ext = zext i16 %295 to i64, !dbg !373
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !373
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !373
  %296 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619.14), !dbg !369
  %O_reg.sroa.17.28.insert.ext = zext i16 %296 to i64, !dbg !373
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !373
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !373
  %297 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1619.15), !dbg !369
  %O_reg.sroa.17.30.insert.ext = zext i16 %297 to i64, !dbg !373
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !373
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !373
  %shr1661 = lshr i32 %18, 5
  %and1664 = and i32 %18, 7
  %298 = lshr i32 %18, 2
  %mul1670 = and i32 %298, 4
  %xor = xor i32 %shr1661, %and1664, !dbg !374
  %mul1665 = shl nuw nsw i32 %xor, 3, !dbg !375
  %add1666 = add nuw nsw i32 %mul1665, %mul25, !dbg !376
  %add1671 = or disjoint i32 %add1666, %mul1670, !dbg !377
  %add.ptr1673 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1671, !dbg !378
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr1673, align 8, !dbg !379
  %add1662.1 = add nuw nsw i32 %shr1661, 2, !dbg !380
  %xor.1 = xor i32 %add1662.1, %and1664, !dbg !374
  %mul1665.1 = shl nuw nsw i32 %xor.1, 3, !dbg !375
  %add1666.1 = add nuw nsw i32 %mul1665.1, %mul25, !dbg !376
  %add1671.1 = or disjoint i32 %add1666.1, %mul1670, !dbg !377
  %add.ptr1673.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1671.1, !dbg !378
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr1673.1, align 8, !dbg !379
  %add1662.2 = add nuw nsw i32 %shr1661, 4, !dbg !380
  %xor.2 = xor i32 %add1662.2, %and1664, !dbg !374
  %mul1665.2 = shl nuw nsw i32 %xor.2, 3, !dbg !375
  %add1666.2 = add nuw nsw i32 %mul1665.2, %mul25, !dbg !376
  %add1671.2 = or disjoint i32 %add1666.2, %mul1670, !dbg !377
  %add.ptr1673.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1671.2, !dbg !378
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr1673.2, align 8, !dbg !379
  %add1662.3 = add nuw nsw i32 %shr1661, 6, !dbg !380
  %xor.3 = xor i32 %add1662.3, %and1664, !dbg !374
  %mul1665.3 = shl nuw nsw i32 %xor.3, 3, !dbg !375
  %add1666.3 = add nuw nsw i32 %mul1665.3, %mul25, !dbg !376
  %add1671.3 = or disjoint i32 %add1666.3, %mul1670, !dbg !377
  %add.ptr1673.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1671.3, !dbg !378
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr1673.3, align 8, !dbg !379
  fence syncscope("warp") release, !dbg !381
  tail call void @llvm.mxc.barrier.warp(), !dbg !386
  fence syncscope("warp") acquire, !dbg !387
  %299 = shl nuw nsw i32 %18, 3
  %mul1684 = and i32 %299, 8128
  %xor16902133 = and i32 %299, 56
  %call1688.masked = and i32 %18, 1016
  %mul1691 = xor i32 %xor16902133, %call1688.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul1684, !dbg !388
  %invariant.gep2271 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul1691, !dbg !388
  %add1701 = add nuw nsw i32 %add23, %299
  %300 = zext nneg i32 %add1701 to i64, !dbg !389
  %add.ptr1706 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %300, !dbg !390
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1706, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep2271, i64 16, i1 false), !dbg !391, !tbaa.struct !392, !call_argsrelate !393
  %gep2272.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep2271, i32 1024, !dbg !394
  %301 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %300, !dbg !390
  %add.ptr1706.1 = getelementptr inbounds i8, ptr addrspace(1) %301, i64 1024, !dbg !390
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1706.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep2272.1, i64 16, i1 false), !dbg !391, !tbaa.struct !392, !call_argsrelate !393
  ret void, !dbg !395
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
!1 = !DIFile(filename: "/tmp/tmputn1d82q/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmputn1d82q/tvm_kernels.maca", directory: "")
!42 = !DILocation(line: 26, column: 3, scope: !40)
!43 = !DILocation(line: 27, column: 21, scope: !40)
!44 = !DILocation(line: 705, column: 10, scope: !45, inlinedAt: !47)
!45 = distinct !DISubprogram(name: "max", scope: !46, file: !46, line: 704, type: !7, scopeLine: 704, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!46 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!47 = distinct !DILocation(line: 28, column: 24, scope: !40)
!48 = !{i32 0, i32 -1}
!49 = !DILocation(line: 708, column: 10, scope: !50, inlinedAt: !51)
!50 = distinct !DISubprogram(name: "min", scope: !46, file: !46, line: 707, type: !7, scopeLine: 707, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!51 = distinct !DILocation(line: 28, column: 20, scope: !40)
!52 = !DILocation(line: 28, column: 48, scope: !40)
!53 = !DILocation(line: 27, column: 90, scope: !40)
!54 = !{i32 0, i32 1024}
!55 = !DILocation(line: 31, column: 3, scope: !40)
!56 = !DILocation(line: 32, column: 46, scope: !40)
!57 = !DILocation(line: 32, column: 32, scope: !40)
!58 = !DILocation(line: 48, column: 32, scope: !40)
!59 = !DILocation(line: 50, column: 5, scope: !40)
!60 = !DILocation(line: 51, column: 52, scope: !40)
!61 = !DILocation(line: 51, column: 38, scope: !40)
!62 = !DILocation(line: 54, column: 26, scope: !40)
!63 = !DILocation(line: 55, column: 32, scope: !40)
!64 = !DILocation(line: 57, column: 5, scope: !40)
!65 = !DILocation(line: 58, column: 52, scope: !40)
!66 = !DILocation(line: 58, column: 38, scope: !40)
!67 = !DILocation(line: 62, column: 32, scope: !40)
!68 = !DILocation(line: 64, column: 5, scope: !40)
!69 = !DILocation(line: 65, column: 52, scope: !40)
!70 = !DILocation(line: 65, column: 38, scope: !40)
!71 = !DILocation(line: 69, column: 30, scope: !40)
!72 = !DILocation(line: 69, column: 7, scope: !40)
!73 = !DILocation(line: 70, column: 45, scope: !40)
!74 = !DILocation(line: 70, column: 27, scope: !40)
!75 = !DILocation(line: 70, column: 9, scope: !40)
!76 = !DILocation(line: 74, column: 73, scope: !40)
!77 = !DILocation(line: 79, column: 20, scope: !40)
!78 = !DILocation(line: 74, column: 66, scope: !40)
!79 = !DILocation(line: 0, scope: !40)
!80 = !DILocation(line: 88, column: 36, scope: !40)
!81 = !{i32 -1, i32 3, i32 -1}
!82 = !DILocation(line: 96, column: 30, scope: !40)
!83 = !DILocation(line: 96, column: 41, scope: !40)
!84 = !DILocation(line: 354, column: 10, scope: !85, inlinedAt: !86)
!85 = distinct !DISubprogram(name: "min", scope: !46, file: !46, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!86 = distinct !DILocation(line: 96, column: 25, scope: !40)
!87 = !DILocation(line: 288, column: 10, scope: !88, inlinedAt: !89)
!88 = distinct !DISubprogram(name: "expf", scope: !46, file: !46, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!89 = distinct !DILocation(line: 96, column: 20, scope: !40)
!90 = !DILocation(line: 75, column: 10, scope: !91, inlinedAt: !93)
!91 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !92, file: !92, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!92 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!93 = distinct !DILocation(line: 984, column: 9, scope: !94, inlinedAt: !96)
!94 = distinct !DISubprogram(name: "__float2half", scope: !95, file: !95, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!95 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!96 = distinct !DILocation(line: 133, column: 53, scope: !97, inlinedAt: !98)
!97 = distinct !DISubprogram(name: "__half", scope: !95, file: !95, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!98 = distinct !DILocation(line: 104, column: 32, scope: !40)
!99 = !DILocation(line: 104, column: 29, scope: !40)
!100 = !DILocation(line: 108, column: 36, scope: !40)
!101 = !DILocation(line: 114, column: 26, scope: !40)
!102 = !DILocation(line: 115, column: 32, scope: !40)
!103 = !DILocation(line: 117, column: 5, scope: !40)
!104 = !DILocation(line: 118, column: 52, scope: !40)
!105 = !DILocation(line: 118, column: 38, scope: !40)
!106 = !DILocation(line: 122, column: 32, scope: !40)
!107 = !DILocation(line: 124, column: 5, scope: !40)
!108 = !DILocation(line: 125, column: 53, scope: !40)
!109 = !DILocation(line: 125, column: 39, scope: !40)
!110 = !DILocation(line: 129, column: 30, scope: !40)
!111 = !DILocation(line: 129, column: 7, scope: !40)
!112 = !DILocation(line: 130, column: 45, scope: !40)
!113 = !DILocation(line: 130, column: 27, scope: !40)
!114 = !DILocation(line: 130, column: 9, scope: !40)
!115 = !DILocation(line: 134, column: 74, scope: !40)
!116 = !DILocation(line: 139, column: 21, scope: !40)
!117 = !DILocation(line: 134, column: 66, scope: !40)
!118 = !DILocation(line: 148, column: 36, scope: !40)
!119 = !DILocation(line: 156, column: 31, scope: !40)
!120 = !DILocation(line: 156, column: 43, scope: !40)
!121 = !DILocation(line: 354, column: 10, scope: !85, inlinedAt: !122)
!122 = distinct !DILocation(line: 156, column: 26, scope: !40)
!123 = !DILocation(line: 288, column: 10, scope: !88, inlinedAt: !124)
!124 = distinct !DILocation(line: 156, column: 21, scope: !40)
!125 = !DILocation(line: 160, column: 38, scope: !40)
!126 = !DILocation(line: 75, column: 10, scope: !91, inlinedAt: !127)
!127 = distinct !DILocation(line: 984, column: 9, scope: !94, inlinedAt: !128)
!128 = distinct !DILocation(line: 133, column: 53, scope: !97, inlinedAt: !129)
!129 = distinct !DILocation(line: 164, column: 34, scope: !40)
!130 = !DILocation(line: 164, column: 31, scope: !40)
!131 = !DILocation(line: 168, column: 42, scope: !40)
!132 = !DILocation(line: 174, column: 26, scope: !40)
!133 = !DILocation(line: 175, column: 32, scope: !40)
!134 = !DILocation(line: 177, column: 5, scope: !40)
!135 = !DILocation(line: 178, column: 53, scope: !40)
!136 = !DILocation(line: 178, column: 39, scope: !40)
!137 = !DILocation(line: 182, column: 32, scope: !40)
!138 = !DILocation(line: 184, column: 5, scope: !40)
!139 = !DILocation(line: 185, column: 53, scope: !40)
!140 = !DILocation(line: 185, column: 39, scope: !40)
!141 = !DILocation(line: 189, column: 30, scope: !40)
!142 = !DILocation(line: 189, column: 7, scope: !40)
!143 = !DILocation(line: 190, column: 45, scope: !40)
!144 = !DILocation(line: 190, column: 27, scope: !40)
!145 = !DILocation(line: 190, column: 9, scope: !40)
!146 = !DILocation(line: 194, column: 74, scope: !40)
!147 = !DILocation(line: 199, column: 21, scope: !40)
!148 = !DILocation(line: 194, column: 66, scope: !40)
!149 = !DILocation(line: 208, column: 36, scope: !40)
!150 = !DILocation(line: 216, column: 31, scope: !40)
!151 = !DILocation(line: 216, column: 43, scope: !40)
!152 = !DILocation(line: 354, column: 10, scope: !85, inlinedAt: !153)
!153 = distinct !DILocation(line: 216, column: 26, scope: !40)
!154 = !DILocation(line: 288, column: 10, scope: !88, inlinedAt: !155)
!155 = distinct !DILocation(line: 216, column: 21, scope: !40)
!156 = !DILocation(line: 220, column: 38, scope: !40)
!157 = !DILocation(line: 75, column: 10, scope: !91, inlinedAt: !158)
!158 = distinct !DILocation(line: 984, column: 9, scope: !94, inlinedAt: !159)
!159 = distinct !DILocation(line: 133, column: 53, scope: !97, inlinedAt: !160)
!160 = distinct !DILocation(line: 224, column: 34, scope: !40)
!161 = !DILocation(line: 224, column: 31, scope: !40)
!162 = !DILocation(line: 228, column: 38, scope: !40)
!163 = !DILocation(line: 234, column: 26, scope: !40)
!164 = !DILocation(line: 235, column: 32, scope: !40)
!165 = !DILocation(line: 237, column: 5, scope: !40)
!166 = !DILocation(line: 238, column: 53, scope: !40)
!167 = !DILocation(line: 238, column: 39, scope: !40)
!168 = !DILocation(line: 242, column: 32, scope: !40)
!169 = !DILocation(line: 244, column: 5, scope: !40)
!170 = !DILocation(line: 245, column: 53, scope: !40)
!171 = !DILocation(line: 245, column: 39, scope: !40)
!172 = !DILocation(line: 249, column: 30, scope: !40)
!173 = !DILocation(line: 249, column: 7, scope: !40)
!174 = !DILocation(line: 250, column: 45, scope: !40)
!175 = !DILocation(line: 250, column: 27, scope: !40)
!176 = !DILocation(line: 250, column: 9, scope: !40)
!177 = !DILocation(line: 254, column: 74, scope: !40)
!178 = !DILocation(line: 259, column: 21, scope: !40)
!179 = !DILocation(line: 254, column: 66, scope: !40)
!180 = !DILocation(line: 268, column: 36, scope: !40)
!181 = !DILocation(line: 276, column: 31, scope: !40)
!182 = !DILocation(line: 276, column: 43, scope: !40)
!183 = !DILocation(line: 354, column: 10, scope: !85, inlinedAt: !184)
!184 = distinct !DILocation(line: 276, column: 26, scope: !40)
!185 = !DILocation(line: 288, column: 10, scope: !88, inlinedAt: !186)
!186 = distinct !DILocation(line: 276, column: 21, scope: !40)
!187 = !DILocation(line: 280, column: 38, scope: !40)
!188 = !DILocation(line: 75, column: 10, scope: !91, inlinedAt: !189)
!189 = distinct !DILocation(line: 984, column: 9, scope: !94, inlinedAt: !190)
!190 = distinct !DILocation(line: 133, column: 53, scope: !97, inlinedAt: !191)
!191 = distinct !DILocation(line: 284, column: 34, scope: !40)
!192 = !DILocation(line: 284, column: 31, scope: !40)
!193 = !DILocation(line: 288, column: 42, scope: !40)
!194 = !DILocation(line: 294, column: 26, scope: !40)
!195 = !DILocation(line: 295, column: 32, scope: !40)
!196 = !DILocation(line: 297, column: 5, scope: !40)
!197 = !DILocation(line: 298, column: 53, scope: !40)
!198 = !DILocation(line: 298, column: 39, scope: !40)
!199 = !DILocation(line: 302, column: 32, scope: !40)
!200 = !DILocation(line: 304, column: 5, scope: !40)
!201 = !DILocation(line: 305, column: 53, scope: !40)
!202 = !DILocation(line: 305, column: 39, scope: !40)
!203 = !DILocation(line: 309, column: 30, scope: !40)
!204 = !DILocation(line: 309, column: 7, scope: !40)
!205 = !DILocation(line: 310, column: 45, scope: !40)
!206 = !DILocation(line: 310, column: 27, scope: !40)
!207 = !DILocation(line: 310, column: 9, scope: !40)
!208 = !DILocation(line: 314, column: 74, scope: !40)
!209 = !DILocation(line: 319, column: 21, scope: !40)
!210 = !DILocation(line: 314, column: 66, scope: !40)
!211 = !DILocation(line: 328, column: 36, scope: !40)
!212 = !DILocation(line: 336, column: 31, scope: !40)
!213 = !DILocation(line: 336, column: 43, scope: !40)
!214 = !DILocation(line: 354, column: 10, scope: !85, inlinedAt: !215)
!215 = distinct !DILocation(line: 336, column: 26, scope: !40)
!216 = !DILocation(line: 288, column: 10, scope: !88, inlinedAt: !217)
!217 = distinct !DILocation(line: 336, column: 21, scope: !40)
!218 = !DILocation(line: 340, column: 38, scope: !40)
!219 = !DILocation(line: 75, column: 10, scope: !91, inlinedAt: !220)
!220 = distinct !DILocation(line: 984, column: 9, scope: !94, inlinedAt: !221)
!221 = distinct !DILocation(line: 133, column: 53, scope: !97, inlinedAt: !222)
!222 = distinct !DILocation(line: 344, column: 34, scope: !40)
!223 = !DILocation(line: 344, column: 31, scope: !40)
!224 = !DILocation(line: 348, column: 38, scope: !40)
!225 = !DILocation(line: 354, column: 26, scope: !40)
!226 = !DILocation(line: 355, column: 32, scope: !40)
!227 = !DILocation(line: 357, column: 5, scope: !40)
!228 = !DILocation(line: 358, column: 53, scope: !40)
!229 = !DILocation(line: 358, column: 39, scope: !40)
!230 = !DILocation(line: 362, column: 32, scope: !40)
!231 = !DILocation(line: 364, column: 5, scope: !40)
!232 = !DILocation(line: 365, column: 53, scope: !40)
!233 = !DILocation(line: 365, column: 39, scope: !40)
!234 = !DILocation(line: 369, column: 30, scope: !40)
!235 = !DILocation(line: 369, column: 7, scope: !40)
!236 = !DILocation(line: 370, column: 45, scope: !40)
!237 = !DILocation(line: 370, column: 27, scope: !40)
!238 = !DILocation(line: 370, column: 9, scope: !40)
!239 = !DILocation(line: 374, column: 74, scope: !40)
!240 = !DILocation(line: 379, column: 21, scope: !40)
!241 = !DILocation(line: 374, column: 66, scope: !40)
!242 = !DILocation(line: 388, column: 36, scope: !40)
!243 = !DILocation(line: 396, column: 31, scope: !40)
!244 = !DILocation(line: 396, column: 43, scope: !40)
!245 = !DILocation(line: 354, column: 10, scope: !85, inlinedAt: !246)
!246 = distinct !DILocation(line: 396, column: 26, scope: !40)
!247 = !DILocation(line: 288, column: 10, scope: !88, inlinedAt: !248)
!248 = distinct !DILocation(line: 396, column: 21, scope: !40)
!249 = !DILocation(line: 400, column: 38, scope: !40)
!250 = !DILocation(line: 75, column: 10, scope: !91, inlinedAt: !251)
!251 = distinct !DILocation(line: 984, column: 9, scope: !94, inlinedAt: !252)
!252 = distinct !DILocation(line: 133, column: 53, scope: !97, inlinedAt: !253)
!253 = distinct !DILocation(line: 404, column: 34, scope: !40)
!254 = !DILocation(line: 404, column: 31, scope: !40)
!255 = !DILocation(line: 408, column: 42, scope: !40)
!256 = !DILocation(line: 414, column: 26, scope: !40)
!257 = !DILocation(line: 415, column: 32, scope: !40)
!258 = !DILocation(line: 417, column: 5, scope: !40)
!259 = !DILocation(line: 418, column: 53, scope: !40)
!260 = !DILocation(line: 418, column: 39, scope: !40)
!261 = !DILocation(line: 422, column: 32, scope: !40)
!262 = !DILocation(line: 424, column: 5, scope: !40)
!263 = !DILocation(line: 425, column: 53, scope: !40)
!264 = !DILocation(line: 425, column: 39, scope: !40)
!265 = !DILocation(line: 429, column: 30, scope: !40)
!266 = !DILocation(line: 429, column: 7, scope: !40)
!267 = !DILocation(line: 430, column: 45, scope: !40)
!268 = !DILocation(line: 430, column: 27, scope: !40)
!269 = !DILocation(line: 430, column: 9, scope: !40)
!270 = !DILocation(line: 434, column: 74, scope: !40)
!271 = !DILocation(line: 439, column: 21, scope: !40)
!272 = !DILocation(line: 434, column: 66, scope: !40)
!273 = !DILocation(line: 448, column: 36, scope: !40)
!274 = !DILocation(line: 456, column: 31, scope: !40)
!275 = !DILocation(line: 456, column: 43, scope: !40)
!276 = !DILocation(line: 354, column: 10, scope: !85, inlinedAt: !277)
!277 = distinct !DILocation(line: 456, column: 26, scope: !40)
!278 = !DILocation(line: 288, column: 10, scope: !88, inlinedAt: !279)
!279 = distinct !DILocation(line: 456, column: 21, scope: !40)
!280 = !DILocation(line: 460, column: 38, scope: !40)
!281 = !DILocation(line: 75, column: 10, scope: !91, inlinedAt: !282)
!282 = distinct !DILocation(line: 984, column: 9, scope: !94, inlinedAt: !283)
!283 = distinct !DILocation(line: 133, column: 53, scope: !97, inlinedAt: !284)
!284 = distinct !DILocation(line: 464, column: 34, scope: !40)
!285 = !DILocation(line: 464, column: 31, scope: !40)
!286 = !DILocation(line: 468, column: 38, scope: !40)
!287 = !DILocation(line: 475, column: 32, scope: !40)
!288 = !DILocation(line: 477, column: 5, scope: !40)
!289 = !DILocation(line: 478, column: 53, scope: !40)
!290 = !DILocation(line: 478, column: 39, scope: !40)
!291 = !DILocation(line: 482, column: 30, scope: !40)
!292 = !DILocation(line: 482, column: 7, scope: !40)
!293 = !DILocation(line: 483, column: 45, scope: !40)
!294 = !DILocation(line: 483, column: 27, scope: !40)
!295 = !DILocation(line: 483, column: 9, scope: !40)
!296 = !DILocation(line: 487, column: 74, scope: !40)
!297 = !DILocation(line: 492, column: 21, scope: !40)
!298 = !DILocation(line: 487, column: 66, scope: !40)
!299 = !DILocation(line: 501, column: 36, scope: !40)
!300 = !DILocation(line: 509, column: 31, scope: !40)
!301 = !DILocation(line: 509, column: 43, scope: !40)
!302 = !DILocation(line: 354, column: 10, scope: !85, inlinedAt: !303)
!303 = distinct !DILocation(line: 509, column: 26, scope: !40)
!304 = !DILocation(line: 288, column: 10, scope: !88, inlinedAt: !305)
!305 = distinct !DILocation(line: 509, column: 21, scope: !40)
!306 = !DILocation(line: 513, column: 38, scope: !40)
!307 = !DILocation(line: 75, column: 10, scope: !91, inlinedAt: !308)
!308 = distinct !DILocation(line: 984, column: 9, scope: !94, inlinedAt: !309)
!309 = distinct !DILocation(line: 133, column: 53, scope: !97, inlinedAt: !310)
!310 = distinct !DILocation(line: 517, column: 34, scope: !40)
!311 = !DILocation(line: 517, column: 31, scope: !40)
!312 = !DILocation(line: 521, column: 42, scope: !40)
!313 = !DILocation(line: 528, column: 3, scope: !40)
!314 = !DILocation(line: 529, column: 20, scope: !40)
!315 = !DILocation(line: 529, column: 34, scope: !40)
!316 = !DILocation(line: 529, column: 32, scope: !40)
!317 = !DILocation(line: 534, column: 36, scope: !40)
!318 = !DILocation(line: 1018, column: 9, scope: !319, inlinedAt: !321)
!319 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !320, file: !320, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!320 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!321 = distinct !DILocation(line: 396, column: 10, scope: !322, inlinedAt: !324)
!322 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !323, file: !323, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!323 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!324 = distinct !DILocation(line: 129, column: 24, scope: !325, inlinedAt: !327)
!325 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !326, file: !326, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!326 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!327 = distinct !DILocation(line: 101, column: 14, scope: !328, inlinedAt: !329)
!328 = distinct !DISubprogram(name: "run<float>", scope: !326, file: !326, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!329 = distinct !DILocation(line: 536, column: 19, scope: !40)
!330 = !DILocation(line: 171, column: 37, scope: !331, inlinedAt: !332)
!331 = distinct !DISubprogram(name: "__lane_id", scope: !320, file: !320, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!332 = distinct !DILocation(line: 990, column: 14, scope: !333, inlinedAt: !334)
!333 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !320, file: !320, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!334 = distinct !DILocation(line: 1019, column: 11, scope: !319, inlinedAt: !321)
!335 = !DILocation(line: 171, column: 10, scope: !331, inlinedAt: !332)
!336 = !DILocation(line: 991, column: 20, scope: !333, inlinedAt: !334)
!337 = !DILocation(line: 992, column: 36, scope: !333, inlinedAt: !334)
!338 = !DILocation(line: 992, column: 17, scope: !333, inlinedAt: !334)
!339 = !DILocation(line: 992, column: 11, scope: !333, inlinedAt: !334)
!340 = !DILocation(line: 993, column: 43, scope: !333, inlinedAt: !334)
!341 = !DILocation(line: 993, column: 10, scope: !333, inlinedAt: !334)
!342 = !DILocation(line: 1020, column: 14, scope: !319, inlinedAt: !321)
!343 = !DILocation(line: 25, column: 14, scope: !344, inlinedAt: !345)
!344 = distinct !DISubprogram(name: "operator()<float>", scope: !326, file: !326, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!345 = distinct !DILocation(line: 129, column: 11, scope: !325, inlinedAt: !327)
!346 = !DILocation(line: 1018, column: 9, scope: !319, inlinedAt: !347)
!347 = distinct !DILocation(line: 396, column: 10, scope: !322, inlinedAt: !348)
!348 = distinct !DILocation(line: 129, column: 24, scope: !349, inlinedAt: !350)
!349 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !326, file: !326, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!350 = distinct !DILocation(line: 101, column: 14, scope: !351, inlinedAt: !352)
!351 = distinct !DISubprogram(name: "run<float>", scope: !326, file: !326, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!352 = distinct !DILocation(line: 134, column: 14, scope: !325, inlinedAt: !327)
!353 = !DILocation(line: 171, column: 37, scope: !331, inlinedAt: !354)
!354 = distinct !DILocation(line: 990, column: 14, scope: !333, inlinedAt: !355)
!355 = distinct !DILocation(line: 1019, column: 11, scope: !319, inlinedAt: !347)
!356 = !DILocation(line: 171, column: 10, scope: !331, inlinedAt: !354)
!357 = !DILocation(line: 991, column: 20, scope: !333, inlinedAt: !355)
!358 = !DILocation(line: 992, column: 36, scope: !333, inlinedAt: !355)
!359 = !DILocation(line: 992, column: 17, scope: !333, inlinedAt: !355)
!360 = !DILocation(line: 992, column: 11, scope: !333, inlinedAt: !355)
!361 = !DILocation(line: 993, column: 43, scope: !333, inlinedAt: !355)
!362 = !DILocation(line: 993, column: 10, scope: !333, inlinedAt: !355)
!363 = !DILocation(line: 1020, column: 14, scope: !319, inlinedAt: !347)
!364 = !DILocation(line: 25, column: 14, scope: !344, inlinedAt: !365)
!365 = distinct !DILocation(line: 129, column: 11, scope: !349, inlinedAt: !350)
!366 = !DILocation(line: 538, column: 32, scope: !40)
!367 = !DILocation(line: 538, column: 7, scope: !40)
!368 = !DILocation(line: 546, column: 32, scope: !40)
!369 = !DILocation(line: 75, column: 10, scope: !91, inlinedAt: !370)
!370 = distinct !DILocation(line: 984, column: 9, scope: !94, inlinedAt: !371)
!371 = distinct !DILocation(line: 133, column: 53, scope: !97, inlinedAt: !372)
!372 = distinct !DILocation(line: 552, column: 50, scope: !40)
!373 = !DILocation(line: 552, column: 47, scope: !40)
!374 = !DILocation(line: 557, column: 122, scope: !40)
!375 = !DILocation(line: 557, column: 150, scope: !40)
!376 = !DILocation(line: 557, column: 77, scope: !40)
!377 = !DILocation(line: 557, column: 156, scope: !40)
!378 = !DILocation(line: 557, column: 40, scope: !40)
!379 = !DILocation(line: 557, column: 199, scope: !40)
!380 = !DILocation(line: 557, column: 93, scope: !40)
!381 = !DILocation(line: 68, column: 3, scope: !382, inlinedAt: !383)
!382 = distinct !DISubprogram(name: "__barrier_warp", scope: !320, file: !320, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!383 = distinct !DILocation(line: 192, column: 3, scope: !384, inlinedAt: !385)
!384 = distinct !DISubprogram(name: "__syncwarp", scope: !320, file: !320, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!385 = distinct !DILocation(line: 559, column: 3, scope: !40)
!386 = !DILocation(line: 69, column: 3, scope: !382, inlinedAt: !383)
!387 = !DILocation(line: 70, column: 3, scope: !382, inlinedAt: !383)
!388 = !DILocation(line: 561, column: 8, scope: !40)
!389 = !DILocation(line: 561, column: 3, scope: !40)
!390 = !DILocation(line: 562, column: 22, scope: !40)
!391 = !DILocation(line: 562, column: 132, scope: !40)
!392 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!393 = !{i32 2, i32 -1, i32 -1, i32 -1}
!394 = !DILocation(line: 562, column: 169, scope: !40)
!395 = !DILocation(line: 564, column: 1, scope: !40)
