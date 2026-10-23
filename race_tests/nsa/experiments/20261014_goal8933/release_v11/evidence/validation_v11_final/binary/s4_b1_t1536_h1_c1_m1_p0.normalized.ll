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
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul = shl nsw i32 %0, 10
  %1 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !44
  %and = shl nuw nsw i32 %1, 6
  %mul7 = and i32 %and, 960
  %add = or disjoint i32 %mul7, %mul
  %2 = lshr i32 %1, 1
  %mul11 = and i32 %2, 504
  %add9 = add nuw nsw i32 %add, %mul11
  %3 = zext nneg i32 %add9 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16
  %q.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %q.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %q.sroa.4.0.add.ptr.sroa_idx, align 8
  %4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %4, i64 64
  %q.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16
  %q.sroa.7.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %4, i64 72
  %q.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %q.sroa.7.16.add.ptr.1.sroa_idx, align 8
  %mul22 = shl nsw i32 %0, 2
  %5 = zext nneg i32 %mul22 to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %5
  %6 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  store i32 %6, ptr addrspace(5) %blocks, align 4, !tbaa !30
  %7 = or disjoint i64 %5, 1
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %7
  %8 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !tbaa !30
  %arrayidx25.1 = getelementptr inbounds i8, ptr addrspace(5) %blocks, i32 4
  store i32 %8, ptr addrspace(5) %arrayidx25.1, align 4, !tbaa !30
  %9 = or disjoint i64 %5, 2
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %9
  %10 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !tbaa !30
  %arrayidx25.2 = getelementptr inbounds i8, ptr addrspace(5) %blocks, i32 8
  store i32 %10, ptr addrspace(5) %arrayidx25.2, align 4, !tbaa !30
  %11 = or disjoint i64 %5, 3
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %11
  %12 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !tbaa !30
  %arrayidx25.3 = getelementptr inbounds i8, ptr addrspace(5) %blocks, i32 12
  store i32 %12, ptr addrspace(5) %arrayidx25.3, align 4, !tbaa !30
  %or.cond = icmp ugt i32 %6, 95
  %shr34 = lshr i32 %0, 4
  %cmp35.not = icmp ugt i32 %6, %shr34
  %or.cond952 = or i1 %or.cond, %cmp35.not
  br i1 %or.cond952, label %if.end, label %for.cond36.preheader

for.cond36.preheader:                             ; preds = %entry
  %mul45 = shl nuw nsw i32 %6, 10
  %mul49 = shl nuw nsw i32 %1, 3
  %add47 = add nuw nsw i32 %mul45, %mul49
  %13 = zext nneg i32 %add47 to i64
  %add.ptr54 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %13
  %14 = load i32, ptr addrspace(4) %add.ptr54, align 4, !tbaa !30
  %15 = or disjoint i64 %13, 2
  %add.ptr54.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %15
  %16 = load i32, ptr addrspace(4) %add.ptr54.1, align 4, !tbaa !30
  %17 = or disjoint i64 %13, 4
  %add.ptr54.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %17
  %18 = load i32, ptr addrspace(4) %add.ptr54.2, align 4, !tbaa !30
  %19 = or disjoint i64 %13, 6
  %add.ptr54.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %19
  %20 = load i32, ptr addrspace(4) %add.ptr54.3, align 4, !tbaa !30
  %21 = add nuw nsw i64 %13, 512
  %add.ptr54.1754 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %21
  %22 = load i32, ptr addrspace(4) %add.ptr54.1754, align 4, !tbaa !30
  %23 = add nuw nsw i64 %13, 514
  %add.ptr54.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %23
  %24 = load i32, ptr addrspace(4) %add.ptr54.1.1, align 4, !tbaa !30
  %25 = add nuw nsw i64 %13, 516
  %add.ptr54.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %25
  %26 = load i32, ptr addrspace(4) %add.ptr54.2.1, align 4, !tbaa !30
  %27 = add nuw nsw i64 %13, 518
  %add.ptr54.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %27
  %28 = load i32, ptr addrspace(4) %add.ptr54.3.1, align 4, !tbaa !30
  %add.ptr84 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %13
  %29 = load i32, ptr addrspace(4) %add.ptr84, align 4, !tbaa !30
  %add.ptr84.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %15
  %30 = load i32, ptr addrspace(4) %add.ptr84.1, align 4, !tbaa !30
  %add.ptr84.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %17
  %31 = load i32, ptr addrspace(4) %add.ptr84.2, align 4, !tbaa !30
  %add.ptr84.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %19
  %32 = load i32, ptr addrspace(4) %add.ptr84.3, align 4, !tbaa !30
  %add.ptr84.1766 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %21
  %33 = load i32, ptr addrspace(4) %add.ptr84.1766, align 4, !tbaa !30
  %add.ptr84.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %23
  %34 = load i32, ptr addrspace(4) %add.ptr84.1.1, align 4, !tbaa !30
  %add.ptr84.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %25
  %35 = load i32, ptr addrspace(4) %add.ptr84.2.1, align 4, !tbaa !30
  %add.ptr84.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %27
  %36 = load i32, ptr addrspace(4) %add.ptr84.3.1, align 4, !tbaa !30
  br label %if.end

