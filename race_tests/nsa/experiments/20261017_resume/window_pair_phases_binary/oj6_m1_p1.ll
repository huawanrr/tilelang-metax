; ModuleID = 'experiments/20261017_resume/window_pair_phases_binary/oj6_m1_p1.bc'
source_filename = "/tmp/tmp4z6w3glz/tvm_kernels.maca"
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
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias noundef readonly %PackedKV.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(1) noalias nocapture noundef readonly %Schedule.coerce) local_unnamed_addr #3 !dbg !40 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !dbg !42, !range !29
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !dbg !46, !range !29
  %mul = mul nuw nsw i32 %1, 241, !dbg !49
  %idxprom = zext nneg i32 %mul to i64, !dbg !50
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %Schedule.coerce, i64 %idxprom, !dbg !50
  %2 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !50, !tbaa !30
  %cmp = icmp slt i32 %0, %2, !dbg !51
  br i1 %cmp, label %if.then, label %if.end571, !dbg !52

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
  %invariant.gep768 = getelementptr i8, ptr addrspace(4) %PackedKV.coerce, i64 8192, !dbg !58
  %8 = lshr i32 %1, 3
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
  %invariant.gep744 = getelementptr %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %mul109
  %and = lshr i32 %9, 1
  %shr134 = and i32 %and, 15
  %shr137 = lshr i32 %9, 5
  %add132 = and i32 %10, 3972
  %and156 = shl nuw nsw i32 %9, 7
  %mul157 = and i32 %and156, 1920
  %shr160 = lshr i32 %9, 4
  %and163 = and i32 %9, 15
  %gep767 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %mul157
  %13 = lshr i32 %9, 2
  %mul193 = and i32 %13, 252
  %add190 = add nuw nsw i32 %mul88, %mul193
  %cmp247 = icmp slt i32 %7, 0
  %gep769 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep768, i64 %mul109
  %cmp32 = icmp sgt i32 %6, -1, !dbg !60
  br i1 %cmp32, label %for.cond34.preheader, label %if.end357, !dbg !61

for.cond34.preheader:                             ; preds = %if.then
  %cmp42 = icmp ult i32 %6, 1024
  %condval_4.0 = zext nneg i32 %6 to i64
  br i1 %cmp42, label %if.then43, label %if.end79, !dbg !62

if.then43:                                        ; preds = %for.cond34.preheader
  %.idx787 = shl nuw nsw i64 %condval_4.0, 12, !dbg !63
  %14 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787, !dbg !63
  %.idx788 = shl nuw nsw i64 %shr, 22, !dbg !63
  %15 = getelementptr i8, ptr addrspace(4) %14, i64 %.idx788, !dbg !63
  %condval_1.sroa.0.0.copyload = load i32, ptr addrspace(4) %15, align 8, !dbg !64, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %15, i64 4, !dbg !64
  %condval_1.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx, align 4, !dbg !64, !tbaa !30
  br label %if.end79, !dbg !65

if.end79:                                         ; preds = %for.cond34.preheader, %if.then43
  %condval_1.sroa.0.0 = phi i32 [ %condval_1.sroa.0.0.copyload, %if.then43 ], [ 0, %for.cond34.preheader ], !dbg !66
  %condval_1.sroa.5.0 = phi i32 [ %condval_1.sroa.5.0.copyload, %if.then43 ], [ 0, %for.cond34.preheader ], !dbg !66
  %q_stage.sroa.0.0.insert.ext = zext i32 %condval_1.sroa.0.0 to i64, !dbg !67
  %q_stage.sroa.0.4.insert.ext = zext i32 %condval_1.sroa.5.0 to i64, !dbg !67
  %q_stage.sroa.0.4.insert.shift = shl nuw i64 %q_stage.sroa.0.4.insert.ext, 32, !dbg !67
  %q_stage.sroa.0.4.insert.insert = or disjoint i64 %q_stage.sroa.0.4.insert.shift, %q_stage.sroa.0.0.insert.ext, !dbg !67
  br i1 %cmp42, label %if.then43.1, label %if.end79.1, !dbg !62

if.then43.1:                                      ; preds = %if.end79
  %.idx787.1 = shl nuw nsw i64 %condval_4.0, 12, !dbg !63
  %16 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787.1, !dbg !63
  %.idx788.1 = shl nuw nsw i64 %shr, 22, !dbg !63
  %17 = getelementptr i8, ptr addrspace(4) %16, i64 %.idx788.1, !dbg !63
  %gep.1 = getelementptr i8, ptr addrspace(4) %17, i64 512, !dbg !63
  %condval_1.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %gep.1, align 8, !dbg !64, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.1 = getelementptr i8, ptr addrspace(4) %17, i64 516, !dbg !64
  %condval_1.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.1, align 4, !dbg !64, !tbaa !30
  br label %if.end79.1, !dbg !65

if.end79.1:                                       ; preds = %if.then43.1, %if.end79
  %condval_1.sroa.0.0.1 = phi i32 [ %condval_1.sroa.0.0.copyload.1, %if.then43.1 ], [ 0, %if.end79 ], !dbg !66
  %condval_1.sroa.5.0.1 = phi i32 [ %condval_1.sroa.5.0.copyload.1, %if.then43.1 ], [ 0, %if.end79 ], !dbg !66
  %q_stage.sroa.8.8.insert.ext = zext i32 %condval_1.sroa.0.0.1 to i64, !dbg !67
  %q_stage.sroa.8.12.insert.ext = zext i32 %condval_1.sroa.5.0.1 to i64, !dbg !67
  %q_stage.sroa.8.12.insert.shift = shl nuw i64 %q_stage.sroa.8.12.insert.ext, 32, !dbg !67
  %q_stage.sroa.8.12.insert.insert = or disjoint i64 %q_stage.sroa.8.12.insert.shift, %q_stage.sroa.8.8.insert.ext, !dbg !67
  br i1 %cmp42, label %if.then43.2, label %if.end79.2, !dbg !62

if.then43.2:                                      ; preds = %if.end79.1
  %.idx787.2 = shl nuw nsw i64 %condval_4.0, 12, !dbg !63
  %18 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787.2, !dbg !63
  %.idx788.2 = shl nuw nsw i64 %shr, 22, !dbg !63
  %19 = getelementptr i8, ptr addrspace(4) %18, i64 %.idx788.2, !dbg !63
  %gep.2 = getelementptr i8, ptr addrspace(4) %19, i64 1024, !dbg !63
  %condval_1.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %gep.2, align 8, !dbg !64, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.2 = getelementptr i8, ptr addrspace(4) %19, i64 1028, !dbg !64
  %condval_1.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.2, align 4, !dbg !64, !tbaa !30
  br label %if.end79.2, !dbg !65

if.end79.2:                                       ; preds = %if.then43.2, %if.end79.1
  %condval_1.sroa.0.0.2 = phi i32 [ %condval_1.sroa.0.0.copyload.2, %if.then43.2 ], [ 0, %if.end79.1 ], !dbg !66
  %condval_1.sroa.5.0.2 = phi i32 [ %condval_1.sroa.5.0.copyload.2, %if.then43.2 ], [ 0, %if.end79.1 ], !dbg !66
  %q_stage.sroa.14.16.insert.ext = zext i32 %condval_1.sroa.0.0.2 to i64, !dbg !67
  %q_stage.sroa.14.20.insert.ext = zext i32 %condval_1.sroa.5.0.2 to i64, !dbg !67
  %q_stage.sroa.14.20.insert.shift = shl nuw i64 %q_stage.sroa.14.20.insert.ext, 32, !dbg !67
  %q_stage.sroa.14.20.insert.insert = or disjoint i64 %q_stage.sroa.14.20.insert.shift, %q_stage.sroa.14.16.insert.ext, !dbg !67
  br i1 %cmp42, label %if.then43.3, label %if.end79.3, !dbg !62

if.then43.3:                                      ; preds = %if.end79.2
  %.idx787.3 = shl nuw nsw i64 %condval_4.0, 12, !dbg !63
  %20 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787.3, !dbg !63
  %.idx788.3 = shl nuw nsw i64 %shr, 22, !dbg !63
  %21 = getelementptr i8, ptr addrspace(4) %20, i64 %.idx788.3, !dbg !63
  %gep.3 = getelementptr i8, ptr addrspace(4) %21, i64 1536, !dbg !63
  %condval_1.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %gep.3, align 8, !dbg !64, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.3 = getelementptr i8, ptr addrspace(4) %21, i64 1540, !dbg !64
  %condval_1.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.3, align 4, !dbg !64, !tbaa !30
  br label %if.end79.3, !dbg !65

if.end79.3:                                       ; preds = %if.then43.3, %if.end79.2
  %condval_1.sroa.0.0.3 = phi i32 [ %condval_1.sroa.0.0.copyload.3, %if.then43.3 ], [ 0, %if.end79.2 ], !dbg !66
  %condval_1.sroa.5.0.3 = phi i32 [ %condval_1.sroa.5.0.copyload.3, %if.then43.3 ], [ 0, %if.end79.2 ], !dbg !66
  %q_stage.sroa.20.24.insert.ext = zext i32 %condval_1.sroa.0.0.3 to i64, !dbg !67
  %q_stage.sroa.20.28.insert.ext = zext i32 %condval_1.sroa.5.0.3 to i64, !dbg !67
  %q_stage.sroa.20.28.insert.shift = shl nuw i64 %q_stage.sroa.20.28.insert.ext, 32, !dbg !67
  %q_stage.sroa.20.28.insert.insert = or disjoint i64 %q_stage.sroa.20.28.insert.shift, %q_stage.sroa.20.24.insert.ext, !dbg !67
  br i1 %cmp42, label %if.then43.4, label %if.end79.4, !dbg !62

if.then43.4:                                      ; preds = %if.end79.3
  %.idx787.4 = shl nuw nsw i64 %condval_4.0, 12, !dbg !63
  %22 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787.4, !dbg !63
  %.idx788.4 = shl nuw nsw i64 %shr, 22, !dbg !63
  %23 = getelementptr i8, ptr addrspace(4) %22, i64 %.idx788.4, !dbg !63
  %gep.4 = getelementptr i8, ptr addrspace(4) %23, i64 2048, !dbg !63
  %condval_1.sroa.0.0.copyload.4 = load i32, ptr addrspace(4) %gep.4, align 8, !dbg !64, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.4 = getelementptr i8, ptr addrspace(4) %23, i64 2052, !dbg !64
  %condval_1.sroa.5.0.copyload.4 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.4, align 4, !dbg !64, !tbaa !30
  br label %if.end79.4, !dbg !65

if.end79.4:                                       ; preds = %if.then43.4, %if.end79.3
  %condval_1.sroa.0.0.4 = phi i32 [ %condval_1.sroa.0.0.copyload.4, %if.then43.4 ], [ 0, %if.end79.3 ], !dbg !66
  %condval_1.sroa.5.0.4 = phi i32 [ %condval_1.sroa.5.0.copyload.4, %if.then43.4 ], [ 0, %if.end79.3 ], !dbg !66
  %q_stage.sroa.26.32.insert.ext = zext i32 %condval_1.sroa.0.0.4 to i64, !dbg !67
  %q_stage.sroa.26.36.insert.ext = zext i32 %condval_1.sroa.5.0.4 to i64, !dbg !67
  %q_stage.sroa.26.36.insert.shift = shl nuw i64 %q_stage.sroa.26.36.insert.ext, 32, !dbg !67
  %q_stage.sroa.26.36.insert.insert = or disjoint i64 %q_stage.sroa.26.36.insert.shift, %q_stage.sroa.26.32.insert.ext, !dbg !67
  br i1 %cmp42, label %if.then43.5, label %if.end79.5, !dbg !62

if.then43.5:                                      ; preds = %if.end79.4
  %.idx787.5 = shl nuw nsw i64 %condval_4.0, 12, !dbg !63
  %24 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787.5, !dbg !63
  %.idx788.5 = shl nuw nsw i64 %shr, 22, !dbg !63
  %25 = getelementptr i8, ptr addrspace(4) %24, i64 %.idx788.5, !dbg !63
  %gep.5 = getelementptr i8, ptr addrspace(4) %25, i64 2560, !dbg !63
  %condval_1.sroa.0.0.copyload.5 = load i32, ptr addrspace(4) %gep.5, align 8, !dbg !64, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.5 = getelementptr i8, ptr addrspace(4) %25, i64 2564, !dbg !64
  %condval_1.sroa.5.0.copyload.5 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.5, align 4, !dbg !64, !tbaa !30
  br label %if.end79.5, !dbg !65

if.end79.5:                                       ; preds = %if.then43.5, %if.end79.4
  %condval_1.sroa.0.0.5 = phi i32 [ %condval_1.sroa.0.0.copyload.5, %if.then43.5 ], [ 0, %if.end79.4 ], !dbg !66
  %condval_1.sroa.5.0.5 = phi i32 [ %condval_1.sroa.5.0.copyload.5, %if.then43.5 ], [ 0, %if.end79.4 ], !dbg !66
  %q_stage.sroa.32.40.insert.ext = zext i32 %condval_1.sroa.0.0.5 to i64, !dbg !67
  %q_stage.sroa.32.44.insert.ext = zext i32 %condval_1.sroa.5.0.5 to i64, !dbg !67
  %q_stage.sroa.32.44.insert.shift = shl nuw i64 %q_stage.sroa.32.44.insert.ext, 32, !dbg !67
  %q_stage.sroa.32.44.insert.insert = or disjoint i64 %q_stage.sroa.32.44.insert.shift, %q_stage.sroa.32.40.insert.ext, !dbg !67
  br i1 %cmp42, label %if.then43.6, label %if.end79.6, !dbg !62

if.then43.6:                                      ; preds = %if.end79.5
  %.idx787.6 = shl nuw nsw i64 %condval_4.0, 12, !dbg !63
  %26 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787.6, !dbg !63
  %.idx788.6 = shl nuw nsw i64 %shr, 22, !dbg !63
  %27 = getelementptr i8, ptr addrspace(4) %26, i64 %.idx788.6, !dbg !63
  %gep.6 = getelementptr i8, ptr addrspace(4) %27, i64 3072, !dbg !63
  %condval_1.sroa.0.0.copyload.6 = load i32, ptr addrspace(4) %gep.6, align 8, !dbg !64, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.6 = getelementptr i8, ptr addrspace(4) %27, i64 3076, !dbg !64
  %condval_1.sroa.5.0.copyload.6 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.6, align 4, !dbg !64, !tbaa !30
  br label %if.end79.6, !dbg !65

if.end79.6:                                       ; preds = %if.then43.6, %if.end79.5
  %condval_1.sroa.0.0.6 = phi i32 [ %condval_1.sroa.0.0.copyload.6, %if.then43.6 ], [ 0, %if.end79.5 ], !dbg !66
  %condval_1.sroa.5.0.6 = phi i32 [ %condval_1.sroa.5.0.copyload.6, %if.then43.6 ], [ 0, %if.end79.5 ], !dbg !66
  %q_stage.sroa.38.48.insert.ext = zext i32 %condval_1.sroa.0.0.6 to i64, !dbg !67
  %q_stage.sroa.38.52.insert.ext = zext i32 %condval_1.sroa.5.0.6 to i64, !dbg !67
  %q_stage.sroa.38.52.insert.shift = shl nuw i64 %q_stage.sroa.38.52.insert.ext, 32, !dbg !67
  %q_stage.sroa.38.52.insert.insert = or disjoint i64 %q_stage.sroa.38.52.insert.shift, %q_stage.sroa.38.48.insert.ext, !dbg !67
  br i1 %cmp42, label %if.then43.7, label %if.end79.7, !dbg !62

if.then43.7:                                      ; preds = %if.end79.6
  %.idx787.7 = shl nuw nsw i64 %condval_4.0, 12, !dbg !63
  %28 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787.7, !dbg !63
  %.idx788.7 = shl nuw nsw i64 %shr, 22, !dbg !63
  %29 = getelementptr i8, ptr addrspace(4) %28, i64 %.idx788.7, !dbg !63
  %gep.7 = getelementptr i8, ptr addrspace(4) %29, i64 3584, !dbg !63
  %condval_1.sroa.0.0.copyload.7 = load i32, ptr addrspace(4) %gep.7, align 8, !dbg !64, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.7 = getelementptr i8, ptr addrspace(4) %29, i64 3588, !dbg !64
  %condval_1.sroa.5.0.copyload.7 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.7, align 4, !dbg !64, !tbaa !30
  br label %if.end79.7, !dbg !65

if.end79.7:                                       ; preds = %if.then43.7, %if.end79.6
  %condval_1.sroa.0.0.7 = phi i32 [ %condval_1.sroa.0.0.copyload.7, %if.then43.7 ], [ 0, %if.end79.6 ], !dbg !66
  %condval_1.sroa.5.0.7 = phi i32 [ %condval_1.sroa.5.0.copyload.7, %if.then43.7 ], [ 0, %if.end79.6 ], !dbg !66
  %cmp89 = icmp sle i32 %mul88, %6
  %or.cond785 = select i1 %cmp87, i1 %cmp89, i1 false, !dbg !68
  br i1 %or.cond785, label %for.body96.preheader, label %if.end357, !dbg !68

