; ModuleID = 'experiments/20261016_s8_phases/phase_binary/oj12_m5_p1.bc'
source_filename = "/tmp/tmp0bs752wz/tvm_kernels.maca"
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
  %cond.i.i2416 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64), !dbg !49
  %mul11 = shl nsw i32 %cond.i.i2416, 4, !dbg !52
  %4 = or disjoint i64 %2, 1, !dbg !53
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4, !dbg !43
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !dbg !43, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2416.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64), !dbg !49
  %mul11.1 = shl nsw i32 %cond.i.i2416.1, 4, !dbg !52
  %6 = or disjoint i64 %2, 2, !dbg !53
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6, !dbg !43
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !dbg !43, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2416.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64), !dbg !49
  %mul11.2 = shl nsw i32 %cond.i.i2416.2, 4, !dbg !52
  %8 = or disjoint i64 %2, 3, !dbg !53
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8, !dbg !43
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !dbg !43, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2416.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64), !dbg !49
  %mul11.3 = shl nsw i32 %cond.i.i2416.3, 4, !dbg !52
  %10 = or disjoint i64 %2, 4, !dbg !53
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10, !dbg !43
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !dbg !43, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2416.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64), !dbg !49
  %mul11.4 = shl nsw i32 %cond.i.i2416.4, 4, !dbg !52
  %12 = or disjoint i64 %2, 5, !dbg !53
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12, !dbg !43
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !dbg !43, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2416.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64), !dbg !49
  %mul11.5 = shl nsw i32 %cond.i.i2416.5, 4, !dbg !52
  %14 = or disjoint i64 %2, 6, !dbg !53
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14, !dbg !43
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !dbg !43, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2416.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64), !dbg !49
  %mul11.6 = shl nsw i32 %cond.i.i2416.6, 4, !dbg !52
  %16 = or disjoint i64 %2, 7, !dbg !53
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16, !dbg !43
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !dbg !43, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i2416.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64), !dbg !49
  %mul11.7 = shl nsw i32 %cond.i.i2416.7, 4, !dbg !52
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
  %or.cond2562 = or i1 %or.cond, %cmp47.not, !dbg !58
  br i1 %or.cond2562, label %if.end, label %for.cond48.preheader, !dbg !58

for.cond48.preheader:                             ; preds = %entry
  %mul54 = shl nsw i32 %0, 16
  %22 = shl nsw i32 %cond.i.i2416, 10
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
  %or.cond2563 = icmp ugt i32 %mul11.1, 1023, !dbg !63
  %cmp78.not = icmp sgt i32 %mul11.1, %1
  %or.cond2564 = or i1 %or.cond2563, %cmp78.not, !dbg !63
  br i1 %or.cond2564, label %if.end104, label %for.cond80.preheader, !dbg !63

for.cond80.preheader:                             ; preds = %if.end
  %mul86 = shl nsw i32 %0, 16
  %25 = shl nsw i32 %cond.i.i2416.1, 10
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
  %or.cond2565 = icmp ult i32 %mul11, 1024, !dbg !67
  br i1 %or.cond2565, label %land.lhs.true108, label %if.end213, !dbg !67

land.lhs.true108:                                 ; preds = %if.end104
  br i1 %cmp47.not, label %if.end213, label %if.then111, !dbg !68

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
  %acc_s.sroa.0.0.vec.insert3046 = insertelement <4 x float> poison, float %fneg., i64 0, !dbg !73
  %cmp127.not.1.not = icmp slt i32 %add124, %1, !dbg !72
  %fneg..1 = select i1 %cmp127.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3139 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3046, float %fneg..1, i64 1, !dbg !73
  %add125.2 = or disjoint i32 %add124, 2, !dbg !74
  %cmp127.not.2 = icmp sgt i32 %add125.2, %1, !dbg !72
  %fneg..2 = select i1 %cmp127.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3232 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3139, float %fneg..2, i64 2, !dbg !73
  %add125.3 = or disjoint i32 %add124, 3, !dbg !74
  %cmp127.not.3 = icmp sgt i32 %add125.3, %1, !dbg !72
  %fneg..3 = select i1 %cmp127.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3325 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3232, float %fneg..3, i64 3, !dbg !73
  br label %if.end140

if.end140:                                        ; preds = %if.then111, %for.cond116.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3325, %for.cond116.preheader ], [ zeroinitializer, %if.then111 ], !dbg !75
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
  %arrayidx209.idx = shl nuw nsw i32 %18, 3, !dbg !95
  %arrayidx209 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %arrayidx209.idx, !dbg !95
  store i16 %41, ptr addrspace(3) %arrayidx209, align 8, !dbg !96, !tbaa !97
  %42 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %36), !dbg !86
  %arrayidx209.1 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2), i32 %arrayidx209.idx, !dbg !95
  store i16 %42, ptr addrspace(3) %arrayidx209.1, align 2, !dbg !96, !tbaa !97
  %43 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %38), !dbg !86
  %arrayidx209.2 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4), i32 %arrayidx209.idx, !dbg !95
  store i16 %43, ptr addrspace(3) %arrayidx209.2, align 4, !dbg !96, !tbaa !97
  %44 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %40), !dbg !86
  %arrayidx209.3 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 6), i32 %arrayidx209.idx, !dbg !95
  store i16 %44, ptr addrspace(3) %arrayidx209.3, align 2, !dbg !96, !tbaa !97
  br label %if.end213, !dbg !98

if.end213:                                        ; preds = %if.end140, %land.lhs.true108, %if.end104
  %sum_acc.sroa.56.0 = phi float [ 0.000000e+00, %land.lhs.true108 ], [ %40, %if.end140 ], [ 0.000000e+00, %if.end104 ], !dbg !75
  %sum_acc.sroa.38.0 = phi float [ 0.000000e+00, %land.lhs.true108 ], [ %38, %if.end140 ], [ 0.000000e+00, %if.end104 ], !dbg !75
  %sum_acc.sroa.20.0 = phi float [ 0.000000e+00, %land.lhs.true108 ], [ %36, %if.end140 ], [ 0.000000e+00, %if.end104 ], !dbg !75
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %land.lhs.true108 ], [ %34, %if.end140 ], [ 0.000000e+00, %if.end104 ], !dbg !75
  %or.cond2566 = icmp ult i32 %mul11.1, 1024, !dbg !98
  br i1 %or.cond2566, label %land.lhs.true217, label %if.end322, !dbg !98

land.lhs.true217:                                 ; preds = %if.end213
  br i1 %cmp78.not, label %if.end322, label %if.then220, !dbg !99

if.then220:                                       ; preds = %land.lhs.true217
  %add222 = or disjoint i32 %mul11.1, 15, !dbg !100
  %cmp223 = icmp ult i32 %1, %add222, !dbg !101
  br i1 %cmp223, label %for.cond225.preheader, label %if.end249, !dbg !102

for.cond225.preheader:                            ; preds = %if.then220
  %45 = lshr i32 %18, 2
  %mul231 = and i32 %45, 252
  %add232 = add nuw nsw i32 %mul11.1, %mul231
  %cmp235.not = icmp sgt i32 %add232, %1, !dbg !103
  %fneg.2401 = select i1 %cmp235.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3055 = insertelement <4 x float> poison, float %fneg.2401, i64 0, !dbg !104
  %cmp235.not.1.not = icmp slt i32 %add232, %1, !dbg !103
  %fneg.2401.1 = select i1 %cmp235.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3148 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3055, float %fneg.2401.1, i64 1, !dbg !104
  %add233.2 = or disjoint i32 %add232, 2, !dbg !105
  %cmp235.not.2 = icmp sgt i32 %add233.2, %1, !dbg !103
  %fneg.2401.2 = select i1 %cmp235.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3241 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3148, float %fneg.2401.2, i64 2, !dbg !104
  %add233.3 = or disjoint i32 %add232, 3, !dbg !105
  %cmp235.not.3 = icmp sgt i32 %add233.3, %1, !dbg !103
  %fneg.2401.3 = select i1 %cmp235.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3334 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3241, float %fneg.2401.3, i64 3, !dbg !104
  br label %if.end249

if.end249:                                        ; preds = %if.then220, %for.cond225.preheader
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3334, %for.cond225.preheader ], [ zeroinitializer, %if.then220 ], !dbg !75
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.2), !dbg !106, !call_argsrelate !77
  %47 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.10.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %46), !dbg !106, !call_argsrelate !77
  %48 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.14.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %47), !dbg !106, !call_argsrelate !77
  %49 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.22.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %48), !dbg !106, !call_argsrelate !77
  %acc_s.sroa.0.0.vec.extract3057 = extractelement <4 x float> %49, i64 0, !dbg !107
  %mul284 = fmul contract float %acc_s.sroa.0.0.vec.extract3057, 0x3FB99999A0000000, !dbg !108
  %50 = tail call contract noundef float @llvm.minnum.f32(float %mul284, float 0x4024CB5EC0000000), !dbg !109
  %51 = tail call contract noundef float @llvm.exp.f32(float %50), !dbg !111
  %acc_s.sroa.0.4.vec.extract3150 = extractelement <4 x float> %49, i64 1, !dbg !107
  %mul284.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3150, 0x3FB99999A0000000, !dbg !108
  %52 = tail call contract noundef float @llvm.minnum.f32(float %mul284.1, float 0x4024CB5EC0000000), !dbg !109
  %53 = tail call contract noundef float @llvm.exp.f32(float %52), !dbg !111
  %acc_s.sroa.0.8.vec.extract3243 = extractelement <4 x float> %49, i64 2, !dbg !107
  %mul284.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3243, 0x3FB99999A0000000, !dbg !108
  %54 = tail call contract noundef float @llvm.minnum.f32(float %mul284.2, float 0x4024CB5EC0000000), !dbg !109
  %55 = tail call contract noundef float @llvm.exp.f32(float %54), !dbg !111
  %acc_s.sroa.0.12.vec.extract3336 = extractelement <4 x float> %49, i64 3, !dbg !107
  %mul284.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3336, 0x3FB99999A0000000, !dbg !108
  %56 = tail call contract noundef float @llvm.minnum.f32(float %mul284.3, float 0x4024CB5EC0000000), !dbg !109
  %57 = tail call contract noundef float @llvm.exp.f32(float %56), !dbg !111
  %add300 = fadd contract float %sum_acc.sroa.0.0, %51, !dbg !113
  %add300.1 = fadd contract float %sum_acc.sroa.20.0, %53, !dbg !113
  %add300.2 = fadd contract float %sum_acc.sroa.38.0, %55, !dbg !113
  %add300.3 = fadd contract float %sum_acc.sroa.56.0, %57, !dbg !113
  %58 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %51), !dbg !114
  %gep.idx = shl nuw nsw i32 %18, 3, !dbg !118
  %gep = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 512), i32 %gep.idx, !dbg !118
  store i16 %58, ptr addrspace(3) %gep, align 8, !dbg !119, !tbaa !97
  %59 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %53), !dbg !114
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 514), i32 %gep.idx, !dbg !118
  store i16 %59, ptr addrspace(3) %gep.1, align 2, !dbg !119, !tbaa !97
  %60 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %55), !dbg !114
  %gep.2 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 516), i32 %gep.idx, !dbg !118
  store i16 %60, ptr addrspace(3) %gep.2, align 4, !dbg !119, !tbaa !97
  %61 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %57), !dbg !114
  %gep.3 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 518), i32 %gep.idx, !dbg !118
  store i16 %61, ptr addrspace(3) %gep.3, align 2, !dbg !119, !tbaa !97
  br label %if.end322, !dbg !120

if.end322:                                        ; preds = %if.end249, %land.lhs.true217, %if.end213
  %sum_acc.sroa.56.1 = phi float [ %sum_acc.sroa.56.0, %land.lhs.true217 ], [ %add300.3, %if.end249 ], [ %sum_acc.sroa.56.0, %if.end213 ], !dbg !75
  %sum_acc.sroa.38.1 = phi float [ %sum_acc.sroa.38.0, %land.lhs.true217 ], [ %add300.2, %if.end249 ], [ %sum_acc.sroa.38.0, %if.end213 ], !dbg !75
  %sum_acc.sroa.20.1 = phi float [ %sum_acc.sroa.20.0, %land.lhs.true217 ], [ %add300.1, %if.end249 ], [ %sum_acc.sroa.20.0, %if.end213 ], !dbg !75
  %sum_acc.sroa.0.1 = phi float [ %sum_acc.sroa.0.0, %land.lhs.true217 ], [ %add300, %if.end249 ], [ %sum_acc.sroa.0.0, %if.end213 ], !dbg !75
  %or.cond2567 = icmp ugt i32 %mul11.2, 1023, !dbg !121
  %cmp329.not = icmp sgt i32 %mul11.2, %1
  %or.cond2568 = or i1 %or.cond2567, %cmp329.not, !dbg !121
  br i1 %or.cond2568, label %if.end354, label %for.cond331.preheader, !dbg !121

for.cond331.preheader:                            ; preds = %if.end322
  %mul336 = shl nsw i32 %0, 16
  %62 = shl nsw i32 %cond.i.i2416.2, 10
  %mul338 = and i32 %62, 64512
  %mul343 = shl nuw nsw i32 %18, 3
  %add339 = or disjoint i32 %mul343, %mul336
  %add341 = add nuw nsw i32 %add339, %mul338
  %63 = zext nneg i32 %add341 to i64, !dbg !122
  %add.ptr346 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %63, !dbg !123
  %K_reg.sroa.0.0.copyload3430 = load <4 x half>, ptr addrspace(4) %add.ptr346, align 16, !dbg !124
  %K_reg.sroa.10.0.add.ptr346.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr346, i64 8, !dbg !124
  %K_reg.sroa.10.0.copyload3433 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.10.0.add.ptr346.sroa_idx, align 8, !dbg !124
  %64 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %63, !dbg !123
  %add.ptr346.1 = getelementptr inbounds i8, ptr addrspace(4) %64, i64 1024, !dbg !123
  %K_reg.sroa.14.16.copyload3442 = load <4 x half>, ptr addrspace(4) %add.ptr346.1, align 16, !dbg !124
  %K_reg.sroa.22.16.add.ptr346.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %64, i64 1032, !dbg !124
  %K_reg.sroa.22.16.copyload3445 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.22.16.add.ptr346.1.sroa_idx, align 8, !dbg !124
  br label %if.end354, !dbg !125

if.end354:                                        ; preds = %for.cond331.preheader, %if.end322
  %K_reg.sroa.22.1 = phi <4 x half> [ %K_reg.sroa.22.0, %if.end322 ], [ %K_reg.sroa.22.16.copyload3445, %for.cond331.preheader ]
  %K_reg.sroa.14.1 = phi <4 x half> [ %K_reg.sroa.14.0, %if.end322 ], [ %K_reg.sroa.14.16.copyload3442, %for.cond331.preheader ]
  %K_reg.sroa.10.1 = phi <4 x half> [ %K_reg.sroa.10.0, %if.end322 ], [ %K_reg.sroa.10.0.copyload3433, %for.cond331.preheader ]
  %K_reg.sroa.0.1 = phi <4 x half> [ %K_reg.sroa.0.0, %if.end322 ], [ %K_reg.sroa.0.0.copyload3430, %for.cond331.preheader ]
  %or.cond2569 = icmp ugt i32 %mul11.3, 1023, !dbg !126
  %cmp361.not = icmp sgt i32 %mul11.3, %1
  %or.cond2570 = or i1 %or.cond2569, %cmp361.not, !dbg !126
  br i1 %or.cond2570, label %if.end386, label %for.cond363.preheader, !dbg !126

for.cond363.preheader:                            ; preds = %if.end354
  %mul368 = shl nsw i32 %0, 16
  %65 = shl nsw i32 %cond.i.i2416.3, 10
  %mul370 = and i32 %65, 64512
  %mul375 = shl nuw nsw i32 %18, 3
  %add371 = or disjoint i32 %mul375, %mul368
  %add373 = add nuw nsw i32 %add371, %mul370
  %66 = zext nneg i32 %add373 to i64, !dbg !127
  %add.ptr378 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %66, !dbg !128
  %K_reg1.sroa.0.0.copyload3406 = load <4 x half>, ptr addrspace(4) %add.ptr378, align 16, !dbg !129
  %K_reg1.sroa.10.0.add.ptr378.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr378, i64 8, !dbg !129
  %K_reg1.sroa.10.0.copyload3409 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.10.0.add.ptr378.sroa_idx, align 8, !dbg !129
  %67 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %66, !dbg !128
  %add.ptr378.1 = getelementptr inbounds i8, ptr addrspace(4) %67, i64 1024, !dbg !128
  %K_reg1.sroa.14.16.copyload3418 = load <4 x half>, ptr addrspace(4) %add.ptr378.1, align 16, !dbg !129
  %K_reg1.sroa.22.16.add.ptr378.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %67, i64 1032, !dbg !129
  %K_reg1.sroa.22.16.copyload3421 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.22.16.add.ptr378.1.sroa_idx, align 8, !dbg !129
  br label %if.end386, !dbg !130

if.end386:                                        ; preds = %for.cond363.preheader, %if.end354
  %K_reg1.sroa.22.1 = phi <4 x half> [ %K_reg1.sroa.22.0, %if.end354 ], [ %K_reg1.sroa.22.16.copyload3421, %for.cond363.preheader ]
  %K_reg1.sroa.14.1 = phi <4 x half> [ %K_reg1.sroa.14.0, %if.end354 ], [ %K_reg1.sroa.14.16.copyload3418, %for.cond363.preheader ]
  %K_reg1.sroa.10.1 = phi <4 x half> [ %K_reg1.sroa.10.0, %if.end354 ], [ %K_reg1.sroa.10.0.copyload3409, %for.cond363.preheader ]
  %K_reg1.sroa.0.1 = phi <4 x half> [ %K_reg1.sroa.0.0, %if.end354 ], [ %K_reg1.sroa.0.0.copyload3406, %for.cond363.preheader ]
  %or.cond2571 = icmp ult i32 %mul11.2, 1024, !dbg !130
  br i1 %or.cond2571, label %land.lhs.true390, label %if.end495, !dbg !130

