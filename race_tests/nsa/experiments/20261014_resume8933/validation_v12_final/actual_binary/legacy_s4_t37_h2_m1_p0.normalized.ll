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
  %indices = alloca [4 x i32], align 4, addrspace(5)
  call void @llvm.lifetime.start.p5(i64 16, ptr addrspace(5) %indices) #11
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul = shl nsw i32 %0, 3
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul7 = shl nsw i32 %1, 2
  %add = add nuw nsw i32 %mul, %mul7
  %2 = zext nneg i32 %add to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %2
  %3 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cmp10 = icmp ult i32 %3, 3
  %4 = shl nsw i32 %3, 4
  %mul11 = select i1 %cmp10, i32 %4, i32 -16
  store i32 %mul11, ptr addrspace(5) %indices, align 4, !tbaa !30
  %5 = or disjoint i64 %2, 1
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %5
  %6 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !tbaa !30
  %cmp10.1 = icmp ult i32 %6, 3
  %7 = shl nsw i32 %6, 4
  %mul11.1 = select i1 %cmp10.1, i32 %7, i32 -16
  %arrayidx13.1 = getelementptr inbounds i8, ptr addrspace(5) %indices, i32 4
  store i32 %mul11.1, ptr addrspace(5) %arrayidx13.1, align 4, !tbaa !30
  %8 = or disjoint i64 %2, 2
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8
  %9 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !tbaa !30
  %cmp10.2 = icmp ult i32 %9, 3
  %10 = shl nsw i32 %9, 4
  %mul11.2 = select i1 %cmp10.2, i32 %10, i32 -16
  %arrayidx13.2 = getelementptr inbounds i8, ptr addrspace(5) %indices, i32 8
  store i32 %mul11.2, ptr addrspace(5) %arrayidx13.2, align 4, !tbaa !30
  %11 = or disjoint i64 %2, 3
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %11
  %12 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !tbaa !30
  %cmp10.3 = icmp ult i32 %12, 3
  %13 = shl nsw i32 %12, 4
  %mul11.3 = select i1 %cmp10.3, i32 %13, i32 -16
  %arrayidx13.3 = getelementptr inbounds i8, ptr addrspace(5) %indices, i32 12
  store i32 %mul11.3, ptr addrspace(5) %arrayidx13.3, align 4, !tbaa !30
  %mul20 = shl nsw i32 %0, 11
  %mul22 = shl nsw i32 %1, 10
  %add23 = add nuw nsw i32 %mul20, %mul22
  %14 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !49
  %and = shl nuw nsw i32 %14, 6
  %mul25 = and i32 %and, 960
  %add26 = or disjoint i32 %add23, %mul25
  %15 = lshr i32 %14, 1
  %mul30 = and i32 %15, 504
  %add28 = add nuw nsw i32 %add26, %mul30
  %16 = zext nneg i32 %add28 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %16
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16
  %Q_reg.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.4.0.add.ptr.sroa_idx, align 8
  %17 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %16
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %17, i64 64
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16
  %Q_reg.sroa.7.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %17, i64 72
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.7.16.add.ptr.1.sroa_idx, align 8
  %shr73 = lshr i32 %14, 3
  %18 = shl nuw nsw i32 %14, 4
  %mul81 = and i32 %18, 16256
  %mul86 = shl nsw i32 %1, 6
  %add82 = add nuw nsw i32 %mul81, %mul86
  %and89 = shl nuw nsw i32 %14, 3
  %mul90 = and i32 %and89, 56
  %add84 = or disjoint i32 %add82, %mul90
  %mul192 = and i32 %and89, 8128
  %call196.masked = and i32 %14, 1016
  %mul198 = xor i32 %mul90, %call196.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul192
  %invariant.gep675 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul198
  %19 = lshr i32 %14, 2
  %mul213 = and i32 %19, 252
  %shr245 = lshr i32 %14, 4
  %and248 = and i32 %14, 7
  %20 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul25
  %invariant.gep687 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 2048
  %mul361 = and i32 %18, 16128
  %shr367 = and i32 %shr73, 1
  %mul372 = and i32 %19, 4
  %K_reg.sroa.4.0.invariant.gep675.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 4
  %K_reg.sroa.5.0.invariant.gep675.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 8
  %K_reg.sroa.6.0.invariant.gep675.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 12
  %gep676.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 1024
  %K_reg.sroa.9.16.gep676.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 1028
  %K_reg.sroa.10.16.gep676.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 1032
  %K_reg.sroa.11.16.gep676.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 1036
  %xor249 = xor i32 %shr245, %and248
  %add.ptr253.idx = shl nuw nsw i32 %xor249, 4
  %add.ptr253 = getelementptr inbounds i8, ptr addrspace(3) %20, i32 %add.ptr253.idx
  %kb.sroa.6.0.add.ptr253.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr253, i32 8
  %add246.1 = add nuw nsw i32 %shr245, 4
  %xor249.1 = xor i32 %add246.1, %and248
  %add.ptr253.idx.1 = shl nuw nsw i32 %xor249.1, 4
  %add.ptr253.1 = getelementptr inbounds i8, ptr addrspace(3) %20, i32 %add.ptr253.idx.1
  %kb.sroa.6.0.add.ptr253.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr253.1, i32 8
  %V_reg.sroa.4.0.invariant.gep687.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 2052
  %V_reg.sroa.5.0.invariant.gep687.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 2056
  %V_reg.sroa.6.0.invariant.gep687.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 2060
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 3072
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 3076
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 3080
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 3084
  %xor374 = or disjoint i32 %mul372, %shr367
  %mul375 = shl nuw nsw i32 %xor374, 3
  %add376 = or disjoint i32 %mul375, %mul361
  %add379 = or disjoint i32 %add376, %and248
  %gep691 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379
  %add363.1 = or disjoint i32 %mul361, 64
  %add373.1 = or disjoint i32 %mul372, 1
  %xor374.1 = xor i32 %add373.1, %shr367
  %mul375.1 = shl nuw nsw i32 %xor374.1, 3
  %add376.1 = or disjoint i32 %mul375.1, %add363.1
  %add379.1 = or disjoint i32 %add376.1, %and248
  %gep691.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1
  %add363.2 = or disjoint i32 %mul361, 128
  %add373.2 = or disjoint i32 %mul372, 2
  %xor374.2 = or disjoint i32 %add373.2, %shr367
  %mul375.2 = shl nuw nsw i32 %xor374.2, 3
  %add376.2 = or disjoint i32 %mul375.2, %add363.2
  %add379.2 = or disjoint i32 %add376.2, %and248
  %gep691.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.2
  %add363.3 = or disjoint i32 %mul361, 192
  %add373.3 = or disjoint i32 %mul372, 3
  %xor374.3 = xor i32 %add373.3, %shr367
  %mul375.3 = shl nuw nsw i32 %xor374.3, 3
  %add376.3 = or disjoint i32 %mul375.3, %add363.3
  %add379.3 = or disjoint i32 %add376.3, %and248
  %gep691.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.3
  %add368.1 = or disjoint i32 %shr367, 2
  %xor374.1723 = or disjoint i32 %mul372, %add368.1
  %mul375.1724 = shl nuw nsw i32 %xor374.1723, 3
  %add376.1725 = or disjoint i32 %mul375.1724, %mul361
  %add379.1726 = or disjoint i32 %add376.1725, %and248
  %gep691.1727 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1726
  %xor374.1.1 = xor i32 %add373.1, %add368.1
  %mul375.1.1 = shl nuw nsw i32 %xor374.1.1, 3
  %add376.1.1 = or disjoint i32 %mul375.1.1, %add363.1
  %add379.1.1 = or disjoint i32 %add376.1.1, %and248
  %gep691.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1.1
  %xor374.2.1 = xor i32 %add373.2, %add368.1
  %mul375.2.1 = shl nuw nsw i32 %xor374.2.1, 3
  %add376.2.1 = or disjoint i32 %mul375.2.1, %add363.2
  %add379.2.1 = or disjoint i32 %add376.2.1, %and248
  %gep691.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.2.1
  %xor374.3.1 = xor i32 %add373.3, %add368.1
  %mul375.3.1 = shl nuw nsw i32 %xor374.3.1, 3
  %add376.3.1 = or disjoint i32 %mul375.3.1, %add363.3
  %add379.3.1 = or disjoint i32 %add376.3.1, %and248
  %gep691.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.3.1
  %add368.2 = or disjoint i32 %shr367, 4
  %xor374.2729 = xor i32 %mul372, %add368.2
  %mul375.2730 = shl nuw nsw i32 %xor374.2729, 3
  %add376.2731 = or disjoint i32 %mul375.2730, %mul361
  %add379.2732 = or disjoint i32 %add376.2731, %and248
  %gep691.2733 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.2732
  %xor374.1.2 = xor i32 %add373.1, %add368.2
  %mul375.1.2 = shl nuw nsw i32 %xor374.1.2, 3
  %add376.1.2 = or disjoint i32 %mul375.1.2, %add363.1
  %add379.1.2 = or disjoint i32 %add376.1.2, %and248
  %gep691.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1.2
  %xor374.2.2 = xor i32 %add373.2, %add368.2
  %mul375.2.2 = shl nuw nsw i32 %xor374.2.2, 3
  %add376.2.2 = or disjoint i32 %mul375.2.2, %add363.2
  %add379.2.2 = or disjoint i32 %add376.2.2, %and248
  %gep691.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.2.2
  %xor374.3.2 = xor i32 %add373.3, %add368.2
  %mul375.3.2 = shl nuw nsw i32 %xor374.3.2, 3
  %add376.3.2 = or disjoint i32 %mul375.3.2, %add363.3
  %add379.3.2 = or disjoint i32 %add376.3.2, %and248
  %gep691.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.3.2
  %add368.3 = or disjoint i32 %shr367, 6
  %xor374.3735 = xor i32 %mul372, %add368.3
  %mul375.3736 = shl nuw nsw i32 %xor374.3735, 3
  %add376.3737 = or disjoint i32 %mul375.3736, %mul361
  %add379.3738 = or disjoint i32 %add376.3737, %and248
  %gep691.3739 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.3738
  %xor374.1.3 = xor i32 %add373.1, %add368.3
  %mul375.1.3 = shl nuw nsw i32 %xor374.1.3, 3
  %add376.1.3 = or disjoint i32 %mul375.1.3, %add363.1
  %add379.1.3 = or disjoint i32 %add376.1.3, %and248
  %gep691.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1.3
  %xor374.2.3 = xor i32 %add373.2, %add368.3
  %mul375.2.3 = shl nuw nsw i32 %xor374.2.3, 3
  %add376.2.3 = or disjoint i32 %mul375.2.3, %add363.2
  %add379.2.3 = or disjoint i32 %add376.2.3, %and248
  %gep691.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.2.3
  %xor374.3.3 = xor i32 %add373.3, %add368.3
  %mul375.3.3 = shl nuw nsw i32 %xor374.3.3, 3
  %add376.3.3 = or disjoint i32 %mul375.3.3, %add363.3
  %add379.3.3 = or disjoint i32 %add376.3.3, %and248
  %gep691.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.3.3
  br label %for.body60

