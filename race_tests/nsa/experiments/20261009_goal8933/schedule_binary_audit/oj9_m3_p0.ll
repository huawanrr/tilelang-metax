; ModuleID = 'experiments/20261009_goal8933/schedule_binary_audit/oj9_m3_p0.bc'
source_filename = "/tmp/tmpd7czuryn/tvm_kernels.maca"
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
  %cmp28 = icmp ugt i32 %4, 511
  %shr = lshr i32 %0, 4
  %cmp31.not = icmp ugt i32 %4, %shr
  %or.cond631 = or i1 %cmp28, %cmp31.not, !dbg !46
  br i1 %or.cond631, label %if.end326, label %if.then, !dbg !46

if.then:                                          ; preds = %entry
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !47
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %2, !dbg !47
  %mul43 = shl nuw nsw i32 %4, 10
  %add45 = add nuw nsw i32 %mul43, %mul8
  %5 = zext nneg i32 %add45 to i64, !dbg !48
  %add.ptr52 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %5, !dbg !49
  %6 = load i32, ptr addrspace(4) %add.ptr52, align 4, !dbg !50, !tbaa !30
  %7 = or disjoint i64 %5, 2, !dbg !51
  %add.ptr52.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %7, !dbg !49
  %8 = load i32, ptr addrspace(4) %add.ptr52.1, align 4, !dbg !50, !tbaa !30
  %9 = or disjoint i64 %5, 4, !dbg !51
  %add.ptr52.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %9, !dbg !49
  %10 = load i32, ptr addrspace(4) %add.ptr52.2, align 4, !dbg !50, !tbaa !30
  %11 = or disjoint i64 %5, 6, !dbg !51
  %add.ptr52.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %11, !dbg !49
  %12 = load i32, ptr addrspace(4) %add.ptr52.3, align 4, !dbg !50, !tbaa !30
  %13 = add nuw nsw i64 %5, 512
  %add.ptr52.1648 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %13, !dbg !49
  %14 = load i32, ptr addrspace(4) %add.ptr52.1648, align 4, !dbg !50, !tbaa !30
  %15 = add nuw nsw i64 %5, 514, !dbg !51
  %add.ptr52.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %15, !dbg !49
  %16 = load i32, ptr addrspace(4) %add.ptr52.1.1, align 4, !dbg !50, !tbaa !30
  %17 = add nuw nsw i64 %5, 516, !dbg !51
  %add.ptr52.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %17, !dbg !49
  %18 = load i32, ptr addrspace(4) %add.ptr52.2.1, align 4, !dbg !50, !tbaa !30
  %19 = add nuw nsw i64 %5, 518, !dbg !51
  %add.ptr52.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %19, !dbg !49
  %20 = load i32, ptr addrspace(4) %add.ptr52.3.1, align 4, !dbg !50, !tbaa !30
  %add.ptr82 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %5, !dbg !52
  %21 = load i32, ptr addrspace(4) %add.ptr82, align 4, !dbg !53, !tbaa !30
  %add.ptr82.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %7, !dbg !52
  %22 = load i32, ptr addrspace(4) %add.ptr82.1, align 4, !dbg !53, !tbaa !30
  %add.ptr82.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %9, !dbg !52
  %23 = load i32, ptr addrspace(4) %add.ptr82.2, align 4, !dbg !53, !tbaa !30
  %add.ptr82.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %11, !dbg !52
  %24 = load i32, ptr addrspace(4) %add.ptr82.3, align 4, !dbg !53, !tbaa !30
  %add.ptr82.1660 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %13, !dbg !52
  %25 = load i32, ptr addrspace(4) %add.ptr82.1660, align 4, !dbg !53, !tbaa !30
  %add.ptr82.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %15, !dbg !52
  %26 = load i32, ptr addrspace(4) %add.ptr82.1.1, align 4, !dbg !53, !tbaa !30
  %add.ptr82.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %17, !dbg !52
  %27 = load i32, ptr addrspace(4) %add.ptr82.2.1, align 4, !dbg !53, !tbaa !30
  %add.ptr82.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %19, !dbg !52
  %28 = load i32, ptr addrspace(4) %add.ptr82.3.1, align 4, !dbg !53, !tbaa !30
  %mul106 = and i32 %mul8, 8128
  %xor582 = and i32 %mul8, 56
  %call109.masked = and i32 %1, 1016
  %mul111 = xor i32 %xor582, %call109.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul106, !dbg !54
  %invariant.gep598 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul111, !dbg !54
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep598, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !dbg !55, !call_argsrelate !56
  %gep599.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep598, i32 1024, !dbg !57
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep599.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !dbg !55, !call_argsrelate !56
  fence syncscope("warp") release, !dbg !58
  tail call void @llvm.mxc.barrier.warp(), !dbg !64
  fence syncscope("warp") acquire, !dbg !65
  %and123 = shl nuw nsw i32 %1, 6
  %mul124 = and i32 %and123, 960
  %shr127 = lshr i32 %1, 4
  %and130 = and i32 %1, 7
  %29 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul124
  %xor131 = xor i32 %shr127, %and130, !dbg !66
  %add.ptr135.idx = shl nuw nsw i32 %xor131, 4, !dbg !67
  %add.ptr135 = getelementptr inbounds i8, ptr addrspace(3) %29, i32 %add.ptr135.idx, !dbg !67
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr135, align 16, !dbg !68
  %Q_reg.sroa.4.0.add.ptr135.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr135, i32 8, !dbg !68
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr135.sroa_idx, align 8, !dbg !68
  %add128.1 = add nuw nsw i32 %shr127, 4, !dbg !69
  %xor131.1 = xor i32 %add128.1, %and130, !dbg !66
  %add.ptr135.idx.1 = shl nuw nsw i32 %xor131.1, 4, !dbg !67
  %add.ptr135.1 = getelementptr inbounds i8, ptr addrspace(3) %29, i32 %add.ptr135.idx.1, !dbg !67
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr135.1, align 16, !dbg !68
  %Q_reg.sroa.7.16.add.ptr135.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr135.1, i32 8, !dbg !68
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr135.1.sroa_idx, align 8, !dbg !68
  fence syncscope("warp") release, !dbg !70
  tail call void @llvm.mxc.barrier.warp(), !dbg !73
  fence syncscope("warp") acquire, !dbg !74
  store i32 %6, ptr addrspace(3) %invariant.gep598, align 16, !dbg !75, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep603.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep598, i32 4, !dbg !75
  store i32 %8, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep603.sroa_idx, align 4, !dbg !75, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep603.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep598, i32 8, !dbg !75
  store i32 %10, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep603.sroa_idx, align 8, !dbg !75, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep603.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep598, i32 12, !dbg !75
  store i32 %12, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep603.sroa_idx, align 4, !dbg !75, !tbaa !30
  store i32 %14, ptr addrspace(3) %gep599.1, align 16, !dbg !75, !tbaa !30
  %K_reg.sroa.9.16.gep604.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep598, i32 1028, !dbg !75
  store i32 %16, ptr addrspace(3) %K_reg.sroa.9.16.gep604.1.sroa_idx, align 4, !dbg !75, !tbaa !30
  %K_reg.sroa.10.16.gep604.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep598, i32 1032, !dbg !75
  store i32 %18, ptr addrspace(3) %K_reg.sroa.10.16.gep604.1.sroa_idx, align 8, !dbg !75, !tbaa !30
  %K_reg.sroa.11.16.gep604.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep598, i32 1036, !dbg !75
  store i32 %20, ptr addrspace(3) %K_reg.sroa.11.16.gep604.1.sroa_idx, align 4, !dbg !75, !tbaa !30
  %mul32 = shl nuw nsw i32 %4, 4, !dbg !76
  %add170 = or disjoint i32 %mul32, 15, !dbg !77
  %cmp171 = icmp ult i32 %0, %add170, !dbg !78
  br i1 %cmp171, label %for.cond173.preheader, label %if.end197, !dbg !79

