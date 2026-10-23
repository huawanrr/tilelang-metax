; ModuleID = 'experiments/20261016_goal895/readonly_binary/oj11_m3_p0.bc'
source_filename = "/tmp/tmpx4isi4uj/tvm_kernels.maca"
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
  %arrayidx30.val = load i32, ptr addrspace(1) %arrayidx30, align 4, !dbg !50, !tbaa !30
  store i32 %arrayidx30.val, ptr addrspace(5) %blocks, align 4, !dbg !51, !tbaa !30
  %7 = or disjoint i64 %6, 1, !dbg !52
  %arrayidx30.1 = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %7, !dbg !49
  %arrayidx30.val.1 = load i32, ptr addrspace(1) %arrayidx30.1, align 4, !dbg !50, !tbaa !30
  %arrayidx33.1 = getelementptr inbounds i8, ptr addrspace(5) %blocks, i32 4, !dbg !53
  store i32 %arrayidx30.val.1, ptr addrspace(5) %arrayidx33.1, align 4, !dbg !51, !tbaa !30
  %8 = or disjoint i64 %6, 2, !dbg !52
  %arrayidx30.2 = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %8, !dbg !49
  %arrayidx30.val.2 = load i32, ptr addrspace(1) %arrayidx30.2, align 4, !dbg !50, !tbaa !30
  %arrayidx33.2 = getelementptr inbounds i8, ptr addrspace(5) %blocks, i32 8, !dbg !53
  store i32 %arrayidx30.val.2, ptr addrspace(5) %arrayidx33.2, align 4, !dbg !51, !tbaa !30
  %9 = or disjoint i64 %6, 3, !dbg !52
  %arrayidx30.3 = getelementptr inbounds i32, ptr addrspace(1) %Indices.coerce, i64 %9, !dbg !49
  %arrayidx30.val.3 = load i32, ptr addrspace(1) %arrayidx30.3, align 4, !dbg !50, !tbaa !30
  %arrayidx33.3 = getelementptr inbounds i8, ptr addrspace(5) %blocks, i32 12, !dbg !53
  store i32 %arrayidx30.val.3, ptr addrspace(5) %arrayidx33.3, align 4, !dbg !51, !tbaa !30
  %or.cond = icmp ugt i32 %arrayidx30.val, 31, !dbg !54
  %shr42 = lshr i32 %1, 4
  %cmp43.not = icmp ugt i32 %arrayidx30.val, %shr42
  %or.cond1093 = or i1 %or.cond, %cmp43.not, !dbg !54
  br i1 %or.cond1093, label %if.end, label %for.cond44.preheader, !dbg !54

for.cond44.preheader:                             ; preds = %entry
  %mul58 = shl nsw i32 %0, 15
  %mul59 = shl nuw nsw i32 %arrayidx30.val, 10
  %mul64 = shl nuw nsw i32 %2, 3
  %add60 = or disjoint i32 %mul64, %mul58
  %add62 = add nuw nsw i32 %add60, %mul59
  %10 = zext nneg i32 %add62 to i64, !dbg !55
  %arrayidx70 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %10, !dbg !56
  %11 = load <2 x i16>, ptr addrspace(4) %arrayidx70, align 2, !dbg !57, !tbaa !58
  %12 = or disjoint i64 %10, 2
  %arrayidx70.1856 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %12, !dbg !56
  %13 = load <2 x i16>, ptr addrspace(4) %arrayidx70.1856, align 2, !dbg !57, !tbaa !58
  %14 = or disjoint i64 %10, 4
  %arrayidx70.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %14, !dbg !56
  %15 = load <2 x i16>, ptr addrspace(4) %arrayidx70.2, align 2, !dbg !57, !tbaa !58
  %16 = or disjoint i64 %10, 6
  %arrayidx70.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %16, !dbg !56
  %17 = load <2 x i16>, ptr addrspace(4) %arrayidx70.3, align 2, !dbg !57, !tbaa !58
  %18 = add nuw nsw i64 %10, 512
  %arrayidx70.1863 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %18, !dbg !56
  %19 = load <2 x i16>, ptr addrspace(4) %arrayidx70.1863, align 2, !dbg !57, !tbaa !58
  %20 = add nuw nsw i64 %10, 514
  %arrayidx70.1856.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %20, !dbg !56
  %21 = load <2 x i16>, ptr addrspace(4) %arrayidx70.1856.1, align 2, !dbg !57, !tbaa !58
  %22 = add nuw nsw i64 %10, 516
  %arrayidx70.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %22, !dbg !56
  %23 = load <2 x i16>, ptr addrspace(4) %arrayidx70.2.1, align 2, !dbg !57, !tbaa !58
  %24 = add nuw nsw i64 %10, 518
  %arrayidx70.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %24, !dbg !56
  %25 = load <2 x i16>, ptr addrspace(4) %arrayidx70.3.1, align 2, !dbg !57, !tbaa !58
  %arrayidx113 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %10, !dbg !59
  %26 = load <2 x i16>, ptr addrspace(4) %arrayidx113, align 2, !dbg !60, !tbaa !58
  %arrayidx113.1877 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %12, !dbg !59
  %27 = load <2 x i16>, ptr addrspace(4) %arrayidx113.1877, align 2, !dbg !60, !tbaa !58
  %arrayidx113.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %14, !dbg !59
  %28 = load <2 x i16>, ptr addrspace(4) %arrayidx113.2, align 2, !dbg !60, !tbaa !58
  %arrayidx113.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %16, !dbg !59
  %29 = load <2 x i16>, ptr addrspace(4) %arrayidx113.3, align 2, !dbg !60, !tbaa !58
  %arrayidx113.1884 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %18, !dbg !59
  %30 = load <2 x i16>, ptr addrspace(4) %arrayidx113.1884, align 2, !dbg !60, !tbaa !58
  %arrayidx113.1877.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %20, !dbg !59
  %31 = load <2 x i16>, ptr addrspace(4) %arrayidx113.1877.1, align 2, !dbg !60, !tbaa !58
  %arrayidx113.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %22, !dbg !59
  %32 = load <2 x i16>, ptr addrspace(4) %arrayidx113.2.1, align 2, !dbg !60, !tbaa !58
  %arrayidx113.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %24, !dbg !59
  %33 = load <2 x i16>, ptr addrspace(4) %arrayidx113.3.1, align 2, !dbg !60, !tbaa !58
  br label %if.end, !dbg !61

