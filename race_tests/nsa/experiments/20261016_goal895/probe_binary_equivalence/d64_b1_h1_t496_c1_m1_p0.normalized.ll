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
  %arrayidx14 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom
  %4 = load i32, ptr addrspace(1) %arrayidx14, align 4, !tbaa !30
  %cmp29 = icmp ugt i32 %4, 30
  %shr = lshr i32 %0, 4
  %cmp32.not = icmp ugt i32 %4, %shr
  %or.cond = or i1 %cmp29, %cmp32.not
  br i1 %or.cond, label %if.end327, label %for.cond35.preheader

for.cond35.preheader:                             ; preds = %entry
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %2
  %mul44 = shl nuw nsw i32 %4, 10
  %add46 = add nuw nsw i32 %mul44, %mul8
  %5 = zext nneg i32 %add46 to i64
  %add.ptr53 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %5
  %6 = load i32, ptr addrspace(4) %add.ptr53, align 4, !tbaa !30
  %7 = or disjoint i64 %5, 2
  %add.ptr53.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %7
  %8 = load i32, ptr addrspace(4) %add.ptr53.1, align 4, !tbaa !30
  %9 = or disjoint i64 %5, 4
  %add.ptr53.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %9
  %10 = load i32, ptr addrspace(4) %add.ptr53.2, align 4, !tbaa !30
  %11 = or disjoint i64 %5, 6
  %add.ptr53.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %11
  %12 = load i32, ptr addrspace(4) %add.ptr53.3, align 4, !tbaa !30
  %13 = add nuw nsw i64 %5, 512
  %add.ptr53.1645 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %13
  %14 = load i32, ptr addrspace(4) %add.ptr53.1645, align 4, !tbaa !30
  %15 = add nuw nsw i64 %5, 514
  %add.ptr53.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %15
  %16 = load i32, ptr addrspace(4) %add.ptr53.1.1, align 4, !tbaa !30
  %17 = add nuw nsw i64 %5, 516
  %add.ptr53.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %17
  %18 = load i32, ptr addrspace(4) %add.ptr53.2.1, align 4, !tbaa !30
  %19 = add nuw nsw i64 %5, 518
  %add.ptr53.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %19
  %20 = load i32, ptr addrspace(4) %add.ptr53.3.1, align 4, !tbaa !30
  %add.ptr83 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %5
  %21 = load i32, ptr addrspace(4) %add.ptr83, align 4, !tbaa !30
  %add.ptr83.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %7
  %22 = load i32, ptr addrspace(4) %add.ptr83.1, align 4, !tbaa !30
  %add.ptr83.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %9
  %23 = load i32, ptr addrspace(4) %add.ptr83.2, align 4, !tbaa !30
  %add.ptr83.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %11
  %24 = load i32, ptr addrspace(4) %add.ptr83.3, align 4, !tbaa !30
  %add.ptr83.1657 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %13
  %25 = load i32, ptr addrspace(4) %add.ptr83.1657, align 4, !tbaa !30
  %add.ptr83.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %15
  %26 = load i32, ptr addrspace(4) %add.ptr83.1.1, align 4, !tbaa !30
  %add.ptr83.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %17
  %27 = load i32, ptr addrspace(4) %add.ptr83.2.1, align 4, !tbaa !30
  %add.ptr83.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %19
  %28 = load i32, ptr addrspace(4) %add.ptr83.3.1, align 4, !tbaa !30
  %mul107 = and i32 %mul8, 8128
  %xor586 = and i32 %mul8, 56
  %call110.masked = and i32 %1, 1016
  %mul112 = xor i32 %xor586, %call110.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul107
  %invariant.gep596 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul112
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep596, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !56
  %gep597.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep596, i32 1024
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep597.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !call_argsrelate !56
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and124 = shl nuw nsw i32 %1, 6
  %mul125 = and i32 %and124, 960
  %shr128 = lshr i32 %1, 4
  %and131 = and i32 %1, 7
  %29 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul125
  %xor132 = xor i32 %shr128, %and131
  %add.ptr136.idx = shl nuw nsw i32 %xor132, 4
  %add.ptr136 = getelementptr inbounds i8, ptr addrspace(3) %29, i32 %add.ptr136.idx
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr136, align 16
  %Q_reg.sroa.4.0.add.ptr136.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr136, i32 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr136.sroa_idx, align 8
  %add129.1 = add nuw nsw i32 %shr128, 4
  %xor132.1 = xor i32 %add129.1, %and131
  %add.ptr136.idx.1 = shl nuw nsw i32 %xor132.1, 4
  %add.ptr136.1 = getelementptr inbounds i8, ptr addrspace(3) %29, i32 %add.ptr136.idx.1
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr136.1, align 16
  %Q_reg.sroa.7.16.add.ptr136.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr136.1, i32 8
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr136.1.sroa_idx, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  store i32 %6, ptr addrspace(3) %invariant.gep596, align 16, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep601.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep596, i32 4
  store i32 %8, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep601.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep601.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep596, i32 8
  store i32 %10, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep601.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep601.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep596, i32 12
  store i32 %12, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep601.sroa_idx, align 4, !tbaa !30
  store i32 %14, ptr addrspace(3) %gep597.1, align 16, !tbaa !30
  %K_reg.sroa.9.16.gep602.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep596, i32 1028
  store i32 %16, ptr addrspace(3) %K_reg.sroa.9.16.gep602.1.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.10.16.gep602.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep596, i32 1032
  store i32 %18, ptr addrspace(3) %K_reg.sroa.10.16.gep602.1.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.11.16.gep602.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep596, i32 1036
  store i32 %20, ptr addrspace(3) %K_reg.sroa.11.16.gep602.1.sroa_idx, align 4, !tbaa !30
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr136, align 16
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr136.sroa_idx, align 8
  %30 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer)
  %31 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %30)
  %kb.sroa.0.0.copyload687 = load <4 x half>, ptr addrspace(3) %add.ptr136.1, align 16
  %kb.sroa.6.0.copyload688 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr136.1.sroa_idx, align 8
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload687, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %31)
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload688, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %32)
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add.ptr228.idx = shl nuw nsw i32 %1, 4
  %invariant.gep609 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr228.idx
  store i32 %21, ptr addrspace(3) %invariant.gep609, align 16, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep609.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep609, i32 4
  store i32 %22, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep609.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep609.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep609, i32 8
  store i32 %23, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep609.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep609.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep609, i32 12
  store i32 %24, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep609.sroa_idx, align 4, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep609, i32 1024
  store i32 %25, ptr addrspace(3) %gep.1, align 16, !tbaa !30
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep609, i32 1028
  store i32 %26, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep609, i32 1032
  store i32 %27, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep609, i32 1036
  store i32 %28, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !tbaa !30
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %33, i64 0
  %mul238 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %34 = tail call contract noundef float @llvm.minnum.f32(float %mul238, float 0x4024CB5EC0000000)
  %35 = tail call contract noundef float @llvm.exp.f32(float %34)
  %acc_s.sroa.0.0.vec.insert694 = insertelement <4 x float> poison, float %35, i64 0
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %33, i64 1
  %mul238.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %36 = tail call contract noundef float @llvm.minnum.f32(float %mul238.1, float 0x4024CB5EC0000000)
  %37 = tail call contract noundef float @llvm.exp.f32(float %36)
  %acc_s.sroa.0.4.vec.insert709 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert694, float %37, i64 1
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %33, i64 2
  %mul238.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %38 = tail call contract noundef float @llvm.minnum.f32(float %mul238.2, float 0x4024CB5EC0000000)
  %39 = tail call contract noundef float @llvm.exp.f32(float %38)
  %acc_s.sroa.0.8.vec.insert724 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert709, float %39, i64 2
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %33, i64 3
  %mul238.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul238.3, float 0x4024CB5EC0000000)
  %41 = tail call contract noundef float @llvm.exp.f32(float %40)
  %acc_s.sroa.0.12.vec.insert739 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert724, float %41, i64 3
  %cmp248 = icmp eq i32 %4, %shr
  br i1 %cmp248, label %for.cond250.preheader, label %if.end269