for.cond173.preheader:                            ; preds = %if.then
  %30 = lshr i32 %1, 2
  %mul179 = and i32 %30, 252
  %add181 = add nuw nsw i32 %mul32, %mul179
  %cmp184.not = icmp ugt i32 %add181, %0, !dbg !80
  %spec.select = select i1 %cmp184.not, float 0xFFF0000000000000, float 0.000000e+00, !dbg !81
  %acc_s.sroa.0.0.vec.insert696 = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !82
  %cmp184.not.1.not = icmp ult i32 %add181, %0, !dbg !80
  %spec.select.1 = select i1 %cmp184.not.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !81
  %acc_s.sroa.0.4.vec.insert709 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert696, float %spec.select.1, i64 1, !dbg !82
  %add182.2 = or disjoint i32 %add181, 2, !dbg !83
  %cmp184.not.2 = icmp ugt i32 %add182.2, %0, !dbg !80
  %spec.select.2 = select i1 %cmp184.not.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !81
  %acc_s.sroa.0.8.vec.insert722 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert709, float %spec.select.2, i64 2, !dbg !82
  %add182.3 = or disjoint i32 %add181, 3, !dbg !83
  %cmp184.not.3 = icmp ugt i32 %add182.3, %0, !dbg !80
  %spec.select.3 = select i1 %cmp184.not.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !81
  %acc_s.sroa.0.12.vec.insert735 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert722, float %spec.select.3, i64 3, !dbg !82
  br label %if.end197, !dbg !84

