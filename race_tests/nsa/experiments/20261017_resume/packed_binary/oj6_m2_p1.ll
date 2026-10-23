; ModuleID = 'experiments/20261017_resume/packed_binary/oj6_m2_p1.bc'
source_filename = "/tmp/tmpenngwf_3/tvm_kernels.maca"
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
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %Indices.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %PackedKV.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce) local_unnamed_addr #3 !dbg !40 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !range !29
  %mul = shl nsw i32 %0, 21
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul10 = shl nsw i32 %1, 11
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %and = shl nuw nsw i32 %2, 7
  %mul14 = and i32 %and, 896
  %3 = shl nuw nsw i32 %2, 2
  %mul20 = and i32 %3, 32
  %4 = lshr i32 %2, 1
  %mul24 = and i32 %4, 504
  %add21 = add nuw nsw i32 %mul, %mul10
  %5 = or disjoint i32 %mul14, %mul20
  %add12 = or disjoint i32 %5, %add21
  %add15 = add nuw nsw i32 %add12, %mul24
  %6 = zext nneg i32 %add15 to i64, !dbg !43
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %6, !dbg !44
  %q_words.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr, align 16, !dbg !45, !tbaa !30
  %q_words.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 4, !dbg !45
  %q_words.sroa.4.0.copyload = load i32, ptr addrspace(4) %q_words.sroa.4.0.add.ptr.sroa_idx, align 4, !dbg !45, !tbaa !30
  %q_words.sroa.5.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !45
  %q_words.sroa.5.0.copyload = load i32, ptr addrspace(4) %q_words.sroa.5.0.add.ptr.sroa_idx, align 8, !dbg !45, !tbaa !30
  %q_words.sroa.6.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 12, !dbg !45
  %q_words.sroa.6.0.copyload = load i32, ptr addrspace(4) %q_words.sroa.6.0.add.ptr.sroa_idx, align 4, !dbg !45, !tbaa !30
  %7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %6, !dbg !44
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %7, i64 2048, !dbg !44
  %q_words.sroa.7.16.copyload = load i32, ptr addrspace(4) %add.ptr.1, align 16, !dbg !45, !tbaa !30
  %q_words.sroa.9.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %7, i64 2052, !dbg !45
  %q_words.sroa.9.16.copyload = load i32, ptr addrspace(4) %q_words.sroa.9.16.add.ptr.1.sroa_idx, align 4, !dbg !45, !tbaa !30
  %q_words.sroa.10.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %7, i64 2056, !dbg !45
  %q_words.sroa.10.16.copyload = load i32, ptr addrspace(4) %q_words.sroa.10.16.add.ptr.1.sroa_idx, align 8, !dbg !45, !tbaa !30
  %q_words.sroa.11.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %7, i64 2060, !dbg !45
  %q_words.sroa.11.16.copyload = load i32, ptr addrspace(4) %q_words.sroa.11.16.add.ptr.1.sroa_idx, align 4, !dbg !45, !tbaa !30
  %8 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %6, !dbg !44
  %add.ptr.1679 = getelementptr inbounds i8, ptr addrspace(4) %8, i64 128, !dbg !44
  %q_words.sroa.12.32.copyload = load i32, ptr addrspace(4) %add.ptr.1679, align 16, !dbg !45, !tbaa !30
  %q_words.sroa.14.32.add.ptr.1679.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %8, i64 132, !dbg !45
  %q_words.sroa.14.32.copyload = load i32, ptr addrspace(4) %q_words.sroa.14.32.add.ptr.1679.sroa_idx, align 4, !dbg !45, !tbaa !30
  %q_words.sroa.15.32.add.ptr.1679.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %8, i64 136, !dbg !45
  %q_words.sroa.15.32.copyload = load i32, ptr addrspace(4) %q_words.sroa.15.32.add.ptr.1679.sroa_idx, align 8, !dbg !45, !tbaa !30
  %q_words.sroa.16.32.add.ptr.1679.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %8, i64 140, !dbg !45
  %q_words.sroa.16.32.copyload = load i32, ptr addrspace(4) %q_words.sroa.16.32.add.ptr.1679.sroa_idx, align 4, !dbg !45, !tbaa !30
  %9 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %6, !dbg !44
  %add.ptr.1.1 = getelementptr inbounds i8, ptr addrspace(4) %9, i64 2176, !dbg !44
  %q_words.sroa.17.48.copyload = load i32, ptr addrspace(4) %add.ptr.1.1, align 16, !dbg !45, !tbaa !30
  %q_words.sroa.19.48.add.ptr.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %9, i64 2180, !dbg !45
  %q_words.sroa.19.48.copyload = load i32, ptr addrspace(4) %q_words.sroa.19.48.add.ptr.1.1.sroa_idx, align 4, !dbg !45, !tbaa !30
  %q_words.sroa.20.48.add.ptr.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %9, i64 2184, !dbg !45
  %q_words.sroa.20.48.copyload = load i32, ptr addrspace(4) %q_words.sroa.20.48.add.ptr.1.1.sroa_idx, align 8, !dbg !45, !tbaa !30
  %q_words.sroa.21.48.add.ptr.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %9, i64 2188, !dbg !45
  %q_words.sroa.21.48.copyload = load i32, ptr addrspace(4) %q_words.sroa.21.48.add.ptr.1.1.sroa_idx, align 4, !dbg !45, !tbaa !30
  %mul35 = shl nsw i32 %0, 10, !dbg !46
  %add37 = add nuw nsw i32 %mul35, %1, !dbg !47
  %idxprom = zext nneg i32 %add37 to i64, !dbg !48
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %idxprom, !dbg !48
  %10 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !48, !tbaa !30
  %cmp38 = icmp sgt i32 %10, -1, !dbg !49
  br i1 %cmp38, label %land.lhs.true, label %land.end, !dbg !50

land.lhs.true:                                    ; preds = %entry
  %cmp39 = icmp ult i32 %10, 32, !dbg !51
  %mul40 = shl nsw i32 %10, 5
  %cmp42 = icmp sle i32 %mul40, %1
  %spec.select = select i1 %cmp39, i1 %cmp42, i1 false, !dbg !52
  br label %land.end, !dbg !52

land.end:                                         ; preds = %land.lhs.true, %entry
  %11 = phi i1 [ false, %entry ], [ %spec.select, %land.lhs.true ], !dbg !53
  br i1 %11, label %for.cond43.preheader, label %land.end.if.end313_crit_edge, !dbg !54

land.end.if.end313_crit_edge:                     ; preds = %land.end
  %.pre = lshr i32 %2, 2
  %.pre1085 = shl nuw nsw i32 %2, 3
  %.pre1087 = zext nneg i32 %0 to i64
  %.pre1088 = shl nuw nsw i64 %.pre1087, 18
  %.pre1089 = sext i32 %10 to i64
  %.pre1090 = shl nsw i64 %.pre1089, 13
  %.pre1091 = add nsw i64 %.pre1090, %.pre1088
  %.pre1092 = zext nneg i32 %.pre1085 to i64
  br label %if.end313, !dbg !54