if.end:                                           ; preds = %entry, %for.cond36.preheader
  %k.sroa.18.0 = phi i32 [ %28, %for.cond36.preheader ], [ undef, %entry ]
  %k.sroa.16.0 = phi i32 [ %26, %for.cond36.preheader ], [ undef, %entry ]
  %k.sroa.14.0 = phi i32 [ %24, %for.cond36.preheader ], [ undef, %entry ]
  %k.sroa.11.0 = phi i32 [ %22, %for.cond36.preheader ], [ undef, %entry ]
  %k.sroa.9.0 = phi i32 [ %20, %for.cond36.preheader ], [ undef, %entry ]
  %k.sroa.7.0 = phi i32 [ %18, %for.cond36.preheader ], [ undef, %entry ]
  %k.sroa.5.0 = phi i32 [ %16, %for.cond36.preheader ], [ undef, %entry ]
  %k.sroa.0.0 = phi i32 [ %14, %for.cond36.preheader ], [ undef, %entry ]
  %v.sroa.18.0 = phi i32 [ %36, %for.cond36.preheader ], [ undef, %entry ]
  %v.sroa.16.0 = phi i32 [ %35, %for.cond36.preheader ], [ undef, %entry ]
  %v.sroa.14.0 = phi i32 [ %34, %for.cond36.preheader ], [ undef, %entry ]
  %v.sroa.11.0 = phi i32 [ %33, %for.cond36.preheader ], [ undef, %entry ]
  %v.sroa.9.0 = phi i32 [ %32, %for.cond36.preheader ], [ undef, %entry ]
  %v.sroa.7.0 = phi i32 [ %31, %for.cond36.preheader ], [ undef, %entry ]
  %v.sroa.5.0 = phi i32 [ %30, %for.cond36.preheader ], [ undef, %entry ]
  %v.sroa.0.0 = phi i32 [ %29, %for.cond36.preheader ], [ undef, %entry ]
  %37 = shl nuw nsw i32 %1, 3
  %mul138 = and i32 %37, 8128
  %xor673 = and i32 %37, 56
  %call142.masked = and i32 %1, 1016
  %mul144 = xor i32 %xor673, %call142.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul138
  %invariant.gep696 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul144
  %38 = lshr i32 %1, 2
  %mul163 = and i32 %38, 252
  %shr191 = lshr i32 %1, 4
  %and194 = and i32 %1, 7
  %39 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul7
  %invariant.gep708 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 2048
  %40 = shl nuw nsw i32 %1, 4
  %mul377 = and i32 %40, 16128
  %and382 = lshr i32 %1, 3
  %shr383 = and i32 %and382, 1
  %mul388 = and i32 %38, 4
  %k.sroa.5.0.invariant.gep696.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 4
  %k.sroa.7.0.invariant.gep696.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 8
  %k.sroa.9.0.invariant.gep696.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 12
  %gep697.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 1024
  %k.sroa.14.16.gep697.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 1028
  %k.sroa.16.16.gep697.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 1032
  %k.sroa.18.16.gep697.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 1036
  %xor195 = xor i32 %shr191, %and194
  %add.ptr199.idx = shl nuw nsw i32 %xor195, 4
  %add.ptr199 = getelementptr inbounds i8, ptr addrspace(3) %39, i32 %add.ptr199.idx
  %kb.sroa.6.0.add.ptr199.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr199, i32 8
  %add192.1 = add nuw nsw i32 %shr191, 4
  %xor195.1 = xor i32 %add192.1, %and194
  %add.ptr199.idx.1 = shl nuw nsw i32 %xor195.1, 4
  %add.ptr199.1 = getelementptr inbounds i8, ptr addrspace(3) %39, i32 %add.ptr199.idx.1
  %kb.sroa.6.0.add.ptr199.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr199.1, i32 8
  %v.sroa.5.0.invariant.gep708.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 2052
  %v.sroa.7.0.invariant.gep708.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 2056
  %v.sroa.9.0.invariant.gep708.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 2060
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 3072
  %v.sroa.14.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 3076
  %v.sroa.16.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 3080
  %v.sroa.18.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 3084
  %xor390 = or disjoint i32 %mul388, %shr383
  %mul391 = shl nuw nsw i32 %xor390, 3
  %add392 = or disjoint i32 %mul391, %mul377
  %add395 = or disjoint i32 %add392, %and194
  %gep716 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395
  %add379.1 = or disjoint i32 %mul377, 64
  %add389.1 = or disjoint i32 %mul388, 1
  %xor390.1 = xor i32 %add389.1, %shr383
  %mul391.1 = shl nuw nsw i32 %xor390.1, 3
  %add392.1 = or disjoint i32 %mul391.1, %add379.1
  %add395.1 = or disjoint i32 %add392.1, %and194
  %gep716.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395.1
  %add379.2 = or disjoint i32 %mul377, 128
  %add389.2 = or disjoint i32 %mul388, 2
  %xor390.2 = or disjoint i32 %add389.2, %shr383
  %mul391.2 = shl nuw nsw i32 %xor390.2, 3
  %add392.2 = or disjoint i32 %mul391.2, %add379.2
  %add395.2 = or disjoint i32 %add392.2, %and194
  %gep716.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395.2
  %add379.3 = or disjoint i32 %mul377, 192
  %add389.3 = or disjoint i32 %mul388, 3
  %xor390.3 = xor i32 %add389.3, %shr383
  %mul391.3 = shl nuw nsw i32 %xor390.3, 3
  %add392.3 = or disjoint i32 %mul391.3, %add379.3
  %add395.3 = or disjoint i32 %add392.3, %and194
  %gep716.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395.3
  %add384.1 = or disjoint i32 %shr383, 2
  %xor390.1794 = or disjoint i32 %mul388, %add384.1
  %mul391.1795 = shl nuw nsw i32 %xor390.1794, 3
  %add392.1796 = or disjoint i32 %mul391.1795, %mul377
  %add395.1797 = or disjoint i32 %add392.1796, %and194
  %gep716.1798 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395.1797
  %xor390.1.1 = xor i32 %add389.1, %add384.1
  %mul391.1.1 = shl nuw nsw i32 %xor390.1.1, 3
  %add392.1.1 = or disjoint i32 %mul391.1.1, %add379.1
  %add395.1.1 = or disjoint i32 %add392.1.1, %and194
  %gep716.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395.1.1
  %xor390.2.1 = xor i32 %add389.2, %add384.1
  %mul391.2.1 = shl nuw nsw i32 %xor390.2.1, 3
  %add392.2.1 = or disjoint i32 %mul391.2.1, %add379.2
  %add395.2.1 = or disjoint i32 %add392.2.1, %and194
  %gep716.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395.2.1
  %xor390.3.1 = xor i32 %add389.3, %add384.1
  %mul391.3.1 = shl nuw nsw i32 %xor390.3.1, 3
  %add392.3.1 = or disjoint i32 %mul391.3.1, %add379.3
  %add395.3.1 = or disjoint i32 %add392.3.1, %and194
  %gep716.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395.3.1
  %add384.2 = or disjoint i32 %shr383, 4
  %xor390.2800 = xor i32 %mul388, %add384.2
  %mul391.2801 = shl nuw nsw i32 %xor390.2800, 3
  %add392.2802 = or disjoint i32 %mul391.2801, %mul377
  %add395.2803 = or disjoint i32 %add392.2802, %and194
  %gep716.2804 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395.2803
  %xor390.1.2 = xor i32 %add389.1, %add384.2
  %mul391.1.2 = shl nuw nsw i32 %xor390.1.2, 3
  %add392.1.2 = or disjoint i32 %mul391.1.2, %add379.1
  %add395.1.2 = or disjoint i32 %add392.1.2, %and194
  %gep716.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395.1.2
  %xor390.2.2 = xor i32 %add389.2, %add384.2
  %mul391.2.2 = shl nuw nsw i32 %xor390.2.2, 3
  %add392.2.2 = or disjoint i32 %mul391.2.2, %add379.2
  %add395.2.2 = or disjoint i32 %add392.2.2, %and194
  %gep716.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395.2.2
  %xor390.3.2 = xor i32 %add389.3, %add384.2
  %mul391.3.2 = shl nuw nsw i32 %xor390.3.2, 3
  %add392.3.2 = or disjoint i32 %mul391.3.2, %add379.3
  %add395.3.2 = or disjoint i32 %add392.3.2, %and194
  %gep716.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395.3.2
  %add384.3 = or disjoint i32 %shr383, 6
  %xor390.3806 = xor i32 %mul388, %add384.3
  %mul391.3807 = shl nuw nsw i32 %xor390.3806, 3
  %add392.3808 = or disjoint i32 %mul391.3807, %mul377
  %add395.3809 = or disjoint i32 %add392.3808, %and194
  %gep716.3810 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395.3809
  %xor390.1.3 = xor i32 %add389.1, %add384.3
  %mul391.1.3 = shl nuw nsw i32 %xor390.1.3, 3
  %add392.1.3 = or disjoint i32 %mul391.1.3, %add379.1
  %add395.1.3 = or disjoint i32 %add392.1.3, %and194
  %gep716.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395.1.3
  %xor390.2.3 = xor i32 %add389.2, %add384.3
  %mul391.2.3 = shl nuw nsw i32 %xor390.2.3, 3
  %add392.2.3 = or disjoint i32 %mul391.2.3, %add379.2
  %add395.2.3 = or disjoint i32 %add392.2.3, %and194
  %gep716.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395.2.3
  %xor390.3.3 = xor i32 %add389.3, %add384.3
  %mul391.3.3 = shl nuw nsw i32 %xor390.3.3, 3
  %add392.3.3 = or disjoint i32 %mul391.3.3, %add379.3
  %add395.3.3 = or disjoint i32 %add392.3.3, %and194
  %gep716.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add395.3.3
  br label %for.body116

