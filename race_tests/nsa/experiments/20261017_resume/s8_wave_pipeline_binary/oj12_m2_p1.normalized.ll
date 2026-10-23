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
  %cond.i.i617 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64)
  %mul11 = shl nsw i32 %cond.i.i617, 4
  %4 = or disjoint i64 %2, 1
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !call_argsrelate !48
  %cond.i.i617.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64)
  %mul11.1 = shl nsw i32 %cond.i.i617.1, 4
  %6 = or disjoint i64 %2, 2
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !call_argsrelate !48
  %cond.i.i617.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64)
  %mul11.2 = shl nsw i32 %cond.i.i617.2, 4
  %8 = or disjoint i64 %2, 3
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !call_argsrelate !48
  %cond.i.i617.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64)
  %mul11.3 = shl nsw i32 %cond.i.i617.3, 4
  %10 = or disjoint i64 %2, 4
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !call_argsrelate !48
  %cond.i.i617.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64)
  %mul11.4 = shl nsw i32 %cond.i.i617.4, 4
  %12 = or disjoint i64 %2, 5
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !call_argsrelate !48
  %cond.i.i617.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64)
  %mul11.5 = shl nsw i32 %cond.i.i617.5, 4
  %14 = or disjoint i64 %2, 6
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !call_argsrelate !48
  %cond.i.i617.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64)
  %mul11.6 = shl nsw i32 %cond.i.i617.6, 4
  %16 = or disjoint i64 %2, 7
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !call_argsrelate !48
  %cond.i.i617.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64)
  %mul11.7 = shl nsw i32 %cond.i.i617.7, 4
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
  %cmp80 = icmp ugt i32 %18, 63
  %shr257.mask = and i32 %18, 960
  %cmp258.not = icmp eq i32 %shr257.mask, 64
  %mul103 = shl nsw i32 %0, 16
  %and110 = shl nuw nsw i32 %18, 3
  %and247 = shl nuw nsw i32 %18, 2
  %invariant.op = add nsw i32 %1, -15
  %25 = lshr i32 %18, 2
  %mul154 = and i32 %25, 12
  %mul290 = and i32 %and110, 504
  %mul308 = and i32 %and247, 252
  %26 = zext nneg i32 %and110 to i64
  %27 = zext nneg i32 %mul290 to i64
  br i1 %cmp80, label %if.end358, label %for.cond83.preheader

for.body370.preheader:                            ; preds = %if.end358.4
  %add374 = fadd contract float %sums.sroa.0.12, 0.000000e+00
  %add374.1 = fadd contract float %add374, %sums.sroa.24.12
  %add374.2 = fadd contract float %add374.1, %sums.sroa.46.12
  %add374.3 = fadd contract float %add374.2, %sums.sroa.68.12
  %28 = bitcast float %add374.3 to i32
  %29 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %30 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %29) #11
  %xor.i.i = xor i32 %30, 32
  %31 = and i32 %30, -64
  %and.i.i = add nsw i32 %31, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i618 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %30
  %shl.i.i = shl i32 %cond.i.i618, 2
  %32 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %28)
  %33 = bitcast i32 %32 to float
  %add382 = fadd contract float %add374.3, %33
  %34 = bitcast float %add382 to i32
  %35 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %36 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %35) #11
  %xor.i.i619 = xor i32 %36, 16
  %37 = and i32 %36, -64
  %and.i.i620 = add nsw i32 %37, 64
  %cmp.not.i.i621 = icmp slt i32 %xor.i.i619, %and.i.i620
  %cond.i.i622 = select i1 %cmp.not.i.i621, i32 %xor.i.i619, i32 %36
  %shl.i.i623 = shl i32 %cond.i.i622, 2
  %38 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i623, i32 %34)
  %39 = bitcast i32 %38 to float
  %add387 = fadd contract float %add382, %39
  %cmp390 = fcmp contract ogt float %add387, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add387
  %condval_1.0 = select i1 %cmp390, float %div, float 0.000000e+00
  %arrayidx400 = getelementptr inbounds float, ptr addrspace(3) @buf_dyn_shmem, i32 %18
  store float %condval_1.0, ptr addrspace(3) %arrayidx400, align 4, !tbaa !105
  br label %if.end401

for.cond83.preheader:                             ; preds = %if.end
  %or.cond648 = icmp ugt i32 %mul11, 1023
  %cmp96.not = icmp sgt i32 %mul11, %1
  %or.cond649 = or i1 %or.cond648, %cmp96.not
  br i1 %or.cond649, label %if.end124, label %for.cond98.preheader

for.cond98.preheader:                             ; preds = %for.cond83.preheader
  %40 = shl nsw i32 %cond.i.i617, 10
  %mul105 = and i32 %40, 64512
  %add106 = or disjoint i32 %mul105, %mul103
  %41 = zext nneg i32 %add106 to i64
  %42 = or disjoint i64 %41, %26
  %add.ptr114 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %42
  %kr.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr114, align 16
  %kr.sroa.12.0.add.ptr114.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114, i64 8
  %kr.sroa.12.0.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.12.0.add.ptr114.sroa_idx, align 8
  %43 = or disjoint i64 %41, %26
  %44 = or disjoint i64 %43, 512
  %add.ptr114.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %44
  %kr.sroa.17.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr114.1, align 16
  %kr.sroa.27.16.add.ptr114.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114.1, i64 8
  %kr.sroa.27.16.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.27.16.add.ptr114.1.sroa_idx, align 8
  br label %if.end124

if.end124:                                        ; preds = %for.cond98.preheader, %for.cond83.preheader
  %kr.sroa.27.0 = phi <4 x half> [ undef, %for.cond83.preheader ], [ %kr.sroa.27.16.copyload, %for.cond98.preheader ]
  %kr.sroa.17.0 = phi <4 x half> [ undef, %for.cond83.preheader ], [ %kr.sroa.17.16.copyload, %for.cond98.preheader ]
  %kr.sroa.12.0 = phi <4 x half> [ undef, %for.cond83.preheader ], [ %kr.sroa.12.0.copyload, %for.cond98.preheader ]
  %kr.sroa.0.0 = phi <4 x half> [ undef, %for.cond83.preheader ], [ %kr.sroa.0.0.copyload, %for.cond98.preheader ]
  %or.cond648.1 = icmp ugt i32 %mul11.1, 1023
  %cmp96.not.1 = icmp sgt i32 %mul11.1, %1
  %or.cond649.1 = or i1 %or.cond648.1, %cmp96.not.1
  br i1 %or.cond649.1, label %if.end124.1, label %for.cond98.preheader.1

for.cond98.preheader.1:                           ; preds = %if.end124
  %45 = shl nsw i32 %cond.i.i617.1, 10
  %mul105.1 = and i32 %45, 64512
  %add106.1 = or disjoint i32 %mul105.1, %mul103
  %46 = zext nneg i32 %add106.1 to i64
  %47 = or disjoint i64 %46, %26
  %add.ptr114.1667 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %47
  %kr.sroa.32.32.copyload = load <4 x half>, ptr addrspace(4) %add.ptr114.1667, align 16
  %kr.sroa.42.32.add.ptr114.1667.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114.1667, i64 8
  %kr.sroa.42.32.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.42.32.add.ptr114.1667.sroa_idx, align 8
  %48 = or disjoint i64 %46, %26
  %49 = or disjoint i64 %48, 512
  %add.ptr114.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %49
  %kr.sroa.47.48.copyload = load <4 x half>, ptr addrspace(4) %add.ptr114.1.1, align 16
  %kr.sroa.57.48.add.ptr114.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114.1.1, i64 8
  %kr.sroa.57.48.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.57.48.add.ptr114.1.1.sroa_idx, align 8
  br label %if.end124.1

if.end124.1:                                      ; preds = %for.cond98.preheader.1, %if.end124
  %kr.sroa.57.0 = phi <4 x half> [ undef, %if.end124 ], [ %kr.sroa.57.48.copyload, %for.cond98.preheader.1 ]
  %kr.sroa.47.0 = phi <4 x half> [ undef, %if.end124 ], [ %kr.sroa.47.48.copyload, %for.cond98.preheader.1 ]
  %kr.sroa.42.0 = phi <4 x half> [ undef, %if.end124 ], [ %kr.sroa.42.32.copyload, %for.cond98.preheader.1 ]
  %kr.sroa.32.0 = phi <4 x half> [ undef, %if.end124 ], [ %kr.sroa.32.32.copyload, %for.cond98.preheader.1 ]
  br i1 %or.cond649, label %if.end239, label %if.then142

if.then142:                                       ; preds = %if.end124.1
  %cmp145 = icmp sgt i32 %mul11, %invariant.op
  br i1 %cmp145, label %for.cond147.preheader, label %if.end173

for.cond147.preheader:                            ; preds = %if.then142
  %add155 = or disjoint i32 %mul11, %mul154
  %cmp158.not = icmp sgt i32 %add155, %1
  %spec.select = select i1 %cmp158.not, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert914 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp158.not.1.not = icmp slt i32 %add155, %1
  %spec.select.1 = select i1 %cmp158.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1029 = insertelement <4 x float> %scores.sroa.0.0.vec.insert914, float %spec.select.1, i64 1
  %add156.2 = or disjoint i32 %add155, 2
  %cmp158.not.2 = icmp sgt i32 %add156.2, %1
  %spec.select.2 = select i1 %cmp158.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1126 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1029, float %spec.select.2, i64 2
  %add156.3 = or disjoint i32 %add155, 3
  %cmp158.not.3 = icmp sgt i32 %add156.3, %1
  %spec.select.3 = select i1 %cmp158.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1223 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1126, float %spec.select.3, i64 3
  br label %if.end173

if.end173:                                        ; preds = %if.then142, %for.cond147.preheader
  %scores.sroa.0.0 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1223, %for.cond147.preheader ], [ zeroinitializer, %if.then142 ]
  %50 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.0)
  %51 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.12.0, <4 x half> %qr.sroa.13.0, <4 x float> %50)
  %52 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.17.0, <4 x half> %qr.sroa.23.0, <4 x float> %51)
  %53 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.27.0, <4 x half> %qr.sroa.34.0, <4 x float> %52)
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %53, i64 0
  %mul199 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %54 = tail call contract noundef float @llvm.minnum.f32(float %mul199, float 0x4024CB5EC0000000)
  %55 = tail call contract noundef float @llvm.exp.f32(float %54)
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %53, i64 1
  %mul199.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %56 = tail call contract noundef float @llvm.minnum.f32(float %mul199.1, float 0x4024CB5EC0000000)
  %57 = tail call contract noundef float @llvm.exp.f32(float %56)
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %53, i64 2
  %mul199.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %58 = tail call contract noundef float @llvm.minnum.f32(float %mul199.2, float 0x4024CB5EC0000000)
  %59 = tail call contract noundef float @llvm.exp.f32(float %58)
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %53, i64 3
  %mul199.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %60 = tail call contract noundef float @llvm.minnum.f32(float %mul199.3, float 0x4024CB5EC0000000)
  %61 = tail call contract noundef float @llvm.exp.f32(float %60)
  %62 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %55)
  %probs.sroa.0.0.vec.insert = insertelement <4 x i16> poison, i16 %62, i64 0
  %63 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %57)
  %probs.sroa.0.2.vec.insert = insertelement <4 x i16> %probs.sroa.0.0.vec.insert, i16 %63, i64 1
  %64 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %59)
  %probs.sroa.0.4.vec.insert = insertelement <4 x i16> %probs.sroa.0.2.vec.insert, i16 %64, i64 2
  %65 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %61)
  %probs.sroa.0.6.vec.insert = insertelement <4 x i16> %probs.sroa.0.4.vec.insert, i16 %65, i64 3
  br label %if.end239

if.end239:                                        ; preds = %if.end124.1, %if.end173
  %sums.sroa.68.1 = phi float [ %61, %if.end173 ], [ 0.000000e+00, %if.end124.1 ]
  %sums.sroa.46.1 = phi float [ %59, %if.end173 ], [ 0.000000e+00, %if.end124.1 ]
  %sums.sroa.24.1 = phi float [ %57, %if.end173 ], [ 0.000000e+00, %if.end124.1 ]
  %sums.sroa.0.1 = phi float [ %55, %if.end173 ], [ 0.000000e+00, %if.end124.1 ]
  %probs.sroa.0.0 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert, %if.end173 ], [ zeroinitializer, %if.end124.1 ]
  %add.ptr251 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and247
  store <4 x i16> %probs.sroa.0.0, ptr addrspace(3) %add.ptr251, align 8
  br i1 %or.cond649.1, label %if.end239.1, label %if.then142.1

if.then142.1:                                     ; preds = %if.end239
  %cmp145.1 = icmp sgt i32 %mul11.1, %invariant.op
  br i1 %cmp145.1, label %for.cond147.preheader.1, label %if.end173.1

for.cond147.preheader.1:                          ; preds = %if.then142.1
  %add155.1 = or disjoint i32 %mul11.1, %mul154
  %cmp158.not.1670 = icmp sgt i32 %add155.1, %1
  %spec.select.1671 = select i1 %cmp158.not.1670, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert923 = insertelement <4 x float> poison, float %spec.select.1671, i64 0
  %cmp158.not.1.1.not = icmp slt i32 %add155.1, %1
  %spec.select.1.1 = select i1 %cmp158.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1036 = insertelement <4 x float> %scores.sroa.0.0.vec.insert923, float %spec.select.1.1, i64 1
  %add156.2.1 = or disjoint i32 %add155.1, 2
  %cmp158.not.2.1 = icmp sgt i32 %add156.2.1, %1
  %spec.select.2.1 = select i1 %cmp158.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1133 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1036, float %spec.select.2.1, i64 2
  %add156.3.1 = or disjoint i32 %add155.1, 3
  %cmp158.not.3.1 = icmp sgt i32 %add156.3.1, %1
  %spec.select.3.1 = select i1 %cmp158.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1230 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1133, float %spec.select.3.1, i64 3
  br label %if.end173.1

