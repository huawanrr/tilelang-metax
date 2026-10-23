; ModuleID = '/data/tilelang-metax/race_tests/nsa/experiments/20261016_goal895/validation_dispatch_r1/actual_binary/d64_b1_h3_t96_c1_m0_p0.bc'
source_filename = "/tmp/tmp_vlyj031/tvm_kernels.maca"
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
  %mul = mul nuw nsw i32 %0, 3072
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul7 = shl nsw i32 %1, 10
  %add = add nuw nsw i32 %mul, %mul7
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %mul11 = shl nuw nsw i32 %2, 3
  %add9 = add nuw nsw i32 %add, %mul11
  %3 = zext nneg i32 %add9 to i64, !dbg !43
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !44
  %4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !44
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %4, i64 1024, !dbg !44
  %mul17 = mul nuw nsw i32 %0, 3, !dbg !45
  %add19 = add nuw nsw i32 %mul17, %1, !dbg !46
  %idxprom = zext nneg i32 %add19 to i64, !dbg !47
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom, !dbg !47
  %5 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !47, !tbaa !30
  %mul20 = shl nsw i32 %5, 4, !dbg !48
  %cmp34 = icmp sgt i32 %5, -1, !dbg !49
  br i1 %cmp34, label %land.lhs.true, label %if.end438, !dbg !50

land.lhs.true:                                    ; preds = %entry
  %cmp35 = icmp ugt i32 %5, 5, !dbg !51
  %cmp38.not = icmp sgt i32 %mul20, %0
  %or.cond = select i1 %cmp35, i1 true, i1 %cmp38.not, !dbg !52
  br i1 %or.cond, label %if.end438, label %for.cond39.preheader, !dbg !52

for.cond39.preheader:                             ; preds = %land.lhs.true
  %shr = lshr i32 %2, 3
  %add45 = add nuw nsw i32 %mul20, %shr
  %mul53 = mul nuw nsw i32 %shr, 192
  %mul55 = mul nuw nsw i32 %5, 3072
  %mul58 = shl nsw i32 %1, 6
  %add54 = add nuw nsw i32 %mul53, %mul58
  %mul61 = and i32 %mul11, 56
  %add56 = or disjoint i32 %add54, %mul61
  %add59 = add nuw nsw i32 %add56, %mul55
  %6 = zext nneg i32 %add59 to i64, !dbg !53
  %cmp48 = icmp ult i32 %add45, 96, !dbg !54
  br i1 %cmp48, label %if.then49, label %if.end, !dbg !55

if.then49:                                        ; preds = %for.cond39.preheader
  %add.ptr64 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %6, !dbg !56
  %condval.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr64, align 16, !dbg !57, !tbaa !30
  %condval.sroa.5.0.add.ptr64.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr64, i64 4, !dbg !57
  %condval.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval.sroa.5.0.add.ptr64.sroa_idx, align 4, !dbg !57, !tbaa !30
  %condval.sroa.6.0.add.ptr64.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr64, i64 8, !dbg !57
  %condval.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval.sroa.6.0.add.ptr64.sroa_idx, align 8, !dbg !57, !tbaa !30
  %condval.sroa.7.0.add.ptr64.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr64, i64 12, !dbg !57
  %condval.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval.sroa.7.0.add.ptr64.sroa_idx, align 4, !dbg !57, !tbaa !30
  br label %if.end, !dbg !58

if.end:                                           ; preds = %for.cond39.preheader, %if.then49
  %condval.sroa.0.0 = phi i32 [ %condval.sroa.0.0.copyload, %if.then49 ], [ 0, %for.cond39.preheader ], !dbg !59
  %condval.sroa.5.0 = phi i32 [ %condval.sroa.5.0.copyload, %if.then49 ], [ 0, %for.cond39.preheader ], !dbg !59
  %condval.sroa.6.0 = phi i32 [ %condval.sroa.6.0.copyload, %if.then49 ], [ 0, %for.cond39.preheader ], !dbg !59
  %condval.sroa.7.0 = phi i32 [ %condval.sroa.7.0.copyload, %if.then49 ], [ 0, %for.cond39.preheader ], !dbg !59
  %cmp48.1 = icmp ult i32 %add45, 88, !dbg !54
  br i1 %cmp48.1, label %if.then49.1, label %if.end.1, !dbg !55

if.then49.1:                                      ; preds = %if.end
  %7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %6, !dbg !56
  %add.ptr64.1 = getelementptr inbounds i8, ptr addrspace(4) %7, i64 3072, !dbg !56
  %condval.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr64.1, align 16, !dbg !57, !tbaa !30
  %condval.sroa.5.0.add.ptr64.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %7, i64 3076, !dbg !57
  %condval.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval.sroa.5.0.add.ptr64.sroa_idx.1, align 4, !dbg !57, !tbaa !30
  %condval.sroa.6.0.add.ptr64.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %7, i64 3080, !dbg !57
  %condval.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval.sroa.6.0.add.ptr64.sroa_idx.1, align 8, !dbg !57, !tbaa !30
  %condval.sroa.7.0.add.ptr64.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %7, i64 3084, !dbg !57
  %condval.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval.sroa.7.0.add.ptr64.sroa_idx.1, align 4, !dbg !57, !tbaa !30
  br label %if.end.1, !dbg !58

if.end.1:                                         ; preds = %if.then49.1, %if.end
  %condval.sroa.0.0.1 = phi i32 [ %condval.sroa.0.0.copyload.1, %if.then49.1 ], [ 0, %if.end ], !dbg !59
  %condval.sroa.5.0.1 = phi i32 [ %condval.sroa.5.0.copyload.1, %if.then49.1 ], [ 0, %if.end ], !dbg !59
  %condval.sroa.6.0.1 = phi i32 [ %condval.sroa.6.0.copyload.1, %if.then49.1 ], [ 0, %if.end ], !dbg !59
  %condval.sroa.7.0.1 = phi i32 [ %condval.sroa.7.0.copyload.1, %if.then49.1 ], [ 0, %if.end ], !dbg !59
  br i1 %cmp48, label %if.then103, label %if.end143, !dbg !60

if.then103:                                       ; preds = %if.end.1
  %add.ptr119 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %6, !dbg !61
  %condval_1.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr119, align 16, !dbg !62, !tbaa !30
  %condval_1.sroa.5.0.add.ptr119.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr119, i64 4, !dbg !62
  %condval_1.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr119.sroa_idx, align 4, !dbg !62, !tbaa !30
  %condval_1.sroa.6.0.add.ptr119.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr119, i64 8, !dbg !62
  %condval_1.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr119.sroa_idx, align 8, !dbg !62, !tbaa !30
  %condval_1.sroa.7.0.add.ptr119.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr119, i64 12, !dbg !62
  %condval_1.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr119.sroa_idx, align 4, !dbg !62, !tbaa !30
  br label %if.end143, !dbg !63

