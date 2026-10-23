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
  %arrayidx30.val = load i32, ptr addrspace(1) %arrayidx30, align 4, !tbaa !30
  store i32 %arrayidx30.val, ptr addrspace(5) %blocks, align 4, !tbaa !30
  %7 = or disjoint i64 %6, 1
  %arrayidx30.1 = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %7
  %arrayidx30.val.1 = load i32, ptr addrspace(1) %arrayidx30.1, align 4, !tbaa !30
  %arrayidx33.1 = getelementptr inbounds i8, ptr addrspace(5) %blocks, i32 4
  store i32 %arrayidx30.val.1, ptr addrspace(5) %arrayidx33.1, align 4, !tbaa !30
  %8 = or disjoint i64 %6, 2
  %arrayidx30.2 = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %8
  %arrayidx30.val.2 = load i32, ptr addrspace(1) %arrayidx30.2, align 4, !tbaa !30
  %arrayidx33.2 = getelementptr inbounds i8, ptr addrspace(5) %blocks, i32 8
  store i32 %arrayidx30.val.2, ptr addrspace(5) %arrayidx33.2, align 4, !tbaa !30
  %9 = or disjoint i64 %6, 3
  %arrayidx30.3 = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %9
  %arrayidx30.val.3 = load i32, ptr addrspace(1) %arrayidx30.3, align 4, !tbaa !30
  %arrayidx33.3 = getelementptr inbounds i8, ptr addrspace(5) %blocks, i32 12
  store i32 %arrayidx30.val.3, ptr addrspace(5) %arrayidx33.3, align 4, !tbaa !30
  %or.cond = icmp ugt i32 %arrayidx30.val, 31
  %shr42 = lshr i32 %1, 4
  %cmp43.not = icmp ugt i32 %arrayidx30.val, %shr42
  %or.cond998 = or i1 %or.cond, %cmp43.not
  br i1 %or.cond998, label %if.end, label %for.cond44.preheader

for.cond44.preheader:                             ; preds = %entry
  %mul54 = shl nsw i32 %0, 15
  %mul55 = shl nuw nsw i32 %arrayidx30.val, 10
  %mul60 = shl nuw nsw i32 %2, 3
  %add56 = or disjoint i32 %mul60, %mul54
  %add58 = add nuw nsw i32 %add56, %mul55
  %10 = zext nneg i32 %add58 to i64
  %add.ptr65 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %10
  %11 = load i32, ptr addrspace(4) %add.ptr65, align 4, !tbaa !30
  %12 = or disjoint i64 %10, 2
  %add.ptr65.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %12
  %13 = load i32, ptr addrspace(4) %add.ptr65.1, align 4, !tbaa !30
  %14 = or disjoint i64 %10, 4
  %add.ptr65.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %14
  %15 = load i32, ptr addrspace(4) %add.ptr65.2, align 4, !tbaa !30
  %16 = or disjoint i64 %10, 6
  %add.ptr65.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %16
  %17 = load i32, ptr addrspace(4) %add.ptr65.3, align 4, !tbaa !30
  %18 = add nuw nsw i64 %10, 512
  %add.ptr65.1800 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %18
  %19 = load i32, ptr addrspace(4) %add.ptr65.1800, align 4, !tbaa !30
  %20 = add nuw nsw i64 %10, 514
  %add.ptr65.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %20
  %21 = load i32, ptr addrspace(4) %add.ptr65.1.1, align 4, !tbaa !30
  %22 = add nuw nsw i64 %10, 516
  %add.ptr65.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %22
  %23 = load i32, ptr addrspace(4) %add.ptr65.2.1, align 4, !tbaa !30
  %24 = add nuw nsw i64 %10, 518
  %add.ptr65.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %24
  %25 = load i32, ptr addrspace(4) %add.ptr65.3.1, align 4, !tbaa !30
  %add.ptr98 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %10
  %26 = load i32, ptr addrspace(4) %add.ptr98, align 4, !tbaa !30
  %add.ptr98.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %12
  %27 = load i32, ptr addrspace(4) %add.ptr98.1, align 4, !tbaa !30
  %add.ptr98.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %14
  %28 = load i32, ptr addrspace(4) %add.ptr98.2, align 4, !tbaa !30
  %add.ptr98.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %16
  %29 = load i32, ptr addrspace(4) %add.ptr98.3, align 4, !tbaa !30
  %add.ptr98.1812 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %18
  %30 = load i32, ptr addrspace(4) %add.ptr98.1812, align 4, !tbaa !30
  %add.ptr98.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %20
  %31 = load i32, ptr addrspace(4) %add.ptr98.1.1, align 4, !tbaa !30
  %add.ptr98.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %22
  %32 = load i32, ptr addrspace(4) %add.ptr98.2.1, align 4, !tbaa !30
  %add.ptr98.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %24
  %33 = load i32, ptr addrspace(4) %add.ptr98.3.1, align 4, !tbaa !30
  br label %if.end

