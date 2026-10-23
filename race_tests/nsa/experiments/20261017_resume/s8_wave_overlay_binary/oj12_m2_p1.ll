; ModuleID = 'experiments/20261017_resume/s8_wave_overlay_binary/oj12_m2_p1.bc'
source_filename = "/tmp/tmpdvdavbew/tvm_kernels.maca"
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
  %cond.i.i630 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64), !dbg !49
  %mul11 = shl nsw i32 %cond.i.i630, 4, !dbg !52
  %4 = or disjoint i64 %2, 1, !dbg !53
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4, !dbg !43
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !dbg !43, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i630.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64), !dbg !49
  %mul11.1 = shl nsw i32 %cond.i.i630.1, 4, !dbg !52
  %6 = or disjoint i64 %2, 2, !dbg !53
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6, !dbg !43
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !dbg !43, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i630.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64), !dbg !49
  %mul11.2 = shl nsw i32 %cond.i.i630.2, 4, !dbg !52
  %8 = or disjoint i64 %2, 3, !dbg !53
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8, !dbg !43
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !dbg !43, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i630.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64), !dbg !49
  %mul11.3 = shl nsw i32 %cond.i.i630.3, 4, !dbg !52
  %10 = or disjoint i64 %2, 4, !dbg !53
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10, !dbg !43
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !dbg !43, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i630.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64), !dbg !49
  %mul11.4 = shl nsw i32 %cond.i.i630.4, 4, !dbg !52
  %12 = or disjoint i64 %2, 5, !dbg !53
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12, !dbg !43
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !dbg !43, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i630.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64), !dbg !49
  %mul11.5 = shl nsw i32 %cond.i.i630.5, 4, !dbg !52
  %14 = or disjoint i64 %2, 6, !dbg !53
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14, !dbg !43
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !dbg !43, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i630.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64), !dbg !49
  %mul11.6 = shl nsw i32 %cond.i.i630.6, 4, !dbg !52
  %16 = or disjoint i64 %2, 7, !dbg !53
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16, !dbg !43
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !dbg !43, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i630.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64), !dbg !49
  %mul11.7 = shl nsw i32 %cond.i.i630.7, 4, !dbg !52
  %18 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !dbg !54, !range !58
  %cmp15 = icmp ult i32 %18, 64, !dbg !59
  br i1 %cmp15, label %for.cond16.preheader, label %if.end, !dbg !60

for.cond16.preheader:                             ; preds = %entry
  %mul22 = shl nsw i32 %0, 20
  %mul24 = shl nsw i32 %1, 10
  %add25 = add nuw nsw i32 %mul22, %mul24
  %and = shl nuw nsw i32 %18, 6
  %mul27 = and i32 %and, 960
  %add28 = or disjoint i32 %add25, %mul27
  %19 = lshr i32 %18, 1
  %mul34 = and i32 %19, 24
  %20 = zext nneg i32 %add28 to i64, !dbg !61
  %21 = zext nneg i32 %mul34 to i64, !dbg !61
  %22 = or disjoint i64 %20, %21, !dbg !62
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %22, !dbg !63
  %qr.sroa.0.0.copyload = load i16, ptr addrspace(4) %add.ptr, align 16, !dbg !64
  %qr.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 2, !dbg !64
  %qr.sroa.4.0.copyload = load i16, ptr addrspace(4) %qr.sroa.4.0.add.ptr.sroa_idx, align 2, !dbg !64, !tbaa !30
  %qr.sroa.5.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 4, !dbg !64
  %qr.sroa.5.0.copyload = load i16, ptr addrspace(4) %qr.sroa.5.0.add.ptr.sroa_idx, align 4, !dbg !64
  %qr.sroa.6.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 6, !dbg !64
  %qr.sroa.6.0.copyload = load i16, ptr addrspace(4) %qr.sroa.6.0.add.ptr.sroa_idx, align 2, !dbg !64, !tbaa !30
  %qr.sroa.7.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !64
  %qr.sroa.7.0.copyload = load i16, ptr addrspace(4) %qr.sroa.7.0.add.ptr.sroa_idx, align 8, !dbg !64
  %qr.sroa.8.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 10, !dbg !64
  %qr.sroa.8.0.copyload = load i16, ptr addrspace(4) %qr.sroa.8.0.add.ptr.sroa_idx, align 2, !dbg !64, !tbaa !30
  %qr.sroa.9.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 12, !dbg !64
  %qr.sroa.9.0.copyload = load i16, ptr addrspace(4) %qr.sroa.9.0.add.ptr.sroa_idx, align 4, !dbg !64
  %qr.sroa.10.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 14, !dbg !64
  %qr.sroa.10.0.copyload = load i16, ptr addrspace(4) %qr.sroa.10.0.add.ptr.sroa_idx, align 2, !dbg !64, !tbaa !30
  %23 = or disjoint i64 %20, %21, !dbg !62
  %24 = or disjoint i64 %23, 32, !dbg !62
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %24, !dbg !63
  %qr.sroa.11.16.copyload = load i16, ptr addrspace(4) %add.ptr.1, align 16, !dbg !64
  %qr.sroa.13.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr.1, i64 2, !dbg !64
  %qr.sroa.13.16.copyload = load i16, ptr addrspace(4) %qr.sroa.13.16.add.ptr.1.sroa_idx, align 2, !dbg !64, !tbaa !30
  %qr.sroa.14.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr.1, i64 4, !dbg !64
  %qr.sroa.14.16.copyload = load i16, ptr addrspace(4) %qr.sroa.14.16.add.ptr.1.sroa_idx, align 4, !dbg !64
  %qr.sroa.15.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr.1, i64 6, !dbg !64
  %qr.sroa.15.16.copyload = load i16, ptr addrspace(4) %qr.sroa.15.16.add.ptr.1.sroa_idx, align 2, !dbg !64, !tbaa !30
  %qr.sroa.16.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr.1, i64 8, !dbg !64
  %qr.sroa.16.16.copyload = load i16, ptr addrspace(4) %qr.sroa.16.16.add.ptr.1.sroa_idx, align 8, !dbg !64
  %qr.sroa.17.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr.1, i64 10, !dbg !64
  %qr.sroa.17.16.copyload = load i16, ptr addrspace(4) %qr.sroa.17.16.add.ptr.1.sroa_idx, align 2, !dbg !64, !tbaa !30
  %qr.sroa.18.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr.1, i64 12, !dbg !64
  %qr.sroa.18.16.copyload = load i16, ptr addrspace(4) %qr.sroa.18.16.add.ptr.1.sroa_idx, align 4, !dbg !64
  %qr.sroa.19.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr.1, i64 14, !dbg !64
  %qr.sroa.19.16.copyload = load i16, ptr addrspace(4) %qr.sroa.19.16.add.ptr.1.sroa_idx, align 2, !dbg !64, !tbaa !30
  %conv = zext i16 %qr.sroa.0.0.copyload to i32, !dbg !65
  %conv54 = zext i16 %qr.sroa.4.0.copyload to i32, !dbg !66
  %shl = shl nuw i32 %conv54, 16, !dbg !67
  %or = or disjoint i32 %shl, %conv, !dbg !68
  %25 = insertelement <4 x i32> poison, i32 %or, i64 0, !dbg !69
  %conv.1 = zext i16 %qr.sroa.5.0.copyload to i32, !dbg !65
  %conv54.1 = zext i16 %qr.sroa.6.0.copyload to i32, !dbg !66
  %shl.1 = shl nuw i32 %conv54.1, 16, !dbg !67
  %or.1 = or disjoint i32 %shl.1, %conv.1, !dbg !68
  %26 = insertelement <4 x i32> %25, i32 %or.1, i64 1, !dbg !69
  %conv.2 = zext i16 %qr.sroa.7.0.copyload to i32, !dbg !65
  %conv54.2 = zext i16 %qr.sroa.8.0.copyload to i32, !dbg !66
  %shl.2 = shl nuw i32 %conv54.2, 16, !dbg !67
  %or.2 = or disjoint i32 %shl.2, %conv.2, !dbg !68
  %27 = insertelement <4 x i32> %26, i32 %or.2, i64 2, !dbg !69
  %conv.3 = zext i16 %qr.sroa.9.0.copyload to i32, !dbg !65
  %conv54.3 = zext i16 %qr.sroa.10.0.copyload to i32, !dbg !66
  %shl.3 = shl nuw i32 %conv54.3, 16, !dbg !67
  %or.3 = or disjoint i32 %shl.3, %conv.3, !dbg !68
  %28 = insertelement <4 x i32> %27, i32 %or.3, i64 3, !dbg !69
  %resident.sroa.0.12.vec.insert1867 = bitcast <4 x i32> %28 to <4 x float>, !dbg !69
  %conv.4 = zext i16 %qr.sroa.11.16.copyload to i32, !dbg !65
  %conv54.4 = zext i16 %qr.sroa.13.16.copyload to i32, !dbg !66
  %shl.4 = shl nuw i32 %conv54.4, 16, !dbg !67
  %or.4 = or disjoint i32 %shl.4, %conv.4, !dbg !68
  %29 = insertelement <4 x i32> poison, i32 %or.4, i64 0, !dbg !69
  %conv.5 = zext i16 %qr.sroa.14.16.copyload to i32, !dbg !65
  %conv54.5 = zext i16 %qr.sroa.15.16.copyload to i32, !dbg !66
  %shl.5 = shl nuw i32 %conv54.5, 16, !dbg !67
  %or.5 = or disjoint i32 %shl.5, %conv.5, !dbg !68
  %30 = insertelement <4 x i32> %29, i32 %or.5, i64 1, !dbg !69
  %conv.6 = zext i16 %qr.sroa.16.16.copyload to i32, !dbg !65
  %conv54.6 = zext i16 %qr.sroa.17.16.copyload to i32, !dbg !66
  %shl.6 = shl nuw i32 %conv54.6, 16, !dbg !67
  %or.6 = or disjoint i32 %shl.6, %conv.6, !dbg !68
  %31 = insertelement <4 x i32> %30, i32 %or.6, i64 2, !dbg !69
  %conv.7 = zext i16 %qr.sroa.18.16.copyload to i32, !dbg !65
  %conv54.7 = zext i16 %qr.sroa.19.16.copyload to i32, !dbg !66
  %shl.7 = shl nuw i32 %conv54.7, 16, !dbg !67
  %or.7 = or disjoint i32 %shl.7, %conv.7, !dbg !68
  %32 = insertelement <4 x i32> %31, i32 %or.7, i64 3, !dbg !69
  %resident.sroa.66.28.vec.insert1947 = bitcast <4 x i32> %32 to <4 x float>, !dbg !69
  br label %if.end

if.end:                                           ; preds = %entry, %for.cond16.preheader
  %resident.sroa.66.0 = phi <4 x float> [ %resident.sroa.66.28.vec.insert1947, %for.cond16.preheader ], [ zeroinitializer, %entry ], !dbg !70
  %resident.sroa.0.0 = phi <4 x float> [ %resident.sroa.0.12.vec.insert1867, %for.cond16.preheader ], [ zeroinitializer, %entry ], !dbg !70
  %cmp91 = icmp ugt i32 %18, 63
  %shr269.mask = and i32 %18, 960
  %cmp270.not = icmp eq i32 %shr269.mask, 64
  %mul114 = shl nsw i32 %0, 16
  %and121 = shl nuw nsw i32 %18, 3
  %and259 = shl nuw nsw i32 %18, 2
  %invariant.op = add nsw i32 %1, -15
  %33 = lshr i32 %18, 2
  %mul165 = and i32 %33, 12
  %mul302 = and i32 %and121, 504
  %mul318 = and i32 %and259, 252
  %34 = zext nneg i32 %and121 to i64, !dbg !71
  %35 = zext nneg i32 %mul302 to i64, !dbg !71
  br i1 %cmp91, label %if.end371, label %for.cond94.preheader, !dbg !72

for.body383.preheader:                            ; preds = %if.end371.2
  %resident.sroa.130.32.vec.extract = extractelement <4 x float> %resident.sroa.130.30, i64 0, !dbg !73
  %add388 = fadd contract float %resident.sroa.130.32.vec.extract, 0.000000e+00, !dbg !74
  %resident.sroa.130.36.vec.extract2065 = extractelement <4 x float> %resident.sroa.130.30, i64 1, !dbg !73
  %add388.1 = fadd contract float %add388, %resident.sroa.130.36.vec.extract2065, !dbg !74
  %resident.sroa.130.40.vec.extract2120 = extractelement <4 x float> %resident.sroa.130.30, i64 2, !dbg !73
  %add388.2 = fadd contract float %add388.1, %resident.sroa.130.40.vec.extract2120, !dbg !74
  %resident.sroa.130.44.vec.extract2175 = extractelement <4 x float> %resident.sroa.130.30, i64 3, !dbg !73
  %add388.3 = fadd contract float %add388.2, %resident.sroa.130.44.vec.extract2175, !dbg !74
  %36 = bitcast float %add388.3 to i32, !dbg !75
  %37 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !79
  %38 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %37) #11, !dbg !84
  %xor.i.i = xor i32 %38, 32, !dbg !85
  %39 = and i32 %38, -64, !dbg !86
  %and.i.i = add nsw i32 %39, 64, !dbg !86
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !87
  %cond.i.i631 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %38, !dbg !88
  %shl.i.i = shl i32 %cond.i.i631, 2, !dbg !89
  %40 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %36), !dbg !90
  %41 = bitcast i32 %40 to float, !dbg !91
  %add396 = fadd contract float %add388.3, %41, !dbg !92
  %42 = bitcast float %add396 to i32, !dbg !93
  %43 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !95
  %44 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %43) #11, !dbg !98
  %xor.i.i632 = xor i32 %44, 16, !dbg !99
  %45 = and i32 %44, -64, !dbg !100
  %and.i.i633 = add nsw i32 %45, 64, !dbg !100
  %cmp.not.i.i634 = icmp slt i32 %xor.i.i632, %and.i.i633, !dbg !101
  %cond.i.i635 = select i1 %cmp.not.i.i634, i32 %xor.i.i632, i32 %44, !dbg !102
  %shl.i.i636 = shl i32 %cond.i.i635, 2, !dbg !103
  %46 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i636, i32 %42), !dbg !104
  %47 = bitcast i32 %46 to float, !dbg !105
  %add401 = fadd contract float %add396, %47, !dbg !106
  %cmp404 = fcmp contract ogt float %add401, 0.000000e+00, !dbg !107
  %div = fdiv contract float 1.000000e+00, %add401, !dbg !108
  %condval_1.0 = select i1 %cmp404, float %div, float 0.000000e+00, !dbg !108
  %arrayidx414 = getelementptr inbounds float, ptr addrspace(3) @buf_dyn_shmem, i32 %18, !dbg !109
  store float %condval_1.0, ptr addrspace(3) %arrayidx414, align 4, !dbg !110, !tbaa !111
  br label %if.end415, !dbg !113

for.cond94.preheader:                             ; preds = %if.end
  %or.cond663 = icmp ugt i32 %mul11, 1023, !dbg !114
  %cmp107.not = icmp sgt i32 %mul11, %1
  %or.cond664 = or i1 %or.cond663, %cmp107.not, !dbg !114
  br i1 %or.cond664, label %if.end135, label %for.cond109.preheader, !dbg !114

for.cond109.preheader:                            ; preds = %for.cond94.preheader
  %48 = shl nsw i32 %cond.i.i630, 10
  %mul116 = and i32 %48, 64512
  %add117 = or disjoint i32 %mul116, %mul114
  %49 = zext nneg i32 %add117 to i64, !dbg !115
  %50 = or disjoint i64 %49, %34, !dbg !116
  %add.ptr125 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %50, !dbg !117
  %kr.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr125, align 16, !dbg !118
  %kr.sroa.44.0.add.ptr125.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125, i64 8, !dbg !118
  %kr.sroa.44.0.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.44.0.add.ptr125.sroa_idx, align 8, !dbg !118
  %51 = or disjoint i64 %49, %34, !dbg !116
  %52 = or disjoint i64 %51, 512, !dbg !116
  %add.ptr125.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %52, !dbg !117
  %kr.sroa.71.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr125.1, align 16, !dbg !118
  %kr.sroa.113.16.add.ptr125.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1, i64 8, !dbg !118
  %kr.sroa.113.16.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.113.16.add.ptr125.1.sroa_idx, align 8, !dbg !118
  br label %if.end135, !dbg !119

if.end135:                                        ; preds = %for.cond109.preheader, %for.cond94.preheader
  %kr.sroa.113.0 = phi <4 x half> [ undef, %for.cond94.preheader ], [ %kr.sroa.113.16.copyload, %for.cond109.preheader ]
  %kr.sroa.71.0 = phi <4 x half> [ undef, %for.cond94.preheader ], [ %kr.sroa.71.16.copyload, %for.cond109.preheader ]
  %kr.sroa.44.0 = phi <4 x half> [ undef, %for.cond94.preheader ], [ %kr.sroa.44.0.copyload, %for.cond109.preheader ]
  %kr.sroa.0.0 = phi <4 x half> [ undef, %for.cond94.preheader ], [ %kr.sroa.0.0.copyload, %for.cond109.preheader ]
  %or.cond663.1 = icmp ugt i32 %mul11.1, 1023, !dbg !114
  %cmp107.not.1 = icmp sgt i32 %mul11.1, %1
  %or.cond664.1 = or i1 %or.cond663.1, %cmp107.not.1, !dbg !114
  br i1 %or.cond664.1, label %if.end135.1, label %for.cond109.preheader.1, !dbg !114

for.cond109.preheader.1:                          ; preds = %if.end135
  %53 = shl nsw i32 %cond.i.i630.1, 10
  %mul116.1 = and i32 %53, 64512
  %add117.1 = or disjoint i32 %mul116.1, %mul114
  %54 = zext nneg i32 %add117.1 to i64, !dbg !115
  %55 = or disjoint i64 %54, %34, !dbg !116
  %add.ptr125.1683 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %55, !dbg !117
  %kr.sroa.140.32.copyload = load <4 x half>, ptr addrspace(4) %add.ptr125.1683, align 16, !dbg !118
  %kr.sroa.146.32.add.ptr125.1683.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1683, i64 8, !dbg !118
  %kr.sroa.146.32.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.146.32.add.ptr125.1683.sroa_idx, align 8, !dbg !118
  %56 = or disjoint i64 %54, %34, !dbg !116
  %57 = or disjoint i64 %56, 512, !dbg !116
  %add.ptr125.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %57, !dbg !117
  %kr.sroa.149.48.copyload = load <4 x half>, ptr addrspace(4) %add.ptr125.1.1, align 16, !dbg !118
  %kr.sroa.155.48.add.ptr125.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1.1, i64 8, !dbg !118
  %kr.sroa.155.48.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.155.48.add.ptr125.1.1.sroa_idx, align 8, !dbg !118
  br label %if.end135.1, !dbg !119

if.end135.1:                                      ; preds = %for.cond109.preheader.1, %if.end135
  %kr.sroa.155.0 = phi <4 x half> [ undef, %if.end135 ], [ %kr.sroa.155.48.copyload, %for.cond109.preheader.1 ]
  %kr.sroa.149.0 = phi <4 x half> [ undef, %if.end135 ], [ %kr.sroa.149.48.copyload, %for.cond109.preheader.1 ]
  %kr.sroa.146.0 = phi <4 x half> [ undef, %if.end135 ], [ %kr.sroa.146.32.copyload, %for.cond109.preheader.1 ]
  %kr.sroa.140.0 = phi <4 x half> [ undef, %if.end135 ], [ %kr.sroa.140.32.copyload, %for.cond109.preheader.1 ]
  %or.cond663.2 = icmp ugt i32 %mul11.2, 1023, !dbg !114
  %cmp107.not.2 = icmp sgt i32 %mul11.2, %1
  %or.cond664.2 = or i1 %or.cond663.2, %cmp107.not.2, !dbg !114
  br i1 %or.cond664.2, label %if.end135.2, label %for.cond109.preheader.2, !dbg !114

for.cond109.preheader.2:                          ; preds = %if.end135.1
  %58 = shl nsw i32 %cond.i.i630.2, 10
  %mul116.2 = and i32 %58, 64512
  %add117.2 = or disjoint i32 %mul116.2, %mul114
  %59 = zext nneg i32 %add117.2 to i64, !dbg !115
  %60 = or disjoint i64 %59, %34, !dbg !116
  %add.ptr125.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %60, !dbg !117
  %kr.sroa.158.64.copyload = load <4 x half>, ptr addrspace(4) %add.ptr125.2, align 16, !dbg !118
  %kr.sroa.164.64.add.ptr125.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.2, i64 8, !dbg !118
  %kr.sroa.164.64.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.164.64.add.ptr125.2.sroa_idx, align 8, !dbg !118
  %61 = or disjoint i64 %59, %34, !dbg !116
  %62 = or disjoint i64 %61, 512, !dbg !116
  %add.ptr125.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %62, !dbg !117
  %kr.sroa.167.80.copyload = load <4 x half>, ptr addrspace(4) %add.ptr125.1.2, align 16, !dbg !118
  %kr.sroa.173.80.add.ptr125.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1.2, i64 8, !dbg !118
  %kr.sroa.173.80.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.173.80.add.ptr125.1.2.sroa_idx, align 8, !dbg !118
  br label %if.end135.2, !dbg !119

