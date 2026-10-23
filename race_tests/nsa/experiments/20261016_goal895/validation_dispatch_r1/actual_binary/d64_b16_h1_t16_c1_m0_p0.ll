; ModuleID = '/data/tilelang-metax/race_tests/nsa/experiments/20261016_goal895/validation_dispatch_r1/actual_binary/d64_b16_h1_t16_c1_m0_p0.bc'
source_filename = "/tmp/tmpgl68rqyx/tvm_kernels.maca"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "mxc-metax-macahca"

%struct.__half = type { i16 }
%struct.mcDevMallocInfo.0 = type { i32, i32, ptr }

@V_shared = external protected local_unnamed_addr addrspace(3) global [0 x %struct.__half], align 1024
@mcDeviceMemoryInfo = weak protected addrspace(1) externally_initialized global [1 x %struct.mcDevMallocInfo.0] zeroinitializer, align 8
@llvm.compiler.used = appending addrspace(1) global [1 x ptr] [ptr addrspacecast (ptr addrspace(1) @mcDeviceMemoryInfo to ptr)], section "llvm.metadata"

; Function Attrs: mustprogress noreturn nounwind
define weak void @__cxa_pure_virtual() local_unnamed_addr #0 !dbg !5 {
entry:
  tail call void @llvm.trap(), !dbg !9
  unreachable, !dbg !10
}

; Function Attrs: cold noreturn nounwind memory(inaccessiblemem: write)
declare void @llvm.trap() #1

; Function Attrs: mustprogress noreturn nounwind
define weak void @__cxa_deleted_virtual() local_unnamed_addr #0 !dbg !11 {
entry:
  tail call void @llvm.trap(), !dbg !12
  unreachable, !dbg !13
}

; Function Attrs: mustprogress nounwind
define weak protected void @__mcImplicitDeviceSynchronize() local_unnamed_addr #2 !dbg !14 {
entry:
  %0 = tail call ptr addrspace(4) @llvm.mxc.implicitarg.ptr(), !dbg !16
  %arrayidx.i.i = getelementptr inbounds i8, ptr addrspace(4) %0, i64 32, !dbg !16
  %1 = load i64, ptr addrspace(4) %arrayidx.i.i, align 8, !dbg !16, !tbaa !17
  %2 = inttoptr i64 %1 to ptr, !dbg !16
  %arrayidx.i32.i = getelementptr inbounds i8, ptr addrspace(4) %0, i64 40, !dbg !16
  %3 = load i64, ptr addrspace(4) %arrayidx.i32.i, align 8, !dbg !16, !tbaa !17
  %4 = inttoptr i64 %3 to ptr, !dbg !16
  %current_counter.i = getelementptr inbounds i8, ptr %4, i64 12, !dbg !16
  %thread_counter.i = getelementptr inbounds i8, ptr %4, i64 16, !dbg !16
  %5 = load ptr, ptr %thread_counter.i, align 8, !dbg !16, !tbaa !21
  %cmp.not.i = icmp eq ptr %5, null, !dbg !16
  br i1 %cmp.not.i, label %if.end.i, label %if.then.i, !dbg !16

if.then.i:                                        ; preds = %entry
  %6 = tail call align 4 dereferenceable(64) ptr addrspace(4) @llvm.mxc.dispatch.ptr(), !dbg !16
  %7 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 12, !dbg !16
  %8 = load i32, ptr addrspace(4) %7, align 4, !dbg !16, !range !28, !invariant.load !8
  %9 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 4, !dbg !16
  %10 = load i32, ptr addrspace(4) %9, align 4, !dbg !16, !invariant.load !8
  %conv.i14.i.i = and i32 %10, 65535, !dbg !16
  %div.i15.i.i = udiv i32 %8, %conv.i14.i.i, !dbg !16
  %mul.i16.i.i = mul i32 %div.i15.i.i, %conv.i14.i.i, !dbg !16
  %cmp.i17.i.i = icmp ugt i32 %8, %mul.i16.i.i, !dbg !16
  %conv2.i18.i.i = zext i1 %cmp.i17.i.i to i32, !dbg !16
  %add.i19.i.i = add nuw i32 %div.i15.i.i, %conv2.i18.i.i, !dbg !16
  %11 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 16, !dbg !16
  %12 = load i32, ptr addrspace(4) %11, align 4, !dbg !16, !range !28, !invariant.load !8
  %13 = lshr i32 %10, 16, !dbg !16
  %div.i.i.i = udiv i32 %12, %13, !dbg !16
  %mul.i.i.i = mul i32 %div.i.i.i, %13, !dbg !16
  %cmp.i.i.i = icmp ugt i32 %12, %mul.i.i.i, !dbg !16
  %conv2.i.i.i = zext i1 %cmp.i.i.i to i32, !dbg !16
  %add.i.i.i = add nuw i32 %div.i.i.i, %conv2.i.i.i, !dbg !16
  %14 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !dbg !16, !range !29
  %mul.i.i = mul i32 %add.i.i.i, %14, !dbg !16
  %15 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !dbg !16, !range !29
  %mul320.i.i = add i32 %mul.i.i, %15, !dbg !16
  %add.i.i = mul i32 %mul320.i.i, %add.i19.i.i, !dbg !16
  %16 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !dbg !16, !range !29
  %add8.i.i = add i32 %add.i.i, %16, !dbg !16
  %conv.i.i = zext i32 %add8.i.i to i64, !dbg !16
  %arrayidx.i = getelementptr inbounds i32, ptr %5, i64 %conv.i.i, !dbg !16
  %17 = tail call i1 @llvm.mxc.is.private(ptr nonnull %arrayidx.i), !dbg !16
  br label %while.cond.i, !dbg !16

while.cond.i:                                     ; preds = %while.body.i, %if.then.i
  br i1 %17, label %if.then.i.i, label %if.end.i.i, !dbg !16

if.then.i.i:                                      ; preds = %while.cond.i
  %18 = load i32, ptr %arrayidx.i, align 4, !dbg !16, !tbaa !30
  br label %_Z9atomicAddPii.exit.i, !dbg !16

if.end.i.i:                                       ; preds = %while.cond.i
  %19 = atomicrmw or ptr %arrayidx.i, i32 0 syncscope("device-one-as") monotonic, align 4, !dbg !16
  br label %_Z9atomicAddPii.exit.i, !dbg !16

_Z9atomicAddPii.exit.i:                           ; preds = %if.end.i.i, %if.then.i.i
  %retval.0.i.i = phi i32 [ %18, %if.then.i.i ], [ %19, %if.end.i.i ], !dbg !16
  %cmp6.i = icmp sgt i32 %retval.0.i.i, 0, !dbg !16
  br i1 %cmp6.i, label %while.body.i, label %if.end.i, !dbg !16

while.body.i:                                     ; preds = %_Z9atomicAddPii.exit.i
  tail call void @llvm.mxc.sleep(i32 1), !dbg !16
  br label %while.cond.i, !dbg !16, !llvm.loop !31

if.end.i:                                         ; preds = %_Z9atomicAddPii.exit.i, %entry
  %20 = tail call i1 @llvm.mxc.is.private(ptr nonnull %current_counter.i), !dbg !16
  br i1 %20, label %if.then.i36.i, label %if.end.i34.i, !dbg !16

if.then.i36.i:                                    ; preds = %if.end.i
  %21 = load i32, ptr %current_counter.i, align 4, !dbg !16, !tbaa !30
  %add.i37.i = add nsw i32 %21, -1, !dbg !16
  store i32 %add.i37.i, ptr %current_counter.i, align 4, !dbg !16, !tbaa !30
  br label %_Z9atomicAddPii.exit38.i, !dbg !16

if.end.i34.i:                                     ; preds = %if.end.i
  %22 = atomicrmw add ptr %current_counter.i, i32 -1 syncscope("device-one-as") monotonic, align 4, !dbg !16
  br label %_Z9atomicAddPii.exit38.i, !dbg !16