for.body60:                                       ; preds = %if.end411.1, %entry
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %entry ], [ %sum_acc.sroa.0.1.1, %if.end411.1 ]
  %sum_acc.sroa.6.0 = phi float [ 0.000000e+00, %entry ], [ %sum_acc.sroa.6.1.1, %if.end411.1 ]
  %sum_acc.sroa.10.0 = phi float [ 0.000000e+00, %entry ], [ %sum_acc.sroa.10.1.1, %if.end411.1 ]
  %sum_acc.sroa.14.0 = phi float [ 0.000000e+00, %entry ], [ %sum_acc.sroa.14.1.1, %if.end411.1 ]
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %acc_o.sroa.0.1.1, %if.end411.1 ]
  %acc_o.sroa.20.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %acc_o.sroa.20.1.1, %if.end411.1 ]
  %acc_o.sroa.38.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %acc_o.sroa.38.1.1, %if.end411.1 ]
  %acc_o.sroa.56.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %acc_o.sroa.56.1.1, %if.end411.1 ]
  %V_reg.sroa.11.0 = phi i32 [ undef, %entry ], [ %V_reg.sroa.11.1.1, %if.end411.1 ]
  %V_reg.sroa.10.0 = phi i32 [ undef, %entry ], [ %V_reg.sroa.10.1.1, %if.end411.1 ]
  %V_reg.sroa.9.0 = phi i32 [ undef, %entry ], [ %V_reg.sroa.9.1.1, %if.end411.1 ]
  %V_reg.sroa.7.0 = phi i32 [ undef, %entry ], [ %V_reg.sroa.7.1.1, %if.end411.1 ]
  %V_reg.sroa.6.0 = phi i32 [ undef, %entry ], [ %V_reg.sroa.6.1.1, %if.end411.1 ]
  %V_reg.sroa.5.0 = phi i32 [ undef, %entry ], [ %V_reg.sroa.5.1.1, %if.end411.1 ]
  %V_reg.sroa.4.0 = phi i32 [ undef, %entry ], [ %V_reg.sroa.4.1.1, %if.end411.1 ]
  %V_reg.sroa.0.0 = phi i32 [ undef, %entry ], [ %V_reg.sroa.0.1.1, %if.end411.1 ]
  %acc_s.sroa.0.0 = phi <4 x float> [ undef, %entry ], [ %acc_s.sroa.0.2.1, %if.end411.1 ]
  %acc_s_cast.sroa.0.0697 = phi <4 x half> [ undef, %entry ], [ %acc_s_cast.sroa.0.1.1, %if.end411.1 ]
  %s.0696 = phi i32 [ 0, %entry ], [ %inc413.1, %if.end411.1 ]
  %arrayidx62 = getelementptr inbounds [4 x i32], ptr addrspace(5) %indices, i32 0, i32 %s.0696
  %21 = load i32, ptr addrspace(5) %arrayidx62, align 4, !tbaa !30
  %or.cond702 = icmp ult i32 %21, 37
  br i1 %or.cond702, label %for.cond67.preheader, label %if.end231

for.cond67.preheader:                             ; preds = %for.body60
  %add74 = add nuw nsw i32 %21, %shr73
  %mul83 = shl nuw nsw i32 %21, 7
  %add87 = add nuw nsw i32 %add84, %mul83
  %22 = zext nneg i32 %add87 to i64
  %cmp76 = icmp slt i32 %add74, 37
  br i1 %cmp76, label %if.then77, label %if.end115

if.then77:                                        ; preds = %for.cond67.preheader
  %add.ptr93 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %22
  %condval_1.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr93, align 16, !tbaa !30
  %condval_1.sroa.5.0.add.ptr93.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr93, i64 4
  %condval_1.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr93.sroa_idx, align 4, !tbaa !30
  %condval_1.sroa.6.0.add.ptr93.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr93, i64 8
  %condval_1.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr93.sroa_idx, align 8, !tbaa !30
  %condval_1.sroa.7.0.add.ptr93.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr93, i64 12
  %condval_1.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr93.sroa_idx, align 4, !tbaa !30
  br label %if.end115

if.end115:                                        ; preds = %for.cond67.preheader, %if.then77
  %condval_1.sroa.0.0 = phi i32 [ %condval_1.sroa.0.0.copyload, %if.then77 ], [ 0, %for.cond67.preheader ]
  %condval_1.sroa.5.0 = phi i32 [ %condval_1.sroa.5.0.copyload, %if.then77 ], [ 0, %for.cond67.preheader ]
  %condval_1.sroa.6.0 = phi i32 [ %condval_1.sroa.6.0.copyload, %if.then77 ], [ 0, %for.cond67.preheader ]
  %condval_1.sroa.7.0 = phi i32 [ %condval_1.sroa.7.0.copyload, %if.then77 ], [ 0, %for.cond67.preheader ]
  %cmp76.1 = icmp slt i32 %add74, 29
  br i1 %cmp76.1, label %if.then77.1, label %if.end115.1

if.then77.1:                                      ; preds = %if.end115
  %23 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %22
  %add.ptr93.1 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 2048
  %condval_1.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr93.1, align 16, !tbaa !30
  %condval_1.sroa.5.0.add.ptr93.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 2052
  %condval_1.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr93.sroa_idx.1, align 4, !tbaa !30
  %condval_1.sroa.6.0.add.ptr93.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 2056
  %condval_1.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr93.sroa_idx.1, align 8, !tbaa !30
  %condval_1.sroa.7.0.add.ptr93.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 2060
  %condval_1.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr93.sroa_idx.1, align 4, !tbaa !30
  br label %if.end115.1

if.end115.1:                                      ; preds = %if.then77.1, %if.end115
  %condval_1.sroa.0.0.1 = phi i32 [ %condval_1.sroa.0.0.copyload.1, %if.then77.1 ], [ 0, %if.end115 ]
  %condval_1.sroa.5.0.1 = phi i32 [ %condval_1.sroa.5.0.copyload.1, %if.then77.1 ], [ 0, %if.end115 ]
  %condval_1.sroa.6.0.1 = phi i32 [ %condval_1.sroa.6.0.copyload.1, %if.then77.1 ], [ 0, %if.end115 ]
  %condval_1.sroa.7.0.1 = phi i32 [ %condval_1.sroa.7.0.copyload.1, %if.then77.1 ], [ 0, %if.end115 ]
  br i1 %cmp76, label %if.then133, label %if.end173

if.then133:                                       ; preds = %if.end115.1
  %add.ptr149 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %22
  %condval_2.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr149, align 16, !tbaa !30
  %condval_2.sroa.5.0.add.ptr149.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr149, i64 4
  %condval_2.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr149.sroa_idx, align 4, !tbaa !30
  %condval_2.sroa.6.0.add.ptr149.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr149, i64 8
  %condval_2.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr149.sroa_idx, align 8, !tbaa !30
  %condval_2.sroa.7.0.add.ptr149.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr149, i64 12
  %condval_2.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr149.sroa_idx, align 4, !tbaa !30
  br label %if.end173

