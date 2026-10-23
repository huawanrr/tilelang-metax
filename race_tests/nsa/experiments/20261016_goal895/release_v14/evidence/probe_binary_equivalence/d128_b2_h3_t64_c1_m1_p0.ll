; ModuleID = 'experiments/20261016_goal895/probe_binary_equivalence/d128_b2_h3_t64_c1_m1_p0.bc'
source_filename = "/tmp/tmpzjovluzr/tvm_kernels.maca"
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
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %BlockIndices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K_blocks.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V_blocks.coerce) local_unnamed_addr #3 !dbg !40 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %div = udiv i32 %0, 3
  %mul = mul nuw nsw i32 %div, 393216
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul7 = mul nuw nsw i32 %1, 6144
  %2 = mul i32 %div, 3
  %rem.decomposed = sub i32 %0, %2
  %mul9 = shl nuw nsw i32 %rem.decomposed, 11
  %3 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %mul14 = shl nuw nsw i32 %3, 3
  %add = add nuw nsw i32 %mul14, %mul7
  %add10 = add nuw nsw i32 %add, %mul
  %add12 = add nuw nsw i32 %add10, %mul9
  %4 = zext nneg i32 %add12 to i64, !dbg !43
  %5 = add nuw nsw i64 %4, 512, !dbg !44
  %6 = add nuw nsw i64 %4, 1024, !dbg !44
  %7 = add nuw nsw i64 %4, 1536, !dbg !44
  %mul21 = mul nuw nsw i32 %div, 192, !dbg !45
  %mul23 = mul nuw nsw i32 %1, 3, !dbg !46
  %add24 = add nuw nsw i32 %rem.decomposed, %mul23, !dbg !47
  %add27 = add nuw nsw i32 %add24, %mul21, !dbg !48
  %idxprom = zext nneg i32 %add27 to i64, !dbg !49
  %arrayidx28 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom, !dbg !49
  %8 = load i32, ptr addrspace(1) %arrayidx28, align 4, !dbg !49, !tbaa !30
  %cmp43 = icmp ugt i32 %8, 3
  %shr = lshr i32 %1, 4
  %cmp46.not = icmp ugt i32 %8, %shr
  %or.cond = or i1 %cmp43, %cmp46.not, !dbg !50
  br i1 %or.cond, label %if.end372, label %for.cond49.preheader, !dbg !50

