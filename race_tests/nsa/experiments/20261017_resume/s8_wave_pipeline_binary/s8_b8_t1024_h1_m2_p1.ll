; ModuleID = 'experiments/20261017_resume/s8_wave_pipeline_binary/s8_b8_t1024_h1_m2_p1.bc'
source_filename = "/tmp/tmp7xdt47y8/tvm_kernels.maca"
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
  %cond.i.i743 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64), !dbg !49
  %mul11 = shl nsw i32 %cond.i.i743, 4, !dbg !52
  %4 = or disjoint i64 %2, 1, !dbg !53
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4, !dbg !43
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !dbg !43, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i743.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64), !dbg !49
  %mul11.1 = shl nsw i32 %cond.i.i743.1, 4, !dbg !52
  %6 = or disjoint i64 %2, 2, !dbg !53
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6, !dbg !43
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !dbg !43, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i743.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64), !dbg !49
  %mul11.2 = shl nsw i32 %cond.i.i743.2, 4, !dbg !52
  %8 = or disjoint i64 %2, 3, !dbg !53
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8, !dbg !43
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !dbg !43, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i743.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64), !dbg !49
  %mul11.3 = shl nsw i32 %cond.i.i743.3, 4, !dbg !52
  %10 = or disjoint i64 %2, 4, !dbg !53
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10, !dbg !43
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !dbg !43, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i743.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64), !dbg !49
  %mul11.4 = shl nsw i32 %cond.i.i743.4, 4, !dbg !52
  %12 = or disjoint i64 %2, 5, !dbg !53
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12, !dbg !43
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !dbg !43, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i743.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64), !dbg !49
  %mul11.5 = shl nsw i32 %cond.i.i743.5, 4, !dbg !52
  %14 = or disjoint i64 %2, 6, !dbg !53
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14, !dbg !43
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !dbg !43, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i743.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64), !dbg !49
  %mul11.6 = shl nsw i32 %cond.i.i743.6, 4, !dbg !52
  %16 = or disjoint i64 %2, 7, !dbg !53
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16, !dbg !43
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !dbg !43, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i743.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64), !dbg !49
  %mul11.7 = shl nsw i32 %cond.i.i743.7, 4, !dbg !52
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
  %qr.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16, !dbg !64
  %qr.sroa.13.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !64
  %qr.sroa.13.0.copyload = load <4 x half>, ptr addrspace(4) %qr.sroa.13.0.add.ptr.sroa_idx, align 8, !dbg !64
  %23 = or disjoint i64 %20, %21, !dbg !62
  %24 = or disjoint i64 %23, 32, !dbg !62
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %24, !dbg !63
  %qr.sroa.23.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16, !dbg !64
  %qr.sroa.34.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr.1, i64 8, !dbg !64
  %qr.sroa.34.16.copyload = load <4 x half>, ptr addrspace(4) %qr.sroa.34.16.add.ptr.1.sroa_idx, align 8, !dbg !64
  br label %if.end, !dbg !65

if.end:                                           ; preds = %entry, %for.cond16.preheader
  %qr.sroa.34.0 = phi <4 x half> [ %qr.sroa.34.16.copyload, %for.cond16.preheader ], [ undef, %entry ]
  %qr.sroa.23.0 = phi <4 x half> [ %qr.sroa.23.16.copyload, %for.cond16.preheader ], [ undef, %entry ]
  %qr.sroa.13.0 = phi <4 x half> [ %qr.sroa.13.0.copyload, %for.cond16.preheader ], [ undef, %entry ]
  %qr.sroa.0.0 = phi <4 x half> [ %qr.sroa.0.0.copyload, %for.cond16.preheader ], [ undef, %entry ]
  %cmp108 = icmp ugt i32 %18, 63
  %shr285.mask = and i32 %18, 960
  %cmp286.not = icmp eq i32 %shr285.mask, 64
  %mul131 = shl nsw i32 %0, 16
  %and138 = shl nuw nsw i32 %18, 3
  %and275 = shl nuw nsw i32 %18, 2
  %invariant.op = add nsw i32 %1, -15
  %25 = lshr i32 %18, 2
  %mul182 = and i32 %25, 12
  %mul318 = and i32 %and138, 504
  %mul336 = and i32 %and275, 252
  %26 = zext nneg i32 %and138 to i64, !dbg !66
  %27 = zext nneg i32 %mul318 to i64, !dbg !66
  br i1 %cmp108, label %if.end441, label %for.cond111.preheader, !dbg !67

for.body453.preheader:                            ; preds = %if.end441.4
  %add457 = fadd contract float %sums.sroa.0.12, 0.000000e+00, !dbg !68
  %add457.1 = fadd contract float %add457, %sums.sroa.24.12, !dbg !68
  %add457.2 = fadd contract float %add457.1, %sums.sroa.46.12, !dbg !68
  %add457.3 = fadd contract float %add457.2, %sums.sroa.68.12, !dbg !68
  %28 = bitcast float %add457.3 to i32, !dbg !69
  %29 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !73
  %30 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %29) #11, !dbg !78
  %xor.i.i = xor i32 %30, 32, !dbg !79
  %31 = and i32 %30, -64, !dbg !80
  %and.i.i = add nsw i32 %31, 64, !dbg !80
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !81
  %cond.i.i744 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %30, !dbg !82
  %shl.i.i = shl i32 %cond.i.i744, 2, !dbg !83
  %32 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %28), !dbg !84
  %33 = bitcast i32 %32 to float, !dbg !85
  %add465 = fadd contract float %add457.3, %33, !dbg !86
  %34 = bitcast float %add465 to i32, !dbg !87
  %35 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !89
  %36 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %35) #11, !dbg !92
  %xor.i.i745 = xor i32 %36, 16, !dbg !93
  %37 = and i32 %36, -64, !dbg !94
  %and.i.i746 = add nsw i32 %37, 64, !dbg !94
  %cmp.not.i.i747 = icmp slt i32 %xor.i.i745, %and.i.i746, !dbg !95
  %cond.i.i748 = select i1 %cmp.not.i.i747, i32 %xor.i.i745, i32 %36, !dbg !96
  %shl.i.i749 = shl i32 %cond.i.i748, 2, !dbg !97
  %38 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i749, i32 %34), !dbg !98
  %39 = bitcast i32 %38 to float, !dbg !99
  %add470 = fadd contract float %add465, %39, !dbg !100
  %cmp473 = fcmp contract ogt float %add470, 0.000000e+00, !dbg !101
  %div = fdiv contract float 1.000000e+00, %add470, !dbg !102
  %condval_1.0 = select i1 %cmp473, float %div, float 0.000000e+00, !dbg !102
  %arrayidx483 = getelementptr inbounds float, ptr addrspace(3) @buf_dyn_shmem, i32 %18, !dbg !103
  store float %condval_1.0, ptr addrspace(3) %arrayidx483, align 4, !dbg !104, !tbaa !105
  br label %if.end484, !dbg !107

for.cond111.preheader:                            ; preds = %if.end
  %or.cond780 = icmp ugt i32 %mul11, 1023, !dbg !108
  %cmp124.not = icmp sgt i32 %mul11, %1
  %or.cond781 = or i1 %or.cond780, %cmp124.not, !dbg !108
  br i1 %or.cond781, label %if.end152, label %for.cond126.preheader, !dbg !108

for.cond126.preheader:                            ; preds = %for.cond111.preheader
  %40 = shl nsw i32 %cond.i.i743, 10
  %mul133 = and i32 %40, 64512
  %add134 = or disjoint i32 %mul133, %mul131
  %41 = zext nneg i32 %add134 to i64, !dbg !109
  %42 = or disjoint i64 %41, %26, !dbg !110
  %add.ptr142 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %42, !dbg !111
  %kr.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr142, align 16, !dbg !112
  %kr.sroa.12.0.add.ptr142.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142, i64 8, !dbg !112
  %kr.sroa.12.0.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.12.0.add.ptr142.sroa_idx, align 8, !dbg !112
  %43 = or disjoint i64 %41, %26, !dbg !110
  %44 = or disjoint i64 %43, 512, !dbg !110
  %add.ptr142.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %44, !dbg !111
  %kr.sroa.17.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr142.1, align 16, !dbg !112
  %kr.sroa.27.16.add.ptr142.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1, i64 8, !dbg !112
  %kr.sroa.27.16.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.27.16.add.ptr142.1.sroa_idx, align 8, !dbg !112
  br label %if.end152, !dbg !113

if.end152:                                        ; preds = %for.cond126.preheader, %for.cond111.preheader
  %kr.sroa.27.0 = phi <4 x half> [ undef, %for.cond111.preheader ], [ %kr.sroa.27.16.copyload, %for.cond126.preheader ]
  %kr.sroa.17.0 = phi <4 x half> [ undef, %for.cond111.preheader ], [ %kr.sroa.17.16.copyload, %for.cond126.preheader ]
  %kr.sroa.12.0 = phi <4 x half> [ undef, %for.cond111.preheader ], [ %kr.sroa.12.0.copyload, %for.cond126.preheader ]
  %kr.sroa.0.0 = phi <4 x half> [ undef, %for.cond111.preheader ], [ %kr.sroa.0.0.copyload, %for.cond126.preheader ]
  %or.cond780.1 = icmp ugt i32 %mul11.1, 1023, !dbg !108
  %cmp124.not.1 = icmp sgt i32 %mul11.1, %1
  %or.cond781.1 = or i1 %or.cond780.1, %cmp124.not.1, !dbg !108
  br i1 %or.cond781.1, label %if.end152.1, label %for.cond126.preheader.1, !dbg !108

for.cond126.preheader.1:                          ; preds = %if.end152
  %45 = shl nsw i32 %cond.i.i743.1, 10
  %mul133.1 = and i32 %45, 64512
  %add134.1 = or disjoint i32 %mul133.1, %mul131
  %46 = zext nneg i32 %add134.1 to i64, !dbg !109
  %47 = or disjoint i64 %46, %26, !dbg !110
  %add.ptr142.1801 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %47, !dbg !111
  %kr.sroa.32.32.copyload = load <4 x half>, ptr addrspace(4) %add.ptr142.1801, align 16, !dbg !112
  %kr.sroa.42.32.add.ptr142.1801.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1801, i64 8, !dbg !112
  %kr.sroa.42.32.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.42.32.add.ptr142.1801.sroa_idx, align 8, !dbg !112
  %48 = or disjoint i64 %46, %26, !dbg !110
  %49 = or disjoint i64 %48, 512, !dbg !110
  %add.ptr142.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %49, !dbg !111
  %kr.sroa.47.48.copyload = load <4 x half>, ptr addrspace(4) %add.ptr142.1.1, align 16, !dbg !112
  %kr.sroa.57.48.add.ptr142.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1.1, i64 8, !dbg !112
  %kr.sroa.57.48.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.57.48.add.ptr142.1.1.sroa_idx, align 8, !dbg !112
  br label %if.end152.1, !dbg !113

if.end152.1:                                      ; preds = %for.cond126.preheader.1, %if.end152
  %kr.sroa.57.0 = phi <4 x half> [ undef, %if.end152 ], [ %kr.sroa.57.48.copyload, %for.cond126.preheader.1 ]
  %kr.sroa.47.0 = phi <4 x half> [ undef, %if.end152 ], [ %kr.sroa.47.48.copyload, %for.cond126.preheader.1 ]
  %kr.sroa.42.0 = phi <4 x half> [ undef, %if.end152 ], [ %kr.sroa.42.32.copyload, %for.cond126.preheader.1 ]
  %kr.sroa.32.0 = phi <4 x half> [ undef, %if.end152 ], [ %kr.sroa.32.32.copyload, %for.cond126.preheader.1 ]
  br i1 %or.cond781, label %if.end267, label %if.then170, !dbg !114

if.then170:                                       ; preds = %if.end152.1
  %cmp173 = icmp sgt i32 %mul11, %invariant.op, !dbg !115
  br i1 %cmp173, label %for.cond175.preheader, label %if.end201, !dbg !116

for.cond175.preheader:                            ; preds = %if.then170
  %add183 = or disjoint i32 %mul11, %mul182
  %cmp186.not = icmp sgt i32 %add183, %1, !dbg !117
  %spec.select = select i1 %cmp186.not, float 0xFFF0000000000000, float 0.000000e+00, !dbg !118
  %scores.sroa.0.0.vec.insert1146 = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !119
  %cmp186.not.1.not = icmp slt i32 %add183, %1, !dbg !117
  %spec.select.1 = select i1 %cmp186.not.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !118
  %scores.sroa.0.4.vec.insert1261 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1146, float %spec.select.1, i64 1, !dbg !119
  %add184.2 = or disjoint i32 %add183, 2, !dbg !120
  %cmp186.not.2 = icmp sgt i32 %add184.2, %1, !dbg !117
  %spec.select.2 = select i1 %cmp186.not.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !118
  %scores.sroa.0.8.vec.insert1358 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1261, float %spec.select.2, i64 2, !dbg !119
  %add184.3 = or disjoint i32 %add183, 3, !dbg !120
  %cmp186.not.3 = icmp sgt i32 %add184.3, %1, !dbg !117
  %spec.select.3 = select i1 %cmp186.not.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !118
  %scores.sroa.0.12.vec.insert1455 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1358, float %spec.select.3, i64 3, !dbg !119
  br label %if.end201

if.end201:                                        ; preds = %if.then170, %for.cond175.preheader
  %scores.sroa.0.0 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1455, %for.cond175.preheader ], [ zeroinitializer, %if.then170 ], !dbg !121
  %50 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.0), !dbg !122
  %51 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.12.0, <4 x half> %qr.sroa.13.0, <4 x float> %50), !dbg !122
  %52 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.17.0, <4 x half> %qr.sroa.23.0, <4 x float> %51), !dbg !122
  %53 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.27.0, <4 x half> %qr.sroa.34.0, <4 x float> %52), !dbg !122
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %53, i64 0, !dbg !123
  %mul227 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !124
  %54 = tail call contract noundef float @llvm.minnum.f32(float %mul227, float 0x4024CB5EC0000000), !dbg !125
  %55 = tail call contract noundef float @llvm.exp.f32(float %54), !dbg !128
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %53, i64 1, !dbg !123
  %mul227.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !124
  %56 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1, float 0x4024CB5EC0000000), !dbg !125
  %57 = tail call contract noundef float @llvm.exp.f32(float %56), !dbg !128
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %53, i64 2, !dbg !123
  %mul227.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !124
  %58 = tail call contract noundef float @llvm.minnum.f32(float %mul227.2, float 0x4024CB5EC0000000), !dbg !125
  %59 = tail call contract noundef float @llvm.exp.f32(float %58), !dbg !128
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %53, i64 3, !dbg !123
  %mul227.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !124
  %60 = tail call contract noundef float @llvm.minnum.f32(float %mul227.3, float 0x4024CB5EC0000000), !dbg !125
  %61 = tail call contract noundef float @llvm.exp.f32(float %60), !dbg !128
  %62 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %55), !dbg !131
  %probs.sroa.0.0.vec.insert = insertelement <4 x i16> poison, i16 %62, i64 0, !dbg !140
  %63 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %57), !dbg !131
  %probs.sroa.0.2.vec.insert = insertelement <4 x i16> %probs.sroa.0.0.vec.insert, i16 %63, i64 1, !dbg !140
  %64 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %59), !dbg !131
  %probs.sroa.0.4.vec.insert = insertelement <4 x i16> %probs.sroa.0.2.vec.insert, i16 %64, i64 2, !dbg !140
  %65 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %61), !dbg !131
  %probs.sroa.0.6.vec.insert = insertelement <4 x i16> %probs.sroa.0.4.vec.insert, i16 %65, i64 3, !dbg !140
  br label %if.end267, !dbg !141

if.end267:                                        ; preds = %if.end152.1, %if.end201
  %sums.sroa.68.1 = phi float [ %61, %if.end201 ], [ 0.000000e+00, %if.end152.1 ], !dbg !121
  %sums.sroa.46.1 = phi float [ %59, %if.end201 ], [ 0.000000e+00, %if.end152.1 ], !dbg !121
  %sums.sroa.24.1 = phi float [ %57, %if.end201 ], [ 0.000000e+00, %if.end152.1 ], !dbg !121
  %sums.sroa.0.1 = phi float [ %55, %if.end201 ], [ 0.000000e+00, %if.end152.1 ], !dbg !121
  %probs.sroa.0.0 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert, %if.end201 ], [ zeroinitializer, %if.end152.1 ], !dbg !121
  %add.ptr279 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and275, !dbg !142
  store <4 x i16> %probs.sroa.0.0, ptr addrspace(3) %add.ptr279, align 8, !dbg !143
  br i1 %or.cond781.1, label %if.end267.1, label %if.then170.1, !dbg !114

if.then170.1:                                     ; preds = %if.end267
  %cmp173.1 = icmp sgt i32 %mul11.1, %invariant.op, !dbg !115
  br i1 %cmp173.1, label %for.cond175.preheader.1, label %if.end201.1, !dbg !116

for.cond175.preheader.1:                          ; preds = %if.then170.1
  %add183.1 = or disjoint i32 %mul11.1, %mul182
  %cmp186.not.1804 = icmp sgt i32 %add183.1, %1, !dbg !117
  %spec.select.1805 = select i1 %cmp186.not.1804, float 0xFFF0000000000000, float 0.000000e+00, !dbg !118
  %scores.sroa.0.0.vec.insert1155 = insertelement <4 x float> poison, float %spec.select.1805, i64 0, !dbg !119
  %cmp186.not.1.1.not = icmp slt i32 %add183.1, %1, !dbg !117
  %spec.select.1.1 = select i1 %cmp186.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !118
  %scores.sroa.0.4.vec.insert1268 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1155, float %spec.select.1.1, i64 1, !dbg !119
  %add184.2.1 = or disjoint i32 %add183.1, 2, !dbg !120
  %cmp186.not.2.1 = icmp sgt i32 %add184.2.1, %1, !dbg !117
  %spec.select.2.1 = select i1 %cmp186.not.2.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !118
  %scores.sroa.0.8.vec.insert1365 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1268, float %spec.select.2.1, i64 2, !dbg !119
  %add184.3.1 = or disjoint i32 %add183.1, 3, !dbg !120
  %cmp186.not.3.1 = icmp sgt i32 %add184.3.1, %1, !dbg !117
  %spec.select.3.1 = select i1 %cmp186.not.3.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !118
  %scores.sroa.0.12.vec.insert1462 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1365, float %spec.select.3.1, i64 3, !dbg !119
  br label %if.end201.1

