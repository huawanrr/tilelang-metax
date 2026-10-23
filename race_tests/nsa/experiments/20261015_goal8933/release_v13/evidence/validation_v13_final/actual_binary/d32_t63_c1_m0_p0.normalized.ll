target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "mxc-metax-macahca"

%struct.__half = type { i16 }
%struct.mcDevMallocInfo.0 = type { i32, i32, ptr }

@V_shared = external protected local_unnamed_addr addrspace(3) global [0 x %struct.__half], align 1024
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

define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %BlockIndices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V.coerce) local_unnamed_addr #3 {
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
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16
  %Q_reg.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.4.0.add.ptr.sroa_idx, align 8
  %idxprom = zext nneg i32 %0 to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom
  %3 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cmp19 = icmp ugt i32 %3, 3
  %shr22 = lshr i32 %0, 4
  %cmp23.not = icmp ugt i32 %3, %shr22
  %or.cond484 = or i1 %cmp19, %cmp23.not
  br i1 %or.cond484, label %entry.if.end301_crit_edge, label %if.then

entry.if.end301_crit_edge:                        ; preds = %entry
  %.pre = lshr i32 %1, 2
  br label %if.end301

if.then:                                          ; preds = %entry
  %mul24 = shl nuw nsw i32 %3, 4
  %and26 = and i32 %1, 15
  %add27 = or disjoint i32 %mul24, %and26
  %cmp28 = icmp ult i32 %add27, 63
  br i1 %cmp28, label %if.then29, label %if.end

if.then29:                                        ; preds = %if.then
  %mul30 = shl nuw nsw i32 %3, 9
  %add34 = add nuw nsw i32 %mul9, %mul7
  %add38 = add nuw nsw i32 %add34, %mul30
  %idx.ext39 = zext nneg i32 %add38 to i64
  %add.ptr40 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext39
  %condval.sroa.6.0.add.ptr40.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr40, i64 8
  %4 = load <4 x half>, ptr addrspace(4) %add.ptr40, align 16, !tbaa !30
  %5 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr40.sroa_idx, align 8, !tbaa !30
  br label %if.end

if.end:                                           ; preds = %if.then, %if.then29
  %6 = phi <4 x half> [ %5, %if.then29 ], [ zeroinitializer, %if.then ]
  %7 = phi <4 x half> [ %4, %if.then29 ], [ zeroinitializer, %if.then ]
  %shr65 = lshr i32 %1, 2
  %add66 = add nuw nsw i32 %mul24, %shr65
  %cmp67 = icmp ult i32 %add66, 63
  br i1 %cmp67, label %if.then68, label %if.end98

if.then68:                                        ; preds = %if.end
  %mul69 = shl nuw nsw i32 %3, 9
  %mul71 = shl nuw nsw i32 %1, 3
  %add72 = add nuw nsw i32 %mul69, %mul71
  %idx.ext73 = zext nneg i32 %add72 to i64
  %add.ptr74 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idx.ext73
  %condval_1.sroa.7.0.add.ptr74.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr74, i64 12
  %condval_1.sroa.6.0.add.ptr74.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr74, i64 8
  %condval_1.sroa.5.0.add.ptr74.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr74, i64 4
  %condval_1.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr74, align 16, !tbaa !30
  %condval_1.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr74.sroa_idx, align 4, !tbaa !30
  %condval_1.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr74.sroa_idx, align 8, !tbaa !30
  %condval_1.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr74.sroa_idx, align 4, !tbaa !30
  br label %if.end98

if.end98:                                         ; preds = %if.end, %if.then68
  %condval_1.sroa.0.0 = phi i32 [ %condval_1.sroa.0.0.copyload, %if.then68 ], [ 0, %if.end ]
  %condval_1.sroa.5.0 = phi i32 [ %condval_1.sroa.5.0.copyload, %if.then68 ], [ 0, %if.end ]
  %condval_1.sroa.6.0 = phi i32 [ %condval_1.sroa.6.0.copyload, %if.then68 ], [ 0, %if.end ]
  %condval_1.sroa.7.0 = phi i32 [ %condval_1.sroa.7.0.copyload, %if.then68 ], [ 0, %if.end ]
  %add103 = or disjoint i32 %mul24, 15
  %cmp104 = icmp ult i32 %0, %add103
  br i1 %cmp104, label %for.cond106.preheader, label %if.end133

