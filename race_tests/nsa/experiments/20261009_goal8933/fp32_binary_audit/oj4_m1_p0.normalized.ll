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
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul = shl nsw i32 %0, 19
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul7 = shl nsw i32 %1, 10
  %add = add nuw nsw i32 %mul, %mul7
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %mul11 = shl nuw nsw i32 %2, 3
  %add9 = add nuw nsw i32 %add, %mul11
  %3 = zext nneg i32 %add9 to i64
  %4 = add nuw nsw i64 %3, 512
  %mul17 = shl nsw i32 %0, 9
  %add19 = add nuw nsw i32 %mul17, %1
  %idxprom = zext nneg i32 %add19 to i64
  %arrayidx20 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom
  %5 = load i32, ptr addrspace(1) %arrayidx20, align 4, !tbaa !30
  %cmp35 = icmp ugt i32 %5, 31
  %shr = lshr i32 %1, 4
  %cmp38.not = icmp ugt i32 %5, %shr
  %or.cond634 = or i1 %cmp35, %cmp38.not
  br i1 %or.cond634, label %if.end332, label %if.then

if.then:                                          ; preds = %entry
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %mul51 = shl nsw i32 %0, 15
  %mul52 = shl nuw nsw i32 %5, 10
  %add53 = or disjoint i32 %mul11, %mul51
  %add55 = add nuw nsw i32 %add53, %mul52
  %6 = zext nneg i32 %add55 to i64
  %add.ptr62 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %6
  %7 = load i32, ptr addrspace(4) %add.ptr62, align 4, !tbaa !30
  %8 = or disjoint i64 %6, 2
  %add.ptr62.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %8
  %9 = load i32, ptr addrspace(4) %add.ptr62.1, align 4, !tbaa !30
  %10 = or disjoint i64 %6, 4
  %add.ptr62.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %10
  %11 = load i32, ptr addrspace(4) %add.ptr62.2, align 4, !tbaa !30
  %12 = or disjoint i64 %6, 6
  %add.ptr62.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %12
  %13 = load i32, ptr addrspace(4) %add.ptr62.3, align 4, !tbaa !30
  %14 = add nuw nsw i64 %6, 512
  %add.ptr62.1652 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %14
  %15 = load i32, ptr addrspace(4) %add.ptr62.1652, align 4, !tbaa !30
  %16 = add nuw nsw i64 %6, 514
  %add.ptr62.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %16
  %17 = load i32, ptr addrspace(4) %add.ptr62.1.1, align 4, !tbaa !30
  %18 = add nuw nsw i64 %6, 516
  %add.ptr62.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %18
  %19 = load i32, ptr addrspace(4) %add.ptr62.2.1, align 4, !tbaa !30
  %20 = add nuw nsw i64 %6, 518
  %add.ptr62.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %20
  %21 = load i32, ptr addrspace(4) %add.ptr62.3.1, align 4, !tbaa !30
  %add.ptr95 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %6
  %22 = load i32, ptr addrspace(4) %add.ptr95, align 4, !tbaa !30
  %add.ptr95.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %8
  %23 = load i32, ptr addrspace(4) %add.ptr95.1, align 4, !tbaa !30
  %add.ptr95.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %10
  %24 = load i32, ptr addrspace(4) %add.ptr95.2, align 4, !tbaa !30
  %add.ptr95.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %12
  %25 = load i32, ptr addrspace(4) %add.ptr95.3, align 4, !tbaa !30
  %add.ptr95.1664 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %14
  %26 = load i32, ptr addrspace(4) %add.ptr95.1664, align 4, !tbaa !30
  %add.ptr95.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %16
  %27 = load i32, ptr addrspace(4) %add.ptr95.1.1, align 4, !tbaa !30
  %add.ptr95.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %18
  %28 = load i32, ptr addrspace(4) %add.ptr95.2.1, align 4, !tbaa !30
  %add.ptr95.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %20
  %29 = load i32, ptr addrspace(4) %add.ptr95.3.1, align 4, !tbaa !30
  %mul119 = and i32 %mul11, 8128
  %xor592 = and i32 %mul11, 56
  %call122.masked = and i32 %2, 1016
  %mul124 = xor i32 %xor592, %call122.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul119
  %invariant.gep602 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul124
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep602, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !58
  %gep603.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep602, i32 1024
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep603.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !call_argsrelate !58
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and136 = shl nuw nsw i32 %2, 6
  %mul137 = and i32 %and136, 960
  %shr140 = lshr i32 %2, 4
  %and143 = and i32 %2, 7
  %30 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul137
  %xor144 = xor i32 %shr140, %and143
  %add.ptr148.idx = shl nuw nsw i32 %xor144, 4
  %add.ptr148 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 %add.ptr148.idx
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr148, align 16
  %Q_reg.sroa.4.0.add.ptr148.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr148, i32 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr148.sroa_idx, align 8
  %add141.1 = add nuw nsw i32 %shr140, 4
  %xor144.1 = xor i32 %add141.1, %and143
  %add.ptr148.idx.1 = shl nuw nsw i32 %xor144.1, 4
  %add.ptr148.1 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 %add.ptr148.idx.1
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr148.1, align 16
  %Q_reg.sroa.7.16.add.ptr148.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr148.1, i32 8
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr148.1.sroa_idx, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  store i32 %7, ptr addrspace(3) %invariant.gep602, align 16, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep607.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep602, i32 4
  store i32 %9, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep607.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep607.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep602, i32 8
  store i32 %11, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep607.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep607.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep602, i32 12
  store i32 %13, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep607.sroa_idx, align 4, !tbaa !30
  store i32 %15, ptr addrspace(3) %gep603.1, align 16, !tbaa !30
  %K_reg.sroa.9.16.gep608.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep602, i32 1028
  store i32 %17, ptr addrspace(3) %K_reg.sroa.9.16.gep608.1.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.10.16.gep608.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep602, i32 1032
  store i32 %19, ptr addrspace(3) %K_reg.sroa.10.16.gep608.1.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.11.16.gep608.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep602, i32 1036
  store i32 %21, ptr addrspace(3) %K_reg.sroa.11.16.gep608.1.sroa_idx, align 4, !tbaa !30
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr148, align 16
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr148.sroa_idx, align 8
  %31 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer)
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %31)
  %kb.sroa.0.0.copyload694 = load <4 x half>, ptr addrspace(3) %add.ptr148.1, align 16
  %kb.sroa.6.0.copyload695 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr148.1.sroa_idx, align 8
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload694, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %32)
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload695, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %33)
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add.ptr240.idx = shl nuw nsw i32 %2, 4
  %invariant.gep615 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr240.idx
  store i32 %22, ptr addrspace(3) %invariant.gep615, align 16, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep615.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep615, i32 4
  store i32 %23, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep615.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep615.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep615, i32 8
  store i32 %24, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep615.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep615.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep615, i32 12
  store i32 %25, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep615.sroa_idx, align 4, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep615, i32 1024
  store i32 %26, ptr addrspace(3) %gep.1, align 16, !tbaa !30
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep615, i32 1028
  store i32 %27, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep615, i32 1032
  store i32 %28, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep615, i32 1036
  store i32 %29, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !tbaa !30
  %mul39 = shl nuw nsw i32 %5, 4
  %shr252 = shl nuw nsw i32 %5, 2
  %add253 = add nuw nsw i32 %shr252, %shr140
  %cmp254 = icmp ugt i32 %add253, 127
  %35 = lshr i32 %2, 2
  %mul258 = and i32 %35, 252
  %add260 = add nuw nsw i32 %mul39, %mul258
  %cmp263.not = icmp ugt i32 %add260, %1
  %or.cond635 = select i1 %cmp254, i1 true, i1 %cmp263.not
  br i1 %or.cond635, label %if.end, label %if.then264

