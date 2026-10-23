; ModuleID = 'experiments/20261016_rsqrt/candidate_binary/oj13_m1_p0.bc'
source_filename = "/tmp/tmpj967mejb/tvm_kernels.maca"
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
  %arrayidx20 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom, !dbg !47
  %5 = load i32, ptr addrspace(1) %arrayidx20, align 4, !dbg !47, !tbaa !30
  %cmp35 = icmp ugt i32 %5, 15
  %shr = lshr i32 %0, 4
  %cmp38.not = icmp ugt i32 %5, %shr
  %or.cond = or i1 %cmp35, %cmp38.not, !dbg !48
  br i1 %or.cond, label %if.end353, label %for.cond41.preheader, !dbg !48

for.cond41.preheader:                             ; preds = %entry
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4, !dbg !49
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %3, !dbg !49
  %mul50 = shl nuw nsw i32 %5, 11
  %6 = shl nuw nsw i32 %2, 4
  %mul55 = and i32 %6, 16256
  %mul58 = shl nsw i32 %1, 6
  %add52 = add nuw nsw i32 %mul55, %mul58
  %mul61 = and i32 %mul11, 56
  %add56 = or disjoint i32 %add52, %mul61
  %add59 = add nuw nsw i32 %add56, %mul50
  %7 = zext nneg i32 %add59 to i64, !dbg !50
  %add.ptr66 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %7, !dbg !51
  %8 = load i32, ptr addrspace(4) %add.ptr66, align 4, !dbg !52, !tbaa !30
  %9 = or disjoint i64 %7, 2, !dbg !53
  %add.ptr66.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %9, !dbg !51
  %10 = load i32, ptr addrspace(4) %add.ptr66.1, align 4, !dbg !52, !tbaa !30
  %11 = or disjoint i64 %7, 4, !dbg !53
  %add.ptr66.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %11, !dbg !51
  %12 = load i32, ptr addrspace(4) %add.ptr66.2, align 4, !dbg !52, !tbaa !30
  %13 = or disjoint i64 %7, 6, !dbg !53
  %add.ptr66.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %13, !dbg !51
  %14 = load i32, ptr addrspace(4) %add.ptr66.3, align 4, !dbg !52, !tbaa !30
  %15 = add nuw nsw i64 %7, 1024
  %add.ptr66.1681 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %15, !dbg !51
  %16 = load i32, ptr addrspace(4) %add.ptr66.1681, align 4, !dbg !52, !tbaa !30
  %17 = add nuw nsw i64 %7, 1026, !dbg !53
  %add.ptr66.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %17, !dbg !51
  %18 = load i32, ptr addrspace(4) %add.ptr66.1.1, align 4, !dbg !52, !tbaa !30
  %19 = add nuw nsw i64 %7, 1028, !dbg !53
  %add.ptr66.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %19, !dbg !51
  %20 = load i32, ptr addrspace(4) %add.ptr66.2.1, align 4, !dbg !52, !tbaa !30
  %21 = add nuw nsw i64 %7, 1030, !dbg !53
  %add.ptr66.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %21, !dbg !51
  %22 = load i32, ptr addrspace(4) %add.ptr66.3.1, align 4, !dbg !52, !tbaa !30
  %add.ptr104 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %7, !dbg !54
  %23 = load i32, ptr addrspace(4) %add.ptr104, align 4, !dbg !55, !tbaa !30
  %add.ptr104.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %9, !dbg !54
  %24 = load i32, ptr addrspace(4) %add.ptr104.1, align 4, !dbg !55, !tbaa !30
  %add.ptr104.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %11, !dbg !54
  %25 = load i32, ptr addrspace(4) %add.ptr104.2, align 4, !dbg !55, !tbaa !30
  %add.ptr104.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %13, !dbg !54
  %26 = load i32, ptr addrspace(4) %add.ptr104.3, align 4, !dbg !55, !tbaa !30
  %add.ptr104.1693 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %15, !dbg !54
  %27 = load i32, ptr addrspace(4) %add.ptr104.1693, align 4, !dbg !55, !tbaa !30
  %add.ptr104.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %17, !dbg !54
  %28 = load i32, ptr addrspace(4) %add.ptr104.1.1, align 4, !dbg !55, !tbaa !30
  %add.ptr104.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %19, !dbg !54
  %29 = load i32, ptr addrspace(4) %add.ptr104.2.1, align 4, !dbg !55, !tbaa !30
  %add.ptr104.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %21, !dbg !54
  %30 = load i32, ptr addrspace(4) %add.ptr104.3.1, align 4, !dbg !55, !tbaa !30
  %mul128 = and i32 %mul11, 8128
  %call132.masked = and i32 %2, 1016
  %mul134 = xor i32 %mul61, %call132.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul128, !dbg !56
  %invariant.gep632 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul134, !dbg !56
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep632, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !dbg !57, !call_argsrelate !58
  %gep633.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep632, i32 1024, !dbg !59
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep633.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !dbg !57, !call_argsrelate !58
  fence syncscope("warp") release, !dbg !60
  tail call void @llvm.mxc.barrier.warp(), !dbg !66
  fence syncscope("warp") acquire, !dbg !67
  %and146 = shl nuw nsw i32 %2, 6
  %mul147 = and i32 %and146, 960
  %shr150 = lshr i32 %2, 4
  %and153 = and i32 %2, 7
  %31 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul147
  %xor154 = xor i32 %shr150, %and153, !dbg !68
  %add.ptr158.idx = shl nuw nsw i32 %xor154, 4, !dbg !69
  %add.ptr158 = getelementptr inbounds i8, ptr addrspace(3) %31, i32 %add.ptr158.idx, !dbg !69
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr158, align 16, !dbg !70
  %Q_reg.sroa.4.0.add.ptr158.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr158, i32 8, !dbg !70
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr158.sroa_idx, align 8, !dbg !70
  %add151.1 = add nuw nsw i32 %shr150, 4, !dbg !71
  %xor154.1 = xor i32 %add151.1, %and153, !dbg !68
  %add.ptr158.idx.1 = shl nuw nsw i32 %xor154.1, 4, !dbg !69
  %add.ptr158.1 = getelementptr inbounds i8, ptr addrspace(3) %31, i32 %add.ptr158.idx.1, !dbg !69
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr158.1, align 16, !dbg !70
  %Q_reg.sroa.7.16.add.ptr158.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr158.1, i32 8, !dbg !70
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr158.1.sroa_idx, align 8, !dbg !70
  fence syncscope("warp") release, !dbg !72
  tail call void @llvm.mxc.barrier.warp(), !dbg !75
  fence syncscope("warp") acquire, !dbg !76
  store i32 %8, ptr addrspace(3) %invariant.gep632, align 16, !dbg !77, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep637.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep632, i32 4, !dbg !77
  store i32 %10, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep637.sroa_idx, align 4, !dbg !77, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep637.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep632, i32 8, !dbg !77
  store i32 %12, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep637.sroa_idx, align 8, !dbg !77, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep637.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep632, i32 12, !dbg !77
  store i32 %14, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep637.sroa_idx, align 4, !dbg !77, !tbaa !30
  store i32 %16, ptr addrspace(3) %gep633.1, align 16, !dbg !77, !tbaa !30
  %K_reg.sroa.9.16.gep638.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep632, i32 1028, !dbg !77
  store i32 %18, ptr addrspace(3) %K_reg.sroa.9.16.gep638.1.sroa_idx, align 4, !dbg !77, !tbaa !30
  %K_reg.sroa.10.16.gep638.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep632, i32 1032, !dbg !77
  store i32 %20, ptr addrspace(3) %K_reg.sroa.10.16.gep638.1.sroa_idx, align 8, !dbg !77, !tbaa !30
  %K_reg.sroa.11.16.gep638.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep632, i32 1036, !dbg !77
  store i32 %22, ptr addrspace(3) %K_reg.sroa.11.16.gep638.1.sroa_idx, align 4, !dbg !77, !tbaa !30
  fence syncscope("warp") release, !dbg !78
  tail call void @llvm.mxc.barrier.warp(), !dbg !81
  fence syncscope("warp") acquire, !dbg !82
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr158, align 16, !dbg !83
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr158.sroa_idx, align 8, !dbg !83
  %32 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !84
  %33 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %32), !dbg !84
  %kb.sroa.0.0.copyload723 = load <4 x half>, ptr addrspace(3) %add.ptr158.1, align 16, !dbg !83
  %kb.sroa.6.0.copyload724 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr158.1.sroa_idx, align 8, !dbg !83
  %34 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload723, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %33), !dbg !84
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload724, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %34), !dbg !84
  fence syncscope("warp") release, !dbg !85
  tail call void @llvm.mxc.barrier.warp(), !dbg !88
  fence syncscope("warp") acquire, !dbg !89
  %invariant.gep645 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %6, !dbg !90
  store i32 %23, ptr addrspace(3) %invariant.gep645, align 16, !dbg !91, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep645.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep645, i32 4, !dbg !91
  store i32 %24, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep645.sroa_idx, align 4, !dbg !91, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep645.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep645, i32 8, !dbg !91
  store i32 %25, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep645.sroa_idx, align 8, !dbg !91, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep645.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep645, i32 12, !dbg !91
  store i32 %26, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep645.sroa_idx, align 4, !dbg !91, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep645, i32 1024, !dbg !92
  store i32 %27, ptr addrspace(3) %gep.1, align 16, !dbg !91, !tbaa !30
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep645, i32 1028, !dbg !91
  store i32 %28, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !dbg !91, !tbaa !30
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep645, i32 1032, !dbg !91
  store i32 %29, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !dbg !91, !tbaa !30
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep645, i32 1036, !dbg !91
  store i32 %30, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !dbg !91, !tbaa !30
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %35, i64 0, !dbg !93
  %mul260 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !94
  %36 = tail call contract noundef float @llvm.minnum.f32(float %mul260, float 0x4024CB5EC0000000), !dbg !95
  %37 = tail call contract noundef float @llvm.exp.f32(float %36), !dbg !99
  %acc_s.sroa.0.0.vec.insert730 = insertelement <4 x float> poison, float %37, i64 0, !dbg !102
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %35, i64 1, !dbg !93
  %mul260.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !94
  %38 = tail call contract noundef float @llvm.minnum.f32(float %mul260.1, float 0x4024CB5EC0000000), !dbg !95
  %39 = tail call contract noundef float @llvm.exp.f32(float %38), !dbg !99
  %acc_s.sroa.0.4.vec.insert745 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert730, float %39, i64 1, !dbg !102
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %35, i64 2, !dbg !93
  %mul260.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !94
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul260.2, float 0x4024CB5EC0000000), !dbg !95
  %41 = tail call contract noundef float @llvm.exp.f32(float %40), !dbg !99
  %acc_s.sroa.0.8.vec.insert760 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert745, float %41, i64 2, !dbg !102
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %35, i64 3, !dbg !93
  %mul260.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !94
  %42 = tail call contract noundef float @llvm.minnum.f32(float %mul260.3, float 0x4024CB5EC0000000), !dbg !95
  %43 = tail call contract noundef float @llvm.exp.f32(float %42), !dbg !99
  %acc_s.sroa.0.12.vec.insert775 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert760, float %43, i64 3, !dbg !102
  %cmp270 = icmp eq i32 %5, %shr, !dbg !103
  br i1 %cmp270, label %for.cond272.preheader, label %if.end291, !dbg !104