for.body96.preheader:                             ; preds = %if.end79.7
  %q_stage.sroa.44.60.insert.ext = zext i32 %condval_1.sroa.5.0.7 to i64, !dbg !67
  %q_stage.sroa.44.60.insert.shift = shl nuw i64 %q_stage.sroa.44.60.insert.ext, 32, !dbg !67
  %q_stage.sroa.44.56.insert.ext = zext i32 %condval_1.sroa.0.0.7 to i64, !dbg !67
  %q_stage.sroa.44.60.insert.insert = or disjoint i64 %q_stage.sroa.44.60.insert.shift, %q_stage.sroa.44.56.insert.ext, !dbg !67
  %.idx789 = shl nuw nsw i64 %shr, 19, !dbg !69
  %30 = getelementptr i8, ptr addrspace(4) %invariant.gep744, i64 %.idx789, !dbg !69
  %31 = getelementptr %struct.__half, ptr addrspace(4) %30, i64 %mul102, !dbg !69
  %k.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %31, align 16, !dbg !70
  %k.sroa.6.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %31, i64 8, !dbg !70
  %k.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.6.0..sroa_idx, align 8, !dbg !70
  %gep745.1 = getelementptr i8, ptr addrspace(4) %31, i64 1024, !dbg !69
  %k.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %gep745.1, align 16, !dbg !70
  %k.sroa.12.16.gep745.1.sroa_idx = getelementptr i8, ptr addrspace(4) %31, i64 1032, !dbg !70
  %k.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.12.16.gep745.1.sroa_idx, align 8, !dbg !70
  %gep745.2 = getelementptr i8, ptr addrspace(4) %31, i64 2048, !dbg !69
  %k.sroa.14.32.copyload = load <4 x half>, ptr addrspace(4) %gep745.2, align 16, !dbg !70
  %k.sroa.18.32.gep745.2.sroa_idx = getelementptr i8, ptr addrspace(4) %31, i64 2056, !dbg !70
  %k.sroa.18.32.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.18.32.gep745.2.sroa_idx, align 8, !dbg !70
  %gep745.3 = getelementptr i8, ptr addrspace(4) %31, i64 3072, !dbg !69
  %k.sroa.20.48.copyload = load <4 x half>, ptr addrspace(4) %gep745.3, align 16, !dbg !70
  %k.sroa.24.48.gep745.3.sroa_idx = getelementptr i8, ptr addrspace(4) %31, i64 3080, !dbg !70
  %k.sroa.24.48.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.24.48.gep745.3.sroa_idx, align 8, !dbg !70
  %gep745.4 = getelementptr i8, ptr addrspace(4) %31, i64 4096, !dbg !69
  %k.sroa.26.64.copyload = load <4 x half>, ptr addrspace(4) %gep745.4, align 16, !dbg !70
  %k.sroa.30.64.gep745.4.sroa_idx = getelementptr i8, ptr addrspace(4) %31, i64 4104, !dbg !70
  %k.sroa.30.64.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.30.64.gep745.4.sroa_idx, align 8, !dbg !70
  %gep745.5 = getelementptr i8, ptr addrspace(4) %31, i64 5120, !dbg !69
  %k.sroa.32.80.copyload = load <4 x half>, ptr addrspace(4) %gep745.5, align 16, !dbg !70
  %k.sroa.36.80.gep745.5.sroa_idx = getelementptr i8, ptr addrspace(4) %31, i64 5128, !dbg !70
  %k.sroa.36.80.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.36.80.gep745.5.sroa_idx, align 8, !dbg !70
  %gep745.6 = getelementptr i8, ptr addrspace(4) %31, i64 6144, !dbg !69
  %k.sroa.38.96.copyload = load <4 x half>, ptr addrspace(4) %gep745.6, align 16, !dbg !70
  %k.sroa.42.96.gep745.6.sroa_idx = getelementptr i8, ptr addrspace(4) %31, i64 6152, !dbg !70
  %k.sroa.42.96.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.42.96.gep745.6.sroa_idx, align 8, !dbg !70
  %gep745.7 = getelementptr i8, ptr addrspace(4) %31, i64 7168, !dbg !69
  %k.sroa.44.112.copyload = load <4 x half>, ptr addrspace(4) %gep745.7, align 16, !dbg !70
  %k.sroa.48.112.gep745.7.sroa_idx = getelementptr i8, ptr addrspace(4) %31, i64 7176, !dbg !70
  %k.sroa.48.112.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.48.112.gep745.7.sroa_idx, align 8, !dbg !70
  %xor = xor i32 %shr137, %shr134, !dbg !71
  %32 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %add132, !dbg !72
  %gep747.idx = shl nuw nsw i32 %xor, 4, !dbg !72
  %gep747 = getelementptr inbounds i8, ptr addrspace(3) %32, i32 %gep747.idx, !dbg !72
  store i64 %q_stage.sroa.0.4.insert.insert, ptr addrspace(3) %gep747, align 8, !dbg !73
  %add138.1 = add nuw nsw i32 %shr137, 2, !dbg !74
  %xor.1 = xor i32 %add138.1, %shr134, !dbg !71
  %33 = getelementptr inbounds i8, ptr addrspace(3) %32, i32 512, !dbg !72
  %gep747.idx.1 = shl nuw nsw i32 %xor.1, 4, !dbg !72
  %gep747.1 = getelementptr inbounds i8, ptr addrspace(3) %33, i32 %gep747.idx.1, !dbg !72
  store i64 %q_stage.sroa.8.12.insert.insert, ptr addrspace(3) %gep747.1, align 8, !dbg !73
  %add138.2 = add nuw nsw i32 %shr137, 4, !dbg !74
  %xor.2 = xor i32 %add138.2, %shr134, !dbg !71
  %34 = getelementptr inbounds i8, ptr addrspace(3) %32, i32 1024, !dbg !72
  %gep747.idx.2 = shl nuw nsw i32 %xor.2, 4, !dbg !72
  %gep747.2 = getelementptr inbounds i8, ptr addrspace(3) %34, i32 %gep747.idx.2, !dbg !72
  store i64 %q_stage.sroa.14.20.insert.insert, ptr addrspace(3) %gep747.2, align 8, !dbg !73
  %add138.3 = add nuw nsw i32 %shr137, 6, !dbg !74
  %xor.3 = xor i32 %add138.3, %shr134, !dbg !71
  %35 = getelementptr inbounds i8, ptr addrspace(3) %32, i32 1536, !dbg !72
  %gep747.idx.3 = shl nuw nsw i32 %xor.3, 4, !dbg !72
  %gep747.3 = getelementptr inbounds i8, ptr addrspace(3) %35, i32 %gep747.idx.3, !dbg !72
  store i64 %q_stage.sroa.20.28.insert.insert, ptr addrspace(3) %gep747.3, align 8, !dbg !73
  %add138.4 = add nuw nsw i32 %shr137, 8, !dbg !74
  %xor.4 = xor i32 %add138.4, %shr134, !dbg !71
  %36 = getelementptr inbounds i8, ptr addrspace(3) %32, i32 2048, !dbg !72
  %gep747.idx.4 = shl nuw nsw i32 %xor.4, 4, !dbg !72
  %gep747.4 = getelementptr inbounds i8, ptr addrspace(3) %36, i32 %gep747.idx.4, !dbg !72
  store i64 %q_stage.sroa.26.36.insert.insert, ptr addrspace(3) %gep747.4, align 8, !dbg !73
  %add138.5 = add nuw nsw i32 %shr137, 10, !dbg !74
  %xor.5 = xor i32 %add138.5, %shr134, !dbg !71
  %37 = getelementptr inbounds i8, ptr addrspace(3) %32, i32 2560, !dbg !72
  %gep747.idx.5 = shl nuw nsw i32 %xor.5, 4, !dbg !72
  %gep747.5 = getelementptr inbounds i8, ptr addrspace(3) %37, i32 %gep747.idx.5, !dbg !72
  store i64 %q_stage.sroa.32.44.insert.insert, ptr addrspace(3) %gep747.5, align 8, !dbg !73
  %add138.6 = add nuw nsw i32 %shr137, 12, !dbg !74
  %xor.6 = xor i32 %add138.6, %shr134, !dbg !71
  %38 = getelementptr inbounds i8, ptr addrspace(3) %32, i32 3072, !dbg !72
  %gep747.idx.6 = shl nuw nsw i32 %xor.6, 4, !dbg !72
  %gep747.6 = getelementptr inbounds i8, ptr addrspace(3) %38, i32 %gep747.idx.6, !dbg !72
  store i64 %q_stage.sroa.38.52.insert.insert, ptr addrspace(3) %gep747.6, align 8, !dbg !73
  %add138.7 = add nuw nsw i32 %shr137, 14, !dbg !74
  %xor.7 = xor i32 %add138.7, %shr134, !dbg !71
  %39 = getelementptr inbounds i8, ptr addrspace(3) %32, i32 3584, !dbg !72
  %gep747.idx.7 = shl nuw nsw i32 %xor.7, 4, !dbg !72
  %gep747.7 = getelementptr inbounds i8, ptr addrspace(3) %39, i32 %gep747.idx.7, !dbg !72
  store i64 %q_stage.sroa.44.60.insert.insert, ptr addrspace(3) %gep747.7, align 8, !dbg !73
  fence syncscope("warp") release, !dbg !75
  tail call void @llvm.mxc.barrier.warp(), !dbg !81
  fence syncscope("warp") acquire, !dbg !82
  %xor164 = xor i32 %shr160, %and163, !dbg !83
  %.idx = shl nuw nsw i32 %xor164, 4, !dbg !84
  %gep750 = getelementptr inbounds i8, ptr addrspace(3) %gep767, i32 %.idx, !dbg !84
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %gep750, align 16, !dbg !85
  %q.sroa.6.0.gep750.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep750, i32 8, !dbg !85
  %q.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.6.0.gep750.sroa_idx, align 8, !dbg !85
  %add161.1 = add nuw nsw i32 %shr160, 4, !dbg !86
  %xor164.1 = xor i32 %add161.1, %and163, !dbg !83
  %.idx.1 = shl nuw nsw i32 %xor164.1, 4, !dbg !84
  %gep750.1 = getelementptr inbounds i8, ptr addrspace(3) %gep767, i32 %.idx.1, !dbg !84
  %q.sroa.8.16.copyload = load <4 x half>, ptr addrspace(3) %gep750.1, align 16, !dbg !85
  %q.sroa.12.16.gep750.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep750.1, i32 8, !dbg !85
  %q.sroa.12.16.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.12.16.gep750.1.sroa_idx, align 8, !dbg !85
  %add161.2 = add nuw nsw i32 %shr160, 8, !dbg !86
  %xor164.2 = xor i32 %add161.2, %and163, !dbg !83
  %.idx.2 = shl nuw nsw i32 %xor164.2, 4, !dbg !84
  %gep750.2 = getelementptr inbounds i8, ptr addrspace(3) %gep767, i32 %.idx.2, !dbg !84
  %q.sroa.14.32.copyload = load <4 x half>, ptr addrspace(3) %gep750.2, align 16, !dbg !85
  %q.sroa.18.32.gep750.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep750.2, i32 8, !dbg !85
  %q.sroa.18.32.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.18.32.gep750.2.sroa_idx, align 8, !dbg !85
  %add161.3 = add nuw nsw i32 %shr160, 12, !dbg !86
  %xor164.3 = xor i32 %add161.3, %and163, !dbg !83
  %.idx.3 = shl nuw nsw i32 %xor164.3, 4, !dbg !84
  %gep750.3 = getelementptr inbounds i8, ptr addrspace(3) %gep767, i32 %.idx.3, !dbg !84
  %q.sroa.20.48.copyload = load <4 x half>, ptr addrspace(3) %gep750.3, align 16, !dbg !85
  %q.sroa.24.48.gep750.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep750.3, i32 8, !dbg !85
  %q.sroa.24.48.copyload = load <4 x half>, ptr addrspace(3) %q.sroa.24.48.gep750.3.sroa_idx, align 8, !dbg !85
  %cmp197.not = icmp sgt i32 %add190, %6, !dbg !87
  %spec.select = select i1 %cmp197.not, float 0xFFF0000000000000, float 0.000000e+00, !dbg !88
  %scores.sroa.0.0.vec.insert = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !89
  %cmp197.not.1.not = icmp slt i32 %add190, %6, !dbg !87
  %spec.select.1 = select i1 %cmp197.not.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.0.4.vec.insert = insertelement <4 x float> %scores.sroa.0.0.vec.insert, float %spec.select.1, i64 1, !dbg !89
  %add194.2 = or disjoint i32 %add190, 2, !dbg !90
  %cmp197.not.2 = icmp sgt i32 %add194.2, %6, !dbg !87
  %spec.select.2 = select i1 %cmp197.not.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !88
  %scores.sroa.0.8.vec.insert = insertelement <4 x float> %scores.sroa.0.4.vec.insert, float %spec.select.2, i64 2, !dbg !89
  %add194.3 = or disjoint i32 %add190, 3, !dbg !90
  %cmp197.not.3 = icmp sgt i32 %add194.3, %6, !dbg !87
  %spec.select.3 = select i1 %cmp197.not.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !88
  %scores.sroa.0.12.vec.insert = insertelement <4 x float> %scores.sroa.0.8.vec.insert, float %spec.select.3, i64 3, !dbg !89
  %add196.4 = add nuw nsw i32 %add190, 16, !dbg !91
  %cmp197.not.4 = icmp sgt i32 %add196.4, %6, !dbg !87
  %spec.select.4 = select i1 %cmp197.not.4, float 0xFFF0000000000000, float 0.000000e+00, !dbg !88
  %scores.sroa.90.16.vec.insert = insertelement <4 x float> poison, float %spec.select.4, i64 0, !dbg !89
  %add196.5 = add nuw nsw i32 %add190, 17, !dbg !91
  %cmp197.not.5 = icmp sgt i32 %add196.5, %6, !dbg !87
  %spec.select.5 = select i1 %cmp197.not.5, float 0xFFF0000000000000, float 0.000000e+00, !dbg !88
  %scores.sroa.90.20.vec.insert = insertelement <4 x float> %scores.sroa.90.16.vec.insert, float %spec.select.5, i64 1, !dbg !89
  %add196.6 = add nuw nsw i32 %add190, 18, !dbg !91
  %cmp197.not.6 = icmp sgt i32 %add196.6, %6, !dbg !87
  %spec.select.6 = select i1 %cmp197.not.6, float 0xFFF0000000000000, float 0.000000e+00, !dbg !88
  %scores.sroa.90.24.vec.insert = insertelement <4 x float> %scores.sroa.90.20.vec.insert, float %spec.select.6, i64 2, !dbg !89
  %add196.7 = add nuw nsw i32 %add190, 19, !dbg !91
  %cmp197.not.7 = icmp sgt i32 %add196.7, %6, !dbg !87
  %spec.select.7 = select i1 %cmp197.not.7, float 0xFFF0000000000000, float 0.000000e+00, !dbg !88
  %scores.sroa.90.28.vec.insert = insertelement <4 x float> %scores.sroa.90.24.vec.insert, float %spec.select.7, i64 3, !dbg !89
  %40 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.12.vec.insert), !dbg !92, !call_argsrelate !93
  %41 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.16.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.90.28.vec.insert), !dbg !92, !call_argsrelate !93
  %42 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.6.0.copyload, <4 x half> %q.sroa.6.0.copyload, <4 x float> %40), !dbg !92, !call_argsrelate !93
  %43 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.12.16.copyload, <4 x half> %q.sroa.6.0.copyload, <4 x float> %41), !dbg !92, !call_argsrelate !93
  %44 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.32.copyload, <4 x half> %q.sroa.8.16.copyload, <4 x float> %42), !dbg !92, !call_argsrelate !93
  %45 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.48.copyload, <4 x half> %q.sroa.8.16.copyload, <4 x float> %43), !dbg !92, !call_argsrelate !93
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.18.32.copyload, <4 x half> %q.sroa.12.16.copyload, <4 x float> %44), !dbg !92, !call_argsrelate !93
  %47 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.24.48.copyload, <4 x half> %q.sroa.12.16.copyload, <4 x float> %45), !dbg !92, !call_argsrelate !93
  %48 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.26.64.copyload, <4 x half> %q.sroa.14.32.copyload, <4 x float> %46), !dbg !92, !call_argsrelate !93
  %49 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.32.80.copyload, <4 x half> %q.sroa.14.32.copyload, <4 x float> %47), !dbg !92, !call_argsrelate !93
  %50 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.30.64.copyload, <4 x half> %q.sroa.18.32.copyload, <4 x float> %48), !dbg !92, !call_argsrelate !93
  %51 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.36.80.copyload, <4 x half> %q.sroa.18.32.copyload, <4 x float> %49), !dbg !92, !call_argsrelate !93
  %52 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.38.96.copyload, <4 x half> %q.sroa.20.48.copyload, <4 x float> %50), !dbg !92, !call_argsrelate !93
  %53 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.44.112.copyload, <4 x half> %q.sroa.20.48.copyload, <4 x float> %51), !dbg !92, !call_argsrelate !93
  %54 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.42.96.copyload, <4 x half> %q.sroa.24.48.copyload, <4 x float> %52), !dbg !92, !call_argsrelate !93
  %55 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.48.112.copyload, <4 x half> %q.sroa.24.48.copyload, <4 x float> %53), !dbg !92, !call_argsrelate !93
  br i1 %cmp247, label %for.body252.preheader, label %if.end276, !dbg !94

for.body252.preheader:                            ; preds = %for.body96.preheader
  %.idx793 = shl nuw nsw i64 %shr, 19, !dbg !95
  %56 = getelementptr i8, ptr addrspace(4) %gep769, i64 %.idx793, !dbg !95
  %57 = getelementptr %struct.__half, ptr addrspace(4) %56, i64 %mul102, !dbg !95
  %v.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %57, align 16, !dbg !96
  %v.sroa.6.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %57, i64 8, !dbg !96
  %v.sroa.6.0.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.6.0..sroa_idx, align 8, !dbg !96
  %gep759.1 = getelementptr i8, ptr addrspace(4) %57, i64 1024, !dbg !95
  %v.sroa.8.16.copyload = load <4 x half>, ptr addrspace(4) %gep759.1, align 16, !dbg !96
  %v.sroa.12.16.gep759.1.sroa_idx = getelementptr i8, ptr addrspace(4) %57, i64 1032, !dbg !96
  %v.sroa.12.16.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.12.16.gep759.1.sroa_idx, align 8, !dbg !96
  %gep759.2 = getelementptr i8, ptr addrspace(4) %57, i64 2048, !dbg !95
  %v.sroa.14.32.copyload = load <4 x half>, ptr addrspace(4) %gep759.2, align 16, !dbg !96
  %v.sroa.18.32.gep759.2.sroa_idx = getelementptr i8, ptr addrspace(4) %57, i64 2056, !dbg !96
  %v.sroa.18.32.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.18.32.gep759.2.sroa_idx, align 8, !dbg !96
  %gep759.3 = getelementptr i8, ptr addrspace(4) %57, i64 3072, !dbg !95
  %v.sroa.20.48.copyload = load <4 x half>, ptr addrspace(4) %gep759.3, align 16, !dbg !96
  %v.sroa.24.48.gep759.3.sroa_idx = getelementptr i8, ptr addrspace(4) %57, i64 3080, !dbg !96
  %v.sroa.24.48.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.24.48.gep759.3.sroa_idx, align 8, !dbg !96
  %gep759.4 = getelementptr i8, ptr addrspace(4) %57, i64 4096, !dbg !95
  %v.sroa.26.64.copyload = load <4 x half>, ptr addrspace(4) %gep759.4, align 16, !dbg !96
  %v.sroa.30.64.gep759.4.sroa_idx = getelementptr i8, ptr addrspace(4) %57, i64 4104, !dbg !96
  %v.sroa.30.64.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.30.64.gep759.4.sroa_idx, align 8, !dbg !96
  %gep759.5 = getelementptr i8, ptr addrspace(4) %57, i64 5120, !dbg !95
  %v.sroa.32.80.copyload = load <4 x half>, ptr addrspace(4) %gep759.5, align 16, !dbg !96
  %v.sroa.36.80.gep759.5.sroa_idx = getelementptr i8, ptr addrspace(4) %57, i64 5128, !dbg !96
  %v.sroa.36.80.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.36.80.gep759.5.sroa_idx, align 8, !dbg !96
  %gep759.6 = getelementptr i8, ptr addrspace(4) %57, i64 6144, !dbg !95
  %v.sroa.38.96.copyload = load <4 x half>, ptr addrspace(4) %gep759.6, align 16, !dbg !96
  %v.sroa.42.96.gep759.6.sroa_idx = getelementptr i8, ptr addrspace(4) %57, i64 6152, !dbg !96
  %v.sroa.42.96.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.42.96.gep759.6.sroa_idx, align 8, !dbg !96
  %gep759.7 = getelementptr i8, ptr addrspace(4) %57, i64 7168, !dbg !95
  %v.sroa.44.112.copyload = load <4 x half>, ptr addrspace(4) %gep759.7, align 16, !dbg !96
  %v.sroa.48.112.gep759.7.sroa_idx = getelementptr i8, ptr addrspace(4) %57, i64 7176, !dbg !96
  %v.sroa.48.112.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.48.112.gep759.7.sroa_idx, align 8, !dbg !96
  br label %if.end276, !dbg !97