for.cond43.preheader:                             ; preds = %land.end
  %conv = zext nneg i32 %0 to i64
  %conv49 = sext i32 %10 to i64
  %12 = shl nuw nsw i32 %2, 3
  %mul57 = zext nneg i32 %12 to i64
  %invariant.gep = getelementptr %struct.__half, ptr addrspace(4) %PackedKV.coerce, i64 %mul57, !dbg !55
  %.idx665 = shl nsw i64 %conv49, 14, !dbg !56
  %13 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 %.idx665, !dbg !56
  %.idx666 = shl nuw nsw i64 %conv, 19, !dbg !56
  %14 = getelementptr i8, ptr addrspace(4) %13, i64 %.idx666, !dbg !56
  %k.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %14, align 16, !dbg !57
  %k.sroa.4.0..sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %14, i64 8, !dbg !57
  %k.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.4.0..sroa_idx, align 8, !dbg !57
  %gep.1 = getelementptr i8, ptr addrspace(4) %14, i64 1024, !dbg !56
  %k.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %gep.1, align 16, !dbg !57
  %k.sroa.7.16.gep.1.sroa_idx = getelementptr i8, ptr addrspace(4) %14, i64 1032, !dbg !57
  %k.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.7.16.gep.1.sroa_idx, align 8, !dbg !57
  %gep.2 = getelementptr i8, ptr addrspace(4) %14, i64 2048, !dbg !56
  %k.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %gep.2, align 16, !dbg !57
  %k.sroa.10.32.gep.2.sroa_idx = getelementptr i8, ptr addrspace(4) %14, i64 2056, !dbg !57
  %k.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.10.32.gep.2.sroa_idx, align 8, !dbg !57
  %gep.3 = getelementptr i8, ptr addrspace(4) %14, i64 3072, !dbg !56
  %k.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %gep.3, align 16, !dbg !57
  %k.sroa.13.48.gep.3.sroa_idx = getelementptr i8, ptr addrspace(4) %14, i64 3080, !dbg !57
  %k.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.13.48.gep.3.sroa_idx, align 8, !dbg !57
  %gep.4 = getelementptr i8, ptr addrspace(4) %14, i64 4096, !dbg !56
  %k.sroa.14.64.copyload = load <4 x half>, ptr addrspace(4) %gep.4, align 16, !dbg !57
  %k.sroa.16.64.gep.4.sroa_idx = getelementptr i8, ptr addrspace(4) %14, i64 4104, !dbg !57
  %k.sroa.16.64.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.16.64.gep.4.sroa_idx, align 8, !dbg !57
  %gep.5 = getelementptr i8, ptr addrspace(4) %14, i64 5120, !dbg !56
  %k.sroa.17.80.copyload = load <4 x half>, ptr addrspace(4) %gep.5, align 16, !dbg !57
  %k.sroa.19.80.gep.5.sroa_idx = getelementptr i8, ptr addrspace(4) %14, i64 5128, !dbg !57
  %k.sroa.19.80.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.19.80.gep.5.sroa_idx, align 8, !dbg !57
  %gep.6 = getelementptr i8, ptr addrspace(4) %14, i64 6144, !dbg !56
  %k.sroa.20.96.copyload = load <4 x half>, ptr addrspace(4) %gep.6, align 16, !dbg !57
  %k.sroa.22.96.gep.6.sroa_idx = getelementptr i8, ptr addrspace(4) %14, i64 6152, !dbg !57
  %k.sroa.22.96.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.22.96.gep.6.sroa_idx, align 8, !dbg !57
  %gep.7 = getelementptr i8, ptr addrspace(4) %14, i64 7168, !dbg !56
  %k.sroa.23.112.copyload = load <4 x half>, ptr addrspace(4) %gep.7, align 16, !dbg !57
  %k.sroa.25.112.gep.7.sroa_idx = getelementptr i8, ptr addrspace(4) %14, i64 7176, !dbg !57
  %k.sroa.25.112.copyload = load <4 x half>, ptr addrspace(4) %k.sroa.25.112.gep.7.sroa_idx, align 8, !dbg !57
  %and85 = and i32 %2, 8
  %cmp86.not.not = icmp eq i32 %and85, 0
  %. = select i1 %cmp86.not.not, i32 %q_words.sroa.7.16.copyload, i32 %q_words.sroa.0.0.copyload
  %15 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !58
  %16 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %15) #11, !dbg !66
  %xor.i.i = xor i32 %16, 8, !dbg !67
  %17 = and i32 %16, -64, !dbg !68
  %and.i.i = add nsw i32 %17, 64, !dbg !68
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !69
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %16, !dbg !70
  %shl.i.i = shl i32 %cond.i.i, 2, !dbg !71
  %18 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %.), !dbg !72
  %condval_1.0 = select i1 %cmp86.not.not, i32 %q_words.sroa.0.0.copyload, i32 %18, !dbg !73
  %condval_2.0 = select i1 %cmp86.not.not, i32 %18, i32 %q_words.sroa.7.16.copyload, !dbg !74
  %..1 = select i1 %cmp86.not.not, i32 %q_words.sroa.9.16.copyload, i32 %q_words.sroa.4.0.copyload
  %19 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !58
  %20 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %19) #11, !dbg !66
  %xor.i.i.1 = xor i32 %20, 8, !dbg !67
  %21 = and i32 %20, -64, !dbg !68
  %and.i.i.1 = add nsw i32 %21, 64, !dbg !68
  %cmp.not.i.i.1 = icmp slt i32 %xor.i.i.1, %and.i.i.1, !dbg !69
  %cond.i.i.1 = select i1 %cmp.not.i.i.1, i32 %xor.i.i.1, i32 %20, !dbg !70
  %shl.i.i.1 = shl i32 %cond.i.i.1, 2, !dbg !71
  %22 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.1, i32 %..1), !dbg !72
  %condval_1.0.1 = select i1 %cmp86.not.not, i32 %q_words.sroa.4.0.copyload, i32 %22, !dbg !73
  %condval_2.0.1 = select i1 %cmp86.not.not, i32 %22, i32 %q_words.sroa.9.16.copyload, !dbg !74
  %..2 = select i1 %cmp86.not.not, i32 %q_words.sroa.10.16.copyload, i32 %q_words.sroa.5.0.copyload
  %23 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !58
  %24 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %23) #11, !dbg !66
  %xor.i.i.2 = xor i32 %24, 8, !dbg !67
  %25 = and i32 %24, -64, !dbg !68
  %and.i.i.2 = add nsw i32 %25, 64, !dbg !68
  %cmp.not.i.i.2 = icmp slt i32 %xor.i.i.2, %and.i.i.2, !dbg !69
  %cond.i.i.2 = select i1 %cmp.not.i.i.2, i32 %xor.i.i.2, i32 %24, !dbg !70
  %shl.i.i.2 = shl i32 %cond.i.i.2, 2, !dbg !71
  %26 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.2, i32 %..2), !dbg !72
  %condval_1.0.2 = select i1 %cmp86.not.not, i32 %q_words.sroa.5.0.copyload, i32 %26, !dbg !73
  %condval_2.0.2 = select i1 %cmp86.not.not, i32 %26, i32 %q_words.sroa.10.16.copyload, !dbg !74
  %..3 = select i1 %cmp86.not.not, i32 %q_words.sroa.11.16.copyload, i32 %q_words.sroa.6.0.copyload
  %27 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !58
  %28 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %27) #11, !dbg !66
  %xor.i.i.3 = xor i32 %28, 8, !dbg !67
  %29 = and i32 %28, -64, !dbg !68
  %and.i.i.3 = add nsw i32 %29, 64, !dbg !68
  %cmp.not.i.i.3 = icmp slt i32 %xor.i.i.3, %and.i.i.3, !dbg !69
  %cond.i.i.3 = select i1 %cmp.not.i.i.3, i32 %xor.i.i.3, i32 %28, !dbg !70
  %shl.i.i.3 = shl i32 %cond.i.i.3, 2, !dbg !71
  %30 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.3, i32 %..3), !dbg !72
  %condval_1.0.3 = select i1 %cmp86.not.not, i32 %q_words.sroa.6.0.copyload, i32 %30, !dbg !73
  %condval_2.0.3 = select i1 %cmp86.not.not, i32 %30, i32 %q_words.sroa.11.16.copyload, !dbg !74
  %..1686 = select i1 %cmp86.not.not, i32 %q_words.sroa.17.48.copyload, i32 %q_words.sroa.12.32.copyload
  %31 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !58
  %32 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %31) #11, !dbg !66
  %xor.i.i.1687 = xor i32 %32, 8, !dbg !67
  %33 = and i32 %32, -64, !dbg !68
  %and.i.i.1688 = add nsw i32 %33, 64, !dbg !68
  %cmp.not.i.i.1689 = icmp slt i32 %xor.i.i.1687, %and.i.i.1688, !dbg !69
  %cond.i.i.1690 = select i1 %cmp.not.i.i.1689, i32 %xor.i.i.1687, i32 %32, !dbg !70
  %shl.i.i.1691 = shl i32 %cond.i.i.1690, 2, !dbg !71
  %34 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.1691, i32 %..1686), !dbg !72
  %condval_1.0.1692 = select i1 %cmp86.not.not, i32 %q_words.sroa.12.32.copyload, i32 %34, !dbg !73
  %condval_2.0.1694 = select i1 %cmp86.not.not, i32 %34, i32 %q_words.sroa.17.48.copyload, !dbg !74
  %..1.1 = select i1 %cmp86.not.not, i32 %q_words.sroa.19.48.copyload, i32 %q_words.sroa.14.32.copyload
  %35 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !58
  %36 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %35) #11, !dbg !66
  %xor.i.i.1.1 = xor i32 %36, 8, !dbg !67
  %37 = and i32 %36, -64, !dbg !68
  %and.i.i.1.1 = add nsw i32 %37, 64, !dbg !68
  %cmp.not.i.i.1.1 = icmp slt i32 %xor.i.i.1.1, %and.i.i.1.1, !dbg !69
  %cond.i.i.1.1 = select i1 %cmp.not.i.i.1.1, i32 %xor.i.i.1.1, i32 %36, !dbg !70
  %shl.i.i.1.1 = shl i32 %cond.i.i.1.1, 2, !dbg !71
  %38 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.1.1, i32 %..1.1), !dbg !72
  %condval_1.0.1.1 = select i1 %cmp86.not.not, i32 %q_words.sroa.14.32.copyload, i32 %38, !dbg !73
  %condval_2.0.1.1 = select i1 %cmp86.not.not, i32 %38, i32 %q_words.sroa.19.48.copyload, !dbg !74
  %..2.1 = select i1 %cmp86.not.not, i32 %q_words.sroa.20.48.copyload, i32 %q_words.sroa.15.32.copyload
  %39 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !58
  %40 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %39) #11, !dbg !66
  %xor.i.i.2.1 = xor i32 %40, 8, !dbg !67
  %41 = and i32 %40, -64, !dbg !68
  %and.i.i.2.1 = add nsw i32 %41, 64, !dbg !68
  %cmp.not.i.i.2.1 = icmp slt i32 %xor.i.i.2.1, %and.i.i.2.1, !dbg !69
  %cond.i.i.2.1 = select i1 %cmp.not.i.i.2.1, i32 %xor.i.i.2.1, i32 %40, !dbg !70
  %shl.i.i.2.1 = shl i32 %cond.i.i.2.1, 2, !dbg !71
  %42 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.2.1, i32 %..2.1), !dbg !72
  %condval_1.0.2.1 = select i1 %cmp86.not.not, i32 %q_words.sroa.15.32.copyload, i32 %42, !dbg !73
  %condval_2.0.2.1 = select i1 %cmp86.not.not, i32 %42, i32 %q_words.sroa.20.48.copyload, !dbg !74
  %..3.1 = select i1 %cmp86.not.not, i32 %q_words.sroa.21.48.copyload, i32 %q_words.sroa.16.32.copyload
  %43 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !58
  %44 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %43) #11, !dbg !66
  %xor.i.i.3.1 = xor i32 %44, 8, !dbg !67
  %45 = and i32 %44, -64, !dbg !68
  %and.i.i.3.1 = add nsw i32 %45, 64, !dbg !68
  %cmp.not.i.i.3.1 = icmp slt i32 %xor.i.i.3.1, %and.i.i.3.1, !dbg !69
  %cond.i.i.3.1 = select i1 %cmp.not.i.i.3.1, i32 %xor.i.i.3.1, i32 %44, !dbg !70
  %shl.i.i.3.1 = shl i32 %cond.i.i.3.1, 2, !dbg !71
  %46 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i.3.1, i32 %..3.1), !dbg !72
  %condval_1.0.3.1 = select i1 %cmp86.not.not, i32 %q_words.sroa.16.32.copyload, i32 %46, !dbg !73
  %condval_2.0.3.1 = select i1 %cmp86.not.not, i32 %46, i32 %q_words.sroa.21.48.copyload, !dbg !74
  %47 = insertelement <2 x i32> poison, i32 %condval_1.0, i64 0, !dbg !75
  %q.sroa.0.2.vec.insert = bitcast <2 x i32> %47 to <4 x half>, !dbg !75
  %q_halves.sroa.5.4.extract.trunc = trunc i32 %condval_1.0.1 to i16, !dbg !75
  %48 = bitcast i16 %q_halves.sroa.5.4.extract.trunc to half, !dbg !75
  %q.sroa.0.4.vec.insert = insertelement <4 x half> %q.sroa.0.2.vec.insert, half %48, i64 2, !dbg !75
  %q_halves.sroa.5.6.extract.shift = lshr i32 %condval_1.0.1, 16, !dbg !75
  %q_halves.sroa.5.6.extract.trunc = trunc nuw i32 %q_halves.sroa.5.6.extract.shift to i16, !dbg !75
  %49 = bitcast i16 %q_halves.sroa.5.6.extract.trunc to half, !dbg !75
  %q.sroa.0.6.vec.insert = insertelement <4 x half> %q.sroa.0.4.vec.insert, half %49, i64 3, !dbg !75
  %50 = insertelement <2 x i32> poison, i32 %condval_1.0.2, i64 0, !dbg !75
  %q.sroa.7.10.vec.insert = bitcast <2 x i32> %50 to <4 x half>, !dbg !75
  %q_halves.sroa.11.12.extract.trunc = trunc i32 %condval_1.0.3 to i16, !dbg !75
  %51 = bitcast i16 %q_halves.sroa.11.12.extract.trunc to half, !dbg !75
  %q.sroa.7.12.vec.insert = insertelement <4 x half> %q.sroa.7.10.vec.insert, half %51, i64 2, !dbg !75
  %q_halves.sroa.11.14.extract.shift = lshr i32 %condval_1.0.3, 16, !dbg !75
  %q_halves.sroa.11.14.extract.trunc = trunc nuw i32 %q_halves.sroa.11.14.extract.shift to i16, !dbg !75
  %52 = bitcast i16 %q_halves.sroa.11.14.extract.trunc to half, !dbg !75
  %q.sroa.7.14.vec.insert = insertelement <4 x half> %q.sroa.7.12.vec.insert, half %52, i64 3, !dbg !75
  %53 = insertelement <2 x i32> poison, i32 %condval_2.0, i64 0, !dbg !75
  %q.sroa.12.18.vec.insert = bitcast <2 x i32> %53 to <4 x half>, !dbg !75
  %q_halves.sroa.17.20.extract.trunc = trunc i32 %condval_2.0.1 to i16, !dbg !75
  %54 = bitcast i16 %q_halves.sroa.17.20.extract.trunc to half, !dbg !75
  %q.sroa.12.20.vec.insert = insertelement <4 x half> %q.sroa.12.18.vec.insert, half %54, i64 2, !dbg !75
  %q_halves.sroa.17.22.extract.shift = lshr i32 %condval_2.0.1, 16, !dbg !75
  %q_halves.sroa.17.22.extract.trunc = trunc nuw i32 %q_halves.sroa.17.22.extract.shift to i16, !dbg !75
  %55 = bitcast i16 %q_halves.sroa.17.22.extract.trunc to half, !dbg !75
  %q.sroa.12.22.vec.insert = insertelement <4 x half> %q.sroa.12.20.vec.insert, half %55, i64 3, !dbg !75
  %56 = insertelement <2 x i32> poison, i32 %condval_2.0.2, i64 0, !dbg !75
  %q.sroa.17.26.vec.insert = bitcast <2 x i32> %56 to <4 x half>, !dbg !75
  %q_halves.sroa.23.28.extract.trunc = trunc i32 %condval_2.0.3 to i16, !dbg !75
  %57 = bitcast i16 %q_halves.sroa.23.28.extract.trunc to half, !dbg !75
  %q.sroa.17.28.vec.insert = insertelement <4 x half> %q.sroa.17.26.vec.insert, half %57, i64 2, !dbg !75
  %q_halves.sroa.23.30.extract.shift = lshr i32 %condval_2.0.3, 16, !dbg !75
  %q_halves.sroa.23.30.extract.trunc = trunc nuw i32 %q_halves.sroa.23.30.extract.shift to i16, !dbg !75
  %58 = bitcast i16 %q_halves.sroa.23.30.extract.trunc to half, !dbg !75
  %q.sroa.17.30.vec.insert = insertelement <4 x half> %q.sroa.17.28.vec.insert, half %58, i64 3, !dbg !75
  %59 = insertelement <2 x i32> poison, i32 %condval_1.0.1692, i64 0, !dbg !75
  %q.sroa.22.34.vec.insert = bitcast <2 x i32> %59 to <4 x half>, !dbg !75
  %q_halves.sroa.29.36.extract.trunc = trunc i32 %condval_1.0.1.1 to i16, !dbg !75
  %60 = bitcast i16 %q_halves.sroa.29.36.extract.trunc to half, !dbg !75
  %q.sroa.22.36.vec.insert = insertelement <4 x half> %q.sroa.22.34.vec.insert, half %60, i64 2, !dbg !75
  %q_halves.sroa.29.38.extract.shift = lshr i32 %condval_1.0.1.1, 16, !dbg !75
  %q_halves.sroa.29.38.extract.trunc = trunc nuw i32 %q_halves.sroa.29.38.extract.shift to i16, !dbg !75
  %61 = bitcast i16 %q_halves.sroa.29.38.extract.trunc to half, !dbg !75
  %q.sroa.22.38.vec.insert = insertelement <4 x half> %q.sroa.22.36.vec.insert, half %61, i64 3, !dbg !75
  %62 = insertelement <2 x i32> poison, i32 %condval_1.0.2.1, i64 0, !dbg !75
  %q.sroa.27.42.vec.insert = bitcast <2 x i32> %62 to <4 x half>, !dbg !75
  %q_halves.sroa.35.44.extract.trunc = trunc i32 %condval_1.0.3.1 to i16, !dbg !75
  %63 = bitcast i16 %q_halves.sroa.35.44.extract.trunc to half, !dbg !75
  %q.sroa.27.44.vec.insert = insertelement <4 x half> %q.sroa.27.42.vec.insert, half %63, i64 2, !dbg !75
  %q_halves.sroa.35.46.extract.shift = lshr i32 %condval_1.0.3.1, 16, !dbg !75
  %q_halves.sroa.35.46.extract.trunc = trunc nuw i32 %q_halves.sroa.35.46.extract.shift to i16, !dbg !75
  %64 = bitcast i16 %q_halves.sroa.35.46.extract.trunc to half, !dbg !75
  %q.sroa.27.46.vec.insert = insertelement <4 x half> %q.sroa.27.44.vec.insert, half %64, i64 3, !dbg !75
  %65 = insertelement <2 x i32> poison, i32 %condval_2.0.1694, i64 0, !dbg !75
  %q.sroa.32.50.vec.insert = bitcast <2 x i32> %65 to <4 x half>, !dbg !75
  %q_halves.sroa.41.52.extract.trunc = trunc i32 %condval_2.0.1.1 to i16, !dbg !75
  %66 = bitcast i16 %q_halves.sroa.41.52.extract.trunc to half, !dbg !75
  %q.sroa.32.52.vec.insert = insertelement <4 x half> %q.sroa.32.50.vec.insert, half %66, i64 2, !dbg !75
  %q_halves.sroa.41.54.extract.shift = lshr i32 %condval_2.0.1.1, 16, !dbg !75
  %q_halves.sroa.41.54.extract.trunc = trunc nuw i32 %q_halves.sroa.41.54.extract.shift to i16, !dbg !75
  %67 = bitcast i16 %q_halves.sroa.41.54.extract.trunc to half, !dbg !75
  %q.sroa.32.54.vec.insert = insertelement <4 x half> %q.sroa.32.52.vec.insert, half %67, i64 3, !dbg !75
  %68 = insertelement <2 x i32> poison, i32 %condval_2.0.2.1, i64 0, !dbg !75
  %q.sroa.37.58.vec.insert = bitcast <2 x i32> %68 to <4 x half>, !dbg !75
  %q_halves.sroa.47.60.extract.trunc = trunc i32 %condval_2.0.3.1 to i16, !dbg !75
  %69 = bitcast i16 %q_halves.sroa.47.60.extract.trunc to half, !dbg !75
  %q.sroa.37.60.vec.insert = insertelement <4 x half> %q.sroa.37.58.vec.insert, half %69, i64 2, !dbg !75
  %q_halves.sroa.47.62.extract.shift = lshr i32 %condval_2.0.3.1, 16, !dbg !75
  %q_halves.sroa.47.62.extract.trunc = trunc nuw i32 %q_halves.sroa.47.62.extract.shift to i16, !dbg !75
  %70 = bitcast i16 %q_halves.sroa.47.62.extract.trunc to half, !dbg !75
  %q.sroa.37.62.vec.insert = insertelement <4 x half> %q.sroa.37.60.vec.insert, half %70, i64 3, !dbg !75
  %cmp144 = icmp slt i32 %10, 32
  %71 = lshr i32 %2, 2
  br i1 %cmp144, label %for.body143.us.preheader, label %for.cond167.preheader