if.end135.2:                                      ; preds = %for.cond109.preheader.2, %if.end135.1
  %kr.sroa.173.0 = phi <4 x half> [ undef, %if.end135.1 ], [ %kr.sroa.173.80.copyload, %for.cond109.preheader.2 ]
  %kr.sroa.167.0 = phi <4 x half> [ undef, %if.end135.1 ], [ %kr.sroa.167.80.copyload, %for.cond109.preheader.2 ]
  %kr.sroa.164.0 = phi <4 x half> [ undef, %if.end135.1 ], [ %kr.sroa.164.64.copyload, %for.cond109.preheader.2 ]
  %kr.sroa.158.0 = phi <4 x half> [ undef, %if.end135.1 ], [ %kr.sroa.158.64.copyload, %for.cond109.preheader.2 ]
  %or.cond663.3 = icmp ugt i32 %mul11.3, 1023, !dbg !114
  %cmp107.not.3 = icmp sgt i32 %mul11.3, %1
  %or.cond664.3 = or i1 %or.cond663.3, %cmp107.not.3, !dbg !114
  br i1 %or.cond664.3, label %if.end135.3, label %for.cond109.preheader.3, !dbg !114

for.cond109.preheader.3:                          ; preds = %if.end135.2
  %63 = shl nsw i32 %cond.i.i630.3, 10
  %mul116.3 = and i32 %63, 64512
  %add117.3 = or disjoint i32 %mul116.3, %mul114
  %64 = zext nneg i32 %add117.3 to i64, !dbg !115
  %65 = or disjoint i64 %64, %34, !dbg !116
  %add.ptr125.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %65, !dbg !117
  %kr.sroa.176.96.copyload = load <4 x half>, ptr addrspace(4) %add.ptr125.3, align 16, !dbg !118
  %kr.sroa.182.96.add.ptr125.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.3, i64 8, !dbg !118
  %kr.sroa.182.96.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.182.96.add.ptr125.3.sroa_idx, align 8, !dbg !118
  %66 = or disjoint i64 %64, %34, !dbg !116
  %67 = or disjoint i64 %66, 512, !dbg !116
  %add.ptr125.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %67, !dbg !117
  %kr.sroa.185.112.copyload = load <4 x half>, ptr addrspace(4) %add.ptr125.1.3, align 16, !dbg !118
  %kr.sroa.191.112.add.ptr125.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1.3, i64 8, !dbg !118
  %kr.sroa.191.112.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.191.112.add.ptr125.1.3.sroa_idx, align 8, !dbg !118
  br label %if.end135.3, !dbg !119

if.end135.3:                                      ; preds = %for.cond109.preheader.3, %if.end135.2
  %kr.sroa.191.0 = phi <4 x half> [ undef, %if.end135.2 ], [ %kr.sroa.191.112.copyload, %for.cond109.preheader.3 ]
  %kr.sroa.185.0 = phi <4 x half> [ undef, %if.end135.2 ], [ %kr.sroa.185.112.copyload, %for.cond109.preheader.3 ]
  %kr.sroa.182.0 = phi <4 x half> [ undef, %if.end135.2 ], [ %kr.sroa.182.96.copyload, %for.cond109.preheader.3 ]
  %kr.sroa.176.0 = phi <4 x half> [ undef, %if.end135.2 ], [ %kr.sroa.176.96.copyload, %for.cond109.preheader.3 ]
  br i1 %or.cond664, label %if.end252, label %if.then153, !dbg !120

if.then153:                                       ; preds = %if.end135.3
  %cmp156 = icmp sgt i32 %mul11, %invariant.op, !dbg !121
  br i1 %cmp156, label %for.cond158.preheader, label %if.end184, !dbg !122

for.cond158.preheader:                            ; preds = %if.then153
  %add166 = or disjoint i32 %mul11, %mul165
  %cmp169.not = icmp sgt i32 %add166, %1, !dbg !123
  %spec.select = select i1 %cmp169.not, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.0.vec.insert931 = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !125
  %cmp169.not.1.not = icmp slt i32 %add166, %1, !dbg !123
  %spec.select.1 = select i1 %cmp169.not.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !124
  %scores.sroa.0.4.vec.insert1070 = insertelement <4 x float> %scores.sroa.0.0.vec.insert931, float %spec.select.1, i64 1, !dbg !125
  %add167.2 = or disjoint i32 %add166, 2, !dbg !126
  %cmp169.not.2 = icmp sgt i32 %add167.2, %1, !dbg !123
  %spec.select.2 = select i1 %cmp169.not.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.8.vec.insert1187 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1070, float %spec.select.2, i64 2, !dbg !125
  %add167.3 = or disjoint i32 %add166, 3, !dbg !126
  %cmp169.not.3 = icmp sgt i32 %add167.3, %1, !dbg !123
  %spec.select.3 = select i1 %cmp169.not.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.12.vec.insert1304 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1187, float %spec.select.3, i64 3, !dbg !125
  br label %if.end184

if.end184:                                        ; preds = %if.then153, %for.cond158.preheader
  %scores.sroa.0.0 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1304, %for.cond158.preheader ], [ zeroinitializer, %if.then153 ], !dbg !70
  %resident.sroa.0.0.vec.extract = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %68 = bitcast <2 x float> %resident.sroa.0.0.vec.extract to <4 x half>, !dbg !127
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0, <4 x half> %68, <4 x float> %scores.sroa.0.0), !dbg !128
  %resident.sroa.0.8.vec.extract = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %70 = bitcast <2 x float> %resident.sroa.0.8.vec.extract to <4 x half>, !dbg !127
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.44.0, <4 x half> %70, <4 x float> %69), !dbg !128
  %resident.sroa.66.16.vec.extract = shufflevector <4 x float> %resident.sroa.66.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %72 = bitcast <2 x float> %resident.sroa.66.16.vec.extract to <4 x half>, !dbg !127
  %73 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.71.0, <4 x half> %72, <4 x float> %71), !dbg !128
  %resident.sroa.66.24.vec.extract = shufflevector <4 x float> %resident.sroa.66.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %74 = bitcast <2 x float> %resident.sroa.66.24.vec.extract to <4 x half>, !dbg !127
  %75 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.113.0, <4 x half> %74, <4 x float> %73), !dbg !128
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %75, i64 0, !dbg !129
  %mul210 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !130
  %76 = tail call contract noundef float @llvm.minnum.f32(float %mul210, float 0x4024CB5EC0000000), !dbg !131
  %77 = tail call contract noundef float @llvm.exp.f32(float %76), !dbg !134
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %75, i64 1, !dbg !129
  %mul210.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !130
  %78 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1, float 0x4024CB5EC0000000), !dbg !131
  %79 = tail call contract noundef float @llvm.exp.f32(float %78), !dbg !134
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %75, i64 2, !dbg !129
  %mul210.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !130
  %80 = tail call contract noundef float @llvm.minnum.f32(float %mul210.2, float 0x4024CB5EC0000000), !dbg !131
  %81 = tail call contract noundef float @llvm.exp.f32(float %80), !dbg !134
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %75, i64 3, !dbg !129
  %mul210.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !130
  %82 = tail call contract noundef float @llvm.minnum.f32(float %mul210.3, float 0x4024CB5EC0000000), !dbg !131
  %83 = tail call contract noundef float @llvm.exp.f32(float %82), !dbg !134
  %resident.sroa.130.32.vec.insert = insertelement <4 x float> poison, float %77, i64 0, !dbg !137
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %77), !dbg !138
  %probs.sroa.0.0.vec.insert = insertelement <4 x i16> poison, i16 %84, i64 0, !dbg !147
  %resident.sroa.130.36.vec.insert2019 = insertelement <4 x float> %resident.sroa.130.32.vec.insert, float %79, i64 1, !dbg !137
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %79), !dbg !138
  %probs.sroa.0.2.vec.insert = insertelement <4 x i16> %probs.sroa.0.0.vec.insert, i16 %85, i64 1, !dbg !147
  %resident.sroa.130.40.vec.insert2074 = insertelement <4 x float> %resident.sroa.130.36.vec.insert2019, float %81, i64 2, !dbg !137
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %81), !dbg !138
  %probs.sroa.0.4.vec.insert = insertelement <4 x i16> %probs.sroa.0.2.vec.insert, i16 %86, i64 2, !dbg !147
  %resident.sroa.130.44.vec.insert2129 = insertelement <4 x float> %resident.sroa.130.40.vec.insert2074, float %83, i64 3, !dbg !137
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %83), !dbg !138
  %probs.sroa.0.6.vec.insert = insertelement <4 x i16> %probs.sroa.0.4.vec.insert, i16 %87, i64 3, !dbg !147
  br label %if.end252, !dbg !148

if.end252:                                        ; preds = %if.end135.3, %if.end184
  %resident.sroa.130.1 = phi <4 x float> [ %resident.sroa.130.44.vec.insert2129, %if.end184 ], [ zeroinitializer, %if.end135.3 ], !dbg !70
  %probs.sroa.0.0 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert, %if.end184 ], [ zeroinitializer, %if.end135.3 ], !dbg !70
  %add.ptr263 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and259, !dbg !149
  store <4 x i16> %probs.sroa.0.0, ptr addrspace(3) %add.ptr263, align 8, !dbg !150
  br i1 %or.cond664.1, label %if.end252.1, label %if.then153.1, !dbg !120

if.then153.1:                                     ; preds = %if.end252
  %cmp156.1 = icmp sgt i32 %mul11.1, %invariant.op, !dbg !121
  br i1 %cmp156.1, label %for.cond158.preheader.1, label %if.end184.1, !dbg !122

for.cond158.preheader.1:                          ; preds = %if.then153.1
  %add166.1 = or disjoint i32 %mul11.1, %mul165
  %cmp169.not.1686 = icmp sgt i32 %add166.1, %1, !dbg !123
  %spec.select.1687 = select i1 %cmp169.not.1686, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.0.vec.insert940 = insertelement <4 x float> poison, float %spec.select.1687, i64 0, !dbg !125
  %cmp169.not.1.1.not = icmp slt i32 %add166.1, %1, !dbg !123
  %spec.select.1.1 = select i1 %cmp169.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !124
  %scores.sroa.0.4.vec.insert1077 = insertelement <4 x float> %scores.sroa.0.0.vec.insert940, float %spec.select.1.1, i64 1, !dbg !125
  %add167.2.1 = or disjoint i32 %add166.1, 2, !dbg !126
  %cmp169.not.2.1 = icmp sgt i32 %add167.2.1, %1, !dbg !123
  %spec.select.2.1 = select i1 %cmp169.not.2.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.8.vec.insert1194 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1077, float %spec.select.2.1, i64 2, !dbg !125
  %add167.3.1 = or disjoint i32 %add166.1, 3, !dbg !126
  %cmp169.not.3.1 = icmp sgt i32 %add167.3.1, %1, !dbg !123
  %spec.select.3.1 = select i1 %cmp169.not.3.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.12.vec.insert1311 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1194, float %spec.select.3.1, i64 3, !dbg !125
  br label %if.end184.1

if.end184.1:                                      ; preds = %if.then153.1, %for.cond158.preheader.1
  %scores.sroa.0.2 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1311, %for.cond158.preheader.1 ], [ zeroinitializer, %if.then153.1 ], !dbg !70
  %resident.sroa.0.0.vec.extract1801 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %88 = bitcast <2 x float> %resident.sroa.0.0.vec.extract1801 to <4 x half>, !dbg !127
  %89 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.140.0, <4 x half> %88, <4 x float> %scores.sroa.0.2), !dbg !128
  %resident.sroa.0.8.vec.extract1835 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %90 = bitcast <2 x float> %resident.sroa.0.8.vec.extract1835 to <4 x half>, !dbg !127
  %91 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.146.0, <4 x half> %90, <4 x float> %89), !dbg !128
  %resident.sroa.66.16.vec.extract1881 = shufflevector <4 x float> %resident.sroa.66.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %92 = bitcast <2 x float> %resident.sroa.66.16.vec.extract1881 to <4 x half>, !dbg !127
  %93 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.149.0, <4 x half> %92, <4 x float> %91), !dbg !128
  %resident.sroa.66.24.vec.extract1915 = shufflevector <4 x float> %resident.sroa.66.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %94 = bitcast <2 x float> %resident.sroa.66.24.vec.extract1915 to <4 x half>, !dbg !127
  %95 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.155.0, <4 x half> %94, <4 x float> %93), !dbg !128
  %scores.sroa.0.0.vec.extract942 = extractelement <4 x float> %95, i64 0, !dbg !129
  %mul210.1690 = fmul contract float %scores.sroa.0.0.vec.extract942, 0x3FB99999A0000000, !dbg !130
  %96 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1690, float 0x4024CB5EC0000000), !dbg !131
  %97 = tail call contract noundef float @llvm.exp.f32(float %96), !dbg !134
  %scores.sroa.0.4.vec.extract1079 = extractelement <4 x float> %95, i64 1, !dbg !129
  %mul210.1.1 = fmul contract float %scores.sroa.0.4.vec.extract1079, 0x3FB99999A0000000, !dbg !130
  %98 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1.1, float 0x4024CB5EC0000000), !dbg !131
  %99 = tail call contract noundef float @llvm.exp.f32(float %98), !dbg !134
  %scores.sroa.0.8.vec.extract1196 = extractelement <4 x float> %95, i64 2, !dbg !129
  %mul210.2.1 = fmul contract float %scores.sroa.0.8.vec.extract1196, 0x3FB99999A0000000, !dbg !130
  %100 = tail call contract noundef float @llvm.minnum.f32(float %mul210.2.1, float 0x4024CB5EC0000000), !dbg !131
  %101 = tail call contract noundef float @llvm.exp.f32(float %100), !dbg !134
  %scores.sroa.0.12.vec.extract1313 = extractelement <4 x float> %95, i64 3, !dbg !129
  %mul210.3.1 = fmul contract float %scores.sroa.0.12.vec.extract1313, 0x3FB99999A0000000, !dbg !130
  %102 = tail call contract noundef float @llvm.minnum.f32(float %mul210.3.1, float 0x4024CB5EC0000000), !dbg !131
  %103 = tail call contract noundef float @llvm.exp.f32(float %102), !dbg !134
  %resident.sroa.130.32.vec.extract1968 = extractelement <4 x float> %resident.sroa.130.1, i64 0, !dbg !151
  %add227.1692 = fadd contract float %resident.sroa.130.32.vec.extract1968, %97, !dbg !152
  %resident.sroa.130.32.vec.insert1970 = insertelement <4 x float> poison, float %add227.1692, i64 0, !dbg !137
  %104 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %97), !dbg !138
  %probs.sroa.0.0.vec.insert1446 = insertelement <4 x i16> poison, i16 %104, i64 0, !dbg !147
  %resident.sroa.130.36.vec.extract2021 = extractelement <4 x float> %resident.sroa.130.1, i64 1, !dbg !151
  %add227.1.1 = fadd contract float %resident.sroa.130.36.vec.extract2021, %99, !dbg !152
  %resident.sroa.130.36.vec.insert2023 = insertelement <4 x float> %resident.sroa.130.32.vec.insert1970, float %add227.1.1, i64 1, !dbg !137
  %105 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %99), !dbg !138
  %probs.sroa.0.2.vec.insert1492 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1446, i16 %105, i64 1, !dbg !147
  %resident.sroa.130.40.vec.extract2076 = extractelement <4 x float> %resident.sroa.130.1, i64 2, !dbg !151
  %add227.2.1 = fadd contract float %resident.sroa.130.40.vec.extract2076, %101, !dbg !152
  %resident.sroa.130.40.vec.insert2078 = insertelement <4 x float> %resident.sroa.130.36.vec.insert2023, float %add227.2.1, i64 2, !dbg !137
  %106 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %101), !dbg !138
  %probs.sroa.0.4.vec.insert1537 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1492, i16 %106, i64 2, !dbg !147
  %resident.sroa.130.44.vec.extract2131 = extractelement <4 x float> %resident.sroa.130.1, i64 3, !dbg !151
  %add227.3.1 = fadd contract float %resident.sroa.130.44.vec.extract2131, %103, !dbg !152
  %resident.sroa.130.44.vec.insert2133 = insertelement <4 x float> %resident.sroa.130.40.vec.insert2078, float %add227.3.1, i64 3, !dbg !137
  %107 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %103), !dbg !138
  %probs.sroa.0.6.vec.insert1559 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1537, i16 %107, i64 3, !dbg !147
  br label %if.end252.1, !dbg !148

if.end252.1:                                      ; preds = %if.end252, %if.end184.1
  %resident.sroa.130.2 = phi <4 x float> [ %resident.sroa.130.44.vec.insert2133, %if.end184.1 ], [ %resident.sroa.130.1, %if.end252 ], !dbg !70
  %probs.sroa.0.1 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1559, %if.end184.1 ], [ zeroinitializer, %if.end252 ], !dbg !70
  %add261.1 = or disjoint i32 %and259, 256, !dbg !153
  %add.ptr263.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add261.1, !dbg !149
  store <4 x i16> %probs.sroa.0.1, ptr addrspace(3) %add.ptr263.1, align 8, !dbg !150
  br i1 %or.cond664.2, label %if.end252.2, label %if.then153.2, !dbg !120

if.then153.2:                                     ; preds = %if.end252.1
  %cmp156.2 = icmp sgt i32 %mul11.2, %invariant.op, !dbg !121
  br i1 %cmp156.2, label %for.cond158.preheader.2, label %if.end184.2, !dbg !122

for.cond158.preheader.2:                          ; preds = %if.then153.2
  %add166.2 = or disjoint i32 %mul11.2, %mul165
  %cmp169.not.2693 = icmp sgt i32 %add166.2, %1, !dbg !123
  %spec.select.2694 = select i1 %cmp169.not.2693, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.0.vec.insert950 = insertelement <4 x float> poison, float %spec.select.2694, i64 0, !dbg !125
  %cmp169.not.1.2.not = icmp slt i32 %add166.2, %1, !dbg !123
  %spec.select.1.2 = select i1 %cmp169.not.1.2.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !124
  %scores.sroa.0.4.vec.insert1085 = insertelement <4 x float> %scores.sroa.0.0.vec.insert950, float %spec.select.1.2, i64 1, !dbg !125
  %add167.2.2 = or disjoint i32 %add166.2, 2, !dbg !126
  %cmp169.not.2.2 = icmp sgt i32 %add167.2.2, %1, !dbg !123
  %spec.select.2.2 = select i1 %cmp169.not.2.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.8.vec.insert1202 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1085, float %spec.select.2.2, i64 2, !dbg !125
  %add167.3.2 = or disjoint i32 %add166.2, 3, !dbg !126
  %cmp169.not.3.2 = icmp sgt i32 %add167.3.2, %1, !dbg !123
  %spec.select.3.2 = select i1 %cmp169.not.3.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.12.vec.insert1319 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1202, float %spec.select.3.2, i64 3, !dbg !125
  br label %if.end184.2

