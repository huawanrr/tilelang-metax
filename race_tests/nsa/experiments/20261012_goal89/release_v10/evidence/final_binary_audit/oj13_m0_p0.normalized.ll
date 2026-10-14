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
  %mul = shl nsw i32 %0, 11
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul7 = shl nsw i32 %1, 10
  %add = add nuw nsw i32 %mul, %mul7
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %mul11 = shl nuw nsw i32 %2, 3
  %add9 = add nuw nsw i32 %add, %mul11
  %3 = zext nneg i32 %add9 to i64
  %4 = add nuw nsw i64 %3, 512
  %mul17 = shl nuw nsw i32 %0, 1
  %add19 = add nuw nsw i32 %mul17, %1
  %idxprom = zext nneg i32 %add19 to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom
  %5 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cmp34 = icmp ugt i32 %5, 15
  %shr = lshr i32 %0, 4
  %cmp37.not = icmp ugt i32 %5, %shr
  %or.cond644 = or i1 %cmp34, %cmp37.not
  br i1 %or.cond644, label %if.end339, label %if.then

if.then:                                          ; preds = %entry
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %mul49 = shl nuw nsw i32 %5, 11
  %6 = shl nuw nsw i32 %2, 4
  %mul54 = and i32 %6, 16256
  %mul57 = shl nsw i32 %1, 6
  %add51 = add nuw nsw i32 %mul54, %mul57
  %mul60 = and i32 %mul11, 56
  %add55 = or disjoint i32 %add51, %mul60
  %add58 = add nuw nsw i32 %add55, %mul49
  %7 = zext nneg i32 %add58 to i64
  %add.ptr65 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %7
  %8 = load i32, ptr addrspace(4) %add.ptr65, align 4, !tbaa !30
  %9 = or disjoint i64 %7, 2
  %add.ptr65.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %9
  %10 = load i32, ptr addrspace(4) %add.ptr65.1, align 4, !tbaa !30
  %11 = or disjoint i64 %7, 4
  %add.ptr65.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %11
  %12 = load i32, ptr addrspace(4) %add.ptr65.2, align 4, !tbaa !30
  %13 = or disjoint i64 %7, 6
  %add.ptr65.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %13
  %14 = load i32, ptr addrspace(4) %add.ptr65.3, align 4, !tbaa !30
  %15 = add nuw nsw i64 %7, 1024
  %add.ptr65.1662 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %15
  %16 = load i32, ptr addrspace(4) %add.ptr65.1662, align 4, !tbaa !30
  %17 = add nuw nsw i64 %7, 1026
  %add.ptr65.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %17
  %18 = load i32, ptr addrspace(4) %add.ptr65.1.1, align 4, !tbaa !30
  %19 = add nuw nsw i64 %7, 1028
  %add.ptr65.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %19
  %20 = load i32, ptr addrspace(4) %add.ptr65.2.1, align 4, !tbaa !30
  %21 = add nuw nsw i64 %7, 1030
  %add.ptr65.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %21
  %22 = load i32, ptr addrspace(4) %add.ptr65.3.1, align 4, !tbaa !30
  %add.ptr103 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %7
  %23 = load i32, ptr addrspace(4) %add.ptr103, align 4, !tbaa !30
  %add.ptr103.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %9
  %24 = load i32, ptr addrspace(4) %add.ptr103.1, align 4, !tbaa !30
  %add.ptr103.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %11
  %25 = load i32, ptr addrspace(4) %add.ptr103.2, align 4, !tbaa !30
  %add.ptr103.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %13
  %26 = load i32, ptr addrspace(4) %add.ptr103.3, align 4, !tbaa !30
  %add.ptr103.1674 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %15
  %27 = load i32, ptr addrspace(4) %add.ptr103.1674, align 4, !tbaa !30
  %add.ptr103.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %17
  %28 = load i32, ptr addrspace(4) %add.ptr103.1.1, align 4, !tbaa !30
  %add.ptr103.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %19
  %29 = load i32, ptr addrspace(4) %add.ptr103.2.1, align 4, !tbaa !30
  %add.ptr103.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %21
  %30 = load i32, ptr addrspace(4) %add.ptr103.3.1, align 4, !tbaa !30
  %mul127 = and i32 %mul11, 8128
  %call131.masked = and i32 %2, 1016
  %mul133 = xor i32 %mul60, %call131.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul127
  %invariant.gep612 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul133
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep612, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !58
  %gep613.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 1024
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep613.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !call_argsrelate !58
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and145 = shl nuw nsw i32 %2, 6
  %mul146 = and i32 %and145, 960
  %shr149 = lshr i32 %2, 4
  %and152 = and i32 %2, 7
  %31 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul146
  %xor153 = xor i32 %shr149, %and152
  %add.ptr157.idx = shl nuw nsw i32 %xor153, 4
  %add.ptr157 = getelementptr inbounds i8, ptr addrspace(3) %31, i32 %add.ptr157.idx
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr157, align 16
  %Q_reg.sroa.4.0.add.ptr157.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157, i32 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr157.sroa_idx, align 8
  %add150.1 = add nuw nsw i32 %shr149, 4
  %xor153.1 = xor i32 %add150.1, %and152
  %add.ptr157.idx.1 = shl nuw nsw i32 %xor153.1, 4
  %add.ptr157.1 = getelementptr inbounds i8, ptr addrspace(3) %31, i32 %add.ptr157.idx.1
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr157.1, align 16
  %Q_reg.sroa.7.16.add.ptr157.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.1, i32 8
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr157.1.sroa_idx, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  store i32 %8, ptr addrspace(3) %invariant.gep612, align 16, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep617.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 4
  store i32 %10, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep617.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep617.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 8
  store i32 %12, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep617.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep617.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 12
  store i32 %14, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep617.sroa_idx, align 4, !tbaa !30
  store i32 %16, ptr addrspace(3) %gep613.1, align 16, !tbaa !30
  %K_reg.sroa.9.16.gep618.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 1028
  store i32 %18, ptr addrspace(3) %K_reg.sroa.9.16.gep618.1.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.10.16.gep618.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 1032
  store i32 %20, ptr addrspace(3) %K_reg.sroa.10.16.gep618.1.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.11.16.gep618.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 1036
  store i32 %22, ptr addrspace(3) %K_reg.sroa.11.16.gep618.1.sroa_idx, align 4, !tbaa !30
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr157, align 16
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr157.sroa_idx, align 8
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer)
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %32)
  %kb.sroa.0.0.copyload704 = load <4 x half>, ptr addrspace(3) %add.ptr157.1, align 16
  %kb.sroa.6.0.copyload705 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr157.1.sroa_idx, align 8
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload704, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %33)
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload705, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %34)
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %invariant.gep625 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %6
  store i32 %23, ptr addrspace(3) %invariant.gep625, align 16, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep625.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep625, i32 4
  store i32 %24, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep625.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep625.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep625, i32 8
  store i32 %25, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep625.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep625.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep625, i32 12
  store i32 %26, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep625.sroa_idx, align 4, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep625, i32 1024
  store i32 %27, ptr addrspace(3) %gep.1, align 16, !tbaa !30
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep625, i32 1028
  store i32 %28, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep625, i32 1032
  store i32 %29, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep625, i32 1036
  store i32 %30, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !tbaa !30
  %mul38 = shl nuw nsw i32 %5, 4
  %shr261 = shl nuw nsw i32 %5, 2
  %add262 = add nuw nsw i32 %shr261, %shr149
  %cmp263 = icmp ugt i32 %add262, 63
  %36 = lshr i32 %2, 2
  %mul267 = and i32 %36, 252
  %add269 = add nuw nsw i32 %mul38, %mul267
  %cmp272.not = icmp ugt i32 %add269, %0
  %or.cond645 = select i1 %cmp263, i1 true, i1 %cmp272.not
  br i1 %or.cond645, label %if.end, label %if.then273

