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
  %4 = load i32, ptr addrspace(1) %arrayidx14, align 4, !tbaa !30
  %cmp29 = icmp ugt i32 %4, 511
  %shr = lshr i32 %0, 4
  %cmp32.not = icmp ugt i32 %4, %shr
  %or.cond = or i1 %cmp29, %cmp32.not
  br i1 %or.cond, label %if.end348, label %for.cond35.preheader

for.cond35.preheader:                             ; preds = %entry
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %2
  %mul49 = shl nuw nsw i32 %4, 10
  %add51 = add nuw nsw i32 %mul49, %mul8
  %5 = zext nneg i32 %add51 to i64
  %arrayidx59 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %5
  %6 = or disjoint i64 %5, 2
  %arrayidx59.1671 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %6
  %7 = or disjoint i64 %5, 4
  %arrayidx59.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %7
  %8 = or disjoint i64 %5, 6
  %arrayidx59.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %8
  %9 = add nuw nsw i64 %5, 512
  %arrayidx59.1678 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %9
  %10 = add nuw nsw i64 %5, 514
  %arrayidx59.1671.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %10
  %11 = add nuw nsw i64 %5, 516
  %arrayidx59.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %11
  %12 = add nuw nsw i64 %5, 518
  %arrayidx59.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %12
  %arrayidx99 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %5
  %arrayidx99.1692 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %6
  %arrayidx99.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %7
  %arrayidx99.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %8
  %arrayidx99.1699 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %9
  %arrayidx99.1692.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %10
  %arrayidx99.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %11
  %arrayidx99.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %12
  %mul128 = and i32 %mul8, 8128
  %xor613 = and i32 %mul8, 56
  %call131.masked = and i32 %1, 1016
  %mul133 = xor i32 %xor613, %call131.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul128
  %invariant.gep625 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul133
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep625, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !53
  %gep626.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep625, i32 1024
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep626.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !call_argsrelate !53
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and145 = shl nuw nsw i32 %1, 6
  %mul146 = and i32 %and145, 960
  %shr149 = lshr i32 %1, 4
  %and152 = and i32 %1, 7
  %13 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul146
  %xor153 = xor i32 %shr149, %and152
  %add.ptr157.idx = shl nuw nsw i32 %xor153, 4
  %add.ptr157 = getelementptr inbounds i8, ptr addrspace(3) %13, i32 %add.ptr157.idx
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr157, align 16
  %Q_reg.sroa.4.0.add.ptr157.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157, i32 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr157.sroa_idx, align 8
  %add150.1 = add nuw nsw i32 %shr149, 4
  %xor153.1 = xor i32 %add150.1, %and152
  %add.ptr157.idx.1 = shl nuw nsw i32 %xor153.1, 4
  %add.ptr157.1 = getelementptr inbounds i8, ptr addrspace(3) %13, i32 %add.ptr157.idx.1
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr157.1, align 16
  %Q_reg.sroa.7.16.add.ptr157.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.1, i32 8
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr157.1.sroa_idx, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %14 = load <2 x i16>, ptr addrspace(4) %arrayidx59, align 2, !tbaa !73
  store <2 x i16> %14, ptr addrspace(3) %invariant.gep625, align 16
  %K_reg.sroa.5.0.invariant.gep630.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep625, i32 4
  %15 = load <2 x i16>, ptr addrspace(4) %arrayidx59.1671, align 2, !tbaa !73
  store <2 x i16> %15, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep630.sroa_idx, align 4
  %K_reg.sroa.7.0.invariant.gep630.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep625, i32 8
  %16 = load <2 x i16>, ptr addrspace(4) %arrayidx59.2, align 2, !tbaa !73
  store <2 x i16> %16, ptr addrspace(3) %K_reg.sroa.7.0.invariant.gep630.sroa_idx, align 8
  %K_reg.sroa.9.0.invariant.gep630.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep625, i32 12
  %17 = load <2 x i16>, ptr addrspace(4) %arrayidx59.3, align 2, !tbaa !73
  store <2 x i16> %17, ptr addrspace(3) %K_reg.sroa.9.0.invariant.gep630.sroa_idx, align 4
  %18 = load <2 x i16>, ptr addrspace(4) %arrayidx59.1678, align 2, !tbaa !73
  store <2 x i16> %18, ptr addrspace(3) %gep626.1, align 16
  %K_reg.sroa.14.16.gep631.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep625, i32 1028
  %19 = load <2 x i16>, ptr addrspace(4) %arrayidx59.1671.1, align 2, !tbaa !73
  store <2 x i16> %19, ptr addrspace(3) %K_reg.sroa.14.16.gep631.1.sroa_idx, align 4
  %K_reg.sroa.16.16.gep631.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep625, i32 1032
  %20 = load <2 x i16>, ptr addrspace(4) %arrayidx59.2.1, align 2, !tbaa !73
  store <2 x i16> %20, ptr addrspace(3) %K_reg.sroa.16.16.gep631.1.sroa_idx, align 8
  %K_reg.sroa.18.16.gep631.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep625, i32 1036
  %21 = load <2 x i16>, ptr addrspace(4) %arrayidx59.3.1, align 2, !tbaa !73
  store <2 x i16> %21, ptr addrspace(3) %K_reg.sroa.18.16.gep631.1.sroa_idx, align 4
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr157, align 16
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr157.sroa_idx, align 8
  %22 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer)
  %23 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %22)
  %kb.sroa.0.0.copyload734 = load <4 x half>, ptr addrspace(3) %add.ptr157.1, align 16
  %kb.sroa.6.0.copyload735 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr157.1.sroa_idx, align 8
  %24 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload734, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %23)
  %25 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload735, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %24)
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add.ptr249.idx = shl nuw nsw i32 %1, 4
  %invariant.gep638 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr249.idx
  %26 = load <2 x i16>, ptr addrspace(4) %arrayidx99, align 2, !tbaa !73
  store <2 x i16> %26, ptr addrspace(3) %invariant.gep638, align 16
  %V_reg.sroa.5.0.invariant.gep638.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep638, i32 4
  %27 = load <2 x i16>, ptr addrspace(4) %arrayidx99.1692, align 2, !tbaa !73
  store <2 x i16> %27, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep638.sroa_idx, align 4
  %V_reg.sroa.7.0.invariant.gep638.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep638, i32 8
  %28 = load <2 x i16>, ptr addrspace(4) %arrayidx99.2, align 2, !tbaa !73
  store <2 x i16> %28, ptr addrspace(3) %V_reg.sroa.7.0.invariant.gep638.sroa_idx, align 8
  %V_reg.sroa.9.0.invariant.gep638.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep638, i32 12
  %29 = load <2 x i16>, ptr addrspace(4) %arrayidx99.3, align 2, !tbaa !73
  store <2 x i16> %29, ptr addrspace(3) %V_reg.sroa.9.0.invariant.gep638.sroa_idx, align 4
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep638, i32 1024
  %30 = load <2 x i16>, ptr addrspace(4) %arrayidx99.1699, align 2, !tbaa !73
  store <2 x i16> %30, ptr addrspace(3) %gep.1, align 16
  %V_reg.sroa.14.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep638, i32 1028
  %31 = load <2 x i16>, ptr addrspace(4) %arrayidx99.1692.1, align 2, !tbaa !73
  store <2 x i16> %31, ptr addrspace(3) %V_reg.sroa.14.16.gep.1.sroa_idx, align 4
  %V_reg.sroa.16.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep638, i32 1032
  %32 = load <2 x i16>, ptr addrspace(4) %arrayidx99.2.1, align 2, !tbaa !73
  store <2 x i16> %32, ptr addrspace(3) %V_reg.sroa.16.16.gep.1.sroa_idx, align 8
  %V_reg.sroa.18.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep638, i32 1036
  %33 = load <2 x i16>, ptr addrspace(4) %arrayidx99.3.1, align 2, !tbaa !73
  store <2 x i16> %33, ptr addrspace(3) %V_reg.sroa.18.16.gep.1.sroa_idx, align 4
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %25, i64 0
  %mul259 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %34 = tail call contract noundef float @llvm.minnum.f32(float %mul259, float 0x4024CB5EC0000000)
  %35 = tail call contract noundef float @llvm.exp.f32(float %34)
  %acc_s.sroa.0.0.vec.insert741 = insertelement <4 x float> poison, float %35, i64 0
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %25, i64 1
  %mul259.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %36 = tail call contract noundef float @llvm.minnum.f32(float %mul259.1, float 0x4024CB5EC0000000)
  %37 = tail call contract noundef float @llvm.exp.f32(float %36)
  %acc_s.sroa.0.4.vec.insert756 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert741, float %37, i64 1
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %25, i64 2
  %mul259.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %38 = tail call contract noundef float @llvm.minnum.f32(float %mul259.2, float 0x4024CB5EC0000000)
  %39 = tail call contract noundef float @llvm.exp.f32(float %38)
  %acc_s.sroa.0.8.vec.insert771 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert756, float %39, i64 2
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %25, i64 3
  %mul259.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul259.3, float 0x4024CB5EC0000000)
  %41 = tail call contract noundef float @llvm.exp.f32(float %40)
  %acc_s.sroa.0.12.vec.insert786 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert771, float %41, i64 3
  %cmp269 = icmp eq i32 %4, %shr
  br i1 %cmp269, label %for.cond271.preheader, label %if.end290

