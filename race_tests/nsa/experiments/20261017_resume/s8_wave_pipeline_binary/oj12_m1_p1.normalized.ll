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
  %cond.i.i573 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64)
  %mul11 = shl nsw i32 %cond.i.i573, 4
  %4 = or disjoint i64 %2, 1
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !call_argsrelate !48
  %cond.i.i573.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64)
  %mul11.1 = shl nsw i32 %cond.i.i573.1, 4
  %6 = or disjoint i64 %2, 2
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !call_argsrelate !48
  %cond.i.i573.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64)
  %mul11.2 = shl nsw i32 %cond.i.i573.2, 4
  %8 = or disjoint i64 %2, 3
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !call_argsrelate !48
  %cond.i.i573.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64)
  %mul11.3 = shl nsw i32 %cond.i.i573.3, 4
  %10 = or disjoint i64 %2, 4
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !call_argsrelate !48
  %cond.i.i573.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64)
  %mul11.4 = shl nsw i32 %cond.i.i573.4, 4
  %12 = or disjoint i64 %2, 5
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !call_argsrelate !48
  %cond.i.i573.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64)
  %mul11.5 = shl nsw i32 %cond.i.i573.5, 4
  %14 = or disjoint i64 %2, 6
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !call_argsrelate !48
  %cond.i.i573.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64)
  %mul11.6 = shl nsw i32 %cond.i.i573.6, 4
  %16 = or disjoint i64 %2, 7
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !call_argsrelate !48
  %cond.i.i573.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64)
  %mul11.7 = shl nsw i32 %cond.i.i573.7, 4
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
  %qr.sroa.12.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %qr.sroa.12.0.copyload = load <4 x half>, ptr addrspace(4) %qr.sroa.12.0.add.ptr.sroa_idx, align 8
  %23 = or disjoint i64 %20, %21
  %24 = or disjoint i64 %23, 32
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %24
  %qr.sroa.21.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16
  %qr.sroa.31.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr.1, i64 8
  %qr.sroa.31.16.copyload = load <4 x half>, ptr addrspace(4) %qr.sroa.31.16.add.ptr.1.sroa_idx, align 8
  br label %if.end

if.end:                                           ; preds = %entry, %for.cond16.preheader
  %qr.sroa.31.0 = phi <4 x half> [ %qr.sroa.31.16.copyload, %for.cond16.preheader ], [ undef, %entry ]
  %qr.sroa.21.0 = phi <4 x half> [ %qr.sroa.21.16.copyload, %for.cond16.preheader ], [ undef, %entry ]
  %qr.sroa.12.0 = phi <4 x half> [ %qr.sroa.12.0.copyload, %for.cond16.preheader ], [ undef, %entry ]
  %qr.sroa.0.0 = phi <4 x half> [ %qr.sroa.0.0.copyload, %for.cond16.preheader ], [ undef, %entry ]
  %cmp80 = icmp ugt i32 %18, 63
  %shr233.mask = and i32 %18, 960
  %cmp234.not = icmp eq i32 %shr233.mask, 64
  %mul97 = shl nsw i32 %0, 16
  %and104 = shl nuw nsw i32 %18, 3
  %invariant.op = add nsw i32 %1, -15
  %25 = lshr i32 %18, 2
  %mul137 = and i32 %25, 12
  %and226 = shl nuw nsw i32 %18, 2
  %mul260 = and i32 %and104, 504
  %26 = zext nneg i32 %and104 to i64
  %27 = zext nneg i32 %mul260 to i64
  br i1 %cmp80, label %if.end324, label %if.then82

for.body336.preheader:                            ; preds = %if.end324.8
  %add340 = fadd contract float %sums.sroa.0.16, 0.000000e+00
  %add340.1 = fadd contract float %add340, %sums.sroa.22.16
  %add340.2 = fadd contract float %add340.1, %sums.sroa.42.16
  %add340.3 = fadd contract float %add340.2, %sums.sroa.62.16
  %28 = bitcast float %add340.3 to i32
  %29 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %30 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %29) #11
  %xor.i.i = xor i32 %30, 32
  %31 = and i32 %30, -64
  %and.i.i = add nsw i32 %31, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i574 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %30
  %shl.i.i = shl i32 %cond.i.i574, 2
  %32 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %28)
  %33 = bitcast i32 %32 to float
  %add348 = fadd contract float %add340.3, %33
  %34 = bitcast float %add348 to i32
  %35 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %36 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %35) #11
  %xor.i.i575 = xor i32 %36, 16
  %37 = and i32 %36, -64
  %and.i.i576 = add nsw i32 %37, 64
  %cmp.not.i.i577 = icmp slt i32 %xor.i.i575, %and.i.i576
  %cond.i.i578 = select i1 %cmp.not.i.i577, i32 %xor.i.i575, i32 %36
  %shl.i.i579 = shl i32 %cond.i.i578, 2
  %38 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i579, i32 %34)
  %39 = bitcast i32 %38 to float
  %add353 = fadd contract float %add348, %39
  %cmp356 = fcmp contract ogt float %add353, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add353
  %condval_1.0 = select i1 %cmp356, float %div, float 0.000000e+00
  %arrayidx366 = getelementptr inbounds float, ptr addrspace(3) @buf_dyn_shmem, i32 %18
  store float %condval_1.0, ptr addrspace(3) %arrayidx366, align 4, !tbaa !105
  br label %if.end367

if.then82:                                        ; preds = %if.end
  %or.cond600 = icmp ugt i32 %mul11, 1023
  %cmp90.not = icmp sgt i32 %mul11, %1
  %or.cond601 = or i1 %or.cond600, %cmp90.not
  br i1 %or.cond601, label %if.end116, label %for.cond92.preheader

for.cond92.preheader:                             ; preds = %if.then82
  %40 = shl nsw i32 %cond.i.i573, 10
  %mul99 = and i32 %40, 64512
  %add100 = or disjoint i32 %mul99, %mul97
  %41 = zext nneg i32 %add100 to i64
  %42 = or disjoint i64 %41, %26
  %add.ptr108 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %42
  %kr.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr108, align 16
  %kr.sroa.20.0.add.ptr108.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108, i64 8
  %kr.sroa.20.0.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.20.0.add.ptr108.sroa_idx, align 8
  %43 = or disjoint i64 %41, %26
  %44 = or disjoint i64 %43, 512
  %add.ptr108.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %44
  %kr.sroa.29.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr108.1, align 16
  %kr.sroa.47.16.add.ptr108.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108.1, i64 8
  %kr.sroa.47.16.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.47.16.add.ptr108.1.sroa_idx, align 8
  br label %if.end116

if.end116:                                        ; preds = %for.cond92.preheader, %if.then82
  %kr.sroa.47.0 = phi <4 x half> [ undef, %if.then82 ], [ %kr.sroa.47.16.copyload, %for.cond92.preheader ]
  %kr.sroa.29.0 = phi <4 x half> [ undef, %if.then82 ], [ %kr.sroa.29.16.copyload, %for.cond92.preheader ]
  %kr.sroa.20.0 = phi <4 x half> [ undef, %if.then82 ], [ %kr.sroa.20.0.copyload, %for.cond92.preheader ]
  %kr.sroa.0.0 = phi <4 x half> [ undef, %if.then82 ], [ %kr.sroa.0.0.copyload, %for.cond92.preheader ]
  br i1 %or.cond601, label %if.end220, label %if.then125

if.then125:                                       ; preds = %if.end116
  %cmp128 = icmp sgt i32 %mul11, %invariant.op
  br i1 %cmp128, label %for.cond130.preheader, label %if.end156

for.cond130.preheader:                            ; preds = %if.then125
  %add138 = or disjoint i32 %mul11, %mul137
  %cmp141.not = icmp sgt i32 %add138, %1
  %spec.select = select i1 %cmp141.not, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert752 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp141.not.1.not = icmp slt i32 %add138, %1
  %spec.select.1 = select i1 %cmp141.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert855 = insertelement <4 x float> %scores.sroa.0.0.vec.insert752, float %spec.select.1, i64 1
  %add139.2 = or disjoint i32 %add138, 2
  %cmp141.not.2 = icmp sgt i32 %add139.2, %1
  %spec.select.2 = select i1 %cmp141.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert942 = insertelement <4 x float> %scores.sroa.0.4.vec.insert855, float %spec.select.2, i64 2
  %add139.3 = or disjoint i32 %add138, 3
  %cmp141.not.3 = icmp sgt i32 %add139.3, %1
  %spec.select.3 = select i1 %cmp141.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1029 = insertelement <4 x float> %scores.sroa.0.8.vec.insert942, float %spec.select.3, i64 3
  br label %if.end156

if.end156:                                        ; preds = %if.then125, %for.cond130.preheader
  %scores.sroa.0.0 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1029, %for.cond130.preheader ], [ zeroinitializer, %if.then125 ]
  %45 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.0)
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.20.0, <4 x half> %qr.sroa.12.0, <4 x float> %45)
  %47 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.29.0, <4 x half> %qr.sroa.21.0, <4 x float> %46)
  %48 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.0, <4 x half> %qr.sroa.31.0, <4 x float> %47)
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %48, i64 0
  %mul180 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %49 = tail call contract noundef float @llvm.minnum.f32(float %mul180, float 0x4024CB5EC0000000)
  %50 = tail call contract noundef float @llvm.exp.f32(float %49)
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %48, i64 1
  %mul180.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %51 = tail call contract noundef float @llvm.minnum.f32(float %mul180.1, float 0x4024CB5EC0000000)
  %52 = tail call contract noundef float @llvm.exp.f32(float %51)
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %48, i64 2
  %mul180.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %53 = tail call contract noundef float @llvm.minnum.f32(float %mul180.2, float 0x4024CB5EC0000000)
  %54 = tail call contract noundef float @llvm.exp.f32(float %53)
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %48, i64 3
  %mul180.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %55 = tail call contract noundef float @llvm.minnum.f32(float %mul180.3, float 0x4024CB5EC0000000)
  %56 = tail call contract noundef float @llvm.exp.f32(float %55)
  %57 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %50)
  %probs.sroa.0.0.vec.insert = insertelement <4 x i16> poison, i16 %57, i64 0
  %58 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %52)
  %probs.sroa.0.2.vec.insert = insertelement <4 x i16> %probs.sroa.0.0.vec.insert, i16 %58, i64 1
  %59 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %54)
  %probs.sroa.0.4.vec.insert = insertelement <4 x i16> %probs.sroa.0.2.vec.insert, i16 %59, i64 2
  %60 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %56)
  %probs.sroa.0.6.vec.insert = insertelement <4 x i16> %probs.sroa.0.4.vec.insert, i16 %60, i64 3
  br label %if.end220

if.end220:                                        ; preds = %if.end116, %if.end156
  %sums.sroa.62.1 = phi float [ %56, %if.end156 ], [ 0.000000e+00, %if.end116 ]
  %sums.sroa.42.1 = phi float [ %54, %if.end156 ], [ 0.000000e+00, %if.end116 ]
  %sums.sroa.22.1 = phi float [ %52, %if.end156 ], [ 0.000000e+00, %if.end116 ]
  %sums.sroa.0.1 = phi float [ %50, %if.end156 ], [ 0.000000e+00, %if.end116 ]
  %probs.sroa.0.0 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert, %if.end156 ], [ zeroinitializer, %if.end116 ]
  %add.ptr230 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and226
  store <4 x i16> %probs.sroa.0.0, ptr addrspace(3) %add.ptr230, align 8
  br label %if.end324

if.end324:                                        ; preds = %if.end, %if.end220
  %sums.sroa.62.2 = phi float [ 0.000000e+00, %if.end ], [ %sums.sroa.62.1, %if.end220 ]
  %sums.sroa.42.2 = phi float [ 0.000000e+00, %if.end ], [ %sums.sroa.42.1, %if.end220 ]
  %sums.sroa.22.2 = phi float [ 0.000000e+00, %if.end ], [ %sums.sroa.22.1, %if.end220 ]
  %sums.sroa.0.2 = phi float [ 0.000000e+00, %if.end ], [ %sums.sroa.0.1, %if.end220 ]
  %kr.sroa.47.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.47.0, %if.end220 ]
  %kr.sroa.29.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.29.0, %if.end220 ]
  %kr.sroa.20.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.20.0, %if.end220 ]
  %kr.sroa.0.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.0.0, %if.end220 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %cmp80, label %if.end231.1, label %if.then82.1

if.then82.1:                                      ; preds = %if.end324
  %or.cond600.1 = icmp ugt i32 %mul11.1, 1023
  %cmp90.not.1 = icmp sgt i32 %mul11.1, %1
  %or.cond601.1 = or i1 %or.cond600.1, %cmp90.not.1
  br i1 %or.cond601.1, label %if.end116.1, label %for.cond92.preheader.1

for.cond92.preheader.1:                           ; preds = %if.then82.1
  %61 = shl nsw i32 %cond.i.i573.1, 10
  %mul99.1 = and i32 %61, 64512
  %add100.1 = or disjoint i32 %mul99.1, %mul97
  %62 = zext nneg i32 %add100.1 to i64
  %63 = or disjoint i64 %62, %26
  %add.ptr108.1624 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %63
  %kr.sroa.0.0.copyload1241 = load <4 x half>, ptr addrspace(4) %add.ptr108.1624, align 16
  %kr.sroa.20.0.add.ptr108.1624.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108.1624, i64 8
  %kr.sroa.20.0.copyload1249 = load <4 x half>, ptr addrspace(4) %kr.sroa.20.0.add.ptr108.1624.sroa_idx, align 8
  %64 = or disjoint i64 %62, %26
  %65 = or disjoint i64 %64, 512
  %add.ptr108.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %65
  %kr.sroa.29.16.copyload1273 = load <4 x half>, ptr addrspace(4) %add.ptr108.1.1, align 16
  %kr.sroa.47.16.add.ptr108.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108.1.1, i64 8
  %kr.sroa.47.16.copyload1281 = load <4 x half>, ptr addrspace(4) %kr.sroa.47.16.add.ptr108.1.1.sroa_idx, align 8
  br label %if.end116.1

if.end116.1:                                      ; preds = %for.cond92.preheader.1, %if.then82.1
  %kr.sroa.47.2 = phi <4 x half> [ %kr.sroa.47.1, %if.then82.1 ], [ %kr.sroa.47.16.copyload1281, %for.cond92.preheader.1 ]
  %kr.sroa.29.2 = phi <4 x half> [ %kr.sroa.29.1, %if.then82.1 ], [ %kr.sroa.29.16.copyload1273, %for.cond92.preheader.1 ]
  %kr.sroa.20.2 = phi <4 x half> [ %kr.sroa.20.1, %if.then82.1 ], [ %kr.sroa.20.0.copyload1249, %for.cond92.preheader.1 ]
  %kr.sroa.0.2 = phi <4 x half> [ %kr.sroa.0.1, %if.then82.1 ], [ %kr.sroa.0.0.copyload1241, %for.cond92.preheader.1 ]
  br i1 %or.cond601.1, label %if.end220.1, label %if.then125.1

if.then125.1:                                     ; preds = %if.end116.1
  %cmp128.1 = icmp sgt i32 %mul11.1, %invariant.op
  br i1 %cmp128.1, label %for.cond130.preheader.1, label %if.end156.1

