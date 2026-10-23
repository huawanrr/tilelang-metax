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
  %mul = shl nsw i32 %0, 22
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul7 = shl nsw i32 %1, 10
  %add = add nuw nsw i32 %mul, %mul7
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %mul11 = shl nuw nsw i32 %2, 3
  %add9 = add nuw nsw i32 %add, %mul11
  %3 = zext nneg i32 %add9 to i64
  %4 = add nuw nsw i64 %3, 512
  %mul17 = shl nsw i32 %0, 12
  %add19 = add nuw nsw i32 %mul17, %1
  %idxprom = zext nneg i32 %add19 to i64
  %arrayidx20 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom
  %5 = load i32, ptr addrspace(1) %arrayidx20, align 4, !tbaa !30
  %cmp35 = icmp ugt i32 %5, 255
  %shr = lshr i32 %1, 4
  %cmp38.not = icmp ugt i32 %5, %shr
  %or.cond = or i1 %cmp35, %cmp38.not
  br i1 %or.cond, label %if.end343, label %for.cond41.preheader

for.cond41.preheader:                             ; preds = %entry
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %mul51 = shl nsw i32 %0, 18
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
  %add.ptr62.1671 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %14
  %15 = load i32, ptr addrspace(4) %add.ptr62.1671, align 4, !tbaa !30
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
  %add.ptr95.1683 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %14
  %26 = load i32, ptr addrspace(4) %add.ptr95.1683, align 4, !tbaa !30
  %add.ptr95.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %16
  %27 = load i32, ptr addrspace(4) %add.ptr95.1.1, align 4, !tbaa !30
  %add.ptr95.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %18
  %28 = load i32, ptr addrspace(4) %add.ptr95.2.1, align 4, !tbaa !30
  %add.ptr95.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %20
  %29 = load i32, ptr addrspace(4) %add.ptr95.3.1, align 4, !tbaa !30
  %mul119 = and i32 %mul11, 8128
  %xor607 = and i32 %mul11, 56
  %call122.masked = and i32 %2, 1016
  %mul124 = xor i32 %xor607, %call122.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul119
  %invariant.gep622 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul124
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep622, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !58
  %gep623.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep622, i32 1024
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep623.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !call_argsrelate !58
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
  store i32 %7, ptr addrspace(3) %invariant.gep622, align 16, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep627.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep622, i32 4
  store i32 %9, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep627.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep627.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep622, i32 8
  store i32 %11, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep627.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep627.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep622, i32 12
  store i32 %13, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep627.sroa_idx, align 4, !tbaa !30
  store i32 %15, ptr addrspace(3) %gep623.1, align 16, !tbaa !30
  %K_reg.sroa.9.16.gep628.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep622, i32 1028
  store i32 %17, ptr addrspace(3) %K_reg.sroa.9.16.gep628.1.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.10.16.gep628.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep622, i32 1032
  store i32 %19, ptr addrspace(3) %K_reg.sroa.10.16.gep628.1.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.11.16.gep628.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep622, i32 1036
  store i32 %21, ptr addrspace(3) %K_reg.sroa.11.16.gep628.1.sroa_idx, align 4, !tbaa !30
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr148, align 16
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr148.sroa_idx, align 8
  %31 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer)
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %31)
  %kb.sroa.0.0.copyload713 = load <4 x half>, ptr addrspace(3) %add.ptr148.1, align 16
  %kb.sroa.6.0.copyload714 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr148.1.sroa_idx, align 8
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload713, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %32)
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload714, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %33)
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add.ptr240.idx = shl nuw nsw i32 %2, 4
  %invariant.gep635 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr240.idx
  store i32 %22, ptr addrspace(3) %invariant.gep635, align 16, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep635.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep635, i32 4
  store i32 %23, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep635.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep635.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep635, i32 8
  store i32 %24, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep635.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep635.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep635, i32 12
  store i32 %25, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep635.sroa_idx, align 4, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep635, i32 1024
  store i32 %26, ptr addrspace(3) %gep.1, align 16, !tbaa !30
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep635, i32 1028
  store i32 %27, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep635, i32 1032
  store i32 %28, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep635, i32 1036
  store i32 %29, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !tbaa !30
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %34, i64 0
  %mul250 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %35 = tail call contract noundef float @llvm.minnum.f32(float %mul250, float 0x4024CB5EC0000000)
  %36 = tail call contract noundef float @llvm.exp.f32(float %35)
  %acc_s.sroa.0.0.vec.insert720 = insertelement <4 x float> poison, float %36, i64 0
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %34, i64 1
  %mul250.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %37 = tail call contract noundef float @llvm.minnum.f32(float %mul250.1, float 0x4024CB5EC0000000)
  %38 = tail call contract noundef float @llvm.exp.f32(float %37)
  %acc_s.sroa.0.4.vec.insert735 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert720, float %38, i64 1
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %34, i64 2
  %mul250.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %39 = tail call contract noundef float @llvm.minnum.f32(float %mul250.2, float 0x4024CB5EC0000000)
  %40 = tail call contract noundef float @llvm.exp.f32(float %39)
  %acc_s.sroa.0.8.vec.insert750 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert735, float %40, i64 2
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %34, i64 3
  %mul250.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %41 = tail call contract noundef float @llvm.minnum.f32(float %mul250.3, float 0x4024CB5EC0000000)
  %42 = tail call contract noundef float @llvm.exp.f32(float %41)
  %acc_s.sroa.0.12.vec.insert765 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert750, float %42, i64 3
  %cmp260 = icmp eq i32 %5, %shr
  br i1 %cmp260, label %for.cond262.preheader, label %if.end281

