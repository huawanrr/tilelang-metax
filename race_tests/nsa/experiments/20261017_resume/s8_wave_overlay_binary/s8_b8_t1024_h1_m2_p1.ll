; ModuleID = 'experiments/20261017_resume/s8_wave_overlay_binary/s8_b8_t1024_h1_m2_p1.bc'
source_filename = "/tmp/tmpka3lffuq/tvm_kernels.maca"
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
  %cond.i.i710 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64), !dbg !49
  %mul11 = shl nsw i32 %cond.i.i710, 4, !dbg !52
  %4 = or disjoint i64 %2, 1, !dbg !53
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4, !dbg !43
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !dbg !43, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i710.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64), !dbg !49
  %mul11.1 = shl nsw i32 %cond.i.i710.1, 4, !dbg !52
  %6 = or disjoint i64 %2, 2, !dbg !53
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6, !dbg !43
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !dbg !43, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i710.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64), !dbg !49
  %mul11.2 = shl nsw i32 %cond.i.i710.2, 4, !dbg !52
  %8 = or disjoint i64 %2, 3, !dbg !53
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8, !dbg !43
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !dbg !43, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i710.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64), !dbg !49
  %mul11.3 = shl nsw i32 %cond.i.i710.3, 4, !dbg !52
  %10 = or disjoint i64 %2, 4, !dbg !53
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10, !dbg !43
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !dbg !43, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i710.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64), !dbg !49
  %mul11.4 = shl nsw i32 %cond.i.i710.4, 4, !dbg !52
  %12 = or disjoint i64 %2, 5, !dbg !53
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12, !dbg !43
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !dbg !43, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i710.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64), !dbg !49
  %mul11.5 = shl nsw i32 %cond.i.i710.5, 4, !dbg !52
  %14 = or disjoint i64 %2, 6, !dbg !53
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14, !dbg !43
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !dbg !43, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i710.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64), !dbg !49
  %mul11.6 = shl nsw i32 %cond.i.i710.6, 4, !dbg !52
  %16 = or disjoint i64 %2, 7, !dbg !53
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16, !dbg !43
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !dbg !43, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i710.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64), !dbg !49
  %mul11.7 = shl nsw i32 %cond.i.i710.7, 4, !dbg !52
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
  %resident.sroa.0.12.vec.insert2131 = bitcast <4 x i32> %28 to <4 x float>, !dbg !69
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
  %resident.sroa.74.28.vec.insert2227 = bitcast <4 x i32> %32 to <4 x float>, !dbg !69
  br label %if.end

if.end:                                           ; preds = %entry, %for.cond16.preheader
  %resident.sroa.74.0 = phi <4 x float> [ %resident.sroa.74.28.vec.insert2227, %for.cond16.preheader ], [ zeroinitializer, %entry ], !dbg !70
  %resident.sroa.0.0 = phi <4 x float> [ %resident.sroa.0.12.vec.insert2131, %for.cond16.preheader ], [ zeroinitializer, %entry ], !dbg !70
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
  br i1 %cmp91, label %if.end419, label %for.cond94.preheader, !dbg !72

for.body431.preheader:                            ; preds = %if.end419.2
  %resident.sroa.146.32.vec.extract = extractelement <4 x float> %resident.sroa.146.30, i64 0, !dbg !73
  %add436 = fadd contract float %resident.sroa.146.32.vec.extract, 0.000000e+00, !dbg !74
  %resident.sroa.146.36.vec.extract2349 = extractelement <4 x float> %resident.sroa.146.30, i64 1, !dbg !73
  %add436.1 = fadd contract float %add436, %resident.sroa.146.36.vec.extract2349, !dbg !74
  %resident.sroa.146.40.vec.extract2408 = extractelement <4 x float> %resident.sroa.146.30, i64 2, !dbg !73
  %add436.2 = fadd contract float %add436.1, %resident.sroa.146.40.vec.extract2408, !dbg !74
  %resident.sroa.146.44.vec.extract2467 = extractelement <4 x float> %resident.sroa.146.30, i64 3, !dbg !73
  %add436.3 = fadd contract float %add436.2, %resident.sroa.146.44.vec.extract2467, !dbg !74
  %36 = bitcast float %add436.3 to i32, !dbg !75
  %37 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !79
  %38 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %37) #11, !dbg !84
  %xor.i.i = xor i32 %38, 32, !dbg !85
  %39 = and i32 %38, -64, !dbg !86
  %and.i.i = add nsw i32 %39, 64, !dbg !86
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !87
  %cond.i.i711 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %38, !dbg !88
  %shl.i.i = shl i32 %cond.i.i711, 2, !dbg !89
  %40 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %36), !dbg !90
  %41 = bitcast i32 %40 to float, !dbg !91
  %add444 = fadd contract float %add436.3, %41, !dbg !92
  %42 = bitcast float %add444 to i32, !dbg !93
  %43 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !95
  %44 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %43) #11, !dbg !98
  %xor.i.i712 = xor i32 %44, 16, !dbg !99
  %45 = and i32 %44, -64, !dbg !100
  %and.i.i713 = add nsw i32 %45, 64, !dbg !100
  %cmp.not.i.i714 = icmp slt i32 %xor.i.i712, %and.i.i713, !dbg !101
  %cond.i.i715 = select i1 %cmp.not.i.i714, i32 %xor.i.i712, i32 %44, !dbg !102
  %shl.i.i716 = shl i32 %cond.i.i715, 2, !dbg !103
  %46 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i716, i32 %42), !dbg !104
  %47 = bitcast i32 %46 to float, !dbg !105
  %add449 = fadd contract float %add444, %47, !dbg !106
  %cmp452 = fcmp contract ogt float %add449, 0.000000e+00, !dbg !107
  %div = fdiv contract float 1.000000e+00, %add449, !dbg !108
  %condval_1.0 = select i1 %cmp452, float %div, float 0.000000e+00, !dbg !108
  %arrayidx462 = getelementptr inbounds float, ptr addrspace(3) @buf_dyn_shmem, i32 %18, !dbg !109
  store float %condval_1.0, ptr addrspace(3) %arrayidx462, align 4, !dbg !110, !tbaa !111
  br label %if.end463, !dbg !113

for.cond94.preheader:                             ; preds = %if.end
  %or.cond747 = icmp ugt i32 %mul11, 1023, !dbg !114
  %cmp107.not = icmp sgt i32 %mul11, %1
  %or.cond748 = or i1 %or.cond747, %cmp107.not, !dbg !114
  br i1 %or.cond748, label %if.end135, label %for.cond109.preheader, !dbg !114

for.cond109.preheader:                            ; preds = %for.cond94.preheader
  %48 = shl nsw i32 %cond.i.i710, 10
  %mul116 = and i32 %48, 64512
  %add117 = or disjoint i32 %mul116, %mul114
  %49 = zext nneg i32 %add117 to i64, !dbg !115
  %50 = or disjoint i64 %49, %34, !dbg !116
  %add.ptr125 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %50, !dbg !117
  %kr.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr125, align 16, !dbg !118
  %kr.sroa.68.0.add.ptr125.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125, i64 8, !dbg !118
  %kr.sroa.68.0.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.68.0.add.ptr125.sroa_idx, align 8, !dbg !118
  %51 = or disjoint i64 %49, %34, !dbg !116
  %52 = or disjoint i64 %51, 512, !dbg !116
  %add.ptr125.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %52, !dbg !117
  %kr.sroa.119.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr125.1, align 16, !dbg !118
  %kr.sroa.185.16.add.ptr125.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1, i64 8, !dbg !118
  %kr.sroa.185.16.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.185.16.add.ptr125.1.sroa_idx, align 8, !dbg !118
  br label %if.end135, !dbg !119

if.end135:                                        ; preds = %for.cond109.preheader, %for.cond94.preheader
  %kr.sroa.185.0 = phi <4 x half> [ undef, %for.cond94.preheader ], [ %kr.sroa.185.16.copyload, %for.cond109.preheader ]
  %kr.sroa.119.0 = phi <4 x half> [ undef, %for.cond94.preheader ], [ %kr.sroa.119.16.copyload, %for.cond109.preheader ]
  %kr.sroa.68.0 = phi <4 x half> [ undef, %for.cond94.preheader ], [ %kr.sroa.68.0.copyload, %for.cond109.preheader ]
  %kr.sroa.0.0 = phi <4 x half> [ undef, %for.cond94.preheader ], [ %kr.sroa.0.0.copyload, %for.cond109.preheader ]
  %or.cond747.1 = icmp ugt i32 %mul11.1, 1023, !dbg !114
  %cmp107.not.1 = icmp sgt i32 %mul11.1, %1
  %or.cond748.1 = or i1 %or.cond747.1, %cmp107.not.1, !dbg !114
  br i1 %or.cond748.1, label %if.end135.1, label %for.cond109.preheader.1, !dbg !114

for.cond109.preheader.1:                          ; preds = %if.end135
  %53 = shl nsw i32 %cond.i.i710.1, 10
  %mul116.1 = and i32 %53, 64512
  %add117.1 = or disjoint i32 %mul116.1, %mul114
  %54 = zext nneg i32 %add117.1 to i64, !dbg !115
  %55 = or disjoint i64 %54, %34, !dbg !116
  %add.ptr125.1769 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %55, !dbg !117
  %kr.sroa.236.32.copyload = load <4 x half>, ptr addrspace(4) %add.ptr125.1769, align 16, !dbg !118
  %kr.sroa.242.32.add.ptr125.1769.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1769, i64 8, !dbg !118
  %kr.sroa.242.32.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.242.32.add.ptr125.1769.sroa_idx, align 8, !dbg !118
  %56 = or disjoint i64 %54, %34, !dbg !116
  %57 = or disjoint i64 %56, 512, !dbg !116
  %add.ptr125.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %57, !dbg !117
  %kr.sroa.245.48.copyload = load <4 x half>, ptr addrspace(4) %add.ptr125.1.1, align 16, !dbg !118
  %kr.sroa.251.48.add.ptr125.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1.1, i64 8, !dbg !118
  %kr.sroa.251.48.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.251.48.add.ptr125.1.1.sroa_idx, align 8, !dbg !118
  br label %if.end135.1, !dbg !119

if.end135.1:                                      ; preds = %for.cond109.preheader.1, %if.end135
  %kr.sroa.251.0 = phi <4 x half> [ undef, %if.end135 ], [ %kr.sroa.251.48.copyload, %for.cond109.preheader.1 ]
  %kr.sroa.245.0 = phi <4 x half> [ undef, %if.end135 ], [ %kr.sroa.245.48.copyload, %for.cond109.preheader.1 ]
  %kr.sroa.242.0 = phi <4 x half> [ undef, %if.end135 ], [ %kr.sroa.242.32.copyload, %for.cond109.preheader.1 ]
  %kr.sroa.236.0 = phi <4 x half> [ undef, %if.end135 ], [ %kr.sroa.236.32.copyload, %for.cond109.preheader.1 ]
  %or.cond747.2 = icmp ugt i32 %mul11.2, 1023, !dbg !114
  %cmp107.not.2 = icmp sgt i32 %mul11.2, %1
  %or.cond748.2 = or i1 %or.cond747.2, %cmp107.not.2, !dbg !114
  br i1 %or.cond748.2, label %if.end135.2, label %for.cond109.preheader.2, !dbg !114

for.cond109.preheader.2:                          ; preds = %if.end135.1
  %58 = shl nsw i32 %cond.i.i710.2, 10
  %mul116.2 = and i32 %58, 64512
  %add117.2 = or disjoint i32 %mul116.2, %mul114
  %59 = zext nneg i32 %add117.2 to i64, !dbg !115
  %60 = or disjoint i64 %59, %34, !dbg !116
  %add.ptr125.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %60, !dbg !117
  %kr.sroa.254.64.copyload = load <4 x half>, ptr addrspace(4) %add.ptr125.2, align 16, !dbg !118
  %kr.sroa.260.64.add.ptr125.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.2, i64 8, !dbg !118
  %kr.sroa.260.64.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.260.64.add.ptr125.2.sroa_idx, align 8, !dbg !118
  %61 = or disjoint i64 %59, %34, !dbg !116
  %62 = or disjoint i64 %61, 512, !dbg !116
  %add.ptr125.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %62, !dbg !117
  %kr.sroa.263.80.copyload = load <4 x half>, ptr addrspace(4) %add.ptr125.1.2, align 16, !dbg !118
  %kr.sroa.269.80.add.ptr125.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1.2, i64 8, !dbg !118
  %kr.sroa.269.80.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.269.80.add.ptr125.1.2.sroa_idx, align 8, !dbg !118
  br label %if.end135.2, !dbg !119

if.end135.2:                                      ; preds = %for.cond109.preheader.2, %if.end135.1
  %kr.sroa.269.0 = phi <4 x half> [ undef, %if.end135.1 ], [ %kr.sroa.269.80.copyload, %for.cond109.preheader.2 ]
  %kr.sroa.263.0 = phi <4 x half> [ undef, %if.end135.1 ], [ %kr.sroa.263.80.copyload, %for.cond109.preheader.2 ]
  %kr.sroa.260.0 = phi <4 x half> [ undef, %if.end135.1 ], [ %kr.sroa.260.64.copyload, %for.cond109.preheader.2 ]
  %kr.sroa.254.0 = phi <4 x half> [ undef, %if.end135.1 ], [ %kr.sroa.254.64.copyload, %for.cond109.preheader.2 ]
  %or.cond747.3 = icmp ugt i32 %mul11.3, 1023, !dbg !114
  %cmp107.not.3 = icmp sgt i32 %mul11.3, %1
  %or.cond748.3 = or i1 %or.cond747.3, %cmp107.not.3, !dbg !114
  br i1 %or.cond748.3, label %if.end135.3, label %for.cond109.preheader.3, !dbg !114

for.cond109.preheader.3:                          ; preds = %if.end135.2
  %63 = shl nsw i32 %cond.i.i710.3, 10
  %mul116.3 = and i32 %63, 64512
  %add117.3 = or disjoint i32 %mul116.3, %mul114
  %64 = zext nneg i32 %add117.3 to i64, !dbg !115
  %65 = or disjoint i64 %64, %34, !dbg !116
  %add.ptr125.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %65, !dbg !117
  %kr.sroa.272.96.copyload = load <4 x half>, ptr addrspace(4) %add.ptr125.3, align 16, !dbg !118
  %kr.sroa.278.96.add.ptr125.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.3, i64 8, !dbg !118
  %kr.sroa.278.96.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.278.96.add.ptr125.3.sroa_idx, align 8, !dbg !118
  %66 = or disjoint i64 %64, %34, !dbg !116
  %67 = or disjoint i64 %66, 512, !dbg !116
  %add.ptr125.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %67, !dbg !117
  %kr.sroa.281.112.copyload = load <4 x half>, ptr addrspace(4) %add.ptr125.1.3, align 16, !dbg !118
  %kr.sroa.287.112.add.ptr125.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1.3, i64 8, !dbg !118
  %kr.sroa.287.112.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.287.112.add.ptr125.1.3.sroa_idx, align 8, !dbg !118
  br label %if.end135.3, !dbg !119

if.end135.3:                                      ; preds = %for.cond109.preheader.3, %if.end135.2
  %kr.sroa.287.0 = phi <4 x half> [ undef, %if.end135.2 ], [ %kr.sroa.287.112.copyload, %for.cond109.preheader.3 ]
  %kr.sroa.281.0 = phi <4 x half> [ undef, %if.end135.2 ], [ %kr.sroa.281.112.copyload, %for.cond109.preheader.3 ]
  %kr.sroa.278.0 = phi <4 x half> [ undef, %if.end135.2 ], [ %kr.sroa.278.96.copyload, %for.cond109.preheader.3 ]
  %kr.sroa.272.0 = phi <4 x half> [ undef, %if.end135.2 ], [ %kr.sroa.272.96.copyload, %for.cond109.preheader.3 ]
  br i1 %or.cond748, label %if.end252, label %if.then153, !dbg !120

if.then153:                                       ; preds = %if.end135.3
  %cmp156 = icmp sgt i32 %mul11, %invariant.op, !dbg !121
  br i1 %cmp156, label %for.cond158.preheader, label %if.end184, !dbg !122

for.cond158.preheader:                            ; preds = %if.then153
  %add166 = or disjoint i32 %mul11, %mul165
  %cmp169.not = icmp sgt i32 %add166, %1, !dbg !123
  %spec.select = select i1 %cmp169.not, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.0.vec.insert1059 = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !125
  %cmp169.not.1.not = icmp slt i32 %add166, %1, !dbg !123
  %spec.select.1 = select i1 %cmp169.not.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !124
  %scores.sroa.0.4.vec.insert1198 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1059, float %spec.select.1, i64 1, !dbg !125
  %add167.2 = or disjoint i32 %add166, 2, !dbg !126
  %cmp169.not.2 = icmp sgt i32 %add167.2, %1, !dbg !123
  %spec.select.2 = select i1 %cmp169.not.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.8.vec.insert1315 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1198, float %spec.select.2, i64 2, !dbg !125
  %add167.3 = or disjoint i32 %add166, 3, !dbg !126
  %cmp169.not.3 = icmp sgt i32 %add167.3, %1, !dbg !123
  %spec.select.3 = select i1 %cmp169.not.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.12.vec.insert1432 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1315, float %spec.select.3, i64 3, !dbg !125
  br label %if.end184

if.end184:                                        ; preds = %if.then153, %for.cond158.preheader
  %scores.sroa.0.0 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1432, %for.cond158.preheader ], [ zeroinitializer, %if.then153 ], !dbg !70
  %resident.sroa.0.0.vec.extract = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %68 = bitcast <2 x float> %resident.sroa.0.0.vec.extract to <4 x half>, !dbg !127
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0, <4 x half> %68, <4 x float> %scores.sroa.0.0), !dbg !128
  %resident.sroa.0.8.vec.extract = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %70 = bitcast <2 x float> %resident.sroa.0.8.vec.extract to <4 x half>, !dbg !127
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.68.0, <4 x half> %70, <4 x float> %69), !dbg !128
  %resident.sroa.74.16.vec.extract = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %72 = bitcast <2 x float> %resident.sroa.74.16.vec.extract to <4 x half>, !dbg !127
  %73 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.119.0, <4 x half> %72, <4 x float> %71), !dbg !128
  %resident.sroa.74.24.vec.extract = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %74 = bitcast <2 x float> %resident.sroa.74.24.vec.extract to <4 x half>, !dbg !127
  %75 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.185.0, <4 x half> %74, <4 x float> %73), !dbg !128
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
  %resident.sroa.146.32.vec.insert = insertelement <4 x float> poison, float %77, i64 0, !dbg !137
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %77), !dbg !138
  %probs.sroa.0.0.vec.insert = insertelement <4 x i16> poison, i16 %84, i64 0, !dbg !147
  %resident.sroa.146.36.vec.insert2303 = insertelement <4 x float> %resident.sroa.146.32.vec.insert, float %79, i64 1, !dbg !137
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %79), !dbg !138
  %probs.sroa.0.2.vec.insert = insertelement <4 x i16> %probs.sroa.0.0.vec.insert, i16 %85, i64 1, !dbg !147
  %resident.sroa.146.40.vec.insert2362 = insertelement <4 x float> %resident.sroa.146.36.vec.insert2303, float %81, i64 2, !dbg !137
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %81), !dbg !138
  %probs.sroa.0.4.vec.insert = insertelement <4 x i16> %probs.sroa.0.2.vec.insert, i16 %86, i64 2, !dbg !147
  %resident.sroa.146.44.vec.insert2421 = insertelement <4 x float> %resident.sroa.146.40.vec.insert2362, float %83, i64 3, !dbg !137
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %83), !dbg !138
  %probs.sroa.0.6.vec.insert = insertelement <4 x i16> %probs.sroa.0.4.vec.insert, i16 %87, i64 3, !dbg !147
  br label %if.end252, !dbg !148

