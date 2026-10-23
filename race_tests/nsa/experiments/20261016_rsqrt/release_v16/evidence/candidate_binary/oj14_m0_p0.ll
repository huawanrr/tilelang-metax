; ModuleID = 'experiments/20261016_rsqrt/candidate_binary/oj14_m0_p0.bc'
source_filename = "/tmp/tmp92zz11pj/tvm_kernels.maca"
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
  %cmp42 = icmp ugt i32 %7, 31
  %shr45 = lshr i32 %2, 4
  %cmp46.not = icmp ugt i32 %7, %shr45
  %or.cond669 = or i1 %cmp42, %cmp46.not, !dbg !51
  br i1 %or.cond669, label %if.end359, label %if.then, !dbg !51

if.then:                                          ; preds = %entry
  %add.ptr.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %5, !dbg !52
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %4, !dbg !52
  %8 = shl nuw nsw i32 %0, 15
  %mul60 = and i32 %8, 2147418112
  %mul61 = shl nuw nsw i32 %7, 11
  %9 = shl nuw nsw i32 %3, 4
  %mul67 = and i32 %9, 16256
  %and70 = shl i32 %0, 6
  %mul71 = and i32 %and70, 64
  %mul75 = and i32 %mul14, 56
  %add62 = or disjoint i32 %mul67, %mul60
  %add64 = or disjoint i32 %add62, %mul71
  %add68 = or disjoint i32 %add64, %mul75
  %add72 = add nuw nsw i32 %add68, %mul61
  %10 = zext nneg i32 %add72 to i64, !dbg !53
  %add.ptr80 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %10, !dbg !54
  %11 = load i32, ptr addrspace(4) %add.ptr80, align 4, !dbg !55, !tbaa !30
  %12 = or disjoint i64 %10, 2, !dbg !56
  %add.ptr80.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %12, !dbg !54
  %13 = load i32, ptr addrspace(4) %add.ptr80.1, align 4, !dbg !55, !tbaa !30
  %14 = or disjoint i64 %10, 4, !dbg !56
  %add.ptr80.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %14, !dbg !54
  %15 = load i32, ptr addrspace(4) %add.ptr80.2, align 4, !dbg !55, !tbaa !30
  %16 = or disjoint i64 %10, 6, !dbg !56
  %add.ptr80.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %16, !dbg !54
  %17 = load i32, ptr addrspace(4) %add.ptr80.3, align 4, !dbg !55, !tbaa !30
  %18 = add nuw nsw i64 %10, 1024
  %add.ptr80.1687 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %18, !dbg !54
  %19 = load i32, ptr addrspace(4) %add.ptr80.1687, align 4, !dbg !55, !tbaa !30
  %20 = add nuw nsw i64 %10, 1026, !dbg !56
  %add.ptr80.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %20, !dbg !54
  %21 = load i32, ptr addrspace(4) %add.ptr80.1.1, align 4, !dbg !55, !tbaa !30
  %22 = add nuw nsw i64 %10, 1028, !dbg !56
  %add.ptr80.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %22, !dbg !54
  %23 = load i32, ptr addrspace(4) %add.ptr80.2.1, align 4, !dbg !55, !tbaa !30
  %24 = add nuw nsw i64 %10, 1030, !dbg !56
  %add.ptr80.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K_blocks.coerce, i64 %24, !dbg !54
  %25 = load i32, ptr addrspace(4) %add.ptr80.3.1, align 4, !dbg !55, !tbaa !30
  %add.ptr123 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %10, !dbg !57
  %26 = load i32, ptr addrspace(4) %add.ptr123, align 4, !dbg !58, !tbaa !30
  %add.ptr123.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %12, !dbg !57
  %27 = load i32, ptr addrspace(4) %add.ptr123.1, align 4, !dbg !58, !tbaa !30
  %add.ptr123.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %14, !dbg !57
  %28 = load i32, ptr addrspace(4) %add.ptr123.2, align 4, !dbg !58, !tbaa !30
  %add.ptr123.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %16, !dbg !57
  %29 = load i32, ptr addrspace(4) %add.ptr123.3, align 4, !dbg !58, !tbaa !30
  %add.ptr123.1699 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %18, !dbg !57
  %30 = load i32, ptr addrspace(4) %add.ptr123.1699, align 4, !dbg !58, !tbaa !30
  %add.ptr123.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %20, !dbg !57
  %31 = load i32, ptr addrspace(4) %add.ptr123.1.1, align 4, !dbg !58, !tbaa !30
  %add.ptr123.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %22, !dbg !57
  %32 = load i32, ptr addrspace(4) %add.ptr123.2.1, align 4, !dbg !58, !tbaa !30
  %add.ptr123.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V_blocks.coerce, i64 %24, !dbg !57
  %33 = load i32, ptr addrspace(4) %add.ptr123.3.1, align 4, !dbg !58, !tbaa !30
  %mul147 = and i32 %mul14, 8128
  %call151.masked = and i32 %3, 1016
  %mul153 = xor i32 %mul75, %call151.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul147, !dbg !59
  %invariant.gep637 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul153, !dbg !59
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep637, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr, i64 16, i1 false), !dbg !60, !call_argsrelate !61
  %gep638.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep637, i32 1024, !dbg !62
  tail call void @llvm.memcpy.p3.p4.i64(ptr addrspace(3) noundef align 16 dereferenceable(16) %gep638.1, ptr addrspace(4) noundef align 16 dereferenceable(16) %add.ptr.1, i64 16, i1 false), !dbg !60, !call_argsrelate !61
  fence syncscope("warp") release, !dbg !63
  tail call void @llvm.mxc.barrier.warp(), !dbg !69
  fence syncscope("warp") acquire, !dbg !70
  %and165 = shl nuw nsw i32 %3, 6
  %mul166 = and i32 %and165, 960
  %shr169 = lshr i32 %3, 4
  %and172 = and i32 %3, 7
  %34 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul166
  %xor173 = xor i32 %shr169, %and172, !dbg !71
  %add.ptr177.idx = shl nuw nsw i32 %xor173, 4, !dbg !72
  %add.ptr177 = getelementptr inbounds i8, ptr addrspace(3) %34, i32 %add.ptr177.idx, !dbg !72
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr177, align 16, !dbg !73
  %Q_reg.sroa.4.0.add.ptr177.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr177, i32 8, !dbg !73
  %Q_reg.sroa.4.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr177.sroa_idx, align 8, !dbg !73
  %add170.1 = add nuw nsw i32 %shr169, 4, !dbg !74
  %xor173.1 = xor i32 %add170.1, %and172, !dbg !71
  %add.ptr177.idx.1 = shl nuw nsw i32 %xor173.1, 4, !dbg !72
  %add.ptr177.1 = getelementptr inbounds i8, ptr addrspace(3) %34, i32 %add.ptr177.idx.1, !dbg !72
  %Q_reg.sroa.5.16.copyload = load <4 x half>, ptr addrspace(3) %add.ptr177.1, align 16, !dbg !73
  %Q_reg.sroa.7.16.add.ptr177.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(3) %add.ptr177.1, i32 8, !dbg !73
  %Q_reg.sroa.7.16.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr177.1.sroa_idx, align 8, !dbg !73
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
  %kb.sroa.0.0.copyload = load <4 x half>, ptr addrspace(3) %add.ptr177, align 16, !dbg !86
  %kb.sroa.6.0.copyload = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.4.0.add.ptr177.sroa_idx, align 8, !dbg !86
  %35 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.0.0.copyload, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> zeroinitializer), !dbg !87
  %36 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %kb.sroa.6.0.copyload, <4 x half> %Q_reg.sroa.4.0.copyload, <4 x float> %35), !dbg !87
  %kb.sroa.0.0.copyload729 = load <4 x half>, ptr addrspace(3) %add.ptr177.1, align 16, !dbg !86
  %kb.sroa.6.0.copyload730 = load <4 x half>, ptr addrspace(3) %Q_reg.sroa.7.16.add.ptr177.1.sroa_idx, align 8, !dbg !86
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
  %mul47 = shl nuw nsw i32 %7, 4, !dbg !96
  %shr281 = shl nuw nsw i32 %7, 2
  %add282 = add nuw nsw i32 %shr281, %shr169
  %cmp283 = icmp ugt i32 %add282, 127
  %39 = lshr i32 %3, 2
  %mul287 = and i32 %39, 252
  %add289 = add nuw nsw i32 %mul47, %mul287
  %cmp292.not = icmp ugt i32 %add289, %2
  %or.cond670 = select i1 %cmp283, i1 true, i1 %cmp292.not, !dbg !97
  br i1 %or.cond670, label %if.end, label %if.then293, !dbg !97

