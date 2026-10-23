; ModuleID = '/data/tilelang-metax/race_tests/nsa/experiments/20261016_goal895/validation_dispatch_r1/actual_binary/d64_b1_h1_t496_c1_m0_p0.bc'
source_filename = "/tmp/tmp7_8upr4j/tvm_kernels.maca"
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
  %idxprom = zext nneg i32 %0 to i64, !dbg !43
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom, !dbg !43
  %2 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !43, !tbaa !30
  %cmp28 = icmp ugt i32 %2, 30
  %shr = lshr i32 %0, 4
  %cmp31.not = icmp ugt i32 %2, %shr
  %or.cond561 = or i1 %cmp28, %cmp31.not, !dbg !44
  br i1 %or.cond561, label %entry.if.end375_crit_edge, label %if.then, !dbg !44

entry.if.end375_crit_edge:                        ; preds = %entry
  %.pre = shl nuw nsw i32 %1, 6
  %.pre689 = and i32 %.pre, 960
  br label %if.end375, !dbg !44

if.then:                                          ; preds = %entry
  %mul8 = shl nuw nsw i32 %1, 3
  %add = add nuw nsw i32 %mul8, %mul
  %3 = zext nneg i32 %add to i64, !dbg !45
  %4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !46
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %4, i64 1024, !dbg !46
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !46
  %mul43 = shl nuw nsw i32 %2, 10
  %add45 = add nuw nsw i32 %mul43, %mul8
  %5 = zext nneg i32 %add45 to i64, !dbg !47
  %add.ptr52 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %5, !dbg !48
  %6 = load i32, ptr addrspace(4) %add.ptr52, align 4, !dbg !49, !tbaa !30
  %7 = or disjoint i64 %5, 2, !dbg !50
  %add.ptr52.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %7, !dbg !48
  %8 = load i32, ptr addrspace(4) %add.ptr52.1, align 4, !dbg !49, !tbaa !30
  %9 = or disjoint i64 %5, 4, !dbg !50
  %add.ptr52.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %9, !dbg !48
  %10 = load i32, ptr addrspace(4) %add.ptr52.2, align 4, !dbg !49, !tbaa !30
  %11 = or disjoint i64 %5, 6, !dbg !50
  %add.ptr52.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %11, !dbg !48
  %12 = load i32, ptr addrspace(4) %add.ptr52.3, align 4, !dbg !49, !tbaa !30
  %13 = add nuw nsw i64 %5, 512
  %add.ptr52.1576 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %13, !dbg !48
  %14 = load i32, ptr addrspace(4) %add.ptr52.1576, align 4, !dbg !49, !tbaa !30
  %15 = add nuw nsw i64 %5, 514, !dbg !50
  %add.ptr52.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %15, !dbg !48
  %16 = load i32, ptr addrspace(4) %add.ptr52.1.1, align 4, !dbg !49, !tbaa !30
  %17 = add nuw nsw i64 %5, 516, !dbg !50
  %add.ptr52.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %17, !dbg !48
  %18 = load i32, ptr addrspace(4) %add.ptr52.2.1, align 4, !dbg !49, !tbaa !30
  %19 = add nuw nsw i64 %5, 518, !dbg !50
  %add.ptr52.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %19, !dbg !48
  %20 = load i32, ptr addrspace(4) %add.ptr52.3.1, align 4, !dbg !49, !tbaa !30
  %add.ptr82 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %5, !dbg !51
  %21 = load i32, ptr addrspace(4) %add.ptr82, align 4, !dbg !52, !tbaa !30
  %add.ptr82.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %7, !dbg !51
  %22 = load i32, ptr addrspace(4) %add.ptr82.1, align 4, !dbg !52, !tbaa !30
  %add.ptr82.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %9, !dbg !51
  %23 = load i32, ptr addrspace(4) %add.ptr82.2, align 4, !dbg !52, !tbaa !30
  %add.ptr82.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %11, !dbg !51
  %24 = load i32, ptr addrspace(4) %add.ptr82.3, align 4, !dbg !52, !tbaa !30
  %add.ptr82.1588 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %13, !dbg !51
  %25 = load i32, ptr addrspace(4) %add.ptr82.1588, align 4, !dbg !52, !tbaa !30
  %add.ptr82.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %15, !dbg !51
  %26 = load i32, ptr addrspace(4) %add.ptr82.1.1, align 4, !dbg !52, !tbaa !30
  %add.ptr82.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %17, !dbg !51
  %27 = load i32, ptr addrspace(4) %add.ptr82.2.1, align 4, !dbg !52, !tbaa !30
  %add.ptr82.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %19, !dbg !51
  %28 = load i32, ptr addrspace(4) %add.ptr82.3.1, align 4, !dbg !52, !tbaa !30
  %mul106 = and i32 %mul8, 8128
  %xor501 = and i32 %mul8, 56
  %call109.masked = and i32 %1, 1016
  %mul111 = xor i32 %xor501, %call109.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul106, !dbg !53
  %invariant.gep537 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul111, !dbg !53
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep537, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !dbg !54, !call_argsrelate !55
  %gep538.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep537, i32 1024, !dbg !56
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep538.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !dbg !54, !call_argsrelate !55
  fence syncscope("warp") release, !dbg !57
  tail call void @llvm.mxc.barrier.warp(), !dbg !63
  fence syncscope("warp") acquire, !dbg !64
  %and123 = shl nuw nsw i32 %1, 6
  %mul124 = and i32 %and123, 960
  %shr127 = lshr i32 %1, 4
  %and130 = and i32 %1, 7
  %29 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul124
  %xor131 = xor i32 %shr127, %and130, !dbg !65
  %add.ptr135.idx = shl nuw nsw i32 %xor131, 4, !dbg !66
  %add.ptr135 = getelementptr inbounds i8, ptr addrspace(3) %29, i32 %add.ptr135.idx, !dbg !66
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr135, align 16, !dbg !67
  %Q_reg.sroa.4.0.add.ptr135.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr135, i32 8, !dbg !67
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr135.sroa_idx, align 8, !dbg !67
  %add128.1 = add nuw nsw i32 %shr127, 4, !dbg !68
  %xor131.1 = xor i32 %add128.1, %and130, !dbg !65
  %add.ptr135.idx.1 = shl nuw nsw i32 %xor131.1, 4, !dbg !66
  %add.ptr135.1 = getelementptr inbounds i8, ptr addrspace(3) %29, i32 %add.ptr135.idx.1, !dbg !66
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr135.1, align 16, !dbg !67
  %Q_reg.sroa.7.16.add.ptr135.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr135.1, i32 8, !dbg !67
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr135.1.sroa_idx, align 8, !dbg !67
  fence syncscope("warp") release, !dbg !69
  tail call void @llvm.mxc.barrier.warp(), !dbg !72
  fence syncscope("warp") acquire, !dbg !73
  store i32 %6, ptr addrspace(3) %invariant.gep537, align 16, !dbg !74, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep542.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep537, i32 4, !dbg !74
  store i32 %8, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep542.sroa_idx, align 4, !dbg !74, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep542.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep537, i32 8, !dbg !74
  store i32 %10, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep542.sroa_idx, align 8, !dbg !74, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep542.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep537, i32 12, !dbg !74
  store i32 %12, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep542.sroa_idx, align 4, !dbg !74, !tbaa !30
  store i32 %14, ptr addrspace(3) %gep538.1, align 16, !dbg !74, !tbaa !30
  %K_reg.sroa.9.16.gep543.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep537, i32 1028, !dbg !74
  store i32 %16, ptr addrspace(3) %K_reg.sroa.9.16.gep543.1.sroa_idx, align 4, !dbg !74, !tbaa !30
  %K_reg.sroa.10.16.gep543.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep537, i32 1032, !dbg !74
  store i32 %18, ptr addrspace(3) %K_reg.sroa.10.16.gep543.1.sroa_idx, align 8, !dbg !74, !tbaa !30
  %K_reg.sroa.11.16.gep543.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep537, i32 1036, !dbg !74
  store i32 %20, ptr addrspace(3) %K_reg.sroa.11.16.gep543.1.sroa_idx, align 4, !dbg !74, !tbaa !30
  %mul32 = shl nuw nsw i32 %2, 4, !dbg !75
  %add170 = or disjoint i32 %mul32, 15, !dbg !76
  %cmp171 = icmp ult i32 %0, %add170, !dbg !77
  br i1 %cmp171, label %for.cond173.preheader, label %if.end197, !dbg !78

