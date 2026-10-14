; ModuleID = 'experiments/20261008_resume8871/mid_binary_audit/n512_b2_h2_noncausal_m1_p0.bc'
source_filename = "/tmp/tmp7ovvnekx/tvm_kernels.maca"
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
  br i1 %cmp42, label %for.cond45.preheader, label %if.end336, !dbg !51

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
  %add.ptr76.1652 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %18, !dbg !54
  %19 = load i32, ptr addrspace(4) %add.ptr76.1652, align 4, !dbg !55, !tbaa !30
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
  %add.ptr119.1664 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %18, !dbg !57
  %30 = load i32, ptr addrspace(4) %add.ptr119.1664, align 4, !dbg !58, !tbaa !30
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
  %invariant.gep605 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul149, !dbg !59
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep605, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !dbg !60, !call_argsrelate !61
  %gep606.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep605, i32 1024, !dbg !62
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep606.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !dbg !60, !call_argsrelate !61
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
  store i32 %11, ptr addrspace(3) %invariant.gep605, align 16, !dbg !80, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep610.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep605, i32 4, !dbg !80
  store i32 %13, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep610.sroa_idx, align 4, !dbg !80, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep610.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep605, i32 8, !dbg !80
  store i32 %15, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep610.sroa_idx, align 8, !dbg !80, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep610.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep605, i32 12, !dbg !80
  store i32 %17, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep610.sroa_idx, align 4, !dbg !80, !tbaa !30
  store i32 %19, ptr addrspace(3) %gep606.1, align 16, !dbg !80, !tbaa !30
  %K_reg.sroa.9.16.gep611.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep605, i32 1028, !dbg !80
  store i32 %21, ptr addrspace(3) %K_reg.sroa.9.16.gep611.1.sroa_idx, align 4, !dbg !80, !tbaa !30
  %K_reg.sroa.10.16.gep611.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep605, i32 1032, !dbg !80
  store i32 %23, ptr addrspace(3) %K_reg.sroa.10.16.gep611.1.sroa_idx, align 8, !dbg !80, !tbaa !30
  %K_reg.sroa.11.16.gep611.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep605, i32 1036, !dbg !80
  store i32 %25, ptr addrspace(3) %K_reg.sroa.11.16.gep611.1.sroa_idx, align 4, !dbg !80, !tbaa !30
  fence syncscope("warp") release, !dbg !81
  tail call void @llvm.mxc.barrier.warp(), !dbg !84
  fence syncscope("warp") acquire, !dbg !85
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr173, align 16, !dbg !86
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr173.sroa_idx, align 8, !dbg !86
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !87
  %36 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %35), !dbg !87
  %kb.sroa.0.0.copyload694 = load <4 x half>, ptr addrspace(3) %add.ptr173.1, align 16, !dbg !86
  %kb.sroa.6.0.copyload695 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr173.1.sroa_idx, align 8, !dbg !86
  %37 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload694, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %36), !dbg !87
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload695, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %37), !dbg !87
  fence syncscope("warp") release, !dbg !88
  tail call void @llvm.mxc.barrier.warp(), !dbg !91
  fence syncscope("warp") acquire, !dbg !92
  %invariant.gep618 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %9, !dbg !93
  store i32 %26, ptr addrspace(3) %invariant.gep618, align 16, !dbg !94, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep618.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep618, i32 4, !dbg !94
  store i32 %27, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep618.sroa_idx, align 4, !dbg !94, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep618.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep618, i32 8, !dbg !94
  store i32 %28, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep618.sroa_idx, align 8, !dbg !94, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep618.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep618, i32 12, !dbg !94
  store i32 %29, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep618.sroa_idx, align 4, !dbg !94, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep618, i32 1024, !dbg !95
  store i32 %30, ptr addrspace(3) %gep.1, align 16, !dbg !94, !tbaa !30
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep618, i32 1028, !dbg !94
  store i32 %31, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !dbg !94, !tbaa !30
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep618, i32 1032, !dbg !94
  store i32 %32, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !dbg !94, !tbaa !30
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep618, i32 1036, !dbg !94
  store i32 %33, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !dbg !94, !tbaa !30
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %38, i64 0, !dbg !96
  %mul275 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !97
  %39 = tail call contract noundef float @llvm.minnum.f32(float %mul275, float 0x4024CB5EC0000000), !dbg !98
  %40 = tail call contract noundef float @llvm.exp.f32(float %39), !dbg !102
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %38, i64 1, !dbg !96
  %mul275.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !97
  %41 = tail call contract noundef float @llvm.minnum.f32(float %mul275.1, float 0x4024CB5EC0000000), !dbg !98
  %42 = tail call contract noundef float @llvm.exp.f32(float %41), !dbg !102
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %38, i64 2, !dbg !96
  %mul275.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !97
  %43 = tail call contract noundef float @llvm.minnum.f32(float %mul275.2, float 0x4024CB5EC0000000), !dbg !98
  %44 = tail call contract noundef float @llvm.exp.f32(float %43), !dbg !102
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %38, i64 3, !dbg !96
  %mul275.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !97
  %45 = tail call contract noundef float @llvm.minnum.f32(float %mul275.3, float 0x4024CB5EC0000000), !dbg !98
  %46 = tail call contract noundef float @llvm.exp.f32(float %45), !dbg !102
  %add291.1 = fadd contract float %40, %42, !dbg !105
  %add291.2 = fadd contract float %add291.1, %44, !dbg !105
  %add291.3 = fadd contract float %add291.2, %46, !dbg !105
  %47 = bitcast float %add291.3 to i32, !dbg !106
  %48 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !109
  %49 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %48) #11, !dbg !114
  %xor.i.i = xor i32 %49, 32, !dbg !115
  %50 = and i32 %49, -64, !dbg !116
  %and.i.i = add nsw i32 %50, 64, !dbg !116
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !117
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %49, !dbg !118
  %shl.i.i = shl i32 %cond.i.i, 2, !dbg !119
  %51 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %47), !dbg !120
  %52 = bitcast i32 %51 to float, !dbg !121
  %add299 = fadd contract float %add291.3, %52, !dbg !122
  %53 = bitcast float %add299 to i32, !dbg !123
  %54 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !125
  %55 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %54) #11, !dbg !128
  %xor.i.i592 = xor i32 %55, 16, !dbg !129
  %56 = and i32 %55, -64, !dbg !130
  %and.i.i593 = add nsw i32 %56, 64, !dbg !130
  %cmp.not.i.i594 = icmp slt i32 %xor.i.i592, %and.i.i593, !dbg !131
  %cond.i.i595 = select i1 %cmp.not.i.i594, i32 %xor.i.i592, i32 %55, !dbg !132
  %shl.i.i596 = shl i32 %cond.i.i595, 2, !dbg !133
  %57 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i596, i32 %53), !dbg !134
  %58 = bitcast i32 %57 to float, !dbg !135
  %add304 = fadd contract float %add299, %58, !dbg !136
  %cmp307 = fcmp contract ogt float %add304, 0.000000e+00, !dbg !137
  %div = fdiv contract float 1.000000e+00, %add304, !dbg !138
  %condval.0 = select i1 %cmp307, float %div, float 0.000000e+00, !dbg !138
  %mul318 = fmul contract float %condval.0, %40, !dbg !139
  %mul318.1 = fmul contract float %condval.0, %42, !dbg !139
  %mul318.2 = fmul contract float %condval.0, %44, !dbg !139
  %mul318.3 = fmul contract float %condval.0, %46, !dbg !139
  %59 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul318), !dbg !140
  %60 = insertelement <4 x i16> poison, i16 %59, i64 0, !dbg !149
  %61 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul318.1), !dbg !140
  %62 = insertelement <4 x i16> %60, i16 %61, i64 1, !dbg !149
  %63 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul318.2), !dbg !140
  %64 = insertelement <4 x i16> %62, i16 %63, i64 2, !dbg !149
  %65 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul318.3), !dbg !140
  %66 = insertelement <4 x i16> %64, i16 %65, i64 3, !dbg !149
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %66 to <4 x half>, !dbg !149
  fence syncscope("warp") release, !dbg !150
  tail call void @llvm.mxc.barrier.warp(), !dbg !153
  fence syncscope("warp") acquire, !dbg !154
  br label %if.end336, !dbg !155

