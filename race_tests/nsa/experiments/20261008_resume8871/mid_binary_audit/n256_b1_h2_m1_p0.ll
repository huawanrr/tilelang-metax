; ModuleID = 'experiments/20261008_resume8871/mid_binary_audit/n256_b1_h2_m1_p0.bc'
source_filename = "/tmp/tmpcj5plaq7/tvm_kernels.maca"
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
  %mul = shl nsw i32 %0, 11
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul7 = shl nsw i32 %1, 10
  %add = add nuw nsw i32 %mul, %mul7
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %mul11 = shl nuw nsw i32 %2, 3
  %add9 = add nuw nsw i32 %add, %mul11
  %3 = zext nneg i32 %add9 to i64, !dbg !43
  %4 = add nuw nsw i64 %3, 512, !dbg !44
  %mul17 = shl nuw nsw i32 %0, 1, !dbg !45
  %add19 = add nuw nsw i32 %mul17, %1, !dbg !46
  %idxprom = zext nneg i32 %add19 to i64, !dbg !47
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom, !dbg !47
  %5 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !47, !tbaa !30
  %cmp34 = icmp ugt i32 %5, 15
  %shr = lshr i32 %0, 4
  %cmp37.not = icmp ugt i32 %5, %shr
  %or.cond = or i1 %cmp34, %cmp37.not, !dbg !48
  br i1 %or.cond, label %if.end346, label %for.cond40.preheader, !dbg !48

