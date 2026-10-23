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
  %cond.i.i727 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64)
  %mul11 = shl nsw i32 %cond.i.i727, 4
  %4 = or disjoint i64 %2, 1
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !call_argsrelate !48
  %cond.i.i727.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64)
  %mul11.1 = shl nsw i32 %cond.i.i727.1, 4
  %6 = or disjoint i64 %2, 2
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !call_argsrelate !48
  %cond.i.i727.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64)
  %mul11.2 = shl nsw i32 %cond.i.i727.2, 4
  %8 = or disjoint i64 %2, 3
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !call_argsrelate !48
  %cond.i.i727.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64)
  %mul11.3 = shl nsw i32 %cond.i.i727.3, 4
  %10 = or disjoint i64 %2, 4
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !call_argsrelate !48
  %cond.i.i727.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64)
  %mul11.4 = shl nsw i32 %cond.i.i727.4, 4
  %12 = or disjoint i64 %2, 5
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !call_argsrelate !48
  %cond.i.i727.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64)
  %mul11.5 = shl nsw i32 %cond.i.i727.5, 4
  %14 = or disjoint i64 %2, 6
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !call_argsrelate !48
  %cond.i.i727.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64)
  %mul11.6 = shl nsw i32 %cond.i.i727.6, 4
  %16 = or disjoint i64 %2, 7
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !call_argsrelate !48
  %cond.i.i727.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64)
  %mul11.7 = shl nsw i32 %cond.i.i727.7, 4
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
  %cmp108 = icmp ugt i32 %18, 63
  %shr284.mask = and i32 %18, 960
  %cmp285.not = icmp eq i32 %shr284.mask, 64
  %mul131 = shl nsw i32 %0, 16
  %and138 = shl nuw nsw i32 %18, 3
  %and274 = shl nuw nsw i32 %18, 2
  %invariant.op = add nsw i32 %1, -15
  %25 = lshr i32 %18, 2
  %mul182 = and i32 %25, 12
  %mul317 = and i32 %and138, 504
  %mul333 = and i32 %and274, 252
  %26 = zext nneg i32 %and138 to i64
  %27 = zext nneg i32 %mul317 to i64
  br i1 %cmp108, label %if.end428, label %for.cond111.preheader

for.body440.preheader:                            ; preds = %if.end428.2
  %add444 = fadd contract float %sums.sroa.0.10, 0.000000e+00
  %add444.1 = fadd contract float %add444, %sums.sroa.28.10
  %add444.2 = fadd contract float %add444.1, %sums.sroa.54.10
  %add444.3 = fadd contract float %add444.2, %sums.sroa.80.10
  %28 = bitcast float %add444.3 to i32
  %29 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %30 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %29) #11
  %xor.i.i = xor i32 %30, 32
  %31 = and i32 %30, -64
  %and.i.i = add nsw i32 %31, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i728 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %30
  %shl.i.i = shl i32 %cond.i.i728, 2
  %32 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %28)
  %33 = bitcast i32 %32 to float
  %add452 = fadd contract float %add444.3, %33
  %34 = bitcast float %add452 to i32
  %35 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %36 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %35) #11
  %xor.i.i729 = xor i32 %36, 16
  %37 = and i32 %36, -64
  %and.i.i730 = add nsw i32 %37, 64
  %cmp.not.i.i731 = icmp slt i32 %xor.i.i729, %and.i.i730
  %cond.i.i732 = select i1 %cmp.not.i.i731, i32 %xor.i.i729, i32 %36
  %shl.i.i733 = shl i32 %cond.i.i732, 2
  %38 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i733, i32 %34)
  %39 = bitcast i32 %38 to float
  %add457 = fadd contract float %add452, %39
  %cmp460 = fcmp contract ogt float %add457, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add457
  %condval_1.0 = select i1 %cmp460, float %div, float 0.000000e+00
  %arrayidx470 = getelementptr inbounds float, ptr addrspace(3) @buf_dyn_shmem, i32 %18
  store float %condval_1.0, ptr addrspace(3) %arrayidx470, align 4, !tbaa !105
  br label %if.end471

for.cond111.preheader:                            ; preds = %if.end
  %or.cond764 = icmp ugt i32 %mul11, 1023
  %cmp124.not = icmp sgt i32 %mul11, %1
  %or.cond765 = or i1 %or.cond764, %cmp124.not
  br i1 %or.cond765, label %if.end152, label %for.cond126.preheader

for.cond126.preheader:                            ; preds = %for.cond111.preheader
  %40 = shl nsw i32 %cond.i.i727, 10
  %mul133 = and i32 %40, 64512
  %add134 = or disjoint i32 %mul133, %mul131
  %41 = zext nneg i32 %add134 to i64
  %42 = or disjoint i64 %41, %26
  %add.ptr142 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %42
  %kr.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr142, align 16
  %kr.sroa.8.0.add.ptr142.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142, i64 8
  %kr.sroa.8.0.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.8.0.add.ptr142.sroa_idx, align 8
  %43 = or disjoint i64 %41, %26
  %44 = or disjoint i64 %43, 512
  %add.ptr142.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %44
  %kr.sroa.11.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr142.1, align 16
  %kr.sroa.17.16.add.ptr142.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1, i64 8
  %kr.sroa.17.16.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.17.16.add.ptr142.1.sroa_idx, align 8
  br label %if.end152

if.end152:                                        ; preds = %for.cond126.preheader, %for.cond111.preheader
  %kr.sroa.17.0 = phi <4 x half> [ undef, %for.cond111.preheader ], [ %kr.sroa.17.16.copyload, %for.cond126.preheader ]
  %kr.sroa.11.0 = phi <4 x half> [ undef, %for.cond111.preheader ], [ %kr.sroa.11.16.copyload, %for.cond126.preheader ]
  %kr.sroa.8.0 = phi <4 x half> [ undef, %for.cond111.preheader ], [ %kr.sroa.8.0.copyload, %for.cond126.preheader ]
  %kr.sroa.0.0 = phi <4 x half> [ undef, %for.cond111.preheader ], [ %kr.sroa.0.0.copyload, %for.cond126.preheader ]
  %or.cond764.1 = icmp ugt i32 %mul11.1, 1023
  %cmp124.not.1 = icmp sgt i32 %mul11.1, %1
  %or.cond765.1 = or i1 %or.cond764.1, %cmp124.not.1
  br i1 %or.cond765.1, label %if.end152.1, label %for.cond126.preheader.1

for.cond126.preheader.1:                          ; preds = %if.end152
  %45 = shl nsw i32 %cond.i.i727.1, 10
  %mul133.1 = and i32 %45, 64512
  %add134.1 = or disjoint i32 %mul133.1, %mul131
  %46 = zext nneg i32 %add134.1 to i64
  %47 = or disjoint i64 %46, %26
  %add.ptr142.1785 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %47
  %kr.sroa.20.32.copyload = load <4 x half>, ptr addrspace(4) %add.ptr142.1785, align 16
  %kr.sroa.26.32.add.ptr142.1785.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1785, i64 8
  %kr.sroa.26.32.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.26.32.add.ptr142.1785.sroa_idx, align 8
  %48 = or disjoint i64 %46, %26
  %49 = or disjoint i64 %48, 512
  %add.ptr142.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %49
  %kr.sroa.29.48.copyload = load <4 x half>, ptr addrspace(4) %add.ptr142.1.1, align 16
  %kr.sroa.35.48.add.ptr142.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1.1, i64 8
  %kr.sroa.35.48.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.35.48.add.ptr142.1.1.sroa_idx, align 8
  br label %if.end152.1

if.end152.1:                                      ; preds = %for.cond126.preheader.1, %if.end152
  %kr.sroa.35.0 = phi <4 x half> [ undef, %if.end152 ], [ %kr.sroa.35.48.copyload, %for.cond126.preheader.1 ]
  %kr.sroa.29.0 = phi <4 x half> [ undef, %if.end152 ], [ %kr.sroa.29.48.copyload, %for.cond126.preheader.1 ]
  %kr.sroa.26.0 = phi <4 x half> [ undef, %if.end152 ], [ %kr.sroa.26.32.copyload, %for.cond126.preheader.1 ]
  %kr.sroa.20.0 = phi <4 x half> [ undef, %if.end152 ], [ %kr.sroa.20.32.copyload, %for.cond126.preheader.1 ]
  %or.cond764.2 = icmp ugt i32 %mul11.2, 1023
  %cmp124.not.2 = icmp sgt i32 %mul11.2, %1
  %or.cond765.2 = or i1 %or.cond764.2, %cmp124.not.2
  br i1 %or.cond765.2, label %if.end152.2, label %for.cond126.preheader.2

for.cond126.preheader.2:                          ; preds = %if.end152.1
  %50 = shl nsw i32 %cond.i.i727.2, 10
  %mul133.2 = and i32 %50, 64512
  %add134.2 = or disjoint i32 %mul133.2, %mul131
  %51 = zext nneg i32 %add134.2 to i64
  %52 = or disjoint i64 %51, %26
  %add.ptr142.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %52
  %kr.sroa.38.64.copyload = load <4 x half>, ptr addrspace(4) %add.ptr142.2, align 16
  %kr.sroa.44.64.add.ptr142.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.2, i64 8
  %kr.sroa.44.64.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.44.64.add.ptr142.2.sroa_idx, align 8
  %53 = or disjoint i64 %51, %26
  %54 = or disjoint i64 %53, 512
  %add.ptr142.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %54
  %kr.sroa.47.80.copyload = load <4 x half>, ptr addrspace(4) %add.ptr142.1.2, align 16
  %kr.sroa.53.80.add.ptr142.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1.2, i64 8
  %kr.sroa.53.80.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.53.80.add.ptr142.1.2.sroa_idx, align 8
  br label %if.end152.2

if.end152.2:                                      ; preds = %for.cond126.preheader.2, %if.end152.1
  %kr.sroa.53.0 = phi <4 x half> [ undef, %if.end152.1 ], [ %kr.sroa.53.80.copyload, %for.cond126.preheader.2 ]
  %kr.sroa.47.0 = phi <4 x half> [ undef, %if.end152.1 ], [ %kr.sroa.47.80.copyload, %for.cond126.preheader.2 ]
  %kr.sroa.44.0 = phi <4 x half> [ undef, %if.end152.1 ], [ %kr.sroa.44.64.copyload, %for.cond126.preheader.2 ]
  %kr.sroa.38.0 = phi <4 x half> [ undef, %if.end152.1 ], [ %kr.sroa.38.64.copyload, %for.cond126.preheader.2 ]
  %or.cond764.3 = icmp ugt i32 %mul11.3, 1023
  %cmp124.not.3 = icmp sgt i32 %mul11.3, %1
  %or.cond765.3 = or i1 %or.cond764.3, %cmp124.not.3
  br i1 %or.cond765.3, label %if.end152.3, label %for.cond126.preheader.3

for.cond126.preheader.3:                          ; preds = %if.end152.2
  %55 = shl nsw i32 %cond.i.i727.3, 10
  %mul133.3 = and i32 %55, 64512
  %add134.3 = or disjoint i32 %mul133.3, %mul131
  %56 = zext nneg i32 %add134.3 to i64
  %57 = or disjoint i64 %56, %26
  %add.ptr142.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %57
  %kr.sroa.56.96.copyload = load <4 x half>, ptr addrspace(4) %add.ptr142.3, align 16
  %kr.sroa.62.96.add.ptr142.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.3, i64 8
  %kr.sroa.62.96.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.62.96.add.ptr142.3.sroa_idx, align 8
  %58 = or disjoint i64 %56, %26
  %59 = or disjoint i64 %58, 512
  %add.ptr142.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %59
  %kr.sroa.65.112.copyload = load <4 x half>, ptr addrspace(4) %add.ptr142.1.3, align 16
  %kr.sroa.71.112.add.ptr142.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1.3, i64 8
  %kr.sroa.71.112.copyload = load <4 x half>, ptr addrspace(4) %kr.sroa.71.112.add.ptr142.1.3.sroa_idx, align 8
  br label %if.end152.3

if.end152.3:                                      ; preds = %for.cond126.preheader.3, %if.end152.2
  %kr.sroa.71.0 = phi <4 x half> [ undef, %if.end152.2 ], [ %kr.sroa.71.112.copyload, %for.cond126.preheader.3 ]
  %kr.sroa.65.0 = phi <4 x half> [ undef, %if.end152.2 ], [ %kr.sroa.65.112.copyload, %for.cond126.preheader.3 ]
  %kr.sroa.62.0 = phi <4 x half> [ undef, %if.end152.2 ], [ %kr.sroa.62.96.copyload, %for.cond126.preheader.3 ]
  %kr.sroa.56.0 = phi <4 x half> [ undef, %if.end152.2 ], [ %kr.sroa.56.96.copyload, %for.cond126.preheader.3 ]
  br i1 %or.cond765, label %if.end267, label %if.then170

if.then170:                                       ; preds = %if.end152.3
  %cmp173 = icmp sgt i32 %mul11, %invariant.op
  br i1 %cmp173, label %for.cond175.preheader, label %if.end201

for.cond175.preheader:                            ; preds = %if.then170
  %add183 = or disjoint i32 %mul11, %mul182
  %cmp186.not = icmp sgt i32 %add183, %1
  %spec.select = select i1 %cmp186.not, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1287 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp186.not.1.not = icmp slt i32 %add183, %1
  %spec.select.1 = select i1 %cmp186.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1426 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1287, float %spec.select.1, i64 1
  %add184.2 = or disjoint i32 %add183, 2
  %cmp186.not.2 = icmp sgt i32 %add184.2, %1
  %spec.select.2 = select i1 %cmp186.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1543 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1426, float %spec.select.2, i64 2
  %add184.3 = or disjoint i32 %add183, 3
  %cmp186.not.3 = icmp sgt i32 %add184.3, %1
  %spec.select.3 = select i1 %cmp186.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1660 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1543, float %spec.select.3, i64 3
  br label %if.end201

if.end201:                                        ; preds = %if.then170, %for.cond175.preheader
  %scores.sroa.0.0 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1660, %for.cond175.preheader ], [ zeroinitializer, %if.then170 ]
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.0, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.0)
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.8.0, <4 x half> %qr.sroa.15.0, <4 x float> %60)
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.11.0, <4 x half> %qr.sroa.27.0, <4 x float> %61)
  %63 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.17.0, <4 x half> %qr.sroa.40.0, <4 x float> %62)
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %63, i64 0
  %mul227 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %64 = tail call contract noundef float @llvm.minnum.f32(float %mul227, float 0x4024CB5EC0000000)
  %65 = tail call contract noundef float @llvm.exp.f32(float %64)
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %63, i64 1
  %mul227.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %66 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1, float 0x4024CB5EC0000000)
  %67 = tail call contract noundef float @llvm.exp.f32(float %66)
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %63, i64 2
  %mul227.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %68 = tail call contract noundef float @llvm.minnum.f32(float %mul227.2, float 0x4024CB5EC0000000)
  %69 = tail call contract noundef float @llvm.exp.f32(float %68)
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %63, i64 3
  %mul227.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %70 = tail call contract noundef float @llvm.minnum.f32(float %mul227.3, float 0x4024CB5EC0000000)
  %71 = tail call contract noundef float @llvm.exp.f32(float %70)
  %72 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %65)
  %probs.sroa.0.0.vec.insert = insertelement <4 x i16> poison, i16 %72, i64 0
  %73 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %67)
  %probs.sroa.0.2.vec.insert = insertelement <4 x i16> %probs.sroa.0.0.vec.insert, i16 %73, i64 1
  %74 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %69)
  %probs.sroa.0.4.vec.insert = insertelement <4 x i16> %probs.sroa.0.2.vec.insert, i16 %74, i64 2
  %75 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %71)
  %probs.sroa.0.6.vec.insert = insertelement <4 x i16> %probs.sroa.0.4.vec.insert, i16 %75, i64 3
  br label %if.end267

