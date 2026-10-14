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
  %or.cond700 = or i1 %cmp34, %cmp37.not
  br i1 %or.cond700, label %if.else482, label %if.then

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
  %add.ptr61.1718 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %14
  %15 = load i32, ptr addrspace(4) %add.ptr61.1718, align 4, !tbaa !30
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
  %add.ptr94.1730 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %14
  %26 = load i32, ptr addrspace(4) %add.ptr94.1730, align 4, !tbaa !30
  %add.ptr94.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %16
  %27 = load i32, ptr addrspace(4) %add.ptr94.1.1, align 4, !tbaa !30
  %add.ptr94.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %18
  %28 = load i32, ptr addrspace(4) %add.ptr94.2.1, align 4, !tbaa !30
  %add.ptr94.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %20
  %29 = load i32, ptr addrspace(4) %add.ptr94.3.1, align 4, !tbaa !30
  %mul118 = and i32 %mul11, 8128
  %xor624 = and i32 %mul11, 56
  %call121.masked = and i32 %2, 1016
  %mul123 = xor i32 %xor624, %call121.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul118
  %invariant.gep657 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul123
  %invariant.gep659 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep657, i32 2048
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep659, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !58
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep657, i32 3072
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !call_argsrelate !58
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and136 = shl nuw nsw i32 %2, 6
  %mul137 = and i32 %and136, 960
  %shr140 = lshr i32 %2, 4
  %and143 = and i32 %2, 7
  %30 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul137
  %invariant.gep661 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 2048
  %xor144 = xor i32 %shr140, %and143
  %.idx648 = shl nuw nsw i32 %xor144, 4
  %gep662 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep661, i32 %.idx648
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %gep662, align 16
  %Q_reg.sroa.4.0.gep662.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep662, i32 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.gep662.sroa_idx, align 8
  %add141.1 = add nuw nsw i32 %shr140, 4
  %xor144.1 = xor i32 %add141.1, %and143
  %.idx648.1 = shl nuw nsw i32 %xor144.1, 4
  %gep662.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep661, i32 %.idx648.1
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %gep662.1, align 16
  %Q_reg.sroa.7.16.gep662.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep662.1, i32 8
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.gep662.1.sroa_idx, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %invariant.gep668 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep657, i32 4096
  store i32 %7, ptr addrspace(3) %invariant.gep668, align 16, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep668.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep657, i32 4100
  store i32 %9, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep668.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep668.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep657, i32 4104
  store i32 %11, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep668.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep668.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep657, i32 4108
  store i32 %13, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep668.sroa_idx, align 4, !tbaa !30
  %gep669.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep657, i32 5120
  store i32 %15, ptr addrspace(3) %gep669.1, align 16, !tbaa !30
  %K_reg.sroa.9.16.gep669.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep657, i32 5124
  store i32 %17, ptr addrspace(3) %K_reg.sroa.9.16.gep669.1.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.10.16.gep669.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep657, i32 5128
  store i32 %19, ptr addrspace(3) %K_reg.sroa.10.16.gep669.1.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.11.16.gep669.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep657, i32 5132
  store i32 %21, ptr addrspace(3) %K_reg.sroa.11.16.gep669.1.sroa_idx, align 4, !tbaa !30
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %31 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %.idx648
  %32 = getelementptr inbounds %struct.__half, ptr addrspace(3) %31, i32 %mul137
  %add.ptr205 = getelementptr inbounds i8, ptr addrspace(3) %32, i32 4096
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr205, align 16
  %kb.sroa.6.0.add.ptr205.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %32, i32 4104
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr205.sroa_idx, align 8
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer)
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %33)
  %35 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %.idx648.1
  %36 = getelementptr inbounds %struct.__half, ptr addrspace(3) %35, i32 %mul137
  %add.ptr205.1 = getelementptr inbounds i8, ptr addrspace(3) %36, i32 4096
  %kb.sroa.0.0.copyload763 = load <4 x half>, ptr addrspace(3) %add.ptr205.1, align 16
  %kb.sroa.6.0.add.ptr205.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %36, i32 4104
  %kb.sroa.6.0.copyload764 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr205.1.sroa_idx, align 8
  %37 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload763, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %34)
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload764, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %37)
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %.idx646 = shl nuw nsw i32 %2, 4
  %invariant.gep676 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %.idx646
  %invariant.gep678 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep676, i32 4096
  store i32 %22, ptr addrspace(3) %invariant.gep678, align 16, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep678.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep676, i32 4100
  store i32 %23, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep678.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep678.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep676, i32 4104
  store i32 %24, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep678.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep678.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep676, i32 4108
  store i32 %25, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep678.sroa_idx, align 4, !tbaa !30
  %gep679.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep676, i32 5120
  store i32 %26, ptr addrspace(3) %gep679.1, align 16, !tbaa !30
  %V_reg.sroa.9.16.gep679.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep676, i32 5124
  store i32 %27, ptr addrspace(3) %V_reg.sroa.9.16.gep679.1.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.10.16.gep679.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep676, i32 5128
  store i32 %28, ptr addrspace(3) %V_reg.sroa.10.16.gep679.1.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.11.16.gep679.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep676, i32 5132
  store i32 %29, ptr addrspace(3) %V_reg.sroa.11.16.gep679.1.sroa_idx, align 4, !tbaa !30
  %mul38 = shl nuw nsw i32 %5, 4
  %shr256 = shl nuw nsw i32 %5, 2
  %add257 = add nuw nsw i32 %shr256, %shr140
  %cmp258 = icmp ugt i32 %add257, 127
  %39 = lshr i32 %2, 2
  %mul262 = and i32 %39, 252
  %add264 = add nuw nsw i32 %mul38, %mul262
  %cmp267.not = icmp ugt i32 %add264, %1
  %or.cond701 = select i1 %cmp258, i1 true, i1 %cmp267.not
  br i1 %or.cond701, label %if.end, label %if.then268

