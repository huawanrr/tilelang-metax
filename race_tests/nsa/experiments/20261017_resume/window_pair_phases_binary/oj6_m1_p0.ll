; ModuleID = 'experiments/20261017_resume/window_pair_phases_binary/oj6_m1_p0.bc'
source_filename = "/tmp/tmpyp6j048g/tvm_kernels.maca"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5-G1-ni:7"
target triple = "mxc-metax-macahca"

%struct.mcDevMallocInfo.0 = type { i32, i32, ptr }
%struct.__half = type { i16 }

@buf_dyn_shmem = external protected addrspace(3) global [0 x i8], align 1024
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
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %Indices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %PackedKV.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Schedule.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V.coerce) local_unnamed_addr #3 !dbg !40 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !dbg !42, !range !29
  %cmp = icmp ult i32 %0, 128, !dbg !46
  br i1 %cmp, label %for.cond.preheader, label %if.else, !dbg !47

for.cond.preheader:                               ; preds = %entry
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul = shl nsw i32 %1, 17
  %2 = shl nuw nsw i32 %0, 10
  %mul9 = and i32 %2, 129024
  %add = or disjoint i32 %mul9, %mul
  %3 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !48
  %4 = shl nuw nsw i32 %3, 4
  %mul14 = and i32 %4, 16256
  %add11 = add nuw nsw i32 %add, %mul14
  %and = shl nuw nsw i32 %0, 6
  %mul17 = and i32 %and, 64
  %and20 = shl nuw nsw i32 %3, 3
  %mul21 = and i32 %and20, 56
  %add15 = or disjoint i32 %add11, %mul17
  %add18 = or disjoint i32 %add15, %mul21
  %5 = zext nneg i32 %add18 to i64, !dbg !49
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %5, !dbg !50
  %6 = add nuw nsw i64 %5, 1024, !dbg !51
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %6, !dbg !50
  %add.ptr52 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %5, !dbg !52
  %tile.sroa.0.0.copyload = load i64, ptr addrspace(4) %add.ptr52, align 16, !dbg !53
  %tile.sroa.4.0.add.ptr52.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr52, i64 8, !dbg !53
  %tile.sroa.4.0.copyload = load i64, ptr addrspace(4) %tile.sroa.4.0.add.ptr52.sroa_idx, align 8, !dbg !53
  %add.ptr52.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %6, !dbg !52
  %tile.sroa.5.16.copyload = load i64, ptr addrspace(4) %add.ptr52.1, align 16, !dbg !53
  %tile.sroa.7.16.add.ptr52.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr52.1, i64 8, !dbg !53
  %tile.sroa.7.16.copyload = load i64, ptr addrspace(4) %tile.sroa.7.16.add.ptr52.1.sroa_idx, align 8, !dbg !53
  %mul72 = and i32 %and20, 8128
  %call76.masked = and i32 %3, 1016
  %mul78 = xor i32 %mul21, %call76.masked
  %invariant.gep567 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul72, !dbg !54
  %invariant.gep569 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep567, i32 %mul78, !dbg !54
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep569, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !dbg !55, !call_argsrelate !56
  %gep570.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep569, i32 1024, !dbg !57
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep570.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !dbg !55, !call_argsrelate !56
  %and101 = shl nuw nsw i32 %3, 1
  %mul102 = and i32 %and101, 14
  %shr108 = lshr i32 %3, 3
  %xor110 = xor i32 %shr108, %mul102, !dbg !58
  %.idx551 = shl nuw nsw i32 %xor110, 3, !dbg !59
  %7 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep567, i32 %.idx551, !dbg !59
  %add.ptr115 = getelementptr inbounds i8, ptr addrspace(3) %7, i32 2048, !dbg !59
  store i64 %tile.sroa.0.0.copyload, ptr addrspace(3) %add.ptr115, align 8, !dbg !60
  %add104.1 = or disjoint i32 %mul102, 1, !dbg !61
  %xor110.1 = xor i32 %shr108, %add104.1, !dbg !58
  %.idx551.1 = shl nuw nsw i32 %xor110.1, 3, !dbg !59
  %8 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep567, i32 %.idx551.1, !dbg !59
  %add.ptr115.1 = getelementptr inbounds i8, ptr addrspace(3) %8, i32 2048, !dbg !59
  store i64 %tile.sroa.4.0.copyload, ptr addrspace(3) %add.ptr115.1, align 8, !dbg !60
  %add109.2 = add nuw nsw i32 %shr108, 8, !dbg !62
  %xor110.2 = xor i32 %add109.2, %mul102, !dbg !58
  %gep573.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep567, i32 1024, !dbg !59
  %.idx551.2 = shl nuw nsw i32 %xor110.2, 3, !dbg !59
  %9 = getelementptr inbounds i8, ptr addrspace(3) %gep573.2, i32 %.idx551.2, !dbg !59
  %add.ptr115.2 = getelementptr inbounds i8, ptr addrspace(3) %9, i32 2048, !dbg !59
  store i64 %tile.sroa.5.16.copyload, ptr addrspace(3) %add.ptr115.2, align 8, !dbg !60
  %xor110.3 = xor i32 %add109.2, %add104.1, !dbg !58
  %.idx551.3 = shl nuw nsw i32 %xor110.3, 3, !dbg !59
  %10 = getelementptr inbounds i8, ptr addrspace(3) %gep573.2, i32 %.idx551.3, !dbg !59
  %add.ptr115.3 = getelementptr inbounds i8, ptr addrspace(3) %10, i32 2048, !dbg !59
  store i64 %tile.sroa.7.16.copyload, ptr addrspace(3) %add.ptr115.3, align 8, !dbg !60
  fence syncscope("warp") release, !dbg !63
  tail call void @llvm.mxc.barrier.warp(), !dbg !69
  fence syncscope("warp") acquire, !dbg !70
  %and125 = shl nuw nsw i32 %3, 6
  %mul126 = and i32 %and125, 960
  %shr129 = lshr i32 %3, 4
  %and132 = and i32 %3, 7
  %11 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul126
  %xor133 = xor i32 %shr129, %and132, !dbg !71
  %add.ptr137.idx = shl nuw nsw i32 %xor133, 4, !dbg !72
  %add.ptr137 = getelementptr inbounds i8, ptr addrspace(3) %11, i32 %add.ptr137.idx, !dbg !72
  %add130.1 = add nuw nsw i32 %shr129, 4, !dbg !73
  %xor133.1 = xor i32 %add130.1, %and132, !dbg !71
  %add.ptr137.idx.1 = shl nuw nsw i32 %xor133.1, 4, !dbg !72
  %add.ptr137.1 = getelementptr inbounds i8, ptr addrspace(3) %11, i32 %add.ptr137.idx.1, !dbg !72
  %mul152 = and i32 %4, 16128
  %and159 = lshr i32 %3, 2
  %shr160 = and i32 %and159, 3
  %mul164 = and i32 %and159, 252
  %and171 = and i32 %3, 3
  %add155 = or disjoint i32 %mul152, %and171
  %12 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add155, !dbg !74
  %gep576.idx = shl nuw nsw i32 %and159, 3, !dbg !74
  %gep576 = getelementptr inbounds i8, ptr addrspace(3) %12, i32 %gep576.idx, !dbg !74
  %13 = load i16, ptr addrspace(3) %gep576, align 2, !dbg !75, !tbaa !76
  %add166.1 = or disjoint i32 %mul164, 1, !dbg !77
  %xor167.1 = xor i32 %shr160, %add166.1, !dbg !78
  %add169.1 = or disjoint i32 %add155, 64, !dbg !79
  %14 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add169.1, !dbg !74
  %gep576.idx.1 = shl nuw nsw i32 %xor167.1, 3, !dbg !74
  %gep576.1 = getelementptr inbounds i8, ptr addrspace(3) %14, i32 %gep576.idx.1, !dbg !74
  %15 = load i16, ptr addrspace(3) %gep576.1, align 2, !dbg !75, !tbaa !76
  %add166.2 = or disjoint i32 %mul164, 2, !dbg !77
  %xor167.2 = xor i32 %shr160, %add166.2, !dbg !78
  %add169.2 = or disjoint i32 %add155, 128, !dbg !79
  %16 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add169.2, !dbg !74
  %gep576.idx.2 = shl nuw nsw i32 %xor167.2, 3, !dbg !74
  %gep576.2 = getelementptr inbounds i8, ptr addrspace(3) %16, i32 %gep576.idx.2, !dbg !74
  %17 = load i16, ptr addrspace(3) %gep576.2, align 2, !dbg !75, !tbaa !76
  %add166.3 = or i32 %and159, 3, !dbg !77
  %add169.3 = or disjoint i32 %add155, 192, !dbg !79
  %18 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add169.3, !dbg !74
  %xor167.3 = shl nuw nsw i32 %and159, 3, !dbg !74
  %gep576.idx.3 = xor i32 %xor167.3, 24, !dbg !74
  %gep576.3 = getelementptr inbounds i8, ptr addrspace(3) %18, i32 %gep576.idx.3, !dbg !74
  %19 = load i16, ptr addrspace(3) %gep576.3, align 2, !dbg !75, !tbaa !76
  %add161.4 = or disjoint i32 %shr160, 4, !dbg !80
  %xor167.4 = xor i32 %add161.4, %mul164, !dbg !78
  %gep576.idx.4 = shl nuw nsw i32 %xor167.4, 3, !dbg !74
  %gep576.4 = getelementptr inbounds i8, ptr addrspace(3) %12, i32 %gep576.idx.4, !dbg !74
  %20 = load i16, ptr addrspace(3) %gep576.4, align 2, !dbg !75, !tbaa !76
  %xor167.5 = xor i32 %add161.4, %add166.1, !dbg !78
  %gep576.idx.5 = shl nuw nsw i32 %xor167.5, 3, !dbg !74
  %gep576.5 = getelementptr inbounds i8, ptr addrspace(3) %14, i32 %gep576.idx.5, !dbg !74
  %21 = load i16, ptr addrspace(3) %gep576.5, align 2, !dbg !75, !tbaa !76
  %xor167.6 = xor i32 %add161.4, %add166.2, !dbg !78
  %gep576.idx.6 = shl nuw nsw i32 %xor167.6, 3, !dbg !74
  %gep576.6 = getelementptr inbounds i8, ptr addrspace(3) %16, i32 %gep576.idx.6, !dbg !74
  %22 = load i16, ptr addrspace(3) %gep576.6, align 2, !dbg !75, !tbaa !76
  %xor167.7 = xor i32 %add161.4, %add166.3, !dbg !78
  %gep576.idx.7 = shl nuw nsw i32 %xor167.7, 3, !dbg !74
  %gep576.7 = getelementptr inbounds i8, ptr addrspace(3) %18, i32 %gep576.idx.7, !dbg !74
  %23 = load i16, ptr addrspace(3) %gep576.7, align 2, !dbg !75, !tbaa !76
  %add161.8 = or disjoint i32 %shr160, 8, !dbg !80
  %xor167.8 = xor i32 %add161.8, %mul164, !dbg !78
  %gep576.idx.8 = shl nuw nsw i32 %xor167.8, 3, !dbg !74
  %gep576.8 = getelementptr inbounds i8, ptr addrspace(3) %12, i32 %gep576.idx.8, !dbg !74
  %24 = load i16, ptr addrspace(3) %gep576.8, align 2, !dbg !75, !tbaa !76
  %xor167.9 = xor i32 %add161.8, %add166.1, !dbg !78
  %gep576.idx.9 = shl nuw nsw i32 %xor167.9, 3, !dbg !74
  %gep576.9 = getelementptr inbounds i8, ptr addrspace(3) %14, i32 %gep576.idx.9, !dbg !74
  %25 = load i16, ptr addrspace(3) %gep576.9, align 2, !dbg !75, !tbaa !76
  %xor167.10 = xor i32 %add161.8, %add166.2, !dbg !78
  %gep576.idx.10 = shl nuw nsw i32 %xor167.10, 3, !dbg !74
  %gep576.10 = getelementptr inbounds i8, ptr addrspace(3) %16, i32 %gep576.idx.10, !dbg !74
  %26 = load i16, ptr addrspace(3) %gep576.10, align 2, !dbg !75, !tbaa !76
  %xor167.11 = xor i32 %add161.8, %add166.3, !dbg !78
  %gep576.idx.11 = shl nuw nsw i32 %xor167.11, 3, !dbg !74
  %gep576.11 = getelementptr inbounds i8, ptr addrspace(3) %18, i32 %gep576.idx.11, !dbg !74
  %27 = load i16, ptr addrspace(3) %gep576.11, align 2, !dbg !75, !tbaa !76
  %add161.12 = or disjoint i32 %shr160, 12, !dbg !80
  %xor167.12 = xor i32 %add161.12, %mul164, !dbg !78
  %gep576.idx.12 = shl nuw nsw i32 %xor167.12, 3, !dbg !74
  %gep576.12 = getelementptr inbounds i8, ptr addrspace(3) %12, i32 %gep576.idx.12, !dbg !74
  %28 = load i16, ptr addrspace(3) %gep576.12, align 2, !dbg !75, !tbaa !76
  %xor167.13 = xor i32 %add161.12, %add166.1, !dbg !78
  %gep576.idx.13 = shl nuw nsw i32 %xor167.13, 3, !dbg !74
  %gep576.13 = getelementptr inbounds i8, ptr addrspace(3) %14, i32 %gep576.idx.13, !dbg !74
  %29 = load i16, ptr addrspace(3) %gep576.13, align 2, !dbg !75, !tbaa !76
  %xor167.14 = xor i32 %add161.12, %add166.2, !dbg !78
  %gep576.idx.14 = shl nuw nsw i32 %xor167.14, 3, !dbg !74
  %gep576.14 = getelementptr inbounds i8, ptr addrspace(3) %16, i32 %gep576.idx.14, !dbg !74
  %30 = load i16, ptr addrspace(3) %gep576.14, align 2, !dbg !75, !tbaa !76
  %xor167.15 = xor i32 %add161.12, %add166.3, !dbg !78
  %gep576.idx.15 = shl nuw nsw i32 %xor167.15, 3, !dbg !74
  %gep576.15 = getelementptr inbounds i8, ptr addrspace(3) %18, i32 %gep576.idx.15, !dbg !74
  %31 = load i16, ptr addrspace(3) %gep576.15, align 2, !dbg !75, !tbaa !76
  %mul189 = shl nsw i32 %1, 18
  %32 = shl nuw nsw i32 %0, 11
  %33 = and i32 %32, 256000
  %34 = shl nuw nsw i32 %0, 8
  %mul203 = and i32 %34, 512
  %add204 = or disjoint i32 %and20, %mul189
  %add197 = add nuw nsw i32 %add204, %33
  %add199 = add nuw nsw i32 %add197, %mul203
  %35 = zext nneg i32 %add199 to i64, !dbg !81
  %add.ptr209 = getelementptr inbounds %struct.__half, ptr addrspace(1) %PackedKV.coerce, i64 %35, !dbg !82
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr209, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr137, i64 16, i1 false), !dbg !83, !call_argsrelate !84
  %36 = getelementptr inbounds %struct.__half, ptr addrspace(1) %PackedKV.coerce, i64 %35, !dbg !82
  %add.ptr209.1 = getelementptr inbounds i8, ptr addrspace(1) %36, i64 2048, !dbg !82
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr209.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr137.1, i64 16, i1 false), !dbg !83, !call_argsrelate !84
  %mul226 = and i32 %32, 253952
  %mul230 = and i32 %2, 3072
  %add231 = or disjoint i32 %add204, %mul226
  %add233 = add nuw nsw i32 %add231, %mul230
  %invariant.gep579 = getelementptr inbounds i8, ptr addrspace(1) %PackedKV.coerce, i64 8192, !dbg !85
  %37 = zext nneg i32 %add233 to i64, !dbg !85
  %gep580 = getelementptr inbounds %struct.__half, ptr addrspace(1) %invariant.gep579, i64 %37, !dbg !86
  store i16 %13, ptr addrspace(1) %gep580, align 16, !dbg !87
  %packed_v.sroa.4.0.gep580.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %gep580, i64 2, !dbg !87
  store i16 %15, ptr addrspace(1) %packed_v.sroa.4.0.gep580.sroa_idx, align 2, !dbg !87, !tbaa !30
  %packed_v.sroa.5.0.gep580.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %gep580, i64 4, !dbg !87
  store i16 %17, ptr addrspace(1) %packed_v.sroa.5.0.gep580.sroa_idx, align 4, !dbg !87
  %packed_v.sroa.6.0.gep580.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %gep580, i64 6, !dbg !87
  store i16 %19, ptr addrspace(1) %packed_v.sroa.6.0.gep580.sroa_idx, align 2, !dbg !87, !tbaa !30
  %packed_v.sroa.7.0.gep580.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %gep580, i64 8, !dbg !87
  store i16 %20, ptr addrspace(1) %packed_v.sroa.7.0.gep580.sroa_idx, align 8, !dbg !87
  %packed_v.sroa.8.0.gep580.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %gep580, i64 10, !dbg !87
  store i16 %21, ptr addrspace(1) %packed_v.sroa.8.0.gep580.sroa_idx, align 2, !dbg !87, !tbaa !30
  %packed_v.sroa.9.0.gep580.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %gep580, i64 12, !dbg !87
  store i16 %22, ptr addrspace(1) %packed_v.sroa.9.0.gep580.sroa_idx, align 4, !dbg !87
  %packed_v.sroa.10.0.gep580.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %gep580, i64 14, !dbg !87
  store i16 %23, ptr addrspace(1) %packed_v.sroa.10.0.gep580.sroa_idx, align 2, !dbg !87, !tbaa !30
  %38 = getelementptr inbounds %struct.__half, ptr addrspace(1) %invariant.gep579, i64 %37, !dbg !86
  %gep580.1 = getelementptr inbounds i8, ptr addrspace(1) %38, i64 1024, !dbg !86
  store i16 %24, ptr addrspace(1) %gep580.1, align 16, !dbg !87
  %packed_v.sroa.13.16.gep580.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %38, i64 1026, !dbg !87
  store i16 %25, ptr addrspace(1) %packed_v.sroa.13.16.gep580.1.sroa_idx, align 2, !dbg !87, !tbaa !30
  %packed_v.sroa.14.16.gep580.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %38, i64 1028, !dbg !87
  store i16 %26, ptr addrspace(1) %packed_v.sroa.14.16.gep580.1.sroa_idx, align 4, !dbg !87
  %packed_v.sroa.15.16.gep580.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %38, i64 1030, !dbg !87
  store i16 %27, ptr addrspace(1) %packed_v.sroa.15.16.gep580.1.sroa_idx, align 2, !dbg !87, !tbaa !30
  %packed_v.sroa.16.16.gep580.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %38, i64 1032, !dbg !87
  store i16 %28, ptr addrspace(1) %packed_v.sroa.16.16.gep580.1.sroa_idx, align 8, !dbg !87
  %packed_v.sroa.17.16.gep580.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %38, i64 1034, !dbg !87
  store i16 %29, ptr addrspace(1) %packed_v.sroa.17.16.gep580.1.sroa_idx, align 2, !dbg !87, !tbaa !30
  %packed_v.sroa.18.16.gep580.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %38, i64 1036, !dbg !87
  store i16 %30, ptr addrspace(1) %packed_v.sroa.18.16.gep580.1.sroa_idx, align 4, !dbg !87
  %packed_v.sroa.19.16.gep580.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %38, i64 1038, !dbg !87
  store i16 %31, ptr addrspace(1) %packed_v.sroa.19.16.gep580.1.sroa_idx, align 2, !dbg !87, !tbaa !30
  br label %if.end478, !dbg !88