if.end:                                           ; preds = %entry, %for.cond44.preheader
  %34 = phi <2 x i16> [ %26, %for.cond44.preheader ], [ undef, %entry ]
  %35 = phi <2 x i16> [ %27, %for.cond44.preheader ], [ undef, %entry ]
  %36 = phi <2 x i16> [ %28, %for.cond44.preheader ], [ undef, %entry ]
  %37 = phi <2 x i16> [ %29, %for.cond44.preheader ], [ undef, %entry ]
  %38 = phi <2 x i16> [ %30, %for.cond44.preheader ], [ undef, %entry ]
  %39 = phi <2 x i16> [ %31, %for.cond44.preheader ], [ undef, %entry ]
  %40 = phi <2 x i16> [ %32, %for.cond44.preheader ], [ undef, %entry ]
  %41 = phi <2 x i16> [ %33, %for.cond44.preheader ], [ undef, %entry ]
  %42 = phi <2 x i16> [ %11, %for.cond44.preheader ], [ undef, %entry ]
  %43 = phi <2 x i16> [ %13, %for.cond44.preheader ], [ undef, %entry ]
  %44 = phi <2 x i16> [ %15, %for.cond44.preheader ], [ undef, %entry ]
  %45 = phi <2 x i16> [ %17, %for.cond44.preheader ], [ undef, %entry ]
  %46 = phi <2 x i16> [ %19, %for.cond44.preheader ], [ undef, %entry ]
  %47 = phi <2 x i16> [ %21, %for.cond44.preheader ], [ undef, %entry ]
  %48 = phi <2 x i16> [ %23, %for.cond44.preheader ], [ undef, %entry ]
  %49 = phi <2 x i16> [ %25, %for.cond44.preheader ], [ undef, %entry ]
  %50 = shl nuw nsw i32 %2, 3
  %mul173 = and i32 %50, 8128
  %xor787 = and i32 %50, 56
  %call177.masked = and i32 %2, 1016
  %mul179 = xor i32 %xor787, %call177.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul173
  %invariant.gep799 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul179
  %51 = lshr i32 %2, 2
  %mul198 = and i32 %51, 252
  %shr226 = lshr i32 %2, 4
  %and229 = and i32 %2, 7
  %52 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul9
  %invariant.gep811 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep799, i32 2048
  %mul346 = shl nsw i32 %0, 15
  %add348 = or disjoint i32 %50, %mul346
  %53 = shl nuw nsw i32 %2, 4
  %mul440 = and i32 %53, 16128
  %and445 = lshr i32 %2, 3
  %shr446 = and i32 %and445, 1
  %mul451 = and i32 %51, 4
  %k.sroa.7.0.invariant.gep799.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep799, i32 4
  %k.sroa.11.0.invariant.gep799.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep799, i32 8
  %k.sroa.15.0.invariant.gep799.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep799, i32 12
  %gep800.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep799, i32 1024
  %k.sroa.24.16.gep800.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep799, i32 1028
  %k.sroa.28.16.gep800.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep799, i32 1032
  %k.sroa.32.16.gep800.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep799, i32 1036
  %xor230 = xor i32 %shr226, %and229
  %add.ptr234.idx = shl nuw nsw i32 %xor230, 4
  %add.ptr234 = getelementptr inbounds i8, ptr addrspace(3) %52, i32 %add.ptr234.idx
  %kb.sroa.6.0.add.ptr234.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr234, i32 8
  %add227.1 = add nuw nsw i32 %shr226, 4
  %xor230.1 = xor i32 %add227.1, %and229
  %add.ptr234.idx.1 = shl nuw nsw i32 %xor230.1, 4
  %add.ptr234.1 = getelementptr inbounds i8, ptr addrspace(3) %52, i32 %add.ptr234.idx.1
  %kb.sroa.6.0.add.ptr234.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr234.1, i32 8
  %v.sroa.7.0.invariant.gep811.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep799, i32 2052
  %v.sroa.11.0.invariant.gep811.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep799, i32 2056
  %v.sroa.15.0.invariant.gep811.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep799, i32 2060
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep799, i32 3072
  %v.sroa.24.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep799, i32 3076
  %v.sroa.28.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep799, i32 3080
  %v.sroa.32.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep799, i32 3084
  %xor453 = or disjoint i32 %mul451, %shr446
  %mul454 = shl nuw nsw i32 %xor453, 3
  %add455 = or disjoint i32 %mul454, %mul440
  %add458 = or disjoint i32 %add455, %and229
  %gep821 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add458
  %add442.1 = or disjoint i32 %mul440, 64
  %add452.1 = or disjoint i32 %mul451, 1
  %xor453.1 = xor i32 %add452.1, %shr446
  %mul454.1 = shl nuw nsw i32 %xor453.1, 3
  %add455.1 = or disjoint i32 %mul454.1, %add442.1
  %add458.1 = or disjoint i32 %add455.1, %and229
  %gep821.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add458.1
  %add442.2 = or disjoint i32 %mul440, 128
  %add452.2 = or disjoint i32 %mul451, 2
  %xor453.2 = or disjoint i32 %add452.2, %shr446
  %mul454.2 = shl nuw nsw i32 %xor453.2, 3
  %add455.2 = or disjoint i32 %mul454.2, %add442.2
  %add458.2 = or disjoint i32 %add455.2, %and229
  %gep821.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add458.2
  %add442.3 = or disjoint i32 %mul440, 192
  %add452.3 = or disjoint i32 %mul451, 3
  %xor453.3 = xor i32 %add452.3, %shr446
  %mul454.3 = shl nuw nsw i32 %xor453.3, 3
  %add455.3 = or disjoint i32 %mul454.3, %add442.3
  %add458.3 = or disjoint i32 %add455.3, %and229
  %gep821.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add458.3
  %add447.1 = or disjoint i32 %shr446, 2
  %xor453.1935 = or disjoint i32 %mul451, %add447.1
  %mul454.1936 = shl nuw nsw i32 %xor453.1935, 3
  %add455.1937 = or disjoint i32 %mul454.1936, %mul440
  %add458.1938 = or disjoint i32 %add455.1937, %and229
  %gep821.1939 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add458.1938
  %xor453.1.1 = xor i32 %add452.1, %add447.1
  %mul454.1.1 = shl nuw nsw i32 %xor453.1.1, 3
  %add455.1.1 = or disjoint i32 %mul454.1.1, %add442.1
  %add458.1.1 = or disjoint i32 %add455.1.1, %and229
  %gep821.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add458.1.1
  %xor453.2.1 = xor i32 %add452.2, %add447.1
  %mul454.2.1 = shl nuw nsw i32 %xor453.2.1, 3
  %add455.2.1 = or disjoint i32 %mul454.2.1, %add442.2
  %add458.2.1 = or disjoint i32 %add455.2.1, %and229
  %gep821.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add458.2.1
  %xor453.3.1 = xor i32 %add452.3, %add447.1
  %mul454.3.1 = shl nuw nsw i32 %xor453.3.1, 3
  %add455.3.1 = or disjoint i32 %mul454.3.1, %add442.3
  %add458.3.1 = or disjoint i32 %add455.3.1, %and229
  %gep821.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add458.3.1
  %add447.2 = or disjoint i32 %shr446, 4
  %xor453.2941 = xor i32 %mul451, %add447.2
  %mul454.2942 = shl nuw nsw i32 %xor453.2941, 3
  %add455.2943 = or disjoint i32 %mul454.2942, %mul440
  %add458.2944 = or disjoint i32 %add455.2943, %and229
  %gep821.2945 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add458.2944
  %xor453.1.2 = xor i32 %add452.1, %add447.2
  %mul454.1.2 = shl nuw nsw i32 %xor453.1.2, 3
  %add455.1.2 = or disjoint i32 %mul454.1.2, %add442.1
  %add458.1.2 = or disjoint i32 %add455.1.2, %and229
  %gep821.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add458.1.2
  %xor453.2.2 = xor i32 %add452.2, %add447.2
  %mul454.2.2 = shl nuw nsw i32 %xor453.2.2, 3
  %add455.2.2 = or disjoint i32 %mul454.2.2, %add442.2
  %add458.2.2 = or disjoint i32 %add455.2.2, %and229
  %gep821.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add458.2.2
  %xor453.3.2 = xor i32 %add452.3, %add447.2
  %mul454.3.2 = shl nuw nsw i32 %xor453.3.2, 3
  %add455.3.2 = or disjoint i32 %mul454.3.2, %add442.3
  %add458.3.2 = or disjoint i32 %add455.3.2, %and229
  %gep821.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add458.3.2
  %add447.3 = or disjoint i32 %shr446, 6
  %xor453.3947 = xor i32 %mul451, %add447.3
  %mul454.3948 = shl nuw nsw i32 %xor453.3947, 3
  %add455.3949 = or disjoint i32 %mul454.3948, %mul440
  %add458.3950 = or disjoint i32 %add455.3949, %and229
  %gep821.3951 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add458.3950
  %xor453.1.3 = xor i32 %add452.1, %add447.3
  %mul454.1.3 = shl nuw nsw i32 %xor453.1.3, 3
  %add455.1.3 = or disjoint i32 %mul454.1.3, %add442.1
  %add458.1.3 = or disjoint i32 %add455.1.3, %and229
  %gep821.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add458.1.3
  %xor453.2.3 = xor i32 %add452.2, %add447.3
  %mul454.2.3 = shl nuw nsw i32 %xor453.2.3, 3
  %add455.2.3 = or disjoint i32 %mul454.2.3, %add442.2
  %add458.2.3 = or disjoint i32 %add455.2.3, %and229
  %gep821.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add458.2.3
  %xor453.3.3 = xor i32 %add452.3, %add447.3
  %mul454.3.3 = shl nuw nsw i32 %xor453.3.3, 3
  %add455.3.3 = or disjoint i32 %mul454.3.3, %add442.3
  %add458.3.3 = or disjoint i32 %add455.3.3, %and229
  %gep821.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) getelementptr inbounds (i8, ptr addrspace(3) @buf_dyn_shmem, i32 2048), i32 %add458.3.3
  br label %for.body151, !dbg !62

for.body151:                                      ; preds = %if.end490.1, %if.end
  %out.sroa.56.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.56.1.1, %if.end490.1 ], !dbg !63
  %out.sroa.38.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.38.1.1, %if.end490.1 ], !dbg !63
  %out.sroa.20.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.20.1.1, %if.end490.1 ], !dbg !63
  %out.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end ], [ %out.sroa.0.1.1, %if.end490.1 ], !dbg !63
  %partial_sum.sroa.14.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.14.1.1, %if.end490.1 ], !dbg !64
  %partial_sum.sroa.10.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.10.1.1, %if.end490.1 ], !dbg !64
  %partial_sum.sroa.6.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.6.1.1, %if.end490.1 ], !dbg !64
  %partial_sum.sroa.0.0 = phi float [ 0.000000e+00, %if.end ], [ %partial_sum.sroa.0.1.1, %if.end490.1 ], !dbg !64
  %prob.sroa.0.0 = phi <4 x half> [ undef, %if.end ], [ %prob.sroa.0.1.1, %if.end490.1 ]
  %s_1.0825 = phi i32 [ 0, %if.end ], [ %inc492.1, %if.end490.1 ]
  %54 = phi <2 x i16> [ %34, %if.end ], [ %198, %if.end490.1 ]
  %55 = phi <2 x i16> [ %35, %if.end ], [ %199, %if.end490.1 ]
  %56 = phi <2 x i16> [ %36, %if.end ], [ %200, %if.end490.1 ]
  %57 = phi <2 x i16> [ %37, %if.end ], [ %201, %if.end490.1 ]
  %58 = phi <2 x i16> [ %38, %if.end ], [ %202, %if.end490.1 ]
  %59 = phi <2 x i16> [ %39, %if.end ], [ %203, %if.end490.1 ]
  %60 = phi <2 x i16> [ %40, %if.end ], [ %204, %if.end490.1 ]
  %61 = phi <2 x i16> [ %41, %if.end ], [ %205, %if.end490.1 ]
  %62 = phi <2 x i16> [ %42, %if.end ], [ %206, %if.end490.1 ]
  %63 = phi <2 x i16> [ %43, %if.end ], [ %207, %if.end490.1 ]
  %64 = phi <2 x i16> [ %44, %if.end ], [ %208, %if.end490.1 ]
  %65 = phi <2 x i16> [ %45, %if.end ], [ %209, %if.end490.1 ]
  %66 = phi <2 x i16> [ %46, %if.end ], [ %210, %if.end490.1 ]
  %67 = phi <2 x i16> [ %47, %if.end ], [ %211, %if.end490.1 ]
  %68 = phi <2 x i16> [ %48, %if.end ], [ %212, %if.end490.1 ]
  %69 = phi <2 x i16> [ %49, %if.end ], [ %213, %if.end490.1 ]
  %arrayidx153 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %s_1.0825, !dbg !65
  %70 = load i32, ptr addrspace(5) %arrayidx153, align 4, !dbg !65, !tbaa !30
  %or.cond837 = icmp ugt i32 %70, 31, !dbg !66
  %cmp160.not = icmp sgt i32 %70, %shr42
  %or.cond838 = or i1 %or.cond837, %cmp160.not, !dbg !66
  br i1 %or.cond838, label %if.then320, label %for.body165.preheader, !dbg !66

for.body165.preheader:                            ; preds = %for.body151
  store <2 x i16> %62, ptr addrspace(3) %invariant.gep799, align 16, !dbg !67
  store <2 x i16> %63, ptr addrspace(3) %k.sroa.7.0.invariant.gep799.sroa_idx, align 4, !dbg !67
  store <2 x i16> %64, ptr addrspace(3) %k.sroa.11.0.invariant.gep799.sroa_idx, align 8, !dbg !67
  store <2 x i16> %65, ptr addrspace(3) %k.sroa.15.0.invariant.gep799.sroa_idx, align 4, !dbg !67
  store <2 x i16> %66, ptr addrspace(3) %gep800.1, align 16, !dbg !67
  store <2 x i16> %67, ptr addrspace(3) %k.sroa.24.16.gep800.1.sroa_idx, align 4, !dbg !67
  store <2 x i16> %68, ptr addrspace(3) %k.sroa.28.16.gep800.1.sroa_idx, align 8, !dbg !67
  store <2 x i16> %69, ptr addrspace(3) %k.sroa.32.16.gep800.1.sroa_idx, align 4, !dbg !67
  %mul187 = shl nuw nsw i32 %70, 4, !dbg !68
  %add188 = or disjoint i32 %mul187, 15, !dbg !69
  %cmp189 = icmp ult i32 %1, %add188, !dbg !70
  br i1 %cmp189, label %for.cond191.preheader, label %if.end216, !dbg !71

