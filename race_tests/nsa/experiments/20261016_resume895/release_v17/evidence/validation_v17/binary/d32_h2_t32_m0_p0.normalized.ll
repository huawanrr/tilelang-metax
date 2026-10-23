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
  %mul = shl nsw i32 %0, 10
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !range !29
  %mul7 = shl nsw i32 %1, 9
  %add = add nuw nsw i32 %mul, %mul7
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !55
  %and = shl nuw nsw i32 %2, 5
  %mul9 = and i32 %and, 480
  %add10 = or disjoint i32 %add, %mul9
  %mul16 = shl nuw nsw i32 %0, 1
  %add18 = add nuw nsw i32 %mul16, %1
  %idxprom = zext nneg i32 %add18 to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %idxprom
  %3 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cmp25 = icmp ugt i32 %3, 1
  %shr28 = lshr i32 %0, 4
  %cmp29.not = icmp ugt i32 %3, %shr28
  %or.cond321 = or i1 %cmp25, %cmp29.not
  br i1 %or.cond321, label %entry.if.end199_crit_edge, label %if.then

entry.if.end199_crit_edge:                        ; preds = %entry
  %.pre = lshr i32 %2, 2
  %.pre402 = and i32 %.pre, 252
  br label %if.end199

if.then:                                          ; preds = %entry
  %4 = lshr i32 %2, 1
  %mul12 = and i32 %4, 504
  %add13 = add nuw nsw i32 %add10, %mul12
  %idx.ext = zext nneg i32 %add13 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %idx.ext
  %q.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %q.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %q.sroa.4.0.add.ptr.sroa_idx, align 8
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16
  %mul30 = shl nuw nsw i32 %3, 10
  %and32 = shl nuw nsw i32 %2, 6
  %mul33 = and i32 %and32, 960
  %mul36 = shl nsw i32 %1, 5
  %add34 = add nuw nsw i32 %mul33, %mul36
  %add37 = add nuw nsw i32 %add34, %mul12
  %add41 = add nuw nsw i32 %add37, %mul30
  %idx.ext42 = zext nneg i32 %add41 to i64
  %add.ptr43 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %idx.ext42
  %k.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr43, align 16
  %k.sroa.4.0.add.ptr43.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr43, i64 8
  %k.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.4.0.add.ptr43.sroa_idx, align 8
  %5 = shl nuw nsw i32 %2, 4
  %mul54 = and i32 %5, 16128
  %and66 = and i32 %2, 15
  %add55 = or disjoint i32 %and66, %mul36
  %add58 = add nuw nsw i32 %add55, %mul54
  %add61 = add nuw nsw i32 %add58, %mul30
  %idxprom68 = zext nneg i32 %add61 to i64
  %arrayidx69 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom68
  %6 = load half, ptr addrspace(4) %arrayidx69, align 2, !tbaa !76
  %v.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %6, i64 0
  %add64.1 = add nuw nsw i32 %add61, 64
  %idxprom68.1 = zext nneg i32 %add64.1 to i64
  %arrayidx69.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom68.1
  %7 = load half, ptr addrspace(4) %arrayidx69.1, align 2, !tbaa !76
  %v.sroa.0.2.vec.insert = insertelement <4 x half> %v.sroa.0.0.vec.insert, half %7, i64 1
  %add64.2 = add nuw nsw i32 %add61, 128
  %idxprom68.2 = zext nneg i32 %add64.2 to i64
  %arrayidx69.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom68.2
  %8 = load half, ptr addrspace(4) %arrayidx69.2, align 2, !tbaa !76
  %v.sroa.0.4.vec.insert = insertelement <4 x half> %v.sroa.0.2.vec.insert, half %8, i64 2
  %add64.3 = add nuw nsw i32 %add61, 192
  %idxprom68.3 = zext nneg i32 %add64.3 to i64
  %arrayidx69.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom68.3
  %9 = load half, ptr addrspace(4) %arrayidx69.3, align 2, !tbaa !76
  %v.sroa.0.6.vec.insert = insertelement <4 x half> %v.sroa.0.4.vec.insert, half %9, i64 3
  %add67.4 = or disjoint i32 %add61, 16
  %idxprom68.4 = zext nneg i32 %add67.4 to i64
  %arrayidx69.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom68.4
  %10 = load half, ptr addrspace(4) %arrayidx69.4, align 2, !tbaa !76
  %v.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %10, i64 0
  %add67.5 = or disjoint i32 %add64.1, 16
  %idxprom68.5 = zext nneg i32 %add67.5 to i64
  %arrayidx69.5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom68.5
  %11 = load half, ptr addrspace(4) %arrayidx69.5, align 2, !tbaa !76
  %v.sroa.7.10.vec.insert = insertelement <4 x half> %v.sroa.7.8.vec.insert, half %11, i64 1
  %add67.6 = or disjoint i32 %add64.2, 16
  %idxprom68.6 = zext nneg i32 %add67.6 to i64
  %arrayidx69.6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom68.6
  %12 = load half, ptr addrspace(4) %arrayidx69.6, align 2, !tbaa !76
  %v.sroa.7.12.vec.insert = insertelement <4 x half> %v.sroa.7.10.vec.insert, half %12, i64 2
  %add67.7 = or disjoint i32 %add64.3, 16
  %idxprom68.7 = zext nneg i32 %add67.7 to i64
  %arrayidx69.7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom68.7
  %13 = load half, ptr addrspace(4) %arrayidx69.7, align 2, !tbaa !76
  %v.sroa.7.14.vec.insert = insertelement <4 x half> %v.sroa.7.12.vec.insert, half %13, i64 3
  %14 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !80
  %15 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.4.0.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %14), !call_argsrelate !80
  %mul102 = shl nuw nsw i32 %3, 4
  %16 = lshr i32 %2, 2
  %mul105 = and i32 %16, 252
  %add106 = add nuw nsw i32 %mul102, %mul105
  %cmp109.not = icmp ugt i32 %add106, %0
  %. = select i1 %cmp109.not, float 0.000000e+00, float 1.000000e+00
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %15, i64 0
  %mul113 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %17 = tail call contract noundef float @llvm.minnum.f32(float %mul113, float 0x4024CB5EC0000000)
  %18 = tail call contract noundef float @llvm.exp.f32(float %17)
  %mul116 = fmul contract float %., %18
  %cmp109.not.1.not = icmp ult i32 %add106, %0
  %..1 = select i1 %cmp109.not.1.not, float 1.000000e+00, float 0.000000e+00
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %15, i64 1
  %mul113.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %19 = tail call contract noundef float @llvm.minnum.f32(float %mul113.1, float 0x4024CB5EC0000000)
  %20 = tail call contract noundef float @llvm.exp.f32(float %19)
  %mul116.1 = fmul contract float %..1, %20
  %add107.2 = or disjoint i32 %add106, 2
  %cmp109.not.2 = icmp ugt i32 %add107.2, %0
  %..2 = select i1 %cmp109.not.2, float 0.000000e+00, float 1.000000e+00
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %15, i64 2
  %mul113.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %21 = tail call contract noundef float @llvm.minnum.f32(float %mul113.2, float 0x4024CB5EC0000000)
  %22 = tail call contract noundef float @llvm.exp.f32(float %21)
  %mul116.2 = fmul contract float %..2, %22
  %add107.3 = or disjoint i32 %add106, 3
  %cmp109.not.3 = icmp ugt i32 %add107.3, %0
  %..3 = select i1 %cmp109.not.3, float 0.000000e+00, float 1.000000e+00
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %15, i64 3
  %mul113.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %23 = tail call contract noundef float @llvm.minnum.f32(float %mul113.3, float 0x4024CB5EC0000000)
  %24 = tail call contract noundef float @llvm.exp.f32(float %23)
  %mul116.3 = fmul contract float %..3, %24
  %25 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul116)
  %26 = insertelement <4 x i16> poison, i16 %25, i64 0
  %27 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul116.1)
  %28 = insertelement <4 x i16> %26, i16 %27, i64 1
  %29 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul116.2)
  %30 = insertelement <4 x i16> %28, i16 %29, i64 2
  %31 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul116.3)
  %32 = insertelement <4 x i16> %30, i16 %31, i64 3
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %32 to <4 x half>
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.6.vec.insert, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.7.14.vec.insert, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %add163 = fadd contract float %mul116, 0.000000e+00
  %add163.1 = fadd contract float %add163, %mul116.1
  %add163.2 = fadd contract float %add163.1, %mul116.2
  %add163.3 = fadd contract float %add163.2, %mul116.3
  %35 = bitcast float %add163.3 to i32
  %36 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %37 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %36) #9
  %xor.i.i = xor i32 %37, 32
  %38 = and i32 %37, -64
  %and.i.i = add nsw i32 %38, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %37
  %shl.i.i = shl i32 %cond.i.i, 2
  %39 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %35)
  %40 = bitcast i32 %39 to float
  %add171 = fadd contract float %add163.3, %40
  %41 = bitcast float %add171 to i32
  %42 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9
  %43 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %42) #9
  %xor.i.i304 = xor i32 %43, 16
  %44 = and i32 %43, -64
  %and.i.i305 = add nsw i32 %44, 64
  %cmp.not.i.i306 = icmp slt i32 %xor.i.i304, %and.i.i305
  %cond.i.i307 = select i1 %cmp.not.i.i306, i32 %xor.i.i304, i32 %43
  %shl.i.i308 = shl i32 %cond.i.i307, 2
  %45 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i308, i32 %41)
  %46 = bitcast i32 %45 to float
  %add176 = fadd contract float %add171, %46
  %cmp179 = fcmp contract ogt float %add176, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add176
  %condval_1.0 = select i1 %cmp179, float %div, float 0.000000e+00
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %33, i64 0
  %mul193 = fmul contract float %condval_1.0, %out.sroa.0.0.vec.extract
  %out.sroa.0.0.vec.insert363 = insertelement <4 x float> poison, float %mul193, i64 0
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %33, i64 1
  %mul193.1 = fmul contract float %condval_1.0, %out.sroa.0.4.vec.extract
  %out.sroa.0.4.vec.insert368 = insertelement <4 x float> %out.sroa.0.0.vec.insert363, float %mul193.1, i64 1
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %33, i64 2
  %mul193.2 = fmul contract float %condval_1.0, %out.sroa.0.8.vec.extract
  %out.sroa.0.8.vec.insert373 = insertelement <4 x float> %out.sroa.0.4.vec.insert368, float %mul193.2, i64 2
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %33, i64 3
  %mul193.3 = fmul contract float %condval_1.0, %out.sroa.0.12.vec.extract
  %out.sroa.0.12.vec.insert378 = insertelement <4 x float> %out.sroa.0.8.vec.insert373, float %mul193.3, i64 3
  %out.sroa.20.16.vec.extract = extractelement <4 x float> %34, i64 0
  %mul193.4 = fmul contract float %condval_1.0, %out.sroa.20.16.vec.extract
  %out.sroa.20.16.vec.insert384 = insertelement <4 x float> poison, float %mul193.4, i64 0
  %out.sroa.20.20.vec.extract = extractelement <4 x float> %34, i64 1
  %mul193.5 = fmul contract float %condval_1.0, %out.sroa.20.20.vec.extract
  %out.sroa.20.20.vec.insert389 = insertelement <4 x float> %out.sroa.20.16.vec.insert384, float %mul193.5, i64 1
  %out.sroa.20.24.vec.extract = extractelement <4 x float> %34, i64 2
  %mul193.6 = fmul contract float %condval_1.0, %out.sroa.20.24.vec.extract
  %out.sroa.20.24.vec.insert394 = insertelement <4 x float> %out.sroa.20.20.vec.insert389, float %mul193.6, i64 2
  %out.sroa.20.28.vec.extract = extractelement <4 x float> %34, i64 3
  %mul193.7 = fmul contract float %condval_1.0, %out.sroa.20.28.vec.extract
  %out.sroa.20.28.vec.insert399 = insertelement <4 x float> %out.sroa.20.24.vec.insert394, float %mul193.7, i64 3
  br label %if.end199