if.end143:                                        ; preds = %if.end.1, %if.then103
  %condval_1.sroa.0.0 = phi i32 [ %condval_1.sroa.0.0.copyload, %if.then103 ], [ 0, %if.end.1 ], !dbg !59
  %condval_1.sroa.5.0 = phi i32 [ %condval_1.sroa.5.0.copyload, %if.then103 ], [ 0, %if.end.1 ], !dbg !59
  %condval_1.sroa.6.0 = phi i32 [ %condval_1.sroa.6.0.copyload, %if.then103 ], [ 0, %if.end.1 ], !dbg !59
  %condval_1.sroa.7.0 = phi i32 [ %condval_1.sroa.7.0.copyload, %if.then103 ], [ 0, %if.end.1 ], !dbg !59
  br i1 %cmp48.1, label %if.then103.1, label %if.end143.1, !dbg !60

if.then103.1:                                     ; preds = %if.end143
  %8 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %6, !dbg !61
  %add.ptr119.1 = getelementptr inbounds i8, ptr addrspace(4) %8, i64 3072, !dbg !61
  %condval_1.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr119.1, align 16, !dbg !62, !tbaa !30
  %condval_1.sroa.5.0.add.ptr119.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %8, i64 3076, !dbg !62
  %condval_1.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr119.sroa_idx.1, align 4, !dbg !62, !tbaa !30
  %condval_1.sroa.6.0.add.ptr119.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %8, i64 3080, !dbg !62
  %condval_1.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr119.sroa_idx.1, align 8, !dbg !62, !tbaa !30
  %condval_1.sroa.7.0.add.ptr119.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %8, i64 3084, !dbg !62
  %condval_1.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr119.sroa_idx.1, align 4, !dbg !62, !tbaa !30
  br label %if.end143.1, !dbg !63

if.end143.1:                                      ; preds = %if.then103.1, %if.end143
  %condval_1.sroa.0.0.1 = phi i32 [ %condval_1.sroa.0.0.copyload.1, %if.then103.1 ], [ 0, %if.end143 ], !dbg !59
  %condval_1.sroa.5.0.1 = phi i32 [ %condval_1.sroa.5.0.copyload.1, %if.then103.1 ], [ 0, %if.end143 ], !dbg !59
  %condval_1.sroa.6.0.1 = phi i32 [ %condval_1.sroa.6.0.copyload.1, %if.then103.1 ], [ 0, %if.end143 ], !dbg !59
  %condval_1.sroa.7.0.1 = phi i32 [ %condval_1.sroa.7.0.copyload.1, %if.then103.1 ], [ 0, %if.end143 ], !dbg !59
  %mul163 = and i32 %mul11, 8128
  %call167.masked = and i32 %2, 1016
  %mul169 = xor i32 %mul61, %call167.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul163, !dbg !64
  %invariant.gep645 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul169, !dbg !64
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep645, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !dbg !65, !call_argsrelate !66
  %gep646.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep645, i32 1024, !dbg !67
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep646.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !dbg !65, !call_argsrelate !66
  fence syncscope("warp") release, !dbg !68
  tail call void @llvm.mxc.barrier.warp(), !dbg !74
  fence syncscope("warp") acquire, !dbg !75
  %and182 = shl nuw nsw i32 %2, 6
  %mul183 = and i32 %and182, 960
  %shr186 = lshr i32 %2, 4
  %and189 = and i32 %2, 7
  %9 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul183
  %xor190 = xor i32 %shr186, %and189, !dbg !76
  %add.ptr194.idx = shl nuw nsw i32 %xor190, 4, !dbg !77
  %add.ptr194 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr194.idx, !dbg !77
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr194, align 16, !dbg !78
  %Q_reg.sroa.4.0.add.ptr194.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr194, i32 8, !dbg !78
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr194.sroa_idx, align 8, !dbg !78
  %add187.1 = add nuw nsw i32 %shr186, 4, !dbg !79
  %xor190.1 = xor i32 %add187.1, %and189, !dbg !76
  %add.ptr194.idx.1 = shl nuw nsw i32 %xor190.1, 4, !dbg !77
  %add.ptr194.1 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 %add.ptr194.idx.1, !dbg !77
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr194.1, align 16, !dbg !78
  %Q_reg.sroa.7.16.add.ptr194.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr194.1, i32 8, !dbg !78
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr194.1.sroa_idx, align 8, !dbg !78
  fence syncscope("warp") release, !dbg !80
  tail call void @llvm.mxc.barrier.warp(), !dbg !83
  fence syncscope("warp") acquire, !dbg !84
  store i32 %condval.sroa.0.0, ptr addrspace(3) %invariant.gep645, align 16, !dbg !85, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep650.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep645, i32 4, !dbg !85
  store i32 %condval.sroa.5.0, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep650.sroa_idx, align 4, !dbg !85, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep650.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep645, i32 8, !dbg !85
  store i32 %condval.sroa.6.0, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep650.sroa_idx, align 8, !dbg !85, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep650.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep645, i32 12, !dbg !85
  store i32 %condval.sroa.7.0, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep650.sroa_idx, align 4, !dbg !85, !tbaa !30
  store i32 %condval.sroa.0.0.1, ptr addrspace(3) %gep646.1, align 16, !dbg !85, !tbaa !30
  %K_reg.sroa.9.16.gep651.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep645, i32 1028, !dbg !85
  store i32 %condval.sroa.5.0.1, ptr addrspace(3) %K_reg.sroa.9.16.gep651.1.sroa_idx, align 4, !dbg !85, !tbaa !30
  %K_reg.sroa.10.16.gep651.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep645, i32 1032, !dbg !85
  store i32 %condval.sroa.6.0.1, ptr addrspace(3) %K_reg.sroa.10.16.gep651.1.sroa_idx, align 8, !dbg !85, !tbaa !30
  %K_reg.sroa.11.16.gep651.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep645, i32 1036, !dbg !85
  store i32 %condval.sroa.7.0.1, ptr addrspace(3) %K_reg.sroa.11.16.gep651.1.sroa_idx, align 4, !dbg !85, !tbaa !30
  %add229 = or disjoint i32 %mul20, 15, !dbg !86
  %cmp230 = icmp slt i32 %0, %add229, !dbg !87
  br i1 %cmp230, label %for.cond232.preheader, label %if.end258, !dbg !88

for.cond232.preheader:                            ; preds = %if.end143.1
  %10 = lshr i32 %2, 2
  %mul239 = and i32 %10, 252
  %add240 = add nuw nsw i32 %mul20, %mul239
  %cmp243.not = icmp sgt i32 %add240, %0, !dbg !89
  %spec.select = select i1 %cmp243.not, float 0xFFF0000000000000, float 0.000000e+00, !dbg !90
  %acc_s.sroa.0.0.vec.insert712 = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !91
  %cmp243.not.1.not = icmp slt i32 %add240, %0, !dbg !89
  %spec.select.1 = select i1 %cmp243.not.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !90
  %acc_s.sroa.0.4.vec.insert725 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert712, float %spec.select.1, i64 1, !dbg !91
  %add241.2 = or disjoint i32 %add240, 2, !dbg !92
  %cmp243.not.2 = icmp sgt i32 %add241.2, %0, !dbg !89
  %spec.select.2 = select i1 %cmp243.not.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !90
  %acc_s.sroa.0.8.vec.insert738 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert725, float %spec.select.2, i64 2, !dbg !91
  %add241.3 = or disjoint i32 %add240, 3, !dbg !92
  %cmp243.not.3 = icmp sgt i32 %add241.3, %0, !dbg !89
  %spec.select.3 = select i1 %cmp243.not.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !90
  %acc_s.sroa.0.12.vec.insert751 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert738, float %spec.select.3, i64 3, !dbg !91
  br label %if.end258, !dbg !93

