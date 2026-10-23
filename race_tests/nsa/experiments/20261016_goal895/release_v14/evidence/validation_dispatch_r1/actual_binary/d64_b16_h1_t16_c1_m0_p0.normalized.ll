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
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul = shl nsw i32 %0, 14
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul7 = shl nsw i32 %1, 10
  %add = add nuw nsw i32 %mul, %mul7
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %and = shl nuw nsw i32 %2, 6
  %mul9 = and i32 %and, 960
  %add10 = or disjoint i32 %add, %mul9
  %3 = lshr i32 %2, 1
  %mul14 = and i32 %3, 504
  %add12 = add nuw nsw i32 %add10, %mul14
  %4 = zext nneg i32 %add12 to i64
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16
  %Q_reg.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.4.0.add.ptr.sroa_idx, align 8
  %5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %5, i64 64
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16
  %Q_reg.sroa.7.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %5, i64 72
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.7.16.add.ptr.1.sroa_idx, align 8
  %mul20 = shl nsw i32 %0, 4
  %add22 = add nuw nsw i32 %mul20, %1
  %idxprom = zext nneg i32 %add22 to i64
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom
  %6 = load i32, ptr addrspace(1) %arrayidx, align 4, !tbaa !30
  %cmp38.not = icmp eq i32 %6, 0
  br i1 %cmp38.not, label %for.cond42.preheader, label %if.end345

for.cond42.preheader:                             ; preds = %entry
  %mul53 = shl nsw i32 %0, 10
  %add59 = or disjoint i32 %mul9, %mul53
  %add61 = add nuw nsw i32 %add59, %mul14
  %7 = zext nneg i32 %add61 to i64
  %add.ptr67 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %7
  %8 = load <4 x half>, ptr addrspace(4) %add.ptr67, align 16, !tbaa !30
  %condval.sroa.6.0.add.ptr67.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr67, i64 8
  %9 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr67.sroa_idx, align 8, !tbaa !30
  %10 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %7
  %add.ptr67.1 = getelementptr inbounds i8, ptr addrspace(4) %10, i64 64
  %11 = load <4 x half>, ptr addrspace(4) %add.ptr67.1, align 16, !tbaa !30
  %condval.sroa.6.0.add.ptr67.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %10, i64 72
  %12 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr67.sroa_idx.1, align 8, !tbaa !30
  %mul114 = shl nuw nsw i32 %2, 3
  %add110 = add nuw nsw i32 %mul114, %mul53
  %13 = zext nneg i32 %add110 to i64
  %cmp105 = icmp ult i32 %2, 128
  br i1 %cmp105, label %if.then106, label %if.end141

for.cond153.preheader:                            ; preds = %if.end141.1
  %14 = lshr i32 %2, 2
  %mul160 = and i32 %14, 252
  %cmp164.not = icmp ugt i32 %mul160, %1
  %spec.select = select i1 %cmp164.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert566 = insertelement <4 x float> poison, float %spec.select, i64 0
  %cmp164.not.1.not = icmp ult i32 %mul160, %1
  %spec.select.1 = select i1 %cmp164.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert579 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert566, float %spec.select.1, i64 1
  %add162.2 = or disjoint i32 %mul160, 2
  %cmp164.not.2 = icmp ugt i32 %add162.2, %1
  %spec.select.2 = select i1 %cmp164.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert592 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert579, float %spec.select.2, i64 2
  %add162.3 = or i32 %14, 3
  %cmp164.not.3 = icmp ugt i32 %add162.3, %1
  %spec.select.3 = select i1 %cmp164.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert605 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert592, float %spec.select.3, i64 3
  br label %if.end179

