; ModuleID = 'experiments/20261016_goal895/readonly_binary/oj12_m2_p1.bc'
source_filename = "/tmp/tmpabf65qeo/tvm_kernels.maca"
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
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %BlockIndices.coerce, ptr addrspace(4) noalias noundef readonly %K.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias noundef readonly %V.coerce) local_unnamed_addr #3 !dbg !40 {
entry:
  %0 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.x(), !range !29
  %mul = shl nsw i32 %0, 13
  %1 = tail call noundef range(i32 0, 2147483647) i32 @llvm.mxc.block.id.z(), !range !29
  %mul7 = shl nsw i32 %1, 3
  %add = add nuw nsw i32 %mul, %mul7
  %2 = zext nneg i32 %add to i64, !dbg !42
  %arrayidx = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %2, !dbg !43
  %3 = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !43, !tbaa !30
  %cond.i.i = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %3, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i1211 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64), !dbg !49
  %mul11 = shl nsw i32 %cond.i.i1211, 4, !dbg !52
  %4 = or disjoint i64 %2, 1, !dbg !53
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4, !dbg !43
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !dbg !43, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i1211.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64), !dbg !49
  %mul11.1 = shl nsw i32 %cond.i.i1211.1, 4, !dbg !52
  %6 = or disjoint i64 %2, 2, !dbg !53
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6, !dbg !43
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !dbg !43, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i1211.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64), !dbg !49
  %mul11.2 = shl nsw i32 %cond.i.i1211.2, 4, !dbg !52
  %8 = or disjoint i64 %2, 3, !dbg !53
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8, !dbg !43
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !dbg !43, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i1211.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64), !dbg !49
  %mul11.3 = shl nsw i32 %cond.i.i1211.3, 4, !dbg !52
  %10 = or disjoint i64 %2, 4, !dbg !53
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10, !dbg !43
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !dbg !43, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i1211.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64), !dbg !49
  %mul11.4 = shl nsw i32 %cond.i.i1211.4, 4, !dbg !52
  %12 = or disjoint i64 %2, 5, !dbg !53
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12, !dbg !43
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !dbg !43, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i1211.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64), !dbg !49
  %mul11.5 = shl nsw i32 %cond.i.i1211.5, 4, !dbg !52
  %14 = or disjoint i64 %2, 6, !dbg !53
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14, !dbg !43
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !dbg !43, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i1211.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64), !dbg !49
  %mul11.6 = shl nsw i32 %cond.i.i1211.6, 4, !dbg !52
  %16 = or disjoint i64 %2, 7, !dbg !53
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16, !dbg !43
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !dbg !43, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i1211.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64), !dbg !49
  %mul11.7 = shl nsw i32 %cond.i.i1211.7, 4, !dbg !52
  %mul20 = shl nsw i32 %0, 20
  %mul22 = shl nsw i32 %1, 10
  %add23 = add nuw nsw i32 %mul20, %mul22
  %18 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !54
  %and = shl nuw nsw i32 %18, 6
  %mul25 = and i32 %and, 960
  %add26 = or disjoint i32 %add23, %mul25
  %19 = lshr i32 %18, 1
  %mul30 = and i32 %19, 504
  %add28 = add nuw nsw i32 %add26, %mul30
  %20 = zext nneg i32 %add28 to i64, !dbg !55
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %20, !dbg !56
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16, !dbg !57
  %Q_reg.sroa.11.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !57
  %Q_reg.sroa.11.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.11.0.add.ptr.sroa_idx, align 8, !dbg !57
  %21 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %20, !dbg !56
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %21, i64 64, !dbg !56
  %Q_reg.sroa.19.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16, !dbg !57
  %Q_reg.sroa.28.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %21, i64 72, !dbg !57
  %Q_reg.sroa.28.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.28.16.add.ptr.1.sroa_idx, align 8, !dbg !57
  %mul101 = shl nsw i32 %0, 16
  %mul109 = shl nuw nsw i32 %18, 3
  %add104 = or disjoint i32 %mul109, %mul101
  %invariant.op = add nsw i32 %1, -15, !dbg !58
  %22 = lshr i32 %18, 2
  %mul270 = and i32 %22, 252
  %or.cond = icmp ugt i32 %mul11, 1023, !dbg !59
  %cmp94.not = icmp sgt i32 %mul11, %1
  %or.cond1287 = or i1 %or.cond, %cmp94.not, !dbg !59
  br i1 %or.cond1287, label %if.end, label %for.cond95.preheader, !dbg !59

for.cond95.preheader:                             ; preds = %entry
  %23 = shl nsw i32 %cond.i.i1211, 10
  %mul103 = and i32 %23, 64512
  %add107 = add nuw nsw i32 %add104, %mul103
  %idxprom113 = zext nneg i32 %add107 to i64, !dbg !60
  %arrayidx114 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom113, !dbg !60
  %24 = load <4 x half>, ptr addrspace(4) %arrayidx114, align 2, !dbg !61, !tbaa !62
  %add110.4 = or disjoint i32 %add107, 4, !dbg !63
  %idxprom113.4 = zext nneg i32 %add110.4 to i64, !dbg !60
  %arrayidx114.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom113.4, !dbg !60
  %25 = load <4 x half>, ptr addrspace(4) %arrayidx114.4, align 2, !dbg !61, !tbaa !62
  %26 = zext nneg i32 %add107 to i64, !dbg !60
  %27 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %26, !dbg !60
  %arrayidx114.8 = getelementptr inbounds i8, ptr addrspace(4) %27, i64 1024, !dbg !60
  %28 = load <4 x half>, ptr addrspace(4) %arrayidx114.8, align 2, !dbg !61, !tbaa !62
  %29 = zext nneg i32 %add107 to i64, !dbg !60
  %30 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %29, !dbg !60
  %arrayidx114.12 = getelementptr inbounds i8, ptr addrspace(4) %30, i64 1032, !dbg !60
  %31 = load <4 x half>, ptr addrspace(4) %arrayidx114.12, align 2, !dbg !61, !tbaa !62
  br label %if.end, !dbg !64

if.end:                                           ; preds = %for.cond95.preheader, %entry
  %K_reg.sroa.32.0 = phi <4 x half> [ undef, %entry ], [ %31, %for.cond95.preheader ]
  %K_reg.sroa.22.0 = phi <4 x half> [ undef, %entry ], [ %28, %for.cond95.preheader ]
  %K_reg.sroa.12.0 = phi <4 x half> [ undef, %entry ], [ %25, %for.cond95.preheader ]
  %K_reg.sroa.0.0 = phi <4 x half> [ undef, %entry ], [ %24, %for.cond95.preheader ]
  %or.cond1288 = icmp ugt i32 %mul11.1, 1023, !dbg !64
  %cmp126.not = icmp sgt i32 %mul11.1, %1
  %or.cond1289 = or i1 %or.cond1288, %cmp126.not, !dbg !64
  br i1 %or.cond1289, label %if.end155, label %for.cond128.preheader, !dbg !64

for.cond128.preheader:                            ; preds = %if.end
  %32 = shl nsw i32 %cond.i.i1211.1, 10
  %mul136 = and i32 %32, 64512
  %add140 = add nuw nsw i32 %add104, %mul136
  %idxprom146 = zext nneg i32 %add140 to i64, !dbg !65
  %arrayidx147 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom146, !dbg !65
  %33 = load <4 x half>, ptr addrspace(4) %arrayidx147, align 2, !dbg !66, !tbaa !62
  %add143.4 = or disjoint i32 %add140, 4, !dbg !67
  %idxprom146.4 = zext nneg i32 %add143.4 to i64, !dbg !65
  %arrayidx147.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom146.4, !dbg !65
  %34 = load <4 x half>, ptr addrspace(4) %arrayidx147.4, align 2, !dbg !66, !tbaa !62
  %35 = zext nneg i32 %add140 to i64, !dbg !65
  %36 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %35, !dbg !65
  %arrayidx147.8 = getelementptr inbounds i8, ptr addrspace(4) %36, i64 1024, !dbg !65
  %37 = load <4 x half>, ptr addrspace(4) %arrayidx147.8, align 2, !dbg !66, !tbaa !62
  %38 = zext nneg i32 %add140 to i64, !dbg !65
  %39 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %38, !dbg !65
  %arrayidx147.12 = getelementptr inbounds i8, ptr addrspace(4) %39, i64 1032, !dbg !65
  %40 = load <4 x half>, ptr addrspace(4) %arrayidx147.12, align 2, !dbg !66, !tbaa !62
  br label %if.end155, !dbg !68

if.end155:                                        ; preds = %for.cond128.preheader, %if.end
  %K_reg1.sroa.32.0 = phi <4 x half> [ undef, %if.end ], [ %40, %for.cond128.preheader ]
  %K_reg1.sroa.22.0 = phi <4 x half> [ undef, %if.end ], [ %37, %for.cond128.preheader ]
  %K_reg1.sroa.12.0 = phi <4 x half> [ undef, %if.end ], [ %34, %for.cond128.preheader ]
  %K_reg1.sroa.0.0 = phi <4 x half> [ undef, %if.end ], [ %33, %for.cond128.preheader ]
  %or.cond1290 = icmp ugt i32 %mul11.2, 1023, !dbg !68
  %cmp161.not = icmp sgt i32 %mul11.2, %1
  %or.cond1291 = or i1 %or.cond1290, %cmp161.not, !dbg !68
  br i1 %or.cond1291, label %if.end190, label %for.cond163.preheader, !dbg !68

for.cond163.preheader:                            ; preds = %if.end155
  %41 = shl nsw i32 %cond.i.i1211.2, 10
  %mul171 = and i32 %41, 64512
  %add175 = add nuw nsw i32 %add104, %mul171
  %idxprom181 = zext nneg i32 %add175 to i64, !dbg !69
  %arrayidx182 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom181, !dbg !69
  %42 = load <4 x half>, ptr addrspace(4) %arrayidx182, align 2, !dbg !70, !tbaa !62
  %add178.4 = or disjoint i32 %add175, 4, !dbg !71
  %idxprom181.4 = zext nneg i32 %add178.4 to i64, !dbg !69
  %arrayidx182.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom181.4, !dbg !69
  %43 = load <4 x half>, ptr addrspace(4) %arrayidx182.4, align 2, !dbg !70, !tbaa !62
  %44 = zext nneg i32 %add175 to i64, !dbg !69
  %45 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %44, !dbg !69
  %arrayidx182.8 = getelementptr inbounds i8, ptr addrspace(4) %45, i64 1024, !dbg !69
  %46 = load <4 x half>, ptr addrspace(4) %arrayidx182.8, align 2, !dbg !70, !tbaa !62
  %47 = zext nneg i32 %add175 to i64, !dbg !69
  %48 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %47, !dbg !69
  %arrayidx182.12 = getelementptr inbounds i8, ptr addrspace(4) %48, i64 1032, !dbg !69
  %49 = load <4 x half>, ptr addrspace(4) %arrayidx182.12, align 2, !dbg !70, !tbaa !62
  br label %if.end190, !dbg !72

if.end190:                                        ; preds = %for.cond163.preheader, %if.end155
  %K_reg2.sroa.32.0 = phi <4 x half> [ undef, %if.end155 ], [ %49, %for.cond163.preheader ]
  %K_reg2.sroa.22.0 = phi <4 x half> [ undef, %if.end155 ], [ %46, %for.cond163.preheader ]
  %K_reg2.sroa.12.0 = phi <4 x half> [ undef, %if.end155 ], [ %43, %for.cond163.preheader ]
  %K_reg2.sroa.0.0 = phi <4 x half> [ undef, %if.end155 ], [ %42, %for.cond163.preheader ]
  %or.cond1292 = icmp ugt i32 %mul11.3, 1023, !dbg !72
  %cmp196.not = icmp sgt i32 %mul11.3, %1
  %or.cond1293 = or i1 %or.cond1292, %cmp196.not, !dbg !72
  br i1 %or.cond1293, label %if.end225, label %for.cond198.preheader, !dbg !72

for.cond198.preheader:                            ; preds = %if.end190
  %50 = shl nsw i32 %cond.i.i1211.3, 10
  %mul206 = and i32 %50, 64512
  %add210 = add nuw nsw i32 %add104, %mul206
  %idxprom216 = zext nneg i32 %add210 to i64, !dbg !73
  %arrayidx217 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom216, !dbg !73
  %51 = load <4 x half>, ptr addrspace(4) %arrayidx217, align 2, !dbg !74, !tbaa !62
  %add213.4 = or disjoint i32 %add210, 4, !dbg !75
  %idxprom216.4 = zext nneg i32 %add213.4 to i64, !dbg !73
  %arrayidx217.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom216.4, !dbg !73
  %52 = load <4 x half>, ptr addrspace(4) %arrayidx217.4, align 2, !dbg !74, !tbaa !62
  %53 = zext nneg i32 %add210 to i64, !dbg !73
  %54 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %53, !dbg !73
  %arrayidx217.8 = getelementptr inbounds i8, ptr addrspace(4) %54, i64 1024, !dbg !73
  %55 = load <4 x half>, ptr addrspace(4) %arrayidx217.8, align 2, !dbg !74, !tbaa !62
  %56 = zext nneg i32 %add210 to i64, !dbg !73
  %57 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %56, !dbg !73
  %arrayidx217.12 = getelementptr inbounds i8, ptr addrspace(4) %57, i64 1032, !dbg !73
  %58 = load <4 x half>, ptr addrspace(4) %arrayidx217.12, align 2, !dbg !74, !tbaa !62
  br label %if.end225, !dbg !76

if.end225:                                        ; preds = %for.cond198.preheader, %if.end190
  %K_reg3.sroa.32.0 = phi <4 x half> [ undef, %if.end190 ], [ %58, %for.cond198.preheader ]
  %K_reg3.sroa.22.0 = phi <4 x half> [ undef, %if.end190 ], [ %55, %for.cond198.preheader ]
  %K_reg3.sroa.12.0 = phi <4 x half> [ undef, %if.end190 ], [ %52, %for.cond198.preheader ]
  %K_reg3.sroa.0.0 = phi <4 x half> [ undef, %if.end190 ], [ %51, %for.cond198.preheader ]
  br i1 %or.cond1287, label %if.end374, label %for.cond233.preheader, !dbg !76

for.cond233.preheader:                            ; preds = %if.end225
  %59 = shl nsw i32 %cond.i.i1211, 10
  %mul241 = and i32 %59, 64512
  %add245 = add nuw nsw i32 %add104, %mul241
  %idxprom251 = zext nneg i32 %add245 to i64, !dbg !77
  %arrayidx252 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom251, !dbg !77
  %60 = load <4 x half>, ptr addrspace(4) %arrayidx252, align 2, !dbg !78, !tbaa !62
  %add248.4 = or disjoint i32 %add245, 4, !dbg !79
  %idxprom251.4 = zext nneg i32 %add248.4 to i64, !dbg !77
  %arrayidx252.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom251.4, !dbg !77
  %61 = load <4 x half>, ptr addrspace(4) %arrayidx252.4, align 2, !dbg !78, !tbaa !62
  %62 = zext nneg i32 %add245 to i64, !dbg !77
  %63 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %62, !dbg !77
  %arrayidx252.8 = getelementptr inbounds i8, ptr addrspace(4) %63, i64 1024, !dbg !77
  %64 = load <4 x half>, ptr addrspace(4) %arrayidx252.8, align 2, !dbg !78, !tbaa !62
  %65 = zext nneg i32 %add245 to i64, !dbg !77
  %66 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %65, !dbg !77
  %arrayidx252.12 = getelementptr inbounds i8, ptr addrspace(4) %66, i64 1032, !dbg !77
  %67 = load <4 x half>, ptr addrspace(4) %arrayidx252.12, align 2, !dbg !78, !tbaa !62
  %cmp262 = icmp sgt i32 %mul11, %invariant.op, !dbg !80
  br i1 %cmp262, label %for.cond264.preheader, label %if.end287, !dbg !81