for.cond250.preheader:                            ; preds = %for.cond35.preheader
  %42 = lshr i32 %1, 2
  %mul256 = and i32 %42, 252
  %and259 = and i32 %0, 15
  %cmp260.not = icmp ugt i32 %mul256, %and259
  %spec.select = select i1 %cmp260.not, float 0.000000e+00, float %35
  %acc_s.sroa.0.0.vec.insert698 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp260.not.1.not = icmp ult i32 %mul256, %and259
  %condval.0.1 = select i1 %cmp260.not.1.not, float %37, float 0.000000e+00
  %acc_s.sroa.0.4.vec.insert713 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert698, float %condval.0.1, i64 1
  %add257.2 = or disjoint i32 %mul256, 2
  %cmp260.not.2 = icmp ugt i32 %add257.2, %and259
  %condval.0.2 = select i1 %cmp260.not.2, float 0.000000e+00, float %39
  %acc_s.sroa.0.8.vec.insert728 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert713, float %condval.0.2, i64 2
  %add257.3 = or i32 %42, 3
  %cmp260.not.3 = icmp ugt i32 %add257.3, %and259
  %condval.0.3 = select i1 %cmp260.not.3, float 0.000000e+00, float %41
  %acc_s.sroa.0.12.vec.insert743 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert728, float %condval.0.3, i64 3
  br label %if.end269