_Z9atomicAddPii.exit38.i:                         ; preds = %if.end.i34.i, %if.then.i36.i
  %retval.0.i35.i = phi i32 [ %21, %if.then.i36.i ], [ %22, %if.end.i34.i ], !dbg !16
  %call_deep.i = getelementptr inbounds i8, ptr %4, i64 4, !dbg !16
  %23 = load i32, ptr %call_deep.i, align 4, !dbg !16, !tbaa !33
  %cmp8.i = icmp eq i32 %23, 0, !dbg !16
  br i1 %cmp8.i, label %if.then9.i, label %if.else.i, !dbg !16

if.then9.i:                                       ; preds = %_Z9atomicAddPii.exit38.i
  %cmp10.i = icmp slt i32 %retval.0.i35.i, 2, !dbg !16
  br i1 %cmp10.i, label %if.then11.i, label %__mcImplicitDeviceSynchronizeImpl.exit, !dbg !16

if.then11.i:                                      ; preds = %if.then9.i
  tail call void @llvm.mxc.sleep(i32 30), !dbg !16
  br label %__mcImplicitDeviceSynchronizeImpl.exit, !dbg !16

if.else.i:                                        ; preds = %_Z9atomicAddPii.exit38.i
  %parent_wrap13.i = getelementptr inbounds i8, ptr %4, i64 24, !dbg !16
  %24 = load ptr, ptr %parent_wrap13.i, align 8, !dbg !16, !tbaa !34
  %25 = load i32, ptr %4, align 8, !dbg !16, !tbaa !35
  %thread_counter15.i = getelementptr inbounds i8, ptr %24, i64 16, !dbg !16
  %26 = load ptr, ptr %thread_counter15.i, align 8, !dbg !16, !tbaa !21
  %idxprom.i = zext i32 %25 to i64, !dbg !16
  %arrayidx16.i = getelementptr inbounds i32, ptr %26, i64 %idxprom.i, !dbg !16
  %cmp17.i = icmp slt i32 %retval.0.i35.i, 2, !dbg !16
  br i1 %cmp17.i, label %if.then18.i, label %if.end20.i, !dbg !16

if.then18.i:                                      ; preds = %if.else.i
  %mqlwrap_slots.i = getelementptr inbounds i8, ptr %2, i64 24, !dbg !16
  %27 = load ptr, ptr %mqlwrap_slots.i, align 8, !dbg !16, !tbaa !36
  %sub.ptr.rhs.cast.i = ptrtoint ptr %27 to i64, !dbg !16
  %sub.ptr.sub.i = sub i64 %3, %sub.ptr.rhs.cast.i, !dbg !16
  %sub.ptr.div.i = sdiv exact i64 %sub.ptr.sub.i, 96, !dbg !16
  %mqlwrap_slot_mask.i = getelementptr inbounds i8, ptr %2, i64 80, !dbg !16
  %28 = load i64, ptr %mqlwrap_slot_mask.i, align 8, !dbg !16, !tbaa !38
  %29 = inttoptr i64 %28 to ptr, !dbg !16
  %idx.ext.i.i = and i64 %sub.ptr.div.i, 4294967295, !dbg !16
  %add.ptr.i.i = getelementptr inbounds i32, ptr %29, i64 %idx.ext.i.i, !dbg !16
  %30 = tail call i1 @llvm.mxc.is.private(ptr %add.ptr.i.i), !dbg !16
  br i1 %30, label %if.then.i.i.i, label %if.end.i.i.i, !dbg !16

if.then.i.i.i:                                    ; preds = %if.then18.i
  %31 = load i32, ptr %add.ptr.i.i, align 4, !dbg !16, !tbaa !30
  %and.i.i.i = and i32 %31, 2147483647, !dbg !16
  store i32 %and.i.i.i, ptr %add.ptr.i.i, align 4, !dbg !16, !tbaa !30
  br label %if.end20.i, !dbg !16

if.end.i.i.i:                                     ; preds = %if.then18.i
  %32 = atomicrmw and ptr %add.ptr.i.i, i32 2147483647 syncscope("device-one-as") monotonic, align 4, !dbg !16
  br label %if.end20.i, !dbg !16

if.end20.i:                                       ; preds = %if.end.i.i.i, %if.then.i.i.i, %if.else.i
  %33 = tail call i1 @llvm.mxc.is.private(ptr %arrayidx16.i), !dbg !16
  br i1 %33, label %if.then.i41.i, label %if.end.i39.i, !dbg !16

if.then.i41.i:                                    ; preds = %if.end20.i
  %34 = load i32, ptr %arrayidx16.i, align 4, !dbg !16, !tbaa !30
  %add.i42.i = add nsw i32 %34, -1, !dbg !16
  store i32 %add.i42.i, ptr %arrayidx16.i, align 4, !dbg !16, !tbaa !30
  br label %__mcImplicitDeviceSynchronizeImpl.exit, !dbg !16

if.end.i39.i:                                     ; preds = %if.end20.i
  %35 = atomicrmw add ptr %arrayidx16.i, i32 -1 syncscope("device-one-as") monotonic, align 4, !dbg !16
  br label %__mcImplicitDeviceSynchronizeImpl.exit, !dbg !16

__mcImplicitDeviceSynchronizeImpl.exit:           ; preds = %if.then9.i, %if.then11.i, %if.then.i41.i, %if.end.i39.i
  ret void, !dbg !39
}

; Function Attrs: convergent mustprogress norecurse nounwind willreturn
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %BlockIndices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V.coerce) local_unnamed_addr #3 !dbg !40 {
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
  %4 = zext nneg i32 %add12 to i64, !dbg !43
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4, !dbg !44
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16, !dbg !45
  %Q_reg.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !45
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.4.0.add.ptr.sroa_idx, align 8, !dbg !45
  %5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4, !dbg !44
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %5, i64 64, !dbg !44
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16, !dbg !45
  %Q_reg.sroa.7.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %5, i64 72, !dbg !45
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.7.16.add.ptr.1.sroa_idx, align 8, !dbg !45
  %mul20 = shl nsw i32 %0, 4, !dbg !46
  %add22 = add nuw nsw i32 %mul20, %1, !dbg !47
  %idxprom = zext nneg i32 %add22 to i64, !dbg !48
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom, !dbg !48
  %6 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !48, !tbaa !30
  %cmp38.not = icmp eq i32 %6, 0
  br i1 %cmp38.not, label %for.cond42.preheader, label %if.end345, !dbg !49

for.cond42.preheader:                             ; preds = %entry
  %mul53 = shl nsw i32 %0, 10
  %add59 = or disjoint i32 %mul9, %mul53
  %add61 = add nuw nsw i32 %add59, %mul14
  %7 = zext nneg i32 %add61 to i64, !dbg !50
  %add.ptr67 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %7, !dbg !51
  %8 = load <4 x half>, ptr addrspace(4) %add.ptr67, align 16, !dbg !52, !tbaa !30
  %condval.sroa.6.0.add.ptr67.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr67, i64 8, !dbg !52
  %9 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr67.sroa_idx, align 8, !dbg !52, !tbaa !30
  %10 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %7, !dbg !51
  %add.ptr67.1 = getelementptr inbounds i8, ptr addrspace(4) %10, i64 64, !dbg !51
  %11 = load <4 x half>, ptr addrspace(4) %add.ptr67.1, align 16, !dbg !52, !tbaa !30
  %condval.sroa.6.0.add.ptr67.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %10, i64 72, !dbg !52
  %12 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr67.sroa_idx.1, align 8, !dbg !52, !tbaa !30
  %mul114 = shl nuw nsw i32 %2, 3
  %add110 = add nuw nsw i32 %mul114, %mul53
  %13 = zext nneg i32 %add110 to i64, !dbg !53
  %cmp105 = icmp ult i32 %2, 128, !dbg !54
  br i1 %cmp105, label %if.then106, label %if.end141, !dbg !55

