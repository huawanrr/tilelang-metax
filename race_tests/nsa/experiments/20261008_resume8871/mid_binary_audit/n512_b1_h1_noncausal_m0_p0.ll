; ModuleID = 'experiments/20261008_resume8871/mid_binary_audit/n512_b1_h1_noncausal_m0_p0.bc'
source_filename = "/tmp/tmpcpfk66p5/tvm_kernels.maca"
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
  %mul = shl nsw i32 %0, 10
  %1 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %mul8 = shl nuw nsw i32 %1, 3
  %add = add nuw nsw i32 %mul8, %mul
  %2 = zext nneg i32 %add to i64, !dbg !43
  %3 = add nuw nsw i64 %2, 512, !dbg !44
  %idxprom = zext nneg i32 %0 to i64, !dbg !45
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom, !dbg !45
  %4 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !45, !tbaa !30
  %cmp28 = icmp ult i32 %4, 32
  br i1 %cmp28, label %for.cond31.preheader, label %if.end304, !dbg !46

for.cond31.preheader:                             ; preds = %entry
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !47
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %2, !dbg !47
  %mul40 = shl nuw nsw i32 %4, 10
  %add42 = add nuw nsw i32 %mul40, %mul8
  %5 = zext nneg i32 %add42 to i64, !dbg !48
  %add.ptr49 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %5, !dbg !49
  %6 = load i32, ptr addrspace(4) %add.ptr49, align 4, !dbg !50, !tbaa !30
  %7 = or disjoint i64 %5, 2, !dbg !51
  %add.ptr49.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %7, !dbg !49
  %8 = load i32, ptr addrspace(4) %add.ptr49.1, align 4, !dbg !50, !tbaa !30
  %9 = or disjoint i64 %5, 4, !dbg !51
  %add.ptr49.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %9, !dbg !49
  %10 = load i32, ptr addrspace(4) %add.ptr49.2, align 4, !dbg !50, !tbaa !30
  %11 = or disjoint i64 %5, 6, !dbg !51
  %add.ptr49.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %11, !dbg !49
  %12 = load i32, ptr addrspace(4) %add.ptr49.3, align 4, !dbg !50, !tbaa !30
  %13 = add nuw nsw i64 %5, 512
  %add.ptr49.1613 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %13, !dbg !49
  %14 = load i32, ptr addrspace(4) %add.ptr49.1613, align 4, !dbg !50, !tbaa !30
  %15 = add nuw nsw i64 %5, 514, !dbg !51
  %add.ptr49.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %15, !dbg !49
  %16 = load i32, ptr addrspace(4) %add.ptr49.1.1, align 4, !dbg !50, !tbaa !30
  %17 = add nuw nsw i64 %5, 516, !dbg !51
  %add.ptr49.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %17, !dbg !49
  %18 = load i32, ptr addrspace(4) %add.ptr49.2.1, align 4, !dbg !50, !tbaa !30
  %19 = add nuw nsw i64 %5, 518, !dbg !51
  %add.ptr49.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %19, !dbg !49
  %20 = load i32, ptr addrspace(4) %add.ptr49.3.1, align 4, !dbg !50, !tbaa !30
  %add.ptr79 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %5, !dbg !52
  %21 = load i32, ptr addrspace(4) %add.ptr79, align 4, !dbg !53, !tbaa !30
  %add.ptr79.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %7, !dbg !52
  %22 = load i32, ptr addrspace(4) %add.ptr79.1, align 4, !dbg !53, !tbaa !30
  %add.ptr79.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %9, !dbg !52
  %23 = load i32, ptr addrspace(4) %add.ptr79.2, align 4, !dbg !53, !tbaa !30
  %add.ptr79.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %11, !dbg !52
  %24 = load i32, ptr addrspace(4) %add.ptr79.3, align 4, !dbg !53, !tbaa !30
  %add.ptr79.1625 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %13, !dbg !52
  %25 = load i32, ptr addrspace(4) %add.ptr79.1625, align 4, !dbg !53, !tbaa !30
  %add.ptr79.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %15, !dbg !52
  %26 = load i32, ptr addrspace(4) %add.ptr79.1.1, align 4, !dbg !53, !tbaa !30
  %add.ptr79.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %17, !dbg !52
  %27 = load i32, ptr addrspace(4) %add.ptr79.2.1, align 4, !dbg !53, !tbaa !30
  %add.ptr79.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %19, !dbg !52
  %28 = load i32, ptr addrspace(4) %add.ptr79.3.1, align 4, !dbg !53, !tbaa !30
  %mul102 = and i32 %mul8, 8128
  %xor551 = and i32 %mul8, 56
  %call105.masked = and i32 %1, 1016
  %mul107 = xor i32 %xor551, %call105.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul102, !dbg !54
  %invariant.gep566 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul107, !dbg !54
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep566, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !dbg !55, !call_argsrelate !56
  %gep567.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep566, i32 1024, !dbg !57
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep567.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !dbg !55, !call_argsrelate !56
  fence syncscope("warp") release, !dbg !58
  tail call void @llvm.mxc.barrier.warp(), !dbg !64
  fence syncscope("warp") acquire, !dbg !65
  %and119 = shl nuw nsw i32 %1, 6
  %mul120 = and i32 %and119, 960
  %shr123 = lshr i32 %1, 4
  %and126 = and i32 %1, 7
  %29 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul120
  %xor127 = xor i32 %shr123, %and126, !dbg !66
  %add.ptr131.idx = shl nuw nsw i32 %xor127, 4, !dbg !67
  %add.ptr131 = getelementptr inbounds i8, ptr addrspace(3) %29, i32 %add.ptr131.idx, !dbg !67
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr131, align 16, !dbg !68
  %Q_reg.sroa.4.0.add.ptr131.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr131, i32 8, !dbg !68
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr131.sroa_idx, align 8, !dbg !68
  %add124.1 = add nuw nsw i32 %shr123, 4, !dbg !69
  %xor127.1 = xor i32 %add124.1, %and126, !dbg !66
  %add.ptr131.idx.1 = shl nuw nsw i32 %xor127.1, 4, !dbg !67
  %add.ptr131.1 = getelementptr inbounds i8, ptr addrspace(3) %29, i32 %add.ptr131.idx.1, !dbg !67
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr131.1, align 16, !dbg !68
  %Q_reg.sroa.7.16.add.ptr131.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr131.1, i32 8, !dbg !68
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr131.1.sroa_idx, align 8, !dbg !68
  fence syncscope("warp") release, !dbg !70
  tail call void @llvm.mxc.barrier.warp(), !dbg !73
  fence syncscope("warp") acquire, !dbg !74
  store i32 %6, ptr addrspace(3) %invariant.gep566, align 16, !dbg !75, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep571.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep566, i32 4, !dbg !75
  store i32 %8, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep571.sroa_idx, align 4, !dbg !75, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep571.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep566, i32 8, !dbg !75
  store i32 %10, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep571.sroa_idx, align 8, !dbg !75, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep571.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep566, i32 12, !dbg !75
  store i32 %12, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep571.sroa_idx, align 4, !dbg !75, !tbaa !30
  store i32 %14, ptr addrspace(3) %gep567.1, align 16, !dbg !75, !tbaa !30
  %K_reg.sroa.9.16.gep572.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep566, i32 1028, !dbg !75
  store i32 %16, ptr addrspace(3) %K_reg.sroa.9.16.gep572.1.sroa_idx, align 4, !dbg !75, !tbaa !30
  %K_reg.sroa.10.16.gep572.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep566, i32 1032, !dbg !75
  store i32 %18, ptr addrspace(3) %K_reg.sroa.10.16.gep572.1.sroa_idx, align 8, !dbg !75, !tbaa !30
  %K_reg.sroa.11.16.gep572.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep566, i32 1036, !dbg !75
  store i32 %20, ptr addrspace(3) %K_reg.sroa.11.16.gep572.1.sroa_idx, align 4, !dbg !75, !tbaa !30
  fence syncscope("warp") release, !dbg !76
  tail call void @llvm.mxc.barrier.warp(), !dbg !79
  fence syncscope("warp") acquire, !dbg !80
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr131, align 16, !dbg !81
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr131.sroa_idx, align 8, !dbg !81
  %30 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !82
  %31 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %30), !dbg !82
  %kb.sroa.0.0.copyload655 = load <4 x half>, ptr addrspace(3) %add.ptr131.1, align 16, !dbg !81
  %kb.sroa.6.0.copyload656 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr131.1.sroa_idx, align 8, !dbg !81
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload655, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %31), !dbg !82
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload656, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %32), !dbg !82
  fence syncscope("warp") release, !dbg !83
  tail call void @llvm.mxc.barrier.warp(), !dbg !86
  fence syncscope("warp") acquire, !dbg !87
  %add.ptr223.idx = shl nuw nsw i32 %1, 4
  %invariant.gep579 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr223.idx, !dbg !88
  store i32 %21, ptr addrspace(3) %invariant.gep579, align 16, !dbg !89, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep579.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep579, i32 4, !dbg !89
  store i32 %22, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep579.sroa_idx, align 4, !dbg !89, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep579.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep579, i32 8, !dbg !89
  store i32 %23, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep579.sroa_idx, align 8, !dbg !89, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep579.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep579, i32 12, !dbg !89
  store i32 %24, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep579.sroa_idx, align 4, !dbg !89, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep579, i32 1024, !dbg !90
  store i32 %25, ptr addrspace(3) %gep.1, align 16, !dbg !89, !tbaa !30
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep579, i32 1028, !dbg !89
  store i32 %26, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !dbg !89, !tbaa !30
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep579, i32 1032, !dbg !89
  store i32 %27, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !dbg !89, !tbaa !30
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep579, i32 1036, !dbg !89
  store i32 %28, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !dbg !89, !tbaa !30
  %34 = shl nuw nsw i32 %4, 2
  %add236 = add nuw nsw i32 %34, %shr123
  %cmp237 = icmp ult i32 %add236, 128
  br i1 %cmp237, label %if.then238, label %if.end, !dbg !91