if.end173.1:                                      ; preds = %if.then142.1, %for.cond147.preheader.1
  %scores.sroa.0.2 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1230, %for.cond147.preheader.1 ], [ zeroinitializer, %if.then142.1 ]
  %66 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.32.0, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.2)
  %67 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.42.0, <4 x half> %qr.sroa.13.0, <4 x float> %66)
  %68 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.0, <4 x half> %qr.sroa.23.0, <4 x float> %67)
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.57.0, <4 x half> %qr.sroa.34.0, <4 x float> %68)
  %scores.sroa.0.0.vec.extract925 = extractelement <4 x float> %69, i64 0
  %mul199.1674 = fmul contract float %scores.sroa.0.0.vec.extract925, 0x3FB99999A0000000
  %70 = tail call contract noundef float @llvm.minnum.f32(float %mul199.1674, float 0x4024CB5EC0000000)
  %71 = tail call contract noundef float @llvm.exp.f32(float %70)
  %scores.sroa.0.4.vec.extract1038 = extractelement <4 x float> %69, i64 1
  %mul199.1.1 = fmul contract float %scores.sroa.0.4.vec.extract1038, 0x3FB99999A0000000
  %72 = tail call contract noundef float @llvm.minnum.f32(float %mul199.1.1, float 0x4024CB5EC0000000)
  %73 = tail call contract noundef float @llvm.exp.f32(float %72)
  %scores.sroa.0.8.vec.extract1135 = extractelement <4 x float> %69, i64 2
  %mul199.2.1 = fmul contract float %scores.sroa.0.8.vec.extract1135, 0x3FB99999A0000000
  %74 = tail call contract noundef float @llvm.minnum.f32(float %mul199.2.1, float 0x4024CB5EC0000000)
  %75 = tail call contract noundef float @llvm.exp.f32(float %74)
  %scores.sroa.0.12.vec.extract1232 = extractelement <4 x float> %69, i64 3
  %mul199.3.1 = fmul contract float %scores.sroa.0.12.vec.extract1232, 0x3FB99999A0000000
  %76 = tail call contract noundef float @llvm.minnum.f32(float %mul199.3.1, float 0x4024CB5EC0000000)
  %77 = tail call contract noundef float @llvm.exp.f32(float %76)
  %add215.1675 = fadd contract float %sums.sroa.0.1, %71
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %71)
  %probs.sroa.0.0.vec.insert1341 = insertelement <4 x i16> poison, i16 %78, i64 0
  %add215.1.1 = fadd contract float %sums.sroa.24.1, %73
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %73)
  %probs.sroa.0.2.vec.insert1379 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1341, i16 %79, i64 1
  %add215.2.1 = fadd contract float %sums.sroa.46.1, %75
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %75)
  %probs.sroa.0.4.vec.insert1416 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1379, i16 %80, i64 2
  %add215.3.1 = fadd contract float %sums.sroa.68.1, %77
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %77)
  %probs.sroa.0.6.vec.insert1434 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1416, i16 %81, i64 3
  br label %if.end239.1

if.end239.1:                                      ; preds = %if.end239, %if.end173.1
  %sums.sroa.68.2 = phi float [ %add215.3.1, %if.end173.1 ], [ %sums.sroa.68.1, %if.end239 ]
  %sums.sroa.46.2 = phi float [ %add215.2.1, %if.end173.1 ], [ %sums.sroa.46.1, %if.end239 ]
  %sums.sroa.24.2 = phi float [ %add215.1.1, %if.end173.1 ], [ %sums.sroa.24.1, %if.end239 ]
  %sums.sroa.0.2 = phi float [ %add215.1675, %if.end173.1 ], [ %sums.sroa.0.1, %if.end239 ]
  %probs.sroa.0.1 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1434, %if.end173.1 ], [ zeroinitializer, %if.end239 ]
  %add249.1 = or disjoint i32 %and247, 256
  %add.ptr251.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add249.1
  store <4 x i16> %probs.sroa.0.1, ptr addrspace(3) %add.ptr251.1, align 8
  br label %if.end358

if.end358:                                        ; preds = %if.end, %if.end239.1
  %sums.sroa.68.3 = phi float [ 0.000000e+00, %if.end ], [ %sums.sroa.68.2, %if.end239.1 ]
  %sums.sroa.46.3 = phi float [ 0.000000e+00, %if.end ], [ %sums.sroa.46.2, %if.end239.1 ]
  %sums.sroa.24.3 = phi float [ 0.000000e+00, %if.end ], [ %sums.sroa.24.2, %if.end239.1 ]
  %sums.sroa.0.3 = phi float [ 0.000000e+00, %if.end ], [ %sums.sroa.0.2, %if.end239.1 ]
  %kr.sroa.57.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.57.0, %if.end239.1 ]
  %kr.sroa.47.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.47.0, %if.end239.1 ]
  %kr.sroa.42.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.42.0, %if.end239.1 ]
  %kr.sroa.32.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.32.0, %if.end239.1 ]
  %kr.sroa.27.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.27.0, %if.end239.1 ]
  %kr.sroa.17.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.17.0, %if.end239.1 ]
  %kr.sroa.12.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.12.0, %if.end239.1 ]
  %kr.sroa.0.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.0.0, %if.end239.1 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %cmp80, label %if.end255.1, label %for.cond83.preheader.1

for.cond83.preheader.1:                           ; preds = %if.end358
  %or.cond648.1683 = icmp ugt i32 %mul11.2, 1023
  %cmp96.not.1684 = icmp sgt i32 %mul11.2, %1
  %or.cond649.1685 = or i1 %or.cond648.1683, %cmp96.not.1684
  br i1 %or.cond649.1685, label %if.end124.1692, label %for.cond98.preheader.1688

for.cond98.preheader.1688:                        ; preds = %for.cond83.preheader.1
  %82 = shl nsw i32 %cond.i.i617.2, 10
  %mul105.1686 = and i32 %82, 64512
  %add106.1687 = or disjoint i32 %mul105.1686, %mul103
  %83 = zext nneg i32 %add106.1687 to i64
  %84 = or disjoint i64 %83, %26
  %add.ptr114.1689 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %84
  %kr.sroa.0.0.copyload1455 = load <4 x half>, ptr addrspace(4) %add.ptr114.1689, align 16
  %kr.sroa.12.0.add.ptr114.1689.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114.1689, i64 8
  %kr.sroa.12.0.copyload1459 = load <4 x half>, ptr addrspace(4) %kr.sroa.12.0.add.ptr114.1689.sroa_idx, align 8
  %85 = or disjoint i64 %83, %26
  %86 = or disjoint i64 %85, 512
  %add.ptr114.1.1690 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %86
  %kr.sroa.17.16.copyload1471 = load <4 x half>, ptr addrspace(4) %add.ptr114.1.1690, align 16
  %kr.sroa.27.16.add.ptr114.1.1690.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114.1.1690, i64 8
  %kr.sroa.27.16.copyload1475 = load <4 x half>, ptr addrspace(4) %kr.sroa.27.16.add.ptr114.1.1690.sroa_idx, align 8
  br label %if.end124.1692

if.end124.1692:                                   ; preds = %for.cond98.preheader.1688, %for.cond83.preheader.1
  %kr.sroa.27.2 = phi <4 x half> [ %kr.sroa.27.1, %for.cond83.preheader.1 ], [ %kr.sroa.27.16.copyload1475, %for.cond98.preheader.1688 ]
  %kr.sroa.17.2 = phi <4 x half> [ %kr.sroa.17.1, %for.cond83.preheader.1 ], [ %kr.sroa.17.16.copyload1471, %for.cond98.preheader.1688 ]
  %kr.sroa.12.2 = phi <4 x half> [ %kr.sroa.12.1, %for.cond83.preheader.1 ], [ %kr.sroa.12.0.copyload1459, %for.cond98.preheader.1688 ]
  %kr.sroa.0.2 = phi <4 x half> [ %kr.sroa.0.1, %for.cond83.preheader.1 ], [ %kr.sroa.0.0.copyload1455, %for.cond98.preheader.1688 ]
  %or.cond648.1.1 = icmp ugt i32 %mul11.3, 1023
  %cmp96.not.1.1 = icmp sgt i32 %mul11.3, %1
  %or.cond649.1.1 = or i1 %or.cond648.1.1, %cmp96.not.1.1
  br i1 %or.cond649.1.1, label %if.end124.1.1, label %for.cond98.preheader.1.1

for.cond98.preheader.1.1:                         ; preds = %if.end124.1692
  %87 = shl nsw i32 %cond.i.i617.3, 10
  %mul105.1.1 = and i32 %87, 64512
  %add106.1.1 = or disjoint i32 %mul105.1.1, %mul103
  %88 = zext nneg i32 %add106.1.1 to i64
  %89 = or disjoint i64 %88, %26
  %add.ptr114.1667.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %89
  %kr.sroa.32.32.copyload1487 = load <4 x half>, ptr addrspace(4) %add.ptr114.1667.1, align 16
  %kr.sroa.42.32.add.ptr114.1667.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114.1667.1, i64 8
  %kr.sroa.42.32.copyload1491 = load <4 x half>, ptr addrspace(4) %kr.sroa.42.32.add.ptr114.1667.1.sroa_idx, align 8
  %90 = or disjoint i64 %88, %26
  %91 = or disjoint i64 %90, 512
  %add.ptr114.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %91
  %kr.sroa.47.48.copyload1503 = load <4 x half>, ptr addrspace(4) %add.ptr114.1.1.1, align 16
  %kr.sroa.57.48.add.ptr114.1.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114.1.1.1, i64 8
  %kr.sroa.57.48.copyload1507 = load <4 x half>, ptr addrspace(4) %kr.sroa.57.48.add.ptr114.1.1.1.sroa_idx, align 8
  br label %if.end124.1.1

if.end124.1.1:                                    ; preds = %for.cond98.preheader.1.1, %if.end124.1692
  %kr.sroa.57.2 = phi <4 x half> [ %kr.sroa.57.1, %if.end124.1692 ], [ %kr.sroa.57.48.copyload1507, %for.cond98.preheader.1.1 ]
  %kr.sroa.47.2 = phi <4 x half> [ %kr.sroa.47.1, %if.end124.1692 ], [ %kr.sroa.47.48.copyload1503, %for.cond98.preheader.1.1 ]
  %kr.sroa.42.2 = phi <4 x half> [ %kr.sroa.42.1, %if.end124.1692 ], [ %kr.sroa.42.32.copyload1491, %for.cond98.preheader.1.1 ]
  %kr.sroa.32.2 = phi <4 x half> [ %kr.sroa.32.1, %if.end124.1692 ], [ %kr.sroa.32.32.copyload1487, %for.cond98.preheader.1.1 ]
  br i1 %or.cond649.1685, label %if.end239.1748, label %if.then142.1698

if.then142.1698:                                  ; preds = %if.end124.1.1
  %cmp145.1697 = icmp sgt i32 %mul11.2, %invariant.op
  br i1 %cmp145.1697, label %for.cond147.preheader.1701, label %if.end173.1718

for.cond147.preheader.1701:                       ; preds = %if.then142.1698
  %add155.1700 = or disjoint i32 %mul11.2, %mul154
  %cmp158.not.1702 = icmp sgt i32 %add155.1700, %1
  %spec.select.1703 = select i1 %cmp158.not.1702, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert933 = insertelement <4 x float> poison, float %spec.select.1703, i64 0
  %cmp158.not.1.1705.not = icmp slt i32 %add155.1700, %1
  %spec.select.1.1706 = select i1 %cmp158.not.1.1705.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1044 = insertelement <4 x float> %scores.sroa.0.0.vec.insert933, float %spec.select.1.1706, i64 1
  %add156.2.1708 = or disjoint i32 %add155.1700, 2
  %cmp158.not.2.1709 = icmp sgt i32 %add156.2.1708, %1
  %spec.select.2.1710 = select i1 %cmp158.not.2.1709, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1141 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1044, float %spec.select.2.1710, i64 2
  %add156.3.1712 = or disjoint i32 %add155.1700, 3
  %cmp158.not.3.1713 = icmp sgt i32 %add156.3.1712, %1
  %spec.select.3.1714 = select i1 %cmp158.not.3.1713, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1238 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1141, float %spec.select.3.1714, i64 3
  br label %if.end173.1718

if.end173.1718:                                   ; preds = %if.then142.1698, %for.cond147.preheader.1701
  %scores.sroa.0.5 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1238, %for.cond147.preheader.1701 ], [ zeroinitializer, %if.then142.1698 ]
  %92 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.2, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.5)
  %93 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.12.2, <4 x half> %qr.sroa.13.0, <4 x float> %92)
  %94 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.17.2, <4 x half> %qr.sroa.23.0, <4 x float> %93)
  %95 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.27.2, <4 x half> %qr.sroa.34.0, <4 x float> %94)
  %scores.sroa.0.0.vec.extract935 = extractelement <4 x float> %95, i64 0
  %mul199.1723 = fmul contract float %scores.sroa.0.0.vec.extract935, 0x3FB99999A0000000
  %96 = tail call contract noundef float @llvm.minnum.f32(float %mul199.1723, float 0x4024CB5EC0000000)
  %97 = tail call contract noundef float @llvm.exp.f32(float %96)
  %scores.sroa.0.4.vec.extract1046 = extractelement <4 x float> %95, i64 1
  %mul199.1.1725 = fmul contract float %scores.sroa.0.4.vec.extract1046, 0x3FB99999A0000000
  %98 = tail call contract noundef float @llvm.minnum.f32(float %mul199.1.1725, float 0x4024CB5EC0000000)
  %99 = tail call contract noundef float @llvm.exp.f32(float %98)
  %scores.sroa.0.8.vec.extract1143 = extractelement <4 x float> %95, i64 2
  %mul199.2.1727 = fmul contract float %scores.sroa.0.8.vec.extract1143, 0x3FB99999A0000000
  %100 = tail call contract noundef float @llvm.minnum.f32(float %mul199.2.1727, float 0x4024CB5EC0000000)
  %101 = tail call contract noundef float @llvm.exp.f32(float %100)
  %scores.sroa.0.12.vec.extract1240 = extractelement <4 x float> %95, i64 3
  %mul199.3.1729 = fmul contract float %scores.sroa.0.12.vec.extract1240, 0x3FB99999A0000000
  %102 = tail call contract noundef float @llvm.minnum.f32(float %mul199.3.1729, float 0x4024CB5EC0000000)
  %103 = tail call contract noundef float @llvm.exp.f32(float %102)
  %add215.1731 = fadd contract float %sums.sroa.0.3, %97
  %104 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %97)
  %probs.sroa.0.0.vec.insert1343 = insertelement <4 x i16> poison, i16 %104, i64 0
  %add215.1.1734 = fadd contract float %sums.sroa.24.3, %99
  %105 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %99)
  %probs.sroa.0.2.vec.insert1381 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1343, i16 %105, i64 1
  %add215.2.1738 = fadd contract float %sums.sroa.46.3, %101
  %106 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %101)
  %probs.sroa.0.4.vec.insert1418 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1381, i16 %106, i64 2
  %add215.3.1742 = fadd contract float %sums.sroa.68.3, %103
  %107 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %103)
  %probs.sroa.0.6.vec.insert1436 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1418, i16 %107, i64 3
  br label %if.end239.1748

if.end239.1748:                                   ; preds = %if.end124.1.1, %if.end173.1718
  %sums.sroa.68.4 = phi float [ %add215.3.1742, %if.end173.1718 ], [ %sums.sroa.68.3, %if.end124.1.1 ]
  %sums.sroa.46.4 = phi float [ %add215.2.1738, %if.end173.1718 ], [ %sums.sroa.46.3, %if.end124.1.1 ]
  %sums.sroa.24.4 = phi float [ %add215.1.1734, %if.end173.1718 ], [ %sums.sroa.24.3, %if.end124.1.1 ]
  %sums.sroa.0.4 = phi float [ %add215.1731, %if.end173.1718 ], [ %sums.sroa.0.3, %if.end124.1.1 ]
  %probs.sroa.0.6 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1436, %if.end173.1718 ], [ zeroinitializer, %if.end124.1.1 ]
  %add249.1746 = or disjoint i32 %and247, 512
  %add.ptr251.1747 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add249.1746
  store <4 x i16> %probs.sroa.0.6, ptr addrspace(3) %add.ptr251.1747, align 8
  br i1 %or.cond649.1.1, label %if.end239.1.1, label %if.then142.1.1

