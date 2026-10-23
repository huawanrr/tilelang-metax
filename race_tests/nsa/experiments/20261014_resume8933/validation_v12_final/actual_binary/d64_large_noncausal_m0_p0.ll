; ModuleID = '/data/tilelang-metax/race_tests/nsa/experiments/20261014_resume8933/validation_v12_final/actual_binary/d64_large_noncausal_m0_p0.bc'
source_filename = "/tmp/tmpazckvryo/tvm_kernels.maca"
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
  %mul = shl nsw i32 %0, 20
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul7 = shl nsw i32 %1, 10
  %add = add nuw nsw i32 %mul, %mul7
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %mul11 = shl nuw nsw i32 %2, 3
  %add9 = add nuw nsw i32 %add, %mul11
  %3 = zext nneg i32 %add9 to i64, !dbg !43
  %4 = add nuw nsw i64 %3, 512, !dbg !44
  %mul17 = shl nsw i32 %0, 10, !dbg !45
  %add19 = add nuw nsw i32 %mul17, %1, !dbg !46
  %idxprom = zext nneg i32 %add19 to i64, !dbg !47
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom, !dbg !47
  %5 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !47, !tbaa !30
  %cmp34 = icmp ult i32 %5, 64
  br i1 %cmp34, label %for.cond37.preheader, label %if.end331, !dbg !48

