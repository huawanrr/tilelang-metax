; ModuleID = '/data/tilelang-metax/race_tests/nsa/experiments/20261014_resume8933/validation_v12_final/actual_binary/legacy_s2_t37_h2_m0_p0.bc'
source_filename = "/tmp/tmpipa3wm_x/tvm_kernels.maca"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "mxc-metax-macahca"

%struct.mcDevMallocInfo.0 = type { i32, i32, ptr }
%struct.__half = type { i16 }

@buf_dyn_shmem = external protected local_unnamed_addr addrspace(3) global [0 x i8], align 1024
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
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul = shl nsw i32 %0, 2
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul7 = shl nuw nsw i32 %1, 1
  %add = add nuw nsw i32 %mul, %mul7
  %2 = zext nneg i32 %add to i64, !dbg !42
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %2, !dbg !43
  %3 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !43, !tbaa !30
  %cmp10 = icmp ult i32 %3, 3
  %4 = shl nsw i32 %3, 4, !dbg !44
  %mul11 = select i1 %cmp10, i32 %4, i32 -16, !dbg !44
  %5 = or disjoint i64 %2, 1, !dbg !45
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %5, !dbg !43
  %6 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !dbg !43, !tbaa !30
  %cmp10.1 = icmp ult i32 %6, 3
  %7 = shl nsw i32 %6, 4, !dbg !44
  %mul11.1 = select i1 %cmp10.1, i32 %7, i32 -16, !dbg !44
  %mul20 = shl nsw i32 %0, 11
  %mul22 = shl nsw i32 %1, 10
  %add23 = add nuw nsw i32 %mul20, %mul22
  %8 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !46
  %and = shl nuw nsw i32 %8, 6
  %mul25 = and i32 %and, 960
  %add26 = or disjoint i32 %add23, %mul25
  %9 = lshr i32 %8, 1
  %mul30 = and i32 %9, 504
  %add28 = add nuw nsw i32 %add26, %mul30
  %10 = zext nneg i32 %add28 to i64, !dbg !47
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %10, !dbg !48
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16, !dbg !49
  %Q_reg.sroa.5.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !49
  %Q_reg.sroa.5.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.5.0.add.ptr.sroa_idx, align 8, !dbg !49
  %11 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %10, !dbg !48
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %11, i64 64, !dbg !48
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16, !dbg !49
  %Q_reg.sroa.10.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %11, i64 72, !dbg !49
  %Q_reg.sroa.10.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.10.16.add.ptr.1.sroa_idx, align 8, !dbg !49
  %shr73 = lshr i32 %8, 3
  %12 = shl nuw nsw i32 %8, 4
  %mul81 = and i32 %12, 16256
  %mul86 = shl nsw i32 %1, 6
  %add82 = add nuw nsw i32 %mul81, %mul86
  %and89 = shl nuw nsw i32 %8, 3
  %mul90 = and i32 %and89, 56
  %add84 = or disjoint i32 %add82, %mul90
  %mul192 = and i32 %and89, 8128
  %call196.masked = and i32 %8, 1016
  %mul198 = xor i32 %mul90, %call196.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul192
  %invariant.gep675 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul198
  %13 = lshr i32 %8, 2
  %mul213 = and i32 %13, 252
  %shr245 = lshr i32 %8, 4
  %and248 = and i32 %8, 7
  %14 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul25
  %invariant.gep687 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 2048
  %mul361 = and i32 %12, 16128
  %shr367 = and i32 %shr73, 1
  %mul372 = and i32 %13, 4
  %or.cond702 = icmp ult i32 %mul11, 37, !dbg !50
  br i1 %or.cond702, label %for.cond67.preheader, label %if.end231, !dbg !50

for.cond67.preheader:                             ; preds = %entry
  %add74 = add nuw nsw i32 %mul11, %shr73
  %mul83 = shl nuw nsw i32 %mul11, 7
  %add87 = add nuw nsw i32 %add84, %mul83
  %15 = zext nneg i32 %add87 to i64, !dbg !51
  %cmp76 = icmp slt i32 %add74, 37, !dbg !52
  br i1 %cmp76, label %if.then77, label %if.end115, !dbg !53

if.then77:                                        ; preds = %for.cond67.preheader
  %add.ptr93 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %15, !dbg !54
  %condval_1.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr93, align 16, !dbg !55, !tbaa !30
  %condval_1.sroa.5.0.add.ptr93.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr93, i64 4, !dbg !55
  %condval_1.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr93.sroa_idx, align 4, !dbg !55, !tbaa !30
  %condval_1.sroa.6.0.add.ptr93.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr93, i64 8, !dbg !55
  %condval_1.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr93.sroa_idx, align 8, !dbg !55, !tbaa !30
  %condval_1.sroa.7.0.add.ptr93.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr93, i64 12, !dbg !55
  %condval_1.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr93.sroa_idx, align 4, !dbg !55, !tbaa !30
  br label %if.end115, !dbg !56

if.end115:                                        ; preds = %for.cond67.preheader, %if.then77
  %condval_1.sroa.0.0 = phi i32 [ %condval_1.sroa.0.0.copyload, %if.then77 ], [ 0, %for.cond67.preheader ], !dbg !57
  %condval_1.sroa.5.0 = phi i32 [ %condval_1.sroa.5.0.copyload, %if.then77 ], [ 0, %for.cond67.preheader ], !dbg !57
  %condval_1.sroa.6.0 = phi i32 [ %condval_1.sroa.6.0.copyload, %if.then77 ], [ 0, %for.cond67.preheader ], !dbg !57
  %condval_1.sroa.7.0 = phi i32 [ %condval_1.sroa.7.0.copyload, %if.then77 ], [ 0, %for.cond67.preheader ], !dbg !57
  %cmp76.1 = icmp slt i32 %add74, 29, !dbg !52
  br i1 %cmp76.1, label %if.then77.1, label %if.end115.1, !dbg !53

if.then77.1:                                      ; preds = %if.end115
  %16 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %15, !dbg !54
  %add.ptr93.1 = getelementptr inbounds i8, ptr addrspace(4) %16, i64 2048, !dbg !54
  %condval_1.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr93.1, align 16, !dbg !55, !tbaa !30
  %condval_1.sroa.5.0.add.ptr93.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %16, i64 2052, !dbg !55
  %condval_1.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr93.sroa_idx.1, align 4, !dbg !55, !tbaa !30
  %condval_1.sroa.6.0.add.ptr93.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %16, i64 2056, !dbg !55
  %condval_1.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr93.sroa_idx.1, align 8, !dbg !55, !tbaa !30
  %condval_1.sroa.7.0.add.ptr93.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %16, i64 2060, !dbg !55
  %condval_1.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr93.sroa_idx.1, align 4, !dbg !55, !tbaa !30
  br label %if.end115.1, !dbg !56

if.end115.1:                                      ; preds = %if.then77.1, %if.end115
  %condval_1.sroa.0.0.1 = phi i32 [ %condval_1.sroa.0.0.copyload.1, %if.then77.1 ], [ 0, %if.end115 ], !dbg !57
  %condval_1.sroa.5.0.1 = phi i32 [ %condval_1.sroa.5.0.copyload.1, %if.then77.1 ], [ 0, %if.end115 ], !dbg !57
  %condval_1.sroa.6.0.1 = phi i32 [ %condval_1.sroa.6.0.copyload.1, %if.then77.1 ], [ 0, %if.end115 ], !dbg !57
  %condval_1.sroa.7.0.1 = phi i32 [ %condval_1.sroa.7.0.copyload.1, %if.then77.1 ], [ 0, %if.end115 ], !dbg !57
  br i1 %cmp76, label %if.then133, label %if.end173, !dbg !58

if.then133:                                       ; preds = %if.end115.1
  %add.ptr149 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %15, !dbg !59
  %condval_2.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr149, align 16, !dbg !60, !tbaa !30
  %condval_2.sroa.5.0.add.ptr149.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr149, i64 4, !dbg !60
  %condval_2.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr149.sroa_idx, align 4, !dbg !60, !tbaa !30
  %condval_2.sroa.6.0.add.ptr149.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr149, i64 8, !dbg !60
  %condval_2.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr149.sroa_idx, align 8, !dbg !60, !tbaa !30
  %condval_2.sroa.7.0.add.ptr149.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr149, i64 12, !dbg !60
  %condval_2.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr149.sroa_idx, align 4, !dbg !60, !tbaa !30
  br label %if.end173, !dbg !61

if.end173:                                        ; preds = %if.end115.1, %if.then133
  %condval_2.sroa.0.0 = phi i32 [ %condval_2.sroa.0.0.copyload, %if.then133 ], [ 0, %if.end115.1 ], !dbg !57
  %condval_2.sroa.5.0 = phi i32 [ %condval_2.sroa.5.0.copyload, %if.then133 ], [ 0, %if.end115.1 ], !dbg !57
  %condval_2.sroa.6.0 = phi i32 [ %condval_2.sroa.6.0.copyload, %if.then133 ], [ 0, %if.end115.1 ], !dbg !57
  %condval_2.sroa.7.0 = phi i32 [ %condval_2.sroa.7.0.copyload, %if.then133 ], [ 0, %if.end115.1 ], !dbg !57
  br i1 %cmp76.1, label %if.then133.1, label %if.end173.1, !dbg !58

if.then133.1:                                     ; preds = %if.end173
  %17 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %15, !dbg !59
  %add.ptr149.1 = getelementptr inbounds i8, ptr addrspace(4) %17, i64 2048, !dbg !59
  %condval_2.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr149.1, align 16, !dbg !60, !tbaa !30
  %condval_2.sroa.5.0.add.ptr149.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %17, i64 2052, !dbg !60
  %condval_2.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr149.sroa_idx.1, align 4, !dbg !60, !tbaa !30
  %condval_2.sroa.6.0.add.ptr149.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %17, i64 2056, !dbg !60
  %condval_2.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr149.sroa_idx.1, align 8, !dbg !60, !tbaa !30
  %condval_2.sroa.7.0.add.ptr149.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %17, i64 2060, !dbg !60
  %condval_2.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr149.sroa_idx.1, align 4, !dbg !60, !tbaa !30
  br label %if.end173.1, !dbg !61

if.end173.1:                                      ; preds = %if.then133.1, %if.end173
  %condval_2.sroa.0.0.1 = phi i32 [ %condval_2.sroa.0.0.copyload.1, %if.then133.1 ], [ 0, %if.end173 ], !dbg !57
  %condval_2.sroa.5.0.1 = phi i32 [ %condval_2.sroa.5.0.copyload.1, %if.then133.1 ], [ 0, %if.end173 ], !dbg !57
  %condval_2.sroa.6.0.1 = phi i32 [ %condval_2.sroa.6.0.copyload.1, %if.then133.1 ], [ 0, %if.end173 ], !dbg !57
  %condval_2.sroa.7.0.1 = phi i32 [ %condval_2.sroa.7.0.copyload.1, %if.then133.1 ], [ 0, %if.end173 ], !dbg !57
  store i32 %condval_1.sroa.0.0, ptr addrspace(3) %invariant.gep675, align 16, !dbg !62, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep675.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 4, !dbg !62
  store i32 %condval_1.sroa.5.0, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep675.sroa_idx, align 4, !dbg !62, !tbaa !30
  %K_reg.sroa.8.0.invariant.gep675.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 8, !dbg !62
  store i32 %condval_1.sroa.6.0, ptr addrspace(3) %K_reg.sroa.8.0.invariant.gep675.sroa_idx, align 8, !dbg !62, !tbaa !30
  %K_reg.sroa.10.0.invariant.gep675.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 12, !dbg !62
  store i32 %condval_1.sroa.7.0, ptr addrspace(3) %K_reg.sroa.10.0.invariant.gep675.sroa_idx, align 4, !dbg !62, !tbaa !30
  %gep676.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 1024, !dbg !63
  store i32 %condval_1.sroa.0.0.1, ptr addrspace(3) %gep676.1, align 16, !dbg !62, !tbaa !30
  %K_reg.sroa.16.16.gep676.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 1028, !dbg !62
  store i32 %condval_1.sroa.5.0.1, ptr addrspace(3) %K_reg.sroa.16.16.gep676.1.sroa_idx, align 4, !dbg !62, !tbaa !30
  %K_reg.sroa.18.16.gep676.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 1032, !dbg !62
  store i32 %condval_1.sroa.6.0.1, ptr addrspace(3) %K_reg.sroa.18.16.gep676.1.sroa_idx, align 8, !dbg !62, !tbaa !30
  %K_reg.sroa.20.16.gep676.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 1036, !dbg !62
  store i32 %condval_1.sroa.7.0.1, ptr addrspace(3) %K_reg.sroa.20.16.gep676.1.sroa_idx, align 4, !dbg !62, !tbaa !30
  %cmp205 = icmp sgt i32 %mul11, 21, !dbg !64
  br i1 %cmp205, label %for.cond207.preheader, label %if.end231, !dbg !65

for.cond207.preheader:                            ; preds = %if.end173.1
  %add214 = add nuw nsw i32 %mul11, %mul213
  %cmp216 = icmp slt i32 %add214, 37, !dbg !66
  %.fneg = select i1 %cmp216, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.0.vec.insert881 = insertelement <4 x float> poison, float %.fneg, i64 0, !dbg !67
  %add215.1 = or disjoint i32 %add214, 1, !dbg !68
  %cmp216.1 = icmp slt i32 %add215.1, 37, !dbg !66
  %.fneg.1 = select i1 %cmp216.1, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert906 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert881, float %.fneg.1, i64 1, !dbg !67
  %add215.2 = or disjoint i32 %add214, 2, !dbg !68
  %cmp216.2 = icmp slt i32 %add215.2, 37, !dbg !66
  %.fneg.2 = select i1 %cmp216.2, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.8.vec.insert927 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert906, float %.fneg.2, i64 2, !dbg !67
  %add215.3 = or disjoint i32 %add214, 3, !dbg !68
  %cmp216.3 = icmp slt i32 %add215.3, 37, !dbg !66
  %.fneg.3 = select i1 %cmp216.3, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.12.vec.insert948 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert927, float %.fneg.3, i64 3, !dbg !67
  br label %if.end231, !dbg !69

