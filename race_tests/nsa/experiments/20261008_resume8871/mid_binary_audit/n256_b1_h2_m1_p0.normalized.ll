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
  %or.cond = or i1 %cmp34, %cmp37.not
  br i1 %or.cond, label %if.end346, label %for.cond40.preheader

for.cond40.preheader:                             ; preds = %entry
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
  %add.ptr65.1670 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %15
  %16 = load i32, ptr addrspace(4) %add.ptr65.1670, align 4, !tbaa !30
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
  %add.ptr103.1682 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %15
  %27 = load i32, ptr addrspace(4) %add.ptr103.1682, align 4, !tbaa !30
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
  %invariant.gep621 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul133
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep621, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !58
  %gep622.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 1024
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep622.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !call_argsrelate !58
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
  store i32 %8, ptr addrspace(3) %invariant.gep621, align 16, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep626.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 4
  store i32 %10, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep626.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep626.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 8
  store i32 %12, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep626.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep626.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 12
  store i32 %14, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep626.sroa_idx, align 4, !tbaa !30
  store i32 %16, ptr addrspace(3) %gep622.1, align 16, !tbaa !30
  %K_reg.sroa.9.16.gep627.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 1028
  store i32 %18, ptr addrspace(3) %K_reg.sroa.9.16.gep627.1.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.10.16.gep627.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 1032
  store i32 %20, ptr addrspace(3) %K_reg.sroa.10.16.gep627.1.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.11.16.gep627.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 1036
  store i32 %22, ptr addrspace(3) %K_reg.sroa.11.16.gep627.1.sroa_idx, align 4, !tbaa !30
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr157, align 16
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr157.sroa_idx, align 8
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer)
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %32)
  %kb.sroa.0.0.copyload712 = load <4 x half>, ptr addrspace(3) %add.ptr157.1, align 16
  %kb.sroa.6.0.copyload713 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr157.1.sroa_idx, align 8
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload712, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %33)
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload713, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %34)
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %invariant.gep634 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %6
  store i32 %23, ptr addrspace(3) %invariant.gep634, align 16, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep634.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep634, i32 4
  store i32 %24, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep634.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep634.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep634, i32 8
  store i32 %25, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep634.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep634.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep634, i32 12
  store i32 %26, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep634.sroa_idx, align 4, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep634, i32 1024
  store i32 %27, ptr addrspace(3) %gep.1, align 16, !tbaa !30
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep634, i32 1028
  store i32 %28, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep634, i32 1032
  store i32 %29, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep634, i32 1036
  store i32 %30, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !tbaa !30
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %35, i64 0
  %mul259 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %36 = tail call contract noundef float @llvm.minnum.f32(float %mul259, float 0x4024CB5EC0000000)
  %37 = tail call contract noundef float @llvm.exp.f32(float %36)
  %acc_s.sroa.0.0.vec.insert719 = insertelement <4 x float> poison, float %37, i64 0
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %35, i64 1
  %mul259.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %38 = tail call contract noundef float @llvm.minnum.f32(float %mul259.1, float 0x4024CB5EC0000000)
  %39 = tail call contract noundef float @llvm.exp.f32(float %38)
  %acc_s.sroa.0.4.vec.insert734 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert719, float %39, i64 1
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %35, i64 2
  %mul259.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul259.2, float 0x4024CB5EC0000000)
  %41 = tail call contract noundef float @llvm.exp.f32(float %40)
  %acc_s.sroa.0.8.vec.insert749 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert734, float %41, i64 2
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %35, i64 3
  %mul259.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %42 = tail call contract noundef float @llvm.minnum.f32(float %mul259.3, float 0x4024CB5EC0000000)
  %43 = tail call contract noundef float @llvm.exp.f32(float %42)
  %acc_s.sroa.0.12.vec.insert764 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert749, float %43, i64 3
  %cmp269 = icmp eq i32 %5, %shr
  br i1 %cmp269, label %for.cond271.preheader, label %if.end290