for.cond49.preheader:                             ; preds = %entry
  %add.ptr.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %7, !dbg !51
  %add.ptr.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %6, !dbg !51
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %5, !dbg !51
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4, !dbg !51
  %mul60 = mul nuw nsw i32 %div, 24576
  %mul61 = mul nuw nsw i32 %8, 6144
  %shr66 = lshr i32 %3, 4
  %mul67 = mul nuw nsw i32 %shr66, 384
  %mul71 = shl nuw nsw i32 %rem.decomposed, 7
  %add62 = add nuw nsw i32 %mul67, %mul60
  %add64 = add nuw nsw i32 %add62, %mul71
  %mul74 = and i32 %mul14, 120
  %add68 = or disjoint i32 %add64, %mul74
  %add72 = add nuw nsw i32 %add68, %mul61
  %9 = zext nneg i32 %add72 to i64, !dbg !52
  %add.ptr79 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %9, !dbg !53
  %10 = load i32, ptr addrspace(4) %add.ptr79, align 4, !dbg !54, !tbaa !30
  %11 = or disjoint i64 %9, 2, !dbg !55
  %add.ptr79.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %11, !dbg !53
  %12 = load i32, ptr addrspace(4) %add.ptr79.1, align 4, !dbg !54, !tbaa !30
  %13 = or disjoint i64 %9, 4, !dbg !55
  %add.ptr79.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %13, !dbg !53
  %14 = load i32, ptr addrspace(4) %add.ptr79.2, align 4, !dbg !54, !tbaa !30
  %15 = or disjoint i64 %9, 6, !dbg !55
  %add.ptr79.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %15, !dbg !53
  %16 = load i32, ptr addrspace(4) %add.ptr79.3, align 4, !dbg !54, !tbaa !30
  %17 = add nuw nsw i64 %9, 1536
  %add.ptr79.1693 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %17, !dbg !53
  %18 = load i32, ptr addrspace(4) %add.ptr79.1693, align 4, !dbg !54, !tbaa !30
  %19 = add nuw nsw i64 %9, 1538, !dbg !55
  %add.ptr79.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %19, !dbg !53
  %20 = load i32, ptr addrspace(4) %add.ptr79.1.1, align 4, !dbg !54, !tbaa !30
  %21 = add nuw nsw i64 %9, 1540, !dbg !55
  %add.ptr79.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %21, !dbg !53
  %22 = load i32, ptr addrspace(4) %add.ptr79.2.1, align 4, !dbg !54, !tbaa !30
  %23 = add nuw nsw i64 %9, 1542, !dbg !55
  %add.ptr79.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %23, !dbg !53
  %24 = load i32, ptr addrspace(4) %add.ptr79.3.1, align 4, !dbg !54, !tbaa !30
  %25 = add nuw nsw i64 %9, 3072
  %add.ptr79.2695 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %25, !dbg !53
  %26 = load i32, ptr addrspace(4) %add.ptr79.2695, align 4, !dbg !54, !tbaa !30
  %27 = add nuw nsw i64 %9, 3074, !dbg !55
  %add.ptr79.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %27, !dbg !53
  %28 = load i32, ptr addrspace(4) %add.ptr79.1.2, align 4, !dbg !54, !tbaa !30
  %29 = add nuw nsw i64 %9, 3076, !dbg !55
  %add.ptr79.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %29, !dbg !53
  %30 = load i32, ptr addrspace(4) %add.ptr79.2.2, align 4, !dbg !54, !tbaa !30
  %31 = add nuw nsw i64 %9, 3078, !dbg !55
  %add.ptr79.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %31, !dbg !53
  %32 = load i32, ptr addrspace(4) %add.ptr79.3.2, align 4, !dbg !54, !tbaa !30
  %33 = add nuw nsw i64 %9, 4608
  %add.ptr79.3697 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %33, !dbg !53
  %34 = load i32, ptr addrspace(4) %add.ptr79.3697, align 4, !dbg !54, !tbaa !30
  %35 = add nuw nsw i64 %9, 4610, !dbg !55
  %add.ptr79.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %35, !dbg !53
  %36 = load i32, ptr addrspace(4) %add.ptr79.1.3, align 4, !dbg !54, !tbaa !30
  %37 = add nuw nsw i64 %9, 4612, !dbg !55
  %add.ptr79.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %37, !dbg !53
  %38 = load i32, ptr addrspace(4) %add.ptr79.2.3, align 4, !dbg !54, !tbaa !30
  %39 = add nuw nsw i64 %9, 4614, !dbg !55
  %add.ptr79.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %39, !dbg !53
  %40 = load i32, ptr addrspace(4) %add.ptr79.3.3, align 4, !dbg !54, !tbaa !30
  %add.ptr122 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %9, !dbg !56
  %41 = load i32, ptr addrspace(4) %add.ptr122, align 4, !dbg !57, !tbaa !30
  %add.ptr122.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %11, !dbg !56
  %42 = load i32, ptr addrspace(4) %add.ptr122.1, align 4, !dbg !57, !tbaa !30
  %add.ptr122.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %13, !dbg !56
  %43 = load i32, ptr addrspace(4) %add.ptr122.2, align 4, !dbg !57, !tbaa !30
  %add.ptr122.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %15, !dbg !56
  %44 = load i32, ptr addrspace(4) %add.ptr122.3, align 4, !dbg !57, !tbaa !30
  %add.ptr122.1709 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %17, !dbg !56
  %45 = load i32, ptr addrspace(4) %add.ptr122.1709, align 4, !dbg !57, !tbaa !30
  %add.ptr122.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %19, !dbg !56
  %46 = load i32, ptr addrspace(4) %add.ptr122.1.1, align 4, !dbg !57, !tbaa !30
  %add.ptr122.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %21, !dbg !56
  %47 = load i32, ptr addrspace(4) %add.ptr122.2.1, align 4, !dbg !57, !tbaa !30
  %add.ptr122.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %23, !dbg !56
  %48 = load i32, ptr addrspace(4) %add.ptr122.3.1, align 4, !dbg !57, !tbaa !30
  %add.ptr122.2711 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %25, !dbg !56
  %49 = load i32, ptr addrspace(4) %add.ptr122.2711, align 4, !dbg !57, !tbaa !30
  %add.ptr122.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %27, !dbg !56
  %50 = load i32, ptr addrspace(4) %add.ptr122.1.2, align 4, !dbg !57, !tbaa !30
  %add.ptr122.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %29, !dbg !56
  %51 = load i32, ptr addrspace(4) %add.ptr122.2.2, align 4, !dbg !57, !tbaa !30
  %add.ptr122.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %31, !dbg !56
  %52 = load i32, ptr addrspace(4) %add.ptr122.3.2, align 4, !dbg !57, !tbaa !30
  %add.ptr122.3713 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %33, !dbg !56
  %53 = load i32, ptr addrspace(4) %add.ptr122.3713, align 4, !dbg !57, !tbaa !30
  %add.ptr122.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %35, !dbg !56
  %54 = load i32, ptr addrspace(4) %add.ptr122.1.3, align 4, !dbg !57, !tbaa !30
  %add.ptr122.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %37, !dbg !56
  %55 = load i32, ptr addrspace(4) %add.ptr122.2.3, align 4, !dbg !57, !tbaa !30
  %add.ptr122.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %39, !dbg !56
  %56 = load i32, ptr addrspace(4) %add.ptr122.3.3, align 4, !dbg !57, !tbaa !30
  %mul146 = and i32 %mul14, 8064
  %and149 = and i32 %3, 15
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul146, !dbg !58
  %xor = xor i32 %shr66, %and149, !dbg !59
  %add.ptr157.idx = shl nuw nsw i32 %xor, 4, !dbg !60
  %add.ptr157 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 %add.ptr157.idx, !dbg !60
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr157, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !dbg !61, !call_argsrelate !62
  %add153.1 = add nuw nsw i32 %shr66, 4, !dbg !63
  %xor.1 = xor i32 %add153.1, %and149, !dbg !59
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1024, !dbg !60
  %add.ptr157.idx.1 = shl nuw nsw i32 %xor.1, 4, !dbg !60
  %add.ptr157.1 = getelementptr inbounds i8, ptr addrspace(3) %gep.1, i32 %add.ptr157.idx.1, !dbg !60
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr157.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !dbg !61, !call_argsrelate !62
  %add153.2 = add nuw nsw i32 %shr66, 8, !dbg !63
  %xor.2 = xor i32 %add153.2, %and149, !dbg !59
  %gep.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 2048, !dbg !60
  %add.ptr157.idx.2 = shl nuw nsw i32 %xor.2, 4, !dbg !60
  %add.ptr157.2 = getelementptr inbounds i8, ptr addrspace(3) %gep.2, i32 %add.ptr157.idx.2, !dbg !60
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr157.2, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.2, i64 16, i1 false), !dbg !61, !call_argsrelate !62
  %add153.3 = add nuw nsw i32 %shr66, 12, !dbg !63
  %xor.3 = xor i32 %add153.3, %and149, !dbg !59
  %gep.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 3072, !dbg !60
  %add.ptr157.idx.3 = shl nuw nsw i32 %xor.3, 4, !dbg !60
  %add.ptr157.3 = getelementptr inbounds i8, ptr addrspace(3) %gep.3, i32 %add.ptr157.idx.3, !dbg !60
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr157.3, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.3, i64 16, i1 false), !dbg !61, !call_argsrelate !62
  fence syncscope("warp") release, !dbg !64
  tail call void @llvm.mxc.barrier.warp(), !dbg !70
  fence syncscope("warp") acquire, !dbg !71
  %and166 = shl nuw nsw i32 %3, 7
  %mul167 = and i32 %and166, 1920
  %57 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul167
  %add.ptr178 = getelementptr inbounds i8, ptr addrspace(3) %57, i32 %add.ptr157.idx, !dbg !72
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr178, align 16, !dbg !73
  %Q_reg.sroa.4.0.add.ptr178.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr178, i32 8, !dbg !73
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr178.sroa_idx, align 8, !dbg !73
  %add.ptr178.1 = getelementptr inbounds i8, ptr addrspace(3) %57, i32 %add.ptr157.idx.1, !dbg !72
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr178.1, align 16, !dbg !73
  %Q_reg.sroa.7.16.add.ptr178.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr178.1, i32 8, !dbg !73
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr178.1.sroa_idx, align 8, !dbg !73
  %add.ptr178.2 = getelementptr inbounds i8, ptr addrspace(3) %57, i32 %add.ptr157.idx.2, !dbg !72
  %Q_reg.sroa.8.32.copyload = load <4 x half>, ptr addrspace(3) %add.ptr178.2, align 16, !dbg !73
  %Q_reg.sroa.10.32.add.ptr178.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr178.2, i32 8, !dbg !73
  %Q_reg.sroa.10.32.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.10.32.add.ptr178.2.sroa_idx, align 8, !dbg !73
  %add.ptr178.3 = getelementptr inbounds i8, ptr addrspace(3) %57, i32 %add.ptr157.idx.3, !dbg !72
  %Q_reg.sroa.11.48.copyload = load <4 x half>, ptr addrspace(3) %add.ptr178.3, align 16, !dbg !73
  %Q_reg.sroa.13.48.add.ptr178.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr178.3, i32 8, !dbg !73
  %Q_reg.sroa.13.48.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.13.48.add.ptr178.3.sroa_idx, align 8, !dbg !73
  fence syncscope("warp") release, !dbg !74
  tail call void @llvm.mxc.barrier.warp(), !dbg !77
  fence syncscope("warp") acquire, !dbg !78
  store i32 %10, ptr addrspace(3) %add.ptr157, align 16, !dbg !79, !tbaa !30
  %K_reg.sroa.4.0.add.ptr209.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157, i32 4, !dbg !79
  store i32 %12, ptr addrspace(3) %K_reg.sroa.4.0.add.ptr209.sroa_idx, align 4, !dbg !79, !tbaa !30
  %K_reg.sroa.5.0.add.ptr209.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157, i32 8, !dbg !79
  store i32 %14, ptr addrspace(3) %K_reg.sroa.5.0.add.ptr209.sroa_idx, align 8, !dbg !79, !tbaa !30
  %K_reg.sroa.6.0.add.ptr209.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157, i32 12, !dbg !79
  store i32 %16, ptr addrspace(3) %K_reg.sroa.6.0.add.ptr209.sroa_idx, align 4, !dbg !79, !tbaa !30
  store i32 %18, ptr addrspace(3) %add.ptr157.1, align 16, !dbg !79, !tbaa !30
  %K_reg.sroa.9.16.add.ptr209.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.1, i32 4, !dbg !79
  store i32 %20, ptr addrspace(3) %K_reg.sroa.9.16.add.ptr209.1.sroa_idx, align 4, !dbg !79, !tbaa !30
  %K_reg.sroa.10.16.add.ptr209.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.1, i32 8, !dbg !79
  store i32 %22, ptr addrspace(3) %K_reg.sroa.10.16.add.ptr209.1.sroa_idx, align 8, !dbg !79, !tbaa !30
  %K_reg.sroa.11.16.add.ptr209.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.1, i32 12, !dbg !79
  store i32 %24, ptr addrspace(3) %K_reg.sroa.11.16.add.ptr209.1.sroa_idx, align 4, !dbg !79, !tbaa !30
  store i32 %26, ptr addrspace(3) %add.ptr157.2, align 16, !dbg !79, !tbaa !30
  %K_reg.sroa.14.32.add.ptr209.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.2, i32 4, !dbg !79
  store i32 %28, ptr addrspace(3) %K_reg.sroa.14.32.add.ptr209.2.sroa_idx, align 4, !dbg !79, !tbaa !30
  %K_reg.sroa.15.32.add.ptr209.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.2, i32 8, !dbg !79
  store i32 %30, ptr addrspace(3) %K_reg.sroa.15.32.add.ptr209.2.sroa_idx, align 8, !dbg !79, !tbaa !30
  %K_reg.sroa.16.32.add.ptr209.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.2, i32 12, !dbg !79
  store i32 %32, ptr addrspace(3) %K_reg.sroa.16.32.add.ptr209.2.sroa_idx, align 4, !dbg !79, !tbaa !30
  store i32 %34, ptr addrspace(3) %add.ptr157.3, align 16, !dbg !79, !tbaa !30
  %K_reg.sroa.19.48.add.ptr209.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.3, i32 4, !dbg !79
  store i32 %36, ptr addrspace(3) %K_reg.sroa.19.48.add.ptr209.3.sroa_idx, align 4, !dbg !79, !tbaa !30
  %K_reg.sroa.20.48.add.ptr209.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.3, i32 8, !dbg !79
  store i32 %38, ptr addrspace(3) %K_reg.sroa.20.48.add.ptr209.3.sroa_idx, align 8, !dbg !79, !tbaa !30
  %K_reg.sroa.21.48.add.ptr209.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.3, i32 12, !dbg !79
  store i32 %40, ptr addrspace(3) %K_reg.sroa.21.48.add.ptr209.3.sroa_idx, align 4, !dbg !79, !tbaa !30
  fence syncscope("warp") release, !dbg !80
  tail call void @llvm.mxc.barrier.warp(), !dbg !83
  fence syncscope("warp") acquire, !dbg !84
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr178, align 16, !dbg !85
  %kb.sroa.10.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr178.sroa_idx, align 8, !dbg !85
  %58 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !86
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %58), !dbg !86
  %kb.sroa.0.0.copyload751 = load <4 x half>, ptr addrspace(3) %add.ptr178.1, align 16, !dbg !85
  %kb.sroa.10.0.copyload754 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr178.1.sroa_idx, align 8, !dbg !85
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload751, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %59), !dbg !86
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload754, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %60), !dbg !86
  %kb.sroa.0.0.copyload752 = load <4 x half>, ptr addrspace(3) %add.ptr178.2, align 16, !dbg !85
  %kb.sroa.10.0.copyload755 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.10.32.add.ptr178.2.sroa_idx, align 8, !dbg !85
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload752, <4 x half> %Q_reg.sroa.8.32.copyload, <4 x float> %61), !dbg !86
  %63 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload755, <4 x half> %Q_reg.sroa.10.32.copyload, <4 x float> %62), !dbg !86
  %kb.sroa.0.0.copyload753 = load <4 x half>, ptr addrspace(3) %add.ptr178.3, align 16, !dbg !85
  %kb.sroa.10.0.copyload756 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.13.48.add.ptr178.3.sroa_idx, align 8, !dbg !85
  %64 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload753, <4 x half> %Q_reg.sroa.11.48.copyload, <4 x float> %63), !dbg !86
  %65 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload756, <4 x half> %Q_reg.sroa.13.48.copyload, <4 x float> %64), !dbg !86
  fence syncscope("warp") release, !dbg !87
  tail call void @llvm.mxc.barrier.warp(), !dbg !90
  fence syncscope("warp") acquire, !dbg !91
  %add.ptr272.idx = shl nuw nsw i32 %3, 4
  %invariant.gep658 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr272.idx, !dbg !92
  store i32 %41, ptr addrspace(3) %invariant.gep658, align 16, !dbg !93, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep658.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep658, i32 4, !dbg !93
  store i32 %42, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep658.sroa_idx, align 4, !dbg !93, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep658.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep658, i32 8, !dbg !93
  store i32 %43, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep658.sroa_idx, align 8, !dbg !93, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep658.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep658, i32 12, !dbg !93
  store i32 %44, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep658.sroa_idx, align 4, !dbg !93, !tbaa !30
  %gep659.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep658, i32 1024, !dbg !94
  store i32 %45, ptr addrspace(3) %gep659.1, align 16, !dbg !93, !tbaa !30
  %V_reg.sroa.9.16.gep659.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep658, i32 1028, !dbg !93
  store i32 %46, ptr addrspace(3) %V_reg.sroa.9.16.gep659.1.sroa_idx, align 4, !dbg !93, !tbaa !30
  %V_reg.sroa.10.16.gep659.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep658, i32 1032, !dbg !93
  store i32 %47, ptr addrspace(3) %V_reg.sroa.10.16.gep659.1.sroa_idx, align 8, !dbg !93, !tbaa !30
  %V_reg.sroa.11.16.gep659.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep658, i32 1036, !dbg !93
  store i32 %48, ptr addrspace(3) %V_reg.sroa.11.16.gep659.1.sroa_idx, align 4, !dbg !93, !tbaa !30
  %gep659.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep658, i32 2048, !dbg !94
  store i32 %49, ptr addrspace(3) %gep659.2, align 16, !dbg !93, !tbaa !30
  %V_reg.sroa.14.32.gep659.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep658, i32 2052, !dbg !93
  store i32 %50, ptr addrspace(3) %V_reg.sroa.14.32.gep659.2.sroa_idx, align 4, !dbg !93, !tbaa !30
  %V_reg.sroa.15.32.gep659.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep658, i32 2056, !dbg !93
  store i32 %51, ptr addrspace(3) %V_reg.sroa.15.32.gep659.2.sroa_idx, align 8, !dbg !93, !tbaa !30
  %V_reg.sroa.16.32.gep659.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep658, i32 2060, !dbg !93
  store i32 %52, ptr addrspace(3) %V_reg.sroa.16.32.gep659.2.sroa_idx, align 4, !dbg !93, !tbaa !30
  %gep659.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep658, i32 3072, !dbg !94
  store i32 %53, ptr addrspace(3) %gep659.3, align 16, !dbg !93, !tbaa !30
  %V_reg.sroa.19.48.gep659.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep658, i32 3076, !dbg !93
  store i32 %54, ptr addrspace(3) %V_reg.sroa.19.48.gep659.3.sroa_idx, align 4, !dbg !93, !tbaa !30
  %V_reg.sroa.20.48.gep659.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep658, i32 3080, !dbg !93
  store i32 %55, ptr addrspace(3) %V_reg.sroa.20.48.gep659.3.sroa_idx, align 8, !dbg !93, !tbaa !30
  %V_reg.sroa.21.48.gep659.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep658, i32 3084, !dbg !93
  store i32 %56, ptr addrspace(3) %V_reg.sroa.21.48.gep659.3.sroa_idx, align 4, !dbg !93, !tbaa !30
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %65, i64 0, !dbg !95
  %mul282 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !96
  %66 = tail call contract noundef float @llvm.minnum.f32(float %mul282, float 0x4024CB5EC0000000), !dbg !97
  %67 = tail call contract noundef float @llvm.exp.f32(float %66), !dbg !101
  %acc_s.sroa.0.0.vec.insert764 = insertelement <4 x float> poison, float %67, i64 0, !dbg !104
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %65, i64 1, !dbg !95
  %mul282.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !96
  %68 = tail call contract noundef float @llvm.minnum.f32(float %mul282.1, float 0x4024CB5EC0000000), !dbg !97
  %69 = tail call contract noundef float @llvm.exp.f32(float %68), !dbg !101
  %acc_s.sroa.0.4.vec.insert779 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert764, float %69, i64 1, !dbg !104
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %65, i64 2, !dbg !95
  %mul282.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !96
  %70 = tail call contract noundef float @llvm.minnum.f32(float %mul282.2, float 0x4024CB5EC0000000), !dbg !97
  %71 = tail call contract noundef float @llvm.exp.f32(float %70), !dbg !101
  %acc_s.sroa.0.8.vec.insert794 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert779, float %71, i64 2, !dbg !104
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %65, i64 3, !dbg !95
  %mul282.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !96
  %72 = tail call contract noundef float @llvm.minnum.f32(float %mul282.3, float 0x4024CB5EC0000000), !dbg !97
  %73 = tail call contract noundef float @llvm.exp.f32(float %72), !dbg !101
  %acc_s.sroa.0.12.vec.insert809 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert794, float %73, i64 3, !dbg !104
  %cmp292 = icmp eq i32 %8, %shr, !dbg !105
  br i1 %cmp292, label %for.cond294.preheader, label %if.end313, !dbg !106

