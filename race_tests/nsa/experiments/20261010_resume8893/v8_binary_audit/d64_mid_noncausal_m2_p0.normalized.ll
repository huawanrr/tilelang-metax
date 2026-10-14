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
  %cmp35 = icmp ult i32 %5, 32
  br i1 %cmp35, label %for.cond38.preheader, label %if.end319

for.cond38.preheader:                             ; preds = %entry
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %mul47 = shl nuw nsw i32 %5, 11
  %6 = shl nuw nsw i32 %2, 4
  %mul51 = and i32 %6, 16256
  %mul54 = shl nsw i32 %1, 6
  %add49 = add nuw nsw i32 %mul51, %mul54
  %mul57 = and i32 %mul11, 56
  %add52 = or disjoint i32 %add49, %mul57
  %add55 = add nuw nsw i32 %add52, %mul47
  %7 = zext nneg i32 %add55 to i64
  %add.ptr62 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %7
  %8 = load i32, ptr addrspace(4) %add.ptr62, align 4, !tbaa !30
  %9 = or disjoint i64 %7, 2
  %add.ptr62.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %9
  %10 = load i32, ptr addrspace(4) %add.ptr62.1, align 4, !tbaa !30
  %11 = or disjoint i64 %7, 4
  %add.ptr62.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %11
  %12 = load i32, ptr addrspace(4) %add.ptr62.2, align 4, !tbaa !30
  %13 = or disjoint i64 %7, 6
  %add.ptr62.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %13
  %14 = load i32, ptr addrspace(4) %add.ptr62.3, align 4, !tbaa !30
  %15 = add nuw nsw i64 %7, 1024
  %add.ptr62.1627 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %15
  %16 = load i32, ptr addrspace(4) %add.ptr62.1627, align 4, !tbaa !30
  %17 = add nuw nsw i64 %7, 1026
  %add.ptr62.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %17
  %18 = load i32, ptr addrspace(4) %add.ptr62.1.1, align 4, !tbaa !30
  %19 = add nuw nsw i64 %7, 1028
  %add.ptr62.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %19
  %20 = load i32, ptr addrspace(4) %add.ptr62.2.1, align 4, !tbaa !30
  %21 = add nuw nsw i64 %7, 1030
  %add.ptr62.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %21
  %22 = load i32, ptr addrspace(4) %add.ptr62.3.1, align 4, !tbaa !30
  %add.ptr100 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %7
  %23 = load i32, ptr addrspace(4) %add.ptr100, align 4, !tbaa !30
  %add.ptr100.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %9
  %24 = load i32, ptr addrspace(4) %add.ptr100.1, align 4, !tbaa !30
  %add.ptr100.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %11
  %25 = load i32, ptr addrspace(4) %add.ptr100.2, align 4, !tbaa !30
  %add.ptr100.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %13
  %26 = load i32, ptr addrspace(4) %add.ptr100.3, align 4, !tbaa !30
  %add.ptr100.1639 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %15
  %27 = load i32, ptr addrspace(4) %add.ptr100.1639, align 4, !tbaa !30
  %add.ptr100.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %17
  %28 = load i32, ptr addrspace(4) %add.ptr100.1.1, align 4, !tbaa !30
  %add.ptr100.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %19
  %29 = load i32, ptr addrspace(4) %add.ptr100.2.1, align 4, !tbaa !30
  %add.ptr100.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %21
  %30 = load i32, ptr addrspace(4) %add.ptr100.3.1, align 4, !tbaa !30
  %mul124 = and i32 %mul11, 8128
  %call128.masked = and i32 %2, 1016
  %mul130 = xor i32 %mul57, %call128.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul124
  %invariant.gep580 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul130
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep580, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !58
  %gep581.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep580, i32 1024
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep581.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !call_argsrelate !58
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and142 = shl nuw nsw i32 %2, 6
  %mul143 = and i32 %and142, 960
  %shr146 = lshr i32 %2, 4
  %and149 = and i32 %2, 7
  %31 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul143
  %xor150 = xor i32 %shr146, %and149
  %add.ptr154.idx = shl nuw nsw i32 %xor150, 4
  %add.ptr154 = getelementptr inbounds i8, ptr addrspace(3) %31, i32 %add.ptr154.idx
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr154, align 16
  %Q_reg.sroa.4.0.add.ptr154.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr154, i32 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr154.sroa_idx, align 8
  %add147.1 = add nuw nsw i32 %shr146, 4
  %xor150.1 = xor i32 %add147.1, %and149
  %add.ptr154.idx.1 = shl nuw nsw i32 %xor150.1, 4
  %add.ptr154.1 = getelementptr inbounds i8, ptr addrspace(3) %31, i32 %add.ptr154.idx.1
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr154.1, align 16
  %Q_reg.sroa.7.16.add.ptr154.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr154.1, i32 8
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr154.1.sroa_idx, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  store i32 %8, ptr addrspace(3) %invariant.gep580, align 16, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep585.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep580, i32 4
  store i32 %10, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep585.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep585.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep580, i32 8
  store i32 %12, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep585.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep585.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep580, i32 12
  store i32 %14, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep585.sroa_idx, align 4, !tbaa !30
  store i32 %16, ptr addrspace(3) %gep581.1, align 16, !tbaa !30
  %K_reg.sroa.9.16.gep586.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep580, i32 1028
  store i32 %18, ptr addrspace(3) %K_reg.sroa.9.16.gep586.1.sroa_idx, align 4, !tbaa !30
  %K_reg.sroa.10.16.gep586.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep580, i32 1032
  store i32 %20, ptr addrspace(3) %K_reg.sroa.10.16.gep586.1.sroa_idx, align 8, !tbaa !30
  %K_reg.sroa.11.16.gep586.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep580, i32 1036
  store i32 %22, ptr addrspace(3) %K_reg.sroa.11.16.gep586.1.sroa_idx, align 4, !tbaa !30
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr154, align 16
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr154.sroa_idx, align 8
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer)
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %32)
  %kb.sroa.0.0.copyload669 = load <4 x half>, ptr addrspace(3) %add.ptr154.1, align 16
  %kb.sroa.6.0.copyload670 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr154.1.sroa_idx, align 8
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload669, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %33)
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload670, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %34)
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %invariant.gep593 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %6
  store i32 %23, ptr addrspace(3) %invariant.gep593, align 16, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep593.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep593, i32 4
  store i32 %24, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep593.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep593.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep593, i32 8
  store i32 %25, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep593.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep593.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep593, i32 12
  store i32 %26, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep593.sroa_idx, align 4, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep593, i32 1024
  store i32 %27, ptr addrspace(3) %gep.1, align 16, !tbaa !30
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep593, i32 1028
  store i32 %28, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep593, i32 1032
  store i32 %29, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep593, i32 1036
  store i32 %30, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !tbaa !30
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %35, i64 0
  %mul256 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %36 = tail call contract noundef float @llvm.minnum.f32(float %mul256, float 0x4024CB5EC0000000)
  %37 = tail call contract noundef float @llvm.exp.f32(float %36)
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %35, i64 1
  %mul256.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %38 = tail call contract noundef float @llvm.minnum.f32(float %mul256.1, float 0x4024CB5EC0000000)
  %39 = tail call contract noundef float @llvm.exp.f32(float %38)
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %35, i64 2
  %mul256.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul256.2, float 0x4024CB5EC0000000)
  %41 = tail call contract noundef float @llvm.exp.f32(float %40)
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %35, i64 3
  %mul256.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %42 = tail call contract noundef float @llvm.minnum.f32(float %mul256.3, float 0x4024CB5EC0000000)
  %43 = tail call contract noundef float @llvm.exp.f32(float %42)
  %add272.1 = fadd contract float %37, %39
  %add272.2 = fadd contract float %add272.1, %41
  %add272.3 = fadd contract float %add272.2, %43
  %44 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add272.3, <4 x float> zeroinitializer)
  %wsum_output.sroa.0.0.vec.extract = extractelement <4 x float> %44, i64 0
  %cmp290 = fcmp contract ogt float %wsum_output.sroa.0.0.vec.extract, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %wsum_output.sroa.0.0.vec.extract
  %condval.0 = select i1 %cmp290, float %div, float 0.000000e+00
  %mul301 = fmul contract float %condval.0, %37
  %mul301.1 = fmul contract float %condval.0, %39
  %mul301.2 = fmul contract float %condval.0, %41
  %mul301.3 = fmul contract float %condval.0, %43
  %45 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul301)
  %46 = insertelement <4 x i16> poison, i16 %45, i64 0
  %47 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul301.1)
  %48 = insertelement <4 x i16> %46, i16 %47, i64 1
  %49 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul301.2)
  %50 = insertelement <4 x i16> %48, i16 %49, i64 2
  %51 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul301.3)
  %52 = insertelement <4 x i16> %50, i16 %51, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %52 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end319