for.cond271.preheader:                            ; preds = %for.cond40.preheader
  %44 = lshr i32 %2, 2
  %mul277 = and i32 %44, 252
  %and280 = and i32 %0, 15
  %cmp281.not = icmp ugt i32 %mul277, %and280
  %spec.select = select i1 %cmp281.not, float 0.000000e+00, float %37
  %acc_s.sroa.0.0.vec.insert723 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp281.not.1.not = icmp ult i32 %mul277, %and280
  %condval.0.1 = select i1 %cmp281.not.1.not, float %39, float 0.000000e+00
  %acc_s.sroa.0.4.vec.insert738 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert723, float %condval.0.1, i64 1
  %add278.2 = or disjoint i32 %mul277, 2
  %cmp281.not.2 = icmp ugt i32 %add278.2, %and280
  %condval.0.2 = select i1 %cmp281.not.2, float 0.000000e+00, float %41
  %acc_s.sroa.0.8.vec.insert753 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert738, float %condval.0.2, i64 2
  %add278.3 = or i32 %44, 3
  %cmp281.not.3 = icmp ugt i32 %add278.3, %and280
  %condval.0.3 = select i1 %cmp281.not.3, float 0.000000e+00, float %43
  %acc_s.sroa.0.12.vec.insert768 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert753, float %condval.0.3, i64 3
  br label %if.end290

if.end290:                                        ; preds = %for.cond271.preheader, %for.cond40.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert768, %for.cond271.preheader ], [ %acc_s.sroa.0.12.vec.insert764, %for.cond40.preheader ]
  %acc_s.sroa.0.0.vec.extract725 = extractelement <4 x float> %acc_s.sroa.0.0, i64 0
  %add299 = fadd contract float %acc_s.sroa.0.0.vec.extract725, 0.000000e+00
  %acc_s.sroa.0.4.vec.extract740 = extractelement <4 x float> %acc_s.sroa.0.0, i64 1
  %add299.1 = fadd contract float %add299, %acc_s.sroa.0.4.vec.extract740
  %acc_s.sroa.0.8.vec.extract755 = extractelement <4 x float> %acc_s.sroa.0.0, i64 2
  %add299.2 = fadd contract float %add299.1, %acc_s.sroa.0.8.vec.extract755
  %acc_s.sroa.0.12.vec.extract770 = extractelement <4 x float> %acc_s.sroa.0.0, i64 3
  %add299.3 = fadd contract float %add299.2, %acc_s.sroa.0.12.vec.extract770
  %45 = bitcast float %add299.3 to i32
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
  %add307 = fadd contract float %add299.3, %50
  %51 = bitcast float %add307 to i32
  %52 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %53 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %52) #11
  %xor.i.i608 = xor i32 %53, 16
  %54 = and i32 %53, -64
  %and.i.i609 = add nsw i32 %54, 64
  %cmp.not.i.i610 = icmp slt i32 %xor.i.i608, %and.i.i609
  %cond.i.i611 = select i1 %cmp.not.i.i610, i32 %xor.i.i608, i32 %53
  %shl.i.i612 = shl i32 %cond.i.i611, 2
  %55 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i612, i32 %51)
  %56 = bitcast i32 %55 to float
  %add312 = fadd contract float %add307, %56
  %cmp315 = fcmp contract ogt float %add312, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add312
  %condval_1.0 = select i1 %cmp315, float %div, float 0.000000e+00
  %mul328 = fmul contract float %condval_1.0, %acc_s.sroa.0.0.vec.extract725
  %acc_s.sroa.0.4.vec.extract742 = extractelement <4 x float> %acc_s.sroa.0.0, i64 1
  %mul328.1 = fmul contract float %condval_1.0, %acc_s.sroa.0.4.vec.extract742
  %acc_s.sroa.0.8.vec.extract757 = extractelement <4 x float> %acc_s.sroa.0.0, i64 2
  %mul328.2 = fmul contract float %condval_1.0, %acc_s.sroa.0.8.vec.extract757
  %acc_s.sroa.0.12.vec.extract772 = extractelement <4 x float> %acc_s.sroa.0.0, i64 3
  %mul328.3 = fmul contract float %condval_1.0, %acc_s.sroa.0.12.vec.extract772
  %57 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul328)
  %58 = insertelement <4 x i16> poison, i16 %57, i64 0
  %59 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul328.1)
  %60 = insertelement <4 x i16> %58, i16 %59, i64 1
  %61 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul328.2)
  %62 = insertelement <4 x i16> %60, i16 %61, i64 2
  %63 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul328.3)
  %64 = insertelement <4 x i16> %62, i16 %63, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %64 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end346

