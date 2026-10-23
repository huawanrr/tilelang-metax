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
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom
  %5 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cmp34 = icmp ugt i32 %5, 31
  %shr = lshr i32 %1, 4
  %cmp37.not = icmp ugt i32 %5, %shr
  %or.cond645 = or i1 %cmp34, %cmp37.not
  br i1 %or.cond645, label %if.end333, label %if.then

if.then:                                          ; preds = %entry
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %mul50 = shl nsw i32 %0, 15
  %mul51 = shl nuw nsw i32 %5, 10
  %add52 = or disjoint i32 %mul11, %mul50
  %add54 = add nuw nsw i32 %add52, %mul51
  %6 = zext nneg i32 %add54 to i64
  %add.ptr61 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %6
  %7 = load i32, ptr addrspace(4) %add.ptr61, align 4, !tbaa !30
  %8 = or disjoint i64 %6, 2
  %add.ptr61.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %8
  %9 = load i32, ptr addrspace(4) %add.ptr61.1, align 4, !tbaa !30
  %10 = or disjoint i64 %6, 4
  %add.ptr61.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %10
  %11 = load i32, ptr addrspace(4) %add.ptr61.2, align 4, !tbaa !30
  %12 = or disjoint i64 %6, 6
  %add.ptr61.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %12
  %13 = load i32, ptr addrspace(4) %add.ptr61.3, align 4, !tbaa !30
  %14 = add nuw nsw i64 %6, 512
  %add.ptr61.1663 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %14
  %15 = load i32, ptr addrspace(4) %add.ptr61.1663, align 4, !tbaa !30
  %16 = add nuw nsw i64 %6, 514
  %add.ptr61.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %16
  %17 = load i32, ptr addrspace(4) %add.ptr61.1.1, align 4, !tbaa !30
  %18 = add nuw nsw i64 %6, 516
  %add.ptr61.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %18
  %19 = load i32, ptr addrspace(4) %add.ptr61.2.1, align 4, !tbaa !30
  %20 = add nuw nsw i64 %6, 518
  %add.ptr61.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %20
  %21 = load i32, ptr addrspace(4) %add.ptr61.3.1, align 4, !tbaa !30
  %add.ptr94 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %6
  %22 = load i32, ptr addrspace(4) %add.ptr94, align 4, !tbaa !30
  %add.ptr94.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %8
  %23 = load i32, ptr addrspace(4) %add.ptr94.1, align 4, !tbaa !30
  %add.ptr94.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %10
  %24 = load i32, ptr addrspace(4) %add.ptr94.2, align 4, !tbaa !30
  %add.ptr94.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %12
  %25 = load i32, ptr addrspace(4) %add.ptr94.3, align 4, !tbaa !30
  %add.ptr94.1675 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %14
  %26 = load i32, ptr addrspace(4) %add.ptr94.1675, align 4, !tbaa !30
  %add.ptr94.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %16
  %27 = load i32, ptr addrspace(4) %add.ptr94.1.1, align 4, !tbaa !30
  %add.ptr94.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %18
  %28 = load i32, ptr addrspace(4) %add.ptr94.2.1, align 4, !tbaa !30
  %add.ptr94.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %20
  %29 = load i32, ptr addrspace(4) %add.ptr94.3.1, align 4, !tbaa !30
  %mul118 = and i32 %mul11, 8128
  %xor592 = and i32 %mul11, 56
  %call121.masked = and i32 %2, 1016
  %mul123 = xor i32 %xor592, %call121.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul118
  %invariant.gep613 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul123
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep613, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !58
  %gep614.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 1024
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep614.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !call_argsrelate !58
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and135 = shl nuw nsw i32 %2, 6
  %mul136 = and i32 %and135, 960
  %shr139 = lshr i32 %2, 4
  %and142 = and i32 %2, 7
  %30 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul136
  %xor143 = xor i32 %shr139, %and142
  %add.ptr147.idx = shl nuw nsw i32 %xor143, 4
  %add.ptr147 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 %add.ptr147.idx
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr147, align 16
  %Q_reg.sroa.4.0.add.ptr147.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr147, i32 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr147.sroa_idx, align 8
  %add140.1 = add nuw nsw i32 %shr139, 4
  %xor143.1 = xor i32 %add140.1, %and142
  %add.ptr147.idx.1 = shl nuw nsw i32 %xor143.1, 4
  %add.ptr147.1 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 %add.ptr147.idx.1
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr147.1, align 16
  %Q_reg.sroa.7.16.add.ptr147.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr147.1, i32 8
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr147.1.sroa_idx, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  store i32 %7, ptr addrspace(3) %invariant.gep613, align 16, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep618.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 4
  store i32 %9, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep618.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep618.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 8
  store i32 %11, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep618.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep618.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 12
  store i32 %13, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep618.sroa_idx, align 4, !tbaa !30
  store i32 %15, ptr addrspace(3) %gep614.1, align 16, !tbaa !30
  %K_reg.sroa.9.16.gep619.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 1028
  store i32 %17, ptr addrspace(3) %K_reg.sroa.9.16.gep619.1.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.10.16.gep619.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 1032
  store i32 %19, ptr addrspace(3) %K_reg.sroa.10.16.gep619.1.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.11.16.gep619.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 1036
  store i32 %21, ptr addrspace(3) %K_reg.sroa.11.16.gep619.1.sroa_idx, align 4, !tbaa !30
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr147, align 16
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr147.sroa_idx, align 8
  %31 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer)
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %31)
  %kb.sroa.0.0.copyload705 = load <4 x half>, ptr addrspace(3) %add.ptr147.1, align 16
  %kb.sroa.6.0.copyload706 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr147.1.sroa_idx, align 8
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload705, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %32)
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload706, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %33)
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add.ptr239.idx = shl nuw nsw i32 %2, 4
  %invariant.gep626 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr239.idx
  store i32 %22, ptr addrspace(3) %invariant.gep626, align 16, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep626.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep626, i32 4
  store i32 %23, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep626.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep626.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep626, i32 8
  store i32 %24, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep626.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep626.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep626, i32 12
  store i32 %25, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep626.sroa_idx, align 4, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep626, i32 1024
  store i32 %26, ptr addrspace(3) %gep.1, align 16, !tbaa !30
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep626, i32 1028
  store i32 %27, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep626, i32 1032
  store i32 %28, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep626, i32 1036
  store i32 %29, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !tbaa !30
  %mul38 = shl nuw nsw i32 %5, 4
  %shr251 = shl nuw nsw i32 %5, 2
  %add252 = add nuw nsw i32 %shr251, %shr139
  %cmp253 = icmp ugt i32 %add252, 127
  %35 = lshr i32 %2, 2
  %mul257 = and i32 %35, 252
  %add259 = add nuw nsw i32 %mul38, %mul257
  %cmp262.not = icmp ugt i32 %add259, %1
  %or.cond646 = select i1 %cmp253, i1 true, i1 %cmp262.not
  br i1 %or.cond646, label %if.end, label %if.then263