for.cond106.preheader:                            ; preds = %if.end98
  %mul114 = and i32 %shr65, 252
  %add115 = add nuw nsw i32 %mul24, %mul114
  %cmp118.not = icmp ugt i32 %add115, %0
  %spec.select = select i1 %cmp118.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert500 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp118.not.1.not = icmp ult i32 %add115, %0
  %spec.select.1 = select i1 %cmp118.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert513 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert500, float %spec.select.1, i64 1
  %add116.2 = or disjoint i32 %add115, 2
  %cmp118.not.2 = icmp ugt i32 %add116.2, %0
  %spec.select.2 = select i1 %cmp118.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert526 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert513, float %spec.select.2, i64 2
  %add116.3 = or disjoint i32 %add115, 3
  %cmp118.not.3 = icmp ugt i32 %add116.3, %0
  %spec.select.3 = select i1 %cmp118.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert539 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert526, float %spec.select.3, i64 3
  br label %if.end133

if.end133:                                        ; preds = %if.end98, %for.cond106.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert539, %for.cond106.preheader ], [ zeroinitializer, %if.end98 ]
  %8 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %7, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !call_argsrelate !81
  %9 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %6, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %8), !call_argsrelate !81
  %10 = shl nuw nsw i32 %1, 3
  %mul156 = and i32 %10, 8160
  %xor = xor i32 %10, %1
  %mul162 = and i32 %xor, 24
  %add163 = or disjoint i32 %mul162, %mul156
  %add.ptr165 = getelementptr inbounds %struct.__half, ptr addrspace(3) @V_shared, i32 %add163
  store i32 %condval_1.sroa.0.0, ptr addrspace(3) %add.ptr165, align 16, !tbaa !30
  %V_reg.sroa.4.0.add.ptr165.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr165, i32 4
  store i32 %condval_1.sroa.5.0, ptr addrspace(3) %V_reg.sroa.4.0.add.ptr165.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.5.0.add.ptr165.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr165, i32 8
  store i32 %condval_1.sroa.6.0, ptr addrspace(3) %V_reg.sroa.5.0.add.ptr165.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.6.0.add.ptr165.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr165, i32 12
  store i32 %condval_1.sroa.7.0, ptr addrspace(3) %V_reg.sroa.6.0.add.ptr165.sroa_idx, align 4, !tbaa !30
  %acc_s.sroa.0.0.vec.extract502 = extractelement <4 x float> %9, i64 0
  %mul173 = fmul contract float %acc_s.sroa.0.0.vec.extract502, 0x3FC2776C60000000
  %11 = tail call contract noundef float @llvm.minnum.f32(float %mul173, float 1.500000e+01)
  %cmp.i.i = fcmp contract olt float %11, -1.260000e+02
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00
  %add.i.i = fadd contract float %11, %cond.i.i
  %12 = tail call contract float @llvm.exp2.f32(float %add.i.i)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %cond2.i.i, %12
  %acc_s.sroa.0.4.vec.extract515 = extractelement <4 x float> %9, i64 1
  %mul173.1 = fmul contract float %acc_s.sroa.0.4.vec.extract515, 0x3FC2776C60000000
  %13 = tail call contract noundef float @llvm.minnum.f32(float %mul173.1, float 1.500000e+01)
  %cmp.i.i.1 = fcmp contract olt float %13, -1.260000e+02
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i.1 = fadd contract float %13, %cond.i.i.1
  %14 = tail call contract float @llvm.exp2.f32(float %add.i.i.1)
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %14
  %acc_s.sroa.0.8.vec.extract528 = extractelement <4 x float> %9, i64 2
  %mul173.2 = fmul contract float %acc_s.sroa.0.8.vec.extract528, 0x3FC2776C60000000
  %15 = tail call contract noundef float @llvm.minnum.f32(float %mul173.2, float 1.500000e+01)
  %cmp.i.i.2 = fcmp contract olt float %15, -1.260000e+02
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00
  %add.i.i.2 = fadd contract float %15, %cond.i.i.2
  %16 = tail call contract float @llvm.exp2.f32(float %add.i.i.2)
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %16
  %acc_s.sroa.0.12.vec.extract541 = extractelement <4 x float> %9, i64 3
  %mul173.3 = fmul contract float %acc_s.sroa.0.12.vec.extract541, 0x3FC2776C60000000
  %17 = tail call contract noundef float @llvm.minnum.f32(float %mul173.3, float 1.500000e+01)
  %cmp.i.i.3 = fcmp contract olt float %17, -1.260000e+02
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00
  %add.i.i.3 = fadd contract float %17, %cond.i.i.3
  %18 = tail call contract float @llvm.exp2.f32(float %add.i.i.3)
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %18
  %add190 = fadd contract float %mul.i.i, 0.000000e+00
  %add190.1 = fadd contract float %add190, %mul.i.i.1
  %add190.2 = fadd contract float %add190.1, %mul.i.i.2
  %add190.3 = fadd contract float %add190.2, %mul.i.i.3
  %19 = bitcast float %add190.3 to i32
  %20 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10
  %21 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %20) #10
  %xor.i.i = xor i32 %21, 32
  %22 = and i32 %21, -64
  %and.i.i = add nsw i32 %22, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i441 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %21
  %shl.i.i = shl i32 %cond.i.i441, 2
  %23 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %19)
  %24 = bitcast i32 %23 to float
  %add198 = fadd contract float %add190.3, %24
  %25 = bitcast float %add198 to i32
  %26 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10
  %27 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %26) #10
  %xor.i.i442 = xor i32 %27, 16
  %28 = and i32 %27, -64
  %and.i.i443 = add nsw i32 %28, 64
  %cmp.not.i.i444 = icmp slt i32 %xor.i.i442, %and.i.i443
  %cond.i.i445 = select i1 %cmp.not.i.i444, i32 %xor.i.i442, i32 %27
  %shl.i.i446 = shl i32 %cond.i.i445, 2
  %29 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i446, i32 %25)
  %30 = bitcast i32 %29 to float
  %add203 = fadd contract float %add198, %30
  %cmp206 = fcmp contract ogt float %add203, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add203
  %condval_3.0 = select i1 %cmp206, float %div, float 0.000000e+00
  %mul220 = fmul contract float %condval_3.0, %mul.i.i
  %mul220.1 = fmul contract float %condval_3.0, %mul.i.i.1
  %mul220.2 = fmul contract float %condval_3.0, %mul.i.i.2
  %mul220.3 = fmul contract float %condval_3.0, %mul.i.i.3
  %31 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !140
  %32 = fptrunc float %mul220 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %31), !noalias !140
  %33 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !140
  %34 = fptrunc float %mul220.1 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %33), !noalias !140
  %__1.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %32, i64 0
  %__1.sroa.0.2.vec.insert = insertelement <4 x half> %__1.sroa.0.0.vec.insert, half %34, i64 1
  %35 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !154
  %36 = fptrunc float %mul220.2 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %35), !noalias !154
  %37 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !154
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %37), !noalias !154
  %__1.sroa.0.4.vec.insert = insertelement <4 x half> %__1.sroa.0.2.vec.insert, half %36, i64 2
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul251 = and i32 %10, 8064
  %and256 = lshr i32 %1, 3
  %shr257 = and i32 %and256, 1
  %mul262 = and i32 %and256, 2
  %and269 = and i32 %1, 7
  %mul266 = and i32 %1, 24
  %add267 = or disjoint i32 %mul266, %mul251
  %add270 = or disjoint i32 %add267, %and269
  %arrayidx272 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add270
  %38 = load half, ptr addrspace(3) %arrayidx272, align 2, !tbaa !175
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %38, i64 0
  %add253.1 = or disjoint i32 %mul251, 32
  %add267.1 = or disjoint i32 %mul266, %add253.1
  %add270.1 = or disjoint i32 %add267.1, %and269
  %arrayidx272.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add270.1
  %39 = load half, ptr addrspace(3) %arrayidx272.1, align 2, !tbaa !175
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %39, i64 1
  %add253.2 = or disjoint i32 %mul251, 64
  %add264.2 = or disjoint i32 %mul262, 1
  %xor265.2 = xor i32 %add264.2, %shr257
  %mul266.2 = shl nuw nsw i32 %xor265.2, 3
  %add267.2 = or disjoint i32 %mul266.2, %add253.2
  %add270.2 = or disjoint i32 %add267.2, %and269
  %arrayidx272.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add270.2
  %40 = load half, ptr addrspace(3) %arrayidx272.2, align 2, !tbaa !175
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %40, i64 2
  %add253.3 = or disjoint i32 %mul251, 96
  %add267.3 = or disjoint i32 %mul266.2, %add253.3
  %add270.3 = or disjoint i32 %add267.3, %and269
  %arrayidx272.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add270.3
  %41 = load half, ptr addrspace(3) %arrayidx272.3, align 2, !tbaa !175
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %41, i64 3
  %add258.1 = or disjoint i32 %shr257, 2
  %xor265.1485 = xor i32 %mul262, %add258.1
  %mul266.1486 = shl nuw nsw i32 %xor265.1485, 3
  %add267.1487 = or disjoint i32 %mul266.1486, %mul251
  %add270.1488 = or disjoint i32 %add267.1487, %and269
  %arrayidx272.1489 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add270.1488
  %42 = load half, ptr addrspace(3) %arrayidx272.1489, align 2, !tbaa !175
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %42, i64 0
  %add267.1.1 = or disjoint i32 %mul266.1486, %add253.1
  %add270.1.1 = or disjoint i32 %add267.1.1, %and269
  %arrayidx272.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add270.1.1
  %43 = load half, ptr addrspace(3) %arrayidx272.1.1, align 2, !tbaa !175
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %43, i64 1
  %xor265.2.1 = xor i32 %add264.2, %add258.1
  %mul266.2.1 = shl nuw nsw i32 %xor265.2.1, 3
  %add267.2.1 = or disjoint i32 %mul266.2.1, %add253.2
  %add270.2.1 = or disjoint i32 %add267.2.1, %and269
  %arrayidx272.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add270.2.1
  %44 = load half, ptr addrspace(3) %arrayidx272.2.1, align 2, !tbaa !175
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %44, i64 2
  %add267.3.1 = or disjoint i32 %mul266.2.1, %add253.3
  %add270.3.1 = or disjoint i32 %add267.3.1, %and269
  %arrayidx272.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add270.3.1
  %45 = load half, ptr addrspace(3) %arrayidx272.3.1, align 2, !tbaa !175
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %45, i64 3
  %46 = fptrunc float %mul220.3 to half
  %__1.sroa.0.6.vec.insert = insertelement <4 x half> %__1.sroa.0.4.vec.insert, half %46, i64 3
  %47 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %48 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  br label %if.end301

