; ModuleID = 'experiments/20261009_goal8933/fp32_binary_audit/oj14_m1_p0.bc'
source_filename = "/tmp/tmpt7szmssf/tvm_kernels.maca"
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
  %arrayidx28 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %idxprom, !dbg !50
  %7 = load i32, ptr addrspace(1) %arrayidx28, align 4, !dbg !50, !tbaa !30
  %cmp43 = icmp ugt i32 %7, 31
  %shr46 = lshr i32 %2, 4
  %cmp47.not = icmp ugt i32 %7, %shr46
  %or.cond669 = or i1 %cmp43, %cmp47.not, !dbg !51
  br i1 %or.cond669, label %if.end362, label %if.then, !dbg !51

if.then:                                          ; preds = %entry
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %5, !dbg !52
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4, !dbg !52
  %8 = shl nuw nsw i32 %0, 15
  %mul61 = and i32 %8, 2147418112
  %mul62 = shl nuw nsw i32 %7, 11
  %9 = shl nuw nsw i32 %3, 4
  %mul68 = and i32 %9, 16256
  %and71 = shl i32 %0, 6
  %mul72 = and i32 %and71, 64
  %mul76 = and i32 %mul14, 56
  %add63 = or disjoint i32 %mul68, %mul61
  %add65 = or disjoint i32 %add63, %mul72
  %add69 = or disjoint i32 %add65, %mul76
  %add73 = add nuw nsw i32 %add69, %mul62
  %10 = zext nneg i32 %add73 to i64, !dbg !53
  %add.ptr81 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %10, !dbg !54
  %11 = load i32, ptr addrspace(4) %add.ptr81, align 4, !dbg !55, !tbaa !30
  %12 = or disjoint i64 %10, 2, !dbg !56
  %add.ptr81.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %12, !dbg !54
  %13 = load i32, ptr addrspace(4) %add.ptr81.1, align 4, !dbg !55, !tbaa !30
  %14 = or disjoint i64 %10, 4, !dbg !56
  %add.ptr81.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %14, !dbg !54
  %15 = load i32, ptr addrspace(4) %add.ptr81.2, align 4, !dbg !55, !tbaa !30
  %16 = or disjoint i64 %10, 6, !dbg !56
  %add.ptr81.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %16, !dbg !54
  %17 = load i32, ptr addrspace(4) %add.ptr81.3, align 4, !dbg !55, !tbaa !30
  %18 = add nuw nsw i64 %10, 1024
  %add.ptr81.1687 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %18, !dbg !54
  %19 = load i32, ptr addrspace(4) %add.ptr81.1687, align 4, !dbg !55, !tbaa !30
  %20 = add nuw nsw i64 %10, 1026, !dbg !56
  %add.ptr81.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %20, !dbg !54
  %21 = load i32, ptr addrspace(4) %add.ptr81.1.1, align 4, !dbg !55, !tbaa !30
  %22 = add nuw nsw i64 %10, 1028, !dbg !56
  %add.ptr81.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %22, !dbg !54
  %23 = load i32, ptr addrspace(4) %add.ptr81.2.1, align 4, !dbg !55, !tbaa !30
  %24 = add nuw nsw i64 %10, 1030, !dbg !56
  %add.ptr81.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %24, !dbg !54
  %25 = load i32, ptr addrspace(4) %add.ptr81.3.1, align 4, !dbg !55, !tbaa !30
  %add.ptr124 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %10, !dbg !57
  %26 = load i32, ptr addrspace(4) %add.ptr124, align 4, !dbg !58, !tbaa !30
  %add.ptr124.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %12, !dbg !57
  %27 = load i32, ptr addrspace(4) %add.ptr124.1, align 4, !dbg !58, !tbaa !30
  %add.ptr124.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %14, !dbg !57
  %28 = load i32, ptr addrspace(4) %add.ptr124.2, align 4, !dbg !58, !tbaa !30
  %add.ptr124.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %16, !dbg !57
  %29 = load i32, ptr addrspace(4) %add.ptr124.3, align 4, !dbg !58, !tbaa !30
  %add.ptr124.1699 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %18, !dbg !57
  %30 = load i32, ptr addrspace(4) %add.ptr124.1699, align 4, !dbg !58, !tbaa !30
  %add.ptr124.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %20, !dbg !57
  %31 = load i32, ptr addrspace(4) %add.ptr124.1.1, align 4, !dbg !58, !tbaa !30
  %add.ptr124.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %22, !dbg !57
  %32 = load i32, ptr addrspace(4) %add.ptr124.2.1, align 4, !dbg !58, !tbaa !30
  %add.ptr124.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %24, !dbg !57
  %33 = load i32, ptr addrspace(4) %add.ptr124.3.1, align 4, !dbg !58, !tbaa !30
  %mul148 = and i32 %mul14, 8128
  %call152.masked = and i32 %3, 1016
  %mul154 = xor i32 %mul76, %call152.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul148, !dbg !59
  %invariant.gep637 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul154, !dbg !59
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep637, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !dbg !60, !call_argsrelate !61
  %gep638.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep637, i32 1024, !dbg !62
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep638.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !dbg !60, !call_argsrelate !61
  fence syncscope("warp") release, !dbg !63
  tail call void @llvm.mxc.barrier.warp(), !dbg !69
  fence syncscope("warp") acquire, !dbg !70
  %and166 = shl nuw nsw i32 %3, 6
  %mul167 = and i32 %and166, 960
  %shr170 = lshr i32 %3, 4
  %and173 = and i32 %3, 7
  %34 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul167
  %xor174 = xor i32 %shr170, %and173, !dbg !71
  %add.ptr178.idx = shl nuw nsw i32 %xor174, 4, !dbg !72
  %add.ptr178 = getelementptr inbounds i8, ptr addrspace(3) %34, i32 %add.ptr178.idx, !dbg !72
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr178, align 16, !dbg !73
  %Q_reg.sroa.4.0.add.ptr178.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr178, i32 8, !dbg !73
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr178.sroa_idx, align 8, !dbg !73
  %add171.1 = add nuw nsw i32 %shr170, 4, !dbg !74
  %xor174.1 = xor i32 %add171.1, %and173, !dbg !71
  %add.ptr178.idx.1 = shl nuw nsw i32 %xor174.1, 4, !dbg !72
  %add.ptr178.1 = getelementptr inbounds i8, ptr addrspace(3) %34, i32 %add.ptr178.idx.1, !dbg !72
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr178.1, align 16, !dbg !73
  %Q_reg.sroa.7.16.add.ptr178.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr178.1, i32 8, !dbg !73
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr178.1.sroa_idx, align 8, !dbg !73
  fence syncscope("warp") release, !dbg !75
  tail call void @llvm.mxc.barrier.warp(), !dbg !78
  fence syncscope("warp") acquire, !dbg !79
  store i32 %11, ptr addrspace(3) %invariant.gep637, align 16, !dbg !80, !tbaa !30
  %K_reg.sroa.4.0.invariant.gep642.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep637, i32 4, !dbg !80
  store i32 %13, ptr addrspace(3) %K_reg.sroa.4.0.invariant.gep642.sroa_idx, align 4, !dbg !80, !tbaa !30
  %K_reg.sroa.5.0.invariant.gep642.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep637, i32 8, !dbg !80
  store i32 %15, ptr addrspace(3) %K_reg.sroa.5.0.invariant.gep642.sroa_idx, align 8, !dbg !80, !tbaa !30
  %K_reg.sroa.6.0.invariant.gep642.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep637, i32 12, !dbg !80
  store i32 %17, ptr addrspace(3) %K_reg.sroa.6.0.invariant.gep642.sroa_idx, align 4, !dbg !80, !tbaa !30
  store i32 %19, ptr addrspace(3) %gep638.1, align 16, !dbg !80, !tbaa !30
  %K_reg.sroa.9.16.gep643.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep637, i32 1028, !dbg !80
  store i32 %21, ptr addrspace(3) %K_reg.sroa.9.16.gep643.1.sroa_idx, align 4, !dbg !80, !tbaa !30
  %K_reg.sroa.10.16.gep643.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep637, i32 1032, !dbg !80
  store i32 %23, ptr addrspace(3) %K_reg.sroa.10.16.gep643.1.sroa_idx, align 8, !dbg !80, !tbaa !30
  %K_reg.sroa.11.16.gep643.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep637, i32 1036, !dbg !80
  store i32 %25, ptr addrspace(3) %K_reg.sroa.11.16.gep643.1.sroa_idx, align 4, !dbg !80, !tbaa !30
  fence syncscope("warp") release, !dbg !81
  tail call void @llvm.mxc.barrier.warp(), !dbg !84
  fence syncscope("warp") acquire, !dbg !85
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr178, align 16, !dbg !86
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr178.sroa_idx, align 8, !dbg !86
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !87
  %36 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %35), !dbg !87
  %kb.sroa.0.0.copyload729 = load <4 x half>, ptr addrspace(3) %add.ptr178.1, align 16, !dbg !86
  %kb.sroa.6.0.copyload730 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr178.1.sroa_idx, align 8, !dbg !86
  %37 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload729, <4 x half> %Q_reg.sroa.5.16.copyload, <4 x float> %36), !dbg !87
  %38 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload730, <4 x half> %Q_reg.sroa.7.16.copyload, <4 x float> %37), !dbg !87
  fence syncscope("warp") release, !dbg !88
  tail call void @llvm.mxc.barrier.warp(), !dbg !91
  fence syncscope("warp") acquire, !dbg !92
  %invariant.gep650 = getelementptr inbounds i8, ptr addrspace(3) @buf_dyn_shmem, i32 %9, !dbg !93
  store i32 %26, ptr addrspace(3) %invariant.gep650, align 16, !dbg !94, !tbaa !30
  %V_reg.sroa.4.0.invariant.gep650.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep650, i32 4, !dbg !94
  store i32 %27, ptr addrspace(3) %V_reg.sroa.4.0.invariant.gep650.sroa_idx, align 4, !dbg !94, !tbaa !30
  %V_reg.sroa.5.0.invariant.gep650.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep650, i32 8, !dbg !94
  store i32 %28, ptr addrspace(3) %V_reg.sroa.5.0.invariant.gep650.sroa_idx, align 8, !dbg !94, !tbaa !30
  %V_reg.sroa.6.0.invariant.gep650.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep650, i32 12, !dbg !94
  store i32 %29, ptr addrspace(3) %V_reg.sroa.6.0.invariant.gep650.sroa_idx, align 4, !dbg !94, !tbaa !30
  %gep.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep650, i32 1024, !dbg !95
  store i32 %30, ptr addrspace(3) %gep.1, align 16, !dbg !94, !tbaa !30
  %V_reg.sroa.9.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep650, i32 1028, !dbg !94
  store i32 %31, ptr addrspace(3) %V_reg.sroa.9.16.gep.1.sroa_idx, align 4, !dbg !94, !tbaa !30
  %V_reg.sroa.10.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep650, i32 1032, !dbg !94
  store i32 %32, ptr addrspace(3) %V_reg.sroa.10.16.gep.1.sroa_idx, align 8, !dbg !94, !tbaa !30
  %V_reg.sroa.11.16.gep.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep650, i32 1036, !dbg !94
  store i32 %33, ptr addrspace(3) %V_reg.sroa.11.16.gep.1.sroa_idx, align 4, !dbg !94, !tbaa !30
  %mul48 = shl nuw nsw i32 %7, 4, !dbg !96
  %shr282 = shl nuw nsw i32 %7, 2
  %add283 = add nuw nsw i32 %shr282, %shr170
  %cmp284 = icmp ugt i32 %add283, 127
  %39 = lshr i32 %3, 2
  %mul288 = and i32 %39, 252
  %add290 = add nuw nsw i32 %mul48, %mul288
  %cmp293.not = icmp ugt i32 %add290, %2
  %or.cond670 = select i1 %cmp284, i1 true, i1 %cmp293.not, !dbg !97
  br i1 %or.cond670, label %if.end, label %if.then294, !dbg !97

