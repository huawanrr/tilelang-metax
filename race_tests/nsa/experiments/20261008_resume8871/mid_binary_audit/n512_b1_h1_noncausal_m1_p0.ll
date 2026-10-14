; ModuleID = 'experiments/20261008_resume8871/mid_binary_audit/n512_b1_h1_noncausal_m1_p0.bc'
source_filename = "/tmp/tmp_u9pws4c/tvm_kernels.maca"
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
  br i1 %cmp28, label %for.cond31.preheader, label %if.end294, !dbg !46

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
  %add.ptr49.1602 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %13, !dbg !49
  %14 = load i32, ptr addrspace(4) %add.ptr49.1602, align 4, !dbg !50, !tbaa !30
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
  %add.ptr79.1614 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %13, !dbg !52
  %25 = load i32, ptr addrspace(4) %add.ptr79.1614, align 4, !dbg !53, !tbaa !30
  %add.ptr79.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %15, !dbg !52
  %26 = load i32, ptr addrspace(4) %add.ptr79.1.1, align 4, !dbg !53, !tbaa !30
  %add.ptr79.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %17, !dbg !52
  %27 = load i32, ptr addrspace(4) %add.ptr79.2.1, align 4, !dbg !53, !tbaa !30
  %add.ptr79.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %19, !dbg !52
  %28 = load i32, ptr addrspace(4) %add.ptr79.3.1, align 4, !dbg !53, !tbaa !30
  %mul102 = and i32 %mul8, 8128
  %xor540 = and i32 %mul8, 56
  %call105.masked = and i32 %1, 1016
  %mul107 = xor i32 %xor540, %call105.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul102, !dbg !54
  %invariant.gep555 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul107, !dbg !54
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep555, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !dbg !55, !call_argsrelate !56
  %gep556.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep555, i32 1024, !dbg !57
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep556.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !dbg !55, !call_argsrelate !56
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
  store i32 %6, ptr addrspace(3) %invariant.gep555, align 16, !dbg !75, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep560.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep555, i32 4, !dbg !75
  store i32 %8, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep560.sroa_idx, align 4, !dbg !75, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep560.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep555, i32 8, !dbg !75
  store i32 %10, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep560.sroa_idx, align 8, !dbg !75, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep560.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep555, i32 12, !dbg !75
  store i32 %12, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep560.sroa_idx, align 4, !dbg !75, !tbaa !30
  store i32 %14, ptr addrspace(3) %gep556.1, align 16, !dbg !75, !tbaa !30
  %K_reg.sroa.9.16.gep561.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep555, i32 1028, !dbg !75
  store i32 %16, ptr addrspace(3) %K_reg.sroa.9.16.gep561.1.sroa_idx, align 4, !dbg !75, !tbaa !30
  %K_reg.sroa.10.16.gep561.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep555, i32 1032, !dbg !75
  store i32 %18, ptr addrspace(3) %K_reg.sroa.10.16.gep561.1.sroa_idx, align 8, !dbg !75, !tbaa !30
  %K_reg.sroa.11.16.gep561.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep555, i32 1036, !dbg !75
  store i32 %20, ptr addrspace(3) %K_reg.sroa.11.16.gep561.1.sroa_idx, align 4, !dbg !75, !tbaa !30
  fence syncscope("warp") release, !dbg !76
  tail call void @llvm.mxc.barrier.warp(), !dbg !79
  fence syncscope("warp") acquire, !dbg !80
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr131, align 16, !dbg !81
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr131.sroa_idx, align 8, !dbg !81
  %30 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !82
  %31 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %30), !dbg !82
  %kb.sroa.0.0.copyload644 = load <4 x half>, ptr addrspace(3) %add.ptr131.1, align 16, !dbg !81
  %kb.sroa.6.0.copyload645 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr131.1.sroa_idx, align 8, !dbg !81
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload644, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %31), !dbg !82
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload645, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %32), !dbg !82
  fence syncscope("warp") release, !dbg !83
  tail call void @llvm.mxc.barrier.warp(), !dbg !86
  fence syncscope("warp") acquire, !dbg !87
  %add.ptr223.idx = shl nuw nsw i32 %1, 4
  %invariant.gep568 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr223.idx, !dbg !88
  store i32 %21, ptr addrspace(3) %invariant.gep568, align 16, !dbg !89, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep568.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep568, i32 4, !dbg !89
  store i32 %22, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep568.sroa_idx, align 4, !dbg !89, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep568.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep568, i32 8, !dbg !89
  store i32 %23, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep568.sroa_idx, align 8, !dbg !89, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep568.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep568, i32 12, !dbg !89
  store i32 %24, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep568.sroa_idx, align 4, !dbg !89, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep568, i32 1024, !dbg !90
  store i32 %25, ptr addrspace(3) %gep.1, align 16, !dbg !89, !tbaa !30
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep568, i32 1028, !dbg !89
  store i32 %26, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !dbg !89, !tbaa !30
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep568, i32 1032, !dbg !89
  store i32 %27, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !dbg !89, !tbaa !30
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep568, i32 1036, !dbg !89
  store i32 %28, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !dbg !89, !tbaa !30
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %33, i64 0, !dbg !91
  %mul233 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !92
  %34 = tail call contract noundef float @llvm.minnum.f32(float %mul233, float 0x4024CB5EC0000000), !dbg !93
  %35 = tail call contract noundef float @llvm.exp.f32(float %34), !dbg !97
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %33, i64 1, !dbg !91
  %mul233.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !92
  %36 = tail call contract noundef float @llvm.minnum.f32(float %mul233.1, float 0x4024CB5EC0000000), !dbg !93
  %37 = tail call contract noundef float @llvm.exp.f32(float %36), !dbg !97
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %33, i64 2, !dbg !91
  %mul233.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !92
  %38 = tail call contract noundef float @llvm.minnum.f32(float %mul233.2, float 0x4024CB5EC0000000), !dbg !93
  %39 = tail call contract noundef float @llvm.exp.f32(float %38), !dbg !97
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %33, i64 3, !dbg !91
  %mul233.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !92
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul233.3, float 0x4024CB5EC0000000), !dbg !93
  %41 = tail call contract noundef float @llvm.exp.f32(float %40), !dbg !97
  %add249.1 = fadd contract float %35, %37, !dbg !100
  %add249.2 = fadd contract float %add249.1, %39, !dbg !100
  %add249.3 = fadd contract float %add249.2, %41, !dbg !100
  %42 = bitcast float %add249.3 to i32, !dbg !101
  %43 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !104
  %44 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %43) #11, !dbg !109
  %xor.i.i = xor i32 %44, 32, !dbg !110
  %45 = and i32 %44, -64, !dbg !111
  %and.i.i = add nsw i32 %45, 64, !dbg !111
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !112
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %44, !dbg !113
  %shl.i.i = shl i32 %cond.i.i, 2, !dbg !114
  %46 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %42), !dbg !115
  %47 = bitcast i32 %46 to float, !dbg !116
  %add257 = fadd contract float %add249.3, %47, !dbg !117
  %48 = bitcast float %add257 to i32, !dbg !118
  %49 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !120
  %50 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %49) #11, !dbg !123
  %xor.i.i542 = xor i32 %50, 16, !dbg !124
  %51 = and i32 %50, -64, !dbg !125
  %and.i.i543 = add nsw i32 %51, 64, !dbg !125
  %cmp.not.i.i544 = icmp slt i32 %xor.i.i542, %and.i.i543, !dbg !126
  %cond.i.i545 = select i1 %cmp.not.i.i544, i32 %xor.i.i542, i32 %50, !dbg !127
  %shl.i.i546 = shl i32 %cond.i.i545, 2, !dbg !128
  %52 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i546, i32 %48), !dbg !129
  %53 = bitcast i32 %52 to float, !dbg !130
  %add262 = fadd contract float %add257, %53, !dbg !131
  %cmp265 = fcmp contract ogt float %add262, 0.000000e+00, !dbg !132
  %div = fdiv contract float 1.000000e+00, %add262, !dbg !133
  %condval.0 = select i1 %cmp265, float %div, float 0.000000e+00, !dbg !133
  %mul276 = fmul contract float %condval.0, %35, !dbg !134
  %mul276.1 = fmul contract float %condval.0, %37, !dbg !134
  %mul276.2 = fmul contract float %condval.0, %39, !dbg !134
  %mul276.3 = fmul contract float %condval.0, %41, !dbg !134
  %54 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul276), !dbg !135
  %55 = insertelement <4 x i16> poison, i16 %54, i64 0, !dbg !144
  %56 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul276.1), !dbg !135
  %57 = insertelement <4 x i16> %55, i16 %56, i64 1, !dbg !144
  %58 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul276.2), !dbg !135
  %59 = insertelement <4 x i16> %57, i16 %58, i64 2, !dbg !144
  %60 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul276.3), !dbg !135
  %61 = insertelement <4 x i16> %59, i16 %60, i64 3, !dbg !144
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %61 to <4 x half>, !dbg !144
  fence syncscope("warp") release, !dbg !145
  tail call void @llvm.mxc.barrier.warp(), !dbg !148
  fence syncscope("warp") acquire, !dbg !149
  br label %if.end294, !dbg !150

