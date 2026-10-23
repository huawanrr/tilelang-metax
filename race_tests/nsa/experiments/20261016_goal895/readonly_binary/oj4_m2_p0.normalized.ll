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
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul = shl nsw i32 %0, 19
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul7 = shl nsw i32 %1, 10
  %add = add nuw nsw i32 %mul, %mul7
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %mul11 = shl nuw nsw i32 %2, 3
  %add9 = add nuw nsw i32 %add, %mul11
  %3 = zext nneg i32 %add9 to i64
  %4 = add nuw nsw i64 %3, 512
  %mul17 = shl nsw i32 %0, 9
  %add19 = add nuw nsw i32 %mul17, %1
  %idxprom = zext nneg i32 %add19 to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom
  %5 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cmp34 = icmp ugt i32 %5, 31
  %shr = lshr i32 %1, 4
  %cmp37.not = icmp ugt i32 %5, %shr
  %or.cond663 = or i1 %cmp34, %cmp37.not
  br i1 %or.cond663, label %if.end350, label %if.then

if.then:                                          ; preds = %entry
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3
  %mul55 = shl nsw i32 %0, 15
  %mul56 = shl nuw nsw i32 %5, 10
  %add57 = or disjoint i32 %mul11, %mul55
  %add59 = add nuw nsw i32 %add57, %mul56
  %6 = zext nneg i32 %add59 to i64
  %arrayidx67 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %6
  %7 = or disjoint i64 %6, 2
  %arrayidx67.1678 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %7
  %8 = or disjoint i64 %6, 4
  %arrayidx67.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %8
  %9 = or disjoint i64 %6, 6
  %arrayidx67.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %9
  %10 = add nuw nsw i64 %6, 512
  %arrayidx67.1685 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %10
  %11 = add nuw nsw i64 %6, 514
  %arrayidx67.1678.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %11
  %12 = add nuw nsw i64 %6, 516
  %arrayidx67.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %12
  %13 = add nuw nsw i64 %6, 518
  %arrayidx67.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %13
  %arrayidx110 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %6
  %arrayidx110.1699 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %7
  %arrayidx110.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %8
  %arrayidx110.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %9
  %arrayidx110.1706 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %10
  %arrayidx110.1699.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %11
  %arrayidx110.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %12
  %arrayidx110.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %13
  %mul139 = and i32 %mul11, 8128
  %xor614 = and i32 %mul11, 56
  %call142.masked = and i32 %2, 1016
  %mul144 = xor i32 %xor614, %call142.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul139
  %invariant.gep631 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul144
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep631, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !call_argsrelate !55
  %gep632.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep631, i32 1024
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep632.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !call_argsrelate !55
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and156 = shl nuw nsw i32 %2, 6
  %mul157 = and i32 %and156, 960
  %shr160 = lshr i32 %2, 4
  %and163 = and i32 %2, 7
  %14 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul157
  %xor164 = xor i32 %shr160, %and163
  %add.ptr168.idx = shl nuw nsw i32 %xor164, 4
  %add.ptr168 = getelementptr inbounds i8, ptr addrspace(3) %14, i32 %add.ptr168.idx
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr168, align 16
  %Q_reg.sroa.4.0.add.ptr168.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr168, i32 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr168.sroa_idx, align 8
  %add161.1 = add nuw nsw i32 %shr160, 4
  %xor164.1 = xor i32 %add161.1, %and163
  %add.ptr168.idx.1 = shl nuw nsw i32 %xor164.1, 4
  %add.ptr168.1 = getelementptr inbounds i8, ptr addrspace(3) %14, i32 %add.ptr168.idx.1
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr168.1, align 16
  %Q_reg.sroa.7.16.add.ptr168.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr168.1, i32 8
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr168.1.sroa_idx, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %15 = load <2 x i16>, ptr addrspace(4) %arrayidx67, align 2, !tbaa !75
  store <2 x i16> %15, ptr addrspace(3) %invariant.gep631, align 16
  %K_reg.sroa.5.0.invariant.gep636.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep631, i32 4
  %16 = load <2 x i16>, ptr addrspace(4) %arrayidx67.1678, align 2, !tbaa !75
  store <2 x i16> %16, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep636.sroa_idx, align 4
  %K_reg.sroa.7.0.invariant.gep636.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep631, i32 8
  %17 = load <2 x i16>, ptr addrspace(4) %arrayidx67.2, align 2, !tbaa !75
  store <2 x i16> %17, ptr addrspace(3) %K_reg.sroa.7.0.invariant.gep636.sroa_idx, align 8
  %K_reg.sroa.9.0.invariant.gep636.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep631, i32 12
  %18 = load <2 x i16>, ptr addrspace(4) %arrayidx67.3, align 2, !tbaa !75
  store <2 x i16> %18, ptr addrspace(3) %K_reg.sroa.9.0.invariant.gep636.sroa_idx, align 4
  %19 = load <2 x i16>, ptr addrspace(4) %arrayidx67.1685, align 2, !tbaa !75
  store <2 x i16> %19, ptr addrspace(3) %gep632.1, align 16
  %K_reg.sroa.14.16.gep637.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep631, i32 1028
  %20 = load <2 x i16>, ptr addrspace(4) %arrayidx67.1678.1, align 2, !tbaa !75
  store <2 x i16> %20, ptr addrspace(3) %K_reg.sroa.14.16.gep637.1.sroa_idx, align 4
  %K_reg.sroa.16.16.gep637.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep631, i32 1032
  %21 = load <2 x i16>, ptr addrspace(4) %arrayidx67.2.1, align 2, !tbaa !75
  store <2 x i16> %21, ptr addrspace(3) %K_reg.sroa.16.16.gep637.1.sroa_idx, align 8
  %K_reg.sroa.18.16.gep637.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep631, i32 1036
  %22 = load <2 x i16>, ptr addrspace(4) %arrayidx67.3.1, align 2, !tbaa !75
  store <2 x i16> %22, ptr addrspace(3) %K_reg.sroa.18.16.gep637.1.sroa_idx, align 4
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr168, align 16
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr168.sroa_idx, align 8
  %23 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer)
  %24 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %23)
  %kb.sroa.0.0.copyload741 = load <4 x half>, ptr addrspace(3) %add.ptr168.1, align 16
  %kb.sroa.6.0.copyload742 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr168.1.sroa_idx, align 8
  %25 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload741, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %24)
  %26 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload742, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %25)
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %add.ptr260.idx = shl nuw nsw i32 %2, 4
  %invariant.gep644 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr260.idx
  %27 = load <2 x i16>, ptr addrspace(4) %arrayidx110, align 2, !tbaa !75
  store <2 x i16> %27, ptr addrspace(3) %invariant.gep644, align 16
  %V_reg.sroa.5.0.invariant.gep644.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep644, i32 4
  %28 = load <2 x i16>, ptr addrspace(4) %arrayidx110.1699, align 2, !tbaa !75
  store <2 x i16> %28, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep644.sroa_idx, align 4
  %V_reg.sroa.7.0.invariant.gep644.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep644, i32 8
  %29 = load <2 x i16>, ptr addrspace(4) %arrayidx110.2, align 2, !tbaa !75
  store <2 x i16> %29, ptr addrspace(3) %V_reg.sroa.7.0.invariant.gep644.sroa_idx, align 8
  %V_reg.sroa.9.0.invariant.gep644.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep644, i32 12
  %30 = load <2 x i16>, ptr addrspace(4) %arrayidx110.3, align 2, !tbaa !75
  store <2 x i16> %30, ptr addrspace(3) %V_reg.sroa.9.0.invariant.gep644.sroa_idx, align 4
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep644, i32 1024
  %31 = load <2 x i16>, ptr addrspace(4) %arrayidx110.1706, align 2, !tbaa !75
  store <2 x i16> %31, ptr addrspace(3) %gep.1, align 16
  %V_reg.sroa.14.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep644, i32 1028
  %32 = load <2 x i16>, ptr addrspace(4) %arrayidx110.1699.1, align 2, !tbaa !75
  store <2 x i16> %32, ptr addrspace(3) %V_reg.sroa.14.16.gep.1.sroa_idx, align 4
  %V_reg.sroa.16.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep644, i32 1032
  %33 = load <2 x i16>, ptr addrspace(4) %arrayidx110.2.1, align 2, !tbaa !75
  store <2 x i16> %33, ptr addrspace(3) %V_reg.sroa.16.16.gep.1.sroa_idx, align 8
  %V_reg.sroa.18.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep644, i32 1036
  %34 = load <2 x i16>, ptr addrspace(4) %arrayidx110.3.1, align 2, !tbaa !75
  store <2 x i16> %34, ptr addrspace(3) %V_reg.sroa.18.16.gep.1.sroa_idx, align 4
  %mul38 = shl nuw nsw i32 %5, 4
  %shr272 = shl nuw nsw i32 %5, 2
  %add273 = add nuw nsw i32 %shr272, %shr160
  %cmp274 = icmp ugt i32 %add273, 127
  %35 = lshr i32 %2, 2
  %mul278 = and i32 %35, 252
  %add280 = add nuw nsw i32 %mul38, %mul278
  %cmp283.not = icmp ugt i32 %add280, %1
  %or.cond664 = select i1 %cmp274, i1 true, i1 %cmp283.not
  br i1 %or.cond664, label %if.end, label %if.then284