if.then294:                                       ; preds = %if.then
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %38, i64 0, !dbg !98
  %mul297 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !99
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul297, float 0x4024CB5EC0000000), !dbg !100
  %41 = tail call contract noundef float @llvm.exp.f32(float %40), !dbg !104
  br label %if.end, !dbg !107

if.end:                                           ; preds = %if.then, %if.then294
  %condval.0 = phi float [ %41, %if.then294 ], [ 0.000000e+00, %if.then ], !dbg !108
  %cmp293.not.1 = icmp uge i32 %add290, %2
  %or.cond670.1 = select i1 %cmp284, i1 true, i1 %cmp293.not.1, !dbg !97
  br i1 %or.cond670.1, label %if.end.1, label %if.then294.1, !dbg !97

if.then294.1:                                     ; preds = %if.end
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %38, i64 1, !dbg !98
  %mul297.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !99
  %42 = tail call contract noundef float @llvm.minnum.f32(float %mul297.1, float 0x4024CB5EC0000000), !dbg !100
  %43 = tail call contract noundef float @llvm.exp.f32(float %42), !dbg !104
  br label %if.end.1, !dbg !107

if.end.1:                                         ; preds = %if.then294.1, %if.end
  %condval.0.1 = phi float [ %43, %if.then294.1 ], [ 0.000000e+00, %if.end ], !dbg !108
  %add291.2 = or disjoint i32 %add290, 2
  %cmp293.not.2 = icmp ugt i32 %add291.2, %2
  %or.cond670.2 = select i1 %cmp284, i1 true, i1 %cmp293.not.2, !dbg !97
  br i1 %or.cond670.2, label %if.end.2, label %if.then294.2, !dbg !97

