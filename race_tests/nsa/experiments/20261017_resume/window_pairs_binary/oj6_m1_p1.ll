; ModuleID = 'experiments/20261017_resume/window_pairs_binary/oj6_m1_p1.bc'
source_filename = "/tmp/tmp6rme96vt/tvm_kernels.maca"
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
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %PackedKV.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(1) noalias nocapture noundef readonly %Schedule.coerce) local_unnamed_addr #3 !dbg !40 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !dbg !42, !range !29
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !dbg !46, !range !29
  %mul = mul nuw nsw i32 %1, 145, !dbg !49
  %idxprom = zext nneg i32 %mul to i64, !dbg !50
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %Schedule.coerce, i64 %idxprom, !dbg !50
  %2 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !50, !tbaa !30
  %cmp = icmp slt i32 %0, %2, !dbg !51
  br i1 %cmp, label %if.then, label %if.end526, !dbg !52

if.then:                                          ; preds = %entry
  %mul9 = mul nuw nsw i32 %0, 3, !dbg !53
  %add = add nuw nsw i32 %mul, %mul9, !dbg !54
  %3 = zext nneg i32 %add to i64, !dbg !55
  %4 = getelementptr inbounds i32, ptr addrspace(1) %Schedule.coerce, i64 %3, !dbg !55
  %arrayidx12 = getelementptr inbounds i8, ptr addrspace(1) %4, i64 4, !dbg !55
  %5 = load i32, ptr addrspace(1) %arrayidx12, align 4, !dbg !55, !tbaa !30
  %arrayidx20 = getelementptr inbounds i8, ptr addrspace(1) %4, i64 8, !dbg !56
  %6 = load i32, ptr addrspace(1) %arrayidx20, align 4, !dbg !56, !tbaa !30
  %arrayidx28 = getelementptr inbounds i8, ptr addrspace(1) %4, i64 12, !dbg !57
  %7 = load i32, ptr addrspace(1) %arrayidx28, align 4, !dbg !57, !tbaa !30
  %invariant.gep714 = getelementptr i8, ptr addrspace(4) %PackedKV.coerce, i64 8192, !dbg !58
  %8 = lshr i32 %1, 4
  %shr = zext nneg i32 %8 to i64
  %9 = tail call range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !59
  %10 = shl nuw nsw i32 %9, 2
  %mul67 = zext nneg i32 %10 to i64
  %invariant.gep = getelementptr %struct.__half, ptr addrspace(4) %Q.coerce, i64 %mul67
  %cmp87 = icmp ult i32 %5, 32
  %mul88 = shl nsw i32 %5, 5
  %11 = shl nuw nsw i32 %5, 13
  %mul102 = zext nneg i32 %11 to i64
  %12 = shl nuw nsw i32 %9, 3
  %mul109 = zext nneg i32 %12 to i64
  %invariant.gep681 = getelementptr %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %mul109
  %and = lshr i32 %9, 1
  %shr134 = and i32 %and, 15
  %shr137 = lshr i32 %9, 5
  %add132 = and i32 %10, 3972
  %and156 = shl nuw nsw i32 %9, 7
  %mul157 = and i32 %and156, 1920
  %shr160 = lshr i32 %9, 4
  %and163 = and i32 %9, 15
  %gep713 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %mul157
  %13 = lshr i32 %9, 2
  %mul193 = and i32 %13, 252
  %add190 = add nuw nsw i32 %mul88, %mul193
  %gep715 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep714, i64 %mul109
  %mul465 = and i32 %13, 4
  %mul493 = and i32 %12, 8064
  %invariant.gep711 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul493
  %14 = shl nuw nsw i32 %1, 17
  %mul508 = and i32 %14, 2145386496
  %add510 = or disjoint i32 %mul508, %12
  %cmp32 = icmp sgt i32 %6, -1, !dbg !60
  br i1 %cmp32, label %for.cond34.preheader, label %if.end522, !dbg !61

for.cond34.preheader:                             ; preds = %if.then
  %cmp42 = icmp ult i32 %6, 1024
  %condval_4.0 = zext nneg i32 %6 to i64
  br i1 %cmp42, label %if.then43, label %if.end79, !dbg !62

for.body421.preheader:                            ; preds = %if.end79.7
  %.pre = add nuw nsw i32 %shr137, 2, !dbg !63
  %.pre1689 = add nuw nsw i32 %shr137, 4, !dbg !63
  %.pre1690 = add nuw nsw i32 %shr137, 6, !dbg !63
  %.pre1691 = add nuw nsw i32 %shr137, 8, !dbg !63
  %.pre1692 = add nuw nsw i32 %shr137, 10, !dbg !63
  %.pre1693 = add nuw nsw i32 %shr137, 12, !dbg !63
  %.pre1694 = add nuw nsw i32 %shr137, 14, !dbg !63
  br label %if.end441, !dbg !64

if.then43:                                        ; preds = %for.cond34.preheader
  %.idx718 = shl nuw nsw i64 %condval_4.0, 12, !dbg !70
  %15 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718, !dbg !70
  %.idx719 = shl nuw nsw i64 %shr, 22, !dbg !70
  %16 = getelementptr i8, ptr addrspace(4) %15, i64 %.idx719, !dbg !70
  %condval_1.sroa.0.0.copyload = load i32, ptr addrspace(4) %16, align 8, !dbg !71, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %16, i64 4, !dbg !71
  %condval_1.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx, align 4, !dbg !71, !tbaa !30
  br label %if.end79, !dbg !72

if.end79:                                         ; preds = %for.cond34.preheader, %if.then43
  %condval_1.sroa.0.0 = phi i32 [ %condval_1.sroa.0.0.copyload, %if.then43 ], [ 0, %for.cond34.preheader ], !dbg !73
  %condval_1.sroa.5.0 = phi i32 [ %condval_1.sroa.5.0.copyload, %if.then43 ], [ 0, %for.cond34.preheader ], !dbg !73
  %q_stage.sroa.0.0.insert.ext = zext i32 %condval_1.sroa.0.0 to i64, !dbg !74
  %q_stage.sroa.0.4.insert.ext = zext i32 %condval_1.sroa.5.0 to i64, !dbg !74
  %q_stage.sroa.0.4.insert.shift = shl nuw i64 %q_stage.sroa.0.4.insert.ext, 32, !dbg !74
  %q_stage.sroa.0.4.insert.insert = or disjoint i64 %q_stage.sroa.0.4.insert.shift, %q_stage.sroa.0.0.insert.ext, !dbg !74
  br i1 %cmp42, label %if.then43.1, label %if.end79.1, !dbg !62

if.then43.1:                                      ; preds = %if.end79
  %.idx718.1 = shl nuw nsw i64 %condval_4.0, 12, !dbg !70
  %17 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718.1, !dbg !70
  %.idx719.1 = shl nuw nsw i64 %shr, 22, !dbg !70
  %18 = getelementptr i8, ptr addrspace(4) %17, i64 %.idx719.1, !dbg !70
  %gep.1 = getelementptr i8, ptr addrspace(4) %18, i64 512, !dbg !70
  %condval_1.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %gep.1, align 8, !dbg !71, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.1 = getelementptr i8, ptr addrspace(4) %18, i64 516, !dbg !71
  %condval_1.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.1, align 4, !dbg !71, !tbaa !30
  br label %if.end79.1, !dbg !72

if.end79.1:                                       ; preds = %if.then43.1, %if.end79
  %condval_1.sroa.0.0.1 = phi i32 [ %condval_1.sroa.0.0.copyload.1, %if.then43.1 ], [ 0, %if.end79 ], !dbg !73
  %condval_1.sroa.5.0.1 = phi i32 [ %condval_1.sroa.5.0.copyload.1, %if.then43.1 ], [ 0, %if.end79 ], !dbg !73
  %q_stage.sroa.8.8.insert.ext = zext i32 %condval_1.sroa.0.0.1 to i64, !dbg !74
  %q_stage.sroa.8.12.insert.ext = zext i32 %condval_1.sroa.5.0.1 to i64, !dbg !74
  %q_stage.sroa.8.12.insert.shift = shl nuw i64 %q_stage.sroa.8.12.insert.ext, 32, !dbg !74
  %q_stage.sroa.8.12.insert.insert = or disjoint i64 %q_stage.sroa.8.12.insert.shift, %q_stage.sroa.8.8.insert.ext, !dbg !74
  br i1 %cmp42, label %if.then43.2, label %if.end79.2, !dbg !62

if.then43.2:                                      ; preds = %if.end79.1
  %.idx718.2 = shl nuw nsw i64 %condval_4.0, 12, !dbg !70
  %19 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718.2, !dbg !70
  %.idx719.2 = shl nuw nsw i64 %shr, 22, !dbg !70
  %20 = getelementptr i8, ptr addrspace(4) %19, i64 %.idx719.2, !dbg !70
  %gep.2 = getelementptr i8, ptr addrspace(4) %20, i64 1024, !dbg !70
  %condval_1.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %gep.2, align 8, !dbg !71, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.2 = getelementptr i8, ptr addrspace(4) %20, i64 1028, !dbg !71
  %condval_1.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.2, align 4, !dbg !71, !tbaa !30
  br label %if.end79.2, !dbg !72

if.end79.2:                                       ; preds = %if.then43.2, %if.end79.1
  %condval_1.sroa.0.0.2 = phi i32 [ %condval_1.sroa.0.0.copyload.2, %if.then43.2 ], [ 0, %if.end79.1 ], !dbg !73
  %condval_1.sroa.5.0.2 = phi i32 [ %condval_1.sroa.5.0.copyload.2, %if.then43.2 ], [ 0, %if.end79.1 ], !dbg !73
  %q_stage.sroa.14.16.insert.ext = zext i32 %condval_1.sroa.0.0.2 to i64, !dbg !74
  %q_stage.sroa.14.20.insert.ext = zext i32 %condval_1.sroa.5.0.2 to i64, !dbg !74
  %q_stage.sroa.14.20.insert.shift = shl nuw i64 %q_stage.sroa.14.20.insert.ext, 32, !dbg !74
  %q_stage.sroa.14.20.insert.insert = or disjoint i64 %q_stage.sroa.14.20.insert.shift, %q_stage.sroa.14.16.insert.ext, !dbg !74
  br i1 %cmp42, label %if.then43.3, label %if.end79.3, !dbg !62

if.then43.3:                                      ; preds = %if.end79.2
  %.idx718.3 = shl nuw nsw i64 %condval_4.0, 12, !dbg !70
  %21 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718.3, !dbg !70
  %.idx719.3 = shl nuw nsw i64 %shr, 22, !dbg !70
  %22 = getelementptr i8, ptr addrspace(4) %21, i64 %.idx719.3, !dbg !70
  %gep.3 = getelementptr i8, ptr addrspace(4) %22, i64 1536, !dbg !70
  %condval_1.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %gep.3, align 8, !dbg !71, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.3 = getelementptr i8, ptr addrspace(4) %22, i64 1540, !dbg !71
  %condval_1.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.3, align 4, !dbg !71, !tbaa !30
  br label %if.end79.3, !dbg !72

if.end79.3:                                       ; preds = %if.then43.3, %if.end79.2
  %condval_1.sroa.0.0.3 = phi i32 [ %condval_1.sroa.0.0.copyload.3, %if.then43.3 ], [ 0, %if.end79.2 ], !dbg !73
  %condval_1.sroa.5.0.3 = phi i32 [ %condval_1.sroa.5.0.copyload.3, %if.then43.3 ], [ 0, %if.end79.2 ], !dbg !73
  %q_stage.sroa.20.24.insert.ext = zext i32 %condval_1.sroa.0.0.3 to i64, !dbg !74
  %q_stage.sroa.20.28.insert.ext = zext i32 %condval_1.sroa.5.0.3 to i64, !dbg !74
  %q_stage.sroa.20.28.insert.shift = shl nuw i64 %q_stage.sroa.20.28.insert.ext, 32, !dbg !74
  %q_stage.sroa.20.28.insert.insert = or disjoint i64 %q_stage.sroa.20.28.insert.shift, %q_stage.sroa.20.24.insert.ext, !dbg !74
  br i1 %cmp42, label %if.then43.4, label %if.end79.4, !dbg !62

if.then43.4:                                      ; preds = %if.end79.3
  %.idx718.4 = shl nuw nsw i64 %condval_4.0, 12, !dbg !70
  %23 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718.4, !dbg !70
  %.idx719.4 = shl nuw nsw i64 %shr, 22, !dbg !70
  %24 = getelementptr i8, ptr addrspace(4) %23, i64 %.idx719.4, !dbg !70
  %gep.4 = getelementptr i8, ptr addrspace(4) %24, i64 2048, !dbg !70
  %condval_1.sroa.0.0.copyload.4 = load i32, ptr addrspace(4) %gep.4, align 8, !dbg !71, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.4 = getelementptr i8, ptr addrspace(4) %24, i64 2052, !dbg !71
  %condval_1.sroa.5.0.copyload.4 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.4, align 4, !dbg !71, !tbaa !30
  br label %if.end79.4, !dbg !72

if.end79.4:                                       ; preds = %if.then43.4, %if.end79.3
  %condval_1.sroa.0.0.4 = phi i32 [ %condval_1.sroa.0.0.copyload.4, %if.then43.4 ], [ 0, %if.end79.3 ], !dbg !73
  %condval_1.sroa.5.0.4 = phi i32 [ %condval_1.sroa.5.0.copyload.4, %if.then43.4 ], [ 0, %if.end79.3 ], !dbg !73
  %q_stage.sroa.26.32.insert.ext = zext i32 %condval_1.sroa.0.0.4 to i64, !dbg !74
  %q_stage.sroa.26.36.insert.ext = zext i32 %condval_1.sroa.5.0.4 to i64, !dbg !74
  %q_stage.sroa.26.36.insert.shift = shl nuw i64 %q_stage.sroa.26.36.insert.ext, 32, !dbg !74
  %q_stage.sroa.26.36.insert.insert = or disjoint i64 %q_stage.sroa.26.36.insert.shift, %q_stage.sroa.26.32.insert.ext, !dbg !74
  br i1 %cmp42, label %if.then43.5, label %if.end79.5, !dbg !62

if.then43.5:                                      ; preds = %if.end79.4
  %.idx718.5 = shl nuw nsw i64 %condval_4.0, 12, !dbg !70
  %25 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718.5, !dbg !70
  %.idx719.5 = shl nuw nsw i64 %shr, 22, !dbg !70
  %26 = getelementptr i8, ptr addrspace(4) %25, i64 %.idx719.5, !dbg !70
  %gep.5 = getelementptr i8, ptr addrspace(4) %26, i64 2560, !dbg !70
  %condval_1.sroa.0.0.copyload.5 = load i32, ptr addrspace(4) %gep.5, align 8, !dbg !71, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.5 = getelementptr i8, ptr addrspace(4) %26, i64 2564, !dbg !71
  %condval_1.sroa.5.0.copyload.5 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.5, align 4, !dbg !71, !tbaa !30
  br label %if.end79.5, !dbg !72

if.end79.5:                                       ; preds = %if.then43.5, %if.end79.4
  %condval_1.sroa.0.0.5 = phi i32 [ %condval_1.sroa.0.0.copyload.5, %if.then43.5 ], [ 0, %if.end79.4 ], !dbg !73
  %condval_1.sroa.5.0.5 = phi i32 [ %condval_1.sroa.5.0.copyload.5, %if.then43.5 ], [ 0, %if.end79.4 ], !dbg !73
  %q_stage.sroa.32.40.insert.ext = zext i32 %condval_1.sroa.0.0.5 to i64, !dbg !74
  %q_stage.sroa.32.44.insert.ext = zext i32 %condval_1.sroa.5.0.5 to i64, !dbg !74
  %q_stage.sroa.32.44.insert.shift = shl nuw i64 %q_stage.sroa.32.44.insert.ext, 32, !dbg !74
  %q_stage.sroa.32.44.insert.insert = or disjoint i64 %q_stage.sroa.32.44.insert.shift, %q_stage.sroa.32.40.insert.ext, !dbg !74
  br i1 %cmp42, label %if.then43.6, label %if.end79.6, !dbg !62

if.then43.6:                                      ; preds = %if.end79.5
  %.idx718.6 = shl nuw nsw i64 %condval_4.0, 12, !dbg !70
  %27 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718.6, !dbg !70
  %.idx719.6 = shl nuw nsw i64 %shr, 22, !dbg !70
  %28 = getelementptr i8, ptr addrspace(4) %27, i64 %.idx719.6, !dbg !70
  %gep.6 = getelementptr i8, ptr addrspace(4) %28, i64 3072, !dbg !70
  %condval_1.sroa.0.0.copyload.6 = load i32, ptr addrspace(4) %gep.6, align 8, !dbg !71, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.6 = getelementptr i8, ptr addrspace(4) %28, i64 3076, !dbg !71
  %condval_1.sroa.5.0.copyload.6 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.6, align 4, !dbg !71, !tbaa !30
  br label %if.end79.6, !dbg !72

if.end79.6:                                       ; preds = %if.then43.6, %if.end79.5
  %condval_1.sroa.0.0.6 = phi i32 [ %condval_1.sroa.0.0.copyload.6, %if.then43.6 ], [ 0, %if.end79.5 ], !dbg !73
  %condval_1.sroa.5.0.6 = phi i32 [ %condval_1.sroa.5.0.copyload.6, %if.then43.6 ], [ 0, %if.end79.5 ], !dbg !73
  %q_stage.sroa.38.48.insert.ext = zext i32 %condval_1.sroa.0.0.6 to i64, !dbg !74
  %q_stage.sroa.38.52.insert.ext = zext i32 %condval_1.sroa.5.0.6 to i64, !dbg !74
  %q_stage.sroa.38.52.insert.shift = shl nuw i64 %q_stage.sroa.38.52.insert.ext, 32, !dbg !74
  %q_stage.sroa.38.52.insert.insert = or disjoint i64 %q_stage.sroa.38.52.insert.shift, %q_stage.sroa.38.48.insert.ext, !dbg !74
  br i1 %cmp42, label %if.then43.7, label %if.end79.7, !dbg !62

if.then43.7:                                      ; preds = %if.end79.6
  %.idx718.7 = shl nuw nsw i64 %condval_4.0, 12, !dbg !70
  %29 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718.7, !dbg !70
  %.idx719.7 = shl nuw nsw i64 %shr, 22, !dbg !70
  %30 = getelementptr i8, ptr addrspace(4) %29, i64 %.idx719.7, !dbg !70
  %gep.7 = getelementptr i8, ptr addrspace(4) %30, i64 3584, !dbg !70
  %condval_1.sroa.0.0.copyload.7 = load i32, ptr addrspace(4) %gep.7, align 8, !dbg !71, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.7 = getelementptr i8, ptr addrspace(4) %30, i64 3588, !dbg !71
  %condval_1.sroa.5.0.copyload.7 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.7, align 4, !dbg !71, !tbaa !30
  %31 = zext i32 %condval_1.sroa.0.0.copyload.7 to i64, !dbg !74
  %32 = zext i32 %condval_1.sroa.5.0.copyload.7 to i64, !dbg !74
  %33 = shl nuw i64 %32, 32, !dbg !74
  br label %if.end79.7, !dbg !72

if.end79.7:                                       ; preds = %if.then43.7, %if.end79.6
  %condval_1.sroa.0.0.7 = phi i64 [ %31, %if.then43.7 ], [ 0, %if.end79.6 ], !dbg !73
  %condval_1.sroa.5.0.7 = phi i64 [ %33, %if.then43.7 ], [ 0, %if.end79.6 ], !dbg !73
  %cmp89 = icmp sle i32 %mul88, %6
  %or.cond717 = select i1 %cmp87, i1 %cmp89, i1 false, !dbg !75
  br i1 %or.cond717, label %for.body96.preheader, label %for.body421.preheader, !dbg !75

