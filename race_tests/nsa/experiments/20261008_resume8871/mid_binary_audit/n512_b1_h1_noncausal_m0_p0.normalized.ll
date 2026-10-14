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
  %mul = shl nsw i32 %0, 10
  %1 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %mul8 = shl nuw nsw i32 %1, 3
  %add = add nuw nsw i32 %mul8, %mul
  %2 = zext nneg i32 %add to i64
  %3 = add nuw nsw i64 %2, 512
  %idxprom = zext nneg i32 %0 to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom
  %4 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cmp28 = icmp ult i32 %4, 32
  br i1 %cmp28, label %for.cond31.preheader, label %if.end304

for.cond31.preheader:                             ; preds = %entry
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %2
  %mul40 = shl nuw nsw i32 %4, 10
  %add42 = add nuw nsw i32 %mul40, %mul8
  %5 = zext nneg i32 %add42 to i64
  %add.ptr49 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %5
  %6 = load i32, ptr addrspace(4) %add.ptr49, align 4, !tbaa !30
  %7 = or disjoint i64 %5, 2
  %add.ptr49.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %7
  %8 = load i32, ptr addrspace(4) %add.ptr49.1, align 4, !tbaa !30
  %9 = or disjoint i64 %5, 4
  %add.ptr49.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %9
  %10 = load i32, ptr addrspace(4) %add.ptr49.2, align 4, !tbaa !30
  %11 = or disjoint i64 %5, 6
  %add.ptr49.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %11
  %12 = load i32, ptr addrspace(4) %add.ptr49.3, align 4, !tbaa !30
  %13 = add nuw nsw i64 %5, 512
  %add.ptr49.1613 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %13
  %14 = load i32, ptr addrspace(4) %add.ptr49.1613, align 4, !tbaa !30
  %15 = add nuw nsw i64 %5, 514
  %add.ptr49.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %15
  %16 = load i32, ptr addrspace(4) %add.ptr49.1.1, align 4, !tbaa !30
  %17 = add nuw nsw i64 %5, 516
  %add.ptr49.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %17
  %18 = load i32, ptr addrspace(4) %add.ptr49.2.1, align 4, !tbaa !30
  %19 = add nuw nsw i64 %5, 518
  %add.ptr49.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %19
  %20 = load i32, ptr addrspace(4) %add.ptr49.3.1, align 4, !tbaa !30
  %add.ptr79 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %5
  %21 = load i32, ptr addrspace(4) %add.ptr79, align 4, !tbaa !30
  %add.ptr79.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %7
  %22 = load i32, ptr addrspace(4) %add.ptr79.1, align 4, !tbaa !30
  %add.ptr79.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %9
  %23 = load i32, ptr addrspace(4) %add.ptr79.2, align 4, !tbaa !30
  %add.ptr79.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %11
  %24 = load i32, ptr addrspace(4) %add.ptr79.3, align 4, !tbaa !30
  %add.ptr79.1625 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %13
  %25 = load i32, ptr addrspace(4) %add.ptr79.1625, align 4, !tbaa !30
  %add.ptr79.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %15
  %26 = load i32, ptr addrspace(4) %add.ptr79.1.1, align 4, !tbaa !30
  %add.ptr79.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %17
  %27 = load i32, ptr addrspace(4) %add.ptr79.2.1, align 4, !tbaa !30
  %add.ptr79.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %19
  %28 = load i32, ptr addrspace(4) %add.ptr79.3.1, align 4, !tbaa !30
  %mul102 = and i32 %mul8, 8128
  %xor551 = and i32 %mul8, 56
  %call105.masked = and i32 %1, 1016
  %mul107 = xor i32 %xor551, %call105.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul102
  %invariant.gep566 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul107
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep566, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !56
  %gep567.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep566, i32 1024
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep567.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !call_argsrelate !56
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and119 = shl nuw nsw i32 %1, 6
  %mul120 = and i32 %and119, 960
  %shr123 = lshr i32 %1, 4
  %and126 = and i32 %1, 7
  %29 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul120
  %xor127 = xor i32 %shr123, %and126
  %add.ptr131.idx = shl nuw nsw i32 %xor127, 4
  %add.ptr131 = getelementptr inbounds i8, ptr addrspace(3) %29, i32 %add.ptr131.idx
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr131, align 16
  %Q_reg.sroa.4.0.add.ptr131.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr131, i32 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr131.sroa_idx, align 8
  %add124.1 = add nuw nsw i32 %shr123, 4
  %xor127.1 = xor i32 %add124.1, %and126
  %add.ptr131.idx.1 = shl nuw nsw i32 %xor127.1, 4
  %add.ptr131.1 = getelementptr inbounds i8, ptr addrspace(3) %29, i32 %add.ptr131.idx.1
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr131.1, align 16
  %Q_reg.sroa.7.16.add.ptr131.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr131.1, i32 8
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr131.1.sroa_idx, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  store i32 %6, ptr addrspace(3) %invariant.gep566, align 16, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep571.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep566, i32 4
  store i32 %8, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep571.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep571.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep566, i32 8
  store i32 %10, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep571.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep571.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep566, i32 12
  store i32 %12, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep571.sroa_idx, align 4, !tbaa !30
  store i32 %14, ptr addrspace(3) %gep567.1, align 16, !tbaa !30
  %K_reg.sroa.9.16.gep572.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep566, i32 1028
  store i32 %16, ptr addrspace(3) %K_reg.sroa.9.16.gep572.1.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.10.16.gep572.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep566, i32 1032
  store i32 %18, ptr addrspace(3) %K_reg.sroa.10.16.gep572.1.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.11.16.gep572.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep566, i32 1036
  store i32 %20, ptr addrspace(3) %K_reg.sroa.11.16.gep572.1.sroa_idx, align 4, !tbaa !30
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr131, align 16
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr131.sroa_idx, align 8
  %30 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer)
  %31 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %30)
  %kb.sroa.0.0.copyload655 = load <4 x half>, ptr addrspace(3) %add.ptr131.1, align 16
  %kb.sroa.6.0.copyload656 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr131.1.sroa_idx, align 8
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload655, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %31)
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload656, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %32)
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add.ptr223.idx = shl nuw nsw i32 %1, 4
  %invariant.gep579 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr223.idx
  store i32 %21, ptr addrspace(3) %invariant.gep579, align 16, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep579.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep579, i32 4
  store i32 %22, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep579.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep579.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep579, i32 8
  store i32 %23, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep579.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep579.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep579, i32 12
  store i32 %24, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep579.sroa_idx, align 4, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep579, i32 1024
  store i32 %25, ptr addrspace(3) %gep.1, align 16, !tbaa !30
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep579, i32 1028
  store i32 %26, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep579, i32 1032
  store i32 %27, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep579, i32 1036
  store i32 %28, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !tbaa !30
  %34 = shl nuw nsw i32 %4, 2
  %add236 = add nuw nsw i32 %34, %shr123
  %cmp237 = icmp ult i32 %add236, 128
  br i1 %cmp237, label %if.then238, label %if.end

