; ModuleID = '/data/tilelang-metax/race_tests/nsa/experiments/20261014_resume8933/validation_v12_final/actual_binary/s4_b1_t256_h2_c1_m0_p0.bc'
source_filename = "/tmp/tmp0e9rkjvi/tvm_kernels.maca"
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
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %Indices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K_blocks.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V_blocks.coerce) local_unnamed_addr #3 !dbg !40 {
entry:
  %blocks = alloca [4 x i32], align 4, addrspace(5)
  call void @llvm.lifetime.start.p5(i64 16, ptr addrspace(5) %blocks) #12, !dbg !42, !call_argsrelate !43
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul = shl nsw i32 %0, 11
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !range !29
  %mul7 = shl nsw i32 %1, 10
  %add = add nuw nsw i32 %mul, %mul7
  %2 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !44
  %and = shl nuw nsw i32 %2, 6
  %mul9 = and i32 %and, 960
  %add10 = or disjoint i32 %add, %mul9
  %3 = lshr i32 %2, 1
  %mul14 = and i32 %3, 504
  %add12 = add nuw nsw i32 %add10, %mul14
  %4 = zext nneg i32 %add12 to i64, !dbg !45
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4, !dbg !46
  %q.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16, !dbg !47
  %q.sroa.4.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !47
  %q.sroa.4.0.copyload = load <4 x half>, ptr addrspace(4) %q.sroa.4.0.add.ptr.sroa_idx, align 8, !dbg !47
  %5 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4, !dbg !46
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %5, i64 64, !dbg !46
  %q.sroa.5.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16, !dbg !47
  %q.sroa.7.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %5, i64 72, !dbg !47
  %q.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %q.sroa.7.16.add.ptr.1.sroa_idx, align 8, !dbg !47
  %mul25 = shl nsw i32 %0, 3
  %mul27 = shl nsw i32 %1, 2
  %add28 = add nuw nsw i32 %mul25, %mul27
  %6 = zext nneg i32 %add28 to i64, !dbg !48
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %6, !dbg !49
  %7 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !49, !tbaa !30
  store i32 %7, ptr addrspace(5) %blocks, align 4, !dbg !50, !tbaa !30
  %8 = or disjoint i64 %6, 1, !dbg !51
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %8, !dbg !49
  %9 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !dbg !49, !tbaa !30
  %arrayidx31.1 = getelementptr inbounds i8, ptr addrspace(5) %blocks, i32 4, !dbg !52
  store i32 %9, ptr addrspace(5) %arrayidx31.1, align 4, !dbg !50, !tbaa !30
  %10 = or disjoint i64 %6, 2, !dbg !51
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %10, !dbg !49
  %11 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !dbg !49, !tbaa !30
  %arrayidx31.2 = getelementptr inbounds i8, ptr addrspace(5) %blocks, i32 8, !dbg !52
  store i32 %11, ptr addrspace(5) %arrayidx31.2, align 4, !dbg !50, !tbaa !30
  %12 = or disjoint i64 %6, 3, !dbg !51
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %12, !dbg !49
  %13 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !dbg !49, !tbaa !30
  %arrayidx31.3 = getelementptr inbounds i8, ptr addrspace(5) %blocks, i32 12, !dbg !52
  store i32 %13, ptr addrspace(5) %arrayidx31.3, align 4, !dbg !50, !tbaa !30
  %or.cond = icmp ugt i32 %7, 15, !dbg !53
  %shr40 = lshr i32 %0, 4
  %cmp41.not = icmp ugt i32 %7, %shr40
  %or.cond993 = or i1 %or.cond, %cmp41.not, !dbg !53
  br i1 %or.cond993, label %if.end, label %for.cond42.preheader, !dbg !53

for.cond42.preheader:                             ; preds = %entry
  %mul51 = shl nuw nsw i32 %7, 11
  %14 = shl nuw nsw i32 %2, 4
  %mul56 = and i32 %14, 16256
  %mul59 = shl nsw i32 %1, 6
  %add53 = add nuw nsw i32 %mul56, %mul59
  %and62 = shl nuw nsw i32 %2, 3
  %mul63 = and i32 %and62, 56
  %add57 = or disjoint i32 %add53, %mul63
  %add60 = add nuw nsw i32 %add57, %mul51
  %15 = zext nneg i32 %add60 to i64, !dbg !54
  %add.ptr68 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %15, !dbg !55
  %16 = load i32, ptr addrspace(4) %add.ptr68, align 4, !dbg !56, !tbaa !30
  %17 = or disjoint i64 %15, 2, !dbg !57
  %add.ptr68.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %17, !dbg !55
  %18 = load i32, ptr addrspace(4) %add.ptr68.1, align 4, !dbg !56, !tbaa !30
  %19 = or disjoint i64 %15, 4, !dbg !57
  %add.ptr68.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %19, !dbg !55
  %20 = load i32, ptr addrspace(4) %add.ptr68.2, align 4, !dbg !56, !tbaa !30
  %21 = or disjoint i64 %15, 6, !dbg !57
  %add.ptr68.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %21, !dbg !55
  %22 = load i32, ptr addrspace(4) %add.ptr68.3, align 4, !dbg !56, !tbaa !30
  %23 = add nuw nsw i64 %15, 1024
  %add.ptr68.1795 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %23, !dbg !55
  %24 = load i32, ptr addrspace(4) %add.ptr68.1795, align 4, !dbg !56, !tbaa !30
  %25 = add nuw nsw i64 %15, 1026, !dbg !57
  %add.ptr68.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %25, !dbg !55
  %26 = load i32, ptr addrspace(4) %add.ptr68.1.1, align 4, !dbg !56, !tbaa !30
  %27 = add nuw nsw i64 %15, 1028, !dbg !57
  %add.ptr68.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %27, !dbg !55
  %28 = load i32, ptr addrspace(4) %add.ptr68.2.1, align 4, !dbg !56, !tbaa !30
  %29 = add nuw nsw i64 %15, 1030, !dbg !57
  %add.ptr68.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %29, !dbg !55
  %30 = load i32, ptr addrspace(4) %add.ptr68.3.1, align 4, !dbg !56, !tbaa !30
  %add.ptr106 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %15, !dbg !58
  %31 = load i32, ptr addrspace(4) %add.ptr106, align 4, !dbg !59, !tbaa !30
  %add.ptr106.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %17, !dbg !58
  %32 = load i32, ptr addrspace(4) %add.ptr106.1, align 4, !dbg !59, !tbaa !30
  %add.ptr106.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %19, !dbg !58
  %33 = load i32, ptr addrspace(4) %add.ptr106.2, align 4, !dbg !59, !tbaa !30
  %add.ptr106.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %21, !dbg !58
  %34 = load i32, ptr addrspace(4) %add.ptr106.3, align 4, !dbg !59, !tbaa !30
  %add.ptr106.1807 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %23, !dbg !58
  %35 = load i32, ptr addrspace(4) %add.ptr106.1807, align 4, !dbg !59, !tbaa !30
  %add.ptr106.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %25, !dbg !58
  %36 = load i32, ptr addrspace(4) %add.ptr106.1.1, align 4, !dbg !59, !tbaa !30
  %add.ptr106.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %27, !dbg !58
  %37 = load i32, ptr addrspace(4) %add.ptr106.2.1, align 4, !dbg !59, !tbaa !30
  %add.ptr106.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %29, !dbg !58
  %38 = load i32, ptr addrspace(4) %add.ptr106.3.1, align 4, !dbg !59, !tbaa !30
  br label %if.end, !dbg !60

