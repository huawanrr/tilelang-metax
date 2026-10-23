; ModuleID = 'experiments/20261016_rsqrt/binary/oj10_m1_p0.bc'
source_filename = "/tmp/tmpx4ex0ceb/tvm_kernels.maca"
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
  %mul = shl nsw i32 %0, 10
  %1 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %and = shl nuw nsw i32 %1, 6
  %mul7 = and i32 %and, 960
  %add = or disjoint i32 %mul7, %mul
  %2 = lshr i32 %1, 1
  %mul11 = and i32 %2, 504
  %add9 = add nuw nsw i32 %add, %mul11
  %3 = zext nneg i32 %add9 to i64, !dbg !43
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !44
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16, !dbg !45
  %Q_reg.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !45
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.4.0.add.ptr.sroa_idx, align 8, !dbg !45
  %4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !44
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %4, i64 64, !dbg !44
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16, !dbg !45
  %Q_reg.sroa.7.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %4, i64 72, !dbg !45
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.7.16.add.ptr.1.sroa_idx, align 8, !dbg !45
  %mul22 = shl nuw nsw i32 %0, 1
  %5 = zext nneg i32 %mul22 to i64, !dbg !46
  %arrayidx24 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %5, !dbg !47
  %6 = load i32, ptr addrspace(1) %arrayidx24, align 4, !dbg !47, !tbaa !30
  %cmp26 = icmp ult i32 %6, 16
  %7 = shl nsw i32 %6, 4, !dbg !48
  %mul27 = select i1 %cmp26, i32 %7, i32 -16, !dbg !48
  %8 = or disjoint i64 %5, 1, !dbg !49
  %arrayidx24.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8, !dbg !47
  %9 = load i32, ptr addrspace(1) %arrayidx24.1, align 4, !dbg !47, !tbaa !30
  %cmp26.1 = icmp ult i32 %9, 16
  %10 = shl nsw i32 %9, 4, !dbg !48
  %mul27.1 = select i1 %cmp26.1, i32 %10, i32 -16, !dbg !48
  %shr62 = lshr i32 %1, 3
  %11 = shl nuw nsw i32 %1, 3
  %12 = and i32 %11, 56
  %add58 = add nsw i32 %shr62, %mul27, !dbg !50
  %or.cond = icmp ult i32 %add58, 256, !dbg !51
  br i1 %or.cond, label %if.then70, label %if.then52.1, !dbg !51

if.then70:                                        ; preds = %entry
  %13 = shl nuw nsw i32 %add58, 6
  %add76813 = or disjoint i32 %13, %12
  %add76 = zext nneg i32 %add76813 to i64
  %add.ptr77 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add76
  %condval_2.sroa.7.0.add.ptr77.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr77, i64 12
  %condval_2.sroa.6.0.add.ptr77.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr77, i64 8
  %condval_2.sroa.5.0.add.ptr77.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr77, i64 4
  %condval_2.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr77, align 16, !dbg !52, !tbaa !30
  %condval_2.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr77.sroa_idx, align 4, !dbg !52, !tbaa !30
  %condval_2.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr77.sroa_idx, align 8, !dbg !52, !tbaa !30
  %condval_2.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr77.sroa_idx, align 4, !dbg !52, !tbaa !30
  br label %if.then52.1, !dbg !53

if.then52.1:                                      ; preds = %if.then70, %entry
  %condval_2.sroa.0.0 = phi i32 [ %condval_2.sroa.0.0.copyload, %if.then70 ], [ 0, %entry ], !dbg !54
  %condval_2.sroa.5.0 = phi i32 [ %condval_2.sroa.5.0.copyload, %if.then70 ], [ 0, %entry ], !dbg !54
  %condval_2.sroa.6.0 = phi i32 [ %condval_2.sroa.6.0.copyload, %if.then70 ], [ 0, %entry ], !dbg !54
  %condval_2.sroa.7.0 = phi i32 [ %condval_2.sroa.7.0.copyload, %if.then70 ], [ 0, %entry ], !dbg !54
  %add56.1 = add nuw nsw i32 %shr62, 8, !dbg !55
  %add58.1 = add nsw i32 %add56.1, %mul27, !dbg !50
  %or.cond.1 = icmp ult i32 %add58.1, 256, !dbg !51
  br i1 %or.cond.1, label %if.then70.1, label %if.else59.2, !dbg !51

if.then70.1:                                      ; preds = %if.then52.1
  %14 = shl nuw nsw i32 %add58.1, 6
  %add76813.1 = or disjoint i32 %14, %12
  %add76.1 = zext nneg i32 %add76813.1 to i64
  %add.ptr77.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add76.1
  %condval_2.sroa.7.0.add.ptr77.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr77.1, i64 12
  %condval_2.sroa.6.0.add.ptr77.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr77.1, i64 8
  %condval_2.sroa.5.0.add.ptr77.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr77.1, i64 4
  %condval_2.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr77.1, align 16, !dbg !52, !tbaa !30
  %condval_2.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr77.sroa_idx.1, align 4, !dbg !52, !tbaa !30
  %condval_2.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr77.sroa_idx.1, align 8, !dbg !52, !tbaa !30
  %condval_2.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr77.sroa_idx.1, align 4, !dbg !52, !tbaa !30
  br label %if.else59.2, !dbg !53

if.else59.2:                                      ; preds = %if.then52.1, %if.then70.1
  %condval_2.sroa.0.0.1 = phi i32 [ %condval_2.sroa.0.0.copyload.1, %if.then70.1 ], [ 0, %if.then52.1 ], !dbg !54
  %condval_2.sroa.5.0.1 = phi i32 [ %condval_2.sroa.5.0.copyload.1, %if.then70.1 ], [ 0, %if.then52.1 ], !dbg !54
  %condval_2.sroa.6.0.1 = phi i32 [ %condval_2.sroa.6.0.copyload.1, %if.then70.1 ], [ 0, %if.then52.1 ], !dbg !54
  %condval_2.sroa.7.0.1 = phi i32 [ %condval_2.sroa.7.0.copyload.1, %if.then70.1 ], [ 0, %if.then52.1 ], !dbg !54
  %sub.2 = add i32 %shr62, %mul27.1, !dbg !56
  %or.cond.2 = icmp ult i32 %sub.2, 256, !dbg !51
  br i1 %or.cond.2, label %if.then70.2, label %if.else59.3, !dbg !51

if.then70.2:                                      ; preds = %if.else59.2
  %15 = shl nuw nsw i32 %sub.2, 6
  %add76813.2 = or disjoint i32 %15, %12
  %add76.2 = zext nneg i32 %add76813.2 to i64
  %add.ptr77.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add76.2
  %condval_2.sroa.7.0.add.ptr77.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr77.2, i64 12
  %condval_2.sroa.6.0.add.ptr77.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr77.2, i64 8
  %condval_2.sroa.5.0.add.ptr77.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr77.2, i64 4
  %condval_2.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %add.ptr77.2, align 16, !dbg !52, !tbaa !30
  %condval_2.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr77.sroa_idx.2, align 4, !dbg !52, !tbaa !30
  %condval_2.sroa.6.0.copyload.2 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr77.sroa_idx.2, align 8, !dbg !52, !tbaa !30
  %condval_2.sroa.7.0.copyload.2 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr77.sroa_idx.2, align 4, !dbg !52, !tbaa !30
  br label %if.else59.3, !dbg !53

if.else59.3:                                      ; preds = %if.else59.2, %if.then70.2
  %condval_2.sroa.0.0.2 = phi i32 [ %condval_2.sroa.0.0.copyload.2, %if.then70.2 ], [ 0, %if.else59.2 ], !dbg !54
  %condval_2.sroa.5.0.2 = phi i32 [ %condval_2.sroa.5.0.copyload.2, %if.then70.2 ], [ 0, %if.else59.2 ], !dbg !54
  %condval_2.sroa.6.0.2 = phi i32 [ %condval_2.sroa.6.0.copyload.2, %if.then70.2 ], [ 0, %if.else59.2 ], !dbg !54
  %condval_2.sroa.7.0.2 = phi i32 [ %condval_2.sroa.7.0.copyload.2, %if.then70.2 ], [ 0, %if.else59.2 ], !dbg !54
  %add65.3 = add nuw nsw i32 %shr62, 8, !dbg !57
  %sub.3 = add i32 %add65.3, %mul27.1, !dbg !56
  %or.cond.3 = icmp ult i32 %sub.3, 256, !dbg !51
  br i1 %or.cond.3, label %if.then70.3, label %if.then113, !dbg !51

if.then70.3:                                      ; preds = %if.else59.3
  %16 = shl nuw nsw i32 %sub.3, 6
  %add76813.3 = or disjoint i32 %16, %12
  %add76.3 = zext nneg i32 %add76813.3 to i64
  %add.ptr77.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add76.3
  %condval_2.sroa.7.0.add.ptr77.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr77.3, i64 12
  %condval_2.sroa.6.0.add.ptr77.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr77.3, i64 8
  %condval_2.sroa.5.0.add.ptr77.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr77.3, i64 4
  %condval_2.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %add.ptr77.3, align 16, !dbg !52, !tbaa !30
  %condval_2.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr77.sroa_idx.3, align 4, !dbg !52, !tbaa !30
  %condval_2.sroa.6.0.copyload.3 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr77.sroa_idx.3, align 8, !dbg !52, !tbaa !30
  %condval_2.sroa.7.0.copyload.3 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr77.sroa_idx.3, align 4, !dbg !52, !tbaa !30
  br label %if.then113, !dbg !53

if.then113:                                       ; preds = %if.else59.3, %if.then70.3
  %condval_2.sroa.0.0.3 = phi i32 [ %condval_2.sroa.0.0.copyload.3, %if.then70.3 ], [ 0, %if.else59.3 ], !dbg !54
  %condval_2.sroa.5.0.3 = phi i32 [ %condval_2.sroa.5.0.copyload.3, %if.then70.3 ], [ 0, %if.else59.3 ], !dbg !54
  %condval_2.sroa.6.0.3 = phi i32 [ %condval_2.sroa.6.0.copyload.3, %if.then70.3 ], [ 0, %if.else59.3 ], !dbg !54
  %condval_2.sroa.7.0.3 = phi i32 [ %condval_2.sroa.7.0.copyload.3, %if.then70.3 ], [ 0, %if.else59.3 ], !dbg !54
  %add119 = add nsw i32 %shr62, %mul27, !dbg !58
  %or.cond728 = icmp ult i32 %add119, 256, !dbg !59
  br i1 %or.cond728, label %if.then132, label %if.then113.1, !dbg !59

