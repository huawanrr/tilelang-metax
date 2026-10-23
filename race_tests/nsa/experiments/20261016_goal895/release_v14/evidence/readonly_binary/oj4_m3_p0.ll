; ModuleID = 'experiments/20261016_goal895/readonly_binary/oj4_m3_p0.bc'
source_filename = "/tmp/tmp23n9fv3u/tvm_kernels.maca"
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
  %mul = shl nsw i32 %0, 19
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul7 = shl nsw i32 %1, 10
  %add = add nuw nsw i32 %mul, %mul7
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %mul11 = shl nuw nsw i32 %2, 3
  %add9 = add nuw nsw i32 %add, %mul11
  %3 = zext nneg i32 %add9 to i64, !dbg !43
  %4 = add nuw nsw i64 %3, 512, !dbg !44
  %mul17 = shl nsw i32 %0, 9, !dbg !45
  %add19 = add nuw nsw i32 %mul17, %1, !dbg !46
  %idxprom = zext nneg i32 %add19 to i64, !dbg !47
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom, !dbg !47
  %arrayidx.val = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !48, !tbaa !30
  %or.cond = icmp ugt i32 %arrayidx.val, 31, !dbg !49
  %shr = lshr i32 %1, 4
  %cmp38.not = icmp ugt i32 %arrayidx.val, %shr
  %or.cond665 = or i1 %or.cond, %cmp38.not, !dbg !49
  br i1 %or.cond665, label %if.end351, label %if.then, !dbg !49

