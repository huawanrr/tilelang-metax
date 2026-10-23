; ModuleID = '/data/tilelang-metax/race_tests/nsa/experiments/20261014_goal8933/timing_signal_binary/oj10_m1_p0.bc'
source_filename = "/tmp/tmpr1ieo18u/tvm_kernels.maca"
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
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %5, !dbg !47
  %6 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !47, !tbaa !30
  %cmp25 = icmp ult i32 %6, 16
  %7 = shl nsw i32 %6, 4, !dbg !48
  %mul26 = select i1 %cmp25, i32 %7, i32 -16, !dbg !48
  %8 = or disjoint i64 %5, 1, !dbg !49
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8, !dbg !47
  %9 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !dbg !47, !tbaa !30
  %cmp25.1 = icmp ult i32 %9, 16
  %10 = shl nsw i32 %9, 4, !dbg !48
  %mul26.1 = select i1 %cmp25.1, i32 %10, i32 -16, !dbg !48
  %shr61 = lshr i32 %1, 3
  %11 = shl nuw nsw i32 %1, 3
  %12 = and i32 %11, 56
  %add57 = add nsw i32 %shr61, %mul26, !dbg !50
  %or.cond = icmp ult i32 %add57, 256, !dbg !51
  br i1 %or.cond, label %if.then69, label %if.then51.1, !dbg !51

if.then69:                                        ; preds = %entry
  %13 = shl nuw nsw i32 %add57, 6
  %add75757 = or disjoint i32 %13, %12
  %add75 = zext nneg i32 %add75757 to i64
  %add.ptr76 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add75
  %condval_2.sroa.7.0.add.ptr76.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr76, i64 12
  %condval_2.sroa.6.0.add.ptr76.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr76, i64 8
  %condval_2.sroa.5.0.add.ptr76.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr76, i64 4
  %condval_2.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr76, align 16, !dbg !52, !tbaa !30
  %condval_2.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr76.sroa_idx, align 4, !dbg !52, !tbaa !30
  %condval_2.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr76.sroa_idx, align 8, !dbg !52, !tbaa !30
  %condval_2.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr76.sroa_idx, align 4, !dbg !52, !tbaa !30
  br label %if.then51.1, !dbg !53

if.then51.1:                                      ; preds = %if.then69, %entry
  %condval_2.sroa.0.0 = phi i32 [ %condval_2.sroa.0.0.copyload, %if.then69 ], [ 0, %entry ], !dbg !54
  %condval_2.sroa.5.0 = phi i32 [ %condval_2.sroa.5.0.copyload, %if.then69 ], [ 0, %entry ], !dbg !54
  %condval_2.sroa.6.0 = phi i32 [ %condval_2.sroa.6.0.copyload, %if.then69 ], [ 0, %entry ], !dbg !54
  %condval_2.sroa.7.0 = phi i32 [ %condval_2.sroa.7.0.copyload, %if.then69 ], [ 0, %entry ], !dbg !54
  %add55.1 = add nuw nsw i32 %shr61, 8, !dbg !55
  %add57.1 = add nsw i32 %add55.1, %mul26, !dbg !50
  %or.cond.1 = icmp ult i32 %add57.1, 256, !dbg !51
  br i1 %or.cond.1, label %if.then69.1, label %if.else58.2, !dbg !51

if.then69.1:                                      ; preds = %if.then51.1
  %14 = shl nuw nsw i32 %add57.1, 6
  %add75757.1 = or disjoint i32 %14, %12
  %add75.1 = zext nneg i32 %add75757.1 to i64
  %add.ptr76.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add75.1
  %condval_2.sroa.7.0.add.ptr76.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr76.1, i64 12
  %condval_2.sroa.6.0.add.ptr76.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr76.1, i64 8
  %condval_2.sroa.5.0.add.ptr76.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr76.1, i64 4
  %condval_2.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr76.1, align 16, !dbg !52, !tbaa !30
  %condval_2.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr76.sroa_idx.1, align 4, !dbg !52, !tbaa !30
  %condval_2.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr76.sroa_idx.1, align 8, !dbg !52, !tbaa !30
  %condval_2.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr76.sroa_idx.1, align 4, !dbg !52, !tbaa !30
  br label %if.else58.2, !dbg !53

if.else58.2:                                      ; preds = %if.then51.1, %if.then69.1
  %condval_2.sroa.0.0.1 = phi i32 [ %condval_2.sroa.0.0.copyload.1, %if.then69.1 ], [ 0, %if.then51.1 ], !dbg !54
  %condval_2.sroa.5.0.1 = phi i32 [ %condval_2.sroa.5.0.copyload.1, %if.then69.1 ], [ 0, %if.then51.1 ], !dbg !54
  %condval_2.sroa.6.0.1 = phi i32 [ %condval_2.sroa.6.0.copyload.1, %if.then69.1 ], [ 0, %if.then51.1 ], !dbg !54
  %condval_2.sroa.7.0.1 = phi i32 [ %condval_2.sroa.7.0.copyload.1, %if.then69.1 ], [ 0, %if.then51.1 ], !dbg !54
  %sub.2 = add i32 %shr61, %mul26.1, !dbg !56
  %or.cond.2 = icmp ult i32 %sub.2, 256, !dbg !51
  br i1 %or.cond.2, label %if.then69.2, label %if.else58.3, !dbg !51

if.then69.2:                                      ; preds = %if.else58.2
  %15 = shl nuw nsw i32 %sub.2, 6
  %add75757.2 = or disjoint i32 %15, %12
  %add75.2 = zext nneg i32 %add75757.2 to i64
  %add.ptr76.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add75.2
  %condval_2.sroa.7.0.add.ptr76.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr76.2, i64 12
  %condval_2.sroa.6.0.add.ptr76.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr76.2, i64 8
  %condval_2.sroa.5.0.add.ptr76.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr76.2, i64 4
  %condval_2.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %add.ptr76.2, align 16, !dbg !52, !tbaa !30
  %condval_2.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr76.sroa_idx.2, align 4, !dbg !52, !tbaa !30
  %condval_2.sroa.6.0.copyload.2 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr76.sroa_idx.2, align 8, !dbg !52, !tbaa !30
  %condval_2.sroa.7.0.copyload.2 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr76.sroa_idx.2, align 4, !dbg !52, !tbaa !30
  br label %if.else58.3, !dbg !53

if.else58.3:                                      ; preds = %if.else58.2, %if.then69.2
  %condval_2.sroa.0.0.2 = phi i32 [ %condval_2.sroa.0.0.copyload.2, %if.then69.2 ], [ 0, %if.else58.2 ], !dbg !54
  %condval_2.sroa.5.0.2 = phi i32 [ %condval_2.sroa.5.0.copyload.2, %if.then69.2 ], [ 0, %if.else58.2 ], !dbg !54
  %condval_2.sroa.6.0.2 = phi i32 [ %condval_2.sroa.6.0.copyload.2, %if.then69.2 ], [ 0, %if.else58.2 ], !dbg !54
  %condval_2.sroa.7.0.2 = phi i32 [ %condval_2.sroa.7.0.copyload.2, %if.then69.2 ], [ 0, %if.else58.2 ], !dbg !54
  %add64.3 = add nuw nsw i32 %shr61, 8, !dbg !57
  %sub.3 = add i32 %add64.3, %mul26.1, !dbg !56
  %or.cond.3 = icmp ult i32 %sub.3, 256, !dbg !51
  br i1 %or.cond.3, label %if.then69.3, label %if.then112, !dbg !51

if.then69.3:                                      ; preds = %if.else58.3
  %16 = shl nuw nsw i32 %sub.3, 6
  %add75757.3 = or disjoint i32 %16, %12
  %add75.3 = zext nneg i32 %add75757.3 to i64
  %add.ptr76.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add75.3
  %condval_2.sroa.7.0.add.ptr76.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr76.3, i64 12
  %condval_2.sroa.6.0.add.ptr76.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr76.3, i64 8
  %condval_2.sroa.5.0.add.ptr76.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr76.3, i64 4
  %condval_2.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %add.ptr76.3, align 16, !dbg !52, !tbaa !30
  %condval_2.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr76.sroa_idx.3, align 4, !dbg !52, !tbaa !30
  %condval_2.sroa.6.0.copyload.3 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr76.sroa_idx.3, align 8, !dbg !52, !tbaa !30
  %condval_2.sroa.7.0.copyload.3 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr76.sroa_idx.3, align 4, !dbg !52, !tbaa !30
  br label %if.then112, !dbg !53

if.then112:                                       ; preds = %if.else58.3, %if.then69.3
  %condval_2.sroa.0.0.3 = phi i32 [ %condval_2.sroa.0.0.copyload.3, %if.then69.3 ], [ 0, %if.else58.3 ], !dbg !54
  %condval_2.sroa.5.0.3 = phi i32 [ %condval_2.sroa.5.0.copyload.3, %if.then69.3 ], [ 0, %if.else58.3 ], !dbg !54
  %condval_2.sroa.6.0.3 = phi i32 [ %condval_2.sroa.6.0.copyload.3, %if.then69.3 ], [ 0, %if.else58.3 ], !dbg !54
  %condval_2.sroa.7.0.3 = phi i32 [ %condval_2.sroa.7.0.copyload.3, %if.then69.3 ], [ 0, %if.else58.3 ], !dbg !54
  %add118 = add nsw i32 %shr61, %mul26, !dbg !58
  %or.cond677 = icmp ult i32 %add118, 256, !dbg !59
  br i1 %or.cond677, label %if.then131, label %if.then112.1, !dbg !59

if.then131:                                       ; preds = %if.then112
  %17 = shl nuw nsw i32 %add118, 6
  %add138758 = or disjoint i32 %17, %12
  %add138 = zext nneg i32 %add138758 to i64
  %add.ptr139 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add138
  %condval_4.sroa.7.0.add.ptr139.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr139, i64 12
  %condval_4.sroa.6.0.add.ptr139.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr139, i64 8
  %condval_4.sroa.5.0.add.ptr139.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr139, i64 4
  %condval_4.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr139, align 16, !dbg !60, !tbaa !30
  %condval_4.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr139.sroa_idx, align 4, !dbg !60, !tbaa !30
  %condval_4.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr139.sroa_idx, align 8, !dbg !60, !tbaa !30
  %condval_4.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr139.sroa_idx, align 4, !dbg !60, !tbaa !30
  br label %if.then112.1, !dbg !61