if.then293:                                       ; preds = %if.then
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %38, i64 0, !dbg !98
  %mul296 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !99
  %40 = tail call contract noundef float @llvm.minnum.f32(float %mul296, float 0x4024CB5EC0000000), !dbg !100
  %41 = tail call contract noundef float @llvm.exp.f32(float %40), !dbg !104
  br label %if.end, !dbg !107

if.end:                                           ; preds = %if.then, %if.then293
  %condval.0 = phi float [ %41, %if.then293 ], [ 0.000000e+00, %if.then ], !dbg !108
  %cmp292.not.1 = icmp uge i32 %add289, %2
  %or.cond670.1 = select i1 %cmp283, i1 true, i1 %cmp292.not.1, !dbg !97
  br i1 %or.cond670.1, label %if.end.1, label %if.then293.1, !dbg !97

if.then293.1:                                     ; preds = %if.end
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %38, i64 1, !dbg !98
  %mul296.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !99
  %42 = tail call contract noundef float @llvm.minnum.f32(float %mul296.1, float 0x4024CB5EC0000000), !dbg !100
  %43 = tail call contract noundef float @llvm.exp.f32(float %42), !dbg !104
  br label %if.end.1, !dbg !107

if.end.1:                                         ; preds = %if.then293.1, %if.end
  %condval.0.1 = phi float [ %43, %if.then293.1 ], [ 0.000000e+00, %if.end ], !dbg !108
  %add290.2 = or disjoint i32 %add289, 2
  %cmp292.not.2 = icmp ugt i32 %add290.2, %2
  %or.cond670.2 = select i1 %cmp283, i1 true, i1 %cmp292.not.2, !dbg !97
  br i1 %or.cond670.2, label %if.end.2, label %if.then293.2, !dbg !97