for.cond272.preheader:                            ; preds = %for.cond41.preheader
  %44 = lshr i32 %2, 2
  %mul278 = and i32 %44, 252
  %and281 = and i32 %0, 15
  %cmp282.not = icmp ugt i32 %mul278, %and281, !dbg !105
  %spec.select = select i1 %cmp282.not, float 0.000000e+00, float %37, !dbg !106
  %acc_s.sroa.0.0.vec.insert734 = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !107
  %cmp282.not.1.not = icmp ult i32 %mul278, %and281, !dbg !105
  %condval.0.1 = select i1 %cmp282.not.1.not, float %39, float 0.000000e+00, !dbg !106
  %acc_s.sroa.0.4.vec.insert749 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert734, float %condval.0.1, i64 1, !dbg !107
  %add279.2 = or disjoint i32 %mul278, 2, !dbg !108
  %cmp282.not.2 = icmp ugt i32 %add279.2, %and281, !dbg !105
  %condval.0.2 = select i1 %cmp282.not.2, float 0.000000e+00, float %41, !dbg !106
  %acc_s.sroa.0.8.vec.insert764 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert749, float %condval.0.2, i64 2, !dbg !107
  %add279.3 = or i32 %44, 3, !dbg !108
  %cmp282.not.3 = icmp ugt i32 %add279.3, %and281, !dbg !105
  %condval.0.3 = select i1 %cmp282.not.3, float 0.000000e+00, float %43, !dbg !106
  %acc_s.sroa.0.12.vec.insert779 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert764, float %condval.0.3, i64 3, !dbg !107
  br label %if.end291, !dbg !109