for.cond294.preheader:                            ; preds = %for.cond49.preheader
  %74 = lshr i32 %3, 2
  %mul300 = and i32 %74, 252
  %and303 = and i32 %1, 15
  %cmp304.not = icmp ugt i32 %mul300, %and303, !dbg !107
  %spec.select = select i1 %cmp304.not, float 0.000000e+00, float %67, !dbg !108
  %acc_s.sroa.0.0.vec.insert768 = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !109
  %cmp304.not.1.not = icmp ult i32 %mul300, %and303, !dbg !107
  %condval.0.1 = select i1 %cmp304.not.1.not, float %69, float 0.000000e+00, !dbg !108
  %acc_s.sroa.0.4.vec.insert783 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert768, float %condval.0.1, i64 1, !dbg !109
  %add301.2 = or disjoint i32 %mul300, 2, !dbg !110
  %cmp304.not.2 = icmp ugt i32 %add301.2, %and303, !dbg !107
  %condval.0.2 = select i1 %cmp304.not.2, float 0.000000e+00, float %71, !dbg !108
  %acc_s.sroa.0.8.vec.insert798 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert783, float %condval.0.2, i64 2, !dbg !109
  %add301.3 = or i32 %74, 3, !dbg !110
  %cmp304.not.3 = icmp ugt i32 %add301.3, %and303, !dbg !107
  %condval.0.3 = select i1 %cmp304.not.3, float 0.000000e+00, float %73, !dbg !108
  %acc_s.sroa.0.12.vec.insert813 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert798, float %condval.0.3, i64 3, !dbg !109
  br label %if.end313, !dbg !111

if.end313:                                        ; preds = %for.cond294.preheader, %for.cond49.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert813, %for.cond294.preheader ], [ %acc_s.sroa.0.12.vec.insert809, %for.cond49.preheader ], !dbg !112
  %acc_s.sroa.0.0.vec.extract770 = extractelement <4 x float> %acc_s.sroa.0.0, i64 0, !dbg !113
  %add322 = fadd contract float %acc_s.sroa.0.0.vec.extract770, 0.000000e+00, !dbg !114
  %acc_s.sroa.0.4.vec.extract785 = extractelement <4 x float> %acc_s.sroa.0.0, i64 1, !dbg !113
  %add322.1 = fadd contract float %add322, %acc_s.sroa.0.4.vec.extract785, !dbg !114
  %acc_s.sroa.0.8.vec.extract800 = extractelement <4 x float> %acc_s.sroa.0.0, i64 2, !dbg !113
  %add322.2 = fadd contract float %add322.1, %acc_s.sroa.0.8.vec.extract800, !dbg !114
  %acc_s.sroa.0.12.vec.extract815 = extractelement <4 x float> %acc_s.sroa.0.0, i64 3, !dbg !113
  %add322.3 = fadd contract float %add322.2, %acc_s.sroa.0.12.vec.extract815, !dbg !114
  %75 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add322.3, <4 x float> zeroinitializer), !dbg !115
  %wsum_output.sroa.0.0.vec.extract = extractelement <4 x float> %75, i64 0, !dbg !116
  %cmp340 = fcmp contract ogt float %wsum_output.sroa.0.0.vec.extract, 0.000000e+00, !dbg !117
  %div343 = fdiv contract float 1.000000e+00, %wsum_output.sroa.0.0.vec.extract, !dbg !118
  %condval_1.0 = select i1 %cmp340, float %div343, float 0.000000e+00, !dbg !118
  %mul354 = fmul contract float %condval_1.0, %acc_s.sroa.0.0.vec.extract770, !dbg !119
  %acc_s.sroa.0.4.vec.extract787 = extractelement <4 x float> %acc_s.sroa.0.0, i64 1, !dbg !120
  %mul354.1 = fmul contract float %condval_1.0, %acc_s.sroa.0.4.vec.extract787, !dbg !119
  %acc_s.sroa.0.8.vec.extract802 = extractelement <4 x float> %acc_s.sroa.0.0, i64 2, !dbg !120
  %mul354.2 = fmul contract float %condval_1.0, %acc_s.sroa.0.8.vec.extract802, !dbg !119
  %acc_s.sroa.0.12.vec.extract817 = extractelement <4 x float> %acc_s.sroa.0.0, i64 3, !dbg !120
  %mul354.3 = fmul contract float %condval_1.0, %acc_s.sroa.0.12.vec.extract817, !dbg !119
  %76 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul354), !dbg !121
  %77 = insertelement <4 x i16> poison, i16 %76, i64 0, !dbg !130
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul354.1), !dbg !121
  %79 = insertelement <4 x i16> %77, i16 %78, i64 1, !dbg !130
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul354.2), !dbg !121
  %81 = insertelement <4 x i16> %79, i16 %80, i64 2, !dbg !130
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul354.3), !dbg !121
  %83 = insertelement <4 x i16> %81, i16 %82, i64 3, !dbg !130
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %83 to <4 x half>, !dbg !130
  fence syncscope("warp") release, !dbg !131
  tail call void @llvm.mxc.barrier.warp(), !dbg !134
  fence syncscope("warp") acquire, !dbg !135
  br label %if.end372, !dbg !136