if.then284:                                       ; preds = %if.then
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %26, i64 0
  %mul287 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %36 = tail call contract noundef float @llvm.minnum.f32(float %mul287, float 0x4024CB5EC0000000)
  %37 = tail call contract noundef float @llvm.exp.f32(float %36)
  br label %if.end

if.end:                                           ; preds = %if.then, %if.then284
  %condval.0 = phi float [ %37, %if.then284 ], [ 0.000000e+00, %if.then ]
  %cmp283.not.1 = icmp uge i32 %add280, %1
  %or.cond664.1 = select i1 %cmp274, i1 true, i1 %cmp283.not.1
  br i1 %or.cond664.1, label %if.end.1, label %if.then284.1

if.then284.1:                                     ; preds = %if.end
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %26, i64 1
  %mul287.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %38 = tail call contract noundef float @llvm.minnum.f32(float %mul287.1, float 0x4024CB5EC0000000)
  %39 = tail call contract noundef float @llvm.exp.f32(float %38)
  br label %if.end.1

if.end.1:                                         ; preds = %if.then284.1, %if.end
  %condval.0.1 = phi float [ %39, %if.then284.1 ], [ 0.000000e+00, %if.end ]
  %add281.2 = or disjoint i32 %add280, 2
  %cmp283.not.2 = icmp ugt i32 %add281.2, %1
  %or.cond664.2 = select i1 %cmp274, i1 true, i1 %cmp283.not.2
  br i1 %or.cond664.2, label %if.end.2, label %if.then284.2