if.then293.2:                                     ; preds = %if.end.1
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %38, i64 2, !dbg !98
  %mul296.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !99
  %44 = tail call contract noundef float @llvm.minnum.f32(float %mul296.2, float 0x4024CB5EC0000000), !dbg !100
  %45 = tail call contract noundef float @llvm.exp.f32(float %44), !dbg !104
  br label %if.end.2, !dbg !107

if.end.2:                                         ; preds = %if.then293.2, %if.end.1
  %condval.0.2 = phi float [ %45, %if.then293.2 ], [ 0.000000e+00, %if.end.1 ], !dbg !108
  %add290.3 = or disjoint i32 %add289, 3
  %cmp292.not.3 = icmp ugt i32 %add290.3, %2
  %or.cond670.3 = select i1 %cmp283, i1 true, i1 %cmp292.not.3, !dbg !97
  br i1 %or.cond670.3, label %if.end.3, label %if.then293.3, !dbg !97

if.then293.3:                                     ; preds = %if.end.2
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %38, i64 3, !dbg !98
  %mul296.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !99
  %46 = tail call contract noundef float @llvm.minnum.f32(float %mul296.3, float 0x4024CB5EC0000000), !dbg !100
  %47 = tail call contract noundef float @llvm.exp.f32(float %46), !dbg !104
  br label %if.end.3, !dbg !107

if.end.3:                                         ; preds = %if.then293.3, %if.end.2
  %condval.0.3 = phi float [ %47, %if.then293.3 ], [ 0.000000e+00, %if.end.2 ], !dbg !108
  %add312.1 = fadd contract float %condval.0, %condval.0.1, !dbg !109
  %add312.2 = fadd contract float %add312.1, %condval.0.2, !dbg !109
  %add312.3 = fadd contract float %add312.2, %condval.0.3, !dbg !109
  %48 = bitcast float %add312.3 to i32, !dbg !110
  %49 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !113
  %50 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %49) #11, !dbg !118
  %xor.i.i = xor i32 %50, 32, !dbg !119
  %51 = and i32 %50, -64, !dbg !120
  %and.i.i = add nsw i32 %51, 64, !dbg !120
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !121
  %cond.i.i = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %50, !dbg !122
  %shl.i.i = shl i32 %cond.i.i, 2, !dbg !123
  %52 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %48), !dbg !124
  %53 = bitcast i32 %52 to float, !dbg !125
  %add320 = fadd contract float %add312.3, %53, !dbg !126
  %54 = bitcast float %add320 to i32, !dbg !127
  %55 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !129
  %56 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %55) #11, !dbg !132
  %xor.i.i624 = xor i32 %56, 16, !dbg !133
  %57 = and i32 %56, -64, !dbg !134
  %and.i.i625 = add nsw i32 %57, 64, !dbg !134
  %cmp.not.i.i626 = icmp slt i32 %xor.i.i624, %and.i.i625, !dbg !135
  %cond.i.i627 = select i1 %cmp.not.i.i626, i32 %xor.i.i624, i32 %56, !dbg !136
  %shl.i.i628 = shl i32 %cond.i.i627, 2, !dbg !137
  %58 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i628, i32 %54), !dbg !138
  %59 = bitcast i32 %58 to float, !dbg !139
  %add325 = fadd contract float %add320, %59, !dbg !140
  %cmp328 = fcmp contract ogt float %add325, 0.000000e+00, !dbg !141
  %div = fdiv contract float 1.000000e+00, %add325, !dbg !142
  %condval_1.0 = select i1 %cmp328, float %div, float 0.000000e+00, !dbg !142
  %mul341 = fmul contract float %condval_1.0, %condval.0, !dbg !143
  %mul341.1 = fmul contract float %condval_1.0, %condval.0.1, !dbg !143
  %mul341.2 = fmul contract float %condval_1.0, %condval.0.2, !dbg !143
  %mul341.3 = fmul contract float %condval_1.0, %condval.0.3, !dbg !143
  %60 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul341), !dbg !144
  %61 = insertelement <4 x i16> poison, i16 %60, i64 0, !dbg !153
  %62 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul341.1), !dbg !144
  %63 = insertelement <4 x i16> %61, i16 %62, i64 1, !dbg !153
  %64 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul341.2), !dbg !144
  %65 = insertelement <4 x i16> %63, i16 %64, i64 2, !dbg !153
  %66 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul341.3), !dbg !144
  %67 = insertelement <4 x i16> %65, i16 %66, i64 3, !dbg !153
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %67 to <4 x half>, !dbg !153
  fence syncscope("warp") release, !dbg !154
  tail call void @llvm.mxc.barrier.warp(), !dbg !157
  fence syncscope("warp") acquire, !dbg !158
  br label %if.end359, !dbg !159

