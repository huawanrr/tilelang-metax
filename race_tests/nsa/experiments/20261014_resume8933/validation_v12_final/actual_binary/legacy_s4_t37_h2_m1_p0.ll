; ModuleID = '/data/tilelang-metax/race_tests/nsa/experiments/20261014_resume8933/validation_v12_final/actual_binary/legacy_s4_t37_h2_m1_p0.bc'
source_filename = "/tmp/tmpi_6uxjdh/tvm_kernels.maca"
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

; Function Attrs: convergent mustprogress norecurse nounwind
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %BlockIndices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V.coerce) local_unnamed_addr #3 !dbg !40 {
entry:
  %indices = alloca [4 x i32], align 4, addrspace(5)
  call void @llvm.lifetime.start.p5(i64 16, ptr addrspace(5) %indices) #11, !dbg !42
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul = shl nsw i32 %0, 3
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul7 = shl nsw i32 %1, 2
  %add = add nuw nsw i32 %mul, %mul7
  %2 = zext nneg i32 %add to i64, !dbg !43
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %2, !dbg !44
  %3 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !44, !tbaa !30
  %cmp10 = icmp ult i32 %3, 3
  %4 = shl nsw i32 %3, 4, !dbg !45
  %mul11 = select i1 %cmp10, i32 %4, i32 -16, !dbg !45
  store i32 %mul11, ptr addrspace(5) %indices, align 4, !dbg !46, !tbaa !30
  %5 = or disjoint i64 %2, 1, !dbg !47
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %5, !dbg !44
  %6 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !dbg !44, !tbaa !30
  %cmp10.1 = icmp ult i32 %6, 3
  %7 = shl nsw i32 %6, 4, !dbg !45
  %mul11.1 = select i1 %cmp10.1, i32 %7, i32 -16, !dbg !45
  %arrayidx13.1 = getelementptr inbounds i8, ptr addrspace(5) %indices, i32 4, !dbg !48
  store i32 %mul11.1, ptr addrspace(5) %arrayidx13.1, align 4, !dbg !46, !tbaa !30
  %8 = or disjoint i64 %2, 2, !dbg !47
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8, !dbg !44
  %9 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !dbg !44, !tbaa !30
  %cmp10.2 = icmp ult i32 %9, 3
  %10 = shl nsw i32 %9, 4, !dbg !45
  %mul11.2 = select i1 %cmp10.2, i32 %10, i32 -16, !dbg !45
  %arrayidx13.2 = getelementptr inbounds i8, ptr addrspace(5) %indices, i32 8, !dbg !48
  store i32 %mul11.2, ptr addrspace(5) %arrayidx13.2, align 4, !dbg !46, !tbaa !30
  %11 = or disjoint i64 %2, 3, !dbg !47
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %11, !dbg !44
  %12 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !dbg !44, !tbaa !30
  %cmp10.3 = icmp ult i32 %12, 3
  %13 = shl nsw i32 %12, 4, !dbg !45
  %mul11.3 = select i1 %cmp10.3, i32 %13, i32 -16, !dbg !45
  %arrayidx13.3 = getelementptr inbounds i8, ptr addrspace(5) %indices, i32 12, !dbg !48
  store i32 %mul11.3, ptr addrspace(5) %arrayidx13.3, align 4, !dbg !46, !tbaa !30
  %mul20 = shl nsw i32 %0, 11
  %mul22 = shl nsw i32 %1, 10
  %add23 = add nuw nsw i32 %mul20, %mul22
  %14 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !49
  %and = shl nuw nsw i32 %14, 6
  %mul25 = and i32 %and, 960
  %add26 = or disjoint i32 %add23, %mul25
  %15 = lshr i32 %14, 1
  %mul30 = and i32 %15, 504
  %add28 = add nuw nsw i32 %add26, %mul30
  %16 = zext nneg i32 %add28 to i64, !dbg !50
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %16, !dbg !51
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16, !dbg !52
  %Q_reg.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !52
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.4.0.add.ptr.sroa_idx, align 8, !dbg !52
  %17 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %16, !dbg !51
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %17, i64 64, !dbg !51
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16, !dbg !52
  %Q_reg.sroa.7.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %17, i64 72, !dbg !52
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.7.16.add.ptr.1.sroa_idx, align 8, !dbg !52
  %shr73 = lshr i32 %14, 3
  %18 = shl nuw nsw i32 %14, 4
  %mul81 = and i32 %18, 16256
  %mul86 = shl nsw i32 %1, 6
  %add82 = add nuw nsw i32 %mul81, %mul86
  %and89 = shl nuw nsw i32 %14, 3
  %mul90 = and i32 %and89, 56
  %add84 = or disjoint i32 %add82, %mul90
  %mul192 = and i32 %and89, 8128
  %call196.masked = and i32 %14, 1016
  %mul198 = xor i32 %mul90, %call196.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul192
  %invariant.gep675 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul198
  %19 = lshr i32 %14, 2
  %mul213 = and i32 %19, 252
  %shr245 = lshr i32 %14, 4
  %and248 = and i32 %14, 7
  %20 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul25
  %invariant.gep687 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 2048
  %mul361 = and i32 %18, 16128
  %shr367 = and i32 %shr73, 1
  %mul372 = and i32 %19, 4
  %K_reg.sroa.4.0.invariant.gep675.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 4
  %K_reg.sroa.5.0.invariant.gep675.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 8
  %K_reg.sroa.6.0.invariant.gep675.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 12
  %gep676.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 1024
  %K_reg.sroa.9.16.gep676.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 1028
  %K_reg.sroa.10.16.gep676.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 1032
  %K_reg.sroa.11.16.gep676.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 1036
  %xor249 = xor i32 %shr245, %and248
  %add.ptr253.idx = shl nuw nsw i32 %xor249, 4
  %add.ptr253 = getelementptr inbounds i8, ptr addrspace(3) %20, i32 %add.ptr253.idx
  %kb.sroa.6.0.add.ptr253.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr253, i32 8
  %add246.1 = add nuw nsw i32 %shr245, 4
  %xor249.1 = xor i32 %add246.1, %and248
  %add.ptr253.idx.1 = shl nuw nsw i32 %xor249.1, 4
  %add.ptr253.1 = getelementptr inbounds i8, ptr addrspace(3) %20, i32 %add.ptr253.idx.1
  %kb.sroa.6.0.add.ptr253.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr253.1, i32 8
  %V_reg.sroa.4.0.invariant.gep687.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 2052
  %V_reg.sroa.5.0.invariant.gep687.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 2056
  %V_reg.sroa.6.0.invariant.gep687.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 2060
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 3072
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 3076
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 3080
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep675, i32 3084
  %xor374 = or disjoint i32 %mul372, %shr367
  %mul375 = shl nuw nsw i32 %xor374, 3
  %add376 = or disjoint i32 %mul375, %mul361
  %add379 = or disjoint i32 %add376, %and248
  %gep691 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379
  %add363.1 = or disjoint i32 %mul361, 64
  %add373.1 = or disjoint i32 %mul372, 1
  %xor374.1 = xor i32 %add373.1, %shr367
  %mul375.1 = shl nuw nsw i32 %xor374.1, 3
  %add376.1 = or disjoint i32 %mul375.1, %add363.1
  %add379.1 = or disjoint i32 %add376.1, %and248
  %gep691.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1
  %add363.2 = or disjoint i32 %mul361, 128
  %add373.2 = or disjoint i32 %mul372, 2
  %xor374.2 = or disjoint i32 %add373.2, %shr367
  %mul375.2 = shl nuw nsw i32 %xor374.2, 3
  %add376.2 = or disjoint i32 %mul375.2, %add363.2
  %add379.2 = or disjoint i32 %add376.2, %and248
  %gep691.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.2
  %add363.3 = or disjoint i32 %mul361, 192
  %add373.3 = or disjoint i32 %mul372, 3
  %xor374.3 = xor i32 %add373.3, %shr367
  %mul375.3 = shl nuw nsw i32 %xor374.3, 3
  %add376.3 = or disjoint i32 %mul375.3, %add363.3
  %add379.3 = or disjoint i32 %add376.3, %and248
  %gep691.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.3
  %add368.1 = or disjoint i32 %shr367, 2
  %xor374.1723 = or disjoint i32 %mul372, %add368.1
  %mul375.1724 = shl nuw nsw i32 %xor374.1723, 3
  %add376.1725 = or disjoint i32 %mul375.1724, %mul361
  %add379.1726 = or disjoint i32 %add376.1725, %and248
  %gep691.1727 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1726
  %xor374.1.1 = xor i32 %add373.1, %add368.1
  %mul375.1.1 = shl nuw nsw i32 %xor374.1.1, 3
  %add376.1.1 = or disjoint i32 %mul375.1.1, %add363.1
  %add379.1.1 = or disjoint i32 %add376.1.1, %and248
  %gep691.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1.1
  %xor374.2.1 = xor i32 %add373.2, %add368.1
  %mul375.2.1 = shl nuw nsw i32 %xor374.2.1, 3
  %add376.2.1 = or disjoint i32 %mul375.2.1, %add363.2
  %add379.2.1 = or disjoint i32 %add376.2.1, %and248
  %gep691.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.2.1
  %xor374.3.1 = xor i32 %add373.3, %add368.1
  %mul375.3.1 = shl nuw nsw i32 %xor374.3.1, 3
  %add376.3.1 = or disjoint i32 %mul375.3.1, %add363.3
  %add379.3.1 = or disjoint i32 %add376.3.1, %and248
  %gep691.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.3.1
  %add368.2 = or disjoint i32 %shr367, 4
  %xor374.2729 = xor i32 %mul372, %add368.2
  %mul375.2730 = shl nuw nsw i32 %xor374.2729, 3
  %add376.2731 = or disjoint i32 %mul375.2730, %mul361
  %add379.2732 = or disjoint i32 %add376.2731, %and248
  %gep691.2733 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.2732
  %xor374.1.2 = xor i32 %add373.1, %add368.2
  %mul375.1.2 = shl nuw nsw i32 %xor374.1.2, 3
  %add376.1.2 = or disjoint i32 %mul375.1.2, %add363.1
  %add379.1.2 = or disjoint i32 %add376.1.2, %and248
  %gep691.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1.2
  %xor374.2.2 = xor i32 %add373.2, %add368.2
  %mul375.2.2 = shl nuw nsw i32 %xor374.2.2, 3
  %add376.2.2 = or disjoint i32 %mul375.2.2, %add363.2
  %add379.2.2 = or disjoint i32 %add376.2.2, %and248
  %gep691.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.2.2
  %xor374.3.2 = xor i32 %add373.3, %add368.2
  %mul375.3.2 = shl nuw nsw i32 %xor374.3.2, 3
  %add376.3.2 = or disjoint i32 %mul375.3.2, %add363.3
  %add379.3.2 = or disjoint i32 %add376.3.2, %and248
  %gep691.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.3.2
  %add368.3 = or disjoint i32 %shr367, 6
  %xor374.3735 = xor i32 %mul372, %add368.3
  %mul375.3736 = shl nuw nsw i32 %xor374.3735, 3
  %add376.3737 = or disjoint i32 %mul375.3736, %mul361
  %add379.3738 = or disjoint i32 %add376.3737, %and248
  %gep691.3739 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.3738
  %xor374.1.3 = xor i32 %add373.1, %add368.3
  %mul375.1.3 = shl nuw nsw i32 %xor374.1.3, 3
  %add376.1.3 = or disjoint i32 %mul375.1.3, %add363.1
  %add379.1.3 = or disjoint i32 %add376.1.3, %and248
  %gep691.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.1.3
  %xor374.2.3 = xor i32 %add373.2, %add368.3
  %mul375.2.3 = shl nuw nsw i32 %xor374.2.3, 3
  %add376.2.3 = or disjoint i32 %mul375.2.3, %add363.2
  %add379.2.3 = or disjoint i32 %add376.2.3, %and248
  %gep691.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.2.3
  %xor374.3.3 = xor i32 %add373.3, %add368.3
  %mul375.3.3 = shl nuw nsw i32 %xor374.3.3, 3
  %add376.3.3 = or disjoint i32 %mul375.3.3, %add363.3
  %add379.3.3 = or disjoint i32 %add376.3.3, %and248
  %gep691.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add379.3.3
  br label %for.body60, !dbg !53