for.cond40.preheader:                             ; preds = %entry
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4, !dbg !49
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !49
  %mul49 = shl nuw nsw i32 %5, 11
  %6 = shl nuw nsw i32 %2, 4
  %mul54 = and i32 %6, 16256
  %mul57 = shl nsw i32 %1, 6
  %add51 = add nuw nsw i32 %mul54, %mul57
  %mul60 = and i32 %mul11, 56
  %add55 = or disjoint i32 %add51, %mul60
  %add58 = add nuw nsw i32 %add55, %mul49
  %7 = zext nneg i32 %add58 to i64, !dbg !50
  %add.ptr65 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %7, !dbg !51
  %8 = load i32, ptr addrspace(4) %add.ptr65, align 4, !dbg !52, !tbaa !30
  %9 = or disjoint i64 %7, 2, !dbg !53
  %add.ptr65.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %9, !dbg !51
  %10 = load i32, ptr addrspace(4) %add.ptr65.1, align 4, !dbg !52, !tbaa !30
  %11 = or disjoint i64 %7, 4, !dbg !53
  %add.ptr65.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %11, !dbg !51
  %12 = load i32, ptr addrspace(4) %add.ptr65.2, align 4, !dbg !52, !tbaa !30
  %13 = or disjoint i64 %7, 6, !dbg !53
  %add.ptr65.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %13, !dbg !51
  %14 = load i32, ptr addrspace(4) %add.ptr65.3, align 4, !dbg !52, !tbaa !30
  %15 = add nuw nsw i64 %7, 1024
  %add.ptr65.1670 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %15, !dbg !51
  %16 = load i32, ptr addrspace(4) %add.ptr65.1670, align 4, !dbg !52, !tbaa !30
  %17 = add nuw nsw i64 %7, 1026, !dbg !53
  %add.ptr65.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %17, !dbg !51
  %18 = load i32, ptr addrspace(4) %add.ptr65.1.1, align 4, !dbg !52, !tbaa !30
  %19 = add nuw nsw i64 %7, 1028, !dbg !53
  %add.ptr65.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %19, !dbg !51
  %20 = load i32, ptr addrspace(4) %add.ptr65.2.1, align 4, !dbg !52, !tbaa !30
  %21 = add nuw nsw i64 %7, 1030, !dbg !53
  %add.ptr65.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %21, !dbg !51
  %22 = load i32, ptr addrspace(4) %add.ptr65.3.1, align 4, !dbg !52, !tbaa !30
  %add.ptr103 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %7, !dbg !54
  %23 = load i32, ptr addrspace(4) %add.ptr103, align 4, !dbg !55, !tbaa !30
  %add.ptr103.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %9, !dbg !54
  %24 = load i32, ptr addrspace(4) %add.ptr103.1, align 4, !dbg !55, !tbaa !30
  %add.ptr103.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %11, !dbg !54
  %25 = load i32, ptr addrspace(4) %add.ptr103.2, align 4, !dbg !55, !tbaa !30
  %add.ptr103.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %13, !dbg !54
  %26 = load i32, ptr addrspace(4) %add.ptr103.3, align 4, !dbg !55, !tbaa !30
  %add.ptr103.1682 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %15, !dbg !54
  %27 = load i32, ptr addrspace(4) %add.ptr103.1682, align 4, !dbg !55, !tbaa !30
  %add.ptr103.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %17, !dbg !54
  %28 = load i32, ptr addrspace(4) %add.ptr103.1.1, align 4, !dbg !55, !tbaa !30
  %add.ptr103.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %19, !dbg !54
  %29 = load i32, ptr addrspace(4) %add.ptr103.2.1, align 4, !dbg !55, !tbaa !30
  %add.ptr103.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %21, !dbg !54
  %30 = load i32, ptr addrspace(4) %add.ptr103.3.1, align 4, !dbg !55, !tbaa !30
  %mul127 = and i32 %mul11, 8128
  %call131.masked = and i32 %2, 1016
  %mul133 = xor i32 %mul60, %call131.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul127, !dbg !56
  %invariant.gep621 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul133, !dbg !56
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep621, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !dbg !57, !call_argsrelate !58
  %gep622.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 1024, !dbg !59
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep622.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !dbg !57, !call_argsrelate !58
  fence syncscope("warp") release, !dbg !60
  tail call void @llvm.mxc.barrier.warp(), !dbg !66
  fence syncscope("warp") acquire, !dbg !67
  %and145 = shl nuw nsw i32 %2, 6
  %mul146 = and i32 %and145, 960
  %shr149 = lshr i32 %2, 4
  %and152 = and i32 %2, 7
  %31 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul146
  %xor153 = xor i32 %shr149, %and152, !dbg !68
  %add.ptr157.idx = shl nuw nsw i32 %xor153, 4, !dbg !69
  %add.ptr157 = getelementptr inbounds i8, ptr addrspace(3) %31, i32 %add.ptr157.idx, !dbg !69
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr157, align 16, !dbg !70
  %Q_reg.sroa.4.0.add.ptr157.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157, i32 8, !dbg !70
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr157.sroa_idx, align 8, !dbg !70
  %add150.1 = add nuw nsw i32 %shr149, 4, !dbg !71
  %xor153.1 = xor i32 %add150.1, %and152, !dbg !68
  %add.ptr157.idx.1 = shl nuw nsw i32 %xor153.1, 4, !dbg !69
  %add.ptr157.1 = getelementptr inbounds i8, ptr addrspace(3) %31, i32 %add.ptr157.idx.1, !dbg !69
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr157.1, align 16, !dbg !70
  %Q_reg.sroa.7.16.add.ptr157.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr157.1, i32 8, !dbg !70
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr157.1.sroa_idx, align 8, !dbg !70
  fence syncscope("warp") release, !dbg !72
  tail call void @llvm.mxc.barrier.warp(), !dbg !75
  fence syncscope("warp") acquire, !dbg !76
  store i32 %8, ptr addrspace(3) %invariant.gep621, align 16, !dbg !77, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep626.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 4, !dbg !77
  store i32 %10, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep626.sroa_idx, align 4, !dbg !77, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep626.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 8, !dbg !77
  store i32 %12, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep626.sroa_idx, align 8, !dbg !77, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep626.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 12, !dbg !77
  store i32 %14, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep626.sroa_idx, align 4, !dbg !77, !tbaa !30
  store i32 %16, ptr addrspace(3) %gep622.1, align 16, !dbg !77, !tbaa !30
  %K_reg.sroa.9.16.gep627.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 1028, !dbg !77
  store i32 %18, ptr addrspace(3) %K_reg.sroa.9.16.gep627.1.sroa_idx, align 4, !dbg !77, !tbaa !30
  %K_reg.sroa.10.16.gep627.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 1032, !dbg !77
  store i32 %20, ptr addrspace(3) %K_reg.sroa.10.16.gep627.1.sroa_idx, align 8, !dbg !77, !tbaa !30
  %K_reg.sroa.11.16.gep627.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep621, i32 1036, !dbg !77
  store i32 %22, ptr addrspace(3) %K_reg.sroa.11.16.gep627.1.sroa_idx, align 4, !dbg !77, !tbaa !30
  fence syncscope("warp") release, !dbg !78
  tail call void @llvm.mxc.barrier.warp(), !dbg !81
  fence syncscope("warp") acquire, !dbg !82
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr157, align 16, !dbg !83
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr157.sroa_idx, align 8, !dbg !83
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !84
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %32), !dbg !84
  %kb.sroa.0.0.copyload712 = load <4 x half>, ptr addrspace(3) %add.ptr157.1, align 16, !dbg !83
  %kb.sroa.6.0.copyload713 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr157.1.sroa_idx, align 8, !dbg !83
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload712, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %33), !dbg !84
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload713, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %34), !dbg !84
  fence syncscope("warp") release, !dbg !85
  tail call void @llvm.mxc.barrier.warp(), !dbg !88
  fence syncscope("warp") acquire, !dbg !89
  %invariant.gep634 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %6, !dbg !90
  store i32 %23, ptr addrspace(3) %invariant.gep634, align 16, !dbg !91, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep634.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep634, i32 4, !dbg !91
  store i32 %24, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep634.sroa_idx, align 4, !dbg !91, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep634.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep634, i32 8, !dbg !91
  store i32 %25, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep634.sroa_idx, align 8, !dbg !91, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep634.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep634, i32 12, !dbg !91
  store i32 %26, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep634.sroa_idx, align 4, !dbg !91, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep634, i32 1024, !dbg !92
  store i32 %27, ptr addrspace(3) %gep.1, align 16, !dbg !91, !tbaa !30
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep634, i32 1028, !dbg !91
  store i32 %28, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !dbg !91, !tbaa !30
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep634, i32 1032, !dbg !91
  store i32 %29, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !dbg !91, !tbaa !30
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep634, i32 1036, !dbg !91
  store i32 %30, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !dbg !91, !tbaa !30
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %35, i64 0, !dbg !93
  %mul259 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !94
  %36 = tail call contract noundef float @llvm.minnum.f32(float %mul259, float 0x4024CB5EC0000000), !dbg !95
  %37 = tail call contract noundef float @llvm.exp.f32(float %36), !dbg !99
  %acc_s.sroa.0.0.vec.insert719 = insertelement <4 x float> poison, float %37, i64 0, !dbg !102
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %35, i64 1, !dbg !93
  %mul259.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !94
  %38 = tail call contract noundef float @llvm.minnum.f32(float %mul259.1, float 0x4024CB5EC0000000), !dbg !95
  %39 = tail call contract noundef float @llvm.exp.f32(float %38), !dbg !99
  %acc_s.sroa.0.4.vec.insert734 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert719, float %39, i64 1, !dbg !102
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %35, i64 2, !dbg !93
  %mul259.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !94
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul259.2, float 0x4024CB5EC0000000), !dbg !95
  %41 = tail call contract noundef float @llvm.exp.f32(float %40), !dbg !99
  %acc_s.sroa.0.8.vec.insert749 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert734, float %41, i64 2, !dbg !102
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %35, i64 3, !dbg !93
  %mul259.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !94
  %42 = tail call contract noundef float @llvm.minnum.f32(float %mul259.3, float 0x4024CB5EC0000000), !dbg !95
  %43 = tail call contract noundef float @llvm.exp.f32(float %42), !dbg !99
  %acc_s.sroa.0.12.vec.insert764 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert749, float %43, i64 3, !dbg !102
  %cmp269 = icmp eq i32 %5, %shr, !dbg !103
  br i1 %cmp269, label %for.cond271.preheader, label %if.end290, !dbg !104