if.end:                                           ; preds = %entry, %for.cond44.preheader
  %k.sroa.18.0 = phi i32 [ %25, %for.cond44.preheader ], [ undef, %entry ]
  %k.sroa.16.0 = phi i32 [ %23, %for.cond44.preheader ], [ undef, %entry ]
  %k.sroa.14.0 = phi i32 [ %21, %for.cond44.preheader ], [ undef, %entry ]
  %k.sroa.11.0 = phi i32 [ %19, %for.cond44.preheader ], [ undef, %entry ]
  %k.sroa.9.0 = phi i32 [ %17, %for.cond44.preheader ], [ undef, %entry ]
  %k.sroa.7.0 = phi i32 [ %15, %for.cond44.preheader ], [ undef, %entry ]
  %k.sroa.5.0 = phi i32 [ %13, %for.cond44.preheader ], [ undef, %entry ]
  %k.sroa.0.0 = phi i32 [ %11, %for.cond44.preheader ], [ undef, %entry ]
  %v.sroa.18.0 = phi i32 [ %33, %for.cond44.preheader ], [ undef, %entry ]
  %v.sroa.16.0 = phi i32 [ %32, %for.cond44.preheader ], [ undef, %entry ]
  %v.sroa.14.0 = phi i32 [ %31, %for.cond44.preheader ], [ undef, %entry ]
  %v.sroa.11.0 = phi i32 [ %30, %for.cond44.preheader ], [ undef, %entry ]
  %v.sroa.9.0 = phi i32 [ %29, %for.cond44.preheader ], [ undef, %entry ]
  %v.sroa.7.0 = phi i32 [ %28, %for.cond44.preheader ], [ undef, %entry ]
  %v.sroa.5.0 = phi i32 [ %27, %for.cond44.preheader ], [ undef, %entry ]
  %v.sroa.0.0 = phi i32 [ %26, %for.cond44.preheader ], [ undef, %entry ]
  %34 = shl nuw nsw i32 %2, 3
  %mul152 = and i32 %34, 8128
  %xor732 = and i32 %34, 56
  %call156.masked = and i32 %2, 1016
  %mul158 = xor i32 %xor732, %call156.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul152
  %invariant.gep742 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul158
  %35 = lshr i32 %2, 2
  %mul177 = and i32 %35, 252
  %shr205 = lshr i32 %2, 4
  %and208 = and i32 %2, 7
  %36 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul9
  %invariant.gep754 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep742, i32 2048
  %mul320 = shl nsw i32 %0, 15
  %add322 = or disjoint i32 %34, %mul320
  %37 = shl nuw nsw i32 %2, 4
  %mul397 = and i32 %37, 16128
  %and402 = lshr i32 %2, 3
  %shr403 = and i32 %and402, 1
  %mul408 = and i32 %35, 4
  %k.sroa.5.0.invariant.gep742.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep742, i32 4
  %k.sroa.7.0.invariant.gep742.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep742, i32 8
  %k.sroa.9.0.invariant.gep742.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep742, i32 12
  %gep743.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep742, i32 1024
  %k.sroa.14.16.gep743.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep742, i32 1028
  %k.sroa.16.16.gep743.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep742, i32 1032
  %k.sroa.18.16.gep743.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep742, i32 1036
  %xor209 = xor i32 %shr205, %and208
  %add.ptr213.idx = shl nuw nsw i32 %xor209, 4
  %add.ptr213 = getelementptr inbounds i8, ptr addrspace(3) %36, i32 %add.ptr213.idx
  %kb.sroa.6.0.add.ptr213.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr213, i32 8
  %add206.1 = add nuw nsw i32 %shr205, 4
  %xor209.1 = xor i32 %add206.1, %and208
  %add.ptr213.idx.1 = shl nuw nsw i32 %xor209.1, 4
  %add.ptr213.1 = getelementptr inbounds i8, ptr addrspace(3) %36, i32 %add.ptr213.idx.1
  %kb.sroa.6.0.add.ptr213.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr213.1, i32 8
  %v.sroa.5.0.invariant.gep754.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep742, i32 2052
  %v.sroa.7.0.invariant.gep754.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep742, i32 2056
  %v.sroa.9.0.invariant.gep754.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep742, i32 2060
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep742, i32 3072
  %v.sroa.14.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep742, i32 3076
  %v.sroa.16.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep742, i32 3080
  %v.sroa.18.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep742, i32 3084
  %xor410 = or disjoint i32 %mul408, %shr403
  %mul411 = shl nuw nsw i32 %xor410, 3
  %add412 = or disjoint i32 %mul411, %mul397
  %add415 = or disjoint i32 %add412, %and208
  %gep762 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add415
  %add399.1 = or disjoint i32 %mul397, 64
  %add409.1 = or disjoint i32 %mul408, 1
  %xor410.1 = xor i32 %add409.1, %shr403
  %mul411.1 = shl nuw nsw i32 %xor410.1, 3
  %add412.1 = or disjoint i32 %mul411.1, %add399.1
  %add415.1 = or disjoint i32 %add412.1, %and208
  %gep762.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add415.1
  %add399.2 = or disjoint i32 %mul397, 128
  %add409.2 = or disjoint i32 %mul408, 2
  %xor410.2 = or disjoint i32 %add409.2, %shr403
  %mul411.2 = shl nuw nsw i32 %xor410.2, 3
  %add412.2 = or disjoint i32 %mul411.2, %add399.2
  %add415.2 = or disjoint i32 %add412.2, %and208
  %gep762.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add415.2
  %add399.3 = or disjoint i32 %mul397, 192
  %add409.3 = or disjoint i32 %mul408, 3
  %xor410.3 = xor i32 %add409.3, %shr403
  %mul411.3 = shl nuw nsw i32 %xor410.3, 3
  %add412.3 = or disjoint i32 %mul411.3, %add399.3
  %add415.3 = or disjoint i32 %add412.3, %and208
  %gep762.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add415.3
  %add404.1 = or disjoint i32 %shr403, 2
  %xor410.1840 = or disjoint i32 %mul408, %add404.1
  %mul411.1841 = shl nuw nsw i32 %xor410.1840, 3
  %add412.1842 = or disjoint i32 %mul411.1841, %mul397
  %add415.1843 = or disjoint i32 %add412.1842, %and208
  %gep762.1844 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add415.1843
  %xor410.1.1 = xor i32 %add409.1, %add404.1
  %mul411.1.1 = shl nuw nsw i32 %xor410.1.1, 3
  %add412.1.1 = or disjoint i32 %mul411.1.1, %add399.1
  %add415.1.1 = or disjoint i32 %add412.1.1, %and208
  %gep762.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add415.1.1
  %xor410.2.1 = xor i32 %add409.2, %add404.1
  %mul411.2.1 = shl nuw nsw i32 %xor410.2.1, 3
  %add412.2.1 = or disjoint i32 %mul411.2.1, %add399.2
  %add415.2.1 = or disjoint i32 %add412.2.1, %and208
  %gep762.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add415.2.1
  %xor410.3.1 = xor i32 %add409.3, %add404.1
  %mul411.3.1 = shl nuw nsw i32 %xor410.3.1, 3
  %add412.3.1 = or disjoint i32 %mul411.3.1, %add399.3
  %add415.3.1 = or disjoint i32 %add412.3.1, %and208
  %gep762.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add415.3.1
  %add404.2 = or disjoint i32 %shr403, 4
  %xor410.2846 = xor i32 %mul408, %add404.2
  %mul411.2847 = shl nuw nsw i32 %xor410.2846, 3
  %add412.2848 = or disjoint i32 %mul411.2847, %mul397
  %add415.2849 = or disjoint i32 %add412.2848, %and208
  %gep762.2850 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add415.2849
  %xor410.1.2 = xor i32 %add409.1, %add404.2
  %mul411.1.2 = shl nuw nsw i32 %xor410.1.2, 3
  %add412.1.2 = or disjoint i32 %mul411.1.2, %add399.1
  %add415.1.2 = or disjoint i32 %add412.1.2, %and208
  %gep762.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add415.1.2
  %xor410.2.2 = xor i32 %add409.2, %add404.2
  %mul411.2.2 = shl nuw nsw i32 %xor410.2.2, 3
  %add412.2.2 = or disjoint i32 %mul411.2.2, %add399.2
  %add415.2.2 = or disjoint i32 %add412.2.2, %and208
  %gep762.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add415.2.2
  %xor410.3.2 = xor i32 %add409.3, %add404.2
  %mul411.3.2 = shl nuw nsw i32 %xor410.3.2, 3
  %add412.3.2 = or disjoint i32 %mul411.3.2, %add399.3
  %add415.3.2 = or disjoint i32 %add412.3.2, %and208
  %gep762.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add415.3.2
  %add404.3 = or disjoint i32 %shr403, 6
  %xor410.3852 = xor i32 %mul408, %add404.3
  %mul411.3853 = shl nuw nsw i32 %xor410.3852, 3
  %add412.3854 = or disjoint i32 %mul411.3853, %mul397
  %add415.3855 = or disjoint i32 %add412.3854, %and208
  %gep762.3856 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add415.3855
  %xor410.1.3 = xor i32 %add409.1, %add404.3
  %mul411.1.3 = shl nuw nsw i32 %xor410.1.3, 3
  %add412.1.3 = or disjoint i32 %mul411.1.3, %add399.1
  %add415.1.3 = or disjoint i32 %add412.1.3, %and208
  %gep762.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add415.1.3
  %xor410.2.3 = xor i32 %add409.2, %add404.3
  %mul411.2.3 = shl nuw nsw i32 %xor410.2.3, 3
  %add412.2.3 = or disjoint i32 %mul411.2.3, %add399.2
  %add415.2.3 = or disjoint i32 %add412.2.3, %and208
  %gep762.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add415.2.3
  %xor410.3.3 = xor i32 %add409.3, %add404.3
  %mul411.3.3 = shl nuw nsw i32 %xor410.3.3, 3
  %add412.3.3 = or disjoint i32 %mul411.3.3, %add399.3
  %add415.3.3 = or disjoint i32 %add412.3.3, %and208
  %gep762.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add415.3.3
  br label %for.body130