if.then132:                                       ; preds = %if.then113
  %17 = shl nuw nsw i32 %add119, 6
  %add139814 = or disjoint i32 %17, %12
  %add139 = zext nneg i32 %add139814 to i64
  %add.ptr140 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add139
  %condval_4.sroa.7.0.add.ptr140.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr140, i64 12
  %condval_4.sroa.6.0.add.ptr140.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr140, i64 8
  %condval_4.sroa.5.0.add.ptr140.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr140, i64 4
  %condval_4.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr140, align 16, !dbg !60, !tbaa !30
  %condval_4.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr140.sroa_idx, align 4, !dbg !60, !tbaa !30
  %condval_4.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr140.sroa_idx, align 8, !dbg !60, !tbaa !30
  %condval_4.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr140.sroa_idx, align 4, !dbg !60, !tbaa !30
  br label %if.then113.1, !dbg !61

if.then113.1:                                     ; preds = %if.then132, %if.then113
  %condval_4.sroa.0.0 = phi i32 [ %condval_4.sroa.0.0.copyload, %if.then132 ], [ 0, %if.then113 ], !dbg !54
  %condval_4.sroa.5.0 = phi i32 [ %condval_4.sroa.5.0.copyload, %if.then132 ], [ 0, %if.then113 ], !dbg !54
  %condval_4.sroa.6.0 = phi i32 [ %condval_4.sroa.6.0.copyload, %if.then132 ], [ 0, %if.then113 ], !dbg !54
  %condval_4.sroa.7.0 = phi i32 [ %condval_4.sroa.7.0.copyload, %if.then132 ], [ 0, %if.then113 ], !dbg !54
  %add117.1 = add nuw nsw i32 %shr62, 8, !dbg !62
  %add119.1 = add nsw i32 %add117.1, %mul27, !dbg !58
  %or.cond728.1 = icmp ult i32 %add119.1, 256, !dbg !59
  br i1 %or.cond728.1, label %if.then132.1, label %if.else120.2, !dbg !59

if.then132.1:                                     ; preds = %if.then113.1
  %18 = shl nuw nsw i32 %add119.1, 6
  %add139814.1 = or disjoint i32 %18, %12
  %add139.1 = zext nneg i32 %add139814.1 to i64
  %add.ptr140.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add139.1
  %condval_4.sroa.7.0.add.ptr140.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr140.1, i64 12
  %condval_4.sroa.6.0.add.ptr140.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr140.1, i64 8
  %condval_4.sroa.5.0.add.ptr140.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr140.1, i64 4
  %condval_4.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr140.1, align 16, !dbg !60, !tbaa !30
  %condval_4.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr140.sroa_idx.1, align 4, !dbg !60, !tbaa !30
  %condval_4.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr140.sroa_idx.1, align 8, !dbg !60, !tbaa !30
  %condval_4.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr140.sroa_idx.1, align 4, !dbg !60, !tbaa !30
  br label %if.else120.2, !dbg !61

if.else120.2:                                     ; preds = %if.then113.1, %if.then132.1
  %condval_4.sroa.0.0.1 = phi i32 [ %condval_4.sroa.0.0.copyload.1, %if.then132.1 ], [ 0, %if.then113.1 ], !dbg !54
  %condval_4.sroa.5.0.1 = phi i32 [ %condval_4.sroa.5.0.copyload.1, %if.then132.1 ], [ 0, %if.then113.1 ], !dbg !54
  %condval_4.sroa.6.0.1 = phi i32 [ %condval_4.sroa.6.0.copyload.1, %if.then132.1 ], [ 0, %if.then113.1 ], !dbg !54
  %condval_4.sroa.7.0.1 = phi i32 [ %condval_4.sroa.7.0.copyload.1, %if.then132.1 ], [ 0, %if.then113.1 ], !dbg !54
  %sub127.2 = add i32 %shr62, %mul27.1, !dbg !63
  %or.cond728.2 = icmp ult i32 %sub127.2, 256, !dbg !59
  br i1 %or.cond728.2, label %if.then132.2, label %if.else120.3, !dbg !59

if.then132.2:                                     ; preds = %if.else120.2
  %19 = shl nuw nsw i32 %sub127.2, 6
  %add139814.2 = or disjoint i32 %19, %12
  %add139.2 = zext nneg i32 %add139814.2 to i64
  %add.ptr140.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add139.2
  %condval_4.sroa.7.0.add.ptr140.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr140.2, i64 12
  %condval_4.sroa.6.0.add.ptr140.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr140.2, i64 8
  %condval_4.sroa.5.0.add.ptr140.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr140.2, i64 4
  %condval_4.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %add.ptr140.2, align 16, !dbg !60, !tbaa !30
  %condval_4.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr140.sroa_idx.2, align 4, !dbg !60, !tbaa !30
  %condval_4.sroa.6.0.copyload.2 = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr140.sroa_idx.2, align 8, !dbg !60, !tbaa !30
  %condval_4.sroa.7.0.copyload.2 = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr140.sroa_idx.2, align 4, !dbg !60, !tbaa !30
  br label %if.else120.3, !dbg !61

if.else120.3:                                     ; preds = %if.else120.2, %if.then132.2
  %condval_4.sroa.0.0.2 = phi i32 [ %condval_4.sroa.0.0.copyload.2, %if.then132.2 ], [ 0, %if.else120.2 ], !dbg !54
  %condval_4.sroa.5.0.2 = phi i32 [ %condval_4.sroa.5.0.copyload.2, %if.then132.2 ], [ 0, %if.else120.2 ], !dbg !54
  %condval_4.sroa.6.0.2 = phi i32 [ %condval_4.sroa.6.0.copyload.2, %if.then132.2 ], [ 0, %if.else120.2 ], !dbg !54
  %condval_4.sroa.7.0.2 = phi i32 [ %condval_4.sroa.7.0.copyload.2, %if.then132.2 ], [ 0, %if.else120.2 ], !dbg !54
  %add126.3 = add nuw nsw i32 %shr62, 8, !dbg !64
  %sub127.3 = add i32 %add126.3, %mul27.1, !dbg !63
  %or.cond728.3 = icmp ult i32 %sub127.3, 256, !dbg !59
  br i1 %or.cond728.3, label %if.then132.3, label %if.end164.3, !dbg !59

if.then132.3:                                     ; preds = %if.else120.3
  %20 = shl nuw nsw i32 %sub127.3, 6
  %add139814.3 = or disjoint i32 %20, %12
  %add139.3 = zext nneg i32 %add139814.3 to i64
  %add.ptr140.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add139.3
  %condval_4.sroa.7.0.add.ptr140.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr140.3, i64 12
  %condval_4.sroa.6.0.add.ptr140.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr140.3, i64 8
  %condval_4.sroa.5.0.add.ptr140.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr140.3, i64 4
  %condval_4.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %add.ptr140.3, align 16, !dbg !60, !tbaa !30
  %condval_4.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr140.sroa_idx.3, align 4, !dbg !60, !tbaa !30
  %condval_4.sroa.6.0.copyload.3 = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr140.sroa_idx.3, align 8, !dbg !60, !tbaa !30
  %condval_4.sroa.7.0.copyload.3 = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr140.sroa_idx.3, align 4, !dbg !60, !tbaa !30
  br label %if.end164.3, !dbg !61

