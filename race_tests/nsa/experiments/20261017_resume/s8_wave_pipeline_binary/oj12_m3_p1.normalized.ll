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
  %cond.i.i615 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64)
  %mul11 = shl nsw i32 %cond.i.i615, 4
  %4 = or disjoint i64 %2, 1
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !call_argsrelate !48
  %cond.i.i615.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64)
  %mul11.1 = shl nsw i32 %cond.i.i615.1, 4
  %6 = or disjoint i64 %2, 2
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !call_argsrelate !48
  %cond.i.i615.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64)
  %mul11.2 = shl nsw i32 %cond.i.i615.2, 4
  %8 = or disjoint i64 %2, 3
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !call_argsrelate !48
  %cond.i.i615.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64)
  %mul11.3 = shl nsw i32 %cond.i.i615.3, 4
  %10 = or disjoint i64 %2, 4
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !call_argsrelate !48
  %cond.i.i615.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64)
  %mul11.4 = shl nsw i32 %cond.i.i615.4, 4
  %12 = or disjoint i64 %2, 5
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !call_argsrelate !48
  %cond.i.i615.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64)
  %mul11.5 = shl nsw i32 %cond.i.i615.5, 4
  %14 = or disjoint i64 %2, 6
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !call_argsrelate !48
  %cond.i.i615.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64)
  %mul11.6 = shl nsw i32 %cond.i.i615.6, 4
  %16 = or disjoint i64 %2, 7
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !call_argsrelate !48
  %cond.i.i615.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64)
  %mul11.7 = shl nsw i32 %cond.i.i615.7, 4
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
  %qr.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16
  %qr.sroa.15.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %qr.sroa.15.0.copyload = load <4 x half>, ptr addrspace(4) %qr.sroa.15.0.add.ptr.sroa_idx, align 8
  %23 = or disjoint i64 %20, %21
  %24 = or disjoint i64 %23, 32
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %24
  %qr.sroa.27.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16
  %qr.sroa.40.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr.1, i64 8
  %qr.sroa.40.16.copyload = load <4 x half>, ptr addrspace(4) %qr.sroa.40.16.add.ptr.1.sroa_idx, align 8
  br label %if.end

if.end:                                           ; preds = %entry, %for.cond16.preheader
  %qr.sroa.40.0 = phi <4 x half> [ %qr.sroa.40.16.copyload, %for.cond16.preheader ], [ undef, %entry ]
  %qr.sroa.27.0 = phi <4 x half> [ %qr.sroa.27.16.copyload, %for.cond16.preheader ], [ undef, %entry ]
  %qr.sroa.15.0 = phi <4 x half> [ %qr.sroa.15.0.copyload, %for.cond16.preheader ], [ undef, %entry ]
  %qr.sroa.0.0 = phi <4 x half> [ %qr.sroa.0.0.copyload, %for.cond16.preheader ], [ undef, %entry ]
  %cmp80 = icmp ugt i32 %18, 63
  %shr256.mask = and i32 %18, 960
  %cmp257.not = icmp eq i32 %shr256.mask, 64
  %mul103 = shl nsw i32 %0, 16
  %and110 = shl nuw nsw i32 %18, 3
  %and246 = shl nuw nsw i32 %18, 2
  %invariant.op = add nsw i32 %1, -15
  %25 = lshr i32 %18, 2
  %mul154 = and i32 %25, 12
  %mul289 = and i32 %and110, 504
  %mul305 = and i32 %and246, 252
  %26 = zext nneg i32 %and110 to i64
  %27 = zext nneg i32 %mul289 to i64
  br i1 %cmp80, label %if.end356, label %for.cond83.preheader

for.body368.preheader:                            ; preds = %if.end356.2
  %add372 = fadd contract float %sums.sroa.0.10, 0.000000e+00
  %add372.1 = fadd contract float %add372, %sums.sroa.28.10
  %add372.2 = fadd contract float %add372.1, %sums.sroa.54.10
  %add372.3 = fadd contract float %add372.2, %sums.sroa.80.10
  %28 = bitcast float %add372.3 to i32
  %29 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %30 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %29) #11
  %xor.i.i = xor i32 %30, 32
  %31 = and i32 %30, -64
  %and.i.i = add nsw i32 %31, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i616 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %30
  %shl.i.i = shl i32 %cond.i.i616, 2
  %32 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %28)
  %33 = bitcast i32 %32 to float
  %add380 = fadd contract float %add372.3, %33
  %34 = bitcast float %add380 to i32
  %35 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %36 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %35) #11
  %xor.i.i617 = xor i32 %36, 16
  %37 = and i32 %36, -64
  %and.i.i618 = add nsw i32 %37, 64
  %cmp.not.i.i619 = icmp slt i32 %xor.i.i617, %and.i.i618
  %cond.i.i620 = select i1 %cmp.not.i.i619, i32 %xor.i.i617, i32 %36
  %shl.i.i621 = shl i32 %cond.i.i620, 2
  %38 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i621, i32 %34)
  %39 = bitcast i32 %38 to float
  %add385 = fadd contract float %add380, %39
  %cmp388 = fcmp contract ogt float %add385, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add385
  %condval_1.0 = select i1 %cmp388, float %div, float 0.000000e+00
  %arrayidx398 = getelementptr inbounds float, ptr addrspace(3) @buf_dyn_shmem, i32 %18
  store float %condval_1.0, ptr addrspace(3) %arrayidx398, align 4, !tbaa !105
  br label %if.end399

for.cond83.preheader:                             ; preds = %if.end
  %or.cond646 = icmp ugt i32 %mul11, 1023
  %cmp96.not = icmp sgt i32 %mul11, %1
  %or.cond647 = or i1 %or.cond646, %cmp96.not
  br i1 %or.cond647, label %if.end124, label %for.cond98.preheader

for.cond98.preheader:                             ; preds = %for.cond83.preheader
  %40 = shl nsw i32 %cond.i.i615, 10
  %mul105 = and i32 %40, 64512
  %add106 = or disjoint i32 %mul105, %mul103
  %41 = zext nneg i32 %add106 to i64
  %42 = or disjoint i64 %41, %26
  %add.ptr114 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %42
  %kr.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr114, align 16
  %kr.sroa.8.0.add.ptr114.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114, i64 8
  %kr.sroa.8.0.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.8.0.add.ptr114.sroa_idx, align 8
  %43 = or disjoint i64 %41, %26
  %44 = or disjoint i64 %43, 512
  %add.ptr114.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %44
  %kr.sroa.11.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr114.1, align 16
  %kr.sroa.17.16.add.ptr114.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114.1, i64 8
  %kr.sroa.17.16.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.17.16.add.ptr114.1.sroa_idx, align 8
  br label %if.end124

if.end124:                                        ; preds = %for.cond98.preheader, %for.cond83.preheader
  %kr.sroa.17.0 = phi <4 x half> [ undef, %for.cond83.preheader ], [ %kr.sroa.17.16.copyload, %for.cond98.preheader ]
  %kr.sroa.11.0 = phi <4 x half> [ undef, %for.cond83.preheader ], [ %kr.sroa.11.16.copyload, %for.cond98.preheader ]
  %kr.sroa.8.0 = phi <4 x half> [ undef, %for.cond83.preheader ], [ %kr.sroa.8.0.copyload, %for.cond98.preheader ]
  %kr.sroa.0.0 = phi <4 x half> [ undef, %for.cond83.preheader ], [ %kr.sroa.0.0.copyload, %for.cond98.preheader ]
  %or.cond646.1 = icmp ugt i32 %mul11.1, 1023
  %cmp96.not.1 = icmp sgt i32 %mul11.1, %1
  %or.cond647.1 = or i1 %or.cond646.1, %cmp96.not.1
  br i1 %or.cond647.1, label %if.end124.1, label %for.cond98.preheader.1

for.cond98.preheader.1:                           ; preds = %if.end124
  %45 = shl nsw i32 %cond.i.i615.1, 10
  %mul105.1 = and i32 %45, 64512
  %add106.1 = or disjoint i32 %mul105.1, %mul103
  %46 = zext nneg i32 %add106.1 to i64
  %47 = or disjoint i64 %46, %26
  %add.ptr114.1665 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %47
  %kr.sroa.20.32.copyload = load <4 x half>, ptr addrspace(4) %add.ptr114.1665, align 16
  %kr.sroa.26.32.add.ptr114.1665.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114.1665, i64 8
  %kr.sroa.26.32.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.26.32.add.ptr114.1665.sroa_idx, align 8
  %48 = or disjoint i64 %46, %26
  %49 = or disjoint i64 %48, 512
  %add.ptr114.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %49
  %kr.sroa.29.48.copyload = load <4 x half>, ptr addrspace(4) %add.ptr114.1.1, align 16
  %kr.sroa.35.48.add.ptr114.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114.1.1, i64 8
  %kr.sroa.35.48.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.35.48.add.ptr114.1.1.sroa_idx, align 8
  br label %if.end124.1

if.end124.1:                                      ; preds = %for.cond98.preheader.1, %if.end124
  %kr.sroa.35.0 = phi <4 x half> [ undef, %if.end124 ], [ %kr.sroa.35.48.copyload, %for.cond98.preheader.1 ]
  %kr.sroa.29.0 = phi <4 x half> [ undef, %if.end124 ], [ %kr.sroa.29.48.copyload, %for.cond98.preheader.1 ]
  %kr.sroa.26.0 = phi <4 x half> [ undef, %if.end124 ], [ %kr.sroa.26.32.copyload, %for.cond98.preheader.1 ]
  %kr.sroa.20.0 = phi <4 x half> [ undef, %if.end124 ], [ %kr.sroa.20.32.copyload, %for.cond98.preheader.1 ]
  %or.cond646.2 = icmp ugt i32 %mul11.2, 1023
  %cmp96.not.2 = icmp sgt i32 %mul11.2, %1
  %or.cond647.2 = or i1 %or.cond646.2, %cmp96.not.2
  br i1 %or.cond647.2, label %if.end124.2, label %for.cond98.preheader.2

for.cond98.preheader.2:                           ; preds = %if.end124.1
  %50 = shl nsw i32 %cond.i.i615.2, 10
  %mul105.2 = and i32 %50, 64512
  %add106.2 = or disjoint i32 %mul105.2, %mul103
  %51 = zext nneg i32 %add106.2 to i64
  %52 = or disjoint i64 %51, %26
  %add.ptr114.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %52
  %kr.sroa.38.64.copyload = load <4 x half>, ptr addrspace(4) %add.ptr114.2, align 16
  %kr.sroa.44.64.add.ptr114.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114.2, i64 8
  %kr.sroa.44.64.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.44.64.add.ptr114.2.sroa_idx, align 8
  %53 = or disjoint i64 %51, %26
  %54 = or disjoint i64 %53, 512
  %add.ptr114.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %54
  %kr.sroa.47.80.copyload = load <4 x half>, ptr addrspace(4) %add.ptr114.1.2, align 16
  %kr.sroa.53.80.add.ptr114.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114.1.2, i64 8
  %kr.sroa.53.80.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.53.80.add.ptr114.1.2.sroa_idx, align 8
  br label %if.end124.2

if.end124.2:                                      ; preds = %for.cond98.preheader.2, %if.end124.1
  %kr.sroa.53.0 = phi <4 x half> [ undef, %if.end124.1 ], [ %kr.sroa.53.80.copyload, %for.cond98.preheader.2 ]
  %kr.sroa.47.0 = phi <4 x half> [ undef, %if.end124.1 ], [ %kr.sroa.47.80.copyload, %for.cond98.preheader.2 ]
  %kr.sroa.44.0 = phi <4 x half> [ undef, %if.end124.1 ], [ %kr.sroa.44.64.copyload, %for.cond98.preheader.2 ]
  %kr.sroa.38.0 = phi <4 x half> [ undef, %if.end124.1 ], [ %kr.sroa.38.64.copyload, %for.cond98.preheader.2 ]
  %or.cond646.3 = icmp ugt i32 %mul11.3, 1023
  %cmp96.not.3 = icmp sgt i32 %mul11.3, %1
  %or.cond647.3 = or i1 %or.cond646.3, %cmp96.not.3
  br i1 %or.cond647.3, label %if.end124.3, label %for.cond98.preheader.3

for.cond98.preheader.3:                           ; preds = %if.end124.2
  %55 = shl nsw i32 %cond.i.i615.3, 10
  %mul105.3 = and i32 %55, 64512
  %add106.3 = or disjoint i32 %mul105.3, %mul103
  %56 = zext nneg i32 %add106.3 to i64
  %57 = or disjoint i64 %56, %26
  %add.ptr114.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %57
  %kr.sroa.56.96.copyload = load <4 x half>, ptr addrspace(4) %add.ptr114.3, align 16
  %kr.sroa.62.96.add.ptr114.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114.3, i64 8
  %kr.sroa.62.96.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.62.96.add.ptr114.3.sroa_idx, align 8
  %58 = or disjoint i64 %56, %26
  %59 = or disjoint i64 %58, 512
  %add.ptr114.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %59
  %kr.sroa.65.112.copyload = load <4 x half>, ptr addrspace(4) %add.ptr114.1.3, align 16
  %kr.sroa.71.112.add.ptr114.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114.1.3, i64 8
  %kr.sroa.71.112.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.71.112.add.ptr114.1.3.sroa_idx, align 8
  br label %if.end124.3

if.end124.3:                                      ; preds = %for.cond98.preheader.3, %if.end124.2
  %kr.sroa.71.0 = phi <4 x half> [ undef, %if.end124.2 ], [ %kr.sroa.71.112.copyload, %for.cond98.preheader.3 ]
  %kr.sroa.65.0 = phi <4 x half> [ undef, %if.end124.2 ], [ %kr.sroa.65.112.copyload, %for.cond98.preheader.3 ]
  %kr.sroa.62.0 = phi <4 x half> [ undef, %if.end124.2 ], [ %kr.sroa.62.96.copyload, %for.cond98.preheader.3 ]
  %kr.sroa.56.0 = phi <4 x half> [ undef, %if.end124.2 ], [ %kr.sroa.56.96.copyload, %for.cond98.preheader.3 ]
  br i1 %or.cond647, label %if.end239, label %if.then142

