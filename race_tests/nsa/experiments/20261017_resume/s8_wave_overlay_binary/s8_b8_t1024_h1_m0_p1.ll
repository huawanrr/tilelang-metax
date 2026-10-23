; ModuleID = 'experiments/20261017_resume/s8_wave_overlay_binary/s8_b8_t1024_h1_m0_p1.bc'
source_filename = "/tmp/tmpgmunruiq/tvm_kernels.maca"
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
  %cond.i.i1230 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64), !dbg !49
  %mul11 = shl nsw i32 %cond.i.i1230, 4, !dbg !52
  %4 = or disjoint i64 %2, 1, !dbg !53
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4, !dbg !43
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !dbg !43, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i1230.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64), !dbg !49
  %mul11.1 = shl nsw i32 %cond.i.i1230.1, 4, !dbg !52
  %6 = or disjoint i64 %2, 2, !dbg !53
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6, !dbg !43
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !dbg !43, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i1230.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64), !dbg !49
  %mul11.2 = shl nsw i32 %cond.i.i1230.2, 4, !dbg !52
  %8 = or disjoint i64 %2, 3, !dbg !53
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8, !dbg !43
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !dbg !43, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i1230.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64), !dbg !49
  %mul11.3 = shl nsw i32 %cond.i.i1230.3, 4, !dbg !52
  %10 = or disjoint i64 %2, 4, !dbg !53
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10, !dbg !43
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !dbg !43, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i1230.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64), !dbg !49
  %mul11.4 = shl nsw i32 %cond.i.i1230.4, 4, !dbg !52
  %12 = or disjoint i64 %2, 5, !dbg !53
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12, !dbg !43
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !dbg !43, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i1230.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64), !dbg !49
  %mul11.5 = shl nsw i32 %cond.i.i1230.5, 4, !dbg !52
  %14 = or disjoint i64 %2, 6, !dbg !53
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14, !dbg !43
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !dbg !43, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i1230.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64), !dbg !49
  %mul11.6 = shl nsw i32 %cond.i.i1230.6, 4, !dbg !52
  %16 = or disjoint i64 %2, 7, !dbg !53
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16, !dbg !43
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !dbg !43, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i1230.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64), !dbg !49
  %mul11.7 = shl nsw i32 %cond.i.i1230.7, 4, !dbg !52
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
  %mul128 = shl nsw i32 %0, 16
  %mul135 = shl nuw nsw i32 %18, 3
  %add131 = or disjoint i32 %mul135, %mul128
  %invariant.op = add nsw i32 %1, -15, !dbg !58
  %22 = lshr i32 %18, 2
  %mul279 = and i32 %22, 252
  %or.cond = icmp ugt i32 %mul11, 1023, !dbg !59
  %cmp122.not = icmp sgt i32 %mul11, %1
  %or.cond1308 = or i1 %or.cond, %cmp122.not, !dbg !59
  br i1 %or.cond1308, label %if.end, label %for.cond123.preheader, !dbg !59

for.cond123.preheader:                            ; preds = %entry
  %23 = shl nsw i32 %cond.i.i1230, 10
  %mul130 = and i32 %23, 64512
  %add133 = add nuw nsw i32 %add131, %mul130
  %24 = zext nneg i32 %add133 to i64, !dbg !60
  %add.ptr138 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %24, !dbg !61
  %K_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr138, align 16, !dbg !62
  %K_reg.sroa.6.0.add.ptr138.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr138, i64 8, !dbg !62
  %K_reg.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg.sroa.6.0.add.ptr138.sroa_idx, align 8, !dbg !62
  %25 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %24, !dbg !61
  %add.ptr138.1 = getelementptr inbounds i8, ptr addrspace(4) %25, i64 1024, !dbg !61
  %K_reg.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr138.1, align 16, !dbg !62
  %K_reg.sroa.12.16.add.ptr138.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %25, i64 1032, !dbg !62
  %K_reg.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg.sroa.12.16.add.ptr138.1.sroa_idx, align 8, !dbg !62
  br label %if.end, !dbg !63

if.end:                                           ; preds = %for.cond123.preheader, %entry
  %K_reg.sroa.12.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.12.16.copyload, %for.cond123.preheader ]
  %K_reg.sroa.8.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.8.16.copyload, %for.cond123.preheader ]
  %K_reg.sroa.6.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.6.0.copyload, %for.cond123.preheader ]
  %K_reg.sroa.0.0 = phi <4 x half> [ undef, %entry ], [ %K_reg.sroa.0.0.copyload, %for.cond123.preheader ]
  %or.cond1309 = icmp ugt i32 %mul11.1, 1023, !dbg !63
  %cmp151.not = icmp sgt i32 %mul11.1, %1
  %or.cond1310 = or i1 %or.cond1309, %cmp151.not, !dbg !63
  br i1 %or.cond1310, label %if.end176, label %for.cond153.preheader, !dbg !63

for.cond153.preheader:                            ; preds = %if.end
  %26 = shl nsw i32 %cond.i.i1230.1, 10
  %mul160 = and i32 %26, 64512
  %add163 = add nuw nsw i32 %add131, %mul160
  %27 = zext nneg i32 %add163 to i64, !dbg !64
  %add.ptr168 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %27, !dbg !65
  %K_reg1.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr168, align 16, !dbg !66
  %K_reg1.sroa.6.0.add.ptr168.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr168, i64 8, !dbg !66
  %K_reg1.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.6.0.add.ptr168.sroa_idx, align 8, !dbg !66
  %28 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %27, !dbg !65
  %add.ptr168.1 = getelementptr inbounds i8, ptr addrspace(4) %28, i64 1024, !dbg !65
  %K_reg1.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr168.1, align 16, !dbg !66
  %K_reg1.sroa.12.16.add.ptr168.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %28, i64 1032, !dbg !66
  %K_reg1.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.12.16.add.ptr168.1.sroa_idx, align 8, !dbg !66
  br label %if.end176, !dbg !67

if.end176:                                        ; preds = %for.cond153.preheader, %if.end
  %K_reg1.sroa.12.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.12.16.copyload, %for.cond153.preheader ]
  %K_reg1.sroa.8.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.8.16.copyload, %for.cond153.preheader ]
  %K_reg1.sroa.6.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.6.0.copyload, %for.cond153.preheader ]
  %K_reg1.sroa.0.0 = phi <4 x half> [ undef, %if.end ], [ %K_reg1.sroa.0.0.copyload, %for.cond153.preheader ]
  %or.cond1311 = icmp ugt i32 %mul11.2, 1023, !dbg !67
  %cmp182.not = icmp sgt i32 %mul11.2, %1
  %or.cond1312 = or i1 %or.cond1311, %cmp182.not, !dbg !67
  br i1 %or.cond1312, label %if.end207, label %for.cond184.preheader, !dbg !67

for.cond184.preheader:                            ; preds = %if.end176
  %29 = shl nsw i32 %cond.i.i1230.2, 10
  %mul191 = and i32 %29, 64512
  %add194 = add nuw nsw i32 %add131, %mul191
  %30 = zext nneg i32 %add194 to i64, !dbg !68
  %add.ptr199 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %30, !dbg !69
  %K_reg2.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr199, align 16, !dbg !70
  %K_reg2.sroa.6.0.add.ptr199.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr199, i64 8, !dbg !70
  %K_reg2.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.6.0.add.ptr199.sroa_idx, align 8, !dbg !70
  %31 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %30, !dbg !69
  %add.ptr199.1 = getelementptr inbounds i8, ptr addrspace(4) %31, i64 1024, !dbg !69
  %K_reg2.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr199.1, align 16, !dbg !70
  %K_reg2.sroa.12.16.add.ptr199.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %31, i64 1032, !dbg !70
  %K_reg2.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.12.16.add.ptr199.1.sroa_idx, align 8, !dbg !70
  br label %if.end207, !dbg !71

if.end207:                                        ; preds = %for.cond184.preheader, %if.end176
  %K_reg2.sroa.12.0 = phi <4 x half> [ undef, %if.end176 ], [ %K_reg2.sroa.12.16.copyload, %for.cond184.preheader ]
  %K_reg2.sroa.8.0 = phi <4 x half> [ undef, %if.end176 ], [ %K_reg2.sroa.8.16.copyload, %for.cond184.preheader ]
  %K_reg2.sroa.6.0 = phi <4 x half> [ undef, %if.end176 ], [ %K_reg2.sroa.6.0.copyload, %for.cond184.preheader ]
  %K_reg2.sroa.0.0 = phi <4 x half> [ undef, %if.end176 ], [ %K_reg2.sroa.0.0.copyload, %for.cond184.preheader ]
  %or.cond1313 = icmp ugt i32 %mul11.3, 1023, !dbg !71
  %cmp213.not = icmp sgt i32 %mul11.3, %1
  %or.cond1314 = or i1 %or.cond1313, %cmp213.not, !dbg !71
  br i1 %or.cond1314, label %if.end238, label %for.cond215.preheader, !dbg !71

for.cond215.preheader:                            ; preds = %if.end207
  %32 = shl nsw i32 %cond.i.i1230.3, 10
  %mul222 = and i32 %32, 64512
  %add225 = add nuw nsw i32 %add131, %mul222
  %33 = zext nneg i32 %add225 to i64, !dbg !72
  %add.ptr230 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %33, !dbg !73
  %K_reg3.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr230, align 16, !dbg !74
  %K_reg3.sroa.6.0.add.ptr230.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr230, i64 8, !dbg !74
  %K_reg3.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.6.0.add.ptr230.sroa_idx, align 8, !dbg !74
  %34 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %33, !dbg !73
  %add.ptr230.1 = getelementptr inbounds i8, ptr addrspace(4) %34, i64 1024, !dbg !73
  %K_reg3.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr230.1, align 16, !dbg !74
  %K_reg3.sroa.12.16.add.ptr230.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %34, i64 1032, !dbg !74
  %K_reg3.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.12.16.add.ptr230.1.sroa_idx, align 8, !dbg !74
  br label %if.end238, !dbg !75

if.end238:                                        ; preds = %for.cond215.preheader, %if.end207
  %K_reg3.sroa.12.0 = phi <4 x half> [ undef, %if.end207 ], [ %K_reg3.sroa.12.16.copyload, %for.cond215.preheader ]
  %K_reg3.sroa.8.0 = phi <4 x half> [ undef, %if.end207 ], [ %K_reg3.sroa.8.16.copyload, %for.cond215.preheader ]
  %K_reg3.sroa.6.0 = phi <4 x half> [ undef, %if.end207 ], [ %K_reg3.sroa.6.0.copyload, %for.cond215.preheader ]
  %K_reg3.sroa.0.0 = phi <4 x half> [ undef, %if.end207 ], [ %K_reg3.sroa.0.0.copyload, %for.cond215.preheader ]
  br i1 %or.cond1308, label %if.end383, label %for.cond246.preheader, !dbg !75

for.cond246.preheader:                            ; preds = %if.end238
  %35 = shl nsw i32 %cond.i.i1230, 10
  %mul253 = and i32 %35, 64512
  %add256 = add nuw nsw i32 %add131, %mul253
  %36 = zext nneg i32 %add256 to i64, !dbg !76
  %add.ptr261 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %36, !dbg !77
  %V_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr261, align 16, !dbg !78
  %V_reg.sroa.18.0.add.ptr261.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr261, i64 8, !dbg !78
  %V_reg.sroa.18.0.copyload = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr261.sroa_idx, align 8, !dbg !78
  %37 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %36, !dbg !77
  %add.ptr261.1 = getelementptr inbounds i8, ptr addrspace(4) %37, i64 1024, !dbg !77
  %V_reg.sroa.26.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr261.1, align 16, !dbg !78
  %V_reg.sroa.42.16.add.ptr261.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %37, i64 1032, !dbg !78
  %V_reg.sroa.42.16.copyload = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr261.1.sroa_idx, align 8, !dbg !78
  %cmp271 = icmp sgt i32 %mul11, %invariant.op, !dbg !79
  br i1 %cmp271, label %for.cond273.preheader, label %if.end296, !dbg !80

for.cond273.preheader:                            ; preds = %for.cond246.preheader
  %add280 = add nuw nsw i32 %mul11, %mul279
  %cmp283.not = icmp sgt i32 %add280, %1, !dbg !81
  %fneg. = select i1 %cmp283.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1496 = insertelement <4 x float> poison, float %fneg., i64 0, !dbg !82
  %cmp283.not.1.not = icmp slt i32 %add280, %1, !dbg !81
  %fneg..1 = select i1 %cmp283.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1597 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1496, float %fneg..1, i64 1, !dbg !82
  %add281.2 = or disjoint i32 %add280, 2, !dbg !83
  %cmp283.not.2 = icmp sgt i32 %add281.2, %1, !dbg !81
  %fneg..2 = select i1 %cmp283.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1690 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1597, float %fneg..2, i64 2, !dbg !82
  %add281.3 = or disjoint i32 %add280, 3, !dbg !83
  %cmp283.not.3 = icmp sgt i32 %add281.3, %1, !dbg !81
  %fneg..3 = select i1 %cmp283.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1783 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1690, float %fneg..3, i64 3, !dbg !82
  br label %if.end296

if.end296:                                        ; preds = %for.cond246.preheader, %for.cond273.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1783, %for.cond273.preheader ], [ zeroinitializer, %for.cond246.preheader ], !dbg !84
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !dbg !85, !call_argsrelate !86
  %39 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %38), !dbg !85, !call_argsrelate !86
  %40 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %39), !dbg !85, !call_argsrelate !86
  %41 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %40), !dbg !85, !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %41, i64 0, !dbg !87
  %mul331 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !88
  %42 = tail call contract noundef float @llvm.minnum.f32(float %mul331, float 0x4024CB5EC0000000), !dbg !89
  %43 = tail call contract noundef float @llvm.exp.f32(float %42), !dbg !92
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %41, i64 1, !dbg !87
  %mul331.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !88
  %44 = tail call contract noundef float @llvm.minnum.f32(float %mul331.1, float 0x4024CB5EC0000000), !dbg !89
  %45 = tail call contract noundef float @llvm.exp.f32(float %44), !dbg !92
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %41, i64 2, !dbg !87
  %mul331.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !88
  %46 = tail call contract noundef float @llvm.minnum.f32(float %mul331.2, float 0x4024CB5EC0000000), !dbg !89
  %47 = tail call contract noundef float @llvm.exp.f32(float %46), !dbg !92
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %41, i64 3, !dbg !87
  %mul331.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !88
  %48 = tail call contract noundef float @llvm.minnum.f32(float %mul331.3, float 0x4024CB5EC0000000), !dbg !89
  %49 = tail call contract noundef float @llvm.exp.f32(float %48), !dbg !92
  %50 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %43), !dbg !95
  %51 = insertelement <4 x i16> poison, i16 %50, i64 0, !dbg !104
  %52 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %45), !dbg !95
  %53 = insertelement <4 x i16> %51, i16 %52, i64 1, !dbg !104
  %54 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %47), !dbg !95
  %55 = insertelement <4 x i16> %53, i16 %54, i64 2, !dbg !104
  %56 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %49), !dbg !95
  %57 = insertelement <4 x i16> %55, i16 %56, i64 3, !dbg !104
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %57 to <4 x half>, !dbg !104
  %58 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !105, !call_argsrelate !106
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !105, !call_argsrelate !106
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !105, !call_argsrelate !106
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !105, !call_argsrelate !106
  br label %if.end383, !dbg !107

