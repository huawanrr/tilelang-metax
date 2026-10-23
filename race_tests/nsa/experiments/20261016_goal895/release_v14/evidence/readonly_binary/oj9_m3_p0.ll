; ModuleID = 'experiments/20261016_goal895/readonly_binary/oj9_m3_p0.bc'
source_filename = "/tmp/tmpawpp8juv/tvm_kernels.maca"
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
  %arrayidx14.val = load i32, ptr addrspace(1) %arrayidx14, align 4, !dbg !46, !tbaa !30
  %or.cond = icmp ugt i32 %arrayidx14.val, 511, !dbg !47
  %.pre = lshr i32 %0, 4
  %cmp33.not = icmp ugt i32 %arrayidx14.val, %.pre
  %or.cond852 = or i1 %or.cond, %cmp33.not, !dbg !47
  br i1 %or.cond852, label %if.end349, label %for.cond36.preheader, !dbg !47

for.cond36.preheader:                             ; preds = %entry
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !48
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %2, !dbg !48
  %mul50 = shl nuw nsw i32 %arrayidx14.val, 10
  %add52 = add nuw nsw i32 %mul50, %mul8
  %4 = zext nneg i32 %add52 to i64, !dbg !49
  %arrayidx60 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %4, !dbg !50
  %5 = or disjoint i64 %4, 2
  %arrayidx60.1672 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %5, !dbg !50
  %6 = or disjoint i64 %4, 4
  %arrayidx60.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %6, !dbg !50
  %7 = or disjoint i64 %4, 6
  %arrayidx60.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %7, !dbg !50
  %8 = add nuw nsw i64 %4, 512
  %arrayidx60.1679 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %8, !dbg !50
  %9 = add nuw nsw i64 %4, 514
  %arrayidx60.1672.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %9, !dbg !50
  %10 = add nuw nsw i64 %4, 516
  %arrayidx60.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %10, !dbg !50
  %11 = add nuw nsw i64 %4, 518
  %arrayidx60.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %11, !dbg !50
  %arrayidx100 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %4, !dbg !51
  %arrayidx100.1693 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %5, !dbg !51
  %arrayidx100.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %6, !dbg !51
  %arrayidx100.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %7, !dbg !51
  %arrayidx100.1700 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %8, !dbg !51
  %arrayidx100.1693.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %9, !dbg !51
  %arrayidx100.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %10, !dbg !51
  %arrayidx100.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %11, !dbg !51
  %mul129 = and i32 %mul8, 8128
  %xor614 = and i32 %mul8, 56
  %call132.masked = and i32 %1, 1016
  %mul134 = xor i32 %xor614, %call132.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul129, !dbg !52
  %invariant.gep627 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul134, !dbg !52
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep627, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !dbg !53, !call_argsrelate !54
  %gep628.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep627, i32 1024, !dbg !55
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep628.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !dbg !53, !call_argsrelate !54
  fence syncscope("warp") release, !dbg !56
  tail call void @llvm.mxc.barrier.warp(), !dbg !62
  fence syncscope("warp") acquire, !dbg !63
  %and146 = shl nuw nsw i32 %1, 6
  %mul147 = and i32 %and146, 960
  %shr150 = lshr i32 %1, 4
  %and153 = and i32 %1, 7
  %12 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul147
  %xor154 = xor i32 %shr150, %and153, !dbg !64
  %add.ptr158.idx = shl nuw nsw i32 %xor154, 4, !dbg !65
  %add.ptr158 = getelementptr inbounds i8, ptr addrspace(3) %12, i32 %add.ptr158.idx, !dbg !65
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr158, align 16, !dbg !66
  %Q_reg.sroa.4.0.add.ptr158.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr158, i32 8, !dbg !66
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr158.sroa_idx, align 8, !dbg !66
  %add151.1 = add nuw nsw i32 %shr150, 4, !dbg !67
  %xor154.1 = xor i32 %add151.1, %and153, !dbg !64
  %add.ptr158.idx.1 = shl nuw nsw i32 %xor154.1, 4, !dbg !65
  %add.ptr158.1 = getelementptr inbounds i8, ptr addrspace(3) %12, i32 %add.ptr158.idx.1, !dbg !65
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr158.1, align 16, !dbg !66
  %Q_reg.sroa.7.16.add.ptr158.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr158.1, i32 8, !dbg !66
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr158.1.sroa_idx, align 8, !dbg !66
  fence syncscope("warp") release, !dbg !68
  tail call void @llvm.mxc.barrier.warp(), !dbg !71
  fence syncscope("warp") acquire, !dbg !72
  %13 = load <2 x i16>, ptr addrspace(4) %arrayidx60, align 2, !dbg !73, !tbaa !74
  store <2 x i16> %13, ptr addrspace(3) %invariant.gep627, align 16, !dbg !75
  %K_reg.sroa.5.0.invariant.gep632.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep627, i32 4, !dbg !75
  %14 = load <2 x i16>, ptr addrspace(4) %arrayidx60.1672, align 2, !dbg !73, !tbaa !74
  store <2 x i16> %14, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep632.sroa_idx, align 4, !dbg !75
  %K_reg.sroa.7.0.invariant.gep632.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep627, i32 8, !dbg !75
  %15 = load <2 x i16>, ptr addrspace(4) %arrayidx60.2, align 2, !dbg !73, !tbaa !74
  store <2 x i16> %15, ptr addrspace(3) %K_reg.sroa.7.0.invariant.gep632.sroa_idx, align 8, !dbg !75
  %K_reg.sroa.9.0.invariant.gep632.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep627, i32 12, !dbg !75
  %16 = load <2 x i16>, ptr addrspace(4) %arrayidx60.3, align 2, !dbg !73, !tbaa !74
  store <2 x i16> %16, ptr addrspace(3) %K_reg.sroa.9.0.invariant.gep632.sroa_idx, align 4, !dbg !75
  %17 = load <2 x i16>, ptr addrspace(4) %arrayidx60.1679, align 2, !dbg !73, !tbaa !74
  store <2 x i16> %17, ptr addrspace(3) %gep628.1, align 16, !dbg !75
  %K_reg.sroa.14.16.gep633.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep627, i32 1028, !dbg !75
  %18 = load <2 x i16>, ptr addrspace(4) %arrayidx60.1672.1, align 2, !dbg !73, !tbaa !74
  store <2 x i16> %18, ptr addrspace(3) %K_reg.sroa.14.16.gep633.1.sroa_idx, align 4, !dbg !75
  %K_reg.sroa.16.16.gep633.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep627, i32 1032, !dbg !75
  %19 = load <2 x i16>, ptr addrspace(4) %arrayidx60.2.1, align 2, !dbg !73, !tbaa !74
  store <2 x i16> %19, ptr addrspace(3) %K_reg.sroa.16.16.gep633.1.sroa_idx, align 8, !dbg !75
  %K_reg.sroa.18.16.gep633.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep627, i32 1036, !dbg !75
  %20 = load <2 x i16>, ptr addrspace(4) %arrayidx60.3.1, align 2, !dbg !73, !tbaa !74
  store <2 x i16> %20, ptr addrspace(3) %K_reg.sroa.18.16.gep633.1.sroa_idx, align 4, !dbg !75
  fence syncscope("warp") release, !dbg !76
  tail call void @llvm.mxc.barrier.warp(), !dbg !79
  fence syncscope("warp") acquire, !dbg !80
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr158, align 16, !dbg !81
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr158.sroa_idx, align 8, !dbg !81
  %21 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !82
  %22 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %21), !dbg !82
  %kb.sroa.0.0.copyload735 = load <4 x half>, ptr addrspace(3) %add.ptr158.1, align 16, !dbg !81
  %kb.sroa.6.0.copyload736 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr158.1.sroa_idx, align 8, !dbg !81
  %23 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload735, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %22), !dbg !82
  %24 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload736, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %23), !dbg !82
  fence syncscope("warp") release, !dbg !83
  tail call void @llvm.mxc.barrier.warp(), !dbg !86
  fence syncscope("warp") acquire, !dbg !87
  %add.ptr250.idx = shl nuw nsw i32 %1, 4
  %invariant.gep640 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr250.idx, !dbg !88
  %25 = load <2 x i16>, ptr addrspace(4) %arrayidx100, align 2, !dbg !89, !tbaa !74
  store <2 x i16> %25, ptr addrspace(3) %invariant.gep640, align 16, !dbg !90
  %V_reg.sroa.5.0.invariant.gep640.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep640, i32 4, !dbg !90
  %26 = load <2 x i16>, ptr addrspace(4) %arrayidx100.1693, align 2, !dbg !89, !tbaa !74
  store <2 x i16> %26, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep640.sroa_idx, align 4, !dbg !90
  %V_reg.sroa.7.0.invariant.gep640.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep640, i32 8, !dbg !90
  %27 = load <2 x i16>, ptr addrspace(4) %arrayidx100.2, align 2, !dbg !89, !tbaa !74
  store <2 x i16> %27, ptr addrspace(3) %V_reg.sroa.7.0.invariant.gep640.sroa_idx, align 8, !dbg !90
  %V_reg.sroa.9.0.invariant.gep640.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep640, i32 12, !dbg !90
  %28 = load <2 x i16>, ptr addrspace(4) %arrayidx100.3, align 2, !dbg !89, !tbaa !74
  store <2 x i16> %28, ptr addrspace(3) %V_reg.sroa.9.0.invariant.gep640.sroa_idx, align 4, !dbg !90
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep640, i32 1024, !dbg !91
  %29 = load <2 x i16>, ptr addrspace(4) %arrayidx100.1700, align 2, !dbg !89, !tbaa !74
  store <2 x i16> %29, ptr addrspace(3) %gep.1, align 16, !dbg !90
  %V_reg.sroa.14.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep640, i32 1028, !dbg !90
  %30 = load <2 x i16>, ptr addrspace(4) %arrayidx100.1693.1, align 2, !dbg !89, !tbaa !74
  store <2 x i16> %30, ptr addrspace(3) %V_reg.sroa.14.16.gep.1.sroa_idx, align 4, !dbg !90
  %V_reg.sroa.16.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep640, i32 1032, !dbg !90
  %31 = load <2 x i16>, ptr addrspace(4) %arrayidx100.2.1, align 2, !dbg !89, !tbaa !74
  store <2 x i16> %31, ptr addrspace(3) %V_reg.sroa.16.16.gep.1.sroa_idx, align 8, !dbg !90
  %V_reg.sroa.18.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep640, i32 1036, !dbg !90
  %32 = load <2 x i16>, ptr addrspace(4) %arrayidx100.3.1, align 2, !dbg !89, !tbaa !74
  store <2 x i16> %32, ptr addrspace(3) %V_reg.sroa.18.16.gep.1.sroa_idx, align 4, !dbg !90
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %24, i64 0, !dbg !92
  %mul260 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !93
  %33 = tail call contract noundef float @llvm.minnum.f32(float %mul260, float 0x4024CB5EC0000000), !dbg !94
  %34 = tail call contract noundef float @llvm.exp.f32(float %33), !dbg !98
  %acc_s.sroa.0.0.vec.insert742 = insertelement <4 x float> poison, float %34, i64 0, !dbg !101
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %24, i64 1, !dbg !92
  %mul260.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !93
  %35 = tail call contract noundef float @llvm.minnum.f32(float %mul260.1, float 0x4024CB5EC0000000), !dbg !94
  %36 = tail call contract noundef float @llvm.exp.f32(float %35), !dbg !98
  %acc_s.sroa.0.4.vec.insert757 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert742, float %36, i64 1, !dbg !101
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %24, i64 2, !dbg !92
  %mul260.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !93
  %37 = tail call contract noundef float @llvm.minnum.f32(float %mul260.2, float 0x4024CB5EC0000000), !dbg !94
  %38 = tail call contract noundef float @llvm.exp.f32(float %37), !dbg !98
  %acc_s.sroa.0.8.vec.insert772 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert757, float %38, i64 2, !dbg !101
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %24, i64 3, !dbg !92
  %mul260.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !93
  %39 = tail call contract noundef float @llvm.minnum.f32(float %mul260.3, float 0x4024CB5EC0000000), !dbg !94
  %40 = tail call contract noundef float @llvm.exp.f32(float %39), !dbg !98
  %acc_s.sroa.0.12.vec.insert787 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert772, float %40, i64 3, !dbg !101
  %cmp270 = icmp eq i32 %arrayidx14.val, %.pre, !dbg !102
  br i1 %cmp270, label %for.cond272.preheader, label %if.end291, !dbg !103