if.then263:                                       ; preds = %if.then
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %34, i64 0
  %mul266 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %36 = tail call contract noundef float @llvm.minnum.f32(float %mul266, float 0x4024CB5EC0000000)
  %37 = tail call contract noundef float @llvm.exp.f32(float %36)
  br label %if.end

if.end:                                           ; preds = %if.then, %if.then263
  %condval.0 = phi float [ %37, %if.then263 ], [ 0.000000e+00, %if.then ]
  %cmp262.not.1 = icmp uge i32 %add259, %1
  %or.cond646.1 = select i1 %cmp253, i1 true, i1 %cmp262.not.1
  br i1 %or.cond646.1, label %if.end.1, label %if.then263.1

if.then263.1:                                     ; preds = %if.end
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %34, i64 1
  %mul266.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %38 = tail call contract noundef float @llvm.minnum.f32(float %mul266.1, float 0x4024CB5EC0000000)
  %39 = tail call contract noundef float @llvm.exp.f32(float %38)
  br label %if.end.1

if.end.1:                                         ; preds = %if.then263.1, %if.end
  %condval.0.1 = phi float [ %39, %if.then263.1 ], [ 0.000000e+00, %if.end ]
  %add260.2 = or disjoint i32 %add259, 2
  %cmp262.not.2 = icmp ugt i32 %add260.2, %1
  %or.cond646.2 = select i1 %cmp253, i1 true, i1 %cmp262.not.2
  br i1 %or.cond646.2, label %if.end.2, label %if.then263.2

if.then263.2:                                     ; preds = %if.end.1
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %34, i64 2
  %mul266.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul266.2, float 0x4024CB5EC0000000)
  %41 = tail call contract noundef float @llvm.exp.f32(float %40)
  br label %if.end.2