if.end383:                                        ; preds = %if.end296, %if.end238
  %acc_o.sroa.110.0 = phi <4 x float> [ zeroinitializer, %if.end238 ], [ %61, %if.end296 ], !dbg !84
  %acc_o.sroa.74.0 = phi <4 x float> [ zeroinitializer, %if.end238 ], [ %60, %if.end296 ], !dbg !84
  %acc_o.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end238 ], [ %59, %if.end296 ], !dbg !84
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end238 ], [ %58, %if.end296 ], !dbg !84
  %sum_acc.sroa.56.0 = phi float [ 0.000000e+00, %if.end238 ], [ %49, %if.end296 ], !dbg !84
  %sum_acc.sroa.38.0 = phi float [ 0.000000e+00, %if.end238 ], [ %47, %if.end296 ], !dbg !84
  %sum_acc.sroa.20.0 = phi float [ 0.000000e+00, %if.end238 ], [ %45, %if.end296 ], !dbg !84
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %if.end238 ], [ %43, %if.end296 ], !dbg !84
  br i1 %or.cond1310, label %if.end529, label %for.cond391.preheader, !dbg !107

for.cond391.preheader:                            ; preds = %if.end383
  %62 = shl nsw i32 %cond.i.i1230.1, 10
  %mul398 = and i32 %62, 64512
  %add401 = add nuw nsw i32 %add131, %mul398
  %63 = zext nneg i32 %add401 to i64, !dbg !108
  %add.ptr406 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %63, !dbg !109
  %V_reg.sroa.0.0.copyload1868 = load <4 x half>, ptr addrspace(4) %add.ptr406, align 16, !dbg !110
  %V_reg.sroa.18.0.add.ptr406.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr406, i64 8, !dbg !110
  %V_reg.sroa.18.0.copyload1875 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr406.sroa_idx, align 8, !dbg !110
  %64 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %63, !dbg !109
  %add.ptr406.1 = getelementptr inbounds i8, ptr addrspace(4) %64, i64 1024, !dbg !109
  %V_reg.sroa.26.16.copyload1896 = load <4 x half>, ptr addrspace(4) %add.ptr406.1, align 16, !dbg !110
  %V_reg.sroa.42.16.add.ptr406.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %64, i64 1032, !dbg !110
  %V_reg.sroa.42.16.copyload1903 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr406.1.sroa_idx, align 8, !dbg !110
  %cmp416 = icmp sgt i32 %mul11.1, %invariant.op, !dbg !111
  br i1 %cmp416, label %for.cond418.preheader, label %if.end442, !dbg !112

for.cond418.preheader:                            ; preds = %for.cond391.preheader
  %add425 = add nuw nsw i32 %mul11.1, %mul279
  %cmp428.not = icmp sgt i32 %add425, %1, !dbg !113
  %fneg.1219 = select i1 %cmp428.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1505 = insertelement <4 x float> poison, float %fneg.1219, i64 0, !dbg !114
  %cmp428.not.1.not = icmp slt i32 %add425, %1, !dbg !113
  %fneg.1219.1 = select i1 %cmp428.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1606 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1505, float %fneg.1219.1, i64 1, !dbg !114
  %add426.2 = or disjoint i32 %add425, 2, !dbg !115
  %cmp428.not.2 = icmp sgt i32 %add426.2, %1, !dbg !113
  %fneg.1219.2 = select i1 %cmp428.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1699 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1606, float %fneg.1219.2, i64 2, !dbg !114
  %add426.3 = or disjoint i32 %add425, 3, !dbg !115
  %cmp428.not.3 = icmp sgt i32 %add426.3, %1, !dbg !113
  %fneg.1219.3 = select i1 %cmp428.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1792 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1699, float %fneg.1219.3, i64 3, !dbg !114
  br label %if.end442

if.end442:                                        ; preds = %for.cond391.preheader, %for.cond418.preheader
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1792, %for.cond418.preheader ], [ zeroinitializer, %for.cond391.preheader ], !dbg !84
  %65 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.2), !dbg !116, !call_argsrelate !86
  %66 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %65), !dbg !116, !call_argsrelate !86
  %67 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %66), !dbg !116, !call_argsrelate !86
  %68 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %67), !dbg !116, !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract1507 = extractelement <4 x float> %68, i64 0, !dbg !117
  %mul477 = fmul contract float %acc_s.sroa.0.0.vec.extract1507, 0x3FB99999A0000000, !dbg !118
  %69 = tail call contract noundef float @llvm.minnum.f32(float %mul477, float 0x4024CB5EC0000000), !dbg !119
  %70 = tail call contract noundef float @llvm.exp.f32(float %69), !dbg !121
  %acc_s.sroa.0.4.vec.extract1608 = extractelement <4 x float> %68, i64 1, !dbg !117
  %mul477.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1608, 0x3FB99999A0000000, !dbg !118
  %71 = tail call contract noundef float @llvm.minnum.f32(float %mul477.1, float 0x4024CB5EC0000000), !dbg !119
  %72 = tail call contract noundef float @llvm.exp.f32(float %71), !dbg !121
  %acc_s.sroa.0.8.vec.extract1701 = extractelement <4 x float> %68, i64 2, !dbg !117
  %mul477.2 = fmul contract float %acc_s.sroa.0.8.vec.extract1701, 0x3FB99999A0000000, !dbg !118
  %73 = tail call contract noundef float @llvm.minnum.f32(float %mul477.2, float 0x4024CB5EC0000000), !dbg !119
  %74 = tail call contract noundef float @llvm.exp.f32(float %73), !dbg !121
  %acc_s.sroa.0.12.vec.extract1794 = extractelement <4 x float> %68, i64 3, !dbg !117
  %mul477.3 = fmul contract float %acc_s.sroa.0.12.vec.extract1794, 0x3FB99999A0000000, !dbg !118
  %75 = tail call contract noundef float @llvm.minnum.f32(float %mul477.3, float 0x4024CB5EC0000000), !dbg !119
  %76 = tail call contract noundef float @llvm.exp.f32(float %75), !dbg !121
  %add493 = fadd contract float %sum_acc.sroa.0.0, %70, !dbg !123
  %add493.1 = fadd contract float %sum_acc.sroa.20.0, %72, !dbg !123
  %add493.2 = fadd contract float %sum_acc.sroa.38.0, %74, !dbg !123
  %add493.3 = fadd contract float %sum_acc.sroa.56.0, %76, !dbg !123
  %77 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %70), !dbg !124
  %78 = insertelement <4 x i16> poison, i16 %77, i64 0, !dbg !128
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %72), !dbg !124
  %80 = insertelement <4 x i16> %78, i16 %79, i64 1, !dbg !128
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %74), !dbg !124
  %82 = insertelement <4 x i16> %80, i16 %81, i64 2, !dbg !128
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %76), !dbg !124
  %84 = insertelement <4 x i16> %82, i16 %83, i64 3, !dbg !128
  %acc_s_cast.sroa.0.6.vec.insert1468 = bitcast <4 x i16> %84 to <4 x half>, !dbg !128
  %85 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1868, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1468, <4 x float> zeroinitializer), !dbg !129, !call_argsrelate !106
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1875, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1468, <4 x float> zeroinitializer), !dbg !129, !call_argsrelate !106
  %87 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1896, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1468, <4 x float> zeroinitializer), !dbg !129, !call_argsrelate !106
  %88 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1903, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1468, <4 x float> zeroinitializer), !dbg !129, !call_argsrelate !106
  br label %if.end529, !dbg !130

if.end529:                                        ; preds = %if.end442, %if.end383
  %acc_o_1.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end383 ], [ %88, %if.end442 ], !dbg !84
  %acc_o_1.sroa.26.0 = phi <4 x float> [ zeroinitializer, %if.end383 ], [ %87, %if.end442 ], !dbg !84
  %acc_o_1.sroa.14.0 = phi <4 x float> [ zeroinitializer, %if.end383 ], [ %86, %if.end442 ], !dbg !84
  %acc_o_1.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end383 ], [ %85, %if.end442 ], !dbg !84
  %sum_acc.sroa.56.1 = phi float [ %sum_acc.sroa.56.0, %if.end383 ], [ %add493.3, %if.end442 ], !dbg !84
  %sum_acc.sroa.38.1 = phi float [ %sum_acc.sroa.38.0, %if.end383 ], [ %add493.2, %if.end442 ], !dbg !84
  %sum_acc.sroa.20.1 = phi float [ %sum_acc.sroa.20.0, %if.end383 ], [ %add493.1, %if.end442 ], !dbg !84
  %sum_acc.sroa.0.1 = phi float [ %sum_acc.sroa.0.0, %if.end383 ], [ %add493, %if.end442 ], !dbg !84
  br i1 %or.cond1312, label %if.end675, label %for.cond537.preheader, !dbg !130

for.cond537.preheader:                            ; preds = %if.end529
  %89 = shl nsw i32 %cond.i.i1230.2, 10
  %mul544 = and i32 %89, 64512
  %add547 = add nuw nsw i32 %add131, %mul544
  %90 = zext nneg i32 %add547 to i64, !dbg !131
  %add.ptr552 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %90, !dbg !132
  %V_reg.sroa.0.0.copyload1869 = load <4 x half>, ptr addrspace(4) %add.ptr552, align 16, !dbg !133
  %V_reg.sroa.18.0.add.ptr552.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr552, i64 8, !dbg !133
  %V_reg.sroa.18.0.copyload1876 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr552.sroa_idx, align 8, !dbg !133
  %91 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %90, !dbg !132
  %add.ptr552.1 = getelementptr inbounds i8, ptr addrspace(4) %91, i64 1024, !dbg !132
  %V_reg.sroa.26.16.copyload1897 = load <4 x half>, ptr addrspace(4) %add.ptr552.1, align 16, !dbg !133
  %V_reg.sroa.42.16.add.ptr552.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %91, i64 1032, !dbg !133
  %V_reg.sroa.42.16.copyload1904 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr552.1.sroa_idx, align 8, !dbg !133
  %cmp562 = icmp sgt i32 %mul11.2, %invariant.op, !dbg !134
  br i1 %cmp562, label %for.cond564.preheader, label %if.end588, !dbg !135

for.cond564.preheader:                            ; preds = %for.cond537.preheader
  %add571 = add nuw nsw i32 %mul11.2, %mul279
  %cmp574.not = icmp sgt i32 %add571, %1, !dbg !136
  %fneg.1220 = select i1 %cmp574.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1515 = insertelement <4 x float> poison, float %fneg.1220, i64 0, !dbg !137
  %cmp574.not.1.not = icmp slt i32 %add571, %1, !dbg !136
  %fneg.1220.1 = select i1 %cmp574.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1616 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1515, float %fneg.1220.1, i64 1, !dbg !137
  %add572.2 = or disjoint i32 %add571, 2, !dbg !138
  %cmp574.not.2 = icmp sgt i32 %add572.2, %1, !dbg !136
  %fneg.1220.2 = select i1 %cmp574.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1709 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1616, float %fneg.1220.2, i64 2, !dbg !137
  %add572.3 = or disjoint i32 %add571, 3, !dbg !138
  %cmp574.not.3 = icmp sgt i32 %add572.3, %1, !dbg !136
  %fneg.1220.3 = select i1 %cmp574.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1802 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1709, float %fneg.1220.3, i64 3, !dbg !137
  br label %if.end588

if.end588:                                        ; preds = %for.cond537.preheader, %for.cond564.preheader
  %acc_s.sroa.0.4 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1802, %for.cond564.preheader ], [ zeroinitializer, %for.cond537.preheader ], !dbg !84
  %92 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.4), !dbg !139, !call_argsrelate !86
  %93 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %92), !dbg !139, !call_argsrelate !86
  %94 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %93), !dbg !139, !call_argsrelate !86
  %95 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %94), !dbg !139, !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract1517 = extractelement <4 x float> %95, i64 0, !dbg !140
  %mul623 = fmul contract float %acc_s.sroa.0.0.vec.extract1517, 0x3FB99999A0000000, !dbg !141
  %96 = tail call contract noundef float @llvm.minnum.f32(float %mul623, float 0x4024CB5EC0000000), !dbg !142
  %97 = tail call contract noundef float @llvm.exp.f32(float %96), !dbg !144
  %acc_s.sroa.0.4.vec.extract1618 = extractelement <4 x float> %95, i64 1, !dbg !140
  %mul623.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1618, 0x3FB99999A0000000, !dbg !141
  %98 = tail call contract noundef float @llvm.minnum.f32(float %mul623.1, float 0x4024CB5EC0000000), !dbg !142
  %99 = tail call contract noundef float @llvm.exp.f32(float %98), !dbg !144
  %acc_s.sroa.0.8.vec.extract1711 = extractelement <4 x float> %95, i64 2, !dbg !140
  %mul623.2 = fmul contract float %acc_s.sroa.0.8.vec.extract1711, 0x3FB99999A0000000, !dbg !141
  %100 = tail call contract noundef float @llvm.minnum.f32(float %mul623.2, float 0x4024CB5EC0000000), !dbg !142
  %101 = tail call contract noundef float @llvm.exp.f32(float %100), !dbg !144
  %acc_s.sroa.0.12.vec.extract1804 = extractelement <4 x float> %95, i64 3, !dbg !140
  %mul623.3 = fmul contract float %acc_s.sroa.0.12.vec.extract1804, 0x3FB99999A0000000, !dbg !141
  %102 = tail call contract noundef float @llvm.minnum.f32(float %mul623.3, float 0x4024CB5EC0000000), !dbg !142
  %103 = tail call contract noundef float @llvm.exp.f32(float %102), !dbg !144
  %add639 = fadd contract float %sum_acc.sroa.0.1, %97, !dbg !146
  %add639.1 = fadd contract float %sum_acc.sroa.20.1, %99, !dbg !146
  %add639.2 = fadd contract float %sum_acc.sroa.38.1, %101, !dbg !146
  %add639.3 = fadd contract float %sum_acc.sroa.56.1, %103, !dbg !146
  %104 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %97), !dbg !147
  %105 = insertelement <4 x i16> poison, i16 %104, i64 0, !dbg !151
  %106 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %99), !dbg !147
  %107 = insertelement <4 x i16> %105, i16 %106, i64 1, !dbg !151
  %108 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %101), !dbg !147
  %109 = insertelement <4 x i16> %107, i16 %108, i64 2, !dbg !151
  %110 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %103), !dbg !147
  %111 = insertelement <4 x i16> %109, i16 %110, i64 3, !dbg !151
  %acc_s_cast.sroa.0.6.vec.insert1470 = bitcast <4 x i16> %111 to <4 x half>, !dbg !151
  %112 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1869, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1470, <4 x float> zeroinitializer), !dbg !152, !call_argsrelate !106
  %113 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1876, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1470, <4 x float> zeroinitializer), !dbg !152, !call_argsrelate !106
  %114 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1897, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1470, <4 x float> zeroinitializer), !dbg !152, !call_argsrelate !106
  %115 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1904, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1470, <4 x float> zeroinitializer), !dbg !152, !call_argsrelate !106
  br label %if.end675, !dbg !153