if.end184.2:                                      ; preds = %if.then153.2, %for.cond158.preheader.2
  %scores.sroa.0.4 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1319, %for.cond158.preheader.2 ], [ zeroinitializer, %if.then153.2 ], !dbg !70
  %resident.sroa.0.0.vec.extract1803 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %108 = bitcast <2 x float> %resident.sroa.0.0.vec.extract1803 to <4 x half>, !dbg !127
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.158.0, <4 x half> %108, <4 x float> %scores.sroa.0.4), !dbg !128
  %resident.sroa.0.8.vec.extract1837 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %110 = bitcast <2 x float> %resident.sroa.0.8.vec.extract1837 to <4 x half>, !dbg !127
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.164.0, <4 x half> %110, <4 x float> %109), !dbg !128
  %resident.sroa.66.16.vec.extract1883 = shufflevector <4 x float> %resident.sroa.66.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %112 = bitcast <2 x float> %resident.sroa.66.16.vec.extract1883 to <4 x half>, !dbg !127
  %113 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.167.0, <4 x half> %112, <4 x float> %111), !dbg !128
  %resident.sroa.66.24.vec.extract1917 = shufflevector <4 x float> %resident.sroa.66.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %114 = bitcast <2 x float> %resident.sroa.66.24.vec.extract1917 to <4 x half>, !dbg !127
  %115 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.173.0, <4 x half> %114, <4 x float> %113), !dbg !128
  %scores.sroa.0.0.vec.extract952 = extractelement <4 x float> %115, i64 0, !dbg !129
  %mul210.2697 = fmul contract float %scores.sroa.0.0.vec.extract952, 0x3FB99999A0000000, !dbg !130
  %116 = tail call contract noundef float @llvm.minnum.f32(float %mul210.2697, float 0x4024CB5EC0000000), !dbg !131
  %117 = tail call contract noundef float @llvm.exp.f32(float %116), !dbg !134
  %scores.sroa.0.4.vec.extract1087 = extractelement <4 x float> %115, i64 1, !dbg !129
  %mul210.1.2 = fmul contract float %scores.sroa.0.4.vec.extract1087, 0x3FB99999A0000000, !dbg !130
  %118 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1.2, float 0x4024CB5EC0000000), !dbg !131
  %119 = tail call contract noundef float @llvm.exp.f32(float %118), !dbg !134
  %scores.sroa.0.8.vec.extract1204 = extractelement <4 x float> %115, i64 2, !dbg !129
  %mul210.2.2 = fmul contract float %scores.sroa.0.8.vec.extract1204, 0x3FB99999A0000000, !dbg !130
  %120 = tail call contract noundef float @llvm.minnum.f32(float %mul210.2.2, float 0x4024CB5EC0000000), !dbg !131
  %121 = tail call contract noundef float @llvm.exp.f32(float %120), !dbg !134
  %scores.sroa.0.12.vec.extract1321 = extractelement <4 x float> %115, i64 3, !dbg !129
  %mul210.3.2 = fmul contract float %scores.sroa.0.12.vec.extract1321, 0x3FB99999A0000000, !dbg !130
  %122 = tail call contract noundef float @llvm.minnum.f32(float %mul210.3.2, float 0x4024CB5EC0000000), !dbg !131
  %123 = tail call contract noundef float @llvm.exp.f32(float %122), !dbg !134
  %resident.sroa.130.32.vec.extract1972 = extractelement <4 x float> %resident.sroa.130.2, i64 0, !dbg !151
  %add227.2699 = fadd contract float %resident.sroa.130.32.vec.extract1972, %117, !dbg !152
  %resident.sroa.130.32.vec.insert1974 = insertelement <4 x float> poison, float %add227.2699, i64 0, !dbg !137
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %117), !dbg !138
  %probs.sroa.0.0.vec.insert1448 = insertelement <4 x i16> poison, i16 %124, i64 0, !dbg !147
  %resident.sroa.130.36.vec.extract2025 = extractelement <4 x float> %resident.sroa.130.2, i64 1, !dbg !151
  %add227.1.2 = fadd contract float %resident.sroa.130.36.vec.extract2025, %119, !dbg !152
  %resident.sroa.130.36.vec.insert2027 = insertelement <4 x float> %resident.sroa.130.32.vec.insert1974, float %add227.1.2, i64 1, !dbg !137
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %119), !dbg !138
  %probs.sroa.0.2.vec.insert1494 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1448, i16 %125, i64 1, !dbg !147
  %resident.sroa.130.40.vec.extract2080 = extractelement <4 x float> %resident.sroa.130.2, i64 2, !dbg !151
  %add227.2.2 = fadd contract float %resident.sroa.130.40.vec.extract2080, %121, !dbg !152
  %resident.sroa.130.40.vec.insert2082 = insertelement <4 x float> %resident.sroa.130.36.vec.insert2027, float %add227.2.2, i64 2, !dbg !137
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %121), !dbg !138
  %probs.sroa.0.4.vec.insert1539 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1494, i16 %126, i64 2, !dbg !147
  %resident.sroa.130.44.vec.extract2135 = extractelement <4 x float> %resident.sroa.130.2, i64 3, !dbg !151
  %add227.3.2 = fadd contract float %resident.sroa.130.44.vec.extract2135, %123, !dbg !152
  %resident.sroa.130.44.vec.insert2137 = insertelement <4 x float> %resident.sroa.130.40.vec.insert2082, float %add227.3.2, i64 3, !dbg !137
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %123), !dbg !138
  %probs.sroa.0.6.vec.insert1561 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1539, i16 %127, i64 3, !dbg !147
  br label %if.end252.2, !dbg !148

if.end252.2:                                      ; preds = %if.end252.1, %if.end184.2
  %resident.sroa.130.3 = phi <4 x float> [ %resident.sroa.130.44.vec.insert2137, %if.end184.2 ], [ %resident.sroa.130.2, %if.end252.1 ], !dbg !70
  %probs.sroa.0.2 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1561, %if.end184.2 ], [ zeroinitializer, %if.end252.1 ], !dbg !70
  %add261.2 = or disjoint i32 %and259, 512, !dbg !153
  %add.ptr263.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add261.2, !dbg !149
  store <4 x i16> %probs.sroa.0.2, ptr addrspace(3) %add.ptr263.2, align 8, !dbg !150
  br i1 %or.cond664.3, label %if.end252.3, label %if.then153.3, !dbg !120

if.then153.3:                                     ; preds = %if.end252.2
  %cmp156.3 = icmp sgt i32 %mul11.3, %invariant.op, !dbg !121
  br i1 %cmp156.3, label %for.cond158.preheader.3, label %if.end184.3, !dbg !122

for.cond158.preheader.3:                          ; preds = %if.then153.3
  %add166.3 = or disjoint i32 %mul11.3, %mul165
  %cmp169.not.3700 = icmp sgt i32 %add166.3, %1, !dbg !123
  %spec.select.3701 = select i1 %cmp169.not.3700, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.0.vec.insert960 = insertelement <4 x float> poison, float %spec.select.3701, i64 0, !dbg !125
  %cmp169.not.1.3.not = icmp slt i32 %add166.3, %1, !dbg !123
  %spec.select.1.3 = select i1 %cmp169.not.1.3.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !124
  %scores.sroa.0.4.vec.insert1093 = insertelement <4 x float> %scores.sroa.0.0.vec.insert960, float %spec.select.1.3, i64 1, !dbg !125
  %add167.2.3 = or disjoint i32 %add166.3, 2, !dbg !126
  %cmp169.not.2.3 = icmp sgt i32 %add167.2.3, %1, !dbg !123
  %spec.select.2.3 = select i1 %cmp169.not.2.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.8.vec.insert1210 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1093, float %spec.select.2.3, i64 2, !dbg !125
  %add167.3.3 = or disjoint i32 %add166.3, 3, !dbg !126
  %cmp169.not.3.3 = icmp sgt i32 %add167.3.3, %1, !dbg !123
  %spec.select.3.3 = select i1 %cmp169.not.3.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.12.vec.insert1327 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1210, float %spec.select.3.3, i64 3, !dbg !125
  br label %if.end184.3

if.end184.3:                                      ; preds = %if.then153.3, %for.cond158.preheader.3
  %scores.sroa.0.6 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1327, %for.cond158.preheader.3 ], [ zeroinitializer, %if.then153.3 ], !dbg !70
  %resident.sroa.0.0.vec.extract1805 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %128 = bitcast <2 x float> %resident.sroa.0.0.vec.extract1805 to <4 x half>, !dbg !127
  %129 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.176.0, <4 x half> %128, <4 x float> %scores.sroa.0.6), !dbg !128
  %resident.sroa.0.8.vec.extract1839 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %130 = bitcast <2 x float> %resident.sroa.0.8.vec.extract1839 to <4 x half>, !dbg !127
  %131 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.182.0, <4 x half> %130, <4 x float> %129), !dbg !128
  %resident.sroa.66.16.vec.extract1885 = shufflevector <4 x float> %resident.sroa.66.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %132 = bitcast <2 x float> %resident.sroa.66.16.vec.extract1885 to <4 x half>, !dbg !127
  %133 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.185.0, <4 x half> %132, <4 x float> %131), !dbg !128
  %resident.sroa.66.24.vec.extract1919 = shufflevector <4 x float> %resident.sroa.66.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %134 = bitcast <2 x float> %resident.sroa.66.24.vec.extract1919 to <4 x half>, !dbg !127
  %135 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.191.0, <4 x half> %134, <4 x float> %133), !dbg !128
  %scores.sroa.0.0.vec.extract962 = extractelement <4 x float> %135, i64 0, !dbg !129
  %mul210.3704 = fmul contract float %scores.sroa.0.0.vec.extract962, 0x3FB99999A0000000, !dbg !130
  %136 = tail call contract noundef float @llvm.minnum.f32(float %mul210.3704, float 0x4024CB5EC0000000), !dbg !131
  %137 = tail call contract noundef float @llvm.exp.f32(float %136), !dbg !134
  %scores.sroa.0.4.vec.extract1095 = extractelement <4 x float> %135, i64 1, !dbg !129
  %mul210.1.3 = fmul contract float %scores.sroa.0.4.vec.extract1095, 0x3FB99999A0000000, !dbg !130
  %138 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1.3, float 0x4024CB5EC0000000), !dbg !131
  %139 = tail call contract noundef float @llvm.exp.f32(float %138), !dbg !134
  %scores.sroa.0.8.vec.extract1212 = extractelement <4 x float> %135, i64 2, !dbg !129
  %mul210.2.3 = fmul contract float %scores.sroa.0.8.vec.extract1212, 0x3FB99999A0000000, !dbg !130
  %140 = tail call contract noundef float @llvm.minnum.f32(float %mul210.2.3, float 0x4024CB5EC0000000), !dbg !131
  %141 = tail call contract noundef float @llvm.exp.f32(float %140), !dbg !134
  %scores.sroa.0.12.vec.extract1329 = extractelement <4 x float> %135, i64 3, !dbg !129
  %mul210.3.3 = fmul contract float %scores.sroa.0.12.vec.extract1329, 0x3FB99999A0000000, !dbg !130
  %142 = tail call contract noundef float @llvm.minnum.f32(float %mul210.3.3, float 0x4024CB5EC0000000), !dbg !131
  %143 = tail call contract noundef float @llvm.exp.f32(float %142), !dbg !134
  %resident.sroa.130.32.vec.extract1976 = extractelement <4 x float> %resident.sroa.130.3, i64 0, !dbg !151
  %add227.3706 = fadd contract float %resident.sroa.130.32.vec.extract1976, %137, !dbg !152
  %resident.sroa.130.32.vec.insert1978 = insertelement <4 x float> poison, float %add227.3706, i64 0, !dbg !137
  %144 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %137), !dbg !138
  %probs.sroa.0.0.vec.insert1450 = insertelement <4 x i16> poison, i16 %144, i64 0, !dbg !147
  %resident.sroa.130.36.vec.extract2029 = extractelement <4 x float> %resident.sroa.130.3, i64 1, !dbg !151
  %add227.1.3 = fadd contract float %resident.sroa.130.36.vec.extract2029, %139, !dbg !152
  %resident.sroa.130.36.vec.insert2031 = insertelement <4 x float> %resident.sroa.130.32.vec.insert1978, float %add227.1.3, i64 1, !dbg !137
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %139), !dbg !138
  %probs.sroa.0.2.vec.insert1496 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1450, i16 %145, i64 1, !dbg !147
  %resident.sroa.130.40.vec.extract2084 = extractelement <4 x float> %resident.sroa.130.3, i64 2, !dbg !151
  %add227.2.3 = fadd contract float %resident.sroa.130.40.vec.extract2084, %141, !dbg !152
  %resident.sroa.130.40.vec.insert2086 = insertelement <4 x float> %resident.sroa.130.36.vec.insert2031, float %add227.2.3, i64 2, !dbg !137
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %141), !dbg !138
  %probs.sroa.0.4.vec.insert1541 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1496, i16 %146, i64 2, !dbg !147
  %resident.sroa.130.44.vec.extract2139 = extractelement <4 x float> %resident.sroa.130.3, i64 3, !dbg !151
  %add227.3.3 = fadd contract float %resident.sroa.130.44.vec.extract2139, %143, !dbg !152
  %resident.sroa.130.44.vec.insert2141 = insertelement <4 x float> %resident.sroa.130.40.vec.insert2086, float %add227.3.3, i64 3, !dbg !137
  %147 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %143), !dbg !138
  %probs.sroa.0.6.vec.insert1563 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1541, i16 %147, i64 3, !dbg !147
  br label %if.end252.3, !dbg !148

if.end252.3:                                      ; preds = %if.end252.2, %if.end184.3
  %resident.sroa.130.4 = phi <4 x float> [ %resident.sroa.130.44.vec.insert2141, %if.end184.3 ], [ %resident.sroa.130.3, %if.end252.2 ], !dbg !70
  %probs.sroa.0.3 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1563, %if.end184.3 ], [ zeroinitializer, %if.end252.2 ], !dbg !70
  %add261.3 = or disjoint i32 %and259, 768, !dbg !153
  %add.ptr263.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add261.3, !dbg !149
  store <4 x i16> %probs.sroa.0.3, ptr addrspace(3) %add.ptr263.3, align 8, !dbg !150
  br label %if.end371

if.end371:                                        ; preds = %if.end, %if.end252.3
  %resident.sroa.130.5 = phi <4 x float> [ zeroinitializer, %if.end ], [ %resident.sroa.130.4, %if.end252.3 ], !dbg !154
  %kr.sroa.191.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.191.0, %if.end252.3 ]
  %kr.sroa.185.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.185.0, %if.end252.3 ]
  %kr.sroa.182.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.182.0, %if.end252.3 ]
  %kr.sroa.176.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.176.0, %if.end252.3 ]
  %kr.sroa.173.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.173.0, %if.end252.3 ]
  %kr.sroa.167.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.167.0, %if.end252.3 ]
  %kr.sroa.164.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.164.0, %if.end252.3 ]
  %kr.sroa.158.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.158.0, %if.end252.3 ]
  %kr.sroa.155.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.155.0, %if.end252.3 ]
  %kr.sroa.149.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.149.0, %if.end252.3 ]
  %kr.sroa.146.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.146.0, %if.end252.3 ]
  %kr.sroa.140.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.140.0, %if.end252.3 ]
  %kr.sroa.113.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.113.0, %if.end252.3 ]
  %kr.sroa.71.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.71.0, %if.end252.3 ]
  %kr.sroa.44.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.44.0, %if.end252.3 ]
  %kr.sroa.0.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.0.0, %if.end252.3 ]
  fence syncscope("block") release, !dbg !155
  tail call void @llvm.mxc.barrier(), !dbg !160
  fence syncscope("block") acquire, !dbg !161
  br i1 %cmp91, label %if.end267.1, label %for.cond94.preheader.1, !dbg !72

for.cond94.preheader.1:                           ; preds = %if.end371
  %or.cond663.1717 = icmp ugt i32 %mul11.4, 1023, !dbg !114
  %cmp107.not.1718 = icmp sgt i32 %mul11.4, %1
  %or.cond664.1719 = or i1 %or.cond663.1717, %cmp107.not.1718, !dbg !114
  br i1 %or.cond664.1719, label %if.end135.1726, label %for.cond109.preheader.1722, !dbg !114

for.cond109.preheader.1722:                       ; preds = %for.cond94.preheader.1
  %148 = shl nsw i32 %cond.i.i630.4, 10
  %mul116.1720 = and i32 %148, 64512
  %add117.1721 = or disjoint i32 %mul116.1720, %mul114
  %149 = zext nneg i32 %add117.1721 to i64, !dbg !115
  %150 = or disjoint i64 %149, %34, !dbg !116
  %add.ptr125.1723 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %150, !dbg !117
  %kr.sroa.0.0.copyload1610 = load <4 x half>, ptr addrspace(4) %add.ptr125.1723, align 16, !dbg !118
  %kr.sroa.44.0.add.ptr125.1723.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1723, i64 8, !dbg !118
  %kr.sroa.44.0.copyload1624 = load <4 x half>, ptr addrspace(4) %kr.sroa.44.0.add.ptr125.1723.sroa_idx, align 8, !dbg !118
  %151 = or disjoint i64 %149, %34, !dbg !116
  %152 = or disjoint i64 %151, 512, !dbg !116
  %add.ptr125.1.1724 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %152, !dbg !117
  %kr.sroa.71.16.copyload1690 = load <4 x half>, ptr addrspace(4) %add.ptr125.1.1724, align 16, !dbg !118
  %kr.sroa.113.16.add.ptr125.1.1724.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1.1724, i64 8, !dbg !118
  %kr.sroa.113.16.copyload1704 = load <4 x half>, ptr addrspace(4) %kr.sroa.113.16.add.ptr125.1.1724.sroa_idx, align 8, !dbg !118
  br label %if.end135.1726, !dbg !119

if.end135.1726:                                   ; preds = %for.cond109.preheader.1722, %for.cond94.preheader.1
  %kr.sroa.113.7 = phi <4 x half> [ %kr.sroa.113.1, %for.cond94.preheader.1 ], [ %kr.sroa.113.16.copyload1704, %for.cond109.preheader.1722 ]
  %kr.sroa.71.7 = phi <4 x half> [ %kr.sroa.71.1, %for.cond94.preheader.1 ], [ %kr.sroa.71.16.copyload1690, %for.cond109.preheader.1722 ]
  %kr.sroa.44.7 = phi <4 x half> [ %kr.sroa.44.1, %for.cond94.preheader.1 ], [ %kr.sroa.44.0.copyload1624, %for.cond109.preheader.1722 ]
  %kr.sroa.0.7 = phi <4 x half> [ %kr.sroa.0.1, %for.cond94.preheader.1 ], [ %kr.sroa.0.0.copyload1610, %for.cond109.preheader.1722 ]
  %or.cond663.1.1 = icmp ugt i32 %mul11.5, 1023, !dbg !114
  %cmp107.not.1.1 = icmp sgt i32 %mul11.5, %1
  %or.cond664.1.1 = or i1 %or.cond663.1.1, %cmp107.not.1.1, !dbg !114
  br i1 %or.cond664.1.1, label %if.end135.1.1, label %for.cond109.preheader.1.1, !dbg !114

for.cond109.preheader.1.1:                        ; preds = %if.end135.1726
  %153 = shl nsw i32 %cond.i.i630.5, 10
  %mul116.1.1 = and i32 %153, 64512
  %add117.1.1 = or disjoint i32 %mul116.1.1, %mul114
  %154 = zext nneg i32 %add117.1.1 to i64, !dbg !115
  %155 = or disjoint i64 %154, %34, !dbg !116
  %add.ptr125.1683.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %155, !dbg !117
  %kr.sroa.140.32.copyload1742 = load <4 x half>, ptr addrspace(4) %add.ptr125.1683.1, align 16, !dbg !118
  %kr.sroa.146.32.add.ptr125.1683.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1683.1, i64 8, !dbg !118
  %kr.sroa.146.32.copyload1744 = load <4 x half>, ptr addrspace(4) %kr.sroa.146.32.add.ptr125.1683.1.sroa_idx, align 8, !dbg !118
  %156 = or disjoint i64 %154, %34, !dbg !116
  %157 = or disjoint i64 %156, 512, !dbg !116
  %add.ptr125.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %157, !dbg !117
  %kr.sroa.149.48.copyload1750 = load <4 x half>, ptr addrspace(4) %add.ptr125.1.1.1, align 16, !dbg !118
  %kr.sroa.155.48.add.ptr125.1.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1.1.1, i64 8, !dbg !118
  %kr.sroa.155.48.copyload1752 = load <4 x half>, ptr addrspace(4) %kr.sroa.155.48.add.ptr125.1.1.1.sroa_idx, align 8, !dbg !118
  br label %if.end135.1.1, !dbg !119

if.end135.1.1:                                    ; preds = %for.cond109.preheader.1.1, %if.end135.1726
  %kr.sroa.155.2 = phi <4 x half> [ %kr.sroa.155.1, %if.end135.1726 ], [ %kr.sroa.155.48.copyload1752, %for.cond109.preheader.1.1 ]
  %kr.sroa.149.2 = phi <4 x half> [ %kr.sroa.149.1, %if.end135.1726 ], [ %kr.sroa.149.48.copyload1750, %for.cond109.preheader.1.1 ]
  %kr.sroa.146.2 = phi <4 x half> [ %kr.sroa.146.1, %if.end135.1726 ], [ %kr.sroa.146.32.copyload1744, %for.cond109.preheader.1.1 ]
  %kr.sroa.140.2 = phi <4 x half> [ %kr.sroa.140.1, %if.end135.1726 ], [ %kr.sroa.140.32.copyload1742, %for.cond109.preheader.1.1 ]
  %or.cond663.2.1 = icmp ugt i32 %mul11.6, 1023, !dbg !114
  %cmp107.not.2.1 = icmp sgt i32 %mul11.6, %1
  %or.cond664.2.1 = or i1 %or.cond663.2.1, %cmp107.not.2.1, !dbg !114
  br i1 %or.cond664.2.1, label %if.end135.2.1, label %for.cond109.preheader.2.1, !dbg !114

for.cond109.preheader.2.1:                        ; preds = %if.end135.1.1
  %158 = shl nsw i32 %cond.i.i630.6, 10
  %mul116.2.1 = and i32 %158, 64512
  %add117.2.1 = or disjoint i32 %mul116.2.1, %mul114
  %159 = zext nneg i32 %add117.2.1 to i64, !dbg !115
  %160 = or disjoint i64 %159, %34, !dbg !116
  %add.ptr125.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %160, !dbg !117
  %kr.sroa.158.64.copyload1758 = load <4 x half>, ptr addrspace(4) %add.ptr125.2.1, align 16, !dbg !118
  %kr.sroa.164.64.add.ptr125.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.2.1, i64 8, !dbg !118
  %kr.sroa.164.64.copyload1760 = load <4 x half>, ptr addrspace(4) %kr.sroa.164.64.add.ptr125.2.1.sroa_idx, align 8, !dbg !118
  %161 = or disjoint i64 %159, %34, !dbg !116
  %162 = or disjoint i64 %161, 512, !dbg !116
  %add.ptr125.1.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %162, !dbg !117
  %kr.sroa.167.80.copyload1766 = load <4 x half>, ptr addrspace(4) %add.ptr125.1.2.1, align 16, !dbg !118
  %kr.sroa.173.80.add.ptr125.1.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1.2.1, i64 8, !dbg !118
  %kr.sroa.173.80.copyload1768 = load <4 x half>, ptr addrspace(4) %kr.sroa.173.80.add.ptr125.1.2.1.sroa_idx, align 8, !dbg !118
  br label %if.end135.2.1, !dbg !119

if.end135.2.1:                                    ; preds = %for.cond109.preheader.2.1, %if.end135.1.1
  %kr.sroa.173.2 = phi <4 x half> [ %kr.sroa.173.1, %if.end135.1.1 ], [ %kr.sroa.173.80.copyload1768, %for.cond109.preheader.2.1 ]
  %kr.sroa.167.2 = phi <4 x half> [ %kr.sroa.167.1, %if.end135.1.1 ], [ %kr.sroa.167.80.copyload1766, %for.cond109.preheader.2.1 ]
  %kr.sroa.164.2 = phi <4 x half> [ %kr.sroa.164.1, %if.end135.1.1 ], [ %kr.sroa.164.64.copyload1760, %for.cond109.preheader.2.1 ]
  %kr.sroa.158.2 = phi <4 x half> [ %kr.sroa.158.1, %if.end135.1.1 ], [ %kr.sroa.158.64.copyload1758, %for.cond109.preheader.2.1 ]
  %or.cond663.3.1 = icmp ugt i32 %mul11.7, 1023, !dbg !114
  %cmp107.not.3.1 = icmp sgt i32 %mul11.7, %1
  %or.cond664.3.1 = or i1 %or.cond663.3.1, %cmp107.not.3.1, !dbg !114
  br i1 %or.cond664.3.1, label %if.end135.3.1, label %for.cond109.preheader.3.1, !dbg !114

for.cond109.preheader.3.1:                        ; preds = %if.end135.2.1
  %163 = shl nsw i32 %cond.i.i630.7, 10
  %mul116.3.1 = and i32 %163, 64512
  %add117.3.1 = or disjoint i32 %mul116.3.1, %mul114
  %164 = zext nneg i32 %add117.3.1 to i64, !dbg !115
  %165 = or disjoint i64 %164, %34, !dbg !116
  %add.ptr125.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %165, !dbg !117
  %kr.sroa.176.96.copyload1774 = load <4 x half>, ptr addrspace(4) %add.ptr125.3.1, align 16, !dbg !118
  %kr.sroa.182.96.add.ptr125.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.3.1, i64 8, !dbg !118
  %kr.sroa.182.96.copyload1776 = load <4 x half>, ptr addrspace(4) %kr.sroa.182.96.add.ptr125.3.1.sroa_idx, align 8, !dbg !118
  %166 = or disjoint i64 %164, %34, !dbg !116
  %167 = or disjoint i64 %166, 512, !dbg !116
  %add.ptr125.1.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %167, !dbg !117
  %kr.sroa.185.112.copyload1782 = load <4 x half>, ptr addrspace(4) %add.ptr125.1.3.1, align 16, !dbg !118
  %kr.sroa.191.112.add.ptr125.1.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1.3.1, i64 8, !dbg !118
  %kr.sroa.191.112.copyload1784 = load <4 x half>, ptr addrspace(4) %kr.sroa.191.112.add.ptr125.1.3.1.sroa_idx, align 8, !dbg !118
  br label %if.end135.3.1, !dbg !119

if.end135.3.1:                                    ; preds = %for.cond109.preheader.3.1, %if.end135.2.1
  %kr.sroa.191.2 = phi <4 x half> [ %kr.sroa.191.1, %if.end135.2.1 ], [ %kr.sroa.191.112.copyload1784, %for.cond109.preheader.3.1 ]
  %kr.sroa.185.2 = phi <4 x half> [ %kr.sroa.185.1, %if.end135.2.1 ], [ %kr.sroa.185.112.copyload1782, %for.cond109.preheader.3.1 ]
  %kr.sroa.182.2 = phi <4 x half> [ %kr.sroa.182.1, %if.end135.2.1 ], [ %kr.sroa.182.96.copyload1776, %for.cond109.preheader.3.1 ]
  %kr.sroa.176.2 = phi <4 x half> [ %kr.sroa.176.1, %if.end135.2.1 ], [ %kr.sroa.176.96.copyload1774, %for.cond109.preheader.3.1 ]
  br i1 %or.cond664.1719, label %if.end252.1783, label %if.then153.1732, !dbg !120

if.then153.1732:                                  ; preds = %if.end135.3.1
  %cmp156.1731 = icmp sgt i32 %mul11.4, %invariant.op, !dbg !121
  br i1 %cmp156.1731, label %for.cond158.preheader.1735, label %if.end184.1752, !dbg !122

for.cond158.preheader.1735:                       ; preds = %if.then153.1732
  %add166.1734 = or disjoint i32 %mul11.4, %mul165
  %cmp169.not.1736 = icmp sgt i32 %add166.1734, %1, !dbg !123
  %spec.select.1737 = select i1 %cmp169.not.1736, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.0.vec.insert970 = insertelement <4 x float> poison, float %spec.select.1737, i64 0, !dbg !125
  %cmp169.not.1.1739.not = icmp slt i32 %add166.1734, %1, !dbg !123
  %spec.select.1.1740 = select i1 %cmp169.not.1.1739.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !124
  %scores.sroa.0.4.vec.insert1101 = insertelement <4 x float> %scores.sroa.0.0.vec.insert970, float %spec.select.1.1740, i64 1, !dbg !125
  %add167.2.1742 = or disjoint i32 %add166.1734, 2, !dbg !126
  %cmp169.not.2.1743 = icmp sgt i32 %add167.2.1742, %1, !dbg !123
  %spec.select.2.1744 = select i1 %cmp169.not.2.1743, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.8.vec.insert1218 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1101, float %spec.select.2.1744, i64 2, !dbg !125
  %add167.3.1746 = or disjoint i32 %add166.1734, 3, !dbg !126
  %cmp169.not.3.1747 = icmp sgt i32 %add167.3.1746, %1, !dbg !123
  %spec.select.3.1748 = select i1 %cmp169.not.3.1747, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.12.vec.insert1335 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1218, float %spec.select.3.1748, i64 3, !dbg !125
  br label %if.end184.1752

if.end184.1752:                                   ; preds = %if.then153.1732, %for.cond158.preheader.1735
  %scores.sroa.0.9 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1335, %for.cond158.preheader.1735 ], [ zeroinitializer, %if.then153.1732 ], !dbg !70
  %resident.sroa.0.0.vec.extract1807 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %168 = bitcast <2 x float> %resident.sroa.0.0.vec.extract1807 to <4 x half>, !dbg !127
  %169 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.7, <4 x half> %168, <4 x float> %scores.sroa.0.9), !dbg !128
  %resident.sroa.0.8.vec.extract1841 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %170 = bitcast <2 x float> %resident.sroa.0.8.vec.extract1841 to <4 x half>, !dbg !127
  %171 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.44.7, <4 x half> %170, <4 x float> %169), !dbg !128
  %resident.sroa.66.16.vec.extract1887 = shufflevector <4 x float> %resident.sroa.66.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %172 = bitcast <2 x float> %resident.sroa.66.16.vec.extract1887 to <4 x half>, !dbg !127
  %173 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.71.7, <4 x half> %172, <4 x float> %171), !dbg !128
  %resident.sroa.66.24.vec.extract1921 = shufflevector <4 x float> %resident.sroa.66.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %174 = bitcast <2 x float> %resident.sroa.66.24.vec.extract1921 to <4 x half>, !dbg !127
  %175 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.113.7, <4 x half> %174, <4 x float> %173), !dbg !128
  %scores.sroa.0.0.vec.extract972 = extractelement <4 x float> %175, i64 0, !dbg !129
  %mul210.1757 = fmul contract float %scores.sroa.0.0.vec.extract972, 0x3FB99999A0000000, !dbg !130
  %176 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1757, float 0x4024CB5EC0000000), !dbg !131
  %177 = tail call contract noundef float @llvm.exp.f32(float %176), !dbg !134
  %scores.sroa.0.4.vec.extract1103 = extractelement <4 x float> %175, i64 1, !dbg !129
  %mul210.1.1759 = fmul contract float %scores.sroa.0.4.vec.extract1103, 0x3FB99999A0000000, !dbg !130
  %178 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1.1759, float 0x4024CB5EC0000000), !dbg !131
  %179 = tail call contract noundef float @llvm.exp.f32(float %178), !dbg !134
  %scores.sroa.0.8.vec.extract1220 = extractelement <4 x float> %175, i64 2, !dbg !129
  %mul210.2.1761 = fmul contract float %scores.sroa.0.8.vec.extract1220, 0x3FB99999A0000000, !dbg !130
  %180 = tail call contract noundef float @llvm.minnum.f32(float %mul210.2.1761, float 0x4024CB5EC0000000), !dbg !131
  %181 = tail call contract noundef float @llvm.exp.f32(float %180), !dbg !134
  %scores.sroa.0.12.vec.extract1337 = extractelement <4 x float> %175, i64 3, !dbg !129
  %mul210.3.1763 = fmul contract float %scores.sroa.0.12.vec.extract1337, 0x3FB99999A0000000, !dbg !130
  %182 = tail call contract noundef float @llvm.minnum.f32(float %mul210.3.1763, float 0x4024CB5EC0000000), !dbg !131
  %183 = tail call contract noundef float @llvm.exp.f32(float %182), !dbg !134
  %resident.sroa.130.32.vec.extract1980 = extractelement <4 x float> %resident.sroa.130.5, i64 0, !dbg !151
  %add227.1766 = fadd contract float %resident.sroa.130.32.vec.extract1980, %177, !dbg !152
  %resident.sroa.130.32.vec.insert1982 = insertelement <4 x float> poison, float %add227.1766, i64 0, !dbg !137
  %184 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %177), !dbg !138
  %probs.sroa.0.0.vec.insert1452 = insertelement <4 x i16> poison, i16 %184, i64 0, !dbg !147
  %resident.sroa.130.36.vec.extract2033 = extractelement <4 x float> %resident.sroa.130.5, i64 1, !dbg !151
  %add227.1.1769 = fadd contract float %resident.sroa.130.36.vec.extract2033, %179, !dbg !152
  %resident.sroa.130.36.vec.insert2035 = insertelement <4 x float> %resident.sroa.130.32.vec.insert1982, float %add227.1.1769, i64 1, !dbg !137
  %185 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %179), !dbg !138
  %probs.sroa.0.2.vec.insert1498 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1452, i16 %185, i64 1, !dbg !147
  %resident.sroa.130.40.vec.extract2088 = extractelement <4 x float> %resident.sroa.130.5, i64 2, !dbg !151
  %add227.2.1773 = fadd contract float %resident.sroa.130.40.vec.extract2088, %181, !dbg !152
  %resident.sroa.130.40.vec.insert2090 = insertelement <4 x float> %resident.sroa.130.36.vec.insert2035, float %add227.2.1773, i64 2, !dbg !137
  %186 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %181), !dbg !138
  %probs.sroa.0.4.vec.insert1543 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1498, i16 %186, i64 2, !dbg !147
  %resident.sroa.130.44.vec.extract2143 = extractelement <4 x float> %resident.sroa.130.5, i64 3, !dbg !151
  %add227.3.1777 = fadd contract float %resident.sroa.130.44.vec.extract2143, %183, !dbg !152
  %resident.sroa.130.44.vec.insert2145 = insertelement <4 x float> %resident.sroa.130.40.vec.insert2090, float %add227.3.1777, i64 3, !dbg !137
  %187 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %183), !dbg !138
  %probs.sroa.0.6.vec.insert1565 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1543, i16 %187, i64 3, !dbg !147
  br label %if.end252.1783, !dbg !148

if.end252.1783:                                   ; preds = %if.end135.3.1, %if.end184.1752
  %resident.sroa.130.11 = phi <4 x float> [ %resident.sroa.130.44.vec.insert2145, %if.end184.1752 ], [ %resident.sroa.130.5, %if.end135.3.1 ], !dbg !70
  %probs.sroa.0.10 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1565, %if.end184.1752 ], [ zeroinitializer, %if.end135.3.1 ], !dbg !70
  %add261.1781 = or disjoint i32 %and259, 1024, !dbg !153
  %add.ptr263.1782 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add261.1781, !dbg !149
  store <4 x i16> %probs.sroa.0.10, ptr addrspace(3) %add.ptr263.1782, align 8, !dbg !150
  br i1 %or.cond664.1.1, label %if.end252.1.1, label %if.then153.1.1, !dbg !120

if.then153.1.1:                                   ; preds = %if.end252.1783
  %cmp156.1.1 = icmp sgt i32 %mul11.5, %invariant.op, !dbg !121
  br i1 %cmp156.1.1, label %for.cond158.preheader.1.1, label %if.end184.1.1, !dbg !122

for.cond158.preheader.1.1:                        ; preds = %if.then153.1.1
  %add166.1.1 = or disjoint i32 %mul11.5, %mul165
  %cmp169.not.1686.1 = icmp sgt i32 %add166.1.1, %1, !dbg !123
  %spec.select.1687.1 = select i1 %cmp169.not.1686.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.0.vec.insert980 = insertelement <4 x float> poison, float %spec.select.1687.1, i64 0, !dbg !125
  %cmp169.not.1.1.1.not = icmp slt i32 %add166.1.1, %1, !dbg !123
  %spec.select.1.1.1 = select i1 %cmp169.not.1.1.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !124
  %scores.sroa.0.4.vec.insert1109 = insertelement <4 x float> %scores.sroa.0.0.vec.insert980, float %spec.select.1.1.1, i64 1, !dbg !125
  %add167.2.1.1 = or disjoint i32 %add166.1.1, 2, !dbg !126
  %cmp169.not.2.1.1 = icmp sgt i32 %add167.2.1.1, %1, !dbg !123
  %spec.select.2.1.1 = select i1 %cmp169.not.2.1.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.8.vec.insert1226 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1109, float %spec.select.2.1.1, i64 2, !dbg !125
  %add167.3.1.1 = or disjoint i32 %add166.1.1, 3, !dbg !126
  %cmp169.not.3.1.1 = icmp sgt i32 %add167.3.1.1, %1, !dbg !123
  %spec.select.3.1.1 = select i1 %cmp169.not.3.1.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.12.vec.insert1343 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1226, float %spec.select.3.1.1, i64 3, !dbg !125
  br label %if.end184.1.1

if.end184.1.1:                                    ; preds = %if.then153.1.1, %for.cond158.preheader.1.1
  %scores.sroa.0.11 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1343, %for.cond158.preheader.1.1 ], [ zeroinitializer, %if.then153.1.1 ], !dbg !70
  %resident.sroa.0.0.vec.extract1809 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %188 = bitcast <2 x float> %resident.sroa.0.0.vec.extract1809 to <4 x half>, !dbg !127
  %189 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.140.2, <4 x half> %188, <4 x float> %scores.sroa.0.11), !dbg !128
  %resident.sroa.0.8.vec.extract1843 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %190 = bitcast <2 x float> %resident.sroa.0.8.vec.extract1843 to <4 x half>, !dbg !127
  %191 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.146.2, <4 x half> %190, <4 x float> %189), !dbg !128
  %resident.sroa.66.16.vec.extract1889 = shufflevector <4 x float> %resident.sroa.66.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %192 = bitcast <2 x float> %resident.sroa.66.16.vec.extract1889 to <4 x half>, !dbg !127
  %193 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.149.2, <4 x half> %192, <4 x float> %191), !dbg !128
  %resident.sroa.66.24.vec.extract1923 = shufflevector <4 x float> %resident.sroa.66.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %194 = bitcast <2 x float> %resident.sroa.66.24.vec.extract1923 to <4 x half>, !dbg !127
  %195 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.155.2, <4 x half> %194, <4 x float> %193), !dbg !128
  %scores.sroa.0.0.vec.extract982 = extractelement <4 x float> %195, i64 0, !dbg !129
  %mul210.1690.1 = fmul contract float %scores.sroa.0.0.vec.extract982, 0x3FB99999A0000000, !dbg !130
  %196 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1690.1, float 0x4024CB5EC0000000), !dbg !131
  %197 = tail call contract noundef float @llvm.exp.f32(float %196), !dbg !134
  %scores.sroa.0.4.vec.extract1111 = extractelement <4 x float> %195, i64 1, !dbg !129
  %mul210.1.1.1 = fmul contract float %scores.sroa.0.4.vec.extract1111, 0x3FB99999A0000000, !dbg !130
  %198 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1.1.1, float 0x4024CB5EC0000000), !dbg !131
  %199 = tail call contract noundef float @llvm.exp.f32(float %198), !dbg !134
  %scores.sroa.0.8.vec.extract1228 = extractelement <4 x float> %195, i64 2, !dbg !129
  %mul210.2.1.1 = fmul contract float %scores.sroa.0.8.vec.extract1228, 0x3FB99999A0000000, !dbg !130
  %200 = tail call contract noundef float @llvm.minnum.f32(float %mul210.2.1.1, float 0x4024CB5EC0000000), !dbg !131
  %201 = tail call contract noundef float @llvm.exp.f32(float %200), !dbg !134
  %scores.sroa.0.12.vec.extract1345 = extractelement <4 x float> %195, i64 3, !dbg !129
  %mul210.3.1.1 = fmul contract float %scores.sroa.0.12.vec.extract1345, 0x3FB99999A0000000, !dbg !130
  %202 = tail call contract noundef float @llvm.minnum.f32(float %mul210.3.1.1, float 0x4024CB5EC0000000), !dbg !131
  %203 = tail call contract noundef float @llvm.exp.f32(float %202), !dbg !134
  %resident.sroa.130.32.vec.extract1984 = extractelement <4 x float> %resident.sroa.130.11, i64 0, !dbg !151
  %add227.1692.1 = fadd contract float %resident.sroa.130.32.vec.extract1984, %197, !dbg !152
  %resident.sroa.130.32.vec.insert1986 = insertelement <4 x float> poison, float %add227.1692.1, i64 0, !dbg !137
  %204 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %197), !dbg !138
  %probs.sroa.0.0.vec.insert1454 = insertelement <4 x i16> poison, i16 %204, i64 0, !dbg !147
  %resident.sroa.130.36.vec.extract2037 = extractelement <4 x float> %resident.sroa.130.11, i64 1, !dbg !151
  %add227.1.1.1 = fadd contract float %resident.sroa.130.36.vec.extract2037, %199, !dbg !152
  %resident.sroa.130.36.vec.insert2039 = insertelement <4 x float> %resident.sroa.130.32.vec.insert1986, float %add227.1.1.1, i64 1, !dbg !137
  %205 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %199), !dbg !138
  %probs.sroa.0.2.vec.insert1500 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1454, i16 %205, i64 1, !dbg !147
  %resident.sroa.130.40.vec.extract2092 = extractelement <4 x float> %resident.sroa.130.11, i64 2, !dbg !151
  %add227.2.1.1 = fadd contract float %resident.sroa.130.40.vec.extract2092, %201, !dbg !152
  %resident.sroa.130.40.vec.insert2094 = insertelement <4 x float> %resident.sroa.130.36.vec.insert2039, float %add227.2.1.1, i64 2, !dbg !137
  %206 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %201), !dbg !138
  %probs.sroa.0.4.vec.insert1545 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1500, i16 %206, i64 2, !dbg !147
  %resident.sroa.130.44.vec.extract2147 = extractelement <4 x float> %resident.sroa.130.11, i64 3, !dbg !151
  %add227.3.1.1 = fadd contract float %resident.sroa.130.44.vec.extract2147, %203, !dbg !152
  %resident.sroa.130.44.vec.insert2149 = insertelement <4 x float> %resident.sroa.130.40.vec.insert2094, float %add227.3.1.1, i64 3, !dbg !137
  %207 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %203), !dbg !138
  %probs.sroa.0.6.vec.insert1567 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1545, i16 %207, i64 3, !dbg !147
  br label %if.end252.1.1, !dbg !148