for.cond262.preheader:                            ; preds = %for.cond41.preheader
  %43 = lshr i32 %2, 2
  %mul268 = and i32 %43, 252
  %and271 = and i32 %1, 15
  %cmp272.not = icmp ugt i32 %mul268, %and271
  %spec.select = select i1 %cmp272.not, float 0.000000e+00, float %36
  %acc_s.sroa.0.0.vec.insert724 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp272.not.1.not = icmp ult i32 %mul268, %and271
  %condval.0.1 = select i1 %cmp272.not.1.not, float %38, float 0.000000e+00
  %acc_s.sroa.0.4.vec.insert739 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert724, float %condval.0.1, i64 1
  %add269.2 = or disjoint i32 %mul268, 2
  %cmp272.not.2 = icmp ugt i32 %add269.2, %and271
  %condval.0.2 = select i1 %cmp272.not.2, float 0.000000e+00, float %40
  %acc_s.sroa.0.8.vec.insert754 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert739, float %condval.0.2, i64 2
  %add269.3 = or i32 %43, 3
  %cmp272.not.3 = icmp ugt i32 %add269.3, %and271
  %condval.0.3 = select i1 %cmp272.not.3, float 0.000000e+00, float %42
  %acc_s.sroa.0.12.vec.insert769 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert754, float %condval.0.3, i64 3
  br label %if.end281

