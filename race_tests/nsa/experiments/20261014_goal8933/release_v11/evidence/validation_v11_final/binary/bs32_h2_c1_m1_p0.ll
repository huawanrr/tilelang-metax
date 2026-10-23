; ModuleID = '/data/tilelang-metax/race_tests/nsa/experiments/20261014_goal8933/validation_v11_final/binary/bs32_h2_c1_m1_p0.bc'
source_filename = "/tmp/tmpkmb2u0jj/tvm_kernels.maca"
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
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(4) noalias nocapture noundef readonly %K.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Packed.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %PackedK.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V.coerce) local_unnamed_addr #3 !dbg !40 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %1 = and i32 %0, 1048574
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %3 = shl nuw nsw i32 %2, 5
  %mul8 = and i32 %3, 32512
  %4 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !range !29
  %mul11 = shl nsw i32 %4, 7
  %add9 = add nuw nsw i32 %mul8, %mul11
  %and = shl i32 %0, 6
  %mul14 = and i32 %and, 64
  %and17 = shl nuw nsw i32 %2, 3
  %mul18 = and i32 %and17, 56
  %add12 = or disjoint i32 %add9, %mul14
  %add15 = or disjoint i32 %add12, %mul18
  %5 = zext nneg i32 %1 to i64, !dbg !43
  %6 = zext nneg i32 %add15 to i64, !dbg !43
  %7 = shl nuw nsw i64 %5, 11, !dbg !44
  %8 = add nuw nsw i64 %7, %6, !dbg !45
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %8, !dbg !46
  %9 = shl nuw nsw i64 %5, 11, !dbg !44
  %10 = or disjoint i64 %9, 2048, !dbg !44
  %11 = add nuw nsw i64 %10, %6, !dbg !45
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %11, !dbg !46
  %add.ptr49 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %8, !dbg !47
  %tile.sroa.0.0.copyload = load i64, ptr addrspace(4) %add.ptr49, align 16, !dbg !48
  %tile.sroa.4.0.add.ptr49.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49, i64 8, !dbg !48
  %tile.sroa.4.0.copyload = load i64, ptr addrspace(4) %tile.sroa.4.0.add.ptr49.sroa_idx, align 8, !dbg !48
  %add.ptr49.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %11, !dbg !47
  %tile.sroa.5.16.copyload = load i64, ptr addrspace(4) %add.ptr49.1, align 16, !dbg !48
  %tile.sroa.7.16.add.ptr49.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr49.1, i64 8, !dbg !48
  %tile.sroa.7.16.copyload = load i64, ptr addrspace(4) %tile.sroa.7.16.add.ptr49.1.sroa_idx, align 8, !dbg !48
  %mul69 = and i32 %and17, 8128
  %call73.masked = and i32 %2, 1016
  %mul75 = xor i32 %mul18, %call73.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul69, !dbg !49
  %invariant.gep273 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul75, !dbg !49
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep273, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !dbg !50, !call_argsrelate !51
  %gep274.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep273, i32 1024, !dbg !52
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep274.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !dbg !50, !call_argsrelate !51
  %and98 = shl nuw nsw i32 %2, 1
  %mul99 = and i32 %and98, 14
  %shr105 = lshr i32 %2, 3
  %xor107 = xor i32 %shr105, %mul99, !dbg !53
  %.idx269 = shl nuw nsw i32 %xor107, 3, !dbg !54
  %12 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 %.idx269, !dbg !54
  %add.ptr112 = getelementptr inbounds i8, ptr addrspace(3) %12, i32 2048, !dbg !54
  store i64 %tile.sroa.0.0.copyload, ptr addrspace(3) %add.ptr112, align 8, !dbg !55
  %add101.1 = or disjoint i32 %mul99, 1, !dbg !56
  %xor107.1 = xor i32 %shr105, %add101.1, !dbg !53
  %.idx269.1 = shl nuw nsw i32 %xor107.1, 3, !dbg !54
  %13 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 %.idx269.1, !dbg !54
  %add.ptr112.1 = getelementptr inbounds i8, ptr addrspace(3) %13, i32 2048, !dbg !54
  store i64 %tile.sroa.4.0.copyload, ptr addrspace(3) %add.ptr112.1, align 8, !dbg !55
  %add106.2 = add nuw nsw i32 %shr105, 8, !dbg !57
  %xor107.2 = xor i32 %add106.2, %mul99, !dbg !53
  %gep.2 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep, i32 1024, !dbg !54
  %.idx269.2 = shl nuw nsw i32 %xor107.2, 3, !dbg !54
  %14 = getelementptr inbounds i8, ptr addrspace(3) %gep.2, i32 %.idx269.2, !dbg !54
  %add.ptr112.2 = getelementptr inbounds i8, ptr addrspace(3) %14, i32 2048, !dbg !54
  store i64 %tile.sroa.5.16.copyload, ptr addrspace(3) %add.ptr112.2, align 8, !dbg !55
  %xor107.3 = xor i32 %add106.2, %add101.1, !dbg !53
  %.idx269.3 = shl nuw nsw i32 %xor107.3, 3, !dbg !54
  %15 = getelementptr inbounds i8, ptr addrspace(3) %gep.2, i32 %.idx269.3, !dbg !54
  %add.ptr112.3 = getelementptr inbounds i8, ptr addrspace(3) %15, i32 2048, !dbg !54
  store i64 %tile.sroa.7.16.copyload, ptr addrspace(3) %add.ptr112.3, align 8, !dbg !55
  fence syncscope("warp") release, !dbg !58
  tail call void @llvm.mxc.barrier.warp(), !dbg !64
  fence syncscope("warp") acquire, !dbg !65
  %and122 = shl nuw nsw i32 %2, 6
  %mul123 = and i32 %and122, 960
  %shr126 = lshr i32 %2, 4
  %and129 = and i32 %2, 7
  %16 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul123
  %xor130 = xor i32 %shr126, %and129, !dbg !66
  %add.ptr134.idx = shl nuw nsw i32 %xor130, 4, !dbg !67
  %add.ptr134 = getelementptr inbounds i8, ptr addrspace(3) %16, i32 %add.ptr134.idx, !dbg !67
  %add127.1 = add nuw nsw i32 %shr126, 4, !dbg !68
  %xor130.1 = xor i32 %add127.1, %and129, !dbg !66
  %add.ptr134.idx.1 = shl nuw nsw i32 %xor130.1, 4, !dbg !67
  %add.ptr134.1 = getelementptr inbounds i8, ptr addrspace(3) %16, i32 %add.ptr134.idx.1, !dbg !67
  %17 = shl nuw nsw i32 %2, 4
  %mul149 = and i32 %17, 16128
  %and156 = lshr i32 %2, 2
  %shr157 = and i32 %and156, 3
  %mul161 = and i32 %and156, 252
  %and168 = and i32 %2, 3
  %add152 = or disjoint i32 %mul149, %and168
  %18 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add152, !dbg !69
  %gep279.idx = shl nuw nsw i32 %and156, 3, !dbg !69
  %gep279 = getelementptr inbounds i8, ptr addrspace(3) %18, i32 %gep279.idx, !dbg !69
  %19 = load i16, ptr addrspace(3) %gep279, align 2, !dbg !70, !tbaa !71
  %add163.1 = or disjoint i32 %mul161, 1, !dbg !72
  %xor164.1 = xor i32 %shr157, %add163.1, !dbg !73
  %add166.1 = or disjoint i32 %add152, 64, !dbg !74
  %20 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add166.1, !dbg !69
  %gep279.idx.1 = shl nuw nsw i32 %xor164.1, 3, !dbg !69
  %gep279.1 = getelementptr inbounds i8, ptr addrspace(3) %20, i32 %gep279.idx.1, !dbg !69
  %21 = load i16, ptr addrspace(3) %gep279.1, align 2, !dbg !70, !tbaa !71
  %add163.2 = or disjoint i32 %mul161, 2, !dbg !72
  %xor164.2 = xor i32 %shr157, %add163.2, !dbg !73
  %add166.2 = or disjoint i32 %add152, 128, !dbg !74
  %22 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add166.2, !dbg !69
  %gep279.idx.2 = shl nuw nsw i32 %xor164.2, 3, !dbg !69
  %gep279.2 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 %gep279.idx.2, !dbg !69
  %23 = load i16, ptr addrspace(3) %gep279.2, align 2, !dbg !70, !tbaa !71
  %add163.3 = or i32 %and156, 3, !dbg !72
  %add166.3 = or disjoint i32 %add152, 192, !dbg !74
  %24 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add166.3, !dbg !69
  %xor164.3 = shl nuw nsw i32 %and156, 3, !dbg !69
  %gep279.idx.3 = xor i32 %xor164.3, 24, !dbg !69
  %gep279.3 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 %gep279.idx.3, !dbg !69
  %25 = load i16, ptr addrspace(3) %gep279.3, align 2, !dbg !70, !tbaa !71
  %add158.4 = or disjoint i32 %shr157, 4, !dbg !75
  %xor164.4 = xor i32 %add158.4, %mul161, !dbg !73
  %gep279.idx.4 = shl nuw nsw i32 %xor164.4, 3, !dbg !69
  %gep279.4 = getelementptr inbounds i8, ptr addrspace(3) %18, i32 %gep279.idx.4, !dbg !69
  %26 = load i16, ptr addrspace(3) %gep279.4, align 2, !dbg !70, !tbaa !71
  %xor164.5 = xor i32 %add158.4, %add163.1, !dbg !73
  %gep279.idx.5 = shl nuw nsw i32 %xor164.5, 3, !dbg !69
  %gep279.5 = getelementptr inbounds i8, ptr addrspace(3) %20, i32 %gep279.idx.5, !dbg !69
  %27 = load i16, ptr addrspace(3) %gep279.5, align 2, !dbg !70, !tbaa !71
  %xor164.6 = xor i32 %add158.4, %add163.2, !dbg !73
  %gep279.idx.6 = shl nuw nsw i32 %xor164.6, 3, !dbg !69
  %gep279.6 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 %gep279.idx.6, !dbg !69
  %28 = load i16, ptr addrspace(3) %gep279.6, align 2, !dbg !70, !tbaa !71
  %xor164.7 = xor i32 %add158.4, %add163.3, !dbg !73
  %gep279.idx.7 = shl nuw nsw i32 %xor164.7, 3, !dbg !69
  %gep279.7 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 %gep279.idx.7, !dbg !69
  %29 = load i16, ptr addrspace(3) %gep279.7, align 2, !dbg !70, !tbaa !71
  %add158.8 = or disjoint i32 %shr157, 8, !dbg !75
  %xor164.8 = xor i32 %add158.8, %mul161, !dbg !73
  %gep279.idx.8 = shl nuw nsw i32 %xor164.8, 3, !dbg !69
  %gep279.8 = getelementptr inbounds i8, ptr addrspace(3) %18, i32 %gep279.idx.8, !dbg !69
  %30 = load i16, ptr addrspace(3) %gep279.8, align 2, !dbg !70, !tbaa !71
  %xor164.9 = xor i32 %add158.8, %add163.1, !dbg !73
  %gep279.idx.9 = shl nuw nsw i32 %xor164.9, 3, !dbg !69
  %gep279.9 = getelementptr inbounds i8, ptr addrspace(3) %20, i32 %gep279.idx.9, !dbg !69
  %31 = load i16, ptr addrspace(3) %gep279.9, align 2, !dbg !70, !tbaa !71
  %xor164.10 = xor i32 %add158.8, %add163.2, !dbg !73
  %gep279.idx.10 = shl nuw nsw i32 %xor164.10, 3, !dbg !69
  %gep279.10 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 %gep279.idx.10, !dbg !69
  %32 = load i16, ptr addrspace(3) %gep279.10, align 2, !dbg !70, !tbaa !71
  %xor164.11 = xor i32 %add158.8, %add163.3, !dbg !73
  %gep279.idx.11 = shl nuw nsw i32 %xor164.11, 3, !dbg !69
  %gep279.11 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 %gep279.idx.11, !dbg !69
  %33 = load i16, ptr addrspace(3) %gep279.11, align 2, !dbg !70, !tbaa !71
  %add158.12 = or disjoint i32 %shr157, 12, !dbg !75
  %xor164.12 = xor i32 %add158.12, %mul161, !dbg !73
  %gep279.idx.12 = shl nuw nsw i32 %xor164.12, 3, !dbg !69
  %gep279.12 = getelementptr inbounds i8, ptr addrspace(3) %18, i32 %gep279.idx.12, !dbg !69
  %34 = load i16, ptr addrspace(3) %gep279.12, align 2, !dbg !70, !tbaa !71
  %xor164.13 = xor i32 %add158.12, %add163.1, !dbg !73
  %gep279.idx.13 = shl nuw nsw i32 %xor164.13, 3, !dbg !69
  %gep279.13 = getelementptr inbounds i8, ptr addrspace(3) %20, i32 %gep279.idx.13, !dbg !69
  %35 = load i16, ptr addrspace(3) %gep279.13, align 2, !dbg !70, !tbaa !71
  %xor164.14 = xor i32 %add158.12, %add163.2, !dbg !73
  %gep279.idx.14 = shl nuw nsw i32 %xor164.14, 3, !dbg !69
  %gep279.14 = getelementptr inbounds i8, ptr addrspace(3) %22, i32 %gep279.idx.14, !dbg !69
  %36 = load i16, ptr addrspace(3) %gep279.14, align 2, !dbg !70, !tbaa !71
  %xor164.15 = xor i32 %add158.12, %add163.3, !dbg !73
  %gep279.idx.15 = shl nuw nsw i32 %xor164.15, 3, !dbg !69
  %gep279.15 = getelementptr inbounds i8, ptr addrspace(3) %24, i32 %gep279.idx.15, !dbg !69
  %37 = load i16, ptr addrspace(3) %gep279.15, align 2, !dbg !70, !tbaa !71
  %38 = shl i32 %0, 11
  %mul187 = and i32 %38, 2147475456
  %mul189 = shl nsw i32 %4, 12
  %mul193 = and i32 %38, 2048
  %39 = shl i32 %0, 8
  %mul200 = and i32 %39, 512
  %add201 = add nuw nsw i32 %and17, %mul189
  %add190 = add nuw nsw i32 %add201, %mul187
  %add194 = add nuw nsw i32 %add190, %mul193
  %add196 = add nuw nsw i32 %add194, %mul200
  %40 = zext nneg i32 %add196 to i64, !dbg !76
  %add.ptr206 = getelementptr inbounds %struct.__half, ptr addrspace(1) %PackedK.coerce, i64 %40, !dbg !77
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr206, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr134, i64 16, i1 false), !dbg !78, !call_argsrelate !79
  %41 = getelementptr inbounds %struct.__half, ptr addrspace(1) %PackedK.coerce, i64 %40, !dbg !77
  %add.ptr206.1 = getelementptr inbounds i8, ptr addrspace(1) %41, i64 2048, !dbg !77
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr206.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %add.ptr134.1, i64 16, i1 false), !dbg !78, !call_argsrelate !79
  %and226 = shl i32 %0, 10
  %mul227 = and i32 %and226, 3072
  %add230 = add nuw nsw i32 %add190, %mul227
  %42 = zext nneg i32 %add230 to i64, !dbg !80
  %add.ptr235 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Packed.coerce, i64 %42, !dbg !81
  store i16 %19, ptr addrspace(1) %add.ptr235, align 16, !dbg !82
  %packed_v.sroa.4.0.add.ptr235.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr235, i64 2, !dbg !82
  store i16 %21, ptr addrspace(1) %packed_v.sroa.4.0.add.ptr235.sroa_idx, align 2, !dbg !82, !tbaa !30
  %packed_v.sroa.5.0.add.ptr235.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr235, i64 4, !dbg !82
  store i16 %23, ptr addrspace(1) %packed_v.sroa.5.0.add.ptr235.sroa_idx, align 4, !dbg !82
  %packed_v.sroa.6.0.add.ptr235.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr235, i64 6, !dbg !82
  store i16 %25, ptr addrspace(1) %packed_v.sroa.6.0.add.ptr235.sroa_idx, align 2, !dbg !82, !tbaa !30
  %packed_v.sroa.7.0.add.ptr235.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr235, i64 8, !dbg !82
  store i16 %26, ptr addrspace(1) %packed_v.sroa.7.0.add.ptr235.sroa_idx, align 8, !dbg !82
  %packed_v.sroa.8.0.add.ptr235.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr235, i64 10, !dbg !82
  store i16 %27, ptr addrspace(1) %packed_v.sroa.8.0.add.ptr235.sroa_idx, align 2, !dbg !82, !tbaa !30
  %packed_v.sroa.9.0.add.ptr235.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr235, i64 12, !dbg !82
  store i16 %28, ptr addrspace(1) %packed_v.sroa.9.0.add.ptr235.sroa_idx, align 4, !dbg !82
  %packed_v.sroa.10.0.add.ptr235.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %add.ptr235, i64 14, !dbg !82
  store i16 %29, ptr addrspace(1) %packed_v.sroa.10.0.add.ptr235.sroa_idx, align 2, !dbg !82, !tbaa !30
  %43 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Packed.coerce, i64 %42, !dbg !81
  %add.ptr235.1 = getelementptr inbounds i8, ptr addrspace(1) %43, i64 1024, !dbg !81
  store i16 %30, ptr addrspace(1) %add.ptr235.1, align 16, !dbg !82
  %packed_v.sroa.13.16.add.ptr235.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %43, i64 1026, !dbg !82
  store i16 %31, ptr addrspace(1) %packed_v.sroa.13.16.add.ptr235.1.sroa_idx, align 2, !dbg !82, !tbaa !30
  %packed_v.sroa.14.16.add.ptr235.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %43, i64 1028, !dbg !82
  store i16 %32, ptr addrspace(1) %packed_v.sroa.14.16.add.ptr235.1.sroa_idx, align 4, !dbg !82
  %packed_v.sroa.15.16.add.ptr235.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %43, i64 1030, !dbg !82
  store i16 %33, ptr addrspace(1) %packed_v.sroa.15.16.add.ptr235.1.sroa_idx, align 2, !dbg !82, !tbaa !30
  %packed_v.sroa.16.16.add.ptr235.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %43, i64 1032, !dbg !82
  store i16 %34, ptr addrspace(1) %packed_v.sroa.16.16.add.ptr235.1.sroa_idx, align 8, !dbg !82
  %packed_v.sroa.17.16.add.ptr235.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %43, i64 1034, !dbg !82
  store i16 %35, ptr addrspace(1) %packed_v.sroa.17.16.add.ptr235.1.sroa_idx, align 2, !dbg !82, !tbaa !30
  %packed_v.sroa.18.16.add.ptr235.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %43, i64 1036, !dbg !82
  store i16 %36, ptr addrspace(1) %packed_v.sroa.18.16.add.ptr235.1.sroa_idx, align 4, !dbg !82
  %packed_v.sroa.19.16.add.ptr235.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(1) %43, i64 1038, !dbg !82
  store i16 %37, ptr addrspace(1) %packed_v.sroa.19.16.add.ptr235.1.sroa_idx, align 2, !dbg !82, !tbaa !30
  ret void, !dbg !83
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

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #4

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #4

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i1 @llvm.mxc.is.private(ptr nocapture) #4

