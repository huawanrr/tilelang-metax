; ModuleID = '/data/tilelang-metax/race_tests/nsa/experiments/20261016_goal895/validation_dispatch_r1/actual_binary/d128_b16_h1_t16_c1_m0_p0.bc'
source_filename = "/tmp/tmpo0rrkad0/tvm_kernels.maca"
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
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %BlockIndices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K_blocks.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V_blocks.coerce) local_unnamed_addr #3 !dbg !40 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul = shl nsw i32 %0, 15
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul7 = shl nsw i32 %1, 11
  %add = add nuw nsw i32 %mul, %mul7
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %and = shl nuw nsw i32 %2, 7
  %mul9 = and i32 %and, 1920
  %add10 = or disjoint i32 %add, %mul9
  %3 = lshr i32 %2, 1
  %mul14 = and i32 %3, 504
  %add12 = add nuw nsw i32 %add10, %mul14
  %4 = zext nneg i32 %add12 to i64, !dbg !43
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4, !dbg !44
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16, !dbg !45
  %Q_reg.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !45
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.4.0.add.ptr.sroa_idx, align 8, !dbg !45
  %5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4, !dbg !44
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %5, i64 64, !dbg !44
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16, !dbg !45
  %Q_reg.sroa.7.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %5, i64 72, !dbg !45
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.7.16.add.ptr.1.sroa_idx, align 8, !dbg !45
  %6 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4, !dbg !44
  %add.ptr.2 = getelementptr inbounds i8, ptr addrspace(4) %6, i64 128, !dbg !44
  %Q_reg.sroa.8.32.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.2, align 16, !dbg !45
  %Q_reg.sroa.10.32.add.ptr.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %6, i64 136, !dbg !45
  %Q_reg.sroa.10.32.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.10.32.add.ptr.2.sroa_idx, align 8, !dbg !45
  %7 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4, !dbg !44
  %add.ptr.3 = getelementptr inbounds i8, ptr addrspace(4) %7, i64 192, !dbg !44
  %Q_reg.sroa.11.48.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.3, align 16, !dbg !45
  %Q_reg.sroa.13.48.add.ptr.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %7, i64 200, !dbg !45
  %Q_reg.sroa.13.48.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.13.48.add.ptr.3.sroa_idx, align 8, !dbg !45
  %mul20 = shl nsw i32 %0, 4, !dbg !46
  %add22 = add nuw nsw i32 %mul20, %1, !dbg !47
  %idxprom = zext nneg i32 %add22 to i64, !dbg !48
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom, !dbg !48
  %8 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !48, !tbaa !30
  %cmp37 = icmp eq i32 %8, 0
  br i1 %cmp37, label %for.cond42.preheader, label %if.end341, !dbg !49