for.body143.us.preheader:                         ; preds = %for.cond43.preheader
  %mul146 = shl nsw i32 %10, 5
  %mul152 = and i32 %71, 252
  %add149 = add i32 %mul146, %mul152
  %cmp157.not.us = icmp sgt i32 %add149, %1, !dbg !76
  %spec.select663 = select i1 %cmp157.not.us, float 0xFFF0000000000000, float 0.000000e+00, !dbg !77
  %scores.sroa.0.0.vec.insert966 = insertelement <4 x float> poison, float %spec.select663, i64 0, !dbg !78
  %cmp157.not.us.1.not = icmp slt i32 %add149, %1, !dbg !76
  %spec.select663.1 = select i1 %cmp157.not.us.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !77
  %scores.sroa.0.4.vec.insert979 = insertelement <4 x float> %scores.sroa.0.0.vec.insert966, float %spec.select663.1, i64 1, !dbg !78
  %add153.us.2 = or disjoint i32 %add149, 2, !dbg !79
  %cmp157.not.us.2 = icmp sgt i32 %add153.us.2, %1, !dbg !76
  %spec.select663.2 = select i1 %cmp157.not.us.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !77
  %scores.sroa.0.8.vec.insert992 = insertelement <4 x float> %scores.sroa.0.4.vec.insert979, float %spec.select663.2, i64 2, !dbg !78
  %add153.us.3 = or disjoint i32 %add149, 3, !dbg !79
  %cmp157.not.us.3 = icmp sgt i32 %add153.us.3, %1, !dbg !76
  %spec.select663.3 = select i1 %cmp157.not.us.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !77
  %scores.sroa.0.12.vec.insert1005 = insertelement <4 x float> %scores.sroa.0.8.vec.insert992, float %spec.select663.3, i64 3, !dbg !78
  %add155.us.4 = add i32 %add149, 16, !dbg !80
  %cmp157.not.us.4 = icmp sgt i32 %add155.us.4, %1, !dbg !76
  %spec.select663.4 = select i1 %cmp157.not.us.4, float 0xFFF0000000000000, float 0.000000e+00, !dbg !77
  %scores.sroa.50.16.vec.insert1026 = insertelement <4 x float> poison, float %spec.select663.4, i64 0, !dbg !78
  %add155.us.5 = add i32 %add149, 17, !dbg !80
  %cmp157.not.us.5 = icmp sgt i32 %add155.us.5, %1, !dbg !76
  %spec.select663.5 = select i1 %cmp157.not.us.5, float 0xFFF0000000000000, float 0.000000e+00, !dbg !77
  %scores.sroa.50.20.vec.insert1039 = insertelement <4 x float> %scores.sroa.50.16.vec.insert1026, float %spec.select663.5, i64 1, !dbg !78
  %add155.us.6 = add i32 %add149, 18, !dbg !80
  %cmp157.not.us.6 = icmp sgt i32 %add155.us.6, %1, !dbg !76
  %spec.select663.6 = select i1 %cmp157.not.us.6, float 0xFFF0000000000000, float 0.000000e+00, !dbg !77
  %scores.sroa.50.24.vec.insert1052 = insertelement <4 x float> %scores.sroa.50.20.vec.insert1039, float %spec.select663.6, i64 2, !dbg !78
  %add155.us.7 = add i32 %add149, 19, !dbg !80
  %cmp157.not.us.7 = icmp sgt i32 %add155.us.7, %1, !dbg !76
  %spec.select663.7 = select i1 %cmp157.not.us.7, float 0xFFF0000000000000, float 0.000000e+00, !dbg !77
  %scores.sroa.50.28.vec.insert1065 = insertelement <4 x float> %scores.sroa.50.24.vec.insert1052, float %spec.select663.7, i64 3, !dbg !78
  br label %for.cond167.preheader, !dbg !81