if.then142.1.1:                                   ; preds = %if.end239.1748
  %cmp145.1.1 = icmp sgt i32 %mul11.3, %invariant.op
  br i1 %cmp145.1.1, label %for.cond147.preheader.1.1, label %if.end173.1.1

for.cond147.preheader.1.1:                        ; preds = %if.then142.1.1
  %add155.1.1 = or disjoint i32 %mul11.3, %mul154
  %cmp158.not.1670.1 = icmp sgt i32 %add155.1.1, %1
  %spec.select.1671.1 = select i1 %cmp158.not.1670.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert943 = insertelement <4 x float> poison, float %spec.select.1671.1, i64 0
  %cmp158.not.1.1.1.not = icmp slt i32 %add155.1.1, %1
  %spec.select.1.1.1 = select i1 %cmp158.not.1.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1052 = insertelement <4 x float> %scores.sroa.0.0.vec.insert943, float %spec.select.1.1.1, i64 1
  %add156.2.1.1 = or disjoint i32 %add155.1.1, 2
  %cmp158.not.2.1.1 = icmp sgt i32 %add156.2.1.1, %1
  %spec.select.2.1.1 = select i1 %cmp158.not.2.1.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1149 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1052, float %spec.select.2.1.1, i64 2
  %add156.3.1.1 = or disjoint i32 %add155.1.1, 3
  %cmp158.not.3.1.1 = icmp sgt i32 %add156.3.1.1, %1
  %spec.select.3.1.1 = select i1 %cmp158.not.3.1.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1246 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1149, float %spec.select.3.1.1, i64 3
  br label %if.end173.1.1

if.end173.1.1:                                    ; preds = %if.then142.1.1, %for.cond147.preheader.1.1
  %scores.sroa.0.7 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1246, %for.cond147.preheader.1.1 ], [ zeroinitializer, %if.then142.1.1 ]
  %108 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.32.2, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.7)
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.42.2, <4 x half> %qr.sroa.13.0, <4 x float> %108)
  %110 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.2, <4 x half> %qr.sroa.23.0, <4 x float> %109)
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.57.2, <4 x half> %qr.sroa.34.0, <4 x float> %110)
  %scores.sroa.0.0.vec.extract945 = extractelement <4 x float> %111, i64 0
  %mul199.1674.1 = fmul contract float %scores.sroa.0.0.vec.extract945, 0x3FB99999A0000000
  %112 = tail call contract noundef float @llvm.minnum.f32(float %mul199.1674.1, float 0x4024CB5EC0000000)
  %113 = tail call contract noundef float @llvm.exp.f32(float %112)
  %scores.sroa.0.4.vec.extract1054 = extractelement <4 x float> %111, i64 1
  %mul199.1.1.1 = fmul contract float %scores.sroa.0.4.vec.extract1054, 0x3FB99999A0000000
  %114 = tail call contract noundef float @llvm.minnum.f32(float %mul199.1.1.1, float 0x4024CB5EC0000000)
  %115 = tail call contract noundef float @llvm.exp.f32(float %114)
  %scores.sroa.0.8.vec.extract1151 = extractelement <4 x float> %111, i64 2
  %mul199.2.1.1 = fmul contract float %scores.sroa.0.8.vec.extract1151, 0x3FB99999A0000000
  %116 = tail call contract noundef float @llvm.minnum.f32(float %mul199.2.1.1, float 0x4024CB5EC0000000)
  %117 = tail call contract noundef float @llvm.exp.f32(float %116)
  %scores.sroa.0.12.vec.extract1248 = extractelement <4 x float> %111, i64 3
  %mul199.3.1.1 = fmul contract float %scores.sroa.0.12.vec.extract1248, 0x3FB99999A0000000
  %118 = tail call contract noundef float @llvm.minnum.f32(float %mul199.3.1.1, float 0x4024CB5EC0000000)
  %119 = tail call contract noundef float @llvm.exp.f32(float %118)
  %add215.1675.1 = fadd contract float %sums.sroa.0.4, %113
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %113)
  %probs.sroa.0.0.vec.insert1345 = insertelement <4 x i16> poison, i16 %120, i64 0
  %add215.1.1.1 = fadd contract float %sums.sroa.24.4, %115
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %115)
  %probs.sroa.0.2.vec.insert1383 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1345, i16 %121, i64 1
  %add215.2.1.1 = fadd contract float %sums.sroa.46.4, %117
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %117)
  %probs.sroa.0.4.vec.insert1420 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1383, i16 %122, i64 2
  %add215.3.1.1 = fadd contract float %sums.sroa.68.4, %119
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %119)
  %probs.sroa.0.6.vec.insert1438 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1420, i16 %123, i64 3
  br label %if.end239.1.1

if.end239.1.1:                                    ; preds = %if.end239.1748, %if.end173.1.1
  %sums.sroa.68.5 = phi float [ %add215.3.1.1, %if.end173.1.1 ], [ %sums.sroa.68.4, %if.end239.1748 ]
  %sums.sroa.46.5 = phi float [ %add215.2.1.1, %if.end173.1.1 ], [ %sums.sroa.46.4, %if.end239.1748 ]
  %sums.sroa.24.5 = phi float [ %add215.1.1.1, %if.end173.1.1 ], [ %sums.sroa.24.4, %if.end239.1748 ]
  %sums.sroa.0.5 = phi float [ %add215.1675.1, %if.end173.1.1 ], [ %sums.sroa.0.4, %if.end239.1748 ]
  %probs.sroa.0.7 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1438, %if.end173.1.1 ], [ zeroinitializer, %if.end239.1748 ]
  %add249.1.1 = or disjoint i32 %and247, 768
  %add.ptr251.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add249.1.1
  store <4 x i16> %probs.sroa.0.7, ptr addrspace(3) %add.ptr251.1.1, align 8
  br label %if.end255.1

if.end255.1:                                      ; preds = %if.end239.1.1, %if.end358
  %sums.sroa.68.6 = phi float [ %sums.sroa.68.3, %if.end358 ], [ %sums.sroa.68.5, %if.end239.1.1 ]
  %sums.sroa.46.6 = phi float [ %sums.sroa.46.3, %if.end358 ], [ %sums.sroa.46.5, %if.end239.1.1 ]
  %sums.sroa.24.6 = phi float [ %sums.sroa.24.3, %if.end358 ], [ %sums.sroa.24.5, %if.end239.1.1 ]
  %sums.sroa.0.6 = phi float [ %sums.sroa.0.3, %if.end358 ], [ %sums.sroa.0.5, %if.end239.1.1 ]
  %kr.sroa.57.3 = phi <4 x half> [ %kr.sroa.57.1, %if.end358 ], [ %kr.sroa.57.2, %if.end239.1.1 ]
  %kr.sroa.47.3 = phi <4 x half> [ %kr.sroa.47.1, %if.end358 ], [ %kr.sroa.47.2, %if.end239.1.1 ]
  %kr.sroa.42.3 = phi <4 x half> [ %kr.sroa.42.1, %if.end358 ], [ %kr.sroa.42.2, %if.end239.1.1 ]
  %kr.sroa.32.3 = phi <4 x half> [ %kr.sroa.32.1, %if.end358 ], [ %kr.sroa.32.2, %if.end239.1.1 ]
  %kr.sroa.27.3 = phi <4 x half> [ %kr.sroa.27.1, %if.end358 ], [ %kr.sroa.27.2, %if.end239.1.1 ]
  %kr.sroa.17.3 = phi <4 x half> [ %kr.sroa.17.1, %if.end358 ], [ %kr.sroa.17.2, %if.end239.1.1 ]
  %kr.sroa.12.3 = phi <4 x half> [ %kr.sroa.12.1, %if.end358 ], [ %kr.sroa.12.2, %if.end239.1.1 ]
  %kr.sroa.0.3 = phi <4 x half> [ %kr.sroa.0.1, %if.end358 ], [ %kr.sroa.0.2, %if.end239.1.1 ]
  br i1 %cmp258.not, label %for.cond262.preheader.1, label %if.end358.1

for.cond262.preheader.1:                          ; preds = %if.end255.1
  %or.cond652.1750 = icmp ugt i32 %mul11, 1023
  %cmp275.not.1751 = icmp sgt i32 %mul11, %1
  %or.cond653.1752 = or i1 %or.cond652.1750, %cmp275.not.1751
  br i1 %or.cond653.1752, label %if.end354.1778, label %for.cond316.preheader.1770

for.cond316.preheader.1770:                       ; preds = %for.cond262.preheader.1
  %add.ptr311.1760 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul308
  %124 = load <4 x half>, ptr addrspace(3) %add.ptr311.1760, align 8
  %125 = shl nsw i32 %cond.i.i617, 10
  %mul284.1753 = and i32 %125, 64512
  %add285.1754 = or disjoint i32 %mul284.1753, %mul103
  %126 = zext nneg i32 %add285.1754 to i64
  %127 = or disjoint i64 %126, %27
  %128 = or disjoint i64 %127, 512
  %add.ptr293.1.1757 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %128
  %vr.sroa.82.16.add.ptr293.1.1757.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr293.1.1757, i64 8
  %vr.sroa.82.16.copyload876 = load <4 x half>, ptr addrspace(4) %vr.sroa.82.16.add.ptr293.1.1757.sroa_idx, align 8
  %vr.sroa.52.16.copyload867 = load <4 x half>, ptr addrspace(4) %add.ptr293.1.1757, align 16
  %129 = or disjoint i64 %126, %27
  %add.ptr293.1756 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %129
  %vr.sroa.32.0.add.ptr293.1756.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr293.1756, i64 8
  %vr.sroa.32.0.copyload820 = load <4 x half>, ptr addrspace(4) %vr.sroa.32.0.add.ptr293.1756.sroa_idx, align 8
  %vr.sroa.0.0.copyload811 = load <4 x half>, ptr addrspace(4) %add.ptr293.1756, align 16
  %130 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload811, <4 x half> %124, <4 x float> zeroinitializer), !call_argsrelate !163
  %131 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.32.0.copyload820, <4 x half> %124, <4 x float> zeroinitializer), !call_argsrelate !163
  %132 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.52.16.copyload867, <4 x half> %124, <4 x float> zeroinitializer), !call_argsrelate !163
  %133 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.82.16.copyload876, <4 x half> %124, <4 x float> zeroinitializer), !call_argsrelate !163
  br label %if.end354.1778

if.end354.1778:                                   ; preds = %for.cond316.preheader.1770, %for.cond262.preheader.1
  %out.sroa.98.4 = phi <4 x float> [ zeroinitializer, %for.cond262.preheader.1 ], [ %133, %for.cond316.preheader.1770 ]
  %out.sroa.66.4 = phi <4 x float> [ zeroinitializer, %for.cond262.preheader.1 ], [ %132, %for.cond316.preheader.1770 ]
  %out.sroa.34.4 = phi <4 x float> [ zeroinitializer, %for.cond262.preheader.1 ], [ %131, %for.cond316.preheader.1770 ]
  %out.sroa.0.4 = phi <4 x float> [ zeroinitializer, %for.cond262.preheader.1 ], [ %130, %for.cond316.preheader.1770 ]
  %or.cond652.1.1 = icmp ugt i32 %mul11.1, 1023
  %cmp275.not.1.1 = icmp sgt i32 %mul11.1, %1
  %or.cond653.1.1 = or i1 %or.cond652.1.1, %cmp275.not.1.1
  br i1 %or.cond653.1.1, label %if.end358.1, label %for.cond335.preheader.1.1

for.cond335.preheader.1.1:                        ; preds = %if.end354.1778
  %add.ptr311.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and247
  %134 = load <4 x half>, ptr addrspace(3) %add.ptr311.1.1, align 8
  %135 = shl nsw i32 %cond.i.i617.1, 10
  %mul284.1.1 = and i32 %135, 64512
  %add285.1.1 = or disjoint i32 %mul284.1.1, %mul103
  %136 = zext nneg i32 %add285.1.1 to i64
  %137 = or disjoint i64 %136, %27
  %138 = or disjoint i64 %137, 512
  %add.ptr293.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %138
  %vr.sroa.82.16.add.ptr293.1.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr293.1.1.1, i64 8
  %vr.sroa.82.16.copyload877 = load <4 x half>, ptr addrspace(4) %vr.sroa.82.16.add.ptr293.1.1.1.sroa_idx, align 8
  %vr.sroa.52.16.copyload868 = load <4 x half>, ptr addrspace(4) %add.ptr293.1.1.1, align 16
  %139 = or disjoint i64 %136, %27
  %add.ptr293.1681.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %139
  %vr.sroa.32.0.add.ptr293.1681.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr293.1681.1, i64 8
  %vr.sroa.32.0.copyload821 = load <4 x half>, ptr addrspace(4) %vr.sroa.32.0.add.ptr293.1681.1.sroa_idx, align 8
  %vr.sroa.0.0.copyload812 = load <4 x half>, ptr addrspace(4) %add.ptr293.1681.1, align 16
  %140 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload812, <4 x half> %134, <4 x float> zeroinitializer), !call_argsrelate !163
  %141 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.32.0.copyload821, <4 x half> %134, <4 x float> zeroinitializer), !call_argsrelate !163
  %142 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.52.16.copyload868, <4 x half> %134, <4 x float> zeroinitializer), !call_argsrelate !163
  %143 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.82.16.copyload877, <4 x half> %134, <4 x float> zeroinitializer), !call_argsrelate !163
  br label %if.end358.1