for.body130:                                      ; preds = %if.end447.1, %if.end
  %k.sroa.18.1 = phi i32 [ %k.sroa.18.0, %if.end ], [ %k.sroa.18.2.1, %if.end447.1 ]
  %k.sroa.16.1 = phi i32 [ %k.sroa.16.0, %if.end ], [ %k.sroa.16.2.1, %if.end447.1 ]
  %k.sroa.14.1 = phi i32 [ %k.sroa.14.0, %if.end ], [ %k.sroa.14.2.1, %if.end447.1 ]
  %k.sroa.11.1 = phi i32 [ %k.sroa.11.0, %if.end ], [ %k.sroa.11.2.1, %if.end447.1 ]
  %k.sroa.9.1 = phi i32 [ %k.sroa.9.0, %if.end ], [ %k.sroa.9.2.1, %if.end447.1 ]
  %k.sroa.7.1 = phi i32 [ %k.sroa.7.0, %if.end ], [ %k.sroa.7.2.1, %if.end447.1 ]
  %k.sroa.5.1 = phi i32 [ %k.sroa.5.0, %if.end ], [ %k.sroa.5.2.1, %if.end447.1 ]
  %k.sroa.0.1 = phi i32 [ %k.sroa.0.0, %if.end ], [ %k.sroa.0.2.1, %if.end447.1 ]
  %v.sroa.18.1 = phi i32 [ %v.sroa.18.0, %if.end ], [ %v.sroa.18.2.1, %if.end447.1 ]
  %v.sroa.16.1 = phi i32 [ %v.sroa.16.0, %if.end ], [ %v.sroa.16.2.1, %if.end447.1 ]
  %v.sroa.14.1 = phi i32 [ %v.sroa.14.0, %if.end ], [ %v.sroa.14.2.1, %if.end447.1 ]
  %v.sroa.11.1 = phi i32 [ %v.sroa.11.0, %if.end ], [ %v.sroa.11.2.1, %if.end447.1 ]
  %v.sroa.9.1 = phi i32 [ %v.sroa.9.0, %if.end ], [ %v.sroa.9.2.1, %if.end447.1 ]
  %v.sroa.7.1 = phi i32 [ %v.sroa.7.0, %if.end ], [ %v.sroa.7.2.1, %if.end447.1 ]
  %v.sroa.5.1 = phi i32 [ %v.sroa.5.0, %if.end ], [ %v.sroa.5.2.1, %if.end447.1 ]
  %v.sroa.0.1 = phi i32 [ %v.sroa.0.0, %if.end ], [ %v.sroa.0.2.1, %if.end447.1 ]
  %out.sroa.56.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.56.1.1, %if.end447.1 ]
  %out.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.38.1.1, %if.end447.1 ]
  %out.sroa.20.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.20.1.1, %if.end447.1 ]
  %out.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.0.1.1, %if.end447.1 ]
  %partial_sum.sroa.14.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.14.1.1, %if.end447.1 ]
  %partial_sum.sroa.10.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.10.1.1, %if.end447.1 ]
  %partial_sum.sroa.6.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.6.1.1, %if.end447.1 ]
  %partial_sum.sroa.0.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.0.1.1, %if.end447.1 ]
  %prob.sroa.0.0 = phi <4 x half> [ undef, %if.end ], [ %prob.sroa.0.1.1, %if.end447.1 ]
  %s_1.0766 = phi i32 [ 0, %if.end ], [ %inc449.1, %if.end447.1 ]
  %arrayidx132 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %s_1.0766
  %38 = load i32, ptr addrspace(5) %arrayidx132, align 4, !tbaa !30
  %or.cond778 = icmp ugt i32 %38, 31
  %cmp139.not = icmp sgt i32 %38, %shr42
  %or.cond779 = or i1 %or.cond778, %cmp139.not
  br i1 %or.cond779, label %if.then299, label %for.body144.preheader

for.body144.preheader:                            ; preds = %for.body130
  store i32 %k.sroa.0.1, ptr addrspace(3) %invariant.gep742, align 16, !tbaa !30
  store i32 %k.sroa.5.1, ptr addrspace(3) %k.sroa.5.0.invariant.gep742.sroa_idx, align 4, !tbaa !30
  store i32 %k.sroa.7.1, ptr addrspace(3) %k.sroa.7.0.invariant.gep742.sroa_idx, align 8, !tbaa !30
  store i32 %k.sroa.9.1, ptr addrspace(3) %k.sroa.9.0.invariant.gep742.sroa_idx, align 4, !tbaa !30
  store i32 %k.sroa.11.1, ptr addrspace(3) %gep743.1, align 16, !tbaa !30
  store i32 %k.sroa.14.1, ptr addrspace(3) %k.sroa.14.16.gep743.1.sroa_idx, align 4, !tbaa !30
  store i32 %k.sroa.16.1, ptr addrspace(3) %k.sroa.16.16.gep743.1.sroa_idx, align 8, !tbaa !30
  store i32 %k.sroa.18.1, ptr addrspace(3) %k.sroa.18.16.gep743.1.sroa_idx, align 4, !tbaa !30
  %mul166 = shl nuw nsw i32 %38, 4
  %add167 = or disjoint i32 %mul166, 15
  %cmp168 = icmp ult i32 %1, %add167
  br i1 %cmp168, label %for.cond170.preheader, label %if.end195

for.cond170.preheader:                            ; preds = %for.body144.preheader
  %add178 = add nuw nsw i32 %mul166, %mul177
  %cmp181.not = icmp ugt i32 %add178, %1
  %spec.select = select i1 %cmp181.not, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert883 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp181.not.1.not = icmp ult i32 %add178, %1
  %spec.select.1 = select i1 %cmp181.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert890 = insertelement <4 x float> %scores.sroa.0.0.vec.insert883, float %spec.select.1, i64 1
  %add179.2 = or disjoint i32 %add178, 2
  %cmp181.not.2 = icmp ugt i32 %add179.2, %1
  %spec.select.2 = select i1 %cmp181.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert897 = insertelement <4 x float> %scores.sroa.0.4.vec.insert890, float %spec.select.2, i64 2
  %add179.3 = or disjoint i32 %add178, 3
  %cmp181.not.3 = icmp ugt i32 %add179.3, %1
  %spec.select.3 = select i1 %cmp181.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert904 = insertelement <4 x float> %scores.sroa.0.8.vec.insert897, float %spec.select.3, i64 3
  br label %if.end195

if.end195:                                        ; preds = %for.body144.preheader, %for.cond170.preheader
  %scores.sroa.0.1 = phi <4 x float> [ %scores.sroa.0.12.vec.insert904, %for.cond170.preheader ], [ zeroinitializer, %for.body144.preheader ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr213, align 16
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr213.sroa_idx, align 8
  %39 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.1), !call_argsrelate !87
  %40 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %39), !call_argsrelate !87
  %kb.sroa.0.0.copyload873 = load <4 x half>, ptr addrspace(3) %add.ptr213.1, align 16
  %kb.sroa.6.0.copyload874 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr213.1.sroa_idx, align 8
  %41 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload873, <4 x half> %q.sroa.5.16.copyload, <4 x float> %40), !call_argsrelate !87
  %42 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload874, <4 x half> %q.sroa.7.16.copyload, <4 x float> %41), !call_argsrelate !87
  store i32 %v.sroa.0.1, ptr addrspace(3) %invariant.gep754, align 16, !tbaa !30
  store i32 %v.sroa.5.1, ptr addrspace(3) %v.sroa.5.0.invariant.gep754.sroa_idx, align 4, !tbaa !30
  store i32 %v.sroa.7.1, ptr addrspace(3) %v.sroa.7.0.invariant.gep754.sroa_idx, align 8, !tbaa !30
  store i32 %v.sroa.9.1, ptr addrspace(3) %v.sroa.9.0.invariant.gep754.sroa_idx, align 4, !tbaa !30
  store i32 %v.sroa.11.1, ptr addrspace(3) %gep.1, align 16, !tbaa !30
  store i32 %v.sroa.14.1, ptr addrspace(3) %v.sroa.14.16.gep.1.sroa_idx, align 4, !tbaa !30
  store i32 %v.sroa.16.1, ptr addrspace(3) %v.sroa.16.16.gep.1.sroa_idx, align 8, !tbaa !30
  store i32 %v.sroa.18.1, ptr addrspace(3) %v.sroa.18.16.gep.1.sroa_idx, align 4, !tbaa !30
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %42, i64 0
  %mul270 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %43 = tail call contract noundef float @llvm.minnum.f32(float %mul270, float 0x4024CB5EC0000000)
  %44 = tail call contract noundef float @llvm.exp.f32(float %43)
  %add279 = fadd contract float %partial_sum.sroa.0.0, %44
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %42, i64 1
  %mul270.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %45 = tail call contract noundef float @llvm.minnum.f32(float %mul270.1, float 0x4024CB5EC0000000)
  %46 = tail call contract noundef float @llvm.exp.f32(float %45)
  %add279.1 = fadd contract float %partial_sum.sroa.6.0, %46
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %42, i64 2
  %mul270.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %47 = tail call contract noundef float @llvm.minnum.f32(float %mul270.2, float 0x4024CB5EC0000000)
  %48 = tail call contract noundef float @llvm.exp.f32(float %47)
  %add279.2 = fadd contract float %partial_sum.sroa.10.0, %48
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %42, i64 3
  %mul270.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %49 = tail call contract noundef float @llvm.minnum.f32(float %mul270.3, float 0x4024CB5EC0000000)
  %50 = tail call contract noundef float @llvm.exp.f32(float %49)
  %add279.3 = fadd contract float %partial_sum.sroa.14.0, %50
  %51 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %44)
  %52 = insertelement <4 x i16> poison, i16 %51, i64 0
  %53 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %46)
  %54 = insertelement <4 x i16> %52, i16 %53, i64 1
  %55 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %48)
  %56 = insertelement <4 x i16> %54, i16 %55, i64 2
  %57 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %50)
  %58 = insertelement <4 x i16> %56, i16 %57, i64 3
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %58 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.then299