if.end267:                                        ; preds = %if.end152.3, %if.end201
  %sums.sroa.80.1 = phi float [ %71, %if.end201 ], [ 0.000000e+00, %if.end152.3 ]
  %sums.sroa.54.1 = phi float [ %69, %if.end201 ], [ 0.000000e+00, %if.end152.3 ]
  %sums.sroa.28.1 = phi float [ %67, %if.end201 ], [ 0.000000e+00, %if.end152.3 ]
  %sums.sroa.0.1 = phi float [ %65, %if.end201 ], [ 0.000000e+00, %if.end152.3 ]
  %probs.sroa.0.0 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert, %if.end201 ], [ zeroinitializer, %if.end152.3 ]
  %add.ptr278 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %and274
  store <4 x i16> %probs.sroa.0.0, ptr addrspace(3) %add.ptr278, align 8
  br i1 %or.cond765.1, label %if.end267.1, label %if.then170.1

if.then170.1:                                     ; preds = %if.end267
  %cmp173.1 = icmp sgt i32 %mul11.1, %invariant.op
  br i1 %cmp173.1, label %for.cond175.preheader.1, label %if.end201.1

for.cond175.preheader.1:                          ; preds = %if.then170.1
  %add183.1 = or disjoint i32 %mul11.1, %mul182
  %cmp186.not.1788 = icmp sgt i32 %add183.1, %1
  %spec.select.1789 = select i1 %cmp186.not.1788, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1296 = insertelement <4 x float> poison, float %spec.select.1789, i64 0
  %cmp186.not.1.1.not = icmp slt i32 %add183.1, %1
  %spec.select.1.1 = select i1 %cmp186.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1433 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1296, float %spec.select.1.1, i64 1
  %add184.2.1 = or disjoint i32 %add183.1, 2
  %cmp186.not.2.1 = icmp sgt i32 %add184.2.1, %1
  %spec.select.2.1 = select i1 %cmp186.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1550 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1433, float %spec.select.2.1, i64 2
  %add184.3.1 = or disjoint i32 %add183.1, 3
  %cmp186.not.3.1 = icmp sgt i32 %add184.3.1, %1
  %spec.select.3.1 = select i1 %cmp186.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1667 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1550, float %spec.select.3.1, i64 3
  br label %if.end201.1

if.end201.1:                                      ; preds = %if.then170.1, %for.cond175.preheader.1
  %scores.sroa.0.2 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1667, %for.cond175.preheader.1 ], [ zeroinitializer, %if.then170.1 ]
  %76 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.20.0, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.2)
  %77 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.26.0, <4 x half> %qr.sroa.15.0, <4 x float> %76)
  %78 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.29.0, <4 x half> %qr.sroa.27.0, <4 x float> %77)
  %79 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.35.0, <4 x half> %qr.sroa.40.0, <4 x float> %78)
  %scores.sroa.0.0.vec.extract1298 = extractelement <4 x float> %79, i64 0
  %mul227.1792 = fmul contract float %scores.sroa.0.0.vec.extract1298, 0x3FB99999A0000000
  %80 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1792, float 0x4024CB5EC0000000)
  %81 = tail call contract noundef float @llvm.exp.f32(float %80)
  %scores.sroa.0.4.vec.extract1435 = extractelement <4 x float> %79, i64 1
  %mul227.1.1 = fmul contract float %scores.sroa.0.4.vec.extract1435, 0x3FB99999A0000000
  %82 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1.1, float 0x4024CB5EC0000000)
  %83 = tail call contract noundef float @llvm.exp.f32(float %82)
  %scores.sroa.0.8.vec.extract1552 = extractelement <4 x float> %79, i64 2
  %mul227.2.1 = fmul contract float %scores.sroa.0.8.vec.extract1552, 0x3FB99999A0000000
  %84 = tail call contract noundef float @llvm.minnum.f32(float %mul227.2.1, float 0x4024CB5EC0000000)
  %85 = tail call contract noundef float @llvm.exp.f32(float %84)
  %scores.sroa.0.12.vec.extract1669 = extractelement <4 x float> %79, i64 3
  %mul227.3.1 = fmul contract float %scores.sroa.0.12.vec.extract1669, 0x3FB99999A0000000
  %86 = tail call contract noundef float @llvm.minnum.f32(float %mul227.3.1, float 0x4024CB5EC0000000)
  %87 = tail call contract noundef float @llvm.exp.f32(float %86)
  %add243.1793 = fadd contract float %sums.sroa.0.1, %81
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %81)
  %probs.sroa.0.0.vec.insert1826 = insertelement <4 x i16> poison, i16 %88, i64 0
  %add243.1.1 = fadd contract float %sums.sroa.28.1, %83
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %83)
  %probs.sroa.0.2.vec.insert1872 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1826, i16 %89, i64 1
  %add243.2.1 = fadd contract float %sums.sroa.54.1, %85
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %85)
  %probs.sroa.0.4.vec.insert1917 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1872, i16 %90, i64 2
  %add243.3.1 = fadd contract float %sums.sroa.80.1, %87
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %87)
  %probs.sroa.0.6.vec.insert1939 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1917, i16 %91, i64 3
  br label %if.end267.1

if.end267.1:                                      ; preds = %if.end267, %if.end201.1
  %sums.sroa.80.2 = phi float [ %add243.3.1, %if.end201.1 ], [ %sums.sroa.80.1, %if.end267 ]
  %sums.sroa.54.2 = phi float [ %add243.2.1, %if.end201.1 ], [ %sums.sroa.54.1, %if.end267 ]
  %sums.sroa.28.2 = phi float [ %add243.1.1, %if.end201.1 ], [ %sums.sroa.28.1, %if.end267 ]
  %sums.sroa.0.2 = phi float [ %add243.1793, %if.end201.1 ], [ %sums.sroa.0.1, %if.end267 ]
  %probs.sroa.0.1 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1939, %if.end201.1 ], [ zeroinitializer, %if.end267 ]
  %add276.1 = or disjoint i32 %and274, 256
  %add.ptr278.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add276.1
  store <4 x i16> %probs.sroa.0.1, ptr addrspace(3) %add.ptr278.1, align 8
  br i1 %or.cond765.2, label %if.end267.2, label %if.then170.2

if.then170.2:                                     ; preds = %if.end267.1
  %cmp173.2 = icmp sgt i32 %mul11.2, %invariant.op
  br i1 %cmp173.2, label %for.cond175.preheader.2, label %if.end201.2

for.cond175.preheader.2:                          ; preds = %if.then170.2
  %add183.2 = or disjoint i32 %mul11.2, %mul182
  %cmp186.not.2794 = icmp sgt i32 %add183.2, %1
  %spec.select.2795 = select i1 %cmp186.not.2794, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1306 = insertelement <4 x float> poison, float %spec.select.2795, i64 0
  %cmp186.not.1.2.not = icmp slt i32 %add183.2, %1
  %spec.select.1.2 = select i1 %cmp186.not.1.2.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1441 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1306, float %spec.select.1.2, i64 1
  %add184.2.2 = or disjoint i32 %add183.2, 2
  %cmp186.not.2.2 = icmp sgt i32 %add184.2.2, %1
  %spec.select.2.2 = select i1 %cmp186.not.2.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1558 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1441, float %spec.select.2.2, i64 2
  %add184.3.2 = or disjoint i32 %add183.2, 3
  %cmp186.not.3.2 = icmp sgt i32 %add184.3.2, %1
  %spec.select.3.2 = select i1 %cmp186.not.3.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1675 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1558, float %spec.select.3.2, i64 3
  br label %if.end201.2

if.end201.2:                                      ; preds = %if.then170.2, %for.cond175.preheader.2
  %scores.sroa.0.4 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1675, %for.cond175.preheader.2 ], [ zeroinitializer, %if.then170.2 ]
  %92 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.38.0, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.4)
  %93 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.44.0, <4 x half> %qr.sroa.15.0, <4 x float> %92)
  %94 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.0, <4 x half> %qr.sroa.27.0, <4 x float> %93)
  %95 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.53.0, <4 x half> %qr.sroa.40.0, <4 x float> %94)
  %scores.sroa.0.0.vec.extract1308 = extractelement <4 x float> %95, i64 0
  %mul227.2798 = fmul contract float %scores.sroa.0.0.vec.extract1308, 0x3FB99999A0000000
  %96 = tail call contract noundef float @llvm.minnum.f32(float %mul227.2798, float 0x4024CB5EC0000000)
  %97 = tail call contract noundef float @llvm.exp.f32(float %96)
  %scores.sroa.0.4.vec.extract1443 = extractelement <4 x float> %95, i64 1
  %mul227.1.2 = fmul contract float %scores.sroa.0.4.vec.extract1443, 0x3FB99999A0000000
  %98 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1.2, float 0x4024CB5EC0000000)
  %99 = tail call contract noundef float @llvm.exp.f32(float %98)
  %scores.sroa.0.8.vec.extract1560 = extractelement <4 x float> %95, i64 2
  %mul227.2.2 = fmul contract float %scores.sroa.0.8.vec.extract1560, 0x3FB99999A0000000
  %100 = tail call contract noundef float @llvm.minnum.f32(float %mul227.2.2, float 0x4024CB5EC0000000)
  %101 = tail call contract noundef float @llvm.exp.f32(float %100)
  %scores.sroa.0.12.vec.extract1677 = extractelement <4 x float> %95, i64 3
  %mul227.3.2 = fmul contract float %scores.sroa.0.12.vec.extract1677, 0x3FB99999A0000000
  %102 = tail call contract noundef float @llvm.minnum.f32(float %mul227.3.2, float 0x4024CB5EC0000000)
  %103 = tail call contract noundef float @llvm.exp.f32(float %102)
  %add243.2799 = fadd contract float %sums.sroa.0.2, %97
  %104 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %97)
  %probs.sroa.0.0.vec.insert1828 = insertelement <4 x i16> poison, i16 %104, i64 0
  %add243.1.2 = fadd contract float %sums.sroa.28.2, %99
  %105 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %99)
  %probs.sroa.0.2.vec.insert1874 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1828, i16 %105, i64 1
  %add243.2.2 = fadd contract float %sums.sroa.54.2, %101
  %106 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %101)
  %probs.sroa.0.4.vec.insert1919 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1874, i16 %106, i64 2
  %add243.3.2 = fadd contract float %sums.sroa.80.2, %103
  %107 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %103)
  %probs.sroa.0.6.vec.insert1941 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1919, i16 %107, i64 3
  br label %if.end267.2

if.end267.2:                                      ; preds = %if.end267.1, %if.end201.2
  %sums.sroa.80.3 = phi float [ %add243.3.2, %if.end201.2 ], [ %sums.sroa.80.2, %if.end267.1 ]
  %sums.sroa.54.3 = phi float [ %add243.2.2, %if.end201.2 ], [ %sums.sroa.54.2, %if.end267.1 ]
  %sums.sroa.28.3 = phi float [ %add243.1.2, %if.end201.2 ], [ %sums.sroa.28.2, %if.end267.1 ]
  %sums.sroa.0.3 = phi float [ %add243.2799, %if.end201.2 ], [ %sums.sroa.0.2, %if.end267.1 ]
  %probs.sroa.0.2 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1941, %if.end201.2 ], [ zeroinitializer, %if.end267.1 ]
  %add276.2 = or disjoint i32 %and274, 512
  %add.ptr278.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add276.2
  store <4 x i16> %probs.sroa.0.2, ptr addrspace(3) %add.ptr278.2, align 8
  br i1 %or.cond765.3, label %if.end267.3, label %if.then170.3

if.then170.3:                                     ; preds = %if.end267.2
  %cmp173.3 = icmp sgt i32 %mul11.3, %invariant.op
  br i1 %cmp173.3, label %for.cond175.preheader.3, label %if.end201.3

for.cond175.preheader.3:                          ; preds = %if.then170.3
  %add183.3 = or disjoint i32 %mul11.3, %mul182
  %cmp186.not.3800 = icmp sgt i32 %add183.3, %1
  %spec.select.3801 = select i1 %cmp186.not.3800, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1316 = insertelement <4 x float> poison, float %spec.select.3801, i64 0
  %cmp186.not.1.3.not = icmp slt i32 %add183.3, %1
  %spec.select.1.3 = select i1 %cmp186.not.1.3.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1449 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1316, float %spec.select.1.3, i64 1
  %add184.2.3 = or disjoint i32 %add183.3, 2
  %cmp186.not.2.3 = icmp sgt i32 %add184.2.3, %1
  %spec.select.2.3 = select i1 %cmp186.not.2.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1566 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1449, float %spec.select.2.3, i64 2
  %add184.3.3 = or disjoint i32 %add183.3, 3
  %cmp186.not.3.3 = icmp sgt i32 %add184.3.3, %1
  %spec.select.3.3 = select i1 %cmp186.not.3.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1683 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1566, float %spec.select.3.3, i64 3
  br label %if.end201.3

if.end201.3:                                      ; preds = %if.then170.3, %for.cond175.preheader.3
  %scores.sroa.0.6 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1683, %for.cond175.preheader.3 ], [ zeroinitializer, %if.then170.3 ]
  %108 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.56.0, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.6)
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.62.0, <4 x half> %qr.sroa.15.0, <4 x float> %108)
  %110 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.65.0, <4 x half> %qr.sroa.27.0, <4 x float> %109)
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.71.0, <4 x half> %qr.sroa.40.0, <4 x float> %110)
  %scores.sroa.0.0.vec.extract1318 = extractelement <4 x float> %111, i64 0
  %mul227.3804 = fmul contract float %scores.sroa.0.0.vec.extract1318, 0x3FB99999A0000000
  %112 = tail call contract noundef float @llvm.minnum.f32(float %mul227.3804, float 0x4024CB5EC0000000)
  %113 = tail call contract noundef float @llvm.exp.f32(float %112)
  %scores.sroa.0.4.vec.extract1451 = extractelement <4 x float> %111, i64 1
  %mul227.1.3 = fmul contract float %scores.sroa.0.4.vec.extract1451, 0x3FB99999A0000000
  %114 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1.3, float 0x4024CB5EC0000000)
  %115 = tail call contract noundef float @llvm.exp.f32(float %114)
  %scores.sroa.0.8.vec.extract1568 = extractelement <4 x float> %111, i64 2
  %mul227.2.3 = fmul contract float %scores.sroa.0.8.vec.extract1568, 0x3FB99999A0000000
  %116 = tail call contract noundef float @llvm.minnum.f32(float %mul227.2.3, float 0x4024CB5EC0000000)
  %117 = tail call contract noundef float @llvm.exp.f32(float %116)
  %scores.sroa.0.12.vec.extract1685 = extractelement <4 x float> %111, i64 3
  %mul227.3.3 = fmul contract float %scores.sroa.0.12.vec.extract1685, 0x3FB99999A0000000
  %118 = tail call contract noundef float @llvm.minnum.f32(float %mul227.3.3, float 0x4024CB5EC0000000)
  %119 = tail call contract noundef float @llvm.exp.f32(float %118)
  %add243.3805 = fadd contract float %sums.sroa.0.3, %113
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %113)
  %probs.sroa.0.0.vec.insert1830 = insertelement <4 x i16> poison, i16 %120, i64 0
  %add243.1.3 = fadd contract float %sums.sroa.28.3, %115
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %115)
  %probs.sroa.0.2.vec.insert1876 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1830, i16 %121, i64 1
  %add243.2.3 = fadd contract float %sums.sroa.54.3, %117
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %117)
  %probs.sroa.0.4.vec.insert1921 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1876, i16 %122, i64 2
  %add243.3.3 = fadd contract float %sums.sroa.80.3, %119
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %119)
  %probs.sroa.0.6.vec.insert1943 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1921, i16 %123, i64 3
  br label %if.end267.3