if.end276:                                        ; preds = %for.body252.preheader, %for.body96.preheader
  %v.sroa.48.0 = phi <4 x half> [ %v.sroa.48.112.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %v.sroa.44.0 = phi <4 x half> [ %v.sroa.44.112.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %v.sroa.42.0 = phi <4 x half> [ %v.sroa.42.96.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %v.sroa.38.0 = phi <4 x half> [ %v.sroa.38.96.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %v.sroa.36.0 = phi <4 x half> [ %v.sroa.36.80.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %v.sroa.32.0 = phi <4 x half> [ %v.sroa.32.80.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %v.sroa.30.0 = phi <4 x half> [ %v.sroa.30.64.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %v.sroa.26.0 = phi <4 x half> [ %v.sroa.26.64.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %v.sroa.24.0 = phi <4 x half> [ %v.sroa.24.48.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %v.sroa.20.0 = phi <4 x half> [ %v.sroa.20.48.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %v.sroa.18.0 = phi <4 x half> [ %v.sroa.18.32.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %v.sroa.14.0 = phi <4 x half> [ %v.sroa.14.32.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %v.sroa.12.0 = phi <4 x half> [ %v.sroa.12.16.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %v.sroa.8.0 = phi <4 x half> [ %v.sroa.8.16.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %v.sroa.6.0 = phi <4 x half> [ %v.sroa.6.0.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %v.sroa.0.0 = phi <4 x half> [ %v.sroa.0.0.copyload, %for.body252.preheader ], [ undef, %for.body96.preheader ]
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %54, i64 0, !dbg !98
  %mul283 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FC2776C60000000, !dbg !99
  %58 = tail call contract noundef float @llvm.minnum.f32(float %mul283, float 1.500000e+01), !dbg !100
  %cmp.i.i = fcmp contract olt float %58, -1.260000e+02, !dbg !104
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00, !dbg !104
  %add.i.i730 = fadd contract float %58, %cond.i.i, !dbg !104
  %59 = tail call contract float @llvm.exp2.f32(float %add.i.i730), !dbg !104
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00, !dbg !104
  %mul.i.i = fmul contract float %cond2.i.i, %59, !dbg !104
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %54, i64 1, !dbg !98
  %mul283.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FC2776C60000000, !dbg !99
  %60 = tail call contract noundef float @llvm.minnum.f32(float %mul283.1, float 1.500000e+01), !dbg !100
  %cmp.i.i.1 = fcmp contract olt float %60, -1.260000e+02, !dbg !104
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00, !dbg !104
  %add.i.i730.1 = fadd contract float %60, %cond.i.i.1, !dbg !104
  %61 = tail call contract float @llvm.exp2.f32(float %add.i.i730.1), !dbg !104
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !104
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %61, !dbg !104
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %54, i64 2, !dbg !98
  %mul283.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FC2776C60000000, !dbg !99
  %62 = tail call contract noundef float @llvm.minnum.f32(float %mul283.2, float 1.500000e+01), !dbg !100
  %cmp.i.i.2 = fcmp contract olt float %62, -1.260000e+02, !dbg !104
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00, !dbg !104
  %add.i.i730.2 = fadd contract float %62, %cond.i.i.2, !dbg !104
  %63 = tail call contract float @llvm.exp2.f32(float %add.i.i730.2), !dbg !104
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00, !dbg !104
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %63, !dbg !104
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %54, i64 3, !dbg !98
  %mul283.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FC2776C60000000, !dbg !99
  %64 = tail call contract noundef float @llvm.minnum.f32(float %mul283.3, float 1.500000e+01), !dbg !100
  %cmp.i.i.3 = fcmp contract olt float %64, -1.260000e+02, !dbg !104
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00, !dbg !104
  %add.i.i730.3 = fadd contract float %64, %cond.i.i.3, !dbg !104
  %65 = tail call contract float @llvm.exp2.f32(float %add.i.i730.3), !dbg !104
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00, !dbg !104
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %65, !dbg !104
  %scores.sroa.90.16.vec.extract = extractelement <4 x float> %55, i64 0, !dbg !98
  %mul283.4 = fmul contract float %scores.sroa.90.16.vec.extract, 0x3FC2776C60000000, !dbg !99
  %66 = tail call contract noundef float @llvm.minnum.f32(float %mul283.4, float 1.500000e+01), !dbg !100
  %cmp.i.i.4 = fcmp contract olt float %66, -1.260000e+02, !dbg !104
  %cond.i.i.4 = select contract i1 %cmp.i.i.4, float 6.400000e+01, float 0.000000e+00, !dbg !104
  %add.i.i730.4 = fadd contract float %66, %cond.i.i.4, !dbg !104
  %67 = tail call contract float @llvm.exp2.f32(float %add.i.i730.4), !dbg !104
  %cond2.i.i.4 = select contract i1 %cmp.i.i.4, float 0x3BF0000000000000, float 1.000000e+00, !dbg !104
  %mul.i.i.4 = fmul contract float %cond2.i.i.4, %67, !dbg !104
  %scores.sroa.90.20.vec.extract = extractelement <4 x float> %55, i64 1, !dbg !98
  %mul283.5 = fmul contract float %scores.sroa.90.20.vec.extract, 0x3FC2776C60000000, !dbg !99
  %68 = tail call contract noundef float @llvm.minnum.f32(float %mul283.5, float 1.500000e+01), !dbg !100
  %cmp.i.i.5 = fcmp contract olt float %68, -1.260000e+02, !dbg !104
  %cond.i.i.5 = select contract i1 %cmp.i.i.5, float 6.400000e+01, float 0.000000e+00, !dbg !104
  %add.i.i730.5 = fadd contract float %68, %cond.i.i.5, !dbg !104
  %69 = tail call contract float @llvm.exp2.f32(float %add.i.i730.5), !dbg !104
  %cond2.i.i.5 = select contract i1 %cmp.i.i.5, float 0x3BF0000000000000, float 1.000000e+00, !dbg !104
  %mul.i.i.5 = fmul contract float %cond2.i.i.5, %69, !dbg !104
  %scores.sroa.90.24.vec.extract = extractelement <4 x float> %55, i64 2, !dbg !98
  %mul283.6 = fmul contract float %scores.sroa.90.24.vec.extract, 0x3FC2776C60000000, !dbg !99
  %70 = tail call contract noundef float @llvm.minnum.f32(float %mul283.6, float 1.500000e+01), !dbg !100
  %cmp.i.i.6 = fcmp contract olt float %70, -1.260000e+02, !dbg !104
  %cond.i.i.6 = select contract i1 %cmp.i.i.6, float 6.400000e+01, float 0.000000e+00, !dbg !104
  %add.i.i730.6 = fadd contract float %70, %cond.i.i.6, !dbg !104
  %71 = tail call contract float @llvm.exp2.f32(float %add.i.i730.6), !dbg !104
  %cond2.i.i.6 = select contract i1 %cmp.i.i.6, float 0x3BF0000000000000, float 1.000000e+00, !dbg !104
  %mul.i.i.6 = fmul contract float %cond2.i.i.6, %71, !dbg !104
  %scores.sroa.90.28.vec.extract = extractelement <4 x float> %55, i64 3, !dbg !98
  %mul283.7 = fmul contract float %scores.sroa.90.28.vec.extract, 0x3FC2776C60000000, !dbg !99
  %72 = tail call contract noundef float @llvm.minnum.f32(float %mul283.7, float 1.500000e+01), !dbg !100
  %cmp.i.i.7 = fcmp contract olt float %72, -1.260000e+02, !dbg !104
  %cond.i.i.7 = select contract i1 %cmp.i.i.7, float 6.400000e+01, float 0.000000e+00, !dbg !104
  %add.i.i730.7 = fadd contract float %72, %cond.i.i.7, !dbg !104
  %73 = tail call contract float @llvm.exp2.f32(float %add.i.i730.7), !dbg !104
  %cond2.i.i.7 = select contract i1 %cmp.i.i.7, float 0x3BF0000000000000, float 1.000000e+00, !dbg !104
  %mul.i.i.7 = fmul contract float %cond2.i.i.7, %73, !dbg !104
  %add303 = fadd contract float %mul.i.i, 0.000000e+00, !dbg !107
  %add303.1 = fadd contract float %add303, %mul.i.i.4, !dbg !107
  %add303.2 = fadd contract float %add303.1, %mul.i.i.1, !dbg !107
  %add303.3 = fadd contract float %add303.2, %mul.i.i.5, !dbg !107
  %add303.4 = fadd contract float %add303.3, %mul.i.i.2, !dbg !107
  %add303.5 = fadd contract float %add303.4, %mul.i.i.6, !dbg !107
  %add303.6 = fadd contract float %add303.5, %mul.i.i.3, !dbg !107
  %add303.7 = fadd contract float %add303.6, %mul.i.i.7, !dbg !107
  %74 = bitcast float %add303.7 to i32, !dbg !108
  %75 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !119
  %76 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %75) #11, !dbg !124
  %xor.i.i = xor i32 %76, 32, !dbg !125
  %77 = and i32 %76, -64, !dbg !126
  %and.i.i = add nsw i32 %77, 64, !dbg !126
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !127
  %cond.i.i731 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %76, !dbg !128
  %shl.i.i = shl i32 %cond.i.i731, 2, !dbg !129
  %78 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %74), !dbg !130
  %79 = bitcast i32 %78 to float, !dbg !131
  %add.i = fadd contract float %add303.7, %79, !dbg !132
  %80 = bitcast float %add.i to i32, !dbg !135
  %81 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !142
  %82 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %81) #11, !dbg !145
  %xor.i.i732 = xor i32 %82, 16, !dbg !146
  %83 = and i32 %82, -64, !dbg !147
  %and.i.i733 = add nsw i32 %83, 64, !dbg !147
  %cmp.not.i.i734 = icmp slt i32 %xor.i.i732, %and.i.i733, !dbg !148
  %cond.i.i735 = select i1 %cmp.not.i.i734, i32 %xor.i.i732, i32 %82, !dbg !149
  %shl.i.i736 = shl i32 %cond.i.i735, 2, !dbg !150
  %84 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i736, i32 %80), !dbg !151
  %85 = bitcast i32 %84 to float, !dbg !152
  %add.i.i = fadd contract float %add.i, %85, !dbg !153
  %cmp312 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !155
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !156
  %condval_8.0 = select i1 %cmp312, float %div, float 0.000000e+00, !dbg !156
  %mul325 = fmul contract float %condval_8.0, %mul.i.i, !dbg !157
  %mul325.1 = fmul contract float %condval_8.0, %mul.i.i.1, !dbg !157
  %mul325.2 = fmul contract float %condval_8.0, %mul.i.i.2, !dbg !157
  %mul325.3 = fmul contract float %condval_8.0, %mul.i.i.3, !dbg !157
  %mul325.4 = fmul contract float %condval_8.0, %mul.i.i.4, !dbg !157
  %mul325.5 = fmul contract float %condval_8.0, %mul.i.i.5, !dbg !157
  %mul325.6 = fmul contract float %condval_8.0, %mul.i.i.6, !dbg !157
  %mul325.7 = fmul contract float %condval_8.0, %mul.i.i.7, !dbg !157
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325), !dbg !158
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.1), !dbg !158
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.2), !dbg !158
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.3), !dbg !158
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.4), !dbg !158
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.5), !dbg !158
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.6), !dbg !158
  %93 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.7), !dbg !158
  fence syncscope("warp") release, !dbg !167
  tail call void @llvm.mxc.barrier.warp(), !dbg !170
  fence syncscope("warp") acquire, !dbg !171
  br label %if.end357, !dbg !172

if.end357:                                        ; preds = %if.end276, %if.end79.7, %if.then
  %v.sroa.48.1 = phi <4 x half> [ %v.sroa.48.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %v.sroa.44.1 = phi <4 x half> [ %v.sroa.44.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %v.sroa.42.1 = phi <4 x half> [ %v.sroa.42.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %v.sroa.38.1 = phi <4 x half> [ %v.sroa.38.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %v.sroa.36.1 = phi <4 x half> [ %v.sroa.36.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %v.sroa.32.1 = phi <4 x half> [ %v.sroa.32.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %v.sroa.30.1 = phi <4 x half> [ %v.sroa.30.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %v.sroa.26.1 = phi <4 x half> [ %v.sroa.26.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %v.sroa.24.1 = phi <4 x half> [ %v.sroa.24.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %v.sroa.20.1 = phi <4 x half> [ %v.sroa.20.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %v.sroa.18.1 = phi <4 x half> [ %v.sroa.18.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %v.sroa.14.1 = phi <4 x half> [ %v.sroa.14.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %v.sroa.12.1 = phi <4 x half> [ %v.sroa.12.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %v.sroa.8.1 = phi <4 x half> [ %v.sroa.8.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %v.sroa.6.1 = phi <4 x half> [ %v.sroa.6.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %v.sroa.0.1 = phi <4 x half> [ %v.sroa.0.0, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %pair_prob.sroa.16.0 = phi i16 [ %93, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %pair_prob.sroa.14.0 = phi i16 [ %92, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %pair_prob.sroa.12.0 = phi i16 [ %91, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %pair_prob.sroa.10.0 = phi i16 [ %90, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %pair_prob.sroa.8.0 = phi i16 [ %89, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %pair_prob.sroa.6.0 = phi i16 [ %88, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %pair_prob.sroa.4.0 = phi i16 [ %87, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %pair_prob.sroa.0.0 = phi i16 [ %86, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.48.1 = phi <4 x half> [ %k.sroa.48.112.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.44.1 = phi <4 x half> [ %k.sroa.44.112.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.42.1 = phi <4 x half> [ %k.sroa.42.96.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.38.1 = phi <4 x half> [ %k.sroa.38.96.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.36.1 = phi <4 x half> [ %k.sroa.36.80.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.32.1 = phi <4 x half> [ %k.sroa.32.80.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.30.1 = phi <4 x half> [ %k.sroa.30.64.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.26.1 = phi <4 x half> [ %k.sroa.26.64.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.24.1 = phi <4 x half> [ %k.sroa.24.48.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.20.1 = phi <4 x half> [ %k.sroa.20.48.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.18.1 = phi <4 x half> [ %k.sroa.18.32.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.14.1 = phi <4 x half> [ %k.sroa.14.32.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.12.1 = phi <4 x half> [ %k.sroa.12.16.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.8.1 = phi <4 x half> [ %k.sroa.8.16.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.6.1 = phi <4 x half> [ %k.sroa.6.0.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %k.sroa.0.1 = phi <4 x half> [ %k.sroa.0.0.copyload, %if.end276 ], [ undef, %if.end79.7 ], [ undef, %if.then ]
  %cmp32.1 = icmp sgt i32 %7, -1, !dbg !60
  br i1 %cmp32.1, label %for.cond34.preheader.1, label %if.end357.1, !dbg !61

for.cond34.preheader.1:                           ; preds = %if.end357
  %cmp42.1 = icmp ult i32 %7, 1024
  %condval_4.0.1 = zext nneg i32 %7 to i64
  br i1 %cmp42.1, label %if.then43.1817, label %if.end79.1821, !dbg !62

if.then43.1817:                                   ; preds = %for.cond34.preheader.1
  %.idx787.1812 = shl nuw nsw i64 %condval_4.0.1, 12, !dbg !63
  %94 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787.1812, !dbg !63
  %.idx788.1813 = shl nuw nsw i64 %shr, 22, !dbg !63
  %95 = getelementptr i8, ptr addrspace(4) %94, i64 %.idx788.1813, !dbg !63
  %condval_1.sroa.0.0.copyload.1814 = load i32, ptr addrspace(4) %95, align 8, !dbg !64, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.1815 = getelementptr inbounds i8, ptr addrspace(4) %95, i64 4, !dbg !64
  %condval_1.sroa.5.0.copyload.1816 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.1815, align 4, !dbg !64, !tbaa !30
  %96 = zext i32 %condval_1.sroa.0.0.copyload.1814 to i64, !dbg !67
  %97 = zext i32 %condval_1.sroa.5.0.copyload.1816 to i64, !dbg !67
  %98 = shl nuw i64 %97, 32, !dbg !67
  %99 = or disjoint i64 %98, %96, !dbg !65
  br label %if.end79.1821, !dbg !65

if.end79.1821:                                    ; preds = %if.then43.1817, %for.cond34.preheader.1
  %q_stage.sroa.0.4.insert.insert1658 = phi i64 [ %99, %if.then43.1817 ], [ 0, %for.cond34.preheader.1 ], !dbg !67
  br i1 %cmp42.1, label %if.then43.1.1, label %if.end79.1.1, !dbg !62

if.then43.1.1:                                    ; preds = %if.end79.1821
  %.idx787.1.1 = shl nuw nsw i64 %condval_4.0.1, 12, !dbg !63
  %100 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787.1.1, !dbg !63
  %.idx788.1.1 = shl nuw nsw i64 %shr, 22, !dbg !63
  %101 = getelementptr i8, ptr addrspace(4) %100, i64 %.idx788.1.1, !dbg !63
  %gep.1.1 = getelementptr i8, ptr addrspace(4) %101, i64 512, !dbg !63
  %condval_1.sroa.0.0.copyload.1.1 = load i32, ptr addrspace(4) %gep.1.1, align 8, !dbg !64, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.1.1 = getelementptr i8, ptr addrspace(4) %101, i64 516, !dbg !64
  %condval_1.sroa.5.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.1.1, align 4, !dbg !64, !tbaa !30
  %102 = zext i32 %condval_1.sroa.0.0.copyload.1.1 to i64, !dbg !67
  %103 = zext i32 %condval_1.sroa.5.0.copyload.1.1 to i64, !dbg !67
  %104 = shl nuw i64 %103, 32, !dbg !67
  %105 = or disjoint i64 %104, %102, !dbg !65
  br label %if.end79.1.1, !dbg !65

if.end79.1.1:                                     ; preds = %if.then43.1.1, %if.end79.1821
  %q_stage.sroa.8.12.insert.insert1668 = phi i64 [ %105, %if.then43.1.1 ], [ 0, %if.end79.1821 ], !dbg !67
  br i1 %cmp42.1, label %if.then43.2.1, label %if.end79.2.1, !dbg !62

if.then43.2.1:                                    ; preds = %if.end79.1.1
  %.idx787.2.1 = shl nuw nsw i64 %condval_4.0.1, 12, !dbg !63
  %106 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787.2.1, !dbg !63
  %.idx788.2.1 = shl nuw nsw i64 %shr, 22, !dbg !63
  %107 = getelementptr i8, ptr addrspace(4) %106, i64 %.idx788.2.1, !dbg !63
  %gep.2.1 = getelementptr i8, ptr addrspace(4) %107, i64 1024, !dbg !63
  %condval_1.sroa.0.0.copyload.2.1 = load i32, ptr addrspace(4) %gep.2.1, align 8, !dbg !64, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.2.1 = getelementptr i8, ptr addrspace(4) %107, i64 1028, !dbg !64
  %condval_1.sroa.5.0.copyload.2.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.2.1, align 4, !dbg !64, !tbaa !30
  %108 = zext i32 %condval_1.sroa.0.0.copyload.2.1 to i64, !dbg !67
  %109 = zext i32 %condval_1.sroa.5.0.copyload.2.1 to i64, !dbg !67
  %110 = shl nuw i64 %109, 32, !dbg !67
  %111 = or disjoint i64 %110, %108, !dbg !65
  br label %if.end79.2.1, !dbg !65

if.end79.2.1:                                     ; preds = %if.then43.2.1, %if.end79.1.1
  %q_stage.sroa.14.20.insert.insert1678 = phi i64 [ %111, %if.then43.2.1 ], [ 0, %if.end79.1.1 ], !dbg !67
  br i1 %cmp42.1, label %if.then43.3.1, label %if.end79.3.1, !dbg !62

if.then43.3.1:                                    ; preds = %if.end79.2.1
  %.idx787.3.1 = shl nuw nsw i64 %condval_4.0.1, 12, !dbg !63
  %112 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787.3.1, !dbg !63
  %.idx788.3.1 = shl nuw nsw i64 %shr, 22, !dbg !63
  %113 = getelementptr i8, ptr addrspace(4) %112, i64 %.idx788.3.1, !dbg !63
  %gep.3.1 = getelementptr i8, ptr addrspace(4) %113, i64 1536, !dbg !63
  %condval_1.sroa.0.0.copyload.3.1 = load i32, ptr addrspace(4) %gep.3.1, align 8, !dbg !64, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.3.1 = getelementptr i8, ptr addrspace(4) %113, i64 1540, !dbg !64
  %condval_1.sroa.5.0.copyload.3.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.3.1, align 4, !dbg !64, !tbaa !30
  %114 = zext i32 %condval_1.sroa.0.0.copyload.3.1 to i64, !dbg !67
  %115 = zext i32 %condval_1.sroa.5.0.copyload.3.1 to i64, !dbg !67
  %116 = shl nuw i64 %115, 32, !dbg !67
  %117 = or disjoint i64 %116, %114, !dbg !65
  br label %if.end79.3.1, !dbg !65

if.end79.3.1:                                     ; preds = %if.then43.3.1, %if.end79.2.1
  %q_stage.sroa.20.28.insert.insert1688 = phi i64 [ %117, %if.then43.3.1 ], [ 0, %if.end79.2.1 ], !dbg !67
  br i1 %cmp42.1, label %if.then43.4.1, label %if.end79.4.1, !dbg !62

if.then43.4.1:                                    ; preds = %if.end79.3.1
  %.idx787.4.1 = shl nuw nsw i64 %condval_4.0.1, 12, !dbg !63
  %118 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787.4.1, !dbg !63
  %.idx788.4.1 = shl nuw nsw i64 %shr, 22, !dbg !63
  %119 = getelementptr i8, ptr addrspace(4) %118, i64 %.idx788.4.1, !dbg !63
  %gep.4.1 = getelementptr i8, ptr addrspace(4) %119, i64 2048, !dbg !63
  %condval_1.sroa.0.0.copyload.4.1 = load i32, ptr addrspace(4) %gep.4.1, align 8, !dbg !64, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.4.1 = getelementptr i8, ptr addrspace(4) %119, i64 2052, !dbg !64
  %condval_1.sroa.5.0.copyload.4.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.4.1, align 4, !dbg !64, !tbaa !30
  %120 = zext i32 %condval_1.sroa.0.0.copyload.4.1 to i64, !dbg !67
  %121 = zext i32 %condval_1.sroa.5.0.copyload.4.1 to i64, !dbg !67
  %122 = shl nuw i64 %121, 32, !dbg !67
  %123 = or disjoint i64 %122, %120, !dbg !65
  br label %if.end79.4.1, !dbg !65

if.end79.4.1:                                     ; preds = %if.then43.4.1, %if.end79.3.1
  %q_stage.sroa.26.36.insert.insert1698 = phi i64 [ %123, %if.then43.4.1 ], [ 0, %if.end79.3.1 ], !dbg !67
  br i1 %cmp42.1, label %if.then43.5.1, label %if.end79.5.1, !dbg !62

if.then43.5.1:                                    ; preds = %if.end79.4.1
  %.idx787.5.1 = shl nuw nsw i64 %condval_4.0.1, 12, !dbg !63
  %124 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787.5.1, !dbg !63
  %.idx788.5.1 = shl nuw nsw i64 %shr, 22, !dbg !63
  %125 = getelementptr i8, ptr addrspace(4) %124, i64 %.idx788.5.1, !dbg !63
  %gep.5.1 = getelementptr i8, ptr addrspace(4) %125, i64 2560, !dbg !63
  %condval_1.sroa.0.0.copyload.5.1 = load i32, ptr addrspace(4) %gep.5.1, align 8, !dbg !64, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.5.1 = getelementptr i8, ptr addrspace(4) %125, i64 2564, !dbg !64
  %condval_1.sroa.5.0.copyload.5.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.5.1, align 4, !dbg !64, !tbaa !30
  %126 = zext i32 %condval_1.sroa.0.0.copyload.5.1 to i64, !dbg !67
  %127 = zext i32 %condval_1.sroa.5.0.copyload.5.1 to i64, !dbg !67
  %128 = shl nuw i64 %127, 32, !dbg !67
  %129 = or disjoint i64 %128, %126, !dbg !65
  br label %if.end79.5.1, !dbg !65

if.end79.5.1:                                     ; preds = %if.then43.5.1, %if.end79.4.1
  %q_stage.sroa.32.44.insert.insert1708 = phi i64 [ %129, %if.then43.5.1 ], [ 0, %if.end79.4.1 ], !dbg !67
  br i1 %cmp42.1, label %if.then43.6.1, label %if.end79.6.1, !dbg !62

if.then43.6.1:                                    ; preds = %if.end79.5.1
  %.idx787.6.1 = shl nuw nsw i64 %condval_4.0.1, 12, !dbg !63
  %130 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787.6.1, !dbg !63
  %.idx788.6.1 = shl nuw nsw i64 %shr, 22, !dbg !63
  %131 = getelementptr i8, ptr addrspace(4) %130, i64 %.idx788.6.1, !dbg !63
  %gep.6.1 = getelementptr i8, ptr addrspace(4) %131, i64 3072, !dbg !63
  %condval_1.sroa.0.0.copyload.6.1 = load i32, ptr addrspace(4) %gep.6.1, align 8, !dbg !64, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.6.1 = getelementptr i8, ptr addrspace(4) %131, i64 3076, !dbg !64
  %condval_1.sroa.5.0.copyload.6.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.6.1, align 4, !dbg !64, !tbaa !30
  %132 = zext i32 %condval_1.sroa.0.0.copyload.6.1 to i64, !dbg !67
  %133 = zext i32 %condval_1.sroa.5.0.copyload.6.1 to i64, !dbg !67
  %134 = shl nuw i64 %133, 32, !dbg !67
  %135 = or disjoint i64 %134, %132, !dbg !65
  br label %if.end79.6.1, !dbg !65

if.end79.6.1:                                     ; preds = %if.then43.6.1, %if.end79.5.1
  %q_stage.sroa.38.52.insert.insert1718 = phi i64 [ %135, %if.then43.6.1 ], [ 0, %if.end79.5.1 ], !dbg !67
  br i1 %cmp42.1, label %if.then43.7.1, label %if.end79.7.1, !dbg !62

if.then43.7.1:                                    ; preds = %if.end79.6.1
  %.idx787.7.1 = shl nuw nsw i64 %condval_4.0.1, 12, !dbg !63
  %136 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx787.7.1, !dbg !63
  %.idx788.7.1 = shl nuw nsw i64 %shr, 22, !dbg !63
  %137 = getelementptr i8, ptr addrspace(4) %136, i64 %.idx788.7.1, !dbg !63
  %gep.7.1 = getelementptr i8, ptr addrspace(4) %137, i64 3584, !dbg !63
  %condval_1.sroa.0.0.copyload.7.1 = load i32, ptr addrspace(4) %gep.7.1, align 8, !dbg !64, !tbaa !30
  %condval_1.sroa.5.0.add.ptr.sroa_idx.7.1 = getelementptr i8, ptr addrspace(4) %137, i64 3588, !dbg !64
  %condval_1.sroa.5.0.copyload.7.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr.sroa_idx.7.1, align 4, !dbg !64, !tbaa !30
  %138 = zext i32 %condval_1.sroa.0.0.copyload.7.1 to i64, !dbg !67
  %139 = zext i32 %condval_1.sroa.5.0.copyload.7.1 to i64, !dbg !67
  %140 = shl nuw i64 %139, 32, !dbg !67
  %141 = or disjoint i64 %140, %138, !dbg !65
  br label %if.end79.7.1, !dbg !65

if.end79.7.1:                                     ; preds = %if.then43.7.1, %if.end79.6.1
  %q_stage.sroa.44.60.insert.insert1728 = phi i64 [ %141, %if.then43.7.1 ], [ 0, %if.end79.6.1 ], !dbg !67
  %cmp89.1 = icmp sle i32 %mul88, %7
  %or.cond785.1 = select i1 %cmp87, i1 %cmp89.1, i1 false, !dbg !68
  br i1 %or.cond785.1, label %if.end119.1, label %if.end357.1, !dbg !68

if.end119.1:                                      ; preds = %if.end79.7.1
  %xor.1823 = xor i32 %shr137, %shr134, !dbg !71
  %142 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4096), i32 %add132, !dbg !72
  %gep747.idx.1824 = shl nuw nsw i32 %xor.1823, 4, !dbg !72
  %gep747.1825 = getelementptr inbounds i8, ptr addrspace(3) %142, i32 %gep747.idx.1824, !dbg !72
  store i64 %q_stage.sroa.0.4.insert.insert1658, ptr addrspace(3) %gep747.1825, align 8, !dbg !73
  %add138.1.1 = add nuw nsw i32 %shr137, 2, !dbg !74
  %xor.1.1 = xor i32 %add138.1.1, %shr134, !dbg !71
  %143 = getelementptr inbounds i8, ptr addrspace(3) %142, i32 512, !dbg !72
  %gep747.idx.1.1 = shl nuw nsw i32 %xor.1.1, 4, !dbg !72
  %gep747.1.1 = getelementptr inbounds i8, ptr addrspace(3) %143, i32 %gep747.idx.1.1, !dbg !72
  store i64 %q_stage.sroa.8.12.insert.insert1668, ptr addrspace(3) %gep747.1.1, align 8, !dbg !73
  %add138.2.1 = add nuw nsw i32 %shr137, 4, !dbg !74
  %xor.2.1 = xor i32 %add138.2.1, %shr134, !dbg !71
  %144 = getelementptr inbounds i8, ptr addrspace(3) %142, i32 1024, !dbg !72
  %gep747.idx.2.1 = shl nuw nsw i32 %xor.2.1, 4, !dbg !72
  %gep747.2.1 = getelementptr inbounds i8, ptr addrspace(3) %144, i32 %gep747.idx.2.1, !dbg !72
  store i64 %q_stage.sroa.14.20.insert.insert1678, ptr addrspace(3) %gep747.2.1, align 8, !dbg !73
  %add138.3.1 = add nuw nsw i32 %shr137, 6, !dbg !74
  %xor.3.1 = xor i32 %add138.3.1, %shr134, !dbg !71
  %145 = getelementptr inbounds i8, ptr addrspace(3) %142, i32 1536, !dbg !72
  %gep747.idx.3.1 = shl nuw nsw i32 %xor.3.1, 4, !dbg !72
  %gep747.3.1 = getelementptr inbounds i8, ptr addrspace(3) %145, i32 %gep747.idx.3.1, !dbg !72
  store i64 %q_stage.sroa.20.28.insert.insert1688, ptr addrspace(3) %gep747.3.1, align 8, !dbg !73
  %add138.4.1 = add nuw nsw i32 %shr137, 8, !dbg !74
  %xor.4.1 = xor i32 %add138.4.1, %shr134, !dbg !71
  %146 = getelementptr inbounds i8, ptr addrspace(3) %142, i32 2048, !dbg !72
  %gep747.idx.4.1 = shl nuw nsw i32 %xor.4.1, 4, !dbg !72
  %gep747.4.1 = getelementptr inbounds i8, ptr addrspace(3) %146, i32 %gep747.idx.4.1, !dbg !72
  store i64 %q_stage.sroa.26.36.insert.insert1698, ptr addrspace(3) %gep747.4.1, align 8, !dbg !73
  %add138.5.1 = add nuw nsw i32 %shr137, 10, !dbg !74
  %xor.5.1 = xor i32 %add138.5.1, %shr134, !dbg !71
  %147 = getelementptr inbounds i8, ptr addrspace(3) %142, i32 2560, !dbg !72
  %gep747.idx.5.1 = shl nuw nsw i32 %xor.5.1, 4, !dbg !72
  %gep747.5.1 = getelementptr inbounds i8, ptr addrspace(3) %147, i32 %gep747.idx.5.1, !dbg !72
  store i64 %q_stage.sroa.32.44.insert.insert1708, ptr addrspace(3) %gep747.5.1, align 8, !dbg !73
  %add138.6.1 = add nuw nsw i32 %shr137, 12, !dbg !74
  %xor.6.1 = xor i32 %add138.6.1, %shr134, !dbg !71
  %148 = getelementptr inbounds i8, ptr addrspace(3) %142, i32 3072, !dbg !72
  %gep747.idx.6.1 = shl nuw nsw i32 %xor.6.1, 4, !dbg !72
  %gep747.6.1 = getelementptr inbounds i8, ptr addrspace(3) %148, i32 %gep747.idx.6.1, !dbg !72
  store i64 %q_stage.sroa.38.52.insert.insert1718, ptr addrspace(3) %gep747.6.1, align 8, !dbg !73
  %add138.7.1 = add nuw nsw i32 %shr137, 14, !dbg !74
  %xor.7.1 = xor i32 %add138.7.1, %shr134, !dbg !71
  %149 = getelementptr inbounds i8, ptr addrspace(3) %142, i32 3584, !dbg !72
  %gep747.idx.7.1 = shl nuw nsw i32 %xor.7.1, 4, !dbg !72
  %gep747.7.1 = getelementptr inbounds i8, ptr addrspace(3) %149, i32 %gep747.idx.7.1, !dbg !72
  store i64 %q_stage.sroa.44.60.insert.insert1728, ptr addrspace(3) %gep747.7.1, align 8, !dbg !73
  fence syncscope("warp") release, !dbg !75
  tail call void @llvm.mxc.barrier.warp(), !dbg !81
  fence syncscope("warp") acquire, !dbg !82
  %xor164.1826 = xor i32 %shr160, %and163, !dbg !83
  %.idx.1827 = shl nuw nsw i32 %xor164.1826, 4, !dbg !84
  %gep750.1828 = getelementptr inbounds i8, ptr addrspace(3) %gep767, i32 %.idx.1827, !dbg !84
  %q.sroa.0.0.copyload1601 = load <4 x half>, ptr addrspace(3) %gep750.1828, align 16, !dbg !85
  %q.sroa.6.0.gep750.1828.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep750.1828, i32 8, !dbg !85
  %q.sroa.6.0.copyload1602 = load <4 x half>, ptr addrspace(3) %q.sroa.6.0.gep750.1828.sroa_idx, align 8, !dbg !85
  %add161.1.1 = add nuw nsw i32 %shr160, 4, !dbg !86
  %xor164.1.1 = xor i32 %add161.1.1, %and163, !dbg !83
  %.idx.1.1 = shl nuw nsw i32 %xor164.1.1, 4, !dbg !84
  %gep750.1.1 = getelementptr inbounds i8, ptr addrspace(3) %gep767, i32 %.idx.1.1, !dbg !84
  %q.sroa.8.16.copyload1605 = load <4 x half>, ptr addrspace(3) %gep750.1.1, align 16, !dbg !85
  %q.sroa.12.16.gep750.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep750.1.1, i32 8, !dbg !85
  %q.sroa.12.16.copyload1606 = load <4 x half>, ptr addrspace(3) %q.sroa.12.16.gep750.1.1.sroa_idx, align 8, !dbg !85
  %add161.2.1 = add nuw nsw i32 %shr160, 8, !dbg !86
  %xor164.2.1 = xor i32 %add161.2.1, %and163, !dbg !83
  %.idx.2.1 = shl nuw nsw i32 %xor164.2.1, 4, !dbg !84
  %gep750.2.1 = getelementptr inbounds i8, ptr addrspace(3) %gep767, i32 %.idx.2.1, !dbg !84
  %q.sroa.14.32.copyload1609 = load <4 x half>, ptr addrspace(3) %gep750.2.1, align 16, !dbg !85
  %q.sroa.18.32.gep750.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep750.2.1, i32 8, !dbg !85
  %q.sroa.18.32.copyload1610 = load <4 x half>, ptr addrspace(3) %q.sroa.18.32.gep750.2.1.sroa_idx, align 8, !dbg !85
  %add161.3.1 = add nuw nsw i32 %shr160, 12, !dbg !86
  %xor164.3.1 = xor i32 %add161.3.1, %and163, !dbg !83
  %.idx.3.1 = shl nuw nsw i32 %xor164.3.1, 4, !dbg !84
  %gep750.3.1 = getelementptr inbounds i8, ptr addrspace(3) %gep767, i32 %.idx.3.1, !dbg !84
  %q.sroa.20.48.copyload1613 = load <4 x half>, ptr addrspace(3) %gep750.3.1, align 16, !dbg !85
  %q.sroa.24.48.gep750.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep750.3.1, i32 8, !dbg !85
  %q.sroa.24.48.copyload1614 = load <4 x half>, ptr addrspace(3) %q.sroa.24.48.gep750.3.1.sroa_idx, align 8, !dbg !85
  %cmp197.not.1829 = icmp sgt i32 %add190, %7, !dbg !87
  %spec.select.1830 = select i1 %cmp197.not.1829, float 0xFFF0000000000000, float 0.000000e+00, !dbg !88
  %scores.sroa.0.0.vec.insert1396 = insertelement <4 x float> poison, float %spec.select.1830, i64 0, !dbg !89
  %cmp197.not.1.1.not = icmp slt i32 %add190, %7, !dbg !87
  %spec.select.1.1 = select i1 %cmp197.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !88
  %scores.sroa.0.4.vec.insert1421 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1396, float %spec.select.1.1, i64 1, !dbg !89
  %add194.2.1 = or disjoint i32 %add190, 2, !dbg !90
  %cmp197.not.2.1 = icmp sgt i32 %add194.2.1, %7, !dbg !87
  %spec.select.2.1 = select i1 %cmp197.not.2.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !88
  %scores.sroa.0.8.vec.insert1446 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1421, float %spec.select.2.1, i64 2, !dbg !89
  %add194.3.1 = or disjoint i32 %add190, 3, !dbg !90
  %cmp197.not.3.1 = icmp sgt i32 %add194.3.1, %7, !dbg !87
  %spec.select.3.1 = select i1 %cmp197.not.3.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !88
  %scores.sroa.0.12.vec.insert1471 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1446, float %spec.select.3.1, i64 3, !dbg !89
  %add196.4.1 = add nuw nsw i32 %add190, 16, !dbg !91
  %cmp197.not.4.1 = icmp sgt i32 %add196.4.1, %7, !dbg !87
  %spec.select.4.1 = select i1 %cmp197.not.4.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !88
  %scores.sroa.90.16.vec.insert1512 = insertelement <4 x float> poison, float %spec.select.4.1, i64 0, !dbg !89
  %add196.5.1 = add nuw nsw i32 %add190, 17, !dbg !91
  %cmp197.not.5.1 = icmp sgt i32 %add196.5.1, %7, !dbg !87
  %spec.select.5.1 = select i1 %cmp197.not.5.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !88
  %scores.sroa.90.20.vec.insert1537 = insertelement <4 x float> %scores.sroa.90.16.vec.insert1512, float %spec.select.5.1, i64 1, !dbg !89
  %add196.6.1 = add nuw nsw i32 %add190, 18, !dbg !91
  %cmp197.not.6.1 = icmp sgt i32 %add196.6.1, %7, !dbg !87
  %spec.select.6.1 = select i1 %cmp197.not.6.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !88
  %scores.sroa.90.24.vec.insert1562 = insertelement <4 x float> %scores.sroa.90.20.vec.insert1537, float %spec.select.6.1, i64 2, !dbg !89
  %add196.7.1 = add nuw nsw i32 %add190, 19, !dbg !91
  %cmp197.not.7.1 = icmp sgt i32 %add196.7.1, %7, !dbg !87
  %spec.select.7.1 = select i1 %cmp197.not.7.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !88
  %scores.sroa.90.28.vec.insert1587 = insertelement <4 x float> %scores.sroa.90.24.vec.insert1562, float %spec.select.7.1, i64 3, !dbg !89
  %150 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.1, <4 x half> %q.sroa.0.0.copyload1601, <4 x float> %scores.sroa.0.12.vec.insert1471), !dbg !92
  %151 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.1, <4 x half> %q.sroa.0.0.copyload1601, <4 x float> %scores.sroa.90.28.vec.insert1587), !dbg !92
  %152 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.6.1, <4 x half> %q.sroa.6.0.copyload1602, <4 x float> %150), !dbg !92
  %153 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.12.1, <4 x half> %q.sroa.6.0.copyload1602, <4 x float> %151), !dbg !92
  %154 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.1, <4 x half> %q.sroa.8.16.copyload1605, <4 x float> %152), !dbg !92
  %155 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.1, <4 x half> %q.sroa.8.16.copyload1605, <4 x float> %153), !dbg !92
  %156 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.18.1, <4 x half> %q.sroa.12.16.copyload1606, <4 x float> %154), !dbg !92
  %157 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.24.1, <4 x half> %q.sroa.12.16.copyload1606, <4 x float> %155), !dbg !92
  %158 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.26.1, <4 x half> %q.sroa.14.32.copyload1609, <4 x float> %156), !dbg !92
  %159 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.32.1, <4 x half> %q.sroa.14.32.copyload1609, <4 x float> %157), !dbg !92
  %160 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.30.1, <4 x half> %q.sroa.18.32.copyload1610, <4 x float> %158), !dbg !92
  %161 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.36.1, <4 x half> %q.sroa.18.32.copyload1610, <4 x float> %159), !dbg !92
  %162 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.38.1, <4 x half> %q.sroa.20.48.copyload1613, <4 x float> %160), !dbg !92
  %163 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.44.1, <4 x half> %q.sroa.20.48.copyload1613, <4 x float> %161), !dbg !92
  %164 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.42.1, <4 x half> %q.sroa.24.48.copyload1614, <4 x float> %162), !dbg !92
  %165 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.48.1, <4 x half> %q.sroa.24.48.copyload1614, <4 x float> %163), !dbg !92
  %.idx793.1838 = shl nuw nsw i64 %shr, 19, !dbg !95
  %166 = getelementptr i8, ptr addrspace(4) %gep769, i64 %.idx793.1838, !dbg !95
  %167 = getelementptr %struct.__half, ptr addrspace(4) %166, i64 %mul102, !dbg !95
  %v.sroa.48.112.gep759.7.1.sroa_idx = getelementptr i8, ptr addrspace(4) %167, i64 7176, !dbg !96
  %v.sroa.48.112.copyload1760 = load <4 x half>, ptr addrspace(4) %v.sroa.48.112.gep759.7.1.sroa_idx, align 8, !dbg !96
  %gep759.7.1 = getelementptr i8, ptr addrspace(4) %167, i64 7168, !dbg !95
  %v.sroa.44.112.copyload1759 = load <4 x half>, ptr addrspace(4) %gep759.7.1, align 16, !dbg !96
  %v.sroa.42.96.gep759.6.1.sroa_idx = getelementptr i8, ptr addrspace(4) %167, i64 6152, !dbg !96
  %v.sroa.42.96.copyload1756 = load <4 x half>, ptr addrspace(4) %v.sroa.42.96.gep759.6.1.sroa_idx, align 8, !dbg !96
  %gep759.6.1 = getelementptr i8, ptr addrspace(4) %167, i64 6144, !dbg !95
  %v.sroa.38.96.copyload1755 = load <4 x half>, ptr addrspace(4) %gep759.6.1, align 16, !dbg !96
  %v.sroa.36.80.gep759.5.1.sroa_idx = getelementptr i8, ptr addrspace(4) %167, i64 5128, !dbg !96
  %v.sroa.36.80.copyload1752 = load <4 x half>, ptr addrspace(4) %v.sroa.36.80.gep759.5.1.sroa_idx, align 8, !dbg !96
  %gep759.5.1 = getelementptr i8, ptr addrspace(4) %167, i64 5120, !dbg !95
  %v.sroa.32.80.copyload1751 = load <4 x half>, ptr addrspace(4) %gep759.5.1, align 16, !dbg !96
  %v.sroa.30.64.gep759.4.1.sroa_idx = getelementptr i8, ptr addrspace(4) %167, i64 4104, !dbg !96
  %v.sroa.30.64.copyload1748 = load <4 x half>, ptr addrspace(4) %v.sroa.30.64.gep759.4.1.sroa_idx, align 8, !dbg !96
  %gep759.4.1 = getelementptr i8, ptr addrspace(4) %167, i64 4096, !dbg !95
  %v.sroa.26.64.copyload1747 = load <4 x half>, ptr addrspace(4) %gep759.4.1, align 16, !dbg !96
  %v.sroa.24.48.gep759.3.1.sroa_idx = getelementptr i8, ptr addrspace(4) %167, i64 3080, !dbg !96
  %v.sroa.24.48.copyload1744 = load <4 x half>, ptr addrspace(4) %v.sroa.24.48.gep759.3.1.sroa_idx, align 8, !dbg !96
  %gep759.3.1 = getelementptr i8, ptr addrspace(4) %167, i64 3072, !dbg !95
  %v.sroa.20.48.copyload1743 = load <4 x half>, ptr addrspace(4) %gep759.3.1, align 16, !dbg !96
  %v.sroa.18.32.gep759.2.1.sroa_idx = getelementptr i8, ptr addrspace(4) %167, i64 2056, !dbg !96
  %v.sroa.18.32.copyload1740 = load <4 x half>, ptr addrspace(4) %v.sroa.18.32.gep759.2.1.sroa_idx, align 8, !dbg !96
  %gep759.2.1 = getelementptr i8, ptr addrspace(4) %167, i64 2048, !dbg !95
  %v.sroa.14.32.copyload1739 = load <4 x half>, ptr addrspace(4) %gep759.2.1, align 16, !dbg !96
  %v.sroa.12.16.gep759.1.1.sroa_idx = getelementptr i8, ptr addrspace(4) %167, i64 1032, !dbg !96
  %v.sroa.12.16.copyload1736 = load <4 x half>, ptr addrspace(4) %v.sroa.12.16.gep759.1.1.sroa_idx, align 8, !dbg !96
  %gep759.1.1 = getelementptr i8, ptr addrspace(4) %167, i64 1024, !dbg !95
  %v.sroa.8.16.copyload1735 = load <4 x half>, ptr addrspace(4) %gep759.1.1, align 16, !dbg !96
  %v.sroa.6.0..sroa_idx1731 = getelementptr inbounds i8, ptr addrspace(4) %167, i64 8, !dbg !96
  %v.sroa.6.0.copyload1732 = load <4 x half>, ptr addrspace(4) %v.sroa.6.0..sroa_idx1731, align 8, !dbg !96
  %v.sroa.0.0.copyload1730 = load <4 x half>, ptr addrspace(4) %167, align 16, !dbg !96
  %scores.sroa.0.0.vec.extract1398 = extractelement <4 x float> %164, i64 0, !dbg !98
  %mul283.1839 = fmul contract float %scores.sroa.0.0.vec.extract1398, 0x3FC2776C60000000, !dbg !99
  %168 = tail call contract noundef float @llvm.minnum.f32(float %mul283.1839, float 1.500000e+01), !dbg !100
  %cmp.i.i.1840 = fcmp contract olt float %168, -1.260000e+02, !dbg !104
  %cond.i.i.1841 = select contract i1 %cmp.i.i.1840, float 6.400000e+01, float 0.000000e+00, !dbg !104
  %add.i.i730.1842 = fadd contract float %168, %cond.i.i.1841, !dbg !104
  %169 = tail call contract float @llvm.exp2.f32(float %add.i.i730.1842), !dbg !104
  %cond2.i.i.1843 = select contract i1 %cmp.i.i.1840, float 0x3BF0000000000000, float 1.000000e+00, !dbg !104
  %mul.i.i.1844 = fmul contract float %cond2.i.i.1843, %169, !dbg !104
  %scores.sroa.0.4.vec.extract1423 = extractelement <4 x float> %164, i64 1, !dbg !98
  %mul283.1.1 = fmul contract float %scores.sroa.0.4.vec.extract1423, 0x3FC2776C60000000, !dbg !99
  %170 = tail call contract noundef float @llvm.minnum.f32(float %mul283.1.1, float 1.500000e+01), !dbg !100
  %cmp.i.i.1.1 = fcmp contract olt float %170, -1.260000e+02, !dbg !104
  %cond.i.i.1.1 = select contract i1 %cmp.i.i.1.1, float 6.400000e+01, float 0.000000e+00, !dbg !104
  %add.i.i730.1.1 = fadd contract float %170, %cond.i.i.1.1, !dbg !104
  %171 = tail call contract float @llvm.exp2.f32(float %add.i.i730.1.1), !dbg !104
  %cond2.i.i.1.1 = select contract i1 %cmp.i.i.1.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !104
  %mul.i.i.1.1 = fmul contract float %cond2.i.i.1.1, %171, !dbg !104
  %scores.sroa.0.8.vec.extract1448 = extractelement <4 x float> %164, i64 2, !dbg !98
  %mul283.2.1 = fmul contract float %scores.sroa.0.8.vec.extract1448, 0x3FC2776C60000000, !dbg !99
  %172 = tail call contract noundef float @llvm.minnum.f32(float %mul283.2.1, float 1.500000e+01), !dbg !100
  %cmp.i.i.2.1 = fcmp contract olt float %172, -1.260000e+02, !dbg !104
  %cond.i.i.2.1 = select contract i1 %cmp.i.i.2.1, float 6.400000e+01, float 0.000000e+00, !dbg !104
  %add.i.i730.2.1 = fadd contract float %172, %cond.i.i.2.1, !dbg !104
  %173 = tail call contract float @llvm.exp2.f32(float %add.i.i730.2.1), !dbg !104
  %cond2.i.i.2.1 = select contract i1 %cmp.i.i.2.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !104
  %mul.i.i.2.1 = fmul contract float %cond2.i.i.2.1, %173, !dbg !104
  %scores.sroa.0.12.vec.extract1473 = extractelement <4 x float> %164, i64 3, !dbg !98
  %mul283.3.1 = fmul contract float %scores.sroa.0.12.vec.extract1473, 0x3FC2776C60000000, !dbg !99
  %174 = tail call contract noundef float @llvm.minnum.f32(float %mul283.3.1, float 1.500000e+01), !dbg !100
  %cmp.i.i.3.1 = fcmp contract olt float %174, -1.260000e+02, !dbg !104
  %cond.i.i.3.1 = select contract i1 %cmp.i.i.3.1, float 6.400000e+01, float 0.000000e+00, !dbg !104
  %add.i.i730.3.1 = fadd contract float %174, %cond.i.i.3.1, !dbg !104
  %175 = tail call contract float @llvm.exp2.f32(float %add.i.i730.3.1), !dbg !104
  %cond2.i.i.3.1 = select contract i1 %cmp.i.i.3.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !104
  %mul.i.i.3.1 = fmul contract float %cond2.i.i.3.1, %175, !dbg !104
  %scores.sroa.90.16.vec.extract1514 = extractelement <4 x float> %165, i64 0, !dbg !98
  %mul283.4.1 = fmul contract float %scores.sroa.90.16.vec.extract1514, 0x3FC2776C60000000, !dbg !99
  %176 = tail call contract noundef float @llvm.minnum.f32(float %mul283.4.1, float 1.500000e+01), !dbg !100
  %cmp.i.i.4.1 = fcmp contract olt float %176, -1.260000e+02, !dbg !104
  %cond.i.i.4.1 = select contract i1 %cmp.i.i.4.1, float 6.400000e+01, float 0.000000e+00, !dbg !104
  %add.i.i730.4.1 = fadd contract float %176, %cond.i.i.4.1, !dbg !104
  %177 = tail call contract float @llvm.exp2.f32(float %add.i.i730.4.1), !dbg !104
  %cond2.i.i.4.1 = select contract i1 %cmp.i.i.4.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !104
  %mul.i.i.4.1 = fmul contract float %cond2.i.i.4.1, %177, !dbg !104
  %scores.sroa.90.20.vec.extract1539 = extractelement <4 x float> %165, i64 1, !dbg !98
  %mul283.5.1 = fmul contract float %scores.sroa.90.20.vec.extract1539, 0x3FC2776C60000000, !dbg !99
  %178 = tail call contract noundef float @llvm.minnum.f32(float %mul283.5.1, float 1.500000e+01), !dbg !100
  %cmp.i.i.5.1 = fcmp contract olt float %178, -1.260000e+02, !dbg !104
  %cond.i.i.5.1 = select contract i1 %cmp.i.i.5.1, float 6.400000e+01, float 0.000000e+00, !dbg !104
  %add.i.i730.5.1 = fadd contract float %178, %cond.i.i.5.1, !dbg !104
  %179 = tail call contract float @llvm.exp2.f32(float %add.i.i730.5.1), !dbg !104
  %cond2.i.i.5.1 = select contract i1 %cmp.i.i.5.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !104
  %mul.i.i.5.1 = fmul contract float %cond2.i.i.5.1, %179, !dbg !104
  %scores.sroa.90.24.vec.extract1564 = extractelement <4 x float> %165, i64 2, !dbg !98
  %mul283.6.1 = fmul contract float %scores.sroa.90.24.vec.extract1564, 0x3FC2776C60000000, !dbg !99
  %180 = tail call contract noundef float @llvm.minnum.f32(float %mul283.6.1, float 1.500000e+01), !dbg !100
  %cmp.i.i.6.1 = fcmp contract olt float %180, -1.260000e+02, !dbg !104
  %cond.i.i.6.1 = select contract i1 %cmp.i.i.6.1, float 6.400000e+01, float 0.000000e+00, !dbg !104
  %add.i.i730.6.1 = fadd contract float %180, %cond.i.i.6.1, !dbg !104
  %181 = tail call contract float @llvm.exp2.f32(float %add.i.i730.6.1), !dbg !104
  %cond2.i.i.6.1 = select contract i1 %cmp.i.i.6.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !104
  %mul.i.i.6.1 = fmul contract float %cond2.i.i.6.1, %181, !dbg !104
  %scores.sroa.90.28.vec.extract1589 = extractelement <4 x float> %165, i64 3, !dbg !98
  %mul283.7.1 = fmul contract float %scores.sroa.90.28.vec.extract1589, 0x3FC2776C60000000, !dbg !99
  %182 = tail call contract noundef float @llvm.minnum.f32(float %mul283.7.1, float 1.500000e+01), !dbg !100
  %cmp.i.i.7.1 = fcmp contract olt float %182, -1.260000e+02, !dbg !104
  %cond.i.i.7.1 = select contract i1 %cmp.i.i.7.1, float 6.400000e+01, float 0.000000e+00, !dbg !104
  %add.i.i730.7.1 = fadd contract float %182, %cond.i.i.7.1, !dbg !104
  %183 = tail call contract float @llvm.exp2.f32(float %add.i.i730.7.1), !dbg !104
  %cond2.i.i.7.1 = select contract i1 %cmp.i.i.7.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !104
  %mul.i.i.7.1 = fmul contract float %cond2.i.i.7.1, %183, !dbg !104
  %add303.1845 = fadd contract float %mul.i.i.1844, 0.000000e+00, !dbg !107
  %add303.1.1 = fadd contract float %add303.1845, %mul.i.i.4.1, !dbg !107
  %add303.2.1 = fadd contract float %add303.1.1, %mul.i.i.1.1, !dbg !107
  %add303.3.1 = fadd contract float %add303.2.1, %mul.i.i.5.1, !dbg !107
  %add303.4.1 = fadd contract float %add303.3.1, %mul.i.i.2.1, !dbg !107
  %add303.5.1 = fadd contract float %add303.4.1, %mul.i.i.6.1, !dbg !107
  %add303.6.1 = fadd contract float %add303.5.1, %mul.i.i.3.1, !dbg !107
  %add303.7.1 = fadd contract float %add303.6.1, %mul.i.i.7.1, !dbg !107
  %184 = bitcast float %add303.7.1 to i32, !dbg !108
  %185 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !119
  %186 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %185) #11, !dbg !124
  %xor.i.i.1 = xor i32 %186, 32, !dbg !125
  %187 = and i32 %186, -64, !dbg !126
  %and.i.i.1 = add nsw i32 %187, 64, !dbg !126
  %cmp.not.i.i.1 = icmp slt i32 %xor.i.i.1, %and.i.i.1, !dbg !127
  %cond.i.i731.1 = select i1 %cmp.not.i.i.1, i32 %xor.i.i.1, i32 %186, !dbg !128
  %shl.i.i.1 = shl i32 %cond.i.i731.1, 2, !dbg !129
  %188 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.1, i32 %184), !dbg !130
  %189 = bitcast i32 %188 to float, !dbg !131
  %add.i.1 = fadd contract float %add303.7.1, %189, !dbg !132
  %190 = bitcast float %add.i.1 to i32, !dbg !135
  %191 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !142
  %192 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %191) #11, !dbg !145
  %xor.i.i732.1 = xor i32 %192, 16, !dbg !146
  %193 = and i32 %192, -64, !dbg !147
  %and.i.i733.1 = add nsw i32 %193, 64, !dbg !147
  %cmp.not.i.i734.1 = icmp slt i32 %xor.i.i732.1, %and.i.i733.1, !dbg !148
  %cond.i.i735.1 = select i1 %cmp.not.i.i734.1, i32 %xor.i.i732.1, i32 %192, !dbg !149
  %shl.i.i736.1 = shl i32 %cond.i.i735.1, 2, !dbg !150
  %194 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i736.1, i32 %190), !dbg !151
  %195 = bitcast i32 %194 to float, !dbg !152
  %add.i.i.1 = fadd contract float %add.i.1, %195, !dbg !153
  %cmp312.1 = fcmp contract ogt float %add.i.i.1, 0.000000e+00, !dbg !155
  %div.1 = fdiv contract float 1.000000e+00, %add.i.i.1, !dbg !156
  %condval_8.0.1 = select i1 %cmp312.1, float %div.1, float 0.000000e+00, !dbg !156
  %mul325.1846 = fmul contract float %condval_8.0.1, %mul.i.i.1844, !dbg !157
  %mul325.1.1 = fmul contract float %condval_8.0.1, %mul.i.i.1.1, !dbg !157
  %mul325.2.1 = fmul contract float %condval_8.0.1, %mul.i.i.2.1, !dbg !157
  %mul325.3.1 = fmul contract float %condval_8.0.1, %mul.i.i.3.1, !dbg !157
  %mul325.4.1 = fmul contract float %condval_8.0.1, %mul.i.i.4.1, !dbg !157
  %mul325.5.1 = fmul contract float %condval_8.0.1, %mul.i.i.5.1, !dbg !157
  %mul325.6.1 = fmul contract float %condval_8.0.1, %mul.i.i.6.1, !dbg !157
  %mul325.7.1 = fmul contract float %condval_8.0.1, %mul.i.i.7.1, !dbg !157
  %196 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.1846), !dbg !158
  %197 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.1.1), !dbg !158
  %198 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.2.1), !dbg !158
  %199 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.3.1), !dbg !158
  %200 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.4.1), !dbg !158
  %201 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.5.1), !dbg !158
  %202 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.6.1), !dbg !158
  %203 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul325.7.1), !dbg !158
  fence syncscope("warp") release, !dbg !167
  tail call void @llvm.mxc.barrier.warp(), !dbg !170
  fence syncscope("warp") acquire, !dbg !171
  %204 = insertelement <4 x i16> poison, i16 %196, i64 0, !dbg !173
  %205 = insertelement <4 x i16> %204, i16 %197, i64 1, !dbg !173
  %206 = insertelement <4 x i16> %205, i16 %198, i64 2, !dbg !173
  %207 = insertelement <4 x i16> %206, i16 %199, i64 3, !dbg !173
  %208 = bitcast <4 x i16> %207 to <4 x half>, !dbg !173
  %209 = insertelement <4 x i16> poison, i16 %200, i64 0, !dbg !173
  %210 = insertelement <4 x i16> %209, i16 %201, i64 1, !dbg !173
  %211 = insertelement <4 x i16> %210, i16 %202, i64 2, !dbg !173
  %212 = insertelement <4 x i16> %211, i16 %203, i64 3, !dbg !173
  %213 = bitcast <4 x i16> %212 to <4 x half>, !dbg !173
  br label %if.end357.1, !dbg !172

if.end357.1:                                      ; preds = %if.end119.1, %if.end79.7.1, %if.end357
  %v.sroa.48.3 = phi <4 x half> [ %v.sroa.48.112.copyload1760, %if.end119.1 ], [ %v.sroa.48.1, %if.end79.7.1 ], [ %v.sroa.48.1, %if.end357 ], !dbg !96
  %v.sroa.44.3 = phi <4 x half> [ %v.sroa.44.112.copyload1759, %if.end119.1 ], [ %v.sroa.44.1, %if.end79.7.1 ], [ %v.sroa.44.1, %if.end357 ], !dbg !96
  %v.sroa.42.3 = phi <4 x half> [ %v.sroa.42.96.copyload1756, %if.end119.1 ], [ %v.sroa.42.1, %if.end79.7.1 ], [ %v.sroa.42.1, %if.end357 ], !dbg !96
  %v.sroa.38.3 = phi <4 x half> [ %v.sroa.38.96.copyload1755, %if.end119.1 ], [ %v.sroa.38.1, %if.end79.7.1 ], [ %v.sroa.38.1, %if.end357 ], !dbg !96
  %v.sroa.36.3 = phi <4 x half> [ %v.sroa.36.80.copyload1752, %if.end119.1 ], [ %v.sroa.36.1, %if.end79.7.1 ], [ %v.sroa.36.1, %if.end357 ], !dbg !96
  %v.sroa.32.3 = phi <4 x half> [ %v.sroa.32.80.copyload1751, %if.end119.1 ], [ %v.sroa.32.1, %if.end79.7.1 ], [ %v.sroa.32.1, %if.end357 ], !dbg !96
  %v.sroa.30.3 = phi <4 x half> [ %v.sroa.30.64.copyload1748, %if.end119.1 ], [ %v.sroa.30.1, %if.end79.7.1 ], [ %v.sroa.30.1, %if.end357 ], !dbg !96
  %v.sroa.26.3 = phi <4 x half> [ %v.sroa.26.64.copyload1747, %if.end119.1 ], [ %v.sroa.26.1, %if.end79.7.1 ], [ %v.sroa.26.1, %if.end357 ], !dbg !96
  %v.sroa.24.3 = phi <4 x half> [ %v.sroa.24.48.copyload1744, %if.end119.1 ], [ %v.sroa.24.1, %if.end79.7.1 ], [ %v.sroa.24.1, %if.end357 ], !dbg !96
  %v.sroa.20.3 = phi <4 x half> [ %v.sroa.20.48.copyload1743, %if.end119.1 ], [ %v.sroa.20.1, %if.end79.7.1 ], [ %v.sroa.20.1, %if.end357 ], !dbg !96
  %v.sroa.18.3 = phi <4 x half> [ %v.sroa.18.32.copyload1740, %if.end119.1 ], [ %v.sroa.18.1, %if.end79.7.1 ], [ %v.sroa.18.1, %if.end357 ], !dbg !96
  %v.sroa.14.3 = phi <4 x half> [ %v.sroa.14.32.copyload1739, %if.end119.1 ], [ %v.sroa.14.1, %if.end79.7.1 ], [ %v.sroa.14.1, %if.end357 ], !dbg !96
  %v.sroa.12.3 = phi <4 x half> [ %v.sroa.12.16.copyload1736, %if.end119.1 ], [ %v.sroa.12.1, %if.end79.7.1 ], [ %v.sroa.12.1, %if.end357 ], !dbg !96
  %v.sroa.8.3 = phi <4 x half> [ %v.sroa.8.16.copyload1735, %if.end119.1 ], [ %v.sroa.8.1, %if.end79.7.1 ], [ %v.sroa.8.1, %if.end357 ], !dbg !96
  %v.sroa.6.3 = phi <4 x half> [ %v.sroa.6.0.copyload1732, %if.end119.1 ], [ %v.sroa.6.1, %if.end79.7.1 ], [ %v.sroa.6.1, %if.end357 ], !dbg !96
  %v.sroa.0.3 = phi <4 x half> [ %v.sroa.0.0.copyload1730, %if.end119.1 ], [ %v.sroa.0.1, %if.end79.7.1 ], [ %v.sroa.0.1, %if.end357 ], !dbg !96
  %214 = phi <4 x half> [ %213, %if.end119.1 ], [ undef, %if.end79.7.1 ], [ undef, %if.end357 ]
  %215 = phi <4 x half> [ %208, %if.end119.1 ], [ undef, %if.end79.7.1 ], [ undef, %if.end357 ]
  %mul510 = and i32 %13, 4
  %mul538 = and i32 %12, 8064
  %invariant.gep780 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul538
  %216 = shl nuw nsw i32 %1, 18
  %mul553 = and i32 %216, 2145386496
  %add555 = or disjoint i32 %mul553, %12
  br i1 %cmp32, label %if.then370, label %if.end567, !dbg !174

if.then370:                                       ; preds = %if.end357.1
  %cmp380 = icmp ule i32 %mul88, %6
  %or.cond786 = select i1 %cmp87, i1 %cmp380, i1 false, !dbg !175
  br i1 %or.cond786, label %for.cond385.preheader, label %if.end486, !dbg !175

for.cond385.preheader:                            ; preds = %if.then370
  %217 = insertelement <4 x i16> poison, i16 %pair_prob.sroa.0.0, i64 0, !dbg !173
  %218 = insertelement <4 x i16> %217, i16 %pair_prob.sroa.4.0, i64 1, !dbg !173
  %219 = insertelement <4 x i16> %218, i16 %pair_prob.sroa.6.0, i64 2, !dbg !173
  %220 = insertelement <4 x i16> %219, i16 %pair_prob.sroa.8.0, i64 3, !dbg !173
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %220 to <4 x half>, !dbg !173
  %221 = insertelement <4 x i16> poison, i16 %pair_prob.sroa.10.0, i64 0, !dbg !173
  %222 = insertelement <4 x i16> %221, i16 %pair_prob.sroa.12.0, i64 1, !dbg !173
  %223 = insertelement <4 x i16> %222, i16 %pair_prob.sroa.14.0, i64 2, !dbg !173
  %224 = insertelement <4 x i16> %223, i16 %pair_prob.sroa.16.0, i64 3, !dbg !173
  %prob.sroa.12.14.vec.insert = bitcast <4 x i16> %224 to <4 x half>, !dbg !173
  %225 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.3, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !176
  %226 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.6.3, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !176
  %227 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.8.3, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !176
  %228 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.12.3, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !176
  %229 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.3, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !176
  %230 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.18.3, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !176
  %231 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.20.3, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !176
  %232 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.24.3, <4 x half> %prob.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !176
  %233 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.26.3, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %225), !dbg !176
  %234 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.30.3, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %226), !dbg !176
  %235 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.32.3, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %227), !dbg !176
  %236 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.36.3, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %228), !dbg !176
  %237 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.38.3, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %229), !dbg !176
  %238 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.42.3, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %230), !dbg !176
  %239 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.44.3, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %231), !dbg !176
  %240 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.48.3, <4 x half> %prob.sroa.12.14.vec.insert, <4 x float> %232), !dbg !176
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %233, i64 0, !dbg !177
  %241 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract), !dbg !178
  %output_reg.sroa.0.0.insert.ext = zext i16 %241 to i64, !dbg !182
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %233, i64 1, !dbg !177
  %242 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract), !dbg !178
  %output_reg.sroa.0.2.insert.ext = zext i16 %242 to i64, !dbg !182
  %output_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext, 16, !dbg !182
  %output_reg.sroa.0.2.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.shift, %output_reg.sroa.0.0.insert.ext, !dbg !182
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %233, i64 2, !dbg !177
  %243 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract), !dbg !178
  %output_reg.sroa.0.4.insert.ext = zext i16 %243 to i64, !dbg !182
  %output_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext, 32, !dbg !182
  %output_reg.sroa.0.4.insert.insert1113 = or disjoint i64 %output_reg.sroa.0.2.insert.insert, %output_reg.sroa.0.4.insert.shift, !dbg !182
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %233, i64 3, !dbg !177
  %244 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract), !dbg !178
  %output_reg.sroa.0.6.insert.ext = zext i16 %244 to i64, !dbg !182
  %output_reg.sroa.0.6.insert.shift = shl nuw i64 %output_reg.sroa.0.6.insert.ext, 48, !dbg !182
  %output_reg.sroa.0.6.insert.insert = or disjoint i64 %output_reg.sroa.0.4.insert.insert1113, %output_reg.sroa.0.6.insert.shift, !dbg !182
  %out.sroa.26.16.vec.extract = extractelement <4 x float> %234, i64 0, !dbg !177
  %245 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.16.vec.extract), !dbg !178
  %output_reg.sroa.16.8.insert.ext = zext i16 %245 to i64, !dbg !182
  %out.sroa.26.20.vec.extract = extractelement <4 x float> %234, i64 1, !dbg !177
  %246 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.20.vec.extract), !dbg !178
  %output_reg.sroa.16.10.insert.ext = zext i16 %246 to i64, !dbg !182
  %output_reg.sroa.16.10.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.10.insert.ext, 16, !dbg !182
  %output_reg.sroa.16.10.insert.insert = or disjoint i64 %output_reg.sroa.16.10.insert.shift, %output_reg.sroa.16.8.insert.ext, !dbg !182
  %out.sroa.26.24.vec.extract = extractelement <4 x float> %234, i64 2, !dbg !177
  %247 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.24.vec.extract), !dbg !178
  %output_reg.sroa.16.12.insert.ext = zext i16 %247 to i64, !dbg !182
  %output_reg.sroa.16.12.insert.shift = shl nuw nsw i64 %output_reg.sroa.16.12.insert.ext, 32, !dbg !182
  %output_reg.sroa.16.12.insert.insert1145 = or disjoint i64 %output_reg.sroa.16.10.insert.insert, %output_reg.sroa.16.12.insert.shift, !dbg !182
  %out.sroa.26.28.vec.extract = extractelement <4 x float> %234, i64 3, !dbg !177
  %248 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.28.vec.extract), !dbg !178
  %output_reg.sroa.16.14.insert.ext = zext i16 %248 to i64, !dbg !182
  %output_reg.sroa.16.14.insert.shift = shl nuw i64 %output_reg.sroa.16.14.insert.ext, 48, !dbg !182
  %output_reg.sroa.16.14.insert.insert = or disjoint i64 %output_reg.sroa.16.12.insert.insert1145, %output_reg.sroa.16.14.insert.shift, !dbg !182
  %out.sroa.50.32.vec.extract = extractelement <4 x float> %235, i64 0, !dbg !177
  %249 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.32.vec.extract), !dbg !178
  %output_reg.sroa.30.16.insert.ext = zext i16 %249 to i64, !dbg !182
  %out.sroa.50.36.vec.extract = extractelement <4 x float> %235, i64 1, !dbg !177
  %250 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.36.vec.extract), !dbg !178
  %output_reg.sroa.30.18.insert.ext = zext i16 %250 to i64, !dbg !182
  %output_reg.sroa.30.18.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.18.insert.ext, 16, !dbg !182
  %output_reg.sroa.30.18.insert.insert = or disjoint i64 %output_reg.sroa.30.18.insert.shift, %output_reg.sroa.30.16.insert.ext, !dbg !182
  %out.sroa.50.40.vec.extract = extractelement <4 x float> %235, i64 2, !dbg !177
  %251 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.40.vec.extract), !dbg !178
  %output_reg.sroa.30.20.insert.ext = zext i16 %251 to i64, !dbg !182
  %output_reg.sroa.30.20.insert.shift = shl nuw nsw i64 %output_reg.sroa.30.20.insert.ext, 32, !dbg !182
  %output_reg.sroa.30.20.insert.insert1177 = or disjoint i64 %output_reg.sroa.30.18.insert.insert, %output_reg.sroa.30.20.insert.shift, !dbg !182
  %out.sroa.50.44.vec.extract = extractelement <4 x float> %235, i64 3, !dbg !177
  %252 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.44.vec.extract), !dbg !178
  %output_reg.sroa.30.22.insert.ext = zext i16 %252 to i64, !dbg !182
  %output_reg.sroa.30.22.insert.shift = shl nuw i64 %output_reg.sroa.30.22.insert.ext, 48, !dbg !182
  %output_reg.sroa.30.22.insert.insert = or disjoint i64 %output_reg.sroa.30.20.insert.insert1177, %output_reg.sroa.30.22.insert.shift, !dbg !182
  %out.sroa.74.48.vec.extract = extractelement <4 x float> %236, i64 0, !dbg !177
  %253 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.48.vec.extract), !dbg !178
  %output_reg.sroa.44.24.insert.ext = zext i16 %253 to i64, !dbg !182
  %out.sroa.74.52.vec.extract = extractelement <4 x float> %236, i64 1, !dbg !177
  %254 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.52.vec.extract), !dbg !178
  %output_reg.sroa.44.26.insert.ext = zext i16 %254 to i64, !dbg !182
  %output_reg.sroa.44.26.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.26.insert.ext, 16, !dbg !182
  %output_reg.sroa.44.26.insert.insert = or disjoint i64 %output_reg.sroa.44.26.insert.shift, %output_reg.sroa.44.24.insert.ext, !dbg !182
  %out.sroa.74.56.vec.extract = extractelement <4 x float> %236, i64 2, !dbg !177
  %255 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.56.vec.extract), !dbg !178
  %output_reg.sroa.44.28.insert.ext = zext i16 %255 to i64, !dbg !182
  %output_reg.sroa.44.28.insert.shift = shl nuw nsw i64 %output_reg.sroa.44.28.insert.ext, 32, !dbg !182
  %output_reg.sroa.44.28.insert.insert1209 = or disjoint i64 %output_reg.sroa.44.26.insert.insert, %output_reg.sroa.44.28.insert.shift, !dbg !182
  %out.sroa.74.60.vec.extract = extractelement <4 x float> %236, i64 3, !dbg !177
  %256 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.60.vec.extract), !dbg !178
  %output_reg.sroa.44.30.insert.ext = zext i16 %256 to i64, !dbg !182
  %output_reg.sroa.44.30.insert.shift = shl nuw i64 %output_reg.sroa.44.30.insert.ext, 48, !dbg !182
  %output_reg.sroa.44.30.insert.insert = or disjoint i64 %output_reg.sroa.44.28.insert.insert1209, %output_reg.sroa.44.30.insert.shift, !dbg !182
  %out.sroa.98.64.vec.extract = extractelement <4 x float> %237, i64 0, !dbg !177
  %257 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.64.vec.extract), !dbg !178
  %output_reg.sroa.58.32.insert.ext = zext i16 %257 to i64, !dbg !182
  %out.sroa.98.68.vec.extract = extractelement <4 x float> %237, i64 1, !dbg !177
  %258 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.68.vec.extract), !dbg !178
  %output_reg.sroa.58.34.insert.ext = zext i16 %258 to i64, !dbg !182
  %output_reg.sroa.58.34.insert.shift = shl nuw nsw i64 %output_reg.sroa.58.34.insert.ext, 16, !dbg !182
  %output_reg.sroa.58.34.insert.insert = or disjoint i64 %output_reg.sroa.58.34.insert.shift, %output_reg.sroa.58.32.insert.ext, !dbg !182
  %out.sroa.98.72.vec.extract = extractelement <4 x float> %237, i64 2, !dbg !177
  %259 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.72.vec.extract), !dbg !178
  %output_reg.sroa.58.36.insert.ext = zext i16 %259 to i64, !dbg !182
  %output_reg.sroa.58.36.insert.shift = shl nuw nsw i64 %output_reg.sroa.58.36.insert.ext, 32, !dbg !182
  %output_reg.sroa.58.36.insert.insert1241 = or disjoint i64 %output_reg.sroa.58.34.insert.insert, %output_reg.sroa.58.36.insert.shift, !dbg !182
  %out.sroa.98.76.vec.extract = extractelement <4 x float> %237, i64 3, !dbg !177
  %260 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.76.vec.extract), !dbg !178
  %output_reg.sroa.58.38.insert.ext = zext i16 %260 to i64, !dbg !182
  %output_reg.sroa.58.38.insert.shift = shl nuw i64 %output_reg.sroa.58.38.insert.ext, 48, !dbg !182
  %output_reg.sroa.58.38.insert.insert = or disjoint i64 %output_reg.sroa.58.36.insert.insert1241, %output_reg.sroa.58.38.insert.shift, !dbg !182
  %out.sroa.122.80.vec.extract = extractelement <4 x float> %238, i64 0, !dbg !177
  %261 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.80.vec.extract), !dbg !178
  %output_reg.sroa.72.40.insert.ext = zext i16 %261 to i64, !dbg !182
  %out.sroa.122.84.vec.extract = extractelement <4 x float> %238, i64 1, !dbg !177
  %262 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.84.vec.extract), !dbg !178
  %output_reg.sroa.72.42.insert.ext = zext i16 %262 to i64, !dbg !182
  %output_reg.sroa.72.42.insert.shift = shl nuw nsw i64 %output_reg.sroa.72.42.insert.ext, 16, !dbg !182
  %output_reg.sroa.72.42.insert.insert = or disjoint i64 %output_reg.sroa.72.42.insert.shift, %output_reg.sroa.72.40.insert.ext, !dbg !182
  %out.sroa.122.88.vec.extract = extractelement <4 x float> %238, i64 2, !dbg !177
  %263 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.88.vec.extract), !dbg !178
  %output_reg.sroa.72.44.insert.ext = zext i16 %263 to i64, !dbg !182
  %output_reg.sroa.72.44.insert.shift = shl nuw nsw i64 %output_reg.sroa.72.44.insert.ext, 32, !dbg !182
  %output_reg.sroa.72.44.insert.insert1273 = or disjoint i64 %output_reg.sroa.72.42.insert.insert, %output_reg.sroa.72.44.insert.shift, !dbg !182
  %out.sroa.122.92.vec.extract = extractelement <4 x float> %238, i64 3, !dbg !177
  %264 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.92.vec.extract), !dbg !178
  %output_reg.sroa.72.46.insert.ext = zext i16 %264 to i64, !dbg !182
  %output_reg.sroa.72.46.insert.shift = shl nuw i64 %output_reg.sroa.72.46.insert.ext, 48, !dbg !182
  %output_reg.sroa.72.46.insert.insert = or disjoint i64 %output_reg.sroa.72.44.insert.insert1273, %output_reg.sroa.72.46.insert.shift, !dbg !182
  %out.sroa.146.96.vec.extract = extractelement <4 x float> %239, i64 0, !dbg !177
  %265 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.96.vec.extract), !dbg !178
  %output_reg.sroa.86.48.insert.ext = zext i16 %265 to i64, !dbg !182
  %out.sroa.146.100.vec.extract = extractelement <4 x float> %239, i64 1, !dbg !177
  %266 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.100.vec.extract), !dbg !178
  %output_reg.sroa.86.50.insert.ext = zext i16 %266 to i64, !dbg !182
  %output_reg.sroa.86.50.insert.shift = shl nuw nsw i64 %output_reg.sroa.86.50.insert.ext, 16, !dbg !182
  %output_reg.sroa.86.50.insert.insert = or disjoint i64 %output_reg.sroa.86.50.insert.shift, %output_reg.sroa.86.48.insert.ext, !dbg !182
  %out.sroa.146.104.vec.extract = extractelement <4 x float> %239, i64 2, !dbg !177
  %267 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.104.vec.extract), !dbg !178
  %output_reg.sroa.86.52.insert.ext = zext i16 %267 to i64, !dbg !182
  %output_reg.sroa.86.52.insert.shift = shl nuw nsw i64 %output_reg.sroa.86.52.insert.ext, 32, !dbg !182
  %output_reg.sroa.86.52.insert.insert1305 = or disjoint i64 %output_reg.sroa.86.50.insert.insert, %output_reg.sroa.86.52.insert.shift, !dbg !182
  %out.sroa.146.108.vec.extract = extractelement <4 x float> %239, i64 3, !dbg !177
  %268 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.108.vec.extract), !dbg !178
  %output_reg.sroa.86.54.insert.ext = zext i16 %268 to i64, !dbg !182
  %output_reg.sroa.86.54.insert.shift = shl nuw i64 %output_reg.sroa.86.54.insert.ext, 48, !dbg !182
  %output_reg.sroa.86.54.insert.insert = or disjoint i64 %output_reg.sroa.86.52.insert.insert1305, %output_reg.sroa.86.54.insert.shift, !dbg !182
  %out.sroa.170.112.vec.extract = extractelement <4 x float> %240, i64 0, !dbg !177
  %269 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.112.vec.extract), !dbg !178
  %output_reg.sroa.100.56.insert.ext = zext i16 %269 to i64, !dbg !182
  %out.sroa.170.116.vec.extract = extractelement <4 x float> %240, i64 1, !dbg !177
  %270 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.116.vec.extract), !dbg !178
  %output_reg.sroa.100.58.insert.ext = zext i16 %270 to i64, !dbg !182
  %output_reg.sroa.100.58.insert.shift = shl nuw nsw i64 %output_reg.sroa.100.58.insert.ext, 16, !dbg !182
  %output_reg.sroa.100.58.insert.insert = or disjoint i64 %output_reg.sroa.100.58.insert.shift, %output_reg.sroa.100.56.insert.ext, !dbg !182
  %out.sroa.170.120.vec.extract = extractelement <4 x float> %240, i64 2, !dbg !177
  %271 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.120.vec.extract), !dbg !178
  %output_reg.sroa.100.60.insert.ext = zext i16 %271 to i64, !dbg !182
  %output_reg.sroa.100.60.insert.shift = shl nuw nsw i64 %output_reg.sroa.100.60.insert.ext, 32, !dbg !182
  %output_reg.sroa.100.60.insert.insert1337 = or disjoint i64 %output_reg.sroa.100.58.insert.insert, %output_reg.sroa.100.60.insert.shift, !dbg !182
  %out.sroa.170.124.vec.extract = extractelement <4 x float> %240, i64 3, !dbg !177
  %272 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.124.vec.extract), !dbg !178
  %output_reg.sroa.100.62.insert.ext = zext i16 %272 to i64, !dbg !182
  %output_reg.sroa.100.62.insert.shift = shl nuw i64 %output_reg.sroa.100.62.insert.ext, 48, !dbg !182
  %output_reg.sroa.100.62.insert.insert = or disjoint i64 %output_reg.sroa.100.60.insert.insert1337, %output_reg.sroa.100.62.insert.shift, !dbg !182
  br label %if.end486, !dbg !183