if.then273:                                       ; preds = %if.then
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %35, i64 0
  %mul276 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %37 = tail call contract noundef float @llvm.minnum.f32(float %mul276, float 0x4024CB5EC0000000)
  %38 = tail call contract noundef float @llvm.exp.f32(float %37)
  br label %if.end

if.end:                                           ; preds = %if.then, %if.then273
  %condval.0 = phi float [ %38, %if.then273 ], [ 0.000000e+00, %if.then ]
  %cmp272.not.1 = icmp uge i32 %add269, %0
  %or.cond645.1 = select i1 %cmp263, i1 true, i1 %cmp272.not.1
  br i1 %or.cond645.1, label %if.end.1, label %if.then273.1

if.then273.1:                                     ; preds = %if.end
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %35, i64 1
  %mul276.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %39 = tail call contract noundef float @llvm.minnum.f32(float %mul276.1, float 0x4024CB5EC0000000)
  %40 = tail call contract noundef float @llvm.exp.f32(float %39)
  br label %if.end.1

if.end.1:                                         ; preds = %if.then273.1, %if.end
  %condval.0.1 = phi float [ %40, %if.then273.1 ], [ 0.000000e+00, %if.end ]
  %add270.2 = or disjoint i32 %add269, 2
  %cmp272.not.2 = icmp ugt i32 %add270.2, %0
  %or.cond645.2 = select i1 %cmp263, i1 true, i1 %cmp272.not.2
  br i1 %or.cond645.2, label %if.end.2, label %if.then273.2