if.then238:                                       ; preds = %for.cond31.preheader
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %33, i64 0
  %mul241 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %35 = tail call contract noundef float @llvm.minnum.f32(float %mul241, float 0x4024CB5EC0000000)
  %36 = tail call contract noundef float @llvm.exp.f32(float %35)
  br label %if.end

if.end:                                           ; preds = %for.cond31.preheader, %if.then238
  %condval.0 = phi float [ %36, %if.then238 ], [ 0.000000e+00, %for.cond31.preheader ]
  br i1 %cmp237, label %if.then238.1, label %if.end.1

if.then238.1:                                     ; preds = %if.end
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %33, i64 1
  %mul241.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %37 = tail call contract noundef float @llvm.minnum.f32(float %mul241.1, float 0x4024CB5EC0000000)
  %38 = tail call contract noundef float @llvm.exp.f32(float %37)
  br label %if.end.1

if.end.1:                                         ; preds = %if.then238.1, %if.end
  %condval.0.1 = phi float [ %38, %if.then238.1 ], [ 0.000000e+00, %if.end ]
  br i1 %cmp237, label %if.then238.2, label %if.end.2

if.then238.2:                                     ; preds = %if.end.1
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %33, i64 2
  %mul241.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %39 = tail call contract noundef float @llvm.minnum.f32(float %mul241.2, float 0x4024CB5EC0000000)
  %40 = tail call contract noundef float @llvm.exp.f32(float %39)
  br label %if.end.2

