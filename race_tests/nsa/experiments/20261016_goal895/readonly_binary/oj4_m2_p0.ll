; ModuleID = 'experiments/20261016_goal895/readonly_binary/oj4_m2_p0.bc'
source_filename = "/tmp/tmpgrm60zv9/tvm_kernels.maca"
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
  %5 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !47, !tbaa !30
  %cmp34 = icmp ugt i32 %5, 31
  %shr = lshr i32 %1, 4
  %cmp37.not = icmp ugt i32 %5, %shr
  %or.cond663 = or i1 %cmp34, %cmp37.not, !dbg !48
  br i1 %or.cond663, label %if.end350, label %if.then, !dbg !48

if.then:                                          ; preds = %entry
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4, !dbg !49
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !49
  %mul55 = shl nsw i32 %0, 15
  %mul56 = shl nuw nsw i32 %5, 10
  %add57 = or disjoint i32 %mul11, %mul55
  %add59 = add nuw nsw i32 %add57, %mul56
  %6 = zext nneg i32 %add59 to i64, !dbg !50
  %arrayidx67 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %6, !dbg !51
  %7 = or disjoint i64 %6, 2
  %arrayidx67.1678 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %7, !dbg !51
  %8 = or disjoint i64 %6, 4
  %arrayidx67.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %8, !dbg !51
  %9 = or disjoint i64 %6, 6
  %arrayidx67.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %9, !dbg !51
  %10 = add nuw nsw i64 %6, 512
  %arrayidx67.1685 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %10, !dbg !51
  %11 = add nuw nsw i64 %6, 514
  %arrayidx67.1678.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %11, !dbg !51
  %12 = add nuw nsw i64 %6, 516
  %arrayidx67.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %12, !dbg !51
  %13 = add nuw nsw i64 %6, 518
  %arrayidx67.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %13, !dbg !51
  %arrayidx110 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %6, !dbg !52
  %arrayidx110.1699 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %7, !dbg !52
  %arrayidx110.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %8, !dbg !52
  %arrayidx110.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %9, !dbg !52
  %arrayidx110.1706 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %10, !dbg !52
  %arrayidx110.1699.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %11, !dbg !52
  %arrayidx110.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %12, !dbg !52
  %arrayidx110.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %13, !dbg !52
  %mul139 = and i32 %mul11, 8128
  %xor614 = and i32 %mul11, 56
  %call142.masked = and i32 %2, 1016
  %mul144 = xor i32 %xor614, %call142.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul139, !dbg !53
  %invariant.gep631 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul144, !dbg !53
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep631, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !dbg !54, !call_argsrelate !55
  %gep632.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep631, i32 1024, !dbg !56
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep632.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !dbg !54, !call_argsrelate !55
  fence syncscope("warp") release, !dbg !57
  tail call void @llvm.mxc.barrier.warp(), !dbg !63
  fence syncscope("warp") acquire, !dbg !64
  %and156 = shl nuw nsw i32 %2, 6
  %mul157 = and i32 %and156, 960
  %shr160 = lshr i32 %2, 4
  %and163 = and i32 %2, 7
  %14 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul157
  %xor164 = xor i32 %shr160, %and163, !dbg !65
  %add.ptr168.idx = shl nuw nsw i32 %xor164, 4, !dbg !66
  %add.ptr168 = getelementptr inbounds i8, ptr addrspace(3) %14, i32 %add.ptr168.idx, !dbg !66
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr168, align 16, !dbg !67
  %Q_reg.sroa.4.0.add.ptr168.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr168, i32 8, !dbg !67
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr168.sroa_idx, align 8, !dbg !67
  %add161.1 = add nuw nsw i32 %shr160, 4, !dbg !68
  %xor164.1 = xor i32 %add161.1, %and163, !dbg !65
  %add.ptr168.idx.1 = shl nuw nsw i32 %xor164.1, 4, !dbg !66
  %add.ptr168.1 = getelementptr inbounds i8, ptr addrspace(3) %14, i32 %add.ptr168.idx.1, !dbg !66
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr168.1, align 16, !dbg !67
  %Q_reg.sroa.7.16.add.ptr168.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr168.1, i32 8, !dbg !67
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr168.1.sroa_idx, align 8, !dbg !67
  fence syncscope("warp") release, !dbg !69
  tail call void @llvm.mxc.barrier.warp(), !dbg !72
  fence syncscope("warp") acquire, !dbg !73
  %15 = load <2 x i16>, ptr addrspace(4) %arrayidx67, align 2, !dbg !74, !tbaa !75
  store <2 x i16> %15, ptr addrspace(3) %invariant.gep631, align 16, !dbg !76
  %K_reg.sroa.5.0.invariant.gep636.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep631, i32 4, !dbg !76
  %16 = load <2 x i16>, ptr addrspace(4) %arrayidx67.1678, align 2, !dbg !74, !tbaa !75
  store <2 x i16> %16, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep636.sroa_idx, align 4, !dbg !76
  %K_reg.sroa.7.0.invariant.gep636.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep631, i32 8, !dbg !76
  %17 = load <2 x i16>, ptr addrspace(4) %arrayidx67.2, align 2, !dbg !74, !tbaa !75
  store <2 x i16> %17, ptr addrspace(3) %K_reg.sroa.7.0.invariant.gep636.sroa_idx, align 8, !dbg !76
  %K_reg.sroa.9.0.invariant.gep636.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep631, i32 12, !dbg !76
  %18 = load <2 x i16>, ptr addrspace(4) %arrayidx67.3, align 2, !dbg !74, !tbaa !75
  store <2 x i16> %18, ptr addrspace(3) %K_reg.sroa.9.0.invariant.gep636.sroa_idx, align 4, !dbg !76
  %19 = load <2 x i16>, ptr addrspace(4) %arrayidx67.1685, align 2, !dbg !74, !tbaa !75
  store <2 x i16> %19, ptr addrspace(3) %gep632.1, align 16, !dbg !76
  %K_reg.sroa.14.16.gep637.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep631, i32 1028, !dbg !76
  %20 = load <2 x i16>, ptr addrspace(4) %arrayidx67.1678.1, align 2, !dbg !74, !tbaa !75
  store <2 x i16> %20, ptr addrspace(3) %K_reg.sroa.14.16.gep637.1.sroa_idx, align 4, !dbg !76
  %K_reg.sroa.16.16.gep637.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep631, i32 1032, !dbg !76
  %21 = load <2 x i16>, ptr addrspace(4) %arrayidx67.2.1, align 2, !dbg !74, !tbaa !75
  store <2 x i16> %21, ptr addrspace(3) %K_reg.sroa.16.16.gep637.1.sroa_idx, align 8, !dbg !76
  %K_reg.sroa.18.16.gep637.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep631, i32 1036, !dbg !76
  %22 = load <2 x i16>, ptr addrspace(4) %arrayidx67.3.1, align 2, !dbg !74, !tbaa !75
  store <2 x i16> %22, ptr addrspace(3) %K_reg.sroa.18.16.gep637.1.sroa_idx, align 4, !dbg !76
  fence syncscope("warp") release, !dbg !77
  tail call void @llvm.mxc.barrier.warp(), !dbg !80
  fence syncscope("warp") acquire, !dbg !81
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr168, align 16, !dbg !82
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr168.sroa_idx, align 8, !dbg !82
  %23 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !83
  %24 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %23), !dbg !83
  %kb.sroa.0.0.copyload741 = load <4 x half>, ptr addrspace(3) %add.ptr168.1, align 16, !dbg !82
  %kb.sroa.6.0.copyload742 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr168.1.sroa_idx, align 8, !dbg !82
  %25 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload741, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %24), !dbg !83
  %26 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload742, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %25), !dbg !83
  fence syncscope("warp") release, !dbg !84
  tail call void @llvm.mxc.barrier.warp(), !dbg !87
  fence syncscope("warp") acquire, !dbg !88
  %add.ptr260.idx = shl nuw nsw i32 %2, 4
  %invariant.gep644 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %add.ptr260.idx, !dbg !89
  %27 = load <2 x i16>, ptr addrspace(4) %arrayidx110, align 2, !dbg !90, !tbaa !75
  store <2 x i16> %27, ptr addrspace(3) %invariant.gep644, align 16, !dbg !91
  %V_reg.sroa.5.0.invariant.gep644.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep644, i32 4, !dbg !91
  %28 = load <2 x i16>, ptr addrspace(4) %arrayidx110.1699, align 2, !dbg !90, !tbaa !75
  store <2 x i16> %28, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep644.sroa_idx, align 4, !dbg !91
  %V_reg.sroa.7.0.invariant.gep644.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep644, i32 8, !dbg !91
  %29 = load <2 x i16>, ptr addrspace(4) %arrayidx110.2, align 2, !dbg !90, !tbaa !75
  store <2 x i16> %29, ptr addrspace(3) %V_reg.sroa.7.0.invariant.gep644.sroa_idx, align 8, !dbg !91
  %V_reg.sroa.9.0.invariant.gep644.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep644, i32 12, !dbg !91
  %30 = load <2 x i16>, ptr addrspace(4) %arrayidx110.3, align 2, !dbg !90, !tbaa !75
  store <2 x i16> %30, ptr addrspace(3) %V_reg.sroa.9.0.invariant.gep644.sroa_idx, align 4, !dbg !91
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep644, i32 1024, !dbg !92
  %31 = load <2 x i16>, ptr addrspace(4) %arrayidx110.1706, align 2, !dbg !90, !tbaa !75
  store <2 x i16> %31, ptr addrspace(3) %gep.1, align 16, !dbg !91
  %V_reg.sroa.14.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep644, i32 1028, !dbg !91
  %32 = load <2 x i16>, ptr addrspace(4) %arrayidx110.1699.1, align 2, !dbg !90, !tbaa !75
  store <2 x i16> %32, ptr addrspace(3) %V_reg.sroa.14.16.gep.1.sroa_idx, align 4, !dbg !91
  %V_reg.sroa.16.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep644, i32 1032, !dbg !91
  %33 = load <2 x i16>, ptr addrspace(4) %arrayidx110.2.1, align 2, !dbg !90, !tbaa !75
  store <2 x i16> %33, ptr addrspace(3) %V_reg.sroa.16.16.gep.1.sroa_idx, align 8, !dbg !91
  %V_reg.sroa.18.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep644, i32 1036, !dbg !91
  %34 = load <2 x i16>, ptr addrspace(4) %arrayidx110.3.1, align 2, !dbg !90, !tbaa !75
  store <2 x i16> %34, ptr addrspace(3) %V_reg.sroa.18.16.gep.1.sroa_idx, align 4, !dbg !91
  %mul38 = shl nuw nsw i32 %5, 4, !dbg !93
  %shr272 = shl nuw nsw i32 %5, 2
  %add273 = add nuw nsw i32 %shr272, %shr160
  %cmp274 = icmp ugt i32 %add273, 127
  %35 = lshr i32 %2, 2
  %mul278 = and i32 %35, 252
  %add280 = add nuw nsw i32 %mul38, %mul278
  %cmp283.not = icmp ugt i32 %add280, %1
  %or.cond664 = select i1 %cmp274, i1 true, i1 %cmp283.not, !dbg !94
  br i1 %or.cond664, label %if.end, label %if.then284, !dbg !94