land.lhs.true390:                                 ; preds = %if.end386
  br i1 %cmp329.not, label %if.end495, label %if.then393, !dbg !131

if.then393:                                       ; preds = %land.lhs.true390
  %add395 = or disjoint i32 %mul11.2, 15, !dbg !132
  %cmp396 = icmp ult i32 %1, %add395, !dbg !133
  br i1 %cmp396, label %for.cond398.preheader, label %if.end422, !dbg !134

for.cond398.preheader:                            ; preds = %if.then393
  %68 = lshr i32 %18, 2
  %mul404 = and i32 %68, 252
  %add405 = add nuw nsw i32 %mul11.2, %mul404
  %cmp408.not = icmp sgt i32 %add405, %1, !dbg !135
  %fneg.2402 = select i1 %cmp408.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3065 = insertelement <4 x float> poison, float %fneg.2402, i64 0, !dbg !136
  %cmp408.not.1.not = icmp slt i32 %add405, %1, !dbg !135
  %fneg.2402.1 = select i1 %cmp408.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3158 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3065, float %fneg.2402.1, i64 1, !dbg !136
  %add406.2 = or disjoint i32 %add405, 2, !dbg !137
  %cmp408.not.2 = icmp sgt i32 %add406.2, %1, !dbg !135
  %fneg.2402.2 = select i1 %cmp408.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3251 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3158, float %fneg.2402.2, i64 2, !dbg !136
  %add406.3 = or disjoint i32 %add405, 3, !dbg !137
  %cmp408.not.3 = icmp sgt i32 %add406.3, %1, !dbg !135
  %fneg.2402.3 = select i1 %cmp408.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3344 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3251, float %fneg.2402.3, i64 3, !dbg !136
  br label %if.end422

if.end422:                                        ; preds = %if.then393, %for.cond398.preheader
  %acc_s.sroa.0.4 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3344, %for.cond398.preheader ], [ zeroinitializer, %if.then393 ], !dbg !75
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.4), !dbg !138, !call_argsrelate !77
  %70 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.10.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %69), !dbg !138, !call_argsrelate !77
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.14.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %70), !dbg !138, !call_argsrelate !77
  %72 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.22.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %71), !dbg !138, !call_argsrelate !77
  %acc_s.sroa.0.0.vec.extract3067 = extractelement <4 x float> %72, i64 0, !dbg !139
  %mul457 = fmul contract float %acc_s.sroa.0.0.vec.extract3067, 0x3FB99999A0000000, !dbg !140
  %73 = tail call contract noundef float @llvm.minnum.f32(float %mul457, float 0x4024CB5EC0000000), !dbg !141
  %74 = tail call contract noundef float @llvm.exp.f32(float %73), !dbg !143
  %acc_s.sroa.0.4.vec.extract3160 = extractelement <4 x float> %72, i64 1, !dbg !139
  %mul457.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3160, 0x3FB99999A0000000, !dbg !140
  %75 = tail call contract noundef float @llvm.minnum.f32(float %mul457.1, float 0x4024CB5EC0000000), !dbg !141
  %76 = tail call contract noundef float @llvm.exp.f32(float %75), !dbg !143
  %acc_s.sroa.0.8.vec.extract3253 = extractelement <4 x float> %72, i64 2, !dbg !139
  %mul457.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3253, 0x3FB99999A0000000, !dbg !140
  %77 = tail call contract noundef float @llvm.minnum.f32(float %mul457.2, float 0x4024CB5EC0000000), !dbg !141
  %78 = tail call contract noundef float @llvm.exp.f32(float %77), !dbg !143
  %acc_s.sroa.0.12.vec.extract3346 = extractelement <4 x float> %72, i64 3, !dbg !139
  %mul457.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3346, 0x3FB99999A0000000, !dbg !140
  %79 = tail call contract noundef float @llvm.minnum.f32(float %mul457.3, float 0x4024CB5EC0000000), !dbg !141
  %80 = tail call contract noundef float @llvm.exp.f32(float %79), !dbg !143
  %add473 = fadd contract float %sum_acc.sroa.0.1, %74, !dbg !145
  %add473.1 = fadd contract float %sum_acc.sroa.20.1, %76, !dbg !145
  %add473.2 = fadd contract float %sum_acc.sroa.38.1, %78, !dbg !145
  %add473.3 = fadd contract float %sum_acc.sroa.56.1, %80, !dbg !145
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %74), !dbg !146
  %gep2457.idx = shl nuw nsw i32 %18, 3, !dbg !150
  %gep2457 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 1024), i32 %gep2457.idx, !dbg !150
  store i16 %81, ptr addrspace(3) %gep2457, align 8, !dbg !151, !tbaa !97
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %76), !dbg !146
  %gep2457.1 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 1026), i32 %gep2457.idx, !dbg !150
  store i16 %82, ptr addrspace(3) %gep2457.1, align 2, !dbg !151, !tbaa !97
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %78), !dbg !146
  %gep2457.2 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 1028), i32 %gep2457.idx, !dbg !150
  store i16 %83, ptr addrspace(3) %gep2457.2, align 4, !dbg !151, !tbaa !97
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %80), !dbg !146
  %gep2457.3 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 1030), i32 %gep2457.idx, !dbg !150
  store i16 %84, ptr addrspace(3) %gep2457.3, align 2, !dbg !151, !tbaa !97
  br label %if.end495, !dbg !152

if.end495:                                        ; preds = %if.end422, %land.lhs.true390, %if.end386
  %sum_acc.sroa.56.2 = phi float [ %sum_acc.sroa.56.1, %land.lhs.true390 ], [ %add473.3, %if.end422 ], [ %sum_acc.sroa.56.1, %if.end386 ], !dbg !75
  %sum_acc.sroa.38.2 = phi float [ %sum_acc.sroa.38.1, %land.lhs.true390 ], [ %add473.2, %if.end422 ], [ %sum_acc.sroa.38.1, %if.end386 ], !dbg !75
  %sum_acc.sroa.20.2 = phi float [ %sum_acc.sroa.20.1, %land.lhs.true390 ], [ %add473.1, %if.end422 ], [ %sum_acc.sroa.20.1, %if.end386 ], !dbg !75
  %sum_acc.sroa.0.2 = phi float [ %sum_acc.sroa.0.1, %land.lhs.true390 ], [ %add473, %if.end422 ], [ %sum_acc.sroa.0.1, %if.end386 ], !dbg !75
  %or.cond2572 = icmp ult i32 %mul11.3, 1024, !dbg !152
  br i1 %or.cond2572, label %land.lhs.true499, label %if.end604, !dbg !152

land.lhs.true499:                                 ; preds = %if.end495
  br i1 %cmp361.not, label %if.end604, label %if.then502, !dbg !153

if.then502:                                       ; preds = %land.lhs.true499
  %add504 = or disjoint i32 %mul11.3, 15, !dbg !154
  %cmp505 = icmp ult i32 %1, %add504, !dbg !155
  br i1 %cmp505, label %for.cond507.preheader, label %if.end531, !dbg !156

for.cond507.preheader:                            ; preds = %if.then502
  %85 = lshr i32 %18, 2
  %mul513 = and i32 %85, 252
  %add514 = add nuw nsw i32 %mul11.3, %mul513
  %cmp517.not = icmp sgt i32 %add514, %1, !dbg !157
  %fneg.2403 = select i1 %cmp517.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3075 = insertelement <4 x float> poison, float %fneg.2403, i64 0, !dbg !158
  %cmp517.not.1.not = icmp slt i32 %add514, %1, !dbg !157
  %fneg.2403.1 = select i1 %cmp517.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3168 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3075, float %fneg.2403.1, i64 1, !dbg !158
  %add515.2 = or disjoint i32 %add514, 2, !dbg !159
  %cmp517.not.2 = icmp sgt i32 %add515.2, %1, !dbg !157
  %fneg.2403.2 = select i1 %cmp517.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3261 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3168, float %fneg.2403.2, i64 2, !dbg !158
  %add515.3 = or disjoint i32 %add514, 3, !dbg !159
  %cmp517.not.3 = icmp sgt i32 %add515.3, %1, !dbg !157
  %fneg.2403.3 = select i1 %cmp517.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3354 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3261, float %fneg.2403.3, i64 3, !dbg !158
  br label %if.end531

if.end531:                                        ; preds = %if.then502, %for.cond507.preheader
  %acc_s.sroa.0.6 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3354, %for.cond507.preheader ], [ zeroinitializer, %if.then502 ], !dbg !75
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.6), !dbg !160, !call_argsrelate !77
  %87 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.10.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %86), !dbg !160, !call_argsrelate !77
  %88 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.14.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %87), !dbg !160, !call_argsrelate !77
  %89 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.22.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %88), !dbg !160, !call_argsrelate !77
  %acc_s.sroa.0.0.vec.extract3077 = extractelement <4 x float> %89, i64 0, !dbg !161
  %mul566 = fmul contract float %acc_s.sroa.0.0.vec.extract3077, 0x3FB99999A0000000, !dbg !162
  %90 = tail call contract noundef float @llvm.minnum.f32(float %mul566, float 0x4024CB5EC0000000), !dbg !163
  %91 = tail call contract noundef float @llvm.exp.f32(float %90), !dbg !165
  %acc_s.sroa.0.4.vec.extract3170 = extractelement <4 x float> %89, i64 1, !dbg !161
  %mul566.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3170, 0x3FB99999A0000000, !dbg !162
  %92 = tail call contract noundef float @llvm.minnum.f32(float %mul566.1, float 0x4024CB5EC0000000), !dbg !163
  %93 = tail call contract noundef float @llvm.exp.f32(float %92), !dbg !165
  %acc_s.sroa.0.8.vec.extract3263 = extractelement <4 x float> %89, i64 2, !dbg !161
  %mul566.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3263, 0x3FB99999A0000000, !dbg !162
  %94 = tail call contract noundef float @llvm.minnum.f32(float %mul566.2, float 0x4024CB5EC0000000), !dbg !163
  %95 = tail call contract noundef float @llvm.exp.f32(float %94), !dbg !165
  %acc_s.sroa.0.12.vec.extract3356 = extractelement <4 x float> %89, i64 3, !dbg !161
  %mul566.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3356, 0x3FB99999A0000000, !dbg !162
  %96 = tail call contract noundef float @llvm.minnum.f32(float %mul566.3, float 0x4024CB5EC0000000), !dbg !163
  %97 = tail call contract noundef float @llvm.exp.f32(float %96), !dbg !165
  %add582 = fadd contract float %sum_acc.sroa.0.2, %91, !dbg !167
  %add582.1 = fadd contract float %sum_acc.sroa.20.2, %93, !dbg !167
  %add582.2 = fadd contract float %sum_acc.sroa.38.2, %95, !dbg !167
  %add582.3 = fadd contract float %sum_acc.sroa.56.2, %97, !dbg !167
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %91), !dbg !168
  %gep2468.idx = shl nuw nsw i32 %18, 3, !dbg !172
  %gep2468 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 1536), i32 %gep2468.idx, !dbg !172
  store i16 %98, ptr addrspace(3) %gep2468, align 8, !dbg !173, !tbaa !97
  %99 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %93), !dbg !168
  %gep2468.1 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 1538), i32 %gep2468.idx, !dbg !172
  store i16 %99, ptr addrspace(3) %gep2468.1, align 2, !dbg !173, !tbaa !97
  %100 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %95), !dbg !168
  %gep2468.2 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 1540), i32 %gep2468.idx, !dbg !172
  store i16 %100, ptr addrspace(3) %gep2468.2, align 4, !dbg !173, !tbaa !97
  %101 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %97), !dbg !168
  %gep2468.3 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 1542), i32 %gep2468.idx, !dbg !172
  store i16 %101, ptr addrspace(3) %gep2468.3, align 2, !dbg !173, !tbaa !97
  br label %if.end604, !dbg !174

if.end604:                                        ; preds = %if.end531, %land.lhs.true499, %if.end495
  %sum_acc.sroa.56.3 = phi float [ %sum_acc.sroa.56.2, %land.lhs.true499 ], [ %add582.3, %if.end531 ], [ %sum_acc.sroa.56.2, %if.end495 ], !dbg !75
  %sum_acc.sroa.38.3 = phi float [ %sum_acc.sroa.38.2, %land.lhs.true499 ], [ %add582.2, %if.end531 ], [ %sum_acc.sroa.38.2, %if.end495 ], !dbg !75
  %sum_acc.sroa.20.3 = phi float [ %sum_acc.sroa.20.2, %land.lhs.true499 ], [ %add582.1, %if.end531 ], [ %sum_acc.sroa.20.2, %if.end495 ], !dbg !75
  %sum_acc.sroa.0.3 = phi float [ %sum_acc.sroa.0.2, %land.lhs.true499 ], [ %add582, %if.end531 ], [ %sum_acc.sroa.0.2, %if.end495 ], !dbg !75
  %or.cond2573 = icmp ugt i32 %mul11.4, 1023, !dbg !175
  %cmp611.not = icmp sgt i32 %mul11.4, %1
  %or.cond2574 = or i1 %or.cond2573, %cmp611.not, !dbg !175
  br i1 %or.cond2574, label %if.end636, label %for.cond613.preheader, !dbg !175

for.cond613.preheader:                            ; preds = %if.end604
  %mul618 = shl nsw i32 %0, 16
  %102 = shl nsw i32 %cond.i.i2416.4, 10
  %mul620 = and i32 %102, 64512
  %mul625 = shl nuw nsw i32 %18, 3
  %add621 = or disjoint i32 %mul625, %mul618
  %add623 = add nuw nsw i32 %add621, %mul620
  %103 = zext nneg i32 %add623 to i64, !dbg !176
  %add.ptr628 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %103, !dbg !177
  %K_reg.sroa.0.0.copyload3431 = load <4 x half>, ptr addrspace(4) %add.ptr628, align 16, !dbg !178
  %K_reg.sroa.10.0.add.ptr628.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr628, i64 8, !dbg !178
  %K_reg.sroa.10.0.copyload3434 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.10.0.add.ptr628.sroa_idx, align 8, !dbg !178
  %104 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %103, !dbg !177
  %add.ptr628.1 = getelementptr inbounds i8, ptr addrspace(4) %104, i64 1024, !dbg !177
  %K_reg.sroa.14.16.copyload3443 = load <4 x half>, ptr addrspace(4) %add.ptr628.1, align 16, !dbg !178
  %K_reg.sroa.22.16.add.ptr628.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %104, i64 1032, !dbg !178
  %K_reg.sroa.22.16.copyload3446 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.22.16.add.ptr628.1.sroa_idx, align 8, !dbg !178
  br label %if.end636, !dbg !179

if.end636:                                        ; preds = %for.cond613.preheader, %if.end604
  %K_reg.sroa.22.2 = phi <4 x half> [ %K_reg.sroa.22.1, %if.end604 ], [ %K_reg.sroa.22.16.copyload3446, %for.cond613.preheader ]
  %K_reg.sroa.14.2 = phi <4 x half> [ %K_reg.sroa.14.1, %if.end604 ], [ %K_reg.sroa.14.16.copyload3443, %for.cond613.preheader ]
  %K_reg.sroa.10.2 = phi <4 x half> [ %K_reg.sroa.10.1, %if.end604 ], [ %K_reg.sroa.10.0.copyload3434, %for.cond613.preheader ]
  %K_reg.sroa.0.2 = phi <4 x half> [ %K_reg.sroa.0.1, %if.end604 ], [ %K_reg.sroa.0.0.copyload3431, %for.cond613.preheader ]
  %or.cond2575 = icmp ugt i32 %mul11.5, 1023, !dbg !180
  %cmp643.not = icmp sgt i32 %mul11.5, %1
  %or.cond2576 = or i1 %or.cond2575, %cmp643.not, !dbg !180
  br i1 %or.cond2576, label %if.end668, label %for.cond645.preheader, !dbg !180

for.cond645.preheader:                            ; preds = %if.end636
  %mul650 = shl nsw i32 %0, 16
  %105 = shl nsw i32 %cond.i.i2416.5, 10
  %mul652 = and i32 %105, 64512
  %mul657 = shl nuw nsw i32 %18, 3
  %add653 = or disjoint i32 %mul657, %mul650
  %add655 = add nuw nsw i32 %add653, %mul652
  %106 = zext nneg i32 %add655 to i64, !dbg !181
  %add.ptr660 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %106, !dbg !182
  %K_reg1.sroa.0.0.copyload3407 = load <4 x half>, ptr addrspace(4) %add.ptr660, align 16, !dbg !183
  %K_reg1.sroa.10.0.add.ptr660.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr660, i64 8, !dbg !183
  %K_reg1.sroa.10.0.copyload3410 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.10.0.add.ptr660.sroa_idx, align 8, !dbg !183
  %107 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %106, !dbg !182
  %add.ptr660.1 = getelementptr inbounds i8, ptr addrspace(4) %107, i64 1024, !dbg !182
  %K_reg1.sroa.14.16.copyload3419 = load <4 x half>, ptr addrspace(4) %add.ptr660.1, align 16, !dbg !183
  %K_reg1.sroa.22.16.add.ptr660.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %107, i64 1032, !dbg !183
  %K_reg1.sroa.22.16.copyload3422 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.22.16.add.ptr660.1.sroa_idx, align 8, !dbg !183
  br label %if.end668, !dbg !184

if.end668:                                        ; preds = %for.cond645.preheader, %if.end636
  %K_reg1.sroa.22.2 = phi <4 x half> [ %K_reg1.sroa.22.1, %if.end636 ], [ %K_reg1.sroa.22.16.copyload3422, %for.cond645.preheader ]
  %K_reg1.sroa.14.2 = phi <4 x half> [ %K_reg1.sroa.14.1, %if.end636 ], [ %K_reg1.sroa.14.16.copyload3419, %for.cond645.preheader ]
  %K_reg1.sroa.10.2 = phi <4 x half> [ %K_reg1.sroa.10.1, %if.end636 ], [ %K_reg1.sroa.10.0.copyload3410, %for.cond645.preheader ]
  %K_reg1.sroa.0.2 = phi <4 x half> [ %K_reg1.sroa.0.1, %if.end636 ], [ %K_reg1.sroa.0.0.copyload3407, %for.cond645.preheader ]
  %or.cond2577 = icmp ult i32 %mul11.4, 1024, !dbg !184
  br i1 %or.cond2577, label %land.lhs.true672, label %if.end777, !dbg !184

