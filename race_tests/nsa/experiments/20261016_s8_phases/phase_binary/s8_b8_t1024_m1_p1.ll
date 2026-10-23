; ModuleID = 'experiments/20261016_s8_phases/phase_binary/s8_b8_t1024_m1_p1.bc'
source_filename = "/tmp/tmpgw9reekh/tvm_kernels.maca"
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
  %cond.i.i2330 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64), !dbg !49
  %mul11 = shl nsw i32 %cond.i.i2330, 4, !dbg !52
  %4 = or disjoint i64 %2, 1, !dbg !53
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4, !dbg !43
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !dbg !43, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2330.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64), !dbg !49
  %mul11.1 = shl nsw i32 %cond.i.i2330.1, 4, !dbg !52
  %6 = or disjoint i64 %2, 2, !dbg !53
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6, !dbg !43
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !dbg !43, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2330.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64), !dbg !49
  %mul11.2 = shl nsw i32 %cond.i.i2330.2, 4, !dbg !52
  %8 = or disjoint i64 %2, 3, !dbg !53
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8, !dbg !43
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !dbg !43, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2330.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64), !dbg !49
  %mul11.3 = shl nsw i32 %cond.i.i2330.3, 4, !dbg !52
  %10 = or disjoint i64 %2, 4, !dbg !53
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10, !dbg !43
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !dbg !43, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2330.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64), !dbg !49
  %mul11.4 = shl nsw i32 %cond.i.i2330.4, 4, !dbg !52
  %12 = or disjoint i64 %2, 5, !dbg !53
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12, !dbg !43
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !dbg !43, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2330.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64), !dbg !49
  %mul11.5 = shl nsw i32 %cond.i.i2330.5, 4, !dbg !52
  %14 = or disjoint i64 %2, 6, !dbg !53
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14, !dbg !43
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !dbg !43, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2330.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64), !dbg !49
  %mul11.6 = shl nsw i32 %cond.i.i2330.6, 4, !dbg !52
  %16 = or disjoint i64 %2, 7, !dbg !53
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16, !dbg !43
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !dbg !43, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2330.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64), !dbg !49
  %mul11.7 = shl nsw i32 %cond.i.i2330.7, 4, !dbg !52
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
  %or.cond2464 = or i1 %or.cond, %cmp47.not, !dbg !58
  br i1 %or.cond2464, label %if.end, label %for.cond48.preheader, !dbg !58

for.cond48.preheader:                             ; preds = %entry
  %mul54 = shl nsw i32 %0, 16
  %22 = shl nsw i32 %cond.i.i2330, 10
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
  %or.cond2465 = icmp ugt i32 %mul11.1, 1023, !dbg !63
  %cmp78.not = icmp sgt i32 %mul11.1, %1
  %or.cond2466 = or i1 %or.cond2465, %cmp78.not, !dbg !63
  br i1 %or.cond2466, label %if.end104, label %for.cond80.preheader, !dbg !63

for.cond80.preheader:                             ; preds = %if.end
  %mul86 = shl nsw i32 %0, 16
  %25 = shl nsw i32 %cond.i.i2330.1, 10
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
  %or.cond2467 = icmp ugt i32 %mul11.2, 1023, !dbg !68
  %cmp111.not = icmp sgt i32 %mul11.2, %1
  %or.cond2468 = or i1 %or.cond2467, %cmp111.not, !dbg !68
  br i1 %or.cond2468, label %if.end137, label %for.cond113.preheader, !dbg !68

for.cond113.preheader:                            ; preds = %if.end104
  %mul119 = shl nsw i32 %0, 16
  %28 = shl nsw i32 %cond.i.i2330.2, 10
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
  %or.cond2469 = icmp ugt i32 %mul11.3, 1023, !dbg !73
  %cmp144.not = icmp sgt i32 %mul11.3, %1
  %or.cond2470 = or i1 %or.cond2469, %cmp144.not, !dbg !73
  br i1 %or.cond2470, label %if.end170, label %for.cond146.preheader, !dbg !73

for.cond146.preheader:                            ; preds = %if.end137
  %mul152 = shl nsw i32 %0, 16
  %31 = shl nsw i32 %cond.i.i2330.3, 10
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
  %or.cond2471 = icmp ult i32 %mul11, 1024, !dbg !77
  br i1 %or.cond2471, label %land.lhs.true174, label %if.end276, !dbg !77

land.lhs.true174:                                 ; preds = %if.end170
  br i1 %cmp47.not, label %if.end276, label %if.then177, !dbg !78

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
  %acc_s.sroa.0.0.vec.insert3036 = insertelement <4 x float> poison, float %fneg., i64 0, !dbg !83
  %cmp193.not.1.not = icmp slt i32 %add190, %1, !dbg !82
  %fneg..1 = select i1 %cmp193.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3129 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3036, float %fneg..1, i64 1, !dbg !83
  %add191.2 = or disjoint i32 %add190, 2, !dbg !84
  %cmp193.not.2 = icmp sgt i32 %add191.2, %1, !dbg !82
  %fneg..2 = select i1 %cmp193.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3222 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3129, float %fneg..2, i64 2, !dbg !83
  %add191.3 = or disjoint i32 %add190, 3, !dbg !84
  %cmp193.not.3 = icmp sgt i32 %add191.3, %1, !dbg !82
  %fneg..3 = select i1 %cmp193.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3315 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3222, float %fneg..3, i64 3, !dbg !83
  br label %if.end206

if.end206:                                        ; preds = %if.then177, %for.cond182.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3315, %for.cond182.preheader ], [ zeroinitializer, %if.then177 ], !dbg !85
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
  %48 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %42), !dbg !96
  %49 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %44), !dbg !96
  %50 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %46), !dbg !96
  br label %if.end276, !dbg !105

if.end276:                                        ; preds = %if.end206, %land.lhs.true174, %if.end170
  %sum_acc.sroa.56.0 = phi float [ 0.000000e+00, %land.lhs.true174 ], [ %46, %if.end206 ], [ 0.000000e+00, %if.end170 ], !dbg !85
  %sum_acc.sroa.38.0 = phi float [ 0.000000e+00, %land.lhs.true174 ], [ %44, %if.end206 ], [ 0.000000e+00, %if.end170 ], !dbg !85
  %sum_acc.sroa.20.0 = phi float [ 0.000000e+00, %land.lhs.true174 ], [ %42, %if.end206 ], [ 0.000000e+00, %if.end170 ], !dbg !85
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %land.lhs.true174 ], [ %40, %if.end206 ], [ 0.000000e+00, %if.end170 ], !dbg !85
  %phase_weights.sroa.8.0 = phi i16 [ undef, %land.lhs.true174 ], [ %50, %if.end206 ], [ undef, %if.end170 ]
  %phase_weights.sroa.6.0 = phi i16 [ undef, %land.lhs.true174 ], [ %49, %if.end206 ], [ undef, %if.end170 ]
  %phase_weights.sroa.4.0 = phi i16 [ undef, %land.lhs.true174 ], [ %48, %if.end206 ], [ undef, %if.end170 ]
  %phase_weights.sroa.0.0 = phi i16 [ undef, %land.lhs.true174 ], [ %47, %if.end206 ], [ undef, %if.end170 ]
  %or.cond2472 = icmp ult i32 %mul11.1, 1024, !dbg !105
  br i1 %or.cond2472, label %land.lhs.true280, label %if.end382, !dbg !105

land.lhs.true280:                                 ; preds = %if.end276
  br i1 %cmp78.not, label %if.end382, label %if.then283, !dbg !106

if.then283:                                       ; preds = %land.lhs.true280
  %add285 = or disjoint i32 %mul11.1, 15, !dbg !107
  %cmp286 = icmp ult i32 %1, %add285, !dbg !108
  br i1 %cmp286, label %for.cond288.preheader, label %if.end312, !dbg !109

for.cond288.preheader:                            ; preds = %if.then283
  %51 = lshr i32 %18, 2
  %mul294 = and i32 %51, 252
  %add295 = add nuw nsw i32 %mul11.1, %mul294
  %cmp298.not = icmp sgt i32 %add295, %1, !dbg !110
  %fneg.2315 = select i1 %cmp298.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3045 = insertelement <4 x float> poison, float %fneg.2315, i64 0, !dbg !111
  %cmp298.not.1.not = icmp slt i32 %add295, %1, !dbg !110
  %fneg.2315.1 = select i1 %cmp298.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3138 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3045, float %fneg.2315.1, i64 1, !dbg !111
  %add296.2 = or disjoint i32 %add295, 2, !dbg !112
  %cmp298.not.2 = icmp sgt i32 %add296.2, %1, !dbg !110
  %fneg.2315.2 = select i1 %cmp298.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3231 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3138, float %fneg.2315.2, i64 2, !dbg !111
  %add296.3 = or disjoint i32 %add295, 3, !dbg !112
  %cmp298.not.3 = icmp sgt i32 %add296.3, %1, !dbg !110
  %fneg.2315.3 = select i1 %cmp298.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3324 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3231, float %fneg.2315.3, i64 3, !dbg !111
  br label %if.end312

if.end312:                                        ; preds = %if.then283, %for.cond288.preheader
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3324, %for.cond288.preheader ], [ zeroinitializer, %if.then283 ], !dbg !85
  %52 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.2), !dbg !113, !call_argsrelate !87
  %53 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %52), !dbg !113, !call_argsrelate !87
  %54 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %53), !dbg !113, !call_argsrelate !87
  %55 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %54), !dbg !113, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract3047 = extractelement <4 x float> %55, i64 0, !dbg !114
  %mul347 = fmul contract float %acc_s.sroa.0.0.vec.extract3047, 0x3FB99999A0000000, !dbg !115
  %56 = tail call contract noundef float @llvm.minnum.f32(float %mul347, float 0x4024CB5EC0000000), !dbg !116
  %57 = tail call contract noundef float @llvm.exp.f32(float %56), !dbg !118
  %acc_s.sroa.0.4.vec.extract3140 = extractelement <4 x float> %55, i64 1, !dbg !114
  %mul347.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3140, 0x3FB99999A0000000, !dbg !115
  %58 = tail call contract noundef float @llvm.minnum.f32(float %mul347.1, float 0x4024CB5EC0000000), !dbg !116
  %59 = tail call contract noundef float @llvm.exp.f32(float %58), !dbg !118
  %acc_s.sroa.0.8.vec.extract3233 = extractelement <4 x float> %55, i64 2, !dbg !114
  %mul347.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3233, 0x3FB99999A0000000, !dbg !115
  %60 = tail call contract noundef float @llvm.minnum.f32(float %mul347.2, float 0x4024CB5EC0000000), !dbg !116
  %61 = tail call contract noundef float @llvm.exp.f32(float %60), !dbg !118
  %acc_s.sroa.0.12.vec.extract3326 = extractelement <4 x float> %55, i64 3, !dbg !114
  %mul347.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3326, 0x3FB99999A0000000, !dbg !115
  %62 = tail call contract noundef float @llvm.minnum.f32(float %mul347.3, float 0x4024CB5EC0000000), !dbg !116
  %63 = tail call contract noundef float @llvm.exp.f32(float %62), !dbg !118
  %add363 = fadd contract float %sum_acc.sroa.0.0, %57, !dbg !120
  %add363.1 = fadd contract float %sum_acc.sroa.20.0, %59, !dbg !120
  %add363.2 = fadd contract float %sum_acc.sroa.38.0, %61, !dbg !120
  %add363.3 = fadd contract float %sum_acc.sroa.56.0, %63, !dbg !120
  %64 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %57), !dbg !121
  %65 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %59), !dbg !121
  %66 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %61), !dbg !121
  %67 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %63), !dbg !121
  br label %if.end382, !dbg !125

if.end382:                                        ; preds = %if.end312, %land.lhs.true280, %if.end276
  %sum_acc.sroa.56.1 = phi float [ %sum_acc.sroa.56.0, %land.lhs.true280 ], [ %add363.3, %if.end312 ], [ %sum_acc.sroa.56.0, %if.end276 ], !dbg !85
  %sum_acc.sroa.38.1 = phi float [ %sum_acc.sroa.38.0, %land.lhs.true280 ], [ %add363.2, %if.end312 ], [ %sum_acc.sroa.38.0, %if.end276 ], !dbg !85
  %sum_acc.sroa.20.1 = phi float [ %sum_acc.sroa.20.0, %land.lhs.true280 ], [ %add363.1, %if.end312 ], [ %sum_acc.sroa.20.0, %if.end276 ], !dbg !85
  %sum_acc.sroa.0.1 = phi float [ %sum_acc.sroa.0.0, %land.lhs.true280 ], [ %add363, %if.end312 ], [ %sum_acc.sroa.0.0, %if.end276 ], !dbg !85
  %phase_weights.sroa.16.0 = phi i16 [ undef, %land.lhs.true280 ], [ %67, %if.end312 ], [ undef, %if.end276 ]
  %phase_weights.sroa.14.0 = phi i16 [ undef, %land.lhs.true280 ], [ %66, %if.end312 ], [ undef, %if.end276 ]
  %phase_weights.sroa.12.0 = phi i16 [ undef, %land.lhs.true280 ], [ %65, %if.end312 ], [ undef, %if.end276 ]
  %phase_weights.sroa.10.0 = phi i16 [ undef, %land.lhs.true280 ], [ %64, %if.end312 ], [ undef, %if.end276 ]
  %or.cond2473 = icmp ult i32 %mul11.2, 1024, !dbg !125
  br i1 %or.cond2473, label %land.lhs.true386, label %if.end488, !dbg !125

land.lhs.true386:                                 ; preds = %if.end382
  br i1 %cmp111.not, label %if.end488, label %if.then389, !dbg !126

if.then389:                                       ; preds = %land.lhs.true386
  %add391 = or disjoint i32 %mul11.2, 15, !dbg !127
  %cmp392 = icmp ult i32 %1, %add391, !dbg !128
  br i1 %cmp392, label %for.cond394.preheader, label %if.end418, !dbg !129

for.cond394.preheader:                            ; preds = %if.then389
  %68 = lshr i32 %18, 2
  %mul400 = and i32 %68, 252
  %add401 = add nuw nsw i32 %mul11.2, %mul400
  %cmp404.not = icmp sgt i32 %add401, %1, !dbg !130
  %fneg.2316 = select i1 %cmp404.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3055 = insertelement <4 x float> poison, float %fneg.2316, i64 0, !dbg !131
  %cmp404.not.1.not = icmp slt i32 %add401, %1, !dbg !130
  %fneg.2316.1 = select i1 %cmp404.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3148 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3055, float %fneg.2316.1, i64 1, !dbg !131
  %add402.2 = or disjoint i32 %add401, 2, !dbg !132
  %cmp404.not.2 = icmp sgt i32 %add402.2, %1, !dbg !130
  %fneg.2316.2 = select i1 %cmp404.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3241 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3148, float %fneg.2316.2, i64 2, !dbg !131
  %add402.3 = or disjoint i32 %add401, 3, !dbg !132
  %cmp404.not.3 = icmp sgt i32 %add402.3, %1, !dbg !130
  %fneg.2316.3 = select i1 %cmp404.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3334 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3241, float %fneg.2316.3, i64 3, !dbg !131
  br label %if.end418

if.end418:                                        ; preds = %if.then389, %for.cond394.preheader
  %acc_s.sroa.0.4 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3334, %for.cond394.preheader ], [ zeroinitializer, %if.then389 ], !dbg !85
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.4), !dbg !133, !call_argsrelate !87
  %70 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %69), !dbg !133, !call_argsrelate !87
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %70), !dbg !133, !call_argsrelate !87
  %72 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %71), !dbg !133, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract3057 = extractelement <4 x float> %72, i64 0, !dbg !134
  %mul453 = fmul contract float %acc_s.sroa.0.0.vec.extract3057, 0x3FB99999A0000000, !dbg !135
  %73 = tail call contract noundef float @llvm.minnum.f32(float %mul453, float 0x4024CB5EC0000000), !dbg !136
  %74 = tail call contract noundef float @llvm.exp.f32(float %73), !dbg !138
  %acc_s.sroa.0.4.vec.extract3150 = extractelement <4 x float> %72, i64 1, !dbg !134
  %mul453.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3150, 0x3FB99999A0000000, !dbg !135
  %75 = tail call contract noundef float @llvm.minnum.f32(float %mul453.1, float 0x4024CB5EC0000000), !dbg !136
  %76 = tail call contract noundef float @llvm.exp.f32(float %75), !dbg !138
  %acc_s.sroa.0.8.vec.extract3243 = extractelement <4 x float> %72, i64 2, !dbg !134
  %mul453.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3243, 0x3FB99999A0000000, !dbg !135
  %77 = tail call contract noundef float @llvm.minnum.f32(float %mul453.2, float 0x4024CB5EC0000000), !dbg !136
  %78 = tail call contract noundef float @llvm.exp.f32(float %77), !dbg !138
  %acc_s.sroa.0.12.vec.extract3336 = extractelement <4 x float> %72, i64 3, !dbg !134
  %mul453.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3336, 0x3FB99999A0000000, !dbg !135
  %79 = tail call contract noundef float @llvm.minnum.f32(float %mul453.3, float 0x4024CB5EC0000000), !dbg !136
  %80 = tail call contract noundef float @llvm.exp.f32(float %79), !dbg !138
  %add469 = fadd contract float %sum_acc.sroa.0.1, %74, !dbg !140
  %add469.1 = fadd contract float %sum_acc.sroa.20.1, %76, !dbg !140
  %add469.2 = fadd contract float %sum_acc.sroa.38.1, %78, !dbg !140
  %add469.3 = fadd contract float %sum_acc.sroa.56.1, %80, !dbg !140
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %74), !dbg !141
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %76), !dbg !141
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %78), !dbg !141
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %80), !dbg !141
  br label %if.end488, !dbg !145