if.end231:                                        ; preds = %if.end173.1, %for.cond207.preheader, %entry
  %V_reg.sroa.20.0 = phi i32 [ %condval_2.sroa.7.0.1, %for.cond207.preheader ], [ undef, %entry ], [ %condval_2.sroa.7.0.1, %if.end173.1 ]
  %V_reg.sroa.18.0 = phi i32 [ %condval_2.sroa.6.0.1, %for.cond207.preheader ], [ undef, %entry ], [ %condval_2.sroa.6.0.1, %if.end173.1 ]
  %V_reg.sroa.16.0 = phi i32 [ %condval_2.sroa.5.0.1, %for.cond207.preheader ], [ undef, %entry ], [ %condval_2.sroa.5.0.1, %if.end173.1 ]
  %V_reg.sroa.12.0 = phi i32 [ %condval_2.sroa.0.0.1, %for.cond207.preheader ], [ undef, %entry ], [ %condval_2.sroa.0.0.1, %if.end173.1 ]
  %V_reg.sroa.10.0 = phi i32 [ %condval_2.sroa.7.0, %for.cond207.preheader ], [ undef, %entry ], [ %condval_2.sroa.7.0, %if.end173.1 ]
  %V_reg.sroa.8.0 = phi i32 [ %condval_2.sroa.6.0, %for.cond207.preheader ], [ undef, %entry ], [ %condval_2.sroa.6.0, %if.end173.1 ]
  %V_reg.sroa.6.0 = phi i32 [ %condval_2.sroa.5.0, %for.cond207.preheader ], [ undef, %entry ], [ %condval_2.sroa.5.0, %if.end173.1 ]
  %V_reg.sroa.0.0 = phi i32 [ %condval_2.sroa.0.0, %for.cond207.preheader ], [ undef, %entry ], [ %condval_2.sroa.0.0, %if.end173.1 ]
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert948, %for.cond207.preheader ], [ undef, %entry ], [ zeroinitializer, %if.end173.1 ]
  fence syncscope("block") release, !dbg !69
  tail call void @llvm.mxc.barrier(), !dbg !75
  fence syncscope("block") acquire, !dbg !76
  br i1 %or.cond702, label %for.cond236.preheader, label %if.end346, !dbg !77

for.cond236.preheader:                            ; preds = %if.end231
  %xor249 = xor i32 %shr245, %and248, !dbg !78
  %add.ptr253.idx = shl nuw nsw i32 %xor249, 4, !dbg !79
  %add.ptr253 = getelementptr inbounds i8, ptr addrspace(3) %14, i32 %add.ptr253.idx, !dbg !79
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr253, align 16, !dbg !80
  %kb.sroa.10.0.add.ptr253.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr253, i32 8, !dbg !80
  %kb.sroa.10.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr253.sroa_idx, align 8, !dbg !80
  %18 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !dbg !81, !call_argsrelate !82
  %19 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload, <4 x half> %Q_reg.sroa.5.0.copyload, <4 x float> %18), !dbg !81, !call_argsrelate !82
  %add246.1 = add nuw nsw i32 %shr245, 4, !dbg !83
  %xor249.1 = xor i32 %add246.1, %and248, !dbg !78
  %add.ptr253.idx.1 = shl nuw nsw i32 %xor249.1, 4, !dbg !79
  %add.ptr253.1 = getelementptr inbounds i8, ptr addrspace(3) %14, i32 %add.ptr253.idx.1, !dbg !79
  %kb.sroa.0.0.copyload868 = load <4 x half>, ptr addrspace(3) %add.ptr253.1, align 16, !dbg !80
  %kb.sroa.10.0.add.ptr253.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr253.1, i32 8, !dbg !80
  %kb.sroa.10.0.copyload871 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr253.1.sroa_idx, align 8, !dbg !80
  %20 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload868, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %19), !dbg !81, !call_argsrelate !82
  %21 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload871, <4 x half> %Q_reg.sroa.10.16.copyload, <4 x float> %20), !dbg !81, !call_argsrelate !82
  store i32 %V_reg.sroa.0.0, ptr addrspace(3) %invariant.gep687, align 16, !dbg !84, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep687.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 2052, !dbg !84
  store i32 %V_reg.sroa.6.0, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep687.sroa_idx, align 4, !dbg !84, !tbaa !30
  %V_reg.sroa.8.0.invariant.gep687.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 2056, !dbg !84
  store i32 %V_reg.sroa.8.0, ptr addrspace(3) %V_reg.sroa.8.0.invariant.gep687.sroa_idx, align 8, !dbg !84, !tbaa !30
  %V_reg.sroa.10.0.invariant.gep687.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 2060, !dbg !84
  store i32 %V_reg.sroa.10.0, ptr addrspace(3) %V_reg.sroa.10.0.invariant.gep687.sroa_idx, align 4, !dbg !84, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 3072, !dbg !85
  store i32 %V_reg.sroa.12.0, ptr addrspace(3) %gep.1, align 16, !dbg !84, !tbaa !30
  %V_reg.sroa.16.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 3076, !dbg !84
  store i32 %V_reg.sroa.16.0, ptr addrspace(3) %V_reg.sroa.16.16.gep.1.sroa_idx, align 4, !dbg !84, !tbaa !30
  %V_reg.sroa.18.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 3080, !dbg !84
  store i32 %V_reg.sroa.18.0, ptr addrspace(3) %V_reg.sroa.18.16.gep.1.sroa_idx, align 8, !dbg !84, !tbaa !30
  %V_reg.sroa.20.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 3084, !dbg !84
  store i32 %V_reg.sroa.20.0, ptr addrspace(3) %V_reg.sroa.20.16.gep.1.sroa_idx, align 4, !dbg !84, !tbaa !30
  %acc_s.sroa.0.0.vec.extract883 = extractelement <4 x float> %21, i64 0, !dbg !86
  %mul310 = fmul contract float %acc_s.sroa.0.0.vec.extract883, 0x3FC2776C60000000, !dbg !87
  %22 = tail call contract noundef float @llvm.minnum.f32(float %mul310, float 1.500000e+01), !dbg !88
  %cmp.i.i = fcmp contract olt float %22, -1.260000e+02, !dbg !92
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00, !dbg !92
  %add.i.i636 = fadd contract float %22, %cond.i.i, !dbg !92
  %23 = tail call contract float @llvm.exp2.f32(float %add.i.i636), !dbg !92
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00, !dbg !92
  %mul.i.i = fmul contract float %cond2.i.i, %23, !dbg !92
  %acc_s.sroa.0.0.vec.insert885 = insertelement <4 x float> poison, float %mul.i.i, i64 0, !dbg !95
  %acc_s.sroa.0.4.vec.extract908 = extractelement <4 x float> %21, i64 1, !dbg !86
  %mul310.1 = fmul contract float %acc_s.sroa.0.4.vec.extract908, 0x3FC2776C60000000, !dbg !87
  %24 = tail call contract noundef float @llvm.minnum.f32(float %mul310.1, float 1.500000e+01), !dbg !88
  %cmp.i.i.1 = fcmp contract olt float %24, -1.260000e+02, !dbg !92
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00, !dbg !92
  %add.i.i636.1 = fadd contract float %24, %cond.i.i.1, !dbg !92
  %25 = tail call contract float @llvm.exp2.f32(float %add.i.i636.1), !dbg !92
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !92
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %25, !dbg !92
  %acc_s.sroa.0.4.vec.insert910 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert885, float %mul.i.i.1, i64 1, !dbg !95
  %acc_s.sroa.0.8.vec.extract929 = extractelement <4 x float> %21, i64 2, !dbg !86
  %mul310.2 = fmul contract float %acc_s.sroa.0.8.vec.extract929, 0x3FC2776C60000000, !dbg !87
  %26 = tail call contract noundef float @llvm.minnum.f32(float %mul310.2, float 1.500000e+01), !dbg !88
  %cmp.i.i.2 = fcmp contract olt float %26, -1.260000e+02, !dbg !92
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00, !dbg !92
  %add.i.i636.2 = fadd contract float %26, %cond.i.i.2, !dbg !92
  %27 = tail call contract float @llvm.exp2.f32(float %add.i.i636.2), !dbg !92
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00, !dbg !92
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %27, !dbg !92
  %acc_s.sroa.0.8.vec.insert931 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert910, float %mul.i.i.2, i64 2, !dbg !95
  %acc_s.sroa.0.12.vec.extract950 = extractelement <4 x float> %21, i64 3, !dbg !86
  %mul310.3 = fmul contract float %acc_s.sroa.0.12.vec.extract950, 0x3FC2776C60000000, !dbg !87
  %28 = tail call contract noundef float @llvm.minnum.f32(float %mul310.3, float 1.500000e+01), !dbg !88
  %cmp.i.i.3 = fcmp contract olt float %28, -1.260000e+02, !dbg !92
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00, !dbg !92
  %add.i.i636.3 = fadd contract float %28, %cond.i.i.3, !dbg !92
  %29 = tail call contract float @llvm.exp2.f32(float %add.i.i636.3), !dbg !92
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00, !dbg !92
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %29, !dbg !92
  %acc_s.sroa.0.12.vec.insert952 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert931, float %mul.i.i.3, i64 3, !dbg !95
  %add326 = fadd contract float %mul.i.i, 0.000000e+00, !dbg !96
  %add326.1 = fadd contract float %mul.i.i.1, 0.000000e+00, !dbg !96
  %add326.2 = fadd contract float %mul.i.i.2, 0.000000e+00, !dbg !96
  %add326.3 = fadd contract float %mul.i.i.3, 0.000000e+00, !dbg !96
  %30 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !97
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !97, !noalias !105
  %31 = fptrunc float %mul.i.i to half, !dbg !97
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %30), !dbg !97, !noalias !105
  %32 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !110
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !110, !noalias !105
  %33 = fptrunc float %mul.i.i.1 to half, !dbg !110
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %32), !dbg !110, !noalias !105
  %__1.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %31, i64 0, !dbg !112
  %__1.sroa.0.2.vec.insert = insertelement <4 x half> %__1.sroa.0.0.vec.insert, half %33, i64 1, !dbg !112
  %34 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !115
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !115, !noalias !119
  %35 = fptrunc float %mul.i.i.2 to half, !dbg !115
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %34), !dbg !115, !noalias !119
  %36 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !124
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !124, !noalias !119
  %37 = fptrunc float %mul.i.i.3 to half, !dbg !124
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %36), !dbg !124, !noalias !119
  %__1.sroa.0.4.vec.insert = insertelement <4 x half> %__1.sroa.0.2.vec.insert, half %35, i64 2, !dbg !126
  %__1.sroa.0.6.vec.insert = insertelement <4 x half> %__1.sroa.0.4.vec.insert, half %37, i64 3, !dbg !126
  br label %if.end346, !dbg !128

if.end346:                                        ; preds = %for.cond236.preheader, %if.end231
  %sum_acc.sroa.20.0 = phi float [ %add326.3, %for.cond236.preheader ], [ 0.000000e+00, %if.end231 ], !dbg !57
  %sum_acc.sroa.14.0 = phi float [ %add326.2, %for.cond236.preheader ], [ 0.000000e+00, %if.end231 ], !dbg !57
  %sum_acc.sroa.8.0 = phi float [ %add326.1, %for.cond236.preheader ], [ 0.000000e+00, %if.end231 ], !dbg !57
  %sum_acc.sroa.0.0 = phi float [ %add326, %for.cond236.preheader ], [ 0.000000e+00, %if.end231 ], !dbg !57
  %acc_s.sroa.0.1 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert952, %for.cond236.preheader ], [ %acc_s.sroa.0.0, %if.end231 ], !dbg !57
  %acc_s_cast.sroa.0.1 = phi <4 x half> [ %__1.sroa.0.6.vec.insert, %for.cond236.preheader ], [ undef, %if.end231 ]
  fence syncscope("block") release, !dbg !129
  tail call void @llvm.mxc.barrier(), !dbg !132
  fence syncscope("block") acquire, !dbg !133
  br i1 %or.cond702, label %for.cond355.preheader.preheader, label %if.end411, !dbg !134