land.lhs.true672:                                 ; preds = %if.end668
  br i1 %cmp611.not, label %if.end777, label %if.then675, !dbg !185

if.then675:                                       ; preds = %land.lhs.true672
  %add677 = or disjoint i32 %mul11.4, 15, !dbg !186
  %cmp678 = icmp ult i32 %1, %add677, !dbg !187
  br i1 %cmp678, label %for.cond680.preheader, label %if.end704, !dbg !188

for.cond680.preheader:                            ; preds = %if.then675
  %108 = lshr i32 %18, 2
  %mul686 = and i32 %108, 252
  %add687 = add nuw nsw i32 %mul11.4, %mul686
  %cmp690.not = icmp sgt i32 %add687, %1, !dbg !189
  %fneg.2404 = select i1 %cmp690.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3085 = insertelement <4 x float> poison, float %fneg.2404, i64 0, !dbg !190
  %cmp690.not.1.not = icmp slt i32 %add687, %1, !dbg !189
  %fneg.2404.1 = select i1 %cmp690.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3178 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3085, float %fneg.2404.1, i64 1, !dbg !190
  %add688.2 = or disjoint i32 %add687, 2, !dbg !191
  %cmp690.not.2 = icmp sgt i32 %add688.2, %1, !dbg !189
  %fneg.2404.2 = select i1 %cmp690.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3271 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3178, float %fneg.2404.2, i64 2, !dbg !190
  %add688.3 = or disjoint i32 %add687, 3, !dbg !191
  %cmp690.not.3 = icmp sgt i32 %add688.3, %1, !dbg !189
  %fneg.2404.3 = select i1 %cmp690.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3364 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3271, float %fneg.2404.3, i64 3, !dbg !190
  br label %if.end704

if.end704:                                        ; preds = %if.then675, %for.cond680.preheader
  %acc_s.sroa.0.8 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3364, %for.cond680.preheader ], [ zeroinitializer, %if.then675 ], !dbg !75
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.2, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.8), !dbg !192, !call_argsrelate !77
  %110 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.10.2, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %109), !dbg !192, !call_argsrelate !77
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.14.2, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %110), !dbg !192, !call_argsrelate !77
  %112 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.22.2, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %111), !dbg !192, !call_argsrelate !77
  %acc_s.sroa.0.0.vec.extract3087 = extractelement <4 x float> %112, i64 0, !dbg !193
  %mul739 = fmul contract float %acc_s.sroa.0.0.vec.extract3087, 0x3FB99999A0000000, !dbg !194
  %113 = tail call contract noundef float @llvm.minnum.f32(float %mul739, float 0x4024CB5EC0000000), !dbg !195
  %114 = tail call contract noundef float @llvm.exp.f32(float %113), !dbg !197
  %acc_s.sroa.0.4.vec.extract3180 = extractelement <4 x float> %112, i64 1, !dbg !193
  %mul739.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3180, 0x3FB99999A0000000, !dbg !194
  %115 = tail call contract noundef float @llvm.minnum.f32(float %mul739.1, float 0x4024CB5EC0000000), !dbg !195
  %116 = tail call contract noundef float @llvm.exp.f32(float %115), !dbg !197
  %acc_s.sroa.0.8.vec.extract3273 = extractelement <4 x float> %112, i64 2, !dbg !193
  %mul739.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3273, 0x3FB99999A0000000, !dbg !194
  %117 = tail call contract noundef float @llvm.minnum.f32(float %mul739.2, float 0x4024CB5EC0000000), !dbg !195
  %118 = tail call contract noundef float @llvm.exp.f32(float %117), !dbg !197
  %acc_s.sroa.0.12.vec.extract3366 = extractelement <4 x float> %112, i64 3, !dbg !193
  %mul739.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3366, 0x3FB99999A0000000, !dbg !194
  %119 = tail call contract noundef float @llvm.minnum.f32(float %mul739.3, float 0x4024CB5EC0000000), !dbg !195
  %120 = tail call contract noundef float @llvm.exp.f32(float %119), !dbg !197
  %add755 = fadd contract float %sum_acc.sroa.0.3, %114, !dbg !199
  %add755.1 = fadd contract float %sum_acc.sroa.20.3, %116, !dbg !199
  %add755.2 = fadd contract float %sum_acc.sroa.38.3, %118, !dbg !199
  %add755.3 = fadd contract float %sum_acc.sroa.56.3, %120, !dbg !199
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %114), !dbg !200
  %gep2481.idx = shl nuw nsw i32 %18, 3, !dbg !204
  %gep2481 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %gep2481.idx, !dbg !204
  store i16 %121, ptr addrspace(3) %gep2481, align 8, !dbg !205, !tbaa !97
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %116), !dbg !200
  %gep2481.1 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2050), i32 %gep2481.idx, !dbg !204
  store i16 %122, ptr addrspace(3) %gep2481.1, align 2, !dbg !205, !tbaa !97
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %118), !dbg !200
  %gep2481.2 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2052), i32 %gep2481.idx, !dbg !204
  store i16 %123, ptr addrspace(3) %gep2481.2, align 4, !dbg !205, !tbaa !97
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %120), !dbg !200
  %gep2481.3 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2054), i32 %gep2481.idx, !dbg !204
  store i16 %124, ptr addrspace(3) %gep2481.3, align 2, !dbg !205, !tbaa !97
  br label %if.end777, !dbg !206

if.end777:                                        ; preds = %if.end704, %land.lhs.true672, %if.end668
  %sum_acc.sroa.56.4 = phi float [ %sum_acc.sroa.56.3, %land.lhs.true672 ], [ %add755.3, %if.end704 ], [ %sum_acc.sroa.56.3, %if.end668 ], !dbg !75
  %sum_acc.sroa.38.4 = phi float [ %sum_acc.sroa.38.3, %land.lhs.true672 ], [ %add755.2, %if.end704 ], [ %sum_acc.sroa.38.3, %if.end668 ], !dbg !75
  %sum_acc.sroa.20.4 = phi float [ %sum_acc.sroa.20.3, %land.lhs.true672 ], [ %add755.1, %if.end704 ], [ %sum_acc.sroa.20.3, %if.end668 ], !dbg !75
  %sum_acc.sroa.0.4 = phi float [ %sum_acc.sroa.0.3, %land.lhs.true672 ], [ %add755, %if.end704 ], [ %sum_acc.sroa.0.3, %if.end668 ], !dbg !75
  %or.cond2578 = icmp ult i32 %mul11.5, 1024, !dbg !206
  br i1 %or.cond2578, label %land.lhs.true781, label %if.end886, !dbg !206

land.lhs.true781:                                 ; preds = %if.end777
  br i1 %cmp643.not, label %if.end886, label %if.then784, !dbg !207

if.then784:                                       ; preds = %land.lhs.true781
  %add786 = or disjoint i32 %mul11.5, 15, !dbg !208
  %cmp787 = icmp ult i32 %1, %add786, !dbg !209
  br i1 %cmp787, label %for.cond789.preheader, label %if.end813, !dbg !210

for.cond789.preheader:                            ; preds = %if.then784
  %125 = lshr i32 %18, 2
  %mul795 = and i32 %125, 252
  %add796 = add nuw nsw i32 %mul11.5, %mul795
  %cmp799.not = icmp sgt i32 %add796, %1, !dbg !211
  %fneg.2405 = select i1 %cmp799.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3095 = insertelement <4 x float> poison, float %fneg.2405, i64 0, !dbg !212
  %cmp799.not.1.not = icmp slt i32 %add796, %1, !dbg !211
  %fneg.2405.1 = select i1 %cmp799.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3188 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3095, float %fneg.2405.1, i64 1, !dbg !212
  %add797.2 = or disjoint i32 %add796, 2, !dbg !213
  %cmp799.not.2 = icmp sgt i32 %add797.2, %1, !dbg !211
  %fneg.2405.2 = select i1 %cmp799.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3281 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3188, float %fneg.2405.2, i64 2, !dbg !212
  %add797.3 = or disjoint i32 %add796, 3, !dbg !213
  %cmp799.not.3 = icmp sgt i32 %add797.3, %1, !dbg !211
  %fneg.2405.3 = select i1 %cmp799.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3374 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3281, float %fneg.2405.3, i64 3, !dbg !212
  br label %if.end813

if.end813:                                        ; preds = %if.then784, %for.cond789.preheader
  %acc_s.sroa.0.10 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3374, %for.cond789.preheader ], [ zeroinitializer, %if.then784 ], !dbg !75
  %126 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.2, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.10), !dbg !214, !call_argsrelate !77
  %127 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.10.2, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %126), !dbg !214, !call_argsrelate !77
  %128 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.14.2, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %127), !dbg !214, !call_argsrelate !77
  %129 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.22.2, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %128), !dbg !214, !call_argsrelate !77
  %acc_s.sroa.0.0.vec.extract3097 = extractelement <4 x float> %129, i64 0, !dbg !215
  %mul848 = fmul contract float %acc_s.sroa.0.0.vec.extract3097, 0x3FB99999A0000000, !dbg !216
  %130 = tail call contract noundef float @llvm.minnum.f32(float %mul848, float 0x4024CB5EC0000000), !dbg !217
  %131 = tail call contract noundef float @llvm.exp.f32(float %130), !dbg !219
  %acc_s.sroa.0.4.vec.extract3190 = extractelement <4 x float> %129, i64 1, !dbg !215
  %mul848.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3190, 0x3FB99999A0000000, !dbg !216
  %132 = tail call contract noundef float @llvm.minnum.f32(float %mul848.1, float 0x4024CB5EC0000000), !dbg !217
  %133 = tail call contract noundef float @llvm.exp.f32(float %132), !dbg !219
  %acc_s.sroa.0.8.vec.extract3283 = extractelement <4 x float> %129, i64 2, !dbg !215
  %mul848.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3283, 0x3FB99999A0000000, !dbg !216
  %134 = tail call contract noundef float @llvm.minnum.f32(float %mul848.2, float 0x4024CB5EC0000000), !dbg !217
  %135 = tail call contract noundef float @llvm.exp.f32(float %134), !dbg !219
  %acc_s.sroa.0.12.vec.extract3376 = extractelement <4 x float> %129, i64 3, !dbg !215
  %mul848.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3376, 0x3FB99999A0000000, !dbg !216
  %136 = tail call contract noundef float @llvm.minnum.f32(float %mul848.3, float 0x4024CB5EC0000000), !dbg !217
  %137 = tail call contract noundef float @llvm.exp.f32(float %136), !dbg !219
  %add864 = fadd contract float %sum_acc.sroa.0.4, %131, !dbg !221
  %add864.1 = fadd contract float %sum_acc.sroa.20.4, %133, !dbg !221
  %add864.2 = fadd contract float %sum_acc.sroa.38.4, %135, !dbg !221
  %add864.3 = fadd contract float %sum_acc.sroa.56.4, %137, !dbg !221
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %131), !dbg !222
  %gep2492.idx = shl nuw nsw i32 %18, 3, !dbg !226
  %gep2492 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2560), i32 %gep2492.idx, !dbg !226
  store i16 %138, ptr addrspace(3) %gep2492, align 8, !dbg !227, !tbaa !97
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %133), !dbg !222
  %gep2492.1 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2562), i32 %gep2492.idx, !dbg !226
  store i16 %139, ptr addrspace(3) %gep2492.1, align 2, !dbg !227, !tbaa !97
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %135), !dbg !222
  %gep2492.2 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2564), i32 %gep2492.idx, !dbg !226
  store i16 %140, ptr addrspace(3) %gep2492.2, align 4, !dbg !227, !tbaa !97
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %137), !dbg !222
  %gep2492.3 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2566), i32 %gep2492.idx, !dbg !226
  store i16 %141, ptr addrspace(3) %gep2492.3, align 2, !dbg !227, !tbaa !97
  br label %if.end886, !dbg !228

if.end886:                                        ; preds = %if.end813, %land.lhs.true781, %if.end777
  %sum_acc.sroa.56.5 = phi float [ %sum_acc.sroa.56.4, %land.lhs.true781 ], [ %add864.3, %if.end813 ], [ %sum_acc.sroa.56.4, %if.end777 ], !dbg !75
  %sum_acc.sroa.38.5 = phi float [ %sum_acc.sroa.38.4, %land.lhs.true781 ], [ %add864.2, %if.end813 ], [ %sum_acc.sroa.38.4, %if.end777 ], !dbg !75
  %sum_acc.sroa.20.5 = phi float [ %sum_acc.sroa.20.4, %land.lhs.true781 ], [ %add864.1, %if.end813 ], [ %sum_acc.sroa.20.4, %if.end777 ], !dbg !75
  %sum_acc.sroa.0.5 = phi float [ %sum_acc.sroa.0.4, %land.lhs.true781 ], [ %add864, %if.end813 ], [ %sum_acc.sroa.0.4, %if.end777 ], !dbg !75
  %or.cond2579 = icmp ugt i32 %mul11.6, 1023, !dbg !229
  %cmp893.not = icmp sgt i32 %mul11.6, %1
  %or.cond2580 = or i1 %or.cond2579, %cmp893.not, !dbg !229
  br i1 %or.cond2580, label %if.end918, label %for.cond895.preheader, !dbg !229

for.cond895.preheader:                            ; preds = %if.end886
  %mul900 = shl nsw i32 %0, 16
  %142 = shl nsw i32 %cond.i.i2416.6, 10
  %mul902 = and i32 %142, 64512
  %mul907 = shl nuw nsw i32 %18, 3
  %add903 = or disjoint i32 %mul907, %mul900
  %add905 = add nuw nsw i32 %add903, %mul902
  %143 = zext nneg i32 %add905 to i64, !dbg !230
  %add.ptr910 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %143, !dbg !231
  %K_reg.sroa.0.0.copyload3432 = load <4 x half>, ptr addrspace(4) %add.ptr910, align 16, !dbg !232
  %K_reg.sroa.10.0.add.ptr910.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr910, i64 8, !dbg !232
  %K_reg.sroa.10.0.copyload3435 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.10.0.add.ptr910.sroa_idx, align 8, !dbg !232
  %144 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %143, !dbg !231
  %add.ptr910.1 = getelementptr inbounds i8, ptr addrspace(4) %144, i64 1024, !dbg !231
  %K_reg.sroa.14.16.copyload3444 = load <4 x half>, ptr addrspace(4) %add.ptr910.1, align 16, !dbg !232
  %K_reg.sroa.22.16.add.ptr910.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %144, i64 1032, !dbg !232
  %K_reg.sroa.22.16.copyload3447 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.22.16.add.ptr910.1.sroa_idx, align 8, !dbg !232
  br label %if.end918, !dbg !233

if.end918:                                        ; preds = %for.cond895.preheader, %if.end886
  %K_reg.sroa.22.3 = phi <4 x half> [ %K_reg.sroa.22.2, %if.end886 ], [ %K_reg.sroa.22.16.copyload3447, %for.cond895.preheader ]
  %K_reg.sroa.14.3 = phi <4 x half> [ %K_reg.sroa.14.2, %if.end886 ], [ %K_reg.sroa.14.16.copyload3444, %for.cond895.preheader ]
  %K_reg.sroa.10.3 = phi <4 x half> [ %K_reg.sroa.10.2, %if.end886 ], [ %K_reg.sroa.10.0.copyload3435, %for.cond895.preheader ]
  %K_reg.sroa.0.3 = phi <4 x half> [ %K_reg.sroa.0.2, %if.end886 ], [ %K_reg.sroa.0.0.copyload3432, %for.cond895.preheader ]
  %or.cond2581 = icmp ugt i32 %mul11.7, 1023, !dbg !234
  %cmp925.not = icmp sgt i32 %mul11.7, %1
  %or.cond2582 = or i1 %or.cond2581, %cmp925.not, !dbg !234
  br i1 %or.cond2582, label %if.end950, label %for.cond927.preheader, !dbg !234

for.cond927.preheader:                            ; preds = %if.end918
  %mul932 = shl nsw i32 %0, 16
  %145 = shl nsw i32 %cond.i.i2416.7, 10
  %mul934 = and i32 %145, 64512
  %mul939 = shl nuw nsw i32 %18, 3
  %add935 = or disjoint i32 %mul939, %mul932
  %add937 = add nuw nsw i32 %add935, %mul934
  %146 = zext nneg i32 %add937 to i64, !dbg !235
  %add.ptr942 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %146, !dbg !236
  %K_reg1.sroa.0.0.copyload3408 = load <4 x half>, ptr addrspace(4) %add.ptr942, align 16, !dbg !237
  %K_reg1.sroa.10.0.add.ptr942.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr942, i64 8, !dbg !237
  %K_reg1.sroa.10.0.copyload3411 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.10.0.add.ptr942.sroa_idx, align 8, !dbg !237
  %147 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %146, !dbg !236
  %add.ptr942.1 = getelementptr inbounds i8, ptr addrspace(4) %147, i64 1024, !dbg !236
  %K_reg1.sroa.14.16.copyload3420 = load <4 x half>, ptr addrspace(4) %add.ptr942.1, align 16, !dbg !237
  %K_reg1.sroa.22.16.add.ptr942.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %147, i64 1032, !dbg !237
  %K_reg1.sroa.22.16.copyload3423 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.22.16.add.ptr942.1.sroa_idx, align 8, !dbg !237
  br label %if.end950, !dbg !238

if.end950:                                        ; preds = %for.cond927.preheader, %if.end918
  %K_reg1.sroa.22.3 = phi <4 x half> [ %K_reg1.sroa.22.2, %if.end918 ], [ %K_reg1.sroa.22.16.copyload3423, %for.cond927.preheader ]
  %K_reg1.sroa.14.3 = phi <4 x half> [ %K_reg1.sroa.14.2, %if.end918 ], [ %K_reg1.sroa.14.16.copyload3420, %for.cond927.preheader ]
  %K_reg1.sroa.10.3 = phi <4 x half> [ %K_reg1.sroa.10.2, %if.end918 ], [ %K_reg1.sroa.10.0.copyload3411, %for.cond927.preheader ]
  %K_reg1.sroa.0.3 = phi <4 x half> [ %K_reg1.sroa.0.2, %if.end918 ], [ %K_reg1.sroa.0.0.copyload3408, %for.cond927.preheader ]
  %or.cond2583 = icmp ult i32 %mul11.6, 1024, !dbg !238
  br i1 %or.cond2583, label %land.lhs.true954, label %if.end1059, !dbg !238