if.then238:                                       ; preds = %for.cond31.preheader
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %33, i64 0, !dbg !92
  %mul241 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !93
  %35 = tail call contract noundef float @llvm.minnum.f32(float %mul241, float 0x4024CB5EC0000000), !dbg !94
  %36 = tail call contract noundef float @llvm.exp.f32(float %35), !dbg !98
  br label %if.end, !dbg !101

if.end:                                           ; preds = %for.cond31.preheader, %if.then238
  %condval.0 = phi float [ %36, %if.then238 ], [ 0.000000e+00, %for.cond31.preheader ], !dbg !102
  br i1 %cmp237, label %if.then238.1, label %if.end.1, !dbg !91

if.then238.1:                                     ; preds = %if.end
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %33, i64 1, !dbg !92
  %mul241.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !93
  %37 = tail call contract noundef float @llvm.minnum.f32(float %mul241.1, float 0x4024CB5EC0000000), !dbg !94
  %38 = tail call contract noundef float @llvm.exp.f32(float %37), !dbg !98
  br label %if.end.1, !dbg !101

if.end.1:                                         ; preds = %if.then238.1, %if.end
  %condval.0.1 = phi float [ %38, %if.then238.1 ], [ 0.000000e+00, %if.end ], !dbg !102
  br i1 %cmp237, label %if.then238.2, label %if.end.2, !dbg !91

