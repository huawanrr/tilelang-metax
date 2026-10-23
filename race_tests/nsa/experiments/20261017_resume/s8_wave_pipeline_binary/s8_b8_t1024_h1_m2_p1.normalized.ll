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
  %cond.i.i743 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64)
  %mul11 = shl nsw i32 %cond.i.i743, 4
  %4 = or disjoint i64 %2, 1
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !call_argsrelate !48
  %cond.i.i743.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64)
  %mul11.1 = shl nsw i32 %cond.i.i743.1, 4
  %6 = or disjoint i64 %2, 2
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !call_argsrelate !48
  %cond.i.i743.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64)
  %mul11.2 = shl nsw i32 %cond.i.i743.2, 4
  %8 = or disjoint i64 %2, 3
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !call_argsrelate !48
  %cond.i.i743.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64)
  %mul11.3 = shl nsw i32 %cond.i.i743.3, 4
  %10 = or disjoint i64 %2, 4
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !call_argsrelate !48
  %cond.i.i743.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64)
  %mul11.4 = shl nsw i32 %cond.i.i743.4, 4
  %12 = or disjoint i64 %2, 5
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !call_argsrelate !48
  %cond.i.i743.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64)
  %mul11.5 = shl nsw i32 %cond.i.i743.5, 4
  %14 = or disjoint i64 %2, 6
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !call_argsrelate !48
  %cond.i.i743.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64)
  %mul11.6 = shl nsw i32 %cond.i.i743.6, 4
  %16 = or disjoint i64 %2, 7
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !call_argsrelate !48
  %cond.i.i743.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64)
  %mul11.7 = shl nsw i32 %cond.i.i743.7, 4
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
  %qr.sroa.13.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %qr.sroa.13.0.copyload = load <4 x half>, ptr addrspace(4) %qr.sroa.13.0.add.ptr.sroa_idx, align 8
  %23 = or disjoint i64 %20, %21
  %24 = or disjoint i64 %23, 32
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %24
  %qr.sroa.23.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16
  %qr.sroa.34.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr.1, i64 8
  %qr.sroa.34.16.copyload = load <4 x half>, ptr addrspace(4) %qr.sroa.34.16.add.ptr.1.sroa_idx, align 8
  br label %if.end

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
  %26 = zext nneg i32 %and138 to i64
  %27 = zext nneg i32 %mul318 to i64
  br i1 %cmp108, label %if.end441, label %for.cond111.preheader

for.body453.preheader:                            ; preds = %if.end441.4
  %add457 = fadd contract float %sums.sroa.0.12, 0.000000e+00
  %add457.1 = fadd contract float %add457, %sums.sroa.24.12
  %add457.2 = fadd contract float %add457.1, %sums.sroa.46.12
  %add457.3 = fadd contract float %add457.2, %sums.sroa.68.12
  %28 = bitcast float %add457.3 to i32
  %29 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %30 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %29) #11
  %xor.i.i = xor i32 %30, 32
  %31 = and i32 %30, -64
  %and.i.i = add nsw i32 %31, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i744 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %30
  %shl.i.i = shl i32 %cond.i.i744, 2
  %32 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %28)
  %33 = bitcast i32 %32 to float
  %add465 = fadd contract float %add457.3, %33
  %34 = bitcast float %add465 to i32
  %35 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %36 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %35) #11
  %xor.i.i745 = xor i32 %36, 16
  %37 = and i32 %36, -64
  %and.i.i746 = add nsw i32 %37, 64
  %cmp.not.i.i747 = icmp slt i32 %xor.i.i745, %and.i.i746
  %cond.i.i748 = select i1 %cmp.not.i.i747, i32 %xor.i.i745, i32 %36
  %shl.i.i749 = shl i32 %cond.i.i748, 2
  %38 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i749, i32 %34)
  %39 = bitcast i32 %38 to float
  %add470 = fadd contract float %add465, %39
  %cmp473 = fcmp contract ogt float %add470, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add470
  %condval_1.0 = select i1 %cmp473, float %div, float 0.000000e+00
  %arrayidx483 = getelementptr inbounds float, ptr addrspace(3) @buf_dyn_shmem, i32 %18
  store float %condval_1.0, ptr addrspace(3) %arrayidx483, align 4, !tbaa !105
  br label %if.end484

for.cond111.preheader:                            ; preds = %if.end
  %or.cond780 = icmp ugt i32 %mul11, 1023
  %cmp124.not = icmp sgt i32 %mul11, %1
  %or.cond781 = or i1 %or.cond780, %cmp124.not
  br i1 %or.cond781, label %if.end152, label %for.cond126.preheader

for.cond126.preheader:                            ; preds = %for.cond111.preheader
  %40 = shl nsw i32 %cond.i.i743, 10
  %mul133 = and i32 %40, 64512
  %add134 = or disjoint i32 %mul133, %mul131
  %41 = zext nneg i32 %add134 to i64
  %42 = or disjoint i64 %41, %26
  %add.ptr142 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %42
  %kr.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr142, align 16
  %kr.sroa.12.0.add.ptr142.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142, i64 8
  %kr.sroa.12.0.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.12.0.add.ptr142.sroa_idx, align 8
  %43 = or disjoint i64 %41, %26
  %44 = or disjoint i64 %43, 512
  %add.ptr142.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %44
  %kr.sroa.17.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr142.1, align 16
  %kr.sroa.27.16.add.ptr142.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1, i64 8
  %kr.sroa.27.16.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.27.16.add.ptr142.1.sroa_idx, align 8
  br label %if.end152

if.end152:                                        ; preds = %for.cond126.preheader, %for.cond111.preheader
  %kr.sroa.27.0 = phi <4 x half> [ undef, %for.cond111.preheader ], [ %kr.sroa.27.16.copyload, %for.cond126.preheader ]
  %kr.sroa.17.0 = phi <4 x half> [ undef, %for.cond111.preheader ], [ %kr.sroa.17.16.copyload, %for.cond126.preheader ]
  %kr.sroa.12.0 = phi <4 x half> [ undef, %for.cond111.preheader ], [ %kr.sroa.12.0.copyload, %for.cond126.preheader ]
  %kr.sroa.0.0 = phi <4 x half> [ undef, %for.cond111.preheader ], [ %kr.sroa.0.0.copyload, %for.cond126.preheader ]
  %or.cond780.1 = icmp ugt i32 %mul11.1, 1023
  %cmp124.not.1 = icmp sgt i32 %mul11.1, %1
  %or.cond781.1 = or i1 %or.cond780.1, %cmp124.not.1
  br i1 %or.cond781.1, label %if.end152.1, label %for.cond126.preheader.1

for.cond126.preheader.1:                          ; preds = %if.end152
  %45 = shl nsw i32 %cond.i.i743.1, 10
  %mul133.1 = and i32 %45, 64512
  %add134.1 = or disjoint i32 %mul133.1, %mul131
  %46 = zext nneg i32 %add134.1 to i64
  %47 = or disjoint i64 %46, %26
  %add.ptr142.1801 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %47
  %kr.sroa.32.32.copyload = load <4 x half>, ptr addrspace(4) %add.ptr142.1801, align 16
  %kr.sroa.42.32.add.ptr142.1801.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1801, i64 8
  %kr.sroa.42.32.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.42.32.add.ptr142.1801.sroa_idx, align 8
  %48 = or disjoint i64 %46, %26
  %49 = or disjoint i64 %48, 512
  %add.ptr142.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %49
  %kr.sroa.47.48.copyload = load <4 x half>, ptr addrspace(4) %add.ptr142.1.1, align 16
  %kr.sroa.57.48.add.ptr142.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1.1, i64 8
  %kr.sroa.57.48.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.57.48.add.ptr142.1.1.sroa_idx, align 8
  br label %if.end152.1

if.end152.1:                                      ; preds = %for.cond126.preheader.1, %if.end152
  %kr.sroa.57.0 = phi <4 x half> [ undef, %if.end152 ], [ %kr.sroa.57.48.copyload, %for.cond126.preheader.1 ]
  %kr.sroa.47.0 = phi <4 x half> [ undef, %if.end152 ], [ %kr.sroa.47.48.copyload, %for.cond126.preheader.1 ]
  %kr.sroa.42.0 = phi <4 x half> [ undef, %if.end152 ], [ %kr.sroa.42.32.copyload, %for.cond126.preheader.1 ]
  %kr.sroa.32.0 = phi <4 x half> [ undef, %if.end152 ], [ %kr.sroa.32.32.copyload, %for.cond126.preheader.1 ]
  br i1 %or.cond781, label %if.end267, label %if.then170

if.then170:                                       ; preds = %if.end152.1
  %cmp173 = icmp sgt i32 %mul11, %invariant.op
  br i1 %cmp173, label %for.cond175.preheader, label %if.end201

for.cond175.preheader:                            ; preds = %if.then170
  %add183 = or disjoint i32 %mul11, %mul182
  %cmp186.not = icmp sgt i32 %add183, %1
  %spec.select = select i1 %cmp186.not, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1146 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp186.not.1.not = icmp slt i32 %add183, %1
  %spec.select.1 = select i1 %cmp186.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1261 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1146, float %spec.select.1, i64 1
  %add184.2 = or disjoint i32 %add183, 2
  %cmp186.not.2 = icmp sgt i32 %add184.2, %1
  %spec.select.2 = select i1 %cmp186.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1358 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1261, float %spec.select.2, i64 2
  %add184.3 = or disjoint i32 %add183, 3
  %cmp186.not.3 = icmp sgt i32 %add184.3, %1
  %spec.select.3 = select i1 %cmp186.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1455 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1358, float %spec.select.3, i64 3
  br label %if.end201

if.end201:                                        ; preds = %if.then170, %for.cond175.preheader
  %scores.sroa.0.0 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1455, %for.cond175.preheader ], [ zeroinitializer, %if.then170 ]
  %50 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.0)
  %51 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.12.0, <4 x half> %qr.sroa.13.0, <4 x float> %50)
  %52 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.17.0, <4 x half> %qr.sroa.23.0, <4 x float> %51)
  %53 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.27.0, <4 x half> %qr.sroa.34.0, <4 x float> %52)
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %53, i64 0
  %mul227 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %54 = tail call contract noundef float @llvm.minnum.f32(float %mul227, float 0x4024CB5EC0000000)
  %55 = tail call contract noundef float @llvm.exp.f32(float %54)
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %53, i64 1
  %mul227.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %56 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1, float 0x4024CB5EC0000000)
  %57 = tail call contract noundef float @llvm.exp.f32(float %56)
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %53, i64 2
  %mul227.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %58 = tail call contract noundef float @llvm.minnum.f32(float %mul227.2, float 0x4024CB5EC0000000)
  %59 = tail call contract noundef float @llvm.exp.f32(float %58)
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %53, i64 3
  %mul227.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %60 = tail call contract noundef float @llvm.minnum.f32(float %mul227.3, float 0x4024CB5EC0000000)
  %61 = tail call contract noundef float @llvm.exp.f32(float %60)
  %62 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %55)
  %probs.sroa.0.0.vec.insert = insertelement <4 x i16> poison, i16 %62, i64 0
  %63 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %57)
  %probs.sroa.0.2.vec.insert = insertelement <4 x i16> %probs.sroa.0.0.vec.insert, i16 %63, i64 1
  %64 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %59)
  %probs.sroa.0.4.vec.insert = insertelement <4 x i16> %probs.sroa.0.2.vec.insert, i16 %64, i64 2
  %65 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %61)
  %probs.sroa.0.6.vec.insert = insertelement <4 x i16> %probs.sroa.0.4.vec.insert, i16 %65, i64 3
  br label %if.end267

if.end267:                                        ; preds = %if.end152.1, %if.end201
  %sums.sroa.68.1 = phi float [ %61, %if.end201 ], [ 0.000000e+00, %if.end152.1 ]
  %sums.sroa.46.1 = phi float [ %59, %if.end201 ], [ 0.000000e+00, %if.end152.1 ]
  %sums.sroa.24.1 = phi float [ %57, %if.end201 ], [ 0.000000e+00, %if.end152.1 ]
  %sums.sroa.0.1 = phi float [ %55, %if.end201 ], [ 0.000000e+00, %if.end152.1 ]
  %probs.sroa.0.0 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert, %if.end201 ], [ zeroinitializer, %if.end152.1 ]
  %add.ptr279 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and275
  store <4 x i16> %probs.sroa.0.0, ptr addrspace(3) %add.ptr279, align 8
  br i1 %or.cond781.1, label %if.end267.1, label %if.then170.1

if.then170.1:                                     ; preds = %if.end267
  %cmp173.1 = icmp sgt i32 %mul11.1, %invariant.op
  br i1 %cmp173.1, label %for.cond175.preheader.1, label %if.end201.1

for.cond175.preheader.1:                          ; preds = %if.then170.1
  %add183.1 = or disjoint i32 %mul11.1, %mul182
  %cmp186.not.1804 = icmp sgt i32 %add183.1, %1
  %spec.select.1805 = select i1 %cmp186.not.1804, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1155 = insertelement <4 x float> poison, float %spec.select.1805, i64 0
  %cmp186.not.1.1.not = icmp slt i32 %add183.1, %1
  %spec.select.1.1 = select i1 %cmp186.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1268 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1155, float %spec.select.1.1, i64 1
  %add184.2.1 = or disjoint i32 %add183.1, 2
  %cmp186.not.2.1 = icmp sgt i32 %add184.2.1, %1
  %spec.select.2.1 = select i1 %cmp186.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1365 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1268, float %spec.select.2.1, i64 2
  %add184.3.1 = or disjoint i32 %add183.1, 3
  %cmp186.not.3.1 = icmp sgt i32 %add184.3.1, %1
  %spec.select.3.1 = select i1 %cmp186.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1462 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1365, float %spec.select.3.1, i64 3
  br label %if.end201.1

if.end201.1:                                      ; preds = %if.then170.1, %for.cond175.preheader.1
  %scores.sroa.0.2 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1462, %for.cond175.preheader.1 ], [ zeroinitializer, %if.then170.1 ]
  %66 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.32.0, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.2)
  %67 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.42.0, <4 x half> %qr.sroa.13.0, <4 x float> %66)
  %68 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.0, <4 x half> %qr.sroa.23.0, <4 x float> %67)
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.57.0, <4 x half> %qr.sroa.34.0, <4 x float> %68)
  %scores.sroa.0.0.vec.extract1157 = extractelement <4 x float> %69, i64 0
  %mul227.1808 = fmul contract float %scores.sroa.0.0.vec.extract1157, 0x3FB99999A0000000
  %70 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1808, float 0x4024CB5EC0000000)
  %71 = tail call contract noundef float @llvm.exp.f32(float %70)
  %scores.sroa.0.4.vec.extract1270 = extractelement <4 x float> %69, i64 1
  %mul227.1.1 = fmul contract float %scores.sroa.0.4.vec.extract1270, 0x3FB99999A0000000
  %72 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1.1, float 0x4024CB5EC0000000)
  %73 = tail call contract noundef float @llvm.exp.f32(float %72)
  %scores.sroa.0.8.vec.extract1367 = extractelement <4 x float> %69, i64 2
  %mul227.2.1 = fmul contract float %scores.sroa.0.8.vec.extract1367, 0x3FB99999A0000000
  %74 = tail call contract noundef float @llvm.minnum.f32(float %mul227.2.1, float 0x4024CB5EC0000000)
  %75 = tail call contract noundef float @llvm.exp.f32(float %74)
  %scores.sroa.0.12.vec.extract1464 = extractelement <4 x float> %69, i64 3
  %mul227.3.1 = fmul contract float %scores.sroa.0.12.vec.extract1464, 0x3FB99999A0000000
  %76 = tail call contract noundef float @llvm.minnum.f32(float %mul227.3.1, float 0x4024CB5EC0000000)
  %77 = tail call contract noundef float @llvm.exp.f32(float %76)
  %add243.1809 = fadd contract float %sums.sroa.0.1, %71
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %71)
  %probs.sroa.0.0.vec.insert1593 = insertelement <4 x i16> poison, i16 %78, i64 0
  %add243.1.1 = fadd contract float %sums.sroa.24.1, %73
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %73)
  %probs.sroa.0.2.vec.insert1631 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1593, i16 %79, i64 1
  %add243.2.1 = fadd contract float %sums.sroa.46.1, %75
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %75)
  %probs.sroa.0.4.vec.insert1668 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1631, i16 %80, i64 2
  %add243.3.1 = fadd contract float %sums.sroa.68.1, %77
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %77)
  %probs.sroa.0.6.vec.insert1686 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1668, i16 %81, i64 3
  br label %if.end267.1

