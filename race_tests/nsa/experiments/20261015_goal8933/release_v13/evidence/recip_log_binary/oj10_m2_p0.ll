; ModuleID = 'experiments/20261015_goal8933/recip_log_binary/oj10_m2_p0.bc'
source_filename = "/tmp/tmpwwdbwk89/tvm_kernels.maca"
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
  %add76760 = or disjoint i32 %13, %12
  %add76 = zext nneg i32 %add76760 to i64
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
  %add76760.1 = or disjoint i32 %14, %12
  %add76.1 = zext nneg i32 %add76760.1 to i64
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
  %add76760.2 = or disjoint i32 %15, %12
  %add76.2 = zext nneg i32 %add76760.2 to i64
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
  %add76760.3 = or disjoint i32 %16, %12
  %add76.3 = zext nneg i32 %add76760.3 to i64
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
  %or.cond685 = icmp ult i32 %add119, 256, !dbg !59
  br i1 %or.cond685, label %if.then132, label %if.then113.1, !dbg !59

if.then132:                                       ; preds = %if.then113
  %17 = shl nuw nsw i32 %add119, 6
  %add139761 = or disjoint i32 %17, %12
  %add139 = zext nneg i32 %add139761 to i64
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
  %or.cond685.1 = icmp ult i32 %add119.1, 256, !dbg !59
  br i1 %or.cond685.1, label %if.then132.1, label %if.else120.2, !dbg !59

if.then132.1:                                     ; preds = %if.then113.1
  %18 = shl nuw nsw i32 %add119.1, 6
  %add139761.1 = or disjoint i32 %18, %12
  %add139.1 = zext nneg i32 %add139761.1 to i64
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
  %or.cond685.2 = icmp ult i32 %sub127.2, 256, !dbg !59
  br i1 %or.cond685.2, label %if.then132.2, label %if.else120.3, !dbg !59

if.then132.2:                                     ; preds = %if.else120.2
  %19 = shl nuw nsw i32 %sub127.2, 6
  %add139761.2 = or disjoint i32 %19, %12
  %add139.2 = zext nneg i32 %add139761.2 to i64
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
  %or.cond685.3 = icmp ult i32 %sub127.3, 256, !dbg !59
  br i1 %or.cond685.3, label %if.then132.3, label %if.end164.3, !dbg !59