for.cond272.preheader:                            ; preds = %for.cond36.preheader
  %41 = lshr i32 %1, 2
  %mul278 = and i32 %41, 252
  %and281 = and i32 %0, 15
  %cmp282.not = icmp ugt i32 %mul278, %and281, !dbg !104
  %spec.select = select i1 %cmp282.not, float 0.000000e+00, float %34, !dbg !105
  %acc_s.sroa.0.0.vec.insert746 = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !106
  %cmp282.not.1.not = icmp ult i32 %mul278, %and281, !dbg !104
  %condval.0.1 = select i1 %cmp282.not.1.not, float %36, float 0.000000e+00, !dbg !105
  %acc_s.sroa.0.4.vec.insert761 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert746, float %condval.0.1, i64 1, !dbg !106
  %add279.2 = or disjoint i32 %mul278, 2, !dbg !107
  %cmp282.not.2 = icmp ugt i32 %add279.2, %and281, !dbg !104
  %condval.0.2 = select i1 %cmp282.not.2, float 0.000000e+00, float %38, !dbg !105
  %acc_s.sroa.0.8.vec.insert776 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert761, float %condval.0.2, i64 2, !dbg !106
  %add279.3 = or i32 %41, 3, !dbg !107
  %cmp282.not.3 = icmp ugt i32 %add279.3, %and281, !dbg !104
  %condval.0.3 = select i1 %cmp282.not.3, float 0.000000e+00, float %40, !dbg !105
  %acc_s.sroa.0.12.vec.insert791 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert776, float %condval.0.3, i64 3, !dbg !106
  br label %if.end291, !dbg !108