for.body116:                                      ; preds = %if.end427.1, %if.end
  %k.sroa.18.1 = phi i32 [ %k.sroa.18.0, %if.end ], [ %k.sroa.18.2.1, %if.end427.1 ]
  %k.sroa.16.1 = phi i32 [ %k.sroa.16.0, %if.end ], [ %k.sroa.16.2.1, %if.end427.1 ]
  %k.sroa.14.1 = phi i32 [ %k.sroa.14.0, %if.end ], [ %k.sroa.14.2.1, %if.end427.1 ]
  %k.sroa.11.1 = phi i32 [ %k.sroa.11.0, %if.end ], [ %k.sroa.11.2.1, %if.end427.1 ]
  %k.sroa.9.1 = phi i32 [ %k.sroa.9.0, %if.end ], [ %k.sroa.9.2.1, %if.end427.1 ]
  %k.sroa.7.1 = phi i32 [ %k.sroa.7.0, %if.end ], [ %k.sroa.7.2.1, %if.end427.1 ]
  %k.sroa.5.1 = phi i32 [ %k.sroa.5.0, %if.end ], [ %k.sroa.5.2.1, %if.end427.1 ]
  %k.sroa.0.1 = phi i32 [ %k.sroa.0.0, %if.end ], [ %k.sroa.0.2.1, %if.end427.1 ]
  %v.sroa.18.1 = phi i32 [ %v.sroa.18.0, %if.end ], [ %v.sroa.18.2.1, %if.end427.1 ]
  %v.sroa.16.1 = phi i32 [ %v.sroa.16.0, %if.end ], [ %v.sroa.16.2.1, %if.end427.1 ]
  %v.sroa.14.1 = phi i32 [ %v.sroa.14.0, %if.end ], [ %v.sroa.14.2.1, %if.end427.1 ]
  %v.sroa.11.1 = phi i32 [ %v.sroa.11.0, %if.end ], [ %v.sroa.11.2.1, %if.end427.1 ]
  %v.sroa.9.1 = phi i32 [ %v.sroa.9.0, %if.end ], [ %v.sroa.9.2.1, %if.end427.1 ]
  %v.sroa.7.1 = phi i32 [ %v.sroa.7.0, %if.end ], [ %v.sroa.7.2.1, %if.end427.1 ]
  %v.sroa.5.1 = phi i32 [ %v.sroa.5.0, %if.end ], [ %v.sroa.5.2.1, %if.end427.1 ]
  %v.sroa.0.1 = phi i32 [ %v.sroa.0.0, %if.end ], [ %v.sroa.0.2.1, %if.end427.1 ]
  %out.sroa.56.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.56.1.1, %if.end427.1 ]
  %out.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.38.1.1, %if.end427.1 ]
  %out.sroa.20.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.20.1.1, %if.end427.1 ]
  %out.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.0.1.1, %if.end427.1 ]
  %partial_sum.sroa.14.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.14.1.1, %if.end427.1 ]
  %partial_sum.sroa.10.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.10.1.1, %if.end427.1 ]
  %partial_sum.sroa.6.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.6.1.1, %if.end427.1 ]
  %partial_sum.sroa.0.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.0.1.1, %if.end427.1 ]
  %prob.sroa.0.0 = phi <4 x half> [ undef, %if.end ], [ %prob.sroa.0.1.1, %if.end427.1 ]
  %s_1.0720 = phi i32 [ 0, %if.end ], [ %inc429.1, %if.end427.1 ]
  %arrayidx118 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %s_1.0720
  %41 = load i32, ptr addrspace(5) %arrayidx118, align 4, !tbaa !30
  %or.cond732 = icmp ugt i32 %41, 95
  %cmp125.not = icmp sgt i32 %41, %shr34
  %or.cond733 = or i1 %or.cond732, %cmp125.not
  br i1 %or.cond733, label %if.then285, label %for.body130.preheader

for.body130.preheader:                            ; preds = %for.body116
  store i32 %k.sroa.0.1, ptr addrspace(3) %invariant.gep696, align 16, !tbaa !30
  store i32 %k.sroa.5.1, ptr addrspace(3) %k.sroa.5.0.invariant.gep696.sroa_idx, align 4, !tbaa !30
  store i32 %k.sroa.7.1, ptr addrspace(3) %k.sroa.7.0.invariant.gep696.sroa_idx, align 8, !tbaa !30
  store i32 %k.sroa.9.1, ptr addrspace(3) %k.sroa.9.0.invariant.gep696.sroa_idx, align 4, !tbaa !30
  store i32 %k.sroa.11.1, ptr addrspace(3) %gep697.1, align 16, !tbaa !30
  store i32 %k.sroa.14.1, ptr addrspace(3) %k.sroa.14.16.gep697.1.sroa_idx, align 4, !tbaa !30
  store i32 %k.sroa.16.1, ptr addrspace(3) %k.sroa.16.16.gep697.1.sroa_idx, align 8, !tbaa !30
  store i32 %k.sroa.18.1, ptr addrspace(3) %k.sroa.18.16.gep697.1.sroa_idx, align 4, !tbaa !30
  %mul152 = shl nuw nsw i32 %41, 4
  %add153 = or disjoint i32 %mul152, 15
  %cmp154 = icmp ult i32 %0, %add153
  br i1 %cmp154, label %for.cond156.preheader, label %if.end181

for.cond156.preheader:                            ; preds = %for.body130.preheader
  %add164 = add nuw nsw i32 %mul152, %mul163
  %cmp167.not = icmp ugt i32 %add164, %0
  %spec.select = select i1 %cmp167.not, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert837 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp167.not.1.not = icmp ult i32 %add164, %0
  %spec.select.1 = select i1 %cmp167.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert844 = insertelement <4 x float> %scores.sroa.0.0.vec.insert837, float %spec.select.1, i64 1
  %add165.2 = or disjoint i32 %add164, 2
  %cmp167.not.2 = icmp ugt i32 %add165.2, %0
  %spec.select.2 = select i1 %cmp167.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert851 = insertelement <4 x float> %scores.sroa.0.4.vec.insert844, float %spec.select.2, i64 2
  %add165.3 = or disjoint i32 %add164, 3
  %cmp167.not.3 = icmp ugt i32 %add165.3, %0
  %spec.select.3 = select i1 %cmp167.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert858 = insertelement <4 x float> %scores.sroa.0.8.vec.insert851, float %spec.select.3, i64 3
  br label %if.end181

if.end181:                                        ; preds = %for.body130.preheader, %for.cond156.preheader
  %scores.sroa.0.1 = phi <4 x float> [ %scores.sroa.0.12.vec.insert858, %for.cond156.preheader ], [ zeroinitializer, %for.body130.preheader ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr199, align 16
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr199.sroa_idx, align 8
  %42 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.1), !call_argsrelate !86
  %43 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %42), !call_argsrelate !86
  %kb.sroa.0.0.copyload827 = load <4 x half>, ptr addrspace(3) %add.ptr199.1, align 16
  %kb.sroa.6.0.copyload828 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr199.1.sroa_idx, align 8
  %44 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload827, <4 x half> %q.sroa.5.16.copyload, <4 x float> %43), !call_argsrelate !86
  %45 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload828, <4 x half> %q.sroa.7.16.copyload, <4 x float> %44), !call_argsrelate !86
  store i32 %v.sroa.0.1, ptr addrspace(3) %invariant.gep708, align 16, !tbaa !30
  store i32 %v.sroa.5.1, ptr addrspace(3) %v.sroa.5.0.invariant.gep708.sroa_idx, align 4, !tbaa !30
  store i32 %v.sroa.7.1, ptr addrspace(3) %v.sroa.7.0.invariant.gep708.sroa_idx, align 8, !tbaa !30
  store i32 %v.sroa.9.1, ptr addrspace(3) %v.sroa.9.0.invariant.gep708.sroa_idx, align 4, !tbaa !30
  store i32 %v.sroa.11.1, ptr addrspace(3) %gep.1, align 16, !tbaa !30
  store i32 %v.sroa.14.1, ptr addrspace(3) %v.sroa.14.16.gep.1.sroa_idx, align 4, !tbaa !30
  store i32 %v.sroa.16.1, ptr addrspace(3) %v.sroa.16.16.gep.1.sroa_idx, align 8, !tbaa !30
  store i32 %v.sroa.18.1, ptr addrspace(3) %v.sroa.18.16.gep.1.sroa_idx, align 4, !tbaa !30
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %45, i64 0
  %mul256 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %46 = tail call contract noundef float @llvm.minnum.f32(float %mul256, float 0x4024CB5EC0000000)
  %47 = tail call contract noundef float @llvm.exp.f32(float %46)
  %add265 = fadd contract float %partial_sum.sroa.0.0, %47
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %45, i64 1
  %mul256.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %48 = tail call contract noundef float @llvm.minnum.f32(float %mul256.1, float 0x4024CB5EC0000000)
  %49 = tail call contract noundef float @llvm.exp.f32(float %48)
  %add265.1 = fadd contract float %partial_sum.sroa.6.0, %49
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %45, i64 2
  %mul256.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %50 = tail call contract noundef float @llvm.minnum.f32(float %mul256.2, float 0x4024CB5EC0000000)
  %51 = tail call contract noundef float @llvm.exp.f32(float %50)
  %add265.2 = fadd contract float %partial_sum.sroa.10.0, %51
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %45, i64 3
  %mul256.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %52 = tail call contract noundef float @llvm.minnum.f32(float %mul256.3, float 0x4024CB5EC0000000)
  %53 = tail call contract noundef float @llvm.exp.f32(float %52)
  %add265.3 = fadd contract float %partial_sum.sroa.14.0, %53
  %54 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %47)
  %55 = insertelement <4 x i16> poison, i16 %54, i64 0
  %56 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %49)
  %57 = insertelement <4 x i16> %55, i16 %56, i64 1
  %58 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %51)
  %59 = insertelement <4 x i16> %57, i16 %58, i64 2
  %60 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %53)
  %61 = insertelement <4 x i16> %59, i16 %60, i64 3
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %61 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.then285