if.end199:                                        ; preds = %entry.if.end199_crit_edge, %if.then
  %mul245.pre-phi = phi i32 [ %.pre402, %entry.if.end199_crit_edge ], [ %mul105, %if.then ]
  %out.sroa.0.0 = phi <4 x float> [ zeroinitializer, %entry.if.end199_crit_edge ], [ %out.sroa.0.12.vec.insert378, %if.then ]
  %out.sroa.20.0 = phi <4 x float> [ zeroinitializer, %entry.if.end199_crit_edge ], [ %out.sroa.20.28.vec.insert399, %if.then ]
  %out.sroa.0.0.vec.extract365 = extractelement <4 x float> %out.sroa.0.0, i64 0
  %47 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract365)
  %result.sroa.0.0.insert.ext = zext i16 %47 to i64
  %out.sroa.0.4.vec.extract370 = extractelement <4 x float> %out.sroa.0.0, i64 1
  %48 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract370)
  %result.sroa.0.2.insert.ext = zext i16 %48 to i64
  %result.sroa.0.2.insert.shift = shl nuw nsw i64 %result.sroa.0.2.insert.ext, 16
  %result.sroa.0.2.insert.insert = or disjoint i64 %result.sroa.0.2.insert.shift, %result.sroa.0.0.insert.ext
  %out.sroa.0.8.vec.extract375 = extractelement <4 x float> %out.sroa.0.0, i64 2
  %49 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract375)
  %result.sroa.0.4.insert.ext = zext i16 %49 to i64
  %result.sroa.0.4.insert.shift = shl nuw nsw i64 %result.sroa.0.4.insert.ext, 32
  %result.sroa.0.4.insert.insert = or disjoint i64 %result.sroa.0.2.insert.insert, %result.sroa.0.4.insert.shift
  %out.sroa.0.12.vec.extract380 = extractelement <4 x float> %out.sroa.0.0, i64 3
  %50 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract380)
  %result.sroa.0.6.insert.ext = zext i16 %50 to i64
  %result.sroa.0.6.insert.shift = shl nuw i64 %result.sroa.0.6.insert.ext, 48
  %result.sroa.0.6.insert.insert = or disjoint i64 %result.sroa.0.4.insert.insert, %result.sroa.0.6.insert.shift
  %out.sroa.20.16.vec.extract386 = extractelement <4 x float> %out.sroa.20.0, i64 0
  %51 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.20.16.vec.extract386)
  %result.sroa.7.8.insert.ext = zext i16 %51 to i64
  %out.sroa.20.20.vec.extract391 = extractelement <4 x float> %out.sroa.20.0, i64 1
  %52 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.20.20.vec.extract391)
  %result.sroa.7.10.insert.ext = zext i16 %52 to i64
  %result.sroa.7.10.insert.shift = shl nuw nsw i64 %result.sroa.7.10.insert.ext, 16
  %result.sroa.7.10.insert.insert = or disjoint i64 %result.sroa.7.10.insert.shift, %result.sroa.7.8.insert.ext
  %out.sroa.20.24.vec.extract396 = extractelement <4 x float> %out.sroa.20.0, i64 2
  %53 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.20.24.vec.extract396)
  %result.sroa.7.12.insert.ext = zext i16 %53 to i64
  %result.sroa.7.12.insert.shift = shl nuw nsw i64 %result.sroa.7.12.insert.ext, 32
  %result.sroa.7.12.insert.insert = or disjoint i64 %result.sroa.7.10.insert.insert, %result.sroa.7.12.insert.shift
  %out.sroa.20.28.vec.extract401 = extractelement <4 x float> %out.sroa.20.0, i64 3
  %54 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.20.28.vec.extract401)
  %result.sroa.7.14.insert.ext = zext i16 %54 to i64
  %result.sroa.7.14.insert.shift = shl nuw i64 %result.sroa.7.14.insert.ext, 48
  %result.sroa.7.14.insert.insert = or disjoint i64 %result.sroa.7.12.insert.insert, %result.sroa.7.14.insert.shift
  %add242 = add nuw nsw i32 %add10, %mul245.pre-phi
  %55 = zext nneg i32 %add242 to i64
  %add.ptr248 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %55
  store i64 %result.sroa.0.6.insert.insert, ptr addrspace(1) %add.ptr248, align 8
  %56 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %55
  %add.ptr248.1 = getelementptr inbounds i8, ptr addrspace(1) %56, i64 32
  store i64 %result.sroa.7.14.insert.insert, ptr addrspace(1) %add.ptr248.1, align 8
  ret void
}

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

declare i32 @llvm.mxc.block.id.x() #5

declare i32 @llvm.mxc.block.id.y() #5

declare i32 @llvm.mxc.block.id.z() #5

declare i32 @llvm.mxc.thread.id.x() #5

declare float @llvm.exp.f32(float) #6

declare i16 @llvm.convert.to.fp16.f32(float) #7

declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

declare i1 @llvm.mxc.is.private(ptr nocapture) #5

declare void @llvm.mxc.sleep(i32 immarg) #8

declare float @llvm.minnum.f32(float, float) #6

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress nofree norecurse nounwind willreturn memory(argmem: readwrite) "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #7 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #8 = { nounwind willreturn }
attributes #9 = { nomerge }