if.then112.1:                                     ; preds = %if.then131, %if.then112
  %condval_4.sroa.0.0 = phi i32 [ %condval_4.sroa.0.0.copyload, %if.then131 ], [ 0, %if.then112 ], !dbg !54
  %condval_4.sroa.5.0 = phi i32 [ %condval_4.sroa.5.0.copyload, %if.then131 ], [ 0, %if.then112 ], !dbg !54
  %condval_4.sroa.6.0 = phi i32 [ %condval_4.sroa.6.0.copyload, %if.then131 ], [ 0, %if.then112 ], !dbg !54
  %condval_4.sroa.7.0 = phi i32 [ %condval_4.sroa.7.0.copyload, %if.then131 ], [ 0, %if.then112 ], !dbg !54
  %add116.1 = add nuw nsw i32 %shr61, 8, !dbg !62
  %add118.1 = add nsw i32 %add116.1, %mul26, !dbg !58
  %or.cond677.1 = icmp ult i32 %add118.1, 256, !dbg !59
  br i1 %or.cond677.1, label %if.then131.1, label %if.else119.2, !dbg !59

if.then131.1:                                     ; preds = %if.then112.1
  %18 = shl nuw nsw i32 %add118.1, 6
  %add138758.1 = or disjoint i32 %18, %12
  %add138.1 = zext nneg i32 %add138758.1 to i64
  %add.ptr139.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add138.1
  %condval_4.sroa.7.0.add.ptr139.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr139.1, i64 12
  %condval_4.sroa.6.0.add.ptr139.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr139.1, i64 8
  %condval_4.sroa.5.0.add.ptr139.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr139.1, i64 4
  %condval_4.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr139.1, align 16, !dbg !60, !tbaa !30
  %condval_4.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr139.sroa_idx.1, align 4, !dbg !60, !tbaa !30
  %condval_4.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr139.sroa_idx.1, align 8, !dbg !60, !tbaa !30
  %condval_4.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr139.sroa_idx.1, align 4, !dbg !60, !tbaa !30
  br label %if.else119.2, !dbg !61

if.else119.2:                                     ; preds = %if.then112.1, %if.then131.1
  %condval_4.sroa.0.0.1 = phi i32 [ %condval_4.sroa.0.0.copyload.1, %if.then131.1 ], [ 0, %if.then112.1 ], !dbg !54
  %condval_4.sroa.5.0.1 = phi i32 [ %condval_4.sroa.5.0.copyload.1, %if.then131.1 ], [ 0, %if.then112.1 ], !dbg !54
  %condval_4.sroa.6.0.1 = phi i32 [ %condval_4.sroa.6.0.copyload.1, %if.then131.1 ], [ 0, %if.then112.1 ], !dbg !54
  %condval_4.sroa.7.0.1 = phi i32 [ %condval_4.sroa.7.0.copyload.1, %if.then131.1 ], [ 0, %if.then112.1 ], !dbg !54
  %sub126.2 = add i32 %shr61, %mul26.1, !dbg !63
  %or.cond677.2 = icmp ult i32 %sub126.2, 256, !dbg !59
  br i1 %or.cond677.2, label %if.then131.2, label %if.else119.3, !dbg !59

if.then131.2:                                     ; preds = %if.else119.2
  %19 = shl nuw nsw i32 %sub126.2, 6
  %add138758.2 = or disjoint i32 %19, %12
  %add138.2 = zext nneg i32 %add138758.2 to i64
  %add.ptr139.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add138.2
  %condval_4.sroa.7.0.add.ptr139.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr139.2, i64 12
  %condval_4.sroa.6.0.add.ptr139.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr139.2, i64 8
  %condval_4.sroa.5.0.add.ptr139.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr139.2, i64 4
  %condval_4.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %add.ptr139.2, align 16, !dbg !60, !tbaa !30
  %condval_4.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr139.sroa_idx.2, align 4, !dbg !60, !tbaa !30
  %condval_4.sroa.6.0.copyload.2 = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr139.sroa_idx.2, align 8, !dbg !60, !tbaa !30
  %condval_4.sroa.7.0.copyload.2 = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr139.sroa_idx.2, align 4, !dbg !60, !tbaa !30
  br label %if.else119.3, !dbg !61

if.else119.3:                                     ; preds = %if.else119.2, %if.then131.2
  %condval_4.sroa.0.0.2 = phi i32 [ %condval_4.sroa.0.0.copyload.2, %if.then131.2 ], [ 0, %if.else119.2 ], !dbg !54
  %condval_4.sroa.5.0.2 = phi i32 [ %condval_4.sroa.5.0.copyload.2, %if.then131.2 ], [ 0, %if.else119.2 ], !dbg !54
  %condval_4.sroa.6.0.2 = phi i32 [ %condval_4.sroa.6.0.copyload.2, %if.then131.2 ], [ 0, %if.else119.2 ], !dbg !54
  %condval_4.sroa.7.0.2 = phi i32 [ %condval_4.sroa.7.0.copyload.2, %if.then131.2 ], [ 0, %if.else119.2 ], !dbg !54
  %add125.3 = add nuw nsw i32 %shr61, 8, !dbg !64
  %sub126.3 = add i32 %add125.3, %mul26.1, !dbg !63
  %or.cond677.3 = icmp ult i32 %sub126.3, 256, !dbg !59
  br i1 %or.cond677.3, label %if.then131.3, label %if.end163.3, !dbg !59

if.then131.3:                                     ; preds = %if.else119.3
  %20 = shl nuw nsw i32 %sub126.3, 6
  %add138758.3 = or disjoint i32 %20, %12
  %add138.3 = zext nneg i32 %add138758.3 to i64
  %add.ptr139.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add138.3
  %condval_4.sroa.7.0.add.ptr139.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr139.3, i64 12
  %condval_4.sroa.6.0.add.ptr139.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr139.3, i64 8
  %condval_4.sroa.5.0.add.ptr139.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr139.3, i64 4
  %condval_4.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %add.ptr139.3, align 16, !dbg !60, !tbaa !30
  %condval_4.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr139.sroa_idx.3, align 4, !dbg !60, !tbaa !30
  %condval_4.sroa.6.0.copyload.3 = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr139.sroa_idx.3, align 8, !dbg !60, !tbaa !30
  %condval_4.sroa.7.0.copyload.3 = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr139.sroa_idx.3, align 4, !dbg !60, !tbaa !30
  br label %if.end163.3, !dbg !61