if.then238.2:                                     ; preds = %if.end.1
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %33, i64 2, !dbg !92
  %mul241.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !93
  %39 = tail call contract noundef float @llvm.minnum.f32(float %mul241.2, float 0x4024CB5EC0000000), !dbg !94
  %40 = tail call contract noundef float @llvm.exp.f32(float %39), !dbg !98
  br label %if.end.2, !dbg !101

if.end.2:                                         ; preds = %if.then238.2, %if.end.1
  %condval.0.2 = phi float [ %40, %if.then238.2 ], [ 0.000000e+00, %if.end.1 ], !dbg !102
  br i1 %cmp237, label %if.then238.3, label %if.end.3, !dbg !91

if.then238.3:                                     ; preds = %if.end.2
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %33, i64 3, !dbg !92
  %mul241.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !93
  %41 = tail call contract noundef float @llvm.minnum.f32(float %mul241.3, float 0x4024CB5EC0000000), !dbg !94
  %42 = tail call contract noundef float @llvm.exp.f32(float %41), !dbg !98
  br label %if.end.3, !dbg !101

if.end.3:                                         ; preds = %if.then238.3, %if.end.2
  %condval.0.3 = phi float [ %42, %if.then238.3 ], [ 0.000000e+00, %if.end.2 ], !dbg !102
  %add257.1 = fadd contract float %condval.0, %condval.0.1, !dbg !103
  %add257.2 = fadd contract float %add257.1, %condval.0.2, !dbg !103
  %add257.3 = fadd contract float %add257.2, %condval.0.3, !dbg !103
  %43 = bitcast float %add257.3 to i32, !dbg !104
  %44 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !107
  %45 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %44) #11, !dbg !112
  %xor.i.i = xor i32 %45, 32, !dbg !113
  %46 = and i32 %45, -64, !dbg !114
  %and.i.i = add nsw i32 %46, 64, !dbg !114
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !115
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %45, !dbg !116
  %shl.i.i = shl i32 %cond.i.i, 2, !dbg !117
  %47 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %43), !dbg !118
  %48 = bitcast i32 %47 to float, !dbg !119
  %add265 = fadd contract float %add257.3, %48, !dbg !120
  %49 = bitcast float %add265 to i32, !dbg !121
  %50 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !123
  %51 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %50) #11, !dbg !126
  %xor.i.i553 = xor i32 %51, 16, !dbg !127
  %52 = and i32 %51, -64, !dbg !128
  %and.i.i554 = add nsw i32 %52, 64, !dbg !128
  %cmp.not.i.i555 = icmp slt i32 %xor.i.i553, %and.i.i554, !dbg !129
  %cond.i.i556 = select i1 %cmp.not.i.i555, i32 %xor.i.i553, i32 %51, !dbg !130
  %shl.i.i557 = shl i32 %cond.i.i556, 2, !dbg !131
  %53 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i557, i32 %49), !dbg !132
  %54 = bitcast i32 %53 to float, !dbg !133
  %add270 = fadd contract float %add265, %54, !dbg !134
  %cmp273 = fcmp contract ogt float %add270, 0.000000e+00, !dbg !135
  %div = fdiv contract float 1.000000e+00, %add270, !dbg !136
  %condval_1.0 = select i1 %cmp273, float %div, float 0.000000e+00, !dbg !136
  %mul286 = fmul contract float %condval_1.0, %condval.0, !dbg !137
  %mul286.1 = fmul contract float %condval_1.0, %condval.0.1, !dbg !137
  %mul286.2 = fmul contract float %condval_1.0, %condval.0.2, !dbg !137
  %mul286.3 = fmul contract float %condval_1.0, %condval.0.3, !dbg !137
  %55 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul286), !dbg !138
  %56 = insertelement <4 x i16> poison, i16 %55, i64 0, !dbg !147
  %57 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul286.1), !dbg !138
  %58 = insertelement <4 x i16> %56, i16 %57, i64 1, !dbg !147
  %59 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul286.2), !dbg !138
  %60 = insertelement <4 x i16> %58, i16 %59, i64 2, !dbg !147
  %61 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul286.3), !dbg !138
  %62 = insertelement <4 x i16> %60, i16 %61, i64 3, !dbg !147
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %62 to <4 x half>, !dbg !147
  fence syncscope("warp") release, !dbg !148
  tail call void @llvm.mxc.barrier.warp(), !dbg !151
  fence syncscope("warp") acquire, !dbg !152
  br label %if.end304, !dbg !153