for.cond264.preheader:                            ; preds = %for.cond233.preheader
  %add271 = add nuw nsw i32 %mul11, %mul270
  %cmp274.not = icmp sgt i32 %add271, %1, !dbg !82
  %fneg. = select i1 %cmp274.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1459 = insertelement <4 x float> poison, float %fneg., i64 0, !dbg !83
  %cmp274.not.1.not = icmp slt i32 %add271, %1, !dbg !82
  %fneg..1 = select i1 %cmp274.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1560 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1459, float %fneg..1, i64 1, !dbg !83
  %add272.2 = or disjoint i32 %add271, 2, !dbg !84
  %cmp274.not.2 = icmp sgt i32 %add272.2, %1, !dbg !82
  %fneg..2 = select i1 %cmp274.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1653 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1560, float %fneg..2, i64 2, !dbg !83
  %add272.3 = or disjoint i32 %add271, 3, !dbg !84
  %cmp274.not.3 = icmp sgt i32 %add272.3, %1, !dbg !82
  %fneg..3 = select i1 %cmp274.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1746 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1653, float %fneg..3, i64 3, !dbg !83
  br label %if.end287

if.end287:                                        ; preds = %for.cond233.preheader, %for.cond264.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1746, %for.cond264.preheader ], [ zeroinitializer, %for.cond233.preheader ], !dbg !85
  %68 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !dbg !86, !call_argsrelate !87
  %69 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.12.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %68), !dbg !86, !call_argsrelate !87
  %70 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.22.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %69), !dbg !86, !call_argsrelate !87
  %71 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.32.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %70), !dbg !86, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %71, i64 0, !dbg !88
  %mul322 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !89
  %72 = tail call contract noundef float @llvm.minnum.f32(float %mul322, float 0x4024CB5EC0000000), !dbg !90
  %73 = tail call contract noundef float @llvm.exp.f32(float %72), !dbg !93
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %71, i64 1, !dbg !88
  %mul322.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !89
  %74 = tail call contract noundef float @llvm.minnum.f32(float %mul322.1, float 0x4024CB5EC0000000), !dbg !90
  %75 = tail call contract noundef float @llvm.exp.f32(float %74), !dbg !93
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %71, i64 2, !dbg !88
  %mul322.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !89
  %76 = tail call contract noundef float @llvm.minnum.f32(float %mul322.2, float 0x4024CB5EC0000000), !dbg !90
  %77 = tail call contract noundef float @llvm.exp.f32(float %76), !dbg !93
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %71, i64 3, !dbg !88
  %mul322.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !89
  %78 = tail call contract noundef float @llvm.minnum.f32(float %mul322.3, float 0x4024CB5EC0000000), !dbg !90
  %79 = tail call contract noundef float @llvm.exp.f32(float %78), !dbg !93
  %80 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %73), !dbg !96
  %81 = insertelement <4 x i16> poison, i16 %80, i64 0, !dbg !105
  %82 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %75), !dbg !96
  %83 = insertelement <4 x i16> %81, i16 %82, i64 1, !dbg !105
  %84 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %77), !dbg !96
  %85 = insertelement <4 x i16> %83, i16 %84, i64 2, !dbg !105
  %86 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %79), !dbg !96
  %87 = insertelement <4 x i16> %85, i16 %86, i64 3, !dbg !105
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %87 to <4 x half>, !dbg !105
  %88 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %60, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !106, !call_argsrelate !107
  %89 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %61, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !106, !call_argsrelate !107
  %90 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %64, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !106, !call_argsrelate !107
  %91 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %67, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !106, !call_argsrelate !107
  br label %if.end374, !dbg !108

if.end374:                                        ; preds = %if.end287, %if.end225
  %acc_o.sroa.98.0 = phi <4 x float> [ zeroinitializer, %if.end225 ], [ %91, %if.end287 ], !dbg !85
  %acc_o.sroa.66.0 = phi <4 x float> [ zeroinitializer, %if.end225 ], [ %90, %if.end287 ], !dbg !85
  %acc_o.sroa.34.0 = phi <4 x float> [ zeroinitializer, %if.end225 ], [ %89, %if.end287 ], !dbg !85
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end225 ], [ %88, %if.end287 ], !dbg !85
  %sum_acc.sroa.56.0 = phi float [ 0.000000e+00, %if.end225 ], [ %79, %if.end287 ], !dbg !85
  %sum_acc.sroa.38.0 = phi float [ 0.000000e+00, %if.end225 ], [ %77, %if.end287 ], !dbg !85
  %sum_acc.sroa.20.0 = phi float [ 0.000000e+00, %if.end225 ], [ %75, %if.end287 ], !dbg !85
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %if.end225 ], [ %73, %if.end287 ], !dbg !85
  br i1 %or.cond1289, label %if.end524, label %for.cond382.preheader, !dbg !108

for.cond382.preheader:                            ; preds = %if.end374
  %92 = shl nsw i32 %cond.i.i1211.1, 10
  %mul390 = and i32 %92, 64512
  %add394 = add nuw nsw i32 %add104, %mul390
  %idxprom400 = zext nneg i32 %add394 to i64, !dbg !109
  %arrayidx401 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom400, !dbg !109
  %93 = load <4 x half>, ptr addrspace(4) %arrayidx401, align 2, !dbg !110, !tbaa !62
  %add397.4 = or disjoint i32 %add394, 4, !dbg !111
  %idxprom400.4 = zext nneg i32 %add397.4 to i64, !dbg !109
  %arrayidx401.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom400.4, !dbg !109
  %94 = load <4 x half>, ptr addrspace(4) %arrayidx401.4, align 2, !dbg !110, !tbaa !62
  %95 = zext nneg i32 %add394 to i64, !dbg !109
  %96 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %95, !dbg !109
  %arrayidx401.8 = getelementptr inbounds i8, ptr addrspace(4) %96, i64 1024, !dbg !109
  %97 = load <4 x half>, ptr addrspace(4) %arrayidx401.8, align 2, !dbg !110, !tbaa !62
  %98 = zext nneg i32 %add394 to i64, !dbg !109
  %99 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %98, !dbg !109
  %arrayidx401.12 = getelementptr inbounds i8, ptr addrspace(4) %99, i64 1032, !dbg !109
  %100 = load <4 x half>, ptr addrspace(4) %arrayidx401.12, align 2, !dbg !110, !tbaa !62
  %cmp411 = icmp sgt i32 %mul11.1, %invariant.op, !dbg !112
  br i1 %cmp411, label %for.cond413.preheader, label %if.end437, !dbg !113

for.cond413.preheader:                            ; preds = %for.cond382.preheader
  %add420 = add nuw nsw i32 %mul11.1, %mul270
  %cmp423.not = icmp sgt i32 %add420, %1, !dbg !114
  %fneg.1200 = select i1 %cmp423.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1468 = insertelement <4 x float> poison, float %fneg.1200, i64 0, !dbg !115
  %cmp423.not.1.not = icmp slt i32 %add420, %1, !dbg !114
  %fneg.1200.1 = select i1 %cmp423.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1569 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1468, float %fneg.1200.1, i64 1, !dbg !115
  %add421.2 = or disjoint i32 %add420, 2, !dbg !116
  %cmp423.not.2 = icmp sgt i32 %add421.2, %1, !dbg !114
  %fneg.1200.2 = select i1 %cmp423.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1662 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1569, float %fneg.1200.2, i64 2, !dbg !115
  %add421.3 = or disjoint i32 %add420, 3, !dbg !116
  %cmp423.not.3 = icmp sgt i32 %add421.3, %1, !dbg !114
  %fneg.1200.3 = select i1 %cmp423.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1755 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1662, float %fneg.1200.3, i64 3, !dbg !115
  br label %if.end437

if.end437:                                        ; preds = %for.cond382.preheader, %for.cond413.preheader
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1755, %for.cond413.preheader ], [ zeroinitializer, %for.cond382.preheader ], !dbg !85
  %101 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.2), !dbg !117, !call_argsrelate !87
  %102 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.12.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %101), !dbg !117, !call_argsrelate !87
  %103 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.22.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %102), !dbg !117, !call_argsrelate !87
  %104 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.32.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %103), !dbg !117, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract1470 = extractelement <4 x float> %104, i64 0, !dbg !118
  %mul472 = fmul contract float %acc_s.sroa.0.0.vec.extract1470, 0x3FB99999A0000000, !dbg !119
  %105 = tail call contract noundef float @llvm.minnum.f32(float %mul472, float 0x4024CB5EC0000000), !dbg !120
  %106 = tail call contract noundef float @llvm.exp.f32(float %105), !dbg !122
  %acc_s.sroa.0.4.vec.extract1571 = extractelement <4 x float> %104, i64 1, !dbg !118
  %mul472.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1571, 0x3FB99999A0000000, !dbg !119
  %107 = tail call contract noundef float @llvm.minnum.f32(float %mul472.1, float 0x4024CB5EC0000000), !dbg !120
  %108 = tail call contract noundef float @llvm.exp.f32(float %107), !dbg !122
  %acc_s.sroa.0.8.vec.extract1664 = extractelement <4 x float> %104, i64 2, !dbg !118
  %mul472.2 = fmul contract float %acc_s.sroa.0.8.vec.extract1664, 0x3FB99999A0000000, !dbg !119
  %109 = tail call contract noundef float @llvm.minnum.f32(float %mul472.2, float 0x4024CB5EC0000000), !dbg !120
  %110 = tail call contract noundef float @llvm.exp.f32(float %109), !dbg !122
  %acc_s.sroa.0.12.vec.extract1757 = extractelement <4 x float> %104, i64 3, !dbg !118
  %mul472.3 = fmul contract float %acc_s.sroa.0.12.vec.extract1757, 0x3FB99999A0000000, !dbg !119
  %111 = tail call contract noundef float @llvm.minnum.f32(float %mul472.3, float 0x4024CB5EC0000000), !dbg !120
  %112 = tail call contract noundef float @llvm.exp.f32(float %111), !dbg !122
  %add488 = fadd contract float %sum_acc.sroa.0.0, %106, !dbg !124
  %add488.1 = fadd contract float %sum_acc.sroa.20.0, %108, !dbg !124
  %add488.2 = fadd contract float %sum_acc.sroa.38.0, %110, !dbg !124
  %add488.3 = fadd contract float %sum_acc.sroa.56.0, %112, !dbg !124
  %113 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %106), !dbg !125
  %114 = insertelement <4 x i16> poison, i16 %113, i64 0, !dbg !129
  %115 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %108), !dbg !125
  %116 = insertelement <4 x i16> %114, i16 %115, i64 1, !dbg !129
  %117 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %110), !dbg !125
  %118 = insertelement <4 x i16> %116, i16 %117, i64 2, !dbg !129
  %119 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %112), !dbg !125
  %120 = insertelement <4 x i16> %118, i16 %119, i64 3, !dbg !129
  %acc_s_cast.sroa.0.6.vec.insert1431 = bitcast <4 x i16> %120 to <4 x half>, !dbg !129
  %121 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %93, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1431, <4 x float> zeroinitializer), !dbg !130, !call_argsrelate !107
  %122 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %94, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1431, <4 x float> zeroinitializer), !dbg !130, !call_argsrelate !107
  %123 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %97, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1431, <4 x float> zeroinitializer), !dbg !130, !call_argsrelate !107
  %124 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %100, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1431, <4 x float> zeroinitializer), !dbg !130, !call_argsrelate !107
  br label %if.end524, !dbg !131

if.end524:                                        ; preds = %if.end437, %if.end374
  %acc_o_alt.sroa.50.0 = phi <4 x float> [ zeroinitializer, %if.end374 ], [ %124, %if.end437 ], !dbg !85
  %acc_o_alt.sroa.34.0 = phi <4 x float> [ zeroinitializer, %if.end374 ], [ %123, %if.end437 ], !dbg !85
  %acc_o_alt.sroa.18.0 = phi <4 x float> [ zeroinitializer, %if.end374 ], [ %122, %if.end437 ], !dbg !85
  %acc_o_alt.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end374 ], [ %121, %if.end437 ], !dbg !85
  %sum_acc.sroa.56.1 = phi float [ %sum_acc.sroa.56.0, %if.end374 ], [ %add488.3, %if.end437 ], !dbg !85
  %sum_acc.sroa.38.1 = phi float [ %sum_acc.sroa.38.0, %if.end374 ], [ %add488.2, %if.end437 ], !dbg !85
  %sum_acc.sroa.20.1 = phi float [ %sum_acc.sroa.20.0, %if.end374 ], [ %add488.1, %if.end437 ], !dbg !85
  %sum_acc.sroa.0.1 = phi float [ %sum_acc.sroa.0.0, %if.end374 ], [ %add488, %if.end437 ], !dbg !85
  br i1 %or.cond1291, label %if.end674, label %for.cond532.preheader, !dbg !131

for.cond532.preheader:                            ; preds = %if.end524
  %125 = shl nsw i32 %cond.i.i1211.2, 10
  %mul540 = and i32 %125, 64512
  %add544 = add nuw nsw i32 %add104, %mul540
  %idxprom550 = zext nneg i32 %add544 to i64, !dbg !132
  %arrayidx551 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom550, !dbg !132
  %126 = load <4 x half>, ptr addrspace(4) %arrayidx551, align 2, !dbg !133, !tbaa !62
  %add547.4 = or disjoint i32 %add544, 4, !dbg !134
  %idxprom550.4 = zext nneg i32 %add547.4 to i64, !dbg !132
  %arrayidx551.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom550.4, !dbg !132
  %127 = load <4 x half>, ptr addrspace(4) %arrayidx551.4, align 2, !dbg !133, !tbaa !62
  %128 = zext nneg i32 %add544 to i64, !dbg !132
  %129 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %128, !dbg !132
  %arrayidx551.8 = getelementptr inbounds i8, ptr addrspace(4) %129, i64 1024, !dbg !132
  %130 = load <4 x half>, ptr addrspace(4) %arrayidx551.8, align 2, !dbg !133, !tbaa !62
  %131 = zext nneg i32 %add544 to i64, !dbg !132
  %132 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %131, !dbg !132
  %arrayidx551.12 = getelementptr inbounds i8, ptr addrspace(4) %132, i64 1032, !dbg !132
  %133 = load <4 x half>, ptr addrspace(4) %arrayidx551.12, align 2, !dbg !133, !tbaa !62
  %cmp561 = icmp sgt i32 %mul11.2, %invariant.op, !dbg !135
  br i1 %cmp561, label %for.cond563.preheader, label %if.end587, !dbg !136

