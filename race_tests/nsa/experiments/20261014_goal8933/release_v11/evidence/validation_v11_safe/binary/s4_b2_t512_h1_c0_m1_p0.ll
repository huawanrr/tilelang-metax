; ModuleID = '/data/tilelang-metax/race_tests/nsa/experiments/20261014_goal8933/validation_v11_safe/binary/s4_b2_t512_h1_c0_m1_p0.bc'
source_filename = "/tmp/tmpvxjvv3x2/tvm_kernels.maca"
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
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.y(), !range !29
  %mul = shl nsw i32 %0, 19
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
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
  %mul25 = shl nsw i32 %0, 11
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
  %or.cond = icmp ult i32 %7, 32, !dbg !53
  br i1 %or.cond, label %for.cond38.preheader, label %entry.if.end_crit_edge, !dbg !53

entry.if.end_crit_edge:                           ; preds = %entry
  %.pre = shl nuw nsw i32 %2, 3
  %.pre908 = shl nsw i32 %0, 15
  %.pre909 = or disjoint i32 %.pre, %.pre908
  br label %if.end, !dbg !53

for.cond38.preheader:                             ; preds = %entry
  %mul48 = shl nsw i32 %0, 15
  %mul49 = shl nuw nsw i32 %7, 10
  %mul54 = shl nuw nsw i32 %2, 3
  %add50 = or disjoint i32 %mul54, %mul48
  %add52 = add nuw nsw i32 %add50, %mul49
  %14 = zext nneg i32 %add52 to i64, !dbg !54
  %add.ptr59 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %14, !dbg !55
  %15 = load i32, ptr addrspace(4) %add.ptr59, align 4, !dbg !56, !tbaa !30
  %16 = or disjoint i64 %14, 2, !dbg !57
  %add.ptr59.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %16, !dbg !55
  %17 = load i32, ptr addrspace(4) %add.ptr59.1, align 4, !dbg !56, !tbaa !30
  %18 = or disjoint i64 %14, 4, !dbg !57
  %add.ptr59.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %18, !dbg !55
  %19 = load i32, ptr addrspace(4) %add.ptr59.2, align 4, !dbg !56, !tbaa !30
  %20 = or disjoint i64 %14, 6, !dbg !57
  %add.ptr59.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %20, !dbg !55
  %21 = load i32, ptr addrspace(4) %add.ptr59.3, align 4, !dbg !56, !tbaa !30
  %22 = add nuw nsw i64 %14, 512
  %add.ptr59.1718 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %22, !dbg !55
  %23 = load i32, ptr addrspace(4) %add.ptr59.1718, align 4, !dbg !56, !tbaa !30
  %24 = add nuw nsw i64 %14, 514, !dbg !57
  %add.ptr59.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %24, !dbg !55
  %25 = load i32, ptr addrspace(4) %add.ptr59.1.1, align 4, !dbg !56, !tbaa !30
  %26 = add nuw nsw i64 %14, 516, !dbg !57
  %add.ptr59.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %26, !dbg !55
  %27 = load i32, ptr addrspace(4) %add.ptr59.2.1, align 4, !dbg !56, !tbaa !30
  %28 = add nuw nsw i64 %14, 518, !dbg !57
  %add.ptr59.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %28, !dbg !55
  %29 = load i32, ptr addrspace(4) %add.ptr59.3.1, align 4, !dbg !56, !tbaa !30
  %add.ptr92 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %14, !dbg !58
  %30 = load i32, ptr addrspace(4) %add.ptr92, align 4, !dbg !59, !tbaa !30
  %add.ptr92.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %16, !dbg !58
  %31 = load i32, ptr addrspace(4) %add.ptr92.1, align 4, !dbg !59, !tbaa !30
  %add.ptr92.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %18, !dbg !58
  %32 = load i32, ptr addrspace(4) %add.ptr92.2, align 4, !dbg !59, !tbaa !30
  %add.ptr92.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %20, !dbg !58
  %33 = load i32, ptr addrspace(4) %add.ptr92.3, align 4, !dbg !59, !tbaa !30
  %add.ptr92.1730 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %22, !dbg !58
  %34 = load i32, ptr addrspace(4) %add.ptr92.1730, align 4, !dbg !59, !tbaa !30
  %add.ptr92.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %24, !dbg !58
  %35 = load i32, ptr addrspace(4) %add.ptr92.1.1, align 4, !dbg !59, !tbaa !30
  %add.ptr92.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %26, !dbg !58
  %36 = load i32, ptr addrspace(4) %add.ptr92.2.1, align 4, !dbg !59, !tbaa !30
  %add.ptr92.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %28, !dbg !58
  %37 = load i32, ptr addrspace(4) %add.ptr92.3.1, align 4, !dbg !59, !tbaa !30
  br label %if.end, !dbg !60

if.end:                                           ; preds = %entry.if.end_crit_edge, %for.cond38.preheader
  %add281.pre-phi = phi i32 [ %.pre909, %entry.if.end_crit_edge ], [ %add50, %for.cond38.preheader ]
  %.pre-phi = phi i32 [ %.pre, %entry.if.end_crit_edge ], [ %mul54, %for.cond38.preheader ]
  %k.sroa.18.0 = phi i32 [ undef, %entry.if.end_crit_edge ], [ %29, %for.cond38.preheader ]
  %k.sroa.16.0 = phi i32 [ undef, %entry.if.end_crit_edge ], [ %27, %for.cond38.preheader ]
  %k.sroa.14.0 = phi i32 [ undef, %entry.if.end_crit_edge ], [ %25, %for.cond38.preheader ]
  %k.sroa.11.0 = phi i32 [ undef, %entry.if.end_crit_edge ], [ %23, %for.cond38.preheader ]
  %k.sroa.9.0 = phi i32 [ undef, %entry.if.end_crit_edge ], [ %21, %for.cond38.preheader ]
  %k.sroa.7.0 = phi i32 [ undef, %entry.if.end_crit_edge ], [ %19, %for.cond38.preheader ]
  %k.sroa.5.0 = phi i32 [ undef, %entry.if.end_crit_edge ], [ %17, %for.cond38.preheader ]
  %k.sroa.0.0 = phi i32 [ undef, %entry.if.end_crit_edge ], [ %15, %for.cond38.preheader ]
  %v.sroa.18.0 = phi i32 [ undef, %entry.if.end_crit_edge ], [ %37, %for.cond38.preheader ]
  %v.sroa.16.0 = phi i32 [ undef, %entry.if.end_crit_edge ], [ %36, %for.cond38.preheader ]
  %v.sroa.14.0 = phi i32 [ undef, %entry.if.end_crit_edge ], [ %35, %for.cond38.preheader ]
  %v.sroa.11.0 = phi i32 [ undef, %entry.if.end_crit_edge ], [ %34, %for.cond38.preheader ]
  %v.sroa.9.0 = phi i32 [ undef, %entry.if.end_crit_edge ], [ %33, %for.cond38.preheader ]
  %v.sroa.7.0 = phi i32 [ undef, %entry.if.end_crit_edge ], [ %32, %for.cond38.preheader ]
  %v.sroa.5.0 = phi i32 [ undef, %entry.if.end_crit_edge ], [ %31, %for.cond38.preheader ]
  %v.sroa.0.0 = phi i32 [ undef, %entry.if.end_crit_edge ], [ %30, %for.cond38.preheader ]
  %mul142 = and i32 %.pre-phi, 8128
  %xor641 = and i32 %.pre-phi, 56
  %call146.masked = and i32 %2, 1016
  %mul148 = xor i32 %xor641, %call146.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul142
  %invariant.gep664 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul148
  %shr168 = lshr i32 %2, 4
  %and171 = and i32 %2, 7
  %38 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul9
  %invariant.gep675 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep664, i32 2048
  %39 = shl nuw nsw i32 %2, 4
  %mul352 = and i32 %39, 16128
  %and357 = lshr i32 %2, 3
  %shr358 = and i32 %and357, 1
  %40 = lshr i32 %2, 2
  %mul363 = and i32 %40, 4
  %k.sroa.5.0.invariant.gep664.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep664, i32 4
  %k.sroa.7.0.invariant.gep664.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep664, i32 8
  %k.sroa.9.0.invariant.gep664.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep664, i32 12
  %gep665.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep664, i32 1024
  %k.sroa.14.16.gep665.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep664, i32 1028
  %k.sroa.16.16.gep665.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep664, i32 1032
  %k.sroa.18.16.gep665.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep664, i32 1036
  %xor172 = xor i32 %shr168, %and171
  %add.ptr176.idx = shl nuw nsw i32 %xor172, 4
  %add.ptr176 = getelementptr inbounds i8, ptr addrspace(3) %38, i32 %add.ptr176.idx
  %kb.sroa.6.0.add.ptr176.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr176, i32 8
  %add169.1 = add nuw nsw i32 %shr168, 4
  %xor172.1 = xor i32 %add169.1, %and171
  %add.ptr176.idx.1 = shl nuw nsw i32 %xor172.1, 4
  %add.ptr176.1 = getelementptr inbounds i8, ptr addrspace(3) %38, i32 %add.ptr176.idx.1
  %kb.sroa.6.0.add.ptr176.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr176.1, i32 8
  %v.sroa.5.0.invariant.gep675.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep664, i32 2052
  %v.sroa.7.0.invariant.gep675.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep664, i32 2056
  %v.sroa.9.0.invariant.gep675.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep664, i32 2060
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep664, i32 3072
  %v.sroa.14.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep664, i32 3076
  %v.sroa.16.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep664, i32 3080
  %v.sroa.18.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep664, i32 3084
  %xor365 = or disjoint i32 %mul363, %shr358
  %mul366 = shl nuw nsw i32 %xor365, 3
  %add367 = or disjoint i32 %mul366, %mul352
  %add370 = or disjoint i32 %add367, %and171
  %gep683 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add370
  %add354.1 = or disjoint i32 %mul352, 64
  %add364.1 = or disjoint i32 %mul363, 1
  %xor365.1 = xor i32 %add364.1, %shr358
  %mul366.1 = shl nuw nsw i32 %xor365.1, 3
  %add367.1 = or disjoint i32 %mul366.1, %add354.1
  %add370.1 = or disjoint i32 %add367.1, %and171
  %gep683.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add370.1
  %add354.2 = or disjoint i32 %mul352, 128
  %add364.2 = or disjoint i32 %mul363, 2
  %xor365.2 = or disjoint i32 %add364.2, %shr358
  %mul366.2 = shl nuw nsw i32 %xor365.2, 3
  %add367.2 = or disjoint i32 %mul366.2, %add354.2
  %add370.2 = or disjoint i32 %add367.2, %and171
  %gep683.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add370.2
  %add354.3 = or disjoint i32 %mul352, 192
  %add364.3 = or disjoint i32 %mul363, 3
  %xor365.3 = xor i32 %add364.3, %shr358
  %mul366.3 = shl nuw nsw i32 %xor365.3, 3
  %add367.3 = or disjoint i32 %mul366.3, %add354.3
  %add370.3 = or disjoint i32 %add367.3, %and171
  %gep683.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add370.3
  %add359.1 = or disjoint i32 %shr358, 2
  %xor365.1758 = or disjoint i32 %mul363, %add359.1
  %mul366.1759 = shl nuw nsw i32 %xor365.1758, 3
  %add367.1760 = or disjoint i32 %mul366.1759, %mul352
  %add370.1761 = or disjoint i32 %add367.1760, %and171
  %gep683.1762 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add370.1761
  %xor365.1.1 = xor i32 %add364.1, %add359.1
  %mul366.1.1 = shl nuw nsw i32 %xor365.1.1, 3
  %add367.1.1 = or disjoint i32 %mul366.1.1, %add354.1
  %add370.1.1 = or disjoint i32 %add367.1.1, %and171
  %gep683.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add370.1.1
  %xor365.2.1 = xor i32 %add364.2, %add359.1
  %mul366.2.1 = shl nuw nsw i32 %xor365.2.1, 3
  %add367.2.1 = or disjoint i32 %mul366.2.1, %add354.2
  %add370.2.1 = or disjoint i32 %add367.2.1, %and171
  %gep683.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add370.2.1
  %xor365.3.1 = xor i32 %add364.3, %add359.1
  %mul366.3.1 = shl nuw nsw i32 %xor365.3.1, 3
  %add367.3.1 = or disjoint i32 %mul366.3.1, %add354.3
  %add370.3.1 = or disjoint i32 %add367.3.1, %and171
  %gep683.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add370.3.1
  %add359.2 = or disjoint i32 %shr358, 4
  %xor365.2764 = xor i32 %mul363, %add359.2
  %mul366.2765 = shl nuw nsw i32 %xor365.2764, 3
  %add367.2766 = or disjoint i32 %mul366.2765, %mul352
  %add370.2767 = or disjoint i32 %add367.2766, %and171
  %gep683.2768 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add370.2767
  %xor365.1.2 = xor i32 %add364.1, %add359.2
  %mul366.1.2 = shl nuw nsw i32 %xor365.1.2, 3
  %add367.1.2 = or disjoint i32 %mul366.1.2, %add354.1
  %add370.1.2 = or disjoint i32 %add367.1.2, %and171
  %gep683.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add370.1.2
  %xor365.2.2 = xor i32 %add364.2, %add359.2
  %mul366.2.2 = shl nuw nsw i32 %xor365.2.2, 3
  %add367.2.2 = or disjoint i32 %mul366.2.2, %add354.2
  %add370.2.2 = or disjoint i32 %add367.2.2, %and171
  %gep683.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add370.2.2
  %xor365.3.2 = xor i32 %add364.3, %add359.2
  %mul366.3.2 = shl nuw nsw i32 %xor365.3.2, 3
  %add367.3.2 = or disjoint i32 %mul366.3.2, %add354.3
  %add370.3.2 = or disjoint i32 %add367.3.2, %and171
  %gep683.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add370.3.2
  %add359.3 = or disjoint i32 %shr358, 6
  %xor365.3770 = xor i32 %mul363, %add359.3
  %mul366.3771 = shl nuw nsw i32 %xor365.3770, 3
  %add367.3772 = or disjoint i32 %mul366.3771, %mul352
  %add370.3773 = or disjoint i32 %add367.3772, %and171
  %gep683.3774 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add370.3773
  %xor365.1.3 = xor i32 %add364.1, %add359.3
  %mul366.1.3 = shl nuw nsw i32 %xor365.1.3, 3
  %add367.1.3 = or disjoint i32 %mul366.1.3, %add354.1
  %add370.1.3 = or disjoint i32 %add367.1.3, %and171
  %gep683.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add370.1.3
  %xor365.2.3 = xor i32 %add364.2, %add359.3
  %mul366.2.3 = shl nuw nsw i32 %xor365.2.3, 3
  %add367.2.3 = or disjoint i32 %mul366.2.3, %add354.2
  %add370.2.3 = or disjoint i32 %add367.2.3, %and171
  %gep683.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add370.2.3
  %xor365.3.3 = xor i32 %add364.3, %add359.3
  %mul366.3.3 = shl nuw nsw i32 %xor365.3.3, 3
  %add367.3.3 = or disjoint i32 %mul366.3.3, %add354.3
  %add370.3.3 = or disjoint i32 %add367.3.3, %and171
  %gep683.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add370.3.3
  br label %for.body124, !dbg !61

