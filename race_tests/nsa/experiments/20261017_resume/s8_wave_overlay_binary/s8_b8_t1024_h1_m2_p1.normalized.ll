target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "mxc-metax-macahca"

%struct.mcDevMallocInfo.0 = type { i32, i32, ptr }
%struct.__half = type { i16 }

@buf_dyn_shmem = external protected local_unnamed_addr addrspace(3) global [0 x i8], align 1024
@mcDeviceMemoryInfo = weak protected addrspace(1) externally_initialized global [1 x %struct.mcDevMallocInfo.0] zeroinitializer, align 8
@llvm.compiler.used = appending addrspace(1) global [1 x ptr] [ptr addrspacecast (ptr addrspace(1) @mcDeviceMemoryInfo to ptr)], section "llvm.metadata"

define weak void @__cxa_pure_virtual() local_unnamed_addr #0 {
entry:
  tail call void @llvm.trap()
  unreachable
}

declare void @llvm.trap() #1

define weak void @__cxa_deleted_virtual() local_unnamed_addr #0 {
entry:
  tail call void @llvm.trap()
  unreachable
}

define weak protected void @__mcImplicitDeviceSynchronize() local_unnamed_addr #2 {
entry:
  %0 = tail call ptr addrspace(4) @llvm.mxc.implicitarg.ptr()
  %arrayidx.i.i = getelementptr inbounds i8, ptr addrspace(4) %0, i64 32
  %1 = load i64, ptr addrspace(4) %arrayidx.i.i, align 8, !tbaa !17
  %2 = inttoptr i64 %1 to ptr
  %arrayidx.i32.i = getelementptr inbounds i8, ptr addrspace(4) %0, i64 40
  %3 = load i64, ptr addrspace(4) %arrayidx.i32.i, align 8, !tbaa !17
  %4 = inttoptr i64 %3 to ptr
  %current_counter.i = getelementptr inbounds i8, ptr %4, i64 12
  %thread_counter.i = getelementptr inbounds i8, ptr %4, i64 16
  %5 = load ptr, ptr %thread_counter.i, align 8, !tbaa !21
  %cmp.not.i = icmp eq ptr %5, null
  br i1 %cmp.not.i, label %if.end.i, label %if.then.i

if.then.i:                                        ; preds = %entry
  %6 = tail call align 4 dereferenceable(64) ptr addrspace(4) @llvm.mxc.dispatch.ptr()
  %7 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 12
  %8 = load i32, ptr addrspace(4) %7, align 4, !range !28, !invariant.load !8
  %9 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 4
  %10 = load i32, ptr addrspace(4) %9, align 4, !invariant.load !8
  %conv.i14.i.i = and i32 %10, 65535
  %div.i15.i.i = udiv i32 %8, %conv.i14.i.i
  %mul.i16.i.i = mul i32 %div.i15.i.i, %conv.i14.i.i
  %cmp.i17.i.i = icmp ugt i32 %8, %mul.i16.i.i
  %conv2.i18.i.i = zext i1 %cmp.i17.i.i to i32
  %add.i19.i.i = add nuw i32 %div.i15.i.i, %conv2.i18.i.i
  %11 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 16
  %12 = load i32, ptr addrspace(4) %11, align 4, !range !28, !invariant.load !8
  %13 = lshr i32 %10, 16
  %div.i.i.i = udiv i32 %12, %13
  %mul.i.i.i = mul i32 %div.i.i.i, %13
  %cmp.i.i.i = icmp ugt i32 %12, %mul.i.i.i
  %conv2.i.i.i = zext i1 %cmp.i.i.i to i32
  %add.i.i.i = add nuw i32 %div.i.i.i, %conv2.i.i.i
  %14 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul.i.i = mul i32 %add.i.i.i, %14
  %15 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !range !29
  %mul320.i.i = add i32 %mul.i.i, %15
  %add.i.i = mul i32 %mul320.i.i, %add.i19.i.i
  %16 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %add8.i.i = add i32 %add.i.i, %16
  %conv.i.i = zext i32 %add8.i.i to i64
  %arrayidx.i = getelementptr inbounds i32, ptr %5, i64 %conv.i.i
  %17 = tail call i1 @llvm.mxc.is.private(ptr nonnull %arrayidx.i)
  br label %while.cond.i

while.cond.i:                                     ; preds = %while.body.i, %if.then.i
  br i1 %17, label %if.then.i.i, label %if.end.i.i

if.then.i.i:                                      ; preds = %while.cond.i
  %18 = load i32, ptr %arrayidx.i, align 4, !tbaa !30
  br label %_Z9atomicAddPii.exit.i

if.end.i.i:                                       ; preds = %while.cond.i
  %19 = atomicrmw or ptr %arrayidx.i, i32 0 syncscope("device-one-as") monotonic, align 4
  br label %_Z9atomicAddPii.exit.i

_Z9atomicAddPii.exit.i:                           ; preds = %if.end.i.i, %if.then.i.i
  %retval.0.i.i = phi i32 [ %18, %if.then.i.i ], [ %19, %if.end.i.i ]
  %cmp6.i = icmp sgt i32 %retval.0.i.i, 0
  br i1 %cmp6.i, label %while.body.i, label %if.end.i

while.body.i:                                     ; preds = %_Z9atomicAddPii.exit.i
  tail call void @llvm.mxc.sleep(i32 1)
  br label %while.cond.i, !llvm.loop !31

if.end.i:                                         ; preds = %_Z9atomicAddPii.exit.i, %entry
  %20 = tail call i1 @llvm.mxc.is.private(ptr nonnull %current_counter.i)
  br i1 %20, label %if.then.i36.i, label %if.end.i34.i

if.then.i36.i:                                    ; preds = %if.end.i
  %21 = load i32, ptr %current_counter.i, align 4, !tbaa !30
  %add.i37.i = add nsw i32 %21, -1
  store i32 %add.i37.i, ptr %current_counter.i, align 4, !tbaa !30
  br label %_Z9atomicAddPii.exit38.i

if.end.i34.i:                                     ; preds = %if.end.i
  %22 = atomicrmw add ptr %current_counter.i, i32 -1 syncscope("device-one-as") monotonic, align 4
  br label %_Z9atomicAddPii.exit38.i

_Z9atomicAddPii.exit38.i:                         ; preds = %if.end.i34.i, %if.then.i36.i
  %retval.0.i35.i = phi i32 [ %21, %if.then.i36.i ], [ %22, %if.end.i34.i ]
  %call_deep.i = getelementptr inbounds i8, ptr %4, i64 4
  %23 = load i32, ptr %call_deep.i, align 4, !tbaa !33
  %cmp8.i = icmp eq i32 %23, 0
  br i1 %cmp8.i, label %if.then9.i, label %if.else.i

if.then9.i:                                       ; preds = %_Z9atomicAddPii.exit38.i
  %cmp10.i = icmp slt i32 %retval.0.i35.i, 2
  br i1 %cmp10.i, label %if.then11.i, label %__mcImplicitDeviceSynchronizeImpl.exit

if.then11.i:                                      ; preds = %if.then9.i
  tail call void @llvm.mxc.sleep(i32 30)
  br label %__mcImplicitDeviceSynchronizeImpl.exit

if.else.i:                                        ; preds = %_Z9atomicAddPii.exit38.i
  %parent_wrap13.i = getelementptr inbounds i8, ptr %4, i64 24
  %24 = load ptr, ptr %parent_wrap13.i, align 8, !tbaa !34
  %25 = load i32, ptr %4, align 8, !tbaa !35
  %thread_counter15.i = getelementptr inbounds i8, ptr %24, i64 16
  %26 = load ptr, ptr %thread_counter15.i, align 8, !tbaa !21
  %idxprom.i = zext i32 %25 to i64
  %arrayidx16.i = getelementptr inbounds i32, ptr %26, i64 %idxprom.i
  %cmp17.i = icmp slt i32 %retval.0.i35.i, 2
  br i1 %cmp17.i, label %if.then18.i, label %if.end20.i

if.then18.i:                                      ; preds = %if.else.i
  %mqlwrap_slots.i = getelementptr inbounds i8, ptr %2, i64 24
  %27 = load ptr, ptr %mqlwrap_slots.i, align 8, !tbaa !36
  %sub.ptr.rhs.cast.i = ptrtoint ptr %27 to i64
  %sub.ptr.sub.i = sub i64 %3, %sub.ptr.rhs.cast.i
  %sub.ptr.div.i = sdiv exact i64 %sub.ptr.sub.i, 96
  %mqlwrap_slot_mask.i = getelementptr inbounds i8, ptr %2, i64 80
  %28 = load i64, ptr %mqlwrap_slot_mask.i, align 8, !tbaa !38
  %29 = inttoptr i64 %28 to ptr
  %idx.ext.i.i = and i64 %sub.ptr.div.i, 4294967295
  %add.ptr.i.i = getelementptr inbounds i32, ptr %29, i64 %idx.ext.i.i
  %30 = tail call i1 @llvm.mxc.is.private(ptr %add.ptr.i.i)
  br i1 %30, label %if.then.i.i.i, label %if.end.i.i.i

if.then.i.i.i:                                    ; preds = %if.then18.i
  %31 = load i32, ptr %add.ptr.i.i, align 4, !tbaa !30
  %and.i.i.i = and i32 %31, 2147483647
  store i32 %and.i.i.i, ptr %add.ptr.i.i, align 4, !tbaa !30
  br label %if.end20.i

if.end.i.i.i:                                     ; preds = %if.then18.i
  %32 = atomicrmw and ptr %add.ptr.i.i, i32 2147483647 syncscope("device-one-as") monotonic, align 4
  br label %if.end20.i

if.end20.i:                                       ; preds = %if.end.i.i.i, %if.then.i.i.i, %if.else.i
  %33 = tail call i1 @llvm.mxc.is.private(ptr %arrayidx16.i)
  br i1 %33, label %if.then.i41.i, label %if.end.i39.i

if.then.i41.i:                                    ; preds = %if.end20.i
  %34 = load i32, ptr %arrayidx16.i, align 4, !tbaa !30
  %add.i42.i = add nsw i32 %34, -1
  store i32 %add.i42.i, ptr %arrayidx16.i, align 4, !tbaa !30
  br label %__mcImplicitDeviceSynchronizeImpl.exit

if.end.i39.i:                                     ; preds = %if.end20.i
  %35 = atomicrmw add ptr %arrayidx16.i, i32 -1 syncscope("device-one-as") monotonic, align 4
  br label %__mcImplicitDeviceSynchronizeImpl.exit

__mcImplicitDeviceSynchronizeImpl.exit:           ; preds = %if.then9.i, %if.then11.i, %if.then.i41.i, %if.end.i39.i
  ret void
}

define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %BlockIndices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V.coerce) local_unnamed_addr #3 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul = shl nsw i32 %0, 13
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul7 = shl nsw i32 %1, 3
  %add = add nuw nsw i32 %mul, %mul7
  %2 = zext nneg i32 %add to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %2
  %3 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cond.i.i = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %3, i32 -1), !call_argsrelate !48
  %cond.i.i710 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64)
  %mul11 = shl nsw i32 %cond.i.i710, 4
  %4 = or disjoint i64 %2, 1
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !call_argsrelate !48
  %cond.i.i710.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64)
  %mul11.1 = shl nsw i32 %cond.i.i710.1, 4
  %6 = or disjoint i64 %2, 2
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !call_argsrelate !48
  %cond.i.i710.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64)
  %mul11.2 = shl nsw i32 %cond.i.i710.2, 4
  %8 = or disjoint i64 %2, 3
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !call_argsrelate !48
  %cond.i.i710.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64)
  %mul11.3 = shl nsw i32 %cond.i.i710.3, 4
  %10 = or disjoint i64 %2, 4
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !call_argsrelate !48
  %cond.i.i710.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64)
  %mul11.4 = shl nsw i32 %cond.i.i710.4, 4
  %12 = or disjoint i64 %2, 5
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !call_argsrelate !48
  %cond.i.i710.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64)
  %mul11.5 = shl nsw i32 %cond.i.i710.5, 4
  %14 = or disjoint i64 %2, 6
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !call_argsrelate !48
  %cond.i.i710.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64)
  %mul11.6 = shl nsw i32 %cond.i.i710.6, 4
  %16 = or disjoint i64 %2, 7
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !call_argsrelate !48
  %cond.i.i710.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64)
  %mul11.7 = shl nsw i32 %cond.i.i710.7, 4
  %18 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !58
  %cmp15 = icmp ult i32 %18, 64
  br i1 %cmp15, label %for.cond16.preheader, label %if.end

for.cond16.preheader:                             ; preds = %entry
  %mul22 = shl nsw i32 %0, 20
  %mul24 = shl nsw i32 %1, 10
  %add25 = add nuw nsw i32 %mul22, %mul24
  %and = shl nuw nsw i32 %18, 6
  %mul27 = and i32 %and, 960
  %add28 = or disjoint i32 %add25, %mul27
  %19 = lshr i32 %18, 1
  %mul34 = and i32 %19, 24
  %20 = zext nneg i32 %add28 to i64
  %21 = zext nneg i32 %mul34 to i64
  %22 = or disjoint i64 %20, %21
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %22
  %qr.sroa.0.0.copyload = load i16, ptr addrspace(4) %add.ptr, align 16
  %qr.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 2
  %qr.sroa.4.0.copyload = load i16, ptr addrspace(4) %qr.sroa.4.0.add.ptr.sroa_idx, align 2, !tbaa !30
  %qr.sroa.5.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 4
  %qr.sroa.5.0.copyload = load i16, ptr addrspace(4) %qr.sroa.5.0.add.ptr.sroa_idx, align 4
  %qr.sroa.6.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 6
  %qr.sroa.6.0.copyload = load i16, ptr addrspace(4) %qr.sroa.6.0.add.ptr.sroa_idx, align 2, !tbaa !30
  %qr.sroa.7.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %qr.sroa.7.0.copyload = load i16, ptr addrspace(4) %qr.sroa.7.0.add.ptr.sroa_idx, align 8
  %qr.sroa.8.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 10
  %qr.sroa.8.0.copyload = load i16, ptr addrspace(4) %qr.sroa.8.0.add.ptr.sroa_idx, align 2, !tbaa !30
  %qr.sroa.9.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 12
  %qr.sroa.9.0.copyload = load i16, ptr addrspace(4) %qr.sroa.9.0.add.ptr.sroa_idx, align 4
  %qr.sroa.10.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 14
  %qr.sroa.10.0.copyload = load i16, ptr addrspace(4) %qr.sroa.10.0.add.ptr.sroa_idx, align 2, !tbaa !30
  %23 = or disjoint i64 %20, %21
  %24 = or disjoint i64 %23, 32
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %24
  %qr.sroa.11.16.copyload = load i16, ptr addrspace(4) %add.ptr.1, align 16
  %qr.sroa.13.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr.1, i64 2
  %qr.sroa.13.16.copyload = load i16, ptr addrspace(4) %qr.sroa.13.16.add.ptr.1.sroa_idx, align 2, !tbaa !30
  %qr.sroa.14.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr.1, i64 4
  %qr.sroa.14.16.copyload = load i16, ptr addrspace(4) %qr.sroa.14.16.add.ptr.1.sroa_idx, align 4
  %qr.sroa.15.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr.1, i64 6
  %qr.sroa.15.16.copyload = load i16, ptr addrspace(4) %qr.sroa.15.16.add.ptr.1.sroa_idx, align 2, !tbaa !30
  %qr.sroa.16.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr.1, i64 8
  %qr.sroa.16.16.copyload = load i16, ptr addrspace(4) %qr.sroa.16.16.add.ptr.1.sroa_idx, align 8
  %qr.sroa.17.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr.1, i64 10
  %qr.sroa.17.16.copyload = load i16, ptr addrspace(4) %qr.sroa.17.16.add.ptr.1.sroa_idx, align 2, !tbaa !30
  %qr.sroa.18.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr.1, i64 12
  %qr.sroa.18.16.copyload = load i16, ptr addrspace(4) %qr.sroa.18.16.add.ptr.1.sroa_idx, align 4
  %qr.sroa.19.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr.1, i64 14
  %qr.sroa.19.16.copyload = load i16, ptr addrspace(4) %qr.sroa.19.16.add.ptr.1.sroa_idx, align 2, !tbaa !30
  %conv = zext i16 %qr.sroa.0.0.copyload to i32
  %conv54 = zext i16 %qr.sroa.4.0.copyload to i32
  %shl = shl nuw i32 %conv54, 16
  %or = or disjoint i32 %shl, %conv
  %25 = insertelement <4 x i32> poison, i32 %or, i64 0
  %conv.1 = zext i16 %qr.sroa.5.0.copyload to i32
  %conv54.1 = zext i16 %qr.sroa.6.0.copyload to i32
  %shl.1 = shl nuw i32 %conv54.1, 16
  %or.1 = or disjoint i32 %shl.1, %conv.1
  %26 = insertelement <4 x i32> %25, i32 %or.1, i64 1
  %conv.2 = zext i16 %qr.sroa.7.0.copyload to i32
  %conv54.2 = zext i16 %qr.sroa.8.0.copyload to i32
  %shl.2 = shl nuw i32 %conv54.2, 16
  %or.2 = or disjoint i32 %shl.2, %conv.2
  %27 = insertelement <4 x i32> %26, i32 %or.2, i64 2
  %conv.3 = zext i16 %qr.sroa.9.0.copyload to i32
  %conv54.3 = zext i16 %qr.sroa.10.0.copyload to i32
  %shl.3 = shl nuw i32 %conv54.3, 16
  %or.3 = or disjoint i32 %shl.3, %conv.3
  %28 = insertelement <4 x i32> %27, i32 %or.3, i64 3
  %resident.sroa.0.12.vec.insert2131 = bitcast <4 x i32> %28 to <4 x float>
  %conv.4 = zext i16 %qr.sroa.11.16.copyload to i32
  %conv54.4 = zext i16 %qr.sroa.13.16.copyload to i32
  %shl.4 = shl nuw i32 %conv54.4, 16
  %or.4 = or disjoint i32 %shl.4, %conv.4
  %29 = insertelement <4 x i32> poison, i32 %or.4, i64 0
  %conv.5 = zext i16 %qr.sroa.14.16.copyload to i32
  %conv54.5 = zext i16 %qr.sroa.15.16.copyload to i32
  %shl.5 = shl nuw i32 %conv54.5, 16
  %or.5 = or disjoint i32 %shl.5, %conv.5
  %30 = insertelement <4 x i32> %29, i32 %or.5, i64 1
  %conv.6 = zext i16 %qr.sroa.16.16.copyload to i32
  %conv54.6 = zext i16 %qr.sroa.17.16.copyload to i32
  %shl.6 = shl nuw i32 %conv54.6, 16
  %or.6 = or disjoint i32 %shl.6, %conv.6
  %31 = insertelement <4 x i32> %30, i32 %or.6, i64 2
  %conv.7 = zext i16 %qr.sroa.18.16.copyload to i32
  %conv54.7 = zext i16 %qr.sroa.19.16.copyload to i32
  %shl.7 = shl nuw i32 %conv54.7, 16
  %or.7 = or disjoint i32 %shl.7, %conv.7
  %32 = insertelement <4 x i32> %31, i32 %or.7, i64 3
  %resident.sroa.74.28.vec.insert2227 = bitcast <4 x i32> %32 to <4 x float>
  br label %if.end