if.end201.1:                                      ; preds = %if.then170.1, %for.cond175.preheader.1
  %scores.sroa.0.2 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1462, %for.cond175.preheader.1 ], [ zeroinitializer, %if.then170.1 ], !dbg !121
  %66 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.32.0, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.2), !dbg !122
  %67 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.42.0, <4 x half> %qr.sroa.13.0, <4 x float> %66), !dbg !122
  %68 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.0, <4 x half> %qr.sroa.23.0, <4 x float> %67), !dbg !122
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.57.0, <4 x half> %qr.sroa.34.0, <4 x float> %68), !dbg !122
  %scores.sroa.0.0.vec.extract1157 = extractelement <4 x float> %69, i64 0, !dbg !123
  %mul227.1808 = fmul contract float %scores.sroa.0.0.vec.extract1157, 0x3FB99999A0000000, !dbg !124
  %70 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1808, float 0x4024CB5EC0000000), !dbg !125
  %71 = tail call contract noundef float @llvm.exp.f32(float %70), !dbg !128
  %scores.sroa.0.4.vec.extract1270 = extractelement <4 x float> %69, i64 1, !dbg !123
  %mul227.1.1 = fmul contract float %scores.sroa.0.4.vec.extract1270, 0x3FB99999A0000000, !dbg !124
  %72 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1.1, float 0x4024CB5EC0000000), !dbg !125
  %73 = tail call contract noundef float @llvm.exp.f32(float %72), !dbg !128
  %scores.sroa.0.8.vec.extract1367 = extractelement <4 x float> %69, i64 2, !dbg !123
  %mul227.2.1 = fmul contract float %scores.sroa.0.8.vec.extract1367, 0x3FB99999A0000000, !dbg !124
  %74 = tail call contract noundef float @llvm.minnum.f32(float %mul227.2.1, float 0x4024CB5EC0000000), !dbg !125
  %75 = tail call contract noundef float @llvm.exp.f32(float %74), !dbg !128
  %scores.sroa.0.12.vec.extract1464 = extractelement <4 x float> %69, i64 3, !dbg !123
  %mul227.3.1 = fmul contract float %scores.sroa.0.12.vec.extract1464, 0x3FB99999A0000000, !dbg !124
  %76 = tail call contract noundef float @llvm.minnum.f32(float %mul227.3.1, float 0x4024CB5EC0000000), !dbg !125
  %77 = tail call contract noundef float @llvm.exp.f32(float %76), !dbg !128
  %add243.1809 = fadd contract float %sums.sroa.0.1, %71, !dbg !144
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %71), !dbg !131
  %probs.sroa.0.0.vec.insert1593 = insertelement <4 x i16> poison, i16 %78, i64 0, !dbg !140
  %add243.1.1 = fadd contract float %sums.sroa.24.1, %73, !dbg !144
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %73), !dbg !131
  %probs.sroa.0.2.vec.insert1631 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1593, i16 %79, i64 1, !dbg !140
  %add243.2.1 = fadd contract float %sums.sroa.46.1, %75, !dbg !144
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %75), !dbg !131
  %probs.sroa.0.4.vec.insert1668 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1631, i16 %80, i64 2, !dbg !140
  %add243.3.1 = fadd contract float %sums.sroa.68.1, %77, !dbg !144
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %77), !dbg !131
  %probs.sroa.0.6.vec.insert1686 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1668, i16 %81, i64 3, !dbg !140
  br label %if.end267.1, !dbg !141

if.end267.1:                                      ; preds = %if.end267, %if.end201.1
  %sums.sroa.68.2 = phi float [ %add243.3.1, %if.end201.1 ], [ %sums.sroa.68.1, %if.end267 ], !dbg !121
  %sums.sroa.46.2 = phi float [ %add243.2.1, %if.end201.1 ], [ %sums.sroa.46.1, %if.end267 ], !dbg !121
  %sums.sroa.24.2 = phi float [ %add243.1.1, %if.end201.1 ], [ %sums.sroa.24.1, %if.end267 ], !dbg !121
  %sums.sroa.0.2 = phi float [ %add243.1809, %if.end201.1 ], [ %sums.sroa.0.1, %if.end267 ], !dbg !121
  %probs.sroa.0.1 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1686, %if.end201.1 ], [ zeroinitializer, %if.end267 ], !dbg !121
  %add277.1 = or disjoint i32 %and275, 256, !dbg !145
  %add.ptr279.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add277.1, !dbg !142
  store <4 x i16> %probs.sroa.0.1, ptr addrspace(3) %add.ptr279.1, align 8, !dbg !143
  br label %if.end441

if.end441:                                        ; preds = %if.end, %if.end267.1
  %sums.sroa.68.3 = phi float [ 0.000000e+00, %if.end ], [ %sums.sroa.68.2, %if.end267.1 ], !dbg !146
  %sums.sroa.46.3 = phi float [ 0.000000e+00, %if.end ], [ %sums.sroa.46.2, %if.end267.1 ], !dbg !146
  %sums.sroa.24.3 = phi float [ 0.000000e+00, %if.end ], [ %sums.sroa.24.2, %if.end267.1 ], !dbg !146
  %sums.sroa.0.3 = phi float [ 0.000000e+00, %if.end ], [ %sums.sroa.0.2, %if.end267.1 ], !dbg !146
  %kr.sroa.57.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.57.0, %if.end267.1 ]
  %kr.sroa.47.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.47.0, %if.end267.1 ]
  %kr.sroa.42.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.42.0, %if.end267.1 ]
  %kr.sroa.32.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.32.0, %if.end267.1 ]
  %kr.sroa.27.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.27.0, %if.end267.1 ]
  %kr.sroa.17.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.17.0, %if.end267.1 ]
  %kr.sroa.12.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.12.0, %if.end267.1 ]
  %kr.sroa.0.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.0.0, %if.end267.1 ]
  fence syncscope("block") release, !dbg !147
  tail call void @llvm.mxc.barrier(), !dbg !152
  fence syncscope("block") acquire, !dbg !153
  br i1 %cmp108, label %if.end283.1, label %for.cond111.preheader.1, !dbg !67

for.cond111.preheader.1:                          ; preds = %if.end441
  %or.cond780.1817 = icmp ugt i32 %mul11.2, 1023, !dbg !108
  %cmp124.not.1818 = icmp sgt i32 %mul11.2, %1
  %or.cond781.1819 = or i1 %or.cond780.1817, %cmp124.not.1818, !dbg !108
  br i1 %or.cond781.1819, label %if.end152.1826, label %for.cond126.preheader.1822, !dbg !108

for.cond126.preheader.1822:                       ; preds = %for.cond111.preheader.1
  %82 = shl nsw i32 %cond.i.i743.2, 10
  %mul133.1820 = and i32 %82, 64512
  %add134.1821 = or disjoint i32 %mul133.1820, %mul131
  %83 = zext nneg i32 %add134.1821 to i64, !dbg !109
  %84 = or disjoint i64 %83, %26, !dbg !110
  %add.ptr142.1823 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %84, !dbg !111
  %kr.sroa.0.0.copyload1707 = load <4 x half>, ptr addrspace(4) %add.ptr142.1823, align 16, !dbg !112
  %kr.sroa.12.0.add.ptr142.1823.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1823, i64 8, !dbg !112
  %kr.sroa.12.0.copyload1711 = load <4 x half>, ptr addrspace(4) %kr.sroa.12.0.add.ptr142.1823.sroa_idx, align 8, !dbg !112
  %85 = or disjoint i64 %83, %26, !dbg !110
  %86 = or disjoint i64 %85, 512, !dbg !110
  %add.ptr142.1.1824 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %86, !dbg !111
  %kr.sroa.17.16.copyload1723 = load <4 x half>, ptr addrspace(4) %add.ptr142.1.1824, align 16, !dbg !112
  %kr.sroa.27.16.add.ptr142.1.1824.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1.1824, i64 8, !dbg !112
  %kr.sroa.27.16.copyload1727 = load <4 x half>, ptr addrspace(4) %kr.sroa.27.16.add.ptr142.1.1824.sroa_idx, align 8, !dbg !112
  br label %if.end152.1826, !dbg !113

if.end152.1826:                                   ; preds = %for.cond126.preheader.1822, %for.cond111.preheader.1
  %kr.sroa.27.2 = phi <4 x half> [ %kr.sroa.27.1, %for.cond111.preheader.1 ], [ %kr.sroa.27.16.copyload1727, %for.cond126.preheader.1822 ]
  %kr.sroa.17.2 = phi <4 x half> [ %kr.sroa.17.1, %for.cond111.preheader.1 ], [ %kr.sroa.17.16.copyload1723, %for.cond126.preheader.1822 ]
  %kr.sroa.12.2 = phi <4 x half> [ %kr.sroa.12.1, %for.cond111.preheader.1 ], [ %kr.sroa.12.0.copyload1711, %for.cond126.preheader.1822 ]
  %kr.sroa.0.2 = phi <4 x half> [ %kr.sroa.0.1, %for.cond111.preheader.1 ], [ %kr.sroa.0.0.copyload1707, %for.cond126.preheader.1822 ]
  %or.cond780.1.1 = icmp ugt i32 %mul11.3, 1023, !dbg !108
  %cmp124.not.1.1 = icmp sgt i32 %mul11.3, %1
  %or.cond781.1.1 = or i1 %or.cond780.1.1, %cmp124.not.1.1, !dbg !108
  br i1 %or.cond781.1.1, label %if.end152.1.1, label %for.cond126.preheader.1.1, !dbg !108

for.cond126.preheader.1.1:                        ; preds = %if.end152.1826
  %87 = shl nsw i32 %cond.i.i743.3, 10
  %mul133.1.1 = and i32 %87, 64512
  %add134.1.1 = or disjoint i32 %mul133.1.1, %mul131
  %88 = zext nneg i32 %add134.1.1 to i64, !dbg !109
  %89 = or disjoint i64 %88, %26, !dbg !110
  %add.ptr142.1801.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %89, !dbg !111
  %kr.sroa.32.32.copyload1739 = load <4 x half>, ptr addrspace(4) %add.ptr142.1801.1, align 16, !dbg !112
  %kr.sroa.42.32.add.ptr142.1801.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1801.1, i64 8, !dbg !112
  %kr.sroa.42.32.copyload1743 = load <4 x half>, ptr addrspace(4) %kr.sroa.42.32.add.ptr142.1801.1.sroa_idx, align 8, !dbg !112
  %90 = or disjoint i64 %88, %26, !dbg !110
  %91 = or disjoint i64 %90, 512, !dbg !110
  %add.ptr142.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %91, !dbg !111
  %kr.sroa.47.48.copyload1755 = load <4 x half>, ptr addrspace(4) %add.ptr142.1.1.1, align 16, !dbg !112
  %kr.sroa.57.48.add.ptr142.1.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1.1.1, i64 8, !dbg !112
  %kr.sroa.57.48.copyload1759 = load <4 x half>, ptr addrspace(4) %kr.sroa.57.48.add.ptr142.1.1.1.sroa_idx, align 8, !dbg !112
  br label %if.end152.1.1, !dbg !113

if.end152.1.1:                                    ; preds = %for.cond126.preheader.1.1, %if.end152.1826
  %kr.sroa.57.2 = phi <4 x half> [ %kr.sroa.57.1, %if.end152.1826 ], [ %kr.sroa.57.48.copyload1759, %for.cond126.preheader.1.1 ]
  %kr.sroa.47.2 = phi <4 x half> [ %kr.sroa.47.1, %if.end152.1826 ], [ %kr.sroa.47.48.copyload1755, %for.cond126.preheader.1.1 ]
  %kr.sroa.42.2 = phi <4 x half> [ %kr.sroa.42.1, %if.end152.1826 ], [ %kr.sroa.42.32.copyload1743, %for.cond126.preheader.1.1 ]
  %kr.sroa.32.2 = phi <4 x half> [ %kr.sroa.32.1, %if.end152.1826 ], [ %kr.sroa.32.32.copyload1739, %for.cond126.preheader.1.1 ]
  br i1 %or.cond781.1819, label %if.end267.1882, label %if.then170.1832, !dbg !114

if.then170.1832:                                  ; preds = %if.end152.1.1
  %cmp173.1831 = icmp sgt i32 %mul11.2, %invariant.op, !dbg !115
  br i1 %cmp173.1831, label %for.cond175.preheader.1835, label %if.end201.1852, !dbg !116

for.cond175.preheader.1835:                       ; preds = %if.then170.1832
  %add183.1834 = or disjoint i32 %mul11.2, %mul182
  %cmp186.not.1836 = icmp sgt i32 %add183.1834, %1, !dbg !117
  %spec.select.1837 = select i1 %cmp186.not.1836, float 0xFFF0000000000000, float 0.000000e+00, !dbg !118
  %scores.sroa.0.0.vec.insert1165 = insertelement <4 x float> poison, float %spec.select.1837, i64 0, !dbg !119
  %cmp186.not.1.1839.not = icmp slt i32 %add183.1834, %1, !dbg !117
  %spec.select.1.1840 = select i1 %cmp186.not.1.1839.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !118
  %scores.sroa.0.4.vec.insert1276 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1165, float %spec.select.1.1840, i64 1, !dbg !119
  %add184.2.1842 = or disjoint i32 %add183.1834, 2, !dbg !120
  %cmp186.not.2.1843 = icmp sgt i32 %add184.2.1842, %1, !dbg !117
  %spec.select.2.1844 = select i1 %cmp186.not.2.1843, float 0xFFF0000000000000, float 0.000000e+00, !dbg !118
  %scores.sroa.0.8.vec.insert1373 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1276, float %spec.select.2.1844, i64 2, !dbg !119
  %add184.3.1846 = or disjoint i32 %add183.1834, 3, !dbg !120
  %cmp186.not.3.1847 = icmp sgt i32 %add184.3.1846, %1, !dbg !117
  %spec.select.3.1848 = select i1 %cmp186.not.3.1847, float 0xFFF0000000000000, float 0.000000e+00, !dbg !118
  %scores.sroa.0.12.vec.insert1470 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1373, float %spec.select.3.1848, i64 3, !dbg !119
  br label %if.end201.1852

if.end201.1852:                                   ; preds = %if.then170.1832, %for.cond175.preheader.1835
  %scores.sroa.0.5 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1470, %for.cond175.preheader.1835 ], [ zeroinitializer, %if.then170.1832 ], !dbg !121
  %92 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.2, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.5), !dbg !122
  %93 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.12.2, <4 x half> %qr.sroa.13.0, <4 x float> %92), !dbg !122
  %94 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.17.2, <4 x half> %qr.sroa.23.0, <4 x float> %93), !dbg !122
  %95 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.27.2, <4 x half> %qr.sroa.34.0, <4 x float> %94), !dbg !122
  %scores.sroa.0.0.vec.extract1167 = extractelement <4 x float> %95, i64 0, !dbg !123
  %mul227.1857 = fmul contract float %scores.sroa.0.0.vec.extract1167, 0x3FB99999A0000000, !dbg !124
  %96 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1857, float 0x4024CB5EC0000000), !dbg !125
  %97 = tail call contract noundef float @llvm.exp.f32(float %96), !dbg !128
  %scores.sroa.0.4.vec.extract1278 = extractelement <4 x float> %95, i64 1, !dbg !123
  %mul227.1.1859 = fmul contract float %scores.sroa.0.4.vec.extract1278, 0x3FB99999A0000000, !dbg !124
  %98 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1.1859, float 0x4024CB5EC0000000), !dbg !125
  %99 = tail call contract noundef float @llvm.exp.f32(float %98), !dbg !128
  %scores.sroa.0.8.vec.extract1375 = extractelement <4 x float> %95, i64 2, !dbg !123
  %mul227.2.1861 = fmul contract float %scores.sroa.0.8.vec.extract1375, 0x3FB99999A0000000, !dbg !124
  %100 = tail call contract noundef float @llvm.minnum.f32(float %mul227.2.1861, float 0x4024CB5EC0000000), !dbg !125
  %101 = tail call contract noundef float @llvm.exp.f32(float %100), !dbg !128
  %scores.sroa.0.12.vec.extract1472 = extractelement <4 x float> %95, i64 3, !dbg !123
  %mul227.3.1863 = fmul contract float %scores.sroa.0.12.vec.extract1472, 0x3FB99999A0000000, !dbg !124
  %102 = tail call contract noundef float @llvm.minnum.f32(float %mul227.3.1863, float 0x4024CB5EC0000000), !dbg !125
  %103 = tail call contract noundef float @llvm.exp.f32(float %102), !dbg !128
  %add243.1865 = fadd contract float %sums.sroa.0.3, %97, !dbg !144
  %104 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %97), !dbg !131
  %probs.sroa.0.0.vec.insert1595 = insertelement <4 x i16> poison, i16 %104, i64 0, !dbg !140
  %add243.1.1868 = fadd contract float %sums.sroa.24.3, %99, !dbg !144
  %105 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %99), !dbg !131
  %probs.sroa.0.2.vec.insert1633 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1595, i16 %105, i64 1, !dbg !140
  %add243.2.1872 = fadd contract float %sums.sroa.46.3, %101, !dbg !144
  %106 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %101), !dbg !131
  %probs.sroa.0.4.vec.insert1670 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1633, i16 %106, i64 2, !dbg !140
  %add243.3.1876 = fadd contract float %sums.sroa.68.3, %103, !dbg !144
  %107 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %103), !dbg !131
  %probs.sroa.0.6.vec.insert1688 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1670, i16 %107, i64 3, !dbg !140
  br label %if.end267.1882, !dbg !141

if.end267.1882:                                   ; preds = %if.end152.1.1, %if.end201.1852
  %sums.sroa.68.4 = phi float [ %add243.3.1876, %if.end201.1852 ], [ %sums.sroa.68.3, %if.end152.1.1 ], !dbg !121
  %sums.sroa.46.4 = phi float [ %add243.2.1872, %if.end201.1852 ], [ %sums.sroa.46.3, %if.end152.1.1 ], !dbg !121
  %sums.sroa.24.4 = phi float [ %add243.1.1868, %if.end201.1852 ], [ %sums.sroa.24.3, %if.end152.1.1 ], !dbg !121
  %sums.sroa.0.4 = phi float [ %add243.1865, %if.end201.1852 ], [ %sums.sroa.0.3, %if.end152.1.1 ], !dbg !121
  %probs.sroa.0.6 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1688, %if.end201.1852 ], [ zeroinitializer, %if.end152.1.1 ], !dbg !121
  %add277.1880 = or disjoint i32 %and275, 512, !dbg !145
  %add.ptr279.1881 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add277.1880, !dbg !142
  store <4 x i16> %probs.sroa.0.6, ptr addrspace(3) %add.ptr279.1881, align 8, !dbg !143
  br i1 %or.cond781.1.1, label %if.end267.1.1, label %if.then170.1.1, !dbg !114

if.then170.1.1:                                   ; preds = %if.end267.1882
  %cmp173.1.1 = icmp sgt i32 %mul11.3, %invariant.op, !dbg !115
  br i1 %cmp173.1.1, label %for.cond175.preheader.1.1, label %if.end201.1.1, !dbg !116

for.cond175.preheader.1.1:                        ; preds = %if.then170.1.1
  %add183.1.1 = or disjoint i32 %mul11.3, %mul182
  %cmp186.not.1804.1 = icmp sgt i32 %add183.1.1, %1, !dbg !117
  %spec.select.1805.1 = select i1 %cmp186.not.1804.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !118
  %scores.sroa.0.0.vec.insert1175 = insertelement <4 x float> poison, float %spec.select.1805.1, i64 0, !dbg !119
  %cmp186.not.1.1.1.not = icmp slt i32 %add183.1.1, %1, !dbg !117
  %spec.select.1.1.1 = select i1 %cmp186.not.1.1.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !118
  %scores.sroa.0.4.vec.insert1284 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1175, float %spec.select.1.1.1, i64 1, !dbg !119
  %add184.2.1.1 = or disjoint i32 %add183.1.1, 2, !dbg !120
  %cmp186.not.2.1.1 = icmp sgt i32 %add184.2.1.1, %1, !dbg !117
  %spec.select.2.1.1 = select i1 %cmp186.not.2.1.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !118
  %scores.sroa.0.8.vec.insert1381 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1284, float %spec.select.2.1.1, i64 2, !dbg !119
  %add184.3.1.1 = or disjoint i32 %add183.1.1, 3, !dbg !120
  %cmp186.not.3.1.1 = icmp sgt i32 %add184.3.1.1, %1, !dbg !117
  %spec.select.3.1.1 = select i1 %cmp186.not.3.1.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !118
  %scores.sroa.0.12.vec.insert1478 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1381, float %spec.select.3.1.1, i64 3, !dbg !119
  br label %if.end201.1.1