if.end.2:                                         ; preds = %if.then238.2, %if.end.1
  %condval.0.2 = phi float [ %40, %if.then238.2 ], [ 0.000000e+00, %if.end.1 ]
  br i1 %cmp237, label %if.then238.3, label %if.end.3

if.then238.3:                                     ; preds = %if.end.2
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %33, i64 3
  %mul241.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %41 = tail call contract noundef float @llvm.minnum.f32(float %mul241.3, float 0x4024CB5EC0000000)
  %42 = tail call contract noundef float @llvm.exp.f32(float %41)
  br label %if.end.3

if.end.3:                                         ; preds = %if.then238.3, %if.end.2
  %condval.0.3 = phi float [ %42, %if.then238.3 ], [ 0.000000e+00, %if.end.2 ]
  %add257.1 = fadd contract float %condval.0, %condval.0.1
  %add257.2 = fadd contract float %add257.1, %condval.0.2
  %add257.3 = fadd contract float %add257.2, %condval.0.3
  %43 = bitcast float %add257.3 to i32
  %44 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %45 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %44) #11
  %xor.i.i = xor i32 %45, 32
  %46 = and i32 %45, -64
  %and.i.i = add nsw i32 %46, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %45
  %shl.i.i = shl i32 %cond.i.i, 2
  %47 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %43)
  %48 = bitcast i32 %47 to float
  %add265 = fadd contract float %add257.3, %48
  %49 = bitcast float %add265 to i32
  %50 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %51 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %50) #11
  %xor.i.i553 = xor i32 %51, 16
  %52 = and i32 %51, -64
  %and.i.i554 = add nsw i32 %52, 64
  %cmp.not.i.i555 = icmp slt i32 %xor.i.i553, %and.i.i554
  %cond.i.i556 = select i1 %cmp.not.i.i555, i32 %xor.i.i553, i32 %51
  %shl.i.i557 = shl i32 %cond.i.i556, 2
  %53 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i557, i32 %49)
  %54 = bitcast i32 %53 to float
  %add270 = fadd contract float %add265, %54
  %cmp273 = fcmp contract ogt float %add270, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add270
  %condval_1.0 = select i1 %cmp273, float %div, float 0.000000e+00
  %mul286 = fmul contract float %condval_1.0, %condval.0
  %mul286.1 = fmul contract float %condval_1.0, %condval.0.1
  %mul286.2 = fmul contract float %condval_1.0, %condval.0.2
  %mul286.3 = fmul contract float %condval_1.0, %condval.0.3
  %55 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul286)
  %56 = insertelement <4 x i16> poison, i16 %55, i64 0
  %57 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul286.1)
  %58 = insertelement <4 x i16> %56, i16 %57, i64 1
  %59 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul286.2)
  %60 = insertelement <4 x i16> %58, i16 %59, i64 2
  %61 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul286.3)
  %62 = insertelement <4 x i16> %60, i16 %61, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %62 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end304

if.end304:                                        ; preds = %if.end.3, %entry
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ %acc_s_cast.sroa.0.6.vec.insert, %if.end.3 ], [ undef, %entry ]
  br i1 %cmp28, label %for.cond322.preheader, label %if.end370

