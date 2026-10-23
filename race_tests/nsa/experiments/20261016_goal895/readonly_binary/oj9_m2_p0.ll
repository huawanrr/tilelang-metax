; ModuleID = 'experiments/20261016_goal895/readonly_binary/oj9_m2_p0.bc'
source_filename = "/tmp/tmpw1awpnsz/tvm_kernels.maca"
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
  %cmp29 = icmp ugt i32 %4, 511
  %shr = lshr i32 %0, 4
  %cmp32.not = icmp ugt i32 %4, %shr
  %or.cond = or i1 %cmp29, %cmp32.not, !dbg !46
  br i1 %or.cond, label %if.end348, label %for.cond35.preheader, !dbg !46

for.cond35.preheader:                             ; preds = %entry
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !47
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %2, !dbg !47
  %mul49 = shl nuw nsw i32 %4, 10
  %add51 = add nuw nsw i32 %mul49, %mul8
  %5 = zext nneg i32 %add51 to i64, !dbg !48
  %arrayidx59 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %5, !dbg !49
  %6 = or disjoint i64 %5, 2
  %arrayidx59.1671 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %6, !dbg !49
  %7 = or disjoint i64 %5, 4
  %arrayidx59.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %7, !dbg !49
  %8 = or disjoint i64 %5, 6
  %arrayidx59.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %8, !dbg !49
  %9 = add nuw nsw i64 %5, 512
  %arrayidx59.1678 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %9, !dbg !49
  %10 = add nuw nsw i64 %5, 514
  %arrayidx59.1671.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %10, !dbg !49
  %11 = add nuw nsw i64 %5, 516
  %arrayidx59.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %11, !dbg !49
  %12 = add nuw nsw i64 %5, 518
  %arrayidx59.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %12, !dbg !49
  %arrayidx99 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %5, !dbg !50
  %arrayidx99.1692 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %6, !dbg !50
  %arrayidx99.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %7, !dbg !50
  %arrayidx99.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %8, !dbg !50
  %arrayidx99.1699 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %9, !dbg !50
  %arrayidx99.1692.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %10, !dbg !50
  %arrayidx99.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %11, !dbg !50
  %arrayidx99.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %12, !dbg !50
  %mul128 = and i32 %mul8, 8128
  %xor613 = and i32 %mul8, 56
  %call131.masked = and i32 %1, 1016
  %mul133 = xor i32 %xor613, %call131.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul128, !dbg !51
  %invariant.gep625 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul133, !dbg !51
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep625, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !dbg !52, !call_argsrelate !53
  %gep626.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep625, i32 1024, !dbg !54
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep626.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !dbg !52, !call_argsrelate !53
  fence syncscope("warp") release, !dbg !55
  tail call void @llvm.mxc.barrier.warp(), !dbg !61
  fence syncscope("warp") acquire, !dbg !62
  %and145 = shl nuw nsw i32 %1, 6
  %mul146 = and i32 %and145, 960
  %shr149 = lshr i32 %1, 4
  %and152 = and i32 %1, 7
  %13 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul146
  %xor153 = xor i32 %shr149, %and152, !dbg !63
  %add.ptr157.idx = shl nuw nsw i32 %xor153, 4, !dbg !64
  %add.ptr157 = getelementptr inbounds i8, ptr addrspace(3) %13, i32 %add.ptr157.idx, !dbg !64
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr157, align 16, !dbg !65
  %Q_reg.sroa.4.0.add.ptr157.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157, i32 8, !dbg !65
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr157.sroa_idx, align 8, !dbg !65
  %add150.1 = add nuw nsw i32 %shr149, 4, !dbg !66
  %xor153.1 = xor i32 %add150.1, %and152, !dbg !63
  %add.ptr157.idx.1 = shl nuw nsw i32 %xor153.1, 4, !dbg !64
  %add.ptr157.1 = getelementptr inbounds i8, ptr addrspace(3) %13, i32 %add.ptr157.idx.1, !dbg !64
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr157.1, align 16, !dbg !65
  %Q_reg.sroa.7.16.add.ptr157.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.1, i32 8, !dbg !65
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr157.1.sroa_idx, align 8, !dbg !65
  fence syncscope("warp") release, !dbg !67
  tail call void @llvm.mxc.barrier.warp(), !dbg !70
  fence syncscope("warp") acquire, !dbg !71
  %14 = load <2 x i16>, ptr addrspace(4) %arrayidx59, align 2, !dbg !72, !tbaa !73
  store <2 x i16> %14, ptr addrspace(3) %invariant.gep625, align 16, !dbg !74
  %K_reg.sroa.5.0.invariant.gep630.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep625, i32 4, !dbg !74
  %15 = load <2 x i16>, ptr addrspace(4) %arrayidx59.1671, align 2, !dbg !72, !tbaa !73
  store <2 x i16> %15, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep630.sroa_idx, align 4, !dbg !74
  %K_reg.sroa.7.0.invariant.gep630.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep625, i32 8, !dbg !74
  %16 = load <2 x i16>, ptr addrspace(4) %arrayidx59.2, align 2, !dbg !72, !tbaa !73
  store <2 x i16> %16, ptr addrspace(3) %K_reg.sroa.7.0.invariant.gep630.sroa_idx, align 8, !dbg !74
  %K_reg.sroa.9.0.invariant.gep630.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep625, i32 12, !dbg !74
  %17 = load <2 x i16>, ptr addrspace(4) %arrayidx59.3, align 2, !dbg !72, !tbaa !73
  store <2 x i16> %17, ptr addrspace(3) %K_reg.sroa.9.0.invariant.gep630.sroa_idx, align 4, !dbg !74
  %18 = load <2 x i16>, ptr addrspace(4) %arrayidx59.1678, align 2, !dbg !72, !tbaa !73
  store <2 x i16> %18, ptr addrspace(3) %gep626.1, align 16, !dbg !74
  %K_reg.sroa.14.16.gep631.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep625, i32 1028, !dbg !74
  %19 = load <2 x i16>, ptr addrspace(4) %arrayidx59.1671.1, align 2, !dbg !72, !tbaa !73
  store <2 x i16> %19, ptr addrspace(3) %K_reg.sroa.14.16.gep631.1.sroa_idx, align 4, !dbg !74
  %K_reg.sroa.16.16.gep631.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep625, i32 1032, !dbg !74
  %20 = load <2 x i16>, ptr addrspace(4) %arrayidx59.2.1, align 2, !dbg !72, !tbaa !73
  store <2 x i16> %20, ptr addrspace(3) %K_reg.sroa.16.16.gep631.1.sroa_idx, align 8, !dbg !74
  %K_reg.sroa.18.16.gep631.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep625, i32 1036, !dbg !74
  %21 = load <2 x i16>, ptr addrspace(4) %arrayidx59.3.1, align 2, !dbg !72, !tbaa !73
  store <2 x i16> %21, ptr addrspace(3) %K_reg.sroa.18.16.gep631.1.sroa_idx, align 4, !dbg !74
  fence syncscope("warp") release, !dbg !75
  tail call void @llvm.mxc.barrier.warp(), !dbg !78
  fence syncscope("warp") acquire, !dbg !79
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr157, align 16, !dbg !80
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr157.sroa_idx, align 8, !dbg !80
  %22 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !81
  %23 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %22), !dbg !81
  %kb.sroa.0.0.copyload734 = load <4 x half>, ptr addrspace(3) %add.ptr157.1, align 16, !dbg !80
  %kb.sroa.6.0.copyload735 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr157.1.sroa_idx, align 8, !dbg !80
  %24 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload734, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %23), !dbg !81
  %25 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload735, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %24), !dbg !81
  fence syncscope("warp") release, !dbg !82
  tail call void @llvm.mxc.barrier.warp(), !dbg !85
  fence syncscope("warp") acquire, !dbg !86
  %add.ptr249.idx = shl nuw nsw i32 %1, 4
  %invariant.gep638 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr249.idx, !dbg !87
  %26 = load <2 x i16>, ptr addrspace(4) %arrayidx99, align 2, !dbg !88, !tbaa !73
  store <2 x i16> %26, ptr addrspace(3) %invariant.gep638, align 16, !dbg !89
  %V_reg.sroa.5.0.invariant.gep638.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep638, i32 4, !dbg !89
  %27 = load <2 x i16>, ptr addrspace(4) %arrayidx99.1692, align 2, !dbg !88, !tbaa !73
  store <2 x i16> %27, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep638.sroa_idx, align 4, !dbg !89
  %V_reg.sroa.7.0.invariant.gep638.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep638, i32 8, !dbg !89
  %28 = load <2 x i16>, ptr addrspace(4) %arrayidx99.2, align 2, !dbg !88, !tbaa !73
  store <2 x i16> %28, ptr addrspace(3) %V_reg.sroa.7.0.invariant.gep638.sroa_idx, align 8, !dbg !89
  %V_reg.sroa.9.0.invariant.gep638.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep638, i32 12, !dbg !89
  %29 = load <2 x i16>, ptr addrspace(4) %arrayidx99.3, align 2, !dbg !88, !tbaa !73
  store <2 x i16> %29, ptr addrspace(3) %V_reg.sroa.9.0.invariant.gep638.sroa_idx, align 4, !dbg !89
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep638, i32 1024, !dbg !90
  %30 = load <2 x i16>, ptr addrspace(4) %arrayidx99.1699, align 2, !dbg !88, !tbaa !73
  store <2 x i16> %30, ptr addrspace(3) %gep.1, align 16, !dbg !89
  %V_reg.sroa.14.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep638, i32 1028, !dbg !89
  %31 = load <2 x i16>, ptr addrspace(4) %arrayidx99.1692.1, align 2, !dbg !88, !tbaa !73
  store <2 x i16> %31, ptr addrspace(3) %V_reg.sroa.14.16.gep.1.sroa_idx, align 4, !dbg !89
  %V_reg.sroa.16.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep638, i32 1032, !dbg !89
  %32 = load <2 x i16>, ptr addrspace(4) %arrayidx99.2.1, align 2, !dbg !88, !tbaa !73
  store <2 x i16> %32, ptr addrspace(3) %V_reg.sroa.16.16.gep.1.sroa_idx, align 8, !dbg !89
  %V_reg.sroa.18.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep638, i32 1036, !dbg !89
  %33 = load <2 x i16>, ptr addrspace(4) %arrayidx99.3.1, align 2, !dbg !88, !tbaa !73
  store <2 x i16> %33, ptr addrspace(3) %V_reg.sroa.18.16.gep.1.sroa_idx, align 4, !dbg !89
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %25, i64 0, !dbg !91
  %mul259 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !92
  %34 = tail call contract noundef float @llvm.minnum.f32(float %mul259, float 0x4024CB5EC0000000), !dbg !93
  %35 = tail call contract noundef float @llvm.exp.f32(float %34), !dbg !97
  %acc_s.sroa.0.0.vec.insert741 = insertelement <4 x float> poison, float %35, i64 0, !dbg !100
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %25, i64 1, !dbg !91
  %mul259.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !92
  %36 = tail call contract noundef float @llvm.minnum.f32(float %mul259.1, float 0x4024CB5EC0000000), !dbg !93
  %37 = tail call contract noundef float @llvm.exp.f32(float %36), !dbg !97
  %acc_s.sroa.0.4.vec.insert756 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert741, float %37, i64 1, !dbg !100
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %25, i64 2, !dbg !91
  %mul259.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !92
  %38 = tail call contract noundef float @llvm.minnum.f32(float %mul259.2, float 0x4024CB5EC0000000), !dbg !93
  %39 = tail call contract noundef float @llvm.exp.f32(float %38), !dbg !97
  %acc_s.sroa.0.8.vec.insert771 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert756, float %39, i64 2, !dbg !100
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %25, i64 3, !dbg !91
  %mul259.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !92
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul259.3, float 0x4024CB5EC0000000), !dbg !93
  %41 = tail call contract noundef float @llvm.exp.f32(float %40), !dbg !97
  %acc_s.sroa.0.12.vec.insert786 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert771, float %41, i64 3, !dbg !100
  %cmp269 = icmp eq i32 %4, %shr, !dbg !101
  br i1 %cmp269, label %for.cond271.preheader, label %if.end290, !dbg !102