if.end269:                                        ; preds = %for.cond250.preheader, %for.cond35.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert743, %for.cond250.preheader ], [ %acc_s.sroa.0.12.vec.insert739, %for.cond35.preheader ]
  %acc_s.sroa.0.0.vec.extract700 = extractelement <4 x float> %acc_s.sroa.0.0, i64 0
  %add278 = fadd contract float %acc_s.sroa.0.0.vec.extract700, 0.000000e+00
  %acc_s.sroa.0.4.vec.extract715 = extractelement <4 x float> %acc_s.sroa.0.0, i64 1
  %add278.1 = fadd contract float %add278, %acc_s.sroa.0.4.vec.extract715
  %acc_s.sroa.0.8.vec.extract730 = extractelement <4 x float> %acc_s.sroa.0.0, i64 2
  %add278.2 = fadd contract float %add278.1, %acc_s.sroa.0.8.vec.extract730
  %acc_s.sroa.0.12.vec.extract745 = extractelement <4 x float> %acc_s.sroa.0.0, i64 3
  %add278.3 = fadd contract float %add278.2, %acc_s.sroa.0.12.vec.extract745
  %43 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add278.3, <4 x float> zeroinitializer)
  %wsum_output.sroa.0.0.vec.extract = extractelement <4 x float> %43, i64 0
  %cmp296 = fcmp contract ogt float %wsum_output.sroa.0.0.vec.extract, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %wsum_output.sroa.0.0.vec.extract
  %condval_1.0 = select i1 %cmp296, float %div, float 0.000000e+00
  %mul309 = fmul contract float %condval_1.0, %acc_s.sroa.0.0.vec.extract700
  %acc_s.sroa.0.4.vec.extract717 = extractelement <4 x float> %acc_s.sroa.0.0, i64 1
  %mul309.1 = fmul contract float %condval_1.0, %acc_s.sroa.0.4.vec.extract717
  %acc_s.sroa.0.8.vec.extract732 = extractelement <4 x float> %acc_s.sroa.0.0, i64 2
  %mul309.2 = fmul contract float %condval_1.0, %acc_s.sroa.0.8.vec.extract732
  %acc_s.sroa.0.12.vec.extract747 = extractelement <4 x float> %acc_s.sroa.0.0, i64 3
  %mul309.3 = fmul contract float %condval_1.0, %acc_s.sroa.0.12.vec.extract747
  %44 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul309)
  %45 = insertelement <4 x i16> poison, i16 %44, i64 0
  %46 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul309.1)
  %47 = insertelement <4 x i16> %45, i16 %46, i64 1
  %48 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul309.2)
  %49 = insertelement <4 x i16> %47, i16 %48, i64 2
  %50 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul309.3)
  %51 = insertelement <4 x i16> %49, i16 %50, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %51 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end327

if.end327:                                        ; preds = %entry, %if.end269
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ %acc_s_cast.sroa.0.6.vec.insert, %if.end269 ], [ undef, %entry ]
  %cmp343 = icmp ugt i32 %4, 30
  %cmp347.not = icmp ugt i32 %4, %shr
  %or.cond630 = or i1 %cmp343, %cmp347.not
  br i1 %or.cond630, label %if.end397, label %for.cond349.preheader

