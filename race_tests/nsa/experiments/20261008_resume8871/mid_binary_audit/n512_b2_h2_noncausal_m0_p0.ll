; ModuleID = 'experiments/20261008_resume8871/mid_binary_audit/n512_b2_h2_noncausal_m0_p0.bc'
source_filename = "/tmp/tmp1hocybkt/tvm_kernels.maca"
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
  %1 = shl nuw nsw i32 %0, 19
  %mul = and i32 %1, 2146435072
  %2 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul7 = shl nsw i32 %2, 11
  %and = shl i32 %0, 10
  %mul9 = and i32 %and, 1024
  %3 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !42
  %mul14 = shl nuw nsw i32 %3, 3
  %add = add nuw nsw i32 %mul14, %mul7
  %add10 = add nuw nsw i32 %add, %mul
  %add12 = add nuw nsw i32 %add10, %mul9
  %4 = zext nneg i32 %add12 to i64, !dbg !43
  %5 = add nuw nsw i64 %4, 512, !dbg !44
  %6 = shl nuw nsw i32 %0, 9, !dbg !45
  %mul21 = and i32 %6, 2147482624, !dbg !45
  %mul23 = shl nuw nsw i32 %2, 1, !dbg !46
  %add24 = add nuw nsw i32 %mul21, %mul23, !dbg !47
  %and26 = and i32 %0, 1, !dbg !48
  %add27 = or disjoint i32 %add24, %and26, !dbg !49
  %idxprom = zext nneg i32 %add27 to i64, !dbg !50
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom, !dbg !50
  %7 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !50, !tbaa !30
  %cmp42 = icmp ult i32 %7, 32
  br i1 %cmp42, label %for.cond45.preheader, label %if.end346, !dbg !51