for.cond322.preheader:                            ; preds = %if.end304
  %63 = shl nuw nsw i32 %1, 4
  %mul332 = and i32 %63, 16128
  %and338 = and i32 %1, 15
  %add339 = or disjoint i32 %mul332, %and338
  %arrayidx341 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339
  %64 = load half, ptr addrspace(3) %arrayidx341, align 2, !tbaa !158
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %64, i64 0
  %add334.1 = or disjoint i32 %mul332, %and338
  %add339.1 = or disjoint i32 %add334.1, 64
  %arrayidx341.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339.1
  %65 = load half, ptr addrspace(3) %arrayidx341.1, align 2, !tbaa !158
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %65, i64 1
  %add334.2 = or disjoint i32 %mul332, %and338
  %add339.2 = or disjoint i32 %add334.2, 128
  %arrayidx341.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339.2
  %66 = load half, ptr addrspace(3) %arrayidx341.2, align 2, !tbaa !158
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %66, i64 2
  %add334.3 = or disjoint i32 %mul332, %and338
  %add339.3 = or disjoint i32 %add334.3, 192
  %arrayidx341.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339.3
  %67 = load half, ptr addrspace(3) %arrayidx341.3, align 2, !tbaa !158
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %67, i64 3
  %add336.1629 = or disjoint i32 %mul332, %and338
  %add339.1630 = or disjoint i32 %add336.1629, 16
  %arrayidx341.1631 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339.1630
  %68 = load half, ptr addrspace(3) %arrayidx341.1631, align 2, !tbaa !158
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %68, i64 0
  %add336.1.1 = or disjoint i32 %mul332, %and338
  %add339.1.1 = or disjoint i32 %add336.1.1, 80
  %arrayidx341.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339.1.1
  %69 = load half, ptr addrspace(3) %arrayidx341.1.1, align 2, !tbaa !158
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %69, i64 1
  %add336.2.1 = or disjoint i32 %mul332, %and338
  %add339.2.1 = or disjoint i32 %add336.2.1, 144
  %arrayidx341.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339.2.1
  %70 = load half, ptr addrspace(3) %arrayidx341.2.1, align 2, !tbaa !158
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %70, i64 2
  %add336.3.1 = or disjoint i32 %mul332, %and338
  %add339.3.1 = or disjoint i32 %add336.3.1, 208
  %arrayidx341.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339.3.1
  %71 = load half, ptr addrspace(3) %arrayidx341.3.1, align 2, !tbaa !158
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %71, i64 3
  %add336.2633 = or disjoint i32 %mul332, %and338
  %add339.2634 = or disjoint i32 %add336.2633, 32
  %arrayidx341.2635 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339.2634
  %72 = load half, ptr addrspace(3) %arrayidx341.2635, align 2, !tbaa !158
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %72, i64 0
  %add336.1.2 = or disjoint i32 %mul332, %and338
  %add339.1.2 = or disjoint i32 %add336.1.2, 96
  %arrayidx341.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339.1.2
  %73 = load half, ptr addrspace(3) %arrayidx341.1.2, align 2, !tbaa !158
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %73, i64 1
  %add336.2.2 = or disjoint i32 %mul332, %and338
  %add339.2.2 = or disjoint i32 %add336.2.2, 160
  %arrayidx341.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339.2.2
  %74 = load half, ptr addrspace(3) %arrayidx341.2.2, align 2, !tbaa !158
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %74, i64 2
  %add336.3.2 = or disjoint i32 %mul332, %and338
  %add339.3.2 = or disjoint i32 %add336.3.2, 224
  %arrayidx341.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339.3.2
  %75 = load half, ptr addrspace(3) %arrayidx341.3.2, align 2, !tbaa !158
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %75, i64 3
  %add336.3637 = or disjoint i32 %mul332, %and338
  %add339.3638 = or disjoint i32 %add336.3637, 48
  %arrayidx341.3639 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339.3638
  %76 = load half, ptr addrspace(3) %arrayidx341.3639, align 2, !tbaa !158
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %76, i64 0
  %add336.1.3 = or disjoint i32 %mul332, %and338
  %add339.1.3 = or disjoint i32 %add336.1.3, 112
  %arrayidx341.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339.1.3
  %77 = load half, ptr addrspace(3) %arrayidx341.1.3, align 2, !tbaa !158
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %77, i64 1
  %add336.2.3 = or disjoint i32 %mul332, %and338
  %add339.2.3 = or disjoint i32 %add336.2.3, 176
  %arrayidx341.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339.2.3
  %78 = load half, ptr addrspace(3) %arrayidx341.2.3, align 2, !tbaa !158
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %78, i64 2
  %add336.3.3 = or disjoint i32 %63, %and338
  %add339.3.3 = or i32 %add336.3.3, 240
  %arrayidx341.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339.3.3
  %79 = load half, ptr addrspace(3) %arrayidx341.3.3, align 2, !tbaa !158
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %79, i64 3
  %80 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %81 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %83 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  br label %if.end370