if.then142:                                       ; preds = %if.end124.3
  %cmp145 = icmp sgt i32 %mul11, %invariant.op
  br i1 %cmp145, label %for.cond147.preheader, label %if.end173

for.cond147.preheader:                            ; preds = %if.then142
  %add155 = or disjoint i32 %mul11, %mul154
  %cmp158.not = icmp sgt i32 %add155, %1
  %spec.select = select i1 %cmp158.not, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1039 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp158.not.1.not = icmp slt i32 %add155, %1
  %spec.select.1 = select i1 %cmp158.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1178 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1039, float %spec.select.1, i64 1
  %add156.2 = or disjoint i32 %add155, 2
  %cmp158.not.2 = icmp sgt i32 %add156.2, %1
  %spec.select.2 = select i1 %cmp158.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1295 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1178, float %spec.select.2, i64 2
  %add156.3 = or disjoint i32 %add155, 3
  %cmp158.not.3 = icmp sgt i32 %add156.3, %1
  %spec.select.3 = select i1 %cmp158.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1412 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1295, float %spec.select.3, i64 3
  br label %if.end173

if.end173:                                        ; preds = %if.then142, %for.cond147.preheader
  %scores.sroa.0.0 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1412, %for.cond147.preheader ], [ zeroinitializer, %if.then142 ]
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.0)
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.8.0, <4 x half> %qr.sroa.15.0, <4 x float> %60)
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.11.0, <4 x half> %qr.sroa.27.0, <4 x float> %61)
  %63 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.17.0, <4 x half> %qr.sroa.40.0, <4 x float> %62)
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %63, i64 0
  %mul199 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %64 = tail call contract noundef float @llvm.minnum.f32(float %mul199, float 0x4024CB5EC0000000)
  %65 = tail call contract noundef float @llvm.exp.f32(float %64)
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %63, i64 1
  %mul199.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %66 = tail call contract noundef float @llvm.minnum.f32(float %mul199.1, float 0x4024CB5EC0000000)
  %67 = tail call contract noundef float @llvm.exp.f32(float %66)
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %63, i64 2
  %mul199.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %68 = tail call contract noundef float @llvm.minnum.f32(float %mul199.2, float 0x4024CB5EC0000000)
  %69 = tail call contract noundef float @llvm.exp.f32(float %68)
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %63, i64 3
  %mul199.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %70 = tail call contract noundef float @llvm.minnum.f32(float %mul199.3, float 0x4024CB5EC0000000)
  %71 = tail call contract noundef float @llvm.exp.f32(float %70)
  %72 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %65)
  %probs.sroa.0.0.vec.insert = insertelement <4 x i16> poison, i16 %72, i64 0
  %73 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %67)
  %probs.sroa.0.2.vec.insert = insertelement <4 x i16> %probs.sroa.0.0.vec.insert, i16 %73, i64 1
  %74 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %69)
  %probs.sroa.0.4.vec.insert = insertelement <4 x i16> %probs.sroa.0.2.vec.insert, i16 %74, i64 2
  %75 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %71)
  %probs.sroa.0.6.vec.insert = insertelement <4 x i16> %probs.sroa.0.4.vec.insert, i16 %75, i64 3
  br label %if.end239

if.end239:                                        ; preds = %if.end124.3, %if.end173
  %sums.sroa.80.1 = phi float [ %71, %if.end173 ], [ 0.000000e+00, %if.end124.3 ]
  %sums.sroa.54.1 = phi float [ %69, %if.end173 ], [ 0.000000e+00, %if.end124.3 ]
  %sums.sroa.28.1 = phi float [ %67, %if.end173 ], [ 0.000000e+00, %if.end124.3 ]
  %sums.sroa.0.1 = phi float [ %65, %if.end173 ], [ 0.000000e+00, %if.end124.3 ]
  %probs.sroa.0.0 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert, %if.end173 ], [ zeroinitializer, %if.end124.3 ]
  %add.ptr250 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and246
  store <4 x i16> %probs.sroa.0.0, ptr addrspace(3) %add.ptr250, align 8
  br i1 %or.cond647.1, label %if.end239.1, label %if.then142.1

if.then142.1:                                     ; preds = %if.end239
  %cmp145.1 = icmp sgt i32 %mul11.1, %invariant.op
  br i1 %cmp145.1, label %for.cond147.preheader.1, label %if.end173.1

for.cond147.preheader.1:                          ; preds = %if.then142.1
  %add155.1 = or disjoint i32 %mul11.1, %mul154
  %cmp158.not.1668 = icmp sgt i32 %add155.1, %1
  %spec.select.1669 = select i1 %cmp158.not.1668, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1048 = insertelement <4 x float> poison, float %spec.select.1669, i64 0
  %cmp158.not.1.1.not = icmp slt i32 %add155.1, %1
  %spec.select.1.1 = select i1 %cmp158.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1185 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1048, float %spec.select.1.1, i64 1
  %add156.2.1 = or disjoint i32 %add155.1, 2
  %cmp158.not.2.1 = icmp sgt i32 %add156.2.1, %1
  %spec.select.2.1 = select i1 %cmp158.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1302 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1185, float %spec.select.2.1, i64 2
  %add156.3.1 = or disjoint i32 %add155.1, 3
  %cmp158.not.3.1 = icmp sgt i32 %add156.3.1, %1
  %spec.select.3.1 = select i1 %cmp158.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1419 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1302, float %spec.select.3.1, i64 3
  br label %if.end173.1

if.end173.1:                                      ; preds = %if.then142.1, %for.cond147.preheader.1
  %scores.sroa.0.2 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1419, %for.cond147.preheader.1 ], [ zeroinitializer, %if.then142.1 ]
  %76 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.20.0, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.2)
  %77 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.26.0, <4 x half> %qr.sroa.15.0, <4 x float> %76)
  %78 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.29.0, <4 x half> %qr.sroa.27.0, <4 x float> %77)
  %79 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.35.0, <4 x half> %qr.sroa.40.0, <4 x float> %78)
  %scores.sroa.0.0.vec.extract1050 = extractelement <4 x float> %79, i64 0
  %mul199.1672 = fmul contract float %scores.sroa.0.0.vec.extract1050, 0x3FB99999A0000000
  %80 = tail call contract noundef float @llvm.minnum.f32(float %mul199.1672, float 0x4024CB5EC0000000)
  %81 = tail call contract noundef float @llvm.exp.f32(float %80)
  %scores.sroa.0.4.vec.extract1187 = extractelement <4 x float> %79, i64 1
  %mul199.1.1 = fmul contract float %scores.sroa.0.4.vec.extract1187, 0x3FB99999A0000000
  %82 = tail call contract noundef float @llvm.minnum.f32(float %mul199.1.1, float 0x4024CB5EC0000000)
  %83 = tail call contract noundef float @llvm.exp.f32(float %82)
  %scores.sroa.0.8.vec.extract1304 = extractelement <4 x float> %79, i64 2
  %mul199.2.1 = fmul contract float %scores.sroa.0.8.vec.extract1304, 0x3FB99999A0000000
  %84 = tail call contract noundef float @llvm.minnum.f32(float %mul199.2.1, float 0x4024CB5EC0000000)
  %85 = tail call contract noundef float @llvm.exp.f32(float %84)
  %scores.sroa.0.12.vec.extract1421 = extractelement <4 x float> %79, i64 3
  %mul199.3.1 = fmul contract float %scores.sroa.0.12.vec.extract1421, 0x3FB99999A0000000
  %86 = tail call contract noundef float @llvm.minnum.f32(float %mul199.3.1, float 0x4024CB5EC0000000)
  %87 = tail call contract noundef float @llvm.exp.f32(float %86)
  %add215.1673 = fadd contract float %sums.sroa.0.1, %81
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %81)
  %probs.sroa.0.0.vec.insert1554 = insertelement <4 x i16> poison, i16 %88, i64 0
  %add215.1.1 = fadd contract float %sums.sroa.28.1, %83
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %83)
  %probs.sroa.0.2.vec.insert1600 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1554, i16 %89, i64 1
  %add215.2.1 = fadd contract float %sums.sroa.54.1, %85
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %85)
  %probs.sroa.0.4.vec.insert1645 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1600, i16 %90, i64 2
  %add215.3.1 = fadd contract float %sums.sroa.80.1, %87
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %87)
  %probs.sroa.0.6.vec.insert1667 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1645, i16 %91, i64 3
  br label %if.end239.1

if.end239.1:                                      ; preds = %if.end239, %if.end173.1
  %sums.sroa.80.2 = phi float [ %add215.3.1, %if.end173.1 ], [ %sums.sroa.80.1, %if.end239 ]
  %sums.sroa.54.2 = phi float [ %add215.2.1, %if.end173.1 ], [ %sums.sroa.54.1, %if.end239 ]
  %sums.sroa.28.2 = phi float [ %add215.1.1, %if.end173.1 ], [ %sums.sroa.28.1, %if.end239 ]
  %sums.sroa.0.2 = phi float [ %add215.1673, %if.end173.1 ], [ %sums.sroa.0.1, %if.end239 ]
  %probs.sroa.0.1 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1667, %if.end173.1 ], [ zeroinitializer, %if.end239 ]
  %add248.1 = or disjoint i32 %and246, 256
  %add.ptr250.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add248.1
  store <4 x i16> %probs.sroa.0.1, ptr addrspace(3) %add.ptr250.1, align 8
  br i1 %or.cond647.2, label %if.end239.2, label %if.then142.2

if.then142.2:                                     ; preds = %if.end239.1
  %cmp145.2 = icmp sgt i32 %mul11.2, %invariant.op
  br i1 %cmp145.2, label %for.cond147.preheader.2, label %if.end173.2

for.cond147.preheader.2:                          ; preds = %if.then142.2
  %add155.2 = or disjoint i32 %mul11.2, %mul154
  %cmp158.not.2674 = icmp sgt i32 %add155.2, %1
  %spec.select.2675 = select i1 %cmp158.not.2674, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1058 = insertelement <4 x float> poison, float %spec.select.2675, i64 0
  %cmp158.not.1.2.not = icmp slt i32 %add155.2, %1
  %spec.select.1.2 = select i1 %cmp158.not.1.2.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1193 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1058, float %spec.select.1.2, i64 1
  %add156.2.2 = or disjoint i32 %add155.2, 2
  %cmp158.not.2.2 = icmp sgt i32 %add156.2.2, %1
  %spec.select.2.2 = select i1 %cmp158.not.2.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1310 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1193, float %spec.select.2.2, i64 2
  %add156.3.2 = or disjoint i32 %add155.2, 3
  %cmp158.not.3.2 = icmp sgt i32 %add156.3.2, %1
  %spec.select.3.2 = select i1 %cmp158.not.3.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1427 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1310, float %spec.select.3.2, i64 3
  br label %if.end173.2

if.end173.2:                                      ; preds = %if.then142.2, %for.cond147.preheader.2
  %scores.sroa.0.4 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1427, %for.cond147.preheader.2 ], [ zeroinitializer, %if.then142.2 ]
  %92 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.38.0, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.4)
  %93 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.44.0, <4 x half> %qr.sroa.15.0, <4 x float> %92)
  %94 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.0, <4 x half> %qr.sroa.27.0, <4 x float> %93)
  %95 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.53.0, <4 x half> %qr.sroa.40.0, <4 x float> %94)
  %scores.sroa.0.0.vec.extract1060 = extractelement <4 x float> %95, i64 0
  %mul199.2678 = fmul contract float %scores.sroa.0.0.vec.extract1060, 0x3FB99999A0000000
  %96 = tail call contract noundef float @llvm.minnum.f32(float %mul199.2678, float 0x4024CB5EC0000000)
  %97 = tail call contract noundef float @llvm.exp.f32(float %96)
  %scores.sroa.0.4.vec.extract1195 = extractelement <4 x float> %95, i64 1
  %mul199.1.2 = fmul contract float %scores.sroa.0.4.vec.extract1195, 0x3FB99999A0000000
  %98 = tail call contract noundef float @llvm.minnum.f32(float %mul199.1.2, float 0x4024CB5EC0000000)
  %99 = tail call contract noundef float @llvm.exp.f32(float %98)
  %scores.sroa.0.8.vec.extract1312 = extractelement <4 x float> %95, i64 2
  %mul199.2.2 = fmul contract float %scores.sroa.0.8.vec.extract1312, 0x3FB99999A0000000
  %100 = tail call contract noundef float @llvm.minnum.f32(float %mul199.2.2, float 0x4024CB5EC0000000)
  %101 = tail call contract noundef float @llvm.exp.f32(float %100)
  %scores.sroa.0.12.vec.extract1429 = extractelement <4 x float> %95, i64 3
  %mul199.3.2 = fmul contract float %scores.sroa.0.12.vec.extract1429, 0x3FB99999A0000000
  %102 = tail call contract noundef float @llvm.minnum.f32(float %mul199.3.2, float 0x4024CB5EC0000000)
  %103 = tail call contract noundef float @llvm.exp.f32(float %102)
  %add215.2679 = fadd contract float %sums.sroa.0.2, %97
  %104 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %97)
  %probs.sroa.0.0.vec.insert1556 = insertelement <4 x i16> poison, i16 %104, i64 0
  %add215.1.2 = fadd contract float %sums.sroa.28.2, %99
  %105 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %99)
  %probs.sroa.0.2.vec.insert1602 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1556, i16 %105, i64 1
  %add215.2.2 = fadd contract float %sums.sroa.54.2, %101
  %106 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %101)
  %probs.sroa.0.4.vec.insert1647 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1602, i16 %106, i64 2
  %add215.3.2 = fadd contract float %sums.sroa.80.2, %103
  %107 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %103)
  %probs.sroa.0.6.vec.insert1669 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1647, i16 %107, i64 3
  br label %if.end239.2