for.body124:                                      ; preds = %if.end402.1, %if.end
  %k.sroa.18.1 = phi i32 [ %k.sroa.18.0, %if.end ], [ %k.sroa.18.2.1, %if.end402.1 ], !dbg !56
  %k.sroa.16.1 = phi i32 [ %k.sroa.16.0, %if.end ], [ %k.sroa.16.2.1, %if.end402.1 ], !dbg !56
  %k.sroa.14.1 = phi i32 [ %k.sroa.14.0, %if.end ], [ %k.sroa.14.2.1, %if.end402.1 ], !dbg !56
  %k.sroa.11.1 = phi i32 [ %k.sroa.11.0, %if.end ], [ %k.sroa.11.2.1, %if.end402.1 ], !dbg !56
  %k.sroa.9.1 = phi i32 [ %k.sroa.9.0, %if.end ], [ %k.sroa.9.2.1, %if.end402.1 ], !dbg !56
  %k.sroa.7.1 = phi i32 [ %k.sroa.7.0, %if.end ], [ %k.sroa.7.2.1, %if.end402.1 ], !dbg !56
  %k.sroa.5.1 = phi i32 [ %k.sroa.5.0, %if.end ], [ %k.sroa.5.2.1, %if.end402.1 ], !dbg !56
  %k.sroa.0.1 = phi i32 [ %k.sroa.0.0, %if.end ], [ %k.sroa.0.2.1, %if.end402.1 ], !dbg !56
  %v.sroa.18.1 = phi i32 [ %v.sroa.18.0, %if.end ], [ %v.sroa.18.2.1, %if.end402.1 ], !dbg !59
  %v.sroa.16.1 = phi i32 [ %v.sroa.16.0, %if.end ], [ %v.sroa.16.2.1, %if.end402.1 ], !dbg !59
  %v.sroa.14.1 = phi i32 [ %v.sroa.14.0, %if.end ], [ %v.sroa.14.2.1, %if.end402.1 ], !dbg !59
  %v.sroa.11.1 = phi i32 [ %v.sroa.11.0, %if.end ], [ %v.sroa.11.2.1, %if.end402.1 ], !dbg !59
  %v.sroa.9.1 = phi i32 [ %v.sroa.9.0, %if.end ], [ %v.sroa.9.2.1, %if.end402.1 ], !dbg !59
  %v.sroa.7.1 = phi i32 [ %v.sroa.7.0, %if.end ], [ %v.sroa.7.2.1, %if.end402.1 ], !dbg !59
  %v.sroa.5.1 = phi i32 [ %v.sroa.5.0, %if.end ], [ %v.sroa.5.2.1, %if.end402.1 ], !dbg !59
  %v.sroa.0.1 = phi i32 [ %v.sroa.0.0, %if.end ], [ %v.sroa.0.2.1, %if.end402.1 ], !dbg !59
  %out.sroa.56.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.56.1.1, %if.end402.1 ], !dbg !62
  %out.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.38.1.1, %if.end402.1 ], !dbg !62
  %out.sroa.20.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.20.1.1, %if.end402.1 ], !dbg !62
  %out.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.0.1.1, %if.end402.1 ], !dbg !62
  %partial_sum.sroa.14.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.14.1.1, %if.end402.1 ], !dbg !62
  %partial_sum.sroa.10.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.10.1.1, %if.end402.1 ], !dbg !62
  %partial_sum.sroa.6.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.6.1.1, %if.end402.1 ], !dbg !62
  %partial_sum.sroa.0.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.0.1.1, %if.end402.1 ], !dbg !62
  %prob.sroa.0.0 = phi <4 x half> [ undef, %if.end ], [ %prob.sroa.0.1.1, %if.end402.1 ]
  %s_1.0687 = phi i32 [ 0, %if.end ], [ %inc404.1, %if.end402.1 ]
  %arrayidx126 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %s_1.0687, !dbg !63
  %41 = load i32, ptr addrspace(5) %arrayidx126, align 4, !dbg !63, !tbaa !30
  %or.cond699 = icmp ult i32 %41, 32, !dbg !64
  br i1 %or.cond699, label %for.body134.preheader, label %if.then262, !dbg !64