if.end173:                                        ; preds = %if.end115.1, %if.then133
  %condval_2.sroa.0.0 = phi i32 [ %condval_2.sroa.0.0.copyload, %if.then133 ], [ 0, %if.end115.1 ]
  %condval_2.sroa.5.0 = phi i32 [ %condval_2.sroa.5.0.copyload, %if.then133 ], [ 0, %if.end115.1 ]
  %condval_2.sroa.6.0 = phi i32 [ %condval_2.sroa.6.0.copyload, %if.then133 ], [ 0, %if.end115.1 ]
  %condval_2.sroa.7.0 = phi i32 [ %condval_2.sroa.7.0.copyload, %if.then133 ], [ 0, %if.end115.1 ]
  br i1 %cmp76.1, label %if.then133.1, label %if.end173.1

if.then133.1:                                     ; preds = %if.end173
  %24 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %22
  %add.ptr149.1 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 2048
  %condval_2.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr149.1, align 16, !tbaa !30
  %condval_2.sroa.5.0.add.ptr149.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 2052
  %condval_2.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr149.sroa_idx.1, align 4, !tbaa !30
  %condval_2.sroa.6.0.add.ptr149.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 2056
  %condval_2.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr149.sroa_idx.1, align 8, !tbaa !30
  %condval_2.sroa.7.0.add.ptr149.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 2060
  %condval_2.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr149.sroa_idx.1, align 4, !tbaa !30
  br label %if.end173.1

if.end173.1:                                      ; preds = %if.then133.1, %if.end173
  %condval_2.sroa.0.0.1 = phi i32 [ %condval_2.sroa.0.0.copyload.1, %if.then133.1 ], [ 0, %if.end173 ]
  %condval_2.sroa.5.0.1 = phi i32 [ %condval_2.sroa.5.0.copyload.1, %if.then133.1 ], [ 0, %if.end173 ]
  %condval_2.sroa.6.0.1 = phi i32 [ %condval_2.sroa.6.0.copyload.1, %if.then133.1 ], [ 0, %if.end173 ]
  %condval_2.sroa.7.0.1 = phi i32 [ %condval_2.sroa.7.0.copyload.1, %if.then133.1 ], [ 0, %if.end173 ]
  store i32 %condval_1.sroa.0.0, ptr addrspace(3) %invariant.gep675, align 16, !tbaa !30
  store i32 %condval_1.sroa.5.0, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep675.sroa_idx, align 4, !tbaa !30
  store i32 %condval_1.sroa.6.0, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep675.sroa_idx, align 8, !tbaa !30
  store i32 %condval_1.sroa.7.0, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep675.sroa_idx, align 4, !tbaa !30
  store i32 %condval_1.sroa.0.0.1, ptr addrspace(3) %gep676.1, align 16, !tbaa !30
  store i32 %condval_1.sroa.5.0.1, ptr addrspace(3) %K_reg.sroa.9.16.gep676.1.sroa_idx, align 4, !tbaa !30
  store i32 %condval_1.sroa.6.0.1, ptr addrspace(3) %K_reg.sroa.10.16.gep676.1.sroa_idx, align 8, !tbaa !30
  store i32 %condval_1.sroa.7.0.1, ptr addrspace(3) %K_reg.sroa.11.16.gep676.1.sroa_idx, align 4, !tbaa !30
  %cmp205 = icmp sgt i32 %21, 21
  br i1 %cmp205, label %for.cond207.preheader, label %if.end231

for.cond207.preheader:                            ; preds = %if.end173.1
  %add214 = add nuw nsw i32 %21, %mul213
  %cmp216 = icmp slt i32 %add214, 37
  %.fneg = select i1 %cmp216, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.0.vec.insert759 = insertelement <4 x float> poison, float %.fneg, i64 0
  %cmp216.1 = icmp slt i32 %add214, 36
  %.fneg.1 = select i1 %cmp216.1, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert768 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert759, float %.fneg.1, i64 1
  %cmp216.2 = icmp slt i32 %add214, 35
  %.fneg.2 = select i1 %cmp216.2, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.8.vec.insert777 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert768, float %.fneg.2, i64 2
  %cmp216.3 = icmp slt i32 %add214, 34
  %.fneg.3 = select i1 %cmp216.3, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.12.vec.insert786 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert777, float %.fneg.3, i64 3
  br label %if.end231

if.end231:                                        ; preds = %if.end173.1, %for.cond207.preheader, %for.body60
  %V_reg.sroa.11.1 = phi i32 [ %condval_2.sroa.7.0.1, %for.cond207.preheader ], [ %V_reg.sroa.11.0, %for.body60 ], [ %condval_2.sroa.7.0.1, %if.end173.1 ]
  %V_reg.sroa.10.1 = phi i32 [ %condval_2.sroa.6.0.1, %for.cond207.preheader ], [ %V_reg.sroa.10.0, %for.body60 ], [ %condval_2.sroa.6.0.1, %if.end173.1 ]
  %V_reg.sroa.9.1 = phi i32 [ %condval_2.sroa.5.0.1, %for.cond207.preheader ], [ %V_reg.sroa.9.0, %for.body60 ], [ %condval_2.sroa.5.0.1, %if.end173.1 ]
  %V_reg.sroa.7.1 = phi i32 [ %condval_2.sroa.0.0.1, %for.cond207.preheader ], [ %V_reg.sroa.7.0, %for.body60 ], [ %condval_2.sroa.0.0.1, %if.end173.1 ]
  %V_reg.sroa.6.1 = phi i32 [ %condval_2.sroa.7.0, %for.cond207.preheader ], [ %V_reg.sroa.6.0, %for.body60 ], [ %condval_2.sroa.7.0, %if.end173.1 ]
  %V_reg.sroa.5.1 = phi i32 [ %condval_2.sroa.6.0, %for.cond207.preheader ], [ %V_reg.sroa.5.0, %for.body60 ], [ %condval_2.sroa.6.0, %if.end173.1 ]
  %V_reg.sroa.4.1 = phi i32 [ %condval_2.sroa.5.0, %for.cond207.preheader ], [ %V_reg.sroa.4.0, %for.body60 ], [ %condval_2.sroa.5.0, %if.end173.1 ]
  %V_reg.sroa.0.1 = phi i32 [ %condval_2.sroa.0.0, %for.cond207.preheader ], [ %V_reg.sroa.0.0, %for.body60 ], [ %condval_2.sroa.0.0, %if.end173.1 ]
  %acc_s.sroa.0.1 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert786, %for.cond207.preheader ], [ %acc_s.sroa.0.0, %for.body60 ], [ zeroinitializer, %if.end173.1 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %or.cond702, label %for.cond236.preheader, label %if.end346

for.cond236.preheader:                            ; preds = %if.end231
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr253, align 16
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr253.sroa_idx, align 8
  %25 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.1), !call_argsrelate !83
  %26 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %25), !call_argsrelate !83
  %kb.sroa.0.0.copyload753 = load <4 x half>, ptr addrspace(3) %add.ptr253.1, align 16
  %kb.sroa.6.0.copyload754 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr253.1.sroa_idx, align 8
  %27 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload753, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %26), !call_argsrelate !83
  %28 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload754, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %27), !call_argsrelate !83
  store i32 %V_reg.sroa.0.1, ptr addrspace(3) %invariant.gep687, align 16, !tbaa !30
  store i32 %V_reg.sroa.4.1, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep687.sroa_idx, align 4, !tbaa !30
  store i32 %V_reg.sroa.5.1, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep687.sroa_idx, align 8, !tbaa !30
  store i32 %V_reg.sroa.6.1, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep687.sroa_idx, align 4, !tbaa !30
  store i32 %V_reg.sroa.7.1, ptr addrspace(3) %gep.1, align 16, !tbaa !30
  store i32 %V_reg.sroa.9.1, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !tbaa !30
  store i32 %V_reg.sroa.10.1, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !tbaa !30
  store i32 %V_reg.sroa.11.1, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !tbaa !30
  %acc_s.sroa.0.0.vec.extract761 = extractelement <4 x float> %28, i64 0
  %mul310 = fmul contract float %acc_s.sroa.0.0.vec.extract761, 0x3FC2776C60000000
  %29 = tail call contract noundef float @llvm.minnum.f32(float %mul310, float 1.500000e+01)
  %cmp.i.i = fcmp contract olt float %29, -1.260000e+02
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00
  %add.i.i636 = fadd contract float %29, %cond.i.i
  %30 = tail call contract float @llvm.exp2.f32(float %add.i.i636)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %cond2.i.i, %30
  %acc_s.sroa.0.0.vec.insert763 = insertelement <4 x float> poison, float %mul.i.i, i64 0
  %acc_s.sroa.0.4.vec.extract770 = extractelement <4 x float> %28, i64 1
  %mul310.1 = fmul contract float %acc_s.sroa.0.4.vec.extract770, 0x3FC2776C60000000
  %31 = tail call contract noundef float @llvm.minnum.f32(float %mul310.1, float 1.500000e+01)
  %cmp.i.i.1 = fcmp contract olt float %31, -1.260000e+02
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i636.1 = fadd contract float %31, %cond.i.i.1
  %32 = tail call contract float @llvm.exp2.f32(float %add.i.i636.1)
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %32
  %acc_s.sroa.0.4.vec.insert772 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert763, float %mul.i.i.1, i64 1
  %acc_s.sroa.0.8.vec.extract779 = extractelement <4 x float> %28, i64 2
  %mul310.2 = fmul contract float %acc_s.sroa.0.8.vec.extract779, 0x3FC2776C60000000
  %33 = tail call contract noundef float @llvm.minnum.f32(float %mul310.2, float 1.500000e+01)
  %cmp.i.i.2 = fcmp contract olt float %33, -1.260000e+02
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00
  %add.i.i636.2 = fadd contract float %33, %cond.i.i.2
  %34 = tail call contract float @llvm.exp2.f32(float %add.i.i636.2)
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %34
  %acc_s.sroa.0.8.vec.insert781 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert772, float %mul.i.i.2, i64 2
  %acc_s.sroa.0.12.vec.extract788 = extractelement <4 x float> %28, i64 3
  %mul310.3 = fmul contract float %acc_s.sroa.0.12.vec.extract788, 0x3FC2776C60000000
  %35 = tail call contract noundef float @llvm.minnum.f32(float %mul310.3, float 1.500000e+01)
  %cmp.i.i.3 = fcmp contract olt float %35, -1.260000e+02
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00
  %add.i.i636.3 = fadd contract float %35, %cond.i.i.3
  %36 = tail call contract float @llvm.exp2.f32(float %add.i.i636.3)
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %36
  %acc_s.sroa.0.12.vec.insert790 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert781, float %mul.i.i.3, i64 3
  %add326 = fadd contract float %sum_acc.sroa.0.0, %mul.i.i
  %add326.1 = fadd contract float %sum_acc.sroa.6.0, %mul.i.i.1
  %add326.2 = fadd contract float %sum_acc.sroa.10.0, %mul.i.i.2
  %add326.3 = fadd contract float %sum_acc.sroa.14.0, %mul.i.i.3
  %37 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !104
  %38 = fptrunc float %mul.i.i to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %37), !noalias !104
  %39 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !104
  %40 = fptrunc float %mul.i.i.1 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %39), !noalias !104
  %__1.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %38, i64 0
  %__1.sroa.0.2.vec.insert = insertelement <4 x half> %__1.sroa.0.0.vec.insert, half %40, i64 1
  %41 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !118
  %42 = fptrunc float %mul.i.i.2 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %41), !noalias !118
  %43 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !118
  %44 = fptrunc float %mul.i.i.3 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %43), !noalias !118
  %__1.sroa.0.4.vec.insert = insertelement <4 x half> %__1.sroa.0.2.vec.insert, half %42, i64 2
  %__1.sroa.0.6.vec.insert = insertelement <4 x half> %__1.sroa.0.4.vec.insert, half %44, i64 3
  br label %if.end346