for.body96.preheader:                             ; preds = %if.end79.7
  %q_stage.sroa.44.60.insert.insert = or disjoint i64 %condval_1.sroa.5.0.7, %condval_1.sroa.0.0.7, !dbg !74
  %.idx720 = shl nuw nsw i64 %shr, 19, !dbg !76
  %34 = getelementptr i8, ptr addrspace(4) %invariant.gep681, i64 %.idx720, !dbg !76
  %35 = getelementptr %struct.__half, ptr addrspace(4) %34, i64 %mul102, !dbg !76
  %k.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %35, align 16, !dbg !77
  %k.sroa.6.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %35, i64 8, !dbg !77
  %k.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.6.0..sroa_idx, align 8, !dbg !77
  %gep682.1 = getelementptr i8, ptr addrspace(4) %35, i64 1024, !dbg !76
  %k.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %gep682.1, align 16, !dbg !77
  %k.sroa.12.16.gep682.1.sroa_idx = getelementptr i8, ptr addrspace(4) %35, i64 1032, !dbg !77
  %k.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.12.16.gep682.1.sroa_idx, align 8, !dbg !77
  %gep682.2 = getelementptr i8, ptr addrspace(4) %35, i64 2048, !dbg !76
  %k.sroa.14.32.copyload = load <4 x half>, ptr addrspace(4) %gep682.2, align 16, !dbg !77
  %k.sroa.18.32.gep682.2.sroa_idx = getelementptr i8, ptr addrspace(4) %35, i64 2056, !dbg !77
  %k.sroa.18.32.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.18.32.gep682.2.sroa_idx, align 8, !dbg !77
  %gep682.3 = getelementptr i8, ptr addrspace(4) %35, i64 3072, !dbg !76
  %k.sroa.20.48.copyload = load <4 x half>, ptr addrspace(4) %gep682.3, align 16, !dbg !77
  %k.sroa.24.48.gep682.3.sroa_idx = getelementptr i8, ptr addrspace(4) %35, i64 3080, !dbg !77
  %k.sroa.24.48.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.24.48.gep682.3.sroa_idx, align 8, !dbg !77
  %gep682.4 = getelementptr i8, ptr addrspace(4) %35, i64 4096, !dbg !76
  %k.sroa.26.64.copyload = load <4 x half>, ptr addrspace(4) %gep682.4, align 16, !dbg !77
  %k.sroa.30.64.gep682.4.sroa_idx = getelementptr i8, ptr addrspace(4) %35, i64 4104, !dbg !77
  %k.sroa.30.64.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.30.64.gep682.4.sroa_idx, align 8, !dbg !77
  %gep682.5 = getelementptr i8, ptr addrspace(4) %35, i64 5120, !dbg !76
  %k.sroa.32.80.copyload = load <4 x half>, ptr addrspace(4) %gep682.5, align 16, !dbg !77
  %k.sroa.36.80.gep682.5.sroa_idx = getelementptr i8, ptr addrspace(4) %35, i64 5128, !dbg !77
  %k.sroa.36.80.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.36.80.gep682.5.sroa_idx, align 8, !dbg !77
  %gep682.6 = getelementptr i8, ptr addrspace(4) %35, i64 6144, !dbg !76
  %k.sroa.38.96.copyload = load <4 x half>, ptr addrspace(4) %gep682.6, align 16, !dbg !77
  %k.sroa.42.96.gep682.6.sroa_idx = getelementptr i8, ptr addrspace(4) %35, i64 6152, !dbg !77
  %k.sroa.42.96.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.42.96.gep682.6.sroa_idx, align 8, !dbg !77
  %gep682.7 = getelementptr i8, ptr addrspace(4) %35, i64 7168, !dbg !76
  %k.sroa.44.112.copyload = load <4 x half>, ptr addrspace(4) %gep682.7, align 16, !dbg !77
  %k.sroa.48.112.gep682.7.sroa_idx = getelementptr i8, ptr addrspace(4) %35, i64 7176, !dbg !77
  %k.sroa.48.112.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.48.112.gep682.7.sroa_idx, align 8, !dbg !77
  %xor = xor i32 %shr137, %shr134, !dbg !78
  %36 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %add132, !dbg !79
  %gep684.idx = shl nuw nsw i32 %xor, 4, !dbg !79
  %gep684 = getelementptr inbounds i8, ptr addrspace(3) %36, i32 %gep684.idx, !dbg !79
  store i64 %q_stage.sroa.0.4.insert.insert, ptr addrspace(3) %gep684, align 8, !dbg !80
  %add138.1 = add nuw nsw i32 %shr137, 2, !dbg !81
  %xor.1 = xor i32 %add138.1, %shr134, !dbg !78
  %37 = getelementptr inbounds i8, ptr addrspace(3) %36, i32 512, !dbg !79
  %gep684.idx.1 = shl nuw nsw i32 %xor.1, 4, !dbg !79
  %gep684.1 = getelementptr inbounds i8, ptr addrspace(3) %37, i32 %gep684.idx.1, !dbg !79
  store i64 %q_stage.sroa.8.12.insert.insert, ptr addrspace(3) %gep684.1, align 8, !dbg !80
  %add138.2 = add nuw nsw i32 %shr137, 4, !dbg !81
  %xor.2 = xor i32 %add138.2, %shr134, !dbg !78
  %38 = getelementptr inbounds i8, ptr addrspace(3) %36, i32 1024, !dbg !79
  %gep684.idx.2 = shl nuw nsw i32 %xor.2, 4, !dbg !79
  %gep684.2 = getelementptr inbounds i8, ptr addrspace(3) %38, i32 %gep684.idx.2, !dbg !79
  store i64 %q_stage.sroa.14.20.insert.insert, ptr addrspace(3) %gep684.2, align 8, !dbg !80
  %add138.3 = add nuw nsw i32 %shr137, 6, !dbg !81
  %xor.3 = xor i32 %add138.3, %shr134, !dbg !78
  %39 = getelementptr inbounds i8, ptr addrspace(3) %36, i32 1536, !dbg !79
  %gep684.idx.3 = shl nuw nsw i32 %xor.3, 4, !dbg !79
  %gep684.3 = getelementptr inbounds i8, ptr addrspace(3) %39, i32 %gep684.idx.3, !dbg !79
  store i64 %q_stage.sroa.20.28.insert.insert, ptr addrspace(3) %gep684.3, align 8, !dbg !80
  %add138.4 = add nuw nsw i32 %shr137, 8, !dbg !81
  %xor.4 = xor i32 %add138.4, %shr134, !dbg !78
  %40 = getelementptr inbounds i8, ptr addrspace(3) %36, i32 2048, !dbg !79
  %gep684.idx.4 = shl nuw nsw i32 %xor.4, 4, !dbg !79
  %gep684.4 = getelementptr inbounds i8, ptr addrspace(3) %40, i32 %gep684.idx.4, !dbg !79
  store i64 %q_stage.sroa.26.36.insert.insert, ptr addrspace(3) %gep684.4, align 8, !dbg !80
  %add138.5 = add nuw nsw i32 %shr137, 10, !dbg !81
  %xor.5 = xor i32 %add138.5, %shr134, !dbg !78
  %41 = getelementptr inbounds i8, ptr addrspace(3) %36, i32 2560, !dbg !79
  %gep684.idx.5 = shl nuw nsw i32 %xor.5, 4, !dbg !79
  %gep684.5 = getelementptr inbounds i8, ptr addrspace(3) %41, i32 %gep684.idx.5, !dbg !79
  store i64 %q_stage.sroa.32.44.insert.insert, ptr addrspace(3) %gep684.5, align 8, !dbg !80
  %add138.6 = add nuw nsw i32 %shr137, 12, !dbg !81
  %xor.6 = xor i32 %add138.6, %shr134, !dbg !78
  %42 = getelementptr inbounds i8, ptr addrspace(3) %36, i32 3072, !dbg !79
  %gep684.idx.6 = shl nuw nsw i32 %xor.6, 4, !dbg !79
  %gep684.6 = getelementptr inbounds i8, ptr addrspace(3) %42, i32 %gep684.idx.6, !dbg !79
  store i64 %q_stage.sroa.38.52.insert.insert, ptr addrspace(3) %gep684.6, align 8, !dbg !80
  %add138.7 = add nuw nsw i32 %shr137, 14, !dbg !81
  %xor.7 = xor i32 %add138.7, %shr134, !dbg !78
  %43 = getelementptr inbounds i8, ptr addrspace(3) %36, i32 3584, !dbg !79
  %gep684.idx.7 = shl nuw nsw i32 %xor.7, 4, !dbg !79
  %gep684.7 = getelementptr inbounds i8, ptr addrspace(3) %43, i32 %gep684.idx.7, !dbg !79
  store i64 %q_stage.sroa.44.60.insert.insert, ptr addrspace(3) %gep684.7, align 8, !dbg !80
  fence syncscope("warp") release, !dbg !82
  tail call void @llvm.mxc.barrier.warp(), !dbg !85
  fence syncscope("warp") acquire, !dbg !86
  %xor164 = xor i32 %shr160, %and163, !dbg !87
  %.idx = shl nuw nsw i32 %xor164, 4, !dbg !88
  %gep687 = getelementptr inbounds i8, ptr addrspace(3) %gep713, i32 %.idx, !dbg !88
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %gep687, align 16, !dbg !89
  %q.sroa.6.0.gep687.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep687, i32 8, !dbg !89
  %q.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.6.0.gep687.sroa_idx, align 8, !dbg !89
  %add161.1 = add nuw nsw i32 %shr160, 4, !dbg !90
  %xor164.1 = xor i32 %add161.1, %and163, !dbg !87
  %.idx.1 = shl nuw nsw i32 %xor164.1, 4, !dbg !88
  %gep687.1 = getelementptr inbounds i8, ptr addrspace(3) %gep713, i32 %.idx.1, !dbg !88
  %q.sroa.8.16.copyload = load <4 x half>, ptr addrspace(3) %gep687.1, align 16, !dbg !89
  %q.sroa.12.16.gep687.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep687.1, i32 8, !dbg !89
  %q.sroa.12.16.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.12.16.gep687.1.sroa_idx, align 8, !dbg !89
  %add161.2 = add nuw nsw i32 %shr160, 8, !dbg !90
  %xor164.2 = xor i32 %add161.2, %and163, !dbg !87
  %.idx.2 = shl nuw nsw i32 %xor164.2, 4, !dbg !88
  %gep687.2 = getelementptr inbounds i8, ptr addrspace(3) %gep713, i32 %.idx.2, !dbg !88
  %q.sroa.14.32.copyload = load <4 x half>, ptr addrspace(3) %gep687.2, align 16, !dbg !89
  %q.sroa.18.32.gep687.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep687.2, i32 8, !dbg !89
  %q.sroa.18.32.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.18.32.gep687.2.sroa_idx, align 8, !dbg !89
  %add161.3 = add nuw nsw i32 %shr160, 12, !dbg !90
  %xor164.3 = xor i32 %add161.3, %and163, !dbg !87
  %.idx.3 = shl nuw nsw i32 %xor164.3, 4, !dbg !88
  %gep687.3 = getelementptr inbounds i8, ptr addrspace(3) %gep713, i32 %.idx.3, !dbg !88
  %q.sroa.20.48.copyload = load <4 x half>, ptr addrspace(3) %gep687.3, align 16, !dbg !89
  %q.sroa.24.48.gep687.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep687.3, i32 8, !dbg !89
  %q.sroa.24.48.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.24.48.gep687.3.sroa_idx, align 8, !dbg !89
  %cmp197.not = icmp sgt i32 %add190, %6, !dbg !91
  %spec.select = select i1 %cmp197.not, float 0xFFF0000000000000, float 0.000000e+00, !dbg !92
  %scores.sroa.0.0.vec.insert = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !93
  %cmp197.not.1.not = icmp slt i32 %add190, %6, !dbg !91
  %spec.select.1 = select i1 %cmp197.not.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !92
  %scores.sroa.0.4.vec.insert = insertelement <4 x float> %scores.sroa.0.0.vec.insert, float %spec.select.1, i64 1, !dbg !93
  %add194.2 = or disjoint i32 %add190, 2, !dbg !94
  %cmp197.not.2 = icmp sgt i32 %add194.2, %6, !dbg !91
  %spec.select.2 = select i1 %cmp197.not.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !92
  %scores.sroa.0.8.vec.insert = insertelement <4 x float> %scores.sroa.0.4.vec.insert, float %spec.select.2, i64 2, !dbg !93
  %add194.3 = or disjoint i32 %add190, 3, !dbg !94
  %cmp197.not.3 = icmp sgt i32 %add194.3, %6, !dbg !91
  %spec.select.3 = select i1 %cmp197.not.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !92
  %scores.sroa.0.12.vec.insert = insertelement <4 x float> %scores.sroa.0.8.vec.insert, float %spec.select.3, i64 3, !dbg !93
  %add196.4 = add nuw nsw i32 %add190, 16, !dbg !95
  %cmp197.not.4 = icmp sgt i32 %add196.4, %6, !dbg !91
  %spec.select.4 = select i1 %cmp197.not.4, float 0xFFF0000000000000, float 0.000000e+00, !dbg !92
  %scores.sroa.90.16.vec.insert = insertelement <4 x float> poison, float %spec.select.4, i64 0, !dbg !93
  %add196.5 = add nuw nsw i32 %add190, 17, !dbg !95
  %cmp197.not.5 = icmp sgt i32 %add196.5, %6, !dbg !91
  %spec.select.5 = select i1 %cmp197.not.5, float 0xFFF0000000000000, float 0.000000e+00, !dbg !92
  %scores.sroa.90.20.vec.insert = insertelement <4 x float> %scores.sroa.90.16.vec.insert, float %spec.select.5, i64 1, !dbg !93
  %add196.6 = add nuw nsw i32 %add190, 18, !dbg !95
  %cmp197.not.6 = icmp sgt i32 %add196.6, %6, !dbg !91
  %spec.select.6 = select i1 %cmp197.not.6, float 0xFFF0000000000000, float 0.000000e+00, !dbg !92
  %scores.sroa.90.24.vec.insert = insertelement <4 x float> %scores.sroa.90.20.vec.insert, float %spec.select.6, i64 2, !dbg !93
  %add196.7 = add nuw nsw i32 %add190, 19, !dbg !95
  %cmp197.not.7 = icmp sgt i32 %add196.7, %6, !dbg !91
  %spec.select.7 = select i1 %cmp197.not.7, float 0xFFF0000000000000, float 0.000000e+00, !dbg !92
  %scores.sroa.90.28.vec.insert = insertelement <4 x float> %scores.sroa.90.24.vec.insert, float %spec.select.7, i64 3, !dbg !93
  %44 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.12.vec.insert), !dbg !96, !call_argsrelate !97
  %45 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.16.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.90.28.vec.insert), !dbg !96, !call_argsrelate !97
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.6.0.copyload, <4 x half> %q.sroa.6.0.copyload, <4 x float> %44), !dbg !96, !call_argsrelate !97
  %47 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.12.16.copyload, <4 x half> %q.sroa.6.0.copyload, <4 x float> %45), !dbg !96, !call_argsrelate !97
  %48 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.32.copyload, <4 x half> %q.sroa.8.16.copyload, <4 x float> %46), !dbg !96, !call_argsrelate !97
  %49 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.48.copyload, <4 x half> %q.sroa.8.16.copyload, <4 x float> %47), !dbg !96, !call_argsrelate !97
  %50 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.18.32.copyload, <4 x half> %q.sroa.12.16.copyload, <4 x float> %48), !dbg !96, !call_argsrelate !97
  %51 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.24.48.copyload, <4 x half> %q.sroa.12.16.copyload, <4 x float> %49), !dbg !96, !call_argsrelate !97
  %52 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.26.64.copyload, <4 x half> %q.sroa.14.32.copyload, <4 x float> %50), !dbg !96, !call_argsrelate !97
  %53 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.32.80.copyload, <4 x half> %q.sroa.14.32.copyload, <4 x float> %51), !dbg !96, !call_argsrelate !97
  %54 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.30.64.copyload, <4 x half> %q.sroa.18.32.copyload, <4 x float> %52), !dbg !96, !call_argsrelate !97
  %55 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.36.80.copyload, <4 x half> %q.sroa.18.32.copyload, <4 x float> %53), !dbg !96, !call_argsrelate !97
  %56 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.38.96.copyload, <4 x half> %q.sroa.20.48.copyload, <4 x float> %54), !dbg !96, !call_argsrelate !97
  %57 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.44.112.copyload, <4 x half> %q.sroa.20.48.copyload, <4 x float> %55), !dbg !96, !call_argsrelate !97
  %58 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.42.96.copyload, <4 x half> %q.sroa.24.48.copyload, <4 x float> %56), !dbg !96, !call_argsrelate !97
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.48.112.copyload, <4 x half> %q.sroa.24.48.copyload, <4 x float> %57), !dbg !96, !call_argsrelate !97
  %.idx724 = shl nuw nsw i64 %shr, 19, !dbg !98
  %60 = getelementptr i8, ptr addrspace(4) %gep715, i64 %.idx724, !dbg !98
  %61 = getelementptr %struct.__half, ptr addrspace(4) %60, i64 %mul102, !dbg !98
  %v.sroa.48.112.gep696.7.sroa_idx = getelementptr i8, ptr addrspace(4) %61, i64 7176, !dbg !99
  %v.sroa.48.112.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.48.112.gep696.7.sroa_idx, align 8, !dbg !99
  %gep696.7 = getelementptr i8, ptr addrspace(4) %61, i64 7168, !dbg !98
  %v.sroa.44.112.copyload = load <4 x half>, ptr addrspace(4) %gep696.7, align 16, !dbg !99
  %v.sroa.42.96.gep696.6.sroa_idx = getelementptr i8, ptr addrspace(4) %61, i64 6152, !dbg !99
  %v.sroa.42.96.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.42.96.gep696.6.sroa_idx, align 8, !dbg !99
  %gep696.6 = getelementptr i8, ptr addrspace(4) %61, i64 6144, !dbg !98
  %v.sroa.38.96.copyload = load <4 x half>, ptr addrspace(4) %gep696.6, align 16, !dbg !99
  %v.sroa.36.80.gep696.5.sroa_idx = getelementptr i8, ptr addrspace(4) %61, i64 5128, !dbg !99
  %v.sroa.36.80.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.36.80.gep696.5.sroa_idx, align 8, !dbg !99
  %gep696.5 = getelementptr i8, ptr addrspace(4) %61, i64 5120, !dbg !98
  %v.sroa.32.80.copyload = load <4 x half>, ptr addrspace(4) %gep696.5, align 16, !dbg !99
  %v.sroa.30.64.gep696.4.sroa_idx = getelementptr i8, ptr addrspace(4) %61, i64 4104, !dbg !99
  %v.sroa.30.64.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.30.64.gep696.4.sroa_idx, align 8, !dbg !99
  %gep696.4 = getelementptr i8, ptr addrspace(4) %61, i64 4096, !dbg !98
  %v.sroa.26.64.copyload = load <4 x half>, ptr addrspace(4) %gep696.4, align 16, !dbg !99
  %v.sroa.24.48.gep696.3.sroa_idx = getelementptr i8, ptr addrspace(4) %61, i64 3080, !dbg !99
  %v.sroa.24.48.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.24.48.gep696.3.sroa_idx, align 8, !dbg !99
  %gep696.3 = getelementptr i8, ptr addrspace(4) %61, i64 3072, !dbg !98
  %v.sroa.20.48.copyload = load <4 x half>, ptr addrspace(4) %gep696.3, align 16, !dbg !99
  %v.sroa.18.32.gep696.2.sroa_idx = getelementptr i8, ptr addrspace(4) %61, i64 2056, !dbg !99
  %v.sroa.18.32.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.18.32.gep696.2.sroa_idx, align 8, !dbg !99
  %gep696.2 = getelementptr i8, ptr addrspace(4) %61, i64 2048, !dbg !98
  %v.sroa.14.32.copyload = load <4 x half>, ptr addrspace(4) %gep696.2, align 16, !dbg !99
  %v.sroa.12.16.gep696.1.sroa_idx = getelementptr i8, ptr addrspace(4) %61, i64 1032, !dbg !99
  %v.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.12.16.gep696.1.sroa_idx, align 8, !dbg !99
  %gep696.1 = getelementptr i8, ptr addrspace(4) %61, i64 1024, !dbg !98
  %v.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %gep696.1, align 16, !dbg !99
  %v.sroa.6.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %61, i64 8, !dbg !99
  %v.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.6.0..sroa_idx, align 8, !dbg !99
  %v.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %61, align 16, !dbg !99
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %58, i64 0, !dbg !100
  %mul282 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FC2776C60000000, !dbg !101
  %62 = tail call contract noundef float @llvm.minnum.f32(float %mul282, float 1.500000e+01), !dbg !102
  %cmp.i.i = fcmp contract olt float %62, -1.260000e+02, !dbg !106
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00, !dbg !106
  %add.i.i667 = fadd contract float %62, %cond.i.i, !dbg !106
  %63 = tail call contract float @llvm.exp2.f32(float %add.i.i667), !dbg !106
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00, !dbg !106
  %mul.i.i = fmul contract float %cond2.i.i, %63, !dbg !106
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %58, i64 1, !dbg !100
  %mul282.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FC2776C60000000, !dbg !101
  %64 = tail call contract noundef float @llvm.minnum.f32(float %mul282.1, float 1.500000e+01), !dbg !102
  %cmp.i.i.1 = fcmp contract olt float %64, -1.260000e+02, !dbg !106
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00, !dbg !106
  %add.i.i667.1 = fadd contract float %64, %cond.i.i.1, !dbg !106
  %65 = tail call contract float @llvm.exp2.f32(float %add.i.i667.1), !dbg !106
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !106
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %65, !dbg !106
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %58, i64 2, !dbg !100
  %mul282.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FC2776C60000000, !dbg !101
  %66 = tail call contract noundef float @llvm.minnum.f32(float %mul282.2, float 1.500000e+01), !dbg !102
  %cmp.i.i.2 = fcmp contract olt float %66, -1.260000e+02, !dbg !106
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00, !dbg !106
  %add.i.i667.2 = fadd contract float %66, %cond.i.i.2, !dbg !106
  %67 = tail call contract float @llvm.exp2.f32(float %add.i.i667.2), !dbg !106
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00, !dbg !106
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %67, !dbg !106
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %58, i64 3, !dbg !100
  %mul282.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FC2776C60000000, !dbg !101
  %68 = tail call contract noundef float @llvm.minnum.f32(float %mul282.3, float 1.500000e+01), !dbg !102
  %cmp.i.i.3 = fcmp contract olt float %68, -1.260000e+02, !dbg !106
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00, !dbg !106
  %add.i.i667.3 = fadd contract float %68, %cond.i.i.3, !dbg !106
  %69 = tail call contract float @llvm.exp2.f32(float %add.i.i667.3), !dbg !106
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00, !dbg !106
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %69, !dbg !106
  %scores.sroa.90.16.vec.extract = extractelement <4 x float> %59, i64 0, !dbg !100
  %mul282.4 = fmul contract float %scores.sroa.90.16.vec.extract, 0x3FC2776C60000000, !dbg !101
  %70 = tail call contract noundef float @llvm.minnum.f32(float %mul282.4, float 1.500000e+01), !dbg !102
  %cmp.i.i.4 = fcmp contract olt float %70, -1.260000e+02, !dbg !106
  %cond.i.i.4 = select contract i1 %cmp.i.i.4, float 6.400000e+01, float 0.000000e+00, !dbg !106
  %add.i.i667.4 = fadd contract float %70, %cond.i.i.4, !dbg !106
  %71 = tail call contract float @llvm.exp2.f32(float %add.i.i667.4), !dbg !106
  %cond2.i.i.4 = select contract i1 %cmp.i.i.4, float 0x3BF0000000000000, float 1.000000e+00, !dbg !106
  %mul.i.i.4 = fmul contract float %cond2.i.i.4, %71, !dbg !106
  %scores.sroa.90.20.vec.extract = extractelement <4 x float> %59, i64 1, !dbg !100
  %mul282.5 = fmul contract float %scores.sroa.90.20.vec.extract, 0x3FC2776C60000000, !dbg !101
  %72 = tail call contract noundef float @llvm.minnum.f32(float %mul282.5, float 1.500000e+01), !dbg !102
  %cmp.i.i.5 = fcmp contract olt float %72, -1.260000e+02, !dbg !106
  %cond.i.i.5 = select contract i1 %cmp.i.i.5, float 6.400000e+01, float 0.000000e+00, !dbg !106
  %add.i.i667.5 = fadd contract float %72, %cond.i.i.5, !dbg !106
  %73 = tail call contract float @llvm.exp2.f32(float %add.i.i667.5), !dbg !106
  %cond2.i.i.5 = select contract i1 %cmp.i.i.5, float 0x3BF0000000000000, float 1.000000e+00, !dbg !106
  %mul.i.i.5 = fmul contract float %cond2.i.i.5, %73, !dbg !106
  %scores.sroa.90.24.vec.extract = extractelement <4 x float> %59, i64 2, !dbg !100
  %mul282.6 = fmul contract float %scores.sroa.90.24.vec.extract, 0x3FC2776C60000000, !dbg !101
  %74 = tail call contract noundef float @llvm.minnum.f32(float %mul282.6, float 1.500000e+01), !dbg !102
  %cmp.i.i.6 = fcmp contract olt float %74, -1.260000e+02, !dbg !106
  %cond.i.i.6 = select contract i1 %cmp.i.i.6, float 6.400000e+01, float 0.000000e+00, !dbg !106
  %add.i.i667.6 = fadd contract float %74, %cond.i.i.6, !dbg !106
  %75 = tail call contract float @llvm.exp2.f32(float %add.i.i667.6), !dbg !106
  %cond2.i.i.6 = select contract i1 %cmp.i.i.6, float 0x3BF0000000000000, float 1.000000e+00, !dbg !106
  %mul.i.i.6 = fmul contract float %cond2.i.i.6, %75, !dbg !106
  %scores.sroa.90.28.vec.extract = extractelement <4 x float> %59, i64 3, !dbg !100
  %mul282.7 = fmul contract float %scores.sroa.90.28.vec.extract, 0x3FC2776C60000000, !dbg !101
  %76 = tail call contract noundef float @llvm.minnum.f32(float %mul282.7, float 1.500000e+01), !dbg !102
  %cmp.i.i.7 = fcmp contract olt float %76, -1.260000e+02, !dbg !106
  %cond.i.i.7 = select contract i1 %cmp.i.i.7, float 6.400000e+01, float 0.000000e+00, !dbg !106
  %add.i.i667.7 = fadd contract float %76, %cond.i.i.7, !dbg !106
  %77 = tail call contract float @llvm.exp2.f32(float %add.i.i667.7), !dbg !106
  %cond2.i.i.7 = select contract i1 %cmp.i.i.7, float 0x3BF0000000000000, float 1.000000e+00, !dbg !106
  %mul.i.i.7 = fmul contract float %cond2.i.i.7, %77, !dbg !106
  %add302 = fadd contract float %mul.i.i, 0.000000e+00, !dbg !109
  %add302.1 = fadd contract float %add302, %mul.i.i.4, !dbg !109
  %add302.2 = fadd contract float %add302.1, %mul.i.i.1, !dbg !109
  %add302.3 = fadd contract float %add302.2, %mul.i.i.5, !dbg !109
  %add302.4 = fadd contract float %add302.3, %mul.i.i.2, !dbg !109
  %add302.5 = fadd contract float %add302.4, %mul.i.i.6, !dbg !109
  %add302.6 = fadd contract float %add302.5, %mul.i.i.3, !dbg !109
  %add302.7 = fadd contract float %add302.6, %mul.i.i.7, !dbg !109
  %78 = bitcast float %add302.7 to i32, !dbg !110
  %79 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !121
  %80 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %79) #11, !dbg !126
  %xor.i.i = xor i32 %80, 32, !dbg !127
  %81 = and i32 %80, -64, !dbg !128
  %and.i.i = add nsw i32 %81, 64, !dbg !128
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !129
  %cond.i.i668 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %80, !dbg !130
  %shl.i.i = shl i32 %cond.i.i668, 2, !dbg !131
  %82 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %78), !dbg !132
  %83 = bitcast i32 %82 to float, !dbg !133
  %add.i = fadd contract float %add302.7, %83, !dbg !134
  %84 = bitcast float %add.i to i32, !dbg !137
  %85 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !144
  %86 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %85) #11, !dbg !147
  %xor.i.i669 = xor i32 %86, 16, !dbg !148
  %87 = and i32 %86, -64, !dbg !149
  %and.i.i670 = add nsw i32 %87, 64, !dbg !149
  %cmp.not.i.i671 = icmp slt i32 %xor.i.i669, %and.i.i670, !dbg !150
  %cond.i.i672 = select i1 %cmp.not.i.i671, i32 %xor.i.i669, i32 %86, !dbg !151
  %shl.i.i673 = shl i32 %cond.i.i672, 2, !dbg !152
  %88 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i673, i32 %84), !dbg !153
  %89 = bitcast i32 %88 to float, !dbg !154
  %add.i.i = fadd contract float %add.i, %89, !dbg !155
  %cmp311 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !157
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !158
  %condval_8.0 = select i1 %cmp311, float %div, float 0.000000e+00, !dbg !158
  %mul324 = fmul contract float %condval_8.0, %mul.i.i, !dbg !159
  %mul324.1 = fmul contract float %condval_8.0, %mul.i.i.1, !dbg !159
  %mul324.2 = fmul contract float %condval_8.0, %mul.i.i.2, !dbg !159
  %mul324.3 = fmul contract float %condval_8.0, %mul.i.i.3, !dbg !159
  %mul324.4 = fmul contract float %condval_8.0, %mul.i.i.4, !dbg !159
  %mul324.5 = fmul contract float %condval_8.0, %mul.i.i.5, !dbg !159
  %mul324.6 = fmul contract float %condval_8.0, %mul.i.i.6, !dbg !159
  %mul324.7 = fmul contract float %condval_8.0, %mul.i.i.7, !dbg !159
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324), !dbg !160
  %91 = insertelement <4 x i16> poison, i16 %90, i64 0, !dbg !169
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324.1), !dbg !160
  %93 = insertelement <4 x i16> %91, i16 %92, i64 1, !dbg !169
  %94 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324.2), !dbg !160
  %95 = insertelement <4 x i16> %93, i16 %94, i64 2, !dbg !169
  %96 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324.3), !dbg !160
  %97 = insertelement <4 x i16> %95, i16 %96, i64 3, !dbg !169
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %97 to <4 x half>, !dbg !169
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324.4), !dbg !160
  %99 = insertelement <4 x i16> poison, i16 %98, i64 0, !dbg !169
  %100 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324.5), !dbg !160
  %101 = insertelement <4 x i16> %99, i16 %100, i64 1, !dbg !169
  %102 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324.6), !dbg !160
  %103 = insertelement <4 x i16> %101, i16 %102, i64 2, !dbg !169
  %104 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324.7), !dbg !160
  %105 = insertelement <4 x i16> %103, i16 %104, i64 3, !dbg !169
  %prob.sroa.12.14.vec.insert = bitcast <4 x i16> %105 to <4 x half>, !dbg !169
  %106 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.0.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !170, !call_argsrelate !97
  %107 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.6.0.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !170, !call_argsrelate !97
  %108 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.8.16.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !170, !call_argsrelate !97
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.12.16.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !170, !call_argsrelate !97
  %110 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.32.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !170, !call_argsrelate !97
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.18.32.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !170, !call_argsrelate !97
  %112 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.20.48.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !170, !call_argsrelate !97
  %113 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.24.48.copyload, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !170, !call_argsrelate !97
  %114 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.26.64.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %106), !dbg !170, !call_argsrelate !97
  %115 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.30.64.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %107), !dbg !170, !call_argsrelate !97
  %116 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.32.80.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %108), !dbg !170, !call_argsrelate !97
  %117 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.36.80.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %109), !dbg !170, !call_argsrelate !97
  %118 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.38.96.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %110), !dbg !170, !call_argsrelate !97
  %119 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.42.96.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %111), !dbg !170, !call_argsrelate !97
  %120 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.44.112.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %112), !dbg !170, !call_argsrelate !97
  %121 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.48.112.copyload, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %113), !dbg !170, !call_argsrelate !97
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %114, i64 0, !dbg !171
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract), !dbg !172
  %output_reg.sroa.0.0.insert.ext = zext i16 %122 to i64, !dbg !176
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %114, i64 1, !dbg !171
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract), !dbg !172
  %output_reg.sroa.0.2.insert.ext = zext i16 %123 to i64, !dbg !176
  %output_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext, 16, !dbg !176
  %output_reg.sroa.0.2.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.shift, %output_reg.sroa.0.0.insert.ext, !dbg !176
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %114, i64 2, !dbg !171
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract), !dbg !172
  %output_reg.sroa.0.4.insert.ext = zext i16 %124 to i64, !dbg !176
  %output_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext, 32, !dbg !176
  %output_reg.sroa.0.4.insert.insert1040 = or disjoint i64 %output_reg.sroa.0.2.insert.insert, %output_reg.sroa.0.4.insert.shift, !dbg !176
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %114, i64 3, !dbg !171
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract), !dbg !172
  %output_reg.sroa.0.6.insert.ext = zext i16 %125 to i64, !dbg !176
  %output_reg.sroa.0.6.insert.shift = shl nuw i64 %output_reg.sroa.0.6.insert.ext, 48, !dbg !176
  %output_reg.sroa.0.6.insert.insert = or disjoint i64 %output_reg.sroa.0.4.insert.insert1040, %output_reg.sroa.0.6.insert.shift, !dbg !176
  %out.sroa.26.16.vec.extract = extractelement <4 x float> %115, i64 0, !dbg !171
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.16.vec.extract), !dbg !172
  %output_reg.sroa.16.8.insert.ext = zext i16 %126 to i64, !dbg !176
  %out.sroa.26.20.vec.extract = extractelement <4 x float> %115, i64 1, !dbg !171
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.20.vec.extract), !dbg !172
  %output_reg.sroa.16.10.insert.ext = zext i16 %127 to i64, !dbg !176
  %output_reg.sroa.16.10.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.10.insert.ext, 16, !dbg !176
  %output_reg.sroa.16.10.insert.insert = or disjoint i64 %output_reg.sroa.16.10.insert.shift, %output_reg.sroa.16.8.insert.ext, !dbg !176
  %out.sroa.26.24.vec.extract = extractelement <4 x float> %115, i64 2, !dbg !171
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.24.vec.extract), !dbg !172
  %output_reg.sroa.16.12.insert.ext = zext i16 %128 to i64, !dbg !176
  %output_reg.sroa.16.12.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.12.insert.ext, 32, !dbg !176
  %output_reg.sroa.16.12.insert.insert1072 = or disjoint i64 %output_reg.sroa.16.10.insert.insert, %output_reg.sroa.16.12.insert.shift, !dbg !176
  %out.sroa.26.28.vec.extract = extractelement <4 x float> %115, i64 3, !dbg !171
  %129 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.28.vec.extract), !dbg !172
  %output_reg.sroa.16.14.insert.ext = zext i16 %129 to i64, !dbg !176
  %output_reg.sroa.16.14.insert.shift = shl nuw i64 %output_reg.sroa.16.14.insert.ext, 48, !dbg !176
  %output_reg.sroa.16.14.insert.insert = or disjoint i64 %output_reg.sroa.16.12.insert.insert1072, %output_reg.sroa.16.14.insert.shift, !dbg !176
  %out.sroa.50.32.vec.extract = extractelement <4 x float> %116, i64 0, !dbg !171
  %130 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.32.vec.extract), !dbg !172
  %output_reg.sroa.30.16.insert.ext = zext i16 %130 to i64, !dbg !176
  %out.sroa.50.36.vec.extract = extractelement <4 x float> %116, i64 1, !dbg !171
  %131 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.36.vec.extract), !dbg !172
  %output_reg.sroa.30.18.insert.ext = zext i16 %131 to i64, !dbg !176
  %output_reg.sroa.30.18.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.18.insert.ext, 16, !dbg !176
  %output_reg.sroa.30.18.insert.insert = or disjoint i64 %output_reg.sroa.30.18.insert.shift, %output_reg.sroa.30.16.insert.ext, !dbg !176
  %out.sroa.50.40.vec.extract = extractelement <4 x float> %116, i64 2, !dbg !171
  %132 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.40.vec.extract), !dbg !172
  %output_reg.sroa.30.20.insert.ext = zext i16 %132 to i64, !dbg !176
  %output_reg.sroa.30.20.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.20.insert.ext, 32, !dbg !176
  %output_reg.sroa.30.20.insert.insert1104 = or disjoint i64 %output_reg.sroa.30.18.insert.insert, %output_reg.sroa.30.20.insert.shift, !dbg !176
  %out.sroa.50.44.vec.extract = extractelement <4 x float> %116, i64 3, !dbg !171
  %133 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.44.vec.extract), !dbg !172
  %output_reg.sroa.30.22.insert.ext = zext i16 %133 to i64, !dbg !176
  %output_reg.sroa.30.22.insert.shift = shl nuw i64 %output_reg.sroa.30.22.insert.ext, 48, !dbg !176
  %output_reg.sroa.30.22.insert.insert = or disjoint i64 %output_reg.sroa.30.20.insert.insert1104, %output_reg.sroa.30.22.insert.shift, !dbg !176
  %out.sroa.74.48.vec.extract = extractelement <4 x float> %117, i64 0, !dbg !171
  %134 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.48.vec.extract), !dbg !172
  %output_reg.sroa.44.24.insert.ext = zext i16 %134 to i64, !dbg !176
  %out.sroa.74.52.vec.extract = extractelement <4 x float> %117, i64 1, !dbg !171
  %135 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.52.vec.extract), !dbg !172
  %output_reg.sroa.44.26.insert.ext = zext i16 %135 to i64, !dbg !176
  %output_reg.sroa.44.26.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.26.insert.ext, 16, !dbg !176
  %output_reg.sroa.44.26.insert.insert = or disjoint i64 %output_reg.sroa.44.26.insert.shift, %output_reg.sroa.44.24.insert.ext, !dbg !176
  %out.sroa.74.56.vec.extract = extractelement <4 x float> %117, i64 2, !dbg !171
  %136 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.56.vec.extract), !dbg !172
  %output_reg.sroa.44.28.insert.ext = zext i16 %136 to i64, !dbg !176
  %output_reg.sroa.44.28.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.28.insert.ext, 32, !dbg !176
  %output_reg.sroa.44.28.insert.insert1136 = or disjoint i64 %output_reg.sroa.44.26.insert.insert, %output_reg.sroa.44.28.insert.shift, !dbg !176
  %out.sroa.74.60.vec.extract = extractelement <4 x float> %117, i64 3, !dbg !171
  %137 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.60.vec.extract), !dbg !172
  %output_reg.sroa.44.30.insert.ext = zext i16 %137 to i64, !dbg !176
  %output_reg.sroa.44.30.insert.shift = shl nuw i64 %output_reg.sroa.44.30.insert.ext, 48, !dbg !176
  %output_reg.sroa.44.30.insert.insert = or disjoint i64 %output_reg.sroa.44.28.insert.insert1136, %output_reg.sroa.44.30.insert.shift, !dbg !176
  %out.sroa.98.64.vec.extract = extractelement <4 x float> %118, i64 0, !dbg !171
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.64.vec.extract), !dbg !172
  %output_reg.sroa.58.32.insert.ext = zext i16 %138 to i64, !dbg !176
  %out.sroa.98.68.vec.extract = extractelement <4 x float> %118, i64 1, !dbg !171
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.68.vec.extract), !dbg !172
  %output_reg.sroa.58.34.insert.ext = zext i16 %139 to i64, !dbg !176
  %output_reg.sroa.58.34.insert.shift = shl nuw nsw i64 %output_reg.sroa.58.34.insert.ext, 16, !dbg !176
  %output_reg.sroa.58.34.insert.insert = or disjoint i64 %output_reg.sroa.58.34.insert.shift, %output_reg.sroa.58.32.insert.ext, !dbg !176
  %out.sroa.98.72.vec.extract = extractelement <4 x float> %118, i64 2, !dbg !171
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.72.vec.extract), !dbg !172
  %output_reg.sroa.58.36.insert.ext = zext i16 %140 to i64, !dbg !176
  %output_reg.sroa.58.36.insert.shift = shl nuw nsw i64 %output_reg.sroa.58.36.insert.ext, 32, !dbg !176
  %output_reg.sroa.58.36.insert.insert1168 = or disjoint i64 %output_reg.sroa.58.34.insert.insert, %output_reg.sroa.58.36.insert.shift, !dbg !176
  %out.sroa.98.76.vec.extract = extractelement <4 x float> %118, i64 3, !dbg !171
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.76.vec.extract), !dbg !172
  %output_reg.sroa.58.38.insert.ext = zext i16 %141 to i64, !dbg !176
  %output_reg.sroa.58.38.insert.shift = shl nuw i64 %output_reg.sroa.58.38.insert.ext, 48, !dbg !176
  %output_reg.sroa.58.38.insert.insert = or disjoint i64 %output_reg.sroa.58.36.insert.insert1168, %output_reg.sroa.58.38.insert.shift, !dbg !176
  %out.sroa.122.80.vec.extract = extractelement <4 x float> %119, i64 0, !dbg !171
  %142 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.80.vec.extract), !dbg !172
  %output_reg.sroa.72.40.insert.ext = zext i16 %142 to i64, !dbg !176
  %out.sroa.122.84.vec.extract = extractelement <4 x float> %119, i64 1, !dbg !171
  %143 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.84.vec.extract), !dbg !172
  %output_reg.sroa.72.42.insert.ext = zext i16 %143 to i64, !dbg !176
  %output_reg.sroa.72.42.insert.shift = shl nuw nsw i64 %output_reg.sroa.72.42.insert.ext, 16, !dbg !176
  %output_reg.sroa.72.42.insert.insert = or disjoint i64 %output_reg.sroa.72.42.insert.shift, %output_reg.sroa.72.40.insert.ext, !dbg !176
  %out.sroa.122.88.vec.extract = extractelement <4 x float> %119, i64 2, !dbg !171
  %144 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.88.vec.extract), !dbg !172
  %output_reg.sroa.72.44.insert.ext = zext i16 %144 to i64, !dbg !176
  %output_reg.sroa.72.44.insert.shift = shl nuw nsw i64 %output_reg.sroa.72.44.insert.ext, 32, !dbg !176
  %output_reg.sroa.72.44.insert.insert1200 = or disjoint i64 %output_reg.sroa.72.42.insert.insert, %output_reg.sroa.72.44.insert.shift, !dbg !176
  %out.sroa.122.92.vec.extract = extractelement <4 x float> %119, i64 3, !dbg !171
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.92.vec.extract), !dbg !172
  %output_reg.sroa.72.46.insert.ext = zext i16 %145 to i64, !dbg !176
  %output_reg.sroa.72.46.insert.shift = shl nuw i64 %output_reg.sroa.72.46.insert.ext, 48, !dbg !176
  %output_reg.sroa.72.46.insert.insert = or disjoint i64 %output_reg.sroa.72.44.insert.insert1200, %output_reg.sroa.72.46.insert.shift, !dbg !176
  %out.sroa.146.96.vec.extract = extractelement <4 x float> %120, i64 0, !dbg !171
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.96.vec.extract), !dbg !172
  %output_reg.sroa.86.48.insert.ext = zext i16 %146 to i64, !dbg !176
  %out.sroa.146.100.vec.extract = extractelement <4 x float> %120, i64 1, !dbg !171
  %147 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.100.vec.extract), !dbg !172
  %output_reg.sroa.86.50.insert.ext = zext i16 %147 to i64, !dbg !176
  %output_reg.sroa.86.50.insert.shift = shl nuw nsw i64 %output_reg.sroa.86.50.insert.ext, 16, !dbg !176
  %output_reg.sroa.86.50.insert.insert = or disjoint i64 %output_reg.sroa.86.50.insert.shift, %output_reg.sroa.86.48.insert.ext, !dbg !176
  %out.sroa.146.104.vec.extract = extractelement <4 x float> %120, i64 2, !dbg !171
  %148 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.104.vec.extract), !dbg !172
  %output_reg.sroa.86.52.insert.ext = zext i16 %148 to i64, !dbg !176
  %output_reg.sroa.86.52.insert.shift = shl nuw nsw i64 %output_reg.sroa.86.52.insert.ext, 32, !dbg !176
  %output_reg.sroa.86.52.insert.insert1232 = or disjoint i64 %output_reg.sroa.86.50.insert.insert, %output_reg.sroa.86.52.insert.shift, !dbg !176
  %out.sroa.146.108.vec.extract = extractelement <4 x float> %120, i64 3, !dbg !171
  %149 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.108.vec.extract), !dbg !172
  %output_reg.sroa.86.54.insert.ext = zext i16 %149 to i64, !dbg !176
  %output_reg.sroa.86.54.insert.shift = shl nuw i64 %output_reg.sroa.86.54.insert.ext, 48, !dbg !176
  %output_reg.sroa.86.54.insert.insert = or disjoint i64 %output_reg.sroa.86.52.insert.insert1232, %output_reg.sroa.86.54.insert.shift, !dbg !176
  %out.sroa.170.112.vec.extract = extractelement <4 x float> %121, i64 0, !dbg !171
  %150 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.112.vec.extract), !dbg !172
  %output_reg.sroa.100.56.insert.ext = zext i16 %150 to i64, !dbg !176
  %out.sroa.170.116.vec.extract = extractelement <4 x float> %121, i64 1, !dbg !171
  %151 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.116.vec.extract), !dbg !172
  %output_reg.sroa.100.58.insert.ext = zext i16 %151 to i64, !dbg !176
  %output_reg.sroa.100.58.insert.shift = shl nuw nsw i64 %output_reg.sroa.100.58.insert.ext, 16, !dbg !176
  %output_reg.sroa.100.58.insert.insert = or disjoint i64 %output_reg.sroa.100.58.insert.shift, %output_reg.sroa.100.56.insert.ext, !dbg !176
  %out.sroa.170.120.vec.extract = extractelement <4 x float> %121, i64 2, !dbg !171
  %152 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.120.vec.extract), !dbg !172
  %output_reg.sroa.100.60.insert.ext = zext i16 %152 to i64, !dbg !176
  %output_reg.sroa.100.60.insert.shift = shl nuw nsw i64 %output_reg.sroa.100.60.insert.ext, 32, !dbg !176
  %output_reg.sroa.100.60.insert.insert1264 = or disjoint i64 %output_reg.sroa.100.58.insert.insert, %output_reg.sroa.100.60.insert.shift, !dbg !176
  %out.sroa.170.124.vec.extract = extractelement <4 x float> %121, i64 3, !dbg !171
  %153 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.124.vec.extract), !dbg !172
  %output_reg.sroa.100.62.insert.ext = zext i16 %153 to i64, !dbg !176
  %output_reg.sroa.100.62.insert.shift = shl nuw i64 %output_reg.sroa.100.62.insert.ext, 48, !dbg !176
  %output_reg.sroa.100.62.insert.insert = or disjoint i64 %output_reg.sroa.100.60.insert.insert1264, %output_reg.sroa.100.62.insert.shift, !dbg !176
  br label %if.end441, !dbg !64