if.end:                                           ; preds = %entry, %for.cond42.preheader
  %k.sroa.18.0 = phi i32 [ %30, %for.cond42.preheader ], [ undef, %entry ]
  %k.sroa.16.0 = phi i32 [ %28, %for.cond42.preheader ], [ undef, %entry ]
  %k.sroa.14.0 = phi i32 [ %26, %for.cond42.preheader ], [ undef, %entry ]
  %k.sroa.11.0 = phi i32 [ %24, %for.cond42.preheader ], [ undef, %entry ]
  %k.sroa.9.0 = phi i32 [ %22, %for.cond42.preheader ], [ undef, %entry ]
  %k.sroa.7.0 = phi i32 [ %20, %for.cond42.preheader ], [ undef, %entry ]
  %k.sroa.5.0 = phi i32 [ %18, %for.cond42.preheader ], [ undef, %entry ]
  %k.sroa.0.0 = phi i32 [ %16, %for.cond42.preheader ], [ undef, %entry ]
  %v.sroa.18.0 = phi i32 [ %38, %for.cond42.preheader ], [ undef, %entry ]
  %v.sroa.16.0 = phi i32 [ %37, %for.cond42.preheader ], [ undef, %entry ]
  %v.sroa.14.0 = phi i32 [ %36, %for.cond42.preheader ], [ undef, %entry ]
  %v.sroa.11.0 = phi i32 [ %35, %for.cond42.preheader ], [ undef, %entry ]
  %v.sroa.9.0 = phi i32 [ %34, %for.cond42.preheader ], [ undef, %entry ]
  %v.sroa.7.0 = phi i32 [ %33, %for.cond42.preheader ], [ undef, %entry ]
  %v.sroa.5.0 = phi i32 [ %32, %for.cond42.preheader ], [ undef, %entry ]
  %v.sroa.0.0 = phi i32 [ %31, %for.cond42.preheader ], [ undef, %entry ]
  %39 = shl nuw nsw i32 %2, 3
  %mul160 = and i32 %39, 8128
  %xor714 = and i32 %39, 56
  %call164.masked = and i32 %2, 1016
  %mul166 = xor i32 %xor714, %call164.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul160
  %invariant.gep737 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul166
  %40 = lshr i32 %2, 2
  %mul185 = and i32 %40, 252
  %shr213 = lshr i32 %2, 4
  %and216 = and i32 %2, 7
  %41 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul9
  %invariant.gep749 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep737, i32 2048
  %42 = shl nuw nsw i32 %2, 4
  %mul332 = and i32 %42, 16256
  %mul335 = shl nsw i32 %1, 6
  %add329 = add nuw nsw i32 %mul332, %mul335
  %add333 = or disjoint i32 %add329, %xor714
  %mul415 = and i32 %42, 16128
  %and420 = lshr i32 %2, 3
  %shr421 = and i32 %and420, 1
  %mul426 = and i32 %40, 4
  %k.sroa.5.0.invariant.gep737.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep737, i32 4
  %k.sroa.7.0.invariant.gep737.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep737, i32 8
  %k.sroa.9.0.invariant.gep737.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep737, i32 12
  %gep738.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep737, i32 1024
  %k.sroa.14.16.gep738.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep737, i32 1028
  %k.sroa.16.16.gep738.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep737, i32 1032
  %k.sroa.18.16.gep738.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep737, i32 1036
  %xor217 = xor i32 %shr213, %and216
  %add.ptr221.idx = shl nuw nsw i32 %xor217, 4
  %add.ptr221 = getelementptr inbounds i8, ptr addrspace(3) %41, i32 %add.ptr221.idx
  %kb.sroa.6.0.add.ptr221.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr221, i32 8
  %add214.1 = add nuw nsw i32 %shr213, 4
  %xor217.1 = xor i32 %add214.1, %and216
  %add.ptr221.idx.1 = shl nuw nsw i32 %xor217.1, 4
  %add.ptr221.1 = getelementptr inbounds i8, ptr addrspace(3) %41, i32 %add.ptr221.idx.1
  %kb.sroa.6.0.add.ptr221.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr221.1, i32 8
  %v.sroa.5.0.invariant.gep749.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep737, i32 2052
  %v.sroa.7.0.invariant.gep749.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep737, i32 2056
  %v.sroa.9.0.invariant.gep749.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep737, i32 2060
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep737, i32 3072
  %v.sroa.14.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep737, i32 3076
  %v.sroa.16.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep737, i32 3080
  %v.sroa.18.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep737, i32 3084
  %xor428 = or disjoint i32 %mul426, %shr421
  %mul429 = shl nuw nsw i32 %xor428, 3
  %add430 = or disjoint i32 %mul429, %mul415
  %add433 = or disjoint i32 %add430, %and216
  %gep757 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add433
  %add417.1 = or disjoint i32 %mul415, 64
  %add427.1 = or disjoint i32 %mul426, 1
  %xor428.1 = xor i32 %add427.1, %shr421
  %mul429.1 = shl nuw nsw i32 %xor428.1, 3
  %add430.1 = or disjoint i32 %mul429.1, %add417.1
  %add433.1 = or disjoint i32 %add430.1, %and216
  %gep757.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add433.1
  %add417.2 = or disjoint i32 %mul415, 128
  %add427.2 = or disjoint i32 %mul426, 2
  %xor428.2 = or disjoint i32 %add427.2, %shr421
  %mul429.2 = shl nuw nsw i32 %xor428.2, 3
  %add430.2 = or disjoint i32 %mul429.2, %add417.2
  %add433.2 = or disjoint i32 %add430.2, %and216
  %gep757.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add433.2
  %add417.3 = or disjoint i32 %mul415, 192
  %add427.3 = or disjoint i32 %mul426, 3
  %xor428.3 = xor i32 %add427.3, %shr421
  %mul429.3 = shl nuw nsw i32 %xor428.3, 3
  %add430.3 = or disjoint i32 %mul429.3, %add417.3
  %add433.3 = or disjoint i32 %add430.3, %and216
  %gep757.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add433.3
  %add422.1 = or disjoint i32 %shr421, 2
  %xor428.1835 = or disjoint i32 %mul426, %add422.1
  %mul429.1836 = shl nuw nsw i32 %xor428.1835, 3
  %add430.1837 = or disjoint i32 %mul429.1836, %mul415
  %add433.1838 = or disjoint i32 %add430.1837, %and216
  %gep757.1839 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add433.1838
  %xor428.1.1 = xor i32 %add427.1, %add422.1
  %mul429.1.1 = shl nuw nsw i32 %xor428.1.1, 3
  %add430.1.1 = or disjoint i32 %mul429.1.1, %add417.1
  %add433.1.1 = or disjoint i32 %add430.1.1, %and216
  %gep757.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add433.1.1
  %xor428.2.1 = xor i32 %add427.2, %add422.1
  %mul429.2.1 = shl nuw nsw i32 %xor428.2.1, 3
  %add430.2.1 = or disjoint i32 %mul429.2.1, %add417.2
  %add433.2.1 = or disjoint i32 %add430.2.1, %and216
  %gep757.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add433.2.1
  %xor428.3.1 = xor i32 %add427.3, %add422.1
  %mul429.3.1 = shl nuw nsw i32 %xor428.3.1, 3
  %add430.3.1 = or disjoint i32 %mul429.3.1, %add417.3
  %add433.3.1 = or disjoint i32 %add430.3.1, %and216
  %gep757.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add433.3.1
  %add422.2 = or disjoint i32 %shr421, 4
  %xor428.2841 = xor i32 %mul426, %add422.2
  %mul429.2842 = shl nuw nsw i32 %xor428.2841, 3
  %add430.2843 = or disjoint i32 %mul429.2842, %mul415
  %add433.2844 = or disjoint i32 %add430.2843, %and216
  %gep757.2845 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add433.2844
  %xor428.1.2 = xor i32 %add427.1, %add422.2
  %mul429.1.2 = shl nuw nsw i32 %xor428.1.2, 3
  %add430.1.2 = or disjoint i32 %mul429.1.2, %add417.1
  %add433.1.2 = or disjoint i32 %add430.1.2, %and216
  %gep757.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add433.1.2
  %xor428.2.2 = xor i32 %add427.2, %add422.2
  %mul429.2.2 = shl nuw nsw i32 %xor428.2.2, 3
  %add430.2.2 = or disjoint i32 %mul429.2.2, %add417.2
  %add433.2.2 = or disjoint i32 %add430.2.2, %and216
  %gep757.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add433.2.2
  %xor428.3.2 = xor i32 %add427.3, %add422.2
  %mul429.3.2 = shl nuw nsw i32 %xor428.3.2, 3
  %add430.3.2 = or disjoint i32 %mul429.3.2, %add417.3
  %add433.3.2 = or disjoint i32 %add430.3.2, %and216
  %gep757.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add433.3.2
  %add422.3 = or disjoint i32 %shr421, 6
  %xor428.3847 = xor i32 %mul426, %add422.3
  %mul429.3848 = shl nuw nsw i32 %xor428.3847, 3
  %add430.3849 = or disjoint i32 %mul429.3848, %mul415
  %add433.3850 = or disjoint i32 %add430.3849, %and216
  %gep757.3851 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add433.3850
  %xor428.1.3 = xor i32 %add427.1, %add422.3
  %mul429.1.3 = shl nuw nsw i32 %xor428.1.3, 3
  %add430.1.3 = or disjoint i32 %mul429.1.3, %add417.1
  %add433.1.3 = or disjoint i32 %add430.1.3, %and216
  %gep757.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add433.1.3
  %xor428.2.3 = xor i32 %add427.2, %add422.3
  %mul429.2.3 = shl nuw nsw i32 %xor428.2.3, 3
  %add430.2.3 = or disjoint i32 %mul429.2.3, %add417.2
  %add433.2.3 = or disjoint i32 %add430.2.3, %and216
  %gep757.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add433.2.3
  %xor428.3.3 = xor i32 %add427.3, %add422.3
  %mul429.3.3 = shl nuw nsw i32 %xor428.3.3, 3
  %add430.3.3 = or disjoint i32 %mul429.3.3, %add417.3
  %add433.3.3 = or disjoint i32 %add430.3.3, %and216
  %gep757.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add433.3.3
  br label %for.body138, !dbg !61

for.body138:                                      ; preds = %if.end465.1, %if.end
  %k.sroa.18.1 = phi i32 [ %k.sroa.18.0, %if.end ], [ %k.sroa.18.2.1, %if.end465.1 ]
  %k.sroa.16.1 = phi i32 [ %k.sroa.16.0, %if.end ], [ %k.sroa.16.2.1, %if.end465.1 ]
  %k.sroa.14.1 = phi i32 [ %k.sroa.14.0, %if.end ], [ %k.sroa.14.2.1, %if.end465.1 ]
  %k.sroa.11.1 = phi i32 [ %k.sroa.11.0, %if.end ], [ %k.sroa.11.2.1, %if.end465.1 ]
  %k.sroa.9.1 = phi i32 [ %k.sroa.9.0, %if.end ], [ %k.sroa.9.2.1, %if.end465.1 ]
  %k.sroa.7.1 = phi i32 [ %k.sroa.7.0, %if.end ], [ %k.sroa.7.2.1, %if.end465.1 ]
  %k.sroa.5.1 = phi i32 [ %k.sroa.5.0, %if.end ], [ %k.sroa.5.2.1, %if.end465.1 ]
  %k.sroa.0.1 = phi i32 [ %k.sroa.0.0, %if.end ], [ %k.sroa.0.2.1, %if.end465.1 ]
  %v.sroa.18.1 = phi i32 [ %v.sroa.18.0, %if.end ], [ %v.sroa.18.2.1, %if.end465.1 ]
  %v.sroa.16.1 = phi i32 [ %v.sroa.16.0, %if.end ], [ %v.sroa.16.2.1, %if.end465.1 ]
  %v.sroa.14.1 = phi i32 [ %v.sroa.14.0, %if.end ], [ %v.sroa.14.2.1, %if.end465.1 ]
  %v.sroa.11.1 = phi i32 [ %v.sroa.11.0, %if.end ], [ %v.sroa.11.2.1, %if.end465.1 ]
  %v.sroa.9.1 = phi i32 [ %v.sroa.9.0, %if.end ], [ %v.sroa.9.2.1, %if.end465.1 ]
  %v.sroa.7.1 = phi i32 [ %v.sroa.7.0, %if.end ], [ %v.sroa.7.2.1, %if.end465.1 ]
  %v.sroa.5.1 = phi i32 [ %v.sroa.5.0, %if.end ], [ %v.sroa.5.2.1, %if.end465.1 ]
  %v.sroa.0.1 = phi i32 [ %v.sroa.0.0, %if.end ], [ %v.sroa.0.2.1, %if.end465.1 ]
  %out.sroa.56.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.56.1.1, %if.end465.1 ], !dbg !62
  %out.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.38.1.1, %if.end465.1 ], !dbg !62
  %out.sroa.20.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.20.1.1, %if.end465.1 ], !dbg !62
  %out.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.0.1.1, %if.end465.1 ], !dbg !62
  %partial_sum.sroa.14.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.14.1.1, %if.end465.1 ], !dbg !63
  %partial_sum.sroa.10.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.10.1.1, %if.end465.1 ], !dbg !63
  %partial_sum.sroa.6.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.6.1.1, %if.end465.1 ], !dbg !63
  %partial_sum.sroa.0.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.0.1.1, %if.end465.1 ], !dbg !63
  %prob.sroa.0.0 = phi <4 x half> [ undef, %if.end ], [ %prob.sroa.0.1.1, %if.end465.1 ]
  %s_1.0761 = phi i32 [ 0, %if.end ], [ %inc467.1, %if.end465.1 ]
  %arrayidx140 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %s_1.0761, !dbg !64
  %43 = load i32, ptr addrspace(5) %arrayidx140, align 4, !dbg !64, !tbaa !30
  %or.cond773 = icmp ugt i32 %43, 15, !dbg !65
  %cmp147.not = icmp sgt i32 %43, %shr40
  %or.cond774 = or i1 %or.cond773, %cmp147.not, !dbg !65
  br i1 %or.cond774, label %if.then307, label %for.body152.preheader, !dbg !65

for.body152.preheader:                            ; preds = %for.body138
  store i32 %k.sroa.0.1, ptr addrspace(3) %invariant.gep737, align 16, !dbg !66, !tbaa !30
  store i32 %k.sroa.5.1, ptr addrspace(3) %k.sroa.5.0.invariant.gep737.sroa_idx, align 4, !dbg !66, !tbaa !30
  store i32 %k.sroa.7.1, ptr addrspace(3) %k.sroa.7.0.invariant.gep737.sroa_idx, align 8, !dbg !66, !tbaa !30
  store i32 %k.sroa.9.1, ptr addrspace(3) %k.sroa.9.0.invariant.gep737.sroa_idx, align 4, !dbg !66, !tbaa !30
  store i32 %k.sroa.11.1, ptr addrspace(3) %gep738.1, align 16, !dbg !66, !tbaa !30
  store i32 %k.sroa.14.1, ptr addrspace(3) %k.sroa.14.16.gep738.1.sroa_idx, align 4, !dbg !66, !tbaa !30
  store i32 %k.sroa.16.1, ptr addrspace(3) %k.sroa.16.16.gep738.1.sroa_idx, align 8, !dbg !66, !tbaa !30
  store i32 %k.sroa.18.1, ptr addrspace(3) %k.sroa.18.16.gep738.1.sroa_idx, align 4, !dbg !66, !tbaa !30
  %mul174 = shl nuw nsw i32 %43, 4, !dbg !67
  %add175 = or disjoint i32 %mul174, 15, !dbg !68
  %cmp176 = icmp ult i32 %0, %add175, !dbg !69
  br i1 %cmp176, label %for.cond178.preheader, label %if.end203, !dbg !70