for.cond563.preheader:                            ; preds = %for.cond532.preheader
  %add570 = add nuw nsw i32 %mul11.2, %mul270
  %cmp573.not = icmp sgt i32 %add570, %1, !dbg !137
  %fneg.1201 = select i1 %cmp573.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1478 = insertelement <4 x float> poison, float %fneg.1201, i64 0, !dbg !138
  %cmp573.not.1.not = icmp slt i32 %add570, %1, !dbg !137
  %fneg.1201.1 = select i1 %cmp573.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1579 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1478, float %fneg.1201.1, i64 1, !dbg !138
  %add571.2 = or disjoint i32 %add570, 2, !dbg !139
  %cmp573.not.2 = icmp sgt i32 %add571.2, %1, !dbg !137
  %fneg.1201.2 = select i1 %cmp573.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1672 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1579, float %fneg.1201.2, i64 2, !dbg !138
  %add571.3 = or disjoint i32 %add570, 3, !dbg !139
  %cmp573.not.3 = icmp sgt i32 %add571.3, %1, !dbg !137
  %fneg.1201.3 = select i1 %cmp573.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1765 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1672, float %fneg.1201.3, i64 3, !dbg !138
  br label %if.end587

if.end587:                                        ; preds = %for.cond532.preheader, %for.cond563.preheader
  %acc_s.sroa.0.4 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1765, %for.cond563.preheader ], [ zeroinitializer, %for.cond532.preheader ], !dbg !85
  %134 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.4), !dbg !140, !call_argsrelate !87
  %135 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.12.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %134), !dbg !140, !call_argsrelate !87
  %136 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.22.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %135), !dbg !140, !call_argsrelate !87
  %137 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.32.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %136), !dbg !140, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract1480 = extractelement <4 x float> %137, i64 0, !dbg !141
  %mul622 = fmul contract float %acc_s.sroa.0.0.vec.extract1480, 0x3FB99999A0000000, !dbg !142
  %138 = tail call contract noundef float @llvm.minnum.f32(float %mul622, float 0x4024CB5EC0000000), !dbg !143
  %139 = tail call contract noundef float @llvm.exp.f32(float %138), !dbg !145
  %acc_s.sroa.0.4.vec.extract1581 = extractelement <4 x float> %137, i64 1, !dbg !141
  %mul622.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1581, 0x3FB99999A0000000, !dbg !142
  %140 = tail call contract noundef float @llvm.minnum.f32(float %mul622.1, float 0x4024CB5EC0000000), !dbg !143
  %141 = tail call contract noundef float @llvm.exp.f32(float %140), !dbg !145
  %acc_s.sroa.0.8.vec.extract1674 = extractelement <4 x float> %137, i64 2, !dbg !141
  %mul622.2 = fmul contract float %acc_s.sroa.0.8.vec.extract1674, 0x3FB99999A0000000, !dbg !142
  %142 = tail call contract noundef float @llvm.minnum.f32(float %mul622.2, float 0x4024CB5EC0000000), !dbg !143
  %143 = tail call contract noundef float @llvm.exp.f32(float %142), !dbg !145
  %acc_s.sroa.0.12.vec.extract1767 = extractelement <4 x float> %137, i64 3, !dbg !141
  %mul622.3 = fmul contract float %acc_s.sroa.0.12.vec.extract1767, 0x3FB99999A0000000, !dbg !142
  %144 = tail call contract noundef float @llvm.minnum.f32(float %mul622.3, float 0x4024CB5EC0000000), !dbg !143
  %145 = tail call contract noundef float @llvm.exp.f32(float %144), !dbg !145
  %add638 = fadd contract float %sum_acc.sroa.0.1, %139, !dbg !147
  %add638.1 = fadd contract float %sum_acc.sroa.20.1, %141, !dbg !147
  %add638.2 = fadd contract float %sum_acc.sroa.38.1, %143, !dbg !147
  %add638.3 = fadd contract float %sum_acc.sroa.56.1, %145, !dbg !147
  %146 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %139), !dbg !148
  %147 = insertelement <4 x i16> poison, i16 %146, i64 0, !dbg !152
  %148 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %141), !dbg !148
  %149 = insertelement <4 x i16> %147, i16 %148, i64 1, !dbg !152
  %150 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %143), !dbg !148
  %151 = insertelement <4 x i16> %149, i16 %150, i64 2, !dbg !152
  %152 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %145), !dbg !148
  %153 = insertelement <4 x i16> %151, i16 %152, i64 3, !dbg !152
  %acc_s_cast.sroa.0.6.vec.insert1433 = bitcast <4 x i16> %153 to <4 x half>, !dbg !152
  %154 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %126, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1433, <4 x float> %acc_o.sroa.0.0), !dbg !153, !call_argsrelate !107
  %155 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %127, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1433, <4 x float> %acc_o.sroa.34.0), !dbg !153, !call_argsrelate !107
  %156 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %130, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1433, <4 x float> %acc_o.sroa.66.0), !dbg !153, !call_argsrelate !107
  %157 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %133, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1433, <4 x float> %acc_o.sroa.98.0), !dbg !153, !call_argsrelate !107
  br label %if.end674, !dbg !154

if.end674:                                        ; preds = %if.end587, %if.end524
  %acc_o.sroa.98.1 = phi <4 x float> [ %acc_o.sroa.98.0, %if.end524 ], [ %157, %if.end587 ], !dbg !85
  %acc_o.sroa.66.1 = phi <4 x float> [ %acc_o.sroa.66.0, %if.end524 ], [ %156, %if.end587 ], !dbg !85
  %acc_o.sroa.34.1 = phi <4 x float> [ %acc_o.sroa.34.0, %if.end524 ], [ %155, %if.end587 ], !dbg !85
  %acc_o.sroa.0.1 = phi <4 x float> [ %acc_o.sroa.0.0, %if.end524 ], [ %154, %if.end587 ], !dbg !85
  %sum_acc.sroa.56.2 = phi float [ %sum_acc.sroa.56.1, %if.end524 ], [ %add638.3, %if.end587 ], !dbg !85
  %sum_acc.sroa.38.2 = phi float [ %sum_acc.sroa.38.1, %if.end524 ], [ %add638.2, %if.end587 ], !dbg !85
  %sum_acc.sroa.20.2 = phi float [ %sum_acc.sroa.20.1, %if.end524 ], [ %add638.1, %if.end587 ], !dbg !85
  %sum_acc.sroa.0.2 = phi float [ %sum_acc.sroa.0.1, %if.end524 ], [ %add638, %if.end587 ], !dbg !85
  br i1 %or.cond1293, label %if.end824, label %for.cond682.preheader, !dbg !154

for.cond682.preheader:                            ; preds = %if.end674
  %158 = shl nsw i32 %cond.i.i1211.3, 10
  %mul690 = and i32 %158, 64512
  %add694 = add nuw nsw i32 %add104, %mul690
  %idxprom700 = zext nneg i32 %add694 to i64, !dbg !155
  %arrayidx701 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom700, !dbg !155
  %159 = load <4 x half>, ptr addrspace(4) %arrayidx701, align 2, !dbg !156, !tbaa !62
  %add697.4 = or disjoint i32 %add694, 4, !dbg !157
  %idxprom700.4 = zext nneg i32 %add697.4 to i64, !dbg !155
  %arrayidx701.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom700.4, !dbg !155
  %160 = load <4 x half>, ptr addrspace(4) %arrayidx701.4, align 2, !dbg !156, !tbaa !62
  %161 = zext nneg i32 %add694 to i64, !dbg !155
  %162 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %161, !dbg !155
  %arrayidx701.8 = getelementptr inbounds i8, ptr addrspace(4) %162, i64 1024, !dbg !155
  %163 = load <4 x half>, ptr addrspace(4) %arrayidx701.8, align 2, !dbg !156, !tbaa !62
  %164 = zext nneg i32 %add694 to i64, !dbg !155
  %165 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %164, !dbg !155
  %arrayidx701.12 = getelementptr inbounds i8, ptr addrspace(4) %165, i64 1032, !dbg !155
  %166 = load <4 x half>, ptr addrspace(4) %arrayidx701.12, align 2, !dbg !156, !tbaa !62
  %cmp711 = icmp sgt i32 %mul11.3, %invariant.op, !dbg !158
  br i1 %cmp711, label %for.cond713.preheader, label %if.end737, !dbg !159

for.cond713.preheader:                            ; preds = %for.cond682.preheader
  %add720 = add nuw nsw i32 %mul11.3, %mul270
  %cmp723.not = icmp sgt i32 %add720, %1, !dbg !160
  %fneg.1202 = select i1 %cmp723.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1488 = insertelement <4 x float> poison, float %fneg.1202, i64 0, !dbg !161
  %cmp723.not.1.not = icmp slt i32 %add720, %1, !dbg !160
  %fneg.1202.1 = select i1 %cmp723.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1589 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1488, float %fneg.1202.1, i64 1, !dbg !161
  %add721.2 = or disjoint i32 %add720, 2, !dbg !162
  %cmp723.not.2 = icmp sgt i32 %add721.2, %1, !dbg !160
  %fneg.1202.2 = select i1 %cmp723.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1682 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1589, float %fneg.1202.2, i64 2, !dbg !161
  %add721.3 = or disjoint i32 %add720, 3, !dbg !162
  %cmp723.not.3 = icmp sgt i32 %add721.3, %1, !dbg !160
  %fneg.1202.3 = select i1 %cmp723.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1775 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1682, float %fneg.1202.3, i64 3, !dbg !161
  br label %if.end737

if.end737:                                        ; preds = %for.cond682.preheader, %for.cond713.preheader
  %acc_s.sroa.0.6 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1775, %for.cond713.preheader ], [ zeroinitializer, %for.cond682.preheader ], !dbg !85
  %167 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.6), !dbg !163, !call_argsrelate !87
  %168 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.12.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %167), !dbg !163, !call_argsrelate !87
  %169 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.22.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %168), !dbg !163, !call_argsrelate !87
  %170 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.32.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %169), !dbg !163, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract1490 = extractelement <4 x float> %170, i64 0, !dbg !164
  %mul772 = fmul contract float %acc_s.sroa.0.0.vec.extract1490, 0x3FB99999A0000000, !dbg !165
  %171 = tail call contract noundef float @llvm.minnum.f32(float %mul772, float 0x4024CB5EC0000000), !dbg !166
  %172 = tail call contract noundef float @llvm.exp.f32(float %171), !dbg !168
  %acc_s.sroa.0.4.vec.extract1591 = extractelement <4 x float> %170, i64 1, !dbg !164
  %mul772.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1591, 0x3FB99999A0000000, !dbg !165
  %173 = tail call contract noundef float @llvm.minnum.f32(float %mul772.1, float 0x4024CB5EC0000000), !dbg !166
  %174 = tail call contract noundef float @llvm.exp.f32(float %173), !dbg !168
  %acc_s.sroa.0.8.vec.extract1684 = extractelement <4 x float> %170, i64 2, !dbg !164
  %mul772.2 = fmul contract float %acc_s.sroa.0.8.vec.extract1684, 0x3FB99999A0000000, !dbg !165
  %175 = tail call contract noundef float @llvm.minnum.f32(float %mul772.2, float 0x4024CB5EC0000000), !dbg !166
  %176 = tail call contract noundef float @llvm.exp.f32(float %175), !dbg !168
  %acc_s.sroa.0.12.vec.extract1777 = extractelement <4 x float> %170, i64 3, !dbg !164
  %mul772.3 = fmul contract float %acc_s.sroa.0.12.vec.extract1777, 0x3FB99999A0000000, !dbg !165
  %177 = tail call contract noundef float @llvm.minnum.f32(float %mul772.3, float 0x4024CB5EC0000000), !dbg !166
  %178 = tail call contract noundef float @llvm.exp.f32(float %177), !dbg !168
  %add788 = fadd contract float %sum_acc.sroa.0.2, %172, !dbg !170
  %add788.1 = fadd contract float %sum_acc.sroa.20.2, %174, !dbg !170
  %add788.2 = fadd contract float %sum_acc.sroa.38.2, %176, !dbg !170
  %add788.3 = fadd contract float %sum_acc.sroa.56.2, %178, !dbg !170
  %179 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %172), !dbg !171
  %180 = insertelement <4 x i16> poison, i16 %179, i64 0, !dbg !175
  %181 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %174), !dbg !171
  %182 = insertelement <4 x i16> %180, i16 %181, i64 1, !dbg !175
  %183 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %176), !dbg !171
  %184 = insertelement <4 x i16> %182, i16 %183, i64 2, !dbg !175
  %185 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %178), !dbg !171
  %186 = insertelement <4 x i16> %184, i16 %185, i64 3, !dbg !175
  %acc_s_cast.sroa.0.6.vec.insert1435 = bitcast <4 x i16> %186 to <4 x half>, !dbg !175
  %187 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %159, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1435, <4 x float> %acc_o_alt.sroa.0.0), !dbg !176, !call_argsrelate !107
  %188 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %160, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1435, <4 x float> %acc_o_alt.sroa.18.0), !dbg !176, !call_argsrelate !107
  %189 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %163, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1435, <4 x float> %acc_o_alt.sroa.34.0), !dbg !176, !call_argsrelate !107
  %190 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %166, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1435, <4 x float> %acc_o_alt.sroa.50.0), !dbg !176, !call_argsrelate !107
  br label %if.end824, !dbg !177

if.end824:                                        ; preds = %if.end737, %if.end674
  %acc_o_alt.sroa.50.1 = phi <4 x float> [ %acc_o_alt.sroa.50.0, %if.end674 ], [ %190, %if.end737 ], !dbg !85
  %acc_o_alt.sroa.34.1 = phi <4 x float> [ %acc_o_alt.sroa.34.0, %if.end674 ], [ %189, %if.end737 ], !dbg !85
  %acc_o_alt.sroa.18.1 = phi <4 x float> [ %acc_o_alt.sroa.18.0, %if.end674 ], [ %188, %if.end737 ], !dbg !85
  %acc_o_alt.sroa.0.1 = phi <4 x float> [ %acc_o_alt.sroa.0.0, %if.end674 ], [ %187, %if.end737 ], !dbg !85
  %sum_acc.sroa.56.3 = phi float [ %sum_acc.sroa.56.2, %if.end674 ], [ %add788.3, %if.end737 ], !dbg !85
  %sum_acc.sroa.38.3 = phi float [ %sum_acc.sroa.38.2, %if.end674 ], [ %add788.2, %if.end737 ], !dbg !85
  %sum_acc.sroa.20.3 = phi float [ %sum_acc.sroa.20.2, %if.end674 ], [ %add788.1, %if.end737 ], !dbg !85
  %sum_acc.sroa.0.3 = phi float [ %sum_acc.sroa.0.2, %if.end674 ], [ %add788, %if.end737 ], !dbg !85
  %or.cond.1 = icmp ugt i32 %mul11.4, 1023, !dbg !59
  %cmp94.not.1 = icmp sgt i32 %mul11.4, %1
  %or.cond1287.1 = or i1 %or.cond.1, %cmp94.not.1, !dbg !59
  br i1 %or.cond1287.1, label %if.end.1, label %for.cond95.preheader.1, !dbg !59