if.end239.2:                                      ; preds = %if.end239.1, %if.end173.2
  %sums.sroa.80.3 = phi float [ %add215.3.2, %if.end173.2 ], [ %sums.sroa.80.2, %if.end239.1 ]
  %sums.sroa.54.3 = phi float [ %add215.2.2, %if.end173.2 ], [ %sums.sroa.54.2, %if.end239.1 ]
  %sums.sroa.28.3 = phi float [ %add215.1.2, %if.end173.2 ], [ %sums.sroa.28.2, %if.end239.1 ]
  %sums.sroa.0.3 = phi float [ %add215.2679, %if.end173.2 ], [ %sums.sroa.0.2, %if.end239.1 ]
  %probs.sroa.0.2 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1669, %if.end173.2 ], [ zeroinitializer, %if.end239.1 ]
  %add248.2 = or disjoint i32 %and246, 512
  %add.ptr250.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add248.2
  store <4 x i16> %probs.sroa.0.2, ptr addrspace(3) %add.ptr250.2, align 8
  br i1 %or.cond647.3, label %if.end239.3, label %if.then142.3

if.then142.3:                                     ; preds = %if.end239.2
  %cmp145.3 = icmp sgt i32 %mul11.3, %invariant.op
  br i1 %cmp145.3, label %for.cond147.preheader.3, label %if.end173.3

for.cond147.preheader.3:                          ; preds = %if.then142.3
  %add155.3 = or disjoint i32 %mul11.3, %mul154
  %cmp158.not.3680 = icmp sgt i32 %add155.3, %1
  %spec.select.3681 = select i1 %cmp158.not.3680, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1068 = insertelement <4 x float> poison, float %spec.select.3681, i64 0
  %cmp158.not.1.3.not = icmp slt i32 %add155.3, %1
  %spec.select.1.3 = select i1 %cmp158.not.1.3.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1201 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1068, float %spec.select.1.3, i64 1
  %add156.2.3 = or disjoint i32 %add155.3, 2
  %cmp158.not.2.3 = icmp sgt i32 %add156.2.3, %1
  %spec.select.2.3 = select i1 %cmp158.not.2.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1318 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1201, float %spec.select.2.3, i64 2
  %add156.3.3 = or disjoint i32 %add155.3, 3
  %cmp158.not.3.3 = icmp sgt i32 %add156.3.3, %1
  %spec.select.3.3 = select i1 %cmp158.not.3.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1435 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1318, float %spec.select.3.3, i64 3
  br label %if.end173.3

if.end173.3:                                      ; preds = %if.then142.3, %for.cond147.preheader.3
  %scores.sroa.0.6 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1435, %for.cond147.preheader.3 ], [ zeroinitializer, %if.then142.3 ]
  %108 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.56.0, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.6)
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.62.0, <4 x half> %qr.sroa.15.0, <4 x float> %108)
  %110 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.65.0, <4 x half> %qr.sroa.27.0, <4 x float> %109)
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.71.0, <4 x half> %qr.sroa.40.0, <4 x float> %110)
  %scores.sroa.0.0.vec.extract1070 = extractelement <4 x float> %111, i64 0
  %mul199.3684 = fmul contract float %scores.sroa.0.0.vec.extract1070, 0x3FB99999A0000000
  %112 = tail call contract noundef float @llvm.minnum.f32(float %mul199.3684, float 0x4024CB5EC0000000)
  %113 = tail call contract noundef float @llvm.exp.f32(float %112)
  %scores.sroa.0.4.vec.extract1203 = extractelement <4 x float> %111, i64 1
  %mul199.1.3 = fmul contract float %scores.sroa.0.4.vec.extract1203, 0x3FB99999A0000000
  %114 = tail call contract noundef float @llvm.minnum.f32(float %mul199.1.3, float 0x4024CB5EC0000000)
  %115 = tail call contract noundef float @llvm.exp.f32(float %114)
  %scores.sroa.0.8.vec.extract1320 = extractelement <4 x float> %111, i64 2
  %mul199.2.3 = fmul contract float %scores.sroa.0.8.vec.extract1320, 0x3FB99999A0000000
  %116 = tail call contract noundef float @llvm.minnum.f32(float %mul199.2.3, float 0x4024CB5EC0000000)
  %117 = tail call contract noundef float @llvm.exp.f32(float %116)
  %scores.sroa.0.12.vec.extract1437 = extractelement <4 x float> %111, i64 3
  %mul199.3.3 = fmul contract float %scores.sroa.0.12.vec.extract1437, 0x3FB99999A0000000
  %118 = tail call contract noundef float @llvm.minnum.f32(float %mul199.3.3, float 0x4024CB5EC0000000)
  %119 = tail call contract noundef float @llvm.exp.f32(float %118)
  %add215.3685 = fadd contract float %sums.sroa.0.3, %113
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %113)
  %probs.sroa.0.0.vec.insert1558 = insertelement <4 x i16> poison, i16 %120, i64 0
  %add215.1.3 = fadd contract float %sums.sroa.28.3, %115
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %115)
  %probs.sroa.0.2.vec.insert1604 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1558, i16 %121, i64 1
  %add215.2.3 = fadd contract float %sums.sroa.54.3, %117
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %117)
  %probs.sroa.0.4.vec.insert1649 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1604, i16 %122, i64 2
  %add215.3.3 = fadd contract float %sums.sroa.80.3, %119
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %119)
  %probs.sroa.0.6.vec.insert1671 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1649, i16 %123, i64 3
  br label %if.end239.3

if.end239.3:                                      ; preds = %if.end239.2, %if.end173.3
  %sums.sroa.80.4 = phi float [ %add215.3.3, %if.end173.3 ], [ %sums.sroa.80.3, %if.end239.2 ]
  %sums.sroa.54.4 = phi float [ %add215.2.3, %if.end173.3 ], [ %sums.sroa.54.3, %if.end239.2 ]
  %sums.sroa.28.4 = phi float [ %add215.1.3, %if.end173.3 ], [ %sums.sroa.28.3, %if.end239.2 ]
  %sums.sroa.0.4 = phi float [ %add215.3685, %if.end173.3 ], [ %sums.sroa.0.3, %if.end239.2 ]
  %probs.sroa.0.3 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1671, %if.end173.3 ], [ zeroinitializer, %if.end239.2 ]
  %add248.3 = or disjoint i32 %and246, 768
  %add.ptr250.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add248.3
  store <4 x i16> %probs.sroa.0.3, ptr addrspace(3) %add.ptr250.3, align 8
  br label %if.end356

if.end356:                                        ; preds = %if.end, %if.end239.3
  %sums.sroa.80.5 = phi float [ 0.000000e+00, %if.end ], [ %sums.sroa.80.4, %if.end239.3 ]
  %sums.sroa.54.5 = phi float [ 0.000000e+00, %if.end ], [ %sums.sroa.54.4, %if.end239.3 ]
  %sums.sroa.28.5 = phi float [ 0.000000e+00, %if.end ], [ %sums.sroa.28.4, %if.end239.3 ]
  %sums.sroa.0.5 = phi float [ 0.000000e+00, %if.end ], [ %sums.sroa.0.4, %if.end239.3 ]
  %kr.sroa.71.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.71.0, %if.end239.3 ]
  %kr.sroa.65.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.65.0, %if.end239.3 ]
  %kr.sroa.62.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.62.0, %if.end239.3 ]
  %kr.sroa.56.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.56.0, %if.end239.3 ]
  %kr.sroa.53.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.53.0, %if.end239.3 ]
  %kr.sroa.47.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.47.0, %if.end239.3 ]
  %kr.sroa.44.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.44.0, %if.end239.3 ]
  %kr.sroa.38.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.38.0, %if.end239.3 ]
  %kr.sroa.35.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.35.0, %if.end239.3 ]
  %kr.sroa.29.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.29.0, %if.end239.3 ]
  %kr.sroa.26.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.26.0, %if.end239.3 ]
  %kr.sroa.20.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.20.0, %if.end239.3 ]
  %kr.sroa.17.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.17.0, %if.end239.3 ]
  %kr.sroa.11.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.11.0, %if.end239.3 ]
  %kr.sroa.8.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.8.0, %if.end239.3 ]
  %kr.sroa.0.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.0.0, %if.end239.3 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %cmp80, label %if.end254.1, label %for.cond83.preheader.1

for.cond83.preheader.1:                           ; preds = %if.end356
  %or.cond646.1693 = icmp ugt i32 %mul11.4, 1023
  %cmp96.not.1694 = icmp sgt i32 %mul11.4, %1
  %or.cond647.1695 = or i1 %or.cond646.1693, %cmp96.not.1694
  br i1 %or.cond647.1695, label %if.end124.1702, label %for.cond98.preheader.1698

for.cond98.preheader.1698:                        ; preds = %for.cond83.preheader.1
  %124 = shl nsw i32 %cond.i.i615.4, 10
  %mul105.1696 = and i32 %124, 64512
  %add106.1697 = or disjoint i32 %mul105.1696, %mul103
  %125 = zext nneg i32 %add106.1697 to i64
  %126 = or disjoint i64 %125, %26
  %add.ptr114.1699 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %126
  %kr.sroa.0.0.copyload1690 = load <4 x half>, ptr addrspace(4) %add.ptr114.1699, align 16
  %kr.sroa.8.0.add.ptr114.1699.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114.1699, i64 8
  %kr.sroa.8.0.copyload1692 = load <4 x half>, ptr addrspace(4) %kr.sroa.8.0.add.ptr114.1699.sroa_idx, align 8
  %127 = or disjoint i64 %125, %26
  %128 = or disjoint i64 %127, 512
  %add.ptr114.1.1700 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %128
  %kr.sroa.11.16.copyload1698 = load <4 x half>, ptr addrspace(4) %add.ptr114.1.1700, align 16
  %kr.sroa.17.16.add.ptr114.1.1700.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114.1.1700, i64 8
  %kr.sroa.17.16.copyload1700 = load <4 x half>, ptr addrspace(4) %kr.sroa.17.16.add.ptr114.1.1700.sroa_idx, align 8
  br label %if.end124.1702

if.end124.1702:                                   ; preds = %for.cond98.preheader.1698, %for.cond83.preheader.1
  %kr.sroa.17.2 = phi <4 x half> [ %kr.sroa.17.1, %for.cond83.preheader.1 ], [ %kr.sroa.17.16.copyload1700, %for.cond98.preheader.1698 ]
  %kr.sroa.11.2 = phi <4 x half> [ %kr.sroa.11.1, %for.cond83.preheader.1 ], [ %kr.sroa.11.16.copyload1698, %for.cond98.preheader.1698 ]
  %kr.sroa.8.2 = phi <4 x half> [ %kr.sroa.8.1, %for.cond83.preheader.1 ], [ %kr.sroa.8.0.copyload1692, %for.cond98.preheader.1698 ]
  %kr.sroa.0.2 = phi <4 x half> [ %kr.sroa.0.1, %for.cond83.preheader.1 ], [ %kr.sroa.0.0.copyload1690, %for.cond98.preheader.1698 ]
  %or.cond646.1.1 = icmp ugt i32 %mul11.5, 1023
  %cmp96.not.1.1 = icmp sgt i32 %mul11.5, %1
  %or.cond647.1.1 = or i1 %or.cond646.1.1, %cmp96.not.1.1
  br i1 %or.cond647.1.1, label %if.end124.1.1, label %for.cond98.preheader.1.1

for.cond98.preheader.1.1:                         ; preds = %if.end124.1702
  %129 = shl nsw i32 %cond.i.i615.5, 10
  %mul105.1.1 = and i32 %129, 64512
  %add106.1.1 = or disjoint i32 %mul105.1.1, %mul103
  %130 = zext nneg i32 %add106.1.1 to i64
  %131 = or disjoint i64 %130, %26
  %add.ptr114.1665.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %131
  %kr.sroa.20.32.copyload1706 = load <4 x half>, ptr addrspace(4) %add.ptr114.1665.1, align 16
  %kr.sroa.26.32.add.ptr114.1665.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114.1665.1, i64 8
  %kr.sroa.26.32.copyload1708 = load <4 x half>, ptr addrspace(4) %kr.sroa.26.32.add.ptr114.1665.1.sroa_idx, align 8
  %132 = or disjoint i64 %130, %26
  %133 = or disjoint i64 %132, 512
  %add.ptr114.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %133
  %kr.sroa.29.48.copyload1714 = load <4 x half>, ptr addrspace(4) %add.ptr114.1.1.1, align 16
  %kr.sroa.35.48.add.ptr114.1.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114.1.1.1, i64 8
  %kr.sroa.35.48.copyload1716 = load <4 x half>, ptr addrspace(4) %kr.sroa.35.48.add.ptr114.1.1.1.sroa_idx, align 8
  br label %if.end124.1.1

if.end124.1.1:                                    ; preds = %for.cond98.preheader.1.1, %if.end124.1702
  %kr.sroa.35.2 = phi <4 x half> [ %kr.sroa.35.1, %if.end124.1702 ], [ %kr.sroa.35.48.copyload1716, %for.cond98.preheader.1.1 ]
  %kr.sroa.29.2 = phi <4 x half> [ %kr.sroa.29.1, %if.end124.1702 ], [ %kr.sroa.29.48.copyload1714, %for.cond98.preheader.1.1 ]
  %kr.sroa.26.2 = phi <4 x half> [ %kr.sroa.26.1, %if.end124.1702 ], [ %kr.sroa.26.32.copyload1708, %for.cond98.preheader.1.1 ]
  %kr.sroa.20.2 = phi <4 x half> [ %kr.sroa.20.1, %if.end124.1702 ], [ %kr.sroa.20.32.copyload1706, %for.cond98.preheader.1.1 ]
  %or.cond646.2.1 = icmp ugt i32 %mul11.6, 1023
  %cmp96.not.2.1 = icmp sgt i32 %mul11.6, %1
  %or.cond647.2.1 = or i1 %or.cond646.2.1, %cmp96.not.2.1
  br i1 %or.cond647.2.1, label %if.end124.2.1, label %for.cond98.preheader.2.1

for.cond98.preheader.2.1:                         ; preds = %if.end124.1.1
  %134 = shl nsw i32 %cond.i.i615.6, 10
  %mul105.2.1 = and i32 %134, 64512
  %add106.2.1 = or disjoint i32 %mul105.2.1, %mul103
  %135 = zext nneg i32 %add106.2.1 to i64
  %136 = or disjoint i64 %135, %26
  %add.ptr114.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %136
  %kr.sroa.38.64.copyload1722 = load <4 x half>, ptr addrspace(4) %add.ptr114.2.1, align 16
  %kr.sroa.44.64.add.ptr114.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114.2.1, i64 8
  %kr.sroa.44.64.copyload1724 = load <4 x half>, ptr addrspace(4) %kr.sroa.44.64.add.ptr114.2.1.sroa_idx, align 8
  %137 = or disjoint i64 %135, %26
  %138 = or disjoint i64 %137, 512
  %add.ptr114.1.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %138
  %kr.sroa.47.80.copyload1730 = load <4 x half>, ptr addrspace(4) %add.ptr114.1.2.1, align 16
  %kr.sroa.53.80.add.ptr114.1.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114.1.2.1, i64 8
  %kr.sroa.53.80.copyload1732 = load <4 x half>, ptr addrspace(4) %kr.sroa.53.80.add.ptr114.1.2.1.sroa_idx, align 8
  br label %if.end124.2.1