for.cond130.preheader.1:                          ; preds = %if.then125.1
  %add138.1 = or disjoint i32 %mul11.1, %mul137
  %cmp141.not.1625 = icmp sgt i32 %add138.1, %1
  %spec.select.1626 = select i1 %cmp141.not.1625, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert761 = insertelement <4 x float> poison, float %spec.select.1626, i64 0
  %cmp141.not.1.1.not = icmp slt i32 %add138.1, %1
  %spec.select.1.1 = select i1 %cmp141.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert862 = insertelement <4 x float> %scores.sroa.0.0.vec.insert761, float %spec.select.1.1, i64 1
  %add139.2.1 = or disjoint i32 %add138.1, 2
  %cmp141.not.2.1 = icmp sgt i32 %add139.2.1, %1
  %spec.select.2.1 = select i1 %cmp141.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert949 = insertelement <4 x float> %scores.sroa.0.4.vec.insert862, float %spec.select.2.1, i64 2
  %add139.3.1 = or disjoint i32 %add138.1, 3
  %cmp141.not.3.1 = icmp sgt i32 %add139.3.1, %1
  %spec.select.3.1 = select i1 %cmp141.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1036 = insertelement <4 x float> %scores.sroa.0.8.vec.insert949, float %spec.select.3.1, i64 3
  br label %if.end156.1

if.end156.1:                                      ; preds = %if.then125.1, %for.cond130.preheader.1
  %scores.sroa.0.3 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1036, %for.cond130.preheader.1 ], [ zeroinitializer, %if.then125.1 ]
  %66 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.2, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.3)
  %67 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.20.2, <4 x half> %qr.sroa.12.0, <4 x float> %66)
  %68 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.29.2, <4 x half> %qr.sroa.21.0, <4 x float> %67)
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.2, <4 x half> %qr.sroa.31.0, <4 x float> %68)
  %scores.sroa.0.0.vec.extract763 = extractelement <4 x float> %69, i64 0
  %mul180.1627 = fmul contract float %scores.sroa.0.0.vec.extract763, 0x3FB99999A0000000
  %70 = tail call contract noundef float @llvm.minnum.f32(float %mul180.1627, float 0x4024CB5EC0000000)
  %71 = tail call contract noundef float @llvm.exp.f32(float %70)
  %scores.sroa.0.4.vec.extract864 = extractelement <4 x float> %69, i64 1
  %mul180.1.1 = fmul contract float %scores.sroa.0.4.vec.extract864, 0x3FB99999A0000000
  %72 = tail call contract noundef float @llvm.minnum.f32(float %mul180.1.1, float 0x4024CB5EC0000000)
  %73 = tail call contract noundef float @llvm.exp.f32(float %72)
  %scores.sroa.0.8.vec.extract951 = extractelement <4 x float> %69, i64 2
  %mul180.2.1 = fmul contract float %scores.sroa.0.8.vec.extract951, 0x3FB99999A0000000
  %74 = tail call contract noundef float @llvm.minnum.f32(float %mul180.2.1, float 0x4024CB5EC0000000)
  %75 = tail call contract noundef float @llvm.exp.f32(float %74)
  %scores.sroa.0.12.vec.extract1038 = extractelement <4 x float> %69, i64 3
  %mul180.3.1 = fmul contract float %scores.sroa.0.12.vec.extract1038, 0x3FB99999A0000000
  %76 = tail call contract noundef float @llvm.minnum.f32(float %mul180.3.1, float 0x4024CB5EC0000000)
  %77 = tail call contract noundef float @llvm.exp.f32(float %76)
  %add196.1628 = fadd contract float %sums.sroa.0.2, %71
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %71)
  %probs.sroa.0.0.vec.insert1135 = insertelement <4 x i16> poison, i16 %78, i64 0
  %add196.1.1 = fadd contract float %sums.sroa.22.2, %73
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %73)
  %probs.sroa.0.2.vec.insert1169 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1135, i16 %79, i64 1
  %add196.2.1 = fadd contract float %sums.sroa.42.2, %75
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %75)
  %probs.sroa.0.4.vec.insert1202 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1169, i16 %80, i64 2
  %add196.3.1 = fadd contract float %sums.sroa.62.2, %77
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %77)
  %probs.sroa.0.6.vec.insert1218 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1202, i16 %81, i64 3
  br label %if.end220.1

if.end220.1:                                      ; preds = %if.end116.1, %if.end156.1
  %sums.sroa.62.3 = phi float [ %add196.3.1, %if.end156.1 ], [ %sums.sroa.62.2, %if.end116.1 ]
  %sums.sroa.42.3 = phi float [ %add196.2.1, %if.end156.1 ], [ %sums.sroa.42.2, %if.end116.1 ]
  %sums.sroa.22.3 = phi float [ %add196.1.1, %if.end156.1 ], [ %sums.sroa.22.2, %if.end116.1 ]
  %sums.sroa.0.3 = phi float [ %add196.1628, %if.end156.1 ], [ %sums.sroa.0.2, %if.end116.1 ]
  %probs.sroa.0.3 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1218, %if.end156.1 ], [ zeroinitializer, %if.end116.1 ]
  %add228.1 = or disjoint i32 %and226, 256
  %add.ptr230.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add228.1
  store <4 x i16> %probs.sroa.0.3, ptr addrspace(3) %add.ptr230.1, align 8
  br label %if.end231.1

if.end231.1:                                      ; preds = %if.end220.1, %if.end324
  %sums.sroa.62.4 = phi float [ %sums.sroa.62.2, %if.end324 ], [ %sums.sroa.62.3, %if.end220.1 ]
  %sums.sroa.42.4 = phi float [ %sums.sroa.42.2, %if.end324 ], [ %sums.sroa.42.3, %if.end220.1 ]
  %sums.sroa.22.4 = phi float [ %sums.sroa.22.2, %if.end324 ], [ %sums.sroa.22.3, %if.end220.1 ]
  %sums.sroa.0.4 = phi float [ %sums.sroa.0.2, %if.end324 ], [ %sums.sroa.0.3, %if.end220.1 ]
  %kr.sroa.47.3 = phi <4 x half> [ %kr.sroa.47.1, %if.end324 ], [ %kr.sroa.47.2, %if.end220.1 ]
  %kr.sroa.29.3 = phi <4 x half> [ %kr.sroa.29.1, %if.end324 ], [ %kr.sroa.29.2, %if.end220.1 ]
  %kr.sroa.20.3 = phi <4 x half> [ %kr.sroa.20.1, %if.end324 ], [ %kr.sroa.20.2, %if.end220.1 ]
  %kr.sroa.0.3 = phi <4 x half> [ %kr.sroa.0.1, %if.end324 ], [ %kr.sroa.0.2, %if.end220.1 ]
  br i1 %cmp234.not, label %if.then237.1, label %if.end324.1

if.then237.1:                                     ; preds = %if.end231.1
  %or.cond604.1 = icmp ugt i32 %mul11, 1023
  %cmp245.not.1 = icmp sgt i32 %mul11, %1
  %or.cond605.1 = or i1 %or.cond604.1, %cmp245.not.1
  br i1 %or.cond605.1, label %if.end324.1, label %for.cond285.preheader.1

for.cond285.preheader.1:                          ; preds = %if.then237.1
  %add277.1 = and i32 %and226, 252
  %add.ptr279.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add277.1
  %82 = load <4 x half>, ptr addrspace(3) %add.ptr279.1, align 8
  %83 = shl nsw i32 %cond.i.i573, 10
  %mul254.1 = and i32 %83, 64512
  %add255.1 = or disjoint i32 %mul254.1, %mul97
  %84 = zext nneg i32 %add255.1 to i64
  %85 = or disjoint i64 %84, %27
  %86 = or disjoint i64 %85, 512
  %add.ptr263.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %86
  %vr.sroa.74.16.add.ptr263.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr263.1.1, i64 8
  %vr.sroa.74.16.copyload717 = load <4 x half>, ptr addrspace(4) %vr.sroa.74.16.add.ptr263.1.1.sroa_idx, align 8
  %vr.sroa.47.16.copyload709 = load <4 x half>, ptr addrspace(4) %add.ptr263.1.1, align 16
  %87 = or disjoint i64 %84, %27
  %add.ptr263.1629 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %87
  %vr.sroa.29.0.add.ptr263.1629.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr263.1629, i64 8
  %vr.sroa.29.0.copyload667 = load <4 x half>, ptr addrspace(4) %vr.sroa.29.0.add.ptr263.1629.sroa_idx, align 8
  %vr.sroa.0.0.copyload659 = load <4 x half>, ptr addrspace(4) %add.ptr263.1629, align 16
  %88 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload659, <4 x half> %82, <4 x float> zeroinitializer), !call_argsrelate !164
  %89 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.29.0.copyload667, <4 x half> %82, <4 x float> zeroinitializer), !call_argsrelate !164
  %90 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.47.16.copyload709, <4 x half> %82, <4 x float> zeroinitializer), !call_argsrelate !164
  %91 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.74.16.copyload717, <4 x half> %82, <4 x float> zeroinitializer), !call_argsrelate !164
  br label %if.end324.1

if.end324.1:                                      ; preds = %for.cond285.preheader.1, %if.then237.1, %if.end231.1
  %out.sroa.92.2 = phi <4 x float> [ zeroinitializer, %if.end231.1 ], [ zeroinitializer, %if.then237.1 ], [ %91, %for.cond285.preheader.1 ]
  %out.sroa.62.2 = phi <4 x float> [ zeroinitializer, %if.end231.1 ], [ zeroinitializer, %if.then237.1 ], [ %90, %for.cond285.preheader.1 ]
  %out.sroa.32.2 = phi <4 x float> [ zeroinitializer, %if.end231.1 ], [ zeroinitializer, %if.then237.1 ], [ %89, %for.cond285.preheader.1 ]
  %out.sroa.0.2 = phi <4 x float> [ zeroinitializer, %if.end231.1 ], [ zeroinitializer, %if.then237.1 ], [ %88, %for.cond285.preheader.1 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %cmp80, label %if.end231.2, label %if.then82.2

if.then82.2:                                      ; preds = %if.end324.1
  %or.cond600.2 = icmp ugt i32 %mul11.2, 1023
  %cmp90.not.2 = icmp sgt i32 %mul11.2, %1
  %or.cond601.2 = or i1 %or.cond600.2, %cmp90.not.2
  br i1 %or.cond601.2, label %if.end116.2, label %for.cond92.preheader.2

for.cond92.preheader.2:                           ; preds = %if.then82.2
  %92 = shl nsw i32 %cond.i.i573.2, 10
  %mul99.2 = and i32 %92, 64512
  %add100.2 = or disjoint i32 %mul99.2, %mul97
  %93 = zext nneg i32 %add100.2 to i64
  %94 = or disjoint i64 %93, %26
  %add.ptr108.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %94
  %kr.sroa.0.0.copyload1242 = load <4 x half>, ptr addrspace(4) %add.ptr108.2, align 16
  %kr.sroa.20.0.add.ptr108.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108.2, i64 8
  %kr.sroa.20.0.copyload1250 = load <4 x half>, ptr addrspace(4) %kr.sroa.20.0.add.ptr108.2.sroa_idx, align 8
  %95 = or disjoint i64 %93, %26
  %96 = or disjoint i64 %95, 512
  %add.ptr108.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %96
  %kr.sroa.29.16.copyload1274 = load <4 x half>, ptr addrspace(4) %add.ptr108.1.2, align 16
  %kr.sroa.47.16.add.ptr108.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108.1.2, i64 8
  %kr.sroa.47.16.copyload1282 = load <4 x half>, ptr addrspace(4) %kr.sroa.47.16.add.ptr108.1.2.sroa_idx, align 8
  br label %if.end116.2

if.end116.2:                                      ; preds = %for.cond92.preheader.2, %if.then82.2
  %kr.sroa.47.4 = phi <4 x half> [ %kr.sroa.47.3, %if.then82.2 ], [ %kr.sroa.47.16.copyload1282, %for.cond92.preheader.2 ]
  %kr.sroa.29.4 = phi <4 x half> [ %kr.sroa.29.3, %if.then82.2 ], [ %kr.sroa.29.16.copyload1274, %for.cond92.preheader.2 ]
  %kr.sroa.20.4 = phi <4 x half> [ %kr.sroa.20.3, %if.then82.2 ], [ %kr.sroa.20.0.copyload1250, %for.cond92.preheader.2 ]
  %kr.sroa.0.4 = phi <4 x half> [ %kr.sroa.0.3, %if.then82.2 ], [ %kr.sroa.0.0.copyload1242, %for.cond92.preheader.2 ]
  br i1 %or.cond601.2, label %if.end220.2, label %if.then125.2

if.then125.2:                                     ; preds = %if.end116.2
  %cmp128.2 = icmp sgt i32 %mul11.2, %invariant.op
  br i1 %cmp128.2, label %for.cond130.preheader.2, label %if.end156.2

for.cond130.preheader.2:                          ; preds = %if.then125.2
  %add138.2 = or disjoint i32 %mul11.2, %mul137
  %cmp141.not.2630 = icmp sgt i32 %add138.2, %1
  %spec.select.2631 = select i1 %cmp141.not.2630, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert771 = insertelement <4 x float> poison, float %spec.select.2631, i64 0
  %cmp141.not.1.2.not = icmp slt i32 %add138.2, %1
  %spec.select.1.2 = select i1 %cmp141.not.1.2.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert870 = insertelement <4 x float> %scores.sroa.0.0.vec.insert771, float %spec.select.1.2, i64 1
  %add139.2.2 = or disjoint i32 %add138.2, 2
  %cmp141.not.2.2 = icmp sgt i32 %add139.2.2, %1
  %spec.select.2.2 = select i1 %cmp141.not.2.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert957 = insertelement <4 x float> %scores.sroa.0.4.vec.insert870, float %spec.select.2.2, i64 2
  %add139.3.2 = or disjoint i32 %add138.2, 3
  %cmp141.not.3.2 = icmp sgt i32 %add139.3.2, %1
  %spec.select.3.2 = select i1 %cmp141.not.3.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1044 = insertelement <4 x float> %scores.sroa.0.8.vec.insert957, float %spec.select.3.2, i64 3
  br label %if.end156.2

if.end156.2:                                      ; preds = %if.then125.2, %for.cond130.preheader.2
  %scores.sroa.0.6 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1044, %for.cond130.preheader.2 ], [ zeroinitializer, %if.then125.2 ]
  %97 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.4, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.6)
  %98 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.20.4, <4 x half> %qr.sroa.12.0, <4 x float> %97)
  %99 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.29.4, <4 x half> %qr.sroa.21.0, <4 x float> %98)
  %100 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.4, <4 x half> %qr.sroa.31.0, <4 x float> %99)
  %scores.sroa.0.0.vec.extract773 = extractelement <4 x float> %100, i64 0
  %mul180.2632 = fmul contract float %scores.sroa.0.0.vec.extract773, 0x3FB99999A0000000
  %101 = tail call contract noundef float @llvm.minnum.f32(float %mul180.2632, float 0x4024CB5EC0000000)
  %102 = tail call contract noundef float @llvm.exp.f32(float %101)
  %scores.sroa.0.4.vec.extract872 = extractelement <4 x float> %100, i64 1
  %mul180.1.2 = fmul contract float %scores.sroa.0.4.vec.extract872, 0x3FB99999A0000000
  %103 = tail call contract noundef float @llvm.minnum.f32(float %mul180.1.2, float 0x4024CB5EC0000000)
  %104 = tail call contract noundef float @llvm.exp.f32(float %103)
  %scores.sroa.0.8.vec.extract959 = extractelement <4 x float> %100, i64 2
  %mul180.2.2 = fmul contract float %scores.sroa.0.8.vec.extract959, 0x3FB99999A0000000
  %105 = tail call contract noundef float @llvm.minnum.f32(float %mul180.2.2, float 0x4024CB5EC0000000)
  %106 = tail call contract noundef float @llvm.exp.f32(float %105)
  %scores.sroa.0.12.vec.extract1046 = extractelement <4 x float> %100, i64 3
  %mul180.3.2 = fmul contract float %scores.sroa.0.12.vec.extract1046, 0x3FB99999A0000000
  %107 = tail call contract noundef float @llvm.minnum.f32(float %mul180.3.2, float 0x4024CB5EC0000000)
  %108 = tail call contract noundef float @llvm.exp.f32(float %107)
  %add196.2633 = fadd contract float %sums.sroa.0.4, %102
  %109 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %102)
  %probs.sroa.0.0.vec.insert1137 = insertelement <4 x i16> poison, i16 %109, i64 0
  %add196.1.2 = fadd contract float %sums.sroa.22.4, %104
  %110 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %104)
  %probs.sroa.0.2.vec.insert1171 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1137, i16 %110, i64 1
  %add196.2.2 = fadd contract float %sums.sroa.42.4, %106
  %111 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %106)
  %probs.sroa.0.4.vec.insert1204 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1171, i16 %111, i64 2
  %add196.3.2 = fadd contract float %sums.sroa.62.4, %108
  %112 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %108)
  %probs.sroa.0.6.vec.insert1220 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1204, i16 %112, i64 3
  br label %if.end220.2