if.then:                                          ; preds = %entry
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4, !dbg !50
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !50
  %mul56 = shl nsw i32 %0, 15
  %mul57 = shl nuw nsw i32 %arrayidx.val, 10
  %add58 = or disjoint i32 %mul11, %mul56
  %add60 = add nuw nsw i32 %add58, %mul57
  %5 = zext nneg i32 %add60 to i64, !dbg !51
  %arrayidx68 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %5, !dbg !52
  %6 = or disjoint i64 %5, 2
  %arrayidx68.1680 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %6, !dbg !52
  %7 = or disjoint i64 %5, 4
  %arrayidx68.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %7, !dbg !52
  %8 = or disjoint i64 %5, 6
  %arrayidx68.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %8, !dbg !52
  %9 = add nuw nsw i64 %5, 512
  %arrayidx68.1687 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %9, !dbg !52
  %10 = add nuw nsw i64 %5, 514
  %arrayidx68.1680.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %10, !dbg !52
  %11 = add nuw nsw i64 %5, 516
  %arrayidx68.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %11, !dbg !52
  %12 = add nuw nsw i64 %5, 518
  %arrayidx68.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %12, !dbg !52
  %arrayidx111 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %5, !dbg !53
  %arrayidx111.1701 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %6, !dbg !53
  %arrayidx111.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %7, !dbg !53
  %arrayidx111.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %8, !dbg !53
  %arrayidx111.1708 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %9, !dbg !53
  %arrayidx111.1701.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %10, !dbg !53
  %arrayidx111.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %11, !dbg !53
  %arrayidx111.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %12, !dbg !53
  %mul140 = and i32 %mul11, 8128
  %xor615 = and i32 %mul11, 56
  %call143.masked = and i32 %2, 1016
  %mul145 = xor i32 %xor615, %call143.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul140, !dbg !54
  %invariant.gep633 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul145, !dbg !54
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep633, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !dbg !55, !call_argsrelate !56
  %gep634.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep633, i32 1024, !dbg !57
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep634.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !dbg !55, !call_argsrelate !56
  fence syncscope("warp") release, !dbg !58
  tail call void @llvm.mxc.barrier.warp(), !dbg !64
  fence syncscope("warp") acquire, !dbg !65
  %and157 = shl nuw nsw i32 %2, 6
  %mul158 = and i32 %and157, 960
  %shr161 = lshr i32 %2, 4
  %and164 = and i32 %2, 7
  %13 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul158
  %xor165 = xor i32 %shr161, %and164, !dbg !66
  %add.ptr169.idx = shl nuw nsw i32 %xor165, 4, !dbg !67
  %add.ptr169 = getelementptr inbounds i8, ptr addrspace(3) %13, i32 %add.ptr169.idx, !dbg !67
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr169, align 16, !dbg !68
  %Q_reg.sroa.4.0.add.ptr169.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr169, i32 8, !dbg !68
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr169.sroa_idx, align 8, !dbg !68
  %add162.1 = add nuw nsw i32 %shr161, 4, !dbg !69
  %xor165.1 = xor i32 %add162.1, %and164, !dbg !66
  %add.ptr169.idx.1 = shl nuw nsw i32 %xor165.1, 4, !dbg !67
  %add.ptr169.1 = getelementptr inbounds i8, ptr addrspace(3) %13, i32 %add.ptr169.idx.1, !dbg !67
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr169.1, align 16, !dbg !68
  %Q_reg.sroa.7.16.add.ptr169.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr169.1, i32 8, !dbg !68
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr169.1.sroa_idx, align 8, !dbg !68
  fence syncscope("warp") release, !dbg !70
  tail call void @llvm.mxc.barrier.warp(), !dbg !73
  fence syncscope("warp") acquire, !dbg !74
  %14 = load <2 x i16>, ptr addrspace(4) %arrayidx68, align 2, !dbg !75, !tbaa !76
  store <2 x i16> %14, ptr addrspace(3) %invariant.gep633, align 16, !dbg !77
  %K_reg.sroa.5.0.invariant.gep638.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep633, i32 4, !dbg !77
  %15 = load <2 x i16>, ptr addrspace(4) %arrayidx68.1680, align 2, !dbg !75, !tbaa !76
  store <2 x i16> %15, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep638.sroa_idx, align 4, !dbg !77
  %K_reg.sroa.7.0.invariant.gep638.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep633, i32 8, !dbg !77
  %16 = load <2 x i16>, ptr addrspace(4) %arrayidx68.2, align 2, !dbg !75, !tbaa !76
  store <2 x i16> %16, ptr addrspace(3) %K_reg.sroa.7.0.invariant.gep638.sroa_idx, align 8, !dbg !77
  %K_reg.sroa.9.0.invariant.gep638.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep633, i32 12, !dbg !77
  %17 = load <2 x i16>, ptr addrspace(4) %arrayidx68.3, align 2, !dbg !75, !tbaa !76
  store <2 x i16> %17, ptr addrspace(3) %K_reg.sroa.9.0.invariant.gep638.sroa_idx, align 4, !dbg !77
  %18 = load <2 x i16>, ptr addrspace(4) %arrayidx68.1687, align 2, !dbg !75, !tbaa !76
  store <2 x i16> %18, ptr addrspace(3) %gep634.1, align 16, !dbg !77
  %K_reg.sroa.14.16.gep639.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep633, i32 1028, !dbg !77
  %19 = load <2 x i16>, ptr addrspace(4) %arrayidx68.1680.1, align 2, !dbg !75, !tbaa !76
  store <2 x i16> %19, ptr addrspace(3) %K_reg.sroa.14.16.gep639.1.sroa_idx, align 4, !dbg !77
  %K_reg.sroa.16.16.gep639.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep633, i32 1032, !dbg !77
  %20 = load <2 x i16>, ptr addrspace(4) %arrayidx68.2.1, align 2, !dbg !75, !tbaa !76
  store <2 x i16> %20, ptr addrspace(3) %K_reg.sroa.16.16.gep639.1.sroa_idx, align 8, !dbg !77
  %K_reg.sroa.18.16.gep639.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep633, i32 1036, !dbg !77
  %21 = load <2 x i16>, ptr addrspace(4) %arrayidx68.3.1, align 2, !dbg !75, !tbaa !76
  store <2 x i16> %21, ptr addrspace(3) %K_reg.sroa.18.16.gep639.1.sroa_idx, align 4, !dbg !77
  fence syncscope("warp") release, !dbg !78
  tail call void @llvm.mxc.barrier.warp(), !dbg !81
  fence syncscope("warp") acquire, !dbg !82
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr169, align 16, !dbg !83
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr169.sroa_idx, align 8, !dbg !83
  %22 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !84
  %23 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %22), !dbg !84
  %kb.sroa.0.0.copyload743 = load <4 x half>, ptr addrspace(3) %add.ptr169.1, align 16, !dbg !83
  %kb.sroa.6.0.copyload744 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr169.1.sroa_idx, align 8, !dbg !83
  %24 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload743, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %23), !dbg !84
  %25 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload744, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %24), !dbg !84
  fence syncscope("warp") release, !dbg !85
  tail call void @llvm.mxc.barrier.warp(), !dbg !88
  fence syncscope("warp") acquire, !dbg !89
  %add.ptr261.idx = shl nuw nsw i32 %2, 4
  %invariant.gep646 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr261.idx, !dbg !90
  %26 = load <2 x i16>, ptr addrspace(4) %arrayidx111, align 2, !dbg !91, !tbaa !76
  store <2 x i16> %26, ptr addrspace(3) %invariant.gep646, align 16, !dbg !92
  %V_reg.sroa.5.0.invariant.gep646.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep646, i32 4, !dbg !92
  %27 = load <2 x i16>, ptr addrspace(4) %arrayidx111.1701, align 2, !dbg !91, !tbaa !76
  store <2 x i16> %27, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep646.sroa_idx, align 4, !dbg !92
  %V_reg.sroa.7.0.invariant.gep646.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep646, i32 8, !dbg !92
  %28 = load <2 x i16>, ptr addrspace(4) %arrayidx111.2, align 2, !dbg !91, !tbaa !76
  store <2 x i16> %28, ptr addrspace(3) %V_reg.sroa.7.0.invariant.gep646.sroa_idx, align 8, !dbg !92
  %V_reg.sroa.9.0.invariant.gep646.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep646, i32 12, !dbg !92
  %29 = load <2 x i16>, ptr addrspace(4) %arrayidx111.3, align 2, !dbg !91, !tbaa !76
  store <2 x i16> %29, ptr addrspace(3) %V_reg.sroa.9.0.invariant.gep646.sroa_idx, align 4, !dbg !92
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep646, i32 1024, !dbg !93
  %30 = load <2 x i16>, ptr addrspace(4) %arrayidx111.1708, align 2, !dbg !91, !tbaa !76
  store <2 x i16> %30, ptr addrspace(3) %gep.1, align 16, !dbg !92
  %V_reg.sroa.14.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep646, i32 1028, !dbg !92
  %31 = load <2 x i16>, ptr addrspace(4) %arrayidx111.1701.1, align 2, !dbg !91, !tbaa !76
  store <2 x i16> %31, ptr addrspace(3) %V_reg.sroa.14.16.gep.1.sroa_idx, align 4, !dbg !92
  %V_reg.sroa.16.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep646, i32 1032, !dbg !92
  %32 = load <2 x i16>, ptr addrspace(4) %arrayidx111.2.1, align 2, !dbg !91, !tbaa !76
  store <2 x i16> %32, ptr addrspace(3) %V_reg.sroa.16.16.gep.1.sroa_idx, align 8, !dbg !92
  %V_reg.sroa.18.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep646, i32 1036, !dbg !92
  %33 = load <2 x i16>, ptr addrspace(4) %arrayidx111.3.1, align 2, !dbg !91, !tbaa !76
  store <2 x i16> %33, ptr addrspace(3) %V_reg.sroa.18.16.gep.1.sroa_idx, align 4, !dbg !92
  %mul39 = shl nuw nsw i32 %arrayidx.val, 4, !dbg !94
  %shr273 = shl nuw nsw i32 %arrayidx.val, 2
  %add274 = add nuw nsw i32 %shr273, %shr161
  %cmp275 = icmp ugt i32 %add274, 127
  %34 = lshr i32 %2, 2
  %mul279 = and i32 %34, 252
  %add281 = add nuw nsw i32 %mul39, %mul279
  %cmp284.not = icmp ugt i32 %add281, %1
  %or.cond666 = select i1 %cmp275, i1 true, i1 %cmp284.not, !dbg !95
  br i1 %or.cond666, label %if.end, label %if.then285, !dbg !95