if.then294.2:                                     ; preds = %if.end.1
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %38, i64 2, !dbg !98
  %mul297.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !99
  %44 = tail call contract noundef float @llvm.minnum.f32(float %mul297.2, float 0x4024CB5EC0000000), !dbg !100
  %45 = tail call contract noundef float @llvm.exp.f32(float %44), !dbg !104
  br label %if.end.2, !dbg !107

if.end.2:                                         ; preds = %if.then294.2, %if.end.1
  %condval.0.2 = phi float [ %45, %if.then294.2 ], [ 0.000000e+00, %if.end.1 ], !dbg !108
  %add291.3 = or disjoint i32 %add290, 3
  %cmp293.not.3 = icmp ugt i32 %add291.3, %2
  %or.cond670.3 = select i1 %cmp284, i1 true, i1 %cmp293.not.3, !dbg !97
  br i1 %or.cond670.3, label %if.end.3, label %if.then294.3, !dbg !97

if.then294.3:                                     ; preds = %if.end.2
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %38, i64 3, !dbg !98
  %mul297.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !99
  %46 = tail call contract noundef float @llvm.minnum.f32(float %mul297.3, float 0x4024CB5EC0000000), !dbg !100
  %47 = tail call contract noundef float @llvm.exp.f32(float %46), !dbg !104
  br label %if.end.3, !dbg !107