if.then284.2:                                     ; preds = %if.end.1
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %26, i64 2
  %mul287.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul287.2, float 0x4024CB5EC0000000)
  %41 = tail call contract noundef float @llvm.exp.f32(float %40)
  br label %if.end.2

if.end.2:                                         ; preds = %if.then284.2, %if.end.1
  %condval.0.2 = phi float [ %41, %if.then284.2 ], [ 0.000000e+00, %if.end.1 ]
  %add281.3 = or disjoint i32 %add280, 3
  %cmp283.not.3 = icmp ugt i32 %add281.3, %1
  %or.cond664.3 = select i1 %cmp274, i1 true, i1 %cmp283.not.3
  br i1 %or.cond664.3, label %if.end.3, label %if.then284.3

if.then284.3:                                     ; preds = %if.end.2
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %26, i64 3
  %mul287.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %42 = tail call contract noundef float @llvm.minnum.f32(float %mul287.3, float 0x4024CB5EC0000000)
  %43 = tail call contract noundef float @llvm.exp.f32(float %42)
  br label %if.end.3

if.end.3:                                         ; preds = %if.then284.3, %if.end.2
  %condval.0.3 = phi float [ %43, %if.then284.3 ], [ 0.000000e+00, %if.end.2 ]
  %add303.1 = fadd contract float %condval.0, %condval.0.1
  %add303.2 = fadd contract float %add303.1, %condval.0.2
  %add303.3 = fadd contract float %add303.2, %condval.0.3
  %44 = bitcast float %add303.3 to i32
  %45 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %46 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %45) #11
  %xor.i.i = xor i32 %46, 32
  %47 = and i32 %46, -64
  %and.i.i = add nsw i32 %47, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %46
  %shl.i.i = shl i32 %cond.i.i, 2
  %48 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %44)
  %49 = bitcast i32 %48 to float
  %add311 = fadd contract float %add303.3, %49
  %50 = bitcast float %add311 to i32
  %51 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11
  %52 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %51) #11
  %xor.i.i616 = xor i32 %52, 16
  %53 = and i32 %52, -64
  %and.i.i617 = add nsw i32 %53, 64
  %cmp.not.i.i618 = icmp slt i32 %xor.i.i616, %and.i.i617
  %cond.i.i619 = select i1 %cmp.not.i.i618, i32 %xor.i.i616, i32 %52
  %shl.i.i620 = shl i32 %cond.i.i619, 2
  %54 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i620, i32 %50)
  %55 = bitcast i32 %54 to float
  %add316 = fadd contract float %add311, %55
  %cmp319 = fcmp contract ogt float %add316, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add316
  %condval_1.0 = select i1 %cmp319, float %div, float 0.000000e+00
  %mul332 = fmul contract float %condval_1.0, %condval.0
  %mul332.1 = fmul contract float %condval_1.0, %condval.0.1
  %mul332.2 = fmul contract float %condval_1.0, %condval.0.2
  %mul332.3 = fmul contract float %condval_1.0, %condval.0.3
  %56 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul332)
  %57 = insertelement <4 x i16> poison, i16 %56, i64 0
  %58 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul332.1)
  %59 = insertelement <4 x i16> %57, i16 %58, i64 1
  %60 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul332.2)
  %61 = insertelement <4 x i16> %59, i16 %60, i64 2
  %62 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul332.3)
  %63 = insertelement <4 x i16> %61, i16 %62, i64 3
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %63 to <4 x half>
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  br label %if.end350