if.end291:                                        ; preds = %for.cond272.preheader, %for.cond41.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert779, %for.cond272.preheader ], [ %acc_s.sroa.0.12.vec.insert775, %for.cond41.preheader ], !dbg !110
  %acc_s.sroa.0.0.vec.extract736 = extractelement <4 x float> %acc_s.sroa.0.0, i64 0, !dbg !111
  %add300 = fadd contract float %acc_s.sroa.0.0.vec.extract736, 0.000000e+00, !dbg !112
  %acc_s.sroa.0.4.vec.extract751 = extractelement <4 x float> %acc_s.sroa.0.0, i64 1, !dbg !111
  %add300.1 = fadd contract float %add300, %acc_s.sroa.0.4.vec.extract751, !dbg !112
  %acc_s.sroa.0.8.vec.extract766 = extractelement <4 x float> %acc_s.sroa.0.0, i64 2, !dbg !111
  %add300.2 = fadd contract float %add300.1, %acc_s.sroa.0.8.vec.extract766, !dbg !112
  %acc_s.sroa.0.12.vec.extract781 = extractelement <4 x float> %acc_s.sroa.0.0, i64 3, !dbg !111
  %add300.3 = fadd contract float %add300.2, %acc_s.sroa.0.12.vec.extract781, !dbg !112
  %45 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add300.3, <4 x float> zeroinitializer), !dbg !113
  %wsum_output.sroa.0.0.vec.extract = extractelement <4 x float> %45, i64 0, !dbg !114
  %cmp318 = fcmp contract ogt float %wsum_output.sroa.0.0.vec.extract, 0.000000e+00, !dbg !115
  %cmp.i.i = fcmp contract olt float %wsum_output.sroa.0.0.vec.extract, 0x39B0000000000000
  %cond.i.i = select contract i1 %cmp.i.i, float 0x4630000000000000, float 1.000000e+00
  %mul.i.i = fmul contract float %wsum_output.sroa.0.0.vec.extract, %cond.i.i
  %46 = tail call contract float @llvm.mxc.rsq.f32(float %mul.i.i)
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x4310000000000000, float 1.000000e+00
  %mul3.i.i = fmul contract float %cond2.i.i, %46
  %mul324 = fmul contract float %mul3.i.i, %mul3.i.i
  %condval_1.0 = select i1 %cmp318, float %mul324, float 0.000000e+00, !dbg !116
  %mul335 = fmul contract float %condval_1.0, %acc_s.sroa.0.0.vec.extract736, !dbg !117
  %acc_s.sroa.0.4.vec.extract753 = extractelement <4 x float> %acc_s.sroa.0.0, i64 1, !dbg !118
  %mul335.1 = fmul contract float %condval_1.0, %acc_s.sroa.0.4.vec.extract753, !dbg !117
  %acc_s.sroa.0.8.vec.extract768 = extractelement <4 x float> %acc_s.sroa.0.0, i64 2, !dbg !118
  %mul335.2 = fmul contract float %condval_1.0, %acc_s.sroa.0.8.vec.extract768, !dbg !117
  %acc_s.sroa.0.12.vec.extract783 = extractelement <4 x float> %acc_s.sroa.0.0, i64 3, !dbg !118
  %mul335.3 = fmul contract float %condval_1.0, %acc_s.sroa.0.12.vec.extract783, !dbg !117
  %47 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul335), !dbg !119
  %48 = insertelement <4 x i16> poison, i16 %47, i64 0, !dbg !128
  %49 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul335.1), !dbg !119
  %50 = insertelement <4 x i16> %48, i16 %49, i64 1, !dbg !128
  %51 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul335.2), !dbg !119
  %52 = insertelement <4 x i16> %50, i16 %51, i64 2, !dbg !128
  %53 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul335.3), !dbg !119
  %54 = insertelement <4 x i16> %52, i16 %53, i64 3, !dbg !128
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %54 to <4 x half>, !dbg !128
  fence syncscope("warp") release, !dbg !129
  tail call void @llvm.mxc.barrier.warp(), !dbg !132
  fence syncscope("warp") acquire, !dbg !133
  br label %if.end353, !dbg !134

