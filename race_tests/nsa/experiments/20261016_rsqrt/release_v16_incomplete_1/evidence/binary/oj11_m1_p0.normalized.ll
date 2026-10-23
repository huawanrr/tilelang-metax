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

define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %Indices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K_blocks.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V_blocks.coerce) local_unnamed_addr #3 {
entry:
  %blocks = alloca [4 x i32], align 4, addrspace(5)
  call void @llvm.lifetime.start.p5(i64 16, ptr addrspace(5) %blocks) #12, !call_argsrelate !43
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !range !29
  %mul = shl nsw i32 %0, 19
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul7 = shl nsw i32 %1, 10
  %add = add nuw nsw i32 %mul, %mul7
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !44
  %and = shl nuw nsw i32 %2, 6
  %mul9 = and i32 %and, 960
  %add10 = or disjoint i32 %add, %mul9
  %3 = lshr i32 %2, 1
  %mul14 = and i32 %3, 504
  %add12 = add nuw nsw i32 %add10, %mul14
  %4 = zext nneg i32 %add12 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16
  %q.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %q.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %q.sroa.4.0.add.ptr.sroa_idx, align 8
  %5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %5, i64 64
  %q.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16
  %q.sroa.7.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %5, i64 72
  %q.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %q.sroa.7.16.add.ptr.1.sroa_idx, align 8
  %mul25 = shl nsw i32 %0, 11
  %mul27 = shl nsw i32 %1, 2
  %add28 = add nuw nsw i32 %mul25, %mul27
  %6 = zext nneg i32 %add28 to i64
  %arrayidx30 = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %6
  %7 = load i32, ptr addrspace(1) %arrayidx30, align 4, !tbaa !30
  store i32 %7, ptr addrspace(5) %blocks, align 4, !tbaa !30
  %8 = or disjoint i64 %6, 1
  %arrayidx30.1 = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %8
  %9 = load i32, ptr addrspace(1) %arrayidx30.1, align 4, !tbaa !30
  %arrayidx32.1 = getelementptr inbounds i8, ptr addrspace(5) %blocks, i32 4
  store i32 %9, ptr addrspace(5) %arrayidx32.1, align 4, !tbaa !30
  %10 = or disjoint i64 %6, 2
  %arrayidx30.2 = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %10
  %11 = load i32, ptr addrspace(1) %arrayidx30.2, align 4, !tbaa !30
  %arrayidx32.2 = getelementptr inbounds i8, ptr addrspace(5) %blocks, i32 8
  store i32 %11, ptr addrspace(5) %arrayidx32.2, align 4, !tbaa !30
  %12 = or disjoint i64 %6, 3
  %arrayidx30.3 = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %12
  %13 = load i32, ptr addrspace(1) %arrayidx30.3, align 4, !tbaa !30
  %arrayidx32.3 = getelementptr inbounds i8, ptr addrspace(5) %blocks, i32 12
  store i32 %13, ptr addrspace(5) %arrayidx32.3, align 4, !tbaa !30
  %or.cond = icmp ugt i32 %7, 31
  %shr41 = lshr i32 %1, 4
  %cmp42.not = icmp ugt i32 %7, %shr41
  %or.cond987 = or i1 %or.cond, %cmp42.not
  br i1 %or.cond987, label %if.end, label %for.cond43.preheader

for.cond43.preheader:                             ; preds = %entry
  %mul53 = shl nsw i32 %0, 15
  %mul54 = shl nuw nsw i32 %7, 10
  %mul59 = shl nuw nsw i32 %2, 3
  %add55 = or disjoint i32 %mul59, %mul53
  %add57 = add nuw nsw i32 %add55, %mul54
  %14 = zext nneg i32 %add57 to i64
  %add.ptr64 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %14
  %15 = load i32, ptr addrspace(4) %add.ptr64, align 4, !tbaa !30
  %16 = or disjoint i64 %14, 2
  %add.ptr64.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %16
  %17 = load i32, ptr addrspace(4) %add.ptr64.1, align 4, !tbaa !30
  %18 = or disjoint i64 %14, 4
  %add.ptr64.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %18
  %19 = load i32, ptr addrspace(4) %add.ptr64.2, align 4, !tbaa !30
  %20 = or disjoint i64 %14, 6
  %add.ptr64.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %20
  %21 = load i32, ptr addrspace(4) %add.ptr64.3, align 4, !tbaa !30
  %22 = add nuw nsw i64 %14, 512
  %add.ptr64.1789 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %22
  %23 = load i32, ptr addrspace(4) %add.ptr64.1789, align 4, !tbaa !30
  %24 = add nuw nsw i64 %14, 514
  %add.ptr64.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %24
  %25 = load i32, ptr addrspace(4) %add.ptr64.1.1, align 4, !tbaa !30
  %26 = add nuw nsw i64 %14, 516
  %add.ptr64.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %26
  %27 = load i32, ptr addrspace(4) %add.ptr64.2.1, align 4, !tbaa !30
  %28 = add nuw nsw i64 %14, 518
  %add.ptr64.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %28
  %29 = load i32, ptr addrspace(4) %add.ptr64.3.1, align 4, !tbaa !30
  %add.ptr97 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %14
  %30 = load i32, ptr addrspace(4) %add.ptr97, align 4, !tbaa !30
  %add.ptr97.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %16
  %31 = load i32, ptr addrspace(4) %add.ptr97.1, align 4, !tbaa !30
  %add.ptr97.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %18
  %32 = load i32, ptr addrspace(4) %add.ptr97.2, align 4, !tbaa !30
  %add.ptr97.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %20
  %33 = load i32, ptr addrspace(4) %add.ptr97.3, align 4, !tbaa !30
  %add.ptr97.1801 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %22
  %34 = load i32, ptr addrspace(4) %add.ptr97.1801, align 4, !tbaa !30
  %add.ptr97.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %24
  %35 = load i32, ptr addrspace(4) %add.ptr97.1.1, align 4, !tbaa !30
  %add.ptr97.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %26
  %36 = load i32, ptr addrspace(4) %add.ptr97.2.1, align 4, !tbaa !30
  %add.ptr97.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %28
  %37 = load i32, ptr addrspace(4) %add.ptr97.3.1, align 4, !tbaa !30
  br label %if.end