if.end675:                                        ; preds = %if.end588, %if.end529
  %acc_o_2.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end529 ], [ %115, %if.end588 ], !dbg !84
  %acc_o_2.sroa.26.0 = phi <4 x float> [ zeroinitializer, %if.end529 ], [ %114, %if.end588 ], !dbg !84
  %acc_o_2.sroa.14.0 = phi <4 x float> [ zeroinitializer, %if.end529 ], [ %113, %if.end588 ], !dbg !84
  %acc_o_2.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end529 ], [ %112, %if.end588 ], !dbg !84
  %sum_acc.sroa.56.2 = phi float [ %sum_acc.sroa.56.1, %if.end529 ], [ %add639.3, %if.end588 ], !dbg !84
  %sum_acc.sroa.38.2 = phi float [ %sum_acc.sroa.38.1, %if.end529 ], [ %add639.2, %if.end588 ], !dbg !84
  %sum_acc.sroa.20.2 = phi float [ %sum_acc.sroa.20.1, %if.end529 ], [ %add639.1, %if.end588 ], !dbg !84
  %sum_acc.sroa.0.2 = phi float [ %sum_acc.sroa.0.1, %if.end529 ], [ %add639, %if.end588 ], !dbg !84
  br i1 %or.cond1314, label %if.end821, label %for.cond683.preheader, !dbg !153

for.cond683.preheader:                            ; preds = %if.end675
  %116 = shl nsw i32 %cond.i.i1230.3, 10
  %mul690 = and i32 %116, 64512
  %add693 = add nuw nsw i32 %add131, %mul690
  %117 = zext nneg i32 %add693 to i64, !dbg !154
  %add.ptr698 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %117, !dbg !155
  %V_reg.sroa.0.0.copyload1870 = load <4 x half>, ptr addrspace(4) %add.ptr698, align 16, !dbg !156
  %V_reg.sroa.18.0.add.ptr698.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr698, i64 8, !dbg !156
  %V_reg.sroa.18.0.copyload1877 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr698.sroa_idx, align 8, !dbg !156
  %118 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %117, !dbg !155
  %add.ptr698.1 = getelementptr inbounds i8, ptr addrspace(4) %118, i64 1024, !dbg !155
  %V_reg.sroa.26.16.copyload1898 = load <4 x half>, ptr addrspace(4) %add.ptr698.1, align 16, !dbg !156
  %V_reg.sroa.42.16.add.ptr698.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %118, i64 1032, !dbg !156
  %V_reg.sroa.42.16.copyload1905 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr698.1.sroa_idx, align 8, !dbg !156
  %cmp708 = icmp sgt i32 %mul11.3, %invariant.op, !dbg !157
  br i1 %cmp708, label %for.cond710.preheader, label %if.end734, !dbg !158

for.cond710.preheader:                            ; preds = %for.cond683.preheader
  %add717 = add nuw nsw i32 %mul11.3, %mul279
  %cmp720.not = icmp sgt i32 %add717, %1, !dbg !159
  %fneg.1221 = select i1 %cmp720.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1525 = insertelement <4 x float> poison, float %fneg.1221, i64 0, !dbg !160
  %cmp720.not.1.not = icmp slt i32 %add717, %1, !dbg !159
  %fneg.1221.1 = select i1 %cmp720.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1626 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1525, float %fneg.1221.1, i64 1, !dbg !160
  %add718.2 = or disjoint i32 %add717, 2, !dbg !161
  %cmp720.not.2 = icmp sgt i32 %add718.2, %1, !dbg !159
  %fneg.1221.2 = select i1 %cmp720.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1719 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1626, float %fneg.1221.2, i64 2, !dbg !160
  %add718.3 = or disjoint i32 %add717, 3, !dbg !161
  %cmp720.not.3 = icmp sgt i32 %add718.3, %1, !dbg !159
  %fneg.1221.3 = select i1 %cmp720.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1812 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1719, float %fneg.1221.3, i64 3, !dbg !160
  br label %if.end734

if.end734:                                        ; preds = %for.cond683.preheader, %for.cond710.preheader
  %acc_s.sroa.0.6 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1812, %for.cond710.preheader ], [ zeroinitializer, %for.cond683.preheader ], !dbg !84
  %119 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.6), !dbg !162, !call_argsrelate !86
  %120 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.6.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %119), !dbg !162, !call_argsrelate !86
  %121 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.8.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %120), !dbg !162, !call_argsrelate !86
  %122 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.12.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %121), !dbg !162, !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract1527 = extractelement <4 x float> %122, i64 0, !dbg !163
  %mul769 = fmul contract float %acc_s.sroa.0.0.vec.extract1527, 0x3FB99999A0000000, !dbg !164
  %123 = tail call contract noundef float @llvm.minnum.f32(float %mul769, float 0x4024CB5EC0000000), !dbg !165
  %124 = tail call contract noundef float @llvm.exp.f32(float %123), !dbg !167
  %acc_s.sroa.0.4.vec.extract1628 = extractelement <4 x float> %122, i64 1, !dbg !163
  %mul769.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1628, 0x3FB99999A0000000, !dbg !164
  %125 = tail call contract noundef float @llvm.minnum.f32(float %mul769.1, float 0x4024CB5EC0000000), !dbg !165
  %126 = tail call contract noundef float @llvm.exp.f32(float %125), !dbg !167
  %acc_s.sroa.0.8.vec.extract1721 = extractelement <4 x float> %122, i64 2, !dbg !163
  %mul769.2 = fmul contract float %acc_s.sroa.0.8.vec.extract1721, 0x3FB99999A0000000, !dbg !164
  %127 = tail call contract noundef float @llvm.minnum.f32(float %mul769.2, float 0x4024CB5EC0000000), !dbg !165
  %128 = tail call contract noundef float @llvm.exp.f32(float %127), !dbg !167
  %acc_s.sroa.0.12.vec.extract1814 = extractelement <4 x float> %122, i64 3, !dbg !163
  %mul769.3 = fmul contract float %acc_s.sroa.0.12.vec.extract1814, 0x3FB99999A0000000, !dbg !164
  %129 = tail call contract noundef float @llvm.minnum.f32(float %mul769.3, float 0x4024CB5EC0000000), !dbg !165
  %130 = tail call contract noundef float @llvm.exp.f32(float %129), !dbg !167
  %add785 = fadd contract float %sum_acc.sroa.0.2, %124, !dbg !169
  %add785.1 = fadd contract float %sum_acc.sroa.20.2, %126, !dbg !169
  %add785.2 = fadd contract float %sum_acc.sroa.38.2, %128, !dbg !169
  %add785.3 = fadd contract float %sum_acc.sroa.56.2, %130, !dbg !169
  %131 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %124), !dbg !170
  %132 = insertelement <4 x i16> poison, i16 %131, i64 0, !dbg !174
  %133 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %126), !dbg !170
  %134 = insertelement <4 x i16> %132, i16 %133, i64 1, !dbg !174
  %135 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %128), !dbg !170
  %136 = insertelement <4 x i16> %134, i16 %135, i64 2, !dbg !174
  %137 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %130), !dbg !170
  %138 = insertelement <4 x i16> %136, i16 %137, i64 3, !dbg !174
  %acc_s_cast.sroa.0.6.vec.insert1472 = bitcast <4 x i16> %138 to <4 x half>, !dbg !174
  %139 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1870, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1472, <4 x float> zeroinitializer), !dbg !175, !call_argsrelate !106
  %140 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1877, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1472, <4 x float> zeroinitializer), !dbg !175, !call_argsrelate !106
  %141 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1898, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1472, <4 x float> zeroinitializer), !dbg !175, !call_argsrelate !106
  %142 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1905, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1472, <4 x float> zeroinitializer), !dbg !175, !call_argsrelate !106
  br label %if.end821, !dbg !176

if.end821:                                        ; preds = %if.end734, %if.end675
  %acc_o_3.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end675 ], [ %142, %if.end734 ], !dbg !84
  %acc_o_3.sroa.26.0 = phi <4 x float> [ zeroinitializer, %if.end675 ], [ %141, %if.end734 ], !dbg !84
  %acc_o_3.sroa.14.0 = phi <4 x float> [ zeroinitializer, %if.end675 ], [ %140, %if.end734 ], !dbg !84
  %acc_o_3.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end675 ], [ %139, %if.end734 ], !dbg !84
  %sum_acc.sroa.56.3 = phi float [ %sum_acc.sroa.56.2, %if.end675 ], [ %add785.3, %if.end734 ], !dbg !84
  %sum_acc.sroa.38.3 = phi float [ %sum_acc.sroa.38.2, %if.end675 ], [ %add785.2, %if.end734 ], !dbg !84
  %sum_acc.sroa.20.3 = phi float [ %sum_acc.sroa.20.2, %if.end675 ], [ %add785.1, %if.end734 ], !dbg !84
  %sum_acc.sroa.0.3 = phi float [ %sum_acc.sroa.0.2, %if.end675 ], [ %add785, %if.end734 ], !dbg !84
  %or.cond.1 = icmp ugt i32 %mul11.4, 1023, !dbg !59
  %cmp122.not.1 = icmp sgt i32 %mul11.4, %1
  %or.cond1308.1 = or i1 %or.cond.1, %cmp122.not.1, !dbg !59
  br i1 %or.cond1308.1, label %if.end.1, label %for.cond123.preheader.1, !dbg !59

for.cond123.preheader.1:                          ; preds = %if.end821
  %143 = shl nsw i32 %cond.i.i1230.4, 10
  %mul130.1 = and i32 %143, 64512
  %add133.1 = add nuw nsw i32 %add131, %mul130.1
  %144 = zext nneg i32 %add133.1 to i64, !dbg !60
  %add.ptr138.11372 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %144, !dbg !61
  %K_reg.sroa.0.0.copyload1942 = load <4 x half>, ptr addrspace(4) %add.ptr138.11372, align 16, !dbg !62
  %K_reg.sroa.6.0.add.ptr138.11372.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr138.11372, i64 8, !dbg !62
  %K_reg.sroa.6.0.copyload1943 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.6.0.add.ptr138.11372.sroa_idx, align 8, !dbg !62
  %145 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %144, !dbg !61
  %add.ptr138.1.1 = getelementptr inbounds i8, ptr addrspace(4) %145, i64 1024, !dbg !61
  %K_reg.sroa.8.16.copyload1946 = load <4 x half>, ptr addrspace(4) %add.ptr138.1.1, align 16, !dbg !62
  %K_reg.sroa.12.16.add.ptr138.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %145, i64 1032, !dbg !62
  %K_reg.sroa.12.16.copyload1947 = load <4 x half>, ptr addrspace(4) %K_reg.sroa.12.16.add.ptr138.1.1.sroa_idx, align 8, !dbg !62
  br label %if.end.1, !dbg !63

if.end.1:                                         ; preds = %for.cond123.preheader.1, %if.end821
  %K_reg.sroa.12.1 = phi <4 x half> [ %K_reg.sroa.12.0, %if.end821 ], [ %K_reg.sroa.12.16.copyload1947, %for.cond123.preheader.1 ]
  %K_reg.sroa.8.1 = phi <4 x half> [ %K_reg.sroa.8.0, %if.end821 ], [ %K_reg.sroa.8.16.copyload1946, %for.cond123.preheader.1 ]
  %K_reg.sroa.6.1 = phi <4 x half> [ %K_reg.sroa.6.0, %if.end821 ], [ %K_reg.sroa.6.0.copyload1943, %for.cond123.preheader.1 ]
  %K_reg.sroa.0.1 = phi <4 x half> [ %K_reg.sroa.0.0, %if.end821 ], [ %K_reg.sroa.0.0.copyload1942, %for.cond123.preheader.1 ]
  %or.cond1309.1 = icmp ugt i32 %mul11.5, 1023, !dbg !63
  %cmp151.not.1 = icmp sgt i32 %mul11.5, %1
  %or.cond1310.1 = or i1 %or.cond1309.1, %cmp151.not.1, !dbg !63
  br i1 %or.cond1310.1, label %if.end176.1, label %for.cond153.preheader.1, !dbg !63

for.cond153.preheader.1:                          ; preds = %if.end.1
  %146 = shl nsw i32 %cond.i.i1230.5, 10
  %mul160.1 = and i32 %146, 64512
  %add163.1 = add nuw nsw i32 %add131, %mul160.1
  %147 = zext nneg i32 %add163.1 to i64, !dbg !64
  %add.ptr168.11373 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %147, !dbg !65
  %K_reg1.sroa.0.0.copyload1934 = load <4 x half>, ptr addrspace(4) %add.ptr168.11373, align 16, !dbg !66
  %K_reg1.sroa.6.0.add.ptr168.11373.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr168.11373, i64 8, !dbg !66
  %K_reg1.sroa.6.0.copyload1935 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.6.0.add.ptr168.11373.sroa_idx, align 8, !dbg !66
  %148 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %147, !dbg !65
  %add.ptr168.1.1 = getelementptr inbounds i8, ptr addrspace(4) %148, i64 1024, !dbg !65
  %K_reg1.sroa.8.16.copyload1938 = load <4 x half>, ptr addrspace(4) %add.ptr168.1.1, align 16, !dbg !66
  %K_reg1.sroa.12.16.add.ptr168.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %148, i64 1032, !dbg !66
  %K_reg1.sroa.12.16.copyload1939 = load <4 x half>, ptr addrspace(4) %K_reg1.sroa.12.16.add.ptr168.1.1.sroa_idx, align 8, !dbg !66
  br label %if.end176.1, !dbg !67

if.end176.1:                                      ; preds = %for.cond153.preheader.1, %if.end.1
  %K_reg1.sroa.12.1 = phi <4 x half> [ %K_reg1.sroa.12.0, %if.end.1 ], [ %K_reg1.sroa.12.16.copyload1939, %for.cond153.preheader.1 ]
  %K_reg1.sroa.8.1 = phi <4 x half> [ %K_reg1.sroa.8.0, %if.end.1 ], [ %K_reg1.sroa.8.16.copyload1938, %for.cond153.preheader.1 ]
  %K_reg1.sroa.6.1 = phi <4 x half> [ %K_reg1.sroa.6.0, %if.end.1 ], [ %K_reg1.sroa.6.0.copyload1935, %for.cond153.preheader.1 ]
  %K_reg1.sroa.0.1 = phi <4 x half> [ %K_reg1.sroa.0.0, %if.end.1 ], [ %K_reg1.sroa.0.0.copyload1934, %for.cond153.preheader.1 ]
  %or.cond1311.1 = icmp ugt i32 %mul11.6, 1023, !dbg !67
  %cmp182.not.1 = icmp sgt i32 %mul11.6, %1
  %or.cond1312.1 = or i1 %or.cond1311.1, %cmp182.not.1, !dbg !67
  br i1 %or.cond1312.1, label %if.end207.1, label %for.cond184.preheader.1, !dbg !67