if.end294:                                        ; preds = %for.cond31.preheader, %entry
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ %acc_s_cast.sroa.0.6.vec.insert, %for.cond31.preheader ], [ undef, %entry ]
  br i1 %cmp28, label %for.cond312.preheader, label %if.end360, !dbg !151

for.cond312.preheader:                            ; preds = %if.end294
  %62 = shl nuw nsw i32 %1, 4
  %mul322 = and i32 %62, 16128
  %and328 = and i32 %1, 15
  %add329 = or disjoint i32 %mul322, %and328, !dbg !152
  %arrayidx331 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add329, !dbg !153
  %63 = load half, ptr addrspace(3) %arrayidx331, align 2, !dbg !154, !tbaa !155
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %63, i64 0, !dbg !154
  %add324.1 = or disjoint i32 %mul322, %and328, !dbg !152
  %add329.1 = or disjoint i32 %add324.1, 64, !dbg !152
  %arrayidx331.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add329.1, !dbg !153
  %64 = load half, ptr addrspace(3) %arrayidx331.1, align 2, !dbg !154, !tbaa !155
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %64, i64 1, !dbg !154
  %add324.2 = or disjoint i32 %mul322, %and328, !dbg !152
  %add329.2 = or disjoint i32 %add324.2, 128, !dbg !152
  %arrayidx331.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add329.2, !dbg !153
  %65 = load half, ptr addrspace(3) %arrayidx331.2, align 2, !dbg !154, !tbaa !155
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %65, i64 2, !dbg !154
  %add324.3 = or disjoint i32 %mul322, %and328, !dbg !152
  %add329.3 = or disjoint i32 %add324.3, 192, !dbg !152
  %arrayidx331.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add329.3, !dbg !153
  %66 = load half, ptr addrspace(3) %arrayidx331.3, align 2, !dbg !154, !tbaa !155
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %66, i64 3, !dbg !154
  %add326.1618 = or disjoint i32 %mul322, %and328, !dbg !152
  %add329.1619 = or disjoint i32 %add326.1618, 16, !dbg !152
  %arrayidx331.1620 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add329.1619, !dbg !153
  %67 = load half, ptr addrspace(3) %arrayidx331.1620, align 2, !dbg !154, !tbaa !155
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %67, i64 0, !dbg !154
  %add326.1.1 = or disjoint i32 %mul322, %and328, !dbg !152
  %add329.1.1 = or disjoint i32 %add326.1.1, 80, !dbg !152
  %arrayidx331.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add329.1.1, !dbg !153
  %68 = load half, ptr addrspace(3) %arrayidx331.1.1, align 2, !dbg !154, !tbaa !155
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %68, i64 1, !dbg !154
  %add326.2.1 = or disjoint i32 %mul322, %and328, !dbg !152
  %add329.2.1 = or disjoint i32 %add326.2.1, 144, !dbg !152
  %arrayidx331.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add329.2.1, !dbg !153
  %69 = load half, ptr addrspace(3) %arrayidx331.2.1, align 2, !dbg !154, !tbaa !155
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %69, i64 2, !dbg !154
  %add326.3.1 = or disjoint i32 %mul322, %and328, !dbg !152
  %add329.3.1 = or disjoint i32 %add326.3.1, 208, !dbg !152
  %arrayidx331.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add329.3.1, !dbg !153
  %70 = load half, ptr addrspace(3) %arrayidx331.3.1, align 2, !dbg !154, !tbaa !155
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %70, i64 3, !dbg !154
  %add326.2622 = or disjoint i32 %mul322, %and328, !dbg !152
  %add329.2623 = or disjoint i32 %add326.2622, 32, !dbg !152
  %arrayidx331.2624 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add329.2623, !dbg !153
  %71 = load half, ptr addrspace(3) %arrayidx331.2624, align 2, !dbg !154, !tbaa !155
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %71, i64 0, !dbg !154
  %add326.1.2 = or disjoint i32 %mul322, %and328, !dbg !152
  %add329.1.2 = or disjoint i32 %add326.1.2, 96, !dbg !152
  %arrayidx331.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add329.1.2, !dbg !153
  %72 = load half, ptr addrspace(3) %arrayidx331.1.2, align 2, !dbg !154, !tbaa !155
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %72, i64 1, !dbg !154
  %add326.2.2 = or disjoint i32 %mul322, %and328, !dbg !152
  %add329.2.2 = or disjoint i32 %add326.2.2, 160, !dbg !152
  %arrayidx331.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add329.2.2, !dbg !153
  %73 = load half, ptr addrspace(3) %arrayidx331.2.2, align 2, !dbg !154, !tbaa !155
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %73, i64 2, !dbg !154
  %add326.3.2 = or disjoint i32 %mul322, %and328, !dbg !152
  %add329.3.2 = or disjoint i32 %add326.3.2, 224, !dbg !152
  %arrayidx331.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add329.3.2, !dbg !153
  %74 = load half, ptr addrspace(3) %arrayidx331.3.2, align 2, !dbg !154, !tbaa !155
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %74, i64 3, !dbg !154
  %add326.3626 = or disjoint i32 %mul322, %and328, !dbg !152
  %add329.3627 = or disjoint i32 %add326.3626, 48, !dbg !152
  %arrayidx331.3628 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add329.3627, !dbg !153
  %75 = load half, ptr addrspace(3) %arrayidx331.3628, align 2, !dbg !154, !tbaa !155
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %75, i64 0, !dbg !154
  %add326.1.3 = or disjoint i32 %mul322, %and328, !dbg !152
  %add329.1.3 = or disjoint i32 %add326.1.3, 112, !dbg !152
  %arrayidx331.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add329.1.3, !dbg !153
  %76 = load half, ptr addrspace(3) %arrayidx331.1.3, align 2, !dbg !154, !tbaa !155
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %76, i64 1, !dbg !154
  %add326.2.3 = or disjoint i32 %mul322, %and328, !dbg !152
  %add329.2.3 = or disjoint i32 %add326.2.3, 176, !dbg !152
  %arrayidx331.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add329.2.3, !dbg !153
  %77 = load half, ptr addrspace(3) %arrayidx331.2.3, align 2, !dbg !154, !tbaa !155
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %77, i64 2, !dbg !154
  %add326.3.3 = or disjoint i32 %62, %and328, !dbg !152
  %add329.3.3 = or i32 %add326.3.3, 240, !dbg !152
  %arrayidx331.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add329.3.3, !dbg !153
  %78 = load half, ptr addrspace(3) %arrayidx331.3.3, align 2, !dbg !154, !tbaa !155
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %78, i64 3, !dbg !154
  %79 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !156
  %80 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !156
  %81 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !156
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !156
  br label %if.end360, !dbg !157