for.cond173.preheader:                            ; preds = %if.then
  %30 = lshr i32 %1, 2
  %mul179 = and i32 %30, 252
  %add181 = add nuw nsw i32 %mul32, %mul179
  %cmp184.not = icmp ugt i32 %add181, %0, !dbg !79
  %spec.select = select i1 %cmp184.not, float 0xFFF0000000000000, float 0.000000e+00, !dbg !80
  %acc_s.sroa.0.0.vec.insert619 = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !81
  %cmp184.not.1.not = icmp ult i32 %add181, %0, !dbg !79
  %spec.select.1 = select i1 %cmp184.not.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !80
  %acc_s.sroa.0.4.vec.insert632 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert619, float %spec.select.1, i64 1, !dbg !81
  %add182.2 = or disjoint i32 %add181, 2, !dbg !82
  %cmp184.not.2 = icmp ugt i32 %add182.2, %0, !dbg !79
  %spec.select.2 = select i1 %cmp184.not.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !80
  %acc_s.sroa.0.8.vec.insert645 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert632, float %spec.select.2, i64 2, !dbg !81
  %add182.3 = or disjoint i32 %add181, 3, !dbg !82
  %cmp184.not.3 = icmp ugt i32 %add182.3, %0, !dbg !79
  %spec.select.3 = select i1 %cmp184.not.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !80
  %acc_s.sroa.0.12.vec.insert658 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert645, float %spec.select.3, i64 3, !dbg !81
  br label %if.end197, !dbg !83