for.body60:                                       ; preds = %if.end411.1, %entry
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %entry ], [ %sum_acc.sroa.0.1.1, %if.end411.1 ], !dbg !54
  %sum_acc.sroa.6.0 = phi float [ 0.000000e+00, %entry ], [ %sum_acc.sroa.6.1.1, %if.end411.1 ], !dbg !54
  %sum_acc.sroa.10.0 = phi float [ 0.000000e+00, %entry ], [ %sum_acc.sroa.10.1.1, %if.end411.1 ], !dbg !54
  %sum_acc.sroa.14.0 = phi float [ 0.000000e+00, %entry ], [ %sum_acc.sroa.14.1.1, %if.end411.1 ], !dbg !54
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %acc_o.sroa.0.1.1, %if.end411.1 ], !dbg !54
  %acc_o.sroa.20.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %acc_o.sroa.20.1.1, %if.end411.1 ], !dbg !54
  %acc_o.sroa.38.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %acc_o.sroa.38.1.1, %if.end411.1 ], !dbg !54
  %acc_o.sroa.56.0 = phi <4 x float> [ zeroinitializer, %entry ], [ %acc_o.sroa.56.1.1, %if.end411.1 ], !dbg !54
  %V_reg.sroa.11.0 = phi i32 [ undef, %entry ], [ %V_reg.sroa.11.1.1, %if.end411.1 ]
  %V_reg.sroa.10.0 = phi i32 [ undef, %entry ], [ %V_reg.sroa.10.1.1, %if.end411.1 ]
  %V_reg.sroa.9.0 = phi i32 [ undef, %entry ], [ %V_reg.sroa.9.1.1, %if.end411.1 ]
  %V_reg.sroa.7.0 = phi i32 [ undef, %entry ], [ %V_reg.sroa.7.1.1, %if.end411.1 ]
  %V_reg.sroa.6.0 = phi i32 [ undef, %entry ], [ %V_reg.sroa.6.1.1, %if.end411.1 ]
  %V_reg.sroa.5.0 = phi i32 [ undef, %entry ], [ %V_reg.sroa.5.1.1, %if.end411.1 ]
  %V_reg.sroa.4.0 = phi i32 [ undef, %entry ], [ %V_reg.sroa.4.1.1, %if.end411.1 ]
  %V_reg.sroa.0.0 = phi i32 [ undef, %entry ], [ %V_reg.sroa.0.1.1, %if.end411.1 ]
  %acc_s.sroa.0.0 = phi <4 x float> [ undef, %entry ], [ %acc_s.sroa.0.2.1, %if.end411.1 ]
  %acc_s_cast.sroa.0.0697 = phi <4 x half> [ undef, %entry ], [ %acc_s_cast.sroa.0.1.1, %if.end411.1 ]
  %s.0696 = phi i32 [ 0, %entry ], [ %inc413.1, %if.end411.1 ]
  %arrayidx62 = getelementptr inbounds [4 x i32], ptr addrspace(5) %indices, i32 0, i32 %s.0696, !dbg !55
  %21 = load i32, ptr addrspace(5) %arrayidx62, align 4, !dbg !55, !tbaa !30
  %or.cond702 = icmp ult i32 %21, 37, !dbg !56
  br i1 %or.cond702, label %for.cond67.preheader, label %if.end231, !dbg !56

for.cond67.preheader:                             ; preds = %for.body60
  %add74 = add nuw nsw i32 %21, %shr73
  %mul83 = shl nuw nsw i32 %21, 7
  %add87 = add nuw nsw i32 %add84, %mul83
  %22 = zext nneg i32 %add87 to i64, !dbg !57
  %cmp76 = icmp slt i32 %add74, 37, !dbg !58
  br i1 %cmp76, label %if.then77, label %if.end115, !dbg !59

if.then77:                                        ; preds = %for.cond67.preheader
  %add.ptr93 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %22, !dbg !60
  %condval_1.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr93, align 16, !dbg !61, !tbaa !30
  %condval_1.sroa.5.0.add.ptr93.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr93, i64 4, !dbg !61
  %condval_1.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr93.sroa_idx, align 4, !dbg !61, !tbaa !30
  %condval_1.sroa.6.0.add.ptr93.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr93, i64 8, !dbg !61
  %condval_1.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr93.sroa_idx, align 8, !dbg !61, !tbaa !30
  %condval_1.sroa.7.0.add.ptr93.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr93, i64 12, !dbg !61
  %condval_1.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr93.sroa_idx, align 4, !dbg !61, !tbaa !30
  br label %if.end115, !dbg !62

if.end115:                                        ; preds = %for.cond67.preheader, %if.then77
  %condval_1.sroa.0.0 = phi i32 [ %condval_1.sroa.0.0.copyload, %if.then77 ], [ 0, %for.cond67.preheader ], !dbg !54
  %condval_1.sroa.5.0 = phi i32 [ %condval_1.sroa.5.0.copyload, %if.then77 ], [ 0, %for.cond67.preheader ], !dbg !54
  %condval_1.sroa.6.0 = phi i32 [ %condval_1.sroa.6.0.copyload, %if.then77 ], [ 0, %for.cond67.preheader ], !dbg !54
  %condval_1.sroa.7.0 = phi i32 [ %condval_1.sroa.7.0.copyload, %if.then77 ], [ 0, %for.cond67.preheader ], !dbg !54
  %cmp76.1 = icmp slt i32 %add74, 29, !dbg !58
  br i1 %cmp76.1, label %if.then77.1, label %if.end115.1, !dbg !59

if.then77.1:                                      ; preds = %if.end115
  %23 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %22, !dbg !60
  %add.ptr93.1 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 2048, !dbg !60
  %condval_1.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr93.1, align 16, !dbg !61, !tbaa !30
  %condval_1.sroa.5.0.add.ptr93.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 2052, !dbg !61
  %condval_1.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr93.sroa_idx.1, align 4, !dbg !61, !tbaa !30
  %condval_1.sroa.6.0.add.ptr93.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 2056, !dbg !61
  %condval_1.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr93.sroa_idx.1, align 8, !dbg !61, !tbaa !30
  %condval_1.sroa.7.0.add.ptr93.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %23, i64 2060, !dbg !61
  %condval_1.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr93.sroa_idx.1, align 4, !dbg !61, !tbaa !30
  br label %if.end115.1, !dbg !62

if.end115.1:                                      ; preds = %if.then77.1, %if.end115
  %condval_1.sroa.0.0.1 = phi i32 [ %condval_1.sroa.0.0.copyload.1, %if.then77.1 ], [ 0, %if.end115 ], !dbg !54
  %condval_1.sroa.5.0.1 = phi i32 [ %condval_1.sroa.5.0.copyload.1, %if.then77.1 ], [ 0, %if.end115 ], !dbg !54
  %condval_1.sroa.6.0.1 = phi i32 [ %condval_1.sroa.6.0.copyload.1, %if.then77.1 ], [ 0, %if.end115 ], !dbg !54
  %condval_1.sroa.7.0.1 = phi i32 [ %condval_1.sroa.7.0.copyload.1, %if.then77.1 ], [ 0, %if.end115 ], !dbg !54
  br i1 %cmp76, label %if.then133, label %if.end173, !dbg !63

if.then133:                                       ; preds = %if.end115.1
  %add.ptr149 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %22, !dbg !64
  %condval_2.sroa.0.0.copyload = load i32, ptr addrspace(4) %add.ptr149, align 16, !dbg !65, !tbaa !30
  %condval_2.sroa.5.0.add.ptr149.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr149, i64 4, !dbg !65
  %condval_2.sroa.5.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr149.sroa_idx, align 4, !dbg !65, !tbaa !30
  %condval_2.sroa.6.0.add.ptr149.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr149, i64 8, !dbg !65
  %condval_2.sroa.6.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr149.sroa_idx, align 8, !dbg !65, !tbaa !30
  %condval_2.sroa.7.0.add.ptr149.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr149, i64 12, !dbg !65
  %condval_2.sroa.7.0.copyload = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr149.sroa_idx, align 4, !dbg !65, !tbaa !30
  br label %if.end173, !dbg !66

if.end173:                                        ; preds = %if.end115.1, %if.then133
  %condval_2.sroa.0.0 = phi i32 [ %condval_2.sroa.0.0.copyload, %if.then133 ], [ 0, %if.end115.1 ], !dbg !54
  %condval_2.sroa.5.0 = phi i32 [ %condval_2.sroa.5.0.copyload, %if.then133 ], [ 0, %if.end115.1 ], !dbg !54
  %condval_2.sroa.6.0 = phi i32 [ %condval_2.sroa.6.0.copyload, %if.then133 ], [ 0, %if.end115.1 ], !dbg !54
  %condval_2.sroa.7.0 = phi i32 [ %condval_2.sroa.7.0.copyload, %if.then133 ], [ 0, %if.end115.1 ], !dbg !54
  br i1 %cmp76.1, label %if.then133.1, label %if.end173.1, !dbg !63

if.then133.1:                                     ; preds = %if.end173
  %24 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %22, !dbg !64
  %add.ptr149.1 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 2048, !dbg !64
  %condval_2.sroa.0.0.copyload.1 = load i32, ptr addrspace(4) %add.ptr149.1, align 16, !dbg !65, !tbaa !30
  %condval_2.sroa.5.0.add.ptr149.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 2052, !dbg !65
  %condval_2.sroa.5.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr149.sroa_idx.1, align 4, !dbg !65, !tbaa !30
  %condval_2.sroa.6.0.add.ptr149.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 2056, !dbg !65
  %condval_2.sroa.6.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr149.sroa_idx.1, align 8, !dbg !65, !tbaa !30
  %condval_2.sroa.7.0.add.ptr149.sroa_idx.1 = getelementptr inbounds i8, ptr addrspace(4) %24, i64 2060, !dbg !65
  %condval_2.sroa.7.0.copyload.1 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr149.sroa_idx.1, align 4, !dbg !65, !tbaa !30
  br label %if.end173.1, !dbg !66

if.end173.1:                                      ; preds = %if.then133.1, %if.end173
  %condval_2.sroa.0.0.1 = phi i32 [ %condval_2.sroa.0.0.copyload.1, %if.then133.1 ], [ 0, %if.end173 ], !dbg !54
  %condval_2.sroa.5.0.1 = phi i32 [ %condval_2.sroa.5.0.copyload.1, %if.then133.1 ], [ 0, %if.end173 ], !dbg !54
  %condval_2.sroa.6.0.1 = phi i32 [ %condval_2.sroa.6.0.copyload.1, %if.then133.1 ], [ 0, %if.end173 ], !dbg !54
  %condval_2.sroa.7.0.1 = phi i32 [ %condval_2.sroa.7.0.copyload.1, %if.then133.1 ], [ 0, %if.end173 ], !dbg !54
  store i32 %condval_1.sroa.0.0, ptr addrspace(3) %invariant.gep675, align 16, !dbg !67, !tbaa !30
  store i32 %condval_1.sroa.5.0, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep675.sroa_idx, align 4, !dbg !67, !tbaa !30
  store i32 %condval_1.sroa.6.0, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep675.sroa_idx, align 8, !dbg !67, !tbaa !30
  store i32 %condval_1.sroa.7.0, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep675.sroa_idx, align 4, !dbg !67, !tbaa !30
  store i32 %condval_1.sroa.0.0.1, ptr addrspace(3) %gep676.1, align 16, !dbg !67, !tbaa !30
  store i32 %condval_1.sroa.5.0.1, ptr addrspace(3) %K_reg.sroa.9.16.gep676.1.sroa_idx, align 4, !dbg !67, !tbaa !30
  store i32 %condval_1.sroa.6.0.1, ptr addrspace(3) %K_reg.sroa.10.16.gep676.1.sroa_idx, align 8, !dbg !67, !tbaa !30
  store i32 %condval_1.sroa.7.0.1, ptr addrspace(3) %K_reg.sroa.11.16.gep676.1.sroa_idx, align 4, !dbg !67, !tbaa !30
  %cmp205 = icmp sgt i32 %21, 21, !dbg !68
  br i1 %cmp205, label %for.cond207.preheader, label %if.end231, !dbg !69

for.cond207.preheader:                            ; preds = %if.end173.1
  %add214 = add nuw nsw i32 %21, %mul213
  %cmp216 = icmp slt i32 %add214, 37, !dbg !70
  %.fneg = select i1 %cmp216, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.0.vec.insert759 = insertelement <4 x float> poison, float %.fneg, i64 0, !dbg !71
  %cmp216.1 = icmp slt i32 %add214, 36, !dbg !70
  %.fneg.1 = select i1 %cmp216.1, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert768 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert759, float %.fneg.1, i64 1, !dbg !71
  %cmp216.2 = icmp slt i32 %add214, 35, !dbg !70
  %.fneg.2 = select i1 %cmp216.2, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.8.vec.insert777 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert768, float %.fneg.2, i64 2, !dbg !71
  %cmp216.3 = icmp slt i32 %add214, 34, !dbg !70
  %.fneg.3 = select i1 %cmp216.3, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.12.vec.insert786 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert777, float %.fneg.3, i64 3, !dbg !71
  br label %if.end231, !dbg !72

