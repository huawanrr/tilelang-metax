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
  %arrayidx20 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom
  %5 = load i32, ptr addrspace(1) %arrayidx20, align 4, !tbaa !30
  %cmp35 = icmp ugt i32 %5, 15
  %shr = lshr i32 %0, 4
  %cmp38.not = icmp ugt i32 %5, %shr
  %or.cond = or i1 %cmp35, %cmp38.not
  br i1 %or.cond, label %if.end349, label %for.cond41.preheader

for.cond41.preheader:                             ; preds = %entry
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %mul50 = shl nuw nsw i32 %5, 11
  %6 = shl nuw nsw i32 %2, 4
  %mul55 = and i32 %6, 16256
  %mul58 = shl nsw i32 %1, 6
  %add52 = add nuw nsw i32 %mul55, %mul58
  %mul61 = and i32 %mul11, 56
  %add56 = or disjoint i32 %add52, %mul61
  %add59 = add nuw nsw i32 %add56, %mul50
  %7 = zext nneg i32 %add59 to i64
  %add.ptr66 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %7
  %8 = load i32, ptr addrspace(4) %add.ptr66, align 4, !tbaa !30
  %9 = or disjoint i64 %7, 2
  %add.ptr66.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %9
  %10 = load i32, ptr addrspace(4) %add.ptr66.1, align 4, !tbaa !30
  %11 = or disjoint i64 %7, 4
  %add.ptr66.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %11
  %12 = load i32, ptr addrspace(4) %add.ptr66.2, align 4, !tbaa !30
  %13 = or disjoint i64 %7, 6
  %add.ptr66.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %13
  %14 = load i32, ptr addrspace(4) %add.ptr66.3, align 4, !tbaa !30
  %15 = add nuw nsw i64 %7, 1024
  %add.ptr66.1670 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %15
  %16 = load i32, ptr addrspace(4) %add.ptr66.1670, align 4, !tbaa !30
  %17 = add nuw nsw i64 %7, 1026
  %add.ptr66.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %17
  %18 = load i32, ptr addrspace(4) %add.ptr66.1.1, align 4, !tbaa !30
  %19 = add nuw nsw i64 %7, 1028
  %add.ptr66.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %19
  %20 = load i32, ptr addrspace(4) %add.ptr66.2.1, align 4, !tbaa !30
  %21 = add nuw nsw i64 %7, 1030
  %add.ptr66.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %21
  %22 = load i32, ptr addrspace(4) %add.ptr66.3.1, align 4, !tbaa !30
  %add.ptr104 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %7
  %23 = load i32, ptr addrspace(4) %add.ptr104, align 4, !tbaa !30
  %add.ptr104.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %9
  %24 = load i32, ptr addrspace(4) %add.ptr104.1, align 4, !tbaa !30
  %add.ptr104.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %11
  %25 = load i32, ptr addrspace(4) %add.ptr104.2, align 4, !tbaa !30
  %add.ptr104.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %13
  %26 = load i32, ptr addrspace(4) %add.ptr104.3, align 4, !tbaa !30
  %add.ptr104.1682 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %15
  %27 = load i32, ptr addrspace(4) %add.ptr104.1682, align 4, !tbaa !30
  %add.ptr104.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %17
  %28 = load i32, ptr addrspace(4) %add.ptr104.1.1, align 4, !tbaa !30
  %add.ptr104.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %19
  %29 = load i32, ptr addrspace(4) %add.ptr104.2.1, align 4, !tbaa !30
  %add.ptr104.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %21
  %30 = load i32, ptr addrspace(4) %add.ptr104.3.1, align 4, !tbaa !30
  %mul128 = and i32 %mul11, 8128
  %call132.masked = and i32 %2, 1016
  %mul134 = xor i32 %mul61, %call132.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul128
  %invariant.gep621 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul134
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep621, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !58
  %gep622.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 1024
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep622.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !call_argsrelate !58
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and146 = shl nuw nsw i32 %2, 6
  %mul147 = and i32 %and146, 960
  %shr150 = lshr i32 %2, 4
  %and153 = and i32 %2, 7
  %31 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul147
  %xor154 = xor i32 %shr150, %and153
  %add.ptr158.idx = shl nuw nsw i32 %xor154, 4
  %add.ptr158 = getelementptr inbounds i8, ptr addrspace(3) %31, i32 %add.ptr158.idx
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr158, align 16
  %Q_reg.sroa.4.0.add.ptr158.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr158, i32 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr158.sroa_idx, align 8
  %add151.1 = add nuw nsw i32 %shr150, 4
  %xor154.1 = xor i32 %add151.1, %and153
  %add.ptr158.idx.1 = shl nuw nsw i32 %xor154.1, 4
  %add.ptr158.1 = getelementptr inbounds i8, ptr addrspace(3) %31, i32 %add.ptr158.idx.1
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr158.1, align 16
  %Q_reg.sroa.7.16.add.ptr158.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr158.1, i32 8
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr158.1.sroa_idx, align 8
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
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr158, align 16
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr158.sroa_idx, align 8
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer)
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %32)
  %kb.sroa.0.0.copyload712 = load <4 x half>, ptr addrspace(3) %add.ptr158.1, align 16
  %kb.sroa.6.0.copyload713 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr158.1.sroa_idx, align 8
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
  %mul260 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FC2776C60000000
  %36 = tail call contract noundef float @llvm.minnum.f32(float %mul260, float 1.500000e+01)
  %37 = tail call contract noundef float @llvm.exp2.f32(float %36)
  %acc_s.sroa.0.0.vec.insert719 = insertelement <4 x float> poison, float %37, i64 0
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %35, i64 1
  %mul260.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FC2776C60000000
  %38 = tail call contract noundef float @llvm.minnum.f32(float %mul260.1, float 1.500000e+01)
  %39 = tail call contract noundef float @llvm.exp2.f32(float %38)
  %acc_s.sroa.0.4.vec.insert734 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert719, float %39, i64 1
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %35, i64 2
  %mul260.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FC2776C60000000
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul260.2, float 1.500000e+01)
  %41 = tail call contract noundef float @llvm.exp2.f32(float %40)
  %acc_s.sroa.0.8.vec.insert749 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert734, float %41, i64 2
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %35, i64 3
  %mul260.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FC2776C60000000
  %42 = tail call contract noundef float @llvm.minnum.f32(float %mul260.3, float 1.500000e+01)
  %43 = tail call contract noundef float @llvm.exp2.f32(float %42)
  %acc_s.sroa.0.12.vec.insert764 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert749, float %43, i64 3
  %cmp270 = icmp eq i32 %5, %shr
  br i1 %cmp270, label %for.cond272.preheader, label %if.end291

