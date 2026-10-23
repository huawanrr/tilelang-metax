; ModuleID = '/data/tilelang-metax/race_tests/nsa/experiments/20261014_goal8933/validation_v11_safe/binary/oj11_m1_p0.bc'
source_filename = "/tmp/tmpoopwx1di/tvm_kernels.maca"
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
  %arrayidx30 = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %6, !dbg !49
  %7 = load i32, ptr addrspace(1) %arrayidx30, align 4, !dbg !49, !tbaa !30
  store i32 %7, ptr addrspace(5) %blocks, align 4, !dbg !50, !tbaa !30
  %8 = or disjoint i64 %6, 1, !dbg !51
  %arrayidx30.1 = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %8, !dbg !49
  %9 = load i32, ptr addrspace(1) %arrayidx30.1, align 4, !dbg !49, !tbaa !30
  %arrayidx32.1 = getelementptr inbounds i8, ptr addrspace(5) %blocks, i32 4, !dbg !52
  store i32 %9, ptr addrspace(5) %arrayidx32.1, align 4, !dbg !50, !tbaa !30
  %10 = or disjoint i64 %6, 2, !dbg !51
  %arrayidx30.2 = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %10, !dbg !49
  %11 = load i32, ptr addrspace(1) %arrayidx30.2, align 4, !dbg !49, !tbaa !30
  %arrayidx32.2 = getelementptr inbounds i8, ptr addrspace(5) %blocks, i32 8, !dbg !52
  store i32 %11, ptr addrspace(5) %arrayidx32.2, align 4, !dbg !50, !tbaa !30
  %12 = or disjoint i64 %6, 3, !dbg !51
  %arrayidx30.3 = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %12, !dbg !49
  %13 = load i32, ptr addrspace(1) %arrayidx30.3, align 4, !dbg !49, !tbaa !30
  %arrayidx32.3 = getelementptr inbounds i8, ptr addrspace(5) %blocks, i32 12, !dbg !52
  store i32 %13, ptr addrspace(5) %arrayidx32.3, align 4, !dbg !50, !tbaa !30
  %or.cond = icmp ugt i32 %7, 31, !dbg !53
  %shr41 = lshr i32 %1, 4
  %cmp42.not = icmp ugt i32 %7, %shr41
  %or.cond997 = or i1 %or.cond, %cmp42.not, !dbg !53
  br i1 %or.cond997, label %if.end, label %for.cond43.preheader, !dbg !53

for.cond43.preheader:                             ; preds = %entry
  %mul53 = shl nsw i32 %0, 15
  %mul54 = shl nuw nsw i32 %7, 10
  %mul59 = shl nuw nsw i32 %2, 3
  %add55 = or disjoint i32 %mul59, %mul53
  %add57 = add nuw nsw i32 %add55, %mul54
  %14 = zext nneg i32 %add57 to i64, !dbg !54
  %add.ptr64 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %14, !dbg !55
  %15 = load i32, ptr addrspace(4) %add.ptr64, align 4, !dbg !56, !tbaa !30
  %16 = or disjoint i64 %14, 2, !dbg !57
  %add.ptr64.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %16, !dbg !55
  %17 = load i32, ptr addrspace(4) %add.ptr64.1, align 4, !dbg !56, !tbaa !30
  %18 = or disjoint i64 %14, 4, !dbg !57
  %add.ptr64.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %18, !dbg !55
  %19 = load i32, ptr addrspace(4) %add.ptr64.2, align 4, !dbg !56, !tbaa !30
  %20 = or disjoint i64 %14, 6, !dbg !57
  %add.ptr64.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %20, !dbg !55
  %21 = load i32, ptr addrspace(4) %add.ptr64.3, align 4, !dbg !56, !tbaa !30
  %22 = add nuw nsw i64 %14, 512
  %add.ptr64.1799 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %22, !dbg !55
  %23 = load i32, ptr addrspace(4) %add.ptr64.1799, align 4, !dbg !56, !tbaa !30
  %24 = add nuw nsw i64 %14, 514, !dbg !57
  %add.ptr64.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %24, !dbg !55
  %25 = load i32, ptr addrspace(4) %add.ptr64.1.1, align 4, !dbg !56, !tbaa !30
  %26 = add nuw nsw i64 %14, 516, !dbg !57
  %add.ptr64.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %26, !dbg !55
  %27 = load i32, ptr addrspace(4) %add.ptr64.2.1, align 4, !dbg !56, !tbaa !30
  %28 = add nuw nsw i64 %14, 518, !dbg !57
  %add.ptr64.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %28, !dbg !55
  %29 = load i32, ptr addrspace(4) %add.ptr64.3.1, align 4, !dbg !56, !tbaa !30
  %add.ptr97 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %14, !dbg !58
  %30 = load i32, ptr addrspace(4) %add.ptr97, align 4, !dbg !59, !tbaa !30
  %add.ptr97.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %16, !dbg !58
  %31 = load i32, ptr addrspace(4) %add.ptr97.1, align 4, !dbg !59, !tbaa !30
  %add.ptr97.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %18, !dbg !58
  %32 = load i32, ptr addrspace(4) %add.ptr97.2, align 4, !dbg !59, !tbaa !30
  %add.ptr97.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %20, !dbg !58
  %33 = load i32, ptr addrspace(4) %add.ptr97.3, align 4, !dbg !59, !tbaa !30
  %add.ptr97.1811 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %22, !dbg !58
  %34 = load i32, ptr addrspace(4) %add.ptr97.1811, align 4, !dbg !59, !tbaa !30
  %add.ptr97.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %24, !dbg !58
  %35 = load i32, ptr addrspace(4) %add.ptr97.1.1, align 4, !dbg !59, !tbaa !30
  %add.ptr97.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %26, !dbg !58
  %36 = load i32, ptr addrspace(4) %add.ptr97.2.1, align 4, !dbg !59, !tbaa !30
  %add.ptr97.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %28, !dbg !58
  %37 = load i32, ptr addrspace(4) %add.ptr97.3.1, align 4, !dbg !59, !tbaa !30
  br label %if.end, !dbg !60

