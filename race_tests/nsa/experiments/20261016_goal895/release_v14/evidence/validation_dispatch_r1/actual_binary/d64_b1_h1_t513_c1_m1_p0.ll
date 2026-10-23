; ModuleID = '/data/tilelang-metax/race_tests/nsa/experiments/20261016_goal895/validation_dispatch_r1/actual_binary/d64_b1_h1_t513_c1_m1_p0.bc'
source_filename = "/tmp/tmp68hbdsqg/tvm_kernels.maca"
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
  %mul8 = shl nuw nsw i32 %1, 3
  %add = add nuw nsw i32 %mul8, %mul
  %2 = zext nneg i32 %add to i64, !dbg !43
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %2, !dbg !44
  %3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %2, !dbg !44
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %3, i64 1024, !dbg !44
  %idxprom = zext nneg i32 %0 to i64, !dbg !45
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom, !dbg !45
  %4 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !45, !tbaa !30
  %mul14 = shl nsw i32 %4, 4, !dbg !46
  %cmp28 = icmp sgt i32 %4, -1, !dbg !47
  br i1 %cmp28, label %land.lhs.true, label %if.end416, !dbg !48

land.lhs.true:                                    ; preds = %entry
  %cmp29 = icmp ugt i32 %4, 32, !dbg !49
  %cmp32.not = icmp sgt i32 %mul14, %0
  %or.cond = select i1 %cmp29, i1 true, i1 %cmp32.not, !dbg !50
  br i1 %or.cond, label %if.end416, label %for.cond33.preheader, !dbg !50

for.cond33.preheader:                             ; preds = %land.lhs.true
  %shr = lshr i32 %1, 3
  %add40 = add nuw nsw i32 %mul14, %shr
  %mul45 = shl nuw nsw i32 %4, 10
  %add46 = add nuw nsw i32 %mul45, %mul8
  %5 = zext nneg i32 %add46 to i64, !dbg !51
  %cmp42 = icmp slt i32 %add40, 513, !dbg !52
  br i1 %cmp42, label %if.then43, label %if.end, !dbg !53

if.then43:                                        ; preds = %for.cond33.preheader
  %add.ptr51 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %5
  %condval.sroa.7.0.add.ptr51.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr51, i64 12
  %condval.sroa.6.0.add.ptr51.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr51, i64 8
  %condval.sroa.5.0.add.ptr51.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr51, i64 4
  %condval.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr51, align 16, !dbg !54, !tbaa !30
  %condval.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval.sroa.5.0.add.ptr51.sroa_idx, align 4, !dbg !54, !tbaa !30
  %condval.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval.sroa.6.0.add.ptr51.sroa_idx, align 8, !dbg !54, !tbaa !30
  %condval.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval.sroa.7.0.add.ptr51.sroa_idx, align 4, !dbg !54, !tbaa !30
  br label %if.end, !dbg !55

if.end:                                           ; preds = %for.cond33.preheader, %if.then43
  %condval.sroa.0.0 = phi i32 [ %condval.sroa.0.0.copyload, %if.then43 ], [ 0, %for.cond33.preheader ], !dbg !56
  %condval.sroa.5.0 = phi i32 [ %condval.sroa.5.0.copyload, %if.then43 ], [ 0, %for.cond33.preheader ], !dbg !56
  %condval.sroa.6.0 = phi i32 [ %condval.sroa.6.0.copyload, %if.then43 ], [ 0, %for.cond33.preheader ], !dbg !56
  %condval.sroa.7.0 = phi i32 [ %condval.sroa.7.0.copyload, %if.then43 ], [ 0, %for.cond33.preheader ], !dbg !56
  %cmp42.1 = icmp slt i32 %add40, 505, !dbg !52
  br i1 %cmp42.1, label %if.then43.1, label %if.end.1, !dbg !53

if.then43.1:                                      ; preds = %if.end
  %6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %5
  %add.ptr51.1 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 1024
  %condval.sroa.7.0.add.ptr51.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 1036
  %condval.sroa.6.0.add.ptr51.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 1032
  %condval.sroa.5.0.add.ptr51.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 1028
  %condval.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr51.1, align 16, !dbg !54, !tbaa !30
  %condval.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval.sroa.5.0.add.ptr51.sroa_idx.1, align 4, !dbg !54, !tbaa !30
  %condval.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval.sroa.6.0.add.ptr51.sroa_idx.1, align 8, !dbg !54, !tbaa !30
  %condval.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval.sroa.7.0.add.ptr51.sroa_idx.1, align 4, !dbg !54, !tbaa !30
  br label %if.end.1, !dbg !55

if.end.1:                                         ; preds = %if.then43.1, %if.end
  %condval.sroa.0.0.1 = phi i32 [ %condval.sroa.0.0.copyload.1, %if.then43.1 ], [ 0, %if.end ], !dbg !56
  %condval.sroa.5.0.1 = phi i32 [ %condval.sroa.5.0.copyload.1, %if.then43.1 ], [ 0, %if.end ], !dbg !56
  %condval.sroa.6.0.1 = phi i32 [ %condval.sroa.6.0.copyload.1, %if.then43.1 ], [ 0, %if.end ], !dbg !56
  %condval.sroa.7.0.1 = phi i32 [ %condval.sroa.7.0.copyload.1, %if.then43.1 ], [ 0, %if.end ], !dbg !56
  br i1 %cmp42, label %if.then90, label %if.end122, !dbg !57

if.then90:                                        ; preds = %if.end.1
  %add.ptr98 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %5
  %condval_1.sroa.7.0.add.ptr98.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr98, i64 12
  %condval_1.sroa.6.0.add.ptr98.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr98, i64 8
  %condval_1.sroa.5.0.add.ptr98.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr98, i64 4
  %condval_1.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr98, align 16, !dbg !58, !tbaa !30
  %condval_1.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr98.sroa_idx, align 4, !dbg !58, !tbaa !30
  %condval_1.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr98.sroa_idx, align 8, !dbg !58, !tbaa !30
  %condval_1.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr98.sroa_idx, align 4, !dbg !58, !tbaa !30
  br label %if.end122, !dbg !59

if.end122:                                        ; preds = %if.end.1, %if.then90
  %condval_1.sroa.0.0 = phi i32 [ %condval_1.sroa.0.0.copyload, %if.then90 ], [ 0, %if.end.1 ], !dbg !56
  %condval_1.sroa.5.0 = phi i32 [ %condval_1.sroa.5.0.copyload, %if.then90 ], [ 0, %if.end.1 ], !dbg !56
  %condval_1.sroa.6.0 = phi i32 [ %condval_1.sroa.6.0.copyload, %if.then90 ], [ 0, %if.end.1 ], !dbg !56
  %condval_1.sroa.7.0 = phi i32 [ %condval_1.sroa.7.0.copyload, %if.then90 ], [ 0, %if.end.1 ], !dbg !56
  br i1 %cmp42.1, label %if.then90.1, label %if.end122.1, !dbg !57

