target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "mxc-metax-macahca"

%struct.mcDevMallocInfo.0 = type { i32, i32, ptr }
%struct.__half = type { i16 }

@buf_dyn_shmem = external protected addrspace(3) global [0 x i8], align 1024
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

define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %Indices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %PackedKV.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Schedule.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V.coerce) local_unnamed_addr #3 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %cmp = icmp ult i32 %0, 128
  br i1 %cmp, label %for.cond.preheader, label %if.else

for.cond.preheader:                               ; preds = %entry
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul = shl nsw i32 %1, 17
  %2 = shl nuw nsw i32 %0, 10
  %mul9 = and i32 %2, 129024
  %add = or disjoint i32 %mul9, %mul
  %3 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !48
  %4 = shl nuw nsw i32 %3, 4
  %mul14 = and i32 %4, 16256
  %add11 = add nuw nsw i32 %add, %mul14
  %and = shl nuw nsw i32 %0, 6
  %mul17 = and i32 %and, 64
  %and20 = shl nuw nsw i32 %3, 3
  %mul21 = and i32 %and20, 56
  %add15 = or disjoint i32 %add11, %mul17
  %add18 = or disjoint i32 %add15, %mul21
  %5 = zext nneg i32 %add18 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %5
  %6 = add nuw nsw i64 %5, 1024
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %6
  %add.ptr52 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %5
  %tile.sroa.0.0.copyload = load i64, ptr addrspace(4) %add.ptr52, align 16
  %tile.sroa.4.0.add.ptr52.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr52, i64 8
  %tile.sroa.4.0.copyload = load i64, ptr addrspace(4) %tile.sroa.4.0.add.ptr52.sroa_idx, align 8
  %add.ptr52.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %6
  %tile.sroa.5.16.copyload = load i64, ptr addrspace(4) %add.ptr52.1, align 16
  %tile.sroa.7.16.add.ptr52.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr52.1, i64 8
  %tile.sroa.7.16.copyload = load i64, ptr addrspace(4) %tile.sroa.7.16.add.ptr52.1.sroa_idx, align 8
  %mul72 = and i32 %and20, 8128
  %call76.masked = and i32 %3, 1016
  %mul78 = xor i32 %mul21, %call76.masked
  %invariant.gep567 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul72
  %invariant.gep569 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep567, i32 %mul78
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep569, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !56
  %gep570.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep569, i32 1024
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep570.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !call_argsrelate !56
  %and101 = shl nuw nsw i32 %3, 1
  %mul102 = and i32 %and101, 14
  %shr108 = lshr i32 %3, 3
  %xor110 = xor i32 %shr108, %mul102
  %.idx551 = shl nuw nsw i32 %xor110, 3
  %7 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep567, i32 %.idx551
  %add.ptr115 = getelementptr inbounds i8, ptr addrspace(3) %7, i32 2048
  store i64 %tile.sroa.0.0.copyload, ptr addrspace(3) %add.ptr115, align 8
  %add104.1 = or disjoint i32 %mul102, 1
  %xor110.1 = xor i32 %shr108, %add104.1
  %.idx551.1 = shl nuw nsw i32 %xor110.1, 3
  %8 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep567, i32 %.idx551.1
  %add.ptr115.1 = getelementptr inbounds i8, ptr addrspace(3) %8, i32 2048
  store i64 %tile.sroa.4.0.copyload, ptr addrspace(3) %add.ptr115.1, align 8
  %add109.2 = add nuw nsw i32 %shr108, 8
  %xor110.2 = xor i32 %add109.2, %mul102
  %gep573.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep567, i32 1024
  %.idx551.2 = shl nuw nsw i32 %xor110.2, 3
  %9 = getelementptr inbounds i8, ptr addrspace(3) %gep573.2, i32 %.idx551.2
  %add.ptr115.2 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 2048
  store i64 %tile.sroa.5.16.copyload, ptr addrspace(3) %add.ptr115.2, align 8
  %xor110.3 = xor i32 %add109.2, %add104.1
  %.idx551.3 = shl nuw nsw i32 %xor110.3, 3
  %10 = getelementptr inbounds i8, ptr addrspace(3) %gep573.2, i32 %.idx551.3
  %add.ptr115.3 = getelementptr inbounds i8, ptr addrspace(3) %10, i32 2048
  store i64 %tile.sroa.7.16.copyload, ptr addrspace(3) %add.ptr115.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and125 = shl nuw nsw i32 %3, 6
  %mul126 = and i32 %and125, 960
  %shr129 = lshr i32 %3, 4
  %and132 = and i32 %3, 7
  %11 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul126
  %xor133 = xor i32 %shr129, %and132
  %add.ptr137.idx = shl nuw nsw i32 %xor133, 4
  %add.ptr137 = getelementptr inbounds i8, ptr addrspace(3) %11, i32 %add.ptr137.idx
  %add130.1 = add nuw nsw i32 %shr129, 4
  %xor133.1 = xor i32 %add130.1, %and132
  %add.ptr137.idx.1 = shl nuw nsw i32 %xor133.1, 4
  %add.ptr137.1 = getelementptr inbounds i8, ptr addrspace(3) %11, i32 %add.ptr137.idx.1
  %mul152 = and i32 %4, 16128
  %and159 = lshr i32 %3, 2
  %shr160 = and i32 %and159, 3
  %mul164 = and i32 %and159, 252
  %and171 = and i32 %3, 3
  %add155 = or disjoint i32 %mul152, %and171
  %12 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add155
  %gep576.idx = shl nuw nsw i32 %and159, 3
  %gep576 = getelementptr inbounds i8, ptr addrspace(3) %12, i32 %gep576.idx
  %13 = load i16, ptr addrspace(3) %gep576, align 2, !tbaa !76
  %add166.1 = or disjoint i32 %mul164, 1
  %xor167.1 = xor i32 %shr160, %add166.1
  %add169.1 = or disjoint i32 %add155, 64
  %14 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add169.1
  %gep576.idx.1 = shl nuw nsw i32 %xor167.1, 3
  %gep576.1 = getelementptr inbounds i8, ptr addrspace(3) %14, i32 %gep576.idx.1
  %15 = load i16, ptr addrspace(3) %gep576.1, align 2, !tbaa !76
  %add166.2 = or disjoint i32 %mul164, 2
  %xor167.2 = xor i32 %shr160, %add166.2
  %add169.2 = or disjoint i32 %add155, 128
  %16 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add169.2
  %gep576.idx.2 = shl nuw nsw i32 %xor167.2, 3
  %gep576.2 = getelementptr inbounds i8, ptr addrspace(3) %16, i32 %gep576.idx.2
  %17 = load i16, ptr addrspace(3) %gep576.2, align 2, !tbaa !76
  %add166.3 = or i32 %and159, 3
  %add169.3 = or disjoint i32 %add155, 192
  %18 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add169.3
  %xor167.3 = shl nuw nsw i32 %and159, 3
  %gep576.idx.3 = xor i32 %xor167.3, 24
  %gep576.3 = getelementptr inbounds i8, ptr addrspace(3) %18, i32 %gep576.idx.3
  %19 = load i16, ptr addrspace(3) %gep576.3, align 2, !tbaa !76
  %add161.4 = or disjoint i32 %shr160, 4
  %xor167.4 = xor i32 %add161.4, %mul164
  %gep576.idx.4 = shl nuw nsw i32 %xor167.4, 3
  %gep576.4 = getelementptr inbounds i8, ptr addrspace(3) %12, i32 %gep576.idx.4
  %20 = load i16, ptr addrspace(3) %gep576.4, align 2, !tbaa !76
  %xor167.5 = xor i32 %add161.4, %add166.1
  %gep576.idx.5 = shl nuw nsw i32 %xor167.5, 3
  %gep576.5 = getelementptr inbounds i8, ptr addrspace(3) %14, i32 %gep576.idx.5
  %21 = load i16, ptr addrspace(3) %gep576.5, align 2, !tbaa !76
  %xor167.6 = xor i32 %add161.4, %add166.2
  %gep576.idx.6 = shl nuw nsw i32 %xor167.6, 3
  %gep576.6 = getelementptr inbounds i8, ptr addrspace(3) %16, i32 %gep576.idx.6
  %22 = load i16, ptr addrspace(3) %gep576.6, align 2, !tbaa !76
  %xor167.7 = xor i32 %add161.4, %add166.3
  %gep576.idx.7 = shl nuw nsw i32 %xor167.7, 3
  %gep576.7 = getelementptr inbounds i8, ptr addrspace(3) %18, i32 %gep576.idx.7
  %23 = load i16, ptr addrspace(3) %gep576.7, align 2, !tbaa !76
  %add161.8 = or disjoint i32 %shr160, 8
  %xor167.8 = xor i32 %add161.8, %mul164
  %gep576.idx.8 = shl nuw nsw i32 %xor167.8, 3
  %gep576.8 = getelementptr inbounds i8, ptr addrspace(3) %12, i32 %gep576.idx.8
  %24 = load i16, ptr addrspace(3) %gep576.8, align 2, !tbaa !76
  %xor167.9 = xor i32 %add161.8, %add166.1
  %gep576.idx.9 = shl nuw nsw i32 %xor167.9, 3
  %gep576.9 = getelementptr inbounds i8, ptr addrspace(3) %14, i32 %gep576.idx.9
  %25 = load i16, ptr addrspace(3) %gep576.9, align 2, !tbaa !76
  %xor167.10 = xor i32 %add161.8, %add166.2
  %gep576.idx.10 = shl nuw nsw i32 %xor167.10, 3
  %gep576.10 = getelementptr inbounds i8, ptr addrspace(3) %16, i32 %gep576.idx.10
  %26 = load i16, ptr addrspace(3) %gep576.10, align 2, !tbaa !76
  %xor167.11 = xor i32 %add161.8, %add166.3
  %gep576.idx.11 = shl nuw nsw i32 %xor167.11, 3
  %gep576.11 = getelementptr inbounds i8, ptr addrspace(3) %18, i32 %gep576.idx.11
  %27 = load i16, ptr addrspace(3) %gep576.11, align 2, !tbaa !76
  %add161.12 = or disjoint i32 %shr160, 12
  %xor167.12 = xor i32 %add161.12, %mul164
  %gep576.idx.12 = shl nuw nsw i32 %xor167.12, 3
  %gep576.12 = getelementptr inbounds i8, ptr addrspace(3) %12, i32 %gep576.idx.12
  %28 = load i16, ptr addrspace(3) %gep576.12, align 2, !tbaa !76
  %xor167.13 = xor i32 %add161.12, %add166.1
  %gep576.idx.13 = shl nuw nsw i32 %xor167.13, 3
  %gep576.13 = getelementptr inbounds i8, ptr addrspace(3) %14, i32 %gep576.idx.13
  %29 = load i16, ptr addrspace(3) %gep576.13, align 2, !tbaa !76
  %xor167.14 = xor i32 %add161.12, %add166.2
  %gep576.idx.14 = shl nuw nsw i32 %xor167.14, 3
  %gep576.14 = getelementptr inbounds i8, ptr addrspace(3) %16, i32 %gep576.idx.14
  %30 = load i16, ptr addrspace(3) %gep576.14, align 2, !tbaa !76
  %xor167.15 = xor i32 %add161.12, %add166.3
  %gep576.idx.15 = shl nuw nsw i32 %xor167.15, 3
  %gep576.15 = getelementptr inbounds i8, ptr addrspace(3) %18, i32 %gep576.idx.15
  %31 = load i16, ptr addrspace(3) %gep576.15, align 2, !tbaa !76
  %mul189 = shl nsw i32 %1, 18
  %32 = shl nuw nsw i32 %0, 11
  %33 = and i32 %32, 256000
  %34 = shl nuw nsw i32 %0, 8
  %mul203 = and i32 %34, 512
  %add204 = or disjoint i32 %and20, %mul189
  %add197 = add nuw nsw i32 %add204, %33
  %add199 = add nuw nsw i32 %add197, %mul203
  %35 = zext nneg i32 %add199 to i64
  %add.ptr209 = getelementptr inbounds %struct.__half, ptr addrspace(1) %PackedKV.coerce, i64 %35
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr209, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr137, i64 16, i1 false), !call_argsrelate !84
  %36 = getelementptr inbounds %struct.__half, ptr addrspace(1) %PackedKV.coerce, i64 %35
  %add.ptr209.1 = getelementptr inbounds i8, ptr addrspace(1) %36, i64 2048
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr209.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr137.1, i64 16, i1 false), !call_argsrelate !84
  %mul226 = and i32 %32, 253952
  %mul230 = and i32 %2, 3072
  %add231 = or disjoint i32 %add204, %mul226
  %add233 = add nuw nsw i32 %add231, %mul230
  %invariant.gep579 = getelementptr inbounds i8, ptr addrspace(1) %PackedKV.coerce, i64 8192
  %37 = zext nneg i32 %add233 to i64
  %gep580 = getelementptr inbounds %struct.__half, ptr addrspace(1) %invariant.gep579, i64 %37
  store i16 %13, ptr addrspace(1) %gep580, align 16
  %packed_v.sroa.4.0.gep580.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %gep580, i64 2
  store i16 %15, ptr addrspace(1) %packed_v.sroa.4.0.gep580.sroa_idx, align 2, !tbaa !30
  %packed_v.sroa.5.0.gep580.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %gep580, i64 4
  store i16 %17, ptr addrspace(1) %packed_v.sroa.5.0.gep580.sroa_idx, align 4
  %packed_v.sroa.6.0.gep580.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %gep580, i64 6
  store i16 %19, ptr addrspace(1) %packed_v.sroa.6.0.gep580.sroa_idx, align 2, !tbaa !30
  %packed_v.sroa.7.0.gep580.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %gep580, i64 8
  store i16 %20, ptr addrspace(1) %packed_v.sroa.7.0.gep580.sroa_idx, align 8
  %packed_v.sroa.8.0.gep580.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %gep580, i64 10
  store i16 %21, ptr addrspace(1) %packed_v.sroa.8.0.gep580.sroa_idx, align 2, !tbaa !30
  %packed_v.sroa.9.0.gep580.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %gep580, i64 12
  store i16 %22, ptr addrspace(1) %packed_v.sroa.9.0.gep580.sroa_idx, align 4
  %packed_v.sroa.10.0.gep580.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %gep580, i64 14
  store i16 %23, ptr addrspace(1) %packed_v.sroa.10.0.gep580.sroa_idx, align 2, !tbaa !30
  %38 = getelementptr inbounds %struct.__half, ptr addrspace(1) %invariant.gep579, i64 %37
  %gep580.1 = getelementptr inbounds i8, ptr addrspace(1) %38, i64 1024
  store i16 %24, ptr addrspace(1) %gep580.1, align 16
  %packed_v.sroa.13.16.gep580.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %38, i64 1026
  store i16 %25, ptr addrspace(1) %packed_v.sroa.13.16.gep580.1.sroa_idx, align 2, !tbaa !30
  %packed_v.sroa.14.16.gep580.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %38, i64 1028
  store i16 %26, ptr addrspace(1) %packed_v.sroa.14.16.gep580.1.sroa_idx, align 4
  %packed_v.sroa.15.16.gep580.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %38, i64 1030
  store i16 %27, ptr addrspace(1) %packed_v.sroa.15.16.gep580.1.sroa_idx, align 2, !tbaa !30
  %packed_v.sroa.16.16.gep580.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %38, i64 1032
  store i16 %28, ptr addrspace(1) %packed_v.sroa.16.16.gep580.1.sroa_idx, align 8
  %packed_v.sroa.17.16.gep580.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %38, i64 1034
  store i16 %29, ptr addrspace(1) %packed_v.sroa.17.16.gep580.1.sroa_idx, align 2, !tbaa !30
  %packed_v.sroa.18.16.gep580.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %38, i64 1036
  store i16 %30, ptr addrspace(1) %packed_v.sroa.18.16.gep580.1.sroa_idx, align 4
  %packed_v.sroa.19.16.gep580.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %38, i64 1038
  store i16 %31, ptr addrspace(1) %packed_v.sroa.19.16.gep580.1.sroa_idx, align 2, !tbaa !30
  br label %if.end478