for.cond191.preheader:                            ; preds = %for.body165.preheader
  %add199 = add nuw nsw i32 %mul187, %mul198
  %cmp202.not = icmp ugt i32 %add199, %1, !dbg !72
  %spec.select = select i1 %cmp202.not, float 0xFFF0000000000000, float 0.000000e+00, !dbg !73
  %scores.sroa.0.0.vec.insert978 = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !74
  %cmp202.not.1.not = icmp ult i32 %add199, %1, !dbg !72
  %spec.select.1 = select i1 %cmp202.not.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !73
  %scores.sroa.0.4.vec.insert985 = insertelement <4 x float> %scores.sroa.0.0.vec.insert978, float %spec.select.1, i64 1, !dbg !74
  %add200.2 = or disjoint i32 %add199, 2, !dbg !75
  %cmp202.not.2 = icmp ugt i32 %add200.2, %1, !dbg !72
  %spec.select.2 = select i1 %cmp202.not.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !73
  %scores.sroa.0.8.vec.insert992 = insertelement <4 x float> %scores.sroa.0.4.vec.insert985, float %spec.select.2, i64 2, !dbg !74
  %add200.3 = or disjoint i32 %add199, 3, !dbg !75
  %cmp202.not.3 = icmp ugt i32 %add200.3, %1, !dbg !72
  %spec.select.3 = select i1 %cmp202.not.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !73
  %scores.sroa.0.12.vec.insert999 = insertelement <4 x float> %scores.sroa.0.8.vec.insert992, float %spec.select.3, i64 3, !dbg !74
  br label %if.end216, !dbg !76

if.end216:                                        ; preds = %for.body165.preheader, %for.cond191.preheader
  %scores.sroa.0.1 = phi <4 x float> [ %scores.sroa.0.12.vec.insert999, %for.cond191.preheader ], [ zeroinitializer, %for.body165.preheader ], !dbg !82
  fence syncscope("warp") release, !dbg !76
  tail call void @llvm.mxc.barrier.warp(), !dbg !83
  fence syncscope("warp") acquire, !dbg !84
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr234, align 16, !dbg !85
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr234.sroa_idx, align 8, !dbg !85
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.1), !dbg !86, !call_argsrelate !87
  %72 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %q.sroa.4.0.copyload, <4 x float> %71), !dbg !86, !call_argsrelate !87
  %kb.sroa.0.0.copyload968 = load <4 x half>, ptr addrspace(3) %add.ptr234.1, align 16, !dbg !85
  %kb.sroa.6.0.copyload969 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr234.1.sroa_idx, align 8, !dbg !85
  %73 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload968, <4 x half> %q.sroa.5.16.copyload, <4 x float> %72), !dbg !86, !call_argsrelate !87
  %74 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload969, <4 x half> %q.sroa.7.16.copyload, <4 x float> %73), !dbg !86, !call_argsrelate !87
  store <2 x i16> %54, ptr addrspace(3) %invariant.gep811, align 16, !dbg !88
  store <2 x i16> %55, ptr addrspace(3) %v.sroa.7.0.invariant.gep811.sroa_idx, align 4, !dbg !88
  store <2 x i16> %56, ptr addrspace(3) %v.sroa.11.0.invariant.gep811.sroa_idx, align 8, !dbg !88
  store <2 x i16> %57, ptr addrspace(3) %v.sroa.15.0.invariant.gep811.sroa_idx, align 4, !dbg !88
  store <2 x i16> %58, ptr addrspace(3) %gep.1, align 16, !dbg !88
  store <2 x i16> %59, ptr addrspace(3) %v.sroa.24.16.gep.1.sroa_idx, align 4, !dbg !88
  store <2 x i16> %60, ptr addrspace(3) %v.sroa.28.16.gep.1.sroa_idx, align 8, !dbg !88
  store <2 x i16> %61, ptr addrspace(3) %v.sroa.32.16.gep.1.sroa_idx, align 4, !dbg !88
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %74, i64 0, !dbg !89
  %mul291 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !90
  %75 = tail call contract noundef float @llvm.minnum.f32(float %mul291, float 0x4024CB5EC0000000), !dbg !91
  %76 = tail call contract noundef float @llvm.exp.f32(float %75), !dbg !95
  %add300 = fadd contract float %partial_sum.sroa.0.0, %76, !dbg !98
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %74, i64 1, !dbg !89
  %mul291.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !90
  %77 = tail call contract noundef float @llvm.minnum.f32(float %mul291.1, float 0x4024CB5EC0000000), !dbg !91
  %78 = tail call contract noundef float @llvm.exp.f32(float %77), !dbg !95
  %add300.1 = fadd contract float %partial_sum.sroa.6.0, %78, !dbg !98
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %74, i64 2, !dbg !89
  %mul291.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !90
  %79 = tail call contract noundef float @llvm.minnum.f32(float %mul291.2, float 0x4024CB5EC0000000), !dbg !91
  %80 = tail call contract noundef float @llvm.exp.f32(float %79), !dbg !95
  %add300.2 = fadd contract float %partial_sum.sroa.10.0, %80, !dbg !98
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %74, i64 3, !dbg !89
  %mul291.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !90
  %81 = tail call contract noundef float @llvm.minnum.f32(float %mul291.3, float 0x4024CB5EC0000000), !dbg !91
  %82 = tail call contract noundef float @llvm.exp.f32(float %81), !dbg !95
  %add300.3 = fadd contract float %partial_sum.sroa.14.0, %82, !dbg !98
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %76), !dbg !99
  %84 = insertelement <4 x i16> poison, i16 %83, i64 0, !dbg !108
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %78), !dbg !99
  %86 = insertelement <4 x i16> %84, i16 %85, i64 1, !dbg !108
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %80), !dbg !99
  %88 = insertelement <4 x i16> %86, i16 %87, i64 2, !dbg !108
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %82), !dbg !99
  %90 = insertelement <4 x i16> %88, i16 %89, i64 3, !dbg !108
  %prob.sroa.0.6.vec.insert = bitcast <4 x i16> %90 to <4 x half>, !dbg !108
  fence syncscope("warp") release, !dbg !109
  tail call void @llvm.mxc.barrier.warp(), !dbg !112
  fence syncscope("warp") acquire, !dbg !113
  br label %if.then320, !dbg !114

if.then320:                                       ; preds = %for.body151, %if.end216
  %partial_sum.sroa.14.1 = phi float [ %partial_sum.sroa.14.0, %for.body151 ], [ %add300.3, %if.end216 ], !dbg !82
  %partial_sum.sroa.10.1 = phi float [ %partial_sum.sroa.10.0, %for.body151 ], [ %add300.2, %if.end216 ], !dbg !82
  %partial_sum.sroa.6.1 = phi float [ %partial_sum.sroa.6.0, %for.body151 ], [ %add300.1, %if.end216 ], !dbg !82
  %partial_sum.sroa.0.1 = phi float [ %partial_sum.sroa.0.0, %for.body151 ], [ %add300, %if.end216 ], !dbg !82
  %prob.sroa.0.1 = phi <4 x half> [ %prob.sroa.0.0, %for.body151 ], [ %prob.sroa.0.6.vec.insert, %if.end216 ]
  %add321 = or disjoint i32 %s_1.0825, 1, !dbg !115
  %arrayidx323 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %add321, !dbg !116
  %91 = load i32, ptr addrspace(5) %arrayidx323, align 4, !dbg !116, !tbaa !30
  %or.cond839 = icmp ugt i32 %91, 31, !dbg !117
  %cmp330.not = icmp sgt i32 %91, %shr42
  %or.cond840 = or i1 %or.cond839, %cmp330.not, !dbg !117
  br i1 %or.cond840, label %if.end421, label %for.cond332.preheader, !dbg !117

for.cond332.preheader:                            ; preds = %if.then320
  %mul347 = shl nuw nsw i32 %91, 10
  %add350 = add nuw nsw i32 %add348, %mul347
  %92 = zext nneg i32 %add350 to i64, !dbg !118
  %arrayidx358 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %92, !dbg !119
  %93 = load <2 x i16>, ptr addrspace(4) %arrayidx358, align 2, !dbg !120, !tbaa !58
  %94 = or disjoint i64 %92, 2
  %arrayidx358.1900 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %94, !dbg !119
  %95 = load <2 x i16>, ptr addrspace(4) %arrayidx358.1900, align 2, !dbg !120, !tbaa !58
  %96 = or disjoint i64 %92, 4
  %arrayidx358.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %96, !dbg !119
  %97 = load <2 x i16>, ptr addrspace(4) %arrayidx358.2, align 2, !dbg !120, !tbaa !58
  %98 = or disjoint i64 %92, 6
  %arrayidx358.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %98, !dbg !119
  %99 = load <2 x i16>, ptr addrspace(4) %arrayidx358.3, align 2, !dbg !120, !tbaa !58
  %100 = add nuw nsw i64 %92, 512
  %arrayidx358.1907 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %100, !dbg !119
  %101 = load <2 x i16>, ptr addrspace(4) %arrayidx358.1907, align 2, !dbg !120, !tbaa !58
  %102 = add nuw nsw i64 %92, 514
  %arrayidx358.1900.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %102, !dbg !119
  %103 = load <2 x i16>, ptr addrspace(4) %arrayidx358.1900.1, align 2, !dbg !120, !tbaa !58
  %104 = add nuw nsw i64 %92, 516
  %arrayidx358.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %104, !dbg !119
  %105 = load <2 x i16>, ptr addrspace(4) %arrayidx358.2.1, align 2, !dbg !120, !tbaa !58
  %106 = add nuw nsw i64 %92, 518
  %arrayidx358.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %106, !dbg !119
  %107 = load <2 x i16>, ptr addrspace(4) %arrayidx358.3.1, align 2, !dbg !120, !tbaa !58
  %arrayidx402 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %92, !dbg !121
  %108 = load <2 x i16>, ptr addrspace(4) %arrayidx402, align 2, !dbg !122, !tbaa !58
  %arrayidx402.1921 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %94, !dbg !121
  %109 = load <2 x i16>, ptr addrspace(4) %arrayidx402.1921, align 2, !dbg !122, !tbaa !58
  %arrayidx402.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %96, !dbg !121
  %110 = load <2 x i16>, ptr addrspace(4) %arrayidx402.2, align 2, !dbg !122, !tbaa !58
  %arrayidx402.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %98, !dbg !121
  %111 = load <2 x i16>, ptr addrspace(4) %arrayidx402.3, align 2, !dbg !122, !tbaa !58
  %arrayidx402.1928 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %100, !dbg !121
  %112 = load <2 x i16>, ptr addrspace(4) %arrayidx402.1928, align 2, !dbg !122, !tbaa !58
  %arrayidx402.1921.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %102, !dbg !121
  %113 = load <2 x i16>, ptr addrspace(4) %arrayidx402.1921.1, align 2, !dbg !122, !tbaa !58
  %arrayidx402.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %104, !dbg !121
  %114 = load <2 x i16>, ptr addrspace(4) %arrayidx402.2.1, align 2, !dbg !122, !tbaa !58
  %arrayidx402.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %106, !dbg !121
  %115 = load <2 x i16>, ptr addrspace(4) %arrayidx402.3.1, align 2, !dbg !122, !tbaa !58
  br label %if.end421, !dbg !123