if.else:                                          ; preds = %entry
  %39 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !dbg !89, !range !48
  %40 = getelementptr inbounds i32, ptr addrspace(3) @buf_dyn_shmem, i32 %39, !dbg !92
  %arrayidx246 = getelementptr inbounds i8, ptr addrspace(3) %40, i32 4608, !dbg !92
  store i32 0, ptr addrspace(3) %arrayidx246, align 4, !dbg !93, !tbaa !30
  fence syncscope("warp") release, !dbg !94
  tail call void @llvm.mxc.barrier.warp(), !dbg !97
  fence syncscope("warp") acquire, !dbg !98
  %41 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul257 = shl nsw i32 %41, 10
  %mul259 = shl nsw i32 %0, 7
  %add260 = add nuw nsw i32 %mul259, %39
  %add262 = add nuw nsw i32 %add260, %mul257
  %invariant.gep = getelementptr i8, ptr addrspace(1) %Indices.coerce, i64 -65536, !dbg !99
  %mul272 = shl nsw i32 %0, 2
  %shr276 = lshr i32 %39, 5
  %add274 = add nuw nsw i32 %shr276, %mul272
  %42 = zext nneg i32 %add262 to i64, !dbg !100
  %gep = getelementptr i32, ptr addrspace(1) %invariant.gep, i64 %42, !dbg !101
  %43 = load i32, ptr addrspace(1) %gep, align 4, !dbg !101, !tbaa !30
  %or.cond582 = icmp ugt i32 %43, 31, !dbg !102
  %add270 = or disjoint i32 %43, 512
  %cmp278.not = icmp sgt i32 %add270, %add274
  %or.cond611 = select i1 %or.cond582, i1 true, i1 %cmp278.not, !dbg !102
  %condval.0 = select i1 %or.cond611, i32 32, i32 %43, !dbg !102
  %gep554 = getelementptr i32, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4608), i32 %condval.0, !dbg !103
  %44 = atomicrmw add ptr addrspace(3) %gep554, i32 1 syncscope("device-one-as") monotonic, align 4, !dbg !104, !argrelate !111
  %45 = getelementptr i32, ptr addrspace(1) %invariant.gep, i64 %42, !dbg !101
  %gep.1 = getelementptr i8, ptr addrspace(1) %45, i64 256, !dbg !101
  %46 = load i32, ptr addrspace(1) %gep.1, align 4, !dbg !101, !tbaa !30
  %or.cond582.1 = icmp ult i32 %46, 32, !dbg !102
  br i1 %or.cond582.1, label %land.lhs.true269.1, label %if.else280.1, !dbg !102