if.then285:                                       ; preds = %if.then
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %25, i64 0, !dbg !96
  %mul288 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !97
  %35 = tail call contract noundef float @llvm.minnum.f32(float %mul288, float 0x4024CB5EC0000000), !dbg !98
  %36 = tail call contract noundef float @llvm.exp.f32(float %35), !dbg !102
  br label %if.end, !dbg !105

if.end:                                           ; preds = %if.then, %if.then285
  %condval.0 = phi float [ %36, %if.then285 ], [ 0.000000e+00, %if.then ], !dbg !106
  %cmp284.not.1 = icmp uge i32 %add281, %1
  %or.cond666.1 = select i1 %cmp275, i1 true, i1 %cmp284.not.1, !dbg !95
  br i1 %or.cond666.1, label %if.end.1, label %if.then285.1, !dbg !95

if.then285.1:                                     ; preds = %if.end
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %25, i64 1, !dbg !96
  %mul288.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !97
  %37 = tail call contract noundef float @llvm.minnum.f32(float %mul288.1, float 0x4024CB5EC0000000), !dbg !98
  %38 = tail call contract noundef float @llvm.exp.f32(float %37), !dbg !102
  br label %if.end.1, !dbg !105

if.end.1:                                         ; preds = %if.then285.1, %if.end
  %condval.0.1 = phi float [ %38, %if.then285.1 ], [ 0.000000e+00, %if.end ], !dbg !106
  %add282.2 = or disjoint i32 %add281, 2
  %cmp284.not.2 = icmp ugt i32 %add282.2, %1
  %or.cond666.2 = select i1 %cmp275, i1 true, i1 %cmp284.not.2, !dbg !95
  br i1 %or.cond666.2, label %if.end.2, label %if.then285.2, !dbg !95

if.then285.2:                                     ; preds = %if.end.1
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %25, i64 2, !dbg !96
  %mul288.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !97
  %39 = tail call contract noundef float @llvm.minnum.f32(float %mul288.2, float 0x4024CB5EC0000000), !dbg !98
  %40 = tail call contract noundef float @llvm.exp.f32(float %39), !dbg !102
  br label %if.end.2, !dbg !105

if.end.2:                                         ; preds = %if.then285.2, %if.end.1
  %condval.0.2 = phi float [ %40, %if.then285.2 ], [ 0.000000e+00, %if.end.1 ], !dbg !106
  %add282.3 = or disjoint i32 %add281, 3
  %cmp284.not.3 = icmp ugt i32 %add282.3, %1
  %or.cond666.3 = select i1 %cmp275, i1 true, i1 %cmp284.not.3, !dbg !95
  br i1 %or.cond666.3, label %if.end.3, label %if.then285.3, !dbg !95

if.then285.3:                                     ; preds = %if.end.2
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %25, i64 3, !dbg !96
  %mul288.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !97
  %41 = tail call contract noundef float @llvm.minnum.f32(float %mul288.3, float 0x4024CB5EC0000000), !dbg !98
  %42 = tail call contract noundef float @llvm.exp.f32(float %41), !dbg !102
  br label %if.end.3, !dbg !105