if.end421:                                        ; preds = %for.cond332.preheader, %if.then320
  %116 = phi <2 x i16> [ %54, %if.then320 ], [ %108, %for.cond332.preheader ]
  %117 = phi <2 x i16> [ %55, %if.then320 ], [ %109, %for.cond332.preheader ]
  %118 = phi <2 x i16> [ %56, %if.then320 ], [ %110, %for.cond332.preheader ]
  %119 = phi <2 x i16> [ %57, %if.then320 ], [ %111, %for.cond332.preheader ]
  %120 = phi <2 x i16> [ %58, %if.then320 ], [ %112, %for.cond332.preheader ]
  %121 = phi <2 x i16> [ %59, %if.then320 ], [ %113, %for.cond332.preheader ]
  %122 = phi <2 x i16> [ %60, %if.then320 ], [ %114, %for.cond332.preheader ]
  %123 = phi <2 x i16> [ %61, %if.then320 ], [ %115, %for.cond332.preheader ]
  %124 = phi <2 x i16> [ %62, %if.then320 ], [ %93, %for.cond332.preheader ]
  %125 = phi <2 x i16> [ %63, %if.then320 ], [ %95, %for.cond332.preheader ]
  %126 = phi <2 x i16> [ %64, %if.then320 ], [ %97, %for.cond332.preheader ]
  %127 = phi <2 x i16> [ %65, %if.then320 ], [ %99, %for.cond332.preheader ]
  %128 = phi <2 x i16> [ %66, %if.then320 ], [ %101, %for.cond332.preheader ]
  %129 = phi <2 x i16> [ %67, %if.then320 ], [ %103, %for.cond332.preheader ]
  %130 = phi <2 x i16> [ %68, %if.then320 ], [ %105, %for.cond332.preheader ]
  %131 = phi <2 x i16> [ %69, %if.then320 ], [ %107, %for.cond332.preheader ]
  br i1 %or.cond838, label %if.end490, label %for.cond434.preheader.preheader, !dbg !123

for.cond434.preheader.preheader:                  ; preds = %if.end421
  %132 = load half, ptr addrspace(3) %gep821, align 2, !dbg !124, !tbaa !58
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %132, i64 0, !dbg !124
  %133 = load half, ptr addrspace(3) %gep821.1, align 2, !dbg !124, !tbaa !58
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %133, i64 1, !dbg !124
  %134 = load half, ptr addrspace(3) %gep821.2, align 2, !dbg !124, !tbaa !58
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %134, i64 2, !dbg !124
  %135 = load half, ptr addrspace(3) %gep821.3, align 2, !dbg !124, !tbaa !58
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %135, i64 3, !dbg !124
  %136 = load half, ptr addrspace(3) %gep821.1939, align 2, !dbg !124, !tbaa !58
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %136, i64 0, !dbg !124
  %137 = load half, ptr addrspace(3) %gep821.1.1, align 2, !dbg !124, !tbaa !58
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %137, i64 1, !dbg !124
  %138 = load half, ptr addrspace(3) %gep821.2.1, align 2, !dbg !124, !tbaa !58
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %138, i64 2, !dbg !124
  %139 = load half, ptr addrspace(3) %gep821.3.1, align 2, !dbg !124, !tbaa !58
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %139, i64 3, !dbg !124
  %140 = load half, ptr addrspace(3) %gep821.2945, align 2, !dbg !124, !tbaa !58
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %140, i64 0, !dbg !124
  %141 = load half, ptr addrspace(3) %gep821.1.2, align 2, !dbg !124, !tbaa !58
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %141, i64 1, !dbg !124
  %142 = load half, ptr addrspace(3) %gep821.2.2, align 2, !dbg !124, !tbaa !58
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %142, i64 2, !dbg !124
  %143 = load half, ptr addrspace(3) %gep821.3.2, align 2, !dbg !124, !tbaa !58
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %143, i64 3, !dbg !124
  %144 = load half, ptr addrspace(3) %gep821.3951, align 2, !dbg !124, !tbaa !58
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %144, i64 0, !dbg !124
  %145 = load half, ptr addrspace(3) %gep821.1.3, align 2, !dbg !124, !tbaa !58
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %145, i64 1, !dbg !124
  %146 = load half, ptr addrspace(3) %gep821.2.3, align 2, !dbg !124, !tbaa !58
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %146, i64 2, !dbg !124
  %147 = load half, ptr addrspace(3) %gep821.3.3, align 2, !dbg !124, !tbaa !58
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %147, i64 3, !dbg !124
  %148 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.0.0), !dbg !125
  %149 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.20.0), !dbg !125
  %150 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.38.0), !dbg !125
  %151 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %prob.sroa.0.1, <4 x float> %out.sroa.56.0), !dbg !125
  br label %if.end490, !dbg !126

if.end490:                                        ; preds = %for.cond434.preheader.preheader, %if.end421
  %out.sroa.56.1 = phi <4 x float> [ %out.sroa.56.0, %if.end421 ], [ %151, %for.cond434.preheader.preheader ], !dbg !82
  %out.sroa.38.1 = phi <4 x float> [ %out.sroa.38.0, %if.end421 ], [ %150, %for.cond434.preheader.preheader ], !dbg !82
  %out.sroa.20.1 = phi <4 x float> [ %out.sroa.20.0, %if.end421 ], [ %149, %for.cond434.preheader.preheader ], !dbg !82
  %out.sroa.0.1 = phi <4 x float> [ %out.sroa.0.0, %if.end421 ], [ %148, %for.cond434.preheader.preheader ], !dbg !82
  %inc492 = or disjoint i32 %s_1.0825, 1, !dbg !126
  %arrayidx153.1 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %inc492, !dbg !65
  %152 = load i32, ptr addrspace(5) %arrayidx153.1, align 4, !dbg !65, !tbaa !30
  %or.cond837.1 = icmp ugt i32 %152, 31, !dbg !66
  %cmp160.not.1 = icmp sgt i32 %152, %shr42
  %or.cond838.1 = or i1 %or.cond837.1, %cmp160.not.1, !dbg !66
  br i1 %or.cond838.1, label %if.end318.1, label %for.body165.preheader.1, !dbg !66

for.body165.preheader.1:                          ; preds = %if.end490
  store <2 x i16> %124, ptr addrspace(3) %invariant.gep799, align 16, !dbg !67
  store <2 x i16> %125, ptr addrspace(3) %k.sroa.7.0.invariant.gep799.sroa_idx, align 4, !dbg !67
  store <2 x i16> %126, ptr addrspace(3) %k.sroa.11.0.invariant.gep799.sroa_idx, align 8, !dbg !67
  store <2 x i16> %127, ptr addrspace(3) %k.sroa.15.0.invariant.gep799.sroa_idx, align 4, !dbg !67
  store <2 x i16> %128, ptr addrspace(3) %gep800.1, align 16, !dbg !67
  store <2 x i16> %129, ptr addrspace(3) %k.sroa.24.16.gep800.1.sroa_idx, align 4, !dbg !67
  store <2 x i16> %130, ptr addrspace(3) %k.sroa.28.16.gep800.1.sroa_idx, align 8, !dbg !67
  store <2 x i16> %131, ptr addrspace(3) %k.sroa.32.16.gep800.1.sroa_idx, align 4, !dbg !67
  %mul187.1 = shl nuw nsw i32 %152, 4, !dbg !68
  %add188.1 = or disjoint i32 %mul187.1, 15, !dbg !69
  %cmp189.1 = icmp ult i32 %1, %add188.1, !dbg !70
  br i1 %cmp189.1, label %for.cond191.preheader.1, label %if.end216.1, !dbg !71

for.cond191.preheader.1:                          ; preds = %for.body165.preheader.1
  %add199.1 = add nuw nsw i32 %mul187.1, %mul198
  %cmp202.not.1 = icmp ugt i32 %add199.1, %1, !dbg !72
  %spec.select.11094 = select i1 %cmp202.not.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !73
  %scores.sroa.0.0.vec.insert978.1 = insertelement <4 x float> poison, float %spec.select.11094, i64 0, !dbg !74
  %cmp202.not.1.not.1 = icmp ult i32 %add199.1, %1, !dbg !72
  %spec.select.1.1 = select i1 %cmp202.not.1.not.1, float 0.000000e+00, float 0xFFF0000000000000, !dbg !73
  %scores.sroa.0.4.vec.insert985.1 = insertelement <4 x float> %scores.sroa.0.0.vec.insert978.1, float %spec.select.1.1, i64 1, !dbg !74
  %add200.2.1 = or disjoint i32 %add199.1, 2, !dbg !75
  %cmp202.not.2.1 = icmp ugt i32 %add200.2.1, %1, !dbg !72
  %spec.select.2.1 = select i1 %cmp202.not.2.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !73
  %scores.sroa.0.8.vec.insert992.1 = insertelement <4 x float> %scores.sroa.0.4.vec.insert985.1, float %spec.select.2.1, i64 2, !dbg !74
  %add200.3.1 = or disjoint i32 %add199.1, 3, !dbg !75
  %cmp202.not.3.1 = icmp ugt i32 %add200.3.1, %1, !dbg !72
  %spec.select.3.1 = select i1 %cmp202.not.3.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !73
  %scores.sroa.0.12.vec.insert999.1 = insertelement <4 x float> %scores.sroa.0.8.vec.insert992.1, float %spec.select.3.1, i64 3, !dbg !74
  br label %if.end216.1, !dbg !76