if.then106:                                       ; preds = %for.cond42.preheader
  %add.ptr117 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %13
  %condval_1.sroa.7.0.add.ptr117.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr117, i64 12
  %condval_1.sroa.6.0.add.ptr117.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr117, i64 8
  %condval_1.sroa.5.0.add.ptr117.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr117, i64 4
  %condval_1.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr117, align 16, !tbaa !30
  %condval_1.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr117.sroa_idx, align 4, !tbaa !30
  %condval_1.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr117.sroa_idx, align 8, !tbaa !30
  %condval_1.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr117.sroa_idx, align 4, !tbaa !30
  br label %if.end141

if.end141:                                        ; preds = %for.cond42.preheader, %if.then106
  %condval_1.sroa.0.0 = phi i32 [ %condval_1.sroa.0.0.copyload, %if.then106 ], [ 0, %for.cond42.preheader ]
  %condval_1.sroa.5.0 = phi i32 [ %condval_1.sroa.5.0.copyload, %if.then106 ], [ 0, %for.cond42.preheader ]
  %condval_1.sroa.6.0 = phi i32 [ %condval_1.sroa.6.0.copyload, %if.then106 ], [ 0, %for.cond42.preheader ]
  %condval_1.sroa.7.0 = phi i32 [ %condval_1.sroa.7.0.copyload, %if.then106 ], [ 0, %for.cond42.preheader ]
  %cmp105.1 = icmp ult i32 %2, 64
  br i1 %cmp105.1, label %if.then106.1, label %if.end141.1

if.then106.1:                                     ; preds = %if.end141
  %15 = or disjoint i64 %13, 512
  %add.ptr117.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %15
  %condval_1.sroa.7.0.add.ptr117.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr117.1, i64 12
  %condval_1.sroa.6.0.add.ptr117.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr117.1, i64 8
  %condval_1.sroa.5.0.add.ptr117.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr117.1, i64 4
  %condval_1.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr117.1, align 16, !tbaa !30
  %condval_1.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr117.sroa_idx.1, align 4, !tbaa !30
  %condval_1.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr117.sroa_idx.1, align 8, !tbaa !30
  %condval_1.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr117.sroa_idx.1, align 4, !tbaa !30
  br label %if.end141.1

if.end141.1:                                      ; preds = %if.then106.1, %if.end141
  %condval_1.sroa.0.0.1 = phi i32 [ %condval_1.sroa.0.0.copyload.1, %if.then106.1 ], [ 0, %if.end141 ]
  %condval_1.sroa.5.0.1 = phi i32 [ %condval_1.sroa.5.0.copyload.1, %if.then106.1 ], [ 0, %if.end141 ]
  %condval_1.sroa.6.0.1 = phi i32 [ %condval_1.sroa.6.0.copyload.1, %if.then106.1 ], [ 0, %if.end141 ]
  %condval_1.sroa.7.0.1 = phi i32 [ %condval_1.sroa.7.0.copyload.1, %if.then106.1 ], [ 0, %if.end141 ]
  %cmp151 = icmp ult i32 %1, 15
  br i1 %cmp151, label %for.cond153.preheader, label %if.end179