if.end124.2.1:                                    ; preds = %for.cond98.preheader.2.1, %if.end124.1.1
  %kr.sroa.53.2 = phi <4 x half> [ %kr.sroa.53.1, %if.end124.1.1 ], [ %kr.sroa.53.80.copyload1732, %for.cond98.preheader.2.1 ]
  %kr.sroa.47.2 = phi <4 x half> [ %kr.sroa.47.1, %if.end124.1.1 ], [ %kr.sroa.47.80.copyload1730, %for.cond98.preheader.2.1 ]
  %kr.sroa.44.2 = phi <4 x half> [ %kr.sroa.44.1, %if.end124.1.1 ], [ %kr.sroa.44.64.copyload1724, %for.cond98.preheader.2.1 ]
  %kr.sroa.38.2 = phi <4 x half> [ %kr.sroa.38.1, %if.end124.1.1 ], [ %kr.sroa.38.64.copyload1722, %for.cond98.preheader.2.1 ]
  %or.cond646.3.1 = icmp ugt i32 %mul11.7, 1023
  %cmp96.not.3.1 = icmp sgt i32 %mul11.7, %1
  %or.cond647.3.1 = or i1 %or.cond646.3.1, %cmp96.not.3.1
  br i1 %or.cond647.3.1, label %if.end124.3.1, label %for.cond98.preheader.3.1

for.cond98.preheader.3.1:                         ; preds = %if.end124.2.1
  %139 = shl nsw i32 %cond.i.i615.7, 10
  %mul105.3.1 = and i32 %139, 64512
  %add106.3.1 = or disjoint i32 %mul105.3.1, %mul103
  %140 = zext nneg i32 %add106.3.1 to i64
  %141 = or disjoint i64 %140, %26
  %add.ptr114.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %141
  %kr.sroa.56.96.copyload1738 = load <4 x half>, ptr addrspace(4) %add.ptr114.3.1, align 16
  %kr.sroa.62.96.add.ptr114.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114.3.1, i64 8
  %kr.sroa.62.96.copyload1740 = load <4 x half>, ptr addrspace(4) %kr.sroa.62.96.add.ptr114.3.1.sroa_idx, align 8
  %142 = or disjoint i64 %140, %26
  %143 = or disjoint i64 %142, 512
  %add.ptr114.1.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %143
  %kr.sroa.65.112.copyload1746 = load <4 x half>, ptr addrspace(4) %add.ptr114.1.3.1, align 16
  %kr.sroa.71.112.add.ptr114.1.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114.1.3.1, i64 8
  %kr.sroa.71.112.copyload1748 = load <4 x half>, ptr addrspace(4) %kr.sroa.71.112.add.ptr114.1.3.1.sroa_idx, align 8
  br label %if.end124.3.1

if.end124.3.1:                                    ; preds = %for.cond98.preheader.3.1, %if.end124.2.1
  %kr.sroa.71.2 = phi <4 x half> [ %kr.sroa.71.1, %if.end124.2.1 ], [ %kr.sroa.71.112.copyload1748, %for.cond98.preheader.3.1 ]
  %kr.sroa.65.2 = phi <4 x half> [ %kr.sroa.65.1, %if.end124.2.1 ], [ %kr.sroa.65.112.copyload1746, %for.cond98.preheader.3.1 ]
  %kr.sroa.62.2 = phi <4 x half> [ %kr.sroa.62.1, %if.end124.2.1 ], [ %kr.sroa.62.96.copyload1740, %for.cond98.preheader.3.1 ]
  %kr.sroa.56.2 = phi <4 x half> [ %kr.sroa.56.1, %if.end124.2.1 ], [ %kr.sroa.56.96.copyload1738, %for.cond98.preheader.3.1 ]
  br i1 %or.cond647.1695, label %if.end239.1758, label %if.then142.1708

if.then142.1708:                                  ; preds = %if.end124.3.1
  %cmp145.1707 = icmp sgt i32 %mul11.4, %invariant.op
  br i1 %cmp145.1707, label %for.cond147.preheader.1711, label %if.end173.1728

for.cond147.preheader.1711:                       ; preds = %if.then142.1708
  %add155.1710 = or disjoint i32 %mul11.4, %mul154
  %cmp158.not.1712 = icmp sgt i32 %add155.1710, %1
  %spec.select.1713 = select i1 %cmp158.not.1712, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1078 = insertelement <4 x float> poison, float %spec.select.1713, i64 0
  %cmp158.not.1.1715.not = icmp slt i32 %add155.1710, %1
  %spec.select.1.1716 = select i1 %cmp158.not.1.1715.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1209 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1078, float %spec.select.1.1716, i64 1
  %add156.2.1718 = or disjoint i32 %add155.1710, 2
  %cmp158.not.2.1719 = icmp sgt i32 %add156.2.1718, %1
  %spec.select.2.1720 = select i1 %cmp158.not.2.1719, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1326 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1209, float %spec.select.2.1720, i64 2
  %add156.3.1722 = or disjoint i32 %add155.1710, 3
  %cmp158.not.3.1723 = icmp sgt i32 %add156.3.1722, %1
  %spec.select.3.1724 = select i1 %cmp158.not.3.1723, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1443 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1326, float %spec.select.3.1724, i64 3
  br label %if.end173.1728

if.end173.1728:                                   ; preds = %if.then142.1708, %for.cond147.preheader.1711
  %scores.sroa.0.9 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1443, %for.cond147.preheader.1711 ], [ zeroinitializer, %if.then142.1708 ]
  %144 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.2, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.9)
  %145 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.8.2, <4 x half> %qr.sroa.15.0, <4 x float> %144)
  %146 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.11.2, <4 x half> %qr.sroa.27.0, <4 x float> %145)
  %147 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.17.2, <4 x half> %qr.sroa.40.0, <4 x float> %146)
  %scores.sroa.0.0.vec.extract1080 = extractelement <4 x float> %147, i64 0
  %mul199.1733 = fmul contract float %scores.sroa.0.0.vec.extract1080, 0x3FB99999A0000000
  %148 = tail call contract noundef float @llvm.minnum.f32(float %mul199.1733, float 0x4024CB5EC0000000)
  %149 = tail call contract noundef float @llvm.exp.f32(float %148)
  %scores.sroa.0.4.vec.extract1211 = extractelement <4 x float> %147, i64 1
  %mul199.1.1735 = fmul contract float %scores.sroa.0.4.vec.extract1211, 0x3FB99999A0000000
  %150 = tail call contract noundef float @llvm.minnum.f32(float %mul199.1.1735, float 0x4024CB5EC0000000)
  %151 = tail call contract noundef float @llvm.exp.f32(float %150)
  %scores.sroa.0.8.vec.extract1328 = extractelement <4 x float> %147, i64 2
  %mul199.2.1737 = fmul contract float %scores.sroa.0.8.vec.extract1328, 0x3FB99999A0000000
  %152 = tail call contract noundef float @llvm.minnum.f32(float %mul199.2.1737, float 0x4024CB5EC0000000)
  %153 = tail call contract noundef float @llvm.exp.f32(float %152)
  %scores.sroa.0.12.vec.extract1445 = extractelement <4 x float> %147, i64 3
  %mul199.3.1739 = fmul contract float %scores.sroa.0.12.vec.extract1445, 0x3FB99999A0000000
  %154 = tail call contract noundef float @llvm.minnum.f32(float %mul199.3.1739, float 0x4024CB5EC0000000)
  %155 = tail call contract noundef float @llvm.exp.f32(float %154)
  %add215.1741 = fadd contract float %sums.sroa.0.5, %149
  %156 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %149)
  %probs.sroa.0.0.vec.insert1560 = insertelement <4 x i16> poison, i16 %156, i64 0
  %add215.1.1744 = fadd contract float %sums.sroa.28.5, %151
  %157 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %151)
  %probs.sroa.0.2.vec.insert1606 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1560, i16 %157, i64 1
  %add215.2.1748 = fadd contract float %sums.sroa.54.5, %153
  %158 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %153)
  %probs.sroa.0.4.vec.insert1651 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1606, i16 %158, i64 2
  %add215.3.1752 = fadd contract float %sums.sroa.80.5, %155
  %159 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %155)
  %probs.sroa.0.6.vec.insert1673 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1651, i16 %159, i64 3
  br label %if.end239.1758

if.end239.1758:                                   ; preds = %if.end124.3.1, %if.end173.1728
  %sums.sroa.80.6 = phi float [ %add215.3.1752, %if.end173.1728 ], [ %sums.sroa.80.5, %if.end124.3.1 ]
  %sums.sroa.54.6 = phi float [ %add215.2.1748, %if.end173.1728 ], [ %sums.sroa.54.5, %if.end124.3.1 ]
  %sums.sroa.28.6 = phi float [ %add215.1.1744, %if.end173.1728 ], [ %sums.sroa.28.5, %if.end124.3.1 ]
  %sums.sroa.0.6 = phi float [ %add215.1741, %if.end173.1728 ], [ %sums.sroa.0.5, %if.end124.3.1 ]
  %probs.sroa.0.10 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1673, %if.end173.1728 ], [ zeroinitializer, %if.end124.3.1 ]
  %add248.1756 = or disjoint i32 %and246, 1024
  %add.ptr250.1757 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add248.1756
  store <4 x i16> %probs.sroa.0.10, ptr addrspace(3) %add.ptr250.1757, align 8
  br i1 %or.cond647.1.1, label %if.end239.1.1, label %if.then142.1.1

if.then142.1.1:                                   ; preds = %if.end239.1758
  %cmp145.1.1 = icmp sgt i32 %mul11.5, %invariant.op
  br i1 %cmp145.1.1, label %for.cond147.preheader.1.1, label %if.end173.1.1

for.cond147.preheader.1.1:                        ; preds = %if.then142.1.1
  %add155.1.1 = or disjoint i32 %mul11.5, %mul154
  %cmp158.not.1668.1 = icmp sgt i32 %add155.1.1, %1
  %spec.select.1669.1 = select i1 %cmp158.not.1668.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1088 = insertelement <4 x float> poison, float %spec.select.1669.1, i64 0
  %cmp158.not.1.1.1.not = icmp slt i32 %add155.1.1, %1
  %spec.select.1.1.1 = select i1 %cmp158.not.1.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1217 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1088, float %spec.select.1.1.1, i64 1
  %add156.2.1.1 = or disjoint i32 %add155.1.1, 2
  %cmp158.not.2.1.1 = icmp sgt i32 %add156.2.1.1, %1
  %spec.select.2.1.1 = select i1 %cmp158.not.2.1.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1334 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1217, float %spec.select.2.1.1, i64 2
  %add156.3.1.1 = or disjoint i32 %add155.1.1, 3
  %cmp158.not.3.1.1 = icmp sgt i32 %add156.3.1.1, %1
  %spec.select.3.1.1 = select i1 %cmp158.not.3.1.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1451 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1334, float %spec.select.3.1.1, i64 3
  br label %if.end173.1.1

if.end173.1.1:                                    ; preds = %if.then142.1.1, %for.cond147.preheader.1.1
  %scores.sroa.0.11 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1451, %for.cond147.preheader.1.1 ], [ zeroinitializer, %if.then142.1.1 ]
  %160 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.20.2, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.11)
  %161 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.26.2, <4 x half> %qr.sroa.15.0, <4 x float> %160)
  %162 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.29.2, <4 x half> %qr.sroa.27.0, <4 x float> %161)
  %163 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.35.2, <4 x half> %qr.sroa.40.0, <4 x float> %162)
  %scores.sroa.0.0.vec.extract1090 = extractelement <4 x float> %163, i64 0
  %mul199.1672.1 = fmul contract float %scores.sroa.0.0.vec.extract1090, 0x3FB99999A0000000
  %164 = tail call contract noundef float @llvm.minnum.f32(float %mul199.1672.1, float 0x4024CB5EC0000000)
  %165 = tail call contract noundef float @llvm.exp.f32(float %164)
  %scores.sroa.0.4.vec.extract1219 = extractelement <4 x float> %163, i64 1
  %mul199.1.1.1 = fmul contract float %scores.sroa.0.4.vec.extract1219, 0x3FB99999A0000000
  %166 = tail call contract noundef float @llvm.minnum.f32(float %mul199.1.1.1, float 0x4024CB5EC0000000)
  %167 = tail call contract noundef float @llvm.exp.f32(float %166)
  %scores.sroa.0.8.vec.extract1336 = extractelement <4 x float> %163, i64 2
  %mul199.2.1.1 = fmul contract float %scores.sroa.0.8.vec.extract1336, 0x3FB99999A0000000
  %168 = tail call contract noundef float @llvm.minnum.f32(float %mul199.2.1.1, float 0x4024CB5EC0000000)
  %169 = tail call contract noundef float @llvm.exp.f32(float %168)
  %scores.sroa.0.12.vec.extract1453 = extractelement <4 x float> %163, i64 3
  %mul199.3.1.1 = fmul contract float %scores.sroa.0.12.vec.extract1453, 0x3FB99999A0000000
  %170 = tail call contract noundef float @llvm.minnum.f32(float %mul199.3.1.1, float 0x4024CB5EC0000000)
  %171 = tail call contract noundef float @llvm.exp.f32(float %170)
  %add215.1673.1 = fadd contract float %sums.sroa.0.6, %165
  %172 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %165)
  %probs.sroa.0.0.vec.insert1562 = insertelement <4 x i16> poison, i16 %172, i64 0
  %add215.1.1.1 = fadd contract float %sums.sroa.28.6, %167
  %173 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %167)
  %probs.sroa.0.2.vec.insert1608 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1562, i16 %173, i64 1
  %add215.2.1.1 = fadd contract float %sums.sroa.54.6, %169
  %174 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %169)
  %probs.sroa.0.4.vec.insert1653 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1608, i16 %174, i64 2
  %add215.3.1.1 = fadd contract float %sums.sroa.80.6, %171
  %175 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %171)
  %probs.sroa.0.6.vec.insert1675 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1653, i16 %175, i64 3
  br label %if.end239.1.1

