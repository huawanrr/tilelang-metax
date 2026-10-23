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
  %arrayidx13.val = load i32, ptr addrspace(1) %arrayidx13, align 4, !tbaa !30
  %or.cond = icmp ugt i32 %arrayidx13.val, 3
  %shr24 = lshr i32 %0, 4
  %cmp25.not = icmp ugt i32 %arrayidx13.val, %shr24
  %or.cond328 = or i1 %or.cond, %cmp25.not
  br i1 %or.cond328, label %entry.if.end208_crit_edge, label %for.cond26.preheader

entry.if.end208_crit_edge:                        ; preds = %entry
  %.pre = lshr i32 %1, 2
  %.pre413 = and i32 %.pre, 252
  br label %if.end208

for.cond26.preheader:                             ; preds = %entry
  %mul32 = shl nuw nsw i32 %arrayidx13.val, 9
  %3 = shl nuw nsw i32 %1, 3
  %mul35 = and i32 %3, 8064
  %add36 = add nuw nsw i32 %mul32, %mul35
  %and44 = and i32 %1, 15
  %add45 = or disjoint i32 %add36, %and44
  %idxprom46 = zext nneg i32 %add45 to i64
  %arrayidx47 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom46
  %arrayidx47.val414 = load half, ptr addrspace(4) %arrayidx47, align 2, !tbaa !71
  %v.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %arrayidx47.val414, i64 0
  %add39.1 = or disjoint i32 %add36, %and44
  %add45.1 = or disjoint i32 %add39.1, 32
  %idxprom46.1 = zext nneg i32 %add45.1 to i64
  %arrayidx47.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom46.1
  %arrayidx47.val.1415 = load half, ptr addrspace(4) %arrayidx47.1, align 2, !tbaa !71
  %v.sroa.0.2.vec.insert = insertelement <4 x half> %v.sroa.0.0.vec.insert, half %arrayidx47.val.1415, i64 1
  %add39.2 = or disjoint i32 %add36, %and44
  %add45.2 = or disjoint i32 %add39.2, 64
  %idxprom46.2 = zext nneg i32 %add45.2 to i64
  %arrayidx47.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom46.2
  %arrayidx47.val.2416 = load half, ptr addrspace(4) %arrayidx47.2, align 2, !tbaa !71
  %v.sroa.0.4.vec.insert = insertelement <4 x half> %v.sroa.0.2.vec.insert, half %arrayidx47.val.2416, i64 2
  %add39.3 = or disjoint i32 %add36, %and44
  %add45.3 = or disjoint i32 %add39.3, 96
  %idxprom46.3 = zext nneg i32 %add45.3 to i64
  %arrayidx47.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom46.3
  %arrayidx47.val.3417 = load half, ptr addrspace(4) %arrayidx47.3, align 2, !tbaa !71
  %v.sroa.0.6.vec.insert = insertelement <4 x half> %v.sroa.0.4.vec.insert, half %arrayidx47.val.3417, i64 3
  %add42.4 = or disjoint i32 %add36, %and44
  %add45.4 = or disjoint i32 %add42.4, 16
  %idxprom46.4 = zext nneg i32 %add45.4 to i64
  %arrayidx47.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom46.4
  %arrayidx47.val.4418 = load half, ptr addrspace(4) %arrayidx47.4, align 2, !tbaa !71
  %v.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %arrayidx47.val.4418, i64 0
  %add42.5 = or disjoint i32 %add36, %and44
  %add45.5 = or disjoint i32 %add42.5, 48
  %idxprom46.5 = zext nneg i32 %add45.5 to i64
  %arrayidx47.5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom46.5
  %arrayidx47.val.5419 = load half, ptr addrspace(4) %arrayidx47.5, align 2, !tbaa !71
  %v.sroa.7.10.vec.insert = insertelement <4 x half> %v.sroa.7.8.vec.insert, half %arrayidx47.val.5419, i64 1
  %add42.6 = or disjoint i32 %add36, %and44
  %add45.6 = or disjoint i32 %add42.6, 80
  %idxprom46.6 = zext nneg i32 %add45.6 to i64
  %arrayidx47.6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom46.6
  %arrayidx47.val.6420 = load half, ptr addrspace(4) %arrayidx47.6, align 2, !tbaa !71
  %v.sroa.7.12.vec.insert = insertelement <4 x half> %v.sroa.7.10.vec.insert, half %arrayidx47.val.6420, i64 2
  %add42.7 = or disjoint i32 %add36, %and44
  %add45.7 = or disjoint i32 %add42.7, 112
  %idxprom46.7 = zext nneg i32 %add45.7 to i64
  %arrayidx47.7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %idxprom46.7
  %arrayidx47.val.7421 = load half, ptr addrspace(4) %arrayidx47.7, align 2, !tbaa !71
  %v.sroa.7.14.vec.insert = insertelement <4 x half> %v.sroa.7.12.vec.insert, half %arrayidx47.val.7421, i64 3
  %add64 = add nuw nsw i32 %mul9, %mul7
  %add68 = add nuw nsw i32 %add64, %mul32
  %4 = zext nneg i32 %add68 to i64
  %arrayidx71 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %4
  %5 = load <4 x half>, ptr addrspace(4) %arrayidx71, align 2, !tbaa !71
  %6 = or disjoint i64 %4, 4
  %arrayidx71.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %6
  %7 = load <4 x half>, ptr addrspace(4) %arrayidx71.4, align 2, !tbaa !71
  %8 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %5, <4 x half> %q.sroa.0.0.copyload, <4 x float> zeroinitializer), !call_argsrelate !78
  %9 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %7, <4 x half> %q.sroa.4.0.copyload, <4 x float> %8), !call_argsrelate !78
  %mul106 = shl nuw nsw i32 %arrayidx13.val, 4
  %10 = lshr i32 %1, 2
  %mul109 = and i32 %10, 252
  %add110 = add nuw nsw i32 %mul106, %mul109
  %cmp113.not = icmp ugt i32 %add110, %0
  %. = select i1 %cmp113.not, float 0.000000e+00, float 1.000000e+00
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %9, i64 0
  %mul117 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000
  %11 = tail call contract noundef float @llvm.minnum.f32(float %mul117, float 0x4024CB5EC0000000)
  %12 = tail call contract noundef float @llvm.exp.f32(float %11)
  %mul120 = fmul contract float %., %12
  %cmp113.not.1.not = icmp ult i32 %add110, %0
  %..1 = select i1 %cmp113.not.1.not, float 1.000000e+00, float 0.000000e+00
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %9, i64 1
  %mul117.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000
  %13 = tail call contract noundef float @llvm.minnum.f32(float %mul117.1, float 0x4024CB5EC0000000)
  %14 = tail call contract noundef float @llvm.exp.f32(float %13)
  %mul120.1 = fmul contract float %..1, %14
  %add111.2 = or disjoint i32 %add110, 2
  %cmp113.not.2 = icmp ugt i32 %add111.2, %0
  %..2 = select i1 %cmp113.not.2, float 0.000000e+00, float 1.000000e+00
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %9, i64 2
  %mul117.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000
  %15 = tail call contract noundef float @llvm.minnum.f32(float %mul117.2, float 0x4024CB5EC0000000)
  %16 = tail call contract noundef float @llvm.exp.f32(float %15)
  %mul120.2 = fmul contract float %..2, %16
  %add111.3 = or disjoint i32 %add110, 3
  %cmp113.not.3 = icmp ugt i32 %add111.3, %0
  %..3 = select i1 %cmp113.not.3, float 0.000000e+00, float 1.000000e+00
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %9, i64 3
  %mul117.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000
  %17 = tail call contract noundef float @llvm.minnum.f32(float %mul117.3, float 0x4024CB5EC0000000)
  %18 = tail call contract noundef float @llvm.exp.f32(float %17)
  %mul120.3 = fmul contract float %..3, %18
  %19 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul120)
  %20 = insertelement <4 x i16> poison, i16 %19, i64 0
  %21 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul120.1)
  %22 = insertelement <4 x i16> %20, i16 %21, i64 1
  %23 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul120.2)
  %24 = insertelement <4 x i16> %22, i16 %23, i64 2
  %25 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul120.3)
  %26 = insertelement <4 x i16> %24, i16 %25, i64 3
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %26 to <4 x half>
  %27 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.6.vec.insert, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %28 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.7.14.vec.insert, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %add167 = fadd contract float %mul120, 0.000000e+00
  %add167.1 = fadd contract float %add167, %mul120.1
  %add167.2 = fadd contract float %add167.1, %mul120.2
  %add167.3 = fadd contract float %add167.2, %mul120.3
  %29 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add167.3, <4 x float> zeroinitializer)
  %tiny_sum_out.sroa.0.0.vec.extract = extractelement <4 x float> %29, i64 0
  %cmp185 = fcmp contract ogt float %tiny_sum_out.sroa.0.0.vec.extract, 0.000000e+00
  %30 = tail call contract noundef float @llvm.log.f32(float %tiny_sum_out.sroa.0.0.vec.extract)
  %mul189 = fneg contract float %30
  %31 = tail call contract noundef float @llvm.exp.f32(float %mul189)
  %condval_1.0 = select i1 %cmp185, float %31, float 0.000000e+00
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %27, i64 0
  %mul202 = fmul contract float %condval_1.0, %out.sroa.0.0.vec.extract
  %out.sroa.0.0.vec.insert374 = insertelement <4 x float> poison, float %mul202, i64 0
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %27, i64 1
  %mul202.1 = fmul contract float %condval_1.0, %out.sroa.0.4.vec.extract
  %out.sroa.0.4.vec.insert379 = insertelement <4 x float> %out.sroa.0.0.vec.insert374, float %mul202.1, i64 1
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %27, i64 2
  %mul202.2 = fmul contract float %condval_1.0, %out.sroa.0.8.vec.extract
  %out.sroa.0.8.vec.insert384 = insertelement <4 x float> %out.sroa.0.4.vec.insert379, float %mul202.2, i64 2
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %27, i64 3
  %mul202.3 = fmul contract float %condval_1.0, %out.sroa.0.12.vec.extract
  %out.sroa.0.12.vec.insert389 = insertelement <4 x float> %out.sroa.0.8.vec.insert384, float %mul202.3, i64 3
  %out.sroa.20.16.vec.extract = extractelement <4 x float> %28, i64 0
  %mul202.4 = fmul contract float %condval_1.0, %out.sroa.20.16.vec.extract
  %out.sroa.20.16.vec.insert395 = insertelement <4 x float> poison, float %mul202.4, i64 0
  %out.sroa.20.20.vec.extract = extractelement <4 x float> %28, i64 1
  %mul202.5 = fmul contract float %condval_1.0, %out.sroa.20.20.vec.extract
  %out.sroa.20.20.vec.insert400 = insertelement <4 x float> %out.sroa.20.16.vec.insert395, float %mul202.5, i64 1
  %out.sroa.20.24.vec.extract = extractelement <4 x float> %28, i64 2
  %mul202.6 = fmul contract float %condval_1.0, %out.sroa.20.24.vec.extract
  %out.sroa.20.24.vec.insert405 = insertelement <4 x float> %out.sroa.20.20.vec.insert400, float %mul202.6, i64 2
  %out.sroa.20.28.vec.extract = extractelement <4 x float> %28, i64 3
  %mul202.7 = fmul contract float %condval_1.0, %out.sroa.20.28.vec.extract
  %out.sroa.20.28.vec.insert410 = insertelement <4 x float> %out.sroa.20.24.vec.insert405, float %mul202.7, i64 3
  br label %if.end208