for.cond271.preheader:                            ; preds = %for.cond40.preheader
  %44 = lshr i32 %2, 2
  %mul277 = and i32 %44, 252
  %and280 = and i32 %0, 15
  %cmp281.not = icmp ugt i32 %mul277, %and280, !dbg !105
  %spec.select = select i1 %cmp281.not, float 0.000000e+00, float %37, !dbg !106
  %acc_s.sroa.0.0.vec.insert723 = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !107
  %cmp281.not.1.not = icmp ult i32 %mul277, %and280, !dbg !105
  %condval.0.1 = select i1 %cmp281.not.1.not, float %39, float 0.000000e+00, !dbg !106
  %acc_s.sroa.0.4.vec.insert738 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert723, float %condval.0.1, i64 1, !dbg !107
  %add278.2 = or disjoint i32 %mul277, 2, !dbg !108
  %cmp281.not.2 = icmp ugt i32 %add278.2, %and280, !dbg !105
  %condval.0.2 = select i1 %cmp281.not.2, float 0.000000e+00, float %41, !dbg !106
  %acc_s.sroa.0.8.vec.insert753 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert738, float %condval.0.2, i64 2, !dbg !107
  %add278.3 = or i32 %44, 3, !dbg !108
  %cmp281.not.3 = icmp ugt i32 %add278.3, %and280, !dbg !105
  %condval.0.3 = select i1 %cmp281.not.3, float 0.000000e+00, float %43, !dbg !106
  %acc_s.sroa.0.12.vec.insert768 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert753, float %condval.0.3, i64 3, !dbg !107
  br label %if.end290, !dbg !109