if.end.3:                                         ; preds = %if.then285.3, %if.end.2
  %condval.0.3 = phi float [ %42, %if.then285.3 ], [ 0.000000e+00, %if.end.2 ], !dbg !106
  %add304.1 = fadd contract float %condval.0, %condval.0.1, !dbg !107
  %add304.2 = fadd contract float %add304.1, %condval.0.2, !dbg !107
  %add304.3 = fadd contract float %add304.2, %condval.0.3, !dbg !107
  %43 = bitcast float %add304.3 to i32, !dbg !108
  %44 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !111
  %45 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %44) #11, !dbg !116
  %xor.i.i = xor i32 %45, 32, !dbg !117
  %46 = and i32 %45, -64, !dbg !118
  %and.i.i = add nsw i32 %46, 64, !dbg !118
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !119
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %45, !dbg !120
  %shl.i.i = shl i32 %cond.i.i, 2, !dbg !121
  %47 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %43), !dbg !122
  %48 = bitcast i32 %47 to float, !dbg !123
  %add312 = fadd contract float %add304.3, %48, !dbg !124
  %49 = bitcast float %add312 to i32, !dbg !125
  %50 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !127
  %51 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %50) #11, !dbg !130
  %xor.i.i618 = xor i32 %51, 16, !dbg !131
  %52 = and i32 %51, -64, !dbg !132
  %and.i.i619 = add nsw i32 %52, 64, !dbg !132
  %cmp.not.i.i620 = icmp slt i32 %xor.i.i618, %and.i.i619, !dbg !133
  %cond.i.i621 = select i1 %cmp.not.i.i620, i32 %xor.i.i618, i32 %51, !dbg !134
  %shl.i.i622 = shl i32 %cond.i.i621, 2, !dbg !135
  %53 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i622, i32 %49), !dbg !136
  %54 = bitcast i32 %53 to float, !dbg !137
  %add317 = fadd contract float %add312, %54, !dbg !138
  %cmp320 = fcmp contract ogt float %add317, 0.000000e+00, !dbg !139
  %div = fdiv contract float 1.000000e+00, %add317, !dbg !140
  %condval_1.0 = select i1 %cmp320, float %div, float 0.000000e+00, !dbg !140
  %mul333 = fmul contract float %condval_1.0, %condval.0, !dbg !141
  %mul333.1 = fmul contract float %condval_1.0, %condval.0.1, !dbg !141
  %mul333.2 = fmul contract float %condval_1.0, %condval.0.2, !dbg !141
  %mul333.3 = fmul contract float %condval_1.0, %condval.0.3, !dbg !141
  %55 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul333), !dbg !142
  %56 = insertelement <4 x i16> poison, i16 %55, i64 0, !dbg !151
  %57 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul333.1), !dbg !142
  %58 = insertelement <4 x i16> %56, i16 %57, i64 1, !dbg !151
  %59 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul333.2), !dbg !142
  %60 = insertelement <4 x i16> %58, i16 %59, i64 2, !dbg !151
  %61 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul333.3), !dbg !142
  %62 = insertelement <4 x i16> %60, i16 %61, i64 3, !dbg !151
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %62 to <4 x half>, !dbg !151
  fence syncscope("warp") release, !dbg !152
  tail call void @llvm.mxc.barrier.warp(), !dbg !155
  fence syncscope("warp") acquire, !dbg !156
  br label %if.end351, !dbg !157

if.end351:                                        ; preds = %if.end.3, %entry
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ undef, %entry ], [ %acc_s_cast.sroa.0.6.vec.insert, %if.end.3 ]
  br i1 %or.cond665, label %if.end421, label %for.cond373.preheader, !dbg !158