if.else:                                          ; preds = %entry
  %39 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !48
  %40 = getelementptr inbounds i32, ptr addrspace(3) @buf_dyn_shmem, i32 %39
  %arrayidx246 = getelementptr inbounds i8, ptr addrspace(3) %40, i32 4608
  store i32 0, ptr addrspace(3) %arrayidx246, align 4, !tbaa !30
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %41 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul257 = shl nsw i32 %41, 10
  %mul259 = shl nsw i32 %0, 7
  %add260 = add nuw nsw i32 %mul259, %39
  %add262 = add nuw nsw i32 %add260, %mul257
  %invariant.gep = getelementptr i8, ptr addrspace(1) %Indices.coerce, i64 -65536
  %mul272 = shl nsw i32 %0, 2
  %shr276 = lshr i32 %39, 5
  %add274 = add nuw nsw i32 %shr276, %mul272
  %42 = zext nneg i32 %add262 to i64
  %gep = getelementptr i32, ptr addrspace(1) %invariant.gep, i64 %42
  %43 = load i32, ptr addrspace(1) %gep, align 4, !tbaa !30
  %or.cond582 = icmp ugt i32 %43, 31
  %add270 = or disjoint i32 %43, 512
  %cmp278.not = icmp sgt i32 %add270, %add274
  %or.cond611 = select i1 %or.cond582, i1 true, i1 %cmp278.not
  %condval.0 = select i1 %or.cond611, i32 32, i32 %43
  %gep554 = getelementptr i32, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4608), i32 %condval.0
  %44 = atomicrmw add ptr addrspace(3) %gep554, i32 1 syncscope("device-one-as") monotonic, align 4, !argrelate !111
  %45 = getelementptr i32, ptr addrspace(1) %invariant.gep, i64 %42
  %gep.1 = getelementptr i8, ptr addrspace(1) %45, i64 256
  %46 = load i32, ptr addrspace(1) %gep.1, align 4, !tbaa !30
  %or.cond582.1 = icmp ult i32 %46, 32
  br i1 %or.cond582.1, label %land.lhs.true269.1, label %if.else280.1