if.end252:                                        ; preds = %if.end135.3, %if.end184
  %resident.sroa.146.1 = phi <4 x float> [ %resident.sroa.146.44.vec.insert2421, %if.end184 ], [ zeroinitializer, %if.end135.3 ], !dbg !70
  %probs.sroa.0.0 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert, %if.end184 ], [ zeroinitializer, %if.end135.3 ], !dbg !70
  %add.ptr263 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and259, !dbg !149
  store <4 x i16> %probs.sroa.0.0, ptr addrspace(3) %add.ptr263, align 8, !dbg !150
  br i1 %or.cond748.1, label %if.end252.1, label %if.then153.1, !dbg !120

if.then153.1:                                     ; preds = %if.end252
  %cmp156.1 = icmp sgt i32 %mul11.1, %invariant.op, !dbg !121
  br i1 %cmp156.1, label %for.cond158.preheader.1, label %if.end184.1, !dbg !122

for.cond158.preheader.1:                          ; preds = %if.then153.1
  %add166.1 = or disjoint i32 %mul11.1, %mul165
  %cmp169.not.1772 = icmp sgt i32 %add166.1, %1, !dbg !123
  %spec.select.1773 = select i1 %cmp169.not.1772, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.0.vec.insert1068 = insertelement <4 x float> poison, float %spec.select.1773, i64 0, !dbg !125
  %cmp169.not.1.1.not = icmp slt i32 %add166.1, %1, !dbg !123
  %spec.select.1.1 = select i1 %cmp169.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !124
  %scores.sroa.0.4.vec.insert1205 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1068, float %spec.select.1.1, i64 1, !dbg !125
  %add167.2.1 = or disjoint i32 %add166.1, 2, !dbg !126
  %cmp169.not.2.1 = icmp sgt i32 %add167.2.1, %1, !dbg !123
  %spec.select.2.1 = select i1 %cmp169.not.2.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.8.vec.insert1322 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1205, float %spec.select.2.1, i64 2, !dbg !125
  %add167.3.1 = or disjoint i32 %add166.1, 3, !dbg !126
  %cmp169.not.3.1 = icmp sgt i32 %add167.3.1, %1, !dbg !123
  %spec.select.3.1 = select i1 %cmp169.not.3.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.12.vec.insert1439 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1322, float %spec.select.3.1, i64 3, !dbg !125
  br label %if.end184.1

if.end184.1:                                      ; preds = %if.then153.1, %for.cond158.preheader.1
  %scores.sroa.0.2 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1439, %for.cond158.preheader.1 ], [ zeroinitializer, %if.then153.1 ], !dbg !70
  %resident.sroa.0.0.vec.extract2049 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %88 = bitcast <2 x float> %resident.sroa.0.0.vec.extract2049 to <4 x half>, !dbg !127
  %89 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.236.0, <4 x half> %88, <4 x float> %scores.sroa.0.2), !dbg !128
  %resident.sroa.0.8.vec.extract2091 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %90 = bitcast <2 x float> %resident.sroa.0.8.vec.extract2091 to <4 x half>, !dbg !127
  %91 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.242.0, <4 x half> %90, <4 x float> %89), !dbg !128
  %resident.sroa.74.16.vec.extract2145 = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %92 = bitcast <2 x float> %resident.sroa.74.16.vec.extract2145 to <4 x half>, !dbg !127
  %93 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.245.0, <4 x half> %92, <4 x float> %91), !dbg !128
  %resident.sroa.74.24.vec.extract2187 = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %94 = bitcast <2 x float> %resident.sroa.74.24.vec.extract2187 to <4 x half>, !dbg !127
  %95 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.251.0, <4 x half> %94, <4 x float> %93), !dbg !128
  %scores.sroa.0.0.vec.extract1070 = extractelement <4 x float> %95, i64 0, !dbg !129
  %mul210.1776 = fmul contract float %scores.sroa.0.0.vec.extract1070, 0x3FB99999A0000000, !dbg !130
  %96 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1776, float 0x4024CB5EC0000000), !dbg !131
  %97 = tail call contract noundef float @llvm.exp.f32(float %96), !dbg !134
  %scores.sroa.0.4.vec.extract1207 = extractelement <4 x float> %95, i64 1, !dbg !129
  %mul210.1.1 = fmul contract float %scores.sroa.0.4.vec.extract1207, 0x3FB99999A0000000, !dbg !130
  %98 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1.1, float 0x4024CB5EC0000000), !dbg !131
  %99 = tail call contract noundef float @llvm.exp.f32(float %98), !dbg !134
  %scores.sroa.0.8.vec.extract1324 = extractelement <4 x float> %95, i64 2, !dbg !129
  %mul210.2.1 = fmul contract float %scores.sroa.0.8.vec.extract1324, 0x3FB99999A0000000, !dbg !130
  %100 = tail call contract noundef float @llvm.minnum.f32(float %mul210.2.1, float 0x4024CB5EC0000000), !dbg !131
  %101 = tail call contract noundef float @llvm.exp.f32(float %100), !dbg !134
  %scores.sroa.0.12.vec.extract1441 = extractelement <4 x float> %95, i64 3, !dbg !129
  %mul210.3.1 = fmul contract float %scores.sroa.0.12.vec.extract1441, 0x3FB99999A0000000, !dbg !130
  %102 = tail call contract noundef float @llvm.minnum.f32(float %mul210.3.1, float 0x4024CB5EC0000000), !dbg !131
  %103 = tail call contract noundef float @llvm.exp.f32(float %102), !dbg !134
  %resident.sroa.146.32.vec.extract2248 = extractelement <4 x float> %resident.sroa.146.1, i64 0, !dbg !151
  %add227.1778 = fadd contract float %resident.sroa.146.32.vec.extract2248, %97, !dbg !152
  %resident.sroa.146.32.vec.insert2250 = insertelement <4 x float> poison, float %add227.1778, i64 0, !dbg !137
  %104 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %97), !dbg !138
  %probs.sroa.0.0.vec.insert1598 = insertelement <4 x i16> poison, i16 %104, i64 0, !dbg !147
  %resident.sroa.146.36.vec.extract2305 = extractelement <4 x float> %resident.sroa.146.1, i64 1, !dbg !151
  %add227.1.1 = fadd contract float %resident.sroa.146.36.vec.extract2305, %99, !dbg !152
  %resident.sroa.146.36.vec.insert2307 = insertelement <4 x float> %resident.sroa.146.32.vec.insert2250, float %add227.1.1, i64 1, !dbg !137
  %105 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %99), !dbg !138
  %probs.sroa.0.2.vec.insert1644 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1598, i16 %105, i64 1, !dbg !147
  %resident.sroa.146.40.vec.extract2364 = extractelement <4 x float> %resident.sroa.146.1, i64 2, !dbg !151
  %add227.2.1 = fadd contract float %resident.sroa.146.40.vec.extract2364, %101, !dbg !152
  %resident.sroa.146.40.vec.insert2366 = insertelement <4 x float> %resident.sroa.146.36.vec.insert2307, float %add227.2.1, i64 2, !dbg !137
  %106 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %101), !dbg !138
  %probs.sroa.0.4.vec.insert1689 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1644, i16 %106, i64 2, !dbg !147
  %resident.sroa.146.44.vec.extract2423 = extractelement <4 x float> %resident.sroa.146.1, i64 3, !dbg !151
  %add227.3.1 = fadd contract float %resident.sroa.146.44.vec.extract2423, %103, !dbg !152
  %resident.sroa.146.44.vec.insert2425 = insertelement <4 x float> %resident.sroa.146.40.vec.insert2366, float %add227.3.1, i64 3, !dbg !137
  %107 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %103), !dbg !138
  %probs.sroa.0.6.vec.insert1711 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1689, i16 %107, i64 3, !dbg !147
  br label %if.end252.1, !dbg !148

if.end252.1:                                      ; preds = %if.end252, %if.end184.1
  %resident.sroa.146.2 = phi <4 x float> [ %resident.sroa.146.44.vec.insert2425, %if.end184.1 ], [ %resident.sroa.146.1, %if.end252 ], !dbg !70
  %probs.sroa.0.1 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1711, %if.end184.1 ], [ zeroinitializer, %if.end252 ], !dbg !70
  %add261.1 = or disjoint i32 %and259, 256, !dbg !153
  %add.ptr263.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add261.1, !dbg !149
  store <4 x i16> %probs.sroa.0.1, ptr addrspace(3) %add.ptr263.1, align 8, !dbg !150
  br i1 %or.cond748.2, label %if.end252.2, label %if.then153.2, !dbg !120

if.then153.2:                                     ; preds = %if.end252.1
  %cmp156.2 = icmp sgt i32 %mul11.2, %invariant.op, !dbg !121
  br i1 %cmp156.2, label %for.cond158.preheader.2, label %if.end184.2, !dbg !122

for.cond158.preheader.2:                          ; preds = %if.then153.2
  %add166.2 = or disjoint i32 %mul11.2, %mul165
  %cmp169.not.2779 = icmp sgt i32 %add166.2, %1, !dbg !123
  %spec.select.2780 = select i1 %cmp169.not.2779, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.0.vec.insert1078 = insertelement <4 x float> poison, float %spec.select.2780, i64 0, !dbg !125
  %cmp169.not.1.2.not = icmp slt i32 %add166.2, %1, !dbg !123
  %spec.select.1.2 = select i1 %cmp169.not.1.2.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !124
  %scores.sroa.0.4.vec.insert1213 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1078, float %spec.select.1.2, i64 1, !dbg !125
  %add167.2.2 = or disjoint i32 %add166.2, 2, !dbg !126
  %cmp169.not.2.2 = icmp sgt i32 %add167.2.2, %1, !dbg !123
  %spec.select.2.2 = select i1 %cmp169.not.2.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.8.vec.insert1330 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1213, float %spec.select.2.2, i64 2, !dbg !125
  %add167.3.2 = or disjoint i32 %add166.2, 3, !dbg !126
  %cmp169.not.3.2 = icmp sgt i32 %add167.3.2, %1, !dbg !123
  %spec.select.3.2 = select i1 %cmp169.not.3.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.12.vec.insert1447 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1330, float %spec.select.3.2, i64 3, !dbg !125
  br label %if.end184.2

if.end184.2:                                      ; preds = %if.then153.2, %for.cond158.preheader.2
  %scores.sroa.0.4 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1447, %for.cond158.preheader.2 ], [ zeroinitializer, %if.then153.2 ], !dbg !70
  %resident.sroa.0.0.vec.extract2051 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %108 = bitcast <2 x float> %resident.sroa.0.0.vec.extract2051 to <4 x half>, !dbg !127
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.254.0, <4 x half> %108, <4 x float> %scores.sroa.0.4), !dbg !128
  %resident.sroa.0.8.vec.extract2093 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %110 = bitcast <2 x float> %resident.sroa.0.8.vec.extract2093 to <4 x half>, !dbg !127
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.260.0, <4 x half> %110, <4 x float> %109), !dbg !128
  %resident.sroa.74.16.vec.extract2147 = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %112 = bitcast <2 x float> %resident.sroa.74.16.vec.extract2147 to <4 x half>, !dbg !127
  %113 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.263.0, <4 x half> %112, <4 x float> %111), !dbg !128
  %resident.sroa.74.24.vec.extract2189 = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %114 = bitcast <2 x float> %resident.sroa.74.24.vec.extract2189 to <4 x half>, !dbg !127
  %115 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.269.0, <4 x half> %114, <4 x float> %113), !dbg !128
  %scores.sroa.0.0.vec.extract1080 = extractelement <4 x float> %115, i64 0, !dbg !129
  %mul210.2783 = fmul contract float %scores.sroa.0.0.vec.extract1080, 0x3FB99999A0000000, !dbg !130
  %116 = tail call contract noundef float @llvm.minnum.f32(float %mul210.2783, float 0x4024CB5EC0000000), !dbg !131
  %117 = tail call contract noundef float @llvm.exp.f32(float %116), !dbg !134
  %scores.sroa.0.4.vec.extract1215 = extractelement <4 x float> %115, i64 1, !dbg !129
  %mul210.1.2 = fmul contract float %scores.sroa.0.4.vec.extract1215, 0x3FB99999A0000000, !dbg !130
  %118 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1.2, float 0x4024CB5EC0000000), !dbg !131
  %119 = tail call contract noundef float @llvm.exp.f32(float %118), !dbg !134
  %scores.sroa.0.8.vec.extract1332 = extractelement <4 x float> %115, i64 2, !dbg !129
  %mul210.2.2 = fmul contract float %scores.sroa.0.8.vec.extract1332, 0x3FB99999A0000000, !dbg !130
  %120 = tail call contract noundef float @llvm.minnum.f32(float %mul210.2.2, float 0x4024CB5EC0000000), !dbg !131
  %121 = tail call contract noundef float @llvm.exp.f32(float %120), !dbg !134
  %scores.sroa.0.12.vec.extract1449 = extractelement <4 x float> %115, i64 3, !dbg !129
  %mul210.3.2 = fmul contract float %scores.sroa.0.12.vec.extract1449, 0x3FB99999A0000000, !dbg !130
  %122 = tail call contract noundef float @llvm.minnum.f32(float %mul210.3.2, float 0x4024CB5EC0000000), !dbg !131
  %123 = tail call contract noundef float @llvm.exp.f32(float %122), !dbg !134
  %resident.sroa.146.32.vec.extract2252 = extractelement <4 x float> %resident.sroa.146.2, i64 0, !dbg !151
  %add227.2785 = fadd contract float %resident.sroa.146.32.vec.extract2252, %117, !dbg !152
  %resident.sroa.146.32.vec.insert2254 = insertelement <4 x float> poison, float %add227.2785, i64 0, !dbg !137
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %117), !dbg !138
  %probs.sroa.0.0.vec.insert1600 = insertelement <4 x i16> poison, i16 %124, i64 0, !dbg !147
  %resident.sroa.146.36.vec.extract2309 = extractelement <4 x float> %resident.sroa.146.2, i64 1, !dbg !151
  %add227.1.2 = fadd contract float %resident.sroa.146.36.vec.extract2309, %119, !dbg !152
  %resident.sroa.146.36.vec.insert2311 = insertelement <4 x float> %resident.sroa.146.32.vec.insert2254, float %add227.1.2, i64 1, !dbg !137
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %119), !dbg !138
  %probs.sroa.0.2.vec.insert1646 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1600, i16 %125, i64 1, !dbg !147
  %resident.sroa.146.40.vec.extract2368 = extractelement <4 x float> %resident.sroa.146.2, i64 2, !dbg !151
  %add227.2.2 = fadd contract float %resident.sroa.146.40.vec.extract2368, %121, !dbg !152
  %resident.sroa.146.40.vec.insert2370 = insertelement <4 x float> %resident.sroa.146.36.vec.insert2311, float %add227.2.2, i64 2, !dbg !137
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %121), !dbg !138
  %probs.sroa.0.4.vec.insert1691 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1646, i16 %126, i64 2, !dbg !147
  %resident.sroa.146.44.vec.extract2427 = extractelement <4 x float> %resident.sroa.146.2, i64 3, !dbg !151
  %add227.3.2 = fadd contract float %resident.sroa.146.44.vec.extract2427, %123, !dbg !152
  %resident.sroa.146.44.vec.insert2429 = insertelement <4 x float> %resident.sroa.146.40.vec.insert2370, float %add227.3.2, i64 3, !dbg !137
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %123), !dbg !138
  %probs.sroa.0.6.vec.insert1713 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1691, i16 %127, i64 3, !dbg !147
  br label %if.end252.2, !dbg !148

if.end252.2:                                      ; preds = %if.end252.1, %if.end184.2
  %resident.sroa.146.3 = phi <4 x float> [ %resident.sroa.146.44.vec.insert2429, %if.end184.2 ], [ %resident.sroa.146.2, %if.end252.1 ], !dbg !70
  %probs.sroa.0.2 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1713, %if.end184.2 ], [ zeroinitializer, %if.end252.1 ], !dbg !70
  %add261.2 = or disjoint i32 %and259, 512, !dbg !153
  %add.ptr263.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add261.2, !dbg !149
  store <4 x i16> %probs.sroa.0.2, ptr addrspace(3) %add.ptr263.2, align 8, !dbg !150
  br i1 %or.cond748.3, label %if.end252.3, label %if.then153.3, !dbg !120

if.then153.3:                                     ; preds = %if.end252.2
  %cmp156.3 = icmp sgt i32 %mul11.3, %invariant.op, !dbg !121
  br i1 %cmp156.3, label %for.cond158.preheader.3, label %if.end184.3, !dbg !122

for.cond158.preheader.3:                          ; preds = %if.then153.3
  %add166.3 = or disjoint i32 %mul11.3, %mul165
  %cmp169.not.3786 = icmp sgt i32 %add166.3, %1, !dbg !123
  %spec.select.3787 = select i1 %cmp169.not.3786, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.0.vec.insert1088 = insertelement <4 x float> poison, float %spec.select.3787, i64 0, !dbg !125
  %cmp169.not.1.3.not = icmp slt i32 %add166.3, %1, !dbg !123
  %spec.select.1.3 = select i1 %cmp169.not.1.3.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !124
  %scores.sroa.0.4.vec.insert1221 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1088, float %spec.select.1.3, i64 1, !dbg !125
  %add167.2.3 = or disjoint i32 %add166.3, 2, !dbg !126
  %cmp169.not.2.3 = icmp sgt i32 %add167.2.3, %1, !dbg !123
  %spec.select.2.3 = select i1 %cmp169.not.2.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.8.vec.insert1338 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1221, float %spec.select.2.3, i64 2, !dbg !125
  %add167.3.3 = or disjoint i32 %add166.3, 3, !dbg !126
  %cmp169.not.3.3 = icmp sgt i32 %add167.3.3, %1, !dbg !123
  %spec.select.3.3 = select i1 %cmp169.not.3.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.12.vec.insert1455 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1338, float %spec.select.3.3, i64 3, !dbg !125
  br label %if.end184.3

if.end184.3:                                      ; preds = %if.then153.3, %for.cond158.preheader.3
  %scores.sroa.0.6 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1455, %for.cond158.preheader.3 ], [ zeroinitializer, %if.then153.3 ], !dbg !70
  %resident.sroa.0.0.vec.extract2053 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %128 = bitcast <2 x float> %resident.sroa.0.0.vec.extract2053 to <4 x half>, !dbg !127
  %129 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.272.0, <4 x half> %128, <4 x float> %scores.sroa.0.6), !dbg !128
  %resident.sroa.0.8.vec.extract2095 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %130 = bitcast <2 x float> %resident.sroa.0.8.vec.extract2095 to <4 x half>, !dbg !127
  %131 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.278.0, <4 x half> %130, <4 x float> %129), !dbg !128
  %resident.sroa.74.16.vec.extract2149 = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %132 = bitcast <2 x float> %resident.sroa.74.16.vec.extract2149 to <4 x half>, !dbg !127
  %133 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.281.0, <4 x half> %132, <4 x float> %131), !dbg !128
  %resident.sroa.74.24.vec.extract2191 = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %134 = bitcast <2 x float> %resident.sroa.74.24.vec.extract2191 to <4 x half>, !dbg !127
  %135 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.287.0, <4 x half> %134, <4 x float> %133), !dbg !128
  %scores.sroa.0.0.vec.extract1090 = extractelement <4 x float> %135, i64 0, !dbg !129
  %mul210.3790 = fmul contract float %scores.sroa.0.0.vec.extract1090, 0x3FB99999A0000000, !dbg !130
  %136 = tail call contract noundef float @llvm.minnum.f32(float %mul210.3790, float 0x4024CB5EC0000000), !dbg !131
  %137 = tail call contract noundef float @llvm.exp.f32(float %136), !dbg !134
  %scores.sroa.0.4.vec.extract1223 = extractelement <4 x float> %135, i64 1, !dbg !129
  %mul210.1.3 = fmul contract float %scores.sroa.0.4.vec.extract1223, 0x3FB99999A0000000, !dbg !130
  %138 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1.3, float 0x4024CB5EC0000000), !dbg !131
  %139 = tail call contract noundef float @llvm.exp.f32(float %138), !dbg !134
  %scores.sroa.0.8.vec.extract1340 = extractelement <4 x float> %135, i64 2, !dbg !129
  %mul210.2.3 = fmul contract float %scores.sroa.0.8.vec.extract1340, 0x3FB99999A0000000, !dbg !130
  %140 = tail call contract noundef float @llvm.minnum.f32(float %mul210.2.3, float 0x4024CB5EC0000000), !dbg !131
  %141 = tail call contract noundef float @llvm.exp.f32(float %140), !dbg !134
  %scores.sroa.0.12.vec.extract1457 = extractelement <4 x float> %135, i64 3, !dbg !129
  %mul210.3.3 = fmul contract float %scores.sroa.0.12.vec.extract1457, 0x3FB99999A0000000, !dbg !130
  %142 = tail call contract noundef float @llvm.minnum.f32(float %mul210.3.3, float 0x4024CB5EC0000000), !dbg !131
  %143 = tail call contract noundef float @llvm.exp.f32(float %142), !dbg !134
  %resident.sroa.146.32.vec.extract2256 = extractelement <4 x float> %resident.sroa.146.3, i64 0, !dbg !151
  %add227.3792 = fadd contract float %resident.sroa.146.32.vec.extract2256, %137, !dbg !152
  %resident.sroa.146.32.vec.insert2258 = insertelement <4 x float> poison, float %add227.3792, i64 0, !dbg !137
  %144 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %137), !dbg !138
  %probs.sroa.0.0.vec.insert1602 = insertelement <4 x i16> poison, i16 %144, i64 0, !dbg !147
  %resident.sroa.146.36.vec.extract2313 = extractelement <4 x float> %resident.sroa.146.3, i64 1, !dbg !151
  %add227.1.3 = fadd contract float %resident.sroa.146.36.vec.extract2313, %139, !dbg !152
  %resident.sroa.146.36.vec.insert2315 = insertelement <4 x float> %resident.sroa.146.32.vec.insert2258, float %add227.1.3, i64 1, !dbg !137
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %139), !dbg !138
  %probs.sroa.0.2.vec.insert1648 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1602, i16 %145, i64 1, !dbg !147
  %resident.sroa.146.40.vec.extract2372 = extractelement <4 x float> %resident.sroa.146.3, i64 2, !dbg !151
  %add227.2.3 = fadd contract float %resident.sroa.146.40.vec.extract2372, %141, !dbg !152
  %resident.sroa.146.40.vec.insert2374 = insertelement <4 x float> %resident.sroa.146.36.vec.insert2315, float %add227.2.3, i64 2, !dbg !137
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %141), !dbg !138
  %probs.sroa.0.4.vec.insert1693 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1648, i16 %146, i64 2, !dbg !147
  %resident.sroa.146.44.vec.extract2431 = extractelement <4 x float> %resident.sroa.146.3, i64 3, !dbg !151
  %add227.3.3 = fadd contract float %resident.sroa.146.44.vec.extract2431, %143, !dbg !152
  %resident.sroa.146.44.vec.insert2433 = insertelement <4 x float> %resident.sroa.146.40.vec.insert2374, float %add227.3.3, i64 3, !dbg !137
  %147 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %143), !dbg !138
  %probs.sroa.0.6.vec.insert1715 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1693, i16 %147, i64 3, !dbg !147
  br label %if.end252.3, !dbg !148

if.end252.3:                                      ; preds = %if.end252.2, %if.end184.3
  %resident.sroa.146.4 = phi <4 x float> [ %resident.sroa.146.44.vec.insert2433, %if.end184.3 ], [ %resident.sroa.146.3, %if.end252.2 ], !dbg !70
  %probs.sroa.0.3 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1715, %if.end184.3 ], [ zeroinitializer, %if.end252.2 ], !dbg !70
  %add261.3 = or disjoint i32 %and259, 768, !dbg !153
  %add.ptr263.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add261.3, !dbg !149
  store <4 x i16> %probs.sroa.0.3, ptr addrspace(3) %add.ptr263.3, align 8, !dbg !150
  br label %if.end419

if.end419:                                        ; preds = %if.end, %if.end252.3
  %resident.sroa.146.5 = phi <4 x float> [ zeroinitializer, %if.end ], [ %resident.sroa.146.4, %if.end252.3 ], !dbg !154
  %kr.sroa.287.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.287.0, %if.end252.3 ]
  %kr.sroa.281.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.281.0, %if.end252.3 ]
  %kr.sroa.278.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.278.0, %if.end252.3 ]
  %kr.sroa.272.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.272.0, %if.end252.3 ]
  %kr.sroa.269.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.269.0, %if.end252.3 ]
  %kr.sroa.263.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.263.0, %if.end252.3 ]
  %kr.sroa.260.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.260.0, %if.end252.3 ]
  %kr.sroa.254.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.254.0, %if.end252.3 ]
  %kr.sroa.251.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.251.0, %if.end252.3 ]
  %kr.sroa.245.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.245.0, %if.end252.3 ]
  %kr.sroa.242.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.242.0, %if.end252.3 ]
  %kr.sroa.236.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.236.0, %if.end252.3 ]
  %kr.sroa.185.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.185.0, %if.end252.3 ]
  %kr.sroa.119.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.119.0, %if.end252.3 ]
  %kr.sroa.68.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.68.0, %if.end252.3 ]
  %kr.sroa.0.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.0.0, %if.end252.3 ]
  fence syncscope("block") release, !dbg !155
  tail call void @llvm.mxc.barrier(), !dbg !160
  fence syncscope("block") acquire, !dbg !161
  br i1 %cmp91, label %if.end267.1, label %for.cond94.preheader.1, !dbg !72

for.cond94.preheader.1:                           ; preds = %if.end419
  %or.cond747.1809 = icmp ugt i32 %mul11.4, 1023, !dbg !114
  %cmp107.not.1810 = icmp sgt i32 %mul11.4, %1
  %or.cond748.1811 = or i1 %or.cond747.1809, %cmp107.not.1810, !dbg !114
  br i1 %or.cond748.1811, label %if.end135.1818, label %for.cond109.preheader.1814, !dbg !114

for.cond109.preheader.1814:                       ; preds = %for.cond94.preheader.1
  %148 = shl nsw i32 %cond.i.i710.4, 10
  %mul116.1812 = and i32 %148, 64512
  %add117.1813 = or disjoint i32 %mul116.1812, %mul114
  %149 = zext nneg i32 %add117.1813 to i64, !dbg !115
  %150 = or disjoint i64 %149, %34, !dbg !116
  %add.ptr125.1815 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %150, !dbg !117
  %kr.sroa.0.0.copyload1786 = load <4 x half>, ptr addrspace(4) %add.ptr125.1815, align 16, !dbg !118
  %kr.sroa.68.0.add.ptr125.1815.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1815, i64 8, !dbg !118
  %kr.sroa.68.0.copyload1800 = load <4 x half>, ptr addrspace(4) %kr.sroa.68.0.add.ptr125.1815.sroa_idx, align 8, !dbg !118
  %151 = or disjoint i64 %149, %34, !dbg !116
  %152 = or disjoint i64 %151, 512, !dbg !116
  %add.ptr125.1.1816 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %152, !dbg !117
  %kr.sroa.119.16.copyload1914 = load <4 x half>, ptr addrspace(4) %add.ptr125.1.1816, align 16, !dbg !118
  %kr.sroa.185.16.add.ptr125.1.1816.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1.1816, i64 8, !dbg !118
  %kr.sroa.185.16.copyload1928 = load <4 x half>, ptr addrspace(4) %kr.sroa.185.16.add.ptr125.1.1816.sroa_idx, align 8, !dbg !118
  br label %if.end135.1818, !dbg !119

if.end135.1818:                                   ; preds = %for.cond109.preheader.1814, %for.cond94.preheader.1
  %kr.sroa.185.7 = phi <4 x half> [ %kr.sroa.185.1, %for.cond94.preheader.1 ], [ %kr.sroa.185.16.copyload1928, %for.cond109.preheader.1814 ]
  %kr.sroa.119.7 = phi <4 x half> [ %kr.sroa.119.1, %for.cond94.preheader.1 ], [ %kr.sroa.119.16.copyload1914, %for.cond109.preheader.1814 ]
  %kr.sroa.68.7 = phi <4 x half> [ %kr.sroa.68.1, %for.cond94.preheader.1 ], [ %kr.sroa.68.0.copyload1800, %for.cond109.preheader.1814 ]
  %kr.sroa.0.7 = phi <4 x half> [ %kr.sroa.0.1, %for.cond94.preheader.1 ], [ %kr.sroa.0.0.copyload1786, %for.cond109.preheader.1814 ]
  %or.cond747.1.1 = icmp ugt i32 %mul11.5, 1023, !dbg !114
  %cmp107.not.1.1 = icmp sgt i32 %mul11.5, %1
  %or.cond748.1.1 = or i1 %or.cond747.1.1, %cmp107.not.1.1, !dbg !114
  br i1 %or.cond748.1.1, label %if.end135.1.1, label %for.cond109.preheader.1.1, !dbg !114

for.cond109.preheader.1.1:                        ; preds = %if.end135.1818
  %153 = shl nsw i32 %cond.i.i710.5, 10
  %mul116.1.1 = and i32 %153, 64512
  %add117.1.1 = or disjoint i32 %mul116.1.1, %mul114
  %154 = zext nneg i32 %add117.1.1 to i64, !dbg !115
  %155 = or disjoint i64 %154, %34, !dbg !116
  %add.ptr125.1769.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %155, !dbg !117
  %kr.sroa.236.32.copyload1990 = load <4 x half>, ptr addrspace(4) %add.ptr125.1769.1, align 16, !dbg !118
  %kr.sroa.242.32.add.ptr125.1769.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1769.1, i64 8, !dbg !118
  %kr.sroa.242.32.copyload1992 = load <4 x half>, ptr addrspace(4) %kr.sroa.242.32.add.ptr125.1769.1.sroa_idx, align 8, !dbg !118
  %156 = or disjoint i64 %154, %34, !dbg !116
  %157 = or disjoint i64 %156, 512, !dbg !116
  %add.ptr125.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %157, !dbg !117
  %kr.sroa.245.48.copyload1998 = load <4 x half>, ptr addrspace(4) %add.ptr125.1.1.1, align 16, !dbg !118
  %kr.sroa.251.48.add.ptr125.1.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1.1.1, i64 8, !dbg !118
  %kr.sroa.251.48.copyload2000 = load <4 x half>, ptr addrspace(4) %kr.sroa.251.48.add.ptr125.1.1.1.sroa_idx, align 8, !dbg !118
  br label %if.end135.1.1, !dbg !119

if.end135.1.1:                                    ; preds = %for.cond109.preheader.1.1, %if.end135.1818
  %kr.sroa.251.2 = phi <4 x half> [ %kr.sroa.251.1, %if.end135.1818 ], [ %kr.sroa.251.48.copyload2000, %for.cond109.preheader.1.1 ]
  %kr.sroa.245.2 = phi <4 x half> [ %kr.sroa.245.1, %if.end135.1818 ], [ %kr.sroa.245.48.copyload1998, %for.cond109.preheader.1.1 ]
  %kr.sroa.242.2 = phi <4 x half> [ %kr.sroa.242.1, %if.end135.1818 ], [ %kr.sroa.242.32.copyload1992, %for.cond109.preheader.1.1 ]
  %kr.sroa.236.2 = phi <4 x half> [ %kr.sroa.236.1, %if.end135.1818 ], [ %kr.sroa.236.32.copyload1990, %for.cond109.preheader.1.1 ]
  %or.cond747.2.1 = icmp ugt i32 %mul11.6, 1023, !dbg !114
  %cmp107.not.2.1 = icmp sgt i32 %mul11.6, %1
  %or.cond748.2.1 = or i1 %or.cond747.2.1, %cmp107.not.2.1, !dbg !114
  br i1 %or.cond748.2.1, label %if.end135.2.1, label %for.cond109.preheader.2.1, !dbg !114

for.cond109.preheader.2.1:                        ; preds = %if.end135.1.1
  %158 = shl nsw i32 %cond.i.i710.6, 10
  %mul116.2.1 = and i32 %158, 64512
  %add117.2.1 = or disjoint i32 %mul116.2.1, %mul114
  %159 = zext nneg i32 %add117.2.1 to i64, !dbg !115
  %160 = or disjoint i64 %159, %34, !dbg !116
  %add.ptr125.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %160, !dbg !117
  %kr.sroa.254.64.copyload2006 = load <4 x half>, ptr addrspace(4) %add.ptr125.2.1, align 16, !dbg !118
  %kr.sroa.260.64.add.ptr125.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.2.1, i64 8, !dbg !118
  %kr.sroa.260.64.copyload2008 = load <4 x half>, ptr addrspace(4) %kr.sroa.260.64.add.ptr125.2.1.sroa_idx, align 8, !dbg !118
  %161 = or disjoint i64 %159, %34, !dbg !116
  %162 = or disjoint i64 %161, 512, !dbg !116
  %add.ptr125.1.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %162, !dbg !117
  %kr.sroa.263.80.copyload2014 = load <4 x half>, ptr addrspace(4) %add.ptr125.1.2.1, align 16, !dbg !118
  %kr.sroa.269.80.add.ptr125.1.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1.2.1, i64 8, !dbg !118
  %kr.sroa.269.80.copyload2016 = load <4 x half>, ptr addrspace(4) %kr.sroa.269.80.add.ptr125.1.2.1.sroa_idx, align 8, !dbg !118
  br label %if.end135.2.1, !dbg !119

if.end135.2.1:                                    ; preds = %for.cond109.preheader.2.1, %if.end135.1.1
  %kr.sroa.269.2 = phi <4 x half> [ %kr.sroa.269.1, %if.end135.1.1 ], [ %kr.sroa.269.80.copyload2016, %for.cond109.preheader.2.1 ]
  %kr.sroa.263.2 = phi <4 x half> [ %kr.sroa.263.1, %if.end135.1.1 ], [ %kr.sroa.263.80.copyload2014, %for.cond109.preheader.2.1 ]
  %kr.sroa.260.2 = phi <4 x half> [ %kr.sroa.260.1, %if.end135.1.1 ], [ %kr.sroa.260.64.copyload2008, %for.cond109.preheader.2.1 ]
  %kr.sroa.254.2 = phi <4 x half> [ %kr.sroa.254.1, %if.end135.1.1 ], [ %kr.sroa.254.64.copyload2006, %for.cond109.preheader.2.1 ]
  %or.cond747.3.1 = icmp ugt i32 %mul11.7, 1023, !dbg !114
  %cmp107.not.3.1 = icmp sgt i32 %mul11.7, %1
  %or.cond748.3.1 = or i1 %or.cond747.3.1, %cmp107.not.3.1, !dbg !114
  br i1 %or.cond748.3.1, label %if.end135.3.1, label %for.cond109.preheader.3.1, !dbg !114

for.cond109.preheader.3.1:                        ; preds = %if.end135.2.1
  %163 = shl nsw i32 %cond.i.i710.7, 10
  %mul116.3.1 = and i32 %163, 64512
  %add117.3.1 = or disjoint i32 %mul116.3.1, %mul114
  %164 = zext nneg i32 %add117.3.1 to i64, !dbg !115
  %165 = or disjoint i64 %164, %34, !dbg !116
  %add.ptr125.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %165, !dbg !117
  %kr.sroa.272.96.copyload2022 = load <4 x half>, ptr addrspace(4) %add.ptr125.3.1, align 16, !dbg !118
  %kr.sroa.278.96.add.ptr125.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.3.1, i64 8, !dbg !118
  %kr.sroa.278.96.copyload2024 = load <4 x half>, ptr addrspace(4) %kr.sroa.278.96.add.ptr125.3.1.sroa_idx, align 8, !dbg !118
  %166 = or disjoint i64 %164, %34, !dbg !116
  %167 = or disjoint i64 %166, 512, !dbg !116
  %add.ptr125.1.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %167, !dbg !117
  %kr.sroa.281.112.copyload2030 = load <4 x half>, ptr addrspace(4) %add.ptr125.1.3.1, align 16, !dbg !118
  %kr.sroa.287.112.add.ptr125.1.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1.3.1, i64 8, !dbg !118
  %kr.sroa.287.112.copyload2032 = load <4 x half>, ptr addrspace(4) %kr.sroa.287.112.add.ptr125.1.3.1.sroa_idx, align 8, !dbg !118
  br label %if.end135.3.1, !dbg !119

if.end135.3.1:                                    ; preds = %for.cond109.preheader.3.1, %if.end135.2.1
  %kr.sroa.287.2 = phi <4 x half> [ %kr.sroa.287.1, %if.end135.2.1 ], [ %kr.sroa.287.112.copyload2032, %for.cond109.preheader.3.1 ]
  %kr.sroa.281.2 = phi <4 x half> [ %kr.sroa.281.1, %if.end135.2.1 ], [ %kr.sroa.281.112.copyload2030, %for.cond109.preheader.3.1 ]
  %kr.sroa.278.2 = phi <4 x half> [ %kr.sroa.278.1, %if.end135.2.1 ], [ %kr.sroa.278.96.copyload2024, %for.cond109.preheader.3.1 ]
  %kr.sroa.272.2 = phi <4 x half> [ %kr.sroa.272.1, %if.end135.2.1 ], [ %kr.sroa.272.96.copyload2022, %for.cond109.preheader.3.1 ]
  br i1 %or.cond748.1811, label %if.end252.1875, label %if.then153.1824, !dbg !120

if.then153.1824:                                  ; preds = %if.end135.3.1
  %cmp156.1823 = icmp sgt i32 %mul11.4, %invariant.op, !dbg !121
  br i1 %cmp156.1823, label %for.cond158.preheader.1827, label %if.end184.1844, !dbg !122

for.cond158.preheader.1827:                       ; preds = %if.then153.1824
  %add166.1826 = or disjoint i32 %mul11.4, %mul165
  %cmp169.not.1828 = icmp sgt i32 %add166.1826, %1, !dbg !123
  %spec.select.1829 = select i1 %cmp169.not.1828, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.0.vec.insert1098 = insertelement <4 x float> poison, float %spec.select.1829, i64 0, !dbg !125
  %cmp169.not.1.1831.not = icmp slt i32 %add166.1826, %1, !dbg !123
  %spec.select.1.1832 = select i1 %cmp169.not.1.1831.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !124
  %scores.sroa.0.4.vec.insert1229 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1098, float %spec.select.1.1832, i64 1, !dbg !125
  %add167.2.1834 = or disjoint i32 %add166.1826, 2, !dbg !126
  %cmp169.not.2.1835 = icmp sgt i32 %add167.2.1834, %1, !dbg !123
  %spec.select.2.1836 = select i1 %cmp169.not.2.1835, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.8.vec.insert1346 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1229, float %spec.select.2.1836, i64 2, !dbg !125
  %add167.3.1838 = or disjoint i32 %add166.1826, 3, !dbg !126
  %cmp169.not.3.1839 = icmp sgt i32 %add167.3.1838, %1, !dbg !123
  %spec.select.3.1840 = select i1 %cmp169.not.3.1839, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.12.vec.insert1463 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1346, float %spec.select.3.1840, i64 3, !dbg !125
  br label %if.end184.1844