if.end336:                                        ; preds = %for.cond45.preheader, %entry
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ %acc_s_cast.sroa.0.6.vec.insert, %for.cond45.preheader ], [ undef, %entry ]
  br i1 %cmp42, label %for.cond354.preheader, label %if.end402, !dbg !156

for.cond354.preheader:                            ; preds = %if.end336
  %67 = shl nuw nsw i32 %3, 4
  %mul364 = and i32 %67, 16128
  %and370 = and i32 %3, 15
  %add371 = or disjoint i32 %mul364, %and370, !dbg !157
  %arrayidx373 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371, !dbg !158
  %68 = load half, ptr addrspace(3) %arrayidx373, align 2, !dbg !159, !tbaa !160
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %68, i64 0, !dbg !159
  %add366.1 = or disjoint i32 %mul364, %and370, !dbg !157
  %add371.1 = or disjoint i32 %add366.1, 64, !dbg !157
  %arrayidx373.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.1, !dbg !158
  %69 = load half, ptr addrspace(3) %arrayidx373.1, align 2, !dbg !159, !tbaa !160
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %69, i64 1, !dbg !159
  %add366.2 = or disjoint i32 %mul364, %and370, !dbg !157
  %add371.2 = or disjoint i32 %add366.2, 128, !dbg !157
  %arrayidx373.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.2, !dbg !158
  %70 = load half, ptr addrspace(3) %arrayidx373.2, align 2, !dbg !159, !tbaa !160
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %70, i64 2, !dbg !159
  %add366.3 = or disjoint i32 %mul364, %and370, !dbg !157
  %add371.3 = or disjoint i32 %add366.3, 192, !dbg !157
  %arrayidx373.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.3, !dbg !158
  %71 = load half, ptr addrspace(3) %arrayidx373.3, align 2, !dbg !159, !tbaa !160
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %71, i64 3, !dbg !159
  %add368.1668 = or disjoint i32 %mul364, %and370, !dbg !157
  %add371.1669 = or disjoint i32 %add368.1668, 16, !dbg !157
  %arrayidx373.1670 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.1669, !dbg !158
  %72 = load half, ptr addrspace(3) %arrayidx373.1670, align 2, !dbg !159, !tbaa !160
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %72, i64 0, !dbg !159
  %add368.1.1 = or disjoint i32 %mul364, %and370, !dbg !157
  %add371.1.1 = or disjoint i32 %add368.1.1, 80, !dbg !157
  %arrayidx373.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.1.1, !dbg !158
  %73 = load half, ptr addrspace(3) %arrayidx373.1.1, align 2, !dbg !159, !tbaa !160
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %73, i64 1, !dbg !159
  %add368.2.1 = or disjoint i32 %mul364, %and370, !dbg !157
  %add371.2.1 = or disjoint i32 %add368.2.1, 144, !dbg !157
  %arrayidx373.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.2.1, !dbg !158
  %74 = load half, ptr addrspace(3) %arrayidx373.2.1, align 2, !dbg !159, !tbaa !160
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %74, i64 2, !dbg !159
  %add368.3.1 = or disjoint i32 %mul364, %and370, !dbg !157
  %add371.3.1 = or disjoint i32 %add368.3.1, 208, !dbg !157
  %arrayidx373.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.3.1, !dbg !158
  %75 = load half, ptr addrspace(3) %arrayidx373.3.1, align 2, !dbg !159, !tbaa !160
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %75, i64 3, !dbg !159
  %add368.2672 = or disjoint i32 %mul364, %and370, !dbg !157
  %add371.2673 = or disjoint i32 %add368.2672, 32, !dbg !157
  %arrayidx373.2674 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.2673, !dbg !158
  %76 = load half, ptr addrspace(3) %arrayidx373.2674, align 2, !dbg !159, !tbaa !160
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %76, i64 0, !dbg !159
  %add368.1.2 = or disjoint i32 %mul364, %and370, !dbg !157
  %add371.1.2 = or disjoint i32 %add368.1.2, 96, !dbg !157
  %arrayidx373.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.1.2, !dbg !158
  %77 = load half, ptr addrspace(3) %arrayidx373.1.2, align 2, !dbg !159, !tbaa !160
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %77, i64 1, !dbg !159
  %add368.2.2 = or disjoint i32 %mul364, %and370, !dbg !157
  %add371.2.2 = or disjoint i32 %add368.2.2, 160, !dbg !157
  %arrayidx373.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.2.2, !dbg !158
  %78 = load half, ptr addrspace(3) %arrayidx373.2.2, align 2, !dbg !159, !tbaa !160
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %78, i64 2, !dbg !159
  %add368.3.2 = or disjoint i32 %mul364, %and370, !dbg !157
  %add371.3.2 = or disjoint i32 %add368.3.2, 224, !dbg !157
  %arrayidx373.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.3.2, !dbg !158
  %79 = load half, ptr addrspace(3) %arrayidx373.3.2, align 2, !dbg !159, !tbaa !160
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %79, i64 3, !dbg !159
  %add368.3676 = or disjoint i32 %mul364, %and370, !dbg !157
  %add371.3677 = or disjoint i32 %add368.3676, 48, !dbg !157
  %arrayidx373.3678 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.3677, !dbg !158
  %80 = load half, ptr addrspace(3) %arrayidx373.3678, align 2, !dbg !159, !tbaa !160
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %80, i64 0, !dbg !159
  %add368.1.3 = or disjoint i32 %mul364, %and370, !dbg !157
  %add371.1.3 = or disjoint i32 %add368.1.3, 112, !dbg !157
  %arrayidx373.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.1.3, !dbg !158
  %81 = load half, ptr addrspace(3) %arrayidx373.1.3, align 2, !dbg !159, !tbaa !160
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %81, i64 1, !dbg !159
  %add368.2.3 = or disjoint i32 %mul364, %and370, !dbg !157
  %add371.2.3 = or disjoint i32 %add368.2.3, 176, !dbg !157
  %arrayidx373.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.2.3, !dbg !158
  %82 = load half, ptr addrspace(3) %arrayidx373.2.3, align 2, !dbg !159, !tbaa !160
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %82, i64 2, !dbg !159
  %add368.3.3 = or disjoint i32 %67, %and370, !dbg !157
  %add371.3.3 = or i32 %add368.3.3, 240, !dbg !157
  %arrayidx373.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add371.3.3, !dbg !158
  %83 = load half, ptr addrspace(3) %arrayidx373.3.3, align 2, !dbg !159, !tbaa !160
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %83, i64 3, !dbg !159
  %84 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !161
  %85 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !161
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !161
  %87 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !161
  br label %if.end402, !dbg !162