for.cond184.preheader.1:                          ; preds = %if.end176.1
  %149 = shl nsw i32 %cond.i.i1230.6, 10
  %mul191.1 = and i32 %149, 64512
  %add194.1 = add nuw nsw i32 %add131, %mul191.1
  %150 = zext nneg i32 %add194.1 to i64, !dbg !68
  %add.ptr199.11374 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %150, !dbg !69
  %K_reg2.sroa.0.0.copyload1926 = load <4 x half>, ptr addrspace(4) %add.ptr199.11374, align 16, !dbg !70
  %K_reg2.sroa.6.0.add.ptr199.11374.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr199.11374, i64 8, !dbg !70
  %K_reg2.sroa.6.0.copyload1927 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.6.0.add.ptr199.11374.sroa_idx, align 8, !dbg !70
  %151 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %150, !dbg !69
  %add.ptr199.1.1 = getelementptr inbounds i8, ptr addrspace(4) %151, i64 1024, !dbg !69
  %K_reg2.sroa.8.16.copyload1930 = load <4 x half>, ptr addrspace(4) %add.ptr199.1.1, align 16, !dbg !70
  %K_reg2.sroa.12.16.add.ptr199.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %151, i64 1032, !dbg !70
  %K_reg2.sroa.12.16.copyload1931 = load <4 x half>, ptr addrspace(4) %K_reg2.sroa.12.16.add.ptr199.1.1.sroa_idx, align 8, !dbg !70
  br label %if.end207.1, !dbg !71

if.end207.1:                                      ; preds = %for.cond184.preheader.1, %if.end176.1
  %K_reg2.sroa.12.1 = phi <4 x half> [ %K_reg2.sroa.12.0, %if.end176.1 ], [ %K_reg2.sroa.12.16.copyload1931, %for.cond184.preheader.1 ]
  %K_reg2.sroa.8.1 = phi <4 x half> [ %K_reg2.sroa.8.0, %if.end176.1 ], [ %K_reg2.sroa.8.16.copyload1930, %for.cond184.preheader.1 ]
  %K_reg2.sroa.6.1 = phi <4 x half> [ %K_reg2.sroa.6.0, %if.end176.1 ], [ %K_reg2.sroa.6.0.copyload1927, %for.cond184.preheader.1 ]
  %K_reg2.sroa.0.1 = phi <4 x half> [ %K_reg2.sroa.0.0, %if.end176.1 ], [ %K_reg2.sroa.0.0.copyload1926, %for.cond184.preheader.1 ]
  %or.cond1313.1 = icmp ugt i32 %mul11.7, 1023, !dbg !71
  %cmp213.not.1 = icmp sgt i32 %mul11.7, %1
  %or.cond1314.1 = or i1 %or.cond1313.1, %cmp213.not.1, !dbg !71
  br i1 %or.cond1314.1, label %if.end238.1, label %for.cond215.preheader.1, !dbg !71

for.cond215.preheader.1:                          ; preds = %if.end207.1
  %152 = shl nsw i32 %cond.i.i1230.7, 10
  %mul222.1 = and i32 %152, 64512
  %add225.1 = add nuw nsw i32 %add131, %mul222.1
  %153 = zext nneg i32 %add225.1 to i64, !dbg !72
  %add.ptr230.11375 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %153, !dbg !73
  %K_reg3.sroa.0.0.copyload1918 = load <4 x half>, ptr addrspace(4) %add.ptr230.11375, align 16, !dbg !74
  %K_reg3.sroa.6.0.add.ptr230.11375.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr230.11375, i64 8, !dbg !74
  %K_reg3.sroa.6.0.copyload1919 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.6.0.add.ptr230.11375.sroa_idx, align 8, !dbg !74
  %154 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %153, !dbg !73
  %add.ptr230.1.1 = getelementptr inbounds i8, ptr addrspace(4) %154, i64 1024, !dbg !73
  %K_reg3.sroa.8.16.copyload1922 = load <4 x half>, ptr addrspace(4) %add.ptr230.1.1, align 16, !dbg !74
  %K_reg3.sroa.12.16.add.ptr230.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %154, i64 1032, !dbg !74
  %K_reg3.sroa.12.16.copyload1923 = load <4 x half>, ptr addrspace(4) %K_reg3.sroa.12.16.add.ptr230.1.1.sroa_idx, align 8, !dbg !74
  br label %if.end238.1, !dbg !75

if.end238.1:                                      ; preds = %for.cond215.preheader.1, %if.end207.1
  %K_reg3.sroa.12.1 = phi <4 x half> [ %K_reg3.sroa.12.0, %if.end207.1 ], [ %K_reg3.sroa.12.16.copyload1923, %for.cond215.preheader.1 ]
  %K_reg3.sroa.8.1 = phi <4 x half> [ %K_reg3.sroa.8.0, %if.end207.1 ], [ %K_reg3.sroa.8.16.copyload1922, %for.cond215.preheader.1 ]
  %K_reg3.sroa.6.1 = phi <4 x half> [ %K_reg3.sroa.6.0, %if.end207.1 ], [ %K_reg3.sroa.6.0.copyload1919, %for.cond215.preheader.1 ]
  %K_reg3.sroa.0.1 = phi <4 x half> [ %K_reg3.sroa.0.0, %if.end207.1 ], [ %K_reg3.sroa.0.0.copyload1918, %for.cond215.preheader.1 ]
  br i1 %or.cond1308.1, label %if.end383.1, label %for.cond246.preheader.1, !dbg !75

for.cond246.preheader.1:                          ; preds = %if.end238.1
  %155 = shl nsw i32 %cond.i.i1230.4, 10
  %mul253.1 = and i32 %155, 64512
  %add256.1 = add nuw nsw i32 %add131, %mul253.1
  %156 = zext nneg i32 %add256.1 to i64, !dbg !76
  %add.ptr261.11376 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %156, !dbg !77
  %V_reg.sroa.0.0.copyload1871 = load <4 x half>, ptr addrspace(4) %add.ptr261.11376, align 16, !dbg !78
  %V_reg.sroa.18.0.add.ptr261.11376.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr261.11376, i64 8, !dbg !78
  %V_reg.sroa.18.0.copyload1878 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr261.11376.sroa_idx, align 8, !dbg !78
  %157 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %156, !dbg !77
  %add.ptr261.1.1 = getelementptr inbounds i8, ptr addrspace(4) %157, i64 1024, !dbg !77
  %V_reg.sroa.26.16.copyload1899 = load <4 x half>, ptr addrspace(4) %add.ptr261.1.1, align 16, !dbg !78
  %V_reg.sroa.42.16.add.ptr261.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %157, i64 1032, !dbg !78
  %V_reg.sroa.42.16.copyload1906 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr261.1.1.sroa_idx, align 8, !dbg !78
  %cmp271.1 = icmp sgt i32 %mul11.4, %invariant.op, !dbg !79
  br i1 %cmp271.1, label %for.cond273.preheader.1, label %if.end296.1, !dbg !80

for.cond273.preheader.1:                          ; preds = %for.cond246.preheader.1
  %add280.1 = add nuw nsw i32 %mul11.4, %mul279
  %cmp283.not.11377 = icmp sgt i32 %add280.1, %1, !dbg !81
  %fneg..11378 = select i1 %cmp283.not.11377, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1537 = insertelement <4 x float> poison, float %fneg..11378, i64 0, !dbg !82
  %cmp283.not.1.1.not = icmp slt i32 %add280.1, %1, !dbg !81
  %fneg..1.1 = select i1 %cmp283.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1636 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1537, float %fneg..1.1, i64 1, !dbg !82
  %add281.2.1 = or disjoint i32 %add280.1, 2, !dbg !83
  %cmp283.not.2.1 = icmp sgt i32 %add281.2.1, %1, !dbg !81
  %fneg..2.1 = select i1 %cmp283.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1729 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1636, float %fneg..2.1, i64 2, !dbg !82
  %add281.3.1 = or disjoint i32 %add280.1, 3, !dbg !83
  %cmp283.not.3.1 = icmp sgt i32 %add281.3.1, %1, !dbg !81
  %fneg..3.1 = select i1 %cmp283.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1822 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1729, float %fneg..3.1, i64 3, !dbg !82
  br label %if.end296.1

if.end296.1:                                      ; preds = %for.cond246.preheader.1, %for.cond273.preheader.1
  %acc_s.sroa.0.8 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1822, %for.cond273.preheader.1 ], [ zeroinitializer, %for.cond246.preheader.1 ], !dbg !84
  %158 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.8), !dbg !85, !call_argsrelate !86
  %159 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %158), !dbg !85, !call_argsrelate !86
  %160 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %159), !dbg !85, !call_argsrelate !86
  %161 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %160), !dbg !85, !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract1539 = extractelement <4 x float> %161, i64 0, !dbg !87
  %mul331.11382 = fmul contract float %acc_s.sroa.0.0.vec.extract1539, 0x3FB99999A0000000, !dbg !88
  %162 = tail call contract noundef float @llvm.minnum.f32(float %mul331.11382, float 0x4024CB5EC0000000), !dbg !89
  %163 = tail call contract noundef float @llvm.exp.f32(float %162), !dbg !92
  %acc_s.sroa.0.4.vec.extract1638 = extractelement <4 x float> %161, i64 1, !dbg !87
  %mul331.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1638, 0x3FB99999A0000000, !dbg !88
  %164 = tail call contract noundef float @llvm.minnum.f32(float %mul331.1.1, float 0x4024CB5EC0000000), !dbg !89
  %165 = tail call contract noundef float @llvm.exp.f32(float %164), !dbg !92
  %acc_s.sroa.0.8.vec.extract1731 = extractelement <4 x float> %161, i64 2, !dbg !87
  %mul331.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1731, 0x3FB99999A0000000, !dbg !88
  %166 = tail call contract noundef float @llvm.minnum.f32(float %mul331.2.1, float 0x4024CB5EC0000000), !dbg !89
  %167 = tail call contract noundef float @llvm.exp.f32(float %166), !dbg !92
  %acc_s.sroa.0.12.vec.extract1824 = extractelement <4 x float> %161, i64 3, !dbg !87
  %mul331.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1824, 0x3FB99999A0000000, !dbg !88
  %168 = tail call contract noundef float @llvm.minnum.f32(float %mul331.3.1, float 0x4024CB5EC0000000), !dbg !89
  %169 = tail call contract noundef float @llvm.exp.f32(float %168), !dbg !92
  %add347.11383 = fadd contract float %sum_acc.sroa.0.3, %163, !dbg !177
  %add347.1.1 = fadd contract float %sum_acc.sroa.20.3, %165, !dbg !177
  %add347.2.1 = fadd contract float %sum_acc.sroa.38.3, %167, !dbg !177
  %add347.3.1 = fadd contract float %sum_acc.sroa.56.3, %169, !dbg !177
  %170 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %163), !dbg !95
  %171 = insertelement <4 x i16> poison, i16 %170, i64 0, !dbg !104
  %172 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %165), !dbg !95
  %173 = insertelement <4 x i16> %171, i16 %172, i64 1, !dbg !104
  %174 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %167), !dbg !95
  %175 = insertelement <4 x i16> %173, i16 %174, i64 2, !dbg !104
  %176 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %169), !dbg !95
  %177 = insertelement <4 x i16> %175, i16 %176, i64 3, !dbg !104
  %acc_s_cast.sroa.0.6.vec.insert1474 = bitcast <4 x i16> %177 to <4 x half>, !dbg !104
  %178 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1871, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1474, <4 x float> %acc_o.sroa.0.0), !dbg !105, !call_argsrelate !106
  %179 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1878, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1474, <4 x float> %acc_o.sroa.38.0), !dbg !105, !call_argsrelate !106
  %180 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1899, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1474, <4 x float> %acc_o.sroa.74.0), !dbg !105, !call_argsrelate !106
  %181 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1906, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1474, <4 x float> %acc_o.sroa.110.0), !dbg !105, !call_argsrelate !106
  br label %if.end383.1, !dbg !107

if.end383.1:                                      ; preds = %if.end296.1, %if.end238.1
  %acc_o.sroa.110.1 = phi <4 x float> [ %acc_o.sroa.110.0, %if.end238.1 ], [ %181, %if.end296.1 ], !dbg !84
  %acc_o.sroa.74.1 = phi <4 x float> [ %acc_o.sroa.74.0, %if.end238.1 ], [ %180, %if.end296.1 ], !dbg !84
  %acc_o.sroa.38.1 = phi <4 x float> [ %acc_o.sroa.38.0, %if.end238.1 ], [ %179, %if.end296.1 ], !dbg !84
  %acc_o.sroa.0.1 = phi <4 x float> [ %acc_o.sroa.0.0, %if.end238.1 ], [ %178, %if.end296.1 ], !dbg !84
  %sum_acc.sroa.56.4 = phi float [ %sum_acc.sroa.56.3, %if.end238.1 ], [ %add347.3.1, %if.end296.1 ], !dbg !84
  %sum_acc.sroa.38.4 = phi float [ %sum_acc.sroa.38.3, %if.end238.1 ], [ %add347.2.1, %if.end296.1 ], !dbg !84
  %sum_acc.sroa.20.4 = phi float [ %sum_acc.sroa.20.3, %if.end238.1 ], [ %add347.1.1, %if.end296.1 ], !dbg !84
  %sum_acc.sroa.0.4 = phi float [ %sum_acc.sroa.0.3, %if.end238.1 ], [ %add347.11383, %if.end296.1 ], !dbg !84
  br i1 %or.cond1310.1, label %if.end529.1, label %for.cond391.preheader.1, !dbg !107

for.cond391.preheader.1:                          ; preds = %if.end383.1
  %182 = shl nsw i32 %cond.i.i1230.5, 10
  %mul398.1 = and i32 %182, 64512
  %add401.1 = add nuw nsw i32 %add131, %mul398.1
  %183 = zext nneg i32 %add401.1 to i64, !dbg !108
  %add.ptr406.11384 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %183, !dbg !109
  %V_reg.sroa.0.0.copyload1872 = load <4 x half>, ptr addrspace(4) %add.ptr406.11384, align 16, !dbg !110
  %V_reg.sroa.18.0.add.ptr406.11384.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr406.11384, i64 8, !dbg !110
  %V_reg.sroa.18.0.copyload1879 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr406.11384.sroa_idx, align 8, !dbg !110
  %184 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %183, !dbg !109
  %add.ptr406.1.1 = getelementptr inbounds i8, ptr addrspace(4) %184, i64 1024, !dbg !109
  %V_reg.sroa.26.16.copyload1900 = load <4 x half>, ptr addrspace(4) %add.ptr406.1.1, align 16, !dbg !110
  %V_reg.sroa.42.16.add.ptr406.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %184, i64 1032, !dbg !110
  %V_reg.sroa.42.16.copyload1907 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr406.1.1.sroa_idx, align 8, !dbg !110
  %cmp416.1 = icmp sgt i32 %mul11.5, %invariant.op, !dbg !111
  br i1 %cmp416.1, label %for.cond418.preheader.1, label %if.end442.1, !dbg !112

for.cond418.preheader.1:                          ; preds = %for.cond391.preheader.1
  %add425.1 = add nuw nsw i32 %mul11.5, %mul279
  %cmp428.not.11385 = icmp sgt i32 %add425.1, %1, !dbg !113
  %fneg.1219.11386 = select i1 %cmp428.not.11385, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1549 = insertelement <4 x float> poison, float %fneg.1219.11386, i64 0, !dbg !114
  %cmp428.not.1.1.not = icmp slt i32 %add425.1, %1, !dbg !113
  %fneg.1219.1.1 = select i1 %cmp428.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1646 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1549, float %fneg.1219.1.1, i64 1, !dbg !114
  %add426.2.1 = or disjoint i32 %add425.1, 2, !dbg !115
  %cmp428.not.2.1 = icmp sgt i32 %add426.2.1, %1, !dbg !113
  %fneg.1219.2.1 = select i1 %cmp428.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1739 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1646, float %fneg.1219.2.1, i64 2, !dbg !114
  %add426.3.1 = or disjoint i32 %add425.1, 3, !dbg !115
  %cmp428.not.3.1 = icmp sgt i32 %add426.3.1, %1, !dbg !113
  %fneg.1219.3.1 = select i1 %cmp428.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1832 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1739, float %fneg.1219.3.1, i64 3, !dbg !114
  br label %if.end442.1