land.lhs.true269.1:                               ; preds = %if.else
  %add270.1 = or disjoint i32 %46, 512
  %narrow = add nuw i32 %add274, 2
  %cmp278.not.1 = icmp sgt i32 %add270.1, %narrow
  br i1 %cmp278.not.1, label %if.else280.1, label %if.end.1

if.else280.1:                                     ; preds = %land.lhs.true269.1, %if.else
  br label %if.end.1

if.end.1:                                         ; preds = %if.else280.1, %land.lhs.true269.1
  %condval.0.1 = phi i32 [ 32, %if.else280.1 ], [ %46, %land.lhs.true269.1 ]
  %gep554.1 = getelementptr i32, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4608), i32 %condval.0.1
  %47 = atomicrmw add ptr addrspace(3) %gep554.1, i32 1 syncscope("device-one-as") monotonic, align 4, !argrelate !111
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %48 = load i32, ptr addrspace(3) %arrayidx246, align 4, !tbaa !30
  %mul297 = shl nsw i32 %48, 16
  %add302 = add nsw i32 %48, 1
  %shr303 = ashr i32 %add302, 1
  %add304 = add i32 %shr303, %mul297
  %49 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %50 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %49) #9
  %sub.i = add i32 %50, -1
  %and.i = and i32 %50, -64
  %cmp.i = icmp slt i32 %sub.i, %and.i
  %cond.i = select i1 %cmp.i, i32 %50, i32 %sub.i
  %shl.i = shl i32 %cond.i, 2
  %51 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i, i32 %add304)
  %cmp315.not = icmp eq i32 %39, 0
  %add318 = select i1 %cmp315.not, i32 0, i32 %51
  %spec.select = add nsw i32 %add318, %add304
  %52 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %53 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %52) #9
  %sub.i.1 = add i32 %53, -2
  %and.i.1 = and i32 %53, -64
  %cmp.i.1 = icmp slt i32 %sub.i.1, %and.i.1
  %cond.i.1 = select i1 %cmp.i.1, i32 %53, i32 %sub.i.1
  %shl.i.1 = shl i32 %cond.i.1, 2
  %54 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.1, i32 %spec.select)
  %cmp315.not.1 = icmp ult i32 %39, 2
  %add318.1 = select i1 %cmp315.not.1, i32 0, i32 %54
  %spec.select.1 = add nsw i32 %add318.1, %spec.select
  %55 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %56 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %55) #9
  %sub.i.2 = add i32 %56, -4
  %and.i.2 = and i32 %56, -64
  %cmp.i.2 = icmp slt i32 %sub.i.2, %and.i.2
  %cond.i.2 = select i1 %cmp.i.2, i32 %56, i32 %sub.i.2
  %shl.i.2 = shl i32 %cond.i.2, 2
  %57 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.2, i32 %spec.select.1)
  %cmp315.not.2 = icmp ult i32 %39, 4
  %add318.2 = select i1 %cmp315.not.2, i32 0, i32 %57
  %spec.select.2 = add nsw i32 %add318.2, %spec.select.1
  %58 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %59 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %58) #9
  %sub.i.3 = add i32 %59, -8
  %and.i.3 = and i32 %59, -64
  %cmp.i.3 = icmp slt i32 %sub.i.3, %and.i.3
  %cond.i.3 = select i1 %cmp.i.3, i32 %59, i32 %sub.i.3
  %shl.i.3 = shl i32 %cond.i.3, 2
  %60 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.3, i32 %spec.select.2)
  %cmp315.not.3 = icmp ult i32 %39, 8
  %add318.3 = select i1 %cmp315.not.3, i32 0, i32 %60
  %spec.select.3 = add nsw i32 %add318.3, %spec.select.2
  %61 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %62 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %61) #9
  %sub.i.4 = add i32 %62, -16
  %and.i.4 = and i32 %62, -64
  %cmp.i.4 = icmp slt i32 %sub.i.4, %and.i.4
  %cond.i.4 = select i1 %cmp.i.4, i32 %62, i32 %sub.i.4
  %shl.i.4 = shl i32 %cond.i.4, 2
  %63 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.4, i32 %spec.select.3)
  %cmp315.not.4 = icmp ult i32 %39, 16
  %add318.4 = select i1 %cmp315.not.4, i32 0, i32 %63
  %spec.select.4 = add nsw i32 %add318.4, %spec.select.3
  %64 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %65 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %64) #9
  %sub.i.5 = add i32 %65, -32
  %and.i.5 = and i32 %65, -64
  %cmp.i.5 = icmp slt i32 %sub.i.5, %and.i.5
  %cond.i.5 = select i1 %cmp.i.5, i32 %65, i32 %sub.i.5
  %shl.i.5 = shl i32 %cond.i.5, 2
  %66 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.5, i32 %spec.select.4)
  %cmp315.not.5 = icmp ult i32 %39, 32
  %add318.5 = select i1 %cmp315.not.5, i32 0, i32 %66
  %spec.select.5 = add nsw i32 %add318.5, %spec.select.4
  %sub337 = sub i32 %spec.select.5, %add304
  %arrayidx341 = getelementptr inbounds i8, ptr addrspace(3) %40, i32 4864
  store i32 %sub337, ptr addrspace(3) %arrayidx341, align 4, !tbaa !30
  %cmp343 = icmp eq i32 %39, 63
  %mul348 = mul nuw nsw i32 %41, 1928
  %mul350 = mul nuw nsw i32 %0, 241
  %add351 = add nuw nsw i32 %mul348, %mul350
  br i1 %cmp343, label %if.then344, label %if.end355