for.cond272.preheader:                            ; preds = %for.cond41.preheader
  %44 = lshr i32 %2, 2
  %mul278 = and i32 %44, 252
  %and281 = and i32 %0, 15
  %cmp282.not = icmp ugt i32 %mul278, %and281
  %spec.select = select i1 %cmp282.not, float 0.000000e+00, float %37
  %acc_s.sroa.0.0.vec.insert723 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp282.not.1.not = icmp ult i32 %mul278, %and281
  %condval.0.1 = select i1 %cmp282.not.1.not, float %39, float 0.000000e+00
  %acc_s.sroa.0.4.vec.insert738 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert723, float %condval.0.1, i64 1
  %add279.2 = or disjoint i32 %mul278, 2
  %cmp282.not.2 = icmp ugt i32 %add279.2, %and281
  %condval.0.2 = select i1 %cmp282.not.2, float 0.000000e+00, float %41
  %acc_s.sroa.0.8.vec.insert753 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert738, float %condval.0.2, i64 2
  %add279.3 = or i32 %44, 3
  %cmp282.not.3 = icmp ugt i32 %add279.3, %and281
  %condval.0.3 = select i1 %cmp282.not.3, float 0.000000e+00, float %43
  %acc_s.sroa.0.12.vec.insert768 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert753, float %condval.0.3, i64 3
  br label %if.end291