if.end201.1.1:                                    ; preds = %if.then170.1.1, %for.cond175.preheader.1.1
  %scores.sroa.0.7 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1478, %for.cond175.preheader.1.1 ], [ zeroinitializer, %if.then170.1.1 ], !dbg !121
  %108 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.32.2, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.7), !dbg !122
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.42.2, <4 x half> %qr.sroa.13.0, <4 x float> %108), !dbg !122
  %110 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.2, <4 x half> %qr.sroa.23.0, <4 x float> %109), !dbg !122
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.57.2, <4 x half> %qr.sroa.34.0, <4 x float> %110), !dbg !122
  %scores.sroa.0.0.vec.extract1177 = extractelement <4 x float> %111, i64 0, !dbg !123
  %mul227.1808.1 = fmul contract float %scores.sroa.0.0.vec.extract1177, 0x3FB99999A0000000, !dbg !124
  %112 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1808.1, float 0x4024CB5EC0000000), !dbg !125
  %113 = tail call contract noundef float @llvm.exp.f32(float %112), !dbg !128
  %scores.sroa.0.4.vec.extract1286 = extractelement <4 x float> %111, i64 1, !dbg !123
  %mul227.1.1.1 = fmul contract float %scores.sroa.0.4.vec.extract1286, 0x3FB99999A0000000, !dbg !124
  %114 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1.1.1, float 0x4024CB5EC0000000), !dbg !125
  %115 = tail call contract noundef float @llvm.exp.f32(float %114), !dbg !128
  %scores.sroa.0.8.vec.extract1383 = extractelement <4 x float> %111, i64 2, !dbg !123
  %mul227.2.1.1 = fmul contract float %scores.sroa.0.8.vec.extract1383, 0x3FB99999A0000000, !dbg !124
  %116 = tail call contract noundef float @llvm.minnum.f32(float %mul227.2.1.1, float 0x4024CB5EC0000000), !dbg !125
  %117 = tail call contract noundef float @llvm.exp.f32(float %116), !dbg !128
  %scores.sroa.0.12.vec.extract1480 = extractelement <4 x float> %111, i64 3, !dbg !123
  %mul227.3.1.1 = fmul contract float %scores.sroa.0.12.vec.extract1480, 0x3FB99999A0000000, !dbg !124
  %118 = tail call contract noundef float @llvm.minnum.f32(float %mul227.3.1.1, float 0x4024CB5EC0000000), !dbg !125
  %119 = tail call contract noundef float @llvm.exp.f32(float %118), !dbg !128
  %add243.1809.1 = fadd contract float %sums.sroa.0.4, %113, !dbg !144
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %113), !dbg !131
  %probs.sroa.0.0.vec.insert1597 = insertelement <4 x i16> poison, i16 %120, i64 0, !dbg !140
  %add243.1.1.1 = fadd contract float %sums.sroa.24.4, %115, !dbg !144
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %115), !dbg !131
  %probs.sroa.0.2.vec.insert1635 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1597, i16 %121, i64 1, !dbg !140
  %add243.2.1.1 = fadd contract float %sums.sroa.46.4, %117, !dbg !144
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %117), !dbg !131
  %probs.sroa.0.4.vec.insert1672 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1635, i16 %122, i64 2, !dbg !140
  %add243.3.1.1 = fadd contract float %sums.sroa.68.4, %119, !dbg !144
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %119), !dbg !131
  %probs.sroa.0.6.vec.insert1690 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1672, i16 %123, i64 3, !dbg !140
  br label %if.end267.1.1, !dbg !141

if.end267.1.1:                                    ; preds = %if.end267.1882, %if.end201.1.1
  %sums.sroa.68.5 = phi float [ %add243.3.1.1, %if.end201.1.1 ], [ %sums.sroa.68.4, %if.end267.1882 ], !dbg !121
  %sums.sroa.46.5 = phi float [ %add243.2.1.1, %if.end201.1.1 ], [ %sums.sroa.46.4, %if.end267.1882 ], !dbg !121
  %sums.sroa.24.5 = phi float [ %add243.1.1.1, %if.end201.1.1 ], [ %sums.sroa.24.4, %if.end267.1882 ], !dbg !121
  %sums.sroa.0.5 = phi float [ %add243.1809.1, %if.end201.1.1 ], [ %sums.sroa.0.4, %if.end267.1882 ], !dbg !121
  %probs.sroa.0.7 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1690, %if.end201.1.1 ], [ zeroinitializer, %if.end267.1882 ], !dbg !121
  %add277.1.1 = or disjoint i32 %and275, 768, !dbg !145
  %add.ptr279.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add277.1.1, !dbg !142
  store <4 x i16> %probs.sroa.0.7, ptr addrspace(3) %add.ptr279.1.1, align 8, !dbg !143
  br label %if.end283.1

if.end283.1:                                      ; preds = %if.end267.1.1, %if.end441
  %sums.sroa.68.6 = phi float [ %sums.sroa.68.3, %if.end441 ], [ %sums.sroa.68.5, %if.end267.1.1 ], !dbg !146
  %sums.sroa.46.6 = phi float [ %sums.sroa.46.3, %if.end441 ], [ %sums.sroa.46.5, %if.end267.1.1 ], !dbg !146
  %sums.sroa.24.6 = phi float [ %sums.sroa.24.3, %if.end441 ], [ %sums.sroa.24.5, %if.end267.1.1 ], !dbg !146
  %sums.sroa.0.6 = phi float [ %sums.sroa.0.3, %if.end441 ], [ %sums.sroa.0.5, %if.end267.1.1 ], !dbg !146
  %kr.sroa.57.3 = phi <4 x half> [ %kr.sroa.57.1, %if.end441 ], [ %kr.sroa.57.2, %if.end267.1.1 ]
  %kr.sroa.47.3 = phi <4 x half> [ %kr.sroa.47.1, %if.end441 ], [ %kr.sroa.47.2, %if.end267.1.1 ]
  %kr.sroa.42.3 = phi <4 x half> [ %kr.sroa.42.1, %if.end441 ], [ %kr.sroa.42.2, %if.end267.1.1 ]
  %kr.sroa.32.3 = phi <4 x half> [ %kr.sroa.32.1, %if.end441 ], [ %kr.sroa.32.2, %if.end267.1.1 ]
  %kr.sroa.27.3 = phi <4 x half> [ %kr.sroa.27.1, %if.end441 ], [ %kr.sroa.27.2, %if.end267.1.1 ]
  %kr.sroa.17.3 = phi <4 x half> [ %kr.sroa.17.1, %if.end441 ], [ %kr.sroa.17.2, %if.end267.1.1 ]
  %kr.sroa.12.3 = phi <4 x half> [ %kr.sroa.12.1, %if.end441 ], [ %kr.sroa.12.2, %if.end267.1.1 ]
  %kr.sroa.0.3 = phi <4 x half> [ %kr.sroa.0.1, %if.end441 ], [ %kr.sroa.0.2, %if.end267.1.1 ]
  br i1 %cmp286.not, label %for.cond290.preheader.1, label %if.end441.1, !dbg !154

for.cond290.preheader.1:                          ; preds = %if.end283.1
  %or.cond784.1885 = icmp ugt i32 %mul11, 1023, !dbg !155
  %cmp303.not.1886 = icmp sgt i32 %mul11, %1
  %or.cond785.1887 = or i1 %or.cond784.1885, %cmp303.not.1886, !dbg !155
  br i1 %or.cond785.1887, label %if.end437.1930, label %for.cond347.preheader.1922, !dbg !155

for.cond347.preheader.1922:                       ; preds = %for.cond290.preheader.1
  %add.ptr339.1895 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul336, !dbg !156
  %124 = load <4 x half>, ptr addrspace(3) %add.ptr339.1895, align 8, !dbg !157
  %125 = shl nsw i32 %cond.i.i743, 10
  %mul312.1888 = and i32 %125, 64512
  %add313.1889 = or disjoint i32 %mul312.1888, %mul131
  %126 = zext nneg i32 %add313.1889 to i64, !dbg !158
  %127 = or disjoint i64 %126, %27, !dbg !159
  %128 = or disjoint i64 %127, 512, !dbg !159
  %add.ptr321.1.1892 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %128, !dbg !160
  %vr.sroa.142.16.add.ptr321.1.1892.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.1.1892, i64 8, !dbg !161
  %vr.sroa.142.16.copyload1088 = load <4 x half>, ptr addrspace(4) %vr.sroa.142.16.add.ptr321.1.1892.sroa_idx, align 8, !dbg !161
  %vr.sroa.92.16.copyload1079 = load <4 x half>, ptr addrspace(4) %add.ptr321.1.1892, align 16, !dbg !161
  %129 = or disjoint i64 %126, %27, !dbg !159
  %add.ptr321.1891 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %129, !dbg !160
  %vr.sroa.52.0.add.ptr321.1891.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.1891, i64 8, !dbg !161
  %vr.sroa.52.0.copyload992 = load <4 x half>, ptr addrspace(4) %vr.sroa.52.0.add.ptr321.1891.sroa_idx, align 8, !dbg !161
  %vr.sroa.0.0.copyload983 = load <4 x half>, ptr addrspace(4) %add.ptr321.1891, align 16, !dbg !161
  %130 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload983, <4 x half> %124, <4 x float> zeroinitializer), !dbg !162, !call_argsrelate !163
  %131 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.52.0.copyload992, <4 x half> %124, <4 x float> zeroinitializer), !dbg !162, !call_argsrelate !163
  %132 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.92.16.copyload1079, <4 x half> %124, <4 x float> zeroinitializer), !dbg !162, !call_argsrelate !163
  %133 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.142.16.copyload1088, <4 x half> %124, <4 x float> zeroinitializer), !dbg !162, !call_argsrelate !163
  br label %if.end437.1930, !dbg !164

if.end437.1930:                                   ; preds = %for.cond347.preheader.1922, %for.cond290.preheader.1
  %out.sroa.122.4 = phi <4 x float> [ zeroinitializer, %for.cond290.preheader.1 ], [ %133, %for.cond347.preheader.1922 ]
  %out.sroa.82.4 = phi <4 x float> [ zeroinitializer, %for.cond290.preheader.1 ], [ %132, %for.cond347.preheader.1922 ]
  %out.sroa.42.4 = phi <4 x float> [ zeroinitializer, %for.cond290.preheader.1 ], [ %131, %for.cond347.preheader.1922 ]
  %out.sroa.0.4 = phi <4 x float> [ zeroinitializer, %for.cond290.preheader.1 ], [ %130, %for.cond347.preheader.1922 ]
  %or.cond784.1.1 = icmp ugt i32 %mul11.1, 1023, !dbg !155
  %cmp303.not.1.1 = icmp sgt i32 %mul11.1, %1
  %or.cond785.1.1 = or i1 %or.cond784.1.1, %cmp303.not.1.1, !dbg !155
  br i1 %or.cond785.1.1, label %if.end441.1, label %for.cond372.preheader.1.1, !dbg !155

for.cond372.preheader.1.1:                        ; preds = %if.end437.1930
  %add.ptr339.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and275, !dbg !156
  %134 = load <4 x half>, ptr addrspace(3) %add.ptr339.1.1, align 8, !dbg !157
  %135 = shl nsw i32 %cond.i.i743.1, 10
  %mul312.1.1 = and i32 %135, 64512
  %add313.1.1 = or disjoint i32 %mul312.1.1, %mul131
  %136 = zext nneg i32 %add313.1.1 to i64, !dbg !158
  %137 = or disjoint i64 %136, %27, !dbg !159
  %138 = or disjoint i64 %137, 512, !dbg !159
  %add.ptr321.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %138, !dbg !160
  %vr.sroa.142.16.add.ptr321.1.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.1.1.1, i64 8, !dbg !161
  %vr.sroa.142.16.copyload1089 = load <4 x half>, ptr addrspace(4) %vr.sroa.142.16.add.ptr321.1.1.1.sroa_idx, align 8, !dbg !161
  %vr.sroa.92.16.copyload1080 = load <4 x half>, ptr addrspace(4) %add.ptr321.1.1.1, align 16, !dbg !161
  %139 = or disjoint i64 %136, %27, !dbg !159
  %add.ptr321.1815.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %139, !dbg !160
  %vr.sroa.52.0.add.ptr321.1815.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.1815.1, i64 8, !dbg !161
  %vr.sroa.52.0.copyload993 = load <4 x half>, ptr addrspace(4) %vr.sroa.52.0.add.ptr321.1815.1.sroa_idx, align 8, !dbg !161
  %vr.sroa.0.0.copyload984 = load <4 x half>, ptr addrspace(4) %add.ptr321.1815.1, align 16, !dbg !161
  %140 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload984, <4 x half> %134, <4 x float> zeroinitializer), !dbg !165, !call_argsrelate !163
  %141 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.52.0.copyload993, <4 x half> %134, <4 x float> zeroinitializer), !dbg !165, !call_argsrelate !163
  %142 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.92.16.copyload1080, <4 x half> %134, <4 x float> zeroinitializer), !dbg !165, !call_argsrelate !163
  %143 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.142.16.copyload1089, <4 x half> %134, <4 x float> zeroinitializer), !dbg !165, !call_argsrelate !163
  br label %if.end441.1, !dbg !164

if.end441.1:                                      ; preds = %if.end437.1930, %for.cond372.preheader.1.1, %if.end283.1
  %out.sroa.122.6 = phi <4 x float> [ zeroinitializer, %if.end283.1 ], [ %out.sroa.122.4, %for.cond372.preheader.1.1 ], [ %out.sroa.122.4, %if.end437.1930 ]
  %out.sroa.82.6 = phi <4 x float> [ zeroinitializer, %if.end283.1 ], [ %out.sroa.82.4, %for.cond372.preheader.1.1 ], [ %out.sroa.82.4, %if.end437.1930 ]
  %out.sroa.42.6 = phi <4 x float> [ zeroinitializer, %if.end283.1 ], [ %out.sroa.42.4, %for.cond372.preheader.1.1 ], [ %out.sroa.42.4, %if.end437.1930 ]
  %out.sroa.0.6 = phi <4 x float> [ zeroinitializer, %if.end283.1 ], [ %out.sroa.0.4, %for.cond372.preheader.1.1 ], [ %out.sroa.0.4, %if.end437.1930 ]
  %out_1.sroa.86.6 = phi <4 x float> [ zeroinitializer, %if.end283.1 ], [ %143, %for.cond372.preheader.1.1 ], [ zeroinitializer, %if.end437.1930 ]
  %out_1.sroa.58.6 = phi <4 x float> [ zeroinitializer, %if.end283.1 ], [ %142, %for.cond372.preheader.1.1 ], [ zeroinitializer, %if.end437.1930 ]
  %out_1.sroa.30.6 = phi <4 x float> [ zeroinitializer, %if.end283.1 ], [ %141, %for.cond372.preheader.1.1 ], [ zeroinitializer, %if.end437.1930 ]
  %out_1.sroa.0.6 = phi <4 x float> [ zeroinitializer, %if.end283.1 ], [ %140, %for.cond372.preheader.1.1 ], [ zeroinitializer, %if.end437.1930 ]
  fence syncscope("block") release, !dbg !147
  tail call void @llvm.mxc.barrier(), !dbg !152
  fence syncscope("block") acquire, !dbg !153
  br i1 %cmp108, label %if.end283.2, label %for.cond111.preheader.2, !dbg !67

for.cond111.preheader.2:                          ; preds = %if.end441.1
  %or.cond780.2 = icmp ugt i32 %mul11.4, 1023, !dbg !108
  %cmp124.not.2 = icmp sgt i32 %mul11.4, %1
  %or.cond781.2 = or i1 %or.cond780.2, %cmp124.not.2, !dbg !108
  br i1 %or.cond781.2, label %if.end152.2, label %for.cond126.preheader.2, !dbg !108

for.cond126.preheader.2:                          ; preds = %for.cond111.preheader.2
  %144 = shl nsw i32 %cond.i.i743.4, 10
  %mul133.2 = and i32 %144, 64512
  %add134.2 = or disjoint i32 %mul133.2, %mul131
  %145 = zext nneg i32 %add134.2 to i64, !dbg !109
  %146 = or disjoint i64 %145, %26, !dbg !110
  %add.ptr142.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %146, !dbg !111
  %kr.sroa.0.0.copyload1708 = load <4 x half>, ptr addrspace(4) %add.ptr142.2, align 16, !dbg !112
  %kr.sroa.12.0.add.ptr142.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.2, i64 8, !dbg !112
  %kr.sroa.12.0.copyload1712 = load <4 x half>, ptr addrspace(4) %kr.sroa.12.0.add.ptr142.2.sroa_idx, align 8, !dbg !112
  %147 = or disjoint i64 %145, %26, !dbg !110
  %148 = or disjoint i64 %147, 512, !dbg !110
  %add.ptr142.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %148, !dbg !111
  %kr.sroa.17.16.copyload1724 = load <4 x half>, ptr addrspace(4) %add.ptr142.1.2, align 16, !dbg !112
  %kr.sroa.27.16.add.ptr142.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1.2, i64 8, !dbg !112
  %kr.sroa.27.16.copyload1728 = load <4 x half>, ptr addrspace(4) %kr.sroa.27.16.add.ptr142.1.2.sroa_idx, align 8, !dbg !112
  br label %if.end152.2, !dbg !113

if.end152.2:                                      ; preds = %for.cond126.preheader.2, %for.cond111.preheader.2
  %kr.sroa.27.4 = phi <4 x half> [ %kr.sroa.27.3, %for.cond111.preheader.2 ], [ %kr.sroa.27.16.copyload1728, %for.cond126.preheader.2 ]
  %kr.sroa.17.4 = phi <4 x half> [ %kr.sroa.17.3, %for.cond111.preheader.2 ], [ %kr.sroa.17.16.copyload1724, %for.cond126.preheader.2 ]
  %kr.sroa.12.4 = phi <4 x half> [ %kr.sroa.12.3, %for.cond111.preheader.2 ], [ %kr.sroa.12.0.copyload1712, %for.cond126.preheader.2 ]
  %kr.sroa.0.4 = phi <4 x half> [ %kr.sroa.0.3, %for.cond111.preheader.2 ], [ %kr.sroa.0.0.copyload1708, %for.cond126.preheader.2 ]
  %or.cond780.1.2 = icmp ugt i32 %mul11.5, 1023, !dbg !108
  %cmp124.not.1.2 = icmp sgt i32 %mul11.5, %1
  %or.cond781.1.2 = or i1 %or.cond780.1.2, %cmp124.not.1.2, !dbg !108
  br i1 %or.cond781.1.2, label %if.end152.1.2, label %for.cond126.preheader.1.2, !dbg !108

for.cond126.preheader.1.2:                        ; preds = %if.end152.2
  %149 = shl nsw i32 %cond.i.i743.5, 10
  %mul133.1.2 = and i32 %149, 64512
  %add134.1.2 = or disjoint i32 %mul133.1.2, %mul131
  %150 = zext nneg i32 %add134.1.2 to i64, !dbg !109
  %151 = or disjoint i64 %150, %26, !dbg !110
  %add.ptr142.1801.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %151, !dbg !111
  %kr.sroa.32.32.copyload1740 = load <4 x half>, ptr addrspace(4) %add.ptr142.1801.2, align 16, !dbg !112
  %kr.sroa.42.32.add.ptr142.1801.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1801.2, i64 8, !dbg !112
  %kr.sroa.42.32.copyload1744 = load <4 x half>, ptr addrspace(4) %kr.sroa.42.32.add.ptr142.1801.2.sroa_idx, align 8, !dbg !112
  %152 = or disjoint i64 %150, %26, !dbg !110
  %153 = or disjoint i64 %152, 512, !dbg !110
  %add.ptr142.1.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %153, !dbg !111
  %kr.sroa.47.48.copyload1756 = load <4 x half>, ptr addrspace(4) %add.ptr142.1.1.2, align 16, !dbg !112
  %kr.sroa.57.48.add.ptr142.1.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1.1.2, i64 8, !dbg !112
  %kr.sroa.57.48.copyload1760 = load <4 x half>, ptr addrspace(4) %kr.sroa.57.48.add.ptr142.1.1.2.sroa_idx, align 8, !dbg !112
  br label %if.end152.1.2, !dbg !113

