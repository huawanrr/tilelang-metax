; ModuleID = '/data/tilelang-metax/race_tests/nsa/experiments/20261016_goal895/validation_dispatch_r1/actual_binary/d128_b16_h1_t16_c1_m1_p0.bc'
source_filename = "/tmp/tmpn4t2p7mv/tvm_kernels.maca"
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
  %mul = shl nsw i32 %0, 15
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul7 = shl nsw i32 %1, 11
  %add = add nuw nsw i32 %mul, %mul7
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %mul11 = shl nuw nsw i32 %2, 3
  %add9 = add nuw nsw i32 %add, %mul11
  %3 = zext nneg i32 %add9 to i64, !dbg !43
  %4 = add nuw nsw i64 %3, 512, !dbg !44
  %5 = add nuw nsw i64 %3, 1024, !dbg !44
  %6 = add nuw nsw i64 %3, 1536, !dbg !44
  %mul17 = shl nsw i32 %0, 4, !dbg !45
  %add19 = add nuw nsw i32 %mul17, %1, !dbg !46
  %idxprom = zext nneg i32 %add19 to i64, !dbg !47
  %arrayidx20 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom, !dbg !47
  %7 = load i32, ptr addrspace(1) %arrayidx20, align 4, !dbg !47, !tbaa !30
  %cmp35 = icmp eq i32 %7, 0
  br i1 %cmp35, label %for.cond40.preheader, label %if.end335, !dbg !48