for.cond37.preheader:                             ; preds = %entry
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4, !dbg !49
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !49
  %mul47 = shl nsw i32 %0, 16
  %mul48 = shl nuw nsw i32 %5, 10
  %add49 = or disjoint i32 %mul11, %mul47
  %add51 = add nuw nsw i32 %add49, %mul48
  %6 = zext nneg i32 %add51 to i64, !dbg !50
  %add.ptr58 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %6, !dbg !51
  %7 = load i32, ptr addrspace(4) %add.ptr58, align 4, !dbg !52, !tbaa !30
  %8 = or disjoint i64 %6, 2, !dbg !53
  %add.ptr58.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %8, !dbg !51
  %9 = load i32, ptr addrspace(4) %add.ptr58.1, align 4, !dbg !52, !tbaa !30
  %10 = or disjoint i64 %6, 4, !dbg !53
  %add.ptr58.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %10, !dbg !51
  %11 = load i32, ptr addrspace(4) %add.ptr58.2, align 4, !dbg !52, !tbaa !30
  %12 = or disjoint i64 %6, 6, !dbg !53
  %add.ptr58.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %12, !dbg !51
  %13 = load i32, ptr addrspace(4) %add.ptr58.3, align 4, !dbg !52, !tbaa !30
  %14 = add nuw nsw i64 %6, 512
  %add.ptr58.1647 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %14, !dbg !51
  %15 = load i32, ptr addrspace(4) %add.ptr58.1647, align 4, !dbg !52, !tbaa !30
  %16 = add nuw nsw i64 %6, 514, !dbg !53
  %add.ptr58.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %16, !dbg !51
  %17 = load i32, ptr addrspace(4) %add.ptr58.1.1, align 4, !dbg !52, !tbaa !30
  %18 = add nuw nsw i64 %6, 516, !dbg !53
  %add.ptr58.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %18, !dbg !51
  %19 = load i32, ptr addrspace(4) %add.ptr58.2.1, align 4, !dbg !52, !tbaa !30
  %20 = add nuw nsw i64 %6, 518, !dbg !53
  %add.ptr58.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %20, !dbg !51
  %21 = load i32, ptr addrspace(4) %add.ptr58.3.1, align 4, !dbg !52, !tbaa !30
  %add.ptr91 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %6, !dbg !54
  %22 = load i32, ptr addrspace(4) %add.ptr91, align 4, !dbg !55, !tbaa !30
  %add.ptr91.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %8, !dbg !54
  %23 = load i32, ptr addrspace(4) %add.ptr91.1, align 4, !dbg !55, !tbaa !30
  %add.ptr91.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %10, !dbg !54
  %24 = load i32, ptr addrspace(4) %add.ptr91.2, align 4, !dbg !55, !tbaa !30
  %add.ptr91.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %12, !dbg !54
  %25 = load i32, ptr addrspace(4) %add.ptr91.3, align 4, !dbg !55, !tbaa !30
  %add.ptr91.1659 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %14, !dbg !54
  %26 = load i32, ptr addrspace(4) %add.ptr91.1659, align 4, !dbg !55, !tbaa !30
  %add.ptr91.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %16, !dbg !54
  %27 = load i32, ptr addrspace(4) %add.ptr91.1.1, align 4, !dbg !55, !tbaa !30
  %add.ptr91.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %18, !dbg !54
  %28 = load i32, ptr addrspace(4) %add.ptr91.2.1, align 4, !dbg !55, !tbaa !30
  %add.ptr91.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %20, !dbg !54
  %29 = load i32, ptr addrspace(4) %add.ptr91.3.1, align 4, !dbg !55, !tbaa !30
  %mul114 = and i32 %mul11, 8128
  %xor584 = and i32 %mul11, 56
  %call117.masked = and i32 %2, 1016
  %mul119 = xor i32 %xor584, %call117.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul114, !dbg !56
  %invariant.gep600 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul119, !dbg !56
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep600, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !dbg !57, !call_argsrelate !58
  %gep601.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep600, i32 1024, !dbg !59
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep601.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !dbg !57, !call_argsrelate !58
  fence syncscope("warp") release, !dbg !60
  tail call void @llvm.mxc.barrier.warp(), !dbg !66
  fence syncscope("warp") acquire, !dbg !67
  %and131 = shl nuw nsw i32 %2, 6
  %mul132 = and i32 %and131, 960
  %shr135 = lshr i32 %2, 4
  %and138 = and i32 %2, 7
  %30 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul132
  %xor139 = xor i32 %shr135, %and138, !dbg !68
  %add.ptr143.idx = shl nuw nsw i32 %xor139, 4, !dbg !69
  %add.ptr143 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 %add.ptr143.idx, !dbg !69
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr143, align 16, !dbg !70
  %Q_reg.sroa.4.0.add.ptr143.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr143, i32 8, !dbg !70
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr143.sroa_idx, align 8, !dbg !70
  %add136.1 = add nuw nsw i32 %shr135, 4, !dbg !71
  %xor139.1 = xor i32 %add136.1, %and138, !dbg !68
  %add.ptr143.idx.1 = shl nuw nsw i32 %xor139.1, 4, !dbg !69
  %add.ptr143.1 = getelementptr inbounds i8, ptr addrspace(3) %30, i32 %add.ptr143.idx.1, !dbg !69
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr143.1, align 16, !dbg !70
  %Q_reg.sroa.7.16.add.ptr143.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr143.1, i32 8, !dbg !70
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr143.1.sroa_idx, align 8, !dbg !70
  fence syncscope("warp") release, !dbg !72
  tail call void @llvm.mxc.barrier.warp(), !dbg !75
  fence syncscope("warp") acquire, !dbg !76
  store i32 %7, ptr addrspace(3) %invariant.gep600, align 16, !dbg !77, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep605.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep600, i32 4, !dbg !77
  store i32 %9, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep605.sroa_idx, align 4, !dbg !77, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep605.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep600, i32 8, !dbg !77
  store i32 %11, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep605.sroa_idx, align 8, !dbg !77, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep605.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep600, i32 12, !dbg !77
  store i32 %13, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep605.sroa_idx, align 4, !dbg !77, !tbaa !30
  store i32 %15, ptr addrspace(3) %gep601.1, align 16, !dbg !77, !tbaa !30
  %K_reg.sroa.9.16.gep606.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep600, i32 1028, !dbg !77
  store i32 %17, ptr addrspace(3) %K_reg.sroa.9.16.gep606.1.sroa_idx, align 4, !dbg !77, !tbaa !30
  %K_reg.sroa.10.16.gep606.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep600, i32 1032, !dbg !77
  store i32 %19, ptr addrspace(3) %K_reg.sroa.10.16.gep606.1.sroa_idx, align 8, !dbg !77, !tbaa !30
  %K_reg.sroa.11.16.gep606.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep600, i32 1036, !dbg !77
  store i32 %21, ptr addrspace(3) %K_reg.sroa.11.16.gep606.1.sroa_idx, align 4, !dbg !77, !tbaa !30
  fence syncscope("warp") release, !dbg !78
  tail call void @llvm.mxc.barrier.warp(), !dbg !81
  fence syncscope("warp") acquire, !dbg !82
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr143, align 16, !dbg !83
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr143.sroa_idx, align 8, !dbg !83
  %31 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !84
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %31), !dbg !84
  %kb.sroa.0.0.copyload689 = load <4 x half>, ptr addrspace(3) %add.ptr143.1, align 16, !dbg !83
  %kb.sroa.6.0.copyload690 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr143.1.sroa_idx, align 8, !dbg !83
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload689, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %32), !dbg !84
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload690, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %33), !dbg !84
  fence syncscope("warp") release, !dbg !85
  tail call void @llvm.mxc.barrier.warp(), !dbg !88
  fence syncscope("warp") acquire, !dbg !89
  %add.ptr258.idx = shl nuw nsw i32 %2, 4
  %invariant.gep613 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr258.idx, !dbg !90
  store i32 %22, ptr addrspace(3) %invariant.gep613, align 16, !dbg !91, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep613.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 4, !dbg !91
  store i32 %23, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep613.sroa_idx, align 4, !dbg !91, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep613.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 8, !dbg !91
  store i32 %24, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep613.sroa_idx, align 8, !dbg !91, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep613.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 12, !dbg !91
  store i32 %25, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep613.sroa_idx, align 4, !dbg !91, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 1024, !dbg !92
  store i32 %26, ptr addrspace(3) %gep.1, align 16, !dbg !91, !tbaa !30
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 1028, !dbg !91
  store i32 %27, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !dbg !91, !tbaa !30
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 1032, !dbg !91
  store i32 %28, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !dbg !91, !tbaa !30
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep613, i32 1036, !dbg !91
  store i32 %29, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !dbg !91, !tbaa !30
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %34, i64 0, !dbg !93
  %mul268 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FC2776C60000000, !dbg !94
  %35 = tail call contract noundef float @llvm.minnum.f32(float %mul268, float 1.500000e+01), !dbg !95
  %cmp.i.i = fcmp contract olt float %35, -1.260000e+02, !dbg !99
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00, !dbg !99
  %add.i.i = fadd contract float %35, %cond.i.i, !dbg !99
  %36 = tail call contract float @llvm.exp2.f32(float %add.i.i), !dbg !99
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00, !dbg !99
  %mul.i.i = fmul contract float %cond2.i.i, %36, !dbg !99
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %34, i64 1, !dbg !93
  %mul268.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FC2776C60000000, !dbg !94
  %37 = tail call contract noundef float @llvm.minnum.f32(float %mul268.1, float 1.500000e+01), !dbg !95
  %cmp.i.i.1 = fcmp contract olt float %37, -1.260000e+02, !dbg !99
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00, !dbg !99
  %add.i.i.1 = fadd contract float %37, %cond.i.i.1, !dbg !99
  %38 = tail call contract float @llvm.exp2.f32(float %add.i.i.1), !dbg !99
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !99
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %38, !dbg !99
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %34, i64 2, !dbg !93
  %mul268.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FC2776C60000000, !dbg !94
  %39 = tail call contract noundef float @llvm.minnum.f32(float %mul268.2, float 1.500000e+01), !dbg !95
  %cmp.i.i.2 = fcmp contract olt float %39, -1.260000e+02, !dbg !99
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00, !dbg !99
  %add.i.i.2 = fadd contract float %39, %cond.i.i.2, !dbg !99
  %40 = tail call contract float @llvm.exp2.f32(float %add.i.i.2), !dbg !99
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00, !dbg !99
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %40, !dbg !99
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %34, i64 3, !dbg !93
  %mul268.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FC2776C60000000, !dbg !94
  %41 = tail call contract noundef float @llvm.minnum.f32(float %mul268.3, float 1.500000e+01), !dbg !95
  %cmp.i.i.3 = fcmp contract olt float %41, -1.260000e+02, !dbg !99
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00, !dbg !99
  %add.i.i.3 = fadd contract float %41, %cond.i.i.3, !dbg !99
  %42 = tail call contract float @llvm.exp2.f32(float %add.i.i.3), !dbg !99
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00, !dbg !99
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %42, !dbg !99
  %add284 = fadd contract float %mul.i.i, 0.000000e+00, !dbg !102
  %add284.1 = fadd contract float %add284, %mul.i.i.1, !dbg !102
  %add284.2 = fadd contract float %add284.1, %mul.i.i.2, !dbg !102
  %add284.3 = fadd contract float %add284.2, %mul.i.i.3, !dbg !102
  %43 = bitcast float %add284.3 to i32, !dbg !103
  %44 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !106
  %45 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %44) #11, !dbg !111
  %xor.i.i = xor i32 %45, 32, !dbg !112
  %46 = and i32 %45, -64, !dbg !113
  %and.i.i = add nsw i32 %46, 64, !dbg !113
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !114
  %cond.i.i586 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %45, !dbg !115
  %shl.i.i = shl i32 %cond.i.i586, 2, !dbg !116
  %47 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %43), !dbg !117
  %48 = bitcast i32 %47 to float, !dbg !118
  %add292 = fadd contract float %add284.3, %48, !dbg !119
  %49 = bitcast float %add292 to i32, !dbg !120
  %50 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !122
  %51 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %50) #11, !dbg !125
  %xor.i.i587 = xor i32 %51, 16, !dbg !126
  %52 = and i32 %51, -64, !dbg !127
  %and.i.i588 = add nsw i32 %52, 64, !dbg !127
  %cmp.not.i.i589 = icmp slt i32 %xor.i.i587, %and.i.i588, !dbg !128
  %cond.i.i590 = select i1 %cmp.not.i.i589, i32 %xor.i.i587, i32 %51, !dbg !129
  %shl.i.i591 = shl i32 %cond.i.i590, 2, !dbg !130
  %53 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i591, i32 %49), !dbg !131
  %54 = bitcast i32 %53 to float, !dbg !132
  %add297 = fadd contract float %add292, %54, !dbg !133
  %cmp300 = fcmp contract ogt float %add297, 0.000000e+00, !dbg !134
  %div = fdiv contract float 1.000000e+00, %add297, !dbg !135
  %condval_1.0 = select i1 %cmp300, float %div, float 0.000000e+00, !dbg !135
  %mul313 = fmul contract float %condval_1.0, %mul.i.i, !dbg !136
  %mul313.1 = fmul contract float %condval_1.0, %mul.i.i.1, !dbg !136
  %mul313.2 = fmul contract float %condval_1.0, %mul.i.i.2, !dbg !136
  %mul313.3 = fmul contract float %condval_1.0, %mul.i.i.3, !dbg !136
  %55 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul313), !dbg !137
  %56 = insertelement <4 x i16> poison, i16 %55, i64 0, !dbg !146
  %57 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul313.1), !dbg !137
  %58 = insertelement <4 x i16> %56, i16 %57, i64 1, !dbg !146
  %59 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul313.2), !dbg !137
  %60 = insertelement <4 x i16> %58, i16 %59, i64 2, !dbg !146
  %61 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul313.3), !dbg !137
  %62 = insertelement <4 x i16> %60, i16 %61, i64 3, !dbg !146
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %62 to <4 x half>, !dbg !146
  fence syncscope("warp") release, !dbg !147
  tail call void @llvm.mxc.barrier.warp(), !dbg !150
  fence syncscope("warp") acquire, !dbg !151
  br label %if.end331, !dbg !152