if.end179:                                        ; preds = %if.end141.1, %for.cond153.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert605, %for.cond153.preheader ], [ zeroinitializer, %if.end141.1 ]
  %16 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %8, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !call_argsrelate !66
  %17 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %9, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %16), !call_argsrelate !66
  %18 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %11, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %17), !call_argsrelate !66
  %19 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %12, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %18), !call_argsrelate !66
  %add.ptr222.idx = shl nuw nsw i32 %2, 4
  %invariant.gep = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr222.idx
  store i32 %condval_1.sroa.0.0, ptr addrspace(3) %invariant.gep, align 16, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 4
  store i32 %condval_1.sroa.5.0, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 8
  store i32 %condval_1.sroa.6.0, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 12
  store i32 %condval_1.sroa.7.0, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep.sroa_idx, align 4, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1024
  store i32 %condval_1.sroa.0.0.1, ptr addrspace(3) %gep.1, align 16, !tbaa !30
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1028
  store i32 %condval_1.sroa.5.0.1, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !tbaa !30
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1032
  store i32 %condval_1.sroa.6.0.1, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !tbaa !30
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1036
  store i32 %condval_1.sroa.7.0.1, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !tbaa !30
  %acc_s.sroa.0.0.vec.extract568 = extractelement <4 x float> %19, i64 0
  %mul232 = fmul contract float %acc_s.sroa.0.0.vec.extract568, 0x3FC2776C60000000
  %20 = tail call contract noundef float @llvm.minnum.f32(float %mul232, float 1.500000e+01)
  %cmp.i.i = fcmp contract olt float %20, -1.260000e+02
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00
  %add.i.i = fadd contract float %20, %cond.i.i
  %21 = tail call contract float @llvm.exp2.f32(float %add.i.i)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %cond2.i.i, %21
  %acc_s.sroa.0.4.vec.extract581 = extractelement <4 x float> %19, i64 1
  %mul232.1 = fmul contract float %acc_s.sroa.0.4.vec.extract581, 0x3FC2776C60000000
  %22 = tail call contract noundef float @llvm.minnum.f32(float %mul232.1, float 1.500000e+01)
  %cmp.i.i.1 = fcmp contract olt float %22, -1.260000e+02
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00
  %add.i.i.1 = fadd contract float %22, %cond.i.i.1
  %23 = tail call contract float @llvm.exp2.f32(float %add.i.i.1)
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %23
  %acc_s.sroa.0.8.vec.extract594 = extractelement <4 x float> %19, i64 2
  %mul232.2 = fmul contract float %acc_s.sroa.0.8.vec.extract594, 0x3FC2776C60000000
  %24 = tail call contract noundef float @llvm.minnum.f32(float %mul232.2, float 1.500000e+01)
  %cmp.i.i.2 = fcmp contract olt float %24, -1.260000e+02
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00
  %add.i.i.2 = fadd contract float %24, %cond.i.i.2
  %25 = tail call contract float @llvm.exp2.f32(float %add.i.i.2)
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %25
  %acc_s.sroa.0.12.vec.extract607 = extractelement <4 x float> %19, i64 3
  %mul232.3 = fmul contract float %acc_s.sroa.0.12.vec.extract607, 0x3FC2776C60000000
  %26 = tail call contract noundef float @llvm.minnum.f32(float %mul232.3, float 1.500000e+01)
  %cmp.i.i.3 = fcmp contract olt float %26, -1.260000e+02
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00
  %add.i.i.3 = fadd contract float %26, %cond.i.i.3
  %27 = tail call contract float @llvm.exp2.f32(float %add.i.i.3)
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %27
  %add248 = fadd contract float %mul.i.i, 0.000000e+00
  %add248.1 = fadd contract float %add248, %mul.i.i.1
  %add248.2 = fadd contract float %add248.1, %mul.i.i.2
  %add248.3 = fadd contract float %add248.2, %mul.i.i.3
  %28 = bitcast float %add248.3 to i32
  %29 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10
  %30 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %29) #10
  %xor.i.i = xor i32 %30, 32
  %31 = and i32 %30, -64
  %and.i.i = add nsw i32 %31, 64
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i
  %cond.i.i480 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %30
  %shl.i.i = shl i32 %cond.i.i480, 2
  %32 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %28)
  %33 = bitcast i32 %32 to float
  %add256 = fadd contract float %add248.3, %33
  %34 = bitcast float %add256 to i32
  %35 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10
  %36 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %35) #10
  %xor.i.i481 = xor i32 %36, 16
  %37 = and i32 %36, -64
  %and.i.i482 = add nsw i32 %37, 64
  %cmp.not.i.i483 = icmp slt i32 %xor.i.i481, %and.i.i482
  %cond.i.i484 = select i1 %cmp.not.i.i483, i32 %xor.i.i481, i32 %36
  %shl.i.i485 = shl i32 %cond.i.i484, 2
  %38 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i485, i32 %34)
  %39 = bitcast i32 %38 to float
  %add261 = fadd contract float %add256, %39
  %cmp264 = fcmp contract ogt float %add261, 0.000000e+00
  %div = fdiv contract float 1.000000e+00, %add261
  %condval_3.0 = select i1 %cmp264, float %div, float 0.000000e+00
  %mul277 = fmul contract float %condval_3.0, %mul.i.i
  %mul277.1 = fmul contract float %condval_3.0, %mul.i.i.1
  %mul277.2 = fmul contract float %condval_3.0, %mul.i.i.2
  %mul277.3 = fmul contract float %condval_3.0, %mul.i.i.3
  %40 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !123
  %41 = fptrunc float %mul277 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %40), !noalias !123
  %42 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !123
  %43 = fptrunc float %mul277.1 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %42), !noalias !123
  %__1.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %41, i64 0
  %__1.sroa.0.2.vec.insert = insertelement <4 x half> %__1.sroa.0.0.vec.insert, half %43, i64 1
  %44 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !137
  %45 = fptrunc float %mul277.2 to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %44), !noalias !137
  %46 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !137
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %46), !noalias !137
  %__1.sroa.0.4.vec.insert = insertelement <4 x half> %__1.sroa.0.2.vec.insert, half %45, i64 2
  fence syncscope("warp") release
  tail call void @llvm.mxc.barrier.warp()
  fence syncscope("warp") acquire
  %mul307 = and i32 %add.ptr222.idx, 16128
  %and313 = and i32 %2, 15
  %add314 = or disjoint i32 %mul307, %and313
  %arrayidx316 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314
  %47 = load half, ptr addrspace(3) %arrayidx316, align 2, !tbaa !156
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %47, i64 0
  %add309.1 = or disjoint i32 %mul307, %and313
  %add314.1 = or disjoint i32 %add309.1, 64
  %arrayidx316.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314.1
  %48 = load half, ptr addrspace(3) %arrayidx316.1, align 2, !tbaa !156
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %48, i64 1
  %add309.2 = or disjoint i32 %mul307, %and313
  %add314.2 = or disjoint i32 %add309.2, 128
  %arrayidx316.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314.2
  %49 = load half, ptr addrspace(3) %arrayidx316.2, align 2, !tbaa !156
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %49, i64 2
  %add309.3 = or disjoint i32 %mul307, %and313
  %add314.3 = or disjoint i32 %add309.3, 192
  %arrayidx316.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314.3
  %50 = load half, ptr addrspace(3) %arrayidx316.3, align 2, !tbaa !156
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %50, i64 3
  %add311.1543 = or disjoint i32 %mul307, %and313
  %add314.1544 = or disjoint i32 %add311.1543, 16
  %arrayidx316.1545 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314.1544
  %51 = load half, ptr addrspace(3) %arrayidx316.1545, align 2, !tbaa !156
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %51, i64 0
  %add311.1.1 = or disjoint i32 %mul307, %and313
  %add314.1.1 = or disjoint i32 %add311.1.1, 80
  %arrayidx316.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314.1.1
  %52 = load half, ptr addrspace(3) %arrayidx316.1.1, align 2, !tbaa !156
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %52, i64 1
  %add311.2.1 = or disjoint i32 %mul307, %and313
  %add314.2.1 = or disjoint i32 %add311.2.1, 144
  %arrayidx316.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314.2.1
  %53 = load half, ptr addrspace(3) %arrayidx316.2.1, align 2, !tbaa !156
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %53, i64 2
  %add311.3.1 = or disjoint i32 %mul307, %and313
  %add314.3.1 = or disjoint i32 %add311.3.1, 208
  %arrayidx316.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314.3.1
  %54 = load half, ptr addrspace(3) %arrayidx316.3.1, align 2, !tbaa !156
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %54, i64 3
  %add311.2547 = or disjoint i32 %mul307, %and313
  %add314.2548 = or disjoint i32 %add311.2547, 32
  %arrayidx316.2549 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314.2548
  %55 = load half, ptr addrspace(3) %arrayidx316.2549, align 2, !tbaa !156
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %55, i64 0
  %add311.1.2 = or disjoint i32 %mul307, %and313
  %add314.1.2 = or disjoint i32 %add311.1.2, 96
  %arrayidx316.1.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314.1.2
  %56 = load half, ptr addrspace(3) %arrayidx316.1.2, align 2, !tbaa !156
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %56, i64 1
  %add311.2.2 = or disjoint i32 %mul307, %and313
  %add314.2.2 = or disjoint i32 %add311.2.2, 160
  %arrayidx316.2.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314.2.2
  %57 = load half, ptr addrspace(3) %arrayidx316.2.2, align 2, !tbaa !156
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %57, i64 2
  %add311.3.2 = or disjoint i32 %mul307, %and313
  %add314.3.2 = or disjoint i32 %add311.3.2, 224
  %arrayidx316.3.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314.3.2
  %58 = load half, ptr addrspace(3) %arrayidx316.3.2, align 2, !tbaa !156
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %58, i64 3
  %add311.3551 = or disjoint i32 %mul307, %and313
  %add314.3552 = or disjoint i32 %add311.3551, 48
  %arrayidx316.3553 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314.3552
  %59 = load half, ptr addrspace(3) %arrayidx316.3553, align 2, !tbaa !156
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %59, i64 0
  %add311.1.3 = or disjoint i32 %mul307, %and313
  %add314.1.3 = or disjoint i32 %add311.1.3, 112
  %arrayidx316.1.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314.1.3
  %60 = load half, ptr addrspace(3) %arrayidx316.1.3, align 2, !tbaa !156
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %60, i64 1
  %add311.2.3 = or disjoint i32 %mul307, %and313
  %add314.2.3 = or disjoint i32 %add311.2.3, 176
  %arrayidx316.2.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314.2.3
  %61 = load half, ptr addrspace(3) %arrayidx316.2.3, align 2, !tbaa !156
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %61, i64 2
  %add311.3.3 = or disjoint i32 %add.ptr222.idx, %and313
  %add314.3.3 = or i32 %add311.3.3, 240
  %arrayidx316.3.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314.3.3
  %62 = load half, ptr addrspace(3) %arrayidx316.3.3, align 2, !tbaa !156
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %62, i64 3
  %63 = fptrunc float %mul277.3 to half
  %__1.sroa.0.6.vec.insert = insertelement <4 x half> %__1.sroa.0.4.vec.insert, half %63, i64 3
  %64 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %65 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %66 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  %67 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer)
  br label %if.end345