for.cond40.preheader:                             ; preds = %entry
  %add.ptr.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %6, !dbg !49
  %add.ptr.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %5, !dbg !49
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4, !dbg !49
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !49
  %mul50 = shl nsw i32 %0, 11
  %add54 = add nuw nsw i32 %mul11, %mul50
  %8 = zext nneg i32 %add54 to i64, !dbg !50
  %add.ptr61 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %8, !dbg !51
  %9 = load i32, ptr addrspace(4) %add.ptr61, align 4, !dbg !52, !tbaa !30
  %10 = or disjoint i64 %8, 2, !dbg !53
  %add.ptr61.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %10, !dbg !51
  %11 = load i32, ptr addrspace(4) %add.ptr61.1, align 4, !dbg !52, !tbaa !30
  %12 = or disjoint i64 %8, 4, !dbg !53
  %add.ptr61.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %12, !dbg !51
  %13 = load i32, ptr addrspace(4) %add.ptr61.2, align 4, !dbg !52, !tbaa !30
  %14 = or disjoint i64 %8, 6, !dbg !53
  %add.ptr61.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %14, !dbg !51
  %15 = load i32, ptr addrspace(4) %add.ptr61.3, align 4, !dbg !52, !tbaa !30
  %16 = add nuw nsw i64 %8, 512
  %add.ptr61.1647 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %16, !dbg !51
  %17 = load i32, ptr addrspace(4) %add.ptr61.1647, align 4, !dbg !52, !tbaa !30
  %18 = add nuw nsw i64 %8, 514, !dbg !53
  %add.ptr61.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %18, !dbg !51
  %19 = load i32, ptr addrspace(4) %add.ptr61.1.1, align 4, !dbg !52, !tbaa !30
  %20 = add nuw nsw i64 %8, 516, !dbg !53
  %add.ptr61.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %20, !dbg !51
  %21 = load i32, ptr addrspace(4) %add.ptr61.2.1, align 4, !dbg !52, !tbaa !30
  %22 = add nuw nsw i64 %8, 518, !dbg !53
  %add.ptr61.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %22, !dbg !51
  %23 = load i32, ptr addrspace(4) %add.ptr61.3.1, align 4, !dbg !52, !tbaa !30
  %24 = add nuw nsw i64 %8, 1024
  %add.ptr61.2649 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %24, !dbg !51
  %25 = load i32, ptr addrspace(4) %add.ptr61.2649, align 4, !dbg !52, !tbaa !30
  %26 = add nuw nsw i64 %8, 1026, !dbg !53
  %add.ptr61.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %26, !dbg !51
  %27 = load i32, ptr addrspace(4) %add.ptr61.1.2, align 4, !dbg !52, !tbaa !30
  %28 = add nuw nsw i64 %8, 1028, !dbg !53
  %add.ptr61.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %28, !dbg !51
  %29 = load i32, ptr addrspace(4) %add.ptr61.2.2, align 4, !dbg !52, !tbaa !30
  %30 = add nuw nsw i64 %8, 1030, !dbg !53
  %add.ptr61.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %30, !dbg !51
  %31 = load i32, ptr addrspace(4) %add.ptr61.3.2, align 4, !dbg !52, !tbaa !30
  %32 = add nuw nsw i64 %8, 1536
  %add.ptr61.3651 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %32, !dbg !51
  %33 = load i32, ptr addrspace(4) %add.ptr61.3651, align 4, !dbg !52, !tbaa !30
  %34 = add nuw nsw i64 %8, 1538, !dbg !53
  %add.ptr61.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %34, !dbg !51
  %35 = load i32, ptr addrspace(4) %add.ptr61.1.3, align 4, !dbg !52, !tbaa !30
  %36 = add nuw nsw i64 %8, 1540, !dbg !53
  %add.ptr61.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %36, !dbg !51
  %37 = load i32, ptr addrspace(4) %add.ptr61.2.3, align 4, !dbg !52, !tbaa !30
  %38 = add nuw nsw i64 %8, 1542, !dbg !53
  %add.ptr61.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %38, !dbg !51
  %39 = load i32, ptr addrspace(4) %add.ptr61.3.3, align 4, !dbg !52, !tbaa !30
  %add.ptr94 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %8, !dbg !54
  %40 = load i32, ptr addrspace(4) %add.ptr94, align 4, !dbg !55, !tbaa !30
  %add.ptr94.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %10, !dbg !54
  %41 = load i32, ptr addrspace(4) %add.ptr94.1, align 4, !dbg !55, !tbaa !30
  %add.ptr94.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %12, !dbg !54
  %42 = load i32, ptr addrspace(4) %add.ptr94.2, align 4, !dbg !55, !tbaa !30
  %add.ptr94.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %14, !dbg !54
  %43 = load i32, ptr addrspace(4) %add.ptr94.3, align 4, !dbg !55, !tbaa !30
  %add.ptr94.1663 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %16, !dbg !54
  %44 = load i32, ptr addrspace(4) %add.ptr94.1663, align 4, !dbg !55, !tbaa !30
  %add.ptr94.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %18, !dbg !54
  %45 = load i32, ptr addrspace(4) %add.ptr94.1.1, align 4, !dbg !55, !tbaa !30
  %add.ptr94.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %20, !dbg !54
  %46 = load i32, ptr addrspace(4) %add.ptr94.2.1, align 4, !dbg !55, !tbaa !30
  %add.ptr94.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %22, !dbg !54
  %47 = load i32, ptr addrspace(4) %add.ptr94.3.1, align 4, !dbg !55, !tbaa !30
  %add.ptr94.2665 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %24, !dbg !54
  %48 = load i32, ptr addrspace(4) %add.ptr94.2665, align 4, !dbg !55, !tbaa !30
  %add.ptr94.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %26, !dbg !54
  %49 = load i32, ptr addrspace(4) %add.ptr94.1.2, align 4, !dbg !55, !tbaa !30
  %add.ptr94.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %28, !dbg !54
  %50 = load i32, ptr addrspace(4) %add.ptr94.2.2, align 4, !dbg !55, !tbaa !30
  %add.ptr94.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %30, !dbg !54
  %51 = load i32, ptr addrspace(4) %add.ptr94.3.2, align 4, !dbg !55, !tbaa !30
  %add.ptr94.3667 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %32, !dbg !54
  %52 = load i32, ptr addrspace(4) %add.ptr94.3667, align 4, !dbg !55, !tbaa !30
  %add.ptr94.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %34, !dbg !54
  %53 = load i32, ptr addrspace(4) %add.ptr94.1.3, align 4, !dbg !55, !tbaa !30
  %add.ptr94.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %36, !dbg !54
  %54 = load i32, ptr addrspace(4) %add.ptr94.2.3, align 4, !dbg !55, !tbaa !30
  %add.ptr94.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %38, !dbg !54
  %55 = load i32, ptr addrspace(4) %add.ptr94.3.3, align 4, !dbg !55, !tbaa !30
  %mul117 = and i32 %mul11, 8064
  %and = and i32 %2, 15
  %shr122 = lshr i32 %2, 4
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul117, !dbg !56
  %xor = xor i32 %shr122, %and, !dbg !57
  %add.ptr127.idx = shl nuw nsw i32 %xor, 4, !dbg !58
  %add.ptr127 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 %add.ptr127.idx, !dbg !58
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr127, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !dbg !59, !call_argsrelate !60
  %add123.1 = add nuw nsw i32 %shr122, 4, !dbg !61
  %xor.1 = xor i32 %add123.1, %and, !dbg !57
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1024, !dbg !58
  %add.ptr127.idx.1 = shl nuw nsw i32 %xor.1, 4, !dbg !58
  %add.ptr127.1 = getelementptr inbounds i8, ptr addrspace(3) %gep.1, i32 %add.ptr127.idx.1, !dbg !58
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr127.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !dbg !59, !call_argsrelate !60
  %add123.2 = add nuw nsw i32 %shr122, 8, !dbg !61
  %xor.2 = xor i32 %add123.2, %and, !dbg !57
  %gep.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 2048, !dbg !58
  %add.ptr127.idx.2 = shl nuw nsw i32 %xor.2, 4, !dbg !58
  %add.ptr127.2 = getelementptr inbounds i8, ptr addrspace(3) %gep.2, i32 %add.ptr127.idx.2, !dbg !58
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr127.2, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.2, i64 16, i1 false), !dbg !59, !call_argsrelate !60
  %add123.3 = add nuw nsw i32 %shr122, 12, !dbg !61
  %xor.3 = xor i32 %add123.3, %and, !dbg !57
  %gep.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 3072, !dbg !58
  %add.ptr127.idx.3 = shl nuw nsw i32 %xor.3, 4, !dbg !58
  %add.ptr127.3 = getelementptr inbounds i8, ptr addrspace(3) %gep.3, i32 %add.ptr127.idx.3, !dbg !58
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr127.3, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.3, i64 16, i1 false), !dbg !59, !call_argsrelate !60
  fence syncscope("warp") release, !dbg !62
  tail call void @llvm.mxc.barrier.warp(), !dbg !68
  fence syncscope("warp") acquire, !dbg !69
  %and136 = shl nuw nsw i32 %2, 7
  %mul137 = and i32 %and136, 1920
  %56 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul137
  %add.ptr148 = getelementptr inbounds i8, ptr addrspace(3) %56, i32 %add.ptr127.idx, !dbg !70
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr148, align 16, !dbg !71
  %Q_reg.sroa.4.0.add.ptr148.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr148, i32 8, !dbg !71
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr148.sroa_idx, align 8, !dbg !71
  %add.ptr148.1 = getelementptr inbounds i8, ptr addrspace(3) %56, i32 %add.ptr127.idx.1, !dbg !70
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr148.1, align 16, !dbg !71
  %Q_reg.sroa.7.16.add.ptr148.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr148.1, i32 8, !dbg !71
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr148.1.sroa_idx, align 8, !dbg !71
  %add.ptr148.2 = getelementptr inbounds i8, ptr addrspace(3) %56, i32 %add.ptr127.idx.2, !dbg !70
  %Q_reg.sroa.8.32.copyload = load <4 x half>, ptr addrspace(3) %add.ptr148.2, align 16, !dbg !71
  %Q_reg.sroa.10.32.add.ptr148.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr148.2, i32 8, !dbg !71
  %Q_reg.sroa.10.32.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.10.32.add.ptr148.2.sroa_idx, align 8, !dbg !71
  %add.ptr148.3 = getelementptr inbounds i8, ptr addrspace(3) %56, i32 %add.ptr127.idx.3, !dbg !70
  %Q_reg.sroa.11.48.copyload = load <4 x half>, ptr addrspace(3) %add.ptr148.3, align 16, !dbg !71
  %Q_reg.sroa.13.48.add.ptr148.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr148.3, i32 8, !dbg !71
  %Q_reg.sroa.13.48.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.13.48.add.ptr148.3.sroa_idx, align 8, !dbg !71
  fence syncscope("warp") release, !dbg !72
  tail call void @llvm.mxc.barrier.warp(), !dbg !75
  fence syncscope("warp") acquire, !dbg !76
  store i32 %9, ptr addrspace(3) %add.ptr127, align 16, !dbg !77, !tbaa !30
  %K_reg.sroa.4.0.add.ptr179.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr127, i32 4, !dbg !77
  store i32 %11, ptr addrspace(3) %K_reg.sroa.4.0.add.ptr179.sroa_idx, align 4, !dbg !77, !tbaa !30
  %K_reg.sroa.5.0.add.ptr179.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr127, i32 8, !dbg !77
  store i32 %13, ptr addrspace(3) %K_reg.sroa.5.0.add.ptr179.sroa_idx, align 8, !dbg !77, !tbaa !30
  %K_reg.sroa.6.0.add.ptr179.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr127, i32 12, !dbg !77
  store i32 %15, ptr addrspace(3) %K_reg.sroa.6.0.add.ptr179.sroa_idx, align 4, !dbg !77, !tbaa !30
  store i32 %17, ptr addrspace(3) %add.ptr127.1, align 16, !dbg !77, !tbaa !30
  %K_reg.sroa.9.16.add.ptr179.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr127.1, i32 4, !dbg !77
  store i32 %19, ptr addrspace(3) %K_reg.sroa.9.16.add.ptr179.1.sroa_idx, align 4, !dbg !77, !tbaa !30
  %K_reg.sroa.10.16.add.ptr179.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr127.1, i32 8, !dbg !77
  store i32 %21, ptr addrspace(3) %K_reg.sroa.10.16.add.ptr179.1.sroa_idx, align 8, !dbg !77, !tbaa !30
  %K_reg.sroa.11.16.add.ptr179.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr127.1, i32 12, !dbg !77
  store i32 %23, ptr addrspace(3) %K_reg.sroa.11.16.add.ptr179.1.sroa_idx, align 4, !dbg !77, !tbaa !30
  store i32 %25, ptr addrspace(3) %add.ptr127.2, align 16, !dbg !77, !tbaa !30
  %K_reg.sroa.14.32.add.ptr179.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr127.2, i32 4, !dbg !77
  store i32 %27, ptr addrspace(3) %K_reg.sroa.14.32.add.ptr179.2.sroa_idx, align 4, !dbg !77, !tbaa !30
  %K_reg.sroa.15.32.add.ptr179.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr127.2, i32 8, !dbg !77
  store i32 %29, ptr addrspace(3) %K_reg.sroa.15.32.add.ptr179.2.sroa_idx, align 8, !dbg !77, !tbaa !30
  %K_reg.sroa.16.32.add.ptr179.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr127.2, i32 12, !dbg !77
  store i32 %31, ptr addrspace(3) %K_reg.sroa.16.32.add.ptr179.2.sroa_idx, align 4, !dbg !77, !tbaa !30
  store i32 %33, ptr addrspace(3) %add.ptr127.3, align 16, !dbg !77, !tbaa !30
  %K_reg.sroa.19.48.add.ptr179.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr127.3, i32 4, !dbg !77
  store i32 %35, ptr addrspace(3) %K_reg.sroa.19.48.add.ptr179.3.sroa_idx, align 4, !dbg !77, !tbaa !30
  %K_reg.sroa.20.48.add.ptr179.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr127.3, i32 8, !dbg !77
  store i32 %37, ptr addrspace(3) %K_reg.sroa.20.48.add.ptr179.3.sroa_idx, align 8, !dbg !77, !tbaa !30
  %K_reg.sroa.21.48.add.ptr179.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr127.3, i32 12, !dbg !77
  store i32 %39, ptr addrspace(3) %K_reg.sroa.21.48.add.ptr179.3.sroa_idx, align 4, !dbg !77, !tbaa !30
  fence syncscope("warp") release, !dbg !78
  tail call void @llvm.mxc.barrier.warp(), !dbg !81
  fence syncscope("warp") acquire, !dbg !82
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr148, align 16, !dbg !83
  %kb.sroa.10.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr148.sroa_idx, align 8, !dbg !83
  %57 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !84
  %58 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %57), !dbg !84
  %kb.sroa.0.0.copyload705 = load <4 x half>, ptr addrspace(3) %add.ptr148.1, align 16, !dbg !83
  %kb.sroa.10.0.copyload708 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr148.1.sroa_idx, align 8, !dbg !83
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload705, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %58), !dbg !84
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload708, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %59), !dbg !84
  %kb.sroa.0.0.copyload706 = load <4 x half>, ptr addrspace(3) %add.ptr148.2, align 16, !dbg !83
  %kb.sroa.10.0.copyload709 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.10.32.add.ptr148.2.sroa_idx, align 8, !dbg !83
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload706, <4 x half> %Q_reg.sroa.8.32.copyload, <4 x float> %60), !dbg !84
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload709, <4 x half> %Q_reg.sroa.10.32.copyload, <4 x float> %61), !dbg !84
  %kb.sroa.0.0.copyload707 = load <4 x half>, ptr addrspace(3) %add.ptr148.3, align 16, !dbg !83
  %kb.sroa.10.0.copyload710 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.13.48.add.ptr148.3.sroa_idx, align 8, !dbg !83
  %63 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload707, <4 x half> %Q_reg.sroa.11.48.copyload, <4 x float> %62), !dbg !84
  %64 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload710, <4 x half> %Q_reg.sroa.13.48.copyload, <4 x float> %63), !dbg !84
  fence syncscope("warp") release, !dbg !85
  tail call void @llvm.mxc.barrier.warp(), !dbg !88
  fence syncscope("warp") acquire, !dbg !89
  %add.ptr242.idx = shl nuw nsw i32 %2, 4
  %invariant.gep613 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr242.idx, !dbg !90
  store i32 %40, ptr addrspace(3) %invariant.gep613, align 16, !dbg !91, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep613.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 4, !dbg !91
  store i32 %41, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep613.sroa_idx, align 4, !dbg !91, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep613.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 8, !dbg !91
  store i32 %42, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep613.sroa_idx, align 8, !dbg !91, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep613.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 12, !dbg !91
  store i32 %43, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep613.sroa_idx, align 4, !dbg !91, !tbaa !30
  %gep614.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 1024, !dbg !92
  store i32 %44, ptr addrspace(3) %gep614.1, align 16, !dbg !91, !tbaa !30
  %V_reg.sroa.9.16.gep614.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 1028, !dbg !91
  store i32 %45, ptr addrspace(3) %V_reg.sroa.9.16.gep614.1.sroa_idx, align 4, !dbg !91, !tbaa !30
  %V_reg.sroa.10.16.gep614.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 1032, !dbg !91
  store i32 %46, ptr addrspace(3) %V_reg.sroa.10.16.gep614.1.sroa_idx, align 8, !dbg !91, !tbaa !30
  %V_reg.sroa.11.16.gep614.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 1036, !dbg !91
  store i32 %47, ptr addrspace(3) %V_reg.sroa.11.16.gep614.1.sroa_idx, align 4, !dbg !91, !tbaa !30
  %gep614.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 2048, !dbg !92
  store i32 %48, ptr addrspace(3) %gep614.2, align 16, !dbg !91, !tbaa !30
  %V_reg.sroa.14.32.gep614.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 2052, !dbg !91
  store i32 %49, ptr addrspace(3) %V_reg.sroa.14.32.gep614.2.sroa_idx, align 4, !dbg !91, !tbaa !30
  %V_reg.sroa.15.32.gep614.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 2056, !dbg !91
  store i32 %50, ptr addrspace(3) %V_reg.sroa.15.32.gep614.2.sroa_idx, align 8, !dbg !91, !tbaa !30
  %V_reg.sroa.16.32.gep614.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 2060, !dbg !91
  store i32 %51, ptr addrspace(3) %V_reg.sroa.16.32.gep614.2.sroa_idx, align 4, !dbg !91, !tbaa !30
  %gep614.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 3072, !dbg !92
  store i32 %52, ptr addrspace(3) %gep614.3, align 16, !dbg !91, !tbaa !30
  %V_reg.sroa.19.48.gep614.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 3076, !dbg !91
  store i32 %53, ptr addrspace(3) %V_reg.sroa.19.48.gep614.3.sroa_idx, align 4, !dbg !91, !tbaa !30
  %V_reg.sroa.20.48.gep614.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 3080, !dbg !91
  store i32 %54, ptr addrspace(3) %V_reg.sroa.20.48.gep614.3.sroa_idx, align 8, !dbg !91, !tbaa !30
  %V_reg.sroa.21.48.gep614.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 3084, !dbg !91
  store i32 %55, ptr addrspace(3) %V_reg.sroa.21.48.gep614.3.sroa_idx, align 4, !dbg !91, !tbaa !30
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %64, i64 1, !dbg !93
  %mul252.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !94
  %65 = tail call contract noundef float @llvm.minnum.f32(float %mul252.1, float 0x4024CB5EC0000000), !dbg !95
  %66 = tail call contract noundef float @llvm.exp.f32(float %65), !dbg !99
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %64, i64 2, !dbg !93
  %mul252.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !94
  %67 = tail call contract noundef float @llvm.minnum.f32(float %mul252.2, float 0x4024CB5EC0000000), !dbg !95
  %68 = tail call contract noundef float @llvm.exp.f32(float %67), !dbg !99
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %64, i64 3, !dbg !93
  %mul252.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !94
  %69 = tail call contract noundef float @llvm.minnum.f32(float %mul252.3, float 0x4024CB5EC0000000), !dbg !95
  %70 = tail call contract noundef float @llvm.exp.f32(float %69), !dbg !99
  %71 = lshr i32 %2, 2
  %mul266 = and i32 %71, 252
  %cmp269.not = icmp ugt i32 %mul266, %1, !dbg !102
  br i1 %cmp269.not, label %if.end, label %if.then270, !dbg !103