if.end252.1.1:                                    ; preds = %if.end252.1783, %if.end184.1.1
  %resident.sroa.130.12 = phi <4 x float> [ %resident.sroa.130.44.vec.insert2149, %if.end184.1.1 ], [ %resident.sroa.130.11, %if.end252.1783 ], !dbg !70
  %probs.sroa.0.11 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1567, %if.end184.1.1 ], [ zeroinitializer, %if.end252.1783 ], !dbg !70
  %add261.1.1 = or disjoint i32 %and259, 1280, !dbg !153
  %add.ptr263.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add261.1.1, !dbg !149
  store <4 x i16> %probs.sroa.0.11, ptr addrspace(3) %add.ptr263.1.1, align 8, !dbg !150
  br i1 %or.cond664.2.1, label %if.end252.2.1, label %if.then153.2.1, !dbg !120

if.then153.2.1:                                   ; preds = %if.end252.1.1
  %cmp156.2.1 = icmp sgt i32 %mul11.6, %invariant.op, !dbg !121
  br i1 %cmp156.2.1, label %for.cond158.preheader.2.1, label %if.end184.2.1, !dbg !122

for.cond158.preheader.2.1:                        ; preds = %if.then153.2.1
  %add166.2.1 = or disjoint i32 %mul11.6, %mul165
  %cmp169.not.2693.1 = icmp sgt i32 %add166.2.1, %1, !dbg !123
  %spec.select.2694.1 = select i1 %cmp169.not.2693.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.0.vec.insert990 = insertelement <4 x float> poison, float %spec.select.2694.1, i64 0, !dbg !125
  %cmp169.not.1.2.1.not = icmp slt i32 %add166.2.1, %1, !dbg !123
  %spec.select.1.2.1 = select i1 %cmp169.not.1.2.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !124
  %scores.sroa.0.4.vec.insert1117 = insertelement <4 x float> %scores.sroa.0.0.vec.insert990, float %spec.select.1.2.1, i64 1, !dbg !125
  %add167.2.2.1 = or disjoint i32 %add166.2.1, 2, !dbg !126
  %cmp169.not.2.2.1 = icmp sgt i32 %add167.2.2.1, %1, !dbg !123
  %spec.select.2.2.1 = select i1 %cmp169.not.2.2.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.8.vec.insert1234 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1117, float %spec.select.2.2.1, i64 2, !dbg !125
  %add167.3.2.1 = or disjoint i32 %add166.2.1, 3, !dbg !126
  %cmp169.not.3.2.1 = icmp sgt i32 %add167.3.2.1, %1, !dbg !123
  %spec.select.3.2.1 = select i1 %cmp169.not.3.2.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.12.vec.insert1351 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1234, float %spec.select.3.2.1, i64 3, !dbg !125
  br label %if.end184.2.1

if.end184.2.1:                                    ; preds = %if.then153.2.1, %for.cond158.preheader.2.1
  %scores.sroa.0.13 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1351, %for.cond158.preheader.2.1 ], [ zeroinitializer, %if.then153.2.1 ], !dbg !70
  %resident.sroa.0.0.vec.extract1811 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %208 = bitcast <2 x float> %resident.sroa.0.0.vec.extract1811 to <4 x half>, !dbg !127
  %209 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.158.2, <4 x half> %208, <4 x float> %scores.sroa.0.13), !dbg !128
  %resident.sroa.0.8.vec.extract1845 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %210 = bitcast <2 x float> %resident.sroa.0.8.vec.extract1845 to <4 x half>, !dbg !127
  %211 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.164.2, <4 x half> %210, <4 x float> %209), !dbg !128
  %resident.sroa.66.16.vec.extract1891 = shufflevector <4 x float> %resident.sroa.66.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %212 = bitcast <2 x float> %resident.sroa.66.16.vec.extract1891 to <4 x half>, !dbg !127
  %213 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.167.2, <4 x half> %212, <4 x float> %211), !dbg !128
  %resident.sroa.66.24.vec.extract1925 = shufflevector <4 x float> %resident.sroa.66.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %214 = bitcast <2 x float> %resident.sroa.66.24.vec.extract1925 to <4 x half>, !dbg !127
  %215 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.173.2, <4 x half> %214, <4 x float> %213), !dbg !128
  %scores.sroa.0.0.vec.extract992 = extractelement <4 x float> %215, i64 0, !dbg !129
  %mul210.2697.1 = fmul contract float %scores.sroa.0.0.vec.extract992, 0x3FB99999A0000000, !dbg !130
  %216 = tail call contract noundef float @llvm.minnum.f32(float %mul210.2697.1, float 0x4024CB5EC0000000), !dbg !131
  %217 = tail call contract noundef float @llvm.exp.f32(float %216), !dbg !134
  %scores.sroa.0.4.vec.extract1119 = extractelement <4 x float> %215, i64 1, !dbg !129
  %mul210.1.2.1 = fmul contract float %scores.sroa.0.4.vec.extract1119, 0x3FB99999A0000000, !dbg !130
  %218 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1.2.1, float 0x4024CB5EC0000000), !dbg !131
  %219 = tail call contract noundef float @llvm.exp.f32(float %218), !dbg !134
  %scores.sroa.0.8.vec.extract1236 = extractelement <4 x float> %215, i64 2, !dbg !129
  %mul210.2.2.1 = fmul contract float %scores.sroa.0.8.vec.extract1236, 0x3FB99999A0000000, !dbg !130
  %220 = tail call contract noundef float @llvm.minnum.f32(float %mul210.2.2.1, float 0x4024CB5EC0000000), !dbg !131
  %221 = tail call contract noundef float @llvm.exp.f32(float %220), !dbg !134
  %scores.sroa.0.12.vec.extract1353 = extractelement <4 x float> %215, i64 3, !dbg !129
  %mul210.3.2.1 = fmul contract float %scores.sroa.0.12.vec.extract1353, 0x3FB99999A0000000, !dbg !130
  %222 = tail call contract noundef float @llvm.minnum.f32(float %mul210.3.2.1, float 0x4024CB5EC0000000), !dbg !131
  %223 = tail call contract noundef float @llvm.exp.f32(float %222), !dbg !134
  %resident.sroa.130.32.vec.extract1988 = extractelement <4 x float> %resident.sroa.130.12, i64 0, !dbg !151
  %add227.2699.1 = fadd contract float %resident.sroa.130.32.vec.extract1988, %217, !dbg !152
  %resident.sroa.130.32.vec.insert1990 = insertelement <4 x float> poison, float %add227.2699.1, i64 0, !dbg !137
  %224 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %217), !dbg !138
  %probs.sroa.0.0.vec.insert1456 = insertelement <4 x i16> poison, i16 %224, i64 0, !dbg !147
  %resident.sroa.130.36.vec.extract2041 = extractelement <4 x float> %resident.sroa.130.12, i64 1, !dbg !151
  %add227.1.2.1 = fadd contract float %resident.sroa.130.36.vec.extract2041, %219, !dbg !152
  %resident.sroa.130.36.vec.insert2043 = insertelement <4 x float> %resident.sroa.130.32.vec.insert1990, float %add227.1.2.1, i64 1, !dbg !137
  %225 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %219), !dbg !138
  %probs.sroa.0.2.vec.insert1502 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1456, i16 %225, i64 1, !dbg !147
  %resident.sroa.130.40.vec.extract2096 = extractelement <4 x float> %resident.sroa.130.12, i64 2, !dbg !151
  %add227.2.2.1 = fadd contract float %resident.sroa.130.40.vec.extract2096, %221, !dbg !152
  %resident.sroa.130.40.vec.insert2098 = insertelement <4 x float> %resident.sroa.130.36.vec.insert2043, float %add227.2.2.1, i64 2, !dbg !137
  %226 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %221), !dbg !138
  %probs.sroa.0.4.vec.insert1547 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1502, i16 %226, i64 2, !dbg !147
  %resident.sroa.130.44.vec.extract2151 = extractelement <4 x float> %resident.sroa.130.12, i64 3, !dbg !151
  %add227.3.2.1 = fadd contract float %resident.sroa.130.44.vec.extract2151, %223, !dbg !152
  %resident.sroa.130.44.vec.insert2153 = insertelement <4 x float> %resident.sroa.130.40.vec.insert2098, float %add227.3.2.1, i64 3, !dbg !137
  %227 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %223), !dbg !138
  %probs.sroa.0.6.vec.insert1569 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1547, i16 %227, i64 3, !dbg !147
  br label %if.end252.2.1, !dbg !148

if.end252.2.1:                                    ; preds = %if.end252.1.1, %if.end184.2.1
  %resident.sroa.130.13 = phi <4 x float> [ %resident.sroa.130.44.vec.insert2153, %if.end184.2.1 ], [ %resident.sroa.130.12, %if.end252.1.1 ], !dbg !70
  %probs.sroa.0.12 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1569, %if.end184.2.1 ], [ zeroinitializer, %if.end252.1.1 ], !dbg !70
  %add261.2.1 = or disjoint i32 %and259, 1536, !dbg !153
  %add.ptr263.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add261.2.1, !dbg !149
  store <4 x i16> %probs.sroa.0.12, ptr addrspace(3) %add.ptr263.2.1, align 8, !dbg !150
  br i1 %or.cond664.3.1, label %if.end252.3.1, label %if.then153.3.1, !dbg !120

if.then153.3.1:                                   ; preds = %if.end252.2.1
  %cmp156.3.1 = icmp sgt i32 %mul11.7, %invariant.op, !dbg !121
  br i1 %cmp156.3.1, label %for.cond158.preheader.3.1, label %if.end184.3.1, !dbg !122

for.cond158.preheader.3.1:                        ; preds = %if.then153.3.1
  %add166.3.1 = or disjoint i32 %mul11.7, %mul165
  %cmp169.not.3700.1 = icmp sgt i32 %add166.3.1, %1, !dbg !123
  %spec.select.3701.1 = select i1 %cmp169.not.3700.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.0.vec.insert1000 = insertelement <4 x float> poison, float %spec.select.3701.1, i64 0, !dbg !125
  %cmp169.not.1.3.1.not = icmp slt i32 %add166.3.1, %1, !dbg !123
  %spec.select.1.3.1 = select i1 %cmp169.not.1.3.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !124
  %scores.sroa.0.4.vec.insert1125 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1000, float %spec.select.1.3.1, i64 1, !dbg !125
  %add167.2.3.1 = or disjoint i32 %add166.3.1, 2, !dbg !126
  %cmp169.not.2.3.1 = icmp sgt i32 %add167.2.3.1, %1, !dbg !123
  %spec.select.2.3.1 = select i1 %cmp169.not.2.3.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.8.vec.insert1242 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1125, float %spec.select.2.3.1, i64 2, !dbg !125
  %add167.3.3.1 = or disjoint i32 %add166.3.1, 3, !dbg !126
  %cmp169.not.3.3.1 = icmp sgt i32 %add167.3.3.1, %1, !dbg !123
  %spec.select.3.3.1 = select i1 %cmp169.not.3.3.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.12.vec.insert1359 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1242, float %spec.select.3.3.1, i64 3, !dbg !125
  br label %if.end184.3.1

if.end184.3.1:                                    ; preds = %if.then153.3.1, %for.cond158.preheader.3.1
  %scores.sroa.0.15 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1359, %for.cond158.preheader.3.1 ], [ zeroinitializer, %if.then153.3.1 ], !dbg !70
  %resident.sroa.0.0.vec.extract1813 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %228 = bitcast <2 x float> %resident.sroa.0.0.vec.extract1813 to <4 x half>, !dbg !127
  %229 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.176.2, <4 x half> %228, <4 x float> %scores.sroa.0.15), !dbg !128
  %resident.sroa.0.8.vec.extract1847 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %230 = bitcast <2 x float> %resident.sroa.0.8.vec.extract1847 to <4 x half>, !dbg !127
  %231 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.182.2, <4 x half> %230, <4 x float> %229), !dbg !128
  %resident.sroa.66.16.vec.extract1893 = shufflevector <4 x float> %resident.sroa.66.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %232 = bitcast <2 x float> %resident.sroa.66.16.vec.extract1893 to <4 x half>, !dbg !127
  %233 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.185.2, <4 x half> %232, <4 x float> %231), !dbg !128
  %resident.sroa.66.24.vec.extract1927 = shufflevector <4 x float> %resident.sroa.66.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %234 = bitcast <2 x float> %resident.sroa.66.24.vec.extract1927 to <4 x half>, !dbg !127
  %235 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.191.2, <4 x half> %234, <4 x float> %233), !dbg !128
  %scores.sroa.0.0.vec.extract1002 = extractelement <4 x float> %235, i64 0, !dbg !129
  %mul210.3704.1 = fmul contract float %scores.sroa.0.0.vec.extract1002, 0x3FB99999A0000000, !dbg !130
  %236 = tail call contract noundef float @llvm.minnum.f32(float %mul210.3704.1, float 0x4024CB5EC0000000), !dbg !131
  %237 = tail call contract noundef float @llvm.exp.f32(float %236), !dbg !134
  %scores.sroa.0.4.vec.extract1127 = extractelement <4 x float> %235, i64 1, !dbg !129
  %mul210.1.3.1 = fmul contract float %scores.sroa.0.4.vec.extract1127, 0x3FB99999A0000000, !dbg !130
  %238 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1.3.1, float 0x4024CB5EC0000000), !dbg !131
  %239 = tail call contract noundef float @llvm.exp.f32(float %238), !dbg !134
  %scores.sroa.0.8.vec.extract1244 = extractelement <4 x float> %235, i64 2, !dbg !129
  %mul210.2.3.1 = fmul contract float %scores.sroa.0.8.vec.extract1244, 0x3FB99999A0000000, !dbg !130
  %240 = tail call contract noundef float @llvm.minnum.f32(float %mul210.2.3.1, float 0x4024CB5EC0000000), !dbg !131
  %241 = tail call contract noundef float @llvm.exp.f32(float %240), !dbg !134
  %scores.sroa.0.12.vec.extract1361 = extractelement <4 x float> %235, i64 3, !dbg !129
  %mul210.3.3.1 = fmul contract float %scores.sroa.0.12.vec.extract1361, 0x3FB99999A0000000, !dbg !130
  %242 = tail call contract noundef float @llvm.minnum.f32(float %mul210.3.3.1, float 0x4024CB5EC0000000), !dbg !131
  %243 = tail call contract noundef float @llvm.exp.f32(float %242), !dbg !134
  %resident.sroa.130.32.vec.extract1992 = extractelement <4 x float> %resident.sroa.130.13, i64 0, !dbg !151
  %add227.3706.1 = fadd contract float %resident.sroa.130.32.vec.extract1992, %237, !dbg !152
  %resident.sroa.130.32.vec.insert1994 = insertelement <4 x float> poison, float %add227.3706.1, i64 0, !dbg !137
  %244 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %237), !dbg !138
  %probs.sroa.0.0.vec.insert1458 = insertelement <4 x i16> poison, i16 %244, i64 0, !dbg !147
  %resident.sroa.130.36.vec.extract2045 = extractelement <4 x float> %resident.sroa.130.13, i64 1, !dbg !151
  %add227.1.3.1 = fadd contract float %resident.sroa.130.36.vec.extract2045, %239, !dbg !152
  %resident.sroa.130.36.vec.insert2047 = insertelement <4 x float> %resident.sroa.130.32.vec.insert1994, float %add227.1.3.1, i64 1, !dbg !137
  %245 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %239), !dbg !138
  %probs.sroa.0.2.vec.insert1504 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1458, i16 %245, i64 1, !dbg !147
  %resident.sroa.130.40.vec.extract2100 = extractelement <4 x float> %resident.sroa.130.13, i64 2, !dbg !151
  %add227.2.3.1 = fadd contract float %resident.sroa.130.40.vec.extract2100, %241, !dbg !152
  %resident.sroa.130.40.vec.insert2102 = insertelement <4 x float> %resident.sroa.130.36.vec.insert2047, float %add227.2.3.1, i64 2, !dbg !137
  %246 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %241), !dbg !138
  %probs.sroa.0.4.vec.insert1549 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1504, i16 %246, i64 2, !dbg !147
  %resident.sroa.130.44.vec.extract2155 = extractelement <4 x float> %resident.sroa.130.13, i64 3, !dbg !151
  %add227.3.3.1 = fadd contract float %resident.sroa.130.44.vec.extract2155, %243, !dbg !152
  %resident.sroa.130.44.vec.insert2157 = insertelement <4 x float> %resident.sroa.130.40.vec.insert2102, float %add227.3.3.1, i64 3, !dbg !137
  %247 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %243), !dbg !138
  %probs.sroa.0.6.vec.insert1571 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1549, i16 %247, i64 3, !dbg !147
  br label %if.end252.3.1, !dbg !148

if.end252.3.1:                                    ; preds = %if.end252.2.1, %if.end184.3.1
  %resident.sroa.130.14 = phi <4 x float> [ %resident.sroa.130.44.vec.insert2157, %if.end184.3.1 ], [ %resident.sroa.130.13, %if.end252.2.1 ], !dbg !70
  %probs.sroa.0.13 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1571, %if.end184.3.1 ], [ zeroinitializer, %if.end252.2.1 ], !dbg !70
  %add261.3.1 = or disjoint i32 %and259, 1792, !dbg !153
  %add.ptr263.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add261.3.1, !dbg !149
  store <4 x i16> %probs.sroa.0.13, ptr addrspace(3) %add.ptr263.3.1, align 8, !dbg !150
  br label %if.end267.1

if.end267.1:                                      ; preds = %if.end252.3.1, %if.end371
  %resident.sroa.130.15 = phi <4 x float> [ %resident.sroa.130.5, %if.end371 ], [ %resident.sroa.130.14, %if.end252.3.1 ], !dbg !154
  br i1 %cmp270.not, label %for.cond274.preheader.1, label %if.end371.1, !dbg !162

for.cond274.preheader.1:                          ; preds = %if.end267.1
  %or.cond667.1785 = icmp ugt i32 %mul11, 1023, !dbg !163
  %cmp287.not.1786 = icmp sgt i32 %mul11, %1
  %or.cond668.1787 = or i1 %or.cond667.1785, %cmp287.not.1786, !dbg !163
  br i1 %or.cond668.1787, label %if.end367.1814, label %for.cond327.preheader.1806, !dbg !163

for.cond327.preheader.1806:                       ; preds = %for.cond274.preheader.1
  %gep.1795 = getelementptr %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul318, !dbg !164
  %248 = load <4 x half>, ptr addrspace(3) %gep.1795, align 8, !dbg !165
  %249 = shl nsw i32 %cond.i.i630, 10
  %mul296.1788 = and i32 %249, 64512
  %add297.1789 = or disjoint i32 %mul296.1788, %mul114
  %250 = zext nneg i32 %add297.1789 to i64, !dbg !166
  %251 = or disjoint i64 %250, %35, !dbg !167
  %252 = or disjoint i64 %251, 512, !dbg !167
  %add.ptr305.1.1792 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %252, !dbg !168
  %kr.sroa.113.16.add.ptr305.1.1792.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1.1792, i64 8, !dbg !169
  %kr.sroa.113.16.copyload1705 = load <4 x half>, ptr addrspace(4) %kr.sroa.113.16.add.ptr305.1.1792.sroa_idx, align 8, !dbg !169
  %kr.sroa.71.16.copyload1691 = load <4 x half>, ptr addrspace(4) %add.ptr305.1.1792, align 16, !dbg !169
  %253 = or disjoint i64 %250, %35, !dbg !167
  %add.ptr305.1791 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %253, !dbg !168
  %kr.sroa.44.0.add.ptr305.1791.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1791, i64 8, !dbg !169
  %kr.sroa.44.0.copyload1625 = load <4 x half>, ptr addrspace(4) %kr.sroa.44.0.add.ptr305.1791.sroa_idx, align 8, !dbg !169
  %kr.sroa.0.0.copyload1611 = load <4 x half>, ptr addrspace(4) %add.ptr305.1791, align 16, !dbg !169
  %254 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0.copyload1611, <4 x half> %248, <4 x float> %resident.sroa.0.0), !dbg !170, !call_argsrelate !171
  %255 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.44.0.copyload1625, <4 x half> %248, <4 x float> %resident.sroa.66.0), !dbg !170, !call_argsrelate !171
  %256 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.71.16.copyload1691, <4 x half> %248, <4 x float> %resident.sroa.130.15), !dbg !170, !call_argsrelate !171
  %257 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.113.16.copyload1705, <4 x half> %248, <4 x float> zeroinitializer), !dbg !170, !call_argsrelate !171
  br label %if.end367.1814, !dbg !172