for.body134.preheader:                            ; preds = %for.body124
  store i32 %k.sroa.0.1, ptr addrspace(3) %invariant.gep664, align 16, !dbg !65, !tbaa !30
  store i32 %k.sroa.5.1, ptr addrspace(3) %k.sroa.5.0.invariant.gep664.sroa_idx, align 4, !dbg !65, !tbaa !30
  store i32 %k.sroa.7.1, ptr addrspace(3) %k.sroa.7.0.invariant.gep664.sroa_idx, align 8, !dbg !65, !tbaa !30
  store i32 %k.sroa.9.1, ptr addrspace(3) %k.sroa.9.0.invariant.gep664.sroa_idx, align 4, !dbg !65, !tbaa !30
  store i32 %k.sroa.11.1, ptr addrspace(3) %gep665.1, align 16, !dbg !65, !tbaa !30
  store i32 %k.sroa.14.1, ptr addrspace(3) %k.sroa.14.16.gep665.1.sroa_idx, align 4, !dbg !65, !tbaa !30
  store i32 %k.sroa.16.1, ptr addrspace(3) %k.sroa.16.16.gep665.1.sroa_idx, align 8, !dbg !65, !tbaa !30
  store i32 %k.sroa.18.1, ptr addrspace(3) %k.sroa.18.16.gep665.1.sroa_idx, align 4, !dbg !65, !tbaa !30
  fence syncscope("warp") release, !dbg !66
  tail call void @llvm.mxc.barrier.warp(), !dbg !72
  fence syncscope("warp") acquire, !dbg !73
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr176, align 16, !dbg !74
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr176.sroa_idx, align 8, !dbg !74
  %42 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !75, !call_argsrelate !76
  %43 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %42), !dbg !75, !call_argsrelate !76
  %kb.sroa.0.0.copyload791 = load <4 x half>, ptr addrspace(3) %add.ptr176.1, align 16, !dbg !74
  %kb.sroa.6.0.copyload792 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr176.1.sroa_idx, align 8, !dbg !74
  %44 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload791, <4 x half> %q.sroa.5.16.copyload, <4 x float> %43), !dbg !75, !call_argsrelate !76
  %45 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload792, <4 x half> %q.sroa.7.16.copyload, <4 x float> %44), !dbg !75, !call_argsrelate !76
  store i32 %v.sroa.0.1, ptr addrspace(3) %invariant.gep675, align 16, !dbg !77, !tbaa !30
  store i32 %v.sroa.5.1, ptr addrspace(3) %v.sroa.5.0.invariant.gep675.sroa_idx, align 4, !dbg !77, !tbaa !30
  store i32 %v.sroa.7.1, ptr addrspace(3) %v.sroa.7.0.invariant.gep675.sroa_idx, align 8, !dbg !77, !tbaa !30
  store i32 %v.sroa.9.1, ptr addrspace(3) %v.sroa.9.0.invariant.gep675.sroa_idx, align 4, !dbg !77, !tbaa !30
  store i32 %v.sroa.11.1, ptr addrspace(3) %gep.1, align 16, !dbg !77, !tbaa !30
  store i32 %v.sroa.14.1, ptr addrspace(3) %v.sroa.14.16.gep.1.sroa_idx, align 4, !dbg !77, !tbaa !30
  store i32 %v.sroa.16.1, ptr addrspace(3) %v.sroa.16.16.gep.1.sroa_idx, align 8, !dbg !77, !tbaa !30
  store i32 %v.sroa.18.1, ptr addrspace(3) %v.sroa.18.16.gep.1.sroa_idx, align 4, !dbg !77, !tbaa !30
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %45, i64 0, !dbg !78
  %mul233 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !79
  %46 = tail call contract noundef float @llvm.minnum.f32(float %mul233, float 0x4024CB5EC0000000), !dbg !80
  %47 = tail call contract noundef float @llvm.exp.f32(float %46), !dbg !84
  %add242 = fadd contract float %partial_sum.sroa.0.0, %47, !dbg !87
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %45, i64 1, !dbg !78
  %mul233.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !79
  %48 = tail call contract noundef float @llvm.minnum.f32(float %mul233.1, float 0x4024CB5EC0000000), !dbg !80
  %49 = tail call contract noundef float @llvm.exp.f32(float %48), !dbg !84
  %add242.1 = fadd contract float %partial_sum.sroa.6.0, %49, !dbg !87
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %45, i64 2, !dbg !78
  %mul233.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !79
  %50 = tail call contract noundef float @llvm.minnum.f32(float %mul233.2, float 0x4024CB5EC0000000), !dbg !80
  %51 = tail call contract noundef float @llvm.exp.f32(float %50), !dbg !84
  %add242.2 = fadd contract float %partial_sum.sroa.10.0, %51, !dbg !87
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %45, i64 3, !dbg !78
  %mul233.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !79
  %52 = tail call contract noundef float @llvm.minnum.f32(float %mul233.3, float 0x4024CB5EC0000000), !dbg !80
  %53 = tail call contract noundef float @llvm.exp.f32(float %52), !dbg !84
  %add242.3 = fadd contract float %partial_sum.sroa.14.0, %53, !dbg !87
  %54 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %47), !dbg !88
  %55 = insertelement <4 x i16> poison, i16 %54, i64 0, !dbg !97
  %56 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %49), !dbg !88
  %57 = insertelement <4 x i16> %55, i16 %56, i64 1, !dbg !97
  %58 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %51), !dbg !88
  %59 = insertelement <4 x i16> %57, i16 %58, i64 2, !dbg !97
  %60 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %53), !dbg !88
  %61 = insertelement <4 x i16> %59, i16 %60, i64 3, !dbg !97
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %61 to <4 x half>, !dbg !97
  fence syncscope("warp") release, !dbg !98
  tail call void @llvm.mxc.barrier.warp(), !dbg !101
  fence syncscope("warp") acquire, !dbg !102
  br label %if.then262, !dbg !103

if.then262:                                       ; preds = %for.body124, %for.body134.preheader
  %partial_sum.sroa.14.1 = phi float [ %add242.3, %for.body134.preheader ], [ %partial_sum.sroa.14.0, %for.body124 ], !dbg !62
  %partial_sum.sroa.10.1 = phi float [ %add242.2, %for.body134.preheader ], [ %partial_sum.sroa.10.0, %for.body124 ], !dbg !62
  %partial_sum.sroa.6.1 = phi float [ %add242.1, %for.body134.preheader ], [ %partial_sum.sroa.6.0, %for.body124 ], !dbg !62
  %partial_sum.sroa.0.1 = phi float [ %add242, %for.body134.preheader ], [ %partial_sum.sroa.0.0, %for.body124 ], !dbg !62
  %prob.sroa.0.1 = phi <4 x half> [ %prob.sroa.0.6.vec.insert, %for.body134.preheader ], [ %prob.sroa.0.0, %for.body124 ]
  %add263 = or disjoint i32 %s_1.0687, 1, !dbg !104
  %arrayidx265 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %add263, !dbg !105
  %62 = load i32, ptr addrspace(5) %arrayidx265, align 4, !dbg !105, !tbaa !30
  %or.cond700 = icmp ult i32 %62, 32, !dbg !106
  br i1 %or.cond700, label %for.cond270.preheader, label %if.end337, !dbg !106

for.cond270.preheader:                            ; preds = %if.then262
  %mul280 = shl nuw nsw i32 %62, 10
  %add283 = add nuw nsw i32 %add281.pre-phi, %mul280
  %63 = zext i32 %add283 to i64, !dbg !107
  %add.ptr290 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %63, !dbg !108
  %64 = load i32, ptr addrspace(4) %add.ptr290, align 4, !dbg !109, !tbaa !30
  %65 = add nuw nsw i64 %63, 2, !dbg !110
  %add.ptr290.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %65, !dbg !108
  %66 = load i32, ptr addrspace(4) %add.ptr290.1, align 4, !dbg !109, !tbaa !30
  %67 = add nuw nsw i64 %63, 4, !dbg !110
  %add.ptr290.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %67, !dbg !108
  %68 = load i32, ptr addrspace(4) %add.ptr290.2, align 4, !dbg !109, !tbaa !30
  %69 = add nuw nsw i64 %63, 6, !dbg !110
  %add.ptr290.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %69, !dbg !108
  %70 = load i32, ptr addrspace(4) %add.ptr290.3, align 4, !dbg !109, !tbaa !30
  %71 = add nuw nsw i64 %63, 512
  %add.ptr290.1744 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %71, !dbg !108
  %72 = load i32, ptr addrspace(4) %add.ptr290.1744, align 4, !dbg !109, !tbaa !30
  %73 = add nuw nsw i64 %63, 514, !dbg !110
  %add.ptr290.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %73, !dbg !108
  %74 = load i32, ptr addrspace(4) %add.ptr290.1.1, align 4, !dbg !109, !tbaa !30
  %75 = add nuw nsw i64 %63, 516, !dbg !110
  %add.ptr290.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %75, !dbg !108
  %76 = load i32, ptr addrspace(4) %add.ptr290.2.1, align 4, !dbg !109, !tbaa !30
  %77 = add nuw nsw i64 %63, 518, !dbg !110
  %add.ptr290.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %77, !dbg !108
  %78 = load i32, ptr addrspace(4) %add.ptr290.3.1, align 4, !dbg !109, !tbaa !30
  %add.ptr323 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %63, !dbg !111
  %79 = load i32, ptr addrspace(4) %add.ptr323, align 4, !dbg !112, !tbaa !30
  %add.ptr323.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %65, !dbg !111
  %80 = load i32, ptr addrspace(4) %add.ptr323.1, align 4, !dbg !112, !tbaa !30
  %add.ptr323.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %67, !dbg !111
  %81 = load i32, ptr addrspace(4) %add.ptr323.2, align 4, !dbg !112, !tbaa !30
  %add.ptr323.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %69, !dbg !111
  %82 = load i32, ptr addrspace(4) %add.ptr323.3, align 4, !dbg !112, !tbaa !30
  %add.ptr323.1756 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %71, !dbg !111
  %83 = load i32, ptr addrspace(4) %add.ptr323.1756, align 4, !dbg !112, !tbaa !30
  %add.ptr323.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %73, !dbg !111
  %84 = load i32, ptr addrspace(4) %add.ptr323.1.1, align 4, !dbg !112, !tbaa !30
  %add.ptr323.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %75, !dbg !111
  %85 = load i32, ptr addrspace(4) %add.ptr323.2.1, align 4, !dbg !112, !tbaa !30
  %add.ptr323.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %77, !dbg !111
  %86 = load i32, ptr addrspace(4) %add.ptr323.3.1, align 4, !dbg !112, !tbaa !30
  br label %if.end337, !dbg !113

