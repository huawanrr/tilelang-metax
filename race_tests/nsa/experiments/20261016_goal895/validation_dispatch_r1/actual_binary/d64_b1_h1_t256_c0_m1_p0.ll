; ModuleID = '/data/tilelang-metax/race_tests/nsa/experiments/20261016_goal895/validation_dispatch_r1/actual_binary/d64_b1_h1_t256_c0_m1_p0.bc'
source_filename = "/tmp/tmpgo7pn9ak/tvm_kernels.maca"
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
  %arrayidx14 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom, !dbg !45
  %4 = load i32, ptr addrspace(1) %arrayidx14, align 4, !dbg !45, !tbaa !30
  %cmp29 = icmp ult i32 %4, 16
  br i1 %cmp29, label %for.cond32.preheader, label %if.end297, !dbg !46

for.cond32.preheader:                             ; preds = %entry
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !47
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %2, !dbg !47
  %mul41 = shl nuw nsw i32 %4, 10
  %add43 = add nuw nsw i32 %mul41, %mul8
  %5 = zext nneg i32 %add43 to i64, !dbg !48
  %add.ptr50 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %5, !dbg !49
  %6 = load i32, ptr addrspace(4) %add.ptr50, align 4, !dbg !50, !tbaa !30
  %7 = or disjoint i64 %5, 2, !dbg !51
  %add.ptr50.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %7, !dbg !49
  %8 = load i32, ptr addrspace(4) %add.ptr50.1, align 4, !dbg !50, !tbaa !30
  %9 = or disjoint i64 %5, 4, !dbg !51
  %add.ptr50.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %9, !dbg !49
  %10 = load i32, ptr addrspace(4) %add.ptr50.2, align 4, !dbg !50, !tbaa !30
  %11 = or disjoint i64 %5, 6, !dbg !51
  %add.ptr50.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %11, !dbg !49
  %12 = load i32, ptr addrspace(4) %add.ptr50.3, align 4, !dbg !50, !tbaa !30
  %13 = add nuw nsw i64 %5, 512
  %add.ptr50.1602 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %13, !dbg !49
  %14 = load i32, ptr addrspace(4) %add.ptr50.1602, align 4, !dbg !50, !tbaa !30
  %15 = add nuw nsw i64 %5, 514, !dbg !51
  %add.ptr50.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %15, !dbg !49
  %16 = load i32, ptr addrspace(4) %add.ptr50.1.1, align 4, !dbg !50, !tbaa !30
  %17 = add nuw nsw i64 %5, 516, !dbg !51
  %add.ptr50.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %17, !dbg !49
  %18 = load i32, ptr addrspace(4) %add.ptr50.2.1, align 4, !dbg !50, !tbaa !30
  %19 = add nuw nsw i64 %5, 518, !dbg !51
  %add.ptr50.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %19, !dbg !49
  %20 = load i32, ptr addrspace(4) %add.ptr50.3.1, align 4, !dbg !50, !tbaa !30
  %add.ptr80 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %5, !dbg !52
  %21 = load i32, ptr addrspace(4) %add.ptr80, align 4, !dbg !53, !tbaa !30
  %add.ptr80.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %7, !dbg !52
  %22 = load i32, ptr addrspace(4) %add.ptr80.1, align 4, !dbg !53, !tbaa !30
  %add.ptr80.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %9, !dbg !52
  %23 = load i32, ptr addrspace(4) %add.ptr80.2, align 4, !dbg !53, !tbaa !30
  %add.ptr80.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %11, !dbg !52
  %24 = load i32, ptr addrspace(4) %add.ptr80.3, align 4, !dbg !53, !tbaa !30
  %add.ptr80.1614 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %13, !dbg !52
  %25 = load i32, ptr addrspace(4) %add.ptr80.1614, align 4, !dbg !53, !tbaa !30
  %add.ptr80.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %15, !dbg !52
  %26 = load i32, ptr addrspace(4) %add.ptr80.1.1, align 4, !dbg !53, !tbaa !30
  %add.ptr80.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %17, !dbg !52
  %27 = load i32, ptr addrspace(4) %add.ptr80.2.1, align 4, !dbg !53, !tbaa !30
  %add.ptr80.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %19, !dbg !52
  %28 = load i32, ptr addrspace(4) %add.ptr80.3.1, align 4, !dbg !53, !tbaa !30
  %mul103 = and i32 %mul8, 8128
  %xor545 = and i32 %mul8, 56
  %call106.masked = and i32 %1, 1016
  %mul108 = xor i32 %xor545, %call106.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul103, !dbg !54
  %invariant.gep555 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul108, !dbg !54
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep555, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !dbg !55, !call_argsrelate !56
  %gep556.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep555, i32 1024, !dbg !57
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep556.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !dbg !55, !call_argsrelate !56
  fence syncscope("warp") release, !dbg !58
  tail call void @llvm.mxc.barrier.warp(), !dbg !64
  fence syncscope("warp") acquire, !dbg !65
  %and120 = shl nuw nsw i32 %1, 6
  %mul121 = and i32 %and120, 960
  %shr124 = lshr i32 %1, 4
  %and127 = and i32 %1, 7
  %29 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul121
  %xor128 = xor i32 %shr124, %and127, !dbg !66
  %add.ptr132.idx = shl nuw nsw i32 %xor128, 4, !dbg !67
  %add.ptr132 = getelementptr inbounds i8, ptr addrspace(3) %29, i32 %add.ptr132.idx, !dbg !67
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr132, align 16, !dbg !68
  %Q_reg.sroa.4.0.add.ptr132.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr132, i32 8, !dbg !68
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr132.sroa_idx, align 8, !dbg !68
  %add125.1 = add nuw nsw i32 %shr124, 4, !dbg !69
  %xor128.1 = xor i32 %add125.1, %and127, !dbg !66
  %add.ptr132.idx.1 = shl nuw nsw i32 %xor128.1, 4, !dbg !67
  %add.ptr132.1 = getelementptr inbounds i8, ptr addrspace(3) %29, i32 %add.ptr132.idx.1, !dbg !67
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr132.1, align 16, !dbg !68
  %Q_reg.sroa.7.16.add.ptr132.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr132.1, i32 8, !dbg !68
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr132.1.sroa_idx, align 8, !dbg !68
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
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr132, align 16, !dbg !81
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr132.sroa_idx, align 8, !dbg !81
  %30 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !82
  %31 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %30), !dbg !82
  %kb.sroa.0.0.copyload644 = load <4 x half>, ptr addrspace(3) %add.ptr132.1, align 16, !dbg !81
  %kb.sroa.6.0.copyload645 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr132.1.sroa_idx, align 8, !dbg !81
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload644, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %31), !dbg !82
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload645, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %32), !dbg !82
  fence syncscope("warp") release, !dbg !83
  tail call void @llvm.mxc.barrier.warp(), !dbg !86
  fence syncscope("warp") acquire, !dbg !87
  %add.ptr224.idx = shl nuw nsw i32 %1, 4
  %invariant.gep568 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr224.idx, !dbg !88
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
  %mul234 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !92
  %34 = tail call contract noundef float @llvm.minnum.f32(float %mul234, float 0x4024CB5EC0000000), !dbg !93
  %35 = tail call contract noundef float @llvm.exp.f32(float %34), !dbg !97
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %33, i64 1, !dbg !91
  %mul234.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !92
  %36 = tail call contract noundef float @llvm.minnum.f32(float %mul234.1, float 0x4024CB5EC0000000), !dbg !93
  %37 = tail call contract noundef float @llvm.exp.f32(float %36), !dbg !97
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %33, i64 2, !dbg !91
  %mul234.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !92
  %38 = tail call contract noundef float @llvm.minnum.f32(float %mul234.2, float 0x4024CB5EC0000000), !dbg !93
  %39 = tail call contract noundef float @llvm.exp.f32(float %38), !dbg !97
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %33, i64 3, !dbg !91
  %mul234.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !92
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul234.3, float 0x4024CB5EC0000000), !dbg !93
  %41 = tail call contract noundef float @llvm.exp.f32(float %40), !dbg !97
  %add250.1 = fadd contract float %35, %37, !dbg !100
  %add250.2 = fadd contract float %add250.1, %39, !dbg !100
  %add250.3 = fadd contract float %add250.2, %41, !dbg !100
  %42 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add250.3, <4 x float> zeroinitializer), !dbg !101
  %wsum_output.sroa.0.0.vec.extract = extractelement <4 x float> %42, i64 0, !dbg !102
  %cmp268 = fcmp contract ogt float %wsum_output.sroa.0.0.vec.extract, 0.000000e+00, !dbg !103
  %div = fdiv contract float 1.000000e+00, %wsum_output.sroa.0.0.vec.extract, !dbg !104
  %condval.0 = select i1 %cmp268, float %div, float 0.000000e+00, !dbg !104
  %mul279 = fmul contract float %condval.0, %35, !dbg !105
  %mul279.1 = fmul contract float %condval.0, %37, !dbg !105
  %mul279.2 = fmul contract float %condval.0, %39, !dbg !105
  %mul279.3 = fmul contract float %condval.0, %41, !dbg !105
  %43 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul279), !dbg !106
  %44 = insertelement <4 x i16> poison, i16 %43, i64 0, !dbg !115
  %45 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul279.1), !dbg !106
  %46 = insertelement <4 x i16> %44, i16 %45, i64 1, !dbg !115
  %47 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul279.2), !dbg !106
  %48 = insertelement <4 x i16> %46, i16 %47, i64 2, !dbg !115
  %49 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul279.3), !dbg !106
  %50 = insertelement <4 x i16> %48, i16 %49, i64 3, !dbg !115
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %50 to <4 x half>, !dbg !115
  fence syncscope("warp") release, !dbg !116
  tail call void @llvm.mxc.barrier.warp(), !dbg !119
  fence syncscope("warp") acquire, !dbg !120
  br label %if.end297, !dbg !121