if.end372:                                        ; preds = %entry, %if.end313
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ %acc_s_cast.sroa.0.6.vec.insert, %if.end313 ], [ undef, %entry ]
  %cmp388 = icmp ugt i32 %8, 3
  %cmp392.not = icmp ugt i32 %8, %shr
  %or.cond678 = or i1 %cmp388, %cmp392.not, !dbg !137
  br i1 %or.cond678, label %if.end372.if.end442_crit_edge, label %for.cond394.preheader, !dbg !137

if.end372.if.end442_crit_edge:                    ; preds = %if.end372
  %.pre926 = and i32 %3, 15
  br label %if.end442, !dbg !137

for.cond394.preheader:                            ; preds = %if.end372
  %84 = shl nuw nsw i32 %3, 5
  %mul404 = and i32 %84, 32256
  %and410 = and i32 %3, 15
  %add411 = or disjoint i32 %mul404, %and410, !dbg !138
  %arrayidx413 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411, !dbg !139
  %85 = load half, ptr addrspace(3) %arrayidx413, align 2, !dbg !140, !tbaa !141
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %85, i64 0, !dbg !140
  %add406.1 = or disjoint i32 %mul404, %and410, !dbg !138
  %add411.1 = or disjoint i32 %add406.1, 128, !dbg !138
  %arrayidx413.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.1, !dbg !139
  %86 = load half, ptr addrspace(3) %arrayidx413.1, align 2, !dbg !140, !tbaa !141
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %86, i64 1, !dbg !140
  %add406.2 = or disjoint i32 %mul404, %and410, !dbg !138
  %add411.2 = or disjoint i32 %add406.2, 256, !dbg !138
  %arrayidx413.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.2, !dbg !139
  %87 = load half, ptr addrspace(3) %arrayidx413.2, align 2, !dbg !140, !tbaa !141
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %87, i64 2, !dbg !140
  %add406.3 = or disjoint i32 %mul404, %and410, !dbg !138
  %add411.3 = or disjoint i32 %add406.3, 384, !dbg !138
  %arrayidx413.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.3, !dbg !139
  %88 = load half, ptr addrspace(3) %arrayidx413.3, align 2, !dbg !140, !tbaa !141
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %88, i64 3, !dbg !140
  %add408.1717 = or disjoint i32 %mul404, %and410, !dbg !138
  %add411.1718 = or disjoint i32 %add408.1717, 16, !dbg !138
  %arrayidx413.1719 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.1718, !dbg !139
  %89 = load half, ptr addrspace(3) %arrayidx413.1719, align 2, !dbg !140, !tbaa !141
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %89, i64 0, !dbg !140
  %add408.1.1 = or disjoint i32 %mul404, %and410, !dbg !138
  %add411.1.1 = or disjoint i32 %add408.1.1, 144, !dbg !138
  %arrayidx413.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.1.1, !dbg !139
  %90 = load half, ptr addrspace(3) %arrayidx413.1.1, align 2, !dbg !140, !tbaa !141
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %90, i64 1, !dbg !140
  %add408.2.1 = or disjoint i32 %mul404, %and410, !dbg !138
  %add411.2.1 = or disjoint i32 %add408.2.1, 272, !dbg !138
  %arrayidx413.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.2.1, !dbg !139
  %91 = load half, ptr addrspace(3) %arrayidx413.2.1, align 2, !dbg !140, !tbaa !141
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %91, i64 2, !dbg !140
  %add408.3.1 = or disjoint i32 %mul404, %and410, !dbg !138
  %add411.3.1 = or disjoint i32 %add408.3.1, 400, !dbg !138
  %arrayidx413.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.3.1, !dbg !139
  %92 = load half, ptr addrspace(3) %arrayidx413.3.1, align 2, !dbg !140, !tbaa !141
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %92, i64 3, !dbg !140
  %add408.2721 = or disjoint i32 %mul404, %and410, !dbg !138
  %add411.2722 = or disjoint i32 %add408.2721, 32, !dbg !138
  %arrayidx413.2723 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.2722, !dbg !139
  %93 = load half, ptr addrspace(3) %arrayidx413.2723, align 2, !dbg !140, !tbaa !141
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %93, i64 0, !dbg !140
  %add408.1.2 = or disjoint i32 %mul404, %and410, !dbg !138
  %add411.1.2 = or disjoint i32 %add408.1.2, 160, !dbg !138
  %arrayidx413.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.1.2, !dbg !139
  %94 = load half, ptr addrspace(3) %arrayidx413.1.2, align 2, !dbg !140, !tbaa !141
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %94, i64 1, !dbg !140
  %add408.2.2 = or disjoint i32 %mul404, %and410, !dbg !138
  %add411.2.2 = or disjoint i32 %add408.2.2, 288, !dbg !138
  %arrayidx413.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.2.2, !dbg !139
  %95 = load half, ptr addrspace(3) %arrayidx413.2.2, align 2, !dbg !140, !tbaa !141
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %95, i64 2, !dbg !140
  %add408.3.2 = or disjoint i32 %mul404, %and410, !dbg !138
  %add411.3.2 = or disjoint i32 %add408.3.2, 416, !dbg !138
  %arrayidx413.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.3.2, !dbg !139
  %96 = load half, ptr addrspace(3) %arrayidx413.3.2, align 2, !dbg !140, !tbaa !141
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %96, i64 3, !dbg !140
  %add408.3725 = or disjoint i32 %mul404, %and410, !dbg !138
  %add411.3726 = or disjoint i32 %add408.3725, 48, !dbg !138
  %arrayidx413.3727 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.3726, !dbg !139
  %97 = load half, ptr addrspace(3) %arrayidx413.3727, align 2, !dbg !140, !tbaa !141
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %97, i64 0, !dbg !140
  %add408.1.3 = or disjoint i32 %mul404, %and410, !dbg !138
  %add411.1.3 = or disjoint i32 %add408.1.3, 176, !dbg !138
  %arrayidx413.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.1.3, !dbg !139
  %98 = load half, ptr addrspace(3) %arrayidx413.1.3, align 2, !dbg !140, !tbaa !141
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %98, i64 1, !dbg !140
  %add408.2.3 = or disjoint i32 %mul404, %and410, !dbg !138
  %add411.2.3 = or disjoint i32 %add408.2.3, 304, !dbg !138
  %arrayidx413.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.2.3, !dbg !139
  %99 = load half, ptr addrspace(3) %arrayidx413.2.3, align 2, !dbg !140, !tbaa !141
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %99, i64 2, !dbg !140
  %add408.3.3 = or disjoint i32 %mul404, %and410, !dbg !138
  %add411.3.3 = or disjoint i32 %add408.3.3, 432, !dbg !138
  %arrayidx413.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.3.3, !dbg !139
  %100 = load half, ptr addrspace(3) %arrayidx413.3.3, align 2, !dbg !140, !tbaa !141
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %100, i64 3, !dbg !140
  %add408.4 = or disjoint i32 %mul404, %and410, !dbg !138
  %add411.4 = or disjoint i32 %add408.4, 64, !dbg !138
  %arrayidx413.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.4, !dbg !139
  %101 = load half, ptr addrspace(3) %arrayidx413.4, align 2, !dbg !140, !tbaa !141
  %vb.sroa.22.32.vec.insert = insertelement <4 x half> poison, half %101, i64 0, !dbg !140
  %add408.1.4 = or disjoint i32 %mul404, %and410, !dbg !138
  %add411.1.4 = or disjoint i32 %add408.1.4, 192, !dbg !138
  %arrayidx413.1.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.1.4, !dbg !139
  %102 = load half, ptr addrspace(3) %arrayidx413.1.4, align 2, !dbg !140, !tbaa !141
  %vb.sroa.22.34.vec.insert = insertelement <4 x half> %vb.sroa.22.32.vec.insert, half %102, i64 1, !dbg !140
  %add408.2.4 = or disjoint i32 %mul404, %and410, !dbg !138
  %add411.2.4 = or disjoint i32 %add408.2.4, 320, !dbg !138
  %arrayidx413.2.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.2.4, !dbg !139
  %103 = load half, ptr addrspace(3) %arrayidx413.2.4, align 2, !dbg !140, !tbaa !141
  %vb.sroa.22.36.vec.insert = insertelement <4 x half> %vb.sroa.22.34.vec.insert, half %103, i64 2, !dbg !140
  %add408.3.4 = or disjoint i32 %mul404, %and410, !dbg !138
  %add411.3.4 = or disjoint i32 %add408.3.4, 448, !dbg !138
  %arrayidx413.3.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.3.4, !dbg !139
  %104 = load half, ptr addrspace(3) %arrayidx413.3.4, align 2, !dbg !140, !tbaa !141
  %vb.sroa.22.38.vec.insert = insertelement <4 x half> %vb.sroa.22.36.vec.insert, half %104, i64 3, !dbg !140
  %add408.5 = or disjoint i32 %mul404, %and410, !dbg !138
  %add411.5 = or disjoint i32 %add408.5, 80, !dbg !138
  %arrayidx413.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.5, !dbg !139
  %105 = load half, ptr addrspace(3) %arrayidx413.5, align 2, !dbg !140, !tbaa !141
  %vb.sroa.27.40.vec.insert = insertelement <4 x half> poison, half %105, i64 0, !dbg !140
  %add408.1.5 = or disjoint i32 %mul404, %and410, !dbg !138
  %add411.1.5 = or disjoint i32 %add408.1.5, 208, !dbg !138
  %arrayidx413.1.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.1.5, !dbg !139
  %106 = load half, ptr addrspace(3) %arrayidx413.1.5, align 2, !dbg !140, !tbaa !141
  %vb.sroa.27.42.vec.insert = insertelement <4 x half> %vb.sroa.27.40.vec.insert, half %106, i64 1, !dbg !140
  %add408.2.5 = or disjoint i32 %mul404, %and410, !dbg !138
  %add411.2.5 = or disjoint i32 %add408.2.5, 336, !dbg !138
  %arrayidx413.2.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.2.5, !dbg !139
  %107 = load half, ptr addrspace(3) %arrayidx413.2.5, align 2, !dbg !140, !tbaa !141
  %vb.sroa.27.44.vec.insert = insertelement <4 x half> %vb.sroa.27.42.vec.insert, half %107, i64 2, !dbg !140
  %add408.3.5 = or disjoint i32 %mul404, %and410, !dbg !138
  %add411.3.5 = or disjoint i32 %add408.3.5, 464, !dbg !138
  %arrayidx413.3.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.3.5, !dbg !139
  %108 = load half, ptr addrspace(3) %arrayidx413.3.5, align 2, !dbg !140, !tbaa !141
  %vb.sroa.27.46.vec.insert = insertelement <4 x half> %vb.sroa.27.44.vec.insert, half %108, i64 3, !dbg !140
  %add408.6 = or disjoint i32 %mul404, %and410, !dbg !138
  %add411.6 = or disjoint i32 %add408.6, 96, !dbg !138
  %arrayidx413.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.6, !dbg !139
  %109 = load half, ptr addrspace(3) %arrayidx413.6, align 2, !dbg !140, !tbaa !141
  %vb.sroa.32.48.vec.insert = insertelement <4 x half> poison, half %109, i64 0, !dbg !140
  %add408.1.6 = or disjoint i32 %mul404, %and410, !dbg !138
  %add411.1.6 = or disjoint i32 %add408.1.6, 224, !dbg !138
  %arrayidx413.1.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.1.6, !dbg !139
  %110 = load half, ptr addrspace(3) %arrayidx413.1.6, align 2, !dbg !140, !tbaa !141
  %vb.sroa.32.50.vec.insert = insertelement <4 x half> %vb.sroa.32.48.vec.insert, half %110, i64 1, !dbg !140
  %add408.2.6 = or disjoint i32 %mul404, %and410, !dbg !138
  %add411.2.6 = or disjoint i32 %add408.2.6, 352, !dbg !138
  %arrayidx413.2.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.2.6, !dbg !139
  %111 = load half, ptr addrspace(3) %arrayidx413.2.6, align 2, !dbg !140, !tbaa !141
  %vb.sroa.32.52.vec.insert = insertelement <4 x half> %vb.sroa.32.50.vec.insert, half %111, i64 2, !dbg !140
  %add408.3.6 = or disjoint i32 %84, %and410, !dbg !138
  %add411.3.6 = or i32 %add408.3.6, 480, !dbg !138
  %arrayidx413.3.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.3.6, !dbg !139
  %112 = load half, ptr addrspace(3) %arrayidx413.3.6, align 2, !dbg !140, !tbaa !141
  %vb.sroa.32.54.vec.insert = insertelement <4 x half> %vb.sroa.32.52.vec.insert, half %112, i64 3, !dbg !140
  %add408.7 = or disjoint i32 %mul404, %and410, !dbg !138
  %add411.7 = or disjoint i32 %add408.7, 112, !dbg !138
  %arrayidx413.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.7, !dbg !139
  %113 = load half, ptr addrspace(3) %arrayidx413.7, align 2, !dbg !140, !tbaa !141
  %vb.sroa.37.56.vec.insert = insertelement <4 x half> poison, half %113, i64 0, !dbg !140
  %add408.1.7 = or disjoint i32 %mul404, %and410, !dbg !138
  %add411.1.7 = or disjoint i32 %add408.1.7, 240, !dbg !138
  %arrayidx413.1.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.1.7, !dbg !139
  %114 = load half, ptr addrspace(3) %arrayidx413.1.7, align 2, !dbg !140, !tbaa !141
  %vb.sroa.37.58.vec.insert = insertelement <4 x half> %vb.sroa.37.56.vec.insert, half %114, i64 1, !dbg !140
  %add408.2.7 = or disjoint i32 %mul404, %and410, !dbg !138
  %add411.2.7 = or disjoint i32 %add408.2.7, 368, !dbg !138
  %arrayidx413.2.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.2.7, !dbg !139
  %115 = load half, ptr addrspace(3) %arrayidx413.2.7, align 2, !dbg !140, !tbaa !141
  %vb.sroa.37.60.vec.insert = insertelement <4 x half> %vb.sroa.37.58.vec.insert, half %115, i64 2, !dbg !140
  %add408.3.7 = or disjoint i32 %84, %and410, !dbg !138
  %add411.3.7 = or i32 %add408.3.7, 496, !dbg !138
  %arrayidx413.3.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.3.7, !dbg !139
  %116 = load half, ptr addrspace(3) %arrayidx413.3.7, align 2, !dbg !140, !tbaa !141
  %vb.sroa.37.62.vec.insert = insertelement <4 x half> %vb.sroa.37.60.vec.insert, half %116, i64 3, !dbg !140
  %117 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !142
  %118 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !142
  %119 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !142
  %120 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !142
  %121 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.38.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !142
  %122 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.27.46.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !142
  %123 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.54.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !142
  %124 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.37.62.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !142
  br label %if.end442, !dbg !143