if.end304:                                        ; preds = %if.end.3, %entry
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ %acc_s_cast.sroa.0.6.vec.insert, %if.end.3 ], [ undef, %entry ]
  br i1 %cmp28, label %for.cond322.preheader, label %if.end370, !dbg !154

for.cond322.preheader:                            ; preds = %if.end304
  %63 = shl nuw nsw i32 %1, 4
  %mul332 = and i32 %63, 16128
  %and338 = and i32 %1, 15
  %add339 = or disjoint i32 %mul332, %and338, !dbg !155
  %arrayidx341 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339, !dbg !156
  %64 = load half, ptr addrspace(3) %arrayidx341, align 2, !dbg !157, !tbaa !158
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %64, i64 0, !dbg !157
  %add334.1 = or disjoint i32 %mul332, %and338, !dbg !155
  %add339.1 = or disjoint i32 %add334.1, 64, !dbg !155
  %arrayidx341.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339.1, !dbg !156
  %65 = load half, ptr addrspace(3) %arrayidx341.1, align 2, !dbg !157, !tbaa !158
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %65, i64 1, !dbg !157
  %add334.2 = or disjoint i32 %mul332, %and338, !dbg !155
  %add339.2 = or disjoint i32 %add334.2, 128, !dbg !155
  %arrayidx341.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339.2, !dbg !156
  %66 = load half, ptr addrspace(3) %arrayidx341.2, align 2, !dbg !157, !tbaa !158
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %66, i64 2, !dbg !157
  %add334.3 = or disjoint i32 %mul332, %and338, !dbg !155
  %add339.3 = or disjoint i32 %add334.3, 192, !dbg !155
  %arrayidx341.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339.3, !dbg !156
  %67 = load half, ptr addrspace(3) %arrayidx341.3, align 2, !dbg !157, !tbaa !158
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %67, i64 3, !dbg !157
  %add336.1629 = or disjoint i32 %mul332, %and338, !dbg !155
  %add339.1630 = or disjoint i32 %add336.1629, 16, !dbg !155
  %arrayidx341.1631 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339.1630, !dbg !156
  %68 = load half, ptr addrspace(3) %arrayidx341.1631, align 2, !dbg !157, !tbaa !158
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %68, i64 0, !dbg !157
  %add336.1.1 = or disjoint i32 %mul332, %and338, !dbg !155
  %add339.1.1 = or disjoint i32 %add336.1.1, 80, !dbg !155
  %arrayidx341.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339.1.1, !dbg !156
  %69 = load half, ptr addrspace(3) %arrayidx341.1.1, align 2, !dbg !157, !tbaa !158
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %69, i64 1, !dbg !157
  %add336.2.1 = or disjoint i32 %mul332, %and338, !dbg !155
  %add339.2.1 = or disjoint i32 %add336.2.1, 144, !dbg !155
  %arrayidx341.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339.2.1, !dbg !156
  %70 = load half, ptr addrspace(3) %arrayidx341.2.1, align 2, !dbg !157, !tbaa !158
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %70, i64 2, !dbg !157
  %add336.3.1 = or disjoint i32 %mul332, %and338, !dbg !155
  %add339.3.1 = or disjoint i32 %add336.3.1, 208, !dbg !155
  %arrayidx341.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339.3.1, !dbg !156
  %71 = load half, ptr addrspace(3) %arrayidx341.3.1, align 2, !dbg !157, !tbaa !158
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %71, i64 3, !dbg !157
  %add336.2633 = or disjoint i32 %mul332, %and338, !dbg !155
  %add339.2634 = or disjoint i32 %add336.2633, 32, !dbg !155
  %arrayidx341.2635 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339.2634, !dbg !156
  %72 = load half, ptr addrspace(3) %arrayidx341.2635, align 2, !dbg !157, !tbaa !158
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %72, i64 0, !dbg !157
  %add336.1.2 = or disjoint i32 %mul332, %and338, !dbg !155
  %add339.1.2 = or disjoint i32 %add336.1.2, 96, !dbg !155
  %arrayidx341.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339.1.2, !dbg !156
  %73 = load half, ptr addrspace(3) %arrayidx341.1.2, align 2, !dbg !157, !tbaa !158
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %73, i64 1, !dbg !157
  %add336.2.2 = or disjoint i32 %mul332, %and338, !dbg !155
  %add339.2.2 = or disjoint i32 %add336.2.2, 160, !dbg !155
  %arrayidx341.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339.2.2, !dbg !156
  %74 = load half, ptr addrspace(3) %arrayidx341.2.2, align 2, !dbg !157, !tbaa !158
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %74, i64 2, !dbg !157
  %add336.3.2 = or disjoint i32 %mul332, %and338, !dbg !155
  %add339.3.2 = or disjoint i32 %add336.3.2, 224, !dbg !155
  %arrayidx341.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339.3.2, !dbg !156
  %75 = load half, ptr addrspace(3) %arrayidx341.3.2, align 2, !dbg !157, !tbaa !158
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %75, i64 3, !dbg !157
  %add336.3637 = or disjoint i32 %mul332, %and338, !dbg !155
  %add339.3638 = or disjoint i32 %add336.3637, 48, !dbg !155
  %arrayidx341.3639 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339.3638, !dbg !156
  %76 = load half, ptr addrspace(3) %arrayidx341.3639, align 2, !dbg !157, !tbaa !158
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %76, i64 0, !dbg !157
  %add336.1.3 = or disjoint i32 %mul332, %and338, !dbg !155
  %add339.1.3 = or disjoint i32 %add336.1.3, 112, !dbg !155
  %arrayidx341.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339.1.3, !dbg !156
  %77 = load half, ptr addrspace(3) %arrayidx341.1.3, align 2, !dbg !157, !tbaa !158
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %77, i64 1, !dbg !157
  %add336.2.3 = or disjoint i32 %mul332, %and338, !dbg !155
  %add339.2.3 = or disjoint i32 %add336.2.3, 176, !dbg !155
  %arrayidx341.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339.2.3, !dbg !156
  %78 = load half, ptr addrspace(3) %arrayidx341.2.3, align 2, !dbg !157, !tbaa !158
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %78, i64 2, !dbg !157
  %add336.3.3 = or disjoint i32 %63, %and338, !dbg !155
  %add339.3.3 = or i32 %add336.3.3, 240, !dbg !155
  %arrayidx341.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add339.3.3, !dbg !156
  %79 = load half, ptr addrspace(3) %arrayidx341.3.3, align 2, !dbg !157, !tbaa !158
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %79, i64 3, !dbg !157
  %80 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !159
  %81 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !159
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !159
  %83 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !159
  br label %if.end370, !dbg !160