if.end267.1:                                      ; preds = %if.end267, %if.end201.1
  %sums.sroa.68.2 = phi float [ %add243.3.1, %if.end201.1 ], [ %sums.sroa.68.1, %if.end267 ]
  %sums.sroa.46.2 = phi float [ %add243.2.1, %if.end201.1 ], [ %sums.sroa.46.1, %if.end267 ]
  %sums.sroa.24.2 = phi float [ %add243.1.1, %if.end201.1 ], [ %sums.sroa.24.1, %if.end267 ]
  %sums.sroa.0.2 = phi float [ %add243.1809, %if.end201.1 ], [ %sums.sroa.0.1, %if.end267 ]
  %probs.sroa.0.1 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1686, %if.end201.1 ], [ zeroinitializer, %if.end267 ]
  %add277.1 = or disjoint i32 %and275, 256
  %add.ptr279.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add277.1
  store <4 x i16> %probs.sroa.0.1, ptr addrspace(3) %add.ptr279.1, align 8
  br label %if.end441

if.end441:                                        ; preds = %if.end, %if.end267.1
  %sums.sroa.68.3 = phi float [ 0.000000e+00, %if.end ], [ %sums.sroa.68.2, %if.end267.1 ]
  %sums.sroa.46.3 = phi float [ 0.000000e+00, %if.end ], [ %sums.sroa.46.2, %if.end267.1 ]
  %sums.sroa.24.3 = phi float [ 0.000000e+00, %if.end ], [ %sums.sroa.24.2, %if.end267.1 ]
  %sums.sroa.0.3 = phi float [ 0.000000e+00, %if.end ], [ %sums.sroa.0.2, %if.end267.1 ]
  %kr.sroa.57.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.57.0, %if.end267.1 ]
  %kr.sroa.47.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.47.0, %if.end267.1 ]
  %kr.sroa.42.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.42.0, %if.end267.1 ]
  %kr.sroa.32.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.32.0, %if.end267.1 ]
  %kr.sroa.27.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.27.0, %if.end267.1 ]
  %kr.sroa.17.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.17.0, %if.end267.1 ]
  %kr.sroa.12.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.12.0, %if.end267.1 ]
  %kr.sroa.0.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.0.0, %if.end267.1 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %cmp108, label %if.end283.1, label %for.cond111.preheader.1

for.cond111.preheader.1:                          ; preds = %if.end441
  %or.cond780.1817 = icmp ugt i32 %mul11.2, 1023
  %cmp124.not.1818 = icmp sgt i32 %mul11.2, %1
  %or.cond781.1819 = or i1 %or.cond780.1817, %cmp124.not.1818
  br i1 %or.cond781.1819, label %if.end152.1826, label %for.cond126.preheader.1822

for.cond126.preheader.1822:                       ; preds = %for.cond111.preheader.1
  %82 = shl nsw i32 %cond.i.i743.2, 10
  %mul133.1820 = and i32 %82, 64512
  %add134.1821 = or disjoint i32 %mul133.1820, %mul131
  %83 = zext nneg i32 %add134.1821 to i64
  %84 = or disjoint i64 %83, %26
  %add.ptr142.1823 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %84
  %kr.sroa.0.0.copyload1707 = load <4 x half>, ptr addrspace(4) %add.ptr142.1823, align 16
  %kr.sroa.12.0.add.ptr142.1823.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1823, i64 8
  %kr.sroa.12.0.copyload1711 = load <4 x half>, ptr addrspace(4) %kr.sroa.12.0.add.ptr142.1823.sroa_idx, align 8
  %85 = or disjoint i64 %83, %26
  %86 = or disjoint i64 %85, 512
  %add.ptr142.1.1824 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %86
  %kr.sroa.17.16.copyload1723 = load <4 x half>, ptr addrspace(4) %add.ptr142.1.1824, align 16
  %kr.sroa.27.16.add.ptr142.1.1824.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1.1824, i64 8
  %kr.sroa.27.16.copyload1727 = load <4 x half>, ptr addrspace(4) %kr.sroa.27.16.add.ptr142.1.1824.sroa_idx, align 8
  br label %if.end152.1826

if.end152.1826:                                   ; preds = %for.cond126.preheader.1822, %for.cond111.preheader.1
  %kr.sroa.27.2 = phi <4 x half> [ %kr.sroa.27.1, %for.cond111.preheader.1 ], [ %kr.sroa.27.16.copyload1727, %for.cond126.preheader.1822 ]
  %kr.sroa.17.2 = phi <4 x half> [ %kr.sroa.17.1, %for.cond111.preheader.1 ], [ %kr.sroa.17.16.copyload1723, %for.cond126.preheader.1822 ]
  %kr.sroa.12.2 = phi <4 x half> [ %kr.sroa.12.1, %for.cond111.preheader.1 ], [ %kr.sroa.12.0.copyload1711, %for.cond126.preheader.1822 ]
  %kr.sroa.0.2 = phi <4 x half> [ %kr.sroa.0.1, %for.cond111.preheader.1 ], [ %kr.sroa.0.0.copyload1707, %for.cond126.preheader.1822 ]
  %or.cond780.1.1 = icmp ugt i32 %mul11.3, 1023
  %cmp124.not.1.1 = icmp sgt i32 %mul11.3, %1
  %or.cond781.1.1 = or i1 %or.cond780.1.1, %cmp124.not.1.1
  br i1 %or.cond781.1.1, label %if.end152.1.1, label %for.cond126.preheader.1.1

for.cond126.preheader.1.1:                        ; preds = %if.end152.1826
  %87 = shl nsw i32 %cond.i.i743.3, 10
  %mul133.1.1 = and i32 %87, 64512
  %add134.1.1 = or disjoint i32 %mul133.1.1, %mul131
  %88 = zext nneg i32 %add134.1.1 to i64
  %89 = or disjoint i64 %88, %26
  %add.ptr142.1801.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %89
  %kr.sroa.32.32.copyload1739 = load <4 x half>, ptr addrspace(4) %add.ptr142.1801.1, align 16
  %kr.sroa.42.32.add.ptr142.1801.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1801.1, i64 8
  %kr.sroa.42.32.copyload1743 = load <4 x half>, ptr addrspace(4) %kr.sroa.42.32.add.ptr142.1801.1.sroa_idx, align 8
  %90 = or disjoint i64 %88, %26
  %91 = or disjoint i64 %90, 512
  %add.ptr142.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %91
  %kr.sroa.47.48.copyload1755 = load <4 x half>, ptr addrspace(4) %add.ptr142.1.1.1, align 16
  %kr.sroa.57.48.add.ptr142.1.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1.1.1, i64 8
  %kr.sroa.57.48.copyload1759 = load <4 x half>, ptr addrspace(4) %kr.sroa.57.48.add.ptr142.1.1.1.sroa_idx, align 8
  br label %if.end152.1.1

if.end152.1.1:                                    ; preds = %for.cond126.preheader.1.1, %if.end152.1826
  %kr.sroa.57.2 = phi <4 x half> [ %kr.sroa.57.1, %if.end152.1826 ], [ %kr.sroa.57.48.copyload1759, %for.cond126.preheader.1.1 ]
  %kr.sroa.47.2 = phi <4 x half> [ %kr.sroa.47.1, %if.end152.1826 ], [ %kr.sroa.47.48.copyload1755, %for.cond126.preheader.1.1 ]
  %kr.sroa.42.2 = phi <4 x half> [ %kr.sroa.42.1, %if.end152.1826 ], [ %kr.sroa.42.32.copyload1743, %for.cond126.preheader.1.1 ]
  %kr.sroa.32.2 = phi <4 x half> [ %kr.sroa.32.1, %if.end152.1826 ], [ %kr.sroa.32.32.copyload1739, %for.cond126.preheader.1.1 ]
  br i1 %or.cond781.1819, label %if.end267.1882, label %if.then170.1832

if.then170.1832:                                  ; preds = %if.end152.1.1
  %cmp173.1831 = icmp sgt i32 %mul11.2, %invariant.op
  br i1 %cmp173.1831, label %for.cond175.preheader.1835, label %if.end201.1852

for.cond175.preheader.1835:                       ; preds = %if.then170.1832
  %add183.1834 = or disjoint i32 %mul11.2, %mul182
  %cmp186.not.1836 = icmp sgt i32 %add183.1834, %1
  %spec.select.1837 = select i1 %cmp186.not.1836, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1165 = insertelement <4 x float> poison, float %spec.select.1837, i64 0
  %cmp186.not.1.1839.not = icmp slt i32 %add183.1834, %1
  %spec.select.1.1840 = select i1 %cmp186.not.1.1839.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1276 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1165, float %spec.select.1.1840, i64 1
  %add184.2.1842 = or disjoint i32 %add183.1834, 2
  %cmp186.not.2.1843 = icmp sgt i32 %add184.2.1842, %1
  %spec.select.2.1844 = select i1 %cmp186.not.2.1843, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1373 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1276, float %spec.select.2.1844, i64 2
  %add184.3.1846 = or disjoint i32 %add183.1834, 3
  %cmp186.not.3.1847 = icmp sgt i32 %add184.3.1846, %1
  %spec.select.3.1848 = select i1 %cmp186.not.3.1847, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1470 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1373, float %spec.select.3.1848, i64 3
  br label %if.end201.1852

if.end201.1852:                                   ; preds = %if.then170.1832, %for.cond175.preheader.1835
  %scores.sroa.0.5 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1470, %for.cond175.preheader.1835 ], [ zeroinitializer, %if.then170.1832 ]
  %92 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.2, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.5)
  %93 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.12.2, <4 x half> %qr.sroa.13.0, <4 x float> %92)
  %94 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.17.2, <4 x half> %qr.sroa.23.0, <4 x float> %93)
  %95 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.27.2, <4 x half> %qr.sroa.34.0, <4 x float> %94)
  %scores.sroa.0.0.vec.extract1167 = extractelement <4 x float> %95, i64 0
  %mul227.1857 = fmul contract float %scores.sroa.0.0.vec.extract1167, 0x3FB99999A0000000
  %96 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1857, float 0x4024CB5EC0000000)
  %97 = tail call contract noundef float @llvm.exp.f32(float %96)
  %scores.sroa.0.4.vec.extract1278 = extractelement <4 x float> %95, i64 1
  %mul227.1.1859 = fmul contract float %scores.sroa.0.4.vec.extract1278, 0x3FB99999A0000000
  %98 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1.1859, float 0x4024CB5EC0000000)
  %99 = tail call contract noundef float @llvm.exp.f32(float %98)
  %scores.sroa.0.8.vec.extract1375 = extractelement <4 x float> %95, i64 2
  %mul227.2.1861 = fmul contract float %scores.sroa.0.8.vec.extract1375, 0x3FB99999A0000000
  %100 = tail call contract noundef float @llvm.minnum.f32(float %mul227.2.1861, float 0x4024CB5EC0000000)
  %101 = tail call contract noundef float @llvm.exp.f32(float %100)
  %scores.sroa.0.12.vec.extract1472 = extractelement <4 x float> %95, i64 3
  %mul227.3.1863 = fmul contract float %scores.sroa.0.12.vec.extract1472, 0x3FB99999A0000000
  %102 = tail call contract noundef float @llvm.minnum.f32(float %mul227.3.1863, float 0x4024CB5EC0000000)
  %103 = tail call contract noundef float @llvm.exp.f32(float %102)
  %add243.1865 = fadd contract float %sums.sroa.0.3, %97
  %104 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %97)
  %probs.sroa.0.0.vec.insert1595 = insertelement <4 x i16> poison, i16 %104, i64 0
  %add243.1.1868 = fadd contract float %sums.sroa.24.3, %99
  %105 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %99)
  %probs.sroa.0.2.vec.insert1633 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1595, i16 %105, i64 1
  %add243.2.1872 = fadd contract float %sums.sroa.46.3, %101
  %106 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %101)
  %probs.sroa.0.4.vec.insert1670 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1633, i16 %106, i64 2
  %add243.3.1876 = fadd contract float %sums.sroa.68.3, %103
  %107 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %103)
  %probs.sroa.0.6.vec.insert1688 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1670, i16 %107, i64 3
  br label %if.end267.1882

if.end267.1882:                                   ; preds = %if.end152.1.1, %if.end201.1852
  %sums.sroa.68.4 = phi float [ %add243.3.1876, %if.end201.1852 ], [ %sums.sroa.68.3, %if.end152.1.1 ]
  %sums.sroa.46.4 = phi float [ %add243.2.1872, %if.end201.1852 ], [ %sums.sroa.46.3, %if.end152.1.1 ]
  %sums.sroa.24.4 = phi float [ %add243.1.1868, %if.end201.1852 ], [ %sums.sroa.24.3, %if.end152.1.1 ]
  %sums.sroa.0.4 = phi float [ %add243.1865, %if.end201.1852 ], [ %sums.sroa.0.3, %if.end152.1.1 ]
  %probs.sroa.0.6 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1688, %if.end201.1852 ], [ zeroinitializer, %if.end152.1.1 ]
  %add277.1880 = or disjoint i32 %and275, 512
  %add.ptr279.1881 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add277.1880
  store <4 x i16> %probs.sroa.0.6, ptr addrspace(3) %add.ptr279.1881, align 8
  br i1 %or.cond781.1.1, label %if.end267.1.1, label %if.then170.1.1

if.then170.1.1:                                   ; preds = %if.end267.1882
  %cmp173.1.1 = icmp sgt i32 %mul11.3, %invariant.op
  br i1 %cmp173.1.1, label %for.cond175.preheader.1.1, label %if.end201.1.1

for.cond175.preheader.1.1:                        ; preds = %if.then170.1.1
  %add183.1.1 = or disjoint i32 %mul11.3, %mul182
  %cmp186.not.1804.1 = icmp sgt i32 %add183.1.1, %1
  %spec.select.1805.1 = select i1 %cmp186.not.1804.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1175 = insertelement <4 x float> poison, float %spec.select.1805.1, i64 0
  %cmp186.not.1.1.1.not = icmp slt i32 %add183.1.1, %1
  %spec.select.1.1.1 = select i1 %cmp186.not.1.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1284 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1175, float %spec.select.1.1.1, i64 1
  %add184.2.1.1 = or disjoint i32 %add183.1.1, 2
  %cmp186.not.2.1.1 = icmp sgt i32 %add184.2.1.1, %1
  %spec.select.2.1.1 = select i1 %cmp186.not.2.1.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1381 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1284, float %spec.select.2.1.1, i64 2
  %add184.3.1.1 = or disjoint i32 %add183.1.1, 3
  %cmp186.not.3.1.1 = icmp sgt i32 %add184.3.1.1, %1
  %spec.select.3.1.1 = select i1 %cmp186.not.3.1.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1478 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1381, float %spec.select.3.1.1, i64 3
  br label %if.end201.1.1