if.end216.1:                                      ; preds = %for.cond191.preheader.1, %for.body165.preheader.1
  %scores.sroa.0.1.1 = phi <4 x float> [ %scores.sroa.0.12.vec.insert999.1, %for.cond191.preheader.1 ], [ zeroinitializer, %for.body165.preheader.1 ], !dbg !82
  fence syncscope("warp") release, !dbg !76
  tail call void @llvm.mxc.barrier.warp(), !dbg !83
  fence syncscope("warp") acquire, !dbg !84
  %kb.sroa.0.0.copyload.1 = load <4 x half>, ptr addrspace(3) %add.ptr234, align 16, !dbg !85
  %kb.sroa.6.0.copyload.1 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr234.sroa_idx, align 8, !dbg !85
  %153 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload.1, <4 x half> %q.sroa.0.0.copyload, <4 x float> %scores.sroa.0.1.1), !dbg !86, !call_argsrelate !87
  %154 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload.1, <4 x half> %q.sroa.4.0.copyload, <4 x float> %153), !dbg !86, !call_argsrelate !87
  %kb.sroa.0.0.copyload968.1 = load <4 x half>, ptr addrspace(3) %add.ptr234.1, align 16, !dbg !85
  %kb.sroa.6.0.copyload969.1 = load <4 x half>, ptr addrspace(3) %kb.sroa.6.0.add.ptr234.1.sroa_idx, align 8, !dbg !85
  %155 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload968.1, <4 x half> %q.sroa.5.16.copyload, <4 x float> %154), !dbg !86, !call_argsrelate !87
  %156 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload969.1, <4 x half> %q.sroa.7.16.copyload, <4 x float> %155), !dbg !86, !call_argsrelate !87
  store <2 x i16> %116, ptr addrspace(3) %invariant.gep811, align 16, !dbg !88
  store <2 x i16> %117, ptr addrspace(3) %v.sroa.7.0.invariant.gep811.sroa_idx, align 4, !dbg !88
  store <2 x i16> %118, ptr addrspace(3) %v.sroa.11.0.invariant.gep811.sroa_idx, align 8, !dbg !88
  store <2 x i16> %119, ptr addrspace(3) %v.sroa.15.0.invariant.gep811.sroa_idx, align 4, !dbg !88
  store <2 x i16> %120, ptr addrspace(3) %gep.1, align 16, !dbg !88
  store <2 x i16> %121, ptr addrspace(3) %v.sroa.24.16.gep.1.sroa_idx, align 4, !dbg !88
  store <2 x i16> %122, ptr addrspace(3) %v.sroa.28.16.gep.1.sroa_idx, align 8, !dbg !88
  store <2 x i16> %123, ptr addrspace(3) %v.sroa.32.16.gep.1.sroa_idx, align 4, !dbg !88
  %scores.sroa.0.0.vec.extract.1 = extractelement <4 x float> %156, i64 0, !dbg !89
  %mul291.11095 = fmul contract float %scores.sroa.0.0.vec.extract.1, 0x3FB99999A0000000, !dbg !90
  %157 = tail call contract noundef float @llvm.minnum.f32(float %mul291.11095, float 0x4024CB5EC0000000), !dbg !91
  %158 = tail call contract noundef float @llvm.exp.f32(float %157), !dbg !95
  %add300.11096 = fadd contract float %partial_sum.sroa.0.1, %158, !dbg !98
  %scores.sroa.0.4.vec.extract.1 = extractelement <4 x float> %156, i64 1, !dbg !89
  %mul291.1.1 = fmul contract float %scores.sroa.0.4.vec.extract.1, 0x3FB99999A0000000, !dbg !90
  %159 = tail call contract noundef float @llvm.minnum.f32(float %mul291.1.1, float 0x4024CB5EC0000000), !dbg !91
  %160 = tail call contract noundef float @llvm.exp.f32(float %159), !dbg !95
  %add300.1.1 = fadd contract float %partial_sum.sroa.6.1, %160, !dbg !98
  %scores.sroa.0.8.vec.extract.1 = extractelement <4 x float> %156, i64 2, !dbg !89
  %mul291.2.1 = fmul contract float %scores.sroa.0.8.vec.extract.1, 0x3FB99999A0000000, !dbg !90
  %161 = tail call contract noundef float @llvm.minnum.f32(float %mul291.2.1, float 0x4024CB5EC0000000), !dbg !91
  %162 = tail call contract noundef float @llvm.exp.f32(float %161), !dbg !95
  %add300.2.1 = fadd contract float %partial_sum.sroa.10.1, %162, !dbg !98
  %scores.sroa.0.12.vec.extract.1 = extractelement <4 x float> %156, i64 3, !dbg !89
  %mul291.3.1 = fmul contract float %scores.sroa.0.12.vec.extract.1, 0x3FB99999A0000000, !dbg !90
  %163 = tail call contract noundef float @llvm.minnum.f32(float %mul291.3.1, float 0x4024CB5EC0000000), !dbg !91
  %164 = tail call contract noundef float @llvm.exp.f32(float %163), !dbg !95
  %add300.3.1 = fadd contract float %partial_sum.sroa.14.1, %164, !dbg !98
  %165 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %158), !dbg !99
  %166 = insertelement <4 x i16> poison, i16 %165, i64 0, !dbg !108
  %167 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %160), !dbg !99
  %168 = insertelement <4 x i16> %166, i16 %167, i64 1, !dbg !108
  %169 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %162), !dbg !99
  %170 = insertelement <4 x i16> %168, i16 %169, i64 2, !dbg !108
  %171 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %164), !dbg !99
  %172 = insertelement <4 x i16> %170, i16 %171, i64 3, !dbg !108
  %prob.sroa.0.6.vec.insert.1 = bitcast <4 x i16> %172 to <4 x half>, !dbg !108
  fence syncscope("warp") release, !dbg !109
  tail call void @llvm.mxc.barrier.warp(), !dbg !112
  fence syncscope("warp") acquire, !dbg !113
  br label %if.end318.1, !dbg !114

if.end318.1:                                      ; preds = %if.end216.1, %if.end490
  %partial_sum.sroa.14.1.1 = phi float [ %partial_sum.sroa.14.1, %if.end490 ], [ %add300.3.1, %if.end216.1 ], !dbg !82
  %partial_sum.sroa.10.1.1 = phi float [ %partial_sum.sroa.10.1, %if.end490 ], [ %add300.2.1, %if.end216.1 ], !dbg !82
  %partial_sum.sroa.6.1.1 = phi float [ %partial_sum.sroa.6.1, %if.end490 ], [ %add300.1.1, %if.end216.1 ], !dbg !82
  %partial_sum.sroa.0.1.1 = phi float [ %partial_sum.sroa.0.1, %if.end490 ], [ %add300.11096, %if.end216.1 ], !dbg !82
  %prob.sroa.0.1.1 = phi <4 x half> [ %prob.sroa.0.1, %if.end490 ], [ %prob.sroa.0.6.vec.insert.1, %if.end216.1 ]
  %cmp319.not.1 = icmp eq i32 %s_1.0825, 2, !dbg !127
  br i1 %cmp319.not.1, label %if.end421.1, label %if.then320.1, !dbg !128

if.then320.1:                                     ; preds = %if.end318.1
  %add321.1 = add nuw nsw i32 %s_1.0825, 2, !dbg !115
  %arrayidx323.1 = getelementptr inbounds [4 x i32], ptr addrspace(5) %blocks, i32 0, i32 %add321.1, !dbg !116
  %173 = load i32, ptr addrspace(5) %arrayidx323.1, align 4, !dbg !116, !tbaa !30
  %or.cond839.1 = icmp ugt i32 %173, 31, !dbg !117
  %cmp330.not.1 = icmp sgt i32 %173, %shr42
  %or.cond840.1 = or i1 %or.cond839.1, %cmp330.not.1, !dbg !117
  br i1 %or.cond840.1, label %if.end421.1, label %for.cond332.preheader.1, !dbg !117

for.cond332.preheader.1:                          ; preds = %if.then320.1
  %mul347.1 = shl nuw nsw i32 %173, 10
  %add350.1 = add nuw nsw i32 %add348, %mul347.1
  %174 = zext nneg i32 %add350.1 to i64, !dbg !118
  %arrayidx358.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %174, !dbg !119
  %175 = load <2 x i16>, ptr addrspace(4) %arrayidx358.1, align 2, !dbg !120, !tbaa !58
  %176 = or disjoint i64 %174, 2
  %arrayidx358.1900.11097 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %176, !dbg !119
  %177 = load <2 x i16>, ptr addrspace(4) %arrayidx358.1900.11097, align 2, !dbg !120, !tbaa !58
  %178 = or disjoint i64 %174, 4
  %arrayidx358.2.11098 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %178, !dbg !119
  %179 = load <2 x i16>, ptr addrspace(4) %arrayidx358.2.11098, align 2, !dbg !120, !tbaa !58
  %180 = or disjoint i64 %174, 6
  %arrayidx358.3.11099 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %180, !dbg !119
  %181 = load <2 x i16>, ptr addrspace(4) %arrayidx358.3.11099, align 2, !dbg !120, !tbaa !58
  %182 = add nuw nsw i64 %174, 512
  %arrayidx358.1907.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %182, !dbg !119
  %183 = load <2 x i16>, ptr addrspace(4) %arrayidx358.1907.1, align 2, !dbg !120, !tbaa !58
  %184 = add nuw nsw i64 %174, 514
  %arrayidx358.1900.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %184, !dbg !119
  %185 = load <2 x i16>, ptr addrspace(4) %arrayidx358.1900.1.1, align 2, !dbg !120, !tbaa !58
  %186 = add nuw nsw i64 %174, 516
  %arrayidx358.2.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %186, !dbg !119
  %187 = load <2 x i16>, ptr addrspace(4) %arrayidx358.2.1.1, align 2, !dbg !120, !tbaa !58
  %188 = add nuw nsw i64 %174, 518
  %arrayidx358.3.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %188, !dbg !119
  %189 = load <2 x i16>, ptr addrspace(4) %arrayidx358.3.1.1, align 2, !dbg !120, !tbaa !58
  %arrayidx402.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %174, !dbg !121
  %190 = load <2 x i16>, ptr addrspace(4) %arrayidx402.1, align 2, !dbg !122, !tbaa !58
  %arrayidx402.1921.11100 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %176, !dbg !121
  %191 = load <2 x i16>, ptr addrspace(4) %arrayidx402.1921.11100, align 2, !dbg !122, !tbaa !58
  %arrayidx402.2.11101 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %178, !dbg !121
  %192 = load <2 x i16>, ptr addrspace(4) %arrayidx402.2.11101, align 2, !dbg !122, !tbaa !58
  %arrayidx402.3.11102 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %180, !dbg !121
  %193 = load <2 x i16>, ptr addrspace(4) %arrayidx402.3.11102, align 2, !dbg !122, !tbaa !58
  %arrayidx402.1928.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %182, !dbg !121
  %194 = load <2 x i16>, ptr addrspace(4) %arrayidx402.1928.1, align 2, !dbg !122, !tbaa !58
  %arrayidx402.1921.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %184, !dbg !121
  %195 = load <2 x i16>, ptr addrspace(4) %arrayidx402.1921.1.1, align 2, !dbg !122, !tbaa !58
  %arrayidx402.2.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %186, !dbg !121
  %196 = load <2 x i16>, ptr addrspace(4) %arrayidx402.2.1.1, align 2, !dbg !122, !tbaa !58
  %arrayidx402.3.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %188, !dbg !121
  %197 = load <2 x i16>, ptr addrspace(4) %arrayidx402.3.1.1, align 2, !dbg !122, !tbaa !58
  br label %if.end421.1, !dbg !123