if.end220.2:                                      ; preds = %if.end116.2, %if.end156.2
  %sums.sroa.62.5 = phi float [ %add196.3.2, %if.end156.2 ], [ %sums.sroa.62.4, %if.end116.2 ]
  %sums.sroa.42.5 = phi float [ %add196.2.2, %if.end156.2 ], [ %sums.sroa.42.4, %if.end116.2 ]
  %sums.sroa.22.5 = phi float [ %add196.1.2, %if.end156.2 ], [ %sums.sroa.22.4, %if.end116.2 ]
  %sums.sroa.0.5 = phi float [ %add196.2633, %if.end156.2 ], [ %sums.sroa.0.4, %if.end116.2 ]
  %probs.sroa.0.6 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1220, %if.end156.2 ], [ zeroinitializer, %if.end116.2 ]
  %add.ptr230.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and226
  store <4 x i16> %probs.sroa.0.6, ptr addrspace(3) %add.ptr230.2, align 8
  br label %if.end231.2

if.end231.2:                                      ; preds = %if.end220.2, %if.end324.1
  %sums.sroa.62.6 = phi float [ %sums.sroa.62.4, %if.end324.1 ], [ %sums.sroa.62.5, %if.end220.2 ]
  %sums.sroa.42.6 = phi float [ %sums.sroa.42.4, %if.end324.1 ], [ %sums.sroa.42.5, %if.end220.2 ]
  %sums.sroa.22.6 = phi float [ %sums.sroa.22.4, %if.end324.1 ], [ %sums.sroa.22.5, %if.end220.2 ]
  %sums.sroa.0.6 = phi float [ %sums.sroa.0.4, %if.end324.1 ], [ %sums.sroa.0.5, %if.end220.2 ]
  %kr.sroa.47.5 = phi <4 x half> [ %kr.sroa.47.3, %if.end324.1 ], [ %kr.sroa.47.4, %if.end220.2 ]
  %kr.sroa.29.5 = phi <4 x half> [ %kr.sroa.29.3, %if.end324.1 ], [ %kr.sroa.29.4, %if.end220.2 ]
  %kr.sroa.20.5 = phi <4 x half> [ %kr.sroa.20.3, %if.end324.1 ], [ %kr.sroa.20.4, %if.end220.2 ]
  %kr.sroa.0.5 = phi <4 x half> [ %kr.sroa.0.3, %if.end324.1 ], [ %kr.sroa.0.4, %if.end220.2 ]
  br i1 %cmp234.not, label %if.then237.2, label %if.end324.2

if.then237.2:                                     ; preds = %if.end231.2
  %or.cond604.2 = icmp ugt i32 %mul11.1, 1023
  %cmp245.not.2 = icmp sgt i32 %mul11.1, %1
  %or.cond605.2 = or i1 %or.cond604.2, %cmp245.not.2
  br i1 %or.cond605.2, label %if.end324.2, label %for.cond304.preheader.2

for.cond304.preheader.2:                          ; preds = %if.then237.2
  %add.ptr279.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and226
  %113 = load <4 x half>, ptr addrspace(3) %add.ptr279.2, align 8
  %114 = shl nsw i32 %cond.i.i573.1, 10
  %mul254.2 = and i32 %114, 64512
  %add255.2 = or disjoint i32 %mul254.2, %mul97
  %115 = zext nneg i32 %add255.2 to i64
  %116 = or disjoint i64 %115, %27
  %117 = or disjoint i64 %116, 512
  %add.ptr263.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %117
  %vr.sroa.74.16.add.ptr263.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr263.1.2, i64 8
  %vr.sroa.74.16.copyload718 = load <4 x half>, ptr addrspace(4) %vr.sroa.74.16.add.ptr263.1.2.sroa_idx, align 8
  %vr.sroa.47.16.copyload710 = load <4 x half>, ptr addrspace(4) %add.ptr263.1.2, align 16
  %118 = or disjoint i64 %115, %27
  %add.ptr263.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %118
  %vr.sroa.29.0.add.ptr263.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr263.2, i64 8
  %vr.sroa.29.0.copyload668 = load <4 x half>, ptr addrspace(4) %vr.sroa.29.0.add.ptr263.2.sroa_idx, align 8
  %vr.sroa.0.0.copyload660 = load <4 x half>, ptr addrspace(4) %add.ptr263.2, align 16
  %119 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload660, <4 x half> %113, <4 x float> zeroinitializer), !call_argsrelate !164
  %120 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.29.0.copyload668, <4 x half> %113, <4 x float> zeroinitializer), !call_argsrelate !164
  %121 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.47.16.copyload710, <4 x half> %113, <4 x float> zeroinitializer), !call_argsrelate !164
  %122 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.74.16.copyload718, <4 x half> %113, <4 x float> zeroinitializer), !call_argsrelate !164
  br label %if.end324.2

if.end324.2:                                      ; preds = %for.cond304.preheader.2, %if.then237.2, %if.end231.2
  %out_1.sroa.80.3 = phi <4 x float> [ zeroinitializer, %if.end231.2 ], [ zeroinitializer, %if.then237.2 ], [ %122, %for.cond304.preheader.2 ]
  %out_1.sroa.54.3 = phi <4 x float> [ zeroinitializer, %if.end231.2 ], [ zeroinitializer, %if.then237.2 ], [ %121, %for.cond304.preheader.2 ]
  %out_1.sroa.28.3 = phi <4 x float> [ zeroinitializer, %if.end231.2 ], [ zeroinitializer, %if.then237.2 ], [ %120, %for.cond304.preheader.2 ]
  %out_1.sroa.0.3 = phi <4 x float> [ zeroinitializer, %if.end231.2 ], [ zeroinitializer, %if.then237.2 ], [ %119, %for.cond304.preheader.2 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %cmp80, label %if.end231.3, label %if.then82.3

if.then82.3:                                      ; preds = %if.end324.2
  %or.cond600.3 = icmp ugt i32 %mul11.3, 1023
  %cmp90.not.3 = icmp sgt i32 %mul11.3, %1
  %or.cond601.3 = or i1 %or.cond600.3, %cmp90.not.3
  br i1 %or.cond601.3, label %if.end116.3, label %for.cond92.preheader.3

for.cond92.preheader.3:                           ; preds = %if.then82.3
  %123 = shl nsw i32 %cond.i.i573.3, 10
  %mul99.3 = and i32 %123, 64512
  %add100.3 = or disjoint i32 %mul99.3, %mul97
  %124 = zext nneg i32 %add100.3 to i64
  %125 = or disjoint i64 %124, %26
  %add.ptr108.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %125
  %kr.sroa.0.0.copyload1243 = load <4 x half>, ptr addrspace(4) %add.ptr108.3, align 16
  %kr.sroa.20.0.add.ptr108.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108.3, i64 8
  %kr.sroa.20.0.copyload1251 = load <4 x half>, ptr addrspace(4) %kr.sroa.20.0.add.ptr108.3.sroa_idx, align 8
  %126 = or disjoint i64 %124, %26
  %127 = or disjoint i64 %126, 512
  %add.ptr108.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %127
  %kr.sroa.29.16.copyload1275 = load <4 x half>, ptr addrspace(4) %add.ptr108.1.3, align 16
  %kr.sroa.47.16.add.ptr108.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108.1.3, i64 8
  %kr.sroa.47.16.copyload1283 = load <4 x half>, ptr addrspace(4) %kr.sroa.47.16.add.ptr108.1.3.sroa_idx, align 8
  br label %if.end116.3

if.end116.3:                                      ; preds = %for.cond92.preheader.3, %if.then82.3
  %kr.sroa.47.6 = phi <4 x half> [ %kr.sroa.47.5, %if.then82.3 ], [ %kr.sroa.47.16.copyload1283, %for.cond92.preheader.3 ]
  %kr.sroa.29.6 = phi <4 x half> [ %kr.sroa.29.5, %if.then82.3 ], [ %kr.sroa.29.16.copyload1275, %for.cond92.preheader.3 ]
  %kr.sroa.20.6 = phi <4 x half> [ %kr.sroa.20.5, %if.then82.3 ], [ %kr.sroa.20.0.copyload1251, %for.cond92.preheader.3 ]
  %kr.sroa.0.6 = phi <4 x half> [ %kr.sroa.0.5, %if.then82.3 ], [ %kr.sroa.0.0.copyload1243, %for.cond92.preheader.3 ]
  br i1 %or.cond601.3, label %if.end220.3, label %if.then125.3

if.then125.3:                                     ; preds = %if.end116.3
  %cmp128.3 = icmp sgt i32 %mul11.3, %invariant.op
  br i1 %cmp128.3, label %for.cond130.preheader.3, label %if.end156.3

for.cond130.preheader.3:                          ; preds = %if.then125.3
  %add138.3 = or disjoint i32 %mul11.3, %mul137
  %cmp141.not.3634 = icmp sgt i32 %add138.3, %1
  %spec.select.3635 = select i1 %cmp141.not.3634, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert781 = insertelement <4 x float> poison, float %spec.select.3635, i64 0
  %cmp141.not.1.3.not = icmp slt i32 %add138.3, %1
  %spec.select.1.3 = select i1 %cmp141.not.1.3.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert878 = insertelement <4 x float> %scores.sroa.0.0.vec.insert781, float %spec.select.1.3, i64 1
  %add139.2.3 = or disjoint i32 %add138.3, 2
  %cmp141.not.2.3 = icmp sgt i32 %add139.2.3, %1
  %spec.select.2.3 = select i1 %cmp141.not.2.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert965 = insertelement <4 x float> %scores.sroa.0.4.vec.insert878, float %spec.select.2.3, i64 2
  %add139.3.3 = or disjoint i32 %add138.3, 3
  %cmp141.not.3.3 = icmp sgt i32 %add139.3.3, %1
  %spec.select.3.3 = select i1 %cmp141.not.3.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1052 = insertelement <4 x float> %scores.sroa.0.8.vec.insert965, float %spec.select.3.3, i64 3
  br label %if.end156.3

if.end156.3:                                      ; preds = %if.then125.3, %for.cond130.preheader.3
  %scores.sroa.0.9 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1052, %for.cond130.preheader.3 ], [ zeroinitializer, %if.then125.3 ]
  %128 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.6, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.9)
  %129 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.20.6, <4 x half> %qr.sroa.12.0, <4 x float> %128)
  %130 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.29.6, <4 x half> %qr.sroa.21.0, <4 x float> %129)
  %131 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.6, <4 x half> %qr.sroa.31.0, <4 x float> %130)
  %scores.sroa.0.0.vec.extract783 = extractelement <4 x float> %131, i64 0
  %mul180.3636 = fmul contract float %scores.sroa.0.0.vec.extract783, 0x3FB99999A0000000
  %132 = tail call contract noundef float @llvm.minnum.f32(float %mul180.3636, float 0x4024CB5EC0000000)
  %133 = tail call contract noundef float @llvm.exp.f32(float %132)
  %scores.sroa.0.4.vec.extract880 = extractelement <4 x float> %131, i64 1
  %mul180.1.3 = fmul contract float %scores.sroa.0.4.vec.extract880, 0x3FB99999A0000000
  %134 = tail call contract noundef float @llvm.minnum.f32(float %mul180.1.3, float 0x4024CB5EC0000000)
  %135 = tail call contract noundef float @llvm.exp.f32(float %134)
  %scores.sroa.0.8.vec.extract967 = extractelement <4 x float> %131, i64 2
  %mul180.2.3 = fmul contract float %scores.sroa.0.8.vec.extract967, 0x3FB99999A0000000
  %136 = tail call contract noundef float @llvm.minnum.f32(float %mul180.2.3, float 0x4024CB5EC0000000)
  %137 = tail call contract noundef float @llvm.exp.f32(float %136)
  %scores.sroa.0.12.vec.extract1054 = extractelement <4 x float> %131, i64 3
  %mul180.3.3 = fmul contract float %scores.sroa.0.12.vec.extract1054, 0x3FB99999A0000000
  %138 = tail call contract noundef float @llvm.minnum.f32(float %mul180.3.3, float 0x4024CB5EC0000000)
  %139 = tail call contract noundef float @llvm.exp.f32(float %138)
  %add196.3637 = fadd contract float %sums.sroa.0.6, %133
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %133)
  %probs.sroa.0.0.vec.insert1139 = insertelement <4 x i16> poison, i16 %140, i64 0
  %add196.1.3 = fadd contract float %sums.sroa.22.6, %135
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %135)
  %probs.sroa.0.2.vec.insert1173 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1139, i16 %141, i64 1
  %add196.2.3 = fadd contract float %sums.sroa.42.6, %137
  %142 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %137)
  %probs.sroa.0.4.vec.insert1206 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1173, i16 %142, i64 2
  %add196.3.3 = fadd contract float %sums.sroa.62.6, %139
  %143 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %139)
  %probs.sroa.0.6.vec.insert1222 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1206, i16 %143, i64 3
  br label %if.end220.3