if.end.2:                                         ; preds = %if.then263.2, %if.end.1
  %condval.0.2 = phi float [ %41, %if.then263.2 ], [ 0.000000e+00, %if.end.1 ]
  %add260.3 = or disjoint i32 %add259, 3
  %cmp262.not.3 = icmp ugt i32 %add260.3, %1
  %or.cond646.3 = select i1 %cmp253, i1 true, i1 %cmp262.not.3
  br i1 %or.cond646.3, label %if.end.3, label %if.then263.3

if.then263.3:                                     ; preds = %if.end.2
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %34, i64 3
  %mul266.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %42 = tail call contract noundef float @llvm.minnum.f32(float %mul266.3, float 0x4024CB5EC0000000)
  %43 = tail call contract noundef float @llvm.exp.f32(float %42)
  br label %if.end.3

if.end.3:                                         ; preds = %if.then263.3, %if.end.2
  %condval.0.3 = phi float [ %43, %if.then263.3 ], [ 0.000000e+00, %if.end.2 ]
  %add282.1 = fadd contract float %condval.0, %condval.0.1
  %add282.2 = fadd contract float %add282.1, %condval.0.2
  %add282.3 = fadd contract float %add282.2, %condval.0.3
  %44 = bitcast float %add282.3 to i32
  %45 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %46 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %45) #11
  %xor.i.i = xor i32 %46, 32
  %47 = and i32 %46, -64
  %and.i.i = add nsw i32 %47, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %46
  %shl.i.i = shl i32 %cond.i.i, 2
  %48 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %44)
  %49 = bitcast i32 %48 to float
  %add290 = fadd contract float %add282.3, %49
  %50 = bitcast float %add290 to i32
  %51 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %52 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %51) #11
  %xor.i.i594 = xor i32 %52, 16
  %53 = and i32 %52, -64
  %and.i.i595 = add nsw i32 %53, 64
  %cmp.not.i.i596 = icmp slt i32 %xor.i.i594, %and.i.i595
  %cond.i.i597 = select i1 %cmp.not.i.i596, i32 %xor.i.i594, i32 %52
  %shl.i.i598 = shl i32 %cond.i.i597, 2
  %54 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i598, i32 %50)
  %55 = bitcast i32 %54 to float
  %add295 = fadd contract float %add290, %55
  %cmp298 = fcmp contract ogt float %add295, 0.000000e+00
  %cmp.i.i = fcmp contract olt float %add295, 0x39B0000000000000
  %cond.i.i599 = select contract i1 %cmp.i.i, float 0x4630000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %add295, %cond.i.i599
  %56 = tail call contract float @llvm.mxc.rsq.f32(float %mul.i.i)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x4310000000000000, float 1.000000e+00
  %mul3.i.i = fmul contract float %cond2.i.i, %56
  %mul304 = fmul contract float %mul3.i.i, %mul3.i.i
  %condval_1.0 = select i1 %cmp298, float %mul304, float 0.000000e+00
  %mul315 = fmul contract float %condval_1.0, %condval.0
  %mul315.1 = fmul contract float %condval_1.0, %condval.0.1
  %mul315.2 = fmul contract float %condval_1.0, %condval.0.2
  %mul315.3 = fmul contract float %condval_1.0, %condval.0.3
  %57 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul315)
  %58 = insertelement <4 x i16> poison, i16 %57, i64 0
  %59 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul315.1)
  %60 = insertelement <4 x i16> %58, i16 %59, i64 1
  %61 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul315.2)
  %62 = insertelement <4 x i16> %60, i16 %61, i64 2
  %63 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul315.3)
  %64 = insertelement <4 x i16> %62, i16 %63, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %64 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end333

if.end333:                                        ; preds = %if.end.3, %entry
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ undef, %entry ], [ %acc_s_cast.sroa.0.6.vec.insert, %if.end.3 ]
  br i1 %or.cond645, label %if.end403, label %for.cond355.preheader

