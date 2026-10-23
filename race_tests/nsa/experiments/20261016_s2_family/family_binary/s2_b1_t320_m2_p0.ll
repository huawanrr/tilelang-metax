; ModuleID = 'experiments/20261016_s2_family/family_binary/s2_b1_t320_m2_p0.bc'
source_filename = "/tmp/tmpul088o9c/tvm_kernels.maca"
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
  %mul8 = shl nuw nsw i32 %1, 2
  %add = add nuw nsw i32 %mul8, %mul
  %2 = zext nneg i32 %add to i64, !dbg !43
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %2, !dbg !44
  %3 = load i64, ptr addrspace(4) %add.ptr, align 8, !dbg !45
  %4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %2, !dbg !44
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %4, i64 512, !dbg !44
  %5 = load i64, ptr addrspace(4) %add.ptr.1, align 8, !dbg !45
  %6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %2, !dbg !44
  %add.ptr.2 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 1024, !dbg !44
  %7 = load i64, ptr addrspace(4) %add.ptr.2, align 8, !dbg !45
  %8 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %2, !dbg !44
  %add.ptr.3 = getelementptr inbounds i8, ptr addrspace(4) %8, i64 1536, !dbg !44
  %9 = load i64, ptr addrspace(4) %add.ptr.3, align 8, !dbg !45
  %mul19 = shl nuw nsw i32 %0, 1
  %10 = zext nneg i32 %mul19 to i64, !dbg !46
  %arrayidx21 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10, !dbg !47
  %11 = load i32, ptr addrspace(1) %arrayidx21, align 4, !dbg !47, !tbaa !30
  %cmp23 = icmp ult i32 %11, 20
  %12 = shl nsw i32 %11, 4, !dbg !48
  %mul24 = select i1 %cmp23, i32 %12, i32 -16, !dbg !48
  %13 = or disjoint i64 %10, 1, !dbg !49
  %arrayidx21.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %13, !dbg !47
  %14 = load i32, ptr addrspace(1) %arrayidx21.1, align 4, !dbg !47, !tbaa !30
  %cmp23.1 = icmp ult i32 %14, 20
  %15 = shl nsw i32 %14, 4, !dbg !48
  %mul24.1 = select i1 %cmp23.1, i32 %15, i32 -16, !dbg !48
  %shr58 = lshr i32 %1, 3
  %16 = shl nuw nsw i32 %1, 3
  %17 = and i32 %16, 56
  %add54 = add nsw i32 %shr58, %mul24, !dbg !50
  %or.cond = icmp ult i32 %add54, 320, !dbg !51
  br i1 %or.cond, label %if.then66, label %if.then49.1, !dbg !51

if.then66:                                        ; preds = %entry
  %18 = shl nuw nsw i32 %add54, 6
  %add71843 = or disjoint i32 %18, %17
  %add71 = zext nneg i32 %add71843 to i64
  %add.ptr72 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add71
  %condval_2.sroa.7.0.add.ptr72.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr72, i64 12
  %condval_2.sroa.6.0.add.ptr72.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr72, i64 8
  %condval_2.sroa.5.0.add.ptr72.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr72, i64 4
  %condval_2.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr72, align 16, !dbg !52, !tbaa !30
  %condval_2.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr72.sroa_idx, align 4, !dbg !52, !tbaa !30
  %condval_2.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr72.sroa_idx, align 8, !dbg !52, !tbaa !30
  %condval_2.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr72.sroa_idx, align 4, !dbg !52, !tbaa !30
  br label %if.then49.1, !dbg !53

if.then49.1:                                      ; preds = %if.then66, %entry
  %condval_2.sroa.0.0 = phi i32 [ %condval_2.sroa.0.0.copyload, %if.then66 ], [ 0, %entry ], !dbg !54
  %condval_2.sroa.5.0 = phi i32 [ %condval_2.sroa.5.0.copyload, %if.then66 ], [ 0, %entry ], !dbg !54
  %condval_2.sroa.6.0 = phi i32 [ %condval_2.sroa.6.0.copyload, %if.then66 ], [ 0, %entry ], !dbg !54
  %condval_2.sroa.7.0 = phi i32 [ %condval_2.sroa.7.0.copyload, %if.then66 ], [ 0, %entry ], !dbg !54
  %add52.1 = add nuw nsw i32 %shr58, 8, !dbg !55
  %add54.1 = add nsw i32 %add52.1, %mul24, !dbg !50
  %or.cond.1 = icmp ult i32 %add54.1, 320, !dbg !51
  br i1 %or.cond.1, label %if.then66.1, label %if.else55.2, !dbg !51

if.then66.1:                                      ; preds = %if.then49.1
  %19 = shl nuw nsw i32 %add54.1, 6
  %add71843.1 = or disjoint i32 %19, %17
  %add71.1 = zext nneg i32 %add71843.1 to i64
  %add.ptr72.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add71.1
  %condval_2.sroa.7.0.add.ptr72.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr72.1, i64 12
  %condval_2.sroa.6.0.add.ptr72.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr72.1, i64 8
  %condval_2.sroa.5.0.add.ptr72.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr72.1, i64 4
  %condval_2.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr72.1, align 16, !dbg !52, !tbaa !30
  %condval_2.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr72.sroa_idx.1, align 4, !dbg !52, !tbaa !30
  %condval_2.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr72.sroa_idx.1, align 8, !dbg !52, !tbaa !30
  %condval_2.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr72.sroa_idx.1, align 4, !dbg !52, !tbaa !30
  br label %if.else55.2, !dbg !53

if.else55.2:                                      ; preds = %if.then49.1, %if.then66.1
  %condval_2.sroa.0.0.1 = phi i32 [ %condval_2.sroa.0.0.copyload.1, %if.then66.1 ], [ 0, %if.then49.1 ], !dbg !54
  %condval_2.sroa.5.0.1 = phi i32 [ %condval_2.sroa.5.0.copyload.1, %if.then66.1 ], [ 0, %if.then49.1 ], !dbg !54
  %condval_2.sroa.6.0.1 = phi i32 [ %condval_2.sroa.6.0.copyload.1, %if.then66.1 ], [ 0, %if.then49.1 ], !dbg !54
  %condval_2.sroa.7.0.1 = phi i32 [ %condval_2.sroa.7.0.copyload.1, %if.then66.1 ], [ 0, %if.then49.1 ], !dbg !54
  %sub.2 = add i32 %shr58, %mul24.1, !dbg !56
  %or.cond.2 = icmp ult i32 %sub.2, 320, !dbg !51
  br i1 %or.cond.2, label %if.then66.2, label %if.else55.3, !dbg !51

if.then66.2:                                      ; preds = %if.else55.2
  %20 = shl nuw nsw i32 %sub.2, 6
  %add71843.2 = or disjoint i32 %20, %17
  %add71.2 = zext nneg i32 %add71843.2 to i64
  %add.ptr72.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add71.2
  %condval_2.sroa.7.0.add.ptr72.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr72.2, i64 12
  %condval_2.sroa.6.0.add.ptr72.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr72.2, i64 8
  %condval_2.sroa.5.0.add.ptr72.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr72.2, i64 4
  %condval_2.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %add.ptr72.2, align 16, !dbg !52, !tbaa !30
  %condval_2.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr72.sroa_idx.2, align 4, !dbg !52, !tbaa !30
  %condval_2.sroa.6.0.copyload.2 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr72.sroa_idx.2, align 8, !dbg !52, !tbaa !30
  %condval_2.sroa.7.0.copyload.2 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr72.sroa_idx.2, align 4, !dbg !52, !tbaa !30
  br label %if.else55.3, !dbg !53

if.else55.3:                                      ; preds = %if.else55.2, %if.then66.2
  %condval_2.sroa.0.0.2 = phi i32 [ %condval_2.sroa.0.0.copyload.2, %if.then66.2 ], [ 0, %if.else55.2 ], !dbg !54
  %condval_2.sroa.5.0.2 = phi i32 [ %condval_2.sroa.5.0.copyload.2, %if.then66.2 ], [ 0, %if.else55.2 ], !dbg !54
  %condval_2.sroa.6.0.2 = phi i32 [ %condval_2.sroa.6.0.copyload.2, %if.then66.2 ], [ 0, %if.else55.2 ], !dbg !54
  %condval_2.sroa.7.0.2 = phi i32 [ %condval_2.sroa.7.0.copyload.2, %if.then66.2 ], [ 0, %if.else55.2 ], !dbg !54
  %add61.3 = add nuw nsw i32 %shr58, 8, !dbg !57
  %sub.3 = add i32 %add61.3, %mul24.1, !dbg !56
  %or.cond.3 = icmp ult i32 %sub.3, 320, !dbg !51
  br i1 %or.cond.3, label %if.then66.3, label %if.then108, !dbg !51

if.then66.3:                                      ; preds = %if.else55.3
  %21 = shl nuw nsw i32 %sub.3, 6
  %add71843.3 = or disjoint i32 %21, %17
  %add71.3 = zext nneg i32 %add71843.3 to i64
  %add.ptr72.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %add71.3
  %condval_2.sroa.7.0.add.ptr72.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr72.3, i64 12
  %condval_2.sroa.6.0.add.ptr72.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr72.3, i64 8
  %condval_2.sroa.5.0.add.ptr72.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr72.3, i64 4
  %condval_2.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %add.ptr72.3, align 16, !dbg !52, !tbaa !30
  %condval_2.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr72.sroa_idx.3, align 4, !dbg !52, !tbaa !30
  %condval_2.sroa.6.0.copyload.3 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr72.sroa_idx.3, align 8, !dbg !52, !tbaa !30
  %condval_2.sroa.7.0.copyload.3 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr72.sroa_idx.3, align 4, !dbg !52, !tbaa !30
  br label %if.then108, !dbg !53

if.then108:                                       ; preds = %if.else55.3, %if.then66.3
  %condval_2.sroa.0.0.3 = phi i32 [ %condval_2.sroa.0.0.copyload.3, %if.then66.3 ], [ 0, %if.else55.3 ], !dbg !54
  %condval_2.sroa.5.0.3 = phi i32 [ %condval_2.sroa.5.0.copyload.3, %if.then66.3 ], [ 0, %if.else55.3 ], !dbg !54
  %condval_2.sroa.6.0.3 = phi i32 [ %condval_2.sroa.6.0.copyload.3, %if.then66.3 ], [ 0, %if.else55.3 ], !dbg !54
  %condval_2.sroa.7.0.3 = phi i32 [ %condval_2.sroa.7.0.copyload.3, %if.then66.3 ], [ 0, %if.else55.3 ], !dbg !54
  %add114 = add nsw i32 %shr58, %mul24, !dbg !58
  %or.cond766 = icmp ult i32 %add114, 320, !dbg !59
  br i1 %or.cond766, label %if.then127, label %if.then108.1, !dbg !59