land.lhs.true269.1:                               ; preds = %if.else
  %add270.1 = or disjoint i32 %46, 512, !dbg !112
  %narrow = add nuw i32 %add274, 2, !dbg !113
  %cmp278.not.1 = icmp sgt i32 %add270.1, %narrow, !dbg !114
  br i1 %cmp278.not.1, label %if.else280.1, label %if.end.1, !dbg !115

if.else280.1:                                     ; preds = %land.lhs.true269.1, %if.else
  br label %if.end.1

if.end.1:                                         ; preds = %if.else280.1, %land.lhs.true269.1
  %condval.0.1 = phi i32 [ 32, %if.else280.1 ], [ %46, %land.lhs.true269.1 ], !dbg !116
  %gep554.1 = getelementptr i32, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4608), i32 %condval.0.1, !dbg !103
  %47 = atomicrmw add ptr addrspace(3) %gep554.1, i32 1 syncscope("device-one-as") monotonic, align 4, !dbg !104, !argrelate !111
  fence syncscope("warp") release, !dbg !117
  tail call void @llvm.mxc.barrier.warp(), !dbg !120
  fence syncscope("warp") acquire, !dbg !121
  %48 = load i32, ptr addrspace(3) %arrayidx246, align 4, !dbg !122, !tbaa !30
  %mul297 = shl nsw i32 %48, 16, !dbg !123
  %add302 = add nsw i32 %48, 1, !dbg !124
  %shr303 = ashr i32 %add302, 1, !dbg !125
  %add304 = add i32 %shr303, %mul297, !dbg !126
  %49 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !127
  %50 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %49) #9, !dbg !132
  %sub.i = add i32 %50, -1, !dbg !133
  %and.i = and i32 %50, -64, !dbg !134
  %cmp.i = icmp slt i32 %sub.i, %and.i, !dbg !135
  %cond.i = select i1 %cmp.i, i32 %50, i32 %sub.i, !dbg !136
  %shl.i = shl i32 %cond.i, 2, !dbg !137
  %51 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i, i32 %add304), !dbg !138
  %cmp315.not = icmp eq i32 %39, 0, !dbg !139
  %add318 = select i1 %cmp315.not, i32 0, i32 %51, !dbg !140
  %spec.select = add nsw i32 %add318, %add304, !dbg !140
  %52 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !127
  %53 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %52) #9, !dbg !132
  %sub.i.1 = add i32 %53, -2, !dbg !133
  %and.i.1 = and i32 %53, -64, !dbg !134
  %cmp.i.1 = icmp slt i32 %sub.i.1, %and.i.1, !dbg !135
  %cond.i.1 = select i1 %cmp.i.1, i32 %53, i32 %sub.i.1, !dbg !136
  %shl.i.1 = shl i32 %cond.i.1, 2, !dbg !137
  %54 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.1, i32 %spec.select), !dbg !138
  %cmp315.not.1 = icmp ult i32 %39, 2, !dbg !139
  %add318.1 = select i1 %cmp315.not.1, i32 0, i32 %54, !dbg !140
  %spec.select.1 = add nsw i32 %add318.1, %spec.select, !dbg !140
  %55 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !127
  %56 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %55) #9, !dbg !132
  %sub.i.2 = add i32 %56, -4, !dbg !133
  %and.i.2 = and i32 %56, -64, !dbg !134
  %cmp.i.2 = icmp slt i32 %sub.i.2, %and.i.2, !dbg !135
  %cond.i.2 = select i1 %cmp.i.2, i32 %56, i32 %sub.i.2, !dbg !136
  %shl.i.2 = shl i32 %cond.i.2, 2, !dbg !137
  %57 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.2, i32 %spec.select.1), !dbg !138
  %cmp315.not.2 = icmp ult i32 %39, 4, !dbg !139
  %add318.2 = select i1 %cmp315.not.2, i32 0, i32 %57, !dbg !140
  %spec.select.2 = add nsw i32 %add318.2, %spec.select.1, !dbg !140
  %58 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !127
  %59 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %58) #9, !dbg !132
  %sub.i.3 = add i32 %59, -8, !dbg !133
  %and.i.3 = and i32 %59, -64, !dbg !134
  %cmp.i.3 = icmp slt i32 %sub.i.3, %and.i.3, !dbg !135
  %cond.i.3 = select i1 %cmp.i.3, i32 %59, i32 %sub.i.3, !dbg !136
  %shl.i.3 = shl i32 %cond.i.3, 2, !dbg !137
  %60 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.3, i32 %spec.select.2), !dbg !138
  %cmp315.not.3 = icmp ult i32 %39, 8, !dbg !139
  %add318.3 = select i1 %cmp315.not.3, i32 0, i32 %60, !dbg !140
  %spec.select.3 = add nsw i32 %add318.3, %spec.select.2, !dbg !140
  %61 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !127
  %62 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %61) #9, !dbg !132
  %sub.i.4 = add i32 %62, -16, !dbg !133
  %and.i.4 = and i32 %62, -64, !dbg !134
  %cmp.i.4 = icmp slt i32 %sub.i.4, %and.i.4, !dbg !135
  %cond.i.4 = select i1 %cmp.i.4, i32 %62, i32 %sub.i.4, !dbg !136
  %shl.i.4 = shl i32 %cond.i.4, 2, !dbg !137
  %63 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.4, i32 %spec.select.3), !dbg !138
  %cmp315.not.4 = icmp ult i32 %39, 16, !dbg !139
  %add318.4 = select i1 %cmp315.not.4, i32 0, i32 %63, !dbg !140
  %spec.select.4 = add nsw i32 %add318.4, %spec.select.3, !dbg !140
  %64 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #9, !dbg !127
  %65 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %64) #9, !dbg !132
  %sub.i.5 = add i32 %65, -32, !dbg !133
  %and.i.5 = and i32 %65, -64, !dbg !134
  %cmp.i.5 = icmp slt i32 %sub.i.5, %and.i.5, !dbg !135
  %cond.i.5 = select i1 %cmp.i.5, i32 %65, i32 %sub.i.5, !dbg !136
  %shl.i.5 = shl i32 %cond.i.5, 2, !dbg !137
  %66 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.5, i32 %spec.select.4), !dbg !138
  %cmp315.not.5 = icmp ult i32 %39, 32, !dbg !139
  %add318.5 = select i1 %cmp315.not.5, i32 0, i32 %66, !dbg !140
  %spec.select.5 = add nsw i32 %add318.5, %spec.select.4, !dbg !140
  %sub337 = sub i32 %spec.select.5, %add304, !dbg !141
  %arrayidx341 = getelementptr inbounds i8, ptr addrspace(3) %40, i32 4864, !dbg !142
  store i32 %sub337, ptr addrspace(3) %arrayidx341, align 4, !dbg !143, !tbaa !30
  %cmp343 = icmp eq i32 %39, 63, !dbg !144
  %mul348 = mul nuw nsw i32 %41, 1928
  %mul350 = mul nuw nsw i32 %0, 241
  %add351 = add nuw nsw i32 %mul348, %mul350
  br i1 %cmp343, label %if.then344, label %if.end355, !dbg !145