if.end367.1814:                                   ; preds = %for.cond327.preheader.1806, %for.cond274.preheader.1
  %resident.sroa.270.6 = phi <4 x float> [ zeroinitializer, %for.cond274.preheader.1 ], [ %257, %for.cond327.preheader.1806 ]
  %resident.sroa.130.16 = phi <4 x float> [ %resident.sroa.130.15, %for.cond274.preheader.1 ], [ %256, %for.cond327.preheader.1806 ], !dbg !70
  %resident.sroa.66.6 = phi <4 x float> [ %resident.sroa.66.0, %for.cond274.preheader.1 ], [ %255, %for.cond327.preheader.1806 ], !dbg !70
  %resident.sroa.0.6 = phi <4 x float> [ %resident.sroa.0.0, %for.cond274.preheader.1 ], [ %254, %for.cond327.preheader.1806 ], !dbg !70
  %or.cond667.1.1 = icmp ugt i32 %mul11.1, 1023, !dbg !163
  %cmp287.not.1.1 = icmp sgt i32 %mul11.1, %1
  %or.cond668.1.1 = or i1 %or.cond667.1.1, %cmp287.not.1.1, !dbg !163
  br i1 %or.cond668.1.1, label %if.end367.1.1, label %for.cond346.preheader.1.1, !dbg !163

for.cond346.preheader.1.1:                        ; preds = %if.end367.1814
  %add319.1.1 = or i32 %and259, 1280, !dbg !173
  %gep.1.1 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add319.1.1, !dbg !164
  %258 = load <4 x half>, ptr addrspace(3) %gep.1.1, align 8, !dbg !165
  %259 = shl nsw i32 %cond.i.i630.1, 10
  %mul296.1.1 = and i32 %259, 64512
  %add297.1.1 = or disjoint i32 %mul296.1.1, %mul114
  %260 = zext nneg i32 %add297.1.1 to i64, !dbg !166
  %261 = or disjoint i64 %260, %35, !dbg !167
  %262 = or disjoint i64 %261, 512, !dbg !167
  %add.ptr305.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %262, !dbg !168
  %kr.sroa.113.16.add.ptr305.1.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1.1.1, i64 8, !dbg !169
  %kr.sroa.113.16.copyload1706 = load <4 x half>, ptr addrspace(4) %kr.sroa.113.16.add.ptr305.1.1.1.sroa_idx, align 8, !dbg !169
  %kr.sroa.71.16.copyload1692 = load <4 x half>, ptr addrspace(4) %add.ptr305.1.1.1, align 16, !dbg !169
  %263 = or disjoint i64 %260, %35, !dbg !167
  %add.ptr305.1712.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %263, !dbg !168
  %kr.sroa.44.0.add.ptr305.1712.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1712.1, i64 8, !dbg !169
  %kr.sroa.44.0.copyload1626 = load <4 x half>, ptr addrspace(4) %kr.sroa.44.0.add.ptr305.1712.1.sroa_idx, align 8, !dbg !169
  %kr.sroa.0.0.copyload1612 = load <4 x half>, ptr addrspace(4) %add.ptr305.1712.1, align 16, !dbg !169
  %264 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0.copyload1612, <4 x half> %258, <4 x float> zeroinitializer), !dbg !174, !call_argsrelate !171
  %265 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.44.0.copyload1626, <4 x half> %258, <4 x float> zeroinitializer), !dbg !174, !call_argsrelate !171
  %266 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.71.16.copyload1692, <4 x half> %258, <4 x float> zeroinitializer), !dbg !174, !call_argsrelate !171
  %267 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.113.16.copyload1706, <4 x half> %258, <4 x float> zeroinitializer), !dbg !174, !call_argsrelate !171
  br label %if.end367.1.1, !dbg !172

if.end367.1.1:                                    ; preds = %for.cond346.preheader.1.1, %if.end367.1814
  %resident.sroa.402.7 = phi <4 x float> [ zeroinitializer, %if.end367.1814 ], [ %267, %for.cond346.preheader.1.1 ]
  %resident.sroa.370.7 = phi <4 x float> [ zeroinitializer, %if.end367.1814 ], [ %266, %for.cond346.preheader.1.1 ]
  %resident.sroa.338.7 = phi <4 x float> [ zeroinitializer, %if.end367.1814 ], [ %265, %for.cond346.preheader.1.1 ]
  %resident.sroa.306.7 = phi <4 x float> [ zeroinitializer, %if.end367.1814 ], [ %264, %for.cond346.preheader.1.1 ]
  %or.cond667.2.1 = icmp ugt i32 %mul11.2, 1023, !dbg !163
  %cmp287.not.2.1 = icmp sgt i32 %mul11.2, %1
  %or.cond668.2.1 = or i1 %or.cond667.2.1, %cmp287.not.2.1, !dbg !163
  br i1 %or.cond668.2.1, label %if.end367.2.1, label %for.cond327.preheader.2.1, !dbg !163

for.cond327.preheader.2.1:                        ; preds = %if.end367.1.1
  %add319.2.1 = or disjoint i32 %mul318, 1536, !dbg !173
  %gep.2.1 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add319.2.1, !dbg !164
  %268 = load <4 x half>, ptr addrspace(3) %gep.2.1, align 8, !dbg !165
  %269 = shl nsw i32 %cond.i.i630.2, 10
  %mul296.2.1 = and i32 %269, 64512
  %add297.2.1 = or disjoint i32 %mul296.2.1, %mul114
  %270 = zext nneg i32 %add297.2.1 to i64, !dbg !166
  %271 = or disjoint i64 %270, %35, !dbg !167
  %272 = or disjoint i64 %271, 512, !dbg !167
  %add.ptr305.1.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %272, !dbg !168
  %kr.sroa.113.16.add.ptr305.1.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1.2.1, i64 8, !dbg !169
  %kr.sroa.113.16.copyload1707 = load <4 x half>, ptr addrspace(4) %kr.sroa.113.16.add.ptr305.1.2.1.sroa_idx, align 8, !dbg !169
  %kr.sroa.71.16.copyload1693 = load <4 x half>, ptr addrspace(4) %add.ptr305.1.2.1, align 16, !dbg !169
  %273 = or disjoint i64 %270, %35, !dbg !167
  %add.ptr305.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %273, !dbg !168
  %kr.sroa.44.0.add.ptr305.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.2.1, i64 8, !dbg !169
  %kr.sroa.44.0.copyload1627 = load <4 x half>, ptr addrspace(4) %kr.sroa.44.0.add.ptr305.2.1.sroa_idx, align 8, !dbg !169
  %kr.sroa.0.0.copyload1613 = load <4 x half>, ptr addrspace(4) %add.ptr305.2.1, align 16, !dbg !169
  %274 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0.copyload1613, <4 x half> %268, <4 x float> %resident.sroa.0.6), !dbg !170, !call_argsrelate !171
  %275 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.44.0.copyload1627, <4 x half> %268, <4 x float> %resident.sroa.66.6), !dbg !170, !call_argsrelate !171
  %276 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.71.16.copyload1693, <4 x half> %268, <4 x float> %resident.sroa.130.16), !dbg !170, !call_argsrelate !171
  %277 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.113.16.copyload1707, <4 x half> %268, <4 x float> %resident.sroa.270.6), !dbg !170, !call_argsrelate !171
  br label %if.end367.2.1, !dbg !172

if.end367.2.1:                                    ; preds = %for.cond327.preheader.2.1, %if.end367.1.1
  %resident.sroa.270.8 = phi <4 x float> [ %resident.sroa.270.6, %if.end367.1.1 ], [ %277, %for.cond327.preheader.2.1 ]
  %resident.sroa.130.18 = phi <4 x float> [ %resident.sroa.130.16, %if.end367.1.1 ], [ %276, %for.cond327.preheader.2.1 ], !dbg !70
  %resident.sroa.66.8 = phi <4 x float> [ %resident.sroa.66.6, %if.end367.1.1 ], [ %275, %for.cond327.preheader.2.1 ], !dbg !70
  %resident.sroa.0.8 = phi <4 x float> [ %resident.sroa.0.6, %if.end367.1.1 ], [ %274, %for.cond327.preheader.2.1 ], !dbg !70
  %or.cond667.3.1 = icmp ugt i32 %mul11.3, 1023, !dbg !163
  %cmp287.not.3.1 = icmp sgt i32 %mul11.3, %1
  %or.cond668.3.1 = or i1 %or.cond667.3.1, %cmp287.not.3.1, !dbg !163
  br i1 %or.cond668.3.1, label %if.end371.1, label %for.cond346.preheader.3.1, !dbg !163

for.cond346.preheader.3.1:                        ; preds = %if.end367.2.1
  %add319.3.1 = or i32 %and259, 1792, !dbg !173
  %gep.3.1 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add319.3.1, !dbg !164
  %278 = load <4 x half>, ptr addrspace(3) %gep.3.1, align 8, !dbg !165
  %279 = shl nsw i32 %cond.i.i630.3, 10
  %mul296.3.1 = and i32 %279, 64512
  %add297.3.1 = or disjoint i32 %mul296.3.1, %mul114
  %280 = zext nneg i32 %add297.3.1 to i64, !dbg !166
  %281 = or disjoint i64 %280, %35, !dbg !167
  %282 = or disjoint i64 %281, 512, !dbg !167
  %add.ptr305.1.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %282, !dbg !168
  %kr.sroa.113.16.add.ptr305.1.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1.3.1, i64 8, !dbg !169
  %kr.sroa.113.16.copyload1708 = load <4 x half>, ptr addrspace(4) %kr.sroa.113.16.add.ptr305.1.3.1.sroa_idx, align 8, !dbg !169
  %kr.sroa.71.16.copyload1694 = load <4 x half>, ptr addrspace(4) %add.ptr305.1.3.1, align 16, !dbg !169
  %283 = or disjoint i64 %280, %35, !dbg !167
  %add.ptr305.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %283, !dbg !168
  %kr.sroa.44.0.add.ptr305.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.3.1, i64 8, !dbg !169
  %kr.sroa.44.0.copyload1628 = load <4 x half>, ptr addrspace(4) %kr.sroa.44.0.add.ptr305.3.1.sroa_idx, align 8, !dbg !169
  %kr.sroa.0.0.copyload1614 = load <4 x half>, ptr addrspace(4) %add.ptr305.3.1, align 16, !dbg !169
  %284 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0.copyload1614, <4 x half> %278, <4 x float> %resident.sroa.306.7), !dbg !174, !call_argsrelate !171
  %285 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.44.0.copyload1628, <4 x half> %278, <4 x float> %resident.sroa.338.7), !dbg !174, !call_argsrelate !171
  %286 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.71.16.copyload1694, <4 x half> %278, <4 x float> %resident.sroa.370.7), !dbg !174, !call_argsrelate !171
  %287 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.113.16.copyload1708, <4 x half> %278, <4 x float> %resident.sroa.402.7), !dbg !174, !call_argsrelate !171
  br label %if.end371.1, !dbg !172

if.end371.1:                                      ; preds = %if.end367.2.1, %for.cond346.preheader.3.1, %if.end267.1
  %resident.sroa.402.10 = phi <4 x float> [ zeroinitializer, %if.end267.1 ], [ %resident.sroa.402.7, %if.end367.2.1 ], [ %287, %for.cond346.preheader.3.1 ]
  %resident.sroa.370.10 = phi <4 x float> [ zeroinitializer, %if.end267.1 ], [ %resident.sroa.370.7, %if.end367.2.1 ], [ %286, %for.cond346.preheader.3.1 ]
  %resident.sroa.338.10 = phi <4 x float> [ zeroinitializer, %if.end267.1 ], [ %resident.sroa.338.7, %if.end367.2.1 ], [ %285, %for.cond346.preheader.3.1 ]
  %resident.sroa.306.10 = phi <4 x float> [ zeroinitializer, %if.end267.1 ], [ %resident.sroa.306.7, %if.end367.2.1 ], [ %284, %for.cond346.preheader.3.1 ]
  %resident.sroa.270.10 = phi <4 x float> [ zeroinitializer, %if.end267.1 ], [ %resident.sroa.270.8, %if.end367.2.1 ], [ %resident.sroa.270.8, %for.cond346.preheader.3.1 ]
  %resident.sroa.130.20 = phi <4 x float> [ %resident.sroa.130.15, %if.end267.1 ], [ %resident.sroa.130.18, %if.end367.2.1 ], [ %resident.sroa.130.18, %for.cond346.preheader.3.1 ], !dbg !154
  %resident.sroa.66.10 = phi <4 x float> [ %resident.sroa.66.0, %if.end267.1 ], [ %resident.sroa.66.8, %if.end367.2.1 ], [ %resident.sroa.66.8, %for.cond346.preheader.3.1 ], !dbg !69
  %resident.sroa.0.10 = phi <4 x float> [ %resident.sroa.0.0, %if.end267.1 ], [ %resident.sroa.0.8, %if.end367.2.1 ], [ %resident.sroa.0.8, %for.cond346.preheader.3.1 ], !dbg !69
  fence syncscope("block") release, !dbg !155
  tail call void @llvm.mxc.barrier(), !dbg !160
  fence syncscope("block") acquire, !dbg !161
  br label %if.end267.2, !dbg !72

if.end267.2:                                      ; preds = %if.end371.1
  br i1 %cmp270.not, label %for.cond274.preheader.2, label %if.end371.2, !dbg !162

for.cond274.preheader.2:                          ; preds = %if.end267.2
  %or.cond667.2884 = icmp ugt i32 %mul11.4, 1023, !dbg !163
  %cmp287.not.2885 = icmp sgt i32 %mul11.4, %1
  %or.cond668.2886 = or i1 %or.cond667.2884, %cmp287.not.2885, !dbg !163
  br i1 %or.cond668.2886, label %if.end367.2913, label %for.cond327.preheader.2905, !dbg !163

for.cond327.preheader.2905:                       ; preds = %for.cond274.preheader.2
  %add319.2893 = or disjoint i32 %mul318, 2048, !dbg !173
  %gep.2894 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add319.2893, !dbg !164
  %288 = load <4 x half>, ptr addrspace(3) %gep.2894, align 8, !dbg !165
  %289 = shl nsw i32 %cond.i.i630.4, 10
  %mul296.2887 = and i32 %289, 64512
  %add297.2888 = or disjoint i32 %mul296.2887, %mul114
  %290 = zext nneg i32 %add297.2888 to i64, !dbg !166
  %291 = or disjoint i64 %290, %35, !dbg !167
  %292 = or disjoint i64 %291, 512, !dbg !167
  %add.ptr305.1.2891 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %292, !dbg !168
  %kr.sroa.113.16.add.ptr305.1.2891.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1.2891, i64 8, !dbg !169
  %kr.sroa.113.16.copyload1710 = load <4 x half>, ptr addrspace(4) %kr.sroa.113.16.add.ptr305.1.2891.sroa_idx, align 8, !dbg !169
  %kr.sroa.71.16.copyload1696 = load <4 x half>, ptr addrspace(4) %add.ptr305.1.2891, align 16, !dbg !169
  %293 = or disjoint i64 %290, %35, !dbg !167
  %add.ptr305.2890 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %293, !dbg !168
  %kr.sroa.44.0.add.ptr305.2890.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.2890, i64 8, !dbg !169
  %kr.sroa.44.0.copyload1630 = load <4 x half>, ptr addrspace(4) %kr.sroa.44.0.add.ptr305.2890.sroa_idx, align 8, !dbg !169
  %kr.sroa.0.0.copyload1616 = load <4 x half>, ptr addrspace(4) %add.ptr305.2890, align 16, !dbg !169
  %294 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0.copyload1616, <4 x half> %288, <4 x float> %resident.sroa.0.10), !dbg !170, !call_argsrelate !171
  %295 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.44.0.copyload1630, <4 x half> %288, <4 x float> %resident.sroa.66.10), !dbg !170, !call_argsrelate !171
  %296 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.71.16.copyload1696, <4 x half> %288, <4 x float> %resident.sroa.130.20), !dbg !170, !call_argsrelate !171
  %297 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.113.16.copyload1710, <4 x half> %288, <4 x float> %resident.sroa.270.10), !dbg !170, !call_argsrelate !171
  br label %if.end367.2913, !dbg !172

if.end367.2913:                                   ; preds = %for.cond327.preheader.2905, %for.cond274.preheader.2
  %resident.sroa.270.11 = phi <4 x float> [ %resident.sroa.270.10, %for.cond274.preheader.2 ], [ %297, %for.cond327.preheader.2905 ]
  %resident.sroa.130.26 = phi <4 x float> [ %resident.sroa.130.20, %for.cond274.preheader.2 ], [ %296, %for.cond327.preheader.2905 ], !dbg !70
  %resident.sroa.66.11 = phi <4 x float> [ %resident.sroa.66.10, %for.cond274.preheader.2 ], [ %295, %for.cond327.preheader.2905 ], !dbg !70
  %resident.sroa.0.11 = phi <4 x float> [ %resident.sroa.0.10, %for.cond274.preheader.2 ], [ %294, %for.cond327.preheader.2905 ], !dbg !70
  %or.cond667.1.2 = icmp ugt i32 %mul11.5, 1023, !dbg !163
  %cmp287.not.1.2 = icmp sgt i32 %mul11.5, %1
  %or.cond668.1.2 = or i1 %or.cond667.1.2, %cmp287.not.1.2, !dbg !163
  br i1 %or.cond668.1.2, label %if.end367.1.2, label %for.cond346.preheader.1.2, !dbg !163

for.cond346.preheader.1.2:                        ; preds = %if.end367.2913
  %add319.1.2 = or i32 %and259, 2304, !dbg !173
  %gep.1.2 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add319.1.2, !dbg !164
  %298 = load <4 x half>, ptr addrspace(3) %gep.1.2, align 8, !dbg !165
  %299 = shl nsw i32 %cond.i.i630.5, 10
  %mul296.1.2 = and i32 %299, 64512
  %add297.1.2 = or disjoint i32 %mul296.1.2, %mul114
  %300 = zext nneg i32 %add297.1.2 to i64, !dbg !166
  %301 = or disjoint i64 %300, %35, !dbg !167
  %302 = or disjoint i64 %301, 512, !dbg !167
  %add.ptr305.1.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %302, !dbg !168
  %kr.sroa.113.16.add.ptr305.1.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1.1.2, i64 8, !dbg !169
  %kr.sroa.113.16.copyload1711 = load <4 x half>, ptr addrspace(4) %kr.sroa.113.16.add.ptr305.1.1.2.sroa_idx, align 8, !dbg !169
  %kr.sroa.71.16.copyload1697 = load <4 x half>, ptr addrspace(4) %add.ptr305.1.1.2, align 16, !dbg !169
  %303 = or disjoint i64 %300, %35, !dbg !167
  %add.ptr305.1712.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %303, !dbg !168
  %kr.sroa.44.0.add.ptr305.1712.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1712.2, i64 8, !dbg !169
  %kr.sroa.44.0.copyload1631 = load <4 x half>, ptr addrspace(4) %kr.sroa.44.0.add.ptr305.1712.2.sroa_idx, align 8, !dbg !169
  %kr.sroa.0.0.copyload1617 = load <4 x half>, ptr addrspace(4) %add.ptr305.1712.2, align 16, !dbg !169
  %304 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0.copyload1617, <4 x half> %298, <4 x float> %resident.sroa.306.10), !dbg !174, !call_argsrelate !171
  %305 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.44.0.copyload1631, <4 x half> %298, <4 x float> %resident.sroa.338.10), !dbg !174, !call_argsrelate !171
  %306 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.71.16.copyload1697, <4 x half> %298, <4 x float> %resident.sroa.370.10), !dbg !174, !call_argsrelate !171
  %307 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.113.16.copyload1711, <4 x half> %298, <4 x float> %resident.sroa.402.10), !dbg !174, !call_argsrelate !171
  br label %if.end367.1.2, !dbg !172