if.end:                                           ; preds = %entry, %for.cond16.preheader
  %resident.sroa.74.0 = phi <4 x float> [ %resident.sroa.74.28.vec.insert2227, %for.cond16.preheader ], [ zeroinitializer, %entry ]
  %resident.sroa.0.0 = phi <4 x float> [ %resident.sroa.0.12.vec.insert2131, %for.cond16.preheader ], [ zeroinitializer, %entry ]
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
  %34 = zext nneg i32 %and121 to i64
  %35 = zext nneg i32 %mul302 to i64
  br i1 %cmp91, label %if.end419, label %for.cond94.preheader

for.body431.preheader:                            ; preds = %if.end419.2
  %resident.sroa.146.32.vec.extract = extractelement <4 x float> %resident.sroa.146.30, i64 0
  %add436 = fadd contract float %resident.sroa.146.32.vec.extract, 0.000000e+00
  %resident.sroa.146.36.vec.extract2349 = extractelement <4 x float> %resident.sroa.146.30, i64 1
  %add436.1 = fadd contract float %add436, %resident.sroa.146.36.vec.extract2349
  %resident.sroa.146.40.vec.extract2408 = extractelement <4 x float> %resident.sroa.146.30, i64 2
  %add436.2 = fadd contract float %add436.1, %resident.sroa.146.40.vec.extract2408
  %resident.sroa.146.44.vec.extract2467 = extractelement <4 x float> %resident.sroa.146.30, i64 3
  %add436.3 = fadd contract float %add436.2, %resident.sroa.146.44.vec.extract2467
  %36 = bitcast float %add436.3 to i32
  %37 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %38 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %37) #11
  %xor.i.i = xor i32 %38, 32
  %39 = and i32 %38, -64
  %and.i.i = add nsw i32 %39, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i711 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %38
  %shl.i.i = shl i32 %cond.i.i711, 2
  %40 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %36)
  %41 = bitcast i32 %40 to float
  %add444 = fadd contract float %add436.3, %41
  %42 = bitcast float %add444 to i32
  %43 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %44 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %43) #11
  %xor.i.i712 = xor i32 %44, 16
  %45 = and i32 %44, -64
  %and.i.i713 = add nsw i32 %45, 64
  %cmp.not.i.i714 = icmp slt i32 %xor.i.i712, %and.i.i713
  %cond.i.i715 = select i1 %cmp.not.i.i714, i32 %xor.i.i712, i32 %44
  %shl.i.i716 = shl i32 %cond.i.i715, 2
  %46 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i716, i32 %42)
  %47 = bitcast i32 %46 to float
  %add449 = fadd contract float %add444, %47
  %cmp452 = fcmp contract ogt float %add449, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add449
  %condval_1.0 = select i1 %cmp452, float %div, float 0.000000e+00
  %arrayidx462 = getelementptr inbounds float, ptr addrspace(3) @buf_dyn_shmem, i32 %18
  store float %condval_1.0, ptr addrspace(3) %arrayidx462, align 4, !tbaa !111
  br label %if.end463

for.cond94.preheader:                             ; preds = %if.end
  %or.cond747 = icmp ugt i32 %mul11, 1023
  %cmp107.not = icmp sgt i32 %mul11, %1
  %or.cond748 = or i1 %or.cond747, %cmp107.not
  br i1 %or.cond748, label %if.end135, label %for.cond109.preheader

for.cond109.preheader:                            ; preds = %for.cond94.preheader
  %48 = shl nsw i32 %cond.i.i710, 10
  %mul116 = and i32 %48, 64512
  %add117 = or disjoint i32 %mul116, %mul114
  %49 = zext nneg i32 %add117 to i64
  %50 = or disjoint i64 %49, %34
  %add.ptr125 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %50
  %kr.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr125, align 16
  %kr.sroa.68.0.add.ptr125.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125, i64 8
  %kr.sroa.68.0.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.68.0.add.ptr125.sroa_idx, align 8
  %51 = or disjoint i64 %49, %34
  %52 = or disjoint i64 %51, 512
  %add.ptr125.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %52
  %kr.sroa.119.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr125.1, align 16
  %kr.sroa.185.16.add.ptr125.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1, i64 8
  %kr.sroa.185.16.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.185.16.add.ptr125.1.sroa_idx, align 8
  br label %if.end135

if.end135:                                        ; preds = %for.cond109.preheader, %for.cond94.preheader
  %kr.sroa.185.0 = phi <4 x half> [ undef, %for.cond94.preheader ], [ %kr.sroa.185.16.copyload, %for.cond109.preheader ]
  %kr.sroa.119.0 = phi <4 x half> [ undef, %for.cond94.preheader ], [ %kr.sroa.119.16.copyload, %for.cond109.preheader ]
  %kr.sroa.68.0 = phi <4 x half> [ undef, %for.cond94.preheader ], [ %kr.sroa.68.0.copyload, %for.cond109.preheader ]
  %kr.sroa.0.0 = phi <4 x half> [ undef, %for.cond94.preheader ], [ %kr.sroa.0.0.copyload, %for.cond109.preheader ]
  %or.cond747.1 = icmp ugt i32 %mul11.1, 1023
  %cmp107.not.1 = icmp sgt i32 %mul11.1, %1
  %or.cond748.1 = or i1 %or.cond747.1, %cmp107.not.1
  br i1 %or.cond748.1, label %if.end135.1, label %for.cond109.preheader.1

for.cond109.preheader.1:                          ; preds = %if.end135
  %53 = shl nsw i32 %cond.i.i710.1, 10
  %mul116.1 = and i32 %53, 64512
  %add117.1 = or disjoint i32 %mul116.1, %mul114
  %54 = zext nneg i32 %add117.1 to i64
  %55 = or disjoint i64 %54, %34
  %add.ptr125.1769 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %55
  %kr.sroa.236.32.copyload = load <4 x half>, ptr addrspace(4) %add.ptr125.1769, align 16
  %kr.sroa.242.32.add.ptr125.1769.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1769, i64 8
  %kr.sroa.242.32.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.242.32.add.ptr125.1769.sroa_idx, align 8
  %56 = or disjoint i64 %54, %34
  %57 = or disjoint i64 %56, 512
  %add.ptr125.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %57
  %kr.sroa.245.48.copyload = load <4 x half>, ptr addrspace(4) %add.ptr125.1.1, align 16
  %kr.sroa.251.48.add.ptr125.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1.1, i64 8
  %kr.sroa.251.48.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.251.48.add.ptr125.1.1.sroa_idx, align 8
  br label %if.end135.1

if.end135.1:                                      ; preds = %for.cond109.preheader.1, %if.end135
  %kr.sroa.251.0 = phi <4 x half> [ undef, %if.end135 ], [ %kr.sroa.251.48.copyload, %for.cond109.preheader.1 ]
  %kr.sroa.245.0 = phi <4 x half> [ undef, %if.end135 ], [ %kr.sroa.245.48.copyload, %for.cond109.preheader.1 ]
  %kr.sroa.242.0 = phi <4 x half> [ undef, %if.end135 ], [ %kr.sroa.242.32.copyload, %for.cond109.preheader.1 ]
  %kr.sroa.236.0 = phi <4 x half> [ undef, %if.end135 ], [ %kr.sroa.236.32.copyload, %for.cond109.preheader.1 ]
  %or.cond747.2 = icmp ugt i32 %mul11.2, 1023
  %cmp107.not.2 = icmp sgt i32 %mul11.2, %1
  %or.cond748.2 = or i1 %or.cond747.2, %cmp107.not.2
  br i1 %or.cond748.2, label %if.end135.2, label %for.cond109.preheader.2

for.cond109.preheader.2:                          ; preds = %if.end135.1
  %58 = shl nsw i32 %cond.i.i710.2, 10
  %mul116.2 = and i32 %58, 64512
  %add117.2 = or disjoint i32 %mul116.2, %mul114
  %59 = zext nneg i32 %add117.2 to i64
  %60 = or disjoint i64 %59, %34
  %add.ptr125.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %60
  %kr.sroa.254.64.copyload = load <4 x half>, ptr addrspace(4) %add.ptr125.2, align 16
  %kr.sroa.260.64.add.ptr125.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.2, i64 8
  %kr.sroa.260.64.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.260.64.add.ptr125.2.sroa_idx, align 8
  %61 = or disjoint i64 %59, %34
  %62 = or disjoint i64 %61, 512
  %add.ptr125.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %62
  %kr.sroa.263.80.copyload = load <4 x half>, ptr addrspace(4) %add.ptr125.1.2, align 16
  %kr.sroa.269.80.add.ptr125.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1.2, i64 8
  %kr.sroa.269.80.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.269.80.add.ptr125.1.2.sroa_idx, align 8
  br label %if.end135.2

if.end135.2:                                      ; preds = %for.cond109.preheader.2, %if.end135.1
  %kr.sroa.269.0 = phi <4 x half> [ undef, %if.end135.1 ], [ %kr.sroa.269.80.copyload, %for.cond109.preheader.2 ]
  %kr.sroa.263.0 = phi <4 x half> [ undef, %if.end135.1 ], [ %kr.sroa.263.80.copyload, %for.cond109.preheader.2 ]
  %kr.sroa.260.0 = phi <4 x half> [ undef, %if.end135.1 ], [ %kr.sroa.260.64.copyload, %for.cond109.preheader.2 ]
  %kr.sroa.254.0 = phi <4 x half> [ undef, %if.end135.1 ], [ %kr.sroa.254.64.copyload, %for.cond109.preheader.2 ]
  %or.cond747.3 = icmp ugt i32 %mul11.3, 1023
  %cmp107.not.3 = icmp sgt i32 %mul11.3, %1
  %or.cond748.3 = or i1 %or.cond747.3, %cmp107.not.3
  br i1 %or.cond748.3, label %if.end135.3, label %for.cond109.preheader.3

for.cond109.preheader.3:                          ; preds = %if.end135.2
  %63 = shl nsw i32 %cond.i.i710.3, 10
  %mul116.3 = and i32 %63, 64512
  %add117.3 = or disjoint i32 %mul116.3, %mul114
  %64 = zext nneg i32 %add117.3 to i64
  %65 = or disjoint i64 %64, %34
  %add.ptr125.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %65
  %kr.sroa.272.96.copyload = load <4 x half>, ptr addrspace(4) %add.ptr125.3, align 16
  %kr.sroa.278.96.add.ptr125.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.3, i64 8
  %kr.sroa.278.96.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.278.96.add.ptr125.3.sroa_idx, align 8
  %66 = or disjoint i64 %64, %34
  %67 = or disjoint i64 %66, 512
  %add.ptr125.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %67
  %kr.sroa.281.112.copyload = load <4 x half>, ptr addrspace(4) %add.ptr125.1.3, align 16
  %kr.sroa.287.112.add.ptr125.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1.3, i64 8
  %kr.sroa.287.112.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.287.112.add.ptr125.1.3.sroa_idx, align 8
  br label %if.end135.3

if.end135.3:                                      ; preds = %for.cond109.preheader.3, %if.end135.2
  %kr.sroa.287.0 = phi <4 x half> [ undef, %if.end135.2 ], [ %kr.sroa.287.112.copyload, %for.cond109.preheader.3 ]
  %kr.sroa.281.0 = phi <4 x half> [ undef, %if.end135.2 ], [ %kr.sroa.281.112.copyload, %for.cond109.preheader.3 ]
  %kr.sroa.278.0 = phi <4 x half> [ undef, %if.end135.2 ], [ %kr.sroa.278.96.copyload, %for.cond109.preheader.3 ]
  %kr.sroa.272.0 = phi <4 x half> [ undef, %if.end135.2 ], [ %kr.sroa.272.96.copyload, %for.cond109.preheader.3 ]
  br i1 %or.cond748, label %if.end252, label %if.then153

if.then153:                                       ; preds = %if.end135.3
  %cmp156 = icmp sgt i32 %mul11, %invariant.op
  br i1 %cmp156, label %for.cond158.preheader, label %if.end184

for.cond158.preheader:                            ; preds = %if.then153
  %add166 = or disjoint i32 %mul11, %mul165
  %cmp169.not = icmp sgt i32 %add166, %1
  %spec.select = select i1 %cmp169.not, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1059 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp169.not.1.not = icmp slt i32 %add166, %1
  %spec.select.1 = select i1 %cmp169.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1198 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1059, float %spec.select.1, i64 1
  %add167.2 = or disjoint i32 %add166, 2
  %cmp169.not.2 = icmp sgt i32 %add167.2, %1
  %spec.select.2 = select i1 %cmp169.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1315 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1198, float %spec.select.2, i64 2
  %add167.3 = or disjoint i32 %add166, 3
  %cmp169.not.3 = icmp sgt i32 %add167.3, %1
  %spec.select.3 = select i1 %cmp169.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1432 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1315, float %spec.select.3, i64 3
  br label %if.end184

if.end184:                                        ; preds = %if.then153, %for.cond158.preheader
  %scores.sroa.0.0 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1432, %for.cond158.preheader ], [ zeroinitializer, %if.then153 ]
  %resident.sroa.0.0.vec.extract = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>
  %68 = bitcast <2 x float> %resident.sroa.0.0.vec.extract to <4 x half>
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0, <4 x half> %68, <4 x float> %scores.sroa.0.0)
  %resident.sroa.0.8.vec.extract = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>
  %70 = bitcast <2 x float> %resident.sroa.0.8.vec.extract to <4 x half>
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.68.0, <4 x half> %70, <4 x float> %69)
  %resident.sroa.74.16.vec.extract = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>
  %72 = bitcast <2 x float> %resident.sroa.74.16.vec.extract to <4 x half>
  %73 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.119.0, <4 x half> %72, <4 x float> %71)
  %resident.sroa.74.24.vec.extract = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>
  %74 = bitcast <2 x float> %resident.sroa.74.24.vec.extract to <4 x half>
  %75 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.185.0, <4 x half> %74, <4 x float> %73)
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %75, i64 0
  %mul210 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %76 = tail call contract noundef float @llvm.minnum.f32(float %mul210, float 0x4024CB5EC0000000)
  %77 = tail call contract noundef float @llvm.exp.f32(float %76)
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %75, i64 1
  %mul210.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %78 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1, float 0x4024CB5EC0000000)
  %79 = tail call contract noundef float @llvm.exp.f32(float %78)
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %75, i64 2
  %mul210.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %80 = tail call contract noundef float @llvm.minnum.f32(float %mul210.2, float 0x4024CB5EC0000000)
  %81 = tail call contract noundef float @llvm.exp.f32(float %80)
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %75, i64 3
  %mul210.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %82 = tail call contract noundef float @llvm.minnum.f32(float %mul210.3, float 0x4024CB5EC0000000)
  %83 = tail call contract noundef float @llvm.exp.f32(float %82)
  %resident.sroa.146.32.vec.insert = insertelement <4 x float> poison, float %77, i64 0
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %77)
  %probs.sroa.0.0.vec.insert = insertelement <4 x i16> poison, i16 %84, i64 0
  %resident.sroa.146.36.vec.insert2303 = insertelement <4 x float> %resident.sroa.146.32.vec.insert, float %79, i64 1
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %79)
  %probs.sroa.0.2.vec.insert = insertelement <4 x i16> %probs.sroa.0.0.vec.insert, i16 %85, i64 1
  %resident.sroa.146.40.vec.insert2362 = insertelement <4 x float> %resident.sroa.146.36.vec.insert2303, float %81, i64 2
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %81)
  %probs.sroa.0.4.vec.insert = insertelement <4 x i16> %probs.sroa.0.2.vec.insert, i16 %86, i64 2
  %resident.sroa.146.44.vec.insert2421 = insertelement <4 x float> %resident.sroa.146.40.vec.insert2362, float %83, i64 3
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %83)
  %probs.sroa.0.6.vec.insert = insertelement <4 x i16> %probs.sroa.0.4.vec.insert, i16 %87, i64 3
  br label %if.end252

if.end252:                                        ; preds = %if.end135.3, %if.end184
  %resident.sroa.146.1 = phi <4 x float> [ %resident.sroa.146.44.vec.insert2421, %if.end184 ], [ zeroinitializer, %if.end135.3 ]
  %probs.sroa.0.0 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert, %if.end184 ], [ zeroinitializer, %if.end135.3 ]
  %add.ptr263 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and259
  store <4 x i16> %probs.sroa.0.0, ptr addrspace(3) %add.ptr263, align 8
  br i1 %or.cond748.1, label %if.end252.1, label %if.then153.1