if.end197:                                        ; preds = %if.then, %for.cond173.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert735, %for.cond173.preheader ], [ zeroinitializer, %if.then ], !dbg !87
  fence syncscope("warp") release, !dbg !84
  tail call void @llvm.mxc.barrier.warp(), !dbg !88
  fence syncscope("warp") acquire, !dbg !89
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr135, align 16, !dbg !90
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr135.sroa_idx, align 8, !dbg !90
  %31 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !dbg !91
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %31), !dbg !91
  %kb.sroa.0.0.copyload690 = load <4 x half>, ptr addrspace(3) %add.ptr135.1, align 16, !dbg !90
  %kb.sroa.6.0.copyload691 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr135.1.sroa_idx, align 8, !dbg !90
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload690, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %32), !dbg !91
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload691, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %33), !dbg !91
  fence syncscope("warp") release, !dbg !92
  tail call void @llvm.mxc.barrier.warp(), !dbg !95
  fence syncscope("warp") acquire, !dbg !96
  %add.ptr253.idx = shl nuw nsw i32 %1, 4
  %invariant.gep612 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr253.idx, !dbg !97
  store i32 %21, ptr addrspace(3) %invariant.gep612, align 16, !dbg !98, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep612.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 4, !dbg !98
  store i32 %22, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep612.sroa_idx, align 4, !dbg !98, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep612.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 8, !dbg !98
  store i32 %23, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep612.sroa_idx, align 8, !dbg !98, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep612.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 12, !dbg !98
  store i32 %24, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep612.sroa_idx, align 4, !dbg !98, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 1024, !dbg !99
  store i32 %25, ptr addrspace(3) %gep.1, align 16, !dbg !98, !tbaa !30
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 1028, !dbg !98
  store i32 %26, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !dbg !98, !tbaa !30
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 1032, !dbg !98
  store i32 %27, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !dbg !98, !tbaa !30
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep612, i32 1036, !dbg !98
  store i32 %28, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !dbg !98, !tbaa !30
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %34, i64 0, !dbg !100
  %mul263 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FC2776C60000000, !dbg !101
  %35 = tail call contract noundef float @llvm.minnum.f32(float %mul263, float 1.500000e+01), !dbg !102
  %cmp.i.i = fcmp contract olt float %35, -1.260000e+02, !dbg !106
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00, !dbg !106
  %add.i.i = fadd contract float %35, %cond.i.i, !dbg !106
  %36 = tail call contract float @llvm.exp2.f32(float %add.i.i), !dbg !106
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00, !dbg !106
  %mul.i.i = fmul contract float %cond2.i.i, %36, !dbg !106
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %34, i64 1, !dbg !100
  %mul263.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FC2776C60000000, !dbg !101
  %37 = tail call contract noundef float @llvm.minnum.f32(float %mul263.1, float 1.500000e+01), !dbg !102
  %cmp.i.i.1 = fcmp contract olt float %37, -1.260000e+02, !dbg !106
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00, !dbg !106
  %add.i.i.1 = fadd contract float %37, %cond.i.i.1, !dbg !106
  %38 = tail call contract float @llvm.exp2.f32(float %add.i.i.1), !dbg !106
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !106
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %38, !dbg !106
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %34, i64 2, !dbg !100
  %mul263.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FC2776C60000000, !dbg !101
  %39 = tail call contract noundef float @llvm.minnum.f32(float %mul263.2, float 1.500000e+01), !dbg !102
  %cmp.i.i.2 = fcmp contract olt float %39, -1.260000e+02, !dbg !106
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00, !dbg !106
  %add.i.i.2 = fadd contract float %39, %cond.i.i.2, !dbg !106
  %40 = tail call contract float @llvm.exp2.f32(float %add.i.i.2), !dbg !106
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00, !dbg !106
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %40, !dbg !106
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %34, i64 3, !dbg !100
  %mul263.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FC2776C60000000, !dbg !101
  %41 = tail call contract noundef float @llvm.minnum.f32(float %mul263.3, float 1.500000e+01), !dbg !102
  %cmp.i.i.3 = fcmp contract olt float %41, -1.260000e+02, !dbg !106
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00, !dbg !106
  %add.i.i.3 = fadd contract float %41, %cond.i.i.3, !dbg !106
  %42 = tail call contract float @llvm.exp2.f32(float %add.i.i.3), !dbg !106
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00, !dbg !106
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %42, !dbg !106
  %add279 = fadd contract float %mul.i.i, 0.000000e+00, !dbg !109
  %add279.1 = fadd contract float %add279, %mul.i.i.1, !dbg !109
  %add279.2 = fadd contract float %add279.1, %mul.i.i.2, !dbg !109
  %add279.3 = fadd contract float %add279.2, %mul.i.i.3, !dbg !109
  %43 = bitcast float %add279.3 to i32, !dbg !110
  %44 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !113
  %45 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %44) #11, !dbg !118
  %xor.i.i = xor i32 %45, 32, !dbg !119
  %46 = and i32 %45, -64, !dbg !120
  %and.i.i = add nsw i32 %46, 64, !dbg !120
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !121
  %cond.i.i584 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %45, !dbg !122
  %shl.i.i = shl i32 %cond.i.i584, 2, !dbg !123
  %47 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %43), !dbg !124
  %48 = bitcast i32 %47 to float, !dbg !125
  %add287 = fadd contract float %add279.3, %48, !dbg !126
  %49 = bitcast float %add287 to i32, !dbg !127
  %50 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !129
  %51 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %50) #11, !dbg !132
  %xor.i.i585 = xor i32 %51, 16, !dbg !133
  %52 = and i32 %51, -64, !dbg !134
  %and.i.i586 = add nsw i32 %52, 64, !dbg !134
  %cmp.not.i.i587 = icmp slt i32 %xor.i.i585, %and.i.i586, !dbg !135
  %cond.i.i588 = select i1 %cmp.not.i.i587, i32 %xor.i.i585, i32 %51, !dbg !136
  %shl.i.i589 = shl i32 %cond.i.i588, 2, !dbg !137
  %53 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i589, i32 %49), !dbg !138
  %54 = bitcast i32 %53 to float, !dbg !139
  %add292 = fadd contract float %add287, %54, !dbg !140
  %cmp295 = fcmp contract ogt float %add292, 0.000000e+00, !dbg !141
  %div = fdiv contract float 1.000000e+00, %add292, !dbg !142
  %condval_1.0 = select i1 %cmp295, float %div, float 0.000000e+00, !dbg !142
  %mul308 = fmul contract float %condval_1.0, %mul.i.i, !dbg !143
  %mul308.1 = fmul contract float %condval_1.0, %mul.i.i.1, !dbg !143
  %mul308.2 = fmul contract float %condval_1.0, %mul.i.i.2, !dbg !143
  %mul308.3 = fmul contract float %condval_1.0, %mul.i.i.3, !dbg !143
  %55 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul308), !dbg !144
  %56 = insertelement <4 x i16> poison, i16 %55, i64 0, !dbg !153
  %57 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul308.1), !dbg !144
  %58 = insertelement <4 x i16> %56, i16 %57, i64 1, !dbg !153
  %59 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul308.2), !dbg !144
  %60 = insertelement <4 x i16> %58, i16 %59, i64 2, !dbg !153
  %61 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul308.3), !dbg !144
  %62 = insertelement <4 x i16> %60, i16 %61, i64 3, !dbg !153
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %62 to <4 x half>, !dbg !153
  fence syncscope("warp") release, !dbg !154
  tail call void @llvm.mxc.barrier.warp(), !dbg !157
  fence syncscope("warp") acquire, !dbg !158
  br label %if.end326, !dbg !159