if.end346:                                        ; preds = %for.cond236.preheader, %if.end231
  %sum_acc.sroa.0.1 = phi float [ %add326, %for.cond236.preheader ], [ %sum_acc.sroa.0.0, %if.end231 ]
  %sum_acc.sroa.6.1 = phi float [ %add326.1, %for.cond236.preheader ], [ %sum_acc.sroa.6.0, %if.end231 ]
  %sum_acc.sroa.10.1 = phi float [ %add326.2, %for.cond236.preheader ], [ %sum_acc.sroa.10.0, %if.end231 ]
  %sum_acc.sroa.14.1 = phi float [ %add326.3, %for.cond236.preheader ], [ %sum_acc.sroa.14.0, %if.end231 ]
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert790, %for.cond236.preheader ], [ %acc_s.sroa.0.1, %if.end231 ]
  %acc_s_cast.sroa.0.1 = phi <4 x half> [ %__1.sroa.0.6.vec.insert, %for.cond236.preheader ], [ %acc_s_cast.sroa.0.0697, %if.end231 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %or.cond702, label %for.cond355.preheader.preheader, label %if.end411

for.cond355.preheader.preheader:                  ; preds = %if.end346
  %45 = load half, ptr addrspace(3) %gep691, align 2, !tbaa !135
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %45, i64 0
  %46 = load half, ptr addrspace(3) %gep691.1, align 2, !tbaa !135
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %46, i64 1
  %47 = load half, ptr addrspace(3) %gep691.2, align 2, !tbaa !135
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %47, i64 2
  %48 = load half, ptr addrspace(3) %gep691.3, align 2, !tbaa !135
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %48, i64 3
  %49 = load half, ptr addrspace(3) %gep691.1727, align 2, !tbaa !135
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %49, i64 0
  %50 = load half, ptr addrspace(3) %gep691.1.1, align 2, !tbaa !135
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %50, i64 1
  %51 = load half, ptr addrspace(3) %gep691.2.1, align 2, !tbaa !135
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %51, i64 2
  %52 = load half, ptr addrspace(3) %gep691.3.1, align 2, !tbaa !135
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %52, i64 3
  %53 = load half, ptr addrspace(3) %gep691.2733, align 2, !tbaa !135
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %53, i64 0
  %54 = load half, ptr addrspace(3) %gep691.1.2, align 2, !tbaa !135
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %54, i64 1
  %55 = load half, ptr addrspace(3) %gep691.2.2, align 2, !tbaa !135
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %55, i64 2
  %56 = load half, ptr addrspace(3) %gep691.3.2, align 2, !tbaa !135
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %56, i64 3
  %57 = load half, ptr addrspace(3) %gep691.3739, align 2, !tbaa !135
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %57, i64 0
  %58 = load half, ptr addrspace(3) %gep691.1.3, align 2, !tbaa !135
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %58, i64 1
  %59 = load half, ptr addrspace(3) %gep691.2.3, align 2, !tbaa !135
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %59, i64 2
  %60 = load half, ptr addrspace(3) %gep691.3.3, align 2, !tbaa !135
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %60, i64 3
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.1, <4 x float> %acc_o.sroa.0.0)
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.1, <4 x float> %acc_o.sroa.20.0)
  %63 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.1, <4 x float> %acc_o.sroa.38.0)
  %64 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.1, <4 x float> %acc_o.sroa.56.0)
  br label %if.end411

if.end411:                                        ; preds = %for.cond355.preheader.preheader, %if.end346
  %acc_o.sroa.0.1 = phi <4 x float> [ %61, %for.cond355.preheader.preheader ], [ %acc_o.sroa.0.0, %if.end346 ]
  %acc_o.sroa.20.1 = phi <4 x float> [ %62, %for.cond355.preheader.preheader ], [ %acc_o.sroa.20.0, %if.end346 ]
  %acc_o.sroa.38.1 = phi <4 x float> [ %63, %for.cond355.preheader.preheader ], [ %acc_o.sroa.38.0, %if.end346 ]
  %acc_o.sroa.56.1 = phi <4 x float> [ %64, %for.cond355.preheader.preheader ], [ %acc_o.sroa.56.0, %if.end346 ]
  %inc413 = or disjoint i32 %s.0696, 1
  %arrayidx62.1 = getelementptr inbounds [4 x i32], ptr addrspace(5) %indices, i32 0, i32 %inc413
  %65 = load i32, ptr addrspace(5) %arrayidx62.1, align 4, !tbaa !30
  %or.cond702.1 = icmp ult i32 %65, 37
  br i1 %or.cond702.1, label %for.cond67.preheader.1, label %if.end231.1

for.cond67.preheader.1:                           ; preds = %if.end411
  %add74.1 = add nuw nsw i32 %65, %shr73
  %mul83.1 = shl nuw nsw i32 %65, 7
  %add87.1 = add nuw nsw i32 %add84, %mul83.1
  %66 = zext nneg i32 %add87.1 to i64
  %cmp76.1881 = icmp slt i32 %add74.1, 37
  br i1 %cmp76.1881, label %if.then77.1890, label %if.end115.1895

if.then77.1890:                                   ; preds = %for.cond67.preheader.1
  %add.ptr93.1882 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %66
  %condval_1.sroa.0.0.copyload.1883 = load i32, ptr addrspace(4) %add.ptr93.1882, align 16, !tbaa !30
  %condval_1.sroa.5.0.add.ptr93.sroa_idx.1884 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr93.1882, i64 4
  %condval_1.sroa.5.0.copyload.1885 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr93.sroa_idx.1884, align 4, !tbaa !30
  %condval_1.sroa.6.0.add.ptr93.sroa_idx.1886 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr93.1882, i64 8
  %condval_1.sroa.6.0.copyload.1887 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr93.sroa_idx.1886, align 8, !tbaa !30
  %condval_1.sroa.7.0.add.ptr93.sroa_idx.1888 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr93.1882, i64 12
  %condval_1.sroa.7.0.copyload.1889 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr93.sroa_idx.1888, align 4, !tbaa !30
  br label %if.end115.1895

if.end115.1895:                                   ; preds = %if.then77.1890, %for.cond67.preheader.1
  %condval_1.sroa.0.0.1891 = phi i32 [ %condval_1.sroa.0.0.copyload.1883, %if.then77.1890 ], [ 0, %for.cond67.preheader.1 ]
  %condval_1.sroa.5.0.1892 = phi i32 [ %condval_1.sroa.5.0.copyload.1885, %if.then77.1890 ], [ 0, %for.cond67.preheader.1 ]
  %condval_1.sroa.6.0.1893 = phi i32 [ %condval_1.sroa.6.0.copyload.1887, %if.then77.1890 ], [ 0, %for.cond67.preheader.1 ]
  %condval_1.sroa.7.0.1894 = phi i32 [ %condval_1.sroa.7.0.copyload.1889, %if.then77.1890 ], [ 0, %for.cond67.preheader.1 ]
  %cmp76.1.1 = icmp slt i32 %add74.1, 29
  br i1 %cmp76.1.1, label %if.then77.1.1, label %if.end115.1.1