if.then284:                                       ; preds = %if.then
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %26, i64 0, !dbg !95
  %mul287 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !96
  %36 = tail call contract noundef float @llvm.minnum.f32(float %mul287, float 0x4024CB5EC0000000), !dbg !97
  %37 = tail call contract noundef float @llvm.exp.f32(float %36), !dbg !101
  br label %if.end, !dbg !104

if.end:                                           ; preds = %if.then, %if.then284
  %condval.0 = phi float [ %37, %if.then284 ], [ 0.000000e+00, %if.then ], !dbg !105
  %cmp283.not.1 = icmp uge i32 %add280, %1
  %or.cond664.1 = select i1 %cmp274, i1 true, i1 %cmp283.not.1, !dbg !94
  br i1 %or.cond664.1, label %if.end.1, label %if.then284.1, !dbg !94

if.then284.1:                                     ; preds = %if.end
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %26, i64 1, !dbg !95
  %mul287.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !96
  %38 = tail call contract noundef float @llvm.minnum.f32(float %mul287.1, float 0x4024CB5EC0000000), !dbg !97
  %39 = tail call contract noundef float @llvm.exp.f32(float %38), !dbg !101
  br label %if.end.1, !dbg !104

if.end.1:                                         ; preds = %if.then284.1, %if.end
  %condval.0.1 = phi float [ %39, %if.then284.1 ], [ 0.000000e+00, %if.end ], !dbg !105
  %add281.2 = or disjoint i32 %add280, 2
  %cmp283.not.2 = icmp ugt i32 %add281.2, %1
  %or.cond664.2 = select i1 %cmp274, i1 true, i1 %cmp283.not.2, !dbg !94
  br i1 %or.cond664.2, label %if.end.2, label %if.then284.2, !dbg !94