if.end290:                                        ; preds = %for.cond271.preheader, %for.cond40.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert768, %for.cond271.preheader ], [ %acc_s.sroa.0.12.vec.insert764, %for.cond40.preheader ], !dbg !110
  %acc_s.sroa.0.0.vec.extract725 = extractelement <4 x float> %acc_s.sroa.0.0, i64 0, !dbg !111
  %add299 = fadd contract float %acc_s.sroa.0.0.vec.extract725, 0.000000e+00, !dbg !112
  %acc_s.sroa.0.4.vec.extract740 = extractelement <4 x float> %acc_s.sroa.0.0, i64 1, !dbg !111
  %add299.1 = fadd contract float %add299, %acc_s.sroa.0.4.vec.extract740, !dbg !112
  %acc_s.sroa.0.8.vec.extract755 = extractelement <4 x float> %acc_s.sroa.0.0, i64 2, !dbg !111
  %add299.2 = fadd contract float %add299.1, %acc_s.sroa.0.8.vec.extract755, !dbg !112
  %acc_s.sroa.0.12.vec.extract770 = extractelement <4 x float> %acc_s.sroa.0.0, i64 3, !dbg !111
  %add299.3 = fadd contract float %add299.2, %acc_s.sroa.0.12.vec.extract770, !dbg !112
  %45 = bitcast float %add299.3 to i32, !dbg !113
  %46 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !116
  %47 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %46) #11, !dbg !121
  %xor.i.i = xor i32 %47, 32, !dbg !122
  %48 = and i32 %47, -64, !dbg !123
  %and.i.i = add nsw i32 %48, 64, !dbg !123
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !124
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %47, !dbg !125
  %shl.i.i = shl i32 %cond.i.i, 2, !dbg !126
  %49 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %45), !dbg !127
  %50 = bitcast i32 %49 to float, !dbg !128
  %add307 = fadd contract float %add299.3, %50, !dbg !129
  %51 = bitcast float %add307 to i32, !dbg !130
  %52 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !132
  %53 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %52) #11, !dbg !135
  %xor.i.i608 = xor i32 %53, 16, !dbg !136
  %54 = and i32 %53, -64, !dbg !137
  %and.i.i609 = add nsw i32 %54, 64, !dbg !137
  %cmp.not.i.i610 = icmp slt i32 %xor.i.i608, %and.i.i609, !dbg !138
  %cond.i.i611 = select i1 %cmp.not.i.i610, i32 %xor.i.i608, i32 %53, !dbg !139
  %shl.i.i612 = shl i32 %cond.i.i611, 2, !dbg !140
  %55 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i612, i32 %51), !dbg !141
  %56 = bitcast i32 %55 to float, !dbg !142
  %add312 = fadd contract float %add307, %56, !dbg !143
  %cmp315 = fcmp contract ogt float %add312, 0.000000e+00, !dbg !144
  %div = fdiv contract float 1.000000e+00, %add312, !dbg !145
  %condval_1.0 = select i1 %cmp315, float %div, float 0.000000e+00, !dbg !145
  %mul328 = fmul contract float %condval_1.0, %acc_s.sroa.0.0.vec.extract725, !dbg !146
  %acc_s.sroa.0.4.vec.extract742 = extractelement <4 x float> %acc_s.sroa.0.0, i64 1, !dbg !147
  %mul328.1 = fmul contract float %condval_1.0, %acc_s.sroa.0.4.vec.extract742, !dbg !146
  %acc_s.sroa.0.8.vec.extract757 = extractelement <4 x float> %acc_s.sroa.0.0, i64 2, !dbg !147
  %mul328.2 = fmul contract float %condval_1.0, %acc_s.sroa.0.8.vec.extract757, !dbg !146
  %acc_s.sroa.0.12.vec.extract772 = extractelement <4 x float> %acc_s.sroa.0.0, i64 3, !dbg !147
  %mul328.3 = fmul contract float %condval_1.0, %acc_s.sroa.0.12.vec.extract772, !dbg !146
  %57 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul328), !dbg !148
  %58 = insertelement <4 x i16> poison, i16 %57, i64 0, !dbg !157
  %59 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul328.1), !dbg !148
  %60 = insertelement <4 x i16> %58, i16 %59, i64 1, !dbg !157
  %61 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul328.2), !dbg !148
  %62 = insertelement <4 x i16> %60, i16 %61, i64 2, !dbg !157
  %63 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul328.3), !dbg !148
  %64 = insertelement <4 x i16> %62, i16 %63, i64 3, !dbg !157
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %64 to <4 x half>, !dbg !157
  fence syncscope("warp") release, !dbg !158
  tail call void @llvm.mxc.barrier.warp(), !dbg !161
  fence syncscope("warp") acquire, !dbg !162
  br label %if.end346, !dbg !163

if.end346:                                        ; preds = %entry, %if.end290
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ %acc_s_cast.sroa.0.6.vec.insert, %if.end290 ], [ undef, %entry ]
  %cmp362 = icmp ugt i32 %5, 15
  %cmp366.not = icmp ugt i32 %5, %shr
  %or.cond655 = or i1 %cmp362, %cmp366.not, !dbg !164
  br i1 %or.cond655, label %if.end416, label %for.cond368.preheader, !dbg !164