for.cond167.preheader:                            ; preds = %for.cond43.preheader, %for.body143.us.preheader
  %scores.sroa.50.0 = phi <4 x float> [ %scores.sroa.50.28.vec.insert1065, %for.body143.us.preheader ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %for.cond43.preheader ], !dbg !78
  %scores.sroa.0.0 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1005, %for.body143.us.preheader ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %for.cond43.preheader ], !dbg !78
  %72 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.0.0.copyload, <4 x half> %q.sroa.0.6.vec.insert, <4 x float> %scores.sroa.0.0), !dbg !82, !call_argsrelate !83
  %73 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.5.16.copyload, <4 x half> %q.sroa.0.6.vec.insert, <4 x float> %scores.sroa.50.0), !dbg !82, !call_argsrelate !83
  %74 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.4.0.copyload, <4 x half> %q.sroa.7.14.vec.insert, <4 x float> %72), !dbg !82, !call_argsrelate !83
  %75 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.7.16.copyload, <4 x half> %q.sroa.7.14.vec.insert, <4 x float> %73), !dbg !82, !call_argsrelate !83
  %76 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.8.32.copyload, <4 x half> %q.sroa.12.22.vec.insert, <4 x float> %74), !dbg !82, !call_argsrelate !83
  %77 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.11.48.copyload, <4 x half> %q.sroa.12.22.vec.insert, <4 x float> %75), !dbg !82, !call_argsrelate !83
  %78 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.10.32.copyload, <4 x half> %q.sroa.17.30.vec.insert, <4 x float> %76), !dbg !82, !call_argsrelate !83
  %79 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.13.48.copyload, <4 x half> %q.sroa.17.30.vec.insert, <4 x float> %77), !dbg !82, !call_argsrelate !83
  %80 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.14.64.copyload, <4 x half> %q.sroa.22.38.vec.insert, <4 x float> %78), !dbg !82, !call_argsrelate !83
  %81 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.17.80.copyload, <4 x half> %q.sroa.22.38.vec.insert, <4 x float> %79), !dbg !82, !call_argsrelate !83
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.16.64.copyload, <4 x half> %q.sroa.27.46.vec.insert, <4 x float> %80), !dbg !82, !call_argsrelate !83
  %83 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.19.80.copyload, <4 x half> %q.sroa.27.46.vec.insert, <4 x float> %81), !dbg !82, !call_argsrelate !83
  %84 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.20.96.copyload, <4 x half> %q.sroa.32.54.vec.insert, <4 x float> %82), !dbg !82, !call_argsrelate !83
  %85 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.23.112.copyload, <4 x half> %q.sroa.32.54.vec.insert, <4 x float> %83), !dbg !82, !call_argsrelate !83
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.22.96.copyload, <4 x half> %q.sroa.37.62.vec.insert, <4 x float> %84), !dbg !82, !call_argsrelate !83
  %87 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %k.sroa.25.112.copyload, <4 x half> %q.sroa.37.62.vec.insert, <4 x float> %85), !dbg !82, !call_argsrelate !83
  %mul212 = shl nuw nsw i64 %conv, 18
  %mul214 = shl nsw i64 %conv49, 13
  %add215 = add nsw i64 %mul214, %mul212
  %invariant.gep635 = getelementptr i8, ptr addrspace(4) %invariant.gep, i64 8192, !dbg !84
  %gep636 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep635, i64 %add215, !dbg !85
  %v.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %gep636, align 16, !dbg !86
  %v.sroa.7.0.gep636.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep636, i64 8, !dbg !86
  %v.sroa.7.0.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.7.0.gep636.sroa_idx, align 8, !dbg !86
  %add223.1 = or disjoint i64 %add215, 512, !dbg !87
  %gep636.1 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep635, i64 %add223.1, !dbg !85
  %v.sroa.9.16.copyload = load <4 x half>, ptr addrspace(4) %gep636.1, align 16, !dbg !86
  %v.sroa.14.16.gep636.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep636.1, i64 8, !dbg !86
  %v.sroa.14.16.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.14.16.gep636.1.sroa_idx, align 8, !dbg !86
  %add219.2 = or disjoint i64 %add215, 2048, !dbg !88
  %gep636.2 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep635, i64 %add219.2, !dbg !85
  %v.sroa.16.32.copyload = load <4 x half>, ptr addrspace(4) %gep636.2, align 16, !dbg !86
  %v.sroa.21.32.gep636.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep636.2, i64 8, !dbg !86
  %v.sroa.21.32.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.21.32.gep636.2.sroa_idx, align 8, !dbg !86
  %add223.3 = or disjoint i64 %add215, 2560, !dbg !87
  %gep636.3 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep635, i64 %add223.3, !dbg !85
  %v.sroa.23.48.copyload = load <4 x half>, ptr addrspace(4) %gep636.3, align 16, !dbg !86
  %v.sroa.28.48.gep636.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep636.3, i64 8, !dbg !86
  %v.sroa.28.48.copyload = load <4 x half>, ptr addrspace(4) %v.sroa.28.48.gep636.3.sroa_idx, align 8, !dbg !86
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %86, i64 0, !dbg !89
  %mul243 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FC2776C60000000, !dbg !90
  %88 = tail call contract noundef float @llvm.minnum.f32(float %mul243, float 1.500000e+01), !dbg !91
  %cmp.i.i = fcmp contract olt float %88, -1.260000e+02, !dbg !95
  %cond.i.i610 = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00, !dbg !95
  %add.i.i611 = fadd contract float %88, %cond.i.i610, !dbg !95
  %89 = tail call contract float @llvm.exp2.f32(float %add.i.i611), !dbg !95
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00, !dbg !95
  %mul.i.i = fmul contract float %cond2.i.i, %89, !dbg !95
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %86, i64 1, !dbg !89
  %mul243.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FC2776C60000000, !dbg !90
  %90 = tail call contract noundef float @llvm.minnum.f32(float %mul243.1, float 1.500000e+01), !dbg !91
  %cmp.i.i.1 = fcmp contract olt float %90, -1.260000e+02, !dbg !95
  %cond.i.i610.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00, !dbg !95
  %add.i.i611.1 = fadd contract float %90, %cond.i.i610.1, !dbg !95
  %91 = tail call contract float @llvm.exp2.f32(float %add.i.i611.1), !dbg !95
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !95
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %91, !dbg !95
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %86, i64 2, !dbg !89
  %mul243.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FC2776C60000000, !dbg !90
  %92 = tail call contract noundef float @llvm.minnum.f32(float %mul243.2, float 1.500000e+01), !dbg !91
  %cmp.i.i.2 = fcmp contract olt float %92, -1.260000e+02, !dbg !95
  %cond.i.i610.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00, !dbg !95
  %add.i.i611.2 = fadd contract float %92, %cond.i.i610.2, !dbg !95
  %93 = tail call contract float @llvm.exp2.f32(float %add.i.i611.2), !dbg !95
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00, !dbg !95
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %93, !dbg !95
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %86, i64 3, !dbg !89
  %mul243.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FC2776C60000000, !dbg !90
  %94 = tail call contract noundef float @llvm.minnum.f32(float %mul243.3, float 1.500000e+01), !dbg !91
  %cmp.i.i.3 = fcmp contract olt float %94, -1.260000e+02, !dbg !95
  %cond.i.i610.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00, !dbg !95
  %add.i.i611.3 = fadd contract float %94, %cond.i.i610.3, !dbg !95
  %95 = tail call contract float @llvm.exp2.f32(float %add.i.i611.3), !dbg !95
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00, !dbg !95
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %95, !dbg !95
  %scores.sroa.50.16.vec.extract = extractelement <4 x float> %87, i64 0, !dbg !89
  %mul243.4 = fmul contract float %scores.sroa.50.16.vec.extract, 0x3FC2776C60000000, !dbg !90
  %96 = tail call contract noundef float @llvm.minnum.f32(float %mul243.4, float 1.500000e+01), !dbg !91
  %cmp.i.i.4 = fcmp contract olt float %96, -1.260000e+02, !dbg !95
  %cond.i.i610.4 = select contract i1 %cmp.i.i.4, float 6.400000e+01, float 0.000000e+00, !dbg !95
  %add.i.i611.4 = fadd contract float %96, %cond.i.i610.4, !dbg !95
  %97 = tail call contract float @llvm.exp2.f32(float %add.i.i611.4), !dbg !95
  %cond2.i.i.4 = select contract i1 %cmp.i.i.4, float 0x3BF0000000000000, float 1.000000e+00, !dbg !95
  %mul.i.i.4 = fmul contract float %cond2.i.i.4, %97, !dbg !95
  %scores.sroa.50.20.vec.extract = extractelement <4 x float> %87, i64 1, !dbg !89
  %mul243.5 = fmul contract float %scores.sroa.50.20.vec.extract, 0x3FC2776C60000000, !dbg !90
  %98 = tail call contract noundef float @llvm.minnum.f32(float %mul243.5, float 1.500000e+01), !dbg !91
  %cmp.i.i.5 = fcmp contract olt float %98, -1.260000e+02, !dbg !95
  %cond.i.i610.5 = select contract i1 %cmp.i.i.5, float 6.400000e+01, float 0.000000e+00, !dbg !95
  %add.i.i611.5 = fadd contract float %98, %cond.i.i610.5, !dbg !95
  %99 = tail call contract float @llvm.exp2.f32(float %add.i.i611.5), !dbg !95
  %cond2.i.i.5 = select contract i1 %cmp.i.i.5, float 0x3BF0000000000000, float 1.000000e+00, !dbg !95
  %mul.i.i.5 = fmul contract float %cond2.i.i.5, %99, !dbg !95
  %scores.sroa.50.24.vec.extract = extractelement <4 x float> %87, i64 2, !dbg !89
  %mul243.6 = fmul contract float %scores.sroa.50.24.vec.extract, 0x3FC2776C60000000, !dbg !90
  %100 = tail call contract noundef float @llvm.minnum.f32(float %mul243.6, float 1.500000e+01), !dbg !91
  %cmp.i.i.6 = fcmp contract olt float %100, -1.260000e+02, !dbg !95
  %cond.i.i610.6 = select contract i1 %cmp.i.i.6, float 6.400000e+01, float 0.000000e+00, !dbg !95
  %add.i.i611.6 = fadd contract float %100, %cond.i.i610.6, !dbg !95
  %101 = tail call contract float @llvm.exp2.f32(float %add.i.i611.6), !dbg !95
  %cond2.i.i.6 = select contract i1 %cmp.i.i.6, float 0x3BF0000000000000, float 1.000000e+00, !dbg !95
  %mul.i.i.6 = fmul contract float %cond2.i.i.6, %101, !dbg !95
  %scores.sroa.50.28.vec.extract = extractelement <4 x float> %87, i64 3, !dbg !89
  %mul243.7 = fmul contract float %scores.sroa.50.28.vec.extract, 0x3FC2776C60000000, !dbg !90
  %102 = tail call contract noundef float @llvm.minnum.f32(float %mul243.7, float 1.500000e+01), !dbg !91
  %cmp.i.i.7 = fcmp contract olt float %102, -1.260000e+02, !dbg !95
  %cond.i.i610.7 = select contract i1 %cmp.i.i.7, float 6.400000e+01, float 0.000000e+00, !dbg !95
  %add.i.i611.7 = fadd contract float %102, %cond.i.i610.7, !dbg !95
  %103 = tail call contract float @llvm.exp2.f32(float %add.i.i611.7), !dbg !95
  %cond2.i.i.7 = select contract i1 %cmp.i.i.7, float 0x3BF0000000000000, float 1.000000e+00, !dbg !95
  %mul.i.i.7 = fmul contract float %cond2.i.i.7, %103, !dbg !95
  %add263 = fadd contract float %mul.i.i, 0.000000e+00, !dbg !98
  %add263.1 = fadd contract float %add263, %mul.i.i.4, !dbg !98
  %add263.2 = fadd contract float %add263.1, %mul.i.i.1, !dbg !98
  %add263.3 = fadd contract float %add263.2, %mul.i.i.5, !dbg !98
  %add263.4 = fadd contract float %add263.3, %mul.i.i.2, !dbg !98
  %add263.5 = fadd contract float %add263.4, %mul.i.i.6, !dbg !98
  %add263.6 = fadd contract float %add263.5, %mul.i.i.3, !dbg !98
  %add263.7 = fadd contract float %add263.6, %mul.i.i.7, !dbg !98
  %104 = bitcast float %add263.7 to i32, !dbg !99
  %105 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !110
  %106 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %105) #11, !dbg !113
  %xor.i.i612 = xor i32 %106, 32, !dbg !114
  %107 = and i32 %106, -64, !dbg !115
  %and.i.i613 = add nsw i32 %107, 64, !dbg !115
  %cmp.not.i.i614 = icmp slt i32 %xor.i.i612, %and.i.i613, !dbg !116
  %cond.i.i615 = select i1 %cmp.not.i.i614, i32 %xor.i.i612, i32 %106, !dbg !117
  %shl.i.i616 = shl i32 %cond.i.i615, 2, !dbg !118
  %108 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i616, i32 %104), !dbg !119
  %109 = bitcast i32 %108 to float, !dbg !120
  %add.i = fadd contract float %add263.7, %109, !dbg !121
  %110 = bitcast float %add.i to i32, !dbg !124
  %111 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !131
  %112 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %111) #11, !dbg !134
  %xor.i.i617 = xor i32 %112, 16, !dbg !135
  %113 = and i32 %112, -64, !dbg !136
  %and.i.i618 = add nsw i32 %113, 64, !dbg !136
  %cmp.not.i.i619 = icmp slt i32 %xor.i.i617, %and.i.i618, !dbg !137
  %cond.i.i620 = select i1 %cmp.not.i.i619, i32 %xor.i.i617, i32 %112, !dbg !138
  %shl.i.i621 = shl i32 %cond.i.i620, 2, !dbg !139
  %114 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i621, i32 %110), !dbg !140
  %115 = bitcast i32 %114 to float, !dbg !141
  %add.i.i = fadd contract float %add.i, %115, !dbg !142
  %cmp272 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !144
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !145
  %condval_4.0 = select i1 %cmp272, float %div, float 0.000000e+00, !dbg !145
  %mul285 = fmul contract float %condval_4.0, %mul.i.i, !dbg !146
  %mul285.1 = fmul contract float %condval_4.0, %mul.i.i.1, !dbg !146
  %mul285.2 = fmul contract float %condval_4.0, %mul.i.i.2, !dbg !146
  %mul285.3 = fmul contract float %condval_4.0, %mul.i.i.3, !dbg !146
  %mul285.4 = fmul contract float %condval_4.0, %mul.i.i.4, !dbg !146
  %mul285.5 = fmul contract float %condval_4.0, %mul.i.i.5, !dbg !146
  %mul285.6 = fmul contract float %condval_4.0, %mul.i.i.6, !dbg !146
  %mul285.7 = fmul contract float %condval_4.0, %mul.i.i.7, !dbg !146
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul285), !dbg !147
  %117 = insertelement <4 x i16> poison, i16 %116, i64 0, !dbg !156
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul285.1), !dbg !147
  %119 = insertelement <4 x i16> %117, i16 %118, i64 1, !dbg !156
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul285.2), !dbg !147
  %121 = insertelement <4 x i16> %119, i16 %120, i64 2, !dbg !156
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul285.3), !dbg !147
  %123 = insertelement <4 x i16> %121, i16 %122, i64 3, !dbg !156
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %123 to <4 x half>, !dbg !156
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul285.4), !dbg !147
  %125 = insertelement <4 x i16> poison, i16 %124, i64 0, !dbg !156
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul285.5), !dbg !147
  %127 = insertelement <4 x i16> %125, i16 %126, i64 1, !dbg !156
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul285.6), !dbg !147
  %129 = insertelement <4 x i16> %127, i16 %128, i64 2, !dbg !156
  %130 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul285.7), !dbg !147
  %131 = insertelement <4 x i16> %129, i16 %130, i64 3, !dbg !156
  %prob.sroa.8.14.vec.insert = bitcast <4 x i16> %131 to <4 x half>, !dbg !156
  br label %if.end313, !dbg !157