if.end353:                                        ; preds = %entry, %if.end291
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ %acc_s_cast.sroa.0.6.vec.insert, %if.end291 ], [ undef, %entry ]
  %cmp369 = icmp ugt i32 %5, 15
  %cmp373.not = icmp ugt i32 %5, %shr
  %or.cond666 = or i1 %cmp369, %cmp373.not, !dbg !135
  br i1 %or.cond666, label %if.end423, label %for.cond375.preheader, !dbg !135

for.cond375.preheader:                            ; preds = %if.end353
  %55 = shl nuw nsw i32 %2, 4
  %mul385 = and i32 %55, 16128
  %and391 = and i32 %2, 15
  %add392 = or disjoint i32 %mul385, %and391, !dbg !136
  %arrayidx394 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add392, !dbg !137
  %56 = load half, ptr addrspace(3) %arrayidx394, align 2, !dbg !138, !tbaa !139
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %56, i64 0, !dbg !138
  %add387.1 = or disjoint i32 %mul385, %and391, !dbg !136
  %add392.1 = or disjoint i32 %add387.1, 64, !dbg !136
  %arrayidx394.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add392.1, !dbg !137
  %57 = load half, ptr addrspace(3) %arrayidx394.1, align 2, !dbg !138, !tbaa !139
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %57, i64 1, !dbg !138
  %add387.2 = or disjoint i32 %mul385, %and391, !dbg !136
  %add392.2 = or disjoint i32 %add387.2, 128, !dbg !136
  %arrayidx394.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add392.2, !dbg !137
  %58 = load half, ptr addrspace(3) %arrayidx394.2, align 2, !dbg !138, !tbaa !139
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %58, i64 2, !dbg !138
  %add387.3 = or disjoint i32 %mul385, %and391, !dbg !136
  %add392.3 = or disjoint i32 %add387.3, 192, !dbg !136
  %arrayidx394.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add392.3, !dbg !137
  %59 = load half, ptr addrspace(3) %arrayidx394.3, align 2, !dbg !138, !tbaa !139
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %59, i64 3, !dbg !138
  %add389.1697 = or disjoint i32 %mul385, %and391, !dbg !136
  %add392.1698 = or disjoint i32 %add389.1697, 16, !dbg !136
  %arrayidx394.1699 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add392.1698, !dbg !137
  %60 = load half, ptr addrspace(3) %arrayidx394.1699, align 2, !dbg !138, !tbaa !139
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %60, i64 0, !dbg !138
  %add389.1.1 = or disjoint i32 %mul385, %and391, !dbg !136
  %add392.1.1 = or disjoint i32 %add389.1.1, 80, !dbg !136
  %arrayidx394.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add392.1.1, !dbg !137
  %61 = load half, ptr addrspace(3) %arrayidx394.1.1, align 2, !dbg !138, !tbaa !139
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %61, i64 1, !dbg !138
  %add389.2.1 = or disjoint i32 %mul385, %and391, !dbg !136
  %add392.2.1 = or disjoint i32 %add389.2.1, 144, !dbg !136
  %arrayidx394.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add392.2.1, !dbg !137
  %62 = load half, ptr addrspace(3) %arrayidx394.2.1, align 2, !dbg !138, !tbaa !139
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %62, i64 2, !dbg !138
  %add389.3.1 = or disjoint i32 %mul385, %and391, !dbg !136
  %add392.3.1 = or disjoint i32 %add389.3.1, 208, !dbg !136
  %arrayidx394.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add392.3.1, !dbg !137
  %63 = load half, ptr addrspace(3) %arrayidx394.3.1, align 2, !dbg !138, !tbaa !139
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %63, i64 3, !dbg !138
  %add389.2701 = or disjoint i32 %mul385, %and391, !dbg !136
  %add392.2702 = or disjoint i32 %add389.2701, 32, !dbg !136
  %arrayidx394.2703 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add392.2702, !dbg !137
  %64 = load half, ptr addrspace(3) %arrayidx394.2703, align 2, !dbg !138, !tbaa !139
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %64, i64 0, !dbg !138
  %add389.1.2 = or disjoint i32 %mul385, %and391, !dbg !136
  %add392.1.2 = or disjoint i32 %add389.1.2, 96, !dbg !136
  %arrayidx394.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add392.1.2, !dbg !137
  %65 = load half, ptr addrspace(3) %arrayidx394.1.2, align 2, !dbg !138, !tbaa !139
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %65, i64 1, !dbg !138
  %add389.2.2 = or disjoint i32 %mul385, %and391, !dbg !136
  %add392.2.2 = or disjoint i32 %add389.2.2, 160, !dbg !136
  %arrayidx394.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add392.2.2, !dbg !137
  %66 = load half, ptr addrspace(3) %arrayidx394.2.2, align 2, !dbg !138, !tbaa !139
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %66, i64 2, !dbg !138
  %add389.3.2 = or disjoint i32 %mul385, %and391, !dbg !136
  %add392.3.2 = or disjoint i32 %add389.3.2, 224, !dbg !136
  %arrayidx394.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add392.3.2, !dbg !137
  %67 = load half, ptr addrspace(3) %arrayidx394.3.2, align 2, !dbg !138, !tbaa !139
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %67, i64 3, !dbg !138
  %add389.3705 = or disjoint i32 %mul385, %and391, !dbg !136
  %add392.3706 = or disjoint i32 %add389.3705, 48, !dbg !136
  %arrayidx394.3707 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add392.3706, !dbg !137
  %68 = load half, ptr addrspace(3) %arrayidx394.3707, align 2, !dbg !138, !tbaa !139
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %68, i64 0, !dbg !138
  %add389.1.3 = or disjoint i32 %mul385, %and391, !dbg !136
  %add392.1.3 = or disjoint i32 %add389.1.3, 112, !dbg !136
  %arrayidx394.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add392.1.3, !dbg !137
  %69 = load half, ptr addrspace(3) %arrayidx394.1.3, align 2, !dbg !138, !tbaa !139
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %69, i64 1, !dbg !138
  %add389.2.3 = or disjoint i32 %mul385, %and391, !dbg !136
  %add392.2.3 = or disjoint i32 %add389.2.3, 176, !dbg !136
  %arrayidx394.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add392.2.3, !dbg !137
  %70 = load half, ptr addrspace(3) %arrayidx394.2.3, align 2, !dbg !138, !tbaa !139
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %70, i64 2, !dbg !138
  %add389.3.3 = or disjoint i32 %55, %and391, !dbg !136
  %add392.3.3 = or i32 %add389.3.3, 240, !dbg !136
  %arrayidx394.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add392.3.3, !dbg !137
  %71 = load half, ptr addrspace(3) %arrayidx394.3.3, align 2, !dbg !138, !tbaa !139
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %71, i64 3, !dbg !138
  %72 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !140
  %73 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !140
  %74 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !140
  %75 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !140
  br label %if.end423, !dbg !141