if.end:                                           ; preds = %entry, %for.cond43.preheader
  %k.sroa.18.0 = phi i32 [ %29, %for.cond43.preheader ], [ undef, %entry ]
  %k.sroa.16.0 = phi i32 [ %27, %for.cond43.preheader ], [ undef, %entry ]
  %k.sroa.14.0 = phi i32 [ %25, %for.cond43.preheader ], [ undef, %entry ]
  %k.sroa.11.0 = phi i32 [ %23, %for.cond43.preheader ], [ undef, %entry ]
  %k.sroa.9.0 = phi i32 [ %21, %for.cond43.preheader ], [ undef, %entry ]
  %k.sroa.7.0 = phi i32 [ %19, %for.cond43.preheader ], [ undef, %entry ]
  %k.sroa.5.0 = phi i32 [ %17, %for.cond43.preheader ], [ undef, %entry ]
  %k.sroa.0.0 = phi i32 [ %15, %for.cond43.preheader ], [ undef, %entry ]
  %v.sroa.18.0 = phi i32 [ %37, %for.cond43.preheader ], [ undef, %entry ]
  %v.sroa.16.0 = phi i32 [ %36, %for.cond43.preheader ], [ undef, %entry ]
  %v.sroa.14.0 = phi i32 [ %35, %for.cond43.preheader ], [ undef, %entry ]
  %v.sroa.11.0 = phi i32 [ %34, %for.cond43.preheader ], [ undef, %entry ]
  %v.sroa.9.0 = phi i32 [ %33, %for.cond43.preheader ], [ undef, %entry ]
  %v.sroa.7.0 = phi i32 [ %32, %for.cond43.preheader ], [ undef, %entry ]
  %v.sroa.5.0 = phi i32 [ %31, %for.cond43.preheader ], [ undef, %entry ]
  %v.sroa.0.0 = phi i32 [ %30, %for.cond43.preheader ], [ undef, %entry ]
  %38 = shl nuw nsw i32 %2, 3
  %mul151 = and i32 %38, 8128
  %xor731 = and i32 %38, 56
  %call155.masked = and i32 %2, 1016
  %mul157 = xor i32 %xor731, %call155.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul151
  %invariant.gep741 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul157
  %39 = lshr i32 %2, 2
  %mul176 = and i32 %39, 252
  %shr204 = lshr i32 %2, 4
  %and207 = and i32 %2, 7
  %40 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul9
  %invariant.gep753 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 2048
  %mul319 = shl nsw i32 %0, 15
  %add321 = or disjoint i32 %38, %mul319
  %41 = shl nuw nsw i32 %2, 4
  %mul396 = and i32 %41, 16128
  %and401 = lshr i32 %2, 3
  %shr402 = and i32 %and401, 1
  %mul407 = and i32 %39, 4
  %k.sroa.5.0.invariant.gep741.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 4
  %k.sroa.7.0.invariant.gep741.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 8
  %k.sroa.9.0.invariant.gep741.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 12
  %gep742.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 1024
  %k.sroa.14.16.gep742.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 1028
  %k.sroa.16.16.gep742.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 1032
  %k.sroa.18.16.gep742.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 1036
  %xor208 = xor i32 %shr204, %and207
  %add.ptr212.idx = shl nuw nsw i32 %xor208, 4
  %add.ptr212 = getelementptr inbounds i8, ptr addrspace(3) %40, i32 %add.ptr212.idx
  %kb.sroa.6.0.add.ptr212.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr212, i32 8
  %add205.1 = add nuw nsw i32 %shr204, 4
  %xor208.1 = xor i32 %add205.1, %and207
  %add.ptr212.idx.1 = shl nuw nsw i32 %xor208.1, 4
  %add.ptr212.1 = getelementptr inbounds i8, ptr addrspace(3) %40, i32 %add.ptr212.idx.1
  %kb.sroa.6.0.add.ptr212.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr212.1, i32 8
  %v.sroa.5.0.invariant.gep753.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 2052
  %v.sroa.7.0.invariant.gep753.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 2056
  %v.sroa.9.0.invariant.gep753.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 2060
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 3072
  %v.sroa.14.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 3076
  %v.sroa.16.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 3080
  %v.sroa.18.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 3084
  %xor409 = or disjoint i32 %mul407, %shr402
  %mul410 = shl nuw nsw i32 %xor409, 3
  %add411 = or disjoint i32 %mul410, %mul396
  %add414 = or disjoint i32 %add411, %and207
  %gep761 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414
  %add398.1 = or disjoint i32 %mul396, 64
  %add408.1 = or disjoint i32 %mul407, 1
  %xor409.1 = xor i32 %add408.1, %shr402
  %mul410.1 = shl nuw nsw i32 %xor409.1, 3
  %add411.1 = or disjoint i32 %mul410.1, %add398.1
  %add414.1 = or disjoint i32 %add411.1, %and207
  %gep761.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414.1
  %add398.2 = or disjoint i32 %mul396, 128
  %add408.2 = or disjoint i32 %mul407, 2
  %xor409.2 = or disjoint i32 %add408.2, %shr402
  %mul410.2 = shl nuw nsw i32 %xor409.2, 3
  %add411.2 = or disjoint i32 %mul410.2, %add398.2
  %add414.2 = or disjoint i32 %add411.2, %and207
  %gep761.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414.2
  %add398.3 = or disjoint i32 %mul396, 192
  %add408.3 = or disjoint i32 %mul407, 3
  %xor409.3 = xor i32 %add408.3, %shr402
  %mul410.3 = shl nuw nsw i32 %xor409.3, 3
  %add411.3 = or disjoint i32 %mul410.3, %add398.3
  %add414.3 = or disjoint i32 %add411.3, %and207
  %gep761.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414.3
  %add403.1 = or disjoint i32 %shr402, 2
  %xor409.1839 = or disjoint i32 %mul407, %add403.1
  %mul410.1840 = shl nuw nsw i32 %xor409.1839, 3
  %add411.1841 = or disjoint i32 %mul410.1840, %mul396
  %add414.1842 = or disjoint i32 %add411.1841, %and207
  %gep761.1843 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414.1842
  %xor409.1.1 = xor i32 %add408.1, %add403.1
  %mul410.1.1 = shl nuw nsw i32 %xor409.1.1, 3
  %add411.1.1 = or disjoint i32 %mul410.1.1, %add398.1
  %add414.1.1 = or disjoint i32 %add411.1.1, %and207
  %gep761.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414.1.1
  %xor409.2.1 = xor i32 %add408.2, %add403.1
  %mul410.2.1 = shl nuw nsw i32 %xor409.2.1, 3
  %add411.2.1 = or disjoint i32 %mul410.2.1, %add398.2
  %add414.2.1 = or disjoint i32 %add411.2.1, %and207
  %gep761.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414.2.1
  %xor409.3.1 = xor i32 %add408.3, %add403.1
  %mul410.3.1 = shl nuw nsw i32 %xor409.3.1, 3
  %add411.3.1 = or disjoint i32 %mul410.3.1, %add398.3
  %add414.3.1 = or disjoint i32 %add411.3.1, %and207
  %gep761.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414.3.1
  %add403.2 = or disjoint i32 %shr402, 4
  %xor409.2845 = xor i32 %mul407, %add403.2
  %mul410.2846 = shl nuw nsw i32 %xor409.2845, 3
  %add411.2847 = or disjoint i32 %mul410.2846, %mul396
  %add414.2848 = or disjoint i32 %add411.2847, %and207
  %gep761.2849 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414.2848
  %xor409.1.2 = xor i32 %add408.1, %add403.2
  %mul410.1.2 = shl nuw nsw i32 %xor409.1.2, 3
  %add411.1.2 = or disjoint i32 %mul410.1.2, %add398.1
  %add414.1.2 = or disjoint i32 %add411.1.2, %and207
  %gep761.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414.1.2
  %xor409.2.2 = xor i32 %add408.2, %add403.2
  %mul410.2.2 = shl nuw nsw i32 %xor409.2.2, 3
  %add411.2.2 = or disjoint i32 %mul410.2.2, %add398.2
  %add414.2.2 = or disjoint i32 %add411.2.2, %and207
  %gep761.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414.2.2
  %xor409.3.2 = xor i32 %add408.3, %add403.2
  %mul410.3.2 = shl nuw nsw i32 %xor409.3.2, 3
  %add411.3.2 = or disjoint i32 %mul410.3.2, %add398.3
  %add414.3.2 = or disjoint i32 %add411.3.2, %and207
  %gep761.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414.3.2
  %add403.3 = or disjoint i32 %shr402, 6
  %xor409.3851 = xor i32 %mul407, %add403.3
  %mul410.3852 = shl nuw nsw i32 %xor409.3851, 3
  %add411.3853 = or disjoint i32 %mul410.3852, %mul396
  %add414.3854 = or disjoint i32 %add411.3853, %and207
  %gep761.3855 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414.3854
  %xor409.1.3 = xor i32 %add408.1, %add403.3
  %mul410.1.3 = shl nuw nsw i32 %xor409.1.3, 3
  %add411.1.3 = or disjoint i32 %mul410.1.3, %add398.1
  %add414.1.3 = or disjoint i32 %add411.1.3, %and207
  %gep761.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414.1.3
  %xor409.2.3 = xor i32 %add408.2, %add403.3
  %mul410.2.3 = shl nuw nsw i32 %xor409.2.3, 3
  %add411.2.3 = or disjoint i32 %mul410.2.3, %add398.2
  %add414.2.3 = or disjoint i32 %add411.2.3, %and207
  %gep761.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414.2.3
  %xor409.3.3 = xor i32 %add408.3, %add403.3
  %mul410.3.3 = shl nuw nsw i32 %xor409.3.3, 3
  %add411.3.3 = or disjoint i32 %mul410.3.3, %add398.3
  %add414.3.3 = or disjoint i32 %add411.3.3, %and207
  %gep761.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add414.3.3
  br label %for.body129, !dbg !61

for.body129:                                      ; preds = %if.end446.1, %if.end
  %k.sroa.18.1 = phi i32 [ %k.sroa.18.0, %if.end ], [ %k.sroa.18.2.1, %if.end446.1 ]
  %k.sroa.16.1 = phi i32 [ %k.sroa.16.0, %if.end ], [ %k.sroa.16.2.1, %if.end446.1 ]
  %k.sroa.14.1 = phi i32 [ %k.sroa.14.0, %if.end ], [ %k.sroa.14.2.1, %if.end446.1 ]
  %k.sroa.11.1 = phi i32 [ %k.sroa.11.0, %if.end ], [ %k.sroa.11.2.1, %if.end446.1 ]
  %k.sroa.9.1 = phi i32 [ %k.sroa.9.0, %if.end ], [ %k.sroa.9.2.1, %if.end446.1 ]
  %k.sroa.7.1 = phi i32 [ %k.sroa.7.0, %if.end ], [ %k.sroa.7.2.1, %if.end446.1 ]
  %k.sroa.5.1 = phi i32 [ %k.sroa.5.0, %if.end ], [ %k.sroa.5.2.1, %if.end446.1 ]
  %k.sroa.0.1 = phi i32 [ %k.sroa.0.0, %if.end ], [ %k.sroa.0.2.1, %if.end446.1 ]
  %v.sroa.18.1 = phi i32 [ %v.sroa.18.0, %if.end ], [ %v.sroa.18.2.1, %if.end446.1 ]
  %v.sroa.16.1 = phi i32 [ %v.sroa.16.0, %if.end ], [ %v.sroa.16.2.1, %if.end446.1 ]
  %v.sroa.14.1 = phi i32 [ %v.sroa.14.0, %if.end ], [ %v.sroa.14.2.1, %if.end446.1 ]
  %v.sroa.11.1 = phi i32 [ %v.sroa.11.0, %if.end ], [ %v.sroa.11.2.1, %if.end446.1 ]
  %v.sroa.9.1 = phi i32 [ %v.sroa.9.0, %if.end ], [ %v.sroa.9.2.1, %if.end446.1 ]
  %v.sroa.7.1 = phi i32 [ %v.sroa.7.0, %if.end ], [ %v.sroa.7.2.1, %if.end446.1 ]
  %v.sroa.5.1 = phi i32 [ %v.sroa.5.0, %if.end ], [ %v.sroa.5.2.1, %if.end446.1 ]
  %v.sroa.0.1 = phi i32 [ %v.sroa.0.0, %if.end ], [ %v.sroa.0.2.1, %if.end446.1 ]
  %out.sroa.56.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.56.1.1, %if.end446.1 ], !dbg !62
  %out.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.38.1.1, %if.end446.1 ], !dbg !62
  %out.sroa.20.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.20.1.1, %if.end446.1 ], !dbg !62
  %out.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.0.1.1, %if.end446.1 ], !dbg !62
  %partial_sum.sroa.14.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.14.1.1, %if.end446.1 ], !dbg !63
  %partial_sum.sroa.10.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.10.1.1, %if.end446.1 ], !dbg !63
  %partial_sum.sroa.6.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.6.1.1, %if.end446.1 ], !dbg !63
  %partial_sum.sroa.0.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.0.1.1, %if.end446.1 ], !dbg !63
  %prob.sroa.0.0 = phi <4 x half> [ undef, %if.end ], [ %prob.sroa.0.1.1, %if.end446.1 ]
  %s_1.0765 = phi i32 [ 0, %if.end ], [ %inc448.1, %if.end446.1 ]
  %arrayidx131 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %s_1.0765, !dbg !64
  %42 = load i32, ptr addrspace(5) %arrayidx131, align 4, !dbg !64, !tbaa !30
  %or.cond777 = icmp ugt i32 %42, 31, !dbg !65
  %cmp138.not = icmp sgt i32 %42, %shr41
  %or.cond778 = or i1 %or.cond777, %cmp138.not, !dbg !65
  br i1 %or.cond778, label %if.then298, label %for.body143.preheader, !dbg !65

for.body143.preheader:                            ; preds = %for.body129
  store i32 %k.sroa.0.1, ptr addrspace(3) %invariant.gep741, align 16, !dbg !66, !tbaa !30
  store i32 %k.sroa.5.1, ptr addrspace(3) %k.sroa.5.0.invariant.gep741.sroa_idx, align 4, !dbg !66, !tbaa !30
  store i32 %k.sroa.7.1, ptr addrspace(3) %k.sroa.7.0.invariant.gep741.sroa_idx, align 8, !dbg !66, !tbaa !30
  store i32 %k.sroa.9.1, ptr addrspace(3) %k.sroa.9.0.invariant.gep741.sroa_idx, align 4, !dbg !66, !tbaa !30
  store i32 %k.sroa.11.1, ptr addrspace(3) %gep742.1, align 16, !dbg !66, !tbaa !30
  store i32 %k.sroa.14.1, ptr addrspace(3) %k.sroa.14.16.gep742.1.sroa_idx, align 4, !dbg !66, !tbaa !30
  store i32 %k.sroa.16.1, ptr addrspace(3) %k.sroa.16.16.gep742.1.sroa_idx, align 8, !dbg !66, !tbaa !30
  store i32 %k.sroa.18.1, ptr addrspace(3) %k.sroa.18.16.gep742.1.sroa_idx, align 4, !dbg !66, !tbaa !30
  %mul165 = shl nuw nsw i32 %42, 4, !dbg !67
  %add166 = or disjoint i32 %mul165, 15, !dbg !68
  %cmp167 = icmp ult i32 %1, %add166, !dbg !69
  br i1 %cmp167, label %for.cond169.preheader, label %if.end194, !dbg !70