if.end291:                                        ; preds = %for.cond272.preheader, %for.cond36.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert791, %for.cond272.preheader ], [ %acc_s.sroa.0.12.vec.insert787, %for.cond36.preheader ], !dbg !109
  %acc_s.sroa.0.0.vec.extract748 = extractelement <4 x float> %acc_s.sroa.0.0, i64 0, !dbg !110
  %add300 = fadd contract float %acc_s.sroa.0.0.vec.extract748, 0.000000e+00, !dbg !111
  %acc_s.sroa.0.4.vec.extract763 = extractelement <4 x float> %acc_s.sroa.0.0, i64 1, !dbg !110
  %add300.1 = fadd contract float %add300, %acc_s.sroa.0.4.vec.extract763, !dbg !111
  %acc_s.sroa.0.8.vec.extract778 = extractelement <4 x float> %acc_s.sroa.0.0, i64 2, !dbg !110
  %add300.2 = fadd contract float %add300.1, %acc_s.sroa.0.8.vec.extract778, !dbg !111
  %acc_s.sroa.0.12.vec.extract793 = extractelement <4 x float> %acc_s.sroa.0.0, i64 3, !dbg !110
  %add300.3 = fadd contract float %add300.2, %acc_s.sroa.0.12.vec.extract793, !dbg !111
  %42 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add300.3, <4 x float> zeroinitializer), !dbg !112
  %wsum_output.sroa.0.0.vec.extract = extractelement <4 x float> %42, i64 0, !dbg !113
  %cmp318 = fcmp contract ogt float %wsum_output.sroa.0.0.vec.extract, 0.000000e+00, !dbg !114
  %div = fdiv contract float 1.000000e+00, %wsum_output.sroa.0.0.vec.extract, !dbg !115
  %condval_1.0 = select i1 %cmp318, float %div, float 0.000000e+00, !dbg !115
  %mul331 = fmul contract float %condval_1.0, %acc_s.sroa.0.0.vec.extract748, !dbg !116
  %acc_s.sroa.0.4.vec.extract765 = extractelement <4 x float> %acc_s.sroa.0.0, i64 1, !dbg !117
  %mul331.1 = fmul contract float %condval_1.0, %acc_s.sroa.0.4.vec.extract765, !dbg !116
  %acc_s.sroa.0.8.vec.extract780 = extractelement <4 x float> %acc_s.sroa.0.0, i64 2, !dbg !117
  %mul331.2 = fmul contract float %condval_1.0, %acc_s.sroa.0.8.vec.extract780, !dbg !116
  %acc_s.sroa.0.12.vec.extract795 = extractelement <4 x float> %acc_s.sroa.0.0, i64 3, !dbg !117
  %mul331.3 = fmul contract float %condval_1.0, %acc_s.sroa.0.12.vec.extract795, !dbg !116
  %43 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul331), !dbg !118
  %44 = insertelement <4 x i16> poison, i16 %43, i64 0, !dbg !127
  %45 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul331.1), !dbg !118
  %46 = insertelement <4 x i16> %44, i16 %45, i64 1, !dbg !127
  %47 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul331.2), !dbg !118
  %48 = insertelement <4 x i16> %46, i16 %47, i64 2, !dbg !127
  %49 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul331.3), !dbg !118
  %50 = insertelement <4 x i16> %48, i16 %49, i64 3, !dbg !127
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %50 to <4 x half>, !dbg !127
  fence syncscope("warp") release, !dbg !128
  tail call void @llvm.mxc.barrier.warp(), !dbg !131
  fence syncscope("warp") acquire, !dbg !132
  br label %if.end349, !dbg !133