if.then90.1:                                      ; preds = %if.end122
  %7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %5
  %add.ptr98.1 = getelementptr inbounds i8, ptr addrspace(4) %7, i64 1024
  %condval_1.sroa.7.0.add.ptr98.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %7, i64 1036
  %condval_1.sroa.6.0.add.ptr98.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %7, i64 1032
  %condval_1.sroa.5.0.add.ptr98.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %7, i64 1028
  %condval_1.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr98.1, align 16, !dbg !58, !tbaa !30
  %condval_1.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr98.sroa_idx.1, align 4, !dbg !58, !tbaa !30
  %condval_1.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr98.sroa_idx.1, align 8, !dbg !58, !tbaa !30
  %condval_1.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr98.sroa_idx.1, align 4, !dbg !58, !tbaa !30
  br label %if.end122.1, !dbg !59

if.end122.1:                                      ; preds = %if.then90.1, %if.end122
  %condval_1.sroa.0.0.1 = phi i32 [ %condval_1.sroa.0.0.copyload.1, %if.then90.1 ], [ 0, %if.end122 ], !dbg !56
  %condval_1.sroa.5.0.1 = phi i32 [ %condval_1.sroa.5.0.copyload.1, %if.then90.1 ], [ 0, %if.end122 ], !dbg !56
  %condval_1.sroa.6.0.1 = phi i32 [ %condval_1.sroa.6.0.copyload.1, %if.then90.1 ], [ 0, %if.end122 ], !dbg !56
  %condval_1.sroa.7.0.1 = phi i32 [ %condval_1.sroa.7.0.copyload.1, %if.then90.1 ], [ 0, %if.end122 ], !dbg !56
  %mul142 = and i32 %mul8, 8128
  %xor548 = and i32 %mul8, 56
  %call145.masked = and i32 %1, 1016
  %mul147 = xor i32 %xor548, %call145.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul142, !dbg !60
  %invariant.gep620 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul147, !dbg !60
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep620, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !dbg !61, !call_argsrelate !62
  %gep621.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep620, i32 1024, !dbg !63
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep621.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !dbg !61, !call_argsrelate !62
  fence syncscope("warp") release, !dbg !64
  tail call void @llvm.mxc.barrier.warp(), !dbg !70
  fence syncscope("warp") acquire, !dbg !71
  %and160 = shl nuw nsw i32 %1, 6
  %mul161 = and i32 %and160, 960
  %shr164 = lshr i32 %1, 4
  %and167 = and i32 %1, 7
  %8 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul161
  %xor168 = xor i32 %shr164, %and167, !dbg !72
  %add.ptr172.idx = shl nuw nsw i32 %xor168, 4, !dbg !73
  %add.ptr172 = getelementptr inbounds i8, ptr addrspace(3) %8, i32 %add.ptr172.idx, !dbg !73
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr172, align 16, !dbg !74
  %Q_reg.sroa.4.0.add.ptr172.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr172, i32 8, !dbg !74
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr172.sroa_idx, align 8, !dbg !74
  %add165.1 = add nuw nsw i32 %shr164, 4, !dbg !75
  %xor168.1 = xor i32 %add165.1, %and167, !dbg !72
  %add.ptr172.idx.1 = shl nuw nsw i32 %xor168.1, 4, !dbg !73
  %add.ptr172.1 = getelementptr inbounds i8, ptr addrspace(3) %8, i32 %add.ptr172.idx.1, !dbg !73
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr172.1, align 16, !dbg !74
  %Q_reg.sroa.7.16.add.ptr172.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr172.1, i32 8, !dbg !74
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr172.1.sroa_idx, align 8, !dbg !74
  fence syncscope("warp") release, !dbg !76
  tail call void @llvm.mxc.barrier.warp(), !dbg !79
  fence syncscope("warp") acquire, !dbg !80
  store i32 %condval.sroa.0.0, ptr addrspace(3) %invariant.gep620, align 16, !dbg !81, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep625.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep620, i32 4, !dbg !81
  store i32 %condval.sroa.5.0, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep625.sroa_idx, align 4, !dbg !81, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep625.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep620, i32 8, !dbg !81
  store i32 %condval.sroa.6.0, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep625.sroa_idx, align 8, !dbg !81, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep625.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep620, i32 12, !dbg !81
  store i32 %condval.sroa.7.0, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep625.sroa_idx, align 4, !dbg !81, !tbaa !30
  store i32 %condval.sroa.0.0.1, ptr addrspace(3) %gep621.1, align 16, !dbg !81, !tbaa !30
  %K_reg.sroa.9.16.gep626.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep620, i32 1028, !dbg !81
  store i32 %condval.sroa.5.0.1, ptr addrspace(3) %K_reg.sroa.9.16.gep626.1.sroa_idx, align 4, !dbg !81, !tbaa !30
  %K_reg.sroa.10.16.gep626.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep620, i32 1032, !dbg !81
  store i32 %condval.sroa.6.0.1, ptr addrspace(3) %K_reg.sroa.10.16.gep626.1.sroa_idx, align 8, !dbg !81, !tbaa !30
  %K_reg.sroa.11.16.gep626.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep620, i32 1036, !dbg !81
  store i32 %condval.sroa.7.0.1, ptr addrspace(3) %K_reg.sroa.11.16.gep626.1.sroa_idx, align 4, !dbg !81, !tbaa !30
  %add207 = or disjoint i32 %mul14, 15, !dbg !82
  %cmp208 = icmp slt i32 %0, %add207, !dbg !83
  br i1 %cmp208, label %for.cond210.preheader, label %if.end236, !dbg !84

for.cond210.preheader:                            ; preds = %if.end122.1
  %9 = lshr i32 %1, 2
  %mul217 = and i32 %9, 252
  %add218 = add nuw nsw i32 %mul14, %mul217
  %cmp221.not = icmp sgt i32 %add218, %0, !dbg !85
  %spec.select = select i1 %cmp221.not, float 0xFFF0000000000000, float 0.000000e+00, !dbg !86
  %acc_s.sroa.0.0.vec.insert687 = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !87
  %cmp221.not.1.not = icmp slt i32 %add218, %0, !dbg !85
  %spec.select.1 = select i1 %cmp221.not.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !86
  %acc_s.sroa.0.4.vec.insert700 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert687, float %spec.select.1, i64 1, !dbg !87
  %add219.2 = or disjoint i32 %add218, 2, !dbg !88
  %cmp221.not.2 = icmp sgt i32 %add219.2, %0, !dbg !85
  %spec.select.2 = select i1 %cmp221.not.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !86
  %acc_s.sroa.0.8.vec.insert713 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert700, float %spec.select.2, i64 2, !dbg !87
  %add219.3 = or disjoint i32 %add218, 3, !dbg !88
  %cmp221.not.3 = icmp sgt i32 %add219.3, %0, !dbg !85
  %spec.select.3 = select i1 %cmp221.not.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !86
  %acc_s.sroa.0.12.vec.insert726 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert713, float %spec.select.3, i64 3, !dbg !87
  br label %if.end236, !dbg !89