if.end258:                                        ; preds = %if.end143.1, %for.cond232.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert751, %for.cond232.preheader ], [ zeroinitializer, %if.end143.1 ], !dbg !59
  fence syncscope("warp") release, !dbg !93
  tail call void @llvm.mxc.barrier.warp(), !dbg !96
  fence syncscope("warp") acquire, !dbg !97
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr194, align 16, !dbg !98
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr194.sroa_idx, align 8, !dbg !98
  %11 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !dbg !99
  %12 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %11), !dbg !99
  %kb.sroa.0.0.copyload706 = load <4 x half>, ptr addrspace(3) %add.ptr194.1, align 16, !dbg !98
  %kb.sroa.6.0.copyload707 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr194.1.sroa_idx, align 8, !dbg !98
  %13 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload706, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %12), !dbg !99
  %14 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload707, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %13), !dbg !99
  fence syncscope("warp") release, !dbg !100
  tail call void @llvm.mxc.barrier.warp(), !dbg !103
  fence syncscope("warp") acquire, !dbg !104
  %add.ptr315.idx = shl nuw nsw i32 %2, 4
  %invariant.gep659 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr315.idx, !dbg !105
  store i32 %condval_1.sroa.0.0, ptr addrspace(3) %invariant.gep659, align 16, !dbg !106, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep659.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep659, i32 4, !dbg !106
  store i32 %condval_1.sroa.5.0, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep659.sroa_idx, align 4, !dbg !106, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep659.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep659, i32 8, !dbg !106
  store i32 %condval_1.sroa.6.0, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep659.sroa_idx, align 8, !dbg !106, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep659.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep659, i32 12, !dbg !106
  store i32 %condval_1.sroa.7.0, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep659.sroa_idx, align 4, !dbg !106, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep659, i32 1024, !dbg !107
  store i32 %condval_1.sroa.0.0.1, ptr addrspace(3) %gep.1, align 16, !dbg !106, !tbaa !30
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep659, i32 1028, !dbg !106
  store i32 %condval_1.sroa.5.0.1, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !dbg !106, !tbaa !30
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep659, i32 1032, !dbg !106
  store i32 %condval_1.sroa.6.0.1, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !dbg !106, !tbaa !30
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep659, i32 1036, !dbg !106
  store i32 %condval_1.sroa.7.0.1, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !dbg !106, !tbaa !30
  %acc_s.sroa.0.0.vec.extract714 = extractelement <4 x float> %14, i64 0, !dbg !108
  %mul325 = fmul contract float %acc_s.sroa.0.0.vec.extract714, 0x3FC2776C60000000, !dbg !109
  %15 = tail call contract noundef float @llvm.minnum.f32(float %mul325, float 1.500000e+01), !dbg !110
  %cmp.i.i = fcmp contract olt float %15, -1.260000e+02, !dbg !114
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00, !dbg !114
  %add.i.i = fadd contract float %15, %cond.i.i, !dbg !114
  %16 = tail call contract float @llvm.exp2.f32(float %add.i.i), !dbg !114
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00, !dbg !114
  %mul.i.i = fmul contract float %cond2.i.i, %16, !dbg !114
  %acc_s.sroa.0.4.vec.extract727 = extractelement <4 x float> %14, i64 1, !dbg !108
  %mul325.1 = fmul contract float %acc_s.sroa.0.4.vec.extract727, 0x3FC2776C60000000, !dbg !109
  %17 = tail call contract noundef float @llvm.minnum.f32(float %mul325.1, float 1.500000e+01), !dbg !110
  %cmp.i.i.1 = fcmp contract olt float %17, -1.260000e+02, !dbg !114
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00, !dbg !114
  %add.i.i.1 = fadd contract float %17, %cond.i.i.1, !dbg !114
  %18 = tail call contract float @llvm.exp2.f32(float %add.i.i.1), !dbg !114
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !114
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %18, !dbg !114
  %acc_s.sroa.0.8.vec.extract740 = extractelement <4 x float> %14, i64 2, !dbg !108
  %mul325.2 = fmul contract float %acc_s.sroa.0.8.vec.extract740, 0x3FC2776C60000000, !dbg !109
  %19 = tail call contract noundef float @llvm.minnum.f32(float %mul325.2, float 1.500000e+01), !dbg !110
  %cmp.i.i.2 = fcmp contract olt float %19, -1.260000e+02, !dbg !114
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00, !dbg !114
  %add.i.i.2 = fadd contract float %19, %cond.i.i.2, !dbg !114
  %20 = tail call contract float @llvm.exp2.f32(float %add.i.i.2), !dbg !114
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00, !dbg !114
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %20, !dbg !114
  %acc_s.sroa.0.12.vec.extract753 = extractelement <4 x float> %14, i64 3, !dbg !108
  %mul325.3 = fmul contract float %acc_s.sroa.0.12.vec.extract753, 0x3FC2776C60000000, !dbg !109
  %21 = tail call contract noundef float @llvm.minnum.f32(float %mul325.3, float 1.500000e+01), !dbg !110
  %cmp.i.i.3 = fcmp contract olt float %21, -1.260000e+02, !dbg !114
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00, !dbg !114
  %add.i.i.3 = fadd contract float %21, %cond.i.i.3, !dbg !114
  %22 = tail call contract float @llvm.exp2.f32(float %add.i.i.3), !dbg !114
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00, !dbg !114
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %22, !dbg !114
  %add341 = fadd contract float %mul.i.i, 0.000000e+00, !dbg !117
  %add341.1 = fadd contract float %add341, %mul.i.i.1, !dbg !117
  %add341.2 = fadd contract float %add341.1, %mul.i.i.2, !dbg !117
  %add341.3 = fadd contract float %add341.2, %mul.i.i.3, !dbg !117
  %23 = bitcast float %add341.3 to i32, !dbg !118
  %24 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !121
  %25 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %24) #11, !dbg !126
  %xor.i.i = xor i32 %25, 32, !dbg !127
  %26 = and i32 %25, -64, !dbg !128
  %and.i.i = add nsw i32 %26, 64, !dbg !128
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !129
  %cond.i.i607 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %25, !dbg !130
  %shl.i.i = shl i32 %cond.i.i607, 2, !dbg !131
  %27 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %23), !dbg !132
  %28 = bitcast i32 %27 to float, !dbg !133
  %add349 = fadd contract float %add341.3, %28, !dbg !134
  %29 = bitcast float %add349 to i32, !dbg !135
  %30 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !137
  %31 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %30) #11, !dbg !140
  %xor.i.i608 = xor i32 %31, 16, !dbg !141
  %32 = and i32 %31, -64, !dbg !142
  %and.i.i609 = add nsw i32 %32, 64, !dbg !142
  %cmp.not.i.i610 = icmp slt i32 %xor.i.i608, %and.i.i609, !dbg !143
  %cond.i.i611 = select i1 %cmp.not.i.i610, i32 %xor.i.i608, i32 %31, !dbg !144
  %shl.i.i612 = shl i32 %cond.i.i611, 2, !dbg !145
  %33 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i612, i32 %29), !dbg !146
  %34 = bitcast i32 %33 to float, !dbg !147
  %add354 = fadd contract float %add349, %34, !dbg !148
  %cmp357 = fcmp contract ogt float %add354, 0.000000e+00, !dbg !149
  %div = fdiv contract float 1.000000e+00, %add354, !dbg !150
  %condval_3.0 = select i1 %cmp357, float %div, float 0.000000e+00, !dbg !150
  %mul370 = fmul contract float %condval_3.0, %mul.i.i, !dbg !151
  %mul370.1 = fmul contract float %condval_3.0, %mul.i.i.1, !dbg !151
  %mul370.2 = fmul contract float %condval_3.0, %mul.i.i.2, !dbg !151
  %mul370.3 = fmul contract float %condval_3.0, %mul.i.i.3, !dbg !151
  %35 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !152
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !152, !noalias !160
  %36 = fptrunc float %mul370 to half, !dbg !152
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %35), !dbg !152, !noalias !160
  %37 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !165
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !165, !noalias !160
  %38 = fptrunc float %mul370.1 to half, !dbg !165
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %37), !dbg !165, !noalias !160
  %__1.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %36, i64 0, !dbg !167
  %__1.sroa.0.2.vec.insert = insertelement <4 x half> %__1.sroa.0.0.vec.insert, half %38, i64 1, !dbg !167
  %39 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !170
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !170, !noalias !174
  %40 = fptrunc float %mul370.2 to half, !dbg !170
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %39), !dbg !170, !noalias !174
  %41 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !179
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !179, !noalias !174
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %41), !dbg !179, !noalias !174
  %__1.sroa.0.4.vec.insert = insertelement <4 x half> %__1.sroa.0.2.vec.insert, half %40, i64 2, !dbg !181
  fence syncscope("warp") release, !dbg !183
  tail call void @llvm.mxc.barrier.warp(), !dbg !186
  fence syncscope("warp") acquire, !dbg !187
  %mul400 = and i32 %add.ptr315.idx, 16128
  %and406 = and i32 %2, 15
  %add407 = or disjoint i32 %mul400, %and406, !dbg !188
  %arrayidx409 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407, !dbg !189
  %42 = load half, ptr addrspace(3) %arrayidx409, align 2, !dbg !190, !tbaa !191
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %42, i64 0, !dbg !190
  %add402.1 = or disjoint i32 %mul400, %and406, !dbg !188
  %add407.1 = or disjoint i32 %add402.1, 64, !dbg !188
  %arrayidx409.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407.1, !dbg !189
  %43 = load half, ptr addrspace(3) %arrayidx409.1, align 2, !dbg !190, !tbaa !191
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %43, i64 1, !dbg !190
  %add402.2 = or disjoint i32 %mul400, %and406, !dbg !188
  %add407.2 = or disjoint i32 %add402.2, 128, !dbg !188
  %arrayidx409.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407.2, !dbg !189
  %44 = load half, ptr addrspace(3) %arrayidx409.2, align 2, !dbg !190, !tbaa !191
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %44, i64 2, !dbg !190
  %add402.3 = or disjoint i32 %mul400, %and406, !dbg !188
  %add407.3 = or disjoint i32 %add402.3, 192, !dbg !188
  %arrayidx409.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407.3, !dbg !189
  %45 = load half, ptr addrspace(3) %arrayidx409.3, align 2, !dbg !190, !tbaa !191
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %45, i64 3, !dbg !190
  %add404.1685 = or disjoint i32 %mul400, %and406, !dbg !188
  %add407.1686 = or disjoint i32 %add404.1685, 16, !dbg !188
  %arrayidx409.1687 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407.1686, !dbg !189
  %46 = load half, ptr addrspace(3) %arrayidx409.1687, align 2, !dbg !190, !tbaa !191
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %46, i64 0, !dbg !190
  %add404.1.1 = or disjoint i32 %mul400, %and406, !dbg !188
  %add407.1.1 = or disjoint i32 %add404.1.1, 80, !dbg !188
  %arrayidx409.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407.1.1, !dbg !189
  %47 = load half, ptr addrspace(3) %arrayidx409.1.1, align 2, !dbg !190, !tbaa !191
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %47, i64 1, !dbg !190
  %add404.2.1 = or disjoint i32 %mul400, %and406, !dbg !188
  %add407.2.1 = or disjoint i32 %add404.2.1, 144, !dbg !188
  %arrayidx409.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407.2.1, !dbg !189
  %48 = load half, ptr addrspace(3) %arrayidx409.2.1, align 2, !dbg !190, !tbaa !191
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %48, i64 2, !dbg !190
  %add404.3.1 = or disjoint i32 %mul400, %and406, !dbg !188
  %add407.3.1 = or disjoint i32 %add404.3.1, 208, !dbg !188
  %arrayidx409.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407.3.1, !dbg !189
  %49 = load half, ptr addrspace(3) %arrayidx409.3.1, align 2, !dbg !190, !tbaa !191
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %49, i64 3, !dbg !190
  %add404.2689 = or disjoint i32 %mul400, %and406, !dbg !188
  %add407.2690 = or disjoint i32 %add404.2689, 32, !dbg !188
  %arrayidx409.2691 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407.2690, !dbg !189
  %50 = load half, ptr addrspace(3) %arrayidx409.2691, align 2, !dbg !190, !tbaa !191
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %50, i64 0, !dbg !190
  %add404.1.2 = or disjoint i32 %mul400, %and406, !dbg !188
  %add407.1.2 = or disjoint i32 %add404.1.2, 96, !dbg !188
  %arrayidx409.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407.1.2, !dbg !189
  %51 = load half, ptr addrspace(3) %arrayidx409.1.2, align 2, !dbg !190, !tbaa !191
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %51, i64 1, !dbg !190
  %add404.2.2 = or disjoint i32 %mul400, %and406, !dbg !188
  %add407.2.2 = or disjoint i32 %add404.2.2, 160, !dbg !188
  %arrayidx409.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407.2.2, !dbg !189
  %52 = load half, ptr addrspace(3) %arrayidx409.2.2, align 2, !dbg !190, !tbaa !191
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %52, i64 2, !dbg !190
  %add404.3.2 = or disjoint i32 %mul400, %and406, !dbg !188
  %add407.3.2 = or disjoint i32 %add404.3.2, 224, !dbg !188
  %arrayidx409.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407.3.2, !dbg !189
  %53 = load half, ptr addrspace(3) %arrayidx409.3.2, align 2, !dbg !190, !tbaa !191
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %53, i64 3, !dbg !190
  %add404.3693 = or disjoint i32 %mul400, %and406, !dbg !188
  %add407.3694 = or disjoint i32 %add404.3693, 48, !dbg !188
  %arrayidx409.3695 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407.3694, !dbg !189
  %54 = load half, ptr addrspace(3) %arrayidx409.3695, align 2, !dbg !190, !tbaa !191
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %54, i64 0, !dbg !190
  %add404.1.3 = or disjoint i32 %mul400, %and406, !dbg !188
  %add407.1.3 = or disjoint i32 %add404.1.3, 112, !dbg !188
  %arrayidx409.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407.1.3, !dbg !189
  %55 = load half, ptr addrspace(3) %arrayidx409.1.3, align 2, !dbg !190, !tbaa !191
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %55, i64 1, !dbg !190
  %add404.2.3 = or disjoint i32 %mul400, %and406, !dbg !188
  %add407.2.3 = or disjoint i32 %add404.2.3, 176, !dbg !188
  %arrayidx409.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407.2.3, !dbg !189
  %56 = load half, ptr addrspace(3) %arrayidx409.2.3, align 2, !dbg !190, !tbaa !191
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %56, i64 2, !dbg !190
  %add404.3.3 = or disjoint i32 %add.ptr315.idx, %and406, !dbg !188
  %add407.3.3 = or i32 %add404.3.3, 240, !dbg !188
  %arrayidx409.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add407.3.3, !dbg !189
  %57 = load half, ptr addrspace(3) %arrayidx409.3.3, align 2, !dbg !190, !tbaa !191
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %57, i64 3, !dbg !190
  %58 = fptrunc float %mul370.3 to half, !dbg !179
  %__1.sroa.0.6.vec.insert = insertelement <4 x half> %__1.sroa.0.4.vec.insert, half %58, i64 3, !dbg !181
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !192
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !192
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !192
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !192
  br label %if.end438