if.end152.1.2:                                    ; preds = %for.cond126.preheader.1.2, %if.end152.2
  %kr.sroa.57.4 = phi <4 x half> [ %kr.sroa.57.3, %if.end152.2 ], [ %kr.sroa.57.48.copyload1760, %for.cond126.preheader.1.2 ]
  %kr.sroa.47.4 = phi <4 x half> [ %kr.sroa.47.3, %if.end152.2 ], [ %kr.sroa.47.48.copyload1756, %for.cond126.preheader.1.2 ]
  %kr.sroa.42.4 = phi <4 x half> [ %kr.sroa.42.3, %if.end152.2 ], [ %kr.sroa.42.32.copyload1744, %for.cond126.preheader.1.2 ]
  %kr.sroa.32.4 = phi <4 x half> [ %kr.sroa.32.3, %if.end152.2 ], [ %kr.sroa.32.32.copyload1740, %for.cond126.preheader.1.2 ]
  br i1 %or.cond781.2, label %if.end267.2, label %if.then170.2, !dbg !114

if.then170.2:                                     ; preds = %if.end152.1.2
  %cmp173.2 = icmp sgt i32 %mul11.4, %invariant.op, !dbg !115
  br i1 %cmp173.2, label %for.cond175.preheader.2, label %if.end201.2, !dbg !116

for.cond175.preheader.2:                          ; preds = %if.then170.2
  %add183.2 = or disjoint i32 %mul11.4, %mul182
  %cmp186.not.2931 = icmp sgt i32 %add183.2, %1, !dbg !117
  %spec.select.2932 = select i1 %cmp186.not.2931, float 0xFFF0000000000000, float 0.000000e+00, !dbg !118
  %scores.sroa.0.0.vec.insert1185 = insertelement <4 x float> poison, float %spec.select.2932, i64 0, !dbg !119
  %cmp186.not.1.2.not = icmp slt i32 %add183.2, %1, !dbg !117
  %spec.select.1.2 = select i1 %cmp186.not.1.2.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !118
  %scores.sroa.0.4.vec.insert1292 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1185, float %spec.select.1.2, i64 1, !dbg !119
  %add184.2.2 = or disjoint i32 %add183.2, 2, !dbg !120
  %cmp186.not.2.2 = icmp sgt i32 %add184.2.2, %1, !dbg !117
  %spec.select.2.2 = select i1 %cmp186.not.2.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !118
  %scores.sroa.0.8.vec.insert1389 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1292, float %spec.select.2.2, i64 2, !dbg !119
  %add184.3.2 = or disjoint i32 %add183.2, 3, !dbg !120
  %cmp186.not.3.2 = icmp sgt i32 %add184.3.2, %1, !dbg !117
  %spec.select.3.2 = select i1 %cmp186.not.3.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !118
  %scores.sroa.0.12.vec.insert1486 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1389, float %spec.select.3.2, i64 3, !dbg !119
  br label %if.end201.2

if.end201.2:                                      ; preds = %if.then170.2, %for.cond175.preheader.2
  %scores.sroa.0.10 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1486, %for.cond175.preheader.2 ], [ zeroinitializer, %if.then170.2 ], !dbg !121
  %154 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.4, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.10), !dbg !122
  %155 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.12.4, <4 x half> %qr.sroa.13.0, <4 x float> %154), !dbg !122
  %156 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.17.4, <4 x half> %qr.sroa.23.0, <4 x float> %155), !dbg !122
  %157 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.27.4, <4 x half> %qr.sroa.34.0, <4 x float> %156), !dbg !122
  %scores.sroa.0.0.vec.extract1187 = extractelement <4 x float> %157, i64 0, !dbg !123
  %mul227.2933 = fmul contract float %scores.sroa.0.0.vec.extract1187, 0x3FB99999A0000000, !dbg !124
  %158 = tail call contract noundef float @llvm.minnum.f32(float %mul227.2933, float 0x4024CB5EC0000000), !dbg !125
  %159 = tail call contract noundef float @llvm.exp.f32(float %158), !dbg !128
  %scores.sroa.0.4.vec.extract1294 = extractelement <4 x float> %157, i64 1, !dbg !123
  %mul227.1.2 = fmul contract float %scores.sroa.0.4.vec.extract1294, 0x3FB99999A0000000, !dbg !124
  %160 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1.2, float 0x4024CB5EC0000000), !dbg !125
  %161 = tail call contract noundef float @llvm.exp.f32(float %160), !dbg !128
  %scores.sroa.0.8.vec.extract1391 = extractelement <4 x float> %157, i64 2, !dbg !123
  %mul227.2.2 = fmul contract float %scores.sroa.0.8.vec.extract1391, 0x3FB99999A0000000, !dbg !124
  %162 = tail call contract noundef float @llvm.minnum.f32(float %mul227.2.2, float 0x4024CB5EC0000000), !dbg !125
  %163 = tail call contract noundef float @llvm.exp.f32(float %162), !dbg !128
  %scores.sroa.0.12.vec.extract1488 = extractelement <4 x float> %157, i64 3, !dbg !123
  %mul227.3.2 = fmul contract float %scores.sroa.0.12.vec.extract1488, 0x3FB99999A0000000, !dbg !124
  %164 = tail call contract noundef float @llvm.minnum.f32(float %mul227.3.2, float 0x4024CB5EC0000000), !dbg !125
  %165 = tail call contract noundef float @llvm.exp.f32(float %164), !dbg !128
  %add243.2934 = fadd contract float %sums.sroa.0.6, %159, !dbg !144
  %166 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %159), !dbg !131
  %probs.sroa.0.0.vec.insert1599 = insertelement <4 x i16> poison, i16 %166, i64 0, !dbg !140
  %add243.1.2 = fadd contract float %sums.sroa.24.6, %161, !dbg !144
  %167 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %161), !dbg !131
  %probs.sroa.0.2.vec.insert1637 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1599, i16 %167, i64 1, !dbg !140
  %add243.2.2 = fadd contract float %sums.sroa.46.6, %163, !dbg !144
  %168 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %163), !dbg !131
  %probs.sroa.0.4.vec.insert1674 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1637, i16 %168, i64 2, !dbg !140
  %add243.3.2 = fadd contract float %sums.sroa.68.6, %165, !dbg !144
  %169 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %165), !dbg !131
  %probs.sroa.0.6.vec.insert1692 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1674, i16 %169, i64 3, !dbg !140
  br label %if.end267.2, !dbg !141

if.end267.2:                                      ; preds = %if.end152.1.2, %if.end201.2
  %sums.sroa.68.7 = phi float [ %add243.3.2, %if.end201.2 ], [ %sums.sroa.68.6, %if.end152.1.2 ], !dbg !121
  %sums.sroa.46.7 = phi float [ %add243.2.2, %if.end201.2 ], [ %sums.sroa.46.6, %if.end152.1.2 ], !dbg !121
  %sums.sroa.24.7 = phi float [ %add243.1.2, %if.end201.2 ], [ %sums.sroa.24.6, %if.end152.1.2 ], !dbg !121
  %sums.sroa.0.7 = phi float [ %add243.2934, %if.end201.2 ], [ %sums.sroa.0.6, %if.end152.1.2 ], !dbg !121
  %probs.sroa.0.12 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1692, %if.end201.2 ], [ zeroinitializer, %if.end152.1.2 ], !dbg !121
  %add.ptr279.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and275, !dbg !142
  store <4 x i16> %probs.sroa.0.12, ptr addrspace(3) %add.ptr279.2, align 8, !dbg !143
  br i1 %or.cond781.1.2, label %if.end267.1.2, label %if.then170.1.2, !dbg !114

if.then170.1.2:                                   ; preds = %if.end267.2
  %cmp173.1.2 = icmp sgt i32 %mul11.5, %invariant.op, !dbg !115
  br i1 %cmp173.1.2, label %for.cond175.preheader.1.2, label %if.end201.1.2, !dbg !116

for.cond175.preheader.1.2:                        ; preds = %if.then170.1.2
  %add183.1.2 = or disjoint i32 %mul11.5, %mul182
  %cmp186.not.1804.2 = icmp sgt i32 %add183.1.2, %1, !dbg !117
  %spec.select.1805.2 = select i1 %cmp186.not.1804.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !118
  %scores.sroa.0.0.vec.insert1195 = insertelement <4 x float> poison, float %spec.select.1805.2, i64 0, !dbg !119
  %cmp186.not.1.1.2.not = icmp slt i32 %add183.1.2, %1, !dbg !117
  %spec.select.1.1.2 = select i1 %cmp186.not.1.1.2.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !118
  %scores.sroa.0.4.vec.insert1300 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1195, float %spec.select.1.1.2, i64 1, !dbg !119
  %add184.2.1.2 = or disjoint i32 %add183.1.2, 2, !dbg !120
  %cmp186.not.2.1.2 = icmp sgt i32 %add184.2.1.2, %1, !dbg !117
  %spec.select.2.1.2 = select i1 %cmp186.not.2.1.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !118
  %scores.sroa.0.8.vec.insert1397 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1300, float %spec.select.2.1.2, i64 2, !dbg !119
  %add184.3.1.2 = or disjoint i32 %add183.1.2, 3, !dbg !120
  %cmp186.not.3.1.2 = icmp sgt i32 %add184.3.1.2, %1, !dbg !117
  %spec.select.3.1.2 = select i1 %cmp186.not.3.1.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !118
  %scores.sroa.0.12.vec.insert1494 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1397, float %spec.select.3.1.2, i64 3, !dbg !119
  br label %if.end201.1.2

if.end201.1.2:                                    ; preds = %if.then170.1.2, %for.cond175.preheader.1.2
  %scores.sroa.0.12 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1494, %for.cond175.preheader.1.2 ], [ zeroinitializer, %if.then170.1.2 ], !dbg !121
  %170 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.32.4, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.12), !dbg !122
  %171 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.42.4, <4 x half> %qr.sroa.13.0, <4 x float> %170), !dbg !122
  %172 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.4, <4 x half> %qr.sroa.23.0, <4 x float> %171), !dbg !122
  %173 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.57.4, <4 x half> %qr.sroa.34.0, <4 x float> %172), !dbg !122
  %scores.sroa.0.0.vec.extract1197 = extractelement <4 x float> %173, i64 0, !dbg !123
  %mul227.1808.2 = fmul contract float %scores.sroa.0.0.vec.extract1197, 0x3FB99999A0000000, !dbg !124
  %174 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1808.2, float 0x4024CB5EC0000000), !dbg !125
  %175 = tail call contract noundef float @llvm.exp.f32(float %174), !dbg !128
  %scores.sroa.0.4.vec.extract1302 = extractelement <4 x float> %173, i64 1, !dbg !123
  %mul227.1.1.2 = fmul contract float %scores.sroa.0.4.vec.extract1302, 0x3FB99999A0000000, !dbg !124
  %176 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1.1.2, float 0x4024CB5EC0000000), !dbg !125
  %177 = tail call contract noundef float @llvm.exp.f32(float %176), !dbg !128
  %scores.sroa.0.8.vec.extract1399 = extractelement <4 x float> %173, i64 2, !dbg !123
  %mul227.2.1.2 = fmul contract float %scores.sroa.0.8.vec.extract1399, 0x3FB99999A0000000, !dbg !124
  %178 = tail call contract noundef float @llvm.minnum.f32(float %mul227.2.1.2, float 0x4024CB5EC0000000), !dbg !125
  %179 = tail call contract noundef float @llvm.exp.f32(float %178), !dbg !128
  %scores.sroa.0.12.vec.extract1496 = extractelement <4 x float> %173, i64 3, !dbg !123
  %mul227.3.1.2 = fmul contract float %scores.sroa.0.12.vec.extract1496, 0x3FB99999A0000000, !dbg !124
  %180 = tail call contract noundef float @llvm.minnum.f32(float %mul227.3.1.2, float 0x4024CB5EC0000000), !dbg !125
  %181 = tail call contract noundef float @llvm.exp.f32(float %180), !dbg !128
  %add243.1809.2 = fadd contract float %sums.sroa.0.7, %175, !dbg !144
  %182 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %175), !dbg !131
  %probs.sroa.0.0.vec.insert1601 = insertelement <4 x i16> poison, i16 %182, i64 0, !dbg !140
  %add243.1.1.2 = fadd contract float %sums.sroa.24.7, %177, !dbg !144
  %183 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %177), !dbg !131
  %probs.sroa.0.2.vec.insert1639 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1601, i16 %183, i64 1, !dbg !140
  %add243.2.1.2 = fadd contract float %sums.sroa.46.7, %179, !dbg !144
  %184 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %179), !dbg !131
  %probs.sroa.0.4.vec.insert1676 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1639, i16 %184, i64 2, !dbg !140
  %add243.3.1.2 = fadd contract float %sums.sroa.68.7, %181, !dbg !144
  %185 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %181), !dbg !131
  %probs.sroa.0.6.vec.insert1694 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1676, i16 %185, i64 3, !dbg !140
  br label %if.end267.1.2, !dbg !141

if.end267.1.2:                                    ; preds = %if.end267.2, %if.end201.1.2
  %sums.sroa.68.8 = phi float [ %add243.3.1.2, %if.end201.1.2 ], [ %sums.sroa.68.7, %if.end267.2 ], !dbg !121
  %sums.sroa.46.8 = phi float [ %add243.2.1.2, %if.end201.1.2 ], [ %sums.sroa.46.7, %if.end267.2 ], !dbg !121
  %sums.sroa.24.8 = phi float [ %add243.1.1.2, %if.end201.1.2 ], [ %sums.sroa.24.7, %if.end267.2 ], !dbg !121
  %sums.sroa.0.8 = phi float [ %add243.1809.2, %if.end201.1.2 ], [ %sums.sroa.0.7, %if.end267.2 ], !dbg !121
  %probs.sroa.0.13 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1694, %if.end201.1.2 ], [ zeroinitializer, %if.end267.2 ], !dbg !121
  %add277.1.2 = or disjoint i32 %and275, 256, !dbg !145
  %add.ptr279.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add277.1.2, !dbg !142
  store <4 x i16> %probs.sroa.0.13, ptr addrspace(3) %add.ptr279.1.2, align 8, !dbg !143
  br label %if.end283.2

if.end283.2:                                      ; preds = %if.end267.1.2, %if.end441.1
  %sums.sroa.68.9 = phi float [ %sums.sroa.68.6, %if.end441.1 ], [ %sums.sroa.68.8, %if.end267.1.2 ], !dbg !146
  %sums.sroa.46.9 = phi float [ %sums.sroa.46.6, %if.end441.1 ], [ %sums.sroa.46.8, %if.end267.1.2 ], !dbg !146
  %sums.sroa.24.9 = phi float [ %sums.sroa.24.6, %if.end441.1 ], [ %sums.sroa.24.8, %if.end267.1.2 ], !dbg !146
  %sums.sroa.0.9 = phi float [ %sums.sroa.0.6, %if.end441.1 ], [ %sums.sroa.0.8, %if.end267.1.2 ], !dbg !146
  %kr.sroa.57.5 = phi <4 x half> [ %kr.sroa.57.3, %if.end441.1 ], [ %kr.sroa.57.4, %if.end267.1.2 ]
  %kr.sroa.47.5 = phi <4 x half> [ %kr.sroa.47.3, %if.end441.1 ], [ %kr.sroa.47.4, %if.end267.1.2 ]
  %kr.sroa.42.5 = phi <4 x half> [ %kr.sroa.42.3, %if.end441.1 ], [ %kr.sroa.42.4, %if.end267.1.2 ]
  %kr.sroa.32.5 = phi <4 x half> [ %kr.sroa.32.3, %if.end441.1 ], [ %kr.sroa.32.4, %if.end267.1.2 ]
  %kr.sroa.27.5 = phi <4 x half> [ %kr.sroa.27.3, %if.end441.1 ], [ %kr.sroa.27.4, %if.end267.1.2 ]
  %kr.sroa.17.5 = phi <4 x half> [ %kr.sroa.17.3, %if.end441.1 ], [ %kr.sroa.17.4, %if.end267.1.2 ]
  %kr.sroa.12.5 = phi <4 x half> [ %kr.sroa.12.3, %if.end441.1 ], [ %kr.sroa.12.4, %if.end267.1.2 ]
  %kr.sroa.0.5 = phi <4 x half> [ %kr.sroa.0.3, %if.end441.1 ], [ %kr.sroa.0.4, %if.end267.1.2 ]
  br i1 %cmp286.not, label %for.cond290.preheader.2, label %if.end441.2, !dbg !154

for.cond290.preheader.2:                          ; preds = %if.end283.2
  %or.cond784.2 = icmp ugt i32 %mul11.2, 1023, !dbg !155
  %cmp303.not.2 = icmp sgt i32 %mul11.2, %1
  %or.cond785.2 = or i1 %or.cond784.2, %cmp303.not.2, !dbg !155
  br i1 %or.cond785.2, label %if.end437.2, label %for.cond397.preheader.2, !dbg !155

for.cond397.preheader.2:                          ; preds = %for.cond290.preheader.2
  %add337.2 = or disjoint i32 %mul336, 512, !dbg !166
  %add.ptr339.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add337.2, !dbg !156
  %186 = load <4 x half>, ptr addrspace(3) %add.ptr339.2, align 8, !dbg !157
  %187 = shl nsw i32 %cond.i.i743.2, 10
  %mul312.2 = and i32 %187, 64512
  %add313.2 = or disjoint i32 %mul312.2, %mul131
  %188 = zext nneg i32 %add313.2 to i64, !dbg !158
  %189 = or disjoint i64 %188, %27, !dbg !159
  %190 = or disjoint i64 %189, 512, !dbg !159
  %add.ptr321.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %190, !dbg !160
  %vr.sroa.142.16.add.ptr321.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.1.2, i64 8, !dbg !161
  %vr.sroa.142.16.copyload1090 = load <4 x half>, ptr addrspace(4) %vr.sroa.142.16.add.ptr321.1.2.sroa_idx, align 8, !dbg !161
  %vr.sroa.92.16.copyload1081 = load <4 x half>, ptr addrspace(4) %add.ptr321.1.2, align 16, !dbg !161
  %191 = or disjoint i64 %188, %27, !dbg !159
  %add.ptr321.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %191, !dbg !160
  %vr.sroa.52.0.add.ptr321.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.2, i64 8, !dbg !161
  %vr.sroa.52.0.copyload994 = load <4 x half>, ptr addrspace(4) %vr.sroa.52.0.add.ptr321.2.sroa_idx, align 8, !dbg !161
  %vr.sroa.0.0.copyload985 = load <4 x half>, ptr addrspace(4) %add.ptr321.2, align 16, !dbg !161
  %192 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload985, <4 x half> %186, <4 x float> zeroinitializer), !dbg !167, !call_argsrelate !163
  %193 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.52.0.copyload994, <4 x half> %186, <4 x float> zeroinitializer), !dbg !167, !call_argsrelate !163
  %194 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.92.16.copyload1081, <4 x half> %186, <4 x float> zeroinitializer), !dbg !167, !call_argsrelate !163
  %195 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.142.16.copyload1090, <4 x half> %186, <4 x float> zeroinitializer), !dbg !167, !call_argsrelate !163
  br label %if.end437.2, !dbg !164

if.end437.2:                                      ; preds = %for.cond397.preheader.2, %for.cond290.preheader.2
  %out_2.sroa.86.7 = phi <4 x float> [ zeroinitializer, %for.cond290.preheader.2 ], [ %195, %for.cond397.preheader.2 ]
  %out_2.sroa.58.7 = phi <4 x float> [ zeroinitializer, %for.cond290.preheader.2 ], [ %194, %for.cond397.preheader.2 ]
  %out_2.sroa.30.7 = phi <4 x float> [ zeroinitializer, %for.cond290.preheader.2 ], [ %193, %for.cond397.preheader.2 ]
  %out_2.sroa.0.7 = phi <4 x float> [ zeroinitializer, %for.cond290.preheader.2 ], [ %192, %for.cond397.preheader.2 ]
  %or.cond784.1.2 = icmp ugt i32 %mul11.3, 1023, !dbg !155
  %cmp303.not.1.2 = icmp sgt i32 %mul11.3, %1
  %or.cond785.1.2 = or i1 %or.cond784.1.2, %cmp303.not.1.2, !dbg !155
  br i1 %or.cond785.1.2, label %if.end441.2, label %for.cond416.preheader.1.2, !dbg !155