for.cond271.preheader:                            ; preds = %for.cond35.preheader
  %42 = lshr i32 %1, 2
  %mul277 = and i32 %42, 252
  %and280 = and i32 %0, 15
  %cmp281.not = icmp ugt i32 %mul277, %and280
  %spec.select = select i1 %cmp281.not, float 0.000000e+00, float %35
  %acc_s.sroa.0.0.vec.insert745 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp281.not.1.not = icmp ult i32 %mul277, %and280
  %condval.0.1 = select i1 %cmp281.not.1.not, float %37, float 0.000000e+00
  %acc_s.sroa.0.4.vec.insert760 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert745, float %condval.0.1, i64 1
  %add278.2 = or disjoint i32 %mul277, 2
  %cmp281.not.2 = icmp ugt i32 %add278.2, %and280
  %condval.0.2 = select i1 %cmp281.not.2, float 0.000000e+00, float %39
  %acc_s.sroa.0.8.vec.insert775 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert760, float %condval.0.2, i64 2
  %add278.3 = or i32 %42, 3
  %cmp281.not.3 = icmp ugt i32 %add278.3, %and280
  %condval.0.3 = select i1 %cmp281.not.3, float 0.000000e+00, float %41
  %acc_s.sroa.0.12.vec.insert790 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert775, float %condval.0.3, i64 3
  br label %if.end290