for.cond271.preheader:                            ; preds = %for.cond35.preheader
  %42 = lshr i32 %1, 2
  %mul277 = and i32 %42, 252
  %and280 = and i32 %0, 15
  %cmp281.not = icmp ugt i32 %mul277, %and280, !dbg !103
  %spec.select = select i1 %cmp281.not, float 0.000000e+00, float %35, !dbg !104
  %acc_s.sroa.0.0.vec.insert745 = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !105
  %cmp281.not.1.not = icmp ult i32 %mul277, %and280, !dbg !103
  %condval.0.1 = select i1 %cmp281.not.1.not, float %37, float 0.000000e+00, !dbg !104
  %acc_s.sroa.0.4.vec.insert760 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert745, float %condval.0.1, i64 1, !dbg !105
  %add278.2 = or disjoint i32 %mul277, 2, !dbg !106
  %cmp281.not.2 = icmp ugt i32 %add278.2, %and280, !dbg !103
  %condval.0.2 = select i1 %cmp281.not.2, float 0.000000e+00, float %39, !dbg !104
  %acc_s.sroa.0.8.vec.insert775 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert760, float %condval.0.2, i64 2, !dbg !105
  %add278.3 = or i32 %42, 3, !dbg !106
  %cmp281.not.3 = icmp ugt i32 %add278.3, %and280, !dbg !103
  %condval.0.3 = select i1 %cmp281.not.3, float 0.000000e+00, float %41, !dbg !104
  %acc_s.sroa.0.12.vec.insert790 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert775, float %condval.0.3, i64 3, !dbg !105
  br label %if.end290, !dbg !107