if.end220.3:                                      ; preds = %if.end116.3, %if.end156.3
  %sums.sroa.62.7 = phi float [ %add196.3.3, %if.end156.3 ], [ %sums.sroa.62.6, %if.end116.3 ]
  %sums.sroa.42.7 = phi float [ %add196.2.3, %if.end156.3 ], [ %sums.sroa.42.6, %if.end116.3 ]
  %sums.sroa.22.7 = phi float [ %add196.1.3, %if.end156.3 ], [ %sums.sroa.22.6, %if.end116.3 ]
  %sums.sroa.0.7 = phi float [ %add196.3637, %if.end156.3 ], [ %sums.sroa.0.6, %if.end116.3 ]
  %probs.sroa.0.9 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1222, %if.end156.3 ], [ zeroinitializer, %if.end116.3 ]
  %add228.3 = or disjoint i32 %and226, 256
  %add.ptr230.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add228.3
  store <4 x i16> %probs.sroa.0.9, ptr addrspace(3) %add.ptr230.3, align 8
  br label %if.end231.3

if.end231.3:                                      ; preds = %if.end220.3, %if.end324.2
  %sums.sroa.62.8 = phi float [ %sums.sroa.62.6, %if.end324.2 ], [ %sums.sroa.62.7, %if.end220.3 ]
  %sums.sroa.42.8 = phi float [ %sums.sroa.42.6, %if.end324.2 ], [ %sums.sroa.42.7, %if.end220.3 ]
  %sums.sroa.22.8 = phi float [ %sums.sroa.22.6, %if.end324.2 ], [ %sums.sroa.22.7, %if.end220.3 ]
  %sums.sroa.0.8 = phi float [ %sums.sroa.0.6, %if.end324.2 ], [ %sums.sroa.0.7, %if.end220.3 ]
  %kr.sroa.47.7 = phi <4 x half> [ %kr.sroa.47.5, %if.end324.2 ], [ %kr.sroa.47.6, %if.end220.3 ]
  %kr.sroa.29.7 = phi <4 x half> [ %kr.sroa.29.5, %if.end324.2 ], [ %kr.sroa.29.6, %if.end220.3 ]
  %kr.sroa.20.7 = phi <4 x half> [ %kr.sroa.20.5, %if.end324.2 ], [ %kr.sroa.20.6, %if.end220.3 ]
  %kr.sroa.0.7 = phi <4 x half> [ %kr.sroa.0.5, %if.end324.2 ], [ %kr.sroa.0.6, %if.end220.3 ]
  br i1 %cmp234.not, label %if.then237.3, label %if.end324.3

if.then237.3:                                     ; preds = %if.end231.3
  %or.cond604.3 = icmp ugt i32 %mul11.2, 1023
  %cmp245.not.3 = icmp sgt i32 %mul11.2, %1
  %or.cond605.3 = or i1 %or.cond604.3, %cmp245.not.3
  br i1 %or.cond605.3, label %if.end324.3, label %for.cond285.preheader.3

for.cond285.preheader.3:                          ; preds = %if.then237.3
  %add277.3 = and i32 %and226, 252
  %add.ptr279.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add277.3
  %144 = load <4 x half>, ptr addrspace(3) %add.ptr279.3, align 8
  %145 = shl nsw i32 %cond.i.i573.2, 10
  %mul254.3 = and i32 %145, 64512
  %add255.3 = or disjoint i32 %mul254.3, %mul97
  %146 = zext nneg i32 %add255.3 to i64
  %147 = or disjoint i64 %146, %27
  %148 = or disjoint i64 %147, 512
  %add.ptr263.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %148
  %vr.sroa.74.16.add.ptr263.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr263.1.3, i64 8
  %vr.sroa.74.16.copyload719 = load <4 x half>, ptr addrspace(4) %vr.sroa.74.16.add.ptr263.1.3.sroa_idx, align 8
  %vr.sroa.47.16.copyload711 = load <4 x half>, ptr addrspace(4) %add.ptr263.1.3, align 16
  %149 = or disjoint i64 %146, %27
  %add.ptr263.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %149
  %vr.sroa.29.0.add.ptr263.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr263.3, i64 8
  %vr.sroa.29.0.copyload669 = load <4 x half>, ptr addrspace(4) %vr.sroa.29.0.add.ptr263.3.sroa_idx, align 8
  %vr.sroa.0.0.copyload661 = load <4 x half>, ptr addrspace(4) %add.ptr263.3, align 16
  %150 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload661, <4 x half> %144, <4 x float> %out.sroa.0.2), !call_argsrelate !164
  %151 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.29.0.copyload669, <4 x half> %144, <4 x float> %out.sroa.32.2), !call_argsrelate !164
  %152 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.47.16.copyload711, <4 x half> %144, <4 x float> %out.sroa.62.2), !call_argsrelate !164
  %153 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.74.16.copyload719, <4 x half> %144, <4 x float> %out.sroa.92.2), !call_argsrelate !164
  br label %if.end324.3

if.end324.3:                                      ; preds = %for.cond285.preheader.3, %if.then237.3, %if.end231.3
  %out.sroa.92.4 = phi <4 x float> [ %out.sroa.92.2, %if.end231.3 ], [ %out.sroa.92.2, %if.then237.3 ], [ %153, %for.cond285.preheader.3 ]
  %out.sroa.62.4 = phi <4 x float> [ %out.sroa.62.2, %if.end231.3 ], [ %out.sroa.62.2, %if.then237.3 ], [ %152, %for.cond285.preheader.3 ]
  %out.sroa.32.4 = phi <4 x float> [ %out.sroa.32.2, %if.end231.3 ], [ %out.sroa.32.2, %if.then237.3 ], [ %151, %for.cond285.preheader.3 ]
  %out.sroa.0.4 = phi <4 x float> [ %out.sroa.0.2, %if.end231.3 ], [ %out.sroa.0.2, %if.then237.3 ], [ %150, %for.cond285.preheader.3 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %cmp80, label %if.end231.4, label %if.then82.4

if.then82.4:                                      ; preds = %if.end324.3
  %or.cond600.4 = icmp ugt i32 %mul11.4, 1023
  %cmp90.not.4 = icmp sgt i32 %mul11.4, %1
  %or.cond601.4 = or i1 %or.cond600.4, %cmp90.not.4
  br i1 %or.cond601.4, label %if.end116.4, label %for.cond92.preheader.4

for.cond92.preheader.4:                           ; preds = %if.then82.4
  %154 = shl nsw i32 %cond.i.i573.4, 10
  %mul99.4 = and i32 %154, 64512
  %add100.4 = or disjoint i32 %mul99.4, %mul97
  %155 = zext nneg i32 %add100.4 to i64
  %156 = or disjoint i64 %155, %26
  %add.ptr108.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %156
  %kr.sroa.0.0.copyload1244 = load <4 x half>, ptr addrspace(4) %add.ptr108.4, align 16
  %kr.sroa.20.0.add.ptr108.4.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108.4, i64 8
  %kr.sroa.20.0.copyload1252 = load <4 x half>, ptr addrspace(4) %kr.sroa.20.0.add.ptr108.4.sroa_idx, align 8
  %157 = or disjoint i64 %155, %26
  %158 = or disjoint i64 %157, 512
  %add.ptr108.1.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %158
  %kr.sroa.29.16.copyload1276 = load <4 x half>, ptr addrspace(4) %add.ptr108.1.4, align 16
  %kr.sroa.47.16.add.ptr108.1.4.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108.1.4, i64 8
  %kr.sroa.47.16.copyload1284 = load <4 x half>, ptr addrspace(4) %kr.sroa.47.16.add.ptr108.1.4.sroa_idx, align 8
  br label %if.end116.4

if.end116.4:                                      ; preds = %for.cond92.preheader.4, %if.then82.4
  %kr.sroa.47.8 = phi <4 x half> [ %kr.sroa.47.7, %if.then82.4 ], [ %kr.sroa.47.16.copyload1284, %for.cond92.preheader.4 ]
  %kr.sroa.29.8 = phi <4 x half> [ %kr.sroa.29.7, %if.then82.4 ], [ %kr.sroa.29.16.copyload1276, %for.cond92.preheader.4 ]
  %kr.sroa.20.8 = phi <4 x half> [ %kr.sroa.20.7, %if.then82.4 ], [ %kr.sroa.20.0.copyload1252, %for.cond92.preheader.4 ]
  %kr.sroa.0.8 = phi <4 x half> [ %kr.sroa.0.7, %if.then82.4 ], [ %kr.sroa.0.0.copyload1244, %for.cond92.preheader.4 ]
  br i1 %or.cond601.4, label %if.end220.4, label %if.then125.4

if.then125.4:                                     ; preds = %if.end116.4
  %cmp128.4 = icmp sgt i32 %mul11.4, %invariant.op
  br i1 %cmp128.4, label %for.cond130.preheader.4, label %if.end156.4

for.cond130.preheader.4:                          ; preds = %if.then125.4
  %add138.4 = or disjoint i32 %mul11.4, %mul137
  %cmp141.not.4 = icmp sgt i32 %add138.4, %1
  %spec.select.4 = select i1 %cmp141.not.4, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert791 = insertelement <4 x float> poison, float %spec.select.4, i64 0
  %cmp141.not.1.4.not = icmp slt i32 %add138.4, %1
  %spec.select.1.4 = select i1 %cmp141.not.1.4.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert886 = insertelement <4 x float> %scores.sroa.0.0.vec.insert791, float %spec.select.1.4, i64 1
  %add139.2.4 = or disjoint i32 %add138.4, 2
  %cmp141.not.2.4 = icmp sgt i32 %add139.2.4, %1
  %spec.select.2.4 = select i1 %cmp141.not.2.4, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert973 = insertelement <4 x float> %scores.sroa.0.4.vec.insert886, float %spec.select.2.4, i64 2
  %add139.3.4 = or disjoint i32 %add138.4, 3
  %cmp141.not.3.4 = icmp sgt i32 %add139.3.4, %1
  %spec.select.3.4 = select i1 %cmp141.not.3.4, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1060 = insertelement <4 x float> %scores.sroa.0.8.vec.insert973, float %spec.select.3.4, i64 3
  br label %if.end156.4

if.end156.4:                                      ; preds = %if.then125.4, %for.cond130.preheader.4
  %scores.sroa.0.12 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1060, %for.cond130.preheader.4 ], [ zeroinitializer, %if.then125.4 ]
  %159 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.8, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.12)
  %160 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.20.8, <4 x half> %qr.sroa.12.0, <4 x float> %159)
  %161 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.29.8, <4 x half> %qr.sroa.21.0, <4 x float> %160)
  %162 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.8, <4 x half> %qr.sroa.31.0, <4 x float> %161)
  %scores.sroa.0.0.vec.extract793 = extractelement <4 x float> %162, i64 0
  %mul180.4 = fmul contract float %scores.sroa.0.0.vec.extract793, 0x3FB99999A0000000
  %163 = tail call contract noundef float @llvm.minnum.f32(float %mul180.4, float 0x4024CB5EC0000000)
  %164 = tail call contract noundef float @llvm.exp.f32(float %163)
  %scores.sroa.0.4.vec.extract888 = extractelement <4 x float> %162, i64 1
  %mul180.1.4 = fmul contract float %scores.sroa.0.4.vec.extract888, 0x3FB99999A0000000
  %165 = tail call contract noundef float @llvm.minnum.f32(float %mul180.1.4, float 0x4024CB5EC0000000)
  %166 = tail call contract noundef float @llvm.exp.f32(float %165)
  %scores.sroa.0.8.vec.extract975 = extractelement <4 x float> %162, i64 2
  %mul180.2.4 = fmul contract float %scores.sroa.0.8.vec.extract975, 0x3FB99999A0000000
  %167 = tail call contract noundef float @llvm.minnum.f32(float %mul180.2.4, float 0x4024CB5EC0000000)
  %168 = tail call contract noundef float @llvm.exp.f32(float %167)
  %scores.sroa.0.12.vec.extract1062 = extractelement <4 x float> %162, i64 3
  %mul180.3.4 = fmul contract float %scores.sroa.0.12.vec.extract1062, 0x3FB99999A0000000
  %169 = tail call contract noundef float @llvm.minnum.f32(float %mul180.3.4, float 0x4024CB5EC0000000)
  %170 = tail call contract noundef float @llvm.exp.f32(float %169)
  %add196.4 = fadd contract float %sums.sroa.0.8, %164
  %171 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %164)
  %probs.sroa.0.0.vec.insert1141 = insertelement <4 x i16> poison, i16 %171, i64 0
  %add196.1.4 = fadd contract float %sums.sroa.22.8, %166
  %172 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %166)
  %probs.sroa.0.2.vec.insert1175 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1141, i16 %172, i64 1
  %add196.2.4 = fadd contract float %sums.sroa.42.8, %168
  %173 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %168)
  %probs.sroa.0.4.vec.insert1208 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1175, i16 %173, i64 2
  %add196.3.4 = fadd contract float %sums.sroa.62.8, %170
  %174 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %170)
  %probs.sroa.0.6.vec.insert1224 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1208, i16 %174, i64 3
  br label %if.end220.4

if.end220.4:                                      ; preds = %if.end116.4, %if.end156.4
  %sums.sroa.62.9 = phi float [ %add196.3.4, %if.end156.4 ], [ %sums.sroa.62.8, %if.end116.4 ]
  %sums.sroa.42.9 = phi float [ %add196.2.4, %if.end156.4 ], [ %sums.sroa.42.8, %if.end116.4 ]
  %sums.sroa.22.9 = phi float [ %add196.1.4, %if.end156.4 ], [ %sums.sroa.22.8, %if.end116.4 ]
  %sums.sroa.0.9 = phi float [ %add196.4, %if.end156.4 ], [ %sums.sroa.0.8, %if.end116.4 ]
  %probs.sroa.0.12 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1224, %if.end156.4 ], [ zeroinitializer, %if.end116.4 ]
  %add.ptr230.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and226
  store <4 x i16> %probs.sroa.0.12, ptr addrspace(3) %add.ptr230.4, align 8
  br label %if.end231.4

if.end231.4:                                      ; preds = %if.end220.4, %if.end324.3
  %sums.sroa.62.10 = phi float [ %sums.sroa.62.8, %if.end324.3 ], [ %sums.sroa.62.9, %if.end220.4 ]
  %sums.sroa.42.10 = phi float [ %sums.sroa.42.8, %if.end324.3 ], [ %sums.sroa.42.9, %if.end220.4 ]
  %sums.sroa.22.10 = phi float [ %sums.sroa.22.8, %if.end324.3 ], [ %sums.sroa.22.9, %if.end220.4 ]
  %sums.sroa.0.10 = phi float [ %sums.sroa.0.8, %if.end324.3 ], [ %sums.sroa.0.9, %if.end220.4 ]
  %kr.sroa.47.9 = phi <4 x half> [ %kr.sroa.47.7, %if.end324.3 ], [ %kr.sroa.47.8, %if.end220.4 ]
  %kr.sroa.29.9 = phi <4 x half> [ %kr.sroa.29.7, %if.end324.3 ], [ %kr.sroa.29.8, %if.end220.4 ]
  %kr.sroa.20.9 = phi <4 x half> [ %kr.sroa.20.7, %if.end324.3 ], [ %kr.sroa.20.8, %if.end220.4 ]
  %kr.sroa.0.9 = phi <4 x half> [ %kr.sroa.0.7, %if.end324.3 ], [ %kr.sroa.0.8, %if.end220.4 ]
  br i1 %cmp234.not, label %if.then237.4, label %if.end324.4