if.then268:                                       ; preds = %if.then
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %38, i64 0
  %mul271 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul271, float 0x4024CB5EC0000000)
  %41 = tail call contract noundef float @llvm.exp.f32(float %40)
  br label %if.end

if.end:                                           ; preds = %if.then, %if.then268
  %condval.0 = phi float [ %41, %if.then268 ], [ 0.000000e+00, %if.then ]
  %cmp267.not.1 = icmp uge i32 %add264, %1
  %or.cond701.1 = select i1 %cmp258, i1 true, i1 %cmp267.not.1
  br i1 %or.cond701.1, label %if.end.1, label %if.then268.1

if.then268.1:                                     ; preds = %if.end
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %38, i64 1
  %mul271.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %42 = tail call contract noundef float @llvm.minnum.f32(float %mul271.1, float 0x4024CB5EC0000000)
  %43 = tail call contract noundef float @llvm.exp.f32(float %42)
  br label %if.end.1

if.end.1:                                         ; preds = %if.then268.1, %if.end
  %condval.0.1 = phi float [ %43, %if.then268.1 ], [ 0.000000e+00, %if.end ]
  %add265.2 = or disjoint i32 %add264, 2
  %cmp267.not.2 = icmp ugt i32 %add265.2, %1
  %or.cond701.2 = select i1 %cmp258, i1 true, i1 %cmp267.not.2
  br i1 %or.cond701.2, label %if.end.2, label %if.then268.2

if.then268.2:                                     ; preds = %if.end.1
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %38, i64 2
  %mul271.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %44 = tail call contract noundef float @llvm.minnum.f32(float %mul271.2, float 0x4024CB5EC0000000)
  %45 = tail call contract noundef float @llvm.exp.f32(float %44)
  br label %if.end.2

if.end.2:                                         ; preds = %if.then268.2, %if.end.1
  %condval.0.2 = phi float [ %45, %if.then268.2 ], [ 0.000000e+00, %if.end.1 ]
  %add265.3 = or disjoint i32 %add264, 3
  %cmp267.not.3 = icmp ugt i32 %add265.3, %1
  %or.cond701.3 = select i1 %cmp258, i1 true, i1 %cmp267.not.3
  br i1 %or.cond701.3, label %if.end.3, label %if.then268.3

if.then268.3:                                     ; preds = %if.end.2
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %38, i64 3
  %mul271.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %46 = tail call contract noundef float @llvm.minnum.f32(float %mul271.3, float 0x4024CB5EC0000000)
  %47 = tail call contract noundef float @llvm.exp.f32(float %46)
  br label %if.end.3