if.end164.3:                                      ; preds = %if.then132.3, %if.else120.3
  %condval_4.sroa.0.0.3 = phi i32 [ %condval_4.sroa.0.0.copyload.3, %if.then132.3 ], [ 0, %if.else120.3 ], !dbg !54
  %condval_4.sroa.5.0.3 = phi i32 [ %condval_4.sroa.5.0.copyload.3, %if.then132.3 ], [ 0, %if.else120.3 ], !dbg !54
  %condval_4.sroa.6.0.3 = phi i32 [ %condval_4.sroa.6.0.copyload.3, %if.then132.3 ], [ 0, %if.else120.3 ], !dbg !54
  %condval_4.sroa.7.0.3 = phi i32 [ %condval_4.sroa.7.0.copyload.3, %if.then132.3 ], [ 0, %if.else120.3 ], !dbg !54
  %mul184 = and i32 %11, 8128
  %call188.masked = and i32 %1, 1016
  %mul190 = xor i32 %12, %call188.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul184, !dbg !65
  %invariant.gep780 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul190, !dbg !65
  store i32 %condval_2.sroa.0.0, ptr addrspace(3) %invariant.gep780, align 16, !dbg !66, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep780.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 4, !dbg !66
  store i32 %condval_2.sroa.5.0, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep780.sroa_idx, align 4, !dbg !66, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep780.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 8, !dbg !66
  store i32 %condval_2.sroa.6.0, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep780.sroa_idx, align 8, !dbg !66, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep780.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 12, !dbg !66
  store i32 %condval_2.sroa.7.0, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep780.sroa_idx, align 4, !dbg !66, !tbaa !30
  %gep781.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 1024, !dbg !67
  store i32 %condval_2.sroa.0.0.1, ptr addrspace(3) %gep781.1, align 16, !dbg !66, !tbaa !30
  %K_reg.sroa.9.16.gep781.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 1028, !dbg !66
  store i32 %condval_2.sroa.5.0.1, ptr addrspace(3) %K_reg.sroa.9.16.gep781.1.sroa_idx, align 4, !dbg !66, !tbaa !30
  %K_reg.sroa.10.16.gep781.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 1032, !dbg !66
  store i32 %condval_2.sroa.6.0.1, ptr addrspace(3) %K_reg.sroa.10.16.gep781.1.sroa_idx, align 8, !dbg !66, !tbaa !30
  %K_reg.sroa.11.16.gep781.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 1036, !dbg !66
  store i32 %condval_2.sroa.7.0.1, ptr addrspace(3) %K_reg.sroa.11.16.gep781.1.sroa_idx, align 4, !dbg !66, !tbaa !30
  %gep781.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 2048, !dbg !67
  store i32 %condval_2.sroa.0.0.2, ptr addrspace(3) %gep781.2, align 16, !dbg !66, !tbaa !30
  %K_reg.sroa.14.32.gep781.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 2052, !dbg !66
  store i32 %condval_2.sroa.5.0.2, ptr addrspace(3) %K_reg.sroa.14.32.gep781.2.sroa_idx, align 4, !dbg !66, !tbaa !30
  %K_reg.sroa.15.32.gep781.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 2056, !dbg !66
  store i32 %condval_2.sroa.6.0.2, ptr addrspace(3) %K_reg.sroa.15.32.gep781.2.sroa_idx, align 8, !dbg !66, !tbaa !30
  %K_reg.sroa.16.32.gep781.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 2060, !dbg !66
  store i32 %condval_2.sroa.7.0.2, ptr addrspace(3) %K_reg.sroa.16.32.gep781.2.sroa_idx, align 4, !dbg !66, !tbaa !30
  %gep781.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 3072, !dbg !67
  store i32 %condval_2.sroa.0.0.3, ptr addrspace(3) %gep781.3, align 16, !dbg !66, !tbaa !30
  %K_reg.sroa.19.48.gep781.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 3076, !dbg !66
  store i32 %condval_2.sroa.5.0.3, ptr addrspace(3) %K_reg.sroa.19.48.gep781.3.sroa_idx, align 4, !dbg !66, !tbaa !30
  %K_reg.sroa.20.48.gep781.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 3080, !dbg !66
  store i32 %condval_2.sroa.6.0.3, ptr addrspace(3) %K_reg.sroa.20.48.gep781.3.sroa_idx, align 8, !dbg !66, !tbaa !30
  %K_reg.sroa.21.48.gep781.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 3084, !dbg !66
  store i32 %condval_2.sroa.7.0.3, ptr addrspace(3) %K_reg.sroa.21.48.gep781.3.sroa_idx, align 4, !dbg !66, !tbaa !30
  fence syncscope("warp") release, !dbg !68
  tail call void @llvm.mxc.barrier.warp(), !dbg !74
  fence syncscope("warp") acquire, !dbg !75
  %shr227 = lshr i32 %1, 4
  %and230 = and i32 %1, 7
  %xor231 = xor i32 %shr227, %and230
  %add.ptr235.idx = shl nuw nsw i32 %xor231, 4
  %invariant.gep784 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr235.idx, !dbg !76
  %gep = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep784, i32 %mul7, !dbg !77
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %gep, align 16, !dbg !78
  %kb.sroa.6.0.gep.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep, i32 8, !dbg !78
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.gep.sroa_idx, align 8, !dbg !78
  %add224.1 = or disjoint i32 %mul7, 1024, !dbg !79
  %gep.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep784, i32 %add224.1, !dbg !77
  %kb.sroa.8.16.copyload = load <4 x half>, ptr addrspace(3) %gep.1, align 16, !dbg !78
  %kb.sroa.12.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep.1, i32 8, !dbg !78
  %kb.sroa.12.16.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.12.16.gep.1.sroa_idx, align 8, !dbg !78
  %21 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !80, !call_argsrelate !81
  %22 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.8.16.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !80, !call_argsrelate !81
  %23 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %21), !dbg !80, !call_argsrelate !81
  %24 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.12.16.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %22), !dbg !80, !call_argsrelate !81
  %add228.1 = add nuw nsw i32 %shr227, 4
  %xor231.1 = xor i32 %add228.1, %and230
  %add.ptr235.idx.1 = shl nuw nsw i32 %xor231.1, 4
  %invariant.gep784.1 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr235.idx.1, !dbg !76
  %gep.1824 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep784.1, i32 %mul7, !dbg !77
  %kb.sroa.0.0.copyload912 = load <4 x half>, ptr addrspace(3) %gep.1824, align 16, !dbg !78
  %kb.sroa.6.0.gep.1824.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep.1824, i32 8, !dbg !78
  %kb.sroa.6.0.copyload913 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.gep.1824.sroa_idx, align 8, !dbg !78
  %gep.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep784.1, i32 %add224.1, !dbg !77
  %kb.sroa.8.16.copyload916 = load <4 x half>, ptr addrspace(3) %gep.1.1, align 16, !dbg !78
  %kb.sroa.12.16.gep.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep.1.1, i32 8, !dbg !78
  %kb.sroa.12.16.copyload917 = load <4 x half>, ptr addrspace(3) %kb.sroa.12.16.gep.1.1.sroa_idx, align 8, !dbg !78
  %25 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload912, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %23), !dbg !80, !call_argsrelate !81
  %26 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.8.16.copyload916, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %24), !dbg !80, !call_argsrelate !81
  %27 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload913, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %25), !dbg !80, !call_argsrelate !81
  %28 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.12.16.copyload917, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %26), !dbg !80, !call_argsrelate !81
  fence syncscope("warp") release, !dbg !82
  tail call void @llvm.mxc.barrier.warp(), !dbg !85
  fence syncscope("warp") acquire, !dbg !86
  %add.ptr289.idx = shl nuw nsw i32 %1, 4
  %invariant.gep789 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr289.idx, !dbg !87
  store i32 %condval_4.sroa.0.0, ptr addrspace(3) %invariant.gep789, align 16, !dbg !88, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep789.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep789, i32 4, !dbg !88
  store i32 %condval_4.sroa.5.0, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep789.sroa_idx, align 4, !dbg !88, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep789.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep789, i32 8, !dbg !88
  store i32 %condval_4.sroa.6.0, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep789.sroa_idx, align 8, !dbg !88, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep789.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep789, i32 12, !dbg !88
  store i32 %condval_4.sroa.7.0, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep789.sroa_idx, align 4, !dbg !88, !tbaa !30
  %gep790.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep789, i32 1024, !dbg !89
  store i32 %condval_4.sroa.0.0.1, ptr addrspace(3) %gep790.1, align 16, !dbg !88, !tbaa !30
  %V_reg.sroa.9.16.gep790.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep789, i32 1028, !dbg !88
  store i32 %condval_4.sroa.5.0.1, ptr addrspace(3) %V_reg.sroa.9.16.gep790.1.sroa_idx, align 4, !dbg !88, !tbaa !30
  %V_reg.sroa.10.16.gep790.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep789, i32 1032, !dbg !88
  store i32 %condval_4.sroa.6.0.1, ptr addrspace(3) %V_reg.sroa.10.16.gep790.1.sroa_idx, align 8, !dbg !88, !tbaa !30
  %V_reg.sroa.11.16.gep790.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep789, i32 1036, !dbg !88
  store i32 %condval_4.sroa.7.0.1, ptr addrspace(3) %V_reg.sroa.11.16.gep790.1.sroa_idx, align 4, !dbg !88, !tbaa !30
  %gep790.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep789, i32 2048, !dbg !89
  store i32 %condval_4.sroa.0.0.2, ptr addrspace(3) %gep790.2, align 16, !dbg !88, !tbaa !30
  %V_reg.sroa.14.32.gep790.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep789, i32 2052, !dbg !88
  store i32 %condval_4.sroa.5.0.2, ptr addrspace(3) %V_reg.sroa.14.32.gep790.2.sroa_idx, align 4, !dbg !88, !tbaa !30
  %V_reg.sroa.15.32.gep790.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep789, i32 2056, !dbg !88
  store i32 %condval_4.sroa.6.0.2, ptr addrspace(3) %V_reg.sroa.15.32.gep790.2.sroa_idx, align 8, !dbg !88, !tbaa !30
  %V_reg.sroa.16.32.gep790.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep789, i32 2060, !dbg !88
  store i32 %condval_4.sroa.7.0.2, ptr addrspace(3) %V_reg.sroa.16.32.gep790.2.sroa_idx, align 4, !dbg !88, !tbaa !30
  %gep790.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep789, i32 3072, !dbg !89
  store i32 %condval_4.sroa.0.0.3, ptr addrspace(3) %gep790.3, align 16, !dbg !88, !tbaa !30
  %V_reg.sroa.19.48.gep790.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep789, i32 3076, !dbg !88
  store i32 %condval_4.sroa.5.0.3, ptr addrspace(3) %V_reg.sroa.19.48.gep790.3.sroa_idx, align 4, !dbg !88, !tbaa !30
  %V_reg.sroa.20.48.gep790.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep789, i32 3080, !dbg !88
  store i32 %condval_4.sroa.6.0.3, ptr addrspace(3) %V_reg.sroa.20.48.gep790.3.sroa_idx, align 8, !dbg !88, !tbaa !30
  %V_reg.sroa.21.48.gep790.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep789, i32 3084, !dbg !88
  store i32 %condval_4.sroa.7.0.3, ptr addrspace(3) %V_reg.sroa.21.48.gep790.3.sroa_idx, align 4, !dbg !88, !tbaa !30
  %29 = lshr i32 %1, 2
  %mul310 = and i32 %29, 252
  %add304 = add i32 %29, %mul27, !dbg !90
  %add325 = add i32 %mul310, %mul27, !dbg !91
  %add346 = add i32 %mul310, %mul27, !dbg !92
  %cmp360 = icmp slt i32 %add304, 0, !dbg !93
  %cmp362 = icmp sgt i32 %add325, 255
  %or.cond729.not816 = or i1 %cmp360, %cmp362, !dbg !94
  %cmp365.not = icmp sgt i32 %add346, %0
  %or.cond774 = or i1 %or.cond729.not816, %cmp365.not, !dbg !94
  br i1 %or.cond774, label %if.then298.1, label %if.then366, !dbg !94

if.then366:                                       ; preds = %if.end164.3
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %27, i64 0, !dbg !95
  %mul369 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !96
  %30 = tail call contract noundef float @llvm.minnum.f32(float %mul369, float 0x4024CB5EC0000000), !dbg !97
  %31 = tail call contract noundef float @llvm.exp.f32(float %30), !dbg !101
  br label %if.then298.1, !dbg !104