if.end337:                                        ; preds = %for.cond270.preheader, %if.then262
  %k.sroa.18.2 = phi i32 [ %78, %for.cond270.preheader ], [ %k.sroa.18.1, %if.then262 ], !dbg !62
  %k.sroa.16.2 = phi i32 [ %76, %for.cond270.preheader ], [ %k.sroa.16.1, %if.then262 ], !dbg !62
  %k.sroa.14.2 = phi i32 [ %74, %for.cond270.preheader ], [ %k.sroa.14.1, %if.then262 ], !dbg !62
  %k.sroa.11.2 = phi i32 [ %72, %for.cond270.preheader ], [ %k.sroa.11.1, %if.then262 ], !dbg !62
  %k.sroa.9.2 = phi i32 [ %70, %for.cond270.preheader ], [ %k.sroa.9.1, %if.then262 ], !dbg !62
  %k.sroa.7.2 = phi i32 [ %68, %for.cond270.preheader ], [ %k.sroa.7.1, %if.then262 ], !dbg !62
  %k.sroa.5.2 = phi i32 [ %66, %for.cond270.preheader ], [ %k.sroa.5.1, %if.then262 ], !dbg !62
  %k.sroa.0.2 = phi i32 [ %64, %for.cond270.preheader ], [ %k.sroa.0.1, %if.then262 ], !dbg !62
  %v.sroa.18.2 = phi i32 [ %86, %for.cond270.preheader ], [ %v.sroa.18.1, %if.then262 ], !dbg !62
  %v.sroa.16.2 = phi i32 [ %85, %for.cond270.preheader ], [ %v.sroa.16.1, %if.then262 ], !dbg !62
  %v.sroa.14.2 = phi i32 [ %84, %for.cond270.preheader ], [ %v.sroa.14.1, %if.then262 ], !dbg !62
  %v.sroa.11.2 = phi i32 [ %83, %for.cond270.preheader ], [ %v.sroa.11.1, %if.then262 ], !dbg !62
  %v.sroa.9.2 = phi i32 [ %82, %for.cond270.preheader ], [ %v.sroa.9.1, %if.then262 ], !dbg !62
  %v.sroa.7.2 = phi i32 [ %81, %for.cond270.preheader ], [ %v.sroa.7.1, %if.then262 ], !dbg !62
  %v.sroa.5.2 = phi i32 [ %80, %for.cond270.preheader ], [ %v.sroa.5.1, %if.then262 ], !dbg !62
  %v.sroa.0.2 = phi i32 [ %79, %for.cond270.preheader ], [ %v.sroa.0.1, %if.then262 ], !dbg !62
  br i1 %or.cond699, label %for.cond346.preheader.preheader, label %if.end402, !dbg !113

for.cond346.preheader.preheader:                  ; preds = %if.end337
  %87 = load half, ptr addrspace(3) %gep683, align 2, !dbg !114, !tbaa !115
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %87, i64 0, !dbg !114
  %88 = load half, ptr addrspace(3) %gep683.1, align 2, !dbg !114, !tbaa !115
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %88, i64 1, !dbg !114
  %89 = load half, ptr addrspace(3) %gep683.2, align 2, !dbg !114, !tbaa !115
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %89, i64 2, !dbg !114
  %90 = load half, ptr addrspace(3) %gep683.3, align 2, !dbg !114, !tbaa !115
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %90, i64 3, !dbg !114
  %91 = load half, ptr addrspace(3) %gep683.1762, align 2, !dbg !114, !tbaa !115
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %91, i64 0, !dbg !114
  %92 = load half, ptr addrspace(3) %gep683.1.1, align 2, !dbg !114, !tbaa !115
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %92, i64 1, !dbg !114
  %93 = load half, ptr addrspace(3) %gep683.2.1, align 2, !dbg !114, !tbaa !115
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %93, i64 2, !dbg !114
  %94 = load half, ptr addrspace(3) %gep683.3.1, align 2, !dbg !114, !tbaa !115
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %94, i64 3, !dbg !114
  %95 = load half, ptr addrspace(3) %gep683.2768, align 2, !dbg !114, !tbaa !115
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %95, i64 0, !dbg !114
  %96 = load half, ptr addrspace(3) %gep683.1.2, align 2, !dbg !114, !tbaa !115
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %96, i64 1, !dbg !114
  %97 = load half, ptr addrspace(3) %gep683.2.2, align 2, !dbg !114, !tbaa !115
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %97, i64 2, !dbg !114
  %98 = load half, ptr addrspace(3) %gep683.3.2, align 2, !dbg !114, !tbaa !115
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %98, i64 3, !dbg !114
  %99 = load half, ptr addrspace(3) %gep683.3774, align 2, !dbg !114, !tbaa !115
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %99, i64 0, !dbg !114
  %100 = load half, ptr addrspace(3) %gep683.1.3, align 2, !dbg !114, !tbaa !115
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %100, i64 1, !dbg !114
  %101 = load half, ptr addrspace(3) %gep683.2.3, align 2, !dbg !114, !tbaa !115
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %101, i64 2, !dbg !114
  %102 = load half, ptr addrspace(3) %gep683.3.3, align 2, !dbg !114, !tbaa !115
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %102, i64 3, !dbg !114
  %103 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.0.0), !dbg !116
  %104 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.20.0), !dbg !116
  %105 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.38.0), !dbg !116
  %106 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.56.0), !dbg !116
  br label %if.end402, !dbg !117

if.end402:                                        ; preds = %for.cond346.preheader.preheader, %if.end337
  %out.sroa.56.1 = phi <4 x float> [ %106, %for.cond346.preheader.preheader ], [ %out.sroa.56.0, %if.end337 ], !dbg !62
  %out.sroa.38.1 = phi <4 x float> [ %105, %for.cond346.preheader.preheader ], [ %out.sroa.38.0, %if.end337 ], !dbg !62
  %out.sroa.20.1 = phi <4 x float> [ %104, %for.cond346.preheader.preheader ], [ %out.sroa.20.0, %if.end337 ], !dbg !62
  %out.sroa.0.1 = phi <4 x float> [ %103, %for.cond346.preheader.preheader ], [ %out.sroa.0.0, %if.end337 ], !dbg !62
  %inc404 = or disjoint i32 %s_1.0687, 1, !dbg !117
  %arrayidx126.1 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %inc404, !dbg !63
  %107 = load i32, ptr addrspace(5) %arrayidx126.1, align 4, !dbg !63, !tbaa !30
  %or.cond699.1 = icmp ult i32 %107, 32, !dbg !64
  br i1 %or.cond699.1, label %for.body134.preheader.1, label %if.end260.1, !dbg !64

for.body134.preheader.1:                          ; preds = %if.end402
  store i32 %k.sroa.0.2, ptr addrspace(3) %invariant.gep664, align 16, !dbg !65, !tbaa !30
  store i32 %k.sroa.5.2, ptr addrspace(3) %k.sroa.5.0.invariant.gep664.sroa_idx, align 4, !dbg !65, !tbaa !30
  store i32 %k.sroa.7.2, ptr addrspace(3) %k.sroa.7.0.invariant.gep664.sroa_idx, align 8, !dbg !65, !tbaa !30
  store i32 %k.sroa.9.2, ptr addrspace(3) %k.sroa.9.0.invariant.gep664.sroa_idx, align 4, !dbg !65, !tbaa !30
  store i32 %k.sroa.11.2, ptr addrspace(3) %gep665.1, align 16, !dbg !65, !tbaa !30
  store i32 %k.sroa.14.2, ptr addrspace(3) %k.sroa.14.16.gep665.1.sroa_idx, align 4, !dbg !65, !tbaa !30
  store i32 %k.sroa.16.2, ptr addrspace(3) %k.sroa.16.16.gep665.1.sroa_idx, align 8, !dbg !65, !tbaa !30
  store i32 %k.sroa.18.2, ptr addrspace(3) %k.sroa.18.16.gep665.1.sroa_idx, align 4, !dbg !65, !tbaa !30
  fence syncscope("warp") release, !dbg !66
  tail call void @llvm.mxc.barrier.warp(), !dbg !72
  fence syncscope("warp") acquire, !dbg !73
  %kb.sroa.0.0.copyload.1 = load <4 x half>, ptr addrspace(3) %add.ptr176, align 16, !dbg !74
  %kb.sroa.6.0.copyload.1 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr176.sroa_idx, align 8, !dbg !74
  %108 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload.1, <4 x half> %q.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !75, !call_argsrelate !76
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload.1, <4 x half> %q.sroa.4.0.copyload, <4 x float> %108), !dbg !75, !call_argsrelate !76
  %kb.sroa.0.0.copyload791.1 = load <4 x half>, ptr addrspace(3) %add.ptr176.1, align 16, !dbg !74
  %kb.sroa.6.0.copyload792.1 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr176.1.sroa_idx, align 8, !dbg !74
  %110 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload791.1, <4 x half> %q.sroa.5.16.copyload, <4 x float> %109), !dbg !75, !call_argsrelate !76
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload792.1, <4 x half> %q.sroa.7.16.copyload, <4 x float> %110), !dbg !75, !call_argsrelate !76
  store i32 %v.sroa.0.2, ptr addrspace(3) %invariant.gep675, align 16, !dbg !77, !tbaa !30
  store i32 %v.sroa.5.2, ptr addrspace(3) %v.sroa.5.0.invariant.gep675.sroa_idx, align 4, !dbg !77, !tbaa !30
  store i32 %v.sroa.7.2, ptr addrspace(3) %v.sroa.7.0.invariant.gep675.sroa_idx, align 8, !dbg !77, !tbaa !30
  store i32 %v.sroa.9.2, ptr addrspace(3) %v.sroa.9.0.invariant.gep675.sroa_idx, align 4, !dbg !77, !tbaa !30
  store i32 %v.sroa.11.2, ptr addrspace(3) %gep.1, align 16, !dbg !77, !tbaa !30
  store i32 %v.sroa.14.2, ptr addrspace(3) %v.sroa.14.16.gep.1.sroa_idx, align 4, !dbg !77, !tbaa !30
  store i32 %v.sroa.16.2, ptr addrspace(3) %v.sroa.16.16.gep.1.sroa_idx, align 8, !dbg !77, !tbaa !30
  store i32 %v.sroa.18.2, ptr addrspace(3) %v.sroa.18.16.gep.1.sroa_idx, align 4, !dbg !77, !tbaa !30
  %scores.sroa.0.0.vec.extract.1 = extractelement <4 x float> %111, i64 0, !dbg !78
  %mul233.1910 = fmul contract float %scores.sroa.0.0.vec.extract.1, 0x3FB99999A0000000, !dbg !79
  %112 = tail call contract noundef float @llvm.minnum.f32(float %mul233.1910, float 0x4024CB5EC0000000), !dbg !80
  %113 = tail call contract noundef float @llvm.exp.f32(float %112), !dbg !84
  %add242.1911 = fadd contract float %partial_sum.sroa.0.1, %113, !dbg !87
  %scores.sroa.0.4.vec.extract.1 = extractelement <4 x float> %111, i64 1, !dbg !78
  %mul233.1.1 = fmul contract float %scores.sroa.0.4.vec.extract.1, 0x3FB99999A0000000, !dbg !79
  %114 = tail call contract noundef float @llvm.minnum.f32(float %mul233.1.1, float 0x4024CB5EC0000000), !dbg !80
  %115 = tail call contract noundef float @llvm.exp.f32(float %114), !dbg !84
  %add242.1.1 = fadd contract float %partial_sum.sroa.6.1, %115, !dbg !87
  %scores.sroa.0.8.vec.extract.1 = extractelement <4 x float> %111, i64 2, !dbg !78
  %mul233.2.1 = fmul contract float %scores.sroa.0.8.vec.extract.1, 0x3FB99999A0000000, !dbg !79
  %116 = tail call contract noundef float @llvm.minnum.f32(float %mul233.2.1, float 0x4024CB5EC0000000), !dbg !80
  %117 = tail call contract noundef float @llvm.exp.f32(float %116), !dbg !84
  %add242.2.1 = fadd contract float %partial_sum.sroa.10.1, %117, !dbg !87
  %scores.sroa.0.12.vec.extract.1 = extractelement <4 x float> %111, i64 3, !dbg !78
  %mul233.3.1 = fmul contract float %scores.sroa.0.12.vec.extract.1, 0x3FB99999A0000000, !dbg !79
  %118 = tail call contract noundef float @llvm.minnum.f32(float %mul233.3.1, float 0x4024CB5EC0000000), !dbg !80
  %119 = tail call contract noundef float @llvm.exp.f32(float %118), !dbg !84
  %add242.3.1 = fadd contract float %partial_sum.sroa.14.1, %119, !dbg !87
  %120 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %113), !dbg !88
  %121 = insertelement <4 x i16> poison, i16 %120, i64 0, !dbg !97
  %122 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %115), !dbg !88
  %123 = insertelement <4 x i16> %121, i16 %122, i64 1, !dbg !97
  %124 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %117), !dbg !88
  %125 = insertelement <4 x i16> %123, i16 %124, i64 2, !dbg !97
  %126 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %119), !dbg !88
  %127 = insertelement <4 x i16> %125, i16 %126, i64 3, !dbg !97
  %prob.sroa.0.6.vec.insert.1 = bitcast <4 x i16> %127 to <4 x half>, !dbg !97
  fence syncscope("warp") release, !dbg !98
  tail call void @llvm.mxc.barrier.warp(), !dbg !101
  fence syncscope("warp") acquire, !dbg !102
  br label %if.end260.1, !dbg !103