if.end184.1844:                                   ; preds = %if.then153.1824, %for.cond158.preheader.1827
  %scores.sroa.0.9 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1463, %for.cond158.preheader.1827 ], [ zeroinitializer, %if.then153.1824 ], !dbg !70
  %resident.sroa.0.0.vec.extract2055 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %168 = bitcast <2 x float> %resident.sroa.0.0.vec.extract2055 to <4 x half>, !dbg !127
  %169 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.7, <4 x half> %168, <4 x float> %scores.sroa.0.9), !dbg !128
  %resident.sroa.0.8.vec.extract2097 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %170 = bitcast <2 x float> %resident.sroa.0.8.vec.extract2097 to <4 x half>, !dbg !127
  %171 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.68.7, <4 x half> %170, <4 x float> %169), !dbg !128
  %resident.sroa.74.16.vec.extract2151 = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %172 = bitcast <2 x float> %resident.sroa.74.16.vec.extract2151 to <4 x half>, !dbg !127
  %173 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.119.7, <4 x half> %172, <4 x float> %171), !dbg !128
  %resident.sroa.74.24.vec.extract2193 = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %174 = bitcast <2 x float> %resident.sroa.74.24.vec.extract2193 to <4 x half>, !dbg !127
  %175 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.185.7, <4 x half> %174, <4 x float> %173), !dbg !128
  %scores.sroa.0.0.vec.extract1100 = extractelement <4 x float> %175, i64 0, !dbg !129
  %mul210.1849 = fmul contract float %scores.sroa.0.0.vec.extract1100, 0x3FB99999A0000000, !dbg !130
  %176 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1849, float 0x4024CB5EC0000000), !dbg !131
  %177 = tail call contract noundef float @llvm.exp.f32(float %176), !dbg !134
  %scores.sroa.0.4.vec.extract1231 = extractelement <4 x float> %175, i64 1, !dbg !129
  %mul210.1.1851 = fmul contract float %scores.sroa.0.4.vec.extract1231, 0x3FB99999A0000000, !dbg !130
  %178 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1.1851, float 0x4024CB5EC0000000), !dbg !131
  %179 = tail call contract noundef float @llvm.exp.f32(float %178), !dbg !134
  %scores.sroa.0.8.vec.extract1348 = extractelement <4 x float> %175, i64 2, !dbg !129
  %mul210.2.1853 = fmul contract float %scores.sroa.0.8.vec.extract1348, 0x3FB99999A0000000, !dbg !130
  %180 = tail call contract noundef float @llvm.minnum.f32(float %mul210.2.1853, float 0x4024CB5EC0000000), !dbg !131
  %181 = tail call contract noundef float @llvm.exp.f32(float %180), !dbg !134
  %scores.sroa.0.12.vec.extract1465 = extractelement <4 x float> %175, i64 3, !dbg !129
  %mul210.3.1855 = fmul contract float %scores.sroa.0.12.vec.extract1465, 0x3FB99999A0000000, !dbg !130
  %182 = tail call contract noundef float @llvm.minnum.f32(float %mul210.3.1855, float 0x4024CB5EC0000000), !dbg !131
  %183 = tail call contract noundef float @llvm.exp.f32(float %182), !dbg !134
  %resident.sroa.146.32.vec.extract2260 = extractelement <4 x float> %resident.sroa.146.5, i64 0, !dbg !151
  %add227.1858 = fadd contract float %resident.sroa.146.32.vec.extract2260, %177, !dbg !152
  %resident.sroa.146.32.vec.insert2262 = insertelement <4 x float> poison, float %add227.1858, i64 0, !dbg !137
  %184 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %177), !dbg !138
  %probs.sroa.0.0.vec.insert1604 = insertelement <4 x i16> poison, i16 %184, i64 0, !dbg !147
  %resident.sroa.146.36.vec.extract2317 = extractelement <4 x float> %resident.sroa.146.5, i64 1, !dbg !151
  %add227.1.1861 = fadd contract float %resident.sroa.146.36.vec.extract2317, %179, !dbg !152
  %resident.sroa.146.36.vec.insert2319 = insertelement <4 x float> %resident.sroa.146.32.vec.insert2262, float %add227.1.1861, i64 1, !dbg !137
  %185 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %179), !dbg !138
  %probs.sroa.0.2.vec.insert1650 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1604, i16 %185, i64 1, !dbg !147
  %resident.sroa.146.40.vec.extract2376 = extractelement <4 x float> %resident.sroa.146.5, i64 2, !dbg !151
  %add227.2.1865 = fadd contract float %resident.sroa.146.40.vec.extract2376, %181, !dbg !152
  %resident.sroa.146.40.vec.insert2378 = insertelement <4 x float> %resident.sroa.146.36.vec.insert2319, float %add227.2.1865, i64 2, !dbg !137
  %186 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %181), !dbg !138
  %probs.sroa.0.4.vec.insert1695 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1650, i16 %186, i64 2, !dbg !147
  %resident.sroa.146.44.vec.extract2435 = extractelement <4 x float> %resident.sroa.146.5, i64 3, !dbg !151
  %add227.3.1869 = fadd contract float %resident.sroa.146.44.vec.extract2435, %183, !dbg !152
  %resident.sroa.146.44.vec.insert2437 = insertelement <4 x float> %resident.sroa.146.40.vec.insert2378, float %add227.3.1869, i64 3, !dbg !137
  %187 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %183), !dbg !138
  %probs.sroa.0.6.vec.insert1717 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1695, i16 %187, i64 3, !dbg !147
  br label %if.end252.1875, !dbg !148

if.end252.1875:                                   ; preds = %if.end135.3.1, %if.end184.1844
  %resident.sroa.146.11 = phi <4 x float> [ %resident.sroa.146.44.vec.insert2437, %if.end184.1844 ], [ %resident.sroa.146.5, %if.end135.3.1 ], !dbg !70
  %probs.sroa.0.10 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1717, %if.end184.1844 ], [ zeroinitializer, %if.end135.3.1 ], !dbg !70
  %add261.1873 = or disjoint i32 %and259, 1024, !dbg !153
  %add.ptr263.1874 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add261.1873, !dbg !149
  store <4 x i16> %probs.sroa.0.10, ptr addrspace(3) %add.ptr263.1874, align 8, !dbg !150
  br i1 %or.cond748.1.1, label %if.end252.1.1, label %if.then153.1.1, !dbg !120

if.then153.1.1:                                   ; preds = %if.end252.1875
  %cmp156.1.1 = icmp sgt i32 %mul11.5, %invariant.op, !dbg !121
  br i1 %cmp156.1.1, label %for.cond158.preheader.1.1, label %if.end184.1.1, !dbg !122

for.cond158.preheader.1.1:                        ; preds = %if.then153.1.1
  %add166.1.1 = or disjoint i32 %mul11.5, %mul165
  %cmp169.not.1772.1 = icmp sgt i32 %add166.1.1, %1, !dbg !123
  %spec.select.1773.1 = select i1 %cmp169.not.1772.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.0.vec.insert1108 = insertelement <4 x float> poison, float %spec.select.1773.1, i64 0, !dbg !125
  %cmp169.not.1.1.1.not = icmp slt i32 %add166.1.1, %1, !dbg !123
  %spec.select.1.1.1 = select i1 %cmp169.not.1.1.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !124
  %scores.sroa.0.4.vec.insert1237 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1108, float %spec.select.1.1.1, i64 1, !dbg !125
  %add167.2.1.1 = or disjoint i32 %add166.1.1, 2, !dbg !126
  %cmp169.not.2.1.1 = icmp sgt i32 %add167.2.1.1, %1, !dbg !123
  %spec.select.2.1.1 = select i1 %cmp169.not.2.1.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.8.vec.insert1354 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1237, float %spec.select.2.1.1, i64 2, !dbg !125
  %add167.3.1.1 = or disjoint i32 %add166.1.1, 3, !dbg !126
  %cmp169.not.3.1.1 = icmp sgt i32 %add167.3.1.1, %1, !dbg !123
  %spec.select.3.1.1 = select i1 %cmp169.not.3.1.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.12.vec.insert1471 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1354, float %spec.select.3.1.1, i64 3, !dbg !125
  br label %if.end184.1.1

if.end184.1.1:                                    ; preds = %if.then153.1.1, %for.cond158.preheader.1.1
  %scores.sroa.0.11 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1471, %for.cond158.preheader.1.1 ], [ zeroinitializer, %if.then153.1.1 ], !dbg !70
  %resident.sroa.0.0.vec.extract2057 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %188 = bitcast <2 x float> %resident.sroa.0.0.vec.extract2057 to <4 x half>, !dbg !127
  %189 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.236.2, <4 x half> %188, <4 x float> %scores.sroa.0.11), !dbg !128
  %resident.sroa.0.8.vec.extract2099 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %190 = bitcast <2 x float> %resident.sroa.0.8.vec.extract2099 to <4 x half>, !dbg !127
  %191 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.242.2, <4 x half> %190, <4 x float> %189), !dbg !128
  %resident.sroa.74.16.vec.extract2153 = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %192 = bitcast <2 x float> %resident.sroa.74.16.vec.extract2153 to <4 x half>, !dbg !127
  %193 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.245.2, <4 x half> %192, <4 x float> %191), !dbg !128
  %resident.sroa.74.24.vec.extract2195 = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %194 = bitcast <2 x float> %resident.sroa.74.24.vec.extract2195 to <4 x half>, !dbg !127
  %195 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.251.2, <4 x half> %194, <4 x float> %193), !dbg !128
  %scores.sroa.0.0.vec.extract1110 = extractelement <4 x float> %195, i64 0, !dbg !129
  %mul210.1776.1 = fmul contract float %scores.sroa.0.0.vec.extract1110, 0x3FB99999A0000000, !dbg !130
  %196 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1776.1, float 0x4024CB5EC0000000), !dbg !131
  %197 = tail call contract noundef float @llvm.exp.f32(float %196), !dbg !134
  %scores.sroa.0.4.vec.extract1239 = extractelement <4 x float> %195, i64 1, !dbg !129
  %mul210.1.1.1 = fmul contract float %scores.sroa.0.4.vec.extract1239, 0x3FB99999A0000000, !dbg !130
  %198 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1.1.1, float 0x4024CB5EC0000000), !dbg !131
  %199 = tail call contract noundef float @llvm.exp.f32(float %198), !dbg !134
  %scores.sroa.0.8.vec.extract1356 = extractelement <4 x float> %195, i64 2, !dbg !129
  %mul210.2.1.1 = fmul contract float %scores.sroa.0.8.vec.extract1356, 0x3FB99999A0000000, !dbg !130
  %200 = tail call contract noundef float @llvm.minnum.f32(float %mul210.2.1.1, float 0x4024CB5EC0000000), !dbg !131
  %201 = tail call contract noundef float @llvm.exp.f32(float %200), !dbg !134
  %scores.sroa.0.12.vec.extract1473 = extractelement <4 x float> %195, i64 3, !dbg !129
  %mul210.3.1.1 = fmul contract float %scores.sroa.0.12.vec.extract1473, 0x3FB99999A0000000, !dbg !130
  %202 = tail call contract noundef float @llvm.minnum.f32(float %mul210.3.1.1, float 0x4024CB5EC0000000), !dbg !131
  %203 = tail call contract noundef float @llvm.exp.f32(float %202), !dbg !134
  %resident.sroa.146.32.vec.extract2264 = extractelement <4 x float> %resident.sroa.146.11, i64 0, !dbg !151
  %add227.1778.1 = fadd contract float %resident.sroa.146.32.vec.extract2264, %197, !dbg !152
  %resident.sroa.146.32.vec.insert2266 = insertelement <4 x float> poison, float %add227.1778.1, i64 0, !dbg !137
  %204 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %197), !dbg !138
  %probs.sroa.0.0.vec.insert1606 = insertelement <4 x i16> poison, i16 %204, i64 0, !dbg !147
  %resident.sroa.146.36.vec.extract2321 = extractelement <4 x float> %resident.sroa.146.11, i64 1, !dbg !151
  %add227.1.1.1 = fadd contract float %resident.sroa.146.36.vec.extract2321, %199, !dbg !152
  %resident.sroa.146.36.vec.insert2323 = insertelement <4 x float> %resident.sroa.146.32.vec.insert2266, float %add227.1.1.1, i64 1, !dbg !137
  %205 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %199), !dbg !138
  %probs.sroa.0.2.vec.insert1652 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1606, i16 %205, i64 1, !dbg !147
  %resident.sroa.146.40.vec.extract2380 = extractelement <4 x float> %resident.sroa.146.11, i64 2, !dbg !151
  %add227.2.1.1 = fadd contract float %resident.sroa.146.40.vec.extract2380, %201, !dbg !152
  %resident.sroa.146.40.vec.insert2382 = insertelement <4 x float> %resident.sroa.146.36.vec.insert2323, float %add227.2.1.1, i64 2, !dbg !137
  %206 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %201), !dbg !138
  %probs.sroa.0.4.vec.insert1697 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1652, i16 %206, i64 2, !dbg !147
  %resident.sroa.146.44.vec.extract2439 = extractelement <4 x float> %resident.sroa.146.11, i64 3, !dbg !151
  %add227.3.1.1 = fadd contract float %resident.sroa.146.44.vec.extract2439, %203, !dbg !152
  %resident.sroa.146.44.vec.insert2441 = insertelement <4 x float> %resident.sroa.146.40.vec.insert2382, float %add227.3.1.1, i64 3, !dbg !137
  %207 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %203), !dbg !138
  %probs.sroa.0.6.vec.insert1719 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1697, i16 %207, i64 3, !dbg !147
  br label %if.end252.1.1, !dbg !148

if.end252.1.1:                                    ; preds = %if.end252.1875, %if.end184.1.1
  %resident.sroa.146.12 = phi <4 x float> [ %resident.sroa.146.44.vec.insert2441, %if.end184.1.1 ], [ %resident.sroa.146.11, %if.end252.1875 ], !dbg !70
  %probs.sroa.0.11 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1719, %if.end184.1.1 ], [ zeroinitializer, %if.end252.1875 ], !dbg !70
  %add261.1.1 = or disjoint i32 %and259, 1280, !dbg !153
  %add.ptr263.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add261.1.1, !dbg !149
  store <4 x i16> %probs.sroa.0.11, ptr addrspace(3) %add.ptr263.1.1, align 8, !dbg !150
  br i1 %or.cond748.2.1, label %if.end252.2.1, label %if.then153.2.1, !dbg !120

if.then153.2.1:                                   ; preds = %if.end252.1.1
  %cmp156.2.1 = icmp sgt i32 %mul11.6, %invariant.op, !dbg !121
  br i1 %cmp156.2.1, label %for.cond158.preheader.2.1, label %if.end184.2.1, !dbg !122

for.cond158.preheader.2.1:                        ; preds = %if.then153.2.1
  %add166.2.1 = or disjoint i32 %mul11.6, %mul165
  %cmp169.not.2779.1 = icmp sgt i32 %add166.2.1, %1, !dbg !123
  %spec.select.2780.1 = select i1 %cmp169.not.2779.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.0.vec.insert1118 = insertelement <4 x float> poison, float %spec.select.2780.1, i64 0, !dbg !125
  %cmp169.not.1.2.1.not = icmp slt i32 %add166.2.1, %1, !dbg !123
  %spec.select.1.2.1 = select i1 %cmp169.not.1.2.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !124
  %scores.sroa.0.4.vec.insert1245 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1118, float %spec.select.1.2.1, i64 1, !dbg !125
  %add167.2.2.1 = or disjoint i32 %add166.2.1, 2, !dbg !126
  %cmp169.not.2.2.1 = icmp sgt i32 %add167.2.2.1, %1, !dbg !123
  %spec.select.2.2.1 = select i1 %cmp169.not.2.2.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.8.vec.insert1362 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1245, float %spec.select.2.2.1, i64 2, !dbg !125
  %add167.3.2.1 = or disjoint i32 %add166.2.1, 3, !dbg !126
  %cmp169.not.3.2.1 = icmp sgt i32 %add167.3.2.1, %1, !dbg !123
  %spec.select.3.2.1 = select i1 %cmp169.not.3.2.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.12.vec.insert1479 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1362, float %spec.select.3.2.1, i64 3, !dbg !125
  br label %if.end184.2.1

if.end184.2.1:                                    ; preds = %if.then153.2.1, %for.cond158.preheader.2.1
  %scores.sroa.0.13 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1479, %for.cond158.preheader.2.1 ], [ zeroinitializer, %if.then153.2.1 ], !dbg !70
  %resident.sroa.0.0.vec.extract2059 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %208 = bitcast <2 x float> %resident.sroa.0.0.vec.extract2059 to <4 x half>, !dbg !127
  %209 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.254.2, <4 x half> %208, <4 x float> %scores.sroa.0.13), !dbg !128
  %resident.sroa.0.8.vec.extract2101 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %210 = bitcast <2 x float> %resident.sroa.0.8.vec.extract2101 to <4 x half>, !dbg !127
  %211 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.260.2, <4 x half> %210, <4 x float> %209), !dbg !128
  %resident.sroa.74.16.vec.extract2155 = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %212 = bitcast <2 x float> %resident.sroa.74.16.vec.extract2155 to <4 x half>, !dbg !127
  %213 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.263.2, <4 x half> %212, <4 x float> %211), !dbg !128
  %resident.sroa.74.24.vec.extract2197 = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %214 = bitcast <2 x float> %resident.sroa.74.24.vec.extract2197 to <4 x half>, !dbg !127
  %215 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.269.2, <4 x half> %214, <4 x float> %213), !dbg !128
  %scores.sroa.0.0.vec.extract1120 = extractelement <4 x float> %215, i64 0, !dbg !129
  %mul210.2783.1 = fmul contract float %scores.sroa.0.0.vec.extract1120, 0x3FB99999A0000000, !dbg !130
  %216 = tail call contract noundef float @llvm.minnum.f32(float %mul210.2783.1, float 0x4024CB5EC0000000), !dbg !131
  %217 = tail call contract noundef float @llvm.exp.f32(float %216), !dbg !134
  %scores.sroa.0.4.vec.extract1247 = extractelement <4 x float> %215, i64 1, !dbg !129
  %mul210.1.2.1 = fmul contract float %scores.sroa.0.4.vec.extract1247, 0x3FB99999A0000000, !dbg !130
  %218 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1.2.1, float 0x4024CB5EC0000000), !dbg !131
  %219 = tail call contract noundef float @llvm.exp.f32(float %218), !dbg !134
  %scores.sroa.0.8.vec.extract1364 = extractelement <4 x float> %215, i64 2, !dbg !129
  %mul210.2.2.1 = fmul contract float %scores.sroa.0.8.vec.extract1364, 0x3FB99999A0000000, !dbg !130
  %220 = tail call contract noundef float @llvm.minnum.f32(float %mul210.2.2.1, float 0x4024CB5EC0000000), !dbg !131
  %221 = tail call contract noundef float @llvm.exp.f32(float %220), !dbg !134
  %scores.sroa.0.12.vec.extract1481 = extractelement <4 x float> %215, i64 3, !dbg !129
  %mul210.3.2.1 = fmul contract float %scores.sroa.0.12.vec.extract1481, 0x3FB99999A0000000, !dbg !130
  %222 = tail call contract noundef float @llvm.minnum.f32(float %mul210.3.2.1, float 0x4024CB5EC0000000), !dbg !131
  %223 = tail call contract noundef float @llvm.exp.f32(float %222), !dbg !134
  %resident.sroa.146.32.vec.extract2268 = extractelement <4 x float> %resident.sroa.146.12, i64 0, !dbg !151
  %add227.2785.1 = fadd contract float %resident.sroa.146.32.vec.extract2268, %217, !dbg !152
  %resident.sroa.146.32.vec.insert2270 = insertelement <4 x float> poison, float %add227.2785.1, i64 0, !dbg !137
  %224 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %217), !dbg !138
  %probs.sroa.0.0.vec.insert1608 = insertelement <4 x i16> poison, i16 %224, i64 0, !dbg !147
  %resident.sroa.146.36.vec.extract2325 = extractelement <4 x float> %resident.sroa.146.12, i64 1, !dbg !151
  %add227.1.2.1 = fadd contract float %resident.sroa.146.36.vec.extract2325, %219, !dbg !152
  %resident.sroa.146.36.vec.insert2327 = insertelement <4 x float> %resident.sroa.146.32.vec.insert2270, float %add227.1.2.1, i64 1, !dbg !137
  %225 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %219), !dbg !138
  %probs.sroa.0.2.vec.insert1654 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1608, i16 %225, i64 1, !dbg !147
  %resident.sroa.146.40.vec.extract2384 = extractelement <4 x float> %resident.sroa.146.12, i64 2, !dbg !151
  %add227.2.2.1 = fadd contract float %resident.sroa.146.40.vec.extract2384, %221, !dbg !152
  %resident.sroa.146.40.vec.insert2386 = insertelement <4 x float> %resident.sroa.146.36.vec.insert2327, float %add227.2.2.1, i64 2, !dbg !137
  %226 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %221), !dbg !138
  %probs.sroa.0.4.vec.insert1699 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1654, i16 %226, i64 2, !dbg !147
  %resident.sroa.146.44.vec.extract2443 = extractelement <4 x float> %resident.sroa.146.12, i64 3, !dbg !151
  %add227.3.2.1 = fadd contract float %resident.sroa.146.44.vec.extract2443, %223, !dbg !152
  %resident.sroa.146.44.vec.insert2445 = insertelement <4 x float> %resident.sroa.146.40.vec.insert2386, float %add227.3.2.1, i64 3, !dbg !137
  %227 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %223), !dbg !138
  %probs.sroa.0.6.vec.insert1721 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1699, i16 %227, i64 3, !dbg !147
  br label %if.end252.2.1, !dbg !148