if.end488:                                        ; preds = %if.end418, %land.lhs.true386, %if.end382
  %sum_acc.sroa.56.2 = phi float [ %sum_acc.sroa.56.1, %land.lhs.true386 ], [ %add469.3, %if.end418 ], [ %sum_acc.sroa.56.1, %if.end382 ], !dbg !85
  %sum_acc.sroa.38.2 = phi float [ %sum_acc.sroa.38.1, %land.lhs.true386 ], [ %add469.2, %if.end418 ], [ %sum_acc.sroa.38.1, %if.end382 ], !dbg !85
  %sum_acc.sroa.20.2 = phi float [ %sum_acc.sroa.20.1, %land.lhs.true386 ], [ %add469.1, %if.end418 ], [ %sum_acc.sroa.20.1, %if.end382 ], !dbg !85
  %sum_acc.sroa.0.2 = phi float [ %sum_acc.sroa.0.1, %land.lhs.true386 ], [ %add469, %if.end418 ], [ %sum_acc.sroa.0.1, %if.end382 ], !dbg !85
  %phase_weights.sroa.24.0 = phi i16 [ undef, %land.lhs.true386 ], [ %84, %if.end418 ], [ undef, %if.end382 ]
  %phase_weights.sroa.22.0 = phi i16 [ undef, %land.lhs.true386 ], [ %83, %if.end418 ], [ undef, %if.end382 ]
  %phase_weights.sroa.20.0 = phi i16 [ undef, %land.lhs.true386 ], [ %82, %if.end418 ], [ undef, %if.end382 ]
  %phase_weights.sroa.18.0 = phi i16 [ undef, %land.lhs.true386 ], [ %81, %if.end418 ], [ undef, %if.end382 ]
  %or.cond2474 = icmp ult i32 %mul11.3, 1024, !dbg !145
  br i1 %or.cond2474, label %land.lhs.true492, label %if.end594, !dbg !145

land.lhs.true492:                                 ; preds = %if.end488
  br i1 %cmp144.not, label %if.end594, label %if.then495, !dbg !146

if.then495:                                       ; preds = %land.lhs.true492
  %add497 = or disjoint i32 %mul11.3, 15, !dbg !147
  %cmp498 = icmp ult i32 %1, %add497, !dbg !148
  br i1 %cmp498, label %for.cond500.preheader, label %if.end524, !dbg !149

for.cond500.preheader:                            ; preds = %if.then495
  %85 = lshr i32 %18, 2
  %mul506 = and i32 %85, 252
  %add507 = add nuw nsw i32 %mul11.3, %mul506
  %cmp510.not = icmp sgt i32 %add507, %1, !dbg !150
  %fneg.2317 = select i1 %cmp510.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3065 = insertelement <4 x float> poison, float %fneg.2317, i64 0, !dbg !151
  %cmp510.not.1.not = icmp slt i32 %add507, %1, !dbg !150
  %fneg.2317.1 = select i1 %cmp510.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3158 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3065, float %fneg.2317.1, i64 1, !dbg !151
  %add508.2 = or disjoint i32 %add507, 2, !dbg !152
  %cmp510.not.2 = icmp sgt i32 %add508.2, %1, !dbg !150
  %fneg.2317.2 = select i1 %cmp510.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3251 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3158, float %fneg.2317.2, i64 2, !dbg !151
  %add508.3 = or disjoint i32 %add507, 3, !dbg !152
  %cmp510.not.3 = icmp sgt i32 %add508.3, %1, !dbg !150
  %fneg.2317.3 = select i1 %cmp510.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3344 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3251, float %fneg.2317.3, i64 3, !dbg !151
  br label %if.end524

if.end524:                                        ; preds = %if.then495, %for.cond500.preheader
  %acc_s.sroa.0.6 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3344, %for.cond500.preheader ], [ zeroinitializer, %if.then495 ], !dbg !85
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.6), !dbg !153, !call_argsrelate !87
  %87 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %86), !dbg !153, !call_argsrelate !87
  %88 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %87), !dbg !153, !call_argsrelate !87
  %89 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %88), !dbg !153, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract3067 = extractelement <4 x float> %89, i64 0, !dbg !154
  %mul559 = fmul contract float %acc_s.sroa.0.0.vec.extract3067, 0x3FB99999A0000000, !dbg !155
  %90 = tail call contract noundef float @llvm.minnum.f32(float %mul559, float 0x4024CB5EC0000000), !dbg !156
  %91 = tail call contract noundef float @llvm.exp.f32(float %90), !dbg !158
  %acc_s.sroa.0.4.vec.extract3160 = extractelement <4 x float> %89, i64 1, !dbg !154
  %mul559.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3160, 0x3FB99999A0000000, !dbg !155
  %92 = tail call contract noundef float @llvm.minnum.f32(float %mul559.1, float 0x4024CB5EC0000000), !dbg !156
  %93 = tail call contract noundef float @llvm.exp.f32(float %92), !dbg !158
  %acc_s.sroa.0.8.vec.extract3253 = extractelement <4 x float> %89, i64 2, !dbg !154
  %mul559.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3253, 0x3FB99999A0000000, !dbg !155
  %94 = tail call contract noundef float @llvm.minnum.f32(float %mul559.2, float 0x4024CB5EC0000000), !dbg !156
  %95 = tail call contract noundef float @llvm.exp.f32(float %94), !dbg !158
  %acc_s.sroa.0.12.vec.extract3346 = extractelement <4 x float> %89, i64 3, !dbg !154
  %mul559.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3346, 0x3FB99999A0000000, !dbg !155
  %96 = tail call contract noundef float @llvm.minnum.f32(float %mul559.3, float 0x4024CB5EC0000000), !dbg !156
  %97 = tail call contract noundef float @llvm.exp.f32(float %96), !dbg !158
  %add575 = fadd contract float %sum_acc.sroa.0.2, %91, !dbg !160
  %add575.1 = fadd contract float %sum_acc.sroa.20.2, %93, !dbg !160
  %add575.2 = fadd contract float %sum_acc.sroa.38.2, %95, !dbg !160
  %add575.3 = fadd contract float %sum_acc.sroa.56.2, %97, !dbg !160
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %91), !dbg !161
  %99 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %93), !dbg !161
  %100 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %95), !dbg !161
  %101 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %97), !dbg !161
  br label %if.end594, !dbg !165

if.end594:                                        ; preds = %if.end524, %land.lhs.true492, %if.end488
  %sum_acc.sroa.56.3 = phi float [ %sum_acc.sroa.56.2, %land.lhs.true492 ], [ %add575.3, %if.end524 ], [ %sum_acc.sroa.56.2, %if.end488 ], !dbg !85
  %sum_acc.sroa.38.3 = phi float [ %sum_acc.sroa.38.2, %land.lhs.true492 ], [ %add575.2, %if.end524 ], [ %sum_acc.sroa.38.2, %if.end488 ], !dbg !85
  %sum_acc.sroa.20.3 = phi float [ %sum_acc.sroa.20.2, %land.lhs.true492 ], [ %add575.1, %if.end524 ], [ %sum_acc.sroa.20.2, %if.end488 ], !dbg !85
  %sum_acc.sroa.0.3 = phi float [ %sum_acc.sroa.0.2, %land.lhs.true492 ], [ %add575, %if.end524 ], [ %sum_acc.sroa.0.2, %if.end488 ], !dbg !85
  %phase_weights.sroa.32.0 = phi i16 [ undef, %land.lhs.true492 ], [ %101, %if.end524 ], [ undef, %if.end488 ]
  %phase_weights.sroa.30.0 = phi i16 [ undef, %land.lhs.true492 ], [ %100, %if.end524 ], [ undef, %if.end488 ]
  %phase_weights.sroa.28.0 = phi i16 [ undef, %land.lhs.true492 ], [ %99, %if.end524 ], [ undef, %if.end488 ]
  %phase_weights.sroa.26.0 = phi i16 [ undef, %land.lhs.true492 ], [ %98, %if.end524 ], [ undef, %if.end488 ]
  %or.cond2475 = icmp ugt i32 %mul11.4, 1023, !dbg !166
  %cmp601.not = icmp sgt i32 %mul11.4, %1
  %or.cond2476 = or i1 %or.cond2475, %cmp601.not, !dbg !166
  br i1 %or.cond2476, label %if.end626, label %for.cond603.preheader, !dbg !166

for.cond603.preheader:                            ; preds = %if.end594
  %mul608 = shl nsw i32 %0, 16
  %102 = shl nsw i32 %cond.i.i2330.4, 10
  %mul610 = and i32 %102, 64512
  %mul615 = shl nuw nsw i32 %18, 3
  %add611 = or disjoint i32 %mul615, %mul608
  %add613 = add nuw nsw i32 %add611, %mul610
  %103 = zext nneg i32 %add613 to i64, !dbg !167
  %add.ptr618 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %103, !dbg !168
  %K_reg.sroa.0.0.copyload3418 = load <4 x half>, ptr addrspace(4) %add.ptr618, align 16, !dbg !169
  %K_reg.sroa.6.0.add.ptr618.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr618, i64 8, !dbg !169
  %K_reg.sroa.6.0.copyload3419 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.6.0.add.ptr618.sroa_idx, align 8, !dbg !169
  %104 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %103, !dbg !168
  %add.ptr618.1 = getelementptr inbounds i8, ptr addrspace(4) %104, i64 1024, !dbg !168
  %K_reg.sroa.8.16.copyload3422 = load <4 x half>, ptr addrspace(4) %add.ptr618.1, align 16, !dbg !169
  %K_reg.sroa.12.16.add.ptr618.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %104, i64 1032, !dbg !169
  %K_reg.sroa.12.16.copyload3423 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.12.16.add.ptr618.1.sroa_idx, align 8, !dbg !169
  br label %if.end626, !dbg !170

if.end626:                                        ; preds = %for.cond603.preheader, %if.end594
  %K_reg.sroa.12.1 = phi <4 x half> [ %K_reg.sroa.12.0, %if.end594 ], [ %K_reg.sroa.12.16.copyload3423, %for.cond603.preheader ]
  %K_reg.sroa.8.1 = phi <4 x half> [ %K_reg.sroa.8.0, %if.end594 ], [ %K_reg.sroa.8.16.copyload3422, %for.cond603.preheader ]
  %K_reg.sroa.6.1 = phi <4 x half> [ %K_reg.sroa.6.0, %if.end594 ], [ %K_reg.sroa.6.0.copyload3419, %for.cond603.preheader ]
  %K_reg.sroa.0.1 = phi <4 x half> [ %K_reg.sroa.0.0, %if.end594 ], [ %K_reg.sroa.0.0.copyload3418, %for.cond603.preheader ]
  %or.cond2477 = icmp ugt i32 %mul11.5, 1023, !dbg !171
  %cmp633.not = icmp sgt i32 %mul11.5, %1
  %or.cond2478 = or i1 %or.cond2477, %cmp633.not, !dbg !171
  br i1 %or.cond2478, label %if.end658, label %for.cond635.preheader, !dbg !171

for.cond635.preheader:                            ; preds = %if.end626
  %mul640 = shl nsw i32 %0, 16
  %105 = shl nsw i32 %cond.i.i2330.5, 10
  %mul642 = and i32 %105, 64512
  %mul647 = shl nuw nsw i32 %18, 3
  %add643 = or disjoint i32 %mul647, %mul640
  %add645 = add nuw nsw i32 %add643, %mul642
  %106 = zext nneg i32 %add645 to i64, !dbg !172
  %add.ptr650 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %106, !dbg !173
  %K_reg1.sroa.0.0.copyload3410 = load <4 x half>, ptr addrspace(4) %add.ptr650, align 16, !dbg !174
  %K_reg1.sroa.6.0.add.ptr650.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr650, i64 8, !dbg !174
  %K_reg1.sroa.6.0.copyload3411 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.6.0.add.ptr650.sroa_idx, align 8, !dbg !174
  %107 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %106, !dbg !173
  %add.ptr650.1 = getelementptr inbounds i8, ptr addrspace(4) %107, i64 1024, !dbg !173
  %K_reg1.sroa.8.16.copyload3414 = load <4 x half>, ptr addrspace(4) %add.ptr650.1, align 16, !dbg !174
  %K_reg1.sroa.12.16.add.ptr650.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %107, i64 1032, !dbg !174
  %K_reg1.sroa.12.16.copyload3415 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.12.16.add.ptr650.1.sroa_idx, align 8, !dbg !174
  br label %if.end658, !dbg !175

if.end658:                                        ; preds = %for.cond635.preheader, %if.end626
  %K_reg1.sroa.12.1 = phi <4 x half> [ %K_reg1.sroa.12.0, %if.end626 ], [ %K_reg1.sroa.12.16.copyload3415, %for.cond635.preheader ]
  %K_reg1.sroa.8.1 = phi <4 x half> [ %K_reg1.sroa.8.0, %if.end626 ], [ %K_reg1.sroa.8.16.copyload3414, %for.cond635.preheader ]
  %K_reg1.sroa.6.1 = phi <4 x half> [ %K_reg1.sroa.6.0, %if.end626 ], [ %K_reg1.sroa.6.0.copyload3411, %for.cond635.preheader ]
  %K_reg1.sroa.0.1 = phi <4 x half> [ %K_reg1.sroa.0.0, %if.end626 ], [ %K_reg1.sroa.0.0.copyload3410, %for.cond635.preheader ]
  %or.cond2479 = icmp ugt i32 %mul11.6, 1023, !dbg !176
  %cmp665.not = icmp sgt i32 %mul11.6, %1
  %or.cond2480 = or i1 %or.cond2479, %cmp665.not, !dbg !176
  br i1 %or.cond2480, label %if.end690, label %for.cond667.preheader, !dbg !176

for.cond667.preheader:                            ; preds = %if.end658
  %mul672 = shl nsw i32 %0, 16
  %108 = shl nsw i32 %cond.i.i2330.6, 10
  %mul674 = and i32 %108, 64512
  %mul679 = shl nuw nsw i32 %18, 3
  %add675 = or disjoint i32 %mul679, %mul672
  %add677 = add nuw nsw i32 %add675, %mul674
  %109 = zext nneg i32 %add677 to i64, !dbg !177
  %add.ptr682 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %109, !dbg !178
  %K_reg2.sroa.0.0.copyload3402 = load <4 x half>, ptr addrspace(4) %add.ptr682, align 16, !dbg !179
  %K_reg2.sroa.6.0.add.ptr682.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr682, i64 8, !dbg !179
  %K_reg2.sroa.6.0.copyload3403 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.6.0.add.ptr682.sroa_idx, align 8, !dbg !179
  %110 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %109, !dbg !178
  %add.ptr682.1 = getelementptr inbounds i8, ptr addrspace(4) %110, i64 1024, !dbg !178
  %K_reg2.sroa.8.16.copyload3406 = load <4 x half>, ptr addrspace(4) %add.ptr682.1, align 16, !dbg !179
  %K_reg2.sroa.12.16.add.ptr682.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %110, i64 1032, !dbg !179
  %K_reg2.sroa.12.16.copyload3407 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.12.16.add.ptr682.1.sroa_idx, align 8, !dbg !179
  br label %if.end690, !dbg !180

if.end690:                                        ; preds = %for.cond667.preheader, %if.end658
  %K_reg2.sroa.12.1 = phi <4 x half> [ %K_reg2.sroa.12.0, %if.end658 ], [ %K_reg2.sroa.12.16.copyload3407, %for.cond667.preheader ]
  %K_reg2.sroa.8.1 = phi <4 x half> [ %K_reg2.sroa.8.0, %if.end658 ], [ %K_reg2.sroa.8.16.copyload3406, %for.cond667.preheader ]
  %K_reg2.sroa.6.1 = phi <4 x half> [ %K_reg2.sroa.6.0, %if.end658 ], [ %K_reg2.sroa.6.0.copyload3403, %for.cond667.preheader ]
  %K_reg2.sroa.0.1 = phi <4 x half> [ %K_reg2.sroa.0.0, %if.end658 ], [ %K_reg2.sroa.0.0.copyload3402, %for.cond667.preheader ]
  %or.cond2481 = icmp ugt i32 %mul11.7, 1023, !dbg !181
  %cmp697.not = icmp sgt i32 %mul11.7, %1
  %or.cond2482 = or i1 %or.cond2481, %cmp697.not, !dbg !181
  br i1 %or.cond2482, label %if.end722, label %for.cond699.preheader, !dbg !181