if.then270:                                       ; preds = %for.cond40.preheader
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %64, i64 0, !dbg !93
  %mul252 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !94
  %72 = tail call contract noundef float @llvm.minnum.f32(float %mul252, float 0x4024CB5EC0000000), !dbg !95
  %73 = tail call contract noundef float @llvm.exp.f32(float %72), !dbg !99
  br label %if.end, !dbg !104

if.end:                                           ; preds = %for.cond40.preheader, %if.then270
  %condval.0 = phi float [ %73, %if.then270 ], [ 0.000000e+00, %for.cond40.preheader ], !dbg !105
  %cmp269.not.1.not = icmp ult i32 %mul266, %1, !dbg !102
  %spec.select = select i1 %cmp269.not.1.not, float %66, float 0.000000e+00, !dbg !103
  %add267.2 = or disjoint i32 %mul266, 2, !dbg !106
  %cmp269.not.2 = icmp ugt i32 %add267.2, %1, !dbg !102
  %condval.0.2 = select i1 %cmp269.not.2, float 0.000000e+00, float %68, !dbg !103
  %add267.3 = or i32 %71, 3, !dbg !106
  %cmp269.not.3 = icmp ugt i32 %add267.3, %1, !dbg !102
  %condval.0.3 = select i1 %cmp269.not.3, float 0.000000e+00, float %70, !dbg !103
  %add286.1 = fadd contract float %condval.0, %spec.select, !dbg !107
  %add286.2 = fadd contract float %add286.1, %condval.0.2, !dbg !107
  %add286.3 = fadd contract float %add286.2, %condval.0.3, !dbg !107
  %74 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add286.3, <4 x float> zeroinitializer), !dbg !108
  %wsum_output.sroa.0.0.vec.extract = extractelement <4 x float> %74, i64 0, !dbg !109
  %cmp304 = fcmp contract ogt float %wsum_output.sroa.0.0.vec.extract, 0.000000e+00, !dbg !110
  %div = fdiv contract float 1.000000e+00, %wsum_output.sroa.0.0.vec.extract, !dbg !111
  %condval_1.0 = select i1 %cmp304, float %div, float 0.000000e+00, !dbg !111
  %mul317 = fmul contract float %condval_1.0, %condval.0, !dbg !112
  %mul317.1 = fmul contract float %condval_1.0, %spec.select, !dbg !112
  %mul317.2 = fmul contract float %condval_1.0, %condval.0.2, !dbg !112
  %mul317.3 = fmul contract float %condval_1.0, %condval.0.3, !dbg !112
  %75 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul317), !dbg !113
  %76 = insertelement <4 x i16> poison, i16 %75, i64 0, !dbg !122
  %77 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul317.1), !dbg !113
  %78 = insertelement <4 x i16> %76, i16 %77, i64 1, !dbg !122
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul317.2), !dbg !113
  %80 = insertelement <4 x i16> %78, i16 %79, i64 2, !dbg !122
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul317.3), !dbg !113
  %82 = insertelement <4 x i16> %80, i16 %81, i64 3, !dbg !122
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %82 to <4 x half>, !dbg !122
  fence syncscope("warp") release, !dbg !123
  tail call void @llvm.mxc.barrier.warp(), !dbg !126
  fence syncscope("warp") acquire, !dbg !127
  br label %if.end335, !dbg !128

if.end335:                                        ; preds = %if.end, %entry
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ %acc_s_cast.sroa.0.6.vec.insert, %if.end ], [ undef, %entry ]
  br i1 %cmp35, label %for.cond355.preheader, label %if.end335.if.end403_crit_edge, !dbg !129

if.end335.if.end403_crit_edge:                    ; preds = %if.end335
  %.pre = and i32 %2, 15
  br label %if.end403, !dbg !129