if.end252.2.1:                                    ; preds = %if.end252.1.1, %if.end184.2.1
  %resident.sroa.146.13 = phi <4 x float> [ %resident.sroa.146.44.vec.insert2445, %if.end184.2.1 ], [ %resident.sroa.146.12, %if.end252.1.1 ], !dbg !70
  %probs.sroa.0.12 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1721, %if.end184.2.1 ], [ zeroinitializer, %if.end252.1.1 ], !dbg !70
  %add261.2.1 = or disjoint i32 %and259, 1536, !dbg !153
  %add.ptr263.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add261.2.1, !dbg !149
  store <4 x i16> %probs.sroa.0.12, ptr addrspace(3) %add.ptr263.2.1, align 8, !dbg !150
  br i1 %or.cond748.3.1, label %if.end252.3.1, label %if.then153.3.1, !dbg !120

if.then153.3.1:                                   ; preds = %if.end252.2.1
  %cmp156.3.1 = icmp sgt i32 %mul11.7, %invariant.op, !dbg !121
  br i1 %cmp156.3.1, label %for.cond158.preheader.3.1, label %if.end184.3.1, !dbg !122

for.cond158.preheader.3.1:                        ; preds = %if.then153.3.1
  %add166.3.1 = or disjoint i32 %mul11.7, %mul165
  %cmp169.not.3786.1 = icmp sgt i32 %add166.3.1, %1, !dbg !123
  %spec.select.3787.1 = select i1 %cmp169.not.3786.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.0.vec.insert1128 = insertelement <4 x float> poison, float %spec.select.3787.1, i64 0, !dbg !125
  %cmp169.not.1.3.1.not = icmp slt i32 %add166.3.1, %1, !dbg !123
  %spec.select.1.3.1 = select i1 %cmp169.not.1.3.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !124
  %scores.sroa.0.4.vec.insert1253 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1128, float %spec.select.1.3.1, i64 1, !dbg !125
  %add167.2.3.1 = or disjoint i32 %add166.3.1, 2, !dbg !126
  %cmp169.not.2.3.1 = icmp sgt i32 %add167.2.3.1, %1, !dbg !123
  %spec.select.2.3.1 = select i1 %cmp169.not.2.3.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.8.vec.insert1370 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1253, float %spec.select.2.3.1, i64 2, !dbg !125
  %add167.3.3.1 = or disjoint i32 %add166.3.1, 3, !dbg !126
  %cmp169.not.3.3.1 = icmp sgt i32 %add167.3.3.1, %1, !dbg !123
  %spec.select.3.3.1 = select i1 %cmp169.not.3.3.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !124
  %scores.sroa.0.12.vec.insert1487 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1370, float %spec.select.3.3.1, i64 3, !dbg !125
  br label %if.end184.3.1

if.end184.3.1:                                    ; preds = %if.then153.3.1, %for.cond158.preheader.3.1
  %scores.sroa.0.15 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1487, %for.cond158.preheader.3.1 ], [ zeroinitializer, %if.then153.3.1 ], !dbg !70
  %resident.sroa.0.0.vec.extract2061 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %228 = bitcast <2 x float> %resident.sroa.0.0.vec.extract2061 to <4 x half>, !dbg !127
  %229 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.272.2, <4 x half> %228, <4 x float> %scores.sroa.0.15), !dbg !128
  %resident.sroa.0.8.vec.extract2103 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %230 = bitcast <2 x float> %resident.sroa.0.8.vec.extract2103 to <4 x half>, !dbg !127
  %231 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.278.2, <4 x half> %230, <4 x float> %229), !dbg !128
  %resident.sroa.74.16.vec.extract2157 = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>, !dbg !127
  %232 = bitcast <2 x float> %resident.sroa.74.16.vec.extract2157 to <4 x half>, !dbg !127
  %233 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.281.2, <4 x half> %232, <4 x float> %231), !dbg !128
  %resident.sroa.74.24.vec.extract2199 = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>, !dbg !127
  %234 = bitcast <2 x float> %resident.sroa.74.24.vec.extract2199 to <4 x half>, !dbg !127
  %235 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.287.2, <4 x half> %234, <4 x float> %233), !dbg !128
  %scores.sroa.0.0.vec.extract1130 = extractelement <4 x float> %235, i64 0, !dbg !129
  %mul210.3790.1 = fmul contract float %scores.sroa.0.0.vec.extract1130, 0x3FB99999A0000000, !dbg !130
  %236 = tail call contract noundef float @llvm.minnum.f32(float %mul210.3790.1, float 0x4024CB5EC0000000), !dbg !131
  %237 = tail call contract noundef float @llvm.exp.f32(float %236), !dbg !134
  %scores.sroa.0.4.vec.extract1255 = extractelement <4 x float> %235, i64 1, !dbg !129
  %mul210.1.3.1 = fmul contract float %scores.sroa.0.4.vec.extract1255, 0x3FB99999A0000000, !dbg !130
  %238 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1.3.1, float 0x4024CB5EC0000000), !dbg !131
  %239 = tail call contract noundef float @llvm.exp.f32(float %238), !dbg !134
  %scores.sroa.0.8.vec.extract1372 = extractelement <4 x float> %235, i64 2, !dbg !129
  %mul210.2.3.1 = fmul contract float %scores.sroa.0.8.vec.extract1372, 0x3FB99999A0000000, !dbg !130
  %240 = tail call contract noundef float @llvm.minnum.f32(float %mul210.2.3.1, float 0x4024CB5EC0000000), !dbg !131
  %241 = tail call contract noundef float @llvm.exp.f32(float %240), !dbg !134
  %scores.sroa.0.12.vec.extract1489 = extractelement <4 x float> %235, i64 3, !dbg !129
  %mul210.3.3.1 = fmul contract float %scores.sroa.0.12.vec.extract1489, 0x3FB99999A0000000, !dbg !130
  %242 = tail call contract noundef float @llvm.minnum.f32(float %mul210.3.3.1, float 0x4024CB5EC0000000), !dbg !131
  %243 = tail call contract noundef float @llvm.exp.f32(float %242), !dbg !134
  %resident.sroa.146.32.vec.extract2272 = extractelement <4 x float> %resident.sroa.146.13, i64 0, !dbg !151
  %add227.3792.1 = fadd contract float %resident.sroa.146.32.vec.extract2272, %237, !dbg !152
  %resident.sroa.146.32.vec.insert2274 = insertelement <4 x float> poison, float %add227.3792.1, i64 0, !dbg !137
  %244 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %237), !dbg !138
  %probs.sroa.0.0.vec.insert1610 = insertelement <4 x i16> poison, i16 %244, i64 0, !dbg !147
  %resident.sroa.146.36.vec.extract2329 = extractelement <4 x float> %resident.sroa.146.13, i64 1, !dbg !151
  %add227.1.3.1 = fadd contract float %resident.sroa.146.36.vec.extract2329, %239, !dbg !152
  %resident.sroa.146.36.vec.insert2331 = insertelement <4 x float> %resident.sroa.146.32.vec.insert2274, float %add227.1.3.1, i64 1, !dbg !137
  %245 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %239), !dbg !138
  %probs.sroa.0.2.vec.insert1656 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1610, i16 %245, i64 1, !dbg !147
  %resident.sroa.146.40.vec.extract2388 = extractelement <4 x float> %resident.sroa.146.13, i64 2, !dbg !151
  %add227.2.3.1 = fadd contract float %resident.sroa.146.40.vec.extract2388, %241, !dbg !152
  %resident.sroa.146.40.vec.insert2390 = insertelement <4 x float> %resident.sroa.146.36.vec.insert2331, float %add227.2.3.1, i64 2, !dbg !137
  %246 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %241), !dbg !138
  %probs.sroa.0.4.vec.insert1701 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1656, i16 %246, i64 2, !dbg !147
  %resident.sroa.146.44.vec.extract2447 = extractelement <4 x float> %resident.sroa.146.13, i64 3, !dbg !151
  %add227.3.3.1 = fadd contract float %resident.sroa.146.44.vec.extract2447, %243, !dbg !152
  %resident.sroa.146.44.vec.insert2449 = insertelement <4 x float> %resident.sroa.146.40.vec.insert2390, float %add227.3.3.1, i64 3, !dbg !137
  %247 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %243), !dbg !138
  %probs.sroa.0.6.vec.insert1723 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1701, i16 %247, i64 3, !dbg !147
  br label %if.end252.3.1, !dbg !148

if.end252.3.1:                                    ; preds = %if.end252.2.1, %if.end184.3.1
  %resident.sroa.146.14 = phi <4 x float> [ %resident.sroa.146.44.vec.insert2449, %if.end184.3.1 ], [ %resident.sroa.146.13, %if.end252.2.1 ], !dbg !70
  %probs.sroa.0.13 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1723, %if.end184.3.1 ], [ zeroinitializer, %if.end252.2.1 ], !dbg !70
  %add261.3.1 = or disjoint i32 %and259, 1792, !dbg !153
  %add.ptr263.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add261.3.1, !dbg !149
  store <4 x i16> %probs.sroa.0.13, ptr addrspace(3) %add.ptr263.3.1, align 8, !dbg !150
  br label %if.end267.1

if.end267.1:                                      ; preds = %if.end252.3.1, %if.end419
  %resident.sroa.146.15 = phi <4 x float> [ %resident.sroa.146.5, %if.end419 ], [ %resident.sroa.146.14, %if.end252.3.1 ], !dbg !154
  br i1 %cmp270.not, label %for.cond274.preheader.1, label %if.end419.1, !dbg !162

for.cond274.preheader.1:                          ; preds = %if.end267.1
  %or.cond751.1877 = icmp ugt i32 %mul11, 1023, !dbg !163
  %cmp287.not.1878 = icmp sgt i32 %mul11, %1
  %or.cond752.1879 = or i1 %or.cond751.1877, %cmp287.not.1878, !dbg !163
  br i1 %or.cond752.1879, label %if.end415.1924, label %for.cond327.preheader.1907, !dbg !163

for.cond327.preheader.1907:                       ; preds = %for.cond274.preheader.1
  %gep.1887 = getelementptr %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul318, !dbg !164
  %248 = load <4 x half>, ptr addrspace(3) %gep.1887, align 8, !dbg !165
  %249 = shl nsw i32 %cond.i.i710, 10
  %mul296.1880 = and i32 %249, 64512
  %add297.1881 = or disjoint i32 %mul296.1880, %mul114
  %250 = zext nneg i32 %add297.1881 to i64, !dbg !166
  %251 = or disjoint i64 %250, %35, !dbg !167
  %252 = or disjoint i64 %251, 512, !dbg !167
  %add.ptr305.1.1884 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %252, !dbg !168
  %kr.sroa.185.16.add.ptr305.1.1884.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1.1884, i64 8, !dbg !169
  %kr.sroa.185.16.copyload1929 = load <4 x half>, ptr addrspace(4) %kr.sroa.185.16.add.ptr305.1.1884.sroa_idx, align 8, !dbg !169
  %kr.sroa.119.16.copyload1915 = load <4 x half>, ptr addrspace(4) %add.ptr305.1.1884, align 16, !dbg !169
  %253 = or disjoint i64 %250, %35, !dbg !167
  %add.ptr305.1883 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %253, !dbg !168
  %kr.sroa.68.0.add.ptr305.1883.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1883, i64 8, !dbg !169
  %kr.sroa.68.0.copyload1801 = load <4 x half>, ptr addrspace(4) %kr.sroa.68.0.add.ptr305.1883.sroa_idx, align 8, !dbg !169
  %kr.sroa.0.0.copyload1787 = load <4 x half>, ptr addrspace(4) %add.ptr305.1883, align 16, !dbg !169
  %254 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0.copyload1787, <4 x half> %248, <4 x float> %resident.sroa.0.0), !dbg !170, !call_argsrelate !171
  %255 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.68.0.copyload1801, <4 x half> %248, <4 x float> %resident.sroa.74.0), !dbg !170, !call_argsrelate !171
  %256 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.119.16.copyload1915, <4 x half> %248, <4 x float> %resident.sroa.146.15), !dbg !170, !call_argsrelate !171
  %257 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.185.16.copyload1929, <4 x half> %248, <4 x float> zeroinitializer), !dbg !170, !call_argsrelate !171
  br label %if.end415.1924, !dbg !172

if.end415.1924:                                   ; preds = %for.cond327.preheader.1907, %for.cond274.preheader.1
  %resident.sroa.294.6 = phi <4 x float> [ zeroinitializer, %for.cond274.preheader.1 ], [ %257, %for.cond327.preheader.1907 ]
  %resident.sroa.146.16 = phi <4 x float> [ %resident.sroa.146.15, %for.cond274.preheader.1 ], [ %256, %for.cond327.preheader.1907 ], !dbg !70
  %resident.sroa.74.6 = phi <4 x float> [ %resident.sroa.74.0, %for.cond274.preheader.1 ], [ %255, %for.cond327.preheader.1907 ], !dbg !70
  %resident.sroa.0.6 = phi <4 x float> [ %resident.sroa.0.0, %for.cond274.preheader.1 ], [ %254, %for.cond327.preheader.1907 ], !dbg !70
  %or.cond751.1.1 = icmp ugt i32 %mul11.1, 1023, !dbg !163
  %cmp287.not.1.1 = icmp sgt i32 %mul11.1, %1
  %or.cond752.1.1 = or i1 %or.cond751.1.1, %cmp287.not.1.1, !dbg !163
  br i1 %or.cond752.1.1, label %if.end415.1.1, label %for.cond348.preheader.1.1, !dbg !163

for.cond348.preheader.1.1:                        ; preds = %if.end415.1924
  %add319.1.1 = or i32 %and259, 1280, !dbg !173
  %gep.1.1 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add319.1.1, !dbg !164
  %258 = load <4 x half>, ptr addrspace(3) %gep.1.1, align 8, !dbg !165
  %259 = shl nsw i32 %cond.i.i710.1, 10
  %mul296.1.1 = and i32 %259, 64512
  %add297.1.1 = or disjoint i32 %mul296.1.1, %mul114
  %260 = zext nneg i32 %add297.1.1 to i64, !dbg !166
  %261 = or disjoint i64 %260, %35, !dbg !167
  %262 = or disjoint i64 %261, 512, !dbg !167
  %add.ptr305.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %262, !dbg !168
  %kr.sroa.185.16.add.ptr305.1.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1.1.1, i64 8, !dbg !169
  %kr.sroa.185.16.copyload1930 = load <4 x half>, ptr addrspace(4) %kr.sroa.185.16.add.ptr305.1.1.1.sroa_idx, align 8, !dbg !169
  %kr.sroa.119.16.copyload1916 = load <4 x half>, ptr addrspace(4) %add.ptr305.1.1.1, align 16, !dbg !169
  %263 = or disjoint i64 %260, %35, !dbg !167
  %add.ptr305.1798.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %263, !dbg !168
  %kr.sroa.68.0.add.ptr305.1798.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1798.1, i64 8, !dbg !169
  %kr.sroa.68.0.copyload1802 = load <4 x half>, ptr addrspace(4) %kr.sroa.68.0.add.ptr305.1798.1.sroa_idx, align 8, !dbg !169
  %kr.sroa.0.0.copyload1788 = load <4 x half>, ptr addrspace(4) %add.ptr305.1798.1, align 16, !dbg !169
  %264 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0.copyload1788, <4 x half> %258, <4 x float> zeroinitializer), !dbg !174, !call_argsrelate !171
  %265 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.68.0.copyload1802, <4 x half> %258, <4 x float> zeroinitializer), !dbg !174, !call_argsrelate !171
  %266 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.119.16.copyload1916, <4 x half> %258, <4 x float> zeroinitializer), !dbg !174, !call_argsrelate !171
  %267 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.185.16.copyload1930, <4 x half> %258, <4 x float> zeroinitializer), !dbg !174, !call_argsrelate !171
  br label %if.end415.1.1, !dbg !172

if.end415.1.1:                                    ; preds = %for.cond348.preheader.1.1, %if.end415.1924
  %resident.sroa.434.7 = phi <4 x float> [ zeroinitializer, %if.end415.1924 ], [ %267, %for.cond348.preheader.1.1 ]
  %resident.sroa.402.7 = phi <4 x float> [ zeroinitializer, %if.end415.1924 ], [ %266, %for.cond348.preheader.1.1 ]
  %resident.sroa.370.7 = phi <4 x float> [ zeroinitializer, %if.end415.1924 ], [ %265, %for.cond348.preheader.1.1 ]
  %resident.sroa.338.7 = phi <4 x float> [ zeroinitializer, %if.end415.1924 ], [ %264, %for.cond348.preheader.1.1 ]
  %or.cond751.2.1 = icmp ugt i32 %mul11.2, 1023, !dbg !163
  %cmp287.not.2.1 = icmp sgt i32 %mul11.2, %1
  %or.cond752.2.1 = or i1 %or.cond751.2.1, %cmp287.not.2.1, !dbg !163
  br i1 %or.cond752.2.1, label %if.end415.2.1, label %for.cond371.preheader.2.1, !dbg !163