if.end345:                                        ; preds = %if.end179, %entry
  %acc_o.sroa.0.0 = phi <4 x float> [ %64, %if.end179 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.12.0 = phi <4 x float> [ %65, %if.end179 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.22.0 = phi <4 x float> [ %66, %if.end179 ], [ zeroinitializer, %entry ]
  %acc_o.sroa.32.0 = phi <4 x float> [ %67, %if.end179 ], [ zeroinitializer, %entry ]
  %68 = lshr i32 %2, 2
  %mul381 = and i32 %68, 252
  %add378 = add nuw nsw i32 %add10, %mul381
  %69 = zext nneg i32 %add378 to i64
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3
  %70 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !164
  %71 = fptrunc float %acc_o.sroa.0.0.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %70), !noalias !164
  %72 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !164
  %73 = fptrunc float %acc_o.sroa.0.4.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %72), !noalias !164
  %74 = bitcast half %71 to i16
  %75 = bitcast half %73 to i16
  %76 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !179
  %77 = fptrunc float %acc_o.sroa.0.8.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %76), !noalias !179
  %78 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !179
  %79 = fptrunc float %acc_o.sroa.0.12.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %78), !noalias !179
  %80 = bitcast half %77 to i16
  %81 = bitcast half %79 to i16
  %__2.sroa.6.0.insert.ext = zext i16 %81 to i64
  %__2.sroa.6.0.insert.shift = shl nuw i64 %__2.sroa.6.0.insert.ext, 48
  %__2.sroa.5.0.insert.ext = zext i16 %80 to i64
  %__2.sroa.5.0.insert.shift = shl nuw nsw i64 %__2.sroa.5.0.insert.ext, 32
  %__2.sroa.5.0.insert.insert = or disjoint i64 %__2.sroa.6.0.insert.shift, %__2.sroa.5.0.insert.shift
  %__2.sroa.4.0.insert.ext = zext i16 %75 to i64
  %__2.sroa.4.0.insert.shift = shl nuw nsw i64 %__2.sroa.4.0.insert.ext, 16
  %__2.sroa.4.0.insert.insert = or disjoint i64 %__2.sroa.5.0.insert.insert, %__2.sroa.4.0.insert.shift
  %__2.sroa.0.0.insert.ext = zext i16 %74 to i64
  %__2.sroa.0.0.insert.insert = or disjoint i64 %__2.sroa.4.0.insert.insert, %__2.sroa.0.0.insert.ext
  %add.ptr384 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %69
  store i64 %__2.sroa.0.0.insert.insert, ptr addrspace(1) %add.ptr384, align 8
  %acc_o.sroa.12.16.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 0
  %acc_o.sroa.12.20.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 1
  %acc_o.sroa.12.24.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 2
  %acc_o.sroa.12.28.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 3
  %82 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !164
  %83 = fptrunc float %acc_o.sroa.12.16.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %82), !noalias !164
  %84 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !164
  %85 = fptrunc float %acc_o.sroa.12.20.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %84), !noalias !164
  %86 = bitcast half %83 to i16
  %87 = bitcast half %85 to i16
  %88 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !179
  %89 = fptrunc float %acc_o.sroa.12.24.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %88), !noalias !179
  %90 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !179
  %91 = fptrunc float %acc_o.sroa.12.28.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %90), !noalias !179
  %92 = bitcast half %89 to i16
  %93 = bitcast half %91 to i16
  %__2.sroa.6.0.insert.ext.1 = zext i16 %93 to i64
  %__2.sroa.6.0.insert.shift.1 = shl nuw i64 %__2.sroa.6.0.insert.ext.1, 48
  %__2.sroa.5.0.insert.ext.1 = zext i16 %92 to i64
  %__2.sroa.5.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.1, 32
  %__2.sroa.5.0.insert.insert.1 = or disjoint i64 %__2.sroa.6.0.insert.shift.1, %__2.sroa.5.0.insert.shift.1
  %__2.sroa.4.0.insert.ext.1 = zext i16 %87 to i64
  %__2.sroa.4.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.1, 16
  %__2.sroa.4.0.insert.insert.1 = or disjoint i64 %__2.sroa.5.0.insert.insert.1, %__2.sroa.4.0.insert.shift.1
  %__2.sroa.0.0.insert.ext.1 = zext i16 %86 to i64
  %__2.sroa.0.0.insert.insert.1 = or disjoint i64 %__2.sroa.4.0.insert.insert.1, %__2.sroa.0.0.insert.ext.1
  %94 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %69
  %add.ptr384.1 = getelementptr inbounds i8, ptr addrspace(1) %94, i64 32
  store i64 %__2.sroa.0.0.insert.insert.1, ptr addrspace(1) %add.ptr384.1, align 8
  %acc_o.sroa.22.32.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 0
  %acc_o.sroa.22.36.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 1
  %acc_o.sroa.22.40.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 2
  %acc_o.sroa.22.44.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 3
  %95 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !164
  %96 = fptrunc float %acc_o.sroa.22.32.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %95), !noalias !164
  %97 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !164
  %98 = fptrunc float %acc_o.sroa.22.36.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %97), !noalias !164
  %99 = bitcast half %96 to i16
  %100 = bitcast half %98 to i16
  %101 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !179
  %102 = fptrunc float %acc_o.sroa.22.40.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %101), !noalias !179
  %103 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !179
  %104 = fptrunc float %acc_o.sroa.22.44.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %103), !noalias !179
  %105 = bitcast half %102 to i16
  %106 = bitcast half %104 to i16
  %__2.sroa.6.0.insert.ext.2 = zext i16 %106 to i64
  %__2.sroa.6.0.insert.shift.2 = shl nuw i64 %__2.sroa.6.0.insert.ext.2, 48
  %__2.sroa.5.0.insert.ext.2 = zext i16 %105 to i64
  %__2.sroa.5.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.2, 32
  %__2.sroa.5.0.insert.insert.2 = or disjoint i64 %__2.sroa.6.0.insert.shift.2, %__2.sroa.5.0.insert.shift.2
  %__2.sroa.4.0.insert.ext.2 = zext i16 %100 to i64
  %__2.sroa.4.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.2, 16
  %__2.sroa.4.0.insert.insert.2 = or disjoint i64 %__2.sroa.5.0.insert.insert.2, %__2.sroa.4.0.insert.shift.2
  %__2.sroa.0.0.insert.ext.2 = zext i16 %99 to i64
  %__2.sroa.0.0.insert.insert.2 = or disjoint i64 %__2.sroa.4.0.insert.insert.2, %__2.sroa.0.0.insert.ext.2
  %107 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %69
  %add.ptr384.2 = getelementptr inbounds i8, ptr addrspace(1) %107, i64 64
  store i64 %__2.sroa.0.0.insert.insert.2, ptr addrspace(1) %add.ptr384.2, align 8
  %acc_o.sroa.32.48.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 0
  %acc_o.sroa.32.52.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 1
  %acc_o.sroa.32.56.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 2
  %acc_o.sroa.32.60.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 3
  %108 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !164
  %109 = fptrunc float %acc_o.sroa.32.48.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %108), !noalias !164
  %110 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !164
  %111 = fptrunc float %acc_o.sroa.32.52.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %110), !noalias !164
  %112 = bitcast half %109 to i16
  %113 = bitcast half %111 to i16
  %114 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !179
  %115 = fptrunc float %acc_o.sroa.32.56.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %114), !noalias !179
  %116 = tail call i32 @llvm.mxc.gethwreg(i32 2177)
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !noalias !179
  %117 = fptrunc float %acc_o.sroa.32.60.vec.extract to half
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %116), !noalias !179
  %118 = bitcast half %115 to i16
  %119 = bitcast half %117 to i16
  %__2.sroa.6.0.insert.ext.3 = zext i16 %119 to i64
  %__2.sroa.6.0.insert.shift.3 = shl nuw i64 %__2.sroa.6.0.insert.ext.3, 48
  %__2.sroa.5.0.insert.ext.3 = zext i16 %118 to i64
  %__2.sroa.5.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.3, 32
  %__2.sroa.5.0.insert.insert.3 = or disjoint i64 %__2.sroa.6.0.insert.shift.3, %__2.sroa.5.0.insert.shift.3
  %__2.sroa.4.0.insert.ext.3 = zext i16 %113 to i64
  %__2.sroa.4.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.3, 16
  %__2.sroa.4.0.insert.insert.3 = or disjoint i64 %__2.sroa.5.0.insert.insert.3, %__2.sroa.4.0.insert.shift.3
  %__2.sroa.0.0.insert.ext.3 = zext i16 %112 to i64
  %__2.sroa.0.0.insert.insert.3 = or disjoint i64 %__2.sroa.4.0.insert.insert.3, %__2.sroa.0.0.insert.ext.3
  %120 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %69
  %add.ptr384.3 = getelementptr inbounds i8, ptr addrspace(1) %120, i64 96
  store i64 %__2.sroa.0.0.insert.insert.3, ptr addrspace(1) %add.ptr384.3, align 8
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