if.end360:                                        ; preds = %for.cond312.preheader, %if.end294
  %acc_o.sroa.0.0 = phi <4 x float> [ %79, %for.cond312.preheader ], [ zeroinitializer, %if.end294 ], !dbg !158
  %acc_o.sroa.16.0 = phi <4 x float> [ %80, %for.cond312.preheader ], [ zeroinitializer, %if.end294 ], !dbg !158
  %acc_o.sroa.30.0 = phi <4 x float> [ %81, %for.cond312.preheader ], [ zeroinitializer, %if.end294 ], !dbg !158
  %acc_o.sroa.44.0 = phi <4 x float> [ %82, %for.cond312.preheader ], [ zeroinitializer, %if.end294 ], !dbg !158
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0, !dbg !159
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract), !dbg !160
  %O_reg.sroa.0.0.insert.ext = zext i16 %83 to i64, !dbg !164
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1, !dbg !159
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract), !dbg !160
  %O_reg.sroa.0.2.insert.ext = zext i16 %84 to i64, !dbg !164
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !164
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !164
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2, !dbg !159
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract), !dbg !160
  %O_reg.sroa.0.4.insert.ext = zext i16 %85 to i64, !dbg !164
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !164
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !164
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3, !dbg !159
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract), !dbg !160
  %O_reg.sroa.0.6.insert.ext = zext i16 %86 to i64, !dbg !164
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !164
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !164
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0, !dbg !159
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract), !dbg !160
  %O_reg.sroa.7.8.insert.ext = zext i16 %87 to i64, !dbg !164
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1, !dbg !159
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract), !dbg !160
  %O_reg.sroa.7.10.insert.ext = zext i16 %88 to i64, !dbg !164
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !164
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !164
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2, !dbg !159
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract), !dbg !160
  %O_reg.sroa.7.12.insert.ext = zext i16 %89 to i64, !dbg !164
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !164
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !164
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3, !dbg !159
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract), !dbg !160
  %O_reg.sroa.7.14.insert.ext = zext i16 %90 to i64, !dbg !164
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !164
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !164
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0, !dbg !159
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract), !dbg !160
  %O_reg.sroa.12.16.insert.ext = zext i16 %91 to i64, !dbg !164
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1, !dbg !159
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract), !dbg !160
  %O_reg.sroa.12.18.insert.ext = zext i16 %92 to i64, !dbg !164
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !164
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !164
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2, !dbg !159
  %93 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract), !dbg !160
  %O_reg.sroa.12.20.insert.ext = zext i16 %93 to i64, !dbg !164
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !164
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !164
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3, !dbg !159
  %94 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract), !dbg !160
  %O_reg.sroa.12.22.insert.ext = zext i16 %94 to i64, !dbg !164
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !164
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !164
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0, !dbg !159
  %95 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract), !dbg !160
  %O_reg.sroa.17.24.insert.ext = zext i16 %95 to i64, !dbg !164
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1, !dbg !159
  %96 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract), !dbg !160
  %O_reg.sroa.17.26.insert.ext = zext i16 %96 to i64, !dbg !164
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !164
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !164
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2, !dbg !159
  %97 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract), !dbg !160
  %O_reg.sroa.17.28.insert.ext = zext i16 %97 to i64, !dbg !164
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !164
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !164
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3, !dbg !159
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract), !dbg !160
  %O_reg.sroa.17.30.insert.ext = zext i16 %98 to i64, !dbg !164
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !164
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !164
  fence syncscope("warp") release, !dbg !165
  tail call void @llvm.mxc.barrier.warp(), !dbg !168
  fence syncscope("warp") acquire, !dbg !169
  %and393 = shl nuw nsw i32 %1, 6
  %mul394 = and i32 %and393, 960
  %shr397 = lshr i32 %1, 5
  %and400 = and i32 %1, 7
  %99 = lshr i32 %1, 2
  %mul407 = and i32 %99, 4
  %xor401 = xor i32 %shr397, %and400, !dbg !170
  %mul402 = shl nuw nsw i32 %xor401, 3, !dbg !171
  %add403 = add nuw nsw i32 %mul402, %mul394, !dbg !172
  %add408 = or disjoint i32 %add403, %mul407, !dbg !173
  %add.ptr410 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add408, !dbg !174
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr410, align 8, !dbg !175
  %add398.1 = add nuw nsw i32 %shr397, 2, !dbg !176
  %xor401.1 = xor i32 %add398.1, %and400, !dbg !170
  %mul402.1 = shl nuw nsw i32 %xor401.1, 3, !dbg !171
  %add403.1 = add nuw nsw i32 %mul402.1, %mul394, !dbg !172
  %add408.1 = or disjoint i32 %add403.1, %mul407, !dbg !173
  %add.ptr410.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add408.1, !dbg !174
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr410.1, align 8, !dbg !175
  %add398.2 = add nuw nsw i32 %shr397, 4, !dbg !176
  %xor401.2 = xor i32 %add398.2, %and400, !dbg !170
  %mul402.2 = shl nuw nsw i32 %xor401.2, 3, !dbg !171
  %add403.2 = add nuw nsw i32 %mul402.2, %mul394, !dbg !172
  %add408.2 = or disjoint i32 %add403.2, %mul407, !dbg !173
  %add.ptr410.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add408.2, !dbg !174
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr410.2, align 8, !dbg !175
  %add398.3 = add nuw nsw i32 %shr397, 6, !dbg !176
  %xor401.3 = xor i32 %add398.3, %and400, !dbg !170
  %mul402.3 = shl nuw nsw i32 %xor401.3, 3, !dbg !171
  %add403.3 = add nuw nsw i32 %mul402.3, %mul394, !dbg !172
  %add408.3 = or disjoint i32 %add403.3, %mul407, !dbg !173
  %add.ptr410.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add408.3, !dbg !174
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr410.3, align 8, !dbg !175
  fence syncscope("warp") release, !dbg !177
  tail call void @llvm.mxc.barrier.warp(), !dbg !180
  fence syncscope("warp") acquire, !dbg !181
  %mul421 = and i32 %mul8, 8128
  %xor427536 = and i32 %mul8, 56
  %call425.masked = and i32 %1, 1016
  %mul428 = xor i32 %xor427536, %call425.masked
  %invariant.gep582 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul421, !dbg !182
  %invariant.gep584 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep582, i32 %mul428, !dbg !182
  %add.ptr440 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %2, !dbg !183
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr440, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep584, i64 16, i1 false), !dbg !184, !tbaa.struct !185, !call_argsrelate !186
  %gep585.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep584, i32 1024, !dbg !187
  %add.ptr440.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3, !dbg !183
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr440.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep585.1, i64 16, i1 false), !dbg !184, !tbaa.struct !185, !call_argsrelate !186
  ret void, !dbg !188
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
!1 = !DIFile(filename: "/tmp/tmp_u9pws4c/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmp_u9pws4c/tvm_kernels.maca", directory: "")
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
!91 = !DILocation(line: 84, column: 30, scope: !40)
!92 = !DILocation(line: 84, column: 41, scope: !40)
!93 = !DILocation(line: 354, column: 10, scope: !94, inlinedAt: !96)
!94 = distinct !DISubprogram(name: "min", scope: !95, file: !95, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!95 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!96 = distinct !DILocation(line: 84, column: 25, scope: !40)
!97 = !DILocation(line: 288, column: 10, scope: !98, inlinedAt: !99)
!98 = distinct !DISubprogram(name: "expf", scope: !95, file: !95, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!99 = distinct !DILocation(line: 84, column: 20, scope: !40)
!100 = !DILocation(line: 89, column: 34, scope: !40)
!101 = !DILocation(line: 1018, column: 9, scope: !102, inlinedAt: !103)
!102 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !60, file: !60, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!103 = distinct !DILocation(line: 91, column: 34, scope: !40)
!104 = !DILocation(line: 171, column: 37, scope: !105, inlinedAt: !106)
!105 = distinct !DISubprogram(name: "__lane_id", scope: !60, file: !60, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!106 = distinct !DILocation(line: 990, column: 14, scope: !107, inlinedAt: !108)
!107 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !60, file: !60, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!108 = distinct !DILocation(line: 1019, column: 11, scope: !102, inlinedAt: !103)
!109 = !DILocation(line: 171, column: 10, scope: !105, inlinedAt: !106)
!110 = !DILocation(line: 991, column: 20, scope: !107, inlinedAt: !108)
!111 = !DILocation(line: 992, column: 36, scope: !107, inlinedAt: !108)
!112 = !DILocation(line: 992, column: 17, scope: !107, inlinedAt: !108)
!113 = !DILocation(line: 992, column: 11, scope: !107, inlinedAt: !108)
!114 = !DILocation(line: 993, column: 43, scope: !107, inlinedAt: !108)
!115 = !DILocation(line: 993, column: 10, scope: !107, inlinedAt: !108)
!116 = !DILocation(line: 1020, column: 14, scope: !102, inlinedAt: !103)
!117 = !DILocation(line: 91, column: 32, scope: !40)
!118 = !DILocation(line: 1018, column: 9, scope: !102, inlinedAt: !119)
!119 = distinct !DILocation(line: 92, column: 34, scope: !40)
!120 = !DILocation(line: 171, column: 37, scope: !105, inlinedAt: !121)
!121 = distinct !DILocation(line: 990, column: 14, scope: !107, inlinedAt: !122)
!122 = distinct !DILocation(line: 1019, column: 11, scope: !102, inlinedAt: !119)
!123 = !DILocation(line: 171, column: 10, scope: !105, inlinedAt: !121)
!124 = !DILocation(line: 991, column: 20, scope: !107, inlinedAt: !122)
!125 = !DILocation(line: 992, column: 36, scope: !107, inlinedAt: !122)
!126 = !DILocation(line: 992, column: 17, scope: !107, inlinedAt: !122)
!127 = !DILocation(line: 992, column: 11, scope: !107, inlinedAt: !122)
!128 = !DILocation(line: 993, column: 43, scope: !107, inlinedAt: !122)
!129 = !DILocation(line: 993, column: 10, scope: !107, inlinedAt: !122)
!130 = !DILocation(line: 1020, column: 14, scope: !102, inlinedAt: !119)
!131 = !DILocation(line: 92, column: 32, scope: !40)
!132 = !DILocation(line: 94, column: 34, scope: !40)
!133 = !DILocation(line: 94, column: 9, scope: !40)
!134 = !DILocation(line: 102, column: 32, scope: !40)
!135 = !DILocation(line: 75, column: 10, scope: !136, inlinedAt: !138)
!136 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !137, file: !137, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!137 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!138 = distinct !DILocation(line: 984, column: 9, scope: !139, inlinedAt: !141)
!139 = distinct !DISubprogram(name: "__float2half", scope: !140, file: !140, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!140 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!141 = distinct !DILocation(line: 133, column: 53, scope: !142, inlinedAt: !143)
!142 = distinct !DISubprogram(name: "__half", scope: !140, file: !140, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!143 = distinct !DILocation(line: 106, column: 32, scope: !40)
!144 = !DILocation(line: 106, column: 29, scope: !40)
!145 = !DILocation(line: 68, column: 3, scope: !59, inlinedAt: !146)
!146 = distinct !DILocation(line: 192, column: 3, scope: !62, inlinedAt: !147)
!147 = distinct !DILocation(line: 108, column: 5, scope: !40)
!148 = !DILocation(line: 69, column: 3, scope: !59, inlinedAt: !146)
!149 = !DILocation(line: 70, column: 3, scope: !59, inlinedAt: !146)
!150 = !DILocation(line: 109, column: 3, scope: !40)
!151 = !DILocation(line: 115, column: 30, scope: !40)
!152 = !DILocation(line: 118, column: 119, scope: !40)
!153 = !DILocation(line: 118, column: 31, scope: !40)
!154 = !DILocation(line: 118, column: 29, scope: !40)
!155 = !{!26, !26, i64 0}
!156 = !DILocation(line: 123, column: 38, scope: !40)
!157 = !DILocation(line: 130, column: 3, scope: !40)
!158 = !DILocation(line: 0, scope: !40)
!159 = !DILocation(line: 133, column: 58, scope: !40)
!160 = !DILocation(line: 75, column: 10, scope: !136, inlinedAt: !161)
!161 = distinct !DILocation(line: 984, column: 9, scope: !139, inlinedAt: !162)
!162 = distinct !DILocation(line: 133, column: 53, scope: !142, inlinedAt: !163)
!163 = distinct !DILocation(line: 133, column: 50, scope: !40)
!164 = !DILocation(line: 133, column: 47, scope: !40)
!165 = !DILocation(line: 68, column: 3, scope: !59, inlinedAt: !166)
!166 = distinct !DILocation(line: 192, column: 3, scope: !62, inlinedAt: !167)
!167 = distinct !DILocation(line: 136, column: 3, scope: !40)
!168 = !DILocation(line: 69, column: 3, scope: !59, inlinedAt: !166)
!169 = !DILocation(line: 70, column: 3, scope: !59, inlinedAt: !166)
!170 = !DILocation(line: 139, column: 121, scope: !40)
!171 = !DILocation(line: 139, column: 149, scope: !40)
!172 = !DILocation(line: 139, column: 77, scope: !40)
!173 = !DILocation(line: 139, column: 155, scope: !40)
!174 = !DILocation(line: 139, column: 40, scope: !40)
!175 = !DILocation(line: 139, column: 198, scope: !40)
!176 = !DILocation(line: 139, column: 92, scope: !40)
!177 = !DILocation(line: 68, column: 3, scope: !59, inlinedAt: !178)
!178 = distinct !DILocation(line: 192, column: 3, scope: !62, inlinedAt: !179)
!179 = distinct !DILocation(line: 141, column: 3, scope: !40)
!180 = !DILocation(line: 69, column: 3, scope: !59, inlinedAt: !178)
!181 = !DILocation(line: 70, column: 3, scope: !59, inlinedAt: !178)
!182 = !DILocation(line: 143, column: 8, scope: !40)
!183 = !DILocation(line: 144, column: 22, scope: !40)
!184 = !DILocation(line: 144, column: 98, scope: !40)
!185 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!186 = !{i32 2, i32 -1, i32 -1, i32 -1}
!187 = !DILocation(line: 144, column: 135, scope: !40)
!188 = !DILocation(line: 146, column: 1, scope: !40)