if.then127:                                       ; preds = %if.then108
  %22 = shl nuw nsw i32 %add114, 6
  %add134844 = or disjoint i32 %22, %17
  %add134 = zext nneg i32 %add134844 to i64
  %add.ptr135 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add134
  %condval_4.sroa.7.0.add.ptr135.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr135, i64 12
  %condval_4.sroa.6.0.add.ptr135.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr135, i64 8
  %condval_4.sroa.5.0.add.ptr135.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr135, i64 4
  %condval_4.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr135, align 16, !dbg !60, !tbaa !30
  %condval_4.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr135.sroa_idx, align 4, !dbg !60, !tbaa !30
  %condval_4.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr135.sroa_idx, align 8, !dbg !60, !tbaa !30
  %condval_4.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr135.sroa_idx, align 4, !dbg !60, !tbaa !30
  br label %if.then108.1, !dbg !61

if.then108.1:                                     ; preds = %if.then127, %if.then108
  %condval_4.sroa.0.0 = phi i32 [ %condval_4.sroa.0.0.copyload, %if.then127 ], [ 0, %if.then108 ], !dbg !54
  %condval_4.sroa.5.0 = phi i32 [ %condval_4.sroa.5.0.copyload, %if.then127 ], [ 0, %if.then108 ], !dbg !54
  %condval_4.sroa.6.0 = phi i32 [ %condval_4.sroa.6.0.copyload, %if.then127 ], [ 0, %if.then108 ], !dbg !54
  %condval_4.sroa.7.0 = phi i32 [ %condval_4.sroa.7.0.copyload, %if.then127 ], [ 0, %if.then108 ], !dbg !54
  %add112.1 = add nuw nsw i32 %shr58, 8, !dbg !62
  %add114.1 = add nsw i32 %add112.1, %mul24, !dbg !58
  %or.cond766.1 = icmp ult i32 %add114.1, 320, !dbg !59
  br i1 %or.cond766.1, label %if.then127.1, label %if.else115.2, !dbg !59

if.then127.1:                                     ; preds = %if.then108.1
  %23 = shl nuw nsw i32 %add114.1, 6
  %add134844.1 = or disjoint i32 %23, %17
  %add134.1 = zext nneg i32 %add134844.1 to i64
  %add.ptr135.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add134.1
  %condval_4.sroa.7.0.add.ptr135.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr135.1, i64 12
  %condval_4.sroa.6.0.add.ptr135.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr135.1, i64 8
  %condval_4.sroa.5.0.add.ptr135.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr135.1, i64 4
  %condval_4.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr135.1, align 16, !dbg !60, !tbaa !30
  %condval_4.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr135.sroa_idx.1, align 4, !dbg !60, !tbaa !30
  %condval_4.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr135.sroa_idx.1, align 8, !dbg !60, !tbaa !30
  %condval_4.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr135.sroa_idx.1, align 4, !dbg !60, !tbaa !30
  br label %if.else115.2, !dbg !61

if.else115.2:                                     ; preds = %if.then108.1, %if.then127.1
  %condval_4.sroa.0.0.1 = phi i32 [ %condval_4.sroa.0.0.copyload.1, %if.then127.1 ], [ 0, %if.then108.1 ], !dbg !54
  %condval_4.sroa.5.0.1 = phi i32 [ %condval_4.sroa.5.0.copyload.1, %if.then127.1 ], [ 0, %if.then108.1 ], !dbg !54
  %condval_4.sroa.6.0.1 = phi i32 [ %condval_4.sroa.6.0.copyload.1, %if.then127.1 ], [ 0, %if.then108.1 ], !dbg !54
  %condval_4.sroa.7.0.1 = phi i32 [ %condval_4.sroa.7.0.copyload.1, %if.then127.1 ], [ 0, %if.then108.1 ], !dbg !54
  %sub122.2 = add i32 %shr58, %mul24.1, !dbg !63
  %or.cond766.2 = icmp ult i32 %sub122.2, 320, !dbg !59
  br i1 %or.cond766.2, label %if.then127.2, label %if.else115.3, !dbg !59

if.then127.2:                                     ; preds = %if.else115.2
  %24 = shl nuw nsw i32 %sub122.2, 6
  %add134844.2 = or disjoint i32 %24, %17
  %add134.2 = zext nneg i32 %add134844.2 to i64
  %add.ptr135.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add134.2
  %condval_4.sroa.7.0.add.ptr135.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr135.2, i64 12
  %condval_4.sroa.6.0.add.ptr135.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr135.2, i64 8
  %condval_4.sroa.5.0.add.ptr135.sroa_idx.2 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr135.2, i64 4
  %condval_4.sroa.0.0.copyload.2 = load i32, ptr addrspace(4) %add.ptr135.2, align 16, !dbg !60, !tbaa !30
  %condval_4.sroa.5.0.copyload.2 = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr135.sroa_idx.2, align 4, !dbg !60, !tbaa !30
  %condval_4.sroa.6.0.copyload.2 = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr135.sroa_idx.2, align 8, !dbg !60, !tbaa !30
  %condval_4.sroa.7.0.copyload.2 = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr135.sroa_idx.2, align 4, !dbg !60, !tbaa !30
  br label %if.else115.3, !dbg !61

if.else115.3:                                     ; preds = %if.else115.2, %if.then127.2
  %condval_4.sroa.0.0.2 = phi i32 [ %condval_4.sroa.0.0.copyload.2, %if.then127.2 ], [ 0, %if.else115.2 ], !dbg !54
  %condval_4.sroa.5.0.2 = phi i32 [ %condval_4.sroa.5.0.copyload.2, %if.then127.2 ], [ 0, %if.else115.2 ], !dbg !54
  %condval_4.sroa.6.0.2 = phi i32 [ %condval_4.sroa.6.0.copyload.2, %if.then127.2 ], [ 0, %if.else115.2 ], !dbg !54
  %condval_4.sroa.7.0.2 = phi i32 [ %condval_4.sroa.7.0.copyload.2, %if.then127.2 ], [ 0, %if.else115.2 ], !dbg !54
  %add121.3 = add nuw nsw i32 %shr58, 8, !dbg !64
  %sub122.3 = add i32 %add121.3, %mul24.1, !dbg !63
  %or.cond766.3 = icmp ult i32 %sub122.3, 320, !dbg !59
  br i1 %or.cond766.3, label %if.then127.3, label %if.end159.3, !dbg !59

if.then127.3:                                     ; preds = %if.else115.3
  %25 = shl nuw nsw i32 %sub122.3, 6
  %add134844.3 = or disjoint i32 %25, %17
  %add134.3 = zext nneg i32 %add134844.3 to i64
  %add.ptr135.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %add134.3
  %condval_4.sroa.7.0.add.ptr135.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr135.3, i64 12
  %condval_4.sroa.6.0.add.ptr135.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr135.3, i64 8
  %condval_4.sroa.5.0.add.ptr135.sroa_idx.3 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr135.3, i64 4
  %condval_4.sroa.0.0.copyload.3 = load i32, ptr addrspace(4) %add.ptr135.3, align 16, !dbg !60, !tbaa !30
  %condval_4.sroa.5.0.copyload.3 = load i32, ptr addrspace(4) %condval_4.sroa.5.0.add.ptr135.sroa_idx.3, align 4, !dbg !60, !tbaa !30
  %condval_4.sroa.6.0.copyload.3 = load i32, ptr addrspace(4) %condval_4.sroa.6.0.add.ptr135.sroa_idx.3, align 8, !dbg !60, !tbaa !30
  %condval_4.sroa.7.0.copyload.3 = load i32, ptr addrspace(4) %condval_4.sroa.7.0.add.ptr135.sroa_idx.3, align 4, !dbg !60, !tbaa !30
  br label %if.end159.3, !dbg !61