if.then153.1:                                     ; preds = %if.end252
  %cmp156.1 = icmp sgt i32 %mul11.1, %invariant.op
  br i1 %cmp156.1, label %for.cond158.preheader.1, label %if.end184.1

for.cond158.preheader.1:                          ; preds = %if.then153.1
  %add166.1 = or disjoint i32 %mul11.1, %mul165
  %cmp169.not.1772 = icmp sgt i32 %add166.1, %1
  %spec.select.1773 = select i1 %cmp169.not.1772, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1068 = insertelement <4 x float> poison, float %spec.select.1773, i64 0
  %cmp169.not.1.1.not = icmp slt i32 %add166.1, %1
  %spec.select.1.1 = select i1 %cmp169.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1205 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1068, float %spec.select.1.1, i64 1
  %add167.2.1 = or disjoint i32 %add166.1, 2
  %cmp169.not.2.1 = icmp sgt i32 %add167.2.1, %1
  %spec.select.2.1 = select i1 %cmp169.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1322 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1205, float %spec.select.2.1, i64 2
  %add167.3.1 = or disjoint i32 %add166.1, 3
  %cmp169.not.3.1 = icmp sgt i32 %add167.3.1, %1
  %spec.select.3.1 = select i1 %cmp169.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1439 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1322, float %spec.select.3.1, i64 3
  br label %if.end184.1

if.end184.1:                                      ; preds = %if.then153.1, %for.cond158.preheader.1
  %scores.sroa.0.2 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1439, %for.cond158.preheader.1 ], [ zeroinitializer, %if.then153.1 ]
  %resident.sroa.0.0.vec.extract2049 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>
  %88 = bitcast <2 x float> %resident.sroa.0.0.vec.extract2049 to <4 x half>
  %89 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.236.0, <4 x half> %88, <4 x float> %scores.sroa.0.2)
  %resident.sroa.0.8.vec.extract2091 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>
  %90 = bitcast <2 x float> %resident.sroa.0.8.vec.extract2091 to <4 x half>
  %91 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.242.0, <4 x half> %90, <4 x float> %89)
  %resident.sroa.74.16.vec.extract2145 = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>
  %92 = bitcast <2 x float> %resident.sroa.74.16.vec.extract2145 to <4 x half>
  %93 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.245.0, <4 x half> %92, <4 x float> %91)
  %resident.sroa.74.24.vec.extract2187 = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>
  %94 = bitcast <2 x float> %resident.sroa.74.24.vec.extract2187 to <4 x half>
  %95 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.251.0, <4 x half> %94, <4 x float> %93)
  %scores.sroa.0.0.vec.extract1070 = extractelement <4 x float> %95, i64 0
  %mul210.1776 = fmul contract float %scores.sroa.0.0.vec.extract1070, 0x3FB99999A0000000
  %96 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1776, float 0x4024CB5EC0000000)
  %97 = tail call contract noundef float @llvm.exp.f32(float %96)
  %scores.sroa.0.4.vec.extract1207 = extractelement <4 x float> %95, i64 1
  %mul210.1.1 = fmul contract float %scores.sroa.0.4.vec.extract1207, 0x3FB99999A0000000
  %98 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1.1, float 0x4024CB5EC0000000)
  %99 = tail call contract noundef float @llvm.exp.f32(float %98)
  %scores.sroa.0.8.vec.extract1324 = extractelement <4 x float> %95, i64 2
  %mul210.2.1 = fmul contract float %scores.sroa.0.8.vec.extract1324, 0x3FB99999A0000000
  %100 = tail call contract noundef float @llvm.minnum.f32(float %mul210.2.1, float 0x4024CB5EC0000000)
  %101 = tail call contract noundef float @llvm.exp.f32(float %100)
  %scores.sroa.0.12.vec.extract1441 = extractelement <4 x float> %95, i64 3
  %mul210.3.1 = fmul contract float %scores.sroa.0.12.vec.extract1441, 0x3FB99999A0000000
  %102 = tail call contract noundef float @llvm.minnum.f32(float %mul210.3.1, float 0x4024CB5EC0000000)
  %103 = tail call contract noundef float @llvm.exp.f32(float %102)
  %resident.sroa.146.32.vec.extract2248 = extractelement <4 x float> %resident.sroa.146.1, i64 0
  %add227.1778 = fadd contract float %resident.sroa.146.32.vec.extract2248, %97
  %resident.sroa.146.32.vec.insert2250 = insertelement <4 x float> poison, float %add227.1778, i64 0
  %104 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %97)
  %probs.sroa.0.0.vec.insert1598 = insertelement <4 x i16> poison, i16 %104, i64 0
  %resident.sroa.146.36.vec.extract2305 = extractelement <4 x float> %resident.sroa.146.1, i64 1
  %add227.1.1 = fadd contract float %resident.sroa.146.36.vec.extract2305, %99
  %resident.sroa.146.36.vec.insert2307 = insertelement <4 x float> %resident.sroa.146.32.vec.insert2250, float %add227.1.1, i64 1
  %105 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %99)
  %probs.sroa.0.2.vec.insert1644 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1598, i16 %105, i64 1
  %resident.sroa.146.40.vec.extract2364 = extractelement <4 x float> %resident.sroa.146.1, i64 2
  %add227.2.1 = fadd contract float %resident.sroa.146.40.vec.extract2364, %101
  %resident.sroa.146.40.vec.insert2366 = insertelement <4 x float> %resident.sroa.146.36.vec.insert2307, float %add227.2.1, i64 2
  %106 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %101)
  %probs.sroa.0.4.vec.insert1689 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1644, i16 %106, i64 2
  %resident.sroa.146.44.vec.extract2423 = extractelement <4 x float> %resident.sroa.146.1, i64 3
  %add227.3.1 = fadd contract float %resident.sroa.146.44.vec.extract2423, %103
  %resident.sroa.146.44.vec.insert2425 = insertelement <4 x float> %resident.sroa.146.40.vec.insert2366, float %add227.3.1, i64 3
  %107 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %103)
  %probs.sroa.0.6.vec.insert1711 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1689, i16 %107, i64 3
  br label %if.end252.1

if.end252.1:                                      ; preds = %if.end252, %if.end184.1
  %resident.sroa.146.2 = phi <4 x float> [ %resident.sroa.146.44.vec.insert2425, %if.end184.1 ], [ %resident.sroa.146.1, %if.end252 ]
  %probs.sroa.0.1 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1711, %if.end184.1 ], [ zeroinitializer, %if.end252 ]
  %add261.1 = or disjoint i32 %and259, 256
  %add.ptr263.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add261.1
  store <4 x i16> %probs.sroa.0.1, ptr addrspace(3) %add.ptr263.1, align 8
  br i1 %or.cond748.2, label %if.end252.2, label %if.then153.2

if.then153.2:                                     ; preds = %if.end252.1
  %cmp156.2 = icmp sgt i32 %mul11.2, %invariant.op
  br i1 %cmp156.2, label %for.cond158.preheader.2, label %if.end184.2

for.cond158.preheader.2:                          ; preds = %if.then153.2
  %add166.2 = or disjoint i32 %mul11.2, %mul165
  %cmp169.not.2779 = icmp sgt i32 %add166.2, %1
  %spec.select.2780 = select i1 %cmp169.not.2779, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1078 = insertelement <4 x float> poison, float %spec.select.2780, i64 0
  %cmp169.not.1.2.not = icmp slt i32 %add166.2, %1
  %spec.select.1.2 = select i1 %cmp169.not.1.2.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1213 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1078, float %spec.select.1.2, i64 1
  %add167.2.2 = or disjoint i32 %add166.2, 2
  %cmp169.not.2.2 = icmp sgt i32 %add167.2.2, %1
  %spec.select.2.2 = select i1 %cmp169.not.2.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1330 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1213, float %spec.select.2.2, i64 2
  %add167.3.2 = or disjoint i32 %add166.2, 3
  %cmp169.not.3.2 = icmp sgt i32 %add167.3.2, %1
  %spec.select.3.2 = select i1 %cmp169.not.3.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1447 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1330, float %spec.select.3.2, i64 3
  br label %if.end184.2

if.end184.2:                                      ; preds = %if.then153.2, %for.cond158.preheader.2
  %scores.sroa.0.4 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1447, %for.cond158.preheader.2 ], [ zeroinitializer, %if.then153.2 ]
  %resident.sroa.0.0.vec.extract2051 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>
  %108 = bitcast <2 x float> %resident.sroa.0.0.vec.extract2051 to <4 x half>
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.254.0, <4 x half> %108, <4 x float> %scores.sroa.0.4)
  %resident.sroa.0.8.vec.extract2093 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>
  %110 = bitcast <2 x float> %resident.sroa.0.8.vec.extract2093 to <4 x half>
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.260.0, <4 x half> %110, <4 x float> %109)
  %resident.sroa.74.16.vec.extract2147 = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>
  %112 = bitcast <2 x float> %resident.sroa.74.16.vec.extract2147 to <4 x half>
  %113 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.263.0, <4 x half> %112, <4 x float> %111)
  %resident.sroa.74.24.vec.extract2189 = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>
  %114 = bitcast <2 x float> %resident.sroa.74.24.vec.extract2189 to <4 x half>
  %115 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.269.0, <4 x half> %114, <4 x float> %113)
  %scores.sroa.0.0.vec.extract1080 = extractelement <4 x float> %115, i64 0
  %mul210.2783 = fmul contract float %scores.sroa.0.0.vec.extract1080, 0x3FB99999A0000000
  %116 = tail call contract noundef float @llvm.minnum.f32(float %mul210.2783, float 0x4024CB5EC0000000)
  %117 = tail call contract noundef float @llvm.exp.f32(float %116)
  %scores.sroa.0.4.vec.extract1215 = extractelement <4 x float> %115, i64 1
  %mul210.1.2 = fmul contract float %scores.sroa.0.4.vec.extract1215, 0x3FB99999A0000000
  %118 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1.2, float 0x4024CB5EC0000000)
  %119 = tail call contract noundef float @llvm.exp.f32(float %118)
  %scores.sroa.0.8.vec.extract1332 = extractelement <4 x float> %115, i64 2
  %mul210.2.2 = fmul contract float %scores.sroa.0.8.vec.extract1332, 0x3FB99999A0000000
  %120 = tail call contract noundef float @llvm.minnum.f32(float %mul210.2.2, float 0x4024CB5EC0000000)
  %121 = tail call contract noundef float @llvm.exp.f32(float %120)
  %scores.sroa.0.12.vec.extract1449 = extractelement <4 x float> %115, i64 3
  %mul210.3.2 = fmul contract float %scores.sroa.0.12.vec.extract1449, 0x3FB99999A0000000
  %122 = tail call contract noundef float @llvm.minnum.f32(float %mul210.3.2, float 0x4024CB5EC0000000)
  %123 = tail call contract noundef float @llvm.exp.f32(float %122)
  %resident.sroa.146.32.vec.extract2252 = extractelement <4 x float> %resident.sroa.146.2, i64 0
  %add227.2785 = fadd contract float %resident.sroa.146.32.vec.extract2252, %117
  %resident.sroa.146.32.vec.insert2254 = insertelement <4 x float> poison, float %add227.2785, i64 0
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %117)
  %probs.sroa.0.0.vec.insert1600 = insertelement <4 x i16> poison, i16 %124, i64 0
  %resident.sroa.146.36.vec.extract2309 = extractelement <4 x float> %resident.sroa.146.2, i64 1
  %add227.1.2 = fadd contract float %resident.sroa.146.36.vec.extract2309, %119
  %resident.sroa.146.36.vec.insert2311 = insertelement <4 x float> %resident.sroa.146.32.vec.insert2254, float %add227.1.2, i64 1
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %119)
  %probs.sroa.0.2.vec.insert1646 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1600, i16 %125, i64 1
  %resident.sroa.146.40.vec.extract2368 = extractelement <4 x float> %resident.sroa.146.2, i64 2
  %add227.2.2 = fadd contract float %resident.sroa.146.40.vec.extract2368, %121
  %resident.sroa.146.40.vec.insert2370 = insertelement <4 x float> %resident.sroa.146.36.vec.insert2311, float %add227.2.2, i64 2
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %121)
  %probs.sroa.0.4.vec.insert1691 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1646, i16 %126, i64 2
  %resident.sroa.146.44.vec.extract2427 = extractelement <4 x float> %resident.sroa.146.2, i64 3
  %add227.3.2 = fadd contract float %resident.sroa.146.44.vec.extract2427, %123
  %resident.sroa.146.44.vec.insert2429 = insertelement <4 x float> %resident.sroa.146.40.vec.insert2370, float %add227.3.2, i64 3
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %123)
  %probs.sroa.0.6.vec.insert1713 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1691, i16 %127, i64 3
  br label %if.end252.2

if.end252.2:                                      ; preds = %if.end252.1, %if.end184.2
  %resident.sroa.146.3 = phi <4 x float> [ %resident.sroa.146.44.vec.insert2429, %if.end184.2 ], [ %resident.sroa.146.2, %if.end252.1 ]
  %probs.sroa.0.2 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1713, %if.end184.2 ], [ zeroinitializer, %if.end252.1 ]
  %add261.2 = or disjoint i32 %and259, 512
  %add.ptr263.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add261.2
  store <4 x i16> %probs.sroa.0.2, ptr addrspace(3) %add.ptr263.2, align 8
  br i1 %or.cond748.3, label %if.end252.3, label %if.then153.3

if.then153.3:                                     ; preds = %if.end252.2
  %cmp156.3 = icmp sgt i32 %mul11.3, %invariant.op
  br i1 %cmp156.3, label %for.cond158.preheader.3, label %if.end184.3

for.cond158.preheader.3:                          ; preds = %if.then153.3
  %add166.3 = or disjoint i32 %mul11.3, %mul165
  %cmp169.not.3786 = icmp sgt i32 %add166.3, %1
  %spec.select.3787 = select i1 %cmp169.not.3786, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1088 = insertelement <4 x float> poison, float %spec.select.3787, i64 0
  %cmp169.not.1.3.not = icmp slt i32 %add166.3, %1
  %spec.select.1.3 = select i1 %cmp169.not.1.3.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1221 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1088, float %spec.select.1.3, i64 1
  %add167.2.3 = or disjoint i32 %add166.3, 2
  %cmp169.not.2.3 = icmp sgt i32 %add167.2.3, %1
  %spec.select.2.3 = select i1 %cmp169.not.2.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1338 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1221, float %spec.select.2.3, i64 2
  %add167.3.3 = or disjoint i32 %add166.3, 3
  %cmp169.not.3.3 = icmp sgt i32 %add167.3.3, %1
  %spec.select.3.3 = select i1 %cmp169.not.3.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1455 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1338, float %spec.select.3.3, i64 3
  br label %if.end184.3

if.end184.3:                                      ; preds = %if.then153.3, %for.cond158.preheader.3
  %scores.sroa.0.6 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1455, %for.cond158.preheader.3 ], [ zeroinitializer, %if.then153.3 ]
  %resident.sroa.0.0.vec.extract2053 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>
  %128 = bitcast <2 x float> %resident.sroa.0.0.vec.extract2053 to <4 x half>
  %129 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.272.0, <4 x half> %128, <4 x float> %scores.sroa.0.6)
  %resident.sroa.0.8.vec.extract2095 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>
  %130 = bitcast <2 x float> %resident.sroa.0.8.vec.extract2095 to <4 x half>
  %131 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.278.0, <4 x half> %130, <4 x float> %129)
  %resident.sroa.74.16.vec.extract2149 = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>
  %132 = bitcast <2 x float> %resident.sroa.74.16.vec.extract2149 to <4 x half>
  %133 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.281.0, <4 x half> %132, <4 x float> %131)
  %resident.sroa.74.24.vec.extract2191 = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>
  %134 = bitcast <2 x float> %resident.sroa.74.24.vec.extract2191 to <4 x half>
  %135 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.287.0, <4 x half> %134, <4 x float> %133)
  %scores.sroa.0.0.vec.extract1090 = extractelement <4 x float> %135, i64 0
  %mul210.3790 = fmul contract float %scores.sroa.0.0.vec.extract1090, 0x3FB99999A0000000
  %136 = tail call contract noundef float @llvm.minnum.f32(float %mul210.3790, float 0x4024CB5EC0000000)
  %137 = tail call contract noundef float @llvm.exp.f32(float %136)
  %scores.sroa.0.4.vec.extract1223 = extractelement <4 x float> %135, i64 1
  %mul210.1.3 = fmul contract float %scores.sroa.0.4.vec.extract1223, 0x3FB99999A0000000
  %138 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1.3, float 0x4024CB5EC0000000)
  %139 = tail call contract noundef float @llvm.exp.f32(float %138)
  %scores.sroa.0.8.vec.extract1340 = extractelement <4 x float> %135, i64 2
  %mul210.2.3 = fmul contract float %scores.sroa.0.8.vec.extract1340, 0x3FB99999A0000000
  %140 = tail call contract noundef float @llvm.minnum.f32(float %mul210.2.3, float 0x4024CB5EC0000000)
  %141 = tail call contract noundef float @llvm.exp.f32(float %140)
  %scores.sroa.0.12.vec.extract1457 = extractelement <4 x float> %135, i64 3
  %mul210.3.3 = fmul contract float %scores.sroa.0.12.vec.extract1457, 0x3FB99999A0000000
  %142 = tail call contract noundef float @llvm.minnum.f32(float %mul210.3.3, float 0x4024CB5EC0000000)
  %143 = tail call contract noundef float @llvm.exp.f32(float %142)
  %resident.sroa.146.32.vec.extract2256 = extractelement <4 x float> %resident.sroa.146.3, i64 0
  %add227.3792 = fadd contract float %resident.sroa.146.32.vec.extract2256, %137
  %resident.sroa.146.32.vec.insert2258 = insertelement <4 x float> poison, float %add227.3792, i64 0
  %144 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %137)
  %probs.sroa.0.0.vec.insert1602 = insertelement <4 x i16> poison, i16 %144, i64 0
  %resident.sroa.146.36.vec.extract2313 = extractelement <4 x float> %resident.sroa.146.3, i64 1
  %add227.1.3 = fadd contract float %resident.sroa.146.36.vec.extract2313, %139
  %resident.sroa.146.36.vec.insert2315 = insertelement <4 x float> %resident.sroa.146.32.vec.insert2258, float %add227.1.3, i64 1
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %139)
  %probs.sroa.0.2.vec.insert1648 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1602, i16 %145, i64 1
  %resident.sroa.146.40.vec.extract2372 = extractelement <4 x float> %resident.sroa.146.3, i64 2
  %add227.2.3 = fadd contract float %resident.sroa.146.40.vec.extract2372, %141
  %resident.sroa.146.40.vec.insert2374 = insertelement <4 x float> %resident.sroa.146.36.vec.insert2315, float %add227.2.3, i64 2
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %141)
  %probs.sroa.0.4.vec.insert1693 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1648, i16 %146, i64 2
  %resident.sroa.146.44.vec.extract2431 = extractelement <4 x float> %resident.sroa.146.3, i64 3
  %add227.3.3 = fadd contract float %resident.sroa.146.44.vec.extract2431, %143
  %resident.sroa.146.44.vec.insert2433 = insertelement <4 x float> %resident.sroa.146.40.vec.insert2374, float %add227.3.3, i64 3
  %147 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %143)
  %probs.sroa.0.6.vec.insert1715 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1693, i16 %147, i64 3
  br label %if.end252.3