if.then344:                                       ; preds = %if.end.1
  %67 = zext nneg i32 %add351 to i64
  %68 = getelementptr i32, ptr addrspace(1) %Schedule.coerce, i64 %67
  %arrayidx354 = getelementptr i8, ptr addrspace(1) %68, i64 -123392
  %and346 = and i32 %spec.select.5, 65535
  store i32 %and346, ptr addrspace(1) %arrayidx354, align 4, !dbg !146, !tbaa !30
  br label %if.end355, !dbg !147

if.end355:                                        ; preds = %if.end.1, %if.then344
  fence syncscope("warp") release, !dbg !148
  tail call void @llvm.mxc.barrier.warp(), !dbg !151
  fence syncscope("warp") acquire, !dbg !152
  %add364 = or disjoint i32 %39, -16384
  %add366 = add nsw i32 %add364, %mul259
  %gep559 = getelementptr i32, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4864), i32 %condval.0, !dbg !153
  %69 = load i32, ptr addrspace(3) %gep559, align 4, !dbg !153, !tbaa !30
  %70 = ashr i32 %69, 16, !dbg !154
  %71 = getelementptr i32, ptr addrspace(3) @buf_dyn_shmem, i32 %70, !dbg !155
  %72 = getelementptr i32, ptr addrspace(3) %71, i32 %44, !dbg !155
  %arrayidx380 = getelementptr i8, ptr addrspace(3) %72, i32 4096, !dbg !155
  store i32 %add366, ptr addrspace(3) %arrayidx380, align 4, !dbg !156, !tbaa !30
  %sub367.1 = add nsw i32 %add366, 64, !dbg !157
  %gep559.1 = getelementptr i32, ptr addrspace(3) getelementptr (i8, ptr addrspace(3) @buf_dyn_shmem, i32 4864), i32 %condval.0.1, !dbg !153
  %73 = load i32, ptr addrspace(3) %gep559.1, align 4, !dbg !153, !tbaa !30
  %74 = ashr i32 %73, 16, !dbg !154
  %75 = getelementptr i32, ptr addrspace(3) @buf_dyn_shmem, i32 %74, !dbg !155
  %76 = getelementptr i32, ptr addrspace(3) %75, i32 %47, !dbg !155
  %arrayidx380.1 = getelementptr i8, ptr addrspace(3) %76, i32 4096, !dbg !155
  store i32 %sub367.1, ptr addrspace(3) %arrayidx380.1, align 4, !dbg !156, !tbaa !30
  fence syncscope("warp") release, !dbg !158
  tail call void @llvm.mxc.barrier.warp(), !dbg !161
  fence syncscope("warp") acquire, !dbg !162
  %invariant.gep561 = getelementptr i8, ptr addrspace(1) %Schedule.coerce, i64 -123380, !dbg !163
  %77 = and i32 %44, 1, !dbg !164
  %cmp391 = icmp eq i32 %77, 0, !dbg !164
  br i1 %cmp391, label %if.then392, label %for.inc475, !dbg !165