if.end297:                                        ; preds = %for.cond32.preheader, %entry
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ %acc_s_cast.sroa.0.6.vec.insert, %for.cond32.preheader ], [ undef, %entry ]
  br i1 %cmp29, label %for.cond315.preheader, label %if.end363, !dbg !122

for.cond315.preheader:                            ; preds = %if.end297
  %51 = shl nuw nsw i32 %1, 4
  %mul325 = and i32 %51, 16128
  %and331 = and i32 %1, 15
  %add332 = or disjoint i32 %mul325, %and331, !dbg !123
  %arrayidx334 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add332, !dbg !124
  %52 = load half, ptr addrspace(3) %arrayidx334, align 2, !dbg !125, !tbaa !126
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %52, i64 0, !dbg !125
  %add327.1 = or disjoint i32 %mul325, %and331, !dbg !123
  %add332.1 = or disjoint i32 %add327.1, 64, !dbg !123
  %arrayidx334.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add332.1, !dbg !124
  %53 = load half, ptr addrspace(3) %arrayidx334.1, align 2, !dbg !125, !tbaa !126
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %53, i64 1, !dbg !125
  %add327.2 = or disjoint i32 %mul325, %and331, !dbg !123
  %add332.2 = or disjoint i32 %add327.2, 128, !dbg !123
  %arrayidx334.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add332.2, !dbg !124
  %54 = load half, ptr addrspace(3) %arrayidx334.2, align 2, !dbg !125, !tbaa !126
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %54, i64 2, !dbg !125
  %add327.3 = or disjoint i32 %mul325, %and331, !dbg !123
  %add332.3 = or disjoint i32 %add327.3, 192, !dbg !123
  %arrayidx334.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add332.3, !dbg !124
  %55 = load half, ptr addrspace(3) %arrayidx334.3, align 2, !dbg !125, !tbaa !126
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %55, i64 3, !dbg !125
  %add329.1618 = or disjoint i32 %mul325, %and331, !dbg !123
  %add332.1619 = or disjoint i32 %add329.1618, 16, !dbg !123
  %arrayidx334.1620 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add332.1619, !dbg !124
  %56 = load half, ptr addrspace(3) %arrayidx334.1620, align 2, !dbg !125, !tbaa !126
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %56, i64 0, !dbg !125
  %add329.1.1 = or disjoint i32 %mul325, %and331, !dbg !123
  %add332.1.1 = or disjoint i32 %add329.1.1, 80, !dbg !123
  %arrayidx334.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add332.1.1, !dbg !124
  %57 = load half, ptr addrspace(3) %arrayidx334.1.1, align 2, !dbg !125, !tbaa !126
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %57, i64 1, !dbg !125
  %add329.2.1 = or disjoint i32 %mul325, %and331, !dbg !123
  %add332.2.1 = or disjoint i32 %add329.2.1, 144, !dbg !123
  %arrayidx334.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add332.2.1, !dbg !124
  %58 = load half, ptr addrspace(3) %arrayidx334.2.1, align 2, !dbg !125, !tbaa !126
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %58, i64 2, !dbg !125
  %add329.3.1 = or disjoint i32 %mul325, %and331, !dbg !123
  %add332.3.1 = or disjoint i32 %add329.3.1, 208, !dbg !123
  %arrayidx334.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add332.3.1, !dbg !124
  %59 = load half, ptr addrspace(3) %arrayidx334.3.1, align 2, !dbg !125, !tbaa !126
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %59, i64 3, !dbg !125
  %add329.2622 = or disjoint i32 %mul325, %and331, !dbg !123
  %add332.2623 = or disjoint i32 %add329.2622, 32, !dbg !123
  %arrayidx334.2624 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add332.2623, !dbg !124
  %60 = load half, ptr addrspace(3) %arrayidx334.2624, align 2, !dbg !125, !tbaa !126
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %60, i64 0, !dbg !125
  %add329.1.2 = or disjoint i32 %mul325, %and331, !dbg !123
  %add332.1.2 = or disjoint i32 %add329.1.2, 96, !dbg !123
  %arrayidx334.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add332.1.2, !dbg !124
  %61 = load half, ptr addrspace(3) %arrayidx334.1.2, align 2, !dbg !125, !tbaa !126
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %61, i64 1, !dbg !125
  %add329.2.2 = or disjoint i32 %mul325, %and331, !dbg !123
  %add332.2.2 = or disjoint i32 %add329.2.2, 160, !dbg !123
  %arrayidx334.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add332.2.2, !dbg !124
  %62 = load half, ptr addrspace(3) %arrayidx334.2.2, align 2, !dbg !125, !tbaa !126
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %62, i64 2, !dbg !125
  %add329.3.2 = or disjoint i32 %mul325, %and331, !dbg !123
  %add332.3.2 = or disjoint i32 %add329.3.2, 224, !dbg !123
  %arrayidx334.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add332.3.2, !dbg !124
  %63 = load half, ptr addrspace(3) %arrayidx334.3.2, align 2, !dbg !125, !tbaa !126
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %63, i64 3, !dbg !125
  %add329.3626 = or disjoint i32 %mul325, %and331, !dbg !123
  %add332.3627 = or disjoint i32 %add329.3626, 48, !dbg !123
  %arrayidx334.3628 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add332.3627, !dbg !124
  %64 = load half, ptr addrspace(3) %arrayidx334.3628, align 2, !dbg !125, !tbaa !126
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %64, i64 0, !dbg !125
  %add329.1.3 = or disjoint i32 %mul325, %and331, !dbg !123
  %add332.1.3 = or disjoint i32 %add329.1.3, 112, !dbg !123
  %arrayidx334.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add332.1.3, !dbg !124
  %65 = load half, ptr addrspace(3) %arrayidx334.1.3, align 2, !dbg !125, !tbaa !126
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %65, i64 1, !dbg !125
  %add329.2.3 = or disjoint i32 %mul325, %and331, !dbg !123
  %add332.2.3 = or disjoint i32 %add329.2.3, 176, !dbg !123
  %arrayidx334.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add332.2.3, !dbg !124
  %66 = load half, ptr addrspace(3) %arrayidx334.2.3, align 2, !dbg !125, !tbaa !126
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %66, i64 2, !dbg !125
  %add329.3.3 = or disjoint i32 %51, %and331, !dbg !123
  %add332.3.3 = or i32 %add329.3.3, 240, !dbg !123
  %arrayidx334.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add332.3.3, !dbg !124
  %67 = load half, ptr addrspace(3) %arrayidx334.3.3, align 2, !dbg !125, !tbaa !126
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %67, i64 3, !dbg !125
  %68 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !127
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !127
  %70 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !127
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !127
  br label %if.end363, !dbg !128