if.end252.3:                                      ; preds = %if.end252.2, %if.end184.3
  %resident.sroa.146.4 = phi <4 x float> [ %resident.sroa.146.44.vec.insert2433, %if.end184.3 ], [ %resident.sroa.146.3, %if.end252.2 ]
  %probs.sroa.0.3 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1715, %if.end184.3 ], [ zeroinitializer, %if.end252.2 ]
  %add261.3 = or disjoint i32 %and259, 768
  %add.ptr263.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add261.3
  store <4 x i16> %probs.sroa.0.3, ptr addrspace(3) %add.ptr263.3, align 8
  br label %if.end419

if.end419:                                        ; preds = %if.end, %if.end252.3
  %resident.sroa.146.5 = phi <4 x float> [ zeroinitializer, %if.end ], [ %resident.sroa.146.4, %if.end252.3 ]
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
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %cmp91, label %if.end267.1, label %for.cond94.preheader.1

for.cond94.preheader.1:                           ; preds = %if.end419
  %or.cond747.1809 = icmp ugt i32 %mul11.4, 1023
  %cmp107.not.1810 = icmp sgt i32 %mul11.4, %1
  %or.cond748.1811 = or i1 %or.cond747.1809, %cmp107.not.1810
  br i1 %or.cond748.1811, label %if.end135.1818, label %for.cond109.preheader.1814

for.cond109.preheader.1814:                       ; preds = %for.cond94.preheader.1
  %148 = shl nsw i32 %cond.i.i710.4, 10
  %mul116.1812 = and i32 %148, 64512
  %add117.1813 = or disjoint i32 %mul116.1812, %mul114
  %149 = zext nneg i32 %add117.1813 to i64
  %150 = or disjoint i64 %149, %34
  %add.ptr125.1815 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %150
  %kr.sroa.0.0.copyload1786 = load <4 x half>, ptr addrspace(4) %add.ptr125.1815, align 16
  %kr.sroa.68.0.add.ptr125.1815.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1815, i64 8
  %kr.sroa.68.0.copyload1800 = load <4 x half>, ptr addrspace(4) %kr.sroa.68.0.add.ptr125.1815.sroa_idx, align 8
  %151 = or disjoint i64 %149, %34
  %152 = or disjoint i64 %151, 512
  %add.ptr125.1.1816 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %152
  %kr.sroa.119.16.copyload1914 = load <4 x half>, ptr addrspace(4) %add.ptr125.1.1816, align 16
  %kr.sroa.185.16.add.ptr125.1.1816.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1.1816, i64 8
  %kr.sroa.185.16.copyload1928 = load <4 x half>, ptr addrspace(4) %kr.sroa.185.16.add.ptr125.1.1816.sroa_idx, align 8
  br label %if.end135.1818

if.end135.1818:                                   ; preds = %for.cond109.preheader.1814, %for.cond94.preheader.1
  %kr.sroa.185.7 = phi <4 x half> [ %kr.sroa.185.1, %for.cond94.preheader.1 ], [ %kr.sroa.185.16.copyload1928, %for.cond109.preheader.1814 ]
  %kr.sroa.119.7 = phi <4 x half> [ %kr.sroa.119.1, %for.cond94.preheader.1 ], [ %kr.sroa.119.16.copyload1914, %for.cond109.preheader.1814 ]
  %kr.sroa.68.7 = phi <4 x half> [ %kr.sroa.68.1, %for.cond94.preheader.1 ], [ %kr.sroa.68.0.copyload1800, %for.cond109.preheader.1814 ]
  %kr.sroa.0.7 = phi <4 x half> [ %kr.sroa.0.1, %for.cond94.preheader.1 ], [ %kr.sroa.0.0.copyload1786, %for.cond109.preheader.1814 ]
  %or.cond747.1.1 = icmp ugt i32 %mul11.5, 1023
  %cmp107.not.1.1 = icmp sgt i32 %mul11.5, %1
  %or.cond748.1.1 = or i1 %or.cond747.1.1, %cmp107.not.1.1
  br i1 %or.cond748.1.1, label %if.end135.1.1, label %for.cond109.preheader.1.1

for.cond109.preheader.1.1:                        ; preds = %if.end135.1818
  %153 = shl nsw i32 %cond.i.i710.5, 10
  %mul116.1.1 = and i32 %153, 64512
  %add117.1.1 = or disjoint i32 %mul116.1.1, %mul114
  %154 = zext nneg i32 %add117.1.1 to i64
  %155 = or disjoint i64 %154, %34
  %add.ptr125.1769.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %155
  %kr.sroa.236.32.copyload1990 = load <4 x half>, ptr addrspace(4) %add.ptr125.1769.1, align 16
  %kr.sroa.242.32.add.ptr125.1769.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1769.1, i64 8
  %kr.sroa.242.32.copyload1992 = load <4 x half>, ptr addrspace(4) %kr.sroa.242.32.add.ptr125.1769.1.sroa_idx, align 8
  %156 = or disjoint i64 %154, %34
  %157 = or disjoint i64 %156, 512
  %add.ptr125.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %157
  %kr.sroa.245.48.copyload1998 = load <4 x half>, ptr addrspace(4) %add.ptr125.1.1.1, align 16
  %kr.sroa.251.48.add.ptr125.1.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1.1.1, i64 8
  %kr.sroa.251.48.copyload2000 = load <4 x half>, ptr addrspace(4) %kr.sroa.251.48.add.ptr125.1.1.1.sroa_idx, align 8
  br label %if.end135.1.1

if.end135.1.1:                                    ; preds = %for.cond109.preheader.1.1, %if.end135.1818
  %kr.sroa.251.2 = phi <4 x half> [ %kr.sroa.251.1, %if.end135.1818 ], [ %kr.sroa.251.48.copyload2000, %for.cond109.preheader.1.1 ]
  %kr.sroa.245.2 = phi <4 x half> [ %kr.sroa.245.1, %if.end135.1818 ], [ %kr.sroa.245.48.copyload1998, %for.cond109.preheader.1.1 ]
  %kr.sroa.242.2 = phi <4 x half> [ %kr.sroa.242.1, %if.end135.1818 ], [ %kr.sroa.242.32.copyload1992, %for.cond109.preheader.1.1 ]
  %kr.sroa.236.2 = phi <4 x half> [ %kr.sroa.236.1, %if.end135.1818 ], [ %kr.sroa.236.32.copyload1990, %for.cond109.preheader.1.1 ]
  %or.cond747.2.1 = icmp ugt i32 %mul11.6, 1023
  %cmp107.not.2.1 = icmp sgt i32 %mul11.6, %1
  %or.cond748.2.1 = or i1 %or.cond747.2.1, %cmp107.not.2.1
  br i1 %or.cond748.2.1, label %if.end135.2.1, label %for.cond109.preheader.2.1

for.cond109.preheader.2.1:                        ; preds = %if.end135.1.1
  %158 = shl nsw i32 %cond.i.i710.6, 10
  %mul116.2.1 = and i32 %158, 64512
  %add117.2.1 = or disjoint i32 %mul116.2.1, %mul114
  %159 = zext nneg i32 %add117.2.1 to i64
  %160 = or disjoint i64 %159, %34
  %add.ptr125.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %160
  %kr.sroa.254.64.copyload2006 = load <4 x half>, ptr addrspace(4) %add.ptr125.2.1, align 16
  %kr.sroa.260.64.add.ptr125.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.2.1, i64 8
  %kr.sroa.260.64.copyload2008 = load <4 x half>, ptr addrspace(4) %kr.sroa.260.64.add.ptr125.2.1.sroa_idx, align 8
  %161 = or disjoint i64 %159, %34
  %162 = or disjoint i64 %161, 512
  %add.ptr125.1.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %162
  %kr.sroa.263.80.copyload2014 = load <4 x half>, ptr addrspace(4) %add.ptr125.1.2.1, align 16
  %kr.sroa.269.80.add.ptr125.1.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1.2.1, i64 8
  %kr.sroa.269.80.copyload2016 = load <4 x half>, ptr addrspace(4) %kr.sroa.269.80.add.ptr125.1.2.1.sroa_idx, align 8
  br label %if.end135.2.1

if.end135.2.1:                                    ; preds = %for.cond109.preheader.2.1, %if.end135.1.1
  %kr.sroa.269.2 = phi <4 x half> [ %kr.sroa.269.1, %if.end135.1.1 ], [ %kr.sroa.269.80.copyload2016, %for.cond109.preheader.2.1 ]
  %kr.sroa.263.2 = phi <4 x half> [ %kr.sroa.263.1, %if.end135.1.1 ], [ %kr.sroa.263.80.copyload2014, %for.cond109.preheader.2.1 ]
  %kr.sroa.260.2 = phi <4 x half> [ %kr.sroa.260.1, %if.end135.1.1 ], [ %kr.sroa.260.64.copyload2008, %for.cond109.preheader.2.1 ]
  %kr.sroa.254.2 = phi <4 x half> [ %kr.sroa.254.1, %if.end135.1.1 ], [ %kr.sroa.254.64.copyload2006, %for.cond109.preheader.2.1 ]
  %or.cond747.3.1 = icmp ugt i32 %mul11.7, 1023
  %cmp107.not.3.1 = icmp sgt i32 %mul11.7, %1
  %or.cond748.3.1 = or i1 %or.cond747.3.1, %cmp107.not.3.1
  br i1 %or.cond748.3.1, label %if.end135.3.1, label %for.cond109.preheader.3.1

for.cond109.preheader.3.1:                        ; preds = %if.end135.2.1
  %163 = shl nsw i32 %cond.i.i710.7, 10
  %mul116.3.1 = and i32 %163, 64512
  %add117.3.1 = or disjoint i32 %mul116.3.1, %mul114
  %164 = zext nneg i32 %add117.3.1 to i64
  %165 = or disjoint i64 %164, %34
  %add.ptr125.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %165
  %kr.sroa.272.96.copyload2022 = load <4 x half>, ptr addrspace(4) %add.ptr125.3.1, align 16
  %kr.sroa.278.96.add.ptr125.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.3.1, i64 8
  %kr.sroa.278.96.copyload2024 = load <4 x half>, ptr addrspace(4) %kr.sroa.278.96.add.ptr125.3.1.sroa_idx, align 8
  %166 = or disjoint i64 %164, %34
  %167 = or disjoint i64 %166, 512
  %add.ptr125.1.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %167
  %kr.sroa.281.112.copyload2030 = load <4 x half>, ptr addrspace(4) %add.ptr125.1.3.1, align 16
  %kr.sroa.287.112.add.ptr125.1.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr125.1.3.1, i64 8
  %kr.sroa.287.112.copyload2032 = load <4 x half>, ptr addrspace(4) %kr.sroa.287.112.add.ptr125.1.3.1.sroa_idx, align 8
  br label %if.end135.3.1

if.end135.3.1:                                    ; preds = %for.cond109.preheader.3.1, %if.end135.2.1
  %kr.sroa.287.2 = phi <4 x half> [ %kr.sroa.287.1, %if.end135.2.1 ], [ %kr.sroa.287.112.copyload2032, %for.cond109.preheader.3.1 ]
  %kr.sroa.281.2 = phi <4 x half> [ %kr.sroa.281.1, %if.end135.2.1 ], [ %kr.sroa.281.112.copyload2030, %for.cond109.preheader.3.1 ]
  %kr.sroa.278.2 = phi <4 x half> [ %kr.sroa.278.1, %if.end135.2.1 ], [ %kr.sroa.278.96.copyload2024, %for.cond109.preheader.3.1 ]
  %kr.sroa.272.2 = phi <4 x half> [ %kr.sroa.272.1, %if.end135.2.1 ], [ %kr.sroa.272.96.copyload2022, %for.cond109.preheader.3.1 ]
  br i1 %or.cond748.1811, label %if.end252.1875, label %if.then153.1824

if.then153.1824:                                  ; preds = %if.end135.3.1
  %cmp156.1823 = icmp sgt i32 %mul11.4, %invariant.op
  br i1 %cmp156.1823, label %for.cond158.preheader.1827, label %if.end184.1844

for.cond158.preheader.1827:                       ; preds = %if.then153.1824
  %add166.1826 = or disjoint i32 %mul11.4, %mul165
  %cmp169.not.1828 = icmp sgt i32 %add166.1826, %1
  %spec.select.1829 = select i1 %cmp169.not.1828, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1098 = insertelement <4 x float> poison, float %spec.select.1829, i64 0
  %cmp169.not.1.1831.not = icmp slt i32 %add166.1826, %1
  %spec.select.1.1832 = select i1 %cmp169.not.1.1831.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1229 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1098, float %spec.select.1.1832, i64 1
  %add167.2.1834 = or disjoint i32 %add166.1826, 2
  %cmp169.not.2.1835 = icmp sgt i32 %add167.2.1834, %1
  %spec.select.2.1836 = select i1 %cmp169.not.2.1835, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1346 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1229, float %spec.select.2.1836, i64 2
  %add167.3.1838 = or disjoint i32 %add166.1826, 3
  %cmp169.not.3.1839 = icmp sgt i32 %add167.3.1838, %1
  %spec.select.3.1840 = select i1 %cmp169.not.3.1839, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1463 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1346, float %spec.select.3.1840, i64 3
  br label %if.end184.1844

if.end184.1844:                                   ; preds = %if.then153.1824, %for.cond158.preheader.1827
  %scores.sroa.0.9 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1463, %for.cond158.preheader.1827 ], [ zeroinitializer, %if.then153.1824 ]
  %resident.sroa.0.0.vec.extract2055 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>
  %168 = bitcast <2 x float> %resident.sroa.0.0.vec.extract2055 to <4 x half>
  %169 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.7, <4 x half> %168, <4 x float> %scores.sroa.0.9)
  %resident.sroa.0.8.vec.extract2097 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>
  %170 = bitcast <2 x float> %resident.sroa.0.8.vec.extract2097 to <4 x half>
  %171 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.68.7, <4 x half> %170, <4 x float> %169)
  %resident.sroa.74.16.vec.extract2151 = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>
  %172 = bitcast <2 x float> %resident.sroa.74.16.vec.extract2151 to <4 x half>
  %173 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.119.7, <4 x half> %172, <4 x float> %171)
  %resident.sroa.74.24.vec.extract2193 = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>
  %174 = bitcast <2 x float> %resident.sroa.74.24.vec.extract2193 to <4 x half>
  %175 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.185.7, <4 x half> %174, <4 x float> %173)
  %scores.sroa.0.0.vec.extract1100 = extractelement <4 x float> %175, i64 0
  %mul210.1849 = fmul contract float %scores.sroa.0.0.vec.extract1100, 0x3FB99999A0000000
  %176 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1849, float 0x4024CB5EC0000000)
  %177 = tail call contract noundef float @llvm.exp.f32(float %176)
  %scores.sroa.0.4.vec.extract1231 = extractelement <4 x float> %175, i64 1
  %mul210.1.1851 = fmul contract float %scores.sroa.0.4.vec.extract1231, 0x3FB99999A0000000
  %178 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1.1851, float 0x4024CB5EC0000000)
  %179 = tail call contract noundef float @llvm.exp.f32(float %178)
  %scores.sroa.0.8.vec.extract1348 = extractelement <4 x float> %175, i64 2
  %mul210.2.1853 = fmul contract float %scores.sroa.0.8.vec.extract1348, 0x3FB99999A0000000
  %180 = tail call contract noundef float @llvm.minnum.f32(float %mul210.2.1853, float 0x4024CB5EC0000000)
  %181 = tail call contract noundef float @llvm.exp.f32(float %180)
  %scores.sroa.0.12.vec.extract1465 = extractelement <4 x float> %175, i64 3
  %mul210.3.1855 = fmul contract float %scores.sroa.0.12.vec.extract1465, 0x3FB99999A0000000
  %182 = tail call contract noundef float @llvm.minnum.f32(float %mul210.3.1855, float 0x4024CB5EC0000000)
  %183 = tail call contract noundef float @llvm.exp.f32(float %182)
  %resident.sroa.146.32.vec.extract2260 = extractelement <4 x float> %resident.sroa.146.5, i64 0
  %add227.1858 = fadd contract float %resident.sroa.146.32.vec.extract2260, %177
  %resident.sroa.146.32.vec.insert2262 = insertelement <4 x float> poison, float %add227.1858, i64 0
  %184 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %177)
  %probs.sroa.0.0.vec.insert1604 = insertelement <4 x i16> poison, i16 %184, i64 0
  %resident.sroa.146.36.vec.extract2317 = extractelement <4 x float> %resident.sroa.146.5, i64 1
  %add227.1.1861 = fadd contract float %resident.sroa.146.36.vec.extract2317, %179
  %resident.sroa.146.36.vec.insert2319 = insertelement <4 x float> %resident.sroa.146.32.vec.insert2262, float %add227.1.1861, i64 1
  %185 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %179)
  %probs.sroa.0.2.vec.insert1650 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1604, i16 %185, i64 1
  %resident.sroa.146.40.vec.extract2376 = extractelement <4 x float> %resident.sroa.146.5, i64 2
  %add227.2.1865 = fadd contract float %resident.sroa.146.40.vec.extract2376, %181
  %resident.sroa.146.40.vec.insert2378 = insertelement <4 x float> %resident.sroa.146.36.vec.insert2319, float %add227.2.1865, i64 2
  %186 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %181)
  %probs.sroa.0.4.vec.insert1695 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1650, i16 %186, i64 2
  %resident.sroa.146.44.vec.extract2435 = extractelement <4 x float> %resident.sroa.146.5, i64 3
  %add227.3.1869 = fadd contract float %resident.sroa.146.44.vec.extract2435, %183
  %resident.sroa.146.44.vec.insert2437 = insertelement <4 x float> %resident.sroa.146.40.vec.insert2378, float %add227.3.1869, i64 3
  %187 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %183)
  %probs.sroa.0.6.vec.insert1717 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1695, i16 %187, i64 3
  br label %if.end252.1875