if.end421.1:                                      ; preds = %for.cond332.preheader.1, %if.then320.1, %if.end318.1
  %198 = phi <2 x i16> [ %116, %if.end318.1 ], [ %116, %if.then320.1 ], [ %190, %for.cond332.preheader.1 ]
  %199 = phi <2 x i16> [ %117, %if.end318.1 ], [ %117, %if.then320.1 ], [ %191, %for.cond332.preheader.1 ]
  %200 = phi <2 x i16> [ %118, %if.end318.1 ], [ %118, %if.then320.1 ], [ %192, %for.cond332.preheader.1 ]
  %201 = phi <2 x i16> [ %119, %if.end318.1 ], [ %119, %if.then320.1 ], [ %193, %for.cond332.preheader.1 ]
  %202 = phi <2 x i16> [ %120, %if.end318.1 ], [ %120, %if.then320.1 ], [ %194, %for.cond332.preheader.1 ]
  %203 = phi <2 x i16> [ %121, %if.end318.1 ], [ %121, %if.then320.1 ], [ %195, %for.cond332.preheader.1 ]
  %204 = phi <2 x i16> [ %122, %if.end318.1 ], [ %122, %if.then320.1 ], [ %196, %for.cond332.preheader.1 ]
  %205 = phi <2 x i16> [ %123, %if.end318.1 ], [ %123, %if.then320.1 ], [ %197, %for.cond332.preheader.1 ]
  %206 = phi <2 x i16> [ %124, %if.end318.1 ], [ %124, %if.then320.1 ], [ %175, %for.cond332.preheader.1 ]
  %207 = phi <2 x i16> [ %125, %if.end318.1 ], [ %125, %if.then320.1 ], [ %177, %for.cond332.preheader.1 ]
  %208 = phi <2 x i16> [ %126, %if.end318.1 ], [ %126, %if.then320.1 ], [ %179, %for.cond332.preheader.1 ]
  %209 = phi <2 x i16> [ %127, %if.end318.1 ], [ %127, %if.then320.1 ], [ %181, %for.cond332.preheader.1 ]
  %210 = phi <2 x i16> [ %128, %if.end318.1 ], [ %128, %if.then320.1 ], [ %183, %for.cond332.preheader.1 ]
  %211 = phi <2 x i16> [ %129, %if.end318.1 ], [ %129, %if.then320.1 ], [ %185, %for.cond332.preheader.1 ]
  %212 = phi <2 x i16> [ %130, %if.end318.1 ], [ %130, %if.then320.1 ], [ %187, %for.cond332.preheader.1 ]
  %213 = phi <2 x i16> [ %131, %if.end318.1 ], [ %131, %if.then320.1 ], [ %189, %for.cond332.preheader.1 ]
  br i1 %or.cond838.1, label %if.end490.1, label %for.cond434.preheader.preheader.1, !dbg !123

for.cond434.preheader.preheader.1:                ; preds = %if.end421.1
  %214 = load half, ptr addrspace(3) %gep821, align 2, !dbg !124, !tbaa !58
  %vb.sroa.0.0.vec.insert.1 = insertelement <4 x half> poison, half %214, i64 0, !dbg !124
  %215 = load half, ptr addrspace(3) %gep821.1, align 2, !dbg !124, !tbaa !58
  %vb.sroa.0.2.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.0.vec.insert.1, half %215, i64 1, !dbg !124
  %216 = load half, ptr addrspace(3) %gep821.2, align 2, !dbg !124, !tbaa !58
  %vb.sroa.0.4.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.2.vec.insert.1, half %216, i64 2, !dbg !124
  %217 = load half, ptr addrspace(3) %gep821.3, align 2, !dbg !124, !tbaa !58
  %vb.sroa.0.6.vec.insert.1 = insertelement <4 x half> %vb.sroa.0.4.vec.insert.1, half %217, i64 3, !dbg !124
  %218 = load half, ptr addrspace(3) %gep821.1939, align 2, !dbg !124, !tbaa !58
  %vb.sroa.7.8.vec.insert.1 = insertelement <4 x half> poison, half %218, i64 0, !dbg !124
  %219 = load half, ptr addrspace(3) %gep821.1.1, align 2, !dbg !124, !tbaa !58
  %vb.sroa.7.10.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.8.vec.insert.1, half %219, i64 1, !dbg !124
  %220 = load half, ptr addrspace(3) %gep821.2.1, align 2, !dbg !124, !tbaa !58
  %vb.sroa.7.12.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.10.vec.insert.1, half %220, i64 2, !dbg !124
  %221 = load half, ptr addrspace(3) %gep821.3.1, align 2, !dbg !124, !tbaa !58
  %vb.sroa.7.14.vec.insert.1 = insertelement <4 x half> %vb.sroa.7.12.vec.insert.1, half %221, i64 3, !dbg !124
  %222 = load half, ptr addrspace(3) %gep821.2945, align 2, !dbg !124, !tbaa !58
  %vb.sroa.12.16.vec.insert.1 = insertelement <4 x half> poison, half %222, i64 0, !dbg !124
  %223 = load half, ptr addrspace(3) %gep821.1.2, align 2, !dbg !124, !tbaa !58
  %vb.sroa.12.18.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.16.vec.insert.1, half %223, i64 1, !dbg !124
  %224 = load half, ptr addrspace(3) %gep821.2.2, align 2, !dbg !124, !tbaa !58
  %vb.sroa.12.20.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.18.vec.insert.1, half %224, i64 2, !dbg !124
  %225 = load half, ptr addrspace(3) %gep821.3.2, align 2, !dbg !124, !tbaa !58
  %vb.sroa.12.22.vec.insert.1 = insertelement <4 x half> %vb.sroa.12.20.vec.insert.1, half %225, i64 3, !dbg !124
  %226 = load half, ptr addrspace(3) %gep821.3951, align 2, !dbg !124, !tbaa !58
  %vb.sroa.17.24.vec.insert.1 = insertelement <4 x half> poison, half %226, i64 0, !dbg !124
  %227 = load half, ptr addrspace(3) %gep821.1.3, align 2, !dbg !124, !tbaa !58
  %vb.sroa.17.26.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.24.vec.insert.1, half %227, i64 1, !dbg !124
  %228 = load half, ptr addrspace(3) %gep821.2.3, align 2, !dbg !124, !tbaa !58
  %vb.sroa.17.28.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.26.vec.insert.1, half %228, i64 2, !dbg !124
  %229 = load half, ptr addrspace(3) %gep821.3.3, align 2, !dbg !124, !tbaa !58
  %vb.sroa.17.30.vec.insert.1 = insertelement <4 x half> %vb.sroa.17.28.vec.insert.1, half %229, i64 3, !dbg !124
  %230 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.0.1), !dbg !125
  %231 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.20.1), !dbg !125
  %232 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.38.1), !dbg !125
  %233 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert.1, <4 x half> %prob.sroa.0.1.1, <4 x float> %out.sroa.56.1), !dbg !125
  br label %if.end490.1, !dbg !126

if.end490.1:                                      ; preds = %for.cond434.preheader.preheader.1, %if.end421.1
  %out.sroa.56.1.1 = phi <4 x float> [ %out.sroa.56.1, %if.end421.1 ], [ %233, %for.cond434.preheader.preheader.1 ], !dbg !82
  %out.sroa.38.1.1 = phi <4 x float> [ %out.sroa.38.1, %if.end421.1 ], [ %232, %for.cond434.preheader.preheader.1 ], !dbg !82
  %out.sroa.20.1.1 = phi <4 x float> [ %out.sroa.20.1, %if.end421.1 ], [ %231, %for.cond434.preheader.preheader.1 ], !dbg !82
  %out.sroa.0.1.1 = phi <4 x float> [ %out.sroa.0.1, %if.end421.1 ], [ %230, %for.cond434.preheader.preheader.1 ], !dbg !82
  %inc492.1 = add nuw nsw i32 %s_1.0825, 2, !dbg !126
  %exitcond.not.1 = icmp eq i32 %inc492.1, 4, !dbg !129
  br i1 %exitcond.not.1, label %for.body498.preheader, label %for.body151, !dbg !62, !llvm.loop !130

for.body498.preheader:                            ; preds = %if.end490.1
  %add502 = fadd contract float %partial_sum.sroa.0.1.1, 0.000000e+00, !dbg !133
  %add502.1 = fadd contract float %add502, %partial_sum.sroa.6.1.1, !dbg !133
  %add502.2 = fadd contract float %add502.1, %partial_sum.sroa.10.1.1, !dbg !133
  %add502.3 = fadd contract float %add502.2, %partial_sum.sroa.14.1.1, !dbg !133
  %234 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add502.3, <4 x float> zeroinitializer), !dbg !134
  %short_sum_out.sroa.0.0.vec.extract = extractelement <4 x float> %234, i64 0, !dbg !135
  %cmp520 = fcmp contract ogt float %short_sum_out.sroa.0.0.vec.extract, 0.000000e+00, !dbg !136
  br i1 %cmp520, label %if.then521, label %if.end536, !dbg !137

if.then521:                                       ; preds = %for.body498.preheader
  %235 = bitcast float %short_sum_out.sroa.0.0.vec.extract to i32, !dbg !138
  %sub = sub i32 2129859011, %235, !dbg !139
  %236 = bitcast i32 %sub to float, !dbg !140
  %mul524 = fmul contract float %short_sum_out.sroa.0.0.vec.extract, %236, !dbg !141
  %sub525 = fsub contract float 2.000000e+00, %mul524, !dbg !142
  %mul526 = fmul contract float %sub525, %236, !dbg !143
  %mul532 = fmul contract float %short_sum_out.sroa.0.0.vec.extract, %mul526, !dbg !144
  %sub533 = fsub contract float 2.000000e+00, %mul532, !dbg !145
  %mul534 = fmul contract float %mul526, %sub533, !dbg !146
  br label %if.end536, !dbg !147