for.cond169.preheader:                            ; preds = %for.body143.preheader
  %add177 = add nuw nsw i32 %mul165, %mul176
  %cmp180.not = icmp ugt i32 %add177, %1, !dbg !71
  %spec.select = select i1 %cmp180.not, float 0xFFF0000000000000, float 0.000000e+00, !dbg !72
  %scores.sroa.0.0.vec.insert882 = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !73
  %cmp180.not.1.not = icmp ult i32 %add177, %1, !dbg !71
  %spec.select.1 = select i1 %cmp180.not.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !72
  %scores.sroa.0.4.vec.insert889 = insertelement <4 x float> %scores.sroa.0.0.vec.insert882, float %spec.select.1, i64 1, !dbg !73
  %add178.2 = or disjoint i32 %add177, 2, !dbg !74
  %cmp180.not.2 = icmp ugt i32 %add178.2, %1, !dbg !71
  %spec.select.2 = select i1 %cmp180.not.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !72
  %scores.sroa.0.8.vec.insert896 = insertelement <4 x float> %scores.sroa.0.4.vec.insert889, float %spec.select.2, i64 2, !dbg !73
  %add178.3 = or disjoint i32 %add177, 3, !dbg !74
  %cmp180.not.3 = icmp ugt i32 %add178.3, %1, !dbg !71
  %spec.select.3 = select i1 %cmp180.not.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !72
  %scores.sroa.0.12.vec.insert903 = insertelement <4 x float> %scores.sroa.0.8.vec.insert896, float %spec.select.3, i64 3, !dbg !73
  br label %if.end194, !dbg !75

if.end194:                                        ; preds = %for.body143.preheader, %for.cond169.preheader
  %scores.sroa.0.1 = phi <4 x float> [ %scores.sroa.0.12.vec.insert903, %for.cond169.preheader ], [ zeroinitializer, %for.body143.preheader ], !dbg !81
  fence syncscope("warp") release, !dbg !75
  tail call void @llvm.mxc.barrier.warp(), !dbg !82
  fence syncscope("warp") acquire, !dbg !83
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr212, align 16, !dbg !84
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr212.sroa_idx, align 8, !dbg !84
  %43 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.1), !dbg !85, !call_argsrelate !86
  %44 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %43), !dbg !85, !call_argsrelate !86
  %kb.sroa.0.0.copyload872 = load <4 x half>, ptr addrspace(3) %add.ptr212.1, align 16, !dbg !84
  %kb.sroa.6.0.copyload873 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr212.1.sroa_idx, align 8, !dbg !84
  %45 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload872, <4 x half> %q.sroa.5.16.copyload, <4 x float> %44), !dbg !85, !call_argsrelate !86
  %46 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload873, <4 x half> %q.sroa.7.16.copyload, <4 x float> %45), !dbg !85, !call_argsrelate !86
  store i32 %v.sroa.0.1, ptr addrspace(3) %invariant.gep753, align 16, !dbg !87, !tbaa !30
  store i32 %v.sroa.5.1, ptr addrspace(3) %v.sroa.5.0.invariant.gep753.sroa_idx, align 4, !dbg !87, !tbaa !30
  store i32 %v.sroa.7.1, ptr addrspace(3) %v.sroa.7.0.invariant.gep753.sroa_idx, align 8, !dbg !87, !tbaa !30
  store i32 %v.sroa.9.1, ptr addrspace(3) %v.sroa.9.0.invariant.gep753.sroa_idx, align 4, !dbg !87, !tbaa !30
  store i32 %v.sroa.11.1, ptr addrspace(3) %gep.1, align 16, !dbg !87, !tbaa !30
  store i32 %v.sroa.14.1, ptr addrspace(3) %v.sroa.14.16.gep.1.sroa_idx, align 4, !dbg !87, !tbaa !30
  store i32 %v.sroa.16.1, ptr addrspace(3) %v.sroa.16.16.gep.1.sroa_idx, align 8, !dbg !87, !tbaa !30
  store i32 %v.sroa.18.1, ptr addrspace(3) %v.sroa.18.16.gep.1.sroa_idx, align 4, !dbg !87, !tbaa !30
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %46, i64 0, !dbg !88
  %mul269 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !89
  %47 = tail call contract noundef float @llvm.minnum.f32(float %mul269, float 0x4024CB5EC0000000), !dbg !90
  %48 = tail call contract noundef float @llvm.exp.f32(float %47), !dbg !94
  %add278 = fadd contract float %partial_sum.sroa.0.0, %48, !dbg !97
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %46, i64 1, !dbg !88
  %mul269.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !89
  %49 = tail call contract noundef float @llvm.minnum.f32(float %mul269.1, float 0x4024CB5EC0000000), !dbg !90
  %50 = tail call contract noundef float @llvm.exp.f32(float %49), !dbg !94
  %add278.1 = fadd contract float %partial_sum.sroa.6.0, %50, !dbg !97
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %46, i64 2, !dbg !88
  %mul269.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !89
  %51 = tail call contract noundef float @llvm.minnum.f32(float %mul269.2, float 0x4024CB5EC0000000), !dbg !90
  %52 = tail call contract noundef float @llvm.exp.f32(float %51), !dbg !94
  %add278.2 = fadd contract float %partial_sum.sroa.10.0, %52, !dbg !97
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %46, i64 3, !dbg !88
  %mul269.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !89
  %53 = tail call contract noundef float @llvm.minnum.f32(float %mul269.3, float 0x4024CB5EC0000000), !dbg !90
  %54 = tail call contract noundef float @llvm.exp.f32(float %53), !dbg !94
  %add278.3 = fadd contract float %partial_sum.sroa.14.0, %54, !dbg !97
  %55 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %48), !dbg !98
  %56 = insertelement <4 x i16> poison, i16 %55, i64 0, !dbg !107
  %57 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %50), !dbg !98
  %58 = insertelement <4 x i16> %56, i16 %57, i64 1, !dbg !107
  %59 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %52), !dbg !98
  %60 = insertelement <4 x i16> %58, i16 %59, i64 2, !dbg !107
  %61 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %54), !dbg !98
  %62 = insertelement <4 x i16> %60, i16 %61, i64 3, !dbg !107
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %62 to <4 x half>, !dbg !107
  fence syncscope("warp") release, !dbg !108
  tail call void @llvm.mxc.barrier.warp(), !dbg !111
  fence syncscope("warp") acquire, !dbg !112
  br label %if.then298, !dbg !113

if.then298:                                       ; preds = %for.body129, %if.end194
  %partial_sum.sroa.14.1 = phi float [ %partial_sum.sroa.14.0, %for.body129 ], [ %add278.3, %if.end194 ], !dbg !81
  %partial_sum.sroa.10.1 = phi float [ %partial_sum.sroa.10.0, %for.body129 ], [ %add278.2, %if.end194 ], !dbg !81
  %partial_sum.sroa.6.1 = phi float [ %partial_sum.sroa.6.0, %for.body129 ], [ %add278.1, %if.end194 ], !dbg !81
  %partial_sum.sroa.0.1 = phi float [ %partial_sum.sroa.0.0, %for.body129 ], [ %add278, %if.end194 ], !dbg !81
  %prob.sroa.0.1 = phi <4 x half> [ %prob.sroa.0.0, %for.body129 ], [ %prob.sroa.0.6.vec.insert, %if.end194 ]
  %add299 = or disjoint i32 %s_1.0765, 1, !dbg !114
  %arrayidx301 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %add299, !dbg !115
  %63 = load i32, ptr addrspace(5) %arrayidx301, align 4, !dbg !115, !tbaa !30
  %or.cond779 = icmp ugt i32 %63, 31, !dbg !116
  %cmp308.not = icmp sgt i32 %63, %shr41
  %or.cond780 = or i1 %or.cond779, %cmp308.not, !dbg !116
  br i1 %or.cond780, label %if.end377, label %for.cond310.preheader, !dbg !116

for.cond310.preheader:                            ; preds = %if.then298
  %mul320 = shl nuw nsw i32 %63, 10
  %add323 = add nuw nsw i32 %add321, %mul320
  %64 = zext nneg i32 %add323 to i64, !dbg !117
  %add.ptr330 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %64, !dbg !118
  %65 = load i32, ptr addrspace(4) %add.ptr330, align 4, !dbg !119, !tbaa !30
  %66 = or disjoint i64 %64, 2, !dbg !120
  %add.ptr330.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %66, !dbg !118
  %67 = load i32, ptr addrspace(4) %add.ptr330.1, align 4, !dbg !119, !tbaa !30
  %68 = or disjoint i64 %64, 4, !dbg !120
  %add.ptr330.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %68, !dbg !118
  %69 = load i32, ptr addrspace(4) %add.ptr330.2, align 4, !dbg !119, !tbaa !30
  %70 = or disjoint i64 %64, 6, !dbg !120
  %add.ptr330.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %70, !dbg !118
  %71 = load i32, ptr addrspace(4) %add.ptr330.3, align 4, !dbg !119, !tbaa !30
  %72 = add nuw nsw i64 %64, 512
  %add.ptr330.1825 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %72, !dbg !118
  %73 = load i32, ptr addrspace(4) %add.ptr330.1825, align 4, !dbg !119, !tbaa !30
  %74 = add nuw nsw i64 %64, 514, !dbg !120
  %add.ptr330.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %74, !dbg !118
  %75 = load i32, ptr addrspace(4) %add.ptr330.1.1, align 4, !dbg !119, !tbaa !30
  %76 = add nuw nsw i64 %64, 516, !dbg !120
  %add.ptr330.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %76, !dbg !118
  %77 = load i32, ptr addrspace(4) %add.ptr330.2.1, align 4, !dbg !119, !tbaa !30
  %78 = add nuw nsw i64 %64, 518, !dbg !120
  %add.ptr330.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %78, !dbg !118
  %79 = load i32, ptr addrspace(4) %add.ptr330.3.1, align 4, !dbg !119, !tbaa !30
  %add.ptr363 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %64, !dbg !121
  %80 = load i32, ptr addrspace(4) %add.ptr363, align 4, !dbg !122, !tbaa !30
  %add.ptr363.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %66, !dbg !121
  %81 = load i32, ptr addrspace(4) %add.ptr363.1, align 4, !dbg !122, !tbaa !30
  %add.ptr363.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %68, !dbg !121
  %82 = load i32, ptr addrspace(4) %add.ptr363.2, align 4, !dbg !122, !tbaa !30
  %add.ptr363.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %70, !dbg !121
  %83 = load i32, ptr addrspace(4) %add.ptr363.3, align 4, !dbg !122, !tbaa !30
  %add.ptr363.1837 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %72, !dbg !121
  %84 = load i32, ptr addrspace(4) %add.ptr363.1837, align 4, !dbg !122, !tbaa !30
  %add.ptr363.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %74, !dbg !121
  %85 = load i32, ptr addrspace(4) %add.ptr363.1.1, align 4, !dbg !122, !tbaa !30
  %add.ptr363.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %76, !dbg !121
  %86 = load i32, ptr addrspace(4) %add.ptr363.2.1, align 4, !dbg !122, !tbaa !30
  %add.ptr363.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %78, !dbg !121
  %87 = load i32, ptr addrspace(4) %add.ptr363.3.1, align 4, !dbg !122, !tbaa !30
  br label %if.end377, !dbg !123