if.end:                                           ; preds = %entry, %for.cond43.preheader
  %k.sroa.18.0 = phi i32 [ %29, %for.cond43.preheader ], [ undef, %entry ]
  %k.sroa.16.0 = phi i32 [ %27, %for.cond43.preheader ], [ undef, %entry ]
  %k.sroa.14.0 = phi i32 [ %25, %for.cond43.preheader ], [ undef, %entry ]
  %k.sroa.11.0 = phi i32 [ %23, %for.cond43.preheader ], [ undef, %entry ]
  %k.sroa.9.0 = phi i32 [ %21, %for.cond43.preheader ], [ undef, %entry ]
  %k.sroa.7.0 = phi i32 [ %19, %for.cond43.preheader ], [ undef, %entry ]
  %k.sroa.5.0 = phi i32 [ %17, %for.cond43.preheader ], [ undef, %entry ]
  %k.sroa.0.0 = phi i32 [ %15, %for.cond43.preheader ], [ undef, %entry ]
  %v.sroa.18.0 = phi i32 [ %37, %for.cond43.preheader ], [ undef, %entry ]
  %v.sroa.16.0 = phi i32 [ %36, %for.cond43.preheader ], [ undef, %entry ]
  %v.sroa.14.0 = phi i32 [ %35, %for.cond43.preheader ], [ undef, %entry ]
  %v.sroa.11.0 = phi i32 [ %34, %for.cond43.preheader ], [ undef, %entry ]
  %v.sroa.9.0 = phi i32 [ %33, %for.cond43.preheader ], [ undef, %entry ]
  %v.sroa.7.0 = phi i32 [ %32, %for.cond43.preheader ], [ undef, %entry ]
  %v.sroa.5.0 = phi i32 [ %31, %for.cond43.preheader ], [ undef, %entry ]
  %v.sroa.0.0 = phi i32 [ %30, %for.cond43.preheader ], [ undef, %entry ]
  %38 = shl nuw nsw i32 %2, 3
  %mul151 = and i32 %38, 8128
  %xor716 = and i32 %38, 56
  %call155.masked = and i32 %2, 1016
  %mul157 = xor i32 %xor716, %call155.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul151
  %invariant.gep731 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul157
  %39 = lshr i32 %2, 2
  %mul176 = and i32 %39, 252
  %shr204 = lshr i32 %2, 4
  %and207 = and i32 %2, 7
  %40 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul9
  %invariant.gep743 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep731, i32 2048
  %mul319 = shl nsw i32 %0, 15
  %add321 = or disjoint i32 %38, %mul319
  %41 = shl nuw nsw i32 %2, 4
  %mul396 = and i32 %41, 16128
  %and401 = lshr i32 %2, 3
  %shr402 = and i32 %and401, 1
  %mul407 = and i32 %39, 4
  %k.sroa.5.0.invariant.gep731.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep731, i32 4
  %k.sroa.7.0.invariant.gep731.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep731, i32 8
  %k.sroa.9.0.invariant.gep731.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep731, i32 12
  %gep732.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep731, i32 1024
  %k.sroa.14.16.gep732.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep731, i32 1028
  %k.sroa.16.16.gep732.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep731, i32 1032
  %k.sroa.18.16.gep732.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep731, i32 1036
  %xor208 = xor i32 %shr204, %and207
  %add.ptr212.idx = shl nuw nsw i32 %xor208, 4
  %add.ptr212 = getelementptr inbounds i8, ptr addrspace(3) %40, i32 %add.ptr212.idx
  %kb.sroa.6.0.add.ptr212.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr212, i32 8
  %add205.1 = add nuw nsw i32 %shr204, 4
  %xor208.1 = xor i32 %add205.1, %and207
  %add.ptr212.idx.1 = shl nuw nsw i32 %xor208.1, 4
  %add.ptr212.1 = getelementptr inbounds i8, ptr addrspace(3) %40, i32 %add.ptr212.idx.1
  %kb.sroa.6.0.add.ptr212.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr212.1, i32 8
  %v.sroa.5.0.invariant.gep743.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep731, i32 2052
  %v.sroa.7.0.invariant.gep743.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep731, i32 2056
  %v.sroa.9.0.invariant.gep743.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep731, i32 2060
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep731, i32 3072
  %v.sroa.14.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep731, i32 3076
  %v.sroa.16.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep731, i32 3080
  %v.sroa.18.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep731, i32 3084
  %xor409 = or disjoint i32 %mul407, %shr402
  %mul410 = shl nuw nsw i32 %xor409, 3
  %add411 = or disjoint i32 %mul410, %mul396
  %add414 = or disjoint i32 %add411, %and207
  %gep751 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414
  %add398.1 = or disjoint i32 %mul396, 64
  %add408.1 = or disjoint i32 %mul407, 1
  %xor409.1 = xor i32 %add408.1, %shr402
  %mul410.1 = shl nuw nsw i32 %xor409.1, 3
  %add411.1 = or disjoint i32 %mul410.1, %add398.1
  %add414.1 = or disjoint i32 %add411.1, %and207
  %gep751.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414.1
  %add398.2 = or disjoint i32 %mul396, 128
  %add408.2 = or disjoint i32 %mul407, 2
  %xor409.2 = or disjoint i32 %add408.2, %shr402
  %mul410.2 = shl nuw nsw i32 %xor409.2, 3
  %add411.2 = or disjoint i32 %mul410.2, %add398.2
  %add414.2 = or disjoint i32 %add411.2, %and207
  %gep751.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414.2
  %add398.3 = or disjoint i32 %mul396, 192
  %add408.3 = or disjoint i32 %mul407, 3
  %xor409.3 = xor i32 %add408.3, %shr402
  %mul410.3 = shl nuw nsw i32 %xor409.3, 3
  %add411.3 = or disjoint i32 %mul410.3, %add398.3
  %add414.3 = or disjoint i32 %add411.3, %and207
  %gep751.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414.3
  %add403.1 = or disjoint i32 %shr402, 2
  %xor409.1829 = or disjoint i32 %mul407, %add403.1
  %mul410.1830 = shl nuw nsw i32 %xor409.1829, 3
  %add411.1831 = or disjoint i32 %mul410.1830, %mul396
  %add414.1832 = or disjoint i32 %add411.1831, %and207
  %gep751.1833 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414.1832
  %xor409.1.1 = xor i32 %add408.1, %add403.1
  %mul410.1.1 = shl nuw nsw i32 %xor409.1.1, 3
  %add411.1.1 = or disjoint i32 %mul410.1.1, %add398.1
  %add414.1.1 = or disjoint i32 %add411.1.1, %and207
  %gep751.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414.1.1
  %xor409.2.1 = xor i32 %add408.2, %add403.1
  %mul410.2.1 = shl nuw nsw i32 %xor409.2.1, 3
  %add411.2.1 = or disjoint i32 %mul410.2.1, %add398.2
  %add414.2.1 = or disjoint i32 %add411.2.1, %and207
  %gep751.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414.2.1
  %xor409.3.1 = xor i32 %add408.3, %add403.1
  %mul410.3.1 = shl nuw nsw i32 %xor409.3.1, 3
  %add411.3.1 = or disjoint i32 %mul410.3.1, %add398.3
  %add414.3.1 = or disjoint i32 %add411.3.1, %and207
  %gep751.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414.3.1
  %add403.2 = or disjoint i32 %shr402, 4
  %xor409.2835 = xor i32 %mul407, %add403.2
  %mul410.2836 = shl nuw nsw i32 %xor409.2835, 3
  %add411.2837 = or disjoint i32 %mul410.2836, %mul396
  %add414.2838 = or disjoint i32 %add411.2837, %and207
  %gep751.2839 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414.2838
  %xor409.1.2 = xor i32 %add408.1, %add403.2
  %mul410.1.2 = shl nuw nsw i32 %xor409.1.2, 3
  %add411.1.2 = or disjoint i32 %mul410.1.2, %add398.1
  %add414.1.2 = or disjoint i32 %add411.1.2, %and207
  %gep751.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414.1.2
  %xor409.2.2 = xor i32 %add408.2, %add403.2
  %mul410.2.2 = shl nuw nsw i32 %xor409.2.2, 3
  %add411.2.2 = or disjoint i32 %mul410.2.2, %add398.2
  %add414.2.2 = or disjoint i32 %add411.2.2, %and207
  %gep751.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414.2.2
  %xor409.3.2 = xor i32 %add408.3, %add403.2
  %mul410.3.2 = shl nuw nsw i32 %xor409.3.2, 3
  %add411.3.2 = or disjoint i32 %mul410.3.2, %add398.3
  %add414.3.2 = or disjoint i32 %add411.3.2, %and207
  %gep751.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414.3.2
  %add403.3 = or disjoint i32 %shr402, 6
  %xor409.3841 = xor i32 %mul407, %add403.3
  %mul410.3842 = shl nuw nsw i32 %xor409.3841, 3
  %add411.3843 = or disjoint i32 %mul410.3842, %mul396
  %add414.3844 = or disjoint i32 %add411.3843, %and207
  %gep751.3845 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414.3844
  %xor409.1.3 = xor i32 %add408.1, %add403.3
  %mul410.1.3 = shl nuw nsw i32 %xor409.1.3, 3
  %add411.1.3 = or disjoint i32 %mul410.1.3, %add398.1
  %add414.1.3 = or disjoint i32 %add411.1.3, %and207
  %gep751.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414.1.3
  %xor409.2.3 = xor i32 %add408.2, %add403.3
  %mul410.2.3 = shl nuw nsw i32 %xor409.2.3, 3
  %add411.2.3 = or disjoint i32 %mul410.2.3, %add398.2
  %add414.2.3 = or disjoint i32 %add411.2.3, %and207
  %gep751.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414.2.3
  %xor409.3.3 = xor i32 %add408.3, %add403.3
  %mul410.3.3 = shl nuw nsw i32 %xor409.3.3, 3
  %add411.3.3 = or disjoint i32 %mul410.3.3, %add398.3
  %add414.3.3 = or disjoint i32 %add411.3.3, %and207
  %gep751.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414.3.3
  br label %for.body129