if.then285:                                       ; preds = %for.body116, %if.end181
  %partial_sum.sroa.14.1 = phi float [ %partial_sum.sroa.14.0, %for.body116 ], [ %add265.3, %if.end181 ]
  %partial_sum.sroa.10.1 = phi float [ %partial_sum.sroa.10.0, %for.body116 ], [ %add265.2, %if.end181 ]
  %partial_sum.sroa.6.1 = phi float [ %partial_sum.sroa.6.0, %for.body116 ], [ %add265.1, %if.end181 ]
  %partial_sum.sroa.0.1 = phi float [ %partial_sum.sroa.0.0, %for.body116 ], [ %add265, %if.end181 ]
  %prob.sroa.0.1 = phi <4 x half> [ %prob.sroa.0.0, %for.body116 ], [ %prob.sroa.0.6.vec.insert, %if.end181 ]
  %add286 = or disjoint i32 %s_1.0720, 1
  %arrayidx288 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %add286
  %62 = load i32, ptr addrspace(5) %arrayidx288, align 4, !tbaa !30
  %or.cond734 = icmp ugt i32 %62, 95
  %cmp295.not = icmp sgt i32 %62, %shr34
  %or.cond735 = or i1 %or.cond734, %cmp295.not
  br i1 %or.cond735, label %if.end358, label %for.cond297.preheader

for.cond297.preheader:                            ; preds = %if.then285
  %mul305 = shl nuw nsw i32 %62, 10
  %add307 = add nuw nsw i32 %mul305, %37
  %63 = zext nneg i32 %add307 to i64
  %add.ptr314 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %63
  %64 = load i32, ptr addrspace(4) %add.ptr314, align 4, !tbaa !30
  %65 = or disjoint i64 %63, 2
  %add.ptr314.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %65
  %66 = load i32, ptr addrspace(4) %add.ptr314.1, align 4, !tbaa !30
  %67 = or disjoint i64 %63, 4
  %add.ptr314.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %67
  %68 = load i32, ptr addrspace(4) %add.ptr314.2, align 4, !tbaa !30
  %69 = or disjoint i64 %63, 6
  %add.ptr314.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %69
  %70 = load i32, ptr addrspace(4) %add.ptr314.3, align 4, !tbaa !30
  %71 = add nuw nsw i64 %63, 512
  %add.ptr314.1780 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %71
  %72 = load i32, ptr addrspace(4) %add.ptr314.1780, align 4, !tbaa !30
  %73 = add nuw nsw i64 %63, 514
  %add.ptr314.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %73
  %74 = load i32, ptr addrspace(4) %add.ptr314.1.1, align 4, !tbaa !30
  %75 = add nuw nsw i64 %63, 516
  %add.ptr314.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %75
  %76 = load i32, ptr addrspace(4) %add.ptr314.2.1, align 4, !tbaa !30
  %77 = add nuw nsw i64 %63, 518
  %add.ptr314.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %77
  %78 = load i32, ptr addrspace(4) %add.ptr314.3.1, align 4, !tbaa !30
  %add.ptr344 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %63
  %79 = load i32, ptr addrspace(4) %add.ptr344, align 4, !tbaa !30
  %add.ptr344.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %65
  %80 = load i32, ptr addrspace(4) %add.ptr344.1, align 4, !tbaa !30
  %add.ptr344.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %67
  %81 = load i32, ptr addrspace(4) %add.ptr344.2, align 4, !tbaa !30
  %add.ptr344.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %69
  %82 = load i32, ptr addrspace(4) %add.ptr344.3, align 4, !tbaa !30
  %add.ptr344.1792 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %71
  %83 = load i32, ptr addrspace(4) %add.ptr344.1792, align 4, !tbaa !30
  %add.ptr344.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %73
  %84 = load i32, ptr addrspace(4) %add.ptr344.1.1, align 4, !tbaa !30
  %add.ptr344.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %75
  %85 = load i32, ptr addrspace(4) %add.ptr344.2.1, align 4, !tbaa !30
  %add.ptr344.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %77
  %86 = load i32, ptr addrspace(4) %add.ptr344.3.1, align 4, !tbaa !30
  br label %if.end358

if.end358:                                        ; preds = %for.cond297.preheader, %if.then285
  %k.sroa.18.2 = phi i32 [ %k.sroa.18.1, %if.then285 ], [ %78, %for.cond297.preheader ]
  %k.sroa.16.2 = phi i32 [ %k.sroa.16.1, %if.then285 ], [ %76, %for.cond297.preheader ]
  %k.sroa.14.2 = phi i32 [ %k.sroa.14.1, %if.then285 ], [ %74, %for.cond297.preheader ]
  %k.sroa.11.2 = phi i32 [ %k.sroa.11.1, %if.then285 ], [ %72, %for.cond297.preheader ]
  %k.sroa.9.2 = phi i32 [ %k.sroa.9.1, %if.then285 ], [ %70, %for.cond297.preheader ]
  %k.sroa.7.2 = phi i32 [ %k.sroa.7.1, %if.then285 ], [ %68, %for.cond297.preheader ]
  %k.sroa.5.2 = phi i32 [ %k.sroa.5.1, %if.then285 ], [ %66, %for.cond297.preheader ]
  %k.sroa.0.2 = phi i32 [ %k.sroa.0.1, %if.then285 ], [ %64, %for.cond297.preheader ]
  %v.sroa.18.2 = phi i32 [ %v.sroa.18.1, %if.then285 ], [ %86, %for.cond297.preheader ]
  %v.sroa.16.2 = phi i32 [ %v.sroa.16.1, %if.then285 ], [ %85, %for.cond297.preheader ]
  %v.sroa.14.2 = phi i32 [ %v.sroa.14.1, %if.then285 ], [ %84, %for.cond297.preheader ]
  %v.sroa.11.2 = phi i32 [ %v.sroa.11.1, %if.then285 ], [ %83, %for.cond297.preheader ]
  %v.sroa.9.2 = phi i32 [ %v.sroa.9.1, %if.then285 ], [ %82, %for.cond297.preheader ]
  %v.sroa.7.2 = phi i32 [ %v.sroa.7.1, %if.then285 ], [ %81, %for.cond297.preheader ]
  %v.sroa.5.2 = phi i32 [ %v.sroa.5.1, %if.then285 ], [ %80, %for.cond297.preheader ]
  %v.sroa.0.2 = phi i32 [ %v.sroa.0.1, %if.then285 ], [ %79, %for.cond297.preheader ]
  br i1 %or.cond733, label %if.end427, label %for.cond371.preheader.preheader

for.cond371.preheader.preheader:                  ; preds = %if.end358
  %87 = load half, ptr addrspace(3) %gep716, align 2, !tbaa !125
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %87, i64 0
  %88 = load half, ptr addrspace(3) %gep716.1, align 2, !tbaa !125
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %88, i64 1
  %89 = load half, ptr addrspace(3) %gep716.2, align 2, !tbaa !125
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %89, i64 2
  %90 = load half, ptr addrspace(3) %gep716.3, align 2, !tbaa !125
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %90, i64 3
  %91 = load half, ptr addrspace(3) %gep716.1798, align 2, !tbaa !125
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %91, i64 0
  %92 = load half, ptr addrspace(3) %gep716.1.1, align 2, !tbaa !125
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %92, i64 1
  %93 = load half, ptr addrspace(3) %gep716.2.1, align 2, !tbaa !125
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %93, i64 2
  %94 = load half, ptr addrspace(3) %gep716.3.1, align 2, !tbaa !125
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %94, i64 3
  %95 = load half, ptr addrspace(3) %gep716.2804, align 2, !tbaa !125
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %95, i64 0
  %96 = load half, ptr addrspace(3) %gep716.1.2, align 2, !tbaa !125
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %96, i64 1
  %97 = load half, ptr addrspace(3) %gep716.2.2, align 2, !tbaa !125
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %97, i64 2
  %98 = load half, ptr addrspace(3) %gep716.3.2, align 2, !tbaa !125
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %98, i64 3
  %99 = load half, ptr addrspace(3) %gep716.3810, align 2, !tbaa !125
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %99, i64 0
  %100 = load half, ptr addrspace(3) %gep716.1.3, align 2, !tbaa !125
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %100, i64 1
  %101 = load half, ptr addrspace(3) %gep716.2.3, align 2, !tbaa !125
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %101, i64 2
  %102 = load half, ptr addrspace(3) %gep716.3.3, align 2, !tbaa !125
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %102, i64 3
  %103 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.0.0)
  %104 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.20.0)
  %105 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.38.0)
  %106 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.56.0)
  br label %if.end427