if.end486:                                        ; preds = %if.then370, %for.cond385.preheader
  %output_reg.sroa.100.0 = phi i64 [ %output_reg.sroa.100.62.insert.insert, %for.cond385.preheader ], [ 0, %if.then370 ], !dbg !66
  %output_reg.sroa.86.0 = phi i64 [ %output_reg.sroa.86.54.insert.insert, %for.cond385.preheader ], [ 0, %if.then370 ], !dbg !66
  %output_reg.sroa.72.0 = phi i64 [ %output_reg.sroa.72.46.insert.insert, %for.cond385.preheader ], [ 0, %if.then370 ], !dbg !66
  %output_reg.sroa.58.0 = phi i64 [ %output_reg.sroa.58.38.insert.insert, %for.cond385.preheader ], [ 0, %if.then370 ], !dbg !66
  %output_reg.sroa.44.0 = phi i64 [ %output_reg.sroa.44.30.insert.insert, %for.cond385.preheader ], [ 0, %if.then370 ], !dbg !66
  %output_reg.sroa.30.0 = phi i64 [ %output_reg.sroa.30.22.insert.insert, %for.cond385.preheader ], [ 0, %if.then370 ], !dbg !66
  %output_reg.sroa.16.0 = phi i64 [ %output_reg.sroa.16.14.insert.insert, %for.cond385.preheader ], [ 0, %if.then370 ], !dbg !66
  %output_reg.sroa.0.0 = phi i64 [ %output_reg.sroa.0.6.insert.insert, %for.cond385.preheader ], [ 0, %if.then370 ], !dbg !66
  fence syncscope("warp") release, !dbg !183
  tail call void @llvm.mxc.barrier.warp(), !dbg !186
  fence syncscope("warp") acquire, !dbg !187
  %xor504 = xor i32 %shr137, %and163, !dbg !188
  %mul505 = shl nuw nsw i32 %xor504, 3, !dbg !189
  %add506 = add nuw nsw i32 %mul505, %mul157, !dbg !190
  %add511 = or disjoint i32 %add506, %mul510, !dbg !191
  %add.ptr513 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511, !dbg !192
  store i64 %output_reg.sroa.0.0, ptr addrspace(3) %add.ptr513, align 8, !dbg !193
  %add501.1 = add nuw nsw i32 %shr137, 2, !dbg !194
  %xor504.1 = xor i32 %add501.1, %and163, !dbg !188
  %mul505.1 = shl nuw nsw i32 %xor504.1, 3, !dbg !189
  %add506.1 = add nuw nsw i32 %mul505.1, %mul157, !dbg !190
  %add511.1 = or disjoint i32 %add506.1, %mul510, !dbg !191
  %add.ptr513.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511.1, !dbg !192
  store i64 %output_reg.sroa.16.0, ptr addrspace(3) %add.ptr513.1, align 8, !dbg !193
  %add501.2 = add nuw nsw i32 %shr137, 4, !dbg !194
  %xor504.2 = xor i32 %add501.2, %and163, !dbg !188
  %mul505.2 = shl nuw nsw i32 %xor504.2, 3, !dbg !189
  %add506.2 = add nuw nsw i32 %mul505.2, %mul157, !dbg !190
  %add511.2 = or disjoint i32 %add506.2, %mul510, !dbg !191
  %add.ptr513.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511.2, !dbg !192
  store i64 %output_reg.sroa.30.0, ptr addrspace(3) %add.ptr513.2, align 8, !dbg !193
  %add501.3 = add nuw nsw i32 %shr137, 6, !dbg !194
  %xor504.3 = xor i32 %add501.3, %and163, !dbg !188
  %mul505.3 = shl nuw nsw i32 %xor504.3, 3, !dbg !189
  %add506.3 = add nuw nsw i32 %mul505.3, %mul157, !dbg !190
  %add511.3 = or disjoint i32 %add506.3, %mul510, !dbg !191
  %add.ptr513.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511.3, !dbg !192
  store i64 %output_reg.sroa.44.0, ptr addrspace(3) %add.ptr513.3, align 8, !dbg !193
  %add501.4 = add nuw nsw i32 %shr137, 8, !dbg !194
  %xor504.4 = xor i32 %add501.4, %and163, !dbg !188
  %mul505.4 = shl nuw nsw i32 %xor504.4, 3, !dbg !189
  %add506.4 = add nuw nsw i32 %mul505.4, %mul157, !dbg !190
  %add511.4 = or disjoint i32 %add506.4, %mul510, !dbg !191
  %add.ptr513.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511.4, !dbg !192
  store i64 %output_reg.sroa.58.0, ptr addrspace(3) %add.ptr513.4, align 8, !dbg !193
  %add501.5 = add nuw nsw i32 %shr137, 10, !dbg !194
  %xor504.5 = xor i32 %add501.5, %and163, !dbg !188
  %mul505.5 = shl nuw nsw i32 %xor504.5, 3, !dbg !189
  %add506.5 = add nuw nsw i32 %mul505.5, %mul157, !dbg !190
  %add511.5 = or disjoint i32 %add506.5, %mul510, !dbg !191
  %add.ptr513.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511.5, !dbg !192
  store i64 %output_reg.sroa.72.0, ptr addrspace(3) %add.ptr513.5, align 8, !dbg !193
  %add501.6 = add nuw nsw i32 %shr137, 12, !dbg !194
  %xor504.6 = xor i32 %add501.6, %and163, !dbg !188
  %mul505.6 = shl nuw nsw i32 %xor504.6, 3, !dbg !189
  %add506.6 = add nuw nsw i32 %mul505.6, %mul157, !dbg !190
  %add511.6 = or disjoint i32 %add506.6, %mul510, !dbg !191
  %add.ptr513.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511.6, !dbg !192
  store i64 %output_reg.sroa.86.0, ptr addrspace(3) %add.ptr513.6, align 8, !dbg !193
  %add501.7 = add nuw nsw i32 %shr137, 14, !dbg !194
  %xor504.7 = xor i32 %add501.7, %and163, !dbg !188
  %mul505.7 = shl nuw nsw i32 %xor504.7, 3, !dbg !189
  %add506.7 = add nuw nsw i32 %mul505.7, %mul157, !dbg !190
  %add511.7 = or disjoint i32 %add506.7, %mul510, !dbg !191
  %add.ptr513.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511.7, !dbg !192
  store i64 %output_reg.sroa.100.0, ptr addrspace(3) %add.ptr513.7, align 8, !dbg !193
  fence syncscope("warp") release, !dbg !195
  tail call void @llvm.mxc.barrier.warp(), !dbg !198
  fence syncscope("warp") acquire, !dbg !199
  %cmp525 = icmp slt i32 %6, 1024
  br i1 %cmp525, label %for.body520.us.preheader, label %for.cond.cleanup519