if.end267.3:                                      ; preds = %if.end267.2, %if.end201.3
  %sums.sroa.80.4 = phi float [ %add243.3.3, %if.end201.3 ], [ %sums.sroa.80.3, %if.end267.2 ]
  %sums.sroa.54.4 = phi float [ %add243.2.3, %if.end201.3 ], [ %sums.sroa.54.3, %if.end267.2 ]
  %sums.sroa.28.4 = phi float [ %add243.1.3, %if.end201.3 ], [ %sums.sroa.28.3, %if.end267.2 ]
  %sums.sroa.0.4 = phi float [ %add243.3805, %if.end201.3 ], [ %sums.sroa.0.3, %if.end267.2 ]
  %probs.sroa.0.3 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1943, %if.end201.3 ], [ zeroinitializer, %if.end267.2 ]
  %add276.3 = or disjoint i32 %and274, 768
  %add.ptr278.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add276.3
  store <4 x i16> %probs.sroa.0.3, ptr addrspace(3) %add.ptr278.3, align 8
  br label %if.end428

if.end428:                                        ; preds = %if.end, %if.end267.3
  %sums.sroa.80.5 = phi float [ 0.000000e+00, %if.end ], [ %sums.sroa.80.4, %if.end267.3 ]
  %sums.sroa.54.5 = phi float [ 0.000000e+00, %if.end ], [ %sums.sroa.54.4, %if.end267.3 ]
  %sums.sroa.28.5 = phi float [ 0.000000e+00, %if.end ], [ %sums.sroa.28.4, %if.end267.3 ]
  %sums.sroa.0.5 = phi float [ 0.000000e+00, %if.end ], [ %sums.sroa.0.4, %if.end267.3 ]
  %kr.sroa.71.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.71.0, %if.end267.3 ]
  %kr.sroa.65.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.65.0, %if.end267.3 ]
  %kr.sroa.62.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.62.0, %if.end267.3 ]
  %kr.sroa.56.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.56.0, %if.end267.3 ]
  %kr.sroa.53.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.53.0, %if.end267.3 ]
  %kr.sroa.47.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.47.0, %if.end267.3 ]
  %kr.sroa.44.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.44.0, %if.end267.3 ]
  %kr.sroa.38.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.38.0, %if.end267.3 ]
  %kr.sroa.35.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.35.0, %if.end267.3 ]
  %kr.sroa.29.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.29.0, %if.end267.3 ]
  %kr.sroa.26.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.26.0, %if.end267.3 ]
  %kr.sroa.20.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.20.0, %if.end267.3 ]
  %kr.sroa.17.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.17.0, %if.end267.3 ]
  %kr.sroa.11.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.11.0, %if.end267.3 ]
  %kr.sroa.8.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.8.0, %if.end267.3 ]
  %kr.sroa.0.1 = phi <4 x half> [ undef, %if.end ], [ %kr.sroa.0.0, %if.end267.3 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %cmp108, label %if.end282.1, label %for.cond111.preheader.1

for.cond111.preheader.1:                          ; preds = %if.end428
  %or.cond764.1813 = icmp ugt i32 %mul11.4, 1023
  %cmp124.not.1814 = icmp sgt i32 %mul11.4, %1
  %or.cond765.1815 = or i1 %or.cond764.1813, %cmp124.not.1814
  br i1 %or.cond765.1815, label %if.end152.1822, label %for.cond126.preheader.1818

for.cond126.preheader.1818:                       ; preds = %for.cond111.preheader.1
  %124 = shl nsw i32 %cond.i.i727.4, 10
  %mul133.1816 = and i32 %124, 64512
  %add134.1817 = or disjoint i32 %mul133.1816, %mul131
  %125 = zext nneg i32 %add134.1817 to i64
  %126 = or disjoint i64 %125, %26
  %add.ptr142.1819 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %126
  %kr.sroa.0.0.copyload1962 = load <4 x half>, ptr addrspace(4) %add.ptr142.1819, align 16
  %kr.sroa.8.0.add.ptr142.1819.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1819, i64 8
  %kr.sroa.8.0.copyload1964 = load <4 x half>, ptr addrspace(4) %kr.sroa.8.0.add.ptr142.1819.sroa_idx, align 8
  %127 = or disjoint i64 %125, %26
  %128 = or disjoint i64 %127, 512
  %add.ptr142.1.1820 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %128
  %kr.sroa.11.16.copyload1970 = load <4 x half>, ptr addrspace(4) %add.ptr142.1.1820, align 16
  %kr.sroa.17.16.add.ptr142.1.1820.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1.1820, i64 8
  %kr.sroa.17.16.copyload1972 = load <4 x half>, ptr addrspace(4) %kr.sroa.17.16.add.ptr142.1.1820.sroa_idx, align 8
  br label %if.end152.1822

if.end152.1822:                                   ; preds = %for.cond126.preheader.1818, %for.cond111.preheader.1
  %kr.sroa.17.2 = phi <4 x half> [ %kr.sroa.17.1, %for.cond111.preheader.1 ], [ %kr.sroa.17.16.copyload1972, %for.cond126.preheader.1818 ]
  %kr.sroa.11.2 = phi <4 x half> [ %kr.sroa.11.1, %for.cond111.preheader.1 ], [ %kr.sroa.11.16.copyload1970, %for.cond126.preheader.1818 ]
  %kr.sroa.8.2 = phi <4 x half> [ %kr.sroa.8.1, %for.cond111.preheader.1 ], [ %kr.sroa.8.0.copyload1964, %for.cond126.preheader.1818 ]
  %kr.sroa.0.2 = phi <4 x half> [ %kr.sroa.0.1, %for.cond111.preheader.1 ], [ %kr.sroa.0.0.copyload1962, %for.cond126.preheader.1818 ]
  %or.cond764.1.1 = icmp ugt i32 %mul11.5, 1023
  %cmp124.not.1.1 = icmp sgt i32 %mul11.5, %1
  %or.cond765.1.1 = or i1 %or.cond764.1.1, %cmp124.not.1.1
  br i1 %or.cond765.1.1, label %if.end152.1.1, label %for.cond126.preheader.1.1

for.cond126.preheader.1.1:                        ; preds = %if.end152.1822
  %129 = shl nsw i32 %cond.i.i727.5, 10
  %mul133.1.1 = and i32 %129, 64512
  %add134.1.1 = or disjoint i32 %mul133.1.1, %mul131
  %130 = zext nneg i32 %add134.1.1 to i64
  %131 = or disjoint i64 %130, %26
  %add.ptr142.1785.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %131
  %kr.sroa.20.32.copyload1978 = load <4 x half>, ptr addrspace(4) %add.ptr142.1785.1, align 16
  %kr.sroa.26.32.add.ptr142.1785.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1785.1, i64 8
  %kr.sroa.26.32.copyload1980 = load <4 x half>, ptr addrspace(4) %kr.sroa.26.32.add.ptr142.1785.1.sroa_idx, align 8
  %132 = or disjoint i64 %130, %26
  %133 = or disjoint i64 %132, 512
  %add.ptr142.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %133
  %kr.sroa.29.48.copyload1986 = load <4 x half>, ptr addrspace(4) %add.ptr142.1.1.1, align 16
  %kr.sroa.35.48.add.ptr142.1.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1.1.1, i64 8
  %kr.sroa.35.48.copyload1988 = load <4 x half>, ptr addrspace(4) %kr.sroa.35.48.add.ptr142.1.1.1.sroa_idx, align 8
  br label %if.end152.1.1

if.end152.1.1:                                    ; preds = %for.cond126.preheader.1.1, %if.end152.1822
  %kr.sroa.35.2 = phi <4 x half> [ %kr.sroa.35.1, %if.end152.1822 ], [ %kr.sroa.35.48.copyload1988, %for.cond126.preheader.1.1 ]
  %kr.sroa.29.2 = phi <4 x half> [ %kr.sroa.29.1, %if.end152.1822 ], [ %kr.sroa.29.48.copyload1986, %for.cond126.preheader.1.1 ]
  %kr.sroa.26.2 = phi <4 x half> [ %kr.sroa.26.1, %if.end152.1822 ], [ %kr.sroa.26.32.copyload1980, %for.cond126.preheader.1.1 ]
  %kr.sroa.20.2 = phi <4 x half> [ %kr.sroa.20.1, %if.end152.1822 ], [ %kr.sroa.20.32.copyload1978, %for.cond126.preheader.1.1 ]
  %or.cond764.2.1 = icmp ugt i32 %mul11.6, 1023
  %cmp124.not.2.1 = icmp sgt i32 %mul11.6, %1
  %or.cond765.2.1 = or i1 %or.cond764.2.1, %cmp124.not.2.1
  br i1 %or.cond765.2.1, label %if.end152.2.1, label %for.cond126.preheader.2.1

for.cond126.preheader.2.1:                        ; preds = %if.end152.1.1
  %134 = shl nsw i32 %cond.i.i727.6, 10
  %mul133.2.1 = and i32 %134, 64512
  %add134.2.1 = or disjoint i32 %mul133.2.1, %mul131
  %135 = zext nneg i32 %add134.2.1 to i64
  %136 = or disjoint i64 %135, %26
  %add.ptr142.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %136
  %kr.sroa.38.64.copyload1994 = load <4 x half>, ptr addrspace(4) %add.ptr142.2.1, align 16
  %kr.sroa.44.64.add.ptr142.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.2.1, i64 8
  %kr.sroa.44.64.copyload1996 = load <4 x half>, ptr addrspace(4) %kr.sroa.44.64.add.ptr142.2.1.sroa_idx, align 8
  %137 = or disjoint i64 %135, %26
  %138 = or disjoint i64 %137, 512
  %add.ptr142.1.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %138
  %kr.sroa.47.80.copyload2002 = load <4 x half>, ptr addrspace(4) %add.ptr142.1.2.1, align 16
  %kr.sroa.53.80.add.ptr142.1.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1.2.1, i64 8
  %kr.sroa.53.80.copyload2004 = load <4 x half>, ptr addrspace(4) %kr.sroa.53.80.add.ptr142.1.2.1.sroa_idx, align 8
  br label %if.end152.2.1

if.end152.2.1:                                    ; preds = %for.cond126.preheader.2.1, %if.end152.1.1
  %kr.sroa.53.2 = phi <4 x half> [ %kr.sroa.53.1, %if.end152.1.1 ], [ %kr.sroa.53.80.copyload2004, %for.cond126.preheader.2.1 ]
  %kr.sroa.47.2 = phi <4 x half> [ %kr.sroa.47.1, %if.end152.1.1 ], [ %kr.sroa.47.80.copyload2002, %for.cond126.preheader.2.1 ]
  %kr.sroa.44.2 = phi <4 x half> [ %kr.sroa.44.1, %if.end152.1.1 ], [ %kr.sroa.44.64.copyload1996, %for.cond126.preheader.2.1 ]
  %kr.sroa.38.2 = phi <4 x half> [ %kr.sroa.38.1, %if.end152.1.1 ], [ %kr.sroa.38.64.copyload1994, %for.cond126.preheader.2.1 ]
  %or.cond764.3.1 = icmp ugt i32 %mul11.7, 1023
  %cmp124.not.3.1 = icmp sgt i32 %mul11.7, %1
  %or.cond765.3.1 = or i1 %or.cond764.3.1, %cmp124.not.3.1
  br i1 %or.cond765.3.1, label %if.end152.3.1, label %for.cond126.preheader.3.1

for.cond126.preheader.3.1:                        ; preds = %if.end152.2.1
  %139 = shl nsw i32 %cond.i.i727.7, 10
  %mul133.3.1 = and i32 %139, 64512
  %add134.3.1 = or disjoint i32 %mul133.3.1, %mul131
  %140 = zext nneg i32 %add134.3.1 to i64
  %141 = or disjoint i64 %140, %26
  %add.ptr142.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %141
  %kr.sroa.56.96.copyload2010 = load <4 x half>, ptr addrspace(4) %add.ptr142.3.1, align 16
  %kr.sroa.62.96.add.ptr142.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.3.1, i64 8
  %kr.sroa.62.96.copyload2012 = load <4 x half>, ptr addrspace(4) %kr.sroa.62.96.add.ptr142.3.1.sroa_idx, align 8
  %142 = or disjoint i64 %140, %26
  %143 = or disjoint i64 %142, 512
  %add.ptr142.1.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %143
  %kr.sroa.65.112.copyload2018 = load <4 x half>, ptr addrspace(4) %add.ptr142.1.3.1, align 16
  %kr.sroa.71.112.add.ptr142.1.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr142.1.3.1, i64 8
  %kr.sroa.71.112.copyload2020 = load <4 x half>, ptr addrspace(4) %kr.sroa.71.112.add.ptr142.1.3.1.sroa_idx, align 8
  br label %if.end152.3.1

if.end152.3.1:                                    ; preds = %for.cond126.preheader.3.1, %if.end152.2.1
  %kr.sroa.71.2 = phi <4 x half> [ %kr.sroa.71.1, %if.end152.2.1 ], [ %kr.sroa.71.112.copyload2020, %for.cond126.preheader.3.1 ]
  %kr.sroa.65.2 = phi <4 x half> [ %kr.sroa.65.1, %if.end152.2.1 ], [ %kr.sroa.65.112.copyload2018, %for.cond126.preheader.3.1 ]
  %kr.sroa.62.2 = phi <4 x half> [ %kr.sroa.62.1, %if.end152.2.1 ], [ %kr.sroa.62.96.copyload2012, %for.cond126.preheader.3.1 ]
  %kr.sroa.56.2 = phi <4 x half> [ %kr.sroa.56.1, %if.end152.2.1 ], [ %kr.sroa.56.96.copyload2010, %for.cond126.preheader.3.1 ]
  br i1 %or.cond765.1815, label %if.end267.1878, label %if.then170.1828

if.then170.1828:                                  ; preds = %if.end152.3.1
  %cmp173.1827 = icmp sgt i32 %mul11.4, %invariant.op
  br i1 %cmp173.1827, label %for.cond175.preheader.1831, label %if.end201.1848

for.cond175.preheader.1831:                       ; preds = %if.then170.1828
  %add183.1830 = or disjoint i32 %mul11.4, %mul182
  %cmp186.not.1832 = icmp sgt i32 %add183.1830, %1
  %spec.select.1833 = select i1 %cmp186.not.1832, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1326 = insertelement <4 x float> poison, float %spec.select.1833, i64 0
  %cmp186.not.1.1835.not = icmp slt i32 %add183.1830, %1
  %spec.select.1.1836 = select i1 %cmp186.not.1.1835.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1457 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1326, float %spec.select.1.1836, i64 1
  %add184.2.1838 = or disjoint i32 %add183.1830, 2
  %cmp186.not.2.1839 = icmp sgt i32 %add184.2.1838, %1
  %spec.select.2.1840 = select i1 %cmp186.not.2.1839, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1574 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1457, float %spec.select.2.1840, i64 2
  %add184.3.1842 = or disjoint i32 %add183.1830, 3
  %cmp186.not.3.1843 = icmp sgt i32 %add184.3.1842, %1
  %spec.select.3.1844 = select i1 %cmp186.not.3.1843, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1691 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1574, float %spec.select.3.1844, i64 3
  br label %if.end201.1848

if.end201.1848:                                   ; preds = %if.then170.1828, %for.cond175.preheader.1831
  %scores.sroa.0.9 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1691, %for.cond175.preheader.1831 ], [ zeroinitializer, %if.then170.1828 ]
  %144 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.0.2, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.9)
  %145 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.8.2, <4 x half> %qr.sroa.15.0, <4 x float> %144)
  %146 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.11.2, <4 x half> %qr.sroa.27.0, <4 x float> %145)
  %147 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.17.2, <4 x half> %qr.sroa.40.0, <4 x float> %146)
  %scores.sroa.0.0.vec.extract1328 = extractelement <4 x float> %147, i64 0
  %mul227.1853 = fmul contract float %scores.sroa.0.0.vec.extract1328, 0x3FB99999A0000000
  %148 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1853, float 0x4024CB5EC0000000)
  %149 = tail call contract noundef float @llvm.exp.f32(float %148)
  %scores.sroa.0.4.vec.extract1459 = extractelement <4 x float> %147, i64 1
  %mul227.1.1855 = fmul contract float %scores.sroa.0.4.vec.extract1459, 0x3FB99999A0000000
  %150 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1.1855, float 0x4024CB5EC0000000)
  %151 = tail call contract noundef float @llvm.exp.f32(float %150)
  %scores.sroa.0.8.vec.extract1576 = extractelement <4 x float> %147, i64 2
  %mul227.2.1857 = fmul contract float %scores.sroa.0.8.vec.extract1576, 0x3FB99999A0000000
  %152 = tail call contract noundef float @llvm.minnum.f32(float %mul227.2.1857, float 0x4024CB5EC0000000)
  %153 = tail call contract noundef float @llvm.exp.f32(float %152)
  %scores.sroa.0.12.vec.extract1693 = extractelement <4 x float> %147, i64 3
  %mul227.3.1859 = fmul contract float %scores.sroa.0.12.vec.extract1693, 0x3FB99999A0000000
  %154 = tail call contract noundef float @llvm.minnum.f32(float %mul227.3.1859, float 0x4024CB5EC0000000)
  %155 = tail call contract noundef float @llvm.exp.f32(float %154)
  %add243.1861 = fadd contract float %sums.sroa.0.5, %149
  %156 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %149)
  %probs.sroa.0.0.vec.insert1832 = insertelement <4 x i16> poison, i16 %156, i64 0
  %add243.1.1864 = fadd contract float %sums.sroa.28.5, %151
  %157 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %151)
  %probs.sroa.0.2.vec.insert1878 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1832, i16 %157, i64 1
  %add243.2.1868 = fadd contract float %sums.sroa.54.5, %153
  %158 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %153)
  %probs.sroa.0.4.vec.insert1923 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1878, i16 %158, i64 2
  %add243.3.1872 = fadd contract float %sums.sroa.80.5, %155
  %159 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %155)
  %probs.sroa.0.6.vec.insert1945 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1923, i16 %159, i64 3
  br label %if.end267.1878