if.end441:                                        ; preds = %for.body421.preheader, %for.body96.preheader
  %add456.7.pre-phi = phi i32 [ %.pre1694, %for.body421.preheader ], [ %add138.7, %for.body96.preheader ], !dbg !63
  %add456.6.pre-phi = phi i32 [ %.pre1693, %for.body421.preheader ], [ %add138.6, %for.body96.preheader ], !dbg !63
  %add456.5.pre-phi = phi i32 [ %.pre1692, %for.body421.preheader ], [ %add138.5, %for.body96.preheader ], !dbg !63
  %add456.4.pre-phi = phi i32 [ %.pre1691, %for.body421.preheader ], [ %add138.4, %for.body96.preheader ], !dbg !63
  %add456.3.pre-phi = phi i32 [ %.pre1690, %for.body421.preheader ], [ %add138.3, %for.body96.preheader ], !dbg !63
  %add456.2.pre-phi = phi i32 [ %.pre1689, %for.body421.preheader ], [ %add138.2, %for.body96.preheader ], !dbg !63
  %add456.1.pre-phi = phi i32 [ %.pre, %for.body421.preheader ], [ %add138.1, %for.body96.preheader ], !dbg !63
  %k.sroa.48.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.48.112.copyload, %for.body96.preheader ]
  %k.sroa.44.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.44.112.copyload, %for.body96.preheader ]
  %k.sroa.42.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.42.96.copyload, %for.body96.preheader ]
  %k.sroa.38.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.38.96.copyload, %for.body96.preheader ]
  %k.sroa.36.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.36.80.copyload, %for.body96.preheader ]
  %k.sroa.32.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.32.80.copyload, %for.body96.preheader ]
  %k.sroa.30.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.30.64.copyload, %for.body96.preheader ]
  %k.sroa.26.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.26.64.copyload, %for.body96.preheader ]
  %k.sroa.24.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.24.48.copyload, %for.body96.preheader ]
  %k.sroa.20.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.20.48.copyload, %for.body96.preheader ]
  %k.sroa.18.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.18.32.copyload, %for.body96.preheader ]
  %k.sroa.14.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.14.32.copyload, %for.body96.preheader ]
  %k.sroa.12.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.12.16.copyload, %for.body96.preheader ]
  %k.sroa.8.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.8.16.copyload, %for.body96.preheader ]
  %k.sroa.6.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.6.0.copyload, %for.body96.preheader ]
  %k.sroa.0.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %k.sroa.0.0.copyload, %for.body96.preheader ]
  %v.sroa.48.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.48.112.copyload, %for.body96.preheader ]
  %v.sroa.44.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.44.112.copyload, %for.body96.preheader ]
  %v.sroa.42.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.42.96.copyload, %for.body96.preheader ]
  %v.sroa.38.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.38.96.copyload, %for.body96.preheader ]
  %v.sroa.36.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.36.80.copyload, %for.body96.preheader ]
  %v.sroa.32.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.32.80.copyload, %for.body96.preheader ]
  %v.sroa.30.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.30.64.copyload, %for.body96.preheader ]
  %v.sroa.26.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.26.64.copyload, %for.body96.preheader ]
  %v.sroa.24.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.24.48.copyload, %for.body96.preheader ]
  %v.sroa.20.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.20.48.copyload, %for.body96.preheader ]
  %v.sroa.18.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.18.32.copyload, %for.body96.preheader ]
  %v.sroa.14.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.14.32.copyload, %for.body96.preheader ]
  %v.sroa.12.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.12.16.copyload, %for.body96.preheader ]
  %v.sroa.8.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.8.16.copyload, %for.body96.preheader ]
  %v.sroa.6.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.6.0.copyload, %for.body96.preheader ]
  %v.sroa.0.1 = phi <4 x half> [ undef, %for.body421.preheader ], [ %v.sroa.0.0.copyload, %for.body96.preheader ]
  %output_reg.sroa.100.0 = phi i64 [ 0, %for.body421.preheader ], [ %output_reg.sroa.100.62.insert.insert, %for.body96.preheader ], !dbg !73
  %output_reg.sroa.86.0 = phi i64 [ 0, %for.body421.preheader ], [ %output_reg.sroa.86.54.insert.insert, %for.body96.preheader ], !dbg !73
  %output_reg.sroa.72.0 = phi i64 [ 0, %for.body421.preheader ], [ %output_reg.sroa.72.46.insert.insert, %for.body96.preheader ], !dbg !73
  %output_reg.sroa.58.0 = phi i64 [ 0, %for.body421.preheader ], [ %output_reg.sroa.58.38.insert.insert, %for.body96.preheader ], !dbg !73
  %output_reg.sroa.44.0 = phi i64 [ 0, %for.body421.preheader ], [ %output_reg.sroa.44.30.insert.insert, %for.body96.preheader ], !dbg !73
  %output_reg.sroa.30.0 = phi i64 [ 0, %for.body421.preheader ], [ %output_reg.sroa.30.22.insert.insert, %for.body96.preheader ], !dbg !73
  %output_reg.sroa.16.0 = phi i64 [ 0, %for.body421.preheader ], [ %output_reg.sroa.16.14.insert.insert, %for.body96.preheader ], !dbg !73
  %output_reg.sroa.0.0 = phi i64 [ 0, %for.body421.preheader ], [ %output_reg.sroa.0.6.insert.insert, %for.body96.preheader ], !dbg !73
  fence syncscope("warp") release, !dbg !64
  tail call void @llvm.mxc.barrier.warp(), !dbg !177
  fence syncscope("warp") acquire, !dbg !178
  %xor459 = xor i32 %shr137, %and163, !dbg !179
  %mul460 = shl nuw nsw i32 %xor459, 3, !dbg !180
  %add461 = add nuw nsw i32 %mul460, %mul157, !dbg !181
  %add466 = or disjoint i32 %add461, %mul465, !dbg !182
  %add.ptr468 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466, !dbg !183
  store i64 %output_reg.sroa.0.0, ptr addrspace(3) %add.ptr468, align 8, !dbg !184
  %xor459.1 = xor i32 %add456.1.pre-phi, %and163, !dbg !179
  %mul460.1 = shl nuw nsw i32 %xor459.1, 3, !dbg !180
  %add461.1 = add nuw nsw i32 %mul460.1, %mul157, !dbg !181
  %add466.1 = or disjoint i32 %add461.1, %mul465, !dbg !182
  %add.ptr468.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.1, !dbg !183
  store i64 %output_reg.sroa.16.0, ptr addrspace(3) %add.ptr468.1, align 8, !dbg !184
  %xor459.2 = xor i32 %add456.2.pre-phi, %and163, !dbg !179
  %mul460.2 = shl nuw nsw i32 %xor459.2, 3, !dbg !180
  %add461.2 = add nuw nsw i32 %mul460.2, %mul157, !dbg !181
  %add466.2 = or disjoint i32 %add461.2, %mul465, !dbg !182
  %add.ptr468.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.2, !dbg !183
  store i64 %output_reg.sroa.30.0, ptr addrspace(3) %add.ptr468.2, align 8, !dbg !184
  %xor459.3 = xor i32 %add456.3.pre-phi, %and163, !dbg !179
  %mul460.3 = shl nuw nsw i32 %xor459.3, 3, !dbg !180
  %add461.3 = add nuw nsw i32 %mul460.3, %mul157, !dbg !181
  %add466.3 = or disjoint i32 %add461.3, %mul465, !dbg !182
  %add.ptr468.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.3, !dbg !183
  store i64 %output_reg.sroa.44.0, ptr addrspace(3) %add.ptr468.3, align 8, !dbg !184
  %xor459.4 = xor i32 %add456.4.pre-phi, %and163, !dbg !179
  %mul460.4 = shl nuw nsw i32 %xor459.4, 3, !dbg !180
  %add461.4 = add nuw nsw i32 %mul460.4, %mul157, !dbg !181
  %add466.4 = or disjoint i32 %add461.4, %mul465, !dbg !182
  %add.ptr468.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.4, !dbg !183
  store i64 %output_reg.sroa.58.0, ptr addrspace(3) %add.ptr468.4, align 8, !dbg !184
  %xor459.5 = xor i32 %add456.5.pre-phi, %and163, !dbg !179
  %mul460.5 = shl nuw nsw i32 %xor459.5, 3, !dbg !180
  %add461.5 = add nuw nsw i32 %mul460.5, %mul157, !dbg !181
  %add466.5 = or disjoint i32 %add461.5, %mul465, !dbg !182
  %add.ptr468.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.5, !dbg !183
  store i64 %output_reg.sroa.72.0, ptr addrspace(3) %add.ptr468.5, align 8, !dbg !184
  %xor459.6 = xor i32 %add456.6.pre-phi, %and163, !dbg !179
  %mul460.6 = shl nuw nsw i32 %xor459.6, 3, !dbg !180
  %add461.6 = add nuw nsw i32 %mul460.6, %mul157, !dbg !181
  %add466.6 = or disjoint i32 %add461.6, %mul465, !dbg !182
  %add.ptr468.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.6, !dbg !183
  store i64 %output_reg.sroa.86.0, ptr addrspace(3) %add.ptr468.6, align 8, !dbg !184
  %xor459.7 = xor i32 %add456.7.pre-phi, %and163, !dbg !179
  %mul460.7 = shl nuw nsw i32 %xor459.7, 3, !dbg !180
  %add461.7 = add nuw nsw i32 %mul460.7, %mul157, !dbg !181
  %add466.7 = or disjoint i32 %add461.7, %mul465, !dbg !182
  %add.ptr468.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.7, !dbg !183
  store i64 %output_reg.sroa.100.0, ptr addrspace(3) %add.ptr468.7, align 8, !dbg !184
  fence syncscope("warp") release, !dbg !185
  tail call void @llvm.mxc.barrier.warp(), !dbg !188
  fence syncscope("warp") acquire, !dbg !189
  br i1 %cmp42, label %if.end485, label %if.end518.3, !dbg !190