if.end363:                                        ; preds = %for.cond315.preheader, %if.end297
  %acc_o.sroa.0.0 = phi <4 x float> [ %68, %for.cond315.preheader ], [ zeroinitializer, %if.end297 ], !dbg !129
  %acc_o.sroa.16.0 = phi <4 x float> [ %69, %for.cond315.preheader ], [ zeroinitializer, %if.end297 ], !dbg !129
  %acc_o.sroa.30.0 = phi <4 x float> [ %70, %for.cond315.preheader ], [ zeroinitializer, %if.end297 ], !dbg !129
  %acc_o.sroa.44.0 = phi <4 x float> [ %71, %for.cond315.preheader ], [ zeroinitializer, %if.end297 ], !dbg !129
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0, !dbg !130
  %72 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract), !dbg !131
  %O_reg.sroa.0.0.insert.ext = zext i16 %72 to i64, !dbg !135
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1, !dbg !130
  %73 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract), !dbg !131
  %O_reg.sroa.0.2.insert.ext = zext i16 %73 to i64, !dbg !135
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !135
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !135
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2, !dbg !130
  %74 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract), !dbg !131
  %O_reg.sroa.0.4.insert.ext = zext i16 %74 to i64, !dbg !135
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !135
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !135
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3, !dbg !130
  %75 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract), !dbg !131
  %O_reg.sroa.0.6.insert.ext = zext i16 %75 to i64, !dbg !135
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !135
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !135
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0, !dbg !130
  %76 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract), !dbg !131
  %O_reg.sroa.7.8.insert.ext = zext i16 %76 to i64, !dbg !135
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1, !dbg !130
  %77 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract), !dbg !131
  %O_reg.sroa.7.10.insert.ext = zext i16 %77 to i64, !dbg !135
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !135
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !135
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2, !dbg !130
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract), !dbg !131
  %O_reg.sroa.7.12.insert.ext = zext i16 %78 to i64, !dbg !135
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !135
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !135
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3, !dbg !130
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract), !dbg !131
  %O_reg.sroa.7.14.insert.ext = zext i16 %79 to i64, !dbg !135
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !135
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !135
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0, !dbg !130
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract), !dbg !131
  %O_reg.sroa.12.16.insert.ext = zext i16 %80 to i64, !dbg !135
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1, !dbg !130
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract), !dbg !131
  %O_reg.sroa.12.18.insert.ext = zext i16 %81 to i64, !dbg !135
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !135
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !135
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2, !dbg !130
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract), !dbg !131
  %O_reg.sroa.12.20.insert.ext = zext i16 %82 to i64, !dbg !135
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !135
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !135
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3, !dbg !130
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract), !dbg !131
  %O_reg.sroa.12.22.insert.ext = zext i16 %83 to i64, !dbg !135
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !135
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !135
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0, !dbg !130
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract), !dbg !131
  %O_reg.sroa.17.24.insert.ext = zext i16 %84 to i64, !dbg !135
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1, !dbg !130
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract), !dbg !131
  %O_reg.sroa.17.26.insert.ext = zext i16 %85 to i64, !dbg !135
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !135
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !135
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2, !dbg !130
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract), !dbg !131
  %O_reg.sroa.17.28.insert.ext = zext i16 %86 to i64, !dbg !135
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !135
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !135
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3, !dbg !130
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract), !dbg !131
  %O_reg.sroa.17.30.insert.ext = zext i16 %87 to i64, !dbg !135
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !135
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !135
  fence syncscope("warp") release, !dbg !136
  tail call void @llvm.mxc.barrier.warp(), !dbg !139
  fence syncscope("warp") acquire, !dbg !140
  %and396 = shl nuw nsw i32 %1, 6
  %mul397 = and i32 %and396, 960
  %shr400 = lshr i32 %1, 5
  %and403 = and i32 %1, 7
  %88 = lshr i32 %1, 2
  %mul410 = and i32 %88, 4
  %xor404 = xor i32 %shr400, %and403, !dbg !141
  %mul405 = shl nuw nsw i32 %xor404, 3, !dbg !142
  %add406 = add nuw nsw i32 %mul405, %mul397, !dbg !143
  %add411 = or disjoint i32 %add406, %mul410, !dbg !144
  %add.ptr413 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411, !dbg !145
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr413, align 8, !dbg !146
  %add401.1 = add nuw nsw i32 %shr400, 2, !dbg !147
  %xor404.1 = xor i32 %add401.1, %and403, !dbg !141
  %mul405.1 = shl nuw nsw i32 %xor404.1, 3, !dbg !142
  %add406.1 = add nuw nsw i32 %mul405.1, %mul397, !dbg !143
  %add411.1 = or disjoint i32 %add406.1, %mul410, !dbg !144
  %add.ptr413.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.1, !dbg !145
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr413.1, align 8, !dbg !146
  %add401.2 = add nuw nsw i32 %shr400, 4, !dbg !147
  %xor404.2 = xor i32 %add401.2, %and403, !dbg !141
  %mul405.2 = shl nuw nsw i32 %xor404.2, 3, !dbg !142
  %add406.2 = add nuw nsw i32 %mul405.2, %mul397, !dbg !143
  %add411.2 = or disjoint i32 %add406.2, %mul410, !dbg !144
  %add.ptr413.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.2, !dbg !145
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr413.2, align 8, !dbg !146
  %add401.3 = add nuw nsw i32 %shr400, 6, !dbg !147
  %xor404.3 = xor i32 %add401.3, %and403, !dbg !141
  %mul405.3 = shl nuw nsw i32 %xor404.3, 3, !dbg !142
  %add406.3 = add nuw nsw i32 %mul405.3, %mul397, !dbg !143
  %add411.3 = or disjoint i32 %add406.3, %mul410, !dbg !144
  %add.ptr413.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add411.3, !dbg !145
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr413.3, align 8, !dbg !146
  fence syncscope("warp") release, !dbg !148
  tail call void @llvm.mxc.barrier.warp(), !dbg !151
  fence syncscope("warp") acquire, !dbg !152
  %mul424 = and i32 %mul8, 8128
  %xor430541 = and i32 %mul8, 56
  %call428.masked = and i32 %1, 1016
  %mul431 = xor i32 %xor430541, %call428.masked
  %invariant.gep582 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul424, !dbg !153
  %invariant.gep584 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep582, i32 %mul431, !dbg !153
  %add.ptr443 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %2, !dbg !154
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr443, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep584, i64 16, i1 false), !dbg !155, !tbaa.struct !156, !call_argsrelate !157
  %gep585.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep584, i32 1024, !dbg !158
  %add.ptr443.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3, !dbg !154
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr443.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep585.1, i64 16, i1 false), !dbg !155, !tbaa.struct !156, !call_argsrelate !157
  ret void, !dbg !159
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
!1 = !DIFile(filename: "/tmp/tmpgo7pn9ak/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpgo7pn9ak/tvm_kernels.maca", directory: "")
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
!55 = !DILocation(line: 55, column: 159, scope: !40)
!56 = !{i32 1, i32 3, i32 -1, i32 -1}
!57 = !DILocation(line: 55, column: 42, scope: !40)
!58 = !DILocation(line: 68, column: 3, scope: !59, inlinedAt: !61)
!59 = distinct !DISubprogram(name: "__barrier_warp", scope: !60, file: !60, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!60 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!61 = distinct !DILocation(line: 192, column: 3, scope: !62, inlinedAt: !63)
!62 = distinct !DISubprogram(name: "__syncwarp", scope: !60, file: !60, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!63 = distinct !DILocation(line: 57, column: 5, scope: !40)
!64 = !DILocation(line: 69, column: 3, scope: !59, inlinedAt: !61)
!65 = !DILocation(line: 70, column: 3, scope: !59, inlinedAt: !61)
!66 = !DILocation(line: 60, column: 153, scope: !40)
!67 = !DILocation(line: 60, column: 73, scope: !40)
!68 = !DILocation(line: 60, column: 36, scope: !40)
!69 = !DILocation(line: 60, column: 124, scope: !40)
!70 = !DILocation(line: 68, column: 3, scope: !59, inlinedAt: !71)
!71 = distinct !DILocation(line: 192, column: 3, scope: !62, inlinedAt: !72)
!72 = distinct !DILocation(line: 62, column: 5, scope: !40)
!73 = !DILocation(line: 69, column: 3, scope: !59, inlinedAt: !71)
!74 = !DILocation(line: 70, column: 3, scope: !59, inlinedAt: !71)
!75 = !DILocation(line: 65, column: 159, scope: !40)
!76 = !DILocation(line: 68, column: 3, scope: !59, inlinedAt: !77)
!77 = distinct !DILocation(line: 192, column: 3, scope: !62, inlinedAt: !78)
!78 = distinct !DILocation(line: 69, column: 5, scope: !40)
!79 = !DILocation(line: 69, column: 3, scope: !59, inlinedAt: !77)
!80 = !DILocation(line: 70, column: 3, scope: !59, inlinedAt: !77)
!81 = !DILocation(line: 71, column: 25, scope: !40)
!82 = !DILocation(line: 74, column: 36, scope: !40)
!83 = !DILocation(line: 68, column: 3, scope: !59, inlinedAt: !84)
!84 = distinct !DILocation(line: 192, column: 3, scope: !62, inlinedAt: !85)
!85 = distinct !DILocation(line: 80, column: 5, scope: !40)
!86 = !DILocation(line: 69, column: 3, scope: !59, inlinedAt: !84)
!87 = !DILocation(line: 70, column: 3, scope: !59, inlinedAt: !84)
!88 = !DILocation(line: 82, column: 10, scope: !40)
!89 = !DILocation(line: 83, column: 86, scope: !40)
!90 = !DILocation(line: 83, column: 42, scope: !40)
!91 = !DILocation(line: 87, column: 30, scope: !40)
!92 = !DILocation(line: 87, column: 41, scope: !40)
!93 = !DILocation(line: 354, column: 10, scope: !94, inlinedAt: !96)
!94 = distinct !DISubprogram(name: "min", scope: !95, file: !95, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!95 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!96 = distinct !DILocation(line: 87, column: 25, scope: !40)
!97 = !DILocation(line: 288, column: 10, scope: !98, inlinedAt: !99)
!98 = distinct !DISubprogram(name: "expf", scope: !95, file: !95, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!99 = distinct !DILocation(line: 87, column: 20, scope: !40)
!100 = !DILocation(line: 92, column: 34, scope: !40)
!101 = !DILocation(line: 97, column: 42, scope: !40)
!102 = !DILocation(line: 102, column: 36, scope: !40)
!103 = !DILocation(line: 102, column: 34, scope: !40)
!104 = !DILocation(line: 102, column: 9, scope: !40)
!105 = !DILocation(line: 110, column: 32, scope: !40)
!106 = !DILocation(line: 75, column: 10, scope: !107, inlinedAt: !109)
!107 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !108, file: !108, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!108 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!109 = distinct !DILocation(line: 984, column: 9, scope: !110, inlinedAt: !112)
!110 = distinct !DISubprogram(name: "__float2half", scope: !111, file: !111, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!111 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!112 = distinct !DILocation(line: 133, column: 53, scope: !113, inlinedAt: !114)
!113 = distinct !DISubprogram(name: "__half", scope: !111, file: !111, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!114 = distinct !DILocation(line: 114, column: 32, scope: !40)
!115 = !DILocation(line: 114, column: 29, scope: !40)
!116 = !DILocation(line: 68, column: 3, scope: !59, inlinedAt: !117)
!117 = distinct !DILocation(line: 192, column: 3, scope: !62, inlinedAt: !118)
!118 = distinct !DILocation(line: 116, column: 5, scope: !40)
!119 = !DILocation(line: 69, column: 3, scope: !59, inlinedAt: !117)
!120 = !DILocation(line: 70, column: 3, scope: !59, inlinedAt: !117)
!121 = !DILocation(line: 117, column: 3, scope: !40)
!122 = !DILocation(line: 123, column: 30, scope: !40)
!123 = !DILocation(line: 126, column: 119, scope: !40)
!124 = !DILocation(line: 126, column: 31, scope: !40)
!125 = !DILocation(line: 126, column: 29, scope: !40)
!126 = !{!26, !26, i64 0}
!127 = !DILocation(line: 131, column: 38, scope: !40)
!128 = !DILocation(line: 138, column: 3, scope: !40)
!129 = !DILocation(line: 0, scope: !40)
!130 = !DILocation(line: 141, column: 58, scope: !40)
!131 = !DILocation(line: 75, column: 10, scope: !107, inlinedAt: !132)
!132 = distinct !DILocation(line: 984, column: 9, scope: !110, inlinedAt: !133)
!133 = distinct !DILocation(line: 133, column: 53, scope: !113, inlinedAt: !134)
!134 = distinct !DILocation(line: 141, column: 50, scope: !40)
!135 = !DILocation(line: 141, column: 47, scope: !40)
!136 = !DILocation(line: 68, column: 3, scope: !59, inlinedAt: !137)
!137 = distinct !DILocation(line: 192, column: 3, scope: !62, inlinedAt: !138)
!138 = distinct !DILocation(line: 144, column: 3, scope: !40)
!139 = !DILocation(line: 69, column: 3, scope: !59, inlinedAt: !137)
!140 = !DILocation(line: 70, column: 3, scope: !59, inlinedAt: !137)
!141 = !DILocation(line: 147, column: 121, scope: !40)
!142 = !DILocation(line: 147, column: 149, scope: !40)
!143 = !DILocation(line: 147, column: 77, scope: !40)
!144 = !DILocation(line: 147, column: 155, scope: !40)
!145 = !DILocation(line: 147, column: 40, scope: !40)
!146 = !DILocation(line: 147, column: 198, scope: !40)
!147 = !DILocation(line: 147, column: 92, scope: !40)
!148 = !DILocation(line: 68, column: 3, scope: !59, inlinedAt: !149)
!149 = distinct !DILocation(line: 192, column: 3, scope: !62, inlinedAt: !150)
!150 = distinct !DILocation(line: 149, column: 3, scope: !40)
!151 = !DILocation(line: 69, column: 3, scope: !59, inlinedAt: !149)
!152 = !DILocation(line: 70, column: 3, scope: !59, inlinedAt: !149)
!153 = !DILocation(line: 151, column: 8, scope: !40)
!154 = !DILocation(line: 152, column: 22, scope: !40)
!155 = !DILocation(line: 152, column: 98, scope: !40)
!156 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!157 = !{i32 2, i32 -1, i32 -1, i32 -1}
!158 = !DILocation(line: 152, column: 135, scope: !40)
!159 = !DILocation(line: 154, column: 1, scope: !40)