if.then392:                                       ; preds = %if.end355
  %78 = getelementptr i32, ptr addrspace(3) @buf_dyn_shmem, i32 %condval.0, !dbg !166
  %arrayidx397 = getelementptr i8, ptr addrspace(3) %78, i32 4864, !dbg !166
  %79 = load i32, ptr addrspace(3) %arrayidx397, align 4, !dbg !166, !tbaa !30
  %shr400 = ashr exact i32 %44, 1, !dbg !167
  %and401 = and i32 %79, 65535, !dbg !168
  %add402 = add nsw i32 %and401, %shr400, !dbg !169
  %or.cond = icmp ult i32 %add402, 80, !dbg !170
  br i1 %or.cond, label %if.then406, label %if.end437, !dbg !170

if.then406:                                       ; preds = %if.then392
  %mul414 = mul nuw nsw i32 %add402, 3, !dbg !171
  %add415 = add nuw nsw i32 %add351, %mul414, !dbg !172
  %80 = zext nneg i32 %add415 to i64, !dbg !173
  %81 = getelementptr i32, ptr addrspace(1) %Schedule.coerce, i64 %80, !dbg !173
  %arrayidx418 = getelementptr i8, ptr addrspace(1) %81, i64 -123388, !dbg !173
  store i32 %condval.0, ptr addrspace(1) %arrayidx418, align 4, !dbg !174, !tbaa !30
  %arrayidx435 = getelementptr i8, ptr addrspace(1) %81, i64 -123384, !dbg !175
  store i32 %add366, ptr addrspace(1) %arrayidx435, align 4, !dbg !176, !tbaa !30
  br label %if.end437, !dbg !177

