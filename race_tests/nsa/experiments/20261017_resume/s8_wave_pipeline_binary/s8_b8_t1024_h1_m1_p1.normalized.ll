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
  %cond.i.i689 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64)
  %mul11 = shl nsw i32 %cond.i.i689, 4
  %4 = or disjoint i64 %2, 1
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !call_argsrelate !48
  %cond.i.i689.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64)
  %mul11.1 = shl nsw i32 %cond.i.i689.1, 4
  %6 = or disjoint i64 %2, 2
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !call_argsrelate !48
  %cond.i.i689.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64)
  %mul11.2 = shl nsw i32 %cond.i.i689.2, 4
  %8 = or disjoint i64 %2, 3
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !call_argsrelate !48
  %cond.i.i689.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64)
  %mul11.3 = shl nsw i32 %cond.i.i689.3, 4
  %10 = or disjoint i64 %2, 4
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !call_argsrelate !48
  %cond.i.i689.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64)
  %mul11.4 = shl nsw i32 %cond.i.i689.4, 4
  %12 = or disjoint i64 %2, 5
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !call_argsrelate !48
  %cond.i.i689.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64)
  %mul11.5 = shl nsw i32 %cond.i.i689.5, 4
  %14 = or disjoint i64 %2, 6
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !call_argsrelate !48
  %cond.i.i689.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64)
  %mul11.6 = shl nsw i32 %cond.i.i689.6, 4
  %16 = or disjoint i64 %2, 7
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !call_argsrelate !48
  %cond.i.i689.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64)
  %mul11.7 = shl nsw i32 %cond.i.i689.7, 4
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
  %cmp108 = icmp ugt i32 %18, 63
  %shr261.mask = and i32 %18, 960
  %cmp262.not = icmp eq i32 %shr261.mask, 64
  %mul125 = shl nsw i32 %0, 16
  %and132 = shl nuw nsw i32 %18, 3
  %invariant.op = add nsw i32 %1, -15
  %25 = lshr i32 %18, 2
  %mul165 = and i32 %25, 12
  %and254 = shl nuw nsw i32 %18, 2
  %mul288 = and i32 %and132, 504
  %26 = zext nneg i32 %and132 to i64
  %27 = zext nneg i32 %mul288 to i64
  br i1 %cmp108, label %if.end400, label %if.then110

for.body412.preheader:                            ; preds = %if.end400.8
  %add416 = fadd contract float %sums.sroa.0.16, 0.000000e+00
  %add416.1 = fadd contract float %add416, %sums.sroa.22.16
  %add416.2 = fadd contract float %add416.1, %sums.sroa.42.16
  %add416.3 = fadd contract float %add416.2, %sums.sroa.62.16
  %28 = bitcast float %add416.3 to i32
  %29 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %30 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %29) #11
  %xor.i.i = xor i32 %30, 32
  %31 = and i32 %30, -64
  %and.i.i = add nsw i32 %31, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i690 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %30
  %shl.i.i = shl i32 %cond.i.i690, 2
  %32 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %28)
  %33 = bitcast i32 %32 to float
  %add424 = fadd contract float %add416.3, %33
  %34 = bitcast float %add424 to i32
  %35 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %36 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %35) #11
  %xor.i.i691 = xor i32 %36, 16
  %37 = and i32 %36, -64
  %and.i.i692 = add nsw i32 %37, 64
  %cmp.not.i.i693 = icmp slt i32 %xor.i.i691, %and.i.i692
  %cond.i.i694 = select i1 %cmp.not.i.i693, i32 %xor.i.i691, i32 %36
  %shl.i.i695 = shl i32 %cond.i.i694, 2
  %38 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i695, i32 %34)
  %39 = bitcast i32 %38 to float
  %add429 = fadd contract float %add424, %39
  %cmp432 = fcmp contract ogt float %add429, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add429
  %condval_1.0 = select i1 %cmp432, float %div, float 0.000000e+00
  %arrayidx442 = getelementptr inbounds float, ptr addrspace(3) @buf_dyn_shmem, i32 %18
  store float %condval_1.0, ptr addrspace(3) %arrayidx442, align 4, !tbaa !105
  br label %if.end443

if.then110:                                       ; preds = %if.end
  %or.cond722 = icmp ugt i32 %mul11, 1023
  %cmp118.not = icmp sgt i32 %mul11, %1
  %or.cond723 = or i1 %or.cond722, %cmp118.not
  br i1 %or.cond723, label %if.end144, label %for.cond120.preheader

for.cond120.preheader:                            ; preds = %if.then110
  %40 = shl nsw i32 %cond.i.i689, 10
  %mul127 = and i32 %40, 64512
  %add128 = or disjoint i32 %mul127, %mul125
  %41 = zext nneg i32 %add128 to i64
  %42 = or disjoint i64 %41, %26
  %add.ptr136 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %42
  %kr.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr136, align 16
  %kr.sroa.20.0.add.ptr136.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr136, i64 8
  %kr.sroa.20.0.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.20.0.add.ptr136.sroa_idx, align 8
  %43 = or disjoint i64 %41, %26
  %44 = or disjoint i64 %43, 512
  %add.ptr136.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %44
  %kr.sroa.29.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr136.1, align 16
  %kr.sroa.47.16.add.ptr136.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr136.1, i64 8
  %kr.sroa.47.16.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.47.16.add.ptr136.1.sroa_idx, align 8
  br label %if.end144

if.end144:                                        ; preds = %for.cond120.preheader, %if.then110
  %kr.sroa.47.0 = phi <4 x half> [ undef, %if.then110 ], [ %kr.sroa.47.16.copyload, %for.cond120.preheader ]
  %kr.sroa.29.0 = phi <4 x half> [ undef, %if.then110 ], [ %kr.sroa.29.16.copyload, %for.cond120.preheader ]
  %kr.sroa.20.0 = phi <4 x half> [ undef, %if.then110 ], [ %kr.sroa.20.0.copyload, %for.cond120.preheader ]
  %kr.sroa.0.0 = phi <4 x half> [ undef, %if.then110 ], [ %kr.sroa.0.0.copyload, %for.cond120.preheader ]
  br i1 %or.cond723, label %if.end248, label %if.then153

if.then153:                                       ; preds = %if.end144
  %cmp156 = icmp sgt i32 %mul11, %invariant.op
  br i1 %cmp156, label %for.cond158.preheader, label %if.end184

for.cond158.preheader:                            ; preds = %if.then153
  %add166 = or disjoint i32 %mul11, %mul165
  %cmp169.not = icmp sgt i32 %add166, %1
  %spec.select = select i1 %cmp169.not, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert948 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp169.not.1.not = icmp slt i32 %add166, %1
  %spec.select.1 = select i1 %cmp169.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1051 = insertelement <4 x float> %scores.sroa.0.0.vec.insert948, float %spec.select.1, i64 1
  %add167.2 = or disjoint i32 %add166, 2
  %cmp169.not.2 = icmp sgt i32 %add167.2, %1
  %spec.select.2 = select i1 %cmp169.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1138 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1051, float %spec.select.2, i64 2
  %add167.3 = or disjoint i32 %add166, 3
  %cmp169.not.3 = icmp sgt i32 %add167.3, %1
  %spec.select.3 = select i1 %cmp169.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1225 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1138, float %spec.select.3, i64 3
  br label %if.end184

if.end184:                                        ; preds = %if.then153, %for.cond158.preheader
  %scores.sroa.0.0 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1225, %for.cond158.preheader ], [ zeroinitializer, %if.then153 ]
  %45 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.0)
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.20.0, <4 x half> %qr.sroa.12.0, <4 x float> %45)
  %47 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.29.0, <4 x half> %qr.sroa.21.0, <4 x float> %46)
  %48 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.0, <4 x half> %qr.sroa.31.0, <4 x float> %47)
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %48, i64 0
  %mul208 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %49 = tail call contract noundef float @llvm.minnum.f32(float %mul208, float 0x4024CB5EC0000000)
  %50 = tail call contract noundef float @llvm.exp.f32(float %49)
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %48, i64 1
  %mul208.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %51 = tail call contract noundef float @llvm.minnum.f32(float %mul208.1, float 0x4024CB5EC0000000)
  %52 = tail call contract noundef float @llvm.exp.f32(float %51)
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %48, i64 2
  %mul208.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %53 = tail call contract noundef float @llvm.minnum.f32(float %mul208.2, float 0x4024CB5EC0000000)
  %54 = tail call contract noundef float @llvm.exp.f32(float %53)
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %48, i64 3
  %mul208.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %55 = tail call contract noundef float @llvm.minnum.f32(float %mul208.3, float 0x4024CB5EC0000000)
  %56 = tail call contract noundef float @llvm.exp.f32(float %55)
  %57 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %50)
  %probs.sroa.0.0.vec.insert = insertelement <4 x i16> poison, i16 %57, i64 0
  %58 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %52)
  %probs.sroa.0.2.vec.insert = insertelement <4 x i16> %probs.sroa.0.0.vec.insert, i16 %58, i64 1
  %59 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %54)
  %probs.sroa.0.4.vec.insert = insertelement <4 x i16> %probs.sroa.0.2.vec.insert, i16 %59, i64 2
  %60 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %56)
  %probs.sroa.0.6.vec.insert = insertelement <4 x i16> %probs.sroa.0.4.vec.insert, i16 %60, i64 3
  br label %if.end248

if.end248:                                        ; preds = %if.end144, %if.end184
  %sums.sroa.62.1 = phi float [ %56, %if.end184 ], [ 0.000000e+00, %if.end144 ]
  %sums.sroa.42.1 = phi float [ %54, %if.end184 ], [ 0.000000e+00, %if.end144 ]
  %sums.sroa.22.1 = phi float [ %52, %if.end184 ], [ 0.000000e+00, %if.end144 ]
  %sums.sroa.0.1 = phi float [ %50, %if.end184 ], [ 0.000000e+00, %if.end144 ]
  %probs.sroa.0.0 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert, %if.end184 ], [ zeroinitializer, %if.end144 ]
  %add.ptr258 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and254
  store <4 x i16> %probs.sroa.0.0, ptr addrspace(3) %add.ptr258, align 8
  br label %if.end400

if.end400:                                        ; preds = %if.end, %if.end248
  %sums.sroa.62.2 = phi float [ 0.000000e+00, %if.end ], [ %sums.sroa.62.1, %if.end248 ]
  %sums.sroa.42.2 = phi float [ 0.000000e+00, %if.end ], [ %sums.sroa.42.1, %if.end248 ]
  %sums.sroa.22.2 = phi float [ 0.000000e+00, %if.end ], [ %sums.sroa.22.1, %if.end248 ]
  %sums.sroa.0.2 = phi float [ 0.000000e+00, %if.end ], [ %sums.sroa.0.1, %if.end248 ]
  %kr.sroa.47.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.47.0, %if.end248 ]
  %kr.sroa.29.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.29.0, %if.end248 ]
  %kr.sroa.20.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.20.0, %if.end248 ]
  %kr.sroa.0.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.0.0, %if.end248 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %cmp108, label %if.end259.1, label %if.then110.1

if.then110.1:                                     ; preds = %if.end400
  %or.cond722.1 = icmp ugt i32 %mul11.1, 1023
  %cmp118.not.1 = icmp sgt i32 %mul11.1, %1
  %or.cond723.1 = or i1 %or.cond722.1, %cmp118.not.1
  br i1 %or.cond723.1, label %if.end144.1, label %for.cond120.preheader.1

for.cond120.preheader.1:                          ; preds = %if.then110.1
  %61 = shl nsw i32 %cond.i.i689.1, 10
  %mul127.1 = and i32 %61, 64512
  %add128.1 = or disjoint i32 %mul127.1, %mul125
  %62 = zext nneg i32 %add128.1 to i64
  %63 = or disjoint i64 %62, %26
  %add.ptr136.1748 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %63
  %kr.sroa.0.0.copyload1455 = load <4 x half>, ptr addrspace(4) %add.ptr136.1748, align 16
  %kr.sroa.20.0.add.ptr136.1748.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr136.1748, i64 8
  %kr.sroa.20.0.copyload1463 = load <4 x half>, ptr addrspace(4) %kr.sroa.20.0.add.ptr136.1748.sroa_idx, align 8
  %64 = or disjoint i64 %62, %26
  %65 = or disjoint i64 %64, 512
  %add.ptr136.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %65
  %kr.sroa.29.16.copyload1487 = load <4 x half>, ptr addrspace(4) %add.ptr136.1.1, align 16
  %kr.sroa.47.16.add.ptr136.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr136.1.1, i64 8
  %kr.sroa.47.16.copyload1495 = load <4 x half>, ptr addrspace(4) %kr.sroa.47.16.add.ptr136.1.1.sroa_idx, align 8
  br label %if.end144.1

if.end144.1:                                      ; preds = %for.cond120.preheader.1, %if.then110.1
  %kr.sroa.47.2 = phi <4 x half> [ %kr.sroa.47.1, %if.then110.1 ], [ %kr.sroa.47.16.copyload1495, %for.cond120.preheader.1 ]
  %kr.sroa.29.2 = phi <4 x half> [ %kr.sroa.29.1, %if.then110.1 ], [ %kr.sroa.29.16.copyload1487, %for.cond120.preheader.1 ]
  %kr.sroa.20.2 = phi <4 x half> [ %kr.sroa.20.1, %if.then110.1 ], [ %kr.sroa.20.0.copyload1463, %for.cond120.preheader.1 ]
  %kr.sroa.0.2 = phi <4 x half> [ %kr.sroa.0.1, %if.then110.1 ], [ %kr.sroa.0.0.copyload1455, %for.cond120.preheader.1 ]
  br i1 %or.cond723.1, label %if.end248.1, label %if.then153.1

if.then153.1:                                     ; preds = %if.end144.1
  %cmp156.1 = icmp sgt i32 %mul11.1, %invariant.op
  br i1 %cmp156.1, label %for.cond158.preheader.1, label %if.end184.1

for.cond158.preheader.1:                          ; preds = %if.then153.1
  %add166.1 = or disjoint i32 %mul11.1, %mul165
  %cmp169.not.1749 = icmp sgt i32 %add166.1, %1
  %spec.select.1750 = select i1 %cmp169.not.1749, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert957 = insertelement <4 x float> poison, float %spec.select.1750, i64 0
  %cmp169.not.1.1.not = icmp slt i32 %add166.1, %1
  %spec.select.1.1 = select i1 %cmp169.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1058 = insertelement <4 x float> %scores.sroa.0.0.vec.insert957, float %spec.select.1.1, i64 1
  %add167.2.1 = or disjoint i32 %add166.1, 2
  %cmp169.not.2.1 = icmp sgt i32 %add167.2.1, %1
  %spec.select.2.1 = select i1 %cmp169.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1145 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1058, float %spec.select.2.1, i64 2
  %add167.3.1 = or disjoint i32 %add166.1, 3
  %cmp169.not.3.1 = icmp sgt i32 %add167.3.1, %1
  %spec.select.3.1 = select i1 %cmp169.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1232 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1145, float %spec.select.3.1, i64 3
  br label %if.end184.1