if.end201.1.1:                                    ; preds = %if.then170.1.1, %for.cond175.preheader.1.1
  %scores.sroa.0.7 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1478, %for.cond175.preheader.1.1 ], [ zeroinitializer, %if.then170.1.1 ]
  %108 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.32.2, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.7)
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.42.2, <4 x half> %qr.sroa.13.0, <4 x float> %108)
  %110 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.2, <4 x half> %qr.sroa.23.0, <4 x float> %109)
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.57.2, <4 x half> %qr.sroa.34.0, <4 x float> %110)
  %scores.sroa.0.0.vec.extract1177 = extractelement <4 x float> %111, i64 0
  %mul227.1808.1 = fmul contract float %scores.sroa.0.0.vec.extract1177, 0x3FB99999A0000000
  %112 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1808.1, float 0x4024CB5EC0000000)
  %113 = tail call contract noundef float @llvm.exp.f32(float %112)
  %scores.sroa.0.4.vec.extract1286 = extractelement <4 x float> %111, i64 1
  %mul227.1.1.1 = fmul contract float %scores.sroa.0.4.vec.extract1286, 0x3FB99999A0000000
  %114 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1.1.1, float 0x4024CB5EC0000000)
  %115 = tail call contract noundef float @llvm.exp.f32(float %114)
  %scores.sroa.0.8.vec.extract1383 = extractelement <4 x float> %111, i64 2
  %mul227.2.1.1 = fmul contract float %scores.sroa.0.8.vec.extract1383, 0x3FB99999A0000000
  %116 = tail call contract noundef float @llvm.minnum.f32(float %mul227.2.1.1, float 0x4024CB5EC0000000)
  %117 = tail call contract noundef float @llvm.exp.f32(float %116)
  %scores.sroa.0.12.vec.extract1480 = extractelement <4 x float> %111, i64 3
  %mul227.3.1.1 = fmul contract float %scores.sroa.0.12.vec.extract1480, 0x3FB99999A0000000
  %118 = tail call contract noundef float @llvm.minnum.f32(float %mul227.3.1.1, float 0x4024CB5EC0000000)
  %119 = tail call contract noundef float @llvm.exp.f32(float %118)
  %add243.1809.1 = fadd contract float %sums.sroa.0.4, %113
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %113)
  %probs.sroa.0.0.vec.insert1597 = insertelement <4 x i16> poison, i16 %120, i64 0
  %add243.1.1.1 = fadd contract float %sums.sroa.24.4, %115
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %115)
  %probs.sroa.0.2.vec.insert1635 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1597, i16 %121, i64 1
  %add243.2.1.1 = fadd contract float %sums.sroa.46.4, %117
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %117)
  %probs.sroa.0.4.vec.insert1672 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1635, i16 %122, i64 2
  %add243.3.1.1 = fadd contract float %sums.sroa.68.4, %119
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %119)
  %probs.sroa.0.6.vec.insert1690 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1672, i16 %123, i64 3
  br label %if.end267.1.1

if.end267.1.1:                                    ; preds = %if.end267.1882, %if.end201.1.1
  %sums.sroa.68.5 = phi float [ %add243.3.1.1, %if.end201.1.1 ], [ %sums.sroa.68.4, %if.end267.1882 ]
  %sums.sroa.46.5 = phi float [ %add243.2.1.1, %if.end201.1.1 ], [ %sums.sroa.46.4, %if.end267.1882 ]
  %sums.sroa.24.5 = phi float [ %add243.1.1.1, %if.end201.1.1 ], [ %sums.sroa.24.4, %if.end267.1882 ]
  %sums.sroa.0.5 = phi float [ %add243.1809.1, %if.end201.1.1 ], [ %sums.sroa.0.4, %if.end267.1882 ]
  %probs.sroa.0.7 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1690, %if.end201.1.1 ], [ zeroinitializer, %if.end267.1882 ]
  %add277.1.1 = or disjoint i32 %and275, 768
  %add.ptr279.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add277.1.1
  store <4 x i16> %probs.sroa.0.7, ptr addrspace(3) %add.ptr279.1.1, align 8
  br label %if.end283.1

if.end283.1:                                      ; preds = %if.end267.1.1, %if.end441
  %sums.sroa.68.6 = phi float [ %sums.sroa.68.3, %if.end441 ], [ %sums.sroa.68.5, %if.end267.1.1 ]
  %sums.sroa.46.6 = phi float [ %sums.sroa.46.3, %if.end441 ], [ %sums.sroa.46.5, %if.end267.1.1 ]
  %sums.sroa.24.6 = phi float [ %sums.sroa.24.3, %if.end441 ], [ %sums.sroa.24.5, %if.end267.1.1 ]
  %sums.sroa.0.6 = phi float [ %sums.sroa.0.3, %if.end441 ], [ %sums.sroa.0.5, %if.end267.1.1 ]
  %kr.sroa.57.3 = phi <4 x half> [ %kr.sroa.57.1, %if.end441 ], [ %kr.sroa.57.2, %if.end267.1.1 ]
  %kr.sroa.47.3 = phi <4 x half> [ %kr.sroa.47.1, %if.end441 ], [ %kr.sroa.47.2, %if.end267.1.1 ]
  %kr.sroa.42.3 = phi <4 x half> [ %kr.sroa.42.1, %if.end441 ], [ %kr.sroa.42.2, %if.end267.1.1 ]
  %kr.sroa.32.3 = phi <4 x half> [ %kr.sroa.32.1, %if.end441 ], [ %kr.sroa.32.2, %if.end267.1.1 ]
  %kr.sroa.27.3 = phi <4 x half> [ %kr.sroa.27.1, %if.end441 ], [ %kr.sroa.27.2, %if.end267.1.1 ]
  %kr.sroa.17.3 = phi <4 x half> [ %kr.sroa.17.1, %if.end441 ], [ %kr.sroa.17.2, %if.end267.1.1 ]
  %kr.sroa.12.3 = phi <4 x half> [ %kr.sroa.12.1, %if.end441 ], [ %kr.sroa.12.2, %if.end267.1.1 ]
  %kr.sroa.0.3 = phi <4 x half> [ %kr.sroa.0.1, %if.end441 ], [ %kr.sroa.0.2, %if.end267.1.1 ]
  br i1 %cmp286.not, label %for.cond290.preheader.1, label %if.end441.1

for.cond290.preheader.1:                          ; preds = %if.end283.1
  %or.cond784.1885 = icmp ugt i32 %mul11, 1023
  %cmp303.not.1886 = icmp sgt i32 %mul11, %1
  %or.cond785.1887 = or i1 %or.cond784.1885, %cmp303.not.1886
  br i1 %or.cond785.1887, label %if.end437.1930, label %for.cond347.preheader.1922

for.cond347.preheader.1922:                       ; preds = %for.cond290.preheader.1
  %add.ptr339.1895 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul336
  %124 = load <4 x half>, ptr addrspace(3) %add.ptr339.1895, align 8
  %125 = shl nsw i32 %cond.i.i743, 10
  %mul312.1888 = and i32 %125, 64512
  %add313.1889 = or disjoint i32 %mul312.1888, %mul131
  %126 = zext nneg i32 %add313.1889 to i64
  %127 = or disjoint i64 %126, %27
  %128 = or disjoint i64 %127, 512
  %add.ptr321.1.1892 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %128
  %vr.sroa.142.16.add.ptr321.1.1892.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.1.1892, i64 8
  %vr.sroa.142.16.copyload1088 = load <4 x half>, ptr addrspace(4) %vr.sroa.142.16.add.ptr321.1.1892.sroa_idx, align 8
  %vr.sroa.92.16.copyload1079 = load <4 x half>, ptr addrspace(4) %add.ptr321.1.1892, align 16
  %129 = or disjoint i64 %126, %27
  %add.ptr321.1891 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %129
  %vr.sroa.52.0.add.ptr321.1891.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.1891, i64 8
  %vr.sroa.52.0.copyload992 = load <4 x half>, ptr addrspace(4) %vr.sroa.52.0.add.ptr321.1891.sroa_idx, align 8
  %vr.sroa.0.0.copyload983 = load <4 x half>, ptr addrspace(4) %add.ptr321.1891, align 16
  %130 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload983, <4 x half> %124, <4 x float> zeroinitializer), !call_argsrelate !163
  %131 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.52.0.copyload992, <4 x half> %124, <4 x float> zeroinitializer), !call_argsrelate !163
  %132 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.92.16.copyload1079, <4 x half> %124, <4 x float> zeroinitializer), !call_argsrelate !163
  %133 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.142.16.copyload1088, <4 x half> %124, <4 x float> zeroinitializer), !call_argsrelate !163
  br label %if.end437.1930

if.end437.1930:                                   ; preds = %for.cond347.preheader.1922, %for.cond290.preheader.1
  %out.sroa.122.4 = phi <4 x float> [ zeroinitializer, %for.cond290.preheader.1 ], [ %133, %for.cond347.preheader.1922 ]
  %out.sroa.82.4 = phi <4 x float> [ zeroinitializer, %for.cond290.preheader.1 ], [ %132, %for.cond347.preheader.1922 ]
  %out.sroa.42.4 = phi <4 x float> [ zeroinitializer, %for.cond290.preheader.1 ], [ %131, %for.cond347.preheader.1922 ]
  %out.sroa.0.4 = phi <4 x float> [ zeroinitializer, %for.cond290.preheader.1 ], [ %130, %for.cond347.preheader.1922 ]
  %or.cond784.1.1 = icmp ugt i32 %mul11.1, 1023
  %cmp303.not.1.1 = icmp sgt i32 %mul11.1, %1
  %or.cond785.1.1 = or i1 %or.cond784.1.1, %cmp303.not.1.1
  br i1 %or.cond785.1.1, label %if.end441.1, label %for.cond372.preheader.1.1

for.cond372.preheader.1.1:                        ; preds = %if.end437.1930
  %add.ptr339.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and275
  %134 = load <4 x half>, ptr addrspace(3) %add.ptr339.1.1, align 8
  %135 = shl nsw i32 %cond.i.i743.1, 10
  %mul312.1.1 = and i32 %135, 64512
  %add313.1.1 = or disjoint i32 %mul312.1.1, %mul131
  %136 = zext nneg i32 %add313.1.1 to i64
  %137 = or disjoint i64 %136, %27
  %138 = or disjoint i64 %137, 512
  %add.ptr321.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %138
  %vr.sroa.142.16.add.ptr321.1.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.1.1.1, i64 8
  %vr.sroa.142.16.copyload1089 = load <4 x half>, ptr addrspace(4) %vr.sroa.142.16.add.ptr321.1.1.1.sroa_idx, align 8
  %vr.sroa.92.16.copyload1080 = load <4 x half>, ptr addrspace(4) %add.ptr321.1.1.1, align 16
  %139 = or disjoint i64 %136, %27
  %add.ptr321.1815.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %139
  %vr.sroa.52.0.add.ptr321.1815.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.1815.1, i64 8
  %vr.sroa.52.0.copyload993 = load <4 x half>, ptr addrspace(4) %vr.sroa.52.0.add.ptr321.1815.1.sroa_idx, align 8
  %vr.sroa.0.0.copyload984 = load <4 x half>, ptr addrspace(4) %add.ptr321.1815.1, align 16
  %140 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload984, <4 x half> %134, <4 x float> zeroinitializer), !call_argsrelate !163
  %141 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.52.0.copyload993, <4 x half> %134, <4 x float> zeroinitializer), !call_argsrelate !163
  %142 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.92.16.copyload1080, <4 x half> %134, <4 x float> zeroinitializer), !call_argsrelate !163
  %143 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.142.16.copyload1089, <4 x half> %134, <4 x float> zeroinitializer), !call_argsrelate !163
  br label %if.end441.1