if.end350:                                        ; preds = %if.end.3, %entry
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ undef, %entry ], [ %acc_s_cast.sroa.0.6.vec.insert, %if.end.3 ]
  br i1 %or.cond663, label %if.end420, label %for.cond372.preheader

for.cond372.preheader:                            ; preds = %if.end350
  %64 = shl nuw nsw i32 %2, 4
  %mul382 = and i32 %64, 16128
  %and388 = and i32 %2, 15
  %add389 = or disjoint i32 %mul382, %and388
  %arrayidx391 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389
  %65 = load half, ptr addrspace(3) %arrayidx391, align 2, !tbaa !75
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %65, i64 0
  %add384.1 = or disjoint i32 %mul382, %and388
  %add389.1 = or disjoint i32 %add384.1, 64
  %arrayidx391.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389.1
  %66 = load half, ptr addrspace(3) %arrayidx391.1, align 2, !tbaa !75
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %66, i64 1
  %add384.2 = or disjoint i32 %mul382, %and388
  %add389.2 = or disjoint i32 %add384.2, 128
  %arrayidx391.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389.2
  %67 = load half, ptr addrspace(3) %arrayidx391.2, align 2, !tbaa !75
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %67, i64 2
  %add384.3 = or disjoint i32 %mul382, %and388
  %add389.3 = or disjoint i32 %add384.3, 192
  %arrayidx391.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389.3
  %68 = load half, ptr addrspace(3) %arrayidx391.3, align 2, !tbaa !75
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %68, i64 3
  %add386.1715 = or disjoint i32 %mul382, %and388
  %add389.1716 = or disjoint i32 %add386.1715, 16
  %arrayidx391.1717 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389.1716
  %69 = load half, ptr addrspace(3) %arrayidx391.1717, align 2, !tbaa !75
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %69, i64 0
  %add386.1.1 = or disjoint i32 %mul382, %and388
  %add389.1.1 = or disjoint i32 %add386.1.1, 80
  %arrayidx391.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389.1.1
  %70 = load half, ptr addrspace(3) %arrayidx391.1.1, align 2, !tbaa !75
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %70, i64 1
  %add386.2.1 = or disjoint i32 %mul382, %and388
  %add389.2.1 = or disjoint i32 %add386.2.1, 144
  %arrayidx391.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389.2.1
  %71 = load half, ptr addrspace(3) %arrayidx391.2.1, align 2, !tbaa !75
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %71, i64 2
  %add386.3.1 = or disjoint i32 %mul382, %and388
  %add389.3.1 = or disjoint i32 %add386.3.1, 208
  %arrayidx391.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389.3.1
  %72 = load half, ptr addrspace(3) %arrayidx391.3.1, align 2, !tbaa !75
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %72, i64 3
  %add386.2719 = or disjoint i32 %mul382, %and388
  %add389.2720 = or disjoint i32 %add386.2719, 32
  %arrayidx391.2721 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389.2720
  %73 = load half, ptr addrspace(3) %arrayidx391.2721, align 2, !tbaa !75
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %73, i64 0
  %add386.1.2 = or disjoint i32 %mul382, %and388
  %add389.1.2 = or disjoint i32 %add386.1.2, 96
  %arrayidx391.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389.1.2
  %74 = load half, ptr addrspace(3) %arrayidx391.1.2, align 2, !tbaa !75
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %74, i64 1
  %add386.2.2 = or disjoint i32 %mul382, %and388
  %add389.2.2 = or disjoint i32 %add386.2.2, 160
  %arrayidx391.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389.2.2
  %75 = load half, ptr addrspace(3) %arrayidx391.2.2, align 2, !tbaa !75
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %75, i64 2
  %add386.3.2 = or disjoint i32 %mul382, %and388
  %add389.3.2 = or disjoint i32 %add386.3.2, 224
  %arrayidx391.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389.3.2
  %76 = load half, ptr addrspace(3) %arrayidx391.3.2, align 2, !tbaa !75
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %76, i64 3
  %add386.3723 = or disjoint i32 %mul382, %and388
  %add389.3724 = or disjoint i32 %add386.3723, 48
  %arrayidx391.3725 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389.3724
  %77 = load half, ptr addrspace(3) %arrayidx391.3725, align 2, !tbaa !75
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %77, i64 0
  %add386.1.3 = or disjoint i32 %mul382, %and388
  %add389.1.3 = or disjoint i32 %add386.1.3, 112
  %arrayidx391.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389.1.3
  %78 = load half, ptr addrspace(3) %arrayidx391.1.3, align 2, !tbaa !75
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %78, i64 1
  %add386.2.3 = or disjoint i32 %mul382, %and388
  %add389.2.3 = or disjoint i32 %add386.2.3, 176
  %arrayidx391.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389.2.3
  %79 = load half, ptr addrspace(3) %arrayidx391.2.3, align 2, !tbaa !75
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %79, i64 2
  %add386.3.3 = or disjoint i32 %64, %and388
  %add389.3.3 = or i32 %add386.3.3, 240
  %arrayidx391.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389.3.3
  %80 = load half, ptr addrspace(3) %arrayidx391.3.3, align 2, !tbaa !75
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %80, i64 3
  %81 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %83 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  %84 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer)
  br label %if.end420