if.end184.1:                                      ; preds = %if.then153.1, %for.cond158.preheader.1
  %scores.sroa.0.3 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1232, %for.cond158.preheader.1 ], [ zeroinitializer, %if.then153.1 ]
  %66 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.2, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.3)
  %67 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.20.2, <4 x half> %qr.sroa.12.0, <4 x float> %66)
  %68 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.29.2, <4 x half> %qr.sroa.21.0, <4 x float> %67)
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.2, <4 x half> %qr.sroa.31.0, <4 x float> %68)
  %scores.sroa.0.0.vec.extract959 = extractelement <4 x float> %69, i64 0
  %mul208.1751 = fmul contract float %scores.sroa.0.0.vec.extract959, 0x3FB99999A0000000
  %70 = tail call contract noundef float @llvm.minnum.f32(float %mul208.1751, float 0x4024CB5EC0000000)
  %71 = tail call contract noundef float @llvm.exp.f32(float %70)
  %scores.sroa.0.4.vec.extract1060 = extractelement <4 x float> %69, i64 1
  %mul208.1.1 = fmul contract float %scores.sroa.0.4.vec.extract1060, 0x3FB99999A0000000
  %72 = tail call contract noundef float @llvm.minnum.f32(float %mul208.1.1, float 0x4024CB5EC0000000)
  %73 = tail call contract noundef float @llvm.exp.f32(float %72)
  %scores.sroa.0.8.vec.extract1147 = extractelement <4 x float> %69, i64 2
  %mul208.2.1 = fmul contract float %scores.sroa.0.8.vec.extract1147, 0x3FB99999A0000000
  %74 = tail call contract noundef float @llvm.minnum.f32(float %mul208.2.1, float 0x4024CB5EC0000000)
  %75 = tail call contract noundef float @llvm.exp.f32(float %74)
  %scores.sroa.0.12.vec.extract1234 = extractelement <4 x float> %69, i64 3
  %mul208.3.1 = fmul contract float %scores.sroa.0.12.vec.extract1234, 0x3FB99999A0000000
  %76 = tail call contract noundef float @llvm.minnum.f32(float %mul208.3.1, float 0x4024CB5EC0000000)
  %77 = tail call contract noundef float @llvm.exp.f32(float %76)
  %add224.1752 = fadd contract float %sums.sroa.0.2, %71
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %71)
  %probs.sroa.0.0.vec.insert1349 = insertelement <4 x i16> poison, i16 %78, i64 0
  %add224.1.1 = fadd contract float %sums.sroa.22.2, %73
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %73)
  %probs.sroa.0.2.vec.insert1383 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1349, i16 %79, i64 1
  %add224.2.1 = fadd contract float %sums.sroa.42.2, %75
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %75)
  %probs.sroa.0.4.vec.insert1416 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1383, i16 %80, i64 2
  %add224.3.1 = fadd contract float %sums.sroa.62.2, %77
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %77)
  %probs.sroa.0.6.vec.insert1432 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1416, i16 %81, i64 3
  br label %if.end248.1

if.end248.1:                                      ; preds = %if.end144.1, %if.end184.1
  %sums.sroa.62.3 = phi float [ %add224.3.1, %if.end184.1 ], [ %sums.sroa.62.2, %if.end144.1 ]
  %sums.sroa.42.3 = phi float [ %add224.2.1, %if.end184.1 ], [ %sums.sroa.42.2, %if.end144.1 ]
  %sums.sroa.22.3 = phi float [ %add224.1.1, %if.end184.1 ], [ %sums.sroa.22.2, %if.end144.1 ]
  %sums.sroa.0.3 = phi float [ %add224.1752, %if.end184.1 ], [ %sums.sroa.0.2, %if.end144.1 ]
  %probs.sroa.0.3 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1432, %if.end184.1 ], [ zeroinitializer, %if.end144.1 ]
  %add256.1 = or disjoint i32 %and254, 256
  %add.ptr258.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add256.1
  store <4 x i16> %probs.sroa.0.3, ptr addrspace(3) %add.ptr258.1, align 8
  br label %if.end259.1

if.end259.1:                                      ; preds = %if.end248.1, %if.end400
  %sums.sroa.62.4 = phi float [ %sums.sroa.62.2, %if.end400 ], [ %sums.sroa.62.3, %if.end248.1 ]
  %sums.sroa.42.4 = phi float [ %sums.sroa.42.2, %if.end400 ], [ %sums.sroa.42.3, %if.end248.1 ]
  %sums.sroa.22.4 = phi float [ %sums.sroa.22.2, %if.end400 ], [ %sums.sroa.22.3, %if.end248.1 ]
  %sums.sroa.0.4 = phi float [ %sums.sroa.0.2, %if.end400 ], [ %sums.sroa.0.3, %if.end248.1 ]
  %kr.sroa.47.3 = phi <4 x half> [ %kr.sroa.47.1, %if.end400 ], [ %kr.sroa.47.2, %if.end248.1 ]
  %kr.sroa.29.3 = phi <4 x half> [ %kr.sroa.29.1, %if.end400 ], [ %kr.sroa.29.2, %if.end248.1 ]
  %kr.sroa.20.3 = phi <4 x half> [ %kr.sroa.20.1, %if.end400 ], [ %kr.sroa.20.2, %if.end248.1 ]
  %kr.sroa.0.3 = phi <4 x half> [ %kr.sroa.0.1, %if.end400 ], [ %kr.sroa.0.2, %if.end248.1 ]
  br i1 %cmp262.not, label %if.then265.1, label %if.end400.1

if.then265.1:                                     ; preds = %if.end259.1
  %or.cond726.1 = icmp ugt i32 %mul11, 1023
  %cmp273.not.1 = icmp sgt i32 %mul11, %1
  %or.cond727.1 = or i1 %or.cond726.1, %cmp273.not.1
  br i1 %or.cond727.1, label %if.end400.1, label %for.cond313.preheader.1

for.cond313.preheader.1:                          ; preds = %if.then265.1
  %add305.1 = and i32 %and254, 252
  %add.ptr307.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add305.1
  %82 = load <4 x half>, ptr addrspace(3) %add.ptr307.1, align 8
  %83 = shl nsw i32 %cond.i.i689, 10
  %mul282.1 = and i32 %83, 64512
  %add283.1 = or disjoint i32 %mul282.1, %mul125
  %84 = zext nneg i32 %add283.1 to i64
  %85 = or disjoint i64 %84, %27
  %86 = or disjoint i64 %85, 512
  %add.ptr291.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %86
  %vr.sroa.128.16.add.ptr291.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr291.1.1, i64 8
  %vr.sroa.128.16.copyload895 = load <4 x half>, ptr addrspace(4) %vr.sroa.128.16.add.ptr291.1.1.sroa_idx, align 8
  %vr.sroa.83.16.copyload887 = load <4 x half>, ptr addrspace(4) %add.ptr291.1.1, align 16
  %87 = or disjoint i64 %84, %27
  %add.ptr291.1753 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %87
  %vr.sroa.47.0.add.ptr291.1753.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr291.1753, i64 8
  %vr.sroa.47.0.copyload809 = load <4 x half>, ptr addrspace(4) %vr.sroa.47.0.add.ptr291.1753.sroa_idx, align 8
  %vr.sroa.0.0.copyload801 = load <4 x half>, ptr addrspace(4) %add.ptr291.1753, align 16
  %88 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload801, <4 x half> %82, <4 x float> zeroinitializer), !call_argsrelate !164
  %89 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.47.0.copyload809, <4 x half> %82, <4 x float> zeroinitializer), !call_argsrelate !164
  %90 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.83.16.copyload887, <4 x half> %82, <4 x float> zeroinitializer), !call_argsrelate !164
  %91 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.128.16.copyload895, <4 x half> %82, <4 x float> zeroinitializer), !call_argsrelate !164
  br label %if.end400.1

if.end400.1:                                      ; preds = %for.cond313.preheader.1, %if.then265.1, %if.end259.1
  %out.sroa.116.2 = phi <4 x float> [ zeroinitializer, %if.end259.1 ], [ zeroinitializer, %if.then265.1 ], [ %91, %for.cond313.preheader.1 ]
  %out.sroa.78.2 = phi <4 x float> [ zeroinitializer, %if.end259.1 ], [ zeroinitializer, %if.then265.1 ], [ %90, %for.cond313.preheader.1 ]
  %out.sroa.40.2 = phi <4 x float> [ zeroinitializer, %if.end259.1 ], [ zeroinitializer, %if.then265.1 ], [ %89, %for.cond313.preheader.1 ]
  %out.sroa.0.2 = phi <4 x float> [ zeroinitializer, %if.end259.1 ], [ zeroinitializer, %if.then265.1 ], [ %88, %for.cond313.preheader.1 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %cmp108, label %if.end259.2, label %if.then110.2

if.then110.2:                                     ; preds = %if.end400.1
  %or.cond722.2 = icmp ugt i32 %mul11.2, 1023
  %cmp118.not.2 = icmp sgt i32 %mul11.2, %1
  %or.cond723.2 = or i1 %or.cond722.2, %cmp118.not.2
  br i1 %or.cond723.2, label %if.end144.2, label %for.cond120.preheader.2

for.cond120.preheader.2:                          ; preds = %if.then110.2
  %92 = shl nsw i32 %cond.i.i689.2, 10
  %mul127.2 = and i32 %92, 64512
  %add128.2 = or disjoint i32 %mul127.2, %mul125
  %93 = zext nneg i32 %add128.2 to i64
  %94 = or disjoint i64 %93, %26
  %add.ptr136.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %94
  %kr.sroa.0.0.copyload1456 = load <4 x half>, ptr addrspace(4) %add.ptr136.2, align 16
  %kr.sroa.20.0.add.ptr136.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr136.2, i64 8
  %kr.sroa.20.0.copyload1464 = load <4 x half>, ptr addrspace(4) %kr.sroa.20.0.add.ptr136.2.sroa_idx, align 8
  %95 = or disjoint i64 %93, %26
  %96 = or disjoint i64 %95, 512
  %add.ptr136.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %96
  %kr.sroa.29.16.copyload1488 = load <4 x half>, ptr addrspace(4) %add.ptr136.1.2, align 16
  %kr.sroa.47.16.add.ptr136.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr136.1.2, i64 8
  %kr.sroa.47.16.copyload1496 = load <4 x half>, ptr addrspace(4) %kr.sroa.47.16.add.ptr136.1.2.sroa_idx, align 8
  br label %if.end144.2

if.end144.2:                                      ; preds = %for.cond120.preheader.2, %if.then110.2
  %kr.sroa.47.4 = phi <4 x half> [ %kr.sroa.47.3, %if.then110.2 ], [ %kr.sroa.47.16.copyload1496, %for.cond120.preheader.2 ]
  %kr.sroa.29.4 = phi <4 x half> [ %kr.sroa.29.3, %if.then110.2 ], [ %kr.sroa.29.16.copyload1488, %for.cond120.preheader.2 ]
  %kr.sroa.20.4 = phi <4 x half> [ %kr.sroa.20.3, %if.then110.2 ], [ %kr.sroa.20.0.copyload1464, %for.cond120.preheader.2 ]
  %kr.sroa.0.4 = phi <4 x half> [ %kr.sroa.0.3, %if.then110.2 ], [ %kr.sroa.0.0.copyload1456, %for.cond120.preheader.2 ]
  br i1 %or.cond723.2, label %if.end248.2, label %if.then153.2

if.then153.2:                                     ; preds = %if.end144.2
  %cmp156.2 = icmp sgt i32 %mul11.2, %invariant.op
  br i1 %cmp156.2, label %for.cond158.preheader.2, label %if.end184.2

for.cond158.preheader.2:                          ; preds = %if.then153.2
  %add166.2 = or disjoint i32 %mul11.2, %mul165
  %cmp169.not.2754 = icmp sgt i32 %add166.2, %1
  %spec.select.2755 = select i1 %cmp169.not.2754, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert967 = insertelement <4 x float> poison, float %spec.select.2755, i64 0
  %cmp169.not.1.2.not = icmp slt i32 %add166.2, %1
  %spec.select.1.2 = select i1 %cmp169.not.1.2.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1066 = insertelement <4 x float> %scores.sroa.0.0.vec.insert967, float %spec.select.1.2, i64 1
  %add167.2.2 = or disjoint i32 %add166.2, 2
  %cmp169.not.2.2 = icmp sgt i32 %add167.2.2, %1
  %spec.select.2.2 = select i1 %cmp169.not.2.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1153 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1066, float %spec.select.2.2, i64 2
  %add167.3.2 = or disjoint i32 %add166.2, 3
  %cmp169.not.3.2 = icmp sgt i32 %add167.3.2, %1
  %spec.select.3.2 = select i1 %cmp169.not.3.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1240 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1153, float %spec.select.3.2, i64 3
  br label %if.end184.2

if.end184.2:                                      ; preds = %if.then153.2, %for.cond158.preheader.2
  %scores.sroa.0.6 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1240, %for.cond158.preheader.2 ], [ zeroinitializer, %if.then153.2 ]
  %97 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.4, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.6)
  %98 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.20.4, <4 x half> %qr.sroa.12.0, <4 x float> %97)
  %99 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.29.4, <4 x half> %qr.sroa.21.0, <4 x float> %98)
  %100 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.4, <4 x half> %qr.sroa.31.0, <4 x float> %99)
  %scores.sroa.0.0.vec.extract969 = extractelement <4 x float> %100, i64 0
  %mul208.2756 = fmul contract float %scores.sroa.0.0.vec.extract969, 0x3FB99999A0000000
  %101 = tail call contract noundef float @llvm.minnum.f32(float %mul208.2756, float 0x4024CB5EC0000000)
  %102 = tail call contract noundef float @llvm.exp.f32(float %101)
  %scores.sroa.0.4.vec.extract1068 = extractelement <4 x float> %100, i64 1
  %mul208.1.2 = fmul contract float %scores.sroa.0.4.vec.extract1068, 0x3FB99999A0000000
  %103 = tail call contract noundef float @llvm.minnum.f32(float %mul208.1.2, float 0x4024CB5EC0000000)
  %104 = tail call contract noundef float @llvm.exp.f32(float %103)
  %scores.sroa.0.8.vec.extract1155 = extractelement <4 x float> %100, i64 2
  %mul208.2.2 = fmul contract float %scores.sroa.0.8.vec.extract1155, 0x3FB99999A0000000
  %105 = tail call contract noundef float @llvm.minnum.f32(float %mul208.2.2, float 0x4024CB5EC0000000)
  %106 = tail call contract noundef float @llvm.exp.f32(float %105)
  %scores.sroa.0.12.vec.extract1242 = extractelement <4 x float> %100, i64 3
  %mul208.3.2 = fmul contract float %scores.sroa.0.12.vec.extract1242, 0x3FB99999A0000000
  %107 = tail call contract noundef float @llvm.minnum.f32(float %mul208.3.2, float 0x4024CB5EC0000000)
  %108 = tail call contract noundef float @llvm.exp.f32(float %107)
  %add224.2757 = fadd contract float %sums.sroa.0.4, %102
  %109 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %102)
  %probs.sroa.0.0.vec.insert1351 = insertelement <4 x i16> poison, i16 %109, i64 0
  %add224.1.2 = fadd contract float %sums.sroa.22.4, %104
  %110 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %104)
  %probs.sroa.0.2.vec.insert1385 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1351, i16 %110, i64 1
  %add224.2.2 = fadd contract float %sums.sroa.42.4, %106
  %111 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %106)
  %probs.sroa.0.4.vec.insert1418 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1385, i16 %111, i64 2
  %add224.3.2 = fadd contract float %sums.sroa.62.4, %108
  %112 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %108)
  %probs.sroa.0.6.vec.insert1434 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1418, i16 %112, i64 3
  br label %if.end248.2

if.end248.2:                                      ; preds = %if.end144.2, %if.end184.2
  %sums.sroa.62.5 = phi float [ %add224.3.2, %if.end184.2 ], [ %sums.sroa.62.4, %if.end144.2 ]
  %sums.sroa.42.5 = phi float [ %add224.2.2, %if.end184.2 ], [ %sums.sroa.42.4, %if.end144.2 ]
  %sums.sroa.22.5 = phi float [ %add224.1.2, %if.end184.2 ], [ %sums.sroa.22.4, %if.end144.2 ]
  %sums.sroa.0.5 = phi float [ %add224.2757, %if.end184.2 ], [ %sums.sroa.0.4, %if.end144.2 ]
  %probs.sroa.0.6 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1434, %if.end184.2 ], [ zeroinitializer, %if.end144.2 ]
  %add.ptr258.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and254
  store <4 x i16> %probs.sroa.0.6, ptr addrspace(3) %add.ptr258.2, align 8
  br label %if.end259.2