if.end441.1:                                      ; preds = %if.end437.1930, %for.cond372.preheader.1.1, %if.end283.1
  %out.sroa.122.6 = phi <4 x float> [ zeroinitializer, %if.end283.1 ], [ %out.sroa.122.4, %for.cond372.preheader.1.1 ], [ %out.sroa.122.4, %if.end437.1930 ]
  %out.sroa.82.6 = phi <4 x float> [ zeroinitializer, %if.end283.1 ], [ %out.sroa.82.4, %for.cond372.preheader.1.1 ], [ %out.sroa.82.4, %if.end437.1930 ]
  %out.sroa.42.6 = phi <4 x float> [ zeroinitializer, %if.end283.1 ], [ %out.sroa.42.4, %for.cond372.preheader.1.1 ], [ %out.sroa.42.4, %if.end437.1930 ]
  %out.sroa.0.6 = phi <4 x float> [ zeroinitializer, %if.end283.1 ], [ %out.sroa.0.4, %for.cond372.preheader.1.1 ], [ %out.sroa.0.4, %if.end437.1930 ]
  %out_1.sroa.86.6 = phi <4 x float> [ zeroinitializer, %if.end283.1 ], [ %143, %for.cond372.preheader.1.1 ], [ zeroinitializer, %if.end437.1930 ]
  %out_1.sroa.58.6 = phi <4 x float> [ zeroinitializer, %if.end283.1 ], [ %142, %for.cond372.preheader.1.1 ], [ zeroinitializer, %if.end437.1930 ]
  %out_1.sroa.30.6 = phi <4 x float> [ zeroinitializer, %if.end283.1 ], [ %141, %for.cond372.preheader.1.1 ], [ zeroinitializer, %if.end437.1930 ]
  %out_1.sroa.0.6 = phi <4 x float> [ zeroinitializer, %if.end283.1 ], [ %140, %for.cond372.preheader.1.1 ], [ zeroinitializer, %if.end437.1930 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %cmp108, label %if.end283.2, label %for.cond111.preheader.2

for.cond111.preheader.2:                          ; preds = %if.end441.1
  %or.cond780.2 = icmp ugt i32 %mul11.4, 1023
  %cmp124.not.2 = icmp sgt i32 %mul11.4, %1
  %or.cond781.2 = or i1 %or.cond780.2, %cmp124.not.2
  br i1 %or.cond781.2, label %if.end152.2, label %for.cond126.preheader.2

for.cond126.preheader.2:                          ; preds = %for.cond111.preheader.2
  %144 = shl nsw i32 %cond.i.i743.4, 10
  %mul133.2 = and i32 %144, 64512
  %add134.2 = or disjoint i32 %mul133.2, %mul131
  %145 = zext nneg i32 %add134.2 to i64
  %146 = or disjoint i64 %145, %26
  %add.ptr142.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %146
  %kr.sroa.0.0.copyload1708 = load <4 x half>, ptr addrspace(4) %add.ptr142.2, align 16
  %kr.sroa.12.0.add.ptr142.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.2, i64 8
  %kr.sroa.12.0.copyload1712 = load <4 x half>, ptr addrspace(4) %kr.sroa.12.0.add.ptr142.2.sroa_idx, align 8
  %147 = or disjoint i64 %145, %26
  %148 = or disjoint i64 %147, 512
  %add.ptr142.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %148
  %kr.sroa.17.16.copyload1724 = load <4 x half>, ptr addrspace(4) %add.ptr142.1.2, align 16
  %kr.sroa.27.16.add.ptr142.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1.2, i64 8
  %kr.sroa.27.16.copyload1728 = load <4 x half>, ptr addrspace(4) %kr.sroa.27.16.add.ptr142.1.2.sroa_idx, align 8
  br label %if.end152.2

if.end152.2:                                      ; preds = %for.cond126.preheader.2, %for.cond111.preheader.2
  %kr.sroa.27.4 = phi <4 x half> [ %kr.sroa.27.3, %for.cond111.preheader.2 ], [ %kr.sroa.27.16.copyload1728, %for.cond126.preheader.2 ]
  %kr.sroa.17.4 = phi <4 x half> [ %kr.sroa.17.3, %for.cond111.preheader.2 ], [ %kr.sroa.17.16.copyload1724, %for.cond126.preheader.2 ]
  %kr.sroa.12.4 = phi <4 x half> [ %kr.sroa.12.3, %for.cond111.preheader.2 ], [ %kr.sroa.12.0.copyload1712, %for.cond126.preheader.2 ]
  %kr.sroa.0.4 = phi <4 x half> [ %kr.sroa.0.3, %for.cond111.preheader.2 ], [ %kr.sroa.0.0.copyload1708, %for.cond126.preheader.2 ]
  %or.cond780.1.2 = icmp ugt i32 %mul11.5, 1023
  %cmp124.not.1.2 = icmp sgt i32 %mul11.5, %1
  %or.cond781.1.2 = or i1 %or.cond780.1.2, %cmp124.not.1.2
  br i1 %or.cond781.1.2, label %if.end152.1.2, label %for.cond126.preheader.1.2

for.cond126.preheader.1.2:                        ; preds = %if.end152.2
  %149 = shl nsw i32 %cond.i.i743.5, 10
  %mul133.1.2 = and i32 %149, 64512
  %add134.1.2 = or disjoint i32 %mul133.1.2, %mul131
  %150 = zext nneg i32 %add134.1.2 to i64
  %151 = or disjoint i64 %150, %26
  %add.ptr142.1801.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %151
  %kr.sroa.32.32.copyload1740 = load <4 x half>, ptr addrspace(4) %add.ptr142.1801.2, align 16
  %kr.sroa.42.32.add.ptr142.1801.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1801.2, i64 8
  %kr.sroa.42.32.copyload1744 = load <4 x half>, ptr addrspace(4) %kr.sroa.42.32.add.ptr142.1801.2.sroa_idx, align 8
  %152 = or disjoint i64 %150, %26
  %153 = or disjoint i64 %152, 512
  %add.ptr142.1.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %153
  %kr.sroa.47.48.copyload1756 = load <4 x half>, ptr addrspace(4) %add.ptr142.1.1.2, align 16
  %kr.sroa.57.48.add.ptr142.1.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1.1.2, i64 8
  %kr.sroa.57.48.copyload1760 = load <4 x half>, ptr addrspace(4) %kr.sroa.57.48.add.ptr142.1.1.2.sroa_idx, align 8
  br label %if.end152.1.2

if.end152.1.2:                                    ; preds = %for.cond126.preheader.1.2, %if.end152.2
  %kr.sroa.57.4 = phi <4 x half> [ %kr.sroa.57.3, %if.end152.2 ], [ %kr.sroa.57.48.copyload1760, %for.cond126.preheader.1.2 ]
  %kr.sroa.47.4 = phi <4 x half> [ %kr.sroa.47.3, %if.end152.2 ], [ %kr.sroa.47.48.copyload1756, %for.cond126.preheader.1.2 ]
  %kr.sroa.42.4 = phi <4 x half> [ %kr.sroa.42.3, %if.end152.2 ], [ %kr.sroa.42.32.copyload1744, %for.cond126.preheader.1.2 ]
  %kr.sroa.32.4 = phi <4 x half> [ %kr.sroa.32.3, %if.end152.2 ], [ %kr.sroa.32.32.copyload1740, %for.cond126.preheader.1.2 ]
  br i1 %or.cond781.2, label %if.end267.2, label %if.then170.2

if.then170.2:                                     ; preds = %if.end152.1.2
  %cmp173.2 = icmp sgt i32 %mul11.4, %invariant.op
  br i1 %cmp173.2, label %for.cond175.preheader.2, label %if.end201.2

for.cond175.preheader.2:                          ; preds = %if.then170.2
  %add183.2 = or disjoint i32 %mul11.4, %mul182
  %cmp186.not.2931 = icmp sgt i32 %add183.2, %1
  %spec.select.2932 = select i1 %cmp186.not.2931, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1185 = insertelement <4 x float> poison, float %spec.select.2932, i64 0
  %cmp186.not.1.2.not = icmp slt i32 %add183.2, %1
  %spec.select.1.2 = select i1 %cmp186.not.1.2.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1292 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1185, float %spec.select.1.2, i64 1
  %add184.2.2 = or disjoint i32 %add183.2, 2
  %cmp186.not.2.2 = icmp sgt i32 %add184.2.2, %1
  %spec.select.2.2 = select i1 %cmp186.not.2.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1389 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1292, float %spec.select.2.2, i64 2
  %add184.3.2 = or disjoint i32 %add183.2, 3
  %cmp186.not.3.2 = icmp sgt i32 %add184.3.2, %1
  %spec.select.3.2 = select i1 %cmp186.not.3.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1486 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1389, float %spec.select.3.2, i64 3
  br label %if.end201.2

if.end201.2:                                      ; preds = %if.then170.2, %for.cond175.preheader.2
  %scores.sroa.0.10 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1486, %for.cond175.preheader.2 ], [ zeroinitializer, %if.then170.2 ]
  %154 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.4, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.10)
  %155 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.12.4, <4 x half> %qr.sroa.13.0, <4 x float> %154)
  %156 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.17.4, <4 x half> %qr.sroa.23.0, <4 x float> %155)
  %157 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.27.4, <4 x half> %qr.sroa.34.0, <4 x float> %156)
  %scores.sroa.0.0.vec.extract1187 = extractelement <4 x float> %157, i64 0
  %mul227.2933 = fmul contract float %scores.sroa.0.0.vec.extract1187, 0x3FB99999A0000000
  %158 = tail call contract noundef float @llvm.minnum.f32(float %mul227.2933, float 0x4024CB5EC0000000)
  %159 = tail call contract noundef float @llvm.exp.f32(float %158)
  %scores.sroa.0.4.vec.extract1294 = extractelement <4 x float> %157, i64 1
  %mul227.1.2 = fmul contract float %scores.sroa.0.4.vec.extract1294, 0x3FB99999A0000000
  %160 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1.2, float 0x4024CB5EC0000000)
  %161 = tail call contract noundef float @llvm.exp.f32(float %160)
  %scores.sroa.0.8.vec.extract1391 = extractelement <4 x float> %157, i64 2
  %mul227.2.2 = fmul contract float %scores.sroa.0.8.vec.extract1391, 0x3FB99999A0000000
  %162 = tail call contract noundef float @llvm.minnum.f32(float %mul227.2.2, float 0x4024CB5EC0000000)
  %163 = tail call contract noundef float @llvm.exp.f32(float %162)
  %scores.sroa.0.12.vec.extract1488 = extractelement <4 x float> %157, i64 3
  %mul227.3.2 = fmul contract float %scores.sroa.0.12.vec.extract1488, 0x3FB99999A0000000
  %164 = tail call contract noundef float @llvm.minnum.f32(float %mul227.3.2, float 0x4024CB5EC0000000)
  %165 = tail call contract noundef float @llvm.exp.f32(float %164)
  %add243.2934 = fadd contract float %sums.sroa.0.6, %159
  %166 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %159)
  %probs.sroa.0.0.vec.insert1599 = insertelement <4 x i16> poison, i16 %166, i64 0
  %add243.1.2 = fadd contract float %sums.sroa.24.6, %161
  %167 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %161)
  %probs.sroa.0.2.vec.insert1637 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1599, i16 %167, i64 1
  %add243.2.2 = fadd contract float %sums.sroa.46.6, %163
  %168 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %163)
  %probs.sroa.0.4.vec.insert1674 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1637, i16 %168, i64 2
  %add243.3.2 = fadd contract float %sums.sroa.68.6, %165
  %169 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %165)
  %probs.sroa.0.6.vec.insert1692 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1674, i16 %169, i64 3
  br label %if.end267.2

if.end267.2:                                      ; preds = %if.end152.1.2, %if.end201.2
  %sums.sroa.68.7 = phi float [ %add243.3.2, %if.end201.2 ], [ %sums.sroa.68.6, %if.end152.1.2 ]
  %sums.sroa.46.7 = phi float [ %add243.2.2, %if.end201.2 ], [ %sums.sroa.46.6, %if.end152.1.2 ]
  %sums.sroa.24.7 = phi float [ %add243.1.2, %if.end201.2 ], [ %sums.sroa.24.6, %if.end152.1.2 ]
  %sums.sroa.0.7 = phi float [ %add243.2934, %if.end201.2 ], [ %sums.sroa.0.6, %if.end152.1.2 ]
  %probs.sroa.0.12 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1692, %if.end201.2 ], [ zeroinitializer, %if.end152.1.2 ]
  %add.ptr279.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and275
  store <4 x i16> %probs.sroa.0.12, ptr addrspace(3) %add.ptr279.2, align 8
  br i1 %or.cond781.1.2, label %if.end267.1.2, label %if.then170.1.2

if.then170.1.2:                                   ; preds = %if.end267.2
  %cmp173.1.2 = icmp sgt i32 %mul11.5, %invariant.op
  br i1 %cmp173.1.2, label %for.cond175.preheader.1.2, label %if.end201.1.2

for.cond175.preheader.1.2:                        ; preds = %if.then170.1.2
  %add183.1.2 = or disjoint i32 %mul11.5, %mul182
  %cmp186.not.1804.2 = icmp sgt i32 %add183.1.2, %1
  %spec.select.1805.2 = select i1 %cmp186.not.1804.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1195 = insertelement <4 x float> poison, float %spec.select.1805.2, i64 0
  %cmp186.not.1.1.2.not = icmp slt i32 %add183.1.2, %1
  %spec.select.1.1.2 = select i1 %cmp186.not.1.1.2.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1300 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1195, float %spec.select.1.1.2, i64 1
  %add184.2.1.2 = or disjoint i32 %add183.1.2, 2
  %cmp186.not.2.1.2 = icmp sgt i32 %add184.2.1.2, %1
  %spec.select.2.1.2 = select i1 %cmp186.not.2.1.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1397 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1300, float %spec.select.2.1.2, i64 2
  %add184.3.1.2 = or disjoint i32 %add183.1.2, 3
  %cmp186.not.3.1.2 = icmp sgt i32 %add184.3.1.2, %1
  %spec.select.3.1.2 = select i1 %cmp186.not.3.1.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1494 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1397, float %spec.select.3.1.2, i64 3
  br label %if.end201.1.2

if.end201.1.2:                                    ; preds = %if.then170.1.2, %for.cond175.preheader.1.2
  %scores.sroa.0.12 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1494, %for.cond175.preheader.1.2 ], [ zeroinitializer, %if.then170.1.2 ]
  %170 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.32.4, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.12)
  %171 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.42.4, <4 x half> %qr.sroa.13.0, <4 x float> %170)
  %172 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.4, <4 x half> %qr.sroa.23.0, <4 x float> %171)
  %173 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.57.4, <4 x half> %qr.sroa.34.0, <4 x float> %172)
  %scores.sroa.0.0.vec.extract1197 = extractelement <4 x float> %173, i64 0
  %mul227.1808.2 = fmul contract float %scores.sroa.0.0.vec.extract1197, 0x3FB99999A0000000
  %174 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1808.2, float 0x4024CB5EC0000000)
  %175 = tail call contract noundef float @llvm.exp.f32(float %174)
  %scores.sroa.0.4.vec.extract1302 = extractelement <4 x float> %173, i64 1
  %mul227.1.1.2 = fmul contract float %scores.sroa.0.4.vec.extract1302, 0x3FB99999A0000000
  %176 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1.1.2, float 0x4024CB5EC0000000)
  %177 = tail call contract noundef float @llvm.exp.f32(float %176)
  %scores.sroa.0.8.vec.extract1399 = extractelement <4 x float> %173, i64 2
  %mul227.2.1.2 = fmul contract float %scores.sroa.0.8.vec.extract1399, 0x3FB99999A0000000
  %178 = tail call contract noundef float @llvm.minnum.f32(float %mul227.2.1.2, float 0x4024CB5EC0000000)
  %179 = tail call contract noundef float @llvm.exp.f32(float %178)
  %scores.sroa.0.12.vec.extract1496 = extractelement <4 x float> %173, i64 3
  %mul227.3.1.2 = fmul contract float %scores.sroa.0.12.vec.extract1496, 0x3FB99999A0000000
  %180 = tail call contract noundef float @llvm.minnum.f32(float %mul227.3.1.2, float 0x4024CB5EC0000000)
  %181 = tail call contract noundef float @llvm.exp.f32(float %180)
  %add243.1809.2 = fadd contract float %sums.sroa.0.7, %175
  %182 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %175)
  %probs.sroa.0.0.vec.insert1601 = insertelement <4 x i16> poison, i16 %182, i64 0
  %add243.1.1.2 = fadd contract float %sums.sroa.24.7, %177
  %183 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %177)
  %probs.sroa.0.2.vec.insert1639 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1601, i16 %183, i64 1
  %add243.2.1.2 = fadd contract float %sums.sroa.46.7, %179
  %184 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %179)
  %probs.sroa.0.4.vec.insert1676 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1639, i16 %184, i64 2
  %add243.3.1.2 = fadd contract float %sums.sroa.68.7, %181
  %185 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %181)
  %probs.sroa.0.6.vec.insert1694 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1676, i16 %185, i64 3
  br label %if.end267.1.2

if.end267.1.2:                                    ; preds = %if.end267.2, %if.end201.1.2
  %sums.sroa.68.8 = phi float [ %add243.3.1.2, %if.end201.1.2 ], [ %sums.sroa.68.7, %if.end267.2 ]
  %sums.sroa.46.8 = phi float [ %add243.2.1.2, %if.end201.1.2 ], [ %sums.sroa.46.7, %if.end267.2 ]
  %sums.sroa.24.8 = phi float [ %add243.1.1.2, %if.end201.1.2 ], [ %sums.sroa.24.7, %if.end267.2 ]
  %sums.sroa.0.8 = phi float [ %add243.1809.2, %if.end201.1.2 ], [ %sums.sroa.0.7, %if.end267.2 ]
  %probs.sroa.0.13 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1694, %if.end201.1.2 ], [ zeroinitializer, %if.end267.2 ]
  %add277.1.2 = or disjoint i32 %and275, 256
  %add.ptr279.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add277.1.2
  store <4 x i16> %probs.sroa.0.13, ptr addrspace(3) %add.ptr279.1.2, align 8
  br label %if.end283.2

if.end283.2:                                      ; preds = %if.end267.1.2, %if.end441.1
  %sums.sroa.68.9 = phi float [ %sums.sroa.68.6, %if.end441.1 ], [ %sums.sroa.68.8, %if.end267.1.2 ]
  %sums.sroa.46.9 = phi float [ %sums.sroa.46.6, %if.end441.1 ], [ %sums.sroa.46.8, %if.end267.1.2 ]
  %sums.sroa.24.9 = phi float [ %sums.sroa.24.6, %if.end441.1 ], [ %sums.sroa.24.8, %if.end267.1.2 ]
  %sums.sroa.0.9 = phi float [ %sums.sroa.0.6, %if.end441.1 ], [ %sums.sroa.0.8, %if.end267.1.2 ]
  %kr.sroa.57.5 = phi <4 x half> [ %kr.sroa.57.3, %if.end441.1 ], [ %kr.sroa.57.4, %if.end267.1.2 ]
  %kr.sroa.47.5 = phi <4 x half> [ %kr.sroa.47.3, %if.end441.1 ], [ %kr.sroa.47.4, %if.end267.1.2 ]
  %kr.sroa.42.5 = phi <4 x half> [ %kr.sroa.42.3, %if.end441.1 ], [ %kr.sroa.42.4, %if.end267.1.2 ]
  %kr.sroa.32.5 = phi <4 x half> [ %kr.sroa.32.3, %if.end441.1 ], [ %kr.sroa.32.4, %if.end267.1.2 ]
  %kr.sroa.27.5 = phi <4 x half> [ %kr.sroa.27.3, %if.end441.1 ], [ %kr.sroa.27.4, %if.end267.1.2 ]
  %kr.sroa.17.5 = phi <4 x half> [ %kr.sroa.17.3, %if.end441.1 ], [ %kr.sroa.17.4, %if.end267.1.2 ]
  %kr.sroa.12.5 = phi <4 x half> [ %kr.sroa.12.3, %if.end441.1 ], [ %kr.sroa.12.4, %if.end267.1.2 ]
  %kr.sroa.0.5 = phi <4 x half> [ %kr.sroa.0.3, %if.end441.1 ], [ %kr.sroa.0.4, %if.end267.1.2 ]
  br i1 %cmp286.not, label %for.cond290.preheader.2, label %if.end441.2