if.end260.1:                                      ; preds = %for.body134.preheader.1, %if.end402
  %partial_sum.sroa.14.1.1 = phi float [ %add242.3.1, %for.body134.preheader.1 ], [ %partial_sum.sroa.14.1, %if.end402 ], !dbg !62
  %partial_sum.sroa.10.1.1 = phi float [ %add242.2.1, %for.body134.preheader.1 ], [ %partial_sum.sroa.10.1, %if.end402 ], !dbg !62
  %partial_sum.sroa.6.1.1 = phi float [ %add242.1.1, %for.body134.preheader.1 ], [ %partial_sum.sroa.6.1, %if.end402 ], !dbg !62
  %partial_sum.sroa.0.1.1 = phi float [ %add242.1911, %for.body134.preheader.1 ], [ %partial_sum.sroa.0.1, %if.end402 ], !dbg !62
  %prob.sroa.0.1.1 = phi <4 x half> [ %prob.sroa.0.6.vec.insert.1, %for.body134.preheader.1 ], [ %prob.sroa.0.1, %if.end402 ]
  %cmp261.not.1 = icmp eq i32 %s_1.0687, 2, !dbg !118
  br i1 %cmp261.not.1, label %if.end337.1, label %if.then262.1, !dbg !119

if.then262.1:                                     ; preds = %if.end260.1
  %add263.1 = add nuw nsw i32 %s_1.0687, 2, !dbg !104
  %arrayidx265.1 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %add263.1, !dbg !105
  %128 = load i32, ptr addrspace(5) %arrayidx265.1, align 4, !dbg !105, !tbaa !30
  %or.cond700.1 = icmp ult i32 %128, 32, !dbg !106
  br i1 %or.cond700.1, label %for.cond270.preheader.1, label %if.end337.1, !dbg !106

for.cond270.preheader.1:                          ; preds = %if.then262.1
  %mul280.1 = shl nuw nsw i32 %128, 10
  %add283.1 = add nuw nsw i32 %add281.pre-phi, %mul280.1
  %129 = zext i32 %add283.1 to i64, !dbg !107
  %add.ptr290.1912 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %129, !dbg !108
  %130 = load i32, ptr addrspace(4) %add.ptr290.1912, align 4, !dbg !109, !tbaa !30
  %131 = add nuw nsw i64 %129, 2, !dbg !110
  %add.ptr290.1.1913 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %131, !dbg !108
  %132 = load i32, ptr addrspace(4) %add.ptr290.1.1913, align 4, !dbg !109, !tbaa !30
  %133 = add nuw nsw i64 %129, 4, !dbg !110
  %add.ptr290.2.1914 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %133, !dbg !108
  %134 = load i32, ptr addrspace(4) %add.ptr290.2.1914, align 4, !dbg !109, !tbaa !30
  %135 = add nuw nsw i64 %129, 6, !dbg !110
  %add.ptr290.3.1915 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %135, !dbg !108
  %136 = load i32, ptr addrspace(4) %add.ptr290.3.1915, align 4, !dbg !109, !tbaa !30
  %137 = add nuw nsw i64 %129, 512
  %add.ptr290.1744.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %137, !dbg !108
  %138 = load i32, ptr addrspace(4) %add.ptr290.1744.1, align 4, !dbg !109, !tbaa !30
  %139 = add nuw nsw i64 %129, 514, !dbg !110
  %add.ptr290.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %139, !dbg !108
  %140 = load i32, ptr addrspace(4) %add.ptr290.1.1.1, align 4, !dbg !109, !tbaa !30
  %141 = add nuw nsw i64 %129, 516, !dbg !110
  %add.ptr290.2.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %141, !dbg !108
  %142 = load i32, ptr addrspace(4) %add.ptr290.2.1.1, align 4, !dbg !109, !tbaa !30
  %143 = add nuw nsw i64 %129, 518, !dbg !110
  %add.ptr290.3.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %143, !dbg !108
  %144 = load i32, ptr addrspace(4) %add.ptr290.3.1.1, align 4, !dbg !109, !tbaa !30
  %add.ptr323.1916 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %129, !dbg !111
  %145 = load i32, ptr addrspace(4) %add.ptr323.1916, align 4, !dbg !112, !tbaa !30
  %add.ptr323.1.1917 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %131, !dbg !111
  %146 = load i32, ptr addrspace(4) %add.ptr323.1.1917, align 4, !dbg !112, !tbaa !30
  %add.ptr323.2.1918 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %133, !dbg !111
  %147 = load i32, ptr addrspace(4) %add.ptr323.2.1918, align 4, !dbg !112, !tbaa !30
  %add.ptr323.3.1919 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %135, !dbg !111
  %148 = load i32, ptr addrspace(4) %add.ptr323.3.1919, align 4, !dbg !112, !tbaa !30
  %add.ptr323.1756.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %137, !dbg !111
  %149 = load i32, ptr addrspace(4) %add.ptr323.1756.1, align 4, !dbg !112, !tbaa !30
  %add.ptr323.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %139, !dbg !111
  %150 = load i32, ptr addrspace(4) %add.ptr323.1.1.1, align 4, !dbg !112, !tbaa !30
  %add.ptr323.2.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %141, !dbg !111
  %151 = load i32, ptr addrspace(4) %add.ptr323.2.1.1, align 4, !dbg !112, !tbaa !30
  %add.ptr323.3.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %143, !dbg !111
  %152 = load i32, ptr addrspace(4) %add.ptr323.3.1.1, align 4, !dbg !112, !tbaa !30
  br label %if.end337.1, !dbg !113

if.end337.1:                                      ; preds = %for.cond270.preheader.1, %if.then262.1, %if.end260.1
  %k.sroa.18.2.1 = phi i32 [ %k.sroa.18.2, %if.end260.1 ], [ %144, %for.cond270.preheader.1 ], [ %k.sroa.18.2, %if.then262.1 ], !dbg !62
  %k.sroa.16.2.1 = phi i32 [ %k.sroa.16.2, %if.end260.1 ], [ %142, %for.cond270.preheader.1 ], [ %k.sroa.16.2, %if.then262.1 ], !dbg !62
  %k.sroa.14.2.1 = phi i32 [ %k.sroa.14.2, %if.end260.1 ], [ %140, %for.cond270.preheader.1 ], [ %k.sroa.14.2, %if.then262.1 ], !dbg !62
  %k.sroa.11.2.1 = phi i32 [ %k.sroa.11.2, %if.end260.1 ], [ %138, %for.cond270.preheader.1 ], [ %k.sroa.11.2, %if.then262.1 ], !dbg !62
  %k.sroa.9.2.1 = phi i32 [ %k.sroa.9.2, %if.end260.1 ], [ %136, %for.cond270.preheader.1 ], [ %k.sroa.9.2, %if.then262.1 ], !dbg !62
  %k.sroa.7.2.1 = phi i32 [ %k.sroa.7.2, %if.end260.1 ], [ %134, %for.cond270.preheader.1 ], [ %k.sroa.7.2, %if.then262.1 ], !dbg !62
  %k.sroa.5.2.1 = phi i32 [ %k.sroa.5.2, %if.end260.1 ], [ %132, %for.cond270.preheader.1 ], [ %k.sroa.5.2, %if.then262.1 ], !dbg !62
  %k.sroa.0.2.1 = phi i32 [ %k.sroa.0.2, %if.end260.1 ], [ %130, %for.cond270.preheader.1 ], [ %k.sroa.0.2, %if.then262.1 ], !dbg !62
  %v.sroa.18.2.1 = phi i32 [ %v.sroa.18.2, %if.end260.1 ], [ %152, %for.cond270.preheader.1 ], [ %v.sroa.18.2, %if.then262.1 ], !dbg !62
  %v.sroa.16.2.1 = phi i32 [ %v.sroa.16.2, %if.end260.1 ], [ %151, %for.cond270.preheader.1 ], [ %v.sroa.16.2, %if.then262.1 ], !dbg !62
  %v.sroa.14.2.1 = phi i32 [ %v.sroa.14.2, %if.end260.1 ], [ %150, %for.cond270.preheader.1 ], [ %v.sroa.14.2, %if.then262.1 ], !dbg !62
  %v.sroa.11.2.1 = phi i32 [ %v.sroa.11.2, %if.end260.1 ], [ %149, %for.cond270.preheader.1 ], [ %v.sroa.11.2, %if.then262.1 ], !dbg !62
  %v.sroa.9.2.1 = phi i32 [ %v.sroa.9.2, %if.end260.1 ], [ %148, %for.cond270.preheader.1 ], [ %v.sroa.9.2, %if.then262.1 ], !dbg !62
  %v.sroa.7.2.1 = phi i32 [ %v.sroa.7.2, %if.end260.1 ], [ %147, %for.cond270.preheader.1 ], [ %v.sroa.7.2, %if.then262.1 ], !dbg !62
  %v.sroa.5.2.1 = phi i32 [ %v.sroa.5.2, %if.end260.1 ], [ %146, %for.cond270.preheader.1 ], [ %v.sroa.5.2, %if.then262.1 ], !dbg !62
  %v.sroa.0.2.1 = phi i32 [ %v.sroa.0.2, %if.end260.1 ], [ %145, %for.cond270.preheader.1 ], [ %v.sroa.0.2, %if.then262.1 ], !dbg !62
  br i1 %or.cond699.1, label %for.cond346.preheader.preheader.1, label %if.end402.1, !dbg !113