for.cond45.preheader:                             ; preds = %entry
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %5, !dbg !52
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4, !dbg !52
  %8 = shl nuw nsw i32 %0, 15
  %mul56 = and i32 %8, 2147418112
  %mul57 = shl nuw nsw i32 %7, 11
  %9 = shl nuw nsw i32 %3, 4
  %mul63 = and i32 %9, 16256
  %and66 = shl i32 %0, 6
  %mul67 = and i32 %and66, 64
  %mul71 = and i32 %mul14, 56
  %add58 = or disjoint i32 %mul63, %mul56
  %add60 = or disjoint i32 %add58, %mul67
  %add64 = or disjoint i32 %add60, %mul71
  %add68 = add nuw nsw i32 %add64, %mul57
  %10 = zext nneg i32 %add68 to i64, !dbg !53
  %add.ptr76 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %10, !dbg !54
  %11 = load i32, ptr addrspace(4) %add.ptr76, align 4, !dbg !55, !tbaa !30
  %12 = or disjoint i64 %10, 2, !dbg !56
  %add.ptr76.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %12, !dbg !54
  %13 = load i32, ptr addrspace(4) %add.ptr76.1, align 4, !dbg !55, !tbaa !30
  %14 = or disjoint i64 %10, 4, !dbg !56
  %add.ptr76.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %14, !dbg !54
  %15 = load i32, ptr addrspace(4) %add.ptr76.2, align 4, !dbg !55, !tbaa !30
  %16 = or disjoint i64 %10, 6, !dbg !56
  %add.ptr76.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %16, !dbg !54
  %17 = load i32, ptr addrspace(4) %add.ptr76.3, align 4, !dbg !55, !tbaa !30
  %18 = add nuw nsw i64 %10, 1024
  %add.ptr76.1663 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %18, !dbg !54
  %19 = load i32, ptr addrspace(4) %add.ptr76.1663, align 4, !dbg !55, !tbaa !30
  %20 = add nuw nsw i64 %10, 1026, !dbg !56
  %add.ptr76.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %20, !dbg !54
  %21 = load i32, ptr addrspace(4) %add.ptr76.1.1, align 4, !dbg !55, !tbaa !30
  %22 = add nuw nsw i64 %10, 1028, !dbg !56
  %add.ptr76.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %22, !dbg !54
  %23 = load i32, ptr addrspace(4) %add.ptr76.2.1, align 4, !dbg !55, !tbaa !30
  %24 = add nuw nsw i64 %10, 1030, !dbg !56
  %add.ptr76.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %24, !dbg !54
  %25 = load i32, ptr addrspace(4) %add.ptr76.3.1, align 4, !dbg !55, !tbaa !30
  %add.ptr119 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %10, !dbg !57
  %26 = load i32, ptr addrspace(4) %add.ptr119, align 4, !dbg !58, !tbaa !30
  %add.ptr119.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %12, !dbg !57
  %27 = load i32, ptr addrspace(4) %add.ptr119.1, align 4, !dbg !58, !tbaa !30
  %add.ptr119.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %14, !dbg !57
  %28 = load i32, ptr addrspace(4) %add.ptr119.2, align 4, !dbg !58, !tbaa !30
  %add.ptr119.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %16, !dbg !57
  %29 = load i32, ptr addrspace(4) %add.ptr119.3, align 4, !dbg !58, !tbaa !30
  %add.ptr119.1675 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %18, !dbg !57
  %30 = load i32, ptr addrspace(4) %add.ptr119.1675, align 4, !dbg !58, !tbaa !30
  %add.ptr119.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %20, !dbg !57
  %31 = load i32, ptr addrspace(4) %add.ptr119.1.1, align 4, !dbg !58, !tbaa !30
  %add.ptr119.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %22, !dbg !57
  %32 = load i32, ptr addrspace(4) %add.ptr119.2.1, align 4, !dbg !58, !tbaa !30
  %add.ptr119.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %24, !dbg !57
  %33 = load i32, ptr addrspace(4) %add.ptr119.3.1, align 4, !dbg !58, !tbaa !30
  %mul143 = and i32 %mul14, 8128
  %call147.masked = and i32 %3, 1016
  %mul149 = xor i32 %mul71, %call147.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul143, !dbg !59
  %invariant.gep616 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul149, !dbg !59
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep616, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !dbg !60, !call_argsrelate !61
  %gep617.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep616, i32 1024, !dbg !62
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep617.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !dbg !60, !call_argsrelate !61
  fence syncscope("warp") release, !dbg !63
  tail call void @llvm.mxc.barrier.warp(), !dbg !69
  fence syncscope("warp") acquire, !dbg !70
  %and161 = shl nuw nsw i32 %3, 6
  %mul162 = and i32 %and161, 960
  %shr165 = lshr i32 %3, 4
  %and168 = and i32 %3, 7
  %34 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul162
  %xor169 = xor i32 %shr165, %and168, !dbg !71
  %add.ptr173.idx = shl nuw nsw i32 %xor169, 4, !dbg !72
  %add.ptr173 = getelementptr inbounds i8, ptr addrspace(3) %34, i32 %add.ptr173.idx, !dbg !72
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr173, align 16, !dbg !73
  %Q_reg.sroa.4.0.add.ptr173.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr173, i32 8, !dbg !73
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr173.sroa_idx, align 8, !dbg !73
  %add166.1 = add nuw nsw i32 %shr165, 4, !dbg !74
  %xor169.1 = xor i32 %add166.1, %and168, !dbg !71
  %add.ptr173.idx.1 = shl nuw nsw i32 %xor169.1, 4, !dbg !72
  %add.ptr173.1 = getelementptr inbounds i8, ptr addrspace(3) %34, i32 %add.ptr173.idx.1, !dbg !72
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr173.1, align 16, !dbg !73
  %Q_reg.sroa.7.16.add.ptr173.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr173.1, i32 8, !dbg !73
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr173.1.sroa_idx, align 8, !dbg !73
  fence syncscope("warp") release, !dbg !75
  tail call void @llvm.mxc.barrier.warp(), !dbg !78
  fence syncscope("warp") acquire, !dbg !79
  store i32 %11, ptr addrspace(3) %invariant.gep616, align 16, !dbg !80, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep621.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep616, i32 4, !dbg !80
  store i32 %13, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep621.sroa_idx, align 4, !dbg !80, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep621.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep616, i32 8, !dbg !80
  store i32 %15, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep621.sroa_idx, align 8, !dbg !80, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep621.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep616, i32 12, !dbg !80
  store i32 %17, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep621.sroa_idx, align 4, !dbg !80, !tbaa !30
  store i32 %19, ptr addrspace(3) %gep617.1, align 16, !dbg !80, !tbaa !30
  %K_reg.sroa.9.16.gep622.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep616, i32 1028, !dbg !80
  store i32 %21, ptr addrspace(3) %K_reg.sroa.9.16.gep622.1.sroa_idx, align 4, !dbg !80, !tbaa !30
  %K_reg.sroa.10.16.gep622.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep616, i32 1032, !dbg !80
  store i32 %23, ptr addrspace(3) %K_reg.sroa.10.16.gep622.1.sroa_idx, align 8, !dbg !80, !tbaa !30
  %K_reg.sroa.11.16.gep622.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep616, i32 1036, !dbg !80
  store i32 %25, ptr addrspace(3) %K_reg.sroa.11.16.gep622.1.sroa_idx, align 4, !dbg !80, !tbaa !30
  fence syncscope("warp") release, !dbg !81
  tail call void @llvm.mxc.barrier.warp(), !dbg !84
  fence syncscope("warp") acquire, !dbg !85
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr173, align 16, !dbg !86
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr173.sroa_idx, align 8, !dbg !86
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !87
  %36 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %35), !dbg !87
  %kb.sroa.0.0.copyload705 = load <4 x half>, ptr addrspace(3) %add.ptr173.1, align 16, !dbg !86
  %kb.sroa.6.0.copyload706 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr173.1.sroa_idx, align 8, !dbg !86
  %37 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload705, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %36), !dbg !87
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload706, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %37), !dbg !87
  fence syncscope("warp") release, !dbg !88
  tail call void @llvm.mxc.barrier.warp(), !dbg !91
  fence syncscope("warp") acquire, !dbg !92
  %invariant.gep629 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %9, !dbg !93
  store i32 %26, ptr addrspace(3) %invariant.gep629, align 16, !dbg !94, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep629.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep629, i32 4, !dbg !94
  store i32 %27, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep629.sroa_idx, align 4, !dbg !94, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep629.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep629, i32 8, !dbg !94
  store i32 %28, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep629.sroa_idx, align 8, !dbg !94, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep629.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep629, i32 12, !dbg !94
  store i32 %29, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep629.sroa_idx, align 4, !dbg !94, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep629, i32 1024, !dbg !95
  store i32 %30, ptr addrspace(3) %gep.1, align 16, !dbg !94, !tbaa !30
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep629, i32 1028, !dbg !94
  store i32 %31, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !dbg !94, !tbaa !30
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep629, i32 1032, !dbg !94
  store i32 %32, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !dbg !94, !tbaa !30
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep629, i32 1036, !dbg !94
  store i32 %33, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !dbg !94, !tbaa !30
  %39 = shl nuw nsw i32 %7, 2
  %add278 = add nuw nsw i32 %39, %shr165
  %cmp279 = icmp ult i32 %add278, 128
  br i1 %cmp279, label %if.then280, label %if.end, !dbg !96