if.end437:                                        ; preds = %if.then406, %if.then392
  %82 = add nsw i32 %add402, 1, !dbg !178
  %or.cond550 = icmp ult i32 %82, 81, !dbg !178
  br i1 %or.cond550, label %if.then441, label %for.inc475, !dbg !178

if.then441:                                       ; preds = %if.end437
  %add444 = or disjoint i32 %44, 1, !dbg !179
  %arrayidx449 = getelementptr i8, ptr addrspace(3) %78, i32 4608, !dbg !180
  %83 = load i32, ptr addrspace(3) %arrayidx449, align 4, !dbg !180, !tbaa !30
  %cmp450 = icmp slt i32 %add444, %83, !dbg !181
  br i1 %cmp450, label %if.then451, label %if.end461, !dbg !182

if.then451:                                       ; preds = %if.then441
  %84 = ashr i32 %79, 16
  %85 = getelementptr i32, ptr addrspace(3) @buf_dyn_shmem, i32 %84
  %86 = getelementptr i32, ptr addrspace(3) %85, i32 %44
  %arrayidx459 = getelementptr i8, ptr addrspace(3) %86, i32 4100
  %87 = load i32, ptr addrspace(3) %arrayidx459, align 4, !dbg !183, !tbaa !30
  br label %if.end461, !dbg !184

if.end461:                                        ; preds = %if.then441, %if.then451
  %condval_1.0 = phi i32 [ %87, %if.then451 ], [ -1, %if.then441 ], !dbg !116
  %mul467 = mul nsw i32 %add402, 3, !dbg !185
  %add468 = add nsw i32 %add351, %mul467, !dbg !186
  %88 = sext i32 %add468 to i64, !dbg !187
  %gep562 = getelementptr i32, ptr addrspace(1) %invariant.gep561, i64 %88, !dbg !187
  store i32 %condval_1.0, ptr addrspace(1) %gep562, align 4, !dbg !188, !tbaa !30
  br label %for.inc475, !dbg !189

for.inc475:                                       ; preds = %if.end437, %if.end461, %if.end355
  %89 = and i32 %47, 1, !dbg !164
  %cmp391.1 = icmp eq i32 %89, 0, !dbg !164
  br i1 %cmp391.1, label %if.then392.1, label %if.end478, !dbg !165

if.then392.1:                                     ; preds = %for.inc475
  %90 = getelementptr i32, ptr addrspace(3) @buf_dyn_shmem, i32 %condval.0.1, !dbg !166
  %arrayidx397.1 = getelementptr i8, ptr addrspace(3) %90, i32 4864, !dbg !166
  %91 = load i32, ptr addrspace(3) %arrayidx397.1, align 4, !dbg !166, !tbaa !30
  %shr400.1 = ashr exact i32 %47, 1, !dbg !167
  %and401.1 = and i32 %91, 65535, !dbg !168
  %add402.1 = add nsw i32 %and401.1, %shr400.1, !dbg !169
  %or.cond.1 = icmp ult i32 %add402.1, 80, !dbg !170
  br i1 %or.cond.1, label %if.then406.1, label %if.end437.1, !dbg !170

if.then406.1:                                     ; preds = %if.then392.1
  %mul414.1 = mul nuw nsw i32 %add402.1, 3, !dbg !171
  %add415.1 = add nuw nsw i32 %add351, %mul414.1, !dbg !172
  %92 = zext nneg i32 %add415.1 to i64, !dbg !173
  %93 = getelementptr i32, ptr addrspace(1) %Schedule.coerce, i64 %92, !dbg !173
  %arrayidx418.1 = getelementptr i8, ptr addrspace(1) %93, i64 -123388, !dbg !173
  store i32 %condval.0.1, ptr addrspace(1) %arrayidx418.1, align 4, !dbg !174, !tbaa !30
  %arrayidx435.1 = getelementptr i8, ptr addrspace(1) %93, i64 -123384, !dbg !175
  store i32 %sub367.1, ptr addrspace(1) %arrayidx435.1, align 4, !dbg !176, !tbaa !30
  br label %if.end437.1, !dbg !177

if.end437.1:                                      ; preds = %if.then406.1, %if.then392.1
  %94 = add nsw i32 %add402.1, 1, !dbg !178
  %or.cond550.1 = icmp ult i32 %94, 81, !dbg !178
  br i1 %or.cond550.1, label %if.then441.1, label %if.end478, !dbg !178

if.then441.1:                                     ; preds = %if.end437.1
  %add444.1 = or disjoint i32 %47, 1, !dbg !179
  %arrayidx449.1 = getelementptr i8, ptr addrspace(3) %90, i32 4608, !dbg !180
  %95 = load i32, ptr addrspace(3) %arrayidx449.1, align 4, !dbg !180, !tbaa !30
  %cmp450.1 = icmp slt i32 %add444.1, %95, !dbg !181
  br i1 %cmp450.1, label %if.then451.1, label %if.end461.1, !dbg !182

if.then451.1:                                     ; preds = %if.then441.1
  %96 = ashr i32 %91, 16
  %97 = getelementptr i32, ptr addrspace(3) @buf_dyn_shmem, i32 %96
  %98 = getelementptr i32, ptr addrspace(3) %97, i32 %47
  %arrayidx459.1 = getelementptr i8, ptr addrspace(3) %98, i32 4100
  %99 = load i32, ptr addrspace(3) %arrayidx459.1, align 4, !dbg !183, !tbaa !30
  br label %if.end461.1, !dbg !184