if.end267.1878:                                   ; preds = %if.end152.3.1, %if.end201.1848
  %sums.sroa.80.6 = phi float [ %add243.3.1872, %if.end201.1848 ], [ %sums.sroa.80.5, %if.end152.3.1 ]
  %sums.sroa.54.6 = phi float [ %add243.2.1868, %if.end201.1848 ], [ %sums.sroa.54.5, %if.end152.3.1 ]
  %sums.sroa.28.6 = phi float [ %add243.1.1864, %if.end201.1848 ], [ %sums.sroa.28.5, %if.end152.3.1 ]
  %sums.sroa.0.6 = phi float [ %add243.1861, %if.end201.1848 ], [ %sums.sroa.0.5, %if.end152.3.1 ]
  %probs.sroa.0.10 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1945, %if.end201.1848 ], [ zeroinitializer, %if.end152.3.1 ]
  %add276.1876 = or disjoint i32 %and274, 1024
  %add.ptr278.1877 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add276.1876
  store <4 x i16> %probs.sroa.0.10, ptr addrspace(3) %add.ptr278.1877, align 8
  br i1 %or.cond765.1.1, label %if.end267.1.1, label %if.then170.1.1

if.then170.1.1:                                   ; preds = %if.end267.1878
  %cmp173.1.1 = icmp sgt i32 %mul11.5, %invariant.op
  br i1 %cmp173.1.1, label %for.cond175.preheader.1.1, label %if.end201.1.1

for.cond175.preheader.1.1:                        ; preds = %if.then170.1.1
  %add183.1.1 = or disjoint i32 %mul11.5, %mul182
  %cmp186.not.1788.1 = icmp sgt i32 %add183.1.1, %1
  %spec.select.1789.1 = select i1 %cmp186.not.1788.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1336 = insertelement <4 x float> poison, float %spec.select.1789.1, i64 0
  %cmp186.not.1.1.1.not = icmp slt i32 %add183.1.1, %1
  %spec.select.1.1.1 = select i1 %cmp186.not.1.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1465 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1336, float %spec.select.1.1.1, i64 1
  %add184.2.1.1 = or disjoint i32 %add183.1.1, 2
  %cmp186.not.2.1.1 = icmp sgt i32 %add184.2.1.1, %1
  %spec.select.2.1.1 = select i1 %cmp186.not.2.1.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1582 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1465, float %spec.select.2.1.1, i64 2
  %add184.3.1.1 = or disjoint i32 %add183.1.1, 3
  %cmp186.not.3.1.1 = icmp sgt i32 %add184.3.1.1, %1
  %spec.select.3.1.1 = select i1 %cmp186.not.3.1.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1699 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1582, float %spec.select.3.1.1, i64 3
  br label %if.end201.1.1

if.end201.1.1:                                    ; preds = %if.then170.1.1, %for.cond175.preheader.1.1
  %scores.sroa.0.11 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1699, %for.cond175.preheader.1.1 ], [ zeroinitializer, %if.then170.1.1 ]
  %160 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.20.2, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.11)
  %161 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.26.2, <4 x half> %qr.sroa.15.0, <4 x float> %160)
  %162 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.29.2, <4 x half> %qr.sroa.27.0, <4 x float> %161)
  %163 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.35.2, <4 x half> %qr.sroa.40.0, <4 x float> %162)
  %scores.sroa.0.0.vec.extract1338 = extractelement <4 x float> %163, i64 0
  %mul227.1792.1 = fmul contract float %scores.sroa.0.0.vec.extract1338, 0x3FB99999A0000000
  %164 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1792.1, float 0x4024CB5EC0000000)
  %165 = tail call contract noundef float @llvm.exp.f32(float %164)
  %scores.sroa.0.4.vec.extract1467 = extractelement <4 x float> %163, i64 1
  %mul227.1.1.1 = fmul contract float %scores.sroa.0.4.vec.extract1467, 0x3FB99999A0000000
  %166 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1.1.1, float 0x4024CB5EC0000000)
  %167 = tail call contract noundef float @llvm.exp.f32(float %166)
  %scores.sroa.0.8.vec.extract1584 = extractelement <4 x float> %163, i64 2
  %mul227.2.1.1 = fmul contract float %scores.sroa.0.8.vec.extract1584, 0x3FB99999A0000000
  %168 = tail call contract noundef float @llvm.minnum.f32(float %mul227.2.1.1, float 0x4024CB5EC0000000)
  %169 = tail call contract noundef float @llvm.exp.f32(float %168)
  %scores.sroa.0.12.vec.extract1701 = extractelement <4 x float> %163, i64 3
  %mul227.3.1.1 = fmul contract float %scores.sroa.0.12.vec.extract1701, 0x3FB99999A0000000
  %170 = tail call contract noundef float @llvm.minnum.f32(float %mul227.3.1.1, float 0x4024CB5EC0000000)
  %171 = tail call contract noundef float @llvm.exp.f32(float %170)
  %add243.1793.1 = fadd contract float %sums.sroa.0.6, %165
  %172 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %165)
  %probs.sroa.0.0.vec.insert1834 = insertelement <4 x i16> poison, i16 %172, i64 0
  %add243.1.1.1 = fadd contract float %sums.sroa.28.6, %167
  %173 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %167)
  %probs.sroa.0.2.vec.insert1880 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1834, i16 %173, i64 1
  %add243.2.1.1 = fadd contract float %sums.sroa.54.6, %169
  %174 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %169)
  %probs.sroa.0.4.vec.insert1925 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1880, i16 %174, i64 2
  %add243.3.1.1 = fadd contract float %sums.sroa.80.6, %171
  %175 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %171)
  %probs.sroa.0.6.vec.insert1947 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1925, i16 %175, i64 3
  br label %if.end267.1.1

if.end267.1.1:                                    ; preds = %if.end267.1878, %if.end201.1.1
  %sums.sroa.80.7 = phi float [ %add243.3.1.1, %if.end201.1.1 ], [ %sums.sroa.80.6, %if.end267.1878 ]
  %sums.sroa.54.7 = phi float [ %add243.2.1.1, %if.end201.1.1 ], [ %sums.sroa.54.6, %if.end267.1878 ]
  %sums.sroa.28.7 = phi float [ %add243.1.1.1, %if.end201.1.1 ], [ %sums.sroa.28.6, %if.end267.1878 ]
  %sums.sroa.0.7 = phi float [ %add243.1793.1, %if.end201.1.1 ], [ %sums.sroa.0.6, %if.end267.1878 ]
  %probs.sroa.0.11 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1947, %if.end201.1.1 ], [ zeroinitializer, %if.end267.1878 ]
  %add276.1.1 = or disjoint i32 %and274, 1280
  %add.ptr278.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add276.1.1
  store <4 x i16> %probs.sroa.0.11, ptr addrspace(3) %add.ptr278.1.1, align 8
  br i1 %or.cond765.2.1, label %if.end267.2.1, label %if.then170.2.1

if.then170.2.1:                                   ; preds = %if.end267.1.1
  %cmp173.2.1 = icmp sgt i32 %mul11.6, %invariant.op
  br i1 %cmp173.2.1, label %for.cond175.preheader.2.1, label %if.end201.2.1

for.cond175.preheader.2.1:                        ; preds = %if.then170.2.1
  %add183.2.1 = or disjoint i32 %mul11.6, %mul182
  %cmp186.not.2794.1 = icmp sgt i32 %add183.2.1, %1
  %spec.select.2795.1 = select i1 %cmp186.not.2794.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1346 = insertelement <4 x float> poison, float %spec.select.2795.1, i64 0
  %cmp186.not.1.2.1.not = icmp slt i32 %add183.2.1, %1
  %spec.select.1.2.1 = select i1 %cmp186.not.1.2.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1473 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1346, float %spec.select.1.2.1, i64 1
  %add184.2.2.1 = or disjoint i32 %add183.2.1, 2
  %cmp186.not.2.2.1 = icmp sgt i32 %add184.2.2.1, %1
  %spec.select.2.2.1 = select i1 %cmp186.not.2.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1590 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1473, float %spec.select.2.2.1, i64 2
  %add184.3.2.1 = or disjoint i32 %add183.2.1, 3
  %cmp186.not.3.2.1 = icmp sgt i32 %add184.3.2.1, %1
  %spec.select.3.2.1 = select i1 %cmp186.not.3.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1707 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1590, float %spec.select.3.2.1, i64 3
  br label %if.end201.2.1

if.end201.2.1:                                    ; preds = %if.then170.2.1, %for.cond175.preheader.2.1
  %scores.sroa.0.13 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1707, %for.cond175.preheader.2.1 ], [ zeroinitializer, %if.then170.2.1 ]
  %176 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.38.2, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.13)
  %177 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.44.2, <4 x half> %qr.sroa.15.0, <4 x float> %176)
  %178 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.47.2, <4 x half> %qr.sroa.27.0, <4 x float> %177)
  %179 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.53.2, <4 x half> %qr.sroa.40.0, <4 x float> %178)
  %scores.sroa.0.0.vec.extract1348 = extractelement <4 x float> %179, i64 0
  %mul227.2798.1 = fmul contract float %scores.sroa.0.0.vec.extract1348, 0x3FB99999A0000000
  %180 = tail call contract noundef float @llvm.minnum.f32(float %mul227.2798.1, float 0x4024CB5EC0000000)
  %181 = tail call contract noundef float @llvm.exp.f32(float %180)
  %scores.sroa.0.4.vec.extract1475 = extractelement <4 x float> %179, i64 1
  %mul227.1.2.1 = fmul contract float %scores.sroa.0.4.vec.extract1475, 0x3FB99999A0000000
  %182 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1.2.1, float 0x4024CB5EC0000000)
  %183 = tail call contract noundef float @llvm.exp.f32(float %182)
  %scores.sroa.0.8.vec.extract1592 = extractelement <4 x float> %179, i64 2
  %mul227.2.2.1 = fmul contract float %scores.sroa.0.8.vec.extract1592, 0x3FB99999A0000000
  %184 = tail call contract noundef float @llvm.minnum.f32(float %mul227.2.2.1, float 0x4024CB5EC0000000)
  %185 = tail call contract noundef float @llvm.exp.f32(float %184)
  %scores.sroa.0.12.vec.extract1709 = extractelement <4 x float> %179, i64 3
  %mul227.3.2.1 = fmul contract float %scores.sroa.0.12.vec.extract1709, 0x3FB99999A0000000
  %186 = tail call contract noundef float @llvm.minnum.f32(float %mul227.3.2.1, float 0x4024CB5EC0000000)
  %187 = tail call contract noundef float @llvm.exp.f32(float %186)
  %add243.2799.1 = fadd contract float %sums.sroa.0.7, %181
  %188 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %181)
  %probs.sroa.0.0.vec.insert1836 = insertelement <4 x i16> poison, i16 %188, i64 0
  %add243.1.2.1 = fadd contract float %sums.sroa.28.7, %183
  %189 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %183)
  %probs.sroa.0.2.vec.insert1882 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1836, i16 %189, i64 1
  %add243.2.2.1 = fadd contract float %sums.sroa.54.7, %185
  %190 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %185)
  %probs.sroa.0.4.vec.insert1927 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1882, i16 %190, i64 2
  %add243.3.2.1 = fadd contract float %sums.sroa.80.7, %187
  %191 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %187)
  %probs.sroa.0.6.vec.insert1949 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1927, i16 %191, i64 3
  br label %if.end267.2.1