for.cond178.preheader:                            ; preds = %for.body152.preheader
  %add186 = add nuw nsw i32 %mul174, %mul185
  %cmp189.not = icmp ugt i32 %add186, %0, !dbg !71
  %spec.select = select i1 %cmp189.not, float 0xFFF0000000000000, float 0.000000e+00, !dbg !72
  %scores.sroa.0.0.vec.insert878 = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !73
  %cmp189.not.1.not = icmp ult i32 %add186, %0, !dbg !71
  %spec.select.1 = select i1 %cmp189.not.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !72
  %scores.sroa.0.4.vec.insert885 = insertelement <4 x float> %scores.sroa.0.0.vec.insert878, float %spec.select.1, i64 1, !dbg !73
  %add187.2 = or disjoint i32 %add186, 2, !dbg !74
  %cmp189.not.2 = icmp ugt i32 %add187.2, %0, !dbg !71
  %spec.select.2 = select i1 %cmp189.not.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !72
  %scores.sroa.0.8.vec.insert892 = insertelement <4 x float> %scores.sroa.0.4.vec.insert885, float %spec.select.2, i64 2, !dbg !73
  %add187.3 = or disjoint i32 %add186, 3, !dbg !74
  %cmp189.not.3 = icmp ugt i32 %add187.3, %0, !dbg !71
  %spec.select.3 = select i1 %cmp189.not.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !72
  %scores.sroa.0.12.vec.insert899 = insertelement <4 x float> %scores.sroa.0.8.vec.insert892, float %spec.select.3, i64 3, !dbg !73
  br label %if.end203, !dbg !75

if.end203:                                        ; preds = %for.body152.preheader, %for.cond178.preheader
  %scores.sroa.0.1 = phi <4 x float> [ %scores.sroa.0.12.vec.insert899, %for.cond178.preheader ], [ zeroinitializer, %for.body152.preheader ], !dbg !81
  fence syncscope("warp") release, !dbg !75
  tail call void @llvm.mxc.barrier.warp(), !dbg !82
  fence syncscope("warp") acquire, !dbg !83
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr221, align 16, !dbg !84
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr221.sroa_idx, align 8, !dbg !84
  %44 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.1), !dbg !85, !call_argsrelate !86
  %45 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %44), !dbg !85, !call_argsrelate !86
  %kb.sroa.0.0.copyload868 = load <4 x half>, ptr addrspace(3) %add.ptr221.1, align 16, !dbg !84
  %kb.sroa.6.0.copyload869 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr221.1.sroa_idx, align 8, !dbg !84
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload868, <4 x half> %q.sroa.5.16.copyload, <4 x float> %45), !dbg !85, !call_argsrelate !86
  %47 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload869, <4 x half> %q.sroa.7.16.copyload, <4 x float> %46), !dbg !85, !call_argsrelate !86
  store i32 %v.sroa.0.1, ptr addrspace(3) %invariant.gep749, align 16, !dbg !87, !tbaa !30
  store i32 %v.sroa.5.1, ptr addrspace(3) %v.sroa.5.0.invariant.gep749.sroa_idx, align 4, !dbg !87, !tbaa !30
  store i32 %v.sroa.7.1, ptr addrspace(3) %v.sroa.7.0.invariant.gep749.sroa_idx, align 8, !dbg !87, !tbaa !30
  store i32 %v.sroa.9.1, ptr addrspace(3) %v.sroa.9.0.invariant.gep749.sroa_idx, align 4, !dbg !87, !tbaa !30
  store i32 %v.sroa.11.1, ptr addrspace(3) %gep.1, align 16, !dbg !87, !tbaa !30
  store i32 %v.sroa.14.1, ptr addrspace(3) %v.sroa.14.16.gep.1.sroa_idx, align 4, !dbg !87, !tbaa !30
  store i32 %v.sroa.16.1, ptr addrspace(3) %v.sroa.16.16.gep.1.sroa_idx, align 8, !dbg !87, !tbaa !30
  store i32 %v.sroa.18.1, ptr addrspace(3) %v.sroa.18.16.gep.1.sroa_idx, align 4, !dbg !87, !tbaa !30
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %47, i64 0, !dbg !88
  %mul278 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !89
  %48 = tail call contract noundef float @llvm.minnum.f32(float %mul278, float 0x4024CB5EC0000000), !dbg !90
  %49 = tail call contract noundef float @llvm.exp.f32(float %48), !dbg !94
  %add287 = fadd contract float %partial_sum.sroa.0.0, %49, !dbg !97
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %47, i64 1, !dbg !88
  %mul278.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !89
  %50 = tail call contract noundef float @llvm.minnum.f32(float %mul278.1, float 0x4024CB5EC0000000), !dbg !90
  %51 = tail call contract noundef float @llvm.exp.f32(float %50), !dbg !94
  %add287.1 = fadd contract float %partial_sum.sroa.6.0, %51, !dbg !97
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %47, i64 2, !dbg !88
  %mul278.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !89
  %52 = tail call contract noundef float @llvm.minnum.f32(float %mul278.2, float 0x4024CB5EC0000000), !dbg !90
  %53 = tail call contract noundef float @llvm.exp.f32(float %52), !dbg !94
  %add287.2 = fadd contract float %partial_sum.sroa.10.0, %53, !dbg !97
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %47, i64 3, !dbg !88
  %mul278.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !89
  %54 = tail call contract noundef float @llvm.minnum.f32(float %mul278.3, float 0x4024CB5EC0000000), !dbg !90
  %55 = tail call contract noundef float @llvm.exp.f32(float %54), !dbg !94
  %add287.3 = fadd contract float %partial_sum.sroa.14.0, %55, !dbg !97
  %56 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %49), !dbg !98
  %57 = insertelement <4 x i16> poison, i16 %56, i64 0, !dbg !107
  %58 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %51), !dbg !98
  %59 = insertelement <4 x i16> %57, i16 %58, i64 1, !dbg !107
  %60 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %53), !dbg !98
  %61 = insertelement <4 x i16> %59, i16 %60, i64 2, !dbg !107
  %62 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %55), !dbg !98
  %63 = insertelement <4 x i16> %61, i16 %62, i64 3, !dbg !107
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %63 to <4 x half>, !dbg !107
  fence syncscope("warp") release, !dbg !108
  tail call void @llvm.mxc.barrier.warp(), !dbg !111
  fence syncscope("warp") acquire, !dbg !112
  br label %if.then307, !dbg !113

if.then307:                                       ; preds = %for.body138, %if.end203
  %partial_sum.sroa.14.1 = phi float [ %partial_sum.sroa.14.0, %for.body138 ], [ %add287.3, %if.end203 ], !dbg !81
  %partial_sum.sroa.10.1 = phi float [ %partial_sum.sroa.10.0, %for.body138 ], [ %add287.2, %if.end203 ], !dbg !81
  %partial_sum.sroa.6.1 = phi float [ %partial_sum.sroa.6.0, %for.body138 ], [ %add287.1, %if.end203 ], !dbg !81
  %partial_sum.sroa.0.1 = phi float [ %partial_sum.sroa.0.0, %for.body138 ], [ %add287, %if.end203 ], !dbg !81
  %prob.sroa.0.1 = phi <4 x half> [ %prob.sroa.0.0, %for.body138 ], [ %prob.sroa.0.6.vec.insert, %if.end203 ]
  %add308 = or disjoint i32 %s_1.0761, 1, !dbg !114
  %arrayidx310 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %add308, !dbg !115
  %64 = load i32, ptr addrspace(5) %arrayidx310, align 4, !dbg !115, !tbaa !30
  %or.cond775 = icmp ugt i32 %64, 15, !dbg !116
  %cmp317.not = icmp sgt i32 %64, %shr40
  %or.cond776 = or i1 %or.cond775, %cmp317.not, !dbg !116
  br i1 %or.cond776, label %if.end396, label %for.cond319.preheader, !dbg !116

for.cond319.preheader:                            ; preds = %if.then307
  %mul327 = shl nuw nsw i32 %64, 11
  %add336 = add nuw nsw i32 %add333, %mul327
  %65 = zext nneg i32 %add336 to i64, !dbg !117
  %add.ptr344 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %65, !dbg !118
  %66 = load i32, ptr addrspace(4) %add.ptr344, align 4, !dbg !119, !tbaa !30
  %67 = or disjoint i64 %65, 2, !dbg !120
  %add.ptr344.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %67, !dbg !118
  %68 = load i32, ptr addrspace(4) %add.ptr344.1, align 4, !dbg !119, !tbaa !30
  %69 = or disjoint i64 %65, 4, !dbg !120
  %add.ptr344.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %69, !dbg !118
  %70 = load i32, ptr addrspace(4) %add.ptr344.2, align 4, !dbg !119, !tbaa !30
  %71 = or disjoint i64 %65, 6, !dbg !120
  %add.ptr344.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %71, !dbg !118
  %72 = load i32, ptr addrspace(4) %add.ptr344.3, align 4, !dbg !119, !tbaa !30
  %73 = add nuw nsw i64 %65, 1024
  %add.ptr344.1821 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %73, !dbg !118
  %74 = load i32, ptr addrspace(4) %add.ptr344.1821, align 4, !dbg !119, !tbaa !30
  %75 = add nuw nsw i64 %65, 1026, !dbg !120
  %add.ptr344.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %75, !dbg !118
  %76 = load i32, ptr addrspace(4) %add.ptr344.1.1, align 4, !dbg !119, !tbaa !30
  %77 = add nuw nsw i64 %65, 1028, !dbg !120
  %add.ptr344.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %77, !dbg !118
  %78 = load i32, ptr addrspace(4) %add.ptr344.2.1, align 4, !dbg !119, !tbaa !30
  %79 = add nuw nsw i64 %65, 1030, !dbg !120
  %add.ptr344.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %79, !dbg !118
  %80 = load i32, ptr addrspace(4) %add.ptr344.3.1, align 4, !dbg !119, !tbaa !30
  %add.ptr382 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %65, !dbg !121
  %81 = load i32, ptr addrspace(4) %add.ptr382, align 4, !dbg !122, !tbaa !30
  %add.ptr382.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %67, !dbg !121
  %82 = load i32, ptr addrspace(4) %add.ptr382.1, align 4, !dbg !122, !tbaa !30
  %add.ptr382.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %69, !dbg !121
  %83 = load i32, ptr addrspace(4) %add.ptr382.2, align 4, !dbg !122, !tbaa !30
  %add.ptr382.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %71, !dbg !121
  %84 = load i32, ptr addrspace(4) %add.ptr382.3, align 4, !dbg !122, !tbaa !30
  %add.ptr382.1833 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %73, !dbg !121
  %85 = load i32, ptr addrspace(4) %add.ptr382.1833, align 4, !dbg !122, !tbaa !30
  %add.ptr382.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %75, !dbg !121
  %86 = load i32, ptr addrspace(4) %add.ptr382.1.1, align 4, !dbg !122, !tbaa !30
  %add.ptr382.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %77, !dbg !121
  %87 = load i32, ptr addrspace(4) %add.ptr382.2.1, align 4, !dbg !122, !tbaa !30
  %add.ptr382.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %79, !dbg !121
  %88 = load i32, ptr addrspace(4) %add.ptr382.3.1, align 4, !dbg !122, !tbaa !30
  br label %if.end396, !dbg !123