if.end197:                                        ; preds = %if.then, %for.cond173.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert658, %for.cond173.preheader ], [ zeroinitializer, %if.then ], !dbg !86
  fence syncscope("warp") release, !dbg !83
  tail call void @llvm.mxc.barrier.warp(), !dbg !87
  fence syncscope("warp") acquire, !dbg !88
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr135, align 16, !dbg !89
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr135.sroa_idx, align 8, !dbg !89
  %31 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !dbg !90
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %31), !dbg !90
  %kb.sroa.0.0.copyload613 = load <4 x half>, ptr addrspace(3) %add.ptr135.1, align 16, !dbg !89
  %kb.sroa.6.0.copyload614 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr135.1.sroa_idx, align 8, !dbg !89
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload613, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %32), !dbg !90
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload614, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %33), !dbg !90
  fence syncscope("warp") release, !dbg !91
  tail call void @llvm.mxc.barrier.warp(), !dbg !94
  fence syncscope("warp") acquire, !dbg !95
  %add.ptr253.idx = shl nuw nsw i32 %1, 4
  %invariant.gep551 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr253.idx, !dbg !96
  store i32 %21, ptr addrspace(3) %invariant.gep551, align 16, !dbg !97, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep551.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep551, i32 4, !dbg !97
  store i32 %22, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep551.sroa_idx, align 4, !dbg !97, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep551.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep551, i32 8, !dbg !97
  store i32 %23, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep551.sroa_idx, align 8, !dbg !97, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep551.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep551, i32 12, !dbg !97
  store i32 %24, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep551.sroa_idx, align 4, !dbg !97, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep551, i32 1024, !dbg !98
  store i32 %25, ptr addrspace(3) %gep.1, align 16, !dbg !97, !tbaa !30
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep551, i32 1028, !dbg !97
  store i32 %26, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !dbg !97, !tbaa !30
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep551, i32 1032, !dbg !97
  store i32 %27, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !dbg !97, !tbaa !30
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep551, i32 1036, !dbg !97
  store i32 %28, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !dbg !97, !tbaa !30
  %acc_s.sroa.0.0.vec.extract621 = extractelement <4 x float> %34, i64 0, !dbg !99
  %mul263 = fmul contract float %acc_s.sroa.0.0.vec.extract621, 0x3FC2776C60000000, !dbg !100
  %35 = tail call contract noundef float @llvm.minnum.f32(float %mul263, float 1.500000e+01), !dbg !101
  %cmp.i.i = fcmp contract olt float %35, -1.260000e+02, !dbg !105
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00, !dbg !105
  %add.i.i = fadd contract float %35, %cond.i.i, !dbg !105
  %36 = tail call contract float @llvm.exp2.f32(float %add.i.i), !dbg !105
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00, !dbg !105
  %mul.i.i = fmul contract float %cond2.i.i, %36, !dbg !105
  %acc_s.sroa.0.4.vec.extract634 = extractelement <4 x float> %34, i64 1, !dbg !99
  %mul263.1 = fmul contract float %acc_s.sroa.0.4.vec.extract634, 0x3FC2776C60000000, !dbg !100
  %37 = tail call contract noundef float @llvm.minnum.f32(float %mul263.1, float 1.500000e+01), !dbg !101
  %cmp.i.i.1 = fcmp contract olt float %37, -1.260000e+02, !dbg !105
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00, !dbg !105
  %add.i.i.1 = fadd contract float %37, %cond.i.i.1, !dbg !105
  %38 = tail call contract float @llvm.exp2.f32(float %add.i.i.1), !dbg !105
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !105
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %38, !dbg !105
  %acc_s.sroa.0.8.vec.extract647 = extractelement <4 x float> %34, i64 2, !dbg !99
  %mul263.2 = fmul contract float %acc_s.sroa.0.8.vec.extract647, 0x3FC2776C60000000, !dbg !100
  %39 = tail call contract noundef float @llvm.minnum.f32(float %mul263.2, float 1.500000e+01), !dbg !101
  %cmp.i.i.2 = fcmp contract olt float %39, -1.260000e+02, !dbg !105
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00, !dbg !105
  %add.i.i.2 = fadd contract float %39, %cond.i.i.2, !dbg !105
  %40 = tail call contract float @llvm.exp2.f32(float %add.i.i.2), !dbg !105
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00, !dbg !105
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %40, !dbg !105
  %acc_s.sroa.0.12.vec.extract660 = extractelement <4 x float> %34, i64 3, !dbg !99
  %mul263.3 = fmul contract float %acc_s.sroa.0.12.vec.extract660, 0x3FC2776C60000000, !dbg !100
  %41 = tail call contract noundef float @llvm.minnum.f32(float %mul263.3, float 1.500000e+01), !dbg !101
  %cmp.i.i.3 = fcmp contract olt float %41, -1.260000e+02, !dbg !105
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00, !dbg !105
  %add.i.i.3 = fadd contract float %41, %cond.i.i.3, !dbg !105
  %42 = tail call contract float @llvm.exp2.f32(float %add.i.i.3), !dbg !105
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00, !dbg !105
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %42, !dbg !105
  %add279 = fadd contract float %mul.i.i, 0.000000e+00, !dbg !108
  %add279.1 = fadd contract float %add279, %mul.i.i.1, !dbg !108
  %add279.2 = fadd contract float %add279.1, %mul.i.i.2, !dbg !108
  %add279.3 = fadd contract float %add279.2, %mul.i.i.3, !dbg !108
  %43 = bitcast float %add279.3 to i32, !dbg !109
  %44 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !112
  %45 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %44) #11, !dbg !117
  %xor.i.i = xor i32 %45, 32, !dbg !118
  %46 = and i32 %45, -64, !dbg !119
  %and.i.i = add nsw i32 %46, 64, !dbg !119
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !120
  %cond.i.i503 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %45, !dbg !121
  %shl.i.i = shl i32 %cond.i.i503, 2, !dbg !122
  %47 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %43), !dbg !123
  %48 = bitcast i32 %47 to float, !dbg !124
  %add287 = fadd contract float %add279.3, %48, !dbg !125
  %49 = bitcast float %add287 to i32, !dbg !126
  %50 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !128
  %51 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %50) #11, !dbg !131
  %xor.i.i504 = xor i32 %51, 16, !dbg !132
  %52 = and i32 %51, -64, !dbg !133
  %and.i.i505 = add nsw i32 %52, 64, !dbg !133
  %cmp.not.i.i506 = icmp slt i32 %xor.i.i504, %and.i.i505, !dbg !134
  %cond.i.i507 = select i1 %cmp.not.i.i506, i32 %xor.i.i504, i32 %51, !dbg !135
  %shl.i.i508 = shl i32 %cond.i.i507, 2, !dbg !136
  %53 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i508, i32 %49), !dbg !137
  %54 = bitcast i32 %53 to float, !dbg !138
  %add292 = fadd contract float %add287, %54, !dbg !139
  %cmp295 = fcmp contract ogt float %add292, 0.000000e+00, !dbg !140
  %div = fdiv contract float 1.000000e+00, %add292, !dbg !141
  %condval_1.0 = select i1 %cmp295, float %div, float 0.000000e+00, !dbg !141
  %mul308 = fmul contract float %condval_1.0, %mul.i.i, !dbg !142
  %mul308.1 = fmul contract float %condval_1.0, %mul.i.i.1, !dbg !142
  %mul308.2 = fmul contract float %condval_1.0, %mul.i.i.2, !dbg !142
  %mul308.3 = fmul contract float %condval_1.0, %mul.i.i.3, !dbg !142
  %55 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !143
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !143, !noalias !151
  %56 = fptrunc float %mul308 to half, !dbg !143
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %55), !dbg !143, !noalias !151
  %57 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !156
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !156, !noalias !151
  %58 = fptrunc float %mul308.1 to half, !dbg !156
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %57), !dbg !156, !noalias !151
  %__1.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %56, i64 0, !dbg !158
  %__1.sroa.0.2.vec.insert = insertelement <4 x half> %__1.sroa.0.0.vec.insert, half %58, i64 1, !dbg !158
  %59 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !161
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !161, !noalias !165
  %60 = fptrunc float %mul308.2 to half, !dbg !161
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %59), !dbg !161, !noalias !165
  %61 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !170
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !170, !noalias !165
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %61), !dbg !170, !noalias !165
  %__1.sroa.0.4.vec.insert = insertelement <4 x half> %__1.sroa.0.2.vec.insert, half %60, i64 2, !dbg !172
  fence syncscope("warp") release, !dbg !174
  tail call void @llvm.mxc.barrier.warp(), !dbg !177
  fence syncscope("warp") acquire, !dbg !178
  %mul337 = and i32 %add.ptr253.idx, 16128
  %and343 = and i32 %1, 15
  %add344 = or disjoint i32 %mul337, %and343, !dbg !179
  %arrayidx346 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344, !dbg !180
  %62 = load half, ptr addrspace(3) %arrayidx346, align 2, !dbg !181, !tbaa !182
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %62, i64 0, !dbg !181
  %add339.1 = or disjoint i32 %mul337, %and343, !dbg !179
  %add344.1 = or disjoint i32 %add339.1, 64, !dbg !179
  %arrayidx346.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344.1, !dbg !180
  %63 = load half, ptr addrspace(3) %arrayidx346.1, align 2, !dbg !181, !tbaa !182
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %63, i64 1, !dbg !181
  %add339.2 = or disjoint i32 %mul337, %and343, !dbg !179
  %add344.2 = or disjoint i32 %add339.2, 128, !dbg !179
  %arrayidx346.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344.2, !dbg !180
  %64 = load half, ptr addrspace(3) %arrayidx346.2, align 2, !dbg !181, !tbaa !182
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %64, i64 2, !dbg !181
  %add339.3 = or disjoint i32 %mul337, %and343, !dbg !179
  %add344.3 = or disjoint i32 %add339.3, 192, !dbg !179
  %arrayidx346.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344.3, !dbg !180
  %65 = load half, ptr addrspace(3) %arrayidx346.3, align 2, !dbg !181, !tbaa !182
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %65, i64 3, !dbg !181
  %add341.1592 = or disjoint i32 %mul337, %and343, !dbg !179
  %add344.1593 = or disjoint i32 %add341.1592, 16, !dbg !179
  %arrayidx346.1594 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344.1593, !dbg !180
  %66 = load half, ptr addrspace(3) %arrayidx346.1594, align 2, !dbg !181, !tbaa !182
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %66, i64 0, !dbg !181
  %add341.1.1 = or disjoint i32 %mul337, %and343, !dbg !179
  %add344.1.1 = or disjoint i32 %add341.1.1, 80, !dbg !179
  %arrayidx346.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344.1.1, !dbg !180
  %67 = load half, ptr addrspace(3) %arrayidx346.1.1, align 2, !dbg !181, !tbaa !182
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %67, i64 1, !dbg !181
  %add341.2.1 = or disjoint i32 %mul337, %and343, !dbg !179
  %add344.2.1 = or disjoint i32 %add341.2.1, 144, !dbg !179
  %arrayidx346.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344.2.1, !dbg !180
  %68 = load half, ptr addrspace(3) %arrayidx346.2.1, align 2, !dbg !181, !tbaa !182
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %68, i64 2, !dbg !181
  %add341.3.1 = or disjoint i32 %mul337, %and343, !dbg !179
  %add344.3.1 = or disjoint i32 %add341.3.1, 208, !dbg !179
  %arrayidx346.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344.3.1, !dbg !180
  %69 = load half, ptr addrspace(3) %arrayidx346.3.1, align 2, !dbg !181, !tbaa !182
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %69, i64 3, !dbg !181
  %add341.2596 = or disjoint i32 %mul337, %and343, !dbg !179
  %add344.2597 = or disjoint i32 %add341.2596, 32, !dbg !179
  %arrayidx346.2598 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344.2597, !dbg !180
  %70 = load half, ptr addrspace(3) %arrayidx346.2598, align 2, !dbg !181, !tbaa !182
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %70, i64 0, !dbg !181
  %add341.1.2 = or disjoint i32 %mul337, %and343, !dbg !179
  %add344.1.2 = or disjoint i32 %add341.1.2, 96, !dbg !179
  %arrayidx346.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344.1.2, !dbg !180
  %71 = load half, ptr addrspace(3) %arrayidx346.1.2, align 2, !dbg !181, !tbaa !182
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %71, i64 1, !dbg !181
  %add341.2.2 = or disjoint i32 %mul337, %and343, !dbg !179
  %add344.2.2 = or disjoint i32 %add341.2.2, 160, !dbg !179
  %arrayidx346.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344.2.2, !dbg !180
  %72 = load half, ptr addrspace(3) %arrayidx346.2.2, align 2, !dbg !181, !tbaa !182
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %72, i64 2, !dbg !181
  %add341.3.2 = or disjoint i32 %mul337, %and343, !dbg !179
  %add344.3.2 = or disjoint i32 %add341.3.2, 224, !dbg !179
  %arrayidx346.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344.3.2, !dbg !180
  %73 = load half, ptr addrspace(3) %arrayidx346.3.2, align 2, !dbg !181, !tbaa !182
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %73, i64 3, !dbg !181
  %add341.3600 = or disjoint i32 %mul337, %and343, !dbg !179
  %add344.3601 = or disjoint i32 %add341.3600, 48, !dbg !179
  %arrayidx346.3602 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344.3601, !dbg !180
  %74 = load half, ptr addrspace(3) %arrayidx346.3602, align 2, !dbg !181, !tbaa !182
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %74, i64 0, !dbg !181
  %add341.1.3 = or disjoint i32 %mul337, %and343, !dbg !179
  %add344.1.3 = or disjoint i32 %add341.1.3, 112, !dbg !179
  %arrayidx346.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344.1.3, !dbg !180
  %75 = load half, ptr addrspace(3) %arrayidx346.1.3, align 2, !dbg !181, !tbaa !182
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %75, i64 1, !dbg !181
  %add341.2.3 = or disjoint i32 %mul337, %and343, !dbg !179
  %add344.2.3 = or disjoint i32 %add341.2.3, 176, !dbg !179
  %arrayidx346.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344.2.3, !dbg !180
  %76 = load half, ptr addrspace(3) %arrayidx346.2.3, align 2, !dbg !181, !tbaa !182
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %76, i64 2, !dbg !181
  %add341.3.3 = or disjoint i32 %add.ptr253.idx, %and343, !dbg !179
  %add344.3.3 = or i32 %add341.3.3, 240, !dbg !179
  %arrayidx346.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add344.3.3, !dbg !180
  %77 = load half, ptr addrspace(3) %arrayidx346.3.3, align 2, !dbg !181, !tbaa !182
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %77, i64 3, !dbg !181
  %78 = fptrunc float %mul308.3 to half, !dbg !170
  %__1.sroa.0.6.vec.insert = insertelement <4 x half> %__1.sroa.0.4.vec.insert, half %78, i64 3, !dbg !172
  %79 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !183
  %80 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !183
  %81 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !183
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %__1.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !183
  br label %if.end375