if.end349:                                        ; preds = %entry, %if.end291
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ %acc_s_cast.sroa.0.6.vec.insert, %if.end291 ], [ undef, %entry ]
  %cmp369.not = icmp ugt i32 %arrayidx14.val, %.pre
  %or.cond660 = or i1 %or.cond, %cmp369.not, !dbg !134
  br i1 %or.cond660, label %if.end419, label %for.cond371.preheader, !dbg !134

for.cond371.preheader:                            ; preds = %if.end349
  %51 = shl nuw nsw i32 %1, 4
  %mul381 = and i32 %51, 16128
  %and387 = and i32 %1, 15
  %add388 = or disjoint i32 %mul381, %and387, !dbg !135
  %arrayidx390 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388, !dbg !136
  %52 = load half, ptr addrspace(3) %arrayidx390, align 2, !dbg !137, !tbaa !74
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %52, i64 0, !dbg !137
  %add383.1 = or disjoint i32 %mul381, %and387, !dbg !135
  %add388.1 = or disjoint i32 %add383.1, 64, !dbg !135
  %arrayidx390.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.1, !dbg !136
  %53 = load half, ptr addrspace(3) %arrayidx390.1, align 2, !dbg !137, !tbaa !74
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %53, i64 1, !dbg !137
  %add383.2 = or disjoint i32 %mul381, %and387, !dbg !135
  %add388.2 = or disjoint i32 %add383.2, 128, !dbg !135
  %arrayidx390.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.2, !dbg !136
  %54 = load half, ptr addrspace(3) %arrayidx390.2, align 2, !dbg !137, !tbaa !74
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %54, i64 2, !dbg !137
  %add383.3 = or disjoint i32 %mul381, %and387, !dbg !135
  %add388.3 = or disjoint i32 %add383.3, 192, !dbg !135
  %arrayidx390.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.3, !dbg !136
  %55 = load half, ptr addrspace(3) %arrayidx390.3, align 2, !dbg !137, !tbaa !74
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %55, i64 3, !dbg !137
  %add385.1709 = or disjoint i32 %mul381, %and387, !dbg !135
  %add388.1710 = or disjoint i32 %add385.1709, 16, !dbg !135
  %arrayidx390.1711 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.1710, !dbg !136
  %56 = load half, ptr addrspace(3) %arrayidx390.1711, align 2, !dbg !137, !tbaa !74
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %56, i64 0, !dbg !137
  %add385.1.1 = or disjoint i32 %mul381, %and387, !dbg !135
  %add388.1.1 = or disjoint i32 %add385.1.1, 80, !dbg !135
  %arrayidx390.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.1.1, !dbg !136
  %57 = load half, ptr addrspace(3) %arrayidx390.1.1, align 2, !dbg !137, !tbaa !74
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %57, i64 1, !dbg !137
  %add385.2.1 = or disjoint i32 %mul381, %and387, !dbg !135
  %add388.2.1 = or disjoint i32 %add385.2.1, 144, !dbg !135
  %arrayidx390.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.2.1, !dbg !136
  %58 = load half, ptr addrspace(3) %arrayidx390.2.1, align 2, !dbg !137, !tbaa !74
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %58, i64 2, !dbg !137
  %add385.3.1 = or disjoint i32 %mul381, %and387, !dbg !135
  %add388.3.1 = or disjoint i32 %add385.3.1, 208, !dbg !135
  %arrayidx390.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.3.1, !dbg !136
  %59 = load half, ptr addrspace(3) %arrayidx390.3.1, align 2, !dbg !137, !tbaa !74
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %59, i64 3, !dbg !137
  %add385.2713 = or disjoint i32 %mul381, %and387, !dbg !135
  %add388.2714 = or disjoint i32 %add385.2713, 32, !dbg !135
  %arrayidx390.2715 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.2714, !dbg !136
  %60 = load half, ptr addrspace(3) %arrayidx390.2715, align 2, !dbg !137, !tbaa !74
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %60, i64 0, !dbg !137
  %add385.1.2 = or disjoint i32 %mul381, %and387, !dbg !135
  %add388.1.2 = or disjoint i32 %add385.1.2, 96, !dbg !135
  %arrayidx390.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.1.2, !dbg !136
  %61 = load half, ptr addrspace(3) %arrayidx390.1.2, align 2, !dbg !137, !tbaa !74
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %61, i64 1, !dbg !137
  %add385.2.2 = or disjoint i32 %mul381, %and387, !dbg !135
  %add388.2.2 = or disjoint i32 %add385.2.2, 160, !dbg !135
  %arrayidx390.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.2.2, !dbg !136
  %62 = load half, ptr addrspace(3) %arrayidx390.2.2, align 2, !dbg !137, !tbaa !74
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %62, i64 2, !dbg !137
  %add385.3.2 = or disjoint i32 %mul381, %and387, !dbg !135
  %add388.3.2 = or disjoint i32 %add385.3.2, 224, !dbg !135
  %arrayidx390.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.3.2, !dbg !136
  %63 = load half, ptr addrspace(3) %arrayidx390.3.2, align 2, !dbg !137, !tbaa !74
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %63, i64 3, !dbg !137
  %add385.3717 = or disjoint i32 %mul381, %and387, !dbg !135
  %add388.3718 = or disjoint i32 %add385.3717, 48, !dbg !135
  %arrayidx390.3719 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.3718, !dbg !136
  %64 = load half, ptr addrspace(3) %arrayidx390.3719, align 2, !dbg !137, !tbaa !74
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %64, i64 0, !dbg !137
  %add385.1.3 = or disjoint i32 %mul381, %and387, !dbg !135
  %add388.1.3 = or disjoint i32 %add385.1.3, 112, !dbg !135
  %arrayidx390.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.1.3, !dbg !136
  %65 = load half, ptr addrspace(3) %arrayidx390.1.3, align 2, !dbg !137, !tbaa !74
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %65, i64 1, !dbg !137
  %add385.2.3 = or disjoint i32 %mul381, %and387, !dbg !135
  %add388.2.3 = or disjoint i32 %add385.2.3, 176, !dbg !135
  %arrayidx390.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.2.3, !dbg !136
  %66 = load half, ptr addrspace(3) %arrayidx390.2.3, align 2, !dbg !137, !tbaa !74
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %66, i64 2, !dbg !137
  %add385.3.3 = or disjoint i32 %51, %and387, !dbg !135
  %add388.3.3 = or i32 %add385.3.3, 240, !dbg !135
  %arrayidx390.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add388.3.3, !dbg !136
  %67 = load half, ptr addrspace(3) %arrayidx390.3.3, align 2, !dbg !137, !tbaa !74
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %67, i64 3, !dbg !137
  %68 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !138
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !138
  %70 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !138
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !138
  br label %if.end419, !dbg !139