if.end461.1:                                      ; preds = %if.then451.1, %if.then441.1
  %condval_1.0.1 = phi i32 [ %99, %if.then451.1 ], [ -1, %if.then441.1 ], !dbg !116
  %mul467.1 = mul nsw i32 %add402.1, 3, !dbg !185
  %add468.1 = add nsw i32 %add351, %mul467.1, !dbg !186
  %100 = sext i32 %add468.1 to i64, !dbg !187
  %gep562.1 = getelementptr i32, ptr addrspace(1) %invariant.gep561, i64 %100, !dbg !187
  store i32 %condval_1.0.1, ptr addrspace(1) %gep562.1, align 4, !dbg !188, !tbaa !30
  br label %if.end478, !dbg !189

if.end478:                                        ; preds = %for.inc475, %if.end437.1, %if.end461.1, %for.cond.preheader
  ret void, !dbg !88
}

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.x() #4

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.y() #4

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.z() #4

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.thread.id.x() #4

; Function Attrs: convergent nounwind willreturn
declare void @llvm.mxc.barrier.warp() #5

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #6

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #6

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #6

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i1 @llvm.mxc.is.private(ptr nocapture) #4

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #4

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #4

; Function Attrs: nounwind willreturn
declare void @llvm.mxc.sleep(i32 immarg) #7

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noalias nocapture writeonly, ptr addrspace(4) noalias nocapture readonly, i64, i1 immarg) #8

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #8