if.then264:                                       ; preds = %if.then
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %34, i64 0
  %mul267 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %36 = tail call contract noundef float @llvm.minnum.f32(float %mul267, float 0x4024CB5EC0000000)
  %37 = tail call contract noundef float @llvm.exp.f32(float %36)
  br label %if.end

if.end:                                           ; preds = %if.then, %if.then264
  %condval.0 = phi float [ %37, %if.then264 ], [ 0.000000e+00, %if.then ]
  %cmp263.not.1 = icmp uge i32 %add260, %1
  %or.cond635.1 = select i1 %cmp254, i1 true, i1 %cmp263.not.1
  br i1 %or.cond635.1, label %if.end.1, label %if.then264.1

if.then264.1:                                     ; preds = %if.end
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %34, i64 1
  %mul267.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %38 = tail call contract noundef float @llvm.minnum.f32(float %mul267.1, float 0x4024CB5EC0000000)
  %39 = tail call contract noundef float @llvm.exp.f32(float %38)
  br label %if.end.1

if.end.1:                                         ; preds = %if.then264.1, %if.end
  %condval.0.1 = phi float [ %39, %if.then264.1 ], [ 0.000000e+00, %if.end ]
  %add261.2 = or disjoint i32 %add260, 2
  %cmp263.not.2 = icmp ugt i32 %add261.2, %1
  %or.cond635.2 = select i1 %cmp254, i1 true, i1 %cmp263.not.2
  br i1 %or.cond635.2, label %if.end.2, label %if.then264.2