for.cond290.preheader.2:                          ; preds = %if.end283.2
  %or.cond784.2 = icmp ugt i32 %mul11.2, 1023
  %cmp303.not.2 = icmp sgt i32 %mul11.2, %1
  %or.cond785.2 = or i1 %or.cond784.2, %cmp303.not.2
  br i1 %or.cond785.2, label %if.end437.2, label %for.cond397.preheader.2

for.cond397.preheader.2:                          ; preds = %for.cond290.preheader.2
  %add337.2 = or disjoint i32 %mul336, 512
  %add.ptr339.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add337.2
  %186 = load <4 x half>, ptr addrspace(3) %add.ptr339.2, align 8
  %187 = shl nsw i32 %cond.i.i743.2, 10
  %mul312.2 = and i32 %187, 64512
  %add313.2 = or disjoint i32 %mul312.2, %mul131
  %188 = zext nneg i32 %add313.2 to i64
  %189 = or disjoint i64 %188, %27
  %190 = or disjoint i64 %189, 512
  %add.ptr321.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %190
  %vr.sroa.142.16.add.ptr321.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.1.2, i64 8
  %vr.sroa.142.16.copyload1090 = load <4 x half>, ptr addrspace(4) %vr.sroa.142.16.add.ptr321.1.2.sroa_idx, align 8
  %vr.sroa.92.16.copyload1081 = load <4 x half>, ptr addrspace(4) %add.ptr321.1.2, align 16
  %191 = or disjoint i64 %188, %27
  %add.ptr321.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %191
  %vr.sroa.52.0.add.ptr321.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.2, i64 8
  %vr.sroa.52.0.copyload994 = load <4 x half>, ptr addrspace(4) %vr.sroa.52.0.add.ptr321.2.sroa_idx, align 8
  %vr.sroa.0.0.copyload985 = load <4 x half>, ptr addrspace(4) %add.ptr321.2, align 16
  %192 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload985, <4 x half> %186, <4 x float> zeroinitializer), !call_argsrelate !163
  %193 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.52.0.copyload994, <4 x half> %186, <4 x float> zeroinitializer), !call_argsrelate !163
  %194 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.92.16.copyload1081, <4 x half> %186, <4 x float> zeroinitializer), !call_argsrelate !163
  %195 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.142.16.copyload1090, <4 x half> %186, <4 x float> zeroinitializer), !call_argsrelate !163
  br label %if.end437.2

if.end437.2:                                      ; preds = %for.cond397.preheader.2, %for.cond290.preheader.2
  %out_2.sroa.86.7 = phi <4 x float> [ zeroinitializer, %for.cond290.preheader.2 ], [ %195, %for.cond397.preheader.2 ]
  %out_2.sroa.58.7 = phi <4 x float> [ zeroinitializer, %for.cond290.preheader.2 ], [ %194, %for.cond397.preheader.2 ]
  %out_2.sroa.30.7 = phi <4 x float> [ zeroinitializer, %for.cond290.preheader.2 ], [ %193, %for.cond397.preheader.2 ]
  %out_2.sroa.0.7 = phi <4 x float> [ zeroinitializer, %for.cond290.preheader.2 ], [ %192, %for.cond397.preheader.2 ]
  %or.cond784.1.2 = icmp ugt i32 %mul11.3, 1023
  %cmp303.not.1.2 = icmp sgt i32 %mul11.3, %1
  %or.cond785.1.2 = or i1 %or.cond784.1.2, %cmp303.not.1.2
  br i1 %or.cond785.1.2, label %if.end441.2, label %for.cond416.preheader.1.2

for.cond416.preheader.1.2:                        ; preds = %if.end437.2
  %add337.1.2 = or disjoint i32 %and275, 512
  %add.ptr339.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add337.1.2
  %196 = load <4 x half>, ptr addrspace(3) %add.ptr339.1.2, align 8
  %197 = shl nsw i32 %cond.i.i743.3, 10
  %mul312.1.2 = and i32 %197, 64512
  %add313.1.2 = or disjoint i32 %mul312.1.2, %mul131
  %198 = zext nneg i32 %add313.1.2 to i64
  %199 = or disjoint i64 %198, %27
  %200 = or disjoint i64 %199, 512
  %add.ptr321.1.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %200
  %vr.sroa.142.16.add.ptr321.1.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.1.1.2, i64 8
  %vr.sroa.142.16.copyload1091 = load <4 x half>, ptr addrspace(4) %vr.sroa.142.16.add.ptr321.1.1.2.sroa_idx, align 8
  %vr.sroa.92.16.copyload1082 = load <4 x half>, ptr addrspace(4) %add.ptr321.1.1.2, align 16
  %201 = or disjoint i64 %198, %27
  %add.ptr321.1815.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %201
  %vr.sroa.52.0.add.ptr321.1815.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.1815.2, i64 8
  %vr.sroa.52.0.copyload995 = load <4 x half>, ptr addrspace(4) %vr.sroa.52.0.add.ptr321.1815.2.sroa_idx, align 8
  %vr.sroa.0.0.copyload986 = load <4 x half>, ptr addrspace(4) %add.ptr321.1815.2, align 16
  %202 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload986, <4 x half> %196, <4 x float> zeroinitializer), !call_argsrelate !163
  %203 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.52.0.copyload995, <4 x half> %196, <4 x float> zeroinitializer), !call_argsrelate !163
  %204 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.92.16.copyload1082, <4 x half> %196, <4 x float> zeroinitializer), !call_argsrelate !163
  %205 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.142.16.copyload1091, <4 x half> %196, <4 x float> zeroinitializer), !call_argsrelate !163
  br label %if.end441.2

if.end441.2:                                      ; preds = %if.end437.2, %for.cond416.preheader.1.2, %if.end283.2
  %out_2.sroa.86.9 = phi <4 x float> [ zeroinitializer, %if.end283.2 ], [ %out_2.sroa.86.7, %for.cond416.preheader.1.2 ], [ %out_2.sroa.86.7, %if.end437.2 ]
  %out_2.sroa.58.9 = phi <4 x float> [ zeroinitializer, %if.end283.2 ], [ %out_2.sroa.58.7, %for.cond416.preheader.1.2 ], [ %out_2.sroa.58.7, %if.end437.2 ]
  %out_2.sroa.30.9 = phi <4 x float> [ zeroinitializer, %if.end283.2 ], [ %out_2.sroa.30.7, %for.cond416.preheader.1.2 ], [ %out_2.sroa.30.7, %if.end437.2 ]
  %out_2.sroa.0.9 = phi <4 x float> [ zeroinitializer, %if.end283.2 ], [ %out_2.sroa.0.7, %for.cond416.preheader.1.2 ], [ %out_2.sroa.0.7, %if.end437.2 ]
  %out_3.sroa.86.9 = phi <4 x float> [ zeroinitializer, %if.end283.2 ], [ %205, %for.cond416.preheader.1.2 ], [ zeroinitializer, %if.end437.2 ]
  %out_3.sroa.58.9 = phi <4 x float> [ zeroinitializer, %if.end283.2 ], [ %204, %for.cond416.preheader.1.2 ], [ zeroinitializer, %if.end437.2 ]
  %out_3.sroa.30.9 = phi <4 x float> [ zeroinitializer, %if.end283.2 ], [ %203, %for.cond416.preheader.1.2 ], [ zeroinitializer, %if.end437.2 ]
  %out_3.sroa.0.9 = phi <4 x float> [ zeroinitializer, %if.end283.2 ], [ %202, %for.cond416.preheader.1.2 ], [ zeroinitializer, %if.end437.2 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %cmp108, label %if.end283.3, label %for.cond111.preheader.3

for.cond111.preheader.3:                          ; preds = %if.end441.2
  %or.cond780.3 = icmp ugt i32 %mul11.6, 1023
  %cmp124.not.3 = icmp sgt i32 %mul11.6, %1
  %or.cond781.3 = or i1 %or.cond780.3, %cmp124.not.3
  br i1 %or.cond781.3, label %if.end152.3, label %for.cond126.preheader.3

for.cond126.preheader.3:                          ; preds = %for.cond111.preheader.3
  %206 = shl nsw i32 %cond.i.i743.6, 10
  %mul133.3 = and i32 %206, 64512
  %add134.3 = or disjoint i32 %mul133.3, %mul131
  %207 = zext nneg i32 %add134.3 to i64
  %208 = or disjoint i64 %207, %26
  %add.ptr142.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %208
  %kr.sroa.0.0.copyload1709 = load <4 x half>, ptr addrspace(4) %add.ptr142.3, align 16
  %kr.sroa.12.0.add.ptr142.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.3, i64 8
  %kr.sroa.12.0.copyload1713 = load <4 x half>, ptr addrspace(4) %kr.sroa.12.0.add.ptr142.3.sroa_idx, align 8
  %209 = or disjoint i64 %207, %26
  %210 = or disjoint i64 %209, 512
  %add.ptr142.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %210
  %kr.sroa.17.16.copyload1725 = load <4 x half>, ptr addrspace(4) %add.ptr142.1.3, align 16
  %kr.sroa.27.16.add.ptr142.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1.3, i64 8
  %kr.sroa.27.16.copyload1729 = load <4 x half>, ptr addrspace(4) %kr.sroa.27.16.add.ptr142.1.3.sroa_idx, align 8
  br label %if.end152.3

if.end152.3:                                      ; preds = %for.cond126.preheader.3, %for.cond111.preheader.3
  %kr.sroa.27.6 = phi <4 x half> [ %kr.sroa.27.5, %for.cond111.preheader.3 ], [ %kr.sroa.27.16.copyload1729, %for.cond126.preheader.3 ]
  %kr.sroa.17.6 = phi <4 x half> [ %kr.sroa.17.5, %for.cond111.preheader.3 ], [ %kr.sroa.17.16.copyload1725, %for.cond126.preheader.3 ]
  %kr.sroa.12.6 = phi <4 x half> [ %kr.sroa.12.5, %for.cond111.preheader.3 ], [ %kr.sroa.12.0.copyload1713, %for.cond126.preheader.3 ]
  %kr.sroa.0.6 = phi <4 x half> [ %kr.sroa.0.5, %for.cond111.preheader.3 ], [ %kr.sroa.0.0.copyload1709, %for.cond126.preheader.3 ]
  %or.cond780.1.3 = icmp ugt i32 %mul11.7, 1023
  %cmp124.not.1.3 = icmp sgt i32 %mul11.7, %1
  %or.cond781.1.3 = or i1 %or.cond780.1.3, %cmp124.not.1.3
  br i1 %or.cond781.1.3, label %if.end152.1.3, label %for.cond126.preheader.1.3

for.cond126.preheader.1.3:                        ; preds = %if.end152.3
  %211 = shl nsw i32 %cond.i.i743.7, 10
  %mul133.1.3 = and i32 %211, 64512
  %add134.1.3 = or disjoint i32 %mul133.1.3, %mul131
  %212 = zext nneg i32 %add134.1.3 to i64
  %213 = or disjoint i64 %212, %26
  %add.ptr142.1801.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %213
  %kr.sroa.32.32.copyload1741 = load <4 x half>, ptr addrspace(4) %add.ptr142.1801.3, align 16
  %kr.sroa.42.32.add.ptr142.1801.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1801.3, i64 8
  %kr.sroa.42.32.copyload1745 = load <4 x half>, ptr addrspace(4) %kr.sroa.42.32.add.ptr142.1801.3.sroa_idx, align 8
  %214 = or disjoint i64 %212, %26
  %215 = or disjoint i64 %214, 512
  %add.ptr142.1.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %215
  %kr.sroa.47.48.copyload1757 = load <4 x half>, ptr addrspace(4) %add.ptr142.1.1.3, align 16
  %kr.sroa.57.48.add.ptr142.1.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1.1.3, i64 8
  %kr.sroa.57.48.copyload1761 = load <4 x half>, ptr addrspace(4) %kr.sroa.57.48.add.ptr142.1.1.3.sroa_idx, align 8
  br label %if.end152.1.3

if.end152.1.3:                                    ; preds = %for.cond126.preheader.1.3, %if.end152.3
  %kr.sroa.57.6 = phi <4 x half> [ %kr.sroa.57.5, %if.end152.3 ], [ %kr.sroa.57.48.copyload1761, %for.cond126.preheader.1.3 ]
  %kr.sroa.47.6 = phi <4 x half> [ %kr.sroa.47.5, %if.end152.3 ], [ %kr.sroa.47.48.copyload1757, %for.cond126.preheader.1.3 ]
  %kr.sroa.42.6 = phi <4 x half> [ %kr.sroa.42.5, %if.end152.3 ], [ %kr.sroa.42.32.copyload1745, %for.cond126.preheader.1.3 ]
  %kr.sroa.32.6 = phi <4 x half> [ %kr.sroa.32.5, %if.end152.3 ], [ %kr.sroa.32.32.copyload1741, %for.cond126.preheader.1.3 ]
  br i1 %or.cond781.3, label %if.end267.3, label %if.then170.3

if.then170.3:                                     ; preds = %if.end152.1.3
  %cmp173.3 = icmp sgt i32 %mul11.6, %invariant.op
  br i1 %cmp173.3, label %for.cond175.preheader.3, label %if.end201.3

for.cond175.preheader.3:                          ; preds = %if.then170.3
  %add183.3 = or disjoint i32 %mul11.6, %mul182
  %cmp186.not.3935 = icmp sgt i32 %add183.3, %1
  %spec.select.3936 = select i1 %cmp186.not.3935, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1205 = insertelement <4 x float> poison, float %spec.select.3936, i64 0
  %cmp186.not.1.3.not = icmp slt i32 %add183.3, %1
  %spec.select.1.3 = select i1 %cmp186.not.1.3.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1308 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1205, float %spec.select.1.3, i64 1
  %add184.2.3 = or disjoint i32 %add183.3, 2
  %cmp186.not.2.3 = icmp sgt i32 %add184.2.3, %1
  %spec.select.2.3 = select i1 %cmp186.not.2.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1405 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1308, float %spec.select.2.3, i64 2
  %add184.3.3 = or disjoint i32 %add183.3, 3
  %cmp186.not.3.3 = icmp sgt i32 %add184.3.3, %1
  %spec.select.3.3 = select i1 %cmp186.not.3.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1502 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1405, float %spec.select.3.3, i64 3
  br label %if.end201.3

if.end201.3:                                      ; preds = %if.then170.3, %for.cond175.preheader.3
  %scores.sroa.0.15 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1502, %for.cond175.preheader.3 ], [ zeroinitializer, %if.then170.3 ]
  %216 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.6, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.15)
  %217 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.12.6, <4 x half> %qr.sroa.13.0, <4 x float> %216)
  %218 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.17.6, <4 x half> %qr.sroa.23.0, <4 x float> %217)
  %219 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.27.6, <4 x half> %qr.sroa.34.0, <4 x float> %218)
  %scores.sroa.0.0.vec.extract1207 = extractelement <4 x float> %219, i64 0
  %mul227.3937 = fmul contract float %scores.sroa.0.0.vec.extract1207, 0x3FB99999A0000000
  %220 = tail call contract noundef float @llvm.minnum.f32(float %mul227.3937, float 0x4024CB5EC0000000)
  %221 = tail call contract noundef float @llvm.exp.f32(float %220)
  %scores.sroa.0.4.vec.extract1310 = extractelement <4 x float> %219, i64 1
  %mul227.1.3 = fmul contract float %scores.sroa.0.4.vec.extract1310, 0x3FB99999A0000000
  %222 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1.3, float 0x4024CB5EC0000000)
  %223 = tail call contract noundef float @llvm.exp.f32(float %222)
  %scores.sroa.0.8.vec.extract1407 = extractelement <4 x float> %219, i64 2
  %mul227.2.3 = fmul contract float %scores.sroa.0.8.vec.extract1407, 0x3FB99999A0000000
  %224 = tail call contract noundef float @llvm.minnum.f32(float %mul227.2.3, float 0x4024CB5EC0000000)
  %225 = tail call contract noundef float @llvm.exp.f32(float %224)
  %scores.sroa.0.12.vec.extract1504 = extractelement <4 x float> %219, i64 3
  %mul227.3.3 = fmul contract float %scores.sroa.0.12.vec.extract1504, 0x3FB99999A0000000
  %226 = tail call contract noundef float @llvm.minnum.f32(float %mul227.3.3, float 0x4024CB5EC0000000)
  %227 = tail call contract noundef float @llvm.exp.f32(float %226)
  %add243.3938 = fadd contract float %sums.sroa.0.9, %221
  %228 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %221)
  %probs.sroa.0.0.vec.insert1603 = insertelement <4 x i16> poison, i16 %228, i64 0
  %add243.1.3 = fadd contract float %sums.sroa.24.9, %223
  %229 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %223)
  %probs.sroa.0.2.vec.insert1641 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1603, i16 %229, i64 1
  %add243.2.3 = fadd contract float %sums.sroa.46.9, %225
  %230 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %225)
  %probs.sroa.0.4.vec.insert1678 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1641, i16 %230, i64 2
  %add243.3.3 = fadd contract float %sums.sroa.68.9, %227
  %231 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %227)
  %probs.sroa.0.6.vec.insert1696 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1678, i16 %231, i64 3
  br label %if.end267.3