if.end259.2:                                      ; preds = %if.end248.2, %if.end400.1
  %sums.sroa.62.6 = phi float [ %sums.sroa.62.4, %if.end400.1 ], [ %sums.sroa.62.5, %if.end248.2 ]
  %sums.sroa.42.6 = phi float [ %sums.sroa.42.4, %if.end400.1 ], [ %sums.sroa.42.5, %if.end248.2 ]
  %sums.sroa.22.6 = phi float [ %sums.sroa.22.4, %if.end400.1 ], [ %sums.sroa.22.5, %if.end248.2 ]
  %sums.sroa.0.6 = phi float [ %sums.sroa.0.4, %if.end400.1 ], [ %sums.sroa.0.5, %if.end248.2 ]
  %kr.sroa.47.5 = phi <4 x half> [ %kr.sroa.47.3, %if.end400.1 ], [ %kr.sroa.47.4, %if.end248.2 ]
  %kr.sroa.29.5 = phi <4 x half> [ %kr.sroa.29.3, %if.end400.1 ], [ %kr.sroa.29.4, %if.end248.2 ]
  %kr.sroa.20.5 = phi <4 x half> [ %kr.sroa.20.3, %if.end400.1 ], [ %kr.sroa.20.4, %if.end248.2 ]
  %kr.sroa.0.5 = phi <4 x half> [ %kr.sroa.0.3, %if.end400.1 ], [ %kr.sroa.0.4, %if.end248.2 ]
  br i1 %cmp262.not, label %if.then265.2, label %if.end400.2

if.then265.2:                                     ; preds = %if.end259.2
  %or.cond726.2 = icmp ugt i32 %mul11.1, 1023
  %cmp273.not.2 = icmp sgt i32 %mul11.1, %1
  %or.cond727.2 = or i1 %or.cond726.2, %cmp273.not.2
  br i1 %or.cond727.2, label %if.end400.2, label %for.cond336.preheader.2

for.cond336.preheader.2:                          ; preds = %if.then265.2
  %add.ptr307.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and254
  %113 = load <4 x half>, ptr addrspace(3) %add.ptr307.2, align 8
  %114 = shl nsw i32 %cond.i.i689.1, 10
  %mul282.2 = and i32 %114, 64512
  %add283.2 = or disjoint i32 %mul282.2, %mul125
  %115 = zext nneg i32 %add283.2 to i64
  %116 = or disjoint i64 %115, %27
  %117 = or disjoint i64 %116, 512
  %add.ptr291.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %117
  %vr.sroa.128.16.add.ptr291.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr291.1.2, i64 8
  %vr.sroa.128.16.copyload896 = load <4 x half>, ptr addrspace(4) %vr.sroa.128.16.add.ptr291.1.2.sroa_idx, align 8
  %vr.sroa.83.16.copyload888 = load <4 x half>, ptr addrspace(4) %add.ptr291.1.2, align 16
  %118 = or disjoint i64 %115, %27
  %add.ptr291.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %118
  %vr.sroa.47.0.add.ptr291.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr291.2, i64 8
  %vr.sroa.47.0.copyload810 = load <4 x half>, ptr addrspace(4) %vr.sroa.47.0.add.ptr291.2.sroa_idx, align 8
  %vr.sroa.0.0.copyload802 = load <4 x half>, ptr addrspace(4) %add.ptr291.2, align 16
  %119 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload802, <4 x half> %113, <4 x float> zeroinitializer), !call_argsrelate !164
  %120 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.47.0.copyload810, <4 x half> %113, <4 x float> zeroinitializer), !call_argsrelate !164
  %121 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.83.16.copyload888, <4 x half> %113, <4 x float> zeroinitializer), !call_argsrelate !164
  %122 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.128.16.copyload896, <4 x half> %113, <4 x float> zeroinitializer), !call_argsrelate !164
  br label %if.end400.2

if.end400.2:                                      ; preds = %for.cond336.preheader.2, %if.then265.2, %if.end259.2
  %out_1.sroa.80.3 = phi <4 x float> [ zeroinitializer, %if.end259.2 ], [ zeroinitializer, %if.then265.2 ], [ %122, %for.cond336.preheader.2 ]
  %out_1.sroa.54.3 = phi <4 x float> [ zeroinitializer, %if.end259.2 ], [ zeroinitializer, %if.then265.2 ], [ %121, %for.cond336.preheader.2 ]
  %out_1.sroa.28.3 = phi <4 x float> [ zeroinitializer, %if.end259.2 ], [ zeroinitializer, %if.then265.2 ], [ %120, %for.cond336.preheader.2 ]
  %out_1.sroa.0.3 = phi <4 x float> [ zeroinitializer, %if.end259.2 ], [ zeroinitializer, %if.then265.2 ], [ %119, %for.cond336.preheader.2 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %cmp108, label %if.end259.3, label %if.then110.3

if.then110.3:                                     ; preds = %if.end400.2
  %or.cond722.3 = icmp ugt i32 %mul11.3, 1023
  %cmp118.not.3 = icmp sgt i32 %mul11.3, %1
  %or.cond723.3 = or i1 %or.cond722.3, %cmp118.not.3
  br i1 %or.cond723.3, label %if.end144.3, label %for.cond120.preheader.3

for.cond120.preheader.3:                          ; preds = %if.then110.3
  %123 = shl nsw i32 %cond.i.i689.3, 10
  %mul127.3 = and i32 %123, 64512
  %add128.3 = or disjoint i32 %mul127.3, %mul125
  %124 = zext nneg i32 %add128.3 to i64
  %125 = or disjoint i64 %124, %26
  %add.ptr136.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %125
  %kr.sroa.0.0.copyload1457 = load <4 x half>, ptr addrspace(4) %add.ptr136.3, align 16
  %kr.sroa.20.0.add.ptr136.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr136.3, i64 8
  %kr.sroa.20.0.copyload1465 = load <4 x half>, ptr addrspace(4) %kr.sroa.20.0.add.ptr136.3.sroa_idx, align 8
  %126 = or disjoint i64 %124, %26
  %127 = or disjoint i64 %126, 512
  %add.ptr136.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %127
  %kr.sroa.29.16.copyload1489 = load <4 x half>, ptr addrspace(4) %add.ptr136.1.3, align 16
  %kr.sroa.47.16.add.ptr136.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr136.1.3, i64 8
  %kr.sroa.47.16.copyload1497 = load <4 x half>, ptr addrspace(4) %kr.sroa.47.16.add.ptr136.1.3.sroa_idx, align 8
  br label %if.end144.3

if.end144.3:                                      ; preds = %for.cond120.preheader.3, %if.then110.3
  %kr.sroa.47.6 = phi <4 x half> [ %kr.sroa.47.5, %if.then110.3 ], [ %kr.sroa.47.16.copyload1497, %for.cond120.preheader.3 ]
  %kr.sroa.29.6 = phi <4 x half> [ %kr.sroa.29.5, %if.then110.3 ], [ %kr.sroa.29.16.copyload1489, %for.cond120.preheader.3 ]
  %kr.sroa.20.6 = phi <4 x half> [ %kr.sroa.20.5, %if.then110.3 ], [ %kr.sroa.20.0.copyload1465, %for.cond120.preheader.3 ]
  %kr.sroa.0.6 = phi <4 x half> [ %kr.sroa.0.5, %if.then110.3 ], [ %kr.sroa.0.0.copyload1457, %for.cond120.preheader.3 ]
  br i1 %or.cond723.3, label %if.end248.3, label %if.then153.3

if.then153.3:                                     ; preds = %if.end144.3
  %cmp156.3 = icmp sgt i32 %mul11.3, %invariant.op
  br i1 %cmp156.3, label %for.cond158.preheader.3, label %if.end184.3

for.cond158.preheader.3:                          ; preds = %if.then153.3
  %add166.3 = or disjoint i32 %mul11.3, %mul165
  %cmp169.not.3758 = icmp sgt i32 %add166.3, %1
  %spec.select.3759 = select i1 %cmp169.not.3758, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert977 = insertelement <4 x float> poison, float %spec.select.3759, i64 0
  %cmp169.not.1.3.not = icmp slt i32 %add166.3, %1
  %spec.select.1.3 = select i1 %cmp169.not.1.3.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1074 = insertelement <4 x float> %scores.sroa.0.0.vec.insert977, float %spec.select.1.3, i64 1
  %add167.2.3 = or disjoint i32 %add166.3, 2
  %cmp169.not.2.3 = icmp sgt i32 %add167.2.3, %1
  %spec.select.2.3 = select i1 %cmp169.not.2.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1161 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1074, float %spec.select.2.3, i64 2
  %add167.3.3 = or disjoint i32 %add166.3, 3
  %cmp169.not.3.3 = icmp sgt i32 %add167.3.3, %1
  %spec.select.3.3 = select i1 %cmp169.not.3.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1248 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1161, float %spec.select.3.3, i64 3
  br label %if.end184.3

if.end184.3:                                      ; preds = %if.then153.3, %for.cond158.preheader.3
  %scores.sroa.0.9 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1248, %for.cond158.preheader.3 ], [ zeroinitializer, %if.then153.3 ]
  %128 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.6, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.9)
  %129 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.20.6, <4 x half> %qr.sroa.12.0, <4 x float> %128)
  %130 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.29.6, <4 x half> %qr.sroa.21.0, <4 x float> %129)
  %131 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.6, <4 x half> %qr.sroa.31.0, <4 x float> %130)
  %scores.sroa.0.0.vec.extract979 = extractelement <4 x float> %131, i64 0
  %mul208.3760 = fmul contract float %scores.sroa.0.0.vec.extract979, 0x3FB99999A0000000
  %132 = tail call contract noundef float @llvm.minnum.f32(float %mul208.3760, float 0x4024CB5EC0000000)
  %133 = tail call contract noundef float @llvm.exp.f32(float %132)
  %scores.sroa.0.4.vec.extract1076 = extractelement <4 x float> %131, i64 1
  %mul208.1.3 = fmul contract float %scores.sroa.0.4.vec.extract1076, 0x3FB99999A0000000
  %134 = tail call contract noundef float @llvm.minnum.f32(float %mul208.1.3, float 0x4024CB5EC0000000)
  %135 = tail call contract noundef float @llvm.exp.f32(float %134)
  %scores.sroa.0.8.vec.extract1163 = extractelement <4 x float> %131, i64 2
  %mul208.2.3 = fmul contract float %scores.sroa.0.8.vec.extract1163, 0x3FB99999A0000000
  %136 = tail call contract noundef float @llvm.minnum.f32(float %mul208.2.3, float 0x4024CB5EC0000000)
  %137 = tail call contract noundef float @llvm.exp.f32(float %136)
  %scores.sroa.0.12.vec.extract1250 = extractelement <4 x float> %131, i64 3
  %mul208.3.3 = fmul contract float %scores.sroa.0.12.vec.extract1250, 0x3FB99999A0000000
  %138 = tail call contract noundef float @llvm.minnum.f32(float %mul208.3.3, float 0x4024CB5EC0000000)
  %139 = tail call contract noundef float @llvm.exp.f32(float %138)
  %add224.3761 = fadd contract float %sums.sroa.0.6, %133
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %133)
  %probs.sroa.0.0.vec.insert1353 = insertelement <4 x i16> poison, i16 %140, i64 0
  %add224.1.3 = fadd contract float %sums.sroa.22.6, %135
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %135)
  %probs.sroa.0.2.vec.insert1387 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1353, i16 %141, i64 1
  %add224.2.3 = fadd contract float %sums.sroa.42.6, %137
  %142 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %137)
  %probs.sroa.0.4.vec.insert1420 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1387, i16 %142, i64 2
  %add224.3.3 = fadd contract float %sums.sroa.62.6, %139
  %143 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %139)
  %probs.sroa.0.6.vec.insert1436 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1420, i16 %143, i64 3
  br label %if.end248.3

if.end248.3:                                      ; preds = %if.end144.3, %if.end184.3
  %sums.sroa.62.7 = phi float [ %add224.3.3, %if.end184.3 ], [ %sums.sroa.62.6, %if.end144.3 ]
  %sums.sroa.42.7 = phi float [ %add224.2.3, %if.end184.3 ], [ %sums.sroa.42.6, %if.end144.3 ]
  %sums.sroa.22.7 = phi float [ %add224.1.3, %if.end184.3 ], [ %sums.sroa.22.6, %if.end144.3 ]
  %sums.sroa.0.7 = phi float [ %add224.3761, %if.end184.3 ], [ %sums.sroa.0.6, %if.end144.3 ]
  %probs.sroa.0.9 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1436, %if.end184.3 ], [ zeroinitializer, %if.end144.3 ]
  %add256.3 = or disjoint i32 %and254, 256
  %add.ptr258.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add256.3
  store <4 x i16> %probs.sroa.0.9, ptr addrspace(3) %add.ptr258.3, align 8
  br label %if.end259.3

if.end259.3:                                      ; preds = %if.end248.3, %if.end400.2
  %sums.sroa.62.8 = phi float [ %sums.sroa.62.6, %if.end400.2 ], [ %sums.sroa.62.7, %if.end248.3 ]
  %sums.sroa.42.8 = phi float [ %sums.sroa.42.6, %if.end400.2 ], [ %sums.sroa.42.7, %if.end248.3 ]
  %sums.sroa.22.8 = phi float [ %sums.sroa.22.6, %if.end400.2 ], [ %sums.sroa.22.7, %if.end248.3 ]
  %sums.sroa.0.8 = phi float [ %sums.sroa.0.6, %if.end400.2 ], [ %sums.sroa.0.7, %if.end248.3 ]
  %kr.sroa.47.7 = phi <4 x half> [ %kr.sroa.47.5, %if.end400.2 ], [ %kr.sroa.47.6, %if.end248.3 ]
  %kr.sroa.29.7 = phi <4 x half> [ %kr.sroa.29.5, %if.end400.2 ], [ %kr.sroa.29.6, %if.end248.3 ]
  %kr.sroa.20.7 = phi <4 x half> [ %kr.sroa.20.5, %if.end400.2 ], [ %kr.sroa.20.6, %if.end248.3 ]
  %kr.sroa.0.7 = phi <4 x half> [ %kr.sroa.0.5, %if.end400.2 ], [ %kr.sroa.0.6, %if.end248.3 ]
  br i1 %cmp262.not, label %if.then265.3, label %if.end400.3

if.then265.3:                                     ; preds = %if.end259.3
  %or.cond726.3 = icmp ugt i32 %mul11.2, 1023
  %cmp273.not.3 = icmp sgt i32 %mul11.2, %1
  %or.cond727.3 = or i1 %or.cond726.3, %cmp273.not.3
  br i1 %or.cond727.3, label %if.end400.3, label %for.cond359.preheader.3