if.then344:                                       ; preds = %if.end.1
  %67 = zext nneg i32 %add351 to i64
  %68 = getelementptr i32, ptr addrspace(1) %Schedule.coerce, i64 %67
  %arrayidx354 = getelementptr i8, ptr addrspace(1) %68, i64 -123392
  %and346 = and i32 %spec.select.5, 65535
  store i32 %and346, ptr addrspace(1) %arrayidx354, align 4, !tbaa !30
  br label %if.end355

if.end355:                                        ; preds = %if.end.1, %if.then344
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add364 = or disjoint i32 %39, -16384
  %add366 = add nsw i32 %add364, %mul259
  %gep559 = getelementptr i32, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4864), i32 %condval.0
  %69 = load i32, ptr addrspace(3) %gep559, align 4, !tbaa !30
  %70 = ashr i32 %69, 16
  %71 = getelementptr i32, ptr addrspace(3) @buf_dyn_shmem, i32 %70
  %72 = getelementptr i32, ptr addrspace(3) %71, i32 %44
  %arrayidx380 = getelementptr i8, ptr addrspace(3) %72, i32 4096
  store i32 %add366, ptr addrspace(3) %arrayidx380, align 4, !tbaa !30
  %sub367.1 = add nsw i32 %add366, 64
  %gep559.1 = getelementptr i32, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4864), i32 %condval.0.1
  %73 = load i32, ptr addrspace(3) %gep559.1, align 4, !tbaa !30
  %74 = ashr i32 %73, 16
  %75 = getelementptr i32, ptr addrspace(3) @buf_dyn_shmem, i32 %74
  %76 = getelementptr i32, ptr addrspace(3) %75, i32 %47
  %arrayidx380.1 = getelementptr i8, ptr addrspace(3) %76, i32 4096
  store i32 %sub367.1, ptr addrspace(3) %arrayidx380.1, align 4, !tbaa !30
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %invariant.gep561 = getelementptr i8, ptr addrspace(1) %Schedule.coerce, i64 -123380
  %77 = and i32 %44, 1
  %cmp391 = icmp eq i32 %77, 0
  br i1 %cmp391, label %if.then392, label %for.inc475