if.end485:                                        ; preds = %if.end441
  %mul509 = shl nuw nsw i32 %6, 11
  %add512 = add nuw nsw i32 %add510, %mul509
  %154 = zext nneg i32 %add512 to i64, !dbg !191
  %xor501 = xor i32 %shr160, %and163, !dbg !192
  %add.ptr505.idx = shl nuw nsw i32 %xor501, 4, !dbg !193
  %add.ptr505 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep711, i32 %add.ptr505.idx, !dbg !193
  %add.ptr517 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %154, !dbg !194
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr517, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr505, i64 16, i1 false), !dbg !195, !tbaa.struct !196, !call_argsrelate !197
  %155 = add nuw nsw i32 %shr160, 4, !dbg !198
  %xor501.1 = xor i32 %155, %and163, !dbg !192
  %gep712.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep711, i32 1024, !dbg !193
  %add.ptr505.idx.1 = shl nuw nsw i32 %xor501.1, 4, !dbg !193
  %add.ptr505.1 = getelementptr inbounds i8, ptr addrspace(3) %gep712.1, i32 %add.ptr505.idx.1, !dbg !193
  %156 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %154, !dbg !194
  %add.ptr517.1 = getelementptr inbounds i8, ptr addrspace(1) %156, i64 1024, !dbg !194
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr517.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr505.1, i64 16, i1 false), !dbg !195, !tbaa.struct !196, !call_argsrelate !197
  %157 = add nuw nsw i32 %shr160, 8, !dbg !198
  %xor501.2 = xor i32 %157, %and163, !dbg !192
  %gep712.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep711, i32 2048, !dbg !193
  %add.ptr505.idx.2 = shl nuw nsw i32 %xor501.2, 4, !dbg !193
  %add.ptr505.2 = getelementptr inbounds i8, ptr addrspace(3) %gep712.2, i32 %add.ptr505.idx.2, !dbg !193
  %158 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %154, !dbg !194
  %add.ptr517.2 = getelementptr inbounds i8, ptr addrspace(1) %158, i64 2048, !dbg !194
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr517.2, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr505.2, i64 16, i1 false), !dbg !195, !tbaa.struct !196, !call_argsrelate !197
  %159 = add nuw nsw i32 %shr160, 12, !dbg !198
  %xor501.3 = xor i32 %159, %and163, !dbg !192
  %gep712.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep711, i32 3072, !dbg !193
  %add.ptr505.idx.3 = shl nuw nsw i32 %xor501.3, 4, !dbg !193
  %add.ptr505.3 = getelementptr inbounds i8, ptr addrspace(3) %gep712.3, i32 %add.ptr505.idx.3, !dbg !193
  %160 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %154, !dbg !194
  %add.ptr517.3 = getelementptr inbounds i8, ptr addrspace(1) %160, i64 3072, !dbg !194
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr517.3, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr505.3, i64 16, i1 false), !dbg !195, !tbaa.struct !196, !call_argsrelate !197
  br label %if.end518.3, !dbg !199

if.end518.3:                                      ; preds = %if.end441, %if.end485
  fence syncscope("warp") release, !dbg !200
  tail call void @llvm.mxc.barrier.warp(), !dbg !203
  fence syncscope("warp") acquire, !dbg !204
  br label %if.end522, !dbg !205