if.then273.2:                                     ; preds = %if.end.1
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %35, i64 2
  %mul276.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %41 = tail call contract noundef float @llvm.minnum.f32(float %mul276.2, float 0x4024CB5EC0000000)
  %42 = tail call contract noundef float @llvm.exp.f32(float %41)
  br label %if.end.2

if.end.2:                                         ; preds = %if.then273.2, %if.end.1
  %condval.0.2 = phi float [ %42, %if.then273.2 ], [ 0.000000e+00, %if.end.1 ]
  %add270.3 = or disjoint i32 %add269, 3
  %cmp272.not.3 = icmp ugt i32 %add270.3, %0
  %or.cond645.3 = select i1 %cmp263, i1 true, i1 %cmp272.not.3
  br i1 %or.cond645.3, label %if.end.3, label %if.then273.3

if.then273.3:                                     ; preds = %if.end.2
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %35, i64 3
  %mul276.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %43 = tail call contract noundef float @llvm.minnum.f32(float %mul276.3, float 0x4024CB5EC0000000)
  %44 = tail call contract noundef float @llvm.exp.f32(float %43)
  br label %if.end.3

if.end.3:                                         ; preds = %if.then273.3, %if.end.2
  %condval.0.3 = phi float [ %44, %if.then273.3 ], [ 0.000000e+00, %if.end.2 ]
  %add292.1 = fadd contract float %condval.0, %condval.0.1
  %add292.2 = fadd contract float %add292.1, %condval.0.2
  %add292.3 = fadd contract float %add292.2, %condval.0.3
  %45 = bitcast float %add292.3 to i32
  %46 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %47 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %46) #11
  %xor.i.i = xor i32 %47, 32
  %48 = and i32 %47, -64
  %and.i.i = add nsw i32 %48, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %47
  %shl.i.i = shl i32 %cond.i.i, 2
  %49 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %45)
  %50 = bitcast i32 %49 to float
  %add300 = fadd contract float %add292.3, %50
  %51 = bitcast float %add300 to i32
  %52 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %53 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %52) #11
  %xor.i.i599 = xor i32 %53, 16
  %54 = and i32 %53, -64
  %and.i.i600 = add nsw i32 %54, 64
  %cmp.not.i.i601 = icmp slt i32 %xor.i.i599, %and.i.i600
  %cond.i.i602 = select i1 %cmp.not.i.i601, i32 %xor.i.i599, i32 %53
  %shl.i.i603 = shl i32 %cond.i.i602, 2
  %55 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i603, i32 %51)
  %56 = bitcast i32 %55 to float
  %add305 = fadd contract float %add300, %56
  %cmp308 = fcmp contract ogt float %add305, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add305
  %condval_1.0 = select i1 %cmp308, float %div, float 0.000000e+00
  %mul321 = fmul contract float %condval_1.0, %condval.0
  %mul321.1 = fmul contract float %condval_1.0, %condval.0.1
  %mul321.2 = fmul contract float %condval_1.0, %condval.0.2
  %mul321.3 = fmul contract float %condval_1.0, %condval.0.3
  %57 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul321)
  %58 = insertelement <4 x i16> poison, i16 %57, i64 0
  %59 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul321.1)
  %60 = insertelement <4 x i16> %58, i16 %59, i64 1
  %61 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul321.2)
  %62 = insertelement <4 x i16> %60, i16 %61, i64 2
  %63 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul321.3)
  %64 = insertelement <4 x i16> %62, i16 %63, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %64 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end339