for.cond359.preheader.3:                          ; preds = %if.then265.3
  %add305.3 = and i32 %and254, 252
  %add.ptr307.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add305.3
  %144 = load <4 x half>, ptr addrspace(3) %add.ptr307.3, align 8
  %145 = shl nsw i32 %cond.i.i689.2, 10
  %mul282.3 = and i32 %145, 64512
  %add283.3 = or disjoint i32 %mul282.3, %mul125
  %146 = zext nneg i32 %add283.3 to i64
  %147 = or disjoint i64 %146, %27
  %148 = or disjoint i64 %147, 512
  %add.ptr291.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %148
  %vr.sroa.128.16.add.ptr291.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr291.1.3, i64 8
  %vr.sroa.128.16.copyload897 = load <4 x half>, ptr addrspace(4) %vr.sroa.128.16.add.ptr291.1.3.sroa_idx, align 8
  %vr.sroa.83.16.copyload889 = load <4 x half>, ptr addrspace(4) %add.ptr291.1.3, align 16
  %149 = or disjoint i64 %146, %27
  %add.ptr291.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %149
  %vr.sroa.47.0.add.ptr291.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr291.3, i64 8
  %vr.sroa.47.0.copyload811 = load <4 x half>, ptr addrspace(4) %vr.sroa.47.0.add.ptr291.3.sroa_idx, align 8
  %vr.sroa.0.0.copyload803 = load <4 x half>, ptr addrspace(4) %add.ptr291.3, align 16
  %150 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload803, <4 x half> %144, <4 x float> zeroinitializer), !call_argsrelate !164
  %151 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.47.0.copyload811, <4 x half> %144, <4 x float> zeroinitializer), !call_argsrelate !164
  %152 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.83.16.copyload889, <4 x half> %144, <4 x float> zeroinitializer), !call_argsrelate !164
  %153 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.128.16.copyload897, <4 x half> %144, <4 x float> zeroinitializer), !call_argsrelate !164
  br label %if.end400.3

if.end400.3:                                      ; preds = %for.cond359.preheader.3, %if.then265.3, %if.end259.3
  %out_2.sroa.80.4 = phi <4 x float> [ zeroinitializer, %if.end259.3 ], [ zeroinitializer, %if.then265.3 ], [ %153, %for.cond359.preheader.3 ]
  %out_2.sroa.54.4 = phi <4 x float> [ zeroinitializer, %if.end259.3 ], [ zeroinitializer, %if.then265.3 ], [ %152, %for.cond359.preheader.3 ]
  %out_2.sroa.28.4 = phi <4 x float> [ zeroinitializer, %if.end259.3 ], [ zeroinitializer, %if.then265.3 ], [ %151, %for.cond359.preheader.3 ]
  %out_2.sroa.0.4 = phi <4 x float> [ zeroinitializer, %if.end259.3 ], [ zeroinitializer, %if.then265.3 ], [ %150, %for.cond359.preheader.3 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %cmp108, label %if.end259.4, label %if.then110.4

if.then110.4:                                     ; preds = %if.end400.3
  %or.cond722.4 = icmp ugt i32 %mul11.4, 1023
  %cmp118.not.4 = icmp sgt i32 %mul11.4, %1
  %or.cond723.4 = or i1 %or.cond722.4, %cmp118.not.4
  br i1 %or.cond723.4, label %if.end144.4, label %for.cond120.preheader.4

for.cond120.preheader.4:                          ; preds = %if.then110.4
  %154 = shl nsw i32 %cond.i.i689.4, 10
  %mul127.4 = and i32 %154, 64512
  %add128.4 = or disjoint i32 %mul127.4, %mul125
  %155 = zext nneg i32 %add128.4 to i64
  %156 = or disjoint i64 %155, %26
  %add.ptr136.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %156
  %kr.sroa.0.0.copyload1458 = load <4 x half>, ptr addrspace(4) %add.ptr136.4, align 16
  %kr.sroa.20.0.add.ptr136.4.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr136.4, i64 8
  %kr.sroa.20.0.copyload1466 = load <4 x half>, ptr addrspace(4) %kr.sroa.20.0.add.ptr136.4.sroa_idx, align 8
  %157 = or disjoint i64 %155, %26
  %158 = or disjoint i64 %157, 512
  %add.ptr136.1.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %158
  %kr.sroa.29.16.copyload1490 = load <4 x half>, ptr addrspace(4) %add.ptr136.1.4, align 16
  %kr.sroa.47.16.add.ptr136.1.4.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr136.1.4, i64 8
  %kr.sroa.47.16.copyload1498 = load <4 x half>, ptr addrspace(4) %kr.sroa.47.16.add.ptr136.1.4.sroa_idx, align 8
  br label %if.end144.4

if.end144.4:                                      ; preds = %for.cond120.preheader.4, %if.then110.4
  %kr.sroa.47.8 = phi <4 x half> [ %kr.sroa.47.7, %if.then110.4 ], [ %kr.sroa.47.16.copyload1498, %for.cond120.preheader.4 ]
  %kr.sroa.29.8 = phi <4 x half> [ %kr.sroa.29.7, %if.then110.4 ], [ %kr.sroa.29.16.copyload1490, %for.cond120.preheader.4 ]
  %kr.sroa.20.8 = phi <4 x half> [ %kr.sroa.20.7, %if.then110.4 ], [ %kr.sroa.20.0.copyload1466, %for.cond120.preheader.4 ]
  %kr.sroa.0.8 = phi <4 x half> [ %kr.sroa.0.7, %if.then110.4 ], [ %kr.sroa.0.0.copyload1458, %for.cond120.preheader.4 ]
  br i1 %or.cond723.4, label %if.end248.4, label %if.then153.4

if.then153.4:                                     ; preds = %if.end144.4
  %cmp156.4 = icmp sgt i32 %mul11.4, %invariant.op
  br i1 %cmp156.4, label %for.cond158.preheader.4, label %if.end184.4

for.cond158.preheader.4:                          ; preds = %if.then153.4
  %add166.4 = or disjoint i32 %mul11.4, %mul165
  %cmp169.not.4 = icmp sgt i32 %add166.4, %1
  %spec.select.4 = select i1 %cmp169.not.4, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert987 = insertelement <4 x float> poison, float %spec.select.4, i64 0
  %cmp169.not.1.4.not = icmp slt i32 %add166.4, %1
  %spec.select.1.4 = select i1 %cmp169.not.1.4.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1082 = insertelement <4 x float> %scores.sroa.0.0.vec.insert987, float %spec.select.1.4, i64 1
  %add167.2.4 = or disjoint i32 %add166.4, 2
  %cmp169.not.2.4 = icmp sgt i32 %add167.2.4, %1
  %spec.select.2.4 = select i1 %cmp169.not.2.4, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1169 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1082, float %spec.select.2.4, i64 2
  %add167.3.4 = or disjoint i32 %add166.4, 3
  %cmp169.not.3.4 = icmp sgt i32 %add167.3.4, %1
  %spec.select.3.4 = select i1 %cmp169.not.3.4, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1256 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1169, float %spec.select.3.4, i64 3
  br label %if.end184.4

if.end184.4:                                      ; preds = %if.then153.4, %for.cond158.preheader.4
  %scores.sroa.0.12 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1256, %for.cond158.preheader.4 ], [ zeroinitializer, %if.then153.4 ]
  %159 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.8, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.12)
  %160 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.20.8, <4 x half> %qr.sroa.12.0, <4 x float> %159)
  %161 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.29.8, <4 x half> %qr.sroa.21.0, <4 x float> %160)
  %162 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.8, <4 x half> %qr.sroa.31.0, <4 x float> %161)
  %scores.sroa.0.0.vec.extract989 = extractelement <4 x float> %162, i64 0
  %mul208.4 = fmul contract float %scores.sroa.0.0.vec.extract989, 0x3FB99999A0000000
  %163 = tail call contract noundef float @llvm.minnum.f32(float %mul208.4, float 0x4024CB5EC0000000)
  %164 = tail call contract noundef float @llvm.exp.f32(float %163)
  %scores.sroa.0.4.vec.extract1084 = extractelement <4 x float> %162, i64 1
  %mul208.1.4 = fmul contract float %scores.sroa.0.4.vec.extract1084, 0x3FB99999A0000000
  %165 = tail call contract noundef float @llvm.minnum.f32(float %mul208.1.4, float 0x4024CB5EC0000000)
  %166 = tail call contract noundef float @llvm.exp.f32(float %165)
  %scores.sroa.0.8.vec.extract1171 = extractelement <4 x float> %162, i64 2
  %mul208.2.4 = fmul contract float %scores.sroa.0.8.vec.extract1171, 0x3FB99999A0000000
  %167 = tail call contract noundef float @llvm.minnum.f32(float %mul208.2.4, float 0x4024CB5EC0000000)
  %168 = tail call contract noundef float @llvm.exp.f32(float %167)
  %scores.sroa.0.12.vec.extract1258 = extractelement <4 x float> %162, i64 3
  %mul208.3.4 = fmul contract float %scores.sroa.0.12.vec.extract1258, 0x3FB99999A0000000
  %169 = tail call contract noundef float @llvm.minnum.f32(float %mul208.3.4, float 0x4024CB5EC0000000)
  %170 = tail call contract noundef float @llvm.exp.f32(float %169)
  %add224.4 = fadd contract float %sums.sroa.0.8, %164
  %171 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %164)
  %probs.sroa.0.0.vec.insert1355 = insertelement <4 x i16> poison, i16 %171, i64 0
  %add224.1.4 = fadd contract float %sums.sroa.22.8, %166
  %172 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %166)
  %probs.sroa.0.2.vec.insert1389 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1355, i16 %172, i64 1
  %add224.2.4 = fadd contract float %sums.sroa.42.8, %168
  %173 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %168)
  %probs.sroa.0.4.vec.insert1422 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1389, i16 %173, i64 2
  %add224.3.4 = fadd contract float %sums.sroa.62.8, %170
  %174 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %170)
  %probs.sroa.0.6.vec.insert1438 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1422, i16 %174, i64 3
  br label %if.end248.4

if.end248.4:                                      ; preds = %if.end144.4, %if.end184.4
  %sums.sroa.62.9 = phi float [ %add224.3.4, %if.end184.4 ], [ %sums.sroa.62.8, %if.end144.4 ]
  %sums.sroa.42.9 = phi float [ %add224.2.4, %if.end184.4 ], [ %sums.sroa.42.8, %if.end144.4 ]
  %sums.sroa.22.9 = phi float [ %add224.1.4, %if.end184.4 ], [ %sums.sroa.22.8, %if.end144.4 ]
  %sums.sroa.0.9 = phi float [ %add224.4, %if.end184.4 ], [ %sums.sroa.0.8, %if.end144.4 ]
  %probs.sroa.0.12 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1438, %if.end184.4 ], [ zeroinitializer, %if.end144.4 ]
  %add.ptr258.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and254
  store <4 x i16> %probs.sroa.0.12, ptr addrspace(3) %add.ptr258.4, align 8
  br label %if.end259.4

if.end259.4:                                      ; preds = %if.end248.4, %if.end400.3
  %sums.sroa.62.10 = phi float [ %sums.sroa.62.8, %if.end400.3 ], [ %sums.sroa.62.9, %if.end248.4 ]
  %sums.sroa.42.10 = phi float [ %sums.sroa.42.8, %if.end400.3 ], [ %sums.sroa.42.9, %if.end248.4 ]
  %sums.sroa.22.10 = phi float [ %sums.sroa.22.8, %if.end400.3 ], [ %sums.sroa.22.9, %if.end248.4 ]
  %sums.sroa.0.10 = phi float [ %sums.sroa.0.8, %if.end400.3 ], [ %sums.sroa.0.9, %if.end248.4 ]
  %kr.sroa.47.9 = phi <4 x half> [ %kr.sroa.47.7, %if.end400.3 ], [ %kr.sroa.47.8, %if.end248.4 ]
  %kr.sroa.29.9 = phi <4 x half> [ %kr.sroa.29.7, %if.end400.3 ], [ %kr.sroa.29.8, %if.end248.4 ]
  %kr.sroa.20.9 = phi <4 x half> [ %kr.sroa.20.7, %if.end400.3 ], [ %kr.sroa.20.8, %if.end248.4 ]
  %kr.sroa.0.9 = phi <4 x half> [ %kr.sroa.0.7, %if.end400.3 ], [ %kr.sroa.0.8, %if.end248.4 ]
  br i1 %cmp262.not, label %if.then265.4, label %if.end400.4

if.then265.4:                                     ; preds = %if.end259.4
  %or.cond726.4 = icmp ugt i32 %mul11.3, 1023
  %cmp273.not.4 = icmp sgt i32 %mul11.3, %1
  %or.cond727.4 = or i1 %or.cond726.4, %cmp273.not.4
  br i1 %or.cond727.4, label %if.end400.4, label %for.cond378.preheader.4

for.cond378.preheader.4:                          ; preds = %if.then265.4
  %add.ptr307.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and254
  %175 = load <4 x half>, ptr addrspace(3) %add.ptr307.4, align 8
  %176 = shl nsw i32 %cond.i.i689.3, 10
  %mul282.4 = and i32 %176, 64512
  %add283.4 = or disjoint i32 %mul282.4, %mul125
  %177 = zext nneg i32 %add283.4 to i64
  %178 = or disjoint i64 %177, %27
  %179 = or disjoint i64 %178, 512
  %add.ptr291.1.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %179
  %vr.sroa.128.16.add.ptr291.1.4.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr291.1.4, i64 8
  %vr.sroa.128.16.copyload898 = load <4 x half>, ptr addrspace(4) %vr.sroa.128.16.add.ptr291.1.4.sroa_idx, align 8
  %vr.sroa.83.16.copyload890 = load <4 x half>, ptr addrspace(4) %add.ptr291.1.4, align 16
  %180 = or disjoint i64 %177, %27
  %add.ptr291.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %180
  %vr.sroa.47.0.add.ptr291.4.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr291.4, i64 8
  %vr.sroa.47.0.copyload812 = load <4 x half>, ptr addrspace(4) %vr.sroa.47.0.add.ptr291.4.sroa_idx, align 8
  %vr.sroa.0.0.copyload804 = load <4 x half>, ptr addrspace(4) %add.ptr291.4, align 16
  %181 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload804, <4 x half> %175, <4 x float> zeroinitializer), !call_argsrelate !164
  %182 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.47.0.copyload812, <4 x half> %175, <4 x float> zeroinitializer), !call_argsrelate !164
  %183 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.83.16.copyload890, <4 x half> %175, <4 x float> zeroinitializer), !call_argsrelate !164
  %184 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.128.16.copyload898, <4 x half> %175, <4 x float> zeroinitializer), !call_argsrelate !164
  br label %if.end400.4