if.end536:                                        ; preds = %for.body498.preheader, %if.then521
  %condval_1.0 = phi float [ %mul534, %if.then521 ], [ 0.000000e+00, %for.body498.preheader ], !dbg !82
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 0, !dbg !148
  %mul545 = fmul contract float %condval_1.0, %out.sroa.0.0.vec.extract, !dbg !149
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 1, !dbg !148
  %mul545.1 = fmul contract float %condval_1.0, %out.sroa.0.4.vec.extract, !dbg !149
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 2, !dbg !148
  %mul545.2 = fmul contract float %condval_1.0, %out.sroa.0.8.vec.extract, !dbg !149
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %out.sroa.0.1.1, i64 3, !dbg !148
  %mul545.3 = fmul contract float %condval_1.0, %out.sroa.0.12.vec.extract, !dbg !149
  %out.sroa.20.16.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 0, !dbg !148
  %mul545.4 = fmul contract float %condval_1.0, %out.sroa.20.16.vec.extract, !dbg !149
  %out.sroa.20.20.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 1, !dbg !148
  %mul545.5 = fmul contract float %condval_1.0, %out.sroa.20.20.vec.extract, !dbg !149
  %out.sroa.20.24.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 2, !dbg !148
  %mul545.6 = fmul contract float %condval_1.0, %out.sroa.20.24.vec.extract, !dbg !149
  %out.sroa.20.28.vec.extract = extractelement <4 x float> %out.sroa.20.1.1, i64 3, !dbg !148
  %mul545.7 = fmul contract float %condval_1.0, %out.sroa.20.28.vec.extract, !dbg !149
  %out.sroa.38.32.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 0, !dbg !148
  %mul545.8 = fmul contract float %condval_1.0, %out.sroa.38.32.vec.extract, !dbg !149
  %out.sroa.38.36.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 1, !dbg !148
  %mul545.9 = fmul contract float %condval_1.0, %out.sroa.38.36.vec.extract, !dbg !149
  %out.sroa.38.40.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 2, !dbg !148
  %mul545.10 = fmul contract float %condval_1.0, %out.sroa.38.40.vec.extract, !dbg !149
  %out.sroa.38.44.vec.extract = extractelement <4 x float> %out.sroa.38.1.1, i64 3, !dbg !148
  %mul545.11 = fmul contract float %condval_1.0, %out.sroa.38.44.vec.extract, !dbg !149
  %out.sroa.56.48.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 0, !dbg !148
  %mul545.12 = fmul contract float %condval_1.0, %out.sroa.56.48.vec.extract, !dbg !149
  %out.sroa.56.52.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 1, !dbg !148
  %mul545.13 = fmul contract float %condval_1.0, %out.sroa.56.52.vec.extract, !dbg !149
  %out.sroa.56.56.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 2, !dbg !148
  %mul545.14 = fmul contract float %condval_1.0, %out.sroa.56.56.vec.extract, !dbg !149
  %out.sroa.56.60.vec.extract = extractelement <4 x float> %out.sroa.56.1.1, i64 3, !dbg !148
  %mul545.15 = fmul contract float %condval_1.0, %out.sroa.56.60.vec.extract, !dbg !149
  %237 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul545), !dbg !150
  %result.sroa.0.0.insert.ext = zext i16 %237 to i64, !dbg !154
  %238 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul545.1), !dbg !150
  %result.sroa.0.2.insert.ext = zext i16 %238 to i64, !dbg !154
  %result.sroa.0.2.insert.shift = shl nuw nsw i64 %result.sroa.0.2.insert.ext, 16, !dbg !154
  %result.sroa.0.2.insert.insert = or disjoint i64 %result.sroa.0.2.insert.shift, %result.sroa.0.0.insert.ext, !dbg !154
  %239 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul545.2), !dbg !150
  %result.sroa.0.4.insert.ext = zext i16 %239 to i64, !dbg !154
  %result.sroa.0.4.insert.shift = shl nuw nsw i64 %result.sroa.0.4.insert.ext, 32, !dbg !154
  %result.sroa.0.4.insert.insert = or disjoint i64 %result.sroa.0.2.insert.insert, %result.sroa.0.4.insert.shift, !dbg !154
  %240 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul545.3), !dbg !150
  %result.sroa.0.6.insert.ext = zext i16 %240 to i64, !dbg !154
  %result.sroa.0.6.insert.shift = shl nuw i64 %result.sroa.0.6.insert.ext, 48, !dbg !154
  %result.sroa.0.6.insert.insert = or disjoint i64 %result.sroa.0.4.insert.insert, %result.sroa.0.6.insert.shift, !dbg !154
  %241 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul545.4), !dbg !150
  %result.sroa.7.8.insert.ext = zext i16 %241 to i64, !dbg !154
  %242 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul545.5), !dbg !150
  %result.sroa.7.10.insert.ext = zext i16 %242 to i64, !dbg !154
  %result.sroa.7.10.insert.shift = shl nuw nsw i64 %result.sroa.7.10.insert.ext, 16, !dbg !154
  %result.sroa.7.10.insert.insert = or disjoint i64 %result.sroa.7.10.insert.shift, %result.sroa.7.8.insert.ext, !dbg !154
  %243 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul545.6), !dbg !150
  %result.sroa.7.12.insert.ext = zext i16 %243 to i64, !dbg !154
  %result.sroa.7.12.insert.shift = shl nuw nsw i64 %result.sroa.7.12.insert.ext, 32, !dbg !154
  %result.sroa.7.12.insert.insert = or disjoint i64 %result.sroa.7.10.insert.insert, %result.sroa.7.12.insert.shift, !dbg !154
  %244 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul545.7), !dbg !150
  %result.sroa.7.14.insert.ext = zext i16 %244 to i64, !dbg !154
  %result.sroa.7.14.insert.shift = shl nuw i64 %result.sroa.7.14.insert.ext, 48, !dbg !154
  %result.sroa.7.14.insert.insert = or disjoint i64 %result.sroa.7.12.insert.insert, %result.sroa.7.14.insert.shift, !dbg !154
  %245 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul545.8), !dbg !150
  %result.sroa.12.16.insert.ext = zext i16 %245 to i64, !dbg !154
  %246 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul545.9), !dbg !150
  %result.sroa.12.18.insert.ext = zext i16 %246 to i64, !dbg !154
  %result.sroa.12.18.insert.shift = shl nuw nsw i64 %result.sroa.12.18.insert.ext, 16, !dbg !154
  %result.sroa.12.18.insert.insert = or disjoint i64 %result.sroa.12.18.insert.shift, %result.sroa.12.16.insert.ext, !dbg !154
  %247 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul545.10), !dbg !150
  %result.sroa.12.20.insert.ext = zext i16 %247 to i64, !dbg !154
  %result.sroa.12.20.insert.shift = shl nuw nsw i64 %result.sroa.12.20.insert.ext, 32, !dbg !154
  %result.sroa.12.20.insert.insert = or disjoint i64 %result.sroa.12.18.insert.insert, %result.sroa.12.20.insert.shift, !dbg !154
  %248 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul545.11), !dbg !150
  %result.sroa.12.22.insert.ext = zext i16 %248 to i64, !dbg !154
  %result.sroa.12.22.insert.shift = shl nuw i64 %result.sroa.12.22.insert.ext, 48, !dbg !154
  %result.sroa.12.22.insert.insert = or disjoint i64 %result.sroa.12.20.insert.insert, %result.sroa.12.22.insert.shift, !dbg !154
  %249 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul545.12), !dbg !150
  %result.sroa.17.24.insert.ext = zext i16 %249 to i64, !dbg !154
  %250 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul545.13), !dbg !150
  %result.sroa.17.26.insert.ext = zext i16 %250 to i64, !dbg !154
  %result.sroa.17.26.insert.shift = shl nuw nsw i64 %result.sroa.17.26.insert.ext, 16, !dbg !154
  %result.sroa.17.26.insert.insert = or disjoint i64 %result.sroa.17.26.insert.shift, %result.sroa.17.24.insert.ext, !dbg !154
  %251 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul545.14), !dbg !150
  %result.sroa.17.28.insert.ext = zext i16 %251 to i64, !dbg !154
  %result.sroa.17.28.insert.shift = shl nuw nsw i64 %result.sroa.17.28.insert.ext, 32, !dbg !154
  %result.sroa.17.28.insert.insert = or disjoint i64 %result.sroa.17.26.insert.insert, %result.sroa.17.28.insert.shift, !dbg !154
  %252 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul545.15), !dbg !150
  %result.sroa.17.30.insert.ext = zext i16 %252 to i64, !dbg !154
  %result.sroa.17.30.insert.shift = shl nuw i64 %result.sroa.17.30.insert.ext, 48, !dbg !154
  %result.sroa.17.30.insert.insert = or disjoint i64 %result.sroa.17.28.insert.insert, %result.sroa.17.30.insert.shift, !dbg !154
  fence syncscope("warp") release, !dbg !155
  tail call void @llvm.mxc.barrier.warp(), !dbg !158
  fence syncscope("warp") acquire, !dbg !159
  %shr587 = lshr i32 %2, 5
  %xor591 = xor i32 %shr587, %and229, !dbg !160
  %mul592 = shl nuw nsw i32 %xor591, 3, !dbg !161
  %add593 = add nuw nsw i32 %mul592, %mul9, !dbg !162
  %add598 = or disjoint i32 %add593, %mul451, !dbg !163
  %add.ptr600 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add598, !dbg !164
  store i64 %result.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr600, align 8, !dbg !165
  %add588.1 = add nuw nsw i32 %shr587, 2, !dbg !166
  %xor591.1 = xor i32 %add588.1, %and229, !dbg !160
  %mul592.1 = shl nuw nsw i32 %xor591.1, 3, !dbg !161
  %add593.1 = add nuw nsw i32 %mul592.1, %mul9, !dbg !162
  %add598.1 = or disjoint i32 %add593.1, %mul451, !dbg !163
  %add.ptr600.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add598.1, !dbg !164
  store i64 %result.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr600.1, align 8, !dbg !165
  %add588.2 = add nuw nsw i32 %shr587, 4, !dbg !166
  %xor591.2 = xor i32 %add588.2, %and229, !dbg !160
  %mul592.2 = shl nuw nsw i32 %xor591.2, 3, !dbg !161
  %add593.2 = add nuw nsw i32 %mul592.2, %mul9, !dbg !162
  %add598.2 = or disjoint i32 %add593.2, %mul451, !dbg !163
  %add.ptr600.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add598.2, !dbg !164
  store i64 %result.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr600.2, align 8, !dbg !165
  %add588.3 = add nuw nsw i32 %shr587, 6, !dbg !166
  %xor591.3 = xor i32 %add588.3, %and229, !dbg !160
  %mul592.3 = shl nuw nsw i32 %xor591.3, 3, !dbg !161
  %add593.3 = add nuw nsw i32 %mul592.3, %mul9, !dbg !162
  %add598.3 = or disjoint i32 %add593.3, %mul451, !dbg !163
  %add.ptr600.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add598.3, !dbg !164
  store i64 %result.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr600.3, align 8, !dbg !165
  fence syncscope("warp") release, !dbg !167
  tail call void @llvm.mxc.barrier.warp(), !dbg !170
  fence syncscope("warp") acquire, !dbg !171
  %add628 = add nuw nsw i32 %add, %50
  %253 = zext nneg i32 %add628 to i64, !dbg !172
  %add.ptr633 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %253, !dbg !173
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr633, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep799, i64 16, i1 false), !dbg !174, !tbaa.struct !175, !call_argsrelate !176
  %gep835.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep799, i32 1024, !dbg !177
  %254 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %253, !dbg !173
  %add.ptr633.1 = getelementptr inbounds i8, ptr addrspace(1) %254, i64 1024, !dbg !173
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr633.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep835.1, i64 16, i1 false), !dbg !174, !tbaa.struct !175, !call_argsrelate !176
  call void @llvm.lifetime.end.p5(i64 16, ptr addrspace(5) %blocks) #12, !dbg !178, !call_argsrelate !43
  ret void, !dbg !178
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
!1 = !DIFile(filename: "/tmp/tmpx4isi4uj/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpx4isi4uj/tvm_kernels.maca", directory: "")
!42 = !DILocation(line: 14, column: 3, scope: !40)
!43 = !{i32 -1, i32 0}
!44 = !{i32 0, i32 1024}
!45 = !DILocation(line: 28, column: 3, scope: !40)
!46 = !DILocation(line: 29, column: 42, scope: !40)
!47 = !DILocation(line: 29, column: 28, scope: !40)
!48 = !DILocation(line: 32, column: 3, scope: !40)
!49 = !DILocation(line: 33, column: 25, scope: !40)
!50 = !DILocation(line: 33, column: 17, scope: !40)
!51 = !DILocation(line: 33, column: 15, scope: !40)
!52 = !DILocation(line: 33, column: 89, scope: !40)
!53 = !DILocation(line: 33, column: 5, scope: !40)
!54 = !DILocation(line: 36, column: 27, scope: !40)
!55 = !DILocation(line: 38, column: 5, scope: !40)
!56 = !DILocation(line: 42, column: 62, scope: !40)
!57 = !DILocation(line: 42, column: 54, scope: !40)
!58 = !{!26, !26, i64 0}
!59 = !DILocation(line: 51, column: 68, scope: !40)
!60 = !DILocation(line: 51, column: 60, scope: !40)
!61 = !DILocation(line: 57, column: 3, scope: !40)
!62 = !DILocation(line: 64, column: 3, scope: !40)
!63 = !DILocation(line: 59, column: 33, scope: !40)
!64 = !DILocation(line: 62, column: 31, scope: !40)
!65 = !DILocation(line: 65, column: 17, scope: !40)
!66 = !DILocation(line: 66, column: 23, scope: !40)
!67 = !DILocation(line: 69, column: 161, scope: !40)
!68 = !DILocation(line: 71, column: 39, scope: !40)
!69 = !DILocation(line: 71, column: 45, scope: !40)
!70 = !DILocation(line: 71, column: 29, scope: !40)
!71 = !DILocation(line: 71, column: 11, scope: !40)
!72 = !DILocation(line: 75, column: 73, scope: !40)
!73 = !DILocation(line: 75, column: 15, scope: !40)
!74 = !DILocation(line: 80, column: 23, scope: !40)
!75 = !DILocation(line: 75, column: 66, scope: !40)
!76 = !DILocation(line: 68, column: 3, scope: !77, inlinedAt: !79)
!77 = distinct !DISubprogram(name: "__barrier_warp", scope: !78, file: !78, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!78 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!79 = distinct !DILocation(line: 192, column: 3, scope: !80, inlinedAt: !81)
!80 = distinct !DISubprogram(name: "__syncwarp", scope: !78, file: !78, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!81 = distinct !DILocation(line: 86, column: 7, scope: !40)
!82 = !DILocation(line: 0, scope: !40)
!83 = !DILocation(line: 69, column: 3, scope: !77, inlinedAt: !79)
!84 = !DILocation(line: 70, column: 3, scope: !77, inlinedAt: !79)
!85 = !DILocation(line: 88, column: 27, scope: !40)
!86 = !DILocation(line: 91, column: 37, scope: !40)
!87 = !{i32 -1, i32 3, i32 -1}
!88 = !DILocation(line: 99, column: 170, scope: !40)
!89 = !DILocation(line: 103, column: 33, scope: !40)
!90 = !DILocation(line: 103, column: 45, scope: !40)
!91 = !DILocation(line: 354, column: 10, scope: !92, inlinedAt: !94)
!92 = distinct !DISubprogram(name: "min", scope: !93, file: !93, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!93 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!94 = distinct !DILocation(line: 103, column: 28, scope: !40)
!95 = !DILocation(line: 288, column: 10, scope: !96, inlinedAt: !97)
!96 = distinct !DISubprogram(name: "expf", scope: !93, file: !93, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!97 = distinct !DILocation(line: 103, column: 23, scope: !40)
!98 = !DILocation(line: 104, column: 46, scope: !40)
!99 = !DILocation(line: 75, column: 10, scope: !100, inlinedAt: !102)
!100 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !101, file: !101, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!101 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!102 = distinct !DILocation(line: 984, column: 9, scope: !103, inlinedAt: !105)
!103 = distinct !DISubprogram(name: "__float2half", scope: !104, file: !104, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!104 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!105 = distinct !DILocation(line: 133, column: 53, scope: !106, inlinedAt: !107)
!106 = distinct !DISubprogram(name: "__half", scope: !104, file: !104, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!107 = distinct !DILocation(line: 108, column: 23, scope: !40)
!108 = !DILocation(line: 108, column: 20, scope: !40)
!109 = !DILocation(line: 68, column: 3, scope: !77, inlinedAt: !110)
!110 = distinct !DILocation(line: 192, column: 3, scope: !80, inlinedAt: !111)
!111 = distinct !DILocation(line: 110, column: 7, scope: !40)
!112 = !DILocation(line: 69, column: 3, scope: !77, inlinedAt: !110)
!113 = !DILocation(line: 70, column: 3, scope: !77, inlinedAt: !110)
!114 = !DILocation(line: 111, column: 5, scope: !40)
!115 = !DILocation(line: 113, column: 36, scope: !40)
!116 = !DILocation(line: 113, column: 24, scope: !40)
!117 = !DILocation(line: 114, column: 30, scope: !40)
!118 = !DILocation(line: 116, column: 9, scope: !40)
!119 = !DILocation(line: 120, column: 72, scope: !40)
!120 = !DILocation(line: 120, column: 64, scope: !40)
!121 = !DILocation(line: 129, column: 72, scope: !40)
!122 = !DILocation(line: 129, column: 64, scope: !40)
!123 = !DILocation(line: 135, column: 23, scope: !40)
!124 = !DILocation(line: 138, column: 36, scope: !40)
!125 = !DILocation(line: 143, column: 36, scope: !40)
!126 = !DILocation(line: 64, column: 30, scope: !40)
!127 = !DILocation(line: 112, column: 13, scope: !40)
!128 = !DILocation(line: 112, column: 9, scope: !40)
!129 = !DILocation(line: 64, column: 25, scope: !40)
!130 = distinct !{!130, !62, !131, !32, !132}
!131 = !DILocation(line: 149, column: 3, scope: !40)
!132 = !{!"llvm.loop.unroll.disable"}
!133 = !DILocation(line: 153, column: 32, scope: !40)
!134 = !DILocation(line: 158, column: 44, scope: !40)
!135 = !DILocation(line: 163, column: 34, scope: !40)
!136 = !DILocation(line: 163, column: 32, scope: !40)
!137 = !DILocation(line: 163, column: 7, scope: !40)
!138 = !DILocation(line: 165, column: 37, scope: !40)
!139 = !DILocation(line: 165, column: 34, scope: !40)
!140 = !DILocation(line: 166, column: 20, scope: !40)
!141 = !DILocation(line: 166, column: 88, scope: !40)
!142 = !DILocation(line: 166, column: 68, scope: !40)
!143 = !DILocation(line: 166, column: 41, scope: !40)
!144 = !DILocation(line: 166, column: 162, scope: !40)
!145 = !DILocation(line: 166, column: 142, scope: !40)
!146 = !DILocation(line: 166, column: 115, scope: !40)
!147 = !DILocation(line: 167, column: 3, scope: !40)
!148 = !DILocation(line: 173, column: 17, scope: !40)
!149 = !DILocation(line: 173, column: 26, scope: !40)
!150 = !DILocation(line: 75, column: 10, scope: !100, inlinedAt: !151)
!151 = distinct !DILocation(line: 984, column: 9, scope: !103, inlinedAt: !152)
!152 = distinct !DILocation(line: 133, column: 53, scope: !106, inlinedAt: !153)
!153 = distinct !DILocation(line: 179, column: 41, scope: !40)
!154 = !DILocation(line: 179, column: 38, scope: !40)
!155 = !DILocation(line: 68, column: 3, scope: !77, inlinedAt: !156)
!156 = distinct !DILocation(line: 192, column: 3, scope: !80, inlinedAt: !157)
!157 = distinct !DILocation(line: 182, column: 3, scope: !40)
!158 = !DILocation(line: 69, column: 3, scope: !77, inlinedAt: !156)
!159 = !DILocation(line: 70, column: 3, scope: !77, inlinedAt: !156)
!160 = !DILocation(line: 185, column: 121, scope: !40)
!161 = !DILocation(line: 185, column: 149, scope: !40)
!162 = !DILocation(line: 185, column: 77, scope: !40)
!163 = !DILocation(line: 185, column: 155, scope: !40)
!164 = !DILocation(line: 185, column: 40, scope: !40)
!165 = !DILocation(line: 185, column: 198, scope: !40)
!166 = !DILocation(line: 185, column: 92, scope: !40)
!167 = !DILocation(line: 68, column: 3, scope: !77, inlinedAt: !168)
!168 = distinct !DILocation(line: 192, column: 3, scope: !80, inlinedAt: !169)
!169 = distinct !DILocation(line: 187, column: 3, scope: !40)
!170 = !DILocation(line: 69, column: 3, scope: !77, inlinedAt: !168)
!171 = !DILocation(line: 70, column: 3, scope: !77, inlinedAt: !168)
!172 = !DILocation(line: 189, column: 3, scope: !40)
!173 = !DILocation(line: 190, column: 22, scope: !40)
!174 = !DILocation(line: 190, column: 130, scope: !40)
!175 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!176 = !{i32 2, i32 -1, i32 -1, i32 -1}
!177 = !DILocation(line: 190, column: 167, scope: !40)
!178 = !DILocation(line: 192, column: 1, scope: !40)