for.cond95.preheader.1:                           ; preds = %if.end824
  %191 = shl nsw i32 %cond.i.i1211.4, 10
  %mul103.1 = and i32 %191, 64512
  %add107.1 = add nuw nsw i32 %add104, %mul103.1
  %idxprom113.11319 = zext nneg i32 %add107.1 to i64, !dbg !60
  %arrayidx114.11320 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom113.11319, !dbg !60
  %192 = load <4 x half>, ptr addrspace(4) %arrayidx114.11320, align 2, !dbg !61, !tbaa !62
  %add110.4.1 = or disjoint i32 %add107.1, 4, !dbg !63
  %idxprom113.4.1 = zext nneg i32 %add110.4.1 to i64, !dbg !60
  %arrayidx114.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom113.4.1, !dbg !60
  %193 = load <4 x half>, ptr addrspace(4) %arrayidx114.4.1, align 2, !dbg !61, !tbaa !62
  %194 = zext nneg i32 %add107.1 to i64, !dbg !60
  %195 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %194, !dbg !60
  %arrayidx114.8.1 = getelementptr inbounds i8, ptr addrspace(4) %195, i64 1024, !dbg !60
  %196 = load <4 x half>, ptr addrspace(4) %arrayidx114.8.1, align 2, !dbg !61, !tbaa !62
  %197 = zext nneg i32 %add107.1 to i64, !dbg !60
  %198 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %197, !dbg !60
  %arrayidx114.12.1 = getelementptr inbounds i8, ptr addrspace(4) %198, i64 1032, !dbg !60
  %199 = load <4 x half>, ptr addrspace(4) %arrayidx114.12.1, align 2, !dbg !61, !tbaa !62
  br label %if.end.1, !dbg !64

if.end.1:                                         ; preds = %for.cond95.preheader.1, %if.end824
  %K_reg.sroa.32.1 = phi <4 x half> [ %K_reg.sroa.32.0, %if.end824 ], [ %199, %for.cond95.preheader.1 ]
  %K_reg.sroa.22.1 = phi <4 x half> [ %K_reg.sroa.22.0, %if.end824 ], [ %196, %for.cond95.preheader.1 ]
  %K_reg.sroa.12.1 = phi <4 x half> [ %K_reg.sroa.12.0, %if.end824 ], [ %193, %for.cond95.preheader.1 ]
  %K_reg.sroa.0.1 = phi <4 x half> [ %K_reg.sroa.0.0, %if.end824 ], [ %192, %for.cond95.preheader.1 ]
  %or.cond1288.1 = icmp ugt i32 %mul11.5, 1023, !dbg !64
  %cmp126.not.1 = icmp sgt i32 %mul11.5, %1
  %or.cond1289.1 = or i1 %or.cond1288.1, %cmp126.not.1, !dbg !64
  br i1 %or.cond1289.1, label %if.end155.1, label %for.cond128.preheader.1, !dbg !64

for.cond128.preheader.1:                          ; preds = %if.end.1
  %200 = shl nsw i32 %cond.i.i1211.5, 10
  %mul136.1 = and i32 %200, 64512
  %add140.1 = add nuw nsw i32 %add104, %mul136.1
  %idxprom146.11322 = zext nneg i32 %add140.1 to i64, !dbg !65
  %arrayidx147.11323 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom146.11322, !dbg !65
  %201 = load <4 x half>, ptr addrspace(4) %arrayidx147.11323, align 2, !dbg !66, !tbaa !62
  %add143.4.1 = or disjoint i32 %add140.1, 4, !dbg !67
  %idxprom146.4.1 = zext nneg i32 %add143.4.1 to i64, !dbg !65
  %arrayidx147.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom146.4.1, !dbg !65
  %202 = load <4 x half>, ptr addrspace(4) %arrayidx147.4.1, align 2, !dbg !66, !tbaa !62
  %203 = zext nneg i32 %add140.1 to i64, !dbg !65
  %204 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %203, !dbg !65
  %arrayidx147.8.1 = getelementptr inbounds i8, ptr addrspace(4) %204, i64 1024, !dbg !65
  %205 = load <4 x half>, ptr addrspace(4) %arrayidx147.8.1, align 2, !dbg !66, !tbaa !62
  %206 = zext nneg i32 %add140.1 to i64, !dbg !65
  %207 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %206, !dbg !65
  %arrayidx147.12.1 = getelementptr inbounds i8, ptr addrspace(4) %207, i64 1032, !dbg !65
  %208 = load <4 x half>, ptr addrspace(4) %arrayidx147.12.1, align 2, !dbg !66, !tbaa !62
  br label %if.end155.1, !dbg !68

if.end155.1:                                      ; preds = %for.cond128.preheader.1, %if.end.1
  %K_reg1.sroa.32.1 = phi <4 x half> [ %K_reg1.sroa.32.0, %if.end.1 ], [ %208, %for.cond128.preheader.1 ]
  %K_reg1.sroa.22.1 = phi <4 x half> [ %K_reg1.sroa.22.0, %if.end.1 ], [ %205, %for.cond128.preheader.1 ]
  %K_reg1.sroa.12.1 = phi <4 x half> [ %K_reg1.sroa.12.0, %if.end.1 ], [ %202, %for.cond128.preheader.1 ]
  %K_reg1.sroa.0.1 = phi <4 x half> [ %K_reg1.sroa.0.0, %if.end.1 ], [ %201, %for.cond128.preheader.1 ]
  %or.cond1290.1 = icmp ugt i32 %mul11.6, 1023, !dbg !68
  %cmp161.not.1 = icmp sgt i32 %mul11.6, %1
  %or.cond1291.1 = or i1 %or.cond1290.1, %cmp161.not.1, !dbg !68
  br i1 %or.cond1291.1, label %if.end190.1, label %for.cond163.preheader.1, !dbg !68

for.cond163.preheader.1:                          ; preds = %if.end155.1
  %209 = shl nsw i32 %cond.i.i1211.6, 10
  %mul171.1 = and i32 %209, 64512
  %add175.1 = add nuw nsw i32 %add104, %mul171.1
  %idxprom181.11325 = zext nneg i32 %add175.1 to i64, !dbg !69
  %arrayidx182.11326 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom181.11325, !dbg !69
  %210 = load <4 x half>, ptr addrspace(4) %arrayidx182.11326, align 2, !dbg !70, !tbaa !62
  %add178.4.1 = or disjoint i32 %add175.1, 4, !dbg !71
  %idxprom181.4.1 = zext nneg i32 %add178.4.1 to i64, !dbg !69
  %arrayidx182.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom181.4.1, !dbg !69
  %211 = load <4 x half>, ptr addrspace(4) %arrayidx182.4.1, align 2, !dbg !70, !tbaa !62
  %212 = zext nneg i32 %add175.1 to i64, !dbg !69
  %213 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %212, !dbg !69
  %arrayidx182.8.1 = getelementptr inbounds i8, ptr addrspace(4) %213, i64 1024, !dbg !69
  %214 = load <4 x half>, ptr addrspace(4) %arrayidx182.8.1, align 2, !dbg !70, !tbaa !62
  %215 = zext nneg i32 %add175.1 to i64, !dbg !69
  %216 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %215, !dbg !69
  %arrayidx182.12.1 = getelementptr inbounds i8, ptr addrspace(4) %216, i64 1032, !dbg !69
  %217 = load <4 x half>, ptr addrspace(4) %arrayidx182.12.1, align 2, !dbg !70, !tbaa !62
  br label %if.end190.1, !dbg !72

if.end190.1:                                      ; preds = %for.cond163.preheader.1, %if.end155.1
  %K_reg2.sroa.32.1 = phi <4 x half> [ %K_reg2.sroa.32.0, %if.end155.1 ], [ %217, %for.cond163.preheader.1 ]
  %K_reg2.sroa.22.1 = phi <4 x half> [ %K_reg2.sroa.22.0, %if.end155.1 ], [ %214, %for.cond163.preheader.1 ]
  %K_reg2.sroa.12.1 = phi <4 x half> [ %K_reg2.sroa.12.0, %if.end155.1 ], [ %211, %for.cond163.preheader.1 ]
  %K_reg2.sroa.0.1 = phi <4 x half> [ %K_reg2.sroa.0.0, %if.end155.1 ], [ %210, %for.cond163.preheader.1 ]
  %or.cond1292.1 = icmp ugt i32 %mul11.7, 1023, !dbg !72
  %cmp196.not.1 = icmp sgt i32 %mul11.7, %1
  %or.cond1293.1 = or i1 %or.cond1292.1, %cmp196.not.1, !dbg !72
  br i1 %or.cond1293.1, label %if.end225.1, label %for.cond198.preheader.1, !dbg !72

for.cond198.preheader.1:                          ; preds = %if.end190.1
  %218 = shl nsw i32 %cond.i.i1211.7, 10
  %mul206.1 = and i32 %218, 64512
  %add210.1 = add nuw nsw i32 %add104, %mul206.1
  %idxprom216.11328 = zext nneg i32 %add210.1 to i64, !dbg !73
  %arrayidx217.11329 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom216.11328, !dbg !73
  %219 = load <4 x half>, ptr addrspace(4) %arrayidx217.11329, align 2, !dbg !74, !tbaa !62
  %add213.4.1 = or disjoint i32 %add210.1, 4, !dbg !75
  %idxprom216.4.1 = zext nneg i32 %add213.4.1 to i64, !dbg !73
  %arrayidx217.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom216.4.1, !dbg !73
  %220 = load <4 x half>, ptr addrspace(4) %arrayidx217.4.1, align 2, !dbg !74, !tbaa !62
  %221 = zext nneg i32 %add210.1 to i64, !dbg !73
  %222 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %221, !dbg !73
  %arrayidx217.8.1 = getelementptr inbounds i8, ptr addrspace(4) %222, i64 1024, !dbg !73
  %223 = load <4 x half>, ptr addrspace(4) %arrayidx217.8.1, align 2, !dbg !74, !tbaa !62
  %224 = zext nneg i32 %add210.1 to i64, !dbg !73
  %225 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %224, !dbg !73
  %arrayidx217.12.1 = getelementptr inbounds i8, ptr addrspace(4) %225, i64 1032, !dbg !73
  %226 = load <4 x half>, ptr addrspace(4) %arrayidx217.12.1, align 2, !dbg !74, !tbaa !62
  br label %if.end225.1, !dbg !76

if.end225.1:                                      ; preds = %for.cond198.preheader.1, %if.end190.1
  %K_reg3.sroa.32.1 = phi <4 x half> [ %K_reg3.sroa.32.0, %if.end190.1 ], [ %226, %for.cond198.preheader.1 ]
  %K_reg3.sroa.22.1 = phi <4 x half> [ %K_reg3.sroa.22.0, %if.end190.1 ], [ %223, %for.cond198.preheader.1 ]
  %K_reg3.sroa.12.1 = phi <4 x half> [ %K_reg3.sroa.12.0, %if.end190.1 ], [ %220, %for.cond198.preheader.1 ]
  %K_reg3.sroa.0.1 = phi <4 x half> [ %K_reg3.sroa.0.0, %if.end190.1 ], [ %219, %for.cond198.preheader.1 ]
  br i1 %or.cond1287.1, label %if.end374.1, label %for.cond233.preheader.1, !dbg !76

for.cond233.preheader.1:                          ; preds = %if.end225.1
  %227 = shl nsw i32 %cond.i.i1211.4, 10
  %mul241.1 = and i32 %227, 64512
  %add245.1 = add nuw nsw i32 %add104, %mul241.1
  %idxprom251.11331 = zext nneg i32 %add245.1 to i64, !dbg !77
  %arrayidx252.11332 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom251.11331, !dbg !77
  %228 = load <4 x half>, ptr addrspace(4) %arrayidx252.11332, align 2, !dbg !78, !tbaa !62
  %add248.4.1 = or disjoint i32 %add245.1, 4, !dbg !79
  %idxprom251.4.1 = zext nneg i32 %add248.4.1 to i64, !dbg !77
  %arrayidx252.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom251.4.1, !dbg !77
  %229 = load <4 x half>, ptr addrspace(4) %arrayidx252.4.1, align 2, !dbg !78, !tbaa !62
  %230 = zext nneg i32 %add245.1 to i64, !dbg !77
  %231 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %230, !dbg !77
  %arrayidx252.8.1 = getelementptr inbounds i8, ptr addrspace(4) %231, i64 1024, !dbg !77
  %232 = load <4 x half>, ptr addrspace(4) %arrayidx252.8.1, align 2, !dbg !78, !tbaa !62
  %233 = zext nneg i32 %add245.1 to i64, !dbg !77
  %234 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %233, !dbg !77
  %arrayidx252.12.1 = getelementptr inbounds i8, ptr addrspace(4) %234, i64 1032, !dbg !77
  %235 = load <4 x half>, ptr addrspace(4) %arrayidx252.12.1, align 2, !dbg !78, !tbaa !62
  %cmp262.1 = icmp sgt i32 %mul11.4, %invariant.op, !dbg !80
  br i1 %cmp262.1, label %for.cond264.preheader.1, label %if.end287.1, !dbg !81

for.cond264.preheader.1:                          ; preds = %for.cond233.preheader.1
  %add271.1 = add nuw nsw i32 %mul11.4, %mul270
  %cmp274.not.11334 = icmp sgt i32 %add271.1, %1, !dbg !82
  %fneg..11335 = select i1 %cmp274.not.11334, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1500 = insertelement <4 x float> poison, float %fneg..11335, i64 0, !dbg !83
  %cmp274.not.1.1.not = icmp slt i32 %add271.1, %1, !dbg !82
  %fneg..1.1 = select i1 %cmp274.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1599 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1500, float %fneg..1.1, i64 1, !dbg !83
  %add272.2.1 = or disjoint i32 %add271.1, 2, !dbg !84
  %cmp274.not.2.1 = icmp sgt i32 %add272.2.1, %1, !dbg !82
  %fneg..2.1 = select i1 %cmp274.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1692 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1599, float %fneg..2.1, i64 2, !dbg !83
  %add272.3.1 = or disjoint i32 %add271.1, 3, !dbg !84
  %cmp274.not.3.1 = icmp sgt i32 %add272.3.1, %1, !dbg !82
  %fneg..3.1 = select i1 %cmp274.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1785 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1692, float %fneg..3.1, i64 3, !dbg !83
  br label %if.end287.1