if.end375:                                        ; preds = %entry.if.end375_crit_edge, %if.end197
  %mul402.pre-phi = phi i32 [ %.pre689, %entry.if.end375_crit_edge ], [ %mul124, %if.end197 ]
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %entry.if.end375_crit_edge ], [ %79, %if.end197 ], !dbg !86
  %acc_o.sroa.12.0 = phi <4 x float> [ zeroinitializer, %entry.if.end375_crit_edge ], [ %80, %if.end197 ], !dbg !86
  %acc_o.sroa.22.0 = phi <4 x float> [ zeroinitializer, %entry.if.end375_crit_edge ], [ %81, %if.end197 ], !dbg !86
  %acc_o.sroa.32.0 = phi <4 x float> [ zeroinitializer, %entry.if.end375_crit_edge ], [ %82, %if.end197 ], !dbg !86
  %add403 = or disjoint i32 %mul402.pre-phi, %mul
  %83 = lshr i32 %1, 2
  %mul408 = and i32 %83, 252
  %add405 = add nuw nsw i32 %add403, %mul408
  %84 = zext nneg i32 %add405 to i64, !dbg !184
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0, !dbg !185
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1, !dbg !185
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2, !dbg !185
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3, !dbg !185
  %85 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !186
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !186, !noalias !190
  %86 = fptrunc float %acc_o.sroa.0.0.vec.extract to half, !dbg !186
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %85), !dbg !186, !noalias !190
  %87 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !195, !noalias !190
  %88 = fptrunc float %acc_o.sroa.0.4.vec.extract to half, !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %87), !dbg !195, !noalias !190
  %89 = bitcast half %86 to i16, !dbg !197
  %90 = bitcast half %88 to i16, !dbg !200
  %91 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !201
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !201, !noalias !205
  %92 = fptrunc float %acc_o.sroa.0.8.vec.extract to half, !dbg !201
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %91), !dbg !201, !noalias !205
  %93 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !210, !noalias !205
  %94 = fptrunc float %acc_o.sroa.0.12.vec.extract to half, !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %93), !dbg !210, !noalias !205
  %95 = bitcast half %92 to i16, !dbg !212
  %96 = bitcast half %94 to i16, !dbg !214
  %__2.sroa.6.0.insert.ext = zext i16 %96 to i64, !dbg !215
  %__2.sroa.6.0.insert.shift = shl nuw i64 %__2.sroa.6.0.insert.ext, 48, !dbg !215
  %__2.sroa.5.0.insert.ext = zext i16 %95 to i64, !dbg !215
  %__2.sroa.5.0.insert.shift = shl nuw nsw i64 %__2.sroa.5.0.insert.ext, 32, !dbg !215
  %__2.sroa.5.0.insert.insert = or disjoint i64 %__2.sroa.6.0.insert.shift, %__2.sroa.5.0.insert.shift, !dbg !215
  %__2.sroa.4.0.insert.ext = zext i16 %90 to i64, !dbg !215
  %__2.sroa.4.0.insert.shift = shl nuw nsw i64 %__2.sroa.4.0.insert.ext, 16, !dbg !215
  %__2.sroa.4.0.insert.insert = or disjoint i64 %__2.sroa.5.0.insert.insert, %__2.sroa.4.0.insert.shift, !dbg !215
  %__2.sroa.0.0.insert.ext = zext i16 %89 to i64, !dbg !215
  %__2.sroa.0.0.insert.insert = or disjoint i64 %__2.sroa.4.0.insert.insert, %__2.sroa.0.0.insert.ext, !dbg !215
  %add.ptr411 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %84, !dbg !216
  store i64 %__2.sroa.0.0.insert.insert, ptr addrspace(1) %add.ptr411, align 8, !dbg !217
  %acc_o.sroa.12.16.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 0, !dbg !185
  %acc_o.sroa.12.20.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 1, !dbg !185
  %acc_o.sroa.12.24.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 2, !dbg !185
  %acc_o.sroa.12.28.vec.extract = extractelement <4 x float> %acc_o.sroa.12.0, i64 3, !dbg !185
  %97 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !186
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !186, !noalias !190
  %98 = fptrunc float %acc_o.sroa.12.16.vec.extract to half, !dbg !186
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %97), !dbg !186, !noalias !190
  %99 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !195, !noalias !190
  %100 = fptrunc float %acc_o.sroa.12.20.vec.extract to half, !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %99), !dbg !195, !noalias !190
  %101 = bitcast half %98 to i16, !dbg !197
  %102 = bitcast half %100 to i16, !dbg !200
  %103 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !201
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !201, !noalias !205
  %104 = fptrunc float %acc_o.sroa.12.24.vec.extract to half, !dbg !201
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %103), !dbg !201, !noalias !205
  %105 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !210, !noalias !205
  %106 = fptrunc float %acc_o.sroa.12.28.vec.extract to half, !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %105), !dbg !210, !noalias !205
  %107 = bitcast half %104 to i16, !dbg !212
  %108 = bitcast half %106 to i16, !dbg !214
  %__2.sroa.6.0.insert.ext.1 = zext i16 %108 to i64, !dbg !215
  %__2.sroa.6.0.insert.shift.1 = shl nuw i64 %__2.sroa.6.0.insert.ext.1, 48, !dbg !215
  %__2.sroa.5.0.insert.ext.1 = zext i16 %107 to i64, !dbg !215
  %__2.sroa.5.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.1, 32, !dbg !215
  %__2.sroa.5.0.insert.insert.1 = or disjoint i64 %__2.sroa.6.0.insert.shift.1, %__2.sroa.5.0.insert.shift.1, !dbg !215
  %__2.sroa.4.0.insert.ext.1 = zext i16 %102 to i64, !dbg !215
  %__2.sroa.4.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.1, 16, !dbg !215
  %__2.sroa.4.0.insert.insert.1 = or disjoint i64 %__2.sroa.5.0.insert.insert.1, %__2.sroa.4.0.insert.shift.1, !dbg !215
  %__2.sroa.0.0.insert.ext.1 = zext i16 %101 to i64, !dbg !215
  %__2.sroa.0.0.insert.insert.1 = or disjoint i64 %__2.sroa.4.0.insert.insert.1, %__2.sroa.0.0.insert.ext.1, !dbg !215
  %109 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %84, !dbg !216
  %add.ptr411.1 = getelementptr inbounds i8, ptr addrspace(1) %109, i64 32, !dbg !216
  store i64 %__2.sroa.0.0.insert.insert.1, ptr addrspace(1) %add.ptr411.1, align 8, !dbg !217
  %acc_o.sroa.22.32.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 0, !dbg !185
  %acc_o.sroa.22.36.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 1, !dbg !185
  %acc_o.sroa.22.40.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 2, !dbg !185
  %acc_o.sroa.22.44.vec.extract = extractelement <4 x float> %acc_o.sroa.22.0, i64 3, !dbg !185
  %110 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !186
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !186, !noalias !190
  %111 = fptrunc float %acc_o.sroa.22.32.vec.extract to half, !dbg !186
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %110), !dbg !186, !noalias !190
  %112 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !195, !noalias !190
  %113 = fptrunc float %acc_o.sroa.22.36.vec.extract to half, !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %112), !dbg !195, !noalias !190
  %114 = bitcast half %111 to i16, !dbg !197
  %115 = bitcast half %113 to i16, !dbg !200
  %116 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !201
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !201, !noalias !205
  %117 = fptrunc float %acc_o.sroa.22.40.vec.extract to half, !dbg !201
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %116), !dbg !201, !noalias !205
  %118 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !210, !noalias !205
  %119 = fptrunc float %acc_o.sroa.22.44.vec.extract to half, !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %118), !dbg !210, !noalias !205
  %120 = bitcast half %117 to i16, !dbg !212
  %121 = bitcast half %119 to i16, !dbg !214
  %__2.sroa.6.0.insert.ext.2 = zext i16 %121 to i64, !dbg !215
  %__2.sroa.6.0.insert.shift.2 = shl nuw i64 %__2.sroa.6.0.insert.ext.2, 48, !dbg !215
  %__2.sroa.5.0.insert.ext.2 = zext i16 %120 to i64, !dbg !215
  %__2.sroa.5.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.2, 32, !dbg !215
  %__2.sroa.5.0.insert.insert.2 = or disjoint i64 %__2.sroa.6.0.insert.shift.2, %__2.sroa.5.0.insert.shift.2, !dbg !215
  %__2.sroa.4.0.insert.ext.2 = zext i16 %115 to i64, !dbg !215
  %__2.sroa.4.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.2, 16, !dbg !215
  %__2.sroa.4.0.insert.insert.2 = or disjoint i64 %__2.sroa.5.0.insert.insert.2, %__2.sroa.4.0.insert.shift.2, !dbg !215
  %__2.sroa.0.0.insert.ext.2 = zext i16 %114 to i64, !dbg !215
  %__2.sroa.0.0.insert.insert.2 = or disjoint i64 %__2.sroa.4.0.insert.insert.2, %__2.sroa.0.0.insert.ext.2, !dbg !215
  %122 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %84, !dbg !216
  %add.ptr411.2 = getelementptr inbounds i8, ptr addrspace(1) %122, i64 64, !dbg !216
  store i64 %__2.sroa.0.0.insert.insert.2, ptr addrspace(1) %add.ptr411.2, align 8, !dbg !217
  %acc_o.sroa.32.48.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 0, !dbg !185
  %acc_o.sroa.32.52.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 1, !dbg !185
  %acc_o.sroa.32.56.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 2, !dbg !185
  %acc_o.sroa.32.60.vec.extract = extractelement <4 x float> %acc_o.sroa.32.0, i64 3, !dbg !185
  %123 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !186
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !186, !noalias !190
  %124 = fptrunc float %acc_o.sroa.32.48.vec.extract to half, !dbg !186
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %123), !dbg !186, !noalias !190
  %125 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !195, !noalias !190
  %126 = fptrunc float %acc_o.sroa.32.52.vec.extract to half, !dbg !195
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %125), !dbg !195, !noalias !190
  %127 = bitcast half %124 to i16, !dbg !197
  %128 = bitcast half %126 to i16, !dbg !200
  %129 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !201
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !201, !noalias !205
  %130 = fptrunc float %acc_o.sroa.32.56.vec.extract to half, !dbg !201
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %129), !dbg !201, !noalias !205
  %131 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !210, !noalias !205
  %132 = fptrunc float %acc_o.sroa.32.60.vec.extract to half, !dbg !210
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %131), !dbg !210, !noalias !205
  %133 = bitcast half %130 to i16, !dbg !212
  %134 = bitcast half %132 to i16, !dbg !214
  %__2.sroa.6.0.insert.ext.3 = zext i16 %134 to i64, !dbg !215
  %__2.sroa.6.0.insert.shift.3 = shl nuw i64 %__2.sroa.6.0.insert.ext.3, 48, !dbg !215
  %__2.sroa.5.0.insert.ext.3 = zext i16 %133 to i64, !dbg !215
  %__2.sroa.5.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.3, 32, !dbg !215
  %__2.sroa.5.0.insert.insert.3 = or disjoint i64 %__2.sroa.6.0.insert.shift.3, %__2.sroa.5.0.insert.shift.3, !dbg !215
  %__2.sroa.4.0.insert.ext.3 = zext i16 %128 to i64, !dbg !215
  %__2.sroa.4.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.3, 16, !dbg !215
  %__2.sroa.4.0.insert.insert.3 = or disjoint i64 %__2.sroa.5.0.insert.insert.3, %__2.sroa.4.0.insert.shift.3, !dbg !215
  %__2.sroa.0.0.insert.ext.3 = zext i16 %127 to i64, !dbg !215
  %__2.sroa.0.0.insert.insert.3 = or disjoint i64 %__2.sroa.4.0.insert.insert.3, %__2.sroa.0.0.insert.ext.3, !dbg !215
  %135 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %84, !dbg !216
  %add.ptr411.3 = getelementptr inbounds i8, ptr addrspace(1) %135, i64 96, !dbg !216
  store i64 %__2.sroa.0.0.insert.insert.3, ptr addrspace(1) %add.ptr411.3, align 8, !dbg !217
  ret void, !dbg !218
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
!1 = !DIFile(filename: "/tmp/tmp7_8upr4j/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmp7_8upr4j/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 28, column: 25, scope: !40)
!44 = !DILocation(line: 34, column: 31, scope: !40)
!45 = !DILocation(line: 25, column: 3, scope: !40)
!46 = !DILocation(line: 26, column: 48, scope: !40)
!47 = !DILocation(line: 37, column: 5, scope: !40)
!48 = !DILocation(line: 40, column: 79, scope: !40)
!49 = !DILocation(line: 40, column: 58, scope: !40)
!50 = !DILocation(line: 40, column: 155, scope: !40)
!51 = !DILocation(line: 47, column: 79, scope: !40)
!52 = !DILocation(line: 47, column: 58, scope: !40)
!53 = !DILocation(line: 51, column: 5, scope: !40)
!54 = !DILocation(line: 52, column: 159, scope: !40)
!55 = !{i32 1, i32 3, i32 -1, i32 -1}
!56 = !DILocation(line: 52, column: 42, scope: !40)
!57 = !DILocation(line: 68, column: 3, scope: !58, inlinedAt: !60)
!58 = distinct !DISubprogram(name: "__barrier_warp", scope: !59, file: !59, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!59 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!60 = distinct !DILocation(line: 192, column: 3, scope: !61, inlinedAt: !62)
!61 = distinct !DISubprogram(name: "__syncwarp", scope: !59, file: !59, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!62 = distinct !DILocation(line: 54, column: 5, scope: !40)
!63 = !DILocation(line: 69, column: 3, scope: !58, inlinedAt: !60)
!64 = !DILocation(line: 70, column: 3, scope: !58, inlinedAt: !60)
!65 = !DILocation(line: 57, column: 153, scope: !40)
!66 = !DILocation(line: 57, column: 73, scope: !40)
!67 = !DILocation(line: 57, column: 36, scope: !40)
!68 = !DILocation(line: 57, column: 124, scope: !40)
!69 = !DILocation(line: 68, column: 3, scope: !58, inlinedAt: !70)
!70 = distinct !DILocation(line: 192, column: 3, scope: !61, inlinedAt: !71)
!71 = distinct !DILocation(line: 59, column: 5, scope: !40)
!72 = !DILocation(line: 69, column: 3, scope: !58, inlinedAt: !70)
!73 = !DILocation(line: 70, column: 3, scope: !58, inlinedAt: !70)
!74 = !DILocation(line: 62, column: 159, scope: !40)
!75 = !DILocation(line: 35, column: 43, scope: !40)
!76 = !DILocation(line: 64, column: 49, scope: !40)
!77 = !DILocation(line: 64, column: 27, scope: !40)
!78 = !DILocation(line: 64, column: 9, scope: !40)
!79 = !DILocation(line: 68, column: 77, scope: !40)
!80 = !DILocation(line: 68, column: 13, scope: !40)
!81 = !DILocation(line: 73, column: 20, scope: !40)
!82 = !DILocation(line: 68, column: 70, scope: !40)
!83 = !DILocation(line: 68, column: 3, scope: !58, inlinedAt: !84)
!84 = distinct !DILocation(line: 192, column: 3, scope: !61, inlinedAt: !85)
!85 = distinct !DILocation(line: 79, column: 5, scope: !40)
!86 = !DILocation(line: 0, scope: !40)
!87 = !DILocation(line: 69, column: 3, scope: !58, inlinedAt: !84)
!88 = !DILocation(line: 70, column: 3, scope: !58, inlinedAt: !84)
!89 = !DILocation(line: 81, column: 25, scope: !40)
!90 = !DILocation(line: 84, column: 36, scope: !40)
!91 = !DILocation(line: 68, column: 3, scope: !58, inlinedAt: !92)
!92 = distinct !DILocation(line: 192, column: 3, scope: !61, inlinedAt: !93)
!93 = distinct !DILocation(line: 90, column: 5, scope: !40)
!94 = !DILocation(line: 69, column: 3, scope: !58, inlinedAt: !92)
!95 = !DILocation(line: 70, column: 3, scope: !58, inlinedAt: !92)
!96 = !DILocation(line: 92, column: 10, scope: !40)
!97 = !DILocation(line: 93, column: 86, scope: !40)
!98 = !DILocation(line: 93, column: 42, scope: !40)
!99 = !DILocation(line: 97, column: 31, scope: !40)
!100 = !DILocation(line: 97, column: 42, scope: !40)
!101 = !DILocation(line: 354, column: 10, scope: !102, inlinedAt: !104)
!102 = distinct !DISubprogram(name: "min", scope: !103, file: !103, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!103 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!104 = distinct !DILocation(line: 97, column: 26, scope: !40)
!105 = !DILocation(line: 285, column: 49, scope: !106, inlinedAt: !107)
!106 = distinct !DISubprogram(name: "exp2f", scope: !103, file: !103, line: 285, type: !7, scopeLine: 285, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!107 = distinct !DILocation(line: 97, column: 20, scope: !40)
!108 = !DILocation(line: 102, column: 34, scope: !40)
!109 = !DILocation(line: 1018, column: 9, scope: !110, inlinedAt: !111)
!110 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !59, file: !59, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!111 = distinct !DILocation(line: 104, column: 34, scope: !40)
!112 = !DILocation(line: 171, column: 37, scope: !113, inlinedAt: !114)
!113 = distinct !DISubprogram(name: "__lane_id", scope: !59, file: !59, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!114 = distinct !DILocation(line: 990, column: 14, scope: !115, inlinedAt: !116)
!115 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !59, file: !59, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!116 = distinct !DILocation(line: 1019, column: 11, scope: !110, inlinedAt: !111)
!117 = !DILocation(line: 171, column: 10, scope: !113, inlinedAt: !114)
!118 = !DILocation(line: 991, column: 20, scope: !115, inlinedAt: !116)
!119 = !DILocation(line: 992, column: 36, scope: !115, inlinedAt: !116)
!120 = !DILocation(line: 992, column: 17, scope: !115, inlinedAt: !116)
!121 = !DILocation(line: 992, column: 11, scope: !115, inlinedAt: !116)
!122 = !DILocation(line: 993, column: 43, scope: !115, inlinedAt: !116)
!123 = !DILocation(line: 993, column: 10, scope: !115, inlinedAt: !116)
!124 = !DILocation(line: 1020, column: 14, scope: !110, inlinedAt: !111)
!125 = !DILocation(line: 104, column: 32, scope: !40)
!126 = !DILocation(line: 1018, column: 9, scope: !110, inlinedAt: !127)
!127 = distinct !DILocation(line: 105, column: 34, scope: !40)
!128 = !DILocation(line: 171, column: 37, scope: !113, inlinedAt: !129)
!129 = distinct !DILocation(line: 990, column: 14, scope: !115, inlinedAt: !130)
!130 = distinct !DILocation(line: 1019, column: 11, scope: !110, inlinedAt: !127)
!131 = !DILocation(line: 171, column: 10, scope: !113, inlinedAt: !129)
!132 = !DILocation(line: 991, column: 20, scope: !115, inlinedAt: !130)
!133 = !DILocation(line: 992, column: 36, scope: !115, inlinedAt: !130)
!134 = !DILocation(line: 992, column: 17, scope: !115, inlinedAt: !130)
!135 = !DILocation(line: 992, column: 11, scope: !115, inlinedAt: !130)
!136 = !DILocation(line: 993, column: 43, scope: !115, inlinedAt: !130)
!137 = !DILocation(line: 993, column: 10, scope: !115, inlinedAt: !130)
!138 = !DILocation(line: 1020, column: 14, scope: !110, inlinedAt: !127)
!139 = !DILocation(line: 105, column: 32, scope: !40)
!140 = !DILocation(line: 107, column: 34, scope: !40)
!141 = !DILocation(line: 107, column: 9, scope: !40)
!142 = !DILocation(line: 115, column: 32, scope: !40)
!143 = !DILocation(line: 1007, column: 10, scope: !144, inlinedAt: !146)
!144 = distinct !DISubprogram(name: "__float2half_rn", scope: !145, file: !145, line: 1005, type: !7, scopeLine: 1005, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!145 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!146 = distinct !DILocation(line: 1077, column: 18, scope: !147, inlinedAt: !148)
!147 = distinct !DISubprogram(name: "__floats2half2_rn", scope: !145, file: !145, line: 1075, type: !7, scopeLine: 1076, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!148 = distinct !DILocation(line: 1295, column: 23, scope: !149, inlinedAt: !150)
!149 = distinct !DISubprogram(name: "__float22half2_rn", scope: !145, file: !145, line: 1294, type: !7, scopeLine: 1294, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!150 = distinct !DILocation(line: 119, column: 27, scope: !40)
!151 = !{!152, !154}
!152 = distinct !{!152, !153, !"_ZL17__floats2half2_rnff: %agg.result"}
!153 = distinct !{!153, !"_ZL17__floats2half2_rnff"}
!154 = distinct !{!154, !155, !"_ZL17__float22half2_rn6float2: %agg.result"}
!155 = distinct !{!155, !"_ZL17__float22half2_rn6float2"}
!156 = !DILocation(line: 1007, column: 10, scope: !144, inlinedAt: !157)
!157 = distinct !DILocation(line: 1077, column: 38, scope: !147, inlinedAt: !148)
!158 = !DILocation(line: 593, column: 26, scope: !159, inlinedAt: !160)
!159 = distinct !DISubprogram(name: "operator=", scope: !145, file: !145, line: 592, type: !7, scopeLine: 592, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!160 = distinct !DILocation(line: 119, column: 25, scope: !40)
!161 = !DILocation(line: 1007, column: 10, scope: !144, inlinedAt: !162)
!162 = distinct !DILocation(line: 1077, column: 18, scope: !147, inlinedAt: !163)
!163 = distinct !DILocation(line: 1295, column: 23, scope: !149, inlinedAt: !164)
!164 = distinct !DILocation(line: 120, column: 27, scope: !40)
!165 = !{!166, !168}
!166 = distinct !{!166, !167, !"_ZL17__floats2half2_rnff: %agg.result"}
!167 = distinct !{!167, !"_ZL17__floats2half2_rnff"}
!168 = distinct !{!168, !169, !"_ZL17__float22half2_rn6float2: %agg.result"}
!169 = distinct !{!169, !"_ZL17__float22half2_rn6float2"}
!170 = !DILocation(line: 1007, column: 10, scope: !144, inlinedAt: !171)
!171 = distinct !DILocation(line: 1077, column: 38, scope: !147, inlinedAt: !163)
!172 = !DILocation(line: 593, column: 26, scope: !159, inlinedAt: !173)
!173 = distinct !DILocation(line: 120, column: 25, scope: !40)
!174 = !DILocation(line: 68, column: 3, scope: !58, inlinedAt: !175)
!175 = distinct !DILocation(line: 192, column: 3, scope: !61, inlinedAt: !176)
!176 = distinct !DILocation(line: 122, column: 5, scope: !40)
!177 = !DILocation(line: 69, column: 3, scope: !58, inlinedAt: !175)
!178 = !DILocation(line: 70, column: 3, scope: !58, inlinedAt: !175)
!179 = !DILocation(line: 125, column: 119, scope: !40)
!180 = !DILocation(line: 125, column: 31, scope: !40)
!181 = !DILocation(line: 125, column: 29, scope: !40)
!182 = !{!26, !26, i64 0}
!183 = !DILocation(line: 130, column: 38, scope: !40)
!184 = !DILocation(line: 137, column: 3, scope: !40)
!185 = !DILocation(line: 139, column: 19, scope: !40)
!186 = !DILocation(line: 1007, column: 10, scope: !144, inlinedAt: !187)
!187 = distinct !DILocation(line: 1077, column: 18, scope: !147, inlinedAt: !188)
!188 = distinct !DILocation(line: 1295, column: 23, scope: !149, inlinedAt: !189)
!189 = distinct !DILocation(line: 140, column: 27, scope: !40)
!190 = !{!191, !193}
!191 = distinct !{!191, !192, !"_ZL17__floats2half2_rnff: %agg.result"}
!192 = distinct !{!192, !"_ZL17__floats2half2_rnff"}
!193 = distinct !{!193, !194, !"_ZL17__float22half2_rn6float2: %agg.result"}
!194 = distinct !{!194, !"_ZL17__float22half2_rn6float2"}
!195 = !DILocation(line: 1007, column: 10, scope: !144, inlinedAt: !196)
!196 = distinct !DILocation(line: 1077, column: 38, scope: !147, inlinedAt: !188)
!197 = !DILocation(line: 596, column: 67, scope: !198, inlinedAt: !199)
!198 = distinct !DISubprogram(name: "__half2", scope: !145, file: !145, line: 596, type: !7, scopeLine: 596, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!199 = distinct !DILocation(line: 1077, column: 10, scope: !147, inlinedAt: !188)
!200 = !DILocation(line: 596, column: 73, scope: !198, inlinedAt: !199)
!201 = !DILocation(line: 1007, column: 10, scope: !144, inlinedAt: !202)
!202 = distinct !DILocation(line: 1077, column: 18, scope: !147, inlinedAt: !203)
!203 = distinct !DILocation(line: 1295, column: 23, scope: !149, inlinedAt: !204)
!204 = distinct !DILocation(line: 141, column: 27, scope: !40)
!205 = !{!206, !208}
!206 = distinct !{!206, !207, !"_ZL17__floats2half2_rnff: %agg.result"}
!207 = distinct !{!207, !"_ZL17__floats2half2_rnff"}
!208 = distinct !{!208, !209, !"_ZL17__float22half2_rn6float2: %agg.result"}
!209 = distinct !{!209, !"_ZL17__float22half2_rn6float2"}
!210 = !DILocation(line: 1007, column: 10, scope: !144, inlinedAt: !211)
!211 = distinct !DILocation(line: 1077, column: 38, scope: !147, inlinedAt: !203)
!212 = !DILocation(line: 596, column: 67, scope: !198, inlinedAt: !213)
!213 = distinct !DILocation(line: 1077, column: 10, scope: !147, inlinedAt: !203)
!214 = !DILocation(line: 596, column: 73, scope: !198, inlinedAt: !213)
!215 = !DILocation(line: 142, column: 38, scope: !40)
!216 = !DILocation(line: 143, column: 22, scope: !40)
!217 = !DILocation(line: 143, column: 140, scope: !40)
!218 = !DILocation(line: 145, column: 1, scope: !40)