if.end313:                                        ; preds = %land.end.if.end313_crit_edge, %for.cond167.preheader
  %mul358.pre-phi = phi i64 [ %.pre1092, %land.end.if.end313_crit_edge ], [ %mul57, %for.cond167.preheader ]
  %add344.pre-phi = phi i64 [ %.pre1091, %land.end.if.end313_crit_edge ], [ %add215, %for.cond167.preheader ]
  %.pre-phi1086 = phi i32 [ %.pre1085, %land.end.if.end313_crit_edge ], [ %12, %for.cond167.preheader ]
  %.pre-phi = phi i32 [ %.pre, %land.end.if.end313_crit_edge ], [ %71, %for.cond167.preheader ]
  %v.sroa.28.0 = phi <4 x half> [ undef, %land.end.if.end313_crit_edge ], [ %v.sroa.28.48.copyload, %for.cond167.preheader ]
  %v.sroa.23.0 = phi <4 x half> [ undef, %land.end.if.end313_crit_edge ], [ %v.sroa.23.48.copyload, %for.cond167.preheader ]
  %v.sroa.21.0 = phi <4 x half> [ undef, %land.end.if.end313_crit_edge ], [ %v.sroa.21.32.copyload, %for.cond167.preheader ]
  %v.sroa.16.0 = phi <4 x half> [ undef, %land.end.if.end313_crit_edge ], [ %v.sroa.16.32.copyload, %for.cond167.preheader ]
  %v.sroa.14.0 = phi <4 x half> [ undef, %land.end.if.end313_crit_edge ], [ %v.sroa.14.16.copyload, %for.cond167.preheader ]
  %v.sroa.9.0 = phi <4 x half> [ undef, %land.end.if.end313_crit_edge ], [ %v.sroa.9.16.copyload, %for.cond167.preheader ]
  %v.sroa.7.0 = phi <4 x half> [ undef, %land.end.if.end313_crit_edge ], [ %v.sroa.7.0.copyload, %for.cond167.preheader ]
  %v.sroa.0.0 = phi <4 x half> [ undef, %land.end.if.end313_crit_edge ], [ %v.sroa.0.0.copyload, %for.cond167.preheader ]
  %prob.sroa.8.0 = phi <4 x half> [ undef, %land.end.if.end313_crit_edge ], [ %prob.sroa.8.14.vec.insert, %for.cond167.preheader ]
  %prob.sroa.0.0 = phi <4 x half> [ undef, %land.end.if.end313_crit_edge ], [ %prob.sroa.0.6.vec.insert, %for.cond167.preheader ]
  %invariant.gep660 = getelementptr i8, ptr addrspace(4) %PackedKV.coerce, i64 8192, !dbg !157
  %and431 = shl nuw nsw i32 %2, 6
  %mul432 = and i32 %and431, 960
  %shr435 = lshr i32 %2, 5
  %and438 = and i32 %2, 7
  %mul444 = and i32 %.pre-phi, 4
  %mul458 = and i32 %.pre-phi1086, 8128
  %xor464600 = and i32 %.pre-phi1086, 56
  %call462.masked = and i32 %2, 1016
  %mul465 = xor i32 %xor464600, %call462.masked
  %invariant.gep655 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul458
  %invariant.gep657 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep655, i32 %mul465
  %132 = shl nuw nsw i32 %2, 4
  %mul478 = and i32 %132, 16256
  %add475 = add nuw nsw i32 %add21, %mul478
  %add479 = or disjoint i32 %add475, %xor464600
  %gep661 = getelementptr %struct.__half, ptr addrspace(4) %invariant.gep660, i64 %mul358.pre-phi
  %133 = zext nneg i32 %add479 to i64, !dbg !158
  br i1 %11, label %if.end369, label %if.end398, !dbg !159

if.end369:                                        ; preds = %if.end313
  %134 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.0, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer), !dbg !160
  %135 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.7.0, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer), !dbg !160
  %136 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.9.0, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer), !dbg !160
  %137 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.0, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer), !dbg !160
  %138 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.16.0, <4 x half> %prob.sroa.8.0, <4 x float> %134), !dbg !160
  %139 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.21.0, <4 x half> %prob.sroa.8.0, <4 x float> %135), !dbg !160
  %140 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.23.0, <4 x half> %prob.sroa.8.0, <4 x float> %136), !dbg !160
  %141 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.28.0, <4 x half> %prob.sroa.8.0, <4 x float> %137), !dbg !160
  br label %if.end398, !dbg !161