for.cond368.preheader:                            ; preds = %if.end346
  %65 = shl nuw nsw i32 %2, 4
  %mul378 = and i32 %65, 16128
  %and384 = and i32 %2, 15
  %add385 = or disjoint i32 %mul378, %and384, !dbg !165
  %arrayidx387 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385, !dbg !166
  %66 = load half, ptr addrspace(3) %arrayidx387, align 2, !dbg !167, !tbaa !168
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %66, i64 0, !dbg !167
  %add380.1 = or disjoint i32 %mul378, %and384, !dbg !165
  %add385.1 = or disjoint i32 %add380.1, 64, !dbg !165
  %arrayidx387.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.1, !dbg !166
  %67 = load half, ptr addrspace(3) %arrayidx387.1, align 2, !dbg !167, !tbaa !168
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %67, i64 1, !dbg !167
  %add380.2 = or disjoint i32 %mul378, %and384, !dbg !165
  %add385.2 = or disjoint i32 %add380.2, 128, !dbg !165
  %arrayidx387.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.2, !dbg !166
  %68 = load half, ptr addrspace(3) %arrayidx387.2, align 2, !dbg !167, !tbaa !168
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %68, i64 2, !dbg !167
  %add380.3 = or disjoint i32 %mul378, %and384, !dbg !165
  %add385.3 = or disjoint i32 %add380.3, 192, !dbg !165
  %arrayidx387.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.3, !dbg !166
  %69 = load half, ptr addrspace(3) %arrayidx387.3, align 2, !dbg !167, !tbaa !168
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %69, i64 3, !dbg !167
  %add382.1686 = or disjoint i32 %mul378, %and384, !dbg !165
  %add385.1687 = or disjoint i32 %add382.1686, 16, !dbg !165
  %arrayidx387.1688 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.1687, !dbg !166
  %70 = load half, ptr addrspace(3) %arrayidx387.1688, align 2, !dbg !167, !tbaa !168
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %70, i64 0, !dbg !167
  %add382.1.1 = or disjoint i32 %mul378, %and384, !dbg !165
  %add385.1.1 = or disjoint i32 %add382.1.1, 80, !dbg !165
  %arrayidx387.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.1.1, !dbg !166
  %71 = load half, ptr addrspace(3) %arrayidx387.1.1, align 2, !dbg !167, !tbaa !168
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %71, i64 1, !dbg !167
  %add382.2.1 = or disjoint i32 %mul378, %and384, !dbg !165
  %add385.2.1 = or disjoint i32 %add382.2.1, 144, !dbg !165
  %arrayidx387.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.2.1, !dbg !166
  %72 = load half, ptr addrspace(3) %arrayidx387.2.1, align 2, !dbg !167, !tbaa !168
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %72, i64 2, !dbg !167
  %add382.3.1 = or disjoint i32 %mul378, %and384, !dbg !165
  %add385.3.1 = or disjoint i32 %add382.3.1, 208, !dbg !165
  %arrayidx387.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.3.1, !dbg !166
  %73 = load half, ptr addrspace(3) %arrayidx387.3.1, align 2, !dbg !167, !tbaa !168
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %73, i64 3, !dbg !167
  %add382.2690 = or disjoint i32 %mul378, %and384, !dbg !165
  %add385.2691 = or disjoint i32 %add382.2690, 32, !dbg !165
  %arrayidx387.2692 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.2691, !dbg !166
  %74 = load half, ptr addrspace(3) %arrayidx387.2692, align 2, !dbg !167, !tbaa !168
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %74, i64 0, !dbg !167
  %add382.1.2 = or disjoint i32 %mul378, %and384, !dbg !165
  %add385.1.2 = or disjoint i32 %add382.1.2, 96, !dbg !165
  %arrayidx387.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.1.2, !dbg !166
  %75 = load half, ptr addrspace(3) %arrayidx387.1.2, align 2, !dbg !167, !tbaa !168
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %75, i64 1, !dbg !167
  %add382.2.2 = or disjoint i32 %mul378, %and384, !dbg !165
  %add385.2.2 = or disjoint i32 %add382.2.2, 160, !dbg !165
  %arrayidx387.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.2.2, !dbg !166
  %76 = load half, ptr addrspace(3) %arrayidx387.2.2, align 2, !dbg !167, !tbaa !168
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %76, i64 2, !dbg !167
  %add382.3.2 = or disjoint i32 %mul378, %and384, !dbg !165
  %add385.3.2 = or disjoint i32 %add382.3.2, 224, !dbg !165
  %arrayidx387.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.3.2, !dbg !166
  %77 = load half, ptr addrspace(3) %arrayidx387.3.2, align 2, !dbg !167, !tbaa !168
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %77, i64 3, !dbg !167
  %add382.3694 = or disjoint i32 %mul378, %and384, !dbg !165
  %add385.3695 = or disjoint i32 %add382.3694, 48, !dbg !165
  %arrayidx387.3696 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.3695, !dbg !166
  %78 = load half, ptr addrspace(3) %arrayidx387.3696, align 2, !dbg !167, !tbaa !168
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %78, i64 0, !dbg !167
  %add382.1.3 = or disjoint i32 %mul378, %and384, !dbg !165
  %add385.1.3 = or disjoint i32 %add382.1.3, 112, !dbg !165
  %arrayidx387.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.1.3, !dbg !166
  %79 = load half, ptr addrspace(3) %arrayidx387.1.3, align 2, !dbg !167, !tbaa !168
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %79, i64 1, !dbg !167
  %add382.2.3 = or disjoint i32 %mul378, %and384, !dbg !165
  %add385.2.3 = or disjoint i32 %add382.2.3, 176, !dbg !165
  %arrayidx387.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.2.3, !dbg !166
  %80 = load half, ptr addrspace(3) %arrayidx387.2.3, align 2, !dbg !167, !tbaa !168
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %80, i64 2, !dbg !167
  %add382.3.3 = or disjoint i32 %65, %and384, !dbg !165
  %add385.3.3 = or i32 %add382.3.3, 240, !dbg !165
  %arrayidx387.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add385.3.3, !dbg !166
  %81 = load half, ptr addrspace(3) %arrayidx387.3.3, align 2, !dbg !167, !tbaa !168
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %81, i64 3, !dbg !167
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !169
  %83 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !169
  %84 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !169
  %85 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !169
  br label %if.end416, !dbg !170