for.body520.us.preheader:                         ; preds = %if.end486
  %mul554 = shl nuw nsw i32 %6, 11
  %add557 = add nuw nsw i32 %add555, %mul554
  %273 = zext nneg i32 %add557 to i64, !dbg !200
  %xor546.us = xor i32 %shr160, %and163, !dbg !201
  %add.ptr550.idx.us = shl nuw nsw i32 %xor546.us, 4, !dbg !202
  %add.ptr550.us = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 %add.ptr550.idx.us, !dbg !202
  %add.ptr562.us = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %273, !dbg !203
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr562.us, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr550.us, i64 16, i1 false), !dbg !204, !tbaa.struct !205, !call_argsrelate !206
  %274 = add nuw nsw i32 %shr160, 4, !dbg !207
  %xor546.us.1 = xor i32 %274, %and163, !dbg !201
  %gep781.us.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 1024, !dbg !202
  %add.ptr550.idx.us.1 = shl nuw nsw i32 %xor546.us.1, 4, !dbg !202
  %add.ptr550.us.1 = getelementptr inbounds i8, ptr addrspace(3) %gep781.us.1, i32 %add.ptr550.idx.us.1, !dbg !202
  %275 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %273, !dbg !203
  %add.ptr562.us.1 = getelementptr inbounds i8, ptr addrspace(1) %275, i64 1024, !dbg !203
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr562.us.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr550.us.1, i64 16, i1 false), !dbg !204, !tbaa.struct !205, !call_argsrelate !206
  %276 = add nuw nsw i32 %shr160, 8, !dbg !207
  %xor546.us.2 = xor i32 %276, %and163, !dbg !201
  %gep781.us.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 2048, !dbg !202
  %add.ptr550.idx.us.2 = shl nuw nsw i32 %xor546.us.2, 4, !dbg !202
  %add.ptr550.us.2 = getelementptr inbounds i8, ptr addrspace(3) %gep781.us.2, i32 %add.ptr550.idx.us.2, !dbg !202
  %277 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %273, !dbg !203
  %add.ptr562.us.2 = getelementptr inbounds i8, ptr addrspace(1) %277, i64 2048, !dbg !203
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr562.us.2, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr550.us.2, i64 16, i1 false), !dbg !204, !tbaa.struct !205, !call_argsrelate !206
  %278 = add nuw nsw i32 %shr160, 12, !dbg !207
  %xor546.us.3 = xor i32 %278, %and163, !dbg !201
  %gep781.us.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 3072, !dbg !202
  %add.ptr550.idx.us.3 = shl nuw nsw i32 %xor546.us.3, 4, !dbg !202
  %add.ptr550.us.3 = getelementptr inbounds i8, ptr addrspace(3) %gep781.us.3, i32 %add.ptr550.idx.us.3, !dbg !202
  %279 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %273, !dbg !203
  %add.ptr562.us.3 = getelementptr inbounds i8, ptr addrspace(1) %279, i64 3072, !dbg !203
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr562.us.3, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr550.us.3, i64 16, i1 false), !dbg !204, !tbaa.struct !205, !call_argsrelate !206
  br label %for.cond.cleanup519, !dbg !208