if.end396:                                        ; preds = %for.cond319.preheader, %if.then307
  %k.sroa.18.2 = phi i32 [ %k.sroa.18.1, %if.then307 ], [ %80, %for.cond319.preheader ]
  %k.sroa.16.2 = phi i32 [ %k.sroa.16.1, %if.then307 ], [ %78, %for.cond319.preheader ]
  %k.sroa.14.2 = phi i32 [ %k.sroa.14.1, %if.then307 ], [ %76, %for.cond319.preheader ]
  %k.sroa.11.2 = phi i32 [ %k.sroa.11.1, %if.then307 ], [ %74, %for.cond319.preheader ]
  %k.sroa.9.2 = phi i32 [ %k.sroa.9.1, %if.then307 ], [ %72, %for.cond319.preheader ]
  %k.sroa.7.2 = phi i32 [ %k.sroa.7.1, %if.then307 ], [ %70, %for.cond319.preheader ]
  %k.sroa.5.2 = phi i32 [ %k.sroa.5.1, %if.then307 ], [ %68, %for.cond319.preheader ]
  %k.sroa.0.2 = phi i32 [ %k.sroa.0.1, %if.then307 ], [ %66, %for.cond319.preheader ]
  %v.sroa.18.2 = phi i32 [ %v.sroa.18.1, %if.then307 ], [ %88, %for.cond319.preheader ]
  %v.sroa.16.2 = phi i32 [ %v.sroa.16.1, %if.then307 ], [ %87, %for.cond319.preheader ]
  %v.sroa.14.2 = phi i32 [ %v.sroa.14.1, %if.then307 ], [ %86, %for.cond319.preheader ]
  %v.sroa.11.2 = phi i32 [ %v.sroa.11.1, %if.then307 ], [ %85, %for.cond319.preheader ]
  %v.sroa.9.2 = phi i32 [ %v.sroa.9.1, %if.then307 ], [ %84, %for.cond319.preheader ]
  %v.sroa.7.2 = phi i32 [ %v.sroa.7.1, %if.then307 ], [ %83, %for.cond319.preheader ]
  %v.sroa.5.2 = phi i32 [ %v.sroa.5.1, %if.then307 ], [ %82, %for.cond319.preheader ]
  %v.sroa.0.2 = phi i32 [ %v.sroa.0.1, %if.then307 ], [ %81, %for.cond319.preheader ]
  br i1 %or.cond774, label %if.end465, label %for.cond409.preheader.preheader, !dbg !123

for.cond409.preheader.preheader:                  ; preds = %if.end396
  %89 = load half, ptr addrspace(3) %gep757, align 2, !dbg !124, !tbaa !125
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %89, i64 0, !dbg !124
  %90 = load half, ptr addrspace(3) %gep757.1, align 2, !dbg !124, !tbaa !125
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %90, i64 1, !dbg !124
  %91 = load half, ptr addrspace(3) %gep757.2, align 2, !dbg !124, !tbaa !125
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %91, i64 2, !dbg !124
  %92 = load half, ptr addrspace(3) %gep757.3, align 2, !dbg !124, !tbaa !125
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %92, i64 3, !dbg !124
  %93 = load half, ptr addrspace(3) %gep757.1839, align 2, !dbg !124, !tbaa !125
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %93, i64 0, !dbg !124
  %94 = load half, ptr addrspace(3) %gep757.1.1, align 2, !dbg !124, !tbaa !125
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %94, i64 1, !dbg !124
  %95 = load half, ptr addrspace(3) %gep757.2.1, align 2, !dbg !124, !tbaa !125
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %95, i64 2, !dbg !124
  %96 = load half, ptr addrspace(3) %gep757.3.1, align 2, !dbg !124, !tbaa !125
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %96, i64 3, !dbg !124
  %97 = load half, ptr addrspace(3) %gep757.2845, align 2, !dbg !124, !tbaa !125
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %97, i64 0, !dbg !124
  %98 = load half, ptr addrspace(3) %gep757.1.2, align 2, !dbg !124, !tbaa !125
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %98, i64 1, !dbg !124
  %99 = load half, ptr addrspace(3) %gep757.2.2, align 2, !dbg !124, !tbaa !125
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %99, i64 2, !dbg !124
  %100 = load half, ptr addrspace(3) %gep757.3.2, align 2, !dbg !124, !tbaa !125
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %100, i64 3, !dbg !124
  %101 = load half, ptr addrspace(3) %gep757.3851, align 2, !dbg !124, !tbaa !125
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %101, i64 0, !dbg !124
  %102 = load half, ptr addrspace(3) %gep757.1.3, align 2, !dbg !124, !tbaa !125
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %102, i64 1, !dbg !124
  %103 = load half, ptr addrspace(3) %gep757.2.3, align 2, !dbg !124, !tbaa !125
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %103, i64 2, !dbg !124
  %104 = load half, ptr addrspace(3) %gep757.3.3, align 2, !dbg !124, !tbaa !125
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %104, i64 3, !dbg !124
  %105 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.0.0), !dbg !126
  %106 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.20.0), !dbg !126
  %107 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.38.0), !dbg !126
  %108 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.56.0), !dbg !126
  br label %if.end465, !dbg !127

if.end465:                                        ; preds = %for.cond409.preheader.preheader, %if.end396
  %out.sroa.56.1 = phi <4 x float> [ %out.sroa.56.0, %if.end396 ], [ %108, %for.cond409.preheader.preheader ], !dbg !81
  %out.sroa.38.1 = phi <4 x float> [ %out.sroa.38.0, %if.end396 ], [ %107, %for.cond409.preheader.preheader ], !dbg !81
  %out.sroa.20.1 = phi <4 x float> [ %out.sroa.20.0, %if.end396 ], [ %106, %for.cond409.preheader.preheader ], !dbg !81
  %out.sroa.0.1 = phi <4 x float> [ %out.sroa.0.0, %if.end396 ], [ %105, %for.cond409.preheader.preheader ], !dbg !81
  %inc467 = or disjoint i32 %s_1.0761, 1, !dbg !127
  %arrayidx140.1 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %inc467, !dbg !64
  %109 = load i32, ptr addrspace(5) %arrayidx140.1, align 4, !dbg !64, !tbaa !30
  %or.cond773.1 = icmp ugt i32 %109, 15, !dbg !65
  %cmp147.not.1 = icmp sgt i32 %109, %shr40
  %or.cond774.1 = or i1 %or.cond773.1, %cmp147.not.1, !dbg !65
  br i1 %or.cond774.1, label %if.end305.1, label %for.body152.preheader.1, !dbg !65

for.body152.preheader.1:                          ; preds = %if.end465
  store i32 %k.sroa.0.2, ptr addrspace(3) %invariant.gep737, align 16, !dbg !66, !tbaa !30
  store i32 %k.sroa.5.2, ptr addrspace(3) %k.sroa.5.0.invariant.gep737.sroa_idx, align 4, !dbg !66, !tbaa !30
  store i32 %k.sroa.7.2, ptr addrspace(3) %k.sroa.7.0.invariant.gep737.sroa_idx, align 8, !dbg !66, !tbaa !30
  store i32 %k.sroa.9.2, ptr addrspace(3) %k.sroa.9.0.invariant.gep737.sroa_idx, align 4, !dbg !66, !tbaa !30
  store i32 %k.sroa.11.2, ptr addrspace(3) %gep738.1, align 16, !dbg !66, !tbaa !30
  store i32 %k.sroa.14.2, ptr addrspace(3) %k.sroa.14.16.gep738.1.sroa_idx, align 4, !dbg !66, !tbaa !30
  store i32 %k.sroa.16.2, ptr addrspace(3) %k.sroa.16.16.gep738.1.sroa_idx, align 8, !dbg !66, !tbaa !30
  store i32 %k.sroa.18.2, ptr addrspace(3) %k.sroa.18.16.gep738.1.sroa_idx, align 4, !dbg !66, !tbaa !30
  %mul174.1 = shl nuw nsw i32 %109, 4, !dbg !67
  %add175.1 = or disjoint i32 %mul174.1, 15, !dbg !68
  %cmp176.1 = icmp ult i32 %0, %add175.1, !dbg !69
  br i1 %cmp176.1, label %for.cond178.preheader.1, label %if.end203.1, !dbg !70

for.cond178.preheader.1:                          ; preds = %for.body152.preheader.1
  %add186.1 = add nuw nsw i32 %mul174.1, %mul185
  %cmp189.not.1 = icmp ugt i32 %add186.1, %0, !dbg !71
  %spec.select.1994 = select i1 %cmp189.not.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !72
  %scores.sroa.0.0.vec.insert878.1 = insertelement <4 x float> poison, float %spec.select.1994, i64 0, !dbg !73
  %cmp189.not.1.not.1 = icmp ult i32 %add186.1, %0, !dbg !71
  %spec.select.1.1 = select i1 %cmp189.not.1.not.1, float 0.000000e+00, float 0xFFF0000000000000, !dbg !72
  %scores.sroa.0.4.vec.insert885.1 = insertelement <4 x float> %scores.sroa.0.0.vec.insert878.1, float %spec.select.1.1, i64 1, !dbg !73
  %add187.2.1 = or disjoint i32 %add186.1, 2, !dbg !74
  %cmp189.not.2.1 = icmp ugt i32 %add187.2.1, %0, !dbg !71
  %spec.select.2.1 = select i1 %cmp189.not.2.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !72
  %scores.sroa.0.8.vec.insert892.1 = insertelement <4 x float> %scores.sroa.0.4.vec.insert885.1, float %spec.select.2.1, i64 2, !dbg !73
  %add187.3.1 = or disjoint i32 %add186.1, 3, !dbg !74
  %cmp189.not.3.1 = icmp ugt i32 %add187.3.1, %0, !dbg !71
  %spec.select.3.1 = select i1 %cmp189.not.3.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !72
  %scores.sroa.0.12.vec.insert899.1 = insertelement <4 x float> %scores.sroa.0.8.vec.insert892.1, float %spec.select.3.1, i64 3, !dbg !73
  br label %if.end203.1, !dbg !75

