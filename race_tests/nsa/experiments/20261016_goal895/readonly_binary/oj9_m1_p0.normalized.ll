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

define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %BlockIndices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K_blocks.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V_blocks.coerce) local_unnamed_addr #3 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul = shl nsw i32 %0, 10
  %1 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %mul8 = shl nuw nsw i32 %1, 3
  %add = add nuw nsw i32 %mul8, %mul
  %2 = zext nneg i32 %add to i64
  %3 = add nuw nsw i64 %2, 512
  %idxprom = zext nneg i32 %0 to i64
  %arrayidx14 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom
  %arrayidx14.val = load i32, ptr addrspace(1) %arrayidx14, align 4, !tbaa !30
  %or.cond = icmp ugt i32 %arrayidx14.val, 511
  %.pre = lshr i32 %0, 4
  %cmp33.not = icmp ugt i32 %arrayidx14.val, %.pre
  %or.cond805 = or i1 %or.cond, %cmp33.not
  br i1 %or.cond805, label %if.end328, label %for.cond36.preheader

for.cond36.preheader:                             ; preds = %entry
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %2
  %mul45 = shl nuw nsw i32 %arrayidx14.val, 10
  %add47 = add nuw nsw i32 %mul45, %mul8
  %4 = zext nneg i32 %add47 to i64
  %add.ptr54 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %4
  %5 = load i32, ptr addrspace(4) %add.ptr54, align 4, !tbaa !30
  %6 = or disjoint i64 %4, 2
  %add.ptr54.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %6
  %7 = load i32, ptr addrspace(4) %add.ptr54.1, align 4, !tbaa !30
  %8 = or disjoint i64 %4, 4
  %add.ptr54.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %8
  %9 = load i32, ptr addrspace(4) %add.ptr54.2, align 4, !tbaa !30
  %10 = or disjoint i64 %4, 6
  %add.ptr54.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %10
  %11 = load i32, ptr addrspace(4) %add.ptr54.3, align 4, !tbaa !30
  %12 = add nuw nsw i64 %4, 512
  %add.ptr54.1646 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %12
  %13 = load i32, ptr addrspace(4) %add.ptr54.1646, align 4, !tbaa !30
  %14 = add nuw nsw i64 %4, 514
  %add.ptr54.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %14
  %15 = load i32, ptr addrspace(4) %add.ptr54.1.1, align 4, !tbaa !30
  %16 = add nuw nsw i64 %4, 516
  %add.ptr54.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %16
  %17 = load i32, ptr addrspace(4) %add.ptr54.2.1, align 4, !tbaa !30
  %18 = add nuw nsw i64 %4, 518
  %add.ptr54.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %18
  %19 = load i32, ptr addrspace(4) %add.ptr54.3.1, align 4, !tbaa !30
  %add.ptr84 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %4
  %20 = load i32, ptr addrspace(4) %add.ptr84, align 4, !tbaa !30
  %add.ptr84.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %6
  %21 = load i32, ptr addrspace(4) %add.ptr84.1, align 4, !tbaa !30
  %add.ptr84.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %8
  %22 = load i32, ptr addrspace(4) %add.ptr84.2, align 4, !tbaa !30
  %add.ptr84.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %10
  %23 = load i32, ptr addrspace(4) %add.ptr84.3, align 4, !tbaa !30
  %add.ptr84.1658 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %12
  %24 = load i32, ptr addrspace(4) %add.ptr84.1658, align 4, !tbaa !30
  %add.ptr84.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %14
  %25 = load i32, ptr addrspace(4) %add.ptr84.1.1, align 4, !tbaa !30
  %add.ptr84.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %16
  %26 = load i32, ptr addrspace(4) %add.ptr84.2.1, align 4, !tbaa !30
  %add.ptr84.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %18
  %27 = load i32, ptr addrspace(4) %add.ptr84.3.1, align 4, !tbaa !30
  %mul108 = and i32 %mul8, 8128
  %xor587 = and i32 %mul8, 56
  %call111.masked = and i32 %1, 1016
  %mul113 = xor i32 %xor587, %call111.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul108
  %invariant.gep598 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul113
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep598, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !57
  %gep599.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep598, i32 1024
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep599.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !call_argsrelate !57
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and125 = shl nuw nsw i32 %1, 6
  %mul126 = and i32 %and125, 960
  %shr129 = lshr i32 %1, 4
  %and132 = and i32 %1, 7
  %28 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul126
  %xor133 = xor i32 %shr129, %and132
  %add.ptr137.idx = shl nuw nsw i32 %xor133, 4
  %add.ptr137 = getelementptr inbounds i8, ptr addrspace(3) %28, i32 %add.ptr137.idx
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr137, align 16
  %Q_reg.sroa.4.0.add.ptr137.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr137, i32 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr137.sroa_idx, align 8
  %add130.1 = add nuw nsw i32 %shr129, 4
  %xor133.1 = xor i32 %add130.1, %and132
  %add.ptr137.idx.1 = shl nuw nsw i32 %xor133.1, 4
  %add.ptr137.1 = getelementptr inbounds i8, ptr addrspace(3) %28, i32 %add.ptr137.idx.1
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr137.1, align 16
  %Q_reg.sroa.7.16.add.ptr137.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr137.1, i32 8
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr137.1.sroa_idx, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  store i32 %5, ptr addrspace(3) %invariant.gep598, align 16, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep603.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep598, i32 4
  store i32 %7, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep603.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep603.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep598, i32 8
  store i32 %9, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep603.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep603.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep598, i32 12
  store i32 %11, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep603.sroa_idx, align 4, !tbaa !30
  store i32 %13, ptr addrspace(3) %gep599.1, align 16, !tbaa !30
  %K_reg.sroa.9.16.gep604.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep598, i32 1028
  store i32 %15, ptr addrspace(3) %K_reg.sroa.9.16.gep604.1.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.10.16.gep604.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep598, i32 1032
  store i32 %17, ptr addrspace(3) %K_reg.sroa.10.16.gep604.1.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.11.16.gep604.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep598, i32 1036
  store i32 %19, ptr addrspace(3) %K_reg.sroa.11.16.gep604.1.sroa_idx, align 4, !tbaa !30
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr137, align 16
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr137.sroa_idx, align 8
  %29 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer)
  %30 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %29)
  %kb.sroa.0.0.copyload688 = load <4 x half>, ptr addrspace(3) %add.ptr137.1, align 16
  %kb.sroa.6.0.copyload689 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr137.1.sroa_idx, align 8
  %31 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload688, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %30)
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload689, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %31)
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add.ptr229.idx = shl nuw nsw i32 %1, 4
  %invariant.gep611 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr229.idx
  store i32 %20, ptr addrspace(3) %invariant.gep611, align 16, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep611.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep611, i32 4
  store i32 %21, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep611.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep611.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep611, i32 8
  store i32 %22, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep611.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep611.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep611, i32 12
  store i32 %23, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep611.sroa_idx, align 4, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep611, i32 1024
  store i32 %24, ptr addrspace(3) %gep.1, align 16, !tbaa !30
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep611, i32 1028
  store i32 %25, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep611, i32 1032
  store i32 %26, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep611, i32 1036
  store i32 %27, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !tbaa !30
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %32, i64 0
  %mul239 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %33 = tail call contract noundef float @llvm.minnum.f32(float %mul239, float 0x4024CB5EC0000000)
  %34 = tail call contract noundef float @llvm.exp.f32(float %33)
  %acc_s.sroa.0.0.vec.insert695 = insertelement <4 x float> poison, float %34, i64 0
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %32, i64 1
  %mul239.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %35 = tail call contract noundef float @llvm.minnum.f32(float %mul239.1, float 0x4024CB5EC0000000)
  %36 = tail call contract noundef float @llvm.exp.f32(float %35)
  %acc_s.sroa.0.4.vec.insert710 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert695, float %36, i64 1
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %32, i64 2
  %mul239.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %37 = tail call contract noundef float @llvm.minnum.f32(float %mul239.2, float 0x4024CB5EC0000000)
  %38 = tail call contract noundef float @llvm.exp.f32(float %37)
  %acc_s.sroa.0.8.vec.insert725 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert710, float %38, i64 2
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %32, i64 3
  %mul239.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %39 = tail call contract noundef float @llvm.minnum.f32(float %mul239.3, float 0x4024CB5EC0000000)
  %40 = tail call contract noundef float @llvm.exp.f32(float %39)
  %acc_s.sroa.0.12.vec.insert740 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert725, float %40, i64 3
  %cmp249 = icmp eq i32 %arrayidx14.val, %.pre
  br i1 %cmp249, label %for.cond251.preheader, label %if.end270