if.end231:                                        ; preds = %if.end173.1, %for.cond207.preheader, %for.body60
  %V_reg.sroa.11.1 = phi i32 [ %condval_2.sroa.7.0.1, %for.cond207.preheader ], [ %V_reg.sroa.11.0, %for.body60 ], [ %condval_2.sroa.7.0.1, %if.end173.1 ]
  %V_reg.sroa.10.1 = phi i32 [ %condval_2.sroa.6.0.1, %for.cond207.preheader ], [ %V_reg.sroa.10.0, %for.body60 ], [ %condval_2.sroa.6.0.1, %if.end173.1 ]
  %V_reg.sroa.9.1 = phi i32 [ %condval_2.sroa.5.0.1, %for.cond207.preheader ], [ %V_reg.sroa.9.0, %for.body60 ], [ %condval_2.sroa.5.0.1, %if.end173.1 ]
  %V_reg.sroa.7.1 = phi i32 [ %condval_2.sroa.0.0.1, %for.cond207.preheader ], [ %V_reg.sroa.7.0, %for.body60 ], [ %condval_2.sroa.0.0.1, %if.end173.1 ]
  %V_reg.sroa.6.1 = phi i32 [ %condval_2.sroa.7.0, %for.cond207.preheader ], [ %V_reg.sroa.6.0, %for.body60 ], [ %condval_2.sroa.7.0, %if.end173.1 ]
  %V_reg.sroa.5.1 = phi i32 [ %condval_2.sroa.6.0, %for.cond207.preheader ], [ %V_reg.sroa.5.0, %for.body60 ], [ %condval_2.sroa.6.0, %if.end173.1 ]
  %V_reg.sroa.4.1 = phi i32 [ %condval_2.sroa.5.0, %for.cond207.preheader ], [ %V_reg.sroa.4.0, %for.body60 ], [ %condval_2.sroa.5.0, %if.end173.1 ]
  %V_reg.sroa.0.1 = phi i32 [ %condval_2.sroa.0.0, %for.cond207.preheader ], [ %V_reg.sroa.0.0, %for.body60 ], [ %condval_2.sroa.0.0, %if.end173.1 ]
  %acc_s.sroa.0.1 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert786, %for.cond207.preheader ], [ %acc_s.sroa.0.0, %for.body60 ], [ zeroinitializer, %if.end173.1 ]
  fence syncscope("block") release, !dbg !72
  tail call void @llvm.mxc.barrier(), !dbg !78
  fence syncscope("block") acquire, !dbg !79
  br i1 %or.cond702, label %for.cond236.preheader, label %if.end346, !dbg !80

for.cond236.preheader:                            ; preds = %if.end231
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr253, align 16, !dbg !81
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr253.sroa_idx, align 8, !dbg !81
  %25 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.1), !dbg !82, !call_argsrelate !83
  %26 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %25), !dbg !82, !call_argsrelate !83
  %kb.sroa.0.0.copyload753 = load <4 x half>, ptr addrspace(3) %add.ptr253.1, align 16, !dbg !81
  %kb.sroa.6.0.copyload754 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr253.1.sroa_idx, align 8, !dbg !81
  %27 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload753, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %26), !dbg !82, !call_argsrelate !83
  %28 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload754, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %27), !dbg !82, !call_argsrelate !83
  store i32 %V_reg.sroa.0.1, ptr addrspace(3) %invariant.gep687, align 16, !dbg !84, !tbaa !30
  store i32 %V_reg.sroa.4.1, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep687.sroa_idx, align 4, !dbg !84, !tbaa !30
  store i32 %V_reg.sroa.5.1, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep687.sroa_idx, align 8, !dbg !84, !tbaa !30
  store i32 %V_reg.sroa.6.1, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep687.sroa_idx, align 4, !dbg !84, !tbaa !30
  store i32 %V_reg.sroa.7.1, ptr addrspace(3) %gep.1, align 16, !dbg !84, !tbaa !30
  store i32 %V_reg.sroa.9.1, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !dbg !84, !tbaa !30
  store i32 %V_reg.sroa.10.1, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !dbg !84, !tbaa !30
  store i32 %V_reg.sroa.11.1, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !dbg !84, !tbaa !30
  %acc_s.sroa.0.0.vec.extract761 = extractelement <4 x float> %28, i64 0, !dbg !85
  %mul310 = fmul contract float %acc_s.sroa.0.0.vec.extract761, 0x3FC2776C60000000, !dbg !86
  %29 = tail call contract noundef float @llvm.minnum.f32(float %mul310, float 1.500000e+01), !dbg !87
  %cmp.i.i = fcmp contract olt float %29, -1.260000e+02, !dbg !91
  %cond.i.i = select contract i1 %cmp.i.i, float 6.400000e+01, float 0.000000e+00, !dbg !91
  %add.i.i636 = fadd contract float %29, %cond.i.i, !dbg !91
  %30 = tail call contract float @llvm.exp2.f32(float %add.i.i636), !dbg !91
  %cond2.i.i = select contract i1 %cmp.i.i, float 0x3BF0000000000000, float 1.000000e+00, !dbg !91
  %mul.i.i = fmul contract float %cond2.i.i, %30, !dbg !91
  %acc_s.sroa.0.0.vec.insert763 = insertelement <4 x float> poison, float %mul.i.i, i64 0, !dbg !94
  %acc_s.sroa.0.4.vec.extract770 = extractelement <4 x float> %28, i64 1, !dbg !85
  %mul310.1 = fmul contract float %acc_s.sroa.0.4.vec.extract770, 0x3FC2776C60000000, !dbg !86
  %31 = tail call contract noundef float @llvm.minnum.f32(float %mul310.1, float 1.500000e+01), !dbg !87
  %cmp.i.i.1 = fcmp contract olt float %31, -1.260000e+02, !dbg !91
  %cond.i.i.1 = select contract i1 %cmp.i.i.1, float 6.400000e+01, float 0.000000e+00, !dbg !91
  %add.i.i636.1 = fadd contract float %31, %cond.i.i.1, !dbg !91
  %32 = tail call contract float @llvm.exp2.f32(float %add.i.i636.1), !dbg !91
  %cond2.i.i.1 = select contract i1 %cmp.i.i.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !91
  %mul.i.i.1 = fmul contract float %cond2.i.i.1, %32, !dbg !91
  %acc_s.sroa.0.4.vec.insert772 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert763, float %mul.i.i.1, i64 1, !dbg !94
  %acc_s.sroa.0.8.vec.extract779 = extractelement <4 x float> %28, i64 2, !dbg !85
  %mul310.2 = fmul contract float %acc_s.sroa.0.8.vec.extract779, 0x3FC2776C60000000, !dbg !86
  %33 = tail call contract noundef float @llvm.minnum.f32(float %mul310.2, float 1.500000e+01), !dbg !87
  %cmp.i.i.2 = fcmp contract olt float %33, -1.260000e+02, !dbg !91
  %cond.i.i.2 = select contract i1 %cmp.i.i.2, float 6.400000e+01, float 0.000000e+00, !dbg !91
  %add.i.i636.2 = fadd contract float %33, %cond.i.i.2, !dbg !91
  %34 = tail call contract float @llvm.exp2.f32(float %add.i.i636.2), !dbg !91
  %cond2.i.i.2 = select contract i1 %cmp.i.i.2, float 0x3BF0000000000000, float 1.000000e+00, !dbg !91
  %mul.i.i.2 = fmul contract float %cond2.i.i.2, %34, !dbg !91
  %acc_s.sroa.0.8.vec.insert781 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert772, float %mul.i.i.2, i64 2, !dbg !94
  %acc_s.sroa.0.12.vec.extract788 = extractelement <4 x float> %28, i64 3, !dbg !85
  %mul310.3 = fmul contract float %acc_s.sroa.0.12.vec.extract788, 0x3FC2776C60000000, !dbg !86
  %35 = tail call contract noundef float @llvm.minnum.f32(float %mul310.3, float 1.500000e+01), !dbg !87
  %cmp.i.i.3 = fcmp contract olt float %35, -1.260000e+02, !dbg !91
  %cond.i.i.3 = select contract i1 %cmp.i.i.3, float 6.400000e+01, float 0.000000e+00, !dbg !91
  %add.i.i636.3 = fadd contract float %35, %cond.i.i.3, !dbg !91
  %36 = tail call contract float @llvm.exp2.f32(float %add.i.i636.3), !dbg !91
  %cond2.i.i.3 = select contract i1 %cmp.i.i.3, float 0x3BF0000000000000, float 1.000000e+00, !dbg !91
  %mul.i.i.3 = fmul contract float %cond2.i.i.3, %36, !dbg !91
  %acc_s.sroa.0.12.vec.insert790 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert781, float %mul.i.i.3, i64 3, !dbg !94
  %add326 = fadd contract float %sum_acc.sroa.0.0, %mul.i.i, !dbg !95
  %add326.1 = fadd contract float %sum_acc.sroa.6.0, %mul.i.i.1, !dbg !95
  %add326.2 = fadd contract float %sum_acc.sroa.10.0, %mul.i.i.2, !dbg !95
  %add326.3 = fadd contract float %sum_acc.sroa.14.0, %mul.i.i.3, !dbg !95
  %37 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !96
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !96, !noalias !104
  %38 = fptrunc float %mul.i.i to half, !dbg !96
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %37), !dbg !96, !noalias !104
  %39 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !109
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !109, !noalias !104
  %40 = fptrunc float %mul.i.i.1 to half, !dbg !109
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %39), !dbg !109, !noalias !104
  %__1.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %38, i64 0, !dbg !111
  %__1.sroa.0.2.vec.insert = insertelement <4 x half> %__1.sroa.0.0.vec.insert, half %40, i64 1, !dbg !111
  %41 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !114
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !114, !noalias !118
  %42 = fptrunc float %mul.i.i.2 to half, !dbg !114
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %41), !dbg !114, !noalias !118
  %43 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !123
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !123, !noalias !118
  %44 = fptrunc float %mul.i.i.3 to half, !dbg !123
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %43), !dbg !123, !noalias !118
  %__1.sroa.0.4.vec.insert = insertelement <4 x half> %__1.sroa.0.2.vec.insert, half %42, i64 2, !dbg !125
  %__1.sroa.0.6.vec.insert = insertelement <4 x half> %__1.sroa.0.4.vec.insert, half %44, i64 3, !dbg !125
  br label %if.end346, !dbg !127

if.end346:                                        ; preds = %for.cond236.preheader, %if.end231
  %sum_acc.sroa.0.1 = phi float [ %add326, %for.cond236.preheader ], [ %sum_acc.sroa.0.0, %if.end231 ], !dbg !54
  %sum_acc.sroa.6.1 = phi float [ %add326.1, %for.cond236.preheader ], [ %sum_acc.sroa.6.0, %if.end231 ], !dbg !54
  %sum_acc.sroa.10.1 = phi float [ %add326.2, %for.cond236.preheader ], [ %sum_acc.sroa.10.0, %if.end231 ], !dbg !54
  %sum_acc.sroa.14.1 = phi float [ %add326.3, %for.cond236.preheader ], [ %sum_acc.sroa.14.0, %if.end231 ], !dbg !54
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert790, %for.cond236.preheader ], [ %acc_s.sroa.0.1, %if.end231 ], !dbg !54
  %acc_s_cast.sroa.0.1 = phi <4 x half> [ %__1.sroa.0.6.vec.insert, %for.cond236.preheader ], [ %acc_s_cast.sroa.0.0697, %if.end231 ]
  fence syncscope("block") release, !dbg !128
  tail call void @llvm.mxc.barrier(), !dbg !131
  fence syncscope("block") acquire, !dbg !132
  br i1 %or.cond702, label %for.cond355.preheader.preheader, label %if.end411, !dbg !133

for.cond355.preheader.preheader:                  ; preds = %if.end346
  %45 = load half, ptr addrspace(3) %gep691, align 2, !dbg !134, !tbaa !135
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %45, i64 0, !dbg !134
  %46 = load half, ptr addrspace(3) %gep691.1, align 2, !dbg !134, !tbaa !135
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %46, i64 1, !dbg !134
  %47 = load half, ptr addrspace(3) %gep691.2, align 2, !dbg !134, !tbaa !135
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %47, i64 2, !dbg !134
  %48 = load half, ptr addrspace(3) %gep691.3, align 2, !dbg !134, !tbaa !135
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %48, i64 3, !dbg !134
  %49 = load half, ptr addrspace(3) %gep691.1727, align 2, !dbg !134, !tbaa !135
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %49, i64 0, !dbg !134
  %50 = load half, ptr addrspace(3) %gep691.1.1, align 2, !dbg !134, !tbaa !135
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %50, i64 1, !dbg !134
  %51 = load half, ptr addrspace(3) %gep691.2.1, align 2, !dbg !134, !tbaa !135
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %51, i64 2, !dbg !134
  %52 = load half, ptr addrspace(3) %gep691.3.1, align 2, !dbg !134, !tbaa !135
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %52, i64 3, !dbg !134
  %53 = load half, ptr addrspace(3) %gep691.2733, align 2, !dbg !134, !tbaa !135
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %53, i64 0, !dbg !134
  %54 = load half, ptr addrspace(3) %gep691.1.2, align 2, !dbg !134, !tbaa !135
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %54, i64 1, !dbg !134
  %55 = load half, ptr addrspace(3) %gep691.2.2, align 2, !dbg !134, !tbaa !135
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %55, i64 2, !dbg !134
  %56 = load half, ptr addrspace(3) %gep691.3.2, align 2, !dbg !134, !tbaa !135
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %56, i64 3, !dbg !134
  %57 = load half, ptr addrspace(3) %gep691.3739, align 2, !dbg !134, !tbaa !135
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %57, i64 0, !dbg !134
  %58 = load half, ptr addrspace(3) %gep691.1.3, align 2, !dbg !134, !tbaa !135
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %58, i64 1, !dbg !134
  %59 = load half, ptr addrspace(3) %gep691.2.3, align 2, !dbg !134, !tbaa !135
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %59, i64 2, !dbg !134
  %60 = load half, ptr addrspace(3) %gep691.3.3, align 2, !dbg !134, !tbaa !135
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %60, i64 3, !dbg !134
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.1, <4 x float> %acc_o.sroa.0.0), !dbg !136
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.1, <4 x float> %acc_o.sroa.20.0), !dbg !136
  %63 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.1, <4 x float> %acc_o.sroa.38.0), !dbg !136
  %64 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.1, <4 x float> %acc_o.sroa.56.0), !dbg !136
  br label %if.end411, !dbg !137