for.body129:                                      ; preds = %if.end446.1, %if.end
  %k.sroa.18.1 = phi i32 [ %k.sroa.18.0, %if.end ], [ %k.sroa.18.2.1, %if.end446.1 ]
  %k.sroa.16.1 = phi i32 [ %k.sroa.16.0, %if.end ], [ %k.sroa.16.2.1, %if.end446.1 ]
  %k.sroa.14.1 = phi i32 [ %k.sroa.14.0, %if.end ], [ %k.sroa.14.2.1, %if.end446.1 ]
  %k.sroa.11.1 = phi i32 [ %k.sroa.11.0, %if.end ], [ %k.sroa.11.2.1, %if.end446.1 ]
  %k.sroa.9.1 = phi i32 [ %k.sroa.9.0, %if.end ], [ %k.sroa.9.2.1, %if.end446.1 ]
  %k.sroa.7.1 = phi i32 [ %k.sroa.7.0, %if.end ], [ %k.sroa.7.2.1, %if.end446.1 ]
  %k.sroa.5.1 = phi i32 [ %k.sroa.5.0, %if.end ], [ %k.sroa.5.2.1, %if.end446.1 ]
  %k.sroa.0.1 = phi i32 [ %k.sroa.0.0, %if.end ], [ %k.sroa.0.2.1, %if.end446.1 ]
  %v.sroa.18.1 = phi i32 [ %v.sroa.18.0, %if.end ], [ %v.sroa.18.2.1, %if.end446.1 ]
  %v.sroa.16.1 = phi i32 [ %v.sroa.16.0, %if.end ], [ %v.sroa.16.2.1, %if.end446.1 ]
  %v.sroa.14.1 = phi i32 [ %v.sroa.14.0, %if.end ], [ %v.sroa.14.2.1, %if.end446.1 ]
  %v.sroa.11.1 = phi i32 [ %v.sroa.11.0, %if.end ], [ %v.sroa.11.2.1, %if.end446.1 ]
  %v.sroa.9.1 = phi i32 [ %v.sroa.9.0, %if.end ], [ %v.sroa.9.2.1, %if.end446.1 ]
  %v.sroa.7.1 = phi i32 [ %v.sroa.7.0, %if.end ], [ %v.sroa.7.2.1, %if.end446.1 ]
  %v.sroa.5.1 = phi i32 [ %v.sroa.5.0, %if.end ], [ %v.sroa.5.2.1, %if.end446.1 ]
  %v.sroa.0.1 = phi i32 [ %v.sroa.0.0, %if.end ], [ %v.sroa.0.2.1, %if.end446.1 ]
  %out.sroa.56.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.56.1.1, %if.end446.1 ]
  %out.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.38.1.1, %if.end446.1 ]
  %out.sroa.20.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.20.1.1, %if.end446.1 ]
  %out.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.0.1.1, %if.end446.1 ]
  %partial_sum.sroa.14.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.14.1.1, %if.end446.1 ]
  %partial_sum.sroa.10.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.10.1.1, %if.end446.1 ]
  %partial_sum.sroa.6.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.6.1.1, %if.end446.1 ]
  %partial_sum.sroa.0.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.0.1.1, %if.end446.1 ]
  %prob.sroa.0.0 = phi <4 x half> [ undef, %if.end ], [ %prob.sroa.0.1.1, %if.end446.1 ]
  %s_1.0755 = phi i32 [ 0, %if.end ], [ %inc448.1, %if.end446.1 ]
  %arrayidx131 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %s_1.0755
  %42 = load i32, ptr addrspace(5) %arrayidx131, align 4, !tbaa !30
  %or.cond767 = icmp ugt i32 %42, 31
  %cmp138.not = icmp sgt i32 %42, %shr41
  %or.cond768 = or i1 %or.cond767, %cmp138.not
  br i1 %or.cond768, label %if.then298, label %for.body143.preheader

for.body143.preheader:                            ; preds = %for.body129
  store i32 %k.sroa.0.1, ptr addrspace(3) %invariant.gep731, align 16, !tbaa !30
  store i32 %k.sroa.5.1, ptr addrspace(3) %k.sroa.5.0.invariant.gep731.sroa_idx, align 4, !tbaa !30
  store i32 %k.sroa.7.1, ptr addrspace(3) %k.sroa.7.0.invariant.gep731.sroa_idx, align 8, !tbaa !30
  store i32 %k.sroa.9.1, ptr addrspace(3) %k.sroa.9.0.invariant.gep731.sroa_idx, align 4, !tbaa !30
  store i32 %k.sroa.11.1, ptr addrspace(3) %gep732.1, align 16, !tbaa !30
  store i32 %k.sroa.14.1, ptr addrspace(3) %k.sroa.14.16.gep732.1.sroa_idx, align 4, !tbaa !30
  store i32 %k.sroa.16.1, ptr addrspace(3) %k.sroa.16.16.gep732.1.sroa_idx, align 8, !tbaa !30
  store i32 %k.sroa.18.1, ptr addrspace(3) %k.sroa.18.16.gep732.1.sroa_idx, align 4, !tbaa !30
  %mul165 = shl nuw nsw i32 %42, 4
  %add166 = or disjoint i32 %mul165, 15
  %cmp167 = icmp ult i32 %1, %add166
  br i1 %cmp167, label %for.cond169.preheader, label %if.end194

for.cond169.preheader:                            ; preds = %for.body143.preheader
  %add177 = add nuw nsw i32 %mul165, %mul176
  %cmp180.not = icmp ugt i32 %add177, %1
  %spec.select = select i1 %cmp180.not, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert872 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp180.not.1.not = icmp ult i32 %add177, %1
  %spec.select.1 = select i1 %cmp180.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert879 = insertelement <4 x float> %scores.sroa.0.0.vec.insert872, float %spec.select.1, i64 1
  %add178.2 = or disjoint i32 %add177, 2
  %cmp180.not.2 = icmp ugt i32 %add178.2, %1
  %spec.select.2 = select i1 %cmp180.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert886 = insertelement <4 x float> %scores.sroa.0.4.vec.insert879, float %spec.select.2, i64 2
  %add178.3 = or disjoint i32 %add177, 3
  %cmp180.not.3 = icmp ugt i32 %add178.3, %1
  %spec.select.3 = select i1 %cmp180.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert893 = insertelement <4 x float> %scores.sroa.0.8.vec.insert886, float %spec.select.3, i64 3
  br label %if.end194

if.end194:                                        ; preds = %for.body143.preheader, %for.cond169.preheader
  %scores.sroa.0.1 = phi <4 x float> [ %scores.sroa.0.12.vec.insert893, %for.cond169.preheader ], [ zeroinitializer, %for.body143.preheader ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr212, align 16
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr212.sroa_idx, align 8
  %43 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.1), !call_argsrelate !86
  %44 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %43), !call_argsrelate !86
  %kb.sroa.0.0.copyload862 = load <4 x half>, ptr addrspace(3) %add.ptr212.1, align 16
  %kb.sroa.6.0.copyload863 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr212.1.sroa_idx, align 8
  %45 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload862, <4 x half> %q.sroa.5.16.copyload, <4 x float> %44), !call_argsrelate !86
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload863, <4 x half> %q.sroa.7.16.copyload, <4 x float> %45), !call_argsrelate !86
  store i32 %v.sroa.0.1, ptr addrspace(3) %invariant.gep743, align 16, !tbaa !30
  store i32 %v.sroa.5.1, ptr addrspace(3) %v.sroa.5.0.invariant.gep743.sroa_idx, align 4, !tbaa !30
  store i32 %v.sroa.7.1, ptr addrspace(3) %v.sroa.7.0.invariant.gep743.sroa_idx, align 8, !tbaa !30
  store i32 %v.sroa.9.1, ptr addrspace(3) %v.sroa.9.0.invariant.gep743.sroa_idx, align 4, !tbaa !30
  store i32 %v.sroa.11.1, ptr addrspace(3) %gep.1, align 16, !tbaa !30
  store i32 %v.sroa.14.1, ptr addrspace(3) %v.sroa.14.16.gep.1.sroa_idx, align 4, !tbaa !30
  store i32 %v.sroa.16.1, ptr addrspace(3) %v.sroa.16.16.gep.1.sroa_idx, align 8, !tbaa !30
  store i32 %v.sroa.18.1, ptr addrspace(3) %v.sroa.18.16.gep.1.sroa_idx, align 4, !tbaa !30
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %46, i64 0
  %mul269 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %47 = tail call contract noundef float @llvm.minnum.f32(float %mul269, float 0x4024CB5EC0000000)
  %48 = tail call contract noundef float @llvm.exp.f32(float %47)
  %add278 = fadd contract float %partial_sum.sroa.0.0, %48
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %46, i64 1
  %mul269.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %49 = tail call contract noundef float @llvm.minnum.f32(float %mul269.1, float 0x4024CB5EC0000000)
  %50 = tail call contract noundef float @llvm.exp.f32(float %49)
  %add278.1 = fadd contract float %partial_sum.sroa.6.0, %50
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %46, i64 2
  %mul269.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %51 = tail call contract noundef float @llvm.minnum.f32(float %mul269.2, float 0x4024CB5EC0000000)
  %52 = tail call contract noundef float @llvm.exp.f32(float %51)
  %add278.2 = fadd contract float %partial_sum.sroa.10.0, %52
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %46, i64 3
  %mul269.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %53 = tail call contract noundef float @llvm.minnum.f32(float %mul269.3, float 0x4024CB5EC0000000)
  %54 = tail call contract noundef float @llvm.exp.f32(float %53)
  %add278.3 = fadd contract float %partial_sum.sroa.14.0, %54
  %55 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %48)
  %56 = insertelement <4 x i16> poison, i16 %55, i64 0
  %57 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %50)
  %58 = insertelement <4 x i16> %56, i16 %57, i64 1
  %59 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %52)
  %60 = insertelement <4 x i16> %58, i16 %59, i64 2
  %61 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %54)
  %62 = insertelement <4 x i16> %60, i16 %61, i64 3
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %62 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.then298