if.end358.1:                                      ; preds = %if.end354.1778, %for.cond335.preheader.1.1, %if.end255.1
  %out.sroa.98.6 = phi <4 x float> [ zeroinitializer, %if.end255.1 ], [ %out.sroa.98.4, %for.cond335.preheader.1.1 ], [ %out.sroa.98.4, %if.end354.1778 ]
  %out.sroa.66.6 = phi <4 x float> [ zeroinitializer, %if.end255.1 ], [ %out.sroa.66.4, %for.cond335.preheader.1.1 ], [ %out.sroa.66.4, %if.end354.1778 ]
  %out.sroa.34.6 = phi <4 x float> [ zeroinitializer, %if.end255.1 ], [ %out.sroa.34.4, %for.cond335.preheader.1.1 ], [ %out.sroa.34.4, %if.end354.1778 ]
  %out.sroa.0.6 = phi <4 x float> [ zeroinitializer, %if.end255.1 ], [ %out.sroa.0.4, %for.cond335.preheader.1.1 ], [ %out.sroa.0.4, %if.end354.1778 ]
  %out_1.sroa.86.6 = phi <4 x float> [ zeroinitializer, %if.end255.1 ], [ %143, %for.cond335.preheader.1.1 ], [ zeroinitializer, %if.end354.1778 ]
  %out_1.sroa.58.6 = phi <4 x float> [ zeroinitializer, %if.end255.1 ], [ %142, %for.cond335.preheader.1.1 ], [ zeroinitializer, %if.end354.1778 ]
  %out_1.sroa.30.6 = phi <4 x float> [ zeroinitializer, %if.end255.1 ], [ %141, %for.cond335.preheader.1.1 ], [ zeroinitializer, %if.end354.1778 ]
  %out_1.sroa.0.6 = phi <4 x float> [ zeroinitializer, %if.end255.1 ], [ %140, %for.cond335.preheader.1.1 ], [ zeroinitializer, %if.end354.1778 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %cmp80, label %if.end255.2, label %for.cond83.preheader.2

for.cond83.preheader.2:                           ; preds = %if.end358.1
  %or.cond648.2 = icmp ugt i32 %mul11.4, 1023
  %cmp96.not.2 = icmp sgt i32 %mul11.4, %1
  %or.cond649.2 = or i1 %or.cond648.2, %cmp96.not.2
  br i1 %or.cond649.2, label %if.end124.2, label %for.cond98.preheader.2

for.cond98.preheader.2:                           ; preds = %for.cond83.preheader.2
  %144 = shl nsw i32 %cond.i.i617.4, 10
  %mul105.2 = and i32 %144, 64512
  %add106.2 = or disjoint i32 %mul105.2, %mul103
  %145 = zext nneg i32 %add106.2 to i64
  %146 = or disjoint i64 %145, %26
  %add.ptr114.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %146
  %kr.sroa.0.0.copyload1456 = load <4 x half>, ptr addrspace(4) %add.ptr114.2, align 16
  %kr.sroa.12.0.add.ptr114.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114.2, i64 8
  %kr.sroa.12.0.copyload1460 = load <4 x half>, ptr addrspace(4) %kr.sroa.12.0.add.ptr114.2.sroa_idx, align 8
  %147 = or disjoint i64 %145, %26
  %148 = or disjoint i64 %147, 512
  %add.ptr114.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %148
  %kr.sroa.17.16.copyload1472 = load <4 x half>, ptr addrspace(4) %add.ptr114.1.2, align 16
  %kr.sroa.27.16.add.ptr114.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114.1.2, i64 8
  %kr.sroa.27.16.copyload1476 = load <4 x half>, ptr addrspace(4) %kr.sroa.27.16.add.ptr114.1.2.sroa_idx, align 8
  br label %if.end124.2

if.end124.2:                                      ; preds = %for.cond98.preheader.2, %for.cond83.preheader.2
  %kr.sroa.27.4 = phi <4 x half> [ %kr.sroa.27.3, %for.cond83.preheader.2 ], [ %kr.sroa.27.16.copyload1476, %for.cond98.preheader.2 ]
  %kr.sroa.17.4 = phi <4 x half> [ %kr.sroa.17.3, %for.cond83.preheader.2 ], [ %kr.sroa.17.16.copyload1472, %for.cond98.preheader.2 ]
  %kr.sroa.12.4 = phi <4 x half> [ %kr.sroa.12.3, %for.cond83.preheader.2 ], [ %kr.sroa.12.0.copyload1460, %for.cond98.preheader.2 ]
  %kr.sroa.0.4 = phi <4 x half> [ %kr.sroa.0.3, %for.cond83.preheader.2 ], [ %kr.sroa.0.0.copyload1456, %for.cond98.preheader.2 ]
  %or.cond648.1.2 = icmp ugt i32 %mul11.5, 1023
  %cmp96.not.1.2 = icmp sgt i32 %mul11.5, %1
  %or.cond649.1.2 = or i1 %or.cond648.1.2, %cmp96.not.1.2
  br i1 %or.cond649.1.2, label %if.end124.1.2, label %for.cond98.preheader.1.2

for.cond98.preheader.1.2:                         ; preds = %if.end124.2
  %149 = shl nsw i32 %cond.i.i617.5, 10
  %mul105.1.2 = and i32 %149, 64512
  %add106.1.2 = or disjoint i32 %mul105.1.2, %mul103
  %150 = zext nneg i32 %add106.1.2 to i64
  %151 = or disjoint i64 %150, %26
  %add.ptr114.1667.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %151
  %kr.sroa.32.32.copyload1488 = load <4 x half>, ptr addrspace(4) %add.ptr114.1667.2, align 16
  %kr.sroa.42.32.add.ptr114.1667.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114.1667.2, i64 8
  %kr.sroa.42.32.copyload1492 = load <4 x half>, ptr addrspace(4) %kr.sroa.42.32.add.ptr114.1667.2.sroa_idx, align 8
  %152 = or disjoint i64 %150, %26
  %153 = or disjoint i64 %152, 512
  %add.ptr114.1.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %153
  %kr.sroa.47.48.copyload1504 = load <4 x half>, ptr addrspace(4) %add.ptr114.1.1.2, align 16
  %kr.sroa.57.48.add.ptr114.1.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114.1.1.2, i64 8
  %kr.sroa.57.48.copyload1508 = load <4 x half>, ptr addrspace(4) %kr.sroa.57.48.add.ptr114.1.1.2.sroa_idx, align 8
  br label %if.end124.1.2

if.end124.1.2:                                    ; preds = %for.cond98.preheader.1.2, %if.end124.2
  %kr.sroa.57.4 = phi <4 x half> [ %kr.sroa.57.3, %if.end124.2 ], [ %kr.sroa.57.48.copyload1508, %for.cond98.preheader.1.2 ]
  %kr.sroa.47.4 = phi <4 x half> [ %kr.sroa.47.3, %if.end124.2 ], [ %kr.sroa.47.48.copyload1504, %for.cond98.preheader.1.2 ]
  %kr.sroa.42.4 = phi <4 x half> [ %kr.sroa.42.3, %if.end124.2 ], [ %kr.sroa.42.32.copyload1492, %for.cond98.preheader.1.2 ]
  %kr.sroa.32.4 = phi <4 x half> [ %kr.sroa.32.3, %if.end124.2 ], [ %kr.sroa.32.32.copyload1488, %for.cond98.preheader.1.2 ]
  br i1 %or.cond649.2, label %if.end239.2, label %if.then142.2

if.then142.2:                                     ; preds = %if.end124.1.2
  %cmp145.2 = icmp sgt i32 %mul11.4, %invariant.op
  br i1 %cmp145.2, label %for.cond147.preheader.2, label %if.end173.2

for.cond147.preheader.2:                          ; preds = %if.then142.2
  %add155.2 = or disjoint i32 %mul11.4, %mul154
  %cmp158.not.2779 = icmp sgt i32 %add155.2, %1
  %spec.select.2780 = select i1 %cmp158.not.2779, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert953 = insertelement <4 x float> poison, float %spec.select.2780, i64 0
  %cmp158.not.1.2.not = icmp slt i32 %add155.2, %1
  %spec.select.1.2 = select i1 %cmp158.not.1.2.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1060 = insertelement <4 x float> %scores.sroa.0.0.vec.insert953, float %spec.select.1.2, i64 1
  %add156.2.2 = or disjoint i32 %add155.2, 2
  %cmp158.not.2.2 = icmp sgt i32 %add156.2.2, %1
  %spec.select.2.2 = select i1 %cmp158.not.2.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1157 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1060, float %spec.select.2.2, i64 2
  %add156.3.2 = or disjoint i32 %add155.2, 3
  %cmp158.not.3.2 = icmp sgt i32 %add156.3.2, %1
  %spec.select.3.2 = select i1 %cmp158.not.3.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1254 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1157, float %spec.select.3.2, i64 3
  br label %if.end173.2

if.end173.2:                                      ; preds = %if.then142.2, %for.cond147.preheader.2
  %scores.sroa.0.10 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1254, %for.cond147.preheader.2 ], [ zeroinitializer, %if.then142.2 ]
  %154 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.4, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.10)
  %155 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.12.4, <4 x half> %qr.sroa.13.0, <4 x float> %154)
  %156 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.17.4, <4 x half> %qr.sroa.23.0, <4 x float> %155)
  %157 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.27.4, <4 x half> %qr.sroa.34.0, <4 x float> %156)
  %scores.sroa.0.0.vec.extract955 = extractelement <4 x float> %157, i64 0
  %mul199.2781 = fmul contract float %scores.sroa.0.0.vec.extract955, 0x3FB99999A0000000
  %158 = tail call contract noundef float @llvm.minnum.f32(float %mul199.2781, float 0x4024CB5EC0000000)
  %159 = tail call contract noundef float @llvm.exp.f32(float %158)
  %scores.sroa.0.4.vec.extract1062 = extractelement <4 x float> %157, i64 1
  %mul199.1.2 = fmul contract float %scores.sroa.0.4.vec.extract1062, 0x3FB99999A0000000
  %160 = tail call contract noundef float @llvm.minnum.f32(float %mul199.1.2, float 0x4024CB5EC0000000)
  %161 = tail call contract noundef float @llvm.exp.f32(float %160)
  %scores.sroa.0.8.vec.extract1159 = extractelement <4 x float> %157, i64 2
  %mul199.2.2 = fmul contract float %scores.sroa.0.8.vec.extract1159, 0x3FB99999A0000000
  %162 = tail call contract noundef float @llvm.minnum.f32(float %mul199.2.2, float 0x4024CB5EC0000000)
  %163 = tail call contract noundef float @llvm.exp.f32(float %162)
  %scores.sroa.0.12.vec.extract1256 = extractelement <4 x float> %157, i64 3
  %mul199.3.2 = fmul contract float %scores.sroa.0.12.vec.extract1256, 0x3FB99999A0000000
  %164 = tail call contract noundef float @llvm.minnum.f32(float %mul199.3.2, float 0x4024CB5EC0000000)
  %165 = tail call contract noundef float @llvm.exp.f32(float %164)
  %add215.2782 = fadd contract float %sums.sroa.0.6, %159
  %166 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %159)
  %probs.sroa.0.0.vec.insert1347 = insertelement <4 x i16> poison, i16 %166, i64 0
  %add215.1.2 = fadd contract float %sums.sroa.24.6, %161
  %167 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %161)
  %probs.sroa.0.2.vec.insert1385 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1347, i16 %167, i64 1
  %add215.2.2 = fadd contract float %sums.sroa.46.6, %163
  %168 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %163)
  %probs.sroa.0.4.vec.insert1422 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1385, i16 %168, i64 2
  %add215.3.2 = fadd contract float %sums.sroa.68.6, %165
  %169 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %165)
  %probs.sroa.0.6.vec.insert1440 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1422, i16 %169, i64 3
  br label %if.end239.2

if.end239.2:                                      ; preds = %if.end124.1.2, %if.end173.2
  %sums.sroa.68.7 = phi float [ %add215.3.2, %if.end173.2 ], [ %sums.sroa.68.6, %if.end124.1.2 ]
  %sums.sroa.46.7 = phi float [ %add215.2.2, %if.end173.2 ], [ %sums.sroa.46.6, %if.end124.1.2 ]
  %sums.sroa.24.7 = phi float [ %add215.1.2, %if.end173.2 ], [ %sums.sroa.24.6, %if.end124.1.2 ]
  %sums.sroa.0.7 = phi float [ %add215.2782, %if.end173.2 ], [ %sums.sroa.0.6, %if.end124.1.2 ]
  %probs.sroa.0.12 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1440, %if.end173.2 ], [ zeroinitializer, %if.end124.1.2 ]
  %add.ptr251.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and247
  store <4 x i16> %probs.sroa.0.12, ptr addrspace(3) %add.ptr251.2, align 8
  br i1 %or.cond649.1.2, label %if.end239.1.2, label %if.then142.1.2

if.then142.1.2:                                   ; preds = %if.end239.2
  %cmp145.1.2 = icmp sgt i32 %mul11.5, %invariant.op
  br i1 %cmp145.1.2, label %for.cond147.preheader.1.2, label %if.end173.1.2

for.cond147.preheader.1.2:                        ; preds = %if.then142.1.2
  %add155.1.2 = or disjoint i32 %mul11.5, %mul154
  %cmp158.not.1670.2 = icmp sgt i32 %add155.1.2, %1
  %spec.select.1671.2 = select i1 %cmp158.not.1670.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert963 = insertelement <4 x float> poison, float %spec.select.1671.2, i64 0
  %cmp158.not.1.1.2.not = icmp slt i32 %add155.1.2, %1
  %spec.select.1.1.2 = select i1 %cmp158.not.1.1.2.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1068 = insertelement <4 x float> %scores.sroa.0.0.vec.insert963, float %spec.select.1.1.2, i64 1
  %add156.2.1.2 = or disjoint i32 %add155.1.2, 2
  %cmp158.not.2.1.2 = icmp sgt i32 %add156.2.1.2, %1
  %spec.select.2.1.2 = select i1 %cmp158.not.2.1.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1165 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1068, float %spec.select.2.1.2, i64 2
  %add156.3.1.2 = or disjoint i32 %add155.1.2, 3
  %cmp158.not.3.1.2 = icmp sgt i32 %add156.3.1.2, %1
  %spec.select.3.1.2 = select i1 %cmp158.not.3.1.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1262 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1165, float %spec.select.3.1.2, i64 3
  br label %if.end173.1.2

if.end173.1.2:                                    ; preds = %if.then142.1.2, %for.cond147.preheader.1.2
  %scores.sroa.0.12 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1262, %for.cond147.preheader.1.2 ], [ zeroinitializer, %if.then142.1.2 ]
  %170 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.32.4, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.12)
  %171 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.42.4, <4 x half> %qr.sroa.13.0, <4 x float> %170)
  %172 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.4, <4 x half> %qr.sroa.23.0, <4 x float> %171)
  %173 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.57.4, <4 x half> %qr.sroa.34.0, <4 x float> %172)
  %scores.sroa.0.0.vec.extract965 = extractelement <4 x float> %173, i64 0
  %mul199.1674.2 = fmul contract float %scores.sroa.0.0.vec.extract965, 0x3FB99999A0000000
  %174 = tail call contract noundef float @llvm.minnum.f32(float %mul199.1674.2, float 0x4024CB5EC0000000)
  %175 = tail call contract noundef float @llvm.exp.f32(float %174)
  %scores.sroa.0.4.vec.extract1070 = extractelement <4 x float> %173, i64 1
  %mul199.1.1.2 = fmul contract float %scores.sroa.0.4.vec.extract1070, 0x3FB99999A0000000
  %176 = tail call contract noundef float @llvm.minnum.f32(float %mul199.1.1.2, float 0x4024CB5EC0000000)
  %177 = tail call contract noundef float @llvm.exp.f32(float %176)
  %scores.sroa.0.8.vec.extract1167 = extractelement <4 x float> %173, i64 2
  %mul199.2.1.2 = fmul contract float %scores.sroa.0.8.vec.extract1167, 0x3FB99999A0000000
  %178 = tail call contract noundef float @llvm.minnum.f32(float %mul199.2.1.2, float 0x4024CB5EC0000000)
  %179 = tail call contract noundef float @llvm.exp.f32(float %178)
  %scores.sroa.0.12.vec.extract1264 = extractelement <4 x float> %173, i64 3
  %mul199.3.1.2 = fmul contract float %scores.sroa.0.12.vec.extract1264, 0x3FB99999A0000000
  %180 = tail call contract noundef float @llvm.minnum.f32(float %mul199.3.1.2, float 0x4024CB5EC0000000)
  %181 = tail call contract noundef float @llvm.exp.f32(float %180)
  %add215.1675.2 = fadd contract float %sums.sroa.0.7, %175
  %182 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %175)
  %probs.sroa.0.0.vec.insert1349 = insertelement <4 x i16> poison, i16 %182, i64 0
  %add215.1.1.2 = fadd contract float %sums.sroa.24.7, %177
  %183 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %177)
  %probs.sroa.0.2.vec.insert1387 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1349, i16 %183, i64 1
  %add215.2.1.2 = fadd contract float %sums.sroa.46.7, %179
  %184 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %179)
  %probs.sroa.0.4.vec.insert1424 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1387, i16 %184, i64 2
  %add215.3.1.2 = fadd contract float %sums.sroa.68.7, %181
  %185 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %181)
  %probs.sroa.0.6.vec.insert1442 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1424, i16 %185, i64 3
  br label %if.end239.1.2