if.end359:                                        ; preds = %if.end.3, %entry
  %acc_s_cast.sroa.0.0 = phi <4 x half> [ undef, %entry ], [ %acc_s_cast.sroa.0.6.vec.insert, %if.end.3 ]
  br i1 %or.cond669, label %if.end429, label %for.cond381.preheader, !dbg !160

for.cond381.preheader:                            ; preds = %if.end359
  %68 = shl nuw nsw i32 %3, 4
  %mul391 = and i32 %68, 16128
  %and397 = and i32 %3, 15
  %add398 = or disjoint i32 %mul391, %and397, !dbg !161
  %arrayidx400 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398, !dbg !162
  %69 = load half, ptr addrspace(3) %arrayidx400, align 2, !dbg !163, !tbaa !164
  %vb.sroa.0.0.vec.insert = insertelement <4 x half> poison, half %69, i64 0, !dbg !163
  %add393.1 = or disjoint i32 %mul391, %and397, !dbg !161
  %add398.1 = or disjoint i32 %add393.1, 64, !dbg !161
  %arrayidx400.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398.1, !dbg !162
  %70 = load half, ptr addrspace(3) %arrayidx400.1, align 2, !dbg !163, !tbaa !164
  %vb.sroa.0.2.vec.insert = insertelement <4 x half> %vb.sroa.0.0.vec.insert, half %70, i64 1, !dbg !163
  %add393.2 = or disjoint i32 %mul391, %and397, !dbg !161
  %add398.2 = or disjoint i32 %add393.2, 128, !dbg !161
  %arrayidx400.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398.2, !dbg !162
  %71 = load half, ptr addrspace(3) %arrayidx400.2, align 2, !dbg !163, !tbaa !164
  %vb.sroa.0.4.vec.insert = insertelement <4 x half> %vb.sroa.0.2.vec.insert, half %71, i64 2, !dbg !163
  %add393.3 = or disjoint i32 %mul391, %and397, !dbg !161
  %add398.3 = or disjoint i32 %add393.3, 192, !dbg !161
  %arrayidx400.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398.3, !dbg !162
  %72 = load half, ptr addrspace(3) %arrayidx400.3, align 2, !dbg !163, !tbaa !164
  %vb.sroa.0.6.vec.insert = insertelement <4 x half> %vb.sroa.0.4.vec.insert, half %72, i64 3, !dbg !163
  %add395.1703 = or disjoint i32 %mul391, %and397, !dbg !161
  %add398.1704 = or disjoint i32 %add395.1703, 16, !dbg !161
  %arrayidx400.1705 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398.1704, !dbg !162
  %73 = load half, ptr addrspace(3) %arrayidx400.1705, align 2, !dbg !163, !tbaa !164
  %vb.sroa.7.8.vec.insert = insertelement <4 x half> poison, half %73, i64 0, !dbg !163
  %add395.1.1 = or disjoint i32 %mul391, %and397, !dbg !161
  %add398.1.1 = or disjoint i32 %add395.1.1, 80, !dbg !161
  %arrayidx400.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398.1.1, !dbg !162
  %74 = load half, ptr addrspace(3) %arrayidx400.1.1, align 2, !dbg !163, !tbaa !164
  %vb.sroa.7.10.vec.insert = insertelement <4 x half> %vb.sroa.7.8.vec.insert, half %74, i64 1, !dbg !163
  %add395.2.1 = or disjoint i32 %mul391, %and397, !dbg !161
  %add398.2.1 = or disjoint i32 %add395.2.1, 144, !dbg !161
  %arrayidx400.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398.2.1, !dbg !162
  %75 = load half, ptr addrspace(3) %arrayidx400.2.1, align 2, !dbg !163, !tbaa !164
  %vb.sroa.7.12.vec.insert = insertelement <4 x half> %vb.sroa.7.10.vec.insert, half %75, i64 2, !dbg !163
  %add395.3.1 = or disjoint i32 %mul391, %and397, !dbg !161
  %add398.3.1 = or disjoint i32 %add395.3.1, 208, !dbg !161
  %arrayidx400.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398.3.1, !dbg !162
  %76 = load half, ptr addrspace(3) %arrayidx400.3.1, align 2, !dbg !163, !tbaa !164
  %vb.sroa.7.14.vec.insert = insertelement <4 x half> %vb.sroa.7.12.vec.insert, half %76, i64 3, !dbg !163
  %add395.2707 = or disjoint i32 %mul391, %and397, !dbg !161
  %add398.2708 = or disjoint i32 %add395.2707, 32, !dbg !161
  %arrayidx400.2709 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398.2708, !dbg !162
  %77 = load half, ptr addrspace(3) %arrayidx400.2709, align 2, !dbg !163, !tbaa !164
  %vb.sroa.12.16.vec.insert = insertelement <4 x half> poison, half %77, i64 0, !dbg !163
  %add395.1.2 = or disjoint i32 %mul391, %and397, !dbg !161
  %add398.1.2 = or disjoint i32 %add395.1.2, 96, !dbg !161
  %arrayidx400.1.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398.1.2, !dbg !162
  %78 = load half, ptr addrspace(3) %arrayidx400.1.2, align 2, !dbg !163, !tbaa !164
  %vb.sroa.12.18.vec.insert = insertelement <4 x half> %vb.sroa.12.16.vec.insert, half %78, i64 1, !dbg !163
  %add395.2.2 = or disjoint i32 %mul391, %and397, !dbg !161
  %add398.2.2 = or disjoint i32 %add395.2.2, 160, !dbg !161
  %arrayidx400.2.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398.2.2, !dbg !162
  %79 = load half, ptr addrspace(3) %arrayidx400.2.2, align 2, !dbg !163, !tbaa !164
  %vb.sroa.12.20.vec.insert = insertelement <4 x half> %vb.sroa.12.18.vec.insert, half %79, i64 2, !dbg !163
  %add395.3.2 = or disjoint i32 %mul391, %and397, !dbg !161
  %add398.3.2 = or disjoint i32 %add395.3.2, 224, !dbg !161
  %arrayidx400.3.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398.3.2, !dbg !162
  %80 = load half, ptr addrspace(3) %arrayidx400.3.2, align 2, !dbg !163, !tbaa !164
  %vb.sroa.12.22.vec.insert = insertelement <4 x half> %vb.sroa.12.20.vec.insert, half %80, i64 3, !dbg !163
  %add395.3711 = or disjoint i32 %mul391, %and397, !dbg !161
  %add398.3712 = or disjoint i32 %add395.3711, 48, !dbg !161
  %arrayidx400.3713 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398.3712, !dbg !162
  %81 = load half, ptr addrspace(3) %arrayidx400.3713, align 2, !dbg !163, !tbaa !164
  %vb.sroa.17.24.vec.insert = insertelement <4 x half> poison, half %81, i64 0, !dbg !163
  %add395.1.3 = or disjoint i32 %mul391, %and397, !dbg !161
  %add398.1.3 = or disjoint i32 %add395.1.3, 112, !dbg !161
  %arrayidx400.1.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398.1.3, !dbg !162
  %82 = load half, ptr addrspace(3) %arrayidx400.1.3, align 2, !dbg !163, !tbaa !164
  %vb.sroa.17.26.vec.insert = insertelement <4 x half> %vb.sroa.17.24.vec.insert, half %82, i64 1, !dbg !163
  %add395.2.3 = or disjoint i32 %mul391, %and397, !dbg !161
  %add398.2.3 = or disjoint i32 %add395.2.3, 176, !dbg !161
  %arrayidx400.2.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398.2.3, !dbg !162
  %83 = load half, ptr addrspace(3) %arrayidx400.2.3, align 2, !dbg !163, !tbaa !164
  %vb.sroa.17.28.vec.insert = insertelement <4 x half> %vb.sroa.17.26.vec.insert, half %83, i64 2, !dbg !163
  %add395.3.3 = or disjoint i32 %68, %and397, !dbg !161
  %add398.3.3 = or i32 %add395.3.3, 240, !dbg !161
  %arrayidx400.3.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add398.3.3, !dbg !162
  %84 = load half, ptr addrspace(3) %arrayidx400.3.3, align 2, !dbg !163, !tbaa !164
  %vb.sroa.17.30.vec.insert = insertelement <4 x half> %vb.sroa.17.28.vec.insert, half %84, i64 3, !dbg !163
  %85 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.0.6.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !165
  %86 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.7.14.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !165
  %87 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.12.22.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !165
  %88 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %vb.sroa.17.30.vec.insert, <4 x half> %acc_s_cast.sroa.0.0, <4 x float> zeroinitializer), !dbg !165
  br label %if.end429, !dbg !166