if.end331:                                        ; preds = %for.cond37.preheader, %entry
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ %acc_s_cast.sroa.0.6.vec.insert, %for.cond37.preheader ], [ undef, %entry ]
  br i1 %cmp34, label %for.cond349.preheader, label %if.end397, !dbg !153

for.cond349.preheader:                            ; preds = %if.end331
  %63 = shl nuw nsw i32 %2, 4
  %mul359 = and i32 %63, 16128
  %and365 = and i32 %2, 15
  %add366 = or disjoint i32 %mul359, %and365, !dbg !154
  %arrayidx368 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366, !dbg !155
  %64 = load half, ptr addrspace(3) %arrayidx368, align 2, !dbg !156, !tbaa !157
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %64, i64 0, !dbg !156
  %add361.1 = or disjoint i32 %mul359, %and365, !dbg !154
  %add366.1 = or disjoint i32 %add361.1, 64, !dbg !154
  %arrayidx368.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366.1, !dbg !155
  %65 = load half, ptr addrspace(3) %arrayidx368.1, align 2, !dbg !156, !tbaa !157
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %65, i64 1, !dbg !156
  %add361.2 = or disjoint i32 %mul359, %and365, !dbg !154
  %add366.2 = or disjoint i32 %add361.2, 128, !dbg !154
  %arrayidx368.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366.2, !dbg !155
  %66 = load half, ptr addrspace(3) %arrayidx368.2, align 2, !dbg !156, !tbaa !157
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %66, i64 2, !dbg !156
  %add361.3 = or disjoint i32 %mul359, %and365, !dbg !154
  %add366.3 = or disjoint i32 %add361.3, 192, !dbg !154
  %arrayidx368.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366.3, !dbg !155
  %67 = load half, ptr addrspace(3) %arrayidx368.3, align 2, !dbg !156, !tbaa !157
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %67, i64 3, !dbg !156
  %add363.1663 = or disjoint i32 %mul359, %and365, !dbg !154
  %add366.1664 = or disjoint i32 %add363.1663, 16, !dbg !154
  %arrayidx368.1665 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366.1664, !dbg !155
  %68 = load half, ptr addrspace(3) %arrayidx368.1665, align 2, !dbg !156, !tbaa !157
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %68, i64 0, !dbg !156
  %add363.1.1 = or disjoint i32 %mul359, %and365, !dbg !154
  %add366.1.1 = or disjoint i32 %add363.1.1, 80, !dbg !154
  %arrayidx368.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366.1.1, !dbg !155
  %69 = load half, ptr addrspace(3) %arrayidx368.1.1, align 2, !dbg !156, !tbaa !157
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %69, i64 1, !dbg !156
  %add363.2.1 = or disjoint i32 %mul359, %and365, !dbg !154
  %add366.2.1 = or disjoint i32 %add363.2.1, 144, !dbg !154
  %arrayidx368.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366.2.1, !dbg !155
  %70 = load half, ptr addrspace(3) %arrayidx368.2.1, align 2, !dbg !156, !tbaa !157
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %70, i64 2, !dbg !156
  %add363.3.1 = or disjoint i32 %mul359, %and365, !dbg !154
  %add366.3.1 = or disjoint i32 %add363.3.1, 208, !dbg !154
  %arrayidx368.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366.3.1, !dbg !155
  %71 = load half, ptr addrspace(3) %arrayidx368.3.1, align 2, !dbg !156, !tbaa !157
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %71, i64 3, !dbg !156
  %add363.2667 = or disjoint i32 %mul359, %and365, !dbg !154
  %add366.2668 = or disjoint i32 %add363.2667, 32, !dbg !154
  %arrayidx368.2669 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366.2668, !dbg !155
  %72 = load half, ptr addrspace(3) %arrayidx368.2669, align 2, !dbg !156, !tbaa !157
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %72, i64 0, !dbg !156
  %add363.1.2 = or disjoint i32 %mul359, %and365, !dbg !154
  %add366.1.2 = or disjoint i32 %add363.1.2, 96, !dbg !154
  %arrayidx368.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366.1.2, !dbg !155
  %73 = load half, ptr addrspace(3) %arrayidx368.1.2, align 2, !dbg !156, !tbaa !157
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %73, i64 1, !dbg !156
  %add363.2.2 = or disjoint i32 %mul359, %and365, !dbg !154
  %add366.2.2 = or disjoint i32 %add363.2.2, 160, !dbg !154
  %arrayidx368.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366.2.2, !dbg !155
  %74 = load half, ptr addrspace(3) %arrayidx368.2.2, align 2, !dbg !156, !tbaa !157
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %74, i64 2, !dbg !156
  %add363.3.2 = or disjoint i32 %mul359, %and365, !dbg !154
  %add366.3.2 = or disjoint i32 %add363.3.2, 224, !dbg !154
  %arrayidx368.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366.3.2, !dbg !155
  %75 = load half, ptr addrspace(3) %arrayidx368.3.2, align 2, !dbg !156, !tbaa !157
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %75, i64 3, !dbg !156
  %add363.3671 = or disjoint i32 %mul359, %and365, !dbg !154
  %add366.3672 = or disjoint i32 %add363.3671, 48, !dbg !154
  %arrayidx368.3673 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366.3672, !dbg !155
  %76 = load half, ptr addrspace(3) %arrayidx368.3673, align 2, !dbg !156, !tbaa !157
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %76, i64 0, !dbg !156
  %add363.1.3 = or disjoint i32 %mul359, %and365, !dbg !154
  %add366.1.3 = or disjoint i32 %add363.1.3, 112, !dbg !154
  %arrayidx368.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366.1.3, !dbg !155
  %77 = load half, ptr addrspace(3) %arrayidx368.1.3, align 2, !dbg !156, !tbaa !157
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %77, i64 1, !dbg !156
  %add363.2.3 = or disjoint i32 %mul359, %and365, !dbg !154
  %add366.2.3 = or disjoint i32 %add363.2.3, 176, !dbg !154
  %arrayidx368.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366.2.3, !dbg !155
  %78 = load half, ptr addrspace(3) %arrayidx368.2.3, align 2, !dbg !156, !tbaa !157
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %78, i64 2, !dbg !156
  %add363.3.3 = or disjoint i32 %63, %and365, !dbg !154
  %add366.3.3 = or i32 %add363.3.3, 240, !dbg !154
  %arrayidx368.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add366.3.3, !dbg !155
  %79 = load half, ptr addrspace(3) %arrayidx368.3.3, align 2, !dbg !156, !tbaa !157
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %79, i64 3, !dbg !156
  %80 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !158
  %81 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !158
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !158
  %83 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !158
  br label %if.end397, !dbg !159