if.then284.2:                                     ; preds = %if.end.1
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %26, i64 2, !dbg !95
  %mul287.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !96
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul287.2, float 0x4024CB5EC0000000), !dbg !97
  %41 = tail call contract noundef float @llvm.exp.f32(float %40), !dbg !101
  br label %if.end.2, !dbg !104

if.end.2:                                         ; preds = %if.then284.2, %if.end.1
  %condval.0.2 = phi float [ %41, %if.then284.2 ], [ 0.000000e+00, %if.end.1 ], !dbg !105
  %add281.3 = or disjoint i32 %add280, 3
  %cmp283.not.3 = icmp ugt i32 %add281.3, %1
  %or.cond664.3 = select i1 %cmp274, i1 true, i1 %cmp283.not.3, !dbg !94
  br i1 %or.cond664.3, label %if.end.3, label %if.then284.3, !dbg !94

if.then284.3:                                     ; preds = %if.end.2
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %26, i64 3, !dbg !95
  %mul287.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !96
  %42 = tail call contract noundef float @llvm.minnum.f32(float %mul287.3, float 0x4024CB5EC0000000), !dbg !97
  %43 = tail call contract noundef float @llvm.exp.f32(float %42), !dbg !101
  br label %if.end.3, !dbg !104

if.end.3:                                         ; preds = %if.then284.3, %if.end.2
  %condval.0.3 = phi float [ %43, %if.then284.3 ], [ 0.000000e+00, %if.end.2 ], !dbg !105
  %add303.1 = fadd contract float %condval.0, %condval.0.1, !dbg !106
  %add303.2 = fadd contract float %add303.1, %condval.0.2, !dbg !106
  %add303.3 = fadd contract float %add303.2, %condval.0.3, !dbg !106
  %44 = bitcast float %add303.3 to i32, !dbg !107
  %45 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !110
  %46 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %45) #11, !dbg !115
  %xor.i.i = xor i32 %46, 32, !dbg !116
  %47 = and i32 %46, -64, !dbg !117
  %and.i.i = add nsw i32 %47, 64, !dbg !117
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !118
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %46, !dbg !119
  %shl.i.i = shl i32 %cond.i.i, 2, !dbg !120
  %48 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %44), !dbg !121
  %49 = bitcast i32 %48 to float, !dbg !122
  %add311 = fadd contract float %add303.3, %49, !dbg !123
  %50 = bitcast float %add311 to i32, !dbg !124
  %51 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !126
  %52 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %51) #11, !dbg !129
  %xor.i.i616 = xor i32 %52, 16, !dbg !130
  %53 = and i32 %52, -64, !dbg !131
  %and.i.i617 = add nsw i32 %53, 64, !dbg !131
  %cmp.not.i.i618 = icmp slt i32 %xor.i.i616, %and.i.i617, !dbg !132
  %cond.i.i619 = select i1 %cmp.not.i.i618, i32 %xor.i.i616, i32 %52, !dbg !133
  %shl.i.i620 = shl i32 %cond.i.i619, 2, !dbg !134
  %54 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i620, i32 %50), !dbg !135
  %55 = bitcast i32 %54 to float, !dbg !136
  %add316 = fadd contract float %add311, %55, !dbg !137
  %cmp319 = fcmp contract ogt float %add316, 0.000000e+00, !dbg !138
  %div = fdiv contract float 1.000000e+00, %add316, !dbg !139
  %condval_1.0 = select i1 %cmp319, float %div, float 0.000000e+00, !dbg !139
  %mul332 = fmul contract float %condval_1.0, %condval.0, !dbg !140
  %mul332.1 = fmul contract float %condval_1.0, %condval.0.1, !dbg !140
  %mul332.2 = fmul contract float %condval_1.0, %condval.0.2, !dbg !140
  %mul332.3 = fmul contract float %condval_1.0, %condval.0.3, !dbg !140
  %56 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul332), !dbg !141
  %57 = insertelement <4 x i16> poison, i16 %56, i64 0, !dbg !150
  %58 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul332.1), !dbg !141
  %59 = insertelement <4 x i16> %57, i16 %58, i64 1, !dbg !150
  %60 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul332.2), !dbg !141
  %61 = insertelement <4 x i16> %59, i16 %60, i64 2, !dbg !150
  %62 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul332.3), !dbg !141
  %63 = insertelement <4 x i16> %61, i16 %62, i64 3, !dbg !150
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %63 to <4 x half>, !dbg !150
  fence syncscope("warp") release, !dbg !151
  tail call void @llvm.mxc.barrier.warp(), !dbg !154
  fence syncscope("warp") acquire, !dbg !155
  br label %if.end350, !dbg !156