if.end267.2.1:                                    ; preds = %if.end267.1.1, %if.end201.2.1
  %sums.sroa.80.8 = phi float [ %add243.3.2.1, %if.end201.2.1 ], [ %sums.sroa.80.7, %if.end267.1.1 ]
  %sums.sroa.54.8 = phi float [ %add243.2.2.1, %if.end201.2.1 ], [ %sums.sroa.54.7, %if.end267.1.1 ]
  %sums.sroa.28.8 = phi float [ %add243.1.2.1, %if.end201.2.1 ], [ %sums.sroa.28.7, %if.end267.1.1 ]
  %sums.sroa.0.8 = phi float [ %add243.2799.1, %if.end201.2.1 ], [ %sums.sroa.0.7, %if.end267.1.1 ]
  %probs.sroa.0.12 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1949, %if.end201.2.1 ], [ zeroinitializer, %if.end267.1.1 ]
  %add276.2.1 = or disjoint i32 %and274, 1536
  %add.ptr278.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add276.2.1
  store <4 x i16> %probs.sroa.0.12, ptr addrspace(3) %add.ptr278.2.1, align 8
  br i1 %or.cond765.3.1, label %if.end267.3.1, label %if.then170.3.1

if.then170.3.1:                                   ; preds = %if.end267.2.1
  %cmp173.3.1 = icmp sgt i32 %mul11.7, %invariant.op
  br i1 %cmp173.3.1, label %for.cond175.preheader.3.1, label %if.end201.3.1

for.cond175.preheader.3.1:                        ; preds = %if.then170.3.1
  %add183.3.1 = or disjoint i32 %mul11.7, %mul182
  %cmp186.not.3800.1 = icmp sgt i32 %add183.3.1, %1
  %spec.select.3801.1 = select i1 %cmp186.not.3800.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert1356 = insertelement <4 x float> poison, float %spec.select.3801.1, i64 0
  %cmp186.not.1.3.1.not = icmp slt i32 %add183.3.1, %1
  %spec.select.1.3.1 = select i1 %cmp186.not.1.3.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert1481 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1356, float %spec.select.1.3.1, i64 1
  %add184.2.3.1 = or disjoint i32 %add183.3.1, 2
  %cmp186.not.2.3.1 = icmp sgt i32 %add184.2.3.1, %1
  %spec.select.2.3.1 = select i1 %cmp186.not.2.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert1598 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1481, float %spec.select.2.3.1, i64 2
  %add184.3.3.1 = or disjoint i32 %add183.3.1, 3
  %cmp186.not.3.3.1 = icmp sgt i32 %add184.3.3.1, %1
  %spec.select.3.3.1 = select i1 %cmp186.not.3.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert1715 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1598, float %spec.select.3.3.1, i64 3
  br label %if.end201.3.1

if.end201.3.1:                                    ; preds = %if.then170.3.1, %for.cond175.preheader.3.1
  %scores.sroa.0.15 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1715, %for.cond175.preheader.3.1 ], [ zeroinitializer, %if.then170.3.1 ]
  %192 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.56.2, <4 x half> %qr.sroa.0.0, <4 x float> %scores.sroa.0.15)
  %193 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.62.2, <4 x half> %qr.sroa.15.0, <4 x float> %192)
  %194 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.65.2, <4 x half> %qr.sroa.27.0, <4 x float> %193)
  %195 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kr.sroa.71.2, <4 x half> %qr.sroa.40.0, <4 x float> %194)
  %scores.sroa.0.0.vec.extract1358 = extractelement <4 x float> %195, i64 0
  %mul227.3804.1 = fmul contract float %scores.sroa.0.0.vec.extract1358, 0x3FB99999A0000000
  %196 = tail call contract noundef float @llvm.minnum.f32(float %mul227.3804.1, float 0x4024CB5EC0000000)
  %197 = tail call contract noundef float @llvm.exp.f32(float %196)
  %scores.sroa.0.4.vec.extract1483 = extractelement <4 x float> %195, i64 1
  %mul227.1.3.1 = fmul contract float %scores.sroa.0.4.vec.extract1483, 0x3FB99999A0000000
  %198 = tail call contract noundef float @llvm.minnum.f32(float %mul227.1.3.1, float 0x4024CB5EC0000000)
  %199 = tail call contract noundef float @llvm.exp.f32(float %198)
  %scores.sroa.0.8.vec.extract1600 = extractelement <4 x float> %195, i64 2
  %mul227.2.3.1 = fmul contract float %scores.sroa.0.8.vec.extract1600, 0x3FB99999A0000000
  %200 = tail call contract noundef float @llvm.minnum.f32(float %mul227.2.3.1, float 0x4024CB5EC0000000)
  %201 = tail call contract noundef float @llvm.exp.f32(float %200)
  %scores.sroa.0.12.vec.extract1717 = extractelement <4 x float> %195, i64 3
  %mul227.3.3.1 = fmul contract float %scores.sroa.0.12.vec.extract1717, 0x3FB99999A0000000
  %202 = tail call contract noundef float @llvm.minnum.f32(float %mul227.3.3.1, float 0x4024CB5EC0000000)
  %203 = tail call contract noundef float @llvm.exp.f32(float %202)
  %add243.3805.1 = fadd contract float %sums.sroa.0.8, %197
  %204 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %197)
  %probs.sroa.0.0.vec.insert1838 = insertelement <4 x i16> poison, i16 %204, i64 0
  %add243.1.3.1 = fadd contract float %sums.sroa.28.8, %199
  %205 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %199)
  %probs.sroa.0.2.vec.insert1884 = insertelement <4 x i16> %probs.sroa.0.0.vec.insert1838, i16 %205, i64 1
  %add243.2.3.1 = fadd contract float %sums.sroa.54.8, %201
  %206 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %201)
  %probs.sroa.0.4.vec.insert1929 = insertelement <4 x i16> %probs.sroa.0.2.vec.insert1884, i16 %206, i64 2
  %add243.3.3.1 = fadd contract float %sums.sroa.80.8, %203
  %207 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %203)
  %probs.sroa.0.6.vec.insert1951 = insertelement <4 x i16> %probs.sroa.0.4.vec.insert1929, i16 %207, i64 3
  br label %if.end267.3.1

if.end267.3.1:                                    ; preds = %if.end267.2.1, %if.end201.3.1
  %sums.sroa.80.9 = phi float [ %add243.3.3.1, %if.end201.3.1 ], [ %sums.sroa.80.8, %if.end267.2.1 ]
  %sums.sroa.54.9 = phi float [ %add243.2.3.1, %if.end201.3.1 ], [ %sums.sroa.54.8, %if.end267.2.1 ]
  %sums.sroa.28.9 = phi float [ %add243.1.3.1, %if.end201.3.1 ], [ %sums.sroa.28.8, %if.end267.2.1 ]
  %sums.sroa.0.9 = phi float [ %add243.3805.1, %if.end201.3.1 ], [ %sums.sroa.0.8, %if.end267.2.1 ]
  %probs.sroa.0.13 = phi <4 x i16> [ %probs.sroa.0.6.vec.insert1951, %if.end201.3.1 ], [ zeroinitializer, %if.end267.2.1 ]
  %add276.3.1 = or disjoint i32 %and274, 1792
  %add.ptr278.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add276.3.1
  store <4 x i16> %probs.sroa.0.13, ptr addrspace(3) %add.ptr278.3.1, align 8
  br label %if.end282.1

if.end282.1:                                      ; preds = %if.end267.3.1, %if.end428
  %sums.sroa.80.10 = phi float [ %sums.sroa.80.5, %if.end428 ], [ %sums.sroa.80.9, %if.end267.3.1 ]
  %sums.sroa.54.10 = phi float [ %sums.sroa.54.5, %if.end428 ], [ %sums.sroa.54.9, %if.end267.3.1 ]
  %sums.sroa.28.10 = phi float [ %sums.sroa.28.5, %if.end428 ], [ %sums.sroa.28.9, %if.end267.3.1 ]
  %sums.sroa.0.10 = phi float [ %sums.sroa.0.5, %if.end428 ], [ %sums.sroa.0.9, %if.end267.3.1 ]
  br i1 %cmp285.not, label %for.cond289.preheader.1, label %if.end428.1

for.cond289.preheader.1:                          ; preds = %if.end282.1
  %or.cond768.1880 = icmp ugt i32 %mul11, 1023
  %cmp302.not.1881 = icmp sgt i32 %mul11, %1
  %or.cond769.1882 = or i1 %or.cond768.1880, %cmp302.not.1881
  br i1 %or.cond769.1882, label %if.end424.1924, label %for.cond342.preheader.1908

for.cond342.preheader.1908:                       ; preds = %for.cond289.preheader.1
  %gep.1890 = getelementptr %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul333
  %208 = load <4 x half>, ptr addrspace(3) %gep.1890, align 8
  %209 = shl nsw i32 %cond.i.i727, 10
  %mul311.1883 = and i32 %209, 64512
  %add312.1884 = or disjoint i32 %mul311.1883, %mul131
  %210 = zext nneg i32 %add312.1884 to i64
  %211 = or disjoint i64 %210, %27
  %212 = or disjoint i64 %211, 512
  %add.ptr320.1.1887 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %212
  %vr.sroa.170.16.add.ptr320.1.1887.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr320.1.1887, i64 8
  %vr.sroa.170.16.copyload1219 = load <4 x half>, ptr addrspace(4) %vr.sroa.170.16.add.ptr320.1.1887.sroa_idx, align 8
  %vr.sroa.110.16.copyload1208 = load <4 x half>, ptr addrspace(4) %add.ptr320.1.1887, align 16
  %213 = or disjoint i64 %210, %27
  %add.ptr320.1886 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %213
  %vr.sroa.62.0.add.ptr320.1886.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr320.1886, i64 8
  %vr.sroa.62.0.copyload1103 = load <4 x half>, ptr addrspace(4) %vr.sroa.62.0.add.ptr320.1886.sroa_idx, align 8
  %vr.sroa.0.0.copyload1092 = load <4 x half>, ptr addrspace(4) %add.ptr320.1886, align 16
  %214 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload1092, <4 x half> %208, <4 x float> zeroinitializer), !call_argsrelate !163
  %215 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.62.0.copyload1103, <4 x half> %208, <4 x float> zeroinitializer), !call_argsrelate !163
  %216 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.110.16.copyload1208, <4 x half> %208, <4 x float> zeroinitializer), !call_argsrelate !163
  %217 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.170.16.copyload1219, <4 x half> %208, <4 x float> zeroinitializer), !call_argsrelate !163
  br label %if.end424.1924

if.end424.1924:                                   ; preds = %for.cond342.preheader.1908, %for.cond289.preheader.1
  %out.sroa.134.6 = phi <4 x float> [ zeroinitializer, %for.cond289.preheader.1 ], [ %217, %for.cond342.preheader.1908 ]
  %out.sroa.90.6 = phi <4 x float> [ zeroinitializer, %for.cond289.preheader.1 ], [ %216, %for.cond342.preheader.1908 ]
  %out.sroa.46.6 = phi <4 x float> [ zeroinitializer, %for.cond289.preheader.1 ], [ %215, %for.cond342.preheader.1908 ]
  %out.sroa.0.6 = phi <4 x float> [ zeroinitializer, %for.cond289.preheader.1 ], [ %214, %for.cond342.preheader.1908 ]
  %or.cond768.1.1 = icmp ugt i32 %mul11.1, 1023
  %cmp302.not.1.1 = icmp sgt i32 %mul11.1, %1
  %or.cond769.1.1 = or i1 %or.cond768.1.1, %cmp302.not.1.1
  br i1 %or.cond769.1.1, label %if.end424.1.1, label %for.cond363.preheader.1.1

for.cond363.preheader.1.1:                        ; preds = %if.end424.1924
  %add334.1.1 = or i32 %and274, 1280
  %gep.1.1 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add334.1.1
  %218 = load <4 x half>, ptr addrspace(3) %gep.1.1, align 8
  %219 = shl nsw i32 %cond.i.i727.1, 10
  %mul311.1.1 = and i32 %219, 64512
  %add312.1.1 = or disjoint i32 %mul311.1.1, %mul131
  %220 = zext nneg i32 %add312.1.1 to i64
  %221 = or disjoint i64 %220, %27
  %222 = or disjoint i64 %221, 512
  %add.ptr320.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %222
  %vr.sroa.170.16.add.ptr320.1.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr320.1.1.1, i64 8
  %vr.sroa.170.16.copyload1220 = load <4 x half>, ptr addrspace(4) %vr.sroa.170.16.add.ptr320.1.1.1.sroa_idx, align 8
  %vr.sroa.110.16.copyload1209 = load <4 x half>, ptr addrspace(4) %add.ptr320.1.1.1, align 16
  %223 = or disjoint i64 %220, %27
  %add.ptr320.1811.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %223
  %vr.sroa.62.0.add.ptr320.1811.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr320.1811.1, i64 8
  %vr.sroa.62.0.copyload1104 = load <4 x half>, ptr addrspace(4) %vr.sroa.62.0.add.ptr320.1811.1.sroa_idx, align 8
  %vr.sroa.0.0.copyload1093 = load <4 x half>, ptr addrspace(4) %add.ptr320.1811.1, align 16
  %224 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload1093, <4 x half> %218, <4 x float> zeroinitializer), !call_argsrelate !163
  %225 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.62.0.copyload1104, <4 x half> %218, <4 x float> zeroinitializer), !call_argsrelate !163
  %226 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.110.16.copyload1209, <4 x half> %218, <4 x float> zeroinitializer), !call_argsrelate !163
  %227 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.170.16.copyload1220, <4 x half> %218, <4 x float> zeroinitializer), !call_argsrelate !163
  br label %if.end424.1.1

if.end424.1.1:                                    ; preds = %for.cond363.preheader.1.1, %if.end424.1924
  %out_1.sroa.98.7 = phi <4 x float> [ zeroinitializer, %if.end424.1924 ], [ %227, %for.cond363.preheader.1.1 ]
  %out_1.sroa.66.7 = phi <4 x float> [ zeroinitializer, %if.end424.1924 ], [ %226, %for.cond363.preheader.1.1 ]
  %out_1.sroa.34.7 = phi <4 x float> [ zeroinitializer, %if.end424.1924 ], [ %225, %for.cond363.preheader.1.1 ]
  %out_1.sroa.0.7 = phi <4 x float> [ zeroinitializer, %if.end424.1924 ], [ %224, %for.cond363.preheader.1.1 ]
  %or.cond768.2.1 = icmp ugt i32 %mul11.2, 1023
  %cmp302.not.2.1 = icmp sgt i32 %mul11.2, %1
  %or.cond769.2.1 = or i1 %or.cond768.2.1, %cmp302.not.2.1
  br i1 %or.cond769.2.1, label %if.end424.2.1, label %for.cond384.preheader.2.1

for.cond384.preheader.2.1:                        ; preds = %if.end424.1.1
  %add334.2.1 = or disjoint i32 %mul333, 1536
  %gep.2.1 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add334.2.1
  %228 = load <4 x half>, ptr addrspace(3) %gep.2.1, align 8
  %229 = shl nsw i32 %cond.i.i727.2, 10
  %mul311.2.1 = and i32 %229, 64512
  %add312.2.1 = or disjoint i32 %mul311.2.1, %mul131
  %230 = zext nneg i32 %add312.2.1 to i64
  %231 = or disjoint i64 %230, %27
  %232 = or disjoint i64 %231, 512
  %add.ptr320.1.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %232
  %vr.sroa.170.16.add.ptr320.1.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr320.1.2.1, i64 8
  %vr.sroa.170.16.copyload1221 = load <4 x half>, ptr addrspace(4) %vr.sroa.170.16.add.ptr320.1.2.1.sroa_idx, align 8
  %vr.sroa.110.16.copyload1210 = load <4 x half>, ptr addrspace(4) %add.ptr320.1.2.1, align 16
  %233 = or disjoint i64 %230, %27
  %add.ptr320.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %233
  %vr.sroa.62.0.add.ptr320.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr320.2.1, i64 8
  %vr.sroa.62.0.copyload1105 = load <4 x half>, ptr addrspace(4) %vr.sroa.62.0.add.ptr320.2.1.sroa_idx, align 8
  %vr.sroa.0.0.copyload1094 = load <4 x half>, ptr addrspace(4) %add.ptr320.2.1, align 16
  %234 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload1094, <4 x half> %228, <4 x float> zeroinitializer), !call_argsrelate !163
  %235 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.62.0.copyload1105, <4 x half> %228, <4 x float> zeroinitializer), !call_argsrelate !163
  %236 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.110.16.copyload1210, <4 x half> %228, <4 x float> zeroinitializer), !call_argsrelate !163
  %237 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.170.16.copyload1221, <4 x half> %228, <4 x float> zeroinitializer), !call_argsrelate !163
  br label %if.end424.2.1