if.end287.1:                                      ; preds = %for.cond233.preheader.1, %for.cond264.preheader.1
  %acc_s.sroa.0.8 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1785, %for.cond264.preheader.1 ], [ zeroinitializer, %for.cond233.preheader.1 ], !dbg !85
  %236 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.8), !dbg !86, !call_argsrelate !87
  %237 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.12.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %236), !dbg !86, !call_argsrelate !87
  %238 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.22.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %237), !dbg !86, !call_argsrelate !87
  %239 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.32.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %238), !dbg !86, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract1502 = extractelement <4 x float> %239, i64 0, !dbg !88
  %mul322.11339 = fmul contract float %acc_s.sroa.0.0.vec.extract1502, 0x3FB99999A0000000, !dbg !89
  %240 = tail call contract noundef float @llvm.minnum.f32(float %mul322.11339, float 0x4024CB5EC0000000), !dbg !90
  %241 = tail call contract noundef float @llvm.exp.f32(float %240), !dbg !93
  %acc_s.sroa.0.4.vec.extract1601 = extractelement <4 x float> %239, i64 1, !dbg !88
  %mul322.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1601, 0x3FB99999A0000000, !dbg !89
  %242 = tail call contract noundef float @llvm.minnum.f32(float %mul322.1.1, float 0x4024CB5EC0000000), !dbg !90
  %243 = tail call contract noundef float @llvm.exp.f32(float %242), !dbg !93
  %acc_s.sroa.0.8.vec.extract1694 = extractelement <4 x float> %239, i64 2, !dbg !88
  %mul322.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1694, 0x3FB99999A0000000, !dbg !89
  %244 = tail call contract noundef float @llvm.minnum.f32(float %mul322.2.1, float 0x4024CB5EC0000000), !dbg !90
  %245 = tail call contract noundef float @llvm.exp.f32(float %244), !dbg !93
  %acc_s.sroa.0.12.vec.extract1787 = extractelement <4 x float> %239, i64 3, !dbg !88
  %mul322.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1787, 0x3FB99999A0000000, !dbg !89
  %246 = tail call contract noundef float @llvm.minnum.f32(float %mul322.3.1, float 0x4024CB5EC0000000), !dbg !90
  %247 = tail call contract noundef float @llvm.exp.f32(float %246), !dbg !93
  %add338.11340 = fadd contract float %sum_acc.sroa.0.3, %241, !dbg !178
  %add338.1.1 = fadd contract float %sum_acc.sroa.20.3, %243, !dbg !178
  %add338.2.1 = fadd contract float %sum_acc.sroa.38.3, %245, !dbg !178
  %add338.3.1 = fadd contract float %sum_acc.sroa.56.3, %247, !dbg !178
  %248 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %241), !dbg !96
  %249 = insertelement <4 x i16> poison, i16 %248, i64 0, !dbg !105
  %250 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %243), !dbg !96
  %251 = insertelement <4 x i16> %249, i16 %250, i64 1, !dbg !105
  %252 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %245), !dbg !96
  %253 = insertelement <4 x i16> %251, i16 %252, i64 2, !dbg !105
  %254 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %247), !dbg !96
  %255 = insertelement <4 x i16> %253, i16 %254, i64 3, !dbg !105
  %acc_s_cast.sroa.0.6.vec.insert1437 = bitcast <4 x i16> %255 to <4 x half>, !dbg !105
  %256 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %228, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1437, <4 x float> %acc_o.sroa.0.1), !dbg !106, !call_argsrelate !107
  %257 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %229, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1437, <4 x float> %acc_o.sroa.34.1), !dbg !106, !call_argsrelate !107
  %258 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %232, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1437, <4 x float> %acc_o.sroa.66.1), !dbg !106, !call_argsrelate !107
  %259 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %235, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1437, <4 x float> %acc_o.sroa.98.1), !dbg !106, !call_argsrelate !107
  br label %if.end374.1, !dbg !108

if.end374.1:                                      ; preds = %if.end287.1, %if.end225.1
  %acc_o.sroa.98.2 = phi <4 x float> [ %acc_o.sroa.98.1, %if.end225.1 ], [ %259, %if.end287.1 ], !dbg !85
  %acc_o.sroa.66.2 = phi <4 x float> [ %acc_o.sroa.66.1, %if.end225.1 ], [ %258, %if.end287.1 ], !dbg !85
  %acc_o.sroa.34.2 = phi <4 x float> [ %acc_o.sroa.34.1, %if.end225.1 ], [ %257, %if.end287.1 ], !dbg !85
  %acc_o.sroa.0.2 = phi <4 x float> [ %acc_o.sroa.0.1, %if.end225.1 ], [ %256, %if.end287.1 ], !dbg !85
  %sum_acc.sroa.56.4 = phi float [ %sum_acc.sroa.56.3, %if.end225.1 ], [ %add338.3.1, %if.end287.1 ], !dbg !85
  %sum_acc.sroa.38.4 = phi float [ %sum_acc.sroa.38.3, %if.end225.1 ], [ %add338.2.1, %if.end287.1 ], !dbg !85
  %sum_acc.sroa.20.4 = phi float [ %sum_acc.sroa.20.3, %if.end225.1 ], [ %add338.1.1, %if.end287.1 ], !dbg !85
  %sum_acc.sroa.0.4 = phi float [ %sum_acc.sroa.0.3, %if.end225.1 ], [ %add338.11340, %if.end287.1 ], !dbg !85
  br i1 %or.cond1289.1, label %if.end524.1, label %for.cond382.preheader.1, !dbg !108

for.cond382.preheader.1:                          ; preds = %if.end374.1
  %260 = shl nsw i32 %cond.i.i1211.5, 10
  %mul390.1 = and i32 %260, 64512
  %add394.1 = add nuw nsw i32 %add104, %mul390.1
  %idxprom400.11341 = zext nneg i32 %add394.1 to i64, !dbg !109
  %arrayidx401.11342 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom400.11341, !dbg !109
  %261 = load <4 x half>, ptr addrspace(4) %arrayidx401.11342, align 2, !dbg !110, !tbaa !62
  %add397.4.1 = or disjoint i32 %add394.1, 4, !dbg !111
  %idxprom400.4.1 = zext nneg i32 %add397.4.1 to i64, !dbg !109
  %arrayidx401.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom400.4.1, !dbg !109
  %262 = load <4 x half>, ptr addrspace(4) %arrayidx401.4.1, align 2, !dbg !110, !tbaa !62
  %263 = zext nneg i32 %add394.1 to i64, !dbg !109
  %264 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %263, !dbg !109
  %arrayidx401.8.1 = getelementptr inbounds i8, ptr addrspace(4) %264, i64 1024, !dbg !109
  %265 = load <4 x half>, ptr addrspace(4) %arrayidx401.8.1, align 2, !dbg !110, !tbaa !62
  %266 = zext nneg i32 %add394.1 to i64, !dbg !109
  %267 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %266, !dbg !109
  %arrayidx401.12.1 = getelementptr inbounds i8, ptr addrspace(4) %267, i64 1032, !dbg !109
  %268 = load <4 x half>, ptr addrspace(4) %arrayidx401.12.1, align 2, !dbg !110, !tbaa !62
  %cmp411.1 = icmp sgt i32 %mul11.5, %invariant.op, !dbg !112
  br i1 %cmp411.1, label %for.cond413.preheader.1, label %if.end437.1, !dbg !113

for.cond413.preheader.1:                          ; preds = %for.cond382.preheader.1
  %add420.1 = add nuw nsw i32 %mul11.5, %mul270
  %cmp423.not.11344 = icmp sgt i32 %add420.1, %1, !dbg !114
  %fneg.1200.11345 = select i1 %cmp423.not.11344, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1512 = insertelement <4 x float> poison, float %fneg.1200.11345, i64 0, !dbg !115
  %cmp423.not.1.1.not = icmp slt i32 %add420.1, %1, !dbg !114
  %fneg.1200.1.1 = select i1 %cmp423.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1609 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1512, float %fneg.1200.1.1, i64 1, !dbg !115
  %add421.2.1 = or disjoint i32 %add420.1, 2, !dbg !116
  %cmp423.not.2.1 = icmp sgt i32 %add421.2.1, %1, !dbg !114
  %fneg.1200.2.1 = select i1 %cmp423.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1702 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1609, float %fneg.1200.2.1, i64 2, !dbg !115
  %add421.3.1 = or disjoint i32 %add420.1, 3, !dbg !116
  %cmp423.not.3.1 = icmp sgt i32 %add421.3.1, %1, !dbg !114
  %fneg.1200.3.1 = select i1 %cmp423.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1795 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1702, float %fneg.1200.3.1, i64 3, !dbg !115
  br label %if.end437.1

if.end437.1:                                      ; preds = %for.cond382.preheader.1, %for.cond413.preheader.1
  %acc_s.sroa.0.10 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1795, %for.cond413.preheader.1 ], [ zeroinitializer, %for.cond382.preheader.1 ], !dbg !85
  %269 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.10), !dbg !117, !call_argsrelate !87
  %270 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.12.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %269), !dbg !117, !call_argsrelate !87
  %271 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.22.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %270), !dbg !117, !call_argsrelate !87
  %272 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.32.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %271), !dbg !117, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract1514 = extractelement <4 x float> %272, i64 0, !dbg !118
  %mul472.11349 = fmul contract float %acc_s.sroa.0.0.vec.extract1514, 0x3FB99999A0000000, !dbg !119
  %273 = tail call contract noundef float @llvm.minnum.f32(float %mul472.11349, float 0x4024CB5EC0000000), !dbg !120
  %274 = tail call contract noundef float @llvm.exp.f32(float %273), !dbg !122
  %acc_s.sroa.0.4.vec.extract1611 = extractelement <4 x float> %272, i64 1, !dbg !118
  %mul472.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1611, 0x3FB99999A0000000, !dbg !119
  %275 = tail call contract noundef float @llvm.minnum.f32(float %mul472.1.1, float 0x4024CB5EC0000000), !dbg !120
  %276 = tail call contract noundef float @llvm.exp.f32(float %275), !dbg !122
  %acc_s.sroa.0.8.vec.extract1704 = extractelement <4 x float> %272, i64 2, !dbg !118
  %mul472.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1704, 0x3FB99999A0000000, !dbg !119
  %277 = tail call contract noundef float @llvm.minnum.f32(float %mul472.2.1, float 0x4024CB5EC0000000), !dbg !120
  %278 = tail call contract noundef float @llvm.exp.f32(float %277), !dbg !122
  %acc_s.sroa.0.12.vec.extract1797 = extractelement <4 x float> %272, i64 3, !dbg !118
  %mul472.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1797, 0x3FB99999A0000000, !dbg !119
  %279 = tail call contract noundef float @llvm.minnum.f32(float %mul472.3.1, float 0x4024CB5EC0000000), !dbg !120
  %280 = tail call contract noundef float @llvm.exp.f32(float %279), !dbg !122
  %add488.11350 = fadd contract float %sum_acc.sroa.0.4, %274, !dbg !124
  %add488.1.1 = fadd contract float %sum_acc.sroa.20.4, %276, !dbg !124
  %add488.2.1 = fadd contract float %sum_acc.sroa.38.4, %278, !dbg !124
  %add488.3.1 = fadd contract float %sum_acc.sroa.56.4, %280, !dbg !124
  %281 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %274), !dbg !125
  %282 = insertelement <4 x i16> poison, i16 %281, i64 0, !dbg !129
  %283 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %276), !dbg !125
  %284 = insertelement <4 x i16> %282, i16 %283, i64 1, !dbg !129
  %285 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %278), !dbg !125
  %286 = insertelement <4 x i16> %284, i16 %285, i64 2, !dbg !129
  %287 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %280), !dbg !125
  %288 = insertelement <4 x i16> %286, i16 %287, i64 3, !dbg !129
  %acc_s_cast.sroa.0.6.vec.insert1439 = bitcast <4 x i16> %288 to <4 x half>, !dbg !129
  %289 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %261, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1439, <4 x float> %acc_o_alt.sroa.0.1), !dbg !130, !call_argsrelate !107
  %290 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %262, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1439, <4 x float> %acc_o_alt.sroa.18.1), !dbg !130, !call_argsrelate !107
  %291 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %265, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1439, <4 x float> %acc_o_alt.sroa.34.1), !dbg !130, !call_argsrelate !107
  %292 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %268, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1439, <4 x float> %acc_o_alt.sroa.50.1), !dbg !130, !call_argsrelate !107
  br label %if.end524.1, !dbg !131

if.end524.1:                                      ; preds = %if.end437.1, %if.end374.1
  %acc_o_alt.sroa.50.2 = phi <4 x float> [ %acc_o_alt.sroa.50.1, %if.end374.1 ], [ %292, %if.end437.1 ], !dbg !85
  %acc_o_alt.sroa.34.2 = phi <4 x float> [ %acc_o_alt.sroa.34.1, %if.end374.1 ], [ %291, %if.end437.1 ], !dbg !85
  %acc_o_alt.sroa.18.2 = phi <4 x float> [ %acc_o_alt.sroa.18.1, %if.end374.1 ], [ %290, %if.end437.1 ], !dbg !85
  %acc_o_alt.sroa.0.2 = phi <4 x float> [ %acc_o_alt.sroa.0.1, %if.end374.1 ], [ %289, %if.end437.1 ], !dbg !85
  %sum_acc.sroa.56.5 = phi float [ %sum_acc.sroa.56.4, %if.end374.1 ], [ %add488.3.1, %if.end437.1 ], !dbg !85
  %sum_acc.sroa.38.5 = phi float [ %sum_acc.sroa.38.4, %if.end374.1 ], [ %add488.2.1, %if.end437.1 ], !dbg !85
  %sum_acc.sroa.20.5 = phi float [ %sum_acc.sroa.20.4, %if.end374.1 ], [ %add488.1.1, %if.end437.1 ], !dbg !85
  %sum_acc.sroa.0.5 = phi float [ %sum_acc.sroa.0.4, %if.end374.1 ], [ %add488.11350, %if.end437.1 ], !dbg !85
  br i1 %or.cond1291.1, label %if.end674.1, label %for.cond532.preheader.1, !dbg !131

for.cond532.preheader.1:                          ; preds = %if.end524.1
  %293 = shl nsw i32 %cond.i.i1211.6, 10
  %mul540.1 = and i32 %293, 64512
  %add544.1 = add nuw nsw i32 %add104, %mul540.1
  %idxprom550.11351 = zext nneg i32 %add544.1 to i64, !dbg !132
  %arrayidx551.11352 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom550.11351, !dbg !132
  %294 = load <4 x half>, ptr addrspace(4) %arrayidx551.11352, align 2, !dbg !133, !tbaa !62
  %add547.4.1 = or disjoint i32 %add544.1, 4, !dbg !134
  %idxprom550.4.1 = zext nneg i32 %add547.4.1 to i64, !dbg !132
  %arrayidx551.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom550.4.1, !dbg !132
  %295 = load <4 x half>, ptr addrspace(4) %arrayidx551.4.1, align 2, !dbg !133, !tbaa !62
  %296 = zext nneg i32 %add544.1 to i64, !dbg !132
  %297 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %296, !dbg !132
  %arrayidx551.8.1 = getelementptr inbounds i8, ptr addrspace(4) %297, i64 1024, !dbg !132
  %298 = load <4 x half>, ptr addrspace(4) %arrayidx551.8.1, align 2, !dbg !133, !tbaa !62
  %299 = zext nneg i32 %add544.1 to i64, !dbg !132
  %300 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %299, !dbg !132
  %arrayidx551.12.1 = getelementptr inbounds i8, ptr addrspace(4) %300, i64 1032, !dbg !132
  %301 = load <4 x half>, ptr addrspace(4) %arrayidx551.12.1, align 2, !dbg !133, !tbaa !62
  %cmp561.1 = icmp sgt i32 %mul11.6, %invariant.op, !dbg !135
  br i1 %cmp561.1, label %for.cond563.preheader.1, label %if.end587.1, !dbg !136