if.end319:                                        ; preds = %for.cond38.preheader, %entry
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ %acc_s_cast.sroa.0.6.vec.insert, %for.cond38.preheader ], [ undef, %entry ]
  br i1 %cmp35, label %for.cond337.preheader, label %if.end385

for.cond337.preheader:                            ; preds = %if.end319
  %53 = shl nuw nsw i32 %2, 4
  %mul347 = and i32 %53, 16128
  %and353 = and i32 %2, 15
  %add354 = or disjoint i32 %mul347, %and353
  %arrayidx356 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add354
  %54 = load half, ptr addrspace(3) %arrayidx356, align 2, !tbaa !128
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %54, i64 0
  %add349.1 = or disjoint i32 %mul347, %and353
  %add354.1 = or disjoint i32 %add349.1, 64
  %arrayidx356.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add354.1
  %55 = load half, ptr addrspace(3) %arrayidx356.1, align 2, !tbaa !128
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %55, i64 1
  %add349.2 = or disjoint i32 %mul347, %and353
  %add354.2 = or disjoint i32 %add349.2, 128
  %arrayidx356.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add354.2
  %56 = load half, ptr addrspace(3) %arrayidx356.2, align 2, !tbaa !128
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %56, i64 2
  %add349.3 = or disjoint i32 %mul347, %and353
  %add354.3 = or disjoint i32 %add349.3, 192
  %arrayidx356.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add354.3
  %57 = load half, ptr addrspace(3) %arrayidx356.3, align 2, !tbaa !128
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %57, i64 3
  %add351.1643 = or disjoint i32 %mul347, %and353
  %add354.1644 = or disjoint i32 %add351.1643, 16
  %arrayidx356.1645 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add354.1644
  %58 = load half, ptr addrspace(3) %arrayidx356.1645, align 2, !tbaa !128
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %58, i64 0
  %add351.1.1 = or disjoint i32 %mul347, %and353
  %add354.1.1 = or disjoint i32 %add351.1.1, 80
  %arrayidx356.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add354.1.1
  %59 = load half, ptr addrspace(3) %arrayidx356.1.1, align 2, !tbaa !128
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %59, i64 1
  %add351.2.1 = or disjoint i32 %mul347, %and353
  %add354.2.1 = or disjoint i32 %add351.2.1, 144
  %arrayidx356.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add354.2.1
  %60 = load half, ptr addrspace(3) %arrayidx356.2.1, align 2, !tbaa !128
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %60, i64 2
  %add351.3.1 = or disjoint i32 %mul347, %and353
  %add354.3.1 = or disjoint i32 %add351.3.1, 208
  %arrayidx356.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add354.3.1
  %61 = load half, ptr addrspace(3) %arrayidx356.3.1, align 2, !tbaa !128
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %61, i64 3
  %add351.2647 = or disjoint i32 %mul347, %and353
  %add354.2648 = or disjoint i32 %add351.2647, 32
  %arrayidx356.2649 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add354.2648
  %62 = load half, ptr addrspace(3) %arrayidx356.2649, align 2, !tbaa !128
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %62, i64 0
  %add351.1.2 = or disjoint i32 %mul347, %and353
  %add354.1.2 = or disjoint i32 %add351.1.2, 96
  %arrayidx356.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add354.1.2
  %63 = load half, ptr addrspace(3) %arrayidx356.1.2, align 2, !tbaa !128
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %63, i64 1
  %add351.2.2 = or disjoint i32 %mul347, %and353
  %add354.2.2 = or disjoint i32 %add351.2.2, 160
  %arrayidx356.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add354.2.2
  %64 = load half, ptr addrspace(3) %arrayidx356.2.2, align 2, !tbaa !128
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %64, i64 2
  %add351.3.2 = or disjoint i32 %mul347, %and353
  %add354.3.2 = or disjoint i32 %add351.3.2, 224
  %arrayidx356.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add354.3.2
  %65 = load half, ptr addrspace(3) %arrayidx356.3.2, align 2, !tbaa !128
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %65, i64 3
  %add351.3651 = or disjoint i32 %mul347, %and353
  %add354.3652 = or disjoint i32 %add351.3651, 48
  %arrayidx356.3653 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add354.3652
  %66 = load half, ptr addrspace(3) %arrayidx356.3653, align 2, !tbaa !128
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %66, i64 0
  %add351.1.3 = or disjoint i32 %mul347, %and353
  %add354.1.3 = or disjoint i32 %add351.1.3, 112
  %arrayidx356.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add354.1.3
  %67 = load half, ptr addrspace(3) %arrayidx356.1.3, align 2, !tbaa !128
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %67, i64 1
  %add351.2.3 = or disjoint i32 %mul347, %and353
  %add354.2.3 = or disjoint i32 %add351.2.3, 176
  %arrayidx356.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add354.2.3
  %68 = load half, ptr addrspace(3) %arrayidx356.2.3, align 2, !tbaa !128
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %68, i64 2
  %add351.3.3 = or disjoint i32 %53, %and353
  %add354.3.3 = or i32 %add351.3.3, 240
  %arrayidx356.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add354.3.3
  %69 = load half, ptr addrspace(3) %arrayidx356.3.3, align 2, !tbaa !128
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %69, i64 3
  %70 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %72 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %73 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  br label %if.end385