if.end203.1:                                      ; preds = %for.cond178.preheader.1, %for.body152.preheader.1
  %scores.sroa.0.1.1 = phi <4 x float> [ %scores.sroa.0.12.vec.insert899.1, %for.cond178.preheader.1 ], [ zeroinitializer, %for.body152.preheader.1 ], !dbg !81
  fence syncscope("warp") release, !dbg !75
  tail call void @llvm.mxc.barrier.warp(), !dbg !82
  fence syncscope("warp") acquire, !dbg !83
  %kb.sroa.0.0.copyload.1 = load <4 x half>, ptr addrspace(3) %add.ptr221, align 16, !dbg !84
  %kb.sroa.6.0.copyload.1 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr221.sroa_idx, align 8, !dbg !84
  %110 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload.1, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.1.1), !dbg !85, !call_argsrelate !86
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload.1, <4 x half> %q.sroa.4.0.copyload, <4 x float> %110), !dbg !85, !call_argsrelate !86
  %kb.sroa.0.0.copyload868.1 = load <4 x half>, ptr addrspace(3) %add.ptr221.1, align 16, !dbg !84
  %kb.sroa.6.0.copyload869.1 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr221.1.sroa_idx, align 8, !dbg !84
  %112 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload868.1, <4 x half> %q.sroa.5.16.copyload, <4 x float> %111), !dbg !85, !call_argsrelate !86
  %113 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload869.1, <4 x half> %q.sroa.7.16.copyload, <4 x float> %112), !dbg !85, !call_argsrelate !86
  store i32 %v.sroa.0.2, ptr addrspace(3) %invariant.gep749, align 16, !dbg !87, !tbaa !30
  store i32 %v.sroa.5.2, ptr addrspace(3) %v.sroa.5.0.invariant.gep749.sroa_idx, align 4, !dbg !87, !tbaa !30
  store i32 %v.sroa.7.2, ptr addrspace(3) %v.sroa.7.0.invariant.gep749.sroa_idx, align 8, !dbg !87, !tbaa !30
  store i32 %v.sroa.9.2, ptr addrspace(3) %v.sroa.9.0.invariant.gep749.sroa_idx, align 4, !dbg !87, !tbaa !30
  store i32 %v.sroa.11.2, ptr addrspace(3) %gep.1, align 16, !dbg !87, !tbaa !30
  store i32 %v.sroa.14.2, ptr addrspace(3) %v.sroa.14.16.gep.1.sroa_idx, align 4, !dbg !87, !tbaa !30
  store i32 %v.sroa.16.2, ptr addrspace(3) %v.sroa.16.16.gep.1.sroa_idx, align 8, !dbg !87, !tbaa !30
  store i32 %v.sroa.18.2, ptr addrspace(3) %v.sroa.18.16.gep.1.sroa_idx, align 4, !dbg !87, !tbaa !30
  %scores.sroa.0.0.vec.extract.1 = extractelement <4 x float> %113, i64 0, !dbg !88
  %mul278.1995 = fmul contract float %scores.sroa.0.0.vec.extract.1, 0x3FB99999A0000000, !dbg !89
  %114 = tail call contract noundef float @llvm.minnum.f32(float %mul278.1995, float 0x4024CB5EC0000000), !dbg !90
  %115 = tail call contract noundef float @llvm.exp.f32(float %114), !dbg !94
  %add287.1996 = fadd contract float %partial_sum.sroa.0.1, %115, !dbg !97
  %scores.sroa.0.4.vec.extract.1 = extractelement <4 x float> %113, i64 1, !dbg !88
  %mul278.1.1 = fmul contract float %scores.sroa.0.4.vec.extract.1, 0x3FB99999A0000000, !dbg !89
  %116 = tail call contract noundef float @llvm.minnum.f32(float %mul278.1.1, float 0x4024CB5EC0000000), !dbg !90
  %117 = tail call contract noundef float @llvm.exp.f32(float %116), !dbg !94
  %add287.1.1 = fadd contract float %partial_sum.sroa.6.1, %117, !dbg !97
  %scores.sroa.0.8.vec.extract.1 = extractelement <4 x float> %113, i64 2, !dbg !88
  %mul278.2.1 = fmul contract float %scores.sroa.0.8.vec.extract.1, 0x3FB99999A0000000, !dbg !89
  %118 = tail call contract noundef float @llvm.minnum.f32(float %mul278.2.1, float 0x4024CB5EC0000000), !dbg !90
  %119 = tail call contract noundef float @llvm.exp.f32(float %118), !dbg !94
  %add287.2.1 = fadd contract float %partial_sum.sroa.10.1, %119, !dbg !97
  %scores.sroa.0.12.vec.extract.1 = extractelement <4 x float> %113, i64 3, !dbg !88
  %mul278.3.1 = fmul contract float %scores.sroa.0.12.vec.extract.1, 0x3FB99999A0000000, !dbg !89
  %120 = tail call contract noundef float @llvm.minnum.f32(float %mul278.3.1, float 0x4024CB5EC0000000), !dbg !90
  %121 = tail call contract noundef float @llvm.exp.f32(float %120), !dbg !94
  %add287.3.1 = fadd contract float %partial_sum.sroa.14.1, %121, !dbg !97
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %115), !dbg !98
  %123 = insertelement <4 x i16> poison, i16 %122, i64 0, !dbg !107
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %117), !dbg !98
  %125 = insertelement <4 x i16> %123, i16 %124, i64 1, !dbg !107
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %119), !dbg !98
  %127 = insertelement <4 x i16> %125, i16 %126, i64 2, !dbg !107
  %128 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %121), !dbg !98
  %129 = insertelement <4 x i16> %127, i16 %128, i64 3, !dbg !107
  %prob.sroa.0.6.vec.insert.1 = bitcast <4 x i16> %129 to <4 x half>, !dbg !107
  fence syncscope("warp") release, !dbg !108
  tail call void @llvm.mxc.barrier.warp(), !dbg !111
  fence syncscope("warp") acquire, !dbg !112
  br label %if.end305.1, !dbg !113

if.end305.1:                                      ; preds = %if.end203.1, %if.end465
  %partial_sum.sroa.14.1.1 = phi float [ %partial_sum.sroa.14.1, %if.end465 ], [ %add287.3.1, %if.end203.1 ], !dbg !81
  %partial_sum.sroa.10.1.1 = phi float [ %partial_sum.sroa.10.1, %if.end465 ], [ %add287.2.1, %if.end203.1 ], !dbg !81
  %partial_sum.sroa.6.1.1 = phi float [ %partial_sum.sroa.6.1, %if.end465 ], [ %add287.1.1, %if.end203.1 ], !dbg !81
  %partial_sum.sroa.0.1.1 = phi float [ %partial_sum.sroa.0.1, %if.end465 ], [ %add287.1996, %if.end203.1 ], !dbg !81
  %prob.sroa.0.1.1 = phi <4 x half> [ %prob.sroa.0.1, %if.end465 ], [ %prob.sroa.0.6.vec.insert.1, %if.end203.1 ]
  %cmp306.not.1 = icmp eq i32 %s_1.0761, 2, !dbg !128
  br i1 %cmp306.not.1, label %if.end396.1, label %if.then307.1, !dbg !129

if.then307.1:                                     ; preds = %if.end305.1
  %add308.1 = add nuw nsw i32 %s_1.0761, 2, !dbg !114
  %arrayidx310.1 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %add308.1, !dbg !115
  %130 = load i32, ptr addrspace(5) %arrayidx310.1, align 4, !dbg !115, !tbaa !30
  %or.cond775.1 = icmp ugt i32 %130, 15, !dbg !116
  %cmp317.not.1 = icmp sgt i32 %130, %shr40
  %or.cond776.1 = or i1 %or.cond775.1, %cmp317.not.1, !dbg !116
  br i1 %or.cond776.1, label %if.end396.1, label %for.cond319.preheader.1, !dbg !116

for.cond319.preheader.1:                          ; preds = %if.then307.1
  %mul327.1 = shl nuw nsw i32 %130, 11
  %add336.1 = add nuw nsw i32 %add333, %mul327.1
  %131 = zext nneg i32 %add336.1 to i64, !dbg !117
  %add.ptr344.1997 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %131, !dbg !118
  %132 = load i32, ptr addrspace(4) %add.ptr344.1997, align 4, !dbg !119, !tbaa !30
  %133 = or disjoint i64 %131, 2, !dbg !120
  %add.ptr344.1.1998 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %133, !dbg !118
  %134 = load i32, ptr addrspace(4) %add.ptr344.1.1998, align 4, !dbg !119, !tbaa !30
  %135 = or disjoint i64 %131, 4, !dbg !120
  %add.ptr344.2.1999 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %135, !dbg !118
  %136 = load i32, ptr addrspace(4) %add.ptr344.2.1999, align 4, !dbg !119, !tbaa !30
  %137 = or disjoint i64 %131, 6, !dbg !120
  %add.ptr344.3.11000 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %137, !dbg !118
  %138 = load i32, ptr addrspace(4) %add.ptr344.3.11000, align 4, !dbg !119, !tbaa !30
  %139 = add nuw nsw i64 %131, 1024
  %add.ptr344.1821.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %139, !dbg !118
  %140 = load i32, ptr addrspace(4) %add.ptr344.1821.1, align 4, !dbg !119, !tbaa !30
  %141 = add nuw nsw i64 %131, 1026, !dbg !120
  %add.ptr344.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %141, !dbg !118
  %142 = load i32, ptr addrspace(4) %add.ptr344.1.1.1, align 4, !dbg !119, !tbaa !30
  %143 = add nuw nsw i64 %131, 1028, !dbg !120
  %add.ptr344.2.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %143, !dbg !118
  %144 = load i32, ptr addrspace(4) %add.ptr344.2.1.1, align 4, !dbg !119, !tbaa !30
  %145 = add nuw nsw i64 %131, 1030, !dbg !120
  %add.ptr344.3.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %145, !dbg !118
  %146 = load i32, ptr addrspace(4) %add.ptr344.3.1.1, align 4, !dbg !119, !tbaa !30
  %add.ptr382.11001 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %131, !dbg !121
  %147 = load i32, ptr addrspace(4) %add.ptr382.11001, align 4, !dbg !122, !tbaa !30
  %add.ptr382.1.11002 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %133, !dbg !121
  %148 = load i32, ptr addrspace(4) %add.ptr382.1.11002, align 4, !dbg !122, !tbaa !30
  %add.ptr382.2.11003 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %135, !dbg !121
  %149 = load i32, ptr addrspace(4) %add.ptr382.2.11003, align 4, !dbg !122, !tbaa !30
  %add.ptr382.3.11004 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %137, !dbg !121
  %150 = load i32, ptr addrspace(4) %add.ptr382.3.11004, align 4, !dbg !122, !tbaa !30
  %add.ptr382.1833.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %139, !dbg !121
  %151 = load i32, ptr addrspace(4) %add.ptr382.1833.1, align 4, !dbg !122, !tbaa !30
  %add.ptr382.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %141, !dbg !121
  %152 = load i32, ptr addrspace(4) %add.ptr382.1.1.1, align 4, !dbg !122, !tbaa !30
  %add.ptr382.2.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %143, !dbg !121
  %153 = load i32, ptr addrspace(4) %add.ptr382.2.1.1, align 4, !dbg !122, !tbaa !30
  %add.ptr382.3.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %145, !dbg !121
  %154 = load i32, ptr addrspace(4) %add.ptr382.3.1.1, align 4, !dbg !122, !tbaa !30
  br label %if.end396.1, !dbg !123