if.end267.3:                                      ; preds = %if.end152.1.3, %if.end201.3
  %sums.sroa.68.10 = phi float [ %add243.3.3, %if.end201.3 ], [ %sums.sroa.68.9, %if.end152.1.3 ]
  %sums.sroa.46.10 = phi float [ %add243.2.3, %if.end201.3 ], [ %sums.sroa.46.9, %if.end152.1.3 ]
  %sums.sroa.24.10 = phi float [ %add243.1.3, %if.end201.3 ], [ %sums.sroa.24.9, %if.end152.1.3 ]
  %sums.sroa.0.10 = phi float [ %add243.3938, %if.end201.3 ], [ %sums.sroa.0.9, %if.end152.1.3 ]
  %probs.sroa.0.18 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1696, %if.end201.3 ], [ zeroinitializer, %if.end152.1.3 ]
  %add277.3 = or disjoint i32 %and275, 512
  %add.ptr279.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add277.3
  store <4 x i16> %probs.sroa.0.18, ptr addrspace(3) %add.ptr279.3, align 8
  br i1 %or.cond781.1.3, label %if.end267.1.3, label %if.then170.1.3

if.then170.1.3:                                   ; preds = %if.end267.3
  %cmp173.1.3 = icmp sgt i32 %mul11.7, %invariant.op
  br i1 %cmp173.1.3, label %for.cond175.preheader.1.3, label %if.end201.1.3

for.cond175.preheader.1.3:                        ; preds = %if.then170.1.3
  %add183.1.3 = or disjoint i32 %mul11.7, %mul182
  %cmp186.not.1804.3 = icmp sgt i32 %add183.1.3, %1
  %spec.select.1805.3 = select i1 %cmp186.not.1804.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1215 = insertelement <4 x float> poison, float %spec.select.1805.3, i64 0
  %cmp186.not.1.1.3.not = icmp slt i32 %add183.1.3, %1
  %spec.select.1.1.3 = select i1 %cmp186.not.1.1.3.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1316 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1215, float %spec.select.1.1.3, i64 1
  %add184.2.1.3 = or disjoint i32 %add183.1.3, 2
  %cmp186.not.2.1.3 = icmp sgt i32 %add184.2.1.3, %1
  %spec.select.2.1.3 = select i1 %cmp186.not.2.1.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1413 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1316, float %spec.select.2.1.3, i64 2
  %add184.3.1.3 = or disjoint i32 %add183.1.3, 3
  %cmp186.not.3.1.3 = icmp sgt i32 %add184.3.1.3, %1
  %spec.select.3.1.3 = select i1 %cmp186.not.3.1.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1510 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1413, float %spec.select.3.1.3, i64 3
  br label %if.end201.1.3

if.end201.1.3:                                    ; preds = %if.then170.1.3, %for.cond175.preheader.1.3
  %scores.sroa.0.17 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1510, %for.cond175.preheader.1.3 ], [ zeroinitializer, %if.then170.1.3 ]
  %232 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.32.6, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.17)
  %233 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.42.6, <4 x half> %qr.sroa.13.0, <4 x float> %232)
  %234 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.6, <4 x half> %qr.sroa.23.0, <4 x float> %233)
  %235 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.57.6, <4 x half> %qr.sroa.34.0, <4 x float> %234)
  %scores.sroa.0.0.vec.extract1217 = extractelement <4 x float> %235, i64 0
  %mul227.1808.3 = fmul contract float %scores.sroa.0.0.vec.extract1217, 0x3FB99999A0000000
  %236 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1808.3, float 0x4024CB5EC0000000)
  %237 = tail call contract noundef float @llvm.exp.f32(float %236)
  %scores.sroa.0.4.vec.extract1318 = extractelement <4 x float> %235, i64 1
  %mul227.1.1.3 = fmul contract float %scores.sroa.0.4.vec.extract1318, 0x3FB99999A0000000
  %238 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1.1.3, float 0x4024CB5EC0000000)
  %239 = tail call contract noundef float @llvm.exp.f32(float %238)
  %scores.sroa.0.8.vec.extract1415 = extractelement <4 x float> %235, i64 2
  %mul227.2.1.3 = fmul contract float %scores.sroa.0.8.vec.extract1415, 0x3FB99999A0000000
  %240 = tail call contract noundef float @llvm.minnum.f32(float %mul227.2.1.3, float 0x4024CB5EC0000000)
  %241 = tail call contract noundef float @llvm.exp.f32(float %240)
  %scores.sroa.0.12.vec.extract1512 = extractelement <4 x float> %235, i64 3
  %mul227.3.1.3 = fmul contract float %scores.sroa.0.12.vec.extract1512, 0x3FB99999A0000000
  %242 = tail call contract noundef float @llvm.minnum.f32(float %mul227.3.1.3, float 0x4024CB5EC0000000)
  %243 = tail call contract noundef float @llvm.exp.f32(float %242)
  %add243.1809.3 = fadd contract float %sums.sroa.0.10, %237
  %244 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %237)
  %probs.sroa.0.0.vec.insert1605 = insertelement <4 x i16> poison, i16 %244, i64 0
  %add243.1.1.3 = fadd contract float %sums.sroa.24.10, %239
  %245 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %239)
  %probs.sroa.0.2.vec.insert1643 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1605, i16 %245, i64 1
  %add243.2.1.3 = fadd contract float %sums.sroa.46.10, %241
  %246 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %241)
  %probs.sroa.0.4.vec.insert1680 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1643, i16 %246, i64 2
  %add243.3.1.3 = fadd contract float %sums.sroa.68.10, %243
  %247 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %243)
  %probs.sroa.0.6.vec.insert1698 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1680, i16 %247, i64 3
  %248 = bitcast <4 x i16> %probs.sroa.0.6.vec.insert1698 to i64
  br label %if.end267.1.3

if.end267.1.3:                                    ; preds = %if.end267.3, %if.end201.1.3
  %sums.sroa.68.11 = phi float [ %add243.3.1.3, %if.end201.1.3 ], [ %sums.sroa.68.10, %if.end267.3 ]
  %sums.sroa.46.11 = phi float [ %add243.2.1.3, %if.end201.1.3 ], [ %sums.sroa.46.10, %if.end267.3 ]
  %sums.sroa.24.11 = phi float [ %add243.1.1.3, %if.end201.1.3 ], [ %sums.sroa.24.10, %if.end267.3 ]
  %sums.sroa.0.11 = phi float [ %add243.1809.3, %if.end201.1.3 ], [ %sums.sroa.0.10, %if.end267.3 ]
  %probs.sroa.0.19 = phi i64 [ %248, %if.end201.1.3 ], [ 0, %if.end267.3 ]
  %add277.1.3 = or disjoint i32 %and275, 768
  %add.ptr279.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add277.1.3
  store i64 %probs.sroa.0.19, ptr addrspace(3) %add.ptr279.1.3, align 8
  br label %if.end283.3

if.end283.3:                                      ; preds = %if.end267.1.3, %if.end441.2
  %sums.sroa.68.12 = phi float [ %sums.sroa.68.9, %if.end441.2 ], [ %sums.sroa.68.11, %if.end267.1.3 ]
  %sums.sroa.46.12 = phi float [ %sums.sroa.46.9, %if.end441.2 ], [ %sums.sroa.46.11, %if.end267.1.3 ]
  %sums.sroa.24.12 = phi float [ %sums.sroa.24.9, %if.end441.2 ], [ %sums.sroa.24.11, %if.end267.1.3 ]
  %sums.sroa.0.12 = phi float [ %sums.sroa.0.9, %if.end441.2 ], [ %sums.sroa.0.11, %if.end267.1.3 ]
  br i1 %cmp286.not, label %for.cond290.preheader.3, label %if.end441.3

for.cond290.preheader.3:                          ; preds = %if.end283.3
  %or.cond784.3 = icmp ugt i32 %mul11.4, 1023
  %cmp303.not.3 = icmp sgt i32 %mul11.4, %1
  %or.cond785.3 = or i1 %or.cond784.3, %cmp303.not.3
  br i1 %or.cond785.3, label %if.end437.3, label %for.cond347.preheader.3

for.cond347.preheader.3:                          ; preds = %for.cond290.preheader.3
  %add.ptr339.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul336
  %249 = load <4 x half>, ptr addrspace(3) %add.ptr339.3, align 8
  %250 = shl nsw i32 %cond.i.i743.4, 10
  %mul312.3 = and i32 %250, 64512
  %add313.3 = or disjoint i32 %mul312.3, %mul131
  %251 = zext nneg i32 %add313.3 to i64
  %252 = or disjoint i64 %251, %27
  %253 = or disjoint i64 %252, 512
  %add.ptr321.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %253
  %vr.sroa.142.16.add.ptr321.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.1.3, i64 8
  %vr.sroa.142.16.copyload1092 = load <4 x half>, ptr addrspace(4) %vr.sroa.142.16.add.ptr321.1.3.sroa_idx, align 8
  %vr.sroa.92.16.copyload1083 = load <4 x half>, ptr addrspace(4) %add.ptr321.1.3, align 16
  %254 = or disjoint i64 %251, %27
  %add.ptr321.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %254
  %vr.sroa.52.0.add.ptr321.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.3, i64 8
  %vr.sroa.52.0.copyload996 = load <4 x half>, ptr addrspace(4) %vr.sroa.52.0.add.ptr321.3.sroa_idx, align 8
  %vr.sroa.0.0.copyload987 = load <4 x half>, ptr addrspace(4) %add.ptr321.3, align 16
  %255 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload987, <4 x half> %249, <4 x float> %out.sroa.0.6), !call_argsrelate !163
  %256 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.52.0.copyload996, <4 x half> %249, <4 x float> %out.sroa.42.6), !call_argsrelate !163
  %257 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.92.16.copyload1083, <4 x half> %249, <4 x float> %out.sroa.82.6), !call_argsrelate !163
  %258 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.142.16.copyload1092, <4 x half> %249, <4 x float> %out.sroa.122.6), !call_argsrelate !163
  br label %if.end437.3

if.end437.3:                                      ; preds = %for.cond347.preheader.3, %for.cond290.preheader.3
  %out.sroa.122.10 = phi <4 x float> [ %out.sroa.122.6, %for.cond290.preheader.3 ], [ %258, %for.cond347.preheader.3 ]
  %out.sroa.82.10 = phi <4 x float> [ %out.sroa.82.6, %for.cond290.preheader.3 ], [ %257, %for.cond347.preheader.3 ]
  %out.sroa.42.10 = phi <4 x float> [ %out.sroa.42.6, %for.cond290.preheader.3 ], [ %256, %for.cond347.preheader.3 ]
  %out.sroa.0.10 = phi <4 x float> [ %out.sroa.0.6, %for.cond290.preheader.3 ], [ %255, %for.cond347.preheader.3 ]
  %or.cond784.1.3 = icmp ugt i32 %mul11.5, 1023
  %cmp303.not.1.3 = icmp sgt i32 %mul11.5, %1
  %or.cond785.1.3 = or i1 %or.cond784.1.3, %cmp303.not.1.3
  br i1 %or.cond785.1.3, label %if.end441.3, label %for.cond372.preheader.1.3

for.cond372.preheader.1.3:                        ; preds = %if.end437.3
  %add.ptr339.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and275
  %259 = load <4 x half>, ptr addrspace(3) %add.ptr339.1.3, align 8
  %260 = shl nsw i32 %cond.i.i743.5, 10
  %mul312.1.3 = and i32 %260, 64512
  %add313.1.3 = or disjoint i32 %mul312.1.3, %mul131
  %261 = zext nneg i32 %add313.1.3 to i64
  %262 = or disjoint i64 %261, %27
  %263 = or disjoint i64 %262, 512
  %add.ptr321.1.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %263
  %vr.sroa.142.16.add.ptr321.1.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.1.1.3, i64 8
  %vr.sroa.142.16.copyload1093 = load <4 x half>, ptr addrspace(4) %vr.sroa.142.16.add.ptr321.1.1.3.sroa_idx, align 8
  %vr.sroa.92.16.copyload1084 = load <4 x half>, ptr addrspace(4) %add.ptr321.1.1.3, align 16
  %264 = or disjoint i64 %261, %27
  %add.ptr321.1815.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %264
  %vr.sroa.52.0.add.ptr321.1815.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.1815.3, i64 8
  %vr.sroa.52.0.copyload997 = load <4 x half>, ptr addrspace(4) %vr.sroa.52.0.add.ptr321.1815.3.sroa_idx, align 8
  %vr.sroa.0.0.copyload988 = load <4 x half>, ptr addrspace(4) %add.ptr321.1815.3, align 16
  %265 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload988, <4 x half> %259, <4 x float> %out_1.sroa.0.6), !call_argsrelate !163
  %266 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.52.0.copyload997, <4 x half> %259, <4 x float> %out_1.sroa.30.6), !call_argsrelate !163
  %267 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.92.16.copyload1084, <4 x half> %259, <4 x float> %out_1.sroa.58.6), !call_argsrelate !163
  %268 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.142.16.copyload1093, <4 x half> %259, <4 x float> %out_1.sroa.86.6), !call_argsrelate !163
  br label %if.end441.3