if.end397:                                        ; preds = %for.cond349.preheader, %if.end331
  %acc_o.sroa.0.0 = phi <4 x float> [ %80, %for.cond349.preheader ], [ zeroinitializer, %if.end331 ], !dbg !160
  %acc_o.sroa.16.0 = phi <4 x float> [ %81, %for.cond349.preheader ], [ zeroinitializer, %if.end331 ], !dbg !160
  %acc_o.sroa.30.0 = phi <4 x float> [ %82, %for.cond349.preheader ], [ zeroinitializer, %if.end331 ], !dbg !160
  %acc_o.sroa.44.0 = phi <4 x float> [ %83, %for.cond349.preheader ], [ zeroinitializer, %if.end331 ], !dbg !160
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
  %and430 = shl nuw nsw i32 %2, 6
  %mul431 = and i32 %and430, 960
  %shr434 = lshr i32 %2, 5
  %and437 = and i32 %2, 7
  %100 = lshr i32 %2, 2
  %mul444 = and i32 %100, 4
  %xor438 = xor i32 %shr434, %and437, !dbg !172
  %mul439 = shl nuw nsw i32 %xor438, 3, !dbg !173
  %add440 = add nuw nsw i32 %mul439, %mul431, !dbg !174
  %add445 = or disjoint i32 %add440, %mul444, !dbg !175
  %add.ptr447 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add445, !dbg !176
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr447, align 8, !dbg !177
  %add435.1 = add nuw nsw i32 %shr434, 2, !dbg !178
  %xor438.1 = xor i32 %add435.1, %and437, !dbg !172
  %mul439.1 = shl nuw nsw i32 %xor438.1, 3, !dbg !173
  %add440.1 = add nuw nsw i32 %mul439.1, %mul431, !dbg !174
  %add445.1 = or disjoint i32 %add440.1, %mul444, !dbg !175
  %add.ptr447.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add445.1, !dbg !176
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr447.1, align 8, !dbg !177
  %add435.2 = add nuw nsw i32 %shr434, 4, !dbg !178
  %xor438.2 = xor i32 %add435.2, %and437, !dbg !172
  %mul439.2 = shl nuw nsw i32 %xor438.2, 3, !dbg !173
  %add440.2 = add nuw nsw i32 %mul439.2, %mul431, !dbg !174
  %add445.2 = or disjoint i32 %add440.2, %mul444, !dbg !175
  %add.ptr447.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add445.2, !dbg !176
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr447.2, align 8, !dbg !177
  %add435.3 = add nuw nsw i32 %shr434, 6, !dbg !178
  %xor438.3 = xor i32 %add435.3, %and437, !dbg !172
  %mul439.3 = shl nuw nsw i32 %xor438.3, 3, !dbg !173
  %add440.3 = add nuw nsw i32 %mul439.3, %mul431, !dbg !174
  %add445.3 = or disjoint i32 %add440.3, %mul444, !dbg !175
  %add.ptr447.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add445.3, !dbg !176
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr447.3, align 8, !dbg !177
  fence syncscope("warp") release, !dbg !179
  tail call void @llvm.mxc.barrier.warp(), !dbg !182
  fence syncscope("warp") acquire, !dbg !183
  %mul458 = and i32 %mul11, 8128
  %xor464580 = and i32 %mul11, 56
  %call462.masked = and i32 %2, 1016
  %mul465 = xor i32 %xor464580, %call462.masked
  %invariant.gep627 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul458, !dbg !184
  %invariant.gep629 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep627, i32 %mul465, !dbg !184
  %add.ptr480 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3, !dbg !185
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr480, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep629, i64 16, i1 false), !dbg !186, !tbaa.struct !187, !call_argsrelate !188
  %gep630.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep629, i32 1024, !dbg !189
  %add.ptr480.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4, !dbg !185
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr480.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep630.1, i64 16, i1 false), !dbg !186, !tbaa.struct !187, !call_argsrelate !188
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
!1 = !DIFile(filename: "/tmp/tmpazckvryo/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpazckvryo/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 25, column: 3, scope: !40)
!44 = !DILocation(line: 26, column: 126, scope: !40)
!45 = !DILocation(line: 28, column: 58, scope: !40)
!46 = !DILocation(line: 28, column: 66, scope: !40)
!47 = !DILocation(line: 28, column: 25, scope: !40)
!48 = !DILocation(line: 34, column: 30, scope: !40)
!49 = !DILocation(line: 26, column: 48, scope: !40)
!50 = !DILocation(line: 37, column: 5, scope: !40)
!51 = !DILocation(line: 40, column: 79, scope: !40)
!52 = !DILocation(line: 40, column: 58, scope: !40)
!53 = !DILocation(line: 40, column: 187, scope: !40)
!54 = !DILocation(line: 47, column: 79, scope: !40)
!55 = !DILocation(line: 47, column: 58, scope: !40)
!56 = !DILocation(line: 51, column: 5, scope: !40)
!57 = !DILocation(line: 52, column: 159, scope: !40)
!58 = !{i32 1, i32 3, i32 -1, i32 -1}
!59 = !DILocation(line: 52, column: 42, scope: !40)
!60 = !DILocation(line: 68, column: 3, scope: !61, inlinedAt: !63)
!61 = distinct !DISubprogram(name: "__barrier_warp", scope: !62, file: !62, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!62 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!63 = distinct !DILocation(line: 192, column: 3, scope: !64, inlinedAt: !65)
!64 = distinct !DISubprogram(name: "__syncwarp", scope: !62, file: !62, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!65 = distinct !DILocation(line: 54, column: 5, scope: !40)
!66 = !DILocation(line: 69, column: 3, scope: !61, inlinedAt: !63)
!67 = !DILocation(line: 70, column: 3, scope: !61, inlinedAt: !63)
!68 = !DILocation(line: 57, column: 153, scope: !40)
!69 = !DILocation(line: 57, column: 73, scope: !40)
!70 = !DILocation(line: 57, column: 36, scope: !40)
!71 = !DILocation(line: 57, column: 124, scope: !40)
!72 = !DILocation(line: 68, column: 3, scope: !61, inlinedAt: !73)
!73 = distinct !DILocation(line: 192, column: 3, scope: !64, inlinedAt: !74)
!74 = distinct !DILocation(line: 59, column: 5, scope: !40)
!75 = !DILocation(line: 69, column: 3, scope: !61, inlinedAt: !73)
!76 = !DILocation(line: 70, column: 3, scope: !61, inlinedAt: !73)
!77 = !DILocation(line: 62, column: 159, scope: !40)
!78 = !DILocation(line: 68, column: 3, scope: !61, inlinedAt: !79)
!79 = distinct !DILocation(line: 192, column: 3, scope: !64, inlinedAt: !80)
!80 = distinct !DILocation(line: 79, column: 5, scope: !40)
!81 = !DILocation(line: 69, column: 3, scope: !61, inlinedAt: !79)
!82 = !DILocation(line: 70, column: 3, scope: !61, inlinedAt: !79)
!83 = !DILocation(line: 81, column: 25, scope: !40)
!84 = !DILocation(line: 84, column: 36, scope: !40)
!85 = !DILocation(line: 68, column: 3, scope: !61, inlinedAt: !86)
!86 = distinct !DILocation(line: 192, column: 3, scope: !64, inlinedAt: !87)
!87 = distinct !DILocation(line: 90, column: 5, scope: !40)
!88 = !DILocation(line: 69, column: 3, scope: !61, inlinedAt: !86)
!89 = !DILocation(line: 70, column: 3, scope: !61, inlinedAt: !86)
!90 = !DILocation(line: 92, column: 10, scope: !40)
!91 = !DILocation(line: 93, column: 86, scope: !40)
!92 = !DILocation(line: 93, column: 42, scope: !40)
!93 = !DILocation(line: 97, column: 31, scope: !40)
!94 = !DILocation(line: 97, column: 42, scope: !40)
!95 = !DILocation(line: 354, column: 10, scope: !96, inlinedAt: !98)
!96 = distinct !DISubprogram(name: "min", scope: !97, file: !97, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!97 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!98 = distinct !DILocation(line: 97, column: 26, scope: !40)
!99 = !DILocation(line: 285, column: 49, scope: !100, inlinedAt: !101)
!100 = distinct !DISubprogram(name: "exp2f", scope: !97, file: !97, line: 285, type: !7, scopeLine: 285, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!101 = distinct !DILocation(line: 97, column: 20, scope: !40)
!102 = !DILocation(line: 102, column: 34, scope: !40)
!103 = !DILocation(line: 1018, column: 9, scope: !104, inlinedAt: !105)
!104 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !62, file: !62, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!105 = distinct !DILocation(line: 104, column: 34, scope: !40)
!106 = !DILocation(line: 171, column: 37, scope: !107, inlinedAt: !108)
!107 = distinct !DISubprogram(name: "__lane_id", scope: !62, file: !62, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!108 = distinct !DILocation(line: 990, column: 14, scope: !109, inlinedAt: !110)
!109 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !62, file: !62, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!110 = distinct !DILocation(line: 1019, column: 11, scope: !104, inlinedAt: !105)
!111 = !DILocation(line: 171, column: 10, scope: !107, inlinedAt: !108)
!112 = !DILocation(line: 991, column: 20, scope: !109, inlinedAt: !110)
!113 = !DILocation(line: 992, column: 36, scope: !109, inlinedAt: !110)
!114 = !DILocation(line: 992, column: 17, scope: !109, inlinedAt: !110)
!115 = !DILocation(line: 992, column: 11, scope: !109, inlinedAt: !110)
!116 = !DILocation(line: 993, column: 43, scope: !109, inlinedAt: !110)
!117 = !DILocation(line: 993, column: 10, scope: !109, inlinedAt: !110)
!118 = !DILocation(line: 1020, column: 14, scope: !104, inlinedAt: !105)
!119 = !DILocation(line: 104, column: 32, scope: !40)
!120 = !DILocation(line: 1018, column: 9, scope: !104, inlinedAt: !121)
!121 = distinct !DILocation(line: 105, column: 34, scope: !40)
!122 = !DILocation(line: 171, column: 37, scope: !107, inlinedAt: !123)
!123 = distinct !DILocation(line: 990, column: 14, scope: !109, inlinedAt: !124)
!124 = distinct !DILocation(line: 1019, column: 11, scope: !104, inlinedAt: !121)
!125 = !DILocation(line: 171, column: 10, scope: !107, inlinedAt: !123)
!126 = !DILocation(line: 991, column: 20, scope: !109, inlinedAt: !124)
!127 = !DILocation(line: 992, column: 36, scope: !109, inlinedAt: !124)
!128 = !DILocation(line: 992, column: 17, scope: !109, inlinedAt: !124)
!129 = !DILocation(line: 992, column: 11, scope: !109, inlinedAt: !124)
!130 = !DILocation(line: 993, column: 43, scope: !109, inlinedAt: !124)
!131 = !DILocation(line: 993, column: 10, scope: !109, inlinedAt: !124)
!132 = !DILocation(line: 1020, column: 14, scope: !104, inlinedAt: !121)
!133 = !DILocation(line: 105, column: 32, scope: !40)
!134 = !DILocation(line: 107, column: 34, scope: !40)
!135 = !DILocation(line: 107, column: 9, scope: !40)
!136 = !DILocation(line: 115, column: 32, scope: !40)
!137 = !DILocation(line: 75, column: 10, scope: !138, inlinedAt: !140)
!138 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !139, file: !139, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!139 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!140 = distinct !DILocation(line: 984, column: 9, scope: !141, inlinedAt: !143)
!141 = distinct !DISubprogram(name: "__float2half", scope: !142, file: !142, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!142 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!143 = distinct !DILocation(line: 133, column: 53, scope: !144, inlinedAt: !145)
!144 = distinct !DISubprogram(name: "__half", scope: !142, file: !142, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!145 = distinct !DILocation(line: 119, column: 32, scope: !40)
!146 = !DILocation(line: 119, column: 29, scope: !40)
!147 = !DILocation(line: 68, column: 3, scope: !61, inlinedAt: !148)
!148 = distinct !DILocation(line: 192, column: 3, scope: !64, inlinedAt: !149)
!149 = distinct !DILocation(line: 121, column: 5, scope: !40)
!150 = !DILocation(line: 69, column: 3, scope: !61, inlinedAt: !148)
!151 = !DILocation(line: 70, column: 3, scope: !61, inlinedAt: !148)
!152 = !DILocation(line: 122, column: 3, scope: !40)
!153 = !DILocation(line: 128, column: 30, scope: !40)
!154 = !DILocation(line: 131, column: 119, scope: !40)
!155 = !DILocation(line: 131, column: 31, scope: !40)
!156 = !DILocation(line: 131, column: 29, scope: !40)
!157 = !{!26, !26, i64 0}
!158 = !DILocation(line: 136, column: 38, scope: !40)
!159 = !DILocation(line: 143, column: 3, scope: !40)
!160 = !DILocation(line: 0, scope: !40)
!161 = !DILocation(line: 146, column: 58, scope: !40)
!162 = !DILocation(line: 75, column: 10, scope: !138, inlinedAt: !163)
!163 = distinct !DILocation(line: 984, column: 9, scope: !141, inlinedAt: !164)
!164 = distinct !DILocation(line: 133, column: 53, scope: !144, inlinedAt: !165)
!165 = distinct !DILocation(line: 146, column: 50, scope: !40)
!166 = !DILocation(line: 146, column: 47, scope: !40)
!167 = !DILocation(line: 68, column: 3, scope: !61, inlinedAt: !168)
!168 = distinct !DILocation(line: 192, column: 3, scope: !64, inlinedAt: !169)
!169 = distinct !DILocation(line: 149, column: 3, scope: !40)
!170 = !DILocation(line: 69, column: 3, scope: !61, inlinedAt: !168)
!171 = !DILocation(line: 70, column: 3, scope: !61, inlinedAt: !168)
!172 = !DILocation(line: 152, column: 122, scope: !40)
!173 = !DILocation(line: 152, column: 150, scope: !40)
!174 = !DILocation(line: 152, column: 77, scope: !40)
!175 = !DILocation(line: 152, column: 156, scope: !40)
!176 = !DILocation(line: 152, column: 40, scope: !40)
!177 = !DILocation(line: 152, column: 199, scope: !40)
!178 = !DILocation(line: 152, column: 93, scope: !40)
!179 = !DILocation(line: 68, column: 3, scope: !61, inlinedAt: !180)
!180 = distinct !DILocation(line: 192, column: 3, scope: !64, inlinedAt: !181)
!181 = distinct !DILocation(line: 154, column: 3, scope: !40)
!182 = !DILocation(line: 69, column: 3, scope: !61, inlinedAt: !180)
!183 = !DILocation(line: 70, column: 3, scope: !61, inlinedAt: !180)
!184 = !DILocation(line: 156, column: 8, scope: !40)
!185 = !DILocation(line: 157, column: 22, scope: !40)
!186 = !DILocation(line: 157, column: 132, scope: !40)
!187 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!188 = !{i32 2, i32 -1, i32 -1, i32 -1}
!189 = !DILocation(line: 157, column: 169, scope: !40)
!190 = !DILocation(line: 159, column: 1, scope: !40)