if.end377:                                        ; preds = %for.cond310.preheader, %if.then298
  %k.sroa.18.2 = phi i32 [ %k.sroa.18.1, %if.then298 ], [ %79, %for.cond310.preheader ]
  %k.sroa.16.2 = phi i32 [ %k.sroa.16.1, %if.then298 ], [ %77, %for.cond310.preheader ]
  %k.sroa.14.2 = phi i32 [ %k.sroa.14.1, %if.then298 ], [ %75, %for.cond310.preheader ]
  %k.sroa.11.2 = phi i32 [ %k.sroa.11.1, %if.then298 ], [ %73, %for.cond310.preheader ]
  %k.sroa.9.2 = phi i32 [ %k.sroa.9.1, %if.then298 ], [ %71, %for.cond310.preheader ]
  %k.sroa.7.2 = phi i32 [ %k.sroa.7.1, %if.then298 ], [ %69, %for.cond310.preheader ]
  %k.sroa.5.2 = phi i32 [ %k.sroa.5.1, %if.then298 ], [ %67, %for.cond310.preheader ]
  %k.sroa.0.2 = phi i32 [ %k.sroa.0.1, %if.then298 ], [ %65, %for.cond310.preheader ]
  %v.sroa.18.2 = phi i32 [ %v.sroa.18.1, %if.then298 ], [ %87, %for.cond310.preheader ]
  %v.sroa.16.2 = phi i32 [ %v.sroa.16.1, %if.then298 ], [ %86, %for.cond310.preheader ]
  %v.sroa.14.2 = phi i32 [ %v.sroa.14.1, %if.then298 ], [ %85, %for.cond310.preheader ]
  %v.sroa.11.2 = phi i32 [ %v.sroa.11.1, %if.then298 ], [ %84, %for.cond310.preheader ]
  %v.sroa.9.2 = phi i32 [ %v.sroa.9.1, %if.then298 ], [ %83, %for.cond310.preheader ]
  %v.sroa.7.2 = phi i32 [ %v.sroa.7.1, %if.then298 ], [ %82, %for.cond310.preheader ]
  %v.sroa.5.2 = phi i32 [ %v.sroa.5.1, %if.then298 ], [ %81, %for.cond310.preheader ]
  %v.sroa.0.2 = phi i32 [ %v.sroa.0.1, %if.then298 ], [ %80, %for.cond310.preheader ]
  br i1 %or.cond778, label %if.end446, label %for.cond390.preheader.preheader, !dbg !123

for.cond390.preheader.preheader:                  ; preds = %if.end377
  %88 = load half, ptr addrspace(3) %gep761, align 2, !dbg !124, !tbaa !125
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %88, i64 0, !dbg !124
  %89 = load half, ptr addrspace(3) %gep761.1, align 2, !dbg !124, !tbaa !125
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %89, i64 1, !dbg !124
  %90 = load half, ptr addrspace(3) %gep761.2, align 2, !dbg !124, !tbaa !125
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %90, i64 2, !dbg !124
  %91 = load half, ptr addrspace(3) %gep761.3, align 2, !dbg !124, !tbaa !125
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %91, i64 3, !dbg !124
  %92 = load half, ptr addrspace(3) %gep761.1843, align 2, !dbg !124, !tbaa !125
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %92, i64 0, !dbg !124
  %93 = load half, ptr addrspace(3) %gep761.1.1, align 2, !dbg !124, !tbaa !125
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %93, i64 1, !dbg !124
  %94 = load half, ptr addrspace(3) %gep761.2.1, align 2, !dbg !124, !tbaa !125
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %94, i64 2, !dbg !124
  %95 = load half, ptr addrspace(3) %gep761.3.1, align 2, !dbg !124, !tbaa !125
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %95, i64 3, !dbg !124
  %96 = load half, ptr addrspace(3) %gep761.2849, align 2, !dbg !124, !tbaa !125
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %96, i64 0, !dbg !124
  %97 = load half, ptr addrspace(3) %gep761.1.2, align 2, !dbg !124, !tbaa !125
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %97, i64 1, !dbg !124
  %98 = load half, ptr addrspace(3) %gep761.2.2, align 2, !dbg !124, !tbaa !125
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %98, i64 2, !dbg !124
  %99 = load half, ptr addrspace(3) %gep761.3.2, align 2, !dbg !124, !tbaa !125
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %99, i64 3, !dbg !124
  %100 = load half, ptr addrspace(3) %gep761.3855, align 2, !dbg !124, !tbaa !125
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %100, i64 0, !dbg !124
  %101 = load half, ptr addrspace(3) %gep761.1.3, align 2, !dbg !124, !tbaa !125
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %101, i64 1, !dbg !124
  %102 = load half, ptr addrspace(3) %gep761.2.3, align 2, !dbg !124, !tbaa !125
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %102, i64 2, !dbg !124
  %103 = load half, ptr addrspace(3) %gep761.3.3, align 2, !dbg !124, !tbaa !125
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %103, i64 3, !dbg !124
  %104 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.0.0), !dbg !126
  %105 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.20.0), !dbg !126
  %106 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.38.0), !dbg !126
  %107 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.56.0), !dbg !126
  br label %if.end446, !dbg !127

if.end446:                                        ; preds = %for.cond390.preheader.preheader, %if.end377
  %out.sroa.56.1 = phi <4 x float> [ %out.sroa.56.0, %if.end377 ], [ %107, %for.cond390.preheader.preheader ], !dbg !81
  %out.sroa.38.1 = phi <4 x float> [ %out.sroa.38.0, %if.end377 ], [ %106, %for.cond390.preheader.preheader ], !dbg !81
  %out.sroa.20.1 = phi <4 x float> [ %out.sroa.20.0, %if.end377 ], [ %105, %for.cond390.preheader.preheader ], !dbg !81
  %out.sroa.0.1 = phi <4 x float> [ %out.sroa.0.0, %if.end377 ], [ %104, %for.cond390.preheader.preheader ], !dbg !81
  %inc448 = or disjoint i32 %s_1.0765, 1, !dbg !127
  %arrayidx131.1 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %inc448, !dbg !64
  %108 = load i32, ptr addrspace(5) %arrayidx131.1, align 4, !dbg !64, !tbaa !30
  %or.cond777.1 = icmp ugt i32 %108, 31, !dbg !65
  %cmp138.not.1 = icmp sgt i32 %108, %shr41
  %or.cond778.1 = or i1 %or.cond777.1, %cmp138.not.1, !dbg !65
  br i1 %or.cond778.1, label %if.end296.1, label %for.body143.preheader.1, !dbg !65

for.body143.preheader.1:                          ; preds = %if.end446
  store i32 %k.sroa.0.2, ptr addrspace(3) %invariant.gep741, align 16, !dbg !66, !tbaa !30
  store i32 %k.sroa.5.2, ptr addrspace(3) %k.sroa.5.0.invariant.gep741.sroa_idx, align 4, !dbg !66, !tbaa !30
  store i32 %k.sroa.7.2, ptr addrspace(3) %k.sroa.7.0.invariant.gep741.sroa_idx, align 8, !dbg !66, !tbaa !30
  store i32 %k.sroa.9.2, ptr addrspace(3) %k.sroa.9.0.invariant.gep741.sroa_idx, align 4, !dbg !66, !tbaa !30
  store i32 %k.sroa.11.2, ptr addrspace(3) %gep742.1, align 16, !dbg !66, !tbaa !30
  store i32 %k.sroa.14.2, ptr addrspace(3) %k.sroa.14.16.gep742.1.sroa_idx, align 4, !dbg !66, !tbaa !30
  store i32 %k.sroa.16.2, ptr addrspace(3) %k.sroa.16.16.gep742.1.sroa_idx, align 8, !dbg !66, !tbaa !30
  store i32 %k.sroa.18.2, ptr addrspace(3) %k.sroa.18.16.gep742.1.sroa_idx, align 4, !dbg !66, !tbaa !30
  %mul165.1 = shl nuw nsw i32 %108, 4, !dbg !67
  %add166.1 = or disjoint i32 %mul165.1, 15, !dbg !68
  %cmp167.1 = icmp ult i32 %1, %add166.1, !dbg !69
  br i1 %cmp167.1, label %for.cond169.preheader.1, label %if.end194.1, !dbg !70

for.cond169.preheader.1:                          ; preds = %for.body143.preheader.1
  %add177.1 = add nuw nsw i32 %mul165.1, %mul176
  %cmp180.not.1 = icmp ugt i32 %add177.1, %1, !dbg !71
  %spec.select.1998 = select i1 %cmp180.not.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !72
  %scores.sroa.0.0.vec.insert882.1 = insertelement <4 x float> poison, float %spec.select.1998, i64 0, !dbg !73
  %cmp180.not.1.not.1 = icmp ult i32 %add177.1, %1, !dbg !71
  %spec.select.1.1 = select i1 %cmp180.not.1.not.1, float 0.000000e+00, float 0xFFF0000000000000, !dbg !72
  %scores.sroa.0.4.vec.insert889.1 = insertelement <4 x float> %scores.sroa.0.0.vec.insert882.1, float %spec.select.1.1, i64 1, !dbg !73
  %add178.2.1 = or disjoint i32 %add177.1, 2, !dbg !74
  %cmp180.not.2.1 = icmp ugt i32 %add178.2.1, %1, !dbg !71
  %spec.select.2.1 = select i1 %cmp180.not.2.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !72
  %scores.sroa.0.8.vec.insert896.1 = insertelement <4 x float> %scores.sroa.0.4.vec.insert889.1, float %spec.select.2.1, i64 2, !dbg !73
  %add178.3.1 = or disjoint i32 %add177.1, 3, !dbg !74
  %cmp180.not.3.1 = icmp ugt i32 %add178.3.1, %1, !dbg !71
  %spec.select.3.1 = select i1 %cmp180.not.3.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !72
  %scores.sroa.0.12.vec.insert903.1 = insertelement <4 x float> %scores.sroa.0.8.vec.insert896.1, float %spec.select.3.1, i64 3, !dbg !73
  br label %if.end194.1, !dbg !75