for.cond371.preheader.2.1:                        ; preds = %if.end415.1.1
  %add319.2.1 = or disjoint i32 %mul318, 1536, !dbg !173
  %gep.2.1 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add319.2.1, !dbg !164
  %268 = load <4 x half>, ptr addrspace(3) %gep.2.1, align 8, !dbg !165
  %269 = shl nsw i32 %cond.i.i710.2, 10
  %mul296.2.1 = and i32 %269, 64512
  %add297.2.1 = or disjoint i32 %mul296.2.1, %mul114
  %270 = zext nneg i32 %add297.2.1 to i64, !dbg !166
  %271 = or disjoint i64 %270, %35, !dbg !167
  %272 = or disjoint i64 %271, 512, !dbg !167
  %add.ptr305.1.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %272, !dbg !168
  %kr.sroa.185.16.add.ptr305.1.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1.2.1, i64 8, !dbg !169
  %kr.sroa.185.16.copyload1931 = load <4 x half>, ptr addrspace(4) %kr.sroa.185.16.add.ptr305.1.2.1.sroa_idx, align 8, !dbg !169
  %kr.sroa.119.16.copyload1917 = load <4 x half>, ptr addrspace(4) %add.ptr305.1.2.1, align 16, !dbg !169
  %273 = or disjoint i64 %270, %35, !dbg !167
  %add.ptr305.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %273, !dbg !168
  %kr.sroa.68.0.add.ptr305.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.2.1, i64 8, !dbg !169
  %kr.sroa.68.0.copyload1803 = load <4 x half>, ptr addrspace(4) %kr.sroa.68.0.add.ptr305.2.1.sroa_idx, align 8, !dbg !169
  %kr.sroa.0.0.copyload1789 = load <4 x half>, ptr addrspace(4) %add.ptr305.2.1, align 16, !dbg !169
  %274 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0.copyload1789, <4 x half> %268, <4 x float> zeroinitializer), !dbg !175, !call_argsrelate !171
  %275 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.68.0.copyload1803, <4 x half> %268, <4 x float> zeroinitializer), !dbg !175, !call_argsrelate !171
  %276 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.119.16.copyload1917, <4 x half> %268, <4 x float> zeroinitializer), !dbg !175, !call_argsrelate !171
  %277 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.185.16.copyload1931, <4 x half> %268, <4 x float> zeroinitializer), !dbg !175, !call_argsrelate !171
  br label %if.end415.2.1, !dbg !172

if.end415.2.1:                                    ; preds = %for.cond371.preheader.2.1, %if.end415.1.1
  %resident.sroa.562.8 = phi <4 x float> [ zeroinitializer, %if.end415.1.1 ], [ %277, %for.cond371.preheader.2.1 ]
  %resident.sroa.530.8 = phi <4 x float> [ zeroinitializer, %if.end415.1.1 ], [ %276, %for.cond371.preheader.2.1 ]
  %resident.sroa.498.8 = phi <4 x float> [ zeroinitializer, %if.end415.1.1 ], [ %275, %for.cond371.preheader.2.1 ]
  %resident.sroa.466.8 = phi <4 x float> [ zeroinitializer, %if.end415.1.1 ], [ %274, %for.cond371.preheader.2.1 ]
  %or.cond751.3.1 = icmp ugt i32 %mul11.3, 1023, !dbg !163
  %cmp287.not.3.1 = icmp sgt i32 %mul11.3, %1
  %or.cond752.3.1 = or i1 %or.cond751.3.1, %cmp287.not.3.1, !dbg !163
  br i1 %or.cond752.3.1, label %if.end419.1, label %for.cond392.preheader.3.1, !dbg !163

for.cond392.preheader.3.1:                        ; preds = %if.end415.2.1
  %add319.3.1 = or i32 %and259, 1792, !dbg !173
  %gep.3.1 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add319.3.1, !dbg !164
  %278 = load <4 x half>, ptr addrspace(3) %gep.3.1, align 8, !dbg !165
  %279 = shl nsw i32 %cond.i.i710.3, 10
  %mul296.3.1 = and i32 %279, 64512
  %add297.3.1 = or disjoint i32 %mul296.3.1, %mul114
  %280 = zext nneg i32 %add297.3.1 to i64, !dbg !166
  %281 = or disjoint i64 %280, %35, !dbg !167
  %282 = or disjoint i64 %281, 512, !dbg !167
  %add.ptr305.1.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %282, !dbg !168
  %kr.sroa.185.16.add.ptr305.1.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1.3.1, i64 8, !dbg !169
  %kr.sroa.185.16.copyload1932 = load <4 x half>, ptr addrspace(4) %kr.sroa.185.16.add.ptr305.1.3.1.sroa_idx, align 8, !dbg !169
  %kr.sroa.119.16.copyload1918 = load <4 x half>, ptr addrspace(4) %add.ptr305.1.3.1, align 16, !dbg !169
  %283 = or disjoint i64 %280, %35, !dbg !167
  %add.ptr305.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %283, !dbg !168
  %kr.sroa.68.0.add.ptr305.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.3.1, i64 8, !dbg !169
  %kr.sroa.68.0.copyload1804 = load <4 x half>, ptr addrspace(4) %kr.sroa.68.0.add.ptr305.3.1.sroa_idx, align 8, !dbg !169
  %kr.sroa.0.0.copyload1790 = load <4 x half>, ptr addrspace(4) %add.ptr305.3.1, align 16, !dbg !169
  %284 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0.copyload1790, <4 x half> %278, <4 x float> zeroinitializer), !dbg !176, !call_argsrelate !171
  %285 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.68.0.copyload1804, <4 x half> %278, <4 x float> zeroinitializer), !dbg !176, !call_argsrelate !171
  %286 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.119.16.copyload1918, <4 x half> %278, <4 x float> zeroinitializer), !dbg !176, !call_argsrelate !171
  %287 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.185.16.copyload1932, <4 x half> %278, <4 x float> zeroinitializer), !dbg !176, !call_argsrelate !171
  br label %if.end419.1, !dbg !172

if.end419.1:                                      ; preds = %if.end415.2.1, %for.cond392.preheader.3.1, %if.end267.1
  %resident.sroa.690.10 = phi <4 x float> [ zeroinitializer, %if.end267.1 ], [ zeroinitializer, %if.end415.2.1 ], [ %287, %for.cond392.preheader.3.1 ]
  %resident.sroa.658.10 = phi <4 x float> [ zeroinitializer, %if.end267.1 ], [ zeroinitializer, %if.end415.2.1 ], [ %286, %for.cond392.preheader.3.1 ]
  %resident.sroa.626.10 = phi <4 x float> [ zeroinitializer, %if.end267.1 ], [ zeroinitializer, %if.end415.2.1 ], [ %285, %for.cond392.preheader.3.1 ]
  %resident.sroa.594.10 = phi <4 x float> [ zeroinitializer, %if.end267.1 ], [ zeroinitializer, %if.end415.2.1 ], [ %284, %for.cond392.preheader.3.1 ]
  %resident.sroa.562.10 = phi <4 x float> [ zeroinitializer, %if.end267.1 ], [ %resident.sroa.562.8, %if.end415.2.1 ], [ %resident.sroa.562.8, %for.cond392.preheader.3.1 ]
  %resident.sroa.530.10 = phi <4 x float> [ zeroinitializer, %if.end267.1 ], [ %resident.sroa.530.8, %if.end415.2.1 ], [ %resident.sroa.530.8, %for.cond392.preheader.3.1 ]
  %resident.sroa.498.10 = phi <4 x float> [ zeroinitializer, %if.end267.1 ], [ %resident.sroa.498.8, %if.end415.2.1 ], [ %resident.sroa.498.8, %for.cond392.preheader.3.1 ]
  %resident.sroa.466.10 = phi <4 x float> [ zeroinitializer, %if.end267.1 ], [ %resident.sroa.466.8, %if.end415.2.1 ], [ %resident.sroa.466.8, %for.cond392.preheader.3.1 ]
  %resident.sroa.434.10 = phi <4 x float> [ zeroinitializer, %if.end267.1 ], [ %resident.sroa.434.7, %if.end415.2.1 ], [ %resident.sroa.434.7, %for.cond392.preheader.3.1 ]
  %resident.sroa.402.10 = phi <4 x float> [ zeroinitializer, %if.end267.1 ], [ %resident.sroa.402.7, %if.end415.2.1 ], [ %resident.sroa.402.7, %for.cond392.preheader.3.1 ]
  %resident.sroa.370.10 = phi <4 x float> [ zeroinitializer, %if.end267.1 ], [ %resident.sroa.370.7, %if.end415.2.1 ], [ %resident.sroa.370.7, %for.cond392.preheader.3.1 ]
  %resident.sroa.338.10 = phi <4 x float> [ zeroinitializer, %if.end267.1 ], [ %resident.sroa.338.7, %if.end415.2.1 ], [ %resident.sroa.338.7, %for.cond392.preheader.3.1 ]
  %resident.sroa.294.10 = phi <4 x float> [ zeroinitializer, %if.end267.1 ], [ %resident.sroa.294.6, %if.end415.2.1 ], [ %resident.sroa.294.6, %for.cond392.preheader.3.1 ]
  %resident.sroa.146.20 = phi <4 x float> [ %resident.sroa.146.15, %if.end267.1 ], [ %resident.sroa.146.16, %if.end415.2.1 ], [ %resident.sroa.146.16, %for.cond392.preheader.3.1 ], !dbg !154
  %resident.sroa.74.10 = phi <4 x float> [ %resident.sroa.74.0, %if.end267.1 ], [ %resident.sroa.74.6, %if.end415.2.1 ], [ %resident.sroa.74.6, %for.cond392.preheader.3.1 ], !dbg !69
  %resident.sroa.0.10 = phi <4 x float> [ %resident.sroa.0.0, %if.end267.1 ], [ %resident.sroa.0.6, %if.end415.2.1 ], [ %resident.sroa.0.6, %for.cond392.preheader.3.1 ], !dbg !69
  fence syncscope("block") release, !dbg !155
  tail call void @llvm.mxc.barrier(), !dbg !160
  fence syncscope("block") acquire, !dbg !161
  br label %if.end267.2, !dbg !72

if.end267.2:                                      ; preds = %if.end419.1
  br i1 %cmp270.not, label %for.cond274.preheader.2, label %if.end419.2, !dbg !162

for.cond274.preheader.2:                          ; preds = %if.end267.2
  %or.cond751.2994 = icmp ugt i32 %mul11.4, 1023, !dbg !163
  %cmp287.not.2995 = icmp sgt i32 %mul11.4, %1
  %or.cond752.2996 = or i1 %or.cond751.2994, %cmp287.not.2995, !dbg !163
  br i1 %or.cond752.2996, label %if.end415.21041, label %for.cond327.preheader.21024, !dbg !163

for.cond327.preheader.21024:                      ; preds = %for.cond274.preheader.2
  %add319.21003 = or disjoint i32 %mul318, 2048, !dbg !173
  %gep.21004 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add319.21003, !dbg !164
  %288 = load <4 x half>, ptr addrspace(3) %gep.21004, align 8, !dbg !165
  %289 = shl nsw i32 %cond.i.i710.4, 10
  %mul296.2997 = and i32 %289, 64512
  %add297.2998 = or disjoint i32 %mul296.2997, %mul114
  %290 = zext nneg i32 %add297.2998 to i64, !dbg !166
  %291 = or disjoint i64 %290, %35, !dbg !167
  %292 = or disjoint i64 %291, 512, !dbg !167
  %add.ptr305.1.21001 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %292, !dbg !168
  %kr.sroa.185.16.add.ptr305.1.21001.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1.21001, i64 8, !dbg !169
  %kr.sroa.185.16.copyload1934 = load <4 x half>, ptr addrspace(4) %kr.sroa.185.16.add.ptr305.1.21001.sroa_idx, align 8, !dbg !169
  %kr.sroa.119.16.copyload1920 = load <4 x half>, ptr addrspace(4) %add.ptr305.1.21001, align 16, !dbg !169
  %293 = or disjoint i64 %290, %35, !dbg !167
  %add.ptr305.21000 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %293, !dbg !168
  %kr.sroa.68.0.add.ptr305.21000.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.21000, i64 8, !dbg !169
  %kr.sroa.68.0.copyload1806 = load <4 x half>, ptr addrspace(4) %kr.sroa.68.0.add.ptr305.21000.sroa_idx, align 8, !dbg !169
  %kr.sroa.0.0.copyload1792 = load <4 x half>, ptr addrspace(4) %add.ptr305.21000, align 16, !dbg !169
  %294 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0.copyload1792, <4 x half> %288, <4 x float> %resident.sroa.0.10), !dbg !170, !call_argsrelate !171
  %295 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.68.0.copyload1806, <4 x half> %288, <4 x float> %resident.sroa.74.10), !dbg !170, !call_argsrelate !171
  %296 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.119.16.copyload1920, <4 x half> %288, <4 x float> %resident.sroa.146.20), !dbg !170, !call_argsrelate !171
  %297 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.185.16.copyload1934, <4 x half> %288, <4 x float> %resident.sroa.294.10), !dbg !170, !call_argsrelate !171
  br label %if.end415.21041, !dbg !172

if.end415.21041:                                  ; preds = %for.cond327.preheader.21024, %for.cond274.preheader.2
  %resident.sroa.294.11 = phi <4 x float> [ %resident.sroa.294.10, %for.cond274.preheader.2 ], [ %297, %for.cond327.preheader.21024 ]
  %resident.sroa.146.26 = phi <4 x float> [ %resident.sroa.146.20, %for.cond274.preheader.2 ], [ %296, %for.cond327.preheader.21024 ], !dbg !70
  %resident.sroa.74.11 = phi <4 x float> [ %resident.sroa.74.10, %for.cond274.preheader.2 ], [ %295, %for.cond327.preheader.21024 ], !dbg !70
  %resident.sroa.0.11 = phi <4 x float> [ %resident.sroa.0.10, %for.cond274.preheader.2 ], [ %294, %for.cond327.preheader.21024 ], !dbg !70
  %or.cond751.1.2 = icmp ugt i32 %mul11.5, 1023, !dbg !163
  %cmp287.not.1.2 = icmp sgt i32 %mul11.5, %1
  %or.cond752.1.2 = or i1 %or.cond751.1.2, %cmp287.not.1.2, !dbg !163
  br i1 %or.cond752.1.2, label %if.end415.1.2, label %for.cond348.preheader.1.2, !dbg !163

for.cond348.preheader.1.2:                        ; preds = %if.end415.21041
  %add319.1.2 = or i32 %and259, 2304, !dbg !173
  %gep.1.2 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add319.1.2, !dbg !164
  %298 = load <4 x half>, ptr addrspace(3) %gep.1.2, align 8, !dbg !165
  %299 = shl nsw i32 %cond.i.i710.5, 10
  %mul296.1.2 = and i32 %299, 64512
  %add297.1.2 = or disjoint i32 %mul296.1.2, %mul114
  %300 = zext nneg i32 %add297.1.2 to i64, !dbg !166
  %301 = or disjoint i64 %300, %35, !dbg !167
  %302 = or disjoint i64 %301, 512, !dbg !167
  %add.ptr305.1.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %302, !dbg !168
  %kr.sroa.185.16.add.ptr305.1.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1.1.2, i64 8, !dbg !169
  %kr.sroa.185.16.copyload1935 = load <4 x half>, ptr addrspace(4) %kr.sroa.185.16.add.ptr305.1.1.2.sroa_idx, align 8, !dbg !169
  %kr.sroa.119.16.copyload1921 = load <4 x half>, ptr addrspace(4) %add.ptr305.1.1.2, align 16, !dbg !169
  %303 = or disjoint i64 %300, %35, !dbg !167
  %add.ptr305.1798.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %303, !dbg !168
  %kr.sroa.68.0.add.ptr305.1798.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1798.2, i64 8, !dbg !169
  %kr.sroa.68.0.copyload1807 = load <4 x half>, ptr addrspace(4) %kr.sroa.68.0.add.ptr305.1798.2.sroa_idx, align 8, !dbg !169
  %kr.sroa.0.0.copyload1793 = load <4 x half>, ptr addrspace(4) %add.ptr305.1798.2, align 16, !dbg !169
  %304 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0.copyload1793, <4 x half> %298, <4 x float> %resident.sroa.338.10), !dbg !174, !call_argsrelate !171
  %305 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.68.0.copyload1807, <4 x half> %298, <4 x float> %resident.sroa.370.10), !dbg !174, !call_argsrelate !171
  %306 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.119.16.copyload1921, <4 x half> %298, <4 x float> %resident.sroa.402.10), !dbg !174, !call_argsrelate !171
  %307 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.185.16.copyload1935, <4 x half> %298, <4 x float> %resident.sroa.434.10), !dbg !174, !call_argsrelate !171
  br label %if.end415.1.2, !dbg !172

if.end415.1.2:                                    ; preds = %for.cond348.preheader.1.2, %if.end415.21041
  %resident.sroa.434.12 = phi <4 x float> [ %resident.sroa.434.10, %if.end415.21041 ], [ %307, %for.cond348.preheader.1.2 ]
  %resident.sroa.402.12 = phi <4 x float> [ %resident.sroa.402.10, %if.end415.21041 ], [ %306, %for.cond348.preheader.1.2 ]
  %resident.sroa.370.12 = phi <4 x float> [ %resident.sroa.370.10, %if.end415.21041 ], [ %305, %for.cond348.preheader.1.2 ]
  %resident.sroa.338.12 = phi <4 x float> [ %resident.sroa.338.10, %if.end415.21041 ], [ %304, %for.cond348.preheader.1.2 ]
  %or.cond751.2.2 = icmp ugt i32 %mul11.6, 1023, !dbg !163
  %cmp287.not.2.2 = icmp sgt i32 %mul11.6, %1
  %or.cond752.2.2 = or i1 %or.cond751.2.2, %cmp287.not.2.2, !dbg !163
  br i1 %or.cond752.2.2, label %if.end415.2.2, label %for.cond371.preheader.2.2, !dbg !163

for.cond371.preheader.2.2:                        ; preds = %if.end415.1.2
  %add319.2.2 = or disjoint i32 %mul318, 2560, !dbg !173
  %gep.2.2 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add319.2.2, !dbg !164
  %308 = load <4 x half>, ptr addrspace(3) %gep.2.2, align 8, !dbg !165
  %309 = shl nsw i32 %cond.i.i710.6, 10
  %mul296.2.2 = and i32 %309, 64512
  %add297.2.2 = or disjoint i32 %mul296.2.2, %mul114
  %310 = zext nneg i32 %add297.2.2 to i64, !dbg !166
  %311 = or disjoint i64 %310, %35, !dbg !167
  %312 = or disjoint i64 %311, 512, !dbg !167
  %add.ptr305.1.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %312, !dbg !168
  %kr.sroa.185.16.add.ptr305.1.2.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1.2.2, i64 8, !dbg !169
  %kr.sroa.185.16.copyload1936 = load <4 x half>, ptr addrspace(4) %kr.sroa.185.16.add.ptr305.1.2.2.sroa_idx, align 8, !dbg !169
  %kr.sroa.119.16.copyload1922 = load <4 x half>, ptr addrspace(4) %add.ptr305.1.2.2, align 16, !dbg !169
  %313 = or disjoint i64 %310, %35, !dbg !167
  %add.ptr305.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %313, !dbg !168
  %kr.sroa.68.0.add.ptr305.2.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.2.2, i64 8, !dbg !169
  %kr.sroa.68.0.copyload1808 = load <4 x half>, ptr addrspace(4) %kr.sroa.68.0.add.ptr305.2.2.sroa_idx, align 8, !dbg !169
  %kr.sroa.0.0.copyload1794 = load <4 x half>, ptr addrspace(4) %add.ptr305.2.2, align 16, !dbg !169
  %314 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0.copyload1794, <4 x half> %308, <4 x float> %resident.sroa.466.10), !dbg !175, !call_argsrelate !171
  %315 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.68.0.copyload1808, <4 x half> %308, <4 x float> %resident.sroa.498.10), !dbg !175, !call_argsrelate !171
  %316 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.119.16.copyload1922, <4 x half> %308, <4 x float> %resident.sroa.530.10), !dbg !175, !call_argsrelate !171
  %317 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.185.16.copyload1936, <4 x half> %308, <4 x float> %resident.sroa.562.10), !dbg !175, !call_argsrelate !171
  br label %if.end415.2.2, !dbg !172