if.end290:                                        ; preds = %for.cond271.preheader, %for.cond35.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert790, %for.cond271.preheader ], [ %acc_s.sroa.0.12.vec.insert786, %for.cond35.preheader ], !dbg !108
  %acc_s.sroa.0.0.vec.extract747 = extractelement <4 x float> %acc_s.sroa.0.0, i64 0, !dbg !109
  %add299 = fadd contract float %acc_s.sroa.0.0.vec.extract747, 0.000000e+00, !dbg !110
  %acc_s.sroa.0.4.vec.extract762 = extractelement <4 x float> %acc_s.sroa.0.0, i64 1, !dbg !109
  %add299.1 = fadd contract float %add299, %acc_s.sroa.0.4.vec.extract762, !dbg !110
  %acc_s.sroa.0.8.vec.extract777 = extractelement <4 x float> %acc_s.sroa.0.0, i64 2, !dbg !109
  %add299.2 = fadd contract float %add299.1, %acc_s.sroa.0.8.vec.extract777, !dbg !110
  %acc_s.sroa.0.12.vec.extract792 = extractelement <4 x float> %acc_s.sroa.0.0, i64 3, !dbg !109
  %add299.3 = fadd contract float %add299.2, %acc_s.sroa.0.12.vec.extract792, !dbg !110
  %43 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add299.3, <4 x float> zeroinitializer), !dbg !111
  %wsum_output.sroa.0.0.vec.extract = extractelement <4 x float> %43, i64 0, !dbg !112
  %cmp317 = fcmp contract ogt float %wsum_output.sroa.0.0.vec.extract, 0.000000e+00, !dbg !113
  %div = fdiv contract float 1.000000e+00, %wsum_output.sroa.0.0.vec.extract, !dbg !114
  %condval_1.0 = select i1 %cmp317, float %div, float 0.000000e+00, !dbg !114
  %mul330 = fmul contract float %condval_1.0, %acc_s.sroa.0.0.vec.extract747, !dbg !115
  %acc_s.sroa.0.4.vec.extract764 = extractelement <4 x float> %acc_s.sroa.0.0, i64 1, !dbg !116
  %mul330.1 = fmul contract float %condval_1.0, %acc_s.sroa.0.4.vec.extract764, !dbg !115
  %acc_s.sroa.0.8.vec.extract779 = extractelement <4 x float> %acc_s.sroa.0.0, i64 2, !dbg !116
  %mul330.2 = fmul contract float %condval_1.0, %acc_s.sroa.0.8.vec.extract779, !dbg !115
  %acc_s.sroa.0.12.vec.extract794 = extractelement <4 x float> %acc_s.sroa.0.0, i64 3, !dbg !116
  %mul330.3 = fmul contract float %condval_1.0, %acc_s.sroa.0.12.vec.extract794, !dbg !115
  %44 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul330), !dbg !117
  %45 = insertelement <4 x i16> poison, i16 %44, i64 0, !dbg !126
  %46 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul330.1), !dbg !117
  %47 = insertelement <4 x i16> %45, i16 %46, i64 1, !dbg !126
  %48 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul330.2), !dbg !117
  %49 = insertelement <4 x i16> %47, i16 %48, i64 2, !dbg !126
  %50 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul330.3), !dbg !117
  %51 = insertelement <4 x i16> %49, i16 %50, i64 3, !dbg !126
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %51 to <4 x half>, !dbg !126
  fence syncscope("warp") release, !dbg !127
  tail call void @llvm.mxc.barrier.warp(), !dbg !130
  fence syncscope("warp") acquire, !dbg !131
  br label %if.end348, !dbg !132