if.end239.1.1:                                    ; preds = %if.end239.1758, %if.end173.1.1
  %sums.sroa.80.7 = phi float [ %add215.3.1.1, %if.end173.1.1 ], [ %sums.sroa.80.6, %if.end239.1758 ]
  %sums.sroa.54.7 = phi float [ %add215.2.1.1, %if.end173.1.1 ], [ %sums.sroa.54.6, %if.end239.1758 ]
  %sums.sroa.28.7 = phi float [ %add215.1.1.1, %if.end173.1.1 ], [ %sums.sroa.28.6, %if.end239.1758 ]
  %sums.sroa.0.7 = phi float [ %add215.1673.1, %if.end173.1.1 ], [ %sums.sroa.0.6, %if.end239.1758 ]
  %probs.sroa.0.11 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1675, %if.end173.1.1 ], [ zeroinitializer, %if.end239.1758 ]
  %add248.1.1 = or disjoint i32 %and246, 1280
  %add.ptr250.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add248.1.1
  store <4 x i16> %probs.sroa.0.11, ptr addrspace(3) %add.ptr250.1.1, align 8
  br i1 %or.cond647.2.1, label %if.end239.2.1, label %if.then142.2.1

if.then142.2.1:                                   ; preds = %if.end239.1.1
  %cmp145.2.1 = icmp sgt i32 %mul11.6, %invariant.op
  br i1 %cmp145.2.1, label %for.cond147.preheader.2.1, label %if.end173.2.1

for.cond147.preheader.2.1:                        ; preds = %if.then142.2.1
  %add155.2.1 = or disjoint i32 %mul11.6, %mul154
  %cmp158.not.2674.1 = icmp sgt i32 %add155.2.1, %1
  %spec.select.2675.1 = select i1 %cmp158.not.2674.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1098 = insertelement <4 x float> poison, float %spec.select.2675.1, i64 0
  %cmp158.not.1.2.1.not = icmp slt i32 %add155.2.1, %1
  %spec.select.1.2.1 = select i1 %cmp158.not.1.2.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1225 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1098, float %spec.select.1.2.1, i64 1
  %add156.2.2.1 = or disjoint i32 %add155.2.1, 2
  %cmp158.not.2.2.1 = icmp sgt i32 %add156.2.2.1, %1
  %spec.select.2.2.1 = select i1 %cmp158.not.2.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1342 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1225, float %spec.select.2.2.1, i64 2
  %add156.3.2.1 = or disjoint i32 %add155.2.1, 3
  %cmp158.not.3.2.1 = icmp sgt i32 %add156.3.2.1, %1
  %spec.select.3.2.1 = select i1 %cmp158.not.3.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1459 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1342, float %spec.select.3.2.1, i64 3
  br label %if.end173.2.1

if.end173.2.1:                                    ; preds = %if.then142.2.1, %for.cond147.preheader.2.1
  %scores.sroa.0.13 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1459, %for.cond147.preheader.2.1 ], [ zeroinitializer, %if.then142.2.1 ]
  %176 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.38.2, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.13)
  %177 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.44.2, <4 x half> %qr.sroa.15.0, <4 x float> %176)
  %178 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.2, <4 x half> %qr.sroa.27.0, <4 x float> %177)
  %179 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.53.2, <4 x half> %qr.sroa.40.0, <4 x float> %178)
  %scores.sroa.0.0.vec.extract1100 = extractelement <4 x float> %179, i64 0
  %mul199.2678.1 = fmul contract float %scores.sroa.0.0.vec.extract1100, 0x3FB99999A0000000
  %180 = tail call contract noundef float @llvm.minnum.f32(float %mul199.2678.1, float 0x4024CB5EC0000000)
  %181 = tail call contract noundef float @llvm.exp.f32(float %180)
  %scores.sroa.0.4.vec.extract1227 = extractelement <4 x float> %179, i64 1
  %mul199.1.2.1 = fmul contract float %scores.sroa.0.4.vec.extract1227, 0x3FB99999A0000000
  %182 = tail call contract noundef float @llvm.minnum.f32(float %mul199.1.2.1, float 0x4024CB5EC0000000)
  %183 = tail call contract noundef float @llvm.exp.f32(float %182)
  %scores.sroa.0.8.vec.extract1344 = extractelement <4 x float> %179, i64 2
  %mul199.2.2.1 = fmul contract float %scores.sroa.0.8.vec.extract1344, 0x3FB99999A0000000
  %184 = tail call contract noundef float @llvm.minnum.f32(float %mul199.2.2.1, float 0x4024CB5EC0000000)
  %185 = tail call contract noundef float @llvm.exp.f32(float %184)
  %scores.sroa.0.12.vec.extract1461 = extractelement <4 x float> %179, i64 3
  %mul199.3.2.1 = fmul contract float %scores.sroa.0.12.vec.extract1461, 0x3FB99999A0000000
  %186 = tail call contract noundef float @llvm.minnum.f32(float %mul199.3.2.1, float 0x4024CB5EC0000000)
  %187 = tail call contract noundef float @llvm.exp.f32(float %186)
  %add215.2679.1 = fadd contract float %sums.sroa.0.7, %181
  %188 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %181)
  %probs.sroa.0.0.vec.insert1564 = insertelement <4 x i16> poison, i16 %188, i64 0
  %add215.1.2.1 = fadd contract float %sums.sroa.28.7, %183
  %189 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %183)
  %probs.sroa.0.2.vec.insert1610 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1564, i16 %189, i64 1
  %add215.2.2.1 = fadd contract float %sums.sroa.54.7, %185
  %190 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %185)
  %probs.sroa.0.4.vec.insert1655 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1610, i16 %190, i64 2
  %add215.3.2.1 = fadd contract float %sums.sroa.80.7, %187
  %191 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %187)
  %probs.sroa.0.6.vec.insert1677 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1655, i16 %191, i64 3
  br label %if.end239.2.1

if.end239.2.1:                                    ; preds = %if.end239.1.1, %if.end173.2.1
  %sums.sroa.80.8 = phi float [ %add215.3.2.1, %if.end173.2.1 ], [ %sums.sroa.80.7, %if.end239.1.1 ]
  %sums.sroa.54.8 = phi float [ %add215.2.2.1, %if.end173.2.1 ], [ %sums.sroa.54.7, %if.end239.1.1 ]
  %sums.sroa.28.8 = phi float [ %add215.1.2.1, %if.end173.2.1 ], [ %sums.sroa.28.7, %if.end239.1.1 ]
  %sums.sroa.0.8 = phi float [ %add215.2679.1, %if.end173.2.1 ], [ %sums.sroa.0.7, %if.end239.1.1 ]
  %probs.sroa.0.12 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1677, %if.end173.2.1 ], [ zeroinitializer, %if.end239.1.1 ]
  %add248.2.1 = or disjoint i32 %and246, 1536
  %add.ptr250.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add248.2.1
  store <4 x i16> %probs.sroa.0.12, ptr addrspace(3) %add.ptr250.2.1, align 8
  br i1 %or.cond647.3.1, label %if.end239.3.1, label %if.then142.3.1

if.then142.3.1:                                   ; preds = %if.end239.2.1
  %cmp145.3.1 = icmp sgt i32 %mul11.7, %invariant.op
  br i1 %cmp145.3.1, label %for.cond147.preheader.3.1, label %if.end173.3.1

for.cond147.preheader.3.1:                        ; preds = %if.then142.3.1
  %add155.3.1 = or disjoint i32 %mul11.7, %mul154
  %cmp158.not.3680.1 = icmp sgt i32 %add155.3.1, %1
  %spec.select.3681.1 = select i1 %cmp158.not.3680.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1108 = insertelement <4 x float> poison, float %spec.select.3681.1, i64 0
  %cmp158.not.1.3.1.not = icmp slt i32 %add155.3.1, %1
  %spec.select.1.3.1 = select i1 %cmp158.not.1.3.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1233 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1108, float %spec.select.1.3.1, i64 1
  %add156.2.3.1 = or disjoint i32 %add155.3.1, 2
  %cmp158.not.2.3.1 = icmp sgt i32 %add156.2.3.1, %1
  %spec.select.2.3.1 = select i1 %cmp158.not.2.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1350 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1233, float %spec.select.2.3.1, i64 2
  %add156.3.3.1 = or disjoint i32 %add155.3.1, 3
  %cmp158.not.3.3.1 = icmp sgt i32 %add156.3.3.1, %1
  %spec.select.3.3.1 = select i1 %cmp158.not.3.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1467 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1350, float %spec.select.3.3.1, i64 3
  br label %if.end173.3.1

if.end173.3.1:                                    ; preds = %if.then142.3.1, %for.cond147.preheader.3.1
  %scores.sroa.0.15 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1467, %for.cond147.preheader.3.1 ], [ zeroinitializer, %if.then142.3.1 ]
  %192 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.56.2, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.15)
  %193 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.62.2, <4 x half> %qr.sroa.15.0, <4 x float> %192)
  %194 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.65.2, <4 x half> %qr.sroa.27.0, <4 x float> %193)
  %195 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.71.2, <4 x half> %qr.sroa.40.0, <4 x float> %194)
  %scores.sroa.0.0.vec.extract1110 = extractelement <4 x float> %195, i64 0
  %mul199.3684.1 = fmul contract float %scores.sroa.0.0.vec.extract1110, 0x3FB99999A0000000
  %196 = tail call contract noundef float @llvm.minnum.f32(float %mul199.3684.1, float 0x4024CB5EC0000000)
  %197 = tail call contract noundef float @llvm.exp.f32(float %196)
  %scores.sroa.0.4.vec.extract1235 = extractelement <4 x float> %195, i64 1
  %mul199.1.3.1 = fmul contract float %scores.sroa.0.4.vec.extract1235, 0x3FB99999A0000000
  %198 = tail call contract noundef float @llvm.minnum.f32(float %mul199.1.3.1, float 0x4024CB5EC0000000)
  %199 = tail call contract noundef float @llvm.exp.f32(float %198)
  %scores.sroa.0.8.vec.extract1352 = extractelement <4 x float> %195, i64 2
  %mul199.2.3.1 = fmul contract float %scores.sroa.0.8.vec.extract1352, 0x3FB99999A0000000
  %200 = tail call contract noundef float @llvm.minnum.f32(float %mul199.2.3.1, float 0x4024CB5EC0000000)
  %201 = tail call contract noundef float @llvm.exp.f32(float %200)
  %scores.sroa.0.12.vec.extract1469 = extractelement <4 x float> %195, i64 3
  %mul199.3.3.1 = fmul contract float %scores.sroa.0.12.vec.extract1469, 0x3FB99999A0000000
  %202 = tail call contract noundef float @llvm.minnum.f32(float %mul199.3.3.1, float 0x4024CB5EC0000000)
  %203 = tail call contract noundef float @llvm.exp.f32(float %202)
  %add215.3685.1 = fadd contract float %sums.sroa.0.8, %197
  %204 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %197)
  %probs.sroa.0.0.vec.insert1566 = insertelement <4 x i16> poison, i16 %204, i64 0
  %add215.1.3.1 = fadd contract float %sums.sroa.28.8, %199
  %205 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %199)
  %probs.sroa.0.2.vec.insert1612 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1566, i16 %205, i64 1
  %add215.2.3.1 = fadd contract float %sums.sroa.54.8, %201
  %206 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %201)
  %probs.sroa.0.4.vec.insert1657 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1612, i16 %206, i64 2
  %add215.3.3.1 = fadd contract float %sums.sroa.80.8, %203
  %207 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %203)
  %probs.sroa.0.6.vec.insert1679 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1657, i16 %207, i64 3
  br label %if.end239.3.1

if.end239.3.1:                                    ; preds = %if.end239.2.1, %if.end173.3.1
  %sums.sroa.80.9 = phi float [ %add215.3.3.1, %if.end173.3.1 ], [ %sums.sroa.80.8, %if.end239.2.1 ]
  %sums.sroa.54.9 = phi float [ %add215.2.3.1, %if.end173.3.1 ], [ %sums.sroa.54.8, %if.end239.2.1 ]
  %sums.sroa.28.9 = phi float [ %add215.1.3.1, %if.end173.3.1 ], [ %sums.sroa.28.8, %if.end239.2.1 ]
  %sums.sroa.0.9 = phi float [ %add215.3685.1, %if.end173.3.1 ], [ %sums.sroa.0.8, %if.end239.2.1 ]
  %probs.sroa.0.13 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1679, %if.end173.3.1 ], [ zeroinitializer, %if.end239.2.1 ]
  %add248.3.1 = or disjoint i32 %and246, 1792
  %add.ptr250.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add248.3.1
  store <4 x i16> %probs.sroa.0.13, ptr addrspace(3) %add.ptr250.3.1, align 8
  br label %if.end254.1

if.end254.1:                                      ; preds = %if.end239.3.1, %if.end356
  %sums.sroa.80.10 = phi float [ %sums.sroa.80.5, %if.end356 ], [ %sums.sroa.80.9, %if.end239.3.1 ]
  %sums.sroa.54.10 = phi float [ %sums.sroa.54.5, %if.end356 ], [ %sums.sroa.54.9, %if.end239.3.1 ]
  %sums.sroa.28.10 = phi float [ %sums.sroa.28.5, %if.end356 ], [ %sums.sroa.28.9, %if.end239.3.1 ]
  %sums.sroa.0.10 = phi float [ %sums.sroa.0.5, %if.end356 ], [ %sums.sroa.0.9, %if.end239.3.1 ]
  br i1 %cmp257.not, label %for.cond261.preheader.1, label %if.end356.1

for.cond261.preheader.1:                          ; preds = %if.end254.1
  %or.cond650.1760 = icmp ugt i32 %mul11, 1023
  %cmp274.not.1761 = icmp sgt i32 %mul11, %1
  %or.cond651.1762 = or i1 %or.cond650.1760, %cmp274.not.1761
  br i1 %or.cond651.1762, label %if.end352.1788, label %for.cond314.preheader.1780