if.end339:                                        ; preds = %if.end.3, %entry
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ undef, %entry ], [ %acc_s_cast.sroa.0.6.vec.insert, %if.end.3 ]
  br i1 %or.cond644, label %if.end409, label %for.cond361.preheader

for.cond361.preheader:                            ; preds = %if.end339
  %65 = shl nuw nsw i32 %2, 4
  %mul371 = and i32 %65, 16128
  %and377 = and i32 %2, 15
  %add378 = or disjoint i32 %mul371, %and377
  %arrayidx380 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add378
  %66 = load half, ptr addrspace(3) %arrayidx380, align 2, !tbaa !161
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %66, i64 0
  %add373.1 = or disjoint i32 %mul371, %and377
  %add378.1 = or disjoint i32 %add373.1, 64
  %arrayidx380.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add378.1
  %67 = load half, ptr addrspace(3) %arrayidx380.1, align 2, !tbaa !161
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %67, i64 1
  %add373.2 = or disjoint i32 %mul371, %and377
  %add378.2 = or disjoint i32 %add373.2, 128
  %arrayidx380.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add378.2
  %68 = load half, ptr addrspace(3) %arrayidx380.2, align 2, !tbaa !161
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %68, i64 2
  %add373.3 = or disjoint i32 %mul371, %and377
  %add378.3 = or disjoint i32 %add373.3, 192
  %arrayidx380.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add378.3
  %69 = load half, ptr addrspace(3) %arrayidx380.3, align 2, !tbaa !161
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %69, i64 3
  %add375.1678 = or disjoint i32 %mul371, %and377
  %add378.1679 = or disjoint i32 %add375.1678, 16
  %arrayidx380.1680 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add378.1679
  %70 = load half, ptr addrspace(3) %arrayidx380.1680, align 2, !tbaa !161
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %70, i64 0
  %add375.1.1 = or disjoint i32 %mul371, %and377
  %add378.1.1 = or disjoint i32 %add375.1.1, 80
  %arrayidx380.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add378.1.1
  %71 = load half, ptr addrspace(3) %arrayidx380.1.1, align 2, !tbaa !161
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %71, i64 1
  %add375.2.1 = or disjoint i32 %mul371, %and377
  %add378.2.1 = or disjoint i32 %add375.2.1, 144
  %arrayidx380.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add378.2.1
  %72 = load half, ptr addrspace(3) %arrayidx380.2.1, align 2, !tbaa !161
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %72, i64 2
  %add375.3.1 = or disjoint i32 %mul371, %and377
  %add378.3.1 = or disjoint i32 %add375.3.1, 208
  %arrayidx380.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add378.3.1
  %73 = load half, ptr addrspace(3) %arrayidx380.3.1, align 2, !tbaa !161
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %73, i64 3
  %add375.2682 = or disjoint i32 %mul371, %and377
  %add378.2683 = or disjoint i32 %add375.2682, 32
  %arrayidx380.2684 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add378.2683
  %74 = load half, ptr addrspace(3) %arrayidx380.2684, align 2, !tbaa !161
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %74, i64 0
  %add375.1.2 = or disjoint i32 %mul371, %and377
  %add378.1.2 = or disjoint i32 %add375.1.2, 96
  %arrayidx380.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add378.1.2
  %75 = load half, ptr addrspace(3) %arrayidx380.1.2, align 2, !tbaa !161
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %75, i64 1
  %add375.2.2 = or disjoint i32 %mul371, %and377
  %add378.2.2 = or disjoint i32 %add375.2.2, 160
  %arrayidx380.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add378.2.2
  %76 = load half, ptr addrspace(3) %arrayidx380.2.2, align 2, !tbaa !161
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %76, i64 2
  %add375.3.2 = or disjoint i32 %mul371, %and377
  %add378.3.2 = or disjoint i32 %add375.3.2, 224
  %arrayidx380.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add378.3.2
  %77 = load half, ptr addrspace(3) %arrayidx380.3.2, align 2, !tbaa !161
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %77, i64 3
  %add375.3686 = or disjoint i32 %mul371, %and377
  %add378.3687 = or disjoint i32 %add375.3686, 48
  %arrayidx380.3688 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add378.3687
  %78 = load half, ptr addrspace(3) %arrayidx380.3688, align 2, !tbaa !161
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %78, i64 0
  %add375.1.3 = or disjoint i32 %mul371, %and377
  %add378.1.3 = or disjoint i32 %add375.1.3, 112
  %arrayidx380.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add378.1.3
  %79 = load half, ptr addrspace(3) %arrayidx380.1.3, align 2, !tbaa !161
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %79, i64 1
  %add375.2.3 = or disjoint i32 %mul371, %and377
  %add378.2.3 = or disjoint i32 %add375.2.3, 176
  %arrayidx380.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add378.2.3
  %80 = load half, ptr addrspace(3) %arrayidx380.2.3, align 2, !tbaa !161
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %80, i64 2
  %add375.3.3 = or disjoint i32 %65, %and377
  %add378.3.3 = or i32 %add375.3.3, 240
  %arrayidx380.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add378.3.3
  %81 = load half, ptr addrspace(3) %arrayidx380.3.3, align 2, !tbaa !161
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %81, i64 3
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %83 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %84 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %85 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  br label %if.end409