if.end159.3:                                      ; preds = %if.then127.3, %if.else115.3
  %condval_4.sroa.0.0.3 = phi i32 [ %condval_4.sroa.0.0.copyload.3, %if.then127.3 ], [ 0, %if.else115.3 ], !dbg !54
  %condval_4.sroa.5.0.3 = phi i32 [ %condval_4.sroa.5.0.copyload.3, %if.then127.3 ], [ 0, %if.else115.3 ], !dbg !54
  %condval_4.sroa.6.0.3 = phi i32 [ %condval_4.sroa.6.0.copyload.3, %if.then127.3 ], [ 0, %if.else115.3 ], !dbg !54
  %condval_4.sroa.7.0.3 = phi i32 [ %condval_4.sroa.7.0.copyload.3, %if.then127.3 ], [ 0, %if.else115.3 ], !dbg !54
  %and182 = lshr i32 %1, 1
  %shr183 = and i32 %and182, 7
  %shr187 = lshr i32 %1, 4
  %add180 = and i32 %mul8, 4036
  %xor = xor i32 %shr187, %shr183, !dbg !65
  %26 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add180, !dbg !66
  %add.ptr196.idx = shl nuw nsw i32 %xor, 4, !dbg !66
  %add.ptr196 = getelementptr inbounds i8, ptr addrspace(3) %26, i32 %add.ptr196.idx, !dbg !66
  store i64 %3, ptr addrspace(3) %add.ptr196, align 8, !dbg !67
  %add188.1 = add nuw nsw i32 %shr187, 4, !dbg !68
  %xor.1 = xor i32 %add188.1, %shr183, !dbg !65
  %27 = getelementptr inbounds i8, ptr addrspace(3) %26, i32 512, !dbg !66
  %add.ptr196.idx.1 = shl nuw nsw i32 %xor.1, 4, !dbg !66
  %add.ptr196.1 = getelementptr inbounds i8, ptr addrspace(3) %27, i32 %add.ptr196.idx.1, !dbg !66
  store i64 %5, ptr addrspace(3) %add.ptr196.1, align 8, !dbg !67
  %28 = getelementptr inbounds i8, ptr addrspace(3) %26, i32 1024, !dbg !66
  %add.ptr196.2 = getelementptr inbounds i8, ptr addrspace(3) %28, i32 %add.ptr196.idx, !dbg !66
  store i64 %7, ptr addrspace(3) %add.ptr196.2, align 8, !dbg !67
  %29 = getelementptr inbounds i8, ptr addrspace(3) %26, i32 1536, !dbg !66
  %add.ptr196.3 = getelementptr inbounds i8, ptr addrspace(3) %29, i32 %add.ptr196.idx.1, !dbg !66
  store i64 %9, ptr addrspace(3) %add.ptr196.3, align 8, !dbg !67
  fence syncscope("warp") release, !dbg !69
  tail call void @llvm.mxc.barrier.warp(), !dbg !75
  fence syncscope("warp") acquire, !dbg !76
  %and206 = shl nuw nsw i32 %1, 6
  %mul207 = and i32 %and206, 960
  %and213 = and i32 %1, 7
  %30 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul207
  %xor214 = xor i32 %shr187, %and213, !dbg !77
  %add.ptr218.idx = shl nuw nsw i32 %xor214, 4, !dbg !78
  %add.ptr218 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 %add.ptr218.idx, !dbg !78
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr218, align 16, !dbg !79
  %Q_reg.sroa.4.0.add.ptr218.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr218, i32 8, !dbg !79
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr218.sroa_idx, align 8, !dbg !79
  %xor214.1 = xor i32 %add188.1, %and213, !dbg !77
  %add.ptr218.idx.1 = shl nuw nsw i32 %xor214.1, 4, !dbg !78
  %add.ptr218.1 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 %add.ptr218.idx.1, !dbg !78
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr218.1, align 16, !dbg !79
  %Q_reg.sroa.7.16.add.ptr218.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr218.1, i32 8, !dbg !79
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr218.1.sroa_idx, align 8, !dbg !79
  fence syncscope("warp") release, !dbg !80
  tail call void @llvm.mxc.barrier.warp(), !dbg !83
  fence syncscope("warp") acquire, !dbg !84
  %mul238 = and i32 %16, 8128
  %call242.masked = and i32 %1, 1016
  %mul245 = xor i32 %17, %call242.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul238, !dbg !85
  %invariant.gep815 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul245, !dbg !85
  store i32 %condval_2.sroa.0.0, ptr addrspace(3) %invariant.gep815, align 16, !dbg !86, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep815.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep815, i32 4, !dbg !86
  store i32 %condval_2.sroa.5.0, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep815.sroa_idx, align 4, !dbg !86, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep815.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep815, i32 8, !dbg !86
  store i32 %condval_2.sroa.6.0, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep815.sroa_idx, align 8, !dbg !86, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep815.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep815, i32 12, !dbg !86
  store i32 %condval_2.sroa.7.0, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep815.sroa_idx, align 4, !dbg !86, !tbaa !30
  %gep816.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep815, i32 1024, !dbg !87
  store i32 %condval_2.sroa.0.0.1, ptr addrspace(3) %gep816.1, align 16, !dbg !86, !tbaa !30
  %K_reg.sroa.9.16.gep816.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep815, i32 1028, !dbg !86
  store i32 %condval_2.sroa.5.0.1, ptr addrspace(3) %K_reg.sroa.9.16.gep816.1.sroa_idx, align 4, !dbg !86, !tbaa !30
  %K_reg.sroa.10.16.gep816.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep815, i32 1032, !dbg !86
  store i32 %condval_2.sroa.6.0.1, ptr addrspace(3) %K_reg.sroa.10.16.gep816.1.sroa_idx, align 8, !dbg !86, !tbaa !30
  %K_reg.sroa.11.16.gep816.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep815, i32 1036, !dbg !86
  store i32 %condval_2.sroa.7.0.1, ptr addrspace(3) %K_reg.sroa.11.16.gep816.1.sroa_idx, align 4, !dbg !86, !tbaa !30
  %gep816.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep815, i32 2048, !dbg !87
  store i32 %condval_2.sroa.0.0.2, ptr addrspace(3) %gep816.2, align 16, !dbg !86, !tbaa !30
  %K_reg.sroa.14.32.gep816.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep815, i32 2052, !dbg !86
  store i32 %condval_2.sroa.5.0.2, ptr addrspace(3) %K_reg.sroa.14.32.gep816.2.sroa_idx, align 4, !dbg !86, !tbaa !30
  %K_reg.sroa.15.32.gep816.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep815, i32 2056, !dbg !86
  store i32 %condval_2.sroa.6.0.2, ptr addrspace(3) %K_reg.sroa.15.32.gep816.2.sroa_idx, align 8, !dbg !86, !tbaa !30
  %K_reg.sroa.16.32.gep816.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep815, i32 2060, !dbg !86
  store i32 %condval_2.sroa.7.0.2, ptr addrspace(3) %K_reg.sroa.16.32.gep816.2.sroa_idx, align 4, !dbg !86, !tbaa !30
  %gep816.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep815, i32 3072, !dbg !87
  store i32 %condval_2.sroa.0.0.3, ptr addrspace(3) %gep816.3, align 16, !dbg !86, !tbaa !30
  %K_reg.sroa.19.48.gep816.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep815, i32 3076, !dbg !86
  store i32 %condval_2.sroa.5.0.3, ptr addrspace(3) %K_reg.sroa.19.48.gep816.3.sroa_idx, align 4, !dbg !86, !tbaa !30
  %K_reg.sroa.20.48.gep816.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep815, i32 3080, !dbg !86
  store i32 %condval_2.sroa.6.0.3, ptr addrspace(3) %K_reg.sroa.20.48.gep816.3.sroa_idx, align 8, !dbg !86, !tbaa !30
  %K_reg.sroa.21.48.gep816.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep815, i32 3084, !dbg !86
  store i32 %condval_2.sroa.7.0.3, ptr addrspace(3) %K_reg.sroa.21.48.gep816.3.sroa_idx, align 4, !dbg !86, !tbaa !30
  fence syncscope("warp") release, !dbg !88
  tail call void @llvm.mxc.barrier.warp(), !dbg !91
  fence syncscope("warp") acquire, !dbg !92
  %invariant.gep819 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr218.idx, !dbg !93
  %gep = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep819, i32 %mul207, !dbg !94
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %gep, align 16, !dbg !95
  %kb.sroa.6.0.gep.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep, i32 8, !dbg !95
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.gep.sroa_idx, align 8, !dbg !95
  %add279.1 = or disjoint i32 %mul207, 1024, !dbg !96
  %gep.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep819, i32 %add279.1, !dbg !94
  %kb.sroa.8.16.copyload = load <4 x half>, ptr addrspace(3) %gep.1, align 16, !dbg !95
  %kb.sroa.12.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep.1, i32 8, !dbg !95
  %kb.sroa.12.16.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.12.16.gep.1.sroa_idx, align 8, !dbg !95
  %31 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !97
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.8.16.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !97
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %31), !dbg !97
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.12.16.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %32), !dbg !97
  %invariant.gep819.1 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr218.idx.1, !dbg !93
  %gep.1855 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep819.1, i32 %mul207, !dbg !94
  %kb.sroa.0.0.copyload944 = load <4 x half>, ptr addrspace(3) %gep.1855, align 16, !dbg !95
  %kb.sroa.6.0.gep.1855.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep.1855, i32 8, !dbg !95
  %kb.sroa.6.0.copyload945 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.gep.1855.sroa_idx, align 8, !dbg !95
  %gep.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep819.1, i32 %add279.1, !dbg !94
  %kb.sroa.8.16.copyload948 = load <4 x half>, ptr addrspace(3) %gep.1.1, align 16, !dbg !95
  %kb.sroa.12.16.gep.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %gep.1.1, i32 8, !dbg !95
  %kb.sroa.12.16.copyload949 = load <4 x half>, ptr addrspace(3) %kb.sroa.12.16.gep.1.1.sroa_idx, align 8, !dbg !95
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload944, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %33), !dbg !97
  %36 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.8.16.copyload948, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %34), !dbg !97
  %37 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload945, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %35), !dbg !97
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.12.16.copyload949, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %36), !dbg !97
  fence syncscope("warp") release, !dbg !98
  tail call void @llvm.mxc.barrier.warp(), !dbg !101
  fence syncscope("warp") acquire, !dbg !102
  %add.ptr344.idx = shl nuw nsw i32 %1, 4
  %invariant.gep824 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr344.idx, !dbg !103
  store i32 %condval_4.sroa.0.0, ptr addrspace(3) %invariant.gep824, align 16, !dbg !104, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep824.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep824, i32 4, !dbg !104
  store i32 %condval_4.sroa.5.0, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep824.sroa_idx, align 4, !dbg !104, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep824.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep824, i32 8, !dbg !104
  store i32 %condval_4.sroa.6.0, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep824.sroa_idx, align 8, !dbg !104, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep824.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep824, i32 12, !dbg !104
  store i32 %condval_4.sroa.7.0, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep824.sroa_idx, align 4, !dbg !104, !tbaa !30
  %gep825.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep824, i32 1024, !dbg !105
  store i32 %condval_4.sroa.0.0.1, ptr addrspace(3) %gep825.1, align 16, !dbg !104, !tbaa !30
  %V_reg.sroa.9.16.gep825.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep824, i32 1028, !dbg !104
  store i32 %condval_4.sroa.5.0.1, ptr addrspace(3) %V_reg.sroa.9.16.gep825.1.sroa_idx, align 4, !dbg !104, !tbaa !30
  %V_reg.sroa.10.16.gep825.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep824, i32 1032, !dbg !104
  store i32 %condval_4.sroa.6.0.1, ptr addrspace(3) %V_reg.sroa.10.16.gep825.1.sroa_idx, align 8, !dbg !104, !tbaa !30
  %V_reg.sroa.11.16.gep825.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep824, i32 1036, !dbg !104
  store i32 %condval_4.sroa.7.0.1, ptr addrspace(3) %V_reg.sroa.11.16.gep825.1.sroa_idx, align 4, !dbg !104, !tbaa !30
  %gep825.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep824, i32 2048, !dbg !105
  store i32 %condval_4.sroa.0.0.2, ptr addrspace(3) %gep825.2, align 16, !dbg !104, !tbaa !30
  %V_reg.sroa.14.32.gep825.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep824, i32 2052, !dbg !104
  store i32 %condval_4.sroa.5.0.2, ptr addrspace(3) %V_reg.sroa.14.32.gep825.2.sroa_idx, align 4, !dbg !104, !tbaa !30
  %V_reg.sroa.15.32.gep825.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep824, i32 2056, !dbg !104
  store i32 %condval_4.sroa.6.0.2, ptr addrspace(3) %V_reg.sroa.15.32.gep825.2.sroa_idx, align 8, !dbg !104, !tbaa !30
  %V_reg.sroa.16.32.gep825.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep824, i32 2060, !dbg !104
  store i32 %condval_4.sroa.7.0.2, ptr addrspace(3) %V_reg.sroa.16.32.gep825.2.sroa_idx, align 4, !dbg !104, !tbaa !30
  %gep825.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep824, i32 3072, !dbg !105
  store i32 %condval_4.sroa.0.0.3, ptr addrspace(3) %gep825.3, align 16, !dbg !104, !tbaa !30
  %V_reg.sroa.19.48.gep825.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep824, i32 3076, !dbg !104
  store i32 %condval_4.sroa.5.0.3, ptr addrspace(3) %V_reg.sroa.19.48.gep825.3.sroa_idx, align 4, !dbg !104, !tbaa !30
  %V_reg.sroa.20.48.gep825.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep824, i32 3080, !dbg !104
  store i32 %condval_4.sroa.6.0.3, ptr addrspace(3) %V_reg.sroa.20.48.gep825.3.sroa_idx, align 8, !dbg !104, !tbaa !30
  %V_reg.sroa.21.48.gep825.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep824, i32 3084, !dbg !104
  store i32 %condval_4.sroa.7.0.3, ptr addrspace(3) %V_reg.sroa.21.48.gep825.3.sroa_idx, align 4, !dbg !104, !tbaa !30
  %39 = lshr i32 %1, 2
  %mul365 = and i32 %39, 252
  %add359 = add i32 %39, %mul24, !dbg !106
  %add380 = add i32 %mul365, %mul24, !dbg !107
  %add401 = add i32 %mul365, %mul24, !dbg !108
  %cmp415 = icmp slt i32 %add359, 0, !dbg !109
  %cmp417 = icmp sgt i32 %add380, 319
  %or.cond767.not847 = or i1 %cmp415, %cmp417, !dbg !110
  %cmp420.not = icmp sgt i32 %add401, %0
  %or.cond807 = or i1 %or.cond767.not847, %cmp420.not, !dbg !110
  br i1 %or.cond807, label %if.then353.1, label %if.then421, !dbg !110