if.end239.1.2:                                    ; preds = %if.end239.2, %if.end173.1.2
  %sums.sroa.68.8 = phi float [ %add215.3.1.2, %if.end173.1.2 ], [ %sums.sroa.68.7, %if.end239.2 ]
  %sums.sroa.46.8 = phi float [ %add215.2.1.2, %if.end173.1.2 ], [ %sums.sroa.46.7, %if.end239.2 ]
  %sums.sroa.24.8 = phi float [ %add215.1.1.2, %if.end173.1.2 ], [ %sums.sroa.24.7, %if.end239.2 ]
  %sums.sroa.0.8 = phi float [ %add215.1675.2, %if.end173.1.2 ], [ %sums.sroa.0.7, %if.end239.2 ]
  %probs.sroa.0.13 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1442, %if.end173.1.2 ], [ zeroinitializer, %if.end239.2 ]
  %add249.1.2 = or disjoint i32 %and247, 256
  %add.ptr251.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add249.1.2
  store <4 x i16> %probs.sroa.0.13, ptr addrspace(3) %add.ptr251.1.2, align 8
  br label %if.end255.2

if.end255.2:                                      ; preds = %if.end239.1.2, %if.end358.1
  %sums.sroa.68.9 = phi float [ %sums.sroa.68.6, %if.end358.1 ], [ %sums.sroa.68.8, %if.end239.1.2 ]
  %sums.sroa.46.9 = phi float [ %sums.sroa.46.6, %if.end358.1 ], [ %sums.sroa.46.8, %if.end239.1.2 ]
  %sums.sroa.24.9 = phi float [ %sums.sroa.24.6, %if.end358.1 ], [ %sums.sroa.24.8, %if.end239.1.2 ]
  %sums.sroa.0.9 = phi float [ %sums.sroa.0.6, %if.end358.1 ], [ %sums.sroa.0.8, %if.end239.1.2 ]
  %kr.sroa.57.5 = phi <4 x half> [ %kr.sroa.57.3, %if.end358.1 ], [ %kr.sroa.57.4, %if.end239.1.2 ]
  %kr.sroa.47.5 = phi <4 x half> [ %kr.sroa.47.3, %if.end358.1 ], [ %kr.sroa.47.4, %if.end239.1.2 ]
  %kr.sroa.42.5 = phi <4 x half> [ %kr.sroa.42.3, %if.end358.1 ], [ %kr.sroa.42.4, %if.end239.1.2 ]
  %kr.sroa.32.5 = phi <4 x half> [ %kr.sroa.32.3, %if.end358.1 ], [ %kr.sroa.32.4, %if.end239.1.2 ]
  %kr.sroa.27.5 = phi <4 x half> [ %kr.sroa.27.3, %if.end358.1 ], [ %kr.sroa.27.4, %if.end239.1.2 ]
  %kr.sroa.17.5 = phi <4 x half> [ %kr.sroa.17.3, %if.end358.1 ], [ %kr.sroa.17.4, %if.end239.1.2 ]
  %kr.sroa.12.5 = phi <4 x half> [ %kr.sroa.12.3, %if.end358.1 ], [ %kr.sroa.12.4, %if.end239.1.2 ]
  %kr.sroa.0.5 = phi <4 x half> [ %kr.sroa.0.3, %if.end358.1 ], [ %kr.sroa.0.4, %if.end239.1.2 ]
  br i1 %cmp258.not, label %for.cond262.preheader.2, label %if.end358.2

for.cond262.preheader.2:                          ; preds = %if.end255.2
  %or.cond652.2 = icmp ugt i32 %mul11.2, 1023
  %cmp275.not.2 = icmp sgt i32 %mul11.2, %1
  %or.cond653.2 = or i1 %or.cond652.2, %cmp275.not.2
  br i1 %or.cond653.2, label %if.end354.2, label %for.cond316.preheader.2

for.cond316.preheader.2:                          ; preds = %for.cond262.preheader.2
  %add309.2 = or disjoint i32 %mul308, 512
  %add.ptr311.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add309.2
  %186 = load <4 x half>, ptr addrspace(3) %add.ptr311.2, align 8
  %187 = shl nsw i32 %cond.i.i617.2, 10
  %mul284.2 = and i32 %187, 64512
  %add285.2 = or disjoint i32 %mul284.2, %mul103
  %188 = zext nneg i32 %add285.2 to i64
  %189 = or disjoint i64 %188, %27
  %190 = or disjoint i64 %189, 512
  %add.ptr293.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %190
  %vr.sroa.82.16.add.ptr293.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr293.1.2, i64 8
  %vr.sroa.82.16.copyload878 = load <4 x half>, ptr addrspace(4) %vr.sroa.82.16.add.ptr293.1.2.sroa_idx, align 8
  %vr.sroa.52.16.copyload869 = load <4 x half>, ptr addrspace(4) %add.ptr293.1.2, align 16
  %191 = or disjoint i64 %188, %27
  %add.ptr293.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %191
  %vr.sroa.32.0.add.ptr293.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr293.2, i64 8
  %vr.sroa.32.0.copyload822 = load <4 x half>, ptr addrspace(4) %vr.sroa.32.0.add.ptr293.2.sroa_idx, align 8
  %vr.sroa.0.0.copyload813 = load <4 x half>, ptr addrspace(4) %add.ptr293.2, align 16
  %192 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload813, <4 x half> %186, <4 x float> %out.sroa.0.6), !call_argsrelate !163
  %193 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.32.0.copyload822, <4 x half> %186, <4 x float> %out.sroa.34.6), !call_argsrelate !163
  %194 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.52.16.copyload869, <4 x half> %186, <4 x float> %out.sroa.66.6), !call_argsrelate !163
  %195 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.82.16.copyload878, <4 x half> %186, <4 x float> %out.sroa.98.6), !call_argsrelate !163
  br label %if.end354.2

if.end354.2:                                      ; preds = %for.cond316.preheader.2, %for.cond262.preheader.2
  %out.sroa.98.7 = phi <4 x float> [ %out.sroa.98.6, %for.cond262.preheader.2 ], [ %195, %for.cond316.preheader.2 ]
  %out.sroa.66.7 = phi <4 x float> [ %out.sroa.66.6, %for.cond262.preheader.2 ], [ %194, %for.cond316.preheader.2 ]
  %out.sroa.34.7 = phi <4 x float> [ %out.sroa.34.6, %for.cond262.preheader.2 ], [ %193, %for.cond316.preheader.2 ]
  %out.sroa.0.7 = phi <4 x float> [ %out.sroa.0.6, %for.cond262.preheader.2 ], [ %192, %for.cond316.preheader.2 ]
  %or.cond652.1.2 = icmp ugt i32 %mul11.3, 1023
  %cmp275.not.1.2 = icmp sgt i32 %mul11.3, %1
  %or.cond653.1.2 = or i1 %or.cond652.1.2, %cmp275.not.1.2
  br i1 %or.cond653.1.2, label %if.end358.2, label %for.cond335.preheader.1.2

for.cond335.preheader.1.2:                        ; preds = %if.end354.2
  %add309.1.2 = or disjoint i32 %and247, 512
  %add.ptr311.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add309.1.2
  %196 = load <4 x half>, ptr addrspace(3) %add.ptr311.1.2, align 8
  %197 = shl nsw i32 %cond.i.i617.3, 10
  %mul284.1.2 = and i32 %197, 64512
  %add285.1.2 = or disjoint i32 %mul284.1.2, %mul103
  %198 = zext nneg i32 %add285.1.2 to i64
  %199 = or disjoint i64 %198, %27
  %200 = or disjoint i64 %199, 512
  %add.ptr293.1.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %200
  %vr.sroa.82.16.add.ptr293.1.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr293.1.1.2, i64 8
  %vr.sroa.82.16.copyload879 = load <4 x half>, ptr addrspace(4) %vr.sroa.82.16.add.ptr293.1.1.2.sroa_idx, align 8
  %vr.sroa.52.16.copyload870 = load <4 x half>, ptr addrspace(4) %add.ptr293.1.1.2, align 16
  %201 = or disjoint i64 %198, %27
  %add.ptr293.1681.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %201
  %vr.sroa.32.0.add.ptr293.1681.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr293.1681.2, i64 8
  %vr.sroa.32.0.copyload823 = load <4 x half>, ptr addrspace(4) %vr.sroa.32.0.add.ptr293.1681.2.sroa_idx, align 8
  %vr.sroa.0.0.copyload814 = load <4 x half>, ptr addrspace(4) %add.ptr293.1681.2, align 16
  %202 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload814, <4 x half> %196, <4 x float> %out_1.sroa.0.6), !call_argsrelate !163
  %203 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.32.0.copyload823, <4 x half> %196, <4 x float> %out_1.sroa.30.6), !call_argsrelate !163
  %204 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.52.16.copyload870, <4 x half> %196, <4 x float> %out_1.sroa.58.6), !call_argsrelate !163
  %205 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.82.16.copyload879, <4 x half> %196, <4 x float> %out_1.sroa.86.6), !call_argsrelate !163
  br label %if.end358.2