if.end409:                                        ; preds = %for.cond361.preheader, %if.end339
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end339 ], [ %82, %for.cond361.preheader ]
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end339 ], [ %83, %for.cond361.preheader ]
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end339 ], [ %84, %for.cond361.preheader ]
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end339 ], [ %85, %for.cond361.preheader ]
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
  %and442 = shl nuw nsw i32 %2, 6
  %mul443 = and i32 %and442, 960
  %shr446 = lshr i32 %2, 5
  %and449 = and i32 %2, 7
  %102 = lshr i32 %2, 2
  %mul456 = and i32 %102, 4
  %xor450 = xor i32 %shr446, %and449
  %mul451 = shl nuw nsw i32 %xor450, 3
  %add452 = add nuw nsw i32 %mul451, %mul443
  %add457 = or disjoint i32 %add452, %mul456
  %add.ptr459 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add457
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr459, align 8
  %add447.1 = add nuw nsw i32 %shr446, 2
  %xor450.1 = xor i32 %add447.1, %and449
  %mul451.1 = shl nuw nsw i32 %xor450.1, 3
  %add452.1 = add nuw nsw i32 %mul451.1, %mul443
  %add457.1 = or disjoint i32 %add452.1, %mul456
  %add.ptr459.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add457.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr459.1, align 8
  %add447.2 = add nuw nsw i32 %shr446, 4
  %xor450.2 = xor i32 %add447.2, %and449
  %mul451.2 = shl nuw nsw i32 %xor450.2, 3
  %add452.2 = add nuw nsw i32 %mul451.2, %mul443
  %add457.2 = or disjoint i32 %add452.2, %mul456
  %add.ptr459.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add457.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr459.2, align 8
  %add447.3 = add nuw nsw i32 %shr446, 6
  %xor450.3 = xor i32 %add447.3, %and449
  %mul451.3 = shl nuw nsw i32 %xor450.3, 3
  %add452.3 = add nuw nsw i32 %mul451.3, %mul443
  %add457.3 = or disjoint i32 %add452.3, %mul456
  %add.ptr459.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add457.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr459.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul470 = and i32 %mul11, 8128
  %xor476593 = and i32 %mul11, 56
  %call474.masked = and i32 %2, 1016
  %mul477 = xor i32 %xor476593, %call474.masked
  %invariant.gep639 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul470
  %invariant.gep641 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep639, i32 %mul477
  %add.ptr492 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr492, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep641, i64 16, i1 false), !tbaa.struct !190, !call_argsrelate !191
  %gep642.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep641, i32 1024
  %add.ptr492.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr492.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep642.1, i64 16, i1 false), !tbaa.struct !190, !call_argsrelate !191
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