if.end326:                                        ; preds = %if.end197, %entry
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ undef, %entry ], [ %acc_s_cast.sroa.0.6.vec.insert, %if.end197 ]
  br i1 %or.cond631, label %if.end396, label %for.cond348.preheader, !dbg !160

for.cond348.preheader:                            ; preds = %if.end326
  %63 = shl nuw nsw i32 %1, 4
  %mul358 = and i32 %63, 16128
  %and364 = and i32 %1, 15
  %add365 = or disjoint i32 %mul358, %and364, !dbg !161
  %arrayidx367 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365, !dbg !162
  %64 = load half, ptr addrspace(3) %arrayidx367, align 2, !dbg !163, !tbaa !164
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %64, i64 0, !dbg !163
  %add360.1 = or disjoint i32 %mul358, %and364, !dbg !161
  %add365.1 = or disjoint i32 %add360.1, 64, !dbg !161
  %arrayidx367.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365.1, !dbg !162
  %65 = load half, ptr addrspace(3) %arrayidx367.1, align 2, !dbg !163, !tbaa !164
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %65, i64 1, !dbg !163
  %add360.2 = or disjoint i32 %mul358, %and364, !dbg !161
  %add365.2 = or disjoint i32 %add360.2, 128, !dbg !161
  %arrayidx367.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365.2, !dbg !162
  %66 = load half, ptr addrspace(3) %arrayidx367.2, align 2, !dbg !163, !tbaa !164
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %66, i64 2, !dbg !163
  %add360.3 = or disjoint i32 %mul358, %and364, !dbg !161
  %add365.3 = or disjoint i32 %add360.3, 192, !dbg !161
  %arrayidx367.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365.3, !dbg !162
  %67 = load half, ptr addrspace(3) %arrayidx367.3, align 2, !dbg !163, !tbaa !164
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %67, i64 3, !dbg !163
  %add362.1664 = or disjoint i32 %mul358, %and364, !dbg !161
  %add365.1665 = or disjoint i32 %add362.1664, 16, !dbg !161
  %arrayidx367.1666 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365.1665, !dbg !162
  %68 = load half, ptr addrspace(3) %arrayidx367.1666, align 2, !dbg !163, !tbaa !164
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %68, i64 0, !dbg !163
  %add362.1.1 = or disjoint i32 %mul358, %and364, !dbg !161
  %add365.1.1 = or disjoint i32 %add362.1.1, 80, !dbg !161
  %arrayidx367.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365.1.1, !dbg !162
  %69 = load half, ptr addrspace(3) %arrayidx367.1.1, align 2, !dbg !163, !tbaa !164
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %69, i64 1, !dbg !163
  %add362.2.1 = or disjoint i32 %mul358, %and364, !dbg !161
  %add365.2.1 = or disjoint i32 %add362.2.1, 144, !dbg !161
  %arrayidx367.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365.2.1, !dbg !162
  %70 = load half, ptr addrspace(3) %arrayidx367.2.1, align 2, !dbg !163, !tbaa !164
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %70, i64 2, !dbg !163
  %add362.3.1 = or disjoint i32 %mul358, %and364, !dbg !161
  %add365.3.1 = or disjoint i32 %add362.3.1, 208, !dbg !161
  %arrayidx367.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365.3.1, !dbg !162
  %71 = load half, ptr addrspace(3) %arrayidx367.3.1, align 2, !dbg !163, !tbaa !164
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %71, i64 3, !dbg !163
  %add362.2668 = or disjoint i32 %mul358, %and364, !dbg !161
  %add365.2669 = or disjoint i32 %add362.2668, 32, !dbg !161
  %arrayidx367.2670 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365.2669, !dbg !162
  %72 = load half, ptr addrspace(3) %arrayidx367.2670, align 2, !dbg !163, !tbaa !164
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %72, i64 0, !dbg !163
  %add362.1.2 = or disjoint i32 %mul358, %and364, !dbg !161
  %add365.1.2 = or disjoint i32 %add362.1.2, 96, !dbg !161
  %arrayidx367.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365.1.2, !dbg !162
  %73 = load half, ptr addrspace(3) %arrayidx367.1.2, align 2, !dbg !163, !tbaa !164
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %73, i64 1, !dbg !163
  %add362.2.2 = or disjoint i32 %mul358, %and364, !dbg !161
  %add365.2.2 = or disjoint i32 %add362.2.2, 160, !dbg !161
  %arrayidx367.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365.2.2, !dbg !162
  %74 = load half, ptr addrspace(3) %arrayidx367.2.2, align 2, !dbg !163, !tbaa !164
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %74, i64 2, !dbg !163
  %add362.3.2 = or disjoint i32 %mul358, %and364, !dbg !161
  %add365.3.2 = or disjoint i32 %add362.3.2, 224, !dbg !161
  %arrayidx367.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365.3.2, !dbg !162
  %75 = load half, ptr addrspace(3) %arrayidx367.3.2, align 2, !dbg !163, !tbaa !164
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %75, i64 3, !dbg !163
  %add362.3672 = or disjoint i32 %mul358, %and364, !dbg !161
  %add365.3673 = or disjoint i32 %add362.3672, 48, !dbg !161
  %arrayidx367.3674 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365.3673, !dbg !162
  %76 = load half, ptr addrspace(3) %arrayidx367.3674, align 2, !dbg !163, !tbaa !164
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %76, i64 0, !dbg !163
  %add362.1.3 = or disjoint i32 %mul358, %and364, !dbg !161
  %add365.1.3 = or disjoint i32 %add362.1.3, 112, !dbg !161
  %arrayidx367.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365.1.3, !dbg !162
  %77 = load half, ptr addrspace(3) %arrayidx367.1.3, align 2, !dbg !163, !tbaa !164
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %77, i64 1, !dbg !163
  %add362.2.3 = or disjoint i32 %mul358, %and364, !dbg !161
  %add365.2.3 = or disjoint i32 %add362.2.3, 176, !dbg !161
  %arrayidx367.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365.2.3, !dbg !162
  %78 = load half, ptr addrspace(3) %arrayidx367.2.3, align 2, !dbg !163, !tbaa !164
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %78, i64 2, !dbg !163
  %add362.3.3 = or disjoint i32 %63, %and364, !dbg !161
  %add365.3.3 = or i32 %add362.3.3, 240, !dbg !161
  %arrayidx367.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add365.3.3, !dbg !162
  %79 = load half, ptr addrspace(3) %arrayidx367.3.3, align 2, !dbg !163, !tbaa !164
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %79, i64 3, !dbg !163
  %80 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !165
  %81 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !165
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !165
  %83 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !165
  br label %if.end396, !dbg !166