for.cond699.preheader:                            ; preds = %if.end690
  %mul704 = shl nsw i32 %0, 16
  %111 = shl nsw i32 %cond.i.i2330.7, 10
  %mul706 = and i32 %111, 64512
  %mul711 = shl nuw nsw i32 %18, 3
  %add707 = or disjoint i32 %mul711, %mul704
  %add709 = add nuw nsw i32 %add707, %mul706
  %112 = zext nneg i32 %add709 to i64, !dbg !182
  %add.ptr714 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %112, !dbg !183
  %K_reg3.sroa.0.0.copyload3394 = load <4 x half>, ptr addrspace(4) %add.ptr714, align 16, !dbg !184
  %K_reg3.sroa.6.0.add.ptr714.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr714, i64 8, !dbg !184
  %K_reg3.sroa.6.0.copyload3395 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.6.0.add.ptr714.sroa_idx, align 8, !dbg !184
  %113 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %112, !dbg !183
  %add.ptr714.1 = getelementptr inbounds i8, ptr addrspace(4) %113, i64 1024, !dbg !183
  %K_reg3.sroa.8.16.copyload3398 = load <4 x half>, ptr addrspace(4) %add.ptr714.1, align 16, !dbg !184
  %K_reg3.sroa.12.16.add.ptr714.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %113, i64 1032, !dbg !184
  %K_reg3.sroa.12.16.copyload3399 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.12.16.add.ptr714.1.sroa_idx, align 8, !dbg !184
  br label %if.end722, !dbg !185

if.end722:                                        ; preds = %for.cond699.preheader, %if.end690
  %K_reg3.sroa.12.1 = phi <4 x half> [ %K_reg3.sroa.12.0, %if.end690 ], [ %K_reg3.sroa.12.16.copyload3399, %for.cond699.preheader ]
  %K_reg3.sroa.8.1 = phi <4 x half> [ %K_reg3.sroa.8.0, %if.end690 ], [ %K_reg3.sroa.8.16.copyload3398, %for.cond699.preheader ]
  %K_reg3.sroa.6.1 = phi <4 x half> [ %K_reg3.sroa.6.0, %if.end690 ], [ %K_reg3.sroa.6.0.copyload3395, %for.cond699.preheader ]
  %K_reg3.sroa.0.1 = phi <4 x half> [ %K_reg3.sroa.0.0, %if.end690 ], [ %K_reg3.sroa.0.0.copyload3394, %for.cond699.preheader ]
  %or.cond2483 = icmp ult i32 %mul11.4, 1024, !dbg !185
  br i1 %or.cond2483, label %land.lhs.true726, label %if.end828, !dbg !185

land.lhs.true726:                                 ; preds = %if.end722
  br i1 %cmp601.not, label %if.end828, label %if.then729, !dbg !186

if.then729:                                       ; preds = %land.lhs.true726
  %add731 = or disjoint i32 %mul11.4, 15, !dbg !187
  %cmp732 = icmp ult i32 %1, %add731, !dbg !188
  br i1 %cmp732, label %for.cond734.preheader, label %if.end758, !dbg !189

for.cond734.preheader:                            ; preds = %if.then729
  %114 = lshr i32 %18, 2
  %mul740 = and i32 %114, 252
  %add741 = add nuw nsw i32 %mul11.4, %mul740
  %cmp744.not = icmp sgt i32 %add741, %1, !dbg !190
  %fneg.2318 = select i1 %cmp744.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3075 = insertelement <4 x float> poison, float %fneg.2318, i64 0, !dbg !191
  %cmp744.not.1.not = icmp slt i32 %add741, %1, !dbg !190
  %fneg.2318.1 = select i1 %cmp744.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3168 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3075, float %fneg.2318.1, i64 1, !dbg !191
  %add742.2 = or disjoint i32 %add741, 2, !dbg !192
  %cmp744.not.2 = icmp sgt i32 %add742.2, %1, !dbg !190
  %fneg.2318.2 = select i1 %cmp744.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3261 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3168, float %fneg.2318.2, i64 2, !dbg !191
  %add742.3 = or disjoint i32 %add741, 3, !dbg !192
  %cmp744.not.3 = icmp sgt i32 %add742.3, %1, !dbg !190
  %fneg.2318.3 = select i1 %cmp744.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3354 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3261, float %fneg.2318.3, i64 3, !dbg !191
  br label %if.end758

if.end758:                                        ; preds = %if.then729, %for.cond734.preheader
  %acc_s.sroa.0.8 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3354, %for.cond734.preheader ], [ zeroinitializer, %if.then729 ], !dbg !85
  %115 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.8), !dbg !193, !call_argsrelate !87
  %116 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %115), !dbg !193, !call_argsrelate !87
  %117 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %116), !dbg !193, !call_argsrelate !87
  %118 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %117), !dbg !193, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract3077 = extractelement <4 x float> %118, i64 0, !dbg !194
  %mul793 = fmul contract float %acc_s.sroa.0.0.vec.extract3077, 0x3FB99999A0000000, !dbg !195
  %119 = tail call contract noundef float @llvm.minnum.f32(float %mul793, float 0x4024CB5EC0000000), !dbg !196
  %120 = tail call contract noundef float @llvm.exp.f32(float %119), !dbg !198
  %acc_s.sroa.0.4.vec.extract3170 = extractelement <4 x float> %118, i64 1, !dbg !194
  %mul793.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3170, 0x3FB99999A0000000, !dbg !195
  %121 = tail call contract noundef float @llvm.minnum.f32(float %mul793.1, float 0x4024CB5EC0000000), !dbg !196
  %122 = tail call contract noundef float @llvm.exp.f32(float %121), !dbg !198
  %acc_s.sroa.0.8.vec.extract3263 = extractelement <4 x float> %118, i64 2, !dbg !194
  %mul793.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3263, 0x3FB99999A0000000, !dbg !195
  %123 = tail call contract noundef float @llvm.minnum.f32(float %mul793.2, float 0x4024CB5EC0000000), !dbg !196
  %124 = tail call contract noundef float @llvm.exp.f32(float %123), !dbg !198
  %acc_s.sroa.0.12.vec.extract3356 = extractelement <4 x float> %118, i64 3, !dbg !194
  %mul793.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3356, 0x3FB99999A0000000, !dbg !195
  %125 = tail call contract noundef float @llvm.minnum.f32(float %mul793.3, float 0x4024CB5EC0000000), !dbg !196
  %126 = tail call contract noundef float @llvm.exp.f32(float %125), !dbg !198
  %add809 = fadd contract float %sum_acc.sroa.0.3, %120, !dbg !200
  %add809.1 = fadd contract float %sum_acc.sroa.20.3, %122, !dbg !200
  %add809.2 = fadd contract float %sum_acc.sroa.38.3, %124, !dbg !200
  %add809.3 = fadd contract float %sum_acc.sroa.56.3, %126, !dbg !200
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %120), !dbg !201
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %122), !dbg !201
  %129 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %124), !dbg !201
  %130 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %126), !dbg !201
  br label %if.end828, !dbg !205

if.end828:                                        ; preds = %if.end758, %land.lhs.true726, %if.end722
  %sum_acc.sroa.56.4 = phi float [ %sum_acc.sroa.56.3, %land.lhs.true726 ], [ %add809.3, %if.end758 ], [ %sum_acc.sroa.56.3, %if.end722 ], !dbg !85
  %sum_acc.sroa.38.4 = phi float [ %sum_acc.sroa.38.3, %land.lhs.true726 ], [ %add809.2, %if.end758 ], [ %sum_acc.sroa.38.3, %if.end722 ], !dbg !85
  %sum_acc.sroa.20.4 = phi float [ %sum_acc.sroa.20.3, %land.lhs.true726 ], [ %add809.1, %if.end758 ], [ %sum_acc.sroa.20.3, %if.end722 ], !dbg !85
  %sum_acc.sroa.0.4 = phi float [ %sum_acc.sroa.0.3, %land.lhs.true726 ], [ %add809, %if.end758 ], [ %sum_acc.sroa.0.3, %if.end722 ], !dbg !85
  %phase_weights.sroa.40.0 = phi i16 [ undef, %land.lhs.true726 ], [ %130, %if.end758 ], [ undef, %if.end722 ]
  %phase_weights.sroa.38.0 = phi i16 [ undef, %land.lhs.true726 ], [ %129, %if.end758 ], [ undef, %if.end722 ]
  %phase_weights.sroa.36.0 = phi i16 [ undef, %land.lhs.true726 ], [ %128, %if.end758 ], [ undef, %if.end722 ]
  %phase_weights.sroa.34.0 = phi i16 [ undef, %land.lhs.true726 ], [ %127, %if.end758 ], [ undef, %if.end722 ]
  %or.cond2484 = icmp ult i32 %mul11.5, 1024, !dbg !205
  br i1 %or.cond2484, label %land.lhs.true832, label %if.end934, !dbg !205

land.lhs.true832:                                 ; preds = %if.end828
  br i1 %cmp633.not, label %if.end934, label %if.then835, !dbg !206

if.then835:                                       ; preds = %land.lhs.true832
  %add837 = or disjoint i32 %mul11.5, 15, !dbg !207
  %cmp838 = icmp ult i32 %1, %add837, !dbg !208
  br i1 %cmp838, label %for.cond840.preheader, label %if.end864, !dbg !209

for.cond840.preheader:                            ; preds = %if.then835
  %131 = lshr i32 %18, 2
  %mul846 = and i32 %131, 252
  %add847 = add nuw nsw i32 %mul11.5, %mul846
  %cmp850.not = icmp sgt i32 %add847, %1, !dbg !210
  %fneg.2319 = select i1 %cmp850.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3085 = insertelement <4 x float> poison, float %fneg.2319, i64 0, !dbg !211
  %cmp850.not.1.not = icmp slt i32 %add847, %1, !dbg !210
  %fneg.2319.1 = select i1 %cmp850.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3178 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3085, float %fneg.2319.1, i64 1, !dbg !211
  %add848.2 = or disjoint i32 %add847, 2, !dbg !212
  %cmp850.not.2 = icmp sgt i32 %add848.2, %1, !dbg !210
  %fneg.2319.2 = select i1 %cmp850.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3271 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3178, float %fneg.2319.2, i64 2, !dbg !211
  %add848.3 = or disjoint i32 %add847, 3, !dbg !212
  %cmp850.not.3 = icmp sgt i32 %add848.3, %1, !dbg !210
  %fneg.2319.3 = select i1 %cmp850.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3364 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3271, float %fneg.2319.3, i64 3, !dbg !211
  br label %if.end864

if.end864:                                        ; preds = %if.then835, %for.cond840.preheader
  %acc_s.sroa.0.10 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3364, %for.cond840.preheader ], [ zeroinitializer, %if.then835 ], !dbg !85
  %132 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.10), !dbg !213, !call_argsrelate !87
  %133 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %132), !dbg !213, !call_argsrelate !87
  %134 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %133), !dbg !213, !call_argsrelate !87
  %135 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %134), !dbg !213, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract3087 = extractelement <4 x float> %135, i64 0, !dbg !214
  %mul899 = fmul contract float %acc_s.sroa.0.0.vec.extract3087, 0x3FB99999A0000000, !dbg !215
  %136 = tail call contract noundef float @llvm.minnum.f32(float %mul899, float 0x4024CB5EC0000000), !dbg !216
  %137 = tail call contract noundef float @llvm.exp.f32(float %136), !dbg !218
  %acc_s.sroa.0.4.vec.extract3180 = extractelement <4 x float> %135, i64 1, !dbg !214
  %mul899.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3180, 0x3FB99999A0000000, !dbg !215
  %138 = tail call contract noundef float @llvm.minnum.f32(float %mul899.1, float 0x4024CB5EC0000000), !dbg !216
  %139 = tail call contract noundef float @llvm.exp.f32(float %138), !dbg !218
  %acc_s.sroa.0.8.vec.extract3273 = extractelement <4 x float> %135, i64 2, !dbg !214
  %mul899.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3273, 0x3FB99999A0000000, !dbg !215
  %140 = tail call contract noundef float @llvm.minnum.f32(float %mul899.2, float 0x4024CB5EC0000000), !dbg !216
  %141 = tail call contract noundef float @llvm.exp.f32(float %140), !dbg !218
  %acc_s.sroa.0.12.vec.extract3366 = extractelement <4 x float> %135, i64 3, !dbg !214
  %mul899.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3366, 0x3FB99999A0000000, !dbg !215
  %142 = tail call contract noundef float @llvm.minnum.f32(float %mul899.3, float 0x4024CB5EC0000000), !dbg !216
  %143 = tail call contract noundef float @llvm.exp.f32(float %142), !dbg !218
  %add915 = fadd contract float %sum_acc.sroa.0.4, %137, !dbg !220
  %add915.1 = fadd contract float %sum_acc.sroa.20.4, %139, !dbg !220
  %add915.2 = fadd contract float %sum_acc.sroa.38.4, %141, !dbg !220
  %add915.3 = fadd contract float %sum_acc.sroa.56.4, %143, !dbg !220
  %144 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %137), !dbg !221
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %139), !dbg !221
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %141), !dbg !221
  %147 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %143), !dbg !221
  %148 = insertelement <4 x i16> poison, i16 %144, i64 0, !dbg !225
  %149 = insertelement <4 x i16> %148, i16 %145, i64 1, !dbg !225
  %150 = insertelement <4 x i16> %149, i16 %146, i64 2, !dbg !225
  %151 = insertelement <4 x i16> %150, i16 %147, i64 3, !dbg !225
  %152 = bitcast <4 x i16> %151 to <4 x half>, !dbg !225
  br label %if.end934, !dbg !226

if.end934:                                        ; preds = %if.end864, %land.lhs.true832, %if.end828
  %sum_acc.sroa.56.5 = phi float [ %sum_acc.sroa.56.4, %land.lhs.true832 ], [ %add915.3, %if.end864 ], [ %sum_acc.sroa.56.4, %if.end828 ], !dbg !85
  %sum_acc.sroa.38.5 = phi float [ %sum_acc.sroa.38.4, %land.lhs.true832 ], [ %add915.2, %if.end864 ], [ %sum_acc.sroa.38.4, %if.end828 ], !dbg !85
  %sum_acc.sroa.20.5 = phi float [ %sum_acc.sroa.20.4, %land.lhs.true832 ], [ %add915.1, %if.end864 ], [ %sum_acc.sroa.20.4, %if.end828 ], !dbg !85
  %sum_acc.sroa.0.5 = phi float [ %sum_acc.sroa.0.4, %land.lhs.true832 ], [ %add915, %if.end864 ], [ %sum_acc.sroa.0.4, %if.end828 ], !dbg !85
  %153 = phi <4 x half> [ undef, %land.lhs.true832 ], [ %152, %if.end864 ], [ undef, %if.end828 ]
  %or.cond2485 = icmp ult i32 %mul11.6, 1024, !dbg !226
  br i1 %or.cond2485, label %land.lhs.true938, label %if.end1040, !dbg !226

land.lhs.true938:                                 ; preds = %if.end934
  br i1 %cmp665.not, label %if.end1040, label %if.then941, !dbg !227

if.then941:                                       ; preds = %land.lhs.true938
  %add943 = or disjoint i32 %mul11.6, 15, !dbg !228
  %cmp944 = icmp ult i32 %1, %add943, !dbg !229
  br i1 %cmp944, label %for.cond946.preheader, label %if.end970, !dbg !230

for.cond946.preheader:                            ; preds = %if.then941
  %154 = lshr i32 %18, 2
  %mul952 = and i32 %154, 252
  %add953 = add nuw nsw i32 %mul11.6, %mul952
  %cmp956.not = icmp sgt i32 %add953, %1, !dbg !231
  %fneg.2320 = select i1 %cmp956.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3095 = insertelement <4 x float> poison, float %fneg.2320, i64 0, !dbg !232
  %cmp956.not.1.not = icmp slt i32 %add953, %1, !dbg !231
  %fneg.2320.1 = select i1 %cmp956.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3188 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3095, float %fneg.2320.1, i64 1, !dbg !232
  %add954.2 = or disjoint i32 %add953, 2, !dbg !233
  %cmp956.not.2 = icmp sgt i32 %add954.2, %1, !dbg !231
  %fneg.2320.2 = select i1 %cmp956.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3281 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3188, float %fneg.2320.2, i64 2, !dbg !232
  %add954.3 = or disjoint i32 %add953, 3, !dbg !233
  %cmp956.not.3 = icmp sgt i32 %add954.3, %1, !dbg !231
  %fneg.2320.3 = select i1 %cmp956.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3374 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3281, float %fneg.2320.3, i64 3, !dbg !232
  br label %if.end970