if.then77.1.1:                                    ; preds = %if.end115.1895
  %67 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %66
  %add.ptr93.1.1 = getelementptr inbounds i8, ptr addrspace(4) %67, i64 2048
  %condval_1.sroa.0.0.copyload.1.1 = load i32, ptr addrspace(4) %add.ptr93.1.1, align 16, !tbaa !30
  %condval_1.sroa.5.0.add.ptr93.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %67, i64 2052
  %condval_1.sroa.5.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr93.sroa_idx.1.1, align 4, !tbaa !30
  %condval_1.sroa.6.0.add.ptr93.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %67, i64 2056
  %condval_1.sroa.6.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr93.sroa_idx.1.1, align 8, !tbaa !30
  %condval_1.sroa.7.0.add.ptr93.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %67, i64 2060
  %condval_1.sroa.7.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr93.sroa_idx.1.1, align 4, !tbaa !30
  br label %if.end115.1.1

if.end115.1.1:                                    ; preds = %if.then77.1.1, %if.end115.1895
  %condval_1.sroa.0.0.1.1 = phi i32 [ %condval_1.sroa.0.0.copyload.1.1, %if.then77.1.1 ], [ 0, %if.end115.1895 ]
  %condval_1.sroa.5.0.1.1 = phi i32 [ %condval_1.sroa.5.0.copyload.1.1, %if.then77.1.1 ], [ 0, %if.end115.1895 ]
  %condval_1.sroa.6.0.1.1 = phi i32 [ %condval_1.sroa.6.0.copyload.1.1, %if.then77.1.1 ], [ 0, %if.end115.1895 ]
  %condval_1.sroa.7.0.1.1 = phi i32 [ %condval_1.sroa.7.0.copyload.1.1, %if.then77.1.1 ], [ 0, %if.end115.1895 ]
  br i1 %cmp76.1881, label %if.then133.1904, label %if.end173.1909

if.then133.1904:                                  ; preds = %if.end115.1.1
  %add.ptr149.1896 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %66
  %condval_2.sroa.0.0.copyload.1897 = load i32, ptr addrspace(4) %add.ptr149.1896, align 16, !tbaa !30
  %condval_2.sroa.5.0.add.ptr149.sroa_idx.1898 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr149.1896, i64 4
  %condval_2.sroa.5.0.copyload.1899 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr149.sroa_idx.1898, align 4, !tbaa !30
  %condval_2.sroa.6.0.add.ptr149.sroa_idx.1900 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr149.1896, i64 8
  %condval_2.sroa.6.0.copyload.1901 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr149.sroa_idx.1900, align 8, !tbaa !30
  %condval_2.sroa.7.0.add.ptr149.sroa_idx.1902 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr149.1896, i64 12
  %condval_2.sroa.7.0.copyload.1903 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr149.sroa_idx.1902, align 4, !tbaa !30
  br label %if.end173.1909

if.end173.1909:                                   ; preds = %if.then133.1904, %if.end115.1.1
  %condval_2.sroa.0.0.1905 = phi i32 [ %condval_2.sroa.0.0.copyload.1897, %if.then133.1904 ], [ 0, %if.end115.1.1 ]
  %condval_2.sroa.5.0.1906 = phi i32 [ %condval_2.sroa.5.0.copyload.1899, %if.then133.1904 ], [ 0, %if.end115.1.1 ]
  %condval_2.sroa.6.0.1907 = phi i32 [ %condval_2.sroa.6.0.copyload.1901, %if.then133.1904 ], [ 0, %if.end115.1.1 ]
  %condval_2.sroa.7.0.1908 = phi i32 [ %condval_2.sroa.7.0.copyload.1903, %if.then133.1904 ], [ 0, %if.end115.1.1 ]
  br i1 %cmp76.1.1, label %if.then133.1.1, label %if.end173.1.1

if.then133.1.1:                                   ; preds = %if.end173.1909
  %68 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %66
  %add.ptr149.1.1 = getelementptr inbounds i8, ptr addrspace(4) %68, i64 2048
  %condval_2.sroa.0.0.copyload.1.1 = load i32, ptr addrspace(4) %add.ptr149.1.1, align 16, !tbaa !30
  %condval_2.sroa.5.0.add.ptr149.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %68, i64 2052
  %condval_2.sroa.5.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr149.sroa_idx.1.1, align 4, !tbaa !30
  %condval_2.sroa.6.0.add.ptr149.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %68, i64 2056
  %condval_2.sroa.6.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr149.sroa_idx.1.1, align 8, !tbaa !30
  %condval_2.sroa.7.0.add.ptr149.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %68, i64 2060
  %condval_2.sroa.7.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr149.sroa_idx.1.1, align 4, !tbaa !30
  br label %if.end173.1.1

if.end173.1.1:                                    ; preds = %if.then133.1.1, %if.end173.1909
  %condval_2.sroa.0.0.1.1 = phi i32 [ %condval_2.sroa.0.0.copyload.1.1, %if.then133.1.1 ], [ 0, %if.end173.1909 ]
  %condval_2.sroa.5.0.1.1 = phi i32 [ %condval_2.sroa.5.0.copyload.1.1, %if.then133.1.1 ], [ 0, %if.end173.1909 ]
  %condval_2.sroa.6.0.1.1 = phi i32 [ %condval_2.sroa.6.0.copyload.1.1, %if.then133.1.1 ], [ 0, %if.end173.1909 ]
  %condval_2.sroa.7.0.1.1 = phi i32 [ %condval_2.sroa.7.0.copyload.1.1, %if.then133.1.1 ], [ 0, %if.end173.1909 ]
  store i32 %condval_1.sroa.0.0.1891, ptr addrspace(3) %invariant.gep675, align 16, !tbaa !30
  store i32 %condval_1.sroa.5.0.1892, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep675.sroa_idx, align 4, !tbaa !30
  store i32 %condval_1.sroa.6.0.1893, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep675.sroa_idx, align 8, !tbaa !30
  store i32 %condval_1.sroa.7.0.1894, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep675.sroa_idx, align 4, !tbaa !30
  store i32 %condval_1.sroa.0.0.1.1, ptr addrspace(3) %gep676.1, align 16, !tbaa !30
  store i32 %condval_1.sroa.5.0.1.1, ptr addrspace(3) %K_reg.sroa.9.16.gep676.1.sroa_idx, align 4, !tbaa !30
  store i32 %condval_1.sroa.6.0.1.1, ptr addrspace(3) %K_reg.sroa.10.16.gep676.1.sroa_idx, align 8, !tbaa !30
  store i32 %condval_1.sroa.7.0.1.1, ptr addrspace(3) %K_reg.sroa.11.16.gep676.1.sroa_idx, align 4, !tbaa !30
  %cmp205.1 = icmp sgt i32 %65, 21
  br i1 %cmp205.1, label %for.cond207.preheader.1, label %if.end231.1

for.cond207.preheader.1:                          ; preds = %if.end173.1.1
  %add214.1 = add nuw nsw i32 %65, %mul213
  %cmp216.1910 = icmp slt i32 %add214.1, 37
  %.fneg.1911 = select i1 %cmp216.1910, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.0.vec.insert759.1 = insertelement <4 x float> poison, float %.fneg.1911, i64 0
  %cmp216.1.1 = icmp slt i32 %add214.1, 36
  %.fneg.1.1 = select i1 %cmp216.1.1, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert768.1 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert759.1, float %.fneg.1.1, i64 1
  %cmp216.2.1 = icmp slt i32 %add214.1, 35
  %.fneg.2.1 = select i1 %cmp216.2.1, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.8.vec.insert777.1 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert768.1, float %.fneg.2.1, i64 2
  %cmp216.3.1 = icmp slt i32 %add214.1, 34
  %.fneg.3.1 = select i1 %cmp216.3.1, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.12.vec.insert786.1 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert777.1, float %.fneg.3.1, i64 3
  br label %if.end231.1