for.cond416.preheader.1.2:                        ; preds = %if.end437.2
  %add337.1.2 = or disjoint i32 %and275, 512, !dbg !166
  %add.ptr339.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add337.1.2, !dbg !156
  %196 = load <4 x half>, ptr addrspace(3) %add.ptr339.1.2, align 8, !dbg !157
  %197 = shl nsw i32 %cond.i.i743.3, 10
  %mul312.1.2 = and i32 %197, 64512
  %add313.1.2 = or disjoint i32 %mul312.1.2, %mul131
  %198 = zext nneg i32 %add313.1.2 to i64, !dbg !158
  %199 = or disjoint i64 %198, %27, !dbg !159
  %200 = or disjoint i64 %199, 512, !dbg !159
  %add.ptr321.1.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %200, !dbg !160
  %vr.sroa.142.16.add.ptr321.1.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.1.1.2, i64 8, !dbg !161
  %vr.sroa.142.16.copyload1091 = load <4 x half>, ptr addrspace(4) %vr.sroa.142.16.add.ptr321.1.1.2.sroa_idx, align 8, !dbg !161
  %vr.sroa.92.16.copyload1082 = load <4 x half>, ptr addrspace(4) %add.ptr321.1.1.2, align 16, !dbg !161
  %201 = or disjoint i64 %198, %27, !dbg !159
  %add.ptr321.1815.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %201, !dbg !160
  %vr.sroa.52.0.add.ptr321.1815.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.1815.2, i64 8, !dbg !161
  %vr.sroa.52.0.copyload995 = load <4 x half>, ptr addrspace(4) %vr.sroa.52.0.add.ptr321.1815.2.sroa_idx, align 8, !dbg !161
  %vr.sroa.0.0.copyload986 = load <4 x half>, ptr addrspace(4) %add.ptr321.1815.2, align 16, !dbg !161
  %202 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload986, <4 x half> %196, <4 x float> zeroinitializer), !dbg !168, !call_argsrelate !163
  %203 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.52.0.copyload995, <4 x half> %196, <4 x float> zeroinitializer), !dbg !168, !call_argsrelate !163
  %204 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.92.16.copyload1082, <4 x half> %196, <4 x float> zeroinitializer), !dbg !168, !call_argsrelate !163
  %205 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.142.16.copyload1091, <4 x half> %196, <4 x float> zeroinitializer), !dbg !168, !call_argsrelate !163
  br label %if.end441.2, !dbg !164

if.end441.2:                                      ; preds = %if.end437.2, %for.cond416.preheader.1.2, %if.end283.2
  %out_2.sroa.86.9 = phi <4 x float> [ zeroinitializer, %if.end283.2 ], [ %out_2.sroa.86.7, %for.cond416.preheader.1.2 ], [ %out_2.sroa.86.7, %if.end437.2 ]
  %out_2.sroa.58.9 = phi <4 x float> [ zeroinitializer, %if.end283.2 ], [ %out_2.sroa.58.7, %for.cond416.preheader.1.2 ], [ %out_2.sroa.58.7, %if.end437.2 ]
  %out_2.sroa.30.9 = phi <4 x float> [ zeroinitializer, %if.end283.2 ], [ %out_2.sroa.30.7, %for.cond416.preheader.1.2 ], [ %out_2.sroa.30.7, %if.end437.2 ]
  %out_2.sroa.0.9 = phi <4 x float> [ zeroinitializer, %if.end283.2 ], [ %out_2.sroa.0.7, %for.cond416.preheader.1.2 ], [ %out_2.sroa.0.7, %if.end437.2 ]
  %out_3.sroa.86.9 = phi <4 x float> [ zeroinitializer, %if.end283.2 ], [ %205, %for.cond416.preheader.1.2 ], [ zeroinitializer, %if.end437.2 ]
  %out_3.sroa.58.9 = phi <4 x float> [ zeroinitializer, %if.end283.2 ], [ %204, %for.cond416.preheader.1.2 ], [ zeroinitializer, %if.end437.2 ]
  %out_3.sroa.30.9 = phi <4 x float> [ zeroinitializer, %if.end283.2 ], [ %203, %for.cond416.preheader.1.2 ], [ zeroinitializer, %if.end437.2 ]
  %out_3.sroa.0.9 = phi <4 x float> [ zeroinitializer, %if.end283.2 ], [ %202, %for.cond416.preheader.1.2 ], [ zeroinitializer, %if.end437.2 ]
  fence syncscope("block") release, !dbg !147
  tail call void @llvm.mxc.barrier(), !dbg !152
  fence syncscope("block") acquire, !dbg !153
  br i1 %cmp108, label %if.end283.3, label %for.cond111.preheader.3, !dbg !67

for.cond111.preheader.3:                          ; preds = %if.end441.2
  %or.cond780.3 = icmp ugt i32 %mul11.6, 1023, !dbg !108
  %cmp124.not.3 = icmp sgt i32 %mul11.6, %1
  %or.cond781.3 = or i1 %or.cond780.3, %cmp124.not.3, !dbg !108
  br i1 %or.cond781.3, label %if.end152.3, label %for.cond126.preheader.3, !dbg !108

for.cond126.preheader.3:                          ; preds = %for.cond111.preheader.3
  %206 = shl nsw i32 %cond.i.i743.6, 10
  %mul133.3 = and i32 %206, 64512
  %add134.3 = or disjoint i32 %mul133.3, %mul131
  %207 = zext nneg i32 %add134.3 to i64, !dbg !109
  %208 = or disjoint i64 %207, %26, !dbg !110
  %add.ptr142.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %208, !dbg !111
  %kr.sroa.0.0.copyload1709 = load <4 x half>, ptr addrspace(4) %add.ptr142.3, align 16, !dbg !112
  %kr.sroa.12.0.add.ptr142.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.3, i64 8, !dbg !112
  %kr.sroa.12.0.copyload1713 = load <4 x half>, ptr addrspace(4) %kr.sroa.12.0.add.ptr142.3.sroa_idx, align 8, !dbg !112
  %209 = or disjoint i64 %207, %26, !dbg !110
  %210 = or disjoint i64 %209, 512, !dbg !110
  %add.ptr142.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %210, !dbg !111
  %kr.sroa.17.16.copyload1725 = load <4 x half>, ptr addrspace(4) %add.ptr142.1.3, align 16, !dbg !112
  %kr.sroa.27.16.add.ptr142.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1.3, i64 8, !dbg !112
  %kr.sroa.27.16.copyload1729 = load <4 x half>, ptr addrspace(4) %kr.sroa.27.16.add.ptr142.1.3.sroa_idx, align 8, !dbg !112
  br label %if.end152.3, !dbg !113

if.end152.3:                                      ; preds = %for.cond126.preheader.3, %for.cond111.preheader.3
  %kr.sroa.27.6 = phi <4 x half> [ %kr.sroa.27.5, %for.cond111.preheader.3 ], [ %kr.sroa.27.16.copyload1729, %for.cond126.preheader.3 ]
  %kr.sroa.17.6 = phi <4 x half> [ %kr.sroa.17.5, %for.cond111.preheader.3 ], [ %kr.sroa.17.16.copyload1725, %for.cond126.preheader.3 ]
  %kr.sroa.12.6 = phi <4 x half> [ %kr.sroa.12.5, %for.cond111.preheader.3 ], [ %kr.sroa.12.0.copyload1713, %for.cond126.preheader.3 ]
  %kr.sroa.0.6 = phi <4 x half> [ %kr.sroa.0.5, %for.cond111.preheader.3 ], [ %kr.sroa.0.0.copyload1709, %for.cond126.preheader.3 ]
  %or.cond780.1.3 = icmp ugt i32 %mul11.7, 1023, !dbg !108
  %cmp124.not.1.3 = icmp sgt i32 %mul11.7, %1
  %or.cond781.1.3 = or i1 %or.cond780.1.3, %cmp124.not.1.3, !dbg !108
  br i1 %or.cond781.1.3, label %if.end152.1.3, label %for.cond126.preheader.1.3, !dbg !108

for.cond126.preheader.1.3:                        ; preds = %if.end152.3
  %211 = shl nsw i32 %cond.i.i743.7, 10
  %mul133.1.3 = and i32 %211, 64512
  %add134.1.3 = or disjoint i32 %mul133.1.3, %mul131
  %212 = zext nneg i32 %add134.1.3 to i64, !dbg !109
  %213 = or disjoint i64 %212, %26, !dbg !110
  %add.ptr142.1801.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %213, !dbg !111
  %kr.sroa.32.32.copyload1741 = load <4 x half>, ptr addrspace(4) %add.ptr142.1801.3, align 16, !dbg !112
  %kr.sroa.42.32.add.ptr142.1801.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1801.3, i64 8, !dbg !112
  %kr.sroa.42.32.copyload1745 = load <4 x half>, ptr addrspace(4) %kr.sroa.42.32.add.ptr142.1801.3.sroa_idx, align 8, !dbg !112
  %214 = or disjoint i64 %212, %26, !dbg !110
  %215 = or disjoint i64 %214, 512, !dbg !110
  %add.ptr142.1.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %215, !dbg !111
  %kr.sroa.47.48.copyload1757 = load <4 x half>, ptr addrspace(4) %add.ptr142.1.1.3, align 16, !dbg !112
  %kr.sroa.57.48.add.ptr142.1.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1.1.3, i64 8, !dbg !112
  %kr.sroa.57.48.copyload1761 = load <4 x half>, ptr addrspace(4) %kr.sroa.57.48.add.ptr142.1.1.3.sroa_idx, align 8, !dbg !112
  br label %if.end152.1.3, !dbg !113

if.end152.1.3:                                    ; preds = %for.cond126.preheader.1.3, %if.end152.3
  %kr.sroa.57.6 = phi <4 x half> [ %kr.sroa.57.5, %if.end152.3 ], [ %kr.sroa.57.48.copyload1761, %for.cond126.preheader.1.3 ]
  %kr.sroa.47.6 = phi <4 x half> [ %kr.sroa.47.5, %if.end152.3 ], [ %kr.sroa.47.48.copyload1757, %for.cond126.preheader.1.3 ]
  %kr.sroa.42.6 = phi <4 x half> [ %kr.sroa.42.5, %if.end152.3 ], [ %kr.sroa.42.32.copyload1745, %for.cond126.preheader.1.3 ]
  %kr.sroa.32.6 = phi <4 x half> [ %kr.sroa.32.5, %if.end152.3 ], [ %kr.sroa.32.32.copyload1741, %for.cond126.preheader.1.3 ]
  br i1 %or.cond781.3, label %if.end267.3, label %if.then170.3, !dbg !114

if.then170.3:                                     ; preds = %if.end152.1.3
  %cmp173.3 = icmp sgt i32 %mul11.6, %invariant.op, !dbg !115
  br i1 %cmp173.3, label %for.cond175.preheader.3, label %if.end201.3, !dbg !116

for.cond175.preheader.3:                          ; preds = %if.then170.3
  %add183.3 = or disjoint i32 %mul11.6, %mul182
  %cmp186.not.3935 = icmp sgt i32 %add183.3, %1, !dbg !117
  %spec.select.3936 = select i1 %cmp186.not.3935, float 0xFFF0000000000000, float 0.000000e+00, !dbg !118
  %scores.sroa.0.0.vec.insert1205 = insertelement <4 x float> poison, float %spec.select.3936, i64 0, !dbg !119
  %cmp186.not.1.3.not = icmp slt i32 %add183.3, %1, !dbg !117
  %spec.select.1.3 = select i1 %cmp186.not.1.3.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !118
  %scores.sroa.0.4.vec.insert1308 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1205, float %spec.select.1.3, i64 1, !dbg !119
  %add184.2.3 = or disjoint i32 %add183.3, 2, !dbg !120
  %cmp186.not.2.3 = icmp sgt i32 %add184.2.3, %1, !dbg !117
  %spec.select.2.3 = select i1 %cmp186.not.2.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !118
  %scores.sroa.0.8.vec.insert1405 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1308, float %spec.select.2.3, i64 2, !dbg !119
  %add184.3.3 = or disjoint i32 %add183.3, 3, !dbg !120
  %cmp186.not.3.3 = icmp sgt i32 %add184.3.3, %1, !dbg !117
  %spec.select.3.3 = select i1 %cmp186.not.3.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !118
  %scores.sroa.0.12.vec.insert1502 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1405, float %spec.select.3.3, i64 3, !dbg !119
  br label %if.end201.3

if.end201.3:                                      ; preds = %if.then170.3, %for.cond175.preheader.3
  %scores.sroa.0.15 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1502, %for.cond175.preheader.3 ], [ zeroinitializer, %if.then170.3 ], !dbg !121
  %216 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.6, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.15), !dbg !122
  %217 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.12.6, <4 x half> %qr.sroa.13.0, <4 x float> %216), !dbg !122
  %218 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.17.6, <4 x half> %qr.sroa.23.0, <4 x float> %217), !dbg !122
  %219 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.27.6, <4 x half> %qr.sroa.34.0, <4 x float> %218), !dbg !122
  %scores.sroa.0.0.vec.extract1207 = extractelement <4 x float> %219, i64 0, !dbg !123
  %mul227.3937 = fmul contract float %scores.sroa.0.0.vec.extract1207, 0x3FB99999A0000000, !dbg !124
  %220 = tail call contract noundef float @llvm.minnum.f32(float %mul227.3937, float 0x4024CB5EC0000000), !dbg !125
  %221 = tail call contract noundef float @llvm.exp.f32(float %220), !dbg !128
  %scores.sroa.0.4.vec.extract1310 = extractelement <4 x float> %219, i64 1, !dbg !123
  %mul227.1.3 = fmul contract float %scores.sroa.0.4.vec.extract1310, 0x3FB99999A0000000, !dbg !124
  %222 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1.3, float 0x4024CB5EC0000000), !dbg !125
  %223 = tail call contract noundef float @llvm.exp.f32(float %222), !dbg !128
  %scores.sroa.0.8.vec.extract1407 = extractelement <4 x float> %219, i64 2, !dbg !123
  %mul227.2.3 = fmul contract float %scores.sroa.0.8.vec.extract1407, 0x3FB99999A0000000, !dbg !124
  %224 = tail call contract noundef float @llvm.minnum.f32(float %mul227.2.3, float 0x4024CB5EC0000000), !dbg !125
  %225 = tail call contract noundef float @llvm.exp.f32(float %224), !dbg !128
  %scores.sroa.0.12.vec.extract1504 = extractelement <4 x float> %219, i64 3, !dbg !123
  %mul227.3.3 = fmul contract float %scores.sroa.0.12.vec.extract1504, 0x3FB99999A0000000, !dbg !124
  %226 = tail call contract noundef float @llvm.minnum.f32(float %mul227.3.3, float 0x4024CB5EC0000000), !dbg !125
  %227 = tail call contract noundef float @llvm.exp.f32(float %226), !dbg !128
  %add243.3938 = fadd contract float %sums.sroa.0.9, %221, !dbg !144
  %228 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %221), !dbg !131
  %probs.sroa.0.0.vec.insert1603 = insertelement <4 x i16> poison, i16 %228, i64 0, !dbg !140
  %add243.1.3 = fadd contract float %sums.sroa.24.9, %223, !dbg !144
  %229 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %223), !dbg !131
  %probs.sroa.0.2.vec.insert1641 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1603, i16 %229, i64 1, !dbg !140
  %add243.2.3 = fadd contract float %sums.sroa.46.9, %225, !dbg !144
  %230 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %225), !dbg !131
  %probs.sroa.0.4.vec.insert1678 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1641, i16 %230, i64 2, !dbg !140
  %add243.3.3 = fadd contract float %sums.sroa.68.9, %227, !dbg !144
  %231 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %227), !dbg !131
  %probs.sroa.0.6.vec.insert1696 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1678, i16 %231, i64 3, !dbg !140
  br label %if.end267.3, !dbg !141

if.end267.3:                                      ; preds = %if.end152.1.3, %if.end201.3
  %sums.sroa.68.10 = phi float [ %add243.3.3, %if.end201.3 ], [ %sums.sroa.68.9, %if.end152.1.3 ], !dbg !121
  %sums.sroa.46.10 = phi float [ %add243.2.3, %if.end201.3 ], [ %sums.sroa.46.9, %if.end152.1.3 ], !dbg !121
  %sums.sroa.24.10 = phi float [ %add243.1.3, %if.end201.3 ], [ %sums.sroa.24.9, %if.end152.1.3 ], !dbg !121
  %sums.sroa.0.10 = phi float [ %add243.3938, %if.end201.3 ], [ %sums.sroa.0.9, %if.end152.1.3 ], !dbg !121
  %probs.sroa.0.18 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1696, %if.end201.3 ], [ zeroinitializer, %if.end152.1.3 ], !dbg !121
  %add277.3 = or disjoint i32 %and275, 512, !dbg !145
  %add.ptr279.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add277.3, !dbg !142
  store <4 x i16> %probs.sroa.0.18, ptr addrspace(3) %add.ptr279.3, align 8, !dbg !143
  br i1 %or.cond781.1.3, label %if.end267.1.3, label %if.then170.1.3, !dbg !114

if.then170.1.3:                                   ; preds = %if.end267.3
  %cmp173.1.3 = icmp sgt i32 %mul11.7, %invariant.op, !dbg !115
  br i1 %cmp173.1.3, label %for.cond175.preheader.1.3, label %if.end201.1.3, !dbg !116

for.cond175.preheader.1.3:                        ; preds = %if.then170.1.3
  %add183.1.3 = or disjoint i32 %mul11.7, %mul182
  %cmp186.not.1804.3 = icmp sgt i32 %add183.1.3, %1, !dbg !117
  %spec.select.1805.3 = select i1 %cmp186.not.1804.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !118
  %scores.sroa.0.0.vec.insert1215 = insertelement <4 x float> poison, float %spec.select.1805.3, i64 0, !dbg !119
  %cmp186.not.1.1.3.not = icmp slt i32 %add183.1.3, %1, !dbg !117
  %spec.select.1.1.3 = select i1 %cmp186.not.1.1.3.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !118
  %scores.sroa.0.4.vec.insert1316 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1215, float %spec.select.1.1.3, i64 1, !dbg !119
  %add184.2.1.3 = or disjoint i32 %add183.1.3, 2, !dbg !120
  %cmp186.not.2.1.3 = icmp sgt i32 %add184.2.1.3, %1, !dbg !117
  %spec.select.2.1.3 = select i1 %cmp186.not.2.1.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !118
  %scores.sroa.0.8.vec.insert1413 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1316, float %spec.select.2.1.3, i64 2, !dbg !119
  %add184.3.1.3 = or disjoint i32 %add183.1.3, 3, !dbg !120
  %cmp186.not.3.1.3 = icmp sgt i32 %add184.3.1.3, %1, !dbg !117
  %spec.select.3.1.3 = select i1 %cmp186.not.3.1.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !118
  %scores.sroa.0.12.vec.insert1510 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1413, float %spec.select.3.1.3, i64 3, !dbg !119
  br label %if.end201.1.3

