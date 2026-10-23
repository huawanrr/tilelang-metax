target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "mxc-metax-macahca"

%struct.mcDevMallocInfo.0 = type { i32, i32, ptr }
%struct.__half = type { i16 }

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
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul = shl nsw i32 %0, 9
  %1 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !50
  %and = shl nuw nsw i32 %1, 5
  %mul7 = and i32 %and, 480
  %add = or disjoint i32 %mul7, %mul
  %2 = lshr i32 %1, 1
  %mul9 = and i32 %2, 504
  %add10 = add nuw nsw i32 %add, %mul9
  %idx.ext = zext nneg i32 %add10 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %idx.ext
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16
  %q.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %q.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %q.sroa.4.0.add.ptr.sroa_idx, align 8
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %idxprom = zext nneg i32 %0 to i64
  %arrayidx13 = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %idxprom
  %3 = load i32, ptr addrspace(1) %arrayidx13, align 4, !tbaa !30
  %cmp20 = icmp ugt i32 %3, 3
  %shr23 = lshr i32 %0, 4
  %cmp24.not = icmp ugt i32 %3, %shr23
  %or.cond327 = or i1 %cmp20, %cmp24.not
  br i1 %or.cond327, label %entry.if.end207_crit_edge, label %for.cond25.preheader

entry.if.end207_crit_edge:                        ; preds = %entry
  %.pre = lshr i32 %1, 2
  %.pre412 = and i32 %.pre, 252
  br label %if.end207