if.end398:                                        ; preds = %if.end369, %if.end313
  %out.sroa.74.0 = phi <4 x float> [ %141, %if.end369 ], [ zeroinitializer, %if.end313 ], !dbg !53
  %out.sroa.50.0 = phi <4 x float> [ %140, %if.end369 ], [ zeroinitializer, %if.end313 ], !dbg !53
  %out.sroa.26.0 = phi <4 x float> [ %139, %if.end369 ], [ zeroinitializer, %if.end313 ], !dbg !53
  %out.sroa.0.0 = phi <4 x float> [ %138, %if.end369 ], [ zeroinitializer, %if.end313 ], !dbg !53
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 0, !dbg !162
  %142 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract), !dbg !163
  %output_reg.sroa.0.0.insert.ext = zext i16 %142 to i64, !dbg !167
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 1, !dbg !162
  %143 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract), !dbg !163
  %output_reg.sroa.0.2.insert.ext = zext i16 %143 to i64, !dbg !167
  %output_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext, 16, !dbg !167
  %output_reg.sroa.0.2.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.shift, %output_reg.sroa.0.0.insert.ext, !dbg !167
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 2, !dbg !162
  %144 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract), !dbg !163
  %output_reg.sroa.0.4.insert.ext = zext i16 %144 to i64, !dbg !167
  %output_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext, 32, !dbg !167
  %output_reg.sroa.0.4.insert.insert = or disjoint i64 %output_reg.sroa.0.2.insert.insert, %output_reg.sroa.0.4.insert.shift, !dbg !167
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %out.sroa.0.0, i64 3, !dbg !162
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract), !dbg !163
  %output_reg.sroa.0.6.insert.ext = zext i16 %145 to i64, !dbg !167
  %output_reg.sroa.0.6.insert.shift = shl nuw i64 %output_reg.sroa.0.6.insert.ext, 48, !dbg !167
  %output_reg.sroa.0.6.insert.insert = or disjoint i64 %output_reg.sroa.0.4.insert.insert, %output_reg.sroa.0.6.insert.shift, !dbg !167
  %out.sroa.26.16.vec.extract = extractelement <4 x float> %out.sroa.26.0, i64 0, !dbg !162
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.16.vec.extract), !dbg !163
  %output_reg.sroa.12.8.insert.ext = zext i16 %146 to i64, !dbg !167
  %out.sroa.26.20.vec.extract = extractelement <4 x float> %out.sroa.26.0, i64 1, !dbg !162
  %147 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.20.vec.extract), !dbg !163
  %output_reg.sroa.12.10.insert.ext = zext i16 %147 to i64, !dbg !167
  %output_reg.sroa.12.10.insert.shift = shl nuw nsw i64 %output_reg.sroa.12.10.insert.ext, 16, !dbg !167
  %output_reg.sroa.12.10.insert.insert = or disjoint i64 %output_reg.sroa.12.10.insert.shift, %output_reg.sroa.12.8.insert.ext, !dbg !167
  %out.sroa.26.24.vec.extract = extractelement <4 x float> %out.sroa.26.0, i64 2, !dbg !162
  %148 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.24.vec.extract), !dbg !163
  %output_reg.sroa.12.12.insert.ext = zext i16 %148 to i64, !dbg !167
  %output_reg.sroa.12.12.insert.shift = shl nuw nsw i64 %output_reg.sroa.12.12.insert.ext, 32, !dbg !167
  %output_reg.sroa.12.12.insert.insert = or disjoint i64 %output_reg.sroa.12.10.insert.insert, %output_reg.sroa.12.12.insert.shift, !dbg !167
  %out.sroa.26.28.vec.extract = extractelement <4 x float> %out.sroa.26.0, i64 3, !dbg !162
  %149 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.28.vec.extract), !dbg !163
  %output_reg.sroa.12.14.insert.ext = zext i16 %149 to i64, !dbg !167
  %output_reg.sroa.12.14.insert.shift = shl nuw i64 %output_reg.sroa.12.14.insert.ext, 48, !dbg !167
  %output_reg.sroa.12.14.insert.insert = or disjoint i64 %output_reg.sroa.12.12.insert.insert, %output_reg.sroa.12.14.insert.shift, !dbg !167
  %out.sroa.50.32.vec.extract = extractelement <4 x float> %out.sroa.50.0, i64 0, !dbg !162
  %150 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.32.vec.extract), !dbg !163
  %output_reg.sroa.22.16.insert.ext = zext i16 %150 to i64, !dbg !167
  %out.sroa.50.36.vec.extract = extractelement <4 x float> %out.sroa.50.0, i64 1, !dbg !162
  %151 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.36.vec.extract), !dbg !163
  %output_reg.sroa.22.18.insert.ext = zext i16 %151 to i64, !dbg !167
  %output_reg.sroa.22.18.insert.shift = shl nuw nsw i64 %output_reg.sroa.22.18.insert.ext, 16, !dbg !167
  %output_reg.sroa.22.18.insert.insert = or disjoint i64 %output_reg.sroa.22.18.insert.shift, %output_reg.sroa.22.16.insert.ext, !dbg !167
  %out.sroa.50.40.vec.extract = extractelement <4 x float> %out.sroa.50.0, i64 2, !dbg !162
  %152 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.40.vec.extract), !dbg !163
  %output_reg.sroa.22.20.insert.ext = zext i16 %152 to i64, !dbg !167
  %output_reg.sroa.22.20.insert.shift = shl nuw nsw i64 %output_reg.sroa.22.20.insert.ext, 32, !dbg !167
  %output_reg.sroa.22.20.insert.insert = or disjoint i64 %output_reg.sroa.22.18.insert.insert, %output_reg.sroa.22.20.insert.shift, !dbg !167
  %out.sroa.50.44.vec.extract = extractelement <4 x float> %out.sroa.50.0, i64 3, !dbg !162
  %153 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.44.vec.extract), !dbg !163
  %output_reg.sroa.22.22.insert.ext = zext i16 %153 to i64, !dbg !167
  %output_reg.sroa.22.22.insert.shift = shl nuw i64 %output_reg.sroa.22.22.insert.ext, 48, !dbg !167
  %output_reg.sroa.22.22.insert.insert = or disjoint i64 %output_reg.sroa.22.20.insert.insert, %output_reg.sroa.22.22.insert.shift, !dbg !167
  %out.sroa.74.48.vec.extract = extractelement <4 x float> %out.sroa.74.0, i64 0, !dbg !162
  %154 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.48.vec.extract), !dbg !163
  %output_reg.sroa.32.24.insert.ext = zext i16 %154 to i64, !dbg !167
  %out.sroa.74.52.vec.extract = extractelement <4 x float> %out.sroa.74.0, i64 1, !dbg !162
  %155 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.52.vec.extract), !dbg !163
  %output_reg.sroa.32.26.insert.ext = zext i16 %155 to i64, !dbg !167
  %output_reg.sroa.32.26.insert.shift = shl nuw nsw i64 %output_reg.sroa.32.26.insert.ext, 16, !dbg !167
  %output_reg.sroa.32.26.insert.insert = or disjoint i64 %output_reg.sroa.32.26.insert.shift, %output_reg.sroa.32.24.insert.ext, !dbg !167
  %out.sroa.74.56.vec.extract = extractelement <4 x float> %out.sroa.74.0, i64 2, !dbg !162
  %156 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.56.vec.extract), !dbg !163
  %output_reg.sroa.32.28.insert.ext = zext i16 %156 to i64, !dbg !167
  %output_reg.sroa.32.28.insert.shift = shl nuw nsw i64 %output_reg.sroa.32.28.insert.ext, 32, !dbg !167
  %output_reg.sroa.32.28.insert.insert = or disjoint i64 %output_reg.sroa.32.26.insert.insert, %output_reg.sroa.32.28.insert.shift, !dbg !167
  %out.sroa.74.60.vec.extract = extractelement <4 x float> %out.sroa.74.0, i64 3, !dbg !162
  %157 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.60.vec.extract), !dbg !163
  %output_reg.sroa.32.30.insert.ext = zext i16 %157 to i64, !dbg !167
  %output_reg.sroa.32.30.insert.shift = shl nuw i64 %output_reg.sroa.32.30.insert.ext, 48, !dbg !167
  %output_reg.sroa.32.30.insert.insert = or disjoint i64 %output_reg.sroa.32.28.insert.insert, %output_reg.sroa.32.30.insert.shift, !dbg !167
  fence syncscope("warp") release, !dbg !168
  tail call void @llvm.mxc.barrier.warp(), !dbg !173
  fence syncscope("warp") acquire, !dbg !174
  %xor = xor i32 %shr435, %and438, !dbg !175
  %mul439 = shl nuw nsw i32 %xor, 3, !dbg !176
  %add440 = add nuw nsw i32 %mul439, %mul432, !dbg !177
  %add445 = or disjoint i32 %add440, %mul444, !dbg !178
  %add.ptr447 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add445, !dbg !179
  store i64 %output_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr447, align 8, !dbg !180
  %add436.1 = add nuw nsw i32 %shr435, 2, !dbg !181
  %xor.1 = xor i32 %add436.1, %and438, !dbg !175
  %mul439.1 = shl nuw nsw i32 %xor.1, 3, !dbg !176
  %add440.1 = add nuw nsw i32 %mul439.1, %mul432, !dbg !177
  %add445.1 = or disjoint i32 %add440.1, %mul444, !dbg !178
  %add.ptr447.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add445.1, !dbg !179
  store i64 %output_reg.sroa.12.14.insert.insert, ptr addrspace(3) %add.ptr447.1, align 8, !dbg !180
  %add436.2 = add nuw nsw i32 %shr435, 4, !dbg !181
  %xor.2 = xor i32 %add436.2, %and438, !dbg !175
  %mul439.2 = shl nuw nsw i32 %xor.2, 3, !dbg !176
  %add440.2 = add nuw nsw i32 %mul439.2, %mul432, !dbg !177
  %add445.2 = or disjoint i32 %add440.2, %mul444, !dbg !178
  %add.ptr447.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add445.2, !dbg !179
  store i64 %output_reg.sroa.22.22.insert.insert, ptr addrspace(3) %add.ptr447.2, align 8, !dbg !180
  %add436.3 = add nuw nsw i32 %shr435, 6, !dbg !181
  %xor.3 = xor i32 %add436.3, %and438, !dbg !175
  %mul439.3 = shl nuw nsw i32 %xor.3, 3, !dbg !176
  %add440.3 = add nuw nsw i32 %mul439.3, %mul432, !dbg !177
  %add445.3 = or disjoint i32 %add440.3, %mul444, !dbg !178
  %add.ptr447.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add445.3, !dbg !179
  store i64 %output_reg.sroa.32.30.insert.insert, ptr addrspace(3) %add.ptr447.3, align 8, !dbg !180
  fence syncscope("warp") release, !dbg !182
  tail call void @llvm.mxc.barrier.warp(), !dbg !185
  fence syncscope("warp") acquire, !dbg !186
  %add.ptr487 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %133, !dbg !187
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr487, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep657, i64 16, i1 false), !dbg !188, !tbaa.struct !189, !call_argsrelate !190
  %gep658.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep657, i32 1024, !dbg !191
  %158 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %133, !dbg !187
  %add.ptr487.1 = getelementptr inbounds i8, ptr addrspace(1) %158, i64 2048, !dbg !187
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr487.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep658.1, i64 16, i1 false), !dbg !188, !tbaa.struct !189, !call_argsrelate !190
  br i1 %11, label %if.end369.1, label %if.end398.1, !dbg !159

if.end369.1:                                      ; preds = %if.end398
  %add348.3.1 = add nuw nsw i64 %add344.pre-phi, 3072, !dbg !192
  %add351.3.1 = or i64 %add348.3.1, 1536, !dbg !193
  %gep648.3.1 = getelementptr %struct.__half, ptr addrspace(4) %gep661, i64 %add351.3.1, !dbg !194
  %v.sroa.28.48.gep648.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep648.3.1, i64 8, !dbg !195
  %v.sroa.28.48.copyload955 = load <4 x half>, ptr addrspace(4) %v.sroa.28.48.gep648.3.1.sroa_idx, align 8, !dbg !195
  %v.sroa.23.48.copyload953 = load <4 x half>, ptr addrspace(4) %gep648.3.1, align 16, !dbg !195
  %159 = or i64 %add344.pre-phi, 1024, !dbg !193
  %160 = getelementptr %struct.__half, ptr addrspace(4) %gep661, i64 %159, !dbg !194
  %v.sroa.21.32.gep648.2.1.sroa_idx = getelementptr i8, ptr addrspace(4) %160, i64 4104, !dbg !195
  %v.sroa.21.32.copyload949 = load <4 x half>, ptr addrspace(4) %v.sroa.21.32.gep648.2.1.sroa_idx, align 8, !dbg !195
  %gep648.2.1 = getelementptr i8, ptr addrspace(4) %160, i64 4096, !dbg !194
  %v.sroa.16.32.copyload947 = load <4 x half>, ptr addrspace(4) %gep648.2.1, align 16, !dbg !195
  %161 = or i64 %add344.pre-phi, 512, !dbg !193
  %add351.1.1 = add nuw nsw i64 %161, 1024, !dbg !193
  %add355.1.1 = or i64 %add351.1.1, 1024, !dbg !193
  %gep648.1.1 = getelementptr %struct.__half, ptr addrspace(4) %gep661, i64 %add355.1.1, !dbg !194
  %v.sroa.14.16.gep648.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep648.1.1, i64 8, !dbg !195
  %v.sroa.14.16.copyload943 = load <4 x half>, ptr addrspace(4) %v.sroa.14.16.gep648.1.1.sroa_idx, align 8, !dbg !195
  %v.sroa.9.16.copyload941 = load <4 x half>, ptr addrspace(4) %gep648.1.1, align 16, !dbg !195
  %add355.1734 = or i64 %add344.pre-phi, 1024, !dbg !193
  %gep648.1735 = getelementptr %struct.__half, ptr addrspace(4) %gep661, i64 %add355.1734, !dbg !194
  %v.sroa.7.0.gep648.1735.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %gep648.1735, i64 8, !dbg !195
  %v.sroa.7.0.copyload937 = load <4 x half>, ptr addrspace(4) %v.sroa.7.0.gep648.1735.sroa_idx, align 8, !dbg !195
  %v.sroa.0.0.copyload935 = load <4 x half>, ptr addrspace(4) %gep648.1735, align 16, !dbg !195
  %162 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.0.0.copyload935, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer), !dbg !160, !call_argsrelate !83
  %163 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.7.0.copyload937, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer), !dbg !160, !call_argsrelate !83
  %164 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.9.16.copyload941, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer), !dbg !160, !call_argsrelate !83
  %165 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.14.16.copyload943, <4 x half> %prob.sroa.0.0, <4 x float> zeroinitializer), !dbg !160, !call_argsrelate !83
  %166 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.16.32.copyload947, <4 x half> %prob.sroa.8.0, <4 x float> %162), !dbg !160, !call_argsrelate !83
  %167 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.21.32.copyload949, <4 x half> %prob.sroa.8.0, <4 x float> %163), !dbg !160, !call_argsrelate !83
  %168 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.23.48.copyload953, <4 x half> %prob.sroa.8.0, <4 x float> %164), !dbg !160, !call_argsrelate !83
  %169 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %v.sroa.28.48.copyload955, <4 x half> %prob.sroa.8.0, <4 x float> %165), !dbg !160, !call_argsrelate !83
  br label %if.end398.1, !dbg !161