if.end396:                                        ; preds = %for.cond348.preheader, %if.end326
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end326 ], [ %80, %for.cond348.preheader ], !dbg !87
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end326 ], [ %81, %for.cond348.preheader ], !dbg !87
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end326 ], [ %82, %for.cond348.preheader ], !dbg !87
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end326 ], [ %83, %for.cond348.preheader ], !dbg !87
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0, !dbg !167
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract), !dbg !168
  %O_reg.sroa.0.0.insert.ext = zext i16 %84 to i64, !dbg !172
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1, !dbg !167
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract), !dbg !168
  %O_reg.sroa.0.2.insert.ext = zext i16 %85 to i64, !dbg !172
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !172
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !172
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2, !dbg !167
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract), !dbg !168
  %O_reg.sroa.0.4.insert.ext = zext i16 %86 to i64, !dbg !172
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !172
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !172
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3, !dbg !167
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract), !dbg !168
  %O_reg.sroa.0.6.insert.ext = zext i16 %87 to i64, !dbg !172
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !172
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !172
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0, !dbg !167
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract), !dbg !168
  %O_reg.sroa.7.8.insert.ext = zext i16 %88 to i64, !dbg !172
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1, !dbg !167
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract), !dbg !168
  %O_reg.sroa.7.10.insert.ext = zext i16 %89 to i64, !dbg !172
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !172
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !172
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2, !dbg !167
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract), !dbg !168
  %O_reg.sroa.7.12.insert.ext = zext i16 %90 to i64, !dbg !172
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !172
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !172
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3, !dbg !167
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract), !dbg !168
  %O_reg.sroa.7.14.insert.ext = zext i16 %91 to i64, !dbg !172
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !172
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !172
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0, !dbg !167
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract), !dbg !168
  %O_reg.sroa.12.16.insert.ext = zext i16 %92 to i64, !dbg !172
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1, !dbg !167
  %93 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract), !dbg !168
  %O_reg.sroa.12.18.insert.ext = zext i16 %93 to i64, !dbg !172
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !172
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !172
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2, !dbg !167
  %94 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract), !dbg !168
  %O_reg.sroa.12.20.insert.ext = zext i16 %94 to i64, !dbg !172
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !172
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !172
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3, !dbg !167
  %95 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract), !dbg !168
  %O_reg.sroa.12.22.insert.ext = zext i16 %95 to i64, !dbg !172
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !172
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !172
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0, !dbg !167
  %96 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract), !dbg !168
  %O_reg.sroa.17.24.insert.ext = zext i16 %96 to i64, !dbg !172
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1, !dbg !167
  %97 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract), !dbg !168
  %O_reg.sroa.17.26.insert.ext = zext i16 %97 to i64, !dbg !172
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !172
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !172
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2, !dbg !167
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract), !dbg !168
  %O_reg.sroa.17.28.insert.ext = zext i16 %98 to i64, !dbg !172
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !172
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !172
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3, !dbg !167
  %99 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract), !dbg !168
  %O_reg.sroa.17.30.insert.ext = zext i16 %99 to i64, !dbg !172
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !172
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !172
  fence syncscope("warp") release, !dbg !173
  tail call void @llvm.mxc.barrier.warp(), !dbg !176
  fence syncscope("warp") acquire, !dbg !177
  %and429 = shl nuw nsw i32 %1, 6
  %mul430 = and i32 %and429, 960
  %shr433 = lshr i32 %1, 5
  %and436 = and i32 %1, 7
  %100 = lshr i32 %1, 2
  %mul443 = and i32 %100, 4
  %xor437 = xor i32 %shr433, %and436, !dbg !178
  %mul438 = shl nuw nsw i32 %xor437, 3, !dbg !179
  %add439 = add nuw nsw i32 %mul438, %mul430, !dbg !180
  %add444 = or disjoint i32 %add439, %mul443, !dbg !181
  %add.ptr446 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add444, !dbg !182
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr446, align 8, !dbg !183
  %add434.1 = add nuw nsw i32 %shr433, 2, !dbg !184
  %xor437.1 = xor i32 %add434.1, %and436, !dbg !178
  %mul438.1 = shl nuw nsw i32 %xor437.1, 3, !dbg !179
  %add439.1 = add nuw nsw i32 %mul438.1, %mul430, !dbg !180
  %add444.1 = or disjoint i32 %add439.1, %mul443, !dbg !181
  %add.ptr446.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add444.1, !dbg !182
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr446.1, align 8, !dbg !183
  %add434.2 = add nuw nsw i32 %shr433, 4, !dbg !184
  %xor437.2 = xor i32 %add434.2, %and436, !dbg !178
  %mul438.2 = shl nuw nsw i32 %xor437.2, 3, !dbg !179
  %add439.2 = add nuw nsw i32 %mul438.2, %mul430, !dbg !180
  %add444.2 = or disjoint i32 %add439.2, %mul443, !dbg !181
  %add.ptr446.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add444.2, !dbg !182
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr446.2, align 8, !dbg !183
  %add434.3 = add nuw nsw i32 %shr433, 6, !dbg !184
  %xor437.3 = xor i32 %add434.3, %and436, !dbg !178
  %mul438.3 = shl nuw nsw i32 %xor437.3, 3, !dbg !179
  %add439.3 = add nuw nsw i32 %mul438.3, %mul430, !dbg !180
  %add444.3 = or disjoint i32 %add439.3, %mul443, !dbg !181
  %add.ptr446.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add444.3, !dbg !182
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr446.3, align 8, !dbg !183
  fence syncscope("warp") release, !dbg !185
  tail call void @llvm.mxc.barrier.warp(), !dbg !188
  fence syncscope("warp") acquire, !dbg !189
  %mul457 = and i32 %mul8, 8128
  %xor463578 = and i32 %mul8, 56
  %call461.masked = and i32 %1, 1016
  %mul464 = xor i32 %xor463578, %call461.masked
  %invariant.gep626 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul457, !dbg !190
  %invariant.gep628 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep626, i32 %mul464, !dbg !190
  %add.ptr476 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %2, !dbg !191
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr476, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep628, i64 16, i1 false), !dbg !192, !tbaa.struct !193, !call_argsrelate !194
  %gep629.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep628, i32 1024, !dbg !195
  %add.ptr476.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3, !dbg !191
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr476.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep629.1, i64 16, i1 false), !dbg !192, !tbaa.struct !193, !call_argsrelate !194
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