if.end.3:                                         ; preds = %if.then268.3, %if.end.2
  %condval.0.3 = phi float [ %47, %if.then268.3 ], [ 0.000000e+00, %if.end.2 ]
  %add287.1 = fadd contract float %condval.0, %condval.0.1
  %add287.2 = fadd contract float %add287.1, %condval.0.2
  %add287.3 = fadd contract float %add287.2, %condval.0.3
  %48 = bitcast float %add287.3 to i32
  %49 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %50 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %49) #11
  %xor.i.i = xor i32 %50, 32
  %51 = and i32 %50, -64
  %and.i.i = add nsw i32 %51, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %50
  %shl.i.i = shl i32 %cond.i.i, 2
  %52 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %48)
  %53 = bitcast i32 %52 to float
  %add295 = fadd contract float %add287.3, %53
  %54 = bitcast float %add295 to i32
  %55 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %56 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %55) #11
  %xor.i.i638 = xor i32 %56, 16
  %57 = and i32 %56, -64
  %and.i.i639 = add nsw i32 %57, 64
  %cmp.not.i.i640 = icmp slt i32 %xor.i.i638, %and.i.i639
  %cond.i.i641 = select i1 %cmp.not.i.i640, i32 %xor.i.i638, i32 %56
  %shl.i.i642 = shl i32 %cond.i.i641, 2
  %58 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i642, i32 %54)
  %59 = bitcast i32 %58 to float
  %add300 = fadd contract float %add295, %59
  %cmp303 = fcmp contract ogt float %add300, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add300
  %condval_1.0 = select i1 %cmp303, float %div, float 0.000000e+00
  %mul316 = fmul contract float %condval_1.0, %condval.0
  %mul316.1 = fmul contract float %condval_1.0, %condval.0.1
  %mul316.2 = fmul contract float %condval_1.0, %condval.0.2
  %mul316.3 = fmul contract float %condval_1.0, %condval.0.3
  %60 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul316)
  %61 = insertelement <4 x i16> poison, i16 %60, i64 0
  %62 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul316.1)
  %63 = insertelement <4 x i16> %61, i16 %62, i64 1
  %64 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul316.2)
  %65 = insertelement <4 x i16> %63, i16 %64, i64 2
  %66 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul316.3)
  %67 = insertelement <4 x i16> %65, i16 %66, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %67 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul357 = and i32 %.idx646, 16128
  %and363 = and i32 %2, 15
  %add364 = or disjoint i32 %mul357, %and363
  %gep687 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %add364
  %68 = load half, ptr addrspace(3) %gep687, align 2, !tbaa !163
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %68, i64 0
  %add359.1 = or disjoint i32 %mul357, %and363
  %add364.1 = or disjoint i32 %add359.1, 64
  %gep687.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %add364.1
  %69 = load half, ptr addrspace(3) %gep687.1, align 2, !tbaa !163
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %69, i64 1
  %add359.2 = or disjoint i32 %mul357, %and363
  %add364.2 = or disjoint i32 %add359.2, 128
  %gep687.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %add364.2
  %70 = load half, ptr addrspace(3) %gep687.2, align 2, !tbaa !163
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %70, i64 2
  %add359.3 = or disjoint i32 %mul357, %and363
  %add364.3 = or disjoint i32 %add359.3, 192
  %gep687.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %add364.3
  %71 = load half, ptr addrspace(3) %gep687.3, align 2, !tbaa !163
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %71, i64 3
  %add361.1734 = or disjoint i32 %mul357, %and363
  %add364.1735 = or disjoint i32 %add361.1734, 16
  %gep687.1736 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %add364.1735
  %72 = load half, ptr addrspace(3) %gep687.1736, align 2, !tbaa !163
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %72, i64 0
  %add361.1.1 = or disjoint i32 %mul357, %and363
  %add364.1.1 = or disjoint i32 %add361.1.1, 80
  %gep687.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %add364.1.1
  %73 = load half, ptr addrspace(3) %gep687.1.1, align 2, !tbaa !163
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %73, i64 1
  %add361.2.1 = or disjoint i32 %mul357, %and363
  %add364.2.1 = or disjoint i32 %add361.2.1, 144
  %gep687.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %add364.2.1
  %74 = load half, ptr addrspace(3) %gep687.2.1, align 2, !tbaa !163
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %74, i64 2
  %add361.3.1 = or disjoint i32 %mul357, %and363
  %add364.3.1 = or disjoint i32 %add361.3.1, 208
  %gep687.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %add364.3.1
  %75 = load half, ptr addrspace(3) %gep687.3.1, align 2, !tbaa !163
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %75, i64 3
  %add361.2738 = or disjoint i32 %mul357, %and363
  %add364.2739 = or disjoint i32 %add361.2738, 32
  %gep687.2740 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %add364.2739
  %76 = load half, ptr addrspace(3) %gep687.2740, align 2, !tbaa !163
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %76, i64 0
  %add361.1.2 = or disjoint i32 %mul357, %and363
  %add364.1.2 = or disjoint i32 %add361.1.2, 96
  %gep687.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %add364.1.2
  %77 = load half, ptr addrspace(3) %gep687.1.2, align 2, !tbaa !163
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %77, i64 1
  %add361.2.2 = or disjoint i32 %mul357, %and363
  %add364.2.2 = or disjoint i32 %add361.2.2, 160
  %gep687.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %add364.2.2
  %78 = load half, ptr addrspace(3) %gep687.2.2, align 2, !tbaa !163
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %78, i64 2
  %add361.3.2 = or disjoint i32 %mul357, %and363
  %add364.3.2 = or disjoint i32 %add361.3.2, 224
  %gep687.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %add364.3.2
  %79 = load half, ptr addrspace(3) %gep687.3.2, align 2, !tbaa !163
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %79, i64 3
  %add361.3742 = or disjoint i32 %mul357, %and363
  %add364.3743 = or disjoint i32 %add361.3742, 48
  %gep687.3744 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %add364.3743
  %80 = load half, ptr addrspace(3) %gep687.3744, align 2, !tbaa !163
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %80, i64 0
  %add361.1.3 = or disjoint i32 %mul357, %and363
  %add364.1.3 = or disjoint i32 %add361.1.3, 112
  %gep687.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %add364.1.3
  %81 = load half, ptr addrspace(3) %gep687.1.3, align 2, !tbaa !163
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %81, i64 1
  %add361.2.3 = or disjoint i32 %mul357, %and363
  %add364.2.3 = or disjoint i32 %add361.2.3, 176
  %gep687.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %add364.2.3
  %82 = load half, ptr addrspace(3) %gep687.2.3, align 2, !tbaa !163
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %82, i64 2
  %add361.3.3 = or disjoint i32 %.idx646, %and363
  %add364.3.3 = or i32 %add361.3.3, 240
  %gep687.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %add364.3.3
  %83 = load half, ptr addrspace(3) %gep687.3.3, align 2, !tbaa !163
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %83, i64 3
  %84 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %85 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %87 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %84, i64 0
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract)
  %O_reg.sroa.0.0.insert.ext = zext i16 %88 to i64
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %84, i64 1
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract)
  %O_reg.sroa.0.2.insert.ext = zext i16 %89 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %84, i64 2
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract)
  %O_reg.sroa.0.4.insert.ext = zext i16 %90 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %84, i64 3
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract)
  %O_reg.sroa.0.6.insert.ext = zext i16 %91 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %85, i64 0
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract)
  %O_reg.sroa.7.8.insert.ext = zext i16 %92 to i64
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %85, i64 1
  %93 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract)
  %O_reg.sroa.7.10.insert.ext = zext i16 %93 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %85, i64 2
  %94 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract)
  %O_reg.sroa.7.12.insert.ext = zext i16 %94 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %85, i64 3
  %95 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract)
  %O_reg.sroa.7.14.insert.ext = zext i16 %95 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %86, i64 0
  %96 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract)
  %O_reg.sroa.12.16.insert.ext = zext i16 %96 to i64
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %86, i64 1
  %97 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract)
  %O_reg.sroa.12.18.insert.ext = zext i16 %97 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %86, i64 2
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract)
  %O_reg.sroa.12.20.insert.ext = zext i16 %98 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %86, i64 3
  %99 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract)
  %O_reg.sroa.12.22.insert.ext = zext i16 %99 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %87, i64 0
  %100 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract)
  %O_reg.sroa.17.24.insert.ext = zext i16 %100 to i64
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %87, i64 1
  %101 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract)
  %O_reg.sroa.17.26.insert.ext = zext i16 %101 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %87, i64 2
  %102 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract)
  %O_reg.sroa.17.28.insert.ext = zext i16 %102 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %87, i64 3
  %103 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract)
  %O_reg.sroa.17.30.insert.ext = zext i16 %103 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %shr432 = lshr i32 %2, 5
  %mul442 = and i32 %39, 4
  %xor436 = xor i32 %shr432, %and143
  %mul437 = shl nuw nsw i32 %xor436, 3
  %add438 = add nuw nsw i32 %mul437, %mul137
  %add443 = or disjoint i32 %add438, %mul442
  %add.ptr445 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add443
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr445, align 8
  %add433.1 = add nuw nsw i32 %shr432, 2
  %xor436.1 = xor i32 %add433.1, %and143
  %mul437.1 = shl nuw nsw i32 %xor436.1, 3
  %add438.1 = add nuw nsw i32 %mul437.1, %mul137
  %add443.1 = or disjoint i32 %add438.1, %mul442
  %add.ptr445.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add443.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr445.1, align 8
  %add433.2 = add nuw nsw i32 %shr432, 4
  %xor436.2 = xor i32 %add433.2, %and143
  %mul437.2 = shl nuw nsw i32 %xor436.2, 3
  %add438.2 = add nuw nsw i32 %mul437.2, %mul137
  %add443.2 = or disjoint i32 %add438.2, %mul442
  %add.ptr445.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add443.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr445.2, align 8
  %add433.3 = add nuw nsw i32 %shr432, 6
  %xor436.3 = xor i32 %add433.3, %and143
  %mul437.3 = shl nuw nsw i32 %xor436.3, 3
  %add438.3 = add nuw nsw i32 %mul437.3, %mul137
  %add443.3 = or disjoint i32 %add438.3, %mul442
  %add.ptr445.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add443.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr445.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add.ptr478 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr478, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep657, i64 16, i1 false), !tbaa.struct !190, !call_argsrelate !191
  %gep697.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep657, i32 1024
  %add.ptr478.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr478.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep697.1, i64 16, i1 false), !tbaa.struct !190, !call_argsrelate !191
  br label %if.end522