for.cond355.preheader:                            ; preds = %if.end335
  %83 = shl nuw nsw i32 %2, 5
  %mul365 = and i32 %83, 32256
  %and371 = and i32 %2, 15
  %add372 = or disjoint i32 %mul365, %and371, !dbg !130
  %arrayidx374 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372, !dbg !131
  %84 = load half, ptr addrspace(3) %arrayidx374, align 2, !dbg !132, !tbaa !133
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %84, i64 0, !dbg !132
  %add367.1 = or disjoint i32 %mul365, %and371, !dbg !130
  %add372.1 = or disjoint i32 %add367.1, 128, !dbg !130
  %arrayidx374.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.1, !dbg !131
  %85 = load half, ptr addrspace(3) %arrayidx374.1, align 2, !dbg !132, !tbaa !133
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %85, i64 1, !dbg !132
  %add367.2 = or disjoint i32 %mul365, %and371, !dbg !130
  %add372.2 = or disjoint i32 %add367.2, 256, !dbg !130
  %arrayidx374.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.2, !dbg !131
  %86 = load half, ptr addrspace(3) %arrayidx374.2, align 2, !dbg !132, !tbaa !133
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %86, i64 2, !dbg !132
  %add367.3 = or disjoint i32 %mul365, %and371, !dbg !130
  %add372.3 = or disjoint i32 %add367.3, 384, !dbg !130
  %arrayidx374.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.3, !dbg !131
  %87 = load half, ptr addrspace(3) %arrayidx374.3, align 2, !dbg !132, !tbaa !133
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %87, i64 3, !dbg !132
  %add369.1671 = or disjoint i32 %mul365, %and371, !dbg !130
  %add372.1672 = or disjoint i32 %add369.1671, 16, !dbg !130
  %arrayidx374.1673 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.1672, !dbg !131
  %88 = load half, ptr addrspace(3) %arrayidx374.1673, align 2, !dbg !132, !tbaa !133
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %88, i64 0, !dbg !132
  %add369.1.1 = or disjoint i32 %mul365, %and371, !dbg !130
  %add372.1.1 = or disjoint i32 %add369.1.1, 144, !dbg !130
  %arrayidx374.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.1.1, !dbg !131
  %89 = load half, ptr addrspace(3) %arrayidx374.1.1, align 2, !dbg !132, !tbaa !133
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %89, i64 1, !dbg !132
  %add369.2.1 = or disjoint i32 %mul365, %and371, !dbg !130
  %add372.2.1 = or disjoint i32 %add369.2.1, 272, !dbg !130
  %arrayidx374.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.2.1, !dbg !131
  %90 = load half, ptr addrspace(3) %arrayidx374.2.1, align 2, !dbg !132, !tbaa !133
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %90, i64 2, !dbg !132
  %add369.3.1 = or disjoint i32 %mul365, %and371, !dbg !130
  %add372.3.1 = or disjoint i32 %add369.3.1, 400, !dbg !130
  %arrayidx374.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.3.1, !dbg !131
  %91 = load half, ptr addrspace(3) %arrayidx374.3.1, align 2, !dbg !132, !tbaa !133
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %91, i64 3, !dbg !132
  %add369.2675 = or disjoint i32 %mul365, %and371, !dbg !130
  %add372.2676 = or disjoint i32 %add369.2675, 32, !dbg !130
  %arrayidx374.2677 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.2676, !dbg !131
  %92 = load half, ptr addrspace(3) %arrayidx374.2677, align 2, !dbg !132, !tbaa !133
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %92, i64 0, !dbg !132
  %add369.1.2 = or disjoint i32 %mul365, %and371, !dbg !130
  %add372.1.2 = or disjoint i32 %add369.1.2, 160, !dbg !130
  %arrayidx374.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.1.2, !dbg !131
  %93 = load half, ptr addrspace(3) %arrayidx374.1.2, align 2, !dbg !132, !tbaa !133
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %93, i64 1, !dbg !132
  %add369.2.2 = or disjoint i32 %mul365, %and371, !dbg !130
  %add372.2.2 = or disjoint i32 %add369.2.2, 288, !dbg !130
  %arrayidx374.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.2.2, !dbg !131
  %94 = load half, ptr addrspace(3) %arrayidx374.2.2, align 2, !dbg !132, !tbaa !133
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %94, i64 2, !dbg !132
  %add369.3.2 = or disjoint i32 %mul365, %and371, !dbg !130
  %add372.3.2 = or disjoint i32 %add369.3.2, 416, !dbg !130
  %arrayidx374.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.3.2, !dbg !131
  %95 = load half, ptr addrspace(3) %arrayidx374.3.2, align 2, !dbg !132, !tbaa !133
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %95, i64 3, !dbg !132
  %add369.3679 = or disjoint i32 %mul365, %and371, !dbg !130
  %add372.3680 = or disjoint i32 %add369.3679, 48, !dbg !130
  %arrayidx374.3681 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.3680, !dbg !131
  %96 = load half, ptr addrspace(3) %arrayidx374.3681, align 2, !dbg !132, !tbaa !133
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %96, i64 0, !dbg !132
  %add369.1.3 = or disjoint i32 %mul365, %and371, !dbg !130
  %add372.1.3 = or disjoint i32 %add369.1.3, 176, !dbg !130
  %arrayidx374.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.1.3, !dbg !131
  %97 = load half, ptr addrspace(3) %arrayidx374.1.3, align 2, !dbg !132, !tbaa !133
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %97, i64 1, !dbg !132
  %add369.2.3 = or disjoint i32 %mul365, %and371, !dbg !130
  %add372.2.3 = or disjoint i32 %add369.2.3, 304, !dbg !130
  %arrayidx374.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.2.3, !dbg !131
  %98 = load half, ptr addrspace(3) %arrayidx374.2.3, align 2, !dbg !132, !tbaa !133
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %98, i64 2, !dbg !132
  %add369.3.3 = or disjoint i32 %mul365, %and371, !dbg !130
  %add372.3.3 = or disjoint i32 %add369.3.3, 432, !dbg !130
  %arrayidx374.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.3.3, !dbg !131
  %99 = load half, ptr addrspace(3) %arrayidx374.3.3, align 2, !dbg !132, !tbaa !133
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %99, i64 3, !dbg !132
  %add369.4 = or disjoint i32 %mul365, %and371, !dbg !130
  %add372.4 = or disjoint i32 %add369.4, 64, !dbg !130
  %arrayidx374.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.4, !dbg !131
  %100 = load half, ptr addrspace(3) %arrayidx374.4, align 2, !dbg !132, !tbaa !133
  %vb.sroa.22.32.vec.insert = insertelement <4 x half> poison, half %100, i64 0, !dbg !132
  %add369.1.4 = or disjoint i32 %mul365, %and371, !dbg !130
  %add372.1.4 = or disjoint i32 %add369.1.4, 192, !dbg !130
  %arrayidx374.1.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.1.4, !dbg !131
  %101 = load half, ptr addrspace(3) %arrayidx374.1.4, align 2, !dbg !132, !tbaa !133
  %vb.sroa.22.34.vec.insert = insertelement <4 x half> %vb.sroa.22.32.vec.insert, half %101, i64 1, !dbg !132
  %add369.2.4 = or disjoint i32 %mul365, %and371, !dbg !130
  %add372.2.4 = or disjoint i32 %add369.2.4, 320, !dbg !130
  %arrayidx374.2.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.2.4, !dbg !131
  %102 = load half, ptr addrspace(3) %arrayidx374.2.4, align 2, !dbg !132, !tbaa !133
  %vb.sroa.22.36.vec.insert = insertelement <4 x half> %vb.sroa.22.34.vec.insert, half %102, i64 2, !dbg !132
  %add369.3.4 = or disjoint i32 %mul365, %and371, !dbg !130
  %add372.3.4 = or disjoint i32 %add369.3.4, 448, !dbg !130
  %arrayidx374.3.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.3.4, !dbg !131
  %103 = load half, ptr addrspace(3) %arrayidx374.3.4, align 2, !dbg !132, !tbaa !133
  %vb.sroa.22.38.vec.insert = insertelement <4 x half> %vb.sroa.22.36.vec.insert, half %103, i64 3, !dbg !132
  %add369.5 = or disjoint i32 %mul365, %and371, !dbg !130
  %add372.5 = or disjoint i32 %add369.5, 80, !dbg !130
  %arrayidx374.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.5, !dbg !131
  %104 = load half, ptr addrspace(3) %arrayidx374.5, align 2, !dbg !132, !tbaa !133
  %vb.sroa.27.40.vec.insert = insertelement <4 x half> poison, half %104, i64 0, !dbg !132
  %add369.1.5 = or disjoint i32 %mul365, %and371, !dbg !130
  %add372.1.5 = or disjoint i32 %add369.1.5, 208, !dbg !130
  %arrayidx374.1.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.1.5, !dbg !131
  %105 = load half, ptr addrspace(3) %arrayidx374.1.5, align 2, !dbg !132, !tbaa !133
  %vb.sroa.27.42.vec.insert = insertelement <4 x half> %vb.sroa.27.40.vec.insert, half %105, i64 1, !dbg !132
  %add369.2.5 = or disjoint i32 %mul365, %and371, !dbg !130
  %add372.2.5 = or disjoint i32 %add369.2.5, 336, !dbg !130
  %arrayidx374.2.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.2.5, !dbg !131
  %106 = load half, ptr addrspace(3) %arrayidx374.2.5, align 2, !dbg !132, !tbaa !133
  %vb.sroa.27.44.vec.insert = insertelement <4 x half> %vb.sroa.27.42.vec.insert, half %106, i64 2, !dbg !132
  %add369.3.5 = or disjoint i32 %mul365, %and371, !dbg !130
  %add372.3.5 = or disjoint i32 %add369.3.5, 464, !dbg !130
  %arrayidx374.3.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.3.5, !dbg !131
  %107 = load half, ptr addrspace(3) %arrayidx374.3.5, align 2, !dbg !132, !tbaa !133
  %vb.sroa.27.46.vec.insert = insertelement <4 x half> %vb.sroa.27.44.vec.insert, half %107, i64 3, !dbg !132
  %add369.6 = or disjoint i32 %mul365, %and371, !dbg !130
  %add372.6 = or disjoint i32 %add369.6, 96, !dbg !130
  %arrayidx374.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.6, !dbg !131
  %108 = load half, ptr addrspace(3) %arrayidx374.6, align 2, !dbg !132, !tbaa !133
  %vb.sroa.32.48.vec.insert = insertelement <4 x half> poison, half %108, i64 0, !dbg !132
  %add369.1.6 = or disjoint i32 %mul365, %and371, !dbg !130
  %add372.1.6 = or disjoint i32 %add369.1.6, 224, !dbg !130
  %arrayidx374.1.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.1.6, !dbg !131
  %109 = load half, ptr addrspace(3) %arrayidx374.1.6, align 2, !dbg !132, !tbaa !133
  %vb.sroa.32.50.vec.insert = insertelement <4 x half> %vb.sroa.32.48.vec.insert, half %109, i64 1, !dbg !132
  %add369.2.6 = or disjoint i32 %mul365, %and371, !dbg !130
  %add372.2.6 = or disjoint i32 %add369.2.6, 352, !dbg !130
  %arrayidx374.2.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.2.6, !dbg !131
  %110 = load half, ptr addrspace(3) %arrayidx374.2.6, align 2, !dbg !132, !tbaa !133
  %vb.sroa.32.52.vec.insert = insertelement <4 x half> %vb.sroa.32.50.vec.insert, half %110, i64 2, !dbg !132
  %add369.3.6 = or disjoint i32 %83, %and371, !dbg !130
  %add372.3.6 = or i32 %add369.3.6, 480, !dbg !130
  %arrayidx374.3.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.3.6, !dbg !131
  %111 = load half, ptr addrspace(3) %arrayidx374.3.6, align 2, !dbg !132, !tbaa !133
  %vb.sroa.32.54.vec.insert = insertelement <4 x half> %vb.sroa.32.52.vec.insert, half %111, i64 3, !dbg !132
  %add369.7 = or disjoint i32 %mul365, %and371, !dbg !130
  %add372.7 = or disjoint i32 %add369.7, 112, !dbg !130
  %arrayidx374.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.7, !dbg !131
  %112 = load half, ptr addrspace(3) %arrayidx374.7, align 2, !dbg !132, !tbaa !133
  %vb.sroa.37.56.vec.insert = insertelement <4 x half> poison, half %112, i64 0, !dbg !132
  %add369.1.7 = or disjoint i32 %mul365, %and371, !dbg !130
  %add372.1.7 = or disjoint i32 %add369.1.7, 240, !dbg !130
  %arrayidx374.1.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.1.7, !dbg !131
  %113 = load half, ptr addrspace(3) %arrayidx374.1.7, align 2, !dbg !132, !tbaa !133
  %vb.sroa.37.58.vec.insert = insertelement <4 x half> %vb.sroa.37.56.vec.insert, half %113, i64 1, !dbg !132
  %add369.2.7 = or disjoint i32 %mul365, %and371, !dbg !130
  %add372.2.7 = or disjoint i32 %add369.2.7, 368, !dbg !130
  %arrayidx374.2.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.2.7, !dbg !131
  %114 = load half, ptr addrspace(3) %arrayidx374.2.7, align 2, !dbg !132, !tbaa !133
  %vb.sroa.37.60.vec.insert = insertelement <4 x half> %vb.sroa.37.58.vec.insert, half %114, i64 2, !dbg !132
  %add369.3.7 = or disjoint i32 %83, %and371, !dbg !130
  %add372.3.7 = or i32 %add369.3.7, 496, !dbg !130
  %arrayidx374.3.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add372.3.7, !dbg !131
  %115 = load half, ptr addrspace(3) %arrayidx374.3.7, align 2, !dbg !132, !tbaa !133
  %vb.sroa.37.62.vec.insert = insertelement <4 x half> %vb.sroa.37.60.vec.insert, half %115, i64 3, !dbg !132
  %116 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !134
  %117 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !134
  %118 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !134
  %119 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !134
  %120 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.38.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !134
  %121 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.27.46.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !134
  %122 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.54.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !134
  %123 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.37.62.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !134
  br label %if.end403, !dbg !135