if.then298:                                       ; preds = %for.body129, %if.end194
  %partial_sum.sroa.14.1 = phi float [ %partial_sum.sroa.14.0, %for.body129 ], [ %add278.3, %if.end194 ]
  %partial_sum.sroa.10.1 = phi float [ %partial_sum.sroa.10.0, %for.body129 ], [ %add278.2, %if.end194 ]
  %partial_sum.sroa.6.1 = phi float [ %partial_sum.sroa.6.0, %for.body129 ], [ %add278.1, %if.end194 ]
  %partial_sum.sroa.0.1 = phi float [ %partial_sum.sroa.0.0, %for.body129 ], [ %add278, %if.end194 ]
  %prob.sroa.0.1 = phi <4 x half> [ %prob.sroa.0.0, %for.body129 ], [ %prob.sroa.0.6.vec.insert, %if.end194 ]
  %add299 = or disjoint i32 %s_1.0755, 1
  %arrayidx301 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %add299
  %63 = load i32, ptr addrspace(5) %arrayidx301, align 4, !tbaa !30
  %or.cond769 = icmp ugt i32 %63, 31
  %cmp308.not = icmp sgt i32 %63, %shr41
  %or.cond770 = or i1 %or.cond769, %cmp308.not
  br i1 %or.cond770, label %if.end377, label %for.cond310.preheader

for.cond310.preheader:                            ; preds = %if.then298
  %mul320 = shl nuw nsw i32 %63, 10
  %add323 = add nuw nsw i32 %add321, %mul320
  %64 = zext nneg i32 %add323 to i64
  %add.ptr330 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %64
  %65 = load i32, ptr addrspace(4) %add.ptr330, align 4, !tbaa !30
  %66 = or disjoint i64 %64, 2
  %add.ptr330.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %66
  %67 = load i32, ptr addrspace(4) %add.ptr330.1, align 4, !tbaa !30
  %68 = or disjoint i64 %64, 4
  %add.ptr330.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %68
  %69 = load i32, ptr addrspace(4) %add.ptr330.2, align 4, !tbaa !30
  %70 = or disjoint i64 %64, 6
  %add.ptr330.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %70
  %71 = load i32, ptr addrspace(4) %add.ptr330.3, align 4, !tbaa !30
  %72 = add nuw nsw i64 %64, 512
  %add.ptr330.1815 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %72
  %73 = load i32, ptr addrspace(4) %add.ptr330.1815, align 4, !tbaa !30
  %74 = add nuw nsw i64 %64, 514
  %add.ptr330.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %74
  %75 = load i32, ptr addrspace(4) %add.ptr330.1.1, align 4, !tbaa !30
  %76 = add nuw nsw i64 %64, 516
  %add.ptr330.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %76
  %77 = load i32, ptr addrspace(4) %add.ptr330.2.1, align 4, !tbaa !30
  %78 = add nuw nsw i64 %64, 518
  %add.ptr330.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %78
  %79 = load i32, ptr addrspace(4) %add.ptr330.3.1, align 4, !tbaa !30
  %add.ptr363 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %64
  %80 = load i32, ptr addrspace(4) %add.ptr363, align 4, !tbaa !30
  %add.ptr363.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %66
  %81 = load i32, ptr addrspace(4) %add.ptr363.1, align 4, !tbaa !30
  %add.ptr363.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %68
  %82 = load i32, ptr addrspace(4) %add.ptr363.2, align 4, !tbaa !30
  %add.ptr363.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %70
  %83 = load i32, ptr addrspace(4) %add.ptr363.3, align 4, !tbaa !30
  %add.ptr363.1827 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %72
  %84 = load i32, ptr addrspace(4) %add.ptr363.1827, align 4, !tbaa !30
  %add.ptr363.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %74
  %85 = load i32, ptr addrspace(4) %add.ptr363.1.1, align 4, !tbaa !30
  %add.ptr363.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %76
  %86 = load i32, ptr addrspace(4) %add.ptr363.2.1, align 4, !tbaa !30
  %add.ptr363.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %78
  %87 = load i32, ptr addrspace(4) %add.ptr363.3.1, align 4, !tbaa !30
  br label %if.end377

if.end377:                                        ; preds = %for.cond310.preheader, %if.then298
  %k.sroa.18.2 = phi i32 [ %k.sroa.18.1, %if.then298 ], [ %79, %for.cond310.preheader ]
  %k.sroa.16.2 = phi i32 [ %k.sroa.16.1, %if.then298 ], [ %77, %for.cond310.preheader ]
  %k.sroa.14.2 = phi i32 [ %k.sroa.14.1, %if.then298 ], [ %75, %for.cond310.preheader ]
  %k.sroa.11.2 = phi i32 [ %k.sroa.11.1, %if.then298 ], [ %73, %for.cond310.preheader ]
  %k.sroa.9.2 = phi i32 [ %k.sroa.9.1, %if.then298 ], [ %71, %for.cond310.preheader ]
  %k.sroa.7.2 = phi i32 [ %k.sroa.7.1, %if.then298 ], [ %69, %for.cond310.preheader ]
  %k.sroa.5.2 = phi i32 [ %k.sroa.5.1, %if.then298 ], [ %67, %for.cond310.preheader ]
  %k.sroa.0.2 = phi i32 [ %k.sroa.0.1, %if.then298 ], [ %65, %for.cond310.preheader ]
  %v.sroa.18.2 = phi i32 [ %v.sroa.18.1, %if.then298 ], [ %87, %for.cond310.preheader ]
  %v.sroa.16.2 = phi i32 [ %v.sroa.16.1, %if.then298 ], [ %86, %for.cond310.preheader ]
  %v.sroa.14.2 = phi i32 [ %v.sroa.14.1, %if.then298 ], [ %85, %for.cond310.preheader ]
  %v.sroa.11.2 = phi i32 [ %v.sroa.11.1, %if.then298 ], [ %84, %for.cond310.preheader ]
  %v.sroa.9.2 = phi i32 [ %v.sroa.9.1, %if.then298 ], [ %83, %for.cond310.preheader ]
  %v.sroa.7.2 = phi i32 [ %v.sroa.7.1, %if.then298 ], [ %82, %for.cond310.preheader ]
  %v.sroa.5.2 = phi i32 [ %v.sroa.5.1, %if.then298 ], [ %81, %for.cond310.preheader ]
  %v.sroa.0.2 = phi i32 [ %v.sroa.0.1, %if.then298 ], [ %80, %for.cond310.preheader ]
  br i1 %or.cond768, label %if.end446, label %for.cond390.preheader.preheader

for.cond390.preheader.preheader:                  ; preds = %if.end377
  %88 = load half, ptr addrspace(3) %gep751, align 2, !tbaa !125
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %88, i64 0
  %89 = load half, ptr addrspace(3) %gep751.1, align 2, !tbaa !125
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %89, i64 1
  %90 = load half, ptr addrspace(3) %gep751.2, align 2, !tbaa !125
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %90, i64 2
  %91 = load half, ptr addrspace(3) %gep751.3, align 2, !tbaa !125
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %91, i64 3
  %92 = load half, ptr addrspace(3) %gep751.1833, align 2, !tbaa !125
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %92, i64 0
  %93 = load half, ptr addrspace(3) %gep751.1.1, align 2, !tbaa !125
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %93, i64 1
  %94 = load half, ptr addrspace(3) %gep751.2.1, align 2, !tbaa !125
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %94, i64 2
  %95 = load half, ptr addrspace(3) %gep751.3.1, align 2, !tbaa !125
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %95, i64 3
  %96 = load half, ptr addrspace(3) %gep751.2839, align 2, !tbaa !125
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %96, i64 0
  %97 = load half, ptr addrspace(3) %gep751.1.2, align 2, !tbaa !125
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %97, i64 1
  %98 = load half, ptr addrspace(3) %gep751.2.2, align 2, !tbaa !125
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %98, i64 2
  %99 = load half, ptr addrspace(3) %gep751.3.2, align 2, !tbaa !125
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %99, i64 3
  %100 = load half, ptr addrspace(3) %gep751.3845, align 2, !tbaa !125
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %100, i64 0
  %101 = load half, ptr addrspace(3) %gep751.1.3, align 2, !tbaa !125
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %101, i64 1
  %102 = load half, ptr addrspace(3) %gep751.2.3, align 2, !tbaa !125
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %102, i64 2
  %103 = load half, ptr addrspace(3) %gep751.3.3, align 2, !tbaa !125
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %103, i64 3
  %104 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.0.0)
  %105 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.20.0)
  %106 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.38.0)
  %107 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.56.0)
  br label %if.end446