if.end358.2:                                      ; preds = %if.end354.2, %for.cond335.preheader.1.2, %if.end255.2
  %out.sroa.98.9 = phi <4 x float> [ %out.sroa.98.6, %if.end255.2 ], [ %out.sroa.98.7, %for.cond335.preheader.1.2 ], [ %out.sroa.98.7, %if.end354.2 ]
  %out.sroa.66.9 = phi <4 x float> [ %out.sroa.66.6, %if.end255.2 ], [ %out.sroa.66.7, %for.cond335.preheader.1.2 ], [ %out.sroa.66.7, %if.end354.2 ]
  %out.sroa.34.9 = phi <4 x float> [ %out.sroa.34.6, %if.end255.2 ], [ %out.sroa.34.7, %for.cond335.preheader.1.2 ], [ %out.sroa.34.7, %if.end354.2 ]
  %out.sroa.0.9 = phi <4 x float> [ %out.sroa.0.6, %if.end255.2 ], [ %out.sroa.0.7, %for.cond335.preheader.1.2 ], [ %out.sroa.0.7, %if.end354.2 ]
  %out_1.sroa.86.9 = phi <4 x float> [ %out_1.sroa.86.6, %if.end255.2 ], [ %205, %for.cond335.preheader.1.2 ], [ %out_1.sroa.86.6, %if.end354.2 ]
  %out_1.sroa.58.9 = phi <4 x float> [ %out_1.sroa.58.6, %if.end255.2 ], [ %204, %for.cond335.preheader.1.2 ], [ %out_1.sroa.58.6, %if.end354.2 ]
  %out_1.sroa.30.9 = phi <4 x float> [ %out_1.sroa.30.6, %if.end255.2 ], [ %203, %for.cond335.preheader.1.2 ], [ %out_1.sroa.30.6, %if.end354.2 ]
  %out_1.sroa.0.9 = phi <4 x float> [ %out_1.sroa.0.6, %if.end255.2 ], [ %202, %for.cond335.preheader.1.2 ], [ %out_1.sroa.0.6, %if.end354.2 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %cmp80, label %if.end255.3, label %for.cond83.preheader.3

for.cond83.preheader.3:                           ; preds = %if.end358.2
  %or.cond648.3 = icmp ugt i32 %mul11.6, 1023
  %cmp96.not.3 = icmp sgt i32 %mul11.6, %1
  %or.cond649.3 = or i1 %or.cond648.3, %cmp96.not.3
  br i1 %or.cond649.3, label %if.end124.3, label %for.cond98.preheader.3

for.cond98.preheader.3:                           ; preds = %for.cond83.preheader.3
  %206 = shl nsw i32 %cond.i.i617.6, 10
  %mul105.3 = and i32 %206, 64512
  %add106.3 = or disjoint i32 %mul105.3, %mul103
  %207 = zext nneg i32 %add106.3 to i64
  %208 = or disjoint i64 %207, %26
  %add.ptr114.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %208
  %kr.sroa.0.0.copyload1457 = load <4 x half>, ptr addrspace(4) %add.ptr114.3, align 16
  %kr.sroa.12.0.add.ptr114.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114.3, i64 8
  %kr.sroa.12.0.copyload1461 = load <4 x half>, ptr addrspace(4) %kr.sroa.12.0.add.ptr114.3.sroa_idx, align 8
  %209 = or disjoint i64 %207, %26
  %210 = or disjoint i64 %209, 512
  %add.ptr114.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %210
  %kr.sroa.17.16.copyload1473 = load <4 x half>, ptr addrspace(4) %add.ptr114.1.3, align 16
  %kr.sroa.27.16.add.ptr114.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114.1.3, i64 8
  %kr.sroa.27.16.copyload1477 = load <4 x half>, ptr addrspace(4) %kr.sroa.27.16.add.ptr114.1.3.sroa_idx, align 8
  br label %if.end124.3

if.end124.3:                                      ; preds = %for.cond98.preheader.3, %for.cond83.preheader.3
  %kr.sroa.27.6 = phi <4 x half> [ %kr.sroa.27.5, %for.cond83.preheader.3 ], [ %kr.sroa.27.16.copyload1477, %for.cond98.preheader.3 ]
  %kr.sroa.17.6 = phi <4 x half> [ %kr.sroa.17.5, %for.cond83.preheader.3 ], [ %kr.sroa.17.16.copyload1473, %for.cond98.preheader.3 ]
  %kr.sroa.12.6 = phi <4 x half> [ %kr.sroa.12.5, %for.cond83.preheader.3 ], [ %kr.sroa.12.0.copyload1461, %for.cond98.preheader.3 ]
  %kr.sroa.0.6 = phi <4 x half> [ %kr.sroa.0.5, %for.cond83.preheader.3 ], [ %kr.sroa.0.0.copyload1457, %for.cond98.preheader.3 ]
  %or.cond648.1.3 = icmp ugt i32 %mul11.7, 1023
  %cmp96.not.1.3 = icmp sgt i32 %mul11.7, %1
  %or.cond649.1.3 = or i1 %or.cond648.1.3, %cmp96.not.1.3
  br i1 %or.cond649.1.3, label %if.end124.1.3, label %for.cond98.preheader.1.3

for.cond98.preheader.1.3:                         ; preds = %if.end124.3
  %211 = shl nsw i32 %cond.i.i617.7, 10
  %mul105.1.3 = and i32 %211, 64512
  %add106.1.3 = or disjoint i32 %mul105.1.3, %mul103
  %212 = zext nneg i32 %add106.1.3 to i64
  %213 = or disjoint i64 %212, %26
  %add.ptr114.1667.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %213
  %kr.sroa.32.32.copyload1489 = load <4 x half>, ptr addrspace(4) %add.ptr114.1667.3, align 16
  %kr.sroa.42.32.add.ptr114.1667.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114.1667.3, i64 8
  %kr.sroa.42.32.copyload1493 = load <4 x half>, ptr addrspace(4) %kr.sroa.42.32.add.ptr114.1667.3.sroa_idx, align 8
  %214 = or disjoint i64 %212, %26
  %215 = or disjoint i64 %214, 512
  %add.ptr114.1.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %215
  %kr.sroa.47.48.copyload1505 = load <4 x half>, ptr addrspace(4) %add.ptr114.1.1.3, align 16
  %kr.sroa.57.48.add.ptr114.1.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr114.1.1.3, i64 8
  %kr.sroa.57.48.copyload1509 = load <4 x half>, ptr addrspace(4) %kr.sroa.57.48.add.ptr114.1.1.3.sroa_idx, align 8
  br label %if.end124.1.3

if.end124.1.3:                                    ; preds = %for.cond98.preheader.1.3, %if.end124.3
  %kr.sroa.57.6 = phi <4 x half> [ %kr.sroa.57.5, %if.end124.3 ], [ %kr.sroa.57.48.copyload1509, %for.cond98.preheader.1.3 ]
  %kr.sroa.47.6 = phi <4 x half> [ %kr.sroa.47.5, %if.end124.3 ], [ %kr.sroa.47.48.copyload1505, %for.cond98.preheader.1.3 ]
  %kr.sroa.42.6 = phi <4 x half> [ %kr.sroa.42.5, %if.end124.3 ], [ %kr.sroa.42.32.copyload1493, %for.cond98.preheader.1.3 ]
  %kr.sroa.32.6 = phi <4 x half> [ %kr.sroa.32.5, %if.end124.3 ], [ %kr.sroa.32.32.copyload1489, %for.cond98.preheader.1.3 ]
  br i1 %or.cond649.3, label %if.end239.3, label %if.then142.3

if.then142.3:                                     ; preds = %if.end124.1.3
  %cmp145.3 = icmp sgt i32 %mul11.6, %invariant.op
  br i1 %cmp145.3, label %for.cond147.preheader.3, label %if.end173.3

for.cond147.preheader.3:                          ; preds = %if.then142.3
  %add155.3 = or disjoint i32 %mul11.6, %mul154
  %cmp158.not.3783 = icmp sgt i32 %add155.3, %1
  %spec.select.3784 = select i1 %cmp158.not.3783, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert973 = insertelement <4 x float> poison, float %spec.select.3784, i64 0
  %cmp158.not.1.3.not = icmp slt i32 %add155.3, %1
  %spec.select.1.3 = select i1 %cmp158.not.1.3.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1076 = insertelement <4 x float> %scores.sroa.0.0.vec.insert973, float %spec.select.1.3, i64 1
  %add156.2.3 = or disjoint i32 %add155.3, 2
  %cmp158.not.2.3 = icmp sgt i32 %add156.2.3, %1
  %spec.select.2.3 = select i1 %cmp158.not.2.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1173 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1076, float %spec.select.2.3, i64 2
  %add156.3.3 = or disjoint i32 %add155.3, 3
  %cmp158.not.3.3 = icmp sgt i32 %add156.3.3, %1
  %spec.select.3.3 = select i1 %cmp158.not.3.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1270 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1173, float %spec.select.3.3, i64 3
  br label %if.end173.3

if.end173.3:                                      ; preds = %if.then142.3, %for.cond147.preheader.3
  %scores.sroa.0.15 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1270, %for.cond147.preheader.3 ], [ zeroinitializer, %if.then142.3 ]
  %216 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.6, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.15)
  %217 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.12.6, <4 x half> %qr.sroa.13.0, <4 x float> %216)
  %218 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.17.6, <4 x half> %qr.sroa.23.0, <4 x float> %217)
  %219 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.27.6, <4 x half> %qr.sroa.34.0, <4 x float> %218)
  %scores.sroa.0.0.vec.extract975 = extractelement <4 x float> %219, i64 0
  %mul199.3785 = fmul contract float %scores.sroa.0.0.vec.extract975, 0x3FB99999A0000000
  %220 = tail call contract noundef float @llvm.minnum.f32(float %mul199.3785, float 0x4024CB5EC0000000)
  %221 = tail call contract noundef float @llvm.exp.f32(float %220)
  %scores.sroa.0.4.vec.extract1078 = extractelement <4 x float> %219, i64 1
  %mul199.1.3 = fmul contract float %scores.sroa.0.4.vec.extract1078, 0x3FB99999A0000000
  %222 = tail call contract noundef float @llvm.minnum.f32(float %mul199.1.3, float 0x4024CB5EC0000000)
  %223 = tail call contract noundef float @llvm.exp.f32(float %222)
  %scores.sroa.0.8.vec.extract1175 = extractelement <4 x float> %219, i64 2
  %mul199.2.3 = fmul contract float %scores.sroa.0.8.vec.extract1175, 0x3FB99999A0000000
  %224 = tail call contract noundef float @llvm.minnum.f32(float %mul199.2.3, float 0x4024CB5EC0000000)
  %225 = tail call contract noundef float @llvm.exp.f32(float %224)
  %scores.sroa.0.12.vec.extract1272 = extractelement <4 x float> %219, i64 3
  %mul199.3.3 = fmul contract float %scores.sroa.0.12.vec.extract1272, 0x3FB99999A0000000
  %226 = tail call contract noundef float @llvm.minnum.f32(float %mul199.3.3, float 0x4024CB5EC0000000)
  %227 = tail call contract noundef float @llvm.exp.f32(float %226)
  %add215.3786 = fadd contract float %sums.sroa.0.9, %221
  %228 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %221)
  %probs.sroa.0.0.vec.insert1351 = insertelement <4 x i16> poison, i16 %228, i64 0
  %add215.1.3 = fadd contract float %sums.sroa.24.9, %223
  %229 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %223)
  %probs.sroa.0.2.vec.insert1389 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1351, i16 %229, i64 1
  %add215.2.3 = fadd contract float %sums.sroa.46.9, %225
  %230 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %225)
  %probs.sroa.0.4.vec.insert1426 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1389, i16 %230, i64 2
  %add215.3.3 = fadd contract float %sums.sroa.68.9, %227
  %231 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %227)
  %probs.sroa.0.6.vec.insert1444 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1426, i16 %231, i64 3
  br label %if.end239.3

if.end239.3:                                      ; preds = %if.end124.1.3, %if.end173.3
  %sums.sroa.68.10 = phi float [ %add215.3.3, %if.end173.3 ], [ %sums.sroa.68.9, %if.end124.1.3 ]
  %sums.sroa.46.10 = phi float [ %add215.2.3, %if.end173.3 ], [ %sums.sroa.46.9, %if.end124.1.3 ]
  %sums.sroa.24.10 = phi float [ %add215.1.3, %if.end173.3 ], [ %sums.sroa.24.9, %if.end124.1.3 ]
  %sums.sroa.0.10 = phi float [ %add215.3786, %if.end173.3 ], [ %sums.sroa.0.9, %if.end124.1.3 ]
  %probs.sroa.0.18 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1444, %if.end173.3 ], [ zeroinitializer, %if.end124.1.3 ]
  %add249.3 = or disjoint i32 %and247, 512
  %add.ptr251.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add249.3
  store <4 x i16> %probs.sroa.0.18, ptr addrspace(3) %add.ptr251.3, align 8
  br i1 %or.cond649.1.3, label %if.end239.1.3, label %if.then142.1.3

if.then142.1.3:                                   ; preds = %if.end239.3
  %cmp145.1.3 = icmp sgt i32 %mul11.7, %invariant.op
  br i1 %cmp145.1.3, label %for.cond147.preheader.1.3, label %if.end173.1.3

for.cond147.preheader.1.3:                        ; preds = %if.then142.1.3
  %add155.1.3 = or disjoint i32 %mul11.7, %mul154
  %cmp158.not.1670.3 = icmp sgt i32 %add155.1.3, %1
  %spec.select.1671.3 = select i1 %cmp158.not.1670.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert983 = insertelement <4 x float> poison, float %spec.select.1671.3, i64 0
  %cmp158.not.1.1.3.not = icmp slt i32 %add155.1.3, %1
  %spec.select.1.1.3 = select i1 %cmp158.not.1.1.3.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1084 = insertelement <4 x float> %scores.sroa.0.0.vec.insert983, float %spec.select.1.1.3, i64 1
  %add156.2.1.3 = or disjoint i32 %add155.1.3, 2
  %cmp158.not.2.1.3 = icmp sgt i32 %add156.2.1.3, %1
  %spec.select.2.1.3 = select i1 %cmp158.not.2.1.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1181 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1084, float %spec.select.2.1.3, i64 2
  %add156.3.1.3 = or disjoint i32 %add155.1.3, 3
  %cmp158.not.3.1.3 = icmp sgt i32 %add156.3.1.3, %1
  %spec.select.3.1.3 = select i1 %cmp158.not.3.1.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1278 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1181, float %spec.select.3.1.3, i64 3
  br label %if.end173.1.3

if.end173.1.3:                                    ; preds = %if.then142.1.3, %for.cond147.preheader.1.3
  %scores.sroa.0.17 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1278, %for.cond147.preheader.1.3 ], [ zeroinitializer, %if.then142.1.3 ]
  %232 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.32.6, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.17)
  %233 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.42.6, <4 x half> %qr.sroa.13.0, <4 x float> %232)
  %234 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.6, <4 x half> %qr.sroa.23.0, <4 x float> %233)
  %235 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.57.6, <4 x half> %qr.sroa.34.0, <4 x float> %234)
  %scores.sroa.0.0.vec.extract985 = extractelement <4 x float> %235, i64 0
  %mul199.1674.3 = fmul contract float %scores.sroa.0.0.vec.extract985, 0x3FB99999A0000000
  %236 = tail call contract noundef float @llvm.minnum.f32(float %mul199.1674.3, float 0x4024CB5EC0000000)
  %237 = tail call contract noundef float @llvm.exp.f32(float %236)
  %scores.sroa.0.4.vec.extract1086 = extractelement <4 x float> %235, i64 1
  %mul199.1.1.3 = fmul contract float %scores.sroa.0.4.vec.extract1086, 0x3FB99999A0000000
  %238 = tail call contract noundef float @llvm.minnum.f32(float %mul199.1.1.3, float 0x4024CB5EC0000000)
  %239 = tail call contract noundef float @llvm.exp.f32(float %238)
  %scores.sroa.0.8.vec.extract1183 = extractelement <4 x float> %235, i64 2
  %mul199.2.1.3 = fmul contract float %scores.sroa.0.8.vec.extract1183, 0x3FB99999A0000000
  %240 = tail call contract noundef float @llvm.minnum.f32(float %mul199.2.1.3, float 0x4024CB5EC0000000)
  %241 = tail call contract noundef float @llvm.exp.f32(float %240)
  %scores.sroa.0.12.vec.extract1280 = extractelement <4 x float> %235, i64 3
  %mul199.3.1.3 = fmul contract float %scores.sroa.0.12.vec.extract1280, 0x3FB99999A0000000
  %242 = tail call contract noundef float @llvm.minnum.f32(float %mul199.3.1.3, float 0x4024CB5EC0000000)
  %243 = tail call contract noundef float @llvm.exp.f32(float %242)
  %add215.1675.3 = fadd contract float %sums.sroa.0.10, %237
  %244 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %237)
  %probs.sroa.0.0.vec.insert1353 = insertelement <4 x i16> poison, i16 %244, i64 0
  %add215.1.1.3 = fadd contract float %sums.sroa.24.10, %239
  %245 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %239)
  %probs.sroa.0.2.vec.insert1391 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1353, i16 %245, i64 1
  %add215.2.1.3 = fadd contract float %sums.sroa.46.10, %241
  %246 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %241)
  %probs.sroa.0.4.vec.insert1428 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1391, i16 %246, i64 2
  %add215.3.1.3 = fadd contract float %sums.sroa.68.10, %243
  %247 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %243)
  %probs.sroa.0.6.vec.insert1446 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1428, i16 %247, i64 3
  %248 = bitcast <4 x i16> %probs.sroa.0.6.vec.insert1446 to i64
  br label %if.end239.1.3

if.end239.1.3:                                    ; preds = %if.end239.3, %if.end173.1.3
  %sums.sroa.68.11 = phi float [ %add215.3.1.3, %if.end173.1.3 ], [ %sums.sroa.68.10, %if.end239.3 ]
  %sums.sroa.46.11 = phi float [ %add215.2.1.3, %if.end173.1.3 ], [ %sums.sroa.46.10, %if.end239.3 ]
  %sums.sroa.24.11 = phi float [ %add215.1.1.3, %if.end173.1.3 ], [ %sums.sroa.24.10, %if.end239.3 ]
  %sums.sroa.0.11 = phi float [ %add215.1675.3, %if.end173.1.3 ], [ %sums.sroa.0.10, %if.end239.3 ]
  %probs.sroa.0.19 = phi i64 [ %248, %if.end173.1.3 ], [ 0, %if.end239.3 ]
  %add249.1.3 = or disjoint i32 %and247, 768
  %add.ptr251.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add249.1.3
  store i64 %probs.sroa.0.19, ptr addrspace(3) %add.ptr251.1.3, align 8
  br label %if.end255.3

if.end255.3:                                      ; preds = %if.end239.1.3, %if.end358.2
  %sums.sroa.68.12 = phi float [ %sums.sroa.68.9, %if.end358.2 ], [ %sums.sroa.68.11, %if.end239.1.3 ]
  %sums.sroa.46.12 = phi float [ %sums.sroa.46.9, %if.end358.2 ], [ %sums.sroa.46.11, %if.end239.1.3 ]
  %sums.sroa.24.12 = phi float [ %sums.sroa.24.9, %if.end358.2 ], [ %sums.sroa.24.11, %if.end239.1.3 ]
  %sums.sroa.0.12 = phi float [ %sums.sroa.0.9, %if.end358.2 ], [ %sums.sroa.0.11, %if.end239.1.3 ]
  br i1 %cmp258.not, label %for.cond262.preheader.3, label %if.end358.3