if.then132.3:                                     ; preds = %if.else120.3
  %20 = shl nuw nsw i32 %sub127.3, 6
  %add139761.3 = or disjoint i32 %20, %12
  %add139.3 = zext nneg i32 %add139761.3 to i64
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
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @V_shared, i32 %mul184, !dbg !65
  %invariant.gep732 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul190, !dbg !65
  store i32 %condval_2.sroa.0.0, ptr addrspace(3) %invariant.gep732, align 16, !dbg !66, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep732.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep732, i32 4, !dbg !66
  store i32 %condval_2.sroa.5.0, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep732.sroa_idx, align 4, !dbg !66, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep732.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep732, i32 8, !dbg !66
  store i32 %condval_2.sroa.6.0, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep732.sroa_idx, align 8, !dbg !66, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep732.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep732, i32 12, !dbg !66
  store i32 %condval_2.sroa.7.0, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep732.sroa_idx, align 4, !dbg !66, !tbaa !30
  %gep733.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep732, i32 1024, !dbg !67
  store i32 %condval_2.sroa.0.0.1, ptr addrspace(3) %gep733.1, align 16, !dbg !66, !tbaa !30
  %K_reg.sroa.9.16.gep733.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep732, i32 1028, !dbg !66
  store i32 %condval_2.sroa.5.0.1, ptr addrspace(3) %K_reg.sroa.9.16.gep733.1.sroa_idx, align 4, !dbg !66, !tbaa !30
  %K_reg.sroa.10.16.gep733.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep732, i32 1032, !dbg !66
  store i32 %condval_2.sroa.6.0.1, ptr addrspace(3) %K_reg.sroa.10.16.gep733.1.sroa_idx, align 8, !dbg !66, !tbaa !30
  %K_reg.sroa.11.16.gep733.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep732, i32 1036, !dbg !66
  store i32 %condval_2.sroa.7.0.1, ptr addrspace(3) %K_reg.sroa.11.16.gep733.1.sroa_idx, align 4, !dbg !66, !tbaa !30
  %gep733.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep732, i32 2048, !dbg !67
  store i32 %condval_2.sroa.0.0.2, ptr addrspace(3) %gep733.2, align 16, !dbg !66, !tbaa !30
  %K_reg.sroa.14.32.gep733.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep732, i32 2052, !dbg !66
  store i32 %condval_2.sroa.5.0.2, ptr addrspace(3) %K_reg.sroa.14.32.gep733.2.sroa_idx, align 4, !dbg !66, !tbaa !30
  %K_reg.sroa.15.32.gep733.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep732, i32 2056, !dbg !66
  store i32 %condval_2.sroa.6.0.2, ptr addrspace(3) %K_reg.sroa.15.32.gep733.2.sroa_idx, align 8, !dbg !66, !tbaa !30
  %K_reg.sroa.16.32.gep733.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep732, i32 2060, !dbg !66
  store i32 %condval_2.sroa.7.0.2, ptr addrspace(3) %K_reg.sroa.16.32.gep733.2.sroa_idx, align 4, !dbg !66, !tbaa !30
  %gep733.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep732, i32 3072, !dbg !67
  store i32 %condval_2.sroa.0.0.3, ptr addrspace(3) %gep733.3, align 16, !dbg !66, !tbaa !30
  %K_reg.sroa.19.48.gep733.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep732, i32 3076, !dbg !66
  store i32 %condval_2.sroa.5.0.3, ptr addrspace(3) %K_reg.sroa.19.48.gep733.3.sroa_idx, align 4, !dbg !66, !tbaa !30
  %K_reg.sroa.20.48.gep733.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep732, i32 3080, !dbg !66
  store i32 %condval_2.sroa.6.0.3, ptr addrspace(3) %K_reg.sroa.20.48.gep733.3.sroa_idx, align 8, !dbg !66, !tbaa !30
  %K_reg.sroa.21.48.gep733.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep732, i32 3084, !dbg !66
  store i32 %condval_2.sroa.7.0.3, ptr addrspace(3) %K_reg.sroa.21.48.gep733.3.sroa_idx, align 4, !dbg !66, !tbaa !30
  fence syncscope("block") release, !dbg !68
  tail call void @llvm.mxc.barrier(), !dbg !74
  fence syncscope("block") acquire, !dbg !75
  %shr227 = lshr i32 %1, 4
  %and230 = and i32 %1, 7
  %xor231 = xor i32 %shr227, %and230
  %add.ptr235.idx = shl nuw nsw i32 %xor231, 4
  %invariant.gep736 = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr235.idx, !dbg !76
  %gep = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep736, i32 %mul7, !dbg !77
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %gep, align 16, !dbg !78
  %kb.sroa.6.0.gep.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep, i32 8, !dbg !78
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.gep.sroa_idx, align 8, !dbg !78
  %add224.1 = or disjoint i32 %mul7, 1024, !dbg !79
  %gep.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep736, i32 %add224.1, !dbg !77
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
  %invariant.gep736.1 = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr235.idx.1, !dbg !76
  %gep.1771 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep736.1, i32 %mul7, !dbg !77
  %kb.sroa.0.0.copyload860 = load <4 x half>, ptr addrspace(3) %gep.1771, align 16, !dbg !78
  %kb.sroa.6.0.gep.1771.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep.1771, i32 8, !dbg !78
  %kb.sroa.6.0.copyload861 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.gep.1771.sroa_idx, align 8, !dbg !78
  %gep.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep736.1, i32 %add224.1, !dbg !77
  %kb.sroa.8.16.copyload864 = load <4 x half>, ptr addrspace(3) %gep.1.1, align 16, !dbg !78
  %kb.sroa.12.16.gep.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep.1.1, i32 8, !dbg !78
  %kb.sroa.12.16.copyload865 = load <4 x half>, ptr addrspace(3) %kb.sroa.12.16.gep.1.1.sroa_idx, align 8, !dbg !78
  %25 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload860, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %23), !dbg !80, !call_argsrelate !81
  %26 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.8.16.copyload864, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %24), !dbg !80, !call_argsrelate !81
  %27 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload861, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %25), !dbg !80, !call_argsrelate !81
  %28 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.12.16.copyload865, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %26), !dbg !80, !call_argsrelate !81
  fence syncscope("block") release, !dbg !82
  tail call void @llvm.mxc.barrier(), !dbg !85
  fence syncscope("block") acquire, !dbg !86
  %add.ptr289.idx = shl nuw nsw i32 %1, 4
  %invariant.gep741 = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr289.idx, !dbg !87
  store i32 %condval_4.sroa.0.0, ptr addrspace(3) %invariant.gep741, align 16, !dbg !88, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep741.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 4, !dbg !88
  store i32 %condval_4.sroa.5.0, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep741.sroa_idx, align 4, !dbg !88, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep741.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 8, !dbg !88
  store i32 %condval_4.sroa.6.0, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep741.sroa_idx, align 8, !dbg !88, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep741.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 12, !dbg !88
  store i32 %condval_4.sroa.7.0, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep741.sroa_idx, align 4, !dbg !88, !tbaa !30
  %gep742.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 1024, !dbg !89
  store i32 %condval_4.sroa.0.0.1, ptr addrspace(3) %gep742.1, align 16, !dbg !88, !tbaa !30
  %V_reg.sroa.9.16.gep742.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 1028, !dbg !88
  store i32 %condval_4.sroa.5.0.1, ptr addrspace(3) %V_reg.sroa.9.16.gep742.1.sroa_idx, align 4, !dbg !88, !tbaa !30
  %V_reg.sroa.10.16.gep742.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 1032, !dbg !88
  store i32 %condval_4.sroa.6.0.1, ptr addrspace(3) %V_reg.sroa.10.16.gep742.1.sroa_idx, align 8, !dbg !88, !tbaa !30
  %V_reg.sroa.11.16.gep742.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 1036, !dbg !88
  store i32 %condval_4.sroa.7.0.1, ptr addrspace(3) %V_reg.sroa.11.16.gep742.1.sroa_idx, align 4, !dbg !88, !tbaa !30
  %gep742.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 2048, !dbg !89
  store i32 %condval_4.sroa.0.0.2, ptr addrspace(3) %gep742.2, align 16, !dbg !88, !tbaa !30
  %V_reg.sroa.14.32.gep742.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 2052, !dbg !88
  store i32 %condval_4.sroa.5.0.2, ptr addrspace(3) %V_reg.sroa.14.32.gep742.2.sroa_idx, align 4, !dbg !88, !tbaa !30
  %V_reg.sroa.15.32.gep742.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 2056, !dbg !88
  store i32 %condval_4.sroa.6.0.2, ptr addrspace(3) %V_reg.sroa.15.32.gep742.2.sroa_idx, align 8, !dbg !88, !tbaa !30
  %V_reg.sroa.16.32.gep742.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 2060, !dbg !88
  store i32 %condval_4.sroa.7.0.2, ptr addrspace(3) %V_reg.sroa.16.32.gep742.2.sroa_idx, align 4, !dbg !88, !tbaa !30
  %gep742.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 3072, !dbg !89
  store i32 %condval_4.sroa.0.0.3, ptr addrspace(3) %gep742.3, align 16, !dbg !88, !tbaa !30
  %V_reg.sroa.19.48.gep742.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 3076, !dbg !88
  store i32 %condval_4.sroa.5.0.3, ptr addrspace(3) %V_reg.sroa.19.48.gep742.3.sroa_idx, align 4, !dbg !88, !tbaa !30
  %V_reg.sroa.20.48.gep742.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 3080, !dbg !88
  store i32 %condval_4.sroa.6.0.3, ptr addrspace(3) %V_reg.sroa.20.48.gep742.3.sroa_idx, align 8, !dbg !88, !tbaa !30
  %V_reg.sroa.21.48.gep742.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 3084, !dbg !88
  store i32 %condval_4.sroa.7.0.3, ptr addrspace(3) %V_reg.sroa.21.48.gep742.3.sroa_idx, align 4, !dbg !88, !tbaa !30
  %29 = lshr i32 %1, 2
  %mul310 = and i32 %29, 252
  %add304 = add i32 %29, %mul27, !dbg !90
  %add325 = add i32 %mul310, %mul27, !dbg !91
  %add346 = add i32 %mul310, %mul27, !dbg !92
  %cmp360 = icmp slt i32 %add304, 0, !dbg !93
  %cmp362 = icmp sgt i32 %add325, 255
  %or.cond686.not763 = or i1 %cmp360, %cmp362, !dbg !94
  %cmp365.not = icmp sgt i32 %add346, %0
  %or.cond726 = or i1 %or.cond686.not763, %cmp365.not, !dbg !94
  br i1 %or.cond726, label %if.then298.1, label %if.then366, !dbg !94

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
  %or.cond686.not763.1 = select i1 %cmp360.1, i1 true, i1 %cmp362.1, !dbg !94
  %cmp365.not.1 = icmp sgt i32 %add346.1, %0
  %or.cond726.1 = select i1 %or.cond686.not763.1, i1 true, i1 %cmp365.not.1, !dbg !94
  br i1 %or.cond726.1, label %if.then298.2, label %if.then366.1, !dbg !94

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
  %or.cond686.not763.2 = select i1 %cmp360.2, i1 true, i1 %cmp362.2, !dbg !94
  %cmp365.not.2 = icmp sgt i32 %add346.2, %0
  %or.cond726.2 = select i1 %or.cond686.not763.2, i1 true, i1 %cmp365.not.2, !dbg !94
  br i1 %or.cond726.2, label %if.then298.3, label %if.then366.2, !dbg !94

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
  %or.cond686.not763.3 = or i1 %cmp360.3, %cmp362.3, !dbg !94
  %cmp365.not.3 = icmp sgt i32 %add346.3, %0
  %or.cond726.3 = or i1 %or.cond686.not763.3, %cmp365.not.3, !dbg !94
  br i1 %or.cond726.3, label %if.else305.4, label %if.then366.3, !dbg !94

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
  %or.cond686.not763.4 = or i1 %cmp360.4, %cmp362.4, !dbg !94
  %cmp365.not.4 = icmp sgt i32 %sub358.4, %0
  %or.cond726.4 = select i1 %or.cond686.not763.4, i1 true, i1 %cmp365.not.4, !dbg !94
  br i1 %or.cond726.4, label %if.else305.5, label %if.then366.4, !dbg !94

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
  %or.cond686.not763.5 = select i1 %cmp360.5, i1 true, i1 %cmp362.5, !dbg !94
  %cmp365.not.5 = icmp sgt i32 %sub358.5, %0
  %or.cond726.5 = select i1 %or.cond686.not763.5, i1 true, i1 %cmp365.not.5, !dbg !94
  br i1 %or.cond726.5, label %if.else305.6, label %if.then366.5, !dbg !94

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
  %or.cond686.not763.6 = select i1 %cmp360.6, i1 true, i1 %cmp362.6, !dbg !94
  %cmp365.not.6 = icmp sgt i32 %sub358.6, %0
  %or.cond726.6 = select i1 %or.cond686.not763.6, i1 true, i1 %cmp365.not.6, !dbg !94
  br i1 %or.cond726.6, label %if.else305.7, label %if.then366.6, !dbg !94

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
  %or.cond686.not763.7 = or i1 %cmp360.7, %cmp362.7, !dbg !94
  %cmp365.not.7 = icmp sgt i32 %sub358.7, %0
  %or.cond726.7 = select i1 %or.cond686.not763.7, i1 true, i1 %cmp365.not.7, !dbg !94
  br i1 %or.cond726.7, label %if.end373.7, label %if.then366.7, !dbg !94

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
  %add393.1777 = fadd contract float %add393.3, %condval_5.0.4, !dbg !112
  %add393.1.1 = fadd contract float %add393.1777, %condval_5.0.5, !dbg !112
  %add393.2.1 = fadd contract float %add393.1.1, %condval_5.0.6, !dbg !112
  %add393.3.1 = fadd contract float %add393.2.1, %condval_5.0.7, !dbg !112
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add393.3.1, <4 x float> zeroinitializer), !dbg !113
  %short_sum_out.sroa.0.0.vec.extract = extractelement <4 x float> %46, i64 0, !dbg !114
  %cmp414 = fcmp contract ogt float %short_sum_out.sroa.0.0.vec.extract, 0.000000e+00, !dbg !115
  %47 = tail call contract noundef float @llvm.log.f32(float %short_sum_out.sroa.0.0.vec.extract)
  %mul418 = fneg contract float %47
  %48 = tail call contract noundef float @llvm.exp.f32(float %mul418)
  %condval_9.0 = select i1 %cmp414, float %48, float 0.000000e+00, !dbg !116
  %mul430 = fmul contract float %condval_9.0, %condval_5.0, !dbg !117
  %mul430.1 = fmul contract float %condval_9.0, %condval_5.0.1, !dbg !117
  %mul430.2 = fmul contract float %condval_9.0, %condval_5.0.2, !dbg !117
  %mul430.3 = fmul contract float %condval_9.0, %condval_5.0.3, !dbg !117
  %mul430.4 = fmul contract float %condval_9.0, %condval_5.0.4, !dbg !117
  %mul430.5 = fmul contract float %condval_9.0, %condval_5.0.5, !dbg !117
  %mul430.6 = fmul contract float %condval_9.0, %condval_5.0.6, !dbg !117
  %mul430.7 = fmul contract float %condval_9.0, %condval_5.0.7, !dbg !117
  %49 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul430), !dbg !118
  %50 = insertelement <4 x i16> poison, i16 %49, i64 0, !dbg !127
  %51 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul430.1), !dbg !118
  %52 = insertelement <4 x i16> %50, i16 %51, i64 1, !dbg !127
  %53 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul430.2), !dbg !118
  %54 = insertelement <4 x i16> %52, i16 %53, i64 2, !dbg !127
  %55 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul430.3), !dbg !118
  %56 = insertelement <4 x i16> %54, i16 %55, i64 3, !dbg !127
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %56 to <4 x half>, !dbg !127
  %57 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul430.4), !dbg !118
  %58 = insertelement <4 x i16> poison, i16 %57, i64 0, !dbg !127
  %59 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul430.5), !dbg !118
  %60 = insertelement <4 x i16> %58, i16 %59, i64 1, !dbg !127
  %61 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul430.6), !dbg !118
  %62 = insertelement <4 x i16> %60, i16 %61, i64 2, !dbg !127
  %63 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul430.7), !dbg !118
  %64 = insertelement <4 x i16> %62, i16 %63, i64 3, !dbg !127
  %acc_s_cast.sroa.7.14.vec.insert = bitcast <4 x i16> %64 to <4 x half>, !dbg !127
  fence syncscope("block") release, !dbg !128
  tail call void @llvm.mxc.barrier(), !dbg !131
  fence syncscope("block") acquire, !dbg !132
  %mul474 = and i32 %add.ptr289.idx, 16128
  %and481 = and i32 %1, 15
  %add482 = or disjoint i32 %mul474, %and481, !dbg !133
  %arrayidx484 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482, !dbg !134
  %65 = load half, ptr addrspace(3) %arrayidx484, align 2, !dbg !135, !tbaa !136
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %65, i64 0, !dbg !135
  %add477.1 = or disjoint i32 %mul474, %and481, !dbg !133
  %add482.1 = or disjoint i32 %add477.1, 64, !dbg !133
  %arrayidx484.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.1, !dbg !134
  %66 = load half, ptr addrspace(3) %arrayidx484.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %66, i64 1, !dbg !135
  %add477.2 = or disjoint i32 %mul474, %and481, !dbg !133
  %add482.2 = or disjoint i32 %add477.2, 128, !dbg !133
  %arrayidx484.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.2, !dbg !134
  %67 = load half, ptr addrspace(3) %arrayidx484.2, align 2, !dbg !135, !tbaa !136
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %67, i64 2, !dbg !135
  %add477.3 = or disjoint i32 %mul474, %and481, !dbg !133
  %add482.3 = or disjoint i32 %add477.3, 192, !dbg !133
  %arrayidx484.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.3, !dbg !134
  %68 = load half, ptr addrspace(3) %arrayidx484.3, align 2, !dbg !135, !tbaa !136
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %68, i64 3, !dbg !135
  %add479.1780 = or disjoint i32 %mul474, %and481, !dbg !133
  %add482.1781 = or disjoint i32 %add479.1780, 16, !dbg !133
  %arrayidx484.1782 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.1781, !dbg !134
  %69 = load half, ptr addrspace(3) %arrayidx484.1782, align 2, !dbg !135, !tbaa !136
  %vb.sroa.12.8.vec.insert = insertelement <4 x half> poison, half %69, i64 0, !dbg !135
  %add479.1.1 = or disjoint i32 %mul474, %and481, !dbg !133
  %add482.1.1 = or disjoint i32 %add479.1.1, 80, !dbg !133
  %arrayidx484.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.1.1, !dbg !134
  %70 = load half, ptr addrspace(3) %arrayidx484.1.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.12.10.vec.insert = insertelement <4 x half> %vb.sroa.12.8.vec.insert, half %70, i64 1, !dbg !135
  %add479.2.1 = or disjoint i32 %mul474, %and481, !dbg !133
  %add482.2.1 = or disjoint i32 %add479.2.1, 144, !dbg !133
  %arrayidx484.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.2.1, !dbg !134
  %71 = load half, ptr addrspace(3) %arrayidx484.2.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.12.12.vec.insert = insertelement <4 x half> %vb.sroa.12.10.vec.insert, half %71, i64 2, !dbg !135
  %add479.3.1 = or disjoint i32 %mul474, %and481, !dbg !133
  %add482.3.1 = or disjoint i32 %add479.3.1, 208, !dbg !133
  %arrayidx484.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.3.1, !dbg !134
  %72 = load half, ptr addrspace(3) %arrayidx484.3.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.12.14.vec.insert = insertelement <4 x half> %vb.sroa.12.12.vec.insert, half %72, i64 3, !dbg !135
  %add479.2784 = or disjoint i32 %mul474, %and481, !dbg !133
  %add482.2785 = or disjoint i32 %add479.2784, 32, !dbg !133
  %arrayidx484.2786 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.2785, !dbg !134
  %73 = load half, ptr addrspace(3) %arrayidx484.2786, align 2, !dbg !135, !tbaa !136
  %vb.sroa.22.16.vec.insert = insertelement <4 x half> poison, half %73, i64 0, !dbg !135
  %add479.1.2 = or disjoint i32 %mul474, %and481, !dbg !133
  %add482.1.2 = or disjoint i32 %add479.1.2, 96, !dbg !133
  %arrayidx484.1.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.1.2, !dbg !134
  %74 = load half, ptr addrspace(3) %arrayidx484.1.2, align 2, !dbg !135, !tbaa !136
  %vb.sroa.22.18.vec.insert = insertelement <4 x half> %vb.sroa.22.16.vec.insert, half %74, i64 1, !dbg !135
  %add479.2.2 = or disjoint i32 %mul474, %and481, !dbg !133
  %add482.2.2 = or disjoint i32 %add479.2.2, 160, !dbg !133
  %arrayidx484.2.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.2.2, !dbg !134
  %75 = load half, ptr addrspace(3) %arrayidx484.2.2, align 2, !dbg !135, !tbaa !136
  %vb.sroa.22.20.vec.insert = insertelement <4 x half> %vb.sroa.22.18.vec.insert, half %75, i64 2, !dbg !135
  %add479.3.2 = or disjoint i32 %mul474, %and481, !dbg !133
  %add482.3.2 = or disjoint i32 %add479.3.2, 224, !dbg !133
  %arrayidx484.3.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.3.2, !dbg !134
  %76 = load half, ptr addrspace(3) %arrayidx484.3.2, align 2, !dbg !135, !tbaa !136
  %vb.sroa.22.22.vec.insert = insertelement <4 x half> %vb.sroa.22.20.vec.insert, half %76, i64 3, !dbg !135
  %add479.3788 = or disjoint i32 %mul474, %and481, !dbg !133
  %add482.3789 = or disjoint i32 %add479.3788, 48, !dbg !133
  %arrayidx484.3790 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.3789, !dbg !134
  %77 = load half, ptr addrspace(3) %arrayidx484.3790, align 2, !dbg !135, !tbaa !136
  %vb.sroa.32.24.vec.insert = insertelement <4 x half> poison, half %77, i64 0, !dbg !135
  %add479.1.3 = or disjoint i32 %mul474, %and481, !dbg !133
  %add482.1.3 = or disjoint i32 %add479.1.3, 112, !dbg !133
  %arrayidx484.1.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.1.3, !dbg !134
  %78 = load half, ptr addrspace(3) %arrayidx484.1.3, align 2, !dbg !135, !tbaa !136
  %vb.sroa.32.26.vec.insert = insertelement <4 x half> %vb.sroa.32.24.vec.insert, half %78, i64 1, !dbg !135
  %add479.2.3 = or disjoint i32 %mul474, %and481, !dbg !133
  %add482.2.3 = or disjoint i32 %add479.2.3, 176, !dbg !133
  %arrayidx484.2.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.2.3, !dbg !134
  %79 = load half, ptr addrspace(3) %arrayidx484.2.3, align 2, !dbg !135, !tbaa !136
  %vb.sroa.32.28.vec.insert = insertelement <4 x half> %vb.sroa.32.26.vec.insert, half %79, i64 2, !dbg !135
  %add479.3.3 = or disjoint i32 %add.ptr289.idx, %and481, !dbg !133
  %add482.3.3 = or i32 %add479.3.3, 240, !dbg !133
  %arrayidx484.3.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.3.3, !dbg !134
  %80 = load half, ptr addrspace(3) %arrayidx484.3.3, align 2, !dbg !135, !tbaa !136
  %vb.sroa.32.30.vec.insert = insertelement <4 x half> %vb.sroa.32.28.vec.insert, half %80, i64 3, !dbg !135
  %81 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !137
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !137
  %83 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !137
  %84 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !137
  %add475.1 = add nuw nsw i32 %mul474, 1024
  %add482.1792 = or disjoint i32 %add475.1, %and481, !dbg !133
  %arrayidx484.1793 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.1792, !dbg !134
  %85 = load half, ptr addrspace(3) %arrayidx484.1793, align 2, !dbg !135, !tbaa !136
  %vb.sroa.0.0.vec.insert820 = insertelement <4 x half> poison, half %85, i64 0, !dbg !135
  %add477.1.1794 = add nuw nsw i32 %mul474, 1088, !dbg !138
  %add482.1.1795 = or disjoint i32 %add477.1.1794, %and481, !dbg !133
  %arrayidx484.1.1796 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.1.1795, !dbg !134
  %86 = load half, ptr addrspace(3) %arrayidx484.1.1796, align 2, !dbg !135, !tbaa !136
  %vb.sroa.0.2.vec.insert822 = insertelement <4 x half> %vb.sroa.0.0.vec.insert820, half %86, i64 1, !dbg !135
  %add477.2.1798 = add nuw nsw i32 %mul474, 1152, !dbg !138
  %add482.2.1799 = or disjoint i32 %add477.2.1798, %and481, !dbg !133
  %arrayidx484.2.1800 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.2.1799, !dbg !134
  %87 = load half, ptr addrspace(3) %arrayidx484.2.1800, align 2, !dbg !135, !tbaa !136
  %vb.sroa.0.4.vec.insert824 = insertelement <4 x half> %vb.sroa.0.2.vec.insert822, half %87, i64 2, !dbg !135
  %add477.3.1802 = add nuw nsw i32 %mul474, 1216, !dbg !138
  %add482.3.1803 = or disjoint i32 %add477.3.1802, %and481, !dbg !133
  %arrayidx484.3.1804 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.3.1803, !dbg !134
  %88 = load half, ptr addrspace(3) %arrayidx484.3.1804, align 2, !dbg !135, !tbaa !136
  %vb.sroa.0.6.vec.insert826 = insertelement <4 x half> %vb.sroa.0.4.vec.insert824, half %88, i64 3, !dbg !135
  %add479.1780.1 = add nuw nsw i32 %mul474, 1040, !dbg !139
  %add482.1781.1 = or disjoint i32 %add479.1780.1, %and481, !dbg !133
  %arrayidx484.1782.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.1781.1, !dbg !134
  %89 = load half, ptr addrspace(3) %arrayidx484.1782.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.12.8.vec.insert830 = insertelement <4 x half> poison, half %89, i64 0, !dbg !135
  %add479.1.1.1 = add nuw nsw i32 %mul474, 1104, !dbg !139
  %add482.1.1.1 = or disjoint i32 %add479.1.1.1, %and481, !dbg !133
  %arrayidx484.1.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.1.1.1, !dbg !134
  %90 = load half, ptr addrspace(3) %arrayidx484.1.1.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.12.10.vec.insert832 = insertelement <4 x half> %vb.sroa.12.8.vec.insert830, half %90, i64 1, !dbg !135
  %add479.2.1.1 = add nuw nsw i32 %mul474, 1168, !dbg !139
  %add482.2.1.1 = or disjoint i32 %add479.2.1.1, %and481, !dbg !133
  %arrayidx484.2.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.2.1.1, !dbg !134
  %91 = load half, ptr addrspace(3) %arrayidx484.2.1.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.12.12.vec.insert834 = insertelement <4 x half> %vb.sroa.12.10.vec.insert832, half %91, i64 2, !dbg !135
  %add479.3.1.1 = add nuw nsw i32 %mul474, 1232, !dbg !139
  %add482.3.1.1 = or disjoint i32 %add479.3.1.1, %and481, !dbg !133
  %arrayidx484.3.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.3.1.1, !dbg !134
  %92 = load half, ptr addrspace(3) %arrayidx484.3.1.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.12.14.vec.insert836 = insertelement <4 x half> %vb.sroa.12.12.vec.insert834, half %92, i64 3, !dbg !135
  %add479.2784.1 = add nuw nsw i32 %mul474, 1056, !dbg !139
  %add482.2785.1 = or disjoint i32 %add479.2784.1, %and481, !dbg !133
  %arrayidx484.2786.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.2785.1, !dbg !134
  %93 = load half, ptr addrspace(3) %arrayidx484.2786.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.22.16.vec.insert840 = insertelement <4 x half> poison, half %93, i64 0, !dbg !135
  %add479.1.2.1 = add nuw nsw i32 %mul474, 1120, !dbg !139
  %add482.1.2.1 = or disjoint i32 %add479.1.2.1, %and481, !dbg !133
  %arrayidx484.1.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.1.2.1, !dbg !134
  %94 = load half, ptr addrspace(3) %arrayidx484.1.2.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.22.18.vec.insert842 = insertelement <4 x half> %vb.sroa.22.16.vec.insert840, half %94, i64 1, !dbg !135
  %add479.2.2.1 = add nuw nsw i32 %mul474, 1184, !dbg !139
  %add482.2.2.1 = or disjoint i32 %add479.2.2.1, %and481, !dbg !133
  %arrayidx484.2.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.2.2.1, !dbg !134
  %95 = load half, ptr addrspace(3) %arrayidx484.2.2.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.22.20.vec.insert844 = insertelement <4 x half> %vb.sroa.22.18.vec.insert842, half %95, i64 2, !dbg !135
  %add479.3.2.1 = add nuw nsw i32 %mul474, 1248, !dbg !139
  %add482.3.2.1 = or disjoint i32 %add479.3.2.1, %and481, !dbg !133
  %arrayidx484.3.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.3.2.1, !dbg !134
  %96 = load half, ptr addrspace(3) %arrayidx484.3.2.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.22.22.vec.insert846 = insertelement <4 x half> %vb.sroa.22.20.vec.insert844, half %96, i64 3, !dbg !135
  %add479.3788.1 = add nuw nsw i32 %mul474, 1072, !dbg !139
  %add482.3789.1 = or disjoint i32 %add479.3788.1, %and481, !dbg !133
  %arrayidx484.3790.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.3789.1, !dbg !134
  %97 = load half, ptr addrspace(3) %arrayidx484.3790.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.32.24.vec.insert850 = insertelement <4 x half> poison, half %97, i64 0, !dbg !135
  %add479.1.3.1 = add nuw nsw i32 %mul474, 1136, !dbg !139
  %add482.1.3.1 = or disjoint i32 %add479.1.3.1, %and481, !dbg !133
  %arrayidx484.1.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.1.3.1, !dbg !134
  %98 = load half, ptr addrspace(3) %arrayidx484.1.3.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.32.26.vec.insert852 = insertelement <4 x half> %vb.sroa.32.24.vec.insert850, half %98, i64 1, !dbg !135
  %add479.2.3.1 = add nuw nsw i32 %mul474, 1200, !dbg !139
  %add482.2.3.1 = or disjoint i32 %add479.2.3.1, %and481, !dbg !133
  %arrayidx484.2.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.2.3.1, !dbg !134
  %99 = load half, ptr addrspace(3) %arrayidx484.2.3.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.32.28.vec.insert854 = insertelement <4 x half> %vb.sroa.32.26.vec.insert852, half %99, i64 2, !dbg !135
  %add479.3.3.1 = add nuw nsw i32 %mul474, 1264, !dbg !139
  %add482.3.3.1 = or disjoint i32 %add479.3.3.1, %and481, !dbg !133
  %arrayidx484.3.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add482.3.3.1, !dbg !134
  %100 = load half, ptr addrspace(3) %arrayidx484.3.3.1, align 2, !dbg !135, !tbaa !136
  %vb.sroa.32.30.vec.insert856 = insertelement <4 x half> %vb.sroa.32.28.vec.insert854, half %100, i64 3, !dbg !135
  %101 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert826, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %81), !dbg !137
  %102 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.14.vec.insert836, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %82), !dbg !137
  %103 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.22.vec.insert846, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %83), !dbg !137
  %104 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.30.vec.insert856, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %84), !dbg !137
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %101, i64 0, !dbg !140
  %105 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract), !dbg !141
  %O_cast.sroa.0.0.insert.ext = zext i16 %105 to i64, !dbg !145
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %101, i64 1, !dbg !140
  %106 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract), !dbg !141
  %O_cast.sroa.0.2.insert.ext = zext i16 %106 to i64, !dbg !145
  %O_cast.sroa.0.2.insert.shift = shl nuw nsw i64 %O_cast.sroa.0.2.insert.ext, 16, !dbg !145
  %O_cast.sroa.0.2.insert.insert = or disjoint i64 %O_cast.sroa.0.2.insert.shift, %O_cast.sroa.0.0.insert.ext, !dbg !145
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %101, i64 2, !dbg !140
  %107 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract), !dbg !141
  %O_cast.sroa.0.4.insert.ext = zext i16 %107 to i64, !dbg !145
  %O_cast.sroa.0.4.insert.shift = shl nuw nsw i64 %O_cast.sroa.0.4.insert.ext, 32, !dbg !145
  %O_cast.sroa.0.4.insert.insert = or disjoint i64 %O_cast.sroa.0.2.insert.insert, %O_cast.sroa.0.4.insert.shift, !dbg !145
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %101, i64 3, !dbg !140
  %108 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract), !dbg !141
  %O_cast.sroa.0.6.insert.ext = zext i16 %108 to i64, !dbg !145
  %O_cast.sroa.0.6.insert.shift = shl nuw i64 %O_cast.sroa.0.6.insert.ext, 48, !dbg !145
  %O_cast.sroa.0.6.insert.insert = or disjoint i64 %O_cast.sroa.0.4.insert.insert, %O_cast.sroa.0.6.insert.shift, !dbg !145
  %acc_o.sroa.14.16.vec.extract = extractelement <4 x float> %102, i64 0, !dbg !140
  %109 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.16.vec.extract), !dbg !141
  %O_cast.sroa.7.8.insert.ext = zext i16 %109 to i64, !dbg !145
  %acc_o.sroa.14.20.vec.extract = extractelement <4 x float> %102, i64 1, !dbg !140
  %110 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.20.vec.extract), !dbg !141
  %O_cast.sroa.7.10.insert.ext = zext i16 %110 to i64, !dbg !145
  %O_cast.sroa.7.10.insert.shift = shl nuw nsw i64 %O_cast.sroa.7.10.insert.ext, 16, !dbg !145
  %O_cast.sroa.7.10.insert.insert = or disjoint i64 %O_cast.sroa.7.10.insert.shift, %O_cast.sroa.7.8.insert.ext, !dbg !145
  %acc_o.sroa.14.24.vec.extract = extractelement <4 x float> %102, i64 2, !dbg !140
  %111 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.24.vec.extract), !dbg !141
  %O_cast.sroa.7.12.insert.ext = zext i16 %111 to i64, !dbg !145
  %O_cast.sroa.7.12.insert.shift = shl nuw nsw i64 %O_cast.sroa.7.12.insert.ext, 32, !dbg !145
  %O_cast.sroa.7.12.insert.insert = or disjoint i64 %O_cast.sroa.7.10.insert.insert, %O_cast.sroa.7.12.insert.shift, !dbg !145
  %acc_o.sroa.14.28.vec.extract = extractelement <4 x float> %102, i64 3, !dbg !140
  %112 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.28.vec.extract), !dbg !141
  %O_cast.sroa.7.14.insert.ext = zext i16 %112 to i64, !dbg !145
  %O_cast.sroa.7.14.insert.shift = shl nuw i64 %O_cast.sroa.7.14.insert.ext, 48, !dbg !145
  %O_cast.sroa.7.14.insert.insert = or disjoint i64 %O_cast.sroa.7.12.insert.insert, %O_cast.sroa.7.14.insert.shift, !dbg !145
  %acc_o.sroa.26.32.vec.extract = extractelement <4 x float> %103, i64 0, !dbg !140
  %113 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.32.vec.extract), !dbg !141
  %O_cast.sroa.12.16.insert.ext = zext i16 %113 to i64, !dbg !145
  %acc_o.sroa.26.36.vec.extract = extractelement <4 x float> %103, i64 1, !dbg !140
  %114 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.36.vec.extract), !dbg !141
  %O_cast.sroa.12.18.insert.ext = zext i16 %114 to i64, !dbg !145
  %O_cast.sroa.12.18.insert.shift = shl nuw nsw i64 %O_cast.sroa.12.18.insert.ext, 16, !dbg !145
  %O_cast.sroa.12.18.insert.insert = or disjoint i64 %O_cast.sroa.12.18.insert.shift, %O_cast.sroa.12.16.insert.ext, !dbg !145
  %acc_o.sroa.26.40.vec.extract = extractelement <4 x float> %103, i64 2, !dbg !140
  %115 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.40.vec.extract), !dbg !141
  %O_cast.sroa.12.20.insert.ext = zext i16 %115 to i64, !dbg !145
  %O_cast.sroa.12.20.insert.shift = shl nuw nsw i64 %O_cast.sroa.12.20.insert.ext, 32, !dbg !145
  %O_cast.sroa.12.20.insert.insert = or disjoint i64 %O_cast.sroa.12.18.insert.insert, %O_cast.sroa.12.20.insert.shift, !dbg !145
  %acc_o.sroa.26.44.vec.extract = extractelement <4 x float> %103, i64 3, !dbg !140
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.44.vec.extract), !dbg !141
  %O_cast.sroa.12.22.insert.ext = zext i16 %116 to i64, !dbg !145
  %O_cast.sroa.12.22.insert.shift = shl nuw i64 %O_cast.sroa.12.22.insert.ext, 48, !dbg !145
  %O_cast.sroa.12.22.insert.insert = or disjoint i64 %O_cast.sroa.12.20.insert.insert, %O_cast.sroa.12.22.insert.shift, !dbg !145
  %acc_o.sroa.38.48.vec.extract = extractelement <4 x float> %104, i64 0, !dbg !140
  %117 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.48.vec.extract), !dbg !141
  %O_cast.sroa.17.24.insert.ext = zext i16 %117 to i64, !dbg !145
  %acc_o.sroa.38.52.vec.extract = extractelement <4 x float> %104, i64 1, !dbg !140
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.52.vec.extract), !dbg !141
  %O_cast.sroa.17.26.insert.ext = zext i16 %118 to i64, !dbg !145
  %O_cast.sroa.17.26.insert.shift = shl nuw nsw i64 %O_cast.sroa.17.26.insert.ext, 16, !dbg !145
  %O_cast.sroa.17.26.insert.insert = or disjoint i64 %O_cast.sroa.17.26.insert.shift, %O_cast.sroa.17.24.insert.ext, !dbg !145
  %acc_o.sroa.38.56.vec.extract = extractelement <4 x float> %104, i64 2, !dbg !140
  %119 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.56.vec.extract), !dbg !141
  %O_cast.sroa.17.28.insert.ext = zext i16 %119 to i64, !dbg !145
  %O_cast.sroa.17.28.insert.shift = shl nuw nsw i64 %O_cast.sroa.17.28.insert.ext, 32, !dbg !145
  %O_cast.sroa.17.28.insert.insert = or disjoint i64 %O_cast.sroa.17.26.insert.insert, %O_cast.sroa.17.28.insert.shift, !dbg !145
  %acc_o.sroa.38.60.vec.extract = extractelement <4 x float> %104, i64 3, !dbg !140
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.60.vec.extract), !dbg !141
  %O_cast.sroa.17.30.insert.ext = zext i16 %120 to i64, !dbg !145
  %O_cast.sroa.17.30.insert.shift = shl nuw i64 %O_cast.sroa.17.30.insert.ext, 48, !dbg !145
  %O_cast.sroa.17.30.insert.insert = or disjoint i64 %O_cast.sroa.17.28.insert.insert, %O_cast.sroa.17.30.insert.shift, !dbg !145
  %add555 = add nuw nsw i32 %add, %mul310
  %121 = zext nneg i32 %add555 to i64, !dbg !146
  %add.ptr561 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %121, !dbg !147
  store i64 %O_cast.sroa.0.6.insert.insert, ptr addrspace(1) %add.ptr561, align 8, !dbg !148
  %122 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %121, !dbg !147
  %add.ptr561.1 = getelementptr inbounds i8, ptr addrspace(1) %122, i64 32, !dbg !147
  store i64 %O_cast.sroa.7.14.insert.insert, ptr addrspace(1) %add.ptr561.1, align 8, !dbg !148
  %123 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %121, !dbg !147
  %add.ptr561.2 = getelementptr inbounds i8, ptr addrspace(1) %123, i64 64, !dbg !147
  store i64 %O_cast.sroa.12.22.insert.insert, ptr addrspace(1) %add.ptr561.2, align 8, !dbg !148
  %124 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %121, !dbg !147
  %add.ptr561.3 = getelementptr inbounds i8, ptr addrspace(1) %124, i64 96, !dbg !147
  store i64 %O_cast.sroa.17.30.insert.insert, ptr addrspace(1) %add.ptr561.3, align 8, !dbg !148
  ret void, !dbg !149
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
declare void @llvm.mxc.barrier() #7

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp.f32(float) #8

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.log.f32(float) #8

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i1 @llvm.mxc.is.private(ptr nocapture) #5