if.end290:                                        ; preds = %for.cond271.preheader, %for.cond35.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert790, %for.cond271.preheader ], [ %acc_s.sroa.0.12.vec.insert786, %for.cond35.preheader ]
  %acc_s.sroa.0.0.vec.extract747 = extractelement <4 x float> %acc_s.sroa.0.0, i64 0
  %add299 = fadd contract float %acc_s.sroa.0.0.vec.extract747, 0.000000e+00
  %acc_s.sroa.0.4.vec.extract762 = extractelement <4 x float> %acc_s.sroa.0.0, i64 1
  %add299.1 = fadd contract float %add299, %acc_s.sroa.0.4.vec.extract762
  %acc_s.sroa.0.8.vec.extract777 = extractelement <4 x float> %acc_s.sroa.0.0, i64 2
  %add299.2 = fadd contract float %add299.1, %acc_s.sroa.0.8.vec.extract777
  %acc_s.sroa.0.12.vec.extract792 = extractelement <4 x float> %acc_s.sroa.0.0, i64 3
  %add299.3 = fadd contract float %add299.2, %acc_s.sroa.0.12.vec.extract792
  %43 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add299.3, <4 x float> zeroinitializer)
  %wsum_output.sroa.0.0.vec.extract = extractelement <4 x float> %43, i64 0
  %cmp317 = fcmp contract ogt float %wsum_output.sroa.0.0.vec.extract, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %wsum_output.sroa.0.0.vec.extract
  %condval_1.0 = select i1 %cmp317, float %div, float 0.000000e+00
  %mul330 = fmul contract float %condval_1.0, %acc_s.sroa.0.0.vec.extract747
  %acc_s.sroa.0.4.vec.extract764 = extractelement <4 x float> %acc_s.sroa.0.0, i64 1
  %mul330.1 = fmul contract float %condval_1.0, %acc_s.sroa.0.4.vec.extract764
  %acc_s.sroa.0.8.vec.extract779 = extractelement <4 x float> %acc_s.sroa.0.0, i64 2
  %mul330.2 = fmul contract float %condval_1.0, %acc_s.sroa.0.8.vec.extract779
  %acc_s.sroa.0.12.vec.extract794 = extractelement <4 x float> %acc_s.sroa.0.0, i64 3
  %mul330.3 = fmul contract float %condval_1.0, %acc_s.sroa.0.12.vec.extract794
  %44 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul330)
  %45 = insertelement <4 x i16> poison, i16 %44, i64 0
  %46 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul330.1)
  %47 = insertelement <4 x i16> %45, i16 %46, i64 1
  %48 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul330.2)
  %49 = insertelement <4 x i16> %47, i16 %48, i64 2
  %50 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul330.3)
  %51 = insertelement <4 x i16> %49, i16 %50, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %51 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end348

if.end348:                                        ; preds = %entry, %if.end290
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ %acc_s_cast.sroa.0.6.vec.insert, %if.end290 ], [ undef, %entry ]
  %cmp364 = icmp ugt i32 %4, 511
  %cmp368.not = icmp ugt i32 %4, %shr
  %or.cond659 = or i1 %cmp364, %cmp368.not
  br i1 %or.cond659, label %if.end418, label %for.cond370.preheader