for.cond355.preheader.preheader:                  ; preds = %if.end346
  %xor374 = or disjoint i32 %mul372, %shr367, !dbg !135
  %mul375 = shl nuw nsw i32 %xor374, 3, !dbg !136
  %add376 = or disjoint i32 %mul375, %mul361, !dbg !137
  %add379 = or disjoint i32 %add376, %and248, !dbg !138
  %gep691 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379, !dbg !139
  %38 = load half, ptr addrspace(3) %gep691, align 2, !dbg !140, !tbaa !141
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %38, i64 0, !dbg !140
  %add363.1 = or disjoint i32 %mul361, 64, !dbg !142
  %add373.1 = or disjoint i32 %mul372, 1, !dbg !143
  %xor374.1 = xor i32 %add373.1, %shr367, !dbg !135
  %mul375.1 = shl nuw nsw i32 %xor374.1, 3, !dbg !136
  %add376.1 = or disjoint i32 %mul375.1, %add363.1, !dbg !137
  %add379.1 = or disjoint i32 %add376.1, %and248, !dbg !138
  %gep691.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1, !dbg !139
  %39 = load half, ptr addrspace(3) %gep691.1, align 2, !dbg !140, !tbaa !141
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %39, i64 1, !dbg !140
  %add363.2 = or disjoint i32 %mul361, 128, !dbg !142
  %add373.2 = or disjoint i32 %mul372, 2, !dbg !143
  %xor374.2 = or disjoint i32 %add373.2, %shr367, !dbg !135
  %mul375.2 = shl nuw nsw i32 %xor374.2, 3, !dbg !136
  %add376.2 = or disjoint i32 %mul375.2, %add363.2, !dbg !137
  %add379.2 = or disjoint i32 %add376.2, %and248, !dbg !138
  %gep691.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.2, !dbg !139
  %40 = load half, ptr addrspace(3) %gep691.2, align 2, !dbg !140, !tbaa !141
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %40, i64 2, !dbg !140
  %add363.3 = or disjoint i32 %mul361, 192, !dbg !142
  %add373.3 = or disjoint i32 %mul372, 3, !dbg !143
  %xor374.3 = xor i32 %add373.3, %shr367, !dbg !135
  %mul375.3 = shl nuw nsw i32 %xor374.3, 3, !dbg !136
  %add376.3 = or disjoint i32 %mul375.3, %add363.3, !dbg !137
  %add379.3 = or disjoint i32 %add376.3, %and248, !dbg !138
  %gep691.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.3, !dbg !139
  %41 = load half, ptr addrspace(3) %gep691.3, align 2, !dbg !140, !tbaa !141
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %41, i64 3, !dbg !140
  %add368.1 = or disjoint i32 %shr367, 2
  %xor374.1723 = or disjoint i32 %mul372, %add368.1, !dbg !135
  %mul375.1724 = shl nuw nsw i32 %xor374.1723, 3, !dbg !136
  %add376.1725 = or disjoint i32 %mul375.1724, %mul361, !dbg !137
  %add379.1726 = or disjoint i32 %add376.1725, %and248, !dbg !138
  %gep691.1727 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1726, !dbg !139
  %42 = load half, ptr addrspace(3) %gep691.1727, align 2, !dbg !140, !tbaa !141
  %vb.sroa.12.8.vec.insert = insertelement <4 x half> poison, half %42, i64 0, !dbg !140
  %xor374.1.1 = xor i32 %add373.1, %add368.1, !dbg !135
  %mul375.1.1 = shl nuw nsw i32 %xor374.1.1, 3, !dbg !136
  %add376.1.1 = or disjoint i32 %mul375.1.1, %add363.1, !dbg !137
  %add379.1.1 = or disjoint i32 %add376.1.1, %and248, !dbg !138
  %gep691.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1.1, !dbg !139
  %43 = load half, ptr addrspace(3) %gep691.1.1, align 2, !dbg !140, !tbaa !141
  %vb.sroa.12.10.vec.insert = insertelement <4 x half> %vb.sroa.12.8.vec.insert, half %43, i64 1, !dbg !140
  %xor374.2.1 = xor i32 %add373.2, %add368.1, !dbg !135
  %mul375.2.1 = shl nuw nsw i32 %xor374.2.1, 3, !dbg !136
  %add376.2.1 = or disjoint i32 %mul375.2.1, %add363.2, !dbg !137
  %add379.2.1 = or disjoint i32 %add376.2.1, %and248, !dbg !138
  %gep691.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.2.1, !dbg !139
  %44 = load half, ptr addrspace(3) %gep691.2.1, align 2, !dbg !140, !tbaa !141
  %vb.sroa.12.12.vec.insert = insertelement <4 x half> %vb.sroa.12.10.vec.insert, half %44, i64 2, !dbg !140
  %xor374.3.1 = xor i32 %add373.3, %add368.1, !dbg !135
  %mul375.3.1 = shl nuw nsw i32 %xor374.3.1, 3, !dbg !136
  %add376.3.1 = or disjoint i32 %mul375.3.1, %add363.3, !dbg !137
  %add379.3.1 = or disjoint i32 %add376.3.1, %and248, !dbg !138
  %gep691.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.3.1, !dbg !139
  %45 = load half, ptr addrspace(3) %gep691.3.1, align 2, !dbg !140, !tbaa !141
  %vb.sroa.12.14.vec.insert = insertelement <4 x half> %vb.sroa.12.12.vec.insert, half %45, i64 3, !dbg !140
  %add368.2 = or disjoint i32 %shr367, 4
  %xor374.2729 = xor i32 %mul372, %add368.2, !dbg !135
  %mul375.2730 = shl nuw nsw i32 %xor374.2729, 3, !dbg !136
  %add376.2731 = or disjoint i32 %mul375.2730, %mul361, !dbg !137
  %add379.2732 = or disjoint i32 %add376.2731, %and248, !dbg !138
  %gep691.2733 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.2732, !dbg !139
  %46 = load half, ptr addrspace(3) %gep691.2733, align 2, !dbg !140, !tbaa !141
  %vb.sroa.22.16.vec.insert = insertelement <4 x half> poison, half %46, i64 0, !dbg !140
  %xor374.1.2 = xor i32 %add373.1, %add368.2, !dbg !135
  %mul375.1.2 = shl nuw nsw i32 %xor374.1.2, 3, !dbg !136
  %add376.1.2 = or disjoint i32 %mul375.1.2, %add363.1, !dbg !137
  %add379.1.2 = or disjoint i32 %add376.1.2, %and248, !dbg !138
  %gep691.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1.2, !dbg !139
  %47 = load half, ptr addrspace(3) %gep691.1.2, align 2, !dbg !140, !tbaa !141
  %vb.sroa.22.18.vec.insert = insertelement <4 x half> %vb.sroa.22.16.vec.insert, half %47, i64 1, !dbg !140
  %xor374.2.2 = xor i32 %add373.2, %add368.2, !dbg !135
  %mul375.2.2 = shl nuw nsw i32 %xor374.2.2, 3, !dbg !136
  %add376.2.2 = or disjoint i32 %mul375.2.2, %add363.2, !dbg !137
  %add379.2.2 = or disjoint i32 %add376.2.2, %and248, !dbg !138
  %gep691.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.2.2, !dbg !139
  %48 = load half, ptr addrspace(3) %gep691.2.2, align 2, !dbg !140, !tbaa !141
  %vb.sroa.22.20.vec.insert = insertelement <4 x half> %vb.sroa.22.18.vec.insert, half %48, i64 2, !dbg !140
  %xor374.3.2 = xor i32 %add373.3, %add368.2, !dbg !135
  %mul375.3.2 = shl nuw nsw i32 %xor374.3.2, 3, !dbg !136
  %add376.3.2 = or disjoint i32 %mul375.3.2, %add363.3, !dbg !137
  %add379.3.2 = or disjoint i32 %add376.3.2, %and248, !dbg !138
  %gep691.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.3.2, !dbg !139
  %49 = load half, ptr addrspace(3) %gep691.3.2, align 2, !dbg !140, !tbaa !141
  %vb.sroa.22.22.vec.insert = insertelement <4 x half> %vb.sroa.22.20.vec.insert, half %49, i64 3, !dbg !140
  %add368.3 = or disjoint i32 %shr367, 6
  %xor374.3735 = xor i32 %mul372, %add368.3, !dbg !135
  %mul375.3736 = shl nuw nsw i32 %xor374.3735, 3, !dbg !136
  %add376.3737 = or disjoint i32 %mul375.3736, %mul361, !dbg !137
  %add379.3738 = or disjoint i32 %add376.3737, %and248, !dbg !138
  %gep691.3739 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.3738, !dbg !139
  %50 = load half, ptr addrspace(3) %gep691.3739, align 2, !dbg !140, !tbaa !141
  %vb.sroa.32.24.vec.insert = insertelement <4 x half> poison, half %50, i64 0, !dbg !140
  %xor374.1.3 = xor i32 %add373.1, %add368.3, !dbg !135
  %mul375.1.3 = shl nuw nsw i32 %xor374.1.3, 3, !dbg !136
  %add376.1.3 = or disjoint i32 %mul375.1.3, %add363.1, !dbg !137
  %add379.1.3 = or disjoint i32 %add376.1.3, %and248, !dbg !138
  %gep691.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1.3, !dbg !139
  %51 = load half, ptr addrspace(3) %gep691.1.3, align 2, !dbg !140, !tbaa !141
  %vb.sroa.32.26.vec.insert = insertelement <4 x half> %vb.sroa.32.24.vec.insert, half %51, i64 1, !dbg !140
  %xor374.2.3 = xor i32 %add373.2, %add368.3, !dbg !135
  %mul375.2.3 = shl nuw nsw i32 %xor374.2.3, 3, !dbg !136
  %add376.2.3 = or disjoint i32 %mul375.2.3, %add363.2, !dbg !137
  %add379.2.3 = or disjoint i32 %add376.2.3, %and248, !dbg !138
  %gep691.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.2.3, !dbg !139
  %52 = load half, ptr addrspace(3) %gep691.2.3, align 2, !dbg !140, !tbaa !141
  %vb.sroa.32.28.vec.insert = insertelement <4 x half> %vb.sroa.32.26.vec.insert, half %52, i64 2, !dbg !140
  %xor374.3.3 = xor i32 %add373.3, %add368.3, !dbg !135
  %mul375.3.3 = shl nuw nsw i32 %xor374.3.3, 3, !dbg !136
  %add376.3.3 = or disjoint i32 %mul375.3.3, %add363.3, !dbg !137
  %add379.3.3 = or disjoint i32 %add376.3.3, %and248, !dbg !138
  %gep691.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.3.3, !dbg !139
  %53 = load half, ptr addrspace(3) %gep691.3.3, align 2, !dbg !140, !tbaa !141
  %vb.sroa.32.30.vec.insert = insertelement <4 x half> %vb.sroa.32.28.vec.insert, half %53, i64 3, !dbg !140
  %54 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.1, <4 x float> zeroinitializer), !dbg !144
  %55 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.1, <4 x float> zeroinitializer), !dbg !144
  %56 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.1, <4 x float> zeroinitializer), !dbg !144
  %57 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.1, <4 x float> zeroinitializer), !dbg !144
  br label %if.end411, !dbg !145

if.end411:                                        ; preds = %for.cond355.preheader.preheader, %if.end346
  %acc_o.sroa.62.0 = phi <4 x float> [ %57, %for.cond355.preheader.preheader ], [ zeroinitializer, %if.end346 ], !dbg !57
  %acc_o.sroa.42.0 = phi <4 x float> [ %56, %for.cond355.preheader.preheader ], [ zeroinitializer, %if.end346 ], !dbg !57
  %acc_o.sroa.22.0 = phi <4 x float> [ %55, %for.cond355.preheader.preheader ], [ zeroinitializer, %if.end346 ], !dbg !57
  %acc_o.sroa.0.0 = phi <4 x float> [ %54, %for.cond355.preheader.preheader ], [ zeroinitializer, %if.end346 ], !dbg !57
  %or.cond702.1 = icmp ult i32 %mul11.1, 37, !dbg !50
  br i1 %or.cond702.1, label %for.cond67.preheader.1, label %if.end231.1, !dbg !50

for.cond67.preheader.1:                           ; preds = %if.end411
  %add74.1 = add nuw nsw i32 %mul11.1, %shr73
  %mul83.1 = shl nuw nsw i32 %mul11.1, 7
  %add87.1 = add nuw nsw i32 %add84, %mul83.1
  %58 = zext nneg i32 %add87.1 to i64, !dbg !51
  %cmp76.1741 = icmp slt i32 %add74.1, 37, !dbg !52
  br i1 %cmp76.1741, label %if.then77.1750, label %if.end115.1758, !dbg !53

if.then77.1750:                                   ; preds = %for.cond67.preheader.1
  %add.ptr93.1742 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %58, !dbg !54
  %condval_1.sroa.0.0.copyload.1743 = load i32, ptr addrspace(4) %add.ptr93.1742, align 16, !dbg !55, !tbaa !30
  %condval_1.sroa.5.0.add.ptr93.sroa_idx.1744 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr93.1742, i64 4, !dbg !55
  %condval_1.sroa.5.0.copyload.1745 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr93.sroa_idx.1744, align 4, !dbg !55, !tbaa !30
  %condval_1.sroa.6.0.add.ptr93.sroa_idx.1746 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr93.1742, i64 8, !dbg !55
  %condval_1.sroa.6.0.copyload.1747 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr93.sroa_idx.1746, align 8, !dbg !55, !tbaa !30
  %condval_1.sroa.7.0.add.ptr93.sroa_idx.1748 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr93.1742, i64 12, !dbg !55
  %condval_1.sroa.7.0.copyload.1749 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr93.sroa_idx.1748, align 4, !dbg !55, !tbaa !30
  br label %if.end115.1758, !dbg !56

if.end115.1758:                                   ; preds = %if.then77.1750, %for.cond67.preheader.1
  %condval_1.sroa.0.0.1751 = phi i32 [ %condval_1.sroa.0.0.copyload.1743, %if.then77.1750 ], [ 0, %for.cond67.preheader.1 ], !dbg !57
  %condval_1.sroa.5.0.1752 = phi i32 [ %condval_1.sroa.5.0.copyload.1745, %if.then77.1750 ], [ 0, %for.cond67.preheader.1 ], !dbg !57
  %condval_1.sroa.6.0.1753 = phi i32 [ %condval_1.sroa.6.0.copyload.1747, %if.then77.1750 ], [ 0, %for.cond67.preheader.1 ], !dbg !57
  %condval_1.sroa.7.0.1754 = phi i32 [ %condval_1.sroa.7.0.copyload.1749, %if.then77.1750 ], [ 0, %for.cond67.preheader.1 ], !dbg !57
  %cmp76.1.1 = icmp slt i32 %add74.1, 29, !dbg !52
  br i1 %cmp76.1.1, label %if.then77.1.1, label %if.end115.1.1, !dbg !53