if.then264.2:                                     ; preds = %if.end.1
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %34, i64 2
  %mul267.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul267.2, float 0x4024CB5EC0000000)
  %41 = tail call contract noundef float @llvm.exp.f32(float %40)
  br label %if.end.2

if.end.2:                                         ; preds = %if.then264.2, %if.end.1
  %condval.0.2 = phi float [ %41, %if.then264.2 ], [ 0.000000e+00, %if.end.1 ]
  %add261.3 = or disjoint i32 %add260, 3
  %cmp263.not.3 = icmp ugt i32 %add261.3, %1
  %or.cond635.3 = select i1 %cmp254, i1 true, i1 %cmp263.not.3
  br i1 %or.cond635.3, label %if.end.3, label %if.then264.3

if.then264.3:                                     ; preds = %if.end.2
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %34, i64 3
  %mul267.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %42 = tail call contract noundef float @llvm.minnum.f32(float %mul267.3, float 0x4024CB5EC0000000)
  %43 = tail call contract noundef float @llvm.exp.f32(float %42)
  br label %if.end.3

if.end.3:                                         ; preds = %if.then264.3, %if.end.2
  %condval.0.3 = phi float [ %43, %if.then264.3 ], [ 0.000000e+00, %if.end.2 ]
  %add283.1 = fadd contract float %condval.0, %condval.0.1
  %add283.2 = fadd contract float %add283.1, %condval.0.2
  %add283.3 = fadd contract float %add283.2, %condval.0.3
  %44 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add283.3, <4 x float> zeroinitializer)
  %wsum_output.sroa.0.0.vec.extract = extractelement <4 x float> %44, i64 0
  %cmp301 = fcmp contract ogt float %wsum_output.sroa.0.0.vec.extract, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %wsum_output.sroa.0.0.vec.extract
  %condval_1.0 = select i1 %cmp301, float %div, float 0.000000e+00
  %mul314 = fmul contract float %condval_1.0, %condval.0
  %mul314.1 = fmul contract float %condval_1.0, %condval.0.1
  %mul314.2 = fmul contract float %condval_1.0, %condval.0.2
  %mul314.3 = fmul contract float %condval_1.0, %condval.0.3
  %45 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul314)
  %46 = insertelement <4 x i16> poison, i16 %45, i64 0
  %47 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul314.1)
  %48 = insertelement <4 x i16> %46, i16 %47, i64 1
  %49 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul314.2)
  %50 = insertelement <4 x i16> %48, i16 %49, i64 2
  %51 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul314.3)
  %52 = insertelement <4 x i16> %50, i16 %51, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %52 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end332

if.end332:                                        ; preds = %if.end.3, %entry
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ undef, %entry ], [ %acc_s_cast.sroa.0.6.vec.insert, %if.end.3 ]
  br i1 %or.cond634, label %if.end402, label %for.cond354.preheader