if.end446:                                        ; preds = %for.cond390.preheader.preheader, %if.end377
  %out.sroa.56.1 = phi <4 x float> [ %out.sroa.56.0, %if.end377 ], [ %107, %for.cond390.preheader.preheader ]
  %out.sroa.38.1 = phi <4 x float> [ %out.sroa.38.0, %if.end377 ], [ %106, %for.cond390.preheader.preheader ]
  %out.sroa.20.1 = phi <4 x float> [ %out.sroa.20.0, %if.end377 ], [ %105, %for.cond390.preheader.preheader ]
  %out.sroa.0.1 = phi <4 x float> [ %out.sroa.0.0, %if.end377 ], [ %104, %for.cond390.preheader.preheader ]
  %inc448 = or disjoint i32 %s_1.0755, 1
  %arrayidx131.1 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %inc448
  %108 = load i32, ptr addrspace(5) %arrayidx131.1, align 4, !tbaa !30
  %or.cond767.1 = icmp ugt i32 %108, 31
  %cmp138.not.1 = icmp sgt i32 %108, %shr41
  %or.cond768.1 = or i1 %or.cond767.1, %cmp138.not.1
  br i1 %or.cond768.1, label %if.end296.1, label %for.body143.preheader.1

for.body143.preheader.1:                          ; preds = %if.end446
  store i32 %k.sroa.0.2, ptr addrspace(3) %invariant.gep731, align 16, !tbaa !30
  store i32 %k.sroa.5.2, ptr addrspace(3) %k.sroa.5.0.invariant.gep731.sroa_idx, align 4, !tbaa !30
  store i32 %k.sroa.7.2, ptr addrspace(3) %k.sroa.7.0.invariant.gep731.sroa_idx, align 8, !tbaa !30
  store i32 %k.sroa.9.2, ptr addrspace(3) %k.sroa.9.0.invariant.gep731.sroa_idx, align 4, !tbaa !30
  store i32 %k.sroa.11.2, ptr addrspace(3) %gep732.1, align 16, !tbaa !30
  store i32 %k.sroa.14.2, ptr addrspace(3) %k.sroa.14.16.gep732.1.sroa_idx, align 4, !tbaa !30
  store i32 %k.sroa.16.2, ptr addrspace(3) %k.sroa.16.16.gep732.1.sroa_idx, align 8, !tbaa !30
  store i32 %k.sroa.18.2, ptr addrspace(3) %k.sroa.18.16.gep732.1.sroa_idx, align 4, !tbaa !30
  %mul165.1 = shl nuw nsw i32 %108, 4
  %add166.1 = or disjoint i32 %mul165.1, 15
  %cmp167.1 = icmp ult i32 %1, %add166.1
  br i1 %cmp167.1, label %for.cond169.preheader.1, label %if.end194.1

for.cond169.preheader.1:                          ; preds = %for.body143.preheader.1
  %add177.1 = add nuw nsw i32 %mul165.1, %mul176
  %cmp180.not.1 = icmp ugt i32 %add177.1, %1
  %spec.select.1988 = select i1 %cmp180.not.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert872.1 = insertelement <4 x float> poison, float %spec.select.1988, i64 0
  %cmp180.not.1.not.1 = icmp ult i32 %add177.1, %1
  %spec.select.1.1 = select i1 %cmp180.not.1.not.1, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert879.1 = insertelement <4 x float> %scores.sroa.0.0.vec.insert872.1, float %spec.select.1.1, i64 1
  %add178.2.1 = or disjoint i32 %add177.1, 2
  %cmp180.not.2.1 = icmp ugt i32 %add178.2.1, %1
  %spec.select.2.1 = select i1 %cmp180.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert886.1 = insertelement <4 x float> %scores.sroa.0.4.vec.insert879.1, float %spec.select.2.1, i64 2
  %add178.3.1 = or disjoint i32 %add177.1, 3
  %cmp180.not.3.1 = icmp ugt i32 %add178.3.1, %1
  %spec.select.3.1 = select i1 %cmp180.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert893.1 = insertelement <4 x float> %scores.sroa.0.8.vec.insert886.1, float %spec.select.3.1, i64 3
  br label %if.end194.1

if.end194.1:                                      ; preds = %for.cond169.preheader.1, %for.body143.preheader.1
  %scores.sroa.0.1.1 = phi <4 x float> [ %scores.sroa.0.12.vec.insert893.1, %for.cond169.preheader.1 ], [ zeroinitializer, %for.body143.preheader.1 ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload.1 = load <4 x half>, ptr addrspace(3) %add.ptr212, align 16
  %kb.sroa.6.0.copyload.1 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr212.sroa_idx, align 8
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload.1, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.1.1), !call_argsrelate !86
  %110 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload.1, <4 x half> %q.sroa.4.0.copyload, <4 x float> %109), !call_argsrelate !86
  %kb.sroa.0.0.copyload862.1 = load <4 x half>, ptr addrspace(3) %add.ptr212.1, align 16
  %kb.sroa.6.0.copyload863.1 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr212.1.sroa_idx, align 8
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload862.1, <4 x half> %q.sroa.5.16.copyload, <4 x float> %110), !call_argsrelate !86
  %112 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload863.1, <4 x half> %q.sroa.7.16.copyload, <4 x float> %111), !call_argsrelate !86
  store i32 %v.sroa.0.2, ptr addrspace(3) %invariant.gep743, align 16, !tbaa !30
  store i32 %v.sroa.5.2, ptr addrspace(3) %v.sroa.5.0.invariant.gep743.sroa_idx, align 4, !tbaa !30
  store i32 %v.sroa.7.2, ptr addrspace(3) %v.sroa.7.0.invariant.gep743.sroa_idx, align 8, !tbaa !30
  store i32 %v.sroa.9.2, ptr addrspace(3) %v.sroa.9.0.invariant.gep743.sroa_idx, align 4, !tbaa !30
  store i32 %v.sroa.11.2, ptr addrspace(3) %gep.1, align 16, !tbaa !30
  store i32 %v.sroa.14.2, ptr addrspace(3) %v.sroa.14.16.gep.1.sroa_idx, align 4, !tbaa !30
  store i32 %v.sroa.16.2, ptr addrspace(3) %v.sroa.16.16.gep.1.sroa_idx, align 8, !tbaa !30
  store i32 %v.sroa.18.2, ptr addrspace(3) %v.sroa.18.16.gep.1.sroa_idx, align 4, !tbaa !30
  %scores.sroa.0.0.vec.extract.1 = extractelement <4 x float> %112, i64 0
  %mul269.1989 = fmul contract float %scores.sroa.0.0.vec.extract.1, 0x3FB99999A0000000
  %113 = tail call contract noundef float @llvm.minnum.f32(float %mul269.1989, float 0x4024CB5EC0000000)
  %114 = tail call contract noundef float @llvm.exp.f32(float %113)
  %add278.1990 = fadd contract float %partial_sum.sroa.0.1, %114
  %scores.sroa.0.4.vec.extract.1 = extractelement <4 x float> %112, i64 1
  %mul269.1.1 = fmul contract float %scores.sroa.0.4.vec.extract.1, 0x3FB99999A0000000
  %115 = tail call contract noundef float @llvm.minnum.f32(float %mul269.1.1, float 0x4024CB5EC0000000)
  %116 = tail call contract noundef float @llvm.exp.f32(float %115)
  %add278.1.1 = fadd contract float %partial_sum.sroa.6.1, %116
  %scores.sroa.0.8.vec.extract.1 = extractelement <4 x float> %112, i64 2
  %mul269.2.1 = fmul contract float %scores.sroa.0.8.vec.extract.1, 0x3FB99999A0000000
  %117 = tail call contract noundef float @llvm.minnum.f32(float %mul269.2.1, float 0x4024CB5EC0000000)
  %118 = tail call contract noundef float @llvm.exp.f32(float %117)
  %add278.2.1 = fadd contract float %partial_sum.sroa.10.1, %118
  %scores.sroa.0.12.vec.extract.1 = extractelement <4 x float> %112, i64 3
  %mul269.3.1 = fmul contract float %scores.sroa.0.12.vec.extract.1, 0x3FB99999A0000000
  %119 = tail call contract noundef float @llvm.minnum.f32(float %mul269.3.1, float 0x4024CB5EC0000000)
  %120 = tail call contract noundef float @llvm.exp.f32(float %119)
  %add278.3.1 = fadd contract float %partial_sum.sroa.14.1, %120
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %114)
  %122 = insertelement <4 x i16> poison, i16 %121, i64 0
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %116)
  %124 = insertelement <4 x i16> %122, i16 %123, i64 1
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %118)
  %126 = insertelement <4 x i16> %124, i16 %125, i64 2
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %120)
  %128 = insertelement <4 x i16> %126, i16 %127, i64 3
  %prob.sroa.0.6.vec.insert.1 = bitcast <4 x i16> %128 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end296.1