if.then77.1.1:                                    ; preds = %if.end115.1758
  %59 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %58, !dbg !54
  %add.ptr93.1.1 = getelementptr inbounds i8, ptr addrspace(4) %59, i64 2048, !dbg !54
  %condval_1.sroa.0.0.copyload.1.1 = load i32, ptr addrspace(4) %add.ptr93.1.1, align 16, !dbg !55, !tbaa !30
  %condval_1.sroa.5.0.add.ptr93.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %59, i64 2052, !dbg !55
  %condval_1.sroa.5.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr93.sroa_idx.1.1, align 4, !dbg !55, !tbaa !30
  %condval_1.sroa.6.0.add.ptr93.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %59, i64 2056, !dbg !55
  %condval_1.sroa.6.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr93.sroa_idx.1.1, align 8, !dbg !55, !tbaa !30
  %condval_1.sroa.7.0.add.ptr93.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %59, i64 2060, !dbg !55
  %condval_1.sroa.7.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr93.sroa_idx.1.1, align 4, !dbg !55, !tbaa !30
  br label %if.end115.1.1, !dbg !56

if.end115.1.1:                                    ; preds = %if.then77.1.1, %if.end115.1758
  %condval_1.sroa.0.0.1.1 = phi i32 [ %condval_1.sroa.0.0.copyload.1.1, %if.then77.1.1 ], [ 0, %if.end115.1758 ], !dbg !57
  %condval_1.sroa.5.0.1.1 = phi i32 [ %condval_1.sroa.5.0.copyload.1.1, %if.then77.1.1 ], [ 0, %if.end115.1758 ], !dbg !57
  %condval_1.sroa.6.0.1.1 = phi i32 [ %condval_1.sroa.6.0.copyload.1.1, %if.then77.1.1 ], [ 0, %if.end115.1758 ], !dbg !57
  %condval_1.sroa.7.0.1.1 = phi i32 [ %condval_1.sroa.7.0.copyload.1.1, %if.then77.1.1 ], [ 0, %if.end115.1758 ], !dbg !57
  br i1 %cmp76.1741, label %if.then133.1768, label %if.end173.1776, !dbg !58

if.then133.1768:                                  ; preds = %if.end115.1.1
  %add.ptr149.1760 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %58, !dbg !59
  %condval_2.sroa.0.0.copyload.1761 = load i32, ptr addrspace(4) %add.ptr149.1760, align 16, !dbg !60, !tbaa !30
  %condval_2.sroa.5.0.add.ptr149.sroa_idx.1762 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr149.1760, i64 4, !dbg !60
  %condval_2.sroa.5.0.copyload.1763 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr149.sroa_idx.1762, align 4, !dbg !60, !tbaa !30
  %condval_2.sroa.6.0.add.ptr149.sroa_idx.1764 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr149.1760, i64 8, !dbg !60
  %condval_2.sroa.6.0.copyload.1765 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr149.sroa_idx.1764, align 8, !dbg !60, !tbaa !30
  %condval_2.sroa.7.0.add.ptr149.sroa_idx.1766 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr149.1760, i64 12, !dbg !60
  %condval_2.sroa.7.0.copyload.1767 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr149.sroa_idx.1766, align 4, !dbg !60, !tbaa !30
  br label %if.end173.1776, !dbg !61

if.end173.1776:                                   ; preds = %if.then133.1768, %if.end115.1.1
  %condval_2.sroa.0.0.1769 = phi i32 [ %condval_2.sroa.0.0.copyload.1761, %if.then133.1768 ], [ 0, %if.end115.1.1 ], !dbg !57
  %condval_2.sroa.5.0.1770 = phi i32 [ %condval_2.sroa.5.0.copyload.1763, %if.then133.1768 ], [ 0, %if.end115.1.1 ], !dbg !57
  %condval_2.sroa.6.0.1771 = phi i32 [ %condval_2.sroa.6.0.copyload.1765, %if.then133.1768 ], [ 0, %if.end115.1.1 ], !dbg !57
  %condval_2.sroa.7.0.1772 = phi i32 [ %condval_2.sroa.7.0.copyload.1767, %if.then133.1768 ], [ 0, %if.end115.1.1 ], !dbg !57
  br i1 %cmp76.1.1, label %if.then133.1.1, label %if.end173.1.1, !dbg !58

if.then133.1.1:                                   ; preds = %if.end173.1776
  %60 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %58, !dbg !59
  %add.ptr149.1.1 = getelementptr inbounds i8, ptr addrspace(4) %60, i64 2048, !dbg !59
  %condval_2.sroa.0.0.copyload.1.1 = load i32, ptr addrspace(4) %add.ptr149.1.1, align 16, !dbg !60, !tbaa !30
  %condval_2.sroa.5.0.add.ptr149.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %60, i64 2052, !dbg !60
  %condval_2.sroa.5.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr149.sroa_idx.1.1, align 4, !dbg !60, !tbaa !30
  %condval_2.sroa.6.0.add.ptr149.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %60, i64 2056, !dbg !60
  %condval_2.sroa.6.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr149.sroa_idx.1.1, align 8, !dbg !60, !tbaa !30
  %condval_2.sroa.7.0.add.ptr149.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %60, i64 2060, !dbg !60
  %condval_2.sroa.7.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr149.sroa_idx.1.1, align 4, !dbg !60, !tbaa !30
  br label %if.end173.1.1, !dbg !61

if.end173.1.1:                                    ; preds = %if.then133.1.1, %if.end173.1776
  %condval_2.sroa.0.0.1.1 = phi i32 [ %condval_2.sroa.0.0.copyload.1.1, %if.then133.1.1 ], [ 0, %if.end173.1776 ], !dbg !57
  %condval_2.sroa.5.0.1.1 = phi i32 [ %condval_2.sroa.5.0.copyload.1.1, %if.then133.1.1 ], [ 0, %if.end173.1776 ], !dbg !57
  %condval_2.sroa.6.0.1.1 = phi i32 [ %condval_2.sroa.6.0.copyload.1.1, %if.then133.1.1 ], [ 0, %if.end173.1776 ], !dbg !57
  %condval_2.sroa.7.0.1.1 = phi i32 [ %condval_2.sroa.7.0.copyload.1.1, %if.then133.1.1 ], [ 0, %if.end173.1776 ], !dbg !57
  store i32 %condval_1.sroa.0.0.1751, ptr addrspace(3) %invariant.gep675, align 16, !dbg !62, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep675.sroa_idx975 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 4, !dbg !62
  store i32 %condval_1.sroa.5.0.1752, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep675.sroa_idx975, align 4, !dbg !62, !tbaa !30
  %K_reg.sroa.8.0.invariant.gep675.sroa_idx977 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 8, !dbg !62
  store i32 %condval_1.sroa.6.0.1753, ptr addrspace(3) %K_reg.sroa.8.0.invariant.gep675.sroa_idx977, align 8, !dbg !62, !tbaa !30
  %K_reg.sroa.10.0.invariant.gep675.sroa_idx979 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 12, !dbg !62
  store i32 %condval_1.sroa.7.0.1754, ptr addrspace(3) %K_reg.sroa.10.0.invariant.gep675.sroa_idx979, align 4, !dbg !62, !tbaa !30
  %gep676.1.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 1024, !dbg !63
  store i32 %condval_1.sroa.0.0.1.1, ptr addrspace(3) %gep676.1.1, align 16, !dbg !62, !tbaa !30
  %K_reg.sroa.16.16.gep676.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 1028, !dbg !62
  store i32 %condval_1.sroa.5.0.1.1, ptr addrspace(3) %K_reg.sroa.16.16.gep676.1.1.sroa_idx, align 4, !dbg !62, !tbaa !30
  %K_reg.sroa.18.16.gep676.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 1032, !dbg !62
  store i32 %condval_1.sroa.6.0.1.1, ptr addrspace(3) %K_reg.sroa.18.16.gep676.1.1.sroa_idx, align 8, !dbg !62, !tbaa !30
  %K_reg.sroa.20.16.gep676.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 1036, !dbg !62
  store i32 %condval_1.sroa.7.0.1.1, ptr addrspace(3) %K_reg.sroa.20.16.gep676.1.1.sroa_idx, align 4, !dbg !62, !tbaa !30
  %cmp205.1 = icmp sgt i32 %mul11.1, 21, !dbg !64
  br i1 %cmp205.1, label %for.cond207.preheader.1, label %if.end231.1, !dbg !65

for.cond207.preheader.1:                          ; preds = %if.end173.1.1
  %add214.1 = add nuw nsw i32 %mul11.1, %mul213
  %cmp216.1777 = icmp slt i32 %add214.1, 37, !dbg !66
  %.fneg.1778 = select i1 %cmp216.1777, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.0.vec.insert891 = insertelement <4 x float> poison, float %.fneg.1778, i64 0, !dbg !67
  %add215.1.1 = or disjoint i32 %add214.1, 1, !dbg !68
  %cmp216.1.1 = icmp slt i32 %add215.1.1, 37, !dbg !66
  %.fneg.1.1 = select i1 %cmp216.1.1, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert914 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert891, float %.fneg.1.1, i64 1, !dbg !67
  %add215.2.1 = or disjoint i32 %add214.1, 2, !dbg !68
  %cmp216.2.1 = icmp slt i32 %add215.2.1, 37, !dbg !66
  %.fneg.2.1 = select i1 %cmp216.2.1, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.8.vec.insert935 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert914, float %.fneg.2.1, i64 2, !dbg !67
  %add215.3.1 = or disjoint i32 %add214.1, 3, !dbg !68
  %cmp216.3.1 = icmp slt i32 %add215.3.1, 37, !dbg !66
  %.fneg.3.1 = select i1 %cmp216.3.1, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.12.vec.insert956 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert935, float %.fneg.3.1, i64 3, !dbg !67
  br label %if.end231.1, !dbg !69

if.end231.1:                                      ; preds = %if.end173.1.1, %for.cond207.preheader.1, %if.end411
  %V_reg.sroa.20.1 = phi i32 [ %condval_2.sroa.7.0.1.1, %for.cond207.preheader.1 ], [ %V_reg.sroa.20.0, %if.end411 ], [ %condval_2.sroa.7.0.1.1, %if.end173.1.1 ], !dbg !146
  %V_reg.sroa.18.1 = phi i32 [ %condval_2.sroa.6.0.1.1, %for.cond207.preheader.1 ], [ %V_reg.sroa.18.0, %if.end411 ], [ %condval_2.sroa.6.0.1.1, %if.end173.1.1 ], !dbg !146
  %V_reg.sroa.16.1 = phi i32 [ %condval_2.sroa.5.0.1.1, %for.cond207.preheader.1 ], [ %V_reg.sroa.16.0, %if.end411 ], [ %condval_2.sroa.5.0.1.1, %if.end173.1.1 ], !dbg !146
  %V_reg.sroa.12.1 = phi i32 [ %condval_2.sroa.0.0.1.1, %for.cond207.preheader.1 ], [ %V_reg.sroa.12.0, %if.end411 ], [ %condval_2.sroa.0.0.1.1, %if.end173.1.1 ], !dbg !146
  %V_reg.sroa.10.1 = phi i32 [ %condval_2.sroa.7.0.1772, %for.cond207.preheader.1 ], [ %V_reg.sroa.10.0, %if.end411 ], [ %condval_2.sroa.7.0.1772, %if.end173.1.1 ], !dbg !146
  %V_reg.sroa.8.1 = phi i32 [ %condval_2.sroa.6.0.1771, %for.cond207.preheader.1 ], [ %V_reg.sroa.8.0, %if.end411 ], [ %condval_2.sroa.6.0.1771, %if.end173.1.1 ], !dbg !146
  %V_reg.sroa.6.1 = phi i32 [ %condval_2.sroa.5.0.1770, %for.cond207.preheader.1 ], [ %V_reg.sroa.6.0, %if.end411 ], [ %condval_2.sroa.5.0.1770, %if.end173.1.1 ], !dbg !146
  %V_reg.sroa.0.1 = phi i32 [ %condval_2.sroa.0.0.1769, %for.cond207.preheader.1 ], [ %V_reg.sroa.0.0, %if.end411 ], [ %condval_2.sroa.0.0.1769, %if.end173.1.1 ], !dbg !146
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert956, %for.cond207.preheader.1 ], [ %acc_s.sroa.0.1, %if.end411 ], [ zeroinitializer, %if.end173.1.1 ], !dbg !57
  fence syncscope("block") release, !dbg !69
  tail call void @llvm.mxc.barrier(), !dbg !75
  fence syncscope("block") acquire, !dbg !76
  br i1 %or.cond702.1, label %for.cond236.preheader.1, label %if.end346.1, !dbg !77