for.cond262.preheader.3:                          ; preds = %if.end255.3
  %or.cond652.3 = icmp ugt i32 %mul11.4, 1023
  %cmp275.not.3 = icmp sgt i32 %mul11.4, %1
  %or.cond653.3 = or i1 %or.cond652.3, %cmp275.not.3
  br i1 %or.cond653.3, label %if.end354.3, label %for.cond316.preheader.3

for.cond316.preheader.3:                          ; preds = %for.cond262.preheader.3
  %add.ptr311.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul308
  %249 = load <4 x half>, ptr addrspace(3) %add.ptr311.3, align 8
  %250 = shl nsw i32 %cond.i.i617.4, 10
  %mul284.3 = and i32 %250, 64512
  %add285.3 = or disjoint i32 %mul284.3, %mul103
  %251 = zext nneg i32 %add285.3 to i64
  %252 = or disjoint i64 %251, %27
  %253 = or disjoint i64 %252, 512
  %add.ptr293.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %253
  %vr.sroa.82.16.add.ptr293.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr293.1.3, i64 8
  %vr.sroa.82.16.copyload880 = load <4 x half>, ptr addrspace(4) %vr.sroa.82.16.add.ptr293.1.3.sroa_idx, align 8
  %vr.sroa.52.16.copyload871 = load <4 x half>, ptr addrspace(4) %add.ptr293.1.3, align 16
  %254 = or disjoint i64 %251, %27
  %add.ptr293.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %254
  %vr.sroa.32.0.add.ptr293.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr293.3, i64 8
  %vr.sroa.32.0.copyload824 = load <4 x half>, ptr addrspace(4) %vr.sroa.32.0.add.ptr293.3.sroa_idx, align 8
  %vr.sroa.0.0.copyload815 = load <4 x half>, ptr addrspace(4) %add.ptr293.3, align 16
  %255 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload815, <4 x half> %249, <4 x float> %out.sroa.0.9), !call_argsrelate !163
  %256 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.32.0.copyload824, <4 x half> %249, <4 x float> %out.sroa.34.9), !call_argsrelate !163
  %257 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.52.16.copyload871, <4 x half> %249, <4 x float> %out.sroa.66.9), !call_argsrelate !163
  %258 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.82.16.copyload880, <4 x half> %249, <4 x float> %out.sroa.98.9), !call_argsrelate !163
  br label %if.end354.3

if.end354.3:                                      ; preds = %for.cond316.preheader.3, %for.cond262.preheader.3
  %out.sroa.98.10 = phi <4 x float> [ %out.sroa.98.9, %for.cond262.preheader.3 ], [ %258, %for.cond316.preheader.3 ]
  %out.sroa.66.10 = phi <4 x float> [ %out.sroa.66.9, %for.cond262.preheader.3 ], [ %257, %for.cond316.preheader.3 ]
  %out.sroa.34.10 = phi <4 x float> [ %out.sroa.34.9, %for.cond262.preheader.3 ], [ %256, %for.cond316.preheader.3 ]
  %out.sroa.0.10 = phi <4 x float> [ %out.sroa.0.9, %for.cond262.preheader.3 ], [ %255, %for.cond316.preheader.3 ]
  %or.cond652.1.3 = icmp ugt i32 %mul11.5, 1023
  %cmp275.not.1.3 = icmp sgt i32 %mul11.5, %1
  %or.cond653.1.3 = or i1 %or.cond652.1.3, %cmp275.not.1.3
  br i1 %or.cond653.1.3, label %if.end358.3, label %for.cond335.preheader.1.3

for.cond335.preheader.1.3:                        ; preds = %if.end354.3
  %add.ptr311.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and247
  %259 = load <4 x half>, ptr addrspace(3) %add.ptr311.1.3, align 8
  %260 = shl nsw i32 %cond.i.i617.5, 10
  %mul284.1.3 = and i32 %260, 64512
  %add285.1.3 = or disjoint i32 %mul284.1.3, %mul103
  %261 = zext nneg i32 %add285.1.3 to i64
  %262 = or disjoint i64 %261, %27
  %263 = or disjoint i64 %262, 512
  %add.ptr293.1.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %263
  %vr.sroa.82.16.add.ptr293.1.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr293.1.1.3, i64 8
  %vr.sroa.82.16.copyload881 = load <4 x half>, ptr addrspace(4) %vr.sroa.82.16.add.ptr293.1.1.3.sroa_idx, align 8
  %vr.sroa.52.16.copyload872 = load <4 x half>, ptr addrspace(4) %add.ptr293.1.1.3, align 16
  %264 = or disjoint i64 %261, %27
  %add.ptr293.1681.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %264
  %vr.sroa.32.0.add.ptr293.1681.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr293.1681.3, i64 8
  %vr.sroa.32.0.copyload825 = load <4 x half>, ptr addrspace(4) %vr.sroa.32.0.add.ptr293.1681.3.sroa_idx, align 8
  %vr.sroa.0.0.copyload816 = load <4 x half>, ptr addrspace(4) %add.ptr293.1681.3, align 16
  %265 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload816, <4 x half> %259, <4 x float> %out_1.sroa.0.9), !call_argsrelate !163
  %266 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.32.0.copyload825, <4 x half> %259, <4 x float> %out_1.sroa.30.9), !call_argsrelate !163
  %267 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.52.16.copyload872, <4 x half> %259, <4 x float> %out_1.sroa.58.9), !call_argsrelate !163
  %268 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.82.16.copyload881, <4 x half> %259, <4 x float> %out_1.sroa.86.9), !call_argsrelate !163
  br label %if.end358.3

if.end358.3:                                      ; preds = %if.end354.3, %for.cond335.preheader.1.3, %if.end255.3
  %out.sroa.98.12 = phi <4 x float> [ %out.sroa.98.9, %if.end255.3 ], [ %out.sroa.98.10, %for.cond335.preheader.1.3 ], [ %out.sroa.98.10, %if.end354.3 ]
  %out.sroa.66.12 = phi <4 x float> [ %out.sroa.66.9, %if.end255.3 ], [ %out.sroa.66.10, %for.cond335.preheader.1.3 ], [ %out.sroa.66.10, %if.end354.3 ]
  %out.sroa.34.12 = phi <4 x float> [ %out.sroa.34.9, %if.end255.3 ], [ %out.sroa.34.10, %for.cond335.preheader.1.3 ], [ %out.sroa.34.10, %if.end354.3 ]
  %out.sroa.0.12 = phi <4 x float> [ %out.sroa.0.9, %if.end255.3 ], [ %out.sroa.0.10, %for.cond335.preheader.1.3 ], [ %out.sroa.0.10, %if.end354.3 ]
  %out_1.sroa.86.12 = phi <4 x float> [ %out_1.sroa.86.9, %if.end255.3 ], [ %268, %for.cond335.preheader.1.3 ], [ %out_1.sroa.86.9, %if.end354.3 ]
  %out_1.sroa.58.12 = phi <4 x float> [ %out_1.sroa.58.9, %if.end255.3 ], [ %267, %for.cond335.preheader.1.3 ], [ %out_1.sroa.58.9, %if.end354.3 ]
  %out_1.sroa.30.12 = phi <4 x float> [ %out_1.sroa.30.9, %if.end255.3 ], [ %266, %for.cond335.preheader.1.3 ], [ %out_1.sroa.30.9, %if.end354.3 ]
  %out_1.sroa.0.12 = phi <4 x float> [ %out_1.sroa.0.9, %if.end255.3 ], [ %265, %for.cond335.preheader.1.3 ], [ %out_1.sroa.0.9, %if.end354.3 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br label %if.end255.4

if.end255.4:                                      ; preds = %if.end358.3
  br i1 %cmp258.not, label %for.cond262.preheader.4, label %if.end358.4

for.cond262.preheader.4:                          ; preds = %if.end255.4
  %or.cond652.4 = icmp ugt i32 %mul11.6, 1023
  %cmp275.not.4 = icmp sgt i32 %mul11.6, %1
  %or.cond653.4 = or i1 %or.cond652.4, %cmp275.not.4
  br i1 %or.cond653.4, label %if.end354.4, label %for.cond316.preheader.4

for.cond316.preheader.4:                          ; preds = %for.cond262.preheader.4
  %add309.4 = or disjoint i32 %mul308, 512
  %add.ptr311.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add309.4
  %269 = load <4 x half>, ptr addrspace(3) %add.ptr311.4, align 8
  %270 = shl nsw i32 %cond.i.i617.6, 10
  %mul284.4 = and i32 %270, 64512
  %add285.4 = or disjoint i32 %mul284.4, %mul103
  %271 = zext nneg i32 %add285.4 to i64
  %272 = or disjoint i64 %271, %27
  %273 = or disjoint i64 %272, 512
  %add.ptr293.1.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %273
  %vr.sroa.82.16.add.ptr293.1.4.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr293.1.4, i64 8
  %vr.sroa.82.16.copyload882 = load <4 x half>, ptr addrspace(4) %vr.sroa.82.16.add.ptr293.1.4.sroa_idx, align 8
  %vr.sroa.52.16.copyload873 = load <4 x half>, ptr addrspace(4) %add.ptr293.1.4, align 16
  %274 = or disjoint i64 %271, %27
  %add.ptr293.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %274
  %vr.sroa.32.0.add.ptr293.4.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr293.4, i64 8
  %vr.sroa.32.0.copyload826 = load <4 x half>, ptr addrspace(4) %vr.sroa.32.0.add.ptr293.4.sroa_idx, align 8
  %vr.sroa.0.0.copyload817 = load <4 x half>, ptr addrspace(4) %add.ptr293.4, align 16
  %275 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload817, <4 x half> %269, <4 x float> %out.sroa.0.12), !call_argsrelate !163
  %276 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.32.0.copyload826, <4 x half> %269, <4 x float> %out.sroa.34.12), !call_argsrelate !163
  %277 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.52.16.copyload873, <4 x half> %269, <4 x float> %out.sroa.66.12), !call_argsrelate !163
  %278 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.82.16.copyload882, <4 x half> %269, <4 x float> %out.sroa.98.12), !call_argsrelate !163
  br label %if.end354.4

if.end354.4:                                      ; preds = %for.cond316.preheader.4, %for.cond262.preheader.4
  %out.sroa.98.13 = phi <4 x float> [ %out.sroa.98.12, %for.cond262.preheader.4 ], [ %278, %for.cond316.preheader.4 ]
  %out.sroa.66.13 = phi <4 x float> [ %out.sroa.66.12, %for.cond262.preheader.4 ], [ %277, %for.cond316.preheader.4 ]
  %out.sroa.34.13 = phi <4 x float> [ %out.sroa.34.12, %for.cond262.preheader.4 ], [ %276, %for.cond316.preheader.4 ]
  %out.sroa.0.13 = phi <4 x float> [ %out.sroa.0.12, %for.cond262.preheader.4 ], [ %275, %for.cond316.preheader.4 ]
  %or.cond652.1.4 = icmp ugt i32 %mul11.7, 1023
  %cmp275.not.1.4 = icmp sgt i32 %mul11.7, %1
  %or.cond653.1.4 = or i1 %or.cond652.1.4, %cmp275.not.1.4
  br i1 %or.cond653.1.4, label %if.end358.4, label %for.cond335.preheader.1.4

for.cond335.preheader.1.4:                        ; preds = %if.end354.4
  %add309.1.4 = or disjoint i32 %and247, 512
  %add.ptr311.1.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add309.1.4
  %279 = load <4 x half>, ptr addrspace(3) %add.ptr311.1.4, align 8
  %280 = shl nsw i32 %cond.i.i617.7, 10
  %mul284.1.4 = and i32 %280, 64512
  %add285.1.4 = or disjoint i32 %mul284.1.4, %mul103
  %281 = zext nneg i32 %add285.1.4 to i64
  %282 = or disjoint i64 %281, %27
  %283 = or disjoint i64 %282, 512
  %add.ptr293.1.1.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %283
  %vr.sroa.82.16.add.ptr293.1.1.4.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr293.1.1.4, i64 8
  %vr.sroa.82.16.copyload883 = load <4 x half>, ptr addrspace(4) %vr.sroa.82.16.add.ptr293.1.1.4.sroa_idx, align 8
  %vr.sroa.52.16.copyload874 = load <4 x half>, ptr addrspace(4) %add.ptr293.1.1.4, align 16
  %284 = or disjoint i64 %281, %27
  %add.ptr293.1681.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %284
  %vr.sroa.32.0.add.ptr293.1681.4.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr293.1681.4, i64 8
  %vr.sroa.32.0.copyload827 = load <4 x half>, ptr addrspace(4) %vr.sroa.32.0.add.ptr293.1681.4.sroa_idx, align 8
  %vr.sroa.0.0.copyload818 = load <4 x half>, ptr addrspace(4) %add.ptr293.1681.4, align 16
  %285 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload818, <4 x half> %279, <4 x float> %out_1.sroa.0.12), !call_argsrelate !163
  %286 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.32.0.copyload827, <4 x half> %279, <4 x float> %out_1.sroa.30.12), !call_argsrelate !163
  %287 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.52.16.copyload874, <4 x half> %279, <4 x float> %out_1.sroa.58.12), !call_argsrelate !163
  %288 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.82.16.copyload883, <4 x half> %279, <4 x float> %out_1.sroa.86.12), !call_argsrelate !163
  br label %if.end358.4