for.cond.cleanup519:                              ; preds = %if.end486, %for.body520.us.preheader
  fence syncscope("warp") release, !dbg !208
  tail call void @llvm.mxc.barrier.warp(), !dbg !211
  fence syncscope("warp") acquire, !dbg !212
  br label %if.end567, !dbg !213

if.end567:                                        ; preds = %for.cond.cleanup519, %if.end357.1
  br i1 %cmp32.1, label %if.then370.1, label %if.end571, !dbg !174

if.then370.1:                                     ; preds = %if.end567
  %cmp380.1 = icmp ule i32 %mul88, %7
  %or.cond786.1 = select i1 %cmp87, i1 %cmp380.1, i1 false, !dbg !175
  br i1 %or.cond786.1, label %for.cond385.preheader.1, label %if.end486.1, !dbg !175

for.cond385.preheader.1:                          ; preds = %if.then370.1
  %280 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.3, <4 x half> %215, <4 x float> zeroinitializer), !dbg !176
  %281 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.6.3, <4 x half> %215, <4 x float> zeroinitializer), !dbg !176
  %282 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.8.3, <4 x half> %215, <4 x float> zeroinitializer), !dbg !176
  %283 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.12.3, <4 x half> %215, <4 x float> zeroinitializer), !dbg !176
  %284 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.3, <4 x half> %215, <4 x float> zeroinitializer), !dbg !176
  %285 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.18.3, <4 x half> %215, <4 x float> zeroinitializer), !dbg !176
  %286 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.20.3, <4 x half> %215, <4 x float> zeroinitializer), !dbg !176
  %287 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.24.3, <4 x half> %215, <4 x float> zeroinitializer), !dbg !176
  %288 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.26.3, <4 x half> %214, <4 x float> %280), !dbg !176
  %289 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.30.3, <4 x half> %214, <4 x float> %281), !dbg !176
  %290 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.32.3, <4 x half> %214, <4 x float> %282), !dbg !176
  %291 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.36.3, <4 x half> %214, <4 x float> %283), !dbg !176
  %292 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.38.3, <4 x half> %214, <4 x float> %284), !dbg !176
  %293 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.42.3, <4 x half> %214, <4 x float> %285), !dbg !176
  %294 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.44.3, <4 x half> %214, <4 x float> %286), !dbg !176
  %295 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.48.3, <4 x half> %214, <4 x float> %287), !dbg !176
  %out.sroa.0.0.vec.extract908 = extractelement <4 x float> %288, i64 0, !dbg !177
  %296 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract908), !dbg !178
  %output_reg.sroa.0.0.insert.ext1100 = zext i16 %296 to i64, !dbg !182
  %out.sroa.0.4.vec.extract913 = extractelement <4 x float> %288, i64 1, !dbg !177
  %297 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract913), !dbg !178
  %output_reg.sroa.0.2.insert.ext1104 = zext i16 %297 to i64, !dbg !182
  %output_reg.sroa.0.2.insert.shift1105 = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext1104, 16, !dbg !182
  %output_reg.sroa.0.2.insert.insert1107 = or disjoint i64 %output_reg.sroa.0.2.insert.shift1105, %output_reg.sroa.0.0.insert.ext1100, !dbg !182
  %out.sroa.0.8.vec.extract918 = extractelement <4 x float> %288, i64 2, !dbg !177
  %298 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract918), !dbg !178
  %output_reg.sroa.0.4.insert.ext1115 = zext i16 %298 to i64, !dbg !182
  %output_reg.sroa.0.4.insert.shift1116 = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext1115, 32, !dbg !182
  %output_reg.sroa.0.4.insert.insert1118 = or disjoint i64 %output_reg.sroa.0.2.insert.insert1107, %output_reg.sroa.0.4.insert.shift1116, !dbg !182
  %out.sroa.0.12.vec.extract923 = extractelement <4 x float> %288, i64 3, !dbg !177
  %299 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract923), !dbg !178
  %output_reg.sroa.0.6.insert.ext1120 = zext i16 %299 to i64, !dbg !182
  %output_reg.sroa.0.6.insert.shift1121 = shl nuw i64 %output_reg.sroa.0.6.insert.ext1120, 48, !dbg !182
  %output_reg.sroa.0.6.insert.insert1123 = or disjoint i64 %output_reg.sroa.0.4.insert.insert1118, %output_reg.sroa.0.6.insert.shift1121, !dbg !182
  %out.sroa.26.16.vec.extract932 = extractelement <4 x float> %289, i64 0, !dbg !177
  %300 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.16.vec.extract932), !dbg !178
  %output_reg.sroa.16.8.insert.ext1132 = zext i16 %300 to i64, !dbg !182
  %out.sroa.26.20.vec.extract937 = extractelement <4 x float> %289, i64 1, !dbg !177
  %301 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.20.vec.extract937), !dbg !178
  %output_reg.sroa.16.10.insert.ext1136 = zext i16 %301 to i64, !dbg !182
  %output_reg.sroa.16.10.insert.shift1137 = shl nuw nsw i64 %output_reg.sroa.16.10.insert.ext1136, 16, !dbg !182
  %output_reg.sroa.16.10.insert.insert1139 = or disjoint i64 %output_reg.sroa.16.10.insert.shift1137, %output_reg.sroa.16.8.insert.ext1132, !dbg !182
  %out.sroa.26.24.vec.extract942 = extractelement <4 x float> %289, i64 2, !dbg !177
  %302 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.24.vec.extract942), !dbg !178
  %output_reg.sroa.16.12.insert.ext1147 = zext i16 %302 to i64, !dbg !182
  %output_reg.sroa.16.12.insert.shift1148 = shl nuw nsw i64 %output_reg.sroa.16.12.insert.ext1147, 32, !dbg !182
  %output_reg.sroa.16.12.insert.insert1150 = or disjoint i64 %output_reg.sroa.16.10.insert.insert1139, %output_reg.sroa.16.12.insert.shift1148, !dbg !182
  %out.sroa.26.28.vec.extract947 = extractelement <4 x float> %289, i64 3, !dbg !177
  %303 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.28.vec.extract947), !dbg !178
  %output_reg.sroa.16.14.insert.ext1152 = zext i16 %303 to i64, !dbg !182
  %output_reg.sroa.16.14.insert.shift1153 = shl nuw i64 %output_reg.sroa.16.14.insert.ext1152, 48, !dbg !182
  %output_reg.sroa.16.14.insert.insert1155 = or disjoint i64 %output_reg.sroa.16.12.insert.insert1150, %output_reg.sroa.16.14.insert.shift1153, !dbg !182
  %out.sroa.50.32.vec.extract956 = extractelement <4 x float> %290, i64 0, !dbg !177
  %304 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.32.vec.extract956), !dbg !178
  %output_reg.sroa.30.16.insert.ext1164 = zext i16 %304 to i64, !dbg !182
  %out.sroa.50.36.vec.extract961 = extractelement <4 x float> %290, i64 1, !dbg !177
  %305 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.36.vec.extract961), !dbg !178
  %output_reg.sroa.30.18.insert.ext1168 = zext i16 %305 to i64, !dbg !182
  %output_reg.sroa.30.18.insert.shift1169 = shl nuw nsw i64 %output_reg.sroa.30.18.insert.ext1168, 16, !dbg !182
  %output_reg.sroa.30.18.insert.insert1171 = or disjoint i64 %output_reg.sroa.30.18.insert.shift1169, %output_reg.sroa.30.16.insert.ext1164, !dbg !182
  %out.sroa.50.40.vec.extract966 = extractelement <4 x float> %290, i64 2, !dbg !177
  %306 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.40.vec.extract966), !dbg !178
  %output_reg.sroa.30.20.insert.ext1179 = zext i16 %306 to i64, !dbg !182
  %output_reg.sroa.30.20.insert.shift1180 = shl nuw nsw i64 %output_reg.sroa.30.20.insert.ext1179, 32, !dbg !182
  %output_reg.sroa.30.20.insert.insert1182 = or disjoint i64 %output_reg.sroa.30.18.insert.insert1171, %output_reg.sroa.30.20.insert.shift1180, !dbg !182
  %out.sroa.50.44.vec.extract971 = extractelement <4 x float> %290, i64 3, !dbg !177
  %307 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.44.vec.extract971), !dbg !178
  %output_reg.sroa.30.22.insert.ext1184 = zext i16 %307 to i64, !dbg !182
  %output_reg.sroa.30.22.insert.shift1185 = shl nuw i64 %output_reg.sroa.30.22.insert.ext1184, 48, !dbg !182
  %output_reg.sroa.30.22.insert.insert1187 = or disjoint i64 %output_reg.sroa.30.20.insert.insert1182, %output_reg.sroa.30.22.insert.shift1185, !dbg !182
  %out.sroa.74.48.vec.extract980 = extractelement <4 x float> %291, i64 0, !dbg !177
  %308 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.48.vec.extract980), !dbg !178
  %output_reg.sroa.44.24.insert.ext1196 = zext i16 %308 to i64, !dbg !182
  %out.sroa.74.52.vec.extract985 = extractelement <4 x float> %291, i64 1, !dbg !177
  %309 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.52.vec.extract985), !dbg !178
  %output_reg.sroa.44.26.insert.ext1200 = zext i16 %309 to i64, !dbg !182
  %output_reg.sroa.44.26.insert.shift1201 = shl nuw nsw i64 %output_reg.sroa.44.26.insert.ext1200, 16, !dbg !182
  %output_reg.sroa.44.26.insert.insert1203 = or disjoint i64 %output_reg.sroa.44.26.insert.shift1201, %output_reg.sroa.44.24.insert.ext1196, !dbg !182
  %out.sroa.74.56.vec.extract990 = extractelement <4 x float> %291, i64 2, !dbg !177
  %310 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.56.vec.extract990), !dbg !178
  %output_reg.sroa.44.28.insert.ext1211 = zext i16 %310 to i64, !dbg !182
  %output_reg.sroa.44.28.insert.shift1212 = shl nuw nsw i64 %output_reg.sroa.44.28.insert.ext1211, 32, !dbg !182
  %output_reg.sroa.44.28.insert.insert1214 = or disjoint i64 %output_reg.sroa.44.26.insert.insert1203, %output_reg.sroa.44.28.insert.shift1212, !dbg !182
  %out.sroa.74.60.vec.extract995 = extractelement <4 x float> %291, i64 3, !dbg !177
  %311 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.60.vec.extract995), !dbg !178
  %output_reg.sroa.44.30.insert.ext1216 = zext i16 %311 to i64, !dbg !182
  %output_reg.sroa.44.30.insert.shift1217 = shl nuw i64 %output_reg.sroa.44.30.insert.ext1216, 48, !dbg !182
  %output_reg.sroa.44.30.insert.insert1219 = or disjoint i64 %output_reg.sroa.44.28.insert.insert1214, %output_reg.sroa.44.30.insert.shift1217, !dbg !182
  %out.sroa.98.64.vec.extract1004 = extractelement <4 x float> %292, i64 0, !dbg !177
  %312 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.64.vec.extract1004), !dbg !178
  %output_reg.sroa.58.32.insert.ext1228 = zext i16 %312 to i64, !dbg !182
  %out.sroa.98.68.vec.extract1009 = extractelement <4 x float> %292, i64 1, !dbg !177
  %313 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.68.vec.extract1009), !dbg !178
  %output_reg.sroa.58.34.insert.ext1232 = zext i16 %313 to i64, !dbg !182
  %output_reg.sroa.58.34.insert.shift1233 = shl nuw nsw i64 %output_reg.sroa.58.34.insert.ext1232, 16, !dbg !182
  %output_reg.sroa.58.34.insert.insert1235 = or disjoint i64 %output_reg.sroa.58.34.insert.shift1233, %output_reg.sroa.58.32.insert.ext1228, !dbg !182
  %out.sroa.98.72.vec.extract1014 = extractelement <4 x float> %292, i64 2, !dbg !177
  %314 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.72.vec.extract1014), !dbg !178
  %output_reg.sroa.58.36.insert.ext1243 = zext i16 %314 to i64, !dbg !182
  %output_reg.sroa.58.36.insert.shift1244 = shl nuw nsw i64 %output_reg.sroa.58.36.insert.ext1243, 32, !dbg !182
  %output_reg.sroa.58.36.insert.insert1246 = or disjoint i64 %output_reg.sroa.58.34.insert.insert1235, %output_reg.sroa.58.36.insert.shift1244, !dbg !182
  %out.sroa.98.76.vec.extract1019 = extractelement <4 x float> %292, i64 3, !dbg !177
  %315 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.98.76.vec.extract1019), !dbg !178
  %output_reg.sroa.58.38.insert.ext1248 = zext i16 %315 to i64, !dbg !182
  %output_reg.sroa.58.38.insert.shift1249 = shl nuw i64 %output_reg.sroa.58.38.insert.ext1248, 48, !dbg !182
  %output_reg.sroa.58.38.insert.insert1251 = or disjoint i64 %output_reg.sroa.58.36.insert.insert1246, %output_reg.sroa.58.38.insert.shift1249, !dbg !182
  %out.sroa.122.80.vec.extract1028 = extractelement <4 x float> %293, i64 0, !dbg !177
  %316 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.80.vec.extract1028), !dbg !178
  %output_reg.sroa.72.40.insert.ext1260 = zext i16 %316 to i64, !dbg !182
  %out.sroa.122.84.vec.extract1033 = extractelement <4 x float> %293, i64 1, !dbg !177
  %317 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.84.vec.extract1033), !dbg !178
  %output_reg.sroa.72.42.insert.ext1264 = zext i16 %317 to i64, !dbg !182
  %output_reg.sroa.72.42.insert.shift1265 = shl nuw nsw i64 %output_reg.sroa.72.42.insert.ext1264, 16, !dbg !182
  %output_reg.sroa.72.42.insert.insert1267 = or disjoint i64 %output_reg.sroa.72.42.insert.shift1265, %output_reg.sroa.72.40.insert.ext1260, !dbg !182
  %out.sroa.122.88.vec.extract1038 = extractelement <4 x float> %293, i64 2, !dbg !177
  %318 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.88.vec.extract1038), !dbg !178
  %output_reg.sroa.72.44.insert.ext1275 = zext i16 %318 to i64, !dbg !182
  %output_reg.sroa.72.44.insert.shift1276 = shl nuw nsw i64 %output_reg.sroa.72.44.insert.ext1275, 32, !dbg !182
  %output_reg.sroa.72.44.insert.insert1278 = or disjoint i64 %output_reg.sroa.72.42.insert.insert1267, %output_reg.sroa.72.44.insert.shift1276, !dbg !182
  %out.sroa.122.92.vec.extract1043 = extractelement <4 x float> %293, i64 3, !dbg !177
  %319 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.122.92.vec.extract1043), !dbg !178
  %output_reg.sroa.72.46.insert.ext1280 = zext i16 %319 to i64, !dbg !182
  %output_reg.sroa.72.46.insert.shift1281 = shl nuw i64 %output_reg.sroa.72.46.insert.ext1280, 48, !dbg !182
  %output_reg.sroa.72.46.insert.insert1283 = or disjoint i64 %output_reg.sroa.72.44.insert.insert1278, %output_reg.sroa.72.46.insert.shift1281, !dbg !182
  %out.sroa.146.96.vec.extract1052 = extractelement <4 x float> %294, i64 0, !dbg !177
  %320 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.96.vec.extract1052), !dbg !178
  %output_reg.sroa.86.48.insert.ext1292 = zext i16 %320 to i64, !dbg !182
  %out.sroa.146.100.vec.extract1057 = extractelement <4 x float> %294, i64 1, !dbg !177
  %321 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.100.vec.extract1057), !dbg !178
  %output_reg.sroa.86.50.insert.ext1296 = zext i16 %321 to i64, !dbg !182
  %output_reg.sroa.86.50.insert.shift1297 = shl nuw nsw i64 %output_reg.sroa.86.50.insert.ext1296, 16, !dbg !182
  %output_reg.sroa.86.50.insert.insert1299 = or disjoint i64 %output_reg.sroa.86.50.insert.shift1297, %output_reg.sroa.86.48.insert.ext1292, !dbg !182
  %out.sroa.146.104.vec.extract1062 = extractelement <4 x float> %294, i64 2, !dbg !177
  %322 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.104.vec.extract1062), !dbg !178
  %output_reg.sroa.86.52.insert.ext1307 = zext i16 %322 to i64, !dbg !182
  %output_reg.sroa.86.52.insert.shift1308 = shl nuw nsw i64 %output_reg.sroa.86.52.insert.ext1307, 32, !dbg !182
  %output_reg.sroa.86.52.insert.insert1310 = or disjoint i64 %output_reg.sroa.86.50.insert.insert1299, %output_reg.sroa.86.52.insert.shift1308, !dbg !182
  %out.sroa.146.108.vec.extract1067 = extractelement <4 x float> %294, i64 3, !dbg !177
  %323 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.146.108.vec.extract1067), !dbg !178
  %output_reg.sroa.86.54.insert.ext1312 = zext i16 %323 to i64, !dbg !182
  %output_reg.sroa.86.54.insert.shift1313 = shl nuw i64 %output_reg.sroa.86.54.insert.ext1312, 48, !dbg !182
  %output_reg.sroa.86.54.insert.insert1315 = or disjoint i64 %output_reg.sroa.86.52.insert.insert1310, %output_reg.sroa.86.54.insert.shift1313, !dbg !182
  %out.sroa.170.112.vec.extract1076 = extractelement <4 x float> %295, i64 0, !dbg !177
  %324 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.112.vec.extract1076), !dbg !178
  %output_reg.sroa.100.56.insert.ext1324 = zext i16 %324 to i64, !dbg !182
  %out.sroa.170.116.vec.extract1081 = extractelement <4 x float> %295, i64 1, !dbg !177
  %325 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.116.vec.extract1081), !dbg !178
  %output_reg.sroa.100.58.insert.ext1328 = zext i16 %325 to i64, !dbg !182
  %output_reg.sroa.100.58.insert.shift1329 = shl nuw nsw i64 %output_reg.sroa.100.58.insert.ext1328, 16, !dbg !182
  %output_reg.sroa.100.58.insert.insert1331 = or disjoint i64 %output_reg.sroa.100.58.insert.shift1329, %output_reg.sroa.100.56.insert.ext1324, !dbg !182
  %out.sroa.170.120.vec.extract1086 = extractelement <4 x float> %295, i64 2, !dbg !177
  %326 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.120.vec.extract1086), !dbg !178
  %output_reg.sroa.100.60.insert.ext1339 = zext i16 %326 to i64, !dbg !182
  %output_reg.sroa.100.60.insert.shift1340 = shl nuw nsw i64 %output_reg.sroa.100.60.insert.ext1339, 32, !dbg !182
  %output_reg.sroa.100.60.insert.insert1342 = or disjoint i64 %output_reg.sroa.100.58.insert.insert1331, %output_reg.sroa.100.60.insert.shift1340, !dbg !182
  %out.sroa.170.124.vec.extract1091 = extractelement <4 x float> %295, i64 3, !dbg !177
  %327 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.170.124.vec.extract1091), !dbg !178
  %output_reg.sroa.100.62.insert.ext1344 = zext i16 %327 to i64, !dbg !182
  %output_reg.sroa.100.62.insert.shift1345 = shl nuw i64 %output_reg.sroa.100.62.insert.ext1344, 48, !dbg !182
  %output_reg.sroa.100.62.insert.insert1347 = or disjoint i64 %output_reg.sroa.100.60.insert.insert1342, %output_reg.sroa.100.62.insert.shift1345, !dbg !182
  br label %if.end486.1, !dbg !183

