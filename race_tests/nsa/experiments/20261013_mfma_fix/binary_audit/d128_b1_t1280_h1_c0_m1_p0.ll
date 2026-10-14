; ModuleID = 'experiments/20261013_mfma_fix/binary_audit/d128_b1_t1280_h1_c0_m1_p0.bc'
source_filename = "/tmp/tmpmsau1flh/tvm_kernels.maca"
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
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul = shl nsw i32 %0, 11
  %1 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %mul8 = shl nuw nsw i32 %1, 3
  %add = add nuw nsw i32 %mul8, %mul
  %2 = zext nneg i32 %add to i64, !dbg !43
  %3 = add nuw nsw i64 %2, 512, !dbg !44
  %4 = add nuw nsw i64 %2, 1024, !dbg !44
  %5 = add nuw nsw i64 %2, 1536, !dbg !44
  %idxprom = zext nneg i32 %0 to i64, !dbg !45
  %arrayidx14 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom, !dbg !45
  %6 = load i32, ptr addrspace(1) %arrayidx14, align 4, !dbg !45, !tbaa !30
  %cmp29 = icmp ult i32 %6, 80
  br i1 %cmp29, label %for.cond32.preheader, label %if.end326, !dbg !46

for.cond32.preheader:                             ; preds = %entry
  %add.ptr.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %5, !dbg !47
  %add.ptr.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4, !dbg !47
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !47
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %2, !dbg !47
  %mul41 = shl nuw nsw i32 %6, 11
  %add43 = add nuw nsw i32 %mul41, %mul8
  %7 = zext nneg i32 %add43 to i64, !dbg !48
  %add.ptr50 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %7, !dbg !49
  %8 = load i32, ptr addrspace(4) %add.ptr50, align 4, !dbg !50, !tbaa !30
  %9 = or disjoint i64 %7, 2, !dbg !51
  %add.ptr50.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %9, !dbg !49
  %10 = load i32, ptr addrspace(4) %add.ptr50.1, align 4, !dbg !50, !tbaa !30
  %11 = or disjoint i64 %7, 4, !dbg !51
  %add.ptr50.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %11, !dbg !49
  %12 = load i32, ptr addrspace(4) %add.ptr50.2, align 4, !dbg !50, !tbaa !30
  %13 = or disjoint i64 %7, 6, !dbg !51
  %add.ptr50.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %13, !dbg !49
  %14 = load i32, ptr addrspace(4) %add.ptr50.3, align 4, !dbg !50, !tbaa !30
  %15 = add nuw nsw i64 %7, 512
  %add.ptr50.1630 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %15, !dbg !49
  %16 = load i32, ptr addrspace(4) %add.ptr50.1630, align 4, !dbg !50, !tbaa !30
  %17 = add nuw nsw i64 %7, 514, !dbg !51
  %add.ptr50.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %17, !dbg !49
  %18 = load i32, ptr addrspace(4) %add.ptr50.1.1, align 4, !dbg !50, !tbaa !30
  %19 = add nuw nsw i64 %7, 516, !dbg !51
  %add.ptr50.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %19, !dbg !49
  %20 = load i32, ptr addrspace(4) %add.ptr50.2.1, align 4, !dbg !50, !tbaa !30
  %21 = add nuw nsw i64 %7, 518, !dbg !51
  %add.ptr50.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %21, !dbg !49
  %22 = load i32, ptr addrspace(4) %add.ptr50.3.1, align 4, !dbg !50, !tbaa !30
  %23 = add nuw nsw i64 %7, 1024
  %add.ptr50.2632 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %23, !dbg !49
  %24 = load i32, ptr addrspace(4) %add.ptr50.2632, align 4, !dbg !50, !tbaa !30
  %25 = add nuw nsw i64 %7, 1026, !dbg !51
  %add.ptr50.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %25, !dbg !49
  %26 = load i32, ptr addrspace(4) %add.ptr50.1.2, align 4, !dbg !50, !tbaa !30
  %27 = add nuw nsw i64 %7, 1028, !dbg !51
  %add.ptr50.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %27, !dbg !49
  %28 = load i32, ptr addrspace(4) %add.ptr50.2.2, align 4, !dbg !50, !tbaa !30
  %29 = add nuw nsw i64 %7, 1030, !dbg !51
  %add.ptr50.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %29, !dbg !49
  %30 = load i32, ptr addrspace(4) %add.ptr50.3.2, align 4, !dbg !50, !tbaa !30
  %31 = add nuw nsw i64 %7, 1536
  %add.ptr50.3634 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %31, !dbg !49
  %32 = load i32, ptr addrspace(4) %add.ptr50.3634, align 4, !dbg !50, !tbaa !30
  %33 = add nuw nsw i64 %7, 1538, !dbg !51
  %add.ptr50.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %33, !dbg !49
  %34 = load i32, ptr addrspace(4) %add.ptr50.1.3, align 4, !dbg !50, !tbaa !30
  %35 = add nuw nsw i64 %7, 1540, !dbg !51
  %add.ptr50.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %35, !dbg !49
  %36 = load i32, ptr addrspace(4) %add.ptr50.2.3, align 4, !dbg !50, !tbaa !30
  %37 = add nuw nsw i64 %7, 1542, !dbg !51
  %add.ptr50.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %37, !dbg !49
  %38 = load i32, ptr addrspace(4) %add.ptr50.3.3, align 4, !dbg !50, !tbaa !30
  %add.ptr80 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %7, !dbg !52
  %39 = load i32, ptr addrspace(4) %add.ptr80, align 4, !dbg !53, !tbaa !30
  %add.ptr80.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %9, !dbg !52
  %40 = load i32, ptr addrspace(4) %add.ptr80.1, align 4, !dbg !53, !tbaa !30
  %add.ptr80.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %11, !dbg !52
  %41 = load i32, ptr addrspace(4) %add.ptr80.2, align 4, !dbg !53, !tbaa !30
  %add.ptr80.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %13, !dbg !52
  %42 = load i32, ptr addrspace(4) %add.ptr80.3, align 4, !dbg !53, !tbaa !30
  %add.ptr80.1646 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %15, !dbg !52
  %43 = load i32, ptr addrspace(4) %add.ptr80.1646, align 4, !dbg !53, !tbaa !30
  %add.ptr80.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %17, !dbg !52
  %44 = load i32, ptr addrspace(4) %add.ptr80.1.1, align 4, !dbg !53, !tbaa !30
  %add.ptr80.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %19, !dbg !52
  %45 = load i32, ptr addrspace(4) %add.ptr80.2.1, align 4, !dbg !53, !tbaa !30
  %add.ptr80.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %21, !dbg !52
  %46 = load i32, ptr addrspace(4) %add.ptr80.3.1, align 4, !dbg !53, !tbaa !30
  %add.ptr80.2648 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %23, !dbg !52
  %47 = load i32, ptr addrspace(4) %add.ptr80.2648, align 4, !dbg !53, !tbaa !30
  %add.ptr80.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %25, !dbg !52
  %48 = load i32, ptr addrspace(4) %add.ptr80.1.2, align 4, !dbg !53, !tbaa !30
  %add.ptr80.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %27, !dbg !52
  %49 = load i32, ptr addrspace(4) %add.ptr80.2.2, align 4, !dbg !53, !tbaa !30
  %add.ptr80.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %29, !dbg !52
  %50 = load i32, ptr addrspace(4) %add.ptr80.3.2, align 4, !dbg !53, !tbaa !30
  %add.ptr80.3650 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %31, !dbg !52
  %51 = load i32, ptr addrspace(4) %add.ptr80.3650, align 4, !dbg !53, !tbaa !30
  %add.ptr80.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %33, !dbg !52
  %52 = load i32, ptr addrspace(4) %add.ptr80.1.3, align 4, !dbg !53, !tbaa !30
  %add.ptr80.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %35, !dbg !52
  %53 = load i32, ptr addrspace(4) %add.ptr80.2.3, align 4, !dbg !53, !tbaa !30
  %add.ptr80.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %37, !dbg !52
  %54 = load i32, ptr addrspace(4) %add.ptr80.3.3, align 4, !dbg !53, !tbaa !30
  %mul103 = and i32 %mul8, 8064
  %and = and i32 %1, 15
  %shr108 = lshr i32 %1, 4
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul103, !dbg !54
  %xor = xor i32 %shr108, %and, !dbg !55
  %add.ptr113.idx = shl nuw nsw i32 %xor, 4, !dbg !56
  %add.ptr113 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 %add.ptr113.idx, !dbg !56
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr113, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !dbg !57, !call_argsrelate !58
  %add109.1 = add nuw nsw i32 %shr108, 4, !dbg !59
  %xor.1 = xor i32 %add109.1, %and, !dbg !55
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1024, !dbg !56
  %add.ptr113.idx.1 = shl nuw nsw i32 %xor.1, 4, !dbg !56
  %add.ptr113.1 = getelementptr inbounds i8, ptr addrspace(3) %gep.1, i32 %add.ptr113.idx.1, !dbg !56
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr113.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !dbg !57, !call_argsrelate !58
  %add109.2 = add nuw nsw i32 %shr108, 8, !dbg !59
  %xor.2 = xor i32 %add109.2, %and, !dbg !55
  %gep.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 2048, !dbg !56
  %add.ptr113.idx.2 = shl nuw nsw i32 %xor.2, 4, !dbg !56
  %add.ptr113.2 = getelementptr inbounds i8, ptr addrspace(3) %gep.2, i32 %add.ptr113.idx.2, !dbg !56
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr113.2, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.2, i64 16, i1 false), !dbg !57, !call_argsrelate !58
  %add109.3 = add nuw nsw i32 %shr108, 12, !dbg !59
  %xor.3 = xor i32 %add109.3, %and, !dbg !55
  %gep.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 3072, !dbg !56
  %add.ptr113.idx.3 = shl nuw nsw i32 %xor.3, 4, !dbg !56
  %add.ptr113.3 = getelementptr inbounds i8, ptr addrspace(3) %gep.3, i32 %add.ptr113.idx.3, !dbg !56
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr113.3, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.3, i64 16, i1 false), !dbg !57, !call_argsrelate !58
  fence syncscope("warp") release, !dbg !60
  tail call void @llvm.mxc.barrier.warp(), !dbg !66
  fence syncscope("warp") acquire, !dbg !67
  %and122 = shl nuw nsw i32 %1, 7
  %mul123 = and i32 %and122, 1920
  %55 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul123
  %add.ptr134 = getelementptr inbounds i8, ptr addrspace(3) %55, i32 %add.ptr113.idx, !dbg !68
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr134, align 16, !dbg !69
  %Q_reg.sroa.4.0.add.ptr134.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr134, i32 8, !dbg !69
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr134.sroa_idx, align 8, !dbg !69
  %add.ptr134.1 = getelementptr inbounds i8, ptr addrspace(3) %55, i32 %add.ptr113.idx.1, !dbg !68
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr134.1, align 16, !dbg !69
  %Q_reg.sroa.7.16.add.ptr134.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr134.1, i32 8, !dbg !69
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr134.1.sroa_idx, align 8, !dbg !69
  %add.ptr134.2 = getelementptr inbounds i8, ptr addrspace(3) %55, i32 %add.ptr113.idx.2, !dbg !68
  %Q_reg.sroa.8.32.copyload = load <4 x half>, ptr addrspace(3) %add.ptr134.2, align 16, !dbg !69
  %Q_reg.sroa.10.32.add.ptr134.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr134.2, i32 8, !dbg !69
  %Q_reg.sroa.10.32.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.10.32.add.ptr134.2.sroa_idx, align 8, !dbg !69
  %add.ptr134.3 = getelementptr inbounds i8, ptr addrspace(3) %55, i32 %add.ptr113.idx.3, !dbg !68
  %Q_reg.sroa.11.48.copyload = load <4 x half>, ptr addrspace(3) %add.ptr134.3, align 16, !dbg !69
  %Q_reg.sroa.13.48.add.ptr134.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr134.3, i32 8, !dbg !69
  %Q_reg.sroa.13.48.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.13.48.add.ptr134.3.sroa_idx, align 8, !dbg !69
  fence syncscope("warp") release, !dbg !70
  tail call void @llvm.mxc.barrier.warp(), !dbg !73
  fence syncscope("warp") acquire, !dbg !74
  store i32 %8, ptr addrspace(3) %add.ptr113, align 16, !dbg !75, !tbaa !30
  %K_reg.sroa.4.0.add.ptr165.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr113, i32 4, !dbg !75
  store i32 %10, ptr addrspace(3) %K_reg.sroa.4.0.add.ptr165.sroa_idx, align 4, !dbg !75, !tbaa !30
  %K_reg.sroa.5.0.add.ptr165.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr113, i32 8, !dbg !75
  store i32 %12, ptr addrspace(3) %K_reg.sroa.5.0.add.ptr165.sroa_idx, align 8, !dbg !75, !tbaa !30
  %K_reg.sroa.6.0.add.ptr165.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr113, i32 12, !dbg !75
  store i32 %14, ptr addrspace(3) %K_reg.sroa.6.0.add.ptr165.sroa_idx, align 4, !dbg !75, !tbaa !30
  store i32 %16, ptr addrspace(3) %add.ptr113.1, align 16, !dbg !75, !tbaa !30
  %K_reg.sroa.9.16.add.ptr165.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr113.1, i32 4, !dbg !75
  store i32 %18, ptr addrspace(3) %K_reg.sroa.9.16.add.ptr165.1.sroa_idx, align 4, !dbg !75, !tbaa !30
  %K_reg.sroa.10.16.add.ptr165.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr113.1, i32 8, !dbg !75
  store i32 %20, ptr addrspace(3) %K_reg.sroa.10.16.add.ptr165.1.sroa_idx, align 8, !dbg !75, !tbaa !30
  %K_reg.sroa.11.16.add.ptr165.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr113.1, i32 12, !dbg !75
  store i32 %22, ptr addrspace(3) %K_reg.sroa.11.16.add.ptr165.1.sroa_idx, align 4, !dbg !75, !tbaa !30
  store i32 %24, ptr addrspace(3) %add.ptr113.2, align 16, !dbg !75, !tbaa !30
  %K_reg.sroa.14.32.add.ptr165.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr113.2, i32 4, !dbg !75
  store i32 %26, ptr addrspace(3) %K_reg.sroa.14.32.add.ptr165.2.sroa_idx, align 4, !dbg !75, !tbaa !30
  %K_reg.sroa.15.32.add.ptr165.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr113.2, i32 8, !dbg !75
  store i32 %28, ptr addrspace(3) %K_reg.sroa.15.32.add.ptr165.2.sroa_idx, align 8, !dbg !75, !tbaa !30
  %K_reg.sroa.16.32.add.ptr165.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr113.2, i32 12, !dbg !75
  store i32 %30, ptr addrspace(3) %K_reg.sroa.16.32.add.ptr165.2.sroa_idx, align 4, !dbg !75, !tbaa !30
  store i32 %32, ptr addrspace(3) %add.ptr113.3, align 16, !dbg !75, !tbaa !30
  %K_reg.sroa.19.48.add.ptr165.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr113.3, i32 4, !dbg !75
  store i32 %34, ptr addrspace(3) %K_reg.sroa.19.48.add.ptr165.3.sroa_idx, align 4, !dbg !75, !tbaa !30
  %K_reg.sroa.20.48.add.ptr165.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr113.3, i32 8, !dbg !75
  store i32 %36, ptr addrspace(3) %K_reg.sroa.20.48.add.ptr165.3.sroa_idx, align 8, !dbg !75, !tbaa !30
  %K_reg.sroa.21.48.add.ptr165.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr113.3, i32 12, !dbg !75
  store i32 %38, ptr addrspace(3) %K_reg.sroa.21.48.add.ptr165.3.sroa_idx, align 4, !dbg !75, !tbaa !30
  fence syncscope("warp") release, !dbg !76
  tail call void @llvm.mxc.barrier.warp(), !dbg !79
  fence syncscope("warp") acquire, !dbg !80
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr134, align 16, !dbg !81
  %kb.sroa.10.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr134.sroa_idx, align 8, !dbg !81
  %56 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !82
  %57 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %56), !dbg !82
  %kb.sroa.0.0.copyload688 = load <4 x half>, ptr addrspace(3) %add.ptr134.1, align 16, !dbg !81
  %kb.sroa.10.0.copyload691 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr134.1.sroa_idx, align 8, !dbg !81
  %58 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload688, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %57), !dbg !82
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload691, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %58), !dbg !82
  %kb.sroa.0.0.copyload689 = load <4 x half>, ptr addrspace(3) %add.ptr134.2, align 16, !dbg !81
  %kb.sroa.10.0.copyload692 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.10.32.add.ptr134.2.sroa_idx, align 8, !dbg !81
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload689, <4 x half> %Q_reg.sroa.8.32.copyload, <4 x float> %59), !dbg !82
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload692, <4 x half> %Q_reg.sroa.10.32.copyload, <4 x float> %60), !dbg !82
  %kb.sroa.0.0.copyload690 = load <4 x half>, ptr addrspace(3) %add.ptr134.3, align 16, !dbg !81
  %kb.sroa.10.0.copyload693 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.13.48.add.ptr134.3.sroa_idx, align 8, !dbg !81
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload690, <4 x half> %Q_reg.sroa.11.48.copyload, <4 x float> %61), !dbg !82
  %63 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.10.0.copyload693, <4 x half> %Q_reg.sroa.13.48.copyload, <4 x float> %62), !dbg !82
  fence syncscope("warp") release, !dbg !83
  tail call void @llvm.mxc.barrier.warp(), !dbg !86
  fence syncscope("warp") acquire, !dbg !87
  %add.ptr251.idx = shl nuw nsw i32 %1, 4
  %invariant.gep597 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr251.idx, !dbg !88
  store i32 %39, ptr addrspace(3) %invariant.gep597, align 16, !dbg !89, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep597.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep597, i32 4, !dbg !89
  store i32 %40, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep597.sroa_idx, align 4, !dbg !89, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep597.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep597, i32 8, !dbg !89
  store i32 %41, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep597.sroa_idx, align 8, !dbg !89, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep597.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep597, i32 12, !dbg !89
  store i32 %42, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep597.sroa_idx, align 4, !dbg !89, !tbaa !30
  %gep598.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep597, i32 1024, !dbg !90
  store i32 %43, ptr addrspace(3) %gep598.1, align 16, !dbg !89, !tbaa !30
  %V_reg.sroa.9.16.gep598.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep597, i32 1028, !dbg !89
  store i32 %44, ptr addrspace(3) %V_reg.sroa.9.16.gep598.1.sroa_idx, align 4, !dbg !89, !tbaa !30
  %V_reg.sroa.10.16.gep598.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep597, i32 1032, !dbg !89
  store i32 %45, ptr addrspace(3) %V_reg.sroa.10.16.gep598.1.sroa_idx, align 8, !dbg !89, !tbaa !30
  %V_reg.sroa.11.16.gep598.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep597, i32 1036, !dbg !89
  store i32 %46, ptr addrspace(3) %V_reg.sroa.11.16.gep598.1.sroa_idx, align 4, !dbg !89, !tbaa !30
  %gep598.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep597, i32 2048, !dbg !90
  store i32 %47, ptr addrspace(3) %gep598.2, align 16, !dbg !89, !tbaa !30
  %V_reg.sroa.14.32.gep598.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep597, i32 2052, !dbg !89
  store i32 %48, ptr addrspace(3) %V_reg.sroa.14.32.gep598.2.sroa_idx, align 4, !dbg !89, !tbaa !30
  %V_reg.sroa.15.32.gep598.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep597, i32 2056, !dbg !89
  store i32 %49, ptr addrspace(3) %V_reg.sroa.15.32.gep598.2.sroa_idx, align 8, !dbg !89, !tbaa !30
  %V_reg.sroa.16.32.gep598.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep597, i32 2060, !dbg !89
  store i32 %50, ptr addrspace(3) %V_reg.sroa.16.32.gep598.2.sroa_idx, align 4, !dbg !89, !tbaa !30
  %gep598.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep597, i32 3072, !dbg !90
  store i32 %51, ptr addrspace(3) %gep598.3, align 16, !dbg !89, !tbaa !30
  %V_reg.sroa.19.48.gep598.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep597, i32 3076, !dbg !89
  store i32 %52, ptr addrspace(3) %V_reg.sroa.19.48.gep598.3.sroa_idx, align 4, !dbg !89, !tbaa !30
  %V_reg.sroa.20.48.gep598.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep597, i32 3080, !dbg !89
  store i32 %53, ptr addrspace(3) %V_reg.sroa.20.48.gep598.3.sroa_idx, align 8, !dbg !89, !tbaa !30
  %V_reg.sroa.21.48.gep598.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep597, i32 3084, !dbg !89
  store i32 %54, ptr addrspace(3) %V_reg.sroa.21.48.gep598.3.sroa_idx, align 4, !dbg !89, !tbaa !30
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %63, i64 0, !dbg !91
  %mul261 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FC2776C60000000, !dbg !92
  %64 = tail call contract noundef float @llvm.minnum.f32(float %mul261, float 1.500000e+01), !dbg !93
  %cmp.i.i = fcmp contract olt float %64, -1.260000e+02, !dbg !97
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00, !dbg !97
  %add.i.i = fadd contract float %64, %cond.i.i, !dbg !97
  %65 = tail call contract float @llvm.exp2.f32(float %add.i.i), !dbg !97
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00, !dbg !97
  %mul.i.i = fmul contract float %cond2.i.i, %65, !dbg !97
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %63, i64 1, !dbg !91
  %mul261.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FC2776C60000000, !dbg !92
  %66 = tail call contract noundef float @llvm.minnum.f32(float %mul261.1, float 1.500000e+01), !dbg !93
  %cmp.i.i.1 = fcmp contract olt float %66, -1.260000e+02, !dbg !97
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00, !dbg !97
  %add.i.i.1 = fadd contract float %66, %cond.i.i.1, !dbg !97
  %67 = tail call contract float @llvm.exp2.f32(float %add.i.i.1), !dbg !97
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !97
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %67, !dbg !97
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %63, i64 2, !dbg !91
  %mul261.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FC2776C60000000, !dbg !92
  %68 = tail call contract noundef float @llvm.minnum.f32(float %mul261.2, float 1.500000e+01), !dbg !93
  %cmp.i.i.2 = fcmp contract olt float %68, -1.260000e+02, !dbg !97
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00, !dbg !97
  %add.i.i.2 = fadd contract float %68, %cond.i.i.2, !dbg !97
  %69 = tail call contract float @llvm.exp2.f32(float %add.i.i.2), !dbg !97
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00, !dbg !97
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %69, !dbg !97
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %63, i64 3, !dbg !91
  %mul261.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FC2776C60000000, !dbg !92
  %70 = tail call contract noundef float @llvm.minnum.f32(float %mul261.3, float 1.500000e+01), !dbg !93
  %cmp.i.i.3 = fcmp contract olt float %70, -1.260000e+02, !dbg !97
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00, !dbg !97
  %add.i.i.3 = fadd contract float %70, %cond.i.i.3, !dbg !97
  %71 = tail call contract float @llvm.exp2.f32(float %add.i.i.3), !dbg !97
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00, !dbg !97
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %71, !dbg !97
  %add277 = fadd contract float %mul.i.i, 0.000000e+00, !dbg !100
  %add277.1 = fadd contract float %add277, %mul.i.i.1, !dbg !100
  %add277.2 = fadd contract float %add277.1, %mul.i.i.2, !dbg !100
  %add277.3 = fadd contract float %add277.2, %mul.i.i.3, !dbg !100
  %72 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add277.3, <4 x float> zeroinitializer), !dbg !101
  %wsum_output.sroa.0.0.vec.extract = extractelement <4 x float> %72, i64 0, !dbg !102
  %cmp295 = fcmp contract ogt float %wsum_output.sroa.0.0.vec.extract, 0.000000e+00, !dbg !103
  %div = fdiv contract float 1.000000e+00, %wsum_output.sroa.0.0.vec.extract, !dbg !104
  %condval_1.0 = select i1 %cmp295, float %div, float 0.000000e+00, !dbg !104
  %mul308 = fmul contract float %condval_1.0, %mul.i.i, !dbg !105
  %mul308.1 = fmul contract float %condval_1.0, %mul.i.i.1, !dbg !105
  %mul308.2 = fmul contract float %condval_1.0, %mul.i.i.2, !dbg !105
  %mul308.3 = fmul contract float %condval_1.0, %mul.i.i.3, !dbg !105
  %73 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul308), !dbg !106
  %74 = insertelement <4 x i16> poison, i16 %73, i64 0, !dbg !115
  %75 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul308.1), !dbg !106
  %76 = insertelement <4 x i16> %74, i16 %75, i64 1, !dbg !115
  %77 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul308.2), !dbg !106
  %78 = insertelement <4 x i16> %76, i16 %77, i64 2, !dbg !115
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul308.3), !dbg !106
  %80 = insertelement <4 x i16> %78, i16 %79, i64 3, !dbg !115
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %80 to <4 x half>, !dbg !115
  fence syncscope("warp") release, !dbg !116
  tail call void @llvm.mxc.barrier.warp(), !dbg !119
  fence syncscope("warp") acquire, !dbg !120
  br label %if.end326, !dbg !121