if.end194.1:                                      ; preds = %for.cond169.preheader.1, %for.body143.preheader.1
  %scores.sroa.0.1.1 = phi <4 x float> [ %scores.sroa.0.12.vec.insert903.1, %for.cond169.preheader.1 ], [ zeroinitializer, %for.body143.preheader.1 ], !dbg !81
  fence syncscope("warp") release, !dbg !75
  tail call void @llvm.mxc.barrier.warp(), !dbg !82
  fence syncscope("warp") acquire, !dbg !83
  %kb.sroa.0.0.copyload.1 = load <4 x half>, ptr addrspace(3) %add.ptr212, align 16, !dbg !84
  %kb.sroa.6.0.copyload.1 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr212.sroa_idx, align 8, !dbg !84
  %109 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload.1, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.1.1), !dbg !85, !call_argsrelate !86
  %110 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload.1, <4 x half> %q.sroa.4.0.copyload, <4 x float> %109), !dbg !85, !call_argsrelate !86
  %kb.sroa.0.0.copyload872.1 = load <4 x half>, ptr addrspace(3) %add.ptr212.1, align 16, !dbg !84
  %kb.sroa.6.0.copyload873.1 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr212.1.sroa_idx, align 8, !dbg !84
  %111 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload872.1, <4 x half> %q.sroa.5.16.copyload, <4 x float> %110), !dbg !85, !call_argsrelate !86
  %112 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload873.1, <4 x half> %q.sroa.7.16.copyload, <4 x float> %111), !dbg !85, !call_argsrelate !86
  store i32 %v.sroa.0.2, ptr addrspace(3) %invariant.gep753, align 16, !dbg !87, !tbaa !30
  store i32 %v.sroa.5.2, ptr addrspace(3) %v.sroa.5.0.invariant.gep753.sroa_idx, align 4, !dbg !87, !tbaa !30
  store i32 %v.sroa.7.2, ptr addrspace(3) %v.sroa.7.0.invariant.gep753.sroa_idx, align 8, !dbg !87, !tbaa !30
  store i32 %v.sroa.9.2, ptr addrspace(3) %v.sroa.9.0.invariant.gep753.sroa_idx, align 4, !dbg !87, !tbaa !30
  store i32 %v.sroa.11.2, ptr addrspace(3) %gep.1, align 16, !dbg !87, !tbaa !30
  store i32 %v.sroa.14.2, ptr addrspace(3) %v.sroa.14.16.gep.1.sroa_idx, align 4, !dbg !87, !tbaa !30
  store i32 %v.sroa.16.2, ptr addrspace(3) %v.sroa.16.16.gep.1.sroa_idx, align 8, !dbg !87, !tbaa !30
  store i32 %v.sroa.18.2, ptr addrspace(3) %v.sroa.18.16.gep.1.sroa_idx, align 4, !dbg !87, !tbaa !30
  %scores.sroa.0.0.vec.extract.1 = extractelement <4 x float> %112, i64 0, !dbg !88
  %mul269.1999 = fmul contract float %scores.sroa.0.0.vec.extract.1, 0x3FB99999A0000000, !dbg !89
  %113 = tail call contract noundef float @llvm.minnum.f32(float %mul269.1999, float 0x4024CB5EC0000000), !dbg !90
  %114 = tail call contract noundef float @llvm.exp.f32(float %113), !dbg !94
  %add278.11000 = fadd contract float %partial_sum.sroa.0.1, %114, !dbg !97
  %scores.sroa.0.4.vec.extract.1 = extractelement <4 x float> %112, i64 1, !dbg !88
  %mul269.1.1 = fmul contract float %scores.sroa.0.4.vec.extract.1, 0x3FB99999A0000000, !dbg !89
  %115 = tail call contract noundef float @llvm.minnum.f32(float %mul269.1.1, float 0x4024CB5EC0000000), !dbg !90
  %116 = tail call contract noundef float @llvm.exp.f32(float %115), !dbg !94
  %add278.1.1 = fadd contract float %partial_sum.sroa.6.1, %116, !dbg !97
  %scores.sroa.0.8.vec.extract.1 = extractelement <4 x float> %112, i64 2, !dbg !88
  %mul269.2.1 = fmul contract float %scores.sroa.0.8.vec.extract.1, 0x3FB99999A0000000, !dbg !89
  %117 = tail call contract noundef float @llvm.minnum.f32(float %mul269.2.1, float 0x4024CB5EC0000000), !dbg !90
  %118 = tail call contract noundef float @llvm.exp.f32(float %117), !dbg !94
  %add278.2.1 = fadd contract float %partial_sum.sroa.10.1, %118, !dbg !97
  %scores.sroa.0.12.vec.extract.1 = extractelement <4 x float> %112, i64 3, !dbg !88
  %mul269.3.1 = fmul contract float %scores.sroa.0.12.vec.extract.1, 0x3FB99999A0000000, !dbg !89
  %119 = tail call contract noundef float @llvm.minnum.f32(float %mul269.3.1, float 0x4024CB5EC0000000), !dbg !90
  %120 = tail call contract noundef float @llvm.exp.f32(float %119), !dbg !94
  %add278.3.1 = fadd contract float %partial_sum.sroa.14.1, %120, !dbg !97
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %114), !dbg !98
  %122 = insertelement <4 x i16> poison, i16 %121, i64 0, !dbg !107
  %123 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %116), !dbg !98
  %124 = insertelement <4 x i16> %122, i16 %123, i64 1, !dbg !107
  %125 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %118), !dbg !98
  %126 = insertelement <4 x i16> %124, i16 %125, i64 2, !dbg !107
  %127 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %120), !dbg !98
  %128 = insertelement <4 x i16> %126, i16 %127, i64 3, !dbg !107
  %prob.sroa.0.6.vec.insert.1 = bitcast <4 x i16> %128 to <4 x half>, !dbg !107
  fence syncscope("warp") release, !dbg !108
  tail call void @llvm.mxc.barrier.warp(), !dbg !111
  fence syncscope("warp") acquire, !dbg !112
  br label %if.end296.1, !dbg !113

if.end296.1:                                      ; preds = %if.end194.1, %if.end446
  %partial_sum.sroa.14.1.1 = phi float [ %partial_sum.sroa.14.1, %if.end446 ], [ %add278.3.1, %if.end194.1 ], !dbg !81
  %partial_sum.sroa.10.1.1 = phi float [ %partial_sum.sroa.10.1, %if.end446 ], [ %add278.2.1, %if.end194.1 ], !dbg !81
  %partial_sum.sroa.6.1.1 = phi float [ %partial_sum.sroa.6.1, %if.end446 ], [ %add278.1.1, %if.end194.1 ], !dbg !81
  %partial_sum.sroa.0.1.1 = phi float [ %partial_sum.sroa.0.1, %if.end446 ], [ %add278.11000, %if.end194.1 ], !dbg !81
  %prob.sroa.0.1.1 = phi <4 x half> [ %prob.sroa.0.1, %if.end446 ], [ %prob.sroa.0.6.vec.insert.1, %if.end194.1 ]
  %cmp297.not.1 = icmp eq i32 %s_1.0765, 2, !dbg !128
  br i1 %cmp297.not.1, label %if.end377.1, label %if.then298.1, !dbg !129

if.then298.1:                                     ; preds = %if.end296.1
  %add299.1 = add nuw nsw i32 %s_1.0765, 2, !dbg !114
  %arrayidx301.1 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %add299.1, !dbg !115
  %129 = load i32, ptr addrspace(5) %arrayidx301.1, align 4, !dbg !115, !tbaa !30
  %or.cond779.1 = icmp ugt i32 %129, 31, !dbg !116
  %cmp308.not.1 = icmp sgt i32 %129, %shr41
  %or.cond780.1 = or i1 %or.cond779.1, %cmp308.not.1, !dbg !116
  br i1 %or.cond780.1, label %if.end377.1, label %for.cond310.preheader.1, !dbg !116

for.cond310.preheader.1:                          ; preds = %if.then298.1
  %mul320.1 = shl nuw nsw i32 %129, 10
  %add323.1 = add nuw nsw i32 %add321, %mul320.1
  %130 = zext nneg i32 %add323.1 to i64, !dbg !117
  %add.ptr330.11001 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %130, !dbg !118
  %131 = load i32, ptr addrspace(4) %add.ptr330.11001, align 4, !dbg !119, !tbaa !30
  %132 = or disjoint i64 %130, 2, !dbg !120
  %add.ptr330.1.11002 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %132, !dbg !118
  %133 = load i32, ptr addrspace(4) %add.ptr330.1.11002, align 4, !dbg !119, !tbaa !30
  %134 = or disjoint i64 %130, 4, !dbg !120
  %add.ptr330.2.11003 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %134, !dbg !118
  %135 = load i32, ptr addrspace(4) %add.ptr330.2.11003, align 4, !dbg !119, !tbaa !30
  %136 = or disjoint i64 %130, 6, !dbg !120
  %add.ptr330.3.11004 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %136, !dbg !118
  %137 = load i32, ptr addrspace(4) %add.ptr330.3.11004, align 4, !dbg !119, !tbaa !30
  %138 = add nuw nsw i64 %130, 512
  %add.ptr330.1825.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %138, !dbg !118
  %139 = load i32, ptr addrspace(4) %add.ptr330.1825.1, align 4, !dbg !119, !tbaa !30
  %140 = add nuw nsw i64 %130, 514, !dbg !120
  %add.ptr330.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %140, !dbg !118
  %141 = load i32, ptr addrspace(4) %add.ptr330.1.1.1, align 4, !dbg !119, !tbaa !30
  %142 = add nuw nsw i64 %130, 516, !dbg !120
  %add.ptr330.2.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %142, !dbg !118
  %143 = load i32, ptr addrspace(4) %add.ptr330.2.1.1, align 4, !dbg !119, !tbaa !30
  %144 = add nuw nsw i64 %130, 518, !dbg !120
  %add.ptr330.3.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %144, !dbg !118
  %145 = load i32, ptr addrspace(4) %add.ptr330.3.1.1, align 4, !dbg !119, !tbaa !30
  %add.ptr363.11005 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %130, !dbg !121
  %146 = load i32, ptr addrspace(4) %add.ptr363.11005, align 4, !dbg !122, !tbaa !30
  %add.ptr363.1.11006 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %132, !dbg !121
  %147 = load i32, ptr addrspace(4) %add.ptr363.1.11006, align 4, !dbg !122, !tbaa !30
  %add.ptr363.2.11007 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %134, !dbg !121
  %148 = load i32, ptr addrspace(4) %add.ptr363.2.11007, align 4, !dbg !122, !tbaa !30
  %add.ptr363.3.11008 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %136, !dbg !121
  %149 = load i32, ptr addrspace(4) %add.ptr363.3.11008, align 4, !dbg !122, !tbaa !30
  %add.ptr363.1837.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %138, !dbg !121
  %150 = load i32, ptr addrspace(4) %add.ptr363.1837.1, align 4, !dbg !122, !tbaa !30
  %add.ptr363.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %140, !dbg !121
  %151 = load i32, ptr addrspace(4) %add.ptr363.1.1.1, align 4, !dbg !122, !tbaa !30
  %add.ptr363.2.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %142, !dbg !121
  %152 = load i32, ptr addrspace(4) %add.ptr363.2.1.1, align 4, !dbg !122, !tbaa !30
  %add.ptr363.3.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %144, !dbg !121
  %153 = load i32, ptr addrspace(4) %add.ptr363.3.1.1, align 4, !dbg !122, !tbaa !30
  br label %if.end377.1, !dbg !123