if.end281:                                        ; preds = %for.cond262.preheader, %for.cond41.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert769, %for.cond262.preheader ], [ %acc_s.sroa.0.12.vec.insert765, %for.cond41.preheader ]
  %acc_s.sroa.0.0.vec.extract726 = extractelement <4 x float> %acc_s.sroa.0.0, i64 0
  %add290 = fadd contract float %acc_s.sroa.0.0.vec.extract726, 0.000000e+00
  %acc_s.sroa.0.4.vec.extract741 = extractelement <4 x float> %acc_s.sroa.0.0, i64 1
  %add290.1 = fadd contract float %add290, %acc_s.sroa.0.4.vec.extract741
  %acc_s.sroa.0.8.vec.extract756 = extractelement <4 x float> %acc_s.sroa.0.0, i64 2
  %add290.2 = fadd contract float %add290.1, %acc_s.sroa.0.8.vec.extract756
  %acc_s.sroa.0.12.vec.extract771 = extractelement <4 x float> %acc_s.sroa.0.0, i64 3
  %add290.3 = fadd contract float %add290.2, %acc_s.sroa.0.12.vec.extract771
  %44 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add290.3, <4 x float> zeroinitializer)
  %wsum_output.sroa.0.0.vec.extract = extractelement <4 x float> %44, i64 0
  %cmp308 = fcmp contract ogt float %wsum_output.sroa.0.0.vec.extract, 0.000000e+00
  %cmp.i.i = fcmp contract olt float %wsum_output.sroa.0.0.vec.extract, 0x39B0000000000000
  %cond.i.i = select contract i1 %cmp.i.i, float 0x4630000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %wsum_output.sroa.0.0.vec.extract, %cond.i.i
  %45 = tail call contract float @llvm.mxc.rsq.f32(float %mul.i.i)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x4310000000000000, float 1.000000e+00
  %mul3.i.i = fmul contract float %cond2.i.i, %45
  %mul314 = fmul contract float %mul3.i.i, %mul3.i.i
  %condval_1.0 = select i1 %cmp308, float %mul314, float 0.000000e+00
  %mul325 = fmul contract float %condval_1.0, %acc_s.sroa.0.0.vec.extract726
  %acc_s.sroa.0.4.vec.extract743 = extractelement <4 x float> %acc_s.sroa.0.0, i64 1
  %mul325.1 = fmul contract float %condval_1.0, %acc_s.sroa.0.4.vec.extract743
  %acc_s.sroa.0.8.vec.extract758 = extractelement <4 x float> %acc_s.sroa.0.0, i64 2
  %mul325.2 = fmul contract float %condval_1.0, %acc_s.sroa.0.8.vec.extract758
  %acc_s.sroa.0.12.vec.extract773 = extractelement <4 x float> %acc_s.sroa.0.0, i64 3
  %mul325.3 = fmul contract float %condval_1.0, %acc_s.sroa.0.12.vec.extract773
  %46 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325)
  %47 = insertelement <4 x i16> poison, i16 %46, i64 0
  %48 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.1)
  %49 = insertelement <4 x i16> %47, i16 %48, i64 1
  %50 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.2)
  %51 = insertelement <4 x i16> %49, i16 %50, i64 2
  %52 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.3)
  %53 = insertelement <4 x i16> %51, i16 %52, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %53 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end343

if.end343:                                        ; preds = %entry, %if.end281
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ %acc_s_cast.sroa.0.6.vec.insert, %if.end281 ], [ undef, %entry ]
  %cmp359 = icmp ugt i32 %5, 255
  %cmp363.not = icmp ugt i32 %5, %shr
  %or.cond656 = or i1 %cmp359, %cmp363.not
  br i1 %or.cond656, label %if.end413, label %for.cond365.preheader