if.end326:                                        ; preds = %for.cond32.preheader, %entry
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ %acc_s_cast.sroa.0.6.vec.insert, %for.cond32.preheader ], [ undef, %entry ]
  br i1 %cmp29, label %for.cond344.preheader, label %if.end326.if.end392_crit_edge, !dbg !122

if.end326.if.end392_crit_edge:                    ; preds = %if.end326
  %.pre = and i32 %1, 15
  br label %if.end392, !dbg !122

for.cond344.preheader:                            ; preds = %if.end326
  %81 = shl nuw nsw i32 %1, 5
  %mul354 = and i32 %81, 32256
  %and360 = and i32 %1, 15
  %add361 = or disjoint i32 %mul354, %and360, !dbg !123
  %arrayidx363 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361, !dbg !124
  %82 = load half, ptr addrspace(3) %arrayidx363, align 2, !dbg !125, !tbaa !126
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %82, i64 0, !dbg !125
  %add356.1 = or disjoint i32 %mul354, %and360, !dbg !123
  %add361.1 = or disjoint i32 %add356.1, 128, !dbg !123
  %arrayidx363.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.1, !dbg !124
  %83 = load half, ptr addrspace(3) %arrayidx363.1, align 2, !dbg !125, !tbaa !126
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %83, i64 1, !dbg !125
  %add356.2 = or disjoint i32 %mul354, %and360, !dbg !123
  %add361.2 = or disjoint i32 %add356.2, 256, !dbg !123
  %arrayidx363.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.2, !dbg !124
  %84 = load half, ptr addrspace(3) %arrayidx363.2, align 2, !dbg !125, !tbaa !126
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %84, i64 2, !dbg !125
  %add356.3 = or disjoint i32 %mul354, %and360, !dbg !123
  %add361.3 = or disjoint i32 %add356.3, 384, !dbg !123
  %arrayidx363.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.3, !dbg !124
  %85 = load half, ptr addrspace(3) %arrayidx363.3, align 2, !dbg !125, !tbaa !126
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %85, i64 3, !dbg !125
  %add358.1654 = or disjoint i32 %mul354, %and360, !dbg !123
  %add361.1655 = or disjoint i32 %add358.1654, 16, !dbg !123
  %arrayidx363.1656 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.1655, !dbg !124
  %86 = load half, ptr addrspace(3) %arrayidx363.1656, align 2, !dbg !125, !tbaa !126
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %86, i64 0, !dbg !125
  %add358.1.1 = or disjoint i32 %mul354, %and360, !dbg !123
  %add361.1.1 = or disjoint i32 %add358.1.1, 144, !dbg !123
  %arrayidx363.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.1.1, !dbg !124
  %87 = load half, ptr addrspace(3) %arrayidx363.1.1, align 2, !dbg !125, !tbaa !126
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %87, i64 1, !dbg !125
  %add358.2.1 = or disjoint i32 %mul354, %and360, !dbg !123
  %add361.2.1 = or disjoint i32 %add358.2.1, 272, !dbg !123
  %arrayidx363.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.2.1, !dbg !124
  %88 = load half, ptr addrspace(3) %arrayidx363.2.1, align 2, !dbg !125, !tbaa !126
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %88, i64 2, !dbg !125
  %add358.3.1 = or disjoint i32 %mul354, %and360, !dbg !123
  %add361.3.1 = or disjoint i32 %add358.3.1, 400, !dbg !123
  %arrayidx363.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.3.1, !dbg !124
  %89 = load half, ptr addrspace(3) %arrayidx363.3.1, align 2, !dbg !125, !tbaa !126
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %89, i64 3, !dbg !125
  %add358.2658 = or disjoint i32 %mul354, %and360, !dbg !123
  %add361.2659 = or disjoint i32 %add358.2658, 32, !dbg !123
  %arrayidx363.2660 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.2659, !dbg !124
  %90 = load half, ptr addrspace(3) %arrayidx363.2660, align 2, !dbg !125, !tbaa !126
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %90, i64 0, !dbg !125
  %add358.1.2 = or disjoint i32 %mul354, %and360, !dbg !123
  %add361.1.2 = or disjoint i32 %add358.1.2, 160, !dbg !123
  %arrayidx363.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.1.2, !dbg !124
  %91 = load half, ptr addrspace(3) %arrayidx363.1.2, align 2, !dbg !125, !tbaa !126
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %91, i64 1, !dbg !125
  %add358.2.2 = or disjoint i32 %mul354, %and360, !dbg !123
  %add361.2.2 = or disjoint i32 %add358.2.2, 288, !dbg !123
  %arrayidx363.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.2.2, !dbg !124
  %92 = load half, ptr addrspace(3) %arrayidx363.2.2, align 2, !dbg !125, !tbaa !126
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %92, i64 2, !dbg !125
  %add358.3.2 = or disjoint i32 %mul354, %and360, !dbg !123
  %add361.3.2 = or disjoint i32 %add358.3.2, 416, !dbg !123
  %arrayidx363.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.3.2, !dbg !124
  %93 = load half, ptr addrspace(3) %arrayidx363.3.2, align 2, !dbg !125, !tbaa !126
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %93, i64 3, !dbg !125
  %add358.3662 = or disjoint i32 %mul354, %and360, !dbg !123
  %add361.3663 = or disjoint i32 %add358.3662, 48, !dbg !123
  %arrayidx363.3664 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.3663, !dbg !124
  %94 = load half, ptr addrspace(3) %arrayidx363.3664, align 2, !dbg !125, !tbaa !126
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %94, i64 0, !dbg !125
  %add358.1.3 = or disjoint i32 %mul354, %and360, !dbg !123
  %add361.1.3 = or disjoint i32 %add358.1.3, 176, !dbg !123
  %arrayidx363.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.1.3, !dbg !124
  %95 = load half, ptr addrspace(3) %arrayidx363.1.3, align 2, !dbg !125, !tbaa !126
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %95, i64 1, !dbg !125
  %add358.2.3 = or disjoint i32 %mul354, %and360, !dbg !123
  %add361.2.3 = or disjoint i32 %add358.2.3, 304, !dbg !123
  %arrayidx363.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.2.3, !dbg !124
  %96 = load half, ptr addrspace(3) %arrayidx363.2.3, align 2, !dbg !125, !tbaa !126
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %96, i64 2, !dbg !125
  %add358.3.3 = or disjoint i32 %mul354, %and360, !dbg !123
  %add361.3.3 = or disjoint i32 %add358.3.3, 432, !dbg !123
  %arrayidx363.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.3.3, !dbg !124
  %97 = load half, ptr addrspace(3) %arrayidx363.3.3, align 2, !dbg !125, !tbaa !126
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %97, i64 3, !dbg !125
  %add358.4 = or disjoint i32 %mul354, %and360, !dbg !123
  %add361.4 = or disjoint i32 %add358.4, 64, !dbg !123
  %arrayidx363.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.4, !dbg !124
  %98 = load half, ptr addrspace(3) %arrayidx363.4, align 2, !dbg !125, !tbaa !126
  %vb.sroa.22.32.vec.insert = insertelement <4 x half> poison, half %98, i64 0, !dbg !125
  %add358.1.4 = or disjoint i32 %mul354, %and360, !dbg !123
  %add361.1.4 = or disjoint i32 %add358.1.4, 192, !dbg !123
  %arrayidx363.1.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.1.4, !dbg !124
  %99 = load half, ptr addrspace(3) %arrayidx363.1.4, align 2, !dbg !125, !tbaa !126
  %vb.sroa.22.34.vec.insert = insertelement <4 x half> %vb.sroa.22.32.vec.insert, half %99, i64 1, !dbg !125
  %add358.2.4 = or disjoint i32 %mul354, %and360, !dbg !123
  %add361.2.4 = or disjoint i32 %add358.2.4, 320, !dbg !123
  %arrayidx363.2.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.2.4, !dbg !124
  %100 = load half, ptr addrspace(3) %arrayidx363.2.4, align 2, !dbg !125, !tbaa !126
  %vb.sroa.22.36.vec.insert = insertelement <4 x half> %vb.sroa.22.34.vec.insert, half %100, i64 2, !dbg !125
  %add358.3.4 = or disjoint i32 %mul354, %and360, !dbg !123
  %add361.3.4 = or disjoint i32 %add358.3.4, 448, !dbg !123
  %arrayidx363.3.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.3.4, !dbg !124
  %101 = load half, ptr addrspace(3) %arrayidx363.3.4, align 2, !dbg !125, !tbaa !126
  %vb.sroa.22.38.vec.insert = insertelement <4 x half> %vb.sroa.22.36.vec.insert, half %101, i64 3, !dbg !125
  %add358.5 = or disjoint i32 %mul354, %and360, !dbg !123
  %add361.5 = or disjoint i32 %add358.5, 80, !dbg !123
  %arrayidx363.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.5, !dbg !124
  %102 = load half, ptr addrspace(3) %arrayidx363.5, align 2, !dbg !125, !tbaa !126
  %vb.sroa.27.40.vec.insert = insertelement <4 x half> poison, half %102, i64 0, !dbg !125
  %add358.1.5 = or disjoint i32 %mul354, %and360, !dbg !123
  %add361.1.5 = or disjoint i32 %add358.1.5, 208, !dbg !123
  %arrayidx363.1.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.1.5, !dbg !124
  %103 = load half, ptr addrspace(3) %arrayidx363.1.5, align 2, !dbg !125, !tbaa !126
  %vb.sroa.27.42.vec.insert = insertelement <4 x half> %vb.sroa.27.40.vec.insert, half %103, i64 1, !dbg !125
  %add358.2.5 = or disjoint i32 %mul354, %and360, !dbg !123
  %add361.2.5 = or disjoint i32 %add358.2.5, 336, !dbg !123
  %arrayidx363.2.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.2.5, !dbg !124
  %104 = load half, ptr addrspace(3) %arrayidx363.2.5, align 2, !dbg !125, !tbaa !126
  %vb.sroa.27.44.vec.insert = insertelement <4 x half> %vb.sroa.27.42.vec.insert, half %104, i64 2, !dbg !125
  %add358.3.5 = or disjoint i32 %mul354, %and360, !dbg !123
  %add361.3.5 = or disjoint i32 %add358.3.5, 464, !dbg !123
  %arrayidx363.3.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.3.5, !dbg !124
  %105 = load half, ptr addrspace(3) %arrayidx363.3.5, align 2, !dbg !125, !tbaa !126
  %vb.sroa.27.46.vec.insert = insertelement <4 x half> %vb.sroa.27.44.vec.insert, half %105, i64 3, !dbg !125
  %add358.6 = or disjoint i32 %mul354, %and360, !dbg !123
  %add361.6 = or disjoint i32 %add358.6, 96, !dbg !123
  %arrayidx363.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.6, !dbg !124
  %106 = load half, ptr addrspace(3) %arrayidx363.6, align 2, !dbg !125, !tbaa !126
  %vb.sroa.32.48.vec.insert = insertelement <4 x half> poison, half %106, i64 0, !dbg !125
  %add358.1.6 = or disjoint i32 %mul354, %and360, !dbg !123
  %add361.1.6 = or disjoint i32 %add358.1.6, 224, !dbg !123
  %arrayidx363.1.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.1.6, !dbg !124
  %107 = load half, ptr addrspace(3) %arrayidx363.1.6, align 2, !dbg !125, !tbaa !126
  %vb.sroa.32.50.vec.insert = insertelement <4 x half> %vb.sroa.32.48.vec.insert, half %107, i64 1, !dbg !125
  %add358.2.6 = or disjoint i32 %mul354, %and360, !dbg !123
  %add361.2.6 = or disjoint i32 %add358.2.6, 352, !dbg !123
  %arrayidx363.2.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.2.6, !dbg !124
  %108 = load half, ptr addrspace(3) %arrayidx363.2.6, align 2, !dbg !125, !tbaa !126
  %vb.sroa.32.52.vec.insert = insertelement <4 x half> %vb.sroa.32.50.vec.insert, half %108, i64 2, !dbg !125
  %add358.3.6 = or disjoint i32 %81, %and360, !dbg !123
  %add361.3.6 = or i32 %add358.3.6, 480, !dbg !123
  %arrayidx363.3.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.3.6, !dbg !124
  %109 = load half, ptr addrspace(3) %arrayidx363.3.6, align 2, !dbg !125, !tbaa !126
  %vb.sroa.32.54.vec.insert = insertelement <4 x half> %vb.sroa.32.52.vec.insert, half %109, i64 3, !dbg !125
  %add358.7 = or disjoint i32 %mul354, %and360, !dbg !123
  %add361.7 = or disjoint i32 %add358.7, 112, !dbg !123
  %arrayidx363.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.7, !dbg !124
  %110 = load half, ptr addrspace(3) %arrayidx363.7, align 2, !dbg !125, !tbaa !126
  %vb.sroa.37.56.vec.insert = insertelement <4 x half> poison, half %110, i64 0, !dbg !125
  %add358.1.7 = or disjoint i32 %mul354, %and360, !dbg !123
  %add361.1.7 = or disjoint i32 %add358.1.7, 240, !dbg !123
  %arrayidx363.1.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.1.7, !dbg !124
  %111 = load half, ptr addrspace(3) %arrayidx363.1.7, align 2, !dbg !125, !tbaa !126
  %vb.sroa.37.58.vec.insert = insertelement <4 x half> %vb.sroa.37.56.vec.insert, half %111, i64 1, !dbg !125
  %add358.2.7 = or disjoint i32 %mul354, %and360, !dbg !123
  %add361.2.7 = or disjoint i32 %add358.2.7, 368, !dbg !123
  %arrayidx363.2.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.2.7, !dbg !124
  %112 = load half, ptr addrspace(3) %arrayidx363.2.7, align 2, !dbg !125, !tbaa !126
  %vb.sroa.37.60.vec.insert = insertelement <4 x half> %vb.sroa.37.58.vec.insert, half %112, i64 2, !dbg !125
  %add358.3.7 = or disjoint i32 %81, %and360, !dbg !123
  %add361.3.7 = or i32 %add358.3.7, 496, !dbg !123
  %arrayidx363.3.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add361.3.7, !dbg !124
  %113 = load half, ptr addrspace(3) %arrayidx363.3.7, align 2, !dbg !125, !tbaa !126
  %vb.sroa.37.62.vec.insert = insertelement <4 x half> %vb.sroa.37.60.vec.insert, half %113, i64 3, !dbg !125
  %114 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !127
  %115 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !127
  %116 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !127
  %117 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !127
  %118 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.22.38.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !127
  %119 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.27.46.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !127
  %120 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.32.54.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !127
  %121 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.37.62.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !127
  br label %if.end392, !dbg !128