if.end377.1:                                      ; preds = %for.cond310.preheader.1, %if.then298.1, %if.end296.1
  %k.sroa.18.2.1 = phi i32 [ %k.sroa.18.2, %if.end296.1 ], [ %k.sroa.18.2, %if.then298.1 ], [ %145, %for.cond310.preheader.1 ]
  %k.sroa.16.2.1 = phi i32 [ %k.sroa.16.2, %if.end296.1 ], [ %k.sroa.16.2, %if.then298.1 ], [ %143, %for.cond310.preheader.1 ]
  %k.sroa.14.2.1 = phi i32 [ %k.sroa.14.2, %if.end296.1 ], [ %k.sroa.14.2, %if.then298.1 ], [ %141, %for.cond310.preheader.1 ]
  %k.sroa.11.2.1 = phi i32 [ %k.sroa.11.2, %if.end296.1 ], [ %k.sroa.11.2, %if.then298.1 ], [ %139, %for.cond310.preheader.1 ]
  %k.sroa.9.2.1 = phi i32 [ %k.sroa.9.2, %if.end296.1 ], [ %k.sroa.9.2, %if.then298.1 ], [ %137, %for.cond310.preheader.1 ]
  %k.sroa.7.2.1 = phi i32 [ %k.sroa.7.2, %if.end296.1 ], [ %k.sroa.7.2, %if.then298.1 ], [ %135, %for.cond310.preheader.1 ]
  %k.sroa.5.2.1 = phi i32 [ %k.sroa.5.2, %if.end296.1 ], [ %k.sroa.5.2, %if.then298.1 ], [ %133, %for.cond310.preheader.1 ]
  %k.sroa.0.2.1 = phi i32 [ %k.sroa.0.2, %if.end296.1 ], [ %k.sroa.0.2, %if.then298.1 ], [ %131, %for.cond310.preheader.1 ]
  %v.sroa.18.2.1 = phi i32 [ %v.sroa.18.2, %if.end296.1 ], [ %v.sroa.18.2, %if.then298.1 ], [ %153, %for.cond310.preheader.1 ]
  %v.sroa.16.2.1 = phi i32 [ %v.sroa.16.2, %if.end296.1 ], [ %v.sroa.16.2, %if.then298.1 ], [ %152, %for.cond310.preheader.1 ]
  %v.sroa.14.2.1 = phi i32 [ %v.sroa.14.2, %if.end296.1 ], [ %v.sroa.14.2, %if.then298.1 ], [ %151, %for.cond310.preheader.1 ]
  %v.sroa.11.2.1 = phi i32 [ %v.sroa.11.2, %if.end296.1 ], [ %v.sroa.11.2, %if.then298.1 ], [ %150, %for.cond310.preheader.1 ]
  %v.sroa.9.2.1 = phi i32 [ %v.sroa.9.2, %if.end296.1 ], [ %v.sroa.9.2, %if.then298.1 ], [ %149, %for.cond310.preheader.1 ]
  %v.sroa.7.2.1 = phi i32 [ %v.sroa.7.2, %if.end296.1 ], [ %v.sroa.7.2, %if.then298.1 ], [ %148, %for.cond310.preheader.1 ]
  %v.sroa.5.2.1 = phi i32 [ %v.sroa.5.2, %if.end296.1 ], [ %v.sroa.5.2, %if.then298.1 ], [ %147, %for.cond310.preheader.1 ]
  %v.sroa.0.2.1 = phi i32 [ %v.sroa.0.2, %if.end296.1 ], [ %v.sroa.0.2, %if.then298.1 ], [ %146, %for.cond310.preheader.1 ]
  br i1 %or.cond778.1, label %if.end446.1, label %for.cond390.preheader.preheader.1, !dbg !123

for.cond390.preheader.preheader.1:                ; preds = %if.end377.1
  %154 = load half, ptr addrspace(3) %gep761, align 2, !dbg !124, !tbaa !125
  %vb.sroa.0.0.vec.insert.1 = insertelement <4 x half> poison, half %154, i64 0, !dbg !124
  %155 = load half, ptr addrspace(3) %gep761.1, align 2, !dbg !124, !tbaa !125
  %vb.sroa.0.2.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.0.vec.insert.1, half %155, i64 1, !dbg !124
  %156 = load half, ptr addrspace(3) %gep761.2, align 2, !dbg !124, !tbaa !125
  %vb.sroa.0.4.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.2.vec.insert.1, half %156, i64 2, !dbg !124
  %157 = load half, ptr addrspace(3) %gep761.3, align 2, !dbg !124, !tbaa !125
  %vb.sroa.0.6.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.4.vec.insert.1, half %157, i64 3, !dbg !124
  %158 = load half, ptr addrspace(3) %gep761.1843, align 2, !dbg !124, !tbaa !125
  %vb.sroa.7.8.vec.insert.1 = insertelement <4 x half> poison, half %158, i64 0, !dbg !124
  %159 = load half, ptr addrspace(3) %gep761.1.1, align 2, !dbg !124, !tbaa !125
  %vb.sroa.7.10.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.8.vec.insert.1, half %159, i64 1, !dbg !124
  %160 = load half, ptr addrspace(3) %gep761.2.1, align 2, !dbg !124, !tbaa !125
  %vb.sroa.7.12.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.10.vec.insert.1, half %160, i64 2, !dbg !124
  %161 = load half, ptr addrspace(3) %gep761.3.1, align 2, !dbg !124, !tbaa !125
  %vb.sroa.7.14.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.12.vec.insert.1, half %161, i64 3, !dbg !124
  %162 = load half, ptr addrspace(3) %gep761.2849, align 2, !dbg !124, !tbaa !125
  %vb.sroa.12.16.vec.insert.1 = insertelement <4 x half> poison, half %162, i64 0, !dbg !124
  %163 = load half, ptr addrspace(3) %gep761.1.2, align 2, !dbg !124, !tbaa !125
  %vb.sroa.12.18.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.16.vec.insert.1, half %163, i64 1, !dbg !124
  %164 = load half, ptr addrspace(3) %gep761.2.2, align 2, !dbg !124, !tbaa !125
  %vb.sroa.12.20.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.18.vec.insert.1, half %164, i64 2, !dbg !124
  %165 = load half, ptr addrspace(3) %gep761.3.2, align 2, !dbg !124, !tbaa !125
  %vb.sroa.12.22.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.20.vec.insert.1, half %165, i64 3, !dbg !124
  %166 = load half, ptr addrspace(3) %gep761.3855, align 2, !dbg !124, !tbaa !125
  %vb.sroa.17.24.vec.insert.1 = insertelement <4 x half> poison, half %166, i64 0, !dbg !124
  %167 = load half, ptr addrspace(3) %gep761.1.3, align 2, !dbg !124, !tbaa !125
  %vb.sroa.17.26.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.24.vec.insert.1, half %167, i64 1, !dbg !124
  %168 = load half, ptr addrspace(3) %gep761.2.3, align 2, !dbg !124, !tbaa !125
  %vb.sroa.17.28.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.26.vec.insert.1, half %168, i64 2, !dbg !124
  %169 = load half, ptr addrspace(3) %gep761.3.3, align 2, !dbg !124, !tbaa !125
  %vb.sroa.17.30.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.28.vec.insert.1, half %169, i64 3, !dbg !124
  %170 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.0.1), !dbg !126
  %171 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.20.1), !dbg !126
  %172 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.38.1), !dbg !126
  %173 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.56.1), !dbg !126
  br label %if.end446.1, !dbg !127

if.end446.1:                                      ; preds = %for.cond390.preheader.preheader.1, %if.end377.1
  %out.sroa.56.1.1 = phi <4 x float> [ %out.sroa.56.1, %if.end377.1 ], [ %173, %for.cond390.preheader.preheader.1 ], !dbg !81
  %out.sroa.38.1.1 = phi <4 x float> [ %out.sroa.38.1, %if.end377.1 ], [ %172, %for.cond390.preheader.preheader.1 ], !dbg !81
  %out.sroa.20.1.1 = phi <4 x float> [ %out.sroa.20.1, %if.end377.1 ], [ %171, %for.cond390.preheader.preheader.1 ], !dbg !81
  %out.sroa.0.1.1 = phi <4 x float> [ %out.sroa.0.1, %if.end377.1 ], [ %170, %for.cond390.preheader.preheader.1 ], !dbg !81
  %inc448.1 = add nuw nsw i32 %s_1.0765, 2, !dbg !127
  %exitcond.not.1 = icmp eq i32 %inc448.1, 4, !dbg !130
  br i1 %exitcond.not.1, label %for.body454.preheader, label %for.body129, !dbg !61, !llvm.loop !131

for.body454.preheader:                            ; preds = %if.end446.1
  %add458 = fadd contract float %partial_sum.sroa.0.1.1, 0.000000e+00, !dbg !134
  %add458.1 = fadd contract float %add458, %partial_sum.sroa.6.1.1, !dbg !134
  %add458.2 = fadd contract float %add458.1, %partial_sum.sroa.10.1.1, !dbg !134
  %add458.3 = fadd contract float %add458.2, %partial_sum.sroa.14.1.1, !dbg !134
  %174 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add458.3, <4 x float> zeroinitializer), !dbg !135
  %short_sum_out.sroa.0.0.vec.extract = extractelement <4 x float> %174, i64 0, !dbg !136
  %cmp476 = fcmp contract ogt float %short_sum_out.sroa.0.0.vec.extract, 0.000000e+00, !dbg !137
  br i1 %cmp476, label %if.then477, label %if.end492, !dbg !138

if.then477:                                       ; preds = %for.body454.preheader
  %175 = bitcast float %short_sum_out.sroa.0.0.vec.extract to i32, !dbg !139
  %sub = sub i32 2129859011, %175, !dbg !140
  %176 = bitcast i32 %sub to float, !dbg !141
  %mul480 = fmul contract float %short_sum_out.sroa.0.0.vec.extract, %176, !dbg !142
  %sub481 = fsub contract float 2.000000e+00, %mul480, !dbg !143
  %mul482 = fmul contract float %sub481, %176, !dbg !144
  %mul488 = fmul contract float %short_sum_out.sroa.0.0.vec.extract, %mul482, !dbg !145
  %sub489 = fsub contract float 2.000000e+00, %mul488, !dbg !146
  %mul490 = fmul contract float %mul482, %sub489, !dbg !147
  br label %if.end492, !dbg !148