for.cond370.preheader:                            ; preds = %if.end348
  %52 = shl nuw nsw i32 %1, 4
  %mul380 = and i32 %52, 16128
  %and386 = and i32 %1, 15
  %add387 = or disjoint i32 %mul380, %and386
  %arrayidx389 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387
  %53 = load half, ptr addrspace(3) %arrayidx389, align 2, !tbaa !73
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %53, i64 0
  %add382.1 = or disjoint i32 %mul380, %and386
  %add387.1 = or disjoint i32 %add382.1, 64
  %arrayidx389.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387.1
  %54 = load half, ptr addrspace(3) %arrayidx389.1, align 2, !tbaa !73
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %54, i64 1
  %add382.2 = or disjoint i32 %mul380, %and386
  %add387.2 = or disjoint i32 %add382.2, 128
  %arrayidx389.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387.2
  %55 = load half, ptr addrspace(3) %arrayidx389.2, align 2, !tbaa !73
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %55, i64 2
  %add382.3 = or disjoint i32 %mul380, %and386
  %add387.3 = or disjoint i32 %add382.3, 192
  %arrayidx389.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387.3
  %56 = load half, ptr addrspace(3) %arrayidx389.3, align 2, !tbaa !73
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %56, i64 3
  %add384.1708 = or disjoint i32 %mul380, %and386
  %add387.1709 = or disjoint i32 %add384.1708, 16
  %arrayidx389.1710 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387.1709
  %57 = load half, ptr addrspace(3) %arrayidx389.1710, align 2, !tbaa !73
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %57, i64 0
  %add384.1.1 = or disjoint i32 %mul380, %and386
  %add387.1.1 = or disjoint i32 %add384.1.1, 80
  %arrayidx389.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387.1.1
  %58 = load half, ptr addrspace(3) %arrayidx389.1.1, align 2, !tbaa !73
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %58, i64 1
  %add384.2.1 = or disjoint i32 %mul380, %and386
  %add387.2.1 = or disjoint i32 %add384.2.1, 144
  %arrayidx389.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387.2.1
  %59 = load half, ptr addrspace(3) %arrayidx389.2.1, align 2, !tbaa !73
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %59, i64 2
  %add384.3.1 = or disjoint i32 %mul380, %and386
  %add387.3.1 = or disjoint i32 %add384.3.1, 208
  %arrayidx389.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387.3.1
  %60 = load half, ptr addrspace(3) %arrayidx389.3.1, align 2, !tbaa !73
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %60, i64 3
  %add384.2712 = or disjoint i32 %mul380, %and386
  %add387.2713 = or disjoint i32 %add384.2712, 32
  %arrayidx389.2714 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387.2713
  %61 = load half, ptr addrspace(3) %arrayidx389.2714, align 2, !tbaa !73
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %61, i64 0
  %add384.1.2 = or disjoint i32 %mul380, %and386
  %add387.1.2 = or disjoint i32 %add384.1.2, 96
  %arrayidx389.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387.1.2
  %62 = load half, ptr addrspace(3) %arrayidx389.1.2, align 2, !tbaa !73
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %62, i64 1
  %add384.2.2 = or disjoint i32 %mul380, %and386
  %add387.2.2 = or disjoint i32 %add384.2.2, 160
  %arrayidx389.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387.2.2
  %63 = load half, ptr addrspace(3) %arrayidx389.2.2, align 2, !tbaa !73
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %63, i64 2
  %add384.3.2 = or disjoint i32 %mul380, %and386
  %add387.3.2 = or disjoint i32 %add384.3.2, 224
  %arrayidx389.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387.3.2
  %64 = load half, ptr addrspace(3) %arrayidx389.3.2, align 2, !tbaa !73
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %64, i64 3
  %add384.3716 = or disjoint i32 %mul380, %and386
  %add387.3717 = or disjoint i32 %add384.3716, 48
  %arrayidx389.3718 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387.3717
  %65 = load half, ptr addrspace(3) %arrayidx389.3718, align 2, !tbaa !73
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %65, i64 0
  %add384.1.3 = or disjoint i32 %mul380, %and386
  %add387.1.3 = or disjoint i32 %add384.1.3, 112
  %arrayidx389.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387.1.3
  %66 = load half, ptr addrspace(3) %arrayidx389.1.3, align 2, !tbaa !73
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %66, i64 1
  %add384.2.3 = or disjoint i32 %mul380, %and386
  %add387.2.3 = or disjoint i32 %add384.2.3, 176
  %arrayidx389.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387.2.3
  %67 = load half, ptr addrspace(3) %arrayidx389.2.3, align 2, !tbaa !73
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %67, i64 2
  %add384.3.3 = or disjoint i32 %52, %and386
  %add387.3.3 = or i32 %add384.3.3, 240
  %arrayidx389.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387.3.3
  %68 = load half, ptr addrspace(3) %arrayidx389.3.3, align 2, !tbaa !73
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %68, i64 3
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %70 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %72 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  br label %if.end418