if.end392:                                        ; preds = %if.end326.if.end392_crit_edge, %for.cond344.preheader
  %and432.pre-phi = phi i32 [ %.pre, %if.end326.if.end392_crit_edge ], [ %and360, %for.cond344.preheader ]
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end326.if.end392_crit_edge ], [ %114, %for.cond344.preheader ], !dbg !129
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end326.if.end392_crit_edge ], [ %115, %for.cond344.preheader ], !dbg !129
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end326.if.end392_crit_edge ], [ %116, %for.cond344.preheader ], !dbg !129
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end326.if.end392_crit_edge ], [ %117, %for.cond344.preheader ], !dbg !129
  %acc_o.sroa.58.0 = phi <4 x float> [ zeroinitializer, %if.end326.if.end392_crit_edge ], [ %118, %for.cond344.preheader ], !dbg !129
  %acc_o.sroa.72.0 = phi <4 x float> [ zeroinitializer, %if.end326.if.end392_crit_edge ], [ %119, %for.cond344.preheader ], !dbg !129
  %acc_o.sroa.86.0 = phi <4 x float> [ zeroinitializer, %if.end326.if.end392_crit_edge ], [ %120, %for.cond344.preheader ], !dbg !129
  %acc_o.sroa.100.0 = phi <4 x float> [ zeroinitializer, %if.end326.if.end392_crit_edge ], [ %121, %for.cond344.preheader ], !dbg !129
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0, !dbg !130
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract), !dbg !131
  %O_reg.sroa.0.0.insert.ext = zext i16 %122 to i64, !dbg !135
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1, !dbg !130
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract), !dbg !131
  %O_reg.sroa.0.2.insert.ext = zext i16 %123 to i64, !dbg !135
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !135
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !135
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2, !dbg !130
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract), !dbg !131
  %O_reg.sroa.0.4.insert.ext = zext i16 %124 to i64, !dbg !135
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !135
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !135
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3, !dbg !130
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract), !dbg !131
  %O_reg.sroa.0.6.insert.ext = zext i16 %125 to i64, !dbg !135
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !135
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !135
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0, !dbg !130
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract), !dbg !131
  %O_reg.sroa.7.8.insert.ext = zext i16 %126 to i64, !dbg !135
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1, !dbg !130
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract), !dbg !131
  %O_reg.sroa.7.10.insert.ext = zext i16 %127 to i64, !dbg !135
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !135
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !135
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2, !dbg !130
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract), !dbg !131
  %O_reg.sroa.7.12.insert.ext = zext i16 %128 to i64, !dbg !135
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !135
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !135
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3, !dbg !130
  %129 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract), !dbg !131
  %O_reg.sroa.7.14.insert.ext = zext i16 %129 to i64, !dbg !135
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !135
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !135
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0, !dbg !130
  %130 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract), !dbg !131
  %O_reg.sroa.12.16.insert.ext = zext i16 %130 to i64, !dbg !135
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1, !dbg !130
  %131 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract), !dbg !131
  %O_reg.sroa.12.18.insert.ext = zext i16 %131 to i64, !dbg !135
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !135
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !135
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2, !dbg !130
  %132 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract), !dbg !131
  %O_reg.sroa.12.20.insert.ext = zext i16 %132 to i64, !dbg !135
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !135
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !135
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3, !dbg !130
  %133 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract), !dbg !131
  %O_reg.sroa.12.22.insert.ext = zext i16 %133 to i64, !dbg !135
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !135
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !135
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0, !dbg !130
  %134 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract), !dbg !131
  %O_reg.sroa.17.24.insert.ext = zext i16 %134 to i64, !dbg !135
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1, !dbg !130
  %135 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract), !dbg !131
  %O_reg.sroa.17.26.insert.ext = zext i16 %135 to i64, !dbg !135
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !135
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !135
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2, !dbg !130
  %136 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract), !dbg !131
  %O_reg.sroa.17.28.insert.ext = zext i16 %136 to i64, !dbg !135
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !135
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !135
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3, !dbg !130
  %137 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract), !dbg !131
  %O_reg.sroa.17.30.insert.ext = zext i16 %137 to i64, !dbg !135
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !135
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !135
  %acc_o.sroa.58.64.vec.extract = extractelement <4 x float> %acc_o.sroa.58.0, i64 0, !dbg !130
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.58.64.vec.extract), !dbg !131
  %O_reg.sroa.22.32.insert.ext = zext i16 %138 to i64, !dbg !135
  %acc_o.sroa.58.68.vec.extract = extractelement <4 x float> %acc_o.sroa.58.0, i64 1, !dbg !130
  %139 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.58.68.vec.extract), !dbg !131
  %O_reg.sroa.22.34.insert.ext = zext i16 %139 to i64, !dbg !135
  %O_reg.sroa.22.34.insert.shift = shl nuw nsw i64 %O_reg.sroa.22.34.insert.ext, 16, !dbg !135
  %O_reg.sroa.22.34.insert.insert = or disjoint i64 %O_reg.sroa.22.34.insert.shift, %O_reg.sroa.22.32.insert.ext, !dbg !135
  %acc_o.sroa.58.72.vec.extract = extractelement <4 x float> %acc_o.sroa.58.0, i64 2, !dbg !130
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.58.72.vec.extract), !dbg !131
  %O_reg.sroa.22.36.insert.ext = zext i16 %140 to i64, !dbg !135
  %O_reg.sroa.22.36.insert.shift = shl nuw nsw i64 %O_reg.sroa.22.36.insert.ext, 32, !dbg !135
  %O_reg.sroa.22.36.insert.insert = or disjoint i64 %O_reg.sroa.22.34.insert.insert, %O_reg.sroa.22.36.insert.shift, !dbg !135
  %acc_o.sroa.58.76.vec.extract = extractelement <4 x float> %acc_o.sroa.58.0, i64 3, !dbg !130
  %141 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.58.76.vec.extract), !dbg !131
  %O_reg.sroa.22.38.insert.ext = zext i16 %141 to i64, !dbg !135
  %O_reg.sroa.22.38.insert.shift = shl nuw i64 %O_reg.sroa.22.38.insert.ext, 48, !dbg !135
  %O_reg.sroa.22.38.insert.insert = or disjoint i64 %O_reg.sroa.22.36.insert.insert, %O_reg.sroa.22.38.insert.shift, !dbg !135
  %acc_o.sroa.72.80.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 0, !dbg !130
  %142 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.80.vec.extract), !dbg !131
  %O_reg.sroa.27.40.insert.ext = zext i16 %142 to i64, !dbg !135
  %acc_o.sroa.72.84.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 1, !dbg !130
  %143 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.84.vec.extract), !dbg !131
  %O_reg.sroa.27.42.insert.ext = zext i16 %143 to i64, !dbg !135
  %O_reg.sroa.27.42.insert.shift = shl nuw nsw i64 %O_reg.sroa.27.42.insert.ext, 16, !dbg !135
  %O_reg.sroa.27.42.insert.insert = or disjoint i64 %O_reg.sroa.27.42.insert.shift, %O_reg.sroa.27.40.insert.ext, !dbg !135
  %acc_o.sroa.72.88.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 2, !dbg !130
  %144 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.88.vec.extract), !dbg !131
  %O_reg.sroa.27.44.insert.ext = zext i16 %144 to i64, !dbg !135
  %O_reg.sroa.27.44.insert.shift = shl nuw nsw i64 %O_reg.sroa.27.44.insert.ext, 32, !dbg !135
  %O_reg.sroa.27.44.insert.insert = or disjoint i64 %O_reg.sroa.27.42.insert.insert, %O_reg.sroa.27.44.insert.shift, !dbg !135
  %acc_o.sroa.72.92.vec.extract = extractelement <4 x float> %acc_o.sroa.72.0, i64 3, !dbg !130
  %145 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.72.92.vec.extract), !dbg !131
  %O_reg.sroa.27.46.insert.ext = zext i16 %145 to i64, !dbg !135
  %O_reg.sroa.27.46.insert.shift = shl nuw i64 %O_reg.sroa.27.46.insert.ext, 48, !dbg !135
  %O_reg.sroa.27.46.insert.insert = or disjoint i64 %O_reg.sroa.27.44.insert.insert, %O_reg.sroa.27.46.insert.shift, !dbg !135
  %acc_o.sroa.86.96.vec.extract = extractelement <4 x float> %acc_o.sroa.86.0, i64 0, !dbg !130
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.86.96.vec.extract), !dbg !131
  %O_reg.sroa.32.48.insert.ext = zext i16 %146 to i64, !dbg !135
  %acc_o.sroa.86.100.vec.extract = extractelement <4 x float> %acc_o.sroa.86.0, i64 1, !dbg !130
  %147 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.86.100.vec.extract), !dbg !131
  %O_reg.sroa.32.50.insert.ext = zext i16 %147 to i64, !dbg !135
  %O_reg.sroa.32.50.insert.shift = shl nuw nsw i64 %O_reg.sroa.32.50.insert.ext, 16, !dbg !135
  %O_reg.sroa.32.50.insert.insert = or disjoint i64 %O_reg.sroa.32.50.insert.shift, %O_reg.sroa.32.48.insert.ext, !dbg !135
  %acc_o.sroa.86.104.vec.extract = extractelement <4 x float> %acc_o.sroa.86.0, i64 2, !dbg !130
  %148 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.86.104.vec.extract), !dbg !131
  %O_reg.sroa.32.52.insert.ext = zext i16 %148 to i64, !dbg !135
  %O_reg.sroa.32.52.insert.shift = shl nuw nsw i64 %O_reg.sroa.32.52.insert.ext, 32, !dbg !135
  %O_reg.sroa.32.52.insert.insert = or disjoint i64 %O_reg.sroa.32.50.insert.insert, %O_reg.sroa.32.52.insert.shift, !dbg !135
  %acc_o.sroa.86.108.vec.extract = extractelement <4 x float> %acc_o.sroa.86.0, i64 3, !dbg !130
  %149 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.86.108.vec.extract), !dbg !131
  %O_reg.sroa.32.54.insert.ext = zext i16 %149 to i64, !dbg !135
  %O_reg.sroa.32.54.insert.shift = shl nuw i64 %O_reg.sroa.32.54.insert.ext, 48, !dbg !135
  %O_reg.sroa.32.54.insert.insert = or disjoint i64 %O_reg.sroa.32.52.insert.insert, %O_reg.sroa.32.54.insert.shift, !dbg !135
  %acc_o.sroa.100.112.vec.extract = extractelement <4 x float> %acc_o.sroa.100.0, i64 0, !dbg !130
  %150 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.100.112.vec.extract), !dbg !131
  %O_reg.sroa.37.56.insert.ext = zext i16 %150 to i64, !dbg !135
  %acc_o.sroa.100.116.vec.extract = extractelement <4 x float> %acc_o.sroa.100.0, i64 1, !dbg !130
  %151 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.100.116.vec.extract), !dbg !131
  %O_reg.sroa.37.58.insert.ext = zext i16 %151 to i64, !dbg !135
  %O_reg.sroa.37.58.insert.shift = shl nuw nsw i64 %O_reg.sroa.37.58.insert.ext, 16, !dbg !135
  %O_reg.sroa.37.58.insert.insert = or disjoint i64 %O_reg.sroa.37.58.insert.shift, %O_reg.sroa.37.56.insert.ext, !dbg !135
  %acc_o.sroa.100.120.vec.extract = extractelement <4 x float> %acc_o.sroa.100.0, i64 2, !dbg !130
  %152 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.100.120.vec.extract), !dbg !131
  %O_reg.sroa.37.60.insert.ext = zext i16 %152 to i64, !dbg !135
  %O_reg.sroa.37.60.insert.shift = shl nuw nsw i64 %O_reg.sroa.37.60.insert.ext, 32, !dbg !135
  %O_reg.sroa.37.60.insert.insert = or disjoint i64 %O_reg.sroa.37.58.insert.insert, %O_reg.sroa.37.60.insert.shift, !dbg !135
  %acc_o.sroa.100.124.vec.extract = extractelement <4 x float> %acc_o.sroa.100.0, i64 3, !dbg !130
  %153 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.100.124.vec.extract), !dbg !131
  %O_reg.sroa.37.62.insert.ext = zext i16 %153 to i64, !dbg !135
  %O_reg.sroa.37.62.insert.shift = shl nuw i64 %O_reg.sroa.37.62.insert.ext, 48, !dbg !135
  %O_reg.sroa.37.62.insert.insert = or disjoint i64 %O_reg.sroa.37.60.insert.insert, %O_reg.sroa.37.62.insert.shift, !dbg !135
  fence syncscope("warp") release, !dbg !136
  tail call void @llvm.mxc.barrier.warp(), !dbg !139
  fence syncscope("warp") acquire, !dbg !140
  %and425 = shl nuw nsw i32 %1, 7
  %mul426 = and i32 %and425, 1920
  %shr429 = lshr i32 %1, 5
  %154 = lshr i32 %1, 2
  %mul439 = and i32 %154, 4
  %xor433 = xor i32 %shr429, %and432.pre-phi, !dbg !141
  %mul434 = shl nuw nsw i32 %xor433, 3, !dbg !142
  %add435 = add nuw nsw i32 %mul434, %mul426, !dbg !143
  %add440 = or disjoint i32 %add435, %mul439, !dbg !144
  %add.ptr442 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add440, !dbg !145
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr442, align 8, !dbg !146
  %add430.1 = add nuw nsw i32 %shr429, 2, !dbg !147
  %xor433.1 = xor i32 %add430.1, %and432.pre-phi, !dbg !141
  %mul434.1 = shl nuw nsw i32 %xor433.1, 3, !dbg !142
  %add435.1 = add nuw nsw i32 %mul434.1, %mul426, !dbg !143
  %add440.1 = or disjoint i32 %add435.1, %mul439, !dbg !144
  %add.ptr442.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add440.1, !dbg !145
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr442.1, align 8, !dbg !146
  %add430.2 = add nuw nsw i32 %shr429, 4, !dbg !147
  %xor433.2 = xor i32 %add430.2, %and432.pre-phi, !dbg !141
  %mul434.2 = shl nuw nsw i32 %xor433.2, 3, !dbg !142
  %add435.2 = add nuw nsw i32 %mul434.2, %mul426, !dbg !143
  %add440.2 = or disjoint i32 %add435.2, %mul439, !dbg !144
  %add.ptr442.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add440.2, !dbg !145
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr442.2, align 8, !dbg !146
  %add430.3 = add nuw nsw i32 %shr429, 6, !dbg !147
  %xor433.3 = xor i32 %add430.3, %and432.pre-phi, !dbg !141
  %mul434.3 = shl nuw nsw i32 %xor433.3, 3, !dbg !142
  %add435.3 = add nuw nsw i32 %mul434.3, %mul426, !dbg !143
  %add440.3 = or disjoint i32 %add435.3, %mul439, !dbg !144
  %add.ptr442.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add440.3, !dbg !145
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr442.3, align 8, !dbg !146
  %add430.4 = add nuw nsw i32 %shr429, 8, !dbg !147
  %xor433.4 = xor i32 %add430.4, %and432.pre-phi, !dbg !141
  %mul434.4 = shl nuw nsw i32 %xor433.4, 3, !dbg !142
  %add435.4 = add nuw nsw i32 %mul434.4, %mul426, !dbg !143
  %add440.4 = or disjoint i32 %add435.4, %mul439, !dbg !144
  %add.ptr442.4 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add440.4, !dbg !145
  store i64 %O_reg.sroa.22.38.insert.insert, ptr addrspace(3) %add.ptr442.4, align 8, !dbg !146
  %add430.5 = add nuw nsw i32 %shr429, 10, !dbg !147
  %xor433.5 = xor i32 %add430.5, %and432.pre-phi, !dbg !141
  %mul434.5 = shl nuw nsw i32 %xor433.5, 3, !dbg !142
  %add435.5 = add nuw nsw i32 %mul434.5, %mul426, !dbg !143
  %add440.5 = or disjoint i32 %add435.5, %mul439, !dbg !144
  %add.ptr442.5 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add440.5, !dbg !145
  store i64 %O_reg.sroa.27.46.insert.insert, ptr addrspace(3) %add.ptr442.5, align 8, !dbg !146
  %add430.6 = add nuw nsw i32 %shr429, 12, !dbg !147
  %xor433.6 = xor i32 %add430.6, %and432.pre-phi, !dbg !141
  %mul434.6 = shl nuw nsw i32 %xor433.6, 3, !dbg !142
  %add435.6 = add nuw nsw i32 %mul434.6, %mul426, !dbg !143
  %add440.6 = or disjoint i32 %add435.6, %mul439, !dbg !144
  %add.ptr442.6 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add440.6, !dbg !145
  store i64 %O_reg.sroa.32.54.insert.insert, ptr addrspace(3) %add.ptr442.6, align 8, !dbg !146
  %add430.7 = add nuw nsw i32 %shr429, 14, !dbg !147
  %xor433.7 = xor i32 %add430.7, %and432.pre-phi, !dbg !141
  %mul434.7 = shl nuw nsw i32 %xor433.7, 3, !dbg !142
  %add435.7 = add nuw nsw i32 %mul434.7, %mul426, !dbg !143
  %add440.7 = or disjoint i32 %add435.7, %mul439, !dbg !144
  %add.ptr442.7 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add440.7, !dbg !145
  store i64 %O_reg.sroa.37.62.insert.insert, ptr addrspace(3) %add.ptr442.7, align 8, !dbg !146
  fence syncscope("warp") release, !dbg !148
  tail call void @llvm.mxc.barrier.warp(), !dbg !151
  fence syncscope("warp") acquire, !dbg !152
  %mul453 = and i32 %mul8, 8064
  %shr459 = lshr i32 %1, 4
  %invariant.gep612 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul453, !dbg !153
  %xor461 = xor i32 %shr459, %and432.pre-phi, !dbg !154
  %add.ptr465.idx = shl nuw nsw i32 %xor461, 4, !dbg !155
  %add.ptr465 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 %add.ptr465.idx, !dbg !155
  %add.ptr474 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %2, !dbg !156
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr474, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr465, i64 16, i1 false), !dbg !157, !tbaa.struct !158, !call_argsrelate !159
  %155 = add nuw nsw i32 %shr459, 4, !dbg !160
  %xor461.1 = xor i32 %155, %and432.pre-phi, !dbg !154
  %gep613.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 1024, !dbg !155
  %add.ptr465.idx.1 = shl nuw nsw i32 %xor461.1, 4, !dbg !155
  %add.ptr465.1 = getelementptr inbounds i8, ptr addrspace(3) %gep613.1, i32 %add.ptr465.idx.1, !dbg !155
  %add.ptr474.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3, !dbg !156
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr474.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr465.1, i64 16, i1 false), !dbg !157, !tbaa.struct !158, !call_argsrelate !159
  %156 = add nuw nsw i32 %shr459, 8, !dbg !160
  %xor461.2 = xor i32 %156, %and432.pre-phi, !dbg !154
  %gep613.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 2048, !dbg !155
  %add.ptr465.idx.2 = shl nuw nsw i32 %xor461.2, 4, !dbg !155
  %add.ptr465.2 = getelementptr inbounds i8, ptr addrspace(3) %gep613.2, i32 %add.ptr465.idx.2, !dbg !155
  %add.ptr474.2 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4, !dbg !156
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr474.2, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr465.2, i64 16, i1 false), !dbg !157, !tbaa.struct !158, !call_argsrelate !159
  %narrow = add nuw nsw i32 %shr459, 12, !dbg !160
  %xor461.3 = xor i32 %narrow, %and432.pre-phi, !dbg !154
  %gep613.3 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 3072, !dbg !155
  %add.ptr465.idx.3 = shl nuw nsw i32 %xor461.3, 4, !dbg !155
  %add.ptr465.3 = getelementptr inbounds i8, ptr addrspace(3) %gep613.3, i32 %add.ptr465.idx.3, !dbg !155
  %add.ptr474.3 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %5, !dbg !156
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr474.3, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr465.3, i64 16, i1 false), !dbg !157, !tbaa.struct !158, !call_argsrelate !159
  ret void, !dbg !161
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

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare i16 @llvm.convert.to.fp16.f32(float) #7

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

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noalias nocapture writeonly, ptr addrspace(4) noalias nocapture readonly, i64, i1 immarg) #10

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { convergent nounwind willreturn }
attributes #7 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #8 = { nounwind willreturn }
attributes #9 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmpmsau1flh/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpmsau1flh/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 28, column: 3, scope: !40)
!44 = !DILocation(line: 29, column: 92, scope: !40)
!45 = !DILocation(line: 31, column: 25, scope: !40)
!46 = !DILocation(line: 37, column: 30, scope: !40)
!47 = !DILocation(line: 29, column: 48, scope: !40)
!48 = !DILocation(line: 40, column: 5, scope: !40)
!49 = !DILocation(line: 43, column: 79, scope: !40)
!50 = !DILocation(line: 43, column: 58, scope: !40)
!51 = !DILocation(line: 43, column: 155, scope: !40)
!52 = !DILocation(line: 50, column: 79, scope: !40)
!53 = !DILocation(line: 50, column: 58, scope: !40)
!54 = !DILocation(line: 54, column: 5, scope: !40)
!55 = !DILocation(line: 55, column: 125, scope: !40)
!56 = !DILocation(line: 55, column: 42, scope: !40)
!57 = !DILocation(line: 55, column: 175, scope: !40)
!58 = !{i32 1, i32 3, i32 -1, i32 -1}
!59 = !DILocation(line: 55, column: 138, scope: !40)
!60 = !DILocation(line: 68, column: 3, scope: !61, inlinedAt: !63)
!61 = distinct !DISubprogram(name: "__barrier_warp", scope: !62, file: !62, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!62 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!63 = distinct !DILocation(line: 192, column: 3, scope: !64, inlinedAt: !65)
!64 = distinct !DISubprogram(name: "__syncwarp", scope: !62, file: !62, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!65 = distinct !DILocation(line: 57, column: 5, scope: !40)
!66 = !DILocation(line: 69, column: 3, scope: !61, inlinedAt: !63)
!67 = !DILocation(line: 70, column: 3, scope: !61, inlinedAt: !63)
!68 = !DILocation(line: 60, column: 73, scope: !40)
!69 = !DILocation(line: 60, column: 36, scope: !40)
!70 = !DILocation(line: 68, column: 3, scope: !61, inlinedAt: !71)
!71 = distinct !DILocation(line: 192, column: 3, scope: !64, inlinedAt: !72)
!72 = distinct !DILocation(line: 62, column: 5, scope: !40)
!73 = !DILocation(line: 69, column: 3, scope: !61, inlinedAt: !71)
!74 = !DILocation(line: 70, column: 3, scope: !61, inlinedAt: !71)
!75 = !DILocation(line: 65, column: 175, scope: !40)
!76 = !DILocation(line: 68, column: 3, scope: !61, inlinedAt: !77)
!77 = distinct !DILocation(line: 192, column: 3, scope: !64, inlinedAt: !78)
!78 = distinct !DILocation(line: 82, column: 5, scope: !40)
!79 = !DILocation(line: 69, column: 3, scope: !61, inlinedAt: !77)
!80 = !DILocation(line: 70, column: 3, scope: !61, inlinedAt: !77)
!81 = !DILocation(line: 84, column: 25, scope: !40)
!82 = !DILocation(line: 87, column: 36, scope: !40)
!83 = !DILocation(line: 68, column: 3, scope: !61, inlinedAt: !84)
!84 = distinct !DILocation(line: 192, column: 3, scope: !64, inlinedAt: !85)
!85 = distinct !DILocation(line: 93, column: 5, scope: !40)
!86 = !DILocation(line: 69, column: 3, scope: !61, inlinedAt: !84)
!87 = !DILocation(line: 70, column: 3, scope: !61, inlinedAt: !84)
!88 = !DILocation(line: 95, column: 10, scope: !40)
!89 = !DILocation(line: 96, column: 86, scope: !40)
!90 = !DILocation(line: 96, column: 42, scope: !40)
!91 = !DILocation(line: 100, column: 31, scope: !40)
!92 = !DILocation(line: 100, column: 42, scope: !40)
!93 = !DILocation(line: 354, column: 10, scope: !94, inlinedAt: !96)
!94 = distinct !DISubprogram(name: "min", scope: !95, file: !95, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!95 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!96 = distinct !DILocation(line: 100, column: 26, scope: !40)
!97 = !DILocation(line: 285, column: 49, scope: !98, inlinedAt: !99)
!98 = distinct !DISubprogram(name: "exp2f", scope: !95, file: !95, line: 285, type: !7, scopeLine: 285, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!99 = distinct !DILocation(line: 100, column: 20, scope: !40)
!100 = !DILocation(line: 105, column: 34, scope: !40)
!101 = !DILocation(line: 110, column: 42, scope: !40)
!102 = !DILocation(line: 115, column: 36, scope: !40)
!103 = !DILocation(line: 115, column: 34, scope: !40)
!104 = !DILocation(line: 115, column: 9, scope: !40)
!105 = !DILocation(line: 123, column: 32, scope: !40)
!106 = !DILocation(line: 75, column: 10, scope: !107, inlinedAt: !109)
!107 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !108, file: !108, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!108 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!109 = distinct !DILocation(line: 984, column: 9, scope: !110, inlinedAt: !112)
!110 = distinct !DISubprogram(name: "__float2half", scope: !111, file: !111, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!111 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!112 = distinct !DILocation(line: 133, column: 53, scope: !113, inlinedAt: !114)
!113 = distinct !DISubprogram(name: "__half", scope: !111, file: !111, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!114 = distinct !DILocation(line: 127, column: 32, scope: !40)
!115 = !DILocation(line: 127, column: 29, scope: !40)
!116 = !DILocation(line: 68, column: 3, scope: !61, inlinedAt: !117)
!117 = distinct !DILocation(line: 192, column: 3, scope: !64, inlinedAt: !118)
!118 = distinct !DILocation(line: 129, column: 5, scope: !40)
!119 = !DILocation(line: 69, column: 3, scope: !61, inlinedAt: !117)
!120 = !DILocation(line: 70, column: 3, scope: !61, inlinedAt: !117)
!121 = !DILocation(line: 130, column: 3, scope: !40)
!122 = !DILocation(line: 136, column: 30, scope: !40)
!123 = !DILocation(line: 139, column: 120, scope: !40)
!124 = !DILocation(line: 139, column: 31, scope: !40)
!125 = !DILocation(line: 139, column: 29, scope: !40)
!126 = !{!26, !26, i64 0}
!127 = !DILocation(line: 144, column: 38, scope: !40)
!128 = !DILocation(line: 151, column: 3, scope: !40)
!129 = !DILocation(line: 0, scope: !40)
!130 = !DILocation(line: 154, column: 58, scope: !40)
!131 = !DILocation(line: 75, column: 10, scope: !107, inlinedAt: !132)
!132 = distinct !DILocation(line: 984, column: 9, scope: !110, inlinedAt: !133)
!133 = distinct !DILocation(line: 133, column: 53, scope: !113, inlinedAt: !134)
!134 = distinct !DILocation(line: 154, column: 50, scope: !40)
!135 = !DILocation(line: 154, column: 47, scope: !40)
!136 = !DILocation(line: 68, column: 3, scope: !61, inlinedAt: !137)
!137 = distinct !DILocation(line: 192, column: 3, scope: !64, inlinedAt: !138)
!138 = distinct !DILocation(line: 157, column: 3, scope: !40)
!139 = !DILocation(line: 69, column: 3, scope: !61, inlinedAt: !137)
!140 = !DILocation(line: 70, column: 3, scope: !61, inlinedAt: !137)
!141 = !DILocation(line: 160, column: 123, scope: !40)
!142 = !DILocation(line: 160, column: 152, scope: !40)
!143 = !DILocation(line: 160, column: 78, scope: !40)
!144 = !DILocation(line: 160, column: 158, scope: !40)
!145 = !DILocation(line: 160, column: 40, scope: !40)
!146 = !DILocation(line: 160, column: 201, scope: !40)
!147 = !DILocation(line: 160, column: 94, scope: !40)
!148 = !DILocation(line: 68, column: 3, scope: !61, inlinedAt: !149)
!149 = distinct !DILocation(line: 192, column: 3, scope: !64, inlinedAt: !150)
!150 = distinct !DILocation(line: 162, column: 3, scope: !40)
!151 = !DILocation(line: 69, column: 3, scope: !61, inlinedAt: !149)
!152 = !DILocation(line: 70, column: 3, scope: !61, inlinedAt: !149)
!153 = !DILocation(line: 164, column: 8, scope: !40)
!154 = !DILocation(line: 165, column: 219, scope: !40)
!155 = !DILocation(line: 165, column: 135, scope: !40)
!156 = !DILocation(line: 165, column: 22, scope: !40)
!157 = !DILocation(line: 165, column: 98, scope: !40)
!158 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!159 = !{i32 2, i32 -1, i32 -1, i32 -1}
!160 = !DILocation(line: 165, column: 233, scope: !40)
!161 = !DILocation(line: 167, column: 1, scope: !40)