if.end492:                                        ; preds = %for.body454.preheader, %if.then477
  %condval_1.0 = phi float [ %mul490, %if.then477 ], [ 0.000000e+00, %for.body454.preheader ], !dbg !81
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 0, !dbg !149
  %mul501 = fmul contract float %condval_1.0, %out.sroa.0.0.vec.extract, !dbg !150
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 1, !dbg !149
  %mul501.1 = fmul contract float %condval_1.0, %out.sroa.0.4.vec.extract, !dbg !150
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 2, !dbg !149
  %mul501.2 = fmul contract float %condval_1.0, %out.sroa.0.8.vec.extract, !dbg !150
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 3, !dbg !149
  %mul501.3 = fmul contract float %condval_1.0, %out.sroa.0.12.vec.extract, !dbg !150
  %out.sroa.20.16.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 0, !dbg !149
  %mul501.4 = fmul contract float %condval_1.0, %out.sroa.20.16.vec.extract, !dbg !150
  %out.sroa.20.20.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 1, !dbg !149
  %mul501.5 = fmul contract float %condval_1.0, %out.sroa.20.20.vec.extract, !dbg !150
  %out.sroa.20.24.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 2, !dbg !149
  %mul501.6 = fmul contract float %condval_1.0, %out.sroa.20.24.vec.extract, !dbg !150
  %out.sroa.20.28.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 3, !dbg !149
  %mul501.7 = fmul contract float %condval_1.0, %out.sroa.20.28.vec.extract, !dbg !150
  %out.sroa.38.32.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 0, !dbg !149
  %mul501.8 = fmul contract float %condval_1.0, %out.sroa.38.32.vec.extract, !dbg !150
  %out.sroa.38.36.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 1, !dbg !149
  %mul501.9 = fmul contract float %condval_1.0, %out.sroa.38.36.vec.extract, !dbg !150
  %out.sroa.38.40.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 2, !dbg !149
  %mul501.10 = fmul contract float %condval_1.0, %out.sroa.38.40.vec.extract, !dbg !150
  %out.sroa.38.44.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 3, !dbg !149
  %mul501.11 = fmul contract float %condval_1.0, %out.sroa.38.44.vec.extract, !dbg !150
  %out.sroa.56.48.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 0, !dbg !149
  %mul501.12 = fmul contract float %condval_1.0, %out.sroa.56.48.vec.extract, !dbg !150
  %out.sroa.56.52.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 1, !dbg !149
  %mul501.13 = fmul contract float %condval_1.0, %out.sroa.56.52.vec.extract, !dbg !150
  %out.sroa.56.56.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 2, !dbg !149
  %mul501.14 = fmul contract float %condval_1.0, %out.sroa.56.56.vec.extract, !dbg !150
  %out.sroa.56.60.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 3, !dbg !149
  %mul501.15 = fmul contract float %condval_1.0, %out.sroa.56.60.vec.extract, !dbg !150
  %177 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul501), !dbg !151
  %result.sroa.0.0.insert.ext = zext i16 %177 to i64, !dbg !155
  %178 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul501.1), !dbg !151
  %result.sroa.0.2.insert.ext = zext i16 %178 to i64, !dbg !155
  %result.sroa.0.2.insert.shift = shl nuw nsw i64 %result.sroa.0.2.insert.ext, 16, !dbg !155
  %result.sroa.0.2.insert.insert = or disjoint i64 %result.sroa.0.2.insert.shift, %result.sroa.0.0.insert.ext, !dbg !155
  %179 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul501.2), !dbg !151
  %result.sroa.0.4.insert.ext = zext i16 %179 to i64, !dbg !155
  %result.sroa.0.4.insert.shift = shl nuw nsw i64 %result.sroa.0.4.insert.ext, 32, !dbg !155
  %result.sroa.0.4.insert.insert = or disjoint i64 %result.sroa.0.2.insert.insert, %result.sroa.0.4.insert.shift, !dbg !155
  %180 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul501.3), !dbg !151
  %result.sroa.0.6.insert.ext = zext i16 %180 to i64, !dbg !155
  %result.sroa.0.6.insert.shift = shl nuw i64 %result.sroa.0.6.insert.ext, 48, !dbg !155
  %result.sroa.0.6.insert.insert = or disjoint i64 %result.sroa.0.4.insert.insert, %result.sroa.0.6.insert.shift, !dbg !155
  %181 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul501.4), !dbg !151
  %result.sroa.7.8.insert.ext = zext i16 %181 to i64, !dbg !155
  %182 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul501.5), !dbg !151
  %result.sroa.7.10.insert.ext = zext i16 %182 to i64, !dbg !155
  %result.sroa.7.10.insert.shift = shl nuw nsw i64 %result.sroa.7.10.insert.ext, 16, !dbg !155
  %result.sroa.7.10.insert.insert = or disjoint i64 %result.sroa.7.10.insert.shift, %result.sroa.7.8.insert.ext, !dbg !155
  %183 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul501.6), !dbg !151
  %result.sroa.7.12.insert.ext = zext i16 %183 to i64, !dbg !155
  %result.sroa.7.12.insert.shift = shl nuw nsw i64 %result.sroa.7.12.insert.ext, 32, !dbg !155
  %result.sroa.7.12.insert.insert = or disjoint i64 %result.sroa.7.10.insert.insert, %result.sroa.7.12.insert.shift, !dbg !155
  %184 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul501.7), !dbg !151
  %result.sroa.7.14.insert.ext = zext i16 %184 to i64, !dbg !155
  %result.sroa.7.14.insert.shift = shl nuw i64 %result.sroa.7.14.insert.ext, 48, !dbg !155
  %result.sroa.7.14.insert.insert = or disjoint i64 %result.sroa.7.12.insert.insert, %result.sroa.7.14.insert.shift, !dbg !155
  %185 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul501.8), !dbg !151
  %result.sroa.12.16.insert.ext = zext i16 %185 to i64, !dbg !155
  %186 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul501.9), !dbg !151
  %result.sroa.12.18.insert.ext = zext i16 %186 to i64, !dbg !155
  %result.sroa.12.18.insert.shift = shl nuw nsw i64 %result.sroa.12.18.insert.ext, 16, !dbg !155
  %result.sroa.12.18.insert.insert = or disjoint i64 %result.sroa.12.18.insert.shift, %result.sroa.12.16.insert.ext, !dbg !155
  %187 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul501.10), !dbg !151
  %result.sroa.12.20.insert.ext = zext i16 %187 to i64, !dbg !155
  %result.sroa.12.20.insert.shift = shl nuw nsw i64 %result.sroa.12.20.insert.ext, 32, !dbg !155
  %result.sroa.12.20.insert.insert = or disjoint i64 %result.sroa.12.18.insert.insert, %result.sroa.12.20.insert.shift, !dbg !155
  %188 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul501.11), !dbg !151
  %result.sroa.12.22.insert.ext = zext i16 %188 to i64, !dbg !155
  %result.sroa.12.22.insert.shift = shl nuw i64 %result.sroa.12.22.insert.ext, 48, !dbg !155
  %result.sroa.12.22.insert.insert = or disjoint i64 %result.sroa.12.20.insert.insert, %result.sroa.12.22.insert.shift, !dbg !155
  %189 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul501.12), !dbg !151
  %result.sroa.17.24.insert.ext = zext i16 %189 to i64, !dbg !155
  %190 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul501.13), !dbg !151
  %result.sroa.17.26.insert.ext = zext i16 %190 to i64, !dbg !155
  %result.sroa.17.26.insert.shift = shl nuw nsw i64 %result.sroa.17.26.insert.ext, 16, !dbg !155
  %result.sroa.17.26.insert.insert = or disjoint i64 %result.sroa.17.26.insert.shift, %result.sroa.17.24.insert.ext, !dbg !155
  %191 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul501.14), !dbg !151
  %result.sroa.17.28.insert.ext = zext i16 %191 to i64, !dbg !155
  %result.sroa.17.28.insert.shift = shl nuw nsw i64 %result.sroa.17.28.insert.ext, 32, !dbg !155
  %result.sroa.17.28.insert.insert = or disjoint i64 %result.sroa.17.26.insert.insert, %result.sroa.17.28.insert.shift, !dbg !155
  %192 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul501.15), !dbg !151
  %result.sroa.17.30.insert.ext = zext i16 %192 to i64, !dbg !155
  %result.sroa.17.30.insert.shift = shl nuw i64 %result.sroa.17.30.insert.ext, 48, !dbg !155
  %result.sroa.17.30.insert.insert = or disjoint i64 %result.sroa.17.28.insert.insert, %result.sroa.17.30.insert.shift, !dbg !155
  fence syncscope("warp") release, !dbg !156
  tail call void @llvm.mxc.barrier.warp(), !dbg !159
  fence syncscope("warp") acquire, !dbg !160
  %shr543 = lshr i32 %2, 5
  %xor547 = xor i32 %shr543, %and207, !dbg !161
  %mul548 = shl nuw nsw i32 %xor547, 3, !dbg !162
  %add549 = add nuw nsw i32 %mul548, %mul9, !dbg !163
  %add554 = or disjoint i32 %add549, %mul407, !dbg !164
  %add.ptr556 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add554, !dbg !165
  store i64 %result.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr556, align 8, !dbg !166
  %add544.1 = add nuw nsw i32 %shr543, 2, !dbg !167
  %xor547.1 = xor i32 %add544.1, %and207, !dbg !161
  %mul548.1 = shl nuw nsw i32 %xor547.1, 3, !dbg !162
  %add549.1 = add nuw nsw i32 %mul548.1, %mul9, !dbg !163
  %add554.1 = or disjoint i32 %add549.1, %mul407, !dbg !164
  %add.ptr556.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add554.1, !dbg !165
  store i64 %result.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr556.1, align 8, !dbg !166
  %add544.2 = add nuw nsw i32 %shr543, 4, !dbg !167
  %xor547.2 = xor i32 %add544.2, %and207, !dbg !161
  %mul548.2 = shl nuw nsw i32 %xor547.2, 3, !dbg !162
  %add549.2 = add nuw nsw i32 %mul548.2, %mul9, !dbg !163
  %add554.2 = or disjoint i32 %add549.2, %mul407, !dbg !164
  %add.ptr556.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add554.2, !dbg !165
  store i64 %result.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr556.2, align 8, !dbg !166
  %add544.3 = add nuw nsw i32 %shr543, 6, !dbg !167
  %xor547.3 = xor i32 %add544.3, %and207, !dbg !161
  %mul548.3 = shl nuw nsw i32 %xor547.3, 3, !dbg !162
  %add549.3 = add nuw nsw i32 %mul548.3, %mul9, !dbg !163
  %add554.3 = or disjoint i32 %add549.3, %mul407, !dbg !164
  %add.ptr556.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add554.3, !dbg !165
  store i64 %result.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr556.3, align 8, !dbg !166
  fence syncscope("warp") release, !dbg !168
  tail call void @llvm.mxc.barrier.warp(), !dbg !171
  fence syncscope("warp") acquire, !dbg !172
  %add584 = add nuw nsw i32 %add, %38
  %193 = zext nneg i32 %add584 to i64, !dbg !173
  %add.ptr589 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %193, !dbg !174
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr589, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep741, i64 16, i1 false), !dbg !175, !tbaa.struct !176, !call_argsrelate !177
  %gep775.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep741, i32 1024, !dbg !178
  %194 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %193, !dbg !174
  %add.ptr589.1 = getelementptr inbounds i8, ptr addrspace(1) %194, i64 1024, !dbg !174
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr589.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep775.1, i64 16, i1 false), !dbg !175, !tbaa.struct !176, !call_argsrelate !177
  call void @llvm.lifetime.end.p5(i64 16, ptr addrspace(5) %blocks) #12, !dbg !179, !call_argsrelate !43
  ret void, !dbg !179
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p5(i64 immarg, ptr addrspace(5) nocapture) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p5(i64 immarg, ptr addrspace(5) nocapture) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half>, <4 x half>, <4 x float>) #5