if.end.3:                                         ; preds = %if.then294.3, %if.end.2
  %condval.0.3 = phi float [ %47, %if.then294.3 ], [ 0.000000e+00, %if.end.2 ], !dbg !108
  %add313.1 = fadd contract float %condval.0, %condval.0.1, !dbg !109
  %add313.2 = fadd contract float %add313.1, %condval.0.2, !dbg !109
  %add313.3 = fadd contract float %add313.2, %condval.0.3, !dbg !109
  %48 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x4f32(float 1.000000e+00, float %add313.3, <4 x float> zeroinitializer), !dbg !110
  %wsum_output.sroa.0.0.vec.extract = extractelement <4 x float> %48, i64 0, !dbg !111
  %cmp331 = fcmp contract ogt float %wsum_output.sroa.0.0.vec.extract, 0.000000e+00, !dbg !112
  %div = fdiv contract float 1.000000e+00, %wsum_output.sroa.0.0.vec.extract, !dbg !113
  %condval_1.0 = select i1 %cmp331, float %div, float 0.000000e+00, !dbg !113
  %mul344 = fmul contract float %condval_1.0, %condval.0, !dbg !114
  %mul344.1 = fmul contract float %condval_1.0, %condval.0.1, !dbg !114
  %mul344.2 = fmul contract float %condval_1.0, %condval.0.2, !dbg !114
  %mul344.3 = fmul contract float %condval_1.0, %condval.0.3, !dbg !114
  %49 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul344), !dbg !115
  %50 = insertelement <4 x i16> poison, i16 %49, i64 0, !dbg !124
  %51 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul344.1), !dbg !115
  %52 = insertelement <4 x i16> %50, i16 %51, i64 1, !dbg !124
  %53 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul344.2), !dbg !115
  %54 = insertelement <4 x i16> %52, i16 %53, i64 2, !dbg !124
  %55 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul344.3), !dbg !115
  %56 = insertelement <4 x i16> %54, i16 %55, i64 3, !dbg !124
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %56 to <4 x half>, !dbg !124
  fence syncscope("warp") release, !dbg !125
  tail call void @llvm.mxc.barrier.warp(), !dbg !128
  fence syncscope("warp") acquire, !dbg !129
  br label %if.end362, !dbg !130

if.end362:                                        ; preds = %if.end.3, %entry
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ undef, %entry ], [ %acc_s_cast.sroa.0.6.vec.insert, %if.end.3 ]
  br i1 %or.cond669, label %if.end432, label %for.cond384.preheader, !dbg !131