if.else482:                                       ; preds = %entry
  %add.ptr518 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3
  store i32 0, ptr addrspace(1) %add.ptr518, align 16, !tbaa !30
  %ref.tmp487.sroa.4.0.add.ptr518.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr518, i64 4
  store i32 0, ptr addrspace(1) %ref.tmp487.sroa.4.0.add.ptr518.sroa_idx, align 4, !tbaa !30
  %ref.tmp487.sroa.5.0.add.ptr518.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr518, i64 8
  store i32 0, ptr addrspace(1) %ref.tmp487.sroa.5.0.add.ptr518.sroa_idx, align 8, !tbaa !30
  %ref.tmp487.sroa.6.0.add.ptr518.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr518, i64 12
  store i32 0, ptr addrspace(1) %ref.tmp487.sroa.6.0.add.ptr518.sroa_idx, align 4, !tbaa !30
  %add.ptr518.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4
  store i32 0, ptr addrspace(1) %add.ptr518.1, align 16, !tbaa !30
  %ref.tmp487.sroa.4.0.add.ptr518.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(1) %add.ptr518.1, i64 4
  store i32 0, ptr addrspace(1) %ref.tmp487.sroa.4.0.add.ptr518.sroa_idx.1, align 4, !tbaa !30
  %ref.tmp487.sroa.5.0.add.ptr518.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(1) %add.ptr518.1, i64 8
  store i32 0, ptr addrspace(1) %ref.tmp487.sroa.5.0.add.ptr518.sroa_idx.1, align 8, !tbaa !30
  %ref.tmp487.sroa.6.0.add.ptr518.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(1) %add.ptr518.1, i64 12
  store i32 0, ptr addrspace(1) %ref.tmp487.sroa.6.0.add.ptr518.sroa_idx.1, align 4, !tbaa !30
  br label %if.end522

if.end522:                                        ; preds = %if.end.3, %if.else482
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