land.lhs.true954:                                 ; preds = %if.end950
  br i1 %cmp893.not, label %if.end1059, label %if.then957, !dbg !239

if.then957:                                       ; preds = %land.lhs.true954
  %add959 = or disjoint i32 %mul11.6, 15, !dbg !240
  %cmp960 = icmp ult i32 %1, %add959, !dbg !241
  br i1 %cmp960, label %for.cond962.preheader, label %if.end986, !dbg !242

for.cond962.preheader:                            ; preds = %if.then957
  %148 = lshr i32 %18, 2
  %mul968 = and i32 %148, 252
  %add969 = add nuw nsw i32 %mul11.6, %mul968
  %cmp972.not = icmp sgt i32 %add969, %1, !dbg !243
  %fneg.2406 = select i1 %cmp972.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3105 = insertelement <4 x float> poison, float %fneg.2406, i64 0, !dbg !244
  %cmp972.not.1.not = icmp slt i32 %add969, %1, !dbg !243
  %fneg.2406.1 = select i1 %cmp972.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3198 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3105, float %fneg.2406.1, i64 1, !dbg !244
  %add970.2 = or disjoint i32 %add969, 2, !dbg !245
  %cmp972.not.2 = icmp sgt i32 %add970.2, %1, !dbg !243
  %fneg.2406.2 = select i1 %cmp972.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3291 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3198, float %fneg.2406.2, i64 2, !dbg !244
  %add970.3 = or disjoint i32 %add969, 3, !dbg !245
  %cmp972.not.3 = icmp sgt i32 %add970.3, %1, !dbg !243
  %fneg.2406.3 = select i1 %cmp972.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3384 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3291, float %fneg.2406.3, i64 3, !dbg !244
  br label %if.end986

if.end986:                                        ; preds = %if.then957, %for.cond962.preheader
  %acc_s.sroa.0.12 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3384, %for.cond962.preheader ], [ zeroinitializer, %if.then957 ], !dbg !75
  %149 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.3, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.12), !dbg !246, !call_argsrelate !77
  %150 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.10.3, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %149), !dbg !246, !call_argsrelate !77
  %151 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.14.3, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %150), !dbg !246, !call_argsrelate !77
  %152 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.22.3, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %151), !dbg !246, !call_argsrelate !77
  %acc_s.sroa.0.0.vec.extract3107 = extractelement <4 x float> %152, i64 0, !dbg !247
  %mul1021 = fmul contract float %acc_s.sroa.0.0.vec.extract3107, 0x3FB99999A0000000, !dbg !248
  %153 = tail call contract noundef float @llvm.minnum.f32(float %mul1021, float 0x4024CB5EC0000000), !dbg !249
  %154 = tail call contract noundef float @llvm.exp.f32(float %153), !dbg !251
  %acc_s.sroa.0.4.vec.extract3200 = extractelement <4 x float> %152, i64 1, !dbg !247
  %mul1021.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3200, 0x3FB99999A0000000, !dbg !248
  %155 = tail call contract noundef float @llvm.minnum.f32(float %mul1021.1, float 0x4024CB5EC0000000), !dbg !249
  %156 = tail call contract noundef float @llvm.exp.f32(float %155), !dbg !251
  %acc_s.sroa.0.8.vec.extract3293 = extractelement <4 x float> %152, i64 2, !dbg !247
  %mul1021.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3293, 0x3FB99999A0000000, !dbg !248
  %157 = tail call contract noundef float @llvm.minnum.f32(float %mul1021.2, float 0x4024CB5EC0000000), !dbg !249
  %158 = tail call contract noundef float @llvm.exp.f32(float %157), !dbg !251
  %acc_s.sroa.0.12.vec.extract3386 = extractelement <4 x float> %152, i64 3, !dbg !247
  %mul1021.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3386, 0x3FB99999A0000000, !dbg !248
  %159 = tail call contract noundef float @llvm.minnum.f32(float %mul1021.3, float 0x4024CB5EC0000000), !dbg !249
  %160 = tail call contract noundef float @llvm.exp.f32(float %159), !dbg !251
  %add1037 = fadd contract float %sum_acc.sroa.0.5, %154, !dbg !253
  %add1037.1 = fadd contract float %sum_acc.sroa.20.5, %156, !dbg !253
  %add1037.2 = fadd contract float %sum_acc.sroa.38.5, %158, !dbg !253
  %add1037.3 = fadd contract float %sum_acc.sroa.56.5, %160, !dbg !253
  %161 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %154), !dbg !254
  %gep2505.idx = shl nuw nsw i32 %18, 3, !dbg !258
  %gep2505 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 3072), i32 %gep2505.idx, !dbg !258
  store i16 %161, ptr addrspace(3) %gep2505, align 8, !dbg !259, !tbaa !97
  %162 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %156), !dbg !254
  %gep2505.1 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 3074), i32 %gep2505.idx, !dbg !258
  store i16 %162, ptr addrspace(3) %gep2505.1, align 2, !dbg !259, !tbaa !97
  %163 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %158), !dbg !254
  %gep2505.2 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 3076), i32 %gep2505.idx, !dbg !258
  store i16 %163, ptr addrspace(3) %gep2505.2, align 4, !dbg !259, !tbaa !97
  %164 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %160), !dbg !254
  %gep2505.3 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 3078), i32 %gep2505.idx, !dbg !258
  store i16 %164, ptr addrspace(3) %gep2505.3, align 2, !dbg !259, !tbaa !97
  br label %if.end1059, !dbg !260

if.end1059:                                       ; preds = %if.end986, %land.lhs.true954, %if.end950
  %sum_acc.sroa.56.6 = phi float [ %sum_acc.sroa.56.5, %land.lhs.true954 ], [ %add1037.3, %if.end986 ], [ %sum_acc.sroa.56.5, %if.end950 ], !dbg !75
  %sum_acc.sroa.38.6 = phi float [ %sum_acc.sroa.38.5, %land.lhs.true954 ], [ %add1037.2, %if.end986 ], [ %sum_acc.sroa.38.5, %if.end950 ], !dbg !75
  %sum_acc.sroa.20.6 = phi float [ %sum_acc.sroa.20.5, %land.lhs.true954 ], [ %add1037.1, %if.end986 ], [ %sum_acc.sroa.20.5, %if.end950 ], !dbg !75
  %sum_acc.sroa.0.6 = phi float [ %sum_acc.sroa.0.5, %land.lhs.true954 ], [ %add1037, %if.end986 ], [ %sum_acc.sroa.0.5, %if.end950 ], !dbg !75
  %or.cond2584 = icmp ult i32 %mul11.7, 1024, !dbg !260
  br i1 %or.cond2584, label %land.lhs.true1063, label %if.end1168, !dbg !260

land.lhs.true1063:                                ; preds = %if.end1059
  br i1 %cmp925.not, label %if.end1168, label %if.then1066, !dbg !261

if.then1066:                                      ; preds = %land.lhs.true1063
  %add1068 = or disjoint i32 %mul11.7, 15, !dbg !262
  %cmp1069 = icmp slt i32 %1, %add1068, !dbg !263
  br i1 %cmp1069, label %for.cond1071.preheader, label %if.end1095, !dbg !264

for.cond1071.preheader:                           ; preds = %if.then1066
  %165 = lshr i32 %18, 2
  %mul1077 = and i32 %165, 252
  %add1078 = add nuw nsw i32 %mul11.7, %mul1077
  %cmp1081.not = icmp sgt i32 %add1078, %1, !dbg !265
  %fneg.2407 = select i1 %cmp1081.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert3115 = insertelement <4 x float> poison, float %fneg.2407, i64 0, !dbg !266
  %cmp1081.not.1.not = icmp slt i32 %add1078, %1, !dbg !265
  %fneg.2407.1 = select i1 %cmp1081.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert3208 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert3115, float %fneg.2407.1, i64 1, !dbg !266
  %add1079.2 = or disjoint i32 %add1078, 2, !dbg !267
  %cmp1081.not.2 = icmp sgt i32 %add1079.2, %1, !dbg !265
  %fneg.2407.2 = select i1 %cmp1081.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert3301 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert3208, float %fneg.2407.2, i64 2, !dbg !266
  %add1079.3 = or disjoint i32 %add1078, 3, !dbg !267
  %cmp1081.not.3 = icmp sgt i32 %add1079.3, %1, !dbg !265
  %fneg.2407.3 = select i1 %cmp1081.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert3394 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert3301, float %fneg.2407.3, i64 3, !dbg !266
  br label %if.end1095

if.end1095:                                       ; preds = %if.then1066, %for.cond1071.preheader
  %acc_s.sroa.0.14 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert3394, %for.cond1071.preheader ], [ zeroinitializer, %if.then1066 ], !dbg !75
  %166 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.3, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.14), !dbg !268, !call_argsrelate !77
  %167 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.10.3, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %166), !dbg !268, !call_argsrelate !77
  %168 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.14.3, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %167), !dbg !268, !call_argsrelate !77
  %169 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.22.3, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %168), !dbg !268, !call_argsrelate !77
  %acc_s.sroa.0.0.vec.extract3117 = extractelement <4 x float> %169, i64 0, !dbg !269
  %mul1130 = fmul contract float %acc_s.sroa.0.0.vec.extract3117, 0x3FB99999A0000000, !dbg !270
  %170 = tail call contract noundef float @llvm.minnum.f32(float %mul1130, float 0x4024CB5EC0000000), !dbg !271
  %171 = tail call contract noundef float @llvm.exp.f32(float %170), !dbg !273
  %acc_s.sroa.0.4.vec.extract3210 = extractelement <4 x float> %169, i64 1, !dbg !269
  %mul1130.1 = fmul contract float %acc_s.sroa.0.4.vec.extract3210, 0x3FB99999A0000000, !dbg !270
  %172 = tail call contract noundef float @llvm.minnum.f32(float %mul1130.1, float 0x4024CB5EC0000000), !dbg !271
  %173 = tail call contract noundef float @llvm.exp.f32(float %172), !dbg !273
  %acc_s.sroa.0.8.vec.extract3303 = extractelement <4 x float> %169, i64 2, !dbg !269
  %mul1130.2 = fmul contract float %acc_s.sroa.0.8.vec.extract3303, 0x3FB99999A0000000, !dbg !270
  %174 = tail call contract noundef float @llvm.minnum.f32(float %mul1130.2, float 0x4024CB5EC0000000), !dbg !271
  %175 = tail call contract noundef float @llvm.exp.f32(float %174), !dbg !273
  %acc_s.sroa.0.12.vec.extract3396 = extractelement <4 x float> %169, i64 3, !dbg !269
  %mul1130.3 = fmul contract float %acc_s.sroa.0.12.vec.extract3396, 0x3FB99999A0000000, !dbg !270
  %176 = tail call contract noundef float @llvm.minnum.f32(float %mul1130.3, float 0x4024CB5EC0000000), !dbg !271
  %177 = tail call contract noundef float @llvm.exp.f32(float %176), !dbg !273
  %add1146 = fadd contract float %sum_acc.sroa.0.6, %171, !dbg !275
  %add1146.1 = fadd contract float %sum_acc.sroa.20.6, %173, !dbg !275
  %add1146.2 = fadd contract float %sum_acc.sroa.38.6, %175, !dbg !275
  %add1146.3 = fadd contract float %sum_acc.sroa.56.6, %177, !dbg !275
  %178 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %171), !dbg !276
  %gep2516.idx = shl nuw nsw i32 %18, 3, !dbg !280
  %gep2516 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 3584), i32 %gep2516.idx, !dbg !280
  store i16 %178, ptr addrspace(3) %gep2516, align 8, !dbg !281, !tbaa !97
  %179 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %173), !dbg !276
  %gep2516.1 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 3586), i32 %gep2516.idx, !dbg !280
  store i16 %179, ptr addrspace(3) %gep2516.1, align 2, !dbg !281, !tbaa !97
  %180 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %175), !dbg !276
  %gep2516.2 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 3588), i32 %gep2516.idx, !dbg !280
  store i16 %180, ptr addrspace(3) %gep2516.2, align 4, !dbg !281, !tbaa !97
  %181 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %177), !dbg !276
  %gep2516.3 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 3590), i32 %gep2516.idx, !dbg !280
  store i16 %181, ptr addrspace(3) %gep2516.3, align 2, !dbg !281, !tbaa !97
  br label %if.end1168, !dbg !282

if.end1168:                                       ; preds = %if.end1095, %land.lhs.true1063, %if.end1059
  %sum_acc.sroa.56.7 = phi float [ %sum_acc.sroa.56.6, %land.lhs.true1063 ], [ %add1146.3, %if.end1095 ], [ %sum_acc.sroa.56.6, %if.end1059 ], !dbg !75
  %sum_acc.sroa.38.7 = phi float [ %sum_acc.sroa.38.6, %land.lhs.true1063 ], [ %add1146.2, %if.end1095 ], [ %sum_acc.sroa.38.6, %if.end1059 ], !dbg !75
  %sum_acc.sroa.20.7 = phi float [ %sum_acc.sroa.20.6, %land.lhs.true1063 ], [ %add1146.1, %if.end1095 ], [ %sum_acc.sroa.20.6, %if.end1059 ], !dbg !75
  %sum_acc.sroa.0.7 = phi float [ %sum_acc.sroa.0.6, %land.lhs.true1063 ], [ %add1146, %if.end1095 ], [ %sum_acc.sroa.0.6, %if.end1059 ], !dbg !75
  fence syncscope("warp") release, !dbg !283
  tail call void @llvm.mxc.barrier.warp(), !dbg !289
  fence syncscope("warp") acquire, !dbg !290
  br i1 %or.cond2562, label %if.end1226, label %for.cond1203.preheader, !dbg !291

for.cond1203.preheader:                           ; preds = %if.end1168
  %mul1208 = shl nsw i32 %0, 16
  %182 = shl nsw i32 %cond.i.i2416, 10
  %mul1210 = and i32 %182, 64512
  %mul1215 = shl nuw nsw i32 %18, 3
  %add1211 = or disjoint i32 %mul1215, %mul1208
  %add1213 = add nuw nsw i32 %add1211, %mul1210
  %183 = zext nneg i32 %add1213 to i64, !dbg !292
  %add.ptr1218 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %183, !dbg !293
  %V_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr1218, align 16, !dbg !294
  %V_reg.sroa.10.0.add.ptr1218.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1218, i64 8, !dbg !294
  %V_reg.sroa.10.0.copyload = load <4 x half>, ptr addrspace(4) %V_reg.sroa.10.0.add.ptr1218.sroa_idx, align 8, !dbg !294
  %184 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %183, !dbg !293
  %add.ptr1218.1 = getelementptr inbounds i8, ptr addrspace(4) %184, i64 1024, !dbg !293
  %V_reg.sroa.14.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr1218.1, align 16, !dbg !294
  %V_reg.sroa.22.16.add.ptr1218.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %184, i64 1032, !dbg !294
  %V_reg.sroa.22.16.copyload = load <4 x half>, ptr addrspace(4) %V_reg.sroa.22.16.add.ptr1218.1.sroa_idx, align 8, !dbg !294
  br label %if.end1226, !dbg !295

if.end1226:                                       ; preds = %for.cond1203.preheader, %if.end1168
  %V_reg.sroa.22.0 = phi <4 x half> [ undef, %if.end1168 ], [ %V_reg.sroa.22.16.copyload, %for.cond1203.preheader ]
  %V_reg.sroa.14.0 = phi <4 x half> [ undef, %if.end1168 ], [ %V_reg.sroa.14.16.copyload, %for.cond1203.preheader ]
  %V_reg.sroa.10.0 = phi <4 x half> [ undef, %if.end1168 ], [ %V_reg.sroa.10.0.copyload, %for.cond1203.preheader ]
  %V_reg.sroa.0.0 = phi <4 x half> [ undef, %if.end1168 ], [ %V_reg.sroa.0.0.copyload, %for.cond1203.preheader ]
  br i1 %or.cond2564, label %if.end1258, label %for.cond1235.preheader, !dbg !296

for.cond1235.preheader:                           ; preds = %if.end1226
  %mul1240 = shl nsw i32 %0, 16
  %185 = shl nsw i32 %cond.i.i2416.1, 10
  %mul1242 = and i32 %185, 64512
  %mul1247 = shl nuw nsw i32 %18, 3
  %add1243 = or disjoint i32 %mul1247, %mul1240
  %add1245 = add nuw nsw i32 %add1243, %mul1242
  %186 = zext nneg i32 %add1245 to i64, !dbg !297
  %add.ptr1250 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %186, !dbg !298
  %phase_v1.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr1250, align 16, !dbg !299
  %phase_v1.sroa.10.0.add.ptr1250.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1250, i64 8, !dbg !299
  %phase_v1.sroa.10.0.copyload = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.10.0.add.ptr1250.sroa_idx, align 8, !dbg !299
  %187 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %186, !dbg !298
  %add.ptr1250.1 = getelementptr inbounds i8, ptr addrspace(4) %187, i64 1024, !dbg !298
  %phase_v1.sroa.14.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr1250.1, align 16, !dbg !299
  %phase_v1.sroa.22.16.add.ptr1250.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %187, i64 1032, !dbg !299
  %phase_v1.sroa.22.16.copyload = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.22.16.add.ptr1250.1.sroa_idx, align 8, !dbg !299
  br label %if.end1258, !dbg !300