if.end348:                                        ; preds = %entry, %if.end290
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ %acc_s_cast.sroa.0.6.vec.insert, %if.end290 ], [ undef, %entry ]
  %cmp364 = icmp ugt i32 %4, 511
  %cmp368.not = icmp ugt i32 %4, %shr
  %or.cond659 = or i1 %cmp364, %cmp368.not, !dbg !133
  br i1 %or.cond659, label %if.end418, label %for.cond370.preheader, !dbg !133

for.cond370.preheader:                            ; preds = %if.end348
  %52 = shl nuw nsw i32 %1, 4
  %mul380 = and i32 %52, 16128
  %and386 = and i32 %1, 15
  %add387 = or disjoint i32 %mul380, %and386, !dbg !134
  %arrayidx389 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387, !dbg !135
  %53 = load half, ptr addrspace(3) %arrayidx389, align 2, !dbg !136, !tbaa !73
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %53, i64 0, !dbg !136
  %add382.1 = or disjoint i32 %mul380, %and386, !dbg !134
  %add387.1 = or disjoint i32 %add382.1, 64, !dbg !134
  %arrayidx389.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387.1, !dbg !135
  %54 = load half, ptr addrspace(3) %arrayidx389.1, align 2, !dbg !136, !tbaa !73
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %54, i64 1, !dbg !136
  %add382.2 = or disjoint i32 %mul380, %and386, !dbg !134
  %add387.2 = or disjoint i32 %add382.2, 128, !dbg !134
  %arrayidx389.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387.2, !dbg !135
  %55 = load half, ptr addrspace(3) %arrayidx389.2, align 2, !dbg !136, !tbaa !73
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %55, i64 2, !dbg !136
  %add382.3 = or disjoint i32 %mul380, %and386, !dbg !134
  %add387.3 = or disjoint i32 %add382.3, 192, !dbg !134
  %arrayidx389.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387.3, !dbg !135
  %56 = load half, ptr addrspace(3) %arrayidx389.3, align 2, !dbg !136, !tbaa !73
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %56, i64 3, !dbg !136
  %add384.1708 = or disjoint i32 %mul380, %and386, !dbg !134
  %add387.1709 = or disjoint i32 %add384.1708, 16, !dbg !134
  %arrayidx389.1710 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387.1709, !dbg !135
  %57 = load half, ptr addrspace(3) %arrayidx389.1710, align 2, !dbg !136, !tbaa !73
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %57, i64 0, !dbg !136
  %add384.1.1 = or disjoint i32 %mul380, %and386, !dbg !134
  %add387.1.1 = or disjoint i32 %add384.1.1, 80, !dbg !134
  %arrayidx389.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387.1.1, !dbg !135
  %58 = load half, ptr addrspace(3) %arrayidx389.1.1, align 2, !dbg !136, !tbaa !73
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %58, i64 1, !dbg !136
  %add384.2.1 = or disjoint i32 %mul380, %and386, !dbg !134
  %add387.2.1 = or disjoint i32 %add384.2.1, 144, !dbg !134
  %arrayidx389.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387.2.1, !dbg !135
  %59 = load half, ptr addrspace(3) %arrayidx389.2.1, align 2, !dbg !136, !tbaa !73
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %59, i64 2, !dbg !136
  %add384.3.1 = or disjoint i32 %mul380, %and386, !dbg !134
  %add387.3.1 = or disjoint i32 %add384.3.1, 208, !dbg !134
  %arrayidx389.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387.3.1, !dbg !135
  %60 = load half, ptr addrspace(3) %arrayidx389.3.1, align 2, !dbg !136, !tbaa !73
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %60, i64 3, !dbg !136
  %add384.2712 = or disjoint i32 %mul380, %and386, !dbg !134
  %add387.2713 = or disjoint i32 %add384.2712, 32, !dbg !134
  %arrayidx389.2714 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387.2713, !dbg !135
  %61 = load half, ptr addrspace(3) %arrayidx389.2714, align 2, !dbg !136, !tbaa !73
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %61, i64 0, !dbg !136
  %add384.1.2 = or disjoint i32 %mul380, %and386, !dbg !134
  %add387.1.2 = or disjoint i32 %add384.1.2, 96, !dbg !134
  %arrayidx389.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387.1.2, !dbg !135
  %62 = load half, ptr addrspace(3) %arrayidx389.1.2, align 2, !dbg !136, !tbaa !73
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %62, i64 1, !dbg !136
  %add384.2.2 = or disjoint i32 %mul380, %and386, !dbg !134
  %add387.2.2 = or disjoint i32 %add384.2.2, 160, !dbg !134
  %arrayidx389.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387.2.2, !dbg !135
  %63 = load half, ptr addrspace(3) %arrayidx389.2.2, align 2, !dbg !136, !tbaa !73
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %63, i64 2, !dbg !136
  %add384.3.2 = or disjoint i32 %mul380, %and386, !dbg !134
  %add387.3.2 = or disjoint i32 %add384.3.2, 224, !dbg !134
  %arrayidx389.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387.3.2, !dbg !135
  %64 = load half, ptr addrspace(3) %arrayidx389.3.2, align 2, !dbg !136, !tbaa !73
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %64, i64 3, !dbg !136
  %add384.3716 = or disjoint i32 %mul380, %and386, !dbg !134
  %add387.3717 = or disjoint i32 %add384.3716, 48, !dbg !134
  %arrayidx389.3718 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387.3717, !dbg !135
  %65 = load half, ptr addrspace(3) %arrayidx389.3718, align 2, !dbg !136, !tbaa !73
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %65, i64 0, !dbg !136
  %add384.1.3 = or disjoint i32 %mul380, %and386, !dbg !134
  %add387.1.3 = or disjoint i32 %add384.1.3, 112, !dbg !134
  %arrayidx389.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387.1.3, !dbg !135
  %66 = load half, ptr addrspace(3) %arrayidx389.1.3, align 2, !dbg !136, !tbaa !73
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %66, i64 1, !dbg !136
  %add384.2.3 = or disjoint i32 %mul380, %and386, !dbg !134
  %add387.2.3 = or disjoint i32 %add384.2.3, 176, !dbg !134
  %arrayidx389.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387.2.3, !dbg !135
  %67 = load half, ptr addrspace(3) %arrayidx389.2.3, align 2, !dbg !136, !tbaa !73
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %67, i64 2, !dbg !136
  %add384.3.3 = or disjoint i32 %52, %and386, !dbg !134
  %add387.3.3 = or i32 %add384.3.3, 240, !dbg !134
  %arrayidx389.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add387.3.3, !dbg !135
  %68 = load half, ptr addrspace(3) %arrayidx389.3.3, align 2, !dbg !136, !tbaa !73
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %68, i64 3, !dbg !136
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !137
  %70 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !137
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !137
  %72 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !137
  br label %if.end418, !dbg !138