if.end231.1:                                      ; preds = %for.cond207.preheader.1, %if.end173.1.1, %if.end411
  %V_reg.sroa.11.1.1 = phi i32 [ %condval_2.sroa.7.0.1.1, %for.cond207.preheader.1 ], [ %V_reg.sroa.11.1, %if.end411 ], [ %condval_2.sroa.7.0.1.1, %if.end173.1.1 ]
  %V_reg.sroa.10.1.1 = phi i32 [ %condval_2.sroa.6.0.1.1, %for.cond207.preheader.1 ], [ %V_reg.sroa.10.1, %if.end411 ], [ %condval_2.sroa.6.0.1.1, %if.end173.1.1 ]
  %V_reg.sroa.9.1.1 = phi i32 [ %condval_2.sroa.5.0.1.1, %for.cond207.preheader.1 ], [ %V_reg.sroa.9.1, %if.end411 ], [ %condval_2.sroa.5.0.1.1, %if.end173.1.1 ]
  %V_reg.sroa.7.1.1 = phi i32 [ %condval_2.sroa.0.0.1.1, %for.cond207.preheader.1 ], [ %V_reg.sroa.7.1, %if.end411 ], [ %condval_2.sroa.0.0.1.1, %if.end173.1.1 ]
  %V_reg.sroa.6.1.1 = phi i32 [ %condval_2.sroa.7.0.1908, %for.cond207.preheader.1 ], [ %V_reg.sroa.6.1, %if.end411 ], [ %condval_2.sroa.7.0.1908, %if.end173.1.1 ]
  %V_reg.sroa.5.1.1 = phi i32 [ %condval_2.sroa.6.0.1907, %for.cond207.preheader.1 ], [ %V_reg.sroa.5.1, %if.end411 ], [ %condval_2.sroa.6.0.1907, %if.end173.1.1 ]
  %V_reg.sroa.4.1.1 = phi i32 [ %condval_2.sroa.5.0.1906, %for.cond207.preheader.1 ], [ %V_reg.sroa.4.1, %if.end411 ], [ %condval_2.sroa.5.0.1906, %if.end173.1.1 ]
  %V_reg.sroa.0.1.1 = phi i32 [ %condval_2.sroa.0.0.1905, %for.cond207.preheader.1 ], [ %V_reg.sroa.0.1, %if.end411 ], [ %condval_2.sroa.0.0.1905, %if.end173.1.1 ]
  %acc_s.sroa.0.1.1 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert786.1, %for.cond207.preheader.1 ], [ %acc_s.sroa.0.2, %if.end411 ], [ zeroinitializer, %if.end173.1.1 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %or.cond702.1, label %for.cond236.preheader.1, label %if.end346.1

for.cond236.preheader.1:                          ; preds = %if.end231.1
  %kb.sroa.0.0.copyload.1 = load <4 x half>, ptr addrspace(3) %add.ptr253, align 16
  %kb.sroa.6.0.copyload.1 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr253.sroa_idx, align 8
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.1.1), !call_argsrelate !83
  %70 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload.1, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %69), !call_argsrelate !83
  %kb.sroa.0.0.copyload753.1 = load <4 x half>, ptr addrspace(3) %add.ptr253.1, align 16
  %kb.sroa.6.0.copyload754.1 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr253.1.sroa_idx, align 8
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload753.1, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %70), !call_argsrelate !83
  %72 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload754.1, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %71), !call_argsrelate !83
  store i32 %V_reg.sroa.0.1.1, ptr addrspace(3) %invariant.gep687, align 16, !tbaa !30
  store i32 %V_reg.sroa.4.1.1, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep687.sroa_idx, align 4, !tbaa !30
  store i32 %V_reg.sroa.5.1.1, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep687.sroa_idx, align 8, !tbaa !30
  store i32 %V_reg.sroa.6.1.1, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep687.sroa_idx, align 4, !tbaa !30
  store i32 %V_reg.sroa.7.1.1, ptr addrspace(3) %gep.1, align 16, !tbaa !30
  store i32 %V_reg.sroa.9.1.1, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !tbaa !30
  store i32 %V_reg.sroa.10.1.1, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !tbaa !30
  store i32 %V_reg.sroa.11.1.1, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !tbaa !30
  %acc_s.sroa.0.0.vec.extract761.1 = extractelement <4 x float> %72, i64 0
  %mul310.1912 = fmul contract float %acc_s.sroa.0.0.vec.extract761.1, 0x3FC2776C60000000
  %73 = tail call contract noundef float @llvm.minnum.f32(float %mul310.1912, float 1.500000e+01)
  %cmp.i.i.1913 = fcmp contract olt float %73, -1.260000e+02
  %cond.i.i.1914 = select contract i1 %cmp.i.i.1913, float 6.400000e+01, float 0.000000e+00
  %add.i.i636.1915 = fadd contract float %73, %cond.i.i.1914
  %74 = tail call contract float @llvm.exp2.f32(float %add.i.i636.1915)
  %cond2.i.i.1916 = select contract i1 %cmp.i.i.1913, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1917 = fmul contract float %cond2.i.i.1916, %74
  %acc_s.sroa.0.0.vec.insert763.1 = insertelement <4 x float> poison, float %mul.i.i.1917, i64 0
  %acc_s.sroa.0.4.vec.extract770.1 = extractelement <4 x float> %72, i64 1
  %mul310.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract770.1, 0x3FC2776C60000000
  %75 = tail call contract noundef float @llvm.minnum.f32(float %mul310.1.1, float 1.500000e+01)
  %cmp.i.i.1.1 = fcmp contract olt float %75, -1.260000e+02
  %cond.i.i.1.1 = select contract i1 %cmp.i.i.1.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i636.1.1 = fadd contract float %75, %cond.i.i.1.1
  %76 = tail call contract float @llvm.exp2.f32(float %add.i.i636.1.1)
  %cond2.i.i.1.1 = select contract i1 %cmp.i.i.1.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1.1 = fmul contract float %cond2.i.i.1.1, %76
  %acc_s.sroa.0.4.vec.insert772.1 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert763.1, float %mul.i.i.1.1, i64 1
  %acc_s.sroa.0.8.vec.extract779.1 = extractelement <4 x float> %72, i64 2
  %mul310.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract779.1, 0x3FC2776C60000000
  %77 = tail call contract noundef float @llvm.minnum.f32(float %mul310.2.1, float 1.500000e+01)
  %cmp.i.i.2.1 = fcmp contract olt float %77, -1.260000e+02
  %cond.i.i.2.1 = select contract i1 %cmp.i.i.2.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i636.2.1 = fadd contract float %77, %cond.i.i.2.1
  %78 = tail call contract float @llvm.exp2.f32(float %add.i.i636.2.1)
  %cond2.i.i.2.1 = select contract i1 %cmp.i.i.2.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2.1 = fmul contract float %cond2.i.i.2.1, %78
  %acc_s.sroa.0.8.vec.insert781.1 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert772.1, float %mul.i.i.2.1, i64 2
  %acc_s.sroa.0.12.vec.extract788.1 = extractelement <4 x float> %72, i64 3
  %mul310.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract788.1, 0x3FC2776C60000000
  %79 = tail call contract noundef float @llvm.minnum.f32(float %mul310.3.1, float 1.500000e+01)
  %cmp.i.i.3.1 = fcmp contract olt float %79, -1.260000e+02
  %cond.i.i.3.1 = select contract i1 %cmp.i.i.3.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i636.3.1 = fadd contract float %79, %cond.i.i.3.1
  %80 = tail call contract float @llvm.exp2.f32(float %add.i.i636.3.1)
  %cond2.i.i.3.1 = select contract i1 %cmp.i.i.3.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3.1 = fmul contract float %cond2.i.i.3.1, %80
  %acc_s.sroa.0.12.vec.insert790.1 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert781.1, float %mul.i.i.3.1, i64 3
  %add326.1918 = fadd contract float %sum_acc.sroa.0.1, %mul.i.i.1917
  %add326.1.1 = fadd contract float %sum_acc.sroa.6.1, %mul.i.i.1.1
  %add326.2.1 = fadd contract float %sum_acc.sroa.10.1, %mul.i.i.2.1
  %add326.3.1 = fadd contract float %sum_acc.sroa.14.1, %mul.i.i.3.1
  %81 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !104
  %82 = fptrunc float %mul.i.i.1917 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %81), !noalias !104
  %83 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !104
  %84 = fptrunc float %mul.i.i.1.1 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %83), !noalias !104
  %__1.sroa.0.0.vec.insert.1 = insertelement <4 x half> poison, half %82, i64 0
  %__1.sroa.0.2.vec.insert.1 = insertelement <4 x half> %__1.sroa.0.0.vec.insert.1, half %84, i64 1
  %85 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !118
  %86 = fptrunc float %mul.i.i.2.1 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %85), !noalias !118
  %87 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !118
  %88 = fptrunc float %mul.i.i.3.1 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %87), !noalias !118
  %__1.sroa.0.4.vec.insert.1 = insertelement <4 x half> %__1.sroa.0.2.vec.insert.1, half %86, i64 2
  %__1.sroa.0.6.vec.insert.1 = insertelement <4 x half> %__1.sroa.0.4.vec.insert.1, half %88, i64 3
  br label %if.end346.1

if.end346.1:                                      ; preds = %for.cond236.preheader.1, %if.end231.1
  %sum_acc.sroa.0.1.1 = phi float [ %add326.1918, %for.cond236.preheader.1 ], [ %sum_acc.sroa.0.1, %if.end231.1 ]
  %sum_acc.sroa.6.1.1 = phi float [ %add326.1.1, %for.cond236.preheader.1 ], [ %sum_acc.sroa.6.1, %if.end231.1 ]
  %sum_acc.sroa.10.1.1 = phi float [ %add326.2.1, %for.cond236.preheader.1 ], [ %sum_acc.sroa.10.1, %if.end231.1 ]
  %sum_acc.sroa.14.1.1 = phi float [ %add326.3.1, %for.cond236.preheader.1 ], [ %sum_acc.sroa.14.1, %if.end231.1 ]
  %acc_s.sroa.0.2.1 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert790.1, %for.cond236.preheader.1 ], [ %acc_s.sroa.0.1.1, %if.end231.1 ]
  %acc_s_cast.sroa.0.1.1 = phi <4 x half> [ %__1.sroa.0.6.vec.insert.1, %for.cond236.preheader.1 ], [ %acc_s_cast.sroa.0.1, %if.end231.1 ]
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  br i1 %or.cond702.1, label %for.cond355.preheader.preheader.1, label %if.end411.1