if.then299:                                       ; preds = %for.body130, %if.end195
  %partial_sum.sroa.14.1 = phi float [ %partial_sum.sroa.14.0, %for.body130 ], [ %add279.3, %if.end195 ]
  %partial_sum.sroa.10.1 = phi float [ %partial_sum.sroa.10.0, %for.body130 ], [ %add279.2, %if.end195 ]
  %partial_sum.sroa.6.1 = phi float [ %partial_sum.sroa.6.0, %for.body130 ], [ %add279.1, %if.end195 ]
  %partial_sum.sroa.0.1 = phi float [ %partial_sum.sroa.0.0, %for.body130 ], [ %add279, %if.end195 ]
  %prob.sroa.0.1 = phi <4 x half> [ %prob.sroa.0.0, %for.body130 ], [ %prob.sroa.0.6.vec.insert, %if.end195 ]
  %add300 = or disjoint i32 %s_1.0766, 1
  %arrayidx302 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %add300
  %59 = load i32, ptr addrspace(5) %arrayidx302, align 4, !tbaa !30
  %or.cond780 = icmp ugt i32 %59, 31
  %cmp309.not = icmp sgt i32 %59, %shr42
  %or.cond781 = or i1 %or.cond780, %cmp309.not
  br i1 %or.cond781, label %if.end378, label %for.cond311.preheader

for.cond311.preheader:                            ; preds = %if.then299
  %mul321 = shl nuw nsw i32 %59, 10
  %add324 = add nuw nsw i32 %add322, %mul321
  %60 = zext nneg i32 %add324 to i64
  %add.ptr331 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %60
  %61 = load i32, ptr addrspace(4) %add.ptr331, align 4, !tbaa !30
  %62 = or disjoint i64 %60, 2
  %add.ptr331.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %62
  %63 = load i32, ptr addrspace(4) %add.ptr331.1, align 4, !tbaa !30
  %64 = or disjoint i64 %60, 4
  %add.ptr331.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %64
  %65 = load i32, ptr addrspace(4) %add.ptr331.2, align 4, !tbaa !30
  %66 = or disjoint i64 %60, 6
  %add.ptr331.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %66
  %67 = load i32, ptr addrspace(4) %add.ptr331.3, align 4, !tbaa !30
  %68 = add nuw nsw i64 %60, 512
  %add.ptr331.1826 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %68
  %69 = load i32, ptr addrspace(4) %add.ptr331.1826, align 4, !tbaa !30
  %70 = add nuw nsw i64 %60, 514
  %add.ptr331.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %70
  %71 = load i32, ptr addrspace(4) %add.ptr331.1.1, align 4, !tbaa !30
  %72 = add nuw nsw i64 %60, 516
  %add.ptr331.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %72
  %73 = load i32, ptr addrspace(4) %add.ptr331.2.1, align 4, !tbaa !30
  %74 = add nuw nsw i64 %60, 518
  %add.ptr331.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %74
  %75 = load i32, ptr addrspace(4) %add.ptr331.3.1, align 4, !tbaa !30
  %add.ptr364 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %60
  %76 = load i32, ptr addrspace(4) %add.ptr364, align 4, !tbaa !30
  %add.ptr364.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %62
  %77 = load i32, ptr addrspace(4) %add.ptr364.1, align 4, !tbaa !30
  %add.ptr364.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %64
  %78 = load i32, ptr addrspace(4) %add.ptr364.2, align 4, !tbaa !30
  %add.ptr364.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %66
  %79 = load i32, ptr addrspace(4) %add.ptr364.3, align 4, !tbaa !30
  %add.ptr364.1838 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %68
  %80 = load i32, ptr addrspace(4) %add.ptr364.1838, align 4, !tbaa !30
  %add.ptr364.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %70
  %81 = load i32, ptr addrspace(4) %add.ptr364.1.1, align 4, !tbaa !30
  %add.ptr364.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %72
  %82 = load i32, ptr addrspace(4) %add.ptr364.2.1, align 4, !tbaa !30
  %add.ptr364.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %74
  %83 = load i32, ptr addrspace(4) %add.ptr364.3.1, align 4, !tbaa !30
  br label %if.end378

if.end378:                                        ; preds = %for.cond311.preheader, %if.then299
  %k.sroa.18.2 = phi i32 [ %k.sroa.18.1, %if.then299 ], [ %75, %for.cond311.preheader ]
  %k.sroa.16.2 = phi i32 [ %k.sroa.16.1, %if.then299 ], [ %73, %for.cond311.preheader ]
  %k.sroa.14.2 = phi i32 [ %k.sroa.14.1, %if.then299 ], [ %71, %for.cond311.preheader ]
  %k.sroa.11.2 = phi i32 [ %k.sroa.11.1, %if.then299 ], [ %69, %for.cond311.preheader ]
  %k.sroa.9.2 = phi i32 [ %k.sroa.9.1, %if.then299 ], [ %67, %for.cond311.preheader ]
  %k.sroa.7.2 = phi i32 [ %k.sroa.7.1, %if.then299 ], [ %65, %for.cond311.preheader ]
  %k.sroa.5.2 = phi i32 [ %k.sroa.5.1, %if.then299 ], [ %63, %for.cond311.preheader ]
  %k.sroa.0.2 = phi i32 [ %k.sroa.0.1, %if.then299 ], [ %61, %for.cond311.preheader ]
  %v.sroa.18.2 = phi i32 [ %v.sroa.18.1, %if.then299 ], [ %83, %for.cond311.preheader ]
  %v.sroa.16.2 = phi i32 [ %v.sroa.16.1, %if.then299 ], [ %82, %for.cond311.preheader ]
  %v.sroa.14.2 = phi i32 [ %v.sroa.14.1, %if.then299 ], [ %81, %for.cond311.preheader ]
  %v.sroa.11.2 = phi i32 [ %v.sroa.11.1, %if.then299 ], [ %80, %for.cond311.preheader ]
  %v.sroa.9.2 = phi i32 [ %v.sroa.9.1, %if.then299 ], [ %79, %for.cond311.preheader ]
  %v.sroa.7.2 = phi i32 [ %v.sroa.7.1, %if.then299 ], [ %78, %for.cond311.preheader ]
  %v.sroa.5.2 = phi i32 [ %v.sroa.5.1, %if.then299 ], [ %77, %for.cond311.preheader ]
  %v.sroa.0.2 = phi i32 [ %v.sroa.0.1, %if.then299 ], [ %76, %for.cond311.preheader ]
  br i1 %or.cond779, label %if.end447, label %for.cond391.preheader.preheader

for.cond391.preheader.preheader:                  ; preds = %if.end378
  %84 = load half, ptr addrspace(3) %gep762, align 2, !tbaa !126
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %84, i64 0
  %85 = load half, ptr addrspace(3) %gep762.1, align 2, !tbaa !126
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %85, i64 1
  %86 = load half, ptr addrspace(3) %gep762.2, align 2, !tbaa !126
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %86, i64 2
  %87 = load half, ptr addrspace(3) %gep762.3, align 2, !tbaa !126
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %87, i64 3
  %88 = load half, ptr addrspace(3) %gep762.1844, align 2, !tbaa !126
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %88, i64 0
  %89 = load half, ptr addrspace(3) %gep762.1.1, align 2, !tbaa !126
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %89, i64 1
  %90 = load half, ptr addrspace(3) %gep762.2.1, align 2, !tbaa !126
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %90, i64 2
  %91 = load half, ptr addrspace(3) %gep762.3.1, align 2, !tbaa !126
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %91, i64 3
  %92 = load half, ptr addrspace(3) %gep762.2850, align 2, !tbaa !126
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %92, i64 0
  %93 = load half, ptr addrspace(3) %gep762.1.2, align 2, !tbaa !126
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %93, i64 1
  %94 = load half, ptr addrspace(3) %gep762.2.2, align 2, !tbaa !126
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %94, i64 2
  %95 = load half, ptr addrspace(3) %gep762.3.2, align 2, !tbaa !126
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %95, i64 3
  %96 = load half, ptr addrspace(3) %gep762.3856, align 2, !tbaa !126
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %96, i64 0
  %97 = load half, ptr addrspace(3) %gep762.1.3, align 2, !tbaa !126
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %97, i64 1
  %98 = load half, ptr addrspace(3) %gep762.2.3, align 2, !tbaa !126
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %98, i64 2
  %99 = load half, ptr addrspace(3) %gep762.3.3, align 2, !tbaa !126
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %99, i64 3
  %100 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.0.0)
  %101 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.20.0)
  %102 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.38.0)
  %103 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.56.0)
  br label %if.end447