if.end400.4:                                      ; preds = %for.cond378.preheader.4, %if.then265.4, %if.end259.4
  %out_3.sroa.80.5 = phi <4 x float> [ zeroinitializer, %if.end259.4 ], [ zeroinitializer, %if.then265.4 ], [ %184, %for.cond378.preheader.4 ]
  %out_3.sroa.54.5 = phi <4 x float> [ zeroinitializer, %if.end259.4 ], [ zeroinitializer, %if.then265.4 ], [ %183, %for.cond378.preheader.4 ]
  %out_3.sroa.28.5 = phi <4 x float> [ zeroinitializer, %if.end259.4 ], [ zeroinitializer, %if.then265.4 ], [ %182, %for.cond378.preheader.4 ]
  %out_3.sroa.0.5 = phi <4 x float> [ zeroinitializer, %if.end259.4 ], [ zeroinitializer, %if.then265.4 ], [ %181, %for.cond378.preheader.4 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %cmp108, label %if.end259.5, label %if.then110.5

if.then110.5:                                     ; preds = %if.end400.4
  %or.cond722.5 = icmp ugt i32 %mul11.5, 1023
  %cmp118.not.5 = icmp sgt i32 %mul11.5, %1
  %or.cond723.5 = or i1 %or.cond722.5, %cmp118.not.5
  br i1 %or.cond723.5, label %if.end144.5, label %for.cond120.preheader.5

for.cond120.preheader.5:                          ; preds = %if.then110.5
  %185 = shl nsw i32 %cond.i.i689.5, 10
  %mul127.5 = and i32 %185, 64512
  %add128.5 = or disjoint i32 %mul127.5, %mul125
  %186 = zext nneg i32 %add128.5 to i64
  %187 = or disjoint i64 %186, %26
  %add.ptr136.5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %187
  %kr.sroa.0.0.copyload1459 = load <4 x half>, ptr addrspace(4) %add.ptr136.5, align 16
  %kr.sroa.20.0.add.ptr136.5.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr136.5, i64 8
  %kr.sroa.20.0.copyload1467 = load <4 x half>, ptr addrspace(4) %kr.sroa.20.0.add.ptr136.5.sroa_idx, align 8
  %188 = or disjoint i64 %186, %26
  %189 = or disjoint i64 %188, 512
  %add.ptr136.1.5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %189
  %kr.sroa.29.16.copyload1491 = load <4 x half>, ptr addrspace(4) %add.ptr136.1.5, align 16
  %kr.sroa.47.16.add.ptr136.1.5.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr136.1.5, i64 8
  %kr.sroa.47.16.copyload1499 = load <4 x half>, ptr addrspace(4) %kr.sroa.47.16.add.ptr136.1.5.sroa_idx, align 8
  br label %if.end144.5

if.end144.5:                                      ; preds = %for.cond120.preheader.5, %if.then110.5
  %kr.sroa.47.10 = phi <4 x half> [ %kr.sroa.47.9, %if.then110.5 ], [ %kr.sroa.47.16.copyload1499, %for.cond120.preheader.5 ]
  %kr.sroa.29.10 = phi <4 x half> [ %kr.sroa.29.9, %if.then110.5 ], [ %kr.sroa.29.16.copyload1491, %for.cond120.preheader.5 ]
  %kr.sroa.20.10 = phi <4 x half> [ %kr.sroa.20.9, %if.then110.5 ], [ %kr.sroa.20.0.copyload1467, %for.cond120.preheader.5 ]
  %kr.sroa.0.10 = phi <4 x half> [ %kr.sroa.0.9, %if.then110.5 ], [ %kr.sroa.0.0.copyload1459, %for.cond120.preheader.5 ]
  br i1 %or.cond723.5, label %if.end248.5, label %if.then153.5

if.then153.5:                                     ; preds = %if.end144.5
  %cmp156.5 = icmp sgt i32 %mul11.5, %invariant.op
  br i1 %cmp156.5, label %for.cond158.preheader.5, label %if.end184.5

for.cond158.preheader.5:                          ; preds = %if.then153.5
  %add166.5 = or disjoint i32 %mul11.5, %mul165
  %cmp169.not.5 = icmp sgt i32 %add166.5, %1
  %spec.select.5 = select i1 %cmp169.not.5, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert997 = insertelement <4 x float> poison, float %spec.select.5, i64 0
  %cmp169.not.1.5.not = icmp slt i32 %add166.5, %1
  %spec.select.1.5 = select i1 %cmp169.not.1.5.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1090 = insertelement <4 x float> %scores.sroa.0.0.vec.insert997, float %spec.select.1.5, i64 1
  %add167.2.5 = or disjoint i32 %add166.5, 2
  %cmp169.not.2.5 = icmp sgt i32 %add167.2.5, %1
  %spec.select.2.5 = select i1 %cmp169.not.2.5, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1177 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1090, float %spec.select.2.5, i64 2
  %add167.3.5 = or disjoint i32 %add166.5, 3
  %cmp169.not.3.5 = icmp sgt i32 %add167.3.5, %1
  %spec.select.3.5 = select i1 %cmp169.not.3.5, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1264 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1177, float %spec.select.3.5, i64 3
  br label %if.end184.5

if.end184.5:                                      ; preds = %if.then153.5, %for.cond158.preheader.5
  %scores.sroa.0.15 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1264, %for.cond158.preheader.5 ], [ zeroinitializer, %if.then153.5 ]
  %190 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.10, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.15)
  %191 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.20.10, <4 x half> %qr.sroa.12.0, <4 x float> %190)
  %192 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.29.10, <4 x half> %qr.sroa.21.0, <4 x float> %191)
  %193 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.10, <4 x half> %qr.sroa.31.0, <4 x float> %192)
  %scores.sroa.0.0.vec.extract999 = extractelement <4 x float> %193, i64 0
  %mul208.5 = fmul contract float %scores.sroa.0.0.vec.extract999, 0x3FB99999A0000000
  %194 = tail call contract noundef float @llvm.minnum.f32(float %mul208.5, float 0x4024CB5EC0000000)
  %195 = tail call contract noundef float @llvm.exp.f32(float %194)
  %scores.sroa.0.4.vec.extract1092 = extractelement <4 x float> %193, i64 1
  %mul208.1.5 = fmul contract float %scores.sroa.0.4.vec.extract1092, 0x3FB99999A0000000
  %196 = tail call contract noundef float @llvm.minnum.f32(float %mul208.1.5, float 0x4024CB5EC0000000)
  %197 = tail call contract noundef float @llvm.exp.f32(float %196)
  %scores.sroa.0.8.vec.extract1179 = extractelement <4 x float> %193, i64 2
  %mul208.2.5 = fmul contract float %scores.sroa.0.8.vec.extract1179, 0x3FB99999A0000000
  %198 = tail call contract noundef float @llvm.minnum.f32(float %mul208.2.5, float 0x4024CB5EC0000000)
  %199 = tail call contract noundef float @llvm.exp.f32(float %198)
  %scores.sroa.0.12.vec.extract1266 = extractelement <4 x float> %193, i64 3
  %mul208.3.5 = fmul contract float %scores.sroa.0.12.vec.extract1266, 0x3FB99999A0000000
  %200 = tail call contract noundef float @llvm.minnum.f32(float %mul208.3.5, float 0x4024CB5EC0000000)
  %201 = tail call contract noundef float @llvm.exp.f32(float %200)
  %add224.5 = fadd contract float %sums.sroa.0.10, %195
  %202 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %195)
  %probs.sroa.0.0.vec.insert1357 = insertelement <4 x i16> poison, i16 %202, i64 0
  %add224.1.5 = fadd contract float %sums.sroa.22.10, %197
  %203 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %197)
  %probs.sroa.0.2.vec.insert1391 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1357, i16 %203, i64 1
  %add224.2.5 = fadd contract float %sums.sroa.42.10, %199
  %204 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %199)
  %probs.sroa.0.4.vec.insert1424 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1391, i16 %204, i64 2
  %add224.3.5 = fadd contract float %sums.sroa.62.10, %201
  %205 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %201)
  %probs.sroa.0.6.vec.insert1440 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1424, i16 %205, i64 3
  br label %if.end248.5

if.end248.5:                                      ; preds = %if.end144.5, %if.end184.5
  %sums.sroa.62.11 = phi float [ %add224.3.5, %if.end184.5 ], [ %sums.sroa.62.10, %if.end144.5 ]
  %sums.sroa.42.11 = phi float [ %add224.2.5, %if.end184.5 ], [ %sums.sroa.42.10, %if.end144.5 ]
  %sums.sroa.22.11 = phi float [ %add224.1.5, %if.end184.5 ], [ %sums.sroa.22.10, %if.end144.5 ]
  %sums.sroa.0.11 = phi float [ %add224.5, %if.end184.5 ], [ %sums.sroa.0.10, %if.end144.5 ]
  %probs.sroa.0.15 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1440, %if.end184.5 ], [ zeroinitializer, %if.end144.5 ]
  %add256.5 = or disjoint i32 %and254, 256
  %add.ptr258.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add256.5
  store <4 x i16> %probs.sroa.0.15, ptr addrspace(3) %add.ptr258.5, align 8
  br label %if.end259.5

if.end259.5:                                      ; preds = %if.end248.5, %if.end400.4
  %sums.sroa.62.12 = phi float [ %sums.sroa.62.10, %if.end400.4 ], [ %sums.sroa.62.11, %if.end248.5 ]
  %sums.sroa.42.12 = phi float [ %sums.sroa.42.10, %if.end400.4 ], [ %sums.sroa.42.11, %if.end248.5 ]
  %sums.sroa.22.12 = phi float [ %sums.sroa.22.10, %if.end400.4 ], [ %sums.sroa.22.11, %if.end248.5 ]
  %sums.sroa.0.12 = phi float [ %sums.sroa.0.10, %if.end400.4 ], [ %sums.sroa.0.11, %if.end248.5 ]
  %kr.sroa.47.11 = phi <4 x half> [ %kr.sroa.47.9, %if.end400.4 ], [ %kr.sroa.47.10, %if.end248.5 ]
  %kr.sroa.29.11 = phi <4 x half> [ %kr.sroa.29.9, %if.end400.4 ], [ %kr.sroa.29.10, %if.end248.5 ]
  %kr.sroa.20.11 = phi <4 x half> [ %kr.sroa.20.9, %if.end400.4 ], [ %kr.sroa.20.10, %if.end248.5 ]
  %kr.sroa.0.11 = phi <4 x half> [ %kr.sroa.0.9, %if.end400.4 ], [ %kr.sroa.0.10, %if.end248.5 ]
  br i1 %cmp262.not, label %if.then265.5, label %if.end400.5

if.then265.5:                                     ; preds = %if.end259.5
  %or.cond726.5 = icmp ugt i32 %mul11.4, 1023
  %cmp273.not.5 = icmp sgt i32 %mul11.4, %1
  %or.cond727.5 = or i1 %or.cond726.5, %cmp273.not.5
  br i1 %or.cond727.5, label %if.end400.5, label %for.cond313.preheader.5

for.cond313.preheader.5:                          ; preds = %if.then265.5
  %add305.5 = and i32 %and254, 252
  %add.ptr307.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add305.5
  %206 = load <4 x half>, ptr addrspace(3) %add.ptr307.5, align 8
  %207 = shl nsw i32 %cond.i.i689.4, 10
  %mul282.5 = and i32 %207, 64512
  %add283.5 = or disjoint i32 %mul282.5, %mul125
  %208 = zext nneg i32 %add283.5 to i64
  %209 = or disjoint i64 %208, %27
  %210 = or disjoint i64 %209, 512
  %add.ptr291.1.5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %210
  %vr.sroa.128.16.add.ptr291.1.5.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr291.1.5, i64 8
  %vr.sroa.128.16.copyload899 = load <4 x half>, ptr addrspace(4) %vr.sroa.128.16.add.ptr291.1.5.sroa_idx, align 8
  %vr.sroa.83.16.copyload891 = load <4 x half>, ptr addrspace(4) %add.ptr291.1.5, align 16
  %211 = or disjoint i64 %208, %27
  %add.ptr291.5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %211
  %vr.sroa.47.0.add.ptr291.5.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr291.5, i64 8
  %vr.sroa.47.0.copyload813 = load <4 x half>, ptr addrspace(4) %vr.sroa.47.0.add.ptr291.5.sroa_idx, align 8
  %vr.sroa.0.0.copyload805 = load <4 x half>, ptr addrspace(4) %add.ptr291.5, align 16
  %212 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload805, <4 x half> %206, <4 x float> %out.sroa.0.2), !call_argsrelate !164
  %213 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.47.0.copyload813, <4 x half> %206, <4 x float> %out.sroa.40.2), !call_argsrelate !164
  %214 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.83.16.copyload891, <4 x half> %206, <4 x float> %out.sroa.78.2), !call_argsrelate !164
  %215 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.128.16.copyload899, <4 x half> %206, <4 x float> %out.sroa.116.2), !call_argsrelate !164
  br label %if.end400.5

if.end400.5:                                      ; preds = %for.cond313.preheader.5, %if.then265.5, %if.end259.5
  %out.sroa.116.6 = phi <4 x float> [ %out.sroa.116.2, %if.end259.5 ], [ %out.sroa.116.2, %if.then265.5 ], [ %215, %for.cond313.preheader.5 ]
  %out.sroa.78.6 = phi <4 x float> [ %out.sroa.78.2, %if.end259.5 ], [ %out.sroa.78.2, %if.then265.5 ], [ %214, %for.cond313.preheader.5 ]
  %out.sroa.40.6 = phi <4 x float> [ %out.sroa.40.2, %if.end259.5 ], [ %out.sroa.40.2, %if.then265.5 ], [ %213, %for.cond313.preheader.5 ]
  %out.sroa.0.6 = phi <4 x float> [ %out.sroa.0.2, %if.end259.5 ], [ %out.sroa.0.2, %if.then265.5 ], [ %212, %for.cond313.preheader.5 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %cmp108, label %if.end259.6, label %if.then110.6

if.then110.6:                                     ; preds = %if.end400.5
  %or.cond722.6 = icmp ugt i32 %mul11.6, 1023
  %cmp118.not.6 = icmp sgt i32 %mul11.6, %1
  %or.cond723.6 = or i1 %or.cond722.6, %cmp118.not.6
  br i1 %or.cond723.6, label %if.end144.6, label %for.cond120.preheader.6

for.cond120.preheader.6:                          ; preds = %if.then110.6
  %216 = shl nsw i32 %cond.i.i689.6, 10
  %mul127.6 = and i32 %216, 64512
  %add128.6 = or disjoint i32 %mul127.6, %mul125
  %217 = zext nneg i32 %add128.6 to i64
  %218 = or disjoint i64 %217, %26
  %add.ptr136.6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %218
  %kr.sroa.0.0.copyload1460 = load <4 x half>, ptr addrspace(4) %add.ptr136.6, align 16
  %kr.sroa.20.0.add.ptr136.6.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr136.6, i64 8
  %kr.sroa.20.0.copyload1468 = load <4 x half>, ptr addrspace(4) %kr.sroa.20.0.add.ptr136.6.sroa_idx, align 8
  %219 = or disjoint i64 %217, %26
  %220 = or disjoint i64 %219, 512
  %add.ptr136.1.6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %220
  %kr.sroa.29.16.copyload1492 = load <4 x half>, ptr addrspace(4) %add.ptr136.1.6, align 16
  %kr.sroa.47.16.add.ptr136.1.6.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr136.1.6, i64 8
  %kr.sroa.47.16.copyload1500 = load <4 x half>, ptr addrspace(4) %kr.sroa.47.16.add.ptr136.1.6.sroa_idx, align 8
  br label %if.end144.6

if.end144.6:                                      ; preds = %for.cond120.preheader.6, %if.then110.6
  %kr.sroa.47.12 = phi <4 x half> [ %kr.sroa.47.11, %if.then110.6 ], [ %kr.sroa.47.16.copyload1500, %for.cond120.preheader.6 ]
  %kr.sroa.29.12 = phi <4 x half> [ %kr.sroa.29.11, %if.then110.6 ], [ %kr.sroa.29.16.copyload1492, %for.cond120.preheader.6 ]
  %kr.sroa.20.12 = phi <4 x half> [ %kr.sroa.20.11, %if.then110.6 ], [ %kr.sroa.20.0.copyload1468, %for.cond120.preheader.6 ]
  %kr.sroa.0.12 = phi <4 x half> [ %kr.sroa.0.11, %if.then110.6 ], [ %kr.sroa.0.0.copyload1460, %for.cond120.preheader.6 ]
  br i1 %or.cond723.6, label %if.end248.6, label %if.then153.6

if.then153.6:                                     ; preds = %if.end144.6
  %cmp156.6 = icmp sgt i32 %mul11.6, %invariant.op
  br i1 %cmp156.6, label %for.cond158.preheader.6, label %if.end184.6

for.cond158.preheader.6:                          ; preds = %if.then153.6
  %add166.6 = or disjoint i32 %mul11.6, %mul165
  %cmp169.not.6 = icmp sgt i32 %add166.6, %1
  %spec.select.6 = select i1 %cmp169.not.6, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1007 = insertelement <4 x float> poison, float %spec.select.6, i64 0
  %cmp169.not.1.6.not = icmp slt i32 %add166.6, %1
  %spec.select.1.6 = select i1 %cmp169.not.1.6.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1098 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1007, float %spec.select.1.6, i64 1
  %add167.2.6 = or disjoint i32 %add166.6, 2
  %cmp169.not.2.6 = icmp sgt i32 %add167.2.6, %1
  %spec.select.2.6 = select i1 %cmp169.not.2.6, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1185 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1098, float %spec.select.2.6, i64 2
  %add167.3.6 = or disjoint i32 %add166.6, 3
  %cmp169.not.3.6 = icmp sgt i32 %add167.3.6, %1
  %spec.select.3.6 = select i1 %cmp169.not.3.6, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1272 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1185, float %spec.select.3.6, i64 3
  br label %if.end184.6

if.end184.6:                                      ; preds = %if.then153.6, %for.cond158.preheader.6
  %scores.sroa.0.18 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1272, %for.cond158.preheader.6 ], [ zeroinitializer, %if.then153.6 ]
  %221 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.12, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.18)
  %222 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.20.12, <4 x half> %qr.sroa.12.0, <4 x float> %221)
  %223 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.29.12, <4 x half> %qr.sroa.21.0, <4 x float> %222)
  %224 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.12, <4 x half> %qr.sroa.31.0, <4 x float> %223)
  %scores.sroa.0.0.vec.extract1009 = extractelement <4 x float> %224, i64 0
  %mul208.6 = fmul contract float %scores.sroa.0.0.vec.extract1009, 0x3FB99999A0000000
  %225 = tail call contract noundef float @llvm.minnum.f32(float %mul208.6, float 0x4024CB5EC0000000)
  %226 = tail call contract noundef float @llvm.exp.f32(float %225)
  %scores.sroa.0.4.vec.extract1100 = extractelement <4 x float> %224, i64 1
  %mul208.1.6 = fmul contract float %scores.sroa.0.4.vec.extract1100, 0x3FB99999A0000000
  %227 = tail call contract noundef float @llvm.minnum.f32(float %mul208.1.6, float 0x4024CB5EC0000000)
  %228 = tail call contract noundef float @llvm.exp.f32(float %227)
  %scores.sroa.0.8.vec.extract1187 = extractelement <4 x float> %224, i64 2
  %mul208.2.6 = fmul contract float %scores.sroa.0.8.vec.extract1187, 0x3FB99999A0000000
  %229 = tail call contract noundef float @llvm.minnum.f32(float %mul208.2.6, float 0x4024CB5EC0000000)
  %230 = tail call contract noundef float @llvm.exp.f32(float %229)
  %scores.sroa.0.12.vec.extract1274 = extractelement <4 x float> %224, i64 3
  %mul208.3.6 = fmul contract float %scores.sroa.0.12.vec.extract1274, 0x3FB99999A0000000
  %231 = tail call contract noundef float @llvm.minnum.f32(float %mul208.3.6, float 0x4024CB5EC0000000)
  %232 = tail call contract noundef float @llvm.exp.f32(float %231)
  %add224.6 = fadd contract float %sums.sroa.0.12, %226
  %233 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %226)
  %probs.sroa.0.0.vec.insert1359 = insertelement <4 x i16> poison, i16 %233, i64 0
  %add224.1.6 = fadd contract float %sums.sroa.22.12, %228
  %234 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %228)
  %probs.sroa.0.2.vec.insert1393 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1359, i16 %234, i64 1
  %add224.2.6 = fadd contract float %sums.sroa.42.12, %230
  %235 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %230)
  %probs.sroa.0.4.vec.insert1426 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1393, i16 %235, i64 2
  %add224.3.6 = fadd contract float %sums.sroa.62.12, %232
  %236 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %232)
  %probs.sroa.0.6.vec.insert1442 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1426, i16 %236, i64 3
  br label %if.end248.6