if.then280:                                       ; preds = %for.cond45.preheader
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %38, i64 0, !dbg !97
  %mul283 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !98
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul283, float 0x4024CB5EC0000000), !dbg !99
  %41 = tail call contract noundef float @llvm.exp.f32(float %40), !dbg !103
  br label %if.end, !dbg !106

if.end:                                           ; preds = %for.cond45.preheader, %if.then280
  %condval.0 = phi float [ %41, %if.then280 ], [ 0.000000e+00, %for.cond45.preheader ], !dbg !107
  br i1 %cmp279, label %if.then280.1, label %if.end.1, !dbg !96

if.then280.1:                                     ; preds = %if.end
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %38, i64 1, !dbg !97
  %mul283.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !98
  %42 = tail call contract noundef float @llvm.minnum.f32(float %mul283.1, float 0x4024CB5EC0000000), !dbg !99
  %43 = tail call contract noundef float @llvm.exp.f32(float %42), !dbg !103
  br label %if.end.1, !dbg !106

if.end.1:                                         ; preds = %if.then280.1, %if.end
  %condval.0.1 = phi float [ %43, %if.then280.1 ], [ 0.000000e+00, %if.end ], !dbg !107
  br i1 %cmp279, label %if.then280.2, label %if.end.2, !dbg !96

if.then280.2:                                     ; preds = %if.end.1
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %38, i64 2, !dbg !97
  %mul283.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !98
  %44 = tail call contract noundef float @llvm.minnum.f32(float %mul283.2, float 0x4024CB5EC0000000), !dbg !99
  %45 = tail call contract noundef float @llvm.exp.f32(float %44), !dbg !103
  br label %if.end.2, !dbg !106

if.end.2:                                         ; preds = %if.then280.2, %if.end.1
  %condval.0.2 = phi float [ %45, %if.then280.2 ], [ 0.000000e+00, %if.end.1 ], !dbg !107
  br i1 %cmp279, label %if.then280.3, label %if.end.3, !dbg !96

if.then280.3:                                     ; preds = %if.end.2
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %38, i64 3, !dbg !97
  %mul283.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !98
  %46 = tail call contract noundef float @llvm.minnum.f32(float %mul283.3, float 0x4024CB5EC0000000), !dbg !99
  %47 = tail call contract noundef float @llvm.exp.f32(float %46), !dbg !103
  br label %if.end.3, !dbg !106

if.end.3:                                         ; preds = %if.then280.3, %if.end.2
  %condval.0.3 = phi float [ %47, %if.then280.3 ], [ 0.000000e+00, %if.end.2 ], !dbg !107
  %add299.1 = fadd contract float %condval.0, %condval.0.1, !dbg !108
  %add299.2 = fadd contract float %add299.1, %condval.0.2, !dbg !108
  %add299.3 = fadd contract float %add299.2, %condval.0.3, !dbg !108
  %48 = bitcast float %add299.3 to i32, !dbg !109
  %49 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !112
  %50 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %49) #11, !dbg !117
  %xor.i.i = xor i32 %50, 32, !dbg !118
  %51 = and i32 %50, -64, !dbg !119
  %and.i.i = add nsw i32 %51, 64, !dbg !119
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !120
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %50, !dbg !121
  %shl.i.i = shl i32 %cond.i.i, 2, !dbg !122
  %52 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %48), !dbg !123
  %53 = bitcast i32 %52 to float, !dbg !124
  %add307 = fadd contract float %add299.3, %53, !dbg !125
  %54 = bitcast float %add307 to i32, !dbg !126
  %55 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !128
  %56 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %55) #11, !dbg !131
  %xor.i.i603 = xor i32 %56, 16, !dbg !132
  %57 = and i32 %56, -64, !dbg !133
  %and.i.i604 = add nsw i32 %57, 64, !dbg !133
  %cmp.not.i.i605 = icmp slt i32 %xor.i.i603, %and.i.i604, !dbg !134
  %cond.i.i606 = select i1 %cmp.not.i.i605, i32 %xor.i.i603, i32 %56, !dbg !135
  %shl.i.i607 = shl i32 %cond.i.i606, 2, !dbg !136
  %58 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i607, i32 %54), !dbg !137
  %59 = bitcast i32 %58 to float, !dbg !138
  %add312 = fadd contract float %add307, %59, !dbg !139
  %cmp315 = fcmp contract ogt float %add312, 0.000000e+00, !dbg !140
  %div = fdiv contract float 1.000000e+00, %add312, !dbg !141
  %condval_1.0 = select i1 %cmp315, float %div, float 0.000000e+00, !dbg !141
  %mul328 = fmul contract float %condval_1.0, %condval.0, !dbg !142
  %mul328.1 = fmul contract float %condval_1.0, %condval.0.1, !dbg !142
  %mul328.2 = fmul contract float %condval_1.0, %condval.0.2, !dbg !142
  %mul328.3 = fmul contract float %condval_1.0, %condval.0.3, !dbg !142
  %60 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul328), !dbg !143
  %61 = insertelement <4 x i16> poison, i16 %60, i64 0, !dbg !152
  %62 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul328.1), !dbg !143
  %63 = insertelement <4 x i16> %61, i16 %62, i64 1, !dbg !152
  %64 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul328.2), !dbg !143
  %65 = insertelement <4 x i16> %63, i16 %64, i64 2, !dbg !152
  %66 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul328.3), !dbg !143
  %67 = insertelement <4 x i16> %65, i16 %66, i64 3, !dbg !152
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %67 to <4 x half>, !dbg !152
  fence syncscope("warp") release, !dbg !153
  tail call void @llvm.mxc.barrier.warp(), !dbg !156
  fence syncscope("warp") acquire, !dbg !157
  br label %if.end346, !dbg !158