if.end163.3:                                      ; preds = %if.then131.3, %if.else119.3
  %condval_4.sroa.0.0.3 = phi i32 [ %condval_4.sroa.0.0.copyload.3, %if.then131.3 ], [ 0, %if.else119.3 ], !dbg !54
  %condval_4.sroa.5.0.3 = phi i32 [ %condval_4.sroa.5.0.copyload.3, %if.then131.3 ], [ 0, %if.else119.3 ], !dbg !54
  %condval_4.sroa.6.0.3 = phi i32 [ %condval_4.sroa.6.0.copyload.3, %if.then131.3 ], [ 0, %if.else119.3 ], !dbg !54
  %condval_4.sroa.7.0.3 = phi i32 [ %condval_4.sroa.7.0.copyload.3, %if.then131.3 ], [ 0, %if.else119.3 ], !dbg !54
  %mul183 = and i32 %11, 8128
  %call187.masked = and i32 %1, 1016
  %mul189 = xor i32 %12, %call187.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @V_shared, i32 %mul183, !dbg !65
  %invariant.gep729 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul189, !dbg !65
  store i32 %condval_2.sroa.0.0, ptr addrspace(3) %invariant.gep729, align 16, !dbg !66, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep729.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep729, i32 4, !dbg !66
  store i32 %condval_2.sroa.5.0, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep729.sroa_idx, align 4, !dbg !66, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep729.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep729, i32 8, !dbg !66
  store i32 %condval_2.sroa.6.0, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep729.sroa_idx, align 8, !dbg !66, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep729.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep729, i32 12, !dbg !66
  store i32 %condval_2.sroa.7.0, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep729.sroa_idx, align 4, !dbg !66, !tbaa !30
  %gep730.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep729, i32 1024, !dbg !67
  store i32 %condval_2.sroa.0.0.1, ptr addrspace(3) %gep730.1, align 16, !dbg !66, !tbaa !30
  %K_reg.sroa.9.16.gep730.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep729, i32 1028, !dbg !66
  store i32 %condval_2.sroa.5.0.1, ptr addrspace(3) %K_reg.sroa.9.16.gep730.1.sroa_idx, align 4, !dbg !66, !tbaa !30
  %K_reg.sroa.10.16.gep730.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep729, i32 1032, !dbg !66
  store i32 %condval_2.sroa.6.0.1, ptr addrspace(3) %K_reg.sroa.10.16.gep730.1.sroa_idx, align 8, !dbg !66, !tbaa !30
  %K_reg.sroa.11.16.gep730.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep729, i32 1036, !dbg !66
  store i32 %condval_2.sroa.7.0.1, ptr addrspace(3) %K_reg.sroa.11.16.gep730.1.sroa_idx, align 4, !dbg !66, !tbaa !30
  %gep730.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep729, i32 2048, !dbg !67
  store i32 %condval_2.sroa.0.0.2, ptr addrspace(3) %gep730.2, align 16, !dbg !66, !tbaa !30
  %K_reg.sroa.14.32.gep730.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep729, i32 2052, !dbg !66
  store i32 %condval_2.sroa.5.0.2, ptr addrspace(3) %K_reg.sroa.14.32.gep730.2.sroa_idx, align 4, !dbg !66, !tbaa !30
  %K_reg.sroa.15.32.gep730.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep729, i32 2056, !dbg !66
  store i32 %condval_2.sroa.6.0.2, ptr addrspace(3) %K_reg.sroa.15.32.gep730.2.sroa_idx, align 8, !dbg !66, !tbaa !30
  %K_reg.sroa.16.32.gep730.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep729, i32 2060, !dbg !66
  store i32 %condval_2.sroa.7.0.2, ptr addrspace(3) %K_reg.sroa.16.32.gep730.2.sroa_idx, align 4, !dbg !66, !tbaa !30
  %gep730.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep729, i32 3072, !dbg !67
  store i32 %condval_2.sroa.0.0.3, ptr addrspace(3) %gep730.3, align 16, !dbg !66, !tbaa !30
  %K_reg.sroa.19.48.gep730.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep729, i32 3076, !dbg !66
  store i32 %condval_2.sroa.5.0.3, ptr addrspace(3) %K_reg.sroa.19.48.gep730.3.sroa_idx, align 4, !dbg !66, !tbaa !30
  %K_reg.sroa.20.48.gep730.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep729, i32 3080, !dbg !66
  store i32 %condval_2.sroa.6.0.3, ptr addrspace(3) %K_reg.sroa.20.48.gep730.3.sroa_idx, align 8, !dbg !66, !tbaa !30
  %K_reg.sroa.21.48.gep730.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep729, i32 3084, !dbg !66
  store i32 %condval_2.sroa.7.0.3, ptr addrspace(3) %K_reg.sroa.21.48.gep730.3.sroa_idx, align 4, !dbg !66, !tbaa !30
  fence syncscope("block") release, !dbg !68
  tail call void @llvm.mxc.barrier(), !dbg !74
  fence syncscope("block") acquire, !dbg !75
  %shr226 = lshr i32 %1, 4
  %and229 = and i32 %1, 7
  %xor230 = xor i32 %shr226, %and229
  %add.ptr234.idx = shl nuw nsw i32 %xor230, 4
  %invariant.gep733 = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr234.idx, !dbg !76
  %gep = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep733, i32 %mul7, !dbg !77
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %gep, align 16, !dbg !78
  %kb.sroa.6.0.gep.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep, i32 8, !dbg !78
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.gep.sroa_idx, align 8, !dbg !78
  %add223.1 = or disjoint i32 %mul7, 1024, !dbg !79
  %gep.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep733, i32 %add223.1, !dbg !77
  %kb.sroa.8.16.copyload = load <4 x half>, ptr addrspace(3) %gep.1, align 16, !dbg !78
  %kb.sroa.12.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep.1, i32 8, !dbg !78
  %kb.sroa.12.16.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.12.16.gep.1.sroa_idx, align 8, !dbg !78
  %21 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !80, !call_argsrelate !81
  %22 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.8.16.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !80, !call_argsrelate !81
  %23 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %21), !dbg !80, !call_argsrelate !81
  %24 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.12.16.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %22), !dbg !80, !call_argsrelate !81
  %add227.1 = add nuw nsw i32 %shr226, 4
  %xor230.1 = xor i32 %add227.1, %and229
  %add.ptr234.idx.1 = shl nuw nsw i32 %xor230.1, 4
  %invariant.gep733.1 = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr234.idx.1, !dbg !76
  %gep.1768 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep733.1, i32 %mul7, !dbg !77
  %kb.sroa.0.0.copyload857 = load <4 x half>, ptr addrspace(3) %gep.1768, align 16, !dbg !78
  %kb.sroa.6.0.gep.1768.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep.1768, i32 8, !dbg !78
  %kb.sroa.6.0.copyload858 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.gep.1768.sroa_idx, align 8, !dbg !78
  %gep.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep733.1, i32 %add223.1, !dbg !77
  %kb.sroa.8.16.copyload861 = load <4 x half>, ptr addrspace(3) %gep.1.1, align 16, !dbg !78
  %kb.sroa.12.16.gep.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep.1.1, i32 8, !dbg !78
  %kb.sroa.12.16.copyload862 = load <4 x half>, ptr addrspace(3) %kb.sroa.12.16.gep.1.1.sroa_idx, align 8, !dbg !78
  %25 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload857, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %23), !dbg !80, !call_argsrelate !81
  %26 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.8.16.copyload861, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %24), !dbg !80, !call_argsrelate !81
  %27 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload858, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %25), !dbg !80, !call_argsrelate !81
  %28 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.12.16.copyload862, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %26), !dbg !80, !call_argsrelate !81
  fence syncscope("block") release, !dbg !82
  tail call void @llvm.mxc.barrier(), !dbg !85
  fence syncscope("block") acquire, !dbg !86
  %add.ptr288.idx = shl nuw nsw i32 %1, 4
  %invariant.gep738 = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr288.idx, !dbg !87
  store i32 %condval_4.sroa.0.0, ptr addrspace(3) %invariant.gep738, align 16, !dbg !88, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep738.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep738, i32 4, !dbg !88
  store i32 %condval_4.sroa.5.0, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep738.sroa_idx, align 4, !dbg !88, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep738.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep738, i32 8, !dbg !88
  store i32 %condval_4.sroa.6.0, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep738.sroa_idx, align 8, !dbg !88, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep738.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep738, i32 12, !dbg !88
  store i32 %condval_4.sroa.7.0, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep738.sroa_idx, align 4, !dbg !88, !tbaa !30
  %gep739.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep738, i32 1024, !dbg !89
  store i32 %condval_4.sroa.0.0.1, ptr addrspace(3) %gep739.1, align 16, !dbg !88, !tbaa !30
  %V_reg.sroa.9.16.gep739.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep738, i32 1028, !dbg !88
  store i32 %condval_4.sroa.5.0.1, ptr addrspace(3) %V_reg.sroa.9.16.gep739.1.sroa_idx, align 4, !dbg !88, !tbaa !30
  %V_reg.sroa.10.16.gep739.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep738, i32 1032, !dbg !88
  store i32 %condval_4.sroa.6.0.1, ptr addrspace(3) %V_reg.sroa.10.16.gep739.1.sroa_idx, align 8, !dbg !88, !tbaa !30
  %V_reg.sroa.11.16.gep739.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep738, i32 1036, !dbg !88
  store i32 %condval_4.sroa.7.0.1, ptr addrspace(3) %V_reg.sroa.11.16.gep739.1.sroa_idx, align 4, !dbg !88, !tbaa !30
  %gep739.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep738, i32 2048, !dbg !89
  store i32 %condval_4.sroa.0.0.2, ptr addrspace(3) %gep739.2, align 16, !dbg !88, !tbaa !30
  %V_reg.sroa.14.32.gep739.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep738, i32 2052, !dbg !88
  store i32 %condval_4.sroa.5.0.2, ptr addrspace(3) %V_reg.sroa.14.32.gep739.2.sroa_idx, align 4, !dbg !88, !tbaa !30
  %V_reg.sroa.15.32.gep739.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep738, i32 2056, !dbg !88
  store i32 %condval_4.sroa.6.0.2, ptr addrspace(3) %V_reg.sroa.15.32.gep739.2.sroa_idx, align 8, !dbg !88, !tbaa !30
  %V_reg.sroa.16.32.gep739.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep738, i32 2060, !dbg !88
  store i32 %condval_4.sroa.7.0.2, ptr addrspace(3) %V_reg.sroa.16.32.gep739.2.sroa_idx, align 4, !dbg !88, !tbaa !30
  %gep739.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep738, i32 3072, !dbg !89
  store i32 %condval_4.sroa.0.0.3, ptr addrspace(3) %gep739.3, align 16, !dbg !88, !tbaa !30
  %V_reg.sroa.19.48.gep739.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep738, i32 3076, !dbg !88
  store i32 %condval_4.sroa.5.0.3, ptr addrspace(3) %V_reg.sroa.19.48.gep739.3.sroa_idx, align 4, !dbg !88, !tbaa !30
  %V_reg.sroa.20.48.gep739.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep738, i32 3080, !dbg !88
  store i32 %condval_4.sroa.6.0.3, ptr addrspace(3) %V_reg.sroa.20.48.gep739.3.sroa_idx, align 8, !dbg !88, !tbaa !30
  %V_reg.sroa.21.48.gep739.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep738, i32 3084, !dbg !88
  store i32 %condval_4.sroa.7.0.3, ptr addrspace(3) %V_reg.sroa.21.48.gep739.3.sroa_idx, align 4, !dbg !88, !tbaa !30
  %29 = lshr i32 %1, 2
  %mul309 = and i32 %29, 252
  %add303 = add i32 %29, %mul26, !dbg !90
  %add324 = add i32 %mul309, %mul26, !dbg !91
  %add345 = add i32 %mul309, %mul26, !dbg !92
  %cmp359 = icmp slt i32 %add303, 0, !dbg !93
  %cmp361 = icmp sgt i32 %add324, 255
  %or.cond678.not760 = or i1 %cmp359, %cmp361, !dbg !94
  %cmp364.not = icmp sgt i32 %add345, %0
  %or.cond723 = or i1 %or.cond678.not760, %cmp364.not, !dbg !94
  br i1 %or.cond723, label %if.then297.1, label %if.then365, !dbg !94

if.then365:                                       ; preds = %if.end163.3
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %27, i64 0, !dbg !95
  %mul368 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !96
  %30 = tail call contract noundef float @llvm.minnum.f32(float %mul368, float 0x4024CB5EC0000000), !dbg !97
  %31 = tail call contract noundef float @llvm.exp.f32(float %30), !dbg !101
  br label %if.then297.1, !dbg !104

if.then297.1:                                     ; preds = %if.then365, %if.end163.3
  %condval_5.0 = phi float [ %31, %if.then365 ], [ 0.000000e+00, %if.end163.3 ], !dbg !54
  %add303.1 = add i32 %29, %mul26, !dbg !90
  %add323.1 = or disjoint i32 %mul309, 1, !dbg !105
  %add324.1 = add i32 %add323.1, %mul26, !dbg !91
  %add344.1 = or disjoint i32 %mul309, 1, !dbg !106
  %add345.1 = add i32 %add344.1, %mul26, !dbg !92
  %cmp359.1 = icmp slt i32 %add303.1, 0, !dbg !93
  %cmp361.1 = icmp sgt i32 %add324.1, 255
  %or.cond678.not760.1 = select i1 %cmp359.1, i1 true, i1 %cmp361.1, !dbg !94
  %cmp364.not.1 = icmp sgt i32 %add345.1, %0
  %or.cond723.1 = select i1 %or.cond678.not760.1, i1 true, i1 %cmp364.not.1, !dbg !94
  br i1 %or.cond723.1, label %if.then297.2, label %if.then365.1, !dbg !94