for.cond355.preheader:                            ; preds = %if.end333
  %65 = shl nuw nsw i32 %2, 4
  %mul365 = and i32 %65, 16128
  %and371 = and i32 %2, 15
  %add372 = or disjoint i32 %mul365, %and371
  %arrayidx374 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372
  %66 = load half, ptr addrspace(3) %arrayidx374, align 2, !tbaa !161
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %66, i64 0
  %add367.1 = or disjoint i32 %mul365, %and371
  %add372.1 = or disjoint i32 %add367.1, 64
  %arrayidx374.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.1
  %67 = load half, ptr addrspace(3) %arrayidx374.1, align 2, !tbaa !161
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %67, i64 1
  %add367.2 = or disjoint i32 %mul365, %and371
  %add372.2 = or disjoint i32 %add367.2, 128
  %arrayidx374.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.2
  %68 = load half, ptr addrspace(3) %arrayidx374.2, align 2, !tbaa !161
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %68, i64 2
  %add367.3 = or disjoint i32 %mul365, %and371
  %add372.3 = or disjoint i32 %add367.3, 192
  %arrayidx374.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.3
  %69 = load half, ptr addrspace(3) %arrayidx374.3, align 2, !tbaa !161
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %69, i64 3
  %add369.1679 = or disjoint i32 %mul365, %and371
  %add372.1680 = or disjoint i32 %add369.1679, 16
  %arrayidx374.1681 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.1680
  %70 = load half, ptr addrspace(3) %arrayidx374.1681, align 2, !tbaa !161
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %70, i64 0
  %add369.1.1 = or disjoint i32 %mul365, %and371
  %add372.1.1 = or disjoint i32 %add369.1.1, 80
  %arrayidx374.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.1.1
  %71 = load half, ptr addrspace(3) %arrayidx374.1.1, align 2, !tbaa !161
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %71, i64 1
  %add369.2.1 = or disjoint i32 %mul365, %and371
  %add372.2.1 = or disjoint i32 %add369.2.1, 144
  %arrayidx374.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.2.1
  %72 = load half, ptr addrspace(3) %arrayidx374.2.1, align 2, !tbaa !161
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %72, i64 2
  %add369.3.1 = or disjoint i32 %mul365, %and371
  %add372.3.1 = or disjoint i32 %add369.3.1, 208
  %arrayidx374.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.3.1
  %73 = load half, ptr addrspace(3) %arrayidx374.3.1, align 2, !tbaa !161
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %73, i64 3
  %add369.2683 = or disjoint i32 %mul365, %and371
  %add372.2684 = or disjoint i32 %add369.2683, 32
  %arrayidx374.2685 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.2684
  %74 = load half, ptr addrspace(3) %arrayidx374.2685, align 2, !tbaa !161
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %74, i64 0
  %add369.1.2 = or disjoint i32 %mul365, %and371
  %add372.1.2 = or disjoint i32 %add369.1.2, 96
  %arrayidx374.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.1.2
  %75 = load half, ptr addrspace(3) %arrayidx374.1.2, align 2, !tbaa !161
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %75, i64 1
  %add369.2.2 = or disjoint i32 %mul365, %and371
  %add372.2.2 = or disjoint i32 %add369.2.2, 160
  %arrayidx374.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.2.2
  %76 = load half, ptr addrspace(3) %arrayidx374.2.2, align 2, !tbaa !161
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %76, i64 2
  %add369.3.2 = or disjoint i32 %mul365, %and371
  %add372.3.2 = or disjoint i32 %add369.3.2, 224
  %arrayidx374.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.3.2
  %77 = load half, ptr addrspace(3) %arrayidx374.3.2, align 2, !tbaa !161
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %77, i64 3
  %add369.3687 = or disjoint i32 %mul365, %and371
  %add372.3688 = or disjoint i32 %add369.3687, 48
  %arrayidx374.3689 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.3688
  %78 = load half, ptr addrspace(3) %arrayidx374.3689, align 2, !tbaa !161
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %78, i64 0
  %add369.1.3 = or disjoint i32 %mul365, %and371
  %add372.1.3 = or disjoint i32 %add369.1.3, 112
  %arrayidx374.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.1.3
  %79 = load half, ptr addrspace(3) %arrayidx374.1.3, align 2, !tbaa !161
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %79, i64 1
  %add369.2.3 = or disjoint i32 %mul365, %and371
  %add372.2.3 = or disjoint i32 %add369.2.3, 176
  %arrayidx374.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.2.3
  %80 = load half, ptr addrspace(3) %arrayidx374.2.3, align 2, !tbaa !161
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %80, i64 2
  %add369.3.3 = or disjoint i32 %65, %and371
  %add372.3.3 = or i32 %add369.3.3, 240
  %arrayidx374.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.3.3
  %81 = load half, ptr addrspace(3) %arrayidx374.3.3, align 2, !tbaa !161
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %81, i64 3
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %83 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %84 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %85 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  br label %if.end403