if.then298.1:                                     ; preds = %if.then366, %if.end164.3
  %condval_5.0 = phi float [ %31, %if.then366 ], [ 0.000000e+00, %if.end164.3 ], !dbg !54
  %add304.1 = add i32 %29, %mul27, !dbg !90
  %add324.1 = or disjoint i32 %mul310, 1, !dbg !105
  %add325.1 = add i32 %add324.1, %mul27, !dbg !91
  %add345.1 = or disjoint i32 %mul310, 1, !dbg !106
  %add346.1 = add i32 %add345.1, %mul27, !dbg !92
  %cmp360.1 = icmp slt i32 %add304.1, 0, !dbg !93
  %cmp362.1 = icmp sgt i32 %add325.1, 255
  %or.cond729.not816.1 = select i1 %cmp360.1, i1 true, i1 %cmp362.1, !dbg !94
  %cmp365.not.1 = icmp sgt i32 %add346.1, %0
  %or.cond774.1 = select i1 %or.cond729.not816.1, i1 true, i1 %cmp365.not.1, !dbg !94
  br i1 %or.cond774.1, label %if.then298.2, label %if.then366.1, !dbg !94

if.then366.1:                                     ; preds = %if.then298.1
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %27, i64 1, !dbg !95
  %mul369.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !96
  %32 = tail call contract noundef float @llvm.minnum.f32(float %mul369.1, float 0x4024CB5EC0000000), !dbg !97
  %33 = tail call contract noundef float @llvm.exp.f32(float %32), !dbg !101
  br label %if.then298.2, !dbg !104

if.then298.2:                                     ; preds = %if.then298.1, %if.then366.1
  %condval_5.0.1 = phi float [ %33, %if.then366.1 ], [ 0.000000e+00, %if.then298.1 ], !dbg !54
  %add304.2 = add i32 %29, %mul27, !dbg !90
  %add324.2 = or disjoint i32 %mul310, 2, !dbg !105
  %add325.2 = add i32 %add324.2, %mul27, !dbg !91
  %add345.2 = or disjoint i32 %mul310, 2, !dbg !106
  %add346.2 = add i32 %add345.2, %mul27, !dbg !92
  %cmp360.2 = icmp slt i32 %add304.2, 0, !dbg !93
  %cmp362.2 = icmp sgt i32 %add325.2, 255
  %or.cond729.not816.2 = select i1 %cmp360.2, i1 true, i1 %cmp362.2, !dbg !94
  %cmp365.not.2 = icmp sgt i32 %add346.2, %0
  %or.cond774.2 = select i1 %or.cond729.not816.2, i1 true, i1 %cmp365.not.2, !dbg !94
  br i1 %or.cond774.2, label %if.then298.3, label %if.then366.2, !dbg !94

if.then366.2:                                     ; preds = %if.then298.2
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %27, i64 2, !dbg !95
  %mul369.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !96
  %34 = tail call contract noundef float @llvm.minnum.f32(float %mul369.2, float 0x4024CB5EC0000000), !dbg !97
  %35 = tail call contract noundef float @llvm.exp.f32(float %34), !dbg !101
  br label %if.then298.3, !dbg !104

if.then298.3:                                     ; preds = %if.then298.2, %if.then366.2
  %condval_5.0.2 = phi float [ %35, %if.then366.2 ], [ 0.000000e+00, %if.then298.2 ], !dbg !54
  %add304.3 = add i32 %29, %mul27, !dbg !90
  %add324.3 = or i32 %29, 3, !dbg !105
  %add325.3 = add i32 %add324.3, %mul27, !dbg !91
  %add345.3 = or i32 %29, 3, !dbg !106
  %add346.3 = add i32 %add345.3, %mul27, !dbg !92
  %cmp360.3 = icmp slt i32 %add304.3, 0, !dbg !93
  %cmp362.3 = icmp sgt i32 %add325.3, 255
  %or.cond729.not816.3 = or i1 %cmp360.3, %cmp362.3, !dbg !94
  %cmp365.not.3 = icmp sgt i32 %add346.3, %0
  %or.cond774.3 = or i1 %or.cond729.not816.3, %cmp365.not.3, !dbg !94
  br i1 %or.cond774.3, label %if.else305.4, label %if.then366.3, !dbg !94

if.then366.3:                                     ; preds = %if.then298.3
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %27, i64 3, !dbg !95
  %mul369.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !96
  %36 = tail call contract noundef float @llvm.minnum.f32(float %mul369.3, float 0x4024CB5EC0000000), !dbg !97
  %37 = tail call contract noundef float @llvm.exp.f32(float %36), !dbg !101
  br label %if.else305.4, !dbg !104

if.else305.4:                                     ; preds = %if.then298.3, %if.then366.3
  %condval_5.0.3 = phi float [ %37, %if.then366.3 ], [ 0.000000e+00, %if.then298.3 ], !dbg !54
  %sub316.4 = add i32 %29, %mul27.1, !dbg !107
  %sub337.4 = add i32 %mul310, %mul27.1, !dbg !108
  %sub358.4 = add i32 %mul310, %mul27.1, !dbg !109
  %cmp360.4 = icmp slt i32 %sub316.4, 0, !dbg !93
  %cmp362.4 = icmp sgt i32 %sub337.4, 255
  %or.cond729.not816.4 = or i1 %cmp360.4, %cmp362.4, !dbg !94
  %cmp365.not.4 = icmp sgt i32 %sub358.4, %0
  %or.cond774.4 = select i1 %or.cond729.not816.4, i1 true, i1 %cmp365.not.4, !dbg !94
  br i1 %or.cond774.4, label %if.else305.5, label %if.then366.4, !dbg !94

if.then366.4:                                     ; preds = %if.else305.4
  %acc_s.sroa.38.16.vec.extract = extractelement <4 x float> %28, i64 0, !dbg !95
  %mul369.4 = fmul contract float %acc_s.sroa.38.16.vec.extract, 0x3FB99999A0000000, !dbg !96
  %38 = tail call contract noundef float @llvm.minnum.f32(float %mul369.4, float 0x4024CB5EC0000000), !dbg !97
  %39 = tail call contract noundef float @llvm.exp.f32(float %38), !dbg !101
  br label %if.else305.5, !dbg !104

if.else305.5:                                     ; preds = %if.else305.4, %if.then366.4
  %condval_5.0.4 = phi float [ %39, %if.then366.4 ], [ 0.000000e+00, %if.else305.4 ], !dbg !54
  %sub316.5 = add i32 %29, %mul27.1, !dbg !107
  %add336.5 = or disjoint i32 %mul310, 1, !dbg !110
  %sub337.5 = add i32 %add336.5, %mul27.1, !dbg !108
  %add357.5 = or disjoint i32 %mul310, 1, !dbg !111
  %sub358.5 = add i32 %add357.5, %mul27.1, !dbg !109
  %cmp360.5 = icmp slt i32 %sub316.5, 0, !dbg !93
  %cmp362.5 = icmp sgt i32 %sub337.5, 255
  %or.cond729.not816.5 = select i1 %cmp360.5, i1 true, i1 %cmp362.5, !dbg !94
  %cmp365.not.5 = icmp sgt i32 %sub358.5, %0
  %or.cond774.5 = select i1 %or.cond729.not816.5, i1 true, i1 %cmp365.not.5, !dbg !94
  br i1 %or.cond774.5, label %if.else305.6, label %if.then366.5, !dbg !94

if.then366.5:                                     ; preds = %if.else305.5
  %acc_s.sroa.38.20.vec.extract = extractelement <4 x float> %28, i64 1, !dbg !95
  %mul369.5 = fmul contract float %acc_s.sroa.38.20.vec.extract, 0x3FB99999A0000000, !dbg !96
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul369.5, float 0x4024CB5EC0000000), !dbg !97
  %41 = tail call contract noundef float @llvm.exp.f32(float %40), !dbg !101
  br label %if.else305.6, !dbg !104

if.else305.6:                                     ; preds = %if.else305.5, %if.then366.5
  %condval_5.0.5 = phi float [ %41, %if.then366.5 ], [ 0.000000e+00, %if.else305.5 ], !dbg !54
  %sub316.6 = add i32 %29, %mul27.1, !dbg !107
  %add336.6 = or disjoint i32 %mul310, 2, !dbg !110
  %sub337.6 = add i32 %add336.6, %mul27.1, !dbg !108
  %add357.6 = or disjoint i32 %mul310, 2, !dbg !111
  %sub358.6 = add i32 %add357.6, %mul27.1, !dbg !109
  %cmp360.6 = icmp slt i32 %sub316.6, 0, !dbg !93
  %cmp362.6 = icmp sgt i32 %sub337.6, 255
  %or.cond729.not816.6 = select i1 %cmp360.6, i1 true, i1 %cmp362.6, !dbg !94
  %cmp365.not.6 = icmp sgt i32 %sub358.6, %0
  %or.cond774.6 = select i1 %or.cond729.not816.6, i1 true, i1 %cmp365.not.6, !dbg !94
  br i1 %or.cond774.6, label %if.else305.7, label %if.then366.6, !dbg !94

if.then366.6:                                     ; preds = %if.else305.6
  %acc_s.sroa.38.24.vec.extract = extractelement <4 x float> %28, i64 2, !dbg !95
  %mul369.6 = fmul contract float %acc_s.sroa.38.24.vec.extract, 0x3FB99999A0000000, !dbg !96
  %42 = tail call contract noundef float @llvm.minnum.f32(float %mul369.6, float 0x4024CB5EC0000000), !dbg !97
  %43 = tail call contract noundef float @llvm.exp.f32(float %42), !dbg !101
  br label %if.else305.7, !dbg !104

if.else305.7:                                     ; preds = %if.else305.6, %if.then366.6
  %condval_5.0.6 = phi float [ %43, %if.then366.6 ], [ 0.000000e+00, %if.else305.6 ], !dbg !54
  %sub316.7 = add i32 %29, %mul27.1, !dbg !107
  %add336.7 = or i32 %29, 3, !dbg !110
  %sub337.7 = add i32 %add336.7, %mul27.1, !dbg !108
  %add357.7 = or i32 %29, 3, !dbg !111
  %sub358.7 = add i32 %add357.7, %mul27.1, !dbg !109
  %cmp360.7 = icmp slt i32 %sub316.7, 0, !dbg !93
  %cmp362.7 = icmp sgt i32 %sub337.7, 255
  %or.cond729.not816.7 = or i1 %cmp360.7, %cmp362.7, !dbg !94
  %cmp365.not.7 = icmp sgt i32 %sub358.7, %0
  %or.cond774.7 = select i1 %or.cond729.not816.7, i1 true, i1 %cmp365.not.7, !dbg !94
  br i1 %or.cond774.7, label %if.end373.7, label %if.then366.7, !dbg !94