if.end970:                                        ; preds = %if.then941, %for.cond946.preheader
  %acc_s.sroa.0.12 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3374, %for.cond946.preheader ], [ zeroinitializer, %if.then941 ], !dbg !85
  %155 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.12), !dbg !234, !call_argsrelate !87
  %156 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %155), !dbg !234, !call_argsrelate !87
  %157 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %156), !dbg !234, !call_argsrelate !87
  %158 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %157), !dbg !234, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract3097 = extractelement <4 x float> %158, i64 0, !dbg !235
  %mul1005 = fmul contract float %acc_s.sroa.0.0.vec.extract3097, 0x3FB99999A0000000, !dbg !236
  %159 = tail call contract noundef float @llvm.minnum.f32(float %mul1005, float 0x4024CB5EC0000000), !dbg !237
  %160 = tail call contract noundef float @llvm.exp.f32(float %159), !dbg !239
  %acc_s.sroa.0.4.vec.extract3190 = extractelement <4 x float> %158, i64 1, !dbg !235
  %mul1005.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3190, 0x3FB99999A0000000, !dbg !236
  %161 = tail call contract noundef float @llvm.minnum.f32(float %mul1005.1, float 0x4024CB5EC0000000), !dbg !237
  %162 = tail call contract noundef float @llvm.exp.f32(float %161), !dbg !239
  %acc_s.sroa.0.8.vec.extract3283 = extractelement <4 x float> %158, i64 2, !dbg !235
  %mul1005.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3283, 0x3FB99999A0000000, !dbg !236
  %163 = tail call contract noundef float @llvm.minnum.f32(float %mul1005.2, float 0x4024CB5EC0000000), !dbg !237
  %164 = tail call contract noundef float @llvm.exp.f32(float %163), !dbg !239
  %acc_s.sroa.0.12.vec.extract3376 = extractelement <4 x float> %158, i64 3, !dbg !235
  %mul1005.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3376, 0x3FB99999A0000000, !dbg !236
  %165 = tail call contract noundef float @llvm.minnum.f32(float %mul1005.3, float 0x4024CB5EC0000000), !dbg !237
  %166 = tail call contract noundef float @llvm.exp.f32(float %165), !dbg !239
  %add1021 = fadd contract float %sum_acc.sroa.0.5, %160, !dbg !241
  %add1021.1 = fadd contract float %sum_acc.sroa.20.5, %162, !dbg !241
  %add1021.2 = fadd contract float %sum_acc.sroa.38.5, %164, !dbg !241
  %add1021.3 = fadd contract float %sum_acc.sroa.56.5, %166, !dbg !241
  %167 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %160), !dbg !242
  %168 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %162), !dbg !242
  %169 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %164), !dbg !242
  %170 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %166), !dbg !242
  %171 = insertelement <4 x i16> poison, i16 %167, i64 0, !dbg !246
  %172 = insertelement <4 x i16> %171, i16 %168, i64 1, !dbg !246
  %173 = insertelement <4 x i16> %172, i16 %169, i64 2, !dbg !246
  %174 = insertelement <4 x i16> %173, i16 %170, i64 3, !dbg !246
  %175 = bitcast <4 x i16> %174 to <4 x half>, !dbg !246
  br label %if.end1040, !dbg !247

if.end1040:                                       ; preds = %if.end970, %land.lhs.true938, %if.end934
  %sum_acc.sroa.56.6 = phi float [ %sum_acc.sroa.56.5, %land.lhs.true938 ], [ %add1021.3, %if.end970 ], [ %sum_acc.sroa.56.5, %if.end934 ], !dbg !85
  %sum_acc.sroa.38.6 = phi float [ %sum_acc.sroa.38.5, %land.lhs.true938 ], [ %add1021.2, %if.end970 ], [ %sum_acc.sroa.38.5, %if.end934 ], !dbg !85
  %sum_acc.sroa.20.6 = phi float [ %sum_acc.sroa.20.5, %land.lhs.true938 ], [ %add1021.1, %if.end970 ], [ %sum_acc.sroa.20.5, %if.end934 ], !dbg !85
  %sum_acc.sroa.0.6 = phi float [ %sum_acc.sroa.0.5, %land.lhs.true938 ], [ %add1021, %if.end970 ], [ %sum_acc.sroa.0.5, %if.end934 ], !dbg !85
  %176 = phi <4 x half> [ undef, %land.lhs.true938 ], [ %175, %if.end970 ], [ undef, %if.end934 ]
  %or.cond2486 = icmp ult i32 %mul11.7, 1024, !dbg !247
  br i1 %or.cond2486, label %land.lhs.true1044, label %if.end1146, !dbg !247

land.lhs.true1044:                                ; preds = %if.end1040
  br i1 %cmp697.not, label %if.end1146, label %if.then1047, !dbg !248

if.then1047:                                      ; preds = %land.lhs.true1044
  %add1049 = or disjoint i32 %mul11.7, 15, !dbg !249
  %cmp1050 = icmp slt i32 %1, %add1049, !dbg !250
  br i1 %cmp1050, label %for.cond1052.preheader, label %if.end1076, !dbg !251

for.cond1052.preheader:                           ; preds = %if.then1047
  %177 = lshr i32 %18, 2
  %mul1058 = and i32 %177, 252
  %add1059 = add nuw nsw i32 %mul11.7, %mul1058
  %cmp1062.not = icmp sgt i32 %add1059, %1, !dbg !252
  %fneg.2321 = select i1 %cmp1062.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3105 = insertelement <4 x float> poison, float %fneg.2321, i64 0, !dbg !253
  %cmp1062.not.1.not = icmp slt i32 %add1059, %1, !dbg !252
  %fneg.2321.1 = select i1 %cmp1062.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3198 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3105, float %fneg.2321.1, i64 1, !dbg !253
  %add1060.2 = or disjoint i32 %add1059, 2, !dbg !254
  %cmp1062.not.2 = icmp sgt i32 %add1060.2, %1, !dbg !252
  %fneg.2321.2 = select i1 %cmp1062.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3291 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3198, float %fneg.2321.2, i64 2, !dbg !253
  %add1060.3 = or disjoint i32 %add1059, 3, !dbg !254
  %cmp1062.not.3 = icmp sgt i32 %add1060.3, %1, !dbg !252
  %fneg.2321.3 = select i1 %cmp1062.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3384 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3291, float %fneg.2321.3, i64 3, !dbg !253
  br label %if.end1076

if.end1076:                                       ; preds = %if.then1047, %for.cond1052.preheader
  %acc_s.sroa.0.14 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3384, %for.cond1052.preheader ], [ zeroinitializer, %if.then1047 ], !dbg !85
  %178 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.14), !dbg !255, !call_argsrelate !87
  %179 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %178), !dbg !255, !call_argsrelate !87
  %180 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %179), !dbg !255, !call_argsrelate !87
  %181 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %180), !dbg !255, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract3107 = extractelement <4 x float> %181, i64 0, !dbg !256
  %mul1111 = fmul contract float %acc_s.sroa.0.0.vec.extract3107, 0x3FB99999A0000000, !dbg !257
  %182 = tail call contract noundef float @llvm.minnum.f32(float %mul1111, float 0x4024CB5EC0000000), !dbg !258
  %183 = tail call contract noundef float @llvm.exp.f32(float %182), !dbg !260
  %acc_s.sroa.0.4.vec.extract3200 = extractelement <4 x float> %181, i64 1, !dbg !256
  %mul1111.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3200, 0x3FB99999A0000000, !dbg !257
  %184 = tail call contract noundef float @llvm.minnum.f32(float %mul1111.1, float 0x4024CB5EC0000000), !dbg !258
  %185 = tail call contract noundef float @llvm.exp.f32(float %184), !dbg !260
  %acc_s.sroa.0.8.vec.extract3293 = extractelement <4 x float> %181, i64 2, !dbg !256
  %mul1111.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3293, 0x3FB99999A0000000, !dbg !257
  %186 = tail call contract noundef float @llvm.minnum.f32(float %mul1111.2, float 0x4024CB5EC0000000), !dbg !258
  %187 = tail call contract noundef float @llvm.exp.f32(float %186), !dbg !260
  %acc_s.sroa.0.12.vec.extract3386 = extractelement <4 x float> %181, i64 3, !dbg !256
  %mul1111.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3386, 0x3FB99999A0000000, !dbg !257
  %188 = tail call contract noundef float @llvm.minnum.f32(float %mul1111.3, float 0x4024CB5EC0000000), !dbg !258
  %189 = tail call contract noundef float @llvm.exp.f32(float %188), !dbg !260
  %add1127 = fadd contract float %sum_acc.sroa.0.6, %183, !dbg !262
  %add1127.1 = fadd contract float %sum_acc.sroa.20.6, %185, !dbg !262
  %add1127.2 = fadd contract float %sum_acc.sroa.38.6, %187, !dbg !262
  %add1127.3 = fadd contract float %sum_acc.sroa.56.6, %189, !dbg !262
  %190 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %183), !dbg !263
  %191 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %185), !dbg !263
  %192 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %187), !dbg !263
  %193 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %189), !dbg !263
  %194 = insertelement <4 x i16> poison, i16 %190, i64 0, !dbg !267
  %195 = insertelement <4 x i16> %194, i16 %191, i64 1, !dbg !267
  %196 = insertelement <4 x i16> %195, i16 %192, i64 2, !dbg !267
  %197 = insertelement <4 x i16> %196, i16 %193, i64 3, !dbg !267
  %198 = bitcast <4 x i16> %197 to <4 x half>, !dbg !267
  br label %if.end1146, !dbg !268

if.end1146:                                       ; preds = %if.end1076, %land.lhs.true1044, %if.end1040
  %sum_acc.sroa.56.7 = phi float [ %sum_acc.sroa.56.6, %land.lhs.true1044 ], [ %add1127.3, %if.end1076 ], [ %sum_acc.sroa.56.6, %if.end1040 ], !dbg !85
  %sum_acc.sroa.38.7 = phi float [ %sum_acc.sroa.38.6, %land.lhs.true1044 ], [ %add1127.2, %if.end1076 ], [ %sum_acc.sroa.38.6, %if.end1040 ], !dbg !85
  %sum_acc.sroa.20.7 = phi float [ %sum_acc.sroa.20.6, %land.lhs.true1044 ], [ %add1127.1, %if.end1076 ], [ %sum_acc.sroa.20.6, %if.end1040 ], !dbg !85
  %sum_acc.sroa.0.7 = phi float [ %sum_acc.sroa.0.6, %land.lhs.true1044 ], [ %add1127, %if.end1076 ], [ %sum_acc.sroa.0.6, %if.end1040 ], !dbg !85
  %199 = phi <4 x half> [ undef, %land.lhs.true1044 ], [ %198, %if.end1076 ], [ undef, %if.end1040 ]
  br i1 %or.cond2464, label %if.end1259, label %for.cond1207.preheader, !dbg !269

for.cond1207.preheader:                           ; preds = %if.end1146
  %mul1212 = shl nsw i32 %0, 16
  %200 = shl nsw i32 %cond.i.i2330, 10
  %mul1214 = and i32 %200, 64512
  %mul1219 = shl nuw nsw i32 %18, 3
  %add1215 = or disjoint i32 %mul1219, %mul1212
  %add1217 = add nuw nsw i32 %add1215, %mul1214
  %201 = zext nneg i32 %add1217 to i64, !dbg !270
  %add.ptr1222 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %201, !dbg !271
  %V_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr1222, align 16, !dbg !272
  %V_reg.sroa.18.0.add.ptr1222.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1222, i64 8, !dbg !272
  %V_reg.sroa.18.0.copyload = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr1222.sroa_idx, align 8, !dbg !272
  %202 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %201, !dbg !271
  %add.ptr1222.1 = getelementptr inbounds i8, ptr addrspace(4) %202, i64 1024, !dbg !271
  %V_reg.sroa.26.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr1222.1, align 16, !dbg !272
  %V_reg.sroa.42.16.add.ptr1222.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %202, i64 1032, !dbg !272
  %V_reg.sroa.42.16.copyload = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr1222.1.sroa_idx, align 8, !dbg !272
  %203 = insertelement <4 x i16> poison, i16 %phase_weights.sroa.0.0, i64 0, !dbg !273
  %204 = insertelement <4 x i16> %203, i16 %phase_weights.sroa.4.0, i64 1, !dbg !273
  %205 = insertelement <4 x i16> %204, i16 %phase_weights.sroa.6.0, i64 2, !dbg !273
  %206 = insertelement <4 x i16> %205, i16 %phase_weights.sroa.8.0, i64 3, !dbg !273
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %206 to <4 x half>, !dbg !273
  %207 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !274, !call_argsrelate !275
  %208 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !274, !call_argsrelate !275
  %209 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !274, !call_argsrelate !275
  %210 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !274, !call_argsrelate !275
  br label %if.end1259, !dbg !276

if.end1259:                                       ; preds = %for.cond1207.preheader, %if.end1146
  %acc_o.sroa.110.0 = phi <4 x float> [ zeroinitializer, %if.end1146 ], [ %210, %for.cond1207.preheader ], !dbg !85
  %acc_o.sroa.74.0 = phi <4 x float> [ zeroinitializer, %if.end1146 ], [ %209, %for.cond1207.preheader ], !dbg !85
  %acc_o.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end1146 ], [ %208, %for.cond1207.preheader ], !dbg !85
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1146 ], [ %207, %for.cond1207.preheader ], !dbg !85
  br i1 %or.cond2466, label %if.end1321, label %for.cond1268.preheader, !dbg !276

for.cond1268.preheader:                           ; preds = %if.end1259
  %mul1273 = shl nsw i32 %0, 16
  %211 = shl nsw i32 %cond.i.i2330.1, 10
  %mul1275 = and i32 %211, 64512
  %mul1280 = shl nuw nsw i32 %18, 3
  %add1276 = or disjoint i32 %mul1280, %mul1273
  %add1278 = add nuw nsw i32 %add1276, %mul1275
  %212 = zext nneg i32 %add1278 to i64, !dbg !277
  %add.ptr1283 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %212, !dbg !278
  %V_reg.sroa.0.0.copyload2676 = load <4 x half>, ptr addrspace(4) %add.ptr1283, align 16, !dbg !279
  %V_reg.sroa.18.0.add.ptr1283.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1283, i64 8, !dbg !279
  %V_reg.sroa.18.0.copyload2683 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr1283.sroa_idx, align 8, !dbg !279
  %213 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %212, !dbg !278
  %add.ptr1283.1 = getelementptr inbounds i8, ptr addrspace(4) %213, i64 1024, !dbg !278
  %V_reg.sroa.26.16.copyload2704 = load <4 x half>, ptr addrspace(4) %add.ptr1283.1, align 16, !dbg !279
  %V_reg.sroa.42.16.add.ptr1283.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %213, i64 1032, !dbg !279
  %V_reg.sroa.42.16.copyload2711 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr1283.1.sroa_idx, align 8, !dbg !279
  %214 = insertelement <4 x i16> poison, i16 %phase_weights.sroa.10.0, i64 0, !dbg !280
  %215 = insertelement <4 x i16> %214, i16 %phase_weights.sroa.12.0, i64 1, !dbg !280
  %216 = insertelement <4 x i16> %215, i16 %phase_weights.sroa.14.0, i64 2, !dbg !280
  %217 = insertelement <4 x i16> %216, i16 %phase_weights.sroa.16.0, i64 3, !dbg !280
  %acc_s_cast.sroa.0.6.vec.insert2656 = bitcast <4 x i16> %217 to <4 x half>, !dbg !280
  %218 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload2676, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2656, <4 x float> zeroinitializer), !dbg !281, !call_argsrelate !275
  %219 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload2683, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2656, <4 x float> zeroinitializer), !dbg !281, !call_argsrelate !275
  %220 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload2704, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2656, <4 x float> zeroinitializer), !dbg !281, !call_argsrelate !275
  %221 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload2711, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2656, <4 x float> zeroinitializer), !dbg !281, !call_argsrelate !275
  br label %if.end1321, !dbg !282

if.end1321:                                       ; preds = %for.cond1268.preheader, %if.end1259
  %acc_o_1.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end1259 ], [ %221, %for.cond1268.preheader ], !dbg !85
  %acc_o_1.sroa.26.0 = phi <4 x float> [ zeroinitializer, %if.end1259 ], [ %220, %for.cond1268.preheader ], !dbg !85
  %acc_o_1.sroa.14.0 = phi <4 x float> [ zeroinitializer, %if.end1259 ], [ %219, %for.cond1268.preheader ], !dbg !85
  %acc_o_1.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1259 ], [ %218, %for.cond1268.preheader ], !dbg !85
  br i1 %or.cond2468, label %if.end1383, label %for.cond1330.preheader, !dbg !283