if.end398.1:                                      ; preds = %if.end369.1, %if.end398
  %out.sroa.74.1 = phi <4 x float> [ %169, %if.end369.1 ], [ zeroinitializer, %if.end398 ], !dbg !53
  %out.sroa.50.1 = phi <4 x float> [ %168, %if.end369.1 ], [ zeroinitializer, %if.end398 ], !dbg !53
  %out.sroa.26.1 = phi <4 x float> [ %167, %if.end369.1 ], [ zeroinitializer, %if.end398 ], !dbg !53
  %out.sroa.0.1 = phi <4 x float> [ %166, %if.end369.1 ], [ zeroinitializer, %if.end398 ], !dbg !53
  %out.sroa.0.0.vec.extract841 = extractelement <4 x float> %out.sroa.0.1, i64 0, !dbg !162
  %170 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.0.vec.extract841), !dbg !163
  %output_reg.sroa.0.0.insert.ext755 = zext i16 %170 to i64, !dbg !167
  %out.sroa.0.4.vec.extract846 = extractelement <4 x float> %out.sroa.0.1, i64 1, !dbg !162
  %171 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.4.vec.extract846), !dbg !163
  %output_reg.sroa.0.2.insert.ext759 = zext i16 %171 to i64, !dbg !167
  %output_reg.sroa.0.2.insert.shift760 = shl nuw nsw i64 %output_reg.sroa.0.2.insert.ext759, 16, !dbg !167
  %output_reg.sroa.0.2.insert.insert762 = or disjoint i64 %output_reg.sroa.0.2.insert.shift760, %output_reg.sroa.0.0.insert.ext755, !dbg !167
  %out.sroa.0.8.vec.extract851 = extractelement <4 x float> %out.sroa.0.1, i64 2, !dbg !162
  %172 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.8.vec.extract851), !dbg !163
  %output_reg.sroa.0.4.insert.ext764 = zext i16 %172 to i64, !dbg !167
  %output_reg.sroa.0.4.insert.shift765 = shl nuw nsw i64 %output_reg.sroa.0.4.insert.ext764, 32, !dbg !167
  %output_reg.sroa.0.4.insert.insert767 = or disjoint i64 %output_reg.sroa.0.2.insert.insert762, %output_reg.sroa.0.4.insert.shift765, !dbg !167
  %out.sroa.0.12.vec.extract856 = extractelement <4 x float> %out.sroa.0.1, i64 3, !dbg !162
  %173 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.0.12.vec.extract856), !dbg !163
  %output_reg.sroa.0.6.insert.ext769 = zext i16 %173 to i64, !dbg !167
  %output_reg.sroa.0.6.insert.shift770 = shl nuw i64 %output_reg.sroa.0.6.insert.ext769, 48, !dbg !167
  %output_reg.sroa.0.6.insert.insert772 = or disjoint i64 %output_reg.sroa.0.4.insert.insert767, %output_reg.sroa.0.6.insert.shift770, !dbg !167
  %out.sroa.26.16.vec.extract865 = extractelement <4 x float> %out.sroa.26.1, i64 0, !dbg !162
  %174 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.16.vec.extract865), !dbg !163
  %output_reg.sroa.12.8.insert.ext775 = zext i16 %174 to i64, !dbg !167
  %out.sroa.26.20.vec.extract870 = extractelement <4 x float> %out.sroa.26.1, i64 1, !dbg !162
  %175 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.20.vec.extract870), !dbg !163
  %output_reg.sroa.12.10.insert.ext779 = zext i16 %175 to i64, !dbg !167
  %output_reg.sroa.12.10.insert.shift780 = shl nuw nsw i64 %output_reg.sroa.12.10.insert.ext779, 16, !dbg !167
  %output_reg.sroa.12.10.insert.insert782 = or disjoint i64 %output_reg.sroa.12.10.insert.shift780, %output_reg.sroa.12.8.insert.ext775, !dbg !167
  %out.sroa.26.24.vec.extract875 = extractelement <4 x float> %out.sroa.26.1, i64 2, !dbg !162
  %176 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.24.vec.extract875), !dbg !163
  %output_reg.sroa.12.12.insert.ext784 = zext i16 %176 to i64, !dbg !167
  %output_reg.sroa.12.12.insert.shift785 = shl nuw nsw i64 %output_reg.sroa.12.12.insert.ext784, 32, !dbg !167
  %output_reg.sroa.12.12.insert.insert787 = or disjoint i64 %output_reg.sroa.12.10.insert.insert782, %output_reg.sroa.12.12.insert.shift785, !dbg !167
  %out.sroa.26.28.vec.extract880 = extractelement <4 x float> %out.sroa.26.1, i64 3, !dbg !162
  %177 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.26.28.vec.extract880), !dbg !163
  %output_reg.sroa.12.14.insert.ext789 = zext i16 %177 to i64, !dbg !167
  %output_reg.sroa.12.14.insert.shift790 = shl nuw i64 %output_reg.sroa.12.14.insert.ext789, 48, !dbg !167
  %output_reg.sroa.12.14.insert.insert792 = or disjoint i64 %output_reg.sroa.12.12.insert.insert787, %output_reg.sroa.12.14.insert.shift790, !dbg !167
  %out.sroa.50.32.vec.extract889 = extractelement <4 x float> %out.sroa.50.1, i64 0, !dbg !162
  %178 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.32.vec.extract889), !dbg !163
  %output_reg.sroa.22.16.insert.ext795 = zext i16 %178 to i64, !dbg !167
  %out.sroa.50.36.vec.extract894 = extractelement <4 x float> %out.sroa.50.1, i64 1, !dbg !162
  %179 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.36.vec.extract894), !dbg !163
  %output_reg.sroa.22.18.insert.ext799 = zext i16 %179 to i64, !dbg !167
  %output_reg.sroa.22.18.insert.shift800 = shl nuw nsw i64 %output_reg.sroa.22.18.insert.ext799, 16, !dbg !167
  %output_reg.sroa.22.18.insert.insert802 = or disjoint i64 %output_reg.sroa.22.18.insert.shift800, %output_reg.sroa.22.16.insert.ext795, !dbg !167
  %out.sroa.50.40.vec.extract899 = extractelement <4 x float> %out.sroa.50.1, i64 2, !dbg !162
  %180 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.40.vec.extract899), !dbg !163
  %output_reg.sroa.22.20.insert.ext804 = zext i16 %180 to i64, !dbg !167
  %output_reg.sroa.22.20.insert.shift805 = shl nuw nsw i64 %output_reg.sroa.22.20.insert.ext804, 32, !dbg !167
  %output_reg.sroa.22.20.insert.insert807 = or disjoint i64 %output_reg.sroa.22.18.insert.insert802, %output_reg.sroa.22.20.insert.shift805, !dbg !167
  %out.sroa.50.44.vec.extract904 = extractelement <4 x float> %out.sroa.50.1, i64 3, !dbg !162
  %181 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.50.44.vec.extract904), !dbg !163
  %output_reg.sroa.22.22.insert.ext809 = zext i16 %181 to i64, !dbg !167
  %output_reg.sroa.22.22.insert.shift810 = shl nuw i64 %output_reg.sroa.22.22.insert.ext809, 48, !dbg !167
  %output_reg.sroa.22.22.insert.insert812 = or disjoint i64 %output_reg.sroa.22.20.insert.insert807, %output_reg.sroa.22.22.insert.shift810, !dbg !167
  %out.sroa.74.48.vec.extract913 = extractelement <4 x float> %out.sroa.74.1, i64 0, !dbg !162
  %182 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.48.vec.extract913), !dbg !163
  %output_reg.sroa.32.24.insert.ext815 = zext i16 %182 to i64, !dbg !167
  %out.sroa.74.52.vec.extract918 = extractelement <4 x float> %out.sroa.74.1, i64 1, !dbg !162
  %183 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.52.vec.extract918), !dbg !163
  %output_reg.sroa.32.26.insert.ext819 = zext i16 %183 to i64, !dbg !167
  %output_reg.sroa.32.26.insert.shift820 = shl nuw nsw i64 %output_reg.sroa.32.26.insert.ext819, 16, !dbg !167
  %output_reg.sroa.32.26.insert.insert822 = or disjoint i64 %output_reg.sroa.32.26.insert.shift820, %output_reg.sroa.32.24.insert.ext815, !dbg !167
  %out.sroa.74.56.vec.extract923 = extractelement <4 x float> %out.sroa.74.1, i64 2, !dbg !162
  %184 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.56.vec.extract923), !dbg !163
  %output_reg.sroa.32.28.insert.ext824 = zext i16 %184 to i64, !dbg !167
  %output_reg.sroa.32.28.insert.shift825 = shl nuw nsw i64 %output_reg.sroa.32.28.insert.ext824, 32, !dbg !167
  %output_reg.sroa.32.28.insert.insert827 = or disjoint i64 %output_reg.sroa.32.26.insert.insert822, %output_reg.sroa.32.28.insert.shift825, !dbg !167
  %out.sroa.74.60.vec.extract928 = extractelement <4 x float> %out.sroa.74.1, i64 3, !dbg !162
  %185 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %out.sroa.74.60.vec.extract928), !dbg !163
  %output_reg.sroa.32.30.insert.ext829 = zext i16 %185 to i64, !dbg !167
  %output_reg.sroa.32.30.insert.shift830 = shl nuw i64 %output_reg.sroa.32.30.insert.ext829, 48, !dbg !167
  %output_reg.sroa.32.30.insert.insert832 = or disjoint i64 %output_reg.sroa.32.28.insert.insert827, %output_reg.sroa.32.30.insert.shift830, !dbg !167
  fence syncscope("warp") release, !dbg !168
  tail call void @llvm.mxc.barrier.warp(), !dbg !173
  fence syncscope("warp") acquire, !dbg !174
  store i64 %output_reg.sroa.0.6.insert.insert772, ptr addrspace(3) %add.ptr447, align 8, !dbg !180
  store i64 %output_reg.sroa.12.14.insert.insert792, ptr addrspace(3) %add.ptr447.1, align 8, !dbg !180
  store i64 %output_reg.sroa.22.22.insert.insert812, ptr addrspace(3) %add.ptr447.2, align 8, !dbg !180
  store i64 %output_reg.sroa.32.30.insert.insert832, ptr addrspace(3) %add.ptr447.3, align 8, !dbg !180
  fence syncscope("warp") release, !dbg !182
  tail call void @llvm.mxc.barrier.warp(), !dbg !185
  fence syncscope("warp") acquire, !dbg !186
  %186 = or disjoint i64 %133, 64
  %add.ptr487.1752 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %186, !dbg !187
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr487.1752, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep657, i64 16, i1 false), !dbg !188, !tbaa.struct !189, !call_argsrelate !190
  %187 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %133, !dbg !187
  %add.ptr487.1.1 = getelementptr inbounds i8, ptr addrspace(1) %187, i64 2176, !dbg !187
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr487.1.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep658.1, i64 16, i1 false), !dbg !188, !tbaa.struct !189, !call_argsrelate !190
  ret void, !dbg !196
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

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare i16 @llvm.convert.to.fp16.f32(float) #6