for.cond563.preheader.1:                          ; preds = %for.cond532.preheader.1
  %add570.1 = add nuw nsw i32 %mul11.6, %mul270
  %cmp573.not.11354 = icmp sgt i32 %add570.1, %1, !dbg !137
  %fneg.1201.11355 = select i1 %cmp573.not.11354, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1524 = insertelement <4 x float> poison, float %fneg.1201.11355, i64 0, !dbg !138
  %cmp573.not.1.1.not = icmp slt i32 %add570.1, %1, !dbg !137
  %fneg.1201.1.1 = select i1 %cmp573.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1619 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1524, float %fneg.1201.1.1, i64 1, !dbg !138
  %add571.2.1 = or disjoint i32 %add570.1, 2, !dbg !139
  %cmp573.not.2.1 = icmp sgt i32 %add571.2.1, %1, !dbg !137
  %fneg.1201.2.1 = select i1 %cmp573.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1712 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1619, float %fneg.1201.2.1, i64 2, !dbg !138
  %add571.3.1 = or disjoint i32 %add570.1, 3, !dbg !139
  %cmp573.not.3.1 = icmp sgt i32 %add571.3.1, %1, !dbg !137
  %fneg.1201.3.1 = select i1 %cmp573.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1805 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1712, float %fneg.1201.3.1, i64 3, !dbg !138
  br label %if.end587.1

if.end587.1:                                      ; preds = %for.cond532.preheader.1, %for.cond563.preheader.1
  %acc_s.sroa.0.12 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1805, %for.cond563.preheader.1 ], [ zeroinitializer, %for.cond532.preheader.1 ], !dbg !85
  %302 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.12), !dbg !140, !call_argsrelate !87
  %303 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.12.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %302), !dbg !140, !call_argsrelate !87
  %304 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.22.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %303), !dbg !140, !call_argsrelate !87
  %305 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.32.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %304), !dbg !140, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract1526 = extractelement <4 x float> %305, i64 0, !dbg !141
  %mul622.11359 = fmul contract float %acc_s.sroa.0.0.vec.extract1526, 0x3FB99999A0000000, !dbg !142
  %306 = tail call contract noundef float @llvm.minnum.f32(float %mul622.11359, float 0x4024CB5EC0000000), !dbg !143
  %307 = tail call contract noundef float @llvm.exp.f32(float %306), !dbg !145
  %acc_s.sroa.0.4.vec.extract1621 = extractelement <4 x float> %305, i64 1, !dbg !141
  %mul622.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1621, 0x3FB99999A0000000, !dbg !142
  %308 = tail call contract noundef float @llvm.minnum.f32(float %mul622.1.1, float 0x4024CB5EC0000000), !dbg !143
  %309 = tail call contract noundef float @llvm.exp.f32(float %308), !dbg !145
  %acc_s.sroa.0.8.vec.extract1714 = extractelement <4 x float> %305, i64 2, !dbg !141
  %mul622.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1714, 0x3FB99999A0000000, !dbg !142
  %310 = tail call contract noundef float @llvm.minnum.f32(float %mul622.2.1, float 0x4024CB5EC0000000), !dbg !143
  %311 = tail call contract noundef float @llvm.exp.f32(float %310), !dbg !145
  %acc_s.sroa.0.12.vec.extract1807 = extractelement <4 x float> %305, i64 3, !dbg !141
  %mul622.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1807, 0x3FB99999A0000000, !dbg !142
  %312 = tail call contract noundef float @llvm.minnum.f32(float %mul622.3.1, float 0x4024CB5EC0000000), !dbg !143
  %313 = tail call contract noundef float @llvm.exp.f32(float %312), !dbg !145
  %add638.11360 = fadd contract float %sum_acc.sroa.0.5, %307, !dbg !147
  %add638.1.1 = fadd contract float %sum_acc.sroa.20.5, %309, !dbg !147
  %add638.2.1 = fadd contract float %sum_acc.sroa.38.5, %311, !dbg !147
  %add638.3.1 = fadd contract float %sum_acc.sroa.56.5, %313, !dbg !147
  %314 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %307), !dbg !148
  %315 = insertelement <4 x i16> poison, i16 %314, i64 0, !dbg !152
  %316 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %309), !dbg !148
  %317 = insertelement <4 x i16> %315, i16 %316, i64 1, !dbg !152
  %318 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %311), !dbg !148
  %319 = insertelement <4 x i16> %317, i16 %318, i64 2, !dbg !152
  %320 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %313), !dbg !148
  %321 = insertelement <4 x i16> %319, i16 %320, i64 3, !dbg !152
  %acc_s_cast.sroa.0.6.vec.insert1441 = bitcast <4 x i16> %321 to <4 x half>, !dbg !152
  %322 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %294, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1441, <4 x float> %acc_o.sroa.0.2), !dbg !153, !call_argsrelate !107
  %323 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %295, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1441, <4 x float> %acc_o.sroa.34.2), !dbg !153, !call_argsrelate !107
  %324 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %298, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1441, <4 x float> %acc_o.sroa.66.2), !dbg !153, !call_argsrelate !107
  %325 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %301, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1441, <4 x float> %acc_o.sroa.98.2), !dbg !153, !call_argsrelate !107
  br label %if.end674.1, !dbg !154

if.end674.1:                                      ; preds = %if.end587.1, %if.end524.1
  %acc_o.sroa.98.3 = phi <4 x float> [ %acc_o.sroa.98.2, %if.end524.1 ], [ %325, %if.end587.1 ], !dbg !85
  %acc_o.sroa.66.3 = phi <4 x float> [ %acc_o.sroa.66.2, %if.end524.1 ], [ %324, %if.end587.1 ], !dbg !85
  %acc_o.sroa.34.3 = phi <4 x float> [ %acc_o.sroa.34.2, %if.end524.1 ], [ %323, %if.end587.1 ], !dbg !85
  %acc_o.sroa.0.3 = phi <4 x float> [ %acc_o.sroa.0.2, %if.end524.1 ], [ %322, %if.end587.1 ], !dbg !85
  %sum_acc.sroa.56.6 = phi float [ %sum_acc.sroa.56.5, %if.end524.1 ], [ %add638.3.1, %if.end587.1 ], !dbg !85
  %sum_acc.sroa.38.6 = phi float [ %sum_acc.sroa.38.5, %if.end524.1 ], [ %add638.2.1, %if.end587.1 ], !dbg !85
  %sum_acc.sroa.20.6 = phi float [ %sum_acc.sroa.20.5, %if.end524.1 ], [ %add638.1.1, %if.end587.1 ], !dbg !85
  %sum_acc.sroa.0.6 = phi float [ %sum_acc.sroa.0.5, %if.end524.1 ], [ %add638.11360, %if.end587.1 ], !dbg !85
  br i1 %or.cond1293.1, label %if.end824.1, label %for.cond682.preheader.1, !dbg !154

for.cond682.preheader.1:                          ; preds = %if.end674.1
  %326 = shl nsw i32 %cond.i.i1211.7, 10
  %mul690.1 = and i32 %326, 64512
  %add694.1 = add nuw nsw i32 %add104, %mul690.1
  %idxprom700.11361 = zext nneg i32 %add694.1 to i64, !dbg !155
  %arrayidx701.11362 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom700.11361, !dbg !155
  %327 = load <4 x half>, ptr addrspace(4) %arrayidx701.11362, align 2, !dbg !156, !tbaa !62
  %add697.4.1 = or disjoint i32 %add694.1, 4, !dbg !157
  %idxprom700.4.1 = zext nneg i32 %add697.4.1 to i64, !dbg !155
  %arrayidx701.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom700.4.1, !dbg !155
  %328 = load <4 x half>, ptr addrspace(4) %arrayidx701.4.1, align 2, !dbg !156, !tbaa !62
  %329 = zext nneg i32 %add694.1 to i64, !dbg !155
  %330 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %329, !dbg !155
  %arrayidx701.8.1 = getelementptr inbounds i8, ptr addrspace(4) %330, i64 1024, !dbg !155
  %331 = load <4 x half>, ptr addrspace(4) %arrayidx701.8.1, align 2, !dbg !156, !tbaa !62
  %332 = zext nneg i32 %add694.1 to i64, !dbg !155
  %333 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %332, !dbg !155
  %arrayidx701.12.1 = getelementptr inbounds i8, ptr addrspace(4) %333, i64 1032, !dbg !155
  %334 = load <4 x half>, ptr addrspace(4) %arrayidx701.12.1, align 2, !dbg !156, !tbaa !62
  %cmp711.1 = icmp sgt i32 %mul11.7, %invariant.op, !dbg !158
  br i1 %cmp711.1, label %for.cond713.preheader.1, label %if.end737.1, !dbg !159

for.cond713.preheader.1:                          ; preds = %for.cond682.preheader.1
  %add720.1 = add nuw nsw i32 %mul11.7, %mul270
  %cmp723.not.11364 = icmp sgt i32 %add720.1, %1, !dbg !160
  %fneg.1202.11365 = select i1 %cmp723.not.11364, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1536 = insertelement <4 x float> poison, float %fneg.1202.11365, i64 0, !dbg !161
  %cmp723.not.1.1.not = icmp slt i32 %add720.1, %1, !dbg !160
  %fneg.1202.1.1 = select i1 %cmp723.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1629 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1536, float %fneg.1202.1.1, i64 1, !dbg !161
  %add721.2.1 = or disjoint i32 %add720.1, 2, !dbg !162
  %cmp723.not.2.1 = icmp sgt i32 %add721.2.1, %1, !dbg !160
  %fneg.1202.2.1 = select i1 %cmp723.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1722 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1629, float %fneg.1202.2.1, i64 2, !dbg !161
  %add721.3.1 = or disjoint i32 %add720.1, 3, !dbg !162
  %cmp723.not.3.1 = icmp sgt i32 %add721.3.1, %1, !dbg !160
  %fneg.1202.3.1 = select i1 %cmp723.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1815 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1722, float %fneg.1202.3.1, i64 3, !dbg !161
  br label %if.end737.1

if.end737.1:                                      ; preds = %for.cond682.preheader.1, %for.cond713.preheader.1
  %acc_s.sroa.0.14 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1815, %for.cond713.preheader.1 ], [ zeroinitializer, %for.cond682.preheader.1 ], !dbg !85
  %335 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.14), !dbg !163, !call_argsrelate !87
  %336 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.12.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %335), !dbg !163, !call_argsrelate !87
  %337 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.22.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %336), !dbg !163, !call_argsrelate !87
  %338 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.32.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %337), !dbg !163, !call_argsrelate !87
  %acc_s.sroa.0.0.vec.extract1538 = extractelement <4 x float> %338, i64 0, !dbg !164
  %mul772.11369 = fmul contract float %acc_s.sroa.0.0.vec.extract1538, 0x3FB99999A0000000, !dbg !165
  %339 = tail call contract noundef float @llvm.minnum.f32(float %mul772.11369, float 0x4024CB5EC0000000), !dbg !166
  %340 = tail call contract noundef float @llvm.exp.f32(float %339), !dbg !168
  %acc_s.sroa.0.4.vec.extract1631 = extractelement <4 x float> %338, i64 1, !dbg !164
  %mul772.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1631, 0x3FB99999A0000000, !dbg !165
  %341 = tail call contract noundef float @llvm.minnum.f32(float %mul772.1.1, float 0x4024CB5EC0000000), !dbg !166
  %342 = tail call contract noundef float @llvm.exp.f32(float %341), !dbg !168
  %acc_s.sroa.0.8.vec.extract1724 = extractelement <4 x float> %338, i64 2, !dbg !164
  %mul772.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1724, 0x3FB99999A0000000, !dbg !165
  %343 = tail call contract noundef float @llvm.minnum.f32(float %mul772.2.1, float 0x4024CB5EC0000000), !dbg !166
  %344 = tail call contract noundef float @llvm.exp.f32(float %343), !dbg !168
  %acc_s.sroa.0.12.vec.extract1817 = extractelement <4 x float> %338, i64 3, !dbg !164
  %mul772.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1817, 0x3FB99999A0000000, !dbg !165
  %345 = tail call contract noundef float @llvm.minnum.f32(float %mul772.3.1, float 0x4024CB5EC0000000), !dbg !166
  %346 = tail call contract noundef float @llvm.exp.f32(float %345), !dbg !168
  %add788.11370 = fadd contract float %sum_acc.sroa.0.6, %340, !dbg !170
  %add788.1.1 = fadd contract float %sum_acc.sroa.20.6, %342, !dbg !170
  %add788.2.1 = fadd contract float %sum_acc.sroa.38.6, %344, !dbg !170
  %add788.3.1 = fadd contract float %sum_acc.sroa.56.6, %346, !dbg !170
  %347 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %340), !dbg !171
  %348 = insertelement <4 x i16> poison, i16 %347, i64 0, !dbg !175
  %349 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %342), !dbg !171
  %350 = insertelement <4 x i16> %348, i16 %349, i64 1, !dbg !175
  %351 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %344), !dbg !171
  %352 = insertelement <4 x i16> %350, i16 %351, i64 2, !dbg !175
  %353 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %346), !dbg !171
  %354 = insertelement <4 x i16> %352, i16 %353, i64 3, !dbg !175
  %acc_s_cast.sroa.0.6.vec.insert1443 = bitcast <4 x i16> %354 to <4 x half>, !dbg !175
  %355 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %327, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1443, <4 x float> %acc_o_alt.sroa.0.2), !dbg !176, !call_argsrelate !107
  %356 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %328, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1443, <4 x float> %acc_o_alt.sroa.18.2), !dbg !176, !call_argsrelate !107
  %357 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %331, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1443, <4 x float> %acc_o_alt.sroa.34.2), !dbg !176, !call_argsrelate !107
  %358 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %334, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1443, <4 x float> %acc_o_alt.sroa.50.2), !dbg !176, !call_argsrelate !107
  br label %if.end824.1, !dbg !177