for.cond153.preheader:                            ; preds = %if.end141.1
  %14 = lshr i32 %2, 2
  %mul160 = and i32 %14, 252
  %cmp164.not = icmp ugt i32 %mul160, %1, !dbg !56
  %spec.select = select i1 %cmp164.not, float 0xFFF0000000000000, float 0.000000e+00, !dbg !57
  %acc_s.sroa.0.0.vec.insert566 = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !58
  %cmp164.not.1.not = icmp ult i32 %mul160, %1, !dbg !56
  %spec.select.1 = select i1 %cmp164.not.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !57
  %acc_s.sroa.0.4.vec.insert579 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert566, float %spec.select.1, i64 1, !dbg !58
  %add162.2 = or disjoint i32 %mul160, 2, !dbg !59
  %cmp164.not.2 = icmp ugt i32 %add162.2, %1, !dbg !56
  %spec.select.2 = select i1 %cmp164.not.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !57
  %acc_s.sroa.0.8.vec.insert592 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert579, float %spec.select.2, i64 2, !dbg !58
  %add162.3 = or i32 %14, 3, !dbg !59
  %cmp164.not.3 = icmp ugt i32 %add162.3, %1, !dbg !56
  %spec.select.3 = select i1 %cmp164.not.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !57
  %acc_s.sroa.0.12.vec.insert605 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert592, float %spec.select.3, i64 3, !dbg !58
  br label %if.end179

if.then106:                                       ; preds = %for.cond42.preheader
  %add.ptr117 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %13
  %condval_1.sroa.7.0.add.ptr117.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr117, i64 12
  %condval_1.sroa.6.0.add.ptr117.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr117, i64 8
  %condval_1.sroa.5.0.add.ptr117.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr117, i64 4
  %condval_1.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr117, align 16, !dbg !60, !tbaa !30
  %condval_1.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr117.sroa_idx, align 4, !dbg !60, !tbaa !30
  %condval_1.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr117.sroa_idx, align 8, !dbg !60, !tbaa !30
  %condval_1.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr117.sroa_idx, align 4, !dbg !60, !tbaa !30
  br label %if.end141, !dbg !61

if.end141:                                        ; preds = %for.cond42.preheader, %if.then106
  %condval_1.sroa.0.0 = phi i32 [ %condval_1.sroa.0.0.copyload, %if.then106 ], [ 0, %for.cond42.preheader ], !dbg !62
  %condval_1.sroa.5.0 = phi i32 [ %condval_1.sroa.5.0.copyload, %if.then106 ], [ 0, %for.cond42.preheader ], !dbg !62
  %condval_1.sroa.6.0 = phi i32 [ %condval_1.sroa.6.0.copyload, %if.then106 ], [ 0, %for.cond42.preheader ], !dbg !62
  %condval_1.sroa.7.0 = phi i32 [ %condval_1.sroa.7.0.copyload, %if.then106 ], [ 0, %for.cond42.preheader ], !dbg !62
  %cmp105.1 = icmp ult i32 %2, 64, !dbg !54
  br i1 %cmp105.1, label %if.then106.1, label %if.end141.1, !dbg !55

if.then106.1:                                     ; preds = %if.end141
  %15 = or disjoint i64 %13, 512
  %add.ptr117.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %15
  %condval_1.sroa.7.0.add.ptr117.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr117.1, i64 12
  %condval_1.sroa.6.0.add.ptr117.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr117.1, i64 8
  %condval_1.sroa.5.0.add.ptr117.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr117.1, i64 4
  %condval_1.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr117.1, align 16, !dbg !60, !tbaa !30
  %condval_1.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr117.sroa_idx.1, align 4, !dbg !60, !tbaa !30
  %condval_1.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr117.sroa_idx.1, align 8, !dbg !60, !tbaa !30
  %condval_1.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr117.sroa_idx.1, align 4, !dbg !60, !tbaa !30
  br label %if.end141.1, !dbg !61

if.end141.1:                                      ; preds = %if.then106.1, %if.end141
  %condval_1.sroa.0.0.1 = phi i32 [ %condval_1.sroa.0.0.copyload.1, %if.then106.1 ], [ 0, %if.end141 ], !dbg !62
  %condval_1.sroa.5.0.1 = phi i32 [ %condval_1.sroa.5.0.copyload.1, %if.then106.1 ], [ 0, %if.end141 ], !dbg !62
  %condval_1.sroa.6.0.1 = phi i32 [ %condval_1.sroa.6.0.copyload.1, %if.then106.1 ], [ 0, %if.end141 ], !dbg !62
  %condval_1.sroa.7.0.1 = phi i32 [ %condval_1.sroa.7.0.copyload.1, %if.then106.1 ], [ 0, %if.end141 ], !dbg !62
  %cmp151 = icmp ult i32 %1, 15, !dbg !63
  br i1 %cmp151, label %for.cond153.preheader, label %if.end179, !dbg !64