for.cond42.preheader:                             ; preds = %entry
  %mul52 = shl nsw i32 %0, 11
  %mul58 = shl nuw nsw i32 %2, 3
  %add56 = add nuw nsw i32 %mul58, %mul52
  %9 = zext nneg i32 %add56 to i64, !dbg !50
  %add.ptr63 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %9, !dbg !51
  %10 = load i32, ptr addrspace(4) %add.ptr63, align 4, !dbg !52, !tbaa !30
  %11 = or disjoint i64 %9, 2, !dbg !53
  %add.ptr63.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %11, !dbg !51
  %12 = load i32, ptr addrspace(4) %add.ptr63.1, align 4, !dbg !52, !tbaa !30
  %13 = or disjoint i64 %9, 4, !dbg !53
  %add.ptr63.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %13, !dbg !51
  %14 = load i32, ptr addrspace(4) %add.ptr63.2, align 4, !dbg !52, !tbaa !30
  %15 = or disjoint i64 %9, 6, !dbg !53
  %add.ptr63.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %15, !dbg !51
  %16 = load i32, ptr addrspace(4) %add.ptr63.3, align 4, !dbg !52, !tbaa !30
  %17 = add nuw nsw i64 %9, 512
  %add.ptr63.1522 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %17, !dbg !51
  %18 = load i32, ptr addrspace(4) %add.ptr63.1522, align 4, !dbg !52, !tbaa !30
  %19 = add nuw nsw i64 %9, 514, !dbg !53
  %add.ptr63.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %19, !dbg !51
  %20 = load i32, ptr addrspace(4) %add.ptr63.1.1, align 4, !dbg !52, !tbaa !30
  %21 = add nuw nsw i64 %9, 516, !dbg !53
  %add.ptr63.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %21, !dbg !51
  %22 = load i32, ptr addrspace(4) %add.ptr63.2.1, align 4, !dbg !52, !tbaa !30
  %23 = add nuw nsw i64 %9, 518, !dbg !53
  %add.ptr63.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %23, !dbg !51
  %24 = load i32, ptr addrspace(4) %add.ptr63.3.1, align 4, !dbg !52, !tbaa !30
  %25 = add nuw nsw i64 %9, 1024
  %add.ptr63.2524 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %25, !dbg !51
  %26 = load i32, ptr addrspace(4) %add.ptr63.2524, align 4, !dbg !52, !tbaa !30
  %27 = add nuw nsw i64 %9, 1026, !dbg !53
  %add.ptr63.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %27, !dbg !51
  %28 = load i32, ptr addrspace(4) %add.ptr63.1.2, align 4, !dbg !52, !tbaa !30
  %29 = add nuw nsw i64 %9, 1028, !dbg !53
  %add.ptr63.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %29, !dbg !51
  %30 = load i32, ptr addrspace(4) %add.ptr63.2.2, align 4, !dbg !52, !tbaa !30
  %31 = add nuw nsw i64 %9, 1030, !dbg !53
  %add.ptr63.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %31, !dbg !51
  %32 = load i32, ptr addrspace(4) %add.ptr63.3.2, align 4, !dbg !52, !tbaa !30
  %33 = add nuw nsw i64 %9, 1536
  %add.ptr63.3526 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %33, !dbg !51
  %34 = load i32, ptr addrspace(4) %add.ptr63.3526, align 4, !dbg !52, !tbaa !30
  %35 = add nuw nsw i64 %9, 1538, !dbg !53
  %add.ptr63.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %35, !dbg !51
  %36 = load i32, ptr addrspace(4) %add.ptr63.1.3, align 4, !dbg !52, !tbaa !30
  %37 = add nuw nsw i64 %9, 1540, !dbg !53
  %add.ptr63.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %37, !dbg !51
  %38 = load i32, ptr addrspace(4) %add.ptr63.2.3, align 4, !dbg !52, !tbaa !30
  %39 = add nuw nsw i64 %9, 1542, !dbg !53
  %add.ptr63.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %39, !dbg !51
  %40 = load i32, ptr addrspace(4) %add.ptr63.3.3, align 4, !dbg !52, !tbaa !30
  %add.ptr96 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %9, !dbg !54
  %41 = load i32, ptr addrspace(4) %add.ptr96, align 4, !dbg !55, !tbaa !30
  %add.ptr96.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %11, !dbg !54
  %42 = load i32, ptr addrspace(4) %add.ptr96.1, align 4, !dbg !55, !tbaa !30
  %add.ptr96.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %13, !dbg !54
  %43 = load i32, ptr addrspace(4) %add.ptr96.2, align 4, !dbg !55, !tbaa !30
  %add.ptr96.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %15, !dbg !54
  %44 = load i32, ptr addrspace(4) %add.ptr96.3, align 4, !dbg !55, !tbaa !30
  %add.ptr96.1538 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %17, !dbg !54
  %45 = load i32, ptr addrspace(4) %add.ptr96.1538, align 4, !dbg !55, !tbaa !30
  %add.ptr96.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %19, !dbg !54
  %46 = load i32, ptr addrspace(4) %add.ptr96.1.1, align 4, !dbg !55, !tbaa !30
  %add.ptr96.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %21, !dbg !54
  %47 = load i32, ptr addrspace(4) %add.ptr96.2.1, align 4, !dbg !55, !tbaa !30
  %add.ptr96.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %23, !dbg !54
  %48 = load i32, ptr addrspace(4) %add.ptr96.3.1, align 4, !dbg !55, !tbaa !30
  %add.ptr96.2540 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %25, !dbg !54
  %49 = load i32, ptr addrspace(4) %add.ptr96.2540, align 4, !dbg !55, !tbaa !30
  %add.ptr96.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %27, !dbg !54
  %50 = load i32, ptr addrspace(4) %add.ptr96.1.2, align 4, !dbg !55, !tbaa !30
  %add.ptr96.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %29, !dbg !54
  %51 = load i32, ptr addrspace(4) %add.ptr96.2.2, align 4, !dbg !55, !tbaa !30
  %add.ptr96.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %31, !dbg !54
  %52 = load i32, ptr addrspace(4) %add.ptr96.3.2, align 4, !dbg !55, !tbaa !30
  %add.ptr96.3542 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %33, !dbg !54
  %53 = load i32, ptr addrspace(4) %add.ptr96.3542, align 4, !dbg !55, !tbaa !30
  %add.ptr96.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %35, !dbg !54
  %54 = load i32, ptr addrspace(4) %add.ptr96.1.3, align 4, !dbg !55, !tbaa !30
  %add.ptr96.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %37, !dbg !54
  %55 = load i32, ptr addrspace(4) %add.ptr96.2.3, align 4, !dbg !55, !tbaa !30
  %add.ptr96.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %39, !dbg !54
  %56 = load i32, ptr addrspace(4) %add.ptr96.3.3, align 4, !dbg !55, !tbaa !30
  %mul120 = and i32 %mul58, 8064
  %and123 = and i32 %2, 15
  %shr126 = lshr i32 %2, 4
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @V_shared, i32 %mul120, !dbg !56
  %xor = xor i32 %shr126, %and123, !dbg !57
  %add.ptr131.idx = shl nuw nsw i32 %xor, 4, !dbg !58
  %add.ptr131 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 %add.ptr131.idx, !dbg !58
  store i32 %10, ptr addrspace(3) %add.ptr131, align 16, !dbg !59, !tbaa !30
  %K_reg.sroa.4.0.add.ptr131.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr131, i32 4, !dbg !59
  store i32 %12, ptr addrspace(3) %K_reg.sroa.4.0.add.ptr131.sroa_idx, align 4, !dbg !59, !tbaa !30
  %K_reg.sroa.5.0.add.ptr131.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr131, i32 8, !dbg !59
  store i32 %14, ptr addrspace(3) %K_reg.sroa.5.0.add.ptr131.sroa_idx, align 8, !dbg !59, !tbaa !30
  %K_reg.sroa.6.0.add.ptr131.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr131, i32 12, !dbg !59
  store i32 %16, ptr addrspace(3) %K_reg.sroa.6.0.add.ptr131.sroa_idx, align 4, !dbg !59, !tbaa !30
  %add127.1 = add nuw nsw i32 %shr126, 4, !dbg !60
  %xor.1 = xor i32 %add127.1, %and123, !dbg !57
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1024, !dbg !58
  %add.ptr131.idx.1 = shl nuw nsw i32 %xor.1, 4, !dbg !58
  %add.ptr131.1 = getelementptr inbounds i8, ptr addrspace(3) %gep.1, i32 %add.ptr131.idx.1, !dbg !58
  store i32 %18, ptr addrspace(3) %add.ptr131.1, align 16, !dbg !59, !tbaa !30
  %K_reg.sroa.9.16.add.ptr131.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr131.1, i32 4, !dbg !59
  store i32 %20, ptr addrspace(3) %K_reg.sroa.9.16.add.ptr131.1.sroa_idx, align 4, !dbg !59, !tbaa !30
  %K_reg.sroa.10.16.add.ptr131.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr131.1, i32 8, !dbg !59
  store i32 %22, ptr addrspace(3) %K_reg.sroa.10.16.add.ptr131.1.sroa_idx, align 8, !dbg !59, !tbaa !30
  %K_reg.sroa.11.16.add.ptr131.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr131.1, i32 12, !dbg !59
  store i32 %24, ptr addrspace(3) %K_reg.sroa.11.16.add.ptr131.1.sroa_idx, align 4, !dbg !59, !tbaa !30
  %add127.2 = add nuw nsw i32 %shr126, 8, !dbg !60
  %xor.2 = xor i32 %add127.2, %and123, !dbg !57
  %gep.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 2048, !dbg !58
  %add.ptr131.idx.2 = shl nuw nsw i32 %xor.2, 4, !dbg !58
  %add.ptr131.2 = getelementptr inbounds i8, ptr addrspace(3) %gep.2, i32 %add.ptr131.idx.2, !dbg !58
  store i32 %26, ptr addrspace(3) %add.ptr131.2, align 16, !dbg !59, !tbaa !30
  %K_reg.sroa.14.32.add.ptr131.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr131.2, i32 4, !dbg !59
  store i32 %28, ptr addrspace(3) %K_reg.sroa.14.32.add.ptr131.2.sroa_idx, align 4, !dbg !59, !tbaa !30
  %K_reg.sroa.15.32.add.ptr131.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr131.2, i32 8, !dbg !59
  store i32 %30, ptr addrspace(3) %K_reg.sroa.15.32.add.ptr131.2.sroa_idx, align 8, !dbg !59, !tbaa !30
  %K_reg.sroa.16.32.add.ptr131.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr131.2, i32 12, !dbg !59
  store i32 %32, ptr addrspace(3) %K_reg.sroa.16.32.add.ptr131.2.sroa_idx, align 4, !dbg !59, !tbaa !30
  %add127.3 = add nuw nsw i32 %shr126, 12, !dbg !60
  %xor.3 = xor i32 %add127.3, %and123, !dbg !57
  %gep.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 3072, !dbg !58
  %add.ptr131.idx.3 = shl nuw nsw i32 %xor.3, 4, !dbg !58
  %add.ptr131.3 = getelementptr inbounds i8, ptr addrspace(3) %gep.3, i32 %add.ptr131.idx.3, !dbg !58
  store i32 %34, ptr addrspace(3) %add.ptr131.3, align 16, !dbg !59, !tbaa !30
  %K_reg.sroa.19.48.add.ptr131.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr131.3, i32 4, !dbg !59
  store i32 %36, ptr addrspace(3) %K_reg.sroa.19.48.add.ptr131.3.sroa_idx, align 4, !dbg !59, !tbaa !30
  %K_reg.sroa.20.48.add.ptr131.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr131.3, i32 8, !dbg !59
  store i32 %38, ptr addrspace(3) %K_reg.sroa.20.48.add.ptr131.3.sroa_idx, align 8, !dbg !59, !tbaa !30
  %K_reg.sroa.21.48.add.ptr131.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr131.3, i32 12, !dbg !59
  store i32 %40, ptr addrspace(3) %K_reg.sroa.21.48.add.ptr131.3.sroa_idx, align 4, !dbg !59, !tbaa !30
  %cmp138 = icmp ult i32 %1, 15, !dbg !61
  br i1 %cmp138, label %for.cond140.preheader, label %if.end164, !dbg !62

for.cond140.preheader:                            ; preds = %for.cond42.preheader
  %57 = lshr i32 %2, 2
  %mul146 = and i32 %57, 252
  %cmp151.not = icmp ugt i32 %mul146, %1, !dbg !63
  %spec.select = select i1 %cmp151.not, float 0xFFF0000000000000, float 0.000000e+00, !dbg !64
  %acc_s.sroa.0.0.vec.insert591 = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !65
  %cmp151.not.1.not = icmp ult i32 %mul146, %1, !dbg !63
  %spec.select.1 = select i1 %cmp151.not.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !64
  %acc_s.sroa.0.4.vec.insert604 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert591, float %spec.select.1, i64 1, !dbg !65
  %add149.2 = or disjoint i32 %mul146, 2, !dbg !66
  %cmp151.not.2 = icmp ugt i32 %add149.2, %1, !dbg !63
  %spec.select.2 = select i1 %cmp151.not.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !64
  %acc_s.sroa.0.8.vec.insert617 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert604, float %spec.select.2, i64 2, !dbg !65
  %add149.3 = or i32 %57, 3, !dbg !66
  %cmp151.not.3 = icmp ugt i32 %add149.3, %1, !dbg !63
  %spec.select.3 = select i1 %cmp151.not.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !64
  %acc_s.sroa.0.12.vec.insert630 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert617, float %spec.select.3, i64 3, !dbg !65
  br label %if.end164, !dbg !67