if.then366.7:                                     ; preds = %if.else305.7
  %acc_s.sroa.38.28.vec.extract = extractelement <4 x float> %28, i64 3, !dbg !95
  %mul369.7 = fmul contract float %acc_s.sroa.38.28.vec.extract, 0x3FB99999A0000000, !dbg !96
  %44 = tail call contract noundef float @llvm.minnum.f32(float %mul369.7, float 0x4024CB5EC0000000), !dbg !97
  %45 = tail call contract noundef float @llvm.exp.f32(float %44), !dbg !101
  br label %if.end373.7, !dbg !104

if.end373.7:                                      ; preds = %if.then366.7, %if.else305.7
  %condval_5.0.7 = phi float [ %45, %if.then366.7 ], [ 0.000000e+00, %if.else305.7 ], !dbg !54
  %add393.1 = fadd contract float %condval_5.0, %condval_5.0.1, !dbg !112
  %add393.2 = fadd contract float %add393.1, %condval_5.0.2, !dbg !112
  %add393.3 = fadd contract float %add393.2, %condval_5.0.3, !dbg !112
  %add393.1830 = fadd contract float %add393.3, %condval_5.0.4, !dbg !112
  %add393.1.1 = fadd contract float %add393.1830, %condval_5.0.5, !dbg !112
  %add393.2.1 = fadd contract float %add393.1.1, %condval_5.0.6, !dbg !112
  %add393.3.1 = fadd contract float %add393.2.1, %condval_5.0.7, !dbg !112
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add393.3.1, <4 x float> zeroinitializer), !dbg !113
  %short_sum_out.sroa.0.0.vec.extract = extractelement <4 x float> %46, i64 0, !dbg !114
  %cmp414 = fcmp contract ogt float %short_sum_out.sroa.0.0.vec.extract, 0.000000e+00, !dbg !115
  %cmp.i.i = fcmp contract olt float %short_sum_out.sroa.0.0.vec.extract, 0x39B0000000000000
  %cond.i.i = select contract i1 %cmp.i.i, float 0x4630000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %short_sum_out.sroa.0.0.vec.extract, %cond.i.i
  %47 = tail call contract float @llvm.mxc.rsq.f32(float %mul.i.i)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x4310000000000000, float 1.000000e+00
  %mul3.i.i = fmul contract float %cond2.i.i, %47
  %mul420 = fmul contract float %mul3.i.i, %mul3.i.i
  %condval_9.0 = select i1 %cmp414, float %mul420, float 0.000000e+00, !dbg !116
  %mul431 = fmul contract float %condval_9.0, %condval_5.0, !dbg !117
  %mul431.1 = fmul contract float %condval_9.0, %condval_5.0.1, !dbg !117
  %mul431.2 = fmul contract float %condval_9.0, %condval_5.0.2, !dbg !117
  %mul431.3 = fmul contract float %condval_9.0, %condval_5.0.3, !dbg !117
  %mul431.4 = fmul contract float %condval_9.0, %condval_5.0.4, !dbg !117
  %mul431.5 = fmul contract float %condval_9.0, %condval_5.0.5, !dbg !117
  %mul431.6 = fmul contract float %condval_9.0, %condval_5.0.6, !dbg !117
  %mul431.7 = fmul contract float %condval_9.0, %condval_5.0.7, !dbg !117
  %48 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul431), !dbg !118
  %49 = insertelement <4 x i16> poison, i16 %48, i64 0, !dbg !127
  %50 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul431.1), !dbg !118
  %51 = insertelement <4 x i16> %49, i16 %50, i64 1, !dbg !127
  %52 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul431.2), !dbg !118
  %53 = insertelement <4 x i16> %51, i16 %52, i64 2, !dbg !127
  %54 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul431.3), !dbg !118
  %55 = insertelement <4 x i16> %53, i16 %54, i64 3, !dbg !127
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %55 to <4 x half>, !dbg !127
  %56 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul431.4), !dbg !118
  %57 = insertelement <4 x i16> poison, i16 %56, i64 0, !dbg !127
  %58 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul431.5), !dbg !118
  %59 = insertelement <4 x i16> %57, i16 %58, i64 1, !dbg !127
  %60 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul431.6), !dbg !118
  %61 = insertelement <4 x i16> %59, i16 %60, i64 2, !dbg !127
  %62 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul431.7), !dbg !118
  %63 = insertelement <4 x i16> %61, i16 %62, i64 3, !dbg !127
  %acc_s_cast.sroa.7.14.vec.insert = bitcast <4 x i16> %63 to <4 x half>, !dbg !127
  fence syncscope("warp") release, !dbg !128
  tail call void @llvm.mxc.barrier.warp(), !dbg !131
  fence syncscope("warp") acquire, !dbg !132
  %mul475 = and i32 %add.ptr289.idx, 16128
  %and482 = and i32 %1, 15
  %add483 = or disjoint i32 %mul475, %and482, !dbg !133
  %arrayidx485 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483, !dbg !134
  %64 = load half, ptr addrspace(3) %arrayidx485, align 2, !dbg !135, !tbaa !136
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %64, i64 0, !dbg !135
  %add478.1 = or disjoint i32 %mul475, %and482, !dbg !133
  %add483.1 = or disjoint i32 %add478.1, 64, !dbg !133
  %arrayidx485.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.1, !dbg !134
  %65 = load half, ptr addrspace(3) %arrayidx485.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %65, i64 1, !dbg !135
  %add478.2 = or disjoint i32 %mul475, %and482, !dbg !133
  %add483.2 = or disjoint i32 %add478.2, 128, !dbg !133
  %arrayidx485.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.2, !dbg !134
  %66 = load half, ptr addrspace(3) %arrayidx485.2, align 2, !dbg !135, !tbaa !136
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %66, i64 2, !dbg !135
  %add478.3 = or disjoint i32 %mul475, %and482, !dbg !133
  %add483.3 = or disjoint i32 %add478.3, 192, !dbg !133
  %arrayidx485.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.3, !dbg !134
  %67 = load half, ptr addrspace(3) %arrayidx485.3, align 2, !dbg !135, !tbaa !136
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %67, i64 3, !dbg !135
  %add480.1833 = or disjoint i32 %mul475, %and482, !dbg !133
  %add483.1834 = or disjoint i32 %add480.1833, 16, !dbg !133
  %arrayidx485.1835 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.1834, !dbg !134
  %68 = load half, ptr addrspace(3) %arrayidx485.1835, align 2, !dbg !135, !tbaa !136
  %vb.sroa.12.8.vec.insert = insertelement <4 x half> poison, half %68, i64 0, !dbg !135
  %add480.1.1 = or disjoint i32 %mul475, %and482, !dbg !133
  %add483.1.1 = or disjoint i32 %add480.1.1, 80, !dbg !133
  %arrayidx485.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.1.1, !dbg !134
  %69 = load half, ptr addrspace(3) %arrayidx485.1.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.12.10.vec.insert = insertelement <4 x half> %vb.sroa.12.8.vec.insert, half %69, i64 1, !dbg !135
  %add480.2.1 = or disjoint i32 %mul475, %and482, !dbg !133
  %add483.2.1 = or disjoint i32 %add480.2.1, 144, !dbg !133
  %arrayidx485.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.2.1, !dbg !134
  %70 = load half, ptr addrspace(3) %arrayidx485.2.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.12.12.vec.insert = insertelement <4 x half> %vb.sroa.12.10.vec.insert, half %70, i64 2, !dbg !135
  %add480.3.1 = or disjoint i32 %mul475, %and482, !dbg !133
  %add483.3.1 = or disjoint i32 %add480.3.1, 208, !dbg !133
  %arrayidx485.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.3.1, !dbg !134
  %71 = load half, ptr addrspace(3) %arrayidx485.3.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.12.14.vec.insert = insertelement <4 x half> %vb.sroa.12.12.vec.insert, half %71, i64 3, !dbg !135
  %add480.2837 = or disjoint i32 %mul475, %and482, !dbg !133
  %add483.2838 = or disjoint i32 %add480.2837, 32, !dbg !133
  %arrayidx485.2839 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.2838, !dbg !134
  %72 = load half, ptr addrspace(3) %arrayidx485.2839, align 2, !dbg !135, !tbaa !136
  %vb.sroa.22.16.vec.insert = insertelement <4 x half> poison, half %72, i64 0, !dbg !135
  %add480.1.2 = or disjoint i32 %mul475, %and482, !dbg !133
  %add483.1.2 = or disjoint i32 %add480.1.2, 96, !dbg !133
  %arrayidx485.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.1.2, !dbg !134
  %73 = load half, ptr addrspace(3) %arrayidx485.1.2, align 2, !dbg !135, !tbaa !136
  %vb.sroa.22.18.vec.insert = insertelement <4 x half> %vb.sroa.22.16.vec.insert, half %73, i64 1, !dbg !135
  %add480.2.2 = or disjoint i32 %mul475, %and482, !dbg !133
  %add483.2.2 = or disjoint i32 %add480.2.2, 160, !dbg !133
  %arrayidx485.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.2.2, !dbg !134
  %74 = load half, ptr addrspace(3) %arrayidx485.2.2, align 2, !dbg !135, !tbaa !136
  %vb.sroa.22.20.vec.insert = insertelement <4 x half> %vb.sroa.22.18.vec.insert, half %74, i64 2, !dbg !135
  %add480.3.2 = or disjoint i32 %mul475, %and482, !dbg !133
  %add483.3.2 = or disjoint i32 %add480.3.2, 224, !dbg !133
  %arrayidx485.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.3.2, !dbg !134
  %75 = load half, ptr addrspace(3) %arrayidx485.3.2, align 2, !dbg !135, !tbaa !136
  %vb.sroa.22.22.vec.insert = insertelement <4 x half> %vb.sroa.22.20.vec.insert, half %75, i64 3, !dbg !135
  %add480.3841 = or disjoint i32 %mul475, %and482, !dbg !133
  %add483.3842 = or disjoint i32 %add480.3841, 48, !dbg !133
  %arrayidx485.3843 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.3842, !dbg !134
  %76 = load half, ptr addrspace(3) %arrayidx485.3843, align 2, !dbg !135, !tbaa !136
  %vb.sroa.32.24.vec.insert = insertelement <4 x half> poison, half %76, i64 0, !dbg !135
  %add480.1.3 = or disjoint i32 %mul475, %and482, !dbg !133
  %add483.1.3 = or disjoint i32 %add480.1.3, 112, !dbg !133
  %arrayidx485.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.1.3, !dbg !134
  %77 = load half, ptr addrspace(3) %arrayidx485.1.3, align 2, !dbg !135, !tbaa !136
  %vb.sroa.32.26.vec.insert = insertelement <4 x half> %vb.sroa.32.24.vec.insert, half %77, i64 1, !dbg !135
  %add480.2.3 = or disjoint i32 %mul475, %and482, !dbg !133
  %add483.2.3 = or disjoint i32 %add480.2.3, 176, !dbg !133
  %arrayidx485.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.2.3, !dbg !134
  %78 = load half, ptr addrspace(3) %arrayidx485.2.3, align 2, !dbg !135, !tbaa !136
  %vb.sroa.32.28.vec.insert = insertelement <4 x half> %vb.sroa.32.26.vec.insert, half %78, i64 2, !dbg !135
  %add480.3.3 = or disjoint i32 %add.ptr289.idx, %and482, !dbg !133
  %add483.3.3 = or i32 %add480.3.3, 240, !dbg !133
  %arrayidx485.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.3.3, !dbg !134
  %79 = load half, ptr addrspace(3) %arrayidx485.3.3, align 2, !dbg !135, !tbaa !136
  %vb.sroa.32.30.vec.insert = insertelement <4 x half> %vb.sroa.32.28.vec.insert, half %79, i64 3, !dbg !135
  %80 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !137
  %81 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !137
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !137
  %83 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !137
  %add476.1 = add nuw nsw i32 %mul475, 1024
  %add483.1845 = or disjoint i32 %add476.1, %and482, !dbg !133
  %arrayidx485.1846 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.1845, !dbg !134
  %84 = load half, ptr addrspace(3) %arrayidx485.1846, align 2, !dbg !135, !tbaa !136
  %vb.sroa.0.0.vec.insert872 = insertelement <4 x half> poison, half %84, i64 0, !dbg !135
  %add478.1.1847 = add nuw nsw i32 %mul475, 1088, !dbg !138
  %add483.1.1848 = or disjoint i32 %add478.1.1847, %and482, !dbg !133
  %arrayidx485.1.1849 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.1.1848, !dbg !134
  %85 = load half, ptr addrspace(3) %arrayidx485.1.1849, align 2, !dbg !135, !tbaa !136
  %vb.sroa.0.2.vec.insert874 = insertelement <4 x half> %vb.sroa.0.0.vec.insert872, half %85, i64 1, !dbg !135
  %add478.2.1851 = add nuw nsw i32 %mul475, 1152, !dbg !138
  %add483.2.1852 = or disjoint i32 %add478.2.1851, %and482, !dbg !133
  %arrayidx485.2.1853 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.2.1852, !dbg !134
  %86 = load half, ptr addrspace(3) %arrayidx485.2.1853, align 2, !dbg !135, !tbaa !136
  %vb.sroa.0.4.vec.insert876 = insertelement <4 x half> %vb.sroa.0.2.vec.insert874, half %86, i64 2, !dbg !135
  %add478.3.1855 = add nuw nsw i32 %mul475, 1216, !dbg !138
  %add483.3.1856 = or disjoint i32 %add478.3.1855, %and482, !dbg !133
  %arrayidx485.3.1857 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.3.1856, !dbg !134
  %87 = load half, ptr addrspace(3) %arrayidx485.3.1857, align 2, !dbg !135, !tbaa !136
  %vb.sroa.0.6.vec.insert878 = insertelement <4 x half> %vb.sroa.0.4.vec.insert876, half %87, i64 3, !dbg !135
  %add480.1833.1 = add nuw nsw i32 %mul475, 1040, !dbg !139
  %add483.1834.1 = or disjoint i32 %add480.1833.1, %and482, !dbg !133
  %arrayidx485.1835.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.1834.1, !dbg !134
  %88 = load half, ptr addrspace(3) %arrayidx485.1835.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.12.8.vec.insert882 = insertelement <4 x half> poison, half %88, i64 0, !dbg !135
  %add480.1.1.1 = add nuw nsw i32 %mul475, 1104, !dbg !139
  %add483.1.1.1 = or disjoint i32 %add480.1.1.1, %and482, !dbg !133
  %arrayidx485.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.1.1.1, !dbg !134
  %89 = load half, ptr addrspace(3) %arrayidx485.1.1.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.12.10.vec.insert884 = insertelement <4 x half> %vb.sroa.12.8.vec.insert882, half %89, i64 1, !dbg !135
  %add480.2.1.1 = add nuw nsw i32 %mul475, 1168, !dbg !139
  %add483.2.1.1 = or disjoint i32 %add480.2.1.1, %and482, !dbg !133
  %arrayidx485.2.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.2.1.1, !dbg !134
  %90 = load half, ptr addrspace(3) %arrayidx485.2.1.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.12.12.vec.insert886 = insertelement <4 x half> %vb.sroa.12.10.vec.insert884, half %90, i64 2, !dbg !135
  %add480.3.1.1 = add nuw nsw i32 %mul475, 1232, !dbg !139
  %add483.3.1.1 = or disjoint i32 %add480.3.1.1, %and482, !dbg !133
  %arrayidx485.3.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.3.1.1, !dbg !134
  %91 = load half, ptr addrspace(3) %arrayidx485.3.1.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.12.14.vec.insert888 = insertelement <4 x half> %vb.sroa.12.12.vec.insert886, half %91, i64 3, !dbg !135
  %add480.2837.1 = add nuw nsw i32 %mul475, 1056, !dbg !139
  %add483.2838.1 = or disjoint i32 %add480.2837.1, %and482, !dbg !133
  %arrayidx485.2839.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.2838.1, !dbg !134
  %92 = load half, ptr addrspace(3) %arrayidx485.2839.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.22.16.vec.insert892 = insertelement <4 x half> poison, half %92, i64 0, !dbg !135
  %add480.1.2.1 = add nuw nsw i32 %mul475, 1120, !dbg !139
  %add483.1.2.1 = or disjoint i32 %add480.1.2.1, %and482, !dbg !133
  %arrayidx485.1.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.1.2.1, !dbg !134
  %93 = load half, ptr addrspace(3) %arrayidx485.1.2.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.22.18.vec.insert894 = insertelement <4 x half> %vb.sroa.22.16.vec.insert892, half %93, i64 1, !dbg !135
  %add480.2.2.1 = add nuw nsw i32 %mul475, 1184, !dbg !139
  %add483.2.2.1 = or disjoint i32 %add480.2.2.1, %and482, !dbg !133
  %arrayidx485.2.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.2.2.1, !dbg !134
  %94 = load half, ptr addrspace(3) %arrayidx485.2.2.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.22.20.vec.insert896 = insertelement <4 x half> %vb.sroa.22.18.vec.insert894, half %94, i64 2, !dbg !135
  %add480.3.2.1 = add nuw nsw i32 %mul475, 1248, !dbg !139
  %add483.3.2.1 = or disjoint i32 %add480.3.2.1, %and482, !dbg !133
  %arrayidx485.3.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.3.2.1, !dbg !134
  %95 = load half, ptr addrspace(3) %arrayidx485.3.2.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.22.22.vec.insert898 = insertelement <4 x half> %vb.sroa.22.20.vec.insert896, half %95, i64 3, !dbg !135
  %add480.3841.1 = add nuw nsw i32 %mul475, 1072, !dbg !139
  %add483.3842.1 = or disjoint i32 %add480.3841.1, %and482, !dbg !133
  %arrayidx485.3843.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.3842.1, !dbg !134
  %96 = load half, ptr addrspace(3) %arrayidx485.3843.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.32.24.vec.insert902 = insertelement <4 x half> poison, half %96, i64 0, !dbg !135
  %add480.1.3.1 = add nuw nsw i32 %mul475, 1136, !dbg !139
  %add483.1.3.1 = or disjoint i32 %add480.1.3.1, %and482, !dbg !133
  %arrayidx485.1.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.1.3.1, !dbg !134
  %97 = load half, ptr addrspace(3) %arrayidx485.1.3.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.32.26.vec.insert904 = insertelement <4 x half> %vb.sroa.32.24.vec.insert902, half %97, i64 1, !dbg !135
  %add480.2.3.1 = add nuw nsw i32 %mul475, 1200, !dbg !139
  %add483.2.3.1 = or disjoint i32 %add480.2.3.1, %and482, !dbg !133
  %arrayidx485.2.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.2.3.1, !dbg !134
  %98 = load half, ptr addrspace(3) %arrayidx485.2.3.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.32.28.vec.insert906 = insertelement <4 x half> %vb.sroa.32.26.vec.insert904, half %98, i64 2, !dbg !135
  %add480.3.3.1 = add nuw nsw i32 %mul475, 1264, !dbg !139
  %add483.3.3.1 = or disjoint i32 %add480.3.3.1, %and482, !dbg !133
  %arrayidx485.3.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add483.3.3.1, !dbg !134
  %99 = load half, ptr addrspace(3) %arrayidx485.3.3.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.32.30.vec.insert908 = insertelement <4 x half> %vb.sroa.32.28.vec.insert906, half %99, i64 3, !dbg !135
  %100 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert878, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %80), !dbg !137
  %101 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.14.vec.insert888, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %81), !dbg !137
  %102 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.22.vec.insert898, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %82), !dbg !137
  %103 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.30.vec.insert908, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %83), !dbg !137
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %100, i64 0, !dbg !140
  %104 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract), !dbg !141
  %O_cast.sroa.0.0.insert.ext = zext i16 %104 to i64, !dbg !145
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %100, i64 1, !dbg !140
  %105 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract), !dbg !141
  %O_cast.sroa.0.2.insert.ext = zext i16 %105 to i64, !dbg !145
  %O_cast.sroa.0.2.insert.shift = shl nuw nsw i64 %O_cast.sroa.0.2.insert.ext, 16, !dbg !145
  %O_cast.sroa.0.2.insert.insert = or disjoint i64 %O_cast.sroa.0.2.insert.shift, %O_cast.sroa.0.0.insert.ext, !dbg !145
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %100, i64 2, !dbg !140
  %106 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract), !dbg !141
  %O_cast.sroa.0.4.insert.ext = zext i16 %106 to i64, !dbg !145
  %O_cast.sroa.0.4.insert.shift = shl nuw nsw i64 %O_cast.sroa.0.4.insert.ext, 32, !dbg !145
  %O_cast.sroa.0.4.insert.insert = or disjoint i64 %O_cast.sroa.0.2.insert.insert, %O_cast.sroa.0.4.insert.shift, !dbg !145
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %100, i64 3, !dbg !140
  %107 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract), !dbg !141
  %O_cast.sroa.0.6.insert.ext = zext i16 %107 to i64, !dbg !145
  %O_cast.sroa.0.6.insert.shift = shl nuw i64 %O_cast.sroa.0.6.insert.ext, 48, !dbg !145
  %O_cast.sroa.0.6.insert.insert = or disjoint i64 %O_cast.sroa.0.4.insert.insert, %O_cast.sroa.0.6.insert.shift, !dbg !145
  %acc_o.sroa.14.16.vec.extract = extractelement <4 x float> %101, i64 0, !dbg !140
  %108 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.16.vec.extract), !dbg !141
  %O_cast.sroa.7.8.insert.ext = zext i16 %108 to i64, !dbg !145
  %acc_o.sroa.14.20.vec.extract = extractelement <4 x float> %101, i64 1, !dbg !140
  %109 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.20.vec.extract), !dbg !141
  %O_cast.sroa.7.10.insert.ext = zext i16 %109 to i64, !dbg !145
  %O_cast.sroa.7.10.insert.shift = shl nuw nsw i64 %O_cast.sroa.7.10.insert.ext, 16, !dbg !145
  %O_cast.sroa.7.10.insert.insert = or disjoint i64 %O_cast.sroa.7.10.insert.shift, %O_cast.sroa.7.8.insert.ext, !dbg !145
  %acc_o.sroa.14.24.vec.extract = extractelement <4 x float> %101, i64 2, !dbg !140
  %110 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.24.vec.extract), !dbg !141
  %O_cast.sroa.7.12.insert.ext = zext i16 %110 to i64, !dbg !145
  %O_cast.sroa.7.12.insert.shift = shl nuw nsw i64 %O_cast.sroa.7.12.insert.ext, 32, !dbg !145
  %O_cast.sroa.7.12.insert.insert = or disjoint i64 %O_cast.sroa.7.10.insert.insert, %O_cast.sroa.7.12.insert.shift, !dbg !145
  %acc_o.sroa.14.28.vec.extract = extractelement <4 x float> %101, i64 3, !dbg !140
  %111 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.28.vec.extract), !dbg !141
  %O_cast.sroa.7.14.insert.ext = zext i16 %111 to i64, !dbg !145
  %O_cast.sroa.7.14.insert.shift = shl nuw i64 %O_cast.sroa.7.14.insert.ext, 48, !dbg !145
  %O_cast.sroa.7.14.insert.insert = or disjoint i64 %O_cast.sroa.7.12.insert.insert, %O_cast.sroa.7.14.insert.shift, !dbg !145
  %acc_o.sroa.26.32.vec.extract = extractelement <4 x float> %102, i64 0, !dbg !140
  %112 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.32.vec.extract), !dbg !141
  %O_cast.sroa.12.16.insert.ext = zext i16 %112 to i64, !dbg !145
  %acc_o.sroa.26.36.vec.extract = extractelement <4 x float> %102, i64 1, !dbg !140
  %113 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.36.vec.extract), !dbg !141
  %O_cast.sroa.12.18.insert.ext = zext i16 %113 to i64, !dbg !145
  %O_cast.sroa.12.18.insert.shift = shl nuw nsw i64 %O_cast.sroa.12.18.insert.ext, 16, !dbg !145
  %O_cast.sroa.12.18.insert.insert = or disjoint i64 %O_cast.sroa.12.18.insert.shift, %O_cast.sroa.12.16.insert.ext, !dbg !145
  %acc_o.sroa.26.40.vec.extract = extractelement <4 x float> %102, i64 2, !dbg !140
  %114 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.40.vec.extract), !dbg !141
  %O_cast.sroa.12.20.insert.ext = zext i16 %114 to i64, !dbg !145
  %O_cast.sroa.12.20.insert.shift = shl nuw nsw i64 %O_cast.sroa.12.20.insert.ext, 32, !dbg !145
  %O_cast.sroa.12.20.insert.insert = or disjoint i64 %O_cast.sroa.12.18.insert.insert, %O_cast.sroa.12.20.insert.shift, !dbg !145
  %acc_o.sroa.26.44.vec.extract = extractelement <4 x float> %102, i64 3, !dbg !140
  %115 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.44.vec.extract), !dbg !141
  %O_cast.sroa.12.22.insert.ext = zext i16 %115 to i64, !dbg !145
  %O_cast.sroa.12.22.insert.shift = shl nuw i64 %O_cast.sroa.12.22.insert.ext, 48, !dbg !145
  %O_cast.sroa.12.22.insert.insert = or disjoint i64 %O_cast.sroa.12.20.insert.insert, %O_cast.sroa.12.22.insert.shift, !dbg !145
  %acc_o.sroa.38.48.vec.extract = extractelement <4 x float> %103, i64 0, !dbg !140
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.48.vec.extract), !dbg !141
  %O_cast.sroa.17.24.insert.ext = zext i16 %116 to i64, !dbg !145
  %acc_o.sroa.38.52.vec.extract = extractelement <4 x float> %103, i64 1, !dbg !140
  %117 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.52.vec.extract), !dbg !141
  %O_cast.sroa.17.26.insert.ext = zext i16 %117 to i64, !dbg !145
  %O_cast.sroa.17.26.insert.shift = shl nuw nsw i64 %O_cast.sroa.17.26.insert.ext, 16, !dbg !145
  %O_cast.sroa.17.26.insert.insert = or disjoint i64 %O_cast.sroa.17.26.insert.shift, %O_cast.sroa.17.24.insert.ext, !dbg !145
  %acc_o.sroa.38.56.vec.extract = extractelement <4 x float> %103, i64 2, !dbg !140
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.56.vec.extract), !dbg !141
  %O_cast.sroa.17.28.insert.ext = zext i16 %118 to i64, !dbg !145
  %O_cast.sroa.17.28.insert.shift = shl nuw nsw i64 %O_cast.sroa.17.28.insert.ext, 32, !dbg !145
  %O_cast.sroa.17.28.insert.insert = or disjoint i64 %O_cast.sroa.17.26.insert.insert, %O_cast.sroa.17.28.insert.shift, !dbg !145
  %acc_o.sroa.38.60.vec.extract = extractelement <4 x float> %103, i64 3, !dbg !140
  %119 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.60.vec.extract), !dbg !141
  %O_cast.sroa.17.30.insert.ext = zext i16 %119 to i64, !dbg !145
  %O_cast.sroa.17.30.insert.shift = shl nuw i64 %O_cast.sroa.17.30.insert.ext, 48, !dbg !145
  %O_cast.sroa.17.30.insert.insert = or disjoint i64 %O_cast.sroa.17.28.insert.insert, %O_cast.sroa.17.30.insert.shift, !dbg !145
  fence syncscope("warp") release, !dbg !146
  tail call void @llvm.mxc.barrier.warp(), !dbg !149
  fence syncscope("warp") acquire, !dbg !150
  %shr554 = lshr i32 %1, 5
  %mul564 = and i32 %29, 4
  %xor558 = xor i32 %shr554, %and230, !dbg !151
  %mul559 = shl nuw nsw i32 %xor558, 3, !dbg !152
  %add560 = add nuw nsw i32 %mul559, %mul7, !dbg !153
  %add565 = or disjoint i32 %add560, %mul564, !dbg !154
  %add.ptr567 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add565, !dbg !155
  store i64 %O_cast.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr567, align 8, !dbg !156
  %add555.1 = add nuw nsw i32 %shr554, 2, !dbg !157
  %xor558.1 = xor i32 %add555.1, %and230, !dbg !151
  %mul559.1 = shl nuw nsw i32 %xor558.1, 3, !dbg !152
  %add560.1 = add nuw nsw i32 %mul559.1, %mul7, !dbg !153
  %add565.1 = or disjoint i32 %add560.1, %mul564, !dbg !154
  %add.ptr567.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add565.1, !dbg !155
  store i64 %O_cast.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr567.1, align 8, !dbg !156
  %add555.2 = add nuw nsw i32 %shr554, 4, !dbg !157
  %xor558.2 = xor i32 %add555.2, %and230, !dbg !151
  %mul559.2 = shl nuw nsw i32 %xor558.2, 3, !dbg !152
  %add560.2 = add nuw nsw i32 %mul559.2, %mul7, !dbg !153
  %add565.2 = or disjoint i32 %add560.2, %mul564, !dbg !154
  %add.ptr567.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add565.2, !dbg !155
  store i64 %O_cast.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr567.2, align 8, !dbg !156
  %add555.3 = add nuw nsw i32 %shr554, 6, !dbg !157
  %xor558.3 = xor i32 %add555.3, %and230, !dbg !151
  %mul559.3 = shl nuw nsw i32 %xor558.3, 3, !dbg !152
  %add560.3 = add nuw nsw i32 %mul559.3, %mul7, !dbg !153
  %add565.3 = or disjoint i32 %add560.3, %mul564, !dbg !154
  %add.ptr567.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add565.3, !dbg !155
  store i64 %O_cast.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr567.3, align 8, !dbg !156
  fence syncscope("warp") release, !dbg !158
  tail call void @llvm.mxc.barrier.warp(), !dbg !161
  fence syncscope("warp") acquire, !dbg !162
  %add592 = add nuw nsw i32 %11, %mul
  %120 = zext nneg i32 %add592 to i64, !dbg !163
  %add.ptr597 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %120, !dbg !164
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr597, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep780, i64 16, i1 false), !dbg !165, !tbaa.struct !166, !call_argsrelate !167
  %121 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %120, !dbg !164
  %add.ptr597.1 = getelementptr inbounds i8, ptr addrspace(1) %121, i64 1024, !dbg !164
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr597.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep781.1, i64 16, i1 false), !dbg !165, !tbaa.struct !166, !call_argsrelate !167
  ret void, !dbg !168
}