for.cond1330.preheader:                           ; preds = %if.end1321
  %mul1335 = shl nsw i32 %0, 16
  %222 = shl nsw i32 %cond.i.i2330.2, 10
  %mul1337 = and i32 %222, 64512
  %mul1342 = shl nuw nsw i32 %18, 3
  %add1338 = or disjoint i32 %mul1342, %mul1335
  %add1340 = add nuw nsw i32 %add1338, %mul1337
  %223 = zext nneg i32 %add1340 to i64, !dbg !284
  %add.ptr1345 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %223, !dbg !285
  %V_reg.sroa.0.0.copyload2677 = load <4 x half>, ptr addrspace(4) %add.ptr1345, align 16, !dbg !286
  %V_reg.sroa.18.0.add.ptr1345.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1345, i64 8, !dbg !286
  %V_reg.sroa.18.0.copyload2684 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr1345.sroa_idx, align 8, !dbg !286
  %224 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %223, !dbg !285
  %add.ptr1345.1 = getelementptr inbounds i8, ptr addrspace(4) %224, i64 1024, !dbg !285
  %V_reg.sroa.26.16.copyload2705 = load <4 x half>, ptr addrspace(4) %add.ptr1345.1, align 16, !dbg !286
  %V_reg.sroa.42.16.add.ptr1345.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %224, i64 1032, !dbg !286
  %V_reg.sroa.42.16.copyload2712 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr1345.1.sroa_idx, align 8, !dbg !286
  %225 = insertelement <4 x i16> poison, i16 %phase_weights.sroa.18.0, i64 0, !dbg !287
  %226 = insertelement <4 x i16> %225, i16 %phase_weights.sroa.20.0, i64 1, !dbg !287
  %227 = insertelement <4 x i16> %226, i16 %phase_weights.sroa.22.0, i64 2, !dbg !287
  %228 = insertelement <4 x i16> %227, i16 %phase_weights.sroa.24.0, i64 3, !dbg !287
  %acc_s_cast.sroa.0.6.vec.insert2658 = bitcast <4 x i16> %228 to <4 x half>, !dbg !287
  %229 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload2677, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2658, <4 x float> zeroinitializer), !dbg !288, !call_argsrelate !275
  %230 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload2684, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2658, <4 x float> zeroinitializer), !dbg !288, !call_argsrelate !275
  %231 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload2705, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2658, <4 x float> zeroinitializer), !dbg !288, !call_argsrelate !275
  %232 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload2712, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2658, <4 x float> zeroinitializer), !dbg !288, !call_argsrelate !275
  br label %if.end1383, !dbg !289

if.end1383:                                       ; preds = %for.cond1330.preheader, %if.end1321
  %acc_o_2.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end1321 ], [ %232, %for.cond1330.preheader ], !dbg !85
  %acc_o_2.sroa.26.0 = phi <4 x float> [ zeroinitializer, %if.end1321 ], [ %231, %for.cond1330.preheader ], !dbg !85
  %acc_o_2.sroa.14.0 = phi <4 x float> [ zeroinitializer, %if.end1321 ], [ %230, %for.cond1330.preheader ], !dbg !85
  %acc_o_2.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1321 ], [ %229, %for.cond1330.preheader ], !dbg !85
  br i1 %or.cond2470, label %if.end1445, label %for.cond1392.preheader, !dbg !290

for.cond1392.preheader:                           ; preds = %if.end1383
  %mul1397 = shl nsw i32 %0, 16
  %233 = shl nsw i32 %cond.i.i2330.3, 10
  %mul1399 = and i32 %233, 64512
  %mul1404 = shl nuw nsw i32 %18, 3
  %add1400 = or disjoint i32 %mul1404, %mul1397
  %add1402 = add nuw nsw i32 %add1400, %mul1399
  %234 = zext nneg i32 %add1402 to i64, !dbg !291
  %add.ptr1407 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %234, !dbg !292
  %V_reg.sroa.0.0.copyload2678 = load <4 x half>, ptr addrspace(4) %add.ptr1407, align 16, !dbg !293
  %V_reg.sroa.18.0.add.ptr1407.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1407, i64 8, !dbg !293
  %V_reg.sroa.18.0.copyload2685 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr1407.sroa_idx, align 8, !dbg !293
  %235 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %234, !dbg !292
  %add.ptr1407.1 = getelementptr inbounds i8, ptr addrspace(4) %235, i64 1024, !dbg !292
  %V_reg.sroa.26.16.copyload2706 = load <4 x half>, ptr addrspace(4) %add.ptr1407.1, align 16, !dbg !293
  %V_reg.sroa.42.16.add.ptr1407.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %235, i64 1032, !dbg !293
  %V_reg.sroa.42.16.copyload2713 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr1407.1.sroa_idx, align 8, !dbg !293
  %236 = insertelement <4 x i16> poison, i16 %phase_weights.sroa.26.0, i64 0, !dbg !294
  %237 = insertelement <4 x i16> %236, i16 %phase_weights.sroa.28.0, i64 1, !dbg !294
  %238 = insertelement <4 x i16> %237, i16 %phase_weights.sroa.30.0, i64 2, !dbg !294
  %239 = insertelement <4 x i16> %238, i16 %phase_weights.sroa.32.0, i64 3, !dbg !294
  %acc_s_cast.sroa.0.6.vec.insert2660 = bitcast <4 x i16> %239 to <4 x half>, !dbg !294
  %240 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload2678, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2660, <4 x float> zeroinitializer), !dbg !295, !call_argsrelate !275
  %241 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload2685, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2660, <4 x float> zeroinitializer), !dbg !295, !call_argsrelate !275
  %242 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload2706, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2660, <4 x float> zeroinitializer), !dbg !295, !call_argsrelate !275
  %243 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload2713, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2660, <4 x float> zeroinitializer), !dbg !295, !call_argsrelate !275
  br label %if.end1445, !dbg !296

if.end1445:                                       ; preds = %for.cond1392.preheader, %if.end1383
  %acc_o_3.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end1383 ], [ %243, %for.cond1392.preheader ], !dbg !85
  %acc_o_3.sroa.26.0 = phi <4 x float> [ zeroinitializer, %if.end1383 ], [ %242, %for.cond1392.preheader ], !dbg !85
  %acc_o_3.sroa.14.0 = phi <4 x float> [ zeroinitializer, %if.end1383 ], [ %241, %for.cond1392.preheader ], !dbg !85
  %acc_o_3.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1383 ], [ %240, %for.cond1392.preheader ], !dbg !85
  br i1 %or.cond2476, label %if.end1507, label %for.cond1454.preheader, !dbg !296

for.cond1454.preheader:                           ; preds = %if.end1445
  %mul1459 = shl nsw i32 %0, 16
  %244 = shl nsw i32 %cond.i.i2330.4, 10
  %mul1461 = and i32 %244, 64512
  %mul1466 = shl nuw nsw i32 %18, 3
  %add1462 = or disjoint i32 %mul1466, %mul1459
  %add1464 = add nuw nsw i32 %add1462, %mul1461
  %245 = zext nneg i32 %add1464 to i64, !dbg !297
  %add.ptr1469 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %245, !dbg !298
  %V_reg.sroa.0.0.copyload2679 = load <4 x half>, ptr addrspace(4) %add.ptr1469, align 16, !dbg !299
  %V_reg.sroa.18.0.add.ptr1469.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1469, i64 8, !dbg !299
  %V_reg.sroa.18.0.copyload2686 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr1469.sroa_idx, align 8, !dbg !299
  %246 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %245, !dbg !298
  %add.ptr1469.1 = getelementptr inbounds i8, ptr addrspace(4) %246, i64 1024, !dbg !298
  %V_reg.sroa.26.16.copyload2707 = load <4 x half>, ptr addrspace(4) %add.ptr1469.1, align 16, !dbg !299
  %V_reg.sroa.42.16.add.ptr1469.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %246, i64 1032, !dbg !299
  %V_reg.sroa.42.16.copyload2714 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr1469.1.sroa_idx, align 8, !dbg !299
  %247 = insertelement <4 x i16> poison, i16 %phase_weights.sroa.34.0, i64 0, !dbg !300
  %248 = insertelement <4 x i16> %247, i16 %phase_weights.sroa.36.0, i64 1, !dbg !300
  %249 = insertelement <4 x i16> %248, i16 %phase_weights.sroa.38.0, i64 2, !dbg !300
  %250 = insertelement <4 x i16> %249, i16 %phase_weights.sroa.40.0, i64 3, !dbg !300
  %acc_s_cast.sroa.0.6.vec.insert2662 = bitcast <4 x i16> %250 to <4 x half>, !dbg !300
  %251 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload2679, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2662, <4 x float> %acc_o.sroa.0.0), !dbg !301, !call_argsrelate !275
  %252 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload2686, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2662, <4 x float> %acc_o.sroa.38.0), !dbg !301, !call_argsrelate !275
  %253 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload2707, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2662, <4 x float> %acc_o.sroa.74.0), !dbg !301, !call_argsrelate !275
  %254 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload2714, <4 x half> %acc_s_cast.sroa.0.6.vec.insert2662, <4 x float> %acc_o.sroa.110.0), !dbg !301, !call_argsrelate !275
  br label %if.end1507, !dbg !302

if.end1507:                                       ; preds = %for.cond1454.preheader, %if.end1445
  %acc_o.sroa.110.1 = phi <4 x float> [ %acc_o.sroa.110.0, %if.end1445 ], [ %254, %for.cond1454.preheader ], !dbg !85
  %acc_o.sroa.74.1 = phi <4 x float> [ %acc_o.sroa.74.0, %if.end1445 ], [ %253, %for.cond1454.preheader ], !dbg !85
  %acc_o.sroa.38.1 = phi <4 x float> [ %acc_o.sroa.38.0, %if.end1445 ], [ %252, %for.cond1454.preheader ], !dbg !85
  %acc_o.sroa.0.1 = phi <4 x float> [ %acc_o.sroa.0.0, %if.end1445 ], [ %251, %for.cond1454.preheader ], !dbg !85
  br i1 %or.cond2478, label %if.end1569, label %for.cond1516.preheader, !dbg !302

for.cond1516.preheader:                           ; preds = %if.end1507
  %mul1521 = shl nsw i32 %0, 16
  %255 = shl nsw i32 %cond.i.i2330.5, 10
  %mul1523 = and i32 %255, 64512
  %mul1528 = shl nuw nsw i32 %18, 3
  %add1524 = or disjoint i32 %mul1528, %mul1521
  %add1526 = add nuw nsw i32 %add1524, %mul1523
  %256 = zext nneg i32 %add1526 to i64, !dbg !303
  %add.ptr1531 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %256, !dbg !304
  %V_reg.sroa.0.0.copyload2680 = load <4 x half>, ptr addrspace(4) %add.ptr1531, align 16, !dbg !305
  %V_reg.sroa.18.0.add.ptr1531.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1531, i64 8, !dbg !305
  %V_reg.sroa.18.0.copyload2687 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr1531.sroa_idx, align 8, !dbg !305
  %257 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %256, !dbg !304
  %add.ptr1531.1 = getelementptr inbounds i8, ptr addrspace(4) %257, i64 1024, !dbg !304
  %V_reg.sroa.26.16.copyload2708 = load <4 x half>, ptr addrspace(4) %add.ptr1531.1, align 16, !dbg !305
  %V_reg.sroa.42.16.add.ptr1531.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %257, i64 1032, !dbg !305
  %V_reg.sroa.42.16.copyload2715 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr1531.1.sroa_idx, align 8, !dbg !305
  %258 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload2680, <4 x half> %153, <4 x float> %acc_o_1.sroa.0.0), !dbg !306, !call_argsrelate !275
  %259 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload2687, <4 x half> %153, <4 x float> %acc_o_1.sroa.14.0), !dbg !306, !call_argsrelate !275
  %260 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload2708, <4 x half> %153, <4 x float> %acc_o_1.sroa.26.0), !dbg !306, !call_argsrelate !275
  %261 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload2715, <4 x half> %153, <4 x float> %acc_o_1.sroa.38.0), !dbg !306, !call_argsrelate !275
  br label %if.end1569, !dbg !307

if.end1569:                                       ; preds = %for.cond1516.preheader, %if.end1507
  %acc_o_1.sroa.38.1 = phi <4 x float> [ %acc_o_1.sroa.38.0, %if.end1507 ], [ %261, %for.cond1516.preheader ], !dbg !85
  %acc_o_1.sroa.26.1 = phi <4 x float> [ %acc_o_1.sroa.26.0, %if.end1507 ], [ %260, %for.cond1516.preheader ], !dbg !85
  %acc_o_1.sroa.14.1 = phi <4 x float> [ %acc_o_1.sroa.14.0, %if.end1507 ], [ %259, %for.cond1516.preheader ], !dbg !85
  %acc_o_1.sroa.0.1 = phi <4 x float> [ %acc_o_1.sroa.0.0, %if.end1507 ], [ %258, %for.cond1516.preheader ], !dbg !85
  br i1 %or.cond2480, label %if.end1631, label %for.cond1578.preheader, !dbg !307

for.cond1578.preheader:                           ; preds = %if.end1569
  %mul1583 = shl nsw i32 %0, 16
  %262 = shl nsw i32 %cond.i.i2330.6, 10
  %mul1585 = and i32 %262, 64512
  %mul1590 = shl nuw nsw i32 %18, 3
  %add1586 = or disjoint i32 %mul1590, %mul1583
  %add1588 = add nuw nsw i32 %add1586, %mul1585
  %263 = zext nneg i32 %add1588 to i64, !dbg !308
  %add.ptr1593 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %263, !dbg !309
  %V_reg.sroa.0.0.copyload2681 = load <4 x half>, ptr addrspace(4) %add.ptr1593, align 16, !dbg !310
  %V_reg.sroa.18.0.add.ptr1593.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1593, i64 8, !dbg !310
  %V_reg.sroa.18.0.copyload2688 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr1593.sroa_idx, align 8, !dbg !310
  %264 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %263, !dbg !309
  %add.ptr1593.1 = getelementptr inbounds i8, ptr addrspace(4) %264, i64 1024, !dbg !309
  %V_reg.sroa.26.16.copyload2709 = load <4 x half>, ptr addrspace(4) %add.ptr1593.1, align 16, !dbg !310
  %V_reg.sroa.42.16.add.ptr1593.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %264, i64 1032, !dbg !310
  %V_reg.sroa.42.16.copyload2716 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr1593.1.sroa_idx, align 8, !dbg !310
  %265 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload2681, <4 x half> %176, <4 x float> %acc_o_2.sroa.0.0), !dbg !311, !call_argsrelate !275
  %266 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload2688, <4 x half> %176, <4 x float> %acc_o_2.sroa.14.0), !dbg !311, !call_argsrelate !275
  %267 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload2709, <4 x half> %176, <4 x float> %acc_o_2.sroa.26.0), !dbg !311, !call_argsrelate !275
  %268 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload2716, <4 x half> %176, <4 x float> %acc_o_2.sroa.38.0), !dbg !311, !call_argsrelate !275
  br label %if.end1631, !dbg !312

if.end1631:                                       ; preds = %for.cond1578.preheader, %if.end1569
  %acc_o_2.sroa.38.1 = phi <4 x float> [ %acc_o_2.sroa.38.0, %if.end1569 ], [ %268, %for.cond1578.preheader ], !dbg !85
  %acc_o_2.sroa.26.1 = phi <4 x float> [ %acc_o_2.sroa.26.0, %if.end1569 ], [ %267, %for.cond1578.preheader ], !dbg !85
  %acc_o_2.sroa.14.1 = phi <4 x float> [ %acc_o_2.sroa.14.0, %if.end1569 ], [ %266, %for.cond1578.preheader ], !dbg !85
  %acc_o_2.sroa.0.1 = phi <4 x float> [ %acc_o_2.sroa.0.0, %if.end1569 ], [ %265, %for.cond1578.preheader ], !dbg !85
  br i1 %or.cond2482, label %if.end1631.if.end1693_crit_edge, label %for.cond1640.preheader, !dbg !312

if.end1631.if.end1693_crit_edge:                  ; preds = %if.end1631
  %.pre = shl nuw nsw i32 %18, 3
  br label %if.end1693, !dbg !312