if.end296.1:                                      ; preds = %if.end194.1, %if.end446
  %partial_sum.sroa.14.1.1 = phi float [ %partial_sum.sroa.14.1, %if.end446 ], [ %add278.3.1, %if.end194.1 ]
  %partial_sum.sroa.10.1.1 = phi float [ %partial_sum.sroa.10.1, %if.end446 ], [ %add278.2.1, %if.end194.1 ]
  %partial_sum.sroa.6.1.1 = phi float [ %partial_sum.sroa.6.1, %if.end446 ], [ %add278.1.1, %if.end194.1 ]
  %partial_sum.sroa.0.1.1 = phi float [ %partial_sum.sroa.0.1, %if.end446 ], [ %add278.1990, %if.end194.1 ]
  %prob.sroa.0.1.1 = phi <4 x half> [ %prob.sroa.0.1, %if.end446 ], [ %prob.sroa.0.6.vec.insert.1, %if.end194.1 ]
  %cmp297.not.1 = icmp eq i32 %s_1.0755, 2
  br i1 %cmp297.not.1, label %if.end377.1, label %if.then298.1

if.then298.1:                                     ; preds = %if.end296.1
  %add299.1 = add nuw nsw i32 %s_1.0755, 2
  %arrayidx301.1 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %add299.1
  %129 = load i32, ptr addrspace(5) %arrayidx301.1, align 4, !tbaa !30
  %or.cond769.1 = icmp ugt i32 %129, 31
  %cmp308.not.1 = icmp sgt i32 %129, %shr41
  %or.cond770.1 = or i1 %or.cond769.1, %cmp308.not.1
  br i1 %or.cond770.1, label %if.end377.1, label %for.cond310.preheader.1

for.cond310.preheader.1:                          ; preds = %if.then298.1
  %mul320.1 = shl nuw nsw i32 %129, 10
  %add323.1 = add nuw nsw i32 %add321, %mul320.1
  %130 = zext nneg i32 %add323.1 to i64
  %add.ptr330.1991 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %130
  %131 = load i32, ptr addrspace(4) %add.ptr330.1991, align 4, !tbaa !30
  %132 = or disjoint i64 %130, 2
  %add.ptr330.1.1992 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %132
  %133 = load i32, ptr addrspace(4) %add.ptr330.1.1992, align 4, !tbaa !30
  %134 = or disjoint i64 %130, 4
  %add.ptr330.2.1993 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %134
  %135 = load i32, ptr addrspace(4) %add.ptr330.2.1993, align 4, !tbaa !30
  %136 = or disjoint i64 %130, 6
  %add.ptr330.3.1994 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %136
  %137 = load i32, ptr addrspace(4) %add.ptr330.3.1994, align 4, !tbaa !30
  %138 = add nuw nsw i64 %130, 512
  %add.ptr330.1815.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %138
  %139 = load i32, ptr addrspace(4) %add.ptr330.1815.1, align 4, !tbaa !30
  %140 = add nuw nsw i64 %130, 514
  %add.ptr330.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %140
  %141 = load i32, ptr addrspace(4) %add.ptr330.1.1.1, align 4, !tbaa !30
  %142 = add nuw nsw i64 %130, 516
  %add.ptr330.2.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %142
  %143 = load i32, ptr addrspace(4) %add.ptr330.2.1.1, align 4, !tbaa !30
  %144 = add nuw nsw i64 %130, 518
  %add.ptr330.3.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %144
  %145 = load i32, ptr addrspace(4) %add.ptr330.3.1.1, align 4, !tbaa !30
  %add.ptr363.1995 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %130
  %146 = load i32, ptr addrspace(4) %add.ptr363.1995, align 4, !tbaa !30
  %add.ptr363.1.1996 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %132
  %147 = load i32, ptr addrspace(4) %add.ptr363.1.1996, align 4, !tbaa !30
  %add.ptr363.2.1997 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %134
  %148 = load i32, ptr addrspace(4) %add.ptr363.2.1997, align 4, !tbaa !30
  %add.ptr363.3.1998 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %136
  %149 = load i32, ptr addrspace(4) %add.ptr363.3.1998, align 4, !tbaa !30
  %add.ptr363.1827.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %138
  %150 = load i32, ptr addrspace(4) %add.ptr363.1827.1, align 4, !tbaa !30
  %add.ptr363.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %140
  %151 = load i32, ptr addrspace(4) %add.ptr363.1.1.1, align 4, !tbaa !30
  %add.ptr363.2.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %142
  %152 = load i32, ptr addrspace(4) %add.ptr363.2.1.1, align 4, !tbaa !30
  %add.ptr363.3.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %144
  %153 = load i32, ptr addrspace(4) %add.ptr363.3.1.1, align 4, !tbaa !30
  br label %if.end377.1

if.end377.1:                                      ; preds = %for.cond310.preheader.1, %if.then298.1, %if.end296.1
  %k.sroa.18.2.1 = phi i32 [ %k.sroa.18.2, %if.end296.1 ], [ %k.sroa.18.2, %if.then298.1 ], [ %145, %for.cond310.preheader.1 ]
  %k.sroa.16.2.1 = phi i32 [ %k.sroa.16.2, %if.end296.1 ], [ %k.sroa.16.2, %if.then298.1 ], [ %143, %for.cond310.preheader.1 ]
  %k.sroa.14.2.1 = phi i32 [ %k.sroa.14.2, %if.end296.1 ], [ %k.sroa.14.2, %if.then298.1 ], [ %141, %for.cond310.preheader.1 ]
  %k.sroa.11.2.1 = phi i32 [ %k.sroa.11.2, %if.end296.1 ], [ %k.sroa.11.2, %if.then298.1 ], [ %139, %for.cond310.preheader.1 ]
  %k.sroa.9.2.1 = phi i32 [ %k.sroa.9.2, %if.end296.1 ], [ %k.sroa.9.2, %if.then298.1 ], [ %137, %for.cond310.preheader.1 ]
  %k.sroa.7.2.1 = phi i32 [ %k.sroa.7.2, %if.end296.1 ], [ %k.sroa.7.2, %if.then298.1 ], [ %135, %for.cond310.preheader.1 ]
  %k.sroa.5.2.1 = phi i32 [ %k.sroa.5.2, %if.end296.1 ], [ %k.sroa.5.2, %if.then298.1 ], [ %133, %for.cond310.preheader.1 ]
  %k.sroa.0.2.1 = phi i32 [ %k.sroa.0.2, %if.end296.1 ], [ %k.sroa.0.2, %if.then298.1 ], [ %131, %for.cond310.preheader.1 ]
  %v.sroa.18.2.1 = phi i32 [ %v.sroa.18.2, %if.end296.1 ], [ %v.sroa.18.2, %if.then298.1 ], [ %153, %for.cond310.preheader.1 ]
  %v.sroa.16.2.1 = phi i32 [ %v.sroa.16.2, %if.end296.1 ], [ %v.sroa.16.2, %if.then298.1 ], [ %152, %for.cond310.preheader.1 ]
  %v.sroa.14.2.1 = phi i32 [ %v.sroa.14.2, %if.end296.1 ], [ %v.sroa.14.2, %if.then298.1 ], [ %151, %for.cond310.preheader.1 ]
  %v.sroa.11.2.1 = phi i32 [ %v.sroa.11.2, %if.end296.1 ], [ %v.sroa.11.2, %if.then298.1 ], [ %150, %for.cond310.preheader.1 ]
  %v.sroa.9.2.1 = phi i32 [ %v.sroa.9.2, %if.end296.1 ], [ %v.sroa.9.2, %if.then298.1 ], [ %149, %for.cond310.preheader.1 ]
  %v.sroa.7.2.1 = phi i32 [ %v.sroa.7.2, %if.end296.1 ], [ %v.sroa.7.2, %if.then298.1 ], [ %148, %for.cond310.preheader.1 ]
  %v.sroa.5.2.1 = phi i32 [ %v.sroa.5.2, %if.end296.1 ], [ %v.sroa.5.2, %if.then298.1 ], [ %147, %for.cond310.preheader.1 ]
  %v.sroa.0.2.1 = phi i32 [ %v.sroa.0.2, %if.end296.1 ], [ %v.sroa.0.2, %if.then298.1 ], [ %146, %for.cond310.preheader.1 ]
  br i1 %or.cond768.1, label %if.end446.1, label %for.cond390.preheader.preheader.1