if.then237.4:                                     ; preds = %if.end231.4
  %or.cond604.4 = icmp ugt i32 %mul11.3, 1023
  %cmp245.not.4 = icmp sgt i32 %mul11.3, %1
  %or.cond605.4 = or i1 %or.cond604.4, %cmp245.not.4
  br i1 %or.cond605.4, label %if.end324.4, label %for.cond304.preheader.4

for.cond304.preheader.4:                          ; preds = %if.then237.4
  %add.ptr279.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and226
  %175 = load <4 x half>, ptr addrspace(3) %add.ptr279.4, align 8
  %176 = shl nsw i32 %cond.i.i573.3, 10
  %mul254.4 = and i32 %176, 64512
  %add255.4 = or disjoint i32 %mul254.4, %mul97
  %177 = zext nneg i32 %add255.4 to i64
  %178 = or disjoint i64 %177, %27
  %179 = or disjoint i64 %178, 512
  %add.ptr263.1.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %179
  %vr.sroa.74.16.add.ptr263.1.4.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr263.1.4, i64 8
  %vr.sroa.74.16.copyload720 = load <4 x half>, ptr addrspace(4) %vr.sroa.74.16.add.ptr263.1.4.sroa_idx, align 8
  %vr.sroa.47.16.copyload712 = load <4 x half>, ptr addrspace(4) %add.ptr263.1.4, align 16
  %180 = or disjoint i64 %177, %27
  %add.ptr263.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %180
  %vr.sroa.29.0.add.ptr263.4.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr263.4, i64 8
  %vr.sroa.29.0.copyload670 = load <4 x half>, ptr addrspace(4) %vr.sroa.29.0.add.ptr263.4.sroa_idx, align 8
  %vr.sroa.0.0.copyload662 = load <4 x half>, ptr addrspace(4) %add.ptr263.4, align 16
  %181 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload662, <4 x half> %175, <4 x float> %out_1.sroa.0.3), !call_argsrelate !164
  %182 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.29.0.copyload670, <4 x half> %175, <4 x float> %out_1.sroa.28.3), !call_argsrelate !164
  %183 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.47.16.copyload712, <4 x half> %175, <4 x float> %out_1.sroa.54.3), !call_argsrelate !164
  %184 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.74.16.copyload720, <4 x half> %175, <4 x float> %out_1.sroa.80.3), !call_argsrelate !164
  br label %if.end324.4

if.end324.4:                                      ; preds = %for.cond304.preheader.4, %if.then237.4, %if.end231.4
  %out_1.sroa.80.5 = phi <4 x float> [ %out_1.sroa.80.3, %if.end231.4 ], [ %out_1.sroa.80.3, %if.then237.4 ], [ %184, %for.cond304.preheader.4 ]
  %out_1.sroa.54.5 = phi <4 x float> [ %out_1.sroa.54.3, %if.end231.4 ], [ %out_1.sroa.54.3, %if.then237.4 ], [ %183, %for.cond304.preheader.4 ]
  %out_1.sroa.28.5 = phi <4 x float> [ %out_1.sroa.28.3, %if.end231.4 ], [ %out_1.sroa.28.3, %if.then237.4 ], [ %182, %for.cond304.preheader.4 ]
  %out_1.sroa.0.5 = phi <4 x float> [ %out_1.sroa.0.3, %if.end231.4 ], [ %out_1.sroa.0.3, %if.then237.4 ], [ %181, %for.cond304.preheader.4 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %cmp80, label %if.end231.5, label %if.then82.5

if.then82.5:                                      ; preds = %if.end324.4
  %or.cond600.5 = icmp ugt i32 %mul11.5, 1023
  %cmp90.not.5 = icmp sgt i32 %mul11.5, %1
  %or.cond601.5 = or i1 %or.cond600.5, %cmp90.not.5
  br i1 %or.cond601.5, label %if.end116.5, label %for.cond92.preheader.5

for.cond92.preheader.5:                           ; preds = %if.then82.5
  %185 = shl nsw i32 %cond.i.i573.5, 10
  %mul99.5 = and i32 %185, 64512
  %add100.5 = or disjoint i32 %mul99.5, %mul97
  %186 = zext nneg i32 %add100.5 to i64
  %187 = or disjoint i64 %186, %26
  %add.ptr108.5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %187
  %kr.sroa.0.0.copyload1245 = load <4 x half>, ptr addrspace(4) %add.ptr108.5, align 16
  %kr.sroa.20.0.add.ptr108.5.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108.5, i64 8
  %kr.sroa.20.0.copyload1253 = load <4 x half>, ptr addrspace(4) %kr.sroa.20.0.add.ptr108.5.sroa_idx, align 8
  %188 = or disjoint i64 %186, %26
  %189 = or disjoint i64 %188, 512
  %add.ptr108.1.5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %189
  %kr.sroa.29.16.copyload1277 = load <4 x half>, ptr addrspace(4) %add.ptr108.1.5, align 16
  %kr.sroa.47.16.add.ptr108.1.5.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108.1.5, i64 8
  %kr.sroa.47.16.copyload1285 = load <4 x half>, ptr addrspace(4) %kr.sroa.47.16.add.ptr108.1.5.sroa_idx, align 8
  br label %if.end116.5

if.end116.5:                                      ; preds = %for.cond92.preheader.5, %if.then82.5
  %kr.sroa.47.10 = phi <4 x half> [ %kr.sroa.47.9, %if.then82.5 ], [ %kr.sroa.47.16.copyload1285, %for.cond92.preheader.5 ]
  %kr.sroa.29.10 = phi <4 x half> [ %kr.sroa.29.9, %if.then82.5 ], [ %kr.sroa.29.16.copyload1277, %for.cond92.preheader.5 ]
  %kr.sroa.20.10 = phi <4 x half> [ %kr.sroa.20.9, %if.then82.5 ], [ %kr.sroa.20.0.copyload1253, %for.cond92.preheader.5 ]
  %kr.sroa.0.10 = phi <4 x half> [ %kr.sroa.0.9, %if.then82.5 ], [ %kr.sroa.0.0.copyload1245, %for.cond92.preheader.5 ]
  br i1 %or.cond601.5, label %if.end220.5, label %if.then125.5

if.then125.5:                                     ; preds = %if.end116.5
  %cmp128.5 = icmp sgt i32 %mul11.5, %invariant.op
  br i1 %cmp128.5, label %for.cond130.preheader.5, label %if.end156.5

for.cond130.preheader.5:                          ; preds = %if.then125.5
  %add138.5 = or disjoint i32 %mul11.5, %mul137
  %cmp141.not.5 = icmp sgt i32 %add138.5, %1
  %spec.select.5 = select i1 %cmp141.not.5, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert801 = insertelement <4 x float> poison, float %spec.select.5, i64 0
  %cmp141.not.1.5.not = icmp slt i32 %add138.5, %1
  %spec.select.1.5 = select i1 %cmp141.not.1.5.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert894 = insertelement <4 x float> %scores.sroa.0.0.vec.insert801, float %spec.select.1.5, i64 1
  %add139.2.5 = or disjoint i32 %add138.5, 2
  %cmp141.not.2.5 = icmp sgt i32 %add139.2.5, %1
  %spec.select.2.5 = select i1 %cmp141.not.2.5, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert981 = insertelement <4 x float> %scores.sroa.0.4.vec.insert894, float %spec.select.2.5, i64 2
  %add139.3.5 = or disjoint i32 %add138.5, 3
  %cmp141.not.3.5 = icmp sgt i32 %add139.3.5, %1
  %spec.select.3.5 = select i1 %cmp141.not.3.5, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1068 = insertelement <4 x float> %scores.sroa.0.8.vec.insert981, float %spec.select.3.5, i64 3
  br label %if.end156.5

if.end156.5:                                      ; preds = %if.then125.5, %for.cond130.preheader.5
  %scores.sroa.0.15 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1068, %for.cond130.preheader.5 ], [ zeroinitializer, %if.then125.5 ]
  %190 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.10, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.15)
  %191 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.20.10, <4 x half> %qr.sroa.12.0, <4 x float> %190)
  %192 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.29.10, <4 x half> %qr.sroa.21.0, <4 x float> %191)
  %193 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.10, <4 x half> %qr.sroa.31.0, <4 x float> %192)
  %scores.sroa.0.0.vec.extract803 = extractelement <4 x float> %193, i64 0
  %mul180.5 = fmul contract float %scores.sroa.0.0.vec.extract803, 0x3FB99999A0000000
  %194 = tail call contract noundef float @llvm.minnum.f32(float %mul180.5, float 0x4024CB5EC0000000)
  %195 = tail call contract noundef float @llvm.exp.f32(float %194)
  %scores.sroa.0.4.vec.extract896 = extractelement <4 x float> %193, i64 1
  %mul180.1.5 = fmul contract float %scores.sroa.0.4.vec.extract896, 0x3FB99999A0000000
  %196 = tail call contract noundef float @llvm.minnum.f32(float %mul180.1.5, float 0x4024CB5EC0000000)
  %197 = tail call contract noundef float @llvm.exp.f32(float %196)
  %scores.sroa.0.8.vec.extract983 = extractelement <4 x float> %193, i64 2
  %mul180.2.5 = fmul contract float %scores.sroa.0.8.vec.extract983, 0x3FB99999A0000000
  %198 = tail call contract noundef float @llvm.minnum.f32(float %mul180.2.5, float 0x4024CB5EC0000000)
  %199 = tail call contract noundef float @llvm.exp.f32(float %198)
  %scores.sroa.0.12.vec.extract1070 = extractelement <4 x float> %193, i64 3
  %mul180.3.5 = fmul contract float %scores.sroa.0.12.vec.extract1070, 0x3FB99999A0000000
  %200 = tail call contract noundef float @llvm.minnum.f32(float %mul180.3.5, float 0x4024CB5EC0000000)
  %201 = tail call contract noundef float @llvm.exp.f32(float %200)
  %add196.5 = fadd contract float %sums.sroa.0.10, %195
  %202 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %195)
  %probs.sroa.0.0.vec.insert1143 = insertelement <4 x i16> poison, i16 %202, i64 0
  %add196.1.5 = fadd contract float %sums.sroa.22.10, %197
  %203 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %197)
  %probs.sroa.0.2.vec.insert1177 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1143, i16 %203, i64 1
  %add196.2.5 = fadd contract float %sums.sroa.42.10, %199
  %204 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %199)
  %probs.sroa.0.4.vec.insert1210 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1177, i16 %204, i64 2
  %add196.3.5 = fadd contract float %sums.sroa.62.10, %201
  %205 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %201)
  %probs.sroa.0.6.vec.insert1226 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1210, i16 %205, i64 3
  br label %if.end220.5

if.end220.5:                                      ; preds = %if.end116.5, %if.end156.5
  %sums.sroa.62.11 = phi float [ %add196.3.5, %if.end156.5 ], [ %sums.sroa.62.10, %if.end116.5 ]
  %sums.sroa.42.11 = phi float [ %add196.2.5, %if.end156.5 ], [ %sums.sroa.42.10, %if.end116.5 ]
  %sums.sroa.22.11 = phi float [ %add196.1.5, %if.end156.5 ], [ %sums.sroa.22.10, %if.end116.5 ]
  %sums.sroa.0.11 = phi float [ %add196.5, %if.end156.5 ], [ %sums.sroa.0.10, %if.end116.5 ]
  %probs.sroa.0.15 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1226, %if.end156.5 ], [ zeroinitializer, %if.end116.5 ]
  %add228.5 = or disjoint i32 %and226, 256
  %add.ptr230.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add228.5
  store <4 x i16> %probs.sroa.0.15, ptr addrspace(3) %add.ptr230.5, align 8
  br label %if.end231.5

if.end231.5:                                      ; preds = %if.end220.5, %if.end324.4
  %sums.sroa.62.12 = phi float [ %sums.sroa.62.10, %if.end324.4 ], [ %sums.sroa.62.11, %if.end220.5 ]
  %sums.sroa.42.12 = phi float [ %sums.sroa.42.10, %if.end324.4 ], [ %sums.sroa.42.11, %if.end220.5 ]
  %sums.sroa.22.12 = phi float [ %sums.sroa.22.10, %if.end324.4 ], [ %sums.sroa.22.11, %if.end220.5 ]
  %sums.sroa.0.12 = phi float [ %sums.sroa.0.10, %if.end324.4 ], [ %sums.sroa.0.11, %if.end220.5 ]
  %kr.sroa.47.11 = phi <4 x half> [ %kr.sroa.47.9, %if.end324.4 ], [ %kr.sroa.47.10, %if.end220.5 ]
  %kr.sroa.29.11 = phi <4 x half> [ %kr.sroa.29.9, %if.end324.4 ], [ %kr.sroa.29.10, %if.end220.5 ]
  %kr.sroa.20.11 = phi <4 x half> [ %kr.sroa.20.9, %if.end324.4 ], [ %kr.sroa.20.10, %if.end220.5 ]
  %kr.sroa.0.11 = phi <4 x half> [ %kr.sroa.0.9, %if.end324.4 ], [ %kr.sroa.0.10, %if.end220.5 ]
  br i1 %cmp234.not, label %if.then237.5, label %if.end324.5

if.then237.5:                                     ; preds = %if.end231.5
  %or.cond604.5 = icmp ugt i32 %mul11.4, 1023
  %cmp245.not.5 = icmp sgt i32 %mul11.4, %1
  %or.cond605.5 = or i1 %or.cond604.5, %cmp245.not.5
  br i1 %or.cond605.5, label %if.end324.5, label %for.cond285.preheader.5

for.cond285.preheader.5:                          ; preds = %if.then237.5
  %add277.5 = and i32 %and226, 252
  %add.ptr279.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add277.5
  %206 = load <4 x half>, ptr addrspace(3) %add.ptr279.5, align 8
  %207 = shl nsw i32 %cond.i.i573.4, 10
  %mul254.5 = and i32 %207, 64512
  %add255.5 = or disjoint i32 %mul254.5, %mul97
  %208 = zext nneg i32 %add255.5 to i64
  %209 = or disjoint i64 %208, %27
  %210 = or disjoint i64 %209, 512
  %add.ptr263.1.5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %210
  %vr.sroa.74.16.add.ptr263.1.5.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr263.1.5, i64 8
  %vr.sroa.74.16.copyload721 = load <4 x half>, ptr addrspace(4) %vr.sroa.74.16.add.ptr263.1.5.sroa_idx, align 8
  %vr.sroa.47.16.copyload713 = load <4 x half>, ptr addrspace(4) %add.ptr263.1.5, align 16
  %211 = or disjoint i64 %208, %27
  %add.ptr263.5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %211
  %vr.sroa.29.0.add.ptr263.5.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr263.5, i64 8
  %vr.sroa.29.0.copyload671 = load <4 x half>, ptr addrspace(4) %vr.sroa.29.0.add.ptr263.5.sroa_idx, align 8
  %vr.sroa.0.0.copyload663 = load <4 x half>, ptr addrspace(4) %add.ptr263.5, align 16
  %212 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload663, <4 x half> %206, <4 x float> %out.sroa.0.4), !call_argsrelate !164
  %213 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.29.0.copyload671, <4 x half> %206, <4 x float> %out.sroa.32.4), !call_argsrelate !164
  %214 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.47.16.copyload713, <4 x half> %206, <4 x float> %out.sroa.62.4), !call_argsrelate !164
  %215 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.74.16.copyload721, <4 x half> %206, <4 x float> %out.sroa.92.4), !call_argsrelate !164
  br label %if.end324.5