for.cond25.preheader:                             ; preds = %entry
  %mul31 = shl nuw nsw i32 %3, 9
  %4 = shl nuw nsw i32 %1, 3
  %mul34 = and i32 %4, 8064
  %add35 = add nuw nsw i32 %mul31, %mul34
  %and43 = and i32 %1, 15
  %add44 = or disjoint i32 %add35, %and43
  %idxprom45 = zext nneg i32 %add44 to i64
  %arrayidx46 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom45
  %arrayidx46.val413 = load half, ptr addrspace(4) %arrayidx46, align 2, !tbaa !70
  %v.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %arrayidx46.val413, i64 0
  %add38.1 = or disjoint i32 %add35, %and43
  %add44.1 = or disjoint i32 %add38.1, 32
  %idxprom45.1 = zext nneg i32 %add44.1 to i64
  %arrayidx46.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom45.1
  %arrayidx46.val.1414 = load half, ptr addrspace(4) %arrayidx46.1, align 2, !tbaa !70
  %v.sroa.0.2.vec.insert = insertelement <4 x half> %v.sroa.0.0.vec.insert, half %arrayidx46.val.1414, i64 1
  %add38.2 = or disjoint i32 %add35, %and43
  %add44.2 = or disjoint i32 %add38.2, 64
  %idxprom45.2 = zext nneg i32 %add44.2 to i64
  %arrayidx46.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom45.2
  %arrayidx46.val.2415 = load half, ptr addrspace(4) %arrayidx46.2, align 2, !tbaa !70
  %v.sroa.0.4.vec.insert = insertelement <4 x half> %v.sroa.0.2.vec.insert, half %arrayidx46.val.2415, i64 2
  %add38.3 = or disjoint i32 %add35, %and43
  %add44.3 = or disjoint i32 %add38.3, 96
  %idxprom45.3 = zext nneg i32 %add44.3 to i64
  %arrayidx46.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom45.3
  %arrayidx46.val.3416 = load half, ptr addrspace(4) %arrayidx46.3, align 2, !tbaa !70
  %v.sroa.0.6.vec.insert = insertelement <4 x half> %v.sroa.0.4.vec.insert, half %arrayidx46.val.3416, i64 3
  %add41.4 = or disjoint i32 %add35, %and43
  %add44.4 = or disjoint i32 %add41.4, 16
  %idxprom45.4 = zext nneg i32 %add44.4 to i64
  %arrayidx46.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom45.4
  %arrayidx46.val.4417 = load half, ptr addrspace(4) %arrayidx46.4, align 2, !tbaa !70
  %v.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %arrayidx46.val.4417, i64 0
  %add41.5 = or disjoint i32 %add35, %and43
  %add44.5 = or disjoint i32 %add41.5, 48
  %idxprom45.5 = zext nneg i32 %add44.5 to i64
  %arrayidx46.5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom45.5
  %arrayidx46.val.5418 = load half, ptr addrspace(4) %arrayidx46.5, align 2, !tbaa !70
  %v.sroa.7.10.vec.insert = insertelement <4 x half> %v.sroa.7.8.vec.insert, half %arrayidx46.val.5418, i64 1
  %add41.6 = or disjoint i32 %add35, %and43
  %add44.6 = or disjoint i32 %add41.6, 80
  %idxprom45.6 = zext nneg i32 %add44.6 to i64
  %arrayidx46.6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom45.6
  %arrayidx46.val.6419 = load half, ptr addrspace(4) %arrayidx46.6, align 2, !tbaa !70
  %v.sroa.7.12.vec.insert = insertelement <4 x half> %v.sroa.7.10.vec.insert, half %arrayidx46.val.6419, i64 2
  %add41.7 = or disjoint i32 %add35, %and43
  %add44.7 = or disjoint i32 %add41.7, 112
  %idxprom45.7 = zext nneg i32 %add44.7 to i64
  %arrayidx46.7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom45.7
  %arrayidx46.val.7420 = load half, ptr addrspace(4) %arrayidx46.7, align 2, !tbaa !70
  %v.sroa.7.14.vec.insert = insertelement <4 x half> %v.sroa.7.12.vec.insert, half %arrayidx46.val.7420, i64 3
  %add63 = add nuw nsw i32 %mul9, %mul7
  %add67 = add nuw nsw i32 %add63, %mul31
  %5 = zext nneg i32 %add67 to i64
  %arrayidx70 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %5
  %6 = load <4 x half>, ptr addrspace(4) %arrayidx70, align 2, !tbaa !70
  %7 = or disjoint i64 %5, 4
  %arrayidx70.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %7
  %8 = load <4 x half>, ptr addrspace(4) %arrayidx70.4, align 2, !tbaa !70
  %9 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %6, <4 x half> %q.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !77
  %10 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %8, <4 x half> %q.sroa.4.0.copyload, <4 x float> %9), !call_argsrelate !77
  %mul105 = shl nuw nsw i32 %3, 4
  %11 = lshr i32 %1, 2
  %mul108 = and i32 %11, 252
  %add109 = add nuw nsw i32 %mul105, %mul108
  %cmp112.not = icmp ugt i32 %add109, %0
  %. = select i1 %cmp112.not, float 0.000000e+00, float 1.000000e+00
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %10, i64 0
  %mul116 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %12 = tail call contract noundef float @llvm.minnum.f32(float %mul116, float 0x4024CB5EC0000000)
  %13 = tail call contract noundef float @llvm.exp.f32(float %12)
  %mul119 = fmul contract float %., %13
  %cmp112.not.1.not = icmp ult i32 %add109, %0
  %..1 = select i1 %cmp112.not.1.not, float 1.000000e+00, float 0.000000e+00
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %10, i64 1
  %mul116.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %14 = tail call contract noundef float @llvm.minnum.f32(float %mul116.1, float 0x4024CB5EC0000000)
  %15 = tail call contract noundef float @llvm.exp.f32(float %14)
  %mul119.1 = fmul contract float %..1, %15
  %add110.2 = or disjoint i32 %add109, 2
  %cmp112.not.2 = icmp ugt i32 %add110.2, %0
  %..2 = select i1 %cmp112.not.2, float 0.000000e+00, float 1.000000e+00
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %10, i64 2
  %mul116.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %16 = tail call contract noundef float @llvm.minnum.f32(float %mul116.2, float 0x4024CB5EC0000000)
  %17 = tail call contract noundef float @llvm.exp.f32(float %16)
  %mul119.2 = fmul contract float %..2, %17
  %add110.3 = or disjoint i32 %add109, 3
  %cmp112.not.3 = icmp ugt i32 %add110.3, %0
  %..3 = select i1 %cmp112.not.3, float 0.000000e+00, float 1.000000e+00
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %10, i64 3
  %mul116.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %18 = tail call contract noundef float @llvm.minnum.f32(float %mul116.3, float 0x4024CB5EC0000000)
  %19 = tail call contract noundef float @llvm.exp.f32(float %18)
  %mul119.3 = fmul contract float %..3, %19
  %20 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul119)
  %21 = insertelement <4 x i16> poison, i16 %20, i64 0
  %22 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul119.1)
  %23 = insertelement <4 x i16> %21, i16 %22, i64 1
  %24 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul119.2)
  %25 = insertelement <4 x i16> %23, i16 %24, i64 2
  %26 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul119.3)
  %27 = insertelement <4 x i16> %25, i16 %26, i64 3
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %27 to <4 x half>
  %28 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.6.vec.insert, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %29 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.7.14.vec.insert, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %add166 = fadd contract float %mul119, 0.000000e+00
  %add166.1 = fadd contract float %add166, %mul119.1
  %add166.2 = fadd contract float %add166.1, %mul119.2
  %add166.3 = fadd contract float %add166.2, %mul119.3
  %30 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add166.3, <4 x float> zeroinitializer)
  %tiny_sum_out.sroa.0.0.vec.extract = extractelement <4 x float> %30, i64 0
  %cmp184 = fcmp contract ogt float %tiny_sum_out.sroa.0.0.vec.extract, 0.000000e+00
  %31 = tail call contract noundef float @llvm.log.f32(float %tiny_sum_out.sroa.0.0.vec.extract)
  %mul188 = fneg contract float %31
  %32 = tail call contract noundef float @llvm.exp.f32(float %mul188)
  %condval_1.0 = select i1 %cmp184, float %32, float 0.000000e+00
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %28, i64 0
  %mul201 = fmul contract float %condval_1.0, %out.sroa.0.0.vec.extract
  %out.sroa.0.0.vec.insert373 = insertelement <4 x float> poison, float %mul201, i64 0
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %28, i64 1
  %mul201.1 = fmul contract float %condval_1.0, %out.sroa.0.4.vec.extract
  %out.sroa.0.4.vec.insert378 = insertelement <4 x float> %out.sroa.0.0.vec.insert373, float %mul201.1, i64 1
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %28, i64 2
  %mul201.2 = fmul contract float %condval_1.0, %out.sroa.0.8.vec.extract
  %out.sroa.0.8.vec.insert383 = insertelement <4 x float> %out.sroa.0.4.vec.insert378, float %mul201.2, i64 2
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %28, i64 3
  %mul201.3 = fmul contract float %condval_1.0, %out.sroa.0.12.vec.extract
  %out.sroa.0.12.vec.insert388 = insertelement <4 x float> %out.sroa.0.8.vec.insert383, float %mul201.3, i64 3
  %out.sroa.20.16.vec.extract = extractelement <4 x float> %29, i64 0
  %mul201.4 = fmul contract float %condval_1.0, %out.sroa.20.16.vec.extract
  %out.sroa.20.16.vec.insert394 = insertelement <4 x float> poison, float %mul201.4, i64 0
  %out.sroa.20.20.vec.extract = extractelement <4 x float> %29, i64 1
  %mul201.5 = fmul contract float %condval_1.0, %out.sroa.20.20.vec.extract
  %out.sroa.20.20.vec.insert399 = insertelement <4 x float> %out.sroa.20.16.vec.insert394, float %mul201.5, i64 1
  %out.sroa.20.24.vec.extract = extractelement <4 x float> %29, i64 2
  %mul201.6 = fmul contract float %condval_1.0, %out.sroa.20.24.vec.extract
  %out.sroa.20.24.vec.insert404 = insertelement <4 x float> %out.sroa.20.20.vec.insert399, float %mul201.6, i64 2
  %out.sroa.20.28.vec.extract = extractelement <4 x float> %29, i64 3
  %mul201.7 = fmul contract float %condval_1.0, %out.sroa.20.28.vec.extract
  %out.sroa.20.28.vec.insert409 = insertelement <4 x float> %out.sroa.20.24.vec.insert404, float %mul201.7, i64 3
  br label %if.end207