if.end350:                                        ; preds = %if.end.3, %entry
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ undef, %entry ], [ %acc_s_cast.sroa.0.6.vec.insert, %if.end.3 ]
  br i1 %or.cond663, label %if.end420, label %for.cond372.preheader, !dbg !157

for.cond372.preheader:                            ; preds = %if.end350
  %64 = shl nuw nsw i32 %2, 4
  %mul382 = and i32 %64, 16128
  %and388 = and i32 %2, 15
  %add389 = or disjoint i32 %mul382, %and388, !dbg !158
  %arrayidx391 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389, !dbg !159
  %65 = load half, ptr addrspace(3) %arrayidx391, align 2, !dbg !160, !tbaa !75
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %65, i64 0, !dbg !160
  %add384.1 = or disjoint i32 %mul382, %and388, !dbg !158
  %add389.1 = or disjoint i32 %add384.1, 64, !dbg !158
  %arrayidx391.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389.1, !dbg !159
  %66 = load half, ptr addrspace(3) %arrayidx391.1, align 2, !dbg !160, !tbaa !75
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %66, i64 1, !dbg !160
  %add384.2 = or disjoint i32 %mul382, %and388, !dbg !158
  %add389.2 = or disjoint i32 %add384.2, 128, !dbg !158
  %arrayidx391.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389.2, !dbg !159
  %67 = load half, ptr addrspace(3) %arrayidx391.2, align 2, !dbg !160, !tbaa !75
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %67, i64 2, !dbg !160
  %add384.3 = or disjoint i32 %mul382, %and388, !dbg !158
  %add389.3 = or disjoint i32 %add384.3, 192, !dbg !158
  %arrayidx391.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389.3, !dbg !159
  %68 = load half, ptr addrspace(3) %arrayidx391.3, align 2, !dbg !160, !tbaa !75
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %68, i64 3, !dbg !160
  %add386.1715 = or disjoint i32 %mul382, %and388, !dbg !158
  %add389.1716 = or disjoint i32 %add386.1715, 16, !dbg !158
  %arrayidx391.1717 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389.1716, !dbg !159
  %69 = load half, ptr addrspace(3) %arrayidx391.1717, align 2, !dbg !160, !tbaa !75
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %69, i64 0, !dbg !160
  %add386.1.1 = or disjoint i32 %mul382, %and388, !dbg !158
  %add389.1.1 = or disjoint i32 %add386.1.1, 80, !dbg !158
  %arrayidx391.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389.1.1, !dbg !159
  %70 = load half, ptr addrspace(3) %arrayidx391.1.1, align 2, !dbg !160, !tbaa !75
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %70, i64 1, !dbg !160
  %add386.2.1 = or disjoint i32 %mul382, %and388, !dbg !158
  %add389.2.1 = or disjoint i32 %add386.2.1, 144, !dbg !158
  %arrayidx391.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389.2.1, !dbg !159
  %71 = load half, ptr addrspace(3) %arrayidx391.2.1, align 2, !dbg !160, !tbaa !75
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %71, i64 2, !dbg !160
  %add386.3.1 = or disjoint i32 %mul382, %and388, !dbg !158
  %add389.3.1 = or disjoint i32 %add386.3.1, 208, !dbg !158
  %arrayidx391.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389.3.1, !dbg !159
  %72 = load half, ptr addrspace(3) %arrayidx391.3.1, align 2, !dbg !160, !tbaa !75
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %72, i64 3, !dbg !160
  %add386.2719 = or disjoint i32 %mul382, %and388, !dbg !158
  %add389.2720 = or disjoint i32 %add386.2719, 32, !dbg !158
  %arrayidx391.2721 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389.2720, !dbg !159
  %73 = load half, ptr addrspace(3) %arrayidx391.2721, align 2, !dbg !160, !tbaa !75
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %73, i64 0, !dbg !160
  %add386.1.2 = or disjoint i32 %mul382, %and388, !dbg !158
  %add389.1.2 = or disjoint i32 %add386.1.2, 96, !dbg !158
  %arrayidx391.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389.1.2, !dbg !159
  %74 = load half, ptr addrspace(3) %arrayidx391.1.2, align 2, !dbg !160, !tbaa !75
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %74, i64 1, !dbg !160
  %add386.2.2 = or disjoint i32 %mul382, %and388, !dbg !158
  %add389.2.2 = or disjoint i32 %add386.2.2, 160, !dbg !158
  %arrayidx391.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389.2.2, !dbg !159
  %75 = load half, ptr addrspace(3) %arrayidx391.2.2, align 2, !dbg !160, !tbaa !75
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %75, i64 2, !dbg !160
  %add386.3.2 = or disjoint i32 %mul382, %and388, !dbg !158
  %add389.3.2 = or disjoint i32 %add386.3.2, 224, !dbg !158
  %arrayidx391.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389.3.2, !dbg !159
  %76 = load half, ptr addrspace(3) %arrayidx391.3.2, align 2, !dbg !160, !tbaa !75
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %76, i64 3, !dbg !160
  %add386.3723 = or disjoint i32 %mul382, %and388, !dbg !158
  %add389.3724 = or disjoint i32 %add386.3723, 48, !dbg !158
  %arrayidx391.3725 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389.3724, !dbg !159
  %77 = load half, ptr addrspace(3) %arrayidx391.3725, align 2, !dbg !160, !tbaa !75
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %77, i64 0, !dbg !160
  %add386.1.3 = or disjoint i32 %mul382, %and388, !dbg !158
  %add389.1.3 = or disjoint i32 %add386.1.3, 112, !dbg !158
  %arrayidx391.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389.1.3, !dbg !159
  %78 = load half, ptr addrspace(3) %arrayidx391.1.3, align 2, !dbg !160, !tbaa !75
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %78, i64 1, !dbg !160
  %add386.2.3 = or disjoint i32 %mul382, %and388, !dbg !158
  %add389.2.3 = or disjoint i32 %add386.2.3, 176, !dbg !158
  %arrayidx391.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389.2.3, !dbg !159
  %79 = load half, ptr addrspace(3) %arrayidx391.2.3, align 2, !dbg !160, !tbaa !75
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %79, i64 2, !dbg !160
  %add386.3.3 = or disjoint i32 %64, %and388, !dbg !158
  %add389.3.3 = or i32 %add386.3.3, 240, !dbg !158
  %arrayidx391.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add389.3.3, !dbg !159
  %80 = load half, ptr addrspace(3) %arrayidx391.3.3, align 2, !dbg !160, !tbaa !75
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %80, i64 3, !dbg !160
  %81 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !161
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !161
  %83 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !161
  %84 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !161
  br label %if.end420, !dbg !162