if.end324.5:                                      ; preds = %for.cond285.preheader.5, %if.then237.5, %if.end231.5
  %out.sroa.92.6 = phi <4 x float> [ %out.sroa.92.4, %if.end231.5 ], [ %out.sroa.92.4, %if.then237.5 ], [ %215, %for.cond285.preheader.5 ]
  %out.sroa.62.6 = phi <4 x float> [ %out.sroa.62.4, %if.end231.5 ], [ %out.sroa.62.4, %if.then237.5 ], [ %214, %for.cond285.preheader.5 ]
  %out.sroa.32.6 = phi <4 x float> [ %out.sroa.32.4, %if.end231.5 ], [ %out.sroa.32.4, %if.then237.5 ], [ %213, %for.cond285.preheader.5 ]
  %out.sroa.0.6 = phi <4 x float> [ %out.sroa.0.4, %if.end231.5 ], [ %out.sroa.0.4, %if.then237.5 ], [ %212, %for.cond285.preheader.5 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %cmp80, label %if.end231.6, label %if.then82.6

if.then82.6:                                      ; preds = %if.end324.5
  %or.cond600.6 = icmp ugt i32 %mul11.6, 1023
  %cmp90.not.6 = icmp sgt i32 %mul11.6, %1
  %or.cond601.6 = or i1 %or.cond600.6, %cmp90.not.6
  br i1 %or.cond601.6, label %if.end116.6, label %for.cond92.preheader.6

for.cond92.preheader.6:                           ; preds = %if.then82.6
  %216 = shl nsw i32 %cond.i.i573.6, 10
  %mul99.6 = and i32 %216, 64512
  %add100.6 = or disjoint i32 %mul99.6, %mul97
  %217 = zext nneg i32 %add100.6 to i64
  %218 = or disjoint i64 %217, %26
  %add.ptr108.6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %218
  %kr.sroa.0.0.copyload1246 = load <4 x half>, ptr addrspace(4) %add.ptr108.6, align 16
  %kr.sroa.20.0.add.ptr108.6.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108.6, i64 8
  %kr.sroa.20.0.copyload1254 = load <4 x half>, ptr addrspace(4) %kr.sroa.20.0.add.ptr108.6.sroa_idx, align 8
  %219 = or disjoint i64 %217, %26
  %220 = or disjoint i64 %219, 512
  %add.ptr108.1.6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %220
  %kr.sroa.29.16.copyload1278 = load <4 x half>, ptr addrspace(4) %add.ptr108.1.6, align 16
  %kr.sroa.47.16.add.ptr108.1.6.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108.1.6, i64 8
  %kr.sroa.47.16.copyload1286 = load <4 x half>, ptr addrspace(4) %kr.sroa.47.16.add.ptr108.1.6.sroa_idx, align 8
  br label %if.end116.6

if.end116.6:                                      ; preds = %for.cond92.preheader.6, %if.then82.6
  %kr.sroa.47.12 = phi <4 x half> [ %kr.sroa.47.11, %if.then82.6 ], [ %kr.sroa.47.16.copyload1286, %for.cond92.preheader.6 ]
  %kr.sroa.29.12 = phi <4 x half> [ %kr.sroa.29.11, %if.then82.6 ], [ %kr.sroa.29.16.copyload1278, %for.cond92.preheader.6 ]
  %kr.sroa.20.12 = phi <4 x half> [ %kr.sroa.20.11, %if.then82.6 ], [ %kr.sroa.20.0.copyload1254, %for.cond92.preheader.6 ]
  %kr.sroa.0.12 = phi <4 x half> [ %kr.sroa.0.11, %if.then82.6 ], [ %kr.sroa.0.0.copyload1246, %for.cond92.preheader.6 ]
  br i1 %or.cond601.6, label %if.end220.6, label %if.then125.6

if.then125.6:                                     ; preds = %if.end116.6
  %cmp128.6 = icmp sgt i32 %mul11.6, %invariant.op
  br i1 %cmp128.6, label %for.cond130.preheader.6, label %if.end156.6

for.cond130.preheader.6:                          ; preds = %if.then125.6
  %add138.6 = or disjoint i32 %mul11.6, %mul137
  %cmp141.not.6 = icmp sgt i32 %add138.6, %1
  %spec.select.6 = select i1 %cmp141.not.6, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert811 = insertelement <4 x float> poison, float %spec.select.6, i64 0
  %cmp141.not.1.6.not = icmp slt i32 %add138.6, %1
  %spec.select.1.6 = select i1 %cmp141.not.1.6.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert902 = insertelement <4 x float> %scores.sroa.0.0.vec.insert811, float %spec.select.1.6, i64 1
  %add139.2.6 = or disjoint i32 %add138.6, 2
  %cmp141.not.2.6 = icmp sgt i32 %add139.2.6, %1
  %spec.select.2.6 = select i1 %cmp141.not.2.6, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert989 = insertelement <4 x float> %scores.sroa.0.4.vec.insert902, float %spec.select.2.6, i64 2
  %add139.3.6 = or disjoint i32 %add138.6, 3
  %cmp141.not.3.6 = icmp sgt i32 %add139.3.6, %1
  %spec.select.3.6 = select i1 %cmp141.not.3.6, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1076 = insertelement <4 x float> %scores.sroa.0.8.vec.insert989, float %spec.select.3.6, i64 3
  br label %if.end156.6

if.end156.6:                                      ; preds = %if.then125.6, %for.cond130.preheader.6
  %scores.sroa.0.18 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1076, %for.cond130.preheader.6 ], [ zeroinitializer, %if.then125.6 ]
  %221 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.12, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.18)
  %222 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.20.12, <4 x half> %qr.sroa.12.0, <4 x float> %221)
  %223 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.29.12, <4 x half> %qr.sroa.21.0, <4 x float> %222)
  %224 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.12, <4 x half> %qr.sroa.31.0, <4 x float> %223)
  %scores.sroa.0.0.vec.extract813 = extractelement <4 x float> %224, i64 0
  %mul180.6 = fmul contract float %scores.sroa.0.0.vec.extract813, 0x3FB99999A0000000
  %225 = tail call contract noundef float @llvm.minnum.f32(float %mul180.6, float 0x4024CB5EC0000000)
  %226 = tail call contract noundef float @llvm.exp.f32(float %225)
  %scores.sroa.0.4.vec.extract904 = extractelement <4 x float> %224, i64 1
  %mul180.1.6 = fmul contract float %scores.sroa.0.4.vec.extract904, 0x3FB99999A0000000
  %227 = tail call contract noundef float @llvm.minnum.f32(float %mul180.1.6, float 0x4024CB5EC0000000)
  %228 = tail call contract noundef float @llvm.exp.f32(float %227)
  %scores.sroa.0.8.vec.extract991 = extractelement <4 x float> %224, i64 2
  %mul180.2.6 = fmul contract float %scores.sroa.0.8.vec.extract991, 0x3FB99999A0000000
  %229 = tail call contract noundef float @llvm.minnum.f32(float %mul180.2.6, float 0x4024CB5EC0000000)
  %230 = tail call contract noundef float @llvm.exp.f32(float %229)
  %scores.sroa.0.12.vec.extract1078 = extractelement <4 x float> %224, i64 3
  %mul180.3.6 = fmul contract float %scores.sroa.0.12.vec.extract1078, 0x3FB99999A0000000
  %231 = tail call contract noundef float @llvm.minnum.f32(float %mul180.3.6, float 0x4024CB5EC0000000)
  %232 = tail call contract noundef float @llvm.exp.f32(float %231)
  %add196.6 = fadd contract float %sums.sroa.0.12, %226
  %233 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %226)
  %probs.sroa.0.0.vec.insert1145 = insertelement <4 x i16> poison, i16 %233, i64 0
  %add196.1.6 = fadd contract float %sums.sroa.22.12, %228
  %234 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %228)
  %probs.sroa.0.2.vec.insert1179 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1145, i16 %234, i64 1
  %add196.2.6 = fadd contract float %sums.sroa.42.12, %230
  %235 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %230)
  %probs.sroa.0.4.vec.insert1212 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1179, i16 %235, i64 2
  %add196.3.6 = fadd contract float %sums.sroa.62.12, %232
  %236 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %232)
  %probs.sroa.0.6.vec.insert1228 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1212, i16 %236, i64 3
  br label %if.end220.6

if.end220.6:                                      ; preds = %if.end116.6, %if.end156.6
  %sums.sroa.62.13 = phi float [ %add196.3.6, %if.end156.6 ], [ %sums.sroa.62.12, %if.end116.6 ]
  %sums.sroa.42.13 = phi float [ %add196.2.6, %if.end156.6 ], [ %sums.sroa.42.12, %if.end116.6 ]
  %sums.sroa.22.13 = phi float [ %add196.1.6, %if.end156.6 ], [ %sums.sroa.22.12, %if.end116.6 ]
  %sums.sroa.0.13 = phi float [ %add196.6, %if.end156.6 ], [ %sums.sroa.0.12, %if.end116.6 ]
  %probs.sroa.0.18 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1228, %if.end156.6 ], [ zeroinitializer, %if.end116.6 ]
  %add.ptr230.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and226
  store <4 x i16> %probs.sroa.0.18, ptr addrspace(3) %add.ptr230.6, align 8
  br label %if.end231.6

if.end231.6:                                      ; preds = %if.end220.6, %if.end324.5
  %sums.sroa.62.14 = phi float [ %sums.sroa.62.12, %if.end324.5 ], [ %sums.sroa.62.13, %if.end220.6 ]
  %sums.sroa.42.14 = phi float [ %sums.sroa.42.12, %if.end324.5 ], [ %sums.sroa.42.13, %if.end220.6 ]
  %sums.sroa.22.14 = phi float [ %sums.sroa.22.12, %if.end324.5 ], [ %sums.sroa.22.13, %if.end220.6 ]
  %sums.sroa.0.14 = phi float [ %sums.sroa.0.12, %if.end324.5 ], [ %sums.sroa.0.13, %if.end220.6 ]
  %kr.sroa.47.13 = phi <4 x half> [ %kr.sroa.47.11, %if.end324.5 ], [ %kr.sroa.47.12, %if.end220.6 ]
  %kr.sroa.29.13 = phi <4 x half> [ %kr.sroa.29.11, %if.end324.5 ], [ %kr.sroa.29.12, %if.end220.6 ]
  %kr.sroa.20.13 = phi <4 x half> [ %kr.sroa.20.11, %if.end324.5 ], [ %kr.sroa.20.12, %if.end220.6 ]
  %kr.sroa.0.13 = phi <4 x half> [ %kr.sroa.0.11, %if.end324.5 ], [ %kr.sroa.0.12, %if.end220.6 ]
  br i1 %cmp234.not, label %if.then237.6, label %if.end324.6

if.then237.6:                                     ; preds = %if.end231.6
  %or.cond604.6 = icmp ugt i32 %mul11.5, 1023
  %cmp245.not.6 = icmp sgt i32 %mul11.5, %1
  %or.cond605.6 = or i1 %or.cond604.6, %cmp245.not.6
  br i1 %or.cond605.6, label %if.end324.6, label %for.cond304.preheader.6

for.cond304.preheader.6:                          ; preds = %if.then237.6
  %add.ptr279.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and226
  %237 = load <4 x half>, ptr addrspace(3) %add.ptr279.6, align 8
  %238 = shl nsw i32 %cond.i.i573.5, 10
  %mul254.6 = and i32 %238, 64512
  %add255.6 = or disjoint i32 %mul254.6, %mul97
  %239 = zext nneg i32 %add255.6 to i64
  %240 = or disjoint i64 %239, %27
  %241 = or disjoint i64 %240, 512
  %add.ptr263.1.6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %241
  %vr.sroa.74.16.add.ptr263.1.6.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr263.1.6, i64 8
  %vr.sroa.74.16.copyload722 = load <4 x half>, ptr addrspace(4) %vr.sroa.74.16.add.ptr263.1.6.sroa_idx, align 8
  %vr.sroa.47.16.copyload714 = load <4 x half>, ptr addrspace(4) %add.ptr263.1.6, align 16
  %242 = or disjoint i64 %239, %27
  %add.ptr263.6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %242
  %vr.sroa.29.0.add.ptr263.6.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr263.6, i64 8
  %vr.sroa.29.0.copyload672 = load <4 x half>, ptr addrspace(4) %vr.sroa.29.0.add.ptr263.6.sroa_idx, align 8
  %vr.sroa.0.0.copyload664 = load <4 x half>, ptr addrspace(4) %add.ptr263.6, align 16
  %243 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload664, <4 x half> %237, <4 x float> %out_1.sroa.0.5), !call_argsrelate !164
  %244 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.29.0.copyload672, <4 x half> %237, <4 x float> %out_1.sroa.28.5), !call_argsrelate !164
  %245 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.47.16.copyload714, <4 x half> %237, <4 x float> %out_1.sroa.54.5), !call_argsrelate !164
  %246 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.74.16.copyload722, <4 x half> %237, <4 x float> %out_1.sroa.80.5), !call_argsrelate !164
  br label %if.end324.6