if.end301:                                        ; preds = %entry.if.end301_crit_edge, %if.end133
  %.pre-phi = phi i32 [ %.pre, %entry.if.end301_crit_edge ], [ %shr65, %if.end133 ]
  %acc_o.sroa.12.0 = phi <4 x float> [ zeroinitializer, %entry.if.end301_crit_edge ], [ %48, %if.end133 ]
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %entry.if.end301_crit_edge ], [ %47, %if.end133 ]
  %mul334 = and i32 %.pre-phi, 252
  %add331 = add nuw nsw i32 %add, %mul334
  %49 = zext nneg i32 %add331 to i64
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3
  %50 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !186
  %51 = fptrunc float %acc_o.sroa.0.0.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %50), !noalias !186
  %52 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !186
  %53 = fptrunc float %acc_o.sroa.0.4.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %52), !noalias !186
  %54 = bitcast half %51 to i16
  %55 = bitcast half %53 to i16
  %56 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !201
  %57 = fptrunc float %acc_o.sroa.0.8.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %56), !noalias !201
  %58 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !201
  %59 = fptrunc float %acc_o.sroa.0.12.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %58), !noalias !201
  %60 = bitcast half %57 to i16
  %61 = bitcast half %59 to i16
  %__2.sroa.6.0.insert.ext = zext i16 %61 to i64
  %__2.sroa.6.0.insert.shift = shl nuw i64 %__2.sroa.6.0.insert.ext, 48
  %__2.sroa.5.0.insert.ext = zext i16 %60 to i64
  %__2.sroa.5.0.insert.shift = shl nuw nsw i64 %__2.sroa.5.0.insert.ext, 32
  %__2.sroa.5.0.insert.insert = or disjoint i64 %__2.sroa.6.0.insert.shift, %__2.sroa.5.0.insert.shift
  %__2.sroa.4.0.insert.ext = zext i16 %55 to i64
  %__2.sroa.4.0.insert.shift = shl nuw nsw i64 %__2.sroa.4.0.insert.ext, 16
  %__2.sroa.4.0.insert.insert = or disjoint i64 %__2.sroa.5.0.insert.insert, %__2.sroa.4.0.insert.shift
  %__2.sroa.0.0.insert.ext = zext i16 %54 to i64
  %__2.sroa.0.0.insert.insert = or disjoint i64 %__2.sroa.4.0.insert.insert, %__2.sroa.0.0.insert.ext
  %add.ptr337 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %49
  store i64 %__2.sroa.0.0.insert.insert, ptr addrspace(1) %add.ptr337, align 8
  %acc_o.sroa.12.16.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 0
  %acc_o.sroa.12.20.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 1
  %acc_o.sroa.12.24.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 2
  %acc_o.sroa.12.28.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 3
  %62 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !186
  %63 = fptrunc float %acc_o.sroa.12.16.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %62), !noalias !186
  %64 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !186
  %65 = fptrunc float %acc_o.sroa.12.20.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %64), !noalias !186
  %66 = bitcast half %63 to i16
  %67 = bitcast half %65 to i16
  %68 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !201
  %69 = fptrunc float %acc_o.sroa.12.24.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %68), !noalias !201
  %70 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !201
  %71 = fptrunc float %acc_o.sroa.12.28.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %70), !noalias !201
  %72 = bitcast half %69 to i16
  %73 = bitcast half %71 to i16
  %__2.sroa.6.0.insert.ext.1 = zext i16 %73 to i64
  %__2.sroa.6.0.insert.shift.1 = shl nuw i64 %__2.sroa.6.0.insert.ext.1, 48
  %__2.sroa.5.0.insert.ext.1 = zext i16 %72 to i64
  %__2.sroa.5.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.1, 32
  %__2.sroa.5.0.insert.insert.1 = or disjoint i64 %__2.sroa.6.0.insert.shift.1, %__2.sroa.5.0.insert.shift.1
  %__2.sroa.4.0.insert.ext.1 = zext i16 %67 to i64
  %__2.sroa.4.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.1, 16
  %__2.sroa.4.0.insert.insert.1 = or disjoint i64 %__2.sroa.5.0.insert.insert.1, %__2.sroa.4.0.insert.shift.1
  %__2.sroa.0.0.insert.ext.1 = zext i16 %66 to i64
  %__2.sroa.0.0.insert.insert.1 = or disjoint i64 %__2.sroa.4.0.insert.insert.1, %__2.sroa.0.0.insert.ext.1
  %74 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %49
  %add.ptr337.1 = getelementptr inbounds i8, ptr addrspace(1) %74, i64 32
  store i64 %__2.sroa.0.0.insert.insert.1, ptr addrspace(1) %add.ptr337.1, align 8
  ret void
}

declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

declare i32 @llvm.mxc.block.id.x() #5

declare i32 @llvm.mxc.block.id.y() #5

declare i32 @llvm.mxc.block.id.z() #5

declare i32 @llvm.mxc.thread.id.x() #5

declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

declare void @llvm.mxc.barrier.warp() #6

declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

declare i1 @llvm.mxc.is.private(ptr nocapture) #5

declare void @llvm.mxc.sleep(i32 immarg) #7

declare float @llvm.exp2.f32(float) #8

declare i32 @llvm.mxc.gethwreg(i32 immarg) #9

declare void @llvm.mxc.sethwreg(i32 immarg, i32) #7

declare float @llvm.minnum.f32(float, float) #8

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { convergent nounwind willreturn }
attributes #7 = { nounwind willreturn }
attributes #8 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #9 = { nounwind speculatable willreturn memory(inaccessiblemem: read) }
attributes #10 = { nomerge }