; Function Attrs: convergent nounwind willreturn
declare void @llvm.mxc.barrier.warp() #7

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
!1 = !DIFile(filename: "/tmp/tmpenngwf_3/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpenngwf_3/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 24, column: 3, scope: !40)
!44 = !DILocation(line: 27, column: 84, scope: !40)
!45 = !DILocation(line: 27, column: 70, scope: !40)
!46 = !DILocation(line: 30, column: 43, scope: !40)
!47 = !DILocation(line: 30, column: 51, scope: !40)
!48 = !DILocation(line: 30, column: 15, scope: !40)
!49 = !DILocation(line: 31, column: 21, scope: !40)
!50 = !DILocation(line: 31, column: 31, scope: !40)
!51 = !DILocation(line: 31, column: 41, scope: !40)
!52 = !DILocation(line: 31, column: 48, scope: !40)
!53 = !DILocation(line: 0, scope: !40)
!54 = !DILocation(line: 32, column: 7, scope: !40)
!55 = !DILocation(line: 34, column: 5, scope: !40)
!56 = !DILocation(line: 35, column: 51, scope: !40)
!57 = !DILocation(line: 35, column: 30, scope: !40)
!58 = !DILocation(line: 171, column: 37, scope: !59, inlinedAt: !61)
!59 = distinct !DISubprogram(name: "__lane_id", scope: !60, file: !60, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!60 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!61 = distinct !DILocation(line: 990, column: 14, scope: !62, inlinedAt: !63)
!62 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !60, file: !60, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!63 = distinct !DILocation(line: 1006, column: 11, scope: !64, inlinedAt: !65)
!64 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !60, file: !60, line: 996, type: !7, scopeLine: 999, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!65 = distinct !DILocation(line: 49, column: 21, scope: !40)
!66 = !DILocation(line: 171, column: 10, scope: !59, inlinedAt: !61)
!67 = !DILocation(line: 991, column: 20, scope: !62, inlinedAt: !63)
!68 = !DILocation(line: 992, column: 36, scope: !62, inlinedAt: !63)
!69 = !DILocation(line: 992, column: 17, scope: !62, inlinedAt: !63)
!70 = !DILocation(line: 992, column: 11, scope: !62, inlinedAt: !63)
!71 = !DILocation(line: 993, column: 43, scope: !62, inlinedAt: !63)
!72 = !DILocation(line: 993, column: 10, scope: !62, inlinedAt: !63)
!73 = !DILocation(line: 51, column: 13, scope: !40)
!74 = !DILocation(line: 58, column: 13, scope: !40)
!75 = !DILocation(line: 70, column: 37, scope: !40)
!76 = !DILocation(line: 76, column: 114, scope: !40)
!77 = !DILocation(line: 76, column: 11, scope: !40)
!78 = !DILocation(line: 81, column: 19, scope: !40)
!79 = !DILocation(line: 76, column: 66, scope: !40)
!80 = !DILocation(line: 76, column: 101, scope: !40)
!81 = !DILocation(line: 83, column: 5, scope: !40)
!82 = !DILocation(line: 87, column: 37, scope: !40)
!83 = !{i32 2, i32 -1, i32 -1}
!84 = !DILocation(line: 95, column: 5, scope: !40)
!85 = !DILocation(line: 96, column: 53, scope: !40)
!86 = !DILocation(line: 96, column: 32, scope: !40)
!87 = !DILocation(line: 96, column: 199, scope: !40)
!88 = !DILocation(line: 96, column: 147, scope: !40)
!89 = !DILocation(line: 100, column: 32, scope: !40)
!90 = !DILocation(line: 100, column: 44, scope: !40)
!91 = !DILocation(line: 354, column: 10, scope: !92, inlinedAt: !94)
!92 = distinct !DISubprogram(name: "min", scope: !93, file: !93, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!93 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!94 = distinct !DILocation(line: 100, column: 27, scope: !40)
!95 = !DILocation(line: 285, column: 49, scope: !96, inlinedAt: !97)
!96 = distinct !DISubprogram(name: "exp2f", scope: !93, file: !93, line: 285, type: !7, scopeLine: 285, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!97 = distinct !DILocation(line: 100, column: 21, scope: !40)
!98 = !DILocation(line: 105, column: 28, scope: !40)
!99 = !DILocation(line: 1018, column: 9, scope: !100, inlinedAt: !101)
!100 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !60, file: !60, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!101 = distinct !DILocation(line: 396, column: 10, scope: !102, inlinedAt: !104)
!102 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !103, file: !103, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!103 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!104 = distinct !DILocation(line: 129, column: 24, scope: !105, inlinedAt: !107)
!105 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !106, file: !106, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!106 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!107 = distinct !DILocation(line: 101, column: 14, scope: !108, inlinedAt: !109)
!108 = distinct !DISubprogram(name: "run<float>", scope: !106, file: !106, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!109 = distinct !DILocation(line: 107, column: 16, scope: !40)
!110 = !DILocation(line: 171, column: 37, scope: !59, inlinedAt: !111)
!111 = distinct !DILocation(line: 990, column: 14, scope: !62, inlinedAt: !112)
!112 = distinct !DILocation(line: 1019, column: 11, scope: !100, inlinedAt: !101)
!113 = !DILocation(line: 171, column: 10, scope: !59, inlinedAt: !111)
!114 = !DILocation(line: 991, column: 20, scope: !62, inlinedAt: !112)
!115 = !DILocation(line: 992, column: 36, scope: !62, inlinedAt: !112)
!116 = !DILocation(line: 992, column: 17, scope: !62, inlinedAt: !112)
!117 = !DILocation(line: 992, column: 11, scope: !62, inlinedAt: !112)
!118 = !DILocation(line: 993, column: 43, scope: !62, inlinedAt: !112)
!119 = !DILocation(line: 993, column: 10, scope: !62, inlinedAt: !112)
!120 = !DILocation(line: 1020, column: 14, scope: !100, inlinedAt: !101)
!121 = !DILocation(line: 25, column: 14, scope: !122, inlinedAt: !123)
!122 = distinct !DISubprogram(name: "operator()<float>", scope: !106, file: !106, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!123 = distinct !DILocation(line: 129, column: 11, scope: !105, inlinedAt: !107)
!124 = !DILocation(line: 1018, column: 9, scope: !100, inlinedAt: !125)
!125 = distinct !DILocation(line: 396, column: 10, scope: !102, inlinedAt: !126)
!126 = distinct !DILocation(line: 129, column: 24, scope: !127, inlinedAt: !128)
!127 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !106, file: !106, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!128 = distinct !DILocation(line: 101, column: 14, scope: !129, inlinedAt: !130)
!129 = distinct !DISubprogram(name: "run<float>", scope: !106, file: !106, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!130 = distinct !DILocation(line: 134, column: 14, scope: !105, inlinedAt: !107)
!131 = !DILocation(line: 171, column: 37, scope: !59, inlinedAt: !132)
!132 = distinct !DILocation(line: 990, column: 14, scope: !62, inlinedAt: !133)
!133 = distinct !DILocation(line: 1019, column: 11, scope: !100, inlinedAt: !125)
!134 = !DILocation(line: 171, column: 10, scope: !59, inlinedAt: !132)
!135 = !DILocation(line: 991, column: 20, scope: !62, inlinedAt: !133)
!136 = !DILocation(line: 992, column: 36, scope: !62, inlinedAt: !133)
!137 = !DILocation(line: 992, column: 17, scope: !62, inlinedAt: !133)
!138 = !DILocation(line: 992, column: 11, scope: !62, inlinedAt: !133)
!139 = !DILocation(line: 993, column: 43, scope: !62, inlinedAt: !133)
!140 = !DILocation(line: 993, column: 10, scope: !62, inlinedAt: !133)
!141 = !DILocation(line: 1020, column: 14, scope: !100, inlinedAt: !125)
!142 = !DILocation(line: 25, column: 14, scope: !122, inlinedAt: !143)
!143 = distinct !DILocation(line: 129, column: 11, scope: !127, inlinedAt: !128)
!144 = !DILocation(line: 109, column: 34, scope: !40)
!145 = !DILocation(line: 109, column: 9, scope: !40)
!146 = !DILocation(line: 117, column: 34, scope: !40)
!147 = !DILocation(line: 75, column: 10, scope: !148, inlinedAt: !150)
!148 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !149, file: !149, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!149 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!150 = distinct !DILocation(line: 984, column: 9, scope: !151, inlinedAt: !153)
!151 = distinct !DISubprogram(name: "__float2half", scope: !152, file: !152, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!152 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!153 = distinct !DILocation(line: 133, column: 53, scope: !154, inlinedAt: !155)
!154 = distinct !DISubprogram(name: "__half", scope: !152, file: !152, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!155 = distinct !DILocation(line: 123, column: 49, scope: !40)
!156 = !DILocation(line: 123, column: 46, scope: !40)
!157 = !DILocation(line: 128, column: 8, scope: !40)
!158 = !DILocation(line: 128, column: 3, scope: !40)
!159 = !DILocation(line: 134, column: 9, scope: !40)
!160 = !DILocation(line: 144, column: 36, scope: !40)
!161 = !DILocation(line: 152, column: 5, scope: !40)
!162 = !DILocation(line: 155, column: 67, scope: !40)
!163 = !DILocation(line: 75, column: 10, scope: !148, inlinedAt: !164)
!164 = distinct !DILocation(line: 984, column: 9, scope: !151, inlinedAt: !165)
!165 = distinct !DILocation(line: 133, column: 53, scope: !154, inlinedAt: !166)
!166 = distinct !DILocation(line: 155, column: 59, scope: !40)
!167 = !DILocation(line: 155, column: 56, scope: !40)
!168 = !DILocation(line: 68, column: 3, scope: !169, inlinedAt: !170)
!169 = distinct !DISubprogram(name: "__barrier_warp", scope: !60, file: !60, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!170 = distinct !DILocation(line: 192, column: 3, scope: !171, inlinedAt: !172)
!171 = distinct !DISubprogram(name: "__syncwarp", scope: !60, file: !60, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!172 = distinct !DILocation(line: 158, column: 5, scope: !40)
!173 = !DILocation(line: 69, column: 3, scope: !169, inlinedAt: !170)
!174 = !DILocation(line: 70, column: 3, scope: !169, inlinedAt: !170)
!175 = !DILocation(line: 161, column: 123, scope: !40)
!176 = !DILocation(line: 161, column: 151, scope: !40)
!177 = !DILocation(line: 161, column: 79, scope: !40)
!178 = !DILocation(line: 161, column: 157, scope: !40)
!179 = !DILocation(line: 161, column: 42, scope: !40)
!180 = !DILocation(line: 161, column: 200, scope: !40)
!181 = !DILocation(line: 161, column: 94, scope: !40)
!182 = !DILocation(line: 68, column: 3, scope: !169, inlinedAt: !183)
!183 = distinct !DILocation(line: 192, column: 3, scope: !171, inlinedAt: !184)
!184 = distinct !DILocation(line: 163, column: 5, scope: !40)
!185 = !DILocation(line: 69, column: 3, scope: !169, inlinedAt: !183)
!186 = !DILocation(line: 70, column: 3, scope: !169, inlinedAt: !183)
!187 = !DILocation(line: 166, column: 24, scope: !40)
!188 = !DILocation(line: 166, column: 192, scope: !40)
!189 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!190 = !{i32 1, i32 -1, i32 -1, i32 -1}
!191 = !DILocation(line: 166, column: 229, scope: !40)
!192 = !DILocation(line: 138, column: 152, scope: !40)
!193 = !DILocation(line: 138, column: 239, scope: !40)
!194 = !DILocation(line: 138, column: 57, scope: !40)
!195 = !DILocation(line: 138, column: 36, scope: !40)
!196 = !DILocation(line: 169, column: 1, scope: !40)