if.end346:                                        ; preds = %entry, %if.end290
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ %acc_s_cast.sroa.0.6.vec.insert, %if.end290 ], [ undef, %entry ]
  %cmp362 = icmp ugt i32 %5, 15
  %cmp366.not = icmp ugt i32 %5, %shr
  %or.cond655 = or i1 %cmp362, %cmp366.not
  br i1 %or.cond655, label %if.end416, label %for.cond368.preheader

for.cond368.preheader:                            ; preds = %if.end346
  %65 = shl nuw nsw i32 %2, 4
  %mul378 = and i32 %65, 16128
  %and384 = and i32 %2, 15
  %add385 = or disjoint i32 %mul378, %and384
  %arrayidx387 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385
  %66 = load half, ptr addrspace(3) %arrayidx387, align 2, !tbaa !168
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %66, i64 0
  %add380.1 = or disjoint i32 %mul378, %and384
  %add385.1 = or disjoint i32 %add380.1, 64
  %arrayidx387.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.1
  %67 = load half, ptr addrspace(3) %arrayidx387.1, align 2, !tbaa !168
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %67, i64 1
  %add380.2 = or disjoint i32 %mul378, %and384
  %add385.2 = or disjoint i32 %add380.2, 128
  %arrayidx387.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.2
  %68 = load half, ptr addrspace(3) %arrayidx387.2, align 2, !tbaa !168
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %68, i64 2
  %add380.3 = or disjoint i32 %mul378, %and384
  %add385.3 = or disjoint i32 %add380.3, 192
  %arrayidx387.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.3
  %69 = load half, ptr addrspace(3) %arrayidx387.3, align 2, !tbaa !168
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %69, i64 3
  %add382.1686 = or disjoint i32 %mul378, %and384
  %add385.1687 = or disjoint i32 %add382.1686, 16
  %arrayidx387.1688 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.1687
  %70 = load half, ptr addrspace(3) %arrayidx387.1688, align 2, !tbaa !168
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %70, i64 0
  %add382.1.1 = or disjoint i32 %mul378, %and384
  %add385.1.1 = or disjoint i32 %add382.1.1, 80
  %arrayidx387.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.1.1
  %71 = load half, ptr addrspace(3) %arrayidx387.1.1, align 2, !tbaa !168
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %71, i64 1
  %add382.2.1 = or disjoint i32 %mul378, %and384
  %add385.2.1 = or disjoint i32 %add382.2.1, 144
  %arrayidx387.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.2.1
  %72 = load half, ptr addrspace(3) %arrayidx387.2.1, align 2, !tbaa !168
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %72, i64 2
  %add382.3.1 = or disjoint i32 %mul378, %and384
  %add385.3.1 = or disjoint i32 %add382.3.1, 208
  %arrayidx387.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.3.1
  %73 = load half, ptr addrspace(3) %arrayidx387.3.1, align 2, !tbaa !168
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %73, i64 3
  %add382.2690 = or disjoint i32 %mul378, %and384
  %add385.2691 = or disjoint i32 %add382.2690, 32
  %arrayidx387.2692 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.2691
  %74 = load half, ptr addrspace(3) %arrayidx387.2692, align 2, !tbaa !168
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %74, i64 0
  %add382.1.2 = or disjoint i32 %mul378, %and384
  %add385.1.2 = or disjoint i32 %add382.1.2, 96
  %arrayidx387.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.1.2
  %75 = load half, ptr addrspace(3) %arrayidx387.1.2, align 2, !tbaa !168
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %75, i64 1
  %add382.2.2 = or disjoint i32 %mul378, %and384
  %add385.2.2 = or disjoint i32 %add382.2.2, 160
  %arrayidx387.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.2.2
  %76 = load half, ptr addrspace(3) %arrayidx387.2.2, align 2, !tbaa !168
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %76, i64 2
  %add382.3.2 = or disjoint i32 %mul378, %and384
  %add385.3.2 = or disjoint i32 %add382.3.2, 224
  %arrayidx387.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.3.2
  %77 = load half, ptr addrspace(3) %arrayidx387.3.2, align 2, !tbaa !168
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %77, i64 3
  %add382.3694 = or disjoint i32 %mul378, %and384
  %add385.3695 = or disjoint i32 %add382.3694, 48
  %arrayidx387.3696 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.3695
  %78 = load half, ptr addrspace(3) %arrayidx387.3696, align 2, !tbaa !168
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %78, i64 0
  %add382.1.3 = or disjoint i32 %mul378, %and384
  %add385.1.3 = or disjoint i32 %add382.1.3, 112
  %arrayidx387.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.1.3
  %79 = load half, ptr addrspace(3) %arrayidx387.1.3, align 2, !tbaa !168
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %79, i64 1
  %add382.2.3 = or disjoint i32 %mul378, %and384
  %add385.2.3 = or disjoint i32 %add382.2.3, 176
  %arrayidx387.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.2.3
  %80 = load half, ptr addrspace(3) %arrayidx387.2.3, align 2, !tbaa !168
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %80, i64 2
  %add382.3.3 = or disjoint i32 %65, %and384
  %add385.3.3 = or i32 %add382.3.3, 240
  %arrayidx387.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.3.3
  %81 = load half, ptr addrspace(3) %arrayidx387.3.3, align 2, !tbaa !168
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %81, i64 3
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %83 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %84 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %85 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  br label %if.end416