for.cond236.preheader.1:                          ; preds = %if.end231.1
  %xor249.1779 = xor i32 %shr245, %and248, !dbg !78
  %add.ptr253.idx.1780 = shl nuw nsw i32 %xor249.1779, 4, !dbg !79
  %add.ptr253.1781 = getelementptr inbounds i8, ptr addrspace(3) %14, i32 %add.ptr253.idx.1780, !dbg !79
  %kb.sroa.0.0.copyload869 = load <4 x half>, ptr addrspace(3) %add.ptr253.1781, align 16, !dbg !80
  %kb.sroa.10.0.add.ptr253.1781.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr253.1781, i32 8, !dbg !80
  %kb.sroa.10.0.copyload872 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr253.1781.sroa_idx, align 8, !dbg !80
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload869, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.2), !dbg !81, !call_argsrelate !82
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload872, <4 x half> %Q_reg.sroa.5.0.copyload, <4 x float> %61), !dbg !81, !call_argsrelate !82
  %add246.1.1 = add nuw nsw i32 %shr245, 4, !dbg !83
  %xor249.1.1 = xor i32 %add246.1.1, %and248, !dbg !78
  %add.ptr253.idx.1.1 = shl nuw nsw i32 %xor249.1.1, 4, !dbg !79
  %add.ptr253.1.1 = getelementptr inbounds i8, ptr addrspace(3) %14, i32 %add.ptr253.idx.1.1, !dbg !79
  %kb.sroa.0.0.copyload870 = load <4 x half>, ptr addrspace(3) %add.ptr253.1.1, align 16, !dbg !80
  %kb.sroa.10.0.add.ptr253.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr253.1.1, i32 8, !dbg !80
  %kb.sroa.10.0.copyload873 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr253.1.1.sroa_idx, align 8, !dbg !80
  %63 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload870, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %62), !dbg !81, !call_argsrelate !82
  %64 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload873, <4 x half> %Q_reg.sroa.10.16.copyload, <4 x float> %63), !dbg !81, !call_argsrelate !82
  store i32 %V_reg.sroa.0.1, ptr addrspace(3) %invariant.gep687, align 16, !dbg !84, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep687.sroa_idx964 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 2052, !dbg !84
  store i32 %V_reg.sroa.6.1, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep687.sroa_idx964, align 4, !dbg !84, !tbaa !30
  %V_reg.sroa.8.0.invariant.gep687.sroa_idx966 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 2056, !dbg !84
  store i32 %V_reg.sroa.8.1, ptr addrspace(3) %V_reg.sroa.8.0.invariant.gep687.sroa_idx966, align 8, !dbg !84, !tbaa !30
  %V_reg.sroa.10.0.invariant.gep687.sroa_idx968 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 2060, !dbg !84
  store i32 %V_reg.sroa.10.1, ptr addrspace(3) %V_reg.sroa.10.0.invariant.gep687.sroa_idx968, align 4, !dbg !84, !tbaa !30
  %gep.1.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 3072, !dbg !85
  store i32 %V_reg.sroa.12.1, ptr addrspace(3) %gep.1.1, align 16, !dbg !84, !tbaa !30
  %V_reg.sroa.16.16.gep.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 3076, !dbg !84
  store i32 %V_reg.sroa.16.1, ptr addrspace(3) %V_reg.sroa.16.16.gep.1.1.sroa_idx, align 4, !dbg !84, !tbaa !30
  %V_reg.sroa.18.16.gep.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 3080, !dbg !84
  store i32 %V_reg.sroa.18.1, ptr addrspace(3) %V_reg.sroa.18.16.gep.1.1.sroa_idx, align 8, !dbg !84, !tbaa !30
  %V_reg.sroa.20.16.gep.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 3084, !dbg !84
  store i32 %V_reg.sroa.20.1, ptr addrspace(3) %V_reg.sroa.20.16.gep.1.1.sroa_idx, align 4, !dbg !84, !tbaa !30
  %acc_s.sroa.0.0.vec.extract893 = extractelement <4 x float> %64, i64 0, !dbg !86
  %mul310.1784 = fmul contract float %acc_s.sroa.0.0.vec.extract893, 0x3FC2776C60000000, !dbg !87
  %65 = tail call contract noundef float @llvm.minnum.f32(float %mul310.1784, float 1.500000e+01), !dbg !88
  %cmp.i.i.1785 = fcmp contract olt float %65, -1.260000e+02, !dbg !92
  %cond.i.i.1786 = select contract i1 %cmp.i.i.1785, float 6.400000e+01, float 0.000000e+00, !dbg !92
  %add.i.i636.1787 = fadd contract float %65, %cond.i.i.1786, !dbg !92
  %66 = tail call contract float @llvm.exp2.f32(float %add.i.i636.1787), !dbg !92
  %cond2.i.i.1788 = select contract i1 %cmp.i.i.1785, float 0x3BF0000000000000, float 1.000000e+00, !dbg !92
  %mul.i.i.1789 = fmul contract float %cond2.i.i.1788, %66, !dbg !92
  %acc_s.sroa.0.4.vec.extract916 = extractelement <4 x float> %64, i64 1, !dbg !86
  %mul310.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract916, 0x3FC2776C60000000, !dbg !87
  %67 = tail call contract noundef float @llvm.minnum.f32(float %mul310.1.1, float 1.500000e+01), !dbg !88
  %cmp.i.i.1.1 = fcmp contract olt float %67, -1.260000e+02, !dbg !92
  %cond.i.i.1.1 = select contract i1 %cmp.i.i.1.1, float 6.400000e+01, float 0.000000e+00, !dbg !92
  %add.i.i636.1.1 = fadd contract float %67, %cond.i.i.1.1, !dbg !92
  %68 = tail call contract float @llvm.exp2.f32(float %add.i.i636.1.1), !dbg !92
  %cond2.i.i.1.1 = select contract i1 %cmp.i.i.1.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !92
  %mul.i.i.1.1 = fmul contract float %cond2.i.i.1.1, %68, !dbg !92
  %acc_s.sroa.0.8.vec.extract937 = extractelement <4 x float> %64, i64 2, !dbg !86
  %mul310.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract937, 0x3FC2776C60000000, !dbg !87
  %69 = tail call contract noundef float @llvm.minnum.f32(float %mul310.2.1, float 1.500000e+01), !dbg !88
  %cmp.i.i.2.1 = fcmp contract olt float %69, -1.260000e+02, !dbg !92
  %cond.i.i.2.1 = select contract i1 %cmp.i.i.2.1, float 6.400000e+01, float 0.000000e+00, !dbg !92
  %add.i.i636.2.1 = fadd contract float %69, %cond.i.i.2.1, !dbg !92
  %70 = tail call contract float @llvm.exp2.f32(float %add.i.i636.2.1), !dbg !92
  %cond2.i.i.2.1 = select contract i1 %cmp.i.i.2.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !92
  %mul.i.i.2.1 = fmul contract float %cond2.i.i.2.1, %70, !dbg !92
  %acc_s.sroa.0.12.vec.extract958 = extractelement <4 x float> %64, i64 3, !dbg !86
  %mul310.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract958, 0x3FC2776C60000000, !dbg !87
  %71 = tail call contract noundef float @llvm.minnum.f32(float %mul310.3.1, float 1.500000e+01), !dbg !88
  %cmp.i.i.3.1 = fcmp contract olt float %71, -1.260000e+02, !dbg !92
  %cond.i.i.3.1 = select contract i1 %cmp.i.i.3.1, float 6.400000e+01, float 0.000000e+00, !dbg !92
  %add.i.i636.3.1 = fadd contract float %71, %cond.i.i.3.1, !dbg !92
  %72 = tail call contract float @llvm.exp2.f32(float %add.i.i636.3.1), !dbg !92
  %cond2.i.i.3.1 = select contract i1 %cmp.i.i.3.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !92
  %mul.i.i.3.1 = fmul contract float %cond2.i.i.3.1, %72, !dbg !92
  %add326.1790 = fadd contract float %sum_acc.sroa.0.0, %mul.i.i.1789, !dbg !96
  %add326.1.1 = fadd contract float %sum_acc.sroa.8.0, %mul.i.i.1.1, !dbg !96
  %add326.2.1 = fadd contract float %sum_acc.sroa.14.0, %mul.i.i.2.1, !dbg !96
  %add326.3.1 = fadd contract float %sum_acc.sroa.20.0, %mul.i.i.3.1, !dbg !96
  %73 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !97
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !97, !noalias !105
  %74 = fptrunc float %mul.i.i.1789 to half, !dbg !97
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %73), !dbg !97, !noalias !105
  %75 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !110
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !110, !noalias !105
  %76 = fptrunc float %mul.i.i.1.1 to half, !dbg !110
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %75), !dbg !110, !noalias !105
  %__1.sroa.0.0.vec.insert.1 = insertelement <4 x half> poison, half %74, i64 0, !dbg !112
  %__1.sroa.0.2.vec.insert.1 = insertelement <4 x half> %__1.sroa.0.0.vec.insert.1, half %76, i64 1, !dbg !112
  %77 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !115
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !115, !noalias !119
  %78 = fptrunc float %mul.i.i.2.1 to half, !dbg !115
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %77), !dbg !115, !noalias !119
  %79 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !124
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !124, !noalias !119
  %80 = fptrunc float %mul.i.i.3.1 to half, !dbg !124
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %79), !dbg !124, !noalias !119
  %__1.sroa.0.4.vec.insert.1 = insertelement <4 x half> %__1.sroa.0.2.vec.insert.1, half %78, i64 2, !dbg !126
  %__1.sroa.0.6.vec.insert.1 = insertelement <4 x half> %__1.sroa.0.4.vec.insert.1, half %80, i64 3, !dbg !126
  br label %if.end346.1, !dbg !128

if.end346.1:                                      ; preds = %for.cond236.preheader.1, %if.end231.1
  %sum_acc.sroa.20.1 = phi float [ %add326.3.1, %for.cond236.preheader.1 ], [ %sum_acc.sroa.20.0, %if.end231.1 ], !dbg !147
  %sum_acc.sroa.14.1 = phi float [ %add326.2.1, %for.cond236.preheader.1 ], [ %sum_acc.sroa.14.0, %if.end231.1 ], !dbg !147
  %sum_acc.sroa.8.1 = phi float [ %add326.1.1, %for.cond236.preheader.1 ], [ %sum_acc.sroa.8.0, %if.end231.1 ], !dbg !147
  %sum_acc.sroa.0.1 = phi float [ %add326.1790, %for.cond236.preheader.1 ], [ %sum_acc.sroa.0.0, %if.end231.1 ], !dbg !147
  %acc_s_cast.sroa.0.1.1 = phi <4 x half> [ %__1.sroa.0.6.vec.insert.1, %for.cond236.preheader.1 ], [ %acc_s_cast.sroa.0.1, %if.end231.1 ]
  fence syncscope("block") release, !dbg !129
  tail call void @llvm.mxc.barrier(), !dbg !132
  fence syncscope("block") acquire, !dbg !133
  br i1 %or.cond702.1, label %for.cond355.preheader.preheader.1, label %if.end411.1, !dbg !134