for.cond390.preheader.preheader.1:                ; preds = %if.end377.1
  %154 = load half, ptr addrspace(3) %gep751, align 2, !tbaa !125
  %vb.sroa.0.0.vec.insert.1 = insertelement <4 x half> poison, half %154, i64 0
  %155 = load half, ptr addrspace(3) %gep751.1, align 2, !tbaa !125
  %vb.sroa.0.2.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.0.vec.insert.1, half %155, i64 1
  %156 = load half, ptr addrspace(3) %gep751.2, align 2, !tbaa !125
  %vb.sroa.0.4.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.2.vec.insert.1, half %156, i64 2
  %157 = load half, ptr addrspace(3) %gep751.3, align 2, !tbaa !125
  %vb.sroa.0.6.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.4.vec.insert.1, half %157, i64 3
  %158 = load half, ptr addrspace(3) %gep751.1833, align 2, !tbaa !125
  %vb.sroa.7.8.vec.insert.1 = insertelement <4 x half> poison, half %158, i64 0
  %159 = load half, ptr addrspace(3) %gep751.1.1, align 2, !tbaa !125
  %vb.sroa.7.10.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.8.vec.insert.1, half %159, i64 1
  %160 = load half, ptr addrspace(3) %gep751.2.1, align 2, !tbaa !125
  %vb.sroa.7.12.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.10.vec.insert.1, half %160, i64 2
  %161 = load half, ptr addrspace(3) %gep751.3.1, align 2, !tbaa !125
  %vb.sroa.7.14.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.12.vec.insert.1, half %161, i64 3
  %162 = load half, ptr addrspace(3) %gep751.2839, align 2, !tbaa !125
  %vb.sroa.12.16.vec.insert.1 = insertelement <4 x half> poison, half %162, i64 0
  %163 = load half, ptr addrspace(3) %gep751.1.2, align 2, !tbaa !125
  %vb.sroa.12.18.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.16.vec.insert.1, half %163, i64 1
  %164 = load half, ptr addrspace(3) %gep751.2.2, align 2, !tbaa !125
  %vb.sroa.12.20.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.18.vec.insert.1, half %164, i64 2
  %165 = load half, ptr addrspace(3) %gep751.3.2, align 2, !tbaa !125
  %vb.sroa.12.22.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.20.vec.insert.1, half %165, i64 3
  %166 = load half, ptr addrspace(3) %gep751.3845, align 2, !tbaa !125
  %vb.sroa.17.24.vec.insert.1 = insertelement <4 x half> poison, half %166, i64 0
  %167 = load half, ptr addrspace(3) %gep751.1.3, align 2, !tbaa !125
  %vb.sroa.17.26.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.24.vec.insert.1, half %167, i64 1
  %168 = load half, ptr addrspace(3) %gep751.2.3, align 2, !tbaa !125
  %vb.sroa.17.28.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.26.vec.insert.1, half %168, i64 2
  %169 = load half, ptr addrspace(3) %gep751.3.3, align 2, !tbaa !125
  %vb.sroa.17.30.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.28.vec.insert.1, half %169, i64 3
  %170 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.0.1)
  %171 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.20.1)
  %172 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.38.1)
  %173 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.56.1)
  br label %if.end446.1

if.end446.1:                                      ; preds = %for.cond390.preheader.preheader.1, %if.end377.1
  %out.sroa.56.1.1 = phi <4 x float> [ %out.sroa.56.1, %if.end377.1 ], [ %173, %for.cond390.preheader.preheader.1 ]
  %out.sroa.38.1.1 = phi <4 x float> [ %out.sroa.38.1, %if.end377.1 ], [ %172, %for.cond390.preheader.preheader.1 ]
  %out.sroa.20.1.1 = phi <4 x float> [ %out.sroa.20.1, %if.end377.1 ], [ %171, %for.cond390.preheader.preheader.1 ]
  %out.sroa.0.1.1 = phi <4 x float> [ %out.sroa.0.1, %if.end377.1 ], [ %170, %for.cond390.preheader.preheader.1 ]
  %inc448.1 = add nuw nsw i32 %s_1.0755, 2
  %exitcond.not.1 = icmp eq i32 %inc448.1, 4
  br i1 %exitcond.not.1, label %for.body454.preheader, label %for.body129, !llvm.loop !131