if.end367.1.2:                                    ; preds = %for.cond346.preheader.1.2, %if.end367.2913
  %resident.sroa.402.12 = phi <4 x float> [ %resident.sroa.402.10, %if.end367.2913 ], [ %307, %for.cond346.preheader.1.2 ]
  %resident.sroa.370.12 = phi <4 x float> [ %resident.sroa.370.10, %if.end367.2913 ], [ %306, %for.cond346.preheader.1.2 ]
  %resident.sroa.338.12 = phi <4 x float> [ %resident.sroa.338.10, %if.end367.2913 ], [ %305, %for.cond346.preheader.1.2 ]
  %resident.sroa.306.12 = phi <4 x float> [ %resident.sroa.306.10, %if.end367.2913 ], [ %304, %for.cond346.preheader.1.2 ]
  %or.cond667.2.2 = icmp ugt i32 %mul11.6, 1023, !dbg !163
  %cmp287.not.2.2 = icmp sgt i32 %mul11.6, %1
  %or.cond668.2.2 = or i1 %or.cond667.2.2, %cmp287.not.2.2, !dbg !163
  br i1 %or.cond668.2.2, label %if.end367.2.2, label %for.cond327.preheader.2.2, !dbg !163

for.cond327.preheader.2.2:                        ; preds = %if.end367.1.2
  %add319.2.2 = or disjoint i32 %mul318, 2560, !dbg !173
  %gep.2.2 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add319.2.2, !dbg !164
  %308 = load <4 x half>, ptr addrspace(3) %gep.2.2, align 8, !dbg !165
  %309 = shl nsw i32 %cond.i.i630.6, 10
  %mul296.2.2 = and i32 %309, 64512
  %add297.2.2 = or disjoint i32 %mul296.2.2, %mul114
  %310 = zext nneg i32 %add297.2.2 to i64, !dbg !166
  %311 = or disjoint i64 %310, %35, !dbg !167
  %312 = or disjoint i64 %311, 512, !dbg !167
  %add.ptr305.1.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %312, !dbg !168
  %kr.sroa.113.16.add.ptr305.1.2.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1.2.2, i64 8, !dbg !169
  %kr.sroa.113.16.copyload1712 = load <4 x half>, ptr addrspace(4) %kr.sroa.113.16.add.ptr305.1.2.2.sroa_idx, align 8, !dbg !169
  %kr.sroa.71.16.copyload1698 = load <4 x half>, ptr addrspace(4) %add.ptr305.1.2.2, align 16, !dbg !169
  %313 = or disjoint i64 %310, %35, !dbg !167
  %add.ptr305.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %313, !dbg !168
  %kr.sroa.44.0.add.ptr305.2.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.2.2, i64 8, !dbg !169
  %kr.sroa.44.0.copyload1632 = load <4 x half>, ptr addrspace(4) %kr.sroa.44.0.add.ptr305.2.2.sroa_idx, align 8, !dbg !169
  %kr.sroa.0.0.copyload1618 = load <4 x half>, ptr addrspace(4) %add.ptr305.2.2, align 16, !dbg !169
  %314 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0.copyload1618, <4 x half> %308, <4 x float> %resident.sroa.0.11), !dbg !170, !call_argsrelate !171
  %315 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.44.0.copyload1632, <4 x half> %308, <4 x float> %resident.sroa.66.11), !dbg !170, !call_argsrelate !171
  %316 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.71.16.copyload1698, <4 x half> %308, <4 x float> %resident.sroa.130.26), !dbg !170, !call_argsrelate !171
  %317 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.113.16.copyload1712, <4 x half> %308, <4 x float> %resident.sroa.270.11), !dbg !170, !call_argsrelate !171
  br label %if.end367.2.2, !dbg !172

if.end367.2.2:                                    ; preds = %for.cond327.preheader.2.2, %if.end367.1.2
  %resident.sroa.270.13 = phi <4 x float> [ %resident.sroa.270.11, %if.end367.1.2 ], [ %317, %for.cond327.preheader.2.2 ]
  %resident.sroa.130.28 = phi <4 x float> [ %resident.sroa.130.26, %if.end367.1.2 ], [ %316, %for.cond327.preheader.2.2 ], !dbg !70
  %resident.sroa.66.13 = phi <4 x float> [ %resident.sroa.66.11, %if.end367.1.2 ], [ %315, %for.cond327.preheader.2.2 ], !dbg !70
  %resident.sroa.0.13 = phi <4 x float> [ %resident.sroa.0.11, %if.end367.1.2 ], [ %314, %for.cond327.preheader.2.2 ], !dbg !70
  %or.cond667.3.2 = icmp ugt i32 %mul11.7, 1023, !dbg !163
  %cmp287.not.3.2 = icmp sgt i32 %mul11.7, %1
  %or.cond668.3.2 = or i1 %or.cond667.3.2, %cmp287.not.3.2, !dbg !163
  br i1 %or.cond668.3.2, label %if.end371.2, label %for.cond346.preheader.3.2, !dbg !163

for.cond346.preheader.3.2:                        ; preds = %if.end367.2.2
  %add319.3.2 = or i32 %and259, 2816, !dbg !173
  %gep.3.2 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add319.3.2, !dbg !164
  %318 = load <4 x half>, ptr addrspace(3) %gep.3.2, align 8, !dbg !165
  %319 = shl nsw i32 %cond.i.i630.7, 10
  %mul296.3.2 = and i32 %319, 64512
  %add297.3.2 = or disjoint i32 %mul296.3.2, %mul114
  %320 = zext nneg i32 %add297.3.2 to i64, !dbg !166
  %321 = or disjoint i64 %320, %35, !dbg !167
  %322 = or disjoint i64 %321, 512, !dbg !167
  %add.ptr305.1.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %322, !dbg !168
  %kr.sroa.113.16.add.ptr305.1.3.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1.3.2, i64 8, !dbg !169
  %kr.sroa.113.16.copyload1713 = load <4 x half>, ptr addrspace(4) %kr.sroa.113.16.add.ptr305.1.3.2.sroa_idx, align 8, !dbg !169
  %kr.sroa.71.16.copyload1699 = load <4 x half>, ptr addrspace(4) %add.ptr305.1.3.2, align 16, !dbg !169
  %323 = or disjoint i64 %320, %35, !dbg !167
  %add.ptr305.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %323, !dbg !168
  %kr.sroa.44.0.add.ptr305.3.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.3.2, i64 8, !dbg !169
  %kr.sroa.44.0.copyload1633 = load <4 x half>, ptr addrspace(4) %kr.sroa.44.0.add.ptr305.3.2.sroa_idx, align 8, !dbg !169
  %kr.sroa.0.0.copyload1619 = load <4 x half>, ptr addrspace(4) %add.ptr305.3.2, align 16, !dbg !169
  %324 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0.copyload1619, <4 x half> %318, <4 x float> %resident.sroa.306.12), !dbg !174, !call_argsrelate !171
  %325 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.44.0.copyload1633, <4 x half> %318, <4 x float> %resident.sroa.338.12), !dbg !174, !call_argsrelate !171
  %326 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.71.16.copyload1699, <4 x half> %318, <4 x float> %resident.sroa.370.12), !dbg !174, !call_argsrelate !171
  %327 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.113.16.copyload1713, <4 x half> %318, <4 x float> %resident.sroa.402.12), !dbg !174, !call_argsrelate !171
  br label %if.end371.2, !dbg !172

if.end371.2:                                      ; preds = %if.end367.2.2, %for.cond346.preheader.3.2, %if.end267.2
  %resident.sroa.402.15 = phi <4 x float> [ %resident.sroa.402.10, %if.end267.2 ], [ %resident.sroa.402.12, %if.end367.2.2 ], [ %327, %for.cond346.preheader.3.2 ]
  %resident.sroa.370.15 = phi <4 x float> [ %resident.sroa.370.10, %if.end267.2 ], [ %resident.sroa.370.12, %if.end367.2.2 ], [ %326, %for.cond346.preheader.3.2 ]
  %resident.sroa.338.15 = phi <4 x float> [ %resident.sroa.338.10, %if.end267.2 ], [ %resident.sroa.338.12, %if.end367.2.2 ], [ %325, %for.cond346.preheader.3.2 ]
  %resident.sroa.306.15 = phi <4 x float> [ %resident.sroa.306.10, %if.end267.2 ], [ %resident.sroa.306.12, %if.end367.2.2 ], [ %324, %for.cond346.preheader.3.2 ]
  %resident.sroa.270.15 = phi <4 x float> [ %resident.sroa.270.10, %if.end267.2 ], [ %resident.sroa.270.13, %if.end367.2.2 ], [ %resident.sroa.270.13, %for.cond346.preheader.3.2 ]
  %resident.sroa.130.30 = phi <4 x float> [ %resident.sroa.130.20, %if.end267.2 ], [ %resident.sroa.130.28, %if.end367.2.2 ], [ %resident.sroa.130.28, %for.cond346.preheader.3.2 ], !dbg !154
  %resident.sroa.66.15 = phi <4 x float> [ %resident.sroa.66.10, %if.end267.2 ], [ %resident.sroa.66.13, %if.end367.2.2 ], [ %resident.sroa.66.13, %for.cond346.preheader.3.2 ], !dbg !69
  %resident.sroa.0.15 = phi <4 x float> [ %resident.sroa.0.10, %if.end267.2 ], [ %resident.sroa.0.13, %if.end367.2.2 ], [ %resident.sroa.0.13, %for.cond346.preheader.3.2 ], !dbg !69
  fence syncscope("block") release, !dbg !155
  tail call void @llvm.mxc.barrier(), !dbg !160
  fence syncscope("block") acquire, !dbg !161
  br i1 %cmp15, label %for.body383.preheader, label %if.end415, !dbg !175

if.end415:                                        ; preds = %for.body383.preheader, %if.end371.2
  fence syncscope("block") release, !dbg !176
  tail call void @llvm.mxc.barrier(), !dbg !179
  fence syncscope("block") acquire, !dbg !180
  %cmp418 = icmp eq i32 %shr269.mask, 64, !dbg !181
  br i1 %cmp418, label %if.then419, label %if.end517, !dbg !182

if.then419:                                       ; preds = %if.end415
  %and421 = and i32 %18, 63, !dbg !183
  %arrayidx423 = getelementptr inbounds float, ptr addrspace(3) @buf_dyn_shmem, i32 %and421, !dbg !184
  %328 = load float, ptr addrspace(3) %arrayidx423, align 4, !dbg !184, !tbaa !111
  fence syncscope("warp") release, !dbg !185
  tail call void @llvm.mxc.barrier.warp(), !dbg !190
  fence syncscope("warp") acquire, !dbg !191
  %resident.sroa.0.0.vec.extract1824 = extractelement <4 x float> %resident.sroa.0.15, i64 0, !dbg !192
  %resident.sroa.306.64.vec.extract = extractelement <4 x float> %resident.sroa.306.15, i64 0, !dbg !193
  %add434 = fadd contract float %resident.sroa.0.0.vec.extract1824, %resident.sroa.306.64.vec.extract, !dbg !194
  %mul440 = fmul contract float %328, %add434, !dbg !195
  %329 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul440), !dbg !196
  %oreg.sroa.0.0.insert.ext = zext i16 %329 to i64, !dbg !200
  %resident.sroa.0.4.vec.extract = extractelement <4 x float> %resident.sroa.0.15, i64 1, !dbg !192
  %resident.sroa.306.68.vec.extract = extractelement <4 x float> %resident.sroa.306.15, i64 1, !dbg !193
  %add434.1 = fadd contract float %resident.sroa.0.4.vec.extract, %resident.sroa.306.68.vec.extract, !dbg !194
  %mul440.1 = fmul contract float %328, %add434.1, !dbg !195
  %330 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul440.1), !dbg !196
  %oreg.sroa.0.2.insert.ext = zext i16 %330 to i64, !dbg !200
  %oreg.sroa.0.2.insert.shift = shl nuw nsw i64 %oreg.sroa.0.2.insert.ext, 16, !dbg !200
  %oreg.sroa.0.2.insert.insert = or disjoint i64 %oreg.sroa.0.2.insert.shift, %oreg.sroa.0.0.insert.ext, !dbg !200
  %resident.sroa.0.8.vec.extract1858 = extractelement <4 x float> %resident.sroa.0.15, i64 2, !dbg !192
  %resident.sroa.306.72.vec.extract = extractelement <4 x float> %resident.sroa.306.15, i64 2, !dbg !193
  %add434.2 = fadd contract float %resident.sroa.0.8.vec.extract1858, %resident.sroa.306.72.vec.extract, !dbg !194
  %mul440.2 = fmul contract float %328, %add434.2, !dbg !195
  %331 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul440.2), !dbg !196
  %oreg.sroa.0.4.insert.ext = zext i16 %331 to i64, !dbg !200
  %oreg.sroa.0.4.insert.shift = shl nuw nsw i64 %oreg.sroa.0.4.insert.ext, 32, !dbg !200
  %oreg.sroa.0.4.insert.insert = or disjoint i64 %oreg.sroa.0.2.insert.insert, %oreg.sroa.0.4.insert.shift, !dbg !200
  %resident.sroa.0.12.vec.extract = extractelement <4 x float> %resident.sroa.0.15, i64 3, !dbg !192
  %resident.sroa.306.76.vec.extract = extractelement <4 x float> %resident.sroa.306.15, i64 3, !dbg !193
  %add434.3 = fadd contract float %resident.sroa.0.12.vec.extract, %resident.sroa.306.76.vec.extract, !dbg !194
  %mul440.3 = fmul contract float %328, %add434.3, !dbg !195
  %332 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul440.3), !dbg !196
  %oreg.sroa.0.6.insert.ext = zext i16 %332 to i64, !dbg !200
  %oreg.sroa.0.6.insert.shift = shl nuw i64 %oreg.sroa.0.6.insert.ext, 48, !dbg !200
  %oreg.sroa.0.6.insert.insert = or disjoint i64 %oreg.sroa.0.4.insert.insert, %oreg.sroa.0.6.insert.shift, !dbg !200
  %resident.sroa.66.16.vec.extract1904 = extractelement <4 x float> %resident.sroa.66.15, i64 0, !dbg !192
  %resident.sroa.338.80.vec.extract = extractelement <4 x float> %resident.sroa.338.15, i64 0, !dbg !193
  %add434.4 = fadd contract float %resident.sroa.66.16.vec.extract1904, %resident.sroa.338.80.vec.extract, !dbg !194
  %mul440.4 = fmul contract float %328, %add434.4, !dbg !195
  %333 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul440.4), !dbg !196
  %oreg.sroa.7.8.insert.ext = zext i16 %333 to i64, !dbg !200
  %resident.sroa.66.20.vec.extract = extractelement <4 x float> %resident.sroa.66.15, i64 1, !dbg !192
  %resident.sroa.338.84.vec.extract = extractelement <4 x float> %resident.sroa.338.15, i64 1, !dbg !193
  %add434.5 = fadd contract float %resident.sroa.66.20.vec.extract, %resident.sroa.338.84.vec.extract, !dbg !194
  %mul440.5 = fmul contract float %328, %add434.5, !dbg !195
  %334 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul440.5), !dbg !196
  %oreg.sroa.7.10.insert.ext = zext i16 %334 to i64, !dbg !200
  %oreg.sroa.7.10.insert.shift = shl nuw nsw i64 %oreg.sroa.7.10.insert.ext, 16, !dbg !200
  %oreg.sroa.7.10.insert.insert = or disjoint i64 %oreg.sroa.7.10.insert.shift, %oreg.sroa.7.8.insert.ext, !dbg !200
  %resident.sroa.66.24.vec.extract1938 = extractelement <4 x float> %resident.sroa.66.15, i64 2, !dbg !192
  %resident.sroa.338.88.vec.extract = extractelement <4 x float> %resident.sroa.338.15, i64 2, !dbg !193
  %add434.6 = fadd contract float %resident.sroa.66.24.vec.extract1938, %resident.sroa.338.88.vec.extract, !dbg !194
  %mul440.6 = fmul contract float %328, %add434.6, !dbg !195
  %335 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul440.6), !dbg !196
  %oreg.sroa.7.12.insert.ext = zext i16 %335 to i64, !dbg !200
  %oreg.sroa.7.12.insert.shift = shl nuw nsw i64 %oreg.sroa.7.12.insert.ext, 32, !dbg !200
  %oreg.sroa.7.12.insert.insert = or disjoint i64 %oreg.sroa.7.10.insert.insert, %oreg.sroa.7.12.insert.shift, !dbg !200
  %resident.sroa.66.28.vec.extract = extractelement <4 x float> %resident.sroa.66.15, i64 3, !dbg !192
  %resident.sroa.338.92.vec.extract = extractelement <4 x float> %resident.sroa.338.15, i64 3, !dbg !193
  %add434.7 = fadd contract float %resident.sroa.66.28.vec.extract, %resident.sroa.338.92.vec.extract, !dbg !194
  %mul440.7 = fmul contract float %328, %add434.7, !dbg !195
  %336 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul440.7), !dbg !196
  %oreg.sroa.7.14.insert.ext = zext i16 %336 to i64, !dbg !200
  %oreg.sroa.7.14.insert.shift = shl nuw i64 %oreg.sroa.7.14.insert.ext, 48, !dbg !200
  %oreg.sroa.7.14.insert.insert = or disjoint i64 %oreg.sroa.7.12.insert.insert, %oreg.sroa.7.14.insert.shift, !dbg !200
  %resident.sroa.130.32.vec.extract2012 = extractelement <4 x float> %resident.sroa.130.30, i64 0, !dbg !192
  %resident.sroa.370.96.vec.extract = extractelement <4 x float> %resident.sroa.370.15, i64 0, !dbg !193
  %add434.8 = fadd contract float %resident.sroa.130.32.vec.extract2012, %resident.sroa.370.96.vec.extract, !dbg !194
  %mul440.8 = fmul contract float %328, %add434.8, !dbg !195
  %337 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul440.8), !dbg !196
  %oreg.sroa.12.16.insert.ext = zext i16 %337 to i64, !dbg !200
  %resident.sroa.130.36.vec.extract2067 = extractelement <4 x float> %resident.sroa.130.30, i64 1, !dbg !192
  %resident.sroa.370.100.vec.extract = extractelement <4 x float> %resident.sroa.370.15, i64 1, !dbg !193
  %add434.9 = fadd contract float %resident.sroa.130.36.vec.extract2067, %resident.sroa.370.100.vec.extract, !dbg !194
  %mul440.9 = fmul contract float %328, %add434.9, !dbg !195
  %338 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul440.9), !dbg !196
  %oreg.sroa.12.18.insert.ext = zext i16 %338 to i64, !dbg !200
  %oreg.sroa.12.18.insert.shift = shl nuw nsw i64 %oreg.sroa.12.18.insert.ext, 16, !dbg !200
  %oreg.sroa.12.18.insert.insert = or disjoint i64 %oreg.sroa.12.18.insert.shift, %oreg.sroa.12.16.insert.ext, !dbg !200
  %resident.sroa.130.40.vec.extract2122 = extractelement <4 x float> %resident.sroa.130.30, i64 2, !dbg !192
  %resident.sroa.370.104.vec.extract = extractelement <4 x float> %resident.sroa.370.15, i64 2, !dbg !193
  %add434.10 = fadd contract float %resident.sroa.130.40.vec.extract2122, %resident.sroa.370.104.vec.extract, !dbg !194
  %mul440.10 = fmul contract float %328, %add434.10, !dbg !195
  %339 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul440.10), !dbg !196
  %oreg.sroa.12.20.insert.ext = zext i16 %339 to i64, !dbg !200
  %oreg.sroa.12.20.insert.shift = shl nuw nsw i64 %oreg.sroa.12.20.insert.ext, 32, !dbg !200
  %oreg.sroa.12.20.insert.insert = or disjoint i64 %oreg.sroa.12.18.insert.insert, %oreg.sroa.12.20.insert.shift, !dbg !200
  %resident.sroa.130.44.vec.extract2177 = extractelement <4 x float> %resident.sroa.130.30, i64 3, !dbg !192
  %resident.sroa.370.108.vec.extract = extractelement <4 x float> %resident.sroa.370.15, i64 3, !dbg !193
  %add434.11 = fadd contract float %resident.sroa.130.44.vec.extract2177, %resident.sroa.370.108.vec.extract, !dbg !194
  %mul440.11 = fmul contract float %328, %add434.11, !dbg !195
  %340 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul440.11), !dbg !196
  %oreg.sroa.12.22.insert.ext = zext i16 %340 to i64, !dbg !200
  %oreg.sroa.12.22.insert.shift = shl nuw i64 %oreg.sroa.12.22.insert.ext, 48, !dbg !200
  %oreg.sroa.12.22.insert.insert = or disjoint i64 %oreg.sroa.12.20.insert.insert, %oreg.sroa.12.22.insert.shift, !dbg !200
  %resident.sroa.270.48.vec.extract = extractelement <4 x float> %resident.sroa.270.15, i64 0, !dbg !192
  %resident.sroa.402.112.vec.extract = extractelement <4 x float> %resident.sroa.402.15, i64 0, !dbg !193
  %add434.12 = fadd contract float %resident.sroa.270.48.vec.extract, %resident.sroa.402.112.vec.extract, !dbg !194
  %mul440.12 = fmul contract float %328, %add434.12, !dbg !195
  %341 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul440.12), !dbg !196
  %oreg.sroa.17.24.insert.ext = zext i16 %341 to i64, !dbg !200
  %resident.sroa.270.52.vec.extract = extractelement <4 x float> %resident.sroa.270.15, i64 1, !dbg !192
  %resident.sroa.402.116.vec.extract = extractelement <4 x float> %resident.sroa.402.15, i64 1, !dbg !193
  %add434.13 = fadd contract float %resident.sroa.270.52.vec.extract, %resident.sroa.402.116.vec.extract, !dbg !194
  %mul440.13 = fmul contract float %328, %add434.13, !dbg !195
  %342 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul440.13), !dbg !196
  %oreg.sroa.17.26.insert.ext = zext i16 %342 to i64, !dbg !200
  %oreg.sroa.17.26.insert.shift = shl nuw nsw i64 %oreg.sroa.17.26.insert.ext, 16, !dbg !200
  %oreg.sroa.17.26.insert.insert = or disjoint i64 %oreg.sroa.17.26.insert.shift, %oreg.sroa.17.24.insert.ext, !dbg !200
  %resident.sroa.270.56.vec.extract = extractelement <4 x float> %resident.sroa.270.15, i64 2, !dbg !192
  %resident.sroa.402.120.vec.extract = extractelement <4 x float> %resident.sroa.402.15, i64 2, !dbg !193
  %add434.14 = fadd contract float %resident.sroa.270.56.vec.extract, %resident.sroa.402.120.vec.extract, !dbg !194
  %mul440.14 = fmul contract float %328, %add434.14, !dbg !195
  %343 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul440.14), !dbg !196
  %oreg.sroa.17.28.insert.ext = zext i16 %343 to i64, !dbg !200
  %oreg.sroa.17.28.insert.shift = shl nuw nsw i64 %oreg.sroa.17.28.insert.ext, 32, !dbg !200
  %oreg.sroa.17.28.insert.insert = or disjoint i64 %oreg.sroa.17.26.insert.insert, %oreg.sroa.17.28.insert.shift, !dbg !200
  %resident.sroa.270.60.vec.extract = extractelement <4 x float> %resident.sroa.270.15, i64 3, !dbg !192
  %resident.sroa.402.124.vec.extract = extractelement <4 x float> %resident.sroa.402.15, i64 3, !dbg !193
  %add434.15 = fadd contract float %resident.sroa.270.60.vec.extract, %resident.sroa.402.124.vec.extract, !dbg !194
  %mul440.15 = fmul contract float %328, %add434.15, !dbg !195
  %344 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul440.15), !dbg !196
  %oreg.sroa.17.30.insert.ext = zext i16 %344 to i64, !dbg !200
  %oreg.sroa.17.30.insert.shift = shl nuw i64 %oreg.sroa.17.30.insert.ext, 48, !dbg !200
  %oreg.sroa.17.30.insert.insert = or disjoint i64 %oreg.sroa.17.28.insert.insert, %oreg.sroa.17.30.insert.shift, !dbg !200
  %and460 = shl nuw nsw i32 %18, 6
  %mul461 = and i32 %and460, 960
  %and464 = lshr i32 %18, 5
  %shr465 = and i32 %and464, 1
  %and468 = and i32 %18, 7
  %mul474 = and i32 %33, 4
  %xor = xor i32 %shr465, %and468, !dbg !201
  %mul469 = shl nuw nsw i32 %xor, 3, !dbg !202
  %add470 = or disjoint i32 %mul469, %mul461, !dbg !203
  %add475 = or disjoint i32 %add470, %mul474, !dbg !204
  %add.ptr477 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add475, !dbg !205
  store i64 %oreg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr477, align 8, !dbg !206
  %xor.1 = xor i32 %and464, %and468, !dbg !201
  %mul469.1 = shl nuw nsw i32 %xor.1, 3, !dbg !202
  %add470.1 = or disjoint i32 %mul469.1, %mul461, !dbg !203
  %add475.1 = or disjoint i32 %add470.1, %mul474, !dbg !204
  %add.ptr477.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add475.1, !dbg !205
  store i64 %oreg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr477.1, align 8, !dbg !206
  %add466.2 = or disjoint i32 %shr465, 4, !dbg !207
  %xor.2 = xor i32 %add466.2, %and468, !dbg !201
  %mul469.2 = shl nuw nsw i32 %xor.2, 3, !dbg !202
  %add470.2 = or disjoint i32 %mul469.2, %mul461, !dbg !203
  %add475.2 = or disjoint i32 %add470.2, %mul474, !dbg !204
  %add.ptr477.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add475.2, !dbg !205
  store i64 %oreg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr477.2, align 8, !dbg !206
  %add466.3 = or i32 %and464, 6, !dbg !207
  %xor.3 = xor i32 %add466.3, %and468, !dbg !201
  %mul469.3 = shl nuw nsw i32 %xor.3, 3, !dbg !202
  %add470.3 = or disjoint i32 %mul469.3, %mul461, !dbg !203
  %add475.3 = or disjoint i32 %add470.3, %mul474, !dbg !204
  %add.ptr477.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add475.3, !dbg !205
  store i64 %oreg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr477.3, align 8, !dbg !206
  fence syncscope("warp") release, !dbg !208
  tail call void @llvm.mxc.barrier.warp(), !dbg !211
  fence syncscope("warp") acquire, !dbg !212
  %mul489 = and i32 %and121, 448
  %xor496 = xor i32 %and121, %18
  %mul497 = and i32 %xor496, 56
  %345 = or disjoint i32 %mul497, %mul489
  %mul502 = shl nsw i32 %0, 20
  %mul504 = shl nsw i32 %1, 10
  %add505 = add nuw nsw i32 %mul502, %mul504
  %346 = or disjoint i32 %add505, %mul302
  %347 = zext nneg i32 %346 to i64, !dbg !213
  %add.ptr500 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %345, !dbg !214
  %add.ptr513 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %347, !dbg !215
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr513, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr500, i64 16, i1 false), !dbg !216, !tbaa.struct !217, !call_argsrelate !218
  %348 = or disjoint i32 %345, 512, !dbg !219
  %add.ptr500.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %348, !dbg !214
  %349 = or disjoint i64 %347, 512, !dbg !220
  %add.ptr513.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %349, !dbg !215
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr513.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr500.1, i64 16, i1 false), !dbg !216, !tbaa.struct !217, !call_argsrelate !218
  br label %if.end517, !dbg !221