if.end427:                                        ; preds = %for.cond371.preheader.preheader, %if.end358
  %out.sroa.56.1 = phi <4 x float> [ %out.sroa.56.0, %if.end358 ], [ %106, %for.cond371.preheader.preheader ]
  %out.sroa.38.1 = phi <4 x float> [ %out.sroa.38.0, %if.end358 ], [ %105, %for.cond371.preheader.preheader ]
  %out.sroa.20.1 = phi <4 x float> [ %out.sroa.20.0, %if.end358 ], [ %104, %for.cond371.preheader.preheader ]
  %out.sroa.0.1 = phi <4 x float> [ %out.sroa.0.0, %if.end358 ], [ %103, %for.cond371.preheader.preheader ]
  %inc429 = or disjoint i32 %s_1.0720, 1
  %arrayidx118.1 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %inc429
  %107 = load i32, ptr addrspace(5) %arrayidx118.1, align 4, !tbaa !30
  %or.cond732.1 = icmp ugt i32 %107, 95
  %cmp125.not.1 = icmp sgt i32 %107, %shr34
  %or.cond733.1 = or i1 %or.cond732.1, %cmp125.not.1
  br i1 %or.cond733.1, label %if.end283.1, label %for.body130.preheader.1

for.body130.preheader.1:                          ; preds = %if.end427
  store i32 %k.sroa.0.2, ptr addrspace(3) %invariant.gep696, align 16, !tbaa !30
  store i32 %k.sroa.5.2, ptr addrspace(3) %k.sroa.5.0.invariant.gep696.sroa_idx, align 4, !tbaa !30
  store i32 %k.sroa.7.2, ptr addrspace(3) %k.sroa.7.0.invariant.gep696.sroa_idx, align 8, !tbaa !30
  store i32 %k.sroa.9.2, ptr addrspace(3) %k.sroa.9.0.invariant.gep696.sroa_idx, align 4, !tbaa !30
  store i32 %k.sroa.11.2, ptr addrspace(3) %gep697.1, align 16, !tbaa !30
  store i32 %k.sroa.14.2, ptr addrspace(3) %k.sroa.14.16.gep697.1.sroa_idx, align 4, !tbaa !30
  store i32 %k.sroa.16.2, ptr addrspace(3) %k.sroa.16.16.gep697.1.sroa_idx, align 8, !tbaa !30
  store i32 %k.sroa.18.2, ptr addrspace(3) %k.sroa.18.16.gep697.1.sroa_idx, align 4, !tbaa !30
  %mul152.1 = shl nuw nsw i32 %107, 4
  %add153.1 = or disjoint i32 %mul152.1, 15
  %cmp154.1 = icmp ult i32 %0, %add153.1
  br i1 %cmp154.1, label %for.cond156.preheader.1, label %if.end181.1

for.cond156.preheader.1:                          ; preds = %for.body130.preheader.1
  %add164.1 = add nuw nsw i32 %mul152.1, %mul163
  %cmp167.not.1 = icmp ugt i32 %add164.1, %0
  %spec.select.1953 = select i1 %cmp167.not.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.0.vec.insert837.1 = insertelement <4 x float> poison, float %spec.select.1953, i64 0
  %cmp167.not.1.not.1 = icmp ult i32 %add164.1, %0
  %spec.select.1.1 = select i1 %cmp167.not.1.not.1, float 0.000000e+00, float 0xFFF0000000000000
  %scores.sroa.0.4.vec.insert844.1 = insertelement <4 x float> %scores.sroa.0.0.vec.insert837.1, float %spec.select.1.1, i64 1
  %add165.2.1 = or disjoint i32 %add164.1, 2
  %cmp167.not.2.1 = icmp ugt i32 %add165.2.1, %0
  %spec.select.2.1 = select i1 %cmp167.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.8.vec.insert851.1 = insertelement <4 x float> %scores.sroa.0.4.vec.insert844.1, float %spec.select.2.1, i64 2
  %add165.3.1 = or disjoint i32 %add164.1, 3
  %cmp167.not.3.1 = icmp ugt i32 %add165.3.1, %0
  %spec.select.3.1 = select i1 %cmp167.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %scores.sroa.0.12.vec.insert858.1 = insertelement <4 x float> %scores.sroa.0.8.vec.insert851.1, float %spec.select.3.1, i64 3
  br label %if.end181.1

if.end181.1:                                      ; preds = %for.cond156.preheader.1, %for.body130.preheader.1
  %scores.sroa.0.1.1 = phi <4 x float> [ %scores.sroa.0.12.vec.insert858.1, %for.cond156.preheader.1 ], [ zeroinitializer, %for.body130.preheader.1 ]
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload.1 = load <4 x half>, ptr addrspace(3) %add.ptr199, align 16
  %kb.sroa.6.0.copyload.1 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr199.sroa_idx, align 8
  %108 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload.1, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.1.1), !call_argsrelate !86
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload.1, <4 x half> %q.sroa.4.0.copyload, <4 x float> %108), !call_argsrelate !86
  %kb.sroa.0.0.copyload827.1 = load <4 x half>, ptr addrspace(3) %add.ptr199.1, align 16
  %kb.sroa.6.0.copyload828.1 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr199.1.sroa_idx, align 8
  %110 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload827.1, <4 x half> %q.sroa.5.16.copyload, <4 x float> %109), !call_argsrelate !86
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload828.1, <4 x half> %q.sroa.7.16.copyload, <4 x float> %110), !call_argsrelate !86
  store i32 %v.sroa.0.2, ptr addrspace(3) %invariant.gep708, align 16, !tbaa !30
  store i32 %v.sroa.5.2, ptr addrspace(3) %v.sroa.5.0.invariant.gep708.sroa_idx, align 4, !tbaa !30
  store i32 %v.sroa.7.2, ptr addrspace(3) %v.sroa.7.0.invariant.gep708.sroa_idx, align 8, !tbaa !30
  store i32 %v.sroa.9.2, ptr addrspace(3) %v.sroa.9.0.invariant.gep708.sroa_idx, align 4, !tbaa !30
  store i32 %v.sroa.11.2, ptr addrspace(3) %gep.1, align 16, !tbaa !30
  store i32 %v.sroa.14.2, ptr addrspace(3) %v.sroa.14.16.gep.1.sroa_idx, align 4, !tbaa !30
  store i32 %v.sroa.16.2, ptr addrspace(3) %v.sroa.16.16.gep.1.sroa_idx, align 8, !tbaa !30
  store i32 %v.sroa.18.2, ptr addrspace(3) %v.sroa.18.16.gep.1.sroa_idx, align 4, !tbaa !30
  %scores.sroa.0.0.vec.extract.1 = extractelement <4 x float> %111, i64 0
  %mul256.1954 = fmul contract float %scores.sroa.0.0.vec.extract.1, 0x3FB99999A0000000
  %112 = tail call contract noundef float @llvm.minnum.f32(float %mul256.1954, float 0x4024CB5EC0000000)
  %113 = tail call contract noundef float @llvm.exp.f32(float %112)
  %add265.1955 = fadd contract float %partial_sum.sroa.0.1, %113
  %scores.sroa.0.4.vec.extract.1 = extractelement <4 x float> %111, i64 1
  %mul256.1.1 = fmul contract float %scores.sroa.0.4.vec.extract.1, 0x3FB99999A0000000
  %114 = tail call contract noundef float @llvm.minnum.f32(float %mul256.1.1, float 0x4024CB5EC0000000)
  %115 = tail call contract noundef float @llvm.exp.f32(float %114)
  %add265.1.1 = fadd contract float %partial_sum.sroa.6.1, %115
  %scores.sroa.0.8.vec.extract.1 = extractelement <4 x float> %111, i64 2
  %mul256.2.1 = fmul contract float %scores.sroa.0.8.vec.extract.1, 0x3FB99999A0000000
  %116 = tail call contract noundef float @llvm.minnum.f32(float %mul256.2.1, float 0x4024CB5EC0000000)
  %117 = tail call contract noundef float @llvm.exp.f32(float %116)
  %add265.2.1 = fadd contract float %partial_sum.sroa.10.1, %117
  %scores.sroa.0.12.vec.extract.1 = extractelement <4 x float> %111, i64 3
  %mul256.3.1 = fmul contract float %scores.sroa.0.12.vec.extract.1, 0x3FB99999A0000000
  %118 = tail call contract noundef float @llvm.minnum.f32(float %mul256.3.1, float 0x4024CB5EC0000000)
  %119 = tail call contract noundef float @llvm.exp.f32(float %118)
  %add265.3.1 = fadd contract float %partial_sum.sroa.14.1, %119
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %113)
  %121 = insertelement <4 x i16> poison, i16 %120, i64 0
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %115)
  %123 = insertelement <4 x i16> %121, i16 %122, i64 1
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %117)
  %125 = insertelement <4 x i16> %123, i16 %124, i64 2
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %119)
  %127 = insertelement <4 x i16> %125, i16 %126, i64 3
  %prob.sroa.0.6.vec.insert.1 = bitcast <4 x i16> %127 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end283.1