if.end291:                                        ; preds = %for.cond272.preheader, %for.cond41.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert768, %for.cond272.preheader ], [ %acc_s.sroa.0.12.vec.insert764, %for.cond41.preheader ]
  %acc_s.sroa.0.0.vec.extract725 = extractelement <4 x float> %acc_s.sroa.0.0, i64 0
  %add300 = fadd contract float %acc_s.sroa.0.0.vec.extract725, 0.000000e+00
  %acc_s.sroa.0.4.vec.extract740 = extractelement <4 x float> %acc_s.sroa.0.0, i64 1
  %add300.1 = fadd contract float %add300, %acc_s.sroa.0.4.vec.extract740
  %acc_s.sroa.0.8.vec.extract755 = extractelement <4 x float> %acc_s.sroa.0.0, i64 2
  %add300.2 = fadd contract float %add300.1, %acc_s.sroa.0.8.vec.extract755
  %acc_s.sroa.0.12.vec.extract770 = extractelement <4 x float> %acc_s.sroa.0.0, i64 3
  %add300.3 = fadd contract float %add300.2, %acc_s.sroa.0.12.vec.extract770
  %45 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add300.3, <4 x float> zeroinitializer)
  %wsum_output.sroa.0.0.vec.extract = extractelement <4 x float> %45, i64 0
  %cmp318 = fcmp contract ogt float %wsum_output.sroa.0.0.vec.extract, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %wsum_output.sroa.0.0.vec.extract
  %condval_1.0 = select i1 %cmp318, float %div, float 0.000000e+00
  %mul331 = fmul contract float %condval_1.0, %acc_s.sroa.0.0.vec.extract725
  %acc_s.sroa.0.4.vec.extract742 = extractelement <4 x float> %acc_s.sroa.0.0, i64 1
  %mul331.1 = fmul contract float %condval_1.0, %acc_s.sroa.0.4.vec.extract742
  %acc_s.sroa.0.8.vec.extract757 = extractelement <4 x float> %acc_s.sroa.0.0, i64 2
  %mul331.2 = fmul contract float %condval_1.0, %acc_s.sroa.0.8.vec.extract757
  %acc_s.sroa.0.12.vec.extract772 = extractelement <4 x float> %acc_s.sroa.0.0, i64 3
  %mul331.3 = fmul contract float %condval_1.0, %acc_s.sroa.0.12.vec.extract772
  %46 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul331)
  %47 = insertelement <4 x i16> poison, i16 %46, i64 0
  %48 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul331.1)
  %49 = insertelement <4 x i16> %47, i16 %48, i64 1
  %50 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul331.2)
  %51 = insertelement <4 x i16> %49, i16 %50, i64 2
  %52 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul331.3)
  %53 = insertelement <4 x i16> %51, i16 %52, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %53 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end349

if.end349:                                        ; preds = %entry, %if.end291
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ %acc_s_cast.sroa.0.6.vec.insert, %if.end291 ], [ undef, %entry ]
  %cmp365 = icmp ugt i32 %5, 15
  %cmp369.not = icmp ugt i32 %5, %shr
  %or.cond655 = or i1 %cmp365, %cmp369.not
  br i1 %or.cond655, label %if.end419, label %for.cond371.preheader