if.end248.6:                                      ; preds = %if.end144.6, %if.end184.6
  %sums.sroa.62.13 = phi float [ %add224.3.6, %if.end184.6 ], [ %sums.sroa.62.12, %if.end144.6 ]
  %sums.sroa.42.13 = phi float [ %add224.2.6, %if.end184.6 ], [ %sums.sroa.42.12, %if.end144.6 ]
  %sums.sroa.22.13 = phi float [ %add224.1.6, %if.end184.6 ], [ %sums.sroa.22.12, %if.end144.6 ]
  %sums.sroa.0.13 = phi float [ %add224.6, %if.end184.6 ], [ %sums.sroa.0.12, %if.end144.6 ]
  %probs.sroa.0.18 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1442, %if.end184.6 ], [ zeroinitializer, %if.end144.6 ]
  %add.ptr258.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and254
  store <4 x i16> %probs.sroa.0.18, ptr addrspace(3) %add.ptr258.6, align 8
  br label %if.end259.6

if.end259.6:                                      ; preds = %if.end248.6, %if.end400.5
  %sums.sroa.62.14 = phi float [ %sums.sroa.62.12, %if.end400.5 ], [ %sums.sroa.62.13, %if.end248.6 ]
  %sums.sroa.42.14 = phi float [ %sums.sroa.42.12, %if.end400.5 ], [ %sums.sroa.42.13, %if.end248.6 ]
  %sums.sroa.22.14 = phi float [ %sums.sroa.22.12, %if.end400.5 ], [ %sums.sroa.22.13, %if.end248.6 ]
  %sums.sroa.0.14 = phi float [ %sums.sroa.0.12, %if.end400.5 ], [ %sums.sroa.0.13, %if.end248.6 ]
  %kr.sroa.47.13 = phi <4 x half> [ %kr.sroa.47.11, %if.end400.5 ], [ %kr.sroa.47.12, %if.end248.6 ]
  %kr.sroa.29.13 = phi <4 x half> [ %kr.sroa.29.11, %if.end400.5 ], [ %kr.sroa.29.12, %if.end248.6 ]
  %kr.sroa.20.13 = phi <4 x half> [ %kr.sroa.20.11, %if.end400.5 ], [ %kr.sroa.20.12, %if.end248.6 ]
  %kr.sroa.0.13 = phi <4 x half> [ %kr.sroa.0.11, %if.end400.5 ], [ %kr.sroa.0.12, %if.end248.6 ]
  br i1 %cmp262.not, label %if.then265.6, label %if.end400.6

if.then265.6:                                     ; preds = %if.end259.6
  %or.cond726.6 = icmp ugt i32 %mul11.5, 1023
  %cmp273.not.6 = icmp sgt i32 %mul11.5, %1
  %or.cond727.6 = or i1 %or.cond726.6, %cmp273.not.6
  br i1 %or.cond727.6, label %if.end400.6, label %for.cond336.preheader.6

for.cond336.preheader.6:                          ; preds = %if.then265.6
  %add.ptr307.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and254
  %237 = load <4 x half>, ptr addrspace(3) %add.ptr307.6, align 8
  %238 = shl nsw i32 %cond.i.i689.5, 10
  %mul282.6 = and i32 %238, 64512
  %add283.6 = or disjoint i32 %mul282.6, %mul125
  %239 = zext nneg i32 %add283.6 to i64
  %240 = or disjoint i64 %239, %27
  %241 = or disjoint i64 %240, 512
  %add.ptr291.1.6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %241
  %vr.sroa.128.16.add.ptr291.1.6.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr291.1.6, i64 8
  %vr.sroa.128.16.copyload900 = load <4 x half>, ptr addrspace(4) %vr.sroa.128.16.add.ptr291.1.6.sroa_idx, align 8
  %vr.sroa.83.16.copyload892 = load <4 x half>, ptr addrspace(4) %add.ptr291.1.6, align 16
  %242 = or disjoint i64 %239, %27
  %add.ptr291.6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %242
  %vr.sroa.47.0.add.ptr291.6.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr291.6, i64 8
  %vr.sroa.47.0.copyload814 = load <4 x half>, ptr addrspace(4) %vr.sroa.47.0.add.ptr291.6.sroa_idx, align 8
  %vr.sroa.0.0.copyload806 = load <4 x half>, ptr addrspace(4) %add.ptr291.6, align 16
  %243 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload806, <4 x half> %237, <4 x float> %out_1.sroa.0.3), !call_argsrelate !164
  %244 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.47.0.copyload814, <4 x half> %237, <4 x float> %out_1.sroa.28.3), !call_argsrelate !164
  %245 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.83.16.copyload892, <4 x half> %237, <4 x float> %out_1.sroa.54.3), !call_argsrelate !164
  %246 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.128.16.copyload900, <4 x half> %237, <4 x float> %out_1.sroa.80.3), !call_argsrelate !164
  br label %if.end400.6

if.end400.6:                                      ; preds = %for.cond336.preheader.6, %if.then265.6, %if.end259.6
  %out_1.sroa.80.7 = phi <4 x float> [ %out_1.sroa.80.3, %if.end259.6 ], [ %out_1.sroa.80.3, %if.then265.6 ], [ %246, %for.cond336.preheader.6 ]
  %out_1.sroa.54.7 = phi <4 x float> [ %out_1.sroa.54.3, %if.end259.6 ], [ %out_1.sroa.54.3, %if.then265.6 ], [ %245, %for.cond336.preheader.6 ]
  %out_1.sroa.28.7 = phi <4 x float> [ %out_1.sroa.28.3, %if.end259.6 ], [ %out_1.sroa.28.3, %if.then265.6 ], [ %244, %for.cond336.preheader.6 ]
  %out_1.sroa.0.7 = phi <4 x float> [ %out_1.sroa.0.3, %if.end259.6 ], [ %out_1.sroa.0.3, %if.then265.6 ], [ %243, %for.cond336.preheader.6 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %cmp108, label %if.end259.7, label %if.then110.7

if.then110.7:                                     ; preds = %if.end400.6
  %or.cond722.7 = icmp ugt i32 %mul11.7, 1023
  %cmp118.not.7 = icmp sgt i32 %mul11.7, %1
  %or.cond723.7 = or i1 %or.cond722.7, %cmp118.not.7
  br i1 %or.cond723.7, label %if.end144.7, label %for.cond120.preheader.7

for.cond120.preheader.7:                          ; preds = %if.then110.7
  %247 = shl nsw i32 %cond.i.i689.7, 10
  %mul127.7 = and i32 %247, 64512
  %add128.7 = or disjoint i32 %mul127.7, %mul125
  %248 = zext nneg i32 %add128.7 to i64
  %249 = or disjoint i64 %248, %26
  %add.ptr136.7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %249
  %kr.sroa.0.0.copyload1461 = load <4 x half>, ptr addrspace(4) %add.ptr136.7, align 16
  %kr.sroa.20.0.add.ptr136.7.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr136.7, i64 8
  %kr.sroa.20.0.copyload1469 = load <4 x half>, ptr addrspace(4) %kr.sroa.20.0.add.ptr136.7.sroa_idx, align 8
  %250 = or disjoint i64 %248, %26
  %251 = or disjoint i64 %250, 512
  %add.ptr136.1.7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %251
  %kr.sroa.29.16.copyload1493 = load <4 x half>, ptr addrspace(4) %add.ptr136.1.7, align 16
  %kr.sroa.47.16.add.ptr136.1.7.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr136.1.7, i64 8
  %kr.sroa.47.16.copyload1501 = load <4 x half>, ptr addrspace(4) %kr.sroa.47.16.add.ptr136.1.7.sroa_idx, align 8
  br label %if.end144.7

if.end144.7:                                      ; preds = %for.cond120.preheader.7, %if.then110.7
  %kr.sroa.47.14 = phi <4 x half> [ %kr.sroa.47.13, %if.then110.7 ], [ %kr.sroa.47.16.copyload1501, %for.cond120.preheader.7 ]
  %kr.sroa.29.14 = phi <4 x half> [ %kr.sroa.29.13, %if.then110.7 ], [ %kr.sroa.29.16.copyload1493, %for.cond120.preheader.7 ]
  %kr.sroa.20.14 = phi <4 x half> [ %kr.sroa.20.13, %if.then110.7 ], [ %kr.sroa.20.0.copyload1469, %for.cond120.preheader.7 ]
  %kr.sroa.0.14 = phi <4 x half> [ %kr.sroa.0.13, %if.then110.7 ], [ %kr.sroa.0.0.copyload1461, %for.cond120.preheader.7 ]
  br i1 %or.cond723.7, label %if.end248.7, label %if.then153.7

if.then153.7:                                     ; preds = %if.end144.7
  %cmp156.7 = icmp sgt i32 %mul11.7, %invariant.op
  br i1 %cmp156.7, label %for.cond158.preheader.7, label %if.end184.7

for.cond158.preheader.7:                          ; preds = %if.then153.7
  %add166.7 = or disjoint i32 %mul11.7, %mul165
  %cmp169.not.7 = icmp sgt i32 %add166.7, %1
  %spec.select.7 = select i1 %cmp169.not.7, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1017 = insertelement <4 x float> poison, float %spec.select.7, i64 0
  %cmp169.not.1.7.not = icmp slt i32 %add166.7, %1
  %spec.select.1.7 = select i1 %cmp169.not.1.7.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1106 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1017, float %spec.select.1.7, i64 1
  %add167.2.7 = or disjoint i32 %add166.7, 2
  %cmp169.not.2.7 = icmp sgt i32 %add167.2.7, %1
  %spec.select.2.7 = select i1 %cmp169.not.2.7, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1193 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1106, float %spec.select.2.7, i64 2
  %add167.3.7 = or disjoint i32 %add166.7, 3
  %cmp169.not.3.7 = icmp sgt i32 %add167.3.7, %1
  %spec.select.3.7 = select i1 %cmp169.not.3.7, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1280 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1193, float %spec.select.3.7, i64 3
  br label %if.end184.7

if.end184.7:                                      ; preds = %if.then153.7, %for.cond158.preheader.7
  %scores.sroa.0.21 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1280, %for.cond158.preheader.7 ], [ zeroinitializer, %if.then153.7 ]
  %252 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.14, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.21)
  %253 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.20.14, <4 x half> %qr.sroa.12.0, <4 x float> %252)
  %254 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.29.14, <4 x half> %qr.sroa.21.0, <4 x float> %253)
  %255 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.14, <4 x half> %qr.sroa.31.0, <4 x float> %254)
  %scores.sroa.0.0.vec.extract1019 = extractelement <4 x float> %255, i64 0
  %mul208.7 = fmul contract float %scores.sroa.0.0.vec.extract1019, 0x3FB99999A0000000
  %256 = tail call contract noundef float @llvm.minnum.f32(float %mul208.7, float 0x4024CB5EC0000000)
  %257 = tail call contract noundef float @llvm.exp.f32(float %256)
  %scores.sroa.0.4.vec.extract1108 = extractelement <4 x float> %255, i64 1
  %mul208.1.7 = fmul contract float %scores.sroa.0.4.vec.extract1108, 0x3FB99999A0000000
  %258 = tail call contract noundef float @llvm.minnum.f32(float %mul208.1.7, float 0x4024CB5EC0000000)
  %259 = tail call contract noundef float @llvm.exp.f32(float %258)
  %scores.sroa.0.8.vec.extract1195 = extractelement <4 x float> %255, i64 2
  %mul208.2.7 = fmul contract float %scores.sroa.0.8.vec.extract1195, 0x3FB99999A0000000
  %260 = tail call contract noundef float @llvm.minnum.f32(float %mul208.2.7, float 0x4024CB5EC0000000)
  %261 = tail call contract noundef float @llvm.exp.f32(float %260)
  %scores.sroa.0.12.vec.extract1282 = extractelement <4 x float> %255, i64 3
  %mul208.3.7 = fmul contract float %scores.sroa.0.12.vec.extract1282, 0x3FB99999A0000000
  %262 = tail call contract noundef float @llvm.minnum.f32(float %mul208.3.7, float 0x4024CB5EC0000000)
  %263 = tail call contract noundef float @llvm.exp.f32(float %262)
  %add224.7 = fadd contract float %sums.sroa.0.14, %257
  %264 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %257)
  %probs.sroa.0.0.vec.insert1361 = insertelement <4 x i16> poison, i16 %264, i64 0
  %add224.1.7 = fadd contract float %sums.sroa.22.14, %259
  %265 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %259)
  %probs.sroa.0.2.vec.insert1395 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1361, i16 %265, i64 1
  %add224.2.7 = fadd contract float %sums.sroa.42.14, %261
  %266 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %261)
  %probs.sroa.0.4.vec.insert1428 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1395, i16 %266, i64 2
  %add224.3.7 = fadd contract float %sums.sroa.62.14, %263
  %267 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %263)
  %probs.sroa.0.6.vec.insert1444 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1428, i16 %267, i64 3
  %268 = bitcast <4 x i16> %probs.sroa.0.6.vec.insert1444 to i64
  br label %if.end248.7