if.end486.1:                                      ; preds = %if.then370.1, %for.cond385.preheader.1
  %output_reg.sroa.100.2 = phi i64 [ %output_reg.sroa.100.62.insert.insert1347, %for.cond385.preheader.1 ], [ 0, %if.then370.1 ], !dbg !66
  %output_reg.sroa.86.2 = phi i64 [ %output_reg.sroa.86.54.insert.insert1315, %for.cond385.preheader.1 ], [ 0, %if.then370.1 ], !dbg !66
  %output_reg.sroa.72.2 = phi i64 [ %output_reg.sroa.72.46.insert.insert1283, %for.cond385.preheader.1 ], [ 0, %if.then370.1 ], !dbg !66
  %output_reg.sroa.58.2 = phi i64 [ %output_reg.sroa.58.38.insert.insert1251, %for.cond385.preheader.1 ], [ 0, %if.then370.1 ], !dbg !66
  %output_reg.sroa.44.2 = phi i64 [ %output_reg.sroa.44.30.insert.insert1219, %for.cond385.preheader.1 ], [ 0, %if.then370.1 ], !dbg !66
  %output_reg.sroa.30.2 = phi i64 [ %output_reg.sroa.30.22.insert.insert1187, %for.cond385.preheader.1 ], [ 0, %if.then370.1 ], !dbg !66
  %output_reg.sroa.16.2 = phi i64 [ %output_reg.sroa.16.14.insert.insert1155, %for.cond385.preheader.1 ], [ 0, %if.then370.1 ], !dbg !66
  %output_reg.sroa.0.2 = phi i64 [ %output_reg.sroa.0.6.insert.insert1123, %for.cond385.preheader.1 ], [ 0, %if.then370.1 ], !dbg !66
  fence syncscope("warp") release, !dbg !183
  tail call void @llvm.mxc.barrier.warp(), !dbg !186
  fence syncscope("warp") acquire, !dbg !187
  %xor504.1891 = xor i32 %shr137, %and163, !dbg !188
  %mul505.1892 = shl nuw nsw i32 %xor504.1891, 3, !dbg !189
  %add506.1893 = add nuw nsw i32 %mul505.1892, %mul157, !dbg !190
  %add511.1894 = or disjoint i32 %add506.1893, %mul510, !dbg !191
  %add.ptr513.1895 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511.1894, !dbg !192
  store i64 %output_reg.sroa.0.2, ptr addrspace(3) %add.ptr513.1895, align 8, !dbg !193
  %add501.1.1 = add nuw nsw i32 %shr137, 2, !dbg !194
  %xor504.1.1 = xor i32 %add501.1.1, %and163, !dbg !188
  %mul505.1.1 = shl nuw nsw i32 %xor504.1.1, 3, !dbg !189
  %add506.1.1 = add nuw nsw i32 %mul505.1.1, %mul157, !dbg !190
  %add511.1.1 = or disjoint i32 %add506.1.1, %mul510, !dbg !191
  %add.ptr513.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511.1.1, !dbg !192
  store i64 %output_reg.sroa.16.2, ptr addrspace(3) %add.ptr513.1.1, align 8, !dbg !193
  %add501.2.1 = add nuw nsw i32 %shr137, 4, !dbg !194
  %xor504.2.1 = xor i32 %add501.2.1, %and163, !dbg !188
  %mul505.2.1 = shl nuw nsw i32 %xor504.2.1, 3, !dbg !189
  %add506.2.1 = add nuw nsw i32 %mul505.2.1, %mul157, !dbg !190
  %add511.2.1 = or disjoint i32 %add506.2.1, %mul510, !dbg !191
  %add.ptr513.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511.2.1, !dbg !192
  store i64 %output_reg.sroa.30.2, ptr addrspace(3) %add.ptr513.2.1, align 8, !dbg !193
  %add501.3.1 = add nuw nsw i32 %shr137, 6, !dbg !194
  %xor504.3.1 = xor i32 %add501.3.1, %and163, !dbg !188
  %mul505.3.1 = shl nuw nsw i32 %xor504.3.1, 3, !dbg !189
  %add506.3.1 = add nuw nsw i32 %mul505.3.1, %mul157, !dbg !190
  %add511.3.1 = or disjoint i32 %add506.3.1, %mul510, !dbg !191
  %add.ptr513.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511.3.1, !dbg !192
  store i64 %output_reg.sroa.44.2, ptr addrspace(3) %add.ptr513.3.1, align 8, !dbg !193
  %add501.4.1 = add nuw nsw i32 %shr137, 8, !dbg !194
  %xor504.4.1 = xor i32 %add501.4.1, %and163, !dbg !188
  %mul505.4.1 = shl nuw nsw i32 %xor504.4.1, 3, !dbg !189
  %add506.4.1 = add nuw nsw i32 %mul505.4.1, %mul157, !dbg !190
  %add511.4.1 = or disjoint i32 %add506.4.1, %mul510, !dbg !191
  %add.ptr513.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511.4.1, !dbg !192
  store i64 %output_reg.sroa.58.2, ptr addrspace(3) %add.ptr513.4.1, align 8, !dbg !193
  %add501.5.1 = add nuw nsw i32 %shr137, 10, !dbg !194
  %xor504.5.1 = xor i32 %add501.5.1, %and163, !dbg !188
  %mul505.5.1 = shl nuw nsw i32 %xor504.5.1, 3, !dbg !189
  %add506.5.1 = add nuw nsw i32 %mul505.5.1, %mul157, !dbg !190
  %add511.5.1 = or disjoint i32 %add506.5.1, %mul510, !dbg !191
  %add.ptr513.5.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511.5.1, !dbg !192
  store i64 %output_reg.sroa.72.2, ptr addrspace(3) %add.ptr513.5.1, align 8, !dbg !193
  %add501.6.1 = add nuw nsw i32 %shr137, 12, !dbg !194
  %xor504.6.1 = xor i32 %add501.6.1, %and163, !dbg !188
  %mul505.6.1 = shl nuw nsw i32 %xor504.6.1, 3, !dbg !189
  %add506.6.1 = add nuw nsw i32 %mul505.6.1, %mul157, !dbg !190
  %add511.6.1 = or disjoint i32 %add506.6.1, %mul510, !dbg !191
  %add.ptr513.6.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511.6.1, !dbg !192
  store i64 %output_reg.sroa.86.2, ptr addrspace(3) %add.ptr513.6.1, align 8, !dbg !193
  %add501.7.1 = add nuw nsw i32 %shr137, 14, !dbg !194
  %xor504.7.1 = xor i32 %add501.7.1, %and163, !dbg !188
  %mul505.7.1 = shl nuw nsw i32 %xor504.7.1, 3, !dbg !189
  %add506.7.1 = add nuw nsw i32 %mul505.7.1, %mul157, !dbg !190
  %add511.7.1 = or disjoint i32 %add506.7.1, %mul510, !dbg !191
  %add.ptr513.7.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add511.7.1, !dbg !192
  store i64 %output_reg.sroa.100.2, ptr addrspace(3) %add.ptr513.7.1, align 8, !dbg !193
  fence syncscope("warp") release, !dbg !195
  tail call void @llvm.mxc.barrier.warp(), !dbg !198
  fence syncscope("warp") acquire, !dbg !199
  %cmp525.1 = icmp slt i32 %7, 1024
  br i1 %cmp525.1, label %for.body520.us.preheader.1, label %for.cond.cleanup519.1