if.then365.1:                                     ; preds = %if.then297.1
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %27, i64 1, !dbg !95
  %mul368.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !96
  %32 = tail call contract noundef float @llvm.minnum.f32(float %mul368.1, float 0x4024CB5EC0000000), !dbg !97
  %33 = tail call contract noundef float @llvm.exp.f32(float %32), !dbg !101
  br label %if.then297.2, !dbg !104

if.then297.2:                                     ; preds = %if.then297.1, %if.then365.1
  %condval_5.0.1 = phi float [ %33, %if.then365.1 ], [ 0.000000e+00, %if.then297.1 ], !dbg !54
  %add303.2 = add i32 %29, %mul26, !dbg !90
  %add323.2 = or disjoint i32 %mul309, 2, !dbg !105
  %add324.2 = add i32 %add323.2, %mul26, !dbg !91
  %add344.2 = or disjoint i32 %mul309, 2, !dbg !106
  %add345.2 = add i32 %add344.2, %mul26, !dbg !92
  %cmp359.2 = icmp slt i32 %add303.2, 0, !dbg !93
  %cmp361.2 = icmp sgt i32 %add324.2, 255
  %or.cond678.not760.2 = select i1 %cmp359.2, i1 true, i1 %cmp361.2, !dbg !94
  %cmp364.not.2 = icmp sgt i32 %add345.2, %0
  %or.cond723.2 = select i1 %or.cond678.not760.2, i1 true, i1 %cmp364.not.2, !dbg !94
  br i1 %or.cond723.2, label %if.then297.3, label %if.then365.2, !dbg !94

if.then365.2:                                     ; preds = %if.then297.2
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %27, i64 2, !dbg !95
  %mul368.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !96
  %34 = tail call contract noundef float @llvm.minnum.f32(float %mul368.2, float 0x4024CB5EC0000000), !dbg !97
  %35 = tail call contract noundef float @llvm.exp.f32(float %34), !dbg !101
  br label %if.then297.3, !dbg !104

if.then297.3:                                     ; preds = %if.then297.2, %if.then365.2
  %condval_5.0.2 = phi float [ %35, %if.then365.2 ], [ 0.000000e+00, %if.then297.2 ], !dbg !54
  %add303.3 = add i32 %29, %mul26, !dbg !90
  %add323.3 = or i32 %29, 3, !dbg !105
  %add324.3 = add i32 %add323.3, %mul26, !dbg !91
  %add344.3 = or i32 %29, 3, !dbg !106
  %add345.3 = add i32 %add344.3, %mul26, !dbg !92
  %cmp359.3 = icmp slt i32 %add303.3, 0, !dbg !93
  %cmp361.3 = icmp sgt i32 %add324.3, 255
  %or.cond678.not760.3 = or i1 %cmp359.3, %cmp361.3, !dbg !94
  %cmp364.not.3 = icmp sgt i32 %add345.3, %0
  %or.cond723.3 = or i1 %or.cond678.not760.3, %cmp364.not.3, !dbg !94
  br i1 %or.cond723.3, label %if.else304.4, label %if.then365.3, !dbg !94

if.then365.3:                                     ; preds = %if.then297.3
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %27, i64 3, !dbg !95
  %mul368.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !96
  %36 = tail call contract noundef float @llvm.minnum.f32(float %mul368.3, float 0x4024CB5EC0000000), !dbg !97
  %37 = tail call contract noundef float @llvm.exp.f32(float %36), !dbg !101
  br label %if.else304.4, !dbg !104

if.else304.4:                                     ; preds = %if.then297.3, %if.then365.3
  %condval_5.0.3 = phi float [ %37, %if.then365.3 ], [ 0.000000e+00, %if.then297.3 ], !dbg !54
  %sub315.4 = add i32 %29, %mul26.1, !dbg !107
  %sub336.4 = add i32 %mul309, %mul26.1, !dbg !108
  %sub357.4 = add i32 %mul309, %mul26.1, !dbg !109
  %cmp359.4 = icmp slt i32 %sub315.4, 0, !dbg !93
  %cmp361.4 = icmp sgt i32 %sub336.4, 255
  %or.cond678.not760.4 = or i1 %cmp359.4, %cmp361.4, !dbg !94
  %cmp364.not.4 = icmp sgt i32 %sub357.4, %0
  %or.cond723.4 = select i1 %or.cond678.not760.4, i1 true, i1 %cmp364.not.4, !dbg !94
  br i1 %or.cond723.4, label %if.else304.5, label %if.then365.4, !dbg !94

if.then365.4:                                     ; preds = %if.else304.4
  %acc_s.sroa.38.16.vec.extract = extractelement <4 x float> %28, i64 0, !dbg !95
  %mul368.4 = fmul contract float %acc_s.sroa.38.16.vec.extract, 0x3FB99999A0000000, !dbg !96
  %38 = tail call contract noundef float @llvm.minnum.f32(float %mul368.4, float 0x4024CB5EC0000000), !dbg !97
  %39 = tail call contract noundef float @llvm.exp.f32(float %38), !dbg !101
  br label %if.else304.5, !dbg !104

if.else304.5:                                     ; preds = %if.else304.4, %if.then365.4
  %condval_5.0.4 = phi float [ %39, %if.then365.4 ], [ 0.000000e+00, %if.else304.4 ], !dbg !54
  %sub315.5 = add i32 %29, %mul26.1, !dbg !107
  %add335.5 = or disjoint i32 %mul309, 1, !dbg !110
  %sub336.5 = add i32 %add335.5, %mul26.1, !dbg !108
  %add356.5 = or disjoint i32 %mul309, 1, !dbg !111
  %sub357.5 = add i32 %add356.5, %mul26.1, !dbg !109
  %cmp359.5 = icmp slt i32 %sub315.5, 0, !dbg !93
  %cmp361.5 = icmp sgt i32 %sub336.5, 255
  %or.cond678.not760.5 = select i1 %cmp359.5, i1 true, i1 %cmp361.5, !dbg !94
  %cmp364.not.5 = icmp sgt i32 %sub357.5, %0
  %or.cond723.5 = select i1 %or.cond678.not760.5, i1 true, i1 %cmp364.not.5, !dbg !94
  br i1 %or.cond723.5, label %if.else304.6, label %if.then365.5, !dbg !94

if.then365.5:                                     ; preds = %if.else304.5
  %acc_s.sroa.38.20.vec.extract = extractelement <4 x float> %28, i64 1, !dbg !95
  %mul368.5 = fmul contract float %acc_s.sroa.38.20.vec.extract, 0x3FB99999A0000000, !dbg !96
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul368.5, float 0x4024CB5EC0000000), !dbg !97
  %41 = tail call contract noundef float @llvm.exp.f32(float %40), !dbg !101
  br label %if.else304.6, !dbg !104

if.else304.6:                                     ; preds = %if.else304.5, %if.then365.5
  %condval_5.0.5 = phi float [ %41, %if.then365.5 ], [ 0.000000e+00, %if.else304.5 ], !dbg !54
  %sub315.6 = add i32 %29, %mul26.1, !dbg !107
  %add335.6 = or disjoint i32 %mul309, 2, !dbg !110
  %sub336.6 = add i32 %add335.6, %mul26.1, !dbg !108
  %add356.6 = or disjoint i32 %mul309, 2, !dbg !111
  %sub357.6 = add i32 %add356.6, %mul26.1, !dbg !109
  %cmp359.6 = icmp slt i32 %sub315.6, 0, !dbg !93
  %cmp361.6 = icmp sgt i32 %sub336.6, 255
  %or.cond678.not760.6 = select i1 %cmp359.6, i1 true, i1 %cmp361.6, !dbg !94
  %cmp364.not.6 = icmp sgt i32 %sub357.6, %0
  %or.cond723.6 = select i1 %or.cond678.not760.6, i1 true, i1 %cmp364.not.6, !dbg !94
  br i1 %or.cond723.6, label %if.else304.7, label %if.then365.6, !dbg !94

if.then365.6:                                     ; preds = %if.else304.6
  %acc_s.sroa.38.24.vec.extract = extractelement <4 x float> %28, i64 2, !dbg !95
  %mul368.6 = fmul contract float %acc_s.sroa.38.24.vec.extract, 0x3FB99999A0000000, !dbg !96
  %42 = tail call contract noundef float @llvm.minnum.f32(float %mul368.6, float 0x4024CB5EC0000000), !dbg !97
  %43 = tail call contract noundef float @llvm.exp.f32(float %42), !dbg !101
  br label %if.else304.7, !dbg !104

if.else304.7:                                     ; preds = %if.else304.6, %if.then365.6
  %condval_5.0.6 = phi float [ %43, %if.then365.6 ], [ 0.000000e+00, %if.else304.6 ], !dbg !54
  %sub315.7 = add i32 %29, %mul26.1, !dbg !107
  %add335.7 = or i32 %29, 3, !dbg !110
  %sub336.7 = add i32 %add335.7, %mul26.1, !dbg !108
  %add356.7 = or i32 %29, 3, !dbg !111
  %sub357.7 = add i32 %add356.7, %mul26.1, !dbg !109
  %cmp359.7 = icmp slt i32 %sub315.7, 0, !dbg !93
  %cmp361.7 = icmp sgt i32 %sub336.7, 255
  %or.cond678.not760.7 = or i1 %cmp359.7, %cmp361.7, !dbg !94
  %cmp364.not.7 = icmp sgt i32 %sub357.7, %0
  %or.cond723.7 = select i1 %or.cond678.not760.7, i1 true, i1 %cmp364.not.7, !dbg !94
  br i1 %or.cond723.7, label %if.end372.7, label %if.then365.7, !dbg !94

if.then365.7:                                     ; preds = %if.else304.7
  %acc_s.sroa.38.28.vec.extract = extractelement <4 x float> %28, i64 3, !dbg !95
  %mul368.7 = fmul contract float %acc_s.sroa.38.28.vec.extract, 0x3FB99999A0000000, !dbg !96
  %44 = tail call contract noundef float @llvm.minnum.f32(float %mul368.7, float 0x4024CB5EC0000000), !dbg !97
  %45 = tail call contract noundef float @llvm.exp.f32(float %44), !dbg !101
  br label %if.end372.7, !dbg !104