if.end424.2.1:                                    ; preds = %for.cond384.preheader.2.1, %if.end424.1.1
  %out_2.sroa.98.8 = phi <4 x float> [ zeroinitializer, %if.end424.1.1 ], [ %237, %for.cond384.preheader.2.1 ]
  %out_2.sroa.66.8 = phi <4 x float> [ zeroinitializer, %if.end424.1.1 ], [ %236, %for.cond384.preheader.2.1 ]
  %out_2.sroa.34.8 = phi <4 x float> [ zeroinitializer, %if.end424.1.1 ], [ %235, %for.cond384.preheader.2.1 ]
  %out_2.sroa.0.8 = phi <4 x float> [ zeroinitializer, %if.end424.1.1 ], [ %234, %for.cond384.preheader.2.1 ]
  %or.cond768.3.1 = icmp ugt i32 %mul11.3, 1023
  %cmp302.not.3.1 = icmp sgt i32 %mul11.3, %1
  %or.cond769.3.1 = or i1 %or.cond768.3.1, %cmp302.not.3.1
  br i1 %or.cond769.3.1, label %if.end428.1, label %for.cond403.preheader.3.1

for.cond403.preheader.3.1:                        ; preds = %if.end424.2.1
  %add334.3.1 = or i32 %and274, 1792
  %gep.3.1 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add334.3.1
  %238 = load <4 x half>, ptr addrspace(3) %gep.3.1, align 8
  %239 = shl nsw i32 %cond.i.i727.3, 10
  %mul311.3.1 = and i32 %239, 64512
  %add312.3.1 = or disjoint i32 %mul311.3.1, %mul131
  %240 = zext nneg i32 %add312.3.1 to i64
  %241 = or disjoint i64 %240, %27
  %242 = or disjoint i64 %241, 512
  %add.ptr320.1.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %242
  %vr.sroa.170.16.add.ptr320.1.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr320.1.3.1, i64 8
  %vr.sroa.170.16.copyload1222 = load <4 x half>, ptr addrspace(4) %vr.sroa.170.16.add.ptr320.1.3.1.sroa_idx, align 8
  %vr.sroa.110.16.copyload1211 = load <4 x half>, ptr addrspace(4) %add.ptr320.1.3.1, align 16
  %243 = or disjoint i64 %240, %27
  %add.ptr320.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %243
  %vr.sroa.62.0.add.ptr320.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr320.3.1, i64 8
  %vr.sroa.62.0.copyload1106 = load <4 x half>, ptr addrspace(4) %vr.sroa.62.0.add.ptr320.3.1.sroa_idx, align 8
  %vr.sroa.0.0.copyload1095 = load <4 x half>, ptr addrspace(4) %add.ptr320.3.1, align 16
  %244 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload1095, <4 x half> %238, <4 x float> zeroinitializer), !call_argsrelate !163
  %245 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.62.0.copyload1106, <4 x half> %238, <4 x float> zeroinitializer), !call_argsrelate !163
  %246 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.110.16.copyload1211, <4 x half> %238, <4 x float> zeroinitializer), !call_argsrelate !163
  %247 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.170.16.copyload1222, <4 x half> %238, <4 x float> zeroinitializer), !call_argsrelate !163
  br label %if.end428.1

if.end428.1:                                      ; preds = %if.end424.2.1, %for.cond403.preheader.3.1, %if.end282.1
  %out.sroa.134.10 = phi <4 x float> [ zeroinitializer, %if.end282.1 ], [ %out.sroa.134.6, %for.cond403.preheader.3.1 ], [ %out.sroa.134.6, %if.end424.2.1 ]
  %out.sroa.90.10 = phi <4 x float> [ zeroinitializer, %if.end282.1 ], [ %out.sroa.90.6, %for.cond403.preheader.3.1 ], [ %out.sroa.90.6, %if.end424.2.1 ]
  %out.sroa.46.10 = phi <4 x float> [ zeroinitializer, %if.end282.1 ], [ %out.sroa.46.6, %for.cond403.preheader.3.1 ], [ %out.sroa.46.6, %if.end424.2.1 ]
  %out.sroa.0.10 = phi <4 x float> [ zeroinitializer, %if.end282.1 ], [ %out.sroa.0.6, %for.cond403.preheader.3.1 ], [ %out.sroa.0.6, %if.end424.2.1 ]
  %out_1.sroa.98.10 = phi <4 x float> [ zeroinitializer, %if.end282.1 ], [ %out_1.sroa.98.7, %for.cond403.preheader.3.1 ], [ %out_1.sroa.98.7, %if.end424.2.1 ]
  %out_1.sroa.66.10 = phi <4 x float> [ zeroinitializer, %if.end282.1 ], [ %out_1.sroa.66.7, %for.cond403.preheader.3.1 ], [ %out_1.sroa.66.7, %if.end424.2.1 ]
  %out_1.sroa.34.10 = phi <4 x float> [ zeroinitializer, %if.end282.1 ], [ %out_1.sroa.34.7, %for.cond403.preheader.3.1 ], [ %out_1.sroa.34.7, %if.end424.2.1 ]
  %out_1.sroa.0.10 = phi <4 x float> [ zeroinitializer, %if.end282.1 ], [ %out_1.sroa.0.7, %for.cond403.preheader.3.1 ], [ %out_1.sroa.0.7, %if.end424.2.1 ]
  %out_2.sroa.98.10 = phi <4 x float> [ zeroinitializer, %if.end282.1 ], [ %out_2.sroa.98.8, %for.cond403.preheader.3.1 ], [ %out_2.sroa.98.8, %if.end424.2.1 ]
  %out_2.sroa.66.10 = phi <4 x float> [ zeroinitializer, %if.end282.1 ], [ %out_2.sroa.66.8, %for.cond403.preheader.3.1 ], [ %out_2.sroa.66.8, %if.end424.2.1 ]
  %out_2.sroa.34.10 = phi <4 x float> [ zeroinitializer, %if.end282.1 ], [ %out_2.sroa.34.8, %for.cond403.preheader.3.1 ], [ %out_2.sroa.34.8, %if.end424.2.1 ]
  %out_2.sroa.0.10 = phi <4 x float> [ zeroinitializer, %if.end282.1 ], [ %out_2.sroa.0.8, %for.cond403.preheader.3.1 ], [ %out_2.sroa.0.8, %if.end424.2.1 ]
  %out_3.sroa.98.10 = phi <4 x float> [ zeroinitializer, %if.end282.1 ], [ %247, %for.cond403.preheader.3.1 ], [ zeroinitializer, %if.end424.2.1 ]
  %out_3.sroa.66.10 = phi <4 x float> [ zeroinitializer, %if.end282.1 ], [ %246, %for.cond403.preheader.3.1 ], [ zeroinitializer, %if.end424.2.1 ]
  %out_3.sroa.34.10 = phi <4 x float> [ zeroinitializer, %if.end282.1 ], [ %245, %for.cond403.preheader.3.1 ], [ zeroinitializer, %if.end424.2.1 ]
  %out_3.sroa.0.10 = phi <4 x float> [ zeroinitializer, %if.end282.1 ], [ %244, %for.cond403.preheader.3.1 ], [ zeroinitializer, %if.end424.2.1 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br label %if.end282.2

if.end282.2:                                      ; preds = %if.end428.1
  br i1 %cmp285.not, label %for.cond289.preheader.2, label %if.end428.2

for.cond289.preheader.2:                          ; preds = %if.end282.2
  %or.cond768.2993 = icmp ugt i32 %mul11.4, 1023
  %cmp302.not.2994 = icmp sgt i32 %mul11.4, %1
  %or.cond769.2995 = or i1 %or.cond768.2993, %cmp302.not.2994
  br i1 %or.cond769.2995, label %if.end424.21037, label %for.cond342.preheader.21021

for.cond342.preheader.21021:                      ; preds = %for.cond289.preheader.2
  %add334.21002 = or disjoint i32 %mul333, 2048
  %gep.21003 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add334.21002
  %248 = load <4 x half>, ptr addrspace(3) %gep.21003, align 8
  %249 = shl nsw i32 %cond.i.i727.4, 10
  %mul311.2996 = and i32 %249, 64512
  %add312.2997 = or disjoint i32 %mul311.2996, %mul131
  %250 = zext nneg i32 %add312.2997 to i64
  %251 = or disjoint i64 %250, %27
  %252 = or disjoint i64 %251, 512
  %add.ptr320.1.21000 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %252
  %vr.sroa.170.16.add.ptr320.1.21000.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr320.1.21000, i64 8
  %vr.sroa.170.16.copyload1223 = load <4 x half>, ptr addrspace(4) %vr.sroa.170.16.add.ptr320.1.21000.sroa_idx, align 8
  %vr.sroa.110.16.copyload1212 = load <4 x half>, ptr addrspace(4) %add.ptr320.1.21000, align 16
  %253 = or disjoint i64 %250, %27
  %add.ptr320.2999 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %253
  %vr.sroa.62.0.add.ptr320.2999.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr320.2999, i64 8
  %vr.sroa.62.0.copyload1107 = load <4 x half>, ptr addrspace(4) %vr.sroa.62.0.add.ptr320.2999.sroa_idx, align 8
  %vr.sroa.0.0.copyload1096 = load <4 x half>, ptr addrspace(4) %add.ptr320.2999, align 16
  %254 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload1096, <4 x half> %248, <4 x float> %out.sroa.0.10), !call_argsrelate !163
  %255 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.62.0.copyload1107, <4 x half> %248, <4 x float> %out.sroa.46.10), !call_argsrelate !163
  %256 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.110.16.copyload1212, <4 x half> %248, <4 x float> %out.sroa.90.10), !call_argsrelate !163
  %257 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.170.16.copyload1223, <4 x half> %248, <4 x float> %out.sroa.134.10), !call_argsrelate !163
  br label %if.end424.21037

if.end424.21037:                                  ; preds = %for.cond342.preheader.21021, %for.cond289.preheader.2
  %out.sroa.134.11 = phi <4 x float> [ %out.sroa.134.10, %for.cond289.preheader.2 ], [ %257, %for.cond342.preheader.21021 ]
  %out.sroa.90.11 = phi <4 x float> [ %out.sroa.90.10, %for.cond289.preheader.2 ], [ %256, %for.cond342.preheader.21021 ]
  %out.sroa.46.11 = phi <4 x float> [ %out.sroa.46.10, %for.cond289.preheader.2 ], [ %255, %for.cond342.preheader.21021 ]
  %out.sroa.0.11 = phi <4 x float> [ %out.sroa.0.10, %for.cond289.preheader.2 ], [ %254, %for.cond342.preheader.21021 ]
  %or.cond768.1.2 = icmp ugt i32 %mul11.5, 1023
  %cmp302.not.1.2 = icmp sgt i32 %mul11.5, %1
  %or.cond769.1.2 = or i1 %or.cond768.1.2, %cmp302.not.1.2
  br i1 %or.cond769.1.2, label %if.end424.1.2, label %for.cond363.preheader.1.2

for.cond363.preheader.1.2:                        ; preds = %if.end424.21037
  %add334.1.2 = or i32 %and274, 2304
  %gep.1.2 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add334.1.2
  %258 = load <4 x half>, ptr addrspace(3) %gep.1.2, align 8
  %259 = shl nsw i32 %cond.i.i727.5, 10
  %mul311.1.2 = and i32 %259, 64512
  %add312.1.2 = or disjoint i32 %mul311.1.2, %mul131
  %260 = zext nneg i32 %add312.1.2 to i64
  %261 = or disjoint i64 %260, %27
  %262 = or disjoint i64 %261, 512
  %add.ptr320.1.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %262
  %vr.sroa.170.16.add.ptr320.1.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr320.1.1.2, i64 8
  %vr.sroa.170.16.copyload1224 = load <4 x half>, ptr addrspace(4) %vr.sroa.170.16.add.ptr320.1.1.2.sroa_idx, align 8
  %vr.sroa.110.16.copyload1213 = load <4 x half>, ptr addrspace(4) %add.ptr320.1.1.2, align 16
  %263 = or disjoint i64 %260, %27
  %add.ptr320.1811.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %263
  %vr.sroa.62.0.add.ptr320.1811.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr320.1811.2, i64 8
  %vr.sroa.62.0.copyload1108 = load <4 x half>, ptr addrspace(4) %vr.sroa.62.0.add.ptr320.1811.2.sroa_idx, align 8
  %vr.sroa.0.0.copyload1097 = load <4 x half>, ptr addrspace(4) %add.ptr320.1811.2, align 16
  %264 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload1097, <4 x half> %258, <4 x float> %out_1.sroa.0.10), !call_argsrelate !163
  %265 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.62.0.copyload1108, <4 x half> %258, <4 x float> %out_1.sroa.34.10), !call_argsrelate !163
  %266 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.110.16.copyload1213, <4 x half> %258, <4 x float> %out_1.sroa.66.10), !call_argsrelate !163
  %267 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.170.16.copyload1224, <4 x half> %258, <4 x float> %out_1.sroa.98.10), !call_argsrelate !163
  br label %if.end424.1.2

if.end424.1.2:                                    ; preds = %for.cond363.preheader.1.2, %if.end424.21037
  %out_1.sroa.98.12 = phi <4 x float> [ %out_1.sroa.98.10, %if.end424.21037 ], [ %267, %for.cond363.preheader.1.2 ]
  %out_1.sroa.66.12 = phi <4 x float> [ %out_1.sroa.66.10, %if.end424.21037 ], [ %266, %for.cond363.preheader.1.2 ]
  %out_1.sroa.34.12 = phi <4 x float> [ %out_1.sroa.34.10, %if.end424.21037 ], [ %265, %for.cond363.preheader.1.2 ]
  %out_1.sroa.0.12 = phi <4 x float> [ %out_1.sroa.0.10, %if.end424.21037 ], [ %264, %for.cond363.preheader.1.2 ]
  %or.cond768.2.2 = icmp ugt i32 %mul11.6, 1023
  %cmp302.not.2.2 = icmp sgt i32 %mul11.6, %1
  %or.cond769.2.2 = or i1 %or.cond768.2.2, %cmp302.not.2.2
  br i1 %or.cond769.2.2, label %if.end424.2.2, label %for.cond384.preheader.2.2