if.end416:                                        ; preds = %for.cond368.preheader, %if.end346
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end346 ], [ %82, %for.cond368.preheader ]
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end346 ], [ %83, %for.cond368.preheader ]
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end346 ], [ %84, %for.cond368.preheader ]
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end346 ], [ %85, %for.cond368.preheader ]
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
  %and449 = shl nuw nsw i32 %2, 6
  %mul450 = and i32 %and449, 960
  %shr453 = lshr i32 %2, 5
  %and456 = and i32 %2, 7
  %102 = lshr i32 %2, 2
  %mul463 = and i32 %102, 4
  %xor457 = xor i32 %shr453, %and456
  %mul458 = shl nuw nsw i32 %xor457, 3
  %add459 = add nuw nsw i32 %mul458, %mul450
  %add464 = or disjoint i32 %add459, %mul463
  %add.ptr466 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add464
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr466, align 8
  %add454.1 = add nuw nsw i32 %shr453, 2
  %xor457.1 = xor i32 %add454.1, %and456
  %mul458.1 = shl nuw nsw i32 %xor457.1, 3
  %add459.1 = add nuw nsw i32 %mul458.1, %mul450
  %add464.1 = or disjoint i32 %add459.1, %mul463
  %add.ptr466.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add464.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr466.1, align 8
  %add454.2 = add nuw nsw i32 %shr453, 4
  %xor457.2 = xor i32 %add454.2, %and456
  %mul458.2 = shl nuw nsw i32 %xor457.2, 3
  %add459.2 = add nuw nsw i32 %mul458.2, %mul450
  %add464.2 = or disjoint i32 %add459.2, %mul463
  %add.ptr466.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add464.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr466.2, align 8
  %add454.3 = add nuw nsw i32 %shr453, 6
  %xor457.3 = xor i32 %add454.3, %and456
  %mul458.3 = shl nuw nsw i32 %xor457.3, 3
  %add459.3 = add nuw nsw i32 %mul458.3, %mul450
  %add464.3 = or disjoint i32 %add459.3, %mul463
  %add.ptr466.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add464.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr466.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul477 = and i32 %mul11, 8128
  %xor483602 = and i32 %mul11, 56
  %call481.masked = and i32 %2, 1016
  %mul484 = xor i32 %xor483602, %call481.masked
  %invariant.gep649 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul477
  %invariant.gep651 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep649, i32 %mul484
  %add.ptr499 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr499, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep651, i64 16, i1 false), !tbaa.struct !197, !call_argsrelate !198
  %gep652.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep651, i32 1024
  %add.ptr499.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr499.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep652.1, i64 16, i1 false), !tbaa.struct !197, !call_argsrelate !198
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