if.end252.1875:                                   ; preds = %if.end135.3.1, %if.end184.1844
  %resident.sroa.146.11 = phi <4 x float> [ %resident.sroa.146.44.vec.insert2437, %if.end184.1844 ], [ %resident.sroa.146.5, %if.end135.3.1 ]
  %probs.sroa.0.10 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1717, %if.end184.1844 ], [ zeroinitializer, %if.end135.3.1 ]
  %add261.1873 = or disjoint i32 %and259, 1024
  %add.ptr263.1874 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add261.1873
  store <4 x i16> %probs.sroa.0.10, ptr addrspace(3) %add.ptr263.1874, align 8
  br i1 %or.cond748.1.1, label %if.end252.1.1, label %if.then153.1.1

if.then153.1.1:                                   ; preds = %if.end252.1875
  %cmp156.1.1 = icmp sgt i32 %mul11.5, %invariant.op
  br i1 %cmp156.1.1, label %for.cond158.preheader.1.1, label %if.end184.1.1

for.cond158.preheader.1.1:                        ; preds = %if.then153.1.1
  %add166.1.1 = or disjoint i32 %mul11.5, %mul165
  %cmp169.not.1772.1 = icmp sgt i32 %add166.1.1, %1
  %spec.select.1773.1 = select i1 %cmp169.not.1772.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1108 = insertelement <4 x float> poison, float %spec.select.1773.1, i64 0
  %cmp169.not.1.1.1.not = icmp slt i32 %add166.1.1, %1
  %spec.select.1.1.1 = select i1 %cmp169.not.1.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1237 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1108, float %spec.select.1.1.1, i64 1
  %add167.2.1.1 = or disjoint i32 %add166.1.1, 2
  %cmp169.not.2.1.1 = icmp sgt i32 %add167.2.1.1, %1
  %spec.select.2.1.1 = select i1 %cmp169.not.2.1.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1354 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1237, float %spec.select.2.1.1, i64 2
  %add167.3.1.1 = or disjoint i32 %add166.1.1, 3
  %cmp169.not.3.1.1 = icmp sgt i32 %add167.3.1.1, %1
  %spec.select.3.1.1 = select i1 %cmp169.not.3.1.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1471 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1354, float %spec.select.3.1.1, i64 3
  br label %if.end184.1.1

if.end184.1.1:                                    ; preds = %if.then153.1.1, %for.cond158.preheader.1.1
  %scores.sroa.0.11 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1471, %for.cond158.preheader.1.1 ], [ zeroinitializer, %if.then153.1.1 ]
  %resident.sroa.0.0.vec.extract2057 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>
  %188 = bitcast <2 x float> %resident.sroa.0.0.vec.extract2057 to <4 x half>
  %189 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.236.2, <4 x half> %188, <4 x float> %scores.sroa.0.11)
  %resident.sroa.0.8.vec.extract2099 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>
  %190 = bitcast <2 x float> %resident.sroa.0.8.vec.extract2099 to <4 x half>
  %191 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.242.2, <4 x half> %190, <4 x float> %189)
  %resident.sroa.74.16.vec.extract2153 = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>
  %192 = bitcast <2 x float> %resident.sroa.74.16.vec.extract2153 to <4 x half>
  %193 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.245.2, <4 x half> %192, <4 x float> %191)
  %resident.sroa.74.24.vec.extract2195 = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>
  %194 = bitcast <2 x float> %resident.sroa.74.24.vec.extract2195 to <4 x half>
  %195 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.251.2, <4 x half> %194, <4 x float> %193)
  %scores.sroa.0.0.vec.extract1110 = extractelement <4 x float> %195, i64 0
  %mul210.1776.1 = fmul contract float %scores.sroa.0.0.vec.extract1110, 0x3FB99999A0000000
  %196 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1776.1, float 0x4024CB5EC0000000)
  %197 = tail call contract noundef float @llvm.exp.f32(float %196)
  %scores.sroa.0.4.vec.extract1239 = extractelement <4 x float> %195, i64 1
  %mul210.1.1.1 = fmul contract float %scores.sroa.0.4.vec.extract1239, 0x3FB99999A0000000
  %198 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1.1.1, float 0x4024CB5EC0000000)
  %199 = tail call contract noundef float @llvm.exp.f32(float %198)
  %scores.sroa.0.8.vec.extract1356 = extractelement <4 x float> %195, i64 2
  %mul210.2.1.1 = fmul contract float %scores.sroa.0.8.vec.extract1356, 0x3FB99999A0000000
  %200 = tail call contract noundef float @llvm.minnum.f32(float %mul210.2.1.1, float 0x4024CB5EC0000000)
  %201 = tail call contract noundef float @llvm.exp.f32(float %200)
  %scores.sroa.0.12.vec.extract1473 = extractelement <4 x float> %195, i64 3
  %mul210.3.1.1 = fmul contract float %scores.sroa.0.12.vec.extract1473, 0x3FB99999A0000000
  %202 = tail call contract noundef float @llvm.minnum.f32(float %mul210.3.1.1, float 0x4024CB5EC0000000)
  %203 = tail call contract noundef float @llvm.exp.f32(float %202)
  %resident.sroa.146.32.vec.extract2264 = extractelement <4 x float> %resident.sroa.146.11, i64 0
  %add227.1778.1 = fadd contract float %resident.sroa.146.32.vec.extract2264, %197
  %resident.sroa.146.32.vec.insert2266 = insertelement <4 x float> poison, float %add227.1778.1, i64 0
  %204 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %197)
  %probs.sroa.0.0.vec.insert1606 = insertelement <4 x i16> poison, i16 %204, i64 0
  %resident.sroa.146.36.vec.extract2321 = extractelement <4 x float> %resident.sroa.146.11, i64 1
  %add227.1.1.1 = fadd contract float %resident.sroa.146.36.vec.extract2321, %199
  %resident.sroa.146.36.vec.insert2323 = insertelement <4 x float> %resident.sroa.146.32.vec.insert2266, float %add227.1.1.1, i64 1
  %205 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %199)
  %probs.sroa.0.2.vec.insert1652 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1606, i16 %205, i64 1
  %resident.sroa.146.40.vec.extract2380 = extractelement <4 x float> %resident.sroa.146.11, i64 2
  %add227.2.1.1 = fadd contract float %resident.sroa.146.40.vec.extract2380, %201
  %resident.sroa.146.40.vec.insert2382 = insertelement <4 x float> %resident.sroa.146.36.vec.insert2323, float %add227.2.1.1, i64 2
  %206 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %201)
  %probs.sroa.0.4.vec.insert1697 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1652, i16 %206, i64 2
  %resident.sroa.146.44.vec.extract2439 = extractelement <4 x float> %resident.sroa.146.11, i64 3
  %add227.3.1.1 = fadd contract float %resident.sroa.146.44.vec.extract2439, %203
  %resident.sroa.146.44.vec.insert2441 = insertelement <4 x float> %resident.sroa.146.40.vec.insert2382, float %add227.3.1.1, i64 3
  %207 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %203)
  %probs.sroa.0.6.vec.insert1719 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1697, i16 %207, i64 3
  br label %if.end252.1.1

if.end252.1.1:                                    ; preds = %if.end252.1875, %if.end184.1.1
  %resident.sroa.146.12 = phi <4 x float> [ %resident.sroa.146.44.vec.insert2441, %if.end184.1.1 ], [ %resident.sroa.146.11, %if.end252.1875 ]
  %probs.sroa.0.11 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1719, %if.end184.1.1 ], [ zeroinitializer, %if.end252.1875 ]
  %add261.1.1 = or disjoint i32 %and259, 1280
  %add.ptr263.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add261.1.1
  store <4 x i16> %probs.sroa.0.11, ptr addrspace(3) %add.ptr263.1.1, align 8
  br i1 %or.cond748.2.1, label %if.end252.2.1, label %if.then153.2.1

if.then153.2.1:                                   ; preds = %if.end252.1.1
  %cmp156.2.1 = icmp sgt i32 %mul11.6, %invariant.op
  br i1 %cmp156.2.1, label %for.cond158.preheader.2.1, label %if.end184.2.1

for.cond158.preheader.2.1:                        ; preds = %if.then153.2.1
  %add166.2.1 = or disjoint i32 %mul11.6, %mul165
  %cmp169.not.2779.1 = icmp sgt i32 %add166.2.1, %1
  %spec.select.2780.1 = select i1 %cmp169.not.2779.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1118 = insertelement <4 x float> poison, float %spec.select.2780.1, i64 0
  %cmp169.not.1.2.1.not = icmp slt i32 %add166.2.1, %1
  %spec.select.1.2.1 = select i1 %cmp169.not.1.2.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1245 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1118, float %spec.select.1.2.1, i64 1
  %add167.2.2.1 = or disjoint i32 %add166.2.1, 2
  %cmp169.not.2.2.1 = icmp sgt i32 %add167.2.2.1, %1
  %spec.select.2.2.1 = select i1 %cmp169.not.2.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1362 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1245, float %spec.select.2.2.1, i64 2
  %add167.3.2.1 = or disjoint i32 %add166.2.1, 3
  %cmp169.not.3.2.1 = icmp sgt i32 %add167.3.2.1, %1
  %spec.select.3.2.1 = select i1 %cmp169.not.3.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1479 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1362, float %spec.select.3.2.1, i64 3
  br label %if.end184.2.1

if.end184.2.1:                                    ; preds = %if.then153.2.1, %for.cond158.preheader.2.1
  %scores.sroa.0.13 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1479, %for.cond158.preheader.2.1 ], [ zeroinitializer, %if.then153.2.1 ]
  %resident.sroa.0.0.vec.extract2059 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>
  %208 = bitcast <2 x float> %resident.sroa.0.0.vec.extract2059 to <4 x half>
  %209 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.254.2, <4 x half> %208, <4 x float> %scores.sroa.0.13)
  %resident.sroa.0.8.vec.extract2101 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>
  %210 = bitcast <2 x float> %resident.sroa.0.8.vec.extract2101 to <4 x half>
  %211 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.260.2, <4 x half> %210, <4 x float> %209)
  %resident.sroa.74.16.vec.extract2155 = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>
  %212 = bitcast <2 x float> %resident.sroa.74.16.vec.extract2155 to <4 x half>
  %213 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.263.2, <4 x half> %212, <4 x float> %211)
  %resident.sroa.74.24.vec.extract2197 = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>
  %214 = bitcast <2 x float> %resident.sroa.74.24.vec.extract2197 to <4 x half>
  %215 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.269.2, <4 x half> %214, <4 x float> %213)
  %scores.sroa.0.0.vec.extract1120 = extractelement <4 x float> %215, i64 0
  %mul210.2783.1 = fmul contract float %scores.sroa.0.0.vec.extract1120, 0x3FB99999A0000000
  %216 = tail call contract noundef float @llvm.minnum.f32(float %mul210.2783.1, float 0x4024CB5EC0000000)
  %217 = tail call contract noundef float @llvm.exp.f32(float %216)
  %scores.sroa.0.4.vec.extract1247 = extractelement <4 x float> %215, i64 1
  %mul210.1.2.1 = fmul contract float %scores.sroa.0.4.vec.extract1247, 0x3FB99999A0000000
  %218 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1.2.1, float 0x4024CB5EC0000000)
  %219 = tail call contract noundef float @llvm.exp.f32(float %218)
  %scores.sroa.0.8.vec.extract1364 = extractelement <4 x float> %215, i64 2
  %mul210.2.2.1 = fmul contract float %scores.sroa.0.8.vec.extract1364, 0x3FB99999A0000000
  %220 = tail call contract noundef float @llvm.minnum.f32(float %mul210.2.2.1, float 0x4024CB5EC0000000)
  %221 = tail call contract noundef float @llvm.exp.f32(float %220)
  %scores.sroa.0.12.vec.extract1481 = extractelement <4 x float> %215, i64 3
  %mul210.3.2.1 = fmul contract float %scores.sroa.0.12.vec.extract1481, 0x3FB99999A0000000
  %222 = tail call contract noundef float @llvm.minnum.f32(float %mul210.3.2.1, float 0x4024CB5EC0000000)
  %223 = tail call contract noundef float @llvm.exp.f32(float %222)
  %resident.sroa.146.32.vec.extract2268 = extractelement <4 x float> %resident.sroa.146.12, i64 0
  %add227.2785.1 = fadd contract float %resident.sroa.146.32.vec.extract2268, %217
  %resident.sroa.146.32.vec.insert2270 = insertelement <4 x float> poison, float %add227.2785.1, i64 0
  %224 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %217)
  %probs.sroa.0.0.vec.insert1608 = insertelement <4 x i16> poison, i16 %224, i64 0
  %resident.sroa.146.36.vec.extract2325 = extractelement <4 x float> %resident.sroa.146.12, i64 1
  %add227.1.2.1 = fadd contract float %resident.sroa.146.36.vec.extract2325, %219
  %resident.sroa.146.36.vec.insert2327 = insertelement <4 x float> %resident.sroa.146.32.vec.insert2270, float %add227.1.2.1, i64 1
  %225 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %219)
  %probs.sroa.0.2.vec.insert1654 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1608, i16 %225, i64 1
  %resident.sroa.146.40.vec.extract2384 = extractelement <4 x float> %resident.sroa.146.12, i64 2
  %add227.2.2.1 = fadd contract float %resident.sroa.146.40.vec.extract2384, %221
  %resident.sroa.146.40.vec.insert2386 = insertelement <4 x float> %resident.sroa.146.36.vec.insert2327, float %add227.2.2.1, i64 2
  %226 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %221)
  %probs.sroa.0.4.vec.insert1699 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1654, i16 %226, i64 2
  %resident.sroa.146.44.vec.extract2443 = extractelement <4 x float> %resident.sroa.146.12, i64 3
  %add227.3.2.1 = fadd contract float %resident.sroa.146.44.vec.extract2443, %223
  %resident.sroa.146.44.vec.insert2445 = insertelement <4 x float> %resident.sroa.146.40.vec.insert2386, float %add227.3.2.1, i64 3
  %227 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %223)
  %probs.sroa.0.6.vec.insert1721 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1699, i16 %227, i64 3
  br label %if.end252.2.1

if.end252.2.1:                                    ; preds = %if.end252.1.1, %if.end184.2.1
  %resident.sroa.146.13 = phi <4 x float> [ %resident.sroa.146.44.vec.insert2445, %if.end184.2.1 ], [ %resident.sroa.146.12, %if.end252.1.1 ]
  %probs.sroa.0.12 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1721, %if.end184.2.1 ], [ zeroinitializer, %if.end252.1.1 ]
  %add261.2.1 = or disjoint i32 %and259, 1536
  %add.ptr263.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add261.2.1
  store <4 x i16> %probs.sroa.0.12, ptr addrspace(3) %add.ptr263.2.1, align 8
  br i1 %or.cond748.3.1, label %if.end252.3.1, label %if.then153.3.1

if.then153.3.1:                                   ; preds = %if.end252.2.1
  %cmp156.3.1 = icmp sgt i32 %mul11.7, %invariant.op
  br i1 %cmp156.3.1, label %for.cond158.preheader.3.1, label %if.end184.3.1

for.cond158.preheader.3.1:                        ; preds = %if.then153.3.1
  %add166.3.1 = or disjoint i32 %mul11.7, %mul165
  %cmp169.not.3786.1 = icmp sgt i32 %add166.3.1, %1
  %spec.select.3787.1 = select i1 %cmp169.not.3786.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1128 = insertelement <4 x float> poison, float %spec.select.3787.1, i64 0
  %cmp169.not.1.3.1.not = icmp slt i32 %add166.3.1, %1
  %spec.select.1.3.1 = select i1 %cmp169.not.1.3.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1253 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1128, float %spec.select.1.3.1, i64 1
  %add167.2.3.1 = or disjoint i32 %add166.3.1, 2
  %cmp169.not.2.3.1 = icmp sgt i32 %add167.2.3.1, %1
  %spec.select.2.3.1 = select i1 %cmp169.not.2.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1370 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1253, float %spec.select.2.3.1, i64 2
  %add167.3.3.1 = or disjoint i32 %add166.3.1, 3
  %cmp169.not.3.3.1 = icmp sgt i32 %add167.3.3.1, %1
  %spec.select.3.3.1 = select i1 %cmp169.not.3.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1487 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1370, float %spec.select.3.3.1, i64 3
  br label %if.end184.3.1