for.cond384.preheader.2.2:                        ; preds = %if.end424.1.2
  %add334.2.2 = or disjoint i32 %mul333, 2560
  %gep.2.2 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add334.2.2
  %268 = load <4 x half>, ptr addrspace(3) %gep.2.2, align 8
  %269 = shl nsw i32 %cond.i.i727.6, 10
  %mul311.2.2 = and i32 %269, 64512
  %add312.2.2 = or disjoint i32 %mul311.2.2, %mul131
  %270 = zext nneg i32 %add312.2.2 to i64
  %271 = or disjoint i64 %270, %27
  %272 = or disjoint i64 %271, 512
  %add.ptr320.1.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %272
  %vr.sroa.170.16.add.ptr320.1.2.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr320.1.2.2, i64 8
  %vr.sroa.170.16.copyload1225 = load <4 x half>, ptr addrspace(4) %vr.sroa.170.16.add.ptr320.1.2.2.sroa_idx, align 8
  %vr.sroa.110.16.copyload1214 = load <4 x half>, ptr addrspace(4) %add.ptr320.1.2.2, align 16
  %273 = or disjoint i64 %270, %27
  %add.ptr320.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %273
  %vr.sroa.62.0.add.ptr320.2.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr320.2.2, i64 8
  %vr.sroa.62.0.copyload1109 = load <4 x half>, ptr addrspace(4) %vr.sroa.62.0.add.ptr320.2.2.sroa_idx, align 8
  %vr.sroa.0.0.copyload1098 = load <4 x half>, ptr addrspace(4) %add.ptr320.2.2, align 16
  %274 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload1098, <4 x half> %268, <4 x float> %out_2.sroa.0.10), !call_argsrelate !163
  %275 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.62.0.copyload1109, <4 x half> %268, <4 x float> %out_2.sroa.34.10), !call_argsrelate !163
  %276 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.110.16.copyload1214, <4 x half> %268, <4 x float> %out_2.sroa.66.10), !call_argsrelate !163
  %277 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.170.16.copyload1225, <4 x half> %268, <4 x float> %out_2.sroa.98.10), !call_argsrelate !163
  br label %if.end424.2.2

if.end424.2.2:                                    ; preds = %for.cond384.preheader.2.2, %if.end424.1.2
  %out_2.sroa.98.13 = phi <4 x float> [ %out_2.sroa.98.10, %if.end424.1.2 ], [ %277, %for.cond384.preheader.2.2 ]
  %out_2.sroa.66.13 = phi <4 x float> [ %out_2.sroa.66.10, %if.end424.1.2 ], [ %276, %for.cond384.preheader.2.2 ]
  %out_2.sroa.34.13 = phi <4 x float> [ %out_2.sroa.34.10, %if.end424.1.2 ], [ %275, %for.cond384.preheader.2.2 ]
  %out_2.sroa.0.13 = phi <4 x float> [ %out_2.sroa.0.10, %if.end424.1.2 ], [ %274, %for.cond384.preheader.2.2 ]
  %or.cond768.3.2 = icmp ugt i32 %mul11.7, 1023
  %cmp302.not.3.2 = icmp sgt i32 %mul11.7, %1
  %or.cond769.3.2 = or i1 %or.cond768.3.2, %cmp302.not.3.2
  br i1 %or.cond769.3.2, label %if.end428.2, label %for.cond403.preheader.3.2

for.cond403.preheader.3.2:                        ; preds = %if.end424.2.2
  %add334.3.2 = or i32 %and274, 2816
  %gep.3.2 = getelementptr %struct.__half, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 -2048), i32 %add334.3.2
  %278 = load <4 x half>, ptr addrspace(3) %gep.3.2, align 8
  %279 = shl nsw i32 %cond.i.i727.7, 10
  %mul311.3.2 = and i32 %279, 64512
  %add312.3.2 = or disjoint i32 %mul311.3.2, %mul131
  %280 = zext nneg i32 %add312.3.2 to i64
  %281 = or disjoint i64 %280, %27
  %282 = or disjoint i64 %281, 512
  %add.ptr320.1.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %282
  %vr.sroa.170.16.add.ptr320.1.3.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr320.1.3.2, i64 8
  %vr.sroa.170.16.copyload1226 = load <4 x half>, ptr addrspace(4) %vr.sroa.170.16.add.ptr320.1.3.2.sroa_idx, align 8
  %vr.sroa.110.16.copyload1215 = load <4 x half>, ptr addrspace(4) %add.ptr320.1.3.2, align 16
  %283 = or disjoint i64 %280, %27
  %add.ptr320.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %283
  %vr.sroa.62.0.add.ptr320.3.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr320.3.2, i64 8
  %vr.sroa.62.0.copyload1110 = load <4 x half>, ptr addrspace(4) %vr.sroa.62.0.add.ptr320.3.2.sroa_idx, align 8
  %vr.sroa.0.0.copyload1099 = load <4 x half>, ptr addrspace(4) %add.ptr320.3.2, align 16
  %284 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.0.0.copyload1099, <4 x half> %278, <4 x float> %out_3.sroa.0.10), !call_argsrelate !163
  %285 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.62.0.copyload1110, <4 x half> %278, <4 x float> %out_3.sroa.34.10), !call_argsrelate !163
  %286 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.110.16.copyload1215, <4 x half> %278, <4 x float> %out_3.sroa.66.10), !call_argsrelate !163
  %287 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vr.sroa.170.16.copyload1226, <4 x half> %278, <4 x float> %out_3.sroa.98.10), !call_argsrelate !163
  br label %if.end428.2