for.cond314.preheader.1780:                       ; preds = %for.cond261.preheader.1
  %gep.1770 = getelementptr %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul305
  %208 = load <4 x half>, ptr addrspace(3) %gep.1770, align 8
  %209 = shl nsw i32 %cond.i.i615, 10
  %mul283.1763 = and i32 %209, 64512
  %add284.1764 = or disjoint i32 %mul283.1763, %mul103
  %210 = zext nneg i32 %add284.1764 to i64
  %211 = or disjoint i64 %210, %27
  %212 = or disjoint i64 %211, 512
  %add.ptr292.1.1767 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %212
  %vr.sroa.98.16.add.ptr292.1.1767.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr292.1.1767, i64 8
  %vr.sroa.98.16.copyload995 = load <4 x half>, ptr addrspace(4) %vr.sroa.98.16.add.ptr292.1.1767.sroa_idx, align 8
  %vr.sroa.62.16.copyload984 = load <4 x half>, ptr addrspace(4) %add.ptr292.1.1767, align 16
  %213 = or disjoint i64 %210, %27
  %add.ptr292.1766 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %213
  %vr.sroa.38.0.add.ptr292.1766.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr292.1766, i64 8
  %vr.sroa.38.0.copyload927 = load <4 x half>, ptr addrspace(4) %vr.sroa.38.0.add.ptr292.1766.sroa_idx, align 8
  %vr.sroa.0.0.copyload916 = load <4 x half>, ptr addrspace(4) %add.ptr292.1766, align 16
  %214 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload916, <4 x half> %208, <4 x float> zeroinitializer), !call_argsrelate !163
  %215 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.38.0.copyload927, <4 x half> %208, <4 x float> zeroinitializer), !call_argsrelate !163
  %216 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.62.16.copyload984, <4 x half> %208, <4 x float> zeroinitializer), !call_argsrelate !163
  %217 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.98.16.copyload995, <4 x half> %208, <4 x float> zeroinitializer), !call_argsrelate !163
  br label %if.end352.1788

if.end352.1788:                                   ; preds = %for.cond314.preheader.1780, %for.cond261.preheader.1
  %out.sroa.110.6 = phi <4 x float> [ zeroinitializer, %for.cond261.preheader.1 ], [ %217, %for.cond314.preheader.1780 ]
  %out.sroa.74.6 = phi <4 x float> [ zeroinitializer, %for.cond261.preheader.1 ], [ %216, %for.cond314.preheader.1780 ]
  %out.sroa.38.6 = phi <4 x float> [ zeroinitializer, %for.cond261.preheader.1 ], [ %215, %for.cond314.preheader.1780 ]
  %out.sroa.0.6 = phi <4 x float> [ zeroinitializer, %for.cond261.preheader.1 ], [ %214, %for.cond314.preheader.1780 ]
  %or.cond650.1.1 = icmp ugt i32 %mul11.1, 1023
  %cmp274.not.1.1 = icmp sgt i32 %mul11.1, %1
  %or.cond651.1.1 = or i1 %or.cond650.1.1, %cmp274.not.1.1
  br i1 %or.cond651.1.1, label %if.end352.1.1, label %for.cond333.preheader.1.1

for.cond333.preheader.1.1:                        ; preds = %if.end352.1788
  %add306.1.1 = or i32 %and246, 1280
  %gep.1.1 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add306.1.1
  %218 = load <4 x half>, ptr addrspace(3) %gep.1.1, align 8
  %219 = shl nsw i32 %cond.i.i615.1, 10
  %mul283.1.1 = and i32 %219, 64512
  %add284.1.1 = or disjoint i32 %mul283.1.1, %mul103
  %220 = zext nneg i32 %add284.1.1 to i64
  %221 = or disjoint i64 %220, %27
  %222 = or disjoint i64 %221, 512
  %add.ptr292.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %222
  %vr.sroa.98.16.add.ptr292.1.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr292.1.1.1, i64 8
  %vr.sroa.98.16.copyload996 = load <4 x half>, ptr addrspace(4) %vr.sroa.98.16.add.ptr292.1.1.1.sroa_idx, align 8
  %vr.sroa.62.16.copyload985 = load <4 x half>, ptr addrspace(4) %add.ptr292.1.1.1, align 16
  %223 = or disjoint i64 %220, %27
  %add.ptr292.1691.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %223
  %vr.sroa.38.0.add.ptr292.1691.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr292.1691.1, i64 8
  %vr.sroa.38.0.copyload928 = load <4 x half>, ptr addrspace(4) %vr.sroa.38.0.add.ptr292.1691.1.sroa_idx, align 8
  %vr.sroa.0.0.copyload917 = load <4 x half>, ptr addrspace(4) %add.ptr292.1691.1, align 16
  %224 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload917, <4 x half> %218, <4 x float> zeroinitializer), !call_argsrelate !163
  %225 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.38.0.copyload928, <4 x half> %218, <4 x float> zeroinitializer), !call_argsrelate !163
  %226 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.62.16.copyload985, <4 x half> %218, <4 x float> zeroinitializer), !call_argsrelate !163
  %227 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.98.16.copyload996, <4 x half> %218, <4 x float> zeroinitializer), !call_argsrelate !163
  br label %if.end352.1.1

if.end352.1.1:                                    ; preds = %for.cond333.preheader.1.1, %if.end352.1788
  %out_1.sroa.98.7 = phi <4 x float> [ zeroinitializer, %if.end352.1788 ], [ %227, %for.cond333.preheader.1.1 ]
  %out_1.sroa.66.7 = phi <4 x float> [ zeroinitializer, %if.end352.1788 ], [ %226, %for.cond333.preheader.1.1 ]
  %out_1.sroa.34.7 = phi <4 x float> [ zeroinitializer, %if.end352.1788 ], [ %225, %for.cond333.preheader.1.1 ]
  %out_1.sroa.0.7 = phi <4 x float> [ zeroinitializer, %if.end352.1788 ], [ %224, %for.cond333.preheader.1.1 ]
  %or.cond650.2.1 = icmp ugt i32 %mul11.2, 1023
  %cmp274.not.2.1 = icmp sgt i32 %mul11.2, %1
  %or.cond651.2.1 = or i1 %or.cond650.2.1, %cmp274.not.2.1
  br i1 %or.cond651.2.1, label %if.end352.2.1, label %for.cond314.preheader.2.1

for.cond314.preheader.2.1:                        ; preds = %if.end352.1.1
  %add306.2.1 = or disjoint i32 %mul305, 1536
  %gep.2.1 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add306.2.1
  %228 = load <4 x half>, ptr addrspace(3) %gep.2.1, align 8
  %229 = shl nsw i32 %cond.i.i615.2, 10
  %mul283.2.1 = and i32 %229, 64512
  %add284.2.1 = or disjoint i32 %mul283.2.1, %mul103
  %230 = zext nneg i32 %add284.2.1 to i64
  %231 = or disjoint i64 %230, %27
  %232 = or disjoint i64 %231, 512
  %add.ptr292.1.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %232
  %vr.sroa.98.16.add.ptr292.1.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr292.1.2.1, i64 8
  %vr.sroa.98.16.copyload997 = load <4 x half>, ptr addrspace(4) %vr.sroa.98.16.add.ptr292.1.2.1.sroa_idx, align 8
  %vr.sroa.62.16.copyload986 = load <4 x half>, ptr addrspace(4) %add.ptr292.1.2.1, align 16
  %233 = or disjoint i64 %230, %27
  %add.ptr292.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %233
  %vr.sroa.38.0.add.ptr292.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr292.2.1, i64 8
  %vr.sroa.38.0.copyload929 = load <4 x half>, ptr addrspace(4) %vr.sroa.38.0.add.ptr292.2.1.sroa_idx, align 8
  %vr.sroa.0.0.copyload918 = load <4 x half>, ptr addrspace(4) %add.ptr292.2.1, align 16
  %234 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload918, <4 x half> %228, <4 x float> %out.sroa.0.6), !call_argsrelate !163
  %235 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.38.0.copyload929, <4 x half> %228, <4 x float> %out.sroa.38.6), !call_argsrelate !163
  %236 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.62.16.copyload986, <4 x half> %228, <4 x float> %out.sroa.74.6), !call_argsrelate !163
  %237 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.98.16.copyload997, <4 x half> %228, <4 x float> %out.sroa.110.6), !call_argsrelate !163
  br label %if.end352.2.1

if.end352.2.1:                                    ; preds = %for.cond314.preheader.2.1, %if.end352.1.1
  %out.sroa.110.8 = phi <4 x float> [ %out.sroa.110.6, %if.end352.1.1 ], [ %237, %for.cond314.preheader.2.1 ]
  %out.sroa.74.8 = phi <4 x float> [ %out.sroa.74.6, %if.end352.1.1 ], [ %236, %for.cond314.preheader.2.1 ]
  %out.sroa.38.8 = phi <4 x float> [ %out.sroa.38.6, %if.end352.1.1 ], [ %235, %for.cond314.preheader.2.1 ]
  %out.sroa.0.8 = phi <4 x float> [ %out.sroa.0.6, %if.end352.1.1 ], [ %234, %for.cond314.preheader.2.1 ]
  %or.cond650.3.1 = icmp ugt i32 %mul11.3, 1023
  %cmp274.not.3.1 = icmp sgt i32 %mul11.3, %1
  %or.cond651.3.1 = or i1 %or.cond650.3.1, %cmp274.not.3.1
  br i1 %or.cond651.3.1, label %if.end356.1, label %for.cond333.preheader.3.1

for.cond333.preheader.3.1:                        ; preds = %if.end352.2.1
  %add306.3.1 = or i32 %and246, 1792
  %gep.3.1 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add306.3.1
  %238 = load <4 x half>, ptr addrspace(3) %gep.3.1, align 8
  %239 = shl nsw i32 %cond.i.i615.3, 10
  %mul283.3.1 = and i32 %239, 64512
  %add284.3.1 = or disjoint i32 %mul283.3.1, %mul103
  %240 = zext nneg i32 %add284.3.1 to i64
  %241 = or disjoint i64 %240, %27
  %242 = or disjoint i64 %241, 512
  %add.ptr292.1.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %242
  %vr.sroa.98.16.add.ptr292.1.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr292.1.3.1, i64 8
  %vr.sroa.98.16.copyload998 = load <4 x half>, ptr addrspace(4) %vr.sroa.98.16.add.ptr292.1.3.1.sroa_idx, align 8
  %vr.sroa.62.16.copyload987 = load <4 x half>, ptr addrspace(4) %add.ptr292.1.3.1, align 16
  %243 = or disjoint i64 %240, %27
  %add.ptr292.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %243
  %vr.sroa.38.0.add.ptr292.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr292.3.1, i64 8
  %vr.sroa.38.0.copyload930 = load <4 x half>, ptr addrspace(4) %vr.sroa.38.0.add.ptr292.3.1.sroa_idx, align 8
  %vr.sroa.0.0.copyload919 = load <4 x half>, ptr addrspace(4) %add.ptr292.3.1, align 16
  %244 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload919, <4 x half> %238, <4 x float> %out_1.sroa.0.7), !call_argsrelate !163
  %245 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.38.0.copyload930, <4 x half> %238, <4 x float> %out_1.sroa.34.7), !call_argsrelate !163
  %246 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.62.16.copyload987, <4 x half> %238, <4 x float> %out_1.sroa.66.7), !call_argsrelate !163
  %247 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.98.16.copyload998, <4 x half> %238, <4 x float> %out_1.sroa.98.7), !call_argsrelate !163
  br label %if.end356.1

if.end356.1:                                      ; preds = %if.end352.2.1, %for.cond333.preheader.3.1, %if.end254.1
  %out.sroa.110.10 = phi <4 x float> [ zeroinitializer, %if.end254.1 ], [ %out.sroa.110.8, %for.cond333.preheader.3.1 ], [ %out.sroa.110.8, %if.end352.2.1 ]
  %out.sroa.74.10 = phi <4 x float> [ zeroinitializer, %if.end254.1 ], [ %out.sroa.74.8, %for.cond333.preheader.3.1 ], [ %out.sroa.74.8, %if.end352.2.1 ]
  %out.sroa.38.10 = phi <4 x float> [ zeroinitializer, %if.end254.1 ], [ %out.sroa.38.8, %for.cond333.preheader.3.1 ], [ %out.sroa.38.8, %if.end352.2.1 ]
  %out.sroa.0.10 = phi <4 x float> [ zeroinitializer, %if.end254.1 ], [ %out.sroa.0.8, %for.cond333.preheader.3.1 ], [ %out.sroa.0.8, %if.end352.2.1 ]
  %out_1.sroa.98.10 = phi <4 x float> [ zeroinitializer, %if.end254.1 ], [ %247, %for.cond333.preheader.3.1 ], [ %out_1.sroa.98.7, %if.end352.2.1 ]
  %out_1.sroa.66.10 = phi <4 x float> [ zeroinitializer, %if.end254.1 ], [ %246, %for.cond333.preheader.3.1 ], [ %out_1.sroa.66.7, %if.end352.2.1 ]
  %out_1.sroa.34.10 = phi <4 x float> [ zeroinitializer, %if.end254.1 ], [ %245, %for.cond333.preheader.3.1 ], [ %out_1.sroa.34.7, %if.end352.2.1 ]
  %out_1.sroa.0.10 = phi <4 x float> [ zeroinitializer, %if.end254.1 ], [ %244, %for.cond333.preheader.3.1 ], [ %out_1.sroa.0.7, %if.end352.2.1 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br label %if.end254.2

if.end254.2:                                      ; preds = %if.end356.1
  br i1 %cmp257.not, label %for.cond261.preheader.2, label %if.end356.2

for.cond261.preheader.2:                          ; preds = %if.end254.2
  %or.cond650.2857 = icmp ugt i32 %mul11.4, 1023
  %cmp274.not.2858 = icmp sgt i32 %mul11.4, %1
  %or.cond651.2859 = or i1 %or.cond650.2857, %cmp274.not.2858
  br i1 %or.cond651.2859, label %if.end352.2885, label %for.cond314.preheader.2877

for.cond314.preheader.2877:                       ; preds = %for.cond261.preheader.2
  %add306.2866 = or disjoint i32 %mul305, 2048
  %gep.2867 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add306.2866
  %248 = load <4 x half>, ptr addrspace(3) %gep.2867, align 8
  %249 = shl nsw i32 %cond.i.i615.4, 10
  %mul283.2860 = and i32 %249, 64512
  %add284.2861 = or disjoint i32 %mul283.2860, %mul103
  %250 = zext nneg i32 %add284.2861 to i64
  %251 = or disjoint i64 %250, %27
  %252 = or disjoint i64 %251, 512
  %add.ptr292.1.2864 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %252
  %vr.sroa.98.16.add.ptr292.1.2864.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr292.1.2864, i64 8
  %vr.sroa.98.16.copyload999 = load <4 x half>, ptr addrspace(4) %vr.sroa.98.16.add.ptr292.1.2864.sroa_idx, align 8
  %vr.sroa.62.16.copyload988 = load <4 x half>, ptr addrspace(4) %add.ptr292.1.2864, align 16
  %253 = or disjoint i64 %250, %27
  %add.ptr292.2863 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %253
  %vr.sroa.38.0.add.ptr292.2863.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr292.2863, i64 8
  %vr.sroa.38.0.copyload931 = load <4 x half>, ptr addrspace(4) %vr.sroa.38.0.add.ptr292.2863.sroa_idx, align 8
  %vr.sroa.0.0.copyload920 = load <4 x half>, ptr addrspace(4) %add.ptr292.2863, align 16
  %254 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload920, <4 x half> %248, <4 x float> %out.sroa.0.10), !call_argsrelate !163
  %255 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.38.0.copyload931, <4 x half> %248, <4 x float> %out.sroa.38.10), !call_argsrelate !163
  %256 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.62.16.copyload988, <4 x half> %248, <4 x float> %out.sroa.74.10), !call_argsrelate !163
  %257 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.98.16.copyload999, <4 x half> %248, <4 x float> %out.sroa.110.10), !call_argsrelate !163
  br label %if.end352.2885