if.end420:                                        ; preds = %for.cond372.preheader, %if.end350
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end350 ], [ %81, %for.cond372.preheader ], !dbg !105
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end350 ], [ %82, %for.cond372.preheader ], !dbg !105
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end350 ], [ %83, %for.cond372.preheader ], !dbg !105
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end350 ], [ %84, %for.cond372.preheader ], !dbg !105
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0, !dbg !163
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract), !dbg !164
  %O_reg.sroa.0.0.insert.ext = zext i16 %85 to i64, !dbg !168
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1, !dbg !163
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract), !dbg !164
  %O_reg.sroa.0.2.insert.ext = zext i16 %86 to i64, !dbg !168
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !168
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !168
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2, !dbg !163
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract), !dbg !164
  %O_reg.sroa.0.4.insert.ext = zext i16 %87 to i64, !dbg !168
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !168
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !168
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3, !dbg !163
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract), !dbg !164
  %O_reg.sroa.0.6.insert.ext = zext i16 %88 to i64, !dbg !168
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !168
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !168
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0, !dbg !163
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract), !dbg !164
  %O_reg.sroa.7.8.insert.ext = zext i16 %89 to i64, !dbg !168
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1, !dbg !163
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract), !dbg !164
  %O_reg.sroa.7.10.insert.ext = zext i16 %90 to i64, !dbg !168
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !168
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !168
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2, !dbg !163
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract), !dbg !164
  %O_reg.sroa.7.12.insert.ext = zext i16 %91 to i64, !dbg !168
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !168
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !168
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3, !dbg !163
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract), !dbg !164
  %O_reg.sroa.7.14.insert.ext = zext i16 %92 to i64, !dbg !168
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !168
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !168
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0, !dbg !163
  %93 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract), !dbg !164
  %O_reg.sroa.12.16.insert.ext = zext i16 %93 to i64, !dbg !168
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1, !dbg !163
  %94 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract), !dbg !164
  %O_reg.sroa.12.18.insert.ext = zext i16 %94 to i64, !dbg !168
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !168
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !168
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2, !dbg !163
  %95 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract), !dbg !164
  %O_reg.sroa.12.20.insert.ext = zext i16 %95 to i64, !dbg !168
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !168
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !168
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3, !dbg !163
  %96 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract), !dbg !164
  %O_reg.sroa.12.22.insert.ext = zext i16 %96 to i64, !dbg !168
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !168
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !168
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0, !dbg !163
  %97 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract), !dbg !164
  %O_reg.sroa.17.24.insert.ext = zext i16 %97 to i64, !dbg !168
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1, !dbg !163
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract), !dbg !164
  %O_reg.sroa.17.26.insert.ext = zext i16 %98 to i64, !dbg !168
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !168
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !168
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2, !dbg !163
  %99 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract), !dbg !164
  %O_reg.sroa.17.28.insert.ext = zext i16 %99 to i64, !dbg !168
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !168
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !168
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3, !dbg !163
  %100 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract), !dbg !164
  %O_reg.sroa.17.30.insert.ext = zext i16 %100 to i64, !dbg !168
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !168
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !168
  fence syncscope("warp") release, !dbg !169
  tail call void @llvm.mxc.barrier.warp(), !dbg !172
  fence syncscope("warp") acquire, !dbg !173
  %and453 = shl nuw nsw i32 %2, 6
  %mul454 = and i32 %and453, 960
  %shr457 = lshr i32 %2, 5
  %and460 = and i32 %2, 7
  %101 = lshr i32 %2, 2
  %mul467 = and i32 %101, 4
  %xor461 = xor i32 %shr457, %and460, !dbg !174
  %mul462 = shl nuw nsw i32 %xor461, 3, !dbg !175
  %add463 = add nuw nsw i32 %mul462, %mul454, !dbg !176
  %add468 = or disjoint i32 %add463, %mul467, !dbg !177
  %add.ptr470 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add468, !dbg !178
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr470, align 8, !dbg !179
  %add458.1 = add nuw nsw i32 %shr457, 2, !dbg !180
  %xor461.1 = xor i32 %add458.1, %and460, !dbg !174
  %mul462.1 = shl nuw nsw i32 %xor461.1, 3, !dbg !175
  %add463.1 = add nuw nsw i32 %mul462.1, %mul454, !dbg !176
  %add468.1 = or disjoint i32 %add463.1, %mul467, !dbg !177
  %add.ptr470.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add468.1, !dbg !178
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr470.1, align 8, !dbg !179
  %add458.2 = add nuw nsw i32 %shr457, 4, !dbg !180
  %xor461.2 = xor i32 %add458.2, %and460, !dbg !174
  %mul462.2 = shl nuw nsw i32 %xor461.2, 3, !dbg !175
  %add463.2 = add nuw nsw i32 %mul462.2, %mul454, !dbg !176
  %add468.2 = or disjoint i32 %add463.2, %mul467, !dbg !177
  %add.ptr470.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add468.2, !dbg !178
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr470.2, align 8, !dbg !179
  %add458.3 = add nuw nsw i32 %shr457, 6, !dbg !180
  %xor461.3 = xor i32 %add458.3, %and460, !dbg !174
  %mul462.3 = shl nuw nsw i32 %xor461.3, 3, !dbg !175
  %add463.3 = add nuw nsw i32 %mul462.3, %mul454, !dbg !176
  %add468.3 = or disjoint i32 %add463.3, %mul467, !dbg !177
  %add.ptr470.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add468.3, !dbg !178
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr470.3, align 8, !dbg !179
  fence syncscope("warp") release, !dbg !181
  tail call void @llvm.mxc.barrier.warp(), !dbg !184
  fence syncscope("warp") acquire, !dbg !185
  %mul481 = and i32 %mul11, 8128
  %xor487610 = and i32 %mul11, 56
  %call485.masked = and i32 %2, 1016
  %mul488 = xor i32 %xor487610, %call485.masked
  %invariant.gep658 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul481, !dbg !186
  %invariant.gep660 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep658, i32 %mul488, !dbg !186
  %add.ptr503 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3, !dbg !187
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr503, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep660, i64 16, i1 false), !dbg !188, !tbaa.struct !189, !call_argsrelate !190
  %gep661.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep660, i32 1024, !dbg !191
  %add.ptr503.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4, !dbg !187
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr503.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep661.1, i64 16, i1 false), !dbg !188, !tbaa.struct !189, !call_argsrelate !190
  ret void, !dbg !192
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
!1 = !DIFile(filename: "/tmp/tmpgrm60zv9/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpgrm60zv9/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 25, column: 3, scope: !40)
!44 = !DILocation(line: 26, column: 125, scope: !40)
!45 = !DILocation(line: 28, column: 58, scope: !40)
!46 = !DILocation(line: 28, column: 65, scope: !40)
!47 = !DILocation(line: 28, column: 25, scope: !40)
!48 = !DILocation(line: 34, column: 31, scope: !40)
!49 = !DILocation(line: 26, column: 48, scope: !40)
!50 = !DILocation(line: 37, column: 5, scope: !40)
!51 = !DILocation(line: 41, column: 72, scope: !40)
!52 = !DILocation(line: 50, column: 72, scope: !40)
!53 = !DILocation(line: 55, column: 5, scope: !40)
!54 = !DILocation(line: 56, column: 159, scope: !40)
!55 = !{i32 1, i32 3, i32 -1, i32 -1}
!56 = !DILocation(line: 56, column: 42, scope: !40)
!57 = !DILocation(line: 68, column: 3, scope: !58, inlinedAt: !60)
!58 = distinct !DISubprogram(name: "__barrier_warp", scope: !59, file: !59, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!59 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!60 = distinct !DILocation(line: 192, column: 3, scope: !61, inlinedAt: !62)
!61 = distinct !DISubprogram(name: "__syncwarp", scope: !59, file: !59, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!62 = distinct !DILocation(line: 58, column: 5, scope: !40)
!63 = !DILocation(line: 69, column: 3, scope: !58, inlinedAt: !60)
!64 = !DILocation(line: 70, column: 3, scope: !58, inlinedAt: !60)
!65 = !DILocation(line: 61, column: 153, scope: !40)
!66 = !DILocation(line: 61, column: 73, scope: !40)
!67 = !DILocation(line: 61, column: 36, scope: !40)
!68 = !DILocation(line: 61, column: 124, scope: !40)
!69 = !DILocation(line: 68, column: 3, scope: !58, inlinedAt: !70)
!70 = distinct !DILocation(line: 192, column: 3, scope: !61, inlinedAt: !71)
!71 = distinct !DILocation(line: 63, column: 5, scope: !40)
!72 = !DILocation(line: 69, column: 3, scope: !58, inlinedAt: !70)
!73 = !DILocation(line: 70, column: 3, scope: !58, inlinedAt: !70)
!74 = !DILocation(line: 41, column: 64, scope: !40)
!75 = !{!26, !26, i64 0}
!76 = !DILocation(line: 66, column: 159, scope: !40)
!77 = !DILocation(line: 68, column: 3, scope: !58, inlinedAt: !78)
!78 = distinct !DILocation(line: 192, column: 3, scope: !61, inlinedAt: !79)
!79 = distinct !DILocation(line: 70, column: 5, scope: !40)
!80 = !DILocation(line: 69, column: 3, scope: !58, inlinedAt: !78)
!81 = !DILocation(line: 70, column: 3, scope: !58, inlinedAt: !78)
!82 = !DILocation(line: 72, column: 25, scope: !40)
!83 = !DILocation(line: 75, column: 36, scope: !40)
!84 = !DILocation(line: 68, column: 3, scope: !58, inlinedAt: !85)
!85 = distinct !DILocation(line: 192, column: 3, scope: !61, inlinedAt: !86)
!86 = distinct !DILocation(line: 81, column: 5, scope: !40)
!87 = !DILocation(line: 69, column: 3, scope: !58, inlinedAt: !85)
!88 = !DILocation(line: 70, column: 3, scope: !58, inlinedAt: !85)
!89 = !DILocation(line: 83, column: 10, scope: !40)
!90 = !DILocation(line: 50, column: 64, scope: !40)
!91 = !DILocation(line: 84, column: 86, scope: !40)
!92 = !DILocation(line: 84, column: 42, scope: !40)
!93 = !DILocation(line: 35, column: 43, scope: !40)
!94 = !DILocation(line: 89, column: 84, scope: !40)
!95 = !DILocation(line: 90, column: 29, scope: !40)
!96 = !DILocation(line: 90, column: 40, scope: !40)
!97 = !DILocation(line: 354, column: 10, scope: !98, inlinedAt: !100)
!98 = distinct !DISubprogram(name: "min", scope: !99, file: !99, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!99 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!100 = distinct !DILocation(line: 90, column: 24, scope: !40)
!101 = !DILocation(line: 288, column: 10, scope: !102, inlinedAt: !103)
!102 = distinct !DISubprogram(name: "expf", scope: !99, file: !99, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!103 = distinct !DILocation(line: 90, column: 19, scope: !40)
!104 = !DILocation(line: 91, column: 7, scope: !40)
!105 = !DILocation(line: 0, scope: !40)
!106 = !DILocation(line: 99, column: 34, scope: !40)
!107 = !DILocation(line: 1018, column: 9, scope: !108, inlinedAt: !109)
!108 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !59, file: !59, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!109 = distinct !DILocation(line: 101, column: 34, scope: !40)
!110 = !DILocation(line: 171, column: 37, scope: !111, inlinedAt: !112)
!111 = distinct !DISubprogram(name: "__lane_id", scope: !59, file: !59, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!112 = distinct !DILocation(line: 990, column: 14, scope: !113, inlinedAt: !114)
!113 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !59, file: !59, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!114 = distinct !DILocation(line: 1019, column: 11, scope: !108, inlinedAt: !109)
!115 = !DILocation(line: 171, column: 10, scope: !111, inlinedAt: !112)
!116 = !DILocation(line: 991, column: 20, scope: !113, inlinedAt: !114)
!117 = !DILocation(line: 992, column: 36, scope: !113, inlinedAt: !114)
!118 = !DILocation(line: 992, column: 17, scope: !113, inlinedAt: !114)
!119 = !DILocation(line: 992, column: 11, scope: !113, inlinedAt: !114)
!120 = !DILocation(line: 993, column: 43, scope: !113, inlinedAt: !114)
!121 = !DILocation(line: 993, column: 10, scope: !113, inlinedAt: !114)
!122 = !DILocation(line: 1020, column: 14, scope: !108, inlinedAt: !109)
!123 = !DILocation(line: 101, column: 32, scope: !40)
!124 = !DILocation(line: 1018, column: 9, scope: !108, inlinedAt: !125)
!125 = distinct !DILocation(line: 102, column: 34, scope: !40)
!126 = !DILocation(line: 171, column: 37, scope: !111, inlinedAt: !127)
!127 = distinct !DILocation(line: 990, column: 14, scope: !113, inlinedAt: !128)
!128 = distinct !DILocation(line: 1019, column: 11, scope: !108, inlinedAt: !125)
!129 = !DILocation(line: 171, column: 10, scope: !111, inlinedAt: !127)
!130 = !DILocation(line: 991, column: 20, scope: !113, inlinedAt: !128)
!131 = !DILocation(line: 992, column: 36, scope: !113, inlinedAt: !128)
!132 = !DILocation(line: 992, column: 17, scope: !113, inlinedAt: !128)
!133 = !DILocation(line: 992, column: 11, scope: !113, inlinedAt: !128)
!134 = !DILocation(line: 993, column: 43, scope: !113, inlinedAt: !128)
!135 = !DILocation(line: 993, column: 10, scope: !113, inlinedAt: !128)
!136 = !DILocation(line: 1020, column: 14, scope: !108, inlinedAt: !125)
!137 = !DILocation(line: 102, column: 32, scope: !40)
!138 = !DILocation(line: 104, column: 34, scope: !40)
!139 = !DILocation(line: 104, column: 9, scope: !40)
!140 = !DILocation(line: 112, column: 32, scope: !40)
!141 = !DILocation(line: 75, column: 10, scope: !142, inlinedAt: !144)
!142 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !143, file: !143, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!143 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!144 = distinct !DILocation(line: 984, column: 9, scope: !145, inlinedAt: !147)
!145 = distinct !DISubprogram(name: "__float2half", scope: !146, file: !146, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!146 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!147 = distinct !DILocation(line: 133, column: 53, scope: !148, inlinedAt: !149)
!148 = distinct !DISubprogram(name: "__half", scope: !146, file: !146, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!149 = distinct !DILocation(line: 116, column: 32, scope: !40)
!150 = !DILocation(line: 116, column: 29, scope: !40)
!151 = !DILocation(line: 68, column: 3, scope: !58, inlinedAt: !152)
!152 = distinct !DILocation(line: 192, column: 3, scope: !61, inlinedAt: !153)
!153 = distinct !DILocation(line: 118, column: 5, scope: !40)
!154 = !DILocation(line: 69, column: 3, scope: !58, inlinedAt: !152)
!155 = !DILocation(line: 70, column: 3, scope: !58, inlinedAt: !152)
!156 = !DILocation(line: 119, column: 3, scope: !40)
!157 = !DILocation(line: 125, column: 31, scope: !40)
!158 = !DILocation(line: 128, column: 119, scope: !40)
!159 = !DILocation(line: 128, column: 31, scope: !40)
!160 = !DILocation(line: 128, column: 29, scope: !40)
!161 = !DILocation(line: 133, column: 38, scope: !40)
!162 = !DILocation(line: 140, column: 3, scope: !40)
!163 = !DILocation(line: 143, column: 58, scope: !40)
!164 = !DILocation(line: 75, column: 10, scope: !142, inlinedAt: !165)
!165 = distinct !DILocation(line: 984, column: 9, scope: !145, inlinedAt: !166)
!166 = distinct !DILocation(line: 133, column: 53, scope: !148, inlinedAt: !167)
!167 = distinct !DILocation(line: 143, column: 50, scope: !40)
!168 = !DILocation(line: 143, column: 47, scope: !40)
!169 = !DILocation(line: 68, column: 3, scope: !58, inlinedAt: !170)
!170 = distinct !DILocation(line: 192, column: 3, scope: !61, inlinedAt: !171)
!171 = distinct !DILocation(line: 146, column: 3, scope: !40)
!172 = !DILocation(line: 69, column: 3, scope: !58, inlinedAt: !170)
!173 = !DILocation(line: 70, column: 3, scope: !58, inlinedAt: !170)
!174 = !DILocation(line: 149, column: 121, scope: !40)
!175 = !DILocation(line: 149, column: 149, scope: !40)
!176 = !DILocation(line: 149, column: 77, scope: !40)
!177 = !DILocation(line: 149, column: 155, scope: !40)
!178 = !DILocation(line: 149, column: 40, scope: !40)
!179 = !DILocation(line: 149, column: 198, scope: !40)
!180 = !DILocation(line: 149, column: 92, scope: !40)
!181 = !DILocation(line: 68, column: 3, scope: !58, inlinedAt: !182)
!182 = distinct !DILocation(line: 192, column: 3, scope: !61, inlinedAt: !183)
!183 = distinct !DILocation(line: 151, column: 3, scope: !40)
!184 = !DILocation(line: 69, column: 3, scope: !58, inlinedAt: !182)
!185 = !DILocation(line: 70, column: 3, scope: !58, inlinedAt: !182)
!186 = !DILocation(line: 153, column: 8, scope: !40)
!187 = !DILocation(line: 154, column: 22, scope: !40)
!188 = !DILocation(line: 154, column: 131, scope: !40)
!189 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!190 = !{i32 2, i32 -1, i32 -1, i32 -1}
!191 = !DILocation(line: 154, column: 168, scope: !40)
!192 = !DILocation(line: 156, column: 1, scope: !40)