if.end442.1:                                      ; preds = %for.cond391.preheader.1, %for.cond418.preheader.1
  %acc_s.sroa.0.10 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1832, %for.cond418.preheader.1 ], [ zeroinitializer, %for.cond391.preheader.1 ], !dbg !84
  %185 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.10), !dbg !116, !call_argsrelate !86
  %186 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %185), !dbg !116, !call_argsrelate !86
  %187 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %186), !dbg !116, !call_argsrelate !86
  %188 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %187), !dbg !116, !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract1551 = extractelement <4 x float> %188, i64 0, !dbg !117
  %mul477.11390 = fmul contract float %acc_s.sroa.0.0.vec.extract1551, 0x3FB99999A0000000, !dbg !118
  %189 = tail call contract noundef float @llvm.minnum.f32(float %mul477.11390, float 0x4024CB5EC0000000), !dbg !119
  %190 = tail call contract noundef float @llvm.exp.f32(float %189), !dbg !121
  %acc_s.sroa.0.4.vec.extract1648 = extractelement <4 x float> %188, i64 1, !dbg !117
  %mul477.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1648, 0x3FB99999A0000000, !dbg !118
  %191 = tail call contract noundef float @llvm.minnum.f32(float %mul477.1.1, float 0x4024CB5EC0000000), !dbg !119
  %192 = tail call contract noundef float @llvm.exp.f32(float %191), !dbg !121
  %acc_s.sroa.0.8.vec.extract1741 = extractelement <4 x float> %188, i64 2, !dbg !117
  %mul477.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1741, 0x3FB99999A0000000, !dbg !118
  %193 = tail call contract noundef float @llvm.minnum.f32(float %mul477.2.1, float 0x4024CB5EC0000000), !dbg !119
  %194 = tail call contract noundef float @llvm.exp.f32(float %193), !dbg !121
  %acc_s.sroa.0.12.vec.extract1834 = extractelement <4 x float> %188, i64 3, !dbg !117
  %mul477.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1834, 0x3FB99999A0000000, !dbg !118
  %195 = tail call contract noundef float @llvm.minnum.f32(float %mul477.3.1, float 0x4024CB5EC0000000), !dbg !119
  %196 = tail call contract noundef float @llvm.exp.f32(float %195), !dbg !121
  %add493.11391 = fadd contract float %sum_acc.sroa.0.4, %190, !dbg !123
  %add493.1.1 = fadd contract float %sum_acc.sroa.20.4, %192, !dbg !123
  %add493.2.1 = fadd contract float %sum_acc.sroa.38.4, %194, !dbg !123
  %add493.3.1 = fadd contract float %sum_acc.sroa.56.4, %196, !dbg !123
  %197 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %190), !dbg !124
  %198 = insertelement <4 x i16> poison, i16 %197, i64 0, !dbg !128
  %199 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %192), !dbg !124
  %200 = insertelement <4 x i16> %198, i16 %199, i64 1, !dbg !128
  %201 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %194), !dbg !124
  %202 = insertelement <4 x i16> %200, i16 %201, i64 2, !dbg !128
  %203 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %196), !dbg !124
  %204 = insertelement <4 x i16> %202, i16 %203, i64 3, !dbg !128
  %acc_s_cast.sroa.0.6.vec.insert1476 = bitcast <4 x i16> %204 to <4 x half>, !dbg !128
  %205 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1872, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1476, <4 x float> %acc_o_1.sroa.0.0), !dbg !129, !call_argsrelate !106
  %206 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1879, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1476, <4 x float> %acc_o_1.sroa.14.0), !dbg !129, !call_argsrelate !106
  %207 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1900, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1476, <4 x float> %acc_o_1.sroa.26.0), !dbg !129, !call_argsrelate !106
  %208 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1907, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1476, <4 x float> %acc_o_1.sroa.38.0), !dbg !129, !call_argsrelate !106
  br label %if.end529.1, !dbg !130

if.end529.1:                                      ; preds = %if.end442.1, %if.end383.1
  %acc_o_1.sroa.38.1 = phi <4 x float> [ %acc_o_1.sroa.38.0, %if.end383.1 ], [ %208, %if.end442.1 ], !dbg !84
  %acc_o_1.sroa.26.1 = phi <4 x float> [ %acc_o_1.sroa.26.0, %if.end383.1 ], [ %207, %if.end442.1 ], !dbg !84
  %acc_o_1.sroa.14.1 = phi <4 x float> [ %acc_o_1.sroa.14.0, %if.end383.1 ], [ %206, %if.end442.1 ], !dbg !84
  %acc_o_1.sroa.0.1 = phi <4 x float> [ %acc_o_1.sroa.0.0, %if.end383.1 ], [ %205, %if.end442.1 ], !dbg !84
  %sum_acc.sroa.56.5 = phi float [ %sum_acc.sroa.56.4, %if.end383.1 ], [ %add493.3.1, %if.end442.1 ], !dbg !84
  %sum_acc.sroa.38.5 = phi float [ %sum_acc.sroa.38.4, %if.end383.1 ], [ %add493.2.1, %if.end442.1 ], !dbg !84
  %sum_acc.sroa.20.5 = phi float [ %sum_acc.sroa.20.4, %if.end383.1 ], [ %add493.1.1, %if.end442.1 ], !dbg !84
  %sum_acc.sroa.0.5 = phi float [ %sum_acc.sroa.0.4, %if.end383.1 ], [ %add493.11391, %if.end442.1 ], !dbg !84
  br i1 %or.cond1312.1, label %if.end675.1, label %for.cond537.preheader.1, !dbg !130

for.cond537.preheader.1:                          ; preds = %if.end529.1
  %209 = shl nsw i32 %cond.i.i1230.6, 10
  %mul544.1 = and i32 %209, 64512
  %add547.1 = add nuw nsw i32 %add131, %mul544.1
  %210 = zext nneg i32 %add547.1 to i64, !dbg !131
  %add.ptr552.11392 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %210, !dbg !132
  %V_reg.sroa.0.0.copyload1873 = load <4 x half>, ptr addrspace(4) %add.ptr552.11392, align 16, !dbg !133
  %V_reg.sroa.18.0.add.ptr552.11392.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr552.11392, i64 8, !dbg !133
  %V_reg.sroa.18.0.copyload1880 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr552.11392.sroa_idx, align 8, !dbg !133
  %211 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %210, !dbg !132
  %add.ptr552.1.1 = getelementptr inbounds i8, ptr addrspace(4) %211, i64 1024, !dbg !132
  %V_reg.sroa.26.16.copyload1901 = load <4 x half>, ptr addrspace(4) %add.ptr552.1.1, align 16, !dbg !133
  %V_reg.sroa.42.16.add.ptr552.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %211, i64 1032, !dbg !133
  %V_reg.sroa.42.16.copyload1908 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr552.1.1.sroa_idx, align 8, !dbg !133
  %cmp562.1 = icmp sgt i32 %mul11.6, %invariant.op, !dbg !134
  br i1 %cmp562.1, label %for.cond564.preheader.1, label %if.end588.1, !dbg !135

for.cond564.preheader.1:                          ; preds = %for.cond537.preheader.1
  %add571.1 = add nuw nsw i32 %mul11.6, %mul279
  %cmp574.not.11393 = icmp sgt i32 %add571.1, %1, !dbg !136
  %fneg.1220.11394 = select i1 %cmp574.not.11393, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1561 = insertelement <4 x float> poison, float %fneg.1220.11394, i64 0, !dbg !137
  %cmp574.not.1.1.not = icmp slt i32 %add571.1, %1, !dbg !136
  %fneg.1220.1.1 = select i1 %cmp574.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1656 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1561, float %fneg.1220.1.1, i64 1, !dbg !137
  %add572.2.1 = or disjoint i32 %add571.1, 2, !dbg !138
  %cmp574.not.2.1 = icmp sgt i32 %add572.2.1, %1, !dbg !136
  %fneg.1220.2.1 = select i1 %cmp574.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1749 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1656, float %fneg.1220.2.1, i64 2, !dbg !137
  %add572.3.1 = or disjoint i32 %add571.1, 3, !dbg !138
  %cmp574.not.3.1 = icmp sgt i32 %add572.3.1, %1, !dbg !136
  %fneg.1220.3.1 = select i1 %cmp574.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1842 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1749, float %fneg.1220.3.1, i64 3, !dbg !137
  br label %if.end588.1

if.end588.1:                                      ; preds = %for.cond537.preheader.1, %for.cond564.preheader.1
  %acc_s.sroa.0.12 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1842, %for.cond564.preheader.1 ], [ zeroinitializer, %for.cond537.preheader.1 ], !dbg !84
  %212 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.12), !dbg !139, !call_argsrelate !86
  %213 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %212), !dbg !139, !call_argsrelate !86
  %214 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %213), !dbg !139, !call_argsrelate !86
  %215 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %214), !dbg !139, !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract1563 = extractelement <4 x float> %215, i64 0, !dbg !140
  %mul623.11398 = fmul contract float %acc_s.sroa.0.0.vec.extract1563, 0x3FB99999A0000000, !dbg !141
  %216 = tail call contract noundef float @llvm.minnum.f32(float %mul623.11398, float 0x4024CB5EC0000000), !dbg !142
  %217 = tail call contract noundef float @llvm.exp.f32(float %216), !dbg !144
  %acc_s.sroa.0.4.vec.extract1658 = extractelement <4 x float> %215, i64 1, !dbg !140
  %mul623.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1658, 0x3FB99999A0000000, !dbg !141
  %218 = tail call contract noundef float @llvm.minnum.f32(float %mul623.1.1, float 0x4024CB5EC0000000), !dbg !142
  %219 = tail call contract noundef float @llvm.exp.f32(float %218), !dbg !144
  %acc_s.sroa.0.8.vec.extract1751 = extractelement <4 x float> %215, i64 2, !dbg !140
  %mul623.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1751, 0x3FB99999A0000000, !dbg !141
  %220 = tail call contract noundef float @llvm.minnum.f32(float %mul623.2.1, float 0x4024CB5EC0000000), !dbg !142
  %221 = tail call contract noundef float @llvm.exp.f32(float %220), !dbg !144
  %acc_s.sroa.0.12.vec.extract1844 = extractelement <4 x float> %215, i64 3, !dbg !140
  %mul623.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1844, 0x3FB99999A0000000, !dbg !141
  %222 = tail call contract noundef float @llvm.minnum.f32(float %mul623.3.1, float 0x4024CB5EC0000000), !dbg !142
  %223 = tail call contract noundef float @llvm.exp.f32(float %222), !dbg !144
  %add639.11399 = fadd contract float %sum_acc.sroa.0.5, %217, !dbg !146
  %add639.1.1 = fadd contract float %sum_acc.sroa.20.5, %219, !dbg !146
  %add639.2.1 = fadd contract float %sum_acc.sroa.38.5, %221, !dbg !146
  %add639.3.1 = fadd contract float %sum_acc.sroa.56.5, %223, !dbg !146
  %224 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %217), !dbg !147
  %225 = insertelement <4 x i16> poison, i16 %224, i64 0, !dbg !151
  %226 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %219), !dbg !147
  %227 = insertelement <4 x i16> %225, i16 %226, i64 1, !dbg !151
  %228 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %221), !dbg !147
  %229 = insertelement <4 x i16> %227, i16 %228, i64 2, !dbg !151
  %230 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %223), !dbg !147
  %231 = insertelement <4 x i16> %229, i16 %230, i64 3, !dbg !151
  %acc_s_cast.sroa.0.6.vec.insert1478 = bitcast <4 x i16> %231 to <4 x half>, !dbg !151
  %232 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1873, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1478, <4 x float> %acc_o_2.sroa.0.0), !dbg !152, !call_argsrelate !106
  %233 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1880, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1478, <4 x float> %acc_o_2.sroa.14.0), !dbg !152, !call_argsrelate !106
  %234 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1901, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1478, <4 x float> %acc_o_2.sroa.26.0), !dbg !152, !call_argsrelate !106
  %235 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1908, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1478, <4 x float> %acc_o_2.sroa.38.0), !dbg !152, !call_argsrelate !106
  br label %if.end675.1, !dbg !153

if.end675.1:                                      ; preds = %if.end588.1, %if.end529.1
  %acc_o_2.sroa.38.1 = phi <4 x float> [ %acc_o_2.sroa.38.0, %if.end529.1 ], [ %235, %if.end588.1 ], !dbg !84
  %acc_o_2.sroa.26.1 = phi <4 x float> [ %acc_o_2.sroa.26.0, %if.end529.1 ], [ %234, %if.end588.1 ], !dbg !84
  %acc_o_2.sroa.14.1 = phi <4 x float> [ %acc_o_2.sroa.14.0, %if.end529.1 ], [ %233, %if.end588.1 ], !dbg !84
  %acc_o_2.sroa.0.1 = phi <4 x float> [ %acc_o_2.sroa.0.0, %if.end529.1 ], [ %232, %if.end588.1 ], !dbg !84
  %sum_acc.sroa.56.6 = phi float [ %sum_acc.sroa.56.5, %if.end529.1 ], [ %add639.3.1, %if.end588.1 ], !dbg !84
  %sum_acc.sroa.38.6 = phi float [ %sum_acc.sroa.38.5, %if.end529.1 ], [ %add639.2.1, %if.end588.1 ], !dbg !84
  %sum_acc.sroa.20.6 = phi float [ %sum_acc.sroa.20.5, %if.end529.1 ], [ %add639.1.1, %if.end588.1 ], !dbg !84
  %sum_acc.sroa.0.6 = phi float [ %sum_acc.sroa.0.5, %if.end529.1 ], [ %add639.11399, %if.end588.1 ], !dbg !84
  br i1 %or.cond1314.1, label %if.end821.1, label %for.cond683.preheader.1, !dbg !153

for.cond683.preheader.1:                          ; preds = %if.end675.1
  %236 = shl nsw i32 %cond.i.i1230.7, 10
  %mul690.1 = and i32 %236, 64512
  %add693.1 = add nuw nsw i32 %add131, %mul690.1
  %237 = zext nneg i32 %add693.1 to i64, !dbg !154
  %add.ptr698.11400 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %237, !dbg !155
  %V_reg.sroa.0.0.copyload1874 = load <4 x half>, ptr addrspace(4) %add.ptr698.11400, align 16, !dbg !156
  %V_reg.sroa.18.0.add.ptr698.11400.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr698.11400, i64 8, !dbg !156
  %V_reg.sroa.18.0.copyload1881 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.18.0.add.ptr698.11400.sroa_idx, align 8, !dbg !156
  %238 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %237, !dbg !155
  %add.ptr698.1.1 = getelementptr inbounds i8, ptr addrspace(4) %238, i64 1024, !dbg !155
  %V_reg.sroa.26.16.copyload1902 = load <4 x half>, ptr addrspace(4) %add.ptr698.1.1, align 16, !dbg !156
  %V_reg.sroa.42.16.add.ptr698.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %238, i64 1032, !dbg !156
  %V_reg.sroa.42.16.copyload1909 = load <4 x half>, ptr addrspace(4) %V_reg.sroa.42.16.add.ptr698.1.1.sroa_idx, align 8, !dbg !156
  %cmp708.1 = icmp sgt i32 %mul11.7, %invariant.op, !dbg !157
  br i1 %cmp708.1, label %for.cond710.preheader.1, label %if.end734.1, !dbg !158