if.end522:                                        ; preds = %if.end518.3, %if.then
  %k.sroa.48.2 = phi <4 x half> [ %k.sroa.48.1, %if.end518.3 ], [ undef, %if.then ]
  %k.sroa.44.2 = phi <4 x half> [ %k.sroa.44.1, %if.end518.3 ], [ undef, %if.then ]
  %k.sroa.42.2 = phi <4 x half> [ %k.sroa.42.1, %if.end518.3 ], [ undef, %if.then ]
  %k.sroa.38.2 = phi <4 x half> [ %k.sroa.38.1, %if.end518.3 ], [ undef, %if.then ]
  %k.sroa.36.2 = phi <4 x half> [ %k.sroa.36.1, %if.end518.3 ], [ undef, %if.then ]
  %k.sroa.32.2 = phi <4 x half> [ %k.sroa.32.1, %if.end518.3 ], [ undef, %if.then ]
  %k.sroa.30.2 = phi <4 x half> [ %k.sroa.30.1, %if.end518.3 ], [ undef, %if.then ]
  %k.sroa.26.2 = phi <4 x half> [ %k.sroa.26.1, %if.end518.3 ], [ undef, %if.then ]
  %k.sroa.24.2 = phi <4 x half> [ %k.sroa.24.1, %if.end518.3 ], [ undef, %if.then ]
  %k.sroa.20.2 = phi <4 x half> [ %k.sroa.20.1, %if.end518.3 ], [ undef, %if.then ]
  %k.sroa.18.2 = phi <4 x half> [ %k.sroa.18.1, %if.end518.3 ], [ undef, %if.then ]
  %k.sroa.14.2 = phi <4 x half> [ %k.sroa.14.1, %if.end518.3 ], [ undef, %if.then ]
  %k.sroa.12.2 = phi <4 x half> [ %k.sroa.12.1, %if.end518.3 ], [ undef, %if.then ]
  %k.sroa.8.2 = phi <4 x half> [ %k.sroa.8.1, %if.end518.3 ], [ undef, %if.then ]
  %k.sroa.6.2 = phi <4 x half> [ %k.sroa.6.1, %if.end518.3 ], [ undef, %if.then ]
  %k.sroa.0.2 = phi <4 x half> [ %k.sroa.0.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.48.2 = phi <4 x half> [ %v.sroa.48.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.44.2 = phi <4 x half> [ %v.sroa.44.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.42.2 = phi <4 x half> [ %v.sroa.42.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.38.2 = phi <4 x half> [ %v.sroa.38.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.36.2 = phi <4 x half> [ %v.sroa.36.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.32.2 = phi <4 x half> [ %v.sroa.32.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.30.2 = phi <4 x half> [ %v.sroa.30.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.26.2 = phi <4 x half> [ %v.sroa.26.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.24.2 = phi <4 x half> [ %v.sroa.24.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.20.2 = phi <4 x half> [ %v.sroa.20.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.18.2 = phi <4 x half> [ %v.sroa.18.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.14.2 = phi <4 x half> [ %v.sroa.14.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.12.2 = phi <4 x half> [ %v.sroa.12.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.8.2 = phi <4 x half> [ %v.sroa.8.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.6.2 = phi <4 x half> [ %v.sroa.6.1, %if.end518.3 ], [ undef, %if.then ]
  %v.sroa.0.2 = phi <4 x half> [ %v.sroa.0.1, %if.end518.3 ], [ undef, %if.then ]
  %cmp32.1 = icmp sgt i32 %7, -1, !dbg !60
  br i1 %cmp32.1, label %for.cond34.preheader.1, label %if.end526, !dbg !61

for.cond34.preheader.1:                           ; preds = %if.end522
  %cmp42.1 = icmp ult i32 %7, 1024
  %condval_4.0.1 = zext nneg i32 %7 to i64
  br i1 %cmp42.1, label %if.then43.1760, label %if.end79.1764, !dbg !62

if.then43.1760:                                   ; preds = %for.cond34.preheader.1
  %.idx718.1755 = shl nuw nsw i64 %condval_4.0.1, 12, !dbg !70
  %161 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718.1755, !dbg !70
  %.idx719.1756 = shl nuw nsw i64 %shr, 22, !dbg !70
  %162 = getelementptr i8, ptr addrspace(4) %161, i64 %.idx719.1756, !dbg !70
  %condval_1.sroa.0.0.copyload.1757 = load i32, ptr addrspace(4) %162, align 8, !dbg !71, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.1758 = getelementptr inbounds i8, ptr addrspace(4) %162, i64 4, !dbg !71
  %condval_1.sroa.5.0.copyload.1759 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.1758, align 4, !dbg !71, !tbaa !30
  %163 = zext i32 %condval_1.sroa.0.0.copyload.1757 to i64, !dbg !74
  %164 = zext i32 %condval_1.sroa.5.0.copyload.1759 to i64, !dbg !74
  %165 = shl nuw i64 %164, 32, !dbg !74
  %166 = or disjoint i64 %165, %163, !dbg !72
  br label %if.end79.1764, !dbg !72

if.end79.1764:                                    ; preds = %if.then43.1760, %for.cond34.preheader.1
  %q_stage.sroa.0.4.insert.insert1618 = phi i64 [ %166, %if.then43.1760 ], [ 0, %for.cond34.preheader.1 ], !dbg !74
  br i1 %cmp42.1, label %if.then43.1.1, label %if.end79.1.1, !dbg !62

if.then43.1.1:                                    ; preds = %if.end79.1764
  %.idx718.1.1 = shl nuw nsw i64 %condval_4.0.1, 12, !dbg !70
  %167 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718.1.1, !dbg !70
  %.idx719.1.1 = shl nuw nsw i64 %shr, 22, !dbg !70
  %168 = getelementptr i8, ptr addrspace(4) %167, i64 %.idx719.1.1, !dbg !70
  %gep.1.1 = getelementptr i8, ptr addrspace(4) %168, i64 512, !dbg !70
  %condval_1.sroa.0.0.copyload.1.1 = load i32, ptr addrspace(4) %gep.1.1, align 8, !dbg !71, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.1.1 = getelementptr i8, ptr addrspace(4) %168, i64 516, !dbg !71
  %condval_1.sroa.5.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.1.1, align 4, !dbg !71, !tbaa !30
  %169 = zext i32 %condval_1.sroa.0.0.copyload.1.1 to i64, !dbg !74
  %170 = zext i32 %condval_1.sroa.5.0.copyload.1.1 to i64, !dbg !74
  %171 = shl nuw i64 %170, 32, !dbg !74
  %172 = or disjoint i64 %171, %169, !dbg !72
  br label %if.end79.1.1, !dbg !72

if.end79.1.1:                                     ; preds = %if.then43.1.1, %if.end79.1764
  %q_stage.sroa.8.12.insert.insert1628 = phi i64 [ %172, %if.then43.1.1 ], [ 0, %if.end79.1764 ], !dbg !74
  br i1 %cmp42.1, label %if.then43.2.1, label %if.end79.2.1, !dbg !62

if.then43.2.1:                                    ; preds = %if.end79.1.1
  %.idx718.2.1 = shl nuw nsw i64 %condval_4.0.1, 12, !dbg !70
  %173 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718.2.1, !dbg !70
  %.idx719.2.1 = shl nuw nsw i64 %shr, 22, !dbg !70
  %174 = getelementptr i8, ptr addrspace(4) %173, i64 %.idx719.2.1, !dbg !70
  %gep.2.1 = getelementptr i8, ptr addrspace(4) %174, i64 1024, !dbg !70
  %condval_1.sroa.0.0.copyload.2.1 = load i32, ptr addrspace(4) %gep.2.1, align 8, !dbg !71, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.2.1 = getelementptr i8, ptr addrspace(4) %174, i64 1028, !dbg !71
  %condval_1.sroa.5.0.copyload.2.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.2.1, align 4, !dbg !71, !tbaa !30
  %175 = zext i32 %condval_1.sroa.0.0.copyload.2.1 to i64, !dbg !74
  %176 = zext i32 %condval_1.sroa.5.0.copyload.2.1 to i64, !dbg !74
  %177 = shl nuw i64 %176, 32, !dbg !74
  %178 = or disjoint i64 %177, %175, !dbg !72
  br label %if.end79.2.1, !dbg !72

if.end79.2.1:                                     ; preds = %if.then43.2.1, %if.end79.1.1
  %q_stage.sroa.14.20.insert.insert1638 = phi i64 [ %178, %if.then43.2.1 ], [ 0, %if.end79.1.1 ], !dbg !74
  br i1 %cmp42.1, label %if.then43.3.1, label %if.end79.3.1, !dbg !62

if.then43.3.1:                                    ; preds = %if.end79.2.1
  %.idx718.3.1 = shl nuw nsw i64 %condval_4.0.1, 12, !dbg !70
  %179 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718.3.1, !dbg !70
  %.idx719.3.1 = shl nuw nsw i64 %shr, 22, !dbg !70
  %180 = getelementptr i8, ptr addrspace(4) %179, i64 %.idx719.3.1, !dbg !70
  %gep.3.1 = getelementptr i8, ptr addrspace(4) %180, i64 1536, !dbg !70
  %condval_1.sroa.0.0.copyload.3.1 = load i32, ptr addrspace(4) %gep.3.1, align 8, !dbg !71, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.3.1 = getelementptr i8, ptr addrspace(4) %180, i64 1540, !dbg !71
  %condval_1.sroa.5.0.copyload.3.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.3.1, align 4, !dbg !71, !tbaa !30
  %181 = zext i32 %condval_1.sroa.0.0.copyload.3.1 to i64, !dbg !74
  %182 = zext i32 %condval_1.sroa.5.0.copyload.3.1 to i64, !dbg !74
  %183 = shl nuw i64 %182, 32, !dbg !74
  %184 = or disjoint i64 %183, %181, !dbg !72
  br label %if.end79.3.1, !dbg !72

if.end79.3.1:                                     ; preds = %if.then43.3.1, %if.end79.2.1
  %q_stage.sroa.20.28.insert.insert1648 = phi i64 [ %184, %if.then43.3.1 ], [ 0, %if.end79.2.1 ], !dbg !74
  br i1 %cmp42.1, label %if.then43.4.1, label %if.end79.4.1, !dbg !62

if.then43.4.1:                                    ; preds = %if.end79.3.1
  %.idx718.4.1 = shl nuw nsw i64 %condval_4.0.1, 12, !dbg !70
  %185 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718.4.1, !dbg !70
  %.idx719.4.1 = shl nuw nsw i64 %shr, 22, !dbg !70
  %186 = getelementptr i8, ptr addrspace(4) %185, i64 %.idx719.4.1, !dbg !70
  %gep.4.1 = getelementptr i8, ptr addrspace(4) %186, i64 2048, !dbg !70
  %condval_1.sroa.0.0.copyload.4.1 = load i32, ptr addrspace(4) %gep.4.1, align 8, !dbg !71, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.4.1 = getelementptr i8, ptr addrspace(4) %186, i64 2052, !dbg !71
  %condval_1.sroa.5.0.copyload.4.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.4.1, align 4, !dbg !71, !tbaa !30
  %187 = zext i32 %condval_1.sroa.0.0.copyload.4.1 to i64, !dbg !74
  %188 = zext i32 %condval_1.sroa.5.0.copyload.4.1 to i64, !dbg !74
  %189 = shl nuw i64 %188, 32, !dbg !74
  %190 = or disjoint i64 %189, %187, !dbg !72
  br label %if.end79.4.1, !dbg !72

if.end79.4.1:                                     ; preds = %if.then43.4.1, %if.end79.3.1
  %q_stage.sroa.26.36.insert.insert1658 = phi i64 [ %190, %if.then43.4.1 ], [ 0, %if.end79.3.1 ], !dbg !74
  br i1 %cmp42.1, label %if.then43.5.1, label %if.end79.5.1, !dbg !62

if.then43.5.1:                                    ; preds = %if.end79.4.1
  %.idx718.5.1 = shl nuw nsw i64 %condval_4.0.1, 12, !dbg !70
  %191 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718.5.1, !dbg !70
  %.idx719.5.1 = shl nuw nsw i64 %shr, 22, !dbg !70
  %192 = getelementptr i8, ptr addrspace(4) %191, i64 %.idx719.5.1, !dbg !70
  %gep.5.1 = getelementptr i8, ptr addrspace(4) %192, i64 2560, !dbg !70
  %condval_1.sroa.0.0.copyload.5.1 = load i32, ptr addrspace(4) %gep.5.1, align 8, !dbg !71, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.5.1 = getelementptr i8, ptr addrspace(4) %192, i64 2564, !dbg !71
  %condval_1.sroa.5.0.copyload.5.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.5.1, align 4, !dbg !71, !tbaa !30
  %193 = zext i32 %condval_1.sroa.0.0.copyload.5.1 to i64, !dbg !74
  %194 = zext i32 %condval_1.sroa.5.0.copyload.5.1 to i64, !dbg !74
  %195 = shl nuw i64 %194, 32, !dbg !74
  %196 = or disjoint i64 %195, %193, !dbg !72
  br label %if.end79.5.1, !dbg !72

if.end79.5.1:                                     ; preds = %if.then43.5.1, %if.end79.4.1
  %q_stage.sroa.32.44.insert.insert1668 = phi i64 [ %196, %if.then43.5.1 ], [ 0, %if.end79.4.1 ], !dbg !74
  br i1 %cmp42.1, label %if.then43.6.1, label %if.end79.6.1, !dbg !62

if.then43.6.1:                                    ; preds = %if.end79.5.1
  %.idx718.6.1 = shl nuw nsw i64 %condval_4.0.1, 12, !dbg !70
  %197 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718.6.1, !dbg !70
  %.idx719.6.1 = shl nuw nsw i64 %shr, 22, !dbg !70
  %198 = getelementptr i8, ptr addrspace(4) %197, i64 %.idx719.6.1, !dbg !70
  %gep.6.1 = getelementptr i8, ptr addrspace(4) %198, i64 3072, !dbg !70
  %condval_1.sroa.0.0.copyload.6.1 = load i32, ptr addrspace(4) %gep.6.1, align 8, !dbg !71, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.6.1 = getelementptr i8, ptr addrspace(4) %198, i64 3076, !dbg !71
  %condval_1.sroa.5.0.copyload.6.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.6.1, align 4, !dbg !71, !tbaa !30
  %199 = zext i32 %condval_1.sroa.0.0.copyload.6.1 to i64, !dbg !74
  %200 = zext i32 %condval_1.sroa.5.0.copyload.6.1 to i64, !dbg !74
  %201 = shl nuw i64 %200, 32, !dbg !74
  %202 = or disjoint i64 %201, %199, !dbg !72
  br label %if.end79.6.1, !dbg !72

if.end79.6.1:                                     ; preds = %if.then43.6.1, %if.end79.5.1
  %q_stage.sroa.38.52.insert.insert1678 = phi i64 [ %202, %if.then43.6.1 ], [ 0, %if.end79.5.1 ], !dbg !74
  br i1 %cmp42.1, label %if.then43.7.1, label %if.end79.7.1, !dbg !62

if.then43.7.1:                                    ; preds = %if.end79.6.1
  %.idx718.7.1 = shl nuw nsw i64 %condval_4.0.1, 12, !dbg !70
  %203 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx718.7.1, !dbg !70
  %.idx719.7.1 = shl nuw nsw i64 %shr, 22, !dbg !70
  %204 = getelementptr i8, ptr addrspace(4) %203, i64 %.idx719.7.1, !dbg !70
  %gep.7.1 = getelementptr i8, ptr addrspace(4) %204, i64 3584, !dbg !70
  %condval_1.sroa.0.0.copyload.7.1 = load i32, ptr addrspace(4) %gep.7.1, align 8, !dbg !71, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.7.1 = getelementptr i8, ptr addrspace(4) %204, i64 3588, !dbg !71
  %condval_1.sroa.5.0.copyload.7.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.7.1, align 4, !dbg !71, !tbaa !30
  %205 = zext i32 %condval_1.sroa.0.0.copyload.7.1 to i64, !dbg !74
  %206 = zext i32 %condval_1.sroa.5.0.copyload.7.1 to i64, !dbg !74
  %207 = shl nuw i64 %206, 32, !dbg !74
  %208 = or disjoint i64 %207, %205, !dbg !72
  br label %if.end79.7.1, !dbg !72

if.end79.7.1:                                     ; preds = %if.then43.7.1, %if.end79.6.1
  %q_stage.sroa.44.60.insert.insert1688 = phi i64 [ %208, %if.then43.7.1 ], [ 0, %if.end79.6.1 ], !dbg !74
  %cmp89.1 = icmp sle i32 %mul88, %7
  %or.cond717.1 = select i1 %cmp87, i1 %cmp89.1, i1 false, !dbg !75
  br i1 %or.cond717.1, label %if.end119.1, label %for.body421.preheader.1, !dbg !75

for.body421.preheader.1:                          ; preds = %if.end79.7.1
  %.pre1695 = add nuw nsw i32 %shr137, 2, !dbg !63
  %.pre1696 = add nuw nsw i32 %shr137, 4, !dbg !63
  %.pre1697 = add nuw nsw i32 %shr137, 6, !dbg !63
  %.pre1698 = add nuw nsw i32 %shr137, 8, !dbg !63
  %.pre1699 = add nuw nsw i32 %shr137, 10, !dbg !63
  %.pre1700 = add nuw nsw i32 %shr137, 12, !dbg !63
  %.pre1701 = add nuw nsw i32 %shr137, 14, !dbg !63
  br label %if.end441.1, !dbg !64

if.end119.1:                                      ; preds = %if.end79.7.1
  %xor.1767 = xor i32 %shr137, %shr134, !dbg !78
  %209 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %add132, !dbg !79
  %gep684.idx.1768 = shl nuw nsw i32 %xor.1767, 4, !dbg !79
  %gep684.1769 = getelementptr inbounds i8, ptr addrspace(3) %209, i32 %gep684.idx.1768, !dbg !79
  store i64 %q_stage.sroa.0.4.insert.insert1618, ptr addrspace(3) %gep684.1769, align 8, !dbg !80
  %add138.1.1 = add nuw nsw i32 %shr137, 2, !dbg !81
  %xor.1.1 = xor i32 %add138.1.1, %shr134, !dbg !78
  %210 = getelementptr inbounds i8, ptr addrspace(3) %209, i32 512, !dbg !79
  %gep684.idx.1.1 = shl nuw nsw i32 %xor.1.1, 4, !dbg !79
  %gep684.1.1 = getelementptr inbounds i8, ptr addrspace(3) %210, i32 %gep684.idx.1.1, !dbg !79
  store i64 %q_stage.sroa.8.12.insert.insert1628, ptr addrspace(3) %gep684.1.1, align 8, !dbg !80
  %add138.2.1 = add nuw nsw i32 %shr137, 4, !dbg !81
  %xor.2.1 = xor i32 %add138.2.1, %shr134, !dbg !78
  %211 = getelementptr inbounds i8, ptr addrspace(3) %209, i32 1024, !dbg !79
  %gep684.idx.2.1 = shl nuw nsw i32 %xor.2.1, 4, !dbg !79
  %gep684.2.1 = getelementptr inbounds i8, ptr addrspace(3) %211, i32 %gep684.idx.2.1, !dbg !79
  store i64 %q_stage.sroa.14.20.insert.insert1638, ptr addrspace(3) %gep684.2.1, align 8, !dbg !80
  %add138.3.1 = add nuw nsw i32 %shr137, 6, !dbg !81
  %xor.3.1 = xor i32 %add138.3.1, %shr134, !dbg !78
  %212 = getelementptr inbounds i8, ptr addrspace(3) %209, i32 1536, !dbg !79
  %gep684.idx.3.1 = shl nuw nsw i32 %xor.3.1, 4, !dbg !79
  %gep684.3.1 = getelementptr inbounds i8, ptr addrspace(3) %212, i32 %gep684.idx.3.1, !dbg !79
  store i64 %q_stage.sroa.20.28.insert.insert1648, ptr addrspace(3) %gep684.3.1, align 8, !dbg !80
  %add138.4.1 = add nuw nsw i32 %shr137, 8, !dbg !81
  %xor.4.1 = xor i32 %add138.4.1, %shr134, !dbg !78
  %213 = getelementptr inbounds i8, ptr addrspace(3) %209, i32 2048, !dbg !79
  %gep684.idx.4.1 = shl nuw nsw i32 %xor.4.1, 4, !dbg !79
  %gep684.4.1 = getelementptr inbounds i8, ptr addrspace(3) %213, i32 %gep684.idx.4.1, !dbg !79
  store i64 %q_stage.sroa.26.36.insert.insert1658, ptr addrspace(3) %gep684.4.1, align 8, !dbg !80
  %add138.5.1 = add nuw nsw i32 %shr137, 10, !dbg !81
  %xor.5.1 = xor i32 %add138.5.1, %shr134, !dbg !78
  %214 = getelementptr inbounds i8, ptr addrspace(3) %209, i32 2560, !dbg !79
  %gep684.idx.5.1 = shl nuw nsw i32 %xor.5.1, 4, !dbg !79
  %gep684.5.1 = getelementptr inbounds i8, ptr addrspace(3) %214, i32 %gep684.idx.5.1, !dbg !79
  store i64 %q_stage.sroa.32.44.insert.insert1668, ptr addrspace(3) %gep684.5.1, align 8, !dbg !80
  %add138.6.1 = add nuw nsw i32 %shr137, 12, !dbg !81
  %xor.6.1 = xor i32 %add138.6.1, %shr134, !dbg !78
  %215 = getelementptr inbounds i8, ptr addrspace(3) %209, i32 3072, !dbg !79
  %gep684.idx.6.1 = shl nuw nsw i32 %xor.6.1, 4, !dbg !79
  %gep684.6.1 = getelementptr inbounds i8, ptr addrspace(3) %215, i32 %gep684.idx.6.1, !dbg !79
  store i64 %q_stage.sroa.38.52.insert.insert1678, ptr addrspace(3) %gep684.6.1, align 8, !dbg !80
  %add138.7.1 = add nuw nsw i32 %shr137, 14, !dbg !81
  %xor.7.1 = xor i32 %add138.7.1, %shr134, !dbg !78
  %216 = getelementptr inbounds i8, ptr addrspace(3) %209, i32 3584, !dbg !79
  %gep684.idx.7.1 = shl nuw nsw i32 %xor.7.1, 4, !dbg !79
  %gep684.7.1 = getelementptr inbounds i8, ptr addrspace(3) %216, i32 %gep684.idx.7.1, !dbg !79
  store i64 %q_stage.sroa.44.60.insert.insert1688, ptr addrspace(3) %gep684.7.1, align 8, !dbg !80
  fence syncscope("warp") release, !dbg !82
  tail call void @llvm.mxc.barrier.warp(), !dbg !85
  fence syncscope("warp") acquire, !dbg !86
  %xor164.1770 = xor i32 %shr160, %and163, !dbg !87
  %.idx.1771 = shl nuw nsw i32 %xor164.1770, 4, !dbg !88
  %gep687.1772 = getelementptr inbounds i8, ptr addrspace(3) %gep713, i32 %.idx.1771, !dbg !88
  %q.sroa.0.0.copyload1561 = load <4 x half>, ptr addrspace(3) %gep687.1772, align 16, !dbg !89
  %q.sroa.6.0.gep687.1772.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep687.1772, i32 8, !dbg !89
  %q.sroa.6.0.copyload1562 = load <4 x half>, ptr addrspace(3) %q.sroa.6.0.gep687.1772.sroa_idx, align 8, !dbg !89
  %add161.1.1 = add nuw nsw i32 %shr160, 4, !dbg !90
  %xor164.1.1 = xor i32 %add161.1.1, %and163, !dbg !87
  %.idx.1.1 = shl nuw nsw i32 %xor164.1.1, 4, !dbg !88
  %gep687.1.1 = getelementptr inbounds i8, ptr addrspace(3) %gep713, i32 %.idx.1.1, !dbg !88
  %q.sroa.8.16.copyload1565 = load <4 x half>, ptr addrspace(3) %gep687.1.1, align 16, !dbg !89
  %q.sroa.12.16.gep687.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep687.1.1, i32 8, !dbg !89
  %q.sroa.12.16.copyload1566 = load <4 x half>, ptr addrspace(3) %q.sroa.12.16.gep687.1.1.sroa_idx, align 8, !dbg !89
  %add161.2.1 = add nuw nsw i32 %shr160, 8, !dbg !90
  %xor164.2.1 = xor i32 %add161.2.1, %and163, !dbg !87
  %.idx.2.1 = shl nuw nsw i32 %xor164.2.1, 4, !dbg !88
  %gep687.2.1 = getelementptr inbounds i8, ptr addrspace(3) %gep713, i32 %.idx.2.1, !dbg !88
  %q.sroa.14.32.copyload1569 = load <4 x half>, ptr addrspace(3) %gep687.2.1, align 16, !dbg !89
  %q.sroa.18.32.gep687.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep687.2.1, i32 8, !dbg !89
  %q.sroa.18.32.copyload1570 = load <4 x half>, ptr addrspace(3) %q.sroa.18.32.gep687.2.1.sroa_idx, align 8, !dbg !89
  %add161.3.1 = add nuw nsw i32 %shr160, 12, !dbg !90
  %xor164.3.1 = xor i32 %add161.3.1, %and163, !dbg !87
  %.idx.3.1 = shl nuw nsw i32 %xor164.3.1, 4, !dbg !88
  %gep687.3.1 = getelementptr inbounds i8, ptr addrspace(3) %gep713, i32 %.idx.3.1, !dbg !88
  %q.sroa.20.48.copyload1573 = load <4 x half>, ptr addrspace(3) %gep687.3.1, align 16, !dbg !89
  %q.sroa.24.48.gep687.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep687.3.1, i32 8, !dbg !89
  %q.sroa.24.48.copyload1574 = load <4 x half>, ptr addrspace(3) %q.sroa.24.48.gep687.3.1.sroa_idx, align 8, !dbg !89
  %cmp197.not.1773 = icmp sgt i32 %add190, %7, !dbg !91
  %spec.select.1774 = select i1 %cmp197.not.1773, float 0xFFF0000000000000, float 0.000000e+00, !dbg !92
  %scores.sroa.0.0.vec.insert1356 = insertelement <4 x float> poison, float %spec.select.1774, i64 0, !dbg !93
  %cmp197.not.1.1.not = icmp slt i32 %add190, %7, !dbg !91
  %spec.select.1.1 = select i1 %cmp197.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !92
  %scores.sroa.0.4.vec.insert1381 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1356, float %spec.select.1.1, i64 1, !dbg !93
  %add194.2.1 = or disjoint i32 %add190, 2, !dbg !94
  %cmp197.not.2.1 = icmp sgt i32 %add194.2.1, %7, !dbg !91
  %spec.select.2.1 = select i1 %cmp197.not.2.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !92
  %scores.sroa.0.8.vec.insert1406 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1381, float %spec.select.2.1, i64 2, !dbg !93
  %add194.3.1 = or disjoint i32 %add190, 3, !dbg !94
  %cmp197.not.3.1 = icmp sgt i32 %add194.3.1, %7, !dbg !91
  %spec.select.3.1 = select i1 %cmp197.not.3.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !92
  %scores.sroa.0.12.vec.insert1431 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1406, float %spec.select.3.1, i64 3, !dbg !93
  %add196.4.1 = add nuw nsw i32 %add190, 16, !dbg !95
  %cmp197.not.4.1 = icmp sgt i32 %add196.4.1, %7, !dbg !91
  %spec.select.4.1 = select i1 %cmp197.not.4.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !92
  %scores.sroa.90.16.vec.insert1472 = insertelement <4 x float> poison, float %spec.select.4.1, i64 0, !dbg !93
  %add196.5.1 = add nuw nsw i32 %add190, 17, !dbg !95
  %cmp197.not.5.1 = icmp sgt i32 %add196.5.1, %7, !dbg !91
  %spec.select.5.1 = select i1 %cmp197.not.5.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !92
  %scores.sroa.90.20.vec.insert1497 = insertelement <4 x float> %scores.sroa.90.16.vec.insert1472, float %spec.select.5.1, i64 1, !dbg !93
  %add196.6.1 = add nuw nsw i32 %add190, 18, !dbg !95
  %cmp197.not.6.1 = icmp sgt i32 %add196.6.1, %7, !dbg !91
  %spec.select.6.1 = select i1 %cmp197.not.6.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !92
  %scores.sroa.90.24.vec.insert1522 = insertelement <4 x float> %scores.sroa.90.20.vec.insert1497, float %spec.select.6.1, i64 2, !dbg !93
  %add196.7.1 = add nuw nsw i32 %add190, 19, !dbg !95
  %cmp197.not.7.1 = icmp sgt i32 %add196.7.1, %7, !dbg !91
  %spec.select.7.1 = select i1 %cmp197.not.7.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !92
  %scores.sroa.90.28.vec.insert1547 = insertelement <4 x float> %scores.sroa.90.24.vec.insert1522, float %spec.select.7.1, i64 3, !dbg !93
  %217 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.2, <4 x half> %q.sroa.0.0.copyload1561, <4 x float> %scores.sroa.0.12.vec.insert1431), !dbg !96
  %218 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.2, <4 x half> %q.sroa.0.0.copyload1561, <4 x float> %scores.sroa.90.28.vec.insert1547), !dbg !96
  %219 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.6.2, <4 x half> %q.sroa.6.0.copyload1562, <4 x float> %217), !dbg !96
  %220 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.12.2, <4 x half> %q.sroa.6.0.copyload1562, <4 x float> %218), !dbg !96
  %221 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.2, <4 x half> %q.sroa.8.16.copyload1565, <4 x float> %219), !dbg !96
  %222 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.2, <4 x half> %q.sroa.8.16.copyload1565, <4 x float> %220), !dbg !96
  %223 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.18.2, <4 x half> %q.sroa.12.16.copyload1566, <4 x float> %221), !dbg !96
  %224 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.24.2, <4 x half> %q.sroa.12.16.copyload1566, <4 x float> %222), !dbg !96
  %225 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.26.2, <4 x half> %q.sroa.14.32.copyload1569, <4 x float> %223), !dbg !96
  %226 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.32.2, <4 x half> %q.sroa.14.32.copyload1569, <4 x float> %224), !dbg !96
  %227 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.30.2, <4 x half> %q.sroa.18.32.copyload1570, <4 x float> %225), !dbg !96
  %228 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.36.2, <4 x half> %q.sroa.18.32.copyload1570, <4 x float> %226), !dbg !96
  %229 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.38.2, <4 x half> %q.sroa.20.48.copyload1573, <4 x float> %227), !dbg !96
  %230 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.44.2, <4 x half> %q.sroa.20.48.copyload1573, <4 x float> %228), !dbg !96
  %231 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.42.2, <4 x half> %q.sroa.24.48.copyload1574, <4 x float> %229), !dbg !96
  %232 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.48.2, <4 x half> %q.sroa.24.48.copyload1574, <4 x float> %230), !dbg !96
  %scores.sroa.0.0.vec.extract1358 = extractelement <4 x float> %231, i64 0, !dbg !100
  %mul282.1783 = fmul contract float %scores.sroa.0.0.vec.extract1358, 0x3FC2776C60000000, !dbg !101
  %233 = tail call contract noundef float @llvm.minnum.f32(float %mul282.1783, float 1.500000e+01), !dbg !102
  %cmp.i.i.1784 = fcmp contract olt float %233, -1.260000e+02, !dbg !106
  %cond.i.i.1785 = select contract i1 %cmp.i.i.1784, float 6.400000e+01, float 0.000000e+00, !dbg !106
  %add.i.i667.1786 = fadd contract float %233, %cond.i.i.1785, !dbg !106
  %234 = tail call contract float @llvm.exp2.f32(float %add.i.i667.1786), !dbg !106
  %cond2.i.i.1787 = select contract i1 %cmp.i.i.1784, float 0x3BF0000000000000, float 1.000000e+00, !dbg !106
  %mul.i.i.1788 = fmul contract float %cond2.i.i.1787, %234, !dbg !106
  %scores.sroa.0.4.vec.extract1383 = extractelement <4 x float> %231, i64 1, !dbg !100
  %mul282.1.1 = fmul contract float %scores.sroa.0.4.vec.extract1383, 0x3FC2776C60000000, !dbg !101
  %235 = tail call contract noundef float @llvm.minnum.f32(float %mul282.1.1, float 1.500000e+01), !dbg !102
  %cmp.i.i.1.1 = fcmp contract olt float %235, -1.260000e+02, !dbg !106
  %cond.i.i.1.1 = select contract i1 %cmp.i.i.1.1, float 6.400000e+01, float 0.000000e+00, !dbg !106
  %add.i.i667.1.1 = fadd contract float %235, %cond.i.i.1.1, !dbg !106
  %236 = tail call contract float @llvm.exp2.f32(float %add.i.i667.1.1), !dbg !106
  %cond2.i.i.1.1 = select contract i1 %cmp.i.i.1.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !106
  %mul.i.i.1.1 = fmul contract float %cond2.i.i.1.1, %236, !dbg !106
  %scores.sroa.0.8.vec.extract1408 = extractelement <4 x float> %231, i64 2, !dbg !100
  %mul282.2.1 = fmul contract float %scores.sroa.0.8.vec.extract1408, 0x3FC2776C60000000, !dbg !101
  %237 = tail call contract noundef float @llvm.minnum.f32(float %mul282.2.1, float 1.500000e+01), !dbg !102
  %cmp.i.i.2.1 = fcmp contract olt float %237, -1.260000e+02, !dbg !106
  %cond.i.i.2.1 = select contract i1 %cmp.i.i.2.1, float 6.400000e+01, float 0.000000e+00, !dbg !106
  %add.i.i667.2.1 = fadd contract float %237, %cond.i.i.2.1, !dbg !106
  %238 = tail call contract float @llvm.exp2.f32(float %add.i.i667.2.1), !dbg !106
  %cond2.i.i.2.1 = select contract i1 %cmp.i.i.2.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !106
  %mul.i.i.2.1 = fmul contract float %cond2.i.i.2.1, %238, !dbg !106
  %scores.sroa.0.12.vec.extract1433 = extractelement <4 x float> %231, i64 3, !dbg !100
  %mul282.3.1 = fmul contract float %scores.sroa.0.12.vec.extract1433, 0x3FC2776C60000000, !dbg !101
  %239 = tail call contract noundef float @llvm.minnum.f32(float %mul282.3.1, float 1.500000e+01), !dbg !102
  %cmp.i.i.3.1 = fcmp contract olt float %239, -1.260000e+02, !dbg !106
  %cond.i.i.3.1 = select contract i1 %cmp.i.i.3.1, float 6.400000e+01, float 0.000000e+00, !dbg !106
  %add.i.i667.3.1 = fadd contract float %239, %cond.i.i.3.1, !dbg !106
  %240 = tail call contract float @llvm.exp2.f32(float %add.i.i667.3.1), !dbg !106
  %cond2.i.i.3.1 = select contract i1 %cmp.i.i.3.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !106
  %mul.i.i.3.1 = fmul contract float %cond2.i.i.3.1, %240, !dbg !106
  %scores.sroa.90.16.vec.extract1474 = extractelement <4 x float> %232, i64 0, !dbg !100
  %mul282.4.1 = fmul contract float %scores.sroa.90.16.vec.extract1474, 0x3FC2776C60000000, !dbg !101
  %241 = tail call contract noundef float @llvm.minnum.f32(float %mul282.4.1, float 1.500000e+01), !dbg !102
  %cmp.i.i.4.1 = fcmp contract olt float %241, -1.260000e+02, !dbg !106
  %cond.i.i.4.1 = select contract i1 %cmp.i.i.4.1, float 6.400000e+01, float 0.000000e+00, !dbg !106
  %add.i.i667.4.1 = fadd contract float %241, %cond.i.i.4.1, !dbg !106
  %242 = tail call contract float @llvm.exp2.f32(float %add.i.i667.4.1), !dbg !106
  %cond2.i.i.4.1 = select contract i1 %cmp.i.i.4.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !106
  %mul.i.i.4.1 = fmul contract float %cond2.i.i.4.1, %242, !dbg !106
  %scores.sroa.90.20.vec.extract1499 = extractelement <4 x float> %232, i64 1, !dbg !100
  %mul282.5.1 = fmul contract float %scores.sroa.90.20.vec.extract1499, 0x3FC2776C60000000, !dbg !101
  %243 = tail call contract noundef float @llvm.minnum.f32(float %mul282.5.1, float 1.500000e+01), !dbg !102
  %cmp.i.i.5.1 = fcmp contract olt float %243, -1.260000e+02, !dbg !106
  %cond.i.i.5.1 = select contract i1 %cmp.i.i.5.1, float 6.400000e+01, float 0.000000e+00, !dbg !106
  %add.i.i667.5.1 = fadd contract float %243, %cond.i.i.5.1, !dbg !106
  %244 = tail call contract float @llvm.exp2.f32(float %add.i.i667.5.1), !dbg !106
  %cond2.i.i.5.1 = select contract i1 %cmp.i.i.5.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !106
  %mul.i.i.5.1 = fmul contract float %cond2.i.i.5.1, %244, !dbg !106
  %scores.sroa.90.24.vec.extract1524 = extractelement <4 x float> %232, i64 2, !dbg !100
  %mul282.6.1 = fmul contract float %scores.sroa.90.24.vec.extract1524, 0x3FC2776C60000000, !dbg !101
  %245 = tail call contract noundef float @llvm.minnum.f32(float %mul282.6.1, float 1.500000e+01), !dbg !102
  %cmp.i.i.6.1 = fcmp contract olt float %245, -1.260000e+02, !dbg !106
  %cond.i.i.6.1 = select contract i1 %cmp.i.i.6.1, float 6.400000e+01, float 0.000000e+00, !dbg !106
  %add.i.i667.6.1 = fadd contract float %245, %cond.i.i.6.1, !dbg !106
  %246 = tail call contract float @llvm.exp2.f32(float %add.i.i667.6.1), !dbg !106
  %cond2.i.i.6.1 = select contract i1 %cmp.i.i.6.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !106
  %mul.i.i.6.1 = fmul contract float %cond2.i.i.6.1, %246, !dbg !106
  %scores.sroa.90.28.vec.extract1549 = extractelement <4 x float> %232, i64 3, !dbg !100
  %mul282.7.1 = fmul contract float %scores.sroa.90.28.vec.extract1549, 0x3FC2776C60000000, !dbg !101
  %247 = tail call contract noundef float @llvm.minnum.f32(float %mul282.7.1, float 1.500000e+01), !dbg !102
  %cmp.i.i.7.1 = fcmp contract olt float %247, -1.260000e+02, !dbg !106
  %cond.i.i.7.1 = select contract i1 %cmp.i.i.7.1, float 6.400000e+01, float 0.000000e+00, !dbg !106
  %add.i.i667.7.1 = fadd contract float %247, %cond.i.i.7.1, !dbg !106
  %248 = tail call contract float @llvm.exp2.f32(float %add.i.i667.7.1), !dbg !106
  %cond2.i.i.7.1 = select contract i1 %cmp.i.i.7.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !106
  %mul.i.i.7.1 = fmul contract float %cond2.i.i.7.1, %248, !dbg !106
  %add302.1789 = fadd contract float %mul.i.i.1788, 0.000000e+00, !dbg !109
  %add302.1.1 = fadd contract float %add302.1789, %mul.i.i.4.1, !dbg !109
  %add302.2.1 = fadd contract float %add302.1.1, %mul.i.i.1.1, !dbg !109
  %add302.3.1 = fadd contract float %add302.2.1, %mul.i.i.5.1, !dbg !109
  %add302.4.1 = fadd contract float %add302.3.1, %mul.i.i.2.1, !dbg !109
  %add302.5.1 = fadd contract float %add302.4.1, %mul.i.i.6.1, !dbg !109
  %add302.6.1 = fadd contract float %add302.5.1, %mul.i.i.3.1, !dbg !109
  %add302.7.1 = fadd contract float %add302.6.1, %mul.i.i.7.1, !dbg !109
  %249 = bitcast float %add302.7.1 to i32, !dbg !110
  %250 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !121
  %251 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %250) #11, !dbg !126
  %xor.i.i.1 = xor i32 %251, 32, !dbg !127
  %252 = and i32 %251, -64, !dbg !128
  %and.i.i.1 = add nsw i32 %252, 64, !dbg !128
  %cmp.not.i.i.1 = icmp slt i32 %xor.i.i.1, %and.i.i.1, !dbg !129
  %cond.i.i668.1 = select i1 %cmp.not.i.i.1, i32 %xor.i.i.1, i32 %251, !dbg !130
  %shl.i.i.1 = shl i32 %cond.i.i668.1, 2, !dbg !131
  %253 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.1, i32 %249), !dbg !132
  %254 = bitcast i32 %253 to float, !dbg !133
  %add.i.1 = fadd contract float %add302.7.1, %254, !dbg !134
  %255 = bitcast float %add.i.1 to i32, !dbg !137
  %256 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !144
  %257 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %256) #11, !dbg !147
  %xor.i.i669.1 = xor i32 %257, 16, !dbg !148
  %258 = and i32 %257, -64, !dbg !149
  %and.i.i670.1 = add nsw i32 %258, 64, !dbg !149
  %cmp.not.i.i671.1 = icmp slt i32 %xor.i.i669.1, %and.i.i670.1, !dbg !150
  %cond.i.i672.1 = select i1 %cmp.not.i.i671.1, i32 %xor.i.i669.1, i32 %257, !dbg !151
  %shl.i.i673.1 = shl i32 %cond.i.i672.1, 2, !dbg !152
  %259 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i673.1, i32 %255), !dbg !153
  %260 = bitcast i32 %259 to float, !dbg !154
  %add.i.i.1 = fadd contract float %add.i.1, %260, !dbg !155
  %cmp311.1 = fcmp contract ogt float %add.i.i.1, 0.000000e+00, !dbg !157
  %div.1 = fdiv contract float 1.000000e+00, %add.i.i.1, !dbg !158
  %condval_8.0.1 = select i1 %cmp311.1, float %div.1, float 0.000000e+00, !dbg !158
  %mul324.1790 = fmul contract float %condval_8.0.1, %mul.i.i.1788, !dbg !159
  %mul324.1.1 = fmul contract float %condval_8.0.1, %mul.i.i.1.1, !dbg !159
  %mul324.2.1 = fmul contract float %condval_8.0.1, %mul.i.i.2.1, !dbg !159
  %mul324.3.1 = fmul contract float %condval_8.0.1, %mul.i.i.3.1, !dbg !159
  %mul324.4.1 = fmul contract float %condval_8.0.1, %mul.i.i.4.1, !dbg !159
  %mul324.5.1 = fmul contract float %condval_8.0.1, %mul.i.i.5.1, !dbg !159
  %mul324.6.1 = fmul contract float %condval_8.0.1, %mul.i.i.6.1, !dbg !159
  %mul324.7.1 = fmul contract float %condval_8.0.1, %mul.i.i.7.1, !dbg !159
  %261 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324.1790), !dbg !160
  %262 = insertelement <4 x i16> poison, i16 %261, i64 0, !dbg !169
  %263 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324.1.1), !dbg !160
  %264 = insertelement <4 x i16> %262, i16 %263, i64 1, !dbg !169
  %265 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324.2.1), !dbg !160
  %266 = insertelement <4 x i16> %264, i16 %265, i64 2, !dbg !169
  %267 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324.3.1), !dbg !160
  %268 = insertelement <4 x i16> %266, i16 %267, i64 3, !dbg !169
  %prob.sroa.0.6.vec.insert1284 = bitcast <4 x i16> %268 to <4 x half>, !dbg !169
  %269 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324.4.1), !dbg !160
  %270 = insertelement <4 x i16> poison, i16 %269, i64 0, !dbg !169
  %271 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324.5.1), !dbg !160
  %272 = insertelement <4 x i16> %270, i16 %271, i64 1, !dbg !169
  %273 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324.6.1), !dbg !160
  %274 = insertelement <4 x i16> %272, i16 %273, i64 2, !dbg !169
  %275 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul324.7.1), !dbg !160
  %276 = insertelement <4 x i16> %274, i16 %275, i64 3, !dbg !169
  %prob.sroa.12.14.vec.insert1294 = bitcast <4 x i16> %276 to <4 x half>, !dbg !169
  %277 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.2, <4 x half> %prob.sroa.0.6.vec.insert1284, <4 x float> zeroinitializer), !dbg !170
  %278 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.6.2, <4 x half> %prob.sroa.0.6.vec.insert1284, <4 x float> zeroinitializer), !dbg !170
  %279 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.8.2, <4 x half> %prob.sroa.0.6.vec.insert1284, <4 x float> zeroinitializer), !dbg !170
  %280 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.12.2, <4 x half> %prob.sroa.0.6.vec.insert1284, <4 x float> zeroinitializer), !dbg !170
  %281 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.2, <4 x half> %prob.sroa.0.6.vec.insert1284, <4 x float> zeroinitializer), !dbg !170
  %282 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.18.2, <4 x half> %prob.sroa.0.6.vec.insert1284, <4 x float> zeroinitializer), !dbg !170
  %283 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.20.2, <4 x half> %prob.sroa.0.6.vec.insert1284, <4 x float> zeroinitializer), !dbg !170
  %284 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.24.2, <4 x half> %prob.sroa.0.6.vec.insert1284, <4 x float> zeroinitializer), !dbg !170
  %285 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.26.2, <4 x half> %prob.sroa.12.14.vec.insert1294, <4 x float> %277), !dbg !170
  %286 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.30.2, <4 x half> %prob.sroa.12.14.vec.insert1294, <4 x float> %278), !dbg !170
  %287 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.32.2, <4 x half> %prob.sroa.12.14.vec.insert1294, <4 x float> %279), !dbg !170
  %288 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.36.2, <4 x half> %prob.sroa.12.14.vec.insert1294, <4 x float> %280), !dbg !170
  %289 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.38.2, <4 x half> %prob.sroa.12.14.vec.insert1294, <4 x float> %281), !dbg !170
  %290 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.42.2, <4 x half> %prob.sroa.12.14.vec.insert1294, <4 x float> %282), !dbg !170
  %291 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.44.2, <4 x half> %prob.sroa.12.14.vec.insert1294, <4 x float> %283), !dbg !170
  %292 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.48.2, <4 x half> %prob.sroa.12.14.vec.insert1294, <4 x float> %284), !dbg !170
  %out.sroa.0.0.vec.extract835 = extractelement <4 x float> %285, i64 0, !dbg !171
  %293 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract835), !dbg !172
  %output_reg.sroa.0.0.insert.ext1027 = zext i16 %293 to i64, !dbg !176
  %out.sroa.0.4.vec.extract840 = extractelement <4 x float> %285, i64 1, !dbg !171
  %294 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract840), !dbg !172
  %output_reg.sroa.0.2.insert.ext1031 = zext i16 %294 to i64, !dbg !176
  %output_reg.sroa.0.2.insert.shift1032 = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext1031, 16, !dbg !176
  %output_reg.sroa.0.2.insert.insert1034 = or disjoint i64 %output_reg.sroa.0.2.insert.shift1032, %output_reg.sroa.0.0.insert.ext1027, !dbg !176
  %out.sroa.0.8.vec.extract845 = extractelement <4 x float> %285, i64 2, !dbg !171
  %295 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract845), !dbg !172
  %output_reg.sroa.0.4.insert.ext1042 = zext i16 %295 to i64, !dbg !176
  %output_reg.sroa.0.4.insert.shift1043 = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext1042, 32, !dbg !176
  %output_reg.sroa.0.4.insert.insert1045 = or disjoint i64 %output_reg.sroa.0.2.insert.insert1034, %output_reg.sroa.0.4.insert.shift1043, !dbg !176
  %out.sroa.0.12.vec.extract850 = extractelement <4 x float> %285, i64 3, !dbg !171
  %296 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract850), !dbg !172
  %output_reg.sroa.0.6.insert.ext1047 = zext i16 %296 to i64, !dbg !176
  %output_reg.sroa.0.6.insert.shift1048 = shl nuw i64 %output_reg.sroa.0.6.insert.ext1047, 48, !dbg !176
  %output_reg.sroa.0.6.insert.insert1050 = or disjoint i64 %output_reg.sroa.0.4.insert.insert1045, %output_reg.sroa.0.6.insert.shift1048, !dbg !176
  %out.sroa.26.16.vec.extract859 = extractelement <4 x float> %286, i64 0, !dbg !171
  %297 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.16.vec.extract859), !dbg !172
  %output_reg.sroa.16.8.insert.ext1059 = zext i16 %297 to i64, !dbg !176
  %out.sroa.26.20.vec.extract864 = extractelement <4 x float> %286, i64 1, !dbg !171
  %298 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.20.vec.extract864), !dbg !172
  %output_reg.sroa.16.10.insert.ext1063 = zext i16 %298 to i64, !dbg !176
  %output_reg.sroa.16.10.insert.shift1064 = shl nuw nsw i64 %output_reg.sroa.16.10.insert.ext1063, 16, !dbg !176
  %output_reg.sroa.16.10.insert.insert1066 = or disjoint i64 %output_reg.sroa.16.10.insert.shift1064, %output_reg.sroa.16.8.insert.ext1059, !dbg !176
  %out.sroa.26.24.vec.extract869 = extractelement <4 x float> %286, i64 2, !dbg !171
  %299 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.24.vec.extract869), !dbg !172
  %output_reg.sroa.16.12.insert.ext1074 = zext i16 %299 to i64, !dbg !176
  %output_reg.sroa.16.12.insert.shift1075 = shl nuw nsw i64 %output_reg.sroa.16.12.insert.ext1074, 32, !dbg !176
  %output_reg.sroa.16.12.insert.insert1077 = or disjoint i64 %output_reg.sroa.16.10.insert.insert1066, %output_reg.sroa.16.12.insert.shift1075, !dbg !176
  %out.sroa.26.28.vec.extract874 = extractelement <4 x float> %286, i64 3, !dbg !171
  %300 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.28.vec.extract874), !dbg !172
  %output_reg.sroa.16.14.insert.ext1079 = zext i16 %300 to i64, !dbg !176
  %output_reg.sroa.16.14.insert.shift1080 = shl nuw i64 %output_reg.sroa.16.14.insert.ext1079, 48, !dbg !176
  %output_reg.sroa.16.14.insert.insert1082 = or disjoint i64 %output_reg.sroa.16.12.insert.insert1077, %output_reg.sroa.16.14.insert.shift1080, !dbg !176
  %out.sroa.50.32.vec.extract883 = extractelement <4 x float> %287, i64 0, !dbg !171
  %301 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.32.vec.extract883), !dbg !172
  %output_reg.sroa.30.16.insert.ext1091 = zext i16 %301 to i64, !dbg !176
  %out.sroa.50.36.vec.extract888 = extractelement <4 x float> %287, i64 1, !dbg !171
  %302 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.36.vec.extract888), !dbg !172
  %output_reg.sroa.30.18.insert.ext1095 = zext i16 %302 to i64, !dbg !176
  %output_reg.sroa.30.18.insert.shift1096 = shl nuw nsw i64 %output_reg.sroa.30.18.insert.ext1095, 16, !dbg !176
  %output_reg.sroa.30.18.insert.insert1098 = or disjoint i64 %output_reg.sroa.30.18.insert.shift1096, %output_reg.sroa.30.16.insert.ext1091, !dbg !176
  %out.sroa.50.40.vec.extract893 = extractelement <4 x float> %287, i64 2, !dbg !171
  %303 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.40.vec.extract893), !dbg !172
  %output_reg.sroa.30.20.insert.ext1106 = zext i16 %303 to i64, !dbg !176
  %output_reg.sroa.30.20.insert.shift1107 = shl nuw nsw i64 %output_reg.sroa.30.20.insert.ext1106, 32, !dbg !176
  %output_reg.sroa.30.20.insert.insert1109 = or disjoint i64 %output_reg.sroa.30.18.insert.insert1098, %output_reg.sroa.30.20.insert.shift1107, !dbg !176
  %out.sroa.50.44.vec.extract898 = extractelement <4 x float> %287, i64 3, !dbg !171
  %304 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.44.vec.extract898), !dbg !172
  %output_reg.sroa.30.22.insert.ext1111 = zext i16 %304 to i64, !dbg !176
  %output_reg.sroa.30.22.insert.shift1112 = shl nuw i64 %output_reg.sroa.30.22.insert.ext1111, 48, !dbg !176
  %output_reg.sroa.30.22.insert.insert1114 = or disjoint i64 %output_reg.sroa.30.20.insert.insert1109, %output_reg.sroa.30.22.insert.shift1112, !dbg !176
  %out.sroa.74.48.vec.extract907 = extractelement <4 x float> %288, i64 0, !dbg !171
  %305 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.48.vec.extract907), !dbg !172
  %output_reg.sroa.44.24.insert.ext1123 = zext i16 %305 to i64, !dbg !176
  %out.sroa.74.52.vec.extract912 = extractelement <4 x float> %288, i64 1, !dbg !171
  %306 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.52.vec.extract912), !dbg !172
  %output_reg.sroa.44.26.insert.ext1127 = zext i16 %306 to i64, !dbg !176
  %output_reg.sroa.44.26.insert.shift1128 = shl nuw nsw i64 %output_reg.sroa.44.26.insert.ext1127, 16, !dbg !176
  %output_reg.sroa.44.26.insert.insert1130 = or disjoint i64 %output_reg.sroa.44.26.insert.shift1128, %output_reg.sroa.44.24.insert.ext1123, !dbg !176
  %out.sroa.74.56.vec.extract917 = extractelement <4 x float> %288, i64 2, !dbg !171
  %307 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.56.vec.extract917), !dbg !172
  %output_reg.sroa.44.28.insert.ext1138 = zext i16 %307 to i64, !dbg !176
  %output_reg.sroa.44.28.insert.shift1139 = shl nuw nsw i64 %output_reg.sroa.44.28.insert.ext1138, 32, !dbg !176
  %output_reg.sroa.44.28.insert.insert1141 = or disjoint i64 %output_reg.sroa.44.26.insert.insert1130, %output_reg.sroa.44.28.insert.shift1139, !dbg !176
  %out.sroa.74.60.vec.extract922 = extractelement <4 x float> %288, i64 3, !dbg !171
  %308 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.60.vec.extract922), !dbg !172
  %output_reg.sroa.44.30.insert.ext1143 = zext i16 %308 to i64, !dbg !176
  %output_reg.sroa.44.30.insert.shift1144 = shl nuw i64 %output_reg.sroa.44.30.insert.ext1143, 48, !dbg !176
  %output_reg.sroa.44.30.insert.insert1146 = or disjoint i64 %output_reg.sroa.44.28.insert.insert1141, %output_reg.sroa.44.30.insert.shift1144, !dbg !176
  %out.sroa.98.64.vec.extract931 = extractelement <4 x float> %289, i64 0, !dbg !171
  %309 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.64.vec.extract931), !dbg !172
  %output_reg.sroa.58.32.insert.ext1155 = zext i16 %309 to i64, !dbg !176
  %out.sroa.98.68.vec.extract936 = extractelement <4 x float> %289, i64 1, !dbg !171
  %310 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.68.vec.extract936), !dbg !172
  %output_reg.sroa.58.34.insert.ext1159 = zext i16 %310 to i64, !dbg !176
  %output_reg.sroa.58.34.insert.shift1160 = shl nuw nsw i64 %output_reg.sroa.58.34.insert.ext1159, 16, !dbg !176
  %output_reg.sroa.58.34.insert.insert1162 = or disjoint i64 %output_reg.sroa.58.34.insert.shift1160, %output_reg.sroa.58.32.insert.ext1155, !dbg !176
  %out.sroa.98.72.vec.extract941 = extractelement <4 x float> %289, i64 2, !dbg !171
  %311 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.72.vec.extract941), !dbg !172
  %output_reg.sroa.58.36.insert.ext1170 = zext i16 %311 to i64, !dbg !176
  %output_reg.sroa.58.36.insert.shift1171 = shl nuw nsw i64 %output_reg.sroa.58.36.insert.ext1170, 32, !dbg !176
  %output_reg.sroa.58.36.insert.insert1173 = or disjoint i64 %output_reg.sroa.58.34.insert.insert1162, %output_reg.sroa.58.36.insert.shift1171, !dbg !176
  %out.sroa.98.76.vec.extract946 = extractelement <4 x float> %289, i64 3, !dbg !171
  %312 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.76.vec.extract946), !dbg !172
  %output_reg.sroa.58.38.insert.ext1175 = zext i16 %312 to i64, !dbg !176
  %output_reg.sroa.58.38.insert.shift1176 = shl nuw i64 %output_reg.sroa.58.38.insert.ext1175, 48, !dbg !176
  %output_reg.sroa.58.38.insert.insert1178 = or disjoint i64 %output_reg.sroa.58.36.insert.insert1173, %output_reg.sroa.58.38.insert.shift1176, !dbg !176
  %out.sroa.122.80.vec.extract955 = extractelement <4 x float> %290, i64 0, !dbg !171
  %313 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.80.vec.extract955), !dbg !172
  %output_reg.sroa.72.40.insert.ext1187 = zext i16 %313 to i64, !dbg !176
  %out.sroa.122.84.vec.extract960 = extractelement <4 x float> %290, i64 1, !dbg !171
  %314 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.84.vec.extract960), !dbg !172
  %output_reg.sroa.72.42.insert.ext1191 = zext i16 %314 to i64, !dbg !176
  %output_reg.sroa.72.42.insert.shift1192 = shl nuw nsw i64 %output_reg.sroa.72.42.insert.ext1191, 16, !dbg !176
  %output_reg.sroa.72.42.insert.insert1194 = or disjoint i64 %output_reg.sroa.72.42.insert.shift1192, %output_reg.sroa.72.40.insert.ext1187, !dbg !176
  %out.sroa.122.88.vec.extract965 = extractelement <4 x float> %290, i64 2, !dbg !171
  %315 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.88.vec.extract965), !dbg !172
  %output_reg.sroa.72.44.insert.ext1202 = zext i16 %315 to i64, !dbg !176
  %output_reg.sroa.72.44.insert.shift1203 = shl nuw nsw i64 %output_reg.sroa.72.44.insert.ext1202, 32, !dbg !176
  %output_reg.sroa.72.44.insert.insert1205 = or disjoint i64 %output_reg.sroa.72.42.insert.insert1194, %output_reg.sroa.72.44.insert.shift1203, !dbg !176
  %out.sroa.122.92.vec.extract970 = extractelement <4 x float> %290, i64 3, !dbg !171
  %316 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.92.vec.extract970), !dbg !172
  %output_reg.sroa.72.46.insert.ext1207 = zext i16 %316 to i64, !dbg !176
  %output_reg.sroa.72.46.insert.shift1208 = shl nuw i64 %output_reg.sroa.72.46.insert.ext1207, 48, !dbg !176
  %output_reg.sroa.72.46.insert.insert1210 = or disjoint i64 %output_reg.sroa.72.44.insert.insert1205, %output_reg.sroa.72.46.insert.shift1208, !dbg !176
  %out.sroa.146.96.vec.extract979 = extractelement <4 x float> %291, i64 0, !dbg !171
  %317 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.96.vec.extract979), !dbg !172
  %output_reg.sroa.86.48.insert.ext1219 = zext i16 %317 to i64, !dbg !176
  %out.sroa.146.100.vec.extract984 = extractelement <4 x float> %291, i64 1, !dbg !171
  %318 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.100.vec.extract984), !dbg !172
  %output_reg.sroa.86.50.insert.ext1223 = zext i16 %318 to i64, !dbg !176
  %output_reg.sroa.86.50.insert.shift1224 = shl nuw nsw i64 %output_reg.sroa.86.50.insert.ext1223, 16, !dbg !176
  %output_reg.sroa.86.50.insert.insert1226 = or disjoint i64 %output_reg.sroa.86.50.insert.shift1224, %output_reg.sroa.86.48.insert.ext1219, !dbg !176
  %out.sroa.146.104.vec.extract989 = extractelement <4 x float> %291, i64 2, !dbg !171
  %319 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.104.vec.extract989), !dbg !172
  %output_reg.sroa.86.52.insert.ext1234 = zext i16 %319 to i64, !dbg !176
  %output_reg.sroa.86.52.insert.shift1235 = shl nuw nsw i64 %output_reg.sroa.86.52.insert.ext1234, 32, !dbg !176
  %output_reg.sroa.86.52.insert.insert1237 = or disjoint i64 %output_reg.sroa.86.50.insert.insert1226, %output_reg.sroa.86.52.insert.shift1235, !dbg !176
  %out.sroa.146.108.vec.extract994 = extractelement <4 x float> %291, i64 3, !dbg !171
  %320 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.108.vec.extract994), !dbg !172
  %output_reg.sroa.86.54.insert.ext1239 = zext i16 %320 to i64, !dbg !176
  %output_reg.sroa.86.54.insert.shift1240 = shl nuw i64 %output_reg.sroa.86.54.insert.ext1239, 48, !dbg !176
  %output_reg.sroa.86.54.insert.insert1242 = or disjoint i64 %output_reg.sroa.86.52.insert.insert1237, %output_reg.sroa.86.54.insert.shift1240, !dbg !176
  %out.sroa.170.112.vec.extract1003 = extractelement <4 x float> %292, i64 0, !dbg !171
  %321 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.112.vec.extract1003), !dbg !172
  %output_reg.sroa.100.56.insert.ext1251 = zext i16 %321 to i64, !dbg !176
  %out.sroa.170.116.vec.extract1008 = extractelement <4 x float> %292, i64 1, !dbg !171
  %322 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.116.vec.extract1008), !dbg !172
  %output_reg.sroa.100.58.insert.ext1255 = zext i16 %322 to i64, !dbg !176
  %output_reg.sroa.100.58.insert.shift1256 = shl nuw nsw i64 %output_reg.sroa.100.58.insert.ext1255, 16, !dbg !176
  %output_reg.sroa.100.58.insert.insert1258 = or disjoint i64 %output_reg.sroa.100.58.insert.shift1256, %output_reg.sroa.100.56.insert.ext1251, !dbg !176
  %out.sroa.170.120.vec.extract1013 = extractelement <4 x float> %292, i64 2, !dbg !171
  %323 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.120.vec.extract1013), !dbg !172
  %output_reg.sroa.100.60.insert.ext1266 = zext i16 %323 to i64, !dbg !176
  %output_reg.sroa.100.60.insert.shift1267 = shl nuw nsw i64 %output_reg.sroa.100.60.insert.ext1266, 32, !dbg !176
  %output_reg.sroa.100.60.insert.insert1269 = or disjoint i64 %output_reg.sroa.100.58.insert.insert1258, %output_reg.sroa.100.60.insert.shift1267, !dbg !176
  %out.sroa.170.124.vec.extract1018 = extractelement <4 x float> %292, i64 3, !dbg !171
  %324 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.124.vec.extract1018), !dbg !172
  %output_reg.sroa.100.62.insert.ext1271 = zext i16 %324 to i64, !dbg !176
  %output_reg.sroa.100.62.insert.shift1272 = shl nuw i64 %output_reg.sroa.100.62.insert.ext1271, 48, !dbg !176
  %output_reg.sroa.100.62.insert.insert1274 = or disjoint i64 %output_reg.sroa.100.60.insert.insert1269, %output_reg.sroa.100.62.insert.shift1272, !dbg !176
  br label %if.end441.1, !dbg !64