if.end201.1.3:                                    ; preds = %if.then170.1.3, %for.cond175.preheader.1.3
  %scores.sroa.0.17 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1510, %for.cond175.preheader.1.3 ], [ zeroinitializer, %if.then170.1.3 ], !dbg !121
  %232 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.32.6, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.17), !dbg !122
  %233 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.42.6, <4 x half> %qr.sroa.13.0, <4 x float> %232), !dbg !122
  %234 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.6, <4 x half> %qr.sroa.23.0, <4 x float> %233), !dbg !122
  %235 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.57.6, <4 x half> %qr.sroa.34.0, <4 x float> %234), !dbg !122
  %scores.sroa.0.0.vec.extract1217 = extractelement <4 x float> %235, i64 0, !dbg !123
  %mul227.1808.3 = fmul contract float %scores.sroa.0.0.vec.extract1217, 0x3FB99999A0000000, !dbg !124
  %236 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1808.3, float 0x4024CB5EC0000000), !dbg !125
  %237 = tail call contract noundef float @llvm.exp.f32(float %236), !dbg !128
  %scores.sroa.0.4.vec.extract1318 = extractelement <4 x float> %235, i64 1, !dbg !123
  %mul227.1.1.3 = fmul contract float %scores.sroa.0.4.vec.extract1318, 0x3FB99999A0000000, !dbg !124
  %238 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1.1.3, float 0x4024CB5EC0000000), !dbg !125
  %239 = tail call contract noundef float @llvm.exp.f32(float %238), !dbg !128
  %scores.sroa.0.8.vec.extract1415 = extractelement <4 x float> %235, i64 2, !dbg !123
  %mul227.2.1.3 = fmul contract float %scores.sroa.0.8.vec.extract1415, 0x3FB99999A0000000, !dbg !124
  %240 = tail call contract noundef float @llvm.minnum.f32(float %mul227.2.1.3, float 0x4024CB5EC0000000), !dbg !125
  %241 = tail call contract noundef float @llvm.exp.f32(float %240), !dbg !128
  %scores.sroa.0.12.vec.extract1512 = extractelement <4 x float> %235, i64 3, !dbg !123
  %mul227.3.1.3 = fmul contract float %scores.sroa.0.12.vec.extract1512, 0x3FB99999A0000000, !dbg !124
  %242 = tail call contract noundef float @llvm.minnum.f32(float %mul227.3.1.3, float 0x4024CB5EC0000000), !dbg !125
  %243 = tail call contract noundef float @llvm.exp.f32(float %242), !dbg !128
  %add243.1809.3 = fadd contract float %sums.sroa.0.10, %237, !dbg !144
  %244 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %237), !dbg !131
  %probs.sroa.0.0.vec.insert1605 = insertelement <4 x i16> poison, i16 %244, i64 0, !dbg !140
  %add243.1.1.3 = fadd contract float %sums.sroa.24.10, %239, !dbg !144
  %245 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %239), !dbg !131
  %probs.sroa.0.2.vec.insert1643 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1605, i16 %245, i64 1, !dbg !140
  %add243.2.1.3 = fadd contract float %sums.sroa.46.10, %241, !dbg !144
  %246 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %241), !dbg !131
  %probs.sroa.0.4.vec.insert1680 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1643, i16 %246, i64 2, !dbg !140
  %add243.3.1.3 = fadd contract float %sums.sroa.68.10, %243, !dbg !144
  %247 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %243), !dbg !131
  %probs.sroa.0.6.vec.insert1698 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1680, i16 %247, i64 3, !dbg !140
  %248 = bitcast <4 x i16> %probs.sroa.0.6.vec.insert1698 to i64, !dbg !143
  br label %if.end267.1.3, !dbg !141

if.end267.1.3:                                    ; preds = %if.end267.3, %if.end201.1.3
  %sums.sroa.68.11 = phi float [ %add243.3.1.3, %if.end201.1.3 ], [ %sums.sroa.68.10, %if.end267.3 ], !dbg !121
  %sums.sroa.46.11 = phi float [ %add243.2.1.3, %if.end201.1.3 ], [ %sums.sroa.46.10, %if.end267.3 ], !dbg !121
  %sums.sroa.24.11 = phi float [ %add243.1.1.3, %if.end201.1.3 ], [ %sums.sroa.24.10, %if.end267.3 ], !dbg !121
  %sums.sroa.0.11 = phi float [ %add243.1809.3, %if.end201.1.3 ], [ %sums.sroa.0.10, %if.end267.3 ], !dbg !121
  %probs.sroa.0.19 = phi i64 [ %248, %if.end201.1.3 ], [ 0, %if.end267.3 ], !dbg !121
  %add277.1.3 = or disjoint i32 %and275, 768, !dbg !145
  %add.ptr279.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add277.1.3, !dbg !142
  store i64 %probs.sroa.0.19, ptr addrspace(3) %add.ptr279.1.3, align 8, !dbg !143
  br label %if.end283.3

if.end283.3:                                      ; preds = %if.end267.1.3, %if.end441.2
  %sums.sroa.68.12 = phi float [ %sums.sroa.68.9, %if.end441.2 ], [ %sums.sroa.68.11, %if.end267.1.3 ], !dbg !146
  %sums.sroa.46.12 = phi float [ %sums.sroa.46.9, %if.end441.2 ], [ %sums.sroa.46.11, %if.end267.1.3 ], !dbg !146
  %sums.sroa.24.12 = phi float [ %sums.sroa.24.9, %if.end441.2 ], [ %sums.sroa.24.11, %if.end267.1.3 ], !dbg !146
  %sums.sroa.0.12 = phi float [ %sums.sroa.0.9, %if.end441.2 ], [ %sums.sroa.0.11, %if.end267.1.3 ], !dbg !146
  br i1 %cmp286.not, label %for.cond290.preheader.3, label %if.end441.3, !dbg !154

for.cond290.preheader.3:                          ; preds = %if.end283.3
  %or.cond784.3 = icmp ugt i32 %mul11.4, 1023, !dbg !155
  %cmp303.not.3 = icmp sgt i32 %mul11.4, %1
  %or.cond785.3 = or i1 %or.cond784.3, %cmp303.not.3, !dbg !155
  br i1 %or.cond785.3, label %if.end437.3, label %for.cond347.preheader.3, !dbg !155

for.cond347.preheader.3:                          ; preds = %for.cond290.preheader.3
  %add.ptr339.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul336, !dbg !156
  %249 = load <4 x half>, ptr addrspace(3) %add.ptr339.3, align 8, !dbg !157
  %250 = shl nsw i32 %cond.i.i743.4, 10
  %mul312.3 = and i32 %250, 64512
  %add313.3 = or disjoint i32 %mul312.3, %mul131
  %251 = zext nneg i32 %add313.3 to i64, !dbg !158
  %252 = or disjoint i64 %251, %27, !dbg !159
  %253 = or disjoint i64 %252, 512, !dbg !159
  %add.ptr321.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %253, !dbg !160
  %vr.sroa.142.16.add.ptr321.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.1.3, i64 8, !dbg !161
  %vr.sroa.142.16.copyload1092 = load <4 x half>, ptr addrspace(4) %vr.sroa.142.16.add.ptr321.1.3.sroa_idx, align 8, !dbg !161
  %vr.sroa.92.16.copyload1083 = load <4 x half>, ptr addrspace(4) %add.ptr321.1.3, align 16, !dbg !161
  %254 = or disjoint i64 %251, %27, !dbg !159
  %add.ptr321.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %254, !dbg !160
  %vr.sroa.52.0.add.ptr321.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.3, i64 8, !dbg !161
  %vr.sroa.52.0.copyload996 = load <4 x half>, ptr addrspace(4) %vr.sroa.52.0.add.ptr321.3.sroa_idx, align 8, !dbg !161
  %vr.sroa.0.0.copyload987 = load <4 x half>, ptr addrspace(4) %add.ptr321.3, align 16, !dbg !161
  %255 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload987, <4 x half> %249, <4 x float> %out.sroa.0.6), !dbg !162, !call_argsrelate !163
  %256 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.52.0.copyload996, <4 x half> %249, <4 x float> %out.sroa.42.6), !dbg !162, !call_argsrelate !163
  %257 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.92.16.copyload1083, <4 x half> %249, <4 x float> %out.sroa.82.6), !dbg !162, !call_argsrelate !163
  %258 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.142.16.copyload1092, <4 x half> %249, <4 x float> %out.sroa.122.6), !dbg !162, !call_argsrelate !163
  br label %if.end437.3, !dbg !164

if.end437.3:                                      ; preds = %for.cond347.preheader.3, %for.cond290.preheader.3
  %out.sroa.122.10 = phi <4 x float> [ %out.sroa.122.6, %for.cond290.preheader.3 ], [ %258, %for.cond347.preheader.3 ]
  %out.sroa.82.10 = phi <4 x float> [ %out.sroa.82.6, %for.cond290.preheader.3 ], [ %257, %for.cond347.preheader.3 ]
  %out.sroa.42.10 = phi <4 x float> [ %out.sroa.42.6, %for.cond290.preheader.3 ], [ %256, %for.cond347.preheader.3 ]
  %out.sroa.0.10 = phi <4 x float> [ %out.sroa.0.6, %for.cond290.preheader.3 ], [ %255, %for.cond347.preheader.3 ]
  %or.cond784.1.3 = icmp ugt i32 %mul11.5, 1023, !dbg !155
  %cmp303.not.1.3 = icmp sgt i32 %mul11.5, %1
  %or.cond785.1.3 = or i1 %or.cond784.1.3, %cmp303.not.1.3, !dbg !155
  br i1 %or.cond785.1.3, label %if.end441.3, label %for.cond372.preheader.1.3, !dbg !155

for.cond372.preheader.1.3:                        ; preds = %if.end437.3
  %add.ptr339.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and275, !dbg !156
  %259 = load <4 x half>, ptr addrspace(3) %add.ptr339.1.3, align 8, !dbg !157
  %260 = shl nsw i32 %cond.i.i743.5, 10
  %mul312.1.3 = and i32 %260, 64512
  %add313.1.3 = or disjoint i32 %mul312.1.3, %mul131
  %261 = zext nneg i32 %add313.1.3 to i64, !dbg !158
  %262 = or disjoint i64 %261, %27, !dbg !159
  %263 = or disjoint i64 %262, 512, !dbg !159
  %add.ptr321.1.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %263, !dbg !160
  %vr.sroa.142.16.add.ptr321.1.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.1.1.3, i64 8, !dbg !161
  %vr.sroa.142.16.copyload1093 = load <4 x half>, ptr addrspace(4) %vr.sroa.142.16.add.ptr321.1.1.3.sroa_idx, align 8, !dbg !161
  %vr.sroa.92.16.copyload1084 = load <4 x half>, ptr addrspace(4) %add.ptr321.1.1.3, align 16, !dbg !161
  %264 = or disjoint i64 %261, %27, !dbg !159
  %add.ptr321.1815.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %264, !dbg !160
  %vr.sroa.52.0.add.ptr321.1815.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.1815.3, i64 8, !dbg !161
  %vr.sroa.52.0.copyload997 = load <4 x half>, ptr addrspace(4) %vr.sroa.52.0.add.ptr321.1815.3.sroa_idx, align 8, !dbg !161
  %vr.sroa.0.0.copyload988 = load <4 x half>, ptr addrspace(4) %add.ptr321.1815.3, align 16, !dbg !161
  %265 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload988, <4 x half> %259, <4 x float> %out_1.sroa.0.6), !dbg !165, !call_argsrelate !163
  %266 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.52.0.copyload997, <4 x half> %259, <4 x float> %out_1.sroa.30.6), !dbg !165, !call_argsrelate !163
  %267 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.92.16.copyload1084, <4 x half> %259, <4 x float> %out_1.sroa.58.6), !dbg !165, !call_argsrelate !163
  %268 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.142.16.copyload1093, <4 x half> %259, <4 x float> %out_1.sroa.86.6), !dbg !165, !call_argsrelate !163
  br label %if.end441.3, !dbg !164

if.end441.3:                                      ; preds = %if.end437.3, %for.cond372.preheader.1.3, %if.end283.3
  %out.sroa.122.12 = phi <4 x float> [ %out.sroa.122.6, %if.end283.3 ], [ %out.sroa.122.10, %for.cond372.preheader.1.3 ], [ %out.sroa.122.10, %if.end437.3 ]
  %out.sroa.82.12 = phi <4 x float> [ %out.sroa.82.6, %if.end283.3 ], [ %out.sroa.82.10, %for.cond372.preheader.1.3 ], [ %out.sroa.82.10, %if.end437.3 ]
  %out.sroa.42.12 = phi <4 x float> [ %out.sroa.42.6, %if.end283.3 ], [ %out.sroa.42.10, %for.cond372.preheader.1.3 ], [ %out.sroa.42.10, %if.end437.3 ]
  %out.sroa.0.12 = phi <4 x float> [ %out.sroa.0.6, %if.end283.3 ], [ %out.sroa.0.10, %for.cond372.preheader.1.3 ], [ %out.sroa.0.10, %if.end437.3 ]
  %out_1.sroa.86.12 = phi <4 x float> [ %out_1.sroa.86.6, %if.end283.3 ], [ %268, %for.cond372.preheader.1.3 ], [ %out_1.sroa.86.6, %if.end437.3 ]
  %out_1.sroa.58.12 = phi <4 x float> [ %out_1.sroa.58.6, %if.end283.3 ], [ %267, %for.cond372.preheader.1.3 ], [ %out_1.sroa.58.6, %if.end437.3 ]
  %out_1.sroa.30.12 = phi <4 x float> [ %out_1.sroa.30.6, %if.end283.3 ], [ %266, %for.cond372.preheader.1.3 ], [ %out_1.sroa.30.6, %if.end437.3 ]
  %out_1.sroa.0.12 = phi <4 x float> [ %out_1.sroa.0.6, %if.end283.3 ], [ %265, %for.cond372.preheader.1.3 ], [ %out_1.sroa.0.6, %if.end437.3 ]
  fence syncscope("block") release, !dbg !147
  tail call void @llvm.mxc.barrier(), !dbg !152
  fence syncscope("block") acquire, !dbg !153
  br label %if.end283.4, !dbg !67

if.end283.4:                                      ; preds = %if.end441.3
  br i1 %cmp286.not, label %for.cond290.preheader.4, label %if.end441.4, !dbg !154

for.cond290.preheader.4:                          ; preds = %if.end283.4
  %or.cond784.4 = icmp ugt i32 %mul11.6, 1023, !dbg !155
  %cmp303.not.4 = icmp sgt i32 %mul11.6, %1
  %or.cond785.4 = or i1 %or.cond784.4, %cmp303.not.4, !dbg !155
  br i1 %or.cond785.4, label %if.end437.4, label %for.cond397.preheader.4, !dbg !155

for.cond397.preheader.4:                          ; preds = %for.cond290.preheader.4
  %add337.4 = or disjoint i32 %mul336, 512, !dbg !166
  %add.ptr339.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add337.4, !dbg !156
  %269 = load <4 x half>, ptr addrspace(3) %add.ptr339.4, align 8, !dbg !157
  %270 = shl nsw i32 %cond.i.i743.6, 10
  %mul312.4 = and i32 %270, 64512
  %add313.4 = or disjoint i32 %mul312.4, %mul131
  %271 = zext nneg i32 %add313.4 to i64, !dbg !158
  %272 = or disjoint i64 %271, %27, !dbg !159
  %273 = or disjoint i64 %272, 512, !dbg !159
  %add.ptr321.1.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %273, !dbg !160
  %vr.sroa.142.16.add.ptr321.1.4.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.1.4, i64 8, !dbg !161
  %vr.sroa.142.16.copyload1094 = load <4 x half>, ptr addrspace(4) %vr.sroa.142.16.add.ptr321.1.4.sroa_idx, align 8, !dbg !161
  %vr.sroa.92.16.copyload1085 = load <4 x half>, ptr addrspace(4) %add.ptr321.1.4, align 16, !dbg !161
  %274 = or disjoint i64 %271, %27, !dbg !159
  %add.ptr321.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %274, !dbg !160
  %vr.sroa.52.0.add.ptr321.4.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.4, i64 8, !dbg !161
  %vr.sroa.52.0.copyload998 = load <4 x half>, ptr addrspace(4) %vr.sroa.52.0.add.ptr321.4.sroa_idx, align 8, !dbg !161
  %vr.sroa.0.0.copyload989 = load <4 x half>, ptr addrspace(4) %add.ptr321.4, align 16, !dbg !161
  %275 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload989, <4 x half> %269, <4 x float> %out_2.sroa.0.9), !dbg !167, !call_argsrelate !163
  %276 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.52.0.copyload998, <4 x half> %269, <4 x float> %out_2.sroa.30.9), !dbg !167, !call_argsrelate !163
  %277 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.92.16.copyload1085, <4 x half> %269, <4 x float> %out_2.sroa.58.9), !dbg !167, !call_argsrelate !163
  %278 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.142.16.copyload1094, <4 x half> %269, <4 x float> %out_2.sroa.86.9), !dbg !167, !call_argsrelate !163
  br label %if.end437.4, !dbg !164

if.end437.4:                                      ; preds = %for.cond397.preheader.4, %for.cond290.preheader.4
  %out_2.sroa.86.13 = phi <4 x float> [ %out_2.sroa.86.9, %for.cond290.preheader.4 ], [ %278, %for.cond397.preheader.4 ]
  %out_2.sroa.58.13 = phi <4 x float> [ %out_2.sroa.58.9, %for.cond290.preheader.4 ], [ %277, %for.cond397.preheader.4 ]
  %out_2.sroa.30.13 = phi <4 x float> [ %out_2.sroa.30.9, %for.cond290.preheader.4 ], [ %276, %for.cond397.preheader.4 ]
  %out_2.sroa.0.13 = phi <4 x float> [ %out_2.sroa.0.9, %for.cond290.preheader.4 ], [ %275, %for.cond397.preheader.4 ]
  %or.cond784.1.4 = icmp ugt i32 %mul11.7, 1023, !dbg !155
  %cmp303.not.1.4 = icmp sgt i32 %mul11.7, %1
  %or.cond785.1.4 = or i1 %or.cond784.1.4, %cmp303.not.1.4, !dbg !155
  br i1 %or.cond785.1.4, label %if.end441.4, label %for.cond416.preheader.1.4, !dbg !155

for.cond416.preheader.1.4:                        ; preds = %if.end437.4
  %add337.1.4 = or disjoint i32 %and275, 512, !dbg !166
  %add.ptr339.1.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add337.1.4, !dbg !156
  %279 = load <4 x half>, ptr addrspace(3) %add.ptr339.1.4, align 8, !dbg !157
  %280 = shl nsw i32 %cond.i.i743.7, 10
  %mul312.1.4 = and i32 %280, 64512
  %add313.1.4 = or disjoint i32 %mul312.1.4, %mul131
  %281 = zext nneg i32 %add313.1.4 to i64, !dbg !158
  %282 = or disjoint i64 %281, %27, !dbg !159
  %283 = or disjoint i64 %282, 512, !dbg !159
  %add.ptr321.1.1.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %283, !dbg !160
  %vr.sroa.142.16.add.ptr321.1.1.4.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.1.1.4, i64 8, !dbg !161
  %vr.sroa.142.16.copyload1095 = load <4 x half>, ptr addrspace(4) %vr.sroa.142.16.add.ptr321.1.1.4.sroa_idx, align 8, !dbg !161
  %vr.sroa.92.16.copyload1086 = load <4 x half>, ptr addrspace(4) %add.ptr321.1.1.4, align 16, !dbg !161
  %284 = or disjoint i64 %281, %27, !dbg !159
  %add.ptr321.1815.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %284, !dbg !160
  %vr.sroa.52.0.add.ptr321.1815.4.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.1815.4, i64 8, !dbg !161
  %vr.sroa.52.0.copyload999 = load <4 x half>, ptr addrspace(4) %vr.sroa.52.0.add.ptr321.1815.4.sroa_idx, align 8, !dbg !161
  %vr.sroa.0.0.copyload990 = load <4 x half>, ptr addrspace(4) %add.ptr321.1815.4, align 16, !dbg !161
  %285 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload990, <4 x half> %279, <4 x float> %out_3.sroa.0.9), !dbg !168, !call_argsrelate !163
  %286 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.52.0.copyload999, <4 x half> %279, <4 x float> %out_3.sroa.30.9), !dbg !168, !call_argsrelate !163
  %287 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.92.16.copyload1086, <4 x half> %279, <4 x float> %out_3.sroa.58.9), !dbg !168, !call_argsrelate !163
  %288 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.142.16.copyload1095, <4 x half> %279, <4 x float> %out_3.sroa.86.9), !dbg !168, !call_argsrelate !163
  br label %if.end441.4, !dbg !164