if.end447:                                        ; preds = %for.cond391.preheader.preheader, %if.end378
  %out.sroa.56.1 = phi <4 x float> [ %out.sroa.56.0, %if.end378 ], [ %103, %for.cond391.preheader.preheader ]
  %out.sroa.38.1 = phi <4 x float> [ %out.sroa.38.0, %if.end378 ], [ %102, %for.cond391.preheader.preheader ]
  %out.sroa.20.1 = phi <4 x float> [ %out.sroa.20.0, %if.end378 ], [ %101, %for.cond391.preheader.preheader ]
  %out.sroa.0.1 = phi <4 x float> [ %out.sroa.0.0, %if.end378 ], [ %100, %for.cond391.preheader.preheader ]
  %inc449 = or disjoint i32 %s_1.0766, 1
  %arrayidx132.1 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %inc449
  %104 = load i32, ptr addrspace(5) %arrayidx132.1, align 4, !tbaa !30
  %or.cond778.1 = icmp ugt i32 %104, 31
  %cmp139.not.1 = icmp sgt i32 %104, %shr42
  %or.cond779.1 = or i1 %or.cond778.1, %cmp139.not.1
  br i1 %or.cond779.1, label %if.end297.1, label %for.body144.preheader.1

for.body144.preheader.1:                          ; preds = %if.end447
  store i32 %k.sroa.0.2, ptr addrspace(3) %invariant.gep742, align 16, !tbaa !30
  store i32 %k.sroa.5.2, ptr addrspace(3) %k.sroa.5.0.invariant.gep742.sroa_idx, align 4, !tbaa !30
  store i32 %k.sroa.7.2, ptr addrspace(3) %k.sroa.7.0.invariant.gep742.sroa_idx, align 8, !tbaa !30
  store i32 %k.sroa.9.2, ptr addrspace(3) %k.sroa.9.0.invariant.gep742.sroa_idx, align 4, !tbaa !30
  store i32 %k.sroa.11.2, ptr addrspace(3) %gep743.1, align 16, !tbaa !30
  store i32 %k.sroa.14.2, ptr addrspace(3) %k.sroa.14.16.gep743.1.sroa_idx, align 4, !tbaa !30
  store i32 %k.sroa.16.2, ptr addrspace(3) %k.sroa.16.16.gep743.1.sroa_idx, align 8, !tbaa !30
  store i32 %k.sroa.18.2, ptr addrspace(3) %k.sroa.18.16.gep743.1.sroa_idx, align 4, !tbaa !30
  %mul166.1 = shl nuw nsw i32 %104, 4
  %add167.1 = or disjoint i32 %mul166.1, 15
  %cmp168.1 = icmp ult i32 %1, %add167.1
  br i1 %cmp168.1, label %for.cond170.preheader.1, label %if.end195.1

for.cond170.preheader.1:                          ; preds = %for.body144.preheader.1
  %add178.1 = add nuw nsw i32 %mul166.1, %mul177
  %cmp181.not.1 = icmp ugt i32 %add178.1, %1
  %spec.select.1999 = select i1 %cmp181.not.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert883.1 = insertelement <4 x float> poison, float %spec.select.1999, i64 0
  %cmp181.not.1.not.1 = icmp ult i32 %add178.1, %1
  %spec.select.1.1 = select i1 %cmp181.not.1.not.1, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert890.1 = insertelement <4 x float> %scores.sroa.0.0.vec.insert883.1, float %spec.select.1.1, i64 1
  %add179.2.1 = or disjoint i32 %add178.1, 2
  %cmp181.not.2.1 = icmp ugt i32 %add179.2.1, %1
  %spec.select.2.1 = select i1 %cmp181.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert897.1 = insertelement <4 x float> %scores.sroa.0.4.vec.insert890.1, float %spec.select.2.1, i64 2
  %add179.3.1 = or disjoint i32 %add178.1, 3
  %cmp181.not.3.1 = icmp ugt i32 %add179.3.1, %1
  %spec.select.3.1 = select i1 %cmp181.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert904.1 = insertelement <4 x float> %scores.sroa.0.8.vec.insert897.1, float %spec.select.3.1, i64 3
  br label %if.end195.1

if.end195.1:                                      ; preds = %for.cond170.preheader.1, %for.body144.preheader.1
  %scores.sroa.0.1.1 = phi <4 x float> [ %scores.sroa.0.12.vec.insert904.1, %for.cond170.preheader.1 ], [ zeroinitializer, %for.body144.preheader.1 ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload.1 = load <4 x half>, ptr addrspace(3) %add.ptr213, align 16
  %kb.sroa.6.0.copyload.1 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr213.sroa_idx, align 8
  %105 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload.1, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.1.1), !call_argsrelate !87
  %106 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload.1, <4 x half> %q.sroa.4.0.copyload, <4 x float> %105), !call_argsrelate !87
  %kb.sroa.0.0.copyload873.1 = load <4 x half>, ptr addrspace(3) %add.ptr213.1, align 16
  %kb.sroa.6.0.copyload874.1 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr213.1.sroa_idx, align 8
  %107 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload873.1, <4 x half> %q.sroa.5.16.copyload, <4 x float> %106), !call_argsrelate !87
  %108 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload874.1, <4 x half> %q.sroa.7.16.copyload, <4 x float> %107), !call_argsrelate !87
  store i32 %v.sroa.0.2, ptr addrspace(3) %invariant.gep754, align 16, !tbaa !30
  store i32 %v.sroa.5.2, ptr addrspace(3) %v.sroa.5.0.invariant.gep754.sroa_idx, align 4, !tbaa !30
  store i32 %v.sroa.7.2, ptr addrspace(3) %v.sroa.7.0.invariant.gep754.sroa_idx, align 8, !tbaa !30
  store i32 %v.sroa.9.2, ptr addrspace(3) %v.sroa.9.0.invariant.gep754.sroa_idx, align 4, !tbaa !30
  store i32 %v.sroa.11.2, ptr addrspace(3) %gep.1, align 16, !tbaa !30
  store i32 %v.sroa.14.2, ptr addrspace(3) %v.sroa.14.16.gep.1.sroa_idx, align 4, !tbaa !30
  store i32 %v.sroa.16.2, ptr addrspace(3) %v.sroa.16.16.gep.1.sroa_idx, align 8, !tbaa !30
  store i32 %v.sroa.18.2, ptr addrspace(3) %v.sroa.18.16.gep.1.sroa_idx, align 4, !tbaa !30
  %scores.sroa.0.0.vec.extract.1 = extractelement <4 x float> %108, i64 0
  %mul270.11000 = fmul contract float %scores.sroa.0.0.vec.extract.1, 0x3FB99999A0000000
  %109 = tail call contract noundef float @llvm.minnum.f32(float %mul270.11000, float 0x4024CB5EC0000000)
  %110 = tail call contract noundef float @llvm.exp.f32(float %109)
  %add279.11001 = fadd contract float %partial_sum.sroa.0.1, %110
  %scores.sroa.0.4.vec.extract.1 = extractelement <4 x float> %108, i64 1
  %mul270.1.1 = fmul contract float %scores.sroa.0.4.vec.extract.1, 0x3FB99999A0000000
  %111 = tail call contract noundef float @llvm.minnum.f32(float %mul270.1.1, float 0x4024CB5EC0000000)
  %112 = tail call contract noundef float @llvm.exp.f32(float %111)
  %add279.1.1 = fadd contract float %partial_sum.sroa.6.1, %112
  %scores.sroa.0.8.vec.extract.1 = extractelement <4 x float> %108, i64 2
  %mul270.2.1 = fmul contract float %scores.sroa.0.8.vec.extract.1, 0x3FB99999A0000000
  %113 = tail call contract noundef float @llvm.minnum.f32(float %mul270.2.1, float 0x4024CB5EC0000000)
  %114 = tail call contract noundef float @llvm.exp.f32(float %113)
  %add279.2.1 = fadd contract float %partial_sum.sroa.10.1, %114
  %scores.sroa.0.12.vec.extract.1 = extractelement <4 x float> %108, i64 3
  %mul270.3.1 = fmul contract float %scores.sroa.0.12.vec.extract.1, 0x3FB99999A0000000
  %115 = tail call contract noundef float @llvm.minnum.f32(float %mul270.3.1, float 0x4024CB5EC0000000)
  %116 = tail call contract noundef float @llvm.exp.f32(float %115)
  %add279.3.1 = fadd contract float %partial_sum.sroa.14.1, %116
  %117 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %110)
  %118 = insertelement <4 x i16> poison, i16 %117, i64 0
  %119 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %112)
  %120 = insertelement <4 x i16> %118, i16 %119, i64 1
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %114)
  %122 = insertelement <4 x i16> %120, i16 %121, i64 2
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %116)
  %124 = insertelement <4 x i16> %122, i16 %123, i64 3
  %prob.sroa.0.6.vec.insert.1 = bitcast <4 x i16> %124 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end297.1