for.cond346.preheader.preheader.1:                ; preds = %if.end337.1
  %153 = load half, ptr addrspace(3) %gep683, align 2, !dbg !114, !tbaa !115
  %vb.sroa.0.0.vec.insert.1 = insertelement <4 x half> poison, half %153, i64 0, !dbg !114
  %154 = load half, ptr addrspace(3) %gep683.1, align 2, !dbg !114, !tbaa !115
  %vb.sroa.0.2.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.0.vec.insert.1, half %154, i64 1, !dbg !114
  %155 = load half, ptr addrspace(3) %gep683.2, align 2, !dbg !114, !tbaa !115
  %vb.sroa.0.4.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.2.vec.insert.1, half %155, i64 2, !dbg !114
  %156 = load half, ptr addrspace(3) %gep683.3, align 2, !dbg !114, !tbaa !115
  %vb.sroa.0.6.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.4.vec.insert.1, half %156, i64 3, !dbg !114
  %157 = load half, ptr addrspace(3) %gep683.1762, align 2, !dbg !114, !tbaa !115
  %vb.sroa.7.8.vec.insert.1 = insertelement <4 x half> poison, half %157, i64 0, !dbg !114
  %158 = load half, ptr addrspace(3) %gep683.1.1, align 2, !dbg !114, !tbaa !115
  %vb.sroa.7.10.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.8.vec.insert.1, half %158, i64 1, !dbg !114
  %159 = load half, ptr addrspace(3) %gep683.2.1, align 2, !dbg !114, !tbaa !115
  %vb.sroa.7.12.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.10.vec.insert.1, half %159, i64 2, !dbg !114
  %160 = load half, ptr addrspace(3) %gep683.3.1, align 2, !dbg !114, !tbaa !115
  %vb.sroa.7.14.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.12.vec.insert.1, half %160, i64 3, !dbg !114
  %161 = load half, ptr addrspace(3) %gep683.2768, align 2, !dbg !114, !tbaa !115
  %vb.sroa.12.16.vec.insert.1 = insertelement <4 x half> poison, half %161, i64 0, !dbg !114
  %162 = load half, ptr addrspace(3) %gep683.1.2, align 2, !dbg !114, !tbaa !115
  %vb.sroa.12.18.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.16.vec.insert.1, half %162, i64 1, !dbg !114
  %163 = load half, ptr addrspace(3) %gep683.2.2, align 2, !dbg !114, !tbaa !115
  %vb.sroa.12.20.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.18.vec.insert.1, half %163, i64 2, !dbg !114
  %164 = load half, ptr addrspace(3) %gep683.3.2, align 2, !dbg !114, !tbaa !115
  %vb.sroa.12.22.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.20.vec.insert.1, half %164, i64 3, !dbg !114
  %165 = load half, ptr addrspace(3) %gep683.3774, align 2, !dbg !114, !tbaa !115
  %vb.sroa.17.24.vec.insert.1 = insertelement <4 x half> poison, half %165, i64 0, !dbg !114
  %166 = load half, ptr addrspace(3) %gep683.1.3, align 2, !dbg !114, !tbaa !115
  %vb.sroa.17.26.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.24.vec.insert.1, half %166, i64 1, !dbg !114
  %167 = load half, ptr addrspace(3) %gep683.2.3, align 2, !dbg !114, !tbaa !115
  %vb.sroa.17.28.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.26.vec.insert.1, half %167, i64 2, !dbg !114
  %168 = load half, ptr addrspace(3) %gep683.3.3, align 2, !dbg !114, !tbaa !115
  %vb.sroa.17.30.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.28.vec.insert.1, half %168, i64 3, !dbg !114
  %169 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.0.1), !dbg !116
  %170 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.20.1), !dbg !116
  %171 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.38.1), !dbg !116
  %172 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.56.1), !dbg !116
  br label %if.end402.1, !dbg !117

if.end402.1:                                      ; preds = %for.cond346.preheader.preheader.1, %if.end337.1
  %out.sroa.56.1.1 = phi <4 x float> [ %172, %for.cond346.preheader.preheader.1 ], [ %out.sroa.56.1, %if.end337.1 ], !dbg !62
  %out.sroa.38.1.1 = phi <4 x float> [ %171, %for.cond346.preheader.preheader.1 ], [ %out.sroa.38.1, %if.end337.1 ], !dbg !62
  %out.sroa.20.1.1 = phi <4 x float> [ %170, %for.cond346.preheader.preheader.1 ], [ %out.sroa.20.1, %if.end337.1 ], !dbg !62
  %out.sroa.0.1.1 = phi <4 x float> [ %169, %for.cond346.preheader.preheader.1 ], [ %out.sroa.0.1, %if.end337.1 ], !dbg !62
  %inc404.1 = add nuw nsw i32 %s_1.0687, 2, !dbg !117
  %exitcond.not.1 = icmp eq i32 %inc404.1, 4, !dbg !120
  br i1 %exitcond.not.1, label %for.body410.preheader, label %for.body124, !dbg !61, !llvm.loop !121