if.end824.1:                                      ; preds = %if.end737.1, %if.end674.1
  %acc_o_alt.sroa.50.3 = phi <4 x float> [ %acc_o_alt.sroa.50.2, %if.end674.1 ], [ %358, %if.end737.1 ], !dbg !85
  %acc_o_alt.sroa.34.3 = phi <4 x float> [ %acc_o_alt.sroa.34.2, %if.end674.1 ], [ %357, %if.end737.1 ], !dbg !85
  %acc_o_alt.sroa.18.3 = phi <4 x float> [ %acc_o_alt.sroa.18.2, %if.end674.1 ], [ %356, %if.end737.1 ], !dbg !85
  %acc_o_alt.sroa.0.3 = phi <4 x float> [ %acc_o_alt.sroa.0.2, %if.end674.1 ], [ %355, %if.end737.1 ], !dbg !85
  %sum_acc.sroa.56.7 = phi float [ %sum_acc.sroa.56.6, %if.end674.1 ], [ %add788.3.1, %if.end737.1 ], !dbg !85
  %sum_acc.sroa.38.7 = phi float [ %sum_acc.sroa.38.6, %if.end674.1 ], [ %add788.2.1, %if.end737.1 ], !dbg !85
  %sum_acc.sroa.20.7 = phi float [ %sum_acc.sroa.20.6, %if.end674.1 ], [ %add788.1.1, %if.end737.1 ], !dbg !85
  %sum_acc.sroa.0.7 = phi float [ %sum_acc.sroa.0.6, %if.end674.1 ], [ %add788.11370, %if.end737.1 ], !dbg !85
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 0, !dbg !179
  %acc_o_alt.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 0, !dbg !180
  %add836 = fadd contract float %acc_o.sroa.0.0.vec.extract, %acc_o_alt.sroa.0.0.vec.extract, !dbg !181
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 1, !dbg !179
  %acc_o_alt.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 1, !dbg !180
  %add836.1 = fadd contract float %acc_o.sroa.0.4.vec.extract, %acc_o_alt.sroa.0.4.vec.extract, !dbg !181
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 2, !dbg !179
  %acc_o_alt.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 2, !dbg !180
  %add836.2 = fadd contract float %acc_o.sroa.0.8.vec.extract, %acc_o_alt.sroa.0.8.vec.extract, !dbg !181
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 3, !dbg !179
  %acc_o_alt.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 3, !dbg !180
  %add836.3 = fadd contract float %acc_o.sroa.0.12.vec.extract, %acc_o_alt.sroa.0.12.vec.extract, !dbg !181
  %acc_o.sroa.34.16.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 0, !dbg !179
  %acc_o_alt.sroa.18.16.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 0, !dbg !180
  %add836.4 = fadd contract float %acc_o.sroa.34.16.vec.extract, %acc_o_alt.sroa.18.16.vec.extract, !dbg !181
  %acc_o.sroa.34.20.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 1, !dbg !179
  %acc_o_alt.sroa.18.20.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 1, !dbg !180
  %add836.5 = fadd contract float %acc_o.sroa.34.20.vec.extract, %acc_o_alt.sroa.18.20.vec.extract, !dbg !181
  %acc_o.sroa.34.24.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 2, !dbg !179
  %acc_o_alt.sroa.18.24.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 2, !dbg !180
  %add836.6 = fadd contract float %acc_o.sroa.34.24.vec.extract, %acc_o_alt.sroa.18.24.vec.extract, !dbg !181
  %acc_o.sroa.34.28.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 3, !dbg !179
  %acc_o_alt.sroa.18.28.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 3, !dbg !180
  %add836.7 = fadd contract float %acc_o.sroa.34.28.vec.extract, %acc_o_alt.sroa.18.28.vec.extract, !dbg !181
  %acc_o.sroa.66.32.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 0, !dbg !179
  %acc_o_alt.sroa.34.32.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 0, !dbg !180
  %add836.8 = fadd contract float %acc_o.sroa.66.32.vec.extract, %acc_o_alt.sroa.34.32.vec.extract, !dbg !181
  %acc_o.sroa.66.36.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 1, !dbg !179
  %acc_o_alt.sroa.34.36.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 1, !dbg !180
  %add836.9 = fadd contract float %acc_o.sroa.66.36.vec.extract, %acc_o_alt.sroa.34.36.vec.extract, !dbg !181
  %acc_o.sroa.66.40.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 2, !dbg !179
  %acc_o_alt.sroa.34.40.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 2, !dbg !180
  %add836.10 = fadd contract float %acc_o.sroa.66.40.vec.extract, %acc_o_alt.sroa.34.40.vec.extract, !dbg !181
  %acc_o.sroa.66.44.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 3, !dbg !179
  %acc_o_alt.sroa.34.44.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 3, !dbg !180
  %add836.11 = fadd contract float %acc_o.sroa.66.44.vec.extract, %acc_o_alt.sroa.34.44.vec.extract, !dbg !181
  %acc_o.sroa.98.48.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 0, !dbg !179
  %acc_o_alt.sroa.50.48.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 0, !dbg !180
  %add836.12 = fadd contract float %acc_o.sroa.98.48.vec.extract, %acc_o_alt.sroa.50.48.vec.extract, !dbg !181
  %acc_o.sroa.98.52.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 1, !dbg !179
  %acc_o_alt.sroa.50.52.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 1, !dbg !180
  %add836.13 = fadd contract float %acc_o.sroa.98.52.vec.extract, %acc_o_alt.sroa.50.52.vec.extract, !dbg !181
  %acc_o.sroa.98.56.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 2, !dbg !179
  %acc_o_alt.sroa.50.56.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 2, !dbg !180
  %add836.14 = fadd contract float %acc_o.sroa.98.56.vec.extract, %acc_o_alt.sroa.50.56.vec.extract, !dbg !181
  %acc_o.sroa.98.60.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 3, !dbg !179
  %acc_o_alt.sroa.50.60.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 3, !dbg !180
  %add836.15 = fadd contract float %acc_o.sroa.98.60.vec.extract, %acc_o_alt.sroa.50.60.vec.extract, !dbg !181
  %add850 = fadd contract float %sum_acc.sroa.0.7, 0.000000e+00, !dbg !182
  %add850.1 = fadd contract float %add850, %sum_acc.sroa.20.7, !dbg !182
  %add850.2 = fadd contract float %add850.1, %sum_acc.sroa.38.7, !dbg !182
  %add850.3 = fadd contract float %add850.2, %sum_acc.sroa.56.7, !dbg !182
  %359 = bitcast float %add850.3 to i32, !dbg !183
  %360 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !195
  %361 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %360) #11, !dbg !200
  %xor.i.i = xor i32 %361, 32, !dbg !201
  %362 = and i32 %361, -64, !dbg !202
  %and.i.i = add nsw i32 %362, 64, !dbg !202
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !203
  %cond.i.i1212 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %361, !dbg !204
  %shl.i.i = shl i32 %cond.i.i1212, 2, !dbg !205
  %363 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %359), !dbg !206
  %364 = bitcast i32 %363 to float, !dbg !207
  %add.i = fadd contract float %add850.3, %364, !dbg !208
  %365 = bitcast float %add.i to i32, !dbg !211
  %366 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !218
  %367 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %366) #11, !dbg !221
  %xor.i.i1213 = xor i32 %367, 16, !dbg !222
  %368 = and i32 %367, -64, !dbg !223
  %and.i.i1214 = add nsw i32 %368, 64, !dbg !223
  %cmp.not.i.i1215 = icmp slt i32 %xor.i.i1213, %and.i.i1214, !dbg !224
  %cond.i.i1216 = select i1 %cmp.not.i.i1215, i32 %xor.i.i1213, i32 %367, !dbg !225
  %shl.i.i1217 = shl i32 %cond.i.i1216, 2, !dbg !226
  %369 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i1217, i32 %365), !dbg !227
  %370 = bitcast i32 %369 to float, !dbg !228
  %add.i.i = fadd contract float %add.i, %370, !dbg !229
  %cmp859 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !231
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !232
  %condval_4.0 = select i1 %cmp859, float %div, float 0.000000e+00, !dbg !232
  %mul872 = fmul contract float %condval_4.0, %add836, !dbg !233
  %mul872.1 = fmul contract float %condval_4.0, %add836.1, !dbg !233
  %mul872.2 = fmul contract float %condval_4.0, %add836.2, !dbg !233
  %mul872.3 = fmul contract float %condval_4.0, %add836.3, !dbg !233
  %mul872.4 = fmul contract float %condval_4.0, %add836.4, !dbg !233
  %mul872.5 = fmul contract float %condval_4.0, %add836.5, !dbg !233
  %mul872.6 = fmul contract float %condval_4.0, %add836.6, !dbg !233
  %mul872.7 = fmul contract float %condval_4.0, %add836.7, !dbg !233
  %mul872.8 = fmul contract float %condval_4.0, %add836.8, !dbg !233
  %mul872.9 = fmul contract float %condval_4.0, %add836.9, !dbg !233
  %mul872.10 = fmul contract float %condval_4.0, %add836.10, !dbg !233
  %mul872.11 = fmul contract float %condval_4.0, %add836.11, !dbg !233
  %mul872.12 = fmul contract float %condval_4.0, %add836.12, !dbg !233
  %mul872.13 = fmul contract float %condval_4.0, %add836.13, !dbg !233
  %mul872.14 = fmul contract float %condval_4.0, %add836.14, !dbg !233
  %mul872.15 = fmul contract float %condval_4.0, %add836.15, !dbg !233
  %371 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872), !dbg !234
  %O_reg.sroa.0.0.insert.ext = zext i16 %371 to i64, !dbg !238
  %372 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872.1), !dbg !234
  %O_reg.sroa.0.2.insert.ext = zext i16 %372 to i64, !dbg !238
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !238
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !238
  %373 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872.2), !dbg !234
  %O_reg.sroa.0.4.insert.ext = zext i16 %373 to i64, !dbg !238
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !238
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !238
  %374 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872.3), !dbg !234
  %O_reg.sroa.0.6.insert.ext = zext i16 %374 to i64, !dbg !238
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !238
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !238
  %375 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872.4), !dbg !234
  %O_reg.sroa.7.8.insert.ext = zext i16 %375 to i64, !dbg !238
  %376 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872.5), !dbg !234
  %O_reg.sroa.7.10.insert.ext = zext i16 %376 to i64, !dbg !238
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !238
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !238
  %377 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872.6), !dbg !234
  %O_reg.sroa.7.12.insert.ext = zext i16 %377 to i64, !dbg !238
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !238
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !238
  %378 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872.7), !dbg !234
  %O_reg.sroa.7.14.insert.ext = zext i16 %378 to i64, !dbg !238
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !238
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !238
  %379 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872.8), !dbg !234
  %O_reg.sroa.12.16.insert.ext = zext i16 %379 to i64, !dbg !238
  %380 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872.9), !dbg !234
  %O_reg.sroa.12.18.insert.ext = zext i16 %380 to i64, !dbg !238
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !238
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !238
  %381 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872.10), !dbg !234
  %O_reg.sroa.12.20.insert.ext = zext i16 %381 to i64, !dbg !238
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !238
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !238
  %382 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872.11), !dbg !234
  %O_reg.sroa.12.22.insert.ext = zext i16 %382 to i64, !dbg !238
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !238
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !238
  %383 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872.12), !dbg !234
  %O_reg.sroa.17.24.insert.ext = zext i16 %383 to i64, !dbg !238
  %384 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872.13), !dbg !234
  %O_reg.sroa.17.26.insert.ext = zext i16 %384 to i64, !dbg !238
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !238
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !238
  %385 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872.14), !dbg !234
  %O_reg.sroa.17.28.insert.ext = zext i16 %385 to i64, !dbg !238
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !238
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !238
  %386 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul872.15), !dbg !234
  %O_reg.sroa.17.30.insert.ext = zext i16 %386 to i64, !dbg !238
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !238
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !238
  %shr914 = lshr i32 %18, 5
  %and917 = and i32 %18, 7
  %mul923 = and i32 %22, 4
  %xor = xor i32 %shr914, %and917, !dbg !239
  %mul918 = shl nuw nsw i32 %xor, 3, !dbg !240
  %add919 = add nuw nsw i32 %mul918, %mul25, !dbg !241
  %add924 = or disjoint i32 %add919, %mul923, !dbg !242
  %add.ptr926 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add924, !dbg !243
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr926, align 8, !dbg !244
  %add915.1 = add nuw nsw i32 %shr914, 2, !dbg !245
  %xor.1 = xor i32 %add915.1, %and917, !dbg !239
  %mul918.1 = shl nuw nsw i32 %xor.1, 3, !dbg !240
  %add919.1 = add nuw nsw i32 %mul918.1, %mul25, !dbg !241
  %add924.1 = or disjoint i32 %add919.1, %mul923, !dbg !242
  %add.ptr926.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add924.1, !dbg !243
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr926.1, align 8, !dbg !244
  %add915.2 = add nuw nsw i32 %shr914, 4, !dbg !245
  %xor.2 = xor i32 %add915.2, %and917, !dbg !239
  %mul918.2 = shl nuw nsw i32 %xor.2, 3, !dbg !240
  %add919.2 = add nuw nsw i32 %mul918.2, %mul25, !dbg !241
  %add924.2 = or disjoint i32 %add919.2, %mul923, !dbg !242
  %add.ptr926.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add924.2, !dbg !243
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr926.2, align 8, !dbg !244
  %add915.3 = add nuw nsw i32 %shr914, 6, !dbg !245
  %xor.3 = xor i32 %add915.3, %and917, !dbg !239
  %mul918.3 = shl nuw nsw i32 %xor.3, 3, !dbg !240
  %add919.3 = add nuw nsw i32 %mul918.3, %mul25, !dbg !241
  %add924.3 = or disjoint i32 %add919.3, %mul923, !dbg !242
  %add.ptr926.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add924.3, !dbg !243
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr926.3, align 8, !dbg !244
  fence syncscope("warp") release, !dbg !246
  tail call void @llvm.mxc.barrier.warp(), !dbg !251
  fence syncscope("warp") acquire, !dbg !252
  %mul937 = and i32 %mul109, 8128
  %xor9431198 = and i32 %mul109, 56
  %call941.masked = and i32 %18, 1016
  %mul944 = xor i32 %xor9431198, %call941.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul937, !dbg !253
  %invariant.gep1284 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul944, !dbg !253
  %add954 = add nuw nsw i32 %add23, %mul109
  %387 = zext nneg i32 %add954 to i64, !dbg !254
  %add.ptr959 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %387, !dbg !255
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr959, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep1284, i64 16, i1 false), !dbg !256, !tbaa.struct !257, !call_argsrelate !258
  %gep1285.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep1284, i32 1024, !dbg !259
  %388 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %387, !dbg !255
  %add.ptr959.1 = getelementptr inbounds i8, ptr addrspace(1) %388, i64 1024, !dbg !255
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr959.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep1285.1, i64 16, i1 false), !dbg !256, !tbaa.struct !257, !call_argsrelate !258
  ret void, !dbg !260
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

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp.f32(float) #6

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare i16 @llvm.convert.to.fp16.f32(float) #7

; Function Attrs: convergent nounwind willreturn
declare void @llvm.mxc.barrier.warp() #8

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.bsm.bpermute(i32, i32) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.lo(i32, i32) #4

; Function Attrs: convergent nounwind willreturn memory(none)
declare i32 @llvm.mxc.mbcnt.hi(i32, i32) #4

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.implicitarg.ptr() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare align 4 ptr addrspace(4) @llvm.mxc.dispatch.ptr() #5

; Function Attrs: nounwind speculatable willreturn memory(none)
declare i1 @llvm.mxc.is.private(ptr nocapture) #5