if.end352.2885:                                   ; preds = %for.cond314.preheader.2877, %for.cond261.preheader.2
  %out.sroa.110.11 = phi <4 x float> [ %out.sroa.110.10, %for.cond261.preheader.2 ], [ %257, %for.cond314.preheader.2877 ]
  %out.sroa.74.11 = phi <4 x float> [ %out.sroa.74.10, %for.cond261.preheader.2 ], [ %256, %for.cond314.preheader.2877 ]
  %out.sroa.38.11 = phi <4 x float> [ %out.sroa.38.10, %for.cond261.preheader.2 ], [ %255, %for.cond314.preheader.2877 ]
  %out.sroa.0.11 = phi <4 x float> [ %out.sroa.0.10, %for.cond261.preheader.2 ], [ %254, %for.cond314.preheader.2877 ]
  %or.cond650.1.2 = icmp ugt i32 %mul11.5, 1023
  %cmp274.not.1.2 = icmp sgt i32 %mul11.5, %1
  %or.cond651.1.2 = or i1 %or.cond650.1.2, %cmp274.not.1.2
  br i1 %or.cond651.1.2, label %if.end352.1.2, label %for.cond333.preheader.1.2

for.cond333.preheader.1.2:                        ; preds = %if.end352.2885
  %add306.1.2 = or i32 %and246, 2304
  %gep.1.2 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add306.1.2
  %258 = load <4 x half>, ptr addrspace(3) %gep.1.2, align 8
  %259 = shl nsw i32 %cond.i.i615.5, 10
  %mul283.1.2 = and i32 %259, 64512
  %add284.1.2 = or disjoint i32 %mul283.1.2, %mul103
  %260 = zext nneg i32 %add284.1.2 to i64
  %261 = or disjoint i64 %260, %27
  %262 = or disjoint i64 %261, 512
  %add.ptr292.1.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %262
  %vr.sroa.98.16.add.ptr292.1.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr292.1.1.2, i64 8
  %vr.sroa.98.16.copyload1000 = load <4 x half>, ptr addrspace(4) %vr.sroa.98.16.add.ptr292.1.1.2.sroa_idx, align 8
  %vr.sroa.62.16.copyload989 = load <4 x half>, ptr addrspace(4) %add.ptr292.1.1.2, align 16
  %263 = or disjoint i64 %260, %27
  %add.ptr292.1691.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %263
  %vr.sroa.38.0.add.ptr292.1691.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr292.1691.2, i64 8
  %vr.sroa.38.0.copyload932 = load <4 x half>, ptr addrspace(4) %vr.sroa.38.0.add.ptr292.1691.2.sroa_idx, align 8
  %vr.sroa.0.0.copyload921 = load <4 x half>, ptr addrspace(4) %add.ptr292.1691.2, align 16
  %264 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload921, <4 x half> %258, <4 x float> %out_1.sroa.0.10), !call_argsrelate !163
  %265 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.38.0.copyload932, <4 x half> %258, <4 x float> %out_1.sroa.34.10), !call_argsrelate !163
  %266 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.62.16.copyload989, <4 x half> %258, <4 x float> %out_1.sroa.66.10), !call_argsrelate !163
  %267 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.98.16.copyload1000, <4 x half> %258, <4 x float> %out_1.sroa.98.10), !call_argsrelate !163
  br label %if.end352.1.2

if.end352.1.2:                                    ; preds = %for.cond333.preheader.1.2, %if.end352.2885
  %out_1.sroa.98.12 = phi <4 x float> [ %out_1.sroa.98.10, %if.end352.2885 ], [ %267, %for.cond333.preheader.1.2 ]
  %out_1.sroa.66.12 = phi <4 x float> [ %out_1.sroa.66.10, %if.end352.2885 ], [ %266, %for.cond333.preheader.1.2 ]
  %out_1.sroa.34.12 = phi <4 x float> [ %out_1.sroa.34.10, %if.end352.2885 ], [ %265, %for.cond333.preheader.1.2 ]
  %out_1.sroa.0.12 = phi <4 x float> [ %out_1.sroa.0.10, %if.end352.2885 ], [ %264, %for.cond333.preheader.1.2 ]
  %or.cond650.2.2 = icmp ugt i32 %mul11.6, 1023
  %cmp274.not.2.2 = icmp sgt i32 %mul11.6, %1
  %or.cond651.2.2 = or i1 %or.cond650.2.2, %cmp274.not.2.2
  br i1 %or.cond651.2.2, label %if.end352.2.2, label %for.cond314.preheader.2.2

for.cond314.preheader.2.2:                        ; preds = %if.end352.1.2
  %add306.2.2 = or disjoint i32 %mul305, 2560
  %gep.2.2 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add306.2.2
  %268 = load <4 x half>, ptr addrspace(3) %gep.2.2, align 8
  %269 = shl nsw i32 %cond.i.i615.6, 10
  %mul283.2.2 = and i32 %269, 64512
  %add284.2.2 = or disjoint i32 %mul283.2.2, %mul103
  %270 = zext nneg i32 %add284.2.2 to i64
  %271 = or disjoint i64 %270, %27
  %272 = or disjoint i64 %271, 512
  %add.ptr292.1.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %272
  %vr.sroa.98.16.add.ptr292.1.2.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr292.1.2.2, i64 8
  %vr.sroa.98.16.copyload1001 = load <4 x half>, ptr addrspace(4) %vr.sroa.98.16.add.ptr292.1.2.2.sroa_idx, align 8
  %vr.sroa.62.16.copyload990 = load <4 x half>, ptr addrspace(4) %add.ptr292.1.2.2, align 16
  %273 = or disjoint i64 %270, %27
  %add.ptr292.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %273
  %vr.sroa.38.0.add.ptr292.2.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr292.2.2, i64 8
  %vr.sroa.38.0.copyload933 = load <4 x half>, ptr addrspace(4) %vr.sroa.38.0.add.ptr292.2.2.sroa_idx, align 8
  %vr.sroa.0.0.copyload922 = load <4 x half>, ptr addrspace(4) %add.ptr292.2.2, align 16
  %274 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload922, <4 x half> %268, <4 x float> %out.sroa.0.11), !call_argsrelate !163
  %275 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.38.0.copyload933, <4 x half> %268, <4 x float> %out.sroa.38.11), !call_argsrelate !163
  %276 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.62.16.copyload990, <4 x half> %268, <4 x float> %out.sroa.74.11), !call_argsrelate !163
  %277 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.98.16.copyload1001, <4 x half> %268, <4 x float> %out.sroa.110.11), !call_argsrelate !163
  br label %if.end352.2.2

if.end352.2.2:                                    ; preds = %for.cond314.preheader.2.2, %if.end352.1.2
  %out.sroa.110.13 = phi <4 x float> [ %out.sroa.110.11, %if.end352.1.2 ], [ %277, %for.cond314.preheader.2.2 ]
  %out.sroa.74.13 = phi <4 x float> [ %out.sroa.74.11, %if.end352.1.2 ], [ %276, %for.cond314.preheader.2.2 ]
  %out.sroa.38.13 = phi <4 x float> [ %out.sroa.38.11, %if.end352.1.2 ], [ %275, %for.cond314.preheader.2.2 ]
  %out.sroa.0.13 = phi <4 x float> [ %out.sroa.0.11, %if.end352.1.2 ], [ %274, %for.cond314.preheader.2.2 ]
  %or.cond650.3.2 = icmp ugt i32 %mul11.7, 1023
  %cmp274.not.3.2 = icmp sgt i32 %mul11.7, %1
  %or.cond651.3.2 = or i1 %or.cond650.3.2, %cmp274.not.3.2
  br i1 %or.cond651.3.2, label %if.end356.2, label %for.cond333.preheader.3.2

for.cond333.preheader.3.2:                        ; preds = %if.end352.2.2
  %add306.3.2 = or i32 %and246, 2816
  %gep.3.2 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add306.3.2
  %278 = load <4 x half>, ptr addrspace(3) %gep.3.2, align 8
  %279 = shl nsw i32 %cond.i.i615.7, 10
  %mul283.3.2 = and i32 %279, 64512
  %add284.3.2 = or disjoint i32 %mul283.3.2, %mul103
  %280 = zext nneg i32 %add284.3.2 to i64
  %281 = or disjoint i64 %280, %27
  %282 = or disjoint i64 %281, 512
  %add.ptr292.1.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %282
  %vr.sroa.98.16.add.ptr292.1.3.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr292.1.3.2, i64 8
  %vr.sroa.98.16.copyload1002 = load <4 x half>, ptr addrspace(4) %vr.sroa.98.16.add.ptr292.1.3.2.sroa_idx, align 8
  %vr.sroa.62.16.copyload991 = load <4 x half>, ptr addrspace(4) %add.ptr292.1.3.2, align 16
  %283 = or disjoint i64 %280, %27
  %add.ptr292.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %283
  %vr.sroa.38.0.add.ptr292.3.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr292.3.2, i64 8
  %vr.sroa.38.0.copyload934 = load <4 x half>, ptr addrspace(4) %vr.sroa.38.0.add.ptr292.3.2.sroa_idx, align 8
  %vr.sroa.0.0.copyload923 = load <4 x half>, ptr addrspace(4) %add.ptr292.3.2, align 16
  %284 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload923, <4 x half> %278, <4 x float> %out_1.sroa.0.12), !call_argsrelate !163
  %285 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.38.0.copyload934, <4 x half> %278, <4 x float> %out_1.sroa.34.12), !call_argsrelate !163
  %286 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.62.16.copyload991, <4 x half> %278, <4 x float> %out_1.sroa.66.12), !call_argsrelate !163
  %287 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.98.16.copyload1002, <4 x half> %278, <4 x float> %out_1.sroa.98.12), !call_argsrelate !163
  br label %if.end356.2