if.end297.1:                                      ; preds = %if.end195.1, %if.end447
  %partial_sum.sroa.14.1.1 = phi float [ %partial_sum.sroa.14.1, %if.end447 ], [ %add279.3.1, %if.end195.1 ]
  %partial_sum.sroa.10.1.1 = phi float [ %partial_sum.sroa.10.1, %if.end447 ], [ %add279.2.1, %if.end195.1 ]
  %partial_sum.sroa.6.1.1 = phi float [ %partial_sum.sroa.6.1, %if.end447 ], [ %add279.1.1, %if.end195.1 ]
  %partial_sum.sroa.0.1.1 = phi float [ %partial_sum.sroa.0.1, %if.end447 ], [ %add279.11001, %if.end195.1 ]
  %prob.sroa.0.1.1 = phi <4 x half> [ %prob.sroa.0.1, %if.end447 ], [ %prob.sroa.0.6.vec.insert.1, %if.end195.1 ]
  %cmp298.not.1 = icmp eq i32 %s_1.0766, 2
  br i1 %cmp298.not.1, label %if.end378.1, label %if.then299.1

if.then299.1:                                     ; preds = %if.end297.1
  %add300.1 = add nuw nsw i32 %s_1.0766, 2
  %arrayidx302.1 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %add300.1
  %125 = load i32, ptr addrspace(5) %arrayidx302.1, align 4, !tbaa !30
  %or.cond780.1 = icmp ugt i32 %125, 31
  %cmp309.not.1 = icmp sgt i32 %125, %shr42
  %or.cond781.1 = or i1 %or.cond780.1, %cmp309.not.1
  br i1 %or.cond781.1, label %if.end378.1, label %for.cond311.preheader.1

for.cond311.preheader.1:                          ; preds = %if.then299.1
  %mul321.1 = shl nuw nsw i32 %125, 10
  %add324.1 = add nuw nsw i32 %add322, %mul321.1
  %126 = zext nneg i32 %add324.1 to i64
  %add.ptr331.11002 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %126
  %127 = load i32, ptr addrspace(4) %add.ptr331.11002, align 4, !tbaa !30
  %128 = or disjoint i64 %126, 2
  %add.ptr331.1.11003 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %128
  %129 = load i32, ptr addrspace(4) %add.ptr331.1.11003, align 4, !tbaa !30
  %130 = or disjoint i64 %126, 4
  %add.ptr331.2.11004 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %130
  %131 = load i32, ptr addrspace(4) %add.ptr331.2.11004, align 4, !tbaa !30
  %132 = or disjoint i64 %126, 6
  %add.ptr331.3.11005 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %132
  %133 = load i32, ptr addrspace(4) %add.ptr331.3.11005, align 4, !tbaa !30
  %134 = add nuw nsw i64 %126, 512
  %add.ptr331.1826.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %134
  %135 = load i32, ptr addrspace(4) %add.ptr331.1826.1, align 4, !tbaa !30
  %136 = add nuw nsw i64 %126, 514
  %add.ptr331.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %136
  %137 = load i32, ptr addrspace(4) %add.ptr331.1.1.1, align 4, !tbaa !30
  %138 = add nuw nsw i64 %126, 516
  %add.ptr331.2.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %138
  %139 = load i32, ptr addrspace(4) %add.ptr331.2.1.1, align 4, !tbaa !30
  %140 = add nuw nsw i64 %126, 518
  %add.ptr331.3.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %140
  %141 = load i32, ptr addrspace(4) %add.ptr331.3.1.1, align 4, !tbaa !30
  %add.ptr364.11006 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %126
  %142 = load i32, ptr addrspace(4) %add.ptr364.11006, align 4, !tbaa !30
  %add.ptr364.1.11007 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %128
  %143 = load i32, ptr addrspace(4) %add.ptr364.1.11007, align 4, !tbaa !30
  %add.ptr364.2.11008 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %130
  %144 = load i32, ptr addrspace(4) %add.ptr364.2.11008, align 4, !tbaa !30
  %add.ptr364.3.11009 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %132
  %145 = load i32, ptr addrspace(4) %add.ptr364.3.11009, align 4, !tbaa !30
  %add.ptr364.1838.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %134
  %146 = load i32, ptr addrspace(4) %add.ptr364.1838.1, align 4, !tbaa !30
  %add.ptr364.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %136
  %147 = load i32, ptr addrspace(4) %add.ptr364.1.1.1, align 4, !tbaa !30
  %add.ptr364.2.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %138
  %148 = load i32, ptr addrspace(4) %add.ptr364.2.1.1, align 4, !tbaa !30
  %add.ptr364.3.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %140
  %149 = load i32, ptr addrspace(4) %add.ptr364.3.1.1, align 4, !tbaa !30
  br label %if.end378.1

if.end378.1:                                      ; preds = %for.cond311.preheader.1, %if.then299.1, %if.end297.1
  %k.sroa.18.2.1 = phi i32 [ %k.sroa.18.2, %if.end297.1 ], [ %k.sroa.18.2, %if.then299.1 ], [ %141, %for.cond311.preheader.1 ]
  %k.sroa.16.2.1 = phi i32 [ %k.sroa.16.2, %if.end297.1 ], [ %k.sroa.16.2, %if.then299.1 ], [ %139, %for.cond311.preheader.1 ]
  %k.sroa.14.2.1 = phi i32 [ %k.sroa.14.2, %if.end297.1 ], [ %k.sroa.14.2, %if.then299.1 ], [ %137, %for.cond311.preheader.1 ]
  %k.sroa.11.2.1 = phi i32 [ %k.sroa.11.2, %if.end297.1 ], [ %k.sroa.11.2, %if.then299.1 ], [ %135, %for.cond311.preheader.1 ]
  %k.sroa.9.2.1 = phi i32 [ %k.sroa.9.2, %if.end297.1 ], [ %k.sroa.9.2, %if.then299.1 ], [ %133, %for.cond311.preheader.1 ]
  %k.sroa.7.2.1 = phi i32 [ %k.sroa.7.2, %if.end297.1 ], [ %k.sroa.7.2, %if.then299.1 ], [ %131, %for.cond311.preheader.1 ]
  %k.sroa.5.2.1 = phi i32 [ %k.sroa.5.2, %if.end297.1 ], [ %k.sroa.5.2, %if.then299.1 ], [ %129, %for.cond311.preheader.1 ]
  %k.sroa.0.2.1 = phi i32 [ %k.sroa.0.2, %if.end297.1 ], [ %k.sroa.0.2, %if.then299.1 ], [ %127, %for.cond311.preheader.1 ]
  %v.sroa.18.2.1 = phi i32 [ %v.sroa.18.2, %if.end297.1 ], [ %v.sroa.18.2, %if.then299.1 ], [ %149, %for.cond311.preheader.1 ]
  %v.sroa.16.2.1 = phi i32 [ %v.sroa.16.2, %if.end297.1 ], [ %v.sroa.16.2, %if.then299.1 ], [ %148, %for.cond311.preheader.1 ]
  %v.sroa.14.2.1 = phi i32 [ %v.sroa.14.2, %if.end297.1 ], [ %v.sroa.14.2, %if.then299.1 ], [ %147, %for.cond311.preheader.1 ]
  %v.sroa.11.2.1 = phi i32 [ %v.sroa.11.2, %if.end297.1 ], [ %v.sroa.11.2, %if.then299.1 ], [ %146, %for.cond311.preheader.1 ]
  %v.sroa.9.2.1 = phi i32 [ %v.sroa.9.2, %if.end297.1 ], [ %v.sroa.9.2, %if.then299.1 ], [ %145, %for.cond311.preheader.1 ]
  %v.sroa.7.2.1 = phi i32 [ %v.sroa.7.2, %if.end297.1 ], [ %v.sroa.7.2, %if.then299.1 ], [ %144, %for.cond311.preheader.1 ]
  %v.sroa.5.2.1 = phi i32 [ %v.sroa.5.2, %if.end297.1 ], [ %v.sroa.5.2, %if.then299.1 ], [ %143, %for.cond311.preheader.1 ]
  %v.sroa.0.2.1 = phi i32 [ %v.sroa.0.2, %if.end297.1 ], [ %v.sroa.0.2, %if.then299.1 ], [ %142, %for.cond311.preheader.1 ]
  br i1 %or.cond779.1, label %if.end447.1, label %for.cond391.preheader.preheader.1