if.end442:                                        ; preds = %if.end372.if.end442_crit_edge, %for.cond394.preheader
  %and482.pre-phi = phi i32 [ %.pre926, %if.end372.if.end442_crit_edge ], [ %and410, %for.cond394.preheader ]
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end372.if.end442_crit_edge ], [ %117, %for.cond394.preheader ], !dbg !112
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end372.if.end442_crit_edge ], [ %118, %for.cond394.preheader ], !dbg !112
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end372.if.end442_crit_edge ], [ %119, %for.cond394.preheader ], !dbg !112
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end372.if.end442_crit_edge ], [ %120, %for.cond394.preheader ], !dbg !112
  %acc_o.sroa.58.0 = phi <4 x float> [ zeroinitializer, %if.end372.if.end442_crit_edge ], [ %121, %for.cond394.preheader ], !dbg !112
  %acc_o.sroa.72.0 = phi <4 x float> [ zeroinitializer, %if.end372.if.end442_crit_edge ], [ %122, %for.cond394.preheader ], !dbg !112
  %acc_o.sroa.86.0 = phi <4 x float> [ zeroinitializer, %if.end372.if.end442_crit_edge ], [ %123, %for.cond394.preheader ], !dbg !112
  %acc_o.sroa.100.0 = phi <4 x float> [ zeroinitializer, %if.end372.if.end442_crit_edge ], [ %124, %for.cond394.preheader ], !dbg !112
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0, !dbg !144
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract), !dbg !145
  %O_reg.sroa.0.0.insert.ext = zext i16 %125 to i64, !dbg !149
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1, !dbg !144
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract), !dbg !145
  %O_reg.sroa.0.2.insert.ext = zext i16 %126 to i64, !dbg !149
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !149
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !149
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2, !dbg !144
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract), !dbg !145
  %O_reg.sroa.0.4.insert.ext = zext i16 %127 to i64, !dbg !149
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !149
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !149
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3, !dbg !144
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract), !dbg !145
  %O_reg.sroa.0.6.insert.ext = zext i16 %128 to i64, !dbg !149
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !149
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !149
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0, !dbg !144
  %129 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract), !dbg !145
  %O_reg.sroa.7.8.insert.ext = zext i16 %129 to i64, !dbg !149
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1, !dbg !144
  %130 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract), !dbg !145
  %O_reg.sroa.7.10.insert.ext = zext i16 %130 to i64, !dbg !149
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !149
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !149
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2, !dbg !144
  %131 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract), !dbg !145
  %O_reg.sroa.7.12.insert.ext = zext i16 %131 to i64, !dbg !149
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !149
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !149
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3, !dbg !144
  %132 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract), !dbg !145
  %O_reg.sroa.7.14.insert.ext = zext i16 %132 to i64, !dbg !149
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !149
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !149
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0, !dbg !144
  %133 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract), !dbg !145
  %O_reg.sroa.12.16.insert.ext = zext i16 %133 to i64, !dbg !149
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1, !dbg !144
  %134 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract), !dbg !145
  %O_reg.sroa.12.18.insert.ext = zext i16 %134 to i64, !dbg !149
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !149
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !149
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2, !dbg !144
  %135 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract), !dbg !145
  %O_reg.sroa.12.20.insert.ext = zext i16 %135 to i64, !dbg !149
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !149
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !149
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3, !dbg !144
  %136 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract), !dbg !145
  %O_reg.sroa.12.22.insert.ext = zext i16 %136 to i64, !dbg !149
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !149
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !149
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0, !dbg !144
  %137 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract), !dbg !145
  %O_reg.sroa.17.24.insert.ext = zext i16 %137 to i64, !dbg !149
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1, !dbg !144
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract), !dbg !145
  %O_reg.sroa.17.26.insert.ext = zext i16 %138 to i64, !dbg !149
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !149
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !149
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2, !dbg !144
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract), !dbg !145
  %O_reg.sroa.17.28.insert.ext = zext i16 %139 to i64, !dbg !149
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !149
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !149
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3, !dbg !144
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract), !dbg !145
  %O_reg.sroa.17.30.insert.ext = zext i16 %140 to i64, !dbg !149
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !149
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !149
  %acc_o.sroa.58.64.vec.extract = extractelement <4 x float> %acc_o.sroa.58.0, i64 0, !dbg !144
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.58.64.vec.extract), !dbg !145
  %O_reg.sroa.22.32.insert.ext = zext i16 %141 to i64, !dbg !149
  %acc_o.sroa.58.68.vec.extract = extractelement <4 x float> %acc_o.sroa.58.0, i64 1, !dbg !144
  %142 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.58.68.vec.extract), !dbg !145
  %O_reg.sroa.22.34.insert.ext = zext i16 %142 to i64, !dbg !149
  %O_reg.sroa.22.34.insert.shift = shl nuw nsw i64 %O_reg.sroa.22.34.insert.ext, 16, !dbg !149
  %O_reg.sroa.22.34.insert.insert = or disjoint i64 %O_reg.sroa.22.34.insert.shift, %O_reg.sroa.22.32.insert.ext, !dbg !149
  %acc_o.sroa.58.72.vec.extract = extractelement <4 x float> %acc_o.sroa.58.0, i64 2, !dbg !144
  %143 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.58.72.vec.extract), !dbg !145
  %O_reg.sroa.22.36.insert.ext = zext i16 %143 to i64, !dbg !149
  %O_reg.sroa.22.36.insert.shift = shl nuw nsw i64 %O_reg.sroa.22.36.insert.ext, 32, !dbg !149
  %O_reg.sroa.22.36.insert.insert = or disjoint i64 %O_reg.sroa.22.34.insert.insert, %O_reg.sroa.22.36.insert.shift, !dbg !149
  %acc_o.sroa.58.76.vec.extract = extractelement <4 x float> %acc_o.sroa.58.0, i64 3, !dbg !144
  %144 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.58.76.vec.extract), !dbg !145
  %O_reg.sroa.22.38.insert.ext = zext i16 %144 to i64, !dbg !149
  %O_reg.sroa.22.38.insert.shift = shl nuw i64 %O_reg.sroa.22.38.insert.ext, 48, !dbg !149
  %O_reg.sroa.22.38.insert.insert = or disjoint i64 %O_reg.sroa.22.36.insert.insert, %O_reg.sroa.22.38.insert.shift, !dbg !149
  %acc_o.sroa.72.80.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 0, !dbg !144
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.80.vec.extract), !dbg !145
  %O_reg.sroa.27.40.insert.ext = zext i16 %145 to i64, !dbg !149
  %acc_o.sroa.72.84.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 1, !dbg !144
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.84.vec.extract), !dbg !145
  %O_reg.sroa.27.42.insert.ext = zext i16 %146 to i64, !dbg !149
  %O_reg.sroa.27.42.insert.shift = shl nuw nsw i64 %O_reg.sroa.27.42.insert.ext, 16, !dbg !149
  %O_reg.sroa.27.42.insert.insert = or disjoint i64 %O_reg.sroa.27.42.insert.shift, %O_reg.sroa.27.40.insert.ext, !dbg !149
  %acc_o.sroa.72.88.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 2, !dbg !144
  %147 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.88.vec.extract), !dbg !145
  %O_reg.sroa.27.44.insert.ext = zext i16 %147 to i64, !dbg !149
  %O_reg.sroa.27.44.insert.shift = shl nuw nsw i64 %O_reg.sroa.27.44.insert.ext, 32, !dbg !149
  %O_reg.sroa.27.44.insert.insert = or disjoint i64 %O_reg.sroa.27.42.insert.insert, %O_reg.sroa.27.44.insert.shift, !dbg !149
  %acc_o.sroa.72.92.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 3, !dbg !144
  %148 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.92.vec.extract), !dbg !145
  %O_reg.sroa.27.46.insert.ext = zext i16 %148 to i64, !dbg !149
  %O_reg.sroa.27.46.insert.shift = shl nuw i64 %O_reg.sroa.27.46.insert.ext, 48, !dbg !149
  %O_reg.sroa.27.46.insert.insert = or disjoint i64 %O_reg.sroa.27.44.insert.insert, %O_reg.sroa.27.46.insert.shift, !dbg !149
  %acc_o.sroa.86.96.vec.extract = extractelement <4 x float> %acc_o.sroa.86.0, i64 0, !dbg !144
  %149 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.86.96.vec.extract), !dbg !145
  %O_reg.sroa.32.48.insert.ext = zext i16 %149 to i64, !dbg !149
  %acc_o.sroa.86.100.vec.extract = extractelement <4 x float> %acc_o.sroa.86.0, i64 1, !dbg !144
  %150 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.86.100.vec.extract), !dbg !145
  %O_reg.sroa.32.50.insert.ext = zext i16 %150 to i64, !dbg !149
  %O_reg.sroa.32.50.insert.shift = shl nuw nsw i64 %O_reg.sroa.32.50.insert.ext, 16, !dbg !149
  %O_reg.sroa.32.50.insert.insert = or disjoint i64 %O_reg.sroa.32.50.insert.shift, %O_reg.sroa.32.48.insert.ext, !dbg !149
  %acc_o.sroa.86.104.vec.extract = extractelement <4 x float> %acc_o.sroa.86.0, i64 2, !dbg !144
  %151 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.86.104.vec.extract), !dbg !145
  %O_reg.sroa.32.52.insert.ext = zext i16 %151 to i64, !dbg !149
  %O_reg.sroa.32.52.insert.shift = shl nuw nsw i64 %O_reg.sroa.32.52.insert.ext, 32, !dbg !149
  %O_reg.sroa.32.52.insert.insert = or disjoint i64 %O_reg.sroa.32.50.insert.insert, %O_reg.sroa.32.52.insert.shift, !dbg !149
  %acc_o.sroa.86.108.vec.extract = extractelement <4 x float> %acc_o.sroa.86.0, i64 3, !dbg !144
  %152 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.86.108.vec.extract), !dbg !145
  %O_reg.sroa.32.54.insert.ext = zext i16 %152 to i64, !dbg !149
  %O_reg.sroa.32.54.insert.shift = shl nuw i64 %O_reg.sroa.32.54.insert.ext, 48, !dbg !149
  %O_reg.sroa.32.54.insert.insert = or disjoint i64 %O_reg.sroa.32.52.insert.insert, %O_reg.sroa.32.54.insert.shift, !dbg !149
  %acc_o.sroa.100.112.vec.extract = extractelement <4 x float> %acc_o.sroa.100.0, i64 0, !dbg !144
  %153 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.100.112.vec.extract), !dbg !145
  %O_reg.sroa.37.56.insert.ext = zext i16 %153 to i64, !dbg !149
  %acc_o.sroa.100.116.vec.extract = extractelement <4 x float> %acc_o.sroa.100.0, i64 1, !dbg !144
  %154 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.100.116.vec.extract), !dbg !145
  %O_reg.sroa.37.58.insert.ext = zext i16 %154 to i64, !dbg !149
  %O_reg.sroa.37.58.insert.shift = shl nuw nsw i64 %O_reg.sroa.37.58.insert.ext, 16, !dbg !149
  %O_reg.sroa.37.58.insert.insert = or disjoint i64 %O_reg.sroa.37.58.insert.shift, %O_reg.sroa.37.56.insert.ext, !dbg !149
  %acc_o.sroa.100.120.vec.extract = extractelement <4 x float> %acc_o.sroa.100.0, i64 2, !dbg !144
  %155 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.100.120.vec.extract), !dbg !145
  %O_reg.sroa.37.60.insert.ext = zext i16 %155 to i64, !dbg !149
  %O_reg.sroa.37.60.insert.shift = shl nuw nsw i64 %O_reg.sroa.37.60.insert.ext, 32, !dbg !149
  %O_reg.sroa.37.60.insert.insert = or disjoint i64 %O_reg.sroa.37.58.insert.insert, %O_reg.sroa.37.60.insert.shift, !dbg !149
  %acc_o.sroa.100.124.vec.extract = extractelement <4 x float> %acc_o.sroa.100.0, i64 3, !dbg !144
  %156 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.100.124.vec.extract), !dbg !145
  %O_reg.sroa.37.62.insert.ext = zext i16 %156 to i64, !dbg !149
  %O_reg.sroa.37.62.insert.shift = shl nuw i64 %O_reg.sroa.37.62.insert.ext, 48, !dbg !149
  %O_reg.sroa.37.62.insert.insert = or disjoint i64 %O_reg.sroa.37.60.insert.insert, %O_reg.sroa.37.62.insert.shift, !dbg !149
  fence syncscope("warp") release, !dbg !150
  tail call void @llvm.mxc.barrier.warp(), !dbg !153
  fence syncscope("warp") acquire, !dbg !154
  %and475 = shl nuw nsw i32 %3, 7
  %mul476 = and i32 %and475, 1920
  %shr479 = lshr i32 %3, 5
  %157 = lshr i32 %3, 2
  %mul489 = and i32 %157, 4
  %xor483 = xor i32 %shr479, %and482.pre-phi, !dbg !155
  %mul484 = shl nuw nsw i32 %xor483, 3, !dbg !156
  %add485 = add nuw nsw i32 %mul484, %mul476, !dbg !157
  %add490 = or disjoint i32 %add485, %mul489, !dbg !158
  %add.ptr492 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add490, !dbg !159
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr492, align 8, !dbg !160
  %add480.1 = add nuw nsw i32 %shr479, 2, !dbg !161
  %xor483.1 = xor i32 %add480.1, %and482.pre-phi, !dbg !155
  %mul484.1 = shl nuw nsw i32 %xor483.1, 3, !dbg !156
  %add485.1 = add nuw nsw i32 %mul484.1, %mul476, !dbg !157
  %add490.1 = or disjoint i32 %add485.1, %mul489, !dbg !158
  %add.ptr492.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add490.1, !dbg !159
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr492.1, align 8, !dbg !160
  %add480.2 = add nuw nsw i32 %shr479, 4, !dbg !161
  %xor483.2 = xor i32 %add480.2, %and482.pre-phi, !dbg !155
  %mul484.2 = shl nuw nsw i32 %xor483.2, 3, !dbg !156
  %add485.2 = add nuw nsw i32 %mul484.2, %mul476, !dbg !157
  %add490.2 = or disjoint i32 %add485.2, %mul489, !dbg !158
  %add.ptr492.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add490.2, !dbg !159
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr492.2, align 8, !dbg !160
  %add480.3 = add nuw nsw i32 %shr479, 6, !dbg !161
  %xor483.3 = xor i32 %add480.3, %and482.pre-phi, !dbg !155
  %mul484.3 = shl nuw nsw i32 %xor483.3, 3, !dbg !156
  %add485.3 = add nuw nsw i32 %mul484.3, %mul476, !dbg !157
  %add490.3 = or disjoint i32 %add485.3, %mul489, !dbg !158
  %add.ptr492.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add490.3, !dbg !159
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr492.3, align 8, !dbg !160
  %add480.4 = add nuw nsw i32 %shr479, 8, !dbg !161
  %xor483.4 = xor i32 %add480.4, %and482.pre-phi, !dbg !155
  %mul484.4 = shl nuw nsw i32 %xor483.4, 3, !dbg !156
  %add485.4 = add nuw nsw i32 %mul484.4, %mul476, !dbg !157
  %add490.4 = or disjoint i32 %add485.4, %mul489, !dbg !158
  %add.ptr492.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add490.4, !dbg !159
  store i64 %O_reg.sroa.22.38.insert.insert, ptr addrspace(3) %add.ptr492.4, align 8, !dbg !160
  %add480.5 = add nuw nsw i32 %shr479, 10, !dbg !161
  %xor483.5 = xor i32 %add480.5, %and482.pre-phi, !dbg !155
  %mul484.5 = shl nuw nsw i32 %xor483.5, 3, !dbg !156
  %add485.5 = add nuw nsw i32 %mul484.5, %mul476, !dbg !157
  %add490.5 = or disjoint i32 %add485.5, %mul489, !dbg !158
  %add.ptr492.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add490.5, !dbg !159
  store i64 %O_reg.sroa.27.46.insert.insert, ptr addrspace(3) %add.ptr492.5, align 8, !dbg !160
  %add480.6 = add nuw nsw i32 %shr479, 12, !dbg !161
  %xor483.6 = xor i32 %add480.6, %and482.pre-phi, !dbg !155
  %mul484.6 = shl nuw nsw i32 %xor483.6, 3, !dbg !156
  %add485.6 = add nuw nsw i32 %mul484.6, %mul476, !dbg !157
  %add490.6 = or disjoint i32 %add485.6, %mul489, !dbg !158
  %add.ptr492.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add490.6, !dbg !159
  store i64 %O_reg.sroa.32.54.insert.insert, ptr addrspace(3) %add.ptr492.6, align 8, !dbg !160
  %add480.7 = add nuw nsw i32 %shr479, 14, !dbg !161
  %xor483.7 = xor i32 %add480.7, %and482.pre-phi, !dbg !155
  %mul484.7 = shl nuw nsw i32 %xor483.7, 3, !dbg !156
  %add485.7 = add nuw nsw i32 %mul484.7, %mul476, !dbg !157
  %add490.7 = or disjoint i32 %add485.7, %mul489, !dbg !158
  %add.ptr492.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add490.7, !dbg !159
  store i64 %O_reg.sroa.37.62.insert.insert, ptr addrspace(3) %add.ptr492.7, align 8, !dbg !160
  fence syncscope("warp") release, !dbg !162
  tail call void @llvm.mxc.barrier.warp(), !dbg !165
  fence syncscope("warp") acquire, !dbg !166
  %mul503 = and i32 %mul14, 8064
  %shr509 = lshr i32 %3, 4
  %invariant.gep674 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul503, !dbg !167
  %xor511 = xor i32 %shr509, %and482.pre-phi, !dbg !168
  %add.ptr515.idx = shl nuw nsw i32 %xor511, 4, !dbg !169
  %add.ptr515 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep674, i32 %add.ptr515.idx, !dbg !169
  %add.ptr532 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4, !dbg !170
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr532, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr515, i64 16, i1 false), !dbg !171, !tbaa.struct !172, !call_argsrelate !173
  %158 = add nuw nsw i32 %shr509, 4, !dbg !174
  %xor511.1 = xor i32 %158, %and482.pre-phi, !dbg !168
  %gep675.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep674, i32 1024, !dbg !169
  %add.ptr515.idx.1 = shl nuw nsw i32 %xor511.1, 4, !dbg !169
  %add.ptr515.1 = getelementptr inbounds i8, ptr addrspace(3) %gep675.1, i32 %add.ptr515.idx.1, !dbg !169
  %add.ptr532.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %5, !dbg !170
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr532.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr515.1, i64 16, i1 false), !dbg !171, !tbaa.struct !172, !call_argsrelate !173
  %159 = add nuw nsw i32 %shr509, 8, !dbg !174
  %xor511.2 = xor i32 %159, %and482.pre-phi, !dbg !168
  %gep675.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep674, i32 2048, !dbg !169
  %add.ptr515.idx.2 = shl nuw nsw i32 %xor511.2, 4, !dbg !169
  %add.ptr515.2 = getelementptr inbounds i8, ptr addrspace(3) %gep675.2, i32 %add.ptr515.idx.2, !dbg !169
  %add.ptr532.2 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %6, !dbg !170
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr532.2, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr515.2, i64 16, i1 false), !dbg !171, !tbaa.struct !172, !call_argsrelate !173
  %narrow = add nuw nsw i32 %shr509, 12, !dbg !174
  %xor511.3 = xor i32 %narrow, %and482.pre-phi, !dbg !168
  %gep675.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep674, i32 3072, !dbg !169
  %add.ptr515.idx.3 = shl nuw nsw i32 %xor511.3, 4, !dbg !169
  %add.ptr515.3 = getelementptr inbounds i8, ptr addrspace(3) %gep675.3, i32 %add.ptr515.idx.3, !dbg !169
  %add.ptr532.3 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %7, !dbg !170
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr532.3, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr515.3, i64 16, i1 false), !dbg !171, !tbaa.struct !172, !call_argsrelate !173
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