if.end346:                                        ; preds = %if.end.3, %entry
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ %acc_s_cast.sroa.0.6.vec.insert, %if.end.3 ], [ undef, %entry ]
  br i1 %cmp42, label %for.cond364.preheader, label %if.end412, !dbg !159

for.cond364.preheader:                            ; preds = %if.end346
  %68 = shl nuw nsw i32 %3, 4
  %mul374 = and i32 %68, 16128
  %and380 = and i32 %3, 15
  %add381 = or disjoint i32 %mul374, %and380, !dbg !160
  %arrayidx383 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add381, !dbg !161
  %69 = load half, ptr addrspace(3) %arrayidx383, align 2, !dbg !162, !tbaa !163
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %69, i64 0, !dbg !162
  %add376.1 = or disjoint i32 %mul374, %and380, !dbg !160
  %add381.1 = or disjoint i32 %add376.1, 64, !dbg !160
  %arrayidx383.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add381.1, !dbg !161
  %70 = load half, ptr addrspace(3) %arrayidx383.1, align 2, !dbg !162, !tbaa !163
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %70, i64 1, !dbg !162
  %add376.2 = or disjoint i32 %mul374, %and380, !dbg !160
  %add381.2 = or disjoint i32 %add376.2, 128, !dbg !160
  %arrayidx383.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add381.2, !dbg !161
  %71 = load half, ptr addrspace(3) %arrayidx383.2, align 2, !dbg !162, !tbaa !163
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %71, i64 2, !dbg !162
  %add376.3 = or disjoint i32 %mul374, %and380, !dbg !160
  %add381.3 = or disjoint i32 %add376.3, 192, !dbg !160
  %arrayidx383.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add381.3, !dbg !161
  %72 = load half, ptr addrspace(3) %arrayidx383.3, align 2, !dbg !162, !tbaa !163
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %72, i64 3, !dbg !162
  %add378.1679 = or disjoint i32 %mul374, %and380, !dbg !160
  %add381.1680 = or disjoint i32 %add378.1679, 16, !dbg !160
  %arrayidx383.1681 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add381.1680, !dbg !161
  %73 = load half, ptr addrspace(3) %arrayidx383.1681, align 2, !dbg !162, !tbaa !163
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %73, i64 0, !dbg !162
  %add378.1.1 = or disjoint i32 %mul374, %and380, !dbg !160
  %add381.1.1 = or disjoint i32 %add378.1.1, 80, !dbg !160
  %arrayidx383.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add381.1.1, !dbg !161
  %74 = load half, ptr addrspace(3) %arrayidx383.1.1, align 2, !dbg !162, !tbaa !163
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %74, i64 1, !dbg !162
  %add378.2.1 = or disjoint i32 %mul374, %and380, !dbg !160
  %add381.2.1 = or disjoint i32 %add378.2.1, 144, !dbg !160
  %arrayidx383.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add381.2.1, !dbg !161
  %75 = load half, ptr addrspace(3) %arrayidx383.2.1, align 2, !dbg !162, !tbaa !163
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %75, i64 2, !dbg !162
  %add378.3.1 = or disjoint i32 %mul374, %and380, !dbg !160
  %add381.3.1 = or disjoint i32 %add378.3.1, 208, !dbg !160
  %arrayidx383.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add381.3.1, !dbg !161
  %76 = load half, ptr addrspace(3) %arrayidx383.3.1, align 2, !dbg !162, !tbaa !163
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %76, i64 3, !dbg !162
  %add378.2683 = or disjoint i32 %mul374, %and380, !dbg !160
  %add381.2684 = or disjoint i32 %add378.2683, 32, !dbg !160
  %arrayidx383.2685 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add381.2684, !dbg !161
  %77 = load half, ptr addrspace(3) %arrayidx383.2685, align 2, !dbg !162, !tbaa !163
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %77, i64 0, !dbg !162
  %add378.1.2 = or disjoint i32 %mul374, %and380, !dbg !160
  %add381.1.2 = or disjoint i32 %add378.1.2, 96, !dbg !160
  %arrayidx383.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add381.1.2, !dbg !161
  %78 = load half, ptr addrspace(3) %arrayidx383.1.2, align 2, !dbg !162, !tbaa !163
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %78, i64 1, !dbg !162
  %add378.2.2 = or disjoint i32 %mul374, %and380, !dbg !160
  %add381.2.2 = or disjoint i32 %add378.2.2, 160, !dbg !160
  %arrayidx383.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add381.2.2, !dbg !161
  %79 = load half, ptr addrspace(3) %arrayidx383.2.2, align 2, !dbg !162, !tbaa !163
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %79, i64 2, !dbg !162
  %add378.3.2 = or disjoint i32 %mul374, %and380, !dbg !160
  %add381.3.2 = or disjoint i32 %add378.3.2, 224, !dbg !160
  %arrayidx383.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add381.3.2, !dbg !161
  %80 = load half, ptr addrspace(3) %arrayidx383.3.2, align 2, !dbg !162, !tbaa !163
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %80, i64 3, !dbg !162
  %add378.3687 = or disjoint i32 %mul374, %and380, !dbg !160
  %add381.3688 = or disjoint i32 %add378.3687, 48, !dbg !160
  %arrayidx383.3689 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add381.3688, !dbg !161
  %81 = load half, ptr addrspace(3) %arrayidx383.3689, align 2, !dbg !162, !tbaa !163
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %81, i64 0, !dbg !162
  %add378.1.3 = or disjoint i32 %mul374, %and380, !dbg !160
  %add381.1.3 = or disjoint i32 %add378.1.3, 112, !dbg !160
  %arrayidx383.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add381.1.3, !dbg !161
  %82 = load half, ptr addrspace(3) %arrayidx383.1.3, align 2, !dbg !162, !tbaa !163
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %82, i64 1, !dbg !162
  %add378.2.3 = or disjoint i32 %mul374, %and380, !dbg !160
  %add381.2.3 = or disjoint i32 %add378.2.3, 176, !dbg !160
  %arrayidx383.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add381.2.3, !dbg !161
  %83 = load half, ptr addrspace(3) %arrayidx383.2.3, align 2, !dbg !162, !tbaa !163
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %83, i64 2, !dbg !162
  %add378.3.3 = or disjoint i32 %68, %and380, !dbg !160
  %add381.3.3 = or i32 %add378.3.3, 240, !dbg !160
  %arrayidx383.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add381.3.3, !dbg !161
  %84 = load half, ptr addrspace(3) %arrayidx383.3.3, align 2, !dbg !162, !tbaa !163
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %84, i64 3, !dbg !162
  %85 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !164
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !164
  %87 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !164
  %88 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !164
  br label %if.end412, !dbg !165