; Function Attrs: convergent nounwind willreturn
declare void @llvm.mxc.barrier.warp() #6

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

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
attributes #11 = { nomerge }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmpd7czuryn/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpd7czuryn/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 25, column: 3, scope: !40)
!44 = !DILocation(line: 26, column: 92, scope: !40)
!45 = !DILocation(line: 28, column: 25, scope: !40)
!46 = !DILocation(line: 34, column: 31, scope: !40)
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
!76 = !DILocation(line: 35, column: 43, scope: !40)
!77 = !DILocation(line: 64, column: 49, scope: !40)
!78 = !DILocation(line: 64, column: 27, scope: !40)
!79 = !DILocation(line: 64, column: 9, scope: !40)
!80 = !DILocation(line: 68, column: 77, scope: !40)
!81 = !DILocation(line: 68, column: 13, scope: !40)
!82 = !DILocation(line: 73, column: 20, scope: !40)
!83 = !DILocation(line: 68, column: 70, scope: !40)
!84 = !DILocation(line: 68, column: 3, scope: !59, inlinedAt: !85)
!85 = distinct !DILocation(line: 192, column: 3, scope: !62, inlinedAt: !86)
!86 = distinct !DILocation(line: 79, column: 5, scope: !40)
!87 = !DILocation(line: 0, scope: !40)
!88 = !DILocation(line: 69, column: 3, scope: !59, inlinedAt: !85)
!89 = !DILocation(line: 70, column: 3, scope: !59, inlinedAt: !85)
!90 = !DILocation(line: 81, column: 25, scope: !40)
!91 = !DILocation(line: 84, column: 36, scope: !40)
!92 = !DILocation(line: 68, column: 3, scope: !59, inlinedAt: !93)
!93 = distinct !DILocation(line: 192, column: 3, scope: !62, inlinedAt: !94)
!94 = distinct !DILocation(line: 90, column: 5, scope: !40)
!95 = !DILocation(line: 69, column: 3, scope: !59, inlinedAt: !93)
!96 = !DILocation(line: 70, column: 3, scope: !59, inlinedAt: !93)
!97 = !DILocation(line: 92, column: 10, scope: !40)
!98 = !DILocation(line: 93, column: 86, scope: !40)
!99 = !DILocation(line: 93, column: 42, scope: !40)
!100 = !DILocation(line: 97, column: 31, scope: !40)
!101 = !DILocation(line: 97, column: 42, scope: !40)
!102 = !DILocation(line: 354, column: 10, scope: !103, inlinedAt: !105)
!103 = distinct !DISubprogram(name: "min", scope: !104, file: !104, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!104 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!105 = distinct !DILocation(line: 97, column: 26, scope: !40)
!106 = !DILocation(line: 285, column: 49, scope: !107, inlinedAt: !108)
!107 = distinct !DISubprogram(name: "exp2f", scope: !104, file: !104, line: 285, type: !7, scopeLine: 285, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!108 = distinct !DILocation(line: 97, column: 20, scope: !40)
!109 = !DILocation(line: 102, column: 34, scope: !40)
!110 = !DILocation(line: 1018, column: 9, scope: !111, inlinedAt: !112)
!111 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !60, file: !60, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!112 = distinct !DILocation(line: 104, column: 34, scope: !40)
!113 = !DILocation(line: 171, column: 37, scope: !114, inlinedAt: !115)
!114 = distinct !DISubprogram(name: "__lane_id", scope: !60, file: !60, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!115 = distinct !DILocation(line: 990, column: 14, scope: !116, inlinedAt: !117)
!116 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !60, file: !60, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!117 = distinct !DILocation(line: 1019, column: 11, scope: !111, inlinedAt: !112)
!118 = !DILocation(line: 171, column: 10, scope: !114, inlinedAt: !115)
!119 = !DILocation(line: 991, column: 20, scope: !116, inlinedAt: !117)
!120 = !DILocation(line: 992, column: 36, scope: !116, inlinedAt: !117)
!121 = !DILocation(line: 992, column: 17, scope: !116, inlinedAt: !117)
!122 = !DILocation(line: 992, column: 11, scope: !116, inlinedAt: !117)
!123 = !DILocation(line: 993, column: 43, scope: !116, inlinedAt: !117)
!124 = !DILocation(line: 993, column: 10, scope: !116, inlinedAt: !117)
!125 = !DILocation(line: 1020, column: 14, scope: !111, inlinedAt: !112)
!126 = !DILocation(line: 104, column: 32, scope: !40)
!127 = !DILocation(line: 1018, column: 9, scope: !111, inlinedAt: !128)
!128 = distinct !DILocation(line: 105, column: 34, scope: !40)
!129 = !DILocation(line: 171, column: 37, scope: !114, inlinedAt: !130)
!130 = distinct !DILocation(line: 990, column: 14, scope: !116, inlinedAt: !131)
!131 = distinct !DILocation(line: 1019, column: 11, scope: !111, inlinedAt: !128)
!132 = !DILocation(line: 171, column: 10, scope: !114, inlinedAt: !130)
!133 = !DILocation(line: 991, column: 20, scope: !116, inlinedAt: !131)
!134 = !DILocation(line: 992, column: 36, scope: !116, inlinedAt: !131)
!135 = !DILocation(line: 992, column: 17, scope: !116, inlinedAt: !131)
!136 = !DILocation(line: 992, column: 11, scope: !116, inlinedAt: !131)
!137 = !DILocation(line: 993, column: 43, scope: !116, inlinedAt: !131)
!138 = !DILocation(line: 993, column: 10, scope: !116, inlinedAt: !131)
!139 = !DILocation(line: 1020, column: 14, scope: !111, inlinedAt: !128)
!140 = !DILocation(line: 105, column: 32, scope: !40)
!141 = !DILocation(line: 107, column: 34, scope: !40)
!142 = !DILocation(line: 107, column: 9, scope: !40)
!143 = !DILocation(line: 115, column: 32, scope: !40)
!144 = !DILocation(line: 75, column: 10, scope: !145, inlinedAt: !147)
!145 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !146, file: !146, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!146 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!147 = distinct !DILocation(line: 984, column: 9, scope: !148, inlinedAt: !150)
!148 = distinct !DISubprogram(name: "__float2half", scope: !149, file: !149, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!149 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!150 = distinct !DILocation(line: 133, column: 53, scope: !151, inlinedAt: !152)
!151 = distinct !DISubprogram(name: "__half", scope: !149, file: !149, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!152 = distinct !DILocation(line: 119, column: 32, scope: !40)
!153 = !DILocation(line: 119, column: 29, scope: !40)
!154 = !DILocation(line: 68, column: 3, scope: !59, inlinedAt: !155)
!155 = distinct !DILocation(line: 192, column: 3, scope: !62, inlinedAt: !156)
!156 = distinct !DILocation(line: 121, column: 5, scope: !40)
!157 = !DILocation(line: 69, column: 3, scope: !59, inlinedAt: !155)
!158 = !DILocation(line: 70, column: 3, scope: !59, inlinedAt: !155)
!159 = !DILocation(line: 122, column: 3, scope: !40)
!160 = !DILocation(line: 128, column: 31, scope: !40)
!161 = !DILocation(line: 131, column: 119, scope: !40)
!162 = !DILocation(line: 131, column: 31, scope: !40)
!163 = !DILocation(line: 131, column: 29, scope: !40)
!164 = !{!26, !26, i64 0}
!165 = !DILocation(line: 136, column: 38, scope: !40)
!166 = !DILocation(line: 143, column: 3, scope: !40)
!167 = !DILocation(line: 146, column: 58, scope: !40)
!168 = !DILocation(line: 75, column: 10, scope: !145, inlinedAt: !169)
!169 = distinct !DILocation(line: 984, column: 9, scope: !148, inlinedAt: !170)
!170 = distinct !DILocation(line: 133, column: 53, scope: !151, inlinedAt: !171)
!171 = distinct !DILocation(line: 146, column: 50, scope: !40)
!172 = !DILocation(line: 146, column: 47, scope: !40)
!173 = !DILocation(line: 68, column: 3, scope: !59, inlinedAt: !174)
!174 = distinct !DILocation(line: 192, column: 3, scope: !62, inlinedAt: !175)
!175 = distinct !DILocation(line: 149, column: 3, scope: !40)
!176 = !DILocation(line: 69, column: 3, scope: !59, inlinedAt: !174)
!177 = !DILocation(line: 70, column: 3, scope: !59, inlinedAt: !174)
!178 = !DILocation(line: 152, column: 122, scope: !40)
!179 = !DILocation(line: 152, column: 150, scope: !40)
!180 = !DILocation(line: 152, column: 77, scope: !40)
!181 = !DILocation(line: 152, column: 156, scope: !40)
!182 = !DILocation(line: 152, column: 40, scope: !40)
!183 = !DILocation(line: 152, column: 199, scope: !40)
!184 = !DILocation(line: 152, column: 93, scope: !40)
!185 = !DILocation(line: 68, column: 3, scope: !59, inlinedAt: !186)
!186 = distinct !DILocation(line: 192, column: 3, scope: !62, inlinedAt: !187)
!187 = distinct !DILocation(line: 154, column: 3, scope: !40)
!188 = !DILocation(line: 69, column: 3, scope: !59, inlinedAt: !186)
!189 = !DILocation(line: 70, column: 3, scope: !59, inlinedAt: !186)
!190 = !DILocation(line: 156, column: 8, scope: !40)
!191 = !DILocation(line: 157, column: 22, scope: !40)
!192 = !DILocation(line: 157, column: 98, scope: !40)
!193 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!194 = !{i32 2, i32 -1, i32 -1, i32 -1}
!195 = !DILocation(line: 157, column: 135, scope: !40)
!196 = !DILocation(line: 159, column: 1, scope: !40)