for.cond251.preheader:                            ; preds = %for.cond36.preheader
  %41 = lshr i32 %1, 2
  %mul257 = and i32 %41, 252
  %and260 = and i32 %0, 15
  %cmp261.not = icmp ugt i32 %mul257, %and260
  %spec.select = select i1 %cmp261.not, float 0.000000e+00, float %34
  %acc_s.sroa.0.0.vec.insert699 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp261.not.1.not = icmp ult i32 %mul257, %and260
  %condval.0.1 = select i1 %cmp261.not.1.not, float %36, float 0.000000e+00
  %acc_s.sroa.0.4.vec.insert714 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert699, float %condval.0.1, i64 1
  %add258.2 = or disjoint i32 %mul257, 2
  %cmp261.not.2 = icmp ugt i32 %add258.2, %and260
  %condval.0.2 = select i1 %cmp261.not.2, float 0.000000e+00, float %38
  %acc_s.sroa.0.8.vec.insert729 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert714, float %condval.0.2, i64 2
  %add258.3 = or i32 %41, 3
  %cmp261.not.3 = icmp ugt i32 %add258.3, %and260
  %condval.0.3 = select i1 %cmp261.not.3, float 0.000000e+00, float %40
  %acc_s.sroa.0.12.vec.insert744 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert729, float %condval.0.3, i64 3
  br label %if.end270