if.end411:                                        ; preds = %for.cond355.preheader.preheader, %if.end346
  %acc_o.sroa.0.1 = phi <4 x float> [ %61, %for.cond355.preheader.preheader ], [ %acc_o.sroa.0.0, %if.end346 ], !dbg !54
  %acc_o.sroa.20.1 = phi <4 x float> [ %62, %for.cond355.preheader.preheader ], [ %acc_o.sroa.20.0, %if.end346 ], !dbg !54
  %acc_o.sroa.38.1 = phi <4 x float> [ %63, %for.cond355.preheader.preheader ], [ %acc_o.sroa.38.0, %if.end346 ], !dbg !54
  %acc_o.sroa.56.1 = phi <4 x float> [ %64, %for.cond355.preheader.preheader ], [ %acc_o.sroa.56.0, %if.end346 ], !dbg !54
  %inc413 = or disjoint i32 %s.0696, 1, !dbg !137
  %arrayidx62.1 = getelementptr inbounds [4 x i32], ptr addrspace(5) %indices, i32 0, i32 %inc413, !dbg !55
  %65 = load i32, ptr addrspace(5) %arrayidx62.1, align 4, !dbg !55, !tbaa !30
  %or.cond702.1 = icmp ult i32 %65, 37, !dbg !56
  br i1 %or.cond702.1, label %for.cond67.preheader.1, label %if.end231.1, !dbg !56

for.cond67.preheader.1:                           ; preds = %if.end411
  %add74.1 = add nuw nsw i32 %65, %shr73
  %mul83.1 = shl nuw nsw i32 %65, 7
  %add87.1 = add nuw nsw i32 %add84, %mul83.1
  %66 = zext nneg i32 %add87.1 to i64, !dbg !57
  %cmp76.1881 = icmp slt i32 %add74.1, 37, !dbg !58
  br i1 %cmp76.1881, label %if.then77.1890, label %if.end115.1895, !dbg !59

if.then77.1890:                                   ; preds = %for.cond67.preheader.1
  %add.ptr93.1882 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %66, !dbg !60
  %condval_1.sroa.0.0.copyload.1883 = load i32, ptr addrspace(4) %add.ptr93.1882, align 16, !dbg !61, !tbaa !30
  %condval_1.sroa.5.0.add.ptr93.sroa_idx.1884 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr93.1882, i64 4, !dbg !61
  %condval_1.sroa.5.0.copyload.1885 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr93.sroa_idx.1884, align 4, !dbg !61, !tbaa !30
  %condval_1.sroa.6.0.add.ptr93.sroa_idx.1886 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr93.1882, i64 8, !dbg !61
  %condval_1.sroa.6.0.copyload.1887 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr93.sroa_idx.1886, align 8, !dbg !61, !tbaa !30
  %condval_1.sroa.7.0.add.ptr93.sroa_idx.1888 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr93.1882, i64 12, !dbg !61
  %condval_1.sroa.7.0.copyload.1889 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr93.sroa_idx.1888, align 4, !dbg !61, !tbaa !30
  br label %if.end115.1895, !dbg !62

if.end115.1895:                                   ; preds = %if.then77.1890, %for.cond67.preheader.1
  %condval_1.sroa.0.0.1891 = phi i32 [ %condval_1.sroa.0.0.copyload.1883, %if.then77.1890 ], [ 0, %for.cond67.preheader.1 ], !dbg !54
  %condval_1.sroa.5.0.1892 = phi i32 [ %condval_1.sroa.5.0.copyload.1885, %if.then77.1890 ], [ 0, %for.cond67.preheader.1 ], !dbg !54
  %condval_1.sroa.6.0.1893 = phi i32 [ %condval_1.sroa.6.0.copyload.1887, %if.then77.1890 ], [ 0, %for.cond67.preheader.1 ], !dbg !54
  %condval_1.sroa.7.0.1894 = phi i32 [ %condval_1.sroa.7.0.copyload.1889, %if.then77.1890 ], [ 0, %for.cond67.preheader.1 ], !dbg !54
  %cmp76.1.1 = icmp slt i32 %add74.1, 29, !dbg !58
  br i1 %cmp76.1.1, label %if.then77.1.1, label %if.end115.1.1, !dbg !59

if.then77.1.1:                                    ; preds = %if.end115.1895
  %67 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %66, !dbg !60
  %add.ptr93.1.1 = getelementptr inbounds i8, ptr addrspace(4) %67, i64 2048, !dbg !60
  %condval_1.sroa.0.0.copyload.1.1 = load i32, ptr addrspace(4) %add.ptr93.1.1, align 16, !dbg !61, !tbaa !30
  %condval_1.sroa.5.0.add.ptr93.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %67, i64 2052, !dbg !61
  %condval_1.sroa.5.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_1.sroa.5.0.add.ptr93.sroa_idx.1.1, align 4, !dbg !61, !tbaa !30
  %condval_1.sroa.6.0.add.ptr93.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %67, i64 2056, !dbg !61
  %condval_1.sroa.6.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_1.sroa.6.0.add.ptr93.sroa_idx.1.1, align 8, !dbg !61, !tbaa !30
  %condval_1.sroa.7.0.add.ptr93.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %67, i64 2060, !dbg !61
  %condval_1.sroa.7.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_1.sroa.7.0.add.ptr93.sroa_idx.1.1, align 4, !dbg !61, !tbaa !30
  br label %if.end115.1.1, !dbg !62

if.end115.1.1:                                    ; preds = %if.then77.1.1, %if.end115.1895
  %condval_1.sroa.0.0.1.1 = phi i32 [ %condval_1.sroa.0.0.copyload.1.1, %if.then77.1.1 ], [ 0, %if.end115.1895 ], !dbg !54
  %condval_1.sroa.5.0.1.1 = phi i32 [ %condval_1.sroa.5.0.copyload.1.1, %if.then77.1.1 ], [ 0, %if.end115.1895 ], !dbg !54
  %condval_1.sroa.6.0.1.1 = phi i32 [ %condval_1.sroa.6.0.copyload.1.1, %if.then77.1.1 ], [ 0, %if.end115.1895 ], !dbg !54
  %condval_1.sroa.7.0.1.1 = phi i32 [ %condval_1.sroa.7.0.copyload.1.1, %if.then77.1.1 ], [ 0, %if.end115.1895 ], !dbg !54
  br i1 %cmp76.1881, label %if.then133.1904, label %if.end173.1909, !dbg !63

if.then133.1904:                                  ; preds = %if.end115.1.1
  %add.ptr149.1896 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %66, !dbg !64
  %condval_2.sroa.0.0.copyload.1897 = load i32, ptr addrspace(4) %add.ptr149.1896, align 16, !dbg !65, !tbaa !30
  %condval_2.sroa.5.0.add.ptr149.sroa_idx.1898 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr149.1896, i64 4, !dbg !65
  %condval_2.sroa.5.0.copyload.1899 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr149.sroa_idx.1898, align 4, !dbg !65, !tbaa !30
  %condval_2.sroa.6.0.add.ptr149.sroa_idx.1900 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr149.1896, i64 8, !dbg !65
  %condval_2.sroa.6.0.copyload.1901 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr149.sroa_idx.1900, align 8, !dbg !65, !tbaa !30
  %condval_2.sroa.7.0.add.ptr149.sroa_idx.1902 = getelementptr inbounds i8, ptr addrspace(4) %add.ptr149.1896, i64 12, !dbg !65
  %condval_2.sroa.7.0.copyload.1903 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr149.sroa_idx.1902, align 4, !dbg !65, !tbaa !30
  br label %if.end173.1909, !dbg !66

if.end173.1909:                                   ; preds = %if.then133.1904, %if.end115.1.1
  %condval_2.sroa.0.0.1905 = phi i32 [ %condval_2.sroa.0.0.copyload.1897, %if.then133.1904 ], [ 0, %if.end115.1.1 ], !dbg !54
  %condval_2.sroa.5.0.1906 = phi i32 [ %condval_2.sroa.5.0.copyload.1899, %if.then133.1904 ], [ 0, %if.end115.1.1 ], !dbg !54
  %condval_2.sroa.6.0.1907 = phi i32 [ %condval_2.sroa.6.0.copyload.1901, %if.then133.1904 ], [ 0, %if.end115.1.1 ], !dbg !54
  %condval_2.sroa.7.0.1908 = phi i32 [ %condval_2.sroa.7.0.copyload.1903, %if.then133.1904 ], [ 0, %if.end115.1.1 ], !dbg !54
  br i1 %cmp76.1.1, label %if.then133.1.1, label %if.end173.1.1, !dbg !63

if.then133.1.1:                                   ; preds = %if.end173.1909
  %68 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %66, !dbg !64
  %add.ptr149.1.1 = getelementptr inbounds i8, ptr addrspace(4) %68, i64 2048, !dbg !64
  %condval_2.sroa.0.0.copyload.1.1 = load i32, ptr addrspace(4) %add.ptr149.1.1, align 16, !dbg !65, !tbaa !30
  %condval_2.sroa.5.0.add.ptr149.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %68, i64 2052, !dbg !65
  %condval_2.sroa.5.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_2.sroa.5.0.add.ptr149.sroa_idx.1.1, align 4, !dbg !65, !tbaa !30
  %condval_2.sroa.6.0.add.ptr149.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %68, i64 2056, !dbg !65
  %condval_2.sroa.6.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_2.sroa.6.0.add.ptr149.sroa_idx.1.1, align 8, !dbg !65, !tbaa !30
  %condval_2.sroa.7.0.add.ptr149.sroa_idx.1.1 = getelementptr inbounds i8, ptr addrspace(4) %68, i64 2060, !dbg !65
  %condval_2.sroa.7.0.copyload.1.1 = load i32, ptr addrspace(4) %condval_2.sroa.7.0.add.ptr149.sroa_idx.1.1, align 4, !dbg !65, !tbaa !30
  br label %if.end173.1.1, !dbg !66

if.end173.1.1:                                    ; preds = %if.then133.1.1, %if.end173.1909
  %condval_2.sroa.0.0.1.1 = phi i32 [ %condval_2.sroa.0.0.copyload.1.1, %if.then133.1.1 ], [ 0, %if.end173.1909 ], !dbg !54
  %condval_2.sroa.5.0.1.1 = phi i32 [ %condval_2.sroa.5.0.copyload.1.1, %if.then133.1.1 ], [ 0, %if.end173.1909 ], !dbg !54
  %condval_2.sroa.6.0.1.1 = phi i32 [ %condval_2.sroa.6.0.copyload.1.1, %if.then133.1.1 ], [ 0, %if.end173.1909 ], !dbg !54
  %condval_2.sroa.7.0.1.1 = phi i32 [ %condval_2.sroa.7.0.copyload.1.1, %if.then133.1.1 ], [ 0, %if.end173.1909 ], !dbg !54
  store i32 %condval_1.sroa.0.0.1891, ptr addrspace(3) %invariant.gep675, align 16, !dbg !67, !tbaa !30
  store i32 %condval_1.sroa.5.0.1892, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep675.sroa_idx, align 4, !dbg !67, !tbaa !30
  store i32 %condval_1.sroa.6.0.1893, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep675.sroa_idx, align 8, !dbg !67, !tbaa !30
  store i32 %condval_1.sroa.7.0.1894, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep675.sroa_idx, align 4, !dbg !67, !tbaa !30
  store i32 %condval_1.sroa.0.0.1.1, ptr addrspace(3) %gep676.1, align 16, !dbg !67, !tbaa !30
  store i32 %condval_1.sroa.5.0.1.1, ptr addrspace(3) %K_reg.sroa.9.16.gep676.1.sroa_idx, align 4, !dbg !67, !tbaa !30
  store i32 %condval_1.sroa.6.0.1.1, ptr addrspace(3) %K_reg.sroa.10.16.gep676.1.sroa_idx, align 8, !dbg !67, !tbaa !30
  store i32 %condval_1.sroa.7.0.1.1, ptr addrspace(3) %K_reg.sroa.11.16.gep676.1.sroa_idx, align 4, !dbg !67, !tbaa !30
  %cmp205.1 = icmp sgt i32 %65, 21, !dbg !68
  br i1 %cmp205.1, label %for.cond207.preheader.1, label %if.end231.1, !dbg !69