for.cond355.preheader.preheader.1:                ; preds = %if.end346.1
  %xor374.1791 = or disjoint i32 %mul372, %shr367, !dbg !135
  %mul375.1792 = shl nuw nsw i32 %xor374.1791, 3, !dbg !136
  %add376.1793 = or disjoint i32 %mul375.1792, %mul361, !dbg !137
  %add379.1794 = or disjoint i32 %add376.1793, %and248, !dbg !138
  %gep691.1795 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1794, !dbg !139
  %81 = load half, ptr addrspace(3) %gep691.1795, align 2, !dbg !140, !tbaa !141
  %vb.sroa.0.0.vec.insert828 = insertelement <4 x half> poison, half %81, i64 0, !dbg !140
  %add363.1.1796 = or disjoint i32 %mul361, 64, !dbg !142
  %add373.1.1797 = or disjoint i32 %mul372, 1, !dbg !143
  %xor374.1.1798 = xor i32 %add373.1.1797, %shr367, !dbg !135
  %mul375.1.1799 = shl nuw nsw i32 %xor374.1.1798, 3, !dbg !136
  %add376.1.1800 = or disjoint i32 %mul375.1.1799, %add363.1.1796, !dbg !137
  %add379.1.1801 = or disjoint i32 %add376.1.1800, %and248, !dbg !138
  %gep691.1.1802 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1.1801, !dbg !139
  %82 = load half, ptr addrspace(3) %gep691.1.1802, align 2, !dbg !140, !tbaa !141
  %vb.sroa.0.2.vec.insert830 = insertelement <4 x half> %vb.sroa.0.0.vec.insert828, half %82, i64 1, !dbg !140
  %add363.2.1804 = or disjoint i32 %mul361, 128, !dbg !142
  %add373.2.1805 = or disjoint i32 %mul372, 2, !dbg !143
  %xor374.2.1806 = or disjoint i32 %add373.2.1805, %shr367, !dbg !135
  %mul375.2.1807 = shl nuw nsw i32 %xor374.2.1806, 3, !dbg !136
  %add376.2.1808 = or disjoint i32 %mul375.2.1807, %add363.2.1804, !dbg !137
  %add379.2.1809 = or disjoint i32 %add376.2.1808, %and248, !dbg !138
  %gep691.2.1810 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.2.1809, !dbg !139
  %83 = load half, ptr addrspace(3) %gep691.2.1810, align 2, !dbg !140, !tbaa !141
  %vb.sroa.0.4.vec.insert832 = insertelement <4 x half> %vb.sroa.0.2.vec.insert830, half %83, i64 2, !dbg !140
  %add363.3.1812 = or disjoint i32 %mul361, 192, !dbg !142
  %add373.3.1813 = or disjoint i32 %mul372, 3, !dbg !143
  %xor374.3.1814 = xor i32 %add373.3.1813, %shr367, !dbg !135
  %mul375.3.1815 = shl nuw nsw i32 %xor374.3.1814, 3, !dbg !136
  %add376.3.1816 = or disjoint i32 %mul375.3.1815, %add363.3.1812, !dbg !137
  %add379.3.1817 = or disjoint i32 %add376.3.1816, %and248, !dbg !138
  %gep691.3.1818 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.3.1817, !dbg !139
  %84 = load half, ptr addrspace(3) %gep691.3.1818, align 2, !dbg !140, !tbaa !141
  %vb.sroa.0.6.vec.insert834 = insertelement <4 x half> %vb.sroa.0.4.vec.insert832, half %84, i64 3, !dbg !140
  %add368.1.1 = or disjoint i32 %shr367, 2
  %xor374.1723.1 = or disjoint i32 %mul372, %add368.1.1, !dbg !135
  %mul375.1724.1 = shl nuw nsw i32 %xor374.1723.1, 3, !dbg !136
  %add376.1725.1 = or disjoint i32 %mul375.1724.1, %mul361, !dbg !137
  %add379.1726.1 = or disjoint i32 %add376.1725.1, %and248, !dbg !138
  %gep691.1727.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1726.1, !dbg !139
  %85 = load half, ptr addrspace(3) %gep691.1727.1, align 2, !dbg !140, !tbaa !141
  %vb.sroa.12.8.vec.insert838 = insertelement <4 x half> poison, half %85, i64 0, !dbg !140
  %xor374.1.1.1 = xor i32 %add373.1.1797, %add368.1.1, !dbg !135
  %mul375.1.1.1 = shl nuw nsw i32 %xor374.1.1.1, 3, !dbg !136
  %add376.1.1.1 = or disjoint i32 %mul375.1.1.1, %add363.1.1796, !dbg !137
  %add379.1.1.1 = or disjoint i32 %add376.1.1.1, %and248, !dbg !138
  %gep691.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1.1.1, !dbg !139
  %86 = load half, ptr addrspace(3) %gep691.1.1.1, align 2, !dbg !140, !tbaa !141
  %vb.sroa.12.10.vec.insert840 = insertelement <4 x half> %vb.sroa.12.8.vec.insert838, half %86, i64 1, !dbg !140
  %xor374.2.1.1 = xor i32 %add373.2.1805, %add368.1.1, !dbg !135
  %mul375.2.1.1 = shl nuw nsw i32 %xor374.2.1.1, 3, !dbg !136
  %add376.2.1.1 = or disjoint i32 %mul375.2.1.1, %add363.2.1804, !dbg !137
  %add379.2.1.1 = or disjoint i32 %add376.2.1.1, %and248, !dbg !138
  %gep691.2.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.2.1.1, !dbg !139
  %87 = load half, ptr addrspace(3) %gep691.2.1.1, align 2, !dbg !140, !tbaa !141
  %vb.sroa.12.12.vec.insert842 = insertelement <4 x half> %vb.sroa.12.10.vec.insert840, half %87, i64 2, !dbg !140
  %xor374.3.1.1 = xor i32 %add373.3.1813, %add368.1.1, !dbg !135
  %mul375.3.1.1 = shl nuw nsw i32 %xor374.3.1.1, 3, !dbg !136
  %add376.3.1.1 = or disjoint i32 %mul375.3.1.1, %add363.3.1812, !dbg !137
  %add379.3.1.1 = or disjoint i32 %add376.3.1.1, %and248, !dbg !138
  %gep691.3.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.3.1.1, !dbg !139
  %88 = load half, ptr addrspace(3) %gep691.3.1.1, align 2, !dbg !140, !tbaa !141
  %vb.sroa.12.14.vec.insert844 = insertelement <4 x half> %vb.sroa.12.12.vec.insert842, half %88, i64 3, !dbg !140
  %add368.2.1 = or disjoint i32 %shr367, 4
  %xor374.2729.1 = xor i32 %mul372, %add368.2.1, !dbg !135
  %mul375.2730.1 = shl nuw nsw i32 %xor374.2729.1, 3, !dbg !136
  %add376.2731.1 = or disjoint i32 %mul375.2730.1, %mul361, !dbg !137
  %add379.2732.1 = or disjoint i32 %add376.2731.1, %and248, !dbg !138
  %gep691.2733.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.2732.1, !dbg !139
  %89 = load half, ptr addrspace(3) %gep691.2733.1, align 2, !dbg !140, !tbaa !141
  %vb.sroa.22.16.vec.insert848 = insertelement <4 x half> poison, half %89, i64 0, !dbg !140
  %xor374.1.2.1 = xor i32 %add373.1.1797, %add368.2.1, !dbg !135
  %mul375.1.2.1 = shl nuw nsw i32 %xor374.1.2.1, 3, !dbg !136
  %add376.1.2.1 = or disjoint i32 %mul375.1.2.1, %add363.1.1796, !dbg !137
  %add379.1.2.1 = or disjoint i32 %add376.1.2.1, %and248, !dbg !138
  %gep691.1.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1.2.1, !dbg !139
  %90 = load half, ptr addrspace(3) %gep691.1.2.1, align 2, !dbg !140, !tbaa !141
  %vb.sroa.22.18.vec.insert850 = insertelement <4 x half> %vb.sroa.22.16.vec.insert848, half %90, i64 1, !dbg !140
  %xor374.2.2.1 = xor i32 %add373.2.1805, %add368.2.1, !dbg !135
  %mul375.2.2.1 = shl nuw nsw i32 %xor374.2.2.1, 3, !dbg !136
  %add376.2.2.1 = or disjoint i32 %mul375.2.2.1, %add363.2.1804, !dbg !137
  %add379.2.2.1 = or disjoint i32 %add376.2.2.1, %and248, !dbg !138
  %gep691.2.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.2.2.1, !dbg !139
  %91 = load half, ptr addrspace(3) %gep691.2.2.1, align 2, !dbg !140, !tbaa !141
  %vb.sroa.22.20.vec.insert852 = insertelement <4 x half> %vb.sroa.22.18.vec.insert850, half %91, i64 2, !dbg !140
  %xor374.3.2.1 = xor i32 %add373.3.1813, %add368.2.1, !dbg !135
  %mul375.3.2.1 = shl nuw nsw i32 %xor374.3.2.1, 3, !dbg !136
  %add376.3.2.1 = or disjoint i32 %mul375.3.2.1, %add363.3.1812, !dbg !137
  %add379.3.2.1 = or disjoint i32 %add376.3.2.1, %and248, !dbg !138
  %gep691.3.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.3.2.1, !dbg !139
  %92 = load half, ptr addrspace(3) %gep691.3.2.1, align 2, !dbg !140, !tbaa !141
  %vb.sroa.22.22.vec.insert854 = insertelement <4 x half> %vb.sroa.22.20.vec.insert852, half %92, i64 3, !dbg !140
  %add368.3.1 = or disjoint i32 %shr367, 6
  %xor374.3735.1 = xor i32 %mul372, %add368.3.1, !dbg !135
  %mul375.3736.1 = shl nuw nsw i32 %xor374.3735.1, 3, !dbg !136
  %add376.3737.1 = or disjoint i32 %mul375.3736.1, %mul361, !dbg !137
  %add379.3738.1 = or disjoint i32 %add376.3737.1, %and248, !dbg !138
  %gep691.3739.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.3738.1, !dbg !139
  %93 = load half, ptr addrspace(3) %gep691.3739.1, align 2, !dbg !140, !tbaa !141
  %vb.sroa.32.24.vec.insert858 = insertelement <4 x half> poison, half %93, i64 0, !dbg !140
  %xor374.1.3.1 = xor i32 %add373.1.1797, %add368.3.1, !dbg !135
  %mul375.1.3.1 = shl nuw nsw i32 %xor374.1.3.1, 3, !dbg !136
  %add376.1.3.1 = or disjoint i32 %mul375.1.3.1, %add363.1.1796, !dbg !137
  %add379.1.3.1 = or disjoint i32 %add376.1.3.1, %and248, !dbg !138
  %gep691.1.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1.3.1, !dbg !139
  %94 = load half, ptr addrspace(3) %gep691.1.3.1, align 2, !dbg !140, !tbaa !141
  %vb.sroa.32.26.vec.insert860 = insertelement <4 x half> %vb.sroa.32.24.vec.insert858, half %94, i64 1, !dbg !140
  %xor374.2.3.1 = xor i32 %add373.2.1805, %add368.3.1, !dbg !135
  %mul375.2.3.1 = shl nuw nsw i32 %xor374.2.3.1, 3, !dbg !136
  %add376.2.3.1 = or disjoint i32 %mul375.2.3.1, %add363.2.1804, !dbg !137
  %add379.2.3.1 = or disjoint i32 %add376.2.3.1, %and248, !dbg !138
  %gep691.2.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.2.3.1, !dbg !139
  %95 = load half, ptr addrspace(3) %gep691.2.3.1, align 2, !dbg !140, !tbaa !141
  %vb.sroa.32.28.vec.insert862 = insertelement <4 x half> %vb.sroa.32.26.vec.insert860, half %95, i64 2, !dbg !140
  %xor374.3.3.1 = xor i32 %add373.3.1813, %add368.3.1, !dbg !135
  %mul375.3.3.1 = shl nuw nsw i32 %xor374.3.3.1, 3, !dbg !136
  %add376.3.3.1 = or disjoint i32 %mul375.3.3.1, %add363.3.1812, !dbg !137
  %add379.3.3.1 = or disjoint i32 %add376.3.3.1, %and248, !dbg !138
  %gep691.3.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.3.3.1, !dbg !139
  %96 = load half, ptr addrspace(3) %gep691.3.3.1, align 2, !dbg !140, !tbaa !141
  %vb.sroa.32.30.vec.insert864 = insertelement <4 x half> %vb.sroa.32.28.vec.insert862, half %96, i64 3, !dbg !140
  %97 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert834, <4 x half> %acc_s_cast.sroa.0.1.1, <4 x float> %acc_o.sroa.0.0), !dbg !144
  %98 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.14.vec.insert844, <4 x half> %acc_s_cast.sroa.0.1.1, <4 x float> %acc_o.sroa.22.0), !dbg !144
  %99 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.22.vec.insert854, <4 x half> %acc_s_cast.sroa.0.1.1, <4 x float> %acc_o.sroa.42.0), !dbg !144
  %100 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.30.vec.insert864, <4 x half> %acc_s_cast.sroa.0.1.1, <4 x float> %acc_o.sroa.62.0), !dbg !144
  br label %if.end411.1, !dbg !145