if.end385:                                        ; preds = %for.cond337.preheader, %if.end319
  %acc_o.sroa.0.0 = phi <4 x float> [ %70, %for.cond337.preheader ], [ zeroinitializer, %if.end319 ]
  %acc_o.sroa.16.0 = phi <4 x float> [ %71, %for.cond337.preheader ], [ zeroinitializer, %if.end319 ]
  %acc_o.sroa.30.0 = phi <4 x float> [ %72, %for.cond337.preheader ], [ zeroinitializer, %if.end319 ]
  %acc_o.sroa.44.0 = phi <4 x float> [ %73, %for.cond337.preheader ], [ zeroinitializer, %if.end319 ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0
  %74 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract)
  %O_reg.sroa.0.0.insert.ext = zext i16 %74 to i64
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1
  %75 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract)
  %O_reg.sroa.0.2.insert.ext = zext i16 %75 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2
  %76 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract)
  %O_reg.sroa.0.4.insert.ext = zext i16 %76 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3
  %77 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract)
  %O_reg.sroa.0.6.insert.ext = zext i16 %77 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract)
  %O_reg.sroa.7.8.insert.ext = zext i16 %78 to i64
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract)
  %O_reg.sroa.7.10.insert.ext = zext i16 %79 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract)
  %O_reg.sroa.7.12.insert.ext = zext i16 %80 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract)
  %O_reg.sroa.7.14.insert.ext = zext i16 %81 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract)
  %O_reg.sroa.12.16.insert.ext = zext i16 %82 to i64
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract)
  %O_reg.sroa.12.18.insert.ext = zext i16 %83 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract)
  %O_reg.sroa.12.20.insert.ext = zext i16 %84 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract)
  %O_reg.sroa.12.22.insert.ext = zext i16 %85 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract)
  %O_reg.sroa.17.24.insert.ext = zext i16 %86 to i64
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract)
  %O_reg.sroa.17.26.insert.ext = zext i16 %87 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract)
  %O_reg.sroa.17.28.insert.ext = zext i16 %88 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract)
  %O_reg.sroa.17.30.insert.ext = zext i16 %89 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and418 = shl nuw nsw i32 %2, 6
  %mul419 = and i32 %and418, 960
  %shr422 = lshr i32 %2, 5
  %and425 = and i32 %2, 7
  %90 = lshr i32 %2, 2
  %mul432 = and i32 %90, 4
  %xor426 = xor i32 %shr422, %and425
  %mul427 = shl nuw nsw i32 %xor426, 3
  %add428 = add nuw nsw i32 %mul427, %mul419
  %add433 = or disjoint i32 %add428, %mul432
  %add.ptr435 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add433
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr435, align 8
  %add423.1 = add nuw nsw i32 %shr422, 2
  %xor426.1 = xor i32 %add423.1, %and425
  %mul427.1 = shl nuw nsw i32 %xor426.1, 3
  %add428.1 = add nuw nsw i32 %mul427.1, %mul419
  %add433.1 = or disjoint i32 %add428.1, %mul432
  %add.ptr435.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add433.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr435.1, align 8
  %add423.2 = add nuw nsw i32 %shr422, 4
  %xor426.2 = xor i32 %add423.2, %and425
  %mul427.2 = shl nuw nsw i32 %xor426.2, 3
  %add428.2 = add nuw nsw i32 %mul427.2, %mul419
  %add433.2 = or disjoint i32 %add428.2, %mul432
  %add.ptr435.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add433.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr435.2, align 8
  %add423.3 = add nuw nsw i32 %shr422, 6
  %xor426.3 = xor i32 %add423.3, %and425
  %mul427.3 = shl nuw nsw i32 %xor426.3, 3
  %add428.3 = add nuw nsw i32 %mul427.3, %mul419
  %add433.3 = or disjoint i32 %add428.3, %mul432
  %add.ptr435.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add433.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr435.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul446 = and i32 %mul11, 8128
  %xor452566 = and i32 %mul11, 56
  %call450.masked = and i32 %2, 1016
  %mul453 = xor i32 %xor452566, %call450.masked
  %invariant.gep607 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul446
  %invariant.gep609 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep607, i32 %mul453
  %add.ptr468 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr468, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep609, i64 16, i1 false), !tbaa.struct !158, !call_argsrelate !159
  %gep610.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep609, i32 1024
  %add.ptr468.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr468.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep610.1, i64 16, i1 false), !tbaa.struct !158, !call_argsrelate !159
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