for.body454.preheader:                            ; preds = %if.end446.1
  %add458 = fadd contract float %partial_sum.sroa.0.1.1, 0.000000e+00
  %add458.1 = fadd contract float %add458, %partial_sum.sroa.6.1.1
  %add458.2 = fadd contract float %add458.1, %partial_sum.sroa.10.1.1
  %add458.3 = fadd contract float %add458.2, %partial_sum.sroa.14.1.1
  %174 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add458.3, <4 x float> zeroinitializer)
  %short_sum_out.sroa.0.0.vec.extract = extractelement <4 x float> %174, i64 0
  %cmp476 = fcmp contract ogt float %short_sum_out.sroa.0.0.vec.extract, 0.000000e+00
  %cmp.i.i = fcmp contract olt float %short_sum_out.sroa.0.0.vec.extract, 0x39B0000000000000
  %cond.i.i = select contract i1 %cmp.i.i, float 0x4630000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %short_sum_out.sroa.0.0.vec.extract, %cond.i.i
  %175 = tail call contract float @llvm.mxc.rsq.f32(float %mul.i.i)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x4310000000000000, float 1.000000e+00
  %mul3.i.i = fmul contract float %cond2.i.i, %175
  %mul482 = fmul contract float %mul3.i.i, %mul3.i.i
  %condval_1.0 = select i1 %cmp476, float %mul482, float 0.000000e+00
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 0
  %mul493 = fmul contract float %condval_1.0, %out.sroa.0.0.vec.extract
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 1
  %mul493.1 = fmul contract float %condval_1.0, %out.sroa.0.4.vec.extract
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 2
  %mul493.2 = fmul contract float %condval_1.0, %out.sroa.0.8.vec.extract
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 3
  %mul493.3 = fmul contract float %condval_1.0, %out.sroa.0.12.vec.extract
  %out.sroa.20.16.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 0
  %mul493.4 = fmul contract float %condval_1.0, %out.sroa.20.16.vec.extract
  %out.sroa.20.20.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 1
  %mul493.5 = fmul contract float %condval_1.0, %out.sroa.20.20.vec.extract
  %out.sroa.20.24.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 2
  %mul493.6 = fmul contract float %condval_1.0, %out.sroa.20.24.vec.extract
  %out.sroa.20.28.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 3
  %mul493.7 = fmul contract float %condval_1.0, %out.sroa.20.28.vec.extract
  %out.sroa.38.32.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 0
  %mul493.8 = fmul contract float %condval_1.0, %out.sroa.38.32.vec.extract
  %out.sroa.38.36.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 1
  %mul493.9 = fmul contract float %condval_1.0, %out.sroa.38.36.vec.extract
  %out.sroa.38.40.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 2
  %mul493.10 = fmul contract float %condval_1.0, %out.sroa.38.40.vec.extract
  %out.sroa.38.44.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 3
  %mul493.11 = fmul contract float %condval_1.0, %out.sroa.38.44.vec.extract
  %out.sroa.56.48.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 0
  %mul493.12 = fmul contract float %condval_1.0, %out.sroa.56.48.vec.extract
  %out.sroa.56.52.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 1
  %mul493.13 = fmul contract float %condval_1.0, %out.sroa.56.52.vec.extract
  %out.sroa.56.56.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 2
  %mul493.14 = fmul contract float %condval_1.0, %out.sroa.56.56.vec.extract
  %out.sroa.56.60.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 3
  %mul493.15 = fmul contract float %condval_1.0, %out.sroa.56.60.vec.extract
  %176 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul493)
  %result.sroa.0.0.insert.ext = zext i16 %176 to i64
  %177 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul493.1)
  %result.sroa.0.2.insert.ext = zext i16 %177 to i64
  %result.sroa.0.2.insert.shift = shl nuw nsw i64 %result.sroa.0.2.insert.ext, 16
  %result.sroa.0.2.insert.insert = or disjoint i64 %result.sroa.0.2.insert.shift, %result.sroa.0.0.insert.ext
  %178 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul493.2)
  %result.sroa.0.4.insert.ext = zext i16 %178 to i64
  %result.sroa.0.4.insert.shift = shl nuw nsw i64 %result.sroa.0.4.insert.ext, 32
  %result.sroa.0.4.insert.insert = or disjoint i64 %result.sroa.0.2.insert.insert, %result.sroa.0.4.insert.shift
  %179 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul493.3)
  %result.sroa.0.6.insert.ext = zext i16 %179 to i64
  %result.sroa.0.6.insert.shift = shl nuw i64 %result.sroa.0.6.insert.ext, 48
  %result.sroa.0.6.insert.insert = or disjoint i64 %result.sroa.0.4.insert.insert, %result.sroa.0.6.insert.shift
  %180 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul493.4)
  %result.sroa.7.8.insert.ext = zext i16 %180 to i64
  %181 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul493.5)
  %result.sroa.7.10.insert.ext = zext i16 %181 to i64
  %result.sroa.7.10.insert.shift = shl nuw nsw i64 %result.sroa.7.10.insert.ext, 16
  %result.sroa.7.10.insert.insert = or disjoint i64 %result.sroa.7.10.insert.shift, %result.sroa.7.8.insert.ext
  %182 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul493.6)
  %result.sroa.7.12.insert.ext = zext i16 %182 to i64
  %result.sroa.7.12.insert.shift = shl nuw nsw i64 %result.sroa.7.12.insert.ext, 32
  %result.sroa.7.12.insert.insert = or disjoint i64 %result.sroa.7.10.insert.insert, %result.sroa.7.12.insert.shift
  %183 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul493.7)
  %result.sroa.7.14.insert.ext = zext i16 %183 to i64
  %result.sroa.7.14.insert.shift = shl nuw i64 %result.sroa.7.14.insert.ext, 48
  %result.sroa.7.14.insert.insert = or disjoint i64 %result.sroa.7.12.insert.insert, %result.sroa.7.14.insert.shift
  %184 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul493.8)
  %result.sroa.12.16.insert.ext = zext i16 %184 to i64
  %185 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul493.9)
  %result.sroa.12.18.insert.ext = zext i16 %185 to i64
  %result.sroa.12.18.insert.shift = shl nuw nsw i64 %result.sroa.12.18.insert.ext, 16
  %result.sroa.12.18.insert.insert = or disjoint i64 %result.sroa.12.18.insert.shift, %result.sroa.12.16.insert.ext
  %186 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul493.10)
  %result.sroa.12.20.insert.ext = zext i16 %186 to i64
  %result.sroa.12.20.insert.shift = shl nuw nsw i64 %result.sroa.12.20.insert.ext, 32
  %result.sroa.12.20.insert.insert = or disjoint i64 %result.sroa.12.18.insert.insert, %result.sroa.12.20.insert.shift
  %187 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul493.11)
  %result.sroa.12.22.insert.ext = zext i16 %187 to i64
  %result.sroa.12.22.insert.shift = shl nuw i64 %result.sroa.12.22.insert.ext, 48
  %result.sroa.12.22.insert.insert = or disjoint i64 %result.sroa.12.20.insert.insert, %result.sroa.12.22.insert.shift
  %188 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul493.12)
  %result.sroa.17.24.insert.ext = zext i16 %188 to i64
  %189 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul493.13)
  %result.sroa.17.26.insert.ext = zext i16 %189 to i64
  %result.sroa.17.26.insert.shift = shl nuw nsw i64 %result.sroa.17.26.insert.ext, 16
  %result.sroa.17.26.insert.insert = or disjoint i64 %result.sroa.17.26.insert.shift, %result.sroa.17.24.insert.ext
  %190 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul493.14)
  %result.sroa.17.28.insert.ext = zext i16 %190 to i64
  %result.sroa.17.28.insert.shift = shl nuw nsw i64 %result.sroa.17.28.insert.ext, 32
  %result.sroa.17.28.insert.insert = or disjoint i64 %result.sroa.17.26.insert.insert, %result.sroa.17.28.insert.shift
  %191 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul493.15)
  %result.sroa.17.30.insert.ext = zext i16 %191 to i64
  %result.sroa.17.30.insert.shift = shl nuw i64 %result.sroa.17.30.insert.ext, 48
  %result.sroa.17.30.insert.insert = or disjoint i64 %result.sroa.17.28.insert.insert, %result.sroa.17.30.insert.shift
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %shr535 = lshr i32 %2, 5
  %xor539 = xor i32 %shr535, %and207
  %mul540 = shl nuw nsw i32 %xor539, 3
  %add541 = add nuw nsw i32 %mul540, %mul9
  %add546 = or disjoint i32 %add541, %mul407
  %add.ptr548 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add546
  store i64 %result.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr548, align 8
  %add536.1 = add nuw nsw i32 %shr535, 2
  %xor539.1 = xor i32 %add536.1, %and207
  %mul540.1 = shl nuw nsw i32 %xor539.1, 3
  %add541.1 = add nuw nsw i32 %mul540.1, %mul9
  %add546.1 = or disjoint i32 %add541.1, %mul407
  %add.ptr548.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add546.1
  store i64 %result.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr548.1, align 8
  %add536.2 = add nuw nsw i32 %shr535, 4
  %xor539.2 = xor i32 %add536.2, %and207
  %mul540.2 = shl nuw nsw i32 %xor539.2, 3
  %add541.2 = add nuw nsw i32 %mul540.2, %mul9
  %add546.2 = or disjoint i32 %add541.2, %mul407
  %add.ptr548.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add546.2
  store i64 %result.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr548.2, align 8
  %add536.3 = add nuw nsw i32 %shr535, 6
  %xor539.3 = xor i32 %add536.3, %and207
  %mul540.3 = shl nuw nsw i32 %xor539.3, 3
  %add541.3 = add nuw nsw i32 %mul540.3, %mul9
  %add546.3 = or disjoint i32 %add541.3, %mul407
  %add.ptr548.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add546.3
  store i64 %result.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr548.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add576 = add nuw nsw i32 %add, %38
  %192 = zext nneg i32 %add576 to i64
  %add.ptr581 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %192
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr581, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep731, i64 16, i1 false), !tbaa.struct !166, !call_argsrelate !167
  %gep765.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep731, i32 1024
  %193 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %192
  %add.ptr581.1 = getelementptr inbounds i8, ptr addrspace(1) %193, i64 1024
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr581.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep765.1, i64 16, i1 false), !tbaa.struct !166, !call_argsrelate !167
  call void @llvm.lifetime.end.p5(i64 16, ptr addrspace(5) %blocks) #12, !call_argsrelate !43
  ret void
}

declare void @llvm.lifetime.start.p5(i64 immarg, ptr addrspace(5) nocapture) #4

declare void @llvm.lifetime.end.p5(i64 immarg, ptr addrspace(5) nocapture) #4

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #5

declare <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float, float, <4 x float>) #5

declare i32 @llvm.mxc.block.id.x() #6

declare i32 @llvm.mxc.block.id.y() #6

declare i32 @llvm.mxc.block.id.z() #6

declare i32 @llvm.mxc.thread.id.x() #6

declare void @llvm.mxc.barrier.warp() #7

declare float @llvm.exp.f32(float) #8

declare i16 @llvm.convert.to.fp16.f32(float) #9

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #6

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #6

declare i1 @llvm.mxc.is.private(ptr nocapture) #6

declare void @llvm.mxc.sleep(i32 immarg) #10

declare float @llvm.mxc.rsq.f32(float) #6

declare float @llvm.minnum.f32(float, float) #8

declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #11

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #5 = { convergent nounwind willreturn memory(none) }
attributes #6 = { nounwind speculatable willreturn memory(none) }
attributes #7 = { convergent nounwind willreturn }
attributes #8 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #9 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #10 = { nounwind willreturn }
attributes #11 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #12 = { nounwind }