; Function Attrs: nounwind willreturn
declare void @llvm.mxc.sleep(i32 immarg) #9

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smax.i32(i32, i32) #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smin.i32(i32, i32) #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.minnum.f32(float, float) #6

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #10

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #7 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #8 = { convergent nounwind willreturn }
attributes #9 = { nounwind willreturn }
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #11 = { nomerge }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmpabf65qeo/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmpabf65qeo/tvm_kernels.maca", directory: "")
!42 = !DILocation(line: 28, column: 3, scope: !40)
!43 = !DILocation(line: 29, column: 21, scope: !40)
!44 = !DILocation(line: 705, column: 10, scope: !45, inlinedAt: !47)
!45 = distinct !DISubprogram(name: "max", scope: !46, file: !46, line: 704, type: !7, scopeLine: 704, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!46 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!47 = distinct !DILocation(line: 30, column: 24, scope: !40)
!48 = !{i32 0, i32 -1}
!49 = !DILocation(line: 708, column: 10, scope: !50, inlinedAt: !51)
!50 = distinct !DISubprogram(name: "min", scope: !46, file: !46, line: 707, type: !7, scopeLine: 707, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!51 = distinct !DILocation(line: 30, column: 20, scope: !40)
!52 = !DILocation(line: 30, column: 48, scope: !40)
!53 = !DILocation(line: 29, column: 90, scope: !40)
!54 = !{i32 0, i32 1024}
!55 = !DILocation(line: 33, column: 3, scope: !40)
!56 = !DILocation(line: 34, column: 46, scope: !40)
!57 = !DILocation(line: 34, column: 32, scope: !40)
!58 = !DILocation(line: 49, column: 3, scope: !40)
!59 = !DILocation(line: 54, column: 22, scope: !40)
!60 = !DILocation(line: 57, column: 30, scope: !40)
!61 = !DILocation(line: 57, column: 22, scope: !40)
!62 = !{!26, !26, i64 0}
!63 = !DILocation(line: 57, column: 110, scope: !40)
!64 = !DILocation(line: 60, column: 22, scope: !40)
!65 = !DILocation(line: 63, column: 31, scope: !40)
!66 = !DILocation(line: 63, column: 23, scope: !40)
!67 = !DILocation(line: 63, column: 111, scope: !40)
!68 = !DILocation(line: 66, column: 22, scope: !40)
!69 = !DILocation(line: 69, column: 31, scope: !40)
!70 = !DILocation(line: 69, column: 23, scope: !40)
!71 = !DILocation(line: 69, column: 111, scope: !40)
!72 = !DILocation(line: 72, column: 22, scope: !40)
!73 = !DILocation(line: 75, column: 31, scope: !40)
!74 = !DILocation(line: 75, column: 23, scope: !40)
!75 = !DILocation(line: 75, column: 111, scope: !40)
!76 = !DILocation(line: 78, column: 22, scope: !40)
!77 = !DILocation(line: 81, column: 30, scope: !40)
!78 = !DILocation(line: 81, column: 22, scope: !40)
!79 = !DILocation(line: 81, column: 110, scope: !40)
!80 = !DILocation(line: 83, column: 29, scope: !40)
!81 = !DILocation(line: 83, column: 11, scope: !40)
!82 = !DILocation(line: 87, column: 65, scope: !40)
!83 = !DILocation(line: 92, column: 22, scope: !40)
!84 = !DILocation(line: 87, column: 58, scope: !40)
!85 = !DILocation(line: 0, scope: !40)
!86 = !DILocation(line: 101, column: 36, scope: !40)
!87 = !{i32 -1, i32 3, i32 -1}
!88 = !DILocation(line: 109, column: 32, scope: !40)
!89 = !DILocation(line: 109, column: 43, scope: !40)
!90 = !DILocation(line: 354, column: 10, scope: !91, inlinedAt: !92)
!91 = distinct !DISubprogram(name: "min", scope: !46, file: !46, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!92 = distinct !DILocation(line: 109, column: 27, scope: !40)
!93 = !DILocation(line: 288, column: 10, scope: !94, inlinedAt: !95)
!94 = distinct !DISubprogram(name: "expf", scope: !46, file: !46, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!95 = distinct !DILocation(line: 109, column: 22, scope: !40)
!96 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !99)
!97 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !98, file: !98, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!98 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!99 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !102)
!100 = distinct !DISubprogram(name: "__float2half", scope: !101, file: !101, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!101 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!102 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !104)
!103 = distinct !DISubprogram(name: "__half", scope: !101, file: !101, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!104 = distinct !DILocation(line: 117, column: 34, scope: !40)
!105 = !DILocation(line: 117, column: 31, scope: !40)
!106 = !DILocation(line: 121, column: 36, scope: !40)
!107 = !{i32 4, i32 -1, i32 -1}
!108 = !DILocation(line: 127, column: 22, scope: !40)
!109 = !DILocation(line: 130, column: 31, scope: !40)
!110 = !DILocation(line: 130, column: 23, scope: !40)
!111 = !DILocation(line: 130, column: 112, scope: !40)
!112 = !DILocation(line: 132, column: 29, scope: !40)
!113 = !DILocation(line: 132, column: 11, scope: !40)
!114 = !DILocation(line: 136, column: 66, scope: !40)
!115 = !DILocation(line: 141, column: 23, scope: !40)
!116 = !DILocation(line: 136, column: 58, scope: !40)
!117 = !DILocation(line: 150, column: 36, scope: !40)
!118 = !DILocation(line: 158, column: 33, scope: !40)
!119 = !DILocation(line: 158, column: 45, scope: !40)
!120 = !DILocation(line: 354, column: 10, scope: !91, inlinedAt: !121)
!121 = distinct !DILocation(line: 158, column: 28, scope: !40)
!122 = !DILocation(line: 288, column: 10, scope: !94, inlinedAt: !123)
!123 = distinct !DILocation(line: 158, column: 23, scope: !40)
!124 = !DILocation(line: 162, column: 40, scope: !40)
!125 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !126)
!126 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !127)
!127 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !128)
!128 = distinct !DILocation(line: 166, column: 36, scope: !40)
!129 = !DILocation(line: 166, column: 33, scope: !40)
!130 = !DILocation(line: 170, column: 42, scope: !40)
!131 = !DILocation(line: 176, column: 22, scope: !40)
!132 = !DILocation(line: 179, column: 31, scope: !40)
!133 = !DILocation(line: 179, column: 23, scope: !40)
!134 = !DILocation(line: 179, column: 112, scope: !40)
!135 = !DILocation(line: 181, column: 29, scope: !40)
!136 = !DILocation(line: 181, column: 11, scope: !40)
!137 = !DILocation(line: 185, column: 66, scope: !40)
!138 = !DILocation(line: 190, column: 23, scope: !40)
!139 = !DILocation(line: 185, column: 58, scope: !40)
!140 = !DILocation(line: 199, column: 36, scope: !40)
!141 = !DILocation(line: 207, column: 33, scope: !40)
!142 = !DILocation(line: 207, column: 45, scope: !40)
!143 = !DILocation(line: 354, column: 10, scope: !91, inlinedAt: !144)
!144 = distinct !DILocation(line: 207, column: 28, scope: !40)
!145 = !DILocation(line: 288, column: 10, scope: !94, inlinedAt: !146)
!146 = distinct !DILocation(line: 207, column: 23, scope: !40)
!147 = !DILocation(line: 211, column: 40, scope: !40)
!148 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !149)
!149 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !150)
!150 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !151)
!151 = distinct !DILocation(line: 215, column: 36, scope: !40)
!152 = !DILocation(line: 215, column: 33, scope: !40)
!153 = !DILocation(line: 219, column: 38, scope: !40)
!154 = !DILocation(line: 225, column: 22, scope: !40)
!155 = !DILocation(line: 228, column: 31, scope: !40)
!156 = !DILocation(line: 228, column: 23, scope: !40)
!157 = !DILocation(line: 228, column: 112, scope: !40)
!158 = !DILocation(line: 230, column: 29, scope: !40)
!159 = !DILocation(line: 230, column: 11, scope: !40)
!160 = !DILocation(line: 234, column: 66, scope: !40)
!161 = !DILocation(line: 239, column: 23, scope: !40)
!162 = !DILocation(line: 234, column: 58, scope: !40)
!163 = !DILocation(line: 248, column: 36, scope: !40)
!164 = !DILocation(line: 256, column: 33, scope: !40)
!165 = !DILocation(line: 256, column: 45, scope: !40)
!166 = !DILocation(line: 354, column: 10, scope: !91, inlinedAt: !167)
!167 = distinct !DILocation(line: 256, column: 28, scope: !40)
!168 = !DILocation(line: 288, column: 10, scope: !94, inlinedAt: !169)
!169 = distinct !DILocation(line: 256, column: 23, scope: !40)
!170 = !DILocation(line: 260, column: 40, scope: !40)
!171 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !172)
!172 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !173)
!173 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !174)
!174 = distinct !DILocation(line: 264, column: 36, scope: !40)
!175 = !DILocation(line: 264, column: 33, scope: !40)
!176 = !DILocation(line: 268, column: 42, scope: !40)
!177 = !DILocation(line: 49, column: 34, scope: !40)
!178 = !DILocation(line: 113, column: 40, scope: !40)
!179 = !DILocation(line: 277, column: 20, scope: !40)
!180 = !DILocation(line: 277, column: 34, scope: !40)
!181 = !DILocation(line: 277, column: 32, scope: !40)
!182 = !DILocation(line: 282, column: 36, scope: !40)
!183 = !DILocation(line: 1018, column: 9, scope: !184, inlinedAt: !186)
!184 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !185, file: !185, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!185 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!186 = distinct !DILocation(line: 396, column: 10, scope: !187, inlinedAt: !189)
!187 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !188, file: !188, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!188 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!189 = distinct !DILocation(line: 129, column: 24, scope: !190, inlinedAt: !192)
!190 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !191, file: !191, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!191 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!192 = distinct !DILocation(line: 101, column: 14, scope: !193, inlinedAt: !194)
!193 = distinct !DISubprogram(name: "run<float>", scope: !191, file: !191, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!194 = distinct !DILocation(line: 284, column: 19, scope: !40)
!195 = !DILocation(line: 171, column: 37, scope: !196, inlinedAt: !197)
!196 = distinct !DISubprogram(name: "__lane_id", scope: !185, file: !185, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!197 = distinct !DILocation(line: 990, column: 14, scope: !198, inlinedAt: !199)
!198 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !185, file: !185, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!199 = distinct !DILocation(line: 1019, column: 11, scope: !184, inlinedAt: !186)
!200 = !DILocation(line: 171, column: 10, scope: !196, inlinedAt: !197)
!201 = !DILocation(line: 991, column: 20, scope: !198, inlinedAt: !199)
!202 = !DILocation(line: 992, column: 36, scope: !198, inlinedAt: !199)
!203 = !DILocation(line: 992, column: 17, scope: !198, inlinedAt: !199)
!204 = !DILocation(line: 992, column: 11, scope: !198, inlinedAt: !199)
!205 = !DILocation(line: 993, column: 43, scope: !198, inlinedAt: !199)
!206 = !DILocation(line: 993, column: 10, scope: !198, inlinedAt: !199)
!207 = !DILocation(line: 1020, column: 14, scope: !184, inlinedAt: !186)
!208 = !DILocation(line: 25, column: 14, scope: !209, inlinedAt: !210)
!209 = distinct !DISubprogram(name: "operator()<float>", scope: !191, file: !191, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!210 = distinct !DILocation(line: 129, column: 11, scope: !190, inlinedAt: !192)
!211 = !DILocation(line: 1018, column: 9, scope: !184, inlinedAt: !212)
!212 = distinct !DILocation(line: 396, column: 10, scope: !187, inlinedAt: !213)
!213 = distinct !DILocation(line: 129, column: 24, scope: !214, inlinedAt: !215)
!214 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !191, file: !191, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!215 = distinct !DILocation(line: 101, column: 14, scope: !216, inlinedAt: !217)
!216 = distinct !DISubprogram(name: "run<float>", scope: !191, file: !191, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!217 = distinct !DILocation(line: 134, column: 14, scope: !190, inlinedAt: !192)
!218 = !DILocation(line: 171, column: 37, scope: !196, inlinedAt: !219)
!219 = distinct !DILocation(line: 990, column: 14, scope: !198, inlinedAt: !220)
!220 = distinct !DILocation(line: 1019, column: 11, scope: !184, inlinedAt: !212)
!221 = !DILocation(line: 171, column: 10, scope: !196, inlinedAt: !219)
!222 = !DILocation(line: 991, column: 20, scope: !198, inlinedAt: !220)
!223 = !DILocation(line: 992, column: 36, scope: !198, inlinedAt: !220)
!224 = !DILocation(line: 992, column: 17, scope: !198, inlinedAt: !220)
!225 = !DILocation(line: 992, column: 11, scope: !198, inlinedAt: !220)
!226 = !DILocation(line: 993, column: 43, scope: !198, inlinedAt: !220)
!227 = !DILocation(line: 993, column: 10, scope: !198, inlinedAt: !220)
!228 = !DILocation(line: 1020, column: 14, scope: !184, inlinedAt: !212)
!229 = !DILocation(line: 25, column: 14, scope: !209, inlinedAt: !230)
!230 = distinct !DILocation(line: 129, column: 11, scope: !214, inlinedAt: !215)
!231 = !DILocation(line: 286, column: 32, scope: !40)
!232 = !DILocation(line: 286, column: 7, scope: !40)
!233 = !DILocation(line: 294, column: 32, scope: !40)
!234 = !DILocation(line: 75, column: 10, scope: !97, inlinedAt: !235)
!235 = distinct !DILocation(line: 984, column: 9, scope: !100, inlinedAt: !236)
!236 = distinct !DILocation(line: 133, column: 53, scope: !103, inlinedAt: !237)
!237 = distinct !DILocation(line: 300, column: 50, scope: !40)
!238 = !DILocation(line: 300, column: 47, scope: !40)
!239 = !DILocation(line: 305, column: 122, scope: !40)
!240 = !DILocation(line: 305, column: 150, scope: !40)
!241 = !DILocation(line: 305, column: 77, scope: !40)
!242 = !DILocation(line: 305, column: 156, scope: !40)
!243 = !DILocation(line: 305, column: 40, scope: !40)
!244 = !DILocation(line: 305, column: 199, scope: !40)
!245 = !DILocation(line: 305, column: 93, scope: !40)
!246 = !DILocation(line: 68, column: 3, scope: !247, inlinedAt: !248)
!247 = distinct !DISubprogram(name: "__barrier_warp", scope: !185, file: !185, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!248 = distinct !DILocation(line: 192, column: 3, scope: !249, inlinedAt: !250)
!249 = distinct !DISubprogram(name: "__syncwarp", scope: !185, file: !185, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!250 = distinct !DILocation(line: 307, column: 3, scope: !40)
!251 = !DILocation(line: 69, column: 3, scope: !247, inlinedAt: !248)
!252 = !DILocation(line: 70, column: 3, scope: !247, inlinedAt: !248)
!253 = !DILocation(line: 309, column: 8, scope: !40)
!254 = !DILocation(line: 309, column: 3, scope: !40)
!255 = !DILocation(line: 310, column: 22, scope: !40)
!256 = !DILocation(line: 310, column: 132, scope: !40)
!257 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!258 = !{i32 2, i32 -1, i32 -1, i32 -1}
!259 = !DILocation(line: 310, column: 169, scope: !40)
!260 = !DILocation(line: 312, column: 1, scope: !40)