if.end358.4:                                      ; preds = %if.end354.4, %for.cond335.preheader.1.4, %if.end255.4
  %out.sroa.98.15 = phi <4 x float> [ %out.sroa.98.12, %if.end255.4 ], [ %out.sroa.98.13, %for.cond335.preheader.1.4 ], [ %out.sroa.98.13, %if.end354.4 ]
  %out.sroa.66.15 = phi <4 x float> [ %out.sroa.66.12, %if.end255.4 ], [ %out.sroa.66.13, %for.cond335.preheader.1.4 ], [ %out.sroa.66.13, %if.end354.4 ]
  %out.sroa.34.15 = phi <4 x float> [ %out.sroa.34.12, %if.end255.4 ], [ %out.sroa.34.13, %for.cond335.preheader.1.4 ], [ %out.sroa.34.13, %if.end354.4 ]
  %out.sroa.0.15 = phi <4 x float> [ %out.sroa.0.12, %if.end255.4 ], [ %out.sroa.0.13, %for.cond335.preheader.1.4 ], [ %out.sroa.0.13, %if.end354.4 ]
  %out_1.sroa.86.15 = phi <4 x float> [ %out_1.sroa.86.12, %if.end255.4 ], [ %288, %for.cond335.preheader.1.4 ], [ %out_1.sroa.86.12, %if.end354.4 ]
  %out_1.sroa.58.15 = phi <4 x float> [ %out_1.sroa.58.12, %if.end255.4 ], [ %287, %for.cond335.preheader.1.4 ], [ %out_1.sroa.58.12, %if.end354.4 ]
  %out_1.sroa.30.15 = phi <4 x float> [ %out_1.sroa.30.12, %if.end255.4 ], [ %286, %for.cond335.preheader.1.4 ], [ %out_1.sroa.30.12, %if.end354.4 ]
  %out_1.sroa.0.15 = phi <4 x float> [ %out_1.sroa.0.12, %if.end255.4 ], [ %285, %for.cond335.preheader.1.4 ], [ %out_1.sroa.0.12, %if.end354.4 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %cmp15, label %for.body370.preheader, label %if.end401

if.end401:                                        ; preds = %for.body370.preheader, %if.end358.4
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  %cmp404 = icmp eq i32 %shr257.mask, 64
  br i1 %cmp404, label %if.then405, label %if.end502

if.then405:                                       ; preds = %if.end401
  %and407 = and i32 %18, 63
  %arrayidx409 = getelementptr inbounds float, ptr addrspace(3) @buf_dyn_shmem, i32 %and407
  %289 = load float, ptr addrspace(3) %arrayidx409, align 4, !tbaa !105
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %out.sroa.0.15, i64 0
  %out_1.sroa.0.0.vec.extract = extractelement <4 x float> %out_1.sroa.0.15, i64 0
  %add419 = fadd contract float %out.sroa.0.0.vec.extract, %out_1.sroa.0.0.vec.extract
  %mul425 = fmul contract float %289, %add419
  %290 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul425)
  %oreg.sroa.0.0.insert.ext = zext i16 %290 to i64
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %out.sroa.0.15, i64 1
  %out_1.sroa.0.4.vec.extract = extractelement <4 x float> %out_1.sroa.0.15, i64 1
  %add419.1 = fadd contract float %out.sroa.0.4.vec.extract, %out_1.sroa.0.4.vec.extract
  %mul425.1 = fmul contract float %289, %add419.1
  %291 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul425.1)
  %oreg.sroa.0.2.insert.ext = zext i16 %291 to i64
  %oreg.sroa.0.2.insert.shift = shl nuw nsw i64 %oreg.sroa.0.2.insert.ext, 16
  %oreg.sroa.0.2.insert.insert = or disjoint i64 %oreg.sroa.0.2.insert.shift, %oreg.sroa.0.0.insert.ext
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %out.sroa.0.15, i64 2
  %out_1.sroa.0.8.vec.extract = extractelement <4 x float> %out_1.sroa.0.15, i64 2
  %add419.2 = fadd contract float %out.sroa.0.8.vec.extract, %out_1.sroa.0.8.vec.extract
  %mul425.2 = fmul contract float %289, %add419.2
  %292 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul425.2)
  %oreg.sroa.0.4.insert.ext = zext i16 %292 to i64
  %oreg.sroa.0.4.insert.shift = shl nuw nsw i64 %oreg.sroa.0.4.insert.ext, 32
  %oreg.sroa.0.4.insert.insert = or disjoint i64 %oreg.sroa.0.2.insert.insert, %oreg.sroa.0.4.insert.shift
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %out.sroa.0.15, i64 3
  %out_1.sroa.0.12.vec.extract = extractelement <4 x float> %out_1.sroa.0.15, i64 3
  %add419.3 = fadd contract float %out.sroa.0.12.vec.extract, %out_1.sroa.0.12.vec.extract
  %mul425.3 = fmul contract float %289, %add419.3
  %293 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul425.3)
  %oreg.sroa.0.6.insert.ext = zext i16 %293 to i64
  %oreg.sroa.0.6.insert.shift = shl nuw i64 %oreg.sroa.0.6.insert.ext, 48
  %oreg.sroa.0.6.insert.insert = or disjoint i64 %oreg.sroa.0.4.insert.insert, %oreg.sroa.0.6.insert.shift
  %out.sroa.34.16.vec.extract = extractelement <4 x float> %out.sroa.34.15, i64 0
  %out_1.sroa.30.16.vec.extract = extractelement <4 x float> %out_1.sroa.30.15, i64 0
  %add419.4 = fadd contract float %out.sroa.34.16.vec.extract, %out_1.sroa.30.16.vec.extract
  %mul425.4 = fmul contract float %289, %add419.4
  %294 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul425.4)
  %oreg.sroa.7.8.insert.ext = zext i16 %294 to i64
  %out.sroa.34.20.vec.extract = extractelement <4 x float> %out.sroa.34.15, i64 1
  %out_1.sroa.30.20.vec.extract = extractelement <4 x float> %out_1.sroa.30.15, i64 1
  %add419.5 = fadd contract float %out.sroa.34.20.vec.extract, %out_1.sroa.30.20.vec.extract
  %mul425.5 = fmul contract float %289, %add419.5
  %295 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul425.5)
  %oreg.sroa.7.10.insert.ext = zext i16 %295 to i64
  %oreg.sroa.7.10.insert.shift = shl nuw nsw i64 %oreg.sroa.7.10.insert.ext, 16
  %oreg.sroa.7.10.insert.insert = or disjoint i64 %oreg.sroa.7.10.insert.shift, %oreg.sroa.7.8.insert.ext
  %out.sroa.34.24.vec.extract = extractelement <4 x float> %out.sroa.34.15, i64 2
  %out_1.sroa.30.24.vec.extract = extractelement <4 x float> %out_1.sroa.30.15, i64 2
  %add419.6 = fadd contract float %out.sroa.34.24.vec.extract, %out_1.sroa.30.24.vec.extract
  %mul425.6 = fmul contract float %289, %add419.6
  %296 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul425.6)
  %oreg.sroa.7.12.insert.ext = zext i16 %296 to i64
  %oreg.sroa.7.12.insert.shift = shl nuw nsw i64 %oreg.sroa.7.12.insert.ext, 32
  %oreg.sroa.7.12.insert.insert = or disjoint i64 %oreg.sroa.7.10.insert.insert, %oreg.sroa.7.12.insert.shift
  %out.sroa.34.28.vec.extract = extractelement <4 x float> %out.sroa.34.15, i64 3
  %out_1.sroa.30.28.vec.extract = extractelement <4 x float> %out_1.sroa.30.15, i64 3
  %add419.7 = fadd contract float %out.sroa.34.28.vec.extract, %out_1.sroa.30.28.vec.extract
  %mul425.7 = fmul contract float %289, %add419.7
  %297 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul425.7)
  %oreg.sroa.7.14.insert.ext = zext i16 %297 to i64
  %oreg.sroa.7.14.insert.shift = shl nuw i64 %oreg.sroa.7.14.insert.ext, 48
  %oreg.sroa.7.14.insert.insert = or disjoint i64 %oreg.sroa.7.12.insert.insert, %oreg.sroa.7.14.insert.shift
  %out.sroa.66.32.vec.extract = extractelement <4 x float> %out.sroa.66.15, i64 0
  %out_1.sroa.58.32.vec.extract = extractelement <4 x float> %out_1.sroa.58.15, i64 0
  %add419.8 = fadd contract float %out.sroa.66.32.vec.extract, %out_1.sroa.58.32.vec.extract
  %mul425.8 = fmul contract float %289, %add419.8
  %298 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul425.8)
  %oreg.sroa.12.16.insert.ext = zext i16 %298 to i64
  %out.sroa.66.36.vec.extract = extractelement <4 x float> %out.sroa.66.15, i64 1
  %out_1.sroa.58.36.vec.extract = extractelement <4 x float> %out_1.sroa.58.15, i64 1
  %add419.9 = fadd contract float %out.sroa.66.36.vec.extract, %out_1.sroa.58.36.vec.extract
  %mul425.9 = fmul contract float %289, %add419.9
  %299 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul425.9)
  %oreg.sroa.12.18.insert.ext = zext i16 %299 to i64
  %oreg.sroa.12.18.insert.shift = shl nuw nsw i64 %oreg.sroa.12.18.insert.ext, 16
  %oreg.sroa.12.18.insert.insert = or disjoint i64 %oreg.sroa.12.18.insert.shift, %oreg.sroa.12.16.insert.ext
  %out.sroa.66.40.vec.extract = extractelement <4 x float> %out.sroa.66.15, i64 2
  %out_1.sroa.58.40.vec.extract = extractelement <4 x float> %out_1.sroa.58.15, i64 2
  %add419.10 = fadd contract float %out.sroa.66.40.vec.extract, %out_1.sroa.58.40.vec.extract
  %mul425.10 = fmul contract float %289, %add419.10
  %300 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul425.10)
  %oreg.sroa.12.20.insert.ext = zext i16 %300 to i64
  %oreg.sroa.12.20.insert.shift = shl nuw nsw i64 %oreg.sroa.12.20.insert.ext, 32
  %oreg.sroa.12.20.insert.insert = or disjoint i64 %oreg.sroa.12.18.insert.insert, %oreg.sroa.12.20.insert.shift
  %out.sroa.66.44.vec.extract = extractelement <4 x float> %out.sroa.66.15, i64 3
  %out_1.sroa.58.44.vec.extract = extractelement <4 x float> %out_1.sroa.58.15, i64 3
  %add419.11 = fadd contract float %out.sroa.66.44.vec.extract, %out_1.sroa.58.44.vec.extract
  %mul425.11 = fmul contract float %289, %add419.11
  %301 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul425.11)
  %oreg.sroa.12.22.insert.ext = zext i16 %301 to i64
  %oreg.sroa.12.22.insert.shift = shl nuw i64 %oreg.sroa.12.22.insert.ext, 48
  %oreg.sroa.12.22.insert.insert = or disjoint i64 %oreg.sroa.12.20.insert.insert, %oreg.sroa.12.22.insert.shift
  %out.sroa.98.48.vec.extract = extractelement <4 x float> %out.sroa.98.15, i64 0
  %out_1.sroa.86.48.vec.extract = extractelement <4 x float> %out_1.sroa.86.15, i64 0
  %add419.12 = fadd contract float %out.sroa.98.48.vec.extract, %out_1.sroa.86.48.vec.extract
  %mul425.12 = fmul contract float %289, %add419.12
  %302 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul425.12)
  %oreg.sroa.17.24.insert.ext = zext i16 %302 to i64
  %out.sroa.98.52.vec.extract = extractelement <4 x float> %out.sroa.98.15, i64 1
  %out_1.sroa.86.52.vec.extract = extractelement <4 x float> %out_1.sroa.86.15, i64 1
  %add419.13 = fadd contract float %out.sroa.98.52.vec.extract, %out_1.sroa.86.52.vec.extract
  %mul425.13 = fmul contract float %289, %add419.13
  %303 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul425.13)
  %oreg.sroa.17.26.insert.ext = zext i16 %303 to i64
  %oreg.sroa.17.26.insert.shift = shl nuw nsw i64 %oreg.sroa.17.26.insert.ext, 16
  %oreg.sroa.17.26.insert.insert = or disjoint i64 %oreg.sroa.17.26.insert.shift, %oreg.sroa.17.24.insert.ext
  %out.sroa.98.56.vec.extract = extractelement <4 x float> %out.sroa.98.15, i64 2
  %out_1.sroa.86.56.vec.extract = extractelement <4 x float> %out_1.sroa.86.15, i64 2
  %add419.14 = fadd contract float %out.sroa.98.56.vec.extract, %out_1.sroa.86.56.vec.extract
  %mul425.14 = fmul contract float %289, %add419.14
  %304 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul425.14)
  %oreg.sroa.17.28.insert.ext = zext i16 %304 to i64
  %oreg.sroa.17.28.insert.shift = shl nuw nsw i64 %oreg.sroa.17.28.insert.ext, 32
  %oreg.sroa.17.28.insert.insert = or disjoint i64 %oreg.sroa.17.26.insert.insert, %oreg.sroa.17.28.insert.shift
  %out.sroa.98.60.vec.extract = extractelement <4 x float> %out.sroa.98.15, i64 3
  %out_1.sroa.86.60.vec.extract = extractelement <4 x float> %out_1.sroa.86.15, i64 3
  %add419.15 = fadd contract float %out.sroa.98.60.vec.extract, %out_1.sroa.86.60.vec.extract
  %mul425.15 = fmul contract float %289, %add419.15
  %305 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul425.15)
  %oreg.sroa.17.30.insert.ext = zext i16 %305 to i64
  %oreg.sroa.17.30.insert.shift = shl nuw i64 %oreg.sroa.17.30.insert.ext, 48
  %oreg.sroa.17.30.insert.insert = or disjoint i64 %oreg.sroa.17.28.insert.insert, %oreg.sroa.17.30.insert.shift
  %and445 = shl nuw nsw i32 %18, 6
  %mul446 = and i32 %and445, 960
  %and449 = lshr i32 %18, 5
  %shr450 = and i32 %and449, 1
  %and453 = and i32 %18, 7
  %mul459 = and i32 %25, 4
  %xor = xor i32 %shr450, %and453
  %mul454 = shl nuw nsw i32 %xor, 3
  %add455 = or disjoint i32 %mul454, %mul446
  %add460 = or disjoint i32 %add455, %mul459
  %add.ptr462 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add460
  store i64 %oreg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr462, align 8
  %xor.1 = xor i32 %and449, %and453
  %mul454.1 = shl nuw nsw i32 %xor.1, 3
  %add455.1 = or disjoint i32 %mul454.1, %mul446
  %add460.1 = or disjoint i32 %add455.1, %mul459
  %add.ptr462.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add460.1
  store i64 %oreg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr462.1, align 8
  %add451.2 = or disjoint i32 %shr450, 4
  %xor.2 = xor i32 %add451.2, %and453
  %mul454.2 = shl nuw nsw i32 %xor.2, 3
  %add455.2 = or disjoint i32 %mul454.2, %mul446
  %add460.2 = or disjoint i32 %add455.2, %mul459
  %add.ptr462.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add460.2
  store i64 %oreg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr462.2, align 8
  %add451.3 = or i32 %and449, 6
  %xor.3 = xor i32 %add451.3, %and453
  %mul454.3 = shl nuw nsw i32 %xor.3, 3
  %add455.3 = or disjoint i32 %mul454.3, %mul446
  %add460.3 = or disjoint i32 %add455.3, %mul459
  %add.ptr462.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add460.3
  store i64 %oreg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr462.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul474 = and i32 %and110, 448
  %xor481 = xor i32 %and110, %18
  %mul482 = and i32 %xor481, 56
  %306 = or disjoint i32 %mul482, %mul474
  %mul487 = shl nsw i32 %0, 20
  %mul489 = shl nsw i32 %1, 10
  %add490 = add nuw nsw i32 %mul487, %mul489
  %307 = or disjoint i32 %add490, %mul290
  %308 = zext nneg i32 %307 to i64
  %add.ptr485 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %306
  %add.ptr498 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %308
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr498, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr485, i64 16, i1 false), !tbaa.struct !204, !call_argsrelate !205
  %309 = or disjoint i32 %306, 512
  %add.ptr485.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %309
  %310 = or disjoint i64 %308, 512
  %add.ptr498.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %310
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr498.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr485.1, i64 16, i1 false), !tbaa.struct !204, !call_argsrelate !205
  br label %if.end502

if.end502:                                        ; preds = %if.then405, %if.end401
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