for.body410.preheader:                            ; preds = %if.end402.1
  %add414 = fadd contract float %partial_sum.sroa.0.1.1, 0.000000e+00, !dbg !124
  %add414.1 = fadd contract float %add414, %partial_sum.sroa.6.1.1, !dbg !124
  %add414.2 = fadd contract float %add414.1, %partial_sum.sroa.10.1.1, !dbg !124
  %add414.3 = fadd contract float %add414.2, %partial_sum.sroa.14.1.1, !dbg !124
  %173 = bitcast float %add414.3 to i32, !dbg !125
  %174 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #13, !dbg !136
  %175 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %174) #13, !dbg !141
  %xor.i.i = xor i32 %175, 32, !dbg !142
  %176 = and i32 %175, -64, !dbg !143
  %and.i.i = add nsw i32 %176, 64, !dbg !143
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !144
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %175, !dbg !145
  %shl.i.i = shl i32 %cond.i.i, 2, !dbg !146
  %177 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %173), !dbg !147
  %178 = bitcast i32 %177 to float, !dbg !148
  %add.i = fadd contract float %add414.3, %178, !dbg !149
  %179 = bitcast float %add.i to i32, !dbg !152
  %180 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #13, !dbg !159
  %181 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %180) #13, !dbg !162
  %xor.i.i651 = xor i32 %181, 16, !dbg !163
  %182 = and i32 %181, -64, !dbg !164
  %and.i.i652 = add nsw i32 %182, 64, !dbg !164
  %cmp.not.i.i653 = icmp slt i32 %xor.i.i651, %and.i.i652, !dbg !165
  %cond.i.i654 = select i1 %cmp.not.i.i653, i32 %xor.i.i651, i32 %181, !dbg !166
  %shl.i.i655 = shl i32 %cond.i.i654, 2, !dbg !167
  %183 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i655, i32 %179), !dbg !168
  %184 = bitcast i32 %183 to float, !dbg !169
  %add.i.i = fadd contract float %add.i, %184, !dbg !170
  %cmp423 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !172
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !173
  %condval.0 = select i1 %cmp423, float %div, float 0.000000e+00, !dbg !173
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 0, !dbg !174
  %mul435 = fmul contract float %condval.0, %out.sroa.0.0.vec.extract, !dbg !175
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 1, !dbg !174
  %mul435.1 = fmul contract float %condval.0, %out.sroa.0.4.vec.extract, !dbg !175
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 2, !dbg !174
  %mul435.2 = fmul contract float %condval.0, %out.sroa.0.8.vec.extract, !dbg !175
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 3, !dbg !174
  %mul435.3 = fmul contract float %condval.0, %out.sroa.0.12.vec.extract, !dbg !175
  %out.sroa.20.16.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 0, !dbg !174
  %mul435.4 = fmul contract float %condval.0, %out.sroa.20.16.vec.extract, !dbg !175
  %out.sroa.20.20.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 1, !dbg !174
  %mul435.5 = fmul contract float %condval.0, %out.sroa.20.20.vec.extract, !dbg !175
  %out.sroa.20.24.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 2, !dbg !174
  %mul435.6 = fmul contract float %condval.0, %out.sroa.20.24.vec.extract, !dbg !175
  %out.sroa.20.28.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 3, !dbg !174
  %mul435.7 = fmul contract float %condval.0, %out.sroa.20.28.vec.extract, !dbg !175
  %out.sroa.38.32.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 0, !dbg !174
  %mul435.8 = fmul contract float %condval.0, %out.sroa.38.32.vec.extract, !dbg !175
  %out.sroa.38.36.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 1, !dbg !174
  %mul435.9 = fmul contract float %condval.0, %out.sroa.38.36.vec.extract, !dbg !175
  %out.sroa.38.40.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 2, !dbg !174
  %mul435.10 = fmul contract float %condval.0, %out.sroa.38.40.vec.extract, !dbg !175
  %out.sroa.38.44.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 3, !dbg !174
  %mul435.11 = fmul contract float %condval.0, %out.sroa.38.44.vec.extract, !dbg !175
  %out.sroa.56.48.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 0, !dbg !174
  %mul435.12 = fmul contract float %condval.0, %out.sroa.56.48.vec.extract, !dbg !175
  %out.sroa.56.52.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 1, !dbg !174
  %mul435.13 = fmul contract float %condval.0, %out.sroa.56.52.vec.extract, !dbg !175
  %out.sroa.56.56.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 2, !dbg !174
  %mul435.14 = fmul contract float %condval.0, %out.sroa.56.56.vec.extract, !dbg !175
  %out.sroa.56.60.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 3, !dbg !174
  %mul435.15 = fmul contract float %condval.0, %out.sroa.56.60.vec.extract, !dbg !175
  %185 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul435), !dbg !176
  %result.sroa.0.0.insert.ext = zext i16 %185 to i64, !dbg !180
  %186 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul435.1), !dbg !176
  %result.sroa.0.2.insert.ext = zext i16 %186 to i64, !dbg !180
  %result.sroa.0.2.insert.shift = shl nuw nsw i64 %result.sroa.0.2.insert.ext, 16, !dbg !180
  %result.sroa.0.2.insert.insert = or disjoint i64 %result.sroa.0.2.insert.shift, %result.sroa.0.0.insert.ext, !dbg !180
  %187 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul435.2), !dbg !176
  %result.sroa.0.4.insert.ext = zext i16 %187 to i64, !dbg !180
  %result.sroa.0.4.insert.shift = shl nuw nsw i64 %result.sroa.0.4.insert.ext, 32, !dbg !180
  %result.sroa.0.4.insert.insert = or disjoint i64 %result.sroa.0.2.insert.insert, %result.sroa.0.4.insert.shift, !dbg !180
  %188 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul435.3), !dbg !176
  %result.sroa.0.6.insert.ext = zext i16 %188 to i64, !dbg !180
  %result.sroa.0.6.insert.shift = shl nuw i64 %result.sroa.0.6.insert.ext, 48, !dbg !180
  %result.sroa.0.6.insert.insert = or disjoint i64 %result.sroa.0.4.insert.insert, %result.sroa.0.6.insert.shift, !dbg !180
  %189 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul435.4), !dbg !176
  %result.sroa.7.8.insert.ext = zext i16 %189 to i64, !dbg !180
  %190 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul435.5), !dbg !176
  %result.sroa.7.10.insert.ext = zext i16 %190 to i64, !dbg !180
  %result.sroa.7.10.insert.shift = shl nuw nsw i64 %result.sroa.7.10.insert.ext, 16, !dbg !180
  %result.sroa.7.10.insert.insert = or disjoint i64 %result.sroa.7.10.insert.shift, %result.sroa.7.8.insert.ext, !dbg !180
  %191 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul435.6), !dbg !176
  %result.sroa.7.12.insert.ext = zext i16 %191 to i64, !dbg !180
  %result.sroa.7.12.insert.shift = shl nuw nsw i64 %result.sroa.7.12.insert.ext, 32, !dbg !180
  %result.sroa.7.12.insert.insert = or disjoint i64 %result.sroa.7.10.insert.insert, %result.sroa.7.12.insert.shift, !dbg !180
  %192 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul435.7), !dbg !176
  %result.sroa.7.14.insert.ext = zext i16 %192 to i64, !dbg !180
  %result.sroa.7.14.insert.shift = shl nuw i64 %result.sroa.7.14.insert.ext, 48, !dbg !180
  %result.sroa.7.14.insert.insert = or disjoint i64 %result.sroa.7.12.insert.insert, %result.sroa.7.14.insert.shift, !dbg !180
  %193 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul435.8), !dbg !176
  %result.sroa.12.16.insert.ext = zext i16 %193 to i64, !dbg !180
  %194 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul435.9), !dbg !176
  %result.sroa.12.18.insert.ext = zext i16 %194 to i64, !dbg !180
  %result.sroa.12.18.insert.shift = shl nuw nsw i64 %result.sroa.12.18.insert.ext, 16, !dbg !180
  %result.sroa.12.18.insert.insert = or disjoint i64 %result.sroa.12.18.insert.shift, %result.sroa.12.16.insert.ext, !dbg !180
  %195 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul435.10), !dbg !176
  %result.sroa.12.20.insert.ext = zext i16 %195 to i64, !dbg !180
  %result.sroa.12.20.insert.shift = shl nuw nsw i64 %result.sroa.12.20.insert.ext, 32, !dbg !180
  %result.sroa.12.20.insert.insert = or disjoint i64 %result.sroa.12.18.insert.insert, %result.sroa.12.20.insert.shift, !dbg !180
  %196 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul435.11), !dbg !176
  %result.sroa.12.22.insert.ext = zext i16 %196 to i64, !dbg !180
  %result.sroa.12.22.insert.shift = shl nuw i64 %result.sroa.12.22.insert.ext, 48, !dbg !180
  %result.sroa.12.22.insert.insert = or disjoint i64 %result.sroa.12.20.insert.insert, %result.sroa.12.22.insert.shift, !dbg !180
  %197 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul435.12), !dbg !176
  %result.sroa.17.24.insert.ext = zext i16 %197 to i64, !dbg !180
  %198 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul435.13), !dbg !176
  %result.sroa.17.26.insert.ext = zext i16 %198 to i64, !dbg !180
  %result.sroa.17.26.insert.shift = shl nuw nsw i64 %result.sroa.17.26.insert.ext, 16, !dbg !180
  %result.sroa.17.26.insert.insert = or disjoint i64 %result.sroa.17.26.insert.shift, %result.sroa.17.24.insert.ext, !dbg !180
  %199 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul435.14), !dbg !176
  %result.sroa.17.28.insert.ext = zext i16 %199 to i64, !dbg !180
  %result.sroa.17.28.insert.shift = shl nuw nsw i64 %result.sroa.17.28.insert.ext, 32, !dbg !180
  %result.sroa.17.28.insert.insert = or disjoint i64 %result.sroa.17.26.insert.insert, %result.sroa.17.28.insert.shift, !dbg !180
  %200 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul435.15), !dbg !176
  %result.sroa.17.30.insert.ext = zext i16 %200 to i64, !dbg !180
  %result.sroa.17.30.insert.shift = shl nuw i64 %result.sroa.17.30.insert.ext, 48, !dbg !180
  %result.sroa.17.30.insert.insert = or disjoint i64 %result.sroa.17.28.insert.insert, %result.sroa.17.30.insert.shift, !dbg !180
  fence syncscope("warp") release, !dbg !181
  tail call void @llvm.mxc.barrier.warp(), !dbg !184
  fence syncscope("warp") acquire, !dbg !185
  %shr477 = lshr i32 %2, 5
  %xor481 = xor i32 %shr477, %and171, !dbg !186
  %mul482 = shl nuw nsw i32 %xor481, 3, !dbg !187
  %add483 = add nuw nsw i32 %mul482, %mul9, !dbg !188
  %add488 = or disjoint i32 %add483, %mul363, !dbg !189
  %add.ptr490 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add488, !dbg !190
  store i64 %result.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr490, align 8, !dbg !191
  %add478.1 = add nuw nsw i32 %shr477, 2, !dbg !192
  %xor481.1 = xor i32 %add478.1, %and171, !dbg !186
  %mul482.1 = shl nuw nsw i32 %xor481.1, 3, !dbg !187
  %add483.1 = add nuw nsw i32 %mul482.1, %mul9, !dbg !188
  %add488.1 = or disjoint i32 %add483.1, %mul363, !dbg !189
  %add.ptr490.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add488.1, !dbg !190
  store i64 %result.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr490.1, align 8, !dbg !191
  %add478.2 = add nuw nsw i32 %shr477, 4, !dbg !192
  %xor481.2 = xor i32 %add478.2, %and171, !dbg !186
  %mul482.2 = shl nuw nsw i32 %xor481.2, 3, !dbg !187
  %add483.2 = add nuw nsw i32 %mul482.2, %mul9, !dbg !188
  %add488.2 = or disjoint i32 %add483.2, %mul363, !dbg !189
  %add.ptr490.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add488.2, !dbg !190
  store i64 %result.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr490.2, align 8, !dbg !191
  %add478.3 = add nuw nsw i32 %shr477, 6, !dbg !192
  %xor481.3 = xor i32 %add478.3, %and171, !dbg !186
  %mul482.3 = shl nuw nsw i32 %xor481.3, 3, !dbg !187
  %add483.3 = add nuw nsw i32 %mul482.3, %mul9, !dbg !188
  %add488.3 = or disjoint i32 %add483.3, %mul363, !dbg !189
  %add.ptr490.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add488.3, !dbg !190
  store i64 %result.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr490.3, align 8, !dbg !191
  fence syncscope("warp") release, !dbg !193
  tail call void @llvm.mxc.barrier.warp(), !dbg !196
  fence syncscope("warp") acquire, !dbg !197
  %add518 = add nuw nsw i32 %add, %.pre-phi
  %201 = zext nneg i32 %add518 to i64, !dbg !198
  %add.ptr523 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %201, !dbg !199
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr523, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep664, i64 16, i1 false), !dbg !200, !tbaa.struct !201, !call_argsrelate !202
  %gep697.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep664, i32 1024, !dbg !203
  %202 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %201, !dbg !199
  %add.ptr523.1 = getelementptr inbounds i8, ptr addrspace(1) %202, i64 1024, !dbg !199
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr523.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep697.1, i64 16, i1 false), !dbg !200, !tbaa.struct !201, !call_argsrelate !202
  call void @llvm.lifetime.end.p5(i64 16, ptr addrspace(5) %blocks) #12, !dbg !204, !call_argsrelate !43
  ret void, !dbg !204
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
!1 = !DIFile(filename: "/tmp/tmpvxjvv3x2/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpvxjvv3x2/tvm_kernels.maca", directory: "")
!42 = !DILocation(line: 13, column: 3, scope: !40)
!43 = !{i32 -1, i32 0}
!44 = !{i32 0, i32 1024}
!45 = !DILocation(line: 26, column: 3, scope: !40)
!46 = !DILocation(line: 27, column: 42, scope: !40)
!47 = !DILocation(line: 27, column: 28, scope: !40)
!48 = !DILocation(line: 30, column: 3, scope: !40)
!49 = !DILocation(line: 31, column: 17, scope: !40)
!50 = !DILocation(line: 31, column: 15, scope: !40)
!51 = !DILocation(line: 31, column: 81, scope: !40)
!52 = !DILocation(line: 31, column: 5, scope: !40)
!53 = !DILocation(line: 34, column: 26, scope: !40)
!54 = !DILocation(line: 36, column: 5, scope: !40)
!55 = !DILocation(line: 39, column: 71, scope: !40)
!56 = !DILocation(line: 39, column: 50, scope: !40)
!57 = !DILocation(line: 39, column: 173, scope: !40)
!58 = !DILocation(line: 46, column: 75, scope: !40)
!59 = !DILocation(line: 46, column: 54, scope: !40)
!60 = !DILocation(line: 51, column: 3, scope: !40)
!61 = !DILocation(line: 58, column: 3, scope: !40)
!62 = !DILocation(line: 0, scope: !40)
!63 = !DILocation(line: 59, column: 17, scope: !40)
!64 = !DILocation(line: 60, column: 22, scope: !40)
!65 = !DILocation(line: 63, column: 161, scope: !40)
!66 = !DILocation(line: 68, column: 3, scope: !67, inlinedAt: !69)
!67 = distinct !DISubprogram(name: "__barrier_warp", scope: !68, file: !68, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!68 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!69 = distinct !DILocation(line: 192, column: 3, scope: !70, inlinedAt: !71)
!70 = distinct !DISubprogram(name: "__syncwarp", scope: !68, file: !68, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!71 = distinct !DILocation(line: 67, column: 7, scope: !40)
!72 = !DILocation(line: 69, column: 3, scope: !67, inlinedAt: !69)
!73 = !DILocation(line: 70, column: 3, scope: !67, inlinedAt: !69)
!74 = !DILocation(line: 69, column: 27, scope: !40)
!75 = !DILocation(line: 72, column: 37, scope: !40)
!76 = !{i32 -1, i32 3, i32 -1}
!77 = !DILocation(line: 80, column: 170, scope: !40)
!78 = !DILocation(line: 84, column: 33, scope: !40)
!79 = !DILocation(line: 84, column: 45, scope: !40)
!80 = !DILocation(line: 354, column: 10, scope: !81, inlinedAt: !83)
!81 = distinct !DISubprogram(name: "min", scope: !82, file: !82, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!82 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!83 = distinct !DILocation(line: 84, column: 28, scope: !40)
!84 = !DILocation(line: 288, column: 10, scope: !85, inlinedAt: !86)
!85 = distinct !DISubprogram(name: "expf", scope: !82, file: !82, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!86 = distinct !DILocation(line: 84, column: 23, scope: !40)
!87 = !DILocation(line: 85, column: 46, scope: !40)
!88 = !DILocation(line: 75, column: 10, scope: !89, inlinedAt: !91)
!89 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !90, file: !90, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!90 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!91 = distinct !DILocation(line: 984, column: 9, scope: !92, inlinedAt: !94)
!92 = distinct !DISubprogram(name: "__float2half", scope: !93, file: !93, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!93 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!94 = distinct !DILocation(line: 133, column: 53, scope: !95, inlinedAt: !96)
!95 = distinct !DISubprogram(name: "__half", scope: !93, file: !93, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!96 = distinct !DILocation(line: 89, column: 23, scope: !40)
!97 = !DILocation(line: 89, column: 20, scope: !40)
!98 = !DILocation(line: 68, column: 3, scope: !67, inlinedAt: !99)
!99 = distinct !DILocation(line: 192, column: 3, scope: !70, inlinedAt: !100)
!100 = distinct !DILocation(line: 91, column: 7, scope: !40)
!101 = !DILocation(line: 69, column: 3, scope: !67, inlinedAt: !99)
!102 = !DILocation(line: 70, column: 3, scope: !67, inlinedAt: !99)
!103 = !DILocation(line: 92, column: 5, scope: !40)
!104 = !DILocation(line: 94, column: 36, scope: !40)
!105 = !DILocation(line: 94, column: 24, scope: !40)
!106 = !DILocation(line: 95, column: 29, scope: !40)
!107 = !DILocation(line: 97, column: 9, scope: !40)
!108 = !DILocation(line: 100, column: 79, scope: !40)
!109 = !DILocation(line: 100, column: 58, scope: !40)
!110 = !DILocation(line: 100, column: 182, scope: !40)
!111 = !DILocation(line: 107, column: 79, scope: !40)
!112 = !DILocation(line: 107, column: 58, scope: !40)
!113 = !DILocation(line: 112, column: 22, scope: !40)
!114 = !DILocation(line: 115, column: 36, scope: !40)
!115 = !{!26, !26, i64 0}
!116 = !DILocation(line: 120, column: 36, scope: !40)
!117 = !DILocation(line: 58, column: 30, scope: !40)
!118 = !DILocation(line: 93, column: 13, scope: !40)
!119 = !DILocation(line: 93, column: 9, scope: !40)
!120 = !DILocation(line: 58, column: 25, scope: !40)
!121 = distinct !{!121, !61, !122, !32, !123}
!122 = !DILocation(line: 126, column: 3, scope: !40)
!123 = !{!"llvm.loop.unroll.disable"}
!124 = !DILocation(line: 130, column: 26, scope: !40)
!125 = !DILocation(line: 1018, column: 9, scope: !126, inlinedAt: !127)
!126 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !68, file: !68, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!127 = distinct !DILocation(line: 396, column: 10, scope: !128, inlinedAt: !130)
!128 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !129, file: !129, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!129 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!130 = distinct !DILocation(line: 129, column: 24, scope: !131, inlinedAt: !133)
!131 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !132, file: !132, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!132 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!133 = distinct !DILocation(line: 101, column: 14, scope: !134, inlinedAt: !135)
!134 = distinct !DISubprogram(name: "run<float>", scope: !132, file: !132, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!135 = distinct !DILocation(line: 132, column: 14, scope: !40)
!136 = !DILocation(line: 171, column: 37, scope: !137, inlinedAt: !138)
!137 = distinct !DISubprogram(name: "__lane_id", scope: !68, file: !68, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!138 = distinct !DILocation(line: 990, column: 14, scope: !139, inlinedAt: !140)
!139 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !68, file: !68, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!140 = distinct !DILocation(line: 1019, column: 11, scope: !126, inlinedAt: !127)
!141 = !DILocation(line: 171, column: 10, scope: !137, inlinedAt: !138)
!142 = !DILocation(line: 991, column: 20, scope: !139, inlinedAt: !140)
!143 = !DILocation(line: 992, column: 36, scope: !139, inlinedAt: !140)
!144 = !DILocation(line: 992, column: 17, scope: !139, inlinedAt: !140)
!145 = !DILocation(line: 992, column: 11, scope: !139, inlinedAt: !140)
!146 = !DILocation(line: 993, column: 43, scope: !139, inlinedAt: !140)
!147 = !DILocation(line: 993, column: 10, scope: !139, inlinedAt: !140)
!148 = !DILocation(line: 1020, column: 14, scope: !126, inlinedAt: !127)
!149 = !DILocation(line: 25, column: 14, scope: !150, inlinedAt: !151)
!150 = distinct !DISubprogram(name: "operator()<float>", scope: !132, file: !132, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!151 = distinct !DILocation(line: 129, column: 11, scope: !131, inlinedAt: !133)
!152 = !DILocation(line: 1018, column: 9, scope: !126, inlinedAt: !153)
!153 = distinct !DILocation(line: 396, column: 10, scope: !128, inlinedAt: !154)
!154 = distinct !DILocation(line: 129, column: 24, scope: !155, inlinedAt: !156)
!155 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !132, file: !132, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!156 = distinct !DILocation(line: 101, column: 14, scope: !157, inlinedAt: !158)
!157 = distinct !DISubprogram(name: "run<float>", scope: !132, file: !132, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!158 = distinct !DILocation(line: 134, column: 14, scope: !131, inlinedAt: !133)
!159 = !DILocation(line: 171, column: 37, scope: !137, inlinedAt: !160)
!160 = distinct !DILocation(line: 990, column: 14, scope: !139, inlinedAt: !161)
!161 = distinct !DILocation(line: 1019, column: 11, scope: !126, inlinedAt: !153)
!162 = !DILocation(line: 171, column: 10, scope: !137, inlinedAt: !160)
!163 = !DILocation(line: 991, column: 20, scope: !139, inlinedAt: !161)
!164 = !DILocation(line: 992, column: 36, scope: !139, inlinedAt: !161)
!165 = !DILocation(line: 992, column: 17, scope: !139, inlinedAt: !161)
!166 = !DILocation(line: 992, column: 11, scope: !139, inlinedAt: !161)
!167 = !DILocation(line: 993, column: 43, scope: !139, inlinedAt: !161)
!168 = !DILocation(line: 993, column: 10, scope: !139, inlinedAt: !161)
!169 = !DILocation(line: 1020, column: 14, scope: !126, inlinedAt: !153)
!170 = !DILocation(line: 25, column: 14, scope: !150, inlinedAt: !171)
!171 = distinct !DILocation(line: 129, column: 11, scope: !155, inlinedAt: !156)
!172 = !DILocation(line: 134, column: 32, scope: !40)
!173 = !DILocation(line: 134, column: 7, scope: !40)
!174 = !DILocation(line: 142, column: 17, scope: !40)
!175 = !DILocation(line: 142, column: 26, scope: !40)
!176 = !DILocation(line: 75, column: 10, scope: !89, inlinedAt: !177)
!177 = distinct !DILocation(line: 984, column: 9, scope: !92, inlinedAt: !178)
!178 = distinct !DILocation(line: 133, column: 53, scope: !95, inlinedAt: !179)
!179 = distinct !DILocation(line: 148, column: 41, scope: !40)
!180 = !DILocation(line: 148, column: 38, scope: !40)
!181 = !DILocation(line: 68, column: 3, scope: !67, inlinedAt: !182)
!182 = distinct !DILocation(line: 192, column: 3, scope: !70, inlinedAt: !183)
!183 = distinct !DILocation(line: 151, column: 3, scope: !40)
!184 = !DILocation(line: 69, column: 3, scope: !67, inlinedAt: !182)
!185 = !DILocation(line: 70, column: 3, scope: !67, inlinedAt: !182)
!186 = !DILocation(line: 154, column: 121, scope: !40)
!187 = !DILocation(line: 154, column: 149, scope: !40)
!188 = !DILocation(line: 154, column: 77, scope: !40)
!189 = !DILocation(line: 154, column: 155, scope: !40)
!190 = !DILocation(line: 154, column: 40, scope: !40)
!191 = !DILocation(line: 154, column: 198, scope: !40)
!192 = !DILocation(line: 154, column: 92, scope: !40)
!193 = !DILocation(line: 68, column: 3, scope: !67, inlinedAt: !194)
!194 = distinct !DILocation(line: 192, column: 3, scope: !70, inlinedAt: !195)
!195 = distinct !DILocation(line: 156, column: 3, scope: !40)
!196 = !DILocation(line: 69, column: 3, scope: !67, inlinedAt: !194)
!197 = !DILocation(line: 70, column: 3, scope: !67, inlinedAt: !194)
!198 = !DILocation(line: 158, column: 3, scope: !40)
!199 = !DILocation(line: 159, column: 22, scope: !40)
!200 = !DILocation(line: 159, column: 130, scope: !40)
!201 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!202 = !{i32 2, i32 -1, i32 -1, i32 -1}
!203 = !DILocation(line: 159, column: 167, scope: !40)
!204 = !DILocation(line: 161, column: 1, scope: !40)