if.end270:                                        ; preds = %for.cond251.preheader, %for.cond36.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert744, %for.cond251.preheader ], [ %acc_s.sroa.0.12.vec.insert740, %for.cond36.preheader ]
  %acc_s.sroa.0.0.vec.extract701 = extractelement <4 x float> %acc_s.sroa.0.0, i64 0
  %add279 = fadd contract float %acc_s.sroa.0.0.vec.extract701, 0.000000e+00
  %acc_s.sroa.0.4.vec.extract716 = extractelement <4 x float> %acc_s.sroa.0.0, i64 1
  %add279.1 = fadd contract float %add279, %acc_s.sroa.0.4.vec.extract716
  %acc_s.sroa.0.8.vec.extract731 = extractelement <4 x float> %acc_s.sroa.0.0, i64 2
  %add279.2 = fadd contract float %add279.1, %acc_s.sroa.0.8.vec.extract731
  %acc_s.sroa.0.12.vec.extract746 = extractelement <4 x float> %acc_s.sroa.0.0, i64 3
  %add279.3 = fadd contract float %add279.2, %acc_s.sroa.0.12.vec.extract746
  %42 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add279.3, <4 x float> zeroinitializer)
  %wsum_output.sroa.0.0.vec.extract = extractelement <4 x float> %42, i64 0
  %cmp297 = fcmp contract ogt float %wsum_output.sroa.0.0.vec.extract, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %wsum_output.sroa.0.0.vec.extract
  %condval_1.0 = select i1 %cmp297, float %div, float 0.000000e+00
  %mul310 = fmul contract float %condval_1.0, %acc_s.sroa.0.0.vec.extract701
  %acc_s.sroa.0.4.vec.extract718 = extractelement <4 x float> %acc_s.sroa.0.0, i64 1
  %mul310.1 = fmul contract float %condval_1.0, %acc_s.sroa.0.4.vec.extract718
  %acc_s.sroa.0.8.vec.extract733 = extractelement <4 x float> %acc_s.sroa.0.0, i64 2
  %mul310.2 = fmul contract float %condval_1.0, %acc_s.sroa.0.8.vec.extract733
  %acc_s.sroa.0.12.vec.extract748 = extractelement <4 x float> %acc_s.sroa.0.0, i64 3
  %mul310.3 = fmul contract float %condval_1.0, %acc_s.sroa.0.12.vec.extract748
  %43 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul310)
  %44 = insertelement <4 x i16> poison, i16 %43, i64 0
  %45 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul310.1)
  %46 = insertelement <4 x i16> %44, i16 %45, i64 1
  %47 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul310.2)
  %48 = insertelement <4 x i16> %46, i16 %47, i64 2
  %49 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul310.3)
  %50 = insertelement <4 x i16> %48, i16 %49, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %50 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end328