if.then392:                                       ; preds = %if.end355
  %78 = getelementptr i32, ptr addrspace(3) @buf_dyn_shmem, i32 %condval.0
  %arrayidx397 = getelementptr i8, ptr addrspace(3) %78, i32 4864
  %79 = load i32, ptr addrspace(3) %arrayidx397, align 4, !tbaa !30
  %shr400 = ashr exact i32 %44, 1
  %and401 = and i32 %79, 65535
  %add402 = add nsw i32 %and401, %shr400
  %or.cond = icmp ult i32 %add402, 80
  br i1 %or.cond, label %if.then406, label %if.end437

if.then406:                                       ; preds = %if.then392
  %mul414 = mul nuw nsw i32 %add402, 3
  %add415 = add nuw nsw i32 %add351, %mul414
  %80 = zext nneg i32 %add415 to i64
  %81 = getelementptr i32, ptr addrspace(1) %Schedule.coerce, i64 %80
  %arrayidx418 = getelementptr i8, ptr addrspace(1) %81, i64 -123388
  store i32 %condval.0, ptr addrspace(1) %arrayidx418, align 4, !tbaa !30
  %arrayidx435 = getelementptr i8, ptr addrspace(1) %81, i64 -123384
  store i32 %add366, ptr addrspace(1) %arrayidx435, align 4, !tbaa !30
  br label %if.end437