for.cond349.preheader:                            ; preds = %if.end327
  %52 = shl nuw nsw i32 %1, 4
  %mul359 = and i32 %52, 16128
  %and365 = and i32 %1, 15
  %add366 = or disjoint i32 %mul359, %and365
  %arrayidx368 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366
  %53 = load half, ptr addrspace(3) %arrayidx368, align 2, !tbaa !137
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %53, i64 0
  %add361.1 = or disjoint i32 %mul359, %and365
  %add366.1 = or disjoint i32 %add361.1, 64
  %arrayidx368.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366.1
  %54 = load half, ptr addrspace(3) %arrayidx368.1, align 2, !tbaa !137
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %54, i64 1
  %add361.2 = or disjoint i32 %mul359, %and365
  %add366.2 = or disjoint i32 %add361.2, 128
  %arrayidx368.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366.2
  %55 = load half, ptr addrspace(3) %arrayidx368.2, align 2, !tbaa !137
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %55, i64 2
  %add361.3 = or disjoint i32 %mul359, %and365
  %add366.3 = or disjoint i32 %add361.3, 192
  %arrayidx368.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366.3
  %56 = load half, ptr addrspace(3) %arrayidx368.3, align 2, !tbaa !137
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %56, i64 3
  %add363.1661 = or disjoint i32 %mul359, %and365
  %add366.1662 = or disjoint i32 %add363.1661, 16
  %arrayidx368.1663 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366.1662
  %57 = load half, ptr addrspace(3) %arrayidx368.1663, align 2, !tbaa !137
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %57, i64 0
  %add363.1.1 = or disjoint i32 %mul359, %and365
  %add366.1.1 = or disjoint i32 %add363.1.1, 80
  %arrayidx368.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366.1.1
  %58 = load half, ptr addrspace(3) %arrayidx368.1.1, align 2, !tbaa !137
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %58, i64 1
  %add363.2.1 = or disjoint i32 %mul359, %and365
  %add366.2.1 = or disjoint i32 %add363.2.1, 144
  %arrayidx368.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366.2.1
  %59 = load half, ptr addrspace(3) %arrayidx368.2.1, align 2, !tbaa !137
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %59, i64 2
  %add363.3.1 = or disjoint i32 %mul359, %and365
  %add366.3.1 = or disjoint i32 %add363.3.1, 208
  %arrayidx368.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366.3.1
  %60 = load half, ptr addrspace(3) %arrayidx368.3.1, align 2, !tbaa !137
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %60, i64 3
  %add363.2665 = or disjoint i32 %mul359, %and365
  %add366.2666 = or disjoint i32 %add363.2665, 32
  %arrayidx368.2667 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366.2666
  %61 = load half, ptr addrspace(3) %arrayidx368.2667, align 2, !tbaa !137
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %61, i64 0
  %add363.1.2 = or disjoint i32 %mul359, %and365
  %add366.1.2 = or disjoint i32 %add363.1.2, 96
  %arrayidx368.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366.1.2
  %62 = load half, ptr addrspace(3) %arrayidx368.1.2, align 2, !tbaa !137
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %62, i64 1
  %add363.2.2 = or disjoint i32 %mul359, %and365
  %add366.2.2 = or disjoint i32 %add363.2.2, 160
  %arrayidx368.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366.2.2
  %63 = load half, ptr addrspace(3) %arrayidx368.2.2, align 2, !tbaa !137
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %63, i64 2
  %add363.3.2 = or disjoint i32 %mul359, %and365
  %add366.3.2 = or disjoint i32 %add363.3.2, 224
  %arrayidx368.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366.3.2
  %64 = load half, ptr addrspace(3) %arrayidx368.3.2, align 2, !tbaa !137
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %64, i64 3
  %add363.3669 = or disjoint i32 %mul359, %and365
  %add366.3670 = or disjoint i32 %add363.3669, 48
  %arrayidx368.3671 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366.3670
  %65 = load half, ptr addrspace(3) %arrayidx368.3671, align 2, !tbaa !137
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %65, i64 0
  %add363.1.3 = or disjoint i32 %mul359, %and365
  %add366.1.3 = or disjoint i32 %add363.1.3, 112
  %arrayidx368.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366.1.3
  %66 = load half, ptr addrspace(3) %arrayidx368.1.3, align 2, !tbaa !137
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %66, i64 1
  %add363.2.3 = or disjoint i32 %mul359, %and365
  %add366.2.3 = or disjoint i32 %add363.2.3, 176
  %arrayidx368.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366.2.3
  %67 = load half, ptr addrspace(3) %arrayidx368.2.3, align 2, !tbaa !137
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %67, i64 2
  %add363.3.3 = or disjoint i32 %52, %and365
  %add366.3.3 = or i32 %add363.3.3, 240
  %arrayidx368.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366.3.3
  %68 = load half, ptr addrspace(3) %arrayidx368.3.3, align 2, !tbaa !137
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %68, i64 3
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %70 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %72 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  br label %if.end397