if.end1258:                                       ; preds = %for.cond1235.preheader, %if.end1226
  %phase_v1.sroa.22.0 = phi <4 x half> [ undef, %if.end1226 ], [ %phase_v1.sroa.22.16.copyload, %for.cond1235.preheader ]
  %phase_v1.sroa.14.0 = phi <4 x half> [ undef, %if.end1226 ], [ %phase_v1.sroa.14.16.copyload, %for.cond1235.preheader ]
  %phase_v1.sroa.10.0 = phi <4 x half> [ undef, %if.end1226 ], [ %phase_v1.sroa.10.0.copyload, %for.cond1235.preheader ]
  %phase_v1.sroa.0.0 = phi <4 x half> [ undef, %if.end1226 ], [ %phase_v1.sroa.0.0.copyload, %for.cond1235.preheader ]
  br i1 %or.cond2562, label %if.end1298, label %for.cond1266.preheader, !dbg !300

for.cond1266.preheader:                           ; preds = %if.end1258
  %arrayidx1274.idx = shl nuw nsw i32 %18, 3, !dbg !301
  %arrayidx1274 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %arrayidx1274.idx, !dbg !301
  %188 = load <4 x half>, ptr addrspace(3) %arrayidx1274, align 8, !dbg !302, !tbaa !97
  %189 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0, <4 x half> %188, <4 x float> zeroinitializer), !dbg !303
  %190 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.10.0, <4 x half> %188, <4 x float> zeroinitializer), !dbg !303
  %191 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.14.0, <4 x half> %188, <4 x float> zeroinitializer), !dbg !303
  %192 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.22.0, <4 x half> %188, <4 x float> zeroinitializer), !dbg !303
  br label %if.end1298, !dbg !304

if.end1298:                                       ; preds = %for.cond1266.preheader, %if.end1258
  %acc_o.sroa.98.0 = phi <4 x float> [ zeroinitializer, %if.end1258 ], [ %192, %for.cond1266.preheader ], !dbg !75
  %acc_o.sroa.66.0 = phi <4 x float> [ zeroinitializer, %if.end1258 ], [ %191, %for.cond1266.preheader ], !dbg !75
  %acc_o.sroa.34.0 = phi <4 x float> [ zeroinitializer, %if.end1258 ], [ %190, %for.cond1266.preheader ], !dbg !75
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1258 ], [ %189, %for.cond1266.preheader ], !dbg !75
  br i1 %or.cond2564, label %if.end1339, label %for.cond1306.preheader, !dbg !304

for.cond1306.preheader:                           ; preds = %if.end1298
  %gep2524.idx = shl nuw nsw i32 %18, 3, !dbg !305
  %gep2524 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 512), i32 %gep2524.idx, !dbg !305
  %193 = load <4 x half>, ptr addrspace(3) %gep2524, align 8, !dbg !306, !tbaa !97
  %194 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.0.0, <4 x half> %193, <4 x float> zeroinitializer), !dbg !307
  %195 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.10.0, <4 x half> %193, <4 x float> zeroinitializer), !dbg !307
  %196 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.14.0, <4 x half> %193, <4 x float> zeroinitializer), !dbg !307
  %197 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.22.0, <4 x half> %193, <4 x float> zeroinitializer), !dbg !307
  br label %if.end1339, !dbg !308

if.end1339:                                       ; preds = %for.cond1306.preheader, %if.end1298
  %acc_o_alt.sroa.50.0 = phi <4 x float> [ zeroinitializer, %if.end1298 ], [ %197, %for.cond1306.preheader ], !dbg !75
  %acc_o_alt.sroa.34.0 = phi <4 x float> [ zeroinitializer, %if.end1298 ], [ %196, %for.cond1306.preheader ], !dbg !75
  %acc_o_alt.sroa.18.0 = phi <4 x float> [ zeroinitializer, %if.end1298 ], [ %195, %for.cond1306.preheader ], !dbg !75
  %acc_o_alt.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end1298 ], [ %194, %for.cond1306.preheader ], !dbg !75
  br i1 %or.cond2568, label %if.end1371, label %for.cond1348.preheader, !dbg !309

for.cond1348.preheader:                           ; preds = %if.end1339
  %mul1353 = shl nsw i32 %0, 16
  %198 = shl nsw i32 %cond.i.i2416.2, 10
  %mul1355 = and i32 %198, 64512
  %mul1360 = shl nuw nsw i32 %18, 3
  %add1356 = or disjoint i32 %mul1360, %mul1353
  %add1358 = add nuw nsw i32 %add1356, %mul1355
  %199 = zext nneg i32 %add1358 to i64, !dbg !310
  %add.ptr1363 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %199, !dbg !311
  %V_reg.sroa.0.0.copyload2810 = load <4 x half>, ptr addrspace(4) %add.ptr1363, align 16, !dbg !312
  %V_reg.sroa.10.0.add.ptr1363.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1363, i64 8, !dbg !312
  %V_reg.sroa.10.0.copyload2813 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.10.0.add.ptr1363.sroa_idx, align 8, !dbg !312
  %200 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %199, !dbg !311
  %add.ptr1363.1 = getelementptr inbounds i8, ptr addrspace(4) %200, i64 1024, !dbg !311
  %V_reg.sroa.14.16.copyload2822 = load <4 x half>, ptr addrspace(4) %add.ptr1363.1, align 16, !dbg !312
  %V_reg.sroa.22.16.add.ptr1363.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %200, i64 1032, !dbg !312
  %V_reg.sroa.22.16.copyload2825 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.22.16.add.ptr1363.1.sroa_idx, align 8, !dbg !312
  br label %if.end1371, !dbg !313

if.end1371:                                       ; preds = %for.cond1348.preheader, %if.end1339
  %V_reg.sroa.22.1 = phi <4 x half> [ %V_reg.sroa.22.0, %if.end1339 ], [ %V_reg.sroa.22.16.copyload2825, %for.cond1348.preheader ]
  %V_reg.sroa.14.1 = phi <4 x half> [ %V_reg.sroa.14.0, %if.end1339 ], [ %V_reg.sroa.14.16.copyload2822, %for.cond1348.preheader ]
  %V_reg.sroa.10.1 = phi <4 x half> [ %V_reg.sroa.10.0, %if.end1339 ], [ %V_reg.sroa.10.0.copyload2813, %for.cond1348.preheader ]
  %V_reg.sroa.0.1 = phi <4 x half> [ %V_reg.sroa.0.0, %if.end1339 ], [ %V_reg.sroa.0.0.copyload2810, %for.cond1348.preheader ]
  br i1 %or.cond2570, label %if.end1403, label %for.cond1380.preheader, !dbg !314

for.cond1380.preheader:                           ; preds = %if.end1371
  %mul1385 = shl nsw i32 %0, 16
  %201 = shl nsw i32 %cond.i.i2416.3, 10
  %mul1387 = and i32 %201, 64512
  %mul1392 = shl nuw nsw i32 %18, 3
  %add1388 = or disjoint i32 %mul1392, %mul1385
  %add1390 = add nuw nsw i32 %add1388, %mul1387
  %202 = zext nneg i32 %add1390 to i64, !dbg !315
  %add.ptr1395 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %202, !dbg !316
  %phase_v1.sroa.0.0.copyload2786 = load <4 x half>, ptr addrspace(4) %add.ptr1395, align 16, !dbg !317
  %phase_v1.sroa.10.0.add.ptr1395.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1395, i64 8, !dbg !317
  %phase_v1.sroa.10.0.copyload2789 = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.10.0.add.ptr1395.sroa_idx, align 8, !dbg !317
  %203 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %202, !dbg !316
  %add.ptr1395.1 = getelementptr inbounds i8, ptr addrspace(4) %203, i64 1024, !dbg !316
  %phase_v1.sroa.14.16.copyload2798 = load <4 x half>, ptr addrspace(4) %add.ptr1395.1, align 16, !dbg !317
  %phase_v1.sroa.22.16.add.ptr1395.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %203, i64 1032, !dbg !317
  %phase_v1.sroa.22.16.copyload2801 = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.22.16.add.ptr1395.1.sroa_idx, align 8, !dbg !317
  br label %if.end1403, !dbg !318

if.end1403:                                       ; preds = %for.cond1380.preheader, %if.end1371
  %phase_v1.sroa.22.1 = phi <4 x half> [ %phase_v1.sroa.22.0, %if.end1371 ], [ %phase_v1.sroa.22.16.copyload2801, %for.cond1380.preheader ]
  %phase_v1.sroa.14.1 = phi <4 x half> [ %phase_v1.sroa.14.0, %if.end1371 ], [ %phase_v1.sroa.14.16.copyload2798, %for.cond1380.preheader ]
  %phase_v1.sroa.10.1 = phi <4 x half> [ %phase_v1.sroa.10.0, %if.end1371 ], [ %phase_v1.sroa.10.0.copyload2789, %for.cond1380.preheader ]
  %phase_v1.sroa.0.1 = phi <4 x half> [ %phase_v1.sroa.0.0, %if.end1371 ], [ %phase_v1.sroa.0.0.copyload2786, %for.cond1380.preheader ]
  br i1 %or.cond2568, label %if.end1444, label %for.cond1411.preheader, !dbg !318

for.cond1411.preheader:                           ; preds = %if.end1403
  %gep2529.idx = shl nuw nsw i32 %18, 3, !dbg !319
  %gep2529 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 1024), i32 %gep2529.idx, !dbg !319
  %204 = load <4 x half>, ptr addrspace(3) %gep2529, align 8, !dbg !320, !tbaa !97
  %205 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.1, <4 x half> %204, <4 x float> %acc_o.sroa.0.0), !dbg !321
  %206 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.10.1, <4 x half> %204, <4 x float> %acc_o.sroa.34.0), !dbg !321
  %207 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.14.1, <4 x half> %204, <4 x float> %acc_o.sroa.66.0), !dbg !321
  %208 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.22.1, <4 x half> %204, <4 x float> %acc_o.sroa.98.0), !dbg !321
  br label %if.end1444, !dbg !322

if.end1444:                                       ; preds = %for.cond1411.preheader, %if.end1403
  %acc_o.sroa.98.1 = phi <4 x float> [ %acc_o.sroa.98.0, %if.end1403 ], [ %208, %for.cond1411.preheader ], !dbg !75
  %acc_o.sroa.66.1 = phi <4 x float> [ %acc_o.sroa.66.0, %if.end1403 ], [ %207, %for.cond1411.preheader ], !dbg !75
  %acc_o.sroa.34.1 = phi <4 x float> [ %acc_o.sroa.34.0, %if.end1403 ], [ %206, %for.cond1411.preheader ], !dbg !75
  %acc_o.sroa.0.1 = phi <4 x float> [ %acc_o.sroa.0.0, %if.end1403 ], [ %205, %for.cond1411.preheader ], !dbg !75
  br i1 %or.cond2570, label %if.end1485, label %for.cond1452.preheader, !dbg !322

for.cond1452.preheader:                           ; preds = %if.end1444
  %gep2532.idx = shl nuw nsw i32 %18, 3, !dbg !323
  %gep2532 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 1536), i32 %gep2532.idx, !dbg !323
  %209 = load <4 x half>, ptr addrspace(3) %gep2532, align 8, !dbg !324, !tbaa !97
  %210 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.0.1, <4 x half> %209, <4 x float> %acc_o_alt.sroa.0.0), !dbg !325
  %211 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.10.1, <4 x half> %209, <4 x float> %acc_o_alt.sroa.18.0), !dbg !325
  %212 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.14.1, <4 x half> %209, <4 x float> %acc_o_alt.sroa.34.0), !dbg !325
  %213 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.22.1, <4 x half> %209, <4 x float> %acc_o_alt.sroa.50.0), !dbg !325
  br label %if.end1485, !dbg !326

if.end1485:                                       ; preds = %for.cond1452.preheader, %if.end1444
  %acc_o_alt.sroa.50.1 = phi <4 x float> [ %acc_o_alt.sroa.50.0, %if.end1444 ], [ %213, %for.cond1452.preheader ], !dbg !75
  %acc_o_alt.sroa.34.1 = phi <4 x float> [ %acc_o_alt.sroa.34.0, %if.end1444 ], [ %212, %for.cond1452.preheader ], !dbg !75
  %acc_o_alt.sroa.18.1 = phi <4 x float> [ %acc_o_alt.sroa.18.0, %if.end1444 ], [ %211, %for.cond1452.preheader ], !dbg !75
  %acc_o_alt.sroa.0.1 = phi <4 x float> [ %acc_o_alt.sroa.0.0, %if.end1444 ], [ %210, %for.cond1452.preheader ], !dbg !75
  br i1 %or.cond2574, label %if.end1517, label %for.cond1494.preheader, !dbg !327

for.cond1494.preheader:                           ; preds = %if.end1485
  %mul1499 = shl nsw i32 %0, 16
  %214 = shl nsw i32 %cond.i.i2416.4, 10
  %mul1501 = and i32 %214, 64512
  %mul1506 = shl nuw nsw i32 %18, 3
  %add1502 = or disjoint i32 %mul1506, %mul1499
  %add1504 = add nuw nsw i32 %add1502, %mul1501
  %215 = zext nneg i32 %add1504 to i64, !dbg !328
  %add.ptr1509 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %215, !dbg !329
  %V_reg.sroa.0.0.copyload2811 = load <4 x half>, ptr addrspace(4) %add.ptr1509, align 16, !dbg !330
  %V_reg.sroa.10.0.add.ptr1509.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1509, i64 8, !dbg !330
  %V_reg.sroa.10.0.copyload2814 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.10.0.add.ptr1509.sroa_idx, align 8, !dbg !330
  %216 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %215, !dbg !329
  %add.ptr1509.1 = getelementptr inbounds i8, ptr addrspace(4) %216, i64 1024, !dbg !329
  %V_reg.sroa.14.16.copyload2823 = load <4 x half>, ptr addrspace(4) %add.ptr1509.1, align 16, !dbg !330
  %V_reg.sroa.22.16.add.ptr1509.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %216, i64 1032, !dbg !330
  %V_reg.sroa.22.16.copyload2826 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.22.16.add.ptr1509.1.sroa_idx, align 8, !dbg !330
  br label %if.end1517, !dbg !331

if.end1517:                                       ; preds = %for.cond1494.preheader, %if.end1485
  %V_reg.sroa.22.2 = phi <4 x half> [ %V_reg.sroa.22.1, %if.end1485 ], [ %V_reg.sroa.22.16.copyload2826, %for.cond1494.preheader ]
  %V_reg.sroa.14.2 = phi <4 x half> [ %V_reg.sroa.14.1, %if.end1485 ], [ %V_reg.sroa.14.16.copyload2823, %for.cond1494.preheader ]
  %V_reg.sroa.10.2 = phi <4 x half> [ %V_reg.sroa.10.1, %if.end1485 ], [ %V_reg.sroa.10.0.copyload2814, %for.cond1494.preheader ]
  %V_reg.sroa.0.2 = phi <4 x half> [ %V_reg.sroa.0.1, %if.end1485 ], [ %V_reg.sroa.0.0.copyload2811, %for.cond1494.preheader ]
  br i1 %or.cond2576, label %if.end1549, label %for.cond1526.preheader, !dbg !332

for.cond1526.preheader:                           ; preds = %if.end1517
  %mul1531 = shl nsw i32 %0, 16
  %217 = shl nsw i32 %cond.i.i2416.5, 10
  %mul1533 = and i32 %217, 64512
  %mul1538 = shl nuw nsw i32 %18, 3
  %add1534 = or disjoint i32 %mul1538, %mul1531
  %add1536 = add nuw nsw i32 %add1534, %mul1533
  %218 = zext nneg i32 %add1536 to i64, !dbg !333
  %add.ptr1541 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %218, !dbg !334
  %phase_v1.sroa.0.0.copyload2787 = load <4 x half>, ptr addrspace(4) %add.ptr1541, align 16, !dbg !335
  %phase_v1.sroa.10.0.add.ptr1541.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1541, i64 8, !dbg !335
  %phase_v1.sroa.10.0.copyload2790 = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.10.0.add.ptr1541.sroa_idx, align 8, !dbg !335
  %219 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %218, !dbg !334
  %add.ptr1541.1 = getelementptr inbounds i8, ptr addrspace(4) %219, i64 1024, !dbg !334
  %phase_v1.sroa.14.16.copyload2799 = load <4 x half>, ptr addrspace(4) %add.ptr1541.1, align 16, !dbg !335
  %phase_v1.sroa.22.16.add.ptr1541.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %219, i64 1032, !dbg !335
  %phase_v1.sroa.22.16.copyload2802 = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.22.16.add.ptr1541.1.sroa_idx, align 8, !dbg !335
  br label %if.end1549, !dbg !336

if.end1549:                                       ; preds = %for.cond1526.preheader, %if.end1517
  %phase_v1.sroa.22.2 = phi <4 x half> [ %phase_v1.sroa.22.1, %if.end1517 ], [ %phase_v1.sroa.22.16.copyload2802, %for.cond1526.preheader ]
  %phase_v1.sroa.14.2 = phi <4 x half> [ %phase_v1.sroa.14.1, %if.end1517 ], [ %phase_v1.sroa.14.16.copyload2799, %for.cond1526.preheader ]
  %phase_v1.sroa.10.2 = phi <4 x half> [ %phase_v1.sroa.10.1, %if.end1517 ], [ %phase_v1.sroa.10.0.copyload2790, %for.cond1526.preheader ]
  %phase_v1.sroa.0.2 = phi <4 x half> [ %phase_v1.sroa.0.1, %if.end1517 ], [ %phase_v1.sroa.0.0.copyload2787, %for.cond1526.preheader ]
  br i1 %or.cond2574, label %if.end1590, label %for.cond1557.preheader, !dbg !336

for.cond1557.preheader:                           ; preds = %if.end1549
  %gep2537.idx = shl nuw nsw i32 %18, 3, !dbg !337
  %gep2537 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %gep2537.idx, !dbg !337
  %220 = load <4 x half>, ptr addrspace(3) %gep2537, align 8, !dbg !338, !tbaa !97
  %221 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.2, <4 x half> %220, <4 x float> %acc_o.sroa.0.1), !dbg !339
  %222 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.10.2, <4 x half> %220, <4 x float> %acc_o.sroa.34.1), !dbg !339
  %223 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.14.2, <4 x half> %220, <4 x float> %acc_o.sroa.66.1), !dbg !339
  %224 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.22.2, <4 x half> %220, <4 x float> %acc_o.sroa.98.1), !dbg !339
  br label %if.end1590, !dbg !340