if.end441.3:                                      ; preds = %if.end437.3, %for.cond372.preheader.1.3, %if.end283.3
  %out.sroa.122.12 = phi <4 x float> [ %out.sroa.122.6, %if.end283.3 ], [ %out.sroa.122.10, %for.cond372.preheader.1.3 ], [ %out.sroa.122.10, %if.end437.3 ]
  %out.sroa.82.12 = phi <4 x float> [ %out.sroa.82.6, %if.end283.3 ], [ %out.sroa.82.10, %for.cond372.preheader.1.3 ], [ %out.sroa.82.10, %if.end437.3 ]
  %out.sroa.42.12 = phi <4 x float> [ %out.sroa.42.6, %if.end283.3 ], [ %out.sroa.42.10, %for.cond372.preheader.1.3 ], [ %out.sroa.42.10, %if.end437.3 ]
  %out.sroa.0.12 = phi <4 x float> [ %out.sroa.0.6, %if.end283.3 ], [ %out.sroa.0.10, %for.cond372.preheader.1.3 ], [ %out.sroa.0.10, %if.end437.3 ]
  %out_1.sroa.86.12 = phi <4 x float> [ %out_1.sroa.86.6, %if.end283.3 ], [ %268, %for.cond372.preheader.1.3 ], [ %out_1.sroa.86.6, %if.end437.3 ]
  %out_1.sroa.58.12 = phi <4 x float> [ %out_1.sroa.58.6, %if.end283.3 ], [ %267, %for.cond372.preheader.1.3 ], [ %out_1.sroa.58.6, %if.end437.3 ]
  %out_1.sroa.30.12 = phi <4 x float> [ %out_1.sroa.30.6, %if.end283.3 ], [ %266, %for.cond372.preheader.1.3 ], [ %out_1.sroa.30.6, %if.end437.3 ]
  %out_1.sroa.0.12 = phi <4 x float> [ %out_1.sroa.0.6, %if.end283.3 ], [ %265, %for.cond372.preheader.1.3 ], [ %out_1.sroa.0.6, %if.end437.3 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br label %if.end283.4

if.end283.4:                                      ; preds = %if.end441.3
  br i1 %cmp286.not, label %for.cond290.preheader.4, label %if.end441.4

for.cond290.preheader.4:                          ; preds = %if.end283.4
  %or.cond784.4 = icmp ugt i32 %mul11.6, 1023
  %cmp303.not.4 = icmp sgt i32 %mul11.6, %1
  %or.cond785.4 = or i1 %or.cond784.4, %cmp303.not.4
  br i1 %or.cond785.4, label %if.end437.4, label %for.cond397.preheader.4

for.cond397.preheader.4:                          ; preds = %for.cond290.preheader.4
  %add337.4 = or disjoint i32 %mul336, 512
  %add.ptr339.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add337.4
  %269 = load <4 x half>, ptr addrspace(3) %add.ptr339.4, align 8
  %270 = shl nsw i32 %cond.i.i743.6, 10
  %mul312.4 = and i32 %270, 64512
  %add313.4 = or disjoint i32 %mul312.4, %mul131
  %271 = zext nneg i32 %add313.4 to i64
  %272 = or disjoint i64 %271, %27
  %273 = or disjoint i64 %272, 512
  %add.ptr321.1.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %273
  %vr.sroa.142.16.add.ptr321.1.4.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.1.4, i64 8
  %vr.sroa.142.16.copyload1094 = load <4 x half>, ptr addrspace(4) %vr.sroa.142.16.add.ptr321.1.4.sroa_idx, align 8
  %vr.sroa.92.16.copyload1085 = load <4 x half>, ptr addrspace(4) %add.ptr321.1.4, align 16
  %274 = or disjoint i64 %271, %27
  %add.ptr321.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %274
  %vr.sroa.52.0.add.ptr321.4.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.4, i64 8
  %vr.sroa.52.0.copyload998 = load <4 x half>, ptr addrspace(4) %vr.sroa.52.0.add.ptr321.4.sroa_idx, align 8
  %vr.sroa.0.0.copyload989 = load <4 x half>, ptr addrspace(4) %add.ptr321.4, align 16
  %275 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload989, <4 x half> %269, <4 x float> %out_2.sroa.0.9), !call_argsrelate !163
  %276 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.52.0.copyload998, <4 x half> %269, <4 x float> %out_2.sroa.30.9), !call_argsrelate !163
  %277 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.92.16.copyload1085, <4 x half> %269, <4 x float> %out_2.sroa.58.9), !call_argsrelate !163
  %278 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.142.16.copyload1094, <4 x half> %269, <4 x float> %out_2.sroa.86.9), !call_argsrelate !163
  br label %if.end437.4

if.end437.4:                                      ; preds = %for.cond397.preheader.4, %for.cond290.preheader.4
  %out_2.sroa.86.13 = phi <4 x float> [ %out_2.sroa.86.9, %for.cond290.preheader.4 ], [ %278, %for.cond397.preheader.4 ]
  %out_2.sroa.58.13 = phi <4 x float> [ %out_2.sroa.58.9, %for.cond290.preheader.4 ], [ %277, %for.cond397.preheader.4 ]
  %out_2.sroa.30.13 = phi <4 x float> [ %out_2.sroa.30.9, %for.cond290.preheader.4 ], [ %276, %for.cond397.preheader.4 ]
  %out_2.sroa.0.13 = phi <4 x float> [ %out_2.sroa.0.9, %for.cond290.preheader.4 ], [ %275, %for.cond397.preheader.4 ]
  %or.cond784.1.4 = icmp ugt i32 %mul11.7, 1023
  %cmp303.not.1.4 = icmp sgt i32 %mul11.7, %1
  %or.cond785.1.4 = or i1 %or.cond784.1.4, %cmp303.not.1.4
  br i1 %or.cond785.1.4, label %if.end441.4, label %for.cond416.preheader.1.4

for.cond416.preheader.1.4:                        ; preds = %if.end437.4
  %add337.1.4 = or disjoint i32 %and275, 512
  %add.ptr339.1.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add337.1.4
  %279 = load <4 x half>, ptr addrspace(3) %add.ptr339.1.4, align 8
  %280 = shl nsw i32 %cond.i.i743.7, 10
  %mul312.1.4 = and i32 %280, 64512
  %add313.1.4 = or disjoint i32 %mul312.1.4, %mul131
  %281 = zext nneg i32 %add313.1.4 to i64
  %282 = or disjoint i64 %281, %27
  %283 = or disjoint i64 %282, 512
  %add.ptr321.1.1.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %283
  %vr.sroa.142.16.add.ptr321.1.1.4.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.1.1.4, i64 8
  %vr.sroa.142.16.copyload1095 = load <4 x half>, ptr addrspace(4) %vr.sroa.142.16.add.ptr321.1.1.4.sroa_idx, align 8
  %vr.sroa.92.16.copyload1086 = load <4 x half>, ptr addrspace(4) %add.ptr321.1.1.4, align 16
  %284 = or disjoint i64 %281, %27
  %add.ptr321.1815.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %284
  %vr.sroa.52.0.add.ptr321.1815.4.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr321.1815.4, i64 8
  %vr.sroa.52.0.copyload999 = load <4 x half>, ptr addrspace(4) %vr.sroa.52.0.add.ptr321.1815.4.sroa_idx, align 8
  %vr.sroa.0.0.copyload990 = load <4 x half>, ptr addrspace(4) %add.ptr321.1815.4, align 16
  %285 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload990, <4 x half> %279, <4 x float> %out_3.sroa.0.9), !call_argsrelate !163
  %286 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.52.0.copyload999, <4 x half> %279, <4 x float> %out_3.sroa.30.9), !call_argsrelate !163
  %287 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.92.16.copyload1086, <4 x half> %279, <4 x float> %out_3.sroa.58.9), !call_argsrelate !163
  %288 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.142.16.copyload1095, <4 x half> %279, <4 x float> %out_3.sroa.86.9), !call_argsrelate !163
  br label %if.end441.4