if.end517:                                        ; preds = %if.then419, %if.end415
  ret void, !dbg !221
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
declare void @llvm.mxc.barrier() #8

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

; Function Attrs: convergent nounwind willreturn
declare void @llvm.mxc.barrier.warp() #8

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
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="128" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
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
!1 = !DIFile(filename: "/tmp/tmpdvdavbew/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpdvdavbew/tvm_kernels.maca", directory: "")
!42 = !DILocation(line: 21, column: 3, scope: !40)
!43 = !DILocation(line: 22, column: 21, scope: !40)
!44 = !DILocation(line: 705, column: 10, scope: !45, inlinedAt: !47)
!45 = distinct !DISubprogram(name: "max", scope: !46, file: !46, line: 704, type: !7, scopeLine: 704, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!46 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!47 = distinct !DILocation(line: 23, column: 24, scope: !40)
!48 = !{i32 0, i32 -1}
!49 = !DILocation(line: 708, column: 10, scope: !50, inlinedAt: !51)
!50 = distinct !DISubprogram(name: "min", scope: !46, file: !46, line: 707, type: !7, scopeLine: 707, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!51 = distinct !DILocation(line: 23, column: 20, scope: !40)
!52 = !DILocation(line: 23, column: 48, scope: !40)
!53 = !DILocation(line: 22, column: 90, scope: !40)
!54 = !DILocation(line: 67, column: 3, scope: !55, inlinedAt: !57)
!55 = distinct !DISubprogram(name: "__fetch_builtin_x", scope: !56, file: !56, line: 67, type: !7, scopeLine: 67, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!56 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_builtin_vars.h", directory: "")
!57 = distinct !DILocation(line: 25, column: 14, scope: !40)
!58 = !{i32 0, i32 1024}
!59 = !DILocation(line: 25, column: 33, scope: !40)
!60 = !DILocation(line: 25, column: 7, scope: !40)
!61 = !DILocation(line: 27, column: 5, scope: !40)
!62 = !DILocation(line: 28, column: 161, scope: !40)
!63 = !DILocation(line: 28, column: 46, scope: !40)
!64 = !DILocation(line: 28, column: 32, scope: !40)
!65 = !DILocation(line: 34, column: 26, scope: !40)
!66 = !DILocation(line: 34, column: 58, scope: !40)
!67 = !DILocation(line: 34, column: 82, scope: !40)
!68 = !DILocation(line: 34, column: 48, scope: !40)
!69 = !DILocation(line: 35, column: 20, scope: !40)
!70 = !DILocation(line: 0, scope: !40)
!71 = !DILocation(line: 48, column: 3, scope: !40)
!72 = !DILocation(line: 49, column: 42, scope: !40)
!73 = !DILocation(line: 141, column: 26, scope: !40)
!74 = !DILocation(line: 141, column: 24, scope: !40)
!75 = !DILocation(line: 1018, column: 9, scope: !76, inlinedAt: !78)
!76 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !77, file: !77, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!77 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!78 = distinct !DILocation(line: 143, column: 24, scope: !40)
!79 = !DILocation(line: 171, column: 37, scope: !80, inlinedAt: !81)
!80 = distinct !DISubprogram(name: "__lane_id", scope: !77, file: !77, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!81 = distinct !DILocation(line: 990, column: 14, scope: !82, inlinedAt: !83)
!82 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !77, file: !77, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!83 = distinct !DILocation(line: 1019, column: 11, scope: !76, inlinedAt: !78)
!84 = !DILocation(line: 171, column: 10, scope: !80, inlinedAt: !81)
!85 = !DILocation(line: 991, column: 20, scope: !82, inlinedAt: !83)
!86 = !DILocation(line: 992, column: 36, scope: !82, inlinedAt: !83)
!87 = !DILocation(line: 992, column: 17, scope: !82, inlinedAt: !83)
!88 = !DILocation(line: 992, column: 11, scope: !82, inlinedAt: !83)
!89 = !DILocation(line: 993, column: 43, scope: !82, inlinedAt: !83)
!90 = !DILocation(line: 993, column: 10, scope: !82, inlinedAt: !83)
!91 = !DILocation(line: 1020, column: 14, scope: !76, inlinedAt: !78)
!92 = !DILocation(line: 143, column: 22, scope: !40)
!93 = !DILocation(line: 1018, column: 9, scope: !76, inlinedAt: !94)
!94 = distinct !DILocation(line: 144, column: 24, scope: !40)
!95 = !DILocation(line: 171, column: 37, scope: !80, inlinedAt: !96)
!96 = distinct !DILocation(line: 990, column: 14, scope: !82, inlinedAt: !97)
!97 = distinct !DILocation(line: 1019, column: 11, scope: !76, inlinedAt: !94)
!98 = !DILocation(line: 171, column: 10, scope: !80, inlinedAt: !96)
!99 = !DILocation(line: 991, column: 20, scope: !82, inlinedAt: !97)
!100 = !DILocation(line: 992, column: 36, scope: !82, inlinedAt: !97)
!101 = !DILocation(line: 992, column: 17, scope: !82, inlinedAt: !97)
!102 = !DILocation(line: 992, column: 11, scope: !82, inlinedAt: !97)
!103 = !DILocation(line: 993, column: 43, scope: !82, inlinedAt: !97)
!104 = !DILocation(line: 993, column: 10, scope: !82, inlinedAt: !97)
!105 = !DILocation(line: 1020, column: 14, scope: !76, inlinedAt: !94)
!106 = !DILocation(line: 144, column: 22, scope: !40)
!107 = !DILocation(line: 146, column: 34, scope: !40)
!108 = !DILocation(line: 146, column: 9, scope: !40)
!109 = !DILocation(line: 152, column: 5, scope: !40)
!110 = !DILocation(line: 152, column: 56, scope: !40)
!111 = !{!112, !112, i64 0}
!112 = !{!"float", !19, i64 0}
!113 = !DILocation(line: 153, column: 3, scope: !40)
!114 = !DILocation(line: 53, column: 25, scope: !40)
!115 = !DILocation(line: 55, column: 11, scope: !40)
!116 = !DILocation(line: 56, column: 139, scope: !40)
!117 = !DILocation(line: 56, column: 67, scope: !40)
!118 = !DILocation(line: 56, column: 53, scope: !40)
!119 = !DILocation(line: 51, column: 30, scope: !40)
!120 = !DILocation(line: 63, column: 27, scope: !40)
!121 = !DILocation(line: 64, column: 33, scope: !40)
!122 = !DILocation(line: 64, column: 15, scope: !40)
!123 = !DILocation(line: 68, column: 78, scope: !40)
!124 = !DILocation(line: 68, column: 19, scope: !40)
!125 = !DILocation(line: 73, column: 28, scope: !40)
!126 = !DILocation(line: 68, column: 70, scope: !40)
!127 = !DILocation(line: 83, column: 21, scope: !40)
!128 = !DILocation(line: 82, column: 37, scope: !40)
!129 = !DILocation(line: 89, column: 38, scope: !40)
!130 = !DILocation(line: 89, column: 51, scope: !40)
!131 = !DILocation(line: 354, column: 10, scope: !132, inlinedAt: !133)
!132 = distinct !DISubprogram(name: "min", scope: !46, file: !46, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!133 = distinct !DILocation(line: 89, column: 33, scope: !40)
!134 = !DILocation(line: 288, column: 10, scope: !135, inlinedAt: !136)
!135 = distinct !DISubprogram(name: "expf", scope: !46, file: !46, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!136 = distinct !DILocation(line: 89, column: 28, scope: !40)
!137 = !DILocation(line: 93, column: 34, scope: !40)
!138 = !DILocation(line: 75, column: 10, scope: !139, inlinedAt: !141)
!139 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !140, file: !140, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!140 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!141 = distinct !DILocation(line: 984, column: 9, scope: !142, inlinedAt: !144)
!142 = distinct !DISubprogram(name: "__float2half", scope: !143, file: !143, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!143 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!144 = distinct !DILocation(line: 133, column: 53, scope: !145, inlinedAt: !146)
!145 = distinct !DISubprogram(name: "__half", scope: !143, file: !143, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!146 = distinct !DILocation(line: 94, column: 28, scope: !40)
!147 = !DILocation(line: 94, column: 25, scope: !40)
!148 = !DILocation(line: 100, column: 69, scope: !40)
!149 = !DILocation(line: 100, column: 44, scope: !40)
!150 = !DILocation(line: 100, column: 113, scope: !40)
!151 = !DILocation(line: 93, column: 37, scope: !40)
!152 = !DILocation(line: 93, column: 58, scope: !40)
!153 = !DILocation(line: 100, column: 77, scope: !40)
!154 = !DILocation(line: 39, column: 26, scope: !40)
!155 = !DILocation(line: 60, column: 3, scope: !156, inlinedAt: !157)
!156 = distinct !DISubprogram(name: "__barrier", scope: !77, file: !77, line: 57, type: !7, scopeLine: 57, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!157 = distinct !DILocation(line: 74, column: 3, scope: !158, inlinedAt: !159)
!158 = distinct !DISubprogram(name: "__syncthreads", scope: !77, file: !77, line: 73, type: !7, scopeLine: 73, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!159 = distinct !DILocation(line: 135, column: 5, scope: !40)
!160 = !DILocation(line: 61, column: 3, scope: !156, inlinedAt: !157)
!161 = !DILocation(line: 62, column: 3, scope: !156, inlinedAt: !157)
!162 = !DILocation(line: 103, column: 42, scope: !40)
!163 = !DILocation(line: 107, column: 27, scope: !40)
!164 = !DILocation(line: 112, column: 69, scope: !40)
!165 = !DILocation(line: 112, column: 32, scope: !40)
!166 = !DILocation(line: 109, column: 11, scope: !40)
!167 = !DILocation(line: 110, column: 124, scope: !40)
!168 = !DILocation(line: 110, column: 52, scope: !40)
!169 = !DILocation(line: 110, column: 38, scope: !40)
!170 = !DILocation(line: 117, column: 41, scope: !40)
!171 = !{i32 4, i32 -1, i32 -1}
!172 = !DILocation(line: 105, column: 34, scope: !40)
!173 = !DILocation(line: 112, column: 103, scope: !40)
!174 = !DILocation(line: 126, column: 49, scope: !40)
!175 = !DILocation(line: 137, column: 7, scope: !40)
!176 = !DILocation(line: 60, column: 3, scope: !156, inlinedAt: !177)
!177 = distinct !DILocation(line: 74, column: 3, scope: !158, inlinedAt: !178)
!178 = distinct !DILocation(line: 154, column: 3, scope: !40)
!179 = !DILocation(line: 61, column: 3, scope: !156, inlinedAt: !177)
!180 = !DILocation(line: 62, column: 3, scope: !156, inlinedAt: !177)
!181 = !DILocation(line: 155, column: 33, scope: !40)
!182 = !DILocation(line: 155, column: 7, scope: !40)
!183 = !DILocation(line: 156, column: 58, scope: !40)
!184 = !DILocation(line: 156, column: 14, scope: !40)
!185 = !DILocation(line: 68, column: 3, scope: !186, inlinedAt: !187)
!186 = distinct !DISubprogram(name: "__barrier_warp", scope: !77, file: !77, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!187 = distinct !DILocation(line: 192, column: 3, scope: !188, inlinedAt: !189)
!188 = distinct !DISubprogram(name: "__syncwarp", scope: !77, file: !77, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!189 = distinct !DILocation(line: 157, column: 5, scope: !40)
!190 = !DILocation(line: 69, column: 3, scope: !186, inlinedAt: !187)
!191 = !DILocation(line: 70, column: 3, scope: !186, inlinedAt: !187)
!192 = !DILocation(line: 160, column: 25, scope: !40)
!193 = !DILocation(line: 160, column: 42, scope: !40)
!194 = !DILocation(line: 160, column: 40, scope: !40)
!195 = !DILocation(line: 161, column: 40, scope: !40)
!196 = !DILocation(line: 75, column: 10, scope: !139, inlinedAt: !197)
!197 = distinct !DILocation(line: 984, column: 9, scope: !142, inlinedAt: !198)
!198 = distinct !DILocation(line: 133, column: 53, scope: !145, inlinedAt: !199)
!199 = distinct !DILocation(line: 162, column: 21, scope: !40)
!200 = !DILocation(line: 162, column: 18, scope: !40)
!201 = !DILocation(line: 166, column: 129, scope: !40)
!202 = !DILocation(line: 166, column: 157, scope: !40)
!203 = !DILocation(line: 166, column: 79, scope: !40)
!204 = !DILocation(line: 166, column: 163, scope: !40)
!205 = !DILocation(line: 166, column: 42, scope: !40)
!206 = !DILocation(line: 166, column: 206, scope: !40)
!207 = !DILocation(line: 166, column: 93, scope: !40)
!208 = !DILocation(line: 68, column: 3, scope: !186, inlinedAt: !209)
!209 = distinct !DILocation(line: 192, column: 3, scope: !188, inlinedAt: !210)
!210 = distinct !DILocation(line: 168, column: 5, scope: !40)
!211 = !DILocation(line: 69, column: 3, scope: !186, inlinedAt: !209)
!212 = !DILocation(line: 70, column: 3, scope: !186, inlinedAt: !209)
!213 = !DILocation(line: 170, column: 5, scope: !40)
!214 = !DILocation(line: 171, column: 176, scope: !40)
!215 = !DILocation(line: 171, column: 24, scope: !40)
!216 = !DILocation(line: 171, column: 139, scope: !40)
!217 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!218 = !{i32 2, i32 -1, i32 -1, i32 -1}
!219 = !DILocation(line: 171, column: 234, scope: !40)
!220 = !DILocation(line: 171, column: 103, scope: !40)
!221 = !DILocation(line: 174, column: 1, scope: !40)