if.end372.7:                                      ; preds = %if.then365.7, %if.else304.7
  %condval_5.0.7 = phi float [ %45, %if.then365.7 ], [ 0.000000e+00, %if.else304.7 ], !dbg !54
  %add392.1 = fadd contract float %condval_5.0, %condval_5.0.1, !dbg !112
  %add392.2 = fadd contract float %add392.1, %condval_5.0.2, !dbg !112
  %add392.3 = fadd contract float %add392.2, %condval_5.0.3, !dbg !112
  %add392.1774 = fadd contract float %add392.3, %condval_5.0.4, !dbg !112
  %add392.1.1 = fadd contract float %add392.1774, %condval_5.0.5, !dbg !112
  %add392.2.1 = fadd contract float %add392.1.1, %condval_5.0.6, !dbg !112
  %add392.3.1 = fadd contract float %add392.2.1, %condval_5.0.7, !dbg !112
  %46 = bitcast float %add392.3.1 to i32, !dbg !113
  %47 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10, !dbg !116
  %48 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %47) #10, !dbg !121
  %xor.i.i = xor i32 %48, 32, !dbg !122
  %49 = and i32 %48, -64, !dbg !123
  %and.i.i = add nsw i32 %49, 64, !dbg !123
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !124
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %48, !dbg !125
  %shl.i.i = shl i32 %cond.i.i, 2, !dbg !126
  %50 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %46), !dbg !127
  %51 = bitcast i32 %50 to float, !dbg !128
  %add403 = fadd contract float %add392.3.1, %51, !dbg !129
  %52 = bitcast float %add403 to i32, !dbg !130
  %53 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10, !dbg !132
  %54 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %53) #10, !dbg !135
  %xor.i.i711 = xor i32 %54, 16, !dbg !136
  %55 = and i32 %54, -64, !dbg !137
  %and.i.i712 = add nsw i32 %55, 64, !dbg !137
  %cmp.not.i.i713 = icmp slt i32 %xor.i.i711, %and.i.i712, !dbg !138
  %cond.i.i714 = select i1 %cmp.not.i.i713, i32 %xor.i.i711, i32 %54, !dbg !139
  %shl.i.i715 = shl i32 %cond.i.i714, 2, !dbg !140
  %56 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i715, i32 %52), !dbg !141
  %57 = bitcast i32 %56 to float, !dbg !142
  %add408 = fadd contract float %add403, %57, !dbg !143
  %cmp411 = fcmp contract ogt float %add408, 0.000000e+00, !dbg !144
  %div = fdiv contract float 1.000000e+00, %add408, !dbg !145
  %condval_9.0 = select i1 %cmp411, float %div, float 0.000000e+00, !dbg !145
  %mul424 = fmul contract float %condval_9.0, %condval_5.0, !dbg !146
  %mul424.1 = fmul contract float %condval_9.0, %condval_5.0.1, !dbg !146
  %mul424.2 = fmul contract float %condval_9.0, %condval_5.0.2, !dbg !146
  %mul424.3 = fmul contract float %condval_9.0, %condval_5.0.3, !dbg !146
  %mul424.4 = fmul contract float %condval_9.0, %condval_5.0.4, !dbg !146
  %mul424.5 = fmul contract float %condval_9.0, %condval_5.0.5, !dbg !146
  %mul424.6 = fmul contract float %condval_9.0, %condval_5.0.6, !dbg !146
  %mul424.7 = fmul contract float %condval_9.0, %condval_5.0.7, !dbg !146
  %58 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul424), !dbg !147
  %59 = insertelement <4 x i16> poison, i16 %58, i64 0, !dbg !156
  %60 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul424.1), !dbg !147
  %61 = insertelement <4 x i16> %59, i16 %60, i64 1, !dbg !156
  %62 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul424.2), !dbg !147
  %63 = insertelement <4 x i16> %61, i16 %62, i64 2, !dbg !156
  %64 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul424.3), !dbg !147
  %65 = insertelement <4 x i16> %63, i16 %64, i64 3, !dbg !156
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %65 to <4 x half>, !dbg !156
  %66 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul424.4), !dbg !147
  %67 = insertelement <4 x i16> poison, i16 %66, i64 0, !dbg !156
  %68 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul424.5), !dbg !147
  %69 = insertelement <4 x i16> %67, i16 %68, i64 1, !dbg !156
  %70 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul424.6), !dbg !147
  %71 = insertelement <4 x i16> %69, i16 %70, i64 2, !dbg !156
  %72 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul424.7), !dbg !147
  %73 = insertelement <4 x i16> %71, i16 %72, i64 3, !dbg !156
  %acc_s_cast.sroa.7.14.vec.insert = bitcast <4 x i16> %73 to <4 x half>, !dbg !156
  fence syncscope("block") release, !dbg !157
  tail call void @llvm.mxc.barrier(), !dbg !160
  fence syncscope("block") acquire, !dbg !161
  %mul468 = and i32 %add.ptr288.idx, 16128
  %and475 = and i32 %1, 15
  %add476 = or disjoint i32 %mul468, %and475, !dbg !162
  %arrayidx478 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476, !dbg !163
  %74 = load half, ptr addrspace(3) %arrayidx478, align 2, !dbg !164, !tbaa !165
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %74, i64 0, !dbg !164
  %add471.1 = or disjoint i32 %mul468, %and475, !dbg !162
  %add476.1 = or disjoint i32 %add471.1, 64, !dbg !162
  %arrayidx478.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.1, !dbg !163
  %75 = load half, ptr addrspace(3) %arrayidx478.1, align 2, !dbg !164, !tbaa !165
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %75, i64 1, !dbg !164
  %add471.2 = or disjoint i32 %mul468, %and475, !dbg !162
  %add476.2 = or disjoint i32 %add471.2, 128, !dbg !162
  %arrayidx478.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.2, !dbg !163
  %76 = load half, ptr addrspace(3) %arrayidx478.2, align 2, !dbg !164, !tbaa !165
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %76, i64 2, !dbg !164
  %add471.3 = or disjoint i32 %mul468, %and475, !dbg !162
  %add476.3 = or disjoint i32 %add471.3, 192, !dbg !162
  %arrayidx478.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.3, !dbg !163
  %77 = load half, ptr addrspace(3) %arrayidx478.3, align 2, !dbg !164, !tbaa !165
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %77, i64 3, !dbg !164
  %add473.1777 = or disjoint i32 %mul468, %and475, !dbg !162
  %add476.1778 = or disjoint i32 %add473.1777, 16, !dbg !162
  %arrayidx478.1779 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.1778, !dbg !163
  %78 = load half, ptr addrspace(3) %arrayidx478.1779, align 2, !dbg !164, !tbaa !165
  %vb.sroa.12.8.vec.insert = insertelement <4 x half> poison, half %78, i64 0, !dbg !164
  %add473.1.1 = or disjoint i32 %mul468, %and475, !dbg !162
  %add476.1.1 = or disjoint i32 %add473.1.1, 80, !dbg !162
  %arrayidx478.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.1.1, !dbg !163
  %79 = load half, ptr addrspace(3) %arrayidx478.1.1, align 2, !dbg !164, !tbaa !165
  %vb.sroa.12.10.vec.insert = insertelement <4 x half> %vb.sroa.12.8.vec.insert, half %79, i64 1, !dbg !164
  %add473.2.1 = or disjoint i32 %mul468, %and475, !dbg !162
  %add476.2.1 = or disjoint i32 %add473.2.1, 144, !dbg !162
  %arrayidx478.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.2.1, !dbg !163
  %80 = load half, ptr addrspace(3) %arrayidx478.2.1, align 2, !dbg !164, !tbaa !165
  %vb.sroa.12.12.vec.insert = insertelement <4 x half> %vb.sroa.12.10.vec.insert, half %80, i64 2, !dbg !164
  %add473.3.1 = or disjoint i32 %mul468, %and475, !dbg !162
  %add476.3.1 = or disjoint i32 %add473.3.1, 208, !dbg !162
  %arrayidx478.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.3.1, !dbg !163
  %81 = load half, ptr addrspace(3) %arrayidx478.3.1, align 2, !dbg !164, !tbaa !165
  %vb.sroa.12.14.vec.insert = insertelement <4 x half> %vb.sroa.12.12.vec.insert, half %81, i64 3, !dbg !164
  %add473.2781 = or disjoint i32 %mul468, %and475, !dbg !162
  %add476.2782 = or disjoint i32 %add473.2781, 32, !dbg !162
  %arrayidx478.2783 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.2782, !dbg !163
  %82 = load half, ptr addrspace(3) %arrayidx478.2783, align 2, !dbg !164, !tbaa !165
  %vb.sroa.22.16.vec.insert = insertelement <4 x half> poison, half %82, i64 0, !dbg !164
  %add473.1.2 = or disjoint i32 %mul468, %and475, !dbg !162
  %add476.1.2 = or disjoint i32 %add473.1.2, 96, !dbg !162
  %arrayidx478.1.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.1.2, !dbg !163
  %83 = load half, ptr addrspace(3) %arrayidx478.1.2, align 2, !dbg !164, !tbaa !165
  %vb.sroa.22.18.vec.insert = insertelement <4 x half> %vb.sroa.22.16.vec.insert, half %83, i64 1, !dbg !164
  %add473.2.2 = or disjoint i32 %mul468, %and475, !dbg !162
  %add476.2.2 = or disjoint i32 %add473.2.2, 160, !dbg !162
  %arrayidx478.2.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.2.2, !dbg !163
  %84 = load half, ptr addrspace(3) %arrayidx478.2.2, align 2, !dbg !164, !tbaa !165
  %vb.sroa.22.20.vec.insert = insertelement <4 x half> %vb.sroa.22.18.vec.insert, half %84, i64 2, !dbg !164
  %add473.3.2 = or disjoint i32 %mul468, %and475, !dbg !162
  %add476.3.2 = or disjoint i32 %add473.3.2, 224, !dbg !162
  %arrayidx478.3.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.3.2, !dbg !163
  %85 = load half, ptr addrspace(3) %arrayidx478.3.2, align 2, !dbg !164, !tbaa !165
  %vb.sroa.22.22.vec.insert = insertelement <4 x half> %vb.sroa.22.20.vec.insert, half %85, i64 3, !dbg !164
  %add473.3785 = or disjoint i32 %mul468, %and475, !dbg !162
  %add476.3786 = or disjoint i32 %add473.3785, 48, !dbg !162
  %arrayidx478.3787 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.3786, !dbg !163
  %86 = load half, ptr addrspace(3) %arrayidx478.3787, align 2, !dbg !164, !tbaa !165
  %vb.sroa.32.24.vec.insert = insertelement <4 x half> poison, half %86, i64 0, !dbg !164
  %add473.1.3 = or disjoint i32 %mul468, %and475, !dbg !162
  %add476.1.3 = or disjoint i32 %add473.1.3, 112, !dbg !162
  %arrayidx478.1.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.1.3, !dbg !163
  %87 = load half, ptr addrspace(3) %arrayidx478.1.3, align 2, !dbg !164, !tbaa !165
  %vb.sroa.32.26.vec.insert = insertelement <4 x half> %vb.sroa.32.24.vec.insert, half %87, i64 1, !dbg !164
  %add473.2.3 = or disjoint i32 %mul468, %and475, !dbg !162
  %add476.2.3 = or disjoint i32 %add473.2.3, 176, !dbg !162
  %arrayidx478.2.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.2.3, !dbg !163
  %88 = load half, ptr addrspace(3) %arrayidx478.2.3, align 2, !dbg !164, !tbaa !165
  %vb.sroa.32.28.vec.insert = insertelement <4 x half> %vb.sroa.32.26.vec.insert, half %88, i64 2, !dbg !164
  %add473.3.3 = or disjoint i32 %add.ptr288.idx, %and475, !dbg !162
  %add476.3.3 = or i32 %add473.3.3, 240, !dbg !162
  %arrayidx478.3.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.3.3, !dbg !163
  %89 = load half, ptr addrspace(3) %arrayidx478.3.3, align 2, !dbg !164, !tbaa !165
  %vb.sroa.32.30.vec.insert = insertelement <4 x half> %vb.sroa.32.28.vec.insert, half %89, i64 3, !dbg !164
  %90 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !166
  %91 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !166
  %92 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !166
  %93 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !166
  %add469.1 = add nuw nsw i32 %mul468, 1024
  %add476.1789 = or disjoint i32 %add469.1, %and475, !dbg !162
  %arrayidx478.1790 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.1789, !dbg !163
  %94 = load half, ptr addrspace(3) %arrayidx478.1790, align 2, !dbg !164, !tbaa !165
  %vb.sroa.0.0.vec.insert817 = insertelement <4 x half> poison, half %94, i64 0, !dbg !164
  %add471.1.1791 = add nuw nsw i32 %mul468, 1088, !dbg !167
  %add476.1.1792 = or disjoint i32 %add471.1.1791, %and475, !dbg !162
  %arrayidx478.1.1793 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.1.1792, !dbg !163
  %95 = load half, ptr addrspace(3) %arrayidx478.1.1793, align 2, !dbg !164, !tbaa !165
  %vb.sroa.0.2.vec.insert819 = insertelement <4 x half> %vb.sroa.0.0.vec.insert817, half %95, i64 1, !dbg !164
  %add471.2.1795 = add nuw nsw i32 %mul468, 1152, !dbg !167
  %add476.2.1796 = or disjoint i32 %add471.2.1795, %and475, !dbg !162
  %arrayidx478.2.1797 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.2.1796, !dbg !163
  %96 = load half, ptr addrspace(3) %arrayidx478.2.1797, align 2, !dbg !164, !tbaa !165
  %vb.sroa.0.4.vec.insert821 = insertelement <4 x half> %vb.sroa.0.2.vec.insert819, half %96, i64 2, !dbg !164
  %add471.3.1799 = add nuw nsw i32 %mul468, 1216, !dbg !167
  %add476.3.1800 = or disjoint i32 %add471.3.1799, %and475, !dbg !162
  %arrayidx478.3.1801 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.3.1800, !dbg !163
  %97 = load half, ptr addrspace(3) %arrayidx478.3.1801, align 2, !dbg !164, !tbaa !165
  %vb.sroa.0.6.vec.insert823 = insertelement <4 x half> %vb.sroa.0.4.vec.insert821, half %97, i64 3, !dbg !164
  %add473.1777.1 = add nuw nsw i32 %mul468, 1040, !dbg !168
  %add476.1778.1 = or disjoint i32 %add473.1777.1, %and475, !dbg !162
  %arrayidx478.1779.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.1778.1, !dbg !163
  %98 = load half, ptr addrspace(3) %arrayidx478.1779.1, align 2, !dbg !164, !tbaa !165
  %vb.sroa.12.8.vec.insert827 = insertelement <4 x half> poison, half %98, i64 0, !dbg !164
  %add473.1.1.1 = add nuw nsw i32 %mul468, 1104, !dbg !168
  %add476.1.1.1 = or disjoint i32 %add473.1.1.1, %and475, !dbg !162
  %arrayidx478.1.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.1.1.1, !dbg !163
  %99 = load half, ptr addrspace(3) %arrayidx478.1.1.1, align 2, !dbg !164, !tbaa !165
  %vb.sroa.12.10.vec.insert829 = insertelement <4 x half> %vb.sroa.12.8.vec.insert827, half %99, i64 1, !dbg !164
  %add473.2.1.1 = add nuw nsw i32 %mul468, 1168, !dbg !168
  %add476.2.1.1 = or disjoint i32 %add473.2.1.1, %and475, !dbg !162
  %arrayidx478.2.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.2.1.1, !dbg !163
  %100 = load half, ptr addrspace(3) %arrayidx478.2.1.1, align 2, !dbg !164, !tbaa !165
  %vb.sroa.12.12.vec.insert831 = insertelement <4 x half> %vb.sroa.12.10.vec.insert829, half %100, i64 2, !dbg !164
  %add473.3.1.1 = add nuw nsw i32 %mul468, 1232, !dbg !168
  %add476.3.1.1 = or disjoint i32 %add473.3.1.1, %and475, !dbg !162
  %arrayidx478.3.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.3.1.1, !dbg !163
  %101 = load half, ptr addrspace(3) %arrayidx478.3.1.1, align 2, !dbg !164, !tbaa !165
  %vb.sroa.12.14.vec.insert833 = insertelement <4 x half> %vb.sroa.12.12.vec.insert831, half %101, i64 3, !dbg !164
  %add473.2781.1 = add nuw nsw i32 %mul468, 1056, !dbg !168
  %add476.2782.1 = or disjoint i32 %add473.2781.1, %and475, !dbg !162
  %arrayidx478.2783.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.2782.1, !dbg !163
  %102 = load half, ptr addrspace(3) %arrayidx478.2783.1, align 2, !dbg !164, !tbaa !165
  %vb.sroa.22.16.vec.insert837 = insertelement <4 x half> poison, half %102, i64 0, !dbg !164
  %add473.1.2.1 = add nuw nsw i32 %mul468, 1120, !dbg !168
  %add476.1.2.1 = or disjoint i32 %add473.1.2.1, %and475, !dbg !162
  %arrayidx478.1.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.1.2.1, !dbg !163
  %103 = load half, ptr addrspace(3) %arrayidx478.1.2.1, align 2, !dbg !164, !tbaa !165
  %vb.sroa.22.18.vec.insert839 = insertelement <4 x half> %vb.sroa.22.16.vec.insert837, half %103, i64 1, !dbg !164
  %add473.2.2.1 = add nuw nsw i32 %mul468, 1184, !dbg !168
  %add476.2.2.1 = or disjoint i32 %add473.2.2.1, %and475, !dbg !162
  %arrayidx478.2.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.2.2.1, !dbg !163
  %104 = load half, ptr addrspace(3) %arrayidx478.2.2.1, align 2, !dbg !164, !tbaa !165
  %vb.sroa.22.20.vec.insert841 = insertelement <4 x half> %vb.sroa.22.18.vec.insert839, half %104, i64 2, !dbg !164
  %add473.3.2.1 = add nuw nsw i32 %mul468, 1248, !dbg !168
  %add476.3.2.1 = or disjoint i32 %add473.3.2.1, %and475, !dbg !162
  %arrayidx478.3.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.3.2.1, !dbg !163
  %105 = load half, ptr addrspace(3) %arrayidx478.3.2.1, align 2, !dbg !164, !tbaa !165
  %vb.sroa.22.22.vec.insert843 = insertelement <4 x half> %vb.sroa.22.20.vec.insert841, half %105, i64 3, !dbg !164
  %add473.3785.1 = add nuw nsw i32 %mul468, 1072, !dbg !168
  %add476.3786.1 = or disjoint i32 %add473.3785.1, %and475, !dbg !162
  %arrayidx478.3787.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.3786.1, !dbg !163
  %106 = load half, ptr addrspace(3) %arrayidx478.3787.1, align 2, !dbg !164, !tbaa !165
  %vb.sroa.32.24.vec.insert847 = insertelement <4 x half> poison, half %106, i64 0, !dbg !164
  %add473.1.3.1 = add nuw nsw i32 %mul468, 1136, !dbg !168
  %add476.1.3.1 = or disjoint i32 %add473.1.3.1, %and475, !dbg !162
  %arrayidx478.1.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.1.3.1, !dbg !163
  %107 = load half, ptr addrspace(3) %arrayidx478.1.3.1, align 2, !dbg !164, !tbaa !165
  %vb.sroa.32.26.vec.insert849 = insertelement <4 x half> %vb.sroa.32.24.vec.insert847, half %107, i64 1, !dbg !164
  %add473.2.3.1 = add nuw nsw i32 %mul468, 1200, !dbg !168
  %add476.2.3.1 = or disjoint i32 %add473.2.3.1, %and475, !dbg !162
  %arrayidx478.2.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.2.3.1, !dbg !163
  %108 = load half, ptr addrspace(3) %arrayidx478.2.3.1, align 2, !dbg !164, !tbaa !165
  %vb.sroa.32.28.vec.insert851 = insertelement <4 x half> %vb.sroa.32.26.vec.insert849, half %108, i64 2, !dbg !164
  %add473.3.3.1 = add nuw nsw i32 %mul468, 1264, !dbg !168
  %add476.3.3.1 = or disjoint i32 %add473.3.3.1, %and475, !dbg !162
  %arrayidx478.3.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add476.3.3.1, !dbg !163
  %109 = load half, ptr addrspace(3) %arrayidx478.3.3.1, align 2, !dbg !164, !tbaa !165
  %vb.sroa.32.30.vec.insert853 = insertelement <4 x half> %vb.sroa.32.28.vec.insert851, half %109, i64 3, !dbg !164
  %110 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert823, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %90), !dbg !166
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.14.vec.insert833, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %91), !dbg !166
  %112 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.22.vec.insert843, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %92), !dbg !166
  %113 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.30.vec.insert853, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %93), !dbg !166
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %110, i64 0, !dbg !169
  %114 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract), !dbg !170
  %O_cast.sroa.0.0.insert.ext = zext i16 %114 to i64, !dbg !174
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %110, i64 1, !dbg !169
  %115 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract), !dbg !170
  %O_cast.sroa.0.2.insert.ext = zext i16 %115 to i64, !dbg !174
  %O_cast.sroa.0.2.insert.shift = shl nuw nsw i64 %O_cast.sroa.0.2.insert.ext, 16, !dbg !174
  %O_cast.sroa.0.2.insert.insert = or disjoint i64 %O_cast.sroa.0.2.insert.shift, %O_cast.sroa.0.0.insert.ext, !dbg !174
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %110, i64 2, !dbg !169
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract), !dbg !170
  %O_cast.sroa.0.4.insert.ext = zext i16 %116 to i64, !dbg !174
  %O_cast.sroa.0.4.insert.shift = shl nuw nsw i64 %O_cast.sroa.0.4.insert.ext, 32, !dbg !174
  %O_cast.sroa.0.4.insert.insert = or disjoint i64 %O_cast.sroa.0.2.insert.insert, %O_cast.sroa.0.4.insert.shift, !dbg !174
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %110, i64 3, !dbg !169
  %117 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract), !dbg !170
  %O_cast.sroa.0.6.insert.ext = zext i16 %117 to i64, !dbg !174
  %O_cast.sroa.0.6.insert.shift = shl nuw i64 %O_cast.sroa.0.6.insert.ext, 48, !dbg !174
  %O_cast.sroa.0.6.insert.insert = or disjoint i64 %O_cast.sroa.0.4.insert.insert, %O_cast.sroa.0.6.insert.shift, !dbg !174
  %acc_o.sroa.14.16.vec.extract = extractelement <4 x float> %111, i64 0, !dbg !169
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.16.vec.extract), !dbg !170
  %O_cast.sroa.7.8.insert.ext = zext i16 %118 to i64, !dbg !174
  %acc_o.sroa.14.20.vec.extract = extractelement <4 x float> %111, i64 1, !dbg !169
  %119 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.20.vec.extract), !dbg !170
  %O_cast.sroa.7.10.insert.ext = zext i16 %119 to i64, !dbg !174
  %O_cast.sroa.7.10.insert.shift = shl nuw nsw i64 %O_cast.sroa.7.10.insert.ext, 16, !dbg !174
  %O_cast.sroa.7.10.insert.insert = or disjoint i64 %O_cast.sroa.7.10.insert.shift, %O_cast.sroa.7.8.insert.ext, !dbg !174
  %acc_o.sroa.14.24.vec.extract = extractelement <4 x float> %111, i64 2, !dbg !169
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.24.vec.extract), !dbg !170
  %O_cast.sroa.7.12.insert.ext = zext i16 %120 to i64, !dbg !174
  %O_cast.sroa.7.12.insert.shift = shl nuw nsw i64 %O_cast.sroa.7.12.insert.ext, 32, !dbg !174
  %O_cast.sroa.7.12.insert.insert = or disjoint i64 %O_cast.sroa.7.10.insert.insert, %O_cast.sroa.7.12.insert.shift, !dbg !174
  %acc_o.sroa.14.28.vec.extract = extractelement <4 x float> %111, i64 3, !dbg !169
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.28.vec.extract), !dbg !170
  %O_cast.sroa.7.14.insert.ext = zext i16 %121 to i64, !dbg !174
  %O_cast.sroa.7.14.insert.shift = shl nuw i64 %O_cast.sroa.7.14.insert.ext, 48, !dbg !174
  %O_cast.sroa.7.14.insert.insert = or disjoint i64 %O_cast.sroa.7.12.insert.insert, %O_cast.sroa.7.14.insert.shift, !dbg !174
  %acc_o.sroa.26.32.vec.extract = extractelement <4 x float> %112, i64 0, !dbg !169
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.32.vec.extract), !dbg !170
  %O_cast.sroa.12.16.insert.ext = zext i16 %122 to i64, !dbg !174
  %acc_o.sroa.26.36.vec.extract = extractelement <4 x float> %112, i64 1, !dbg !169
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.36.vec.extract), !dbg !170
  %O_cast.sroa.12.18.insert.ext = zext i16 %123 to i64, !dbg !174
  %O_cast.sroa.12.18.insert.shift = shl nuw nsw i64 %O_cast.sroa.12.18.insert.ext, 16, !dbg !174
  %O_cast.sroa.12.18.insert.insert = or disjoint i64 %O_cast.sroa.12.18.insert.shift, %O_cast.sroa.12.16.insert.ext, !dbg !174
  %acc_o.sroa.26.40.vec.extract = extractelement <4 x float> %112, i64 2, !dbg !169
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.40.vec.extract), !dbg !170
  %O_cast.sroa.12.20.insert.ext = zext i16 %124 to i64, !dbg !174
  %O_cast.sroa.12.20.insert.shift = shl nuw nsw i64 %O_cast.sroa.12.20.insert.ext, 32, !dbg !174
  %O_cast.sroa.12.20.insert.insert = or disjoint i64 %O_cast.sroa.12.18.insert.insert, %O_cast.sroa.12.20.insert.shift, !dbg !174
  %acc_o.sroa.26.44.vec.extract = extractelement <4 x float> %112, i64 3, !dbg !169
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.44.vec.extract), !dbg !170
  %O_cast.sroa.12.22.insert.ext = zext i16 %125 to i64, !dbg !174
  %O_cast.sroa.12.22.insert.shift = shl nuw i64 %O_cast.sroa.12.22.insert.ext, 48, !dbg !174
  %O_cast.sroa.12.22.insert.insert = or disjoint i64 %O_cast.sroa.12.20.insert.insert, %O_cast.sroa.12.22.insert.shift, !dbg !174
  %acc_o.sroa.38.48.vec.extract = extractelement <4 x float> %113, i64 0, !dbg !169
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.48.vec.extract), !dbg !170
  %O_cast.sroa.17.24.insert.ext = zext i16 %126 to i64, !dbg !174
  %acc_o.sroa.38.52.vec.extract = extractelement <4 x float> %113, i64 1, !dbg !169
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.52.vec.extract), !dbg !170
  %O_cast.sroa.17.26.insert.ext = zext i16 %127 to i64, !dbg !174
  %O_cast.sroa.17.26.insert.shift = shl nuw nsw i64 %O_cast.sroa.17.26.insert.ext, 16, !dbg !174
  %O_cast.sroa.17.26.insert.insert = or disjoint i64 %O_cast.sroa.17.26.insert.shift, %O_cast.sroa.17.24.insert.ext, !dbg !174
  %acc_o.sroa.38.56.vec.extract = extractelement <4 x float> %113, i64 2, !dbg !169
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.56.vec.extract), !dbg !170
  %O_cast.sroa.17.28.insert.ext = zext i16 %128 to i64, !dbg !174
  %O_cast.sroa.17.28.insert.shift = shl nuw nsw i64 %O_cast.sroa.17.28.insert.ext, 32, !dbg !174
  %O_cast.sroa.17.28.insert.insert = or disjoint i64 %O_cast.sroa.17.26.insert.insert, %O_cast.sroa.17.28.insert.shift, !dbg !174
  %acc_o.sroa.38.60.vec.extract = extractelement <4 x float> %113, i64 3, !dbg !169
  %129 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.60.vec.extract), !dbg !170
  %O_cast.sroa.17.30.insert.ext = zext i16 %129 to i64, !dbg !174
  %O_cast.sroa.17.30.insert.shift = shl nuw i64 %O_cast.sroa.17.30.insert.ext, 48, !dbg !174
  %O_cast.sroa.17.30.insert.insert = or disjoint i64 %O_cast.sroa.17.28.insert.insert, %O_cast.sroa.17.30.insert.shift, !dbg !174
  %add549 = add nuw nsw i32 %add, %mul309
  %130 = zext nneg i32 %add549 to i64, !dbg !175
  %add.ptr555 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %130, !dbg !176
  store i64 %O_cast.sroa.0.6.insert.insert, ptr addrspace(1) %add.ptr555, align 8, !dbg !177
  %131 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %130, !dbg !176
  %add.ptr555.1 = getelementptr inbounds i8, ptr addrspace(1) %131, i64 32, !dbg !176
  store i64 %O_cast.sroa.7.14.insert.insert, ptr addrspace(1) %add.ptr555.1, align 8, !dbg !177
  %132 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %130, !dbg !176
  %add.ptr555.2 = getelementptr inbounds i8, ptr addrspace(1) %132, i64 64, !dbg !176
  store i64 %O_cast.sroa.12.22.insert.insert, ptr addrspace(1) %add.ptr555.2, align 8, !dbg !177
  %133 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %130, !dbg !176
  %add.ptr555.3 = getelementptr inbounds i8, ptr addrspace(1) %133, i64 96, !dbg !176
  store i64 %O_cast.sroa.17.30.insert.insert, ptr addrspace(1) %add.ptr555.3, align 8, !dbg !177
  ret void, !dbg !178
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

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare i16 @llvm.convert.to.fp16.f32(float) #6