for.cond373.preheader:                            ; preds = %if.end351
  %63 = shl nuw nsw i32 %2, 4
  %mul383 = and i32 %63, 16128
  %and389 = and i32 %2, 15
  %add390 = or disjoint i32 %mul383, %and389, !dbg !159
  %arrayidx392 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add390, !dbg !160
  %64 = load half, ptr addrspace(3) %arrayidx392, align 2, !dbg !161, !tbaa !76
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %64, i64 0, !dbg !161
  %add385.1 = or disjoint i32 %mul383, %and389, !dbg !159
  %add390.1 = or disjoint i32 %add385.1, 64, !dbg !159
  %arrayidx392.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add390.1, !dbg !160
  %65 = load half, ptr addrspace(3) %arrayidx392.1, align 2, !dbg !161, !tbaa !76
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %65, i64 1, !dbg !161
  %add385.2 = or disjoint i32 %mul383, %and389, !dbg !159
  %add390.2 = or disjoint i32 %add385.2, 128, !dbg !159
  %arrayidx392.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add390.2, !dbg !160
  %66 = load half, ptr addrspace(3) %arrayidx392.2, align 2, !dbg !161, !tbaa !76
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %66, i64 2, !dbg !161
  %add385.3 = or disjoint i32 %mul383, %and389, !dbg !159
  %add390.3 = or disjoint i32 %add385.3, 192, !dbg !159
  %arrayidx392.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add390.3, !dbg !160
  %67 = load half, ptr addrspace(3) %arrayidx392.3, align 2, !dbg !161, !tbaa !76
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %67, i64 3, !dbg !161
  %add387.1717 = or disjoint i32 %mul383, %and389, !dbg !159
  %add390.1718 = or disjoint i32 %add387.1717, 16, !dbg !159
  %arrayidx392.1719 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add390.1718, !dbg !160
  %68 = load half, ptr addrspace(3) %arrayidx392.1719, align 2, !dbg !161, !tbaa !76
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %68, i64 0, !dbg !161
  %add387.1.1 = or disjoint i32 %mul383, %and389, !dbg !159
  %add390.1.1 = or disjoint i32 %add387.1.1, 80, !dbg !159
  %arrayidx392.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add390.1.1, !dbg !160
  %69 = load half, ptr addrspace(3) %arrayidx392.1.1, align 2, !dbg !161, !tbaa !76
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %69, i64 1, !dbg !161
  %add387.2.1 = or disjoint i32 %mul383, %and389, !dbg !159
  %add390.2.1 = or disjoint i32 %add387.2.1, 144, !dbg !159
  %arrayidx392.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add390.2.1, !dbg !160
  %70 = load half, ptr addrspace(3) %arrayidx392.2.1, align 2, !dbg !161, !tbaa !76
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %70, i64 2, !dbg !161
  %add387.3.1 = or disjoint i32 %mul383, %and389, !dbg !159
  %add390.3.1 = or disjoint i32 %add387.3.1, 208, !dbg !159
  %arrayidx392.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add390.3.1, !dbg !160
  %71 = load half, ptr addrspace(3) %arrayidx392.3.1, align 2, !dbg !161, !tbaa !76
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %71, i64 3, !dbg !161
  %add387.2721 = or disjoint i32 %mul383, %and389, !dbg !159
  %add390.2722 = or disjoint i32 %add387.2721, 32, !dbg !159
  %arrayidx392.2723 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add390.2722, !dbg !160
  %72 = load half, ptr addrspace(3) %arrayidx392.2723, align 2, !dbg !161, !tbaa !76
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %72, i64 0, !dbg !161
  %add387.1.2 = or disjoint i32 %mul383, %and389, !dbg !159
  %add390.1.2 = or disjoint i32 %add387.1.2, 96, !dbg !159
  %arrayidx392.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add390.1.2, !dbg !160
  %73 = load half, ptr addrspace(3) %arrayidx392.1.2, align 2, !dbg !161, !tbaa !76
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %73, i64 1, !dbg !161
  %add387.2.2 = or disjoint i32 %mul383, %and389, !dbg !159
  %add390.2.2 = or disjoint i32 %add387.2.2, 160, !dbg !159
  %arrayidx392.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add390.2.2, !dbg !160
  %74 = load half, ptr addrspace(3) %arrayidx392.2.2, align 2, !dbg !161, !tbaa !76
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %74, i64 2, !dbg !161
  %add387.3.2 = or disjoint i32 %mul383, %and389, !dbg !159
  %add390.3.2 = or disjoint i32 %add387.3.2, 224, !dbg !159
  %arrayidx392.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add390.3.2, !dbg !160
  %75 = load half, ptr addrspace(3) %arrayidx392.3.2, align 2, !dbg !161, !tbaa !76
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %75, i64 3, !dbg !161
  %add387.3725 = or disjoint i32 %mul383, %and389, !dbg !159
  %add390.3726 = or disjoint i32 %add387.3725, 48, !dbg !159
  %arrayidx392.3727 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add390.3726, !dbg !160
  %76 = load half, ptr addrspace(3) %arrayidx392.3727, align 2, !dbg !161, !tbaa !76
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %76, i64 0, !dbg !161
  %add387.1.3 = or disjoint i32 %mul383, %and389, !dbg !159
  %add390.1.3 = or disjoint i32 %add387.1.3, 112, !dbg !159
  %arrayidx392.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add390.1.3, !dbg !160
  %77 = load half, ptr addrspace(3) %arrayidx392.1.3, align 2, !dbg !161, !tbaa !76
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %77, i64 1, !dbg !161
  %add387.2.3 = or disjoint i32 %mul383, %and389, !dbg !159
  %add390.2.3 = or disjoint i32 %add387.2.3, 176, !dbg !159
  %arrayidx392.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add390.2.3, !dbg !160
  %78 = load half, ptr addrspace(3) %arrayidx392.2.3, align 2, !dbg !161, !tbaa !76
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %78, i64 2, !dbg !161
  %add387.3.3 = or disjoint i32 %63, %and389, !dbg !159
  %add390.3.3 = or i32 %add387.3.3, 240, !dbg !159
  %arrayidx392.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add390.3.3, !dbg !160
  %79 = load half, ptr addrspace(3) %arrayidx392.3.3, align 2, !dbg !161, !tbaa !76
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %79, i64 3, !dbg !161
  %80 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !162
  %81 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !162
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !162
  %83 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !162
  br label %if.end421, !dbg !163