for.cond384.preheader:                            ; preds = %if.end362
  %57 = shl nuw nsw i32 %3, 4
  %mul394 = and i32 %57, 16128
  %and400 = and i32 %3, 15
  %add401 = or disjoint i32 %mul394, %and400, !dbg !132
  %arrayidx403 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401, !dbg !133
  %58 = load half, ptr addrspace(3) %arrayidx403, align 2, !dbg !134, !tbaa !135
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %58, i64 0, !dbg !134
  %add396.1 = or disjoint i32 %mul394, %and400, !dbg !132
  %add401.1 = or disjoint i32 %add396.1, 64, !dbg !132
  %arrayidx403.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401.1, !dbg !133
  %59 = load half, ptr addrspace(3) %arrayidx403.1, align 2, !dbg !134, !tbaa !135
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %59, i64 1, !dbg !134
  %add396.2 = or disjoint i32 %mul394, %and400, !dbg !132
  %add401.2 = or disjoint i32 %add396.2, 128, !dbg !132
  %arrayidx403.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401.2, !dbg !133
  %60 = load half, ptr addrspace(3) %arrayidx403.2, align 2, !dbg !134, !tbaa !135
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %60, i64 2, !dbg !134
  %add396.3 = or disjoint i32 %mul394, %and400, !dbg !132
  %add401.3 = or disjoint i32 %add396.3, 192, !dbg !132
  %arrayidx403.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401.3, !dbg !133
  %61 = load half, ptr addrspace(3) %arrayidx403.3, align 2, !dbg !134, !tbaa !135
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %61, i64 3, !dbg !134
  %add398.1703 = or disjoint i32 %mul394, %and400, !dbg !132
  %add401.1704 = or disjoint i32 %add398.1703, 16, !dbg !132
  %arrayidx403.1705 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401.1704, !dbg !133
  %62 = load half, ptr addrspace(3) %arrayidx403.1705, align 2, !dbg !134, !tbaa !135
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %62, i64 0, !dbg !134
  %add398.1.1 = or disjoint i32 %mul394, %and400, !dbg !132
  %add401.1.1 = or disjoint i32 %add398.1.1, 80, !dbg !132
  %arrayidx403.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401.1.1, !dbg !133
  %63 = load half, ptr addrspace(3) %arrayidx403.1.1, align 2, !dbg !134, !tbaa !135
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %63, i64 1, !dbg !134
  %add398.2.1 = or disjoint i32 %mul394, %and400, !dbg !132
  %add401.2.1 = or disjoint i32 %add398.2.1, 144, !dbg !132
  %arrayidx403.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401.2.1, !dbg !133
  %64 = load half, ptr addrspace(3) %arrayidx403.2.1, align 2, !dbg !134, !tbaa !135
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %64, i64 2, !dbg !134
  %add398.3.1 = or disjoint i32 %mul394, %and400, !dbg !132
  %add401.3.1 = or disjoint i32 %add398.3.1, 208, !dbg !132
  %arrayidx403.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401.3.1, !dbg !133
  %65 = load half, ptr addrspace(3) %arrayidx403.3.1, align 2, !dbg !134, !tbaa !135
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %65, i64 3, !dbg !134
  %add398.2707 = or disjoint i32 %mul394, %and400, !dbg !132
  %add401.2708 = or disjoint i32 %add398.2707, 32, !dbg !132
  %arrayidx403.2709 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401.2708, !dbg !133
  %66 = load half, ptr addrspace(3) %arrayidx403.2709, align 2, !dbg !134, !tbaa !135
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %66, i64 0, !dbg !134
  %add398.1.2 = or disjoint i32 %mul394, %and400, !dbg !132
  %add401.1.2 = or disjoint i32 %add398.1.2, 96, !dbg !132
  %arrayidx403.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401.1.2, !dbg !133
  %67 = load half, ptr addrspace(3) %arrayidx403.1.2, align 2, !dbg !134, !tbaa !135
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %67, i64 1, !dbg !134
  %add398.2.2 = or disjoint i32 %mul394, %and400, !dbg !132
  %add401.2.2 = or disjoint i32 %add398.2.2, 160, !dbg !132
  %arrayidx403.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401.2.2, !dbg !133
  %68 = load half, ptr addrspace(3) %arrayidx403.2.2, align 2, !dbg !134, !tbaa !135
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %68, i64 2, !dbg !134
  %add398.3.2 = or disjoint i32 %mul394, %and400, !dbg !132
  %add401.3.2 = or disjoint i32 %add398.3.2, 224, !dbg !132
  %arrayidx403.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401.3.2, !dbg !133
  %69 = load half, ptr addrspace(3) %arrayidx403.3.2, align 2, !dbg !134, !tbaa !135
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %69, i64 3, !dbg !134
  %add398.3711 = or disjoint i32 %mul394, %and400, !dbg !132
  %add401.3712 = or disjoint i32 %add398.3711, 48, !dbg !132
  %arrayidx403.3713 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401.3712, !dbg !133
  %70 = load half, ptr addrspace(3) %arrayidx403.3713, align 2, !dbg !134, !tbaa !135
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %70, i64 0, !dbg !134
  %add398.1.3 = or disjoint i32 %mul394, %and400, !dbg !132
  %add401.1.3 = or disjoint i32 %add398.1.3, 112, !dbg !132
  %arrayidx403.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401.1.3, !dbg !133
  %71 = load half, ptr addrspace(3) %arrayidx403.1.3, align 2, !dbg !134, !tbaa !135
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %71, i64 1, !dbg !134
  %add398.2.3 = or disjoint i32 %mul394, %and400, !dbg !132
  %add401.2.3 = or disjoint i32 %add398.2.3, 176, !dbg !132
  %arrayidx403.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401.2.3, !dbg !133
  %72 = load half, ptr addrspace(3) %arrayidx403.2.3, align 2, !dbg !134, !tbaa !135
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %72, i64 2, !dbg !134
  %add398.3.3 = or disjoint i32 %57, %and400, !dbg !132
  %add401.3.3 = or i32 %add398.3.3, 240, !dbg !132
  %arrayidx403.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add401.3.3, !dbg !133
  %73 = load half, ptr addrspace(3) %arrayidx403.3.3, align 2, !dbg !134, !tbaa !135
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %73, i64 3, !dbg !134
  %74 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !136
  %75 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !136
  %76 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !136
  %77 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !136
  br label %if.end432, !dbg !137