if.end179:                                        ; preds = %if.end141.1, %for.cond153.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert605, %for.cond153.preheader ], [ zeroinitializer, %if.end141.1 ], !dbg !62
  %16 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %8, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !dbg !65, !call_argsrelate !66
  %17 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %9, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %16), !dbg !65, !call_argsrelate !66
  %18 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %11, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %17), !dbg !65, !call_argsrelate !66
  %19 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %12, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %18), !dbg !65, !call_argsrelate !66
  %add.ptr222.idx = shl nuw nsw i32 %2, 4
  %invariant.gep = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr222.idx, !dbg !67
  store i32 %condval_1.sroa.0.0, ptr addrspace(3) %invariant.gep, align 16, !dbg !68, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 4, !dbg !68
  store i32 %condval_1.sroa.5.0, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep.sroa_idx, align 4, !dbg !68, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 8, !dbg !68
  store i32 %condval_1.sroa.6.0, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep.sroa_idx, align 8, !dbg !68, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 12, !dbg !68
  store i32 %condval_1.sroa.7.0, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep.sroa_idx, align 4, !dbg !68, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1024, !dbg !69
  store i32 %condval_1.sroa.0.0.1, ptr addrspace(3) %gep.1, align 16, !dbg !68, !tbaa !30
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1028, !dbg !68
  store i32 %condval_1.sroa.5.0.1, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !dbg !68, !tbaa !30
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1032, !dbg !68
  store i32 %condval_1.sroa.6.0.1, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !dbg !68, !tbaa !30
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1036, !dbg !68
  store i32 %condval_1.sroa.7.0.1, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !dbg !68, !tbaa !30
  %acc_s.sroa.0.0.vec.extract568 = extractelement <4 x float> %19, i64 0, !dbg !70
  %mul232 = fmul contract float %acc_s.sroa.0.0.vec.extract568, 0x3FC2776C60000000, !dbg !71
  %20 = tail call contract noundef float @llvm.minnum.f32(float %mul232, float 1.500000e+01), !dbg !72
  %cmp.i.i = fcmp contract olt float %20, -1.260000e+02, !dbg !76
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00, !dbg !76
  %add.i.i = fadd contract float %20, %cond.i.i, !dbg !76
  %21 = tail call contract float @llvm.exp2.f32(float %add.i.i), !dbg !76
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00, !dbg !76
  %mul.i.i = fmul contract float %cond2.i.i, %21, !dbg !76
  %acc_s.sroa.0.4.vec.extract581 = extractelement <4 x float> %19, i64 1, !dbg !70
  %mul232.1 = fmul contract float %acc_s.sroa.0.4.vec.extract581, 0x3FC2776C60000000, !dbg !71
  %22 = tail call contract noundef float @llvm.minnum.f32(float %mul232.1, float 1.500000e+01), !dbg !72
  %cmp.i.i.1 = fcmp contract olt float %22, -1.260000e+02, !dbg !76
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00, !dbg !76
  %add.i.i.1 = fadd contract float %22, %cond.i.i.1, !dbg !76
  %23 = tail call contract float @llvm.exp2.f32(float %add.i.i.1), !dbg !76
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !76
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %23, !dbg !76
  %acc_s.sroa.0.8.vec.extract594 = extractelement <4 x float> %19, i64 2, !dbg !70
  %mul232.2 = fmul contract float %acc_s.sroa.0.8.vec.extract594, 0x3FC2776C60000000, !dbg !71
  %24 = tail call contract noundef float @llvm.minnum.f32(float %mul232.2, float 1.500000e+01), !dbg !72
  %cmp.i.i.2 = fcmp contract olt float %24, -1.260000e+02, !dbg !76
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00, !dbg !76
  %add.i.i.2 = fadd contract float %24, %cond.i.i.2, !dbg !76
  %25 = tail call contract float @llvm.exp2.f32(float %add.i.i.2), !dbg !76
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00, !dbg !76
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %25, !dbg !76
  %acc_s.sroa.0.12.vec.extract607 = extractelement <4 x float> %19, i64 3, !dbg !70
  %mul232.3 = fmul contract float %acc_s.sroa.0.12.vec.extract607, 0x3FC2776C60000000, !dbg !71
  %26 = tail call contract noundef float @llvm.minnum.f32(float %mul232.3, float 1.500000e+01), !dbg !72
  %cmp.i.i.3 = fcmp contract olt float %26, -1.260000e+02, !dbg !76
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00, !dbg !76
  %add.i.i.3 = fadd contract float %26, %cond.i.i.3, !dbg !76
  %27 = tail call contract float @llvm.exp2.f32(float %add.i.i.3), !dbg !76
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00, !dbg !76
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %27, !dbg !76
  %add248 = fadd contract float %mul.i.i, 0.000000e+00, !dbg !79
  %add248.1 = fadd contract float %add248, %mul.i.i.1, !dbg !79
  %add248.2 = fadd contract float %add248.1, %mul.i.i.2, !dbg !79
  %add248.3 = fadd contract float %add248.2, %mul.i.i.3, !dbg !79
  %28 = bitcast float %add248.3 to i32, !dbg !80
  %29 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10, !dbg !84
  %30 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %29) #10, !dbg !89
  %xor.i.i = xor i32 %30, 32, !dbg !90
  %31 = and i32 %30, -64, !dbg !91
  %and.i.i = add nsw i32 %31, 64, !dbg !91
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !92
  %cond.i.i480 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %30, !dbg !93
  %shl.i.i = shl i32 %cond.i.i480, 2, !dbg !94
  %32 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %28), !dbg !95
  %33 = bitcast i32 %32 to float, !dbg !96
  %add256 = fadd contract float %add248.3, %33, !dbg !97
  %34 = bitcast float %add256 to i32, !dbg !98
  %35 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10, !dbg !100
  %36 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %35) #10, !dbg !103
  %xor.i.i481 = xor i32 %36, 16, !dbg !104
  %37 = and i32 %36, -64, !dbg !105
  %and.i.i482 = add nsw i32 %37, 64, !dbg !105
  %cmp.not.i.i483 = icmp slt i32 %xor.i.i481, %and.i.i482, !dbg !106
  %cond.i.i484 = select i1 %cmp.not.i.i483, i32 %xor.i.i481, i32 %36, !dbg !107
  %shl.i.i485 = shl i32 %cond.i.i484, 2, !dbg !108
  %38 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i485, i32 %34), !dbg !109
  %39 = bitcast i32 %38 to float, !dbg !110
  %add261 = fadd contract float %add256, %39, !dbg !111
  %cmp264 = fcmp contract ogt float %add261, 0.000000e+00, !dbg !112
  %div = fdiv contract float 1.000000e+00, %add261, !dbg !113
  %condval_3.0 = select i1 %cmp264, float %div, float 0.000000e+00, !dbg !113
  %mul277 = fmul contract float %condval_3.0, %mul.i.i, !dbg !114
  %mul277.1 = fmul contract float %condval_3.0, %mul.i.i.1, !dbg !114
  %mul277.2 = fmul contract float %condval_3.0, %mul.i.i.2, !dbg !114
  %mul277.3 = fmul contract float %condval_3.0, %mul.i.i.3, !dbg !114
  %40 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !115
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !115, !noalias !123
  %41 = fptrunc float %mul277 to half, !dbg !115
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %40), !dbg !115, !noalias !123
  %42 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !128
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !128, !noalias !123
  %43 = fptrunc float %mul277.1 to half, !dbg !128
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %42), !dbg !128, !noalias !123
  %__1.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %41, i64 0, !dbg !130
  %__1.sroa.0.2.vec.insert = insertelement <4 x half> %__1.sroa.0.0.vec.insert, half %43, i64 1, !dbg !130
  %44 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !133
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !133, !noalias !137
  %45 = fptrunc float %mul277.2 to half, !dbg !133
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %44), !dbg !133, !noalias !137
  %46 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !142
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !142, !noalias !137
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %46), !dbg !142, !noalias !137
  %__1.sroa.0.4.vec.insert = insertelement <4 x half> %__1.sroa.0.2.vec.insert, half %45, i64 2, !dbg !144
  fence syncscope("warp") release, !dbg !146
  tail call void @llvm.mxc.barrier.warp(), !dbg !151
  fence syncscope("warp") acquire, !dbg !152
  %mul307 = and i32 %add.ptr222.idx, 16128
  %and313 = and i32 %2, 15
  %add314 = or disjoint i32 %mul307, %and313, !dbg !153
  %arrayidx316 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314, !dbg !154
  %47 = load half, ptr addrspace(3) %arrayidx316, align 2, !dbg !155, !tbaa !156
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %47, i64 0, !dbg !155
  %add309.1 = or disjoint i32 %mul307, %and313, !dbg !153
  %add314.1 = or disjoint i32 %add309.1, 64, !dbg !153
  %arrayidx316.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314.1, !dbg !154
  %48 = load half, ptr addrspace(3) %arrayidx316.1, align 2, !dbg !155, !tbaa !156
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %48, i64 1, !dbg !155
  %add309.2 = or disjoint i32 %mul307, %and313, !dbg !153
  %add314.2 = or disjoint i32 %add309.2, 128, !dbg !153
  %arrayidx316.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314.2, !dbg !154
  %49 = load half, ptr addrspace(3) %arrayidx316.2, align 2, !dbg !155, !tbaa !156
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %49, i64 2, !dbg !155
  %add309.3 = or disjoint i32 %mul307, %and313, !dbg !153
  %add314.3 = or disjoint i32 %add309.3, 192, !dbg !153
  %arrayidx316.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314.3, !dbg !154
  %50 = load half, ptr addrspace(3) %arrayidx316.3, align 2, !dbg !155, !tbaa !156
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %50, i64 3, !dbg !155
  %add311.1543 = or disjoint i32 %mul307, %and313, !dbg !153
  %add314.1544 = or disjoint i32 %add311.1543, 16, !dbg !153
  %arrayidx316.1545 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314.1544, !dbg !154
  %51 = load half, ptr addrspace(3) %arrayidx316.1545, align 2, !dbg !155, !tbaa !156
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %51, i64 0, !dbg !155
  %add311.1.1 = or disjoint i32 %mul307, %and313, !dbg !153
  %add314.1.1 = or disjoint i32 %add311.1.1, 80, !dbg !153
  %arrayidx316.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314.1.1, !dbg !154
  %52 = load half, ptr addrspace(3) %arrayidx316.1.1, align 2, !dbg !155, !tbaa !156
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %52, i64 1, !dbg !155
  %add311.2.1 = or disjoint i32 %mul307, %and313, !dbg !153
  %add314.2.1 = or disjoint i32 %add311.2.1, 144, !dbg !153
  %arrayidx316.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314.2.1, !dbg !154
  %53 = load half, ptr addrspace(3) %arrayidx316.2.1, align 2, !dbg !155, !tbaa !156
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %53, i64 2, !dbg !155
  %add311.3.1 = or disjoint i32 %mul307, %and313, !dbg !153
  %add314.3.1 = or disjoint i32 %add311.3.1, 208, !dbg !153
  %arrayidx316.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314.3.1, !dbg !154
  %54 = load half, ptr addrspace(3) %arrayidx316.3.1, align 2, !dbg !155, !tbaa !156
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %54, i64 3, !dbg !155
  %add311.2547 = or disjoint i32 %mul307, %and313, !dbg !153
  %add314.2548 = or disjoint i32 %add311.2547, 32, !dbg !153
  %arrayidx316.2549 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314.2548, !dbg !154
  %55 = load half, ptr addrspace(3) %arrayidx316.2549, align 2, !dbg !155, !tbaa !156
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %55, i64 0, !dbg !155
  %add311.1.2 = or disjoint i32 %mul307, %and313, !dbg !153
  %add314.1.2 = or disjoint i32 %add311.1.2, 96, !dbg !153
  %arrayidx316.1.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314.1.2, !dbg !154
  %56 = load half, ptr addrspace(3) %arrayidx316.1.2, align 2, !dbg !155, !tbaa !156
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %56, i64 1, !dbg !155
  %add311.2.2 = or disjoint i32 %mul307, %and313, !dbg !153
  %add314.2.2 = or disjoint i32 %add311.2.2, 160, !dbg !153
  %arrayidx316.2.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314.2.2, !dbg !154
  %57 = load half, ptr addrspace(3) %arrayidx316.2.2, align 2, !dbg !155, !tbaa !156
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %57, i64 2, !dbg !155
  %add311.3.2 = or disjoint i32 %mul307, %and313, !dbg !153
  %add314.3.2 = or disjoint i32 %add311.3.2, 224, !dbg !153
  %arrayidx316.3.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314.3.2, !dbg !154
  %58 = load half, ptr addrspace(3) %arrayidx316.3.2, align 2, !dbg !155, !tbaa !156
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %58, i64 3, !dbg !155
  %add311.3551 = or disjoint i32 %mul307, %and313, !dbg !153
  %add314.3552 = or disjoint i32 %add311.3551, 48, !dbg !153
  %arrayidx316.3553 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314.3552, !dbg !154
  %59 = load half, ptr addrspace(3) %arrayidx316.3553, align 2, !dbg !155, !tbaa !156
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %59, i64 0, !dbg !155
  %add311.1.3 = or disjoint i32 %mul307, %and313, !dbg !153
  %add314.1.3 = or disjoint i32 %add311.1.3, 112, !dbg !153
  %arrayidx316.1.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314.1.3, !dbg !154
  %60 = load half, ptr addrspace(3) %arrayidx316.1.3, align 2, !dbg !155, !tbaa !156
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %60, i64 1, !dbg !155
  %add311.2.3 = or disjoint i32 %mul307, %and313, !dbg !153
  %add314.2.3 = or disjoint i32 %add311.2.3, 176, !dbg !153
  %arrayidx316.2.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314.2.3, !dbg !154
  %61 = load half, ptr addrspace(3) %arrayidx316.2.3, align 2, !dbg !155, !tbaa !156
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %61, i64 2, !dbg !155
  %add311.3.3 = or disjoint i32 %add.ptr222.idx, %and313, !dbg !153
  %add314.3.3 = or i32 %add311.3.3, 240, !dbg !153
  %arrayidx316.3.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add314.3.3, !dbg !154
  %62 = load half, ptr addrspace(3) %arrayidx316.3.3, align 2, !dbg !155, !tbaa !156
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %62, i64 3, !dbg !155
  %63 = fptrunc float %mul277.3 to half, !dbg !142
  %__1.sroa.0.6.vec.insert = insertelement <4 x half> %__1.sroa.0.4.vec.insert, half %63, i64 3, !dbg !144
  %64 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !157
  %65 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !157
  %66 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !157
  %67 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !157
  br label %if.end345