for.cond207.preheader.1:                          ; preds = %if.end173.1.1
  %add214.1 = add nuw nsw i32 %65, %mul213
  %cmp216.1910 = icmp slt i32 %add214.1, 37, !dbg !70
  %.fneg.1911 = select i1 %cmp216.1910, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.0.vec.insert759.1 = insertelement <4 x float> poison, float %.fneg.1911, i64 0, !dbg !71
  %cmp216.1.1 = icmp slt i32 %add214.1, 36, !dbg !70
  %.fneg.1.1 = select i1 %cmp216.1.1, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert768.1 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert759.1, float %.fneg.1.1, i64 1, !dbg !71
  %cmp216.2.1 = icmp slt i32 %add214.1, 35, !dbg !70
  %.fneg.2.1 = select i1 %cmp216.2.1, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.8.vec.insert777.1 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert768.1, float %.fneg.2.1, i64 2, !dbg !71
  %cmp216.3.1 = icmp slt i32 %add214.1, 34, !dbg !70
  %.fneg.3.1 = select i1 %cmp216.3.1, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.12.vec.insert786.1 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert777.1, float %.fneg.3.1, i64 3, !dbg !71
  br label %if.end231.1, !dbg !72

if.end231.1:                                      ; preds = %for.cond207.preheader.1, %if.end173.1.1, %if.end411
  %V_reg.sroa.11.1.1 = phi i32 [ %condval_2.sroa.7.0.1.1, %for.cond207.preheader.1 ], [ %V_reg.sroa.11.1, %if.end411 ], [ %condval_2.sroa.7.0.1.1, %if.end173.1.1 ]
  %V_reg.sroa.10.1.1 = phi i32 [ %condval_2.sroa.6.0.1.1, %for.cond207.preheader.1 ], [ %V_reg.sroa.10.1, %if.end411 ], [ %condval_2.sroa.6.0.1.1, %if.end173.1.1 ]
  %V_reg.sroa.9.1.1 = phi i32 [ %condval_2.sroa.5.0.1.1, %for.cond207.preheader.1 ], [ %V_reg.sroa.9.1, %if.end411 ], [ %condval_2.sroa.5.0.1.1, %if.end173.1.1 ]
  %V_reg.sroa.7.1.1 = phi i32 [ %condval_2.sroa.0.0.1.1, %for.cond207.preheader.1 ], [ %V_reg.sroa.7.1, %if.end411 ], [ %condval_2.sroa.0.0.1.1, %if.end173.1.1 ]
  %V_reg.sroa.6.1.1 = phi i32 [ %condval_2.sroa.7.0.1908, %for.cond207.preheader.1 ], [ %V_reg.sroa.6.1, %if.end411 ], [ %condval_2.sroa.7.0.1908, %if.end173.1.1 ]
  %V_reg.sroa.5.1.1 = phi i32 [ %condval_2.sroa.6.0.1907, %for.cond207.preheader.1 ], [ %V_reg.sroa.5.1, %if.end411 ], [ %condval_2.sroa.6.0.1907, %if.end173.1.1 ]
  %V_reg.sroa.4.1.1 = phi i32 [ %condval_2.sroa.5.0.1906, %for.cond207.preheader.1 ], [ %V_reg.sroa.4.1, %if.end411 ], [ %condval_2.sroa.5.0.1906, %if.end173.1.1 ]
  %V_reg.sroa.0.1.1 = phi i32 [ %condval_2.sroa.0.0.1905, %for.cond207.preheader.1 ], [ %V_reg.sroa.0.1, %if.end411 ], [ %condval_2.sroa.0.0.1905, %if.end173.1.1 ]
  %acc_s.sroa.0.1.1 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert786.1, %for.cond207.preheader.1 ], [ %acc_s.sroa.0.2, %if.end411 ], [ zeroinitializer, %if.end173.1.1 ]
  fence syncscope("block") release, !dbg !72
  tail call void @llvm.mxc.barrier(), !dbg !78
  fence syncscope("block") acquire, !dbg !79
  br i1 %or.cond702.1, label %for.cond236.preheader.1, label %if.end346.1, !dbg !80

for.cond236.preheader.1:                          ; preds = %if.end231.1
  %kb.sroa.0.0.copyload.1 = load <4 x half>, ptr addrspace(3) %add.ptr253, align 16, !dbg !81
  %kb.sroa.6.0.copyload.1 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr253.sroa_idx, align 8, !dbg !81
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.1.1), !dbg !82, !call_argsrelate !83
  %70 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload.1, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %69), !dbg !82, !call_argsrelate !83
  %kb.sroa.0.0.copyload753.1 = load <4 x half>, ptr addrspace(3) %add.ptr253.1, align 16, !dbg !81
  %kb.sroa.6.0.copyload754.1 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr253.1.sroa_idx, align 8, !dbg !81
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload753.1, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %70), !dbg !82, !call_argsrelate !83
  %72 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload754.1, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %71), !dbg !82, !call_argsrelate !83
  store i32 %V_reg.sroa.0.1.1, ptr addrspace(3) %invariant.gep687, align 16, !dbg !84, !tbaa !30
  store i32 %V_reg.sroa.4.1.1, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep687.sroa_idx, align 4, !dbg !84, !tbaa !30
  store i32 %V_reg.sroa.5.1.1, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep687.sroa_idx, align 8, !dbg !84, !tbaa !30
  store i32 %V_reg.sroa.6.1.1, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep687.sroa_idx, align 4, !dbg !84, !tbaa !30
  store i32 %V_reg.sroa.7.1.1, ptr addrspace(3) %gep.1, align 16, !dbg !84, !tbaa !30
  store i32 %V_reg.sroa.9.1.1, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !dbg !84, !tbaa !30
  store i32 %V_reg.sroa.10.1.1, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !dbg !84, !tbaa !30
  store i32 %V_reg.sroa.11.1.1, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !dbg !84, !tbaa !30
  %acc_s.sroa.0.0.vec.extract761.1 = extractelement <4 x float> %72, i64 0, !dbg !85
  %mul310.1912 = fmul contract float %acc_s.sroa.0.0.vec.extract761.1, 0x3FC2776C60000000, !dbg !86
  %73 = tail call contract noundef float @llvm.minnum.f32(float %mul310.1912, float 1.500000e+01), !dbg !87
  %cmp.i.i.1913 = fcmp contract olt float %73, -1.260000e+02, !dbg !91
  %cond.i.i.1914 = select contract i1 %cmp.i.i.1913, float 6.400000e+01, float 0.000000e+00, !dbg !91
  %add.i.i636.1915 = fadd contract float %73, %cond.i.i.1914, !dbg !91
  %74 = tail call contract float @llvm.exp2.f32(float %add.i.i636.1915), !dbg !91
  %cond2.i.i.1916 = select contract i1 %cmp.i.i.1913, float 0x3BF0000000000000, float 1.000000e+00, !dbg !91
  %mul.i.i.1917 = fmul contract float %cond2.i.i.1916, %74, !dbg !91
  %acc_s.sroa.0.0.vec.insert763.1 = insertelement <4 x float> poison, float %mul.i.i.1917, i64 0, !dbg !94
  %acc_s.sroa.0.4.vec.extract770.1 = extractelement <4 x float> %72, i64 1, !dbg !85
  %mul310.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract770.1, 0x3FC2776C60000000, !dbg !86
  %75 = tail call contract noundef float @llvm.minnum.f32(float %mul310.1.1, float 1.500000e+01), !dbg !87
  %cmp.i.i.1.1 = fcmp contract olt float %75, -1.260000e+02, !dbg !91
  %cond.i.i.1.1 = select contract i1 %cmp.i.i.1.1, float 6.400000e+01, float 0.000000e+00, !dbg !91
  %add.i.i636.1.1 = fadd contract float %75, %cond.i.i.1.1, !dbg !91
  %76 = tail call contract float @llvm.exp2.f32(float %add.i.i636.1.1), !dbg !91
  %cond2.i.i.1.1 = select contract i1 %cmp.i.i.1.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !91
  %mul.i.i.1.1 = fmul contract float %cond2.i.i.1.1, %76, !dbg !91
  %acc_s.sroa.0.4.vec.insert772.1 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert763.1, float %mul.i.i.1.1, i64 1, !dbg !94
  %acc_s.sroa.0.8.vec.extract779.1 = extractelement <4 x float> %72, i64 2, !dbg !85
  %mul310.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract779.1, 0x3FC2776C60000000, !dbg !86
  %77 = tail call contract noundef float @llvm.minnum.f32(float %mul310.2.1, float 1.500000e+01), !dbg !87
  %cmp.i.i.2.1 = fcmp contract olt float %77, -1.260000e+02, !dbg !91
  %cond.i.i.2.1 = select contract i1 %cmp.i.i.2.1, float 6.400000e+01, float 0.000000e+00, !dbg !91
  %add.i.i636.2.1 = fadd contract float %77, %cond.i.i.2.1, !dbg !91
  %78 = tail call contract float @llvm.exp2.f32(float %add.i.i636.2.1), !dbg !91
  %cond2.i.i.2.1 = select contract i1 %cmp.i.i.2.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !91
  %mul.i.i.2.1 = fmul contract float %cond2.i.i.2.1, %78, !dbg !91
  %acc_s.sroa.0.8.vec.insert781.1 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert772.1, float %mul.i.i.2.1, i64 2, !dbg !94
  %acc_s.sroa.0.12.vec.extract788.1 = extractelement <4 x float> %72, i64 3, !dbg !85
  %mul310.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract788.1, 0x3FC2776C60000000, !dbg !86
  %79 = tail call contract noundef float @llvm.minnum.f32(float %mul310.3.1, float 1.500000e+01), !dbg !87
  %cmp.i.i.3.1 = fcmp contract olt float %79, -1.260000e+02, !dbg !91
  %cond.i.i.3.1 = select contract i1 %cmp.i.i.3.1, float 6.400000e+01, float 0.000000e+00, !dbg !91
  %add.i.i636.3.1 = fadd contract float %79, %cond.i.i.3.1, !dbg !91
  %80 = tail call contract float @llvm.exp2.f32(float %add.i.i636.3.1), !dbg !91
  %cond2.i.i.3.1 = select contract i1 %cmp.i.i.3.1, float 0x3BF0000000000000, float 1.000000e+00, !dbg !91
  %mul.i.i.3.1 = fmul contract float %cond2.i.i.3.1, %80, !dbg !91
  %acc_s.sroa.0.12.vec.insert790.1 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert781.1, float %mul.i.i.3.1, i64 3, !dbg !94
  %add326.1918 = fadd contract float %sum_acc.sroa.0.1, %mul.i.i.1917, !dbg !95
  %add326.1.1 = fadd contract float %sum_acc.sroa.6.1, %mul.i.i.1.1, !dbg !95
  %add326.2.1 = fadd contract float %sum_acc.sroa.10.1, %mul.i.i.2.1, !dbg !95
  %add326.3.1 = fadd contract float %sum_acc.sroa.14.1, %mul.i.i.3.1, !dbg !95
  %81 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !96
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !96, !noalias !104
  %82 = fptrunc float %mul.i.i.1917 to half, !dbg !96
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %81), !dbg !96, !noalias !104
  %83 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !109
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !109, !noalias !104
  %84 = fptrunc float %mul.i.i.1.1 to half, !dbg !109
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %83), !dbg !109, !noalias !104
  %__1.sroa.0.0.vec.insert.1 = insertelement <4 x half> poison, half %82, i64 0, !dbg !111
  %__1.sroa.0.2.vec.insert.1 = insertelement <4 x half> %__1.sroa.0.0.vec.insert.1, half %84, i64 1, !dbg !111
  %85 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !114
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !114, !noalias !118
  %86 = fptrunc float %mul.i.i.2.1 to half, !dbg !114
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %85), !dbg !114, !noalias !118
  %87 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !123
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !123, !noalias !118
  %88 = fptrunc float %mul.i.i.3.1 to half, !dbg !123
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %87), !dbg !123, !noalias !118
  %__1.sroa.0.4.vec.insert.1 = insertelement <4 x half> %__1.sroa.0.2.vec.insert.1, half %86, i64 2, !dbg !125
  %__1.sroa.0.6.vec.insert.1 = insertelement <4 x half> %__1.sroa.0.4.vec.insert.1, half %88, i64 3, !dbg !125
  br label %if.end346.1, !dbg !127