if.end248.7:                                      ; preds = %if.end144.7, %if.end184.7
  %sums.sroa.62.15 = phi float [ %add224.3.7, %if.end184.7 ], [ %sums.sroa.62.14, %if.end144.7 ]
  %sums.sroa.42.15 = phi float [ %add224.2.7, %if.end184.7 ], [ %sums.sroa.42.14, %if.end144.7 ]
  %sums.sroa.22.15 = phi float [ %add224.1.7, %if.end184.7 ], [ %sums.sroa.22.14, %if.end144.7 ]
  %sums.sroa.0.15 = phi float [ %add224.7, %if.end184.7 ], [ %sums.sroa.0.14, %if.end144.7 ]
  %probs.sroa.0.21 = phi i64 [ %268, %if.end184.7 ], [ 0, %if.end144.7 ]
  %add256.7 = or disjoint i32 %and254, 256
  %add.ptr258.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add256.7
  store i64 %probs.sroa.0.21, ptr addrspace(3) %add.ptr258.7, align 8
  br label %if.end259.7

if.end259.7:                                      ; preds = %if.end248.7, %if.end400.6
  %sums.sroa.62.16 = phi float [ %sums.sroa.62.14, %if.end400.6 ], [ %sums.sroa.62.15, %if.end248.7 ]
  %sums.sroa.42.16 = phi float [ %sums.sroa.42.14, %if.end400.6 ], [ %sums.sroa.42.15, %if.end248.7 ]
  %sums.sroa.22.16 = phi float [ %sums.sroa.22.14, %if.end400.6 ], [ %sums.sroa.22.15, %if.end248.7 ]
  %sums.sroa.0.16 = phi float [ %sums.sroa.0.14, %if.end400.6 ], [ %sums.sroa.0.15, %if.end248.7 ]
  br i1 %cmp262.not, label %if.then265.7, label %if.end400.7

if.then265.7:                                     ; preds = %if.end259.7
  %or.cond726.7 = icmp ugt i32 %mul11.6, 1023
  %cmp273.not.7 = icmp sgt i32 %mul11.6, %1
  %or.cond727.7 = or i1 %or.cond726.7, %cmp273.not.7
  br i1 %or.cond727.7, label %if.end400.7, label %for.cond359.preheader.7

for.cond359.preheader.7:                          ; preds = %if.then265.7
  %add305.7 = and i32 %and254, 252
  %add.ptr307.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add305.7
  %269 = load <4 x half>, ptr addrspace(3) %add.ptr307.7, align 8
  %270 = shl nsw i32 %cond.i.i689.6, 10
  %mul282.7 = and i32 %270, 64512
  %add283.7 = or disjoint i32 %mul282.7, %mul125
  %271 = zext nneg i32 %add283.7 to i64
  %272 = or disjoint i64 %271, %27
  %273 = or disjoint i64 %272, 512
  %add.ptr291.1.7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %273
  %vr.sroa.128.16.add.ptr291.1.7.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr291.1.7, i64 8
  %vr.sroa.128.16.copyload901 = load <4 x half>, ptr addrspace(4) %vr.sroa.128.16.add.ptr291.1.7.sroa_idx, align 8
  %vr.sroa.83.16.copyload893 = load <4 x half>, ptr addrspace(4) %add.ptr291.1.7, align 16
  %274 = or disjoint i64 %271, %27
  %add.ptr291.7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %274
  %vr.sroa.47.0.add.ptr291.7.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr291.7, i64 8
  %vr.sroa.47.0.copyload815 = load <4 x half>, ptr addrspace(4) %vr.sroa.47.0.add.ptr291.7.sroa_idx, align 8
  %vr.sroa.0.0.copyload807 = load <4 x half>, ptr addrspace(4) %add.ptr291.7, align 16
  %275 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload807, <4 x half> %269, <4 x float> %out_2.sroa.0.4), !call_argsrelate !164
  %276 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.47.0.copyload815, <4 x half> %269, <4 x float> %out_2.sroa.28.4), !call_argsrelate !164
  %277 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.83.16.copyload893, <4 x half> %269, <4 x float> %out_2.sroa.54.4), !call_argsrelate !164
  %278 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.128.16.copyload901, <4 x half> %269, <4 x float> %out_2.sroa.80.4), !call_argsrelate !164
  br label %if.end400.7

if.end400.7:                                      ; preds = %for.cond359.preheader.7, %if.then265.7, %if.end259.7
  %out_2.sroa.80.8 = phi <4 x float> [ %out_2.sroa.80.4, %if.end259.7 ], [ %out_2.sroa.80.4, %if.then265.7 ], [ %278, %for.cond359.preheader.7 ]
  %out_2.sroa.54.8 = phi <4 x float> [ %out_2.sroa.54.4, %if.end259.7 ], [ %out_2.sroa.54.4, %if.then265.7 ], [ %277, %for.cond359.preheader.7 ]
  %out_2.sroa.28.8 = phi <4 x float> [ %out_2.sroa.28.4, %if.end259.7 ], [ %out_2.sroa.28.4, %if.then265.7 ], [ %276, %for.cond359.preheader.7 ]
  %out_2.sroa.0.8 = phi <4 x float> [ %out_2.sroa.0.4, %if.end259.7 ], [ %out_2.sroa.0.4, %if.then265.7 ], [ %275, %for.cond359.preheader.7 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br label %if.end259.8

if.end259.8:                                      ; preds = %if.end400.7
  br i1 %cmp262.not, label %if.then265.8, label %if.end400.8

if.then265.8:                                     ; preds = %if.end259.8
  %or.cond726.8 = icmp ugt i32 %mul11.7, 1023
  %cmp273.not.8 = icmp sgt i32 %mul11.7, %1
  %or.cond727.8 = or i1 %or.cond726.8, %cmp273.not.8
  br i1 %or.cond727.8, label %if.end400.8, label %for.cond378.preheader.8

for.cond378.preheader.8:                          ; preds = %if.then265.8
  %add.ptr307.8 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and254
  %279 = load <4 x half>, ptr addrspace(3) %add.ptr307.8, align 8
  %280 = shl nsw i32 %cond.i.i689.7, 10
  %mul282.8 = and i32 %280, 64512
  %add283.8 = or disjoint i32 %mul282.8, %mul125
  %281 = zext nneg i32 %add283.8 to i64
  %282 = or disjoint i64 %281, %27
  %283 = or disjoint i64 %282, 512
  %add.ptr291.1.8 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %283
  %vr.sroa.128.16.add.ptr291.1.8.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr291.1.8, i64 8
  %vr.sroa.128.16.copyload902 = load <4 x half>, ptr addrspace(4) %vr.sroa.128.16.add.ptr291.1.8.sroa_idx, align 8
  %vr.sroa.83.16.copyload894 = load <4 x half>, ptr addrspace(4) %add.ptr291.1.8, align 16
  %284 = or disjoint i64 %281, %27
  %add.ptr291.8 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %284
  %vr.sroa.47.0.add.ptr291.8.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr291.8, i64 8
  %vr.sroa.47.0.copyload816 = load <4 x half>, ptr addrspace(4) %vr.sroa.47.0.add.ptr291.8.sroa_idx, align 8
  %vr.sroa.0.0.copyload808 = load <4 x half>, ptr addrspace(4) %add.ptr291.8, align 16
  %285 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload808, <4 x half> %279, <4 x float> %out_3.sroa.0.5), !call_argsrelate !164
  %286 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.47.0.copyload816, <4 x half> %279, <4 x float> %out_3.sroa.28.5), !call_argsrelate !164
  %287 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.83.16.copyload894, <4 x half> %279, <4 x float> %out_3.sroa.54.5), !call_argsrelate !164
  %288 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.128.16.copyload902, <4 x half> %279, <4 x float> %out_3.sroa.80.5), !call_argsrelate !164
  br label %if.end400.8

