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
  %or.cond317 = or i1 %cmp20, %cmp24.not
  br i1 %or.cond317, label %entry.if.end194_crit_edge, label %for.cond25.preheader

entry.if.end194_crit_edge:                        ; preds = %entry
  %.pre = lshr i32 %1, 2
  %.pre398 = and i32 %.pre, 252
  br label %if.end194

for.cond25.preheader:                             ; preds = %entry
  %mul30 = shl nuw nsw i32 %3, 9
  %4 = shl nuw nsw i32 %1, 3
  %mul33 = and i32 %4, 8064
  %add34 = add nuw nsw i32 %mul30, %mul33
  %and42 = and i32 %1, 15
  %add43 = or disjoint i32 %add34, %and42
  %idxprom44 = zext nneg i32 %add43 to i64
  %arrayidx45 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom44
  %5 = load half, ptr addrspace(4) %arrayidx45, align 2, !tbaa !70
  %v.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %5, i64 0
  %add37.1 = or disjoint i32 %add34, %and42
  %add43.1 = or disjoint i32 %add37.1, 32
  %idxprom44.1 = zext nneg i32 %add43.1 to i64
  %arrayidx45.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom44.1
  %6 = load half, ptr addrspace(4) %arrayidx45.1, align 2, !tbaa !70
  %v.sroa.0.2.vec.insert = insertelement <4 x half> %v.sroa.0.0.vec.insert, half %6, i64 1
  %add37.2 = or disjoint i32 %add34, %and42
  %add43.2 = or disjoint i32 %add37.2, 64
  %idxprom44.2 = zext nneg i32 %add43.2 to i64
  %arrayidx45.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom44.2
  %7 = load half, ptr addrspace(4) %arrayidx45.2, align 2, !tbaa !70
  %v.sroa.0.4.vec.insert = insertelement <4 x half> %v.sroa.0.2.vec.insert, half %7, i64 2
  %add37.3 = or disjoint i32 %add34, %and42
  %add43.3 = or disjoint i32 %add37.3, 96
  %idxprom44.3 = zext nneg i32 %add43.3 to i64
  %arrayidx45.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom44.3
  %8 = load half, ptr addrspace(4) %arrayidx45.3, align 2, !tbaa !70
  %v.sroa.0.6.vec.insert = insertelement <4 x half> %v.sroa.0.4.vec.insert, half %8, i64 3
  %add40.4 = or disjoint i32 %add34, %and42
  %add43.4 = or disjoint i32 %add40.4, 16
  %idxprom44.4 = zext nneg i32 %add43.4 to i64
  %arrayidx45.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom44.4
  %9 = load half, ptr addrspace(4) %arrayidx45.4, align 2, !tbaa !70
  %v.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %9, i64 0
  %add40.5 = or disjoint i32 %add34, %and42
  %add43.5 = or disjoint i32 %add40.5, 48
  %idxprom44.5 = zext nneg i32 %add43.5 to i64
  %arrayidx45.5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom44.5
  %10 = load half, ptr addrspace(4) %arrayidx45.5, align 2, !tbaa !70
  %v.sroa.7.10.vec.insert = insertelement <4 x half> %v.sroa.7.8.vec.insert, half %10, i64 1
  %add40.6 = or disjoint i32 %add34, %and42
  %add43.6 = or disjoint i32 %add40.6, 80
  %idxprom44.6 = zext nneg i32 %add43.6 to i64
  %arrayidx45.6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom44.6
  %11 = load half, ptr addrspace(4) %arrayidx45.6, align 2, !tbaa !70
  %v.sroa.7.12.vec.insert = insertelement <4 x half> %v.sroa.7.10.vec.insert, half %11, i64 2
  %add40.7 = or disjoint i32 %add34, %and42
  %add43.7 = or disjoint i32 %add40.7, 112
  %idxprom44.7 = zext nneg i32 %add43.7 to i64
  %arrayidx45.7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom44.7
  %12 = load half, ptr addrspace(4) %arrayidx45.7, align 2, !tbaa !70
  %v.sroa.7.14.vec.insert = insertelement <4 x half> %v.sroa.7.12.vec.insert, half %12, i64 3
  %add55 = add nuw nsw i32 %mul9, %mul7
  %add59 = add nuw nsw i32 %add55, %mul30
  %idx.ext60 = zext nneg i32 %add59 to i64
  %add.ptr61 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %idx.ext60
  %k.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr61, align 16
  %k.sroa.4.0.add.ptr61.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr61, i64 8
  %k.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.4.0.add.ptr61.sroa_idx, align 8
  %13 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !76
  %14 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.4.0.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %13), !call_argsrelate !76
  %mul91 = shl nuw nsw i32 %3, 4
  %15 = lshr i32 %1, 2
  %mul94 = and i32 %15, 252
  %add95 = add nuw nsw i32 %mul91, %mul94
  %cmp98.not = icmp ugt i32 %add95, %0
  %. = select i1 %cmp98.not, float 0.000000e+00, float 1.000000e+00
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %14, i64 0
  %mul102 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FC2776C60000000
  %16 = tail call contract noundef float @llvm.minnum.f32(float %mul102, float 1.500000e+01)
  %17 = tail call contract noundef float @llvm.exp2.f32(float %16)
  %mul105 = fmul contract float %., %17
  %cmp98.not.1.not = icmp ult i32 %add95, %0
  %..1 = select i1 %cmp98.not.1.not, float 1.000000e+00, float 0.000000e+00
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %14, i64 1
  %mul102.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FC2776C60000000
  %18 = tail call contract noundef float @llvm.minnum.f32(float %mul102.1, float 1.500000e+01)
  %19 = tail call contract noundef float @llvm.exp2.f32(float %18)
  %mul105.1 = fmul contract float %..1, %19
  %add96.2 = or disjoint i32 %add95, 2
  %cmp98.not.2 = icmp ugt i32 %add96.2, %0
  %..2 = select i1 %cmp98.not.2, float 0.000000e+00, float 1.000000e+00
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %14, i64 2
  %mul102.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FC2776C60000000
  %20 = tail call contract noundef float @llvm.minnum.f32(float %mul102.2, float 1.500000e+01)
  %21 = tail call contract noundef float @llvm.exp2.f32(float %20)
  %mul105.2 = fmul contract float %..2, %21
  %add96.3 = or disjoint i32 %add95, 3
  %cmp98.not.3 = icmp ugt i32 %add96.3, %0
  %..3 = select i1 %cmp98.not.3, float 0.000000e+00, float 1.000000e+00
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %14, i64 3
  %mul102.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FC2776C60000000
  %22 = tail call contract noundef float @llvm.minnum.f32(float %mul102.3, float 1.500000e+01)
  %23 = tail call contract noundef float @llvm.exp2.f32(float %22)
  %mul105.3 = fmul contract float %..3, %23
  %24 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul105)
  %25 = insertelement <4 x i16> poison, i16 %24, i64 0
  %26 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul105.1)
  %27 = insertelement <4 x i16> %25, i16 %26, i64 1
  %28 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul105.2)
  %29 = insertelement <4 x i16> %27, i16 %28, i64 2
  %30 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul105.3)
  %31 = insertelement <4 x i16> %29, i16 %30, i64 3
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %31 to <4 x half>
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.6.vec.insert, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.7.14.vec.insert, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %add152 = fadd contract float %mul105, 0.000000e+00
  %add152.1 = fadd contract float %add152, %mul105.1
  %add152.2 = fadd contract float %add152.1, %mul105.2
  %add152.3 = fadd contract float %add152.2, %mul105.3
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add152.3, <4 x float> zeroinitializer)
  %tiny_sum_out.sroa.0.0.vec.extract = extractelement <4 x float> %34, i64 0
  %cmp170 = fcmp contract ogt float %tiny_sum_out.sroa.0.0.vec.extract, 0.000000e+00
  %cmp.i.i = fcmp contract olt float %tiny_sum_out.sroa.0.0.vec.extract, 0x39B0000000000000
  %cond.i.i = select contract i1 %cmp.i.i, float 0x4630000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %tiny_sum_out.sroa.0.0.vec.extract, %cond.i.i
  %35 = tail call contract float @llvm.mxc.rsq.f32(float %mul.i.i)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x4310000000000000, float 1.000000e+00
  %mul3.i.i = fmul contract float %cond2.i.i, %35
  %mul176 = fmul contract float %mul3.i.i, %mul3.i.i
  %condval_1.0 = select i1 %cmp170, float %mul176, float 0.000000e+00
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %32, i64 0
  %mul188 = fmul contract float %condval_1.0, %out.sroa.0.0.vec.extract
  %out.sroa.0.0.vec.insert359 = insertelement <4 x float> poison, float %mul188, i64 0
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %32, i64 1
  %mul188.1 = fmul contract float %condval_1.0, %out.sroa.0.4.vec.extract
  %out.sroa.0.4.vec.insert364 = insertelement <4 x float> %out.sroa.0.0.vec.insert359, float %mul188.1, i64 1
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %32, i64 2
  %mul188.2 = fmul contract float %condval_1.0, %out.sroa.0.8.vec.extract
  %out.sroa.0.8.vec.insert369 = insertelement <4 x float> %out.sroa.0.4.vec.insert364, float %mul188.2, i64 2
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %32, i64 3
  %mul188.3 = fmul contract float %condval_1.0, %out.sroa.0.12.vec.extract
  %out.sroa.0.12.vec.insert374 = insertelement <4 x float> %out.sroa.0.8.vec.insert369, float %mul188.3, i64 3
  %out.sroa.20.16.vec.extract = extractelement <4 x float> %33, i64 0
  %mul188.4 = fmul contract float %condval_1.0, %out.sroa.20.16.vec.extract
  %out.sroa.20.16.vec.insert380 = insertelement <4 x float> poison, float %mul188.4, i64 0
  %out.sroa.20.20.vec.extract = extractelement <4 x float> %33, i64 1
  %mul188.5 = fmul contract float %condval_1.0, %out.sroa.20.20.vec.extract
  %out.sroa.20.20.vec.insert385 = insertelement <4 x float> %out.sroa.20.16.vec.insert380, float %mul188.5, i64 1
  %out.sroa.20.24.vec.extract = extractelement <4 x float> %33, i64 2
  %mul188.6 = fmul contract float %condval_1.0, %out.sroa.20.24.vec.extract
  %out.sroa.20.24.vec.insert390 = insertelement <4 x float> %out.sroa.20.20.vec.insert385, float %mul188.6, i64 2
  %out.sroa.20.28.vec.extract = extractelement <4 x float> %33, i64 3
  %mul188.7 = fmul contract float %condval_1.0, %out.sroa.20.28.vec.extract
  %out.sroa.20.28.vec.insert395 = insertelement <4 x float> %out.sroa.20.24.vec.insert390, float %mul188.7, i64 3
  br label %if.end194