if.end345:                                        ; preds = %if.end179, %entry
  %acc_o.sroa.0.0 = phi <4 x float> [ %64, %if.end179 ], [ zeroinitializer, %entry ], !dbg !62
  %acc_o.sroa.12.0 = phi <4 x float> [ %65, %if.end179 ], [ zeroinitializer, %entry ], !dbg !62
  %acc_o.sroa.22.0 = phi <4 x float> [ %66, %if.end179 ], [ zeroinitializer, %entry ], !dbg !62
  %acc_o.sroa.32.0 = phi <4 x float> [ %67, %if.end179 ], [ zeroinitializer, %entry ], !dbg !62
  %68 = lshr i32 %2, 2
  %mul381 = and i32 %68, 252
  %add378 = add nuw nsw i32 %add10, %mul381
  %69 = zext nneg i32 %add378 to i64, !dbg !158
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0, !dbg !159
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1, !dbg !159
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2, !dbg !159
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3, !dbg !159
  %70 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !160
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !160, !noalias !164
  %71 = fptrunc float %acc_o.sroa.0.0.vec.extract to half, !dbg !160
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %70), !dbg !160, !noalias !164
  %72 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !169
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !169, !noalias !164
  %73 = fptrunc float %acc_o.sroa.0.4.vec.extract to half, !dbg !169
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %72), !dbg !169, !noalias !164
  %74 = bitcast half %71 to i16, !dbg !171
  %75 = bitcast half %73 to i16, !dbg !174
  %76 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !175
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !175, !noalias !179
  %77 = fptrunc float %acc_o.sroa.0.8.vec.extract to half, !dbg !175
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %76), !dbg !175, !noalias !179
  %78 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !184
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !184, !noalias !179
  %79 = fptrunc float %acc_o.sroa.0.12.vec.extract to half, !dbg !184
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %78), !dbg !184, !noalias !179
  %80 = bitcast half %77 to i16, !dbg !186
  %81 = bitcast half %79 to i16, !dbg !188
  %__2.sroa.6.0.insert.ext = zext i16 %81 to i64, !dbg !189
  %__2.sroa.6.0.insert.shift = shl nuw i64 %__2.sroa.6.0.insert.ext, 48, !dbg !189
  %__2.sroa.5.0.insert.ext = zext i16 %80 to i64, !dbg !189
  %__2.sroa.5.0.insert.shift = shl nuw nsw i64 %__2.sroa.5.0.insert.ext, 32, !dbg !189
  %__2.sroa.5.0.insert.insert = or disjoint i64 %__2.sroa.6.0.insert.shift, %__2.sroa.5.0.insert.shift, !dbg !189
  %__2.sroa.4.0.insert.ext = zext i16 %75 to i64, !dbg !189
  %__2.sroa.4.0.insert.shift = shl nuw nsw i64 %__2.sroa.4.0.insert.ext, 16, !dbg !189
  %__2.sroa.4.0.insert.insert = or disjoint i64 %__2.sroa.5.0.insert.insert, %__2.sroa.4.0.insert.shift, !dbg !189
  %__2.sroa.0.0.insert.ext = zext i16 %74 to i64, !dbg !189
  %__2.sroa.0.0.insert.insert = or disjoint i64 %__2.sroa.4.0.insert.insert, %__2.sroa.0.0.insert.ext, !dbg !189
  %add.ptr384 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %69, !dbg !190
  store i64 %__2.sroa.0.0.insert.insert, ptr addrspace(1) %add.ptr384, align 8, !dbg !191
  %acc_o.sroa.12.16.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 0, !dbg !159
  %acc_o.sroa.12.20.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 1, !dbg !159
  %acc_o.sroa.12.24.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 2, !dbg !159
  %acc_o.sroa.12.28.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 3, !dbg !159
  %82 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !160
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !160, !noalias !164
  %83 = fptrunc float %acc_o.sroa.12.16.vec.extract to half, !dbg !160
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %82), !dbg !160, !noalias !164
  %84 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !169
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !169, !noalias !164
  %85 = fptrunc float %acc_o.sroa.12.20.vec.extract to half, !dbg !169
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %84), !dbg !169, !noalias !164
  %86 = bitcast half %83 to i16, !dbg !171
  %87 = bitcast half %85 to i16, !dbg !174
  %88 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !175
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !175, !noalias !179
  %89 = fptrunc float %acc_o.sroa.12.24.vec.extract to half, !dbg !175
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %88), !dbg !175, !noalias !179
  %90 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !184
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !184, !noalias !179
  %91 = fptrunc float %acc_o.sroa.12.28.vec.extract to half, !dbg !184
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %90), !dbg !184, !noalias !179
  %92 = bitcast half %89 to i16, !dbg !186
  %93 = bitcast half %91 to i16, !dbg !188
  %__2.sroa.6.0.insert.ext.1 = zext i16 %93 to i64, !dbg !189
  %__2.sroa.6.0.insert.shift.1 = shl nuw i64 %__2.sroa.6.0.insert.ext.1, 48, !dbg !189
  %__2.sroa.5.0.insert.ext.1 = zext i16 %92 to i64, !dbg !189
  %__2.sroa.5.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.1, 32, !dbg !189
  %__2.sroa.5.0.insert.insert.1 = or disjoint i64 %__2.sroa.6.0.insert.shift.1, %__2.sroa.5.0.insert.shift.1, !dbg !189
  %__2.sroa.4.0.insert.ext.1 = zext i16 %87 to i64, !dbg !189
  %__2.sroa.4.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.1, 16, !dbg !189
  %__2.sroa.4.0.insert.insert.1 = or disjoint i64 %__2.sroa.5.0.insert.insert.1, %__2.sroa.4.0.insert.shift.1, !dbg !189
  %__2.sroa.0.0.insert.ext.1 = zext i16 %86 to i64, !dbg !189
  %__2.sroa.0.0.insert.insert.1 = or disjoint i64 %__2.sroa.4.0.insert.insert.1, %__2.sroa.0.0.insert.ext.1, !dbg !189
  %94 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %69, !dbg !190
  %add.ptr384.1 = getelementptr inbounds i8, ptr addrspace(1) %94, i64 32, !dbg !190
  store i64 %__2.sroa.0.0.insert.insert.1, ptr addrspace(1) %add.ptr384.1, align 8, !dbg !191
  %acc_o.sroa.22.32.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 0, !dbg !159
  %acc_o.sroa.22.36.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 1, !dbg !159
  %acc_o.sroa.22.40.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 2, !dbg !159
  %acc_o.sroa.22.44.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 3, !dbg !159
  %95 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !160
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !160, !noalias !164
  %96 = fptrunc float %acc_o.sroa.22.32.vec.extract to half, !dbg !160
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %95), !dbg !160, !noalias !164
  %97 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !169
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !169, !noalias !164
  %98 = fptrunc float %acc_o.sroa.22.36.vec.extract to half, !dbg !169
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %97), !dbg !169, !noalias !164
  %99 = bitcast half %96 to i16, !dbg !171
  %100 = bitcast half %98 to i16, !dbg !174
  %101 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !175
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !175, !noalias !179
  %102 = fptrunc float %acc_o.sroa.22.40.vec.extract to half, !dbg !175
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %101), !dbg !175, !noalias !179
  %103 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !184
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !184, !noalias !179
  %104 = fptrunc float %acc_o.sroa.22.44.vec.extract to half, !dbg !184
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %103), !dbg !184, !noalias !179
  %105 = bitcast half %102 to i16, !dbg !186
  %106 = bitcast half %104 to i16, !dbg !188
  %__2.sroa.6.0.insert.ext.2 = zext i16 %106 to i64, !dbg !189
  %__2.sroa.6.0.insert.shift.2 = shl nuw i64 %__2.sroa.6.0.insert.ext.2, 48, !dbg !189
  %__2.sroa.5.0.insert.ext.2 = zext i16 %105 to i64, !dbg !189
  %__2.sroa.5.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.2, 32, !dbg !189
  %__2.sroa.5.0.insert.insert.2 = or disjoint i64 %__2.sroa.6.0.insert.shift.2, %__2.sroa.5.0.insert.shift.2, !dbg !189
  %__2.sroa.4.0.insert.ext.2 = zext i16 %100 to i64, !dbg !189
  %__2.sroa.4.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.2, 16, !dbg !189
  %__2.sroa.4.0.insert.insert.2 = or disjoint i64 %__2.sroa.5.0.insert.insert.2, %__2.sroa.4.0.insert.shift.2, !dbg !189
  %__2.sroa.0.0.insert.ext.2 = zext i16 %99 to i64, !dbg !189
  %__2.sroa.0.0.insert.insert.2 = or disjoint i64 %__2.sroa.4.0.insert.insert.2, %__2.sroa.0.0.insert.ext.2, !dbg !189
  %107 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %69, !dbg !190
  %add.ptr384.2 = getelementptr inbounds i8, ptr addrspace(1) %107, i64 64, !dbg !190
  store i64 %__2.sroa.0.0.insert.insert.2, ptr addrspace(1) %add.ptr384.2, align 8, !dbg !191
  %acc_o.sroa.32.48.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 0, !dbg !159
  %acc_o.sroa.32.52.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 1, !dbg !159
  %acc_o.sroa.32.56.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 2, !dbg !159
  %acc_o.sroa.32.60.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 3, !dbg !159
  %108 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !160
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !160, !noalias !164
  %109 = fptrunc float %acc_o.sroa.32.48.vec.extract to half, !dbg !160
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %108), !dbg !160, !noalias !164
  %110 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !169
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !169, !noalias !164
  %111 = fptrunc float %acc_o.sroa.32.52.vec.extract to half, !dbg !169
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %110), !dbg !169, !noalias !164
  %112 = bitcast half %109 to i16, !dbg !171
  %113 = bitcast half %111 to i16, !dbg !174
  %114 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !175
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !175, !noalias !179
  %115 = fptrunc float %acc_o.sroa.32.56.vec.extract to half, !dbg !175
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %114), !dbg !175, !noalias !179
  %116 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !184
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !184, !noalias !179
  %117 = fptrunc float %acc_o.sroa.32.60.vec.extract to half, !dbg !184
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %116), !dbg !184, !noalias !179
  %118 = bitcast half %115 to i16, !dbg !186
  %119 = bitcast half %117 to i16, !dbg !188
  %__2.sroa.6.0.insert.ext.3 = zext i16 %119 to i64, !dbg !189
  %__2.sroa.6.0.insert.shift.3 = shl nuw i64 %__2.sroa.6.0.insert.ext.3, 48, !dbg !189
  %__2.sroa.5.0.insert.ext.3 = zext i16 %118 to i64, !dbg !189
  %__2.sroa.5.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.3, 32, !dbg !189
  %__2.sroa.5.0.insert.insert.3 = or disjoint i64 %__2.sroa.6.0.insert.shift.3, %__2.sroa.5.0.insert.shift.3, !dbg !189
  %__2.sroa.4.0.insert.ext.3 = zext i16 %113 to i64, !dbg !189
  %__2.sroa.4.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.3, 16, !dbg !189
  %__2.sroa.4.0.insert.insert.3 = or disjoint i64 %__2.sroa.5.0.insert.insert.3, %__2.sroa.4.0.insert.shift.3, !dbg !189
  %__2.sroa.0.0.insert.ext.3 = zext i16 %112 to i64, !dbg !189
  %__2.sroa.0.0.insert.insert.3 = or disjoint i64 %__2.sroa.4.0.insert.insert.3, %__2.sroa.0.0.insert.ext.3, !dbg !189
  %120 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %69, !dbg !190
  %add.ptr384.3 = getelementptr inbounds i8, ptr addrspace(1) %120, i64 96, !dbg !190
  store i64 %__2.sroa.0.0.insert.insert.3, ptr addrspace(1) %add.ptr384.3, align 8, !dbg !191
  ret void, !dbg !192
}