if.end208:                                        ; preds = %entry.if.end208_crit_edge, %for.cond26.preheader
  %mul251.pre-phi = phi i32 [ %.pre413, %entry.if.end208_crit_edge ], [ %mul109, %for.cond26.preheader ]
  %out.sroa.20.0 = phi <4 x float> [ zeroinitializer, %entry.if.end208_crit_edge ], [ %out.sroa.20.28.vec.insert410, %for.cond26.preheader ]
  %out.sroa.0.0 = phi <4 x float> [ zeroinitializer, %entry.if.end208_crit_edge ], [ %out.sroa.0.12.vec.insert389, %for.cond26.preheader ]
  %out.sroa.0.0.vec.extract376 = extractelement <4 x float> %out.sroa.0.0, i64 0
  %32 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract376)
  %result.sroa.0.0.insert.ext = zext i16 %32 to i64
  %out.sroa.0.4.vec.extract381 = extractelement <4 x float> %out.sroa.0.0, i64 1
  %33 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract381)
  %result.sroa.0.2.insert.ext = zext i16 %33 to i64
  %result.sroa.0.2.insert.shift = shl nuw nsw i64 %result.sroa.0.2.insert.ext, 16
  %result.sroa.0.2.insert.insert = or disjoint i64 %result.sroa.0.2.insert.shift, %result.sroa.0.0.insert.ext
  %out.sroa.0.8.vec.extract386 = extractelement <4 x float> %out.sroa.0.0, i64 2
  %34 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract386)
  %result.sroa.0.4.insert.ext = zext i16 %34 to i64
  %result.sroa.0.4.insert.shift = shl nuw nsw i64 %result.sroa.0.4.insert.ext, 32
  %result.sroa.0.4.insert.insert = or disjoint i64 %result.sroa.0.2.insert.insert, %result.sroa.0.4.insert.shift
  %out.sroa.0.12.vec.extract391 = extractelement <4 x float> %out.sroa.0.0, i64 3
  %35 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract391)
  %result.sroa.0.6.insert.ext = zext i16 %35 to i64
  %result.sroa.0.6.insert.shift = shl nuw i64 %result.sroa.0.6.insert.ext, 48
  %result.sroa.0.6.insert.insert = or disjoint i64 %result.sroa.0.4.insert.insert, %result.sroa.0.6.insert.shift
  %out.sroa.20.16.vec.extract397 = extractelement <4 x float> %out.sroa.20.0, i64 0
  %36 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.20.16.vec.extract397)
  %result.sroa.7.8.insert.ext = zext i16 %36 to i64
  %out.sroa.20.20.vec.extract402 = extractelement <4 x float> %out.sroa.20.0, i64 1
  %37 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.20.20.vec.extract402)
  %result.sroa.7.10.insert.ext = zext i16 %37 to i64
  %result.sroa.7.10.insert.shift = shl nuw nsw i64 %result.sroa.7.10.insert.ext, 16
  %result.sroa.7.10.insert.insert = or disjoint i64 %result.sroa.7.10.insert.shift, %result.sroa.7.8.insert.ext
  %out.sroa.20.24.vec.extract407 = extractelement <4 x float> %out.sroa.20.0, i64 2
  %38 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.20.24.vec.extract407)
  %result.sroa.7.12.insert.ext = zext i16 %38 to i64
  %result.sroa.7.12.insert.shift = shl nuw nsw i64 %result.sroa.7.12.insert.ext, 32
  %result.sroa.7.12.insert.insert = or disjoint i64 %result.sroa.7.10.insert.insert, %result.sroa.7.12.insert.shift
  %out.sroa.20.28.vec.extract412 = extractelement <4 x float> %out.sroa.20.0, i64 3
  %39 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.20.28.vec.extract412)
  %result.sroa.7.14.insert.ext = zext i16 %39 to i64
  %result.sroa.7.14.insert.shift = shl nuw i64 %result.sroa.7.14.insert.ext, 48
  %result.sroa.7.14.insert.insert = or disjoint i64 %result.sroa.7.12.insert.insert, %result.sroa.7.14.insert.shift
  %add248 = add nuw nsw i32 %add, %mul251.pre-phi
  %40 = zext nneg i32 %add248 to i64
  %add.ptr254 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %40
  store i64 %result.sroa.0.6.insert.insert, ptr addrspace(1) %add.ptr254, align 8
  %41 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %40
  %add.ptr254.1 = getelementptr inbounds i8, ptr addrspace(1) %41, i64 32
  store i64 %result.sroa.7.14.insert.insert, ptr addrspace(1) %add.ptr254.1, align 8
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