if.end396.1:                                      ; preds = %for.cond319.preheader.1, %if.then307.1, %if.end305.1
  %k.sroa.18.2.1 = phi i32 [ %k.sroa.18.2, %if.end305.1 ], [ %k.sroa.18.2, %if.then307.1 ], [ %146, %for.cond319.preheader.1 ]
  %k.sroa.16.2.1 = phi i32 [ %k.sroa.16.2, %if.end305.1 ], [ %k.sroa.16.2, %if.then307.1 ], [ %144, %for.cond319.preheader.1 ]
  %k.sroa.14.2.1 = phi i32 [ %k.sroa.14.2, %if.end305.1 ], [ %k.sroa.14.2, %if.then307.1 ], [ %142, %for.cond319.preheader.1 ]
  %k.sroa.11.2.1 = phi i32 [ %k.sroa.11.2, %if.end305.1 ], [ %k.sroa.11.2, %if.then307.1 ], [ %140, %for.cond319.preheader.1 ]
  %k.sroa.9.2.1 = phi i32 [ %k.sroa.9.2, %if.end305.1 ], [ %k.sroa.9.2, %if.then307.1 ], [ %138, %for.cond319.preheader.1 ]
  %k.sroa.7.2.1 = phi i32 [ %k.sroa.7.2, %if.end305.1 ], [ %k.sroa.7.2, %if.then307.1 ], [ %136, %for.cond319.preheader.1 ]
  %k.sroa.5.2.1 = phi i32 [ %k.sroa.5.2, %if.end305.1 ], [ %k.sroa.5.2, %if.then307.1 ], [ %134, %for.cond319.preheader.1 ]
  %k.sroa.0.2.1 = phi i32 [ %k.sroa.0.2, %if.end305.1 ], [ %k.sroa.0.2, %if.then307.1 ], [ %132, %for.cond319.preheader.1 ]
  %v.sroa.18.2.1 = phi i32 [ %v.sroa.18.2, %if.end305.1 ], [ %v.sroa.18.2, %if.then307.1 ], [ %154, %for.cond319.preheader.1 ]
  %v.sroa.16.2.1 = phi i32 [ %v.sroa.16.2, %if.end305.1 ], [ %v.sroa.16.2, %if.then307.1 ], [ %153, %for.cond319.preheader.1 ]
  %v.sroa.14.2.1 = phi i32 [ %v.sroa.14.2, %if.end305.1 ], [ %v.sroa.14.2, %if.then307.1 ], [ %152, %for.cond319.preheader.1 ]
  %v.sroa.11.2.1 = phi i32 [ %v.sroa.11.2, %if.end305.1 ], [ %v.sroa.11.2, %if.then307.1 ], [ %151, %for.cond319.preheader.1 ]
  %v.sroa.9.2.1 = phi i32 [ %v.sroa.9.2, %if.end305.1 ], [ %v.sroa.9.2, %if.then307.1 ], [ %150, %for.cond319.preheader.1 ]
  %v.sroa.7.2.1 = phi i32 [ %v.sroa.7.2, %if.end305.1 ], [ %v.sroa.7.2, %if.then307.1 ], [ %149, %for.cond319.preheader.1 ]
  %v.sroa.5.2.1 = phi i32 [ %v.sroa.5.2, %if.end305.1 ], [ %v.sroa.5.2, %if.then307.1 ], [ %148, %for.cond319.preheader.1 ]
  %v.sroa.0.2.1 = phi i32 [ %v.sroa.0.2, %if.end305.1 ], [ %v.sroa.0.2, %if.then307.1 ], [ %147, %for.cond319.preheader.1 ]
  br i1 %or.cond774.1, label %if.end465.1, label %for.cond409.preheader.preheader.1, !dbg !123

for.cond409.preheader.preheader.1:                ; preds = %if.end396.1
  %155 = load half, ptr addrspace(3) %gep757, align 2, !dbg !124, !tbaa !125
  %vb.sroa.0.0.vec.insert.1 = insertelement <4 x half> poison, half %155, i64 0, !dbg !124
  %156 = load half, ptr addrspace(3) %gep757.1, align 2, !dbg !124, !tbaa !125
  %vb.sroa.0.2.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.0.vec.insert.1, half %156, i64 1, !dbg !124
  %157 = load half, ptr addrspace(3) %gep757.2, align 2, !dbg !124, !tbaa !125
  %vb.sroa.0.4.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.2.vec.insert.1, half %157, i64 2, !dbg !124
  %158 = load half, ptr addrspace(3) %gep757.3, align 2, !dbg !124, !tbaa !125
  %vb.sroa.0.6.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.4.vec.insert.1, half %158, i64 3, !dbg !124
  %159 = load half, ptr addrspace(3) %gep757.1839, align 2, !dbg !124, !tbaa !125
  %vb.sroa.7.8.vec.insert.1 = insertelement <4 x half> poison, half %159, i64 0, !dbg !124
  %160 = load half, ptr addrspace(3) %gep757.1.1, align 2, !dbg !124, !tbaa !125
  %vb.sroa.7.10.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.8.vec.insert.1, half %160, i64 1, !dbg !124
  %161 = load half, ptr addrspace(3) %gep757.2.1, align 2, !dbg !124, !tbaa !125
  %vb.sroa.7.12.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.10.vec.insert.1, half %161, i64 2, !dbg !124
  %162 = load half, ptr addrspace(3) %gep757.3.1, align 2, !dbg !124, !tbaa !125
  %vb.sroa.7.14.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.12.vec.insert.1, half %162, i64 3, !dbg !124
  %163 = load half, ptr addrspace(3) %gep757.2845, align 2, !dbg !124, !tbaa !125
  %vb.sroa.12.16.vec.insert.1 = insertelement <4 x half> poison, half %163, i64 0, !dbg !124
  %164 = load half, ptr addrspace(3) %gep757.1.2, align 2, !dbg !124, !tbaa !125
  %vb.sroa.12.18.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.16.vec.insert.1, half %164, i64 1, !dbg !124
  %165 = load half, ptr addrspace(3) %gep757.2.2, align 2, !dbg !124, !tbaa !125
  %vb.sroa.12.20.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.18.vec.insert.1, half %165, i64 2, !dbg !124
  %166 = load half, ptr addrspace(3) %gep757.3.2, align 2, !dbg !124, !tbaa !125
  %vb.sroa.12.22.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.20.vec.insert.1, half %166, i64 3, !dbg !124
  %167 = load half, ptr addrspace(3) %gep757.3851, align 2, !dbg !124, !tbaa !125
  %vb.sroa.17.24.vec.insert.1 = insertelement <4 x half> poison, half %167, i64 0, !dbg !124
  %168 = load half, ptr addrspace(3) %gep757.1.3, align 2, !dbg !124, !tbaa !125
  %vb.sroa.17.26.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.24.vec.insert.1, half %168, i64 1, !dbg !124
  %169 = load half, ptr addrspace(3) %gep757.2.3, align 2, !dbg !124, !tbaa !125
  %vb.sroa.17.28.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.26.vec.insert.1, half %169, i64 2, !dbg !124
  %170 = load half, ptr addrspace(3) %gep757.3.3, align 2, !dbg !124, !tbaa !125
  %vb.sroa.17.30.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.28.vec.insert.1, half %170, i64 3, !dbg !124
  %171 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.0.1), !dbg !126
  %172 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.20.1), !dbg !126
  %173 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.38.1), !dbg !126
  %174 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.56.1), !dbg !126
  br label %if.end465.1, !dbg !127

if.end465.1:                                      ; preds = %for.cond409.preheader.preheader.1, %if.end396.1
  %out.sroa.56.1.1 = phi <4 x float> [ %out.sroa.56.1, %if.end396.1 ], [ %174, %for.cond409.preheader.preheader.1 ], !dbg !81
  %out.sroa.38.1.1 = phi <4 x float> [ %out.sroa.38.1, %if.end396.1 ], [ %173, %for.cond409.preheader.preheader.1 ], !dbg !81
  %out.sroa.20.1.1 = phi <4 x float> [ %out.sroa.20.1, %if.end396.1 ], [ %172, %for.cond409.preheader.preheader.1 ], !dbg !81
  %out.sroa.0.1.1 = phi <4 x float> [ %out.sroa.0.1, %if.end396.1 ], [ %171, %for.cond409.preheader.preheader.1 ], !dbg !81
  %inc467.1 = add nuw nsw i32 %s_1.0761, 2, !dbg !127
  %exitcond.not.1 = icmp eq i32 %inc467.1, 4, !dbg !130
  br i1 %exitcond.not.1, label %for.body473.preheader, label %for.body138, !dbg !61, !llvm.loop !131