; Function Attrs: convergent nounwind willreturn memory(none)
declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.x() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.y() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.z() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.thread.id.x() #5

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

; Function Attrs: convergent nounwind willreturn
declare void @llvm.mxc.barrier.warp() #6

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i1 @llvm.mxc.is.private(ptr nocapture) #5

; Function Attrs: nounwind willreturn
declare void @llvm.mxc.sleep(i32 immarg) #7

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp2.f32(float) #8

; Function Attrs: nounwind speculatable willreturn memory(inaccessiblemem: read)
declare i32 @llvm.mxc.gethwreg(i32 immarg) #9

; Function Attrs: nounwind willreturn
declare void @llvm.mxc.sethwreg(i32 immarg, i32) #7

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
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

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmpgl68rqyx/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{i32 8, !"PIC Level", i32 1}
!5 = distinct !DISubprogram(name: "__cxa_pure_virtual", scope: !6, file: !6, line: 38, type: !7, scopeLine: 38, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!6 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_runtime_wrapper.h", directory: "")
!7 = !DISubroutineType(types: !8)
!8 = !{}
!9 = !DILocation(line: 39, column: 3, scope: !5)
!10 = !DILocation(line: 40, column: 1, scope: !5)
!11 = distinct !DISubprogram(name: "__cxa_deleted_virtual", scope: !6, file: !6, line: 43, type: !7, scopeLine: 43, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!12 = !DILocation(line: 44, column: 3, scope: !11)
!13 = !DILocation(line: 45, column: 1, scope: !11)
!14 = distinct !DISubprogram(name: "__mcImplicitDeviceSynchronize", scope: !15, file: !15, line: 92, type: !7, scopeLine: 93, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!15 = !DIFile(filename: "/opt/maca/include/mckl/mc_device_runtime.h", directory: "")
!16 = !DILocation(line: 94, column: 5, scope: !14)
!17 = !{!18, !18, i64 0}
!18 = !{!"long", !19, i64 0}
!19 = !{!"omnipotent char", !20, i64 0}
!20 = !{!"Simple C++ TBAA"}
!21 = !{!22, !24, i64 16}
!22 = !{!"_ZTS21_DynamicParallMqlWrap", !23, i64 0, !23, i64 4, !23, i64 8, !23, i64 12, !24, i64 16, !24, i64 24, !25, i64 32}
!23 = !{!"int", !19, i64 0}
!24 = !{!"any pointer", !19, i64 0}
!25 = !{!"_ZTS28mxc_kernel_dispatch_packet_s", !26, i64 0, !26, i64 2, !26, i64 4, !26, i64 6, !26, i64 8, !26, i64 10, !23, i64 12, !23, i64 16, !23, i64 20, !23, i64 24, !23, i64 28, !18, i64 32, !24, i64 40, !18, i64 48, !27, i64 56}
!26 = !{!"short", !19, i64 0}
!27 = !{!"_ZTS12mxc_signal_s", !18, i64 0}
!28 = !{i32 1, i32 -2147483648}
!29 = !{i32 0, i32 2147483647}
!30 = !{!23, !23, i64 0}
!31 = distinct !{!31, !32}
!32 = !{!"llvm.loop.mustprogress"}
!33 = !{!22, !23, i64 4}
!34 = !{!22, !24, i64 24}
!35 = !{!22, !23, i64 0}
!36 = !{!37, !24, i64 24}
!37 = !{!"_ZTS28_DynamicParallSchedulerParam", !18, i64 0, !24, i64 8, !24, i64 16, !24, i64 24, !18, i64 32, !18, i64 40, !18, i64 48, !18, i64 56, !18, i64 64, !18, i64 72, !18, i64 80, !18, i64 88, !18, i64 96, !23, i64 104, !23, i64 108, !23, i64 112, !23, i64 116, !23, i64 120, !23, i64 124}
!38 = !{!37, !18, i64 80}
!39 = !DILocation(line: 95, column: 1, scope: !14)
!40 = distinct !DISubprogram(name: "kernel_kernel", scope: !41, file: !41, line: 10, type: !7, scopeLine: 10, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!41 = !DIFile(filename: "/tmp/tmpgl68rqyx/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 22, column: 3, scope: !40)
!44 = !DILocation(line: 23, column: 46, scope: !40)
!45 = !DILocation(line: 23, column: 32, scope: !40)
!46 = !DILocation(line: 25, column: 47, scope: !40)
!47 = !DILocation(line: 25, column: 53, scope: !40)
!48 = !DILocation(line: 25, column: 14, scope: !40)
!49 = !DILocation(line: 31, column: 19, scope: !40)
!50 = !DILocation(line: 33, column: 5, scope: !40)
!51 = !DILocation(line: 37, column: 31, scope: !40)
!52 = !DILocation(line: 37, column: 17, scope: !40)
!53 = !DILocation(line: 44, column: 5, scope: !40)
!54 = !DILocation(line: 47, column: 61, scope: !40)
!55 = !DILocation(line: 47, column: 11, scope: !40)
!56 = !DILocation(line: 58, column: 62, scope: !40)
!57 = !DILocation(line: 58, column: 13, scope: !40)
!58 = !DILocation(line: 63, column: 20, scope: !40)
!59 = !DILocation(line: 58, column: 55, scope: !40)
!60 = !DILocation(line: 48, column: 19, scope: !40)
!61 = !DILocation(line: 49, column: 7, scope: !40)
!62 = !DILocation(line: 0, scope: !40)
!63 = !DILocation(line: 54, column: 27, scope: !40)
!64 = !DILocation(line: 54, column: 9, scope: !40)
!65 = !DILocation(line: 72, column: 36, scope: !40)
!66 = !{i32 1, i32 3, i32 -1}
!67 = !DILocation(line: 79, column: 5, scope: !40)
!68 = !DILocation(line: 80, column: 70, scope: !40)
!69 = !DILocation(line: 80, column: 26, scope: !40)
!70 = !DILocation(line: 84, column: 31, scope: !40)
!71 = !DILocation(line: 84, column: 42, scope: !40)
!72 = !DILocation(line: 354, column: 10, scope: !73, inlinedAt: !75)
!73 = distinct !DISubprogram(name: "min", scope: !74, file: !74, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!74 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!75 = distinct !DILocation(line: 84, column: 26, scope: !40)
!76 = !DILocation(line: 285, column: 49, scope: !77, inlinedAt: !78)
!77 = distinct !DISubprogram(name: "exp2f", scope: !74, file: !74, line: 285, type: !7, scopeLine: 285, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!78 = distinct !DILocation(line: 84, column: 20, scope: !40)
!79 = !DILocation(line: 89, column: 34, scope: !40)
!80 = !DILocation(line: 1018, column: 9, scope: !81, inlinedAt: !83)
!81 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !82, file: !82, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!82 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!83 = distinct !DILocation(line: 91, column: 34, scope: !40)
!84 = !DILocation(line: 171, column: 37, scope: !85, inlinedAt: !86)
!85 = distinct !DISubprogram(name: "__lane_id", scope: !82, file: !82, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!86 = distinct !DILocation(line: 990, column: 14, scope: !87, inlinedAt: !88)
!87 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !82, file: !82, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!88 = distinct !DILocation(line: 1019, column: 11, scope: !81, inlinedAt: !83)
!89 = !DILocation(line: 171, column: 10, scope: !85, inlinedAt: !86)
!90 = !DILocation(line: 991, column: 20, scope: !87, inlinedAt: !88)
!91 = !DILocation(line: 992, column: 36, scope: !87, inlinedAt: !88)
!92 = !DILocation(line: 992, column: 17, scope: !87, inlinedAt: !88)
!93 = !DILocation(line: 992, column: 11, scope: !87, inlinedAt: !88)
!94 = !DILocation(line: 993, column: 43, scope: !87, inlinedAt: !88)
!95 = !DILocation(line: 993, column: 10, scope: !87, inlinedAt: !88)
!96 = !DILocation(line: 1020, column: 14, scope: !81, inlinedAt: !83)
!97 = !DILocation(line: 91, column: 32, scope: !40)
!98 = !DILocation(line: 1018, column: 9, scope: !81, inlinedAt: !99)
!99 = distinct !DILocation(line: 92, column: 34, scope: !40)
!100 = !DILocation(line: 171, column: 37, scope: !85, inlinedAt: !101)
!101 = distinct !DILocation(line: 990, column: 14, scope: !87, inlinedAt: !102)
!102 = distinct !DILocation(line: 1019, column: 11, scope: !81, inlinedAt: !99)
!103 = !DILocation(line: 171, column: 10, scope: !85, inlinedAt: !101)
!104 = !DILocation(line: 991, column: 20, scope: !87, inlinedAt: !102)
!105 = !DILocation(line: 992, column: 36, scope: !87, inlinedAt: !102)
!106 = !DILocation(line: 992, column: 17, scope: !87, inlinedAt: !102)
!107 = !DILocation(line: 992, column: 11, scope: !87, inlinedAt: !102)
!108 = !DILocation(line: 993, column: 43, scope: !87, inlinedAt: !102)
!109 = !DILocation(line: 993, column: 10, scope: !87, inlinedAt: !102)
!110 = !DILocation(line: 1020, column: 14, scope: !81, inlinedAt: !99)
!111 = !DILocation(line: 92, column: 32, scope: !40)
!112 = !DILocation(line: 94, column: 34, scope: !40)
!113 = !DILocation(line: 94, column: 9, scope: !40)
!114 = !DILocation(line: 102, column: 32, scope: !40)
!115 = !DILocation(line: 1007, column: 10, scope: !116, inlinedAt: !118)
!116 = distinct !DISubprogram(name: "__float2half_rn", scope: !117, file: !117, line: 1005, type: !7, scopeLine: 1005, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!117 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!118 = distinct !DILocation(line: 1077, column: 18, scope: !119, inlinedAt: !120)
!119 = distinct !DISubprogram(name: "__floats2half2_rn", scope: !117, file: !117, line: 1075, type: !7, scopeLine: 1076, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!120 = distinct !DILocation(line: 1295, column: 23, scope: !121, inlinedAt: !122)
!121 = distinct !DISubprogram(name: "__float22half2_rn", scope: !117, file: !117, line: 1294, type: !7, scopeLine: 1294, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!122 = distinct !DILocation(line: 106, column: 27, scope: !40)
!123 = !{!124, !126}
!124 = distinct !{!124, !125, !"_ZL17__floats2half2_rnff: %agg.result"}
!125 = distinct !{!125, !"_ZL17__floats2half2_rnff"}
!126 = distinct !{!126, !127, !"_ZL17__float22half2_rn6float2: %agg.result"}
!127 = distinct !{!127, !"_ZL17__float22half2_rn6float2"}
!128 = !DILocation(line: 1007, column: 10, scope: !116, inlinedAt: !129)
!129 = distinct !DILocation(line: 1077, column: 38, scope: !119, inlinedAt: !120)
!130 = !DILocation(line: 593, column: 26, scope: !131, inlinedAt: !132)
!131 = distinct !DISubprogram(name: "operator=", scope: !117, file: !117, line: 592, type: !7, scopeLine: 592, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!132 = distinct !DILocation(line: 106, column: 25, scope: !40)
!133 = !DILocation(line: 1007, column: 10, scope: !116, inlinedAt: !134)
!134 = distinct !DILocation(line: 1077, column: 18, scope: !119, inlinedAt: !135)
!135 = distinct !DILocation(line: 1295, column: 23, scope: !121, inlinedAt: !136)
!136 = distinct !DILocation(line: 107, column: 27, scope: !40)
!137 = !{!138, !140}
!138 = distinct !{!138, !139, !"_ZL17__floats2half2_rnff: %agg.result"}
!139 = distinct !{!139, !"_ZL17__floats2half2_rnff"}
!140 = distinct !{!140, !141, !"_ZL17__float22half2_rn6float2: %agg.result"}
!141 = distinct !{!141, !"_ZL17__float22half2_rn6float2"}
!142 = !DILocation(line: 1007, column: 10, scope: !116, inlinedAt: !143)
!143 = distinct !DILocation(line: 1077, column: 38, scope: !119, inlinedAt: !135)
!144 = !DILocation(line: 593, column: 26, scope: !131, inlinedAt: !145)
!145 = distinct !DILocation(line: 107, column: 25, scope: !40)
!146 = !DILocation(line: 68, column: 3, scope: !147, inlinedAt: !148)
!147 = distinct !DISubprogram(name: "__barrier_warp", scope: !82, file: !82, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!148 = distinct !DILocation(line: 192, column: 3, scope: !149, inlinedAt: !150)
!149 = distinct !DISubprogram(name: "__syncwarp", scope: !82, file: !82, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!150 = distinct !DILocation(line: 109, column: 5, scope: !40)
!151 = !DILocation(line: 69, column: 3, scope: !147, inlinedAt: !148)
!152 = !DILocation(line: 70, column: 3, scope: !147, inlinedAt: !148)
!153 = !DILocation(line: 112, column: 103, scope: !40)
!154 = !DILocation(line: 112, column: 31, scope: !40)
!155 = !DILocation(line: 112, column: 29, scope: !40)
!156 = !{!26, !26, i64 0}
!157 = !DILocation(line: 117, column: 38, scope: !40)
!158 = !DILocation(line: 124, column: 3, scope: !40)
!159 = !DILocation(line: 126, column: 19, scope: !40)
!160 = !DILocation(line: 1007, column: 10, scope: !116, inlinedAt: !161)
!161 = distinct !DILocation(line: 1077, column: 18, scope: !119, inlinedAt: !162)
!162 = distinct !DILocation(line: 1295, column: 23, scope: !121, inlinedAt: !163)
!163 = distinct !DILocation(line: 127, column: 27, scope: !40)
!164 = !{!165, !167}
!165 = distinct !{!165, !166, !"_ZL17__floats2half2_rnff: %agg.result"}
!166 = distinct !{!166, !"_ZL17__floats2half2_rnff"}
!167 = distinct !{!167, !168, !"_ZL17__float22half2_rn6float2: %agg.result"}
!168 = distinct !{!168, !"_ZL17__float22half2_rn6float2"}
!169 = !DILocation(line: 1007, column: 10, scope: !116, inlinedAt: !170)
!170 = distinct !DILocation(line: 1077, column: 38, scope: !119, inlinedAt: !162)
!171 = !DILocation(line: 596, column: 67, scope: !172, inlinedAt: !173)
!172 = distinct !DISubprogram(name: "__half2", scope: !117, file: !117, line: 596, type: !7, scopeLine: 596, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!173 = distinct !DILocation(line: 1077, column: 10, scope: !119, inlinedAt: !162)
!174 = !DILocation(line: 596, column: 73, scope: !172, inlinedAt: !173)
!175 = !DILocation(line: 1007, column: 10, scope: !116, inlinedAt: !176)
!176 = distinct !DILocation(line: 1077, column: 18, scope: !119, inlinedAt: !177)
!177 = distinct !DILocation(line: 1295, column: 23, scope: !121, inlinedAt: !178)
!178 = distinct !DILocation(line: 128, column: 27, scope: !40)
!179 = !{!180, !182}
!180 = distinct !{!180, !181, !"_ZL17__floats2half2_rnff: %agg.result"}
!181 = distinct !{!181, !"_ZL17__floats2half2_rnff"}
!182 = distinct !{!182, !183, !"_ZL17__float22half2_rn6float2: %agg.result"}
!183 = distinct !{!183, !"_ZL17__float22half2_rn6float2"}
!184 = !DILocation(line: 1007, column: 10, scope: !116, inlinedAt: !185)
!185 = distinct !DILocation(line: 1077, column: 38, scope: !119, inlinedAt: !177)
!186 = !DILocation(line: 596, column: 67, scope: !172, inlinedAt: !187)
!187 = distinct !DILocation(line: 1077, column: 10, scope: !119, inlinedAt: !177)
!188 = !DILocation(line: 596, column: 73, scope: !172, inlinedAt: !187)
!189 = !DILocation(line: 129, column: 38, scope: !40)
!190 = !DILocation(line: 130, column: 22, scope: !40)
!191 = !DILocation(line: 130, column: 172, scope: !40)
!192 = !DILocation(line: 132, column: 1, scope: !40)