if.end403:                                        ; preds = %for.cond355.preheader, %if.end333
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end333 ], [ %82, %for.cond355.preheader ]
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end333 ], [ %83, %for.cond355.preheader ]
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end333 ], [ %84, %for.cond355.preheader ]
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end333 ], [ %85, %for.cond355.preheader ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract)
  %O_reg.sroa.0.0.insert.ext = zext i16 %86 to i64
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract)
  %O_reg.sroa.0.2.insert.ext = zext i16 %87 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract)
  %O_reg.sroa.0.4.insert.ext = zext i16 %88 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract)
  %O_reg.sroa.0.6.insert.ext = zext i16 %89 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract)
  %O_reg.sroa.7.8.insert.ext = zext i16 %90 to i64
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract)
  %O_reg.sroa.7.10.insert.ext = zext i16 %91 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract)
  %O_reg.sroa.7.12.insert.ext = zext i16 %92 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3
  %93 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract)
  %O_reg.sroa.7.14.insert.ext = zext i16 %93 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0
  %94 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract)
  %O_reg.sroa.12.16.insert.ext = zext i16 %94 to i64
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1
  %95 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract)
  %O_reg.sroa.12.18.insert.ext = zext i16 %95 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2
  %96 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract)
  %O_reg.sroa.12.20.insert.ext = zext i16 %96 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3
  %97 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract)
  %O_reg.sroa.12.22.insert.ext = zext i16 %97 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract)
  %O_reg.sroa.17.24.insert.ext = zext i16 %98 to i64
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1
  %99 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract)
  %O_reg.sroa.17.26.insert.ext = zext i16 %99 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2
  %100 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract)
  %O_reg.sroa.17.28.insert.ext = zext i16 %100 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3
  %101 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract)
  %O_reg.sroa.17.30.insert.ext = zext i16 %101 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and436 = shl nuw nsw i32 %2, 6
  %mul437 = and i32 %and436, 960
  %shr440 = lshr i32 %2, 5
  %and443 = and i32 %2, 7
  %102 = lshr i32 %2, 2
  %mul450 = and i32 %102, 4
  %xor444 = xor i32 %shr440, %and443
  %mul445 = shl nuw nsw i32 %xor444, 3
  %add446 = add nuw nsw i32 %mul445, %mul437
  %add451 = or disjoint i32 %add446, %mul450
  %add.ptr453 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add451
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr453, align 8
  %add441.1 = add nuw nsw i32 %shr440, 2
  %xor444.1 = xor i32 %add441.1, %and443
  %mul445.1 = shl nuw nsw i32 %xor444.1, 3
  %add446.1 = add nuw nsw i32 %mul445.1, %mul437
  %add451.1 = or disjoint i32 %add446.1, %mul450
  %add.ptr453.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add451.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr453.1, align 8
  %add441.2 = add nuw nsw i32 %shr440, 4
  %xor444.2 = xor i32 %add441.2, %and443
  %mul445.2 = shl nuw nsw i32 %xor444.2, 3
  %add446.2 = add nuw nsw i32 %mul445.2, %mul437
  %add451.2 = or disjoint i32 %add446.2, %mul450
  %add.ptr453.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add451.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr453.2, align 8
  %add441.3 = add nuw nsw i32 %shr440, 6
  %xor444.3 = xor i32 %add441.3, %and443
  %mul445.3 = shl nuw nsw i32 %xor444.3, 3
  %add446.3 = add nuw nsw i32 %mul445.3, %mul437
  %add451.3 = or disjoint i32 %add446.3, %mul450
  %add.ptr453.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add451.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr453.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul464 = and i32 %mul11, 8128
  %xor470588 = and i32 %mul11, 56
  %call468.masked = and i32 %2, 1016
  %mul471 = xor i32 %xor470588, %call468.masked
  %invariant.gep640 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul464
  %invariant.gep642 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep640, i32 %mul471
  %add.ptr486 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr486, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep642, i64 16, i1 false), !tbaa.struct !190, !call_argsrelate !191
  %gep643.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep642, i32 1024
  %add.ptr486.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr486.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep643.1, i64 16, i1 false), !tbaa.struct !190, !call_argsrelate !191
  ret void
}

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

declare i32 @llvm.mxc.block.id.x() #5

declare i32 @llvm.mxc.block.id.y() #5

declare i32 @llvm.mxc.block.id.z() #5

declare i32 @llvm.mxc.thread.id.x() #5

declare void @llvm.mxc.barrier.warp() #6

declare float @llvm.exp.f32(float) #7

declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

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
attributes #11 = { nomerge }