if.end441.1:                                      ; preds = %if.end119.1, %for.body421.preheader.1
  %add456.7.1.pre-phi = phi i32 [ %add138.7.1, %if.end119.1 ], [ %.pre1701, %for.body421.preheader.1 ], !dbg !63
  %add456.6.1.pre-phi = phi i32 [ %add138.6.1, %if.end119.1 ], [ %.pre1700, %for.body421.preheader.1 ], !dbg !63
  %add456.5.1.pre-phi = phi i32 [ %add138.5.1, %if.end119.1 ], [ %.pre1699, %for.body421.preheader.1 ], !dbg !63
  %add456.4.1.pre-phi = phi i32 [ %add138.4.1, %if.end119.1 ], [ %.pre1698, %for.body421.preheader.1 ], !dbg !63
  %add456.3.1.pre-phi = phi i32 [ %add138.3.1, %if.end119.1 ], [ %.pre1697, %for.body421.preheader.1 ], !dbg !63
  %add456.2.1.pre-phi = phi i32 [ %add138.2.1, %if.end119.1 ], [ %.pre1696, %for.body421.preheader.1 ], !dbg !63
  %add456.1.1.pre-phi = phi i32 [ %add138.1.1, %if.end119.1 ], [ %.pre1695, %for.body421.preheader.1 ], !dbg !63
  %output_reg.sroa.100.2 = phi i64 [ %output_reg.sroa.100.62.insert.insert1274, %if.end119.1 ], [ 0, %for.body421.preheader.1 ], !dbg !73
  %output_reg.sroa.86.2 = phi i64 [ %output_reg.sroa.86.54.insert.insert1242, %if.end119.1 ], [ 0, %for.body421.preheader.1 ], !dbg !73
  %output_reg.sroa.72.2 = phi i64 [ %output_reg.sroa.72.46.insert.insert1210, %if.end119.1 ], [ 0, %for.body421.preheader.1 ], !dbg !73
  %output_reg.sroa.58.2 = phi i64 [ %output_reg.sroa.58.38.insert.insert1178, %if.end119.1 ], [ 0, %for.body421.preheader.1 ], !dbg !73
  %output_reg.sroa.44.2 = phi i64 [ %output_reg.sroa.44.30.insert.insert1146, %if.end119.1 ], [ 0, %for.body421.preheader.1 ], !dbg !73
  %output_reg.sroa.30.2 = phi i64 [ %output_reg.sroa.30.22.insert.insert1114, %if.end119.1 ], [ 0, %for.body421.preheader.1 ], !dbg !73
  %output_reg.sroa.16.2 = phi i64 [ %output_reg.sroa.16.14.insert.insert1082, %if.end119.1 ], [ 0, %for.body421.preheader.1 ], !dbg !73
  %output_reg.sroa.0.2 = phi i64 [ %output_reg.sroa.0.6.insert.insert1050, %if.end119.1 ], [ 0, %for.body421.preheader.1 ], !dbg !73
  fence syncscope("warp") release, !dbg !64
  tail call void @llvm.mxc.barrier.warp(), !dbg !177
  fence syncscope("warp") acquire, !dbg !178
  %xor459.1816 = xor i32 %shr137, %and163, !dbg !179
  %mul460.1817 = shl nuw nsw i32 %xor459.1816, 3, !dbg !180
  %add461.1818 = add nuw nsw i32 %mul460.1817, %mul157, !dbg !181
  %add466.1819 = or disjoint i32 %add461.1818, %mul465, !dbg !182
  %add.ptr468.1820 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.1819, !dbg !183
  store i64 %output_reg.sroa.0.2, ptr addrspace(3) %add.ptr468.1820, align 8, !dbg !184
  %xor459.1.1 = xor i32 %add456.1.1.pre-phi, %and163, !dbg !179
  %mul460.1.1 = shl nuw nsw i32 %xor459.1.1, 3, !dbg !180
  %add461.1.1 = add nuw nsw i32 %mul460.1.1, %mul157, !dbg !181
  %add466.1.1 = or disjoint i32 %add461.1.1, %mul465, !dbg !182
  %add.ptr468.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.1.1, !dbg !183
  store i64 %output_reg.sroa.16.2, ptr addrspace(3) %add.ptr468.1.1, align 8, !dbg !184
  %xor459.2.1 = xor i32 %add456.2.1.pre-phi, %and163, !dbg !179
  %mul460.2.1 = shl nuw nsw i32 %xor459.2.1, 3, !dbg !180
  %add461.2.1 = add nuw nsw i32 %mul460.2.1, %mul157, !dbg !181
  %add466.2.1 = or disjoint i32 %add461.2.1, %mul465, !dbg !182
  %add.ptr468.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.2.1, !dbg !183
  store i64 %output_reg.sroa.30.2, ptr addrspace(3) %add.ptr468.2.1, align 8, !dbg !184
  %xor459.3.1 = xor i32 %add456.3.1.pre-phi, %and163, !dbg !179
  %mul460.3.1 = shl nuw nsw i32 %xor459.3.1, 3, !dbg !180
  %add461.3.1 = add nuw nsw i32 %mul460.3.1, %mul157, !dbg !181
  %add466.3.1 = or disjoint i32 %add461.3.1, %mul465, !dbg !182
  %add.ptr468.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.3.1, !dbg !183
  store i64 %output_reg.sroa.44.2, ptr addrspace(3) %add.ptr468.3.1, align 8, !dbg !184
  %xor459.4.1 = xor i32 %add456.4.1.pre-phi, %and163, !dbg !179
  %mul460.4.1 = shl nuw nsw i32 %xor459.4.1, 3, !dbg !180
  %add461.4.1 = add nuw nsw i32 %mul460.4.1, %mul157, !dbg !181
  %add466.4.1 = or disjoint i32 %add461.4.1, %mul465, !dbg !182
  %add.ptr468.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.4.1, !dbg !183
  store i64 %output_reg.sroa.58.2, ptr addrspace(3) %add.ptr468.4.1, align 8, !dbg !184
  %xor459.5.1 = xor i32 %add456.5.1.pre-phi, %and163, !dbg !179
  %mul460.5.1 = shl nuw nsw i32 %xor459.5.1, 3, !dbg !180
  %add461.5.1 = add nuw nsw i32 %mul460.5.1, %mul157, !dbg !181
  %add466.5.1 = or disjoint i32 %add461.5.1, %mul465, !dbg !182
  %add.ptr468.5.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.5.1, !dbg !183
  store i64 %output_reg.sroa.72.2, ptr addrspace(3) %add.ptr468.5.1, align 8, !dbg !184
  %xor459.6.1 = xor i32 %add456.6.1.pre-phi, %and163, !dbg !179
  %mul460.6.1 = shl nuw nsw i32 %xor459.6.1, 3, !dbg !180
  %add461.6.1 = add nuw nsw i32 %mul460.6.1, %mul157, !dbg !181
  %add466.6.1 = or disjoint i32 %add461.6.1, %mul465, !dbg !182
  %add.ptr468.6.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.6.1, !dbg !183
  store i64 %output_reg.sroa.86.2, ptr addrspace(3) %add.ptr468.6.1, align 8, !dbg !184
  %xor459.7.1 = xor i32 %add456.7.1.pre-phi, %and163, !dbg !179
  %mul460.7.1 = shl nuw nsw i32 %xor459.7.1, 3, !dbg !180
  %add461.7.1 = add nuw nsw i32 %mul460.7.1, %mul157, !dbg !181
  %add466.7.1 = or disjoint i32 %add461.7.1, %mul465, !dbg !182
  %add.ptr468.7.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.7.1, !dbg !183
  store i64 %output_reg.sroa.100.2, ptr addrspace(3) %add.ptr468.7.1, align 8, !dbg !184
  fence syncscope("warp") release, !dbg !185
  tail call void @llvm.mxc.barrier.warp(), !dbg !188
  fence syncscope("warp") acquire, !dbg !189
  br i1 %cmp42.1, label %if.end485.1825, label %if.end518.3.1, !dbg !190