if.end164:                                        ; preds = %for.cond42.preheader, %for.cond140.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert630, %for.cond140.preheader ], [ zeroinitializer, %for.cond42.preheader ], !dbg !73
  fence syncscope("warp") release, !dbg !67
  tail call void @llvm.mxc.barrier.warp(), !dbg !74
  fence syncscope("warp") acquire, !dbg !75
  %58 = getelementptr inbounds %struct.__half, ptr addrspace(3) @V_shared, i32 %mul9
  %add.ptr182 = getelementptr inbounds i8, ptr addrspace(3) %58, i32 %add.ptr131.idx, !dbg !76
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr182, align 16, !dbg !77
  %kb.sroa.10.0.add.ptr182.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr182, i32 8, !dbg !77
  %kb.sroa.10.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr182.sroa_idx, align 8, !dbg !77
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !dbg !78, !call_argsrelate !79
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %59), !dbg !78, !call_argsrelate !79
  %add.ptr182.1 = getelementptr inbounds i8, ptr addrspace(3) %58, i32 %add.ptr131.idx.1, !dbg !76
  %kb.sroa.0.0.copyload579 = load <4 x half>, ptr addrspace(3) %add.ptr182.1, align 16, !dbg !77
  %kb.sroa.10.0.add.ptr182.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr182.1, i32 8, !dbg !77
  %kb.sroa.10.0.copyload582 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr182.1.sroa_idx, align 8, !dbg !77
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload579, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %60), !dbg !78, !call_argsrelate !79
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload582, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %61), !dbg !78, !call_argsrelate !79
  %add.ptr182.2 = getelementptr inbounds i8, ptr addrspace(3) %58, i32 %add.ptr131.idx.2, !dbg !76
  %kb.sroa.0.0.copyload580 = load <4 x half>, ptr addrspace(3) %add.ptr182.2, align 16, !dbg !77
  %kb.sroa.10.0.add.ptr182.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr182.2, i32 8, !dbg !77
  %kb.sroa.10.0.copyload583 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr182.2.sroa_idx, align 8, !dbg !77
  %63 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload580, <4 x half> %Q_reg.sroa.8.32.copyload, <4 x float> %62), !dbg !78, !call_argsrelate !79
  %64 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload583, <4 x half> %Q_reg.sroa.10.32.copyload, <4 x float> %63), !dbg !78, !call_argsrelate !79
  %add.ptr182.3 = getelementptr inbounds i8, ptr addrspace(3) %58, i32 %add.ptr131.idx.3, !dbg !76
  %kb.sroa.0.0.copyload581 = load <4 x half>, ptr addrspace(3) %add.ptr182.3, align 16, !dbg !77
  %kb.sroa.10.0.add.ptr182.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr182.3, i32 8, !dbg !77
  %kb.sroa.10.0.copyload584 = load <4 x half>, ptr addrspace(3) %kb.sroa.10.0.add.ptr182.3.sroa_idx, align 8, !dbg !77
  %65 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload581, <4 x half> %Q_reg.sroa.11.48.copyload, <4 x float> %64), !dbg !78, !call_argsrelate !79
  %66 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload584, <4 x half> %Q_reg.sroa.13.48.copyload, <4 x float> %65), !dbg !78, !call_argsrelate !79
  fence syncscope("warp") release, !dbg !80
  tail call void @llvm.mxc.barrier.warp(), !dbg !83
  fence syncscope("warp") acquire, !dbg !84
  %add.ptr220.idx = shl nuw nsw i32 %2, 4
  %invariant.gep494 = getelementptr inbounds i8, ptr addrspace(3) @V_shared, i32 %add.ptr220.idx, !dbg !85
  store i32 %41, ptr addrspace(3) %invariant.gep494, align 16, !dbg !86, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep494.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep494, i32 4, !dbg !86
  store i32 %42, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep494.sroa_idx, align 4, !dbg !86, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep494.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep494, i32 8, !dbg !86
  store i32 %43, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep494.sroa_idx, align 8, !dbg !86, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep494.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep494, i32 12, !dbg !86
  store i32 %44, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep494.sroa_idx, align 4, !dbg !86, !tbaa !30
  %gep495.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep494, i32 1024, !dbg !87
  store i32 %45, ptr addrspace(3) %gep495.1, align 16, !dbg !86, !tbaa !30
  %V_reg.sroa.9.16.gep495.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep494, i32 1028, !dbg !86
  store i32 %46, ptr addrspace(3) %V_reg.sroa.9.16.gep495.1.sroa_idx, align 4, !dbg !86, !tbaa !30
  %V_reg.sroa.10.16.gep495.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep494, i32 1032, !dbg !86
  store i32 %47, ptr addrspace(3) %V_reg.sroa.10.16.gep495.1.sroa_idx, align 8, !dbg !86, !tbaa !30
  %V_reg.sroa.11.16.gep495.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep494, i32 1036, !dbg !86
  store i32 %48, ptr addrspace(3) %V_reg.sroa.11.16.gep495.1.sroa_idx, align 4, !dbg !86, !tbaa !30
  %gep495.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep494, i32 2048, !dbg !87
  store i32 %49, ptr addrspace(3) %gep495.2, align 16, !dbg !86, !tbaa !30
  %V_reg.sroa.14.32.gep495.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep494, i32 2052, !dbg !86
  store i32 %50, ptr addrspace(3) %V_reg.sroa.14.32.gep495.2.sroa_idx, align 4, !dbg !86, !tbaa !30
  %V_reg.sroa.15.32.gep495.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep494, i32 2056, !dbg !86
  store i32 %51, ptr addrspace(3) %V_reg.sroa.15.32.gep495.2.sroa_idx, align 8, !dbg !86, !tbaa !30
  %V_reg.sroa.16.32.gep495.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep494, i32 2060, !dbg !86
  store i32 %52, ptr addrspace(3) %V_reg.sroa.16.32.gep495.2.sroa_idx, align 4, !dbg !86, !tbaa !30
  %gep495.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep494, i32 3072, !dbg !87
  store i32 %53, ptr addrspace(3) %gep495.3, align 16, !dbg !86, !tbaa !30
  %V_reg.sroa.19.48.gep495.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep494, i32 3076, !dbg !86
  store i32 %54, ptr addrspace(3) %V_reg.sroa.19.48.gep495.3.sroa_idx, align 4, !dbg !86, !tbaa !30
  %V_reg.sroa.20.48.gep495.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep494, i32 3080, !dbg !86
  store i32 %55, ptr addrspace(3) %V_reg.sroa.20.48.gep495.3.sroa_idx, align 8, !dbg !86, !tbaa !30
  %V_reg.sroa.21.48.gep495.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep494, i32 3084, !dbg !86
  store i32 %56, ptr addrspace(3) %V_reg.sroa.21.48.gep495.3.sroa_idx, align 4, !dbg !86, !tbaa !30
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %66, i64 0, !dbg !88
  %mul230 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !89
  %67 = tail call contract noundef float @llvm.minnum.f32(float %mul230, float 0x4024CB5EC0000000), !dbg !90
  %68 = tail call contract noundef float @llvm.exp.f32(float %67), !dbg !94
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %66, i64 1, !dbg !88
  %mul230.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !89
  %69 = tail call contract noundef float @llvm.minnum.f32(float %mul230.1, float 0x4024CB5EC0000000), !dbg !90
  %70 = tail call contract noundef float @llvm.exp.f32(float %69), !dbg !94
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %66, i64 2, !dbg !88
  %mul230.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !89
  %71 = tail call contract noundef float @llvm.minnum.f32(float %mul230.2, float 0x4024CB5EC0000000), !dbg !90
  %72 = tail call contract noundef float @llvm.exp.f32(float %71), !dbg !94
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %66, i64 3, !dbg !88
  %mul230.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !89
  %73 = tail call contract noundef float @llvm.minnum.f32(float %mul230.3, float 0x4024CB5EC0000000), !dbg !90
  %74 = tail call contract noundef float @llvm.exp.f32(float %73), !dbg !94
  %add246.1 = fadd contract float %68, %70, !dbg !97
  %add246.2 = fadd contract float %add246.1, %72, !dbg !97
  %add246.3 = fadd contract float %add246.2, %74, !dbg !97
  %75 = bitcast float %add246.3 to i32, !dbg !98
  %76 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10, !dbg !101
  %77 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %76) #10, !dbg !106
  %xor.i.i = xor i32 %77, 32, !dbg !107
  %78 = and i32 %77, -64, !dbg !108
  %and.i.i = add nsw i32 %78, 64, !dbg !108
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !109
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %77, !dbg !110
  %shl.i.i = shl i32 %cond.i.i, 2, !dbg !111
  %79 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %75), !dbg !112
  %80 = bitcast i32 %79 to float, !dbg !113
  %add254 = fadd contract float %add246.3, %80, !dbg !114
  %81 = bitcast float %add254 to i32, !dbg !115
  %82 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #10, !dbg !117
  %83 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %82) #10, !dbg !120
  %xor.i.i475 = xor i32 %83, 16, !dbg !121
  %84 = and i32 %83, -64, !dbg !122
  %and.i.i476 = add nsw i32 %84, 64, !dbg !122
  %cmp.not.i.i477 = icmp slt i32 %xor.i.i475, %and.i.i476, !dbg !123
  %cond.i.i478 = select i1 %cmp.not.i.i477, i32 %xor.i.i475, i32 %83, !dbg !124
  %shl.i.i479 = shl i32 %cond.i.i478, 2, !dbg !125
  %85 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i479, i32 %81), !dbg !126
  %86 = bitcast i32 %85 to float, !dbg !127
  %add259 = fadd contract float %add254, %86, !dbg !128
  %cmp262 = fcmp contract ogt float %add259, 0.000000e+00, !dbg !129
  %div = fdiv contract float 1.000000e+00, %add259, !dbg !130
  %condval_1.0 = select i1 %cmp262, float %div, float 0.000000e+00, !dbg !130
  %mul275 = fmul contract float %condval_1.0, %68, !dbg !131
  %mul275.1 = fmul contract float %condval_1.0, %70, !dbg !131
  %mul275.2 = fmul contract float %condval_1.0, %72, !dbg !131
  %mul275.3 = fmul contract float %condval_1.0, %74, !dbg !131
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul275), !dbg !132
  %88 = insertelement <4 x i16> poison, i16 %87, i64 0, !dbg !141
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul275.1), !dbg !132
  %90 = insertelement <4 x i16> %88, i16 %89, i64 1, !dbg !141
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul275.2), !dbg !132
  %92 = insertelement <4 x i16> %90, i16 %91, i64 2, !dbg !141
  %93 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul275.3), !dbg !132
  %94 = insertelement <4 x i16> %92, i16 %93, i64 3, !dbg !141
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %94 to <4 x half>, !dbg !141
  fence syncscope("warp") release, !dbg !142
  tail call void @llvm.mxc.barrier.warp(), !dbg !145
  fence syncscope("warp") acquire, !dbg !146
  %95 = shl nuw nsw i32 %2, 5
  %mul303 = and i32 %95, 32256
  %add310 = or disjoint i32 %mul303, %and123, !dbg !147
  %arrayidx312 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310, !dbg !148
  %96 = load half, ptr addrspace(3) %arrayidx312, align 2, !dbg !149, !tbaa !150
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %96, i64 0, !dbg !149
  %add305.1 = or disjoint i32 %mul303, %and123, !dbg !147
  %add310.1 = or disjoint i32 %add305.1, 128, !dbg !147
  %arrayidx312.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.1, !dbg !148
  %97 = load half, ptr addrspace(3) %arrayidx312.1, align 2, !dbg !149, !tbaa !150
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %97, i64 1, !dbg !149
  %add305.2 = or disjoint i32 %mul303, %and123, !dbg !147
  %add310.2 = or disjoint i32 %add305.2, 256, !dbg !147
  %arrayidx312.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.2, !dbg !148
  %98 = load half, ptr addrspace(3) %arrayidx312.2, align 2, !dbg !149, !tbaa !150
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %98, i64 2, !dbg !149
  %add305.3 = or disjoint i32 %mul303, %and123, !dbg !147
  %add310.3 = or disjoint i32 %add305.3, 384, !dbg !147
  %arrayidx312.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.3, !dbg !148
  %99 = load half, ptr addrspace(3) %arrayidx312.3, align 2, !dbg !149, !tbaa !150
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %99, i64 3, !dbg !149
  %add307.1546 = or disjoint i32 %mul303, %and123, !dbg !147
  %add310.1547 = or disjoint i32 %add307.1546, 16, !dbg !147
  %arrayidx312.1548 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.1547, !dbg !148
  %100 = load half, ptr addrspace(3) %arrayidx312.1548, align 2, !dbg !149, !tbaa !150
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %100, i64 0, !dbg !149
  %add307.1.1 = or disjoint i32 %mul303, %and123, !dbg !147
  %add310.1.1 = or disjoint i32 %add307.1.1, 144, !dbg !147
  %arrayidx312.1.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.1.1, !dbg !148
  %101 = load half, ptr addrspace(3) %arrayidx312.1.1, align 2, !dbg !149, !tbaa !150
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %101, i64 1, !dbg !149
  %add307.2.1 = or disjoint i32 %mul303, %and123, !dbg !147
  %add310.2.1 = or disjoint i32 %add307.2.1, 272, !dbg !147
  %arrayidx312.2.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.2.1, !dbg !148
  %102 = load half, ptr addrspace(3) %arrayidx312.2.1, align 2, !dbg !149, !tbaa !150
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %102, i64 2, !dbg !149
  %add307.3.1 = or disjoint i32 %mul303, %and123, !dbg !147
  %add310.3.1 = or disjoint i32 %add307.3.1, 400, !dbg !147
  %arrayidx312.3.1 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.3.1, !dbg !148
  %103 = load half, ptr addrspace(3) %arrayidx312.3.1, align 2, !dbg !149, !tbaa !150
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %103, i64 3, !dbg !149
  %add307.2550 = or disjoint i32 %mul303, %and123, !dbg !147
  %add310.2551 = or disjoint i32 %add307.2550, 32, !dbg !147
  %arrayidx312.2552 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.2551, !dbg !148
  %104 = load half, ptr addrspace(3) %arrayidx312.2552, align 2, !dbg !149, !tbaa !150
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %104, i64 0, !dbg !149
  %add307.1.2 = or disjoint i32 %mul303, %and123, !dbg !147
  %add310.1.2 = or disjoint i32 %add307.1.2, 160, !dbg !147
  %arrayidx312.1.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.1.2, !dbg !148
  %105 = load half, ptr addrspace(3) %arrayidx312.1.2, align 2, !dbg !149, !tbaa !150
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %105, i64 1, !dbg !149
  %add307.2.2 = or disjoint i32 %mul303, %and123, !dbg !147
  %add310.2.2 = or disjoint i32 %add307.2.2, 288, !dbg !147
  %arrayidx312.2.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.2.2, !dbg !148
  %106 = load half, ptr addrspace(3) %arrayidx312.2.2, align 2, !dbg !149, !tbaa !150
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %106, i64 2, !dbg !149
  %add307.3.2 = or disjoint i32 %mul303, %and123, !dbg !147
  %add310.3.2 = or disjoint i32 %add307.3.2, 416, !dbg !147
  %arrayidx312.3.2 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.3.2, !dbg !148
  %107 = load half, ptr addrspace(3) %arrayidx312.3.2, align 2, !dbg !149, !tbaa !150
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %107, i64 3, !dbg !149
  %add307.3554 = or disjoint i32 %mul303, %and123, !dbg !147
  %add310.3555 = or disjoint i32 %add307.3554, 48, !dbg !147
  %arrayidx312.3556 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.3555, !dbg !148
  %108 = load half, ptr addrspace(3) %arrayidx312.3556, align 2, !dbg !149, !tbaa !150
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %108, i64 0, !dbg !149
  %add307.1.3 = or disjoint i32 %mul303, %and123, !dbg !147
  %add310.1.3 = or disjoint i32 %add307.1.3, 176, !dbg !147
  %arrayidx312.1.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.1.3, !dbg !148
  %109 = load half, ptr addrspace(3) %arrayidx312.1.3, align 2, !dbg !149, !tbaa !150
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %109, i64 1, !dbg !149
  %add307.2.3 = or disjoint i32 %mul303, %and123, !dbg !147
  %add310.2.3 = or disjoint i32 %add307.2.3, 304, !dbg !147
  %arrayidx312.2.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.2.3, !dbg !148
  %110 = load half, ptr addrspace(3) %arrayidx312.2.3, align 2, !dbg !149, !tbaa !150
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %110, i64 2, !dbg !149
  %add307.3.3 = or disjoint i32 %mul303, %and123, !dbg !147
  %add310.3.3 = or disjoint i32 %add307.3.3, 432, !dbg !147
  %arrayidx312.3.3 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.3.3, !dbg !148
  %111 = load half, ptr addrspace(3) %arrayidx312.3.3, align 2, !dbg !149, !tbaa !150
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %111, i64 3, !dbg !149
  %add307.4 = or disjoint i32 %mul303, %and123, !dbg !147
  %add310.4 = or disjoint i32 %add307.4, 64, !dbg !147
  %arrayidx312.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.4, !dbg !148
  %112 = load half, ptr addrspace(3) %arrayidx312.4, align 2, !dbg !149, !tbaa !150
  %vb.sroa.22.32.vec.insert = insertelement <4 x half> poison, half %112, i64 0, !dbg !149
  %add307.1.4 = or disjoint i32 %mul303, %and123, !dbg !147
  %add310.1.4 = or disjoint i32 %add307.1.4, 192, !dbg !147
  %arrayidx312.1.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.1.4, !dbg !148
  %113 = load half, ptr addrspace(3) %arrayidx312.1.4, align 2, !dbg !149, !tbaa !150
  %vb.sroa.22.34.vec.insert = insertelement <4 x half> %vb.sroa.22.32.vec.insert, half %113, i64 1, !dbg !149
  %add307.2.4 = or disjoint i32 %mul303, %and123, !dbg !147
  %add310.2.4 = or disjoint i32 %add307.2.4, 320, !dbg !147
  %arrayidx312.2.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.2.4, !dbg !148
  %114 = load half, ptr addrspace(3) %arrayidx312.2.4, align 2, !dbg !149, !tbaa !150
  %vb.sroa.22.36.vec.insert = insertelement <4 x half> %vb.sroa.22.34.vec.insert, half %114, i64 2, !dbg !149
  %add307.3.4 = or disjoint i32 %mul303, %and123, !dbg !147
  %add310.3.4 = or disjoint i32 %add307.3.4, 448, !dbg !147
  %arrayidx312.3.4 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.3.4, !dbg !148
  %115 = load half, ptr addrspace(3) %arrayidx312.3.4, align 2, !dbg !149, !tbaa !150
  %vb.sroa.22.38.vec.insert = insertelement <4 x half> %vb.sroa.22.36.vec.insert, half %115, i64 3, !dbg !149
  %add307.5 = or disjoint i32 %mul303, %and123, !dbg !147
  %add310.5 = or disjoint i32 %add307.5, 80, !dbg !147
  %arrayidx312.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.5, !dbg !148
  %116 = load half, ptr addrspace(3) %arrayidx312.5, align 2, !dbg !149, !tbaa !150
  %vb.sroa.27.40.vec.insert = insertelement <4 x half> poison, half %116, i64 0, !dbg !149
  %add307.1.5 = or disjoint i32 %mul303, %and123, !dbg !147
  %add310.1.5 = or disjoint i32 %add307.1.5, 208, !dbg !147
  %arrayidx312.1.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.1.5, !dbg !148
  %117 = load half, ptr addrspace(3) %arrayidx312.1.5, align 2, !dbg !149, !tbaa !150
  %vb.sroa.27.42.vec.insert = insertelement <4 x half> %vb.sroa.27.40.vec.insert, half %117, i64 1, !dbg !149
  %add307.2.5 = or disjoint i32 %mul303, %and123, !dbg !147
  %add310.2.5 = or disjoint i32 %add307.2.5, 336, !dbg !147
  %arrayidx312.2.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.2.5, !dbg !148
  %118 = load half, ptr addrspace(3) %arrayidx312.2.5, align 2, !dbg !149, !tbaa !150
  %vb.sroa.27.44.vec.insert = insertelement <4 x half> %vb.sroa.27.42.vec.insert, half %118, i64 2, !dbg !149
  %add307.3.5 = or disjoint i32 %mul303, %and123, !dbg !147
  %add310.3.5 = or disjoint i32 %add307.3.5, 464, !dbg !147
  %arrayidx312.3.5 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.3.5, !dbg !148
  %119 = load half, ptr addrspace(3) %arrayidx312.3.5, align 2, !dbg !149, !tbaa !150
  %vb.sroa.27.46.vec.insert = insertelement <4 x half> %vb.sroa.27.44.vec.insert, half %119, i64 3, !dbg !149
  %add307.6 = or disjoint i32 %mul303, %and123, !dbg !147
  %add310.6 = or disjoint i32 %add307.6, 96, !dbg !147
  %arrayidx312.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.6, !dbg !148
  %120 = load half, ptr addrspace(3) %arrayidx312.6, align 2, !dbg !149, !tbaa !150
  %vb.sroa.32.48.vec.insert = insertelement <4 x half> poison, half %120, i64 0, !dbg !149
  %add307.1.6 = or disjoint i32 %mul303, %and123, !dbg !147
  %add310.1.6 = or disjoint i32 %add307.1.6, 224, !dbg !147
  %arrayidx312.1.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.1.6, !dbg !148
  %121 = load half, ptr addrspace(3) %arrayidx312.1.6, align 2, !dbg !149, !tbaa !150
  %vb.sroa.32.50.vec.insert = insertelement <4 x half> %vb.sroa.32.48.vec.insert, half %121, i64 1, !dbg !149
  %add307.2.6 = or disjoint i32 %mul303, %and123, !dbg !147
  %add310.2.6 = or disjoint i32 %add307.2.6, 352, !dbg !147
  %arrayidx312.2.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.2.6, !dbg !148
  %122 = load half, ptr addrspace(3) %arrayidx312.2.6, align 2, !dbg !149, !tbaa !150
  %vb.sroa.32.52.vec.insert = insertelement <4 x half> %vb.sroa.32.50.vec.insert, half %122, i64 2, !dbg !149
  %add307.3.6 = or disjoint i32 %95, %and123, !dbg !147
  %add310.3.6 = or i32 %add307.3.6, 480, !dbg !147
  %arrayidx312.3.6 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.3.6, !dbg !148
  %123 = load half, ptr addrspace(3) %arrayidx312.3.6, align 2, !dbg !149, !tbaa !150
  %vb.sroa.32.54.vec.insert = insertelement <4 x half> %vb.sroa.32.52.vec.insert, half %123, i64 3, !dbg !149
  %add307.7 = or disjoint i32 %mul303, %and123, !dbg !147
  %add310.7 = or disjoint i32 %add307.7, 112, !dbg !147
  %arrayidx312.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.7, !dbg !148
  %124 = load half, ptr addrspace(3) %arrayidx312.7, align 2, !dbg !149, !tbaa !150
  %vb.sroa.37.56.vec.insert = insertelement <4 x half> poison, half %124, i64 0, !dbg !149
  %add307.1.7 = or disjoint i32 %mul303, %and123, !dbg !147
  %add310.1.7 = or disjoint i32 %add307.1.7, 240, !dbg !147
  %arrayidx312.1.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.1.7, !dbg !148
  %125 = load half, ptr addrspace(3) %arrayidx312.1.7, align 2, !dbg !149, !tbaa !150
  %vb.sroa.37.58.vec.insert = insertelement <4 x half> %vb.sroa.37.56.vec.insert, half %125, i64 1, !dbg !149
  %add307.2.7 = or disjoint i32 %mul303, %and123, !dbg !147
  %add310.2.7 = or disjoint i32 %add307.2.7, 368, !dbg !147
  %arrayidx312.2.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.2.7, !dbg !148
  %126 = load half, ptr addrspace(3) %arrayidx312.2.7, align 2, !dbg !149, !tbaa !150
  %vb.sroa.37.60.vec.insert = insertelement <4 x half> %vb.sroa.37.58.vec.insert, half %126, i64 2, !dbg !149
  %add307.3.7 = or disjoint i32 %95, %and123, !dbg !147
  %add310.3.7 = or i32 %add307.3.7, 496, !dbg !147
  %arrayidx312.3.7 = getelementptr inbounds [0 x %struct.__half], ptr addrspace(3) @V_shared, i32 0, i32 %add310.3.7, !dbg !148
  %127 = load half, ptr addrspace(3) %arrayidx312.3.7, align 2, !dbg !149, !tbaa !150
  %vb.sroa.37.62.vec.insert = insertelement <4 x half> %vb.sroa.37.60.vec.insert, half %127, i64 3, !dbg !149
  %128 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !151
  %129 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !151
  %130 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !151
  %131 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !151
  %132 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.38.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !151
  %133 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.27.46.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !151
  %134 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.54.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !151
  %135 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.37.62.vec.insert, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !151
  br label %if.end341, !dbg !152