if.end420:                                        ; preds = %for.cond372.preheader, %if.end350
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end350 ], [ %81, %for.cond372.preheader ]
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end350 ], [ %82, %for.cond372.preheader ]
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end350 ], [ %83, %for.cond372.preheader ]
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end350 ], [ %84, %for.cond372.preheader ]
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract)
  %O_reg.sroa.0.0.insert.ext = zext i16 %85 to i64
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract)
  %O_reg.sroa.0.2.insert.ext = zext i16 %86 to i64
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract)
  %O_reg.sroa.0.4.insert.ext = zext i16 %87 to i64
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract)
  %O_reg.sroa.0.6.insert.ext = zext i16 %88 to i64
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract)
  %O_reg.sroa.7.8.insert.ext = zext i16 %89 to i64
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract)
  %O_reg.sroa.7.10.insert.ext = zext i16 %90 to i64
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract)
  %O_reg.sroa.7.12.insert.ext = zext i16 %91 to i64
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract)
  %O_reg.sroa.7.14.insert.ext = zext i16 %92 to i64
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0
  %93 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract)
  %O_reg.sroa.12.16.insert.ext = zext i16 %93 to i64
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1
  %94 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract)
  %O_reg.sroa.12.18.insert.ext = zext i16 %94 to i64
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2
  %95 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract)
  %O_reg.sroa.12.20.insert.ext = zext i16 %95 to i64
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3
  %96 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract)
  %O_reg.sroa.12.22.insert.ext = zext i16 %96 to i64
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0
  %97 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract)
  %O_reg.sroa.17.24.insert.ext = zext i16 %97 to i64
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract)
  %O_reg.sroa.17.26.insert.ext = zext i16 %98 to i64
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2
  %99 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract)
  %O_reg.sroa.17.28.insert.ext = zext i16 %99 to i64
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3
  %100 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract)
  %O_reg.sroa.17.30.insert.ext = zext i16 %100 to i64
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %and453 = shl nuw nsw i32 %2, 6
  %mul454 = and i32 %and453, 960
  %shr457 = lshr i32 %2, 5
  %and460 = and i32 %2, 7
  %101 = lshr i32 %2, 2
  %mul467 = and i32 %101, 4
  %xor461 = xor i32 %shr457, %and460
  %mul462 = shl nuw nsw i32 %xor461, 3
  %add463 = add nuw nsw i32 %mul462, %mul454
  %add468 = or disjoint i32 %add463, %mul467
  %add.ptr470 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add468
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr470, align 8
  %add458.1 = add nuw nsw i32 %shr457, 2
  %xor461.1 = xor i32 %add458.1, %and460
  %mul462.1 = shl nuw nsw i32 %xor461.1, 3
  %add463.1 = add nuw nsw i32 %mul462.1, %mul454
  %add468.1 = or disjoint i32 %add463.1, %mul467
  %add.ptr470.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add468.1
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr470.1, align 8
  %add458.2 = add nuw nsw i32 %shr457, 4
  %xor461.2 = xor i32 %add458.2, %and460
  %mul462.2 = shl nuw nsw i32 %xor461.2, 3
  %add463.2 = add nuw nsw i32 %mul462.2, %mul454
  %add468.2 = or disjoint i32 %add463.2, %mul467
  %add.ptr470.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add468.2
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr470.2, align 8
  %add458.3 = add nuw nsw i32 %shr457, 6
  %xor461.3 = xor i32 %add458.3, %and460
  %mul462.3 = shl nuw nsw i32 %xor461.3, 3
  %add463.3 = add nuw nsw i32 %mul462.3, %mul454
  %add468.3 = or disjoint i32 %add463.3, %mul467
  %add.ptr470.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add468.3
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr470.3, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul481 = and i32 %mul11, 8128
  %xor487610 = and i32 %mul11, 56
  %call485.masked = and i32 %2, 1016
  %mul488 = xor i32 %xor487610, %call485.masked
  %invariant.gep658 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul481
  %invariant.gep660 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep658, i32 %mul488
  %add.ptr503 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr503, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep660, i64 16, i1 false), !tbaa.struct !189, !call_argsrelate !190
  %gep661.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep660, i32 1024
  %add.ptr503.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr503.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep661.1, i64 16, i1 false), !tbaa.struct !189, !call_argsrelate !190
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