if.end346.1:                                      ; preds = %for.cond236.preheader.1, %if.end231.1
  %sum_acc.sroa.0.1.1 = phi float [ %add326.1918, %for.cond236.preheader.1 ], [ %sum_acc.sroa.0.1, %if.end231.1 ], !dbg !54
  %sum_acc.sroa.6.1.1 = phi float [ %add326.1.1, %for.cond236.preheader.1 ], [ %sum_acc.sroa.6.1, %if.end231.1 ], !dbg !54
  %sum_acc.sroa.10.1.1 = phi float [ %add326.2.1, %for.cond236.preheader.1 ], [ %sum_acc.sroa.10.1, %if.end231.1 ], !dbg !54
  %sum_acc.sroa.14.1.1 = phi float [ %add326.3.1, %for.cond236.preheader.1 ], [ %sum_acc.sroa.14.1, %if.end231.1 ], !dbg !54
  %acc_s.sroa.0.2.1 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert790.1, %for.cond236.preheader.1 ], [ %acc_s.sroa.0.1.1, %if.end231.1 ], !dbg !54
  %acc_s_cast.sroa.0.1.1 = phi <4 x half> [ %__1.sroa.0.6.vec.insert.1, %for.cond236.preheader.1 ], [ %acc_s_cast.sroa.0.1, %if.end231.1 ]
  fence syncscope("block") release, !dbg !128
  tail call void @llvm.mxc.barrier(), !dbg !131
  fence syncscope("block") acquire, !dbg !132
  br i1 %or.cond702.1, label %for.cond355.preheader.preheader.1, label %if.end411.1, !dbg !133

for.cond355.preheader.preheader.1:                ; preds = %if.end346.1
  %89 = load half, ptr addrspace(3) %gep691, align 2, !dbg !134, !tbaa !135
  %vb.sroa.0.0.vec.insert.1 = insertelement <4 x half> poison, half %89, i64 0, !dbg !134
  %90 = load half, ptr addrspace(3) %gep691.1, align 2, !dbg !134, !tbaa !135
  %vb.sroa.0.2.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.0.vec.insert.1, half %90, i64 1, !dbg !134
  %91 = load half, ptr addrspace(3) %gep691.2, align 2, !dbg !134, !tbaa !135
  %vb.sroa.0.4.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.2.vec.insert.1, half %91, i64 2, !dbg !134
  %92 = load half, ptr addrspace(3) %gep691.3, align 2, !dbg !134, !tbaa !135
  %vb.sroa.0.6.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.4.vec.insert.1, half %92, i64 3, !dbg !134
  %93 = load half, ptr addrspace(3) %gep691.1727, align 2, !dbg !134, !tbaa !135
  %vb.sroa.7.8.vec.insert.1 = insertelement <4 x half> poison, half %93, i64 0, !dbg !134
  %94 = load half, ptr addrspace(3) %gep691.1.1, align 2, !dbg !134, !tbaa !135
  %vb.sroa.7.10.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.8.vec.insert.1, half %94, i64 1, !dbg !134
  %95 = load half, ptr addrspace(3) %gep691.2.1, align 2, !dbg !134, !tbaa !135
  %vb.sroa.7.12.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.10.vec.insert.1, half %95, i64 2, !dbg !134
  %96 = load half, ptr addrspace(3) %gep691.3.1, align 2, !dbg !134, !tbaa !135
  %vb.sroa.7.14.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.12.vec.insert.1, half %96, i64 3, !dbg !134
  %97 = load half, ptr addrspace(3) %gep691.2733, align 2, !dbg !134, !tbaa !135
  %vb.sroa.12.16.vec.insert.1 = insertelement <4 x half> poison, half %97, i64 0, !dbg !134
  %98 = load half, ptr addrspace(3) %gep691.1.2, align 2, !dbg !134, !tbaa !135
  %vb.sroa.12.18.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.16.vec.insert.1, half %98, i64 1, !dbg !134
  %99 = load half, ptr addrspace(3) %gep691.2.2, align 2, !dbg !134, !tbaa !135
  %vb.sroa.12.20.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.18.vec.insert.1, half %99, i64 2, !dbg !134
  %100 = load half, ptr addrspace(3) %gep691.3.2, align 2, !dbg !134, !tbaa !135
  %vb.sroa.12.22.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.20.vec.insert.1, half %100, i64 3, !dbg !134
  %101 = load half, ptr addrspace(3) %gep691.3739, align 2, !dbg !134, !tbaa !135
  %vb.sroa.17.24.vec.insert.1 = insertelement <4 x half> poison, half %101, i64 0, !dbg !134
  %102 = load half, ptr addrspace(3) %gep691.1.3, align 2, !dbg !134, !tbaa !135
  %vb.sroa.17.26.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.24.vec.insert.1, half %102, i64 1, !dbg !134
  %103 = load half, ptr addrspace(3) %gep691.2.3, align 2, !dbg !134, !tbaa !135
  %vb.sroa.17.28.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.26.vec.insert.1, half %103, i64 2, !dbg !134
  %104 = load half, ptr addrspace(3) %gep691.3.3, align 2, !dbg !134, !tbaa !135
  %vb.sroa.17.30.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.28.vec.insert.1, half %104, i64 3, !dbg !134
  %105 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert.1, <4 x half> %acc_s_cast.sroa.0.1.1, <4 x float> %acc_o.sroa.0.1), !dbg !136
  %106 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert.1, <4 x half> %acc_s_cast.sroa.0.1.1, <4 x float> %acc_o.sroa.20.1), !dbg !136
  %107 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert.1, <4 x half> %acc_s_cast.sroa.0.1.1, <4 x float> %acc_o.sroa.38.1), !dbg !136
  %108 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert.1, <4 x half> %acc_s_cast.sroa.0.1.1, <4 x float> %acc_o.sroa.56.1), !dbg !136
  br label %if.end411.1, !dbg !137

if.end411.1:                                      ; preds = %for.cond355.preheader.preheader.1, %if.end346.1
  %acc_o.sroa.0.1.1 = phi <4 x float> [ %105, %for.cond355.preheader.preheader.1 ], [ %acc_o.sroa.0.1, %if.end346.1 ], !dbg !54
  %acc_o.sroa.20.1.1 = phi <4 x float> [ %106, %for.cond355.preheader.preheader.1 ], [ %acc_o.sroa.20.1, %if.end346.1 ], !dbg !54
  %acc_o.sroa.38.1.1 = phi <4 x float> [ %107, %for.cond355.preheader.preheader.1 ], [ %acc_o.sroa.38.1, %if.end346.1 ], !dbg !54
  %acc_o.sroa.56.1.1 = phi <4 x float> [ %108, %for.cond355.preheader.preheader.1 ], [ %acc_o.sroa.56.1, %if.end346.1 ], !dbg !54
  %inc413.1 = add nuw nsw i32 %s.0696, 2, !dbg !137
  %exitcond.not.1 = icmp eq i32 %inc413.1, 4, !dbg !138
  br i1 %exitcond.not.1, label %for.body419.preheader, label %for.body60, !dbg !53, !llvm.loop !139