if.end421:                                        ; preds = %for.cond373.preheader, %if.end351
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end351 ], [ %80, %for.cond373.preheader ], !dbg !106
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end351 ], [ %81, %for.cond373.preheader ], !dbg !106
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end351 ], [ %82, %for.cond373.preheader ], !dbg !106
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end351 ], [ %83, %for.cond373.preheader ], !dbg !106
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0, !dbg !164
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract), !dbg !165
  %O_reg.sroa.0.0.insert.ext = zext i16 %84 to i64, !dbg !169
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1, !dbg !164
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract), !dbg !165
  %O_reg.sroa.0.2.insert.ext = zext i16 %85 to i64, !dbg !169
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !169
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !169
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2, !dbg !164
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract), !dbg !165
  %O_reg.sroa.0.4.insert.ext = zext i16 %86 to i64, !dbg !169
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !169
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !169
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3, !dbg !164
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract), !dbg !165
  %O_reg.sroa.0.6.insert.ext = zext i16 %87 to i64, !dbg !169
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !169
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !169
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0, !dbg !164
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract), !dbg !165
  %O_reg.sroa.7.8.insert.ext = zext i16 %88 to i64, !dbg !169
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1, !dbg !164
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract), !dbg !165
  %O_reg.sroa.7.10.insert.ext = zext i16 %89 to i64, !dbg !169
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !169
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !169
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2, !dbg !164
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract), !dbg !165
  %O_reg.sroa.7.12.insert.ext = zext i16 %90 to i64, !dbg !169
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !169
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !169
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3, !dbg !164
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract), !dbg !165
  %O_reg.sroa.7.14.insert.ext = zext i16 %91 to i64, !dbg !169
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !169
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !169
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0, !dbg !164
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract), !dbg !165
  %O_reg.sroa.12.16.insert.ext = zext i16 %92 to i64, !dbg !169
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1, !dbg !164
  %93 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract), !dbg !165
  %O_reg.sroa.12.18.insert.ext = zext i16 %93 to i64, !dbg !169
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !169
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !169
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2, !dbg !164
  %94 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract), !dbg !165
  %O_reg.sroa.12.20.insert.ext = zext i16 %94 to i64, !dbg !169
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !169
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !169
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3, !dbg !164
  %95 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract), !dbg !165
  %O_reg.sroa.12.22.insert.ext = zext i16 %95 to i64, !dbg !169
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !169
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !169
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0, !dbg !164
  %96 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract), !dbg !165
  %O_reg.sroa.17.24.insert.ext = zext i16 %96 to i64, !dbg !169
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1, !dbg !164
  %97 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract), !dbg !165
  %O_reg.sroa.17.26.insert.ext = zext i16 %97 to i64, !dbg !169
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !169
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !169
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2, !dbg !164
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract), !dbg !165
  %O_reg.sroa.17.28.insert.ext = zext i16 %98 to i64, !dbg !169
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !169
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !169
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3, !dbg !164
  %99 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract), !dbg !165
  %O_reg.sroa.17.30.insert.ext = zext i16 %99 to i64, !dbg !169
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !169
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !169
  fence syncscope("warp") release, !dbg !170
  tail call void @llvm.mxc.barrier.warp(), !dbg !173
  fence syncscope("warp") acquire, !dbg !174
  %and454 = shl nuw nsw i32 %2, 6
  %mul455 = and i32 %and454, 960
  %shr458 = lshr i32 %2, 5
  %and461 = and i32 %2, 7
  %100 = lshr i32 %2, 2
  %mul468 = and i32 %100, 4
  %xor462 = xor i32 %shr458, %and461, !dbg !175
  %mul463 = shl nuw nsw i32 %xor462, 3, !dbg !176
  %add464 = add nuw nsw i32 %mul463, %mul455, !dbg !177
  %add469 = or disjoint i32 %add464, %mul468, !dbg !178
  %add.ptr471 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add469, !dbg !179
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr471, align 8, !dbg !180
  %add459.1 = add nuw nsw i32 %shr458, 2, !dbg !181
  %xor462.1 = xor i32 %add459.1, %and461, !dbg !175
  %mul463.1 = shl nuw nsw i32 %xor462.1, 3, !dbg !176
  %add464.1 = add nuw nsw i32 %mul463.1, %mul455, !dbg !177
  %add469.1 = or disjoint i32 %add464.1, %mul468, !dbg !178
  %add.ptr471.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add469.1, !dbg !179
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr471.1, align 8, !dbg !180
  %add459.2 = add nuw nsw i32 %shr458, 4, !dbg !181
  %xor462.2 = xor i32 %add459.2, %and461, !dbg !175
  %mul463.2 = shl nuw nsw i32 %xor462.2, 3, !dbg !176
  %add464.2 = add nuw nsw i32 %mul463.2, %mul455, !dbg !177
  %add469.2 = or disjoint i32 %add464.2, %mul468, !dbg !178
  %add.ptr471.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add469.2, !dbg !179
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr471.2, align 8, !dbg !180
  %add459.3 = add nuw nsw i32 %shr458, 6, !dbg !181
  %xor462.3 = xor i32 %add459.3, %and461, !dbg !175
  %mul463.3 = shl nuw nsw i32 %xor462.3, 3, !dbg !176
  %add464.3 = add nuw nsw i32 %mul463.3, %mul455, !dbg !177
  %add469.3 = or disjoint i32 %add464.3, %mul468, !dbg !178
  %add.ptr471.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add469.3, !dbg !179
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr471.3, align 8, !dbg !180
  fence syncscope("warp") release, !dbg !182
  tail call void @llvm.mxc.barrier.warp(), !dbg !185
  fence syncscope("warp") acquire, !dbg !186
  %mul482 = and i32 %mul11, 8128
  %xor488611 = and i32 %mul11, 56
  %call486.masked = and i32 %2, 1016
  %mul489 = xor i32 %xor488611, %call486.masked
  %invariant.gep660 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul482, !dbg !187
  %invariant.gep662 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep660, i32 %mul489, !dbg !187
  %add.ptr504 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3, !dbg !188
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr504, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep662, i64 16, i1 false), !dbg !189, !tbaa.struct !190, !call_argsrelate !191
  %gep663.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep662, i32 1024, !dbg !192
  %add.ptr504.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4, !dbg !188
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr504.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep663.1, i64 16, i1 false), !dbg !189, !tbaa.struct !190, !call_argsrelate !191
  ret void, !dbg !193
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
!1 = !DIFile(filename: "/tmp/tmp23n9fv3u/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmp23n9fv3u/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 25, column: 3, scope: !40)
!44 = !DILocation(line: 26, column: 125, scope: !40)
!45 = !DILocation(line: 28, column: 66, scope: !40)
!46 = !DILocation(line: 28, column: 73, scope: !40)
!47 = !DILocation(line: 28, column: 33, scope: !40)
!48 = !DILocation(line: 28, column: 25, scope: !40)
!49 = !DILocation(line: 34, column: 31, scope: !40)
!50 = !DILocation(line: 26, column: 48, scope: !40)
!51 = !DILocation(line: 37, column: 5, scope: !40)
!52 = !DILocation(line: 41, column: 72, scope: !40)
!53 = !DILocation(line: 50, column: 72, scope: !40)
!54 = !DILocation(line: 55, column: 5, scope: !40)
!55 = !DILocation(line: 56, column: 159, scope: !40)
!56 = !{i32 1, i32 3, i32 -1, i32 -1}
!57 = !DILocation(line: 56, column: 42, scope: !40)
!58 = !DILocation(line: 68, column: 3, scope: !59, inlinedAt: !61)
!59 = distinct !DISubprogram(name: "__barrier_warp", scope: !60, file: !60, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!60 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!61 = distinct !DILocation(line: 192, column: 3, scope: !62, inlinedAt: !63)
!62 = distinct !DISubprogram(name: "__syncwarp", scope: !60, file: !60, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!63 = distinct !DILocation(line: 58, column: 5, scope: !40)
!64 = !DILocation(line: 69, column: 3, scope: !59, inlinedAt: !61)
!65 = !DILocation(line: 70, column: 3, scope: !59, inlinedAt: !61)
!66 = !DILocation(line: 61, column: 153, scope: !40)
!67 = !DILocation(line: 61, column: 73, scope: !40)
!68 = !DILocation(line: 61, column: 36, scope: !40)
!69 = !DILocation(line: 61, column: 124, scope: !40)
!70 = !DILocation(line: 68, column: 3, scope: !59, inlinedAt: !71)
!71 = distinct !DILocation(line: 192, column: 3, scope: !62, inlinedAt: !72)
!72 = distinct !DILocation(line: 63, column: 5, scope: !40)
!73 = !DILocation(line: 69, column: 3, scope: !59, inlinedAt: !71)
!74 = !DILocation(line: 70, column: 3, scope: !59, inlinedAt: !71)
!75 = !DILocation(line: 41, column: 64, scope: !40)
!76 = !{!26, !26, i64 0}
!77 = !DILocation(line: 66, column: 159, scope: !40)
!78 = !DILocation(line: 68, column: 3, scope: !59, inlinedAt: !79)
!79 = distinct !DILocation(line: 192, column: 3, scope: !62, inlinedAt: !80)
!80 = distinct !DILocation(line: 70, column: 5, scope: !40)
!81 = !DILocation(line: 69, column: 3, scope: !59, inlinedAt: !79)
!82 = !DILocation(line: 70, column: 3, scope: !59, inlinedAt: !79)
!83 = !DILocation(line: 72, column: 25, scope: !40)
!84 = !DILocation(line: 75, column: 36, scope: !40)
!85 = !DILocation(line: 68, column: 3, scope: !59, inlinedAt: !86)
!86 = distinct !DILocation(line: 192, column: 3, scope: !62, inlinedAt: !87)
!87 = distinct !DILocation(line: 81, column: 5, scope: !40)
!88 = !DILocation(line: 69, column: 3, scope: !59, inlinedAt: !86)
!89 = !DILocation(line: 70, column: 3, scope: !59, inlinedAt: !86)
!90 = !DILocation(line: 83, column: 10, scope: !40)
!91 = !DILocation(line: 50, column: 64, scope: !40)
!92 = !DILocation(line: 84, column: 86, scope: !40)
!93 = !DILocation(line: 84, column: 42, scope: !40)
!94 = !DILocation(line: 35, column: 43, scope: !40)
!95 = !DILocation(line: 89, column: 84, scope: !40)
!96 = !DILocation(line: 90, column: 29, scope: !40)
!97 = !DILocation(line: 90, column: 40, scope: !40)
!98 = !DILocation(line: 354, column: 10, scope: !99, inlinedAt: !101)
!99 = distinct !DISubprogram(name: "min", scope: !100, file: !100, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!100 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!101 = distinct !DILocation(line: 90, column: 24, scope: !40)
!102 = !DILocation(line: 288, column: 10, scope: !103, inlinedAt: !104)
!103 = distinct !DISubprogram(name: "expf", scope: !100, file: !100, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!104 = distinct !DILocation(line: 90, column: 19, scope: !40)
!105 = !DILocation(line: 91, column: 7, scope: !40)
!106 = !DILocation(line: 0, scope: !40)
!107 = !DILocation(line: 99, column: 34, scope: !40)
!108 = !DILocation(line: 1018, column: 9, scope: !109, inlinedAt: !110)
!109 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !60, file: !60, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!110 = distinct !DILocation(line: 101, column: 34, scope: !40)
!111 = !DILocation(line: 171, column: 37, scope: !112, inlinedAt: !113)
!112 = distinct !DISubprogram(name: "__lane_id", scope: !60, file: !60, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!113 = distinct !DILocation(line: 990, column: 14, scope: !114, inlinedAt: !115)
!114 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !60, file: !60, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!115 = distinct !DILocation(line: 1019, column: 11, scope: !109, inlinedAt: !110)
!116 = !DILocation(line: 171, column: 10, scope: !112, inlinedAt: !113)
!117 = !DILocation(line: 991, column: 20, scope: !114, inlinedAt: !115)
!118 = !DILocation(line: 992, column: 36, scope: !114, inlinedAt: !115)
!119 = !DILocation(line: 992, column: 17, scope: !114, inlinedAt: !115)
!120 = !DILocation(line: 992, column: 11, scope: !114, inlinedAt: !115)
!121 = !DILocation(line: 993, column: 43, scope: !114, inlinedAt: !115)
!122 = !DILocation(line: 993, column: 10, scope: !114, inlinedAt: !115)
!123 = !DILocation(line: 1020, column: 14, scope: !109, inlinedAt: !110)
!124 = !DILocation(line: 101, column: 32, scope: !40)
!125 = !DILocation(line: 1018, column: 9, scope: !109, inlinedAt: !126)
!126 = distinct !DILocation(line: 102, column: 34, scope: !40)
!127 = !DILocation(line: 171, column: 37, scope: !112, inlinedAt: !128)
!128 = distinct !DILocation(line: 990, column: 14, scope: !114, inlinedAt: !129)
!129 = distinct !DILocation(line: 1019, column: 11, scope: !109, inlinedAt: !126)
!130 = !DILocation(line: 171, column: 10, scope: !112, inlinedAt: !128)
!131 = !DILocation(line: 991, column: 20, scope: !114, inlinedAt: !129)
!132 = !DILocation(line: 992, column: 36, scope: !114, inlinedAt: !129)
!133 = !DILocation(line: 992, column: 17, scope: !114, inlinedAt: !129)
!134 = !DILocation(line: 992, column: 11, scope: !114, inlinedAt: !129)
!135 = !DILocation(line: 993, column: 43, scope: !114, inlinedAt: !129)
!136 = !DILocation(line: 993, column: 10, scope: !114, inlinedAt: !129)
!137 = !DILocation(line: 1020, column: 14, scope: !109, inlinedAt: !126)
!138 = !DILocation(line: 102, column: 32, scope: !40)
!139 = !DILocation(line: 104, column: 34, scope: !40)
!140 = !DILocation(line: 104, column: 9, scope: !40)
!141 = !DILocation(line: 112, column: 32, scope: !40)
!142 = !DILocation(line: 75, column: 10, scope: !143, inlinedAt: !145)
!143 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !144, file: !144, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!144 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!145 = distinct !DILocation(line: 984, column: 9, scope: !146, inlinedAt: !148)
!146 = distinct !DISubprogram(name: "__float2half", scope: !147, file: !147, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!147 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!148 = distinct !DILocation(line: 133, column: 53, scope: !149, inlinedAt: !150)
!149 = distinct !DISubprogram(name: "__half", scope: !147, file: !147, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!150 = distinct !DILocation(line: 116, column: 32, scope: !40)
!151 = !DILocation(line: 116, column: 29, scope: !40)
!152 = !DILocation(line: 68, column: 3, scope: !59, inlinedAt: !153)
!153 = distinct !DILocation(line: 192, column: 3, scope: !62, inlinedAt: !154)
!154 = distinct !DILocation(line: 118, column: 5, scope: !40)
!155 = !DILocation(line: 69, column: 3, scope: !59, inlinedAt: !153)
!156 = !DILocation(line: 70, column: 3, scope: !59, inlinedAt: !153)
!157 = !DILocation(line: 119, column: 3, scope: !40)
!158 = !DILocation(line: 125, column: 31, scope: !40)
!159 = !DILocation(line: 128, column: 119, scope: !40)
!160 = !DILocation(line: 128, column: 31, scope: !40)
!161 = !DILocation(line: 128, column: 29, scope: !40)
!162 = !DILocation(line: 133, column: 38, scope: !40)
!163 = !DILocation(line: 140, column: 3, scope: !40)
!164 = !DILocation(line: 143, column: 58, scope: !40)
!165 = !DILocation(line: 75, column: 10, scope: !143, inlinedAt: !166)
!166 = distinct !DILocation(line: 984, column: 9, scope: !146, inlinedAt: !167)
!167 = distinct !DILocation(line: 133, column: 53, scope: !149, inlinedAt: !168)
!168 = distinct !DILocation(line: 143, column: 50, scope: !40)
!169 = !DILocation(line: 143, column: 47, scope: !40)
!170 = !DILocation(line: 68, column: 3, scope: !59, inlinedAt: !171)
!171 = distinct !DILocation(line: 192, column: 3, scope: !62, inlinedAt: !172)
!172 = distinct !DILocation(line: 146, column: 3, scope: !40)
!173 = !DILocation(line: 69, column: 3, scope: !59, inlinedAt: !171)
!174 = !DILocation(line: 70, column: 3, scope: !59, inlinedAt: !171)
!175 = !DILocation(line: 149, column: 121, scope: !40)
!176 = !DILocation(line: 149, column: 149, scope: !40)
!177 = !DILocation(line: 149, column: 77, scope: !40)
!178 = !DILocation(line: 149, column: 155, scope: !40)
!179 = !DILocation(line: 149, column: 40, scope: !40)
!180 = !DILocation(line: 149, column: 198, scope: !40)
!181 = !DILocation(line: 149, column: 92, scope: !40)
!182 = !DILocation(line: 68, column: 3, scope: !59, inlinedAt: !183)
!183 = distinct !DILocation(line: 192, column: 3, scope: !62, inlinedAt: !184)
!184 = distinct !DILocation(line: 151, column: 3, scope: !40)
!185 = !DILocation(line: 69, column: 3, scope: !59, inlinedAt: !183)
!186 = !DILocation(line: 70, column: 3, scope: !59, inlinedAt: !183)
!187 = !DILocation(line: 153, column: 8, scope: !40)
!188 = !DILocation(line: 154, column: 22, scope: !40)
!189 = !DILocation(line: 154, column: 131, scope: !40)
!190 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!191 = !{i32 2, i32 -1, i32 -1, i32 -1}
!192 = !DILocation(line: 154, column: 168, scope: !40)
!193 = !DILocation(line: 156, column: 1, scope: !40)