if.end207:                                        ; preds = %entry.if.end207_crit_edge, %for.cond25.preheader
  %mul250.pre-phi = phi i32 [ %.pre412, %entry.if.end207_crit_edge ], [ %mul108, %for.cond25.preheader ]
  %out.sroa.20.0 = phi <4 x float> [ zeroinitializer, %entry.if.end207_crit_edge ], [ %out.sroa.20.28.vec.insert409, %for.cond25.preheader ]
  %out.sroa.0.0 = phi <4 x float> [ zeroinitializer, %entry.if.end207_crit_edge ], [ %out.sroa.0.12.vec.insert388, %for.cond25.preheader ]
  %out.sroa.0.0.vec.extract375 = extractelement <4 x float> %out.sroa.0.0, i64 0
  %33 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract375)
  %result.sroa.0.0.insert.ext = zext i16 %33 to i64
  %out.sroa.0.4.vec.extract380 = extractelement <4 x float> %out.sroa.0.0, i64 1
  %34 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract380)
  %result.sroa.0.2.insert.ext = zext i16 %34 to i64
  %result.sroa.0.2.insert.shift = shl nuw nsw i64 %result.sroa.0.2.insert.ext, 16
  %result.sroa.0.2.insert.insert = or disjoint i64 %result.sroa.0.2.insert.shift, %result.sroa.0.0.insert.ext
  %out.sroa.0.8.vec.extract385 = extractelement <4 x float> %out.sroa.0.0, i64 2
  %35 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract385)
  %result.sroa.0.4.insert.ext = zext i16 %35 to i64
  %result.sroa.0.4.insert.shift = shl nuw nsw i64 %result.sroa.0.4.insert.ext, 32
  %result.sroa.0.4.insert.insert = or disjoint i64 %result.sroa.0.2.insert.insert, %result.sroa.0.4.insert.shift
  %out.sroa.0.12.vec.extract390 = extractelement <4 x float> %out.sroa.0.0, i64 3
  %36 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract390)
  %result.sroa.0.6.insert.ext = zext i16 %36 to i64
  %result.sroa.0.6.insert.shift = shl nuw i64 %result.sroa.0.6.insert.ext, 48
  %result.sroa.0.6.insert.insert = or disjoint i64 %result.sroa.0.4.insert.insert, %result.sroa.0.6.insert.shift
  %out.sroa.20.16.vec.extract396 = extractelement <4 x float> %out.sroa.20.0, i64 0
  %37 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.20.16.vec.extract396)
  %result.sroa.7.8.insert.ext = zext i16 %37 to i64
  %out.sroa.20.20.vec.extract401 = extractelement <4 x float> %out.sroa.20.0, i64 1
  %38 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.20.20.vec.extract401)
  %result.sroa.7.10.insert.ext = zext i16 %38 to i64
  %result.sroa.7.10.insert.shift = shl nuw nsw i64 %result.sroa.7.10.insert.ext, 16
  %result.sroa.7.10.insert.insert = or disjoint i64 %result.sroa.7.10.insert.shift, %result.sroa.7.8.insert.ext
  %out.sroa.20.24.vec.extract406 = extractelement <4 x float> %out.sroa.20.0, i64 2
  %39 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.20.24.vec.extract406)
  %result.sroa.7.12.insert.ext = zext i16 %39 to i64
  %result.sroa.7.12.insert.shift = shl nuw nsw i64 %result.sroa.7.12.insert.ext, 32
  %result.sroa.7.12.insert.insert = or disjoint i64 %result.sroa.7.10.insert.insert, %result.sroa.7.12.insert.shift
  %out.sroa.20.28.vec.extract411 = extractelement <4 x float> %out.sroa.20.0, i64 3
  %40 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.20.28.vec.extract411)
  %result.sroa.7.14.insert.ext = zext i16 %40 to i64
  %result.sroa.7.14.insert.shift = shl nuw i64 %result.sroa.7.14.insert.ext, 48
  %result.sroa.7.14.insert.insert = or disjoint i64 %result.sroa.7.12.insert.insert, %result.sroa.7.14.insert.shift
  %add247 = add nuw nsw i32 %add, %mul250.pre-phi
  %41 = zext nneg i32 %add247 to i64
  %add.ptr253 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %41
  store i64 %result.sroa.0.6.insert.insert, ptr addrspace(1) %add.ptr253, align 8
  %42 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %41
  %add.ptr253.1 = getelementptr inbounds i8, ptr addrspace(1) %42, i64 32
  store i64 %result.sroa.7.14.insert.insert, ptr addrspace(1) %add.ptr253.1, align 8
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

declare float @llvm.log.f32(float) #7

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

declare i1 @llvm.mxc.is.private(ptr nocapture) #5

declare void @llvm.mxc.sleep(i32 immarg) #9

declare float @llvm.minnum.f32(float, float) #7

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