; Function Attrs: nounwind willreturn
declare void @llvm.mxc.sleep(i32 immarg) #6

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noalias nocapture writeonly, ptr addrspace(4) noalias nocapture readonly, i64, i1 immarg) #7

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #7

attributes #0 = { mustprogress noreturn nounwind "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { nounwind speculatable willreturn memory(none) }
attributes #5 = { convergent nounwind willreturn }
attributes #6 = { nounwind willreturn }
attributes #7 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmpkmb2u0jj/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpkmb2u0jj/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 17, column: 3, scope: !40)
!44 = !DILocation(line: 18, column: 87, scope: !40)
!45 = !DILocation(line: 18, column: 201, scope: !40)
!46 = !DILocation(line: 18, column: 46, scope: !40)
!47 = !DILocation(line: 22, column: 47, scope: !40)
!48 = !DILocation(line: 22, column: 33, scope: !40)
!49 = !DILocation(line: 25, column: 3, scope: !40)
!50 = !DILocation(line: 26, column: 157, scope: !40)
!51 = !{i32 -1, i32 0, i32 -1, i32 -1}
!52 = !DILocation(line: 26, column: 40, scope: !40)
!53 = !DILocation(line: 30, column: 149, scope: !40)
!54 = !DILocation(line: 30, column: 40, scope: !40)
!55 = !DILocation(line: 30, column: 214, scope: !40)
!56 = !DILocation(line: 30, column: 136, scope: !40)
!57 = !DILocation(line: 30, column: 169, scope: !40)
!58 = !DILocation(line: 68, column: 3, scope: !59, inlinedAt: !61)
!59 = distinct !DISubprogram(name: "__barrier_warp", scope: !60, file: !60, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!60 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!61 = distinct !DILocation(line: 192, column: 3, scope: !62, inlinedAt: !63)
!62 = distinct !DISubprogram(name: "__syncwarp", scope: !60, file: !60, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!63 = distinct !DILocation(line: 32, column: 3, scope: !40)
!64 = !DILocation(line: 69, column: 3, scope: !59, inlinedAt: !61)
!65 = !DILocation(line: 70, column: 3, scope: !59, inlinedAt: !61)
!66 = !DILocation(line: 35, column: 154, scope: !40)
!67 = !DILocation(line: 35, column: 74, scope: !40)
!68 = !DILocation(line: 35, column: 125, scope: !40)
!69 = !DILocation(line: 39, column: 21, scope: !40)
!70 = !DILocation(line: 39, column: 19, scope: !40)
!71 = !{!26, !26, i64 0}
!72 = !DILocation(line: 39, column: 197, scope: !40)
!73 = !DILocation(line: 39, column: 162, scope: !40)
!74 = !DILocation(line: 39, column: 104, scope: !40)
!75 = !DILocation(line: 39, column: 126, scope: !40)
!76 = !DILocation(line: 42, column: 3, scope: !40)
!77 = !DILocation(line: 43, column: 23, scope: !40)
!78 = !DILocation(line: 43, column: 217, scope: !40)
!79 = !{i32 2, i32 -1, i32 -1, i32 -1}
!80 = !DILocation(line: 46, column: 3, scope: !40)
!81 = !DILocation(line: 47, column: 22, scope: !40)
!82 = !DILocation(line: 47, column: 172, scope: !40)
!83 = !DILocation(line: 49, column: 1, scope: !40)