if.end415.2.2:                                    ; preds = %for.cond371.preheader.2.2, %if.end415.1.2
  %resident.sroa.562.13 = phi <4 x float> [ %resident.sroa.562.10, %if.end415.1.2 ], [ %317, %for.cond371.preheader.2.2 ]
  %resident.sroa.530.13 = phi <4 x float> [ %resident.sroa.530.10, %if.end415.1.2 ], [ %316, %for.cond371.preheader.2.2 ]
  %resident.sroa.498.13 = phi <4 x float> [ %resident.sroa.498.10, %if.end415.1.2 ], [ %315, %for.cond371.preheader.2.2 ]
  %resident.sroa.466.13 = phi <4 x float> [ %resident.sroa.466.10, %if.end415.1.2 ], [ %314, %for.cond371.preheader.2.2 ]
  %or.cond751.3.2 = icmp ugt i32 %mul11.7, 1023, !dbg !163
  %cmp287.not.3.2 = icmp sgt i32 %mul11.7, %1
  %or.cond752.3.2 = or i1 %or.cond751.3.2, %cmp287.not.3.2, !dbg !163
  br i1 %or.cond752.3.2, label %if.end419.2, label %for.cond392.preheader.3.2, !dbg !163

for.cond392.preheader.3.2:                        ; preds = %if.end415.2.2
  %add319.3.2 = or i32 %and259, 2816, !dbg !173
  %gep.3.2 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add319.3.2, !dbg !164
  %318 = load <4 x half>, ptr addrspace(3) %gep.3.2, align 8, !dbg !165
  %319 = shl nsw i32 %cond.i.i710.7, 10
  %mul296.3.2 = and i32 %319, 64512
  %add297.3.2 = or disjoint i32 %mul296.3.2, %mul114
  %320 = zext nneg i32 %add297.3.2 to i64, !dbg !166
  %321 = or disjoint i64 %320, %35, !dbg !167
  %322 = or disjoint i64 %321, 512, !dbg !167
  %add.ptr305.1.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %322, !dbg !168
  %kr.sroa.185.16.add.ptr305.1.3.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1.3.2, i64 8, !dbg !169
  %kr.sroa.185.16.copyload1937 = load <4 x half>, ptr addrspace(4) %kr.sroa.185.16.add.ptr305.1.3.2.sroa_idx, align 8, !dbg !169
  %kr.sroa.119.16.copyload1923 = load <4 x half>, ptr addrspace(4) %add.ptr305.1.3.2, align 16, !dbg !169
  %323 = or disjoint i64 %320, %35, !dbg !167
  %add.ptr305.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %323, !dbg !168
  %kr.sroa.68.0.add.ptr305.3.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.3.2, i64 8, !dbg !169
  %kr.sroa.68.0.copyload1809 = load <4 x half>, ptr addrspace(4) %kr.sroa.68.0.add.ptr305.3.2.sroa_idx, align 8, !dbg !169
  %kr.sroa.0.0.copyload1795 = load <4 x half>, ptr addrspace(4) %add.ptr305.3.2, align 16, !dbg !169
  %324 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0.copyload1795, <4 x half> %318, <4 x float> %resident.sroa.594.10), !dbg !176, !call_argsrelate !171
  %325 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.68.0.copyload1809, <4 x half> %318, <4 x float> %resident.sroa.626.10), !dbg !176, !call_argsrelate !171
  %326 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.119.16.copyload1923, <4 x half> %318, <4 x float> %resident.sroa.658.10), !dbg !176, !call_argsrelate !171
  %327 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.185.16.copyload1937, <4 x half> %318, <4 x float> %resident.sroa.690.10), !dbg !176, !call_argsrelate !171
  br label %if.end419.2, !dbg !172

if.end419.2:                                      ; preds = %if.end415.2.2, %for.cond392.preheader.3.2, %if.end267.2
  %resident.sroa.690.15 = phi <4 x float> [ %resident.sroa.690.10, %if.end267.2 ], [ %resident.sroa.690.10, %if.end415.2.2 ], [ %327, %for.cond392.preheader.3.2 ]
  %resident.sroa.658.15 = phi <4 x float> [ %resident.sroa.658.10, %if.end267.2 ], [ %resident.sroa.658.10, %if.end415.2.2 ], [ %326, %for.cond392.preheader.3.2 ]
  %resident.sroa.626.15 = phi <4 x float> [ %resident.sroa.626.10, %if.end267.2 ], [ %resident.sroa.626.10, %if.end415.2.2 ], [ %325, %for.cond392.preheader.3.2 ]
  %resident.sroa.594.15 = phi <4 x float> [ %resident.sroa.594.10, %if.end267.2 ], [ %resident.sroa.594.10, %if.end415.2.2 ], [ %324, %for.cond392.preheader.3.2 ]
  %resident.sroa.562.15 = phi <4 x float> [ %resident.sroa.562.10, %if.end267.2 ], [ %resident.sroa.562.13, %if.end415.2.2 ], [ %resident.sroa.562.13, %for.cond392.preheader.3.2 ]
  %resident.sroa.530.15 = phi <4 x float> [ %resident.sroa.530.10, %if.end267.2 ], [ %resident.sroa.530.13, %if.end415.2.2 ], [ %resident.sroa.530.13, %for.cond392.preheader.3.2 ]
  %resident.sroa.498.15 = phi <4 x float> [ %resident.sroa.498.10, %if.end267.2 ], [ %resident.sroa.498.13, %if.end415.2.2 ], [ %resident.sroa.498.13, %for.cond392.preheader.3.2 ]
  %resident.sroa.466.15 = phi <4 x float> [ %resident.sroa.466.10, %if.end267.2 ], [ %resident.sroa.466.13, %if.end415.2.2 ], [ %resident.sroa.466.13, %for.cond392.preheader.3.2 ]
  %resident.sroa.434.15 = phi <4 x float> [ %resident.sroa.434.10, %if.end267.2 ], [ %resident.sroa.434.12, %if.end415.2.2 ], [ %resident.sroa.434.12, %for.cond392.preheader.3.2 ]
  %resident.sroa.402.15 = phi <4 x float> [ %resident.sroa.402.10, %if.end267.2 ], [ %resident.sroa.402.12, %if.end415.2.2 ], [ %resident.sroa.402.12, %for.cond392.preheader.3.2 ]
  %resident.sroa.370.15 = phi <4 x float> [ %resident.sroa.370.10, %if.end267.2 ], [ %resident.sroa.370.12, %if.end415.2.2 ], [ %resident.sroa.370.12, %for.cond392.preheader.3.2 ]
  %resident.sroa.338.15 = phi <4 x float> [ %resident.sroa.338.10, %if.end267.2 ], [ %resident.sroa.338.12, %if.end415.2.2 ], [ %resident.sroa.338.12, %for.cond392.preheader.3.2 ]
  %resident.sroa.294.15 = phi <4 x float> [ %resident.sroa.294.10, %if.end267.2 ], [ %resident.sroa.294.11, %if.end415.2.2 ], [ %resident.sroa.294.11, %for.cond392.preheader.3.2 ]
  %resident.sroa.146.30 = phi <4 x float> [ %resident.sroa.146.20, %if.end267.2 ], [ %resident.sroa.146.26, %if.end415.2.2 ], [ %resident.sroa.146.26, %for.cond392.preheader.3.2 ], !dbg !154
  %resident.sroa.74.15 = phi <4 x float> [ %resident.sroa.74.10, %if.end267.2 ], [ %resident.sroa.74.11, %if.end415.2.2 ], [ %resident.sroa.74.11, %for.cond392.preheader.3.2 ], !dbg !69
  %resident.sroa.0.15 = phi <4 x float> [ %resident.sroa.0.10, %if.end267.2 ], [ %resident.sroa.0.11, %if.end415.2.2 ], [ %resident.sroa.0.11, %for.cond392.preheader.3.2 ], !dbg !69
  fence syncscope("block") release, !dbg !155
  tail call void @llvm.mxc.barrier(), !dbg !160
  fence syncscope("block") acquire, !dbg !161
  br i1 %cmp15, label %for.body431.preheader, label %if.end463, !dbg !177

if.end463:                                        ; preds = %for.body431.preheader, %if.end419.2
  fence syncscope("block") release, !dbg !178
  tail call void @llvm.mxc.barrier(), !dbg !181
  fence syncscope("block") acquire, !dbg !182
  %cmp466 = icmp eq i32 %shr269.mask, 64, !dbg !183
  br i1 %cmp466, label %if.then467, label %if.end581, !dbg !184