if.end411.1:                                      ; preds = %for.cond355.preheader.preheader.1, %if.end346.1
  %acc_o.sroa.62.1 = phi <4 x float> [ %100, %for.cond355.preheader.preheader.1 ], [ %acc_o.sroa.62.0, %if.end346.1 ], !dbg !148
  %acc_o.sroa.42.1 = phi <4 x float> [ %99, %for.cond355.preheader.preheader.1 ], [ %acc_o.sroa.42.0, %if.end346.1 ], !dbg !148
  %acc_o.sroa.22.1 = phi <4 x float> [ %98, %for.cond355.preheader.preheader.1 ], [ %acc_o.sroa.22.0, %if.end346.1 ], !dbg !148
  %acc_o.sroa.0.1 = phi <4 x float> [ %97, %for.cond355.preheader.preheader.1 ], [ %acc_o.sroa.0.0, %if.end346.1 ], !dbg !148
  %add423 = fadd contract float %sum_acc.sroa.0.1, 0.000000e+00, !dbg !149
  %add423.1 = fadd contract float %add423, %sum_acc.sroa.8.1, !dbg !149
  %add423.2 = fadd contract float %add423.1, %sum_acc.sroa.14.1, !dbg !149
  %add423.3 = fadd contract float %add423.2, %sum_acc.sroa.20.1, !dbg !149
  fence syncscope("block") release, !dbg !150
  tail call void @llvm.mxc.barrier(), !dbg !153
  fence syncscope("block") acquire, !dbg !154
  %101 = bitcast float %add423.3 to i32, !dbg !155
  %102 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10, !dbg !166
  %103 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %102) #10, !dbg !171
  %xor.i.i = xor i32 %103, 32, !dbg !172
  %104 = and i32 %103, -64, !dbg !173
  %and.i.i = add nsw i32 %104, 64, !dbg !173
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !174
  %cond.i.i638 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %103, !dbg !175
  %shl.i.i = shl i32 %cond.i.i638, 2, !dbg !176
  %105 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %101), !dbg !177
  %106 = bitcast i32 %105 to float, !dbg !178
  %add.i = fadd contract float %add423.3, %106, !dbg !179
  %107 = bitcast float %add.i to i32, !dbg !182
  %108 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10, !dbg !189
  %109 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %108) #10, !dbg !192
  %xor.i.i639 = xor i32 %109, 16, !dbg !193
  %110 = and i32 %109, -64, !dbg !194
  %and.i.i640 = add nsw i32 %110, 64, !dbg !194
  %cmp.not.i.i641 = icmp slt i32 %xor.i.i639, %and.i.i640, !dbg !195
  %cond.i.i642 = select i1 %cmp.not.i.i641, i32 %xor.i.i639, i32 %109, !dbg !196
  %shl.i.i643 = shl i32 %cond.i.i642, 2, !dbg !197
  %111 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i643, i32 %107), !dbg !198
  %112 = bitcast i32 %111 to float, !dbg !199
  %add.i.i = fadd contract float %add.i, %112, !dbg !200
  %cmp432 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !202
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !203
  %condval_4.0 = select i1 %cmp432, float %div, float 0.000000e+00, !dbg !203
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 0, !dbg !204
  %mul445 = fmul contract float %condval_4.0, %acc_o.sroa.0.0.vec.extract, !dbg !205
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 1, !dbg !204
  %mul445.1 = fmul contract float %condval_4.0, %acc_o.sroa.0.4.vec.extract, !dbg !205
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 2, !dbg !204
  %mul445.2 = fmul contract float %condval_4.0, %acc_o.sroa.0.8.vec.extract, !dbg !205
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1, i64 3, !dbg !204
  %mul445.3 = fmul contract float %condval_4.0, %acc_o.sroa.0.12.vec.extract, !dbg !205
  %acc_o.sroa.22.16.vec.extract = extractelement <4 x float> %acc_o.sroa.22.1, i64 0, !dbg !204
  %mul445.4 = fmul contract float %condval_4.0, %acc_o.sroa.22.16.vec.extract, !dbg !205
  %acc_o.sroa.22.20.vec.extract = extractelement <4 x float> %acc_o.sroa.22.1, i64 1, !dbg !204
  %mul445.5 = fmul contract float %condval_4.0, %acc_o.sroa.22.20.vec.extract, !dbg !205
  %acc_o.sroa.22.24.vec.extract = extractelement <4 x float> %acc_o.sroa.22.1, i64 2, !dbg !204
  %mul445.6 = fmul contract float %condval_4.0, %acc_o.sroa.22.24.vec.extract, !dbg !205
  %acc_o.sroa.22.28.vec.extract = extractelement <4 x float> %acc_o.sroa.22.1, i64 3, !dbg !204
  %mul445.7 = fmul contract float %condval_4.0, %acc_o.sroa.22.28.vec.extract, !dbg !205
  %acc_o.sroa.42.32.vec.extract = extractelement <4 x float> %acc_o.sroa.42.1, i64 0, !dbg !204
  %mul445.8 = fmul contract float %condval_4.0, %acc_o.sroa.42.32.vec.extract, !dbg !205
  %acc_o.sroa.42.36.vec.extract = extractelement <4 x float> %acc_o.sroa.42.1, i64 1, !dbg !204
  %mul445.9 = fmul contract float %condval_4.0, %acc_o.sroa.42.36.vec.extract, !dbg !205
  %acc_o.sroa.42.40.vec.extract = extractelement <4 x float> %acc_o.sroa.42.1, i64 2, !dbg !204
  %mul445.10 = fmul contract float %condval_4.0, %acc_o.sroa.42.40.vec.extract, !dbg !205
  %acc_o.sroa.42.44.vec.extract = extractelement <4 x float> %acc_o.sroa.42.1, i64 3, !dbg !204
  %mul445.11 = fmul contract float %condval_4.0, %acc_o.sroa.42.44.vec.extract, !dbg !205
  %acc_o.sroa.62.48.vec.extract = extractelement <4 x float> %acc_o.sroa.62.1, i64 0, !dbg !204
  %mul445.12 = fmul contract float %condval_4.0, %acc_o.sroa.62.48.vec.extract, !dbg !205
  %acc_o.sroa.62.52.vec.extract = extractelement <4 x float> %acc_o.sroa.62.1, i64 1, !dbg !204
  %mul445.13 = fmul contract float %condval_4.0, %acc_o.sroa.62.52.vec.extract, !dbg !205
  %acc_o.sroa.62.56.vec.extract = extractelement <4 x float> %acc_o.sroa.62.1, i64 2, !dbg !204
  %mul445.14 = fmul contract float %condval_4.0, %acc_o.sroa.62.56.vec.extract, !dbg !205
  %acc_o.sroa.62.60.vec.extract = extractelement <4 x float> %acc_o.sroa.62.1, i64 3, !dbg !204
  %mul445.15 = fmul contract float %condval_4.0, %acc_o.sroa.62.60.vec.extract, !dbg !205
  %add483 = add nuw nsw i32 %add26, %mul213
  %113 = zext nneg i32 %add483 to i64, !dbg !206
  %114 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !207
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !207, !noalias !211
  %115 = fptrunc float %mul445 to half, !dbg !207
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %114), !dbg !207, !noalias !211
  %116 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !216
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !216, !noalias !211
  %117 = fptrunc float %mul445.1 to half, !dbg !216
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %116), !dbg !216, !noalias !211
  %118 = bitcast half %115 to i16, !dbg !218
  %119 = bitcast half %117 to i16, !dbg !221
  %120 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !222
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !222, !noalias !226
  %121 = fptrunc float %mul445.2 to half, !dbg !222
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %120), !dbg !222, !noalias !226
  %122 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !231
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !231, !noalias !226
  %123 = fptrunc float %mul445.3 to half, !dbg !231
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %122), !dbg !231, !noalias !226
  %124 = bitcast half %121 to i16, !dbg !233
  %125 = bitcast half %123 to i16, !dbg !235
  %__2.sroa.6.0.insert.ext = zext i16 %125 to i64, !dbg !236
  %__2.sroa.6.0.insert.shift = shl nuw i64 %__2.sroa.6.0.insert.ext, 48, !dbg !236
  %__2.sroa.5.0.insert.ext = zext i16 %124 to i64, !dbg !236
  %__2.sroa.5.0.insert.shift = shl nuw nsw i64 %__2.sroa.5.0.insert.ext, 32, !dbg !236
  %__2.sroa.5.0.insert.insert = or disjoint i64 %__2.sroa.6.0.insert.shift, %__2.sroa.5.0.insert.shift, !dbg !236
  %__2.sroa.4.0.insert.ext = zext i16 %119 to i64, !dbg !236
  %__2.sroa.4.0.insert.shift = shl nuw nsw i64 %__2.sroa.4.0.insert.ext, 16, !dbg !236
  %__2.sroa.4.0.insert.insert = or disjoint i64 %__2.sroa.5.0.insert.insert, %__2.sroa.4.0.insert.shift, !dbg !236
  %__2.sroa.0.0.insert.ext = zext i16 %118 to i64, !dbg !236
  %__2.sroa.0.0.insert.insert = or disjoint i64 %__2.sroa.4.0.insert.insert, %__2.sroa.0.0.insert.ext, !dbg !236
  %add.ptr489 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %113, !dbg !237
  store i64 %__2.sroa.0.0.insert.insert, ptr addrspace(1) %add.ptr489, align 8, !dbg !238
  %126 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !207
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !207, !noalias !211
  %127 = fptrunc float %mul445.4 to half, !dbg !207
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %126), !dbg !207, !noalias !211
  %128 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !216
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !216, !noalias !211
  %129 = fptrunc float %mul445.5 to half, !dbg !216
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %128), !dbg !216, !noalias !211
  %130 = bitcast half %127 to i16, !dbg !218
  %131 = bitcast half %129 to i16, !dbg !221
  %132 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !222
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !222, !noalias !226
  %133 = fptrunc float %mul445.6 to half, !dbg !222
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %132), !dbg !222, !noalias !226
  %134 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !231
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !231, !noalias !226
  %135 = fptrunc float %mul445.7 to half, !dbg !231
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %134), !dbg !231, !noalias !226
  %136 = bitcast half %133 to i16, !dbg !233
  %137 = bitcast half %135 to i16, !dbg !235
  %__2.sroa.6.0.insert.ext.1 = zext i16 %137 to i64, !dbg !236
  %__2.sroa.6.0.insert.shift.1 = shl nuw i64 %__2.sroa.6.0.insert.ext.1, 48, !dbg !236
  %__2.sroa.5.0.insert.ext.1 = zext i16 %136 to i64, !dbg !236
  %__2.sroa.5.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.1, 32, !dbg !236
  %__2.sroa.5.0.insert.insert.1 = or disjoint i64 %__2.sroa.6.0.insert.shift.1, %__2.sroa.5.0.insert.shift.1, !dbg !236
  %__2.sroa.4.0.insert.ext.1 = zext i16 %131 to i64, !dbg !236
  %__2.sroa.4.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.1, 16, !dbg !236
  %__2.sroa.4.0.insert.insert.1 = or disjoint i64 %__2.sroa.5.0.insert.insert.1, %__2.sroa.4.0.insert.shift.1, !dbg !236
  %__2.sroa.0.0.insert.ext.1 = zext i16 %130 to i64, !dbg !236
  %__2.sroa.0.0.insert.insert.1 = or disjoint i64 %__2.sroa.4.0.insert.insert.1, %__2.sroa.0.0.insert.ext.1, !dbg !236
  %138 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %113, !dbg !237
  %add.ptr489.1 = getelementptr inbounds i8, ptr addrspace(1) %138, i64 32, !dbg !237
  store i64 %__2.sroa.0.0.insert.insert.1, ptr addrspace(1) %add.ptr489.1, align 8, !dbg !238
  %139 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !207
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !207, !noalias !211
  %140 = fptrunc float %mul445.8 to half, !dbg !207
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %139), !dbg !207, !noalias !211
  %141 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !216
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !216, !noalias !211
  %142 = fptrunc float %mul445.9 to half, !dbg !216
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %141), !dbg !216, !noalias !211
  %143 = bitcast half %140 to i16, !dbg !218
  %144 = bitcast half %142 to i16, !dbg !221
  %145 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !222
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !222, !noalias !226
  %146 = fptrunc float %mul445.10 to half, !dbg !222
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %145), !dbg !222, !noalias !226
  %147 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !231
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !231, !noalias !226
  %148 = fptrunc float %mul445.11 to half, !dbg !231
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %147), !dbg !231, !noalias !226
  %149 = bitcast half %146 to i16, !dbg !233
  %150 = bitcast half %148 to i16, !dbg !235
  %__2.sroa.6.0.insert.ext.2 = zext i16 %150 to i64, !dbg !236
  %__2.sroa.6.0.insert.shift.2 = shl nuw i64 %__2.sroa.6.0.insert.ext.2, 48, !dbg !236
  %__2.sroa.5.0.insert.ext.2 = zext i16 %149 to i64, !dbg !236
  %__2.sroa.5.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.2, 32, !dbg !236
  %__2.sroa.5.0.insert.insert.2 = or disjoint i64 %__2.sroa.6.0.insert.shift.2, %__2.sroa.5.0.insert.shift.2, !dbg !236
  %__2.sroa.4.0.insert.ext.2 = zext i16 %144 to i64, !dbg !236
  %__2.sroa.4.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.2, 16, !dbg !236
  %__2.sroa.4.0.insert.insert.2 = or disjoint i64 %__2.sroa.5.0.insert.insert.2, %__2.sroa.4.0.insert.shift.2, !dbg !236
  %__2.sroa.0.0.insert.ext.2 = zext i16 %143 to i64, !dbg !236
  %__2.sroa.0.0.insert.insert.2 = or disjoint i64 %__2.sroa.4.0.insert.insert.2, %__2.sroa.0.0.insert.ext.2, !dbg !236
  %151 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %113, !dbg !237
  %add.ptr489.2 = getelementptr inbounds i8, ptr addrspace(1) %151, i64 64, !dbg !237
  store i64 %__2.sroa.0.0.insert.insert.2, ptr addrspace(1) %add.ptr489.2, align 8, !dbg !238
  %152 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !207
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !207, !noalias !211
  %153 = fptrunc float %mul445.12 to half, !dbg !207
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %152), !dbg !207, !noalias !211
  %154 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !216
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !216, !noalias !211
  %155 = fptrunc float %mul445.13 to half, !dbg !216
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %154), !dbg !216, !noalias !211
  %156 = bitcast half %153 to i16, !dbg !218
  %157 = bitcast half %155 to i16, !dbg !221
  %158 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !222
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !222, !noalias !226
  %159 = fptrunc float %mul445.14 to half, !dbg !222
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %158), !dbg !222, !noalias !226
  %160 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !231
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !231, !noalias !226
  %161 = fptrunc float %mul445.15 to half, !dbg !231
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %160), !dbg !231, !noalias !226
  %162 = bitcast half %159 to i16, !dbg !233
  %163 = bitcast half %161 to i16, !dbg !235
  %__2.sroa.6.0.insert.ext.3 = zext i16 %163 to i64, !dbg !236
  %__2.sroa.6.0.insert.shift.3 = shl nuw i64 %__2.sroa.6.0.insert.ext.3, 48, !dbg !236
  %__2.sroa.5.0.insert.ext.3 = zext i16 %162 to i64, !dbg !236
  %__2.sroa.5.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.3, 32, !dbg !236
  %__2.sroa.5.0.insert.insert.3 = or disjoint i64 %__2.sroa.6.0.insert.shift.3, %__2.sroa.5.0.insert.shift.3, !dbg !236
  %__2.sroa.4.0.insert.ext.3 = zext i16 %157 to i64, !dbg !236
  %__2.sroa.4.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.3, 16, !dbg !236
  %__2.sroa.4.0.insert.insert.3 = or disjoint i64 %__2.sroa.5.0.insert.insert.3, %__2.sroa.4.0.insert.shift.3, !dbg !236
  %__2.sroa.0.0.insert.ext.3 = zext i16 %156 to i64, !dbg !236
  %__2.sroa.0.0.insert.insert.3 = or disjoint i64 %__2.sroa.4.0.insert.insert.3, %__2.sroa.0.0.insert.ext.3, !dbg !236
  %164 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %113, !dbg !237
  %add.ptr489.3 = getelementptr inbounds i8, ptr addrspace(1) %164, i64 96, !dbg !237
  store i64 %__2.sroa.0.0.insert.insert.3, ptr addrspace(1) %add.ptr489.3, align 8, !dbg !238
  ret void, !dbg !239
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