if.then421:                                       ; preds = %if.end159.3
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %37, i64 0, !dbg !111
  %mul424 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !112
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul424, float 0x4024CB5EC0000000), !dbg !113
  %41 = tail call contract noundef float @llvm.exp.f32(float %40), !dbg !117
  br label %if.then353.1, !dbg !120

if.then353.1:                                     ; preds = %if.then421, %if.end159.3
  %condval_5.0 = phi float [ %41, %if.then421 ], [ 0.000000e+00, %if.end159.3 ], !dbg !54
  %add359.1 = add i32 %39, %mul24, !dbg !106
  %add379.1 = or disjoint i32 %mul365, 1, !dbg !121
  %add380.1 = add i32 %add379.1, %mul24, !dbg !107
  %add400.1 = or disjoint i32 %mul365, 1, !dbg !122
  %add401.1 = add i32 %add400.1, %mul24, !dbg !108
  %cmp415.1 = icmp slt i32 %add359.1, 0, !dbg !109
  %cmp417.1 = icmp sgt i32 %add380.1, 319
  %or.cond767.not847.1 = select i1 %cmp415.1, i1 true, i1 %cmp417.1, !dbg !110
  %cmp420.not.1 = icmp sgt i32 %add401.1, %0
  %or.cond807.1 = select i1 %or.cond767.not847.1, i1 true, i1 %cmp420.not.1, !dbg !110
  br i1 %or.cond807.1, label %if.then353.2, label %if.then421.1, !dbg !110

if.then421.1:                                     ; preds = %if.then353.1
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %37, i64 1, !dbg !111
  %mul424.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !112
  %42 = tail call contract noundef float @llvm.minnum.f32(float %mul424.1, float 0x4024CB5EC0000000), !dbg !113
  %43 = tail call contract noundef float @llvm.exp.f32(float %42), !dbg !117
  br label %if.then353.2, !dbg !120

if.then353.2:                                     ; preds = %if.then353.1, %if.then421.1
  %condval_5.0.1 = phi float [ %43, %if.then421.1 ], [ 0.000000e+00, %if.then353.1 ], !dbg !54
  %add359.2 = add i32 %39, %mul24, !dbg !106
  %add379.2 = or disjoint i32 %mul365, 2, !dbg !121
  %add380.2 = add i32 %add379.2, %mul24, !dbg !107
  %add400.2 = or disjoint i32 %mul365, 2, !dbg !122
  %add401.2 = add i32 %add400.2, %mul24, !dbg !108
  %cmp415.2 = icmp slt i32 %add359.2, 0, !dbg !109
  %cmp417.2 = icmp sgt i32 %add380.2, 319
  %or.cond767.not847.2 = select i1 %cmp415.2, i1 true, i1 %cmp417.2, !dbg !110
  %cmp420.not.2 = icmp sgt i32 %add401.2, %0
  %or.cond807.2 = select i1 %or.cond767.not847.2, i1 true, i1 %cmp420.not.2, !dbg !110
  br i1 %or.cond807.2, label %if.then353.3, label %if.then421.2, !dbg !110

if.then421.2:                                     ; preds = %if.then353.2
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %37, i64 2, !dbg !111
  %mul424.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !112
  %44 = tail call contract noundef float @llvm.minnum.f32(float %mul424.2, float 0x4024CB5EC0000000), !dbg !113
  %45 = tail call contract noundef float @llvm.exp.f32(float %44), !dbg !117
  br label %if.then353.3, !dbg !120

if.then353.3:                                     ; preds = %if.then353.2, %if.then421.2
  %condval_5.0.2 = phi float [ %45, %if.then421.2 ], [ 0.000000e+00, %if.then353.2 ], !dbg !54
  %add359.3 = add i32 %39, %mul24, !dbg !106
  %add379.3 = or i32 %39, 3, !dbg !121
  %add380.3 = add i32 %add379.3, %mul24, !dbg !107
  %add400.3 = or i32 %39, 3, !dbg !122
  %add401.3 = add i32 %add400.3, %mul24, !dbg !108
  %cmp415.3 = icmp slt i32 %add359.3, 0, !dbg !109
  %cmp417.3 = icmp sgt i32 %add380.3, 319
  %or.cond767.not847.3 = or i1 %cmp415.3, %cmp417.3, !dbg !110
  %cmp420.not.3 = icmp sgt i32 %add401.3, %0
  %or.cond807.3 = or i1 %or.cond767.not847.3, %cmp420.not.3, !dbg !110
  br i1 %or.cond807.3, label %if.else360.4, label %if.then421.3, !dbg !110

if.then421.3:                                     ; preds = %if.then353.3
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %37, i64 3, !dbg !111
  %mul424.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !112
  %46 = tail call contract noundef float @llvm.minnum.f32(float %mul424.3, float 0x4024CB5EC0000000), !dbg !113
  %47 = tail call contract noundef float @llvm.exp.f32(float %46), !dbg !117
  br label %if.else360.4, !dbg !120

if.else360.4:                                     ; preds = %if.then353.3, %if.then421.3
  %condval_5.0.3 = phi float [ %47, %if.then421.3 ], [ 0.000000e+00, %if.then353.3 ], !dbg !54
  %sub371.4 = add i32 %39, %mul24.1, !dbg !123
  %sub392.4 = add i32 %mul365, %mul24.1, !dbg !124
  %sub413.4 = add i32 %mul365, %mul24.1, !dbg !125
  %cmp415.4 = icmp slt i32 %sub371.4, 0, !dbg !109
  %cmp417.4 = icmp sgt i32 %sub392.4, 319
  %or.cond767.not847.4 = or i1 %cmp415.4, %cmp417.4, !dbg !110
  %cmp420.not.4 = icmp sgt i32 %sub413.4, %0
  %or.cond807.4 = select i1 %or.cond767.not847.4, i1 true, i1 %cmp420.not.4, !dbg !110
  br i1 %or.cond807.4, label %if.else360.5, label %if.then421.4, !dbg !110

if.then421.4:                                     ; preds = %if.else360.4
  %acc_s.sroa.38.16.vec.extract = extractelement <4 x float> %38, i64 0, !dbg !111
  %mul424.4 = fmul contract float %acc_s.sroa.38.16.vec.extract, 0x3FB99999A0000000, !dbg !112
  %48 = tail call contract noundef float @llvm.minnum.f32(float %mul424.4, float 0x4024CB5EC0000000), !dbg !113
  %49 = tail call contract noundef float @llvm.exp.f32(float %48), !dbg !117
  br label %if.else360.5, !dbg !120

if.else360.5:                                     ; preds = %if.else360.4, %if.then421.4
  %condval_5.0.4 = phi float [ %49, %if.then421.4 ], [ 0.000000e+00, %if.else360.4 ], !dbg !54
  %sub371.5 = add i32 %39, %mul24.1, !dbg !123
  %add391.5 = or disjoint i32 %mul365, 1, !dbg !126
  %sub392.5 = add i32 %add391.5, %mul24.1, !dbg !124
  %add412.5 = or disjoint i32 %mul365, 1, !dbg !127
  %sub413.5 = add i32 %add412.5, %mul24.1, !dbg !125
  %cmp415.5 = icmp slt i32 %sub371.5, 0, !dbg !109
  %cmp417.5 = icmp sgt i32 %sub392.5, 319
  %or.cond767.not847.5 = select i1 %cmp415.5, i1 true, i1 %cmp417.5, !dbg !110
  %cmp420.not.5 = icmp sgt i32 %sub413.5, %0
  %or.cond807.5 = select i1 %or.cond767.not847.5, i1 true, i1 %cmp420.not.5, !dbg !110
  br i1 %or.cond807.5, label %if.else360.6, label %if.then421.5, !dbg !110

if.then421.5:                                     ; preds = %if.else360.5
  %acc_s.sroa.38.20.vec.extract = extractelement <4 x float> %38, i64 1, !dbg !111
  %mul424.5 = fmul contract float %acc_s.sroa.38.20.vec.extract, 0x3FB99999A0000000, !dbg !112
  %50 = tail call contract noundef float @llvm.minnum.f32(float %mul424.5, float 0x4024CB5EC0000000), !dbg !113
  %51 = tail call contract noundef float @llvm.exp.f32(float %50), !dbg !117
  br label %if.else360.6, !dbg !120