if.end1590:                                       ; preds = %for.cond1557.preheader, %if.end1549
  %acc_o.sroa.98.2 = phi <4 x float> [ %acc_o.sroa.98.1, %if.end1549 ], [ %224, %for.cond1557.preheader ], !dbg !75
  %acc_o.sroa.66.2 = phi <4 x float> [ %acc_o.sroa.66.1, %if.end1549 ], [ %223, %for.cond1557.preheader ], !dbg !75
  %acc_o.sroa.34.2 = phi <4 x float> [ %acc_o.sroa.34.1, %if.end1549 ], [ %222, %for.cond1557.preheader ], !dbg !75
  %acc_o.sroa.0.2 = phi <4 x float> [ %acc_o.sroa.0.1, %if.end1549 ], [ %221, %for.cond1557.preheader ], !dbg !75
  br i1 %or.cond2576, label %if.end1631, label %for.cond1598.preheader, !dbg !340

for.cond1598.preheader:                           ; preds = %if.end1590
  %gep2540.idx = shl nuw nsw i32 %18, 3, !dbg !341
  %gep2540 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2560), i32 %gep2540.idx, !dbg !341
  %225 = load <4 x half>, ptr addrspace(3) %gep2540, align 8, !dbg !342, !tbaa !97
  %226 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.0.2, <4 x half> %225, <4 x float> %acc_o_alt.sroa.0.1), !dbg !343
  %227 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.10.2, <4 x half> %225, <4 x float> %acc_o_alt.sroa.18.1), !dbg !343
  %228 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.14.2, <4 x half> %225, <4 x float> %acc_o_alt.sroa.34.1), !dbg !343
  %229 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.22.2, <4 x half> %225, <4 x float> %acc_o_alt.sroa.50.1), !dbg !343
  br label %if.end1631, !dbg !344

if.end1631:                                       ; preds = %for.cond1598.preheader, %if.end1590
  %acc_o_alt.sroa.50.2 = phi <4 x float> [ %acc_o_alt.sroa.50.1, %if.end1590 ], [ %229, %for.cond1598.preheader ], !dbg !75
  %acc_o_alt.sroa.34.2 = phi <4 x float> [ %acc_o_alt.sroa.34.1, %if.end1590 ], [ %228, %for.cond1598.preheader ], !dbg !75
  %acc_o_alt.sroa.18.2 = phi <4 x float> [ %acc_o_alt.sroa.18.1, %if.end1590 ], [ %227, %for.cond1598.preheader ], !dbg !75
  %acc_o_alt.sroa.0.2 = phi <4 x float> [ %acc_o_alt.sroa.0.1, %if.end1590 ], [ %226, %for.cond1598.preheader ], !dbg !75
  br i1 %or.cond2580, label %if.end1663, label %for.cond1640.preheader, !dbg !345

for.cond1640.preheader:                           ; preds = %if.end1631
  %mul1645 = shl nsw i32 %0, 16
  %230 = shl nsw i32 %cond.i.i2416.6, 10
  %mul1647 = and i32 %230, 64512
  %mul1652 = shl nuw nsw i32 %18, 3
  %add1648 = or disjoint i32 %mul1652, %mul1645
  %add1650 = add nuw nsw i32 %add1648, %mul1647
  %231 = zext nneg i32 %add1650 to i64, !dbg !346
  %add.ptr1655 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %231, !dbg !347
  %V_reg.sroa.0.0.copyload2812 = load <4 x half>, ptr addrspace(4) %add.ptr1655, align 16, !dbg !348
  %V_reg.sroa.10.0.add.ptr1655.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1655, i64 8, !dbg !348
  %V_reg.sroa.10.0.copyload2815 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.10.0.add.ptr1655.sroa_idx, align 8, !dbg !348
  %232 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %231, !dbg !347
  %add.ptr1655.1 = getelementptr inbounds i8, ptr addrspace(4) %232, i64 1024, !dbg !347
  %V_reg.sroa.14.16.copyload2824 = load <4 x half>, ptr addrspace(4) %add.ptr1655.1, align 16, !dbg !348
  %V_reg.sroa.22.16.add.ptr1655.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %232, i64 1032, !dbg !348
  %V_reg.sroa.22.16.copyload2827 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.22.16.add.ptr1655.1.sroa_idx, align 8, !dbg !348
  br label %if.end1663, !dbg !349

if.end1663:                                       ; preds = %for.cond1640.preheader, %if.end1631
  %V_reg.sroa.22.3 = phi <4 x half> [ %V_reg.sroa.22.2, %if.end1631 ], [ %V_reg.sroa.22.16.copyload2827, %for.cond1640.preheader ]
  %V_reg.sroa.14.3 = phi <4 x half> [ %V_reg.sroa.14.2, %if.end1631 ], [ %V_reg.sroa.14.16.copyload2824, %for.cond1640.preheader ]
  %V_reg.sroa.10.3 = phi <4 x half> [ %V_reg.sroa.10.2, %if.end1631 ], [ %V_reg.sroa.10.0.copyload2815, %for.cond1640.preheader ]
  %V_reg.sroa.0.3 = phi <4 x half> [ %V_reg.sroa.0.2, %if.end1631 ], [ %V_reg.sroa.0.0.copyload2812, %for.cond1640.preheader ]
  br i1 %or.cond2582, label %if.end1695, label %for.cond1672.preheader, !dbg !350

for.cond1672.preheader:                           ; preds = %if.end1663
  %mul1677 = shl nsw i32 %0, 16
  %233 = shl nsw i32 %cond.i.i2416.7, 10
  %mul1679 = and i32 %233, 64512
  %mul1684 = shl nuw nsw i32 %18, 3
  %add1680 = or disjoint i32 %mul1684, %mul1677
  %add1682 = add nuw nsw i32 %add1680, %mul1679
  %234 = zext nneg i32 %add1682 to i64, !dbg !351
  %add.ptr1687 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %234, !dbg !352
  %phase_v1.sroa.0.0.copyload2788 = load <4 x half>, ptr addrspace(4) %add.ptr1687, align 16, !dbg !353
  %phase_v1.sroa.10.0.add.ptr1687.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr1687, i64 8, !dbg !353
  %phase_v1.sroa.10.0.copyload2791 = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.10.0.add.ptr1687.sroa_idx, align 8, !dbg !353
  %235 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %234, !dbg !352
  %add.ptr1687.1 = getelementptr inbounds i8, ptr addrspace(4) %235, i64 1024, !dbg !352
  %phase_v1.sroa.14.16.copyload2800 = load <4 x half>, ptr addrspace(4) %add.ptr1687.1, align 16, !dbg !353
  %phase_v1.sroa.22.16.add.ptr1687.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %235, i64 1032, !dbg !353
  %phase_v1.sroa.22.16.copyload2803 = load <4 x half>, ptr addrspace(4) %phase_v1.sroa.22.16.add.ptr1687.1.sroa_idx, align 8, !dbg !353
  br label %if.end1695, !dbg !354

if.end1695:                                       ; preds = %for.cond1672.preheader, %if.end1663
  %phase_v1.sroa.22.3 = phi <4 x half> [ %phase_v1.sroa.22.2, %if.end1663 ], [ %phase_v1.sroa.22.16.copyload2803, %for.cond1672.preheader ]
  %phase_v1.sroa.14.3 = phi <4 x half> [ %phase_v1.sroa.14.2, %if.end1663 ], [ %phase_v1.sroa.14.16.copyload2800, %for.cond1672.preheader ]
  %phase_v1.sroa.10.3 = phi <4 x half> [ %phase_v1.sroa.10.2, %if.end1663 ], [ %phase_v1.sroa.10.0.copyload2791, %for.cond1672.preheader ]
  %phase_v1.sroa.0.3 = phi <4 x half> [ %phase_v1.sroa.0.2, %if.end1663 ], [ %phase_v1.sroa.0.0.copyload2788, %for.cond1672.preheader ]
  br i1 %or.cond2580, label %if.end1736, label %for.cond1703.preheader, !dbg !354

for.cond1703.preheader:                           ; preds = %if.end1695
  %gep2545.idx = shl nuw nsw i32 %18, 3, !dbg !355
  %gep2545 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 3072), i32 %gep2545.idx, !dbg !355
  %236 = load <4 x half>, ptr addrspace(3) %gep2545, align 8, !dbg !356, !tbaa !97
  %237 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.3, <4 x half> %236, <4 x float> %acc_o.sroa.0.2), !dbg !357
  %238 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.10.3, <4 x half> %236, <4 x float> %acc_o.sroa.34.2), !dbg !357
  %239 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.14.3, <4 x half> %236, <4 x float> %acc_o.sroa.66.2), !dbg !357
  %240 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.22.3, <4 x half> %236, <4 x float> %acc_o.sroa.98.2), !dbg !357
  br label %if.end1736, !dbg !358

if.end1736:                                       ; preds = %for.cond1703.preheader, %if.end1695
  %acc_o.sroa.98.3 = phi <4 x float> [ %acc_o.sroa.98.2, %if.end1695 ], [ %240, %for.cond1703.preheader ], !dbg !75
  %acc_o.sroa.66.3 = phi <4 x float> [ %acc_o.sroa.66.2, %if.end1695 ], [ %239, %for.cond1703.preheader ], !dbg !75
  %acc_o.sroa.34.3 = phi <4 x float> [ %acc_o.sroa.34.2, %if.end1695 ], [ %238, %for.cond1703.preheader ], !dbg !75
  %acc_o.sroa.0.3 = phi <4 x float> [ %acc_o.sroa.0.2, %if.end1695 ], [ %237, %for.cond1703.preheader ], !dbg !75
  %.pre = shl nuw nsw i32 %18, 3
  br i1 %or.cond2582, label %if.end1777, label %for.cond1744.preheader, !dbg !358

for.cond1744.preheader:                           ; preds = %if.end1736
  %gep2548 = getelementptr inbounds i8, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 3584), i32 %.pre, !dbg !359
  %241 = load <4 x half>, ptr addrspace(3) %gep2548, align 8, !dbg !360, !tbaa !97
  %242 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.0.3, <4 x half> %241, <4 x float> %acc_o_alt.sroa.0.2), !dbg !361
  %243 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.10.3, <4 x half> %241, <4 x float> %acc_o_alt.sroa.18.2), !dbg !361
  %244 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.14.3, <4 x half> %241, <4 x float> %acc_o_alt.sroa.34.2), !dbg !361
  %245 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %phase_v1.sroa.22.3, <4 x half> %241, <4 x float> %acc_o_alt.sroa.50.2), !dbg !361
  br label %if.end1777, !dbg !362