for.cond1640.preheader:                           ; preds = %if.end1631
  %mul1645 = shl nsw i32 %0, 16
  %269 = shl nsw i32 %cond.i.i2330.7, 10
  %mul1647 = and i32 %269, 64512
  %mul1652 = shl nuw nsw i32 %18, 3
  %add1648 = or disjoint i32 %mul1652, %mul1645
  %add1650 = add nuw nsw i32 %add1648, %mul1647
  %270 = zext nneg i32 %add1650 to i64, !dbg !313
  %add.ptr1655 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %270, !dbg !314
  %V_reg.sroa.0.0.copyload2682 = load <4 x half>, ptr addrspace(4) %add.ptr1655, align 16, !dbg !315
  %V_reg.sroa.18.0.add.ptr1655.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1655, i64 8, !dbg !315
  %V_reg.sroa.18.0.copyload2689 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr1655.sroa_idx, align 8, !dbg !315
  %271 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %270, !dbg !314
  %add.ptr1655.1 = getelementptr inbounds i8, ptr addrspace(4) %271, i64 1024, !dbg !314
  %V_reg.sroa.26.16.copyload2710 = load <4 x half>, ptr addrspace(4) %add.ptr1655.1, align 16, !dbg !315
  %V_reg.sroa.42.16.add.ptr1655.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %271, i64 1032, !dbg !315
  %V_reg.sroa.42.16.copyload2717 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr1655.1.sroa_idx, align 8, !dbg !315
  %272 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload2682, <4 x half> %199, <4 x float> %acc_o_3.sroa.0.0), !dbg !316, !call_argsrelate !275
  %273 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload2689, <4 x half> %199, <4 x float> %acc_o_3.sroa.14.0), !dbg !316, !call_argsrelate !275
  %274 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload2710, <4 x half> %199, <4 x float> %acc_o_3.sroa.26.0), !dbg !316, !call_argsrelate !275
  %275 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload2717, <4 x half> %199, <4 x float> %acc_o_3.sroa.38.0), !dbg !316, !call_argsrelate !275
  br label %if.end1693, !dbg !317