if.else360.6:                                     ; preds = %if.else360.5, %if.then421.5
  %condval_5.0.5 = phi float [ %51, %if.then421.5 ], [ 0.000000e+00, %if.else360.5 ], !dbg !54
  %sub371.6 = add i32 %39, %mul24.1, !dbg !123
  %add391.6 = or disjoint i32 %mul365, 2, !dbg !126
  %sub392.6 = add i32 %add391.6, %mul24.1, !dbg !124
  %add412.6 = or disjoint i32 %mul365, 2, !dbg !127
  %sub413.6 = add i32 %add412.6, %mul24.1, !dbg !125
  %cmp415.6 = icmp slt i32 %sub371.6, 0, !dbg !109
  %cmp417.6 = icmp sgt i32 %sub392.6, 319
  %or.cond767.not847.6 = select i1 %cmp415.6, i1 true, i1 %cmp417.6, !dbg !110
  %cmp420.not.6 = icmp sgt i32 %sub413.6, %0
  %or.cond807.6 = select i1 %or.cond767.not847.6, i1 true, i1 %cmp420.not.6, !dbg !110
  br i1 %or.cond807.6, label %if.else360.7, label %if.then421.6, !dbg !110

if.then421.6:                                     ; preds = %if.else360.6
  %acc_s.sroa.38.24.vec.extract = extractelement <4 x float> %38, i64 2, !dbg !111
  %mul424.6 = fmul contract float %acc_s.sroa.38.24.vec.extract, 0x3FB99999A0000000, !dbg !112
  %52 = tail call contract noundef float @llvm.minnum.f32(float %mul424.6, float 0x4024CB5EC0000000), !dbg !113
  %53 = tail call contract noundef float @llvm.exp.f32(float %52), !dbg !117
  br label %if.else360.7, !dbg !120

if.else360.7:                                     ; preds = %if.else360.6, %if.then421.6
  %condval_5.0.6 = phi float [ %53, %if.then421.6 ], [ 0.000000e+00, %if.else360.6 ], !dbg !54
  %sub371.7 = add i32 %39, %mul24.1, !dbg !123
  %add391.7 = or i32 %39, 3, !dbg !126
  %sub392.7 = add i32 %add391.7, %mul24.1, !dbg !124
  %add412.7 = or i32 %39, 3, !dbg !127
  %sub413.7 = add i32 %add412.7, %mul24.1, !dbg !125
  %cmp415.7 = icmp slt i32 %sub371.7, 0, !dbg !109
  %cmp417.7 = icmp sgt i32 %sub392.7, 319
  %or.cond767.not847.7 = or i1 %cmp415.7, %cmp417.7, !dbg !110
  %cmp420.not.7 = icmp sgt i32 %sub413.7, %0
  %or.cond807.7 = select i1 %or.cond767.not847.7, i1 true, i1 %cmp420.not.7, !dbg !110
  br i1 %or.cond807.7, label %if.end428.7, label %if.then421.7, !dbg !110

if.then421.7:                                     ; preds = %if.else360.7
  %acc_s.sroa.38.28.vec.extract = extractelement <4 x float> %38, i64 3, !dbg !111
  %mul424.7 = fmul contract float %acc_s.sroa.38.28.vec.extract, 0x3FB99999A0000000, !dbg !112
  %54 = tail call contract noundef float @llvm.minnum.f32(float %mul424.7, float 0x4024CB5EC0000000), !dbg !113
  %55 = tail call contract noundef float @llvm.exp.f32(float %54), !dbg !117
  br label %if.end428.7, !dbg !120

if.end428.7:                                      ; preds = %if.then421.7, %if.else360.7
  %condval_5.0.7 = phi float [ %55, %if.then421.7 ], [ 0.000000e+00, %if.else360.7 ], !dbg !54
  %add448.1 = fadd contract float %condval_5.0, %condval_5.0.1, !dbg !128
  %add448.2 = fadd contract float %add448.1, %condval_5.0.2, !dbg !128
  %add448.3 = fadd contract float %add448.2, %condval_5.0.3, !dbg !128
  %add448.1861 = fadd contract float %add448.3, %condval_5.0.4, !dbg !128
  %add448.1.1 = fadd contract float %add448.1861, %condval_5.0.5, !dbg !128
  %add448.2.1 = fadd contract float %add448.1.1, %condval_5.0.6, !dbg !128
  %add448.3.1 = fadd contract float %add448.2.1, %condval_5.0.7, !dbg !128
  %56 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add448.3.1, <4 x float> zeroinitializer), !dbg !129
  %short_sum_out.sroa.0.0.vec.extract = extractelement <4 x float> %56, i64 0, !dbg !130
  %cmp469 = fcmp contract ogt float %short_sum_out.sroa.0.0.vec.extract, 0.000000e+00, !dbg !131
  br i1 %cmp469, label %if.then470, label %if.end486, !dbg !132

if.then470:                                       ; preds = %if.end428.7
  %57 = bitcast float %short_sum_out.sroa.0.0.vec.extract to i32, !dbg !133
  %sub472 = sub i32 2129859011, %57, !dbg !134
  %58 = bitcast i32 %sub472 to float, !dbg !135
  %mul474 = fmul contract float %short_sum_out.sroa.0.0.vec.extract, %58, !dbg !136
  %sub475 = fsub contract float 2.000000e+00, %mul474, !dbg !137
  %mul476 = fmul contract float %sub475, %58, !dbg !138
  %mul482 = fmul contract float %short_sum_out.sroa.0.0.vec.extract, %mul476, !dbg !139
  %sub483 = fsub contract float 2.000000e+00, %mul482, !dbg !140
  %mul484 = fmul contract float %mul476, %sub483, !dbg !141
  br label %if.end486, !dbg !142