for.cond391.preheader.preheader.1:                ; preds = %if.end378.1
  %150 = load half, ptr addrspace(3) %gep762, align 2, !tbaa !126
  %vb.sroa.0.0.vec.insert.1 = insertelement <4 x half> poison, half %150, i64 0
  %151 = load half, ptr addrspace(3) %gep762.1, align 2, !tbaa !126
  %vb.sroa.0.2.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.0.vec.insert.1, half %151, i64 1
  %152 = load half, ptr addrspace(3) %gep762.2, align 2, !tbaa !126
  %vb.sroa.0.4.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.2.vec.insert.1, half %152, i64 2
  %153 = load half, ptr addrspace(3) %gep762.3, align 2, !tbaa !126
  %vb.sroa.0.6.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.4.vec.insert.1, half %153, i64 3
  %154 = load half, ptr addrspace(3) %gep762.1844, align 2, !tbaa !126
  %vb.sroa.7.8.vec.insert.1 = insertelement <4 x half> poison, half %154, i64 0
  %155 = load half, ptr addrspace(3) %gep762.1.1, align 2, !tbaa !126
  %vb.sroa.7.10.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.8.vec.insert.1, half %155, i64 1
  %156 = load half, ptr addrspace(3) %gep762.2.1, align 2, !tbaa !126
  %vb.sroa.7.12.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.10.vec.insert.1, half %156, i64 2
  %157 = load half, ptr addrspace(3) %gep762.3.1, align 2, !tbaa !126
  %vb.sroa.7.14.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.12.vec.insert.1, half %157, i64 3
  %158 = load half, ptr addrspace(3) %gep762.2850, align 2, !tbaa !126
  %vb.sroa.12.16.vec.insert.1 = insertelement <4 x half> poison, half %158, i64 0
  %159 = load half, ptr addrspace(3) %gep762.1.2, align 2, !tbaa !126
  %vb.sroa.12.18.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.16.vec.insert.1, half %159, i64 1
  %160 = load half, ptr addrspace(3) %gep762.2.2, align 2, !tbaa !126
  %vb.sroa.12.20.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.18.vec.insert.1, half %160, i64 2
  %161 = load half, ptr addrspace(3) %gep762.3.2, align 2, !tbaa !126
  %vb.sroa.12.22.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.20.vec.insert.1, half %161, i64 3
  %162 = load half, ptr addrspace(3) %gep762.3856, align 2, !tbaa !126
  %vb.sroa.17.24.vec.insert.1 = insertelement <4 x half> poison, half %162, i64 0
  %163 = load half, ptr addrspace(3) %gep762.1.3, align 2, !tbaa !126
  %vb.sroa.17.26.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.24.vec.insert.1, half %163, i64 1
  %164 = load half, ptr addrspace(3) %gep762.2.3, align 2, !tbaa !126
  %vb.sroa.17.28.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.26.vec.insert.1, half %164, i64 2
  %165 = load half, ptr addrspace(3) %gep762.3.3, align 2, !tbaa !126
  %vb.sroa.17.30.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.28.vec.insert.1, half %165, i64 3
  %166 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.0.1)
  %167 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.20.1)
  %168 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.38.1)
  %169 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.56.1)
  br label %if.end447.1

if.end447.1:                                      ; preds = %for.cond391.preheader.preheader.1, %if.end378.1
  %out.sroa.56.1.1 = phi <4 x float> [ %out.sroa.56.1, %if.end378.1 ], [ %169, %for.cond391.preheader.preheader.1 ]
  %out.sroa.38.1.1 = phi <4 x float> [ %out.sroa.38.1, %if.end378.1 ], [ %168, %for.cond391.preheader.preheader.1 ]
  %out.sroa.20.1.1 = phi <4 x float> [ %out.sroa.20.1, %if.end378.1 ], [ %167, %for.cond391.preheader.preheader.1 ]
  %out.sroa.0.1.1 = phi <4 x float> [ %out.sroa.0.1, %if.end378.1 ], [ %166, %for.cond391.preheader.preheader.1 ]
  %inc449.1 = add nuw nsw i32 %s_1.0766, 2
  %exitcond.not.1 = icmp eq i32 %inc449.1, 4
  br i1 %exitcond.not.1, label %for.body455.preheader, label %for.body130, !llvm.loop !132

for.body455.preheader:                            ; preds = %if.end447.1
  %add459 = fadd contract float %partial_sum.sroa.0.1.1, 0.000000e+00
  %add459.1 = fadd contract float %add459, %partial_sum.sroa.6.1.1
  %add459.2 = fadd contract float %add459.1, %partial_sum.sroa.10.1.1
  %add459.3 = fadd contract float %add459.2, %partial_sum.sroa.14.1.1
  %170 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add459.3, <4 x float> zeroinitializer)
  %short_sum_out.sroa.0.0.vec.extract = extractelement <4 x float> %170, i64 0
  %cmp477 = fcmp contract ogt float %short_sum_out.sroa.0.0.vec.extract, 0.000000e+00
  br i1 %cmp477, label %if.then478, label %if.end493

if.then478:                                       ; preds = %for.body455.preheader
  %171 = bitcast float %short_sum_out.sroa.0.0.vec.extract to i32
  %sub = sub i32 2129859011, %171
  %172 = bitcast i32 %sub to float
  %mul481 = fmul contract float %short_sum_out.sroa.0.0.vec.extract, %172
  %sub482 = fsub contract float 2.000000e+00, %mul481
  %mul483 = fmul contract float %sub482, %172
  %mul489 = fmul contract float %short_sum_out.sroa.0.0.vec.extract, %mul483
  %sub490 = fsub contract float 2.000000e+00, %mul489
  %mul491 = fmul contract float %mul483, %sub490
  br label %if.end493