if.end423:                                        ; preds = %for.cond375.preheader, %if.end353
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end353 ], [ %72, %for.cond375.preheader ], !dbg !110
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end353 ], [ %73, %for.cond375.preheader ], !dbg !110
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end353 ], [ %74, %for.cond375.preheader ], !dbg !110
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end353 ], [ %75, %for.cond375.preheader ], !dbg !110
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0, !dbg !142
  %76 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract), !dbg !143
  %O_reg.sroa.0.0.insert.ext = zext i16 %76 to i64, !dbg !147
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1, !dbg !142
  %77 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract), !dbg !143
  %O_reg.sroa.0.2.insert.ext = zext i16 %77 to i64, !dbg !147
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !147
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !147
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2, !dbg !142
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract), !dbg !143
  %O_reg.sroa.0.4.insert.ext = zext i16 %78 to i64, !dbg !147
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !147
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !147
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3, !dbg !142
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract), !dbg !143
  %O_reg.sroa.0.6.insert.ext = zext i16 %79 to i64, !dbg !147
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !147
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !147
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0, !dbg !142
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract), !dbg !143
  %O_reg.sroa.7.8.insert.ext = zext i16 %80 to i64, !dbg !147
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1, !dbg !142
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract), !dbg !143
  %O_reg.sroa.7.10.insert.ext = zext i16 %81 to i64, !dbg !147
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !147
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !147
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2, !dbg !142
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract), !dbg !143
  %O_reg.sroa.7.12.insert.ext = zext i16 %82 to i64, !dbg !147
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !147
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !147
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3, !dbg !142
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract), !dbg !143
  %O_reg.sroa.7.14.insert.ext = zext i16 %83 to i64, !dbg !147
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !147
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !147
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0, !dbg !142
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract), !dbg !143
  %O_reg.sroa.12.16.insert.ext = zext i16 %84 to i64, !dbg !147
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1, !dbg !142
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract), !dbg !143
  %O_reg.sroa.12.18.insert.ext = zext i16 %85 to i64, !dbg !147
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !147
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !147
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2, !dbg !142
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract), !dbg !143
  %O_reg.sroa.12.20.insert.ext = zext i16 %86 to i64, !dbg !147
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !147
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !147
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3, !dbg !142
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract), !dbg !143
  %O_reg.sroa.12.22.insert.ext = zext i16 %87 to i64, !dbg !147
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !147
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !147
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0, !dbg !142
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract), !dbg !143
  %O_reg.sroa.17.24.insert.ext = zext i16 %88 to i64, !dbg !147
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1, !dbg !142
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract), !dbg !143
  %O_reg.sroa.17.26.insert.ext = zext i16 %89 to i64, !dbg !147
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !147
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !147
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2, !dbg !142
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract), !dbg !143
  %O_reg.sroa.17.28.insert.ext = zext i16 %90 to i64, !dbg !147
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !147
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !147
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3, !dbg !142
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract), !dbg !143
  %O_reg.sroa.17.30.insert.ext = zext i16 %91 to i64, !dbg !147
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !147
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !147
  fence syncscope("warp") release, !dbg !148
  tail call void @llvm.mxc.barrier.warp(), !dbg !151
  fence syncscope("warp") acquire, !dbg !152
  %and456 = shl nuw nsw i32 %2, 6
  %mul457 = and i32 %and456, 960
  %shr460 = lshr i32 %2, 5
  %and463 = and i32 %2, 7
  %92 = lshr i32 %2, 2
  %mul470 = and i32 %92, 4
  %xor464 = xor i32 %shr460, %and463, !dbg !153
  %mul465 = shl nuw nsw i32 %xor464, 3, !dbg !154
  %add466 = add nuw nsw i32 %mul465, %mul457, !dbg !155
  %add471 = or disjoint i32 %add466, %mul470, !dbg !156
  %add.ptr473 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add471, !dbg !157
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr473, align 8, !dbg !158
  %add461.1 = add nuw nsw i32 %shr460, 2, !dbg !159
  %xor464.1 = xor i32 %add461.1, %and463, !dbg !153
  %mul465.1 = shl nuw nsw i32 %xor464.1, 3, !dbg !154
  %add466.1 = add nuw nsw i32 %mul465.1, %mul457, !dbg !155
  %add471.1 = or disjoint i32 %add466.1, %mul470, !dbg !156
  %add.ptr473.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add471.1, !dbg !157
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr473.1, align 8, !dbg !158
  %add461.2 = add nuw nsw i32 %shr460, 4, !dbg !159
  %xor464.2 = xor i32 %add461.2, %and463, !dbg !153
  %mul465.2 = shl nuw nsw i32 %xor464.2, 3, !dbg !154
  %add466.2 = add nuw nsw i32 %mul465.2, %mul457, !dbg !155
  %add471.2 = or disjoint i32 %add466.2, %mul470, !dbg !156
  %add.ptr473.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add471.2, !dbg !157
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr473.2, align 8, !dbg !158
  %add461.3 = add nuw nsw i32 %shr460, 6, !dbg !159
  %xor464.3 = xor i32 %add461.3, %and463, !dbg !153
  %mul465.3 = shl nuw nsw i32 %xor464.3, 3, !dbg !154
  %add466.3 = add nuw nsw i32 %mul465.3, %mul457, !dbg !155
  %add471.3 = or disjoint i32 %add466.3, %mul470, !dbg !156
  %add.ptr473.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add471.3, !dbg !157
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr473.3, align 8, !dbg !158
  fence syncscope("warp") release, !dbg !160
  tail call void @llvm.mxc.barrier.warp(), !dbg !163
  fence syncscope("warp") acquire, !dbg !164
  %mul484 = and i32 %mul11, 8128
  %xor490613 = and i32 %mul11, 56
  %call488.masked = and i32 %2, 1016
  %mul491 = xor i32 %xor490613, %call488.masked
  %invariant.gep660 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul484, !dbg !165
  %invariant.gep662 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep660, i32 %mul491, !dbg !165
  %add.ptr506 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %3, !dbg !166
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr506, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep662, i64 16, i1 false), !dbg !167, !tbaa.struct !168, !call_argsrelate !169
  %gep663.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep662, i32 1024, !dbg !170
  %add.ptr506.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4, !dbg !166
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr506.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep663.1, i64 16, i1 false), !dbg !167, !tbaa.struct !168, !call_argsrelate !169
  ret void, !dbg !171
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