if.end438:                                        ; preds = %if.end258, %land.lhs.true, %entry
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %59, %if.end258 ], [ zeroinitializer, %entry ], !dbg !59
  %acc_o.sroa.12.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %60, %if.end258 ], [ zeroinitializer, %entry ], !dbg !59
  %acc_o.sroa.22.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %61, %if.end258 ], [ zeroinitializer, %entry ], !dbg !59
  %acc_o.sroa.32.0 = phi <4 x float> [ zeroinitializer, %land.lhs.true ], [ %62, %if.end258 ], [ zeroinitializer, %entry ], !dbg !59
  %and467 = shl nuw nsw i32 %2, 6
  %mul468 = and i32 %and467, 960
  %add469 = or disjoint i32 %add, %mul468
  %63 = lshr i32 %2, 2
  %mul474 = and i32 %63, 252
  %add471 = add nuw nsw i32 %add469, %mul474
  %64 = zext nneg i32 %add471 to i64, !dbg !193
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0, !dbg !194
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1, !dbg !194
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2, !dbg !194
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3, !dbg !194
  %65 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !195, !noalias !199
  %66 = fptrunc float %acc_o.sroa.0.0.vec.extract to half, !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %65), !dbg !195, !noalias !199
  %67 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !204
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !204, !noalias !199
  %68 = fptrunc float %acc_o.sroa.0.4.vec.extract to half, !dbg !204
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %67), !dbg !204, !noalias !199
  %69 = bitcast half %66 to i16, !dbg !206
  %70 = bitcast half %68 to i16, !dbg !209
  %71 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !210, !noalias !214
  %72 = fptrunc float %acc_o.sroa.0.8.vec.extract to half, !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %71), !dbg !210, !noalias !214
  %73 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !219
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !219, !noalias !214
  %74 = fptrunc float %acc_o.sroa.0.12.vec.extract to half, !dbg !219
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %73), !dbg !219, !noalias !214
  %75 = bitcast half %72 to i16, !dbg !221
  %76 = bitcast half %74 to i16, !dbg !223
  %__2.sroa.6.0.insert.ext = zext i16 %76 to i64, !dbg !224
  %__2.sroa.6.0.insert.shift = shl nuw i64 %__2.sroa.6.0.insert.ext, 48, !dbg !224
  %__2.sroa.5.0.insert.ext = zext i16 %75 to i64, !dbg !224
  %__2.sroa.5.0.insert.shift = shl nuw nsw i64 %__2.sroa.5.0.insert.ext, 32, !dbg !224
  %__2.sroa.5.0.insert.insert = or disjoint i64 %__2.sroa.6.0.insert.shift, %__2.sroa.5.0.insert.shift, !dbg !224
  %__2.sroa.4.0.insert.ext = zext i16 %70 to i64, !dbg !224
  %__2.sroa.4.0.insert.shift = shl nuw nsw i64 %__2.sroa.4.0.insert.ext, 16, !dbg !224
  %__2.sroa.4.0.insert.insert = or disjoint i64 %__2.sroa.5.0.insert.insert, %__2.sroa.4.0.insert.shift, !dbg !224
  %__2.sroa.0.0.insert.ext = zext i16 %69 to i64, !dbg !224
  %__2.sroa.0.0.insert.insert = or disjoint i64 %__2.sroa.4.0.insert.insert, %__2.sroa.0.0.insert.ext, !dbg !224
  %add.ptr477 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %64, !dbg !225
  store i64 %__2.sroa.0.0.insert.insert, ptr addrspace(1) %add.ptr477, align 8, !dbg !226
  %acc_o.sroa.12.16.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 0, !dbg !194
  %acc_o.sroa.12.20.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 1, !dbg !194
  %acc_o.sroa.12.24.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 2, !dbg !194
  %acc_o.sroa.12.28.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 3, !dbg !194
  %77 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !195, !noalias !199
  %78 = fptrunc float %acc_o.sroa.12.16.vec.extract to half, !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %77), !dbg !195, !noalias !199
  %79 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !204
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !204, !noalias !199
  %80 = fptrunc float %acc_o.sroa.12.20.vec.extract to half, !dbg !204
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %79), !dbg !204, !noalias !199
  %81 = bitcast half %78 to i16, !dbg !206
  %82 = bitcast half %80 to i16, !dbg !209
  %83 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !210, !noalias !214
  %84 = fptrunc float %acc_o.sroa.12.24.vec.extract to half, !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %83), !dbg !210, !noalias !214
  %85 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !219
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !219, !noalias !214
  %86 = fptrunc float %acc_o.sroa.12.28.vec.extract to half, !dbg !219
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %85), !dbg !219, !noalias !214
  %87 = bitcast half %84 to i16, !dbg !221
  %88 = bitcast half %86 to i16, !dbg !223
  %__2.sroa.6.0.insert.ext.1 = zext i16 %88 to i64, !dbg !224
  %__2.sroa.6.0.insert.shift.1 = shl nuw i64 %__2.sroa.6.0.insert.ext.1, 48, !dbg !224
  %__2.sroa.5.0.insert.ext.1 = zext i16 %87 to i64, !dbg !224
  %__2.sroa.5.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.1, 32, !dbg !224
  %__2.sroa.5.0.insert.insert.1 = or disjoint i64 %__2.sroa.6.0.insert.shift.1, %__2.sroa.5.0.insert.shift.1, !dbg !224
  %__2.sroa.4.0.insert.ext.1 = zext i16 %82 to i64, !dbg !224
  %__2.sroa.4.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.1, 16, !dbg !224
  %__2.sroa.4.0.insert.insert.1 = or disjoint i64 %__2.sroa.5.0.insert.insert.1, %__2.sroa.4.0.insert.shift.1, !dbg !224
  %__2.sroa.0.0.insert.ext.1 = zext i16 %81 to i64, !dbg !224
  %__2.sroa.0.0.insert.insert.1 = or disjoint i64 %__2.sroa.4.0.insert.insert.1, %__2.sroa.0.0.insert.ext.1, !dbg !224
  %89 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %64, !dbg !225
  %add.ptr477.1 = getelementptr inbounds i8, ptr addrspace(1) %89, i64 32, !dbg !225
  store i64 %__2.sroa.0.0.insert.insert.1, ptr addrspace(1) %add.ptr477.1, align 8, !dbg !226
  %acc_o.sroa.22.32.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 0, !dbg !194
  %acc_o.sroa.22.36.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 1, !dbg !194
  %acc_o.sroa.22.40.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 2, !dbg !194
  %acc_o.sroa.22.44.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 3, !dbg !194
  %90 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !195, !noalias !199
  %91 = fptrunc float %acc_o.sroa.22.32.vec.extract to half, !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %90), !dbg !195, !noalias !199
  %92 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !204
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !204, !noalias !199
  %93 = fptrunc float %acc_o.sroa.22.36.vec.extract to half, !dbg !204
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %92), !dbg !204, !noalias !199
  %94 = bitcast half %91 to i16, !dbg !206
  %95 = bitcast half %93 to i16, !dbg !209
  %96 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !210, !noalias !214
  %97 = fptrunc float %acc_o.sroa.22.40.vec.extract to half, !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %96), !dbg !210, !noalias !214
  %98 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !219
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !219, !noalias !214
  %99 = fptrunc float %acc_o.sroa.22.44.vec.extract to half, !dbg !219
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %98), !dbg !219, !noalias !214
  %100 = bitcast half %97 to i16, !dbg !221
  %101 = bitcast half %99 to i16, !dbg !223
  %__2.sroa.6.0.insert.ext.2 = zext i16 %101 to i64, !dbg !224
  %__2.sroa.6.0.insert.shift.2 = shl nuw i64 %__2.sroa.6.0.insert.ext.2, 48, !dbg !224
  %__2.sroa.5.0.insert.ext.2 = zext i16 %100 to i64, !dbg !224
  %__2.sroa.5.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.2, 32, !dbg !224
  %__2.sroa.5.0.insert.insert.2 = or disjoint i64 %__2.sroa.6.0.insert.shift.2, %__2.sroa.5.0.insert.shift.2, !dbg !224
  %__2.sroa.4.0.insert.ext.2 = zext i16 %95 to i64, !dbg !224
  %__2.sroa.4.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.2, 16, !dbg !224
  %__2.sroa.4.0.insert.insert.2 = or disjoint i64 %__2.sroa.5.0.insert.insert.2, %__2.sroa.4.0.insert.shift.2, !dbg !224
  %__2.sroa.0.0.insert.ext.2 = zext i16 %94 to i64, !dbg !224
  %__2.sroa.0.0.insert.insert.2 = or disjoint i64 %__2.sroa.4.0.insert.insert.2, %__2.sroa.0.0.insert.ext.2, !dbg !224
  %102 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %64, !dbg !225
  %add.ptr477.2 = getelementptr inbounds i8, ptr addrspace(1) %102, i64 64, !dbg !225
  store i64 %__2.sroa.0.0.insert.insert.2, ptr addrspace(1) %add.ptr477.2, align 8, !dbg !226
  %acc_o.sroa.32.48.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 0, !dbg !194
  %acc_o.sroa.32.52.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 1, !dbg !194
  %acc_o.sroa.32.56.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 2, !dbg !194
  %acc_o.sroa.32.60.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 3, !dbg !194
  %103 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !195, !noalias !199
  %104 = fptrunc float %acc_o.sroa.32.48.vec.extract to half, !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %103), !dbg !195, !noalias !199
  %105 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !204
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !204, !noalias !199
  %106 = fptrunc float %acc_o.sroa.32.52.vec.extract to half, !dbg !204
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %105), !dbg !204, !noalias !199
  %107 = bitcast half %104 to i16, !dbg !206
  %108 = bitcast half %106 to i16, !dbg !209
  %109 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !210, !noalias !214
  %110 = fptrunc float %acc_o.sroa.32.56.vec.extract to half, !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %109), !dbg !210, !noalias !214
  %111 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !219
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !219, !noalias !214
  %112 = fptrunc float %acc_o.sroa.32.60.vec.extract to half, !dbg !219
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %111), !dbg !219, !noalias !214
  %113 = bitcast half %110 to i16, !dbg !221
  %114 = bitcast half %112 to i16, !dbg !223
  %__2.sroa.6.0.insert.ext.3 = zext i16 %114 to i64, !dbg !224
  %__2.sroa.6.0.insert.shift.3 = shl nuw i64 %__2.sroa.6.0.insert.ext.3, 48, !dbg !224
  %__2.sroa.5.0.insert.ext.3 = zext i16 %113 to i64, !dbg !224
  %__2.sroa.5.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.3, 32, !dbg !224
  %__2.sroa.5.0.insert.insert.3 = or disjoint i64 %__2.sroa.6.0.insert.shift.3, %__2.sroa.5.0.insert.shift.3, !dbg !224
  %__2.sroa.4.0.insert.ext.3 = zext i16 %108 to i64, !dbg !224
  %__2.sroa.4.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.3, 16, !dbg !224
  %__2.sroa.4.0.insert.insert.3 = or disjoint i64 %__2.sroa.5.0.insert.insert.3, %__2.sroa.4.0.insert.shift.3, !dbg !224
  %__2.sroa.0.0.insert.ext.3 = zext i16 %107 to i64, !dbg !224
  %__2.sroa.0.0.insert.insert.3 = or disjoint i64 %__2.sroa.4.0.insert.insert.3, %__2.sroa.0.0.insert.ext.3, !dbg !224
  %115 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %64, !dbg !225
  %add.ptr477.3 = getelementptr inbounds i8, ptr addrspace(1) %115, i64 96, !dbg !225
  store i64 %__2.sroa.0.0.insert.insert.3, ptr addrspace(1) %add.ptr477.3, align 8, !dbg !226
  ret void, !dbg !227
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
!1 = !DIFile(filename: "/tmp/tmp_vlyj031/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmp_vlyj031/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 24, column: 3, scope: !40)
!44 = !DILocation(line: 25, column: 48, scope: !40)
!45 = !DILocation(line: 27, column: 47, scope: !40)
!46 = !DILocation(line: 27, column: 52, scope: !40)
!47 = !DILocation(line: 27, column: 14, scope: !40)
!48 = !DILocation(line: 27, column: 74, scope: !40)
!49 = !DILocation(line: 33, column: 11, scope: !40)
!50 = !DILocation(line: 33, column: 19, scope: !40)
!51 = !DILocation(line: 33, column: 27, scope: !40)
!52 = !DILocation(line: 33, column: 34, scope: !40)
!53 = !DILocation(line: 35, column: 5, scope: !40)
!54 = !DILocation(line: 38, column: 61, scope: !40)
!55 = !DILocation(line: 38, column: 11, scope: !40)
!56 = !DILocation(line: 39, column: 31, scope: !40)
!57 = !DILocation(line: 39, column: 17, scope: !40)
!58 = !DILocation(line: 40, column: 7, scope: !40)
!59 = !DILocation(line: 0, scope: !40)
!60 = !DILocation(line: 49, column: 11, scope: !40)
!61 = !DILocation(line: 50, column: 33, scope: !40)
!62 = !DILocation(line: 50, column: 19, scope: !40)
!63 = !DILocation(line: 51, column: 7, scope: !40)
!64 = !DILocation(line: 57, column: 5, scope: !40)
!65 = !DILocation(line: 58, column: 159, scope: !40)
!66 = !{i32 -1, i32 3, i32 -1, i32 -1}
!67 = !DILocation(line: 58, column: 42, scope: !40)
!68 = !DILocation(line: 68, column: 3, scope: !69, inlinedAt: !71)
!69 = distinct !DISubprogram(name: "__barrier_warp", scope: !70, file: !70, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!70 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!71 = distinct !DILocation(line: 192, column: 3, scope: !72, inlinedAt: !73)
!72 = distinct !DISubprogram(name: "__syncwarp", scope: !70, file: !70, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!73 = distinct !DILocation(line: 60, column: 5, scope: !40)
!74 = !DILocation(line: 69, column: 3, scope: !69, inlinedAt: !71)
!75 = !DILocation(line: 70, column: 3, scope: !69, inlinedAt: !71)
!76 = !DILocation(line: 63, column: 153, scope: !40)
!77 = !DILocation(line: 63, column: 73, scope: !40)
!78 = !DILocation(line: 63, column: 36, scope: !40)
!79 = !DILocation(line: 63, column: 124, scope: !40)
!80 = !DILocation(line: 68, column: 3, scope: !69, inlinedAt: !81)
!81 = distinct !DILocation(line: 192, column: 3, scope: !72, inlinedAt: !82)
!82 = distinct !DILocation(line: 65, column: 5, scope: !40)
!83 = !DILocation(line: 69, column: 3, scope: !69, inlinedAt: !81)
!84 = !DILocation(line: 70, column: 3, scope: !69, inlinedAt: !81)
!85 = !DILocation(line: 68, column: 159, scope: !40)
!86 = !DILocation(line: 70, column: 34, scope: !40)
!87 = !DILocation(line: 70, column: 27, scope: !40)
!88 = !DILocation(line: 70, column: 9, scope: !40)
!89 = !DILocation(line: 74, column: 62, scope: !40)
!90 = !DILocation(line: 74, column: 13, scope: !40)
!91 = !DILocation(line: 79, column: 20, scope: !40)
!92 = !DILocation(line: 74, column: 55, scope: !40)
!93 = !DILocation(line: 68, column: 3, scope: !69, inlinedAt: !94)
!94 = distinct !DILocation(line: 192, column: 3, scope: !72, inlinedAt: !95)
!95 = distinct !DILocation(line: 85, column: 5, scope: !40)
!96 = !DILocation(line: 69, column: 3, scope: !69, inlinedAt: !94)
!97 = !DILocation(line: 70, column: 3, scope: !69, inlinedAt: !94)
!98 = !DILocation(line: 87, column: 25, scope: !40)
!99 = !DILocation(line: 90, column: 36, scope: !40)
!100 = !DILocation(line: 68, column: 3, scope: !69, inlinedAt: !101)
!101 = distinct !DILocation(line: 192, column: 3, scope: !72, inlinedAt: !102)
!102 = distinct !DILocation(line: 96, column: 5, scope: !40)
!103 = !DILocation(line: 69, column: 3, scope: !69, inlinedAt: !101)
!104 = !DILocation(line: 70, column: 3, scope: !69, inlinedAt: !101)
!105 = !DILocation(line: 98, column: 10, scope: !40)
!106 = !DILocation(line: 99, column: 86, scope: !40)
!107 = !DILocation(line: 99, column: 42, scope: !40)
!108 = !DILocation(line: 103, column: 31, scope: !40)
!109 = !DILocation(line: 103, column: 42, scope: !40)
!110 = !DILocation(line: 354, column: 10, scope: !111, inlinedAt: !113)
!111 = distinct !DISubprogram(name: "min", scope: !112, file: !112, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!112 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!113 = distinct !DILocation(line: 103, column: 26, scope: !40)
!114 = !DILocation(line: 285, column: 49, scope: !115, inlinedAt: !116)
!115 = distinct !DISubprogram(name: "exp2f", scope: !112, file: !112, line: 285, type: !7, scopeLine: 285, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!116 = distinct !DILocation(line: 103, column: 20, scope: !40)
!117 = !DILocation(line: 108, column: 34, scope: !40)
!118 = !DILocation(line: 1018, column: 9, scope: !119, inlinedAt: !120)
!119 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !70, file: !70, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!120 = distinct !DILocation(line: 110, column: 34, scope: !40)
!121 = !DILocation(line: 171, column: 37, scope: !122, inlinedAt: !123)
!122 = distinct !DISubprogram(name: "__lane_id", scope: !70, file: !70, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!123 = distinct !DILocation(line: 990, column: 14, scope: !124, inlinedAt: !125)
!124 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !70, file: !70, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!125 = distinct !DILocation(line: 1019, column: 11, scope: !119, inlinedAt: !120)
!126 = !DILocation(line: 171, column: 10, scope: !122, inlinedAt: !123)
!127 = !DILocation(line: 991, column: 20, scope: !124, inlinedAt: !125)
!128 = !DILocation(line: 992, column: 36, scope: !124, inlinedAt: !125)
!129 = !DILocation(line: 992, column: 17, scope: !124, inlinedAt: !125)
!130 = !DILocation(line: 992, column: 11, scope: !124, inlinedAt: !125)
!131 = !DILocation(line: 993, column: 43, scope: !124, inlinedAt: !125)
!132 = !DILocation(line: 993, column: 10, scope: !124, inlinedAt: !125)
!133 = !DILocation(line: 1020, column: 14, scope: !119, inlinedAt: !120)
!134 = !DILocation(line: 110, column: 32, scope: !40)
!135 = !DILocation(line: 1018, column: 9, scope: !119, inlinedAt: !136)
!136 = distinct !DILocation(line: 111, column: 34, scope: !40)
!137 = !DILocation(line: 171, column: 37, scope: !122, inlinedAt: !138)
!138 = distinct !DILocation(line: 990, column: 14, scope: !124, inlinedAt: !139)
!139 = distinct !DILocation(line: 1019, column: 11, scope: !119, inlinedAt: !136)
!140 = !DILocation(line: 171, column: 10, scope: !122, inlinedAt: !138)
!141 = !DILocation(line: 991, column: 20, scope: !124, inlinedAt: !139)
!142 = !DILocation(line: 992, column: 36, scope: !124, inlinedAt: !139)
!143 = !DILocation(line: 992, column: 17, scope: !124, inlinedAt: !139)
!144 = !DILocation(line: 992, column: 11, scope: !124, inlinedAt: !139)
!145 = !DILocation(line: 993, column: 43, scope: !124, inlinedAt: !139)
!146 = !DILocation(line: 993, column: 10, scope: !124, inlinedAt: !139)
!147 = !DILocation(line: 1020, column: 14, scope: !119, inlinedAt: !136)
!148 = !DILocation(line: 111, column: 32, scope: !40)
!149 = !DILocation(line: 113, column: 34, scope: !40)
!150 = !DILocation(line: 113, column: 9, scope: !40)
!151 = !DILocation(line: 121, column: 34, scope: !40)
!152 = !DILocation(line: 1007, column: 10, scope: !153, inlinedAt: !155)
!153 = distinct !DISubprogram(name: "__float2half_rn", scope: !154, file: !154, line: 1005, type: !7, scopeLine: 1005, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!154 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!155 = distinct !DILocation(line: 1077, column: 18, scope: !156, inlinedAt: !157)
!156 = distinct !DISubprogram(name: "__floats2half2_rn", scope: !154, file: !154, line: 1075, type: !7, scopeLine: 1076, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!157 = distinct !DILocation(line: 1295, column: 23, scope: !158, inlinedAt: !159)
!158 = distinct !DISubprogram(name: "__float22half2_rn", scope: !154, file: !154, line: 1294, type: !7, scopeLine: 1294, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!159 = distinct !DILocation(line: 125, column: 27, scope: !40)
!160 = !{!161, !163}
!161 = distinct !{!161, !162, !"_ZL17__floats2half2_rnff: %agg.result"}
!162 = distinct !{!162, !"_ZL17__floats2half2_rnff"}
!163 = distinct !{!163, !164, !"_ZL17__float22half2_rn6float2: %agg.result"}
!164 = distinct !{!164, !"_ZL17__float22half2_rn6float2"}
!165 = !DILocation(line: 1007, column: 10, scope: !153, inlinedAt: !166)
!166 = distinct !DILocation(line: 1077, column: 38, scope: !156, inlinedAt: !157)
!167 = !DILocation(line: 593, column: 26, scope: !168, inlinedAt: !169)
!168 = distinct !DISubprogram(name: "operator=", scope: !154, file: !154, line: 592, type: !7, scopeLine: 592, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!169 = distinct !DILocation(line: 125, column: 25, scope: !40)
!170 = !DILocation(line: 1007, column: 10, scope: !153, inlinedAt: !171)
!171 = distinct !DILocation(line: 1077, column: 18, scope: !156, inlinedAt: !172)
!172 = distinct !DILocation(line: 1295, column: 23, scope: !158, inlinedAt: !173)
!173 = distinct !DILocation(line: 126, column: 27, scope: !40)
!174 = !{!175, !177}
!175 = distinct !{!175, !176, !"_ZL17__floats2half2_rnff: %agg.result"}
!176 = distinct !{!176, !"_ZL17__floats2half2_rnff"}
!177 = distinct !{!177, !178, !"_ZL17__float22half2_rn6float2: %agg.result"}
!178 = distinct !{!178, !"_ZL17__float22half2_rn6float2"}
!179 = !DILocation(line: 1007, column: 10, scope: !153, inlinedAt: !180)
!180 = distinct !DILocation(line: 1077, column: 38, scope: !156, inlinedAt: !172)
!181 = !DILocation(line: 593, column: 26, scope: !168, inlinedAt: !182)
!182 = distinct !DILocation(line: 126, column: 25, scope: !40)
!183 = !DILocation(line: 68, column: 3, scope: !69, inlinedAt: !184)
!184 = distinct !DILocation(line: 192, column: 3, scope: !72, inlinedAt: !185)
!185 = distinct !DILocation(line: 128, column: 5, scope: !40)
!186 = !DILocation(line: 69, column: 3, scope: !69, inlinedAt: !184)
!187 = !DILocation(line: 70, column: 3, scope: !69, inlinedAt: !184)
!188 = !DILocation(line: 131, column: 119, scope: !40)
!189 = !DILocation(line: 131, column: 31, scope: !40)
!190 = !DILocation(line: 131, column: 29, scope: !40)
!191 = !{!26, !26, i64 0}
!192 = !DILocation(line: 136, column: 38, scope: !40)
!193 = !DILocation(line: 143, column: 3, scope: !40)
!194 = !DILocation(line: 145, column: 19, scope: !40)
!195 = !DILocation(line: 1007, column: 10, scope: !153, inlinedAt: !196)
!196 = distinct !DILocation(line: 1077, column: 18, scope: !156, inlinedAt: !197)
!197 = distinct !DILocation(line: 1295, column: 23, scope: !158, inlinedAt: !198)
!198 = distinct !DILocation(line: 146, column: 27, scope: !40)
!199 = !{!200, !202}
!200 = distinct !{!200, !201, !"_ZL17__floats2half2_rnff: %agg.result"}
!201 = distinct !{!201, !"_ZL17__floats2half2_rnff"}
!202 = distinct !{!202, !203, !"_ZL17__float22half2_rn6float2: %agg.result"}
!203 = distinct !{!203, !"_ZL17__float22half2_rn6float2"}
!204 = !DILocation(line: 1007, column: 10, scope: !153, inlinedAt: !205)
!205 = distinct !DILocation(line: 1077, column: 38, scope: !156, inlinedAt: !197)
!206 = !DILocation(line: 596, column: 67, scope: !207, inlinedAt: !208)
!207 = distinct !DISubprogram(name: "__half2", scope: !154, file: !154, line: 596, type: !7, scopeLine: 596, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!208 = distinct !DILocation(line: 1077, column: 10, scope: !156, inlinedAt: !197)
!209 = !DILocation(line: 596, column: 73, scope: !207, inlinedAt: !208)
!210 = !DILocation(line: 1007, column: 10, scope: !153, inlinedAt: !211)
!211 = distinct !DILocation(line: 1077, column: 18, scope: !156, inlinedAt: !212)
!212 = distinct !DILocation(line: 1295, column: 23, scope: !158, inlinedAt: !213)
!213 = distinct !DILocation(line: 147, column: 27, scope: !40)
!214 = !{!215, !217}
!215 = distinct !{!215, !216, !"_ZL17__floats2half2_rnff: %agg.result"}
!216 = distinct !{!216, !"_ZL17__floats2half2_rnff"}
!217 = distinct !{!217, !218, !"_ZL17__float22half2_rn6float2: %agg.result"}
!218 = distinct !{!218, !"_ZL17__float22half2_rn6float2"}
!219 = !DILocation(line: 1007, column: 10, scope: !153, inlinedAt: !220)
!220 = distinct !DILocation(line: 1077, column: 38, scope: !156, inlinedAt: !212)
!221 = !DILocation(line: 596, column: 67, scope: !207, inlinedAt: !222)
!222 = distinct !DILocation(line: 1077, column: 10, scope: !156, inlinedAt: !212)
!223 = !DILocation(line: 596, column: 73, scope: !207, inlinedAt: !222)
!224 = !DILocation(line: 148, column: 38, scope: !40)
!225 = !DILocation(line: 149, column: 22, scope: !40)
!226 = !DILocation(line: 149, column: 172, scope: !40)
!227 = !DILocation(line: 151, column: 1, scope: !40)