attributes #0 = { mustprogress noreturn nounwind "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { nounwind speculatable willreturn memory(none) }
attributes #5 = { convergent nounwind willreturn }
attributes #6 = { convergent nounwind willreturn memory(none) }
attributes #7 = { nounwind willreturn }
attributes #8 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #9 = { nomerge }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmpyp6j048g/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpyp6j048g/tvm_kernels.maca", directory: "")
!42 = !DILocation(line: 77, column: 3, scope: !43, inlinedAt: !45)
!43 = distinct !DISubprogram(name: "__fetch_builtin_x", scope: !44, file: !44, line: 77, type: !7, scopeLine: 77, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!44 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_builtin_vars.h", directory: "")
!45 = distinct !DILocation(line: 19, column: 13, scope: !40)
!46 = !DILocation(line: 19, column: 25, scope: !40)
!47 = !DILocation(line: 19, column: 7, scope: !40)
!48 = !{i32 0, i32 1024}
!49 = !DILocation(line: 21, column: 5, scope: !40)
!50 = !DILocation(line: 22, column: 48, scope: !40)
!51 = !DILocation(line: 22, column: 206, scope: !40)
!52 = !DILocation(line: 26, column: 49, scope: !40)
!53 = !DILocation(line: 26, column: 35, scope: !40)
!54 = !DILocation(line: 29, column: 5, scope: !40)
!55 = !DILocation(line: 30, column: 159, scope: !40)
!56 = !{i32 3, i32 1, i32 -1, i32 -1}
!57 = !DILocation(line: 30, column: 42, scope: !40)
!58 = !DILocation(line: 34, column: 151, scope: !40)
!59 = !DILocation(line: 34, column: 42, scope: !40)
!60 = !DILocation(line: 34, column: 216, scope: !40)
!61 = !DILocation(line: 34, column: 138, scope: !40)
!62 = !DILocation(line: 34, column: 171, scope: !40)
!63 = !DILocation(line: 68, column: 3, scope: !64, inlinedAt: !66)
!64 = distinct !DISubprogram(name: "__barrier_warp", scope: !65, file: !65, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!65 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!66 = distinct !DILocation(line: 192, column: 3, scope: !67, inlinedAt: !68)
!67 = distinct !DISubprogram(name: "__syncwarp", scope: !65, file: !65, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!68 = distinct !DILocation(line: 36, column: 5, scope: !40)
!69 = !DILocation(line: 69, column: 3, scope: !64, inlinedAt: !66)
!70 = !DILocation(line: 70, column: 3, scope: !64, inlinedAt: !66)
!71 = !DILocation(line: 39, column: 156, scope: !40)
!72 = !DILocation(line: 39, column: 76, scope: !40)
!73 = !DILocation(line: 39, column: 127, scope: !40)
!74 = !DILocation(line: 43, column: 23, scope: !40)
!75 = !DILocation(line: 43, column: 21, scope: !40)
!76 = !{!26, !26, i64 0}
!77 = !DILocation(line: 43, column: 199, scope: !40)
!78 = !DILocation(line: 43, column: 164, scope: !40)
!79 = !DILocation(line: 43, column: 106, scope: !40)
!80 = !DILocation(line: 43, column: 128, scope: !40)
!81 = !DILocation(line: 46, column: 5, scope: !40)
!82 = !DILocation(line: 47, column: 26, scope: !40)
!83 = !DILocation(line: 47, column: 224, scope: !40)
!84 = !{i32 2, i32 3, i32 -1, i32 -1}
!85 = !DILocation(line: 50, column: 5, scope: !40)
!86 = !DILocation(line: 51, column: 26, scope: !40)
!87 = !DILocation(line: 51, column: 191, scope: !40)
!88 = !DILocation(line: 114, column: 1, scope: !40)
!89 = !DILocation(line: 67, column: 3, scope: !90, inlinedAt: !91)
!90 = distinct !DISubprogram(name: "__fetch_builtin_x", scope: !44, file: !44, line: 67, type: !7, scopeLine: 67, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!91 = distinct !DILocation(line: 54, column: 34, scope: !40)
!92 = !DILocation(line: 54, column: 5, scope: !40)
!93 = !DILocation(line: 54, column: 56, scope: !40)
!94 = !DILocation(line: 68, column: 3, scope: !64, inlinedAt: !95)
!95 = distinct !DILocation(line: 192, column: 3, scope: !67, inlinedAt: !96)
!96 = distinct !DILocation(line: 55, column: 5, scope: !40)
!97 = !DILocation(line: 69, column: 3, scope: !64, inlinedAt: !95)
!98 = !DILocation(line: 70, column: 3, scope: !64, inlinedAt: !95)
!99 = !DILocation(line: 57, column: 10, scope: !40)
!100 = !DILocation(line: 57, column: 5, scope: !40)
!101 = !DILocation(line: 60, column: 17, scope: !40)
!102 = !DILocation(line: 62, column: 24, scope: !40)
!103 = !DILocation(line: 68, column: 37, scope: !40)
!104 = !DILocation(line: 98, column: 10, scope: !105, inlinedAt: !107)
!105 = distinct !DISubprogram(name: "atomicAdd", scope: !106, file: !106, line: 92, type: !7, scopeLine: 92, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!106 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_atomic_functions.h", directory: "")
!107 = distinct !DILocation(line: 55, column: 9, scope: !108, inlinedAt: !110)
!108 = distinct !DISubprogram(name: "AtomicAddRet<int, int>", scope: !109, file: !109, line: 50, type: !7, scopeLine: 51, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!109 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/atomic.h", directory: "")
!110 = distinct !DILocation(line: 68, column: 21, scope: !40)
!111 = !{i32 3}
!112 = !DILocation(line: 62, column: 48, scope: !40)
!113 = !DILocation(line: 62, column: 98, scope: !40)
!114 = !DILocation(line: 62, column: 55, scope: !40)
!115 = !DILocation(line: 62, column: 11, scope: !40)
!116 = !DILocation(line: 0, scope: !40)
!117 = !DILocation(line: 68, column: 3, scope: !64, inlinedAt: !118)
!118 = distinct !DILocation(line: 192, column: 3, scope: !67, inlinedAt: !119)
!119 = distinct !DILocation(line: 70, column: 5, scope: !40)
!120 = !DILocation(line: 69, column: 3, scope: !64, inlinedAt: !118)
!121 = !DILocation(line: 70, column: 3, scope: !64, inlinedAt: !118)
!122 = !DILocation(line: 71, column: 17, scope: !40)
!123 = !DILocation(line: 71, column: 68, scope: !40)
!124 = !DILocation(line: 71, column: 132, scope: !40)
!125 = !DILocation(line: 71, column: 137, scope: !40)
!126 = !DILocation(line: 71, column: 77, scope: !40)
!127 = !DILocation(line: 171, column: 37, scope: !128, inlinedAt: !129)
!128 = distinct !DISubprogram(name: "__lane_id", scope: !65, file: !65, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!129 = distinct !DILocation(line: 715, column: 14, scope: !130, inlinedAt: !131)
!130 = distinct !DISubprogram(name: "__shfl_up_sync", scope: !65, file: !65, line: 712, type: !7, scopeLine: 714, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!131 = distinct !DILocation(line: 74, column: 22, scope: !40)
!132 = !DILocation(line: 171, column: 10, scope: !128, inlinedAt: !129)
!133 = !DILocation(line: 716, column: 20, scope: !130, inlinedAt: !131)
!134 = !DILocation(line: 717, column: 26, scope: !130, inlinedAt: !131)
!135 = !DILocation(line: 717, column: 18, scope: !130, inlinedAt: !131)
!136 = !DILocation(line: 717, column: 11, scope: !130, inlinedAt: !131)
!137 = !DILocation(line: 718, column: 43, scope: !130, inlinedAt: !131)
!138 = !DILocation(line: 718, column: 10, scope: !130, inlinedAt: !131)
!139 = !DILocation(line: 75, column: 28, scope: !40)
!140 = !DILocation(line: 75, column: 11, scope: !40)
!141 = !DILocation(line: 79, column: 135, scope: !40)
!142 = !DILocation(line: 79, column: 5, scope: !40)
!143 = !DILocation(line: 79, column: 56, scope: !40)
!144 = !DILocation(line: 80, column: 28, scope: !40)
!145 = !DILocation(line: 80, column: 9, scope: !40)
!146 = !DILocation(line: 81, column: 84, scope: !40)
!147 = !DILocation(line: 82, column: 5, scope: !40)
!148 = !DILocation(line: 68, column: 3, scope: !64, inlinedAt: !149)
!149 = distinct !DILocation(line: 192, column: 3, scope: !67, inlinedAt: !150)
!150 = distinct !DILocation(line: 83, column: 5, scope: !40)
!151 = !DILocation(line: 69, column: 3, scope: !64, inlinedAt: !149)
!152 = !DILocation(line: 70, column: 3, scope: !64, inlinedAt: !149)
!153 = !DILocation(line: 86, column: 42, scope: !40)
!154 = !DILocation(line: 86, column: 102, scope: !40)
!155 = !DILocation(line: 86, column: 7, scope: !40)
!156 = !DILocation(line: 86, column: 175, scope: !40)
!157 = !DILocation(line: 86, column: 245, scope: !40)
!158 = !DILocation(line: 68, column: 3, scope: !64, inlinedAt: !159)
!159 = distinct !DILocation(line: 192, column: 3, scope: !67, inlinedAt: !160)
!160 = distinct !DILocation(line: 88, column: 5, scope: !40)
!161 = !DILocation(line: 69, column: 3, scope: !64, inlinedAt: !159)
!162 = !DILocation(line: 70, column: 3, scope: !64, inlinedAt: !159)
!163 = !DILocation(line: 90, column: 10, scope: !40)
!164 = !DILocation(line: 91, column: 31, scope: !40)
!165 = !DILocation(line: 91, column: 11, scope: !40)
!166 = !DILocation(line: 92, column: 22, scope: !40)
!167 = !DILocation(line: 93, column: 36, scope: !40)
!168 = !DILocation(line: 93, column: 52, scope: !40)
!169 = !DILocation(line: 93, column: 42, scope: !40)
!170 = !DILocation(line: 94, column: 13, scope: !40)
!171 = !DILocation(line: 96, column: 89, scope: !40)
!172 = !DILocation(line: 96, column: 81, scope: !40)
!173 = !DILocation(line: 96, column: 13, scope: !40)
!174 = !DILocation(line: 96, column: 105, scope: !40)
!175 = !DILocation(line: 97, column: 13, scope: !40)
!176 = !DILocation(line: 97, column: 105, scope: !40)
!177 = !DILocation(line: 98, column: 11, scope: !40)
!178 = !DILocation(line: 100, column: 13, scope: !40)
!179 = !DILocation(line: 103, column: 33, scope: !40)
!180 = !DILocation(line: 103, column: 40, scope: !40)
!181 = !DILocation(line: 103, column: 38, scope: !40)
!182 = !DILocation(line: 103, column: 17, scope: !40)
!183 = !DILocation(line: 104, column: 27, scope: !40)
!184 = !DILocation(line: 105, column: 13, scope: !40)
!185 = !DILocation(line: 108, column: 89, scope: !40)
!186 = !DILocation(line: 108, column: 81, scope: !40)
!187 = !DILocation(line: 108, column: 13, scope: !40)
!188 = !DILocation(line: 108, column: 105, scope: !40)
!189 = !DILocation(line: 109, column: 11, scope: !40)