; Function Attrs: convergent nounwind willreturn
declare void @llvm.mxc.barrier.warp() #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp.f32(float) #7

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare i16 @llvm.convert.to.fp16.f32(float) #8

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i1 @llvm.mxc.is.private(ptr nocapture) #5

; Function Attrs: nounwind willreturn
declare void @llvm.mxc.sleep(i32 immarg) #9

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.minnum.f32(float, float) #7

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #10

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noalias nocapture writeonly, ptr addrspace(4) noalias nocapture readonly, i64, i1 immarg) #10

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { convergent nounwind willreturn }
attributes #7 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #8 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #9 = { nounwind willreturn }
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmpzjovluzr/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpzjovluzr/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 28, column: 3, scope: !40)
!44 = !DILocation(line: 29, column: 168, scope: !40)
!45 = !DILocation(line: 31, column: 65, scope: !40)
!46 = !DILocation(line: 31, column: 93, scope: !40)
!47 = !DILocation(line: 31, column: 72, scope: !40)
!48 = !DILocation(line: 31, column: 99, scope: !40)
!49 = !DILocation(line: 31, column: 25, scope: !40)
!50 = !DILocation(line: 37, column: 31, scope: !40)
!51 = !DILocation(line: 29, column: 48, scope: !40)
!52 = !DILocation(line: 40, column: 5, scope: !40)
!53 = !DILocation(line: 43, column: 79, scope: !40)
!54 = !DILocation(line: 43, column: 58, scope: !40)
!55 = !DILocation(line: 43, column: 275, scope: !40)
!56 = !DILocation(line: 50, column: 79, scope: !40)
!57 = !DILocation(line: 50, column: 58, scope: !40)
!58 = !DILocation(line: 54, column: 5, scope: !40)
!59 = !DILocation(line: 55, column: 125, scope: !40)
!60 = !DILocation(line: 55, column: 42, scope: !40)
!61 = !DILocation(line: 55, column: 175, scope: !40)
!62 = !{i32 1, i32 3, i32 -1, i32 -1}
!63 = !DILocation(line: 55, column: 138, scope: !40)
!64 = !DILocation(line: 68, column: 3, scope: !65, inlinedAt: !67)
!65 = distinct !DISubprogram(name: "__barrier_warp", scope: !66, file: !66, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!66 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!67 = distinct !DILocation(line: 192, column: 3, scope: !68, inlinedAt: !69)
!68 = distinct !DISubprogram(name: "__syncwarp", scope: !66, file: !66, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!69 = distinct !DILocation(line: 57, column: 5, scope: !40)
!70 = !DILocation(line: 69, column: 3, scope: !65, inlinedAt: !67)
!71 = !DILocation(line: 70, column: 3, scope: !65, inlinedAt: !67)
!72 = !DILocation(line: 60, column: 73, scope: !40)
!73 = !DILocation(line: 60, column: 36, scope: !40)
!74 = !DILocation(line: 68, column: 3, scope: !65, inlinedAt: !75)
!75 = distinct !DILocation(line: 192, column: 3, scope: !68, inlinedAt: !76)
!76 = distinct !DILocation(line: 62, column: 5, scope: !40)
!77 = !DILocation(line: 69, column: 3, scope: !65, inlinedAt: !75)
!78 = !DILocation(line: 70, column: 3, scope: !65, inlinedAt: !75)
!79 = !DILocation(line: 65, column: 175, scope: !40)
!80 = !DILocation(line: 68, column: 3, scope: !65, inlinedAt: !81)
!81 = distinct !DILocation(line: 192, column: 3, scope: !68, inlinedAt: !82)
!82 = distinct !DILocation(line: 69, column: 5, scope: !40)
!83 = !DILocation(line: 69, column: 3, scope: !65, inlinedAt: !81)
!84 = !DILocation(line: 70, column: 3, scope: !65, inlinedAt: !81)
!85 = !DILocation(line: 71, column: 25, scope: !40)
!86 = !DILocation(line: 74, column: 36, scope: !40)
!87 = !DILocation(line: 68, column: 3, scope: !65, inlinedAt: !88)
!88 = distinct !DILocation(line: 192, column: 3, scope: !68, inlinedAt: !89)
!89 = distinct !DILocation(line: 80, column: 5, scope: !40)
!90 = !DILocation(line: 69, column: 3, scope: !65, inlinedAt: !88)
!91 = !DILocation(line: 70, column: 3, scope: !65, inlinedAt: !88)
!92 = !DILocation(line: 82, column: 10, scope: !40)
!93 = !DILocation(line: 83, column: 86, scope: !40)
!94 = !DILocation(line: 83, column: 42, scope: !40)
!95 = !DILocation(line: 87, column: 30, scope: !40)
!96 = !DILocation(line: 87, column: 41, scope: !40)
!97 = !DILocation(line: 354, column: 10, scope: !98, inlinedAt: !100)
!98 = distinct !DISubprogram(name: "min", scope: !99, file: !99, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!99 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!100 = distinct !DILocation(line: 87, column: 25, scope: !40)
!101 = !DILocation(line: 288, column: 10, scope: !102, inlinedAt: !103)
!102 = distinct !DISubprogram(name: "expf", scope: !99, file: !99, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!103 = distinct !DILocation(line: 87, column: 20, scope: !40)
!104 = !DILocation(line: 87, column: 18, scope: !40)
!105 = !DILocation(line: 89, column: 25, scope: !40)
!106 = !DILocation(line: 89, column: 9, scope: !40)
!107 = !DILocation(line: 93, column: 54, scope: !40)
!108 = !DILocation(line: 93, column: 13, scope: !40)
!109 = !DILocation(line: 98, column: 20, scope: !40)
!110 = !DILocation(line: 93, column: 47, scope: !40)
!111 = !DILocation(line: 103, column: 5, scope: !40)
!112 = !DILocation(line: 0, scope: !40)
!113 = !DILocation(line: 104, column: 36, scope: !40)
!114 = !DILocation(line: 104, column: 34, scope: !40)
!115 = !DILocation(line: 109, column: 42, scope: !40)
!116 = !DILocation(line: 114, column: 36, scope: !40)
!117 = !DILocation(line: 114, column: 34, scope: !40)
!118 = !DILocation(line: 114, column: 9, scope: !40)
!119 = !DILocation(line: 122, column: 32, scope: !40)
!120 = !DILocation(line: 122, column: 21, scope: !40)
!121 = !DILocation(line: 75, column: 10, scope: !122, inlinedAt: !124)
!122 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !123, file: !123, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!123 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!124 = distinct !DILocation(line: 984, column: 9, scope: !125, inlinedAt: !127)
!125 = distinct !DISubprogram(name: "__float2half", scope: !126, file: !126, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!126 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!127 = distinct !DILocation(line: 133, column: 53, scope: !128, inlinedAt: !129)
!128 = distinct !DISubprogram(name: "__half", scope: !126, file: !126, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!129 = distinct !DILocation(line: 126, column: 32, scope: !40)
!130 = !DILocation(line: 126, column: 29, scope: !40)
!131 = !DILocation(line: 68, column: 3, scope: !65, inlinedAt: !132)
!132 = distinct !DILocation(line: 192, column: 3, scope: !68, inlinedAt: !133)
!133 = distinct !DILocation(line: 128, column: 5, scope: !40)
!134 = !DILocation(line: 69, column: 3, scope: !65, inlinedAt: !132)
!135 = !DILocation(line: 70, column: 3, scope: !65, inlinedAt: !132)
!136 = !DILocation(line: 129, column: 3, scope: !40)
!137 = !DILocation(line: 135, column: 31, scope: !40)
!138 = !DILocation(line: 138, column: 120, scope: !40)
!139 = !DILocation(line: 138, column: 31, scope: !40)
!140 = !DILocation(line: 138, column: 29, scope: !40)
!141 = !{!26, !26, i64 0}
!142 = !DILocation(line: 143, column: 38, scope: !40)
!143 = !DILocation(line: 150, column: 3, scope: !40)
!144 = !DILocation(line: 153, column: 58, scope: !40)
!145 = !DILocation(line: 75, column: 10, scope: !122, inlinedAt: !146)
!146 = distinct !DILocation(line: 984, column: 9, scope: !125, inlinedAt: !147)
!147 = distinct !DILocation(line: 133, column: 53, scope: !128, inlinedAt: !148)
!148 = distinct !DILocation(line: 153, column: 50, scope: !40)
!149 = !DILocation(line: 153, column: 47, scope: !40)
!150 = !DILocation(line: 68, column: 3, scope: !65, inlinedAt: !151)
!151 = distinct !DILocation(line: 192, column: 3, scope: !68, inlinedAt: !152)
!152 = distinct !DILocation(line: 156, column: 3, scope: !40)
!153 = !DILocation(line: 69, column: 3, scope: !65, inlinedAt: !151)
!154 = !DILocation(line: 70, column: 3, scope: !65, inlinedAt: !151)
!155 = !DILocation(line: 159, column: 123, scope: !40)
!156 = !DILocation(line: 159, column: 152, scope: !40)
!157 = !DILocation(line: 159, column: 78, scope: !40)
!158 = !DILocation(line: 159, column: 158, scope: !40)
!159 = !DILocation(line: 159, column: 40, scope: !40)
!160 = !DILocation(line: 159, column: 201, scope: !40)
!161 = !DILocation(line: 159, column: 94, scope: !40)
!162 = !DILocation(line: 68, column: 3, scope: !65, inlinedAt: !163)
!163 = distinct !DILocation(line: 192, column: 3, scope: !68, inlinedAt: !164)
!164 = distinct !DILocation(line: 161, column: 3, scope: !40)
!165 = !DILocation(line: 69, column: 3, scope: !65, inlinedAt: !163)
!166 = !DILocation(line: 70, column: 3, scope: !65, inlinedAt: !163)
!167 = !DILocation(line: 163, column: 8, scope: !40)
!168 = !DILocation(line: 164, column: 295, scope: !40)
!169 = !DILocation(line: 164, column: 211, scope: !40)
!170 = !DILocation(line: 164, column: 22, scope: !40)
!171 = !DILocation(line: 164, column: 174, scope: !40)
!172 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!173 = !{i32 2, i32 -1, i32 -1, i32 -1}
!174 = !DILocation(line: 164, column: 309, scope: !40)
!175 = !DILocation(line: 166, column: 1, scope: !40)