for.body520.us.preheader.1:                       ; preds = %if.end486.1
  %mul554.1 = shl nuw nsw i32 %7, 11
  %add557.1 = add nuw nsw i32 %add555, %mul554.1
  %328 = zext nneg i32 %add557.1 to i64, !dbg !200
  %xor546.us.1896 = xor i32 %shr160, %and163, !dbg !201
  %add.ptr550.idx.us.1897 = shl nuw nsw i32 %xor546.us.1896, 4, !dbg !202
  %add.ptr550.us.1898 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 %add.ptr550.idx.us.1897, !dbg !202
  %add.ptr562.us.1899 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %328, !dbg !203
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr562.us.1899, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr550.us.1898, i64 16, i1 false), !dbg !204, !tbaa.struct !205, !call_argsrelate !206
  %329 = add nuw nsw i32 %shr160, 4, !dbg !207
  %xor546.us.1.1 = xor i32 %329, %and163, !dbg !201
  %gep781.us.1.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 1024, !dbg !202
  %add.ptr550.idx.us.1.1 = shl nuw nsw i32 %xor546.us.1.1, 4, !dbg !202
  %add.ptr550.us.1.1 = getelementptr inbounds i8, ptr addrspace(3) %gep781.us.1.1, i32 %add.ptr550.idx.us.1.1, !dbg !202
  %330 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %328, !dbg !203
  %add.ptr562.us.1.1 = getelementptr inbounds i8, ptr addrspace(1) %330, i64 1024, !dbg !203
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr562.us.1.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr550.us.1.1, i64 16, i1 false), !dbg !204, !tbaa.struct !205, !call_argsrelate !206
  %331 = add nuw nsw i32 %shr160, 8, !dbg !207
  %xor546.us.2.1 = xor i32 %331, %and163, !dbg !201
  %gep781.us.2.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 2048, !dbg !202
  %add.ptr550.idx.us.2.1 = shl nuw nsw i32 %xor546.us.2.1, 4, !dbg !202
  %add.ptr550.us.2.1 = getelementptr inbounds i8, ptr addrspace(3) %gep781.us.2.1, i32 %add.ptr550.idx.us.2.1, !dbg !202
  %332 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %328, !dbg !203
  %add.ptr562.us.2.1 = getelementptr inbounds i8, ptr addrspace(1) %332, i64 2048, !dbg !203
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr562.us.2.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr550.us.2.1, i64 16, i1 false), !dbg !204, !tbaa.struct !205, !call_argsrelate !206
  %narrow = add nuw nsw i32 %shr160, 12, !dbg !207
  %xor546.us.3.1 = xor i32 %narrow, %and163, !dbg !201
  %gep781.us.3.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep780, i32 3072, !dbg !202
  %add.ptr550.idx.us.3.1 = shl nuw nsw i32 %xor546.us.3.1, 4, !dbg !202
  %add.ptr550.us.3.1 = getelementptr inbounds i8, ptr addrspace(3) %gep781.us.3.1, i32 %add.ptr550.idx.us.3.1, !dbg !202
  %333 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %328, !dbg !203
  %add.ptr562.us.3.1 = getelementptr inbounds i8, ptr addrspace(1) %333, i64 3072, !dbg !203
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr562.us.3.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr550.us.3.1, i64 16, i1 false), !dbg !204, !tbaa.struct !205, !call_argsrelate !206
  br label %for.cond.cleanup519.1, !dbg !208

for.cond.cleanup519.1:                            ; preds = %if.end486.1, %for.body520.us.preheader.1
  fence syncscope("warp") release, !dbg !208
  tail call void @llvm.mxc.barrier.warp(), !dbg !211
  fence syncscope("warp") acquire, !dbg !212
  br label %if.end571, !dbg !213

if.end571:                                        ; preds = %if.end567, %for.cond.cleanup519.1, %entry
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
!1 = !DIFile(filename: "/tmp/tmp4z6w3glz/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmp4z6w3glz/tvm_kernels.maca", directory: "")
!42 = !DILocation(line: 77, column: 3, scope: !43, inlinedAt: !45)
!43 = distinct !DISubprogram(name: "__fetch_builtin_x", scope: !44, file: !44, line: 77, type: !7, scopeLine: 77, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!44 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_builtin_vars.h", directory: "")
!45 = distinct !DILocation(line: 23, column: 13, scope: !40)
!46 = !DILocation(line: 78, column: 3, scope: !47, inlinedAt: !48)
!47 = distinct !DISubprogram(name: "__fetch_builtin_y", scope: !44, file: !44, line: 78, type: !7, scopeLine: 78, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!48 = distinct !DILocation(line: 23, column: 43, scope: !40)
!49 = !DILocation(line: 23, column: 55, scope: !40)
!50 = !DILocation(line: 23, column: 27, scope: !40)
!51 = !DILocation(line: 23, column: 25, scope: !40)
!52 = !DILocation(line: 23, column: 7, scope: !40)
!53 = !DILocation(line: 24, column: 75, scope: !40)
!54 = !DILocation(line: 24, column: 54, scope: !40)
!55 = !DILocation(line: 24, column: 17, scope: !40)
!56 = !DILocation(line: 25, column: 23, scope: !40)
!57 = !DILocation(line: 26, column: 24, scope: !40)
!58 = !DILocation(line: 28, column: 10, scope: !40)
!59 = !{i32 0, i32 1024}
!60 = !DILocation(line: 35, column: 13, scope: !40)
!61 = !DILocation(line: 35, column: 11, scope: !40)
!62 = !DILocation(line: 46, column: 15, scope: !40)
!63 = !DILocation(line: 59, column: 37, scope: !40)
!64 = !DILocation(line: 59, column: 23, scope: !40)
!65 = !DILocation(line: 60, column: 11, scope: !40)
!66 = !DILocation(line: 0, scope: !40)
!67 = !DILocation(line: 63, column: 40, scope: !40)
!68 = !DILocation(line: 71, column: 37, scope: !40)
!69 = !DILocation(line: 76, column: 61, scope: !40)
!70 = !DILocation(line: 76, column: 40, scope: !40)
!71 = !DILocation(line: 81, column: 140, scope: !40)
!72 = !DILocation(line: 81, column: 48, scope: !40)
!73 = !DILocation(line: 81, column: 232, scope: !40)
!74 = !DILocation(line: 81, column: 153, scope: !40)
!75 = !DILocation(line: 68, column: 3, scope: !76, inlinedAt: !78)
!76 = distinct !DISubprogram(name: "__barrier_warp", scope: !77, file: !77, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!77 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!78 = distinct !DILocation(line: 192, column: 3, scope: !79, inlinedAt: !80)
!79 = distinct !DISubprogram(name: "__syncwarp", scope: !77, file: !77, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!80 = distinct !DILocation(line: 83, column: 11, scope: !40)
!81 = !DILocation(line: 69, column: 3, scope: !76, inlinedAt: !78)
!82 = !DILocation(line: 70, column: 3, scope: !76, inlinedAt: !78)
!83 = !DILocation(line: 86, column: 157, scope: !40)
!84 = !DILocation(line: 86, column: 75, scope: !40)
!85 = !DILocation(line: 86, column: 38, scope: !40)
!86 = !DILocation(line: 86, column: 128, scope: !40)
!87 = !DILocation(line: 97, column: 120, scope: !40)
!88 = !DILocation(line: 97, column: 17, scope: !40)
!89 = !DILocation(line: 102, column: 25, scope: !40)
!90 = !DILocation(line: 97, column: 72, scope: !40)
!91 = !DILocation(line: 97, column: 107, scope: !40)
!92 = !DILocation(line: 108, column: 37, scope: !40)
!93 = !{i32 1, i32 -1, i32 -1}
!94 = !DILocation(line: 115, column: 33, scope: !40)
!95 = !DILocation(line: 118, column: 61, scope: !40)
!96 = !DILocation(line: 118, column: 40, scope: !40)
!97 = !DILocation(line: 122, column: 11, scope: !40)
!98 = !DILocation(line: 123, column: 38, scope: !40)
!99 = !DILocation(line: 123, column: 50, scope: !40)
!100 = !DILocation(line: 354, column: 10, scope: !101, inlinedAt: !103)
!101 = distinct !DISubprogram(name: "min", scope: !102, file: !102, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!102 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!103 = distinct !DILocation(line: 123, column: 33, scope: !40)
!104 = !DILocation(line: 285, column: 49, scope: !105, inlinedAt: !106)
!105 = distinct !DISubprogram(name: "exp2f", scope: !102, file: !102, line: 285, type: !7, scopeLine: 285, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!106 = distinct !DILocation(line: 123, column: 27, scope: !40)
!107 = !DILocation(line: 128, column: 34, scope: !40)
!108 = !DILocation(line: 1018, column: 9, scope: !109, inlinedAt: !110)
!109 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !77, file: !77, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!110 = distinct !DILocation(line: 396, column: 10, scope: !111, inlinedAt: !113)
!111 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !112, file: !112, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!112 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!113 = distinct !DILocation(line: 129, column: 24, scope: !114, inlinedAt: !116)
!114 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !115, file: !115, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!115 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!116 = distinct !DILocation(line: 101, column: 14, scope: !117, inlinedAt: !118)
!117 = distinct !DISubprogram(name: "run<float>", scope: !115, file: !115, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!118 = distinct !DILocation(line: 130, column: 22, scope: !40)
!119 = !DILocation(line: 171, column: 37, scope: !120, inlinedAt: !121)
!120 = distinct !DISubprogram(name: "__lane_id", scope: !77, file: !77, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!121 = distinct !DILocation(line: 990, column: 14, scope: !122, inlinedAt: !123)
!122 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !77, file: !77, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!123 = distinct !DILocation(line: 1019, column: 11, scope: !109, inlinedAt: !110)
!124 = !DILocation(line: 171, column: 10, scope: !120, inlinedAt: !121)
!125 = !DILocation(line: 991, column: 20, scope: !122, inlinedAt: !123)
!126 = !DILocation(line: 992, column: 36, scope: !122, inlinedAt: !123)
!127 = !DILocation(line: 992, column: 17, scope: !122, inlinedAt: !123)
!128 = !DILocation(line: 992, column: 11, scope: !122, inlinedAt: !123)
!129 = !DILocation(line: 993, column: 43, scope: !122, inlinedAt: !123)
!130 = !DILocation(line: 993, column: 10, scope: !122, inlinedAt: !123)
!131 = !DILocation(line: 1020, column: 14, scope: !109, inlinedAt: !110)
!132 = !DILocation(line: 25, column: 14, scope: !133, inlinedAt: !134)
!133 = distinct !DISubprogram(name: "operator()<float>", scope: !115, file: !115, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!134 = distinct !DILocation(line: 129, column: 11, scope: !114, inlinedAt: !116)
!135 = !DILocation(line: 1018, column: 9, scope: !109, inlinedAt: !136)
!136 = distinct !DILocation(line: 396, column: 10, scope: !111, inlinedAt: !137)
!137 = distinct !DILocation(line: 129, column: 24, scope: !138, inlinedAt: !139)
!138 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !115, file: !115, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!139 = distinct !DILocation(line: 101, column: 14, scope: !140, inlinedAt: !141)
!140 = distinct !DISubprogram(name: "run<float>", scope: !115, file: !115, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!141 = distinct !DILocation(line: 134, column: 14, scope: !114, inlinedAt: !116)
!142 = !DILocation(line: 171, column: 37, scope: !120, inlinedAt: !143)
!143 = distinct !DILocation(line: 990, column: 14, scope: !122, inlinedAt: !144)
!144 = distinct !DILocation(line: 1019, column: 11, scope: !109, inlinedAt: !136)
!145 = !DILocation(line: 171, column: 10, scope: !120, inlinedAt: !143)
!146 = !DILocation(line: 991, column: 20, scope: !122, inlinedAt: !144)
!147 = !DILocation(line: 992, column: 36, scope: !122, inlinedAt: !144)
!148 = !DILocation(line: 992, column: 17, scope: !122, inlinedAt: !144)
!149 = !DILocation(line: 992, column: 11, scope: !122, inlinedAt: !144)
!150 = !DILocation(line: 993, column: 43, scope: !122, inlinedAt: !144)
!151 = !DILocation(line: 993, column: 10, scope: !122, inlinedAt: !144)
!152 = !DILocation(line: 1020, column: 14, scope: !109, inlinedAt: !136)
!153 = !DILocation(line: 25, column: 14, scope: !133, inlinedAt: !154)
!154 = distinct !DILocation(line: 129, column: 11, scope: !138, inlinedAt: !139)
!155 = !DILocation(line: 132, column: 40, scope: !40)
!156 = !DILocation(line: 132, column: 15, scope: !40)
!157 = !DILocation(line: 140, column: 40, scope: !40)
!158 = !DILocation(line: 75, column: 10, scope: !159, inlinedAt: !161)
!159 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !160, file: !160, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!160 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!161 = distinct !DILocation(line: 984, column: 9, scope: !162, inlinedAt: !164)
!162 = distinct !DISubprogram(name: "__float2half", scope: !163, file: !163, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!163 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!164 = distinct !DILocation(line: 133, column: 53, scope: !165, inlinedAt: !166)
!165 = distinct !DISubprogram(name: "__half", scope: !163, file: !163, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!166 = distinct !DILocation(line: 146, column: 81, scope: !40)
!167 = !DILocation(line: 68, column: 3, scope: !76, inlinedAt: !168)
!168 = distinct !DILocation(line: 192, column: 3, scope: !79, inlinedAt: !169)
!169 = distinct !DILocation(line: 149, column: 11, scope: !40)
!170 = !DILocation(line: 69, column: 3, scope: !76, inlinedAt: !168)
!171 = !DILocation(line: 70, column: 3, scope: !76, inlinedAt: !168)
!172 = !DILocation(line: 150, column: 9, scope: !40)
!173 = !DILocation(line: 172, column: 23, scope: !40)
!174 = !DILocation(line: 161, column: 11, scope: !40)
!175 = !DILocation(line: 168, column: 39, scope: !40)
!176 = !DILocation(line: 182, column: 36, scope: !40)
!177 = !DILocation(line: 192, column: 73, scope: !40)
!178 = !DILocation(line: 75, column: 10, scope: !159, inlinedAt: !179)
!179 = distinct !DILocation(line: 984, column: 9, scope: !162, inlinedAt: !180)
!180 = distinct !DILocation(line: 133, column: 53, scope: !165, inlinedAt: !181)
!181 = distinct !DILocation(line: 192, column: 65, scope: !40)
!182 = !DILocation(line: 192, column: 62, scope: !40)
!183 = !DILocation(line: 68, column: 3, scope: !76, inlinedAt: !184)
!184 = distinct !DILocation(line: 192, column: 3, scope: !79, inlinedAt: !185)
!185 = distinct !DILocation(line: 202, column: 9, scope: !40)
!186 = !DILocation(line: 69, column: 3, scope: !76, inlinedAt: !184)
!187 = !DILocation(line: 70, column: 3, scope: !76, inlinedAt: !184)
!188 = !DILocation(line: 205, column: 129, scope: !40)
!189 = !DILocation(line: 205, column: 158, scope: !40)
!190 = !DILocation(line: 205, column: 84, scope: !40)
!191 = !DILocation(line: 205, column: 164, scope: !40)
!192 = !DILocation(line: 205, column: 46, scope: !40)
!193 = !DILocation(line: 205, column: 207, scope: !40)
!194 = !DILocation(line: 205, column: 100, scope: !40)
!195 = !DILocation(line: 68, column: 3, scope: !76, inlinedAt: !196)
!196 = distinct !DILocation(line: 192, column: 3, scope: !79, inlinedAt: !197)
!197 = distinct !DILocation(line: 207, column: 9, scope: !40)
!198 = !DILocation(line: 69, column: 3, scope: !76, inlinedAt: !196)
!199 = !DILocation(line: 70, column: 3, scope: !76, inlinedAt: !196)
!200 = !DILocation(line: 209, column: 9, scope: !40)
!201 = !DILocation(line: 229, column: 261, scope: !40)
!202 = !DILocation(line: 229, column: 177, scope: !40)
!203 = !DILocation(line: 229, column: 30, scope: !40)
!204 = !DILocation(line: 229, column: 140, scope: !40)
!205 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!206 = !{i32 0, i32 -1, i32 -1, i32 -1}
!207 = !DILocation(line: 229, column: 275, scope: !40)
!208 = !DILocation(line: 68, column: 3, scope: !76, inlinedAt: !209)
!209 = distinct !DILocation(line: 192, column: 3, scope: !79, inlinedAt: !210)
!210 = distinct !DILocation(line: 232, column: 9, scope: !40)
!211 = !DILocation(line: 69, column: 3, scope: !76, inlinedAt: !209)
!212 = !DILocation(line: 70, column: 3, scope: !76, inlinedAt: !209)
!213 = !DILocation(line: 233, column: 7, scope: !40)
!214 = !DILocation(line: 236, column: 1, scope: !40)