for.cond371.preheader:                            ; preds = %if.end349
  %54 = shl nuw nsw i32 %2, 4
  %mul381 = and i32 %54, 16128
  %and387 = and i32 %2, 15
  %add388 = or disjoint i32 %mul381, %and387
  %arrayidx390 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388
  %55 = load half, ptr addrspace(3) %arrayidx390, align 2, !tbaa !139
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %55, i64 0
  %add383.1 = or disjoint i32 %mul381, %and387
  %add388.1 = or disjoint i32 %add383.1, 64
  %arrayidx390.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.1
  %56 = load half, ptr addrspace(3) %arrayidx390.1, align 2, !tbaa !139
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %56, i64 1
  %add383.2 = or disjoint i32 %mul381, %and387
  %add388.2 = or disjoint i32 %add383.2, 128
  %arrayidx390.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.2
  %57 = load half, ptr addrspace(3) %arrayidx390.2, align 2, !tbaa !139
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %57, i64 2
  %add383.3 = or disjoint i32 %mul381, %and387
  %add388.3 = or disjoint i32 %add383.3, 192
  %arrayidx390.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.3
  %58 = load half, ptr addrspace(3) %arrayidx390.3, align 2, !tbaa !139
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %58, i64 3
  %add385.1686 = or disjoint i32 %mul381, %and387
  %add388.1687 = or disjoint i32 %add385.1686, 16
  %arrayidx390.1688 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.1687
  %59 = load half, ptr addrspace(3) %arrayidx390.1688, align 2, !tbaa !139
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %59, i64 0
  %add385.1.1 = or disjoint i32 %mul381, %and387
  %add388.1.1 = or disjoint i32 %add385.1.1, 80
  %arrayidx390.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.1.1
  %60 = load half, ptr addrspace(3) %arrayidx390.1.1, align 2, !tbaa !139
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %60, i64 1
  %add385.2.1 = or disjoint i32 %mul381, %and387
  %add388.2.1 = or disjoint i32 %add385.2.1, 144
  %arrayidx390.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.2.1
  %61 = load half, ptr addrspace(3) %arrayidx390.2.1, align 2, !tbaa !139
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %61, i64 2
  %add385.3.1 = or disjoint i32 %mul381, %and387
  %add388.3.1 = or disjoint i32 %add385.3.1, 208
  %arrayidx390.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.3.1
  %62 = load half, ptr addrspace(3) %arrayidx390.3.1, align 2, !tbaa !139
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %62, i64 3
  %add385.2690 = or disjoint i32 %mul381, %and387
  %add388.2691 = or disjoint i32 %add385.2690, 32
  %arrayidx390.2692 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.2691
  %63 = load half, ptr addrspace(3) %arrayidx390.2692, align 2, !tbaa !139
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %63, i64 0
  %add385.1.2 = or disjoint i32 %mul381, %and387
  %add388.1.2 = or disjoint i32 %add385.1.2, 96
  %arrayidx390.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.1.2
  %64 = load half, ptr addrspace(3) %arrayidx390.1.2, align 2, !tbaa !139
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %64, i64 1
  %add385.2.2 = or disjoint i32 %mul381, %and387
  %add388.2.2 = or disjoint i32 %add385.2.2, 160
  %arrayidx390.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.2.2
  %65 = load half, ptr addrspace(3) %arrayidx390.2.2, align 2, !tbaa !139
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %65, i64 2
  %add385.3.2 = or disjoint i32 %mul381, %and387
  %add388.3.2 = or disjoint i32 %add385.3.2, 224
  %arrayidx390.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.3.2
  %66 = load half, ptr addrspace(3) %arrayidx390.3.2, align 2, !tbaa !139
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %66, i64 3
  %add385.3694 = or disjoint i32 %mul381, %and387
  %add388.3695 = or disjoint i32 %add385.3694, 48
  %arrayidx390.3696 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.3695
  %67 = load half, ptr addrspace(3) %arrayidx390.3696, align 2, !tbaa !139
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %67, i64 0
  %add385.1.3 = or disjoint i32 %mul381, %and387
  %add388.1.3 = or disjoint i32 %add385.1.3, 112
  %arrayidx390.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.1.3
  %68 = load half, ptr addrspace(3) %arrayidx390.1.3, align 2, !tbaa !139
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %68, i64 1
  %add385.2.3 = or disjoint i32 %mul381, %and387
  %add388.2.3 = or disjoint i32 %add385.2.3, 176
  %arrayidx390.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.2.3
  %69 = load half, ptr addrspace(3) %arrayidx390.2.3, align 2, !tbaa !139
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %69, i64 2
  %add385.3.3 = or disjoint i32 %54, %and387
  %add388.3.3 = or i32 %add385.3.3, 240
  %arrayidx390.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.3.3
  %70 = load half, ptr addrspace(3) %arrayidx390.3.3, align 2, !tbaa !139
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %70, i64 3
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %72 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %73 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %74 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  br label %if.end419