if.end236:                                        ; preds = %if.end122.1, %for.cond210.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert726, %for.cond210.preheader ], [ zeroinitializer, %if.end122.1 ], !dbg !56
  fence syncscope("warp") release, !dbg !89
  tail call void @llvm.mxc.barrier.warp(), !dbg !92
  fence syncscope("warp") acquire, !dbg !93
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr172, align 16, !dbg !94
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr172.sroa_idx, align 8, !dbg !94
  %10 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !dbg !95
  %11 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %10), !dbg !95
  %kb.sroa.0.0.copyload681 = load <4 x half>, ptr addrspace(3) %add.ptr172.1, align 16, !dbg !94
  %kb.sroa.6.0.copyload682 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr172.1.sroa_idx, align 8, !dbg !94
  %12 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload681, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %11), !dbg !95
  %13 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload682, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %12), !dbg !95
  fence syncscope("warp") release, !dbg !96
  tail call void @llvm.mxc.barrier.warp(), !dbg !99
  fence syncscope("warp") acquire, !dbg !100
  %add.ptr293.idx = shl nuw nsw i32 %1, 4
  %invariant.gep634 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr293.idx, !dbg !101
  store i32 %condval_1.sroa.0.0, ptr addrspace(3) %invariant.gep634, align 16, !dbg !102, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep634.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep634, i32 4, !dbg !102
  store i32 %condval_1.sroa.5.0, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep634.sroa_idx, align 4, !dbg !102, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep634.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep634, i32 8, !dbg !102
  store i32 %condval_1.sroa.6.0, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep634.sroa_idx, align 8, !dbg !102, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep634.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep634, i32 12, !dbg !102
  store i32 %condval_1.sroa.7.0, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep634.sroa_idx, align 4, !dbg !102, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep634, i32 1024, !dbg !103
  store i32 %condval_1.sroa.0.0.1, ptr addrspace(3) %gep.1, align 16, !dbg !102, !tbaa !30
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep634, i32 1028, !dbg !102
  store i32 %condval_1.sroa.5.0.1, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !dbg !102, !tbaa !30
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep634, i32 1032, !dbg !102
  store i32 %condval_1.sroa.6.0.1, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !dbg !102, !tbaa !30
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep634, i32 1036, !dbg !102
  store i32 %condval_1.sroa.7.0.1, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !dbg !102, !tbaa !30
  %acc_s.sroa.0.0.vec.extract689 = extractelement <4 x float> %13, i64 0, !dbg !104
  %mul303 = fmul contract float %acc_s.sroa.0.0.vec.extract689, 0x3FC2776C60000000, !dbg !105
  %14 = tail call contract noundef float @llvm.minnum.f32(float %mul303, float 1.500000e+01), !dbg !106
  %cmp.i.i = fcmp contract olt float %14, -1.260000e+02, !dbg !110
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00, !dbg !110
  %add.i.i = fadd contract float %14, %cond.i.i, !dbg !110
  %15 = tail call contract float @llvm.exp2.f32(float %add.i.i), !dbg !110
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00, !dbg !110
  %mul.i.i = fmul contract float %cond2.i.i, %15, !dbg !110
  %acc_s.sroa.0.4.vec.extract702 = extractelement <4 x float> %13, i64 1, !dbg !104
  %mul303.1 = fmul contract float %acc_s.sroa.0.4.vec.extract702, 0x3FC2776C60000000, !dbg !105
  %16 = tail call contract noundef float @llvm.minnum.f32(float %mul303.1, float 1.500000e+01), !dbg !106
  %cmp.i.i.1 = fcmp contract olt float %16, -1.260000e+02, !dbg !110
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00, !dbg !110
  %add.i.i.1 = fadd contract float %16, %cond.i.i.1, !dbg !110
  %17 = tail call contract float @llvm.exp2.f32(float %add.i.i.1), !dbg !110
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !110
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %17, !dbg !110
  %acc_s.sroa.0.8.vec.extract715 = extractelement <4 x float> %13, i64 2, !dbg !104
  %mul303.2 = fmul contract float %acc_s.sroa.0.8.vec.extract715, 0x3FC2776C60000000, !dbg !105
  %18 = tail call contract noundef float @llvm.minnum.f32(float %mul303.2, float 1.500000e+01), !dbg !106
  %cmp.i.i.2 = fcmp contract olt float %18, -1.260000e+02, !dbg !110
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00, !dbg !110
  %add.i.i.2 = fadd contract float %18, %cond.i.i.2, !dbg !110
  %19 = tail call contract float @llvm.exp2.f32(float %add.i.i.2), !dbg !110
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00, !dbg !110
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %19, !dbg !110
  %acc_s.sroa.0.12.vec.extract728 = extractelement <4 x float> %13, i64 3, !dbg !104
  %mul303.3 = fmul contract float %acc_s.sroa.0.12.vec.extract728, 0x3FC2776C60000000, !dbg !105
  %20 = tail call contract noundef float @llvm.minnum.f32(float %mul303.3, float 1.500000e+01), !dbg !106
  %cmp.i.i.3 = fcmp contract olt float %20, -1.260000e+02, !dbg !110
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00, !dbg !110
  %add.i.i.3 = fadd contract float %20, %cond.i.i.3, !dbg !110
  %21 = tail call contract float @llvm.exp2.f32(float %add.i.i.3), !dbg !110
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00, !dbg !110
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %21, !dbg !110
  %add319 = fadd contract float %mul.i.i, 0.000000e+00, !dbg !113
  %add319.1 = fadd contract float %add319, %mul.i.i.1, !dbg !113
  %add319.2 = fadd contract float %add319.1, %mul.i.i.2, !dbg !113
  %add319.3 = fadd contract float %add319.2, %mul.i.i.3, !dbg !113
  %22 = bitcast float %add319.3 to i32, !dbg !114
  %23 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !117
  %24 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %23) #11, !dbg !122
  %xor.i.i = xor i32 %24, 32, !dbg !123
  %25 = and i32 %24, -64, !dbg !124
  %and.i.i = add nsw i32 %25, 64, !dbg !124
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !125
  %cond.i.i582 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %24, !dbg !126
  %shl.i.i = shl i32 %cond.i.i582, 2, !dbg !127
  %26 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %22), !dbg !128
  %27 = bitcast i32 %26 to float, !dbg !129
  %add327 = fadd contract float %add319.3, %27, !dbg !130
  %28 = bitcast float %add327 to i32, !dbg !131
  %29 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !133
  %30 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %29) #11, !dbg !136
  %xor.i.i583 = xor i32 %30, 16, !dbg !137
  %31 = and i32 %30, -64, !dbg !138
  %and.i.i584 = add nsw i32 %31, 64, !dbg !138
  %cmp.not.i.i585 = icmp slt i32 %xor.i.i583, %and.i.i584, !dbg !139
  %cond.i.i586 = select i1 %cmp.not.i.i585, i32 %xor.i.i583, i32 %30, !dbg !140
  %shl.i.i587 = shl i32 %cond.i.i586, 2, !dbg !141
  %32 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i587, i32 %28), !dbg !142
  %33 = bitcast i32 %32 to float, !dbg !143
  %add332 = fadd contract float %add327, %33, !dbg !144
  %cmp335 = fcmp contract ogt float %add332, 0.000000e+00, !dbg !145
  %div = fdiv contract float 1.000000e+00, %add332, !dbg !146
  %condval_3.0 = select i1 %cmp335, float %div, float 0.000000e+00, !dbg !146
  %mul348 = fmul contract float %condval_3.0, %mul.i.i, !dbg !147
  %mul348.1 = fmul contract float %condval_3.0, %mul.i.i.1, !dbg !147
  %mul348.2 = fmul contract float %condval_3.0, %mul.i.i.2, !dbg !147
  %mul348.3 = fmul contract float %condval_3.0, %mul.i.i.3, !dbg !147
  %34 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !148
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !148, !noalias !156
  %35 = fptrunc float %mul348 to half, !dbg !148
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %34), !dbg !148, !noalias !156
  %36 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !161
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !161, !noalias !156
  %37 = fptrunc float %mul348.1 to half, !dbg !161
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %36), !dbg !161, !noalias !156
  %__1.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %35, i64 0, !dbg !163
  %__1.sroa.0.2.vec.insert = insertelement <4 x half> %__1.sroa.0.0.vec.insert, half %37, i64 1, !dbg !163
  %38 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !166
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !166, !noalias !170
  %39 = fptrunc float %mul348.2 to half, !dbg !166
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %38), !dbg !166, !noalias !170
  %40 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !175
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !175, !noalias !170
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %40), !dbg !175, !noalias !170
  %__1.sroa.0.4.vec.insert = insertelement <4 x half> %__1.sroa.0.2.vec.insert, half %39, i64 2, !dbg !177
  fence syncscope("warp") release, !dbg !179
  tail call void @llvm.mxc.barrier.warp(), !dbg !182
  fence syncscope("warp") acquire, !dbg !183
  %mul378 = and i32 %add.ptr293.idx, 16128
  %and384 = and i32 %1, 15
  %add385 = or disjoint i32 %mul378, %and384, !dbg !184
  %arrayidx387 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385, !dbg !185
  %41 = load half, ptr addrspace(3) %arrayidx387, align 2, !dbg !186, !tbaa !187
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %41, i64 0, !dbg !186
  %add380.1 = or disjoint i32 %mul378, %and384, !dbg !184
  %add385.1 = or disjoint i32 %add380.1, 64, !dbg !184
  %arrayidx387.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.1, !dbg !185
  %42 = load half, ptr addrspace(3) %arrayidx387.1, align 2, !dbg !186, !tbaa !187
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %42, i64 1, !dbg !186
  %add380.2 = or disjoint i32 %mul378, %and384, !dbg !184
  %add385.2 = or disjoint i32 %add380.2, 128, !dbg !184
  %arrayidx387.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.2, !dbg !185
  %43 = load half, ptr addrspace(3) %arrayidx387.2, align 2, !dbg !186, !tbaa !187
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %43, i64 2, !dbg !186
  %add380.3 = or disjoint i32 %mul378, %and384, !dbg !184
  %add385.3 = or disjoint i32 %add380.3, 192, !dbg !184
  %arrayidx387.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.3, !dbg !185
  %44 = load half, ptr addrspace(3) %arrayidx387.3, align 2, !dbg !186, !tbaa !187
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %44, i64 3, !dbg !186
  %add382.1660 = or disjoint i32 %mul378, %and384, !dbg !184
  %add385.1661 = or disjoint i32 %add382.1660, 16, !dbg !184
  %arrayidx387.1662 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.1661, !dbg !185
  %45 = load half, ptr addrspace(3) %arrayidx387.1662, align 2, !dbg !186, !tbaa !187
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %45, i64 0, !dbg !186
  %add382.1.1 = or disjoint i32 %mul378, %and384, !dbg !184
  %add385.1.1 = or disjoint i32 %add382.1.1, 80, !dbg !184
  %arrayidx387.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.1.1, !dbg !185
  %46 = load half, ptr addrspace(3) %arrayidx387.1.1, align 2, !dbg !186, !tbaa !187
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %46, i64 1, !dbg !186
  %add382.2.1 = or disjoint i32 %mul378, %and384, !dbg !184
  %add385.2.1 = or disjoint i32 %add382.2.1, 144, !dbg !184
  %arrayidx387.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.2.1, !dbg !185
  %47 = load half, ptr addrspace(3) %arrayidx387.2.1, align 2, !dbg !186, !tbaa !187
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %47, i64 2, !dbg !186
  %add382.3.1 = or disjoint i32 %mul378, %and384, !dbg !184
  %add385.3.1 = or disjoint i32 %add382.3.1, 208, !dbg !184
  %arrayidx387.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.3.1, !dbg !185
  %48 = load half, ptr addrspace(3) %arrayidx387.3.1, align 2, !dbg !186, !tbaa !187
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %48, i64 3, !dbg !186
  %add382.2664 = or disjoint i32 %mul378, %and384, !dbg !184
  %add385.2665 = or disjoint i32 %add382.2664, 32, !dbg !184
  %arrayidx387.2666 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.2665, !dbg !185
  %49 = load half, ptr addrspace(3) %arrayidx387.2666, align 2, !dbg !186, !tbaa !187
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %49, i64 0, !dbg !186
  %add382.1.2 = or disjoint i32 %mul378, %and384, !dbg !184
  %add385.1.2 = or disjoint i32 %add382.1.2, 96, !dbg !184
  %arrayidx387.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.1.2, !dbg !185
  %50 = load half, ptr addrspace(3) %arrayidx387.1.2, align 2, !dbg !186, !tbaa !187
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %50, i64 1, !dbg !186
  %add382.2.2 = or disjoint i32 %mul378, %and384, !dbg !184
  %add385.2.2 = or disjoint i32 %add382.2.2, 160, !dbg !184
  %arrayidx387.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.2.2, !dbg !185
  %51 = load half, ptr addrspace(3) %arrayidx387.2.2, align 2, !dbg !186, !tbaa !187
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %51, i64 2, !dbg !186
  %add382.3.2 = or disjoint i32 %mul378, %and384, !dbg !184
  %add385.3.2 = or disjoint i32 %add382.3.2, 224, !dbg !184
  %arrayidx387.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.3.2, !dbg !185
  %52 = load half, ptr addrspace(3) %arrayidx387.3.2, align 2, !dbg !186, !tbaa !187
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %52, i64 3, !dbg !186
  %add382.3668 = or disjoint i32 %mul378, %and384, !dbg !184
  %add385.3669 = or disjoint i32 %add382.3668, 48, !dbg !184
  %arrayidx387.3670 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.3669, !dbg !185
  %53 = load half, ptr addrspace(3) %arrayidx387.3670, align 2, !dbg !186, !tbaa !187
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %53, i64 0, !dbg !186
  %add382.1.3 = or disjoint i32 %mul378, %and384, !dbg !184
  %add385.1.3 = or disjoint i32 %add382.1.3, 112, !dbg !184
  %arrayidx387.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.1.3, !dbg !185
  %54 = load half, ptr addrspace(3) %arrayidx387.1.3, align 2, !dbg !186, !tbaa !187
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %54, i64 1, !dbg !186
  %add382.2.3 = or disjoint i32 %mul378, %and384, !dbg !184
  %add385.2.3 = or disjoint i32 %add382.2.3, 176, !dbg !184
  %arrayidx387.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.2.3, !dbg !185
  %55 = load half, ptr addrspace(3) %arrayidx387.2.3, align 2, !dbg !186, !tbaa !187
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %55, i64 2, !dbg !186
  %add382.3.3 = or disjoint i32 %add.ptr293.idx, %and384, !dbg !184
  %add385.3.3 = or i32 %add382.3.3, 240, !dbg !184
  %arrayidx387.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.3.3, !dbg !185
  %56 = load half, ptr addrspace(3) %arrayidx387.3.3, align 2, !dbg !186, !tbaa !187
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %56, i64 3, !dbg !186
  %57 = fptrunc float %mul348.3 to half, !dbg !175
  %__1.sroa.0.6.vec.insert = insertelement <4 x half> %__1.sroa.0.4.vec.insert, half %57, i64 3, !dbg !177
  %58 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !188
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !188
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !188
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !188
  br label %if.end416