if.end485.1825:                                   ; preds = %if.end441.1
  %mul509.1 = shl nuw nsw i32 %7, 11
  %add512.1 = add nuw nsw i32 %add510, %mul509.1
  %325 = zext nneg i32 %add512.1 to i64, !dbg !191
  %xor501.1821 = xor i32 %shr160, %and163, !dbg !192
  %add.ptr505.idx.1822 = shl nuw nsw i32 %xor501.1821, 4, !dbg !193
  %add.ptr505.1823 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep711, i32 %add.ptr505.idx.1822, !dbg !193
  %add.ptr517.1824 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %325, !dbg !194
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr517.1824, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr505.1823, i64 16, i1 false), !dbg !195, !tbaa.struct !196, !call_argsrelate !197
  %326 = add nuw nsw i32 %shr160, 4, !dbg !198
  %xor501.1.1 = xor i32 %326, %and163, !dbg !192
  %gep712.1.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep711, i32 1024, !dbg !193
  %add.ptr505.idx.1.1 = shl nuw nsw i32 %xor501.1.1, 4, !dbg !193
  %add.ptr505.1.1 = getelementptr inbounds i8, ptr addrspace(3) %gep712.1.1, i32 %add.ptr505.idx.1.1, !dbg !193
  %327 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %325, !dbg !194
  %add.ptr517.1.1 = getelementptr inbounds i8, ptr addrspace(1) %327, i64 1024, !dbg !194
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr517.1.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr505.1.1, i64 16, i1 false), !dbg !195, !tbaa.struct !196, !call_argsrelate !197
  %328 = add nuw nsw i32 %shr160, 8, !dbg !198
  %xor501.2.1 = xor i32 %328, %and163, !dbg !192
  %gep712.2.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep711, i32 2048, !dbg !193
  %add.ptr505.idx.2.1 = shl nuw nsw i32 %xor501.2.1, 4, !dbg !193
  %add.ptr505.2.1 = getelementptr inbounds i8, ptr addrspace(3) %gep712.2.1, i32 %add.ptr505.idx.2.1, !dbg !193
  %329 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %325, !dbg !194
  %add.ptr517.2.1 = getelementptr inbounds i8, ptr addrspace(1) %329, i64 2048, !dbg !194
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr517.2.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr505.2.1, i64 16, i1 false), !dbg !195, !tbaa.struct !196, !call_argsrelate !197
  %narrow = add nuw nsw i32 %shr160, 12, !dbg !198
  %xor501.3.1 = xor i32 %narrow, %and163, !dbg !192
  %gep712.3.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep711, i32 3072, !dbg !193
  %add.ptr505.idx.3.1 = shl nuw nsw i32 %xor501.3.1, 4, !dbg !193
  %add.ptr505.3.1 = getelementptr inbounds i8, ptr addrspace(3) %gep712.3.1, i32 %add.ptr505.idx.3.1, !dbg !193
  %330 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %325, !dbg !194
  %add.ptr517.3.1 = getelementptr inbounds i8, ptr addrspace(1) %330, i64 3072, !dbg !194
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr517.3.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr505.3.1, i64 16, i1 false), !dbg !195, !tbaa.struct !196, !call_argsrelate !197
  br label %if.end518.3.1, !dbg !199