if.end1693:                                       ; preds = %if.end1631.if.end1693_crit_edge, %for.cond1640.preheader
  %.pre-phi = phi i32 [ %.pre, %if.end1631.if.end1693_crit_edge ], [ %mul1652, %for.cond1640.preheader ]
  %acc_o_3.sroa.38.1 = phi <4 x float> [ %acc_o_3.sroa.38.0, %if.end1631.if.end1693_crit_edge ], [ %275, %for.cond1640.preheader ], !dbg !85
  %acc_o_3.sroa.26.1 = phi <4 x float> [ %acc_o_3.sroa.26.0, %if.end1631.if.end1693_crit_edge ], [ %274, %for.cond1640.preheader ], !dbg !85
  %acc_o_3.sroa.14.1 = phi <4 x float> [ %acc_o_3.sroa.14.0, %if.end1631.if.end1693_crit_edge ], [ %273, %for.cond1640.preheader ], !dbg !85
  %acc_o_3.sroa.0.1 = phi <4 x float> [ %acc_o_3.sroa.0.0, %if.end1631.if.end1693_crit_edge ], [ %272, %for.cond1640.preheader ], !dbg !85
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 0, !dbg !318
  %acc_o_1.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_1.sroa.0.1, i64 0, !dbg !319
  %add1702 = fadd contract float %acc_o.sroa.0.0.vec.extract, %acc_o_1.sroa.0.0.vec.extract, !dbg !320
  %acc_o_2.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_2.sroa.0.1, i64 0, !dbg !321
  %add1709 = fadd contract float %add1702, %acc_o_2.sroa.0.0.vec.extract, !dbg !322
  %acc_o_3.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_3.sroa.0.1, i64 0, !dbg !323
  %add1716 = fadd contract float %add1709, %acc_o_3.sroa.0.0.vec.extract, !dbg !324
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 1, !dbg !318
  %acc_o_1.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_1.sroa.0.1, i64 1, !dbg !319
  %add1702.1 = fadd contract float %acc_o.sroa.0.4.vec.extract, %acc_o_1.sroa.0.4.vec.extract, !dbg !320
  %acc_o_2.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_2.sroa.0.1, i64 1, !dbg !321
  %add1709.1 = fadd contract float %add1702.1, %acc_o_2.sroa.0.4.vec.extract, !dbg !322
  %acc_o_3.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_3.sroa.0.1, i64 1, !dbg !323
  %add1716.1 = fadd contract float %add1709.1, %acc_o_3.sroa.0.4.vec.extract, !dbg !324
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 2, !dbg !318
  %acc_o_1.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_1.sroa.0.1, i64 2, !dbg !319
  %add1702.2 = fadd contract float %acc_o.sroa.0.8.vec.extract, %acc_o_1.sroa.0.8.vec.extract, !dbg !320
  %acc_o_2.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_2.sroa.0.1, i64 2, !dbg !321
  %add1709.2 = fadd contract float %add1702.2, %acc_o_2.sroa.0.8.vec.extract, !dbg !322
  %acc_o_3.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_3.sroa.0.1, i64 2, !dbg !323
  %add1716.2 = fadd contract float %add1709.2, %acc_o_3.sroa.0.8.vec.extract, !dbg !324
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 3, !dbg !318
  %acc_o_1.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_1.sroa.0.1, i64 3, !dbg !319
  %add1702.3 = fadd contract float %acc_o.sroa.0.12.vec.extract, %acc_o_1.sroa.0.12.vec.extract, !dbg !320
  %acc_o_2.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_2.sroa.0.1, i64 3, !dbg !321
  %add1709.3 = fadd contract float %add1702.3, %acc_o_2.sroa.0.12.vec.extract, !dbg !322
  %acc_o_3.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_3.sroa.0.1, i64 3, !dbg !323
  %add1716.3 = fadd contract float %add1709.3, %acc_o_3.sroa.0.12.vec.extract, !dbg !324
  %acc_o.sroa.38.16.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1, i64 0, !dbg !318
  %acc_o_1.sroa.14.16.vec.extract = extractelement <4 x float> %acc_o_1.sroa.14.1, i64 0, !dbg !319
  %add1702.4 = fadd contract float %acc_o.sroa.38.16.vec.extract, %acc_o_1.sroa.14.16.vec.extract, !dbg !320
  %acc_o_2.sroa.14.16.vec.extract = extractelement <4 x float> %acc_o_2.sroa.14.1, i64 0, !dbg !321
  %add1709.4 = fadd contract float %add1702.4, %acc_o_2.sroa.14.16.vec.extract, !dbg !322
  %acc_o_3.sroa.14.16.vec.extract = extractelement <4 x float> %acc_o_3.sroa.14.1, i64 0, !dbg !323
  %add1716.4 = fadd contract float %add1709.4, %acc_o_3.sroa.14.16.vec.extract, !dbg !324
  %acc_o.sroa.38.20.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1, i64 1, !dbg !318
  %acc_o_1.sroa.14.20.vec.extract = extractelement <4 x float> %acc_o_1.sroa.14.1, i64 1, !dbg !319
  %add1702.5 = fadd contract float %acc_o.sroa.38.20.vec.extract, %acc_o_1.sroa.14.20.vec.extract, !dbg !320
  %acc_o_2.sroa.14.20.vec.extract = extractelement <4 x float> %acc_o_2.sroa.14.1, i64 1, !dbg !321
  %add1709.5 = fadd contract float %add1702.5, %acc_o_2.sroa.14.20.vec.extract, !dbg !322
  %acc_o_3.sroa.14.20.vec.extract = extractelement <4 x float> %acc_o_3.sroa.14.1, i64 1, !dbg !323
  %add1716.5 = fadd contract float %add1709.5, %acc_o_3.sroa.14.20.vec.extract, !dbg !324
  %acc_o.sroa.38.24.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1, i64 2, !dbg !318
  %acc_o_1.sroa.14.24.vec.extract = extractelement <4 x float> %acc_o_1.sroa.14.1, i64 2, !dbg !319
  %add1702.6 = fadd contract float %acc_o.sroa.38.24.vec.extract, %acc_o_1.sroa.14.24.vec.extract, !dbg !320
  %acc_o_2.sroa.14.24.vec.extract = extractelement <4 x float> %acc_o_2.sroa.14.1, i64 2, !dbg !321
  %add1709.6 = fadd contract float %add1702.6, %acc_o_2.sroa.14.24.vec.extract, !dbg !322
  %acc_o_3.sroa.14.24.vec.extract = extractelement <4 x float> %acc_o_3.sroa.14.1, i64 2, !dbg !323
  %add1716.6 = fadd contract float %add1709.6, %acc_o_3.sroa.14.24.vec.extract, !dbg !324
  %acc_o.sroa.38.28.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1, i64 3, !dbg !318
  %acc_o_1.sroa.14.28.vec.extract = extractelement <4 x float> %acc_o_1.sroa.14.1, i64 3, !dbg !319
  %add1702.7 = fadd contract float %acc_o.sroa.38.28.vec.extract, %acc_o_1.sroa.14.28.vec.extract, !dbg !320
  %acc_o_2.sroa.14.28.vec.extract = extractelement <4 x float> %acc_o_2.sroa.14.1, i64 3, !dbg !321
  %add1709.7 = fadd contract float %add1702.7, %acc_o_2.sroa.14.28.vec.extract, !dbg !322
  %acc_o_3.sroa.14.28.vec.extract = extractelement <4 x float> %acc_o_3.sroa.14.1, i64 3, !dbg !323
  %add1716.7 = fadd contract float %add1709.7, %acc_o_3.sroa.14.28.vec.extract, !dbg !324
  %acc_o.sroa.74.32.vec.extract = extractelement <4 x float> %acc_o.sroa.74.1, i64 0, !dbg !318
  %acc_o_1.sroa.26.32.vec.extract = extractelement <4 x float> %acc_o_1.sroa.26.1, i64 0, !dbg !319
  %add1702.8 = fadd contract float %acc_o.sroa.74.32.vec.extract, %acc_o_1.sroa.26.32.vec.extract, !dbg !320
  %acc_o_2.sroa.26.32.vec.extract = extractelement <4 x float> %acc_o_2.sroa.26.1, i64 0, !dbg !321
  %add1709.8 = fadd contract float %add1702.8, %acc_o_2.sroa.26.32.vec.extract, !dbg !322
  %acc_o_3.sroa.26.32.vec.extract = extractelement <4 x float> %acc_o_3.sroa.26.1, i64 0, !dbg !323
  %add1716.8 = fadd contract float %add1709.8, %acc_o_3.sroa.26.32.vec.extract, !dbg !324
  %acc_o.sroa.74.36.vec.extract = extractelement <4 x float> %acc_o.sroa.74.1, i64 1, !dbg !318
  %acc_o_1.sroa.26.36.vec.extract = extractelement <4 x float> %acc_o_1.sroa.26.1, i64 1, !dbg !319
  %add1702.9 = fadd contract float %acc_o.sroa.74.36.vec.extract, %acc_o_1.sroa.26.36.vec.extract, !dbg !320
  %acc_o_2.sroa.26.36.vec.extract = extractelement <4 x float> %acc_o_2.sroa.26.1, i64 1, !dbg !321
  %add1709.9 = fadd contract float %add1702.9, %acc_o_2.sroa.26.36.vec.extract, !dbg !322
  %acc_o_3.sroa.26.36.vec.extract = extractelement <4 x float> %acc_o_3.sroa.26.1, i64 1, !dbg !323
  %add1716.9 = fadd contract float %add1709.9, %acc_o_3.sroa.26.36.vec.extract, !dbg !324
  %acc_o.sroa.74.40.vec.extract = extractelement <4 x float> %acc_o.sroa.74.1, i64 2, !dbg !318
  %acc_o_1.sroa.26.40.vec.extract = extractelement <4 x float> %acc_o_1.sroa.26.1, i64 2, !dbg !319
  %add1702.10 = fadd contract float %acc_o.sroa.74.40.vec.extract, %acc_o_1.sroa.26.40.vec.extract, !dbg !320
  %acc_o_2.sroa.26.40.vec.extract = extractelement <4 x float> %acc_o_2.sroa.26.1, i64 2, !dbg !321
  %add1709.10 = fadd contract float %add1702.10, %acc_o_2.sroa.26.40.vec.extract, !dbg !322
  %acc_o_3.sroa.26.40.vec.extract = extractelement <4 x float> %acc_o_3.sroa.26.1, i64 2, !dbg !323
  %add1716.10 = fadd contract float %add1709.10, %acc_o_3.sroa.26.40.vec.extract, !dbg !324
  %acc_o.sroa.74.44.vec.extract = extractelement <4 x float> %acc_o.sroa.74.1, i64 3, !dbg !318
  %acc_o_1.sroa.26.44.vec.extract = extractelement <4 x float> %acc_o_1.sroa.26.1, i64 3, !dbg !319
  %add1702.11 = fadd contract float %acc_o.sroa.74.44.vec.extract, %acc_o_1.sroa.26.44.vec.extract, !dbg !320
  %acc_o_2.sroa.26.44.vec.extract = extractelement <4 x float> %acc_o_2.sroa.26.1, i64 3, !dbg !321
  %add1709.11 = fadd contract float %add1702.11, %acc_o_2.sroa.26.44.vec.extract, !dbg !322
  %acc_o_3.sroa.26.44.vec.extract = extractelement <4 x float> %acc_o_3.sroa.26.1, i64 3, !dbg !323
  %add1716.11 = fadd contract float %add1709.11, %acc_o_3.sroa.26.44.vec.extract, !dbg !324
  %acc_o.sroa.110.48.vec.extract = extractelement <4 x float> %acc_o.sroa.110.1, i64 0, !dbg !318
  %acc_o_1.sroa.38.48.vec.extract = extractelement <4 x float> %acc_o_1.sroa.38.1, i64 0, !dbg !319
  %add1702.12 = fadd contract float %acc_o.sroa.110.48.vec.extract, %acc_o_1.sroa.38.48.vec.extract, !dbg !320
  %acc_o_2.sroa.38.48.vec.extract = extractelement <4 x float> %acc_o_2.sroa.38.1, i64 0, !dbg !321
  %add1709.12 = fadd contract float %add1702.12, %acc_o_2.sroa.38.48.vec.extract, !dbg !322
  %acc_o_3.sroa.38.48.vec.extract = extractelement <4 x float> %acc_o_3.sroa.38.1, i64 0, !dbg !323
  %add1716.12 = fadd contract float %add1709.12, %acc_o_3.sroa.38.48.vec.extract, !dbg !324
  %acc_o.sroa.110.52.vec.extract = extractelement <4 x float> %acc_o.sroa.110.1, i64 1, !dbg !318
  %acc_o_1.sroa.38.52.vec.extract = extractelement <4 x float> %acc_o_1.sroa.38.1, i64 1, !dbg !319
  %add1702.13 = fadd contract float %acc_o.sroa.110.52.vec.extract, %acc_o_1.sroa.38.52.vec.extract, !dbg !320
  %acc_o_2.sroa.38.52.vec.extract = extractelement <4 x float> %acc_o_2.sroa.38.1, i64 1, !dbg !321
  %add1709.13 = fadd contract float %add1702.13, %acc_o_2.sroa.38.52.vec.extract, !dbg !322
  %acc_o_3.sroa.38.52.vec.extract = extractelement <4 x float> %acc_o_3.sroa.38.1, i64 1, !dbg !323
  %add1716.13 = fadd contract float %add1709.13, %acc_o_3.sroa.38.52.vec.extract, !dbg !324
  %acc_o.sroa.110.56.vec.extract = extractelement <4 x float> %acc_o.sroa.110.1, i64 2, !dbg !318
  %acc_o_1.sroa.38.56.vec.extract = extractelement <4 x float> %acc_o_1.sroa.38.1, i64 2, !dbg !319
  %add1702.14 = fadd contract float %acc_o.sroa.110.56.vec.extract, %acc_o_1.sroa.38.56.vec.extract, !dbg !320
  %acc_o_2.sroa.38.56.vec.extract = extractelement <4 x float> %acc_o_2.sroa.38.1, i64 2, !dbg !321
  %add1709.14 = fadd contract float %add1702.14, %acc_o_2.sroa.38.56.vec.extract, !dbg !322
  %acc_o_3.sroa.38.56.vec.extract = extractelement <4 x float> %acc_o_3.sroa.38.1, i64 2, !dbg !323
  %add1716.14 = fadd contract float %add1709.14, %acc_o_3.sroa.38.56.vec.extract, !dbg !324
  %acc_o.sroa.110.60.vec.extract = extractelement <4 x float> %acc_o.sroa.110.1, i64 3, !dbg !318
  %acc_o_1.sroa.38.60.vec.extract = extractelement <4 x float> %acc_o_1.sroa.38.1, i64 3, !dbg !319
  %add1702.15 = fadd contract float %acc_o.sroa.110.60.vec.extract, %acc_o_1.sroa.38.60.vec.extract, !dbg !320
  %acc_o_2.sroa.38.60.vec.extract = extractelement <4 x float> %acc_o_2.sroa.38.1, i64 3, !dbg !321
  %add1709.15 = fadd contract float %add1702.15, %acc_o_2.sroa.38.60.vec.extract, !dbg !322
  %acc_o_3.sroa.38.60.vec.extract = extractelement <4 x float> %acc_o_3.sroa.38.1, i64 3, !dbg !323
  %add1716.15 = fadd contract float %add1709.15, %acc_o_3.sroa.38.60.vec.extract, !dbg !324
  %add1730 = fadd contract float %sum_acc.sroa.0.7, 0.000000e+00, !dbg !325
  %add1730.1 = fadd contract float %add1730, %sum_acc.sroa.20.7, !dbg !325
  %add1730.2 = fadd contract float %add1730.1, %sum_acc.sroa.38.7, !dbg !325
  %add1730.3 = fadd contract float %add1730.2, %sum_acc.sroa.56.7, !dbg !325
  %276 = bitcast float %add1730.3 to i32, !dbg !326
  %277 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !338
  %278 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %277) #11, !dbg !343
  %xor.i.i = xor i32 %278, 32, !dbg !344
  %279 = and i32 %278, -64, !dbg !345
  %and.i.i = add nsw i32 %279, 64, !dbg !345
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !346
  %cond.i.i2331 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %278, !dbg !347
  %shl.i.i = shl i32 %cond.i.i2331, 2, !dbg !348
  %280 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %276), !dbg !349
  %281 = bitcast i32 %280 to float, !dbg !350
  %add.i = fadd contract float %add1730.3, %281, !dbg !351
  %282 = bitcast float %add.i to i32, !dbg !354
  %283 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !361
  %284 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %283) #11, !dbg !364
  %xor.i.i2332 = xor i32 %284, 16, !dbg !365
  %285 = and i32 %284, -64, !dbg !366
  %and.i.i2333 = add nsw i32 %285, 64, !dbg !366
  %cmp.not.i.i2334 = icmp slt i32 %xor.i.i2332, %and.i.i2333, !dbg !367
  %cond.i.i2335 = select i1 %cmp.not.i.i2334, i32 %xor.i.i2332, i32 %284, !dbg !368
  %shl.i.i2336 = shl i32 %cond.i.i2335, 2, !dbg !369
  %286 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i2336, i32 %282), !dbg !370
  %287 = bitcast i32 %286 to float, !dbg !371
  %add.i.i = fadd contract float %add.i, %287, !dbg !372
  %cmp1739 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !374
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !375
  %condval_8.0 = select i1 %cmp1739, float %div, float 0.000000e+00, !dbg !375
  %mul1752 = fmul contract float %condval_8.0, %add1716, !dbg !376
  %mul1752.1 = fmul contract float %condval_8.0, %add1716.1, !dbg !376
  %mul1752.2 = fmul contract float %condval_8.0, %add1716.2, !dbg !376
  %mul1752.3 = fmul contract float %condval_8.0, %add1716.3, !dbg !376
  %mul1752.4 = fmul contract float %condval_8.0, %add1716.4, !dbg !376
  %mul1752.5 = fmul contract float %condval_8.0, %add1716.5, !dbg !376
  %mul1752.6 = fmul contract float %condval_8.0, %add1716.6, !dbg !376
  %mul1752.7 = fmul contract float %condval_8.0, %add1716.7, !dbg !376
  %mul1752.8 = fmul contract float %condval_8.0, %add1716.8, !dbg !376
  %mul1752.9 = fmul contract float %condval_8.0, %add1716.9, !dbg !376
  %mul1752.10 = fmul contract float %condval_8.0, %add1716.10, !dbg !376
  %mul1752.11 = fmul contract float %condval_8.0, %add1716.11, !dbg !376
  %mul1752.12 = fmul contract float %condval_8.0, %add1716.12, !dbg !376
  %mul1752.13 = fmul contract float %condval_8.0, %add1716.13, !dbg !376
  %mul1752.14 = fmul contract float %condval_8.0, %add1716.14, !dbg !376
  %mul1752.15 = fmul contract float %condval_8.0, %add1716.15, !dbg !376
  %288 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1752), !dbg !377
  %O_reg.sroa.0.0.insert.ext = zext i16 %288 to i64, !dbg !381
  %289 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1752.1), !dbg !377
  %O_reg.sroa.0.2.insert.ext = zext i16 %289 to i64, !dbg !381
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !381
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !381
  %290 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1752.2), !dbg !377
  %O_reg.sroa.0.4.insert.ext = zext i16 %290 to i64, !dbg !381
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !381
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !381
  %291 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1752.3), !dbg !377
  %O_reg.sroa.0.6.insert.ext = zext i16 %291 to i64, !dbg !381
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !381
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !381
  %292 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1752.4), !dbg !377
  %O_reg.sroa.7.8.insert.ext = zext i16 %292 to i64, !dbg !381
  %293 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1752.5), !dbg !377
  %O_reg.sroa.7.10.insert.ext = zext i16 %293 to i64, !dbg !381
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !381
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !381
  %294 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1752.6), !dbg !377
  %O_reg.sroa.7.12.insert.ext = zext i16 %294 to i64, !dbg !381
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !381
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !381
  %295 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1752.7), !dbg !377
  %O_reg.sroa.7.14.insert.ext = zext i16 %295 to i64, !dbg !381
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !381
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !381
  %296 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1752.8), !dbg !377
  %O_reg.sroa.12.16.insert.ext = zext i16 %296 to i64, !dbg !381
  %297 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1752.9), !dbg !377
  %O_reg.sroa.12.18.insert.ext = zext i16 %297 to i64, !dbg !381
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !381
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !381
  %298 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1752.10), !dbg !377
  %O_reg.sroa.12.20.insert.ext = zext i16 %298 to i64, !dbg !381
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !381
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !381
  %299 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1752.11), !dbg !377
  %O_reg.sroa.12.22.insert.ext = zext i16 %299 to i64, !dbg !381
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !381
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !381
  %300 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1752.12), !dbg !377
  %O_reg.sroa.17.24.insert.ext = zext i16 %300 to i64, !dbg !381
  %301 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1752.13), !dbg !377
  %O_reg.sroa.17.26.insert.ext = zext i16 %301 to i64, !dbg !381
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !381
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !381
  %302 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1752.14), !dbg !377
  %O_reg.sroa.17.28.insert.ext = zext i16 %302 to i64, !dbg !381
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !381
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !381
  %303 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1752.15), !dbg !377
  %O_reg.sroa.17.30.insert.ext = zext i16 %303 to i64, !dbg !381
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !381
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !381
  %shr1794 = lshr i32 %18, 5
  %and1797 = and i32 %18, 7
  %304 = lshr i32 %18, 2
  %mul1803 = and i32 %304, 4
  %xor = xor i32 %shr1794, %and1797, !dbg !382
  %mul1798 = shl nuw nsw i32 %xor, 3, !dbg !383
  %add1799 = add nuw nsw i32 %mul1798, %mul25, !dbg !384
  %add1804 = or disjoint i32 %add1799, %mul1803, !dbg !385
  %add.ptr1806 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1804, !dbg !386
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr1806, align 8, !dbg !387
  %add1795.1 = add nuw nsw i32 %shr1794, 2, !dbg !388
  %xor.1 = xor i32 %add1795.1, %and1797, !dbg !382
  %mul1798.1 = shl nuw nsw i32 %xor.1, 3, !dbg !383
  %add1799.1 = add nuw nsw i32 %mul1798.1, %mul25, !dbg !384
  %add1804.1 = or disjoint i32 %add1799.1, %mul1803, !dbg !385
  %add.ptr1806.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1804.1, !dbg !386
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr1806.1, align 8, !dbg !387
  %add1795.2 = add nuw nsw i32 %shr1794, 4, !dbg !388
  %xor.2 = xor i32 %add1795.2, %and1797, !dbg !382
  %mul1798.2 = shl nuw nsw i32 %xor.2, 3, !dbg !383
  %add1799.2 = add nuw nsw i32 %mul1798.2, %mul25, !dbg !384
  %add1804.2 = or disjoint i32 %add1799.2, %mul1803, !dbg !385
  %add.ptr1806.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1804.2, !dbg !386
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr1806.2, align 8, !dbg !387
  %add1795.3 = add nuw nsw i32 %shr1794, 6, !dbg !388
  %xor.3 = xor i32 %add1795.3, %and1797, !dbg !382
  %mul1798.3 = shl nuw nsw i32 %xor.3, 3, !dbg !383
  %add1799.3 = add nuw nsw i32 %mul1798.3, %mul25, !dbg !384
  %add1804.3 = or disjoint i32 %add1799.3, %mul1803, !dbg !385
  %add.ptr1806.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1804.3, !dbg !386
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr1806.3, align 8, !dbg !387
  fence syncscope("warp") release, !dbg !389
  tail call void @llvm.mxc.barrier.warp(), !dbg !394
  fence syncscope("warp") acquire, !dbg !395
  %mul1817 = and i32 %.pre-phi, 8128
  %xor18232313 = and i32 %.pre-phi, 56
  %call1821.masked = and i32 %18, 1016
  %mul1824 = xor i32 %xor18232313, %call1821.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul1817, !dbg !396
  %invariant.gep2461 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul1824, !dbg !396
  %add1834 = add nuw nsw i32 %add23, %.pre-phi
  %305 = zext nneg i32 %add1834 to i64, !dbg !397
  %add.ptr1839 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %305, !dbg !398
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1839, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep2461, i64 16, i1 false), !dbg !399, !tbaa.struct !400, !call_argsrelate !401
  %gep2462.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep2461, i32 1024, !dbg !402
  %306 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %305, !dbg !398
  %add.ptr1839.1 = getelementptr inbounds i8, ptr addrspace(1) %306, i64 1024, !dbg !398
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1839.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep2462.1, i64 16, i1 false), !dbg !399, !tbaa.struct !400, !call_argsrelate !401
  ret void, !dbg !403
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
!1 = !DIFile(filename: "/tmp/tmpgw9reekh/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpgw9reekh/tvm_kernels.maca", directory: "")
!42 = !DILocation(line: 31, column: 3, scope: !40)
!43 = !DILocation(line: 32, column: 21, scope: !40)
!44 = !DILocation(line: 705, column: 10, scope: !45, inlinedAt: !47)
!45 = distinct !DISubprogram(name: "max", scope: !46, file: !46, line: 704, type: !7, scopeLine: 704, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!46 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!47 = distinct !DILocation(line: 33, column: 24, scope: !40)
!48 = !{i32 0, i32 -1}
!49 = !DILocation(line: 708, column: 10, scope: !50, inlinedAt: !51)
!50 = distinct !DISubprogram(name: "min", scope: !46, file: !46, line: 707, type: !7, scopeLine: 707, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!51 = distinct !DILocation(line: 33, column: 20, scope: !40)
!52 = !DILocation(line: 33, column: 48, scope: !40)
!53 = !DILocation(line: 32, column: 90, scope: !40)
!54 = !{i32 0, i32 1024}
!55 = !DILocation(line: 36, column: 3, scope: !40)
!56 = !DILocation(line: 37, column: 46, scope: !40)
!57 = !DILocation(line: 37, column: 32, scope: !40)
!58 = !DILocation(line: 43, column: 33, scope: !40)
!59 = !DILocation(line: 45, column: 5, scope: !40)
!60 = !DILocation(line: 46, column: 50, scope: !40)
!61 = !DILocation(line: 46, column: 36, scope: !40)
!62 = !DILocation(line: 49, column: 27, scope: !40)
!63 = !DILocation(line: 50, column: 33, scope: !40)
!64 = !DILocation(line: 52, column: 5, scope: !40)
!65 = !DILocation(line: 53, column: 51, scope: !40)
!66 = !DILocation(line: 53, column: 37, scope: !40)
!67 = !DILocation(line: 56, column: 27, scope: !40)
!68 = !DILocation(line: 57, column: 33, scope: !40)
!69 = !DILocation(line: 59, column: 5, scope: !40)
!70 = !DILocation(line: 60, column: 51, scope: !40)
!71 = !DILocation(line: 60, column: 37, scope: !40)
!72 = !DILocation(line: 63, column: 27, scope: !40)
!73 = !DILocation(line: 64, column: 33, scope: !40)
!74 = !DILocation(line: 66, column: 5, scope: !40)
!75 = !DILocation(line: 67, column: 51, scope: !40)
!76 = !DILocation(line: 67, column: 37, scope: !40)
!77 = !DILocation(line: 70, column: 33, scope: !40)
!78 = !DILocation(line: 70, column: 7, scope: !40)
!79 = !DILocation(line: 71, column: 48, scope: !40)
!80 = !DILocation(line: 71, column: 27, scope: !40)
!81 = !DILocation(line: 71, column: 9, scope: !40)
!82 = !DILocation(line: 75, column: 76, scope: !40)
!83 = !DILocation(line: 80, column: 20, scope: !40)
!84 = !DILocation(line: 75, column: 69, scope: !40)
!85 = !DILocation(line: 0, scope: !40)
!86 = !DILocation(line: 89, column: 36, scope: !40)
!87 = !{i32 -1, i32 3, i32 -1}
!88 = !DILocation(line: 97, column: 30, scope: !40)
!89 = !DILocation(line: 97, column: 41, scope: !40)
!90 = !DILocation(line: 354, column: 10, scope: !91, inlinedAt: !92)
!91 = distinct !DISubprogram(name: "min", scope: !46, file: !46, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!92 = distinct !DILocation(line: 97, column: 25, scope: !40)
!93 = !DILocation(line: 288, column: 10, scope: !94, inlinedAt: !95)
!94 = distinct !DISubprogram(name: "expf", scope: !46, file: !46, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!95 = distinct !DILocation(line: 97, column: 20, scope: !40)
!96 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !99)
!97 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !98, file: !98, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!98 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!99 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !102)
!100 = distinct !DISubprogram(name: "__float2half", scope: !101, file: !101, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!101 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!102 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !104)
!103 = distinct !DISubprogram(name: "__half", scope: !101, file: !101, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!104 = distinct !DILocation(line: 105, column: 36, scope: !40)
!105 = !DILocation(line: 108, column: 33, scope: !40)
!106 = !DILocation(line: 108, column: 7, scope: !40)
!107 = !DILocation(line: 109, column: 48, scope: !40)
!108 = !DILocation(line: 109, column: 27, scope: !40)
!109 = !DILocation(line: 109, column: 9, scope: !40)
!110 = !DILocation(line: 113, column: 76, scope: !40)
!111 = !DILocation(line: 118, column: 20, scope: !40)
!112 = !DILocation(line: 113, column: 69, scope: !40)
!113 = !DILocation(line: 127, column: 36, scope: !40)
!114 = !DILocation(line: 135, column: 30, scope: !40)
!115 = !DILocation(line: 135, column: 41, scope: !40)
!116 = !DILocation(line: 354, column: 10, scope: !91, inlinedAt: !117)
!117 = distinct !DILocation(line: 135, column: 25, scope: !40)
!118 = !DILocation(line: 288, column: 10, scope: !94, inlinedAt: !119)
!119 = distinct !DILocation(line: 135, column: 20, scope: !40)
!120 = !DILocation(line: 139, column: 38, scope: !40)
!121 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !122)
!122 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !123)
!123 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !124)
!124 = distinct !DILocation(line: 143, column: 44, scope: !40)
!125 = !DILocation(line: 146, column: 33, scope: !40)
!126 = !DILocation(line: 146, column: 7, scope: !40)
!127 = !DILocation(line: 147, column: 48, scope: !40)
!128 = !DILocation(line: 147, column: 27, scope: !40)
!129 = !DILocation(line: 147, column: 9, scope: !40)
!130 = !DILocation(line: 151, column: 77, scope: !40)
!131 = !DILocation(line: 156, column: 21, scope: !40)
!132 = !DILocation(line: 151, column: 69, scope: !40)
!133 = !DILocation(line: 165, column: 36, scope: !40)
!134 = !DILocation(line: 173, column: 31, scope: !40)
!135 = !DILocation(line: 173, column: 43, scope: !40)
!136 = !DILocation(line: 354, column: 10, scope: !91, inlinedAt: !137)
!137 = distinct !DILocation(line: 173, column: 26, scope: !40)
!138 = !DILocation(line: 288, column: 10, scope: !94, inlinedAt: !139)
!139 = distinct !DILocation(line: 173, column: 21, scope: !40)
!140 = !DILocation(line: 177, column: 38, scope: !40)
!141 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !142)
!142 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !143)
!143 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !144)
!144 = distinct !DILocation(line: 181, column: 44, scope: !40)
!145 = !DILocation(line: 184, column: 33, scope: !40)
!146 = !DILocation(line: 184, column: 7, scope: !40)
!147 = !DILocation(line: 185, column: 48, scope: !40)
!148 = !DILocation(line: 185, column: 27, scope: !40)
!149 = !DILocation(line: 185, column: 9, scope: !40)
!150 = !DILocation(line: 189, column: 77, scope: !40)
!151 = !DILocation(line: 194, column: 21, scope: !40)
!152 = !DILocation(line: 189, column: 69, scope: !40)
!153 = !DILocation(line: 203, column: 36, scope: !40)
!154 = !DILocation(line: 211, column: 31, scope: !40)
!155 = !DILocation(line: 211, column: 43, scope: !40)
!156 = !DILocation(line: 354, column: 10, scope: !91, inlinedAt: !157)
!157 = distinct !DILocation(line: 211, column: 26, scope: !40)
!158 = !DILocation(line: 288, column: 10, scope: !94, inlinedAt: !159)
!159 = distinct !DILocation(line: 211, column: 21, scope: !40)
!160 = !DILocation(line: 215, column: 38, scope: !40)
!161 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !162)
!162 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !163)
!163 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !164)
!164 = distinct !DILocation(line: 219, column: 45, scope: !40)
!165 = !DILocation(line: 222, column: 27, scope: !40)
!166 = !DILocation(line: 223, column: 33, scope: !40)
!167 = !DILocation(line: 225, column: 5, scope: !40)
!168 = !DILocation(line: 226, column: 51, scope: !40)
!169 = !DILocation(line: 226, column: 37, scope: !40)
!170 = !DILocation(line: 229, column: 27, scope: !40)
!171 = !DILocation(line: 230, column: 33, scope: !40)
!172 = !DILocation(line: 232, column: 5, scope: !40)
!173 = !DILocation(line: 233, column: 52, scope: !40)
!174 = !DILocation(line: 233, column: 38, scope: !40)
!175 = !DILocation(line: 236, column: 27, scope: !40)
!176 = !DILocation(line: 237, column: 33, scope: !40)
!177 = !DILocation(line: 239, column: 5, scope: !40)
!178 = !DILocation(line: 240, column: 52, scope: !40)
!179 = !DILocation(line: 240, column: 38, scope: !40)
!180 = !DILocation(line: 243, column: 27, scope: !40)
!181 = !DILocation(line: 244, column: 33, scope: !40)
!182 = !DILocation(line: 246, column: 5, scope: !40)
!183 = !DILocation(line: 247, column: 52, scope: !40)
!184 = !DILocation(line: 247, column: 38, scope: !40)
!185 = !DILocation(line: 250, column: 33, scope: !40)
!186 = !DILocation(line: 250, column: 7, scope: !40)
!187 = !DILocation(line: 251, column: 48, scope: !40)
!188 = !DILocation(line: 251, column: 27, scope: !40)
!189 = !DILocation(line: 251, column: 9, scope: !40)
!190 = !DILocation(line: 255, column: 77, scope: !40)
!191 = !DILocation(line: 260, column: 21, scope: !40)
!192 = !DILocation(line: 255, column: 69, scope: !40)
!193 = !DILocation(line: 269, column: 36, scope: !40)
!194 = !DILocation(line: 277, column: 31, scope: !40)
!195 = !DILocation(line: 277, column: 43, scope: !40)
!196 = !DILocation(line: 354, column: 10, scope: !91, inlinedAt: !197)
!197 = distinct !DILocation(line: 277, column: 26, scope: !40)
!198 = !DILocation(line: 288, column: 10, scope: !94, inlinedAt: !199)
!199 = distinct !DILocation(line: 277, column: 21, scope: !40)
!200 = !DILocation(line: 281, column: 38, scope: !40)
!201 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !202)
!202 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !203)
!203 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !204)
!204 = distinct !DILocation(line: 285, column: 45, scope: !40)
!205 = !DILocation(line: 288, column: 33, scope: !40)
!206 = !DILocation(line: 288, column: 7, scope: !40)
!207 = !DILocation(line: 289, column: 48, scope: !40)
!208 = !DILocation(line: 289, column: 27, scope: !40)
!209 = !DILocation(line: 289, column: 9, scope: !40)
!210 = !DILocation(line: 293, column: 77, scope: !40)
!211 = !DILocation(line: 298, column: 21, scope: !40)
!212 = !DILocation(line: 293, column: 69, scope: !40)
!213 = !DILocation(line: 307, column: 36, scope: !40)
!214 = !DILocation(line: 315, column: 31, scope: !40)
!215 = !DILocation(line: 315, column: 43, scope: !40)
!216 = !DILocation(line: 354, column: 10, scope: !91, inlinedAt: !217)
!217 = distinct !DILocation(line: 315, column: 26, scope: !40)
!218 = !DILocation(line: 288, column: 10, scope: !94, inlinedAt: !219)
!219 = distinct !DILocation(line: 315, column: 21, scope: !40)
!220 = !DILocation(line: 319, column: 38, scope: !40)
!221 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !222)
!222 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !223)
!223 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !224)
!224 = distinct !DILocation(line: 323, column: 45, scope: !40)
!225 = !DILocation(line: 520, column: 33, scope: !40)
!226 = !DILocation(line: 326, column: 33, scope: !40)
!227 = !DILocation(line: 326, column: 7, scope: !40)
!228 = !DILocation(line: 327, column: 48, scope: !40)
!229 = !DILocation(line: 327, column: 27, scope: !40)
!230 = !DILocation(line: 327, column: 9, scope: !40)
!231 = !DILocation(line: 331, column: 77, scope: !40)
!232 = !DILocation(line: 336, column: 21, scope: !40)
!233 = !DILocation(line: 331, column: 69, scope: !40)
!234 = !DILocation(line: 345, column: 36, scope: !40)
!235 = !DILocation(line: 353, column: 31, scope: !40)
!236 = !DILocation(line: 353, column: 43, scope: !40)
!237 = !DILocation(line: 354, column: 10, scope: !91, inlinedAt: !238)
!238 = distinct !DILocation(line: 353, column: 26, scope: !40)
!239 = !DILocation(line: 288, column: 10, scope: !94, inlinedAt: !240)
!240 = distinct !DILocation(line: 353, column: 21, scope: !40)
!241 = !DILocation(line: 357, column: 38, scope: !40)
!242 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !243)
!243 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !244)
!244 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !245)
!245 = distinct !DILocation(line: 361, column: 45, scope: !40)
!246 = !DILocation(line: 538, column: 33, scope: !40)
!247 = !DILocation(line: 364, column: 33, scope: !40)
!248 = !DILocation(line: 364, column: 7, scope: !40)
!249 = !DILocation(line: 365, column: 48, scope: !40)
!250 = !DILocation(line: 365, column: 27, scope: !40)
!251 = !DILocation(line: 365, column: 9, scope: !40)
!252 = !DILocation(line: 369, column: 77, scope: !40)
!253 = !DILocation(line: 374, column: 21, scope: !40)
!254 = !DILocation(line: 369, column: 69, scope: !40)
!255 = !DILocation(line: 383, column: 36, scope: !40)
!256 = !DILocation(line: 391, column: 31, scope: !40)
!257 = !DILocation(line: 391, column: 43, scope: !40)
!258 = !DILocation(line: 354, column: 10, scope: !91, inlinedAt: !259)
!259 = distinct !DILocation(line: 391, column: 26, scope: !40)
!260 = !DILocation(line: 288, column: 10, scope: !94, inlinedAt: !261)
!261 = distinct !DILocation(line: 391, column: 21, scope: !40)
!262 = !DILocation(line: 395, column: 38, scope: !40)
!263 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !264)
!264 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !265)
!265 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !266)
!266 = distinct !DILocation(line: 399, column: 45, scope: !40)
!267 = !DILocation(line: 556, column: 33, scope: !40)
!268 = !DILocation(line: 403, column: 3, scope: !40)
!269 = !DILocation(line: 423, column: 33, scope: !40)
!270 = !DILocation(line: 425, column: 5, scope: !40)
!271 = !DILocation(line: 426, column: 51, scope: !40)
!272 = !DILocation(line: 426, column: 37, scope: !40)
!273 = !DILocation(line: 430, column: 32, scope: !40)
!274 = !DILocation(line: 434, column: 36, scope: !40)
!275 = !{i32 4, i32 -1, i32 -1}
!276 = !DILocation(line: 441, column: 33, scope: !40)
!277 = !DILocation(line: 443, column: 5, scope: !40)
!278 = !DILocation(line: 444, column: 51, scope: !40)
!279 = !DILocation(line: 444, column: 37, scope: !40)
!280 = !DILocation(line: 448, column: 32, scope: !40)
!281 = !DILocation(line: 452, column: 40, scope: !40)
!282 = !DILocation(line: 458, column: 27, scope: !40)
!283 = !DILocation(line: 459, column: 33, scope: !40)
!284 = !DILocation(line: 461, column: 5, scope: !40)
!285 = !DILocation(line: 462, column: 51, scope: !40)
!286 = !DILocation(line: 462, column: 37, scope: !40)
!287 = !DILocation(line: 466, column: 33, scope: !40)
!288 = !DILocation(line: 470, column: 40, scope: !40)
!289 = !DILocation(line: 476, column: 27, scope: !40)
!290 = !DILocation(line: 477, column: 33, scope: !40)
!291 = !DILocation(line: 479, column: 5, scope: !40)
!292 = !DILocation(line: 480, column: 51, scope: !40)
!293 = !DILocation(line: 480, column: 37, scope: !40)
!294 = !DILocation(line: 484, column: 33, scope: !40)
!295 = !DILocation(line: 488, column: 40, scope: !40)
!296 = !DILocation(line: 495, column: 33, scope: !40)
!297 = !DILocation(line: 497, column: 5, scope: !40)
!298 = !DILocation(line: 498, column: 51, scope: !40)
!299 = !DILocation(line: 498, column: 37, scope: !40)
!300 = !DILocation(line: 502, column: 33, scope: !40)
!301 = !DILocation(line: 506, column: 38, scope: !40)
!302 = !DILocation(line: 513, column: 33, scope: !40)
!303 = !DILocation(line: 515, column: 5, scope: !40)
!304 = !DILocation(line: 516, column: 51, scope: !40)
!305 = !DILocation(line: 516, column: 37, scope: !40)
!306 = !DILocation(line: 524, column: 40, scope: !40)
!307 = !DILocation(line: 531, column: 33, scope: !40)
!308 = !DILocation(line: 533, column: 5, scope: !40)
!309 = !DILocation(line: 534, column: 51, scope: !40)
!310 = !DILocation(line: 534, column: 37, scope: !40)
!311 = !DILocation(line: 542, column: 40, scope: !40)
!312 = !DILocation(line: 549, column: 33, scope: !40)
!313 = !DILocation(line: 551, column: 5, scope: !40)
!314 = !DILocation(line: 552, column: 51, scope: !40)
!315 = !DILocation(line: 552, column: 37, scope: !40)
!316 = !DILocation(line: 560, column: 40, scope: !40)
!317 = !DILocation(line: 567, column: 3, scope: !40)
!318 = !DILocation(line: 568, column: 20, scope: !40)
!319 = !DILocation(line: 568, column: 34, scope: !40)
!320 = !DILocation(line: 568, column: 32, scope: !40)
!321 = !DILocation(line: 569, column: 34, scope: !40)
!322 = !DILocation(line: 569, column: 32, scope: !40)
!323 = !DILocation(line: 570, column: 34, scope: !40)
!324 = !DILocation(line: 570, column: 32, scope: !40)
!325 = !DILocation(line: 575, column: 36, scope: !40)
!326 = !DILocation(line: 1018, column: 9, scope: !327, inlinedAt: !329)
!327 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !328, file: !328, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!328 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!329 = distinct !DILocation(line: 396, column: 10, scope: !330, inlinedAt: !332)
!330 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !331, file: !331, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!331 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!332 = distinct !DILocation(line: 129, column: 24, scope: !333, inlinedAt: !335)
!333 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !334, file: !334, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!334 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!335 = distinct !DILocation(line: 101, column: 14, scope: !336, inlinedAt: !337)
!336 = distinct !DISubprogram(name: "run<float>", scope: !334, file: !334, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!337 = distinct !DILocation(line: 577, column: 19, scope: !40)
!338 = !DILocation(line: 171, column: 37, scope: !339, inlinedAt: !340)
!339 = distinct !DISubprogram(name: "__lane_id", scope: !328, file: !328, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!340 = distinct !DILocation(line: 990, column: 14, scope: !341, inlinedAt: !342)
!341 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !328, file: !328, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!342 = distinct !DILocation(line: 1019, column: 11, scope: !327, inlinedAt: !329)
!343 = !DILocation(line: 171, column: 10, scope: !339, inlinedAt: !340)
!344 = !DILocation(line: 991, column: 20, scope: !341, inlinedAt: !342)
!345 = !DILocation(line: 992, column: 36, scope: !341, inlinedAt: !342)
!346 = !DILocation(line: 992, column: 17, scope: !341, inlinedAt: !342)
!347 = !DILocation(line: 992, column: 11, scope: !341, inlinedAt: !342)
!348 = !DILocation(line: 993, column: 43, scope: !341, inlinedAt: !342)
!349 = !DILocation(line: 993, column: 10, scope: !341, inlinedAt: !342)
!350 = !DILocation(line: 1020, column: 14, scope: !327, inlinedAt: !329)
!351 = !DILocation(line: 25, column: 14, scope: !352, inlinedAt: !353)
!352 = distinct !DISubprogram(name: "operator()<float>", scope: !334, file: !334, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!353 = distinct !DILocation(line: 129, column: 11, scope: !333, inlinedAt: !335)
!354 = !DILocation(line: 1018, column: 9, scope: !327, inlinedAt: !355)
!355 = distinct !DILocation(line: 396, column: 10, scope: !330, inlinedAt: !356)
!356 = distinct !DILocation(line: 129, column: 24, scope: !357, inlinedAt: !358)
!357 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !334, file: !334, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!358 = distinct !DILocation(line: 101, column: 14, scope: !359, inlinedAt: !360)
!359 = distinct !DISubprogram(name: "run<float>", scope: !334, file: !334, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!360 = distinct !DILocation(line: 134, column: 14, scope: !333, inlinedAt: !335)
!361 = !DILocation(line: 171, column: 37, scope: !339, inlinedAt: !362)
!362 = distinct !DILocation(line: 990, column: 14, scope: !341, inlinedAt: !363)
!363 = distinct !DILocation(line: 1019, column: 11, scope: !327, inlinedAt: !355)
!364 = !DILocation(line: 171, column: 10, scope: !339, inlinedAt: !362)
!365 = !DILocation(line: 991, column: 20, scope: !341, inlinedAt: !363)
!366 = !DILocation(line: 992, column: 36, scope: !341, inlinedAt: !363)
!367 = !DILocation(line: 992, column: 17, scope: !341, inlinedAt: !363)
!368 = !DILocation(line: 992, column: 11, scope: !341, inlinedAt: !363)
!369 = !DILocation(line: 993, column: 43, scope: !341, inlinedAt: !363)
!370 = !DILocation(line: 993, column: 10, scope: !341, inlinedAt: !363)
!371 = !DILocation(line: 1020, column: 14, scope: !327, inlinedAt: !355)
!372 = !DILocation(line: 25, column: 14, scope: !352, inlinedAt: !373)
!373 = distinct !DILocation(line: 129, column: 11, scope: !357, inlinedAt: !358)
!374 = !DILocation(line: 579, column: 32, scope: !40)
!375 = !DILocation(line: 579, column: 7, scope: !40)
!376 = !DILocation(line: 587, column: 32, scope: !40)
!377 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !378)
!378 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !379)
!379 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !380)
!380 = distinct !DILocation(line: 593, column: 48, scope: !40)
!381 = !DILocation(line: 593, column: 45, scope: !40)
!382 = !DILocation(line: 598, column: 122, scope: !40)
!383 = !DILocation(line: 598, column: 150, scope: !40)
!384 = !DILocation(line: 598, column: 77, scope: !40)
!385 = !DILocation(line: 598, column: 156, scope: !40)
!386 = !DILocation(line: 598, column: 40, scope: !40)
!387 = !DILocation(line: 598, column: 199, scope: !40)
!388 = !DILocation(line: 598, column: 93, scope: !40)
!389 = !DILocation(line: 68, column: 3, scope: !390, inlinedAt: !391)
!390 = distinct !DISubprogram(name: "__barrier_warp", scope: !328, file: !328, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!391 = distinct !DILocation(line: 192, column: 3, scope: !392, inlinedAt: !393)
!392 = distinct !DISubprogram(name: "__syncwarp", scope: !328, file: !328, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!393 = distinct !DILocation(line: 600, column: 3, scope: !40)
!394 = !DILocation(line: 69, column: 3, scope: !390, inlinedAt: !391)
!395 = !DILocation(line: 70, column: 3, scope: !390, inlinedAt: !391)
!396 = !DILocation(line: 602, column: 8, scope: !40)
!397 = !DILocation(line: 602, column: 3, scope: !40)
!398 = !DILocation(line: 603, column: 22, scope: !40)
!399 = !DILocation(line: 603, column: 132, scope: !40)
!400 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!401 = !{i32 2, i32 -1, i32 -1, i32 -1}
!402 = !DILocation(line: 603, column: 169, scope: !40)
!403 = !DILocation(line: 605, column: 1, scope: !40)