if.end370:                                        ; preds = %for.cond322.preheader, %if.end304
  %acc_o.sroa.0.0 = phi <4 x float> [ %80, %for.cond322.preheader ], [ zeroinitializer, %if.end304 ]
  %acc_o.sroa.16.0 = phi <4 x float> [ %81, %for.cond322.preheader ], [ zeroinitializer, %if.end304 ]
  %acc_o.sroa.30.0 = phi <4 x float> [ %82, %for.cond322.preheader ], [ zeroinitializer, %if.end304 ]
  %acc_o.sroa.44.0 = phi <4 x float> [ %83, %for.cond322.preheader ], [ zeroinitializer, %if.end304 ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract)
  %O_reg.sroa.0.0.insert.ext = zext i16 %84 to i64
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract)
  %O_reg.sroa.0.2.insert.ext = zext i16 %85 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract)
  %O_reg.sroa.0.4.insert.ext = zext i16 %86 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract)
  %O_reg.sroa.0.6.insert.ext = zext i16 %87 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract)
  %O_reg.sroa.7.8.insert.ext = zext i16 %88 to i64
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract)
  %O_reg.sroa.7.10.insert.ext = zext i16 %89 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract)
  %O_reg.sroa.7.12.insert.ext = zext i16 %90 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract)
  %O_reg.sroa.7.14.insert.ext = zext i16 %91 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract)
  %O_reg.sroa.12.16.insert.ext = zext i16 %92 to i64
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1
  %93 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract)
  %O_reg.sroa.12.18.insert.ext = zext i16 %93 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2
  %94 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract)
  %O_reg.sroa.12.20.insert.ext = zext i16 %94 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3
  %95 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract)
  %O_reg.sroa.12.22.insert.ext = zext i16 %95 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0
  %96 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract)
  %O_reg.sroa.17.24.insert.ext = zext i16 %96 to i64
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1
  %97 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract)
  %O_reg.sroa.17.26.insert.ext = zext i16 %97 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract)
  %O_reg.sroa.17.28.insert.ext = zext i16 %98 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3
  %99 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract)
  %O_reg.sroa.17.30.insert.ext = zext i16 %99 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and403 = shl nuw nsw i32 %1, 6
  %mul404 = and i32 %and403, 960
  %shr407 = lshr i32 %1, 5
  %and410 = and i32 %1, 7
  %100 = lshr i32 %1, 2
  %mul417 = and i32 %100, 4
  %xor411 = xor i32 %shr407, %and410
  %mul412 = shl nuw nsw i32 %xor411, 3
  %add413 = add nuw nsw i32 %mul412, %mul404
  %add418 = or disjoint i32 %add413, %mul417
  %add.ptr420 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add418
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr420, align 8
  %add408.1 = add nuw nsw i32 %shr407, 2
  %xor411.1 = xor i32 %add408.1, %and410
  %mul412.1 = shl nuw nsw i32 %xor411.1, 3
  %add413.1 = add nuw nsw i32 %mul412.1, %mul404
  %add418.1 = or disjoint i32 %add413.1, %mul417
  %add.ptr420.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add418.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr420.1, align 8
  %add408.2 = add nuw nsw i32 %shr407, 4
  %xor411.2 = xor i32 %add408.2, %and410
  %mul412.2 = shl nuw nsw i32 %xor411.2, 3
  %add413.2 = add nuw nsw i32 %mul412.2, %mul404
  %add418.2 = or disjoint i32 %add413.2, %mul417
  %add.ptr420.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add418.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr420.2, align 8
  %add408.3 = add nuw nsw i32 %shr407, 6
  %xor411.3 = xor i32 %add408.3, %and410
  %mul412.3 = shl nuw nsw i32 %xor411.3, 3
  %add413.3 = add nuw nsw i32 %mul412.3, %mul404
  %add418.3 = or disjoint i32 %add413.3, %mul417
  %add.ptr420.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add418.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr420.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul431 = and i32 %mul8, 8128
  %xor437547 = and i32 %mul8, 56
  %call435.masked = and i32 %1, 1016
  %mul438 = xor i32 %xor437547, %call435.masked
  %invariant.gep593 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul431
  %invariant.gep595 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep593, i32 %mul438
  %add.ptr450 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %2
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr450, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep595, i64 16, i1 false), !tbaa.struct !187, !call_argsrelate !188
  %gep596.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep595, i32 1024
  %add.ptr450.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr450.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep596.1, i64 16, i1 false), !tbaa.struct !187, !call_argsrelate !188
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