if.end341:                                        ; preds = %if.end164, %entry
  %acc_o.sroa.0.0 = phi <4 x float> [ %128, %if.end164 ], [ zeroinitializer, %entry ], !dbg !73
  %acc_o.sroa.12.0 = phi <4 x float> [ %129, %if.end164 ], [ zeroinitializer, %entry ], !dbg !73
  %acc_o.sroa.22.0 = phi <4 x float> [ %130, %if.end164 ], [ zeroinitializer, %entry ], !dbg !73
  %acc_o.sroa.32.0 = phi <4 x float> [ %131, %if.end164 ], [ zeroinitializer, %entry ], !dbg !73
  %acc_o.sroa.42.0 = phi <4 x float> [ %132, %if.end164 ], [ zeroinitializer, %entry ], !dbg !73
  %acc_o.sroa.52.0 = phi <4 x float> [ %133, %if.end164 ], [ zeroinitializer, %entry ], !dbg !73
  %acc_o.sroa.62.0 = phi <4 x float> [ %134, %if.end164 ], [ zeroinitializer, %entry ], !dbg !73
  %acc_o.sroa.72.0 = phi <4 x float> [ %135, %if.end164 ], [ zeroinitializer, %entry ], !dbg !73
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0, !dbg !153
  %136 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract), !dbg !154
  %O_cast.sroa.0.0.insert.ext = zext i16 %136 to i64, !dbg !158
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1, !dbg !153
  %137 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract), !dbg !154
  %O_cast.sroa.0.2.insert.ext = zext i16 %137 to i64, !dbg !158
  %O_cast.sroa.0.2.insert.shift = shl nuw nsw i64 %O_cast.sroa.0.2.insert.ext, 16, !dbg !158
  %O_cast.sroa.0.2.insert.insert = or disjoint i64 %O_cast.sroa.0.2.insert.shift, %O_cast.sroa.0.0.insert.ext, !dbg !158
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2, !dbg !153
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract), !dbg !154
  %O_cast.sroa.0.4.insert.ext = zext i16 %138 to i64, !dbg !158
  %O_cast.sroa.0.4.insert.shift = shl nuw nsw i64 %O_cast.sroa.0.4.insert.ext, 32, !dbg !158
  %O_cast.sroa.0.4.insert.insert = or disjoint i64 %O_cast.sroa.0.2.insert.insert, %O_cast.sroa.0.4.insert.shift, !dbg !158
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3, !dbg !153
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract), !dbg !154
  %O_cast.sroa.0.6.insert.ext = zext i16 %139 to i64, !dbg !158
  %O_cast.sroa.0.6.insert.shift = shl nuw i64 %O_cast.sroa.0.6.insert.ext, 48, !dbg !158
  %O_cast.sroa.0.6.insert.insert = or disjoint i64 %O_cast.sroa.0.4.insert.insert, %O_cast.sroa.0.6.insert.shift, !dbg !158
  %acc_o.sroa.12.16.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 0, !dbg !153
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.12.16.vec.extract), !dbg !154
  %O_cast.sroa.7.8.insert.ext = zext i16 %140 to i64, !dbg !158
  %acc_o.sroa.12.20.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 1, !dbg !153
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.12.20.vec.extract), !dbg !154
  %O_cast.sroa.7.10.insert.ext = zext i16 %141 to i64, !dbg !158
  %O_cast.sroa.7.10.insert.shift = shl nuw nsw i64 %O_cast.sroa.7.10.insert.ext, 16, !dbg !158
  %O_cast.sroa.7.10.insert.insert = or disjoint i64 %O_cast.sroa.7.10.insert.shift, %O_cast.sroa.7.8.insert.ext, !dbg !158
  %acc_o.sroa.12.24.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 2, !dbg !153
  %142 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.12.24.vec.extract), !dbg !154
  %O_cast.sroa.7.12.insert.ext = zext i16 %142 to i64, !dbg !158
  %O_cast.sroa.7.12.insert.shift = shl nuw nsw i64 %O_cast.sroa.7.12.insert.ext, 32, !dbg !158
  %O_cast.sroa.7.12.insert.insert = or disjoint i64 %O_cast.sroa.7.10.insert.insert, %O_cast.sroa.7.12.insert.shift, !dbg !158
  %acc_o.sroa.12.28.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 3, !dbg !153
  %143 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.12.28.vec.extract), !dbg !154
  %O_cast.sroa.7.14.insert.ext = zext i16 %143 to i64, !dbg !158
  %O_cast.sroa.7.14.insert.shift = shl nuw i64 %O_cast.sroa.7.14.insert.ext, 48, !dbg !158
  %O_cast.sroa.7.14.insert.insert = or disjoint i64 %O_cast.sroa.7.12.insert.insert, %O_cast.sroa.7.14.insert.shift, !dbg !158
  %acc_o.sroa.22.32.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 0, !dbg !153
  %144 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.22.32.vec.extract), !dbg !154
  %O_cast.sroa.12.16.insert.ext = zext i16 %144 to i64, !dbg !158
  %acc_o.sroa.22.36.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 1, !dbg !153
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.22.36.vec.extract), !dbg !154
  %O_cast.sroa.12.18.insert.ext = zext i16 %145 to i64, !dbg !158
  %O_cast.sroa.12.18.insert.shift = shl nuw nsw i64 %O_cast.sroa.12.18.insert.ext, 16, !dbg !158
  %O_cast.sroa.12.18.insert.insert = or disjoint i64 %O_cast.sroa.12.18.insert.shift, %O_cast.sroa.12.16.insert.ext, !dbg !158
  %acc_o.sroa.22.40.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 2, !dbg !153
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.22.40.vec.extract), !dbg !154
  %O_cast.sroa.12.20.insert.ext = zext i16 %146 to i64, !dbg !158
  %O_cast.sroa.12.20.insert.shift = shl nuw nsw i64 %O_cast.sroa.12.20.insert.ext, 32, !dbg !158
  %O_cast.sroa.12.20.insert.insert = or disjoint i64 %O_cast.sroa.12.18.insert.insert, %O_cast.sroa.12.20.insert.shift, !dbg !158
  %acc_o.sroa.22.44.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 3, !dbg !153
  %147 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.22.44.vec.extract), !dbg !154
  %O_cast.sroa.12.22.insert.ext = zext i16 %147 to i64, !dbg !158
  %O_cast.sroa.12.22.insert.shift = shl nuw i64 %O_cast.sroa.12.22.insert.ext, 48, !dbg !158
  %O_cast.sroa.12.22.insert.insert = or disjoint i64 %O_cast.sroa.12.20.insert.insert, %O_cast.sroa.12.22.insert.shift, !dbg !158
  %acc_o.sroa.32.48.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 0, !dbg !153
  %148 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.32.48.vec.extract), !dbg !154
  %O_cast.sroa.17.24.insert.ext = zext i16 %148 to i64, !dbg !158
  %acc_o.sroa.32.52.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 1, !dbg !153
  %149 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.32.52.vec.extract), !dbg !154
  %O_cast.sroa.17.26.insert.ext = zext i16 %149 to i64, !dbg !158
  %O_cast.sroa.17.26.insert.shift = shl nuw nsw i64 %O_cast.sroa.17.26.insert.ext, 16, !dbg !158
  %O_cast.sroa.17.26.insert.insert = or disjoint i64 %O_cast.sroa.17.26.insert.shift, %O_cast.sroa.17.24.insert.ext, !dbg !158
  %acc_o.sroa.32.56.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 2, !dbg !153
  %150 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.32.56.vec.extract), !dbg !154
  %O_cast.sroa.17.28.insert.ext = zext i16 %150 to i64, !dbg !158
  %O_cast.sroa.17.28.insert.shift = shl nuw nsw i64 %O_cast.sroa.17.28.insert.ext, 32, !dbg !158
  %O_cast.sroa.17.28.insert.insert = or disjoint i64 %O_cast.sroa.17.26.insert.insert, %O_cast.sroa.17.28.insert.shift, !dbg !158
  %acc_o.sroa.32.60.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 3, !dbg !153
  %151 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.32.60.vec.extract), !dbg !154
  %O_cast.sroa.17.30.insert.ext = zext i16 %151 to i64, !dbg !158
  %O_cast.sroa.17.30.insert.shift = shl nuw i64 %O_cast.sroa.17.30.insert.ext, 48, !dbg !158
  %O_cast.sroa.17.30.insert.insert = or disjoint i64 %O_cast.sroa.17.28.insert.insert, %O_cast.sroa.17.30.insert.shift, !dbg !158
  %acc_o.sroa.42.64.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 0, !dbg !153
  %152 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.42.64.vec.extract), !dbg !154
  %O_cast.sroa.22.32.insert.ext = zext i16 %152 to i64, !dbg !158
  %acc_o.sroa.42.68.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 1, !dbg !153
  %153 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.42.68.vec.extract), !dbg !154
  %O_cast.sroa.22.34.insert.ext = zext i16 %153 to i64, !dbg !158
  %O_cast.sroa.22.34.insert.shift = shl nuw nsw i64 %O_cast.sroa.22.34.insert.ext, 16, !dbg !158
  %O_cast.sroa.22.34.insert.insert = or disjoint i64 %O_cast.sroa.22.34.insert.shift, %O_cast.sroa.22.32.insert.ext, !dbg !158
  %acc_o.sroa.42.72.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 2, !dbg !153
  %154 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.42.72.vec.extract), !dbg !154
  %O_cast.sroa.22.36.insert.ext = zext i16 %154 to i64, !dbg !158
  %O_cast.sroa.22.36.insert.shift = shl nuw nsw i64 %O_cast.sroa.22.36.insert.ext, 32, !dbg !158
  %O_cast.sroa.22.36.insert.insert = or disjoint i64 %O_cast.sroa.22.34.insert.insert, %O_cast.sroa.22.36.insert.shift, !dbg !158
  %acc_o.sroa.42.76.vec.extract = extractelement <4 x float> %acc_o.sroa.42.0, i64 3, !dbg !153
  %155 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.42.76.vec.extract), !dbg !154
  %O_cast.sroa.22.38.insert.ext = zext i16 %155 to i64, !dbg !158
  %O_cast.sroa.22.38.insert.shift = shl nuw i64 %O_cast.sroa.22.38.insert.ext, 48, !dbg !158
  %O_cast.sroa.22.38.insert.insert = or disjoint i64 %O_cast.sroa.22.36.insert.insert, %O_cast.sroa.22.38.insert.shift, !dbg !158
  %acc_o.sroa.52.80.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 0, !dbg !153
  %156 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.52.80.vec.extract), !dbg !154
  %O_cast.sroa.27.40.insert.ext = zext i16 %156 to i64, !dbg !158
  %acc_o.sroa.52.84.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 1, !dbg !153
  %157 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.52.84.vec.extract), !dbg !154
  %O_cast.sroa.27.42.insert.ext = zext i16 %157 to i64, !dbg !158
  %O_cast.sroa.27.42.insert.shift = shl nuw nsw i64 %O_cast.sroa.27.42.insert.ext, 16, !dbg !158
  %O_cast.sroa.27.42.insert.insert = or disjoint i64 %O_cast.sroa.27.42.insert.shift, %O_cast.sroa.27.40.insert.ext, !dbg !158
  %acc_o.sroa.52.88.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 2, !dbg !153
  %158 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.52.88.vec.extract), !dbg !154
  %O_cast.sroa.27.44.insert.ext = zext i16 %158 to i64, !dbg !158
  %O_cast.sroa.27.44.insert.shift = shl nuw nsw i64 %O_cast.sroa.27.44.insert.ext, 32, !dbg !158
  %O_cast.sroa.27.44.insert.insert = or disjoint i64 %O_cast.sroa.27.42.insert.insert, %O_cast.sroa.27.44.insert.shift, !dbg !158
  %acc_o.sroa.52.92.vec.extract = extractelement <4 x float> %acc_o.sroa.52.0, i64 3, !dbg !153
  %159 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.52.92.vec.extract), !dbg !154
  %O_cast.sroa.27.46.insert.ext = zext i16 %159 to i64, !dbg !158
  %O_cast.sroa.27.46.insert.shift = shl nuw i64 %O_cast.sroa.27.46.insert.ext, 48, !dbg !158
  %O_cast.sroa.27.46.insert.insert = or disjoint i64 %O_cast.sroa.27.44.insert.insert, %O_cast.sroa.27.46.insert.shift, !dbg !158
  %acc_o.sroa.62.96.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 0, !dbg !153
  %160 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.62.96.vec.extract), !dbg !154
  %O_cast.sroa.32.48.insert.ext = zext i16 %160 to i64, !dbg !158
  %acc_o.sroa.62.100.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 1, !dbg !153
  %161 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.62.100.vec.extract), !dbg !154
  %O_cast.sroa.32.50.insert.ext = zext i16 %161 to i64, !dbg !158
  %O_cast.sroa.32.50.insert.shift = shl nuw nsw i64 %O_cast.sroa.32.50.insert.ext, 16, !dbg !158
  %O_cast.sroa.32.50.insert.insert = or disjoint i64 %O_cast.sroa.32.50.insert.shift, %O_cast.sroa.32.48.insert.ext, !dbg !158
  %acc_o.sroa.62.104.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 2, !dbg !153
  %162 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.62.104.vec.extract), !dbg !154
  %O_cast.sroa.32.52.insert.ext = zext i16 %162 to i64, !dbg !158
  %O_cast.sroa.32.52.insert.shift = shl nuw nsw i64 %O_cast.sroa.32.52.insert.ext, 32, !dbg !158
  %O_cast.sroa.32.52.insert.insert = or disjoint i64 %O_cast.sroa.32.50.insert.insert, %O_cast.sroa.32.52.insert.shift, !dbg !158
  %acc_o.sroa.62.108.vec.extract = extractelement <4 x float> %acc_o.sroa.62.0, i64 3, !dbg !153
  %163 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.62.108.vec.extract), !dbg !154
  %O_cast.sroa.32.54.insert.ext = zext i16 %163 to i64, !dbg !158
  %O_cast.sroa.32.54.insert.shift = shl nuw i64 %O_cast.sroa.32.54.insert.ext, 48, !dbg !158
  %O_cast.sroa.32.54.insert.insert = or disjoint i64 %O_cast.sroa.32.52.insert.insert, %O_cast.sroa.32.54.insert.shift, !dbg !158
  %acc_o.sroa.72.112.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 0, !dbg !153
  %164 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.112.vec.extract), !dbg !154
  %O_cast.sroa.37.56.insert.ext = zext i16 %164 to i64, !dbg !158
  %acc_o.sroa.72.116.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 1, !dbg !153
  %165 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.116.vec.extract), !dbg !154
  %O_cast.sroa.37.58.insert.ext = zext i16 %165 to i64, !dbg !158
  %O_cast.sroa.37.58.insert.shift = shl nuw nsw i64 %O_cast.sroa.37.58.insert.ext, 16, !dbg !158
  %O_cast.sroa.37.58.insert.insert = or disjoint i64 %O_cast.sroa.37.58.insert.shift, %O_cast.sroa.37.56.insert.ext, !dbg !158
  %acc_o.sroa.72.120.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 2, !dbg !153
  %166 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.120.vec.extract), !dbg !154
  %O_cast.sroa.37.60.insert.ext = zext i16 %166 to i64, !dbg !158
  %O_cast.sroa.37.60.insert.shift = shl nuw nsw i64 %O_cast.sroa.37.60.insert.ext, 32, !dbg !158
  %O_cast.sroa.37.60.insert.insert = or disjoint i64 %O_cast.sroa.37.58.insert.insert, %O_cast.sroa.37.60.insert.shift, !dbg !158
  %acc_o.sroa.72.124.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 3, !dbg !153
  %167 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.124.vec.extract), !dbg !154
  %O_cast.sroa.37.62.insert.ext = zext i16 %167 to i64, !dbg !158
  %O_cast.sroa.37.62.insert.shift = shl nuw i64 %O_cast.sroa.37.62.insert.ext, 48, !dbg !158
  %O_cast.sroa.37.62.insert.insert = or disjoint i64 %O_cast.sroa.37.60.insert.insert, %O_cast.sroa.37.62.insert.shift, !dbg !158
  %168 = lshr i32 %2, 2
  %mul386 = and i32 %168, 252
  %add383 = add nuw nsw i32 %add10, %mul386
  %169 = zext nneg i32 %add383 to i64, !dbg !159
  %add.ptr389 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %169, !dbg !160
  store i64 %O_cast.sroa.0.6.insert.insert, ptr addrspace(1) %add.ptr389, align 8, !dbg !161
  %170 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %169, !dbg !160
  %add.ptr389.1 = getelementptr inbounds i8, ptr addrspace(1) %170, i64 32, !dbg !160
  store i64 %O_cast.sroa.7.14.insert.insert, ptr addrspace(1) %add.ptr389.1, align 8, !dbg !161
  %171 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %169, !dbg !160
  %add.ptr389.2 = getelementptr inbounds i8, ptr addrspace(1) %171, i64 64, !dbg !160
  store i64 %O_cast.sroa.12.22.insert.insert, ptr addrspace(1) %add.ptr389.2, align 8, !dbg !161
  %172 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %169, !dbg !160
  %add.ptr389.3 = getelementptr inbounds i8, ptr addrspace(1) %172, i64 96, !dbg !160
  store i64 %O_cast.sroa.17.30.insert.insert, ptr addrspace(1) %add.ptr389.3, align 8, !dbg !161
  %173 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %169, !dbg !160
  %add.ptr389.4 = getelementptr inbounds i8, ptr addrspace(1) %173, i64 128, !dbg !160
  store i64 %O_cast.sroa.22.38.insert.insert, ptr addrspace(1) %add.ptr389.4, align 8, !dbg !161
  %174 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %169, !dbg !160
  %add.ptr389.5 = getelementptr inbounds i8, ptr addrspace(1) %174, i64 160, !dbg !160
  store i64 %O_cast.sroa.27.46.insert.insert, ptr addrspace(1) %add.ptr389.5, align 8, !dbg !161
  %175 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %169, !dbg !160
  %add.ptr389.6 = getelementptr inbounds i8, ptr addrspace(1) %175, i64 192, !dbg !160
  store i64 %O_cast.sroa.32.54.insert.insert, ptr addrspace(1) %add.ptr389.6, align 8, !dbg !161
  %176 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %169, !dbg !160
  %add.ptr389.7 = getelementptr inbounds i8, ptr addrspace(1) %176, i64 224, !dbg !160
  store i64 %O_cast.sroa.37.62.insert.insert, ptr addrspace(1) %add.ptr389.7, align 8, !dbg !161
  ret void, !dbg !162
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

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp.f32(float) #7

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

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
attributes #10 = { nomerge }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmpo0rrkad0/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpo0rrkad0/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 24, column: 3, scope: !40)
!44 = !DILocation(line: 25, column: 46, scope: !40)
!45 = !DILocation(line: 25, column: 32, scope: !40)
!46 = !DILocation(line: 27, column: 58, scope: !40)
!47 = !DILocation(line: 27, column: 64, scope: !40)
!48 = !DILocation(line: 27, column: 25, scope: !40)
!49 = !DILocation(line: 33, column: 31, scope: !40)
!50 = !DILocation(line: 36, column: 5, scope: !40)
!51 = !DILocation(line: 39, column: 79, scope: !40)
!52 = !DILocation(line: 39, column: 58, scope: !40)
!53 = !DILocation(line: 39, column: 186, scope: !40)
!54 = !DILocation(line: 46, column: 79, scope: !40)
!55 = !DILocation(line: 46, column: 58, scope: !40)
!56 = !DILocation(line: 50, column: 5, scope: !40)
!57 = !DILocation(line: 51, column: 109, scope: !40)
!58 = !DILocation(line: 51, column: 26, scope: !40)
!59 = !DILocation(line: 51, column: 159, scope: !40)
!60 = !DILocation(line: 51, column: 122, scope: !40)
!61 = !DILocation(line: 53, column: 27, scope: !40)
!62 = !DILocation(line: 53, column: 9, scope: !40)
!63 = !DILocation(line: 57, column: 77, scope: !40)
!64 = !DILocation(line: 57, column: 13, scope: !40)
!65 = !DILocation(line: 62, column: 20, scope: !40)
!66 = !DILocation(line: 57, column: 70, scope: !40)
!67 = !DILocation(line: 68, column: 3, scope: !68, inlinedAt: !70)
!68 = distinct !DISubprogram(name: "__barrier_warp", scope: !69, file: !69, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!69 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!70 = distinct !DILocation(line: 192, column: 3, scope: !71, inlinedAt: !72)
!71 = distinct !DISubprogram(name: "__syncwarp", scope: !69, file: !69, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!72 = distinct !DILocation(line: 68, column: 5, scope: !40)
!73 = !DILocation(line: 0, scope: !40)
!74 = !DILocation(line: 69, column: 3, scope: !68, inlinedAt: !70)
!75 = !DILocation(line: 70, column: 3, scope: !68, inlinedAt: !70)
!76 = !DILocation(line: 70, column: 46, scope: !40)
!77 = !DILocation(line: 70, column: 25, scope: !40)
!78 = !DILocation(line: 73, column: 36, scope: !40)
!79 = !{i32 -1, i32 3, i32 -1}
!80 = !DILocation(line: 68, column: 3, scope: !68, inlinedAt: !81)
!81 = distinct !DILocation(line: 192, column: 3, scope: !71, inlinedAt: !82)
!82 = distinct !DILocation(line: 79, column: 5, scope: !40)
!83 = !DILocation(line: 69, column: 3, scope: !68, inlinedAt: !81)
!84 = !DILocation(line: 70, column: 3, scope: !68, inlinedAt: !81)
!85 = !DILocation(line: 81, column: 10, scope: !40)
!86 = !DILocation(line: 82, column: 70, scope: !40)
!87 = !DILocation(line: 82, column: 26, scope: !40)
!88 = !DILocation(line: 86, column: 30, scope: !40)
!89 = !DILocation(line: 86, column: 41, scope: !40)
!90 = !DILocation(line: 354, column: 10, scope: !91, inlinedAt: !93)
!91 = distinct !DISubprogram(name: "min", scope: !92, file: !92, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!92 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!93 = distinct !DILocation(line: 86, column: 25, scope: !40)
!94 = !DILocation(line: 288, column: 10, scope: !95, inlinedAt: !96)
!95 = distinct !DISubprogram(name: "expf", scope: !92, file: !92, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!96 = distinct !DILocation(line: 86, column: 20, scope: !40)
!97 = !DILocation(line: 91, column: 34, scope: !40)
!98 = !DILocation(line: 1018, column: 9, scope: !99, inlinedAt: !100)
!99 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !69, file: !69, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!100 = distinct !DILocation(line: 93, column: 34, scope: !40)
!101 = !DILocation(line: 171, column: 37, scope: !102, inlinedAt: !103)
!102 = distinct !DISubprogram(name: "__lane_id", scope: !69, file: !69, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!103 = distinct !DILocation(line: 990, column: 14, scope: !104, inlinedAt: !105)
!104 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !69, file: !69, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!105 = distinct !DILocation(line: 1019, column: 11, scope: !99, inlinedAt: !100)
!106 = !DILocation(line: 171, column: 10, scope: !102, inlinedAt: !103)
!107 = !DILocation(line: 991, column: 20, scope: !104, inlinedAt: !105)
!108 = !DILocation(line: 992, column: 36, scope: !104, inlinedAt: !105)
!109 = !DILocation(line: 992, column: 17, scope: !104, inlinedAt: !105)
!110 = !DILocation(line: 992, column: 11, scope: !104, inlinedAt: !105)
!111 = !DILocation(line: 993, column: 43, scope: !104, inlinedAt: !105)
!112 = !DILocation(line: 993, column: 10, scope: !104, inlinedAt: !105)
!113 = !DILocation(line: 1020, column: 14, scope: !99, inlinedAt: !100)
!114 = !DILocation(line: 93, column: 32, scope: !40)
!115 = !DILocation(line: 1018, column: 9, scope: !99, inlinedAt: !116)
!116 = distinct !DILocation(line: 94, column: 34, scope: !40)
!117 = !DILocation(line: 171, column: 37, scope: !102, inlinedAt: !118)
!118 = distinct !DILocation(line: 990, column: 14, scope: !104, inlinedAt: !119)
!119 = distinct !DILocation(line: 1019, column: 11, scope: !99, inlinedAt: !116)
!120 = !DILocation(line: 171, column: 10, scope: !102, inlinedAt: !118)
!121 = !DILocation(line: 991, column: 20, scope: !104, inlinedAt: !119)
!122 = !DILocation(line: 992, column: 36, scope: !104, inlinedAt: !119)
!123 = !DILocation(line: 992, column: 17, scope: !104, inlinedAt: !119)
!124 = !DILocation(line: 992, column: 11, scope: !104, inlinedAt: !119)
!125 = !DILocation(line: 993, column: 43, scope: !104, inlinedAt: !119)
!126 = !DILocation(line: 993, column: 10, scope: !104, inlinedAt: !119)
!127 = !DILocation(line: 1020, column: 14, scope: !99, inlinedAt: !116)
!128 = !DILocation(line: 94, column: 32, scope: !40)
!129 = !DILocation(line: 96, column: 34, scope: !40)
!130 = !DILocation(line: 96, column: 9, scope: !40)
!131 = !DILocation(line: 104, column: 32, scope: !40)
!132 = !DILocation(line: 75, column: 10, scope: !133, inlinedAt: !135)
!133 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !134, file: !134, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!134 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!135 = distinct !DILocation(line: 984, column: 9, scope: !136, inlinedAt: !138)
!136 = distinct !DISubprogram(name: "__float2half", scope: !137, file: !137, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!137 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!138 = distinct !DILocation(line: 133, column: 53, scope: !139, inlinedAt: !140)
!139 = distinct !DISubprogram(name: "__half", scope: !137, file: !137, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!140 = distinct !DILocation(line: 108, column: 32, scope: !40)
!141 = !DILocation(line: 108, column: 29, scope: !40)
!142 = !DILocation(line: 68, column: 3, scope: !68, inlinedAt: !143)
!143 = distinct !DILocation(line: 192, column: 3, scope: !71, inlinedAt: !144)
!144 = distinct !DILocation(line: 110, column: 5, scope: !40)
!145 = !DILocation(line: 69, column: 3, scope: !68, inlinedAt: !143)
!146 = !DILocation(line: 70, column: 3, scope: !68, inlinedAt: !143)
!147 = !DILocation(line: 113, column: 104, scope: !40)
!148 = !DILocation(line: 113, column: 31, scope: !40)
!149 = !DILocation(line: 113, column: 29, scope: !40)
!150 = !{!26, !26, i64 0}
!151 = !DILocation(line: 118, column: 38, scope: !40)
!152 = !DILocation(line: 125, column: 3, scope: !40)
!153 = !DILocation(line: 128, column: 61, scope: !40)
!154 = !DILocation(line: 75, column: 10, scope: !133, inlinedAt: !155)
!155 = distinct !DILocation(line: 984, column: 9, scope: !136, inlinedAt: !156)
!156 = distinct !DILocation(line: 133, column: 53, scope: !139, inlinedAt: !157)
!157 = distinct !DILocation(line: 128, column: 53, scope: !40)
!158 = !DILocation(line: 128, column: 50, scope: !40)
!159 = !DILocation(line: 132, column: 3, scope: !40)
!160 = !DILocation(line: 133, column: 22, scope: !40)
!161 = !DILocation(line: 133, column: 173, scope: !40)
!162 = !DILocation(line: 135, column: 1, scope: !40)