for.cond355.preheader.preheader.1:                ; preds = %if.end346.1
  %89 = load half, ptr addrspace(3) %gep691, align 2, !tbaa !135
  %vb.sroa.0.0.vec.insert.1 = insertelement <4 x half> poison, half %89, i64 0
  %90 = load half, ptr addrspace(3) %gep691.1, align 2, !tbaa !135
  %vb.sroa.0.2.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.0.vec.insert.1, half %90, i64 1
  %91 = load half, ptr addrspace(3) %gep691.2, align 2, !tbaa !135
  %vb.sroa.0.4.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.2.vec.insert.1, half %91, i64 2
  %92 = load half, ptr addrspace(3) %gep691.3, align 2, !tbaa !135
  %vb.sroa.0.6.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.4.vec.insert.1, half %92, i64 3
  %93 = load half, ptr addrspace(3) %gep691.1727, align 2, !tbaa !135
  %vb.sroa.7.8.vec.insert.1 = insertelement <4 x half> poison, half %93, i64 0
  %94 = load half, ptr addrspace(3) %gep691.1.1, align 2, !tbaa !135
  %vb.sroa.7.10.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.8.vec.insert.1, half %94, i64 1
  %95 = load half, ptr addrspace(3) %gep691.2.1, align 2, !tbaa !135
  %vb.sroa.7.12.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.10.vec.insert.1, half %95, i64 2
  %96 = load half, ptr addrspace(3) %gep691.3.1, align 2, !tbaa !135
  %vb.sroa.7.14.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.12.vec.insert.1, half %96, i64 3
  %97 = load half, ptr addrspace(3) %gep691.2733, align 2, !tbaa !135
  %vb.sroa.12.16.vec.insert.1 = insertelement <4 x half> poison, half %97, i64 0
  %98 = load half, ptr addrspace(3) %gep691.1.2, align 2, !tbaa !135
  %vb.sroa.12.18.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.16.vec.insert.1, half %98, i64 1
  %99 = load half, ptr addrspace(3) %gep691.2.2, align 2, !tbaa !135
  %vb.sroa.12.20.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.18.vec.insert.1, half %99, i64 2
  %100 = load half, ptr addrspace(3) %gep691.3.2, align 2, !tbaa !135
  %vb.sroa.12.22.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.20.vec.insert.1, half %100, i64 3
  %101 = load half, ptr addrspace(3) %gep691.3739, align 2, !tbaa !135
  %vb.sroa.17.24.vec.insert.1 = insertelement <4 x half> poison, half %101, i64 0
  %102 = load half, ptr addrspace(3) %gep691.1.3, align 2, !tbaa !135
  %vb.sroa.17.26.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.24.vec.insert.1, half %102, i64 1
  %103 = load half, ptr addrspace(3) %gep691.2.3, align 2, !tbaa !135
  %vb.sroa.17.28.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.26.vec.insert.1, half %103, i64 2
  %104 = load half, ptr addrspace(3) %gep691.3.3, align 2, !tbaa !135
  %vb.sroa.17.30.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.28.vec.insert.1, half %104, i64 3
  %105 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert.1, <4 x half> %acc_s_cast.sroa.0.1.1, <4 x float> %acc_o.sroa.0.1)
  %106 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert.1, <4 x half> %acc_s_cast.sroa.0.1.1, <4 x float> %acc_o.sroa.20.1)
  %107 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert.1, <4 x half> %acc_s_cast.sroa.0.1.1, <4 x float> %acc_o.sroa.38.1)
  %108 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert.1, <4 x half> %acc_s_cast.sroa.0.1.1, <4 x float> %acc_o.sroa.56.1)
  br label %if.end411.1

if.end411.1:                                      ; preds = %for.cond355.preheader.preheader.1, %if.end346.1
  %acc_o.sroa.0.1.1 = phi <4 x float> [ %105, %for.cond355.preheader.preheader.1 ], [ %acc_o.sroa.0.1, %if.end346.1 ]
  %acc_o.sroa.20.1.1 = phi <4 x float> [ %106, %for.cond355.preheader.preheader.1 ], [ %acc_o.sroa.20.1, %if.end346.1 ]
  %acc_o.sroa.38.1.1 = phi <4 x float> [ %107, %for.cond355.preheader.preheader.1 ], [ %acc_o.sroa.38.1, %if.end346.1 ]
  %acc_o.sroa.56.1.1 = phi <4 x float> [ %108, %for.cond355.preheader.preheader.1 ], [ %acc_o.sroa.56.1, %if.end346.1 ]
  %inc413.1 = add nuw nsw i32 %s.0696, 2
  %exitcond.not.1 = icmp eq i32 %inc413.1, 4
  br i1 %exitcond.not.1, label %for.body419.preheader, label %for.body60, !llvm.loop !139