if.end418:                                        ; preds = %for.cond370.preheader, %if.end348
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end348 ], [ %69, %for.cond370.preheader ], !dbg !108
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end348 ], [ %70, %for.cond370.preheader ], !dbg !108
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end348 ], [ %71, %for.cond370.preheader ], !dbg !108
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end348 ], [ %72, %for.cond370.preheader ], !dbg !108
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0, !dbg !139
  %73 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract), !dbg !140
  %O_reg.sroa.0.0.insert.ext = zext i16 %73 to i64, !dbg !144
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1, !dbg !139
  %74 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract), !dbg !140
  %O_reg.sroa.0.2.insert.ext = zext i16 %74 to i64, !dbg !144
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !144
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !144
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2, !dbg !139
  %75 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract), !dbg !140
  %O_reg.sroa.0.4.insert.ext = zext i16 %75 to i64, !dbg !144
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !144
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !144
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3, !dbg !139
  %76 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract), !dbg !140
  %O_reg.sroa.0.6.insert.ext = zext i16 %76 to i64, !dbg !144
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !144
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !144
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0, !dbg !139
  %77 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract), !dbg !140
  %O_reg.sroa.7.8.insert.ext = zext i16 %77 to i64, !dbg !144
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1, !dbg !139
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract), !dbg !140
  %O_reg.sroa.7.10.insert.ext = zext i16 %78 to i64, !dbg !144
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !144
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !144
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2, !dbg !139
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract), !dbg !140
  %O_reg.sroa.7.12.insert.ext = zext i16 %79 to i64, !dbg !144
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !144
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !144
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3, !dbg !139
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract), !dbg !140
  %O_reg.sroa.7.14.insert.ext = zext i16 %80 to i64, !dbg !144
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !144
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !144
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0, !dbg !139
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract), !dbg !140
  %O_reg.sroa.12.16.insert.ext = zext i16 %81 to i64, !dbg !144
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1, !dbg !139
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract), !dbg !140
  %O_reg.sroa.12.18.insert.ext = zext i16 %82 to i64, !dbg !144
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !144
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !144
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2, !dbg !139
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract), !dbg !140
  %O_reg.sroa.12.20.insert.ext = zext i16 %83 to i64, !dbg !144
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !144
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !144
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3, !dbg !139
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract), !dbg !140
  %O_reg.sroa.12.22.insert.ext = zext i16 %84 to i64, !dbg !144
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !144
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !144
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0, !dbg !139
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract), !dbg !140
  %O_reg.sroa.17.24.insert.ext = zext i16 %85 to i64, !dbg !144
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1, !dbg !139
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract), !dbg !140
  %O_reg.sroa.17.26.insert.ext = zext i16 %86 to i64, !dbg !144
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !144
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !144
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2, !dbg !139
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract), !dbg !140
  %O_reg.sroa.17.28.insert.ext = zext i16 %87 to i64, !dbg !144
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !144
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !144
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3, !dbg !139
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract), !dbg !140
  %O_reg.sroa.17.30.insert.ext = zext i16 %88 to i64, !dbg !144
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !144
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !144
  fence syncscope("warp") release, !dbg !145
  tail call void @llvm.mxc.barrier.warp(), !dbg !148
  fence syncscope("warp") acquire, !dbg !149
  %and451 = shl nuw nsw i32 %1, 6
  %mul452 = and i32 %and451, 960
  %shr455 = lshr i32 %1, 5
  %and458 = and i32 %1, 7
  %89 = lshr i32 %1, 2
  %mul465 = and i32 %89, 4
  %xor459 = xor i32 %shr455, %and458, !dbg !150
  %mul460 = shl nuw nsw i32 %xor459, 3, !dbg !151
  %add461 = add nuw nsw i32 %mul460, %mul452, !dbg !152
  %add466 = or disjoint i32 %add461, %mul465, !dbg !153
  %add.ptr468 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466, !dbg !154
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr468, align 8, !dbg !155
  %add456.1 = add nuw nsw i32 %shr455, 2, !dbg !156
  %xor459.1 = xor i32 %add456.1, %and458, !dbg !150
  %mul460.1 = shl nuw nsw i32 %xor459.1, 3, !dbg !151
  %add461.1 = add nuw nsw i32 %mul460.1, %mul452, !dbg !152
  %add466.1 = or disjoint i32 %add461.1, %mul465, !dbg !153
  %add.ptr468.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.1, !dbg !154
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr468.1, align 8, !dbg !155
  %add456.2 = add nuw nsw i32 %shr455, 4, !dbg !156
  %xor459.2 = xor i32 %add456.2, %and458, !dbg !150
  %mul460.2 = shl nuw nsw i32 %xor459.2, 3, !dbg !151
  %add461.2 = add nuw nsw i32 %mul460.2, %mul452, !dbg !152
  %add466.2 = or disjoint i32 %add461.2, %mul465, !dbg !153
  %add.ptr468.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.2, !dbg !154
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr468.2, align 8, !dbg !155
  %add456.3 = add nuw nsw i32 %shr455, 6, !dbg !156
  %xor459.3 = xor i32 %add456.3, %and458, !dbg !150
  %mul460.3 = shl nuw nsw i32 %xor459.3, 3, !dbg !151
  %add461.3 = add nuw nsw i32 %mul460.3, %mul452, !dbg !152
  %add466.3 = or disjoint i32 %add461.3, %mul465, !dbg !153
  %add.ptr468.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add466.3, !dbg !154
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr468.3, align 8, !dbg !155
  fence syncscope("warp") release, !dbg !157
  tail call void @llvm.mxc.barrier.warp(), !dbg !160
  fence syncscope("warp") acquire, !dbg !161
  %mul479 = and i32 %mul8, 8128
  %xor485609 = and i32 %mul8, 56
  %call483.masked = and i32 %1, 1016
  %mul486 = xor i32 %xor485609, %call483.masked
  %invariant.gep653 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul479, !dbg !162
  %invariant.gep655 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep653, i32 %mul486, !dbg !162
  %add.ptr498 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %2, !dbg !163
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr498, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep655, i64 16, i1 false), !dbg !164, !tbaa.struct !165, !call_argsrelate !166
  %gep656.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep655, i32 1024, !dbg !167
  %add.ptr498.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3, !dbg !163
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr498.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep656.1, i64 16, i1 false), !dbg !164, !tbaa.struct !165, !call_argsrelate !166
  ret void, !dbg !168
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
!1 = !DIFile(filename: "/tmp/tmpw1awpnsz/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpw1awpnsz/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 28, column: 3, scope: !40)
!44 = !DILocation(line: 29, column: 92, scope: !40)
!45 = !DILocation(line: 31, column: 25, scope: !40)
!46 = !DILocation(line: 37, column: 31, scope: !40)
!47 = !DILocation(line: 29, column: 48, scope: !40)
!48 = !DILocation(line: 40, column: 5, scope: !40)
!49 = !DILocation(line: 44, column: 72, scope: !40)
!50 = !DILocation(line: 53, column: 72, scope: !40)
!51 = !DILocation(line: 58, column: 5, scope: !40)
!52 = !DILocation(line: 59, column: 159, scope: !40)
!53 = !{i32 1, i32 3, i32 -1, i32 -1}
!54 = !DILocation(line: 59, column: 42, scope: !40)
!55 = !DILocation(line: 68, column: 3, scope: !56, inlinedAt: !58)
!56 = distinct !DISubprogram(name: "__barrier_warp", scope: !57, file: !57, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!57 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!58 = distinct !DILocation(line: 192, column: 3, scope: !59, inlinedAt: !60)
!59 = distinct !DISubprogram(name: "__syncwarp", scope: !57, file: !57, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!60 = distinct !DILocation(line: 61, column: 5, scope: !40)
!61 = !DILocation(line: 69, column: 3, scope: !56, inlinedAt: !58)
!62 = !DILocation(line: 70, column: 3, scope: !56, inlinedAt: !58)
!63 = !DILocation(line: 64, column: 153, scope: !40)
!64 = !DILocation(line: 64, column: 73, scope: !40)
!65 = !DILocation(line: 64, column: 36, scope: !40)
!66 = !DILocation(line: 64, column: 124, scope: !40)
!67 = !DILocation(line: 68, column: 3, scope: !56, inlinedAt: !68)
!68 = distinct !DILocation(line: 192, column: 3, scope: !59, inlinedAt: !69)
!69 = distinct !DILocation(line: 66, column: 5, scope: !40)
!70 = !DILocation(line: 69, column: 3, scope: !56, inlinedAt: !68)
!71 = !DILocation(line: 70, column: 3, scope: !56, inlinedAt: !68)
!72 = !DILocation(line: 44, column: 64, scope: !40)
!73 = !{!26, !26, i64 0}
!74 = !DILocation(line: 69, column: 159, scope: !40)
!75 = !DILocation(line: 68, column: 3, scope: !56, inlinedAt: !76)
!76 = distinct !DILocation(line: 192, column: 3, scope: !59, inlinedAt: !77)
!77 = distinct !DILocation(line: 73, column: 5, scope: !40)
!78 = !DILocation(line: 69, column: 3, scope: !56, inlinedAt: !76)
!79 = !DILocation(line: 70, column: 3, scope: !56, inlinedAt: !76)
!80 = !DILocation(line: 75, column: 25, scope: !40)
!81 = !DILocation(line: 78, column: 36, scope: !40)
!82 = !DILocation(line: 68, column: 3, scope: !56, inlinedAt: !83)
!83 = distinct !DILocation(line: 192, column: 3, scope: !59, inlinedAt: !84)
!84 = distinct !DILocation(line: 84, column: 5, scope: !40)
!85 = !DILocation(line: 69, column: 3, scope: !56, inlinedAt: !83)
!86 = !DILocation(line: 70, column: 3, scope: !56, inlinedAt: !83)
!87 = !DILocation(line: 86, column: 10, scope: !40)
!88 = !DILocation(line: 53, column: 64, scope: !40)
!89 = !DILocation(line: 87, column: 86, scope: !40)
!90 = !DILocation(line: 87, column: 42, scope: !40)
!91 = !DILocation(line: 91, column: 30, scope: !40)
!92 = !DILocation(line: 91, column: 41, scope: !40)
!93 = !DILocation(line: 354, column: 10, scope: !94, inlinedAt: !96)
!94 = distinct !DISubprogram(name: "min", scope: !95, file: !95, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!95 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!96 = distinct !DILocation(line: 91, column: 25, scope: !40)
!97 = !DILocation(line: 288, column: 10, scope: !98, inlinedAt: !99)
!98 = distinct !DISubprogram(name: "expf", scope: !95, file: !95, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!99 = distinct !DILocation(line: 91, column: 20, scope: !40)
!100 = !DILocation(line: 91, column: 18, scope: !40)
!101 = !DILocation(line: 93, column: 25, scope: !40)
!102 = !DILocation(line: 93, column: 9, scope: !40)
!103 = !DILocation(line: 97, column: 54, scope: !40)
!104 = !DILocation(line: 97, column: 13, scope: !40)
!105 = !DILocation(line: 102, column: 20, scope: !40)
!106 = !DILocation(line: 97, column: 47, scope: !40)
!107 = !DILocation(line: 107, column: 5, scope: !40)
!108 = !DILocation(line: 0, scope: !40)
!109 = !DILocation(line: 108, column: 36, scope: !40)
!110 = !DILocation(line: 108, column: 34, scope: !40)
!111 = !DILocation(line: 113, column: 42, scope: !40)
!112 = !DILocation(line: 118, column: 36, scope: !40)
!113 = !DILocation(line: 118, column: 34, scope: !40)
!114 = !DILocation(line: 118, column: 9, scope: !40)
!115 = !DILocation(line: 126, column: 32, scope: !40)
!116 = !DILocation(line: 126, column: 21, scope: !40)
!117 = !DILocation(line: 75, column: 10, scope: !118, inlinedAt: !120)
!118 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !119, file: !119, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!119 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!120 = distinct !DILocation(line: 984, column: 9, scope: !121, inlinedAt: !123)
!121 = distinct !DISubprogram(name: "__float2half", scope: !122, file: !122, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!122 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!123 = distinct !DILocation(line: 133, column: 53, scope: !124, inlinedAt: !125)
!124 = distinct !DISubprogram(name: "__half", scope: !122, file: !122, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!125 = distinct !DILocation(line: 130, column: 32, scope: !40)
!126 = !DILocation(line: 130, column: 29, scope: !40)
!127 = !DILocation(line: 68, column: 3, scope: !56, inlinedAt: !128)
!128 = distinct !DILocation(line: 192, column: 3, scope: !59, inlinedAt: !129)
!129 = distinct !DILocation(line: 132, column: 5, scope: !40)
!130 = !DILocation(line: 69, column: 3, scope: !56, inlinedAt: !128)
!131 = !DILocation(line: 70, column: 3, scope: !56, inlinedAt: !128)
!132 = !DILocation(line: 133, column: 3, scope: !40)
!133 = !DILocation(line: 139, column: 31, scope: !40)
!134 = !DILocation(line: 142, column: 119, scope: !40)
!135 = !DILocation(line: 142, column: 31, scope: !40)
!136 = !DILocation(line: 142, column: 29, scope: !40)
!137 = !DILocation(line: 147, column: 38, scope: !40)
!138 = !DILocation(line: 154, column: 3, scope: !40)
!139 = !DILocation(line: 157, column: 58, scope: !40)
!140 = !DILocation(line: 75, column: 10, scope: !118, inlinedAt: !141)
!141 = distinct !DILocation(line: 984, column: 9, scope: !121, inlinedAt: !142)
!142 = distinct !DILocation(line: 133, column: 53, scope: !124, inlinedAt: !143)
!143 = distinct !DILocation(line: 157, column: 50, scope: !40)
!144 = !DILocation(line: 157, column: 47, scope: !40)
!145 = !DILocation(line: 68, column: 3, scope: !56, inlinedAt: !146)
!146 = distinct !DILocation(line: 192, column: 3, scope: !59, inlinedAt: !147)
!147 = distinct !DILocation(line: 160, column: 3, scope: !40)
!148 = !DILocation(line: 69, column: 3, scope: !56, inlinedAt: !146)
!149 = !DILocation(line: 70, column: 3, scope: !56, inlinedAt: !146)
!150 = !DILocation(line: 163, column: 122, scope: !40)
!151 = !DILocation(line: 163, column: 150, scope: !40)
!152 = !DILocation(line: 163, column: 77, scope: !40)
!153 = !DILocation(line: 163, column: 156, scope: !40)
!154 = !DILocation(line: 163, column: 40, scope: !40)
!155 = !DILocation(line: 163, column: 199, scope: !40)
!156 = !DILocation(line: 163, column: 93, scope: !40)
!157 = !DILocation(line: 68, column: 3, scope: !56, inlinedAt: !158)
!158 = distinct !DILocation(line: 192, column: 3, scope: !59, inlinedAt: !159)
!159 = distinct !DILocation(line: 165, column: 3, scope: !40)
!160 = !DILocation(line: 69, column: 3, scope: !56, inlinedAt: !158)
!161 = !DILocation(line: 70, column: 3, scope: !56, inlinedAt: !158)
!162 = !DILocation(line: 167, column: 8, scope: !40)
!163 = !DILocation(line: 168, column: 22, scope: !40)
!164 = !DILocation(line: 168, column: 98, scope: !40)
!165 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!166 = !{i32 2, i32 -1, i32 -1, i32 -1}
!167 = !DILocation(line: 168, column: 135, scope: !40)
!168 = !DILocation(line: 170, column: 1, scope: !40)