; Function Attrs: convergent nounwind willreturn memory(none)
declare <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float, float, <4 x float>) #5

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

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmpoopwx1di/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpoopwx1di/tvm_kernels.maca", directory: "")
!42 = !DILocation(line: 14, column: 3, scope: !40)
!43 = !{i32 -1, i32 0}
!44 = !{i32 0, i32 1024}
!45 = !DILocation(line: 28, column: 3, scope: !40)
!46 = !DILocation(line: 29, column: 42, scope: !40)
!47 = !DILocation(line: 29, column: 28, scope: !40)
!48 = !DILocation(line: 32, column: 3, scope: !40)
!49 = !DILocation(line: 33, column: 17, scope: !40)
!50 = !DILocation(line: 33, column: 15, scope: !40)
!51 = !DILocation(line: 33, column: 81, scope: !40)
!52 = !DILocation(line: 33, column: 5, scope: !40)
!53 = !DILocation(line: 36, column: 27, scope: !40)
!54 = !DILocation(line: 38, column: 5, scope: !40)
!55 = !DILocation(line: 41, column: 71, scope: !40)
!56 = !DILocation(line: 41, column: 50, scope: !40)
!57 = !DILocation(line: 41, column: 173, scope: !40)
!58 = !DILocation(line: 48, column: 75, scope: !40)
!59 = !DILocation(line: 48, column: 54, scope: !40)
!60 = !DILocation(line: 53, column: 3, scope: !40)
!61 = !DILocation(line: 60, column: 3, scope: !40)
!62 = !DILocation(line: 55, column: 33, scope: !40)
!63 = !DILocation(line: 58, column: 31, scope: !40)
!64 = !DILocation(line: 61, column: 17, scope: !40)
!65 = !DILocation(line: 62, column: 23, scope: !40)
!66 = !DILocation(line: 65, column: 161, scope: !40)
!67 = !DILocation(line: 67, column: 39, scope: !40)
!68 = !DILocation(line: 67, column: 45, scope: !40)
!69 = !DILocation(line: 67, column: 29, scope: !40)
!70 = !DILocation(line: 67, column: 11, scope: !40)
!71 = !DILocation(line: 71, column: 73, scope: !40)
!72 = !DILocation(line: 71, column: 15, scope: !40)
!73 = !DILocation(line: 76, column: 23, scope: !40)
!74 = !DILocation(line: 71, column: 66, scope: !40)
!75 = !DILocation(line: 68, column: 3, scope: !76, inlinedAt: !78)
!76 = distinct !DISubprogram(name: "__barrier_warp", scope: !77, file: !77, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!77 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!78 = distinct !DILocation(line: 192, column: 3, scope: !79, inlinedAt: !80)
!79 = distinct !DISubprogram(name: "__syncwarp", scope: !77, file: !77, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!80 = distinct !DILocation(line: 82, column: 7, scope: !40)
!81 = !DILocation(line: 0, scope: !40)
!82 = !DILocation(line: 69, column: 3, scope: !76, inlinedAt: !78)
!83 = !DILocation(line: 70, column: 3, scope: !76, inlinedAt: !78)
!84 = !DILocation(line: 84, column: 27, scope: !40)
!85 = !DILocation(line: 87, column: 37, scope: !40)
!86 = !{i32 -1, i32 3, i32 -1}
!87 = !DILocation(line: 95, column: 170, scope: !40)
!88 = !DILocation(line: 99, column: 33, scope: !40)
!89 = !DILocation(line: 99, column: 45, scope: !40)
!90 = !DILocation(line: 354, column: 10, scope: !91, inlinedAt: !93)
!91 = distinct !DISubprogram(name: "min", scope: !92, file: !92, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!92 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!93 = distinct !DILocation(line: 99, column: 28, scope: !40)
!94 = !DILocation(line: 288, column: 10, scope: !95, inlinedAt: !96)
!95 = distinct !DISubprogram(name: "expf", scope: !92, file: !92, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!96 = distinct !DILocation(line: 99, column: 23, scope: !40)
!97 = !DILocation(line: 100, column: 46, scope: !40)
!98 = !DILocation(line: 75, column: 10, scope: !99, inlinedAt: !101)
!99 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !100, file: !100, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!100 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!101 = distinct !DILocation(line: 984, column: 9, scope: !102, inlinedAt: !104)
!102 = distinct !DISubprogram(name: "__float2half", scope: !103, file: !103, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!103 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!104 = distinct !DILocation(line: 133, column: 53, scope: !105, inlinedAt: !106)
!105 = distinct !DISubprogram(name: "__half", scope: !103, file: !103, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!106 = distinct !DILocation(line: 104, column: 23, scope: !40)
!107 = !DILocation(line: 104, column: 20, scope: !40)
!108 = !DILocation(line: 68, column: 3, scope: !76, inlinedAt: !109)
!109 = distinct !DILocation(line: 192, column: 3, scope: !79, inlinedAt: !110)
!110 = distinct !DILocation(line: 106, column: 7, scope: !40)
!111 = !DILocation(line: 69, column: 3, scope: !76, inlinedAt: !109)
!112 = !DILocation(line: 70, column: 3, scope: !76, inlinedAt: !109)
!113 = !DILocation(line: 107, column: 5, scope: !40)
!114 = !DILocation(line: 109, column: 36, scope: !40)
!115 = !DILocation(line: 109, column: 24, scope: !40)
!116 = !DILocation(line: 110, column: 30, scope: !40)
!117 = !DILocation(line: 112, column: 9, scope: !40)
!118 = !DILocation(line: 115, column: 79, scope: !40)
!119 = !DILocation(line: 115, column: 58, scope: !40)
!120 = !DILocation(line: 115, column: 182, scope: !40)
!121 = !DILocation(line: 122, column: 79, scope: !40)
!122 = !DILocation(line: 122, column: 58, scope: !40)
!123 = !DILocation(line: 127, column: 23, scope: !40)
!124 = !DILocation(line: 130, column: 36, scope: !40)
!125 = !{!26, !26, i64 0}
!126 = !DILocation(line: 135, column: 36, scope: !40)
!127 = !DILocation(line: 60, column: 30, scope: !40)
!128 = !DILocation(line: 108, column: 13, scope: !40)
!129 = !DILocation(line: 108, column: 9, scope: !40)
!130 = !DILocation(line: 60, column: 25, scope: !40)
!131 = distinct !{!131, !61, !132, !32, !133}
!132 = !DILocation(line: 141, column: 3, scope: !40)
!133 = !{!"llvm.loop.unroll.disable"}
!134 = !DILocation(line: 145, column: 32, scope: !40)
!135 = !DILocation(line: 150, column: 44, scope: !40)
!136 = !DILocation(line: 155, column: 34, scope: !40)
!137 = !DILocation(line: 155, column: 32, scope: !40)
!138 = !DILocation(line: 155, column: 7, scope: !40)
!139 = !DILocation(line: 157, column: 37, scope: !40)
!140 = !DILocation(line: 157, column: 34, scope: !40)
!141 = !DILocation(line: 158, column: 20, scope: !40)
!142 = !DILocation(line: 158, column: 88, scope: !40)
!143 = !DILocation(line: 158, column: 68, scope: !40)
!144 = !DILocation(line: 158, column: 41, scope: !40)
!145 = !DILocation(line: 158, column: 162, scope: !40)
!146 = !DILocation(line: 158, column: 142, scope: !40)
!147 = !DILocation(line: 158, column: 115, scope: !40)
!148 = !DILocation(line: 159, column: 3, scope: !40)
!149 = !DILocation(line: 165, column: 17, scope: !40)
!150 = !DILocation(line: 165, column: 26, scope: !40)
!151 = !DILocation(line: 75, column: 10, scope: !99, inlinedAt: !152)
!152 = distinct !DILocation(line: 984, column: 9, scope: !102, inlinedAt: !153)
!153 = distinct !DILocation(line: 133, column: 53, scope: !105, inlinedAt: !154)
!154 = distinct !DILocation(line: 171, column: 41, scope: !40)
!155 = !DILocation(line: 171, column: 38, scope: !40)
!156 = !DILocation(line: 68, column: 3, scope: !76, inlinedAt: !157)
!157 = distinct !DILocation(line: 192, column: 3, scope: !79, inlinedAt: !158)
!158 = distinct !DILocation(line: 174, column: 3, scope: !40)
!159 = !DILocation(line: 69, column: 3, scope: !76, inlinedAt: !157)
!160 = !DILocation(line: 70, column: 3, scope: !76, inlinedAt: !157)
!161 = !DILocation(line: 177, column: 121, scope: !40)
!162 = !DILocation(line: 177, column: 149, scope: !40)
!163 = !DILocation(line: 177, column: 77, scope: !40)
!164 = !DILocation(line: 177, column: 155, scope: !40)
!165 = !DILocation(line: 177, column: 40, scope: !40)
!166 = !DILocation(line: 177, column: 198, scope: !40)
!167 = !DILocation(line: 177, column: 92, scope: !40)
!168 = !DILocation(line: 68, column: 3, scope: !76, inlinedAt: !169)
!169 = distinct !DILocation(line: 192, column: 3, scope: !79, inlinedAt: !170)
!170 = distinct !DILocation(line: 179, column: 3, scope: !40)
!171 = !DILocation(line: 69, column: 3, scope: !76, inlinedAt: !169)
!172 = !DILocation(line: 70, column: 3, scope: !76, inlinedAt: !169)
!173 = !DILocation(line: 181, column: 3, scope: !40)
!174 = !DILocation(line: 182, column: 22, scope: !40)
!175 = !DILocation(line: 182, column: 130, scope: !40)
!176 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!177 = !{i32 2, i32 -1, i32 -1, i32 -1}
!178 = !DILocation(line: 182, column: 167, scope: !40)
!179 = !DILocation(line: 184, column: 1, scope: !40)