if.end400.8:                                      ; preds = %for.cond378.preheader.8, %if.then265.8, %if.end259.8
  %out_3.sroa.80.9 = phi <4 x float> [ %out_3.sroa.80.5, %if.end259.8 ], [ %out_3.sroa.80.5, %if.then265.8 ], [ %288, %for.cond378.preheader.8 ]
  %out_3.sroa.54.9 = phi <4 x float> [ %out_3.sroa.54.5, %if.end259.8 ], [ %out_3.sroa.54.5, %if.then265.8 ], [ %287, %for.cond378.preheader.8 ]
  %out_3.sroa.28.9 = phi <4 x float> [ %out_3.sroa.28.5, %if.end259.8 ], [ %out_3.sroa.28.5, %if.then265.8 ], [ %286, %for.cond378.preheader.8 ]
  %out_3.sroa.0.9 = phi <4 x float> [ %out_3.sroa.0.5, %if.end259.8 ], [ %out_3.sroa.0.5, %if.then265.8 ], [ %285, %for.cond378.preheader.8 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %cmp15, label %for.body412.preheader, label %if.end443

if.end443:                                        ; preds = %for.body412.preheader, %if.end400.8
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  %cmp446 = icmp eq i32 %shr261.mask, 64
  br i1 %cmp446, label %if.then447, label %if.end558

if.then447:                                       ; preds = %if.end443
  %and449 = and i32 %18, 63
  %arrayidx451 = getelementptr inbounds float, ptr addrspace(3) @buf_dyn_shmem, i32 %and449
  %289 = load float, ptr addrspace(3) %arrayidx451, align 4, !tbaa !105
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %out.sroa.0.6, i64 0
  %out_1.sroa.0.0.vec.extract = extractelement <4 x float> %out_1.sroa.0.7, i64 0
  %add461 = fadd contract float %out.sroa.0.0.vec.extract, %out_1.sroa.0.0.vec.extract
  %out_2.sroa.0.0.vec.extract = extractelement <4 x float> %out_2.sroa.0.8, i64 0
  %add468 = fadd contract float %add461, %out_2.sroa.0.0.vec.extract
  %out_3.sroa.0.0.vec.extract = extractelement <4 x float> %out_3.sroa.0.9, i64 0
  %add475 = fadd contract float %add468, %out_3.sroa.0.0.vec.extract
  %mul481 = fmul contract float %289, %add475
  %290 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul481)
  %oreg.sroa.0.0.insert.ext = zext i16 %290 to i64
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %out.sroa.0.6, i64 1
  %out_1.sroa.0.4.vec.extract = extractelement <4 x float> %out_1.sroa.0.7, i64 1
  %add461.1 = fadd contract float %out.sroa.0.4.vec.extract, %out_1.sroa.0.4.vec.extract
  %out_2.sroa.0.4.vec.extract = extractelement <4 x float> %out_2.sroa.0.8, i64 1
  %add468.1 = fadd contract float %add461.1, %out_2.sroa.0.4.vec.extract
  %out_3.sroa.0.4.vec.extract = extractelement <4 x float> %out_3.sroa.0.9, i64 1
  %add475.1 = fadd contract float %add468.1, %out_3.sroa.0.4.vec.extract
  %mul481.1 = fmul contract float %289, %add475.1
  %291 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul481.1)
  %oreg.sroa.0.2.insert.ext = zext i16 %291 to i64
  %oreg.sroa.0.2.insert.shift = shl nuw nsw i64 %oreg.sroa.0.2.insert.ext, 16
  %oreg.sroa.0.2.insert.insert = or disjoint i64 %oreg.sroa.0.2.insert.shift, %oreg.sroa.0.0.insert.ext
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %out.sroa.0.6, i64 2
  %out_1.sroa.0.8.vec.extract = extractelement <4 x float> %out_1.sroa.0.7, i64 2
  %add461.2 = fadd contract float %out.sroa.0.8.vec.extract, %out_1.sroa.0.8.vec.extract
  %out_2.sroa.0.8.vec.extract = extractelement <4 x float> %out_2.sroa.0.8, i64 2
  %add468.2 = fadd contract float %add461.2, %out_2.sroa.0.8.vec.extract
  %out_3.sroa.0.8.vec.extract = extractelement <4 x float> %out_3.sroa.0.9, i64 2
  %add475.2 = fadd contract float %add468.2, %out_3.sroa.0.8.vec.extract
  %mul481.2 = fmul contract float %289, %add475.2
  %292 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul481.2)
  %oreg.sroa.0.4.insert.ext = zext i16 %292 to i64
  %oreg.sroa.0.4.insert.shift = shl nuw nsw i64 %oreg.sroa.0.4.insert.ext, 32
  %oreg.sroa.0.4.insert.insert = or disjoint i64 %oreg.sroa.0.2.insert.insert, %oreg.sroa.0.4.insert.shift
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %out.sroa.0.6, i64 3
  %out_1.sroa.0.12.vec.extract = extractelement <4 x float> %out_1.sroa.0.7, i64 3
  %add461.3 = fadd contract float %out.sroa.0.12.vec.extract, %out_1.sroa.0.12.vec.extract
  %out_2.sroa.0.12.vec.extract = extractelement <4 x float> %out_2.sroa.0.8, i64 3
  %add468.3 = fadd contract float %add461.3, %out_2.sroa.0.12.vec.extract
  %out_3.sroa.0.12.vec.extract = extractelement <4 x float> %out_3.sroa.0.9, i64 3
  %add475.3 = fadd contract float %add468.3, %out_3.sroa.0.12.vec.extract
  %mul481.3 = fmul contract float %289, %add475.3
  %293 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul481.3)
  %oreg.sroa.0.6.insert.ext = zext i16 %293 to i64
  %oreg.sroa.0.6.insert.shift = shl nuw i64 %oreg.sroa.0.6.insert.ext, 48
  %oreg.sroa.0.6.insert.insert = or disjoint i64 %oreg.sroa.0.4.insert.insert, %oreg.sroa.0.6.insert.shift
  %out.sroa.40.16.vec.extract = extractelement <4 x float> %out.sroa.40.6, i64 0
  %out_1.sroa.28.16.vec.extract = extractelement <4 x float> %out_1.sroa.28.7, i64 0
  %add461.4 = fadd contract float %out.sroa.40.16.vec.extract, %out_1.sroa.28.16.vec.extract
  %out_2.sroa.28.16.vec.extract = extractelement <4 x float> %out_2.sroa.28.8, i64 0
  %add468.4 = fadd contract float %add461.4, %out_2.sroa.28.16.vec.extract
  %out_3.sroa.28.16.vec.extract = extractelement <4 x float> %out_3.sroa.28.9, i64 0
  %add475.4 = fadd contract float %add468.4, %out_3.sroa.28.16.vec.extract
  %mul481.4 = fmul contract float %289, %add475.4
  %294 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul481.4)
  %oreg.sroa.7.8.insert.ext = zext i16 %294 to i64
  %out.sroa.40.20.vec.extract = extractelement <4 x float> %out.sroa.40.6, i64 1
  %out_1.sroa.28.20.vec.extract = extractelement <4 x float> %out_1.sroa.28.7, i64 1
  %add461.5 = fadd contract float %out.sroa.40.20.vec.extract, %out_1.sroa.28.20.vec.extract
  %out_2.sroa.28.20.vec.extract = extractelement <4 x float> %out_2.sroa.28.8, i64 1
  %add468.5 = fadd contract float %add461.5, %out_2.sroa.28.20.vec.extract
  %out_3.sroa.28.20.vec.extract = extractelement <4 x float> %out_3.sroa.28.9, i64 1
  %add475.5 = fadd contract float %add468.5, %out_3.sroa.28.20.vec.extract
  %mul481.5 = fmul contract float %289, %add475.5
  %295 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul481.5)
  %oreg.sroa.7.10.insert.ext = zext i16 %295 to i64
  %oreg.sroa.7.10.insert.shift = shl nuw nsw i64 %oreg.sroa.7.10.insert.ext, 16
  %oreg.sroa.7.10.insert.insert = or disjoint i64 %oreg.sroa.7.10.insert.shift, %oreg.sroa.7.8.insert.ext
  %out.sroa.40.24.vec.extract = extractelement <4 x float> %out.sroa.40.6, i64 2
  %out_1.sroa.28.24.vec.extract = extractelement <4 x float> %out_1.sroa.28.7, i64 2
  %add461.6 = fadd contract float %out.sroa.40.24.vec.extract, %out_1.sroa.28.24.vec.extract
  %out_2.sroa.28.24.vec.extract = extractelement <4 x float> %out_2.sroa.28.8, i64 2
  %add468.6 = fadd contract float %add461.6, %out_2.sroa.28.24.vec.extract
  %out_3.sroa.28.24.vec.extract = extractelement <4 x float> %out_3.sroa.28.9, i64 2
  %add475.6 = fadd contract float %add468.6, %out_3.sroa.28.24.vec.extract
  %mul481.6 = fmul contract float %289, %add475.6
  %296 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul481.6)
  %oreg.sroa.7.12.insert.ext = zext i16 %296 to i64
  %oreg.sroa.7.12.insert.shift = shl nuw nsw i64 %oreg.sroa.7.12.insert.ext, 32
  %oreg.sroa.7.12.insert.insert = or disjoint i64 %oreg.sroa.7.10.insert.insert, %oreg.sroa.7.12.insert.shift
  %out.sroa.40.28.vec.extract = extractelement <4 x float> %out.sroa.40.6, i64 3
  %out_1.sroa.28.28.vec.extract = extractelement <4 x float> %out_1.sroa.28.7, i64 3
  %add461.7 = fadd contract float %out.sroa.40.28.vec.extract, %out_1.sroa.28.28.vec.extract
  %out_2.sroa.28.28.vec.extract = extractelement <4 x float> %out_2.sroa.28.8, i64 3
  %add468.7 = fadd contract float %add461.7, %out_2.sroa.28.28.vec.extract
  %out_3.sroa.28.28.vec.extract = extractelement <4 x float> %out_3.sroa.28.9, i64 3
  %add475.7 = fadd contract float %add468.7, %out_3.sroa.28.28.vec.extract
  %mul481.7 = fmul contract float %289, %add475.7
  %297 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul481.7)
  %oreg.sroa.7.14.insert.ext = zext i16 %297 to i64
  %oreg.sroa.7.14.insert.shift = shl nuw i64 %oreg.sroa.7.14.insert.ext, 48
  %oreg.sroa.7.14.insert.insert = or disjoint i64 %oreg.sroa.7.12.insert.insert, %oreg.sroa.7.14.insert.shift
  %out.sroa.78.32.vec.extract = extractelement <4 x float> %out.sroa.78.6, i64 0
  %out_1.sroa.54.32.vec.extract = extractelement <4 x float> %out_1.sroa.54.7, i64 0
  %add461.8 = fadd contract float %out.sroa.78.32.vec.extract, %out_1.sroa.54.32.vec.extract
  %out_2.sroa.54.32.vec.extract = extractelement <4 x float> %out_2.sroa.54.8, i64 0
  %add468.8 = fadd contract float %add461.8, %out_2.sroa.54.32.vec.extract
  %out_3.sroa.54.32.vec.extract = extractelement <4 x float> %out_3.sroa.54.9, i64 0
  %add475.8 = fadd contract float %add468.8, %out_3.sroa.54.32.vec.extract
  %mul481.8 = fmul contract float %289, %add475.8
  %298 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul481.8)
  %oreg.sroa.12.16.insert.ext = zext i16 %298 to i64
  %out.sroa.78.36.vec.extract = extractelement <4 x float> %out.sroa.78.6, i64 1
  %out_1.sroa.54.36.vec.extract = extractelement <4 x float> %out_1.sroa.54.7, i64 1
  %add461.9 = fadd contract float %out.sroa.78.36.vec.extract, %out_1.sroa.54.36.vec.extract
  %out_2.sroa.54.36.vec.extract = extractelement <4 x float> %out_2.sroa.54.8, i64 1
  %add468.9 = fadd contract float %add461.9, %out_2.sroa.54.36.vec.extract
  %out_3.sroa.54.36.vec.extract = extractelement <4 x float> %out_3.sroa.54.9, i64 1
  %add475.9 = fadd contract float %add468.9, %out_3.sroa.54.36.vec.extract
  %mul481.9 = fmul contract float %289, %add475.9
  %299 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul481.9)
  %oreg.sroa.12.18.insert.ext = zext i16 %299 to i64
  %oreg.sroa.12.18.insert.shift = shl nuw nsw i64 %oreg.sroa.12.18.insert.ext, 16
  %oreg.sroa.12.18.insert.insert = or disjoint i64 %oreg.sroa.12.18.insert.shift, %oreg.sroa.12.16.insert.ext
  %out.sroa.78.40.vec.extract = extractelement <4 x float> %out.sroa.78.6, i64 2
  %out_1.sroa.54.40.vec.extract = extractelement <4 x float> %out_1.sroa.54.7, i64 2
  %add461.10 = fadd contract float %out.sroa.78.40.vec.extract, %out_1.sroa.54.40.vec.extract
  %out_2.sroa.54.40.vec.extract = extractelement <4 x float> %out_2.sroa.54.8, i64 2
  %add468.10 = fadd contract float %add461.10, %out_2.sroa.54.40.vec.extract
  %out_3.sroa.54.40.vec.extract = extractelement <4 x float> %out_3.sroa.54.9, i64 2
  %add475.10 = fadd contract float %add468.10, %out_3.sroa.54.40.vec.extract
  %mul481.10 = fmul contract float %289, %add475.10
  %300 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul481.10)
  %oreg.sroa.12.20.insert.ext = zext i16 %300 to i64
  %oreg.sroa.12.20.insert.shift = shl nuw nsw i64 %oreg.sroa.12.20.insert.ext, 32
  %oreg.sroa.12.20.insert.insert = or disjoint i64 %oreg.sroa.12.18.insert.insert, %oreg.sroa.12.20.insert.shift
  %out.sroa.78.44.vec.extract = extractelement <4 x float> %out.sroa.78.6, i64 3
  %out_1.sroa.54.44.vec.extract = extractelement <4 x float> %out_1.sroa.54.7, i64 3
  %add461.11 = fadd contract float %out.sroa.78.44.vec.extract, %out_1.sroa.54.44.vec.extract
  %out_2.sroa.54.44.vec.extract = extractelement <4 x float> %out_2.sroa.54.8, i64 3
  %add468.11 = fadd contract float %add461.11, %out_2.sroa.54.44.vec.extract
  %out_3.sroa.54.44.vec.extract = extractelement <4 x float> %out_3.sroa.54.9, i64 3
  %add475.11 = fadd contract float %add468.11, %out_3.sroa.54.44.vec.extract
  %mul481.11 = fmul contract float %289, %add475.11
  %301 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul481.11)
  %oreg.sroa.12.22.insert.ext = zext i16 %301 to i64
  %oreg.sroa.12.22.insert.shift = shl nuw i64 %oreg.sroa.12.22.insert.ext, 48
  %oreg.sroa.12.22.insert.insert = or disjoint i64 %oreg.sroa.12.20.insert.insert, %oreg.sroa.12.22.insert.shift
  %out.sroa.116.48.vec.extract = extractelement <4 x float> %out.sroa.116.6, i64 0
  %out_1.sroa.80.48.vec.extract = extractelement <4 x float> %out_1.sroa.80.7, i64 0
  %add461.12 = fadd contract float %out.sroa.116.48.vec.extract, %out_1.sroa.80.48.vec.extract
  %out_2.sroa.80.48.vec.extract = extractelement <4 x float> %out_2.sroa.80.8, i64 0
  %add468.12 = fadd contract float %add461.12, %out_2.sroa.80.48.vec.extract
  %out_3.sroa.80.48.vec.extract = extractelement <4 x float> %out_3.sroa.80.9, i64 0
  %add475.12 = fadd contract float %add468.12, %out_3.sroa.80.48.vec.extract
  %mul481.12 = fmul contract float %289, %add475.12
  %302 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul481.12)
  %oreg.sroa.17.24.insert.ext = zext i16 %302 to i64
  %out.sroa.116.52.vec.extract = extractelement <4 x float> %out.sroa.116.6, i64 1
  %out_1.sroa.80.52.vec.extract = extractelement <4 x float> %out_1.sroa.80.7, i64 1
  %add461.13 = fadd contract float %out.sroa.116.52.vec.extract, %out_1.sroa.80.52.vec.extract
  %out_2.sroa.80.52.vec.extract = extractelement <4 x float> %out_2.sroa.80.8, i64 1
  %add468.13 = fadd contract float %add461.13, %out_2.sroa.80.52.vec.extract
  %out_3.sroa.80.52.vec.extract = extractelement <4 x float> %out_3.sroa.80.9, i64 1
  %add475.13 = fadd contract float %add468.13, %out_3.sroa.80.52.vec.extract
  %mul481.13 = fmul contract float %289, %add475.13
  %303 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul481.13)
  %oreg.sroa.17.26.insert.ext = zext i16 %303 to i64
  %oreg.sroa.17.26.insert.shift = shl nuw nsw i64 %oreg.sroa.17.26.insert.ext, 16
  %oreg.sroa.17.26.insert.insert = or disjoint i64 %oreg.sroa.17.26.insert.shift, %oreg.sroa.17.24.insert.ext
  %out.sroa.116.56.vec.extract = extractelement <4 x float> %out.sroa.116.6, i64 2
  %out_1.sroa.80.56.vec.extract = extractelement <4 x float> %out_1.sroa.80.7, i64 2
  %add461.14 = fadd contract float %out.sroa.116.56.vec.extract, %out_1.sroa.80.56.vec.extract
  %out_2.sroa.80.56.vec.extract = extractelement <4 x float> %out_2.sroa.80.8, i64 2
  %add468.14 = fadd contract float %add461.14, %out_2.sroa.80.56.vec.extract
  %out_3.sroa.80.56.vec.extract = extractelement <4 x float> %out_3.sroa.80.9, i64 2
  %add475.14 = fadd contract float %add468.14, %out_3.sroa.80.56.vec.extract
  %mul481.14 = fmul contract float %289, %add475.14
  %304 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul481.14)
  %oreg.sroa.17.28.insert.ext = zext i16 %304 to i64
  %oreg.sroa.17.28.insert.shift = shl nuw nsw i64 %oreg.sroa.17.28.insert.ext, 32
  %oreg.sroa.17.28.insert.insert = or disjoint i64 %oreg.sroa.17.26.insert.insert, %oreg.sroa.17.28.insert.shift
  %out.sroa.116.60.vec.extract = extractelement <4 x float> %out.sroa.116.6, i64 3
  %out_1.sroa.80.60.vec.extract = extractelement <4 x float> %out_1.sroa.80.7, i64 3
  %add461.15 = fadd contract float %out.sroa.116.60.vec.extract, %out_1.sroa.80.60.vec.extract
  %out_2.sroa.80.60.vec.extract = extractelement <4 x float> %out_2.sroa.80.8, i64 3
  %add468.15 = fadd contract float %add461.15, %out_2.sroa.80.60.vec.extract
  %out_3.sroa.80.60.vec.extract = extractelement <4 x float> %out_3.sroa.80.9, i64 3
  %add475.15 = fadd contract float %add468.15, %out_3.sroa.80.60.vec.extract
  %mul481.15 = fmul contract float %289, %add475.15
  %305 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul481.15)
  %oreg.sroa.17.30.insert.ext = zext i16 %305 to i64
  %oreg.sroa.17.30.insert.shift = shl nuw i64 %oreg.sroa.17.30.insert.ext, 48
  %oreg.sroa.17.30.insert.insert = or disjoint i64 %oreg.sroa.17.28.insert.insert, %oreg.sroa.17.30.insert.shift
  %and501 = shl nuw nsw i32 %18, 6
  %mul502 = and i32 %and501, 960
  %and505 = lshr i32 %18, 5
  %shr506 = and i32 %and505, 1
  %and509 = and i32 %18, 7
  %mul515 = and i32 %25, 4
  %xor = xor i32 %shr506, %and509
  %mul510 = shl nuw nsw i32 %xor, 3
  %add511 = or disjoint i32 %mul510, %mul502
  %add516 = or disjoint i32 %add511, %mul515
  %add.ptr518 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add516
  store i64 %oreg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr518, align 8
  %xor.1 = xor i32 %and505, %and509
  %mul510.1 = shl nuw nsw i32 %xor.1, 3
  %add511.1 = or disjoint i32 %mul510.1, %mul502
  %add516.1 = or disjoint i32 %add511.1, %mul515
  %add.ptr518.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add516.1
  store i64 %oreg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr518.1, align 8
  %add507.2 = or disjoint i32 %shr506, 4
  %xor.2 = xor i32 %add507.2, %and509
  %mul510.2 = shl nuw nsw i32 %xor.2, 3
  %add511.2 = or disjoint i32 %mul510.2, %mul502
  %add516.2 = or disjoint i32 %add511.2, %mul515
  %add.ptr518.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add516.2
  store i64 %oreg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr518.2, align 8
  %add507.3 = or i32 %and505, 6
  %xor.3 = xor i32 %add507.3, %and509
  %mul510.3 = shl nuw nsw i32 %xor.3, 3
  %add511.3 = or disjoint i32 %mul510.3, %mul502
  %add516.3 = or disjoint i32 %add511.3, %mul515
  %add.ptr518.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add516.3
  store i64 %oreg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr518.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul530 = and i32 %and132, 448
  %xor537 = xor i32 %and132, %18
  %mul538 = and i32 %xor537, 56
  %306 = or disjoint i32 %mul538, %mul530
  %mul543 = shl nsw i32 %0, 20
  %mul545 = shl nsw i32 %1, 10
  %add546 = add nuw nsw i32 %mul543, %mul545
  %307 = or disjoint i32 %add546, %mul288
  %308 = zext nneg i32 %307 to i64
  %add.ptr541 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %306
  %add.ptr554 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %308
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr554, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr541, i64 16, i1 false), !tbaa.struct !209, !call_argsrelate !210
  %309 = or disjoint i32 %306, 512
  %add.ptr541.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %309
  %310 = or disjoint i64 %308, 512
  %add.ptr554.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %310
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr554.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr541.1, i64 16, i1 false), !tbaa.struct !209, !call_argsrelate !210
  br label %if.end558

if.end558:                                        ; preds = %if.then447, %if.end443
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