if.end412:                                        ; preds = %for.cond364.preheader, %if.end346
  %acc_o.sroa.0.0 = phi <4 x float> [ %85, %for.cond364.preheader ], [ zeroinitializer, %if.end346 ], !dbg !107
  %acc_o.sroa.16.0 = phi <4 x float> [ %86, %for.cond364.preheader ], [ zeroinitializer, %if.end346 ], !dbg !107
  %acc_o.sroa.30.0 = phi <4 x float> [ %87, %for.cond364.preheader ], [ zeroinitializer, %if.end346 ], !dbg !107
  %acc_o.sroa.44.0 = phi <4 x float> [ %88, %for.cond364.preheader ], [ zeroinitializer, %if.end346 ], !dbg !107
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0, !dbg !166
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract), !dbg !167
  %O_reg.sroa.0.0.insert.ext = zext i16 %89 to i64, !dbg !171
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1, !dbg !166
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract), !dbg !167
  %O_reg.sroa.0.2.insert.ext = zext i16 %90 to i64, !dbg !171
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !171
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !171
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2, !dbg !166
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract), !dbg !167
  %O_reg.sroa.0.4.insert.ext = zext i16 %91 to i64, !dbg !171
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !171
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !171
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3, !dbg !166
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract), !dbg !167
  %O_reg.sroa.0.6.insert.ext = zext i16 %92 to i64, !dbg !171
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !171
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !171
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0, !dbg !166
  %93 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract), !dbg !167
  %O_reg.sroa.7.8.insert.ext = zext i16 %93 to i64, !dbg !171
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1, !dbg !166
  %94 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract), !dbg !167
  %O_reg.sroa.7.10.insert.ext = zext i16 %94 to i64, !dbg !171
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !171
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !171
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2, !dbg !166
  %95 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract), !dbg !167
  %O_reg.sroa.7.12.insert.ext = zext i16 %95 to i64, !dbg !171
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !171
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !171
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3, !dbg !166
  %96 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract), !dbg !167
  %O_reg.sroa.7.14.insert.ext = zext i16 %96 to i64, !dbg !171
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !171
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !171
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0, !dbg !166
  %97 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract), !dbg !167
  %O_reg.sroa.12.16.insert.ext = zext i16 %97 to i64, !dbg !171
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1, !dbg !166
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract), !dbg !167
  %O_reg.sroa.12.18.insert.ext = zext i16 %98 to i64, !dbg !171
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !171
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !171
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2, !dbg !166
  %99 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract), !dbg !167
  %O_reg.sroa.12.20.insert.ext = zext i16 %99 to i64, !dbg !171
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !171
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !171
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3, !dbg !166
  %100 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract), !dbg !167
  %O_reg.sroa.12.22.insert.ext = zext i16 %100 to i64, !dbg !171
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !171
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !171
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0, !dbg !166
  %101 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract), !dbg !167
  %O_reg.sroa.17.24.insert.ext = zext i16 %101 to i64, !dbg !171
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1, !dbg !166
  %102 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract), !dbg !167
  %O_reg.sroa.17.26.insert.ext = zext i16 %102 to i64, !dbg !171
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !171
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !171
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2, !dbg !166
  %103 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract), !dbg !167
  %O_reg.sroa.17.28.insert.ext = zext i16 %103 to i64, !dbg !171
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !171
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !171
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3, !dbg !166
  %104 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract), !dbg !167
  %O_reg.sroa.17.30.insert.ext = zext i16 %104 to i64, !dbg !171
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !171
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !171
  fence syncscope("warp") release, !dbg !172
  tail call void @llvm.mxc.barrier.warp(), !dbg !175
  fence syncscope("warp") acquire, !dbg !176
  %and445 = shl nuw nsw i32 %3, 6
  %mul446 = and i32 %and445, 960
  %shr449 = lshr i32 %3, 5
  %and452 = and i32 %3, 7
  %105 = lshr i32 %3, 2
  %mul459 = and i32 %105, 4
  %xor453 = xor i32 %shr449, %and452, !dbg !177
  %mul454 = shl nuw nsw i32 %xor453, 3, !dbg !178
  %add455 = add nuw nsw i32 %mul454, %mul446, !dbg !179
  %add460 = or disjoint i32 %add455, %mul459, !dbg !180
  %add.ptr462 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add460, !dbg !181
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr462, align 8, !dbg !182
  %add450.1 = add nuw nsw i32 %shr449, 2, !dbg !183
  %xor453.1 = xor i32 %add450.1, %and452, !dbg !177
  %mul454.1 = shl nuw nsw i32 %xor453.1, 3, !dbg !178
  %add455.1 = add nuw nsw i32 %mul454.1, %mul446, !dbg !179
  %add460.1 = or disjoint i32 %add455.1, %mul459, !dbg !180
  %add.ptr462.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add460.1, !dbg !181
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr462.1, align 8, !dbg !182
  %add450.2 = add nuw nsw i32 %shr449, 4, !dbg !183
  %xor453.2 = xor i32 %add450.2, %and452, !dbg !177
  %mul454.2 = shl nuw nsw i32 %xor453.2, 3, !dbg !178
  %add455.2 = add nuw nsw i32 %mul454.2, %mul446, !dbg !179
  %add460.2 = or disjoint i32 %add455.2, %mul459, !dbg !180
  %add.ptr462.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add460.2, !dbg !181
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr462.2, align 8, !dbg !182
  %add450.3 = add nuw nsw i32 %shr449, 6, !dbg !183
  %xor453.3 = xor i32 %add450.3, %and452, !dbg !177
  %mul454.3 = shl nuw nsw i32 %xor453.3, 3, !dbg !178
  %add455.3 = add nuw nsw i32 %mul454.3, %mul446, !dbg !179
  %add460.3 = or disjoint i32 %add455.3, %mul459, !dbg !180
  %add.ptr462.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add460.3, !dbg !181
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr462.3, align 8, !dbg !182
  fence syncscope("warp") release, !dbg !184
  tail call void @llvm.mxc.barrier.warp(), !dbg !187
  fence syncscope("warp") acquire, !dbg !188
  %mul473 = and i32 %mul14, 8128
  %xor479597 = and i32 %mul14, 56
  %call477.masked = and i32 %3, 1016
  %mul480 = xor i32 %xor479597, %call477.masked
  %invariant.gep643 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul473, !dbg !189
  %invariant.gep645 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep643, i32 %mul480, !dbg !189
  %add.ptr500 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4, !dbg !190
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr500, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep645, i64 16, i1 false), !dbg !191, !tbaa.struct !192, !call_argsrelate !193
  %gep646.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep645, i32 1024, !dbg !194
  %add.ptr500.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %5, !dbg !190
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr500.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep646.1, i64 16, i1 false), !dbg !191, !tbaa.struct !192, !call_argsrelate !193
  ret void, !dbg !195
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
!1 = !DIFile(filename: "/tmp/tmp1hocybkt/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmp1hocybkt/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 25, column: 3, scope: !40)
!44 = !DILocation(line: 26, column: 170, scope: !40)
!45 = !DILocation(line: 28, column: 66, scope: !40)
!46 = !DILocation(line: 28, column: 95, scope: !40)
!47 = !DILocation(line: 28, column: 74, scope: !40)
!48 = !DILocation(line: 28, column: 122, scope: !40)
!49 = !DILocation(line: 28, column: 101, scope: !40)
!50 = !DILocation(line: 28, column: 25, scope: !40)
!51 = !DILocation(line: 34, column: 30, scope: !40)
!52 = !DILocation(line: 26, column: 48, scope: !40)
!53 = !DILocation(line: 37, column: 5, scope: !40)
!54 = !DILocation(line: 40, column: 79, scope: !40)
!55 = !DILocation(line: 40, column: 58, scope: !40)
!56 = !DILocation(line: 40, column: 274, scope: !40)
!57 = !DILocation(line: 47, column: 79, scope: !40)
!58 = !DILocation(line: 47, column: 58, scope: !40)
!59 = !DILocation(line: 51, column: 5, scope: !40)
!60 = !DILocation(line: 52, column: 159, scope: !40)
!61 = !{i32 1, i32 3, i32 -1, i32 -1}
!62 = !DILocation(line: 52, column: 42, scope: !40)
!63 = !DILocation(line: 68, column: 3, scope: !64, inlinedAt: !66)
!64 = distinct !DISubprogram(name: "__barrier_warp", scope: !65, file: !65, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!65 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!66 = distinct !DILocation(line: 192, column: 3, scope: !67, inlinedAt: !68)
!67 = distinct !DISubprogram(name: "__syncwarp", scope: !65, file: !65, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!68 = distinct !DILocation(line: 54, column: 5, scope: !40)
!69 = !DILocation(line: 69, column: 3, scope: !64, inlinedAt: !66)
!70 = !DILocation(line: 70, column: 3, scope: !64, inlinedAt: !66)
!71 = !DILocation(line: 57, column: 153, scope: !40)
!72 = !DILocation(line: 57, column: 73, scope: !40)
!73 = !DILocation(line: 57, column: 36, scope: !40)
!74 = !DILocation(line: 57, column: 124, scope: !40)
!75 = !DILocation(line: 68, column: 3, scope: !64, inlinedAt: !76)
!76 = distinct !DILocation(line: 192, column: 3, scope: !67, inlinedAt: !77)
!77 = distinct !DILocation(line: 59, column: 5, scope: !40)
!78 = !DILocation(line: 69, column: 3, scope: !64, inlinedAt: !76)
!79 = !DILocation(line: 70, column: 3, scope: !64, inlinedAt: !76)
!80 = !DILocation(line: 62, column: 159, scope: !40)
!81 = !DILocation(line: 68, column: 3, scope: !64, inlinedAt: !82)
!82 = distinct !DILocation(line: 192, column: 3, scope: !67, inlinedAt: !83)
!83 = distinct !DILocation(line: 66, column: 5, scope: !40)
!84 = !DILocation(line: 69, column: 3, scope: !64, inlinedAt: !82)
!85 = !DILocation(line: 70, column: 3, scope: !64, inlinedAt: !82)
!86 = !DILocation(line: 68, column: 25, scope: !40)
!87 = !DILocation(line: 71, column: 36, scope: !40)
!88 = !DILocation(line: 68, column: 3, scope: !64, inlinedAt: !89)
!89 = distinct !DILocation(line: 192, column: 3, scope: !67, inlinedAt: !90)
!90 = distinct !DILocation(line: 77, column: 5, scope: !40)
!91 = !DILocation(line: 69, column: 3, scope: !64, inlinedAt: !89)
!92 = !DILocation(line: 70, column: 3, scope: !64, inlinedAt: !89)
!93 = !DILocation(line: 79, column: 10, scope: !40)
!94 = !DILocation(line: 80, column: 86, scope: !40)
!95 = !DILocation(line: 80, column: 42, scope: !40)
!96 = !DILocation(line: 85, column: 11, scope: !40)
!97 = !DILocation(line: 86, column: 29, scope: !40)
!98 = !DILocation(line: 86, column: 40, scope: !40)
!99 = !DILocation(line: 354, column: 10, scope: !100, inlinedAt: !102)
!100 = distinct !DISubprogram(name: "min", scope: !101, file: !101, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!101 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!102 = distinct !DILocation(line: 86, column: 24, scope: !40)
!103 = !DILocation(line: 288, column: 10, scope: !104, inlinedAt: !105)
!104 = distinct !DISubprogram(name: "expf", scope: !101, file: !101, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!105 = distinct !DILocation(line: 86, column: 19, scope: !40)
!106 = !DILocation(line: 87, column: 7, scope: !40)
!107 = !DILocation(line: 0, scope: !40)
!108 = !DILocation(line: 95, column: 34, scope: !40)
!109 = !DILocation(line: 1018, column: 9, scope: !110, inlinedAt: !111)
!110 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !65, file: !65, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!111 = distinct !DILocation(line: 97, column: 34, scope: !40)
!112 = !DILocation(line: 171, column: 37, scope: !113, inlinedAt: !114)
!113 = distinct !DISubprogram(name: "__lane_id", scope: !65, file: !65, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!114 = distinct !DILocation(line: 990, column: 14, scope: !115, inlinedAt: !116)
!115 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !65, file: !65, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!116 = distinct !DILocation(line: 1019, column: 11, scope: !110, inlinedAt: !111)
!117 = !DILocation(line: 171, column: 10, scope: !113, inlinedAt: !114)
!118 = !DILocation(line: 991, column: 20, scope: !115, inlinedAt: !116)
!119 = !DILocation(line: 992, column: 36, scope: !115, inlinedAt: !116)
!120 = !DILocation(line: 992, column: 17, scope: !115, inlinedAt: !116)
!121 = !DILocation(line: 992, column: 11, scope: !115, inlinedAt: !116)
!122 = !DILocation(line: 993, column: 43, scope: !115, inlinedAt: !116)
!123 = !DILocation(line: 993, column: 10, scope: !115, inlinedAt: !116)
!124 = !DILocation(line: 1020, column: 14, scope: !110, inlinedAt: !111)
!125 = !DILocation(line: 97, column: 32, scope: !40)
!126 = !DILocation(line: 1018, column: 9, scope: !110, inlinedAt: !127)
!127 = distinct !DILocation(line: 98, column: 34, scope: !40)
!128 = !DILocation(line: 171, column: 37, scope: !113, inlinedAt: !129)
!129 = distinct !DILocation(line: 990, column: 14, scope: !115, inlinedAt: !130)
!130 = distinct !DILocation(line: 1019, column: 11, scope: !110, inlinedAt: !127)
!131 = !DILocation(line: 171, column: 10, scope: !113, inlinedAt: !129)
!132 = !DILocation(line: 991, column: 20, scope: !115, inlinedAt: !130)
!133 = !DILocation(line: 992, column: 36, scope: !115, inlinedAt: !130)
!134 = !DILocation(line: 992, column: 17, scope: !115, inlinedAt: !130)
!135 = !DILocation(line: 992, column: 11, scope: !115, inlinedAt: !130)
!136 = !DILocation(line: 993, column: 43, scope: !115, inlinedAt: !130)
!137 = !DILocation(line: 993, column: 10, scope: !115, inlinedAt: !130)
!138 = !DILocation(line: 1020, column: 14, scope: !110, inlinedAt: !127)
!139 = !DILocation(line: 98, column: 32, scope: !40)
!140 = !DILocation(line: 100, column: 34, scope: !40)
!141 = !DILocation(line: 100, column: 9, scope: !40)
!142 = !DILocation(line: 108, column: 32, scope: !40)
!143 = !DILocation(line: 75, column: 10, scope: !144, inlinedAt: !146)
!144 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !145, file: !145, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!145 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!146 = distinct !DILocation(line: 984, column: 9, scope: !147, inlinedAt: !149)
!147 = distinct !DISubprogram(name: "__float2half", scope: !148, file: !148, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!148 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!149 = distinct !DILocation(line: 133, column: 53, scope: !150, inlinedAt: !151)
!150 = distinct !DISubprogram(name: "__half", scope: !148, file: !148, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!151 = distinct !DILocation(line: 112, column: 32, scope: !40)
!152 = !DILocation(line: 112, column: 29, scope: !40)
!153 = !DILocation(line: 68, column: 3, scope: !64, inlinedAt: !154)
!154 = distinct !DILocation(line: 192, column: 3, scope: !67, inlinedAt: !155)
!155 = distinct !DILocation(line: 114, column: 5, scope: !40)
!156 = !DILocation(line: 69, column: 3, scope: !64, inlinedAt: !154)
!157 = !DILocation(line: 70, column: 3, scope: !64, inlinedAt: !154)
!158 = !DILocation(line: 115, column: 3, scope: !40)
!159 = !DILocation(line: 121, column: 30, scope: !40)
!160 = !DILocation(line: 124, column: 119, scope: !40)
!161 = !DILocation(line: 124, column: 31, scope: !40)
!162 = !DILocation(line: 124, column: 29, scope: !40)
!163 = !{!26, !26, i64 0}
!164 = !DILocation(line: 129, column: 38, scope: !40)
!165 = !DILocation(line: 136, column: 3, scope: !40)
!166 = !DILocation(line: 139, column: 58, scope: !40)
!167 = !DILocation(line: 75, column: 10, scope: !144, inlinedAt: !168)
!168 = distinct !DILocation(line: 984, column: 9, scope: !147, inlinedAt: !169)
!169 = distinct !DILocation(line: 133, column: 53, scope: !150, inlinedAt: !170)
!170 = distinct !DILocation(line: 139, column: 50, scope: !40)
!171 = !DILocation(line: 139, column: 47, scope: !40)
!172 = !DILocation(line: 68, column: 3, scope: !64, inlinedAt: !173)
!173 = distinct !DILocation(line: 192, column: 3, scope: !67, inlinedAt: !174)
!174 = distinct !DILocation(line: 142, column: 3, scope: !40)
!175 = !DILocation(line: 69, column: 3, scope: !64, inlinedAt: !173)
!176 = !DILocation(line: 70, column: 3, scope: !64, inlinedAt: !173)
!177 = !DILocation(line: 145, column: 121, scope: !40)
!178 = !DILocation(line: 145, column: 149, scope: !40)
!179 = !DILocation(line: 145, column: 77, scope: !40)
!180 = !DILocation(line: 145, column: 155, scope: !40)
!181 = !DILocation(line: 145, column: 40, scope: !40)
!182 = !DILocation(line: 145, column: 198, scope: !40)
!183 = !DILocation(line: 145, column: 92, scope: !40)
!184 = !DILocation(line: 68, column: 3, scope: !64, inlinedAt: !185)
!185 = distinct !DILocation(line: 192, column: 3, scope: !67, inlinedAt: !186)
!186 = distinct !DILocation(line: 147, column: 3, scope: !40)
!187 = !DILocation(line: 69, column: 3, scope: !64, inlinedAt: !185)
!188 = !DILocation(line: 70, column: 3, scope: !64, inlinedAt: !185)
!189 = !DILocation(line: 149, column: 8, scope: !40)
!190 = !DILocation(line: 150, column: 22, scope: !40)
!191 = !DILocation(line: 150, column: 176, scope: !40)
!192 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!193 = !{i32 2, i32 -1, i32 -1, i32 -1}
!194 = !DILocation(line: 150, column: 213, scope: !40)
!195 = !DILocation(line: 152, column: 1, scope: !40)