if.end419:                                        ; preds = %for.cond371.preheader, %if.end349
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end349 ], [ %71, %for.cond371.preheader ]
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end349 ], [ %72, %for.cond371.preheader ]
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end349 ], [ %73, %for.cond371.preheader ]
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end349 ], [ %74, %for.cond371.preheader ]
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
  %and452 = shl nuw nsw i32 %2, 6
  %mul453 = and i32 %and452, 960
  %shr456 = lshr i32 %2, 5
  %and459 = and i32 %2, 7
  %91 = lshr i32 %2, 2
  %mul466 = and i32 %91, 4
  %xor460 = xor i32 %shr456, %and459
  %mul461 = shl nuw nsw i32 %xor460, 3
  %add462 = add nuw nsw i32 %mul461, %mul453
  %add467 = or disjoint i32 %add462, %mul466
  %add.ptr469 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add467
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr469, align 8
  %add457.1 = add nuw nsw i32 %shr456, 2
  %xor460.1 = xor i32 %add457.1, %and459
  %mul461.1 = shl nuw nsw i32 %xor460.1, 3
  %add462.1 = add nuw nsw i32 %mul461.1, %mul453
  %add467.1 = or disjoint i32 %add462.1, %mul466
  %add.ptr469.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add467.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr469.1, align 8
  %add457.2 = add nuw nsw i32 %shr456, 4
  %xor460.2 = xor i32 %add457.2, %and459
  %mul461.2 = shl nuw nsw i32 %xor460.2, 3
  %add462.2 = add nuw nsw i32 %mul461.2, %mul453
  %add467.2 = or disjoint i32 %add462.2, %mul466
  %add.ptr469.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add467.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr469.2, align 8
  %add457.3 = add nuw nsw i32 %shr456, 6
  %xor460.3 = xor i32 %add457.3, %and459
  %mul461.3 = shl nuw nsw i32 %xor460.3, 3
  %add462.3 = add nuw nsw i32 %mul461.3, %mul453
  %add467.3 = or disjoint i32 %add462.3, %mul466
  %add.ptr469.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add467.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr469.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul480 = and i32 %mul11, 8128
  %xor486607 = and i32 %mul11, 56
  %call484.masked = and i32 %2, 1016
  %mul487 = xor i32 %xor486607, %call484.masked
  %invariant.gep649 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul480
  %invariant.gep651 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep649, i32 %mul487
  %add.ptr502 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr502, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep651, i64 16, i1 false), !tbaa.struct !168, !call_argsrelate !169
  %gep652.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep651, i32 1024
  %add.ptr502.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr502.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep652.1, i64 16, i1 false), !tbaa.struct !168, !call_argsrelate !169
  ret void
}

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

declare <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float, float, <4 x float>) #4

declare i32 @llvm.mxc.block.id.x() #5

declare i32 @llvm.mxc.block.id.y() #5

declare i32 @llvm.mxc.block.id.z() #5

declare i32 @llvm.mxc.thread.id.x() #5

declare void @llvm.mxc.barrier.warp() #6

declare float @llvm.exp2.f32(float) #7

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