for.cond354.preheader:                            ; preds = %if.end332
  %53 = shl nuw nsw i32 %2, 4
  %mul364 = and i32 %53, 16128
  %and370 = and i32 %2, 15
  %add371 = or disjoint i32 %mul364, %and370
  %arrayidx373 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371
  %54 = load half, ptr addrspace(3) %arrayidx373, align 2, !tbaa !132
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %54, i64 0
  %add366.1 = or disjoint i32 %mul364, %and370
  %add371.1 = or disjoint i32 %add366.1, 64
  %arrayidx373.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.1
  %55 = load half, ptr addrspace(3) %arrayidx373.1, align 2, !tbaa !132
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %55, i64 1
  %add366.2 = or disjoint i32 %mul364, %and370
  %add371.2 = or disjoint i32 %add366.2, 128
  %arrayidx373.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.2
  %56 = load half, ptr addrspace(3) %arrayidx373.2, align 2, !tbaa !132
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %56, i64 2
  %add366.3 = or disjoint i32 %mul364, %and370
  %add371.3 = or disjoint i32 %add366.3, 192
  %arrayidx373.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.3
  %57 = load half, ptr addrspace(3) %arrayidx373.3, align 2, !tbaa !132
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %57, i64 3
  %add368.1668 = or disjoint i32 %mul364, %and370
  %add371.1669 = or disjoint i32 %add368.1668, 16
  %arrayidx373.1670 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.1669
  %58 = load half, ptr addrspace(3) %arrayidx373.1670, align 2, !tbaa !132
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %58, i64 0
  %add368.1.1 = or disjoint i32 %mul364, %and370
  %add371.1.1 = or disjoint i32 %add368.1.1, 80
  %arrayidx373.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.1.1
  %59 = load half, ptr addrspace(3) %arrayidx373.1.1, align 2, !tbaa !132
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %59, i64 1
  %add368.2.1 = or disjoint i32 %mul364, %and370
  %add371.2.1 = or disjoint i32 %add368.2.1, 144
  %arrayidx373.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.2.1
  %60 = load half, ptr addrspace(3) %arrayidx373.2.1, align 2, !tbaa !132
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %60, i64 2
  %add368.3.1 = or disjoint i32 %mul364, %and370
  %add371.3.1 = or disjoint i32 %add368.3.1, 208
  %arrayidx373.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.3.1
  %61 = load half, ptr addrspace(3) %arrayidx373.3.1, align 2, !tbaa !132
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %61, i64 3
  %add368.2672 = or disjoint i32 %mul364, %and370
  %add371.2673 = or disjoint i32 %add368.2672, 32
  %arrayidx373.2674 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.2673
  %62 = load half, ptr addrspace(3) %arrayidx373.2674, align 2, !tbaa !132
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %62, i64 0
  %add368.1.2 = or disjoint i32 %mul364, %and370
  %add371.1.2 = or disjoint i32 %add368.1.2, 96
  %arrayidx373.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.1.2
  %63 = load half, ptr addrspace(3) %arrayidx373.1.2, align 2, !tbaa !132
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %63, i64 1
  %add368.2.2 = or disjoint i32 %mul364, %and370
  %add371.2.2 = or disjoint i32 %add368.2.2, 160
  %arrayidx373.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.2.2
  %64 = load half, ptr addrspace(3) %arrayidx373.2.2, align 2, !tbaa !132
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %64, i64 2
  %add368.3.2 = or disjoint i32 %mul364, %and370
  %add371.3.2 = or disjoint i32 %add368.3.2, 224
  %arrayidx373.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.3.2
  %65 = load half, ptr addrspace(3) %arrayidx373.3.2, align 2, !tbaa !132
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %65, i64 3
  %add368.3676 = or disjoint i32 %mul364, %and370
  %add371.3677 = or disjoint i32 %add368.3676, 48
  %arrayidx373.3678 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.3677
  %66 = load half, ptr addrspace(3) %arrayidx373.3678, align 2, !tbaa !132
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %66, i64 0
  %add368.1.3 = or disjoint i32 %mul364, %and370
  %add371.1.3 = or disjoint i32 %add368.1.3, 112
  %arrayidx373.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.1.3
  %67 = load half, ptr addrspace(3) %arrayidx373.1.3, align 2, !tbaa !132
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %67, i64 1
  %add368.2.3 = or disjoint i32 %mul364, %and370
  %add371.2.3 = or disjoint i32 %add368.2.3, 176
  %arrayidx373.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.2.3
  %68 = load half, ptr addrspace(3) %arrayidx373.2.3, align 2, !tbaa !132
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %68, i64 2
  %add368.3.3 = or disjoint i32 %53, %and370
  %add371.3.3 = or i32 %add368.3.3, 240
  %arrayidx373.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.3.3
  %69 = load half, ptr addrspace(3) %arrayidx373.3.3, align 2, !tbaa !132
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %69, i64 3
  %70 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %72 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %73 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  br label %if.end402