if.end328:                                        ; preds = %entry, %if.end270
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ %acc_s_cast.sroa.0.6.vec.insert, %if.end270 ], [ undef, %entry ]
  %cmp348.not = icmp ugt i32 %arrayidx14.val, %.pre
  %or.cond631 = or i1 %or.cond, %cmp348.not
  br i1 %or.cond631, label %if.end398, label %for.cond350.preheader

for.cond350.preheader:                            ; preds = %if.end328
  %51 = shl nuw nsw i32 %1, 4
  %mul360 = and i32 %51, 16128
  %and366 = and i32 %1, 15
  %add367 = or disjoint i32 %mul360, %and366
  %arrayidx369 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add367
  %52 = load half, ptr addrspace(3) %arrayidx369, align 2, !tbaa !138
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %52, i64 0
  %add362.1 = or disjoint i32 %mul360, %and366
  %add367.1 = or disjoint i32 %add362.1, 64
  %arrayidx369.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add367.1
  %53 = load half, ptr addrspace(3) %arrayidx369.1, align 2, !tbaa !138
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %53, i64 1
  %add362.2 = or disjoint i32 %mul360, %and366
  %add367.2 = or disjoint i32 %add362.2, 128
  %arrayidx369.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add367.2
  %54 = load half, ptr addrspace(3) %arrayidx369.2, align 2, !tbaa !138
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %54, i64 2
  %add362.3 = or disjoint i32 %mul360, %and366
  %add367.3 = or disjoint i32 %add362.3, 192
  %arrayidx369.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add367.3
  %55 = load half, ptr addrspace(3) %arrayidx369.3, align 2, !tbaa !138
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %55, i64 3
  %add364.1662 = or disjoint i32 %mul360, %and366
  %add367.1663 = or disjoint i32 %add364.1662, 16
  %arrayidx369.1664 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add367.1663
  %56 = load half, ptr addrspace(3) %arrayidx369.1664, align 2, !tbaa !138
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %56, i64 0
  %add364.1.1 = or disjoint i32 %mul360, %and366
  %add367.1.1 = or disjoint i32 %add364.1.1, 80
  %arrayidx369.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add367.1.1
  %57 = load half, ptr addrspace(3) %arrayidx369.1.1, align 2, !tbaa !138
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %57, i64 1
  %add364.2.1 = or disjoint i32 %mul360, %and366
  %add367.2.1 = or disjoint i32 %add364.2.1, 144
  %arrayidx369.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add367.2.1
  %58 = load half, ptr addrspace(3) %arrayidx369.2.1, align 2, !tbaa !138
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %58, i64 2
  %add364.3.1 = or disjoint i32 %mul360, %and366
  %add367.3.1 = or disjoint i32 %add364.3.1, 208
  %arrayidx369.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add367.3.1
  %59 = load half, ptr addrspace(3) %arrayidx369.3.1, align 2, !tbaa !138
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %59, i64 3
  %add364.2666 = or disjoint i32 %mul360, %and366
  %add367.2667 = or disjoint i32 %add364.2666, 32
  %arrayidx369.2668 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add367.2667
  %60 = load half, ptr addrspace(3) %arrayidx369.2668, align 2, !tbaa !138
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %60, i64 0
  %add364.1.2 = or disjoint i32 %mul360, %and366
  %add367.1.2 = or disjoint i32 %add364.1.2, 96
  %arrayidx369.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add367.1.2
  %61 = load half, ptr addrspace(3) %arrayidx369.1.2, align 2, !tbaa !138
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %61, i64 1
  %add364.2.2 = or disjoint i32 %mul360, %and366
  %add367.2.2 = or disjoint i32 %add364.2.2, 160
  %arrayidx369.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add367.2.2
  %62 = load half, ptr addrspace(3) %arrayidx369.2.2, align 2, !tbaa !138
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %62, i64 2
  %add364.3.2 = or disjoint i32 %mul360, %and366
  %add367.3.2 = or disjoint i32 %add364.3.2, 224
  %arrayidx369.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add367.3.2
  %63 = load half, ptr addrspace(3) %arrayidx369.3.2, align 2, !tbaa !138
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %63, i64 3
  %add364.3670 = or disjoint i32 %mul360, %and366
  %add367.3671 = or disjoint i32 %add364.3670, 48
  %arrayidx369.3672 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add367.3671
  %64 = load half, ptr addrspace(3) %arrayidx369.3672, align 2, !tbaa !138
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %64, i64 0
  %add364.1.3 = or disjoint i32 %mul360, %and366
  %add367.1.3 = or disjoint i32 %add364.1.3, 112
  %arrayidx369.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add367.1.3
  %65 = load half, ptr addrspace(3) %arrayidx369.1.3, align 2, !tbaa !138
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %65, i64 1
  %add364.2.3 = or disjoint i32 %mul360, %and366
  %add367.2.3 = or disjoint i32 %add364.2.3, 176
  %arrayidx369.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add367.2.3
  %66 = load half, ptr addrspace(3) %arrayidx369.2.3, align 2, !tbaa !138
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %66, i64 2
  %add364.3.3 = or disjoint i32 %51, %and366
  %add367.3.3 = or i32 %add364.3.3, 240
  %arrayidx369.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add367.3.3
  %67 = load half, ptr addrspace(3) %arrayidx369.3.3, align 2, !tbaa !138
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %67, i64 3
  %68 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %70 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  br label %if.end398