if.end403:                                        ; preds = %if.end335.if.end403_crit_edge, %for.cond355.preheader
  %and443.pre-phi = phi i32 [ %.pre, %if.end335.if.end403_crit_edge ], [ %and371, %for.cond355.preheader ]
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end335.if.end403_crit_edge ], [ %116, %for.cond355.preheader ], !dbg !105
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end335.if.end403_crit_edge ], [ %117, %for.cond355.preheader ], !dbg !105
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end335.if.end403_crit_edge ], [ %118, %for.cond355.preheader ], !dbg !105
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end335.if.end403_crit_edge ], [ %119, %for.cond355.preheader ], !dbg !105
  %acc_o.sroa.58.0 = phi <4 x float> [ zeroinitializer, %if.end335.if.end403_crit_edge ], [ %120, %for.cond355.preheader ], !dbg !105
  %acc_o.sroa.72.0 = phi <4 x float> [ zeroinitializer, %if.end335.if.end403_crit_edge ], [ %121, %for.cond355.preheader ], !dbg !105
  %acc_o.sroa.86.0 = phi <4 x float> [ zeroinitializer, %if.end335.if.end403_crit_edge ], [ %122, %for.cond355.preheader ], !dbg !105
  %acc_o.sroa.100.0 = phi <4 x float> [ zeroinitializer, %if.end335.if.end403_crit_edge ], [ %123, %for.cond355.preheader ], !dbg !105
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0, !dbg !136
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract), !dbg !137
  %O_reg.sroa.0.0.insert.ext = zext i16 %124 to i64, !dbg !141
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1, !dbg !136
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract), !dbg !137
  %O_reg.sroa.0.2.insert.ext = zext i16 %125 to i64, !dbg !141
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !141
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !141
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2, !dbg !136
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract), !dbg !137
  %O_reg.sroa.0.4.insert.ext = zext i16 %126 to i64, !dbg !141
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !141
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !141
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3, !dbg !136
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract), !dbg !137
  %O_reg.sroa.0.6.insert.ext = zext i16 %127 to i64, !dbg !141
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !141
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !141
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0, !dbg !136
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract), !dbg !137
  %O_reg.sroa.7.8.insert.ext = zext i16 %128 to i64, !dbg !141
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1, !dbg !136
  %129 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract), !dbg !137
  %O_reg.sroa.7.10.insert.ext = zext i16 %129 to i64, !dbg !141
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !141
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !141
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2, !dbg !136
  %130 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract), !dbg !137
  %O_reg.sroa.7.12.insert.ext = zext i16 %130 to i64, !dbg !141
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !141
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !141
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3, !dbg !136
  %131 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract), !dbg !137
  %O_reg.sroa.7.14.insert.ext = zext i16 %131 to i64, !dbg !141
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !141
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !141
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0, !dbg !136
  %132 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract), !dbg !137
  %O_reg.sroa.12.16.insert.ext = zext i16 %132 to i64, !dbg !141
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1, !dbg !136
  %133 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract), !dbg !137
  %O_reg.sroa.12.18.insert.ext = zext i16 %133 to i64, !dbg !141
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !141
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !141
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2, !dbg !136
  %134 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract), !dbg !137
  %O_reg.sroa.12.20.insert.ext = zext i16 %134 to i64, !dbg !141
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !141
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !141
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3, !dbg !136
  %135 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract), !dbg !137
  %O_reg.sroa.12.22.insert.ext = zext i16 %135 to i64, !dbg !141
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !141
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !141
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0, !dbg !136
  %136 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract), !dbg !137
  %O_reg.sroa.17.24.insert.ext = zext i16 %136 to i64, !dbg !141
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1, !dbg !136
  %137 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract), !dbg !137
  %O_reg.sroa.17.26.insert.ext = zext i16 %137 to i64, !dbg !141
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !141
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !141
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2, !dbg !136
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract), !dbg !137
  %O_reg.sroa.17.28.insert.ext = zext i16 %138 to i64, !dbg !141
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !141
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !141
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3, !dbg !136
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract), !dbg !137
  %O_reg.sroa.17.30.insert.ext = zext i16 %139 to i64, !dbg !141
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !141
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !141
  %acc_o.sroa.58.64.vec.extract = extractelement <4 x float> %acc_o.sroa.58.0, i64 0, !dbg !136
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.58.64.vec.extract), !dbg !137
  %O_reg.sroa.22.32.insert.ext = zext i16 %140 to i64, !dbg !141
  %acc_o.sroa.58.68.vec.extract = extractelement <4 x float> %acc_o.sroa.58.0, i64 1, !dbg !136
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.58.68.vec.extract), !dbg !137
  %O_reg.sroa.22.34.insert.ext = zext i16 %141 to i64, !dbg !141
  %O_reg.sroa.22.34.insert.shift = shl nuw nsw i64 %O_reg.sroa.22.34.insert.ext, 16, !dbg !141
  %O_reg.sroa.22.34.insert.insert = or disjoint i64 %O_reg.sroa.22.34.insert.shift, %O_reg.sroa.22.32.insert.ext, !dbg !141
  %acc_o.sroa.58.72.vec.extract = extractelement <4 x float> %acc_o.sroa.58.0, i64 2, !dbg !136
  %142 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.58.72.vec.extract), !dbg !137
  %O_reg.sroa.22.36.insert.ext = zext i16 %142 to i64, !dbg !141
  %O_reg.sroa.22.36.insert.shift = shl nuw nsw i64 %O_reg.sroa.22.36.insert.ext, 32, !dbg !141
  %O_reg.sroa.22.36.insert.insert = or disjoint i64 %O_reg.sroa.22.34.insert.insert, %O_reg.sroa.22.36.insert.shift, !dbg !141
  %acc_o.sroa.58.76.vec.extract = extractelement <4 x float> %acc_o.sroa.58.0, i64 3, !dbg !136
  %143 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.58.76.vec.extract), !dbg !137
  %O_reg.sroa.22.38.insert.ext = zext i16 %143 to i64, !dbg !141
  %O_reg.sroa.22.38.insert.shift = shl nuw i64 %O_reg.sroa.22.38.insert.ext, 48, !dbg !141
  %O_reg.sroa.22.38.insert.insert = or disjoint i64 %O_reg.sroa.22.36.insert.insert, %O_reg.sroa.22.38.insert.shift, !dbg !141
  %acc_o.sroa.72.80.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 0, !dbg !136
  %144 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.80.vec.extract), !dbg !137
  %O_reg.sroa.27.40.insert.ext = zext i16 %144 to i64, !dbg !141
  %acc_o.sroa.72.84.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 1, !dbg !136
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.84.vec.extract), !dbg !137
  %O_reg.sroa.27.42.insert.ext = zext i16 %145 to i64, !dbg !141
  %O_reg.sroa.27.42.insert.shift = shl nuw nsw i64 %O_reg.sroa.27.42.insert.ext, 16, !dbg !141
  %O_reg.sroa.27.42.insert.insert = or disjoint i64 %O_reg.sroa.27.42.insert.shift, %O_reg.sroa.27.40.insert.ext, !dbg !141
  %acc_o.sroa.72.88.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 2, !dbg !136
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.88.vec.extract), !dbg !137
  %O_reg.sroa.27.44.insert.ext = zext i16 %146 to i64, !dbg !141
  %O_reg.sroa.27.44.insert.shift = shl nuw nsw i64 %O_reg.sroa.27.44.insert.ext, 32, !dbg !141
  %O_reg.sroa.27.44.insert.insert = or disjoint i64 %O_reg.sroa.27.42.insert.insert, %O_reg.sroa.27.44.insert.shift, !dbg !141
  %acc_o.sroa.72.92.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 3, !dbg !136
  %147 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.92.vec.extract), !dbg !137
  %O_reg.sroa.27.46.insert.ext = zext i16 %147 to i64, !dbg !141
  %O_reg.sroa.27.46.insert.shift = shl nuw i64 %O_reg.sroa.27.46.insert.ext, 48, !dbg !141
  %O_reg.sroa.27.46.insert.insert = or disjoint i64 %O_reg.sroa.27.44.insert.insert, %O_reg.sroa.27.46.insert.shift, !dbg !141
  %acc_o.sroa.86.96.vec.extract = extractelement <4 x float> %acc_o.sroa.86.0, i64 0, !dbg !136
  %148 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.86.96.vec.extract), !dbg !137
  %O_reg.sroa.32.48.insert.ext = zext i16 %148 to i64, !dbg !141
  %acc_o.sroa.86.100.vec.extract = extractelement <4 x float> %acc_o.sroa.86.0, i64 1, !dbg !136
  %149 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.86.100.vec.extract), !dbg !137
  %O_reg.sroa.32.50.insert.ext = zext i16 %149 to i64, !dbg !141
  %O_reg.sroa.32.50.insert.shift = shl nuw nsw i64 %O_reg.sroa.32.50.insert.ext, 16, !dbg !141
  %O_reg.sroa.32.50.insert.insert = or disjoint i64 %O_reg.sroa.32.50.insert.shift, %O_reg.sroa.32.48.insert.ext, !dbg !141
  %acc_o.sroa.86.104.vec.extract = extractelement <4 x float> %acc_o.sroa.86.0, i64 2, !dbg !136
  %150 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.86.104.vec.extract), !dbg !137
  %O_reg.sroa.32.52.insert.ext = zext i16 %150 to i64, !dbg !141
  %O_reg.sroa.32.52.insert.shift = shl nuw nsw i64 %O_reg.sroa.32.52.insert.ext, 32, !dbg !141
  %O_reg.sroa.32.52.insert.insert = or disjoint i64 %O_reg.sroa.32.50.insert.insert, %O_reg.sroa.32.52.insert.shift, !dbg !141
  %acc_o.sroa.86.108.vec.extract = extractelement <4 x float> %acc_o.sroa.86.0, i64 3, !dbg !136
  %151 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.86.108.vec.extract), !dbg !137
  %O_reg.sroa.32.54.insert.ext = zext i16 %151 to i64, !dbg !141
  %O_reg.sroa.32.54.insert.shift = shl nuw i64 %O_reg.sroa.32.54.insert.ext, 48, !dbg !141
  %O_reg.sroa.32.54.insert.insert = or disjoint i64 %O_reg.sroa.32.52.insert.insert, %O_reg.sroa.32.54.insert.shift, !dbg !141
  %acc_o.sroa.100.112.vec.extract = extractelement <4 x float> %acc_o.sroa.100.0, i64 0, !dbg !136
  %152 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.100.112.vec.extract), !dbg !137
  %O_reg.sroa.37.56.insert.ext = zext i16 %152 to i64, !dbg !141
  %acc_o.sroa.100.116.vec.extract = extractelement <4 x float> %acc_o.sroa.100.0, i64 1, !dbg !136
  %153 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.100.116.vec.extract), !dbg !137
  %O_reg.sroa.37.58.insert.ext = zext i16 %153 to i64, !dbg !141
  %O_reg.sroa.37.58.insert.shift = shl nuw nsw i64 %O_reg.sroa.37.58.insert.ext, 16, !dbg !141
  %O_reg.sroa.37.58.insert.insert = or disjoint i64 %O_reg.sroa.37.58.insert.shift, %O_reg.sroa.37.56.insert.ext, !dbg !141
  %acc_o.sroa.100.120.vec.extract = extractelement <4 x float> %acc_o.sroa.100.0, i64 2, !dbg !136
  %154 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.100.120.vec.extract), !dbg !137
  %O_reg.sroa.37.60.insert.ext = zext i16 %154 to i64, !dbg !141
  %O_reg.sroa.37.60.insert.shift = shl nuw nsw i64 %O_reg.sroa.37.60.insert.ext, 32, !dbg !141
  %O_reg.sroa.37.60.insert.insert = or disjoint i64 %O_reg.sroa.37.58.insert.insert, %O_reg.sroa.37.60.insert.shift, !dbg !141
  %acc_o.sroa.100.124.vec.extract = extractelement <4 x float> %acc_o.sroa.100.0, i64 3, !dbg !136
  %155 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.100.124.vec.extract), !dbg !137
  %O_reg.sroa.37.62.insert.ext = zext i16 %155 to i64, !dbg !141
  %O_reg.sroa.37.62.insert.shift = shl nuw i64 %O_reg.sroa.37.62.insert.ext, 48, !dbg !141
  %O_reg.sroa.37.62.insert.insert = or disjoint i64 %O_reg.sroa.37.60.insert.insert, %O_reg.sroa.37.62.insert.shift, !dbg !141
  fence syncscope("warp") release, !dbg !142
  tail call void @llvm.mxc.barrier.warp(), !dbg !145
  fence syncscope("warp") acquire, !dbg !146
  %and436 = shl nuw nsw i32 %2, 7
  %mul437 = and i32 %and436, 1920
  %shr440 = lshr i32 %2, 5
  %156 = lshr i32 %2, 2
  %mul450 = and i32 %156, 4
  %xor444 = xor i32 %shr440, %and443.pre-phi, !dbg !147
  %mul445 = shl nuw nsw i32 %xor444, 3, !dbg !148
  %add446 = add nuw nsw i32 %mul445, %mul437, !dbg !149
  %add451 = or disjoint i32 %add446, %mul450, !dbg !150
  %add.ptr453 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add451, !dbg !151
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr453, align 8, !dbg !152
  %add441.1 = add nuw nsw i32 %shr440, 2, !dbg !153
  %xor444.1 = xor i32 %add441.1, %and443.pre-phi, !dbg !147
  %mul445.1 = shl nuw nsw i32 %xor444.1, 3, !dbg !148
  %add446.1 = add nuw nsw i32 %mul445.1, %mul437, !dbg !149
  %add451.1 = or disjoint i32 %add446.1, %mul450, !dbg !150
  %add.ptr453.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add451.1, !dbg !151
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr453.1, align 8, !dbg !152
  %add441.2 = add nuw nsw i32 %shr440, 4, !dbg !153
  %xor444.2 = xor i32 %add441.2, %and443.pre-phi, !dbg !147
  %mul445.2 = shl nuw nsw i32 %xor444.2, 3, !dbg !148
  %add446.2 = add nuw nsw i32 %mul445.2, %mul437, !dbg !149
  %add451.2 = or disjoint i32 %add446.2, %mul450, !dbg !150
  %add.ptr453.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add451.2, !dbg !151
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr453.2, align 8, !dbg !152
  %add441.3 = add nuw nsw i32 %shr440, 6, !dbg !153
  %xor444.3 = xor i32 %add441.3, %and443.pre-phi, !dbg !147
  %mul445.3 = shl nuw nsw i32 %xor444.3, 3, !dbg !148
  %add446.3 = add nuw nsw i32 %mul445.3, %mul437, !dbg !149
  %add451.3 = or disjoint i32 %add446.3, %mul450, !dbg !150
  %add.ptr453.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add451.3, !dbg !151
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr453.3, align 8, !dbg !152
  %add441.4 = add nuw nsw i32 %shr440, 8, !dbg !153
  %xor444.4 = xor i32 %add441.4, %and443.pre-phi, !dbg !147
  %mul445.4 = shl nuw nsw i32 %xor444.4, 3, !dbg !148
  %add446.4 = add nuw nsw i32 %mul445.4, %mul437, !dbg !149
  %add451.4 = or disjoint i32 %add446.4, %mul450, !dbg !150
  %add.ptr453.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add451.4, !dbg !151
  store i64 %O_reg.sroa.22.38.insert.insert, ptr addrspace(3) %add.ptr453.4, align 8, !dbg !152
  %add441.5 = add nuw nsw i32 %shr440, 10, !dbg !153
  %xor444.5 = xor i32 %add441.5, %and443.pre-phi, !dbg !147
  %mul445.5 = shl nuw nsw i32 %xor444.5, 3, !dbg !148
  %add446.5 = add nuw nsw i32 %mul445.5, %mul437, !dbg !149
  %add451.5 = or disjoint i32 %add446.5, %mul450, !dbg !150
  %add.ptr453.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add451.5, !dbg !151
  store i64 %O_reg.sroa.27.46.insert.insert, ptr addrspace(3) %add.ptr453.5, align 8, !dbg !152
  %add441.6 = add nuw nsw i32 %shr440, 12, !dbg !153
  %xor444.6 = xor i32 %add441.6, %and443.pre-phi, !dbg !147
  %mul445.6 = shl nuw nsw i32 %xor444.6, 3, !dbg !148
  %add446.6 = add nuw nsw i32 %mul445.6, %mul437, !dbg !149
  %add451.6 = or disjoint i32 %add446.6, %mul450, !dbg !150
  %add.ptr453.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add451.6, !dbg !151
  store i64 %O_reg.sroa.32.54.insert.insert, ptr addrspace(3) %add.ptr453.6, align 8, !dbg !152
  %add441.7 = add nuw nsw i32 %shr440, 14, !dbg !153
  %xor444.7 = xor i32 %add441.7, %and443.pre-phi, !dbg !147
  %mul445.7 = shl nuw nsw i32 %xor444.7, 3, !dbg !148
  %add446.7 = add nuw nsw i32 %mul445.7, %mul437, !dbg !149
  %add451.7 = or disjoint i32 %add446.7, %mul450, !dbg !150
  %add.ptr453.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add451.7, !dbg !151
  store i64 %O_reg.sroa.37.62.insert.insert, ptr addrspace(3) %add.ptr453.7, align 8, !dbg !152
  fence syncscope("warp") release, !dbg !154
  tail call void @llvm.mxc.barrier.warp(), !dbg !157
  fence syncscope("warp") acquire, !dbg !158
  %mul464 = and i32 %mul11, 8064
  %shr470 = lshr i32 %2, 4
  %invariant.gep629 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul464, !dbg !159
  %xor472 = xor i32 %shr470, %and443.pre-phi, !dbg !160
  %add.ptr476.idx = shl nuw nsw i32 %xor472, 4, !dbg !161
  %add.ptr476 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep629, i32 %add.ptr476.idx, !dbg !161
  %add.ptr488 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3, !dbg !162
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr488, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr476, i64 16, i1 false), !dbg !163, !tbaa.struct !164, !call_argsrelate !165
  %157 = add nuw nsw i32 %shr470, 4, !dbg !166
  %xor472.1 = xor i32 %157, %and443.pre-phi, !dbg !160
  %gep630.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep629, i32 1024, !dbg !161
  %add.ptr476.idx.1 = shl nuw nsw i32 %xor472.1, 4, !dbg !161
  %add.ptr476.1 = getelementptr inbounds i8, ptr addrspace(3) %gep630.1, i32 %add.ptr476.idx.1, !dbg !161
  %add.ptr488.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4, !dbg !162
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr488.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr476.1, i64 16, i1 false), !dbg !163, !tbaa.struct !164, !call_argsrelate !165
  %158 = add nuw nsw i32 %shr470, 8, !dbg !166
  %xor472.2 = xor i32 %158, %and443.pre-phi, !dbg !160
  %gep630.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep629, i32 2048, !dbg !161
  %add.ptr476.idx.2 = shl nuw nsw i32 %xor472.2, 4, !dbg !161
  %add.ptr476.2 = getelementptr inbounds i8, ptr addrspace(3) %gep630.2, i32 %add.ptr476.idx.2, !dbg !161
  %add.ptr488.2 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %5, !dbg !162
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr488.2, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr476.2, i64 16, i1 false), !dbg !163, !tbaa.struct !164, !call_argsrelate !165
  %narrow = add nuw nsw i32 %shr470, 12, !dbg !166
  %xor472.3 = xor i32 %narrow, %and443.pre-phi, !dbg !160
  %gep630.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep629, i32 3072, !dbg !161
  %add.ptr476.idx.3 = shl nuw nsw i32 %xor472.3, 4, !dbg !161
  %add.ptr476.3 = getelementptr inbounds i8, ptr addrspace(3) %gep630.3, i32 %add.ptr476.idx.3, !dbg !161
  %add.ptr488.3 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %6, !dbg !162
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr488.3, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr476.3, i64 16, i1 false), !dbg !163, !tbaa.struct !164, !call_argsrelate !165
  ret void, !dbg !167
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
!1 = !DIFile(filename: "/tmp/tmpn4t2p7mv/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpn4t2p7mv/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 28, column: 3, scope: !40)
!44 = !DILocation(line: 29, column: 124, scope: !40)
!45 = !DILocation(line: 31, column: 58, scope: !40)
!46 = !DILocation(line: 31, column: 64, scope: !40)
!47 = !DILocation(line: 31, column: 25, scope: !40)
!48 = !DILocation(line: 37, column: 31, scope: !40)
!49 = !DILocation(line: 29, column: 48, scope: !40)
!50 = !DILocation(line: 40, column: 5, scope: !40)
!51 = !DILocation(line: 43, column: 79, scope: !40)
!52 = !DILocation(line: 43, column: 58, scope: !40)
!53 = !DILocation(line: 43, column: 186, scope: !40)
!54 = !DILocation(line: 50, column: 79, scope: !40)
!55 = !DILocation(line: 50, column: 58, scope: !40)
!56 = !DILocation(line: 54, column: 5, scope: !40)
!57 = !DILocation(line: 55, column: 125, scope: !40)
!58 = !DILocation(line: 55, column: 42, scope: !40)
!59 = !DILocation(line: 55, column: 175, scope: !40)
!60 = !{i32 1, i32 3, i32 -1, i32 -1}
!61 = !DILocation(line: 55, column: 138, scope: !40)
!62 = !DILocation(line: 68, column: 3, scope: !63, inlinedAt: !65)
!63 = distinct !DISubprogram(name: "__barrier_warp", scope: !64, file: !64, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!64 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!65 = distinct !DILocation(line: 192, column: 3, scope: !66, inlinedAt: !67)
!66 = distinct !DISubprogram(name: "__syncwarp", scope: !64, file: !64, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!67 = distinct !DILocation(line: 57, column: 5, scope: !40)
!68 = !DILocation(line: 69, column: 3, scope: !63, inlinedAt: !65)
!69 = !DILocation(line: 70, column: 3, scope: !63, inlinedAt: !65)
!70 = !DILocation(line: 60, column: 73, scope: !40)
!71 = !DILocation(line: 60, column: 36, scope: !40)
!72 = !DILocation(line: 68, column: 3, scope: !63, inlinedAt: !73)
!73 = distinct !DILocation(line: 192, column: 3, scope: !66, inlinedAt: !74)
!74 = distinct !DILocation(line: 62, column: 5, scope: !40)
!75 = !DILocation(line: 69, column: 3, scope: !63, inlinedAt: !73)
!76 = !DILocation(line: 70, column: 3, scope: !63, inlinedAt: !73)
!77 = !DILocation(line: 65, column: 175, scope: !40)
!78 = !DILocation(line: 68, column: 3, scope: !63, inlinedAt: !79)
!79 = distinct !DILocation(line: 192, column: 3, scope: !66, inlinedAt: !80)
!80 = distinct !DILocation(line: 69, column: 5, scope: !40)
!81 = !DILocation(line: 69, column: 3, scope: !63, inlinedAt: !79)
!82 = !DILocation(line: 70, column: 3, scope: !63, inlinedAt: !79)
!83 = !DILocation(line: 71, column: 25, scope: !40)
!84 = !DILocation(line: 74, column: 36, scope: !40)
!85 = !DILocation(line: 68, column: 3, scope: !63, inlinedAt: !86)
!86 = distinct !DILocation(line: 192, column: 3, scope: !66, inlinedAt: !87)
!87 = distinct !DILocation(line: 80, column: 5, scope: !40)
!88 = !DILocation(line: 69, column: 3, scope: !63, inlinedAt: !86)
!89 = !DILocation(line: 70, column: 3, scope: !63, inlinedAt: !86)
!90 = !DILocation(line: 82, column: 10, scope: !40)
!91 = !DILocation(line: 83, column: 86, scope: !40)
!92 = !DILocation(line: 83, column: 42, scope: !40)
!93 = !DILocation(line: 87, column: 30, scope: !40)
!94 = !DILocation(line: 87, column: 41, scope: !40)
!95 = !DILocation(line: 354, column: 10, scope: !96, inlinedAt: !98)
!96 = distinct !DISubprogram(name: "min", scope: !97, file: !97, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!97 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!98 = distinct !DILocation(line: 87, column: 25, scope: !40)
!99 = !DILocation(line: 288, column: 10, scope: !100, inlinedAt: !101)
!100 = distinct !DISubprogram(name: "expf", scope: !97, file: !97, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!101 = distinct !DILocation(line: 87, column: 20, scope: !40)
!102 = !DILocation(line: 92, column: 52, scope: !40)
!103 = !DILocation(line: 92, column: 11, scope: !40)
!104 = !DILocation(line: 94, column: 7, scope: !40)
!105 = !DILocation(line: 0, scope: !40)
!106 = !DILocation(line: 92, column: 45, scope: !40)
!107 = !DILocation(line: 102, column: 34, scope: !40)
!108 = !DILocation(line: 107, column: 42, scope: !40)
!109 = !DILocation(line: 112, column: 36, scope: !40)
!110 = !DILocation(line: 112, column: 34, scope: !40)
!111 = !DILocation(line: 112, column: 9, scope: !40)
!112 = !DILocation(line: 120, column: 32, scope: !40)
!113 = !DILocation(line: 75, column: 10, scope: !114, inlinedAt: !116)
!114 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !115, file: !115, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!115 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!116 = distinct !DILocation(line: 984, column: 9, scope: !117, inlinedAt: !119)
!117 = distinct !DISubprogram(name: "__float2half", scope: !118, file: !118, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!118 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!119 = distinct !DILocation(line: 133, column: 53, scope: !120, inlinedAt: !121)
!120 = distinct !DISubprogram(name: "__half", scope: !118, file: !118, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!121 = distinct !DILocation(line: 124, column: 32, scope: !40)
!122 = !DILocation(line: 124, column: 29, scope: !40)
!123 = !DILocation(line: 68, column: 3, scope: !63, inlinedAt: !124)
!124 = distinct !DILocation(line: 192, column: 3, scope: !66, inlinedAt: !125)
!125 = distinct !DILocation(line: 126, column: 5, scope: !40)
!126 = !DILocation(line: 69, column: 3, scope: !63, inlinedAt: !124)
!127 = !DILocation(line: 70, column: 3, scope: !63, inlinedAt: !124)
!128 = !DILocation(line: 127, column: 3, scope: !40)
!129 = !DILocation(line: 133, column: 31, scope: !40)
!130 = !DILocation(line: 136, column: 120, scope: !40)
!131 = !DILocation(line: 136, column: 31, scope: !40)
!132 = !DILocation(line: 136, column: 29, scope: !40)
!133 = !{!26, !26, i64 0}
!134 = !DILocation(line: 141, column: 38, scope: !40)
!135 = !DILocation(line: 148, column: 3, scope: !40)
!136 = !DILocation(line: 151, column: 58, scope: !40)
!137 = !DILocation(line: 75, column: 10, scope: !114, inlinedAt: !138)
!138 = distinct !DILocation(line: 984, column: 9, scope: !117, inlinedAt: !139)
!139 = distinct !DILocation(line: 133, column: 53, scope: !120, inlinedAt: !140)
!140 = distinct !DILocation(line: 151, column: 50, scope: !40)
!141 = !DILocation(line: 151, column: 47, scope: !40)
!142 = !DILocation(line: 68, column: 3, scope: !63, inlinedAt: !143)
!143 = distinct !DILocation(line: 192, column: 3, scope: !66, inlinedAt: !144)
!144 = distinct !DILocation(line: 154, column: 3, scope: !40)
!145 = !DILocation(line: 69, column: 3, scope: !63, inlinedAt: !143)
!146 = !DILocation(line: 70, column: 3, scope: !63, inlinedAt: !143)
!147 = !DILocation(line: 157, column: 123, scope: !40)
!148 = !DILocation(line: 157, column: 152, scope: !40)
!149 = !DILocation(line: 157, column: 78, scope: !40)
!150 = !DILocation(line: 157, column: 158, scope: !40)
!151 = !DILocation(line: 157, column: 40, scope: !40)
!152 = !DILocation(line: 157, column: 201, scope: !40)
!153 = !DILocation(line: 157, column: 94, scope: !40)
!154 = !DILocation(line: 68, column: 3, scope: !63, inlinedAt: !155)
!155 = distinct !DILocation(line: 192, column: 3, scope: !66, inlinedAt: !156)
!156 = distinct !DILocation(line: 159, column: 3, scope: !40)
!157 = !DILocation(line: 69, column: 3, scope: !63, inlinedAt: !155)
!158 = !DILocation(line: 70, column: 3, scope: !63, inlinedAt: !155)
!159 = !DILocation(line: 161, column: 8, scope: !40)
!160 = !DILocation(line: 162, column: 251, scope: !40)
!161 = !DILocation(line: 162, column: 167, scope: !40)
!162 = !DILocation(line: 162, column: 22, scope: !40)
!163 = !DILocation(line: 162, column: 130, scope: !40)
!164 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!165 = !{i32 2, i32 -1, i32 -1, i32 -1}
!166 = !DILocation(line: 162, column: 265, scope: !40)
!167 = !DILocation(line: 164, column: 1, scope: !40)