for.cond365.preheader:                            ; preds = %if.end343
  %54 = shl nuw nsw i32 %2, 4
  %mul375 = and i32 %54, 16128
  %and381 = and i32 %2, 15
  %add382 = or disjoint i32 %mul375, %and381
  %arrayidx384 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add382
  %55 = load half, ptr addrspace(3) %arrayidx384, align 2, !tbaa !139
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %55, i64 0
  %add377.1 = or disjoint i32 %mul375, %and381
  %add382.1 = or disjoint i32 %add377.1, 64
  %arrayidx384.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add382.1
  %56 = load half, ptr addrspace(3) %arrayidx384.1, align 2, !tbaa !139
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %56, i64 1
  %add377.2 = or disjoint i32 %mul375, %and381
  %add382.2 = or disjoint i32 %add377.2, 128
  %arrayidx384.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add382.2
  %57 = load half, ptr addrspace(3) %arrayidx384.2, align 2, !tbaa !139
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %57, i64 2
  %add377.3 = or disjoint i32 %mul375, %and381
  %add382.3 = or disjoint i32 %add377.3, 192
  %arrayidx384.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add382.3
  %58 = load half, ptr addrspace(3) %arrayidx384.3, align 2, !tbaa !139
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %58, i64 3
  %add379.1687 = or disjoint i32 %mul375, %and381
  %add382.1688 = or disjoint i32 %add379.1687, 16
  %arrayidx384.1689 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add382.1688
  %59 = load half, ptr addrspace(3) %arrayidx384.1689, align 2, !tbaa !139
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %59, i64 0
  %add379.1.1 = or disjoint i32 %mul375, %and381
  %add382.1.1 = or disjoint i32 %add379.1.1, 80
  %arrayidx384.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add382.1.1
  %60 = load half, ptr addrspace(3) %arrayidx384.1.1, align 2, !tbaa !139
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %60, i64 1
  %add379.2.1 = or disjoint i32 %mul375, %and381
  %add382.2.1 = or disjoint i32 %add379.2.1, 144
  %arrayidx384.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add382.2.1
  %61 = load half, ptr addrspace(3) %arrayidx384.2.1, align 2, !tbaa !139
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %61, i64 2
  %add379.3.1 = or disjoint i32 %mul375, %and381
  %add382.3.1 = or disjoint i32 %add379.3.1, 208
  %arrayidx384.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add382.3.1
  %62 = load half, ptr addrspace(3) %arrayidx384.3.1, align 2, !tbaa !139
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %62, i64 3
  %add379.2691 = or disjoint i32 %mul375, %and381
  %add382.2692 = or disjoint i32 %add379.2691, 32
  %arrayidx384.2693 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add382.2692
  %63 = load half, ptr addrspace(3) %arrayidx384.2693, align 2, !tbaa !139
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %63, i64 0
  %add379.1.2 = or disjoint i32 %mul375, %and381
  %add382.1.2 = or disjoint i32 %add379.1.2, 96
  %arrayidx384.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add382.1.2
  %64 = load half, ptr addrspace(3) %arrayidx384.1.2, align 2, !tbaa !139
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %64, i64 1
  %add379.2.2 = or disjoint i32 %mul375, %and381
  %add382.2.2 = or disjoint i32 %add379.2.2, 160
  %arrayidx384.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add382.2.2
  %65 = load half, ptr addrspace(3) %arrayidx384.2.2, align 2, !tbaa !139
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %65, i64 2
  %add379.3.2 = or disjoint i32 %mul375, %and381
  %add382.3.2 = or disjoint i32 %add379.3.2, 224
  %arrayidx384.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add382.3.2
  %66 = load half, ptr addrspace(3) %arrayidx384.3.2, align 2, !tbaa !139
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %66, i64 3
  %add379.3695 = or disjoint i32 %mul375, %and381
  %add382.3696 = or disjoint i32 %add379.3695, 48
  %arrayidx384.3697 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add382.3696
  %67 = load half, ptr addrspace(3) %arrayidx384.3697, align 2, !tbaa !139
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %67, i64 0
  %add379.1.3 = or disjoint i32 %mul375, %and381
  %add382.1.3 = or disjoint i32 %add379.1.3, 112
  %arrayidx384.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add382.1.3
  %68 = load half, ptr addrspace(3) %arrayidx384.1.3, align 2, !tbaa !139
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %68, i64 1
  %add379.2.3 = or disjoint i32 %mul375, %and381
  %add382.2.3 = or disjoint i32 %add379.2.3, 176
  %arrayidx384.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add382.2.3
  %69 = load half, ptr addrspace(3) %arrayidx384.2.3, align 2, !tbaa !139
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %69, i64 2
  %add379.3.3 = or disjoint i32 %54, %and381
  %add382.3.3 = or i32 %add379.3.3, 240
  %arrayidx384.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add382.3.3
  %70 = load half, ptr addrspace(3) %arrayidx384.3.3, align 2, !tbaa !139
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %70, i64 3
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %72 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %73 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %74 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  br label %if.end413