for.cond710.preheader.1:                          ; preds = %for.cond683.preheader.1
  %add717.1 = add nuw nsw i32 %mul11.7, %mul279
  %cmp720.not.11401 = icmp sgt i32 %add717.1, %1, !dbg !159
  %fneg.1221.11402 = select i1 %cmp720.not.11401, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1573 = insertelement <4 x float> poison, float %fneg.1221.11402, i64 0, !dbg !160
  %cmp720.not.1.1.not = icmp slt i32 %add717.1, %1, !dbg !159
  %fneg.1221.1.1 = select i1 %cmp720.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1666 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1573, float %fneg.1221.1.1, i64 1, !dbg !160
  %add718.2.1 = or disjoint i32 %add717.1, 2, !dbg !161
  %cmp720.not.2.1 = icmp sgt i32 %add718.2.1, %1, !dbg !159
  %fneg.1221.2.1 = select i1 %cmp720.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1759 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1666, float %fneg.1221.2.1, i64 2, !dbg !160
  %add718.3.1 = or disjoint i32 %add717.1, 3, !dbg !161
  %cmp720.not.3.1 = icmp sgt i32 %add718.3.1, %1, !dbg !159
  %fneg.1221.3.1 = select i1 %cmp720.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1852 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1759, float %fneg.1221.3.1, i64 3, !dbg !160
  br label %if.end734.1

if.end734.1:                                      ; preds = %for.cond683.preheader.1, %for.cond710.preheader.1
  %acc_s.sroa.0.14 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1852, %for.cond710.preheader.1 ], [ zeroinitializer, %for.cond683.preheader.1 ], !dbg !84
  %239 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.14), !dbg !162, !call_argsrelate !86
  %240 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.6.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %239), !dbg !162, !call_argsrelate !86
  %241 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.8.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %240), !dbg !162, !call_argsrelate !86
  %242 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.12.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %241), !dbg !162, !call_argsrelate !86
  %acc_s.sroa.0.0.vec.extract1575 = extractelement <4 x float> %242, i64 0, !dbg !163
  %mul769.11406 = fmul contract float %acc_s.sroa.0.0.vec.extract1575, 0x3FB99999A0000000, !dbg !164
  %243 = tail call contract noundef float @llvm.minnum.f32(float %mul769.11406, float 0x4024CB5EC0000000), !dbg !165
  %244 = tail call contract noundef float @llvm.exp.f32(float %243), !dbg !167
  %acc_s.sroa.0.4.vec.extract1668 = extractelement <4 x float> %242, i64 1, !dbg !163
  %mul769.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1668, 0x3FB99999A0000000, !dbg !164
  %245 = tail call contract noundef float @llvm.minnum.f32(float %mul769.1.1, float 0x4024CB5EC0000000), !dbg !165
  %246 = tail call contract noundef float @llvm.exp.f32(float %245), !dbg !167
  %acc_s.sroa.0.8.vec.extract1761 = extractelement <4 x float> %242, i64 2, !dbg !163
  %mul769.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1761, 0x3FB99999A0000000, !dbg !164
  %247 = tail call contract noundef float @llvm.minnum.f32(float %mul769.2.1, float 0x4024CB5EC0000000), !dbg !165
  %248 = tail call contract noundef float @llvm.exp.f32(float %247), !dbg !167
  %acc_s.sroa.0.12.vec.extract1854 = extractelement <4 x float> %242, i64 3, !dbg !163
  %mul769.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1854, 0x3FB99999A0000000, !dbg !164
  %249 = tail call contract noundef float @llvm.minnum.f32(float %mul769.3.1, float 0x4024CB5EC0000000), !dbg !165
  %250 = tail call contract noundef float @llvm.exp.f32(float %249), !dbg !167
  %add785.11407 = fadd contract float %sum_acc.sroa.0.6, %244, !dbg !169
  %add785.1.1 = fadd contract float %sum_acc.sroa.20.6, %246, !dbg !169
  %add785.2.1 = fadd contract float %sum_acc.sroa.38.6, %248, !dbg !169
  %add785.3.1 = fadd contract float %sum_acc.sroa.56.6, %250, !dbg !169
  %251 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %244), !dbg !170
  %252 = insertelement <4 x i16> poison, i16 %251, i64 0, !dbg !174
  %253 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %246), !dbg !170
  %254 = insertelement <4 x i16> %252, i16 %253, i64 1, !dbg !174
  %255 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %248), !dbg !170
  %256 = insertelement <4 x i16> %254, i16 %255, i64 2, !dbg !174
  %257 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %250), !dbg !170
  %258 = insertelement <4 x i16> %256, i16 %257, i64 3, !dbg !174
  %acc_s_cast.sroa.0.6.vec.insert1480 = bitcast <4 x i16> %258 to <4 x half>, !dbg !174
  %259 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.0.0.copyload1874, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1480, <4 x float> %acc_o_3.sroa.0.0), !dbg !175, !call_argsrelate !106
  %260 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.18.0.copyload1881, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1480, <4 x float> %acc_o_3.sroa.14.0), !dbg !175, !call_argsrelate !106
  %261 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.26.16.copyload1902, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1480, <4 x float> %acc_o_3.sroa.26.0), !dbg !175, !call_argsrelate !106
  %262 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %V_reg.sroa.42.16.copyload1909, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1480, <4 x float> %acc_o_3.sroa.38.0), !dbg !175, !call_argsrelate !106
  br label %if.end821.1, !dbg !176