if.end194:                                        ; preds = %entry.if.end194_crit_edge, %for.cond25.preheader
  %mul237.pre-phi = phi i32 [ %.pre398, %entry.if.end194_crit_edge ], [ %mul94, %for.cond25.preheader ]
  %out.sroa.0.0 = phi <4 x float> [ zeroinitializer, %entry.if.end194_crit_edge ], [ %out.sroa.0.12.vec.insert374, %for.cond25.preheader ]
  %out.sroa.20.0 = phi <4 x float> [ zeroinitializer, %entry.if.end194_crit_edge ], [ %out.sroa.20.28.vec.insert395, %for.cond25.preheader ]
  %out.sroa.0.0.vec.extract361 = extractelement <4 x float> %out.sroa.0.0, i64 0
  %36 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract361)
  %result.sroa.0.0.insert.ext = zext i16 %36 to i64
  %out.sroa.0.4.vec.extract366 = extractelement <4 x float> %out.sroa.0.0, i64 1
  %37 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract366)
  %result.sroa.0.2.insert.ext = zext i16 %37 to i64
  %result.sroa.0.2.insert.shift = shl nuw nsw i64 %result.sroa.0.2.insert.ext, 16
  %result.sroa.0.2.insert.insert = or disjoint i64 %result.sroa.0.2.insert.shift, %result.sroa.0.0.insert.ext
  %out.sroa.0.8.vec.extract371 = extractelement <4 x float> %out.sroa.0.0, i64 2
  %38 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract371)
  %result.sroa.0.4.insert.ext = zext i16 %38 to i64
  %result.sroa.0.4.insert.shift = shl nuw nsw i64 %result.sroa.0.4.insert.ext, 32
  %result.sroa.0.4.insert.insert = or disjoint i64 %result.sroa.0.2.insert.insert, %result.sroa.0.4.insert.shift
  %out.sroa.0.12.vec.extract376 = extractelement <4 x float> %out.sroa.0.0, i64 3
  %39 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract376)
  %result.sroa.0.6.insert.ext = zext i16 %39 to i64
  %result.sroa.0.6.insert.shift = shl nuw i64 %result.sroa.0.6.insert.ext, 48
  %result.sroa.0.6.insert.insert = or disjoint i64 %result.sroa.0.4.insert.insert, %result.sroa.0.6.insert.shift
  %out.sroa.20.16.vec.extract382 = extractelement <4 x float> %out.sroa.20.0, i64 0
  %40 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.20.16.vec.extract382)
  %result.sroa.7.8.insert.ext = zext i16 %40 to i64
  %out.sroa.20.20.vec.extract387 = extractelement <4 x float> %out.sroa.20.0, i64 1
  %41 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.20.20.vec.extract387)
  %result.sroa.7.10.insert.ext = zext i16 %41 to i64
  %result.sroa.7.10.insert.shift = shl nuw nsw i64 %result.sroa.7.10.insert.ext, 16
  %result.sroa.7.10.insert.insert = or disjoint i64 %result.sroa.7.10.insert.shift, %result.sroa.7.8.insert.ext
  %out.sroa.20.24.vec.extract392 = extractelement <4 x float> %out.sroa.20.0, i64 2
  %42 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.20.24.vec.extract392)
  %result.sroa.7.12.insert.ext = zext i16 %42 to i64
  %result.sroa.7.12.insert.shift = shl nuw nsw i64 %result.sroa.7.12.insert.ext, 32
  %result.sroa.7.12.insert.insert = or disjoint i64 %result.sroa.7.10.insert.insert, %result.sroa.7.12.insert.shift
  %out.sroa.20.28.vec.extract397 = extractelement <4 x float> %out.sroa.20.0, i64 3
  %43 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.20.28.vec.extract397)
  %result.sroa.7.14.insert.ext = zext i16 %43 to i64
  %result.sroa.7.14.insert.shift = shl nuw i64 %result.sroa.7.14.insert.ext, 48
  %result.sroa.7.14.insert.insert = or disjoint i64 %result.sroa.7.12.insert.insert, %result.sroa.7.14.insert.shift
  %add234 = add nuw nsw i32 %add, %mul237.pre-phi
  %44 = zext nneg i32 %add234 to i64
  %add.ptr240 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %44
  store i64 %result.sroa.0.6.insert.insert, ptr addrspace(1) %add.ptr240, align 8
  %45 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %44
  %add.ptr240.1 = getelementptr inbounds i8, ptr addrspace(1) %45, i64 32
  store i64 %result.sroa.7.14.insert.insert, ptr addrspace(1) %add.ptr240.1, align 8
  ret void
}

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

declare <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float, float, <4 x float>) #4

declare i32 @llvm.mxc.block.id.x() #5

declare i32 @llvm.mxc.block.id.y() #5

declare i32 @llvm.mxc.block.id.z() #5

declare i32 @llvm.mxc.thread.id.x() #5

declare void @llvm.mxc.barrier.warp() #6

declare float @llvm.exp2.f32(float) #7

declare i16 @llvm.convert.to.fp16.f32(float) #8

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

declare i1 @llvm.mxc.is.private(ptr nocapture) #5

declare void @llvm.mxc.sleep(i32 immarg) #9

declare float @llvm.mxc.rsq.f32(float) #5

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