if.end429:                                        ; preds = %for.cond381.preheader, %if.end359
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end359 ], [ %85, %for.cond381.preheader ], !dbg !108
  %acc_o.sroa.16.0 = phi <4 x float> [ zeroinitializer, %if.end359 ], [ %86, %for.cond381.preheader ], !dbg !108
  %acc_o.sroa.30.0 = phi <4 x float> [ zeroinitializer, %if.end359 ], [ %87, %for.cond381.preheader ], !dbg !108
  %acc_o.sroa.44.0 = phi <4 x float> [ zeroinitializer, %if.end359 ], [ %88, %for.cond381.preheader ], !dbg !108
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 0, !dbg !167
  %89 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.0.vec.extract), !dbg !168
  %O_reg.sroa.0.0.insert.ext = zext i16 %89 to i64, !dbg !172
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 1, !dbg !167
  %90 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.4.vec.extract), !dbg !168
  %O_reg.sroa.0.2.insert.ext = zext i16 %90 to i64, !dbg !172
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !172
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !172
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 2, !dbg !167
  %91 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.8.vec.extract), !dbg !168
  %O_reg.sroa.0.4.insert.ext = zext i16 %91 to i64, !dbg !172
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !172
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !172
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.0, i64 3, !dbg !167
  %92 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.0.12.vec.extract), !dbg !168
  %O_reg.sroa.0.6.insert.ext = zext i16 %92 to i64, !dbg !172
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !172
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !172
  %acc_o.sroa.16.16.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 0, !dbg !167
  %93 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.16.vec.extract), !dbg !168
  %O_reg.sroa.7.8.insert.ext = zext i16 %93 to i64, !dbg !172
  %acc_o.sroa.16.20.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 1, !dbg !167
  %94 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.20.vec.extract), !dbg !168
  %O_reg.sroa.7.10.insert.ext = zext i16 %94 to i64, !dbg !172
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !172
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !172
  %acc_o.sroa.16.24.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 2, !dbg !167
  %95 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.24.vec.extract), !dbg !168
  %O_reg.sroa.7.12.insert.ext = zext i16 %95 to i64, !dbg !172
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !172
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !172
  %acc_o.sroa.16.28.vec.extract = extractelement <4 x float> %acc_o.sroa.16.0, i64 3, !dbg !167
  %96 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.16.28.vec.extract), !dbg !168
  %O_reg.sroa.7.14.insert.ext = zext i16 %96 to i64, !dbg !172
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !172
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !172
  %acc_o.sroa.30.32.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 0, !dbg !167
  %97 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.32.vec.extract), !dbg !168
  %O_reg.sroa.12.16.insert.ext = zext i16 %97 to i64, !dbg !172
  %acc_o.sroa.30.36.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 1, !dbg !167
  %98 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.36.vec.extract), !dbg !168
  %O_reg.sroa.12.18.insert.ext = zext i16 %98 to i64, !dbg !172
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !172
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !172
  %acc_o.sroa.30.40.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 2, !dbg !167
  %99 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.40.vec.extract), !dbg !168
  %O_reg.sroa.12.20.insert.ext = zext i16 %99 to i64, !dbg !172
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !172
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !172
  %acc_o.sroa.30.44.vec.extract = extractelement <4 x float> %acc_o.sroa.30.0, i64 3, !dbg !167
  %100 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.30.44.vec.extract), !dbg !168
  %O_reg.sroa.12.22.insert.ext = zext i16 %100 to i64, !dbg !172
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !172
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !172
  %acc_o.sroa.44.48.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 0, !dbg !167
  %101 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.48.vec.extract), !dbg !168
  %O_reg.sroa.17.24.insert.ext = zext i16 %101 to i64, !dbg !172
  %acc_o.sroa.44.52.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 1, !dbg !167
  %102 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.52.vec.extract), !dbg !168
  %O_reg.sroa.17.26.insert.ext = zext i16 %102 to i64, !dbg !172
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !172
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !172
  %acc_o.sroa.44.56.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 2, !dbg !167
  %103 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.56.vec.extract), !dbg !168
  %O_reg.sroa.17.28.insert.ext = zext i16 %103 to i64, !dbg !172
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !172
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !172
  %acc_o.sroa.44.60.vec.extract = extractelement <4 x float> %acc_o.sroa.44.0, i64 3, !dbg !167
  %104 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %acc_o.sroa.44.60.vec.extract), !dbg !168
  %O_reg.sroa.17.30.insert.ext = zext i16 %104 to i64, !dbg !172
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !172
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !172
  fence syncscope("warp") release, !dbg !173
  tail call void @llvm.mxc.barrier.warp(), !dbg !176
  fence syncscope("warp") acquire, !dbg !177
  %and462 = shl nuw nsw i32 %3, 6
  %mul463 = and i32 %and462, 960
  %shr466 = lshr i32 %3, 5
  %and469 = and i32 %3, 7
  %105 = lshr i32 %3, 2
  %mul476 = and i32 %105, 4
  %xor470 = xor i32 %shr466, %and469, !dbg !178
  %mul471 = shl nuw nsw i32 %xor470, 3, !dbg !179
  %add472 = add nuw nsw i32 %mul471, %mul463, !dbg !180
  %add477 = or disjoint i32 %add472, %mul476, !dbg !181
  %add.ptr479 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add477, !dbg !182
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr479, align 8, !dbg !183
  %add467.1 = add nuw nsw i32 %shr466, 2, !dbg !184
  %xor470.1 = xor i32 %add467.1, %and469, !dbg !178
  %mul471.1 = shl nuw nsw i32 %xor470.1, 3, !dbg !179
  %add472.1 = add nuw nsw i32 %mul471.1, %mul463, !dbg !180
  %add477.1 = or disjoint i32 %add472.1, %mul476, !dbg !181
  %add.ptr479.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add477.1, !dbg !182
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr479.1, align 8, !dbg !183
  %add467.2 = add nuw nsw i32 %shr466, 4, !dbg !184
  %xor470.2 = xor i32 %add467.2, %and469, !dbg !178
  %mul471.2 = shl nuw nsw i32 %xor470.2, 3, !dbg !179
  %add472.2 = add nuw nsw i32 %mul471.2, %mul463, !dbg !180
  %add477.2 = or disjoint i32 %add472.2, %mul476, !dbg !181
  %add.ptr479.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add477.2, !dbg !182
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr479.2, align 8, !dbg !183
  %add467.3 = add nuw nsw i32 %shr466, 6, !dbg !184
  %xor470.3 = xor i32 %add467.3, %and469, !dbg !178
  %mul471.3 = shl nuw nsw i32 %xor470.3, 3, !dbg !179
  %add472.3 = add nuw nsw i32 %mul471.3, %mul463, !dbg !180
  %add477.3 = or disjoint i32 %add472.3, %mul476, !dbg !181
  %add.ptr479.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add477.3, !dbg !182
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr479.3, align 8, !dbg !183
  fence syncscope("warp") release, !dbg !185
  tail call void @llvm.mxc.barrier.warp(), !dbg !188
  fence syncscope("warp") acquire, !dbg !189
  %mul490 = and i32 %mul14, 8128
  %xor496618 = and i32 %mul14, 56
  %call494.masked = and i32 %3, 1016
  %mul497 = xor i32 %xor496618, %call494.masked
  %invariant.gep664 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul490, !dbg !190
  %invariant.gep666 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep664, i32 %mul497, !dbg !190
  %add.ptr517 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %4, !dbg !191
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr517, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep666, i64 16, i1 false), !dbg !192, !tbaa.struct !193, !call_argsrelate !194
  %gep667.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep666, i32 1024, !dbg !195
  %add.ptr517.1 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %5, !dbg !191
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr517.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep667.1, i64 16, i1 false), !dbg !192, !tbaa.struct !193, !call_argsrelate !194
  ret void, !dbg !196
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
!1 = !DIFile(filename: "/tmp/tmp92zz11pj/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmp92zz11pj/tvm_kernels.maca", directory: "")
!42 = !{i32 0, i32 1024}
!43 = !DILocation(line: 25, column: 3, scope: !40)
!44 = !DILocation(line: 26, column: 170, scope: !40)
!45 = !DILocation(line: 28, column: 66, scope: !40)
!46 = !DILocation(line: 28, column: 95, scope: !40)
!47 = !DILocation(line: 28, column: 74, scope: !40)
!48 = !DILocation(line: 28, column: 122, scope: !40)
!49 = !DILocation(line: 28, column: 101, scope: !40)
!50 = !DILocation(line: 28, column: 25, scope: !40)
!51 = !DILocation(line: 34, column: 31, scope: !40)
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
!96 = !DILocation(line: 35, column: 43, scope: !40)
!97 = !DILocation(line: 85, column: 84, scope: !40)
!98 = !DILocation(line: 86, column: 29, scope: !40)
!99 = !DILocation(line: 86, column: 40, scope: !40)
!100 = !DILocation(line: 354, column: 10, scope: !101, inlinedAt: !103)
!101 = distinct !DISubprogram(name: "min", scope: !102, file: !102, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!102 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!103 = distinct !DILocation(line: 86, column: 24, scope: !40)
!104 = !DILocation(line: 288, column: 10, scope: !105, inlinedAt: !106)
!105 = distinct !DISubprogram(name: "expf", scope: !102, file: !102, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!106 = distinct !DILocation(line: 86, column: 19, scope: !40)
!107 = !DILocation(line: 87, column: 7, scope: !40)
!108 = !DILocation(line: 0, scope: !40)
!109 = !DILocation(line: 95, column: 34, scope: !40)
!110 = !DILocation(line: 1018, column: 9, scope: !111, inlinedAt: !112)
!111 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !65, file: !65, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!112 = distinct !DILocation(line: 97, column: 34, scope: !40)
!113 = !DILocation(line: 171, column: 37, scope: !114, inlinedAt: !115)
!114 = distinct !DISubprogram(name: "__lane_id", scope: !65, file: !65, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!115 = distinct !DILocation(line: 990, column: 14, scope: !116, inlinedAt: !117)
!116 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !65, file: !65, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!117 = distinct !DILocation(line: 1019, column: 11, scope: !111, inlinedAt: !112)
!118 = !DILocation(line: 171, column: 10, scope: !114, inlinedAt: !115)
!119 = !DILocation(line: 991, column: 20, scope: !116, inlinedAt: !117)
!120 = !DILocation(line: 992, column: 36, scope: !116, inlinedAt: !117)
!121 = !DILocation(line: 992, column: 17, scope: !116, inlinedAt: !117)
!122 = !DILocation(line: 992, column: 11, scope: !116, inlinedAt: !117)
!123 = !DILocation(line: 993, column: 43, scope: !116, inlinedAt: !117)
!124 = !DILocation(line: 993, column: 10, scope: !116, inlinedAt: !117)
!125 = !DILocation(line: 1020, column: 14, scope: !111, inlinedAt: !112)
!126 = !DILocation(line: 97, column: 32, scope: !40)
!127 = !DILocation(line: 1018, column: 9, scope: !111, inlinedAt: !128)
!128 = distinct !DILocation(line: 98, column: 34, scope: !40)
!129 = !DILocation(line: 171, column: 37, scope: !114, inlinedAt: !130)
!130 = distinct !DILocation(line: 990, column: 14, scope: !116, inlinedAt: !131)
!131 = distinct !DILocation(line: 1019, column: 11, scope: !111, inlinedAt: !128)
!132 = !DILocation(line: 171, column: 10, scope: !114, inlinedAt: !130)
!133 = !DILocation(line: 991, column: 20, scope: !116, inlinedAt: !131)
!134 = !DILocation(line: 992, column: 36, scope: !116, inlinedAt: !131)
!135 = !DILocation(line: 992, column: 17, scope: !116, inlinedAt: !131)
!136 = !DILocation(line: 992, column: 11, scope: !116, inlinedAt: !131)
!137 = !DILocation(line: 993, column: 43, scope: !116, inlinedAt: !131)
!138 = !DILocation(line: 993, column: 10, scope: !116, inlinedAt: !131)
!139 = !DILocation(line: 1020, column: 14, scope: !111, inlinedAt: !128)
!140 = !DILocation(line: 98, column: 32, scope: !40)
!141 = !DILocation(line: 100, column: 34, scope: !40)
!142 = !DILocation(line: 100, column: 9, scope: !40)
!143 = !DILocation(line: 108, column: 32, scope: !40)
!144 = !DILocation(line: 75, column: 10, scope: !145, inlinedAt: !147)
!145 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !146, file: !146, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!146 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!147 = distinct !DILocation(line: 984, column: 9, scope: !148, inlinedAt: !150)
!148 = distinct !DISubprogram(name: "__float2half", scope: !149, file: !149, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!149 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!150 = distinct !DILocation(line: 133, column: 53, scope: !151, inlinedAt: !152)
!151 = distinct !DISubprogram(name: "__half", scope: !149, file: !149, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!152 = distinct !DILocation(line: 112, column: 32, scope: !40)
!153 = !DILocation(line: 112, column: 29, scope: !40)
!154 = !DILocation(line: 68, column: 3, scope: !64, inlinedAt: !155)
!155 = distinct !DILocation(line: 192, column: 3, scope: !67, inlinedAt: !156)
!156 = distinct !DILocation(line: 114, column: 5, scope: !40)
!157 = !DILocation(line: 69, column: 3, scope: !64, inlinedAt: !155)
!158 = !DILocation(line: 70, column: 3, scope: !64, inlinedAt: !155)
!159 = !DILocation(line: 115, column: 3, scope: !40)
!160 = !DILocation(line: 121, column: 31, scope: !40)
!161 = !DILocation(line: 124, column: 119, scope: !40)
!162 = !DILocation(line: 124, column: 31, scope: !40)
!163 = !DILocation(line: 124, column: 29, scope: !40)
!164 = !{!26, !26, i64 0}
!165 = !DILocation(line: 129, column: 38, scope: !40)
!166 = !DILocation(line: 136, column: 3, scope: !40)
!167 = !DILocation(line: 139, column: 58, scope: !40)
!168 = !DILocation(line: 75, column: 10, scope: !145, inlinedAt: !169)
!169 = distinct !DILocation(line: 984, column: 9, scope: !148, inlinedAt: !170)
!170 = distinct !DILocation(line: 133, column: 53, scope: !151, inlinedAt: !171)
!171 = distinct !DILocation(line: 139, column: 50, scope: !40)
!172 = !DILocation(line: 139, column: 47, scope: !40)
!173 = !DILocation(line: 68, column: 3, scope: !64, inlinedAt: !174)
!174 = distinct !DILocation(line: 192, column: 3, scope: !67, inlinedAt: !175)
!175 = distinct !DILocation(line: 142, column: 3, scope: !40)
!176 = !DILocation(line: 69, column: 3, scope: !64, inlinedAt: !174)
!177 = !DILocation(line: 70, column: 3, scope: !64, inlinedAt: !174)
!178 = !DILocation(line: 145, column: 121, scope: !40)
!179 = !DILocation(line: 145, column: 149, scope: !40)
!180 = !DILocation(line: 145, column: 77, scope: !40)
!181 = !DILocation(line: 145, column: 155, scope: !40)
!182 = !DILocation(line: 145, column: 40, scope: !40)
!183 = !DILocation(line: 145, column: 198, scope: !40)
!184 = !DILocation(line: 145, column: 92, scope: !40)
!185 = !DILocation(line: 68, column: 3, scope: !64, inlinedAt: !186)
!186 = distinct !DILocation(line: 192, column: 3, scope: !67, inlinedAt: !187)
!187 = distinct !DILocation(line: 147, column: 3, scope: !40)
!188 = !DILocation(line: 69, column: 3, scope: !64, inlinedAt: !186)
!189 = !DILocation(line: 70, column: 3, scope: !64, inlinedAt: !186)
!190 = !DILocation(line: 149, column: 8, scope: !40)
!191 = !DILocation(line: 150, column: 22, scope: !40)
!192 = !DILocation(line: 150, column: 176, scope: !40)
!193 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!194 = !{i32 2, i32 -1, i32 -1, i32 -1}
!195 = !DILocation(line: 150, column: 213, scope: !40)
!196 = !DILocation(line: 152, column: 1, scope: !40)