if.end184.3.1:                                    ; preds = %if.then153.3.1, %for.cond158.preheader.3.1
  %scores.sroa.0.15 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1487, %for.cond158.preheader.3.1 ], [ zeroinitializer, %if.then153.3.1 ]
  %resident.sroa.0.0.vec.extract2061 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>
  %228 = bitcast <2 x float> %resident.sroa.0.0.vec.extract2061 to <4 x half>
  %229 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.272.2, <4 x half> %228, <4 x float> %scores.sroa.0.15)
  %resident.sroa.0.8.vec.extract2103 = shufflevector <4 x float> %resident.sroa.0.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>
  %230 = bitcast <2 x float> %resident.sroa.0.8.vec.extract2103 to <4 x half>
  %231 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.278.2, <4 x half> %230, <4 x float> %229)
  %resident.sroa.74.16.vec.extract2157 = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 0, i32 1>
  %232 = bitcast <2 x float> %resident.sroa.74.16.vec.extract2157 to <4 x half>
  %233 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.281.2, <4 x half> %232, <4 x float> %231)
  %resident.sroa.74.24.vec.extract2199 = shufflevector <4 x float> %resident.sroa.74.0, <4 x float> poison, <2 x i32> <i32 2, i32 3>
  %234 = bitcast <2 x float> %resident.sroa.74.24.vec.extract2199 to <4 x half>
  %235 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.287.2, <4 x half> %234, <4 x float> %233)
  %scores.sroa.0.0.vec.extract1130 = extractelement <4 x float> %235, i64 0
  %mul210.3790.1 = fmul contract float %scores.sroa.0.0.vec.extract1130, 0x3FB99999A0000000
  %236 = tail call contract noundef float @llvm.minnum.f32(float %mul210.3790.1, float 0x4024CB5EC0000000)
  %237 = tail call contract noundef float @llvm.exp.f32(float %236)
  %scores.sroa.0.4.vec.extract1255 = extractelement <4 x float> %235, i64 1
  %mul210.1.3.1 = fmul contract float %scores.sroa.0.4.vec.extract1255, 0x3FB99999A0000000
  %238 = tail call contract noundef float @llvm.minnum.f32(float %mul210.1.3.1, float 0x4024CB5EC0000000)
  %239 = tail call contract noundef float @llvm.exp.f32(float %238)
  %scores.sroa.0.8.vec.extract1372 = extractelement <4 x float> %235, i64 2
  %mul210.2.3.1 = fmul contract float %scores.sroa.0.8.vec.extract1372, 0x3FB99999A0000000
  %240 = tail call contract noundef float @llvm.minnum.f32(float %mul210.2.3.1, float 0x4024CB5EC0000000)
  %241 = tail call contract noundef float @llvm.exp.f32(float %240)
  %scores.sroa.0.12.vec.extract1489 = extractelement <4 x float> %235, i64 3
  %mul210.3.3.1 = fmul contract float %scores.sroa.0.12.vec.extract1489, 0x3FB99999A0000000
  %242 = tail call contract noundef float @llvm.minnum.f32(float %mul210.3.3.1, float 0x4024CB5EC0000000)
  %243 = tail call contract noundef float @llvm.exp.f32(float %242)
  %resident.sroa.146.32.vec.extract2272 = extractelement <4 x float> %resident.sroa.146.13, i64 0
  %add227.3792.1 = fadd contract float %resident.sroa.146.32.vec.extract2272, %237
  %resident.sroa.146.32.vec.insert2274 = insertelement <4 x float> poison, float %add227.3792.1, i64 0
  %244 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %237)
  %probs.sroa.0.0.vec.insert1610 = insertelement <4 x i16> poison, i16 %244, i64 0
  %resident.sroa.146.36.vec.extract2329 = extractelement <4 x float> %resident.sroa.146.13, i64 1
  %add227.1.3.1 = fadd contract float %resident.sroa.146.36.vec.extract2329, %239
  %resident.sroa.146.36.vec.insert2331 = insertelement <4 x float> %resident.sroa.146.32.vec.insert2274, float %add227.1.3.1, i64 1
  %245 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %239)
  %probs.sroa.0.2.vec.insert1656 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1610, i16 %245, i64 1
  %resident.sroa.146.40.vec.extract2388 = extractelement <4 x float> %resident.sroa.146.13, i64 2
  %add227.2.3.1 = fadd contract float %resident.sroa.146.40.vec.extract2388, %241
  %resident.sroa.146.40.vec.insert2390 = insertelement <4 x float> %resident.sroa.146.36.vec.insert2331, float %add227.2.3.1, i64 2
  %246 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %241)
  %probs.sroa.0.4.vec.insert1701 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1656, i16 %246, i64 2
  %resident.sroa.146.44.vec.extract2447 = extractelement <4 x float> %resident.sroa.146.13, i64 3
  %add227.3.3.1 = fadd contract float %resident.sroa.146.44.vec.extract2447, %243
  %resident.sroa.146.44.vec.insert2449 = insertelement <4 x float> %resident.sroa.146.40.vec.insert2390, float %add227.3.3.1, i64 3
  %247 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %243)
  %probs.sroa.0.6.vec.insert1723 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1701, i16 %247, i64 3
  br label %if.end252.3.1

if.end252.3.1:                                    ; preds = %if.end252.2.1, %if.end184.3.1
  %resident.sroa.146.14 = phi <4 x float> [ %resident.sroa.146.44.vec.insert2449, %if.end184.3.1 ], [ %resident.sroa.146.13, %if.end252.2.1 ]
  %probs.sroa.0.13 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1723, %if.end184.3.1 ], [ zeroinitializer, %if.end252.2.1 ]
  %add261.3.1 = or disjoint i32 %and259, 1792
  %add.ptr263.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add261.3.1
  store <4 x i16> %probs.sroa.0.13, ptr addrspace(3) %add.ptr263.3.1, align 8
  br label %if.end267.1

if.end267.1:                                      ; preds = %if.end252.3.1, %if.end419
  %resident.sroa.146.15 = phi <4 x float> [ %resident.sroa.146.5, %if.end419 ], [ %resident.sroa.146.14, %if.end252.3.1 ]
  br i1 %cmp270.not, label %for.cond274.preheader.1, label %if.end419.1

for.cond274.preheader.1:                          ; preds = %if.end267.1
  %or.cond751.1877 = icmp ugt i32 %mul11, 1023
  %cmp287.not.1878 = icmp sgt i32 %mul11, %1
  %or.cond752.1879 = or i1 %or.cond751.1877, %cmp287.not.1878
  br i1 %or.cond752.1879, label %if.end415.1924, label %for.cond327.preheader.1907

for.cond327.preheader.1907:                       ; preds = %for.cond274.preheader.1
  %gep.1887 = getelementptr %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul318
  %248 = load <4 x half>, ptr addrspace(3) %gep.1887, align 8
  %249 = shl nsw i32 %cond.i.i710, 10
  %mul296.1880 = and i32 %249, 64512
  %add297.1881 = or disjoint i32 %mul296.1880, %mul114
  %250 = zext nneg i32 %add297.1881 to i64
  %251 = or disjoint i64 %250, %35
  %252 = or disjoint i64 %251, 512
  %add.ptr305.1.1884 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %252
  %kr.sroa.185.16.add.ptr305.1.1884.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1.1884, i64 8
  %kr.sroa.185.16.copyload1929 = load <4 x half>, ptr addrspace(4) %kr.sroa.185.16.add.ptr305.1.1884.sroa_idx, align 8
  %kr.sroa.119.16.copyload1915 = load <4 x half>, ptr addrspace(4) %add.ptr305.1.1884, align 16
  %253 = or disjoint i64 %250, %35
  %add.ptr305.1883 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %253
  %kr.sroa.68.0.add.ptr305.1883.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1883, i64 8
  %kr.sroa.68.0.copyload1801 = load <4 x half>, ptr addrspace(4) %kr.sroa.68.0.add.ptr305.1883.sroa_idx, align 8
  %kr.sroa.0.0.copyload1787 = load <4 x half>, ptr addrspace(4) %add.ptr305.1883, align 16
  %254 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0.copyload1787, <4 x half> %248, <4 x float> %resident.sroa.0.0), !call_argsrelate !171
  %255 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.68.0.copyload1801, <4 x half> %248, <4 x float> %resident.sroa.74.0), !call_argsrelate !171
  %256 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.119.16.copyload1915, <4 x half> %248, <4 x float> %resident.sroa.146.15), !call_argsrelate !171
  %257 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.185.16.copyload1929, <4 x half> %248, <4 x float> zeroinitializer), !call_argsrelate !171
  br label %if.end415.1924

if.end415.1924:                                   ; preds = %for.cond327.preheader.1907, %for.cond274.preheader.1
  %resident.sroa.294.6 = phi <4 x float> [ zeroinitializer, %for.cond274.preheader.1 ], [ %257, %for.cond327.preheader.1907 ]
  %resident.sroa.146.16 = phi <4 x float> [ %resident.sroa.146.15, %for.cond274.preheader.1 ], [ %256, %for.cond327.preheader.1907 ]
  %resident.sroa.74.6 = phi <4 x float> [ %resident.sroa.74.0, %for.cond274.preheader.1 ], [ %255, %for.cond327.preheader.1907 ]
  %resident.sroa.0.6 = phi <4 x float> [ %resident.sroa.0.0, %for.cond274.preheader.1 ], [ %254, %for.cond327.preheader.1907 ]
  %or.cond751.1.1 = icmp ugt i32 %mul11.1, 1023
  %cmp287.not.1.1 = icmp sgt i32 %mul11.1, %1
  %or.cond752.1.1 = or i1 %or.cond751.1.1, %cmp287.not.1.1
  br i1 %or.cond752.1.1, label %if.end415.1.1, label %for.cond348.preheader.1.1

for.cond348.preheader.1.1:                        ; preds = %if.end415.1924
  %add319.1.1 = or i32 %and259, 1280
  %gep.1.1 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add319.1.1
  %258 = load <4 x half>, ptr addrspace(3) %gep.1.1, align 8
  %259 = shl nsw i32 %cond.i.i710.1, 10
  %mul296.1.1 = and i32 %259, 64512
  %add297.1.1 = or disjoint i32 %mul296.1.1, %mul114
  %260 = zext nneg i32 %add297.1.1 to i64
  %261 = or disjoint i64 %260, %35
  %262 = or disjoint i64 %261, 512
  %add.ptr305.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %262
  %kr.sroa.185.16.add.ptr305.1.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1.1.1, i64 8
  %kr.sroa.185.16.copyload1930 = load <4 x half>, ptr addrspace(4) %kr.sroa.185.16.add.ptr305.1.1.1.sroa_idx, align 8
  %kr.sroa.119.16.copyload1916 = load <4 x half>, ptr addrspace(4) %add.ptr305.1.1.1, align 16
  %263 = or disjoint i64 %260, %35
  %add.ptr305.1798.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %263
  %kr.sroa.68.0.add.ptr305.1798.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1798.1, i64 8
  %kr.sroa.68.0.copyload1802 = load <4 x half>, ptr addrspace(4) %kr.sroa.68.0.add.ptr305.1798.1.sroa_idx, align 8
  %kr.sroa.0.0.copyload1788 = load <4 x half>, ptr addrspace(4) %add.ptr305.1798.1, align 16
  %264 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0.copyload1788, <4 x half> %258, <4 x float> zeroinitializer), !call_argsrelate !171
  %265 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.68.0.copyload1802, <4 x half> %258, <4 x float> zeroinitializer), !call_argsrelate !171
  %266 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.119.16.copyload1916, <4 x half> %258, <4 x float> zeroinitializer), !call_argsrelate !171
  %267 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.185.16.copyload1930, <4 x half> %258, <4 x float> zeroinitializer), !call_argsrelate !171
  br label %if.end415.1.1

if.end415.1.1:                                    ; preds = %for.cond348.preheader.1.1, %if.end415.1924
  %resident.sroa.434.7 = phi <4 x float> [ zeroinitializer, %if.end415.1924 ], [ %267, %for.cond348.preheader.1.1 ]
  %resident.sroa.402.7 = phi <4 x float> [ zeroinitializer, %if.end415.1924 ], [ %266, %for.cond348.preheader.1.1 ]
  %resident.sroa.370.7 = phi <4 x float> [ zeroinitializer, %if.end415.1924 ], [ %265, %for.cond348.preheader.1.1 ]
  %resident.sroa.338.7 = phi <4 x float> [ zeroinitializer, %if.end415.1924 ], [ %264, %for.cond348.preheader.1.1 ]
  %or.cond751.2.1 = icmp ugt i32 %mul11.2, 1023
  %cmp287.not.2.1 = icmp sgt i32 %mul11.2, %1
  %or.cond752.2.1 = or i1 %or.cond751.2.1, %cmp287.not.2.1
  br i1 %or.cond752.2.1, label %if.end415.2.1, label %for.cond371.preheader.2.1

for.cond371.preheader.2.1:                        ; preds = %if.end415.1.1
  %add319.2.1 = or disjoint i32 %mul318, 1536
  %gep.2.1 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add319.2.1
  %268 = load <4 x half>, ptr addrspace(3) %gep.2.1, align 8
  %269 = shl nsw i32 %cond.i.i710.2, 10
  %mul296.2.1 = and i32 %269, 64512
  %add297.2.1 = or disjoint i32 %mul296.2.1, %mul114
  %270 = zext nneg i32 %add297.2.1 to i64
  %271 = or disjoint i64 %270, %35
  %272 = or disjoint i64 %271, 512
  %add.ptr305.1.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %272
  %kr.sroa.185.16.add.ptr305.1.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1.2.1, i64 8
  %kr.sroa.185.16.copyload1931 = load <4 x half>, ptr addrspace(4) %kr.sroa.185.16.add.ptr305.1.2.1.sroa_idx, align 8
  %kr.sroa.119.16.copyload1917 = load <4 x half>, ptr addrspace(4) %add.ptr305.1.2.1, align 16
  %273 = or disjoint i64 %270, %35
  %add.ptr305.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %273
  %kr.sroa.68.0.add.ptr305.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.2.1, i64 8
  %kr.sroa.68.0.copyload1803 = load <4 x half>, ptr addrspace(4) %kr.sroa.68.0.add.ptr305.2.1.sroa_idx, align 8
  %kr.sroa.0.0.copyload1789 = load <4 x half>, ptr addrspace(4) %add.ptr305.2.1, align 16
  %274 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0.copyload1789, <4 x half> %268, <4 x float> zeroinitializer), !call_argsrelate !171
  %275 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.68.0.copyload1803, <4 x half> %268, <4 x float> zeroinitializer), !call_argsrelate !171
  %276 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.119.16.copyload1917, <4 x half> %268, <4 x float> zeroinitializer), !call_argsrelate !171
  %277 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.185.16.copyload1931, <4 x half> %268, <4 x float> zeroinitializer), !call_argsrelate !171
  br label %if.end415.2.1

if.end415.2.1:                                    ; preds = %for.cond371.preheader.2.1, %if.end415.1.1
  %resident.sroa.562.8 = phi <4 x float> [ zeroinitializer, %if.end415.1.1 ], [ %277, %for.cond371.preheader.2.1 ]
  %resident.sroa.530.8 = phi <4 x float> [ zeroinitializer, %if.end415.1.1 ], [ %276, %for.cond371.preheader.2.1 ]
  %resident.sroa.498.8 = phi <4 x float> [ zeroinitializer, %if.end415.1.1 ], [ %275, %for.cond371.preheader.2.1 ]
  %resident.sroa.466.8 = phi <4 x float> [ zeroinitializer, %if.end415.1.1 ], [ %274, %for.cond371.preheader.2.1 ]
  %or.cond751.3.1 = icmp ugt i32 %mul11.3, 1023
  %cmp287.not.3.1 = icmp sgt i32 %mul11.3, %1
  %or.cond752.3.1 = or i1 %or.cond751.3.1, %cmp287.not.3.1
  br i1 %or.cond752.3.1, label %if.end419.1, label %for.cond392.preheader.3.1