if.end402:                                        ; preds = %for.cond354.preheader, %if.end336
  %acc_o.sroa.0.0 = phi <4 x float> [ %84, %for.cond354.preheader ], [ zeroinitializer, %if.end336 ], !dbg !163
  %acc_o.sroa.16.0 = phi <4 x float> [ %85, %for.cond354.preheader ], [ zeroinitializer, %if.end336 ], !dbg !163
  %acc_o.sroa.30.0 = phi <4 x float> [ %86, %for.cond354.preheader ], [ zeroinitializer, %if.end336 ], !dbg !163
  %acc_o.sroa.44.0 = phi <4 x float> [ %87, %for.cond354.preheader ], [ zeroinitializer, %if.end336 ], !dbg !163
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0, !dbg !164
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract), !dbg !165
  %O_reg.sroa.0.0.insert.ext = zext i16 %88 to i64, !dbg !169
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1, !dbg !164
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract), !dbg !165
  %O_reg.sroa.0.2.insert.ext = zext i16 %89 to i64, !dbg !169
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !169
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !169
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2, !dbg !164
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract), !dbg !165
  %O_reg.sroa.0.4.insert.ext = zext i16 %90 to i64, !dbg !169
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !169
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !169
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3, !dbg !164
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract), !dbg !165
  %O_reg.sroa.0.6.insert.ext = zext i16 %91 to i64, !dbg !169
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !169
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !169
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0, !dbg !164
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract), !dbg !165
  %O_reg.sroa.7.8.insert.ext = zext i16 %92 to i64, !dbg !169
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1, !dbg !164
  %93 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract), !dbg !165
  %O_reg.sroa.7.10.insert.ext = zext i16 %93 to i64, !dbg !169
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !169
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !169
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2, !dbg !164
  %94 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract), !dbg !165
  %O_reg.sroa.7.12.insert.ext = zext i16 %94 to i64, !dbg !169
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !169
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !169
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3, !dbg !164
  %95 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract), !dbg !165
  %O_reg.sroa.7.14.insert.ext = zext i16 %95 to i64, !dbg !169
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !169
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !169
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0, !dbg !164
  %96 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract), !dbg !165
  %O_reg.sroa.12.16.insert.ext = zext i16 %96 to i64, !dbg !169
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1, !dbg !164
  %97 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract), !dbg !165
  %O_reg.sroa.12.18.insert.ext = zext i16 %97 to i64, !dbg !169
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !169
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !169
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2, !dbg !164
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract), !dbg !165
  %O_reg.sroa.12.20.insert.ext = zext i16 %98 to i64, !dbg !169
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !169
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !169
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3, !dbg !164
  %99 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract), !dbg !165
  %O_reg.sroa.12.22.insert.ext = zext i16 %99 to i64, !dbg !169
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !169
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !169
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0, !dbg !164
  %100 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract), !dbg !165
  %O_reg.sroa.17.24.insert.ext = zext i16 %100 to i64, !dbg !169
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1, !dbg !164
  %101 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract), !dbg !165
  %O_reg.sroa.17.26.insert.ext = zext i16 %101 to i64, !dbg !169
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !169
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !169
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2, !dbg !164
  %102 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract), !dbg !165
  %O_reg.sroa.17.28.insert.ext = zext i16 %102 to i64, !dbg !169
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !169
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !169
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3, !dbg !164
  %103 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract), !dbg !165
  %O_reg.sroa.17.30.insert.ext = zext i16 %103 to i64, !dbg !169
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !169
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !169
  fence syncscope("warp") release, !dbg !170
  tail call void @llvm.mxc.barrier.warp(), !dbg !173
  fence syncscope("warp") acquire, !dbg !174
  %and435 = shl nuw nsw i32 %3, 6
  %mul436 = and i32 %and435, 960
  %shr439 = lshr i32 %3, 5
  %and442 = and i32 %3, 7
  %104 = lshr i32 %3, 2
  %mul449 = and i32 %104, 4
  %xor443 = xor i32 %shr439, %and442, !dbg !175
  %mul444 = shl nuw nsw i32 %xor443, 3, !dbg !176
  %add445 = add nuw nsw i32 %mul444, %mul436, !dbg !177
  %add450 = or disjoint i32 %add445, %mul449, !dbg !178
  %add.ptr452 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add450, !dbg !179
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr452, align 8, !dbg !180
  %add440.1 = add nuw nsw i32 %shr439, 2, !dbg !181
  %xor443.1 = xor i32 %add440.1, %and442, !dbg !175
  %mul444.1 = shl nuw nsw i32 %xor443.1, 3, !dbg !176
  %add445.1 = add nuw nsw i32 %mul444.1, %mul436, !dbg !177
  %add450.1 = or disjoint i32 %add445.1, %mul449, !dbg !178
  %add.ptr452.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add450.1, !dbg !179
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr452.1, align 8, !dbg !180
  %add440.2 = add nuw nsw i32 %shr439, 4, !dbg !181
  %xor443.2 = xor i32 %add440.2, %and442, !dbg !175
  %mul444.2 = shl nuw nsw i32 %xor443.2, 3, !dbg !176
  %add445.2 = add nuw nsw i32 %mul444.2, %mul436, !dbg !177
  %add450.2 = or disjoint i32 %add445.2, %mul449, !dbg !178
  %add.ptr452.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add450.2, !dbg !179
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr452.2, align 8, !dbg !180
  %add440.3 = add nuw nsw i32 %shr439, 6, !dbg !181
  %xor443.3 = xor i32 %add440.3, %and442, !dbg !175
  %mul444.3 = shl nuw nsw i32 %xor443.3, 3, !dbg !176
  %add445.3 = add nuw nsw i32 %mul444.3, %mul436, !dbg !177
  %add450.3 = or disjoint i32 %add445.3, %mul449, !dbg !178
  %add.ptr452.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add450.3, !dbg !179
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr452.3, align 8, !dbg !180
  fence syncscope("warp") release, !dbg !182
  tail call void @llvm.mxc.barrier.warp(), !dbg !185
  fence syncscope("warp") acquire, !dbg !186
  %mul463 = and i32 %mul14, 8128
  %xor469586 = and i32 %mul14, 56
  %call467.masked = and i32 %3, 1016
  %mul470 = xor i32 %xor469586, %call467.masked
  %invariant.gep632 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul463, !dbg !187
  %invariant.gep634 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep632, i32 %mul470, !dbg !187
  %add.ptr490 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4, !dbg !188
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr490, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep634, i64 16, i1 false), !dbg !189, !tbaa.struct !190, !call_argsrelate !191
  %gep635.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep634, i32 1024, !dbg !192
  %add.ptr490.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %5, !dbg !188
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr490.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep635.1, i64 16, i1 false), !dbg !189, !tbaa.struct !190, !call_argsrelate !191
  ret void, !dbg !193
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
!1 = !DIFile(filename: "/tmp/tmp7ovvnekx/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmp7ovvnekx/tvm_kernels.maca", directory: "")
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
!96 = !DILocation(line: 84, column: 30, scope: !40)
!97 = !DILocation(line: 84, column: 41, scope: !40)
!98 = !DILocation(line: 354, column: 10, scope: !99, inlinedAt: !101)
!99 = distinct !DISubprogram(name: "min", scope: !100, file: !100, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!100 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!101 = distinct !DILocation(line: 84, column: 25, scope: !40)
!102 = !DILocation(line: 288, column: 10, scope: !103, inlinedAt: !104)
!103 = distinct !DISubprogram(name: "expf", scope: !100, file: !100, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!104 = distinct !DILocation(line: 84, column: 20, scope: !40)
!105 = !DILocation(line: 89, column: 34, scope: !40)
!106 = !DILocation(line: 1018, column: 9, scope: !107, inlinedAt: !108)
!107 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !65, file: !65, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!108 = distinct !DILocation(line: 91, column: 34, scope: !40)
!109 = !DILocation(line: 171, column: 37, scope: !110, inlinedAt: !111)
!110 = distinct !DISubprogram(name: "__lane_id", scope: !65, file: !65, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!111 = distinct !DILocation(line: 990, column: 14, scope: !112, inlinedAt: !113)
!112 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !65, file: !65, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!113 = distinct !DILocation(line: 1019, column: 11, scope: !107, inlinedAt: !108)
!114 = !DILocation(line: 171, column: 10, scope: !110, inlinedAt: !111)
!115 = !DILocation(line: 991, column: 20, scope: !112, inlinedAt: !113)
!116 = !DILocation(line: 992, column: 36, scope: !112, inlinedAt: !113)
!117 = !DILocation(line: 992, column: 17, scope: !112, inlinedAt: !113)
!118 = !DILocation(line: 992, column: 11, scope: !112, inlinedAt: !113)
!119 = !DILocation(line: 993, column: 43, scope: !112, inlinedAt: !113)
!120 = !DILocation(line: 993, column: 10, scope: !112, inlinedAt: !113)
!121 = !DILocation(line: 1020, column: 14, scope: !107, inlinedAt: !108)
!122 = !DILocation(line: 91, column: 32, scope: !40)
!123 = !DILocation(line: 1018, column: 9, scope: !107, inlinedAt: !124)
!124 = distinct !DILocation(line: 92, column: 34, scope: !40)
!125 = !DILocation(line: 171, column: 37, scope: !110, inlinedAt: !126)
!126 = distinct !DILocation(line: 990, column: 14, scope: !112, inlinedAt: !127)
!127 = distinct !DILocation(line: 1019, column: 11, scope: !107, inlinedAt: !124)
!128 = !DILocation(line: 171, column: 10, scope: !110, inlinedAt: !126)
!129 = !DILocation(line: 991, column: 20, scope: !112, inlinedAt: !127)
!130 = !DILocation(line: 992, column: 36, scope: !112, inlinedAt: !127)
!131 = !DILocation(line: 992, column: 17, scope: !112, inlinedAt: !127)
!132 = !DILocation(line: 992, column: 11, scope: !112, inlinedAt: !127)
!133 = !DILocation(line: 993, column: 43, scope: !112, inlinedAt: !127)
!134 = !DILocation(line: 993, column: 10, scope: !112, inlinedAt: !127)
!135 = !DILocation(line: 1020, column: 14, scope: !107, inlinedAt: !124)
!136 = !DILocation(line: 92, column: 32, scope: !40)
!137 = !DILocation(line: 94, column: 34, scope: !40)
!138 = !DILocation(line: 94, column: 9, scope: !40)
!139 = !DILocation(line: 102, column: 32, scope: !40)
!140 = !DILocation(line: 75, column: 10, scope: !141, inlinedAt: !143)
!141 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !142, file: !142, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!142 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!143 = distinct !DILocation(line: 984, column: 9, scope: !144, inlinedAt: !146)
!144 = distinct !DISubprogram(name: "__float2half", scope: !145, file: !145, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!145 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!146 = distinct !DILocation(line: 133, column: 53, scope: !147, inlinedAt: !148)
!147 = distinct !DISubprogram(name: "__half", scope: !145, file: !145, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!148 = distinct !DILocation(line: 106, column: 32, scope: !40)
!149 = !DILocation(line: 106, column: 29, scope: !40)
!150 = !DILocation(line: 68, column: 3, scope: !64, inlinedAt: !151)
!151 = distinct !DILocation(line: 192, column: 3, scope: !67, inlinedAt: !152)
!152 = distinct !DILocation(line: 108, column: 5, scope: !40)
!153 = !DILocation(line: 69, column: 3, scope: !64, inlinedAt: !151)
!154 = !DILocation(line: 70, column: 3, scope: !64, inlinedAt: !151)
!155 = !DILocation(line: 109, column: 3, scope: !40)
!156 = !DILocation(line: 115, column: 30, scope: !40)
!157 = !DILocation(line: 118, column: 119, scope: !40)
!158 = !DILocation(line: 118, column: 31, scope: !40)
!159 = !DILocation(line: 118, column: 29, scope: !40)
!160 = !{!26, !26, i64 0}
!161 = !DILocation(line: 123, column: 38, scope: !40)
!162 = !DILocation(line: 130, column: 3, scope: !40)
!163 = !DILocation(line: 0, scope: !40)
!164 = !DILocation(line: 133, column: 58, scope: !40)
!165 = !DILocation(line: 75, column: 10, scope: !141, inlinedAt: !166)
!166 = distinct !DILocation(line: 984, column: 9, scope: !144, inlinedAt: !167)
!167 = distinct !DILocation(line: 133, column: 53, scope: !147, inlinedAt: !168)
!168 = distinct !DILocation(line: 133, column: 50, scope: !40)
!169 = !DILocation(line: 133, column: 47, scope: !40)
!170 = !DILocation(line: 68, column: 3, scope: !64, inlinedAt: !171)
!171 = distinct !DILocation(line: 192, column: 3, scope: !67, inlinedAt: !172)
!172 = distinct !DILocation(line: 136, column: 3, scope: !40)
!173 = !DILocation(line: 69, column: 3, scope: !64, inlinedAt: !171)
!174 = !DILocation(line: 70, column: 3, scope: !64, inlinedAt: !171)
!175 = !DILocation(line: 139, column: 121, scope: !40)
!176 = !DILocation(line: 139, column: 149, scope: !40)
!177 = !DILocation(line: 139, column: 77, scope: !40)
!178 = !DILocation(line: 139, column: 155, scope: !40)
!179 = !DILocation(line: 139, column: 40, scope: !40)
!180 = !DILocation(line: 139, column: 198, scope: !40)
!181 = !DILocation(line: 139, column: 92, scope: !40)
!182 = !DILocation(line: 68, column: 3, scope: !64, inlinedAt: !183)
!183 = distinct !DILocation(line: 192, column: 3, scope: !67, inlinedAt: !184)
!184 = distinct !DILocation(line: 141, column: 3, scope: !40)
!185 = !DILocation(line: 69, column: 3, scope: !64, inlinedAt: !183)
!186 = !DILocation(line: 70, column: 3, scope: !64, inlinedAt: !183)
!187 = !DILocation(line: 143, column: 8, scope: !40)
!188 = !DILocation(line: 144, column: 22, scope: !40)
!189 = !DILocation(line: 144, column: 176, scope: !40)
!190 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!191 = !{i32 2, i32 -1, i32 -1, i32 -1}
!192 = !DILocation(line: 144, column: 213, scope: !40)
!193 = !DILocation(line: 146, column: 1, scope: !40)