if.end821.1:                                      ; preds = %if.end734.1, %if.end675.1
  %acc_o_3.sroa.38.1 = phi <4 x float> [ %acc_o_3.sroa.38.0, %if.end675.1 ], [ %262, %if.end734.1 ], !dbg !84
  %acc_o_3.sroa.26.1 = phi <4 x float> [ %acc_o_3.sroa.26.0, %if.end675.1 ], [ %261, %if.end734.1 ], !dbg !84
  %acc_o_3.sroa.14.1 = phi <4 x float> [ %acc_o_3.sroa.14.0, %if.end675.1 ], [ %260, %if.end734.1 ], !dbg !84
  %acc_o_3.sroa.0.1 = phi <4 x float> [ %acc_o_3.sroa.0.0, %if.end675.1 ], [ %259, %if.end734.1 ], !dbg !84
  %sum_acc.sroa.56.7 = phi float [ %sum_acc.sroa.56.6, %if.end675.1 ], [ %add785.3.1, %if.end734.1 ], !dbg !84
  %sum_acc.sroa.38.7 = phi float [ %sum_acc.sroa.38.6, %if.end675.1 ], [ %add785.2.1, %if.end734.1 ], !dbg !84
  %sum_acc.sroa.20.7 = phi float [ %sum_acc.sroa.20.6, %if.end675.1 ], [ %add785.1.1, %if.end734.1 ], !dbg !84
  %sum_acc.sroa.0.7 = phi float [ %sum_acc.sroa.0.6, %if.end675.1 ], [ %add785.11407, %if.end734.1 ], !dbg !84
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 0, !dbg !178
  %acc_o_1.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_1.sroa.0.1, i64 0, !dbg !179
  %add833 = fadd contract float %acc_o.sroa.0.0.vec.extract, %acc_o_1.sroa.0.0.vec.extract, !dbg !180
  %acc_o_2.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_2.sroa.0.1, i64 0, !dbg !181
  %add840 = fadd contract float %add833, %acc_o_2.sroa.0.0.vec.extract, !dbg !182
  %acc_o_3.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_3.sroa.0.1, i64 0, !dbg !183
  %add847 = fadd contract float %add840, %acc_o_3.sroa.0.0.vec.extract, !dbg !184
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 1, !dbg !178
  %acc_o_1.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_1.sroa.0.1, i64 1, !dbg !179
  %add833.1 = fadd contract float %acc_o.sroa.0.4.vec.extract, %acc_o_1.sroa.0.4.vec.extract, !dbg !180
  %acc_o_2.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_2.sroa.0.1, i64 1, !dbg !181
  %add840.1 = fadd contract float %add833.1, %acc_o_2.sroa.0.4.vec.extract, !dbg !182
  %acc_o_3.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_3.sroa.0.1, i64 1, !dbg !183
  %add847.1 = fadd contract float %add840.1, %acc_o_3.sroa.0.4.vec.extract, !dbg !184
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 2, !dbg !178
  %acc_o_1.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_1.sroa.0.1, i64 2, !dbg !179
  %add833.2 = fadd contract float %acc_o.sroa.0.8.vec.extract, %acc_o_1.sroa.0.8.vec.extract, !dbg !180
  %acc_o_2.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_2.sroa.0.1, i64 2, !dbg !181
  %add840.2 = fadd contract float %add833.2, %acc_o_2.sroa.0.8.vec.extract, !dbg !182
  %acc_o_3.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_3.sroa.0.1, i64 2, !dbg !183
  %add847.2 = fadd contract float %add840.2, %acc_o_3.sroa.0.8.vec.extract, !dbg !184
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 3, !dbg !178
  %acc_o_1.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_1.sroa.0.1, i64 3, !dbg !179
  %add833.3 = fadd contract float %acc_o.sroa.0.12.vec.extract, %acc_o_1.sroa.0.12.vec.extract, !dbg !180
  %acc_o_2.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_2.sroa.0.1, i64 3, !dbg !181
  %add840.3 = fadd contract float %add833.3, %acc_o_2.sroa.0.12.vec.extract, !dbg !182
  %acc_o_3.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_3.sroa.0.1, i64 3, !dbg !183
  %add847.3 = fadd contract float %add840.3, %acc_o_3.sroa.0.12.vec.extract, !dbg !184
  %acc_o.sroa.38.16.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1, i64 0, !dbg !178
  %acc_o_1.sroa.14.16.vec.extract = extractelement <4 x float> %acc_o_1.sroa.14.1, i64 0, !dbg !179
  %add833.4 = fadd contract float %acc_o.sroa.38.16.vec.extract, %acc_o_1.sroa.14.16.vec.extract, !dbg !180
  %acc_o_2.sroa.14.16.vec.extract = extractelement <4 x float> %acc_o_2.sroa.14.1, i64 0, !dbg !181
  %add840.4 = fadd contract float %add833.4, %acc_o_2.sroa.14.16.vec.extract, !dbg !182
  %acc_o_3.sroa.14.16.vec.extract = extractelement <4 x float> %acc_o_3.sroa.14.1, i64 0, !dbg !183
  %add847.4 = fadd contract float %add840.4, %acc_o_3.sroa.14.16.vec.extract, !dbg !184
  %acc_o.sroa.38.20.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1, i64 1, !dbg !178
  %acc_o_1.sroa.14.20.vec.extract = extractelement <4 x float> %acc_o_1.sroa.14.1, i64 1, !dbg !179
  %add833.5 = fadd contract float %acc_o.sroa.38.20.vec.extract, %acc_o_1.sroa.14.20.vec.extract, !dbg !180
  %acc_o_2.sroa.14.20.vec.extract = extractelement <4 x float> %acc_o_2.sroa.14.1, i64 1, !dbg !181
  %add840.5 = fadd contract float %add833.5, %acc_o_2.sroa.14.20.vec.extract, !dbg !182
  %acc_o_3.sroa.14.20.vec.extract = extractelement <4 x float> %acc_o_3.sroa.14.1, i64 1, !dbg !183
  %add847.5 = fadd contract float %add840.5, %acc_o_3.sroa.14.20.vec.extract, !dbg !184
  %acc_o.sroa.38.24.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1, i64 2, !dbg !178
  %acc_o_1.sroa.14.24.vec.extract = extractelement <4 x float> %acc_o_1.sroa.14.1, i64 2, !dbg !179
  %add833.6 = fadd contract float %acc_o.sroa.38.24.vec.extract, %acc_o_1.sroa.14.24.vec.extract, !dbg !180
  %acc_o_2.sroa.14.24.vec.extract = extractelement <4 x float> %acc_o_2.sroa.14.1, i64 2, !dbg !181
  %add840.6 = fadd contract float %add833.6, %acc_o_2.sroa.14.24.vec.extract, !dbg !182
  %acc_o_3.sroa.14.24.vec.extract = extractelement <4 x float> %acc_o_3.sroa.14.1, i64 2, !dbg !183
  %add847.6 = fadd contract float %add840.6, %acc_o_3.sroa.14.24.vec.extract, !dbg !184
  %acc_o.sroa.38.28.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1, i64 3, !dbg !178
  %acc_o_1.sroa.14.28.vec.extract = extractelement <4 x float> %acc_o_1.sroa.14.1, i64 3, !dbg !179
  %add833.7 = fadd contract float %acc_o.sroa.38.28.vec.extract, %acc_o_1.sroa.14.28.vec.extract, !dbg !180
  %acc_o_2.sroa.14.28.vec.extract = extractelement <4 x float> %acc_o_2.sroa.14.1, i64 3, !dbg !181
  %add840.7 = fadd contract float %add833.7, %acc_o_2.sroa.14.28.vec.extract, !dbg !182
  %acc_o_3.sroa.14.28.vec.extract = extractelement <4 x float> %acc_o_3.sroa.14.1, i64 3, !dbg !183
  %add847.7 = fadd contract float %add840.7, %acc_o_3.sroa.14.28.vec.extract, !dbg !184
  %acc_o.sroa.74.32.vec.extract = extractelement <4 x float> %acc_o.sroa.74.1, i64 0, !dbg !178
  %acc_o_1.sroa.26.32.vec.extract = extractelement <4 x float> %acc_o_1.sroa.26.1, i64 0, !dbg !179
  %add833.8 = fadd contract float %acc_o.sroa.74.32.vec.extract, %acc_o_1.sroa.26.32.vec.extract, !dbg !180
  %acc_o_2.sroa.26.32.vec.extract = extractelement <4 x float> %acc_o_2.sroa.26.1, i64 0, !dbg !181
  %add840.8 = fadd contract float %add833.8, %acc_o_2.sroa.26.32.vec.extract, !dbg !182
  %acc_o_3.sroa.26.32.vec.extract = extractelement <4 x float> %acc_o_3.sroa.26.1, i64 0, !dbg !183
  %add847.8 = fadd contract float %add840.8, %acc_o_3.sroa.26.32.vec.extract, !dbg !184
  %acc_o.sroa.74.36.vec.extract = extractelement <4 x float> %acc_o.sroa.74.1, i64 1, !dbg !178
  %acc_o_1.sroa.26.36.vec.extract = extractelement <4 x float> %acc_o_1.sroa.26.1, i64 1, !dbg !179
  %add833.9 = fadd contract float %acc_o.sroa.74.36.vec.extract, %acc_o_1.sroa.26.36.vec.extract, !dbg !180
  %acc_o_2.sroa.26.36.vec.extract = extractelement <4 x float> %acc_o_2.sroa.26.1, i64 1, !dbg !181
  %add840.9 = fadd contract float %add833.9, %acc_o_2.sroa.26.36.vec.extract, !dbg !182
  %acc_o_3.sroa.26.36.vec.extract = extractelement <4 x float> %acc_o_3.sroa.26.1, i64 1, !dbg !183
  %add847.9 = fadd contract float %add840.9, %acc_o_3.sroa.26.36.vec.extract, !dbg !184
  %acc_o.sroa.74.40.vec.extract = extractelement <4 x float> %acc_o.sroa.74.1, i64 2, !dbg !178
  %acc_o_1.sroa.26.40.vec.extract = extractelement <4 x float> %acc_o_1.sroa.26.1, i64 2, !dbg !179
  %add833.10 = fadd contract float %acc_o.sroa.74.40.vec.extract, %acc_o_1.sroa.26.40.vec.extract, !dbg !180
  %acc_o_2.sroa.26.40.vec.extract = extractelement <4 x float> %acc_o_2.sroa.26.1, i64 2, !dbg !181
  %add840.10 = fadd contract float %add833.10, %acc_o_2.sroa.26.40.vec.extract, !dbg !182
  %acc_o_3.sroa.26.40.vec.extract = extractelement <4 x float> %acc_o_3.sroa.26.1, i64 2, !dbg !183
  %add847.10 = fadd contract float %add840.10, %acc_o_3.sroa.26.40.vec.extract, !dbg !184
  %acc_o.sroa.74.44.vec.extract = extractelement <4 x float> %acc_o.sroa.74.1, i64 3, !dbg !178
  %acc_o_1.sroa.26.44.vec.extract = extractelement <4 x float> %acc_o_1.sroa.26.1, i64 3, !dbg !179
  %add833.11 = fadd contract float %acc_o.sroa.74.44.vec.extract, %acc_o_1.sroa.26.44.vec.extract, !dbg !180
  %acc_o_2.sroa.26.44.vec.extract = extractelement <4 x float> %acc_o_2.sroa.26.1, i64 3, !dbg !181
  %add840.11 = fadd contract float %add833.11, %acc_o_2.sroa.26.44.vec.extract, !dbg !182
  %acc_o_3.sroa.26.44.vec.extract = extractelement <4 x float> %acc_o_3.sroa.26.1, i64 3, !dbg !183
  %add847.11 = fadd contract float %add840.11, %acc_o_3.sroa.26.44.vec.extract, !dbg !184
  %acc_o.sroa.110.48.vec.extract = extractelement <4 x float> %acc_o.sroa.110.1, i64 0, !dbg !178
  %acc_o_1.sroa.38.48.vec.extract = extractelement <4 x float> %acc_o_1.sroa.38.1, i64 0, !dbg !179
  %add833.12 = fadd contract float %acc_o.sroa.110.48.vec.extract, %acc_o_1.sroa.38.48.vec.extract, !dbg !180
  %acc_o_2.sroa.38.48.vec.extract = extractelement <4 x float> %acc_o_2.sroa.38.1, i64 0, !dbg !181
  %add840.12 = fadd contract float %add833.12, %acc_o_2.sroa.38.48.vec.extract, !dbg !182
  %acc_o_3.sroa.38.48.vec.extract = extractelement <4 x float> %acc_o_3.sroa.38.1, i64 0, !dbg !183
  %add847.12 = fadd contract float %add840.12, %acc_o_3.sroa.38.48.vec.extract, !dbg !184
  %acc_o.sroa.110.52.vec.extract = extractelement <4 x float> %acc_o.sroa.110.1, i64 1, !dbg !178
  %acc_o_1.sroa.38.52.vec.extract = extractelement <4 x float> %acc_o_1.sroa.38.1, i64 1, !dbg !179
  %add833.13 = fadd contract float %acc_o.sroa.110.52.vec.extract, %acc_o_1.sroa.38.52.vec.extract, !dbg !180
  %acc_o_2.sroa.38.52.vec.extract = extractelement <4 x float> %acc_o_2.sroa.38.1, i64 1, !dbg !181
  %add840.13 = fadd contract float %add833.13, %acc_o_2.sroa.38.52.vec.extract, !dbg !182
  %acc_o_3.sroa.38.52.vec.extract = extractelement <4 x float> %acc_o_3.sroa.38.1, i64 1, !dbg !183
  %add847.13 = fadd contract float %add840.13, %acc_o_3.sroa.38.52.vec.extract, !dbg !184
  %acc_o.sroa.110.56.vec.extract = extractelement <4 x float> %acc_o.sroa.110.1, i64 2, !dbg !178
  %acc_o_1.sroa.38.56.vec.extract = extractelement <4 x float> %acc_o_1.sroa.38.1, i64 2, !dbg !179
  %add833.14 = fadd contract float %acc_o.sroa.110.56.vec.extract, %acc_o_1.sroa.38.56.vec.extract, !dbg !180
  %acc_o_2.sroa.38.56.vec.extract = extractelement <4 x float> %acc_o_2.sroa.38.1, i64 2, !dbg !181
  %add840.14 = fadd contract float %add833.14, %acc_o_2.sroa.38.56.vec.extract, !dbg !182
  %acc_o_3.sroa.38.56.vec.extract = extractelement <4 x float> %acc_o_3.sroa.38.1, i64 2, !dbg !183
  %add847.14 = fadd contract float %add840.14, %acc_o_3.sroa.38.56.vec.extract, !dbg !184
  %acc_o.sroa.110.60.vec.extract = extractelement <4 x float> %acc_o.sroa.110.1, i64 3, !dbg !178
  %acc_o_1.sroa.38.60.vec.extract = extractelement <4 x float> %acc_o_1.sroa.38.1, i64 3, !dbg !179
  %add833.15 = fadd contract float %acc_o.sroa.110.60.vec.extract, %acc_o_1.sroa.38.60.vec.extract, !dbg !180
  %acc_o_2.sroa.38.60.vec.extract = extractelement <4 x float> %acc_o_2.sroa.38.1, i64 3, !dbg !181
  %add840.15 = fadd contract float %add833.15, %acc_o_2.sroa.38.60.vec.extract, !dbg !182
  %acc_o_3.sroa.38.60.vec.extract = extractelement <4 x float> %acc_o_3.sroa.38.1, i64 3, !dbg !183
  %add847.15 = fadd contract float %add840.15, %acc_o_3.sroa.38.60.vec.extract, !dbg !184
  %add861 = fadd contract float %sum_acc.sroa.0.7, 0.000000e+00, !dbg !185
  %add861.1 = fadd contract float %add861, %sum_acc.sroa.20.7, !dbg !185
  %add861.2 = fadd contract float %add861.1, %sum_acc.sroa.38.7, !dbg !185
  %add861.3 = fadd contract float %add861.2, %sum_acc.sroa.56.7, !dbg !185
  %263 = bitcast float %add861.3 to i32, !dbg !186
  %264 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !198
  %265 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %264) #11, !dbg !203
  %xor.i.i = xor i32 %265, 32, !dbg !204
  %266 = and i32 %265, -64, !dbg !205
  %and.i.i = add nsw i32 %266, 64, !dbg !205
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !206
  %cond.i.i1231 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %265, !dbg !207
  %shl.i.i = shl i32 %cond.i.i1231, 2, !dbg !208
  %267 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %263), !dbg !209
  %268 = bitcast i32 %267 to float, !dbg !210
  %add.i = fadd contract float %add861.3, %268, !dbg !211
  %269 = bitcast float %add.i to i32, !dbg !214
  %270 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !221
  %271 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %270) #11, !dbg !224
  %xor.i.i1232 = xor i32 %271, 16, !dbg !225
  %272 = and i32 %271, -64, !dbg !226
  %and.i.i1233 = add nsw i32 %272, 64, !dbg !226
  %cmp.not.i.i1234 = icmp slt i32 %xor.i.i1232, %and.i.i1233, !dbg !227
  %cond.i.i1235 = select i1 %cmp.not.i.i1234, i32 %xor.i.i1232, i32 %271, !dbg !228
  %shl.i.i1236 = shl i32 %cond.i.i1235, 2, !dbg !229
  %273 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i1236, i32 %269), !dbg !230
  %274 = bitcast i32 %273 to float, !dbg !231
  %add.i.i = fadd contract float %add.i, %274, !dbg !232
  %cmp870 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !234
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !235
  %condval_4.0 = select i1 %cmp870, float %div, float 0.000000e+00, !dbg !235
  %mul883 = fmul contract float %condval_4.0, %add847, !dbg !236
  %mul883.1 = fmul contract float %condval_4.0, %add847.1, !dbg !236
  %mul883.2 = fmul contract float %condval_4.0, %add847.2, !dbg !236
  %mul883.3 = fmul contract float %condval_4.0, %add847.3, !dbg !236
  %mul883.4 = fmul contract float %condval_4.0, %add847.4, !dbg !236
  %mul883.5 = fmul contract float %condval_4.0, %add847.5, !dbg !236
  %mul883.6 = fmul contract float %condval_4.0, %add847.6, !dbg !236
  %mul883.7 = fmul contract float %condval_4.0, %add847.7, !dbg !236
  %mul883.8 = fmul contract float %condval_4.0, %add847.8, !dbg !236
  %mul883.9 = fmul contract float %condval_4.0, %add847.9, !dbg !236
  %mul883.10 = fmul contract float %condval_4.0, %add847.10, !dbg !236
  %mul883.11 = fmul contract float %condval_4.0, %add847.11, !dbg !236
  %mul883.12 = fmul contract float %condval_4.0, %add847.12, !dbg !236
  %mul883.13 = fmul contract float %condval_4.0, %add847.13, !dbg !236
  %mul883.14 = fmul contract float %condval_4.0, %add847.14, !dbg !236
  %mul883.15 = fmul contract float %condval_4.0, %add847.15, !dbg !236
  %275 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883), !dbg !237
  %O_reg.sroa.0.0.insert.ext = zext i16 %275 to i64, !dbg !241
  %276 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883.1), !dbg !237
  %O_reg.sroa.0.2.insert.ext = zext i16 %276 to i64, !dbg !241
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !241
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !241
  %277 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883.2), !dbg !237
  %O_reg.sroa.0.4.insert.ext = zext i16 %277 to i64, !dbg !241
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !241
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !241
  %278 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883.3), !dbg !237
  %O_reg.sroa.0.6.insert.ext = zext i16 %278 to i64, !dbg !241
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !241
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !241
  %279 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883.4), !dbg !237
  %O_reg.sroa.7.8.insert.ext = zext i16 %279 to i64, !dbg !241
  %280 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883.5), !dbg !237
  %O_reg.sroa.7.10.insert.ext = zext i16 %280 to i64, !dbg !241
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !241
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !241
  %281 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883.6), !dbg !237
  %O_reg.sroa.7.12.insert.ext = zext i16 %281 to i64, !dbg !241
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !241
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !241
  %282 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883.7), !dbg !237
  %O_reg.sroa.7.14.insert.ext = zext i16 %282 to i64, !dbg !241
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !241
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !241
  %283 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883.8), !dbg !237
  %O_reg.sroa.12.16.insert.ext = zext i16 %283 to i64, !dbg !241
  %284 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883.9), !dbg !237
  %O_reg.sroa.12.18.insert.ext = zext i16 %284 to i64, !dbg !241
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !241
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !241
  %285 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883.10), !dbg !237
  %O_reg.sroa.12.20.insert.ext = zext i16 %285 to i64, !dbg !241
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !241
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !241
  %286 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883.11), !dbg !237
  %O_reg.sroa.12.22.insert.ext = zext i16 %286 to i64, !dbg !241
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !241
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !241
  %287 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883.12), !dbg !237
  %O_reg.sroa.17.24.insert.ext = zext i16 %287 to i64, !dbg !241
  %288 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883.13), !dbg !237
  %O_reg.sroa.17.26.insert.ext = zext i16 %288 to i64, !dbg !241
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !241
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !241
  %289 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883.14), !dbg !237
  %O_reg.sroa.17.28.insert.ext = zext i16 %289 to i64, !dbg !241
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !241
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !241
  %290 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul883.15), !dbg !237
  %O_reg.sroa.17.30.insert.ext = zext i16 %290 to i64, !dbg !241
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !241
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !241
  %shr925 = lshr i32 %18, 5
  %and928 = and i32 %18, 7
  %mul934 = and i32 %22, 4
  %xor = xor i32 %shr925, %and928, !dbg !242
  %mul929 = shl nuw nsw i32 %xor, 3, !dbg !243
  %add930 = add nuw nsw i32 %mul929, %mul25, !dbg !244
  %add935 = or disjoint i32 %add930, %mul934, !dbg !245
  %add.ptr937 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add935, !dbg !246
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr937, align 8, !dbg !247
  %add926.1 = add nuw nsw i32 %shr925, 2, !dbg !248
  %xor.1 = xor i32 %add926.1, %and928, !dbg !242
  %mul929.1 = shl nuw nsw i32 %xor.1, 3, !dbg !243
  %add930.1 = add nuw nsw i32 %mul929.1, %mul25, !dbg !244
  %add935.1 = or disjoint i32 %add930.1, %mul934, !dbg !245
  %add.ptr937.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add935.1, !dbg !246
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr937.1, align 8, !dbg !247
  %add926.2 = add nuw nsw i32 %shr925, 4, !dbg !248
  %xor.2 = xor i32 %add926.2, %and928, !dbg !242
  %mul929.2 = shl nuw nsw i32 %xor.2, 3, !dbg !243
  %add930.2 = add nuw nsw i32 %mul929.2, %mul25, !dbg !244
  %add935.2 = or disjoint i32 %add930.2, %mul934, !dbg !245
  %add.ptr937.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add935.2, !dbg !246
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr937.2, align 8, !dbg !247
  %add926.3 = add nuw nsw i32 %shr925, 6, !dbg !248
  %xor.3 = xor i32 %add926.3, %and928, !dbg !242
  %mul929.3 = shl nuw nsw i32 %xor.3, 3, !dbg !243
  %add930.3 = add nuw nsw i32 %mul929.3, %mul25, !dbg !244
  %add935.3 = or disjoint i32 %add930.3, %mul934, !dbg !245
  %add.ptr937.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add935.3, !dbg !246
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr937.3, align 8, !dbg !247
  fence syncscope("warp") release, !dbg !249
  tail call void @llvm.mxc.barrier.warp(), !dbg !254
  fence syncscope("warp") acquire, !dbg !255
  %mul948 = and i32 %mul135, 8128
  %xor9541217 = and i32 %mul135, 56
  %call952.masked = and i32 %18, 1016
  %mul955 = xor i32 %xor9541217, %call952.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul948, !dbg !256
  %invariant.gep1305 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul955, !dbg !256
  %add965 = add nuw nsw i32 %add23, %mul135
  %291 = zext nneg i32 %add965 to i64, !dbg !257
  %add.ptr970 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %291, !dbg !258
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr970, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep1305, i64 16, i1 false), !dbg !259, !tbaa.struct !260, !call_argsrelate !261
  %gep1306.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep1305, i32 1024, !dbg !262
  %292 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %291, !dbg !258
  %add.ptr970.1 = getelementptr inbounds i8, ptr addrspace(1) %292, i64 1024, !dbg !258
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr970.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep1306.1, i64 16, i1 false), !dbg !259, !tbaa.struct !260, !call_argsrelate !261
  ret void, !dbg !263
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
!1 = !DIFile(filename: "/tmp/tmpgmunruiq/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpgmunruiq/tvm_kernels.maca", directory: "")
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
!58 = !DILocation(line: 61, column: 3, scope: !40)
!59 = !DILocation(line: 66, column: 22, scope: !40)
!60 = !DILocation(line: 68, column: 7, scope: !40)
!61 = !DILocation(line: 69, column: 52, scope: !40)
!62 = !DILocation(line: 69, column: 38, scope: !40)
!63 = !DILocation(line: 72, column: 22, scope: !40)
!64 = !DILocation(line: 74, column: 7, scope: !40)
!65 = !DILocation(line: 75, column: 53, scope: !40)
!66 = !DILocation(line: 75, column: 39, scope: !40)
!67 = !DILocation(line: 78, column: 22, scope: !40)
!68 = !DILocation(line: 80, column: 7, scope: !40)
!69 = !DILocation(line: 81, column: 53, scope: !40)
!70 = !DILocation(line: 81, column: 39, scope: !40)
!71 = !DILocation(line: 84, column: 22, scope: !40)
!72 = !DILocation(line: 86, column: 7, scope: !40)
!73 = !DILocation(line: 87, column: 53, scope: !40)
!74 = !DILocation(line: 87, column: 39, scope: !40)
!75 = !DILocation(line: 90, column: 22, scope: !40)
!76 = !DILocation(line: 92, column: 7, scope: !40)
!77 = !DILocation(line: 93, column: 52, scope: !40)
!78 = !DILocation(line: 93, column: 38, scope: !40)
!79 = !DILocation(line: 95, column: 29, scope: !40)
!80 = !DILocation(line: 95, column: 11, scope: !40)
!81 = !DILocation(line: 99, column: 66, scope: !40)
!82 = !DILocation(line: 104, column: 23, scope: !40)
!83 = !DILocation(line: 99, column: 58, scope: !40)
!84 = !DILocation(line: 0, scope: !40)
!85 = !DILocation(line: 113, column: 36, scope: !40)
!86 = !{i32 -1, i32 3, i32 -1}
!87 = !DILocation(line: 121, column: 33, scope: !40)
!88 = !DILocation(line: 121, column: 45, scope: !40)
!89 = !DILocation(line: 354, column: 10, scope: !90, inlinedAt: !91)
!90 = distinct !DISubprogram(name: "min", scope: !46, file: !46, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!91 = distinct !DILocation(line: 121, column: 28, scope: !40)
!92 = !DILocation(line: 288, column: 10, scope: !93, inlinedAt: !94)
!93 = distinct !DISubprogram(name: "expf", scope: !46, file: !46, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!94 = distinct !DILocation(line: 121, column: 23, scope: !40)
!95 = !DILocation(line: 75, column: 10, scope: !96, inlinedAt: !98)
!96 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !97, file: !97, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!97 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!98 = distinct !DILocation(line: 984, column: 9, scope: !99, inlinedAt: !101)
!99 = distinct !DISubprogram(name: "__float2half", scope: !100, file: !100, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!100 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!101 = distinct !DILocation(line: 133, column: 53, scope: !102, inlinedAt: !103)
!102 = distinct !DISubprogram(name: "__half", scope: !100, file: !100, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!103 = distinct !DILocation(line: 129, column: 34, scope: !40)
!104 = !DILocation(line: 129, column: 31, scope: !40)
!105 = !DILocation(line: 133, column: 36, scope: !40)
!106 = !{i32 4, i32 -1, i32 -1}
!107 = !DILocation(line: 139, column: 22, scope: !40)
!108 = !DILocation(line: 141, column: 7, scope: !40)
!109 = !DILocation(line: 142, column: 53, scope: !40)
!110 = !DILocation(line: 142, column: 39, scope: !40)
!111 = !DILocation(line: 144, column: 29, scope: !40)
!112 = !DILocation(line: 144, column: 11, scope: !40)
!113 = !DILocation(line: 148, column: 66, scope: !40)
!114 = !DILocation(line: 153, column: 23, scope: !40)
!115 = !DILocation(line: 148, column: 58, scope: !40)
!116 = !DILocation(line: 162, column: 36, scope: !40)
!117 = !DILocation(line: 170, column: 33, scope: !40)
!118 = !DILocation(line: 170, column: 45, scope: !40)
!119 = !DILocation(line: 354, column: 10, scope: !90, inlinedAt: !120)
!120 = distinct !DILocation(line: 170, column: 28, scope: !40)
!121 = !DILocation(line: 288, column: 10, scope: !93, inlinedAt: !122)
!122 = distinct !DILocation(line: 170, column: 23, scope: !40)
!123 = !DILocation(line: 174, column: 40, scope: !40)
!124 = !DILocation(line: 75, column: 10, scope: !96, inlinedAt: !125)
!125 = distinct !DILocation(line: 984, column: 9, scope: !99, inlinedAt: !126)
!126 = distinct !DILocation(line: 133, column: 53, scope: !102, inlinedAt: !127)
!127 = distinct !DILocation(line: 178, column: 36, scope: !40)
!128 = !DILocation(line: 178, column: 33, scope: !40)
!129 = !DILocation(line: 182, column: 40, scope: !40)
!130 = !DILocation(line: 188, column: 22, scope: !40)
!131 = !DILocation(line: 190, column: 7, scope: !40)
!132 = !DILocation(line: 191, column: 53, scope: !40)
!133 = !DILocation(line: 191, column: 39, scope: !40)
!134 = !DILocation(line: 193, column: 29, scope: !40)
!135 = !DILocation(line: 193, column: 11, scope: !40)
!136 = !DILocation(line: 197, column: 66, scope: !40)
!137 = !DILocation(line: 202, column: 23, scope: !40)
!138 = !DILocation(line: 197, column: 58, scope: !40)
!139 = !DILocation(line: 211, column: 36, scope: !40)
!140 = !DILocation(line: 219, column: 33, scope: !40)
!141 = !DILocation(line: 219, column: 45, scope: !40)
!142 = !DILocation(line: 354, column: 10, scope: !90, inlinedAt: !143)
!143 = distinct !DILocation(line: 219, column: 28, scope: !40)
!144 = !DILocation(line: 288, column: 10, scope: !93, inlinedAt: !145)
!145 = distinct !DILocation(line: 219, column: 23, scope: !40)
!146 = !DILocation(line: 223, column: 40, scope: !40)
!147 = !DILocation(line: 75, column: 10, scope: !96, inlinedAt: !148)
!148 = distinct !DILocation(line: 984, column: 9, scope: !99, inlinedAt: !149)
!149 = distinct !DILocation(line: 133, column: 53, scope: !102, inlinedAt: !150)
!150 = distinct !DILocation(line: 227, column: 36, scope: !40)
!151 = !DILocation(line: 227, column: 33, scope: !40)
!152 = !DILocation(line: 231, column: 40, scope: !40)
!153 = !DILocation(line: 237, column: 22, scope: !40)
!154 = !DILocation(line: 239, column: 7, scope: !40)
!155 = !DILocation(line: 240, column: 53, scope: !40)
!156 = !DILocation(line: 240, column: 39, scope: !40)
!157 = !DILocation(line: 242, column: 29, scope: !40)
!158 = !DILocation(line: 242, column: 11, scope: !40)
!159 = !DILocation(line: 246, column: 66, scope: !40)
!160 = !DILocation(line: 251, column: 23, scope: !40)
!161 = !DILocation(line: 246, column: 58, scope: !40)
!162 = !DILocation(line: 260, column: 36, scope: !40)
!163 = !DILocation(line: 268, column: 33, scope: !40)
!164 = !DILocation(line: 268, column: 45, scope: !40)
!165 = !DILocation(line: 354, column: 10, scope: !90, inlinedAt: !166)
!166 = distinct !DILocation(line: 268, column: 28, scope: !40)
!167 = !DILocation(line: 288, column: 10, scope: !93, inlinedAt: !168)
!168 = distinct !DILocation(line: 268, column: 23, scope: !40)
!169 = !DILocation(line: 272, column: 40, scope: !40)
!170 = !DILocation(line: 75, column: 10, scope: !96, inlinedAt: !171)
!171 = distinct !DILocation(line: 984, column: 9, scope: !99, inlinedAt: !172)
!172 = distinct !DILocation(line: 133, column: 53, scope: !102, inlinedAt: !173)
!173 = distinct !DILocation(line: 276, column: 36, scope: !40)
!174 = !DILocation(line: 276, column: 33, scope: !40)
!175 = !DILocation(line: 280, column: 40, scope: !40)
!176 = !DILocation(line: 61, column: 34, scope: !40)
!177 = !DILocation(line: 125, column: 40, scope: !40)
!178 = !DILocation(line: 289, column: 20, scope: !40)
!179 = !DILocation(line: 289, column: 34, scope: !40)
!180 = !DILocation(line: 289, column: 32, scope: !40)
!181 = !DILocation(line: 290, column: 34, scope: !40)
!182 = !DILocation(line: 290, column: 32, scope: !40)
!183 = !DILocation(line: 291, column: 34, scope: !40)
!184 = !DILocation(line: 291, column: 32, scope: !40)
!185 = !DILocation(line: 296, column: 36, scope: !40)
!186 = !DILocation(line: 1018, column: 9, scope: !187, inlinedAt: !189)
!187 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !188, file: !188, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!188 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!189 = distinct !DILocation(line: 396, column: 10, scope: !190, inlinedAt: !192)
!190 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !191, file: !191, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!191 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!192 = distinct !DILocation(line: 129, column: 24, scope: !193, inlinedAt: !195)
!193 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !194, file: !194, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!194 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!195 = distinct !DILocation(line: 101, column: 14, scope: !196, inlinedAt: !197)
!196 = distinct !DISubprogram(name: "run<float>", scope: !194, file: !194, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!197 = distinct !DILocation(line: 298, column: 19, scope: !40)
!198 = !DILocation(line: 171, column: 37, scope: !199, inlinedAt: !200)
!199 = distinct !DISubprogram(name: "__lane_id", scope: !188, file: !188, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!200 = distinct !DILocation(line: 990, column: 14, scope: !201, inlinedAt: !202)
!201 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !188, file: !188, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!202 = distinct !DILocation(line: 1019, column: 11, scope: !187, inlinedAt: !189)
!203 = !DILocation(line: 171, column: 10, scope: !199, inlinedAt: !200)
!204 = !DILocation(line: 991, column: 20, scope: !201, inlinedAt: !202)
!205 = !DILocation(line: 992, column: 36, scope: !201, inlinedAt: !202)
!206 = !DILocation(line: 992, column: 17, scope: !201, inlinedAt: !202)
!207 = !DILocation(line: 992, column: 11, scope: !201, inlinedAt: !202)
!208 = !DILocation(line: 993, column: 43, scope: !201, inlinedAt: !202)
!209 = !DILocation(line: 993, column: 10, scope: !201, inlinedAt: !202)
!210 = !DILocation(line: 1020, column: 14, scope: !187, inlinedAt: !189)
!211 = !DILocation(line: 25, column: 14, scope: !212, inlinedAt: !213)
!212 = distinct !DISubprogram(name: "operator()<float>", scope: !194, file: !194, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!213 = distinct !DILocation(line: 129, column: 11, scope: !193, inlinedAt: !195)
!214 = !DILocation(line: 1018, column: 9, scope: !187, inlinedAt: !215)
!215 = distinct !DILocation(line: 396, column: 10, scope: !190, inlinedAt: !216)
!216 = distinct !DILocation(line: 129, column: 24, scope: !217, inlinedAt: !218)
!217 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !194, file: !194, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!218 = distinct !DILocation(line: 101, column: 14, scope: !219, inlinedAt: !220)
!219 = distinct !DISubprogram(name: "run<float>", scope: !194, file: !194, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!220 = distinct !DILocation(line: 134, column: 14, scope: !193, inlinedAt: !195)
!221 = !DILocation(line: 171, column: 37, scope: !199, inlinedAt: !222)
!222 = distinct !DILocation(line: 990, column: 14, scope: !201, inlinedAt: !223)
!223 = distinct !DILocation(line: 1019, column: 11, scope: !187, inlinedAt: !215)
!224 = !DILocation(line: 171, column: 10, scope: !199, inlinedAt: !222)
!225 = !DILocation(line: 991, column: 20, scope: !201, inlinedAt: !223)
!226 = !DILocation(line: 992, column: 36, scope: !201, inlinedAt: !223)
!227 = !DILocation(line: 992, column: 17, scope: !201, inlinedAt: !223)
!228 = !DILocation(line: 992, column: 11, scope: !201, inlinedAt: !223)
!229 = !DILocation(line: 993, column: 43, scope: !201, inlinedAt: !223)
!230 = !DILocation(line: 993, column: 10, scope: !201, inlinedAt: !223)
!231 = !DILocation(line: 1020, column: 14, scope: !187, inlinedAt: !215)
!232 = !DILocation(line: 25, column: 14, scope: !212, inlinedAt: !233)
!233 = distinct !DILocation(line: 129, column: 11, scope: !217, inlinedAt: !218)
!234 = !DILocation(line: 300, column: 32, scope: !40)
!235 = !DILocation(line: 300, column: 7, scope: !40)
!236 = !DILocation(line: 308, column: 32, scope: !40)
!237 = !DILocation(line: 75, column: 10, scope: !96, inlinedAt: !238)
!238 = distinct !DILocation(line: 984, column: 9, scope: !99, inlinedAt: !239)
!239 = distinct !DILocation(line: 133, column: 53, scope: !102, inlinedAt: !240)
!240 = distinct !DILocation(line: 314, column: 50, scope: !40)
!241 = !DILocation(line: 314, column: 47, scope: !40)
!242 = !DILocation(line: 319, column: 122, scope: !40)
!243 = !DILocation(line: 319, column: 150, scope: !40)
!244 = !DILocation(line: 319, column: 77, scope: !40)
!245 = !DILocation(line: 319, column: 156, scope: !40)
!246 = !DILocation(line: 319, column: 40, scope: !40)
!247 = !DILocation(line: 319, column: 199, scope: !40)
!248 = !DILocation(line: 319, column: 93, scope: !40)
!249 = !DILocation(line: 68, column: 3, scope: !250, inlinedAt: !251)
!250 = distinct !DISubprogram(name: "__barrier_warp", scope: !188, file: !188, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!251 = distinct !DILocation(line: 192, column: 3, scope: !252, inlinedAt: !253)
!252 = distinct !DISubprogram(name: "__syncwarp", scope: !188, file: !188, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!253 = distinct !DILocation(line: 321, column: 3, scope: !40)
!254 = !DILocation(line: 69, column: 3, scope: !250, inlinedAt: !251)
!255 = !DILocation(line: 70, column: 3, scope: !250, inlinedAt: !251)
!256 = !DILocation(line: 323, column: 8, scope: !40)
!257 = !DILocation(line: 323, column: 3, scope: !40)
!258 = !DILocation(line: 324, column: 22, scope: !40)
!259 = !DILocation(line: 324, column: 132, scope: !40)
!260 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!261 = !{i32 2, i32 -1, i32 -1, i32 -1}
!262 = !DILocation(line: 324, column: 169, scope: !40)
!263 = !DILocation(line: 326, column: 1, scope: !40)