if.end428.2:                                      ; preds = %if.end424.2.2, %for.cond403.preheader.3.2, %if.end282.2
  %out.sroa.134.15 = phi <4 x float> [ %out.sroa.134.10, %if.end282.2 ], [ %out.sroa.134.11, %for.cond403.preheader.3.2 ], [ %out.sroa.134.11, %if.end424.2.2 ]
  %out.sroa.90.15 = phi <4 x float> [ %out.sroa.90.10, %if.end282.2 ], [ %out.sroa.90.11, %for.cond403.preheader.3.2 ], [ %out.sroa.90.11, %if.end424.2.2 ]
  %out.sroa.46.15 = phi <4 x float> [ %out.sroa.46.10, %if.end282.2 ], [ %out.sroa.46.11, %for.cond403.preheader.3.2 ], [ %out.sroa.46.11, %if.end424.2.2 ]
  %out.sroa.0.15 = phi <4 x float> [ %out.sroa.0.10, %if.end282.2 ], [ %out.sroa.0.11, %for.cond403.preheader.3.2 ], [ %out.sroa.0.11, %if.end424.2.2 ]
  %out_1.sroa.98.15 = phi <4 x float> [ %out_1.sroa.98.10, %if.end282.2 ], [ %out_1.sroa.98.12, %for.cond403.preheader.3.2 ], [ %out_1.sroa.98.12, %if.end424.2.2 ]
  %out_1.sroa.66.15 = phi <4 x float> [ %out_1.sroa.66.10, %if.end282.2 ], [ %out_1.sroa.66.12, %for.cond403.preheader.3.2 ], [ %out_1.sroa.66.12, %if.end424.2.2 ]
  %out_1.sroa.34.15 = phi <4 x float> [ %out_1.sroa.34.10, %if.end282.2 ], [ %out_1.sroa.34.12, %for.cond403.preheader.3.2 ], [ %out_1.sroa.34.12, %if.end424.2.2 ]
  %out_1.sroa.0.15 = phi <4 x float> [ %out_1.sroa.0.10, %if.end282.2 ], [ %out_1.sroa.0.12, %for.cond403.preheader.3.2 ], [ %out_1.sroa.0.12, %if.end424.2.2 ]
  %out_2.sroa.98.15 = phi <4 x float> [ %out_2.sroa.98.10, %if.end282.2 ], [ %out_2.sroa.98.13, %for.cond403.preheader.3.2 ], [ %out_2.sroa.98.13, %if.end424.2.2 ]
  %out_2.sroa.66.15 = phi <4 x float> [ %out_2.sroa.66.10, %if.end282.2 ], [ %out_2.sroa.66.13, %for.cond403.preheader.3.2 ], [ %out_2.sroa.66.13, %if.end424.2.2 ]
  %out_2.sroa.34.15 = phi <4 x float> [ %out_2.sroa.34.10, %if.end282.2 ], [ %out_2.sroa.34.13, %for.cond403.preheader.3.2 ], [ %out_2.sroa.34.13, %if.end424.2.2 ]
  %out_2.sroa.0.15 = phi <4 x float> [ %out_2.sroa.0.10, %if.end282.2 ], [ %out_2.sroa.0.13, %for.cond403.preheader.3.2 ], [ %out_2.sroa.0.13, %if.end424.2.2 ]
  %out_3.sroa.98.15 = phi <4 x float> [ %out_3.sroa.98.10, %if.end282.2 ], [ %287, %for.cond403.preheader.3.2 ], [ %out_3.sroa.98.10, %if.end424.2.2 ]
  %out_3.sroa.66.15 = phi <4 x float> [ %out_3.sroa.66.10, %if.end282.2 ], [ %286, %for.cond403.preheader.3.2 ], [ %out_3.sroa.66.10, %if.end424.2.2 ]
  %out_3.sroa.34.15 = phi <4 x float> [ %out_3.sroa.34.10, %if.end282.2 ], [ %285, %for.cond403.preheader.3.2 ], [ %out_3.sroa.34.10, %if.end424.2.2 ]
  %out_3.sroa.0.15 = phi <4 x float> [ %out_3.sroa.0.10, %if.end282.2 ], [ %284, %for.cond403.preheader.3.2 ], [ %out_3.sroa.0.10, %if.end424.2.2 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %cmp15, label %for.body440.preheader, label %if.end471

if.end471:                                        ; preds = %for.body440.preheader, %if.end428.2
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  %cmp474 = icmp eq i32 %shr284.mask, 64
  br i1 %cmp474, label %if.then475, label %if.end586

if.then475:                                       ; preds = %if.end471
  %and477 = and i32 %18, 63
  %arrayidx479 = getelementptr inbounds float, ptr addrspace(3) @buf_dyn_shmem, i32 %and477
  %288 = load float, ptr addrspace(3) %arrayidx479, align 4, !tbaa !105
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %out.sroa.0.15, i64 0
  %out_1.sroa.0.0.vec.extract = extractelement <4 x float> %out_1.sroa.0.15, i64 0
  %add489 = fadd contract float %out.sroa.0.0.vec.extract, %out_1.sroa.0.0.vec.extract
  %out_2.sroa.0.0.vec.extract = extractelement <4 x float> %out_2.sroa.0.15, i64 0
  %add496 = fadd contract float %add489, %out_2.sroa.0.0.vec.extract
  %out_3.sroa.0.0.vec.extract = extractelement <4 x float> %out_3.sroa.0.15, i64 0
  %add503 = fadd contract float %add496, %out_3.sroa.0.0.vec.extract
  %mul509 = fmul contract float %288, %add503
  %289 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul509)
  %oreg.sroa.0.0.insert.ext = zext i16 %289 to i64
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %out.sroa.0.15, i64 1
  %out_1.sroa.0.4.vec.extract = extractelement <4 x float> %out_1.sroa.0.15, i64 1
  %add489.1 = fadd contract float %out.sroa.0.4.vec.extract, %out_1.sroa.0.4.vec.extract
  %out_2.sroa.0.4.vec.extract = extractelement <4 x float> %out_2.sroa.0.15, i64 1
  %add496.1 = fadd contract float %add489.1, %out_2.sroa.0.4.vec.extract
  %out_3.sroa.0.4.vec.extract = extractelement <4 x float> %out_3.sroa.0.15, i64 1
  %add503.1 = fadd contract float %add496.1, %out_3.sroa.0.4.vec.extract
  %mul509.1 = fmul contract float %288, %add503.1
  %290 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul509.1)
  %oreg.sroa.0.2.insert.ext = zext i16 %290 to i64
  %oreg.sroa.0.2.insert.shift = shl nuw nsw i64 %oreg.sroa.0.2.insert.ext, 16
  %oreg.sroa.0.2.insert.insert = or disjoint i64 %oreg.sroa.0.2.insert.shift, %oreg.sroa.0.0.insert.ext
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %out.sroa.0.15, i64 2
  %out_1.sroa.0.8.vec.extract = extractelement <4 x float> %out_1.sroa.0.15, i64 2
  %add489.2 = fadd contract float %out.sroa.0.8.vec.extract, %out_1.sroa.0.8.vec.extract
  %out_2.sroa.0.8.vec.extract = extractelement <4 x float> %out_2.sroa.0.15, i64 2
  %add496.2 = fadd contract float %add489.2, %out_2.sroa.0.8.vec.extract
  %out_3.sroa.0.8.vec.extract = extractelement <4 x float> %out_3.sroa.0.15, i64 2
  %add503.2 = fadd contract float %add496.2, %out_3.sroa.0.8.vec.extract
  %mul509.2 = fmul contract float %288, %add503.2
  %291 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul509.2)
  %oreg.sroa.0.4.insert.ext = zext i16 %291 to i64
  %oreg.sroa.0.4.insert.shift = shl nuw nsw i64 %oreg.sroa.0.4.insert.ext, 32
  %oreg.sroa.0.4.insert.insert = or disjoint i64 %oreg.sroa.0.2.insert.insert, %oreg.sroa.0.4.insert.shift
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %out.sroa.0.15, i64 3
  %out_1.sroa.0.12.vec.extract = extractelement <4 x float> %out_1.sroa.0.15, i64 3
  %add489.3 = fadd contract float %out.sroa.0.12.vec.extract, %out_1.sroa.0.12.vec.extract
  %out_2.sroa.0.12.vec.extract = extractelement <4 x float> %out_2.sroa.0.15, i64 3
  %add496.3 = fadd contract float %add489.3, %out_2.sroa.0.12.vec.extract
  %out_3.sroa.0.12.vec.extract = extractelement <4 x float> %out_3.sroa.0.15, i64 3
  %add503.3 = fadd contract float %add496.3, %out_3.sroa.0.12.vec.extract
  %mul509.3 = fmul contract float %288, %add503.3
  %292 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul509.3)
  %oreg.sroa.0.6.insert.ext = zext i16 %292 to i64
  %oreg.sroa.0.6.insert.shift = shl nuw i64 %oreg.sroa.0.6.insert.ext, 48
  %oreg.sroa.0.6.insert.insert = or disjoint i64 %oreg.sroa.0.4.insert.insert, %oreg.sroa.0.6.insert.shift
  %out.sroa.46.16.vec.extract = extractelement <4 x float> %out.sroa.46.15, i64 0
  %out_1.sroa.34.16.vec.extract = extractelement <4 x float> %out_1.sroa.34.15, i64 0
  %add489.4 = fadd contract float %out.sroa.46.16.vec.extract, %out_1.sroa.34.16.vec.extract
  %out_2.sroa.34.16.vec.extract = extractelement <4 x float> %out_2.sroa.34.15, i64 0
  %add496.4 = fadd contract float %add489.4, %out_2.sroa.34.16.vec.extract
  %out_3.sroa.34.16.vec.extract = extractelement <4 x float> %out_3.sroa.34.15, i64 0
  %add503.4 = fadd contract float %add496.4, %out_3.sroa.34.16.vec.extract
  %mul509.4 = fmul contract float %288, %add503.4
  %293 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul509.4)
  %oreg.sroa.7.8.insert.ext = zext i16 %293 to i64
  %out.sroa.46.20.vec.extract = extractelement <4 x float> %out.sroa.46.15, i64 1
  %out_1.sroa.34.20.vec.extract = extractelement <4 x float> %out_1.sroa.34.15, i64 1
  %add489.5 = fadd contract float %out.sroa.46.20.vec.extract, %out_1.sroa.34.20.vec.extract
  %out_2.sroa.34.20.vec.extract = extractelement <4 x float> %out_2.sroa.34.15, i64 1
  %add496.5 = fadd contract float %add489.5, %out_2.sroa.34.20.vec.extract
  %out_3.sroa.34.20.vec.extract = extractelement <4 x float> %out_3.sroa.34.15, i64 1
  %add503.5 = fadd contract float %add496.5, %out_3.sroa.34.20.vec.extract
  %mul509.5 = fmul contract float %288, %add503.5
  %294 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul509.5)
  %oreg.sroa.7.10.insert.ext = zext i16 %294 to i64
  %oreg.sroa.7.10.insert.shift = shl nuw nsw i64 %oreg.sroa.7.10.insert.ext, 16
  %oreg.sroa.7.10.insert.insert = or disjoint i64 %oreg.sroa.7.10.insert.shift, %oreg.sroa.7.8.insert.ext
  %out.sroa.46.24.vec.extract = extractelement <4 x float> %out.sroa.46.15, i64 2
  %out_1.sroa.34.24.vec.extract = extractelement <4 x float> %out_1.sroa.34.15, i64 2
  %add489.6 = fadd contract float %out.sroa.46.24.vec.extract, %out_1.sroa.34.24.vec.extract
  %out_2.sroa.34.24.vec.extract = extractelement <4 x float> %out_2.sroa.34.15, i64 2
  %add496.6 = fadd contract float %add489.6, %out_2.sroa.34.24.vec.extract
  %out_3.sroa.34.24.vec.extract = extractelement <4 x float> %out_3.sroa.34.15, i64 2
  %add503.6 = fadd contract float %add496.6, %out_3.sroa.34.24.vec.extract
  %mul509.6 = fmul contract float %288, %add503.6
  %295 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul509.6)
  %oreg.sroa.7.12.insert.ext = zext i16 %295 to i64
  %oreg.sroa.7.12.insert.shift = shl nuw nsw i64 %oreg.sroa.7.12.insert.ext, 32
  %oreg.sroa.7.12.insert.insert = or disjoint i64 %oreg.sroa.7.10.insert.insert, %oreg.sroa.7.12.insert.shift
  %out.sroa.46.28.vec.extract = extractelement <4 x float> %out.sroa.46.15, i64 3
  %out_1.sroa.34.28.vec.extract = extractelement <4 x float> %out_1.sroa.34.15, i64 3
  %add489.7 = fadd contract float %out.sroa.46.28.vec.extract, %out_1.sroa.34.28.vec.extract
  %out_2.sroa.34.28.vec.extract = extractelement <4 x float> %out_2.sroa.34.15, i64 3
  %add496.7 = fadd contract float %add489.7, %out_2.sroa.34.28.vec.extract
  %out_3.sroa.34.28.vec.extract = extractelement <4 x float> %out_3.sroa.34.15, i64 3
  %add503.7 = fadd contract float %add496.7, %out_3.sroa.34.28.vec.extract
  %mul509.7 = fmul contract float %288, %add503.7
  %296 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul509.7)
  %oreg.sroa.7.14.insert.ext = zext i16 %296 to i64
  %oreg.sroa.7.14.insert.shift = shl nuw i64 %oreg.sroa.7.14.insert.ext, 48
  %oreg.sroa.7.14.insert.insert = or disjoint i64 %oreg.sroa.7.12.insert.insert, %oreg.sroa.7.14.insert.shift
  %out.sroa.90.32.vec.extract = extractelement <4 x float> %out.sroa.90.15, i64 0
  %out_1.sroa.66.32.vec.extract = extractelement <4 x float> %out_1.sroa.66.15, i64 0
  %add489.8 = fadd contract float %out.sroa.90.32.vec.extract, %out_1.sroa.66.32.vec.extract
  %out_2.sroa.66.32.vec.extract = extractelement <4 x float> %out_2.sroa.66.15, i64 0
  %add496.8 = fadd contract float %add489.8, %out_2.sroa.66.32.vec.extract
  %out_3.sroa.66.32.vec.extract = extractelement <4 x float> %out_3.sroa.66.15, i64 0
  %add503.8 = fadd contract float %add496.8, %out_3.sroa.66.32.vec.extract
  %mul509.8 = fmul contract float %288, %add503.8
  %297 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul509.8)
  %oreg.sroa.12.16.insert.ext = zext i16 %297 to i64
  %out.sroa.90.36.vec.extract = extractelement <4 x float> %out.sroa.90.15, i64 1
  %out_1.sroa.66.36.vec.extract = extractelement <4 x float> %out_1.sroa.66.15, i64 1
  %add489.9 = fadd contract float %out.sroa.90.36.vec.extract, %out_1.sroa.66.36.vec.extract
  %out_2.sroa.66.36.vec.extract = extractelement <4 x float> %out_2.sroa.66.15, i64 1
  %add496.9 = fadd contract float %add489.9, %out_2.sroa.66.36.vec.extract
  %out_3.sroa.66.36.vec.extract = extractelement <4 x float> %out_3.sroa.66.15, i64 1
  %add503.9 = fadd contract float %add496.9, %out_3.sroa.66.36.vec.extract
  %mul509.9 = fmul contract float %288, %add503.9
  %298 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul509.9)
  %oreg.sroa.12.18.insert.ext = zext i16 %298 to i64
  %oreg.sroa.12.18.insert.shift = shl nuw nsw i64 %oreg.sroa.12.18.insert.ext, 16
  %oreg.sroa.12.18.insert.insert = or disjoint i64 %oreg.sroa.12.18.insert.shift, %oreg.sroa.12.16.insert.ext
  %out.sroa.90.40.vec.extract = extractelement <4 x float> %out.sroa.90.15, i64 2
  %out_1.sroa.66.40.vec.extract = extractelement <4 x float> %out_1.sroa.66.15, i64 2
  %add489.10 = fadd contract float %out.sroa.90.40.vec.extract, %out_1.sroa.66.40.vec.extract
  %out_2.sroa.66.40.vec.extract = extractelement <4 x float> %out_2.sroa.66.15, i64 2
  %add496.10 = fadd contract float %add489.10, %out_2.sroa.66.40.vec.extract
  %out_3.sroa.66.40.vec.extract = extractelement <4 x float> %out_3.sroa.66.15, i64 2
  %add503.10 = fadd contract float %add496.10, %out_3.sroa.66.40.vec.extract
  %mul509.10 = fmul contract float %288, %add503.10
  %299 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul509.10)
  %oreg.sroa.12.20.insert.ext = zext i16 %299 to i64
  %oreg.sroa.12.20.insert.shift = shl nuw nsw i64 %oreg.sroa.12.20.insert.ext, 32
  %oreg.sroa.12.20.insert.insert = or disjoint i64 %oreg.sroa.12.18.insert.insert, %oreg.sroa.12.20.insert.shift
  %out.sroa.90.44.vec.extract = extractelement <4 x float> %out.sroa.90.15, i64 3
  %out_1.sroa.66.44.vec.extract = extractelement <4 x float> %out_1.sroa.66.15, i64 3
  %add489.11 = fadd contract float %out.sroa.90.44.vec.extract, %out_1.sroa.66.44.vec.extract
  %out_2.sroa.66.44.vec.extract = extractelement <4 x float> %out_2.sroa.66.15, i64 3
  %add496.11 = fadd contract float %add489.11, %out_2.sroa.66.44.vec.extract
  %out_3.sroa.66.44.vec.extract = extractelement <4 x float> %out_3.sroa.66.15, i64 3
  %add503.11 = fadd contract float %add496.11, %out_3.sroa.66.44.vec.extract
  %mul509.11 = fmul contract float %288, %add503.11
  %300 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul509.11)
  %oreg.sroa.12.22.insert.ext = zext i16 %300 to i64
  %oreg.sroa.12.22.insert.shift = shl nuw i64 %oreg.sroa.12.22.insert.ext, 48
  %oreg.sroa.12.22.insert.insert = or disjoint i64 %oreg.sroa.12.20.insert.insert, %oreg.sroa.12.22.insert.shift
  %out.sroa.134.48.vec.extract = extractelement <4 x float> %out.sroa.134.15, i64 0
  %out_1.sroa.98.48.vec.extract = extractelement <4 x float> %out_1.sroa.98.15, i64 0
  %add489.12 = fadd contract float %out.sroa.134.48.vec.extract, %out_1.sroa.98.48.vec.extract
  %out_2.sroa.98.48.vec.extract = extractelement <4 x float> %out_2.sroa.98.15, i64 0
  %add496.12 = fadd contract float %add489.12, %out_2.sroa.98.48.vec.extract
  %out_3.sroa.98.48.vec.extract = extractelement <4 x float> %out_3.sroa.98.15, i64 0
  %add503.12 = fadd contract float %add496.12, %out_3.sroa.98.48.vec.extract
  %mul509.12 = fmul contract float %288, %add503.12
  %301 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul509.12)
  %oreg.sroa.17.24.insert.ext = zext i16 %301 to i64
  %out.sroa.134.52.vec.extract = extractelement <4 x float> %out.sroa.134.15, i64 1
  %out_1.sroa.98.52.vec.extract = extractelement <4 x float> %out_1.sroa.98.15, i64 1
  %add489.13 = fadd contract float %out.sroa.134.52.vec.extract, %out_1.sroa.98.52.vec.extract
  %out_2.sroa.98.52.vec.extract = extractelement <4 x float> %out_2.sroa.98.15, i64 1
  %add496.13 = fadd contract float %add489.13, %out_2.sroa.98.52.vec.extract
  %out_3.sroa.98.52.vec.extract = extractelement <4 x float> %out_3.sroa.98.15, i64 1
  %add503.13 = fadd contract float %add496.13, %out_3.sroa.98.52.vec.extract
  %mul509.13 = fmul contract float %288, %add503.13
  %302 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul509.13)
  %oreg.sroa.17.26.insert.ext = zext i16 %302 to i64
  %oreg.sroa.17.26.insert.shift = shl nuw nsw i64 %oreg.sroa.17.26.insert.ext, 16
  %oreg.sroa.17.26.insert.insert = or disjoint i64 %oreg.sroa.17.26.insert.shift, %oreg.sroa.17.24.insert.ext
  %out.sroa.134.56.vec.extract = extractelement <4 x float> %out.sroa.134.15, i64 2
  %out_1.sroa.98.56.vec.extract = extractelement <4 x float> %out_1.sroa.98.15, i64 2
  %add489.14 = fadd contract float %out.sroa.134.56.vec.extract, %out_1.sroa.98.56.vec.extract
  %out_2.sroa.98.56.vec.extract = extractelement <4 x float> %out_2.sroa.98.15, i64 2
  %add496.14 = fadd contract float %add489.14, %out_2.sroa.98.56.vec.extract
  %out_3.sroa.98.56.vec.extract = extractelement <4 x float> %out_3.sroa.98.15, i64 2
  %add503.14 = fadd contract float %add496.14, %out_3.sroa.98.56.vec.extract
  %mul509.14 = fmul contract float %288, %add503.14
  %303 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul509.14)
  %oreg.sroa.17.28.insert.ext = zext i16 %303 to i64
  %oreg.sroa.17.28.insert.shift = shl nuw nsw i64 %oreg.sroa.17.28.insert.ext, 32
  %oreg.sroa.17.28.insert.insert = or disjoint i64 %oreg.sroa.17.26.insert.insert, %oreg.sroa.17.28.insert.shift
  %out.sroa.134.60.vec.extract = extractelement <4 x float> %out.sroa.134.15, i64 3
  %out_1.sroa.98.60.vec.extract = extractelement <4 x float> %out_1.sroa.98.15, i64 3
  %add489.15 = fadd contract float %out.sroa.134.60.vec.extract, %out_1.sroa.98.60.vec.extract
  %out_2.sroa.98.60.vec.extract = extractelement <4 x float> %out_2.sroa.98.15, i64 3
  %add496.15 = fadd contract float %add489.15, %out_2.sroa.98.60.vec.extract
  %out_3.sroa.98.60.vec.extract = extractelement <4 x float> %out_3.sroa.98.15, i64 3
  %add503.15 = fadd contract float %add496.15, %out_3.sroa.98.60.vec.extract
  %mul509.15 = fmul contract float %288, %add503.15
  %304 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul509.15)
  %oreg.sroa.17.30.insert.ext = zext i16 %304 to i64
  %oreg.sroa.17.30.insert.shift = shl nuw i64 %oreg.sroa.17.30.insert.ext, 48
  %oreg.sroa.17.30.insert.insert = or disjoint i64 %oreg.sroa.17.28.insert.insert, %oreg.sroa.17.30.insert.shift
  %and529 = shl nuw nsw i32 %18, 6
  %mul530 = and i32 %and529, 960
  %and533 = lshr i32 %18, 5
  %shr534 = and i32 %and533, 1
  %and537 = and i32 %18, 7
  %mul543 = and i32 %25, 4
  %xor = xor i32 %shr534, %and537
  %mul538 = shl nuw nsw i32 %xor, 3
  %add539 = or disjoint i32 %mul538, %mul530
  %add544 = or disjoint i32 %add539, %mul543
  %add.ptr546 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add544
  store i64 %oreg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr546, align 8
  %xor.1 = xor i32 %and533, %and537
  %mul538.1 = shl nuw nsw i32 %xor.1, 3
  %add539.1 = or disjoint i32 %mul538.1, %mul530
  %add544.1 = or disjoint i32 %add539.1, %mul543
  %add.ptr546.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add544.1
  store i64 %oreg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr546.1, align 8
  %add535.2 = or disjoint i32 %shr534, 4
  %xor.2 = xor i32 %add535.2, %and537
  %mul538.2 = shl nuw nsw i32 %xor.2, 3
  %add539.2 = or disjoint i32 %mul538.2, %mul530
  %add544.2 = or disjoint i32 %add539.2, %mul543
  %add.ptr546.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add544.2
  store i64 %oreg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr546.2, align 8
  %add535.3 = or i32 %and533, 6
  %xor.3 = xor i32 %add535.3, %and537
  %mul538.3 = shl nuw nsw i32 %xor.3, 3
  %add539.3 = or disjoint i32 %mul538.3, %mul530
  %add544.3 = or disjoint i32 %add539.3, %mul543
  %add.ptr546.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add544.3
  store i64 %oreg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr546.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul558 = and i32 %and138, 448
  %xor565 = xor i32 %and138, %18
  %mul566 = and i32 %xor565, 56
  %305 = or disjoint i32 %mul566, %mul558
  %mul571 = shl nsw i32 %0, 20
  %mul573 = shl nsw i32 %1, 10
  %add574 = add nuw nsw i32 %mul571, %mul573
  %306 = or disjoint i32 %add574, %mul317
  %307 = zext nneg i32 %306 to i64
  %add.ptr569 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %305
  %add.ptr582 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %307
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr582, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr569, i64 16, i1 false), !tbaa.struct !215, !call_argsrelate !216
  %308 = or disjoint i32 %305, 512
  %add.ptr569.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %308
  %309 = or disjoint i64 %307, 512
  %add.ptr582.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %309
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr582.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr569.1, i64 16, i1 false), !tbaa.struct !215, !call_argsrelate !216
  br label %if.end586

if.end586:                                        ; preds = %if.then475, %if.end471
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