if.end1777:                                       ; preds = %if.end1736, %for.cond1744.preheader
  %acc_o_alt.sroa.50.3 = phi <4 x float> [ %245, %for.cond1744.preheader ], [ %acc_o_alt.sroa.50.2, %if.end1736 ], !dbg !75
  %acc_o_alt.sroa.34.3 = phi <4 x float> [ %244, %for.cond1744.preheader ], [ %acc_o_alt.sroa.34.2, %if.end1736 ], !dbg !75
  %acc_o_alt.sroa.18.3 = phi <4 x float> [ %243, %for.cond1744.preheader ], [ %acc_o_alt.sroa.18.2, %if.end1736 ], !dbg !75
  %acc_o_alt.sroa.0.3 = phi <4 x float> [ %242, %for.cond1744.preheader ], [ %acc_o_alt.sroa.0.2, %if.end1736 ], !dbg !75
  fence syncscope("warp") release, !dbg !362
  tail call void @llvm.mxc.barrier.warp(), !dbg !365
  fence syncscope("warp") acquire, !dbg !366
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 0, !dbg !367
  %acc_o_alt.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 0, !dbg !368
  %add1786 = fadd contract float %acc_o.sroa.0.0.vec.extract, %acc_o_alt.sroa.0.0.vec.extract, !dbg !369
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 1, !dbg !367
  %acc_o_alt.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 1, !dbg !368
  %add1786.1 = fadd contract float %acc_o.sroa.0.4.vec.extract, %acc_o_alt.sroa.0.4.vec.extract, !dbg !369
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 2, !dbg !367
  %acc_o_alt.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 2, !dbg !368
  %add1786.2 = fadd contract float %acc_o.sroa.0.8.vec.extract, %acc_o_alt.sroa.0.8.vec.extract, !dbg !369
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 3, !dbg !367
  %acc_o_alt.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 3, !dbg !368
  %add1786.3 = fadd contract float %acc_o.sroa.0.12.vec.extract, %acc_o_alt.sroa.0.12.vec.extract, !dbg !369
  %acc_o.sroa.34.16.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 0, !dbg !367
  %acc_o_alt.sroa.18.16.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 0, !dbg !368
  %add1786.4 = fadd contract float %acc_o.sroa.34.16.vec.extract, %acc_o_alt.sroa.18.16.vec.extract, !dbg !369
  %acc_o.sroa.34.20.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 1, !dbg !367
  %acc_o_alt.sroa.18.20.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 1, !dbg !368
  %add1786.5 = fadd contract float %acc_o.sroa.34.20.vec.extract, %acc_o_alt.sroa.18.20.vec.extract, !dbg !369
  %acc_o.sroa.34.24.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 2, !dbg !367
  %acc_o_alt.sroa.18.24.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 2, !dbg !368
  %add1786.6 = fadd contract float %acc_o.sroa.34.24.vec.extract, %acc_o_alt.sroa.18.24.vec.extract, !dbg !369
  %acc_o.sroa.34.28.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 3, !dbg !367
  %acc_o_alt.sroa.18.28.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 3, !dbg !368
  %add1786.7 = fadd contract float %acc_o.sroa.34.28.vec.extract, %acc_o_alt.sroa.18.28.vec.extract, !dbg !369
  %acc_o.sroa.66.32.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 0, !dbg !367
  %acc_o_alt.sroa.34.32.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 0, !dbg !368
  %add1786.8 = fadd contract float %acc_o.sroa.66.32.vec.extract, %acc_o_alt.sroa.34.32.vec.extract, !dbg !369
  %acc_o.sroa.66.36.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 1, !dbg !367
  %acc_o_alt.sroa.34.36.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 1, !dbg !368
  %add1786.9 = fadd contract float %acc_o.sroa.66.36.vec.extract, %acc_o_alt.sroa.34.36.vec.extract, !dbg !369
  %acc_o.sroa.66.40.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 2, !dbg !367
  %acc_o_alt.sroa.34.40.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 2, !dbg !368
  %add1786.10 = fadd contract float %acc_o.sroa.66.40.vec.extract, %acc_o_alt.sroa.34.40.vec.extract, !dbg !369
  %acc_o.sroa.66.44.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 3, !dbg !367
  %acc_o_alt.sroa.34.44.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 3, !dbg !368
  %add1786.11 = fadd contract float %acc_o.sroa.66.44.vec.extract, %acc_o_alt.sroa.34.44.vec.extract, !dbg !369
  %acc_o.sroa.98.48.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 0, !dbg !367
  %acc_o_alt.sroa.50.48.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 0, !dbg !368
  %add1786.12 = fadd contract float %acc_o.sroa.98.48.vec.extract, %acc_o_alt.sroa.50.48.vec.extract, !dbg !369
  %acc_o.sroa.98.52.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 1, !dbg !367
  %acc_o_alt.sroa.50.52.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 1, !dbg !368
  %add1786.13 = fadd contract float %acc_o.sroa.98.52.vec.extract, %acc_o_alt.sroa.50.52.vec.extract, !dbg !369
  %acc_o.sroa.98.56.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 2, !dbg !367
  %acc_o_alt.sroa.50.56.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 2, !dbg !368
  %add1786.14 = fadd contract float %acc_o.sroa.98.56.vec.extract, %acc_o_alt.sroa.50.56.vec.extract, !dbg !369
  %acc_o.sroa.98.60.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 3, !dbg !367
  %acc_o_alt.sroa.50.60.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 3, !dbg !368
  %add1786.15 = fadd contract float %acc_o.sroa.98.60.vec.extract, %acc_o_alt.sroa.50.60.vec.extract, !dbg !369
  %add1800 = fadd contract float %sum_acc.sroa.0.7, 0.000000e+00, !dbg !370
  %add1800.1 = fadd contract float %add1800, %sum_acc.sroa.20.7, !dbg !370
  %add1800.2 = fadd contract float %add1800.1, %sum_acc.sroa.38.7, !dbg !370
  %add1800.3 = fadd contract float %add1800.2, %sum_acc.sroa.56.7, !dbg !370
  %246 = bitcast float %add1800.3 to i32, !dbg !371
  %247 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !382
  %248 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %247) #11, !dbg !387
  %xor.i.i = xor i32 %248, 32, !dbg !388
  %249 = and i32 %248, -64, !dbg !389
  %and.i.i = add nsw i32 %249, 64, !dbg !389
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !390
  %cond.i.i2417 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %248, !dbg !391
  %shl.i.i = shl i32 %cond.i.i2417, 2, !dbg !392
  %250 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %246), !dbg !393
  %251 = bitcast i32 %250 to float, !dbg !394
  %add.i = fadd contract float %add1800.3, %251, !dbg !395
  %252 = bitcast float %add.i to i32, !dbg !398
  %253 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !405
  %254 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %253) #11, !dbg !408
  %xor.i.i2418 = xor i32 %254, 16, !dbg !409
  %255 = and i32 %254, -64, !dbg !410
  %and.i.i2419 = add nsw i32 %255, 64, !dbg !410
  %cmp.not.i.i2420 = icmp slt i32 %xor.i.i2418, %and.i.i2419, !dbg !411
  %cond.i.i2421 = select i1 %cmp.not.i.i2420, i32 %xor.i.i2418, i32 %254, !dbg !412
  %shl.i.i2422 = shl i32 %cond.i.i2421, 2, !dbg !413
  %256 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i2422, i32 %252), !dbg !414
  %257 = bitcast i32 %256 to float, !dbg !415
  %add.i.i = fadd contract float %add.i, %257, !dbg !416
  %cmp1809 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !418
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !419
  %condval_8.0 = select i1 %cmp1809, float %div, float 0.000000e+00, !dbg !419
  %mul1822 = fmul contract float %condval_8.0, %add1786, !dbg !420
  %mul1822.1 = fmul contract float %condval_8.0, %add1786.1, !dbg !420
  %mul1822.2 = fmul contract float %condval_8.0, %add1786.2, !dbg !420
  %mul1822.3 = fmul contract float %condval_8.0, %add1786.3, !dbg !420
  %mul1822.4 = fmul contract float %condval_8.0, %add1786.4, !dbg !420
  %mul1822.5 = fmul contract float %condval_8.0, %add1786.5, !dbg !420
  %mul1822.6 = fmul contract float %condval_8.0, %add1786.6, !dbg !420
  %mul1822.7 = fmul contract float %condval_8.0, %add1786.7, !dbg !420
  %mul1822.8 = fmul contract float %condval_8.0, %add1786.8, !dbg !420
  %mul1822.9 = fmul contract float %condval_8.0, %add1786.9, !dbg !420
  %mul1822.10 = fmul contract float %condval_8.0, %add1786.10, !dbg !420
  %mul1822.11 = fmul contract float %condval_8.0, %add1786.11, !dbg !420
  %mul1822.12 = fmul contract float %condval_8.0, %add1786.12, !dbg !420
  %mul1822.13 = fmul contract float %condval_8.0, %add1786.13, !dbg !420
  %mul1822.14 = fmul contract float %condval_8.0, %add1786.14, !dbg !420
  %mul1822.15 = fmul contract float %condval_8.0, %add1786.15, !dbg !420
  %258 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822), !dbg !421
  %O_reg.sroa.0.0.insert.ext = zext i16 %258 to i64, !dbg !425
  %259 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822.1), !dbg !421
  %O_reg.sroa.0.2.insert.ext = zext i16 %259 to i64, !dbg !425
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !425
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !425
  %260 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822.2), !dbg !421
  %O_reg.sroa.0.4.insert.ext = zext i16 %260 to i64, !dbg !425
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !425
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !425
  %261 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822.3), !dbg !421
  %O_reg.sroa.0.6.insert.ext = zext i16 %261 to i64, !dbg !425
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !425
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !425
  %262 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822.4), !dbg !421
  %O_reg.sroa.7.8.insert.ext = zext i16 %262 to i64, !dbg !425
  %263 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822.5), !dbg !421
  %O_reg.sroa.7.10.insert.ext = zext i16 %263 to i64, !dbg !425
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !425
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !425
  %264 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822.6), !dbg !421
  %O_reg.sroa.7.12.insert.ext = zext i16 %264 to i64, !dbg !425
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !425
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !425
  %265 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822.7), !dbg !421
  %O_reg.sroa.7.14.insert.ext = zext i16 %265 to i64, !dbg !425
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !425
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !425
  %266 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822.8), !dbg !421
  %O_reg.sroa.12.16.insert.ext = zext i16 %266 to i64, !dbg !425
  %267 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822.9), !dbg !421
  %O_reg.sroa.12.18.insert.ext = zext i16 %267 to i64, !dbg !425
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !425
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !425
  %268 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822.10), !dbg !421
  %O_reg.sroa.12.20.insert.ext = zext i16 %268 to i64, !dbg !425
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !425
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !425
  %269 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822.11), !dbg !421
  %O_reg.sroa.12.22.insert.ext = zext i16 %269 to i64, !dbg !425
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !425
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !425
  %270 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822.12), !dbg !421
  %O_reg.sroa.17.24.insert.ext = zext i16 %270 to i64, !dbg !425
  %271 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822.13), !dbg !421
  %O_reg.sroa.17.26.insert.ext = zext i16 %271 to i64, !dbg !425
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !425
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !425
  %272 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822.14), !dbg !421
  %O_reg.sroa.17.28.insert.ext = zext i16 %272 to i64, !dbg !425
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !425
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !425
  %273 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul1822.15), !dbg !421
  %O_reg.sroa.17.30.insert.ext = zext i16 %273 to i64, !dbg !425
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !425
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !425
  %shr1864 = lshr i32 %18, 5
  %and1867 = and i32 %18, 7
  %274 = lshr i32 %18, 2
  %mul1873 = and i32 %274, 4
  %xor = xor i32 %shr1864, %and1867, !dbg !426
  %mul1868 = shl nuw nsw i32 %xor, 3, !dbg !427
  %add1869 = add nuw nsw i32 %mul1868, %mul25, !dbg !428
  %add1874 = or disjoint i32 %add1869, %mul1873, !dbg !429
  %add.ptr1876 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1874, !dbg !430
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr1876, align 8, !dbg !431
  %add1865.1 = add nuw nsw i32 %shr1864, 2, !dbg !432
  %xor.1 = xor i32 %add1865.1, %and1867, !dbg !426
  %mul1868.1 = shl nuw nsw i32 %xor.1, 3, !dbg !427
  %add1869.1 = add nuw nsw i32 %mul1868.1, %mul25, !dbg !428
  %add1874.1 = or disjoint i32 %add1869.1, %mul1873, !dbg !429
  %add.ptr1876.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1874.1, !dbg !430
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr1876.1, align 8, !dbg !431
  %add1865.2 = add nuw nsw i32 %shr1864, 4, !dbg !432
  %xor.2 = xor i32 %add1865.2, %and1867, !dbg !426
  %mul1868.2 = shl nuw nsw i32 %xor.2, 3, !dbg !427
  %add1869.2 = add nuw nsw i32 %mul1868.2, %mul25, !dbg !428
  %add1874.2 = or disjoint i32 %add1869.2, %mul1873, !dbg !429
  %add.ptr1876.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1874.2, !dbg !430
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr1876.2, align 8, !dbg !431
  %add1865.3 = add nuw nsw i32 %shr1864, 6, !dbg !432
  %xor.3 = xor i32 %add1865.3, %and1867, !dbg !426
  %mul1868.3 = shl nuw nsw i32 %xor.3, 3, !dbg !427
  %add1869.3 = add nuw nsw i32 %mul1868.3, %mul25, !dbg !428
  %add1874.3 = or disjoint i32 %add1869.3, %mul1873, !dbg !429
  %add.ptr1876.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add1874.3, !dbg !430
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr1876.3, align 8, !dbg !431
  fence syncscope("warp") release, !dbg !433
  tail call void @llvm.mxc.barrier.warp(), !dbg !436
  fence syncscope("warp") acquire, !dbg !437
  %mul1887 = and i32 %.pre, 8128
  %xor18932399 = and i32 %.pre, 56
  %call1891.masked = and i32 %18, 1016
  %mul1894 = xor i32 %xor18932399, %call1891.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul1887, !dbg !438
  %invariant.gep2559 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul1894, !dbg !438
  %add1904 = add nuw nsw i32 %add23, %.pre
  %275 = zext nneg i32 %add1904 to i64, !dbg !439
  %add.ptr1909 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %275, !dbg !440
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1909, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep2559, i64 16, i1 false), !dbg !441, !tbaa.struct !442, !call_argsrelate !443
  %gep2560.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep2559, i32 1024, !dbg !444
  %276 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %275, !dbg !440
  %add.ptr1909.1 = getelementptr inbounds i8, ptr addrspace(1) %276, i64 1024, !dbg !440
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr1909.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep2560.1, i64 16, i1 false), !dbg !441, !tbaa.struct !442, !call_argsrelate !443
  ret void, !dbg !445
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
!1 = !DIFile(filename: "/tmp/tmp0bs752wz/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmp0bs752wz/tvm_kernels.maca", directory: "")
!42 = !DILocation(line: 27, column: 3, scope: !40)
!43 = !DILocation(line: 28, column: 21, scope: !40)
!44 = !DILocation(line: 705, column: 10, scope: !45, inlinedAt: !47)
!45 = distinct !DISubprogram(name: "max", scope: !46, file: !46, line: 704, type: !7, scopeLine: 704, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!46 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!47 = distinct !DILocation(line: 29, column: 24, scope: !40)
!48 = !{i32 0, i32 -1}
!49 = !DILocation(line: 708, column: 10, scope: !50, inlinedAt: !51)
!50 = distinct !DISubprogram(name: "min", scope: !46, file: !46, line: 707, type: !7, scopeLine: 707, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!51 = distinct !DILocation(line: 29, column: 20, scope: !40)
!52 = !DILocation(line: 29, column: 48, scope: !40)
!53 = !DILocation(line: 28, column: 90, scope: !40)
!54 = !{i32 0, i32 1024}
!55 = !DILocation(line: 32, column: 3, scope: !40)
!56 = !DILocation(line: 33, column: 46, scope: !40)
!57 = !DILocation(line: 33, column: 32, scope: !40)
!58 = !DILocation(line: 39, column: 33, scope: !40)
!59 = !DILocation(line: 41, column: 5, scope: !40)
!60 = !DILocation(line: 42, column: 50, scope: !40)
!61 = !DILocation(line: 42, column: 36, scope: !40)
!62 = !DILocation(line: 45, column: 27, scope: !40)
!63 = !DILocation(line: 46, column: 33, scope: !40)
!64 = !DILocation(line: 48, column: 5, scope: !40)
!65 = !DILocation(line: 49, column: 51, scope: !40)
!66 = !DILocation(line: 49, column: 37, scope: !40)
!67 = !DILocation(line: 52, column: 33, scope: !40)
!68 = !DILocation(line: 52, column: 7, scope: !40)
!69 = !DILocation(line: 53, column: 48, scope: !40)
!70 = !DILocation(line: 53, column: 27, scope: !40)
!71 = !DILocation(line: 53, column: 9, scope: !40)
!72 = !DILocation(line: 57, column: 76, scope: !40)
!73 = !DILocation(line: 62, column: 20, scope: !40)
!74 = !DILocation(line: 57, column: 69, scope: !40)
!75 = !DILocation(line: 0, scope: !40)
!76 = !DILocation(line: 71, column: 36, scope: !40)
!77 = !{i32 -1, i32 3, i32 -1}
!78 = !DILocation(line: 79, column: 30, scope: !40)
!79 = !DILocation(line: 79, column: 41, scope: !40)
!80 = !DILocation(line: 354, column: 10, scope: !81, inlinedAt: !82)
!81 = distinct !DISubprogram(name: "min", scope: !46, file: !46, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!82 = distinct !DILocation(line: 79, column: 25, scope: !40)
!83 = !DILocation(line: 288, column: 10, scope: !84, inlinedAt: !85)
!84 = distinct !DISubprogram(name: "expf", scope: !46, file: !46, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!85 = distinct !DILocation(line: 79, column: 20, scope: !40)
!86 = !DILocation(line: 75, column: 10, scope: !87, inlinedAt: !89)
!87 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !88, file: !88, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!88 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!89 = distinct !DILocation(line: 984, column: 9, scope: !90, inlinedAt: !92)
!90 = distinct !DISubprogram(name: "__float2half", scope: !91, file: !91, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!91 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!92 = distinct !DILocation(line: 133, column: 53, scope: !93, inlinedAt: !94)
!93 = distinct !DISubprogram(name: "__half", scope: !91, file: !91, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!94 = distinct !DILocation(line: 87, column: 76, scope: !40)
!95 = !DILocation(line: 87, column: 7, scope: !40)
!96 = !DILocation(line: 87, column: 73, scope: !40)
!97 = !{!26, !26, i64 0}
!98 = !DILocation(line: 90, column: 33, scope: !40)
!99 = !DILocation(line: 90, column: 7, scope: !40)
!100 = !DILocation(line: 91, column: 48, scope: !40)
!101 = !DILocation(line: 91, column: 27, scope: !40)
!102 = !DILocation(line: 91, column: 9, scope: !40)
!103 = !DILocation(line: 95, column: 76, scope: !40)
!104 = !DILocation(line: 100, column: 20, scope: !40)
!105 = !DILocation(line: 95, column: 69, scope: !40)
!106 = !DILocation(line: 109, column: 36, scope: !40)
!107 = !DILocation(line: 117, column: 30, scope: !40)
!108 = !DILocation(line: 117, column: 41, scope: !40)
!109 = !DILocation(line: 354, column: 10, scope: !81, inlinedAt: !110)
!110 = distinct !DILocation(line: 117, column: 25, scope: !40)
!111 = !DILocation(line: 288, column: 10, scope: !84, inlinedAt: !112)
!112 = distinct !DILocation(line: 117, column: 20, scope: !40)
!113 = !DILocation(line: 121, column: 36, scope: !40)
!114 = !DILocation(line: 75, column: 10, scope: !87, inlinedAt: !115)
!115 = distinct !DILocation(line: 984, column: 9, scope: !90, inlinedAt: !116)
!116 = distinct !DILocation(line: 133, column: 53, scope: !93, inlinedAt: !117)
!117 = distinct !DILocation(line: 125, column: 86, scope: !40)
!118 = !DILocation(line: 125, column: 7, scope: !40)
!119 = !DILocation(line: 125, column: 83, scope: !40)
!120 = !DILocation(line: 128, column: 27, scope: !40)
!121 = !DILocation(line: 129, column: 33, scope: !40)
!122 = !DILocation(line: 131, column: 5, scope: !40)
!123 = !DILocation(line: 132, column: 50, scope: !40)
!124 = !DILocation(line: 132, column: 36, scope: !40)
!125 = !DILocation(line: 135, column: 27, scope: !40)
!126 = !DILocation(line: 136, column: 33, scope: !40)
!127 = !DILocation(line: 138, column: 5, scope: !40)
!128 = !DILocation(line: 139, column: 52, scope: !40)
!129 = !DILocation(line: 139, column: 38, scope: !40)
!130 = !DILocation(line: 142, column: 33, scope: !40)
!131 = !DILocation(line: 142, column: 7, scope: !40)
!132 = !DILocation(line: 143, column: 48, scope: !40)
!133 = !DILocation(line: 143, column: 27, scope: !40)
!134 = !DILocation(line: 143, column: 9, scope: !40)
!135 = !DILocation(line: 147, column: 77, scope: !40)
!136 = !DILocation(line: 152, column: 21, scope: !40)
!137 = !DILocation(line: 147, column: 69, scope: !40)
!138 = !DILocation(line: 161, column: 36, scope: !40)
!139 = !DILocation(line: 169, column: 31, scope: !40)
!140 = !DILocation(line: 169, column: 43, scope: !40)
!141 = !DILocation(line: 354, column: 10, scope: !81, inlinedAt: !142)
!142 = distinct !DILocation(line: 169, column: 26, scope: !40)
!143 = !DILocation(line: 288, column: 10, scope: !84, inlinedAt: !144)
!144 = distinct !DILocation(line: 169, column: 21, scope: !40)
!145 = !DILocation(line: 173, column: 38, scope: !40)
!146 = !DILocation(line: 75, column: 10, scope: !87, inlinedAt: !147)
!147 = distinct !DILocation(line: 984, column: 9, scope: !90, inlinedAt: !148)
!148 = distinct !DILocation(line: 133, column: 53, scope: !93, inlinedAt: !149)
!149 = distinct !DILocation(line: 177, column: 86, scope: !40)
!150 = !DILocation(line: 177, column: 7, scope: !40)
!151 = !DILocation(line: 177, column: 83, scope: !40)
!152 = !DILocation(line: 180, column: 33, scope: !40)
!153 = !DILocation(line: 180, column: 7, scope: !40)
!154 = !DILocation(line: 181, column: 48, scope: !40)
!155 = !DILocation(line: 181, column: 27, scope: !40)
!156 = !DILocation(line: 181, column: 9, scope: !40)
!157 = !DILocation(line: 185, column: 77, scope: !40)
!158 = !DILocation(line: 190, column: 21, scope: !40)
!159 = !DILocation(line: 185, column: 69, scope: !40)
!160 = !DILocation(line: 199, column: 36, scope: !40)
!161 = !DILocation(line: 207, column: 31, scope: !40)
!162 = !DILocation(line: 207, column: 43, scope: !40)
!163 = !DILocation(line: 354, column: 10, scope: !81, inlinedAt: !164)
!164 = distinct !DILocation(line: 207, column: 26, scope: !40)
!165 = !DILocation(line: 288, column: 10, scope: !84, inlinedAt: !166)
!166 = distinct !DILocation(line: 207, column: 21, scope: !40)
!167 = !DILocation(line: 211, column: 38, scope: !40)
!168 = !DILocation(line: 75, column: 10, scope: !87, inlinedAt: !169)
!169 = distinct !DILocation(line: 984, column: 9, scope: !90, inlinedAt: !170)
!170 = distinct !DILocation(line: 133, column: 53, scope: !93, inlinedAt: !171)
!171 = distinct !DILocation(line: 215, column: 86, scope: !40)
!172 = !DILocation(line: 215, column: 7, scope: !40)
!173 = !DILocation(line: 215, column: 83, scope: !40)
!174 = !DILocation(line: 218, column: 27, scope: !40)
!175 = !DILocation(line: 219, column: 33, scope: !40)
!176 = !DILocation(line: 221, column: 5, scope: !40)
!177 = !DILocation(line: 222, column: 51, scope: !40)
!178 = !DILocation(line: 222, column: 37, scope: !40)
!179 = !DILocation(line: 225, column: 27, scope: !40)
!180 = !DILocation(line: 226, column: 33, scope: !40)
!181 = !DILocation(line: 228, column: 5, scope: !40)
!182 = !DILocation(line: 229, column: 52, scope: !40)
!183 = !DILocation(line: 229, column: 38, scope: !40)
!184 = !DILocation(line: 232, column: 33, scope: !40)
!185 = !DILocation(line: 232, column: 7, scope: !40)
!186 = !DILocation(line: 233, column: 48, scope: !40)
!187 = !DILocation(line: 233, column: 27, scope: !40)
!188 = !DILocation(line: 233, column: 9, scope: !40)
!189 = !DILocation(line: 237, column: 77, scope: !40)
!190 = !DILocation(line: 242, column: 21, scope: !40)
!191 = !DILocation(line: 237, column: 69, scope: !40)
!192 = !DILocation(line: 251, column: 36, scope: !40)
!193 = !DILocation(line: 259, column: 31, scope: !40)
!194 = !DILocation(line: 259, column: 43, scope: !40)
!195 = !DILocation(line: 354, column: 10, scope: !81, inlinedAt: !196)
!196 = distinct !DILocation(line: 259, column: 26, scope: !40)
!197 = !DILocation(line: 288, column: 10, scope: !84, inlinedAt: !198)
!198 = distinct !DILocation(line: 259, column: 21, scope: !40)
!199 = !DILocation(line: 263, column: 38, scope: !40)
!200 = !DILocation(line: 75, column: 10, scope: !87, inlinedAt: !201)
!201 = distinct !DILocation(line: 984, column: 9, scope: !90, inlinedAt: !202)
!202 = distinct !DILocation(line: 133, column: 53, scope: !93, inlinedAt: !203)
!203 = distinct !DILocation(line: 267, column: 87, scope: !40)
!204 = !DILocation(line: 267, column: 7, scope: !40)
!205 = !DILocation(line: 267, column: 84, scope: !40)
!206 = !DILocation(line: 270, column: 33, scope: !40)
!207 = !DILocation(line: 270, column: 7, scope: !40)
!208 = !DILocation(line: 271, column: 48, scope: !40)
!209 = !DILocation(line: 271, column: 27, scope: !40)
!210 = !DILocation(line: 271, column: 9, scope: !40)
!211 = !DILocation(line: 275, column: 77, scope: !40)
!212 = !DILocation(line: 280, column: 21, scope: !40)
!213 = !DILocation(line: 275, column: 69, scope: !40)
!214 = !DILocation(line: 289, column: 36, scope: !40)
!215 = !DILocation(line: 297, column: 31, scope: !40)
!216 = !DILocation(line: 297, column: 43, scope: !40)
!217 = !DILocation(line: 354, column: 10, scope: !81, inlinedAt: !218)
!218 = distinct !DILocation(line: 297, column: 26, scope: !40)
!219 = !DILocation(line: 288, column: 10, scope: !84, inlinedAt: !220)
!220 = distinct !DILocation(line: 297, column: 21, scope: !40)
!221 = !DILocation(line: 301, column: 38, scope: !40)
!222 = !DILocation(line: 75, column: 10, scope: !87, inlinedAt: !223)
!223 = distinct !DILocation(line: 984, column: 9, scope: !90, inlinedAt: !224)
!224 = distinct !DILocation(line: 133, column: 53, scope: !93, inlinedAt: !225)
!225 = distinct !DILocation(line: 305, column: 87, scope: !40)
!226 = !DILocation(line: 305, column: 7, scope: !40)
!227 = !DILocation(line: 305, column: 84, scope: !40)
!228 = !DILocation(line: 308, column: 27, scope: !40)
!229 = !DILocation(line: 309, column: 33, scope: !40)
!230 = !DILocation(line: 311, column: 5, scope: !40)
!231 = !DILocation(line: 312, column: 51, scope: !40)
!232 = !DILocation(line: 312, column: 37, scope: !40)
!233 = !DILocation(line: 315, column: 27, scope: !40)
!234 = !DILocation(line: 316, column: 33, scope: !40)
!235 = !DILocation(line: 318, column: 5, scope: !40)
!236 = !DILocation(line: 319, column: 52, scope: !40)
!237 = !DILocation(line: 319, column: 38, scope: !40)
!238 = !DILocation(line: 322, column: 33, scope: !40)
!239 = !DILocation(line: 322, column: 7, scope: !40)
!240 = !DILocation(line: 323, column: 48, scope: !40)
!241 = !DILocation(line: 323, column: 27, scope: !40)
!242 = !DILocation(line: 323, column: 9, scope: !40)
!243 = !DILocation(line: 327, column: 77, scope: !40)
!244 = !DILocation(line: 332, column: 21, scope: !40)
!245 = !DILocation(line: 327, column: 69, scope: !40)
!246 = !DILocation(line: 341, column: 36, scope: !40)
!247 = !DILocation(line: 349, column: 31, scope: !40)
!248 = !DILocation(line: 349, column: 43, scope: !40)
!249 = !DILocation(line: 354, column: 10, scope: !81, inlinedAt: !250)
!250 = distinct !DILocation(line: 349, column: 26, scope: !40)
!251 = !DILocation(line: 288, column: 10, scope: !84, inlinedAt: !252)
!252 = distinct !DILocation(line: 349, column: 21, scope: !40)
!253 = !DILocation(line: 353, column: 38, scope: !40)
!254 = !DILocation(line: 75, column: 10, scope: !87, inlinedAt: !255)
!255 = distinct !DILocation(line: 984, column: 9, scope: !90, inlinedAt: !256)
!256 = distinct !DILocation(line: 133, column: 53, scope: !93, inlinedAt: !257)
!257 = distinct !DILocation(line: 357, column: 87, scope: !40)
!258 = !DILocation(line: 357, column: 7, scope: !40)
!259 = !DILocation(line: 357, column: 84, scope: !40)
!260 = !DILocation(line: 360, column: 33, scope: !40)
!261 = !DILocation(line: 360, column: 7, scope: !40)
!262 = !DILocation(line: 361, column: 48, scope: !40)
!263 = !DILocation(line: 361, column: 27, scope: !40)
!264 = !DILocation(line: 361, column: 9, scope: !40)
!265 = !DILocation(line: 365, column: 77, scope: !40)
!266 = !DILocation(line: 370, column: 21, scope: !40)
!267 = !DILocation(line: 365, column: 69, scope: !40)
!268 = !DILocation(line: 379, column: 36, scope: !40)
!269 = !DILocation(line: 387, column: 31, scope: !40)
!270 = !DILocation(line: 387, column: 43, scope: !40)
!271 = !DILocation(line: 354, column: 10, scope: !81, inlinedAt: !272)
!272 = distinct !DILocation(line: 387, column: 26, scope: !40)
!273 = !DILocation(line: 288, column: 10, scope: !84, inlinedAt: !274)
!274 = distinct !DILocation(line: 387, column: 21, scope: !40)
!275 = !DILocation(line: 391, column: 38, scope: !40)
!276 = !DILocation(line: 75, column: 10, scope: !87, inlinedAt: !277)
!277 = distinct !DILocation(line: 984, column: 9, scope: !90, inlinedAt: !278)
!278 = distinct !DILocation(line: 133, column: 53, scope: !93, inlinedAt: !279)
!279 = distinct !DILocation(line: 395, column: 87, scope: !40)
!280 = !DILocation(line: 395, column: 7, scope: !40)
!281 = !DILocation(line: 395, column: 84, scope: !40)
!282 = !DILocation(line: 399, column: 3, scope: !40)
!283 = !DILocation(line: 68, column: 3, scope: !284, inlinedAt: !286)
!284 = distinct !DISubprogram(name: "__barrier_warp", scope: !285, file: !285, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!285 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!286 = distinct !DILocation(line: 192, column: 3, scope: !287, inlinedAt: !288)
!287 = distinct !DISubprogram(name: "__syncwarp", scope: !285, file: !285, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!288 = distinct !DILocation(line: 408, column: 3, scope: !40)
!289 = !DILocation(line: 69, column: 3, scope: !284, inlinedAt: !286)
!290 = !DILocation(line: 70, column: 3, scope: !284, inlinedAt: !286)
!291 = !DILocation(line: 410, column: 33, scope: !40)
!292 = !DILocation(line: 412, column: 5, scope: !40)
!293 = !DILocation(line: 413, column: 51, scope: !40)
!294 = !DILocation(line: 413, column: 37, scope: !40)
!295 = !DILocation(line: 416, column: 27, scope: !40)
!296 = !DILocation(line: 417, column: 33, scope: !40)
!297 = !DILocation(line: 419, column: 5, scope: !40)
!298 = !DILocation(line: 420, column: 54, scope: !40)
!299 = !DILocation(line: 420, column: 40, scope: !40)
!300 = !DILocation(line: 423, column: 33, scope: !40)
!301 = !DILocation(line: 426, column: 34, scope: !40)
!302 = !DILocation(line: 426, column: 32, scope: !40)
!303 = !DILocation(line: 430, column: 36, scope: !40)
!304 = !DILocation(line: 436, column: 33, scope: !40)
!305 = !DILocation(line: 439, column: 34, scope: !40)
!306 = !DILocation(line: 439, column: 32, scope: !40)
!307 = !DILocation(line: 443, column: 42, scope: !40)
!308 = !DILocation(line: 449, column: 27, scope: !40)
!309 = !DILocation(line: 450, column: 33, scope: !40)
!310 = !DILocation(line: 452, column: 5, scope: !40)
!311 = !DILocation(line: 453, column: 51, scope: !40)
!312 = !DILocation(line: 453, column: 37, scope: !40)
!313 = !DILocation(line: 456, column: 27, scope: !40)
!314 = !DILocation(line: 457, column: 33, scope: !40)
!315 = !DILocation(line: 459, column: 5, scope: !40)
!316 = !DILocation(line: 460, column: 54, scope: !40)
!317 = !DILocation(line: 460, column: 40, scope: !40)
!318 = !DILocation(line: 463, column: 33, scope: !40)
!319 = !DILocation(line: 466, column: 35, scope: !40)
!320 = !DILocation(line: 466, column: 33, scope: !40)
!321 = !DILocation(line: 470, column: 38, scope: !40)
!322 = !DILocation(line: 476, column: 33, scope: !40)
!323 = !DILocation(line: 479, column: 35, scope: !40)
!324 = !DILocation(line: 479, column: 33, scope: !40)
!325 = !DILocation(line: 483, column: 42, scope: !40)
!326 = !DILocation(line: 489, column: 27, scope: !40)
!327 = !DILocation(line: 490, column: 33, scope: !40)
!328 = !DILocation(line: 492, column: 5, scope: !40)
!329 = !DILocation(line: 493, column: 51, scope: !40)
!330 = !DILocation(line: 493, column: 37, scope: !40)
!331 = !DILocation(line: 496, column: 27, scope: !40)
!332 = !DILocation(line: 497, column: 33, scope: !40)
!333 = !DILocation(line: 499, column: 5, scope: !40)
!334 = !DILocation(line: 500, column: 54, scope: !40)
!335 = !DILocation(line: 500, column: 40, scope: !40)
!336 = !DILocation(line: 503, column: 33, scope: !40)
!337 = !DILocation(line: 506, column: 35, scope: !40)
!338 = !DILocation(line: 506, column: 33, scope: !40)
!339 = !DILocation(line: 510, column: 38, scope: !40)
!340 = !DILocation(line: 516, column: 33, scope: !40)
!341 = !DILocation(line: 519, column: 35, scope: !40)
!342 = !DILocation(line: 519, column: 33, scope: !40)
!343 = !DILocation(line: 523, column: 42, scope: !40)
!344 = !DILocation(line: 529, column: 27, scope: !40)
!345 = !DILocation(line: 530, column: 33, scope: !40)
!346 = !DILocation(line: 532, column: 5, scope: !40)
!347 = !DILocation(line: 533, column: 51, scope: !40)
!348 = !DILocation(line: 533, column: 37, scope: !40)
!349 = !DILocation(line: 536, column: 27, scope: !40)
!350 = !DILocation(line: 537, column: 33, scope: !40)
!351 = !DILocation(line: 539, column: 5, scope: !40)
!352 = !DILocation(line: 540, column: 54, scope: !40)
!353 = !DILocation(line: 540, column: 40, scope: !40)
!354 = !DILocation(line: 543, column: 33, scope: !40)
!355 = !DILocation(line: 546, column: 35, scope: !40)
!356 = !DILocation(line: 546, column: 33, scope: !40)
!357 = !DILocation(line: 550, column: 38, scope: !40)
!358 = !DILocation(line: 556, column: 33, scope: !40)
!359 = !DILocation(line: 559, column: 35, scope: !40)
!360 = !DILocation(line: 559, column: 33, scope: !40)
!361 = !DILocation(line: 563, column: 42, scope: !40)
!362 = !DILocation(line: 68, column: 3, scope: !284, inlinedAt: !363)
!363 = distinct !DILocation(line: 192, column: 3, scope: !287, inlinedAt: !364)
!364 = distinct !DILocation(line: 569, column: 3, scope: !40)
!365 = !DILocation(line: 69, column: 3, scope: !284, inlinedAt: !363)
!366 = !DILocation(line: 70, column: 3, scope: !284, inlinedAt: !363)
!367 = !DILocation(line: 572, column: 20, scope: !40)
!368 = !DILocation(line: 572, column: 34, scope: !40)
!369 = !DILocation(line: 572, column: 32, scope: !40)
!370 = !DILocation(line: 577, column: 36, scope: !40)
!371 = !DILocation(line: 1018, column: 9, scope: !372, inlinedAt: !373)
!372 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !285, file: !285, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!373 = distinct !DILocation(line: 396, column: 10, scope: !374, inlinedAt: !376)
!374 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !375, file: !375, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!375 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!376 = distinct !DILocation(line: 129, column: 24, scope: !377, inlinedAt: !379)
!377 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !378, file: !378, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!378 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!379 = distinct !DILocation(line: 101, column: 14, scope: !380, inlinedAt: !381)
!380 = distinct !DISubprogram(name: "run<float>", scope: !378, file: !378, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!381 = distinct !DILocation(line: 579, column: 19, scope: !40)
!382 = !DILocation(line: 171, column: 37, scope: !383, inlinedAt: !384)
!383 = distinct !DISubprogram(name: "__lane_id", scope: !285, file: !285, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!384 = distinct !DILocation(line: 990, column: 14, scope: !385, inlinedAt: !386)
!385 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !285, file: !285, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!386 = distinct !DILocation(line: 1019, column: 11, scope: !372, inlinedAt: !373)
!387 = !DILocation(line: 171, column: 10, scope: !383, inlinedAt: !384)
!388 = !DILocation(line: 991, column: 20, scope: !385, inlinedAt: !386)
!389 = !DILocation(line: 992, column: 36, scope: !385, inlinedAt: !386)
!390 = !DILocation(line: 992, column: 17, scope: !385, inlinedAt: !386)
!391 = !DILocation(line: 992, column: 11, scope: !385, inlinedAt: !386)
!392 = !DILocation(line: 993, column: 43, scope: !385, inlinedAt: !386)
!393 = !DILocation(line: 993, column: 10, scope: !385, inlinedAt: !386)
!394 = !DILocation(line: 1020, column: 14, scope: !372, inlinedAt: !373)
!395 = !DILocation(line: 25, column: 14, scope: !396, inlinedAt: !397)
!396 = distinct !DISubprogram(name: "operator()<float>", scope: !378, file: !378, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!397 = distinct !DILocation(line: 129, column: 11, scope: !377, inlinedAt: !379)
!398 = !DILocation(line: 1018, column: 9, scope: !372, inlinedAt: !399)
!399 = distinct !DILocation(line: 396, column: 10, scope: !374, inlinedAt: !400)
!400 = distinct !DILocation(line: 129, column: 24, scope: !401, inlinedAt: !402)
!401 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !378, file: !378, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!402 = distinct !DILocation(line: 101, column: 14, scope: !403, inlinedAt: !404)
!403 = distinct !DISubprogram(name: "run<float>", scope: !378, file: !378, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!404 = distinct !DILocation(line: 134, column: 14, scope: !377, inlinedAt: !379)
!405 = !DILocation(line: 171, column: 37, scope: !383, inlinedAt: !406)
!406 = distinct !DILocation(line: 990, column: 14, scope: !385, inlinedAt: !407)
!407 = distinct !DILocation(line: 1019, column: 11, scope: !372, inlinedAt: !399)
!408 = !DILocation(line: 171, column: 10, scope: !383, inlinedAt: !406)
!409 = !DILocation(line: 991, column: 20, scope: !385, inlinedAt: !407)
!410 = !DILocation(line: 992, column: 36, scope: !385, inlinedAt: !407)
!411 = !DILocation(line: 992, column: 17, scope: !385, inlinedAt: !407)
!412 = !DILocation(line: 992, column: 11, scope: !385, inlinedAt: !407)
!413 = !DILocation(line: 993, column: 43, scope: !385, inlinedAt: !407)
!414 = !DILocation(line: 993, column: 10, scope: !385, inlinedAt: !407)
!415 = !DILocation(line: 1020, column: 14, scope: !372, inlinedAt: !399)
!416 = !DILocation(line: 25, column: 14, scope: !396, inlinedAt: !417)
!417 = distinct !DILocation(line: 129, column: 11, scope: !401, inlinedAt: !402)
!418 = !DILocation(line: 581, column: 32, scope: !40)
!419 = !DILocation(line: 581, column: 7, scope: !40)
!420 = !DILocation(line: 589, column: 32, scope: !40)
!421 = !DILocation(line: 75, column: 10, scope: !87, inlinedAt: !422)
!422 = distinct !DILocation(line: 984, column: 9, scope: !90, inlinedAt: !423)
!423 = distinct !DILocation(line: 133, column: 53, scope: !93, inlinedAt: !424)
!424 = distinct !DILocation(line: 595, column: 48, scope: !40)
!425 = !DILocation(line: 595, column: 45, scope: !40)
!426 = !DILocation(line: 600, column: 122, scope: !40)
!427 = !DILocation(line: 600, column: 150, scope: !40)
!428 = !DILocation(line: 600, column: 77, scope: !40)
!429 = !DILocation(line: 600, column: 156, scope: !40)
!430 = !DILocation(line: 600, column: 40, scope: !40)
!431 = !DILocation(line: 600, column: 199, scope: !40)
!432 = !DILocation(line: 600, column: 93, scope: !40)
!433 = !DILocation(line: 68, column: 3, scope: !284, inlinedAt: !434)
!434 = distinct !DILocation(line: 192, column: 3, scope: !287, inlinedAt: !435)
!435 = distinct !DILocation(line: 602, column: 3, scope: !40)
!436 = !DILocation(line: 69, column: 3, scope: !284, inlinedAt: !434)
!437 = !DILocation(line: 70, column: 3, scope: !284, inlinedAt: !434)
!438 = !DILocation(line: 604, column: 8, scope: !40)
!439 = !DILocation(line: 604, column: 3, scope: !40)
!440 = !DILocation(line: 605, column: 22, scope: !40)
!441 = !DILocation(line: 605, column: 132, scope: !40)
!442 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!443 = !{i32 2, i32 -1, i32 -1, i32 -1}
!444 = !DILocation(line: 605, column: 169, scope: !40)
!445 = !DILocation(line: 607, column: 1, scope: !40)