if.end370:                                        ; preds = %for.cond322.preheader, %if.end304
  %acc_o.sroa.0.0 = phi <4 x float> [ %80, %for.cond322.preheader ], [ zeroinitializer, %if.end304 ], !dbg !102
  %acc_o.sroa.16.0 = phi <4 x float> [ %81, %for.cond322.preheader ], [ zeroinitializer, %if.end304 ], !dbg !102
  %acc_o.sroa.30.0 = phi <4 x float> [ %82, %for.cond322.preheader ], [ zeroinitializer, %if.end304 ], !dbg !102
  %acc_o.sroa.44.0 = phi <4 x float> [ %83, %for.cond322.preheader ], [ zeroinitializer, %if.end304 ], !dbg !102
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0, !dbg !161
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract), !dbg !162
  %O_reg.sroa.0.0.insert.ext = zext i16 %84 to i64, !dbg !166
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1, !dbg !161
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract), !dbg !162
  %O_reg.sroa.0.2.insert.ext = zext i16 %85 to i64, !dbg !166
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !166
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !166
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2, !dbg !161
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract), !dbg !162
  %O_reg.sroa.0.4.insert.ext = zext i16 %86 to i64, !dbg !166
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !166
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !166
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3, !dbg !161
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract), !dbg !162
  %O_reg.sroa.0.6.insert.ext = zext i16 %87 to i64, !dbg !166
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !166
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !166
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0, !dbg !161
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract), !dbg !162
  %O_reg.sroa.7.8.insert.ext = zext i16 %88 to i64, !dbg !166
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1, !dbg !161
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract), !dbg !162
  %O_reg.sroa.7.10.insert.ext = zext i16 %89 to i64, !dbg !166
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !166
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !166
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2, !dbg !161
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract), !dbg !162
  %O_reg.sroa.7.12.insert.ext = zext i16 %90 to i64, !dbg !166
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !166
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !166
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3, !dbg !161
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract), !dbg !162
  %O_reg.sroa.7.14.insert.ext = zext i16 %91 to i64, !dbg !166
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !166
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !166
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0, !dbg !161
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract), !dbg !162
  %O_reg.sroa.12.16.insert.ext = zext i16 %92 to i64, !dbg !166
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1, !dbg !161
  %93 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract), !dbg !162
  %O_reg.sroa.12.18.insert.ext = zext i16 %93 to i64, !dbg !166
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !166
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !166
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2, !dbg !161
  %94 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract), !dbg !162
  %O_reg.sroa.12.20.insert.ext = zext i16 %94 to i64, !dbg !166
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !166
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !166
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3, !dbg !161
  %95 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract), !dbg !162
  %O_reg.sroa.12.22.insert.ext = zext i16 %95 to i64, !dbg !166
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !166
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !166
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0, !dbg !161
  %96 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract), !dbg !162
  %O_reg.sroa.17.24.insert.ext = zext i16 %96 to i64, !dbg !166
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1, !dbg !161
  %97 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract), !dbg !162
  %O_reg.sroa.17.26.insert.ext = zext i16 %97 to i64, !dbg !166
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !166
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !166
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2, !dbg !161
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract), !dbg !162
  %O_reg.sroa.17.28.insert.ext = zext i16 %98 to i64, !dbg !166
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !166
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !166
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3, !dbg !161
  %99 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract), !dbg !162
  %O_reg.sroa.17.30.insert.ext = zext i16 %99 to i64, !dbg !166
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !166
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !166
  fence syncscope("warp") release, !dbg !167
  tail call void @llvm.mxc.barrier.warp(), !dbg !170
  fence syncscope("warp") acquire, !dbg !171
  %and403 = shl nuw nsw i32 %1, 6
  %mul404 = and i32 %and403, 960
  %shr407 = lshr i32 %1, 5
  %and410 = and i32 %1, 7
  %100 = lshr i32 %1, 2
  %mul417 = and i32 %100, 4
  %xor411 = xor i32 %shr407, %and410, !dbg !172
  %mul412 = shl nuw nsw i32 %xor411, 3, !dbg !173
  %add413 = add nuw nsw i32 %mul412, %mul404, !dbg !174
  %add418 = or disjoint i32 %add413, %mul417, !dbg !175
  %add.ptr420 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add418, !dbg !176
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr420, align 8, !dbg !177
  %add408.1 = add nuw nsw i32 %shr407, 2, !dbg !178
  %xor411.1 = xor i32 %add408.1, %and410, !dbg !172
  %mul412.1 = shl nuw nsw i32 %xor411.1, 3, !dbg !173
  %add413.1 = add nuw nsw i32 %mul412.1, %mul404, !dbg !174
  %add418.1 = or disjoint i32 %add413.1, %mul417, !dbg !175
  %add.ptr420.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add418.1, !dbg !176
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr420.1, align 8, !dbg !177
  %add408.2 = add nuw nsw i32 %shr407, 4, !dbg !178
  %xor411.2 = xor i32 %add408.2, %and410, !dbg !172
  %mul412.2 = shl nuw nsw i32 %xor411.2, 3, !dbg !173
  %add413.2 = add nuw nsw i32 %mul412.2, %mul404, !dbg !174
  %add418.2 = or disjoint i32 %add413.2, %mul417, !dbg !175
  %add.ptr420.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add418.2, !dbg !176
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr420.2, align 8, !dbg !177
  %add408.3 = add nuw nsw i32 %shr407, 6, !dbg !178
  %xor411.3 = xor i32 %add408.3, %and410, !dbg !172
  %mul412.3 = shl nuw nsw i32 %xor411.3, 3, !dbg !173
  %add413.3 = add nuw nsw i32 %mul412.3, %mul404, !dbg !174
  %add418.3 = or disjoint i32 %add413.3, %mul417, !dbg !175
  %add.ptr420.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add418.3, !dbg !176
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr420.3, align 8, !dbg !177
  fence syncscope("warp") release, !dbg !179
  tail call void @llvm.mxc.barrier.warp(), !dbg !182
  fence syncscope("warp") acquire, !dbg !183
  %mul431 = and i32 %mul8, 8128
  %xor437547 = and i32 %mul8, 56
  %call435.masked = and i32 %1, 1016
  %mul438 = xor i32 %xor437547, %call435.masked
  %invariant.gep593 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul431, !dbg !184
  %invariant.gep595 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep593, i32 %mul438, !dbg !184
  %add.ptr450 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %2, !dbg !185
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr450, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep595, i64 16, i1 false), !dbg !186, !tbaa.struct !187, !call_argsrelate !188
  %gep596.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep595, i32 1024, !dbg !189
  %add.ptr450.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3, !dbg !185
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr450.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep596.1, i64 16, i1 false), !dbg !186, !tbaa.struct !187, !call_argsrelate !188
  ret void, !dbg !190
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
attributes #11 = { nomerge }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmpcpfk66p5/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpcpfk66p5/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 25, column: 3, scope: !40)
!44 = !DILocation(line: 26, column: 92, scope: !40)
!45 = !DILocation(line: 28, column: 25, scope: !40)
!46 = !DILocation(line: 34, column: 30, scope: !40)
!47 = !DILocation(line: 26, column: 48, scope: !40)
!48 = !DILocation(line: 37, column: 5, scope: !40)
!49 = !DILocation(line: 40, column: 79, scope: !40)
!50 = !DILocation(line: 40, column: 58, scope: !40)
!51 = !DILocation(line: 40, column: 155, scope: !40)
!52 = !DILocation(line: 47, column: 79, scope: !40)
!53 = !DILocation(line: 47, column: 58, scope: !40)
!54 = !DILocation(line: 51, column: 5, scope: !40)
!55 = !DILocation(line: 52, column: 159, scope: !40)
!56 = !{i32 1, i32 3, i32 -1, i32 -1}
!57 = !DILocation(line: 52, column: 42, scope: !40)
!58 = !DILocation(line: 68, column: 3, scope: !59, inlinedAt: !61)
!59 = distinct !DISubprogram(name: "__barrier_warp", scope: !60, file: !60, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!60 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!61 = distinct !DILocation(line: 192, column: 3, scope: !62, inlinedAt: !63)
!62 = distinct !DISubprogram(name: "__syncwarp", scope: !60, file: !60, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!63 = distinct !DILocation(line: 54, column: 5, scope: !40)
!64 = !DILocation(line: 69, column: 3, scope: !59, inlinedAt: !61)
!65 = !DILocation(line: 70, column: 3, scope: !59, inlinedAt: !61)
!66 = !DILocation(line: 57, column: 153, scope: !40)
!67 = !DILocation(line: 57, column: 73, scope: !40)
!68 = !DILocation(line: 57, column: 36, scope: !40)
!69 = !DILocation(line: 57, column: 124, scope: !40)
!70 = !DILocation(line: 68, column: 3, scope: !59, inlinedAt: !71)
!71 = distinct !DILocation(line: 192, column: 3, scope: !62, inlinedAt: !72)
!72 = distinct !DILocation(line: 59, column: 5, scope: !40)
!73 = !DILocation(line: 69, column: 3, scope: !59, inlinedAt: !71)
!74 = !DILocation(line: 70, column: 3, scope: !59, inlinedAt: !71)
!75 = !DILocation(line: 62, column: 159, scope: !40)
!76 = !DILocation(line: 68, column: 3, scope: !59, inlinedAt: !77)
!77 = distinct !DILocation(line: 192, column: 3, scope: !62, inlinedAt: !78)
!78 = distinct !DILocation(line: 66, column: 5, scope: !40)
!79 = !DILocation(line: 69, column: 3, scope: !59, inlinedAt: !77)
!80 = !DILocation(line: 70, column: 3, scope: !59, inlinedAt: !77)
!81 = !DILocation(line: 68, column: 25, scope: !40)
!82 = !DILocation(line: 71, column: 36, scope: !40)
!83 = !DILocation(line: 68, column: 3, scope: !59, inlinedAt: !84)
!84 = distinct !DILocation(line: 192, column: 3, scope: !62, inlinedAt: !85)
!85 = distinct !DILocation(line: 77, column: 5, scope: !40)
!86 = !DILocation(line: 69, column: 3, scope: !59, inlinedAt: !84)
!87 = !DILocation(line: 70, column: 3, scope: !59, inlinedAt: !84)
!88 = !DILocation(line: 79, column: 10, scope: !40)
!89 = !DILocation(line: 80, column: 86, scope: !40)
!90 = !DILocation(line: 80, column: 42, scope: !40)
!91 = !DILocation(line: 85, column: 11, scope: !40)
!92 = !DILocation(line: 86, column: 29, scope: !40)
!93 = !DILocation(line: 86, column: 40, scope: !40)
!94 = !DILocation(line: 354, column: 10, scope: !95, inlinedAt: !97)
!95 = distinct !DISubprogram(name: "min", scope: !96, file: !96, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!96 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!97 = distinct !DILocation(line: 86, column: 24, scope: !40)
!98 = !DILocation(line: 288, column: 10, scope: !99, inlinedAt: !100)
!99 = distinct !DISubprogram(name: "expf", scope: !96, file: !96, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!100 = distinct !DILocation(line: 86, column: 19, scope: !40)
!101 = !DILocation(line: 87, column: 7, scope: !40)
!102 = !DILocation(line: 0, scope: !40)
!103 = !DILocation(line: 95, column: 34, scope: !40)
!104 = !DILocation(line: 1018, column: 9, scope: !105, inlinedAt: !106)
!105 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !60, file: !60, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!106 = distinct !DILocation(line: 97, column: 34, scope: !40)
!107 = !DILocation(line: 171, column: 37, scope: !108, inlinedAt: !109)
!108 = distinct !DISubprogram(name: "__lane_id", scope: !60, file: !60, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!109 = distinct !DILocation(line: 990, column: 14, scope: !110, inlinedAt: !111)
!110 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !60, file: !60, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!111 = distinct !DILocation(line: 1019, column: 11, scope: !105, inlinedAt: !106)
!112 = !DILocation(line: 171, column: 10, scope: !108, inlinedAt: !109)
!113 = !DILocation(line: 991, column: 20, scope: !110, inlinedAt: !111)
!114 = !DILocation(line: 992, column: 36, scope: !110, inlinedAt: !111)
!115 = !DILocation(line: 992, column: 17, scope: !110, inlinedAt: !111)
!116 = !DILocation(line: 992, column: 11, scope: !110, inlinedAt: !111)
!117 = !DILocation(line: 993, column: 43, scope: !110, inlinedAt: !111)
!118 = !DILocation(line: 993, column: 10, scope: !110, inlinedAt: !111)
!119 = !DILocation(line: 1020, column: 14, scope: !105, inlinedAt: !106)
!120 = !DILocation(line: 97, column: 32, scope: !40)
!121 = !DILocation(line: 1018, column: 9, scope: !105, inlinedAt: !122)
!122 = distinct !DILocation(line: 98, column: 34, scope: !40)
!123 = !DILocation(line: 171, column: 37, scope: !108, inlinedAt: !124)
!124 = distinct !DILocation(line: 990, column: 14, scope: !110, inlinedAt: !125)
!125 = distinct !DILocation(line: 1019, column: 11, scope: !105, inlinedAt: !122)
!126 = !DILocation(line: 171, column: 10, scope: !108, inlinedAt: !124)
!127 = !DILocation(line: 991, column: 20, scope: !110, inlinedAt: !125)
!128 = !DILocation(line: 992, column: 36, scope: !110, inlinedAt: !125)
!129 = !DILocation(line: 992, column: 17, scope: !110, inlinedAt: !125)
!130 = !DILocation(line: 992, column: 11, scope: !110, inlinedAt: !125)
!131 = !DILocation(line: 993, column: 43, scope: !110, inlinedAt: !125)
!132 = !DILocation(line: 993, column: 10, scope: !110, inlinedAt: !125)
!133 = !DILocation(line: 1020, column: 14, scope: !105, inlinedAt: !122)
!134 = !DILocation(line: 98, column: 32, scope: !40)
!135 = !DILocation(line: 100, column: 34, scope: !40)
!136 = !DILocation(line: 100, column: 9, scope: !40)
!137 = !DILocation(line: 108, column: 32, scope: !40)
!138 = !DILocation(line: 75, column: 10, scope: !139, inlinedAt: !141)
!139 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !140, file: !140, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!140 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!141 = distinct !DILocation(line: 984, column: 9, scope: !142, inlinedAt: !144)
!142 = distinct !DISubprogram(name: "__float2half", scope: !143, file: !143, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!143 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!144 = distinct !DILocation(line: 133, column: 53, scope: !145, inlinedAt: !146)
!145 = distinct !DISubprogram(name: "__half", scope: !143, file: !143, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!146 = distinct !DILocation(line: 112, column: 32, scope: !40)
!147 = !DILocation(line: 112, column: 29, scope: !40)
!148 = !DILocation(line: 68, column: 3, scope: !59, inlinedAt: !149)
!149 = distinct !DILocation(line: 192, column: 3, scope: !62, inlinedAt: !150)
!150 = distinct !DILocation(line: 114, column: 5, scope: !40)
!151 = !DILocation(line: 69, column: 3, scope: !59, inlinedAt: !149)
!152 = !DILocation(line: 70, column: 3, scope: !59, inlinedAt: !149)
!153 = !DILocation(line: 115, column: 3, scope: !40)
!154 = !DILocation(line: 121, column: 30, scope: !40)
!155 = !DILocation(line: 124, column: 119, scope: !40)
!156 = !DILocation(line: 124, column: 31, scope: !40)
!157 = !DILocation(line: 124, column: 29, scope: !40)
!158 = !{!26, !26, i64 0}
!159 = !DILocation(line: 129, column: 38, scope: !40)
!160 = !DILocation(line: 136, column: 3, scope: !40)
!161 = !DILocation(line: 139, column: 58, scope: !40)
!162 = !DILocation(line: 75, column: 10, scope: !139, inlinedAt: !163)
!163 = distinct !DILocation(line: 984, column: 9, scope: !142, inlinedAt: !164)
!164 = distinct !DILocation(line: 133, column: 53, scope: !145, inlinedAt: !165)
!165 = distinct !DILocation(line: 139, column: 50, scope: !40)
!166 = !DILocation(line: 139, column: 47, scope: !40)
!167 = !DILocation(line: 68, column: 3, scope: !59, inlinedAt: !168)
!168 = distinct !DILocation(line: 192, column: 3, scope: !62, inlinedAt: !169)
!169 = distinct !DILocation(line: 142, column: 3, scope: !40)
!170 = !DILocation(line: 69, column: 3, scope: !59, inlinedAt: !168)
!171 = !DILocation(line: 70, column: 3, scope: !59, inlinedAt: !168)
!172 = !DILocation(line: 145, column: 121, scope: !40)
!173 = !DILocation(line: 145, column: 149, scope: !40)
!174 = !DILocation(line: 145, column: 77, scope: !40)
!175 = !DILocation(line: 145, column: 155, scope: !40)
!176 = !DILocation(line: 145, column: 40, scope: !40)
!177 = !DILocation(line: 145, column: 198, scope: !40)
!178 = !DILocation(line: 145, column: 92, scope: !40)
!179 = !DILocation(line: 68, column: 3, scope: !59, inlinedAt: !180)
!180 = distinct !DILocation(line: 192, column: 3, scope: !62, inlinedAt: !181)
!181 = distinct !DILocation(line: 147, column: 3, scope: !40)
!182 = !DILocation(line: 69, column: 3, scope: !59, inlinedAt: !180)
!183 = !DILocation(line: 70, column: 3, scope: !59, inlinedAt: !180)
!184 = !DILocation(line: 149, column: 8, scope: !40)
!185 = !DILocation(line: 150, column: 22, scope: !40)
!186 = !DILocation(line: 150, column: 98, scope: !40)
!187 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!188 = !{i32 2, i32 -1, i32 -1, i32 -1}
!189 = !DILocation(line: 150, column: 135, scope: !40)
!190 = !DILocation(line: 152, column: 1, scope: !40)