if.end493:                                        ; preds = %for.body455.preheader, %if.then478
  %condval_1.0 = phi float [ %mul491, %if.then478 ], [ 0.000000e+00, %for.body455.preheader ]
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 0
  %mul502 = fmul contract float %condval_1.0, %out.sroa.0.0.vec.extract
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 1
  %mul502.1 = fmul contract float %condval_1.0, %out.sroa.0.4.vec.extract
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 2
  %mul502.2 = fmul contract float %condval_1.0, %out.sroa.0.8.vec.extract
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 3
  %mul502.3 = fmul contract float %condval_1.0, %out.sroa.0.12.vec.extract
  %out.sroa.20.16.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 0
  %mul502.4 = fmul contract float %condval_1.0, %out.sroa.20.16.vec.extract
  %out.sroa.20.20.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 1
  %mul502.5 = fmul contract float %condval_1.0, %out.sroa.20.20.vec.extract
  %out.sroa.20.24.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 2
  %mul502.6 = fmul contract float %condval_1.0, %out.sroa.20.24.vec.extract
  %out.sroa.20.28.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 3
  %mul502.7 = fmul contract float %condval_1.0, %out.sroa.20.28.vec.extract
  %out.sroa.38.32.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 0
  %mul502.8 = fmul contract float %condval_1.0, %out.sroa.38.32.vec.extract
  %out.sroa.38.36.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 1
  %mul502.9 = fmul contract float %condval_1.0, %out.sroa.38.36.vec.extract
  %out.sroa.38.40.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 2
  %mul502.10 = fmul contract float %condval_1.0, %out.sroa.38.40.vec.extract
  %out.sroa.38.44.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 3
  %mul502.11 = fmul contract float %condval_1.0, %out.sroa.38.44.vec.extract
  %out.sroa.56.48.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 0
  %mul502.12 = fmul contract float %condval_1.0, %out.sroa.56.48.vec.extract
  %out.sroa.56.52.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 1
  %mul502.13 = fmul contract float %condval_1.0, %out.sroa.56.52.vec.extract
  %out.sroa.56.56.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 2
  %mul502.14 = fmul contract float %condval_1.0, %out.sroa.56.56.vec.extract
  %out.sroa.56.60.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 3
  %mul502.15 = fmul contract float %condval_1.0, %out.sroa.56.60.vec.extract
  %173 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul502)
  %result.sroa.0.0.insert.ext = zext i16 %173 to i64
  %174 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul502.1)
  %result.sroa.0.2.insert.ext = zext i16 %174 to i64
  %result.sroa.0.2.insert.shift = shl nuw nsw i64 %result.sroa.0.2.insert.ext, 16
  %result.sroa.0.2.insert.insert = or disjoint i64 %result.sroa.0.2.insert.shift, %result.sroa.0.0.insert.ext
  %175 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul502.2)
  %result.sroa.0.4.insert.ext = zext i16 %175 to i64
  %result.sroa.0.4.insert.shift = shl nuw nsw i64 %result.sroa.0.4.insert.ext, 32
  %result.sroa.0.4.insert.insert = or disjoint i64 %result.sroa.0.2.insert.insert, %result.sroa.0.4.insert.shift
  %176 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul502.3)
  %result.sroa.0.6.insert.ext = zext i16 %176 to i64
  %result.sroa.0.6.insert.shift = shl nuw i64 %result.sroa.0.6.insert.ext, 48
  %result.sroa.0.6.insert.insert = or disjoint i64 %result.sroa.0.4.insert.insert, %result.sroa.0.6.insert.shift
  %177 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul502.4)
  %result.sroa.7.8.insert.ext = zext i16 %177 to i64
  %178 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul502.5)
  %result.sroa.7.10.insert.ext = zext i16 %178 to i64
  %result.sroa.7.10.insert.shift = shl nuw nsw i64 %result.sroa.7.10.insert.ext, 16
  %result.sroa.7.10.insert.insert = or disjoint i64 %result.sroa.7.10.insert.shift, %result.sroa.7.8.insert.ext
  %179 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul502.6)
  %result.sroa.7.12.insert.ext = zext i16 %179 to i64
  %result.sroa.7.12.insert.shift = shl nuw nsw i64 %result.sroa.7.12.insert.ext, 32
  %result.sroa.7.12.insert.insert = or disjoint i64 %result.sroa.7.10.insert.insert, %result.sroa.7.12.insert.shift
  %180 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul502.7)
  %result.sroa.7.14.insert.ext = zext i16 %180 to i64
  %result.sroa.7.14.insert.shift = shl nuw i64 %result.sroa.7.14.insert.ext, 48
  %result.sroa.7.14.insert.insert = or disjoint i64 %result.sroa.7.12.insert.insert, %result.sroa.7.14.insert.shift
  %181 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul502.8)
  %result.sroa.12.16.insert.ext = zext i16 %181 to i64
  %182 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul502.9)
  %result.sroa.12.18.insert.ext = zext i16 %182 to i64
  %result.sroa.12.18.insert.shift = shl nuw nsw i64 %result.sroa.12.18.insert.ext, 16
  %result.sroa.12.18.insert.insert = or disjoint i64 %result.sroa.12.18.insert.shift, %result.sroa.12.16.insert.ext
  %183 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul502.10)
  %result.sroa.12.20.insert.ext = zext i16 %183 to i64
  %result.sroa.12.20.insert.shift = shl nuw nsw i64 %result.sroa.12.20.insert.ext, 32
  %result.sroa.12.20.insert.insert = or disjoint i64 %result.sroa.12.18.insert.insert, %result.sroa.12.20.insert.shift
  %184 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul502.11)
  %result.sroa.12.22.insert.ext = zext i16 %184 to i64
  %result.sroa.12.22.insert.shift = shl nuw i64 %result.sroa.12.22.insert.ext, 48
  %result.sroa.12.22.insert.insert = or disjoint i64 %result.sroa.12.20.insert.insert, %result.sroa.12.22.insert.shift
  %185 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul502.12)
  %result.sroa.17.24.insert.ext = zext i16 %185 to i64
  %186 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul502.13)
  %result.sroa.17.26.insert.ext = zext i16 %186 to i64
  %result.sroa.17.26.insert.shift = shl nuw nsw i64 %result.sroa.17.26.insert.ext, 16
  %result.sroa.17.26.insert.insert = or disjoint i64 %result.sroa.17.26.insert.shift, %result.sroa.17.24.insert.ext
  %187 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul502.14)
  %result.sroa.17.28.insert.ext = zext i16 %187 to i64
  %result.sroa.17.28.insert.shift = shl nuw nsw i64 %result.sroa.17.28.insert.ext, 32
  %result.sroa.17.28.insert.insert = or disjoint i64 %result.sroa.17.26.insert.insert, %result.sroa.17.28.insert.shift
  %188 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul502.15)
  %result.sroa.17.30.insert.ext = zext i16 %188 to i64
  %result.sroa.17.30.insert.shift = shl nuw i64 %result.sroa.17.30.insert.ext, 48
  %result.sroa.17.30.insert.insert = or disjoint i64 %result.sroa.17.28.insert.insert, %result.sroa.17.30.insert.shift
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %shr544 = lshr i32 %2, 5
  %xor548 = xor i32 %shr544, %and208
  %mul549 = shl nuw nsw i32 %xor548, 3
  %add550 = add nuw nsw i32 %mul549, %mul9
  %add555 = or disjoint i32 %add550, %mul408
  %add.ptr557 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add555
  store i64 %result.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr557, align 8
  %add545.1 = add nuw nsw i32 %shr544, 2
  %xor548.1 = xor i32 %add545.1, %and208
  %mul549.1 = shl nuw nsw i32 %xor548.1, 3
  %add550.1 = add nuw nsw i32 %mul549.1, %mul9
  %add555.1 = or disjoint i32 %add550.1, %mul408
  %add.ptr557.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add555.1
  store i64 %result.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr557.1, align 8
  %add545.2 = add nuw nsw i32 %shr544, 4
  %xor548.2 = xor i32 %add545.2, %and208
  %mul549.2 = shl nuw nsw i32 %xor548.2, 3
  %add550.2 = add nuw nsw i32 %mul549.2, %mul9
  %add555.2 = or disjoint i32 %add550.2, %mul408
  %add.ptr557.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add555.2
  store i64 %result.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr557.2, align 8
  %add545.3 = add nuw nsw i32 %shr544, 6
  %xor548.3 = xor i32 %add545.3, %and208
  %mul549.3 = shl nuw nsw i32 %xor548.3, 3
  %add550.3 = add nuw nsw i32 %mul549.3, %mul9
  %add555.3 = or disjoint i32 %add550.3, %mul408
  %add.ptr557.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add555.3
  store i64 %result.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr557.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add585 = add nuw nsw i32 %add, %34
  %189 = zext nneg i32 %add585 to i64
  %add.ptr590 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %189
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr590, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep742, i64 16, i1 false), !tbaa.struct !177, !call_argsrelate !178
  %gep776.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep742, i32 1024
  %190 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %189
  %add.ptr590.1 = getelementptr inbounds i8, ptr addrspace(1) %190, i64 1024
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr590.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep776.1, i64 16, i1 false), !tbaa.struct !177, !call_argsrelate !178
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