if.end324.6:                                      ; preds = %for.cond304.preheader.6, %if.then237.6, %if.end231.6
  %out_1.sroa.80.7 = phi <4 x float> [ %out_1.sroa.80.5, %if.end231.6 ], [ %out_1.sroa.80.5, %if.then237.6 ], [ %246, %for.cond304.preheader.6 ]
  %out_1.sroa.54.7 = phi <4 x float> [ %out_1.sroa.54.5, %if.end231.6 ], [ %out_1.sroa.54.5, %if.then237.6 ], [ %245, %for.cond304.preheader.6 ]
  %out_1.sroa.28.7 = phi <4 x float> [ %out_1.sroa.28.5, %if.end231.6 ], [ %out_1.sroa.28.5, %if.then237.6 ], [ %244, %for.cond304.preheader.6 ]
  %out_1.sroa.0.7 = phi <4 x float> [ %out_1.sroa.0.5, %if.end231.6 ], [ %out_1.sroa.0.5, %if.then237.6 ], [ %243, %for.cond304.preheader.6 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %cmp80, label %if.end231.7, label %if.then82.7

if.then82.7:                                      ; preds = %if.end324.6
  %or.cond600.7 = icmp ugt i32 %mul11.7, 1023
  %cmp90.not.7 = icmp sgt i32 %mul11.7, %1
  %or.cond601.7 = or i1 %or.cond600.7, %cmp90.not.7
  br i1 %or.cond601.7, label %if.end116.7, label %for.cond92.preheader.7

for.cond92.preheader.7:                           ; preds = %if.then82.7
  %247 = shl nsw i32 %cond.i.i573.7, 10
  %mul99.7 = and i32 %247, 64512
  %add100.7 = or disjoint i32 %mul99.7, %mul97
  %248 = zext nneg i32 %add100.7 to i64
  %249 = or disjoint i64 %248, %26
  %add.ptr108.7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %249
  %kr.sroa.0.0.copyload1247 = load <4 x half>, ptr addrspace(4) %add.ptr108.7, align 16
  %kr.sroa.20.0.add.ptr108.7.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108.7, i64 8
  %kr.sroa.20.0.copyload1255 = load <4 x half>, ptr addrspace(4) %kr.sroa.20.0.add.ptr108.7.sroa_idx, align 8
  %250 = or disjoint i64 %248, %26
  %251 = or disjoint i64 %250, 512
  %add.ptr108.1.7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %251
  %kr.sroa.29.16.copyload1279 = load <4 x half>, ptr addrspace(4) %add.ptr108.1.7, align 16
  %kr.sroa.47.16.add.ptr108.1.7.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr108.1.7, i64 8
  %kr.sroa.47.16.copyload1287 = load <4 x half>, ptr addrspace(4) %kr.sroa.47.16.add.ptr108.1.7.sroa_idx, align 8
  br label %if.end116.7

if.end116.7:                                      ; preds = %for.cond92.preheader.7, %if.then82.7
  %kr.sroa.47.14 = phi <4 x half> [ %kr.sroa.47.13, %if.then82.7 ], [ %kr.sroa.47.16.copyload1287, %for.cond92.preheader.7 ]
  %kr.sroa.29.14 = phi <4 x half> [ %kr.sroa.29.13, %if.then82.7 ], [ %kr.sroa.29.16.copyload1279, %for.cond92.preheader.7 ]
  %kr.sroa.20.14 = phi <4 x half> [ %kr.sroa.20.13, %if.then82.7 ], [ %kr.sroa.20.0.copyload1255, %for.cond92.preheader.7 ]
  %kr.sroa.0.14 = phi <4 x half> [ %kr.sroa.0.13, %if.then82.7 ], [ %kr.sroa.0.0.copyload1247, %for.cond92.preheader.7 ]
  br i1 %or.cond601.7, label %if.end220.7, label %if.then125.7

if.then125.7:                                     ; preds = %if.end116.7
  %cmp128.7 = icmp sgt i32 %mul11.7, %invariant.op
  br i1 %cmp128.7, label %for.cond130.preheader.7, label %if.end156.7

for.cond130.preheader.7:                          ; preds = %if.then125.7
  %add138.7 = or disjoint i32 %mul11.7, %mul137
  %cmp141.not.7 = icmp sgt i32 %add138.7, %1
  %spec.select.7 = select i1 %cmp141.not.7, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert821 = insertelement <4 x float> poison, float %spec.select.7, i64 0
  %cmp141.not.1.7.not = icmp slt i32 %add138.7, %1
  %spec.select.1.7 = select i1 %cmp141.not.1.7.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert910 = insertelement <4 x float> %scores.sroa.0.0.vec.insert821, float %spec.select.1.7, i64 1
  %add139.2.7 = or disjoint i32 %add138.7, 2
  %cmp141.not.2.7 = icmp sgt i32 %add139.2.7, %1
  %spec.select.2.7 = select i1 %cmp141.not.2.7, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert997 = insertelement <4 x float> %scores.sroa.0.4.vec.insert910, float %spec.select.2.7, i64 2
  %add139.3.7 = or disjoint i32 %add138.7, 3
  %cmp141.not.3.7 = icmp sgt i32 %add139.3.7, %1
  %spec.select.3.7 = select i1 %cmp141.not.3.7, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1084 = insertelement <4 x float> %scores.sroa.0.8.vec.insert997, float %spec.select.3.7, i64 3
  br label %if.end156.7

if.end156.7:                                      ; preds = %if.then125.7, %for.cond130.preheader.7
  %scores.sroa.0.21 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1084, %for.cond130.preheader.7 ], [ zeroinitializer, %if.then125.7 ]
  %252 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.14, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.21)
  %253 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.20.14, <4 x half> %qr.sroa.12.0, <4 x float> %252)
  %254 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.29.14, <4 x half> %qr.sroa.21.0, <4 x float> %253)
  %255 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.14, <4 x half> %qr.sroa.31.0, <4 x float> %254)
  %scores.sroa.0.0.vec.extract823 = extractelement <4 x float> %255, i64 0
  %mul180.7 = fmul contract float %scores.sroa.0.0.vec.extract823, 0x3FB99999A0000000
  %256 = tail call contract noundef float @llvm.minnum.f32(float %mul180.7, float 0x4024CB5EC0000000)
  %257 = tail call contract noundef float @llvm.exp.f32(float %256)
  %scores.sroa.0.4.vec.extract912 = extractelement <4 x float> %255, i64 1
  %mul180.1.7 = fmul contract float %scores.sroa.0.4.vec.extract912, 0x3FB99999A0000000
  %258 = tail call contract noundef float @llvm.minnum.f32(float %mul180.1.7, float 0x4024CB5EC0000000)
  %259 = tail call contract noundef float @llvm.exp.f32(float %258)
  %scores.sroa.0.8.vec.extract999 = extractelement <4 x float> %255, i64 2
  %mul180.2.7 = fmul contract float %scores.sroa.0.8.vec.extract999, 0x3FB99999A0000000
  %260 = tail call contract noundef float @llvm.minnum.f32(float %mul180.2.7, float 0x4024CB5EC0000000)
  %261 = tail call contract noundef float @llvm.exp.f32(float %260)
  %scores.sroa.0.12.vec.extract1086 = extractelement <4 x float> %255, i64 3
  %mul180.3.7 = fmul contract float %scores.sroa.0.12.vec.extract1086, 0x3FB99999A0000000
  %262 = tail call contract noundef float @llvm.minnum.f32(float %mul180.3.7, float 0x4024CB5EC0000000)
  %263 = tail call contract noundef float @llvm.exp.f32(float %262)
  %add196.7 = fadd contract float %sums.sroa.0.14, %257
  %264 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %257)
  %probs.sroa.0.0.vec.insert1147 = insertelement <4 x i16> poison, i16 %264, i64 0
  %add196.1.7 = fadd contract float %sums.sroa.22.14, %259
  %265 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %259)
  %probs.sroa.0.2.vec.insert1181 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1147, i16 %265, i64 1
  %add196.2.7 = fadd contract float %sums.sroa.42.14, %261
  %266 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %261)
  %probs.sroa.0.4.vec.insert1214 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1181, i16 %266, i64 2
  %add196.3.7 = fadd contract float %sums.sroa.62.14, %263
  %267 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %263)
  %probs.sroa.0.6.vec.insert1230 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1214, i16 %267, i64 3
  %268 = bitcast <4 x i16> %probs.sroa.0.6.vec.insert1230 to i64
  br label %if.end220.7

if.end220.7:                                      ; preds = %if.end116.7, %if.end156.7
  %sums.sroa.62.15 = phi float [ %add196.3.7, %if.end156.7 ], [ %sums.sroa.62.14, %if.end116.7 ]
  %sums.sroa.42.15 = phi float [ %add196.2.7, %if.end156.7 ], [ %sums.sroa.42.14, %if.end116.7 ]
  %sums.sroa.22.15 = phi float [ %add196.1.7, %if.end156.7 ], [ %sums.sroa.22.14, %if.end116.7 ]
  %sums.sroa.0.15 = phi float [ %add196.7, %if.end156.7 ], [ %sums.sroa.0.14, %if.end116.7 ]
  %probs.sroa.0.21 = phi i64 [ %268, %if.end156.7 ], [ 0, %if.end116.7 ]
  %add228.7 = or disjoint i32 %and226, 256
  %add.ptr230.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add228.7
  store i64 %probs.sroa.0.21, ptr addrspace(3) %add.ptr230.7, align 8
  br label %if.end231.7

if.end231.7:                                      ; preds = %if.end220.7, %if.end324.6
  %sums.sroa.62.16 = phi float [ %sums.sroa.62.14, %if.end324.6 ], [ %sums.sroa.62.15, %if.end220.7 ]
  %sums.sroa.42.16 = phi float [ %sums.sroa.42.14, %if.end324.6 ], [ %sums.sroa.42.15, %if.end220.7 ]
  %sums.sroa.22.16 = phi float [ %sums.sroa.22.14, %if.end324.6 ], [ %sums.sroa.22.15, %if.end220.7 ]
  %sums.sroa.0.16 = phi float [ %sums.sroa.0.14, %if.end324.6 ], [ %sums.sroa.0.15, %if.end220.7 ]
  br i1 %cmp234.not, label %if.then237.7, label %if.end324.7

if.then237.7:                                     ; preds = %if.end231.7
  %or.cond604.7 = icmp ugt i32 %mul11.6, 1023
  %cmp245.not.7 = icmp sgt i32 %mul11.6, %1
  %or.cond605.7 = or i1 %or.cond604.7, %cmp245.not.7
  br i1 %or.cond605.7, label %if.end324.7, label %for.cond285.preheader.7

for.cond285.preheader.7:                          ; preds = %if.then237.7
  %add277.7 = and i32 %and226, 252
  %add.ptr279.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add277.7
  %269 = load <4 x half>, ptr addrspace(3) %add.ptr279.7, align 8
  %270 = shl nsw i32 %cond.i.i573.6, 10
  %mul254.7 = and i32 %270, 64512
  %add255.7 = or disjoint i32 %mul254.7, %mul97
  %271 = zext nneg i32 %add255.7 to i64
  %272 = or disjoint i64 %271, %27
  %273 = or disjoint i64 %272, 512
  %add.ptr263.1.7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %273
  %vr.sroa.74.16.add.ptr263.1.7.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr263.1.7, i64 8
  %vr.sroa.74.16.copyload723 = load <4 x half>, ptr addrspace(4) %vr.sroa.74.16.add.ptr263.1.7.sroa_idx, align 8
  %vr.sroa.47.16.copyload715 = load <4 x half>, ptr addrspace(4) %add.ptr263.1.7, align 16
  %274 = or disjoint i64 %271, %27
  %add.ptr263.7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %274
  %vr.sroa.29.0.add.ptr263.7.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr263.7, i64 8
  %vr.sroa.29.0.copyload673 = load <4 x half>, ptr addrspace(4) %vr.sroa.29.0.add.ptr263.7.sroa_idx, align 8
  %vr.sroa.0.0.copyload665 = load <4 x half>, ptr addrspace(4) %add.ptr263.7, align 16
  %275 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload665, <4 x half> %269, <4 x float> %out.sroa.0.6), !call_argsrelate !164
  %276 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.29.0.copyload673, <4 x half> %269, <4 x float> %out.sroa.32.6), !call_argsrelate !164
  %277 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.47.16.copyload715, <4 x half> %269, <4 x float> %out.sroa.62.6), !call_argsrelate !164
  %278 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.74.16.copyload723, <4 x half> %269, <4 x float> %out.sroa.92.6), !call_argsrelate !164
  br label %if.end324.7

if.end324.7:                                      ; preds = %for.cond285.preheader.7, %if.then237.7, %if.end231.7
  %out.sroa.92.8 = phi <4 x float> [ %out.sroa.92.6, %if.end231.7 ], [ %out.sroa.92.6, %if.then237.7 ], [ %278, %for.cond285.preheader.7 ]
  %out.sroa.62.8 = phi <4 x float> [ %out.sroa.62.6, %if.end231.7 ], [ %out.sroa.62.6, %if.then237.7 ], [ %277, %for.cond285.preheader.7 ]
  %out.sroa.32.8 = phi <4 x float> [ %out.sroa.32.6, %if.end231.7 ], [ %out.sroa.32.6, %if.then237.7 ], [ %276, %for.cond285.preheader.7 ]
  %out.sroa.0.8 = phi <4 x float> [ %out.sroa.0.6, %if.end231.7 ], [ %out.sroa.0.6, %if.then237.7 ], [ %275, %for.cond285.preheader.7 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br label %if.end231.8

if.end231.8:                                      ; preds = %if.end324.7
  br i1 %cmp234.not, label %if.then237.8, label %if.end324.8

if.then237.8:                                     ; preds = %if.end231.8
  %or.cond604.8 = icmp ugt i32 %mul11.7, 1023
  %cmp245.not.8 = icmp sgt i32 %mul11.7, %1
  %or.cond605.8 = or i1 %or.cond604.8, %cmp245.not.8
  br i1 %or.cond605.8, label %if.end324.8, label %for.cond304.preheader.8

for.cond304.preheader.8:                          ; preds = %if.then237.8
  %add.ptr279.8 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and226
  %279 = load <4 x half>, ptr addrspace(3) %add.ptr279.8, align 8
  %280 = shl nsw i32 %cond.i.i573.7, 10
  %mul254.8 = and i32 %280, 64512
  %add255.8 = or disjoint i32 %mul254.8, %mul97
  %281 = zext nneg i32 %add255.8 to i64
  %282 = or disjoint i64 %281, %27
  %283 = or disjoint i64 %282, 512
  %add.ptr263.1.8 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %283
  %vr.sroa.74.16.add.ptr263.1.8.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr263.1.8, i64 8
  %vr.sroa.74.16.copyload724 = load <4 x half>, ptr addrspace(4) %vr.sroa.74.16.add.ptr263.1.8.sroa_idx, align 8
  %vr.sroa.47.16.copyload716 = load <4 x half>, ptr addrspace(4) %add.ptr263.1.8, align 16
  %284 = or disjoint i64 %281, %27
  %add.ptr263.8 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %284
  %vr.sroa.29.0.add.ptr263.8.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr263.8, i64 8
  %vr.sroa.29.0.copyload674 = load <4 x half>, ptr addrspace(4) %vr.sroa.29.0.add.ptr263.8.sroa_idx, align 8
  %vr.sroa.0.0.copyload666 = load <4 x half>, ptr addrspace(4) %add.ptr263.8, align 16
  %285 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload666, <4 x half> %279, <4 x float> %out_1.sroa.0.7), !call_argsrelate !164
  %286 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.29.0.copyload674, <4 x half> %279, <4 x float> %out_1.sroa.28.7), !call_argsrelate !164
  %287 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.47.16.copyload716, <4 x half> %279, <4 x float> %out_1.sroa.54.7), !call_argsrelate !164
  %288 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.74.16.copyload724, <4 x half> %279, <4 x float> %out_1.sroa.80.7), !call_argsrelate !164
  br label %if.end324.8