if.end437:                                        ; preds = %if.then406, %if.then392
  %82 = add nsw i32 %add402, 1
  %or.cond550 = icmp ult i32 %82, 81
  br i1 %or.cond550, label %if.then441, label %for.inc475

if.then441:                                       ; preds = %if.end437
  %add444 = or disjoint i32 %44, 1
  %arrayidx449 = getelementptr i8, ptr addrspace(3) %78, i32 4608
  %83 = load i32, ptr addrspace(3) %arrayidx449, align 4, !tbaa !30
  %cmp450 = icmp slt i32 %add444, %83
  br i1 %cmp450, label %if.then451, label %if.end461

if.then451:                                       ; preds = %if.then441
  %84 = ashr i32 %79, 16
  %85 = getelementptr i32, ptr addrspace(3) @buf_dyn_shmem, i32 %84
  %86 = getelementptr i32, ptr addrspace(3) %85, i32 %44
  %arrayidx459 = getelementptr i8, ptr addrspace(3) %86, i32 4100
  %87 = load i32, ptr addrspace(3) %arrayidx459, align 4, !tbaa !30
  br label %if.end461

if.end461:                                        ; preds = %if.then441, %if.then451
  %condval_1.0 = phi i32 [ %87, %if.then451 ], [ -1, %if.then441 ]
  %mul467 = mul nsw i32 %add402, 3
  %add468 = add nsw i32 %add351, %mul467
  %88 = sext i32 %add468 to i64
  %gep562 = getelementptr i32, ptr addrspace(1) %invariant.gep561, i64 %88
  store i32 %condval_1.0, ptr addrspace(1) %gep562, align 4, !tbaa !30
  br label %for.inc475