; Function Attrs: nounwind willreturn
declare void @llvm.mxc.sleep(i32 immarg) #9

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.minnum.f32(float, float) #8

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

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmpwwdbwk89/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpwwdbwk89/tvm_kernels.maca", directory: "")
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
!66 = !DILocation(line: 84, column: 141, scope: !40)
!67 = !DILocation(line: 84, column: 24, scope: !40)
!68 = !DILocation(line: 60, column: 3, scope: !69, inlinedAt: !71)
!69 = distinct !DISubprogram(name: "__barrier", scope: !70, file: !70, line: 57, type: !7, scopeLine: 57, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!70 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!71 = distinct !DILocation(line: 74, column: 3, scope: !72, inlinedAt: !73)
!72 = distinct !DISubprogram(name: "__syncthreads", scope: !70, file: !70, line: 73, type: !7, scopeLine: 73, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!73 = distinct !DILocation(line: 91, column: 3, scope: !40)
!74 = !DILocation(line: 61, column: 3, scope: !69, inlinedAt: !71)
!75 = !DILocation(line: 62, column: 3, scope: !69, inlinedAt: !71)
!76 = !DILocation(line: 93, column: 5, scope: !40)
!77 = !DILocation(line: 94, column: 52, scope: !40)
!78 = !DILocation(line: 94, column: 31, scope: !40)
!79 = !DILocation(line: 94, column: 67, scope: !40)
!80 = !DILocation(line: 99, column: 38, scope: !40)
!81 = !{i32 -1, i32 3, i32 -1}
!82 = !DILocation(line: 60, column: 3, scope: !69, inlinedAt: !83)
!83 = distinct !DILocation(line: 74, column: 3, scope: !72, inlinedAt: !84)
!84 = distinct !DILocation(line: 106, column: 3, scope: !40)
!85 = !DILocation(line: 61, column: 3, scope: !69, inlinedAt: !83)
!86 = !DILocation(line: 62, column: 3, scope: !69, inlinedAt: !83)
!87 = !DILocation(line: 108, column: 8, scope: !40)
!88 = !DILocation(line: 109, column: 68, scope: !40)
!89 = !DILocation(line: 109, column: 24, scope: !40)
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
!128 = !DILocation(line: 60, column: 3, scope: !69, inlinedAt: !129)
!129 = distinct !DILocation(line: 74, column: 3, scope: !72, inlinedAt: !130)
!130 = distinct !DILocation(line: 172, column: 3, scope: !40)
!131 = !DILocation(line: 61, column: 3, scope: !69, inlinedAt: !129)
!132 = !DILocation(line: 62, column: 3, scope: !69, inlinedAt: !129)
!133 = !DILocation(line: 176, column: 121, scope: !40)
!134 = !DILocation(line: 176, column: 31, scope: !40)
!135 = !DILocation(line: 176, column: 29, scope: !40)
!136 = !{!26, !26, i64 0}
!137 = !DILocation(line: 181, column: 38, scope: !40)
!138 = !DILocation(line: 176, column: 95, scope: !40)
!139 = !DILocation(line: 176, column: 107, scope: !40)
!140 = !DILocation(line: 191, column: 61, scope: !40)
!141 = !DILocation(line: 75, column: 10, scope: !119, inlinedAt: !142)
!142 = distinct !DILocation(line: 984, column: 9, scope: !122, inlinedAt: !143)
!143 = distinct !DILocation(line: 133, column: 53, scope: !125, inlinedAt: !144)
!144 = distinct !DILocation(line: 191, column: 53, scope: !40)
!145 = !DILocation(line: 191, column: 50, scope: !40)
!146 = !DILocation(line: 195, column: 3, scope: !40)
!147 = !DILocation(line: 196, column: 22, scope: !40)
!148 = !DILocation(line: 196, column: 140, scope: !40)
!149 = !DILocation(line: 198, column: 1, scope: !40)