for.cond392.preheader.3.1:                        ; preds = %if.end415.2.1
  %add319.3.1 = or i32 %and259, 1792
  %gep.3.1 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add319.3.1
  %278 = load <4 x half>, ptr addrspace(3) %gep.3.1, align 8
  %279 = shl nsw i32 %cond.i.i710.3, 10
  %mul296.3.1 = and i32 %279, 64512
  %add297.3.1 = or disjoint i32 %mul296.3.1, %mul114
  %280 = zext nneg i32 %add297.3.1 to i64
  %281 = or disjoint i64 %280, %35
  %282 = or disjoint i64 %281, 512
  %add.ptr305.1.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %282
  %kr.sroa.185.16.add.ptr305.1.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1.3.1, i64 8
  %kr.sroa.185.16.copyload1932 = load <4 x half>, ptr addrspace(4) %kr.sroa.185.16.add.ptr305.1.3.1.sroa_idx, align 8
  %kr.sroa.119.16.copyload1918 = load <4 x half>, ptr addrspace(4) %add.ptr305.1.3.1, align 16
  %283 = or disjoint i64 %280, %35
  %add.ptr305.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %283
  %kr.sroa.68.0.add.ptr305.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.3.1, i64 8
  %kr.sroa.68.0.copyload1804 = load <4 x half>, ptr addrspace(4) %kr.sroa.68.0.add.ptr305.3.1.sroa_idx, align 8
  %kr.sroa.0.0.copyload1790 = load <4 x half>, ptr addrspace(4) %add.ptr305.3.1, align 16
  %284 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0.copyload1790, <4 x half> %278, <4 x float> zeroinitializer), !call_argsrelate !171
  %285 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.68.0.copyload1804, <4 x half> %278, <4 x float> zeroinitializer), !call_argsrelate !171
  %286 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.119.16.copyload1918, <4 x half> %278, <4 x float> zeroinitializer), !call_argsrelate !171
  %287 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.185.16.copyload1932, <4 x half> %278, <4 x float> zeroinitializer), !call_argsrelate !171
  br label %if.end419.1

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
  %resident.sroa.146.20 = phi <4 x float> [ %resident.sroa.146.15, %if.end267.1 ], [ %resident.sroa.146.16, %if.end415.2.1 ], [ %resident.sroa.146.16, %for.cond392.preheader.3.1 ]
  %resident.sroa.74.10 = phi <4 x float> [ %resident.sroa.74.0, %if.end267.1 ], [ %resident.sroa.74.6, %if.end415.2.1 ], [ %resident.sroa.74.6, %for.cond392.preheader.3.1 ]
  %resident.sroa.0.10 = phi <4 x float> [ %resident.sroa.0.0, %if.end267.1 ], [ %resident.sroa.0.6, %if.end415.2.1 ], [ %resident.sroa.0.6, %for.cond392.preheader.3.1 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br label %if.end267.2

if.end267.2:                                      ; preds = %if.end419.1
  br i1 %cmp270.not, label %for.cond274.preheader.2, label %if.end419.2

for.cond274.preheader.2:                          ; preds = %if.end267.2
  %or.cond751.2994 = icmp ugt i32 %mul11.4, 1023
  %cmp287.not.2995 = icmp sgt i32 %mul11.4, %1
  %or.cond752.2996 = or i1 %or.cond751.2994, %cmp287.not.2995
  br i1 %or.cond752.2996, label %if.end415.21041, label %for.cond327.preheader.21024

for.cond327.preheader.21024:                      ; preds = %for.cond274.preheader.2
  %add319.21003 = or disjoint i32 %mul318, 2048
  %gep.21004 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add319.21003
  %288 = load <4 x half>, ptr addrspace(3) %gep.21004, align 8
  %289 = shl nsw i32 %cond.i.i710.4, 10
  %mul296.2997 = and i32 %289, 64512
  %add297.2998 = or disjoint i32 %mul296.2997, %mul114
  %290 = zext nneg i32 %add297.2998 to i64
  %291 = or disjoint i64 %290, %35
  %292 = or disjoint i64 %291, 512
  %add.ptr305.1.21001 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %292
  %kr.sroa.185.16.add.ptr305.1.21001.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1.21001, i64 8
  %kr.sroa.185.16.copyload1934 = load <4 x half>, ptr addrspace(4) %kr.sroa.185.16.add.ptr305.1.21001.sroa_idx, align 8
  %kr.sroa.119.16.copyload1920 = load <4 x half>, ptr addrspace(4) %add.ptr305.1.21001, align 16
  %293 = or disjoint i64 %290, %35
  %add.ptr305.21000 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %293
  %kr.sroa.68.0.add.ptr305.21000.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.21000, i64 8
  %kr.sroa.68.0.copyload1806 = load <4 x half>, ptr addrspace(4) %kr.sroa.68.0.add.ptr305.21000.sroa_idx, align 8
  %kr.sroa.0.0.copyload1792 = load <4 x half>, ptr addrspace(4) %add.ptr305.21000, align 16
  %294 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0.copyload1792, <4 x half> %288, <4 x float> %resident.sroa.0.10), !call_argsrelate !171
  %295 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.68.0.copyload1806, <4 x half> %288, <4 x float> %resident.sroa.74.10), !call_argsrelate !171
  %296 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.119.16.copyload1920, <4 x half> %288, <4 x float> %resident.sroa.146.20), !call_argsrelate !171
  %297 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.185.16.copyload1934, <4 x half> %288, <4 x float> %resident.sroa.294.10), !call_argsrelate !171
  br label %if.end415.21041

if.end415.21041:                                  ; preds = %for.cond327.preheader.21024, %for.cond274.preheader.2
  %resident.sroa.294.11 = phi <4 x float> [ %resident.sroa.294.10, %for.cond274.preheader.2 ], [ %297, %for.cond327.preheader.21024 ]
  %resident.sroa.146.26 = phi <4 x float> [ %resident.sroa.146.20, %for.cond274.preheader.2 ], [ %296, %for.cond327.preheader.21024 ]
  %resident.sroa.74.11 = phi <4 x float> [ %resident.sroa.74.10, %for.cond274.preheader.2 ], [ %295, %for.cond327.preheader.21024 ]
  %resident.sroa.0.11 = phi <4 x float> [ %resident.sroa.0.10, %for.cond274.preheader.2 ], [ %294, %for.cond327.preheader.21024 ]
  %or.cond751.1.2 = icmp ugt i32 %mul11.5, 1023
  %cmp287.not.1.2 = icmp sgt i32 %mul11.5, %1
  %or.cond752.1.2 = or i1 %or.cond751.1.2, %cmp287.not.1.2
  br i1 %or.cond752.1.2, label %if.end415.1.2, label %for.cond348.preheader.1.2

for.cond348.preheader.1.2:                        ; preds = %if.end415.21041
  %add319.1.2 = or i32 %and259, 2304
  %gep.1.2 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add319.1.2
  %298 = load <4 x half>, ptr addrspace(3) %gep.1.2, align 8
  %299 = shl nsw i32 %cond.i.i710.5, 10
  %mul296.1.2 = and i32 %299, 64512
  %add297.1.2 = or disjoint i32 %mul296.1.2, %mul114
  %300 = zext nneg i32 %add297.1.2 to i64
  %301 = or disjoint i64 %300, %35
  %302 = or disjoint i64 %301, 512
  %add.ptr305.1.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %302
  %kr.sroa.185.16.add.ptr305.1.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1.1.2, i64 8
  %kr.sroa.185.16.copyload1935 = load <4 x half>, ptr addrspace(4) %kr.sroa.185.16.add.ptr305.1.1.2.sroa_idx, align 8
  %kr.sroa.119.16.copyload1921 = load <4 x half>, ptr addrspace(4) %add.ptr305.1.1.2, align 16
  %303 = or disjoint i64 %300, %35
  %add.ptr305.1798.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %303
  %kr.sroa.68.0.add.ptr305.1798.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1798.2, i64 8
  %kr.sroa.68.0.copyload1807 = load <4 x half>, ptr addrspace(4) %kr.sroa.68.0.add.ptr305.1798.2.sroa_idx, align 8
  %kr.sroa.0.0.copyload1793 = load <4 x half>, ptr addrspace(4) %add.ptr305.1798.2, align 16
  %304 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0.copyload1793, <4 x half> %298, <4 x float> %resident.sroa.338.10), !call_argsrelate !171
  %305 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.68.0.copyload1807, <4 x half> %298, <4 x float> %resident.sroa.370.10), !call_argsrelate !171
  %306 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.119.16.copyload1921, <4 x half> %298, <4 x float> %resident.sroa.402.10), !call_argsrelate !171
  %307 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.185.16.copyload1935, <4 x half> %298, <4 x float> %resident.sroa.434.10), !call_argsrelate !171
  br label %if.end415.1.2

if.end415.1.2:                                    ; preds = %for.cond348.preheader.1.2, %if.end415.21041
  %resident.sroa.434.12 = phi <4 x float> [ %resident.sroa.434.10, %if.end415.21041 ], [ %307, %for.cond348.preheader.1.2 ]
  %resident.sroa.402.12 = phi <4 x float> [ %resident.sroa.402.10, %if.end415.21041 ], [ %306, %for.cond348.preheader.1.2 ]
  %resident.sroa.370.12 = phi <4 x float> [ %resident.sroa.370.10, %if.end415.21041 ], [ %305, %for.cond348.preheader.1.2 ]
  %resident.sroa.338.12 = phi <4 x float> [ %resident.sroa.338.10, %if.end415.21041 ], [ %304, %for.cond348.preheader.1.2 ]
  %or.cond751.2.2 = icmp ugt i32 %mul11.6, 1023
  %cmp287.not.2.2 = icmp sgt i32 %mul11.6, %1
  %or.cond752.2.2 = or i1 %or.cond751.2.2, %cmp287.not.2.2
  br i1 %or.cond752.2.2, label %if.end415.2.2, label %for.cond371.preheader.2.2

for.cond371.preheader.2.2:                        ; preds = %if.end415.1.2
  %add319.2.2 = or disjoint i32 %mul318, 2560
  %gep.2.2 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add319.2.2
  %308 = load <4 x half>, ptr addrspace(3) %gep.2.2, align 8
  %309 = shl nsw i32 %cond.i.i710.6, 10
  %mul296.2.2 = and i32 %309, 64512
  %add297.2.2 = or disjoint i32 %mul296.2.2, %mul114
  %310 = zext nneg i32 %add297.2.2 to i64
  %311 = or disjoint i64 %310, %35
  %312 = or disjoint i64 %311, 512
  %add.ptr305.1.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %312
  %kr.sroa.185.16.add.ptr305.1.2.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1.2.2, i64 8
  %kr.sroa.185.16.copyload1936 = load <4 x half>, ptr addrspace(4) %kr.sroa.185.16.add.ptr305.1.2.2.sroa_idx, align 8
  %kr.sroa.119.16.copyload1922 = load <4 x half>, ptr addrspace(4) %add.ptr305.1.2.2, align 16
  %313 = or disjoint i64 %310, %35
  %add.ptr305.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %313
  %kr.sroa.68.0.add.ptr305.2.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.2.2, i64 8
  %kr.sroa.68.0.copyload1808 = load <4 x half>, ptr addrspace(4) %kr.sroa.68.0.add.ptr305.2.2.sroa_idx, align 8
  %kr.sroa.0.0.copyload1794 = load <4 x half>, ptr addrspace(4) %add.ptr305.2.2, align 16
  %314 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0.copyload1794, <4 x half> %308, <4 x float> %resident.sroa.466.10), !call_argsrelate !171
  %315 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.68.0.copyload1808, <4 x half> %308, <4 x float> %resident.sroa.498.10), !call_argsrelate !171
  %316 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.119.16.copyload1922, <4 x half> %308, <4 x float> %resident.sroa.530.10), !call_argsrelate !171
  %317 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.185.16.copyload1936, <4 x half> %308, <4 x float> %resident.sroa.562.10), !call_argsrelate !171
  br label %if.end415.2.2

if.end415.2.2:                                    ; preds = %for.cond371.preheader.2.2, %if.end415.1.2
  %resident.sroa.562.13 = phi <4 x float> [ %resident.sroa.562.10, %if.end415.1.2 ], [ %317, %for.cond371.preheader.2.2 ]
  %resident.sroa.530.13 = phi <4 x float> [ %resident.sroa.530.10, %if.end415.1.2 ], [ %316, %for.cond371.preheader.2.2 ]
  %resident.sroa.498.13 = phi <4 x float> [ %resident.sroa.498.10, %if.end415.1.2 ], [ %315, %for.cond371.preheader.2.2 ]
  %resident.sroa.466.13 = phi <4 x float> [ %resident.sroa.466.10, %if.end415.1.2 ], [ %314, %for.cond371.preheader.2.2 ]
  %or.cond751.3.2 = icmp ugt i32 %mul11.7, 1023
  %cmp287.not.3.2 = icmp sgt i32 %mul11.7, %1
  %or.cond752.3.2 = or i1 %or.cond751.3.2, %cmp287.not.3.2
  br i1 %or.cond752.3.2, label %if.end419.2, label %for.cond392.preheader.3.2