if.end418:                                        ; preds = %for.cond370.preheader, %if.end348
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end348 ], [ %69, %for.cond370.preheader ]
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end348 ], [ %70, %for.cond370.preheader ]
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end348 ], [ %71, %for.cond370.preheader ]
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end348 ], [ %72, %for.cond370.preheader ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0
  %73 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract)
  %O_reg.sroa.0.0.insert.ext = zext i16 %73 to i64
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1
  %74 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract)
  %O_reg.sroa.0.2.insert.ext = zext i16 %74 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2
  %75 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract)
  %O_reg.sroa.0.4.insert.ext = zext i16 %75 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3
  %76 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract)
  %O_reg.sroa.0.6.insert.ext = zext i16 %76 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0
  %77 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract)
  %O_reg.sroa.7.8.insert.ext = zext i16 %77 to i64
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract)
  %O_reg.sroa.7.10.insert.ext = zext i16 %78 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract)
  %O_reg.sroa.7.12.insert.ext = zext i16 %79 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract)
  %O_reg.sroa.7.14.insert.ext = zext i16 %80 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract)
  %O_reg.sroa.12.16.insert.ext = zext i16 %81 to i64
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract)
  %O_reg.sroa.12.18.insert.ext = zext i16 %82 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract)
  %O_reg.sroa.12.20.insert.ext = zext i16 %83 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract)
  %O_reg.sroa.12.22.insert.ext = zext i16 %84 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract)
  %O_reg.sroa.17.24.insert.ext = zext i16 %85 to i64
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract)
  %O_reg.sroa.17.26.insert.ext = zext i16 %86 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract)
  %O_reg.sroa.17.28.insert.ext = zext i16 %87 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract)
  %O_reg.sroa.17.30.insert.ext = zext i16 %88 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and451 = shl nuw nsw i32 %1, 6
  %mul452 = and i32 %and451, 960
  %shr455 = lshr i32 %1, 5
  %and458 = and i32 %1, 7
  %89 = lshr i32 %1, 2
  %mul465 = and i32 %89, 4
  %xor459 = xor i32 %shr455, %and458
  %mul460 = shl nuw nsw i32 %xor459, 3
  %add461 = add nuw nsw i32 %mul460, %mul452
  %add466 = or disjoint i32 %add461, %mul465
  %add.ptr468 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr468, align 8
  %add456.1 = add nuw nsw i32 %shr455, 2
  %xor459.1 = xor i32 %add456.1, %and458
  %mul460.1 = shl nuw nsw i32 %xor459.1, 3
  %add461.1 = add nuw nsw i32 %mul460.1, %mul452
  %add466.1 = or disjoint i32 %add461.1, %mul465
  %add.ptr468.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr468.1, align 8
  %add456.2 = add nuw nsw i32 %shr455, 4
  %xor459.2 = xor i32 %add456.2, %and458
  %mul460.2 = shl nuw nsw i32 %xor459.2, 3
  %add461.2 = add nuw nsw i32 %mul460.2, %mul452
  %add466.2 = or disjoint i32 %add461.2, %mul465
  %add.ptr468.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr468.2, align 8
  %add456.3 = add nuw nsw i32 %shr455, 6
  %xor459.3 = xor i32 %add456.3, %and458
  %mul460.3 = shl nuw nsw i32 %xor459.3, 3
  %add461.3 = add nuw nsw i32 %mul460.3, %mul452
  %add466.3 = or disjoint i32 %add461.3, %mul465
  %add.ptr468.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr468.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul479 = and i32 %mul8, 8128
  %xor485609 = and i32 %mul8, 56
  %call483.masked = and i32 %1, 1016
  %mul486 = xor i32 %xor485609, %call483.masked
  %invariant.gep653 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul479
  %invariant.gep655 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep653, i32 %mul486
  %add.ptr498 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %2
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr498, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep655, i64 16, i1 false), !tbaa.struct !165, !call_argsrelate !166
  %gep656.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep655, i32 1024
  %add.ptr498.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr498.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep656.1, i64 16, i1 false), !tbaa.struct !165, !call_argsrelate !166
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