if.end283.1:                                      ; preds = %if.end181.1, %if.end427
  %partial_sum.sroa.14.1.1 = phi float [ %partial_sum.sroa.14.1, %if.end427 ], [ %add265.3.1, %if.end181.1 ]
  %partial_sum.sroa.10.1.1 = phi float [ %partial_sum.sroa.10.1, %if.end427 ], [ %add265.2.1, %if.end181.1 ]
  %partial_sum.sroa.6.1.1 = phi float [ %partial_sum.sroa.6.1, %if.end427 ], [ %add265.1.1, %if.end181.1 ]
  %partial_sum.sroa.0.1.1 = phi float [ %partial_sum.sroa.0.1, %if.end427 ], [ %add265.1955, %if.end181.1 ]
  %prob.sroa.0.1.1 = phi <4 x half> [ %prob.sroa.0.1, %if.end427 ], [ %prob.sroa.0.6.vec.insert.1, %if.end181.1 ]
  %cmp284.not.1 = icmp eq i32 %s_1.0720, 2
  br i1 %cmp284.not.1, label %if.end358.1, label %if.then285.1

if.then285.1:                                     ; preds = %if.end283.1
  %add286.1 = add nuw nsw i32 %s_1.0720, 2
  %arrayidx288.1 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %add286.1
  %128 = load i32, ptr addrspace(5) %arrayidx288.1, align 4, !tbaa !30
  %or.cond734.1 = icmp ugt i32 %128, 95
  %cmp295.not.1 = icmp sgt i32 %128, %shr34
  %or.cond735.1 = or i1 %or.cond734.1, %cmp295.not.1
  br i1 %or.cond735.1, label %if.end358.1, label %for.cond297.preheader.1

for.cond297.preheader.1:                          ; preds = %if.then285.1
  %mul305.1 = shl nuw nsw i32 %128, 10
  %add307.1 = add nuw nsw i32 %mul305.1, %37
  %129 = zext nneg i32 %add307.1 to i64
  %add.ptr314.1956 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %129
  %130 = load i32, ptr addrspace(4) %add.ptr314.1956, align 4, !tbaa !30
  %131 = or disjoint i64 %129, 2
  %add.ptr314.1.1957 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %131
  %132 = load i32, ptr addrspace(4) %add.ptr314.1.1957, align 4, !tbaa !30
  %133 = or disjoint i64 %129, 4
  %add.ptr314.2.1958 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %133
  %134 = load i32, ptr addrspace(4) %add.ptr314.2.1958, align 4, !tbaa !30
  %135 = or disjoint i64 %129, 6
  %add.ptr314.3.1959 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %135
  %136 = load i32, ptr addrspace(4) %add.ptr314.3.1959, align 4, !tbaa !30
  %137 = add nuw nsw i64 %129, 512
  %add.ptr314.1780.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %137
  %138 = load i32, ptr addrspace(4) %add.ptr314.1780.1, align 4, !tbaa !30
  %139 = add nuw nsw i64 %129, 514
  %add.ptr314.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %139
  %140 = load i32, ptr addrspace(4) %add.ptr314.1.1.1, align 4, !tbaa !30
  %141 = add nuw nsw i64 %129, 516
  %add.ptr314.2.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %141
  %142 = load i32, ptr addrspace(4) %add.ptr314.2.1.1, align 4, !tbaa !30
  %143 = add nuw nsw i64 %129, 518
  %add.ptr314.3.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %143
  %144 = load i32, ptr addrspace(4) %add.ptr314.3.1.1, align 4, !tbaa !30
  %add.ptr344.1960 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %129
  %145 = load i32, ptr addrspace(4) %add.ptr344.1960, align 4, !tbaa !30
  %add.ptr344.1.1961 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %131
  %146 = load i32, ptr addrspace(4) %add.ptr344.1.1961, align 4, !tbaa !30
  %add.ptr344.2.1962 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %133
  %147 = load i32, ptr addrspace(4) %add.ptr344.2.1962, align 4, !tbaa !30
  %add.ptr344.3.1963 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %135
  %148 = load i32, ptr addrspace(4) %add.ptr344.3.1963, align 4, !tbaa !30
  %add.ptr344.1792.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %137
  %149 = load i32, ptr addrspace(4) %add.ptr344.1792.1, align 4, !tbaa !30
  %add.ptr344.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %139
  %150 = load i32, ptr addrspace(4) %add.ptr344.1.1.1, align 4, !tbaa !30
  %add.ptr344.2.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %141
  %151 = load i32, ptr addrspace(4) %add.ptr344.2.1.1, align 4, !tbaa !30
  %add.ptr344.3.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %143
  %152 = load i32, ptr addrspace(4) %add.ptr344.3.1.1, align 4, !tbaa !30
  br label %if.end358.1

if.end358.1:                                      ; preds = %for.cond297.preheader.1, %if.then285.1, %if.end283.1
  %k.sroa.18.2.1 = phi i32 [ %k.sroa.18.2, %if.end283.1 ], [ %k.sroa.18.2, %if.then285.1 ], [ %144, %for.cond297.preheader.1 ]
  %k.sroa.16.2.1 = phi i32 [ %k.sroa.16.2, %if.end283.1 ], [ %k.sroa.16.2, %if.then285.1 ], [ %142, %for.cond297.preheader.1 ]
  %k.sroa.14.2.1 = phi i32 [ %k.sroa.14.2, %if.end283.1 ], [ %k.sroa.14.2, %if.then285.1 ], [ %140, %for.cond297.preheader.1 ]
  %k.sroa.11.2.1 = phi i32 [ %k.sroa.11.2, %if.end283.1 ], [ %k.sroa.11.2, %if.then285.1 ], [ %138, %for.cond297.preheader.1 ]
  %k.sroa.9.2.1 = phi i32 [ %k.sroa.9.2, %if.end283.1 ], [ %k.sroa.9.2, %if.then285.1 ], [ %136, %for.cond297.preheader.1 ]
  %k.sroa.7.2.1 = phi i32 [ %k.sroa.7.2, %if.end283.1 ], [ %k.sroa.7.2, %if.then285.1 ], [ %134, %for.cond297.preheader.1 ]
  %k.sroa.5.2.1 = phi i32 [ %k.sroa.5.2, %if.end283.1 ], [ %k.sroa.5.2, %if.then285.1 ], [ %132, %for.cond297.preheader.1 ]
  %k.sroa.0.2.1 = phi i32 [ %k.sroa.0.2, %if.end283.1 ], [ %k.sroa.0.2, %if.then285.1 ], [ %130, %for.cond297.preheader.1 ]
  %v.sroa.18.2.1 = phi i32 [ %v.sroa.18.2, %if.end283.1 ], [ %v.sroa.18.2, %if.then285.1 ], [ %152, %for.cond297.preheader.1 ]
  %v.sroa.16.2.1 = phi i32 [ %v.sroa.16.2, %if.end283.1 ], [ %v.sroa.16.2, %if.then285.1 ], [ %151, %for.cond297.preheader.1 ]
  %v.sroa.14.2.1 = phi i32 [ %v.sroa.14.2, %if.end283.1 ], [ %v.sroa.14.2, %if.then285.1 ], [ %150, %for.cond297.preheader.1 ]
  %v.sroa.11.2.1 = phi i32 [ %v.sroa.11.2, %if.end283.1 ], [ %v.sroa.11.2, %if.then285.1 ], [ %149, %for.cond297.preheader.1 ]
  %v.sroa.9.2.1 = phi i32 [ %v.sroa.9.2, %if.end283.1 ], [ %v.sroa.9.2, %if.then285.1 ], [ %148, %for.cond297.preheader.1 ]
  %v.sroa.7.2.1 = phi i32 [ %v.sroa.7.2, %if.end283.1 ], [ %v.sroa.7.2, %if.then285.1 ], [ %147, %for.cond297.preheader.1 ]
  %v.sroa.5.2.1 = phi i32 [ %v.sroa.5.2, %if.end283.1 ], [ %v.sroa.5.2, %if.then285.1 ], [ %146, %for.cond297.preheader.1 ]
  %v.sroa.0.2.1 = phi i32 [ %v.sroa.0.2, %if.end283.1 ], [ %v.sroa.0.2, %if.then285.1 ], [ %145, %for.cond297.preheader.1 ]
  br i1 %or.cond733.1, label %if.end427.1, label %for.cond371.preheader.preheader.1

for.cond371.preheader.preheader.1:                ; preds = %if.end358.1
  %153 = load half, ptr addrspace(3) %gep716, align 2, !tbaa !125
  %vb.sroa.0.0.vec.insert.1 = insertelement <4 x half> poison, half %153, i64 0
  %154 = load half, ptr addrspace(3) %gep716.1, align 2, !tbaa !125
  %vb.sroa.0.2.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.0.vec.insert.1, half %154, i64 1
  %155 = load half, ptr addrspace(3) %gep716.2, align 2, !tbaa !125
  %vb.sroa.0.4.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.2.vec.insert.1, half %155, i64 2
  %156 = load half, ptr addrspace(3) %gep716.3, align 2, !tbaa !125
  %vb.sroa.0.6.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.4.vec.insert.1, half %156, i64 3
  %157 = load half, ptr addrspace(3) %gep716.1798, align 2, !tbaa !125
  %vb.sroa.7.8.vec.insert.1 = insertelement <4 x half> poison, half %157, i64 0
  %158 = load half, ptr addrspace(3) %gep716.1.1, align 2, !tbaa !125
  %vb.sroa.7.10.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.8.vec.insert.1, half %158, i64 1
  %159 = load half, ptr addrspace(3) %gep716.2.1, align 2, !tbaa !125
  %vb.sroa.7.12.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.10.vec.insert.1, half %159, i64 2
  %160 = load half, ptr addrspace(3) %gep716.3.1, align 2, !tbaa !125
  %vb.sroa.7.14.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.12.vec.insert.1, half %160, i64 3
  %161 = load half, ptr addrspace(3) %gep716.2804, align 2, !tbaa !125
  %vb.sroa.12.16.vec.insert.1 = insertelement <4 x half> poison, half %161, i64 0
  %162 = load half, ptr addrspace(3) %gep716.1.2, align 2, !tbaa !125
  %vb.sroa.12.18.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.16.vec.insert.1, half %162, i64 1
  %163 = load half, ptr addrspace(3) %gep716.2.2, align 2, !tbaa !125
  %vb.sroa.12.20.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.18.vec.insert.1, half %163, i64 2
  %164 = load half, ptr addrspace(3) %gep716.3.2, align 2, !tbaa !125
  %vb.sroa.12.22.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.20.vec.insert.1, half %164, i64 3
  %165 = load half, ptr addrspace(3) %gep716.3810, align 2, !tbaa !125
  %vb.sroa.17.24.vec.insert.1 = insertelement <4 x half> poison, half %165, i64 0
  %166 = load half, ptr addrspace(3) %gep716.1.3, align 2, !tbaa !125
  %vb.sroa.17.26.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.24.vec.insert.1, half %166, i64 1
  %167 = load half, ptr addrspace(3) %gep716.2.3, align 2, !tbaa !125
  %vb.sroa.17.28.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.26.vec.insert.1, half %167, i64 2
  %168 = load half, ptr addrspace(3) %gep716.3.3, align 2, !tbaa !125
  %vb.sroa.17.30.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.28.vec.insert.1, half %168, i64 3
  %169 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.0.1)
  %170 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.20.1)
  %171 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.38.1)
  %172 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.56.1)
  br label %if.end427.1

if.end427.1:                                      ; preds = %for.cond371.preheader.preheader.1, %if.end358.1
  %out.sroa.56.1.1 = phi <4 x float> [ %out.sroa.56.1, %if.end358.1 ], [ %172, %for.cond371.preheader.preheader.1 ]
  %out.sroa.38.1.1 = phi <4 x float> [ %out.sroa.38.1, %if.end358.1 ], [ %171, %for.cond371.preheader.preheader.1 ]
  %out.sroa.20.1.1 = phi <4 x float> [ %out.sroa.20.1, %if.end358.1 ], [ %170, %for.cond371.preheader.preheader.1 ]
  %out.sroa.0.1.1 = phi <4 x float> [ %out.sroa.0.1, %if.end358.1 ], [ %169, %for.cond371.preheader.preheader.1 ]
  %inc429.1 = add nuw nsw i32 %s_1.0720, 2
  %exitcond.not.1 = icmp eq i32 %inc429.1, 4
  br i1 %exitcond.not.1, label %for.body435.preheader, label %for.body116, !llvm.loop !131

for.body435.preheader:                            ; preds = %if.end427.1
  %add439 = fadd contract float %partial_sum.sroa.0.1.1, 0.000000e+00
  %add439.1 = fadd contract float %add439, %partial_sum.sroa.6.1.1
  %add439.2 = fadd contract float %add439.1, %partial_sum.sroa.10.1.1
  %add439.3 = fadd contract float %add439.2, %partial_sum.sroa.14.1.1
  %173 = bitcast float %add439.3 to i32
  %174 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #13
  %175 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %174) #13
  %xor.i.i = xor i32 %175, 32
  %176 = and i32 %175, -64
  %and.i.i = add nsw i32 %176, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %175
  %shl.i.i = shl i32 %cond.i.i, 2
  %177 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %173)
  %178 = bitcast i32 %177 to float
  %add.i = fadd contract float %add439.3, %178
  %179 = bitcast float %add.i to i32
  %180 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #13
  %181 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %180) #13
  %xor.i.i683 = xor i32 %181, 16
  %182 = and i32 %181, -64
  %and.i.i684 = add nsw i32 %182, 64
  %cmp.not.i.i685 = icmp slt i32 %xor.i.i683, %and.i.i684
  %cond.i.i686 = select i1 %cmp.not.i.i685, i32 %xor.i.i683, i32 %181
  %shl.i.i687 = shl i32 %cond.i.i686, 2
  %183 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i687, i32 %179)
  %184 = bitcast i32 %183 to float
  %add.i.i = fadd contract float %add.i, %184
  %cmp448 = fcmp contract ogt float %add.i.i, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add.i.i
  %condval_1.0 = select i1 %cmp448, float %div, float 0.000000e+00
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 0
  %mul461 = fmul contract float %condval_1.0, %out.sroa.0.0.vec.extract
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 1
  %mul461.1 = fmul contract float %condval_1.0, %out.sroa.0.4.vec.extract
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 2
  %mul461.2 = fmul contract float %condval_1.0, %out.sroa.0.8.vec.extract
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 3
  %mul461.3 = fmul contract float %condval_1.0, %out.sroa.0.12.vec.extract
  %out.sroa.20.16.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 0
  %mul461.4 = fmul contract float %condval_1.0, %out.sroa.20.16.vec.extract
  %out.sroa.20.20.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 1
  %mul461.5 = fmul contract float %condval_1.0, %out.sroa.20.20.vec.extract
  %out.sroa.20.24.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 2
  %mul461.6 = fmul contract float %condval_1.0, %out.sroa.20.24.vec.extract
  %out.sroa.20.28.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 3
  %mul461.7 = fmul contract float %condval_1.0, %out.sroa.20.28.vec.extract
  %out.sroa.38.32.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 0
  %mul461.8 = fmul contract float %condval_1.0, %out.sroa.38.32.vec.extract
  %out.sroa.38.36.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 1
  %mul461.9 = fmul contract float %condval_1.0, %out.sroa.38.36.vec.extract
  %out.sroa.38.40.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 2
  %mul461.10 = fmul contract float %condval_1.0, %out.sroa.38.40.vec.extract
  %out.sroa.38.44.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 3
  %mul461.11 = fmul contract float %condval_1.0, %out.sroa.38.44.vec.extract
  %out.sroa.56.48.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 0
  %mul461.12 = fmul contract float %condval_1.0, %out.sroa.56.48.vec.extract
  %out.sroa.56.52.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 1
  %mul461.13 = fmul contract float %condval_1.0, %out.sroa.56.52.vec.extract
  %out.sroa.56.56.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 2
  %mul461.14 = fmul contract float %condval_1.0, %out.sroa.56.56.vec.extract
  %out.sroa.56.60.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 3
  %mul461.15 = fmul contract float %condval_1.0, %out.sroa.56.60.vec.extract
  %185 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461)
  %result.sroa.0.0.insert.ext = zext i16 %185 to i64
  %186 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461.1)
  %result.sroa.0.2.insert.ext = zext i16 %186 to i64
  %result.sroa.0.2.insert.shift = shl nuw nsw i64 %result.sroa.0.2.insert.ext, 16
  %result.sroa.0.2.insert.insert = or disjoint i64 %result.sroa.0.2.insert.shift, %result.sroa.0.0.insert.ext
  %187 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461.2)
  %result.sroa.0.4.insert.ext = zext i16 %187 to i64
  %result.sroa.0.4.insert.shift = shl nuw nsw i64 %result.sroa.0.4.insert.ext, 32
  %result.sroa.0.4.insert.insert = or disjoint i64 %result.sroa.0.2.insert.insert, %result.sroa.0.4.insert.shift
  %188 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461.3)
  %result.sroa.0.6.insert.ext = zext i16 %188 to i64
  %result.sroa.0.6.insert.shift = shl nuw i64 %result.sroa.0.6.insert.ext, 48
  %result.sroa.0.6.insert.insert = or disjoint i64 %result.sroa.0.4.insert.insert, %result.sroa.0.6.insert.shift
  %189 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461.4)
  %result.sroa.7.8.insert.ext = zext i16 %189 to i64
  %190 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461.5)
  %result.sroa.7.10.insert.ext = zext i16 %190 to i64
  %result.sroa.7.10.insert.shift = shl nuw nsw i64 %result.sroa.7.10.insert.ext, 16
  %result.sroa.7.10.insert.insert = or disjoint i64 %result.sroa.7.10.insert.shift, %result.sroa.7.8.insert.ext
  %191 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461.6)
  %result.sroa.7.12.insert.ext = zext i16 %191 to i64
  %result.sroa.7.12.insert.shift = shl nuw nsw i64 %result.sroa.7.12.insert.ext, 32
  %result.sroa.7.12.insert.insert = or disjoint i64 %result.sroa.7.10.insert.insert, %result.sroa.7.12.insert.shift
  %192 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461.7)
  %result.sroa.7.14.insert.ext = zext i16 %192 to i64
  %result.sroa.7.14.insert.shift = shl nuw i64 %result.sroa.7.14.insert.ext, 48
  %result.sroa.7.14.insert.insert = or disjoint i64 %result.sroa.7.12.insert.insert, %result.sroa.7.14.insert.shift
  %193 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461.8)
  %result.sroa.12.16.insert.ext = zext i16 %193 to i64
  %194 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461.9)
  %result.sroa.12.18.insert.ext = zext i16 %194 to i64
  %result.sroa.12.18.insert.shift = shl nuw nsw i64 %result.sroa.12.18.insert.ext, 16
  %result.sroa.12.18.insert.insert = or disjoint i64 %result.sroa.12.18.insert.shift, %result.sroa.12.16.insert.ext
  %195 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461.10)
  %result.sroa.12.20.insert.ext = zext i16 %195 to i64
  %result.sroa.12.20.insert.shift = shl nuw nsw i64 %result.sroa.12.20.insert.ext, 32
  %result.sroa.12.20.insert.insert = or disjoint i64 %result.sroa.12.18.insert.insert, %result.sroa.12.20.insert.shift
  %196 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461.11)
  %result.sroa.12.22.insert.ext = zext i16 %196 to i64
  %result.sroa.12.22.insert.shift = shl nuw i64 %result.sroa.12.22.insert.ext, 48
  %result.sroa.12.22.insert.insert = or disjoint i64 %result.sroa.12.20.insert.insert, %result.sroa.12.22.insert.shift
  %197 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461.12)
  %result.sroa.17.24.insert.ext = zext i16 %197 to i64
  %198 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461.13)
  %result.sroa.17.26.insert.ext = zext i16 %198 to i64
  %result.sroa.17.26.insert.shift = shl nuw nsw i64 %result.sroa.17.26.insert.ext, 16
  %result.sroa.17.26.insert.insert = or disjoint i64 %result.sroa.17.26.insert.shift, %result.sroa.17.24.insert.ext
  %199 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461.14)
  %result.sroa.17.28.insert.ext = zext i16 %199 to i64
  %result.sroa.17.28.insert.shift = shl nuw nsw i64 %result.sroa.17.28.insert.ext, 32
  %result.sroa.17.28.insert.insert = or disjoint i64 %result.sroa.17.26.insert.insert, %result.sroa.17.28.insert.shift
  %200 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul461.15)
  %result.sroa.17.30.insert.ext = zext i16 %200 to i64
  %result.sroa.17.30.insert.shift = shl nuw i64 %result.sroa.17.30.insert.ext, 48
  %result.sroa.17.30.insert.insert = or disjoint i64 %result.sroa.17.28.insert.insert, %result.sroa.17.30.insert.shift
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %shr503 = lshr i32 %1, 5
  %xor507 = xor i32 %shr503, %and194
  %mul508 = shl nuw nsw i32 %xor507, 3
  %add509 = add nuw nsw i32 %mul508, %mul7
  %add514 = or disjoint i32 %add509, %mul388
  %add.ptr516 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add514
  store i64 %result.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr516, align 8
  %add504.1 = add nuw nsw i32 %shr503, 2
  %xor507.1 = xor i32 %add504.1, %and194
  %mul508.1 = shl nuw nsw i32 %xor507.1, 3
  %add509.1 = add nuw nsw i32 %mul508.1, %mul7
  %add514.1 = or disjoint i32 %add509.1, %mul388
  %add.ptr516.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add514.1
  store i64 %result.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr516.1, align 8
  %add504.2 = add nuw nsw i32 %shr503, 4
  %xor507.2 = xor i32 %add504.2, %and194
  %mul508.2 = shl nuw nsw i32 %xor507.2, 3
  %add509.2 = add nuw nsw i32 %mul508.2, %mul7
  %add514.2 = or disjoint i32 %add509.2, %mul388
  %add.ptr516.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add514.2
  store i64 %result.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr516.2, align 8
  %add504.3 = add nuw nsw i32 %shr503, 6
  %xor507.3 = xor i32 %add504.3, %and194
  %mul508.3 = shl nuw nsw i32 %xor507.3, 3
  %add509.3 = add nuw nsw i32 %mul508.3, %mul7
  %add514.3 = or disjoint i32 %add509.3, %mul388
  %add.ptr516.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add514.3
  store i64 %result.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr516.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add541 = add nuw nsw i32 %37, %mul
  %201 = zext nneg i32 %add541 to i64
  %add.ptr546 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %201
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr546, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep696, i64 16, i1 false), !tbaa.struct !211, !call_argsrelate !212
  %gep730.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep696, i32 1024
  %202 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %201
  %add.ptr546.1 = getelementptr inbounds i8, ptr addrspace(1) %202, i64 1024
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr546.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep730.1, i64 16, i1 false), !tbaa.struct !211, !call_argsrelate !212
  call void @llvm.lifetime.end.p5(i64 16, ptr addrspace(5) %blocks) #12, !call_argsrelate !43
  ret void
}

declare void @llvm.lifetime.start.p5(i64 immarg, ptr addrspace(5) nocapture) #4

declare void @llvm.lifetime.end.p5(i64 immarg, ptr addrspace(5) nocapture) #4

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #5

declare i32 @llvm.mxc.block.id.x() #6

declare i32 @llvm.mxc.block.id.y() #6

declare i32 @llvm.mxc.block.id.z() #6

declare i32 @llvm.mxc.thread.id.x() #6

declare void @llvm.mxc.barrier.warp() #7

declare float @llvm.exp.f32(float) #8

declare i16 @llvm.convert.to.fp16.f32(float) #9

declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #5

declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #5

declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #5

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
attributes #13 = { nomerge }