if.end419:                                        ; preds = %for.cond371.preheader, %if.end349
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end349 ], [ %68, %for.cond371.preheader ], !dbg !109
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end349 ], [ %69, %for.cond371.preheader ], !dbg !109
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end349 ], [ %70, %for.cond371.preheader ], !dbg !109
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end349 ], [ %71, %for.cond371.preheader ], !dbg !109
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0, !dbg !140
  %72 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract), !dbg !141
  %O_reg.sroa.0.0.insert.ext = zext i16 %72 to i64, !dbg !145
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1, !dbg !140
  %73 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract), !dbg !141
  %O_reg.sroa.0.2.insert.ext = zext i16 %73 to i64, !dbg !145
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !145
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !145
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2, !dbg !140
  %74 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract), !dbg !141
  %O_reg.sroa.0.4.insert.ext = zext i16 %74 to i64, !dbg !145
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !145
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !145
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3, !dbg !140
  %75 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract), !dbg !141
  %O_reg.sroa.0.6.insert.ext = zext i16 %75 to i64, !dbg !145
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !145
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !145
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0, !dbg !140
  %76 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract), !dbg !141
  %O_reg.sroa.7.8.insert.ext = zext i16 %76 to i64, !dbg !145
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1, !dbg !140
  %77 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract), !dbg !141
  %O_reg.sroa.7.10.insert.ext = zext i16 %77 to i64, !dbg !145
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !145
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !145
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2, !dbg !140
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract), !dbg !141
  %O_reg.sroa.7.12.insert.ext = zext i16 %78 to i64, !dbg !145
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !145
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !145
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3, !dbg !140
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract), !dbg !141
  %O_reg.sroa.7.14.insert.ext = zext i16 %79 to i64, !dbg !145
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !145
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !145
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0, !dbg !140
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract), !dbg !141
  %O_reg.sroa.12.16.insert.ext = zext i16 %80 to i64, !dbg !145
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1, !dbg !140
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract), !dbg !141
  %O_reg.sroa.12.18.insert.ext = zext i16 %81 to i64, !dbg !145
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !145
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !145
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2, !dbg !140
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract), !dbg !141
  %O_reg.sroa.12.20.insert.ext = zext i16 %82 to i64, !dbg !145
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !145
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !145
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3, !dbg !140
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract), !dbg !141
  %O_reg.sroa.12.22.insert.ext = zext i16 %83 to i64, !dbg !145
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !145
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !145
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0, !dbg !140
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract), !dbg !141
  %O_reg.sroa.17.24.insert.ext = zext i16 %84 to i64, !dbg !145
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1, !dbg !140
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract), !dbg !141
  %O_reg.sroa.17.26.insert.ext = zext i16 %85 to i64, !dbg !145
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !145
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !145
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2, !dbg !140
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract), !dbg !141
  %O_reg.sroa.17.28.insert.ext = zext i16 %86 to i64, !dbg !145
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !145
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !145
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3, !dbg !140
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract), !dbg !141
  %O_reg.sroa.17.30.insert.ext = zext i16 %87 to i64, !dbg !145
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !145
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !145
  fence syncscope("warp") release, !dbg !146
  tail call void @llvm.mxc.barrier.warp(), !dbg !149
  fence syncscope("warp") acquire, !dbg !150
  %and452 = shl nuw nsw i32 %1, 6
  %mul453 = and i32 %and452, 960
  %shr456 = lshr i32 %1, 5
  %and459 = and i32 %1, 7
  %88 = lshr i32 %1, 2
  %mul466 = and i32 %88, 4
  %xor460 = xor i32 %shr456, %and459, !dbg !151
  %mul461 = shl nuw nsw i32 %xor460, 3, !dbg !152
  %add462 = add nuw nsw i32 %mul461, %mul453, !dbg !153
  %add467 = or disjoint i32 %add462, %mul466, !dbg !154
  %add.ptr469 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add467, !dbg !155
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr469, align 8, !dbg !156
  %add457.1 = add nuw nsw i32 %shr456, 2, !dbg !157
  %xor460.1 = xor i32 %add457.1, %and459, !dbg !151
  %mul461.1 = shl nuw nsw i32 %xor460.1, 3, !dbg !152
  %add462.1 = add nuw nsw i32 %mul461.1, %mul453, !dbg !153
  %add467.1 = or disjoint i32 %add462.1, %mul466, !dbg !154
  %add.ptr469.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add467.1, !dbg !155
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr469.1, align 8, !dbg !156
  %add457.2 = add nuw nsw i32 %shr456, 4, !dbg !157
  %xor460.2 = xor i32 %add457.2, %and459, !dbg !151
  %mul461.2 = shl nuw nsw i32 %xor460.2, 3, !dbg !152
  %add462.2 = add nuw nsw i32 %mul461.2, %mul453, !dbg !153
  %add467.2 = or disjoint i32 %add462.2, %mul466, !dbg !154
  %add.ptr469.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add467.2, !dbg !155
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr469.2, align 8, !dbg !156
  %add457.3 = add nuw nsw i32 %shr456, 6, !dbg !157
  %xor460.3 = xor i32 %add457.3, %and459, !dbg !151
  %mul461.3 = shl nuw nsw i32 %xor460.3, 3, !dbg !152
  %add462.3 = add nuw nsw i32 %mul461.3, %mul453, !dbg !153
  %add467.3 = or disjoint i32 %add462.3, %mul466, !dbg !154
  %add.ptr469.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add467.3, !dbg !155
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr469.3, align 8, !dbg !156
  fence syncscope("warp") release, !dbg !158
  tail call void @llvm.mxc.barrier.warp(), !dbg !161
  fence syncscope("warp") acquire, !dbg !162
  %mul480 = and i32 %mul8, 8128
  %xor486610 = and i32 %mul8, 56
  %call484.masked = and i32 %1, 1016
  %mul487 = xor i32 %xor486610, %call484.masked
  %invariant.gep655 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul480, !dbg !163
  %invariant.gep657 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep655, i32 %mul487, !dbg !163
  %add.ptr499 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %2, !dbg !164
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr499, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep657, i64 16, i1 false), !dbg !165, !tbaa.struct !166, !call_argsrelate !167
  %gep658.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep657, i32 1024, !dbg !168
  %add.ptr499.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3, !dbg !164
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr499.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep658.1, i64 16, i1 false), !dbg !165, !tbaa.struct !166, !call_argsrelate !167
  ret void, !dbg !169
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
!1 = !DIFile(filename: "/tmp/tmpawpp8juv/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpawpp8juv/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 28, column: 3, scope: !40)
!44 = !DILocation(line: 29, column: 92, scope: !40)
!45 = !DILocation(line: 31, column: 33, scope: !40)
!46 = !DILocation(line: 31, column: 25, scope: !40)
!47 = !DILocation(line: 37, column: 31, scope: !40)
!48 = !DILocation(line: 29, column: 48, scope: !40)
!49 = !DILocation(line: 40, column: 5, scope: !40)
!50 = !DILocation(line: 44, column: 72, scope: !40)
!51 = !DILocation(line: 53, column: 72, scope: !40)
!52 = !DILocation(line: 58, column: 5, scope: !40)
!53 = !DILocation(line: 59, column: 159, scope: !40)
!54 = !{i32 1, i32 3, i32 -1, i32 -1}
!55 = !DILocation(line: 59, column: 42, scope: !40)
!56 = !DILocation(line: 68, column: 3, scope: !57, inlinedAt: !59)
!57 = distinct !DISubprogram(name: "__barrier_warp", scope: !58, file: !58, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!58 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!59 = distinct !DILocation(line: 192, column: 3, scope: !60, inlinedAt: !61)
!60 = distinct !DISubprogram(name: "__syncwarp", scope: !58, file: !58, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!61 = distinct !DILocation(line: 61, column: 5, scope: !40)
!62 = !DILocation(line: 69, column: 3, scope: !57, inlinedAt: !59)
!63 = !DILocation(line: 70, column: 3, scope: !57, inlinedAt: !59)
!64 = !DILocation(line: 64, column: 153, scope: !40)
!65 = !DILocation(line: 64, column: 73, scope: !40)
!66 = !DILocation(line: 64, column: 36, scope: !40)
!67 = !DILocation(line: 64, column: 124, scope: !40)
!68 = !DILocation(line: 68, column: 3, scope: !57, inlinedAt: !69)
!69 = distinct !DILocation(line: 192, column: 3, scope: !60, inlinedAt: !70)
!70 = distinct !DILocation(line: 66, column: 5, scope: !40)
!71 = !DILocation(line: 69, column: 3, scope: !57, inlinedAt: !69)
!72 = !DILocation(line: 70, column: 3, scope: !57, inlinedAt: !69)
!73 = !DILocation(line: 44, column: 64, scope: !40)
!74 = !{!26, !26, i64 0}
!75 = !DILocation(line: 69, column: 159, scope: !40)
!76 = !DILocation(line: 68, column: 3, scope: !57, inlinedAt: !77)
!77 = distinct !DILocation(line: 192, column: 3, scope: !60, inlinedAt: !78)
!78 = distinct !DILocation(line: 73, column: 5, scope: !40)
!79 = !DILocation(line: 69, column: 3, scope: !57, inlinedAt: !77)
!80 = !DILocation(line: 70, column: 3, scope: !57, inlinedAt: !77)
!81 = !DILocation(line: 75, column: 25, scope: !40)
!82 = !DILocation(line: 78, column: 36, scope: !40)
!83 = !DILocation(line: 68, column: 3, scope: !57, inlinedAt: !84)
!84 = distinct !DILocation(line: 192, column: 3, scope: !60, inlinedAt: !85)
!85 = distinct !DILocation(line: 84, column: 5, scope: !40)
!86 = !DILocation(line: 69, column: 3, scope: !57, inlinedAt: !84)
!87 = !DILocation(line: 70, column: 3, scope: !57, inlinedAt: !84)
!88 = !DILocation(line: 86, column: 10, scope: !40)
!89 = !DILocation(line: 53, column: 64, scope: !40)
!90 = !DILocation(line: 87, column: 86, scope: !40)
!91 = !DILocation(line: 87, column: 42, scope: !40)
!92 = !DILocation(line: 91, column: 30, scope: !40)
!93 = !DILocation(line: 91, column: 41, scope: !40)
!94 = !DILocation(line: 354, column: 10, scope: !95, inlinedAt: !97)
!95 = distinct !DISubprogram(name: "min", scope: !96, file: !96, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!96 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!97 = distinct !DILocation(line: 91, column: 25, scope: !40)
!98 = !DILocation(line: 288, column: 10, scope: !99, inlinedAt: !100)
!99 = distinct !DISubprogram(name: "expf", scope: !96, file: !96, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!100 = distinct !DILocation(line: 91, column: 20, scope: !40)
!101 = !DILocation(line: 91, column: 18, scope: !40)
!102 = !DILocation(line: 93, column: 25, scope: !40)
!103 = !DILocation(line: 93, column: 9, scope: !40)
!104 = !DILocation(line: 97, column: 54, scope: !40)
!105 = !DILocation(line: 97, column: 13, scope: !40)
!106 = !DILocation(line: 102, column: 20, scope: !40)
!107 = !DILocation(line: 97, column: 47, scope: !40)
!108 = !DILocation(line: 107, column: 5, scope: !40)
!109 = !DILocation(line: 0, scope: !40)
!110 = !DILocation(line: 108, column: 36, scope: !40)
!111 = !DILocation(line: 108, column: 34, scope: !40)
!112 = !DILocation(line: 113, column: 42, scope: !40)
!113 = !DILocation(line: 118, column: 36, scope: !40)
!114 = !DILocation(line: 118, column: 34, scope: !40)
!115 = !DILocation(line: 118, column: 9, scope: !40)
!116 = !DILocation(line: 126, column: 32, scope: !40)
!117 = !DILocation(line: 126, column: 21, scope: !40)
!118 = !DILocation(line: 75, column: 10, scope: !119, inlinedAt: !121)
!119 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !120, file: !120, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!120 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!121 = distinct !DILocation(line: 984, column: 9, scope: !122, inlinedAt: !124)
!122 = distinct !DISubprogram(name: "__float2half", scope: !123, file: !123, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!123 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!124 = distinct !DILocation(line: 133, column: 53, scope: !125, inlinedAt: !126)
!125 = distinct !DISubprogram(name: "__half", scope: !123, file: !123, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!126 = distinct !DILocation(line: 130, column: 32, scope: !40)
!127 = !DILocation(line: 130, column: 29, scope: !40)
!128 = !DILocation(line: 68, column: 3, scope: !57, inlinedAt: !129)
!129 = distinct !DILocation(line: 192, column: 3, scope: !60, inlinedAt: !130)
!130 = distinct !DILocation(line: 132, column: 5, scope: !40)
!131 = !DILocation(line: 69, column: 3, scope: !57, inlinedAt: !129)
!132 = !DILocation(line: 70, column: 3, scope: !57, inlinedAt: !129)
!133 = !DILocation(line: 133, column: 3, scope: !40)
!134 = !DILocation(line: 139, column: 31, scope: !40)
!135 = !DILocation(line: 142, column: 119, scope: !40)
!136 = !DILocation(line: 142, column: 31, scope: !40)
!137 = !DILocation(line: 142, column: 29, scope: !40)
!138 = !DILocation(line: 147, column: 38, scope: !40)
!139 = !DILocation(line: 154, column: 3, scope: !40)
!140 = !DILocation(line: 157, column: 58, scope: !40)
!141 = !DILocation(line: 75, column: 10, scope: !119, inlinedAt: !142)
!142 = distinct !DILocation(line: 984, column: 9, scope: !122, inlinedAt: !143)
!143 = distinct !DILocation(line: 133, column: 53, scope: !125, inlinedAt: !144)
!144 = distinct !DILocation(line: 157, column: 50, scope: !40)
!145 = !DILocation(line: 157, column: 47, scope: !40)
!146 = !DILocation(line: 68, column: 3, scope: !57, inlinedAt: !147)
!147 = distinct !DILocation(line: 192, column: 3, scope: !60, inlinedAt: !148)
!148 = distinct !DILocation(line: 160, column: 3, scope: !40)
!149 = !DILocation(line: 69, column: 3, scope: !57, inlinedAt: !147)
!150 = !DILocation(line: 70, column: 3, scope: !57, inlinedAt: !147)
!151 = !DILocation(line: 163, column: 122, scope: !40)
!152 = !DILocation(line: 163, column: 150, scope: !40)
!153 = !DILocation(line: 163, column: 77, scope: !40)
!154 = !DILocation(line: 163, column: 156, scope: !40)
!155 = !DILocation(line: 163, column: 40, scope: !40)
!156 = !DILocation(line: 163, column: 199, scope: !40)
!157 = !DILocation(line: 163, column: 93, scope: !40)
!158 = !DILocation(line: 68, column: 3, scope: !57, inlinedAt: !159)
!159 = distinct !DILocation(line: 192, column: 3, scope: !60, inlinedAt: !160)
!160 = distinct !DILocation(line: 165, column: 3, scope: !40)
!161 = !DILocation(line: 69, column: 3, scope: !57, inlinedAt: !159)
!162 = !DILocation(line: 70, column: 3, scope: !57, inlinedAt: !159)
!163 = !DILocation(line: 167, column: 8, scope: !40)
!164 = !DILocation(line: 168, column: 22, scope: !40)
!165 = !DILocation(line: 168, column: 98, scope: !40)
!166 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!167 = !{i32 2, i32 -1, i32 -1, i32 -1}
!168 = !DILocation(line: 168, column: 135, scope: !40)
!169 = !DILocation(line: 170, column: 1, scope: !40)