if.end518.3.1:                                    ; preds = %if.end441.1, %if.end485.1825
  fence syncscope("warp") release, !dbg !200
  tail call void @llvm.mxc.barrier.warp(), !dbg !203
  fence syncscope("warp") acquire, !dbg !204
  br label %if.end526, !dbg !205

if.end526:                                        ; preds = %if.end522, %if.end518.3.1, %entry
  ret void, !dbg !206
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
declare void @llvm.mxc.barrier.warp() #7

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
declare void @llvm.mxc.sleep(i32 immarg) #8

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp2.f32(float) #9

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.minnum.f32(float, float) #9

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
attributes #8 = { nounwind willreturn }
attributes #9 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #11 = { nomerge }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmp6rme96vt/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmp6rme96vt/tvm_kernels.maca", directory: "")
!42 = !DILocation(line: 77, column: 3, scope: !43, inlinedAt: !45)
!43 = distinct !DISubprogram(name: "__fetch_builtin_x", scope: !44, file: !44, line: 77, type: !7, scopeLine: 77, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!44 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_builtin_vars.h", directory: "")
!45 = distinct !DILocation(line: 22, column: 13, scope: !40)
!46 = !DILocation(line: 78, column: 3, scope: !47, inlinedAt: !48)
!47 = distinct !DISubprogram(name: "__fetch_builtin_y", scope: !44, file: !44, line: 78, type: !7, scopeLine: 78, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!48 = distinct !DILocation(line: 22, column: 43, scope: !40)
!49 = !DILocation(line: 22, column: 55, scope: !40)
!50 = !DILocation(line: 22, column: 27, scope: !40)
!51 = !DILocation(line: 22, column: 25, scope: !40)
!52 = !DILocation(line: 22, column: 7, scope: !40)
!53 = !DILocation(line: 23, column: 75, scope: !40)
!54 = !DILocation(line: 23, column: 54, scope: !40)
!55 = !DILocation(line: 23, column: 17, scope: !40)
!56 = !DILocation(line: 24, column: 23, scope: !40)
!57 = !DILocation(line: 25, column: 24, scope: !40)
!58 = !DILocation(line: 27, column: 10, scope: !40)
!59 = !{i32 0, i32 1024}
!60 = !DILocation(line: 34, column: 13, scope: !40)
!61 = !DILocation(line: 34, column: 11, scope: !40)
!62 = !DILocation(line: 45, column: 15, scope: !40)
!63 = !DILocation(line: 179, column: 100, scope: !40)
!64 = !DILocation(line: 68, column: 3, scope: !65, inlinedAt: !67)
!65 = distinct !DISubprogram(name: "__barrier_warp", scope: !66, file: !66, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!66 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!67 = distinct !DILocation(line: 192, column: 3, scope: !68, inlinedAt: !69)
!68 = distinct !DISubprogram(name: "__syncwarp", scope: !66, file: !66, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!69 = distinct !DILocation(line: 176, column: 9, scope: !40)
!70 = !DILocation(line: 58, column: 37, scope: !40)
!71 = !DILocation(line: 58, column: 23, scope: !40)
!72 = !DILocation(line: 59, column: 11, scope: !40)
!73 = !DILocation(line: 0, scope: !40)
!74 = !DILocation(line: 62, column: 40, scope: !40)
!75 = !DILocation(line: 70, column: 37, scope: !40)
!76 = !DILocation(line: 75, column: 61, scope: !40)
!77 = !DILocation(line: 75, column: 40, scope: !40)
!78 = !DILocation(line: 80, column: 140, scope: !40)
!79 = !DILocation(line: 80, column: 48, scope: !40)
!80 = !DILocation(line: 80, column: 232, scope: !40)
!81 = !DILocation(line: 80, column: 153, scope: !40)
!82 = !DILocation(line: 68, column: 3, scope: !65, inlinedAt: !83)
!83 = distinct !DILocation(line: 192, column: 3, scope: !68, inlinedAt: !84)
!84 = distinct !DILocation(line: 82, column: 11, scope: !40)
!85 = !DILocation(line: 69, column: 3, scope: !65, inlinedAt: !83)
!86 = !DILocation(line: 70, column: 3, scope: !65, inlinedAt: !83)
!87 = !DILocation(line: 85, column: 157, scope: !40)
!88 = !DILocation(line: 85, column: 75, scope: !40)
!89 = !DILocation(line: 85, column: 38, scope: !40)
!90 = !DILocation(line: 85, column: 128, scope: !40)
!91 = !DILocation(line: 96, column: 120, scope: !40)
!92 = !DILocation(line: 96, column: 17, scope: !40)
!93 = !DILocation(line: 101, column: 25, scope: !40)
!94 = !DILocation(line: 96, column: 72, scope: !40)
!95 = !DILocation(line: 96, column: 107, scope: !40)
!96 = !DILocation(line: 107, column: 37, scope: !40)
!97 = !{i32 1, i32 -1, i32 -1}
!98 = !DILocation(line: 117, column: 61, scope: !40)
!99 = !DILocation(line: 117, column: 40, scope: !40)
!100 = !DILocation(line: 122, column: 38, scope: !40)
!101 = !DILocation(line: 122, column: 50, scope: !40)
!102 = !DILocation(line: 354, column: 10, scope: !103, inlinedAt: !105)
!103 = distinct !DISubprogram(name: "min", scope: !104, file: !104, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!104 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!105 = distinct !DILocation(line: 122, column: 33, scope: !40)
!106 = !DILocation(line: 285, column: 49, scope: !107, inlinedAt: !108)
!107 = distinct !DISubprogram(name: "exp2f", scope: !104, file: !104, line: 285, type: !7, scopeLine: 285, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!108 = distinct !DILocation(line: 122, column: 27, scope: !40)
!109 = !DILocation(line: 127, column: 34, scope: !40)
!110 = !DILocation(line: 1018, column: 9, scope: !111, inlinedAt: !112)
!111 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !66, file: !66, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!112 = distinct !DILocation(line: 396, column: 10, scope: !113, inlinedAt: !115)
!113 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !114, file: !114, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!114 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!115 = distinct !DILocation(line: 129, column: 24, scope: !116, inlinedAt: !118)
!116 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !117, file: !117, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!117 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!118 = distinct !DILocation(line: 101, column: 14, scope: !119, inlinedAt: !120)
!119 = distinct !DISubprogram(name: "run<float>", scope: !117, file: !117, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!120 = distinct !DILocation(line: 129, column: 22, scope: !40)
!121 = !DILocation(line: 171, column: 37, scope: !122, inlinedAt: !123)
!122 = distinct !DISubprogram(name: "__lane_id", scope: !66, file: !66, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!123 = distinct !DILocation(line: 990, column: 14, scope: !124, inlinedAt: !125)
!124 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !66, file: !66, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!125 = distinct !DILocation(line: 1019, column: 11, scope: !111, inlinedAt: !112)
!126 = !DILocation(line: 171, column: 10, scope: !122, inlinedAt: !123)
!127 = !DILocation(line: 991, column: 20, scope: !124, inlinedAt: !125)
!128 = !DILocation(line: 992, column: 36, scope: !124, inlinedAt: !125)
!129 = !DILocation(line: 992, column: 17, scope: !124, inlinedAt: !125)
!130 = !DILocation(line: 992, column: 11, scope: !124, inlinedAt: !125)
!131 = !DILocation(line: 993, column: 43, scope: !124, inlinedAt: !125)
!132 = !DILocation(line: 993, column: 10, scope: !124, inlinedAt: !125)
!133 = !DILocation(line: 1020, column: 14, scope: !111, inlinedAt: !112)
!134 = !DILocation(line: 25, column: 14, scope: !135, inlinedAt: !136)
!135 = distinct !DISubprogram(name: "operator()<float>", scope: !117, file: !117, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!136 = distinct !DILocation(line: 129, column: 11, scope: !116, inlinedAt: !118)
!137 = !DILocation(line: 1018, column: 9, scope: !111, inlinedAt: !138)
!138 = distinct !DILocation(line: 396, column: 10, scope: !113, inlinedAt: !139)
!139 = distinct !DILocation(line: 129, column: 24, scope: !140, inlinedAt: !141)
!140 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !117, file: !117, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!141 = distinct !DILocation(line: 101, column: 14, scope: !142, inlinedAt: !143)
!142 = distinct !DISubprogram(name: "run<float>", scope: !117, file: !117, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!143 = distinct !DILocation(line: 134, column: 14, scope: !116, inlinedAt: !118)
!144 = !DILocation(line: 171, column: 37, scope: !122, inlinedAt: !145)
!145 = distinct !DILocation(line: 990, column: 14, scope: !124, inlinedAt: !146)
!146 = distinct !DILocation(line: 1019, column: 11, scope: !111, inlinedAt: !138)
!147 = !DILocation(line: 171, column: 10, scope: !122, inlinedAt: !145)
!148 = !DILocation(line: 991, column: 20, scope: !124, inlinedAt: !146)
!149 = !DILocation(line: 992, column: 36, scope: !124, inlinedAt: !146)
!150 = !DILocation(line: 992, column: 17, scope: !124, inlinedAt: !146)
!151 = !DILocation(line: 992, column: 11, scope: !124, inlinedAt: !146)
!152 = !DILocation(line: 993, column: 43, scope: !124, inlinedAt: !146)
!153 = !DILocation(line: 993, column: 10, scope: !124, inlinedAt: !146)
!154 = !DILocation(line: 1020, column: 14, scope: !111, inlinedAt: !138)
!155 = !DILocation(line: 25, column: 14, scope: !135, inlinedAt: !156)
!156 = distinct !DILocation(line: 129, column: 11, scope: !140, inlinedAt: !141)
!157 = !DILocation(line: 131, column: 40, scope: !40)
!158 = !DILocation(line: 131, column: 15, scope: !40)
!159 = !DILocation(line: 139, column: 40, scope: !40)
!160 = !DILocation(line: 75, column: 10, scope: !161, inlinedAt: !163)
!161 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !162, file: !162, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!162 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!163 = distinct !DILocation(line: 984, column: 9, scope: !164, inlinedAt: !166)
!164 = distinct !DISubprogram(name: "__float2half", scope: !165, file: !165, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!165 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!166 = distinct !DILocation(line: 133, column: 53, scope: !167, inlinedAt: !168)
!167 = distinct !DISubprogram(name: "__half", scope: !165, file: !165, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!168 = distinct !DILocation(line: 145, column: 55, scope: !40)
!169 = !DILocation(line: 145, column: 52, scope: !40)
!170 = !DILocation(line: 156, column: 36, scope: !40)
!171 = !DILocation(line: 166, column: 73, scope: !40)
!172 = !DILocation(line: 75, column: 10, scope: !161, inlinedAt: !173)
!173 = distinct !DILocation(line: 984, column: 9, scope: !164, inlinedAt: !174)
!174 = distinct !DILocation(line: 133, column: 53, scope: !167, inlinedAt: !175)
!175 = distinct !DILocation(line: 166, column: 65, scope: !40)
!176 = !DILocation(line: 166, column: 62, scope: !40)
!177 = !DILocation(line: 69, column: 3, scope: !65, inlinedAt: !67)
!178 = !DILocation(line: 70, column: 3, scope: !65, inlinedAt: !67)
!179 = !DILocation(line: 179, column: 129, scope: !40)
!180 = !DILocation(line: 179, column: 158, scope: !40)
!181 = !DILocation(line: 179, column: 84, scope: !40)
!182 = !DILocation(line: 179, column: 164, scope: !40)
!183 = !DILocation(line: 179, column: 46, scope: !40)
!184 = !DILocation(line: 179, column: 207, scope: !40)
!185 = !DILocation(line: 68, column: 3, scope: !65, inlinedAt: !186)
!186 = distinct !DILocation(line: 192, column: 3, scope: !68, inlinedAt: !187)
!187 = distinct !DILocation(line: 181, column: 9, scope: !40)
!188 = !DILocation(line: 69, column: 3, scope: !65, inlinedAt: !186)
!189 = !DILocation(line: 70, column: 3, scope: !65, inlinedAt: !186)
!190 = !DILocation(line: 190, column: 15, scope: !40)
!191 = !DILocation(line: 183, column: 9, scope: !40)
!192 = !DILocation(line: 203, column: 261, scope: !40)
!193 = !DILocation(line: 203, column: 177, scope: !40)
!194 = !DILocation(line: 203, column: 30, scope: !40)
!195 = !DILocation(line: 203, column: 140, scope: !40)
!196 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!197 = !{i32 0, i32 -1, i32 -1, i32 -1}
!198 = !DILocation(line: 203, column: 275, scope: !40)
!199 = !DILocation(line: 204, column: 11, scope: !40)
!200 = !DILocation(line: 68, column: 3, scope: !65, inlinedAt: !201)
!201 = distinct !DILocation(line: 192, column: 3, scope: !68, inlinedAt: !202)
!202 = distinct !DILocation(line: 206, column: 9, scope: !40)
!203 = !DILocation(line: 69, column: 3, scope: !65, inlinedAt: !201)
!204 = !DILocation(line: 70, column: 3, scope: !65, inlinedAt: !201)
!205 = !DILocation(line: 207, column: 7, scope: !40)
!206 = !DILocation(line: 210, column: 1, scope: !40)