if.end441.4:                                      ; preds = %if.end437.4, %for.cond416.preheader.1.4, %if.end283.4
  %out_2.sroa.86.15 = phi <4 x float> [ %out_2.sroa.86.9, %if.end283.4 ], [ %out_2.sroa.86.13, %for.cond416.preheader.1.4 ], [ %out_2.sroa.86.13, %if.end437.4 ]
  %out_2.sroa.58.15 = phi <4 x float> [ %out_2.sroa.58.9, %if.end283.4 ], [ %out_2.sroa.58.13, %for.cond416.preheader.1.4 ], [ %out_2.sroa.58.13, %if.end437.4 ]
  %out_2.sroa.30.15 = phi <4 x float> [ %out_2.sroa.30.9, %if.end283.4 ], [ %out_2.sroa.30.13, %for.cond416.preheader.1.4 ], [ %out_2.sroa.30.13, %if.end437.4 ]
  %out_2.sroa.0.15 = phi <4 x float> [ %out_2.sroa.0.9, %if.end283.4 ], [ %out_2.sroa.0.13, %for.cond416.preheader.1.4 ], [ %out_2.sroa.0.13, %if.end437.4 ]
  %out_3.sroa.86.15 = phi <4 x float> [ %out_3.sroa.86.9, %if.end283.4 ], [ %288, %for.cond416.preheader.1.4 ], [ %out_3.sroa.86.9, %if.end437.4 ]
  %out_3.sroa.58.15 = phi <4 x float> [ %out_3.sroa.58.9, %if.end283.4 ], [ %287, %for.cond416.preheader.1.4 ], [ %out_3.sroa.58.9, %if.end437.4 ]
  %out_3.sroa.30.15 = phi <4 x float> [ %out_3.sroa.30.9, %if.end283.4 ], [ %286, %for.cond416.preheader.1.4 ], [ %out_3.sroa.30.9, %if.end437.4 ]
  %out_3.sroa.0.15 = phi <4 x float> [ %out_3.sroa.0.9, %if.end283.4 ], [ %285, %for.cond416.preheader.1.4 ], [ %out_3.sroa.0.9, %if.end437.4 ]
  fence syncscope("block") release, !dbg !147
  tail call void @llvm.mxc.barrier(), !dbg !152
  fence syncscope("block") acquire, !dbg !153
  br i1 %cmp15, label %for.body453.preheader, label %if.end484, !dbg !169

if.end484:                                        ; preds = %for.body453.preheader, %if.end441.4
  fence syncscope("block") release, !dbg !170
  tail call void @llvm.mxc.barrier(), !dbg !173
  fence syncscope("block") acquire, !dbg !174
  %cmp487 = icmp eq i32 %shr285.mask, 64, !dbg !175
  br i1 %cmp487, label %if.then488, label %if.end599, !dbg !176

if.then488:                                       ; preds = %if.end484
  %and490 = and i32 %18, 63, !dbg !177
  %arrayidx492 = getelementptr inbounds float, ptr addrspace(3) @buf_dyn_shmem, i32 %and490, !dbg !178
  %289 = load float, ptr addrspace(3) %arrayidx492, align 4, !dbg !178, !tbaa !105
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %out.sroa.0.12, i64 0, !dbg !179
  %out_1.sroa.0.0.vec.extract = extractelement <4 x float> %out_1.sroa.0.12, i64 0, !dbg !180
  %add502 = fadd contract float %out.sroa.0.0.vec.extract, %out_1.sroa.0.0.vec.extract, !dbg !181
  %out_2.sroa.0.0.vec.extract = extractelement <4 x float> %out_2.sroa.0.15, i64 0, !dbg !182
  %add509 = fadd contract float %add502, %out_2.sroa.0.0.vec.extract, !dbg !183
  %out_3.sroa.0.0.vec.extract = extractelement <4 x float> %out_3.sroa.0.15, i64 0, !dbg !184
  %add516 = fadd contract float %add509, %out_3.sroa.0.0.vec.extract, !dbg !185
  %mul522 = fmul contract float %289, %add516, !dbg !186
  %290 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522), !dbg !187
  %oreg.sroa.0.0.insert.ext = zext i16 %290 to i64, !dbg !191
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %out.sroa.0.12, i64 1, !dbg !179
  %out_1.sroa.0.4.vec.extract = extractelement <4 x float> %out_1.sroa.0.12, i64 1, !dbg !180
  %add502.1 = fadd contract float %out.sroa.0.4.vec.extract, %out_1.sroa.0.4.vec.extract, !dbg !181
  %out_2.sroa.0.4.vec.extract = extractelement <4 x float> %out_2.sroa.0.15, i64 1, !dbg !182
  %add509.1 = fadd contract float %add502.1, %out_2.sroa.0.4.vec.extract, !dbg !183
  %out_3.sroa.0.4.vec.extract = extractelement <4 x float> %out_3.sroa.0.15, i64 1, !dbg !184
  %add516.1 = fadd contract float %add509.1, %out_3.sroa.0.4.vec.extract, !dbg !185
  %mul522.1 = fmul contract float %289, %add516.1, !dbg !186
  %291 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522.1), !dbg !187
  %oreg.sroa.0.2.insert.ext = zext i16 %291 to i64, !dbg !191
  %oreg.sroa.0.2.insert.shift = shl nuw nsw i64 %oreg.sroa.0.2.insert.ext, 16, !dbg !191
  %oreg.sroa.0.2.insert.insert = or disjoint i64 %oreg.sroa.0.2.insert.shift, %oreg.sroa.0.0.insert.ext, !dbg !191
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %out.sroa.0.12, i64 2, !dbg !179
  %out_1.sroa.0.8.vec.extract = extractelement <4 x float> %out_1.sroa.0.12, i64 2, !dbg !180
  %add502.2 = fadd contract float %out.sroa.0.8.vec.extract, %out_1.sroa.0.8.vec.extract, !dbg !181
  %out_2.sroa.0.8.vec.extract = extractelement <4 x float> %out_2.sroa.0.15, i64 2, !dbg !182
  %add509.2 = fadd contract float %add502.2, %out_2.sroa.0.8.vec.extract, !dbg !183
  %out_3.sroa.0.8.vec.extract = extractelement <4 x float> %out_3.sroa.0.15, i64 2, !dbg !184
  %add516.2 = fadd contract float %add509.2, %out_3.sroa.0.8.vec.extract, !dbg !185
  %mul522.2 = fmul contract float %289, %add516.2, !dbg !186
  %292 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522.2), !dbg !187
  %oreg.sroa.0.4.insert.ext = zext i16 %292 to i64, !dbg !191
  %oreg.sroa.0.4.insert.shift = shl nuw nsw i64 %oreg.sroa.0.4.insert.ext, 32, !dbg !191
  %oreg.sroa.0.4.insert.insert = or disjoint i64 %oreg.sroa.0.2.insert.insert, %oreg.sroa.0.4.insert.shift, !dbg !191
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %out.sroa.0.12, i64 3, !dbg !179
  %out_1.sroa.0.12.vec.extract = extractelement <4 x float> %out_1.sroa.0.12, i64 3, !dbg !180
  %add502.3 = fadd contract float %out.sroa.0.12.vec.extract, %out_1.sroa.0.12.vec.extract, !dbg !181
  %out_2.sroa.0.12.vec.extract = extractelement <4 x float> %out_2.sroa.0.15, i64 3, !dbg !182
  %add509.3 = fadd contract float %add502.3, %out_2.sroa.0.12.vec.extract, !dbg !183
  %out_3.sroa.0.12.vec.extract = extractelement <4 x float> %out_3.sroa.0.15, i64 3, !dbg !184
  %add516.3 = fadd contract float %add509.3, %out_3.sroa.0.12.vec.extract, !dbg !185
  %mul522.3 = fmul contract float %289, %add516.3, !dbg !186
  %293 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522.3), !dbg !187
  %oreg.sroa.0.6.insert.ext = zext i16 %293 to i64, !dbg !191
  %oreg.sroa.0.6.insert.shift = shl nuw i64 %oreg.sroa.0.6.insert.ext, 48, !dbg !191
  %oreg.sroa.0.6.insert.insert = or disjoint i64 %oreg.sroa.0.4.insert.insert, %oreg.sroa.0.6.insert.shift, !dbg !191
  %out.sroa.42.16.vec.extract = extractelement <4 x float> %out.sroa.42.12, i64 0, !dbg !179
  %out_1.sroa.30.16.vec.extract = extractelement <4 x float> %out_1.sroa.30.12, i64 0, !dbg !180
  %add502.4 = fadd contract float %out.sroa.42.16.vec.extract, %out_1.sroa.30.16.vec.extract, !dbg !181
  %out_2.sroa.30.16.vec.extract = extractelement <4 x float> %out_2.sroa.30.15, i64 0, !dbg !182
  %add509.4 = fadd contract float %add502.4, %out_2.sroa.30.16.vec.extract, !dbg !183
  %out_3.sroa.30.16.vec.extract = extractelement <4 x float> %out_3.sroa.30.15, i64 0, !dbg !184
  %add516.4 = fadd contract float %add509.4, %out_3.sroa.30.16.vec.extract, !dbg !185
  %mul522.4 = fmul contract float %289, %add516.4, !dbg !186
  %294 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522.4), !dbg !187
  %oreg.sroa.7.8.insert.ext = zext i16 %294 to i64, !dbg !191
  %out.sroa.42.20.vec.extract = extractelement <4 x float> %out.sroa.42.12, i64 1, !dbg !179
  %out_1.sroa.30.20.vec.extract = extractelement <4 x float> %out_1.sroa.30.12, i64 1, !dbg !180
  %add502.5 = fadd contract float %out.sroa.42.20.vec.extract, %out_1.sroa.30.20.vec.extract, !dbg !181
  %out_2.sroa.30.20.vec.extract = extractelement <4 x float> %out_2.sroa.30.15, i64 1, !dbg !182
  %add509.5 = fadd contract float %add502.5, %out_2.sroa.30.20.vec.extract, !dbg !183
  %out_3.sroa.30.20.vec.extract = extractelement <4 x float> %out_3.sroa.30.15, i64 1, !dbg !184
  %add516.5 = fadd contract float %add509.5, %out_3.sroa.30.20.vec.extract, !dbg !185
  %mul522.5 = fmul contract float %289, %add516.5, !dbg !186
  %295 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522.5), !dbg !187
  %oreg.sroa.7.10.insert.ext = zext i16 %295 to i64, !dbg !191
  %oreg.sroa.7.10.insert.shift = shl nuw nsw i64 %oreg.sroa.7.10.insert.ext, 16, !dbg !191
  %oreg.sroa.7.10.insert.insert = or disjoint i64 %oreg.sroa.7.10.insert.shift, %oreg.sroa.7.8.insert.ext, !dbg !191
  %out.sroa.42.24.vec.extract = extractelement <4 x float> %out.sroa.42.12, i64 2, !dbg !179
  %out_1.sroa.30.24.vec.extract = extractelement <4 x float> %out_1.sroa.30.12, i64 2, !dbg !180
  %add502.6 = fadd contract float %out.sroa.42.24.vec.extract, %out_1.sroa.30.24.vec.extract, !dbg !181
  %out_2.sroa.30.24.vec.extract = extractelement <4 x float> %out_2.sroa.30.15, i64 2, !dbg !182
  %add509.6 = fadd contract float %add502.6, %out_2.sroa.30.24.vec.extract, !dbg !183
  %out_3.sroa.30.24.vec.extract = extractelement <4 x float> %out_3.sroa.30.15, i64 2, !dbg !184
  %add516.6 = fadd contract float %add509.6, %out_3.sroa.30.24.vec.extract, !dbg !185
  %mul522.6 = fmul contract float %289, %add516.6, !dbg !186
  %296 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522.6), !dbg !187
  %oreg.sroa.7.12.insert.ext = zext i16 %296 to i64, !dbg !191
  %oreg.sroa.7.12.insert.shift = shl nuw nsw i64 %oreg.sroa.7.12.insert.ext, 32, !dbg !191
  %oreg.sroa.7.12.insert.insert = or disjoint i64 %oreg.sroa.7.10.insert.insert, %oreg.sroa.7.12.insert.shift, !dbg !191
  %out.sroa.42.28.vec.extract = extractelement <4 x float> %out.sroa.42.12, i64 3, !dbg !179
  %out_1.sroa.30.28.vec.extract = extractelement <4 x float> %out_1.sroa.30.12, i64 3, !dbg !180
  %add502.7 = fadd contract float %out.sroa.42.28.vec.extract, %out_1.sroa.30.28.vec.extract, !dbg !181
  %out_2.sroa.30.28.vec.extract = extractelement <4 x float> %out_2.sroa.30.15, i64 3, !dbg !182
  %add509.7 = fadd contract float %add502.7, %out_2.sroa.30.28.vec.extract, !dbg !183
  %out_3.sroa.30.28.vec.extract = extractelement <4 x float> %out_3.sroa.30.15, i64 3, !dbg !184
  %add516.7 = fadd contract float %add509.7, %out_3.sroa.30.28.vec.extract, !dbg !185
  %mul522.7 = fmul contract float %289, %add516.7, !dbg !186
  %297 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522.7), !dbg !187
  %oreg.sroa.7.14.insert.ext = zext i16 %297 to i64, !dbg !191
  %oreg.sroa.7.14.insert.shift = shl nuw i64 %oreg.sroa.7.14.insert.ext, 48, !dbg !191
  %oreg.sroa.7.14.insert.insert = or disjoint i64 %oreg.sroa.7.12.insert.insert, %oreg.sroa.7.14.insert.shift, !dbg !191
  %out.sroa.82.32.vec.extract = extractelement <4 x float> %out.sroa.82.12, i64 0, !dbg !179
  %out_1.sroa.58.32.vec.extract = extractelement <4 x float> %out_1.sroa.58.12, i64 0, !dbg !180
  %add502.8 = fadd contract float %out.sroa.82.32.vec.extract, %out_1.sroa.58.32.vec.extract, !dbg !181
  %out_2.sroa.58.32.vec.extract = extractelement <4 x float> %out_2.sroa.58.15, i64 0, !dbg !182
  %add509.8 = fadd contract float %add502.8, %out_2.sroa.58.32.vec.extract, !dbg !183
  %out_3.sroa.58.32.vec.extract = extractelement <4 x float> %out_3.sroa.58.15, i64 0, !dbg !184
  %add516.8 = fadd contract float %add509.8, %out_3.sroa.58.32.vec.extract, !dbg !185
  %mul522.8 = fmul contract float %289, %add516.8, !dbg !186
  %298 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522.8), !dbg !187
  %oreg.sroa.12.16.insert.ext = zext i16 %298 to i64, !dbg !191
  %out.sroa.82.36.vec.extract = extractelement <4 x float> %out.sroa.82.12, i64 1, !dbg !179
  %out_1.sroa.58.36.vec.extract = extractelement <4 x float> %out_1.sroa.58.12, i64 1, !dbg !180
  %add502.9 = fadd contract float %out.sroa.82.36.vec.extract, %out_1.sroa.58.36.vec.extract, !dbg !181
  %out_2.sroa.58.36.vec.extract = extractelement <4 x float> %out_2.sroa.58.15, i64 1, !dbg !182
  %add509.9 = fadd contract float %add502.9, %out_2.sroa.58.36.vec.extract, !dbg !183
  %out_3.sroa.58.36.vec.extract = extractelement <4 x float> %out_3.sroa.58.15, i64 1, !dbg !184
  %add516.9 = fadd contract float %add509.9, %out_3.sroa.58.36.vec.extract, !dbg !185
  %mul522.9 = fmul contract float %289, %add516.9, !dbg !186
  %299 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522.9), !dbg !187
  %oreg.sroa.12.18.insert.ext = zext i16 %299 to i64, !dbg !191
  %oreg.sroa.12.18.insert.shift = shl nuw nsw i64 %oreg.sroa.12.18.insert.ext, 16, !dbg !191
  %oreg.sroa.12.18.insert.insert = or disjoint i64 %oreg.sroa.12.18.insert.shift, %oreg.sroa.12.16.insert.ext, !dbg !191
  %out.sroa.82.40.vec.extract = extractelement <4 x float> %out.sroa.82.12, i64 2, !dbg !179
  %out_1.sroa.58.40.vec.extract = extractelement <4 x float> %out_1.sroa.58.12, i64 2, !dbg !180
  %add502.10 = fadd contract float %out.sroa.82.40.vec.extract, %out_1.sroa.58.40.vec.extract, !dbg !181
  %out_2.sroa.58.40.vec.extract = extractelement <4 x float> %out_2.sroa.58.15, i64 2, !dbg !182
  %add509.10 = fadd contract float %add502.10, %out_2.sroa.58.40.vec.extract, !dbg !183
  %out_3.sroa.58.40.vec.extract = extractelement <4 x float> %out_3.sroa.58.15, i64 2, !dbg !184
  %add516.10 = fadd contract float %add509.10, %out_3.sroa.58.40.vec.extract, !dbg !185
  %mul522.10 = fmul contract float %289, %add516.10, !dbg !186
  %300 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522.10), !dbg !187
  %oreg.sroa.12.20.insert.ext = zext i16 %300 to i64, !dbg !191
  %oreg.sroa.12.20.insert.shift = shl nuw nsw i64 %oreg.sroa.12.20.insert.ext, 32, !dbg !191
  %oreg.sroa.12.20.insert.insert = or disjoint i64 %oreg.sroa.12.18.insert.insert, %oreg.sroa.12.20.insert.shift, !dbg !191
  %out.sroa.82.44.vec.extract = extractelement <4 x float> %out.sroa.82.12, i64 3, !dbg !179
  %out_1.sroa.58.44.vec.extract = extractelement <4 x float> %out_1.sroa.58.12, i64 3, !dbg !180
  %add502.11 = fadd contract float %out.sroa.82.44.vec.extract, %out_1.sroa.58.44.vec.extract, !dbg !181
  %out_2.sroa.58.44.vec.extract = extractelement <4 x float> %out_2.sroa.58.15, i64 3, !dbg !182
  %add509.11 = fadd contract float %add502.11, %out_2.sroa.58.44.vec.extract, !dbg !183
  %out_3.sroa.58.44.vec.extract = extractelement <4 x float> %out_3.sroa.58.15, i64 3, !dbg !184
  %add516.11 = fadd contract float %add509.11, %out_3.sroa.58.44.vec.extract, !dbg !185
  %mul522.11 = fmul contract float %289, %add516.11, !dbg !186
  %301 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522.11), !dbg !187
  %oreg.sroa.12.22.insert.ext = zext i16 %301 to i64, !dbg !191
  %oreg.sroa.12.22.insert.shift = shl nuw i64 %oreg.sroa.12.22.insert.ext, 48, !dbg !191
  %oreg.sroa.12.22.insert.insert = or disjoint i64 %oreg.sroa.12.20.insert.insert, %oreg.sroa.12.22.insert.shift, !dbg !191
  %out.sroa.122.48.vec.extract = extractelement <4 x float> %out.sroa.122.12, i64 0, !dbg !179
  %out_1.sroa.86.48.vec.extract = extractelement <4 x float> %out_1.sroa.86.12, i64 0, !dbg !180
  %add502.12 = fadd contract float %out.sroa.122.48.vec.extract, %out_1.sroa.86.48.vec.extract, !dbg !181
  %out_2.sroa.86.48.vec.extract = extractelement <4 x float> %out_2.sroa.86.15, i64 0, !dbg !182
  %add509.12 = fadd contract float %add502.12, %out_2.sroa.86.48.vec.extract, !dbg !183
  %out_3.sroa.86.48.vec.extract = extractelement <4 x float> %out_3.sroa.86.15, i64 0, !dbg !184
  %add516.12 = fadd contract float %add509.12, %out_3.sroa.86.48.vec.extract, !dbg !185
  %mul522.12 = fmul contract float %289, %add516.12, !dbg !186
  %302 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522.12), !dbg !187
  %oreg.sroa.17.24.insert.ext = zext i16 %302 to i64, !dbg !191
  %out.sroa.122.52.vec.extract = extractelement <4 x float> %out.sroa.122.12, i64 1, !dbg !179
  %out_1.sroa.86.52.vec.extract = extractelement <4 x float> %out_1.sroa.86.12, i64 1, !dbg !180
  %add502.13 = fadd contract float %out.sroa.122.52.vec.extract, %out_1.sroa.86.52.vec.extract, !dbg !181
  %out_2.sroa.86.52.vec.extract = extractelement <4 x float> %out_2.sroa.86.15, i64 1, !dbg !182
  %add509.13 = fadd contract float %add502.13, %out_2.sroa.86.52.vec.extract, !dbg !183
  %out_3.sroa.86.52.vec.extract = extractelement <4 x float> %out_3.sroa.86.15, i64 1, !dbg !184
  %add516.13 = fadd contract float %add509.13, %out_3.sroa.86.52.vec.extract, !dbg !185
  %mul522.13 = fmul contract float %289, %add516.13, !dbg !186
  %303 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522.13), !dbg !187
  %oreg.sroa.17.26.insert.ext = zext i16 %303 to i64, !dbg !191
  %oreg.sroa.17.26.insert.shift = shl nuw nsw i64 %oreg.sroa.17.26.insert.ext, 16, !dbg !191
  %oreg.sroa.17.26.insert.insert = or disjoint i64 %oreg.sroa.17.26.insert.shift, %oreg.sroa.17.24.insert.ext, !dbg !191
  %out.sroa.122.56.vec.extract = extractelement <4 x float> %out.sroa.122.12, i64 2, !dbg !179
  %out_1.sroa.86.56.vec.extract = extractelement <4 x float> %out_1.sroa.86.12, i64 2, !dbg !180
  %add502.14 = fadd contract float %out.sroa.122.56.vec.extract, %out_1.sroa.86.56.vec.extract, !dbg !181
  %out_2.sroa.86.56.vec.extract = extractelement <4 x float> %out_2.sroa.86.15, i64 2, !dbg !182
  %add509.14 = fadd contract float %add502.14, %out_2.sroa.86.56.vec.extract, !dbg !183
  %out_3.sroa.86.56.vec.extract = extractelement <4 x float> %out_3.sroa.86.15, i64 2, !dbg !184
  %add516.14 = fadd contract float %add509.14, %out_3.sroa.86.56.vec.extract, !dbg !185
  %mul522.14 = fmul contract float %289, %add516.14, !dbg !186
  %304 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522.14), !dbg !187
  %oreg.sroa.17.28.insert.ext = zext i16 %304 to i64, !dbg !191
  %oreg.sroa.17.28.insert.shift = shl nuw nsw i64 %oreg.sroa.17.28.insert.ext, 32, !dbg !191
  %oreg.sroa.17.28.insert.insert = or disjoint i64 %oreg.sroa.17.26.insert.insert, %oreg.sroa.17.28.insert.shift, !dbg !191
  %out.sroa.122.60.vec.extract = extractelement <4 x float> %out.sroa.122.12, i64 3, !dbg !179
  %out_1.sroa.86.60.vec.extract = extractelement <4 x float> %out_1.sroa.86.12, i64 3, !dbg !180
  %add502.15 = fadd contract float %out.sroa.122.60.vec.extract, %out_1.sroa.86.60.vec.extract, !dbg !181
  %out_2.sroa.86.60.vec.extract = extractelement <4 x float> %out_2.sroa.86.15, i64 3, !dbg !182
  %add509.15 = fadd contract float %add502.15, %out_2.sroa.86.60.vec.extract, !dbg !183
  %out_3.sroa.86.60.vec.extract = extractelement <4 x float> %out_3.sroa.86.15, i64 3, !dbg !184
  %add516.15 = fadd contract float %add509.15, %out_3.sroa.86.60.vec.extract, !dbg !185
  %mul522.15 = fmul contract float %289, %add516.15, !dbg !186
  %305 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522.15), !dbg !187
  %oreg.sroa.17.30.insert.ext = zext i16 %305 to i64, !dbg !191
  %oreg.sroa.17.30.insert.shift = shl nuw i64 %oreg.sroa.17.30.insert.ext, 48, !dbg !191
  %oreg.sroa.17.30.insert.insert = or disjoint i64 %oreg.sroa.17.28.insert.insert, %oreg.sroa.17.30.insert.shift, !dbg !191
  %and542 = shl nuw nsw i32 %18, 6
  %mul543 = and i32 %and542, 960
  %and546 = lshr i32 %18, 5
  %shr547 = and i32 %and546, 1
  %and550 = and i32 %18, 7
  %mul556 = and i32 %25, 4
  %xor = xor i32 %shr547, %and550, !dbg !192
  %mul551 = shl nuw nsw i32 %xor, 3, !dbg !193
  %add552 = or disjoint i32 %mul551, %mul543, !dbg !194
  %add557 = or disjoint i32 %add552, %mul556, !dbg !195
  %add.ptr559 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add557, !dbg !196
  store i64 %oreg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr559, align 8, !dbg !197
  %xor.1 = xor i32 %and546, %and550, !dbg !192
  %mul551.1 = shl nuw nsw i32 %xor.1, 3, !dbg !193
  %add552.1 = or disjoint i32 %mul551.1, %mul543, !dbg !194
  %add557.1 = or disjoint i32 %add552.1, %mul556, !dbg !195
  %add.ptr559.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add557.1, !dbg !196
  store i64 %oreg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr559.1, align 8, !dbg !197
  %add548.2 = or disjoint i32 %shr547, 4, !dbg !198
  %xor.2 = xor i32 %add548.2, %and550, !dbg !192
  %mul551.2 = shl nuw nsw i32 %xor.2, 3, !dbg !193
  %add552.2 = or disjoint i32 %mul551.2, %mul543, !dbg !194
  %add557.2 = or disjoint i32 %add552.2, %mul556, !dbg !195
  %add.ptr559.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add557.2, !dbg !196
  store i64 %oreg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr559.2, align 8, !dbg !197
  %add548.3 = or i32 %and546, 6, !dbg !198
  %xor.3 = xor i32 %add548.3, %and550, !dbg !192
  %mul551.3 = shl nuw nsw i32 %xor.3, 3, !dbg !193
  %add552.3 = or disjoint i32 %mul551.3, %mul543, !dbg !194
  %add557.3 = or disjoint i32 %add552.3, %mul556, !dbg !195
  %add.ptr559.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add557.3, !dbg !196
  store i64 %oreg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr559.3, align 8, !dbg !197
  fence syncscope("warp") release, !dbg !199
  tail call void @llvm.mxc.barrier.warp(), !dbg !204
  fence syncscope("warp") acquire, !dbg !205
  %mul571 = and i32 %and138, 448
  %xor578 = xor i32 %and138, %18
  %mul579 = and i32 %xor578, 56
  %306 = or disjoint i32 %mul579, %mul571
  %mul584 = shl nsw i32 %0, 20
  %mul586 = shl nsw i32 %1, 10
  %add587 = add nuw nsw i32 %mul584, %mul586
  %307 = or disjoint i32 %add587, %mul318
  %308 = zext nneg i32 %307 to i64, !dbg !206
  %add.ptr582 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %306, !dbg !207
  %add.ptr595 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %308, !dbg !208
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr595, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr582, i64 16, i1 false), !dbg !209, !tbaa.struct !210, !call_argsrelate !211
  %309 = or disjoint i32 %306, 512, !dbg !212
  %add.ptr582.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %309, !dbg !207
  %310 = or disjoint i64 %308, 512, !dbg !213
  %add.ptr595.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %310, !dbg !208
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr595.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr582.1, i64 16, i1 false), !dbg !209, !tbaa.struct !210, !call_argsrelate !211
  br label %if.end599, !dbg !214