if.end432:                                        ; preds = %for.cond384.preheader, %if.end362
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end362 ], [ %74, %for.cond384.preheader ], !dbg !108
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end362 ], [ %75, %for.cond384.preheader ], !dbg !108
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end362 ], [ %76, %for.cond384.preheader ], !dbg !108
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end362 ], [ %77, %for.cond384.preheader ], !dbg !108
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0, !dbg !138
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract), !dbg !139
  %O_reg.sroa.0.0.insert.ext = zext i16 %78 to i64, !dbg !143
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1, !dbg !138
  %79 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract), !dbg !139
  %O_reg.sroa.0.2.insert.ext = zext i16 %79 to i64, !dbg !143
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !143
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !143
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2, !dbg !138
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract), !dbg !139
  %O_reg.sroa.0.4.insert.ext = zext i16 %80 to i64, !dbg !143
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !143
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !143
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3, !dbg !138
  %81 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract), !dbg !139
  %O_reg.sroa.0.6.insert.ext = zext i16 %81 to i64, !dbg !143
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !143
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !143
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0, !dbg !138
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract), !dbg !139
  %O_reg.sroa.7.8.insert.ext = zext i16 %82 to i64, !dbg !143
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1, !dbg !138
  %83 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract), !dbg !139
  %O_reg.sroa.7.10.insert.ext = zext i16 %83 to i64, !dbg !143
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !143
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !143
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2, !dbg !138
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract), !dbg !139
  %O_reg.sroa.7.12.insert.ext = zext i16 %84 to i64, !dbg !143
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !143
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !143
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3, !dbg !138
  %85 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract), !dbg !139
  %O_reg.sroa.7.14.insert.ext = zext i16 %85 to i64, !dbg !143
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !143
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !143
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0, !dbg !138
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract), !dbg !139
  %O_reg.sroa.12.16.insert.ext = zext i16 %86 to i64, !dbg !143
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1, !dbg !138
  %87 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract), !dbg !139
  %O_reg.sroa.12.18.insert.ext = zext i16 %87 to i64, !dbg !143
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !143
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !143
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2, !dbg !138
  %88 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract), !dbg !139
  %O_reg.sroa.12.20.insert.ext = zext i16 %88 to i64, !dbg !143
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !143
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !143
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3, !dbg !138
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract), !dbg !139
  %O_reg.sroa.12.22.insert.ext = zext i16 %89 to i64, !dbg !143
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !143
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !143
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0, !dbg !138
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract), !dbg !139
  %O_reg.sroa.17.24.insert.ext = zext i16 %90 to i64, !dbg !143
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1, !dbg !138
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract), !dbg !139
  %O_reg.sroa.17.26.insert.ext = zext i16 %91 to i64, !dbg !143
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !143
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !143
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2, !dbg !138
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract), !dbg !139
  %O_reg.sroa.17.28.insert.ext = zext i16 %92 to i64, !dbg !143
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !143
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !143
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3, !dbg !138
  %93 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract), !dbg !139
  %O_reg.sroa.17.30.insert.ext = zext i16 %93 to i64, !dbg !143
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !143
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !143
  fence syncscope("warp") release, !dbg !144
  tail call void @llvm.mxc.barrier.warp(), !dbg !147
  fence syncscope("warp") acquire, !dbg !148
  %and465 = shl nuw nsw i32 %3, 6
  %mul466 = and i32 %and465, 960
  %shr469 = lshr i32 %3, 5
  %and472 = and i32 %3, 7
  %94 = lshr i32 %3, 2
  %mul479 = and i32 %94, 4
  %xor473 = xor i32 %shr469, %and472, !dbg !149
  %mul474 = shl nuw nsw i32 %xor473, 3, !dbg !150
  %add475 = add nuw nsw i32 %mul474, %mul466, !dbg !151
  %add480 = or disjoint i32 %add475, %mul479, !dbg !152
  %add.ptr482 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add480, !dbg !153
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr482, align 8, !dbg !154
  %add470.1 = add nuw nsw i32 %shr469, 2, !dbg !155
  %xor473.1 = xor i32 %add470.1, %and472, !dbg !149
  %mul474.1 = shl nuw nsw i32 %xor473.1, 3, !dbg !150
  %add475.1 = add nuw nsw i32 %mul474.1, %mul466, !dbg !151
  %add480.1 = or disjoint i32 %add475.1, %mul479, !dbg !152
  %add.ptr482.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add480.1, !dbg !153
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr482.1, align 8, !dbg !154
  %add470.2 = add nuw nsw i32 %shr469, 4, !dbg !155
  %xor473.2 = xor i32 %add470.2, %and472, !dbg !149
  %mul474.2 = shl nuw nsw i32 %xor473.2, 3, !dbg !150
  %add475.2 = add nuw nsw i32 %mul474.2, %mul466, !dbg !151
  %add480.2 = or disjoint i32 %add475.2, %mul479, !dbg !152
  %add.ptr482.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add480.2, !dbg !153
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr482.2, align 8, !dbg !154
  %add470.3 = add nuw nsw i32 %shr469, 6, !dbg !155
  %xor473.3 = xor i32 %add470.3, %and472, !dbg !149
  %mul474.3 = shl nuw nsw i32 %xor473.3, 3, !dbg !150
  %add475.3 = add nuw nsw i32 %mul474.3, %mul466, !dbg !151
  %add480.3 = or disjoint i32 %add475.3, %mul479, !dbg !152
  %add.ptr482.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add480.3, !dbg !153
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr482.3, align 8, !dbg !154
  fence syncscope("warp") release, !dbg !156
  tail call void @llvm.mxc.barrier.warp(), !dbg !159
  fence syncscope("warp") acquire, !dbg !160
  %mul493 = and i32 %mul14, 8128
  %xor499623 = and i32 %mul14, 56
  %call497.masked = and i32 %3, 1016
  %mul500 = xor i32 %xor499623, %call497.masked
  %invariant.gep664 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul493, !dbg !161
  %invariant.gep666 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep664, i32 %mul500, !dbg !161
  %add.ptr520 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4, !dbg !162
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr520, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep666, i64 16, i1 false), !dbg !163, !tbaa.struct !164, !call_argsrelate !165
  %gep667.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep666, i32 1024, !dbg !166
  %add.ptr520.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %5, !dbg !162
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr520.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep667.1, i64 16, i1 false), !dbg !163, !tbaa.struct !164, !call_argsrelate !165
  ret void, !dbg !167
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
!1 = !DIFile(filename: "/tmp/tmpt7szmssf/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpt7szmssf/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 28, column: 3, scope: !40)
!44 = !DILocation(line: 29, column: 170, scope: !40)
!45 = !DILocation(line: 31, column: 66, scope: !40)
!46 = !DILocation(line: 31, column: 95, scope: !40)
!47 = !DILocation(line: 31, column: 74, scope: !40)
!48 = !DILocation(line: 31, column: 122, scope: !40)
!49 = !DILocation(line: 31, column: 101, scope: !40)
!50 = !DILocation(line: 31, column: 25, scope: !40)
!51 = !DILocation(line: 37, column: 31, scope: !40)
!52 = !DILocation(line: 29, column: 48, scope: !40)
!53 = !DILocation(line: 40, column: 5, scope: !40)
!54 = !DILocation(line: 43, column: 79, scope: !40)
!55 = !DILocation(line: 43, column: 58, scope: !40)
!56 = !DILocation(line: 43, column: 274, scope: !40)
!57 = !DILocation(line: 50, column: 79, scope: !40)
!58 = !DILocation(line: 50, column: 58, scope: !40)
!59 = !DILocation(line: 54, column: 5, scope: !40)
!60 = !DILocation(line: 55, column: 159, scope: !40)
!61 = !{i32 1, i32 3, i32 -1, i32 -1}
!62 = !DILocation(line: 55, column: 42, scope: !40)
!63 = !DILocation(line: 68, column: 3, scope: !64, inlinedAt: !66)
!64 = distinct !DISubprogram(name: "__barrier_warp", scope: !65, file: !65, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!65 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!66 = distinct !DILocation(line: 192, column: 3, scope: !67, inlinedAt: !68)
!67 = distinct !DISubprogram(name: "__syncwarp", scope: !65, file: !65, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!68 = distinct !DILocation(line: 57, column: 5, scope: !40)
!69 = !DILocation(line: 69, column: 3, scope: !64, inlinedAt: !66)
!70 = !DILocation(line: 70, column: 3, scope: !64, inlinedAt: !66)
!71 = !DILocation(line: 60, column: 153, scope: !40)
!72 = !DILocation(line: 60, column: 73, scope: !40)
!73 = !DILocation(line: 60, column: 36, scope: !40)
!74 = !DILocation(line: 60, column: 124, scope: !40)
!75 = !DILocation(line: 68, column: 3, scope: !64, inlinedAt: !76)
!76 = distinct !DILocation(line: 192, column: 3, scope: !67, inlinedAt: !77)
!77 = distinct !DILocation(line: 62, column: 5, scope: !40)
!78 = !DILocation(line: 69, column: 3, scope: !64, inlinedAt: !76)
!79 = !DILocation(line: 70, column: 3, scope: !64, inlinedAt: !76)
!80 = !DILocation(line: 65, column: 159, scope: !40)
!81 = !DILocation(line: 68, column: 3, scope: !64, inlinedAt: !82)
!82 = distinct !DILocation(line: 192, column: 3, scope: !67, inlinedAt: !83)
!83 = distinct !DILocation(line: 69, column: 5, scope: !40)
!84 = !DILocation(line: 69, column: 3, scope: !64, inlinedAt: !82)
!85 = !DILocation(line: 70, column: 3, scope: !64, inlinedAt: !82)
!86 = !DILocation(line: 71, column: 25, scope: !40)
!87 = !DILocation(line: 74, column: 36, scope: !40)
!88 = !DILocation(line: 68, column: 3, scope: !64, inlinedAt: !89)
!89 = distinct !DILocation(line: 192, column: 3, scope: !67, inlinedAt: !90)
!90 = distinct !DILocation(line: 80, column: 5, scope: !40)
!91 = !DILocation(line: 69, column: 3, scope: !64, inlinedAt: !89)
!92 = !DILocation(line: 70, column: 3, scope: !64, inlinedAt: !89)
!93 = !DILocation(line: 82, column: 10, scope: !40)
!94 = !DILocation(line: 83, column: 86, scope: !40)
!95 = !DILocation(line: 83, column: 42, scope: !40)
!96 = !DILocation(line: 38, column: 43, scope: !40)
!97 = !DILocation(line: 88, column: 84, scope: !40)
!98 = !DILocation(line: 89, column: 29, scope: !40)
!99 = !DILocation(line: 89, column: 40, scope: !40)
!100 = !DILocation(line: 354, column: 10, scope: !101, inlinedAt: !103)
!101 = distinct !DISubprogram(name: "min", scope: !102, file: !102, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!102 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!103 = distinct !DILocation(line: 89, column: 24, scope: !40)
!104 = !DILocation(line: 288, column: 10, scope: !105, inlinedAt: !106)
!105 = distinct !DISubprogram(name: "expf", scope: !102, file: !102, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!106 = distinct !DILocation(line: 89, column: 19, scope: !40)
!107 = !DILocation(line: 90, column: 7, scope: !40)
!108 = !DILocation(line: 0, scope: !40)
!109 = !DILocation(line: 98, column: 34, scope: !40)
!110 = !DILocation(line: 103, column: 42, scope: !40)
!111 = !DILocation(line: 108, column: 36, scope: !40)
!112 = !DILocation(line: 108, column: 34, scope: !40)
!113 = !DILocation(line: 108, column: 9, scope: !40)
!114 = !DILocation(line: 116, column: 32, scope: !40)
!115 = !DILocation(line: 75, column: 10, scope: !116, inlinedAt: !118)
!116 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !117, file: !117, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!117 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!118 = distinct !DILocation(line: 984, column: 9, scope: !119, inlinedAt: !121)
!119 = distinct !DISubprogram(name: "__float2half", scope: !120, file: !120, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!120 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!121 = distinct !DILocation(line: 133, column: 53, scope: !122, inlinedAt: !123)
!122 = distinct !DISubprogram(name: "__half", scope: !120, file: !120, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!123 = distinct !DILocation(line: 120, column: 32, scope: !40)
!124 = !DILocation(line: 120, column: 29, scope: !40)
!125 = !DILocation(line: 68, column: 3, scope: !64, inlinedAt: !126)
!126 = distinct !DILocation(line: 192, column: 3, scope: !67, inlinedAt: !127)
!127 = distinct !DILocation(line: 122, column: 5, scope: !40)
!128 = !DILocation(line: 69, column: 3, scope: !64, inlinedAt: !126)
!129 = !DILocation(line: 70, column: 3, scope: !64, inlinedAt: !126)
!130 = !DILocation(line: 123, column: 3, scope: !40)
!131 = !DILocation(line: 129, column: 31, scope: !40)
!132 = !DILocation(line: 132, column: 119, scope: !40)
!133 = !DILocation(line: 132, column: 31, scope: !40)
!134 = !DILocation(line: 132, column: 29, scope: !40)
!135 = !{!26, !26, i64 0}
!136 = !DILocation(line: 137, column: 38, scope: !40)
!137 = !DILocation(line: 144, column: 3, scope: !40)
!138 = !DILocation(line: 147, column: 58, scope: !40)
!139 = !DILocation(line: 75, column: 10, scope: !116, inlinedAt: !140)
!140 = distinct !DILocation(line: 984, column: 9, scope: !119, inlinedAt: !141)
!141 = distinct !DILocation(line: 133, column: 53, scope: !122, inlinedAt: !142)
!142 = distinct !DILocation(line: 147, column: 50, scope: !40)
!143 = !DILocation(line: 147, column: 47, scope: !40)
!144 = !DILocation(line: 68, column: 3, scope: !64, inlinedAt: !145)
!145 = distinct !DILocation(line: 192, column: 3, scope: !67, inlinedAt: !146)
!146 = distinct !DILocation(line: 150, column: 3, scope: !40)
!147 = !DILocation(line: 69, column: 3, scope: !64, inlinedAt: !145)
!148 = !DILocation(line: 70, column: 3, scope: !64, inlinedAt: !145)
!149 = !DILocation(line: 153, column: 121, scope: !40)
!150 = !DILocation(line: 153, column: 149, scope: !40)
!151 = !DILocation(line: 153, column: 77, scope: !40)
!152 = !DILocation(line: 153, column: 155, scope: !40)
!153 = !DILocation(line: 153, column: 40, scope: !40)
!154 = !DILocation(line: 153, column: 198, scope: !40)
!155 = !DILocation(line: 153, column: 92, scope: !40)
!156 = !DILocation(line: 68, column: 3, scope: !64, inlinedAt: !157)
!157 = distinct !DILocation(line: 192, column: 3, scope: !67, inlinedAt: !158)
!158 = distinct !DILocation(line: 155, column: 3, scope: !40)
!159 = !DILocation(line: 69, column: 3, scope: !64, inlinedAt: !157)
!160 = !DILocation(line: 70, column: 3, scope: !64, inlinedAt: !157)
!161 = !DILocation(line: 157, column: 8, scope: !40)
!162 = !DILocation(line: 158, column: 22, scope: !40)
!163 = !DILocation(line: 158, column: 176, scope: !40)
!164 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!165 = !{i32 2, i32 -1, i32 -1, i32 -1}
!166 = !DILocation(line: 158, column: 213, scope: !40)
!167 = !DILocation(line: 160, column: 1, scope: !40)