for.body473.preheader:                            ; preds = %if.end465.1
  %add477 = fadd contract float %partial_sum.sroa.0.1.1, 0.000000e+00, !dbg !134
  %add477.1 = fadd contract float %add477, %partial_sum.sroa.6.1.1, !dbg !134
  %add477.2 = fadd contract float %add477.1, %partial_sum.sroa.10.1.1, !dbg !134
  %add477.3 = fadd contract float %add477.2, %partial_sum.sroa.14.1.1, !dbg !134
  %175 = bitcast float %add477.3 to i32, !dbg !135
  %176 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #13, !dbg !146
  %177 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %176) #13, !dbg !151
  %xor.i.i = xor i32 %177, 32, !dbg !152
  %178 = and i32 %177, -64, !dbg !153
  %and.i.i = add nsw i32 %178, 64, !dbg !153
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !154
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %177, !dbg !155
  %shl.i.i = shl i32 %cond.i.i, 2, !dbg !156
  %179 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %175), !dbg !157
  %180 = bitcast i32 %179 to float, !dbg !158
  %add.i = fadd contract float %add477.3, %180, !dbg !159
  %181 = bitcast float %add.i to i32, !dbg !162
  %182 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #13, !dbg !169
  %183 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %182) #13, !dbg !172
  %xor.i.i724 = xor i32 %183, 16, !dbg !173
  %184 = and i32 %183, -64, !dbg !174
  %and.i.i725 = add nsw i32 %184, 64, !dbg !174
  %cmp.not.i.i726 = icmp slt i32 %xor.i.i724, %and.i.i725, !dbg !175
  %cond.i.i727 = select i1 %cmp.not.i.i726, i32 %xor.i.i724, i32 %183, !dbg !176
  %shl.i.i728 = shl i32 %cond.i.i727, 2, !dbg !177
  %185 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i728, i32 %181), !dbg !178
  %186 = bitcast i32 %185 to float, !dbg !179
  %add.i.i = fadd contract float %add.i, %186, !dbg !180
  %cmp486 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !182
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !183
  %condval_1.0 = select i1 %cmp486, float %div, float 0.000000e+00, !dbg !183
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 0, !dbg !184
  %mul499 = fmul contract float %condval_1.0, %out.sroa.0.0.vec.extract, !dbg !185
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 1, !dbg !184
  %mul499.1 = fmul contract float %condval_1.0, %out.sroa.0.4.vec.extract, !dbg !185
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 2, !dbg !184
  %mul499.2 = fmul contract float %condval_1.0, %out.sroa.0.8.vec.extract, !dbg !185
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 3, !dbg !184
  %mul499.3 = fmul contract float %condval_1.0, %out.sroa.0.12.vec.extract, !dbg !185
  %out.sroa.20.16.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 0, !dbg !184
  %mul499.4 = fmul contract float %condval_1.0, %out.sroa.20.16.vec.extract, !dbg !185
  %out.sroa.20.20.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 1, !dbg !184
  %mul499.5 = fmul contract float %condval_1.0, %out.sroa.20.20.vec.extract, !dbg !185
  %out.sroa.20.24.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 2, !dbg !184
  %mul499.6 = fmul contract float %condval_1.0, %out.sroa.20.24.vec.extract, !dbg !185
  %out.sroa.20.28.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 3, !dbg !184
  %mul499.7 = fmul contract float %condval_1.0, %out.sroa.20.28.vec.extract, !dbg !185
  %out.sroa.38.32.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 0, !dbg !184
  %mul499.8 = fmul contract float %condval_1.0, %out.sroa.38.32.vec.extract, !dbg !185
  %out.sroa.38.36.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 1, !dbg !184
  %mul499.9 = fmul contract float %condval_1.0, %out.sroa.38.36.vec.extract, !dbg !185
  %out.sroa.38.40.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 2, !dbg !184
  %mul499.10 = fmul contract float %condval_1.0, %out.sroa.38.40.vec.extract, !dbg !185
  %out.sroa.38.44.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 3, !dbg !184
  %mul499.11 = fmul contract float %condval_1.0, %out.sroa.38.44.vec.extract, !dbg !185
  %out.sroa.56.48.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 0, !dbg !184
  %mul499.12 = fmul contract float %condval_1.0, %out.sroa.56.48.vec.extract, !dbg !185
  %out.sroa.56.52.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 1, !dbg !184
  %mul499.13 = fmul contract float %condval_1.0, %out.sroa.56.52.vec.extract, !dbg !185
  %out.sroa.56.56.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 2, !dbg !184
  %mul499.14 = fmul contract float %condval_1.0, %out.sroa.56.56.vec.extract, !dbg !185
  %out.sroa.56.60.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 3, !dbg !184
  %mul499.15 = fmul contract float %condval_1.0, %out.sroa.56.60.vec.extract, !dbg !185
  %187 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul499), !dbg !186
  %result.sroa.0.0.insert.ext = zext i16 %187 to i64, !dbg !190
  %188 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul499.1), !dbg !186
  %result.sroa.0.2.insert.ext = zext i16 %188 to i64, !dbg !190
  %result.sroa.0.2.insert.shift = shl nuw nsw i64 %result.sroa.0.2.insert.ext, 16, !dbg !190
  %result.sroa.0.2.insert.insert = or disjoint i64 %result.sroa.0.2.insert.shift, %result.sroa.0.0.insert.ext, !dbg !190
  %189 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul499.2), !dbg !186
  %result.sroa.0.4.insert.ext = zext i16 %189 to i64, !dbg !190
  %result.sroa.0.4.insert.shift = shl nuw nsw i64 %result.sroa.0.4.insert.ext, 32, !dbg !190
  %result.sroa.0.4.insert.insert = or disjoint i64 %result.sroa.0.2.insert.insert, %result.sroa.0.4.insert.shift, !dbg !190
  %190 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul499.3), !dbg !186
  %result.sroa.0.6.insert.ext = zext i16 %190 to i64, !dbg !190
  %result.sroa.0.6.insert.shift = shl nuw i64 %result.sroa.0.6.insert.ext, 48, !dbg !190
  %result.sroa.0.6.insert.insert = or disjoint i64 %result.sroa.0.4.insert.insert, %result.sroa.0.6.insert.shift, !dbg !190
  %191 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul499.4), !dbg !186
  %result.sroa.7.8.insert.ext = zext i16 %191 to i64, !dbg !190
  %192 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul499.5), !dbg !186
  %result.sroa.7.10.insert.ext = zext i16 %192 to i64, !dbg !190
  %result.sroa.7.10.insert.shift = shl nuw nsw i64 %result.sroa.7.10.insert.ext, 16, !dbg !190
  %result.sroa.7.10.insert.insert = or disjoint i64 %result.sroa.7.10.insert.shift, %result.sroa.7.8.insert.ext, !dbg !190
  %193 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul499.6), !dbg !186
  %result.sroa.7.12.insert.ext = zext i16 %193 to i64, !dbg !190
  %result.sroa.7.12.insert.shift = shl nuw nsw i64 %result.sroa.7.12.insert.ext, 32, !dbg !190
  %result.sroa.7.12.insert.insert = or disjoint i64 %result.sroa.7.10.insert.insert, %result.sroa.7.12.insert.shift, !dbg !190
  %194 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul499.7), !dbg !186
  %result.sroa.7.14.insert.ext = zext i16 %194 to i64, !dbg !190
  %result.sroa.7.14.insert.shift = shl nuw i64 %result.sroa.7.14.insert.ext, 48, !dbg !190
  %result.sroa.7.14.insert.insert = or disjoint i64 %result.sroa.7.12.insert.insert, %result.sroa.7.14.insert.shift, !dbg !190
  %195 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul499.8), !dbg !186
  %result.sroa.12.16.insert.ext = zext i16 %195 to i64, !dbg !190
  %196 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul499.9), !dbg !186
  %result.sroa.12.18.insert.ext = zext i16 %196 to i64, !dbg !190
  %result.sroa.12.18.insert.shift = shl nuw nsw i64 %result.sroa.12.18.insert.ext, 16, !dbg !190
  %result.sroa.12.18.insert.insert = or disjoint i64 %result.sroa.12.18.insert.shift, %result.sroa.12.16.insert.ext, !dbg !190
  %197 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul499.10), !dbg !186
  %result.sroa.12.20.insert.ext = zext i16 %197 to i64, !dbg !190
  %result.sroa.12.20.insert.shift = shl nuw nsw i64 %result.sroa.12.20.insert.ext, 32, !dbg !190
  %result.sroa.12.20.insert.insert = or disjoint i64 %result.sroa.12.18.insert.insert, %result.sroa.12.20.insert.shift, !dbg !190
  %198 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul499.11), !dbg !186
  %result.sroa.12.22.insert.ext = zext i16 %198 to i64, !dbg !190
  %result.sroa.12.22.insert.shift = shl nuw i64 %result.sroa.12.22.insert.ext, 48, !dbg !190
  %result.sroa.12.22.insert.insert = or disjoint i64 %result.sroa.12.20.insert.insert, %result.sroa.12.22.insert.shift, !dbg !190
  %199 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul499.12), !dbg !186
  %result.sroa.17.24.insert.ext = zext i16 %199 to i64, !dbg !190
  %200 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul499.13), !dbg !186
  %result.sroa.17.26.insert.ext = zext i16 %200 to i64, !dbg !190
  %result.sroa.17.26.insert.shift = shl nuw nsw i64 %result.sroa.17.26.insert.ext, 16, !dbg !190
  %result.sroa.17.26.insert.insert = or disjoint i64 %result.sroa.17.26.insert.shift, %result.sroa.17.24.insert.ext, !dbg !190
  %201 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul499.14), !dbg !186
  %result.sroa.17.28.insert.ext = zext i16 %201 to i64, !dbg !190
  %result.sroa.17.28.insert.shift = shl nuw nsw i64 %result.sroa.17.28.insert.ext, 32, !dbg !190
  %result.sroa.17.28.insert.insert = or disjoint i64 %result.sroa.17.26.insert.insert, %result.sroa.17.28.insert.shift, !dbg !190
  %202 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul499.15), !dbg !186
  %result.sroa.17.30.insert.ext = zext i16 %202 to i64, !dbg !190
  %result.sroa.17.30.insert.shift = shl nuw i64 %result.sroa.17.30.insert.ext, 48, !dbg !190
  %result.sroa.17.30.insert.insert = or disjoint i64 %result.sroa.17.28.insert.insert, %result.sroa.17.30.insert.shift, !dbg !190
  fence syncscope("warp") release, !dbg !191
  tail call void @llvm.mxc.barrier.warp(), !dbg !194
  fence syncscope("warp") acquire, !dbg !195
  %shr541 = lshr i32 %2, 5
  %xor545 = xor i32 %shr541, %and216, !dbg !196
  %mul546 = shl nuw nsw i32 %xor545, 3, !dbg !197
  %add547 = add nuw nsw i32 %mul546, %mul9, !dbg !198
  %add552 = or disjoint i32 %add547, %mul426, !dbg !199
  %add.ptr554 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add552, !dbg !200
  store i64 %result.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr554, align 8, !dbg !201
  %add542.1 = add nuw nsw i32 %shr541, 2, !dbg !202
  %xor545.1 = xor i32 %add542.1, %and216, !dbg !196
  %mul546.1 = shl nuw nsw i32 %xor545.1, 3, !dbg !197
  %add547.1 = add nuw nsw i32 %mul546.1, %mul9, !dbg !198
  %add552.1 = or disjoint i32 %add547.1, %mul426, !dbg !199
  %add.ptr554.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add552.1, !dbg !200
  store i64 %result.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr554.1, align 8, !dbg !201
  %add542.2 = add nuw nsw i32 %shr541, 4, !dbg !202
  %xor545.2 = xor i32 %add542.2, %and216, !dbg !196
  %mul546.2 = shl nuw nsw i32 %xor545.2, 3, !dbg !197
  %add547.2 = add nuw nsw i32 %mul546.2, %mul9, !dbg !198
  %add552.2 = or disjoint i32 %add547.2, %mul426, !dbg !199
  %add.ptr554.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add552.2, !dbg !200
  store i64 %result.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr554.2, align 8, !dbg !201
  %add542.3 = add nuw nsw i32 %shr541, 6, !dbg !202
  %xor545.3 = xor i32 %add542.3, %and216, !dbg !196
  %mul546.3 = shl nuw nsw i32 %xor545.3, 3, !dbg !197
  %add547.3 = add nuw nsw i32 %mul546.3, %mul9, !dbg !198
  %add552.3 = or disjoint i32 %add547.3, %mul426, !dbg !199
  %add.ptr554.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add552.3, !dbg !200
  store i64 %result.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr554.3, align 8, !dbg !201
  fence syncscope("warp") release, !dbg !203
  tail call void @llvm.mxc.barrier.warp(), !dbg !206
  fence syncscope("warp") acquire, !dbg !207
  %add582 = add nuw nsw i32 %add, %39
  %203 = zext nneg i32 %add582 to i64, !dbg !208
  %add.ptr587 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %203, !dbg !209
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr587, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep737, i64 16, i1 false), !dbg !210, !tbaa.struct !211, !call_argsrelate !212
  %gep771.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep737, i32 1024, !dbg !213
  %204 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %203, !dbg !209
  %add.ptr587.1 = getelementptr inbounds i8, ptr addrspace(1) %204, i64 1024, !dbg !209
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr587.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep771.1, i64 16, i1 false), !dbg !210, !tbaa.struct !211, !call_argsrelate !212
  call void @llvm.lifetime.end.p5(i64 16, ptr addrspace(5) %blocks) #12, !dbg !214, !call_argsrelate !43
  ret void, !dbg !214
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
declare void @llvm.mxc.barrier.warp() #7

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp.f32(float) #8

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare i16 @llvm.convert.to.fp16.f32(float) #9

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
declare void @llvm.mxc.sleep(i32 immarg) #10

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.minnum.f32(float, float) #8

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #11

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #5 = { convergent nounwind willreturn memory(none) }
attributes #6 = { nounwind speculatable willreturn memory(none) }
attributes #7 = { convergent nounwind willreturn }
attributes #8 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #9 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #10 = { nounwind willreturn }
attributes #11 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #12 = { nounwind }
attributes #13 = { nomerge }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmp0e9rkjvi/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmp0e9rkjvi/tvm_kernels.maca", directory: "")
!42 = !DILocation(line: 13, column: 3, scope: !40)
!43 = !{i32 -1, i32 0}
!44 = !{i32 0, i32 1024}
!45 = !DILocation(line: 26, column: 3, scope: !40)
!46 = !DILocation(line: 27, column: 42, scope: !40)
!47 = !DILocation(line: 27, column: 28, scope: !40)
!48 = !DILocation(line: 30, column: 3, scope: !40)
!49 = !DILocation(line: 31, column: 17, scope: !40)
!50 = !DILocation(line: 31, column: 15, scope: !40)
!51 = !DILocation(line: 31, column: 78, scope: !40)
!52 = !DILocation(line: 31, column: 5, scope: !40)
!53 = !DILocation(line: 34, column: 27, scope: !40)
!54 = !DILocation(line: 36, column: 5, scope: !40)
!55 = !DILocation(line: 39, column: 71, scope: !40)
!56 = !DILocation(line: 39, column: 50, scope: !40)
!57 = !DILocation(line: 39, column: 215, scope: !40)
!58 = !DILocation(line: 46, column: 75, scope: !40)
!59 = !DILocation(line: 46, column: 54, scope: !40)
!60 = !DILocation(line: 51, column: 3, scope: !40)
!61 = !DILocation(line: 58, column: 3, scope: !40)
!62 = !DILocation(line: 53, column: 33, scope: !40)
!63 = !DILocation(line: 56, column: 31, scope: !40)
!64 = !DILocation(line: 59, column: 17, scope: !40)
!65 = !DILocation(line: 60, column: 23, scope: !40)
!66 = !DILocation(line: 63, column: 161, scope: !40)
!67 = !DILocation(line: 65, column: 39, scope: !40)
!68 = !DILocation(line: 65, column: 45, scope: !40)
!69 = !DILocation(line: 65, column: 29, scope: !40)
!70 = !DILocation(line: 65, column: 11, scope: !40)
!71 = !DILocation(line: 69, column: 73, scope: !40)
!72 = !DILocation(line: 69, column: 15, scope: !40)
!73 = !DILocation(line: 74, column: 23, scope: !40)
!74 = !DILocation(line: 69, column: 66, scope: !40)
!75 = !DILocation(line: 68, column: 3, scope: !76, inlinedAt: !78)
!76 = distinct !DISubprogram(name: "__barrier_warp", scope: !77, file: !77, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!77 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!78 = distinct !DILocation(line: 192, column: 3, scope: !79, inlinedAt: !80)
!79 = distinct !DISubprogram(name: "__syncwarp", scope: !77, file: !77, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!80 = distinct !DILocation(line: 80, column: 7, scope: !40)
!81 = !DILocation(line: 0, scope: !40)
!82 = !DILocation(line: 69, column: 3, scope: !76, inlinedAt: !78)
!83 = !DILocation(line: 70, column: 3, scope: !76, inlinedAt: !78)
!84 = !DILocation(line: 82, column: 27, scope: !40)
!85 = !DILocation(line: 85, column: 37, scope: !40)
!86 = !{i32 -1, i32 3, i32 -1}
!87 = !DILocation(line: 93, column: 170, scope: !40)
!88 = !DILocation(line: 97, column: 33, scope: !40)
!89 = !DILocation(line: 97, column: 45, scope: !40)
!90 = !DILocation(line: 354, column: 10, scope: !91, inlinedAt: !93)
!91 = distinct !DISubprogram(name: "min", scope: !92, file: !92, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!92 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!93 = distinct !DILocation(line: 97, column: 28, scope: !40)
!94 = !DILocation(line: 288, column: 10, scope: !95, inlinedAt: !96)
!95 = distinct !DISubprogram(name: "expf", scope: !92, file: !92, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!96 = distinct !DILocation(line: 97, column: 23, scope: !40)
!97 = !DILocation(line: 98, column: 46, scope: !40)
!98 = !DILocation(line: 75, column: 10, scope: !99, inlinedAt: !101)
!99 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !100, file: !100, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!100 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!101 = distinct !DILocation(line: 984, column: 9, scope: !102, inlinedAt: !104)
!102 = distinct !DISubprogram(name: "__float2half", scope: !103, file: !103, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!103 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!104 = distinct !DILocation(line: 133, column: 53, scope: !105, inlinedAt: !106)
!105 = distinct !DISubprogram(name: "__half", scope: !103, file: !103, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!106 = distinct !DILocation(line: 102, column: 23, scope: !40)
!107 = !DILocation(line: 102, column: 20, scope: !40)
!108 = !DILocation(line: 68, column: 3, scope: !76, inlinedAt: !109)
!109 = distinct !DILocation(line: 192, column: 3, scope: !79, inlinedAt: !110)
!110 = distinct !DILocation(line: 104, column: 7, scope: !40)
!111 = !DILocation(line: 69, column: 3, scope: !76, inlinedAt: !109)
!112 = !DILocation(line: 70, column: 3, scope: !76, inlinedAt: !109)
!113 = !DILocation(line: 105, column: 5, scope: !40)
!114 = !DILocation(line: 107, column: 36, scope: !40)
!115 = !DILocation(line: 107, column: 24, scope: !40)
!116 = !DILocation(line: 108, column: 30, scope: !40)
!117 = !DILocation(line: 110, column: 9, scope: !40)
!118 = !DILocation(line: 113, column: 79, scope: !40)
!119 = !DILocation(line: 113, column: 58, scope: !40)
!120 = !DILocation(line: 113, column: 224, scope: !40)
!121 = !DILocation(line: 120, column: 79, scope: !40)
!122 = !DILocation(line: 120, column: 58, scope: !40)
!123 = !DILocation(line: 125, column: 23, scope: !40)
!124 = !DILocation(line: 128, column: 36, scope: !40)
!125 = !{!26, !26, i64 0}
!126 = !DILocation(line: 133, column: 36, scope: !40)
!127 = !DILocation(line: 58, column: 30, scope: !40)
!128 = !DILocation(line: 106, column: 13, scope: !40)
!129 = !DILocation(line: 106, column: 9, scope: !40)
!130 = !DILocation(line: 58, column: 25, scope: !40)
!131 = distinct !{!131, !61, !132, !32, !133}
!132 = !DILocation(line: 139, column: 3, scope: !40)
!133 = !{!"llvm.loop.unroll.disable"}
!134 = !DILocation(line: 143, column: 26, scope: !40)
!135 = !DILocation(line: 1018, column: 9, scope: !136, inlinedAt: !137)
!136 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !77, file: !77, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!137 = distinct !DILocation(line: 396, column: 10, scope: !138, inlinedAt: !140)
!138 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !139, file: !139, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!139 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!140 = distinct !DILocation(line: 129, column: 24, scope: !141, inlinedAt: !143)
!141 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !142, file: !142, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!142 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!143 = distinct !DILocation(line: 101, column: 14, scope: !144, inlinedAt: !145)
!144 = distinct !DISubprogram(name: "run<float>", scope: !142, file: !142, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!145 = distinct !DILocation(line: 145, column: 14, scope: !40)
!146 = !DILocation(line: 171, column: 37, scope: !147, inlinedAt: !148)
!147 = distinct !DISubprogram(name: "__lane_id", scope: !77, file: !77, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!148 = distinct !DILocation(line: 990, column: 14, scope: !149, inlinedAt: !150)
!149 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !77, file: !77, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!150 = distinct !DILocation(line: 1019, column: 11, scope: !136, inlinedAt: !137)
!151 = !DILocation(line: 171, column: 10, scope: !147, inlinedAt: !148)
!152 = !DILocation(line: 991, column: 20, scope: !149, inlinedAt: !150)
!153 = !DILocation(line: 992, column: 36, scope: !149, inlinedAt: !150)
!154 = !DILocation(line: 992, column: 17, scope: !149, inlinedAt: !150)
!155 = !DILocation(line: 992, column: 11, scope: !149, inlinedAt: !150)
!156 = !DILocation(line: 993, column: 43, scope: !149, inlinedAt: !150)
!157 = !DILocation(line: 993, column: 10, scope: !149, inlinedAt: !150)
!158 = !DILocation(line: 1020, column: 14, scope: !136, inlinedAt: !137)
!159 = !DILocation(line: 25, column: 14, scope: !160, inlinedAt: !161)
!160 = distinct !DISubprogram(name: "operator()<float>", scope: !142, file: !142, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!161 = distinct !DILocation(line: 129, column: 11, scope: !141, inlinedAt: !143)
!162 = !DILocation(line: 1018, column: 9, scope: !136, inlinedAt: !163)
!163 = distinct !DILocation(line: 396, column: 10, scope: !138, inlinedAt: !164)
!164 = distinct !DILocation(line: 129, column: 24, scope: !165, inlinedAt: !166)
!165 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !142, file: !142, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!166 = distinct !DILocation(line: 101, column: 14, scope: !167, inlinedAt: !168)
!167 = distinct !DISubprogram(name: "run<float>", scope: !142, file: !142, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!168 = distinct !DILocation(line: 134, column: 14, scope: !141, inlinedAt: !143)
!169 = !DILocation(line: 171, column: 37, scope: !147, inlinedAt: !170)
!170 = distinct !DILocation(line: 990, column: 14, scope: !149, inlinedAt: !171)
!171 = distinct !DILocation(line: 1019, column: 11, scope: !136, inlinedAt: !163)
!172 = !DILocation(line: 171, column: 10, scope: !147, inlinedAt: !170)
!173 = !DILocation(line: 991, column: 20, scope: !149, inlinedAt: !171)
!174 = !DILocation(line: 992, column: 36, scope: !149, inlinedAt: !171)
!175 = !DILocation(line: 992, column: 17, scope: !149, inlinedAt: !171)
!176 = !DILocation(line: 992, column: 11, scope: !149, inlinedAt: !171)
!177 = !DILocation(line: 993, column: 43, scope: !149, inlinedAt: !171)
!178 = !DILocation(line: 993, column: 10, scope: !149, inlinedAt: !171)
!179 = !DILocation(line: 1020, column: 14, scope: !136, inlinedAt: !163)
!180 = !DILocation(line: 25, column: 14, scope: !160, inlinedAt: !181)
!181 = distinct !DILocation(line: 129, column: 11, scope: !165, inlinedAt: !166)
!182 = !DILocation(line: 147, column: 32, scope: !40)
!183 = !DILocation(line: 147, column: 7, scope: !40)
!184 = !DILocation(line: 155, column: 17, scope: !40)
!185 = !DILocation(line: 155, column: 26, scope: !40)
!186 = !DILocation(line: 75, column: 10, scope: !99, inlinedAt: !187)
!187 = distinct !DILocation(line: 984, column: 9, scope: !102, inlinedAt: !188)
!188 = distinct !DILocation(line: 133, column: 53, scope: !105, inlinedAt: !189)
!189 = distinct !DILocation(line: 161, column: 41, scope: !40)
!190 = !DILocation(line: 161, column: 38, scope: !40)
!191 = !DILocation(line: 68, column: 3, scope: !76, inlinedAt: !192)
!192 = distinct !DILocation(line: 192, column: 3, scope: !79, inlinedAt: !193)
!193 = distinct !DILocation(line: 164, column: 3, scope: !40)
!194 = !DILocation(line: 69, column: 3, scope: !76, inlinedAt: !192)
!195 = !DILocation(line: 70, column: 3, scope: !76, inlinedAt: !192)
!196 = !DILocation(line: 167, column: 121, scope: !40)
!197 = !DILocation(line: 167, column: 149, scope: !40)
!198 = !DILocation(line: 167, column: 77, scope: !40)
!199 = !DILocation(line: 167, column: 155, scope: !40)
!200 = !DILocation(line: 167, column: 40, scope: !40)
!201 = !DILocation(line: 167, column: 198, scope: !40)
!202 = !DILocation(line: 167, column: 92, scope: !40)
!203 = !DILocation(line: 68, column: 3, scope: !76, inlinedAt: !204)
!204 = distinct !DILocation(line: 192, column: 3, scope: !79, inlinedAt: !205)
!205 = distinct !DILocation(line: 169, column: 3, scope: !40)
!206 = !DILocation(line: 69, column: 3, scope: !76, inlinedAt: !204)
!207 = !DILocation(line: 70, column: 3, scope: !76, inlinedAt: !204)
!208 = !DILocation(line: 171, column: 3, scope: !40)
!209 = !DILocation(line: 172, column: 22, scope: !40)
!210 = !DILocation(line: 172, column: 128, scope: !40)
!211 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!212 = !{i32 2, i32 -1, i32 -1, i32 -1}
!213 = !DILocation(line: 172, column: 165, scope: !40)
!214 = !DILocation(line: 174, column: 1, scope: !40)