if.end416:                                        ; preds = %if.end236, %land.lhs.true, %entry
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %58, %if.end236 ], [ zeroinitializer, %entry ], !dbg !56
  %acc_o.sroa.12.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %59, %if.end236 ], [ zeroinitializer, %entry ], !dbg !56
  %acc_o.sroa.22.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %60, %if.end236 ], [ zeroinitializer, %entry ], !dbg !56
  %acc_o.sroa.32.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %61, %if.end236 ], [ zeroinitializer, %entry ], !dbg !56
  %and442 = shl nuw nsw i32 %1, 6
  %mul443 = and i32 %and442, 960
  %add444 = or disjoint i32 %mul443, %mul
  %62 = lshr i32 %1, 2
  %mul449 = and i32 %62, 252
  %add446 = add nuw nsw i32 %add444, %mul449
  %63 = zext nneg i32 %add446 to i64, !dbg !189
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0, !dbg !190
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1, !dbg !190
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2, !dbg !190
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3, !dbg !190
  %64 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !191
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !191, !noalias !195
  %65 = fptrunc float %acc_o.sroa.0.0.vec.extract to half, !dbg !191
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %64), !dbg !191, !noalias !195
  %66 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !200
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !200, !noalias !195
  %67 = fptrunc float %acc_o.sroa.0.4.vec.extract to half, !dbg !200
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %66), !dbg !200, !noalias !195
  %68 = bitcast half %65 to i16, !dbg !202
  %69 = bitcast half %67 to i16, !dbg !205
  %70 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !206
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !206, !noalias !210
  %71 = fptrunc float %acc_o.sroa.0.8.vec.extract to half, !dbg !206
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %70), !dbg !206, !noalias !210
  %72 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !215
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !215, !noalias !210
  %73 = fptrunc float %acc_o.sroa.0.12.vec.extract to half, !dbg !215
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %72), !dbg !215, !noalias !210
  %74 = bitcast half %71 to i16, !dbg !217
  %75 = bitcast half %73 to i16, !dbg !219
  %__2.sroa.6.0.insert.ext = zext i16 %75 to i64, !dbg !220
  %__2.sroa.6.0.insert.shift = shl nuw i64 %__2.sroa.6.0.insert.ext, 48, !dbg !220
  %__2.sroa.5.0.insert.ext = zext i16 %74 to i64, !dbg !220
  %__2.sroa.5.0.insert.shift = shl nuw nsw i64 %__2.sroa.5.0.insert.ext, 32, !dbg !220
  %__2.sroa.5.0.insert.insert = or disjoint i64 %__2.sroa.6.0.insert.shift, %__2.sroa.5.0.insert.shift, !dbg !220
  %__2.sroa.4.0.insert.ext = zext i16 %69 to i64, !dbg !220
  %__2.sroa.4.0.insert.shift = shl nuw nsw i64 %__2.sroa.4.0.insert.ext, 16, !dbg !220
  %__2.sroa.4.0.insert.insert = or disjoint i64 %__2.sroa.5.0.insert.insert, %__2.sroa.4.0.insert.shift, !dbg !220
  %__2.sroa.0.0.insert.ext = zext i16 %68 to i64, !dbg !220
  %__2.sroa.0.0.insert.insert = or disjoint i64 %__2.sroa.4.0.insert.insert, %__2.sroa.0.0.insert.ext, !dbg !220
  %add.ptr452 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %63, !dbg !221
  store i64 %__2.sroa.0.0.insert.insert, ptr addrspace(1) %add.ptr452, align 8, !dbg !222
  %acc_o.sroa.12.16.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 0, !dbg !190
  %acc_o.sroa.12.20.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 1, !dbg !190
  %acc_o.sroa.12.24.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 2, !dbg !190
  %acc_o.sroa.12.28.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 3, !dbg !190
  %76 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !191
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !191, !noalias !195
  %77 = fptrunc float %acc_o.sroa.12.16.vec.extract to half, !dbg !191
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %76), !dbg !191, !noalias !195
  %78 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !200
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !200, !noalias !195
  %79 = fptrunc float %acc_o.sroa.12.20.vec.extract to half, !dbg !200
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %78), !dbg !200, !noalias !195
  %80 = bitcast half %77 to i16, !dbg !202
  %81 = bitcast half %79 to i16, !dbg !205
  %82 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !206
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !206, !noalias !210
  %83 = fptrunc float %acc_o.sroa.12.24.vec.extract to half, !dbg !206
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %82), !dbg !206, !noalias !210
  %84 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !215
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !215, !noalias !210
  %85 = fptrunc float %acc_o.sroa.12.28.vec.extract to half, !dbg !215
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %84), !dbg !215, !noalias !210
  %86 = bitcast half %83 to i16, !dbg !217
  %87 = bitcast half %85 to i16, !dbg !219
  %__2.sroa.6.0.insert.ext.1 = zext i16 %87 to i64, !dbg !220
  %__2.sroa.6.0.insert.shift.1 = shl nuw i64 %__2.sroa.6.0.insert.ext.1, 48, !dbg !220
  %__2.sroa.5.0.insert.ext.1 = zext i16 %86 to i64, !dbg !220
  %__2.sroa.5.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.1, 32, !dbg !220
  %__2.sroa.5.0.insert.insert.1 = or disjoint i64 %__2.sroa.6.0.insert.shift.1, %__2.sroa.5.0.insert.shift.1, !dbg !220
  %__2.sroa.4.0.insert.ext.1 = zext i16 %81 to i64, !dbg !220
  %__2.sroa.4.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.1, 16, !dbg !220
  %__2.sroa.4.0.insert.insert.1 = or disjoint i64 %__2.sroa.5.0.insert.insert.1, %__2.sroa.4.0.insert.shift.1, !dbg !220
  %__2.sroa.0.0.insert.ext.1 = zext i16 %80 to i64, !dbg !220
  %__2.sroa.0.0.insert.insert.1 = or disjoint i64 %__2.sroa.4.0.insert.insert.1, %__2.sroa.0.0.insert.ext.1, !dbg !220
  %88 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %63, !dbg !221
  %add.ptr452.1 = getelementptr inbounds i8, ptr addrspace(1) %88, i64 32, !dbg !221
  store i64 %__2.sroa.0.0.insert.insert.1, ptr addrspace(1) %add.ptr452.1, align 8, !dbg !222
  %acc_o.sroa.22.32.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 0, !dbg !190
  %acc_o.sroa.22.36.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 1, !dbg !190
  %acc_o.sroa.22.40.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 2, !dbg !190
  %acc_o.sroa.22.44.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 3, !dbg !190
  %89 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !191
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !191, !noalias !195
  %90 = fptrunc float %acc_o.sroa.22.32.vec.extract to half, !dbg !191
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %89), !dbg !191, !noalias !195
  %91 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !200
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !200, !noalias !195
  %92 = fptrunc float %acc_o.sroa.22.36.vec.extract to half, !dbg !200
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %91), !dbg !200, !noalias !195
  %93 = bitcast half %90 to i16, !dbg !202
  %94 = bitcast half %92 to i16, !dbg !205
  %95 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !206
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !206, !noalias !210
  %96 = fptrunc float %acc_o.sroa.22.40.vec.extract to half, !dbg !206
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %95), !dbg !206, !noalias !210
  %97 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !215
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !215, !noalias !210
  %98 = fptrunc float %acc_o.sroa.22.44.vec.extract to half, !dbg !215
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %97), !dbg !215, !noalias !210
  %99 = bitcast half %96 to i16, !dbg !217
  %100 = bitcast half %98 to i16, !dbg !219
  %__2.sroa.6.0.insert.ext.2 = zext i16 %100 to i64, !dbg !220
  %__2.sroa.6.0.insert.shift.2 = shl nuw i64 %__2.sroa.6.0.insert.ext.2, 48, !dbg !220
  %__2.sroa.5.0.insert.ext.2 = zext i16 %99 to i64, !dbg !220
  %__2.sroa.5.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.2, 32, !dbg !220
  %__2.sroa.5.0.insert.insert.2 = or disjoint i64 %__2.sroa.6.0.insert.shift.2, %__2.sroa.5.0.insert.shift.2, !dbg !220
  %__2.sroa.4.0.insert.ext.2 = zext i16 %94 to i64, !dbg !220
  %__2.sroa.4.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.2, 16, !dbg !220
  %__2.sroa.4.0.insert.insert.2 = or disjoint i64 %__2.sroa.5.0.insert.insert.2, %__2.sroa.4.0.insert.shift.2, !dbg !220
  %__2.sroa.0.0.insert.ext.2 = zext i16 %93 to i64, !dbg !220
  %__2.sroa.0.0.insert.insert.2 = or disjoint i64 %__2.sroa.4.0.insert.insert.2, %__2.sroa.0.0.insert.ext.2, !dbg !220
  %101 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %63, !dbg !221
  %add.ptr452.2 = getelementptr inbounds i8, ptr addrspace(1) %101, i64 64, !dbg !221
  store i64 %__2.sroa.0.0.insert.insert.2, ptr addrspace(1) %add.ptr452.2, align 8, !dbg !222
  %acc_o.sroa.32.48.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 0, !dbg !190
  %acc_o.sroa.32.52.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 1, !dbg !190
  %acc_o.sroa.32.56.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 2, !dbg !190
  %acc_o.sroa.32.60.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 3, !dbg !190
  %102 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !191
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !191, !noalias !195
  %103 = fptrunc float %acc_o.sroa.32.48.vec.extract to half, !dbg !191
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %102), !dbg !191, !noalias !195
  %104 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !200
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !200, !noalias !195
  %105 = fptrunc float %acc_o.sroa.32.52.vec.extract to half, !dbg !200
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %104), !dbg !200, !noalias !195
  %106 = bitcast half %103 to i16, !dbg !202
  %107 = bitcast half %105 to i16, !dbg !205
  %108 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !206
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !206, !noalias !210
  %109 = fptrunc float %acc_o.sroa.32.56.vec.extract to half, !dbg !206
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %108), !dbg !206, !noalias !210
  %110 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !215
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !215, !noalias !210
  %111 = fptrunc float %acc_o.sroa.32.60.vec.extract to half, !dbg !215
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %110), !dbg !215, !noalias !210
  %112 = bitcast half %109 to i16, !dbg !217
  %113 = bitcast half %111 to i16, !dbg !219
  %__2.sroa.6.0.insert.ext.3 = zext i16 %113 to i64, !dbg !220
  %__2.sroa.6.0.insert.shift.3 = shl nuw i64 %__2.sroa.6.0.insert.ext.3, 48, !dbg !220
  %__2.sroa.5.0.insert.ext.3 = zext i16 %112 to i64, !dbg !220
  %__2.sroa.5.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.3, 32, !dbg !220
  %__2.sroa.5.0.insert.insert.3 = or disjoint i64 %__2.sroa.6.0.insert.shift.3, %__2.sroa.5.0.insert.shift.3, !dbg !220
  %__2.sroa.4.0.insert.ext.3 = zext i16 %107 to i64, !dbg !220
  %__2.sroa.4.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.3, 16, !dbg !220
  %__2.sroa.4.0.insert.insert.3 = or disjoint i64 %__2.sroa.5.0.insert.insert.3, %__2.sroa.4.0.insert.shift.3, !dbg !220
  %__2.sroa.0.0.insert.ext.3 = zext i16 %106 to i64, !dbg !220
  %__2.sroa.0.0.insert.insert.3 = or disjoint i64 %__2.sroa.4.0.insert.insert.3, %__2.sroa.0.0.insert.ext.3, !dbg !220
  %114 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %63, !dbg !221
  %add.ptr452.3 = getelementptr inbounds i8, ptr addrspace(1) %114, i64 96, !dbg !221
  store i64 %__2.sroa.0.0.insert.insert.3, ptr addrspace(1) %add.ptr452.3, align 8, !dbg !222
  ret void, !dbg !223
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
declare void @llvm.mxc.barrier.warp() #6

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

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noalias nocapture writeonly, ptr addrspace(4) noalias nocapture readonly, i64, i1 immarg) #10

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
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #11 = { nomerge }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmp68hbdsqg/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmp68hbdsqg/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 24, column: 3, scope: !40)
!44 = !DILocation(line: 25, column: 48, scope: !40)
!45 = !DILocation(line: 27, column: 14, scope: !40)
!46 = !DILocation(line: 27, column: 46, scope: !40)
!47 = !DILocation(line: 33, column: 11, scope: !40)
!48 = !DILocation(line: 33, column: 19, scope: !40)
!49 = !DILocation(line: 33, column: 27, scope: !40)
!50 = !DILocation(line: 33, column: 35, scope: !40)
!51 = !DILocation(line: 35, column: 5, scope: !40)
!52 = !DILocation(line: 38, column: 60, scope: !40)
!53 = !DILocation(line: 38, column: 11, scope: !40)
!54 = !DILocation(line: 39, column: 17, scope: !40)
!55 = !DILocation(line: 40, column: 7, scope: !40)
!56 = !DILocation(line: 0, scope: !40)
!57 = !DILocation(line: 49, column: 11, scope: !40)
!58 = !DILocation(line: 50, column: 19, scope: !40)
!59 = !DILocation(line: 51, column: 7, scope: !40)
!60 = !DILocation(line: 57, column: 5, scope: !40)
!61 = !DILocation(line: 58, column: 159, scope: !40)
!62 = !{i32 -1, i32 3, i32 -1, i32 -1}
!63 = !DILocation(line: 58, column: 42, scope: !40)
!64 = !DILocation(line: 68, column: 3, scope: !65, inlinedAt: !67)
!65 = distinct !DISubprogram(name: "__barrier_warp", scope: !66, file: !66, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!66 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!67 = distinct !DILocation(line: 192, column: 3, scope: !68, inlinedAt: !69)
!68 = distinct !DISubprogram(name: "__syncwarp", scope: !66, file: !66, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!69 = distinct !DILocation(line: 60, column: 5, scope: !40)
!70 = !DILocation(line: 69, column: 3, scope: !65, inlinedAt: !67)
!71 = !DILocation(line: 70, column: 3, scope: !65, inlinedAt: !67)
!72 = !DILocation(line: 63, column: 153, scope: !40)
!73 = !DILocation(line: 63, column: 73, scope: !40)
!74 = !DILocation(line: 63, column: 36, scope: !40)
!75 = !DILocation(line: 63, column: 124, scope: !40)
!76 = !DILocation(line: 68, column: 3, scope: !65, inlinedAt: !77)
!77 = distinct !DILocation(line: 192, column: 3, scope: !68, inlinedAt: !78)
!78 = distinct !DILocation(line: 65, column: 5, scope: !40)
!79 = !DILocation(line: 69, column: 3, scope: !65, inlinedAt: !77)
!80 = !DILocation(line: 70, column: 3, scope: !65, inlinedAt: !77)
!81 = !DILocation(line: 68, column: 159, scope: !40)
!82 = !DILocation(line: 70, column: 34, scope: !40)
!83 = !DILocation(line: 70, column: 27, scope: !40)
!84 = !DILocation(line: 70, column: 9, scope: !40)
!85 = !DILocation(line: 74, column: 62, scope: !40)
!86 = !DILocation(line: 74, column: 13, scope: !40)
!87 = !DILocation(line: 79, column: 20, scope: !40)
!88 = !DILocation(line: 74, column: 55, scope: !40)
!89 = !DILocation(line: 68, column: 3, scope: !65, inlinedAt: !90)
!90 = distinct !DILocation(line: 192, column: 3, scope: !68, inlinedAt: !91)
!91 = distinct !DILocation(line: 85, column: 5, scope: !40)
!92 = !DILocation(line: 69, column: 3, scope: !65, inlinedAt: !90)
!93 = !DILocation(line: 70, column: 3, scope: !65, inlinedAt: !90)
!94 = !DILocation(line: 87, column: 25, scope: !40)
!95 = !DILocation(line: 90, column: 36, scope: !40)
!96 = !DILocation(line: 68, column: 3, scope: !65, inlinedAt: !97)
!97 = distinct !DILocation(line: 192, column: 3, scope: !68, inlinedAt: !98)
!98 = distinct !DILocation(line: 96, column: 5, scope: !40)
!99 = !DILocation(line: 69, column: 3, scope: !65, inlinedAt: !97)
!100 = !DILocation(line: 70, column: 3, scope: !65, inlinedAt: !97)
!101 = !DILocation(line: 98, column: 10, scope: !40)
!102 = !DILocation(line: 99, column: 86, scope: !40)
!103 = !DILocation(line: 99, column: 42, scope: !40)
!104 = !DILocation(line: 103, column: 31, scope: !40)
!105 = !DILocation(line: 103, column: 42, scope: !40)
!106 = !DILocation(line: 354, column: 10, scope: !107, inlinedAt: !109)
!107 = distinct !DISubprogram(name: "min", scope: !108, file: !108, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!108 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!109 = distinct !DILocation(line: 103, column: 26, scope: !40)
!110 = !DILocation(line: 285, column: 49, scope: !111, inlinedAt: !112)
!111 = distinct !DISubprogram(name: "exp2f", scope: !108, file: !108, line: 285, type: !7, scopeLine: 285, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!112 = distinct !DILocation(line: 103, column: 20, scope: !40)
!113 = !DILocation(line: 108, column: 34, scope: !40)
!114 = !DILocation(line: 1018, column: 9, scope: !115, inlinedAt: !116)
!115 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !66, file: !66, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!116 = distinct !DILocation(line: 110, column: 34, scope: !40)
!117 = !DILocation(line: 171, column: 37, scope: !118, inlinedAt: !119)
!118 = distinct !DISubprogram(name: "__lane_id", scope: !66, file: !66, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!119 = distinct !DILocation(line: 990, column: 14, scope: !120, inlinedAt: !121)
!120 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !66, file: !66, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!121 = distinct !DILocation(line: 1019, column: 11, scope: !115, inlinedAt: !116)
!122 = !DILocation(line: 171, column: 10, scope: !118, inlinedAt: !119)
!123 = !DILocation(line: 991, column: 20, scope: !120, inlinedAt: !121)
!124 = !DILocation(line: 992, column: 36, scope: !120, inlinedAt: !121)
!125 = !DILocation(line: 992, column: 17, scope: !120, inlinedAt: !121)
!126 = !DILocation(line: 992, column: 11, scope: !120, inlinedAt: !121)
!127 = !DILocation(line: 993, column: 43, scope: !120, inlinedAt: !121)
!128 = !DILocation(line: 993, column: 10, scope: !120, inlinedAt: !121)
!129 = !DILocation(line: 1020, column: 14, scope: !115, inlinedAt: !116)
!130 = !DILocation(line: 110, column: 32, scope: !40)
!131 = !DILocation(line: 1018, column: 9, scope: !115, inlinedAt: !132)
!132 = distinct !DILocation(line: 111, column: 34, scope: !40)
!133 = !DILocation(line: 171, column: 37, scope: !118, inlinedAt: !134)
!134 = distinct !DILocation(line: 990, column: 14, scope: !120, inlinedAt: !135)
!135 = distinct !DILocation(line: 1019, column: 11, scope: !115, inlinedAt: !132)
!136 = !DILocation(line: 171, column: 10, scope: !118, inlinedAt: !134)
!137 = !DILocation(line: 991, column: 20, scope: !120, inlinedAt: !135)
!138 = !DILocation(line: 992, column: 36, scope: !120, inlinedAt: !135)
!139 = !DILocation(line: 992, column: 17, scope: !120, inlinedAt: !135)
!140 = !DILocation(line: 992, column: 11, scope: !120, inlinedAt: !135)
!141 = !DILocation(line: 993, column: 43, scope: !120, inlinedAt: !135)
!142 = !DILocation(line: 993, column: 10, scope: !120, inlinedAt: !135)
!143 = !DILocation(line: 1020, column: 14, scope: !115, inlinedAt: !132)
!144 = !DILocation(line: 111, column: 32, scope: !40)
!145 = !DILocation(line: 113, column: 34, scope: !40)
!146 = !DILocation(line: 113, column: 9, scope: !40)
!147 = !DILocation(line: 121, column: 34, scope: !40)
!148 = !DILocation(line: 1007, column: 10, scope: !149, inlinedAt: !151)
!149 = distinct !DISubprogram(name: "__float2half_rn", scope: !150, file: !150, line: 1005, type: !7, scopeLine: 1005, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!150 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!151 = distinct !DILocation(line: 1077, column: 18, scope: !152, inlinedAt: !153)
!152 = distinct !DISubprogram(name: "__floats2half2_rn", scope: !150, file: !150, line: 1075, type: !7, scopeLine: 1076, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!153 = distinct !DILocation(line: 1295, column: 23, scope: !154, inlinedAt: !155)
!154 = distinct !DISubprogram(name: "__float22half2_rn", scope: !150, file: !150, line: 1294, type: !7, scopeLine: 1294, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!155 = distinct !DILocation(line: 125, column: 27, scope: !40)
!156 = !{!157, !159}
!157 = distinct !{!157, !158, !"_ZL17__floats2half2_rnff: %agg.result"}
!158 = distinct !{!158, !"_ZL17__floats2half2_rnff"}
!159 = distinct !{!159, !160, !"_ZL17__float22half2_rn6float2: %agg.result"}
!160 = distinct !{!160, !"_ZL17__float22half2_rn6float2"}
!161 = !DILocation(line: 1007, column: 10, scope: !149, inlinedAt: !162)
!162 = distinct !DILocation(line: 1077, column: 38, scope: !152, inlinedAt: !153)
!163 = !DILocation(line: 593, column: 26, scope: !164, inlinedAt: !165)
!164 = distinct !DISubprogram(name: "operator=", scope: !150, file: !150, line: 592, type: !7, scopeLine: 592, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!165 = distinct !DILocation(line: 125, column: 25, scope: !40)
!166 = !DILocation(line: 1007, column: 10, scope: !149, inlinedAt: !167)
!167 = distinct !DILocation(line: 1077, column: 18, scope: !152, inlinedAt: !168)
!168 = distinct !DILocation(line: 1295, column: 23, scope: !154, inlinedAt: !169)
!169 = distinct !DILocation(line: 126, column: 27, scope: !40)
!170 = !{!171, !173}
!171 = distinct !{!171, !172, !"_ZL17__floats2half2_rnff: %agg.result"}
!172 = distinct !{!172, !"_ZL17__floats2half2_rnff"}
!173 = distinct !{!173, !174, !"_ZL17__float22half2_rn6float2: %agg.result"}
!174 = distinct !{!174, !"_ZL17__float22half2_rn6float2"}
!175 = !DILocation(line: 1007, column: 10, scope: !149, inlinedAt: !176)
!176 = distinct !DILocation(line: 1077, column: 38, scope: !152, inlinedAt: !168)
!177 = !DILocation(line: 593, column: 26, scope: !164, inlinedAt: !178)
!178 = distinct !DILocation(line: 126, column: 25, scope: !40)
!179 = !DILocation(line: 68, column: 3, scope: !65, inlinedAt: !180)
!180 = distinct !DILocation(line: 192, column: 3, scope: !68, inlinedAt: !181)
!181 = distinct !DILocation(line: 128, column: 5, scope: !40)
!182 = !DILocation(line: 69, column: 3, scope: !65, inlinedAt: !180)
!183 = !DILocation(line: 70, column: 3, scope: !65, inlinedAt: !180)
!184 = !DILocation(line: 131, column: 119, scope: !40)
!185 = !DILocation(line: 131, column: 31, scope: !40)
!186 = !DILocation(line: 131, column: 29, scope: !40)
!187 = !{!26, !26, i64 0}
!188 = !DILocation(line: 136, column: 38, scope: !40)
!189 = !DILocation(line: 143, column: 3, scope: !40)
!190 = !DILocation(line: 145, column: 19, scope: !40)
!191 = !DILocation(line: 1007, column: 10, scope: !149, inlinedAt: !192)
!192 = distinct !DILocation(line: 1077, column: 18, scope: !152, inlinedAt: !193)
!193 = distinct !DILocation(line: 1295, column: 23, scope: !154, inlinedAt: !194)
!194 = distinct !DILocation(line: 146, column: 27, scope: !40)
!195 = !{!196, !198}
!196 = distinct !{!196, !197, !"_ZL17__floats2half2_rnff: %agg.result"}
!197 = distinct !{!197, !"_ZL17__floats2half2_rnff"}
!198 = distinct !{!198, !199, !"_ZL17__float22half2_rn6float2: %agg.result"}
!199 = distinct !{!199, !"_ZL17__float22half2_rn6float2"}
!200 = !DILocation(line: 1007, column: 10, scope: !149, inlinedAt: !201)
!201 = distinct !DILocation(line: 1077, column: 38, scope: !152, inlinedAt: !193)
!202 = !DILocation(line: 596, column: 67, scope: !203, inlinedAt: !204)
!203 = distinct !DISubprogram(name: "__half2", scope: !150, file: !150, line: 596, type: !7, scopeLine: 596, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!204 = distinct !DILocation(line: 1077, column: 10, scope: !152, inlinedAt: !193)
!205 = !DILocation(line: 596, column: 73, scope: !203, inlinedAt: !204)
!206 = !DILocation(line: 1007, column: 10, scope: !149, inlinedAt: !207)
!207 = distinct !DILocation(line: 1077, column: 18, scope: !152, inlinedAt: !208)
!208 = distinct !DILocation(line: 1295, column: 23, scope: !154, inlinedAt: !209)
!209 = distinct !DILocation(line: 147, column: 27, scope: !40)
!210 = !{!211, !213}
!211 = distinct !{!211, !212, !"_ZL17__floats2half2_rnff: %agg.result"}
!212 = distinct !{!212, !"_ZL17__floats2half2_rnff"}
!213 = distinct !{!213, !214, !"_ZL17__float22half2_rn6float2: %agg.result"}
!214 = distinct !{!214, !"_ZL17__float22half2_rn6float2"}
!215 = !DILocation(line: 1007, column: 10, scope: !149, inlinedAt: !216)
!216 = distinct !DILocation(line: 1077, column: 38, scope: !152, inlinedAt: !208)
!217 = !DILocation(line: 596, column: 67, scope: !203, inlinedAt: !218)
!218 = distinct !DILocation(line: 1077, column: 10, scope: !152, inlinedAt: !208)
!219 = !DILocation(line: 596, column: 73, scope: !203, inlinedAt: !218)
!220 = !DILocation(line: 148, column: 38, scope: !40)
!221 = !DILocation(line: 149, column: 22, scope: !40)
!222 = !DILocation(line: 149, column: 141, scope: !40)
!223 = !DILocation(line: 151, column: 1, scope: !40)