for.body419.preheader:                            ; preds = %if.end411.1
  %add423 = fadd contract float %sum_acc.sroa.0.1.1, 0.000000e+00, !dbg !142
  %add423.1 = fadd contract float %add423, %sum_acc.sroa.6.1.1, !dbg !142
  %add423.2 = fadd contract float %add423.1, %sum_acc.sroa.10.1.1, !dbg !142
  %add423.3 = fadd contract float %add423.2, %sum_acc.sroa.14.1.1, !dbg !142
  fence syncscope("block") release, !dbg !143
  tail call void @llvm.mxc.barrier(), !dbg !146
  fence syncscope("block") acquire, !dbg !147
  %109 = bitcast float %add423.3 to i32, !dbg !148
  %110 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #12, !dbg !159
  %111 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %110) #12, !dbg !164
  %xor.i.i = xor i32 %111, 32, !dbg !165
  %112 = and i32 %111, -64, !dbg !166
  %and.i.i = add nsw i32 %112, 64, !dbg !166
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !167
  %cond.i.i638 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %111, !dbg !168
  %shl.i.i = shl i32 %cond.i.i638, 2, !dbg !169
  %113 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %109), !dbg !170
  %114 = bitcast i32 %113 to float, !dbg !171
  %add.i = fadd contract float %add423.3, %114, !dbg !172
  %115 = bitcast float %add.i to i32, !dbg !175
  %116 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #12, !dbg !182
  %117 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %116) #12, !dbg !185
  %xor.i.i639 = xor i32 %117, 16, !dbg !186
  %118 = and i32 %117, -64, !dbg !187
  %and.i.i640 = add nsw i32 %118, 64, !dbg !187
  %cmp.not.i.i641 = icmp slt i32 %xor.i.i639, %and.i.i640, !dbg !188
  %cond.i.i642 = select i1 %cmp.not.i.i641, i32 %xor.i.i639, i32 %117, !dbg !189
  %shl.i.i643 = shl i32 %cond.i.i642, 2, !dbg !190
  %119 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i643, i32 %115), !dbg !191
  %120 = bitcast i32 %119 to float, !dbg !192
  %add.i.i = fadd contract float %add.i, %120, !dbg !193
  %cmp432 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !195
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !196
  %condval_4.0 = select i1 %cmp432, float %div, float 0.000000e+00, !dbg !196
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1.1, i64 0, !dbg !197
  %mul445 = fmul contract float %condval_4.0, %acc_o.sroa.0.0.vec.extract, !dbg !198
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1.1, i64 1, !dbg !197
  %mul445.1 = fmul contract float %condval_4.0, %acc_o.sroa.0.4.vec.extract, !dbg !198
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1.1, i64 2, !dbg !197
  %mul445.2 = fmul contract float %condval_4.0, %acc_o.sroa.0.8.vec.extract, !dbg !198
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.1.1, i64 3, !dbg !197
  %mul445.3 = fmul contract float %condval_4.0, %acc_o.sroa.0.12.vec.extract, !dbg !198
  %acc_o.sroa.20.16.vec.extract = extractelement <4 x float> %acc_o.sroa.20.1.1, i64 0, !dbg !197
  %mul445.4 = fmul contract float %condval_4.0, %acc_o.sroa.20.16.vec.extract, !dbg !198
  %acc_o.sroa.20.20.vec.extract = extractelement <4 x float> %acc_o.sroa.20.1.1, i64 1, !dbg !197
  %mul445.5 = fmul contract float %condval_4.0, %acc_o.sroa.20.20.vec.extract, !dbg !198
  %acc_o.sroa.20.24.vec.extract = extractelement <4 x float> %acc_o.sroa.20.1.1, i64 2, !dbg !197
  %mul445.6 = fmul contract float %condval_4.0, %acc_o.sroa.20.24.vec.extract, !dbg !198
  %acc_o.sroa.20.28.vec.extract = extractelement <4 x float> %acc_o.sroa.20.1.1, i64 3, !dbg !197
  %mul445.7 = fmul contract float %condval_4.0, %acc_o.sroa.20.28.vec.extract, !dbg !198
  %acc_o.sroa.38.32.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1.1, i64 0, !dbg !197
  %mul445.8 = fmul contract float %condval_4.0, %acc_o.sroa.38.32.vec.extract, !dbg !198
  %acc_o.sroa.38.36.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1.1, i64 1, !dbg !197
  %mul445.9 = fmul contract float %condval_4.0, %acc_o.sroa.38.36.vec.extract, !dbg !198
  %acc_o.sroa.38.40.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1.1, i64 2, !dbg !197
  %mul445.10 = fmul contract float %condval_4.0, %acc_o.sroa.38.40.vec.extract, !dbg !198
  %acc_o.sroa.38.44.vec.extract = extractelement <4 x float> %acc_o.sroa.38.1.1, i64 3, !dbg !197
  %mul445.11 = fmul contract float %condval_4.0, %acc_o.sroa.38.44.vec.extract, !dbg !198
  %acc_o.sroa.56.48.vec.extract = extractelement <4 x float> %acc_o.sroa.56.1.1, i64 0, !dbg !197
  %mul445.12 = fmul contract float %condval_4.0, %acc_o.sroa.56.48.vec.extract, !dbg !198
  %acc_o.sroa.56.52.vec.extract = extractelement <4 x float> %acc_o.sroa.56.1.1, i64 1, !dbg !197
  %mul445.13 = fmul contract float %condval_4.0, %acc_o.sroa.56.52.vec.extract, !dbg !198
  %acc_o.sroa.56.56.vec.extract = extractelement <4 x float> %acc_o.sroa.56.1.1, i64 2, !dbg !197
  %mul445.14 = fmul contract float %condval_4.0, %acc_o.sroa.56.56.vec.extract, !dbg !198
  %acc_o.sroa.56.60.vec.extract = extractelement <4 x float> %acc_o.sroa.56.1.1, i64 3, !dbg !197
  %mul445.15 = fmul contract float %condval_4.0, %acc_o.sroa.56.60.vec.extract, !dbg !198
  %add483 = add nuw nsw i32 %add26, %mul213
  %121 = zext nneg i32 %add483 to i64, !dbg !199
  %122 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !200
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !200, !noalias !204
  %123 = fptrunc float %mul445 to half, !dbg !200
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %122), !dbg !200, !noalias !204
  %124 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !209
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !209, !noalias !204
  %125 = fptrunc float %mul445.1 to half, !dbg !209
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %124), !dbg !209, !noalias !204
  %126 = bitcast half %123 to i16, !dbg !211
  %127 = bitcast half %125 to i16, !dbg !214
  %128 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !215
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !215, !noalias !219
  %129 = fptrunc float %mul445.2 to half, !dbg !215
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %128), !dbg !215, !noalias !219
  %130 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !224
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !224, !noalias !219
  %131 = fptrunc float %mul445.3 to half, !dbg !224
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %130), !dbg !224, !noalias !219
  %132 = bitcast half %129 to i16, !dbg !226
  %133 = bitcast half %131 to i16, !dbg !228
  %__2.sroa.6.0.insert.ext = zext i16 %133 to i64, !dbg !229
  %__2.sroa.6.0.insert.shift = shl nuw i64 %__2.sroa.6.0.insert.ext, 48, !dbg !229
  %__2.sroa.5.0.insert.ext = zext i16 %132 to i64, !dbg !229
  %__2.sroa.5.0.insert.shift = shl nuw nsw i64 %__2.sroa.5.0.insert.ext, 32, !dbg !229
  %__2.sroa.5.0.insert.insert = or disjoint i64 %__2.sroa.6.0.insert.shift, %__2.sroa.5.0.insert.shift, !dbg !229
  %__2.sroa.4.0.insert.ext = zext i16 %127 to i64, !dbg !229
  %__2.sroa.4.0.insert.shift = shl nuw nsw i64 %__2.sroa.4.0.insert.ext, 16, !dbg !229
  %__2.sroa.4.0.insert.insert = or disjoint i64 %__2.sroa.5.0.insert.insert, %__2.sroa.4.0.insert.shift, !dbg !229
  %__2.sroa.0.0.insert.ext = zext i16 %126 to i64, !dbg !229
  %__2.sroa.0.0.insert.insert = or disjoint i64 %__2.sroa.4.0.insert.insert, %__2.sroa.0.0.insert.ext, !dbg !229
  %add.ptr489 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %121, !dbg !230
  store i64 %__2.sroa.0.0.insert.insert, ptr addrspace(1) %add.ptr489, align 8, !dbg !231
  %134 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !200
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !200, !noalias !204
  %135 = fptrunc float %mul445.4 to half, !dbg !200
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %134), !dbg !200, !noalias !204
  %136 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !209
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !209, !noalias !204
  %137 = fptrunc float %mul445.5 to half, !dbg !209
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %136), !dbg !209, !noalias !204
  %138 = bitcast half %135 to i16, !dbg !211
  %139 = bitcast half %137 to i16, !dbg !214
  %140 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !215
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !215, !noalias !219
  %141 = fptrunc float %mul445.6 to half, !dbg !215
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %140), !dbg !215, !noalias !219
  %142 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !224
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !224, !noalias !219
  %143 = fptrunc float %mul445.7 to half, !dbg !224
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %142), !dbg !224, !noalias !219
  %144 = bitcast half %141 to i16, !dbg !226
  %145 = bitcast half %143 to i16, !dbg !228
  %__2.sroa.6.0.insert.ext.1 = zext i16 %145 to i64, !dbg !229
  %__2.sroa.6.0.insert.shift.1 = shl nuw i64 %__2.sroa.6.0.insert.ext.1, 48, !dbg !229
  %__2.sroa.5.0.insert.ext.1 = zext i16 %144 to i64, !dbg !229
  %__2.sroa.5.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.1, 32, !dbg !229
  %__2.sroa.5.0.insert.insert.1 = or disjoint i64 %__2.sroa.6.0.insert.shift.1, %__2.sroa.5.0.insert.shift.1, !dbg !229
  %__2.sroa.4.0.insert.ext.1 = zext i16 %139 to i64, !dbg !229
  %__2.sroa.4.0.insert.shift.1 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.1, 16, !dbg !229
  %__2.sroa.4.0.insert.insert.1 = or disjoint i64 %__2.sroa.5.0.insert.insert.1, %__2.sroa.4.0.insert.shift.1, !dbg !229
  %__2.sroa.0.0.insert.ext.1 = zext i16 %138 to i64, !dbg !229
  %__2.sroa.0.0.insert.insert.1 = or disjoint i64 %__2.sroa.4.0.insert.insert.1, %__2.sroa.0.0.insert.ext.1, !dbg !229
  %146 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %121, !dbg !230
  %add.ptr489.1 = getelementptr inbounds i8, ptr addrspace(1) %146, i64 32, !dbg !230
  store i64 %__2.sroa.0.0.insert.insert.1, ptr addrspace(1) %add.ptr489.1, align 8, !dbg !231
  %147 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !200
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !200, !noalias !204
  %148 = fptrunc float %mul445.8 to half, !dbg !200
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %147), !dbg !200, !noalias !204
  %149 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !209
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !209, !noalias !204
  %150 = fptrunc float %mul445.9 to half, !dbg !209
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %149), !dbg !209, !noalias !204
  %151 = bitcast half %148 to i16, !dbg !211
  %152 = bitcast half %150 to i16, !dbg !214
  %153 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !215
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !215, !noalias !219
  %154 = fptrunc float %mul445.10 to half, !dbg !215
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %153), !dbg !215, !noalias !219
  %155 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !224
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !224, !noalias !219
  %156 = fptrunc float %mul445.11 to half, !dbg !224
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %155), !dbg !224, !noalias !219
  %157 = bitcast half %154 to i16, !dbg !226
  %158 = bitcast half %156 to i16, !dbg !228
  %__2.sroa.6.0.insert.ext.2 = zext i16 %158 to i64, !dbg !229
  %__2.sroa.6.0.insert.shift.2 = shl nuw i64 %__2.sroa.6.0.insert.ext.2, 48, !dbg !229
  %__2.sroa.5.0.insert.ext.2 = zext i16 %157 to i64, !dbg !229
  %__2.sroa.5.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.2, 32, !dbg !229
  %__2.sroa.5.0.insert.insert.2 = or disjoint i64 %__2.sroa.6.0.insert.shift.2, %__2.sroa.5.0.insert.shift.2, !dbg !229
  %__2.sroa.4.0.insert.ext.2 = zext i16 %152 to i64, !dbg !229
  %__2.sroa.4.0.insert.shift.2 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.2, 16, !dbg !229
  %__2.sroa.4.0.insert.insert.2 = or disjoint i64 %__2.sroa.5.0.insert.insert.2, %__2.sroa.4.0.insert.shift.2, !dbg !229
  %__2.sroa.0.0.insert.ext.2 = zext i16 %151 to i64, !dbg !229
  %__2.sroa.0.0.insert.insert.2 = or disjoint i64 %__2.sroa.4.0.insert.insert.2, %__2.sroa.0.0.insert.ext.2, !dbg !229
  %159 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %121, !dbg !230
  %add.ptr489.2 = getelementptr inbounds i8, ptr addrspace(1) %159, i64 64, !dbg !230
  store i64 %__2.sroa.0.0.insert.insert.2, ptr addrspace(1) %add.ptr489.2, align 8, !dbg !231
  %160 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !200
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !200, !noalias !204
  %161 = fptrunc float %mul445.12 to half, !dbg !200
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %160), !dbg !200, !noalias !204
  %162 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !209
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !209, !noalias !204
  %163 = fptrunc float %mul445.13 to half, !dbg !209
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %162), !dbg !209, !noalias !204
  %164 = bitcast half %161 to i16, !dbg !211
  %165 = bitcast half %163 to i16, !dbg !214
  %166 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !215
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !215, !noalias !219
  %167 = fptrunc float %mul445.14 to half, !dbg !215
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %166), !dbg !215, !noalias !219
  %168 = tail call i32 @llvm.mxc.gethwreg(i32 2177), !dbg !224
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 0), !dbg !224, !noalias !219
  %169 = fptrunc float %mul445.15 to half, !dbg !224
  tail call void @llvm.mxc.sethwreg(i32 2177, i32 %168), !dbg !224, !noalias !219
  %170 = bitcast half %167 to i16, !dbg !226
  %171 = bitcast half %169 to i16, !dbg !228
  %__2.sroa.6.0.insert.ext.3 = zext i16 %171 to i64, !dbg !229
  %__2.sroa.6.0.insert.shift.3 = shl nuw i64 %__2.sroa.6.0.insert.ext.3, 48, !dbg !229
  %__2.sroa.5.0.insert.ext.3 = zext i16 %170 to i64, !dbg !229
  %__2.sroa.5.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.5.0.insert.ext.3, 32, !dbg !229
  %__2.sroa.5.0.insert.insert.3 = or disjoint i64 %__2.sroa.6.0.insert.shift.3, %__2.sroa.5.0.insert.shift.3, !dbg !229
  %__2.sroa.4.0.insert.ext.3 = zext i16 %165 to i64, !dbg !229
  %__2.sroa.4.0.insert.shift.3 = shl nuw nsw i64 %__2.sroa.4.0.insert.ext.3, 16, !dbg !229
  %__2.sroa.4.0.insert.insert.3 = or disjoint i64 %__2.sroa.5.0.insert.insert.3, %__2.sroa.4.0.insert.shift.3, !dbg !229
  %__2.sroa.0.0.insert.ext.3 = zext i16 %164 to i64, !dbg !229
  %__2.sroa.0.0.insert.insert.3 = or disjoint i64 %__2.sroa.4.0.insert.insert.3, %__2.sroa.0.0.insert.ext.3, !dbg !229
  %172 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %121, !dbg !230
  %add.ptr489.3 = getelementptr inbounds i8, ptr addrspace(1) %172, i64 96, !dbg !230
  store i64 %__2.sroa.0.0.insert.insert.3, ptr addrspace(1) %add.ptr489.3, align 8, !dbg !231
  call void @llvm.lifetime.end.p5(i64 16, ptr addrspace(5) %indices) #11, !dbg !232
  ret void, !dbg !232
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p5(i64 immarg, ptr addrspace(5) nocapture) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p5(i64 immarg, ptr addrspace(5) nocapture) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.x() #6

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.y() #6

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.block.id.z() #6

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i32 @llvm.mxc.thread.id.x() #6

; Function Attrs: convergent nounwind willreturn
declare void @llvm.mxc.barrier() #7

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #5

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #5

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #6

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #6

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i1 @llvm.mxc.is.private(ptr nocapture) #6

; Function Attrs: nounwind willreturn
declare void @llvm.mxc.sleep(i32 immarg) #8

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp2.f32(float) #9

; Function Attrs: nounwind speculatable willreturn memory(inaccessiblemem: read)
declare i32 @llvm.mxc.gethwreg(i32 immarg) #10