if.end324.8:                                      ; preds = %for.cond304.preheader.8, %if.then237.8, %if.end231.8
  %out_1.sroa.80.9 = phi <4 x float> [ %out_1.sroa.80.7, %if.end231.8 ], [ %out_1.sroa.80.7, %if.then237.8 ], [ %288, %for.cond304.preheader.8 ]
  %out_1.sroa.54.9 = phi <4 x float> [ %out_1.sroa.54.7, %if.end231.8 ], [ %out_1.sroa.54.7, %if.then237.8 ], [ %287, %for.cond304.preheader.8 ]
  %out_1.sroa.28.9 = phi <4 x float> [ %out_1.sroa.28.7, %if.end231.8 ], [ %out_1.sroa.28.7, %if.then237.8 ], [ %286, %for.cond304.preheader.8 ]
  %out_1.sroa.0.9 = phi <4 x float> [ %out_1.sroa.0.7, %if.end231.8 ], [ %out_1.sroa.0.7, %if.then237.8 ], [ %285, %for.cond304.preheader.8 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %cmp15, label %for.body336.preheader, label %if.end367

if.end367:                                        ; preds = %for.body336.preheader, %if.end324.8
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  %cmp370 = icmp eq i32 %shr233.mask, 64
  br i1 %cmp370, label %if.then371, label %if.end468

if.then371:                                       ; preds = %if.end367
  %and373 = and i32 %18, 63
  %arrayidx375 = getelementptr inbounds float, ptr addrspace(3) @buf_dyn_shmem, i32 %and373
  %289 = load float, ptr addrspace(3) %arrayidx375, align 4, !tbaa !105
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %out.sroa.0.8, i64 0
  %out_1.sroa.0.0.vec.extract = extractelement <4 x float> %out_1.sroa.0.9, i64 0
  %add385 = fadd contract float %out.sroa.0.0.vec.extract, %out_1.sroa.0.0.vec.extract
  %mul391 = fmul contract float %289, %add385
  %290 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul391)
  %oreg.sroa.0.0.insert.ext = zext i16 %290 to i64
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %out.sroa.0.8, i64 1
  %out_1.sroa.0.4.vec.extract = extractelement <4 x float> %out_1.sroa.0.9, i64 1
  %add385.1 = fadd contract float %out.sroa.0.4.vec.extract, %out_1.sroa.0.4.vec.extract
  %mul391.1 = fmul contract float %289, %add385.1
  %291 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul391.1)
  %oreg.sroa.0.2.insert.ext = zext i16 %291 to i64
  %oreg.sroa.0.2.insert.shift = shl nuw nsw i64 %oreg.sroa.0.2.insert.ext, 16
  %oreg.sroa.0.2.insert.insert = or disjoint i64 %oreg.sroa.0.2.insert.shift, %oreg.sroa.0.0.insert.ext
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %out.sroa.0.8, i64 2
  %out_1.sroa.0.8.vec.extract = extractelement <4 x float> %out_1.sroa.0.9, i64 2
  %add385.2 = fadd contract float %out.sroa.0.8.vec.extract, %out_1.sroa.0.8.vec.extract
  %mul391.2 = fmul contract float %289, %add385.2
  %292 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul391.2)
  %oreg.sroa.0.4.insert.ext = zext i16 %292 to i64
  %oreg.sroa.0.4.insert.shift = shl nuw nsw i64 %oreg.sroa.0.4.insert.ext, 32
  %oreg.sroa.0.4.insert.insert = or disjoint i64 %oreg.sroa.0.2.insert.insert, %oreg.sroa.0.4.insert.shift
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %out.sroa.0.8, i64 3
  %out_1.sroa.0.12.vec.extract = extractelement <4 x float> %out_1.sroa.0.9, i64 3
  %add385.3 = fadd contract float %out.sroa.0.12.vec.extract, %out_1.sroa.0.12.vec.extract
  %mul391.3 = fmul contract float %289, %add385.3
  %293 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul391.3)
  %oreg.sroa.0.6.insert.ext = zext i16 %293 to i64
  %oreg.sroa.0.6.insert.shift = shl nuw i64 %oreg.sroa.0.6.insert.ext, 48
  %oreg.sroa.0.6.insert.insert = or disjoint i64 %oreg.sroa.0.4.insert.insert, %oreg.sroa.0.6.insert.shift
  %out.sroa.32.16.vec.extract = extractelement <4 x float> %out.sroa.32.8, i64 0
  %out_1.sroa.28.16.vec.extract = extractelement <4 x float> %out_1.sroa.28.9, i64 0
  %add385.4 = fadd contract float %out.sroa.32.16.vec.extract, %out_1.sroa.28.16.vec.extract
  %mul391.4 = fmul contract float %289, %add385.4
  %294 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul391.4)
  %oreg.sroa.7.8.insert.ext = zext i16 %294 to i64
  %out.sroa.32.20.vec.extract = extractelement <4 x float> %out.sroa.32.8, i64 1
  %out_1.sroa.28.20.vec.extract = extractelement <4 x float> %out_1.sroa.28.9, i64 1
  %add385.5 = fadd contract float %out.sroa.32.20.vec.extract, %out_1.sroa.28.20.vec.extract
  %mul391.5 = fmul contract float %289, %add385.5
  %295 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul391.5)
  %oreg.sroa.7.10.insert.ext = zext i16 %295 to i64
  %oreg.sroa.7.10.insert.shift = shl nuw nsw i64 %oreg.sroa.7.10.insert.ext, 16
  %oreg.sroa.7.10.insert.insert = or disjoint i64 %oreg.sroa.7.10.insert.shift, %oreg.sroa.7.8.insert.ext
  %out.sroa.32.24.vec.extract = extractelement <4 x float> %out.sroa.32.8, i64 2
  %out_1.sroa.28.24.vec.extract = extractelement <4 x float> %out_1.sroa.28.9, i64 2
  %add385.6 = fadd contract float %out.sroa.32.24.vec.extract, %out_1.sroa.28.24.vec.extract
  %mul391.6 = fmul contract float %289, %add385.6
  %296 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul391.6)
  %oreg.sroa.7.12.insert.ext = zext i16 %296 to i64
  %oreg.sroa.7.12.insert.shift = shl nuw nsw i64 %oreg.sroa.7.12.insert.ext, 32
  %oreg.sroa.7.12.insert.insert = or disjoint i64 %oreg.sroa.7.10.insert.insert, %oreg.sroa.7.12.insert.shift
  %out.sroa.32.28.vec.extract = extractelement <4 x float> %out.sroa.32.8, i64 3
  %out_1.sroa.28.28.vec.extract = extractelement <4 x float> %out_1.sroa.28.9, i64 3
  %add385.7 = fadd contract float %out.sroa.32.28.vec.extract, %out_1.sroa.28.28.vec.extract
  %mul391.7 = fmul contract float %289, %add385.7
  %297 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul391.7)
  %oreg.sroa.7.14.insert.ext = zext i16 %297 to i64
  %oreg.sroa.7.14.insert.shift = shl nuw i64 %oreg.sroa.7.14.insert.ext, 48
  %oreg.sroa.7.14.insert.insert = or disjoint i64 %oreg.sroa.7.12.insert.insert, %oreg.sroa.7.14.insert.shift
  %out.sroa.62.32.vec.extract = extractelement <4 x float> %out.sroa.62.8, i64 0
  %out_1.sroa.54.32.vec.extract = extractelement <4 x float> %out_1.sroa.54.9, i64 0
  %add385.8 = fadd contract float %out.sroa.62.32.vec.extract, %out_1.sroa.54.32.vec.extract
  %mul391.8 = fmul contract float %289, %add385.8
  %298 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul391.8)
  %oreg.sroa.12.16.insert.ext = zext i16 %298 to i64
  %out.sroa.62.36.vec.extract = extractelement <4 x float> %out.sroa.62.8, i64 1
  %out_1.sroa.54.36.vec.extract = extractelement <4 x float> %out_1.sroa.54.9, i64 1
  %add385.9 = fadd contract float %out.sroa.62.36.vec.extract, %out_1.sroa.54.36.vec.extract
  %mul391.9 = fmul contract float %289, %add385.9
  %299 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul391.9)
  %oreg.sroa.12.18.insert.ext = zext i16 %299 to i64
  %oreg.sroa.12.18.insert.shift = shl nuw nsw i64 %oreg.sroa.12.18.insert.ext, 16
  %oreg.sroa.12.18.insert.insert = or disjoint i64 %oreg.sroa.12.18.insert.shift, %oreg.sroa.12.16.insert.ext
  %out.sroa.62.40.vec.extract = extractelement <4 x float> %out.sroa.62.8, i64 2
  %out_1.sroa.54.40.vec.extract = extractelement <4 x float> %out_1.sroa.54.9, i64 2
  %add385.10 = fadd contract float %out.sroa.62.40.vec.extract, %out_1.sroa.54.40.vec.extract
  %mul391.10 = fmul contract float %289, %add385.10
  %300 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul391.10)
  %oreg.sroa.12.20.insert.ext = zext i16 %300 to i64
  %oreg.sroa.12.20.insert.shift = shl nuw nsw i64 %oreg.sroa.12.20.insert.ext, 32
  %oreg.sroa.12.20.insert.insert = or disjoint i64 %oreg.sroa.12.18.insert.insert, %oreg.sroa.12.20.insert.shift
  %out.sroa.62.44.vec.extract = extractelement <4 x float> %out.sroa.62.8, i64 3
  %out_1.sroa.54.44.vec.extract = extractelement <4 x float> %out_1.sroa.54.9, i64 3
  %add385.11 = fadd contract float %out.sroa.62.44.vec.extract, %out_1.sroa.54.44.vec.extract
  %mul391.11 = fmul contract float %289, %add385.11
  %301 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul391.11)
  %oreg.sroa.12.22.insert.ext = zext i16 %301 to i64
  %oreg.sroa.12.22.insert.shift = shl nuw i64 %oreg.sroa.12.22.insert.ext, 48
  %oreg.sroa.12.22.insert.insert = or disjoint i64 %oreg.sroa.12.20.insert.insert, %oreg.sroa.12.22.insert.shift
  %out.sroa.92.48.vec.extract = extractelement <4 x float> %out.sroa.92.8, i64 0
  %out_1.sroa.80.48.vec.extract = extractelement <4 x float> %out_1.sroa.80.9, i64 0
  %add385.12 = fadd contract float %out.sroa.92.48.vec.extract, %out_1.sroa.80.48.vec.extract
  %mul391.12 = fmul contract float %289, %add385.12
  %302 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul391.12)
  %oreg.sroa.17.24.insert.ext = zext i16 %302 to i64
  %out.sroa.92.52.vec.extract = extractelement <4 x float> %out.sroa.92.8, i64 1
  %out_1.sroa.80.52.vec.extract = extractelement <4 x float> %out_1.sroa.80.9, i64 1
  %add385.13 = fadd contract float %out.sroa.92.52.vec.extract, %out_1.sroa.80.52.vec.extract
  %mul391.13 = fmul contract float %289, %add385.13
  %303 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul391.13)
  %oreg.sroa.17.26.insert.ext = zext i16 %303 to i64
  %oreg.sroa.17.26.insert.shift = shl nuw nsw i64 %oreg.sroa.17.26.insert.ext, 16
  %oreg.sroa.17.26.insert.insert = or disjoint i64 %oreg.sroa.17.26.insert.shift, %oreg.sroa.17.24.insert.ext
  %out.sroa.92.56.vec.extract = extractelement <4 x float> %out.sroa.92.8, i64 2
  %out_1.sroa.80.56.vec.extract = extractelement <4 x float> %out_1.sroa.80.9, i64 2
  %add385.14 = fadd contract float %out.sroa.92.56.vec.extract, %out_1.sroa.80.56.vec.extract
  %mul391.14 = fmul contract float %289, %add385.14
  %304 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul391.14)
  %oreg.sroa.17.28.insert.ext = zext i16 %304 to i64
  %oreg.sroa.17.28.insert.shift = shl nuw nsw i64 %oreg.sroa.17.28.insert.ext, 32
  %oreg.sroa.17.28.insert.insert = or disjoint i64 %oreg.sroa.17.26.insert.insert, %oreg.sroa.17.28.insert.shift
  %out.sroa.92.60.vec.extract = extractelement <4 x float> %out.sroa.92.8, i64 3
  %out_1.sroa.80.60.vec.extract = extractelement <4 x float> %out_1.sroa.80.9, i64 3
  %add385.15 = fadd contract float %out.sroa.92.60.vec.extract, %out_1.sroa.80.60.vec.extract
  %mul391.15 = fmul contract float %289, %add385.15
  %305 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul391.15)
  %oreg.sroa.17.30.insert.ext = zext i16 %305 to i64
  %oreg.sroa.17.30.insert.shift = shl nuw i64 %oreg.sroa.17.30.insert.ext, 48
  %oreg.sroa.17.30.insert.insert = or disjoint i64 %oreg.sroa.17.28.insert.insert, %oreg.sroa.17.30.insert.shift
  %and411 = shl nuw nsw i32 %18, 6
  %mul412 = and i32 %and411, 960
  %and415 = lshr i32 %18, 5
  %shr416 = and i32 %and415, 1
  %and419 = and i32 %18, 7
  %mul425 = and i32 %25, 4
  %xor = xor i32 %shr416, %and419
  %mul420 = shl nuw nsw i32 %xor, 3
  %add421 = or disjoint i32 %mul420, %mul412
  %add426 = or disjoint i32 %add421, %mul425
  %add.ptr428 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add426
  store i64 %oreg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr428, align 8
  %xor.1 = xor i32 %and415, %and419
  %mul420.1 = shl nuw nsw i32 %xor.1, 3
  %add421.1 = or disjoint i32 %mul420.1, %mul412
  %add426.1 = or disjoint i32 %add421.1, %mul425
  %add.ptr428.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add426.1
  store i64 %oreg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr428.1, align 8
  %add417.2 = or disjoint i32 %shr416, 4
  %xor.2 = xor i32 %add417.2, %and419
  %mul420.2 = shl nuw nsw i32 %xor.2, 3
  %add421.2 = or disjoint i32 %mul420.2, %mul412
  %add426.2 = or disjoint i32 %add421.2, %mul425
  %add.ptr428.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add426.2
  store i64 %oreg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr428.2, align 8
  %add417.3 = or i32 %and415, 6
  %xor.3 = xor i32 %add417.3, %and419
  %mul420.3 = shl nuw nsw i32 %xor.3, 3
  %add421.3 = or disjoint i32 %mul420.3, %mul412
  %add426.3 = or disjoint i32 %add421.3, %mul425
  %add.ptr428.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add426.3
  store i64 %oreg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr428.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul440 = and i32 %and104, 448
  %xor447 = xor i32 %and104, %18
  %mul448 = and i32 %xor447, 56
  %306 = or disjoint i32 %mul448, %mul440
  %mul453 = shl nsw i32 %0, 20
  %mul455 = shl nsw i32 %1, 10
  %add456 = add nuw nsw i32 %mul453, %mul455
  %307 = or disjoint i32 %add456, %mul260
  %308 = zext nneg i32 %307 to i64
  %add.ptr451 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %306
  %add.ptr464 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %308
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr464, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr451, i64 16, i1 false), !tbaa.struct !203, !call_argsrelate !204
  %309 = or disjoint i32 %306, 512
  %add.ptr451.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %309
  %310 = or disjoint i64 %308, 512
  %add.ptr464.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %310
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr464.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr451.1, i64 16, i1 false), !tbaa.struct !203, !call_argsrelate !204
  br label %if.end468

if.end468:                                        ; preds = %if.then371, %if.end367
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