if.end413:                                        ; preds = %for.cond365.preheader, %if.end343
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end343 ], [ %71, %for.cond365.preheader ]
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end343 ], [ %72, %for.cond365.preheader ]
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end343 ], [ %73, %for.cond365.preheader ]
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end343 ], [ %74, %for.cond365.preheader ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0
  %75 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract)
  %O_reg.sroa.0.0.insert.ext = zext i16 %75 to i64
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1
  %76 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract)
  %O_reg.sroa.0.2.insert.ext = zext i16 %76 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2
  %77 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract)
  %O_reg.sroa.0.4.insert.ext = zext i16 %77 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract)
  %O_reg.sroa.0.6.insert.ext = zext i16 %78 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract)
  %O_reg.sroa.7.8.insert.ext = zext i16 %79 to i64
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract)
  %O_reg.sroa.7.10.insert.ext = zext i16 %80 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract)
  %O_reg.sroa.7.12.insert.ext = zext i16 %81 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract)
  %O_reg.sroa.7.14.insert.ext = zext i16 %82 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract)
  %O_reg.sroa.12.16.insert.ext = zext i16 %83 to i64
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract)
  %O_reg.sroa.12.18.insert.ext = zext i16 %84 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract)
  %O_reg.sroa.12.20.insert.ext = zext i16 %85 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract)
  %O_reg.sroa.12.22.insert.ext = zext i16 %86 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract)
  %O_reg.sroa.17.24.insert.ext = zext i16 %87 to i64
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract)
  %O_reg.sroa.17.26.insert.ext = zext i16 %88 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract)
  %O_reg.sroa.17.28.insert.ext = zext i16 %89 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract)
  %O_reg.sroa.17.30.insert.ext = zext i16 %90 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and446 = shl nuw nsw i32 %2, 6
  %mul447 = and i32 %and446, 960
  %shr450 = lshr i32 %2, 5
  %and453 = and i32 %2, 7
  %91 = lshr i32 %2, 2
  %mul460 = and i32 %91, 4
  %xor454 = xor i32 %shr450, %and453
  %mul455 = shl nuw nsw i32 %xor454, 3
  %add456 = add nuw nsw i32 %mul455, %mul447
  %add461 = or disjoint i32 %add456, %mul460
  %add.ptr463 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add461
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr463, align 8
  %add451.1 = add nuw nsw i32 %shr450, 2
  %xor454.1 = xor i32 %add451.1, %and453
  %mul455.1 = shl nuw nsw i32 %xor454.1, 3
  %add456.1 = add nuw nsw i32 %mul455.1, %mul447
  %add461.1 = or disjoint i32 %add456.1, %mul460
  %add.ptr463.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add461.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr463.1, align 8
  %add451.2 = add nuw nsw i32 %shr450, 4
  %xor454.2 = xor i32 %add451.2, %and453
  %mul455.2 = shl nuw nsw i32 %xor454.2, 3
  %add456.2 = add nuw nsw i32 %mul455.2, %mul447
  %add461.2 = or disjoint i32 %add456.2, %mul460
  %add.ptr463.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add461.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr463.2, align 8
  %add451.3 = add nuw nsw i32 %shr450, 6
  %xor454.3 = xor i32 %add451.3, %and453
  %mul455.3 = shl nuw nsw i32 %xor454.3, 3
  %add456.3 = add nuw nsw i32 %mul455.3, %mul447
  %add461.3 = or disjoint i32 %add456.3, %mul460
  %add.ptr463.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add461.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr463.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul474 = and i32 %mul11, 8128
  %xor480603 = and i32 %mul11, 56
  %call478.masked = and i32 %2, 1016
  %mul481 = xor i32 %xor480603, %call478.masked
  %invariant.gep650 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul474
  %invariant.gep652 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep650, i32 %mul481
  %add.ptr496 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr496, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep652, i64 16, i1 false), !tbaa.struct !168, !call_argsrelate !169
  %gep653.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep652, i32 1024
  %add.ptr496.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr496.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep653.1, i64 16, i1 false), !tbaa.struct !168, !call_argsrelate !169
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

declare float @llvm.mxc.rsq.f32(float) #5

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