; Function Attrs: convergent nounwind willreturn memory(none)
declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float, float, <4 x float>) #4

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.x() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.y() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.z() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.thread.id.x() #5

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare i16 @llvm.convert.to.fp16.f32(float) #6

; Function Attrs: convergent nounwind willreturn
declare void @llvm.mxc.barrier.warp() #7

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp.f32(float) #8

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i1 @llvm.mxc.is.private(ptr nocapture) #5

; Function Attrs: nounwind willreturn
declare void @llvm.mxc.sleep(i32 immarg) #9

; Function Attrs: nounwind speculatable willreturn memory(none)
declare float @llvm.mxc.rsq.f32(float) #5

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.minnum.f32(float, float) #8

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #10

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #7 = { convergent nounwind willreturn }
attributes #8 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #9 = { nounwind willreturn }
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmpx4ex0ceb/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpx4ex0ceb/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 27, column: 3, scope: !40)
!44 = !DILocation(line: 28, column: 46, scope: !40)
!45 = !DILocation(line: 28, column: 32, scope: !40)
!46 = !DILocation(line: 31, column: 3, scope: !40)
!47 = !DILocation(line: 32, column: 22, scope: !40)
!48 = !DILocation(line: 39, column: 27, scope: !40)
!49 = !DILocation(line: 32, column: 60, scope: !40)
!50 = !DILocation(line: 50, column: 60, scope: !40)
!51 = !DILocation(line: 57, column: 22, scope: !40)
!52 = !DILocation(line: 58, column: 17, scope: !40)
!53 = !DILocation(line: 59, column: 5, scope: !40)
!54 = !DILocation(line: 0, scope: !40)
!55 = !DILocation(line: 50, column: 31, scope: !40)
!56 = !DILocation(line: 52, column: 74, scope: !40)
!57 = !DILocation(line: 52, column: 61, scope: !40)
!58 = !DILocation(line: 68, column: 60, scope: !40)
!59 = !DILocation(line: 75, column: 22, scope: !40)
!60 = !DILocation(line: 76, column: 17, scope: !40)
!61 = !DILocation(line: 77, column: 5, scope: !40)
!62 = !DILocation(line: 68, column: 31, scope: !40)
!63 = !DILocation(line: 70, column: 74, scope: !40)
!64 = !DILocation(line: 70, column: 61, scope: !40)
!65 = !DILocation(line: 83, column: 3, scope: !40)
!66 = !DILocation(line: 84, column: 157, scope: !40)
!67 = !DILocation(line: 84, column: 40, scope: !40)
!68 = !DILocation(line: 68, column: 3, scope: !69, inlinedAt: !71)
!69 = distinct !DISubprogram(name: "__barrier_warp", scope: !70, file: !70, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!70 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!71 = distinct !DILocation(line: 192, column: 3, scope: !72, inlinedAt: !73)
!72 = distinct !DISubprogram(name: "__syncwarp", scope: !70, file: !70, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!73 = distinct !DILocation(line: 91, column: 3, scope: !40)
!74 = !DILocation(line: 69, column: 3, scope: !69, inlinedAt: !71)
!75 = !DILocation(line: 70, column: 3, scope: !69, inlinedAt: !71)
!76 = !DILocation(line: 93, column: 5, scope: !40)
!77 = !DILocation(line: 94, column: 68, scope: !40)
!78 = !DILocation(line: 94, column: 31, scope: !40)
!79 = !DILocation(line: 94, column: 83, scope: !40)
!80 = !DILocation(line: 99, column: 38, scope: !40)
!81 = !{i32 -1, i32 3, i32 -1}
!82 = !DILocation(line: 68, column: 3, scope: !69, inlinedAt: !83)
!83 = distinct !DILocation(line: 192, column: 3, scope: !72, inlinedAt: !84)
!84 = distinct !DILocation(line: 106, column: 3, scope: !40)
!85 = !DILocation(line: 69, column: 3, scope: !69, inlinedAt: !83)
!86 = !DILocation(line: 70, column: 3, scope: !69, inlinedAt: !83)
!87 = !DILocation(line: 108, column: 8, scope: !40)
!88 = !DILocation(line: 109, column: 84, scope: !40)
!89 = !DILocation(line: 109, column: 40, scope: !40)
!90 = !DILocation(line: 115, column: 66, scope: !40)
!91 = !DILocation(line: 121, column: 66, scope: !40)
!92 = !DILocation(line: 127, column: 66, scope: !40)
!93 = !DILocation(line: 132, column: 14, scope: !40)
!94 = !DILocation(line: 132, column: 28, scope: !40)
!95 = !DILocation(line: 133, column: 29, scope: !40)
!96 = !DILocation(line: 133, column: 40, scope: !40)
!97 = !DILocation(line: 354, column: 10, scope: !98, inlinedAt: !100)
!98 = distinct !DISubprogram(name: "min", scope: !99, file: !99, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!99 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!100 = distinct !DILocation(line: 133, column: 24, scope: !40)
!101 = !DILocation(line: 288, column: 10, scope: !102, inlinedAt: !103)
!102 = distinct !DISubprogram(name: "expf", scope: !99, file: !99, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!103 = distinct !DILocation(line: 133, column: 19, scope: !40)
!104 = !DILocation(line: 134, column: 5, scope: !40)
!105 = !DILocation(line: 121, column: 53, scope: !40)
!106 = !DILocation(line: 127, column: 53, scope: !40)
!107 = !DILocation(line: 117, column: 102, scope: !40)
!108 = !DILocation(line: 123, column: 102, scope: !40)
!109 = !DILocation(line: 129, column: 102, scope: !40)
!110 = !DILocation(line: 123, column: 89, scope: !40)
!111 = !DILocation(line: 129, column: 89, scope: !40)
!112 = !DILocation(line: 144, column: 34, scope: !40)
!113 = !DILocation(line: 150, column: 44, scope: !40)
!114 = !DILocation(line: 155, column: 34, scope: !40)
!115 = !DILocation(line: 155, column: 32, scope: !40)
!116 = !DILocation(line: 155, column: 7, scope: !40)
!117 = !DILocation(line: 163, column: 30, scope: !40)
!118 = !DILocation(line: 75, column: 10, scope: !119, inlinedAt: !121)
!119 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !120, file: !120, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!120 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!121 = distinct !DILocation(line: 984, column: 9, scope: !122, inlinedAt: !124)
!122 = distinct !DISubprogram(name: "__float2half", scope: !123, file: !123, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!123 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!124 = distinct !DILocation(line: 133, column: 53, scope: !125, inlinedAt: !126)
!125 = distinct !DISubprogram(name: "__half", scope: !123, file: !123, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!126 = distinct !DILocation(line: 169, column: 53, scope: !40)
!127 = !DILocation(line: 169, column: 50, scope: !40)
!128 = !DILocation(line: 68, column: 3, scope: !69, inlinedAt: !129)
!129 = distinct !DILocation(line: 192, column: 3, scope: !72, inlinedAt: !130)
!130 = distinct !DILocation(line: 172, column: 3, scope: !40)
!131 = !DILocation(line: 69, column: 3, scope: !69, inlinedAt: !129)
!132 = !DILocation(line: 70, column: 3, scope: !69, inlinedAt: !129)
!133 = !DILocation(line: 176, column: 137, scope: !40)
!134 = !DILocation(line: 176, column: 31, scope: !40)
!135 = !DILocation(line: 176, column: 29, scope: !40)
!136 = !{!26, !26, i64 0}
!137 = !DILocation(line: 181, column: 38, scope: !40)
!138 = !DILocation(line: 176, column: 111, scope: !40)
!139 = !DILocation(line: 176, column: 123, scope: !40)
!140 = !DILocation(line: 191, column: 61, scope: !40)
!141 = !DILocation(line: 75, column: 10, scope: !119, inlinedAt: !142)
!142 = distinct !DILocation(line: 984, column: 9, scope: !122, inlinedAt: !143)
!143 = distinct !DILocation(line: 133, column: 53, scope: !125, inlinedAt: !144)
!144 = distinct !DILocation(line: 191, column: 53, scope: !40)
!145 = !DILocation(line: 191, column: 50, scope: !40)
!146 = !DILocation(line: 68, column: 3, scope: !69, inlinedAt: !147)
!147 = distinct !DILocation(line: 192, column: 3, scope: !72, inlinedAt: !148)
!148 = distinct !DILocation(line: 194, column: 3, scope: !40)
!149 = !DILocation(line: 69, column: 3, scope: !69, inlinedAt: !147)
!150 = !DILocation(line: 70, column: 3, scope: !69, inlinedAt: !147)
!151 = !DILocation(line: 197, column: 121, scope: !40)
!152 = !DILocation(line: 197, column: 149, scope: !40)
!153 = !DILocation(line: 197, column: 77, scope: !40)
!154 = !DILocation(line: 197, column: 155, scope: !40)
!155 = !DILocation(line: 197, column: 40, scope: !40)
!156 = !DILocation(line: 197, column: 198, scope: !40)
!157 = !DILocation(line: 197, column: 92, scope: !40)
!158 = !DILocation(line: 68, column: 3, scope: !69, inlinedAt: !159)
!159 = distinct !DILocation(line: 192, column: 3, scope: !72, inlinedAt: !160)
!160 = distinct !DILocation(line: 199, column: 3, scope: !40)
!161 = !DILocation(line: 69, column: 3, scope: !69, inlinedAt: !159)
!162 = !DILocation(line: 70, column: 3, scope: !69, inlinedAt: !159)
!163 = !DILocation(line: 201, column: 3, scope: !40)
!164 = !DILocation(line: 202, column: 22, scope: !40)
!165 = !DILocation(line: 202, column: 98, scope: !40)
!166 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!167 = !{i32 2, i32 -1, i32 -1, i32 -1}
!168 = !DILocation(line: 204, column: 1, scope: !40)