if.then467:                                       ; preds = %if.end463
  %and469 = and i32 %18, 63, !dbg !185
  %arrayidx471 = getelementptr inbounds float, ptr addrspace(3) @buf_dyn_shmem, i32 %and469, !dbg !186
  %328 = load float, ptr addrspace(3) %arrayidx471, align 4, !dbg !186, !tbaa !111
  fence syncscope("warp") release, !dbg !187
  tail call void @llvm.mxc.barrier.warp(), !dbg !192
  fence syncscope("warp") acquire, !dbg !193
  %resident.sroa.0.0.vec.extract2072 = extractelement <4 x float> %resident.sroa.0.15, i64 0, !dbg !194
  %resident.sroa.338.64.vec.extract = extractelement <4 x float> %resident.sroa.338.15, i64 0, !dbg !195
  %add482 = fadd contract float %resident.sroa.0.0.vec.extract2072, %resident.sroa.338.64.vec.extract, !dbg !196
  %resident.sroa.466.128.vec.extract = extractelement <4 x float> %resident.sroa.466.15, i64 0, !dbg !197
  %add490 = fadd contract float %add482, %resident.sroa.466.128.vec.extract, !dbg !198
  %resident.sroa.594.192.vec.extract = extractelement <4 x float> %resident.sroa.594.15, i64 0, !dbg !199
  %add498 = fadd contract float %add490, %resident.sroa.594.192.vec.extract, !dbg !200
  %mul504 = fmul contract float %328, %add498, !dbg !201
  %329 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504), !dbg !202
  %oreg.sroa.0.0.insert.ext = zext i16 %329 to i64, !dbg !206
  %resident.sroa.0.4.vec.extract = extractelement <4 x float> %resident.sroa.0.15, i64 1, !dbg !194
  %resident.sroa.338.68.vec.extract = extractelement <4 x float> %resident.sroa.338.15, i64 1, !dbg !195
  %add482.1 = fadd contract float %resident.sroa.0.4.vec.extract, %resident.sroa.338.68.vec.extract, !dbg !196
  %resident.sroa.466.132.vec.extract = extractelement <4 x float> %resident.sroa.466.15, i64 1, !dbg !197
  %add490.1 = fadd contract float %add482.1, %resident.sroa.466.132.vec.extract, !dbg !198
  %resident.sroa.594.196.vec.extract = extractelement <4 x float> %resident.sroa.594.15, i64 1, !dbg !199
  %add498.1 = fadd contract float %add490.1, %resident.sroa.594.196.vec.extract, !dbg !200
  %mul504.1 = fmul contract float %328, %add498.1, !dbg !201
  %330 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504.1), !dbg !202
  %oreg.sroa.0.2.insert.ext = zext i16 %330 to i64, !dbg !206
  %oreg.sroa.0.2.insert.shift = shl nuw nsw i64 %oreg.sroa.0.2.insert.ext, 16, !dbg !206
  %oreg.sroa.0.2.insert.insert = or disjoint i64 %oreg.sroa.0.2.insert.shift, %oreg.sroa.0.0.insert.ext, !dbg !206
  %resident.sroa.0.8.vec.extract2114 = extractelement <4 x float> %resident.sroa.0.15, i64 2, !dbg !194
  %resident.sroa.338.72.vec.extract = extractelement <4 x float> %resident.sroa.338.15, i64 2, !dbg !195
  %add482.2 = fadd contract float %resident.sroa.0.8.vec.extract2114, %resident.sroa.338.72.vec.extract, !dbg !196
  %resident.sroa.466.136.vec.extract = extractelement <4 x float> %resident.sroa.466.15, i64 2, !dbg !197
  %add490.2 = fadd contract float %add482.2, %resident.sroa.466.136.vec.extract, !dbg !198
  %resident.sroa.594.200.vec.extract = extractelement <4 x float> %resident.sroa.594.15, i64 2, !dbg !199
  %add498.2 = fadd contract float %add490.2, %resident.sroa.594.200.vec.extract, !dbg !200
  %mul504.2 = fmul contract float %328, %add498.2, !dbg !201
  %331 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504.2), !dbg !202
  %oreg.sroa.0.4.insert.ext = zext i16 %331 to i64, !dbg !206
  %oreg.sroa.0.4.insert.shift = shl nuw nsw i64 %oreg.sroa.0.4.insert.ext, 32, !dbg !206
  %oreg.sroa.0.4.insert.insert = or disjoint i64 %oreg.sroa.0.2.insert.insert, %oreg.sroa.0.4.insert.shift, !dbg !206
  %resident.sroa.0.12.vec.extract = extractelement <4 x float> %resident.sroa.0.15, i64 3, !dbg !194
  %resident.sroa.338.76.vec.extract = extractelement <4 x float> %resident.sroa.338.15, i64 3, !dbg !195
  %add482.3 = fadd contract float %resident.sroa.0.12.vec.extract, %resident.sroa.338.76.vec.extract, !dbg !196
  %resident.sroa.466.140.vec.extract = extractelement <4 x float> %resident.sroa.466.15, i64 3, !dbg !197
  %add490.3 = fadd contract float %add482.3, %resident.sroa.466.140.vec.extract, !dbg !198
  %resident.sroa.594.204.vec.extract = extractelement <4 x float> %resident.sroa.594.15, i64 3, !dbg !199
  %add498.3 = fadd contract float %add490.3, %resident.sroa.594.204.vec.extract, !dbg !200
  %mul504.3 = fmul contract float %328, %add498.3, !dbg !201
  %332 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504.3), !dbg !202
  %oreg.sroa.0.6.insert.ext = zext i16 %332 to i64, !dbg !206
  %oreg.sroa.0.6.insert.shift = shl nuw i64 %oreg.sroa.0.6.insert.ext, 48, !dbg !206
  %oreg.sroa.0.6.insert.insert = or disjoint i64 %oreg.sroa.0.4.insert.insert, %oreg.sroa.0.6.insert.shift, !dbg !206
  %resident.sroa.74.16.vec.extract2168 = extractelement <4 x float> %resident.sroa.74.15, i64 0, !dbg !194
  %resident.sroa.370.80.vec.extract = extractelement <4 x float> %resident.sroa.370.15, i64 0, !dbg !195
  %add482.4 = fadd contract float %resident.sroa.74.16.vec.extract2168, %resident.sroa.370.80.vec.extract, !dbg !196
  %resident.sroa.498.144.vec.extract = extractelement <4 x float> %resident.sroa.498.15, i64 0, !dbg !197
  %add490.4 = fadd contract float %add482.4, %resident.sroa.498.144.vec.extract, !dbg !198
  %resident.sroa.626.208.vec.extract = extractelement <4 x float> %resident.sroa.626.15, i64 0, !dbg !199
  %add498.4 = fadd contract float %add490.4, %resident.sroa.626.208.vec.extract, !dbg !200
  %mul504.4 = fmul contract float %328, %add498.4, !dbg !201
  %333 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504.4), !dbg !202
  %oreg.sroa.7.8.insert.ext = zext i16 %333 to i64, !dbg !206
  %resident.sroa.74.20.vec.extract = extractelement <4 x float> %resident.sroa.74.15, i64 1, !dbg !194
  %resident.sroa.370.84.vec.extract = extractelement <4 x float> %resident.sroa.370.15, i64 1, !dbg !195
  %add482.5 = fadd contract float %resident.sroa.74.20.vec.extract, %resident.sroa.370.84.vec.extract, !dbg !196
  %resident.sroa.498.148.vec.extract = extractelement <4 x float> %resident.sroa.498.15, i64 1, !dbg !197
  %add490.5 = fadd contract float %add482.5, %resident.sroa.498.148.vec.extract, !dbg !198
  %resident.sroa.626.212.vec.extract = extractelement <4 x float> %resident.sroa.626.15, i64 1, !dbg !199
  %add498.5 = fadd contract float %add490.5, %resident.sroa.626.212.vec.extract, !dbg !200
  %mul504.5 = fmul contract float %328, %add498.5, !dbg !201
  %334 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504.5), !dbg !202
  %oreg.sroa.7.10.insert.ext = zext i16 %334 to i64, !dbg !206
  %oreg.sroa.7.10.insert.shift = shl nuw nsw i64 %oreg.sroa.7.10.insert.ext, 16, !dbg !206
  %oreg.sroa.7.10.insert.insert = or disjoint i64 %oreg.sroa.7.10.insert.shift, %oreg.sroa.7.8.insert.ext, !dbg !206
  %resident.sroa.74.24.vec.extract2210 = extractelement <4 x float> %resident.sroa.74.15, i64 2, !dbg !194
  %resident.sroa.370.88.vec.extract = extractelement <4 x float> %resident.sroa.370.15, i64 2, !dbg !195
  %add482.6 = fadd contract float %resident.sroa.74.24.vec.extract2210, %resident.sroa.370.88.vec.extract, !dbg !196
  %resident.sroa.498.152.vec.extract = extractelement <4 x float> %resident.sroa.498.15, i64 2, !dbg !197
  %add490.6 = fadd contract float %add482.6, %resident.sroa.498.152.vec.extract, !dbg !198
  %resident.sroa.626.216.vec.extract = extractelement <4 x float> %resident.sroa.626.15, i64 2, !dbg !199
  %add498.6 = fadd contract float %add490.6, %resident.sroa.626.216.vec.extract, !dbg !200
  %mul504.6 = fmul contract float %328, %add498.6, !dbg !201
  %335 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504.6), !dbg !202
  %oreg.sroa.7.12.insert.ext = zext i16 %335 to i64, !dbg !206
  %oreg.sroa.7.12.insert.shift = shl nuw nsw i64 %oreg.sroa.7.12.insert.ext, 32, !dbg !206
  %oreg.sroa.7.12.insert.insert = or disjoint i64 %oreg.sroa.7.10.insert.insert, %oreg.sroa.7.12.insert.shift, !dbg !206
  %resident.sroa.74.28.vec.extract = extractelement <4 x float> %resident.sroa.74.15, i64 3, !dbg !194
  %resident.sroa.370.92.vec.extract = extractelement <4 x float> %resident.sroa.370.15, i64 3, !dbg !195
  %add482.7 = fadd contract float %resident.sroa.74.28.vec.extract, %resident.sroa.370.92.vec.extract, !dbg !196
  %resident.sroa.498.156.vec.extract = extractelement <4 x float> %resident.sroa.498.15, i64 3, !dbg !197
  %add490.7 = fadd contract float %add482.7, %resident.sroa.498.156.vec.extract, !dbg !198
  %resident.sroa.626.220.vec.extract = extractelement <4 x float> %resident.sroa.626.15, i64 3, !dbg !199
  %add498.7 = fadd contract float %add490.7, %resident.sroa.626.220.vec.extract, !dbg !200
  %mul504.7 = fmul contract float %328, %add498.7, !dbg !201
  %336 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504.7), !dbg !202
  %oreg.sroa.7.14.insert.ext = zext i16 %336 to i64, !dbg !206
  %oreg.sroa.7.14.insert.shift = shl nuw i64 %oreg.sroa.7.14.insert.ext, 48, !dbg !206
  %oreg.sroa.7.14.insert.insert = or disjoint i64 %oreg.sroa.7.12.insert.insert, %oreg.sroa.7.14.insert.shift, !dbg !206
  %resident.sroa.146.32.vec.extract2292 = extractelement <4 x float> %resident.sroa.146.30, i64 0, !dbg !194
  %resident.sroa.402.96.vec.extract = extractelement <4 x float> %resident.sroa.402.15, i64 0, !dbg !195
  %add482.8 = fadd contract float %resident.sroa.146.32.vec.extract2292, %resident.sroa.402.96.vec.extract, !dbg !196
  %resident.sroa.530.160.vec.extract = extractelement <4 x float> %resident.sroa.530.15, i64 0, !dbg !197
  %add490.8 = fadd contract float %add482.8, %resident.sroa.530.160.vec.extract, !dbg !198
  %resident.sroa.658.224.vec.extract = extractelement <4 x float> %resident.sroa.658.15, i64 0, !dbg !199
  %add498.8 = fadd contract float %add490.8, %resident.sroa.658.224.vec.extract, !dbg !200
  %mul504.8 = fmul contract float %328, %add498.8, !dbg !201
  %337 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504.8), !dbg !202
  %oreg.sroa.12.16.insert.ext = zext i16 %337 to i64, !dbg !206
  %resident.sroa.146.36.vec.extract2351 = extractelement <4 x float> %resident.sroa.146.30, i64 1, !dbg !194
  %resident.sroa.402.100.vec.extract = extractelement <4 x float> %resident.sroa.402.15, i64 1, !dbg !195
  %add482.9 = fadd contract float %resident.sroa.146.36.vec.extract2351, %resident.sroa.402.100.vec.extract, !dbg !196
  %resident.sroa.530.164.vec.extract = extractelement <4 x float> %resident.sroa.530.15, i64 1, !dbg !197
  %add490.9 = fadd contract float %add482.9, %resident.sroa.530.164.vec.extract, !dbg !198
  %resident.sroa.658.228.vec.extract = extractelement <4 x float> %resident.sroa.658.15, i64 1, !dbg !199
  %add498.9 = fadd contract float %add490.9, %resident.sroa.658.228.vec.extract, !dbg !200
  %mul504.9 = fmul contract float %328, %add498.9, !dbg !201
  %338 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504.9), !dbg !202
  %oreg.sroa.12.18.insert.ext = zext i16 %338 to i64, !dbg !206
  %oreg.sroa.12.18.insert.shift = shl nuw nsw i64 %oreg.sroa.12.18.insert.ext, 16, !dbg !206
  %oreg.sroa.12.18.insert.insert = or disjoint i64 %oreg.sroa.12.18.insert.shift, %oreg.sroa.12.16.insert.ext, !dbg !206
  %resident.sroa.146.40.vec.extract2410 = extractelement <4 x float> %resident.sroa.146.30, i64 2, !dbg !194
  %resident.sroa.402.104.vec.extract = extractelement <4 x float> %resident.sroa.402.15, i64 2, !dbg !195
  %add482.10 = fadd contract float %resident.sroa.146.40.vec.extract2410, %resident.sroa.402.104.vec.extract, !dbg !196
  %resident.sroa.530.168.vec.extract = extractelement <4 x float> %resident.sroa.530.15, i64 2, !dbg !197
  %add490.10 = fadd contract float %add482.10, %resident.sroa.530.168.vec.extract, !dbg !198
  %resident.sroa.658.232.vec.extract = extractelement <4 x float> %resident.sroa.658.15, i64 2, !dbg !199
  %add498.10 = fadd contract float %add490.10, %resident.sroa.658.232.vec.extract, !dbg !200
  %mul504.10 = fmul contract float %328, %add498.10, !dbg !201
  %339 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504.10), !dbg !202
  %oreg.sroa.12.20.insert.ext = zext i16 %339 to i64, !dbg !206
  %oreg.sroa.12.20.insert.shift = shl nuw nsw i64 %oreg.sroa.12.20.insert.ext, 32, !dbg !206
  %oreg.sroa.12.20.insert.insert = or disjoint i64 %oreg.sroa.12.18.insert.insert, %oreg.sroa.12.20.insert.shift, !dbg !206
  %resident.sroa.146.44.vec.extract2469 = extractelement <4 x float> %resident.sroa.146.30, i64 3, !dbg !194
  %resident.sroa.402.108.vec.extract = extractelement <4 x float> %resident.sroa.402.15, i64 3, !dbg !195
  %add482.11 = fadd contract float %resident.sroa.146.44.vec.extract2469, %resident.sroa.402.108.vec.extract, !dbg !196
  %resident.sroa.530.172.vec.extract = extractelement <4 x float> %resident.sroa.530.15, i64 3, !dbg !197
  %add490.11 = fadd contract float %add482.11, %resident.sroa.530.172.vec.extract, !dbg !198
  %resident.sroa.658.236.vec.extract = extractelement <4 x float> %resident.sroa.658.15, i64 3, !dbg !199
  %add498.11 = fadd contract float %add490.11, %resident.sroa.658.236.vec.extract, !dbg !200
  %mul504.11 = fmul contract float %328, %add498.11, !dbg !201
  %340 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504.11), !dbg !202
  %oreg.sroa.12.22.insert.ext = zext i16 %340 to i64, !dbg !206
  %oreg.sroa.12.22.insert.shift = shl nuw i64 %oreg.sroa.12.22.insert.ext, 48, !dbg !206
  %oreg.sroa.12.22.insert.insert = or disjoint i64 %oreg.sroa.12.20.insert.insert, %oreg.sroa.12.22.insert.shift, !dbg !206
  %resident.sroa.294.48.vec.extract = extractelement <4 x float> %resident.sroa.294.15, i64 0, !dbg !194
  %resident.sroa.434.112.vec.extract = extractelement <4 x float> %resident.sroa.434.15, i64 0, !dbg !195
  %add482.12 = fadd contract float %resident.sroa.294.48.vec.extract, %resident.sroa.434.112.vec.extract, !dbg !196
  %resident.sroa.562.176.vec.extract = extractelement <4 x float> %resident.sroa.562.15, i64 0, !dbg !197
  %add490.12 = fadd contract float %add482.12, %resident.sroa.562.176.vec.extract, !dbg !198
  %resident.sroa.690.240.vec.extract = extractelement <4 x float> %resident.sroa.690.15, i64 0, !dbg !199
  %add498.12 = fadd contract float %add490.12, %resident.sroa.690.240.vec.extract, !dbg !200
  %mul504.12 = fmul contract float %328, %add498.12, !dbg !201
  %341 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504.12), !dbg !202
  %oreg.sroa.17.24.insert.ext = zext i16 %341 to i64, !dbg !206
  %resident.sroa.294.52.vec.extract = extractelement <4 x float> %resident.sroa.294.15, i64 1, !dbg !194
  %resident.sroa.434.116.vec.extract = extractelement <4 x float> %resident.sroa.434.15, i64 1, !dbg !195
  %add482.13 = fadd contract float %resident.sroa.294.52.vec.extract, %resident.sroa.434.116.vec.extract, !dbg !196
  %resident.sroa.562.180.vec.extract = extractelement <4 x float> %resident.sroa.562.15, i64 1, !dbg !197
  %add490.13 = fadd contract float %add482.13, %resident.sroa.562.180.vec.extract, !dbg !198
  %resident.sroa.690.244.vec.extract = extractelement <4 x float> %resident.sroa.690.15, i64 1, !dbg !199
  %add498.13 = fadd contract float %add490.13, %resident.sroa.690.244.vec.extract, !dbg !200
  %mul504.13 = fmul contract float %328, %add498.13, !dbg !201
  %342 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504.13), !dbg !202
  %oreg.sroa.17.26.insert.ext = zext i16 %342 to i64, !dbg !206
  %oreg.sroa.17.26.insert.shift = shl nuw nsw i64 %oreg.sroa.17.26.insert.ext, 16, !dbg !206
  %oreg.sroa.17.26.insert.insert = or disjoint i64 %oreg.sroa.17.26.insert.shift, %oreg.sroa.17.24.insert.ext, !dbg !206
  %resident.sroa.294.56.vec.extract = extractelement <4 x float> %resident.sroa.294.15, i64 2, !dbg !194
  %resident.sroa.434.120.vec.extract = extractelement <4 x float> %resident.sroa.434.15, i64 2, !dbg !195
  %add482.14 = fadd contract float %resident.sroa.294.56.vec.extract, %resident.sroa.434.120.vec.extract, !dbg !196
  %resident.sroa.562.184.vec.extract = extractelement <4 x float> %resident.sroa.562.15, i64 2, !dbg !197
  %add490.14 = fadd contract float %add482.14, %resident.sroa.562.184.vec.extract, !dbg !198
  %resident.sroa.690.248.vec.extract = extractelement <4 x float> %resident.sroa.690.15, i64 2, !dbg !199
  %add498.14 = fadd contract float %add490.14, %resident.sroa.690.248.vec.extract, !dbg !200
  %mul504.14 = fmul contract float %328, %add498.14, !dbg !201
  %343 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504.14), !dbg !202
  %oreg.sroa.17.28.insert.ext = zext i16 %343 to i64, !dbg !206
  %oreg.sroa.17.28.insert.shift = shl nuw nsw i64 %oreg.sroa.17.28.insert.ext, 32, !dbg !206
  %oreg.sroa.17.28.insert.insert = or disjoint i64 %oreg.sroa.17.26.insert.insert, %oreg.sroa.17.28.insert.shift, !dbg !206
  %resident.sroa.294.60.vec.extract = extractelement <4 x float> %resident.sroa.294.15, i64 3, !dbg !194
  %resident.sroa.434.124.vec.extract = extractelement <4 x float> %resident.sroa.434.15, i64 3, !dbg !195
  %add482.15 = fadd contract float %resident.sroa.294.60.vec.extract, %resident.sroa.434.124.vec.extract, !dbg !196
  %resident.sroa.562.188.vec.extract = extractelement <4 x float> %resident.sroa.562.15, i64 3, !dbg !197
  %add490.15 = fadd contract float %add482.15, %resident.sroa.562.188.vec.extract, !dbg !198
  %resident.sroa.690.252.vec.extract = extractelement <4 x float> %resident.sroa.690.15, i64 3, !dbg !199
  %add498.15 = fadd contract float %add490.15, %resident.sroa.690.252.vec.extract, !dbg !200
  %mul504.15 = fmul contract float %328, %add498.15, !dbg !201
  %344 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504.15), !dbg !202
  %oreg.sroa.17.30.insert.ext = zext i16 %344 to i64, !dbg !206
  %oreg.sroa.17.30.insert.shift = shl nuw i64 %oreg.sroa.17.30.insert.ext, 48, !dbg !206
  %oreg.sroa.17.30.insert.insert = or disjoint i64 %oreg.sroa.17.28.insert.insert, %oreg.sroa.17.30.insert.shift, !dbg !206
  %and524 = shl nuw nsw i32 %18, 6
  %mul525 = and i32 %and524, 960
  %and528 = lshr i32 %18, 5
  %shr529 = and i32 %and528, 1
  %and532 = and i32 %18, 7
  %mul538 = and i32 %33, 4
  %xor = xor i32 %shr529, %and532, !dbg !207
  %mul533 = shl nuw nsw i32 %xor, 3, !dbg !208
  %add534 = or disjoint i32 %mul533, %mul525, !dbg !209
  %add539 = or disjoint i32 %add534, %mul538, !dbg !210
  %add.ptr541 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add539, !dbg !211
  store i64 %oreg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr541, align 8, !dbg !212
  %xor.1 = xor i32 %and528, %and532, !dbg !207
  %mul533.1 = shl nuw nsw i32 %xor.1, 3, !dbg !208
  %add534.1 = or disjoint i32 %mul533.1, %mul525, !dbg !209
  %add539.1 = or disjoint i32 %add534.1, %mul538, !dbg !210
  %add.ptr541.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add539.1, !dbg !211
  store i64 %oreg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr541.1, align 8, !dbg !212
  %add530.2 = or disjoint i32 %shr529, 4, !dbg !213
  %xor.2 = xor i32 %add530.2, %and532, !dbg !207
  %mul533.2 = shl nuw nsw i32 %xor.2, 3, !dbg !208
  %add534.2 = or disjoint i32 %mul533.2, %mul525, !dbg !209
  %add539.2 = or disjoint i32 %add534.2, %mul538, !dbg !210
  %add.ptr541.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add539.2, !dbg !211
  store i64 %oreg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr541.2, align 8, !dbg !212
  %add530.3 = or i32 %and528, 6, !dbg !213
  %xor.3 = xor i32 %add530.3, %and532, !dbg !207
  %mul533.3 = shl nuw nsw i32 %xor.3, 3, !dbg !208
  %add534.3 = or disjoint i32 %mul533.3, %mul525, !dbg !209
  %add539.3 = or disjoint i32 %add534.3, %mul538, !dbg !210
  %add.ptr541.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add539.3, !dbg !211
  store i64 %oreg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr541.3, align 8, !dbg !212
  fence syncscope("warp") release, !dbg !214
  tail call void @llvm.mxc.barrier.warp(), !dbg !217
  fence syncscope("warp") acquire, !dbg !218
  %mul553 = and i32 %and121, 448
  %xor560 = xor i32 %and121, %18
  %mul561 = and i32 %xor560, 56
  %345 = or disjoint i32 %mul561, %mul553
  %mul566 = shl nsw i32 %0, 20
  %mul568 = shl nsw i32 %1, 10
  %add569 = add nuw nsw i32 %mul566, %mul568
  %346 = or disjoint i32 %add569, %mul302
  %347 = zext nneg i32 %346 to i64, !dbg !219
  %add.ptr564 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %345, !dbg !220
  %add.ptr577 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %347, !dbg !221
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr577, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr564, i64 16, i1 false), !dbg !222, !tbaa.struct !223, !call_argsrelate !224
  %348 = or disjoint i32 %345, 512, !dbg !225
  %add.ptr564.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %348, !dbg !220
  %349 = or disjoint i64 %347, 512, !dbg !226
  %add.ptr577.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %349, !dbg !221
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr577.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr564.1, i64 16, i1 false), !dbg !222, !tbaa.struct !223, !call_argsrelate !224
  br label %if.end581, !dbg !227

if.end581:                                        ; preds = %if.then467, %if.end463
  ret void, !dbg !227
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
!1 = !DIFile(filename: "/tmp/tmpka3lffuq/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpka3lffuq/tvm_kernels.maca", directory: "")
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
!73 = !DILocation(line: 163, column: 26, scope: !40)
!74 = !DILocation(line: 163, column: 24, scope: !40)
!75 = !DILocation(line: 1018, column: 9, scope: !76, inlinedAt: !78)
!76 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !77, file: !77, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!77 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!78 = distinct !DILocation(line: 165, column: 24, scope: !40)
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
!92 = !DILocation(line: 165, column: 22, scope: !40)
!93 = !DILocation(line: 1018, column: 9, scope: !76, inlinedAt: !94)
!94 = distinct !DILocation(line: 166, column: 24, scope: !40)
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
!106 = !DILocation(line: 166, column: 22, scope: !40)
!107 = !DILocation(line: 168, column: 34, scope: !40)
!108 = !DILocation(line: 168, column: 9, scope: !40)
!109 = !DILocation(line: 174, column: 5, scope: !40)
!110 = !DILocation(line: 174, column: 56, scope: !40)
!111 = !{!112, !112, i64 0}
!112 = !{!"float", !19, i64 0}
!113 = !DILocation(line: 175, column: 3, scope: !40)
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
!159 = distinct !DILocation(line: 157, column: 5, scope: !40)
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
!174 = !DILocation(line: 127, column: 49, scope: !40)
!175 = !DILocation(line: 137, column: 49, scope: !40)
!176 = !DILocation(line: 146, column: 50, scope: !40)
!177 = !DILocation(line: 159, column: 7, scope: !40)
!178 = !DILocation(line: 60, column: 3, scope: !156, inlinedAt: !179)
!179 = distinct !DILocation(line: 74, column: 3, scope: !158, inlinedAt: !180)
!180 = distinct !DILocation(line: 176, column: 3, scope: !40)
!181 = !DILocation(line: 61, column: 3, scope: !156, inlinedAt: !179)
!182 = !DILocation(line: 62, column: 3, scope: !156, inlinedAt: !179)
!183 = !DILocation(line: 177, column: 33, scope: !40)
!184 = !DILocation(line: 177, column: 7, scope: !40)
!185 = !DILocation(line: 178, column: 58, scope: !40)
!186 = !DILocation(line: 178, column: 14, scope: !40)
!187 = !DILocation(line: 68, column: 3, scope: !188, inlinedAt: !189)
!188 = distinct !DISubprogram(name: "__barrier_warp", scope: !77, file: !77, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!189 = distinct !DILocation(line: 192, column: 3, scope: !190, inlinedAt: !191)
!190 = distinct !DISubprogram(name: "__syncwarp", scope: !77, file: !77, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!191 = distinct !DILocation(line: 179, column: 5, scope: !40)
!192 = !DILocation(line: 69, column: 3, scope: !188, inlinedAt: !189)
!193 = !DILocation(line: 70, column: 3, scope: !188, inlinedAt: !189)
!194 = !DILocation(line: 182, column: 25, scope: !40)
!195 = !DILocation(line: 182, column: 42, scope: !40)
!196 = !DILocation(line: 182, column: 40, scope: !40)
!197 = !DILocation(line: 183, column: 42, scope: !40)
!198 = !DILocation(line: 183, column: 40, scope: !40)
!199 = !DILocation(line: 184, column: 42, scope: !40)
!200 = !DILocation(line: 184, column: 40, scope: !40)
!201 = !DILocation(line: 185, column: 40, scope: !40)
!202 = !DILocation(line: 75, column: 10, scope: !139, inlinedAt: !203)
!203 = distinct !DILocation(line: 984, column: 9, scope: !142, inlinedAt: !204)
!204 = distinct !DILocation(line: 133, column: 53, scope: !145, inlinedAt: !205)
!205 = distinct !DILocation(line: 186, column: 21, scope: !40)
!206 = !DILocation(line: 186, column: 18, scope: !40)
!207 = !DILocation(line: 190, column: 129, scope: !40)
!208 = !DILocation(line: 190, column: 157, scope: !40)
!209 = !DILocation(line: 190, column: 79, scope: !40)
!210 = !DILocation(line: 190, column: 163, scope: !40)
!211 = !DILocation(line: 190, column: 42, scope: !40)
!212 = !DILocation(line: 190, column: 206, scope: !40)
!213 = !DILocation(line: 190, column: 93, scope: !40)
!214 = !DILocation(line: 68, column: 3, scope: !188, inlinedAt: !215)
!215 = distinct !DILocation(line: 192, column: 3, scope: !190, inlinedAt: !216)
!216 = distinct !DILocation(line: 192, column: 5, scope: !40)
!217 = !DILocation(line: 69, column: 3, scope: !188, inlinedAt: !215)
!218 = !DILocation(line: 70, column: 3, scope: !188, inlinedAt: !215)
!219 = !DILocation(line: 194, column: 5, scope: !40)
!220 = !DILocation(line: 195, column: 176, scope: !40)
!221 = !DILocation(line: 195, column: 24, scope: !40)
!222 = !DILocation(line: 195, column: 139, scope: !40)
!223 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!224 = !{i32 2, i32 -1, i32 -1, i32 -1}
!225 = !DILocation(line: 195, column: 234, scope: !40)
!226 = !DILocation(line: 195, column: 103, scope: !40)
!227 = !DILocation(line: 198, column: 1, scope: !40)