if.end416:                                        ; preds = %for.cond368.preheader, %if.end346
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end346 ], [ %82, %for.cond368.preheader ], !dbg !110
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end346 ], [ %83, %for.cond368.preheader ], !dbg !110
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end346 ], [ %84, %for.cond368.preheader ], !dbg !110
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end346 ], [ %85, %for.cond368.preheader ], !dbg !110
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0, !dbg !171
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract), !dbg !172
  %O_reg.sroa.0.0.insert.ext = zext i16 %86 to i64, !dbg !176
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1, !dbg !171
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract), !dbg !172
  %O_reg.sroa.0.2.insert.ext = zext i16 %87 to i64, !dbg !176
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !176
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !176
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2, !dbg !171
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract), !dbg !172
  %O_reg.sroa.0.4.insert.ext = zext i16 %88 to i64, !dbg !176
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !176
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !176
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3, !dbg !171
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract), !dbg !172
  %O_reg.sroa.0.6.insert.ext = zext i16 %89 to i64, !dbg !176
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !176
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !176
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0, !dbg !171
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract), !dbg !172
  %O_reg.sroa.7.8.insert.ext = zext i16 %90 to i64, !dbg !176
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1, !dbg !171
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract), !dbg !172
  %O_reg.sroa.7.10.insert.ext = zext i16 %91 to i64, !dbg !176
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !176
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !176
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2, !dbg !171
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract), !dbg !172
  %O_reg.sroa.7.12.insert.ext = zext i16 %92 to i64, !dbg !176
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !176
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !176
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3, !dbg !171
  %93 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract), !dbg !172
  %O_reg.sroa.7.14.insert.ext = zext i16 %93 to i64, !dbg !176
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !176
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !176
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0, !dbg !171
  %94 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract), !dbg !172
  %O_reg.sroa.12.16.insert.ext = zext i16 %94 to i64, !dbg !176
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1, !dbg !171
  %95 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract), !dbg !172
  %O_reg.sroa.12.18.insert.ext = zext i16 %95 to i64, !dbg !176
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !176
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !176
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2, !dbg !171
  %96 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract), !dbg !172
  %O_reg.sroa.12.20.insert.ext = zext i16 %96 to i64, !dbg !176
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !176
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !176
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3, !dbg !171
  %97 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract), !dbg !172
  %O_reg.sroa.12.22.insert.ext = zext i16 %97 to i64, !dbg !176
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !176
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !176
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0, !dbg !171
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract), !dbg !172
  %O_reg.sroa.17.24.insert.ext = zext i16 %98 to i64, !dbg !176
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1, !dbg !171
  %99 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract), !dbg !172
  %O_reg.sroa.17.26.insert.ext = zext i16 %99 to i64, !dbg !176
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !176
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !176
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2, !dbg !171
  %100 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract), !dbg !172
  %O_reg.sroa.17.28.insert.ext = zext i16 %100 to i64, !dbg !176
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !176
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !176
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3, !dbg !171
  %101 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract), !dbg !172
  %O_reg.sroa.17.30.insert.ext = zext i16 %101 to i64, !dbg !176
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !176
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !176
  fence syncscope("warp") release, !dbg !177
  tail call void @llvm.mxc.barrier.warp(), !dbg !180
  fence syncscope("warp") acquire, !dbg !181
  %and449 = shl nuw nsw i32 %2, 6
  %mul450 = and i32 %and449, 960
  %shr453 = lshr i32 %2, 5
  %and456 = and i32 %2, 7
  %102 = lshr i32 %2, 2
  %mul463 = and i32 %102, 4
  %xor457 = xor i32 %shr453, %and456, !dbg !182
  %mul458 = shl nuw nsw i32 %xor457, 3, !dbg !183
  %add459 = add nuw nsw i32 %mul458, %mul450, !dbg !184
  %add464 = or disjoint i32 %add459, %mul463, !dbg !185
  %add.ptr466 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add464, !dbg !186
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr466, align 8, !dbg !187
  %add454.1 = add nuw nsw i32 %shr453, 2, !dbg !188
  %xor457.1 = xor i32 %add454.1, %and456, !dbg !182
  %mul458.1 = shl nuw nsw i32 %xor457.1, 3, !dbg !183
  %add459.1 = add nuw nsw i32 %mul458.1, %mul450, !dbg !184
  %add464.1 = or disjoint i32 %add459.1, %mul463, !dbg !185
  %add.ptr466.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add464.1, !dbg !186
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr466.1, align 8, !dbg !187
  %add454.2 = add nuw nsw i32 %shr453, 4, !dbg !188
  %xor457.2 = xor i32 %add454.2, %and456, !dbg !182
  %mul458.2 = shl nuw nsw i32 %xor457.2, 3, !dbg !183
  %add459.2 = add nuw nsw i32 %mul458.2, %mul450, !dbg !184
  %add464.2 = or disjoint i32 %add459.2, %mul463, !dbg !185
  %add.ptr466.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add464.2, !dbg !186
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr466.2, align 8, !dbg !187
  %add454.3 = add nuw nsw i32 %shr453, 6, !dbg !188
  %xor457.3 = xor i32 %add454.3, %and456, !dbg !182
  %mul458.3 = shl nuw nsw i32 %xor457.3, 3, !dbg !183
  %add459.3 = add nuw nsw i32 %mul458.3, %mul450, !dbg !184
  %add464.3 = or disjoint i32 %add459.3, %mul463, !dbg !185
  %add.ptr466.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add464.3, !dbg !186
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr466.3, align 8, !dbg !187
  fence syncscope("warp") release, !dbg !189
  tail call void @llvm.mxc.barrier.warp(), !dbg !192
  fence syncscope("warp") acquire, !dbg !193
  %mul477 = and i32 %mul11, 8128
  %xor483602 = and i32 %mul11, 56
  %call481.masked = and i32 %2, 1016
  %mul484 = xor i32 %xor483602, %call481.masked
  %invariant.gep649 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul477, !dbg !194
  %invariant.gep651 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep649, i32 %mul484, !dbg !194
  %add.ptr499 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3, !dbg !195
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr499, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep651, i64 16, i1 false), !dbg !196, !tbaa.struct !197, !call_argsrelate !198
  %gep652.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep651, i32 1024, !dbg !199
  %add.ptr499.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4, !dbg !195
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr499.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep652.1, i64 16, i1 false), !dbg !196, !tbaa.struct !197, !call_argsrelate !198
  ret void, !dbg !200
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
!1 = !DIFile(filename: "/tmp/tmpcj5plaq7/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpcj5plaq7/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 25, column: 3, scope: !40)
!44 = !DILocation(line: 26, column: 123, scope: !40)
!45 = !DILocation(line: 28, column: 58, scope: !40)
!46 = !DILocation(line: 28, column: 63, scope: !40)
!47 = !DILocation(line: 28, column: 25, scope: !40)
!48 = !DILocation(line: 34, column: 31, scope: !40)
!49 = !DILocation(line: 26, column: 48, scope: !40)
!50 = !DILocation(line: 37, column: 5, scope: !40)
!51 = !DILocation(line: 40, column: 79, scope: !40)
!52 = !DILocation(line: 40, column: 58, scope: !40)
!53 = !DILocation(line: 40, column: 229, scope: !40)
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
!80 = distinct !DILocation(line: 66, column: 5, scope: !40)
!81 = !DILocation(line: 69, column: 3, scope: !61, inlinedAt: !79)
!82 = !DILocation(line: 70, column: 3, scope: !61, inlinedAt: !79)
!83 = !DILocation(line: 68, column: 25, scope: !40)
!84 = !DILocation(line: 71, column: 36, scope: !40)
!85 = !DILocation(line: 68, column: 3, scope: !61, inlinedAt: !86)
!86 = distinct !DILocation(line: 192, column: 3, scope: !64, inlinedAt: !87)
!87 = distinct !DILocation(line: 77, column: 5, scope: !40)
!88 = !DILocation(line: 69, column: 3, scope: !61, inlinedAt: !86)
!89 = !DILocation(line: 70, column: 3, scope: !61, inlinedAt: !86)
!90 = !DILocation(line: 79, column: 10, scope: !40)
!91 = !DILocation(line: 80, column: 86, scope: !40)
!92 = !DILocation(line: 80, column: 42, scope: !40)
!93 = !DILocation(line: 84, column: 30, scope: !40)
!94 = !DILocation(line: 84, column: 41, scope: !40)
!95 = !DILocation(line: 354, column: 10, scope: !96, inlinedAt: !98)
!96 = distinct !DISubprogram(name: "min", scope: !97, file: !97, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!97 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!98 = distinct !DILocation(line: 84, column: 25, scope: !40)
!99 = !DILocation(line: 288, column: 10, scope: !100, inlinedAt: !101)
!100 = distinct !DISubprogram(name: "expf", scope: !97, file: !97, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!101 = distinct !DILocation(line: 84, column: 20, scope: !40)
!102 = !DILocation(line: 84, column: 18, scope: !40)
!103 = !DILocation(line: 86, column: 25, scope: !40)
!104 = !DILocation(line: 86, column: 9, scope: !40)
!105 = !DILocation(line: 90, column: 54, scope: !40)
!106 = !DILocation(line: 90, column: 13, scope: !40)
!107 = !DILocation(line: 95, column: 20, scope: !40)
!108 = !DILocation(line: 90, column: 47, scope: !40)
!109 = !DILocation(line: 100, column: 5, scope: !40)
!110 = !DILocation(line: 0, scope: !40)
!111 = !DILocation(line: 101, column: 36, scope: !40)
!112 = !DILocation(line: 101, column: 34, scope: !40)
!113 = !DILocation(line: 1018, column: 9, scope: !114, inlinedAt: !115)
!114 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !62, file: !62, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!115 = distinct !DILocation(line: 103, column: 34, scope: !40)
!116 = !DILocation(line: 171, column: 37, scope: !117, inlinedAt: !118)
!117 = distinct !DISubprogram(name: "__lane_id", scope: !62, file: !62, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!118 = distinct !DILocation(line: 990, column: 14, scope: !119, inlinedAt: !120)
!119 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !62, file: !62, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!120 = distinct !DILocation(line: 1019, column: 11, scope: !114, inlinedAt: !115)
!121 = !DILocation(line: 171, column: 10, scope: !117, inlinedAt: !118)
!122 = !DILocation(line: 991, column: 20, scope: !119, inlinedAt: !120)
!123 = !DILocation(line: 992, column: 36, scope: !119, inlinedAt: !120)
!124 = !DILocation(line: 992, column: 17, scope: !119, inlinedAt: !120)
!125 = !DILocation(line: 992, column: 11, scope: !119, inlinedAt: !120)
!126 = !DILocation(line: 993, column: 43, scope: !119, inlinedAt: !120)
!127 = !DILocation(line: 993, column: 10, scope: !119, inlinedAt: !120)
!128 = !DILocation(line: 1020, column: 14, scope: !114, inlinedAt: !115)
!129 = !DILocation(line: 103, column: 32, scope: !40)
!130 = !DILocation(line: 1018, column: 9, scope: !114, inlinedAt: !131)
!131 = distinct !DILocation(line: 104, column: 34, scope: !40)
!132 = !DILocation(line: 171, column: 37, scope: !117, inlinedAt: !133)
!133 = distinct !DILocation(line: 990, column: 14, scope: !119, inlinedAt: !134)
!134 = distinct !DILocation(line: 1019, column: 11, scope: !114, inlinedAt: !131)
!135 = !DILocation(line: 171, column: 10, scope: !117, inlinedAt: !133)
!136 = !DILocation(line: 991, column: 20, scope: !119, inlinedAt: !134)
!137 = !DILocation(line: 992, column: 36, scope: !119, inlinedAt: !134)
!138 = !DILocation(line: 992, column: 17, scope: !119, inlinedAt: !134)
!139 = !DILocation(line: 992, column: 11, scope: !119, inlinedAt: !134)
!140 = !DILocation(line: 993, column: 43, scope: !119, inlinedAt: !134)
!141 = !DILocation(line: 993, column: 10, scope: !119, inlinedAt: !134)
!142 = !DILocation(line: 1020, column: 14, scope: !114, inlinedAt: !131)
!143 = !DILocation(line: 104, column: 32, scope: !40)
!144 = !DILocation(line: 106, column: 34, scope: !40)
!145 = !DILocation(line: 106, column: 9, scope: !40)
!146 = !DILocation(line: 114, column: 32, scope: !40)
!147 = !DILocation(line: 114, column: 21, scope: !40)
!148 = !DILocation(line: 75, column: 10, scope: !149, inlinedAt: !151)
!149 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !150, file: !150, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!150 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!151 = distinct !DILocation(line: 984, column: 9, scope: !152, inlinedAt: !154)
!152 = distinct !DISubprogram(name: "__float2half", scope: !153, file: !153, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!153 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!154 = distinct !DILocation(line: 133, column: 53, scope: !155, inlinedAt: !156)
!155 = distinct !DISubprogram(name: "__half", scope: !153, file: !153, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!156 = distinct !DILocation(line: 118, column: 32, scope: !40)
!157 = !DILocation(line: 118, column: 29, scope: !40)
!158 = !DILocation(line: 68, column: 3, scope: !61, inlinedAt: !159)
!159 = distinct !DILocation(line: 192, column: 3, scope: !64, inlinedAt: !160)
!160 = distinct !DILocation(line: 120, column: 5, scope: !40)
!161 = !DILocation(line: 69, column: 3, scope: !61, inlinedAt: !159)
!162 = !DILocation(line: 70, column: 3, scope: !61, inlinedAt: !159)
!163 = !DILocation(line: 121, column: 3, scope: !40)
!164 = !DILocation(line: 127, column: 31, scope: !40)
!165 = !DILocation(line: 130, column: 119, scope: !40)
!166 = !DILocation(line: 130, column: 31, scope: !40)
!167 = !DILocation(line: 130, column: 29, scope: !40)
!168 = !{!26, !26, i64 0}
!169 = !DILocation(line: 135, column: 38, scope: !40)
!170 = !DILocation(line: 142, column: 3, scope: !40)
!171 = !DILocation(line: 145, column: 58, scope: !40)
!172 = !DILocation(line: 75, column: 10, scope: !149, inlinedAt: !173)
!173 = distinct !DILocation(line: 984, column: 9, scope: !152, inlinedAt: !174)
!174 = distinct !DILocation(line: 133, column: 53, scope: !155, inlinedAt: !175)
!175 = distinct !DILocation(line: 145, column: 50, scope: !40)
!176 = !DILocation(line: 145, column: 47, scope: !40)
!177 = !DILocation(line: 68, column: 3, scope: !61, inlinedAt: !178)
!178 = distinct !DILocation(line: 192, column: 3, scope: !64, inlinedAt: !179)
!179 = distinct !DILocation(line: 148, column: 3, scope: !40)
!180 = !DILocation(line: 69, column: 3, scope: !61, inlinedAt: !178)
!181 = !DILocation(line: 70, column: 3, scope: !61, inlinedAt: !178)
!182 = !DILocation(line: 151, column: 122, scope: !40)
!183 = !DILocation(line: 151, column: 150, scope: !40)
!184 = !DILocation(line: 151, column: 77, scope: !40)
!185 = !DILocation(line: 151, column: 156, scope: !40)
!186 = !DILocation(line: 151, column: 40, scope: !40)
!187 = !DILocation(line: 151, column: 199, scope: !40)
!188 = !DILocation(line: 151, column: 93, scope: !40)
!189 = !DILocation(line: 68, column: 3, scope: !61, inlinedAt: !190)
!190 = distinct !DILocation(line: 192, column: 3, scope: !64, inlinedAt: !191)
!191 = distinct !DILocation(line: 153, column: 3, scope: !40)
!192 = !DILocation(line: 69, column: 3, scope: !61, inlinedAt: !190)
!193 = !DILocation(line: 70, column: 3, scope: !61, inlinedAt: !190)
!194 = !DILocation(line: 155, column: 8, scope: !40)
!195 = !DILocation(line: 156, column: 22, scope: !40)
!196 = !DILocation(line: 156, column: 129, scope: !40)
!197 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!198 = !{i32 2, i32 -1, i32 -1, i32 -1}
!199 = !DILocation(line: 156, column: 166, scope: !40)
!200 = !DILocation(line: 158, column: 1, scope: !40)