if.end356.2:                                      ; preds = %if.end352.2.2, %for.cond333.preheader.3.2, %if.end254.2
  %out.sroa.110.15 = phi <4 x float> [ %out.sroa.110.10, %if.end254.2 ], [ %out.sroa.110.13, %for.cond333.preheader.3.2 ], [ %out.sroa.110.13, %if.end352.2.2 ]
  %out.sroa.74.15 = phi <4 x float> [ %out.sroa.74.10, %if.end254.2 ], [ %out.sroa.74.13, %for.cond333.preheader.3.2 ], [ %out.sroa.74.13, %if.end352.2.2 ]
  %out.sroa.38.15 = phi <4 x float> [ %out.sroa.38.10, %if.end254.2 ], [ %out.sroa.38.13, %for.cond333.preheader.3.2 ], [ %out.sroa.38.13, %if.end352.2.2 ]
  %out.sroa.0.15 = phi <4 x float> [ %out.sroa.0.10, %if.end254.2 ], [ %out.sroa.0.13, %for.cond333.preheader.3.2 ], [ %out.sroa.0.13, %if.end352.2.2 ]
  %out_1.sroa.98.15 = phi <4 x float> [ %out_1.sroa.98.10, %if.end254.2 ], [ %287, %for.cond333.preheader.3.2 ], [ %out_1.sroa.98.12, %if.end352.2.2 ]
  %out_1.sroa.66.15 = phi <4 x float> [ %out_1.sroa.66.10, %if.end254.2 ], [ %286, %for.cond333.preheader.3.2 ], [ %out_1.sroa.66.12, %if.end352.2.2 ]
  %out_1.sroa.34.15 = phi <4 x float> [ %out_1.sroa.34.10, %if.end254.2 ], [ %285, %for.cond333.preheader.3.2 ], [ %out_1.sroa.34.12, %if.end352.2.2 ]
  %out_1.sroa.0.15 = phi <4 x float> [ %out_1.sroa.0.10, %if.end254.2 ], [ %284, %for.cond333.preheader.3.2 ], [ %out_1.sroa.0.12, %if.end352.2.2 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %cmp15, label %for.body368.preheader, label %if.end399

if.end399:                                        ; preds = %for.body368.preheader, %if.end356.2
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  %cmp402 = icmp eq i32 %shr256.mask, 64
  br i1 %cmp402, label %if.then403, label %if.end500

if.then403:                                       ; preds = %if.end399
  %and405 = and i32 %18, 63
  %arrayidx407 = getelementptr inbounds float, ptr addrspace(3) @buf_dyn_shmem, i32 %and405
  %288 = load float, ptr addrspace(3) %arrayidx407, align 4, !tbaa !105
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %out.sroa.0.15, i64 0
  %out_1.sroa.0.0.vec.extract = extractelement <4 x float> %out_1.sroa.0.15, i64 0
  %add417 = fadd contract float %out.sroa.0.0.vec.extract, %out_1.sroa.0.0.vec.extract
  %mul423 = fmul contract float %288, %add417
  %289 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul423)
  %oreg.sroa.0.0.insert.ext = zext i16 %289 to i64
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %out.sroa.0.15, i64 1
  %out_1.sroa.0.4.vec.extract = extractelement <4 x float> %out_1.sroa.0.15, i64 1
  %add417.1 = fadd contract float %out.sroa.0.4.vec.extract, %out_1.sroa.0.4.vec.extract
  %mul423.1 = fmul contract float %288, %add417.1
  %290 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul423.1)
  %oreg.sroa.0.2.insert.ext = zext i16 %290 to i64
  %oreg.sroa.0.2.insert.shift = shl nuw nsw i64 %oreg.sroa.0.2.insert.ext, 16
  %oreg.sroa.0.2.insert.insert = or disjoint i64 %oreg.sroa.0.2.insert.shift, %oreg.sroa.0.0.insert.ext
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %out.sroa.0.15, i64 2
  %out_1.sroa.0.8.vec.extract = extractelement <4 x float> %out_1.sroa.0.15, i64 2
  %add417.2 = fadd contract float %out.sroa.0.8.vec.extract, %out_1.sroa.0.8.vec.extract
  %mul423.2 = fmul contract float %288, %add417.2
  %291 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul423.2)
  %oreg.sroa.0.4.insert.ext = zext i16 %291 to i64
  %oreg.sroa.0.4.insert.shift = shl nuw nsw i64 %oreg.sroa.0.4.insert.ext, 32
  %oreg.sroa.0.4.insert.insert = or disjoint i64 %oreg.sroa.0.2.insert.insert, %oreg.sroa.0.4.insert.shift
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %out.sroa.0.15, i64 3
  %out_1.sroa.0.12.vec.extract = extractelement <4 x float> %out_1.sroa.0.15, i64 3
  %add417.3 = fadd contract float %out.sroa.0.12.vec.extract, %out_1.sroa.0.12.vec.extract
  %mul423.3 = fmul contract float %288, %add417.3
  %292 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul423.3)
  %oreg.sroa.0.6.insert.ext = zext i16 %292 to i64
  %oreg.sroa.0.6.insert.shift = shl nuw i64 %oreg.sroa.0.6.insert.ext, 48
  %oreg.sroa.0.6.insert.insert = or disjoint i64 %oreg.sroa.0.4.insert.insert, %oreg.sroa.0.6.insert.shift
  %out.sroa.38.16.vec.extract = extractelement <4 x float> %out.sroa.38.15, i64 0
  %out_1.sroa.34.16.vec.extract = extractelement <4 x float> %out_1.sroa.34.15, i64 0
  %add417.4 = fadd contract float %out.sroa.38.16.vec.extract, %out_1.sroa.34.16.vec.extract
  %mul423.4 = fmul contract float %288, %add417.4
  %293 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul423.4)
  %oreg.sroa.7.8.insert.ext = zext i16 %293 to i64
  %out.sroa.38.20.vec.extract = extractelement <4 x float> %out.sroa.38.15, i64 1
  %out_1.sroa.34.20.vec.extract = extractelement <4 x float> %out_1.sroa.34.15, i64 1
  %add417.5 = fadd contract float %out.sroa.38.20.vec.extract, %out_1.sroa.34.20.vec.extract
  %mul423.5 = fmul contract float %288, %add417.5
  %294 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul423.5)
  %oreg.sroa.7.10.insert.ext = zext i16 %294 to i64
  %oreg.sroa.7.10.insert.shift = shl nuw nsw i64 %oreg.sroa.7.10.insert.ext, 16
  %oreg.sroa.7.10.insert.insert = or disjoint i64 %oreg.sroa.7.10.insert.shift, %oreg.sroa.7.8.insert.ext
  %out.sroa.38.24.vec.extract = extractelement <4 x float> %out.sroa.38.15, i64 2
  %out_1.sroa.34.24.vec.extract = extractelement <4 x float> %out_1.sroa.34.15, i64 2
  %add417.6 = fadd contract float %out.sroa.38.24.vec.extract, %out_1.sroa.34.24.vec.extract
  %mul423.6 = fmul contract float %288, %add417.6
  %295 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul423.6)
  %oreg.sroa.7.12.insert.ext = zext i16 %295 to i64
  %oreg.sroa.7.12.insert.shift = shl nuw nsw i64 %oreg.sroa.7.12.insert.ext, 32
  %oreg.sroa.7.12.insert.insert = or disjoint i64 %oreg.sroa.7.10.insert.insert, %oreg.sroa.7.12.insert.shift
  %out.sroa.38.28.vec.extract = extractelement <4 x float> %out.sroa.38.15, i64 3
  %out_1.sroa.34.28.vec.extract = extractelement <4 x float> %out_1.sroa.34.15, i64 3
  %add417.7 = fadd contract float %out.sroa.38.28.vec.extract, %out_1.sroa.34.28.vec.extract
  %mul423.7 = fmul contract float %288, %add417.7
  %296 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul423.7)
  %oreg.sroa.7.14.insert.ext = zext i16 %296 to i64
  %oreg.sroa.7.14.insert.shift = shl nuw i64 %oreg.sroa.7.14.insert.ext, 48
  %oreg.sroa.7.14.insert.insert = or disjoint i64 %oreg.sroa.7.12.insert.insert, %oreg.sroa.7.14.insert.shift
  %out.sroa.74.32.vec.extract = extractelement <4 x float> %out.sroa.74.15, i64 0
  %out_1.sroa.66.32.vec.extract = extractelement <4 x float> %out_1.sroa.66.15, i64 0
  %add417.8 = fadd contract float %out.sroa.74.32.vec.extract, %out_1.sroa.66.32.vec.extract
  %mul423.8 = fmul contract float %288, %add417.8
  %297 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul423.8)
  %oreg.sroa.12.16.insert.ext = zext i16 %297 to i64
  %out.sroa.74.36.vec.extract = extractelement <4 x float> %out.sroa.74.15, i64 1
  %out_1.sroa.66.36.vec.extract = extractelement <4 x float> %out_1.sroa.66.15, i64 1
  %add417.9 = fadd contract float %out.sroa.74.36.vec.extract, %out_1.sroa.66.36.vec.extract
  %mul423.9 = fmul contract float %288, %add417.9
  %298 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul423.9)
  %oreg.sroa.12.18.insert.ext = zext i16 %298 to i64
  %oreg.sroa.12.18.insert.shift = shl nuw nsw i64 %oreg.sroa.12.18.insert.ext, 16
  %oreg.sroa.12.18.insert.insert = or disjoint i64 %oreg.sroa.12.18.insert.shift, %oreg.sroa.12.16.insert.ext
  %out.sroa.74.40.vec.extract = extractelement <4 x float> %out.sroa.74.15, i64 2
  %out_1.sroa.66.40.vec.extract = extractelement <4 x float> %out_1.sroa.66.15, i64 2
  %add417.10 = fadd contract float %out.sroa.74.40.vec.extract, %out_1.sroa.66.40.vec.extract
  %mul423.10 = fmul contract float %288, %add417.10
  %299 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul423.10)
  %oreg.sroa.12.20.insert.ext = zext i16 %299 to i64
  %oreg.sroa.12.20.insert.shift = shl nuw nsw i64 %oreg.sroa.12.20.insert.ext, 32
  %oreg.sroa.12.20.insert.insert = or disjoint i64 %oreg.sroa.12.18.insert.insert, %oreg.sroa.12.20.insert.shift
  %out.sroa.74.44.vec.extract = extractelement <4 x float> %out.sroa.74.15, i64 3
  %out_1.sroa.66.44.vec.extract = extractelement <4 x float> %out_1.sroa.66.15, i64 3
  %add417.11 = fadd contract float %out.sroa.74.44.vec.extract, %out_1.sroa.66.44.vec.extract
  %mul423.11 = fmul contract float %288, %add417.11
  %300 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul423.11)
  %oreg.sroa.12.22.insert.ext = zext i16 %300 to i64
  %oreg.sroa.12.22.insert.shift = shl nuw i64 %oreg.sroa.12.22.insert.ext, 48
  %oreg.sroa.12.22.insert.insert = or disjoint i64 %oreg.sroa.12.20.insert.insert, %oreg.sroa.12.22.insert.shift
  %out.sroa.110.48.vec.extract = extractelement <4 x float> %out.sroa.110.15, i64 0
  %out_1.sroa.98.48.vec.extract = extractelement <4 x float> %out_1.sroa.98.15, i64 0
  %add417.12 = fadd contract float %out.sroa.110.48.vec.extract, %out_1.sroa.98.48.vec.extract
  %mul423.12 = fmul contract float %288, %add417.12
  %301 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul423.12)
  %oreg.sroa.17.24.insert.ext = zext i16 %301 to i64
  %out.sroa.110.52.vec.extract = extractelement <4 x float> %out.sroa.110.15, i64 1
  %out_1.sroa.98.52.vec.extract = extractelement <4 x float> %out_1.sroa.98.15, i64 1
  %add417.13 = fadd contract float %out.sroa.110.52.vec.extract, %out_1.sroa.98.52.vec.extract
  %mul423.13 = fmul contract float %288, %add417.13
  %302 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul423.13)
  %oreg.sroa.17.26.insert.ext = zext i16 %302 to i64
  %oreg.sroa.17.26.insert.shift = shl nuw nsw i64 %oreg.sroa.17.26.insert.ext, 16
  %oreg.sroa.17.26.insert.insert = or disjoint i64 %oreg.sroa.17.26.insert.shift, %oreg.sroa.17.24.insert.ext
  %out.sroa.110.56.vec.extract = extractelement <4 x float> %out.sroa.110.15, i64 2
  %out_1.sroa.98.56.vec.extract = extractelement <4 x float> %out_1.sroa.98.15, i64 2
  %add417.14 = fadd contract float %out.sroa.110.56.vec.extract, %out_1.sroa.98.56.vec.extract
  %mul423.14 = fmul contract float %288, %add417.14
  %303 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul423.14)
  %oreg.sroa.17.28.insert.ext = zext i16 %303 to i64
  %oreg.sroa.17.28.insert.shift = shl nuw nsw i64 %oreg.sroa.17.28.insert.ext, 32
  %oreg.sroa.17.28.insert.insert = or disjoint i64 %oreg.sroa.17.26.insert.insert, %oreg.sroa.17.28.insert.shift
  %out.sroa.110.60.vec.extract = extractelement <4 x float> %out.sroa.110.15, i64 3
  %out_1.sroa.98.60.vec.extract = extractelement <4 x float> %out_1.sroa.98.15, i64 3
  %add417.15 = fadd contract float %out.sroa.110.60.vec.extract, %out_1.sroa.98.60.vec.extract
  %mul423.15 = fmul contract float %288, %add417.15
  %304 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul423.15)
  %oreg.sroa.17.30.insert.ext = zext i16 %304 to i64
  %oreg.sroa.17.30.insert.shift = shl nuw i64 %oreg.sroa.17.30.insert.ext, 48
  %oreg.sroa.17.30.insert.insert = or disjoint i64 %oreg.sroa.17.28.insert.insert, %oreg.sroa.17.30.insert.shift
  %and443 = shl nuw nsw i32 %18, 6
  %mul444 = and i32 %and443, 960
  %and447 = lshr i32 %18, 5
  %shr448 = and i32 %and447, 1
  %and451 = and i32 %18, 7
  %mul457 = and i32 %25, 4
  %xor = xor i32 %shr448, %and451
  %mul452 = shl nuw nsw i32 %xor, 3
  %add453 = or disjoint i32 %mul452, %mul444
  %add458 = or disjoint i32 %add453, %mul457
  %add.ptr460 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add458
  store i64 %oreg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr460, align 8
  %xor.1 = xor i32 %and447, %and451
  %mul452.1 = shl nuw nsw i32 %xor.1, 3
  %add453.1 = or disjoint i32 %mul452.1, %mul444
  %add458.1 = or disjoint i32 %add453.1, %mul457
  %add.ptr460.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add458.1
  store i64 %oreg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr460.1, align 8
  %add449.2 = or disjoint i32 %shr448, 4
  %xor.2 = xor i32 %add449.2, %and451
  %mul452.2 = shl nuw nsw i32 %xor.2, 3
  %add453.2 = or disjoint i32 %mul452.2, %mul444
  %add458.2 = or disjoint i32 %add453.2, %mul457
  %add.ptr460.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add458.2
  store i64 %oreg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr460.2, align 8
  %add449.3 = or i32 %and447, 6
  %xor.3 = xor i32 %add449.3, %and451
  %mul452.3 = shl nuw nsw i32 %xor.3, 3
  %add453.3 = or disjoint i32 %mul452.3, %mul444
  %add458.3 = or disjoint i32 %add453.3, %mul457
  %add.ptr460.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add458.3
  store i64 %oreg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr460.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul472 = and i32 %and110, 448
  %xor479 = xor i32 %and110, %18
  %mul480 = and i32 %xor479, 56
  %305 = or disjoint i32 %mul480, %mul472
  %mul485 = shl nsw i32 %0, 20
  %mul487 = shl nsw i32 %1, 10
  %add488 = add nuw nsw i32 %mul485, %mul487
  %306 = or disjoint i32 %add488, %mul289
  %307 = zext nneg i32 %306 to i64
  %add.ptr483 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %305
  %add.ptr496 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %307
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr496, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr483, i64 16, i1 false), !tbaa.struct !204, !call_argsrelate !205
  %308 = or disjoint i32 %305, 512
  %add.ptr483.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %308
  %309 = or disjoint i64 %307, 512
  %add.ptr496.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %309
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr496.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr483.1, i64 16, i1 false), !tbaa.struct !204, !call_argsrelate !205
  br label %if.end500

if.end500:                                        ; preds = %if.then403, %if.end399
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