; Function Attrs: nounwind speculatable willreturn memory(none)
declare float @llvm.mxc.rsq.f32(float) #5

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
!1 = !DIFile(filename: "/tmp/tmpj967mejb/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpj967mejb/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 28, column: 3, scope: !40)
!44 = !DILocation(line: 29, column: 123, scope: !40)
!45 = !DILocation(line: 31, column: 58, scope: !40)
!46 = !DILocation(line: 31, column: 63, scope: !40)
!47 = !DILocation(line: 31, column: 25, scope: !40)
!48 = !DILocation(line: 37, column: 31, scope: !40)
!49 = !DILocation(line: 29, column: 48, scope: !40)
!50 = !DILocation(line: 40, column: 5, scope: !40)
!51 = !DILocation(line: 43, column: 79, scope: !40)
!52 = !DILocation(line: 43, column: 58, scope: !40)
!53 = !DILocation(line: 43, column: 229, scope: !40)
!54 = !DILocation(line: 50, column: 79, scope: !40)
!55 = !DILocation(line: 50, column: 58, scope: !40)
!56 = !DILocation(line: 54, column: 5, scope: !40)
!57 = !DILocation(line: 55, column: 159, scope: !40)
!58 = !{i32 1, i32 3, i32 -1, i32 -1}
!59 = !DILocation(line: 55, column: 42, scope: !40)
!60 = !DILocation(line: 68, column: 3, scope: !61, inlinedAt: !63)
!61 = distinct !DISubprogram(name: "__barrier_warp", scope: !62, file: !62, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!62 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!63 = distinct !DILocation(line: 192, column: 3, scope: !64, inlinedAt: !65)
!64 = distinct !DISubprogram(name: "__syncwarp", scope: !62, file: !62, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!65 = distinct !DILocation(line: 57, column: 5, scope: !40)
!66 = !DILocation(line: 69, column: 3, scope: !61, inlinedAt: !63)
!67 = !DILocation(line: 70, column: 3, scope: !61, inlinedAt: !63)
!68 = !DILocation(line: 60, column: 153, scope: !40)
!69 = !DILocation(line: 60, column: 73, scope: !40)
!70 = !DILocation(line: 60, column: 36, scope: !40)
!71 = !DILocation(line: 60, column: 124, scope: !40)
!72 = !DILocation(line: 68, column: 3, scope: !61, inlinedAt: !73)
!73 = distinct !DILocation(line: 192, column: 3, scope: !64, inlinedAt: !74)
!74 = distinct !DILocation(line: 62, column: 5, scope: !40)
!75 = !DILocation(line: 69, column: 3, scope: !61, inlinedAt: !73)
!76 = !DILocation(line: 70, column: 3, scope: !61, inlinedAt: !73)
!77 = !DILocation(line: 65, column: 159, scope: !40)
!78 = !DILocation(line: 68, column: 3, scope: !61, inlinedAt: !79)
!79 = distinct !DILocation(line: 192, column: 3, scope: !64, inlinedAt: !80)
!80 = distinct !DILocation(line: 69, column: 5, scope: !40)
!81 = !DILocation(line: 69, column: 3, scope: !61, inlinedAt: !79)
!82 = !DILocation(line: 70, column: 3, scope: !61, inlinedAt: !79)
!83 = !DILocation(line: 71, column: 25, scope: !40)
!84 = !DILocation(line: 74, column: 36, scope: !40)
!85 = !DILocation(line: 68, column: 3, scope: !61, inlinedAt: !86)
!86 = distinct !DILocation(line: 192, column: 3, scope: !64, inlinedAt: !87)
!87 = distinct !DILocation(line: 80, column: 5, scope: !40)
!88 = !DILocation(line: 69, column: 3, scope: !61, inlinedAt: !86)
!89 = !DILocation(line: 70, column: 3, scope: !61, inlinedAt: !86)
!90 = !DILocation(line: 82, column: 10, scope: !40)
!91 = !DILocation(line: 83, column: 86, scope: !40)
!92 = !DILocation(line: 83, column: 42, scope: !40)
!93 = !DILocation(line: 87, column: 30, scope: !40)
!94 = !DILocation(line: 87, column: 41, scope: !40)
!95 = !DILocation(line: 354, column: 10, scope: !96, inlinedAt: !98)
!96 = distinct !DISubprogram(name: "min", scope: !97, file: !97, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!97 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!98 = distinct !DILocation(line: 87, column: 25, scope: !40)
!99 = !DILocation(line: 288, column: 10, scope: !100, inlinedAt: !101)
!100 = distinct !DISubprogram(name: "expf", scope: !97, file: !97, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!101 = distinct !DILocation(line: 87, column: 20, scope: !40)
!102 = !DILocation(line: 87, column: 18, scope: !40)
!103 = !DILocation(line: 89, column: 25, scope: !40)
!104 = !DILocation(line: 89, column: 9, scope: !40)
!105 = !DILocation(line: 93, column: 54, scope: !40)
!106 = !DILocation(line: 93, column: 13, scope: !40)
!107 = !DILocation(line: 98, column: 20, scope: !40)
!108 = !DILocation(line: 93, column: 47, scope: !40)
!109 = !DILocation(line: 103, column: 5, scope: !40)
!110 = !DILocation(line: 0, scope: !40)
!111 = !DILocation(line: 104, column: 36, scope: !40)
!112 = !DILocation(line: 104, column: 34, scope: !40)
!113 = !DILocation(line: 109, column: 42, scope: !40)
!114 = !DILocation(line: 114, column: 36, scope: !40)
!115 = !DILocation(line: 114, column: 34, scope: !40)
!116 = !DILocation(line: 114, column: 9, scope: !40)
!117 = !DILocation(line: 122, column: 32, scope: !40)
!118 = !DILocation(line: 122, column: 21, scope: !40)
!119 = !DILocation(line: 75, column: 10, scope: !120, inlinedAt: !122)
!120 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !121, file: !121, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!121 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!122 = distinct !DILocation(line: 984, column: 9, scope: !123, inlinedAt: !125)
!123 = distinct !DISubprogram(name: "__float2half", scope: !124, file: !124, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!124 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!125 = distinct !DILocation(line: 133, column: 53, scope: !126, inlinedAt: !127)
!126 = distinct !DISubprogram(name: "__half", scope: !124, file: !124, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!127 = distinct !DILocation(line: 126, column: 32, scope: !40)
!128 = !DILocation(line: 126, column: 29, scope: !40)
!129 = !DILocation(line: 68, column: 3, scope: !61, inlinedAt: !130)
!130 = distinct !DILocation(line: 192, column: 3, scope: !64, inlinedAt: !131)
!131 = distinct !DILocation(line: 128, column: 5, scope: !40)
!132 = !DILocation(line: 69, column: 3, scope: !61, inlinedAt: !130)
!133 = !DILocation(line: 70, column: 3, scope: !61, inlinedAt: !130)
!134 = !DILocation(line: 129, column: 3, scope: !40)
!135 = !DILocation(line: 135, column: 31, scope: !40)
!136 = !DILocation(line: 138, column: 119, scope: !40)
!137 = !DILocation(line: 138, column: 31, scope: !40)
!138 = !DILocation(line: 138, column: 29, scope: !40)
!139 = !{!26, !26, i64 0}
!140 = !DILocation(line: 143, column: 38, scope: !40)
!141 = !DILocation(line: 150, column: 3, scope: !40)
!142 = !DILocation(line: 153, column: 58, scope: !40)
!143 = !DILocation(line: 75, column: 10, scope: !120, inlinedAt: !144)
!144 = distinct !DILocation(line: 984, column: 9, scope: !123, inlinedAt: !145)
!145 = distinct !DILocation(line: 133, column: 53, scope: !126, inlinedAt: !146)
!146 = distinct !DILocation(line: 153, column: 50, scope: !40)
!147 = !DILocation(line: 153, column: 47, scope: !40)
!148 = !DILocation(line: 68, column: 3, scope: !61, inlinedAt: !149)
!149 = distinct !DILocation(line: 192, column: 3, scope: !64, inlinedAt: !150)
!150 = distinct !DILocation(line: 156, column: 3, scope: !40)
!151 = !DILocation(line: 69, column: 3, scope: !61, inlinedAt: !149)
!152 = !DILocation(line: 70, column: 3, scope: !61, inlinedAt: !149)
!153 = !DILocation(line: 159, column: 122, scope: !40)
!154 = !DILocation(line: 159, column: 150, scope: !40)
!155 = !DILocation(line: 159, column: 77, scope: !40)
!156 = !DILocation(line: 159, column: 156, scope: !40)
!157 = !DILocation(line: 159, column: 40, scope: !40)
!158 = !DILocation(line: 159, column: 199, scope: !40)
!159 = !DILocation(line: 159, column: 93, scope: !40)
!160 = !DILocation(line: 68, column: 3, scope: !61, inlinedAt: !161)
!161 = distinct !DILocation(line: 192, column: 3, scope: !64, inlinedAt: !162)
!162 = distinct !DILocation(line: 161, column: 3, scope: !40)
!163 = !DILocation(line: 69, column: 3, scope: !61, inlinedAt: !161)
!164 = !DILocation(line: 70, column: 3, scope: !61, inlinedAt: !161)
!165 = !DILocation(line: 163, column: 8, scope: !40)
!166 = !DILocation(line: 164, column: 22, scope: !40)
!167 = !DILocation(line: 164, column: 129, scope: !40)
!168 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!169 = !{i32 2, i32 -1, i32 -1, i32 -1}
!170 = !DILocation(line: 164, column: 166, scope: !40)
!171 = !DILocation(line: 166, column: 1, scope: !40)