; Function Attrs: convergent nounwind willreturn
declare void @llvm.mxc.barrier() #6

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

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
!1 = !DIFile(filename: "/tmp/tmpipa3wm_x/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpipa3wm_x/tvm_kernels.maca", directory: "")
!42 = !DILocation(line: 26, column: 3, scope: !40)
!43 = !DILocation(line: 27, column: 35, scope: !40)
!44 = !DILocation(line: 34, column: 28, scope: !40)
!45 = !DILocation(line: 27, column: 101, scope: !40)
!46 = !{i32 0, i32 1024}
!47 = !DILocation(line: 37, column: 3, scope: !40)
!48 = !DILocation(line: 38, column: 46, scope: !40)
!49 = !DILocation(line: 38, column: 32, scope: !40)
!50 = !DILocation(line: 51, column: 20, scope: !40)
!51 = !DILocation(line: 53, column: 7, scope: !40)
!52 = !DILocation(line: 56, column: 62, scope: !40)
!53 = !DILocation(line: 56, column: 13, scope: !40)
!54 = !DILocation(line: 57, column: 35, scope: !40)
!55 = !DILocation(line: 57, column: 21, scope: !40)
!56 = !DILocation(line: 58, column: 9, scope: !40)
!57 = !DILocation(line: 0, scope: !40)
!58 = !DILocation(line: 67, column: 13, scope: !40)
!59 = !DILocation(line: 68, column: 35, scope: !40)
!60 = !DILocation(line: 68, column: 21, scope: !40)
!61 = !DILocation(line: 69, column: 9, scope: !40)
!62 = !DILocation(line: 76, column: 161, scope: !40)
!63 = !DILocation(line: 76, column: 44, scope: !40)
!64 = !DILocation(line: 78, column: 14, scope: !40)
!65 = !DILocation(line: 78, column: 11, scope: !40)
!66 = !DILocation(line: 82, column: 64, scope: !40)
!67 = !DILocation(line: 87, column: 22, scope: !40)
!68 = !DILocation(line: 82, column: 57, scope: !40)
!69 = !DILocation(line: 60, column: 3, scope: !70, inlinedAt: !72)
!70 = distinct !DISubprogram(name: "__barrier", scope: !71, file: !71, line: 57, type: !7, scopeLine: 57, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!71 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!72 = distinct !DILocation(line: 74, column: 3, scope: !73, inlinedAt: !74)
!73 = distinct !DISubprogram(name: "__syncthreads", scope: !71, file: !71, line: 73, type: !7, scopeLine: 73, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!74 = distinct !DILocation(line: 94, column: 5, scope: !40)
!75 = !DILocation(line: 61, column: 3, scope: !70, inlinedAt: !72)
!76 = !DILocation(line: 62, column: 3, scope: !70, inlinedAt: !72)
!77 = !DILocation(line: 95, column: 20, scope: !40)
!78 = !DILocation(line: 97, column: 143, scope: !40)
!79 = !DILocation(line: 97, column: 64, scope: !40)
!80 = !DILocation(line: 97, column: 27, scope: !40)
!81 = !DILocation(line: 100, column: 36, scope: !40)
!82 = !{i32 -1, i32 3, i32 -1}
!83 = !DILocation(line: 97, column: 114, scope: !40)
!84 = !DILocation(line: 108, column: 170, scope: !40)
!85 = !DILocation(line: 108, column: 44, scope: !40)
!86 = !DILocation(line: 112, column: 33, scope: !40)
!87 = !DILocation(line: 112, column: 44, scope: !40)
!88 = !DILocation(line: 354, column: 10, scope: !89, inlinedAt: !91)
!89 = distinct !DISubprogram(name: "min", scope: !90, file: !90, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!90 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!91 = distinct !DILocation(line: 112, column: 28, scope: !40)
!92 = !DILocation(line: 285, column: 49, scope: !93, inlinedAt: !94)
!93 = distinct !DISubprogram(name: "exp2f", scope: !90, file: !90, line: 285, type: !7, scopeLine: 285, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!94 = distinct !DILocation(line: 112, column: 22, scope: !40)
!95 = !DILocation(line: 112, column: 20, scope: !40)
!96 = !DILocation(line: 116, column: 38, scope: !40)
!97 = !DILocation(line: 1007, column: 10, scope: !98, inlinedAt: !100)
!98 = distinct !DISubprogram(name: "__float2half_rn", scope: !99, file: !99, line: 1005, type: !7, scopeLine: 1005, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!99 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!100 = distinct !DILocation(line: 1077, column: 18, scope: !101, inlinedAt: !102)
!101 = distinct !DISubprogram(name: "__floats2half2_rn", scope: !99, file: !99, line: 1075, type: !7, scopeLine: 1076, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!102 = distinct !DILocation(line: 1295, column: 23, scope: !103, inlinedAt: !104)
!103 = distinct !DISubprogram(name: "__float22half2_rn", scope: !99, file: !99, line: 1294, type: !7, scopeLine: 1294, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!104 = distinct !DILocation(line: 120, column: 29, scope: !40)
!105 = !{!106, !108}
!106 = distinct !{!106, !107, !"_ZL17__floats2half2_rnff: %agg.result"}
!107 = distinct !{!107, !"_ZL17__floats2half2_rnff"}
!108 = distinct !{!108, !109, !"_ZL17__float22half2_rn6float2: %agg.result"}
!109 = distinct !{!109, !"_ZL17__float22half2_rn6float2"}
!110 = !DILocation(line: 1007, column: 10, scope: !98, inlinedAt: !111)
!111 = distinct !DILocation(line: 1077, column: 38, scope: !101, inlinedAt: !102)
!112 = !DILocation(line: 593, column: 26, scope: !113, inlinedAt: !114)
!113 = distinct !DISubprogram(name: "operator=", scope: !99, file: !99, line: 592, type: !7, scopeLine: 592, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!114 = distinct !DILocation(line: 120, column: 27, scope: !40)
!115 = !DILocation(line: 1007, column: 10, scope: !98, inlinedAt: !116)
!116 = distinct !DILocation(line: 1077, column: 18, scope: !101, inlinedAt: !117)
!117 = distinct !DILocation(line: 1295, column: 23, scope: !103, inlinedAt: !118)
!118 = distinct !DILocation(line: 121, column: 29, scope: !40)
!119 = !{!120, !122}
!120 = distinct !{!120, !121, !"_ZL17__floats2half2_rnff: %agg.result"}
!121 = distinct !{!121, !"_ZL17__floats2half2_rnff"}
!122 = distinct !{!122, !123, !"_ZL17__float22half2_rn6float2: %agg.result"}
!123 = distinct !{!123, !"_ZL17__float22half2_rn6float2"}
!124 = !DILocation(line: 1007, column: 10, scope: !98, inlinedAt: !125)
!125 = distinct !DILocation(line: 1077, column: 38, scope: !101, inlinedAt: !117)
!126 = !DILocation(line: 593, column: 26, scope: !113, inlinedAt: !127)
!127 = distinct !DILocation(line: 121, column: 27, scope: !40)
!128 = !DILocation(line: 123, column: 5, scope: !40)
!129 = !DILocation(line: 60, column: 3, scope: !70, inlinedAt: !130)
!130 = distinct !DILocation(line: 74, column: 3, scope: !73, inlinedAt: !131)
!131 = distinct !DILocation(line: 124, column: 5, scope: !40)
!132 = !DILocation(line: 61, column: 3, scope: !70, inlinedAt: !130)
!133 = !DILocation(line: 62, column: 3, scope: !70, inlinedAt: !130)
!134 = !DILocation(line: 125, column: 20, scope: !40)
!135 = !DILocation(line: 128, column: 169, scope: !40)
!136 = !DILocation(line: 128, column: 224, scope: !40)
!137 = !DILocation(line: 128, column: 120, scope: !40)
!138 = !DILocation(line: 128, column: 230, scope: !40)
!139 = !DILocation(line: 128, column: 38, scope: !40)
!140 = !DILocation(line: 128, column: 36, scope: !40)
!141 = !{!26, !26, i64 0}
!142 = !DILocation(line: 128, column: 101, scope: !40)
!143 = !DILocation(line: 128, column: 211, scope: !40)
!144 = !DILocation(line: 133, column: 38, scope: !40)
!145 = !DILocation(line: 49, column: 26, scope: !40)
!146 = !DILocation(line: 72, column: 38, scope: !40)
!147 = !DILocation(line: 116, column: 22, scope: !40)
!148 = !DILocation(line: 133, column: 36, scope: !40)
!149 = !DILocation(line: 143, column: 36, scope: !40)
!150 = !DILocation(line: 60, column: 3, scope: !70, inlinedAt: !151)
!151 = distinct !DILocation(line: 74, column: 3, scope: !73, inlinedAt: !152)
!152 = distinct !DILocation(line: 145, column: 3, scope: !40)
!153 = !DILocation(line: 61, column: 3, scope: !70, inlinedAt: !151)
!154 = !DILocation(line: 62, column: 3, scope: !70, inlinedAt: !151)
!155 = !DILocation(line: 1018, column: 9, scope: !156, inlinedAt: !157)
!156 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !71, file: !71, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!157 = distinct !DILocation(line: 396, column: 10, scope: !158, inlinedAt: !160)
!158 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !159, file: !159, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!159 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!160 = distinct !DILocation(line: 129, column: 24, scope: !161, inlinedAt: !163)
!161 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !162, file: !162, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!162 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!163 = distinct !DILocation(line: 101, column: 14, scope: !164, inlinedAt: !165)
!164 = distinct !DISubprogram(name: "run<float>", scope: !162, file: !162, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!165 = distinct !DILocation(line: 146, column: 19, scope: !40)
!166 = !DILocation(line: 171, column: 37, scope: !167, inlinedAt: !168)
!167 = distinct !DISubprogram(name: "__lane_id", scope: !71, file: !71, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!168 = distinct !DILocation(line: 990, column: 14, scope: !169, inlinedAt: !170)
!169 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !71, file: !71, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!170 = distinct !DILocation(line: 1019, column: 11, scope: !156, inlinedAt: !157)
!171 = !DILocation(line: 171, column: 10, scope: !167, inlinedAt: !168)
!172 = !DILocation(line: 991, column: 20, scope: !169, inlinedAt: !170)
!173 = !DILocation(line: 992, column: 36, scope: !169, inlinedAt: !170)
!174 = !DILocation(line: 992, column: 17, scope: !169, inlinedAt: !170)
!175 = !DILocation(line: 992, column: 11, scope: !169, inlinedAt: !170)
!176 = !DILocation(line: 993, column: 43, scope: !169, inlinedAt: !170)
!177 = !DILocation(line: 993, column: 10, scope: !169, inlinedAt: !170)
!178 = !DILocation(line: 1020, column: 14, scope: !156, inlinedAt: !157)
!179 = !DILocation(line: 25, column: 14, scope: !180, inlinedAt: !181)
!180 = distinct !DISubprogram(name: "operator()<float>", scope: !162, file: !162, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!181 = distinct !DILocation(line: 129, column: 11, scope: !161, inlinedAt: !163)
!182 = !DILocation(line: 1018, column: 9, scope: !156, inlinedAt: !183)
!183 = distinct !DILocation(line: 396, column: 10, scope: !158, inlinedAt: !184)
!184 = distinct !DILocation(line: 129, column: 24, scope: !185, inlinedAt: !186)
!185 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !162, file: !162, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!186 = distinct !DILocation(line: 101, column: 14, scope: !187, inlinedAt: !188)
!187 = distinct !DISubprogram(name: "run<float>", scope: !162, file: !162, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!188 = distinct !DILocation(line: 134, column: 14, scope: !161, inlinedAt: !163)
!189 = !DILocation(line: 171, column: 37, scope: !167, inlinedAt: !190)
!190 = distinct !DILocation(line: 990, column: 14, scope: !169, inlinedAt: !191)
!191 = distinct !DILocation(line: 1019, column: 11, scope: !156, inlinedAt: !183)
!192 = !DILocation(line: 171, column: 10, scope: !167, inlinedAt: !190)
!193 = !DILocation(line: 991, column: 20, scope: !169, inlinedAt: !191)
!194 = !DILocation(line: 992, column: 36, scope: !169, inlinedAt: !191)
!195 = !DILocation(line: 992, column: 17, scope: !169, inlinedAt: !191)
!196 = !DILocation(line: 992, column: 11, scope: !169, inlinedAt: !191)
!197 = !DILocation(line: 993, column: 43, scope: !169, inlinedAt: !191)
!198 = !DILocation(line: 993, column: 10, scope: !169, inlinedAt: !191)
!199 = !DILocation(line: 1020, column: 14, scope: !156, inlinedAt: !183)
!200 = !DILocation(line: 25, column: 14, scope: !180, inlinedAt: !201)
!201 = distinct !DILocation(line: 129, column: 11, scope: !185, inlinedAt: !186)
!202 = !DILocation(line: 148, column: 32, scope: !40)
!203 = !DILocation(line: 148, column: 7, scope: !40)
!204 = !DILocation(line: 156, column: 19, scope: !40)
!205 = !DILocation(line: 156, column: 30, scope: !40)
!206 = !DILocation(line: 159, column: 3, scope: !40)
!207 = !DILocation(line: 1007, column: 10, scope: !98, inlinedAt: !208)
!208 = distinct !DILocation(line: 1077, column: 18, scope: !101, inlinedAt: !209)
!209 = distinct !DILocation(line: 1295, column: 23, scope: !103, inlinedAt: !210)
!210 = distinct !DILocation(line: 162, column: 27, scope: !40)
!211 = !{!212, !214}
!212 = distinct !{!212, !213, !"_ZL17__floats2half2_rnff: %agg.result"}
!213 = distinct !{!213, !"_ZL17__floats2half2_rnff"}
!214 = distinct !{!214, !215, !"_ZL17__float22half2_rn6float2: %agg.result"}
!215 = distinct !{!215, !"_ZL17__float22half2_rn6float2"}
!216 = !DILocation(line: 1007, column: 10, scope: !98, inlinedAt: !217)
!217 = distinct !DILocation(line: 1077, column: 38, scope: !101, inlinedAt: !209)
!218 = !DILocation(line: 596, column: 67, scope: !219, inlinedAt: !220)
!219 = distinct !DISubprogram(name: "__half2", scope: !99, file: !99, line: 596, type: !7, scopeLine: 596, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!220 = distinct !DILocation(line: 1077, column: 10, scope: !101, inlinedAt: !209)
!221 = !DILocation(line: 596, column: 73, scope: !219, inlinedAt: !220)
!222 = !DILocation(line: 1007, column: 10, scope: !98, inlinedAt: !223)
!223 = distinct !DILocation(line: 1077, column: 18, scope: !101, inlinedAt: !224)
!224 = distinct !DILocation(line: 1295, column: 23, scope: !103, inlinedAt: !225)
!225 = distinct !DILocation(line: 163, column: 27, scope: !40)
!226 = !{!227, !229}
!227 = distinct !{!227, !228, !"_ZL17__floats2half2_rnff: %agg.result"}
!228 = distinct !{!228, !"_ZL17__floats2half2_rnff"}
!229 = distinct !{!229, !230, !"_ZL17__float22half2_rn6float2: %agg.result"}
!230 = distinct !{!230, !"_ZL17__float22half2_rn6float2"}
!231 = !DILocation(line: 1007, column: 10, scope: !98, inlinedAt: !232)
!232 = distinct !DILocation(line: 1077, column: 38, scope: !101, inlinedAt: !224)
!233 = !DILocation(line: 596, column: 67, scope: !219, inlinedAt: !234)
!234 = distinct !DILocation(line: 1077, column: 10, scope: !101, inlinedAt: !224)
!235 = !DILocation(line: 596, column: 73, scope: !219, inlinedAt: !234)
!236 = !DILocation(line: 164, column: 38, scope: !40)
!237 = !DILocation(line: 165, column: 22, scope: !40)
!238 = !DILocation(line: 165, column: 172, scope: !40)
!239 = !DILocation(line: 167, column: 1, scope: !40)