; Function Attrs: nounwind willreturn
declare void @llvm.mxc.sethwreg(i32 immarg, i32) #8

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.minnum.f32(float, float) #9

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #5 = { convergent nounwind willreturn memory(none) }
attributes #6 = { nounwind speculatable willreturn memory(none) }
attributes #7 = { convergent nounwind willreturn }
attributes #8 = { nounwind willreturn }
attributes #9 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #10 = { nounwind speculatable willreturn memory(inaccessiblemem: read) }
attributes #11 = { nounwind }
attributes #12 = { nomerge }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmpi_6uxjdh/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpi_6uxjdh/tvm_kernels.maca", directory: "")
!42 = !DILocation(line: 12, column: 3, scope: !40)
!43 = !DILocation(line: 26, column: 3, scope: !40)
!44 = !DILocation(line: 27, column: 35, scope: !40)
!45 = !DILocation(line: 34, column: 28, scope: !40)
!46 = !DILocation(line: 34, column: 17, scope: !40)
!47 = !DILocation(line: 27, column: 101, scope: !40)
!48 = !DILocation(line: 34, column: 5, scope: !40)
!49 = !{i32 0, i32 1024}
!50 = !DILocation(line: 37, column: 3, scope: !40)
!51 = !DILocation(line: 38, column: 46, scope: !40)
!52 = !DILocation(line: 38, column: 32, scope: !40)
!53 = !DILocation(line: 49, column: 3, scope: !40)
!54 = !DILocation(line: 0, scope: !40)
!55 = !DILocation(line: 50, column: 15, scope: !40)
!56 = !DILocation(line: 51, column: 20, scope: !40)
!57 = !DILocation(line: 53, column: 7, scope: !40)
!58 = !DILocation(line: 56, column: 62, scope: !40)
!59 = !DILocation(line: 56, column: 13, scope: !40)
!60 = !DILocation(line: 57, column: 35, scope: !40)
!61 = !DILocation(line: 57, column: 21, scope: !40)
!62 = !DILocation(line: 58, column: 9, scope: !40)
!63 = !DILocation(line: 67, column: 13, scope: !40)
!64 = !DILocation(line: 68, column: 35, scope: !40)
!65 = !DILocation(line: 68, column: 21, scope: !40)
!66 = !DILocation(line: 69, column: 9, scope: !40)
!67 = !DILocation(line: 76, column: 161, scope: !40)
!68 = !DILocation(line: 78, column: 14, scope: !40)
!69 = !DILocation(line: 78, column: 11, scope: !40)
!70 = !DILocation(line: 82, column: 64, scope: !40)
!71 = !DILocation(line: 87, column: 22, scope: !40)
!72 = !DILocation(line: 60, column: 3, scope: !73, inlinedAt: !75)
!73 = distinct !DISubprogram(name: "__barrier", scope: !74, file: !74, line: 57, type: !7, scopeLine: 57, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!74 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!75 = distinct !DILocation(line: 74, column: 3, scope: !76, inlinedAt: !77)
!76 = distinct !DISubprogram(name: "__syncthreads", scope: !74, file: !74, line: 73, type: !7, scopeLine: 73, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!77 = distinct !DILocation(line: 94, column: 5, scope: !40)
!78 = !DILocation(line: 61, column: 3, scope: !73, inlinedAt: !75)
!79 = !DILocation(line: 62, column: 3, scope: !73, inlinedAt: !75)
!80 = !DILocation(line: 95, column: 20, scope: !40)
!81 = !DILocation(line: 97, column: 27, scope: !40)
!82 = !DILocation(line: 100, column: 36, scope: !40)
!83 = !{i32 -1, i32 3, i32 -1}
!84 = !DILocation(line: 108, column: 170, scope: !40)
!85 = !DILocation(line: 112, column: 33, scope: !40)
!86 = !DILocation(line: 112, column: 44, scope: !40)
!87 = !DILocation(line: 354, column: 10, scope: !88, inlinedAt: !90)
!88 = distinct !DISubprogram(name: "min", scope: !89, file: !89, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!89 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!90 = distinct !DILocation(line: 112, column: 28, scope: !40)
!91 = !DILocation(line: 285, column: 49, scope: !92, inlinedAt: !93)
!92 = distinct !DISubprogram(name: "exp2f", scope: !89, file: !89, line: 285, type: !7, scopeLine: 285, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!93 = distinct !DILocation(line: 112, column: 22, scope: !40)
!94 = !DILocation(line: 112, column: 20, scope: !40)
!95 = !DILocation(line: 116, column: 38, scope: !40)
!96 = !DILocation(line: 1007, column: 10, scope: !97, inlinedAt: !99)
!97 = distinct !DISubprogram(name: "__float2half_rn", scope: !98, file: !98, line: 1005, type: !7, scopeLine: 1005, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!98 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!99 = distinct !DILocation(line: 1077, column: 18, scope: !100, inlinedAt: !101)
!100 = distinct !DISubprogram(name: "__floats2half2_rn", scope: !98, file: !98, line: 1075, type: !7, scopeLine: 1076, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!101 = distinct !DILocation(line: 1295, column: 23, scope: !102, inlinedAt: !103)
!102 = distinct !DISubprogram(name: "__float22half2_rn", scope: !98, file: !98, line: 1294, type: !7, scopeLine: 1294, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!103 = distinct !DILocation(line: 120, column: 29, scope: !40)
!104 = !{!105, !107}
!105 = distinct !{!105, !106, !"_ZL17__floats2half2_rnff: %agg.result"}
!106 = distinct !{!106, !"_ZL17__floats2half2_rnff"}
!107 = distinct !{!107, !108, !"_ZL17__float22half2_rn6float2: %agg.result"}
!108 = distinct !{!108, !"_ZL17__float22half2_rn6float2"}
!109 = !DILocation(line: 1007, column: 10, scope: !97, inlinedAt: !110)
!110 = distinct !DILocation(line: 1077, column: 38, scope: !100, inlinedAt: !101)
!111 = !DILocation(line: 593, column: 26, scope: !112, inlinedAt: !113)
!112 = distinct !DISubprogram(name: "operator=", scope: !98, file: !98, line: 592, type: !7, scopeLine: 592, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!113 = distinct !DILocation(line: 120, column: 27, scope: !40)
!114 = !DILocation(line: 1007, column: 10, scope: !97, inlinedAt: !115)
!115 = distinct !DILocation(line: 1077, column: 18, scope: !100, inlinedAt: !116)
!116 = distinct !DILocation(line: 1295, column: 23, scope: !102, inlinedAt: !117)
!117 = distinct !DILocation(line: 121, column: 29, scope: !40)
!118 = !{!119, !121}
!119 = distinct !{!119, !120, !"_ZL17__floats2half2_rnff: %agg.result"}
!120 = distinct !{!120, !"_ZL17__floats2half2_rnff"}
!121 = distinct !{!121, !122, !"_ZL17__float22half2_rn6float2: %agg.result"}
!122 = distinct !{!122, !"_ZL17__float22half2_rn6float2"}
!123 = !DILocation(line: 1007, column: 10, scope: !97, inlinedAt: !124)
!124 = distinct !DILocation(line: 1077, column: 38, scope: !100, inlinedAt: !116)
!125 = !DILocation(line: 593, column: 26, scope: !112, inlinedAt: !126)
!126 = distinct !DILocation(line: 121, column: 27, scope: !40)
!127 = !DILocation(line: 123, column: 5, scope: !40)
!128 = !DILocation(line: 60, column: 3, scope: !73, inlinedAt: !129)
!129 = distinct !DILocation(line: 74, column: 3, scope: !76, inlinedAt: !130)
!130 = distinct !DILocation(line: 124, column: 5, scope: !40)
!131 = !DILocation(line: 61, column: 3, scope: !73, inlinedAt: !129)
!132 = !DILocation(line: 62, column: 3, scope: !73, inlinedAt: !129)
!133 = !DILocation(line: 125, column: 20, scope: !40)
!134 = !DILocation(line: 128, column: 36, scope: !40)
!135 = !{!26, !26, i64 0}
!136 = !DILocation(line: 133, column: 38, scope: !40)
!137 = !DILocation(line: 49, column: 26, scope: !40)
!138 = !DILocation(line: 49, column: 21, scope: !40)
!139 = distinct !{!139, !53, !140, !32, !141}
!140 = !DILocation(line: 139, column: 3, scope: !40)
!141 = !{!"llvm.loop.unroll.disable"}
!142 = !DILocation(line: 143, column: 36, scope: !40)
!143 = !DILocation(line: 60, column: 3, scope: !73, inlinedAt: !144)
!144 = distinct !DILocation(line: 74, column: 3, scope: !76, inlinedAt: !145)
!145 = distinct !DILocation(line: 145, column: 3, scope: !40)
!146 = !DILocation(line: 61, column: 3, scope: !73, inlinedAt: !144)
!147 = !DILocation(line: 62, column: 3, scope: !73, inlinedAt: !144)
!148 = !DILocation(line: 1018, column: 9, scope: !149, inlinedAt: !150)
!149 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !74, file: !74, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!150 = distinct !DILocation(line: 396, column: 10, scope: !151, inlinedAt: !153)
!151 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !152, file: !152, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!152 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!153 = distinct !DILocation(line: 129, column: 24, scope: !154, inlinedAt: !156)
!154 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !155, file: !155, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!155 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!156 = distinct !DILocation(line: 101, column: 14, scope: !157, inlinedAt: !158)
!157 = distinct !DISubprogram(name: "run<float>", scope: !155, file: !155, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!158 = distinct !DILocation(line: 146, column: 19, scope: !40)
!159 = !DILocation(line: 171, column: 37, scope: !160, inlinedAt: !161)
!160 = distinct !DISubprogram(name: "__lane_id", scope: !74, file: !74, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!161 = distinct !DILocation(line: 990, column: 14, scope: !162, inlinedAt: !163)
!162 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !74, file: !74, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!163 = distinct !DILocation(line: 1019, column: 11, scope: !149, inlinedAt: !150)
!164 = !DILocation(line: 171, column: 10, scope: !160, inlinedAt: !161)
!165 = !DILocation(line: 991, column: 20, scope: !162, inlinedAt: !163)
!166 = !DILocation(line: 992, column: 36, scope: !162, inlinedAt: !163)
!167 = !DILocation(line: 992, column: 17, scope: !162, inlinedAt: !163)
!168 = !DILocation(line: 992, column: 11, scope: !162, inlinedAt: !163)
!169 = !DILocation(line: 993, column: 43, scope: !162, inlinedAt: !163)
!170 = !DILocation(line: 993, column: 10, scope: !162, inlinedAt: !163)
!171 = !DILocation(line: 1020, column: 14, scope: !149, inlinedAt: !150)
!172 = !DILocation(line: 25, column: 14, scope: !173, inlinedAt: !174)
!173 = distinct !DISubprogram(name: "operator()<float>", scope: !155, file: !155, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!174 = distinct !DILocation(line: 129, column: 11, scope: !154, inlinedAt: !156)
!175 = !DILocation(line: 1018, column: 9, scope: !149, inlinedAt: !176)
!176 = distinct !DILocation(line: 396, column: 10, scope: !151, inlinedAt: !177)
!177 = distinct !DILocation(line: 129, column: 24, scope: !178, inlinedAt: !179)
!178 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !155, file: !155, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!179 = distinct !DILocation(line: 101, column: 14, scope: !180, inlinedAt: !181)
!180 = distinct !DISubprogram(name: "run<float>", scope: !155, file: !155, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!181 = distinct !DILocation(line: 134, column: 14, scope: !154, inlinedAt: !156)
!182 = !DILocation(line: 171, column: 37, scope: !160, inlinedAt: !183)
!183 = distinct !DILocation(line: 990, column: 14, scope: !162, inlinedAt: !184)
!184 = distinct !DILocation(line: 1019, column: 11, scope: !149, inlinedAt: !176)
!185 = !DILocation(line: 171, column: 10, scope: !160, inlinedAt: !183)
!186 = !DILocation(line: 991, column: 20, scope: !162, inlinedAt: !184)
!187 = !DILocation(line: 992, column: 36, scope: !162, inlinedAt: !184)
!188 = !DILocation(line: 992, column: 17, scope: !162, inlinedAt: !184)
!189 = !DILocation(line: 992, column: 11, scope: !162, inlinedAt: !184)
!190 = !DILocation(line: 993, column: 43, scope: !162, inlinedAt: !184)
!191 = !DILocation(line: 993, column: 10, scope: !162, inlinedAt: !184)
!192 = !DILocation(line: 1020, column: 14, scope: !149, inlinedAt: !176)
!193 = !DILocation(line: 25, column: 14, scope: !173, inlinedAt: !194)
!194 = distinct !DILocation(line: 129, column: 11, scope: !178, inlinedAt: !179)
!195 = !DILocation(line: 148, column: 32, scope: !40)
!196 = !DILocation(line: 148, column: 7, scope: !40)
!197 = !DILocation(line: 156, column: 19, scope: !40)
!198 = !DILocation(line: 156, column: 30, scope: !40)
!199 = !DILocation(line: 159, column: 3, scope: !40)
!200 = !DILocation(line: 1007, column: 10, scope: !97, inlinedAt: !201)
!201 = distinct !DILocation(line: 1077, column: 18, scope: !100, inlinedAt: !202)
!202 = distinct !DILocation(line: 1295, column: 23, scope: !102, inlinedAt: !203)
!203 = distinct !DILocation(line: 162, column: 27, scope: !40)
!204 = !{!205, !207}
!205 = distinct !{!205, !206, !"_ZL17__floats2half2_rnff: %agg.result"}
!206 = distinct !{!206, !"_ZL17__floats2half2_rnff"}
!207 = distinct !{!207, !208, !"_ZL17__float22half2_rn6float2: %agg.result"}
!208 = distinct !{!208, !"_ZL17__float22half2_rn6float2"}
!209 = !DILocation(line: 1007, column: 10, scope: !97, inlinedAt: !210)
!210 = distinct !DILocation(line: 1077, column: 38, scope: !100, inlinedAt: !202)
!211 = !DILocation(line: 596, column: 67, scope: !212, inlinedAt: !213)
!212 = distinct !DISubprogram(name: "__half2", scope: !98, file: !98, line: 596, type: !7, scopeLine: 596, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!213 = distinct !DILocation(line: 1077, column: 10, scope: !100, inlinedAt: !202)
!214 = !DILocation(line: 596, column: 73, scope: !212, inlinedAt: !213)
!215 = !DILocation(line: 1007, column: 10, scope: !97, inlinedAt: !216)
!216 = distinct !DILocation(line: 1077, column: 18, scope: !100, inlinedAt: !217)
!217 = distinct !DILocation(line: 1295, column: 23, scope: !102, inlinedAt: !218)
!218 = distinct !DILocation(line: 163, column: 27, scope: !40)
!219 = !{!220, !222}
!220 = distinct !{!220, !221, !"_ZL17__floats2half2_rnff: %agg.result"}
!221 = distinct !{!221, !"_ZL17__floats2half2_rnff"}
!222 = distinct !{!222, !223, !"_ZL17__float22half2_rn6float2: %agg.result"}
!223 = distinct !{!223, !"_ZL17__float22half2_rn6float2"}
!224 = !DILocation(line: 1007, column: 10, scope: !97, inlinedAt: !225)
!225 = distinct !DILocation(line: 1077, column: 38, scope: !100, inlinedAt: !217)
!226 = !DILocation(line: 596, column: 67, scope: !212, inlinedAt: !227)
!227 = distinct !DILocation(line: 1077, column: 10, scope: !100, inlinedAt: !217)
!228 = !DILocation(line: 596, column: 73, scope: !212, inlinedAt: !227)
!229 = !DILocation(line: 164, column: 38, scope: !40)
!230 = !DILocation(line: 165, column: 22, scope: !40)
!231 = !DILocation(line: 165, column: 172, scope: !40)
!232 = !DILocation(line: 167, column: 1, scope: !40)