if.end397:                                        ; preds = %for.cond349.preheader, %if.end327
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end327 ], [ %69, %for.cond349.preheader ]
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end327 ], [ %70, %for.cond349.preheader ]
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end327 ], [ %71, %for.cond349.preheader ]
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end327 ], [ %72, %for.cond349.preheader ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0
  %73 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract)
  %O_reg.sroa.0.0.insert.ext = zext i16 %73 to i64
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1
  %74 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract)
  %O_reg.sroa.0.2.insert.ext = zext i16 %74 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2
  %75 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract)
  %O_reg.sroa.0.4.insert.ext = zext i16 %75 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3
  %76 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract)
  %O_reg.sroa.0.6.insert.ext = zext i16 %76 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0
  %77 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract)
  %O_reg.sroa.7.8.insert.ext = zext i16 %77 to i64
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract)
  %O_reg.sroa.7.10.insert.ext = zext i16 %78 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract)
  %O_reg.sroa.7.12.insert.ext = zext i16 %79 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract)
  %O_reg.sroa.7.14.insert.ext = zext i16 %80 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract)
  %O_reg.sroa.12.16.insert.ext = zext i16 %81 to i64
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract)
  %O_reg.sroa.12.18.insert.ext = zext i16 %82 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract)
  %O_reg.sroa.12.20.insert.ext = zext i16 %83 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract)
  %O_reg.sroa.12.22.insert.ext = zext i16 %84 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract)
  %O_reg.sroa.17.24.insert.ext = zext i16 %85 to i64
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract)
  %O_reg.sroa.17.26.insert.ext = zext i16 %86 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract)
  %O_reg.sroa.17.28.insert.ext = zext i16 %87 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract)
  %O_reg.sroa.17.30.insert.ext = zext i16 %88 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and430 = shl nuw nsw i32 %1, 6
  %mul431 = and i32 %and430, 960
  %shr434 = lshr i32 %1, 5
  %and437 = and i32 %1, 7
  %89 = lshr i32 %1, 2
  %mul444 = and i32 %89, 4
  %xor438 = xor i32 %shr434, %and437
  %mul439 = shl nuw nsw i32 %xor438, 3
  %add440 = add nuw nsw i32 %mul439, %mul431
  %add445 = or disjoint i32 %add440, %mul444
  %add.ptr447 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add445
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr447, align 8
  %add435.1 = add nuw nsw i32 %shr434, 2
  %xor438.1 = xor i32 %add435.1, %and437
  %mul439.1 = shl nuw nsw i32 %xor438.1, 3
  %add440.1 = add nuw nsw i32 %mul439.1, %mul431
  %add445.1 = or disjoint i32 %add440.1, %mul444
  %add.ptr447.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add445.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr447.1, align 8
  %add435.2 = add nuw nsw i32 %shr434, 4
  %xor438.2 = xor i32 %add435.2, %and437
  %mul439.2 = shl nuw nsw i32 %xor438.2, 3
  %add440.2 = add nuw nsw i32 %mul439.2, %mul431
  %add445.2 = or disjoint i32 %add440.2, %mul444
  %add.ptr447.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add445.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr447.2, align 8
  %add435.3 = add nuw nsw i32 %shr434, 6
  %xor438.3 = xor i32 %add435.3, %and437
  %mul439.3 = shl nuw nsw i32 %xor438.3, 3
  %add440.3 = add nuw nsw i32 %mul439.3, %mul431
  %add445.3 = or disjoint i32 %add440.3, %mul444
  %add.ptr447.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add445.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr447.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul458 = and i32 %mul8, 8128
  %xor464582 = and i32 %mul8, 56
  %call462.masked = and i32 %1, 1016
  %mul465 = xor i32 %xor464582, %call462.masked
  %invariant.gep624 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul458
  %invariant.gep626 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep624, i32 %mul465
  %add.ptr477 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %2
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr477, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep626, i64 16, i1 false), !tbaa.struct !166, !call_argsrelate !167
  %gep627.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep626, i32 1024
  %add.ptr477.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr477.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep627.1, i64 16, i1 false), !tbaa.struct !166, !call_argsrelate !167
  ret void
}

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

declare <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float, float, <4 x float>) #4

declare i32 @llvm.mxc.block.id.x() #5

declare i32 @llvm.mxc.block.id.y() #5

declare i32 @llvm.mxc.block.id.z() #5

declare i32 @llvm.mxc.thread.id.x() #5

declare void @llvm.mxc.barrier.warp() #6

declare float @llvm.exp.f32(float) #7

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