; Function Attrs: convergent nounwind willreturn
declare void @llvm.mxc.barrier() #7

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp.f32(float) #8

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
attributes #10 = { nomerge }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmpr1ieo18u/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpr1ieo18u/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 24, column: 3, scope: !40)
!44 = !DILocation(line: 25, column: 46, scope: !40)
!45 = !DILocation(line: 25, column: 32, scope: !40)
!46 = !DILocation(line: 28, column: 3, scope: !40)
!47 = !DILocation(line: 29, column: 22, scope: !40)
!48 = !DILocation(line: 36, column: 27, scope: !40)
!49 = !DILocation(line: 29, column: 60, scope: !40)
!50 = !DILocation(line: 47, column: 60, scope: !40)
!51 = !DILocation(line: 54, column: 22, scope: !40)
!52 = !DILocation(line: 55, column: 17, scope: !40)
!53 = !DILocation(line: 56, column: 5, scope: !40)
!54 = !DILocation(line: 0, scope: !40)
!55 = !DILocation(line: 47, column: 31, scope: !40)
!56 = !DILocation(line: 49, column: 74, scope: !40)
!57 = !DILocation(line: 49, column: 61, scope: !40)
!58 = !DILocation(line: 65, column: 60, scope: !40)
!59 = !DILocation(line: 72, column: 22, scope: !40)
!60 = !DILocation(line: 73, column: 17, scope: !40)
!61 = !DILocation(line: 74, column: 5, scope: !40)
!62 = !DILocation(line: 65, column: 31, scope: !40)
!63 = !DILocation(line: 67, column: 74, scope: !40)
!64 = !DILocation(line: 67, column: 61, scope: !40)
!65 = !DILocation(line: 80, column: 3, scope: !40)
!66 = !DILocation(line: 81, column: 141, scope: !40)
!67 = !DILocation(line: 81, column: 24, scope: !40)
!68 = !DILocation(line: 60, column: 3, scope: !69, inlinedAt: !71)
!69 = distinct !DISubprogram(name: "__barrier", scope: !70, file: !70, line: 57, type: !7, scopeLine: 57, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!70 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!71 = distinct !DILocation(line: 74, column: 3, scope: !72, inlinedAt: !73)
!72 = distinct !DISubprogram(name: "__syncthreads", scope: !70, file: !70, line: 73, type: !7, scopeLine: 73, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!73 = distinct !DILocation(line: 88, column: 3, scope: !40)
!74 = !DILocation(line: 61, column: 3, scope: !69, inlinedAt: !71)
!75 = !DILocation(line: 62, column: 3, scope: !69, inlinedAt: !71)
!76 = !DILocation(line: 90, column: 5, scope: !40)
!77 = !DILocation(line: 91, column: 52, scope: !40)
!78 = !DILocation(line: 91, column: 31, scope: !40)
!79 = !DILocation(line: 91, column: 67, scope: !40)
!80 = !DILocation(line: 96, column: 38, scope: !40)
!81 = !{i32 -1, i32 3, i32 -1}
!82 = !DILocation(line: 60, column: 3, scope: !69, inlinedAt: !83)
!83 = distinct !DILocation(line: 74, column: 3, scope: !72, inlinedAt: !84)
!84 = distinct !DILocation(line: 103, column: 3, scope: !40)
!85 = !DILocation(line: 61, column: 3, scope: !69, inlinedAt: !83)
!86 = !DILocation(line: 62, column: 3, scope: !69, inlinedAt: !83)
!87 = !DILocation(line: 105, column: 8, scope: !40)
!88 = !DILocation(line: 106, column: 68, scope: !40)
!89 = !DILocation(line: 106, column: 24, scope: !40)
!90 = !DILocation(line: 112, column: 66, scope: !40)
!91 = !DILocation(line: 118, column: 66, scope: !40)
!92 = !DILocation(line: 124, column: 66, scope: !40)
!93 = !DILocation(line: 129, column: 14, scope: !40)
!94 = !DILocation(line: 129, column: 28, scope: !40)
!95 = !DILocation(line: 130, column: 29, scope: !40)
!96 = !DILocation(line: 130, column: 40, scope: !40)
!97 = !DILocation(line: 354, column: 10, scope: !98, inlinedAt: !100)
!98 = distinct !DISubprogram(name: "min", scope: !99, file: !99, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!99 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!100 = distinct !DILocation(line: 130, column: 24, scope: !40)
!101 = !DILocation(line: 288, column: 10, scope: !102, inlinedAt: !103)
!102 = distinct !DISubprogram(name: "expf", scope: !99, file: !99, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!103 = distinct !DILocation(line: 130, column: 19, scope: !40)
!104 = !DILocation(line: 131, column: 5, scope: !40)
!105 = !DILocation(line: 118, column: 53, scope: !40)
!106 = !DILocation(line: 124, column: 53, scope: !40)
!107 = !DILocation(line: 114, column: 102, scope: !40)
!108 = !DILocation(line: 120, column: 102, scope: !40)
!109 = !DILocation(line: 126, column: 102, scope: !40)
!110 = !DILocation(line: 120, column: 89, scope: !40)
!111 = !DILocation(line: 126, column: 89, scope: !40)
!112 = !DILocation(line: 141, column: 34, scope: !40)
!113 = !DILocation(line: 1018, column: 9, scope: !114, inlinedAt: !115)
!114 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !70, file: !70, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!115 = distinct !DILocation(line: 144, column: 32, scope: !40)
!116 = !DILocation(line: 171, column: 37, scope: !117, inlinedAt: !118)
!117 = distinct !DISubprogram(name: "__lane_id", scope: !70, file: !70, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!118 = distinct !DILocation(line: 990, column: 14, scope: !119, inlinedAt: !120)
!119 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !70, file: !70, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!120 = distinct !DILocation(line: 1019, column: 11, scope: !114, inlinedAt: !115)
!121 = !DILocation(line: 171, column: 10, scope: !117, inlinedAt: !118)
!122 = !DILocation(line: 991, column: 20, scope: !119, inlinedAt: !120)
!123 = !DILocation(line: 992, column: 36, scope: !119, inlinedAt: !120)
!124 = !DILocation(line: 992, column: 17, scope: !119, inlinedAt: !120)
!125 = !DILocation(line: 992, column: 11, scope: !119, inlinedAt: !120)
!126 = !DILocation(line: 993, column: 43, scope: !119, inlinedAt: !120)
!127 = !DILocation(line: 993, column: 10, scope: !119, inlinedAt: !120)
!128 = !DILocation(line: 1020, column: 14, scope: !114, inlinedAt: !115)
!129 = !DILocation(line: 144, column: 30, scope: !40)
!130 = !DILocation(line: 1018, column: 9, scope: !114, inlinedAt: !131)
!131 = distinct !DILocation(line: 145, column: 32, scope: !40)
!132 = !DILocation(line: 171, column: 37, scope: !117, inlinedAt: !133)
!133 = distinct !DILocation(line: 990, column: 14, scope: !119, inlinedAt: !134)
!134 = distinct !DILocation(line: 1019, column: 11, scope: !114, inlinedAt: !131)
!135 = !DILocation(line: 171, column: 10, scope: !117, inlinedAt: !133)
!136 = !DILocation(line: 991, column: 20, scope: !119, inlinedAt: !134)
!137 = !DILocation(line: 992, column: 36, scope: !119, inlinedAt: !134)
!138 = !DILocation(line: 992, column: 17, scope: !119, inlinedAt: !134)
!139 = !DILocation(line: 992, column: 11, scope: !119, inlinedAt: !134)
!140 = !DILocation(line: 993, column: 43, scope: !119, inlinedAt: !134)
!141 = !DILocation(line: 993, column: 10, scope: !119, inlinedAt: !134)
!142 = !DILocation(line: 1020, column: 14, scope: !114, inlinedAt: !131)
!143 = !DILocation(line: 145, column: 30, scope: !40)
!144 = !DILocation(line: 147, column: 32, scope: !40)
!145 = !DILocation(line: 147, column: 7, scope: !40)
!146 = !DILocation(line: 155, column: 30, scope: !40)
!147 = !DILocation(line: 75, column: 10, scope: !148, inlinedAt: !150)
!148 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !149, file: !149, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!149 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!150 = distinct !DILocation(line: 984, column: 9, scope: !151, inlinedAt: !153)
!151 = distinct !DISubprogram(name: "__float2half", scope: !152, file: !152, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!152 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!153 = distinct !DILocation(line: 133, column: 53, scope: !154, inlinedAt: !155)
!154 = distinct !DISubprogram(name: "__half", scope: !152, file: !152, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!155 = distinct !DILocation(line: 161, column: 53, scope: !40)
!156 = !DILocation(line: 161, column: 50, scope: !40)
!157 = !DILocation(line: 60, column: 3, scope: !69, inlinedAt: !158)
!158 = distinct !DILocation(line: 74, column: 3, scope: !72, inlinedAt: !159)
!159 = distinct !DILocation(line: 164, column: 3, scope: !40)
!160 = !DILocation(line: 61, column: 3, scope: !69, inlinedAt: !158)
!161 = !DILocation(line: 62, column: 3, scope: !69, inlinedAt: !158)
!162 = !DILocation(line: 168, column: 121, scope: !40)
!163 = !DILocation(line: 168, column: 31, scope: !40)
!164 = !DILocation(line: 168, column: 29, scope: !40)
!165 = !{!26, !26, i64 0}
!166 = !DILocation(line: 173, column: 38, scope: !40)
!167 = !DILocation(line: 168, column: 95, scope: !40)
!168 = !DILocation(line: 168, column: 107, scope: !40)
!169 = !DILocation(line: 183, column: 61, scope: !40)
!170 = !DILocation(line: 75, column: 10, scope: !148, inlinedAt: !171)
!171 = distinct !DILocation(line: 984, column: 9, scope: !151, inlinedAt: !172)
!172 = distinct !DILocation(line: 133, column: 53, scope: !154, inlinedAt: !173)
!173 = distinct !DILocation(line: 183, column: 53, scope: !40)
!174 = !DILocation(line: 183, column: 50, scope: !40)
!175 = !DILocation(line: 187, column: 3, scope: !40)
!176 = !DILocation(line: 188, column: 22, scope: !40)
!177 = !DILocation(line: 188, column: 140, scope: !40)
!178 = !DILocation(line: 190, column: 1, scope: !40)