if.end599:                                        ; preds = %if.then488, %if.end484
  ret void, !dbg !214
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
!1 = !DIFile(filename: "/tmp/tmp7xdt47y8/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmp7xdt47y8/tvm_kernels.maca", directory: "")
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
!54 = !DILocation(line: 67, column: 3, scope: !55, inlinedAt: !57)
!55 = distinct !DISubprogram(name: "__fetch_builtin_x", scope: !56, file: !56, line: 67, type: !7, scopeLine: 67, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!56 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_builtin_vars.h", directory: "")
!57 = distinct !DILocation(line: 30, column: 14, scope: !40)
!58 = !{i32 0, i32 1024}
!59 = !DILocation(line: 30, column: 33, scope: !40)
!60 = !DILocation(line: 30, column: 7, scope: !40)
!61 = !DILocation(line: 32, column: 5, scope: !40)
!62 = !DILocation(line: 33, column: 161, scope: !40)
!63 = !DILocation(line: 33, column: 46, scope: !40)
!64 = !DILocation(line: 33, column: 32, scope: !40)
!65 = !DILocation(line: 37, column: 3, scope: !40)
!66 = !DILocation(line: 59, column: 3, scope: !40)
!67 = !DILocation(line: 60, column: 42, scope: !40)
!68 = !DILocation(line: 174, column: 24, scope: !40)
!69 = !DILocation(line: 1018, column: 9, scope: !70, inlinedAt: !72)
!70 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !71, file: !71, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!71 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!72 = distinct !DILocation(line: 176, column: 24, scope: !40)
!73 = !DILocation(line: 171, column: 37, scope: !74, inlinedAt: !75)
!74 = distinct !DISubprogram(name: "__lane_id", scope: !71, file: !71, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!75 = distinct !DILocation(line: 990, column: 14, scope: !76, inlinedAt: !77)
!76 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !71, file: !71, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!77 = distinct !DILocation(line: 1019, column: 11, scope: !70, inlinedAt: !72)
!78 = !DILocation(line: 171, column: 10, scope: !74, inlinedAt: !75)
!79 = !DILocation(line: 991, column: 20, scope: !76, inlinedAt: !77)
!80 = !DILocation(line: 992, column: 36, scope: !76, inlinedAt: !77)
!81 = !DILocation(line: 992, column: 17, scope: !76, inlinedAt: !77)
!82 = !DILocation(line: 992, column: 11, scope: !76, inlinedAt: !77)
!83 = !DILocation(line: 993, column: 43, scope: !76, inlinedAt: !77)
!84 = !DILocation(line: 993, column: 10, scope: !76, inlinedAt: !77)
!85 = !DILocation(line: 1020, column: 14, scope: !70, inlinedAt: !72)
!86 = !DILocation(line: 176, column: 22, scope: !40)
!87 = !DILocation(line: 1018, column: 9, scope: !70, inlinedAt: !88)
!88 = distinct !DILocation(line: 177, column: 24, scope: !40)
!89 = !DILocation(line: 171, column: 37, scope: !74, inlinedAt: !90)
!90 = distinct !DILocation(line: 990, column: 14, scope: !76, inlinedAt: !91)
!91 = distinct !DILocation(line: 1019, column: 11, scope: !70, inlinedAt: !88)
!92 = !DILocation(line: 171, column: 10, scope: !74, inlinedAt: !90)
!93 = !DILocation(line: 991, column: 20, scope: !76, inlinedAt: !91)
!94 = !DILocation(line: 992, column: 36, scope: !76, inlinedAt: !91)
!95 = !DILocation(line: 992, column: 17, scope: !76, inlinedAt: !91)
!96 = !DILocation(line: 992, column: 11, scope: !76, inlinedAt: !91)
!97 = !DILocation(line: 993, column: 43, scope: !76, inlinedAt: !91)
!98 = !DILocation(line: 993, column: 10, scope: !76, inlinedAt: !91)
!99 = !DILocation(line: 1020, column: 14, scope: !70, inlinedAt: !88)
!100 = !DILocation(line: 177, column: 22, scope: !40)
!101 = !DILocation(line: 179, column: 34, scope: !40)
!102 = !DILocation(line: 179, column: 9, scope: !40)
!103 = !DILocation(line: 185, column: 5, scope: !40)
!104 = !DILocation(line: 185, column: 56, scope: !40)
!105 = !{!106, !106, i64 0}
!106 = !{!"float", !19, i64 0}
!107 = !DILocation(line: 186, column: 3, scope: !40)
!108 = !DILocation(line: 64, column: 25, scope: !40)
!109 = !DILocation(line: 66, column: 11, scope: !40)
!110 = !DILocation(line: 67, column: 139, scope: !40)
!111 = !DILocation(line: 67, column: 67, scope: !40)
!112 = !DILocation(line: 67, column: 53, scope: !40)
!113 = !DILocation(line: 62, column: 30, scope: !40)
!114 = !DILocation(line: 74, column: 27, scope: !40)
!115 = !DILocation(line: 75, column: 33, scope: !40)
!116 = !DILocation(line: 75, column: 15, scope: !40)
!117 = !DILocation(line: 79, column: 76, scope: !40)
!118 = !DILocation(line: 79, column: 19, scope: !40)
!119 = !DILocation(line: 84, column: 26, scope: !40)
!120 = !DILocation(line: 79, column: 70, scope: !40)
!121 = !DILocation(line: 0, scope: !40)
!122 = !DILocation(line: 93, column: 37, scope: !40)
!123 = !DILocation(line: 100, column: 38, scope: !40)
!124 = !DILocation(line: 100, column: 51, scope: !40)
!125 = !DILocation(line: 354, column: 10, scope: !126, inlinedAt: !127)
!126 = distinct !DISubprogram(name: "min", scope: !46, file: !46, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!127 = distinct !DILocation(line: 100, column: 33, scope: !40)
!128 = !DILocation(line: 288, column: 10, scope: !129, inlinedAt: !130)
!129 = distinct !DISubprogram(name: "expf", scope: !46, file: !46, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!130 = distinct !DILocation(line: 100, column: 28, scope: !40)
!131 = !DILocation(line: 75, column: 10, scope: !132, inlinedAt: !134)
!132 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !133, file: !133, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!133 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!134 = distinct !DILocation(line: 984, column: 9, scope: !135, inlinedAt: !137)
!135 = distinct !DISubprogram(name: "__float2half", scope: !136, file: !136, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!136 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!137 = distinct !DILocation(line: 133, column: 53, scope: !138, inlinedAt: !139)
!138 = distinct !DISubprogram(name: "__half", scope: !136, file: !136, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!139 = distinct !DILocation(line: 105, column: 28, scope: !40)
!140 = !DILocation(line: 105, column: 25, scope: !40)
!141 = !DILocation(line: 111, column: 74, scope: !40)
!142 = !DILocation(line: 111, column: 44, scope: !40)
!143 = !DILocation(line: 111, column: 118, scope: !40)
!144 = !DILocation(line: 104, column: 38, scope: !40)
!145 = !DILocation(line: 111, column: 82, scope: !40)
!146 = !DILocation(line: 36, column: 26, scope: !40)
!147 = !DILocation(line: 60, column: 3, scope: !148, inlinedAt: !149)
!148 = distinct !DISubprogram(name: "__barrier", scope: !71, file: !71, line: 57, type: !7, scopeLine: 57, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!149 = distinct !DILocation(line: 74, column: 3, scope: !150, inlinedAt: !151)
!150 = distinct !DISubprogram(name: "__syncthreads", scope: !71, file: !71, line: 73, type: !7, scopeLine: 73, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!151 = distinct !DILocation(line: 168, column: 5, scope: !40)
!152 = !DILocation(line: 61, column: 3, scope: !148, inlinedAt: !149)
!153 = !DILocation(line: 62, column: 3, scope: !148, inlinedAt: !149)
!154 = !DILocation(line: 114, column: 42, scope: !40)
!155 = !DILocation(line: 118, column: 27, scope: !40)
!156 = !DILocation(line: 123, column: 69, scope: !40)
!157 = !DILocation(line: 123, column: 32, scope: !40)
!158 = !DILocation(line: 120, column: 11, scope: !40)
!159 = !DILocation(line: 121, column: 124, scope: !40)
!160 = !DILocation(line: 121, column: 52, scope: !40)
!161 = !DILocation(line: 121, column: 38, scope: !40)
!162 = !DILocation(line: 128, column: 36, scope: !40)
!163 = !{i32 4, i32 -1, i32 -1}
!164 = !DILocation(line: 116, column: 34, scope: !40)
!165 = !DILocation(line: 138, column: 40, scope: !40)
!166 = !DILocation(line: 123, column: 113, scope: !40)
!167 = !DILocation(line: 148, column: 40, scope: !40)
!168 = !DILocation(line: 157, column: 40, scope: !40)
!169 = !DILocation(line: 170, column: 7, scope: !40)
!170 = !DILocation(line: 60, column: 3, scope: !148, inlinedAt: !171)
!171 = distinct !DILocation(line: 74, column: 3, scope: !150, inlinedAt: !172)
!172 = distinct !DILocation(line: 187, column: 3, scope: !40)
!173 = !DILocation(line: 61, column: 3, scope: !148, inlinedAt: !171)
!174 = !DILocation(line: 62, column: 3, scope: !148, inlinedAt: !171)
!175 = !DILocation(line: 188, column: 33, scope: !40)
!176 = !DILocation(line: 188, column: 7, scope: !40)
!177 = !DILocation(line: 189, column: 58, scope: !40)
!178 = !DILocation(line: 189, column: 14, scope: !40)
!179 = !DILocation(line: 192, column: 20, scope: !40)
!180 = !DILocation(line: 192, column: 32, scope: !40)
!181 = !DILocation(line: 192, column: 30, scope: !40)
!182 = !DILocation(line: 193, column: 32, scope: !40)
!183 = !DILocation(line: 193, column: 30, scope: !40)
!184 = !DILocation(line: 194, column: 32, scope: !40)
!185 = !DILocation(line: 194, column: 30, scope: !40)
!186 = !DILocation(line: 195, column: 30, scope: !40)
!187 = !DILocation(line: 75, column: 10, scope: !132, inlinedAt: !188)
!188 = distinct !DILocation(line: 984, column: 9, scope: !135, inlinedAt: !189)
!189 = distinct !DILocation(line: 133, column: 53, scope: !138, inlinedAt: !190)
!190 = distinct !DILocation(line: 196, column: 21, scope: !40)
!191 = !DILocation(line: 196, column: 18, scope: !40)
!192 = !DILocation(line: 200, column: 129, scope: !40)
!193 = !DILocation(line: 200, column: 157, scope: !40)
!194 = !DILocation(line: 200, column: 79, scope: !40)
!195 = !DILocation(line: 200, column: 163, scope: !40)
!196 = !DILocation(line: 200, column: 42, scope: !40)
!197 = !DILocation(line: 200, column: 206, scope: !40)
!198 = !DILocation(line: 200, column: 93, scope: !40)
!199 = !DILocation(line: 68, column: 3, scope: !200, inlinedAt: !201)
!200 = distinct !DISubprogram(name: "__barrier_warp", scope: !71, file: !71, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!201 = distinct !DILocation(line: 192, column: 3, scope: !202, inlinedAt: !203)
!202 = distinct !DISubprogram(name: "__syncwarp", scope: !71, file: !71, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!203 = distinct !DILocation(line: 202, column: 5, scope: !40)
!204 = !DILocation(line: 69, column: 3, scope: !200, inlinedAt: !201)
!205 = !DILocation(line: 70, column: 3, scope: !200, inlinedAt: !201)
!206 = !DILocation(line: 204, column: 5, scope: !40)
!207 = !DILocation(line: 205, column: 176, scope: !40)
!208 = !DILocation(line: 205, column: 24, scope: !40)
!209 = !DILocation(line: 205, column: 139, scope: !40)
!210 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!211 = !{i32 2, i32 -1, i32 -1, i32 -1}
!212 = !DILocation(line: 205, column: 234, scope: !40)
!213 = !DILocation(line: 205, column: 103, scope: !40)
!214 = !DILocation(line: 208, column: 1, scope: !40)