for.inc475:                                       ; preds = %if.end437, %if.end461, %if.end355
  %89 = and i32 %47, 1
  %cmp391.1 = icmp eq i32 %89, 0
  br i1 %cmp391.1, label %if.then392.1, label %if.end478

if.then392.1:                                     ; preds = %for.inc475
  %90 = getelementptr i32, ptr addrspace(3) @buf_dyn_shmem, i32 %condval.0.1
  %arrayidx397.1 = getelementptr i8, ptr addrspace(3) %90, i32 4864
  %91 = load i32, ptr addrspace(3) %arrayidx397.1, align 4, !tbaa !30
  %shr400.1 = ashr exact i32 %47, 1
  %and401.1 = and i32 %91, 65535
  %add402.1 = add nsw i32 %and401.1, %shr400.1
  %or.cond.1 = icmp ult i32 %add402.1, 80
  br i1 %or.cond.1, label %if.then406.1, label %if.end437.1

if.then406.1:                                     ; preds = %if.then392.1
  %mul414.1 = mul nuw nsw i32 %add402.1, 3
  %add415.1 = add nuw nsw i32 %add351, %mul414.1
  %92 = zext nneg i32 %add415.1 to i64
  %93 = getelementptr i32, ptr addrspace(1) %Schedule.coerce, i64 %92
  %arrayidx418.1 = getelementptr i8, ptr addrspace(1) %93, i64 -123388
  store i32 %condval.0.1, ptr addrspace(1) %arrayidx418.1, align 4, !tbaa !30
  %arrayidx435.1 = getelementptr i8, ptr addrspace(1) %93, i64 -123384
  store i32 %sub367.1, ptr addrspace(1) %arrayidx435.1, align 4, !tbaa !30
  br label %if.end437.1