if.end398:                                        ; preds = %for.cond350.preheader, %if.end328
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end328 ], [ %68, %for.cond350.preheader ]
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end328 ], [ %69, %for.cond350.preheader ]
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end328 ], [ %70, %for.cond350.preheader ]
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end328 ], [ %71, %for.cond350.preheader ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0
  %72 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract)
  %O_reg.sroa.0.0.insert.ext = zext i16 %72 to i64
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1
  %73 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract)
  %O_reg.sroa.0.2.insert.ext = zext i16 %73 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2
  %74 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract)
  %O_reg.sroa.0.4.insert.ext = zext i16 %74 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3
  %75 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract)
  %O_reg.sroa.0.6.insert.ext = zext i16 %75 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0
  %76 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract)
  %O_reg.sroa.7.8.insert.ext = zext i16 %76 to i64
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1
  %77 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract)
  %O_reg.sroa.7.10.insert.ext = zext i16 %77 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract)
  %O_reg.sroa.7.12.insert.ext = zext i16 %78 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract)
  %O_reg.sroa.7.14.insert.ext = zext i16 %79 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract)
  %O_reg.sroa.12.16.insert.ext = zext i16 %80 to i64
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract)
  %O_reg.sroa.12.18.insert.ext = zext i16 %81 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract)
  %O_reg.sroa.12.20.insert.ext = zext i16 %82 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract)
  %O_reg.sroa.12.22.insert.ext = zext i16 %83 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract)
  %O_reg.sroa.17.24.insert.ext = zext i16 %84 to i64
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract)
  %O_reg.sroa.17.26.insert.ext = zext i16 %85 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract)
  %O_reg.sroa.17.28.insert.ext = zext i16 %86 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract)
  %O_reg.sroa.17.30.insert.ext = zext i16 %87 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and431 = shl nuw nsw i32 %1, 6
  %mul432 = and i32 %and431, 960
  %shr435 = lshr i32 %1, 5
  %and438 = and i32 %1, 7
  %88 = lshr i32 %1, 2
  %mul445 = and i32 %88, 4
  %xor439 = xor i32 %shr435, %and438
  %mul440 = shl nuw nsw i32 %xor439, 3
  %add441 = add nuw nsw i32 %mul440, %mul432
  %add446 = or disjoint i32 %add441, %mul445
  %add.ptr448 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add446
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr448, align 8
  %add436.1 = add nuw nsw i32 %shr435, 2
  %xor439.1 = xor i32 %add436.1, %and438
  %mul440.1 = shl nuw nsw i32 %xor439.1, 3
  %add441.1 = add nuw nsw i32 %mul440.1, %mul432
  %add446.1 = or disjoint i32 %add441.1, %mul445
  %add.ptr448.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add446.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr448.1, align 8
  %add436.2 = add nuw nsw i32 %shr435, 4
  %xor439.2 = xor i32 %add436.2, %and438
  %mul440.2 = shl nuw nsw i32 %xor439.2, 3
  %add441.2 = add nuw nsw i32 %mul440.2, %mul432
  %add446.2 = or disjoint i32 %add441.2, %mul445
  %add.ptr448.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add446.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr448.2, align 8
  %add436.3 = add nuw nsw i32 %shr435, 6
  %xor439.3 = xor i32 %add436.3, %and438
  %mul440.3 = shl nuw nsw i32 %xor439.3, 3
  %add441.3 = add nuw nsw i32 %mul440.3, %mul432
  %add446.3 = or disjoint i32 %add441.3, %mul445
  %add.ptr448.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add446.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr448.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul459 = and i32 %mul8, 8128
  %xor465583 = and i32 %mul8, 56
  %call463.masked = and i32 %1, 1016
  %mul466 = xor i32 %xor465583, %call463.masked
  %invariant.gep626 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul459
  %invariant.gep628 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep626, i32 %mul466
  %add.ptr478 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %2
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr478, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep628, i64 16, i1 false), !tbaa.struct !167, !call_argsrelate !168
  %gep629.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep628, i32 1024
  %add.ptr478.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr478.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep629.1, i64 16, i1 false), !tbaa.struct !167, !call_argsrelate !168
  ret void
}

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

declare <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float, float, <4 x float>) #4

declare i32 @llvm.mxc.block.id.x() #5

declare i32 @llvm.mxc.block.id.y() #5

declare i32 @llvm.mxc.block.id.z() #5

declare i32 @llvm.mxc.thread.id.x() #5

declare void @llvm.mxc.barrier.warp() #6

declare float @llvm.exp.f32(float) #7

declare i16 @llvm.convert.to.fp16.f32(float) #8

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

declare i1 @llvm.mxc.is.private(ptr nocapture) #5

declare void @llvm.mxc.sleep(i32 immarg) #9

declare float @llvm.minnum.f32(float, float) #7

declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #10

declare void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noalias nocapture writeonly, ptr addrspace(4) noalias nocapture readonly, i64, i1 immarg) #10

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { convergent nounwind willreturn }
attributes #7 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #8 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #9 = { nounwind willreturn }
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }


