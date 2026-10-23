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

define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(4) noalias nocapture noundef readonly %K.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Packed.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %PackedK.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V.coerce) local_unnamed_addr #3 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %1 = and i32 %0, 1048574
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %3 = shl nuw nsw i32 %2, 5
  %mul8 = and i32 %3, 32512
  %4 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !range !29
  %mul11 = shl nsw i32 %4, 7
  %add9 = add nuw nsw i32 %mul8, %mul11
  %and = shl i32 %0, 6
  %mul14 = and i32 %and, 64
  %and17 = shl nuw nsw i32 %2, 3
  %mul18 = and i32 %and17, 56
  %add12 = or disjoint i32 %add9, %mul14
  %add15 = or disjoint i32 %add12, %mul18
  %5 = zext nneg i32 %1 to i64
  %6 = zext nneg i32 %add15 to i64
  %7 = shl nuw nsw i64 %5, 11
  %8 = add nuw nsw i64 %7, %6
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %8
  %9 = shl nuw nsw i64 %5, 11
  %10 = or disjoint i64 %9, 2048
  %11 = add nuw nsw i64 %10, %6
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %11
  %add.ptr49 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %8
  %tile.sroa.0.0.copyload = load i64, ptr addrspace(4) %add.ptr49, align 16
  %tile.sroa.4.0.add.ptr49.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49, i64 8
  %tile.sroa.4.0.copyload = load i64, ptr addrspace(4) %tile.sroa.4.0.add.ptr49.sroa_idx, align 8
  %add.ptr49.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %11
  %tile.sroa.5.16.copyload = load i64, ptr addrspace(4) %add.ptr49.1, align 16
  %tile.sroa.7.16.add.ptr49.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.1, i64 8
  %tile.sroa.7.16.copyload = load i64, ptr addrspace(4) %tile.sroa.7.16.add.ptr49.1.sroa_idx, align 8
  %mul69 = and i32 %and17, 8128
  %call73.masked = and i32 %2, 1016
  %mul75 = xor i32 %mul18, %call73.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul69
  %invariant.gep273 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul75
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep273, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !51
  %gep274.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep273, i32 1024
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep274.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !call_argsrelate !51
  %and98 = shl nuw nsw i32 %2, 1
  %mul99 = and i32 %and98, 14
  %shr105 = lshr i32 %2, 3
  %xor107 = xor i32 %shr105, %mul99
  %.idx269 = shl nuw nsw i32 %xor107, 3
  %12 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 %.idx269
  %add.ptr112 = getelementptr inbounds i8, ptr addrspace(3) %12, i32 2048
  store i64 %tile.sroa.0.0.copyload, ptr addrspace(3) %add.ptr112, align 8
  %add101.1 = or disjoint i32 %mul99, 1
  %xor107.1 = xor i32 %shr105, %add101.1
  %.idx269.1 = shl nuw nsw i32 %xor107.1, 3
  %13 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 %.idx269.1
  %add.ptr112.1 = getelementptr inbounds i8, ptr addrspace(3) %13, i32 2048
  store i64 %tile.sroa.4.0.copyload, ptr addrspace(3) %add.ptr112.1, align 8
  %add106.2 = add nuw nsw i32 %shr105, 8
  %xor107.2 = xor i32 %add106.2, %mul99
  %gep.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1024
  %.idx269.2 = shl nuw nsw i32 %xor107.2, 3
  %14 = getelementptr inbounds i8, ptr addrspace(3) %gep.2, i32 %.idx269.2
  %add.ptr112.2 = getelementptr inbounds i8, ptr addrspace(3) %14, i32 2048
  store i64 %tile.sroa.5.16.copyload, ptr addrspace(3) %add.ptr112.2, align 8
  %xor107.3 = xor i32 %add106.2, %add101.1
  %.idx269.3 = shl nuw nsw i32 %xor107.3, 3
  %15 = getelementptr inbounds i8, ptr addrspace(3) %gep.2, i32 %.idx269.3
  %add.ptr112.3 = getelementptr inbounds i8, ptr addrspace(3) %15, i32 2048
  store i64 %tile.sroa.7.16.copyload, ptr addrspace(3) %add.ptr112.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and122 = shl nuw nsw i32 %2, 6
  %mul123 = and i32 %and122, 960
  %shr126 = lshr i32 %2, 4
  %and129 = and i32 %2, 7
  %16 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul123
  %xor130 = xor i32 %shr126, %and129
  %add.ptr134.idx = shl nuw nsw i32 %xor130, 4
  %add.ptr134 = getelementptr inbounds i8, ptr addrspace(3) %16, i32 %add.ptr134.idx
  %add127.1 = add nuw nsw i32 %shr126, 4
  %xor130.1 = xor i32 %add127.1, %and129
  %add.ptr134.idx.1 = shl nuw nsw i32 %xor130.1, 4
  %add.ptr134.1 = getelementptr inbounds i8, ptr addrspace(3) %16, i32 %add.ptr134.idx.1
  %17 = shl nuw nsw i32 %2, 4
  %mul149 = and i32 %17, 16128
  %and156 = lshr i32 %2, 2
  %shr157 = and i32 %and156, 3
  %mul161 = and i32 %and156, 252
  %and168 = and i32 %2, 3
  %add152 = or disjoint i32 %mul149, %and168
  %18 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add152
  %gep279.idx = shl nuw nsw i32 %and156, 3
  %gep279 = getelementptr inbounds i8, ptr addrspace(3) %18, i32 %gep279.idx
  %19 = load i16, ptr addrspace(3) %gep279, align 2, !tbaa !71
  %add163.1 = or disjoint i32 %mul161, 1
  %xor164.1 = xor i32 %shr157, %add163.1
  %add166.1 = or disjoint i32 %add152, 64
  %20 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add166.1
  %gep279.idx.1 = shl nuw nsw i32 %xor164.1, 3
  %gep279.1 = getelementptr inbounds i8, ptr addrspace(3) %20, i32 %gep279.idx.1
  %21 = load i16, ptr addrspace(3) %gep279.1, align 2, !tbaa !71
  %add163.2 = or disjoint i32 %mul161, 2
  %xor164.2 = xor i32 %shr157, %add163.2
  %add166.2 = or disjoint i32 %add152, 128
  %22 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add166.2
  %gep279.idx.2 = shl nuw nsw i32 %xor164.2, 3
  %gep279.2 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 %gep279.idx.2
  %23 = load i16, ptr addrspace(3) %gep279.2, align 2, !tbaa !71
  %add163.3 = or i32 %and156, 3
  %add166.3 = or disjoint i32 %add152, 192
  %24 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add166.3
  %xor164.3 = shl nuw nsw i32 %and156, 3
  %gep279.idx.3 = xor i32 %xor164.3, 24
  %gep279.3 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 %gep279.idx.3
  %25 = load i16, ptr addrspace(3) %gep279.3, align 2, !tbaa !71
  %add158.4 = or disjoint i32 %shr157, 4
  %xor164.4 = xor i32 %add158.4, %mul161
  %gep279.idx.4 = shl nuw nsw i32 %xor164.4, 3
  %gep279.4 = getelementptr inbounds i8, ptr addrspace(3) %18, i32 %gep279.idx.4
  %26 = load i16, ptr addrspace(3) %gep279.4, align 2, !tbaa !71
  %xor164.5 = xor i32 %add158.4, %add163.1
  %gep279.idx.5 = shl nuw nsw i32 %xor164.5, 3
  %gep279.5 = getelementptr inbounds i8, ptr addrspace(3) %20, i32 %gep279.idx.5
  %27 = load i16, ptr addrspace(3) %gep279.5, align 2, !tbaa !71
  %xor164.6 = xor i32 %add158.4, %add163.2
  %gep279.idx.6 = shl nuw nsw i32 %xor164.6, 3
  %gep279.6 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 %gep279.idx.6
  %28 = load i16, ptr addrspace(3) %gep279.6, align 2, !tbaa !71
  %xor164.7 = xor i32 %add158.4, %add163.3
  %gep279.idx.7 = shl nuw nsw i32 %xor164.7, 3
  %gep279.7 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 %gep279.idx.7
  %29 = load i16, ptr addrspace(3) %gep279.7, align 2, !tbaa !71
  %add158.8 = or disjoint i32 %shr157, 8
  %xor164.8 = xor i32 %add158.8, %mul161
  %gep279.idx.8 = shl nuw nsw i32 %xor164.8, 3
  %gep279.8 = getelementptr inbounds i8, ptr addrspace(3) %18, i32 %gep279.idx.8
  %30 = load i16, ptr addrspace(3) %gep279.8, align 2, !tbaa !71
  %xor164.9 = xor i32 %add158.8, %add163.1
  %gep279.idx.9 = shl nuw nsw i32 %xor164.9, 3
  %gep279.9 = getelementptr inbounds i8, ptr addrspace(3) %20, i32 %gep279.idx.9
  %31 = load i16, ptr addrspace(3) %gep279.9, align 2, !tbaa !71
  %xor164.10 = xor i32 %add158.8, %add163.2
  %gep279.idx.10 = shl nuw nsw i32 %xor164.10, 3
  %gep279.10 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 %gep279.idx.10
  %32 = load i16, ptr addrspace(3) %gep279.10, align 2, !tbaa !71
  %xor164.11 = xor i32 %add158.8, %add163.3
  %gep279.idx.11 = shl nuw nsw i32 %xor164.11, 3
  %gep279.11 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 %gep279.idx.11
  %33 = load i16, ptr addrspace(3) %gep279.11, align 2, !tbaa !71
  %add158.12 = or disjoint i32 %shr157, 12
  %xor164.12 = xor i32 %add158.12, %mul161
  %gep279.idx.12 = shl nuw nsw i32 %xor164.12, 3
  %gep279.12 = getelementptr inbounds i8, ptr addrspace(3) %18, i32 %gep279.idx.12
  %34 = load i16, ptr addrspace(3) %gep279.12, align 2, !tbaa !71
  %xor164.13 = xor i32 %add158.12, %add163.1
  %gep279.idx.13 = shl nuw nsw i32 %xor164.13, 3
  %gep279.13 = getelementptr inbounds i8, ptr addrspace(3) %20, i32 %gep279.idx.13
  %35 = load i16, ptr addrspace(3) %gep279.13, align 2, !tbaa !71
  %xor164.14 = xor i32 %add158.12, %add163.2
  %gep279.idx.14 = shl nuw nsw i32 %xor164.14, 3
  %gep279.14 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 %gep279.idx.14
  %36 = load i16, ptr addrspace(3) %gep279.14, align 2, !tbaa !71
  %xor164.15 = xor i32 %add158.12, %add163.3
  %gep279.idx.15 = shl nuw nsw i32 %xor164.15, 3
  %gep279.15 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 %gep279.idx.15
  %37 = load i16, ptr addrspace(3) %gep279.15, align 2, !tbaa !71
  %38 = shl i32 %0, 11
  %mul187 = and i32 %38, 2147475456
  %mul189 = shl nsw i32 %4, 12
  %mul193 = and i32 %38, 2048
  %39 = shl i32 %0, 8
  %mul200 = and i32 %39, 512
  %add201 = add nuw nsw i32 %and17, %mul189
  %add190 = add nuw nsw i32 %add201, %mul187
  %add194 = add nuw nsw i32 %add190, %mul193
  %add196 = add nuw nsw i32 %add194, %mul200
  %40 = zext nneg i32 %add196 to i64
  %add.ptr206 = getelementptr inbounds %struct.__half, ptr addrspace(1) %PackedK.coerce, i64 %40
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr206, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr134, i64 16, i1 false), !call_argsrelate !79
  %41 = getelementptr inbounds %struct.__half, ptr addrspace(1) %PackedK.coerce, i64 %40
  %add.ptr206.1 = getelementptr inbounds i8, ptr addrspace(1) %41, i64 2048
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr206.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr134.1, i64 16, i1 false), !call_argsrelate !79
  %and226 = shl i32 %0, 10
  %mul227 = and i32 %and226, 3072
  %add230 = add nuw nsw i32 %add190, %mul227
  %42 = zext nneg i32 %add230 to i64
  %add.ptr235 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Packed.coerce, i64 %42
  store i16 %19, ptr addrspace(1) %add.ptr235, align 16
  %packed_v.sroa.4.0.add.ptr235.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr235, i64 2
  store i16 %21, ptr addrspace(1) %packed_v.sroa.4.0.add.ptr235.sroa_idx, align 2, !tbaa !30
  %packed_v.sroa.5.0.add.ptr235.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr235, i64 4
  store i16 %23, ptr addrspace(1) %packed_v.sroa.5.0.add.ptr235.sroa_idx, align 4
  %packed_v.sroa.6.0.add.ptr235.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr235, i64 6
  store i16 %25, ptr addrspace(1) %packed_v.sroa.6.0.add.ptr235.sroa_idx, align 2, !tbaa !30
  %packed_v.sroa.7.0.add.ptr235.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr235, i64 8
  store i16 %26, ptr addrspace(1) %packed_v.sroa.7.0.add.ptr235.sroa_idx, align 8
  %packed_v.sroa.8.0.add.ptr235.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr235, i64 10
  store i16 %27, ptr addrspace(1) %packed_v.sroa.8.0.add.ptr235.sroa_idx, align 2, !tbaa !30
  %packed_v.sroa.9.0.add.ptr235.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr235, i64 12
  store i16 %28, ptr addrspace(1) %packed_v.sroa.9.0.add.ptr235.sroa_idx, align 4
  %packed_v.sroa.10.0.add.ptr235.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr235, i64 14
  store i16 %29, ptr addrspace(1) %packed_v.sroa.10.0.add.ptr235.sroa_idx, align 2, !tbaa !30
  %43 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Packed.coerce, i64 %42
  %add.ptr235.1 = getelementptr inbounds i8, ptr addrspace(1) %43, i64 1024
  store i16 %30, ptr addrspace(1) %add.ptr235.1, align 16
  %packed_v.sroa.13.16.add.ptr235.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %43, i64 1026
  store i16 %31, ptr addrspace(1) %packed_v.sroa.13.16.add.ptr235.1.sroa_idx, align 2, !tbaa !30
  %packed_v.sroa.14.16.add.ptr235.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %43, i64 1028
  store i16 %32, ptr addrspace(1) %packed_v.sroa.14.16.add.ptr235.1.sroa_idx, align 4
  %packed_v.sroa.15.16.add.ptr235.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %43, i64 1030
  store i16 %33, ptr addrspace(1) %packed_v.sroa.15.16.add.ptr235.1.sroa_idx, align 2, !tbaa !30
  %packed_v.sroa.16.16.add.ptr235.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %43, i64 1032
  store i16 %34, ptr addrspace(1) %packed_v.sroa.16.16.add.ptr235.1.sroa_idx, align 8
  %packed_v.sroa.17.16.add.ptr235.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %43, i64 1034
  store i16 %35, ptr addrspace(1) %packed_v.sroa.17.16.add.ptr235.1.sroa_idx, align 2, !tbaa !30
  %packed_v.sroa.18.16.add.ptr235.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %43, i64 1036
  store i16 %36, ptr addrspace(1) %packed_v.sroa.18.16.add.ptr235.1.sroa_idx, align 4
  %packed_v.sroa.19.16.add.ptr235.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %43, i64 1038
  store i16 %37, ptr addrspace(1) %packed_v.sroa.19.16.add.ptr235.1.sroa_idx, align 2, !tbaa !30
  ret void
}

declare i32 @llvm.mxc.block.id.x() #4

declare i32 @llvm.mxc.block.id.y() #4

declare i32 @llvm.mxc.block.id.z() #4

declare i32 @llvm.mxc.thread.id.x() #4

declare void @llvm.mxc.barrier.warp() #5

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #4

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #4

declare i1 @llvm.mxc.is.private(ptr nocapture) #4

declare void @llvm.mxc.sleep(i32 immarg) #6

declare void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noalias nocapture writeonly, ptr addrspace(4) noalias nocapture readonly, i64, i1 immarg) #7

declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #7

attributes #0 = { mustprogress noreturn nounwind "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { nounwind speculatable willreturn memory(none) }
attributes #5 = { convergent nounwind willreturn }
attributes #6 = { nounwind willreturn }
attributes #7 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }


