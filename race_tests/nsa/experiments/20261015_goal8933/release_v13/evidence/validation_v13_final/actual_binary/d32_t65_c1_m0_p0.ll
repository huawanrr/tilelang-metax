; ModuleID = '/data/tilelang-metax/race_tests/nsa/experiments/20261015_goal8933/validation_v13_final/actual_binary/d32_t65_c1_m0_p0.bc'
source_filename = "/tmp/tmp1_70re7m/tvm_kernels.maca"
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
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !dbg !42, !range !29
  %mul = shl nsw i32 %0, 9, !dbg !46
  %1 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !dbg !47, !range !50
  %and = shl nuw nsw i32 %1, 5, !dbg !51
  %mul7 = and i32 %and, 480, !dbg !51
  %add = or disjoint i32 %mul7, %mul, !dbg !52
  %2 = lshr i32 %1, 1, !dbg !53
  %mul9 = and i32 %2, 504, !dbg !53
  %add10 = add nuw nsw i32 %add, %mul9, !dbg !54
  %idx.ext = zext nneg i32 %add10 to i64, !dbg !55
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %idx.ext, !dbg !55
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16, !dbg !56
  %Q_reg.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !56
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.4.0.add.ptr.sroa_idx, align 8, !dbg !56
  %idxprom = zext nneg i32 %0 to i64, !dbg !57
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom, !dbg !57
  %3 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !57, !tbaa !30
  %cmp19 = icmp ugt i32 %3, 4
  %shr22 = lshr i32 %0, 4
  %cmp23.not = icmp ugt i32 %3, %shr22
  %or.cond484 = or i1 %cmp19, %cmp23.not, !dbg !58
  br i1 %or.cond484, label %entry.if.end301_crit_edge, label %if.then, !dbg !58

entry.if.end301_crit_edge:                        ; preds = %entry
  %.pre = lshr i32 %1, 2
  br label %if.end301, !dbg !58

if.then:                                          ; preds = %entry
  %mul24 = shl nuw nsw i32 %3, 4, !dbg !59
  %and26 = and i32 %1, 15, !dbg !60
  %add27 = or disjoint i32 %mul24, %and26, !dbg !61
  %cmp28 = icmp ult i32 %add27, 65, !dbg !62
  br i1 %cmp28, label %if.then29, label %if.end, !dbg !63

if.then29:                                        ; preds = %if.then
  %mul30 = shl nuw nsw i32 %3, 9
  %add34 = add nuw nsw i32 %mul9, %mul7
  %add38 = add nuw nsw i32 %add34, %mul30
  %idx.ext39 = zext nneg i32 %add38 to i64
  %add.ptr40 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext39
  %condval.sroa.6.0.add.ptr40.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr40, i64 8
  %4 = load <4 x half>, ptr addrspace(4) %add.ptr40, align 16, !dbg !64, !tbaa !30
  %5 = load <4 x half>, ptr addrspace(4) %condval.sroa.6.0.add.ptr40.sroa_idx, align 8, !dbg !64, !tbaa !30
  br label %if.end, !dbg !65

if.end:                                           ; preds = %if.then, %if.then29
  %6 = phi <4 x half> [ %5, %if.then29 ], [ zeroinitializer, %if.then ], !dbg !66
  %7 = phi <4 x half> [ %4, %if.then29 ], [ zeroinitializer, %if.then ], !dbg !66
  %shr65 = lshr i32 %1, 2, !dbg !67
  %add66 = add nuw nsw i32 %mul24, %shr65, !dbg !68
  %cmp67 = icmp ult i32 %add66, 65, !dbg !69
  br i1 %cmp67, label %if.then68, label %if.end98, !dbg !70

if.then68:                                        ; preds = %if.end
  %mul69 = shl nuw nsw i32 %3, 9
  %mul71 = shl nuw nsw i32 %1, 3
  %add72 = add nuw nsw i32 %mul69, %mul71
  %idx.ext73 = zext nneg i32 %add72 to i64
  %add.ptr74 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idx.ext73
  %condval_1.sroa.7.0.add.ptr74.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr74, i64 12
  %condval_1.sroa.6.0.add.ptr74.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr74, i64 8
  %condval_1.sroa.5.0.add.ptr74.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr74, i64 4
  %condval_1.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr74, align 16, !dbg !71, !tbaa !30
  %condval_1.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr74.sroa_idx, align 4, !dbg !71, !tbaa !30
  %condval_1.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr74.sroa_idx, align 8, !dbg !71, !tbaa !30
  %condval_1.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr74.sroa_idx, align 4, !dbg !71, !tbaa !30
  br label %if.end98, !dbg !72

if.end98:                                         ; preds = %if.end, %if.then68
  %condval_1.sroa.0.0 = phi i32 [ %condval_1.sroa.0.0.copyload, %if.then68 ], [ 0, %if.end ], !dbg !66
  %condval_1.sroa.5.0 = phi i32 [ %condval_1.sroa.5.0.copyload, %if.then68 ], [ 0, %if.end ], !dbg !66
  %condval_1.sroa.6.0 = phi i32 [ %condval_1.sroa.6.0.copyload, %if.then68 ], [ 0, %if.end ], !dbg !66
  %condval_1.sroa.7.0 = phi i32 [ %condval_1.sroa.7.0.copyload, %if.then68 ], [ 0, %if.end ], !dbg !66
  %add103 = or disjoint i32 %mul24, 15, !dbg !73
  %cmp104 = icmp ult i32 %0, %add103, !dbg !74
  br i1 %cmp104, label %for.cond106.preheader, label %if.end133, !dbg !75

for.cond106.preheader:                            ; preds = %if.end98
  %mul114 = and i32 %shr65, 252
  %add115 = add nuw nsw i32 %mul24, %mul114
  %cmp118.not = icmp ugt i32 %add115, %0, !dbg !76
  %spec.select = select i1 %cmp118.not, float 0xFFF0000000000000, float 0.000000e+00, !dbg !77
  %acc_s.sroa.0.0.vec.insert500 = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !78
  %cmp118.not.1.not = icmp ult i32 %add115, %0, !dbg !76
  %spec.select.1 = select i1 %cmp118.not.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !77
  %acc_s.sroa.0.4.vec.insert513 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert500, float %spec.select.1, i64 1, !dbg !78
  %add116.2 = or disjoint i32 %add115, 2, !dbg !79
  %cmp118.not.2 = icmp ugt i32 %add116.2, %0, !dbg !76
  %spec.select.2 = select i1 %cmp118.not.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !77
  %acc_s.sroa.0.8.vec.insert526 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert513, float %spec.select.2, i64 2, !dbg !78
  %add116.3 = or disjoint i32 %add115, 3, !dbg !79
  %cmp118.not.3 = icmp ugt i32 %add116.3, %0, !dbg !76
  %spec.select.3 = select i1 %cmp118.not.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !77
  %acc_s.sroa.0.12.vec.insert539 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert526, float %spec.select.3, i64 3, !dbg !78
  br label %if.end133

if.end133:                                        ; preds = %if.end98, %for.cond106.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert539, %for.cond106.preheader ], [ zeroinitializer, %if.end98 ], !dbg !66
  %8 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %7, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !dbg !80, !call_argsrelate !81
  %9 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %6, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %8), !dbg !80, !call_argsrelate !81
  %10 = shl nuw nsw i32 %1, 3, !dbg !82
  %mul156 = and i32 %10, 8160, !dbg !82
  %xor = xor i32 %10, %1, !dbg !83
  %mul162 = and i32 %xor, 24, !dbg !83
  %add163 = or disjoint i32 %mul162, %mul156, !dbg !84
  %add.ptr165 = getelementptr inbounds %struct.__half, ptr addrspace(3) @V_shared, i32 %add163, !dbg !85
  store i32 %condval_1.sroa.0.0, ptr addrspace(3) %add.ptr165, align 16, !dbg !86, !tbaa !30
  %V_reg.sroa.4.0.add.ptr165.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr165, i32 4, !dbg !86
  store i32 %condval_1.sroa.5.0, ptr addrspace(3) %V_reg.sroa.4.0.add.ptr165.sroa_idx, align 4, !dbg !86, !tbaa !30
  %V_reg.sroa.5.0.add.ptr165.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr165, i32 8, !dbg !86
  store i32 %condval_1.sroa.6.0, ptr addrspace(3) %V_reg.sroa.5.0.add.ptr165.sroa_idx, align 8, !dbg !86, !tbaa !30
  %V_reg.sroa.6.0.add.ptr165.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr165, i32 12, !dbg !86
  store i32 %condval_1.sroa.7.0, ptr addrspace(3) %V_reg.sroa.6.0.add.ptr165.sroa_idx, align 4, !dbg !86, !tbaa !30
  %acc_s.sroa.0.0.vec.extract502 = extractelement <4 x float> %9, i64 0, !dbg !87
  %mul173 = fmul contract float %acc_s.sroa.0.0.vec.extract502, 0x3FC2776C60000000, !dbg !88
  %11 = tail call contract noundef float @llvm.minnum.f32(float %mul173, float 1.500000e+01), !dbg !89
  %cmp.i.i = fcmp contract olt float %11, -1.260000e+02, !dbg !93
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00, !dbg !93
  %add.i.i = fadd contract float %11, %cond.i.i, !dbg !93
  %12 = tail call contract float @llvm.exp2.f32(float %add.i.i), !dbg !93
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00, !dbg !93
  %mul.i.i = fmul contract float %cond2.i.i, %12, !dbg !93
  %acc_s.sroa.0.4.vec.extract515 = extractelement <4 x float> %9, i64 1, !dbg !87
  %mul173.1 = fmul contract float %acc_s.sroa.0.4.vec.extract515, 0x3FC2776C60000000, !dbg !88
  %13 = tail call contract noundef float @llvm.minnum.f32(float %mul173.1, float 1.500000e+01), !dbg !89
  %cmp.i.i.1 = fcmp contract olt float %13, -1.260000e+02, !dbg !93
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00, !dbg !93
  %add.i.i.1 = fadd contract float %13, %cond.i.i.1, !dbg !93
  %14 = tail call contract float @llvm.exp2.f32(float %add.i.i.1), !dbg !93
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !93
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %14, !dbg !93
  %acc_s.sroa.0.8.vec.extract528 = extractelement <4 x float> %9, i64 2, !dbg !87
  %mul173.2 = fmul contract float %acc_s.sroa.0.8.vec.extract528, 0x3FC2776C60000000, !dbg !88
  %15 = tail call contract noundef float @llvm.minnum.f32(float %mul173.2, float 1.500000e+01), !dbg !89
  %cmp.i.i.2 = fcmp contract olt float %15, -1.260000e+02, !dbg !93
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00, !dbg !93
  %add.i.i.2 = fadd contract float %15, %cond.i.i.2, !dbg !93
  %16 = tail call contract float @llvm.exp2.f32(float %add.i.i.2), !dbg !93
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00, !dbg !93
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %16, !dbg !93
  %acc_s.sroa.0.12.vec.extract541 = extractelement <4 x float> %9, i64 3, !dbg !87
  %mul173.3 = fmul contract float %acc_s.sroa.0.12.vec.extract541, 0x3FC2776C60000000, !dbg !88
  %17 = tail call contract noundef float @llvm.minnum.f32(float %mul173.3, float 1.500000e+01), !dbg !89
  %cmp.i.i.3 = fcmp contract olt float %17, -1.260000e+02, !dbg !93
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00, !dbg !93
  %add.i.i.3 = fadd contract float %17, %cond.i.i.3, !dbg !93
  %18 = tail call contract float @llvm.exp2.f32(float %add.i.i.3), !dbg !93
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00, !dbg !93
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %18, !dbg !93
  %add190 = fadd contract float %mul.i.i, 0.000000e+00, !dbg !96
  %add190.1 = fadd contract float %add190, %mul.i.i.1, !dbg !96
  %add190.2 = fadd contract float %add190.1, %mul.i.i.2, !dbg !96
  %add190.3 = fadd contract float %add190.2, %mul.i.i.3, !dbg !96
  %19 = bitcast float %add190.3 to i32, !dbg !97
  %20 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10, !dbg !101
  %21 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %20) #10, !dbg !106
  %xor.i.i = xor i32 %21, 32, !dbg !107
  %22 = and i32 %21, -64, !dbg !108
  %and.i.i = add nsw i32 %22, 64, !dbg !108
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !109
  %cond.i.i441 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %21, !dbg !110
  %shl.i.i = shl i32 %cond.i.i441, 2, !dbg !111
  %23 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %19), !dbg !112
  %24 = bitcast i32 %23 to float, !dbg !113
  %add198 = fadd contract float %add190.3, %24, !dbg !114
  %25 = bitcast float %add198 to i32, !dbg !115
  %26 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10, !dbg !117
  %27 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %26) #10, !dbg !120
  %xor.i.i442 = xor i32 %27, 16, !dbg !121
  %28 = and i32 %27, -64, !dbg !122
  %and.i.i443 = add nsw i32 %28, 64, !dbg !122
  %cmp.not.i.i444 = icmp slt i32 %xor.i.i442, %and.i.i443, !dbg !123
  %cond.i.i445 = select i1 %cmp.not.i.i444, i32 %xor.i.i442, i32 %27, !dbg !124
  %shl.i.i446 = shl i32 %cond.i.i445, 2, !dbg !125
  %29 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i446, i32 %25), !dbg !126
  %30 = bitcast i32 %29 to float, !dbg !127
  %add203 = fadd contract float %add198, %30, !dbg !128
  %cmp206 = fcmp contract ogt float %add203, 0.000000e+00, !dbg !129
  %div = fdiv contract float 1.000000e+00, %add203, !dbg !130
  %condval_3.0 = select i1 %cmp206, float %div, float 0.000000e+00, !dbg !130
  %mul220 = fmul contract float %condval_3.0, %mul.i.i, !dbg !131
  %mul220.1 = fmul contract float %condval_3.0, %mul.i.i.1, !dbg !131
  %mul220.2 = fmul contract float %condval_3.0, %mul.i.i.2, !dbg !131
  %mul220.3 = fmul contract float %condval_3.0, %mul.i.i.3, !dbg !131
  %31 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !132
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !132, !noalias !140
  %32 = fptrunc float %mul220 to half, !dbg !132
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %31), !dbg !132, !noalias !140
  %33 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !145
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !145, !noalias !140
  %34 = fptrunc float %mul220.1 to half, !dbg !145
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %33), !dbg !145, !noalias !140
  %__1.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %32, i64 0, !dbg !147
  %__1.sroa.0.2.vec.insert = insertelement <4 x half> %__1.sroa.0.0.vec.insert, half %34, i64 1, !dbg !147
  %35 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !150
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !150, !noalias !154
  %36 = fptrunc float %mul220.2 to half, !dbg !150
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %35), !dbg !150, !noalias !154
  %37 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !159
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !159, !noalias !154
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %37), !dbg !159, !noalias !154
  %__1.sroa.0.4.vec.insert = insertelement <4 x half> %__1.sroa.0.2.vec.insert, half %36, i64 2, !dbg !161
  fence syncscope("warp") release, !dbg !163
  tail call void @llvm.mxc.barrier.warp(), !dbg !168
  fence syncscope("warp") acquire, !dbg !169
  %mul251 = and i32 %10, 8064
  %and256 = lshr i32 %1, 3
  %shr257 = and i32 %and256, 1
  %mul262 = and i32 %and256, 2
  %and269 = and i32 %1, 7
  %mul266 = and i32 %1, 24, !dbg !170
  %add267 = or disjoint i32 %mul266, %mul251, !dbg !171
  %add270 = or disjoint i32 %add267, %and269, !dbg !172
  %arrayidx272 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add270, !dbg !173
  %38 = load half, ptr addrspace(3) %arrayidx272, align 2, !dbg !174, !tbaa !175
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %38, i64 0, !dbg !174
  %add253.1 = or disjoint i32 %mul251, 32, !dbg !176
  %add267.1 = or disjoint i32 %mul266, %add253.1, !dbg !171
  %add270.1 = or disjoint i32 %add267.1, %and269, !dbg !172
  %arrayidx272.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add270.1, !dbg !173
  %39 = load half, ptr addrspace(3) %arrayidx272.1, align 2, !dbg !174, !tbaa !175
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %39, i64 1, !dbg !174
  %add253.2 = or disjoint i32 %mul251, 64, !dbg !176
  %add264.2 = or disjoint i32 %mul262, 1, !dbg !177
  %xor265.2 = xor i32 %add264.2, %shr257, !dbg !178
  %mul266.2 = shl nuw nsw i32 %xor265.2, 3, !dbg !170
  %add267.2 = or disjoint i32 %mul266.2, %add253.2, !dbg !171
  %add270.2 = or disjoint i32 %add267.2, %and269, !dbg !172
  %arrayidx272.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add270.2, !dbg !173
  %40 = load half, ptr addrspace(3) %arrayidx272.2, align 2, !dbg !174, !tbaa !175
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %40, i64 2, !dbg !174
  %add253.3 = or disjoint i32 %mul251, 96, !dbg !176
  %add267.3 = or disjoint i32 %mul266.2, %add253.3, !dbg !171
  %add270.3 = or disjoint i32 %add267.3, %and269, !dbg !172
  %arrayidx272.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add270.3, !dbg !173
  %41 = load half, ptr addrspace(3) %arrayidx272.3, align 2, !dbg !174, !tbaa !175
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %41, i64 3, !dbg !174
  %add258.1 = or disjoint i32 %shr257, 2
  %xor265.1485 = xor i32 %mul262, %add258.1, !dbg !178
  %mul266.1486 = shl nuw nsw i32 %xor265.1485, 3, !dbg !170
  %add267.1487 = or disjoint i32 %mul266.1486, %mul251, !dbg !171
  %add270.1488 = or disjoint i32 %add267.1487, %and269, !dbg !172
  %arrayidx272.1489 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add270.1488, !dbg !173
  %42 = load half, ptr addrspace(3) %arrayidx272.1489, align 2, !dbg !174, !tbaa !175
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %42, i64 0, !dbg !174
  %add267.1.1 = or disjoint i32 %mul266.1486, %add253.1, !dbg !171
  %add270.1.1 = or disjoint i32 %add267.1.1, %and269, !dbg !172
  %arrayidx272.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add270.1.1, !dbg !173
  %43 = load half, ptr addrspace(3) %arrayidx272.1.1, align 2, !dbg !174, !tbaa !175
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %43, i64 1, !dbg !174
  %xor265.2.1 = xor i32 %add264.2, %add258.1, !dbg !178
  %mul266.2.1 = shl nuw nsw i32 %xor265.2.1, 3, !dbg !170
  %add267.2.1 = or disjoint i32 %mul266.2.1, %add253.2, !dbg !171
  %add270.2.1 = or disjoint i32 %add267.2.1, %and269, !dbg !172
  %arrayidx272.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add270.2.1, !dbg !173
  %44 = load half, ptr addrspace(3) %arrayidx272.2.1, align 2, !dbg !174, !tbaa !175
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %44, i64 2, !dbg !174
  %add267.3.1 = or disjoint i32 %mul266.2.1, %add253.3, !dbg !171
  %add270.3.1 = or disjoint i32 %add267.3.1, %and269, !dbg !172
  %arrayidx272.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add270.3.1, !dbg !173
  %45 = load half, ptr addrspace(3) %arrayidx272.3.1, align 2, !dbg !174, !tbaa !175
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %45, i64 3, !dbg !174
  %46 = fptrunc float %mul220.3 to half, !dbg !159
  %__1.sroa.0.6.vec.insert = insertelement <4 x half> %__1.sroa.0.4.vec.insert, half %46, i64 3, !dbg !161
  %47 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !179
  %48 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !179
  br label %if.end301

if.end301:                                        ; preds = %entry.if.end301_crit_edge, %if.end133
  %.pre-phi = phi i32 [ %.pre, %entry.if.end301_crit_edge ], [ %shr65, %if.end133 ]
  %acc_o.sroa.12.0 = phi <4 x float> [ zeroinitializer, %entry.if.end301_crit_edge ], [ %48, %if.end133 ], !dbg !66
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %entry.if.end301_crit_edge ], [ %47, %if.end133 ], !dbg !66
  %mul334 = and i32 %.pre-phi, 252
  %add331 = add nuw nsw i32 %add, %mul334
  %49 = zext nneg i32 %add331 to i64, !dbg !180
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0, !dbg !181
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1, !dbg !181
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2, !dbg !181
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3, !dbg !181
  %50 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !182
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !182, !noalias !186
  %51 = fptrunc float %acc_o.sroa.0.0.vec.extract to half, !dbg !182
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %50), !dbg !182, !noalias !186
  %52 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !191
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !191, !noalias !186
  %53 = fptrunc float %acc_o.sroa.0.4.vec.extract to half, !dbg !191
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %52), !dbg !191, !noalias !186
  %54 = bitcast half %51 to i16, !dbg !193
  %55 = bitcast half %53 to i16, !dbg !196
  %56 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !197
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !197, !noalias !201
  %57 = fptrunc float %acc_o.sroa.0.8.vec.extract to half, !dbg !197
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %56), !dbg !197, !noalias !201
  %58 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !206
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !206, !noalias !201
  %59 = fptrunc float %acc_o.sroa.0.12.vec.extract to half, !dbg !206
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %58), !dbg !206, !noalias !201
  %60 = bitcast half %57 to i16, !dbg !208
  %61 = bitcast half %59 to i16, !dbg !210
  %__2.sroa.6.0.insert.ext = zext i16 %61 to i64, !dbg !211
  %__2.sroa.6.0.insert.shift = shl nuw i64 %__2.sroa.6.0.insert.ext, 48, !dbg !211
  %__2.sroa.5.0.insert.ext = zext i16 %60 to i64, !dbg !211
  %__2.sroa.5.0.insert.shift = shl nuw nsw i64 %__2.sroa.5.0.insert.ext, 32, !dbg !211
  %__2.sroa.5.0.insert.insert = or disjoint i64 %__2.sroa.6.0.insert.shift, %__2.sroa.5.0.insert.shift, !dbg !211
  %__2.sroa.4.0.insert.ext = zext i16 %55 to i64, !dbg !211
  %__2.sroa.4.0.insert.shift = shl nuw nsw i64 %__2.sroa.4.0.insert.ext, 16, !dbg !211
  %__2.sroa.4.0.insert.insert = or disjoint i64 %__2.sroa.5.0.insert.insert, %__2.sroa.4.0.insert.shift, !dbg !211
  %__2.sroa.0.0.insert.ext = zext i16 %54 to i64, !dbg !211
  %__2.sroa.0.0.insert.insert = or disjoint i64 %__2.sroa.4.0.insert.insert, %__2.sroa.0.0.insert.ext, !dbg !211
  %add.ptr337 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %49, !dbg !212
  store i64 %__2.sroa.0.0.insert.insert, ptr addrspace(1) %add.ptr337, align 8, !dbg !213
  %acc_o.sroa.12.16.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 0, !dbg !181
  %acc_o.sroa.12.20.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 1, !dbg !181
  %acc_o.sroa.12.24.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 2, !dbg !181
  %acc_o.sroa.12.28.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 3, !dbg !181
  %62 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !182
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !182, !noalias !186
  %63 = fptrunc float %acc_o.sroa.12.16.vec.extract to half, !dbg !182
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %62), !dbg !182, !noalias !186
  %64 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !191
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !191, !noalias !186
  %65 = fptrunc float %acc_o.sroa.12.20.vec.extract to half, !dbg !191
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %64), !dbg !191, !noalias !186
  %66 = bitcast half %63 to i16, !dbg !193
  %67 = bitcast half %65 to i16, !dbg !196
  %68 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !197
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !197, !noalias !201
  %69 = fptrunc float %acc_o.sroa.12.24.vec.extract to half, !dbg !197
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %68), !dbg !197, !noalias !201
  %70 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !206
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !206, !noalias !201
  %71 = fptrunc float %acc_o.sroa.12.28.vec.extract to half, !dbg !206
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %70), !dbg !206, !noalias !201
  %72 = bitcast half %69 to i16, !dbg !208
  %73 = bitcast half %71 to i16, !dbg !210
  %__2.sroa.6.0.insert.ext.1 = zext i16 %73 to i64, !dbg !211
  %__2.sroa.6.0.insert.shift.1 = shl nuw i64 %__2.sroa.6.0.insert.ext.1, 48, !dbg !211
  %__2.sroa.5.0.insert.ext.1 = zext i16 %72 to i64, !dbg !211
  %__2.sroa.5.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.1, 32, !dbg !211
  %__2.sroa.5.0.insert.insert.1 = or disjoint i64 %__2.sroa.6.0.insert.shift.1, %__2.sroa.5.0.insert.shift.1, !dbg !211
  %__2.sroa.4.0.insert.ext.1 = zext i16 %67 to i64, !dbg !211
  %__2.sroa.4.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.1, 16, !dbg !211
  %__2.sroa.4.0.insert.insert.1 = or disjoint i64 %__2.sroa.5.0.insert.insert.1, %__2.sroa.4.0.insert.shift.1, !dbg !211
  %__2.sroa.0.0.insert.ext.1 = zext i16 %66 to i64, !dbg !211
  %__2.sroa.0.0.insert.insert.1 = or disjoint i64 %__2.sroa.4.0.insert.insert.1, %__2.sroa.0.0.insert.ext.1, !dbg !211
  %74 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %49, !dbg !212
  %add.ptr337.1 = getelementptr inbounds i8, ptr addrspace(1) %74, i64 32, !dbg !212
  store i64 %__2.sroa.0.0.insert.insert.1, ptr addrspace(1) %add.ptr337.1, align 8, !dbg !213
  ret void, !dbg !214
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
!1 = !DIFile(filename: "/tmp/tmp1_70re7m/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmp1_70re7m/tvm_kernels.maca", directory: "")
!42 = !DILocation(line: 77, column: 3, scope: !43, inlinedAt: !45)
!43 = distinct !DISubprogram(name: "__fetch_builtin_x", scope: !44, file: !44, line: 77, type: !7, scopeLine: 77, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!44 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_builtin_vars.h", directory: "")
!45 = distinct !DILocation(line: 21, column: 49, scope: !40)
!46 = !DILocation(line: 21, column: 61, scope: !40)
!47 = !DILocation(line: 67, column: 3, scope: !48, inlinedAt: !49)
!48 = distinct !DISubprogram(name: "__fetch_builtin_x", scope: !44, file: !44, line: 67, type: !7, scopeLine: 67, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!49 = distinct !DILocation(line: 21, column: 78, scope: !40)
!50 = !{i32 0, i32 1024}
!51 = !DILocation(line: 21, column: 97, scope: !40)
!52 = !DILocation(line: 21, column: 68, scope: !40)
!53 = !DILocation(line: 21, column: 133, scope: !40)
!54 = !DILocation(line: 21, column: 104, scope: !40)
!55 = !DILocation(line: 21, column: 38, scope: !40)
!56 = !DILocation(line: 21, column: 24, scope: !40)
!57 = !DILocation(line: 22, column: 25, scope: !40)
!58 = !DILocation(line: 28, column: 31, scope: !40)
!59 = !DILocation(line: 31, column: 28, scope: !40)
!60 = !DILocation(line: 31, column: 56, scope: !40)
!61 = !DILocation(line: 31, column: 34, scope: !40)
!62 = !DILocation(line: 31, column: 63, scope: !40)
!63 = !DILocation(line: 31, column: 9, scope: !40)
!64 = !DILocation(line: 32, column: 15, scope: !40)
!65 = !DILocation(line: 33, column: 5, scope: !40)
!66 = !DILocation(line: 0, scope: !40)
!67 = !DILocation(line: 39, column: 56, scope: !40)
!68 = !DILocation(line: 39, column: 34, scope: !40)
!69 = !DILocation(line: 39, column: 63, scope: !40)
!70 = !DILocation(line: 39, column: 9, scope: !40)
!71 = !DILocation(line: 40, column: 17, scope: !40)
!72 = !DILocation(line: 41, column: 5, scope: !40)
!73 = !DILocation(line: 45, column: 53, scope: !40)
!74 = !DILocation(line: 45, column: 27, scope: !40)
!75 = !DILocation(line: 45, column: 9, scope: !40)
!76 = !DILocation(line: 49, column: 81, scope: !40)
!77 = !DILocation(line: 49, column: 13, scope: !40)
!78 = !DILocation(line: 54, column: 20, scope: !40)
!79 = !DILocation(line: 49, column: 74, scope: !40)
!80 = !DILocation(line: 62, column: 36, scope: !40)
!81 = !{i32 -1, i32 3, i32 -1}
!82 = !DILocation(line: 67, column: 54, scope: !40)
!83 = !DILocation(line: 67, column: 125, scope: !40)
!84 = !DILocation(line: 67, column: 60, scope: !40)
!85 = !DILocation(line: 67, column: 24, scope: !40)
!86 = !DILocation(line: 67, column: 132, scope: !40)
!87 = !DILocation(line: 70, column: 31, scope: !40)
!88 = !DILocation(line: 70, column: 42, scope: !40)
!89 = !DILocation(line: 354, column: 10, scope: !90, inlinedAt: !92)
!90 = distinct !DISubprogram(name: "min", scope: !91, file: !91, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!91 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!92 = distinct !DILocation(line: 70, column: 26, scope: !40)
!93 = !DILocation(line: 285, column: 49, scope: !94, inlinedAt: !95)
!94 = distinct !DISubprogram(name: "exp2f", scope: !91, file: !91, line: 285, type: !7, scopeLine: 285, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!95 = distinct !DILocation(line: 70, column: 20, scope: !40)
!96 = !DILocation(line: 75, column: 34, scope: !40)
!97 = !DILocation(line: 1018, column: 9, scope: !98, inlinedAt: !100)
!98 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !99, file: !99, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!99 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!100 = distinct !DILocation(line: 77, column: 34, scope: !40)
!101 = !DILocation(line: 171, column: 37, scope: !102, inlinedAt: !103)
!102 = distinct !DISubprogram(name: "__lane_id", scope: !99, file: !99, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!103 = distinct !DILocation(line: 990, column: 14, scope: !104, inlinedAt: !105)
!104 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !99, file: !99, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!105 = distinct !DILocation(line: 1019, column: 11, scope: !98, inlinedAt: !100)
!106 = !DILocation(line: 171, column: 10, scope: !102, inlinedAt: !103)
!107 = !DILocation(line: 991, column: 20, scope: !104, inlinedAt: !105)
!108 = !DILocation(line: 992, column: 36, scope: !104, inlinedAt: !105)
!109 = !DILocation(line: 992, column: 17, scope: !104, inlinedAt: !105)
!110 = !DILocation(line: 992, column: 11, scope: !104, inlinedAt: !105)
!111 = !DILocation(line: 993, column: 43, scope: !104, inlinedAt: !105)
!112 = !DILocation(line: 993, column: 10, scope: !104, inlinedAt: !105)
!113 = !DILocation(line: 1020, column: 14, scope: !98, inlinedAt: !100)
!114 = !DILocation(line: 77, column: 32, scope: !40)
!115 = !DILocation(line: 1018, column: 9, scope: !98, inlinedAt: !116)
!116 = distinct !DILocation(line: 78, column: 34, scope: !40)
!117 = !DILocation(line: 171, column: 37, scope: !102, inlinedAt: !118)
!118 = distinct !DILocation(line: 990, column: 14, scope: !104, inlinedAt: !119)
!119 = distinct !DILocation(line: 1019, column: 11, scope: !98, inlinedAt: !116)
!120 = !DILocation(line: 171, column: 10, scope: !102, inlinedAt: !118)
!121 = !DILocation(line: 991, column: 20, scope: !104, inlinedAt: !119)
!122 = !DILocation(line: 992, column: 36, scope: !104, inlinedAt: !119)
!123 = !DILocation(line: 992, column: 17, scope: !104, inlinedAt: !119)
!124 = !DILocation(line: 992, column: 11, scope: !104, inlinedAt: !119)
!125 = !DILocation(line: 993, column: 43, scope: !104, inlinedAt: !119)
!126 = !DILocation(line: 993, column: 10, scope: !104, inlinedAt: !119)
!127 = !DILocation(line: 1020, column: 14, scope: !98, inlinedAt: !116)
!128 = !DILocation(line: 78, column: 32, scope: !40)
!129 = !DILocation(line: 80, column: 34, scope: !40)
!130 = !DILocation(line: 80, column: 9, scope: !40)
!131 = !DILocation(line: 88, column: 32, scope: !40)
!132 = !DILocation(line: 1007, column: 10, scope: !133, inlinedAt: !135)
!133 = distinct !DISubprogram(name: "__float2half_rn", scope: !134, file: !134, line: 1005, type: !7, scopeLine: 1005, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!134 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!135 = distinct !DILocation(line: 1077, column: 18, scope: !136, inlinedAt: !137)
!136 = distinct !DISubprogram(name: "__floats2half2_rn", scope: !134, file: !134, line: 1075, type: !7, scopeLine: 1076, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!137 = distinct !DILocation(line: 1295, column: 23, scope: !138, inlinedAt: !139)
!138 = distinct !DISubprogram(name: "__float22half2_rn", scope: !134, file: !134, line: 1294, type: !7, scopeLine: 1294, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!139 = distinct !DILocation(line: 92, column: 27, scope: !40)
!140 = !{!141, !143}
!141 = distinct !{!141, !142, !"_ZL17__floats2half2_rnff: %agg.result"}
!142 = distinct !{!142, !"_ZL17__floats2half2_rnff"}
!143 = distinct !{!143, !144, !"_ZL17__float22half2_rn6float2: %agg.result"}
!144 = distinct !{!144, !"_ZL17__float22half2_rn6float2"}
!145 = !DILocation(line: 1007, column: 10, scope: !133, inlinedAt: !146)
!146 = distinct !DILocation(line: 1077, column: 38, scope: !136, inlinedAt: !137)
!147 = !DILocation(line: 593, column: 26, scope: !148, inlinedAt: !149)
!148 = distinct !DISubprogram(name: "operator=", scope: !134, file: !134, line: 592, type: !7, scopeLine: 592, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!149 = distinct !DILocation(line: 92, column: 25, scope: !40)
!150 = !DILocation(line: 1007, column: 10, scope: !133, inlinedAt: !151)
!151 = distinct !DILocation(line: 1077, column: 18, scope: !136, inlinedAt: !152)
!152 = distinct !DILocation(line: 1295, column: 23, scope: !138, inlinedAt: !153)
!153 = distinct !DILocation(line: 93, column: 27, scope: !40)
!154 = !{!155, !157}
!155 = distinct !{!155, !156, !"_ZL17__floats2half2_rnff: %agg.result"}
!156 = distinct !{!156, !"_ZL17__floats2half2_rnff"}
!157 = distinct !{!157, !158, !"_ZL17__float22half2_rn6float2: %agg.result"}
!158 = distinct !{!158, !"_ZL17__float22half2_rn6float2"}
!159 = !DILocation(line: 1007, column: 10, scope: !133, inlinedAt: !160)
!160 = distinct !DILocation(line: 1077, column: 38, scope: !136, inlinedAt: !152)
!161 = !DILocation(line: 593, column: 26, scope: !148, inlinedAt: !162)
!162 = distinct !DILocation(line: 93, column: 25, scope: !40)
!163 = !DILocation(line: 68, column: 3, scope: !164, inlinedAt: !165)
!164 = distinct !DISubprogram(name: "__barrier_warp", scope: !99, file: !99, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!165 = distinct !DILocation(line: 192, column: 3, scope: !166, inlinedAt: !167)
!166 = distinct !DISubprogram(name: "__syncwarp", scope: !99, file: !99, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!167 = distinct !DILocation(line: 95, column: 5, scope: !40)
!168 = !DILocation(line: 69, column: 3, scope: !164, inlinedAt: !165)
!169 = !DILocation(line: 70, column: 3, scope: !164, inlinedAt: !165)
!170 = !DILocation(line: 98, column: 216, scope: !40)
!171 = !DILocation(line: 98, column: 103, scope: !40)
!172 = !DILocation(line: 98, column: 222, scope: !40)
!173 = !DILocation(line: 98, column: 38, scope: !40)
!174 = !DILocation(line: 98, column: 36, scope: !40)
!175 = !{!26, !26, i64 0}
!176 = !DILocation(line: 98, column: 84, scope: !40)
!177 = !DILocation(line: 98, column: 196, scope: !40)
!178 = !DILocation(line: 98, column: 154, scope: !40)
!179 = !DILocation(line: 103, column: 38, scope: !40)
!180 = !DILocation(line: 110, column: 3, scope: !40)
!181 = !DILocation(line: 112, column: 19, scope: !40)
!182 = !DILocation(line: 1007, column: 10, scope: !133, inlinedAt: !183)
!183 = distinct !DILocation(line: 1077, column: 18, scope: !136, inlinedAt: !184)
!184 = distinct !DILocation(line: 1295, column: 23, scope: !138, inlinedAt: !185)
!185 = distinct !DILocation(line: 113, column: 27, scope: !40)
!186 = !{!187, !189}
!187 = distinct !{!187, !188, !"_ZL17__floats2half2_rnff: %agg.result"}
!188 = distinct !{!188, !"_ZL17__floats2half2_rnff"}
!189 = distinct !{!189, !190, !"_ZL17__float22half2_rn6float2: %agg.result"}
!190 = distinct !{!190, !"_ZL17__float22half2_rn6float2"}
!191 = !DILocation(line: 1007, column: 10, scope: !133, inlinedAt: !192)
!192 = distinct !DILocation(line: 1077, column: 38, scope: !136, inlinedAt: !184)
!193 = !DILocation(line: 596, column: 67, scope: !194, inlinedAt: !195)
!194 = distinct !DISubprogram(name: "__half2", scope: !134, file: !134, line: 596, type: !7, scopeLine: 596, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!195 = distinct !DILocation(line: 1077, column: 10, scope: !136, inlinedAt: !184)
!196 = !DILocation(line: 596, column: 73, scope: !194, inlinedAt: !195)
!197 = !DILocation(line: 1007, column: 10, scope: !133, inlinedAt: !198)
!198 = distinct !DILocation(line: 1077, column: 18, scope: !136, inlinedAt: !199)
!199 = distinct !DILocation(line: 1295, column: 23, scope: !138, inlinedAt: !200)
!200 = distinct !DILocation(line: 114, column: 27, scope: !40)
!201 = !{!202, !204}
!202 = distinct !{!202, !203, !"_ZL17__floats2half2_rnff: %agg.result"}
!203 = distinct !{!203, !"_ZL17__floats2half2_rnff"}
!204 = distinct !{!204, !205, !"_ZL17__float22half2_rn6float2: %agg.result"}
!205 = distinct !{!205, !"_ZL17__float22half2_rn6float2"}
!206 = !DILocation(line: 1007, column: 10, scope: !133, inlinedAt: !207)
!207 = distinct !DILocation(line: 1077, column: 38, scope: !136, inlinedAt: !199)
!208 = !DILocation(line: 596, column: 67, scope: !194, inlinedAt: !209)
!209 = distinct !DILocation(line: 1077, column: 10, scope: !136, inlinedAt: !199)
!210 = !DILocation(line: 596, column: 73, scope: !194, inlinedAt: !209)
!211 = !DILocation(line: 115, column: 38, scope: !40)
!212 = !DILocation(line: 116, column: 22, scope: !40)
!213 = !DILocation(line: 116, column: 139, scope: !40)
!214 = !DILocation(line: 118, column: 1, scope: !40)