if.end402:                                        ; preds = %for.cond354.preheader, %if.end332
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end332 ], [ %70, %for.cond354.preheader ]
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end332 ], [ %71, %for.cond354.preheader ]
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end332 ], [ %72, %for.cond354.preheader ]
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end332 ], [ %73, %for.cond354.preheader ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0
  %74 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract)
  %O_reg.sroa.0.0.insert.ext = zext i16 %74 to i64
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1
  %75 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract)
  %O_reg.sroa.0.2.insert.ext = zext i16 %75 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2
  %76 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract)
  %O_reg.sroa.0.4.insert.ext = zext i16 %76 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3
  %77 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract)
  %O_reg.sroa.0.6.insert.ext = zext i16 %77 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract)
  %O_reg.sroa.7.8.insert.ext = zext i16 %78 to i64
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract)
  %O_reg.sroa.7.10.insert.ext = zext i16 %79 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract)
  %O_reg.sroa.7.12.insert.ext = zext i16 %80 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract)
  %O_reg.sroa.7.14.insert.ext = zext i16 %81 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract)
  %O_reg.sroa.12.16.insert.ext = zext i16 %82 to i64
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract)
  %O_reg.sroa.12.18.insert.ext = zext i16 %83 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract)
  %O_reg.sroa.12.20.insert.ext = zext i16 %84 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract)
  %O_reg.sroa.12.22.insert.ext = zext i16 %85 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract)
  %O_reg.sroa.17.24.insert.ext = zext i16 %86 to i64
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract)
  %O_reg.sroa.17.26.insert.ext = zext i16 %87 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract)
  %O_reg.sroa.17.28.insert.ext = zext i16 %88 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract)
  %O_reg.sroa.17.30.insert.ext = zext i16 %89 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and435 = shl nuw nsw i32 %2, 6
  %mul436 = and i32 %and435, 960
  %shr439 = lshr i32 %2, 5
  %and442 = and i32 %2, 7
  %90 = lshr i32 %2, 2
  %mul449 = and i32 %90, 4
  %xor443 = xor i32 %shr439, %and442
  %mul444 = shl nuw nsw i32 %xor443, 3
  %add445 = add nuw nsw i32 %mul444, %mul436
  %add450 = or disjoint i32 %add445, %mul449
  %add.ptr452 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add450
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr452, align 8
  %add440.1 = add nuw nsw i32 %shr439, 2
  %xor443.1 = xor i32 %add440.1, %and442
  %mul444.1 = shl nuw nsw i32 %xor443.1, 3
  %add445.1 = add nuw nsw i32 %mul444.1, %mul436
  %add450.1 = or disjoint i32 %add445.1, %mul449
  %add.ptr452.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add450.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr452.1, align 8
  %add440.2 = add nuw nsw i32 %shr439, 4
  %xor443.2 = xor i32 %add440.2, %and442
  %mul444.2 = shl nuw nsw i32 %xor443.2, 3
  %add445.2 = add nuw nsw i32 %mul444.2, %mul436
  %add450.2 = or disjoint i32 %add445.2, %mul449
  %add.ptr452.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add450.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr452.2, align 8
  %add440.3 = add nuw nsw i32 %shr439, 6
  %xor443.3 = xor i32 %add440.3, %and442
  %mul444.3 = shl nuw nsw i32 %xor443.3, 3
  %add445.3 = add nuw nsw i32 %mul444.3, %mul436
  %add450.3 = or disjoint i32 %add445.3, %mul449
  %add.ptr452.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add450.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr452.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul463 = and i32 %mul11, 8128
  %xor469588 = and i32 %mul11, 56
  %call467.masked = and i32 %2, 1016
  %mul470 = xor i32 %xor469588, %call467.masked
  %invariant.gep629 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul463
  %invariant.gep631 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep629, i32 %mul470
  %add.ptr485 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr485, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep631, i64 16, i1 false), !tbaa.struct !161, !call_argsrelate !162
  %gep632.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep631, i32 1024
  %add.ptr485.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr485.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep632.1, i64 16, i1 false), !tbaa.struct !161, !call_argsrelate !162
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