if.end437.1:                                      ; preds = %if.then406.1, %if.then392.1
  %94 = add nsw i32 %add402.1, 1
  %or.cond550.1 = icmp ult i32 %94, 81
  br i1 %or.cond550.1, label %if.then441.1, label %if.end478

if.then441.1:                                     ; preds = %if.end437.1
  %add444.1 = or disjoint i32 %47, 1
  %arrayidx449.1 = getelementptr i8, ptr addrspace(3) %90, i32 4608
  %95 = load i32, ptr addrspace(3) %arrayidx449.1, align 4, !tbaa !30
  %cmp450.1 = icmp slt i32 %add444.1, %95
  br i1 %cmp450.1, label %if.then451.1, label %if.end461.1

if.then451.1:                                     ; preds = %if.then441.1
  %96 = ashr i32 %91, 16
  %97 = getelementptr i32, ptr addrspace(3) @buf_dyn_shmem, i32 %96
  %98 = getelementptr i32, ptr addrspace(3) %97, i32 %47
  %arrayidx459.1 = getelementptr i8, ptr addrspace(3) %98, i32 4100
  %99 = load i32, ptr addrspace(3) %arrayidx459.1, align 4, !tbaa !30
  br label %if.end461.1

if.end461.1:                                      ; preds = %if.then451.1, %if.then441.1
  %condval_1.0.1 = phi i32 [ %99, %if.then451.1 ], [ -1, %if.then441.1 ]
  %mul467.1 = mul nsw i32 %add402.1, 3
  %add468.1 = add nsw i32 %add351, %mul467.1
  %100 = sext i32 %add468.1 to i64
  %gep562.1 = getelementptr i32, ptr addrspace(1) %invariant.gep561, i64 %100
  store i32 %condval_1.0.1, ptr addrspace(1) %gep562.1, align 4, !tbaa !30
  br label %if.end478

if.end478:                                        ; preds = %for.inc475, %if.end437.1, %if.end461.1, %for.cond.preheader
  ret void
}

declare i32 @llvm.mxc.block.id.x() #4

declare i32 @llvm.mxc.block.id.y() #4

declare i32 @llvm.mxc.block.id.z() #4

declare i32 @llvm.mxc.thread.id.x() #4

declare void @llvm.mxc.barrier.warp() #5

declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #6

declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #6

declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #6

declare i1 @llvm.mxc.is.private(ptr nocapture) #4

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #4

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #4

declare void @llvm.mxc.sleep(i32 immarg) #7

declare void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noalias nocapture writeonly, ptr addrspace(4) noalias nocapture readonly, i64, i1 immarg) #8

declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #8

attributes #0 = { mustprogress noreturn nounwind "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { nounwind speculatable willreturn memory(none) }
attributes #5 = { convergent nounwind willreturn }
attributes #6 = { convergent nounwind willreturn memory(none) }
attributes #7 = { nounwind willreturn }
attributes #8 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #9 = { nomerge }