if.end441.4:                                      ; preds = %if.end437.4, %for.cond416.preheader.1.4, %if.end283.4
  %out_2.sroa.86.15 = phi <4 x float> [ %out_2.sroa.86.9, %if.end283.4 ], [ %out_2.sroa.86.13, %for.cond416.preheader.1.4 ], [ %out_2.sroa.86.13, %if.end437.4 ]
  %out_2.sroa.58.15 = phi <4 x float> [ %out_2.sroa.58.9, %if.end283.4 ], [ %out_2.sroa.58.13, %for.cond416.preheader.1.4 ], [ %out_2.sroa.58.13, %if.end437.4 ]
  %out_2.sroa.30.15 = phi <4 x float> [ %out_2.sroa.30.9, %if.end283.4 ], [ %out_2.sroa.30.13, %for.cond416.preheader.1.4 ], [ %out_2.sroa.30.13, %if.end437.4 ]
  %out_2.sroa.0.15 = phi <4 x float> [ %out_2.sroa.0.9, %if.end283.4 ], [ %out_2.sroa.0.13, %for.cond416.preheader.1.4 ], [ %out_2.sroa.0.13, %if.end437.4 ]
  %out_3.sroa.86.15 = phi <4 x float> [ %out_3.sroa.86.9, %if.end283.4 ], [ %288, %for.cond416.preheader.1.4 ], [ %out_3.sroa.86.9, %if.end437.4 ]
  %out_3.sroa.58.15 = phi <4 x float> [ %out_3.sroa.58.9, %if.end283.4 ], [ %287, %for.cond416.preheader.1.4 ], [ %out_3.sroa.58.9, %if.end437.4 ]
  %out_3.sroa.30.15 = phi <4 x float> [ %out_3.sroa.30.9, %if.end283.4 ], [ %286, %for.cond416.preheader.1.4 ], [ %out_3.sroa.30.9, %if.end437.4 ]
  %out_3.sroa.0.15 = phi <4 x float> [ %out_3.sroa.0.9, %if.end283.4 ], [ %285, %for.cond416.preheader.1.4 ], [ %out_3.sroa.0.9, %if.end437.4 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %cmp15, label %for.body453.preheader, label %if.end484

if.end484:                                        ; preds = %for.body453.preheader, %if.end441.4
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  %cmp487 = icmp eq i32 %shr285.mask, 64
  br i1 %cmp487, label %if.then488, label %if.end599

if.then488:                                       ; preds = %if.end484
  %and490 = and i32 %18, 63
  %arrayidx492 = getelementptr inbounds float, ptr addrspace(3) @buf_dyn_shmem, i32 %and490
  %289 = load float, ptr addrspace(3) %arrayidx492, align 4, !tbaa !105
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %out.sroa.0.12, i64 0
  %out_1.sroa.0.0.vec.extract = extractelement <4 x float> %out_1.sroa.0.12, i64 0
  %add502 = fadd contract float %out.sroa.0.0.vec.extract, %out_1.sroa.0.0.vec.extract
  %out_2.sroa.0.0.vec.extract = extractelement <4 x float> %out_2.sroa.0.15, i64 0
  %add509 = fadd contract float %add502, %out_2.sroa.0.0.vec.extract
  %out_3.sroa.0.0.vec.extract = extractelement <4 x float> %out_3.sroa.0.15, i64 0
  %add516 = fadd contract float %add509, %out_3.sroa.0.0.vec.extract
  %mul522 = fmul contract float %289, %add516
  %290 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522)
  %oreg.sroa.0.0.insert.ext = zext i16 %290 to i64
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %out.sroa.0.12, i64 1
  %out_1.sroa.0.4.vec.extract = extractelement <4 x float> %out_1.sroa.0.12, i64 1
  %add502.1 = fadd contract float %out.sroa.0.4.vec.extract, %out_1.sroa.0.4.vec.extract
  %out_2.sroa.0.4.vec.extract = extractelement <4 x float> %out_2.sroa.0.15, i64 1
  %add509.1 = fadd contract float %add502.1, %out_2.sroa.0.4.vec.extract
  %out_3.sroa.0.4.vec.extract = extractelement <4 x float> %out_3.sroa.0.15, i64 1
  %add516.1 = fadd contract float %add509.1, %out_3.sroa.0.4.vec.extract
  %mul522.1 = fmul contract float %289, %add516.1
  %291 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522.1)
  %oreg.sroa.0.2.insert.ext = zext i16 %291 to i64
  %oreg.sroa.0.2.insert.shift = shl nuw nsw i64 %oreg.sroa.0.2.insert.ext, 16
  %oreg.sroa.0.2.insert.insert = or disjoint i64 %oreg.sroa.0.2.insert.shift, %oreg.sroa.0.0.insert.ext
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %out.sroa.0.12, i64 2
  %out_1.sroa.0.8.vec.extract = extractelement <4 x float> %out_1.sroa.0.12, i64 2
  %add502.2 = fadd contract float %out.sroa.0.8.vec.extract, %out_1.sroa.0.8.vec.extract
  %out_2.sroa.0.8.vec.extract = extractelement <4 x float> %out_2.sroa.0.15, i64 2
  %add509.2 = fadd contract float %add502.2, %out_2.sroa.0.8.vec.extract
  %out_3.sroa.0.8.vec.extract = extractelement <4 x float> %out_3.sroa.0.15, i64 2
  %add516.2 = fadd contract float %add509.2, %out_3.sroa.0.8.vec.extract
  %mul522.2 = fmul contract float %289, %add516.2
  %292 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522.2)
  %oreg.sroa.0.4.insert.ext = zext i16 %292 to i64
  %oreg.sroa.0.4.insert.shift = shl nuw nsw i64 %oreg.sroa.0.4.insert.ext, 32
  %oreg.sroa.0.4.insert.insert = or disjoint i64 %oreg.sroa.0.2.insert.insert, %oreg.sroa.0.4.insert.shift
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %out.sroa.0.12, i64 3
  %out_1.sroa.0.12.vec.extract = extractelement <4 x float> %out_1.sroa.0.12, i64 3
  %add502.3 = fadd contract float %out.sroa.0.12.vec.extract, %out_1.sroa.0.12.vec.extract
  %out_2.sroa.0.12.vec.extract = extractelement <4 x float> %out_2.sroa.0.15, i64 3
  %add509.3 = fadd contract float %add502.3, %out_2.sroa.0.12.vec.extract
  %out_3.sroa.0.12.vec.extract = extractelement <4 x float> %out_3.sroa.0.15, i64 3
  %add516.3 = fadd contract float %add509.3, %out_3.sroa.0.12.vec.extract
  %mul522.3 = fmul contract float %289, %add516.3
  %293 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522.3)
  %oreg.sroa.0.6.insert.ext = zext i16 %293 to i64
  %oreg.sroa.0.6.insert.shift = shl nuw i64 %oreg.sroa.0.6.insert.ext, 48
  %oreg.sroa.0.6.insert.insert = or disjoint i64 %oreg.sroa.0.4.insert.insert, %oreg.sroa.0.6.insert.shift
  %out.sroa.42.16.vec.extract = extractelement <4 x float> %out.sroa.42.12, i64 0
  %out_1.sroa.30.16.vec.extract = extractelement <4 x float> %out_1.sroa.30.12, i64 0
  %add502.4 = fadd contract float %out.sroa.42.16.vec.extract, %out_1.sroa.30.16.vec.extract
  %out_2.sroa.30.16.vec.extract = extractelement <4 x float> %out_2.sroa.30.15, i64 0
  %add509.4 = fadd contract float %add502.4, %out_2.sroa.30.16.vec.extract
  %out_3.sroa.30.16.vec.extract = extractelement <4 x float> %out_3.sroa.30.15, i64 0
  %add516.4 = fadd contract float %add509.4, %out_3.sroa.30.16.vec.extract
  %mul522.4 = fmul contract float %289, %add516.4
  %294 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522.4)
  %oreg.sroa.7.8.insert.ext = zext i16 %294 to i64
  %out.sroa.42.20.vec.extract = extractelement <4 x float> %out.sroa.42.12, i64 1
  %out_1.sroa.30.20.vec.extract = extractelement <4 x float> %out_1.sroa.30.12, i64 1
  %add502.5 = fadd contract float %out.sroa.42.20.vec.extract, %out_1.sroa.30.20.vec.extract
  %out_2.sroa.30.20.vec.extract = extractelement <4 x float> %out_2.sroa.30.15, i64 1
  %add509.5 = fadd contract float %add502.5, %out_2.sroa.30.20.vec.extract
  %out_3.sroa.30.20.vec.extract = extractelement <4 x float> %out_3.sroa.30.15, i64 1
  %add516.5 = fadd contract float %add509.5, %out_3.sroa.30.20.vec.extract
  %mul522.5 = fmul contract float %289, %add516.5
  %295 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522.5)
  %oreg.sroa.7.10.insert.ext = zext i16 %295 to i64
  %oreg.sroa.7.10.insert.shift = shl nuw nsw i64 %oreg.sroa.7.10.insert.ext, 16
  %oreg.sroa.7.10.insert.insert = or disjoint i64 %oreg.sroa.7.10.insert.shift, %oreg.sroa.7.8.insert.ext
  %out.sroa.42.24.vec.extract = extractelement <4 x float> %out.sroa.42.12, i64 2
  %out_1.sroa.30.24.vec.extract = extractelement <4 x float> %out_1.sroa.30.12, i64 2
  %add502.6 = fadd contract float %out.sroa.42.24.vec.extract, %out_1.sroa.30.24.vec.extract
  %out_2.sroa.30.24.vec.extract = extractelement <4 x float> %out_2.sroa.30.15, i64 2
  %add509.6 = fadd contract float %add502.6, %out_2.sroa.30.24.vec.extract
  %out_3.sroa.30.24.vec.extract = extractelement <4 x float> %out_3.sroa.30.15, i64 2
  %add516.6 = fadd contract float %add509.6, %out_3.sroa.30.24.vec.extract
  %mul522.6 = fmul contract float %289, %add516.6
  %296 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522.6)
  %oreg.sroa.7.12.insert.ext = zext i16 %296 to i64
  %oreg.sroa.7.12.insert.shift = shl nuw nsw i64 %oreg.sroa.7.12.insert.ext, 32
  %oreg.sroa.7.12.insert.insert = or disjoint i64 %oreg.sroa.7.10.insert.insert, %oreg.sroa.7.12.insert.shift
  %out.sroa.42.28.vec.extract = extractelement <4 x float> %out.sroa.42.12, i64 3
  %out_1.sroa.30.28.vec.extract = extractelement <4 x float> %out_1.sroa.30.12, i64 3
  %add502.7 = fadd contract float %out.sroa.42.28.vec.extract, %out_1.sroa.30.28.vec.extract
  %out_2.sroa.30.28.vec.extract = extractelement <4 x float> %out_2.sroa.30.15, i64 3
  %add509.7 = fadd contract float %add502.7, %out_2.sroa.30.28.vec.extract
  %out_3.sroa.30.28.vec.extract = extractelement <4 x float> %out_3.sroa.30.15, i64 3
  %add516.7 = fadd contract float %add509.7, %out_3.sroa.30.28.vec.extract
  %mul522.7 = fmul contract float %289, %add516.7
  %297 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522.7)
  %oreg.sroa.7.14.insert.ext = zext i16 %297 to i64
  %oreg.sroa.7.14.insert.shift = shl nuw i64 %oreg.sroa.7.14.insert.ext, 48
  %oreg.sroa.7.14.insert.insert = or disjoint i64 %oreg.sroa.7.12.insert.insert, %oreg.sroa.7.14.insert.shift
  %out.sroa.82.32.vec.extract = extractelement <4 x float> %out.sroa.82.12, i64 0
  %out_1.sroa.58.32.vec.extract = extractelement <4 x float> %out_1.sroa.58.12, i64 0
  %add502.8 = fadd contract float %out.sroa.82.32.vec.extract, %out_1.sroa.58.32.vec.extract
  %out_2.sroa.58.32.vec.extract = extractelement <4 x float> %out_2.sroa.58.15, i64 0
  %add509.8 = fadd contract float %add502.8, %out_2.sroa.58.32.vec.extract
  %out_3.sroa.58.32.vec.extract = extractelement <4 x float> %out_3.sroa.58.15, i64 0
  %add516.8 = fadd contract float %add509.8, %out_3.sroa.58.32.vec.extract
  %mul522.8 = fmul contract float %289, %add516.8
  %298 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522.8)
  %oreg.sroa.12.16.insert.ext = zext i16 %298 to i64
  %out.sroa.82.36.vec.extract = extractelement <4 x float> %out.sroa.82.12, i64 1
  %out_1.sroa.58.36.vec.extract = extractelement <4 x float> %out_1.sroa.58.12, i64 1
  %add502.9 = fadd contract float %out.sroa.82.36.vec.extract, %out_1.sroa.58.36.vec.extract
  %out_2.sroa.58.36.vec.extract = extractelement <4 x float> %out_2.sroa.58.15, i64 1
  %add509.9 = fadd contract float %add502.9, %out_2.sroa.58.36.vec.extract
  %out_3.sroa.58.36.vec.extract = extractelement <4 x float> %out_3.sroa.58.15, i64 1
  %add516.9 = fadd contract float %add509.9, %out_3.sroa.58.36.vec.extract
  %mul522.9 = fmul contract float %289, %add516.9
  %299 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522.9)
  %oreg.sroa.12.18.insert.ext = zext i16 %299 to i64
  %oreg.sroa.12.18.insert.shift = shl nuw nsw i64 %oreg.sroa.12.18.insert.ext, 16
  %oreg.sroa.12.18.insert.insert = or disjoint i64 %oreg.sroa.12.18.insert.shift, %oreg.sroa.12.16.insert.ext
  %out.sroa.82.40.vec.extract = extractelement <4 x float> %out.sroa.82.12, i64 2
  %out_1.sroa.58.40.vec.extract = extractelement <4 x float> %out_1.sroa.58.12, i64 2
  %add502.10 = fadd contract float %out.sroa.82.40.vec.extract, %out_1.sroa.58.40.vec.extract
  %out_2.sroa.58.40.vec.extract = extractelement <4 x float> %out_2.sroa.58.15, i64 2
  %add509.10 = fadd contract float %add502.10, %out_2.sroa.58.40.vec.extract
  %out_3.sroa.58.40.vec.extract = extractelement <4 x float> %out_3.sroa.58.15, i64 2
  %add516.10 = fadd contract float %add509.10, %out_3.sroa.58.40.vec.extract
  %mul522.10 = fmul contract float %289, %add516.10
  %300 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522.10)
  %oreg.sroa.12.20.insert.ext = zext i16 %300 to i64
  %oreg.sroa.12.20.insert.shift = shl nuw nsw i64 %oreg.sroa.12.20.insert.ext, 32
  %oreg.sroa.12.20.insert.insert = or disjoint i64 %oreg.sroa.12.18.insert.insert, %oreg.sroa.12.20.insert.shift
  %out.sroa.82.44.vec.extract = extractelement <4 x float> %out.sroa.82.12, i64 3
  %out_1.sroa.58.44.vec.extract = extractelement <4 x float> %out_1.sroa.58.12, i64 3
  %add502.11 = fadd contract float %out.sroa.82.44.vec.extract, %out_1.sroa.58.44.vec.extract
  %out_2.sroa.58.44.vec.extract = extractelement <4 x float> %out_2.sroa.58.15, i64 3
  %add509.11 = fadd contract float %add502.11, %out_2.sroa.58.44.vec.extract
  %out_3.sroa.58.44.vec.extract = extractelement <4 x float> %out_3.sroa.58.15, i64 3
  %add516.11 = fadd contract float %add509.11, %out_3.sroa.58.44.vec.extract
  %mul522.11 = fmul contract float %289, %add516.11
  %301 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522.11)
  %oreg.sroa.12.22.insert.ext = zext i16 %301 to i64
  %oreg.sroa.12.22.insert.shift = shl nuw i64 %oreg.sroa.12.22.insert.ext, 48
  %oreg.sroa.12.22.insert.insert = or disjoint i64 %oreg.sroa.12.20.insert.insert, %oreg.sroa.12.22.insert.shift
  %out.sroa.122.48.vec.extract = extractelement <4 x float> %out.sroa.122.12, i64 0
  %out_1.sroa.86.48.vec.extract = extractelement <4 x float> %out_1.sroa.86.12, i64 0
  %add502.12 = fadd contract float %out.sroa.122.48.vec.extract, %out_1.sroa.86.48.vec.extract
  %out_2.sroa.86.48.vec.extract = extractelement <4 x float> %out_2.sroa.86.15, i64 0
  %add509.12 = fadd contract float %add502.12, %out_2.sroa.86.48.vec.extract
  %out_3.sroa.86.48.vec.extract = extractelement <4 x float> %out_3.sroa.86.15, i64 0
  %add516.12 = fadd contract float %add509.12, %out_3.sroa.86.48.vec.extract
  %mul522.12 = fmul contract float %289, %add516.12
  %302 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522.12)
  %oreg.sroa.17.24.insert.ext = zext i16 %302 to i64
  %out.sroa.122.52.vec.extract = extractelement <4 x float> %out.sroa.122.12, i64 1
  %out_1.sroa.86.52.vec.extract = extractelement <4 x float> %out_1.sroa.86.12, i64 1
  %add502.13 = fadd contract float %out.sroa.122.52.vec.extract, %out_1.sroa.86.52.vec.extract
  %out_2.sroa.86.52.vec.extract = extractelement <4 x float> %out_2.sroa.86.15, i64 1
  %add509.13 = fadd contract float %add502.13, %out_2.sroa.86.52.vec.extract
  %out_3.sroa.86.52.vec.extract = extractelement <4 x float> %out_3.sroa.86.15, i64 1
  %add516.13 = fadd contract float %add509.13, %out_3.sroa.86.52.vec.extract
  %mul522.13 = fmul contract float %289, %add516.13
  %303 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522.13)
  %oreg.sroa.17.26.insert.ext = zext i16 %303 to i64
  %oreg.sroa.17.26.insert.shift = shl nuw nsw i64 %oreg.sroa.17.26.insert.ext, 16
  %oreg.sroa.17.26.insert.insert = or disjoint i64 %oreg.sroa.17.26.insert.shift, %oreg.sroa.17.24.insert.ext
  %out.sroa.122.56.vec.extract = extractelement <4 x float> %out.sroa.122.12, i64 2
  %out_1.sroa.86.56.vec.extract = extractelement <4 x float> %out_1.sroa.86.12, i64 2
  %add502.14 = fadd contract float %out.sroa.122.56.vec.extract, %out_1.sroa.86.56.vec.extract
  %out_2.sroa.86.56.vec.extract = extractelement <4 x float> %out_2.sroa.86.15, i64 2
  %add509.14 = fadd contract float %add502.14, %out_2.sroa.86.56.vec.extract
  %out_3.sroa.86.56.vec.extract = extractelement <4 x float> %out_3.sroa.86.15, i64 2
  %add516.14 = fadd contract float %add509.14, %out_3.sroa.86.56.vec.extract
  %mul522.14 = fmul contract float %289, %add516.14
  %304 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522.14)
  %oreg.sroa.17.28.insert.ext = zext i16 %304 to i64
  %oreg.sroa.17.28.insert.shift = shl nuw nsw i64 %oreg.sroa.17.28.insert.ext, 32
  %oreg.sroa.17.28.insert.insert = or disjoint i64 %oreg.sroa.17.26.insert.insert, %oreg.sroa.17.28.insert.shift
  %out.sroa.122.60.vec.extract = extractelement <4 x float> %out.sroa.122.12, i64 3
  %out_1.sroa.86.60.vec.extract = extractelement <4 x float> %out_1.sroa.86.12, i64 3
  %add502.15 = fadd contract float %out.sroa.122.60.vec.extract, %out_1.sroa.86.60.vec.extract
  %out_2.sroa.86.60.vec.extract = extractelement <4 x float> %out_2.sroa.86.15, i64 3
  %add509.15 = fadd contract float %add502.15, %out_2.sroa.86.60.vec.extract
  %out_3.sroa.86.60.vec.extract = extractelement <4 x float> %out_3.sroa.86.15, i64 3
  %add516.15 = fadd contract float %add509.15, %out_3.sroa.86.60.vec.extract
  %mul522.15 = fmul contract float %289, %add516.15
  %305 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul522.15)
  %oreg.sroa.17.30.insert.ext = zext i16 %305 to i64
  %oreg.sroa.17.30.insert.shift = shl nuw i64 %oreg.sroa.17.30.insert.ext, 48
  %oreg.sroa.17.30.insert.insert = or disjoint i64 %oreg.sroa.17.28.insert.insert, %oreg.sroa.17.30.insert.shift
  %and542 = shl nuw nsw i32 %18, 6
  %mul543 = and i32 %and542, 960
  %and546 = lshr i32 %18, 5
  %shr547 = and i32 %and546, 1
  %and550 = and i32 %18, 7
  %mul556 = and i32 %25, 4
  %xor = xor i32 %shr547, %and550
  %mul551 = shl nuw nsw i32 %xor, 3
  %add552 = or disjoint i32 %mul551, %mul543
  %add557 = or disjoint i32 %add552, %mul556
  %add.ptr559 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add557
  store i64 %oreg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr559, align 8
  %xor.1 = xor i32 %and546, %and550
  %mul551.1 = shl nuw nsw i32 %xor.1, 3
  %add552.1 = or disjoint i32 %mul551.1, %mul543
  %add557.1 = or disjoint i32 %add552.1, %mul556
  %add.ptr559.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add557.1
  store i64 %oreg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr559.1, align 8
  %add548.2 = or disjoint i32 %shr547, 4
  %xor.2 = xor i32 %add548.2, %and550
  %mul551.2 = shl nuw nsw i32 %xor.2, 3
  %add552.2 = or disjoint i32 %mul551.2, %mul543
  %add557.2 = or disjoint i32 %add552.2, %mul556
  %add.ptr559.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add557.2
  store i64 %oreg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr559.2, align 8
  %add548.3 = or i32 %and546, 6
  %xor.3 = xor i32 %add548.3, %and550
  %mul551.3 = shl nuw nsw i32 %xor.3, 3
  %add552.3 = or disjoint i32 %mul551.3, %mul543
  %add557.3 = or disjoint i32 %add552.3, %mul556
  %add.ptr559.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add557.3
  store i64 %oreg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr559.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul571 = and i32 %and138, 448
  %xor578 = xor i32 %and138, %18
  %mul579 = and i32 %xor578, 56
  %306 = or disjoint i32 %mul579, %mul571
  %mul584 = shl nsw i32 %0, 20
  %mul586 = shl nsw i32 %1, 10
  %add587 = add nuw nsw i32 %mul584, %mul586
  %307 = or disjoint i32 %add587, %mul318
  %308 = zext nneg i32 %307 to i64
  %add.ptr582 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %306
  %add.ptr595 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %308
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr595, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr582, i64 16, i1 false), !tbaa.struct !210, !call_argsrelate !211
  %309 = or disjoint i32 %306, 512
  %add.ptr582.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %309
  %310 = or disjoint i64 %308, 512
  %add.ptr595.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %310
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr595.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr582.1, i64 16, i1 false), !tbaa.struct !210, !call_argsrelate !211
  br label %if.end599

if.end599:                                        ; preds = %if.then488, %if.end484
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