for.body419.preheader:                            ; preds = %if.end411.1
  %add423 = fadd contract float %sum_acc.sroa.0.1.1, 0.000000e+00
  %add423.1 = fadd contract float %add423, %sum_acc.sroa.6.1.1
  %add423.2 = fadd contract float %add423.1, %sum_acc.sroa.10.1.1
  %add423.3 = fadd contract float %add423.2, %sum_acc.sroa.14.1.1
  fence syncscope("block") release
  tail call void @llvm.mxc.barrier()
  fence syncscope("block") acquire
  %109 = bitcast float %add423.3 to i32
  %110 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #12
  %111 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %110) #12
  %xor.i.i = xor i32 %111, 32
  %112 = and i32 %111, -64
  %and.i.i = add nsw i32 %112, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i638 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %111
  %shl.i.i = shl i32 %cond.i.i638, 2
  %113 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %109)
  %114 = bitcast i32 %113 to float
  %add.i = fadd contract float %add423.3, %114
  %115 = bitcast float %add.i to i32
  %116 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #12
  %117 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %116) #12
  %xor.i.i639 = xor i32 %117, 16
  %118 = and i32 %117, -64
  %and.i.i640 = add nsw i32 %118, 64
  %cmp.not.i.i641 = icmp slt i32 %xor.i.i639, %and.i.i640
  %cond.i.i642 = select i1 %cmp.not.i.i641, i32 %xor.i.i639, i32 %117
  %shl.i.i643 = shl i32 %cond.i.i642, 2
  %119 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i643, i32 %115)
  %120 = bitcast i32 %119 to float
  %add.i.i = fadd contract float %add.i, %120
  %cmp432 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add.i.i
  %condval_4.0 = select i1 %cmp432, float %div, float 0.000000e+00
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1.1, i64 0
  %mul445 = fmul contract float %condval_4.0, %acc_o.sroa.0.0.vec.extract
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1.1, i64 1
  %mul445.1 = fmul contract float %condval_4.0, %acc_o.sroa.0.4.vec.extract
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1.1, i64 2
  %mul445.2 = fmul contract float %condval_4.0, %acc_o.sroa.0.8.vec.extract
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1.1, i64 3
  %mul445.3 = fmul contract float %condval_4.0, %acc_o.sroa.0.12.vec.extract
  %acc_o.sroa.20.16.vec.extract = extractelement <4 x float> %acc_o.sroa.20.1.1, i64 0
  %mul445.4 = fmul contract float %condval_4.0, %acc_o.sroa.20.16.vec.extract
  %acc_o.sroa.20.20.vec.extract = extractelement <4 x float> %acc_o.sroa.20.1.1, i64 1
  %mul445.5 = fmul contract float %condval_4.0, %acc_o.sroa.20.20.vec.extract
  %acc_o.sroa.20.24.vec.extract = extractelement <4 x float> %acc_o.sroa.20.1.1, i64 2
  %mul445.6 = fmul contract float %condval_4.0, %acc_o.sroa.20.24.vec.extract
  %acc_o.sroa.20.28.vec.extract = extractelement <4 x float> %acc_o.sroa.20.1.1, i64 3
  %mul445.7 = fmul contract float %condval_4.0, %acc_o.sroa.20.28.vec.extract
  %acc_o.sroa.38.32.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1.1, i64 0
  %mul445.8 = fmul contract float %condval_4.0, %acc_o.sroa.38.32.vec.extract
  %acc_o.sroa.38.36.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1.1, i64 1
  %mul445.9 = fmul contract float %condval_4.0, %acc_o.sroa.38.36.vec.extract
  %acc_o.sroa.38.40.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1.1, i64 2
  %mul445.10 = fmul contract float %condval_4.0, %acc_o.sroa.38.40.vec.extract
  %acc_o.sroa.38.44.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1.1, i64 3
  %mul445.11 = fmul contract float %condval_4.0, %acc_o.sroa.38.44.vec.extract
  %acc_o.sroa.56.48.vec.extract = extractelement <4 x float> %acc_o.sroa.56.1.1, i64 0
  %mul445.12 = fmul contract float %condval_4.0, %acc_o.sroa.56.48.vec.extract
  %acc_o.sroa.56.52.vec.extract = extractelement <4 x float> %acc_o.sroa.56.1.1, i64 1
  %mul445.13 = fmul contract float %condval_4.0, %acc_o.sroa.56.52.vec.extract
  %acc_o.sroa.56.56.vec.extract = extractelement <4 x float> %acc_o.sroa.56.1.1, i64 2
  %mul445.14 = fmul contract float %condval_4.0, %acc_o.sroa.56.56.vec.extract
  %acc_o.sroa.56.60.vec.extract = extractelement <4 x float> %acc_o.sroa.56.1.1, i64 3
  %mul445.15 = fmul contract float %condval_4.0, %acc_o.sroa.56.60.vec.extract
  %add483 = add nuw nsw i32 %add26, %mul213
  %121 = zext nneg i32 %add483 to i64
  %122 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !204
  %123 = fptrunc float %mul445 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %122), !noalias !204
  %124 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !204
  %125 = fptrunc float %mul445.1 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %124), !noalias !204
  %126 = bitcast half %123 to i16
  %127 = bitcast half %125 to i16
  %128 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !219
  %129 = fptrunc float %mul445.2 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %128), !noalias !219
  %130 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !219
  %131 = fptrunc float %mul445.3 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %130), !noalias !219
  %132 = bitcast half %129 to i16
  %133 = bitcast half %131 to i16
  %__2.sroa.6.0.insert.ext = zext i16 %133 to i64
  %__2.sroa.6.0.insert.shift = shl nuw i64 %__2.sroa.6.0.insert.ext, 48
  %__2.sroa.5.0.insert.ext = zext i16 %132 to i64
  %__2.sroa.5.0.insert.shift = shl nuw nsw i64 %__2.sroa.5.0.insert.ext, 32
  %__2.sroa.5.0.insert.insert = or disjoint i64 %__2.sroa.6.0.insert.shift, %__2.sroa.5.0.insert.shift
  %__2.sroa.4.0.insert.ext = zext i16 %127 to i64
  %__2.sroa.4.0.insert.shift = shl nuw nsw i64 %__2.sroa.4.0.insert.ext, 16
  %__2.sroa.4.0.insert.insert = or disjoint i64 %__2.sroa.5.0.insert.insert, %__2.sroa.4.0.insert.shift
  %__2.sroa.0.0.insert.ext = zext i16 %126 to i64
  %__2.sroa.0.0.insert.insert = or disjoint i64 %__2.sroa.4.0.insert.insert, %__2.sroa.0.0.insert.ext
  %add.ptr489 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %121
  store i64 %__2.sroa.0.0.insert.insert, ptr addrspace(1) %add.ptr489, align 8
  %134 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !204
  %135 = fptrunc float %mul445.4 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %134), !noalias !204
  %136 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !204
  %137 = fptrunc float %mul445.5 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %136), !noalias !204
  %138 = bitcast half %135 to i16
  %139 = bitcast half %137 to i16
  %140 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !219
  %141 = fptrunc float %mul445.6 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %140), !noalias !219
  %142 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !219
  %143 = fptrunc float %mul445.7 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %142), !noalias !219
  %144 = bitcast half %141 to i16
  %145 = bitcast half %143 to i16
  %__2.sroa.6.0.insert.ext.1 = zext i16 %145 to i64
  %__2.sroa.6.0.insert.shift.1 = shl nuw i64 %__2.sroa.6.0.insert.ext.1, 48
  %__2.sroa.5.0.insert.ext.1 = zext i16 %144 to i64
  %__2.sroa.5.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.1, 32
  %__2.sroa.5.0.insert.insert.1 = or disjoint i64 %__2.sroa.6.0.insert.shift.1, %__2.sroa.5.0.insert.shift.1
  %__2.sroa.4.0.insert.ext.1 = zext i16 %139 to i64
  %__2.sroa.4.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.1, 16
  %__2.sroa.4.0.insert.insert.1 = or disjoint i64 %__2.sroa.5.0.insert.insert.1, %__2.sroa.4.0.insert.shift.1
  %__2.sroa.0.0.insert.ext.1 = zext i16 %138 to i64
  %__2.sroa.0.0.insert.insert.1 = or disjoint i64 %__2.sroa.4.0.insert.insert.1, %__2.sroa.0.0.insert.ext.1
  %146 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %121
  %add.ptr489.1 = getelementptr inbounds i8, ptr addrspace(1) %146, i64 32
  store i64 %__2.sroa.0.0.insert.insert.1, ptr addrspace(1) %add.ptr489.1, align 8
  %147 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !204
  %148 = fptrunc float %mul445.8 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %147), !noalias !204
  %149 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !204
  %150 = fptrunc float %mul445.9 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %149), !noalias !204
  %151 = bitcast half %148 to i16
  %152 = bitcast half %150 to i16
  %153 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !219
  %154 = fptrunc float %mul445.10 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %153), !noalias !219
  %155 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !219
  %156 = fptrunc float %mul445.11 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %155), !noalias !219
  %157 = bitcast half %154 to i16
  %158 = bitcast half %156 to i16
  %__2.sroa.6.0.insert.ext.2 = zext i16 %158 to i64
  %__2.sroa.6.0.insert.shift.2 = shl nuw i64 %__2.sroa.6.0.insert.ext.2, 48
  %__2.sroa.5.0.insert.ext.2 = zext i16 %157 to i64
  %__2.sroa.5.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.2, 32
  %__2.sroa.5.0.insert.insert.2 = or disjoint i64 %__2.sroa.6.0.insert.shift.2, %__2.sroa.5.0.insert.shift.2
  %__2.sroa.4.0.insert.ext.2 = zext i16 %152 to i64
  %__2.sroa.4.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.2, 16
  %__2.sroa.4.0.insert.insert.2 = or disjoint i64 %__2.sroa.5.0.insert.insert.2, %__2.sroa.4.0.insert.shift.2
  %__2.sroa.0.0.insert.ext.2 = zext i16 %151 to i64
  %__2.sroa.0.0.insert.insert.2 = or disjoint i64 %__2.sroa.4.0.insert.insert.2, %__2.sroa.0.0.insert.ext.2
  %159 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %121
  %add.ptr489.2 = getelementptr inbounds i8, ptr addrspace(1) %159, i64 64
  store i64 %__2.sroa.0.0.insert.insert.2, ptr addrspace(1) %add.ptr489.2, align 8
  %160 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !204
  %161 = fptrunc float %mul445.12 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %160), !noalias !204
  %162 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !204
  %163 = fptrunc float %mul445.13 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %162), !noalias !204
  %164 = bitcast half %161 to i16
  %165 = bitcast half %163 to i16
  %166 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !219
  %167 = fptrunc float %mul445.14 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %166), !noalias !219
  %168 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !219
  %169 = fptrunc float %mul445.15 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %168), !noalias !219
  %170 = bitcast half %167 to i16
  %171 = bitcast half %169 to i16
  %__2.sroa.6.0.insert.ext.3 = zext i16 %171 to i64
  %__2.sroa.6.0.insert.shift.3 = shl nuw i64 %__2.sroa.6.0.insert.ext.3, 48
  %__2.sroa.5.0.insert.ext.3 = zext i16 %170 to i64
  %__2.sroa.5.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.3, 32
  %__2.sroa.5.0.insert.insert.3 = or disjoint i64 %__2.sroa.6.0.insert.shift.3, %__2.sroa.5.0.insert.shift.3
  %__2.sroa.4.0.insert.ext.3 = zext i16 %165 to i64
  %__2.sroa.4.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.3, 16
  %__2.sroa.4.0.insert.insert.3 = or disjoint i64 %__2.sroa.5.0.insert.insert.3, %__2.sroa.4.0.insert.shift.3
  %__2.sroa.0.0.insert.ext.3 = zext i16 %164 to i64
  %__2.sroa.0.0.insert.insert.3 = or disjoint i64 %__2.sroa.4.0.insert.insert.3, %__2.sroa.0.0.insert.ext.3
  %172 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %121
  %add.ptr489.3 = getelementptr inbounds i8, ptr addrspace(1) %172, i64 96
  store i64 %__2.sroa.0.0.insert.insert.3, ptr addrspace(1) %add.ptr489.3, align 8
  call void @llvm.lifetime.end.p5(i64 16, ptr addrspace(5) %indices) #11
  ret void
}

declare void @llvm.lifetime.start.p5(i64 immarg, ptr addrspace(5) nocapture) #4

declare void @llvm.lifetime.end.p5(i64 immarg, ptr addrspace(5) nocapture) #4

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #5

declare i32 @llvm.mxc.block.id.x() #6

declare i32 @llvm.mxc.block.id.y() #6

declare i32 @llvm.mxc.block.id.z() #6

declare i32 @llvm.mxc.thread.id.x() #6

declare void @llvm.mxc.barrier() #7

declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #5

declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #5

declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #5

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #6

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #6

declare i1 @llvm.mxc.is.private(ptr nocapture) #6

declare void @llvm.mxc.sleep(i32 immarg) #8

declare float @llvm.exp2.f32(float) #9

declare i32 @llvm.mxc.gethwreg(i32 immarg) #10

declare void @llvm.mxc.sethwreg(i32 immarg, i32) #8

declare float @llvm.minnum.f32(float, float) #9

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #5 = { convergent nounwind willreturn memory(none) }
attributes #6 = { nounwind speculatable willreturn memory(none) }
attributes #7 = { convergent nounwind willreturn }
attributes #8 = { nounwind willreturn }
attributes #9 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #10 = { nounwind speculatable willreturn memory(inaccessiblemem: read) }
attributes #11 = { nounwind }
attributes #12 = { nomerge }