if.end486:                                        ; preds = %if.end428.7, %if.then470
  %condval_9.0 = phi float [ %mul484, %if.then470 ], [ 0.000000e+00, %if.end428.7 ], !dbg !54
  %mul495 = fmul contract float %condval_9.0, %condval_5.0, !dbg !143
  %mul495.1 = fmul contract float %condval_9.0, %condval_5.0.1, !dbg !143
  %mul495.2 = fmul contract float %condval_9.0, %condval_5.0.2, !dbg !143
  %mul495.3 = fmul contract float %condval_9.0, %condval_5.0.3, !dbg !143
  %mul495.4 = fmul contract float %condval_9.0, %condval_5.0.4, !dbg !143
  %mul495.5 = fmul contract float %condval_9.0, %condval_5.0.5, !dbg !143
  %mul495.6 = fmul contract float %condval_9.0, %condval_5.0.6, !dbg !143
  %mul495.7 = fmul contract float %condval_9.0, %condval_5.0.7, !dbg !143
  %59 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul495), !dbg !144
  %60 = insertelement <4 x i16> poison, i16 %59, i64 0, !dbg !153
  %61 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul495.1), !dbg !144
  %62 = insertelement <4 x i16> %60, i16 %61, i64 1, !dbg !153
  %63 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul495.2), !dbg !144
  %64 = insertelement <4 x i16> %62, i16 %63, i64 2, !dbg !153
  %65 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul495.3), !dbg !144
  %66 = insertelement <4 x i16> %64, i16 %65, i64 3, !dbg !153
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %66 to <4 x half>, !dbg !153
  %67 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul495.4), !dbg !144
  %68 = insertelement <4 x i16> poison, i16 %67, i64 0, !dbg !153
  %69 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul495.5), !dbg !144
  %70 = insertelement <4 x i16> %68, i16 %69, i64 1, !dbg !153
  %71 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul495.6), !dbg !144
  %72 = insertelement <4 x i16> %70, i16 %71, i64 2, !dbg !153
  %73 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul495.7), !dbg !144
  %74 = insertelement <4 x i16> %72, i16 %73, i64 3, !dbg !153
  %acc_s_cast.sroa.7.14.vec.insert = bitcast <4 x i16> %74 to <4 x half>, !dbg !153
  fence syncscope("warp") release, !dbg !154
  tail call void @llvm.mxc.barrier.warp(), !dbg !157
  fence syncscope("warp") acquire, !dbg !158
  %mul539 = and i32 %add.ptr344.idx, 16128
  %and546 = and i32 %1, 15
  %add547 = or disjoint i32 %mul539, %and546, !dbg !159
  %arrayidx549 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547, !dbg !160
  %75 = load half, ptr addrspace(3) %arrayidx549, align 2, !dbg !161, !tbaa !162
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %75, i64 0, !dbg !161
  %add542.1 = or disjoint i32 %mul539, %and546, !dbg !159
  %add547.1 = or disjoint i32 %add542.1, 64, !dbg !159
  %arrayidx549.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.1, !dbg !160
  %76 = load half, ptr addrspace(3) %arrayidx549.1, align 2, !dbg !161, !tbaa !162
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %76, i64 1, !dbg !161
  %add542.2 = or disjoint i32 %mul539, %and546, !dbg !159
  %add547.2 = or disjoint i32 %add542.2, 128, !dbg !159
  %arrayidx549.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.2, !dbg !160
  %77 = load half, ptr addrspace(3) %arrayidx549.2, align 2, !dbg !161, !tbaa !162
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %77, i64 2, !dbg !161
  %add542.3 = or disjoint i32 %mul539, %and546, !dbg !159
  %add547.3 = or disjoint i32 %add542.3, 192, !dbg !159
  %arrayidx549.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.3, !dbg !160
  %78 = load half, ptr addrspace(3) %arrayidx549.3, align 2, !dbg !161, !tbaa !162
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %78, i64 3, !dbg !161
  %add544.1864 = or disjoint i32 %mul539, %and546, !dbg !159
  %add547.1865 = or disjoint i32 %add544.1864, 16, !dbg !159
  %arrayidx549.1866 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.1865, !dbg !160
  %79 = load half, ptr addrspace(3) %arrayidx549.1866, align 2, !dbg !161, !tbaa !162
  %vb.sroa.12.8.vec.insert = insertelement <4 x half> poison, half %79, i64 0, !dbg !161
  %add544.1.1 = or disjoint i32 %mul539, %and546, !dbg !159
  %add547.1.1 = or disjoint i32 %add544.1.1, 80, !dbg !159
  %arrayidx549.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.1.1, !dbg !160
  %80 = load half, ptr addrspace(3) %arrayidx549.1.1, align 2, !dbg !161, !tbaa !162
  %vb.sroa.12.10.vec.insert = insertelement <4 x half> %vb.sroa.12.8.vec.insert, half %80, i64 1, !dbg !161
  %add544.2.1 = or disjoint i32 %mul539, %and546, !dbg !159
  %add547.2.1 = or disjoint i32 %add544.2.1, 144, !dbg !159
  %arrayidx549.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.2.1, !dbg !160
  %81 = load half, ptr addrspace(3) %arrayidx549.2.1, align 2, !dbg !161, !tbaa !162
  %vb.sroa.12.12.vec.insert = insertelement <4 x half> %vb.sroa.12.10.vec.insert, half %81, i64 2, !dbg !161
  %add544.3.1 = or disjoint i32 %mul539, %and546, !dbg !159
  %add547.3.1 = or disjoint i32 %add544.3.1, 208, !dbg !159
  %arrayidx549.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.3.1, !dbg !160
  %82 = load half, ptr addrspace(3) %arrayidx549.3.1, align 2, !dbg !161, !tbaa !162
  %vb.sroa.12.14.vec.insert = insertelement <4 x half> %vb.sroa.12.12.vec.insert, half %82, i64 3, !dbg !161
  %add544.2868 = or disjoint i32 %mul539, %and546, !dbg !159
  %add547.2869 = or disjoint i32 %add544.2868, 32, !dbg !159
  %arrayidx549.2870 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.2869, !dbg !160
  %83 = load half, ptr addrspace(3) %arrayidx549.2870, align 2, !dbg !161, !tbaa !162
  %vb.sroa.22.16.vec.insert = insertelement <4 x half> poison, half %83, i64 0, !dbg !161
  %add544.1.2 = or disjoint i32 %mul539, %and546, !dbg !159
  %add547.1.2 = or disjoint i32 %add544.1.2, 96, !dbg !159
  %arrayidx549.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.1.2, !dbg !160
  %84 = load half, ptr addrspace(3) %arrayidx549.1.2, align 2, !dbg !161, !tbaa !162
  %vb.sroa.22.18.vec.insert = insertelement <4 x half> %vb.sroa.22.16.vec.insert, half %84, i64 1, !dbg !161
  %add544.2.2 = or disjoint i32 %mul539, %and546, !dbg !159
  %add547.2.2 = or disjoint i32 %add544.2.2, 160, !dbg !159
  %arrayidx549.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.2.2, !dbg !160
  %85 = load half, ptr addrspace(3) %arrayidx549.2.2, align 2, !dbg !161, !tbaa !162
  %vb.sroa.22.20.vec.insert = insertelement <4 x half> %vb.sroa.22.18.vec.insert, half %85, i64 2, !dbg !161
  %add544.3.2 = or disjoint i32 %mul539, %and546, !dbg !159
  %add547.3.2 = or disjoint i32 %add544.3.2, 224, !dbg !159
  %arrayidx549.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.3.2, !dbg !160
  %86 = load half, ptr addrspace(3) %arrayidx549.3.2, align 2, !dbg !161, !tbaa !162
  %vb.sroa.22.22.vec.insert = insertelement <4 x half> %vb.sroa.22.20.vec.insert, half %86, i64 3, !dbg !161
  %add544.3872 = or disjoint i32 %mul539, %and546, !dbg !159
  %add547.3873 = or disjoint i32 %add544.3872, 48, !dbg !159
  %arrayidx549.3874 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.3873, !dbg !160
  %87 = load half, ptr addrspace(3) %arrayidx549.3874, align 2, !dbg !161, !tbaa !162
  %vb.sroa.32.24.vec.insert = insertelement <4 x half> poison, half %87, i64 0, !dbg !161
  %add544.1.3 = or disjoint i32 %mul539, %and546, !dbg !159
  %add547.1.3 = or disjoint i32 %add544.1.3, 112, !dbg !159
  %arrayidx549.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.1.3, !dbg !160
  %88 = load half, ptr addrspace(3) %arrayidx549.1.3, align 2, !dbg !161, !tbaa !162
  %vb.sroa.32.26.vec.insert = insertelement <4 x half> %vb.sroa.32.24.vec.insert, half %88, i64 1, !dbg !161
  %add544.2.3 = or disjoint i32 %mul539, %and546, !dbg !159
  %add547.2.3 = or disjoint i32 %add544.2.3, 176, !dbg !159
  %arrayidx549.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.2.3, !dbg !160
  %89 = load half, ptr addrspace(3) %arrayidx549.2.3, align 2, !dbg !161, !tbaa !162
  %vb.sroa.32.28.vec.insert = insertelement <4 x half> %vb.sroa.32.26.vec.insert, half %89, i64 2, !dbg !161
  %add544.3.3 = or disjoint i32 %add.ptr344.idx, %and546, !dbg !159
  %add547.3.3 = or i32 %add544.3.3, 240, !dbg !159
  %arrayidx549.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.3.3, !dbg !160
  %90 = load half, ptr addrspace(3) %arrayidx549.3.3, align 2, !dbg !161, !tbaa !162
  %vb.sroa.32.30.vec.insert = insertelement <4 x half> %vb.sroa.32.28.vec.insert, half %90, i64 3, !dbg !161
  %91 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !163
  %92 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !163
  %93 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !163
  %94 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !163
  %add540.1 = add nuw nsw i32 %mul539, 1024
  %add547.1876 = or disjoint i32 %add540.1, %and546, !dbg !159
  %arrayidx549.1877 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.1876, !dbg !160
  %95 = load half, ptr addrspace(3) %arrayidx549.1877, align 2, !dbg !161, !tbaa !162
  %vb.sroa.0.0.vec.insert904 = insertelement <4 x half> poison, half %95, i64 0, !dbg !161
  %add542.1.1878 = add nuw nsw i32 %mul539, 1088, !dbg !164
  %add547.1.1879 = or disjoint i32 %add542.1.1878, %and546, !dbg !159
  %arrayidx549.1.1880 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.1.1879, !dbg !160
  %96 = load half, ptr addrspace(3) %arrayidx549.1.1880, align 2, !dbg !161, !tbaa !162
  %vb.sroa.0.2.vec.insert906 = insertelement <4 x half> %vb.sroa.0.0.vec.insert904, half %96, i64 1, !dbg !161
  %add542.2.1882 = add nuw nsw i32 %mul539, 1152, !dbg !164
  %add547.2.1883 = or disjoint i32 %add542.2.1882, %and546, !dbg !159
  %arrayidx549.2.1884 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.2.1883, !dbg !160
  %97 = load half, ptr addrspace(3) %arrayidx549.2.1884, align 2, !dbg !161, !tbaa !162
  %vb.sroa.0.4.vec.insert908 = insertelement <4 x half> %vb.sroa.0.2.vec.insert906, half %97, i64 2, !dbg !161
  %add542.3.1886 = add nuw nsw i32 %mul539, 1216, !dbg !164
  %add547.3.1887 = or disjoint i32 %add542.3.1886, %and546, !dbg !159
  %arrayidx549.3.1888 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.3.1887, !dbg !160
  %98 = load half, ptr addrspace(3) %arrayidx549.3.1888, align 2, !dbg !161, !tbaa !162
  %vb.sroa.0.6.vec.insert910 = insertelement <4 x half> %vb.sroa.0.4.vec.insert908, half %98, i64 3, !dbg !161
  %add544.1864.1 = add nuw nsw i32 %mul539, 1040, !dbg !165
  %add547.1865.1 = or disjoint i32 %add544.1864.1, %and546, !dbg !159
  %arrayidx549.1866.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.1865.1, !dbg !160
  %99 = load half, ptr addrspace(3) %arrayidx549.1866.1, align 2, !dbg !161, !tbaa !162
  %vb.sroa.12.8.vec.insert914 = insertelement <4 x half> poison, half %99, i64 0, !dbg !161
  %add544.1.1.1 = add nuw nsw i32 %mul539, 1104, !dbg !165
  %add547.1.1.1 = or disjoint i32 %add544.1.1.1, %and546, !dbg !159
  %arrayidx549.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.1.1.1, !dbg !160
  %100 = load half, ptr addrspace(3) %arrayidx549.1.1.1, align 2, !dbg !161, !tbaa !162
  %vb.sroa.12.10.vec.insert916 = insertelement <4 x half> %vb.sroa.12.8.vec.insert914, half %100, i64 1, !dbg !161
  %add544.2.1.1 = add nuw nsw i32 %mul539, 1168, !dbg !165
  %add547.2.1.1 = or disjoint i32 %add544.2.1.1, %and546, !dbg !159
  %arrayidx549.2.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.2.1.1, !dbg !160
  %101 = load half, ptr addrspace(3) %arrayidx549.2.1.1, align 2, !dbg !161, !tbaa !162
  %vb.sroa.12.12.vec.insert918 = insertelement <4 x half> %vb.sroa.12.10.vec.insert916, half %101, i64 2, !dbg !161
  %add544.3.1.1 = add nuw nsw i32 %mul539, 1232, !dbg !165
  %add547.3.1.1 = or disjoint i32 %add544.3.1.1, %and546, !dbg !159
  %arrayidx549.3.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.3.1.1, !dbg !160
  %102 = load half, ptr addrspace(3) %arrayidx549.3.1.1, align 2, !dbg !161, !tbaa !162
  %vb.sroa.12.14.vec.insert920 = insertelement <4 x half> %vb.sroa.12.12.vec.insert918, half %102, i64 3, !dbg !161
  %add544.2868.1 = add nuw nsw i32 %mul539, 1056, !dbg !165
  %add547.2869.1 = or disjoint i32 %add544.2868.1, %and546, !dbg !159
  %arrayidx549.2870.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.2869.1, !dbg !160
  %103 = load half, ptr addrspace(3) %arrayidx549.2870.1, align 2, !dbg !161, !tbaa !162
  %vb.sroa.22.16.vec.insert924 = insertelement <4 x half> poison, half %103, i64 0, !dbg !161
  %add544.1.2.1 = add nuw nsw i32 %mul539, 1120, !dbg !165
  %add547.1.2.1 = or disjoint i32 %add544.1.2.1, %and546, !dbg !159
  %arrayidx549.1.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.1.2.1, !dbg !160
  %104 = load half, ptr addrspace(3) %arrayidx549.1.2.1, align 2, !dbg !161, !tbaa !162
  %vb.sroa.22.18.vec.insert926 = insertelement <4 x half> %vb.sroa.22.16.vec.insert924, half %104, i64 1, !dbg !161
  %add544.2.2.1 = add nuw nsw i32 %mul539, 1184, !dbg !165
  %add547.2.2.1 = or disjoint i32 %add544.2.2.1, %and546, !dbg !159
  %arrayidx549.2.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.2.2.1, !dbg !160
  %105 = load half, ptr addrspace(3) %arrayidx549.2.2.1, align 2, !dbg !161, !tbaa !162
  %vb.sroa.22.20.vec.insert928 = insertelement <4 x half> %vb.sroa.22.18.vec.insert926, half %105, i64 2, !dbg !161
  %add544.3.2.1 = add nuw nsw i32 %mul539, 1248, !dbg !165
  %add547.3.2.1 = or disjoint i32 %add544.3.2.1, %and546, !dbg !159
  %arrayidx549.3.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.3.2.1, !dbg !160
  %106 = load half, ptr addrspace(3) %arrayidx549.3.2.1, align 2, !dbg !161, !tbaa !162
  %vb.sroa.22.22.vec.insert930 = insertelement <4 x half> %vb.sroa.22.20.vec.insert928, half %106, i64 3, !dbg !161
  %add544.3872.1 = add nuw nsw i32 %mul539, 1072, !dbg !165
  %add547.3873.1 = or disjoint i32 %add544.3872.1, %and546, !dbg !159
  %arrayidx549.3874.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.3873.1, !dbg !160
  %107 = load half, ptr addrspace(3) %arrayidx549.3874.1, align 2, !dbg !161, !tbaa !162
  %vb.sroa.32.24.vec.insert934 = insertelement <4 x half> poison, half %107, i64 0, !dbg !161
  %add544.1.3.1 = add nuw nsw i32 %mul539, 1136, !dbg !165
  %add547.1.3.1 = or disjoint i32 %add544.1.3.1, %and546, !dbg !159
  %arrayidx549.1.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.1.3.1, !dbg !160
  %108 = load half, ptr addrspace(3) %arrayidx549.1.3.1, align 2, !dbg !161, !tbaa !162
  %vb.sroa.32.26.vec.insert936 = insertelement <4 x half> %vb.sroa.32.24.vec.insert934, half %108, i64 1, !dbg !161
  %add544.2.3.1 = add nuw nsw i32 %mul539, 1200, !dbg !165
  %add547.2.3.1 = or disjoint i32 %add544.2.3.1, %and546, !dbg !159
  %arrayidx549.2.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.2.3.1, !dbg !160
  %109 = load half, ptr addrspace(3) %arrayidx549.2.3.1, align 2, !dbg !161, !tbaa !162
  %vb.sroa.32.28.vec.insert938 = insertelement <4 x half> %vb.sroa.32.26.vec.insert936, half %109, i64 2, !dbg !161
  %add544.3.3.1 = add nuw nsw i32 %mul539, 1264, !dbg !165
  %add547.3.3.1 = or disjoint i32 %add544.3.3.1, %and546, !dbg !159
  %arrayidx549.3.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add547.3.3.1, !dbg !160
  %110 = load half, ptr addrspace(3) %arrayidx549.3.3.1, align 2, !dbg !161, !tbaa !162
  %vb.sroa.32.30.vec.insert940 = insertelement <4 x half> %vb.sroa.32.28.vec.insert938, half %110, i64 3, !dbg !161
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert910, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %91), !dbg !163
  %112 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.14.vec.insert920, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %92), !dbg !163
  %113 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.22.vec.insert930, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %93), !dbg !163
  %114 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.30.vec.insert940, <4 x half> %acc_s_cast.sroa.7.14.vec.insert, <4 x float> %94), !dbg !163
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %111, i64 0, !dbg !166
  %115 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract), !dbg !167
  %O_cast.sroa.0.0.insert.ext = zext i16 %115 to i64, !dbg !171
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %111, i64 1, !dbg !166
  %116 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract), !dbg !167
  %O_cast.sroa.0.2.insert.ext = zext i16 %116 to i64, !dbg !171
  %O_cast.sroa.0.2.insert.shift = shl nuw nsw i64 %O_cast.sroa.0.2.insert.ext, 16, !dbg !171
  %O_cast.sroa.0.2.insert.insert = or disjoint i64 %O_cast.sroa.0.2.insert.shift, %O_cast.sroa.0.0.insert.ext, !dbg !171
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %111, i64 2, !dbg !166
  %117 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract), !dbg !167
  %O_cast.sroa.0.4.insert.ext = zext i16 %117 to i64, !dbg !171
  %O_cast.sroa.0.4.insert.shift = shl nuw nsw i64 %O_cast.sroa.0.4.insert.ext, 32, !dbg !171
  %O_cast.sroa.0.4.insert.insert = or disjoint i64 %O_cast.sroa.0.2.insert.insert, %O_cast.sroa.0.4.insert.shift, !dbg !171
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %111, i64 3, !dbg !166
  %118 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract), !dbg !167
  %O_cast.sroa.0.6.insert.ext = zext i16 %118 to i64, !dbg !171
  %O_cast.sroa.0.6.insert.shift = shl nuw i64 %O_cast.sroa.0.6.insert.ext, 48, !dbg !171
  %O_cast.sroa.0.6.insert.insert = or disjoint i64 %O_cast.sroa.0.4.insert.insert, %O_cast.sroa.0.6.insert.shift, !dbg !171
  %acc_o.sroa.14.16.vec.extract = extractelement <4 x float> %112, i64 0, !dbg !166
  %119 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.16.vec.extract), !dbg !167
  %O_cast.sroa.7.8.insert.ext = zext i16 %119 to i64, !dbg !171
  %acc_o.sroa.14.20.vec.extract = extractelement <4 x float> %112, i64 1, !dbg !166
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.20.vec.extract), !dbg !167
  %O_cast.sroa.7.10.insert.ext = zext i16 %120 to i64, !dbg !171
  %O_cast.sroa.7.10.insert.shift = shl nuw nsw i64 %O_cast.sroa.7.10.insert.ext, 16, !dbg !171
  %O_cast.sroa.7.10.insert.insert = or disjoint i64 %O_cast.sroa.7.10.insert.shift, %O_cast.sroa.7.8.insert.ext, !dbg !171
  %acc_o.sroa.14.24.vec.extract = extractelement <4 x float> %112, i64 2, !dbg !166
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.24.vec.extract), !dbg !167
  %O_cast.sroa.7.12.insert.ext = zext i16 %121 to i64, !dbg !171
  %O_cast.sroa.7.12.insert.shift = shl nuw nsw i64 %O_cast.sroa.7.12.insert.ext, 32, !dbg !171
  %O_cast.sroa.7.12.insert.insert = or disjoint i64 %O_cast.sroa.7.10.insert.insert, %O_cast.sroa.7.12.insert.shift, !dbg !171
  %acc_o.sroa.14.28.vec.extract = extractelement <4 x float> %112, i64 3, !dbg !166
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.14.28.vec.extract), !dbg !167
  %O_cast.sroa.7.14.insert.ext = zext i16 %122 to i64, !dbg !171
  %O_cast.sroa.7.14.insert.shift = shl nuw i64 %O_cast.sroa.7.14.insert.ext, 48, !dbg !171
  %O_cast.sroa.7.14.insert.insert = or disjoint i64 %O_cast.sroa.7.12.insert.insert, %O_cast.sroa.7.14.insert.shift, !dbg !171
  %acc_o.sroa.26.32.vec.extract = extractelement <4 x float> %113, i64 0, !dbg !166
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.32.vec.extract), !dbg !167
  %O_cast.sroa.12.16.insert.ext = zext i16 %123 to i64, !dbg !171
  %acc_o.sroa.26.36.vec.extract = extractelement <4 x float> %113, i64 1, !dbg !166
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.36.vec.extract), !dbg !167
  %O_cast.sroa.12.18.insert.ext = zext i16 %124 to i64, !dbg !171
  %O_cast.sroa.12.18.insert.shift = shl nuw nsw i64 %O_cast.sroa.12.18.insert.ext, 16, !dbg !171
  %O_cast.sroa.12.18.insert.insert = or disjoint i64 %O_cast.sroa.12.18.insert.shift, %O_cast.sroa.12.16.insert.ext, !dbg !171
  %acc_o.sroa.26.40.vec.extract = extractelement <4 x float> %113, i64 2, !dbg !166
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.40.vec.extract), !dbg !167
  %O_cast.sroa.12.20.insert.ext = zext i16 %125 to i64, !dbg !171
  %O_cast.sroa.12.20.insert.shift = shl nuw nsw i64 %O_cast.sroa.12.20.insert.ext, 32, !dbg !171
  %O_cast.sroa.12.20.insert.insert = or disjoint i64 %O_cast.sroa.12.18.insert.insert, %O_cast.sroa.12.20.insert.shift, !dbg !171
  %acc_o.sroa.26.44.vec.extract = extractelement <4 x float> %113, i64 3, !dbg !166
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.26.44.vec.extract), !dbg !167
  %O_cast.sroa.12.22.insert.ext = zext i16 %126 to i64, !dbg !171
  %O_cast.sroa.12.22.insert.shift = shl nuw i64 %O_cast.sroa.12.22.insert.ext, 48, !dbg !171
  %O_cast.sroa.12.22.insert.insert = or disjoint i64 %O_cast.sroa.12.20.insert.insert, %O_cast.sroa.12.22.insert.shift, !dbg !171
  %acc_o.sroa.38.48.vec.extract = extractelement <4 x float> %114, i64 0, !dbg !166
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.48.vec.extract), !dbg !167
  %O_cast.sroa.17.24.insert.ext = zext i16 %127 to i64, !dbg !171
  %acc_o.sroa.38.52.vec.extract = extractelement <4 x float> %114, i64 1, !dbg !166
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.52.vec.extract), !dbg !167
  %O_cast.sroa.17.26.insert.ext = zext i16 %128 to i64, !dbg !171
  %O_cast.sroa.17.26.insert.shift = shl nuw nsw i64 %O_cast.sroa.17.26.insert.ext, 16, !dbg !171
  %O_cast.sroa.17.26.insert.insert = or disjoint i64 %O_cast.sroa.17.26.insert.shift, %O_cast.sroa.17.24.insert.ext, !dbg !171
  %acc_o.sroa.38.56.vec.extract = extractelement <4 x float> %114, i64 2, !dbg !166
  %129 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.56.vec.extract), !dbg !167
  %O_cast.sroa.17.28.insert.ext = zext i16 %129 to i64, !dbg !171
  %O_cast.sroa.17.28.insert.shift = shl nuw nsw i64 %O_cast.sroa.17.28.insert.ext, 32, !dbg !171
  %O_cast.sroa.17.28.insert.insert = or disjoint i64 %O_cast.sroa.17.26.insert.insert, %O_cast.sroa.17.28.insert.shift, !dbg !171
  %acc_o.sroa.38.60.vec.extract = extractelement <4 x float> %114, i64 3, !dbg !166
  %130 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.38.60.vec.extract), !dbg !167
  %O_cast.sroa.17.30.insert.ext = zext i16 %130 to i64, !dbg !171
  %O_cast.sroa.17.30.insert.shift = shl nuw i64 %O_cast.sroa.17.30.insert.ext, 48, !dbg !171
  %O_cast.sroa.17.30.insert.insert = or disjoint i64 %O_cast.sroa.17.28.insert.insert, %O_cast.sroa.17.30.insert.shift, !dbg !171
  %add618 = or disjoint i32 %mul207, %mul
  %add620 = add nuw nsw i32 %add618, %mul365
  %131 = zext nneg i32 %add620 to i64, !dbg !172
  %add.ptr626 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %131, !dbg !173
  store i64 %O_cast.sroa.0.6.insert.insert, ptr addrspace(1) %add.ptr626, align 8, !dbg !174
  %132 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %131, !dbg !173
  %add.ptr626.1 = getelementptr inbounds i8, ptr addrspace(1) %132, i64 32, !dbg !173
  store i64 %O_cast.sroa.7.14.insert.insert, ptr addrspace(1) %add.ptr626.1, align 8, !dbg !174
  %133 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %131, !dbg !173
  %add.ptr626.2 = getelementptr inbounds i8, ptr addrspace(1) %133, i64 64, !dbg !173
  store i64 %O_cast.sroa.12.22.insert.insert, ptr addrspace(1) %add.ptr626.2, align 8, !dbg !174
  %134 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %131, !dbg !173
  %add.ptr626.3 = getelementptr inbounds i8, ptr addrspace(1) %134, i64 96, !dbg !173
  store i64 %O_cast.sroa.17.30.insert.insert, ptr addrspace(1) %add.ptr626.3, align 8, !dbg !174
  ret void, !dbg !175
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
!1 = !DIFile(filename: "/tmp/tmpul088o9c/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpul088o9c/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 28, column: 3, scope: !40)
!44 = !DILocation(line: 29, column: 48, scope: !40)
!45 = !DILocation(line: 29, column: 34, scope: !40)
!46 = !DILocation(line: 32, column: 3, scope: !40)
!47 = !DILocation(line: 33, column: 22, scope: !40)
!48 = !DILocation(line: 40, column: 27, scope: !40)
!49 = !DILocation(line: 33, column: 60, scope: !40)
!50 = !DILocation(line: 51, column: 60, scope: !40)
!51 = !DILocation(line: 58, column: 22, scope: !40)
!52 = !DILocation(line: 59, column: 17, scope: !40)
!53 = !DILocation(line: 60, column: 5, scope: !40)
!54 = !DILocation(line: 0, scope: !40)
!55 = !DILocation(line: 51, column: 31, scope: !40)
!56 = !DILocation(line: 53, column: 74, scope: !40)
!57 = !DILocation(line: 53, column: 61, scope: !40)
!58 = !DILocation(line: 69, column: 60, scope: !40)
!59 = !DILocation(line: 76, column: 22, scope: !40)
!60 = !DILocation(line: 77, column: 17, scope: !40)
!61 = !DILocation(line: 78, column: 5, scope: !40)
!62 = !DILocation(line: 69, column: 31, scope: !40)
!63 = !DILocation(line: 71, column: 74, scope: !40)
!64 = !DILocation(line: 71, column: 61, scope: !40)
!65 = !DILocation(line: 85, column: 130, scope: !40)
!66 = !DILocation(line: 85, column: 40, scope: !40)
!67 = !DILocation(line: 85, column: 220, scope: !40)
!68 = !DILocation(line: 85, column: 149, scope: !40)
!69 = !DILocation(line: 68, column: 3, scope: !70, inlinedAt: !72)
!70 = distinct !DISubprogram(name: "__barrier_warp", scope: !71, file: !71, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!71 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!72 = distinct !DILocation(line: 192, column: 3, scope: !73, inlinedAt: !74)
!73 = distinct !DISubprogram(name: "__syncwarp", scope: !71, file: !71, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!74 = distinct !DILocation(line: 87, column: 3, scope: !40)
!75 = !DILocation(line: 69, column: 3, scope: !70, inlinedAt: !72)
!76 = !DILocation(line: 70, column: 3, scope: !70, inlinedAt: !72)
!77 = !DILocation(line: 90, column: 151, scope: !40)
!78 = !DILocation(line: 90, column: 71, scope: !40)
!79 = !DILocation(line: 90, column: 34, scope: !40)
!80 = !DILocation(line: 68, column: 3, scope: !70, inlinedAt: !81)
!81 = distinct !DILocation(line: 192, column: 3, scope: !73, inlinedAt: !82)
!82 = distinct !DILocation(line: 92, column: 3, scope: !40)
!83 = !DILocation(line: 69, column: 3, scope: !70, inlinedAt: !81)
!84 = !DILocation(line: 70, column: 3, scope: !70, inlinedAt: !81)
!85 = !DILocation(line: 94, column: 8, scope: !40)
!86 = !DILocation(line: 95, column: 157, scope: !40)
!87 = !DILocation(line: 95, column: 40, scope: !40)
!88 = !DILocation(line: 68, column: 3, scope: !70, inlinedAt: !89)
!89 = distinct !DILocation(line: 192, column: 3, scope: !73, inlinedAt: !90)
!90 = distinct !DILocation(line: 102, column: 3, scope: !40)
!91 = !DILocation(line: 69, column: 3, scope: !70, inlinedAt: !89)
!92 = !DILocation(line: 70, column: 3, scope: !70, inlinedAt: !89)
!93 = !DILocation(line: 104, column: 5, scope: !40)
!94 = !DILocation(line: 105, column: 68, scope: !40)
!95 = !DILocation(line: 105, column: 31, scope: !40)
!96 = !DILocation(line: 105, column: 83, scope: !40)
!97 = !DILocation(line: 110, column: 38, scope: !40)
!98 = !DILocation(line: 68, column: 3, scope: !70, inlinedAt: !99)
!99 = distinct !DILocation(line: 192, column: 3, scope: !73, inlinedAt: !100)
!100 = distinct !DILocation(line: 117, column: 3, scope: !40)
!101 = !DILocation(line: 69, column: 3, scope: !70, inlinedAt: !99)
!102 = !DILocation(line: 70, column: 3, scope: !70, inlinedAt: !99)
!103 = !DILocation(line: 119, column: 8, scope: !40)
!104 = !DILocation(line: 120, column: 84, scope: !40)
!105 = !DILocation(line: 120, column: 40, scope: !40)
!106 = !DILocation(line: 126, column: 66, scope: !40)
!107 = !DILocation(line: 132, column: 66, scope: !40)
!108 = !DILocation(line: 138, column: 66, scope: !40)
!109 = !DILocation(line: 143, column: 14, scope: !40)
!110 = !DILocation(line: 143, column: 28, scope: !40)
!111 = !DILocation(line: 144, column: 29, scope: !40)
!112 = !DILocation(line: 144, column: 40, scope: !40)
!113 = !DILocation(line: 354, column: 10, scope: !114, inlinedAt: !116)
!114 = distinct !DISubprogram(name: "min", scope: !115, file: !115, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!115 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!116 = distinct !DILocation(line: 144, column: 24, scope: !40)
!117 = !DILocation(line: 288, column: 10, scope: !118, inlinedAt: !119)
!118 = distinct !DISubprogram(name: "expf", scope: !115, file: !115, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!119 = distinct !DILocation(line: 144, column: 19, scope: !40)
!120 = !DILocation(line: 145, column: 5, scope: !40)
!121 = !DILocation(line: 132, column: 53, scope: !40)
!122 = !DILocation(line: 138, column: 53, scope: !40)
!123 = !DILocation(line: 128, column: 102, scope: !40)
!124 = !DILocation(line: 134, column: 102, scope: !40)
!125 = !DILocation(line: 140, column: 102, scope: !40)
!126 = !DILocation(line: 134, column: 89, scope: !40)
!127 = !DILocation(line: 140, column: 89, scope: !40)
!128 = !DILocation(line: 155, column: 34, scope: !40)
!129 = !DILocation(line: 161, column: 44, scope: !40)
!130 = !DILocation(line: 166, column: 34, scope: !40)
!131 = !DILocation(line: 166, column: 32, scope: !40)
!132 = !DILocation(line: 166, column: 7, scope: !40)
!133 = !DILocation(line: 168, column: 37, scope: !40)
!134 = !DILocation(line: 168, column: 34, scope: !40)
!135 = !DILocation(line: 169, column: 20, scope: !40)
!136 = !DILocation(line: 169, column: 88, scope: !40)
!137 = !DILocation(line: 169, column: 68, scope: !40)
!138 = !DILocation(line: 169, column: 41, scope: !40)
!139 = !DILocation(line: 169, column: 162, scope: !40)
!140 = !DILocation(line: 169, column: 142, scope: !40)
!141 = !DILocation(line: 169, column: 115, scope: !40)
!142 = !DILocation(line: 170, column: 3, scope: !40)
!143 = !DILocation(line: 176, column: 32, scope: !40)
!144 = !DILocation(line: 75, column: 10, scope: !145, inlinedAt: !147)
!145 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !146, file: !146, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!146 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!147 = distinct !DILocation(line: 984, column: 9, scope: !148, inlinedAt: !150)
!148 = distinct !DISubprogram(name: "__float2half", scope: !149, file: !149, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!149 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!150 = distinct !DILocation(line: 133, column: 53, scope: !151, inlinedAt: !152)
!151 = distinct !DISubprogram(name: "__half", scope: !149, file: !149, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!152 = distinct !DILocation(line: 182, column: 53, scope: !40)
!153 = !DILocation(line: 182, column: 50, scope: !40)
!154 = !DILocation(line: 68, column: 3, scope: !70, inlinedAt: !155)
!155 = distinct !DILocation(line: 192, column: 3, scope: !73, inlinedAt: !156)
!156 = distinct !DILocation(line: 185, column: 3, scope: !40)
!157 = !DILocation(line: 69, column: 3, scope: !70, inlinedAt: !155)
!158 = !DILocation(line: 70, column: 3, scope: !70, inlinedAt: !155)
!159 = !DILocation(line: 189, column: 137, scope: !40)
!160 = !DILocation(line: 189, column: 31, scope: !40)
!161 = !DILocation(line: 189, column: 29, scope: !40)
!162 = !{!26, !26, i64 0}
!163 = !DILocation(line: 194, column: 38, scope: !40)
!164 = !DILocation(line: 189, column: 111, scope: !40)
!165 = !DILocation(line: 189, column: 123, scope: !40)
!166 = !DILocation(line: 204, column: 61, scope: !40)
!167 = !DILocation(line: 75, column: 10, scope: !145, inlinedAt: !168)
!168 = distinct !DILocation(line: 984, column: 9, scope: !148, inlinedAt: !169)
!169 = distinct !DILocation(line: 133, column: 53, scope: !151, inlinedAt: !170)
!170 = distinct !DILocation(line: 204, column: 53, scope: !40)
!171 = !DILocation(line: 204, column: 50, scope: !40)
!172 = !DILocation(line: 208, column: 3, scope: !40)
!173 = !DILocation(line: 209, column: 22, scope: !40)
!174 = !DILocation(line: 209, column: 141, scope: !40)
!175 = !DILocation(line: 211, column: 1, scope: !40)