for.cond392.preheader.3.2:                        ; preds = %if.end415.2.2
  %add319.3.2 = or i32 %and259, 2816
  %gep.3.2 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add319.3.2
  %318 = load <4 x half>, ptr addrspace(3) %gep.3.2, align 8
  %319 = shl nsw i32 %cond.i.i710.7, 10
  %mul296.3.2 = and i32 %319, 64512
  %add297.3.2 = or disjoint i32 %mul296.3.2, %mul114
  %320 = zext nneg i32 %add297.3.2 to i64
  %321 = or disjoint i64 %320, %35
  %322 = or disjoint i64 %321, 512
  %add.ptr305.1.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %322
  %kr.sroa.185.16.add.ptr305.1.3.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.1.3.2, i64 8
  %kr.sroa.185.16.copyload1937 = load <4 x half>, ptr addrspace(4) %kr.sroa.185.16.add.ptr305.1.3.2.sroa_idx, align 8
  %kr.sroa.119.16.copyload1923 = load <4 x half>, ptr addrspace(4) %add.ptr305.1.3.2, align 16
  %323 = or disjoint i64 %320, %35
  %add.ptr305.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %323
  %kr.sroa.68.0.add.ptr305.3.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr305.3.2, i64 8
  %kr.sroa.68.0.copyload1809 = load <4 x half>, ptr addrspace(4) %kr.sroa.68.0.add.ptr305.3.2.sroa_idx, align 8
  %kr.sroa.0.0.copyload1795 = load <4 x half>, ptr addrspace(4) %add.ptr305.3.2, align 16
  %324 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0.copyload1795, <4 x half> %318, <4 x float> %resident.sroa.594.10), !call_argsrelate !171
  %325 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.68.0.copyload1809, <4 x half> %318, <4 x float> %resident.sroa.626.10), !call_argsrelate !171
  %326 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.119.16.copyload1923, <4 x half> %318, <4 x float> %resident.sroa.658.10), !call_argsrelate !171
  %327 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.185.16.copyload1937, <4 x half> %318, <4 x float> %resident.sroa.690.10), !call_argsrelate !171
  br label %if.end419.2

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
  %resident.sroa.146.30 = phi <4 x float> [ %resident.sroa.146.20, %if.end267.2 ], [ %resident.sroa.146.26, %if.end415.2.2 ], [ %resident.sroa.146.26, %for.cond392.preheader.3.2 ]
  %resident.sroa.74.15 = phi <4 x float> [ %resident.sroa.74.10, %if.end267.2 ], [ %resident.sroa.74.11, %if.end415.2.2 ], [ %resident.sroa.74.11, %for.cond392.preheader.3.2 ]
  %resident.sroa.0.15 = phi <4 x float> [ %resident.sroa.0.10, %if.end267.2 ], [ %resident.sroa.0.11, %if.end415.2.2 ], [ %resident.sroa.0.11, %for.cond392.preheader.3.2 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %cmp15, label %for.body431.preheader, label %if.end463

if.end463:                                        ; preds = %for.body431.preheader, %if.end419.2
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  %cmp466 = icmp eq i32 %shr269.mask, 64
  br i1 %cmp466, label %if.then467, label %if.end581

if.then467:                                       ; preds = %if.end463
  %and469 = and i32 %18, 63
  %arrayidx471 = getelementptr inbounds float, ptr addrspace(3) @buf_dyn_shmem, i32 %and469
  %328 = load float, ptr addrspace(3) %arrayidx471, align 4, !tbaa !111
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %resident.sroa.0.0.vec.extract2072 = extractelement <4 x float> %resident.sroa.0.15, i64 0
  %resident.sroa.338.64.vec.extract = extractelement <4 x float> %resident.sroa.338.15, i64 0
  %add482 = fadd contract float %resident.sroa.0.0.vec.extract2072, %resident.sroa.338.64.vec.extract
  %resident.sroa.466.128.vec.extract = extractelement <4 x float> %resident.sroa.466.15, i64 0
  %add490 = fadd contract float %add482, %resident.sroa.466.128.vec.extract
  %resident.sroa.594.192.vec.extract = extractelement <4 x float> %resident.sroa.594.15, i64 0
  %add498 = fadd contract float %add490, %resident.sroa.594.192.vec.extract
  %mul504 = fmul contract float %328, %add498
  %329 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504)
  %oreg.sroa.0.0.insert.ext = zext i16 %329 to i64
  %resident.sroa.0.4.vec.extract = extractelement <4 x float> %resident.sroa.0.15, i64 1
  %resident.sroa.338.68.vec.extract = extractelement <4 x float> %resident.sroa.338.15, i64 1
  %add482.1 = fadd contract float %resident.sroa.0.4.vec.extract, %resident.sroa.338.68.vec.extract
  %resident.sroa.466.132.vec.extract = extractelement <4 x float> %resident.sroa.466.15, i64 1
  %add490.1 = fadd contract float %add482.1, %resident.sroa.466.132.vec.extract
  %resident.sroa.594.196.vec.extract = extractelement <4 x float> %resident.sroa.594.15, i64 1
  %add498.1 = fadd contract float %add490.1, %resident.sroa.594.196.vec.extract
  %mul504.1 = fmul contract float %328, %add498.1
  %330 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504.1)
  %oreg.sroa.0.2.insert.ext = zext i16 %330 to i64
  %oreg.sroa.0.2.insert.shift = shl nuw nsw i64 %oreg.sroa.0.2.insert.ext, 16
  %oreg.sroa.0.2.insert.insert = or disjoint i64 %oreg.sroa.0.2.insert.shift, %oreg.sroa.0.0.insert.ext
  %resident.sroa.0.8.vec.extract2114 = extractelement <4 x float> %resident.sroa.0.15, i64 2
  %resident.sroa.338.72.vec.extract = extractelement <4 x float> %resident.sroa.338.15, i64 2
  %add482.2 = fadd contract float %resident.sroa.0.8.vec.extract2114, %resident.sroa.338.72.vec.extract
  %resident.sroa.466.136.vec.extract = extractelement <4 x float> %resident.sroa.466.15, i64 2
  %add490.2 = fadd contract float %add482.2, %resident.sroa.466.136.vec.extract
  %resident.sroa.594.200.vec.extract = extractelement <4 x float> %resident.sroa.594.15, i64 2
  %add498.2 = fadd contract float %add490.2, %resident.sroa.594.200.vec.extract
  %mul504.2 = fmul contract float %328, %add498.2
  %331 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504.2)
  %oreg.sroa.0.4.insert.ext = zext i16 %331 to i64
  %oreg.sroa.0.4.insert.shift = shl nuw nsw i64 %oreg.sroa.0.4.insert.ext, 32
  %oreg.sroa.0.4.insert.insert = or disjoint i64 %oreg.sroa.0.2.insert.insert, %oreg.sroa.0.4.insert.shift
  %resident.sroa.0.12.vec.extract = extractelement <4 x float> %resident.sroa.0.15, i64 3
  %resident.sroa.338.76.vec.extract = extractelement <4 x float> %resident.sroa.338.15, i64 3
  %add482.3 = fadd contract float %resident.sroa.0.12.vec.extract, %resident.sroa.338.76.vec.extract
  %resident.sroa.466.140.vec.extract = extractelement <4 x float> %resident.sroa.466.15, i64 3
  %add490.3 = fadd contract float %add482.3, %resident.sroa.466.140.vec.extract
  %resident.sroa.594.204.vec.extract = extractelement <4 x float> %resident.sroa.594.15, i64 3
  %add498.3 = fadd contract float %add490.3, %resident.sroa.594.204.vec.extract
  %mul504.3 = fmul contract float %328, %add498.3
  %332 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504.3)
  %oreg.sroa.0.6.insert.ext = zext i16 %332 to i64
  %oreg.sroa.0.6.insert.shift = shl nuw i64 %oreg.sroa.0.6.insert.ext, 48
  %oreg.sroa.0.6.insert.insert = or disjoint i64 %oreg.sroa.0.4.insert.insert, %oreg.sroa.0.6.insert.shift
  %resident.sroa.74.16.vec.extract2168 = extractelement <4 x float> %resident.sroa.74.15, i64 0
  %resident.sroa.370.80.vec.extract = extractelement <4 x float> %resident.sroa.370.15, i64 0
  %add482.4 = fadd contract float %resident.sroa.74.16.vec.extract2168, %resident.sroa.370.80.vec.extract
  %resident.sroa.498.144.vec.extract = extractelement <4 x float> %resident.sroa.498.15, i64 0
  %add490.4 = fadd contract float %add482.4, %resident.sroa.498.144.vec.extract
  %resident.sroa.626.208.vec.extract = extractelement <4 x float> %resident.sroa.626.15, i64 0
  %add498.4 = fadd contract float %add490.4, %resident.sroa.626.208.vec.extract
  %mul504.4 = fmul contract float %328, %add498.4
  %333 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504.4)
  %oreg.sroa.7.8.insert.ext = zext i16 %333 to i64
  %resident.sroa.74.20.vec.extract = extractelement <4 x float> %resident.sroa.74.15, i64 1
  %resident.sroa.370.84.vec.extract = extractelement <4 x float> %resident.sroa.370.15, i64 1
  %add482.5 = fadd contract float %resident.sroa.74.20.vec.extract, %resident.sroa.370.84.vec.extract
  %resident.sroa.498.148.vec.extract = extractelement <4 x float> %resident.sroa.498.15, i64 1
  %add490.5 = fadd contract float %add482.5, %resident.sroa.498.148.vec.extract
  %resident.sroa.626.212.vec.extract = extractelement <4 x float> %resident.sroa.626.15, i64 1
  %add498.5 = fadd contract float %add490.5, %resident.sroa.626.212.vec.extract
  %mul504.5 = fmul contract float %328, %add498.5
  %334 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504.5)
  %oreg.sroa.7.10.insert.ext = zext i16 %334 to i64
  %oreg.sroa.7.10.insert.shift = shl nuw nsw i64 %oreg.sroa.7.10.insert.ext, 16
  %oreg.sroa.7.10.insert.insert = or disjoint i64 %oreg.sroa.7.10.insert.shift, %oreg.sroa.7.8.insert.ext
  %resident.sroa.74.24.vec.extract2210 = extractelement <4 x float> %resident.sroa.74.15, i64 2
  %resident.sroa.370.88.vec.extract = extractelement <4 x float> %resident.sroa.370.15, i64 2
  %add482.6 = fadd contract float %resident.sroa.74.24.vec.extract2210, %resident.sroa.370.88.vec.extract
  %resident.sroa.498.152.vec.extract = extractelement <4 x float> %resident.sroa.498.15, i64 2
  %add490.6 = fadd contract float %add482.6, %resident.sroa.498.152.vec.extract
  %resident.sroa.626.216.vec.extract = extractelement <4 x float> %resident.sroa.626.15, i64 2
  %add498.6 = fadd contract float %add490.6, %resident.sroa.626.216.vec.extract
  %mul504.6 = fmul contract float %328, %add498.6
  %335 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504.6)
  %oreg.sroa.7.12.insert.ext = zext i16 %335 to i64
  %oreg.sroa.7.12.insert.shift = shl nuw nsw i64 %oreg.sroa.7.12.insert.ext, 32
  %oreg.sroa.7.12.insert.insert = or disjoint i64 %oreg.sroa.7.10.insert.insert, %oreg.sroa.7.12.insert.shift
  %resident.sroa.74.28.vec.extract = extractelement <4 x float> %resident.sroa.74.15, i64 3
  %resident.sroa.370.92.vec.extract = extractelement <4 x float> %resident.sroa.370.15, i64 3
  %add482.7 = fadd contract float %resident.sroa.74.28.vec.extract, %resident.sroa.370.92.vec.extract
  %resident.sroa.498.156.vec.extract = extractelement <4 x float> %resident.sroa.498.15, i64 3
  %add490.7 = fadd contract float %add482.7, %resident.sroa.498.156.vec.extract
  %resident.sroa.626.220.vec.extract = extractelement <4 x float> %resident.sroa.626.15, i64 3
  %add498.7 = fadd contract float %add490.7, %resident.sroa.626.220.vec.extract
  %mul504.7 = fmul contract float %328, %add498.7
  %336 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504.7)
  %oreg.sroa.7.14.insert.ext = zext i16 %336 to i64
  %oreg.sroa.7.14.insert.shift = shl nuw i64 %oreg.sroa.7.14.insert.ext, 48
  %oreg.sroa.7.14.insert.insert = or disjoint i64 %oreg.sroa.7.12.insert.insert, %oreg.sroa.7.14.insert.shift
  %resident.sroa.146.32.vec.extract2292 = extractelement <4 x float> %resident.sroa.146.30, i64 0
  %resident.sroa.402.96.vec.extract = extractelement <4 x float> %resident.sroa.402.15, i64 0
  %add482.8 = fadd contract float %resident.sroa.146.32.vec.extract2292, %resident.sroa.402.96.vec.extract
  %resident.sroa.530.160.vec.extract = extractelement <4 x float> %resident.sroa.530.15, i64 0
  %add490.8 = fadd contract float %add482.8, %resident.sroa.530.160.vec.extract
  %resident.sroa.658.224.vec.extract = extractelement <4 x float> %resident.sroa.658.15, i64 0
  %add498.8 = fadd contract float %add490.8, %resident.sroa.658.224.vec.extract
  %mul504.8 = fmul contract float %328, %add498.8
  %337 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504.8)
  %oreg.sroa.12.16.insert.ext = zext i16 %337 to i64
  %resident.sroa.146.36.vec.extract2351 = extractelement <4 x float> %resident.sroa.146.30, i64 1
  %resident.sroa.402.100.vec.extract = extractelement <4 x float> %resident.sroa.402.15, i64 1
  %add482.9 = fadd contract float %resident.sroa.146.36.vec.extract2351, %resident.sroa.402.100.vec.extract
  %resident.sroa.530.164.vec.extract = extractelement <4 x float> %resident.sroa.530.15, i64 1
  %add490.9 = fadd contract float %add482.9, %resident.sroa.530.164.vec.extract
  %resident.sroa.658.228.vec.extract = extractelement <4 x float> %resident.sroa.658.15, i64 1
  %add498.9 = fadd contract float %add490.9, %resident.sroa.658.228.vec.extract
  %mul504.9 = fmul contract float %328, %add498.9
  %338 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504.9)
  %oreg.sroa.12.18.insert.ext = zext i16 %338 to i64
  %oreg.sroa.12.18.insert.shift = shl nuw nsw i64 %oreg.sroa.12.18.insert.ext, 16
  %oreg.sroa.12.18.insert.insert = or disjoint i64 %oreg.sroa.12.18.insert.shift, %oreg.sroa.12.16.insert.ext
  %resident.sroa.146.40.vec.extract2410 = extractelement <4 x float> %resident.sroa.146.30, i64 2
  %resident.sroa.402.104.vec.extract = extractelement <4 x float> %resident.sroa.402.15, i64 2
  %add482.10 = fadd contract float %resident.sroa.146.40.vec.extract2410, %resident.sroa.402.104.vec.extract
  %resident.sroa.530.168.vec.extract = extractelement <4 x float> %resident.sroa.530.15, i64 2
  %add490.10 = fadd contract float %add482.10, %resident.sroa.530.168.vec.extract
  %resident.sroa.658.232.vec.extract = extractelement <4 x float> %resident.sroa.658.15, i64 2
  %add498.10 = fadd contract float %add490.10, %resident.sroa.658.232.vec.extract
  %mul504.10 = fmul contract float %328, %add498.10
  %339 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504.10)
  %oreg.sroa.12.20.insert.ext = zext i16 %339 to i64
  %oreg.sroa.12.20.insert.shift = shl nuw nsw i64 %oreg.sroa.12.20.insert.ext, 32
  %oreg.sroa.12.20.insert.insert = or disjoint i64 %oreg.sroa.12.18.insert.insert, %oreg.sroa.12.20.insert.shift
  %resident.sroa.146.44.vec.extract2469 = extractelement <4 x float> %resident.sroa.146.30, i64 3
  %resident.sroa.402.108.vec.extract = extractelement <4 x float> %resident.sroa.402.15, i64 3
  %add482.11 = fadd contract float %resident.sroa.146.44.vec.extract2469, %resident.sroa.402.108.vec.extract
  %resident.sroa.530.172.vec.extract = extractelement <4 x float> %resident.sroa.530.15, i64 3
  %add490.11 = fadd contract float %add482.11, %resident.sroa.530.172.vec.extract
  %resident.sroa.658.236.vec.extract = extractelement <4 x float> %resident.sroa.658.15, i64 3
  %add498.11 = fadd contract float %add490.11, %resident.sroa.658.236.vec.extract
  %mul504.11 = fmul contract float %328, %add498.11
  %340 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504.11)
  %oreg.sroa.12.22.insert.ext = zext i16 %340 to i64
  %oreg.sroa.12.22.insert.shift = shl nuw i64 %oreg.sroa.12.22.insert.ext, 48
  %oreg.sroa.12.22.insert.insert = or disjoint i64 %oreg.sroa.12.20.insert.insert, %oreg.sroa.12.22.insert.shift
  %resident.sroa.294.48.vec.extract = extractelement <4 x float> %resident.sroa.294.15, i64 0
  %resident.sroa.434.112.vec.extract = extractelement <4 x float> %resident.sroa.434.15, i64 0
  %add482.12 = fadd contract float %resident.sroa.294.48.vec.extract, %resident.sroa.434.112.vec.extract
  %resident.sroa.562.176.vec.extract = extractelement <4 x float> %resident.sroa.562.15, i64 0
  %add490.12 = fadd contract float %add482.12, %resident.sroa.562.176.vec.extract
  %resident.sroa.690.240.vec.extract = extractelement <4 x float> %resident.sroa.690.15, i64 0
  %add498.12 = fadd contract float %add490.12, %resident.sroa.690.240.vec.extract
  %mul504.12 = fmul contract float %328, %add498.12
  %341 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504.12)
  %oreg.sroa.17.24.insert.ext = zext i16 %341 to i64
  %resident.sroa.294.52.vec.extract = extractelement <4 x float> %resident.sroa.294.15, i64 1
  %resident.sroa.434.116.vec.extract = extractelement <4 x float> %resident.sroa.434.15, i64 1
  %add482.13 = fadd contract float %resident.sroa.294.52.vec.extract, %resident.sroa.434.116.vec.extract
  %resident.sroa.562.180.vec.extract = extractelement <4 x float> %resident.sroa.562.15, i64 1
  %add490.13 = fadd contract float %add482.13, %resident.sroa.562.180.vec.extract
  %resident.sroa.690.244.vec.extract = extractelement <4 x float> %resident.sroa.690.15, i64 1
  %add498.13 = fadd contract float %add490.13, %resident.sroa.690.244.vec.extract
  %mul504.13 = fmul contract float %328, %add498.13
  %342 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504.13)
  %oreg.sroa.17.26.insert.ext = zext i16 %342 to i64
  %oreg.sroa.17.26.insert.shift = shl nuw nsw i64 %oreg.sroa.17.26.insert.ext, 16
  %oreg.sroa.17.26.insert.insert = or disjoint i64 %oreg.sroa.17.26.insert.shift, %oreg.sroa.17.24.insert.ext
  %resident.sroa.294.56.vec.extract = extractelement <4 x float> %resident.sroa.294.15, i64 2
  %resident.sroa.434.120.vec.extract = extractelement <4 x float> %resident.sroa.434.15, i64 2
  %add482.14 = fadd contract float %resident.sroa.294.56.vec.extract, %resident.sroa.434.120.vec.extract
  %resident.sroa.562.184.vec.extract = extractelement <4 x float> %resident.sroa.562.15, i64 2
  %add490.14 = fadd contract float %add482.14, %resident.sroa.562.184.vec.extract
  %resident.sroa.690.248.vec.extract = extractelement <4 x float> %resident.sroa.690.15, i64 2
  %add498.14 = fadd contract float %add490.14, %resident.sroa.690.248.vec.extract
  %mul504.14 = fmul contract float %328, %add498.14
  %343 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504.14)
  %oreg.sroa.17.28.insert.ext = zext i16 %343 to i64
  %oreg.sroa.17.28.insert.shift = shl nuw nsw i64 %oreg.sroa.17.28.insert.ext, 32
  %oreg.sroa.17.28.insert.insert = or disjoint i64 %oreg.sroa.17.26.insert.insert, %oreg.sroa.17.28.insert.shift
  %resident.sroa.294.60.vec.extract = extractelement <4 x float> %resident.sroa.294.15, i64 3
  %resident.sroa.434.124.vec.extract = extractelement <4 x float> %resident.sroa.434.15, i64 3
  %add482.15 = fadd contract float %resident.sroa.294.60.vec.extract, %resident.sroa.434.124.vec.extract
  %resident.sroa.562.188.vec.extract = extractelement <4 x float> %resident.sroa.562.15, i64 3
  %add490.15 = fadd contract float %add482.15, %resident.sroa.562.188.vec.extract
  %resident.sroa.690.252.vec.extract = extractelement <4 x float> %resident.sroa.690.15, i64 3
  %add498.15 = fadd contract float %add490.15, %resident.sroa.690.252.vec.extract
  %mul504.15 = fmul contract float %328, %add498.15
  %344 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul504.15)
  %oreg.sroa.17.30.insert.ext = zext i16 %344 to i64
  %oreg.sroa.17.30.insert.shift = shl nuw i64 %oreg.sroa.17.30.insert.ext, 48
  %oreg.sroa.17.30.insert.insert = or disjoint i64 %oreg.sroa.17.28.insert.insert, %oreg.sroa.17.30.insert.shift
  %and524 = shl nuw nsw i32 %18, 6
  %mul525 = and i32 %and524, 960
  %and528 = lshr i32 %18, 5
  %shr529 = and i32 %and528, 1
  %and532 = and i32 %18, 7
  %mul538 = and i32 %33, 4
  %xor = xor i32 %shr529, %and532
  %mul533 = shl nuw nsw i32 %xor, 3
  %add534 = or disjoint i32 %mul533, %mul525
  %add539 = or disjoint i32 %add534, %mul538
  %add.ptr541 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add539
  store i64 %oreg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr541, align 8
  %xor.1 = xor i32 %and528, %and532
  %mul533.1 = shl nuw nsw i32 %xor.1, 3
  %add534.1 = or disjoint i32 %mul533.1, %mul525
  %add539.1 = or disjoint i32 %add534.1, %mul538
  %add.ptr541.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add539.1
  store i64 %oreg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr541.1, align 8
  %add530.2 = or disjoint i32 %shr529, 4
  %xor.2 = xor i32 %add530.2, %and532
  %mul533.2 = shl nuw nsw i32 %xor.2, 3
  %add534.2 = or disjoint i32 %mul533.2, %mul525
  %add539.2 = or disjoint i32 %add534.2, %mul538
  %add.ptr541.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add539.2
  store i64 %oreg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr541.2, align 8
  %add530.3 = or i32 %and528, 6
  %xor.3 = xor i32 %add530.3, %and532
  %mul533.3 = shl nuw nsw i32 %xor.3, 3
  %add534.3 = or disjoint i32 %mul533.3, %mul525
  %add539.3 = or disjoint i32 %add534.3, %mul538
  %add.ptr541.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add539.3
  store i64 %oreg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr541.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul553 = and i32 %and121, 448
  %xor560 = xor i32 %and121, %18
  %mul561 = and i32 %xor560, 56
  %345 = or disjoint i32 %mul561, %mul553
  %mul566 = shl nsw i32 %0, 20
  %mul568 = shl nsw i32 %1, 10
  %add569 = add nuw nsw i32 %mul566, %mul568
  %346 = or disjoint i32 %add569, %mul302
  %347 = zext nneg i32 %346 to i64
  %add.ptr564 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %345
  %add.ptr577 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %347
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr577, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr564, i64 16, i1 false), !tbaa.struct !223, !call_argsrelate !224
  %348 = or disjoint i32 %345, 512
  %add.ptr564.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %348
  %349 = or disjoint i64 %347, 512
  %add.ptr577.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %349
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr577.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr564.1, i64 16, i1 false), !tbaa.struct !223, !call_argsrelate !224
  br label %if.end581

if.end581:                                        ; preds = %if.then467, %if.end463
  ret void
}

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

declare i32 @llvm.mxc.block.id.x() #5

declare i32 @llvm.mxc.block.id.y() #5

declare i32 @llvm.mxc.block.id.z() #5

declare i32 @llvm.mxc.thread.id.x() #5

declare float @llvm.exp.f32(float) #6

declare i16 @llvm.convert.to.fp16.f32(float) #7

declare void @llvm.mxc.barrier() #8

declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

declare void @llvm.mxc.barrier.warp() #8

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

declare i1 @llvm.mxc.is.private(ptr nocapture) #5

declare void @llvm.mxc.sleep(i32 immarg) #9

declare i32 @llvm.smax.i32(i32, i32) #6

declare i32 @llvm.smin.i32(i32, i32) #6

declare float @llvm.minnum.f32(float, float) #6

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


