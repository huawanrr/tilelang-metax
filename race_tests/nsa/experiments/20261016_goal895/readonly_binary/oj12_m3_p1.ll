; ModuleID = 'experiments/20261016_goal895/readonly_binary/oj12_m3_p1.bc'
source_filename = "/tmp/tmppkutkuz_/tvm_kernels.maca"
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
  %arrayidx.val = load i32, ptr addrspace(1) %arrayidx, align 4, !dbg !44, !tbaa !30
  %cond.i.i = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %arrayidx.val, i32 -1), !dbg !45, !call_argsrelate !49
  %cond.i.i1212 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64), !dbg !50
  %mul12 = shl nsw i32 %cond.i.i1212, 4, !dbg !53
  %3 = or disjoint i64 %2, 1, !dbg !54
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %3, !dbg !43
  %arrayidx.val.1 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !dbg !44, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %arrayidx.val.1, i32 -1), !dbg !45, !call_argsrelate !49
  %cond.i.i1212.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64), !dbg !50
  %mul12.1 = shl nsw i32 %cond.i.i1212.1, 4, !dbg !53
  %4 = or disjoint i64 %2, 2, !dbg !54
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4, !dbg !43
  %arrayidx.val.2 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !dbg !44, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %arrayidx.val.2, i32 -1), !dbg !45, !call_argsrelate !49
  %cond.i.i1212.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64), !dbg !50
  %mul12.2 = shl nsw i32 %cond.i.i1212.2, 4, !dbg !53
  %5 = or disjoint i64 %2, 3, !dbg !54
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %5, !dbg !43
  %arrayidx.val.3 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !dbg !44, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %arrayidx.val.3, i32 -1), !dbg !45, !call_argsrelate !49
  %cond.i.i1212.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64), !dbg !50
  %mul12.3 = shl nsw i32 %cond.i.i1212.3, 4, !dbg !53
  %6 = or disjoint i64 %2, 4, !dbg !54
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6, !dbg !43
  %arrayidx.val.4 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !dbg !44, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %arrayidx.val.4, i32 -1), !dbg !45, !call_argsrelate !49
  %cond.i.i1212.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64), !dbg !50
  %mul12.4 = shl nsw i32 %cond.i.i1212.4, 4, !dbg !53
  %7 = or disjoint i64 %2, 5, !dbg !54
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %7, !dbg !43
  %arrayidx.val.5 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !dbg !44, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %arrayidx.val.5, i32 -1), !dbg !45, !call_argsrelate !49
  %cond.i.i1212.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64), !dbg !50
  %mul12.5 = shl nsw i32 %cond.i.i1212.5, 4, !dbg !53
  %8 = or disjoint i64 %2, 6, !dbg !54
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8, !dbg !43
  %arrayidx.val.6 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !dbg !44, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %arrayidx.val.6, i32 -1), !dbg !45, !call_argsrelate !49
  %cond.i.i1212.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64), !dbg !50
  %mul12.6 = shl nsw i32 %cond.i.i1212.6, 4, !dbg !53
  %9 = or disjoint i64 %2, 7, !dbg !54
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %9, !dbg !43
  %arrayidx.val.7 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !dbg !44, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %arrayidx.val.7, i32 -1), !dbg !45, !call_argsrelate !49
  %cond.i.i1212.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64), !dbg !50
  %mul12.7 = shl nsw i32 %cond.i.i1212.7, 4, !dbg !53
  %mul21 = shl nsw i32 %0, 20
  %mul23 = shl nsw i32 %1, 10
  %add24 = add nuw nsw i32 %mul21, %mul23
  %10 = tail call noundef range(i32 0, 1024) i32 @llvm.mxc.thread.id.x(), !range !55
  %and = shl nuw nsw i32 %10, 6
  %mul26 = and i32 %and, 960
  %add27 = or disjoint i32 %add24, %mul26
  %11 = lshr i32 %10, 1
  %mul31 = and i32 %11, 504
  %add29 = add nuw nsw i32 %add27, %mul31
  %12 = zext nneg i32 %add29 to i64, !dbg !56
  %add.ptr = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %12, !dbg !57
  %Q_reg.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16, !dbg !58
  %Q_reg.sroa.11.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !58
  %Q_reg.sroa.11.0.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.11.0.add.ptr.sroa_idx, align 8, !dbg !58
  %13 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %12, !dbg !57
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %13, i64 64, !dbg !57
  %Q_reg.sroa.19.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16, !dbg !58
  %Q_reg.sroa.28.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %13, i64 72, !dbg !58
  %Q_reg.sroa.28.16.copyload = load <4 x half>, ptr addrspace(4) %Q_reg.sroa.28.16.add.ptr.1.sroa_idx, align 8, !dbg !58
  %mul102 = shl nsw i32 %0, 16
  %mul110 = shl nuw nsw i32 %10, 3
  %add105 = or disjoint i32 %mul110, %mul102
  %invariant.op = add nsw i32 %1, -15, !dbg !59
  %14 = lshr i32 %10, 2
  %mul271 = and i32 %14, 252
  %or.cond = icmp ugt i32 %mul12, 1023, !dbg !60
  %cmp95.not = icmp sgt i32 %mul12, %1
  %or.cond1288 = or i1 %or.cond, %cmp95.not, !dbg !60
  br i1 %or.cond1288, label %if.end, label %for.cond96.preheader, !dbg !60

for.cond96.preheader:                             ; preds = %entry
  %15 = shl nsw i32 %cond.i.i1212, 10
  %mul104 = and i32 %15, 64512
  %add108 = add nuw nsw i32 %add105, %mul104
  %idxprom114 = zext nneg i32 %add108 to i64, !dbg !61
  %arrayidx115 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom114, !dbg !61
  %16 = load <4 x half>, ptr addrspace(4) %arrayidx115, align 2, !dbg !62, !tbaa !63
  %add111.4 = or disjoint i32 %add108, 4, !dbg !64
  %idxprom114.4 = zext nneg i32 %add111.4 to i64, !dbg !61
  %arrayidx115.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom114.4, !dbg !61
  %17 = load <4 x half>, ptr addrspace(4) %arrayidx115.4, align 2, !dbg !62, !tbaa !63
  %18 = zext nneg i32 %add108 to i64, !dbg !61
  %19 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %18, !dbg !61
  %arrayidx115.8 = getelementptr inbounds i8, ptr addrspace(4) %19, i64 1024, !dbg !61
  %20 = load <4 x half>, ptr addrspace(4) %arrayidx115.8, align 2, !dbg !62, !tbaa !63
  %21 = zext nneg i32 %add108 to i64, !dbg !61
  %22 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %21, !dbg !61
  %arrayidx115.12 = getelementptr inbounds i8, ptr addrspace(4) %22, i64 1032, !dbg !61
  %23 = load <4 x half>, ptr addrspace(4) %arrayidx115.12, align 2, !dbg !62, !tbaa !63
  br label %if.end, !dbg !65

if.end:                                           ; preds = %for.cond96.preheader, %entry
  %K_reg.sroa.32.0 = phi <4 x half> [ undef, %entry ], [ %23, %for.cond96.preheader ]
  %K_reg.sroa.22.0 = phi <4 x half> [ undef, %entry ], [ %20, %for.cond96.preheader ]
  %K_reg.sroa.12.0 = phi <4 x half> [ undef, %entry ], [ %17, %for.cond96.preheader ]
  %K_reg.sroa.0.0 = phi <4 x half> [ undef, %entry ], [ %16, %for.cond96.preheader ]
  %or.cond1289 = icmp ugt i32 %mul12.1, 1023, !dbg !65
  %cmp127.not = icmp sgt i32 %mul12.1, %1
  %or.cond1290 = or i1 %or.cond1289, %cmp127.not, !dbg !65
  br i1 %or.cond1290, label %if.end156, label %for.cond129.preheader, !dbg !65

for.cond129.preheader:                            ; preds = %if.end
  %24 = shl nsw i32 %cond.i.i1212.1, 10
  %mul137 = and i32 %24, 64512
  %add141 = add nuw nsw i32 %add105, %mul137
  %idxprom147 = zext nneg i32 %add141 to i64, !dbg !66
  %arrayidx148 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom147, !dbg !66
  %25 = load <4 x half>, ptr addrspace(4) %arrayidx148, align 2, !dbg !67, !tbaa !63
  %add144.4 = or disjoint i32 %add141, 4, !dbg !68
  %idxprom147.4 = zext nneg i32 %add144.4 to i64, !dbg !66
  %arrayidx148.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom147.4, !dbg !66
  %26 = load <4 x half>, ptr addrspace(4) %arrayidx148.4, align 2, !dbg !67, !tbaa !63
  %27 = zext nneg i32 %add141 to i64, !dbg !66
  %28 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %27, !dbg !66
  %arrayidx148.8 = getelementptr inbounds i8, ptr addrspace(4) %28, i64 1024, !dbg !66
  %29 = load <4 x half>, ptr addrspace(4) %arrayidx148.8, align 2, !dbg !67, !tbaa !63
  %30 = zext nneg i32 %add141 to i64, !dbg !66
  %31 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %30, !dbg !66
  %arrayidx148.12 = getelementptr inbounds i8, ptr addrspace(4) %31, i64 1032, !dbg !66
  %32 = load <4 x half>, ptr addrspace(4) %arrayidx148.12, align 2, !dbg !67, !tbaa !63
  br label %if.end156, !dbg !69

if.end156:                                        ; preds = %for.cond129.preheader, %if.end
  %K_reg1.sroa.32.0 = phi <4 x half> [ undef, %if.end ], [ %32, %for.cond129.preheader ]
  %K_reg1.sroa.22.0 = phi <4 x half> [ undef, %if.end ], [ %29, %for.cond129.preheader ]
  %K_reg1.sroa.12.0 = phi <4 x half> [ undef, %if.end ], [ %26, %for.cond129.preheader ]
  %K_reg1.sroa.0.0 = phi <4 x half> [ undef, %if.end ], [ %25, %for.cond129.preheader ]
  %or.cond1291 = icmp ugt i32 %mul12.2, 1023, !dbg !69
  %cmp162.not = icmp sgt i32 %mul12.2, %1
  %or.cond1292 = or i1 %or.cond1291, %cmp162.not, !dbg !69
  br i1 %or.cond1292, label %if.end191, label %for.cond164.preheader, !dbg !69

for.cond164.preheader:                            ; preds = %if.end156
  %33 = shl nsw i32 %cond.i.i1212.2, 10
  %mul172 = and i32 %33, 64512
  %add176 = add nuw nsw i32 %add105, %mul172
  %idxprom182 = zext nneg i32 %add176 to i64, !dbg !70
  %arrayidx183 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom182, !dbg !70
  %34 = load <4 x half>, ptr addrspace(4) %arrayidx183, align 2, !dbg !71, !tbaa !63
  %add179.4 = or disjoint i32 %add176, 4, !dbg !72
  %idxprom182.4 = zext nneg i32 %add179.4 to i64, !dbg !70
  %arrayidx183.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom182.4, !dbg !70
  %35 = load <4 x half>, ptr addrspace(4) %arrayidx183.4, align 2, !dbg !71, !tbaa !63
  %36 = zext nneg i32 %add176 to i64, !dbg !70
  %37 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %36, !dbg !70
  %arrayidx183.8 = getelementptr inbounds i8, ptr addrspace(4) %37, i64 1024, !dbg !70
  %38 = load <4 x half>, ptr addrspace(4) %arrayidx183.8, align 2, !dbg !71, !tbaa !63
  %39 = zext nneg i32 %add176 to i64, !dbg !70
  %40 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %39, !dbg !70
  %arrayidx183.12 = getelementptr inbounds i8, ptr addrspace(4) %40, i64 1032, !dbg !70
  %41 = load <4 x half>, ptr addrspace(4) %arrayidx183.12, align 2, !dbg !71, !tbaa !63
  br label %if.end191, !dbg !73

if.end191:                                        ; preds = %for.cond164.preheader, %if.end156
  %K_reg2.sroa.32.0 = phi <4 x half> [ undef, %if.end156 ], [ %41, %for.cond164.preheader ]
  %K_reg2.sroa.22.0 = phi <4 x half> [ undef, %if.end156 ], [ %38, %for.cond164.preheader ]
  %K_reg2.sroa.12.0 = phi <4 x half> [ undef, %if.end156 ], [ %35, %for.cond164.preheader ]
  %K_reg2.sroa.0.0 = phi <4 x half> [ undef, %if.end156 ], [ %34, %for.cond164.preheader ]
  %or.cond1293 = icmp ugt i32 %mul12.3, 1023, !dbg !73
  %cmp197.not = icmp sgt i32 %mul12.3, %1
  %or.cond1294 = or i1 %or.cond1293, %cmp197.not, !dbg !73
  br i1 %or.cond1294, label %if.end226, label %for.cond199.preheader, !dbg !73

for.cond199.preheader:                            ; preds = %if.end191
  %42 = shl nsw i32 %cond.i.i1212.3, 10
  %mul207 = and i32 %42, 64512
  %add211 = add nuw nsw i32 %add105, %mul207
  %idxprom217 = zext nneg i32 %add211 to i64, !dbg !74
  %arrayidx218 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom217, !dbg !74
  %43 = load <4 x half>, ptr addrspace(4) %arrayidx218, align 2, !dbg !75, !tbaa !63
  %add214.4 = or disjoint i32 %add211, 4, !dbg !76
  %idxprom217.4 = zext nneg i32 %add214.4 to i64, !dbg !74
  %arrayidx218.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom217.4, !dbg !74
  %44 = load <4 x half>, ptr addrspace(4) %arrayidx218.4, align 2, !dbg !75, !tbaa !63
  %45 = zext nneg i32 %add211 to i64, !dbg !74
  %46 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %45, !dbg !74
  %arrayidx218.8 = getelementptr inbounds i8, ptr addrspace(4) %46, i64 1024, !dbg !74
  %47 = load <4 x half>, ptr addrspace(4) %arrayidx218.8, align 2, !dbg !75, !tbaa !63
  %48 = zext nneg i32 %add211 to i64, !dbg !74
  %49 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %48, !dbg !74
  %arrayidx218.12 = getelementptr inbounds i8, ptr addrspace(4) %49, i64 1032, !dbg !74
  %50 = load <4 x half>, ptr addrspace(4) %arrayidx218.12, align 2, !dbg !75, !tbaa !63
  br label %if.end226, !dbg !77

if.end226:                                        ; preds = %for.cond199.preheader, %if.end191
  %K_reg3.sroa.32.0 = phi <4 x half> [ undef, %if.end191 ], [ %50, %for.cond199.preheader ]
  %K_reg3.sroa.22.0 = phi <4 x half> [ undef, %if.end191 ], [ %47, %for.cond199.preheader ]
  %K_reg3.sroa.12.0 = phi <4 x half> [ undef, %if.end191 ], [ %44, %for.cond199.preheader ]
  %K_reg3.sroa.0.0 = phi <4 x half> [ undef, %if.end191 ], [ %43, %for.cond199.preheader ]
  br i1 %or.cond1288, label %if.end375, label %for.cond234.preheader, !dbg !77

for.cond234.preheader:                            ; preds = %if.end226
  %51 = shl nsw i32 %cond.i.i1212, 10
  %mul242 = and i32 %51, 64512
  %add246 = add nuw nsw i32 %add105, %mul242
  %idxprom252 = zext nneg i32 %add246 to i64, !dbg !78
  %arrayidx253 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom252, !dbg !78
  %52 = load <4 x half>, ptr addrspace(4) %arrayidx253, align 2, !dbg !79, !tbaa !63
  %add249.4 = or disjoint i32 %add246, 4, !dbg !80
  %idxprom252.4 = zext nneg i32 %add249.4 to i64, !dbg !78
  %arrayidx253.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom252.4, !dbg !78
  %53 = load <4 x half>, ptr addrspace(4) %arrayidx253.4, align 2, !dbg !79, !tbaa !63
  %54 = zext nneg i32 %add246 to i64, !dbg !78
  %55 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %54, !dbg !78
  %arrayidx253.8 = getelementptr inbounds i8, ptr addrspace(4) %55, i64 1024, !dbg !78
  %56 = load <4 x half>, ptr addrspace(4) %arrayidx253.8, align 2, !dbg !79, !tbaa !63
  %57 = zext nneg i32 %add246 to i64, !dbg !78
  %58 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %57, !dbg !78
  %arrayidx253.12 = getelementptr inbounds i8, ptr addrspace(4) %58, i64 1032, !dbg !78
  %59 = load <4 x half>, ptr addrspace(4) %arrayidx253.12, align 2, !dbg !79, !tbaa !63
  %cmp263 = icmp sgt i32 %mul12, %invariant.op, !dbg !81
  br i1 %cmp263, label %for.cond265.preheader, label %if.end288, !dbg !82

for.cond265.preheader:                            ; preds = %for.cond234.preheader
  %add272 = add nuw nsw i32 %mul12, %mul271
  %cmp275.not = icmp sgt i32 %add272, %1, !dbg !83
  %fneg. = select i1 %cmp275.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1460 = insertelement <4 x float> poison, float %fneg., i64 0, !dbg !84
  %cmp275.not.1.not = icmp slt i32 %add272, %1, !dbg !83
  %fneg..1 = select i1 %cmp275.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1561 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1460, float %fneg..1, i64 1, !dbg !84
  %add273.2 = or disjoint i32 %add272, 2, !dbg !85
  %cmp275.not.2 = icmp sgt i32 %add273.2, %1, !dbg !83
  %fneg..2 = select i1 %cmp275.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1654 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1561, float %fneg..2, i64 2, !dbg !84
  %add273.3 = or disjoint i32 %add272, 3, !dbg !85
  %cmp275.not.3 = icmp sgt i32 %add273.3, %1, !dbg !83
  %fneg..3 = select i1 %cmp275.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1747 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1654, float %fneg..3, i64 3, !dbg !84
  br label %if.end288

if.end288:                                        ; preds = %for.cond234.preheader, %for.cond265.preheader
  %acc_s.sroa.0.0 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1747, %for.cond265.preheader ], [ zeroinitializer, %for.cond234.preheader ], !dbg !86
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.0), !dbg !87, !call_argsrelate !88
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.12.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %60), !dbg !87, !call_argsrelate !88
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.22.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %61), !dbg !87, !call_argsrelate !88
  %63 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.32.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %62), !dbg !87, !call_argsrelate !88
  %acc_s.sroa.0.0.vec.extract = extractelement <4 x float> %63, i64 0, !dbg !89
  %mul323 = fmul contract float %acc_s.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !90
  %64 = tail call contract noundef float @llvm.minnum.f32(float %mul323, float 0x4024CB5EC0000000), !dbg !91
  %65 = tail call contract noundef float @llvm.exp.f32(float %64), !dbg !94
  %acc_s.sroa.0.4.vec.extract = extractelement <4 x float> %63, i64 1, !dbg !89
  %mul323.1 = fmul contract float %acc_s.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !90
  %66 = tail call contract noundef float @llvm.minnum.f32(float %mul323.1, float 0x4024CB5EC0000000), !dbg !91
  %67 = tail call contract noundef float @llvm.exp.f32(float %66), !dbg !94
  %acc_s.sroa.0.8.vec.extract = extractelement <4 x float> %63, i64 2, !dbg !89
  %mul323.2 = fmul contract float %acc_s.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !90
  %68 = tail call contract noundef float @llvm.minnum.f32(float %mul323.2, float 0x4024CB5EC0000000), !dbg !91
  %69 = tail call contract noundef float @llvm.exp.f32(float %68), !dbg !94
  %acc_s.sroa.0.12.vec.extract = extractelement <4 x float> %63, i64 3, !dbg !89
  %mul323.3 = fmul contract float %acc_s.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !90
  %70 = tail call contract noundef float @llvm.minnum.f32(float %mul323.3, float 0x4024CB5EC0000000), !dbg !91
  %71 = tail call contract noundef float @llvm.exp.f32(float %70), !dbg !94
  %72 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %65), !dbg !97
  %73 = insertelement <4 x i16> poison, i16 %72, i64 0, !dbg !106
  %74 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %67), !dbg !97
  %75 = insertelement <4 x i16> %73, i16 %74, i64 1, !dbg !106
  %76 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %69), !dbg !97
  %77 = insertelement <4 x i16> %75, i16 %76, i64 2, !dbg !106
  %78 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %71), !dbg !97
  %79 = insertelement <4 x i16> %77, i16 %78, i64 3, !dbg !106
  %acc_s_cast.sroa.0.6.vec.insert = bitcast <4 x i16> %79 to <4 x half>, !dbg !106
  %80 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %52, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !107, !call_argsrelate !108
  %81 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %53, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !107, !call_argsrelate !108
  %82 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %56, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !107, !call_argsrelate !108
  %83 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %59, <4 x half> %acc_s_cast.sroa.0.6.vec.insert, <4 x float> zeroinitializer), !dbg !107, !call_argsrelate !108
  br label %if.end375, !dbg !109

if.end375:                                        ; preds = %if.end288, %if.end226
  %acc_o.sroa.98.0 = phi <4 x float> [ zeroinitializer, %if.end226 ], [ %83, %if.end288 ], !dbg !86
  %acc_o.sroa.66.0 = phi <4 x float> [ zeroinitializer, %if.end226 ], [ %82, %if.end288 ], !dbg !86
  %acc_o.sroa.34.0 = phi <4 x float> [ zeroinitializer, %if.end226 ], [ %81, %if.end288 ], !dbg !86
  %acc_o.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end226 ], [ %80, %if.end288 ], !dbg !86
  %sum_acc.sroa.56.0 = phi float [ 0.000000e+00, %if.end226 ], [ %71, %if.end288 ], !dbg !86
  %sum_acc.sroa.38.0 = phi float [ 0.000000e+00, %if.end226 ], [ %69, %if.end288 ], !dbg !86
  %sum_acc.sroa.20.0 = phi float [ 0.000000e+00, %if.end226 ], [ %67, %if.end288 ], !dbg !86
  %sum_acc.sroa.0.0 = phi float [ 0.000000e+00, %if.end226 ], [ %65, %if.end288 ], !dbg !86
  br i1 %or.cond1290, label %if.end525, label %for.cond383.preheader, !dbg !109

for.cond383.preheader:                            ; preds = %if.end375
  %84 = shl nsw i32 %cond.i.i1212.1, 10
  %mul391 = and i32 %84, 64512
  %add395 = add nuw nsw i32 %add105, %mul391
  %idxprom401 = zext nneg i32 %add395 to i64, !dbg !110
  %arrayidx402 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom401, !dbg !110
  %85 = load <4 x half>, ptr addrspace(4) %arrayidx402, align 2, !dbg !111, !tbaa !63
  %add398.4 = or disjoint i32 %add395, 4, !dbg !112
  %idxprom401.4 = zext nneg i32 %add398.4 to i64, !dbg !110
  %arrayidx402.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom401.4, !dbg !110
  %86 = load <4 x half>, ptr addrspace(4) %arrayidx402.4, align 2, !dbg !111, !tbaa !63
  %87 = zext nneg i32 %add395 to i64, !dbg !110
  %88 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %87, !dbg !110
  %arrayidx402.8 = getelementptr inbounds i8, ptr addrspace(4) %88, i64 1024, !dbg !110
  %89 = load <4 x half>, ptr addrspace(4) %arrayidx402.8, align 2, !dbg !111, !tbaa !63
  %90 = zext nneg i32 %add395 to i64, !dbg !110
  %91 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %90, !dbg !110
  %arrayidx402.12 = getelementptr inbounds i8, ptr addrspace(4) %91, i64 1032, !dbg !110
  %92 = load <4 x half>, ptr addrspace(4) %arrayidx402.12, align 2, !dbg !111, !tbaa !63
  %cmp412 = icmp sgt i32 %mul12.1, %invariant.op, !dbg !113
  br i1 %cmp412, label %for.cond414.preheader, label %if.end438, !dbg !114

for.cond414.preheader:                            ; preds = %for.cond383.preheader
  %add421 = add nuw nsw i32 %mul12.1, %mul271
  %cmp424.not = icmp sgt i32 %add421, %1, !dbg !115
  %fneg.1201 = select i1 %cmp424.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1469 = insertelement <4 x float> poison, float %fneg.1201, i64 0, !dbg !116
  %cmp424.not.1.not = icmp slt i32 %add421, %1, !dbg !115
  %fneg.1201.1 = select i1 %cmp424.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1570 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1469, float %fneg.1201.1, i64 1, !dbg !116
  %add422.2 = or disjoint i32 %add421, 2, !dbg !117
  %cmp424.not.2 = icmp sgt i32 %add422.2, %1, !dbg !115
  %fneg.1201.2 = select i1 %cmp424.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1663 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1570, float %fneg.1201.2, i64 2, !dbg !116
  %add422.3 = or disjoint i32 %add421, 3, !dbg !117
  %cmp424.not.3 = icmp sgt i32 %add422.3, %1, !dbg !115
  %fneg.1201.3 = select i1 %cmp424.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1756 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1663, float %fneg.1201.3, i64 3, !dbg !116
  br label %if.end438

if.end438:                                        ; preds = %for.cond383.preheader, %for.cond414.preheader
  %acc_s.sroa.0.2 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1756, %for.cond414.preheader ], [ zeroinitializer, %for.cond383.preheader ], !dbg !86
  %93 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.2), !dbg !118, !call_argsrelate !88
  %94 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.12.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %93), !dbg !118, !call_argsrelate !88
  %95 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.22.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %94), !dbg !118, !call_argsrelate !88
  %96 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.32.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %95), !dbg !118, !call_argsrelate !88
  %acc_s.sroa.0.0.vec.extract1471 = extractelement <4 x float> %96, i64 0, !dbg !119
  %mul473 = fmul contract float %acc_s.sroa.0.0.vec.extract1471, 0x3FB99999A0000000, !dbg !120
  %97 = tail call contract noundef float @llvm.minnum.f32(float %mul473, float 0x4024CB5EC0000000), !dbg !121
  %98 = tail call contract noundef float @llvm.exp.f32(float %97), !dbg !123
  %acc_s.sroa.0.4.vec.extract1572 = extractelement <4 x float> %96, i64 1, !dbg !119
  %mul473.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1572, 0x3FB99999A0000000, !dbg !120
  %99 = tail call contract noundef float @llvm.minnum.f32(float %mul473.1, float 0x4024CB5EC0000000), !dbg !121
  %100 = tail call contract noundef float @llvm.exp.f32(float %99), !dbg !123
  %acc_s.sroa.0.8.vec.extract1665 = extractelement <4 x float> %96, i64 2, !dbg !119
  %mul473.2 = fmul contract float %acc_s.sroa.0.8.vec.extract1665, 0x3FB99999A0000000, !dbg !120
  %101 = tail call contract noundef float @llvm.minnum.f32(float %mul473.2, float 0x4024CB5EC0000000), !dbg !121
  %102 = tail call contract noundef float @llvm.exp.f32(float %101), !dbg !123
  %acc_s.sroa.0.12.vec.extract1758 = extractelement <4 x float> %96, i64 3, !dbg !119
  %mul473.3 = fmul contract float %acc_s.sroa.0.12.vec.extract1758, 0x3FB99999A0000000, !dbg !120
  %103 = tail call contract noundef float @llvm.minnum.f32(float %mul473.3, float 0x4024CB5EC0000000), !dbg !121
  %104 = tail call contract noundef float @llvm.exp.f32(float %103), !dbg !123
  %add489 = fadd contract float %sum_acc.sroa.0.0, %98, !dbg !125
  %add489.1 = fadd contract float %sum_acc.sroa.20.0, %100, !dbg !125
  %add489.2 = fadd contract float %sum_acc.sroa.38.0, %102, !dbg !125
  %add489.3 = fadd contract float %sum_acc.sroa.56.0, %104, !dbg !125
  %105 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %98), !dbg !126
  %106 = insertelement <4 x i16> poison, i16 %105, i64 0, !dbg !130
  %107 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %100), !dbg !126
  %108 = insertelement <4 x i16> %106, i16 %107, i64 1, !dbg !130
  %109 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %102), !dbg !126
  %110 = insertelement <4 x i16> %108, i16 %109, i64 2, !dbg !130
  %111 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %104), !dbg !126
  %112 = insertelement <4 x i16> %110, i16 %111, i64 3, !dbg !130
  %acc_s_cast.sroa.0.6.vec.insert1432 = bitcast <4 x i16> %112 to <4 x half>, !dbg !130
  %113 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %85, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1432, <4 x float> zeroinitializer), !dbg !131, !call_argsrelate !108
  %114 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %86, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1432, <4 x float> zeroinitializer), !dbg !131, !call_argsrelate !108
  %115 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %89, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1432, <4 x float> zeroinitializer), !dbg !131, !call_argsrelate !108
  %116 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %92, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1432, <4 x float> zeroinitializer), !dbg !131, !call_argsrelate !108
  br label %if.end525, !dbg !132

if.end525:                                        ; preds = %if.end438, %if.end375
  %acc_o_alt.sroa.50.0 = phi <4 x float> [ zeroinitializer, %if.end375 ], [ %116, %if.end438 ], !dbg !86
  %acc_o_alt.sroa.34.0 = phi <4 x float> [ zeroinitializer, %if.end375 ], [ %115, %if.end438 ], !dbg !86
  %acc_o_alt.sroa.18.0 = phi <4 x float> [ zeroinitializer, %if.end375 ], [ %114, %if.end438 ], !dbg !86
  %acc_o_alt.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end375 ], [ %113, %if.end438 ], !dbg !86
  %sum_acc.sroa.56.1 = phi float [ %sum_acc.sroa.56.0, %if.end375 ], [ %add489.3, %if.end438 ], !dbg !86
  %sum_acc.sroa.38.1 = phi float [ %sum_acc.sroa.38.0, %if.end375 ], [ %add489.2, %if.end438 ], !dbg !86
  %sum_acc.sroa.20.1 = phi float [ %sum_acc.sroa.20.0, %if.end375 ], [ %add489.1, %if.end438 ], !dbg !86
  %sum_acc.sroa.0.1 = phi float [ %sum_acc.sroa.0.0, %if.end375 ], [ %add489, %if.end438 ], !dbg !86
  br i1 %or.cond1292, label %if.end675, label %for.cond533.preheader, !dbg !132

for.cond533.preheader:                            ; preds = %if.end525
  %117 = shl nsw i32 %cond.i.i1212.2, 10
  %mul541 = and i32 %117, 64512
  %add545 = add nuw nsw i32 %add105, %mul541
  %idxprom551 = zext nneg i32 %add545 to i64, !dbg !133
  %arrayidx552 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom551, !dbg !133
  %118 = load <4 x half>, ptr addrspace(4) %arrayidx552, align 2, !dbg !134, !tbaa !63
  %add548.4 = or disjoint i32 %add545, 4, !dbg !135
  %idxprom551.4 = zext nneg i32 %add548.4 to i64, !dbg !133
  %arrayidx552.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom551.4, !dbg !133
  %119 = load <4 x half>, ptr addrspace(4) %arrayidx552.4, align 2, !dbg !134, !tbaa !63
  %120 = zext nneg i32 %add545 to i64, !dbg !133
  %121 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %120, !dbg !133
  %arrayidx552.8 = getelementptr inbounds i8, ptr addrspace(4) %121, i64 1024, !dbg !133
  %122 = load <4 x half>, ptr addrspace(4) %arrayidx552.8, align 2, !dbg !134, !tbaa !63
  %123 = zext nneg i32 %add545 to i64, !dbg !133
  %124 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %123, !dbg !133
  %arrayidx552.12 = getelementptr inbounds i8, ptr addrspace(4) %124, i64 1032, !dbg !133
  %125 = load <4 x half>, ptr addrspace(4) %arrayidx552.12, align 2, !dbg !134, !tbaa !63
  %cmp562 = icmp sgt i32 %mul12.2, %invariant.op, !dbg !136
  br i1 %cmp562, label %for.cond564.preheader, label %if.end588, !dbg !137

for.cond564.preheader:                            ; preds = %for.cond533.preheader
  %add571 = add nuw nsw i32 %mul12.2, %mul271
  %cmp574.not = icmp sgt i32 %add571, %1, !dbg !138
  %fneg.1202 = select i1 %cmp574.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1479 = insertelement <4 x float> poison, float %fneg.1202, i64 0, !dbg !139
  %cmp574.not.1.not = icmp slt i32 %add571, %1, !dbg !138
  %fneg.1202.1 = select i1 %cmp574.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1580 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1479, float %fneg.1202.1, i64 1, !dbg !139
  %add572.2 = or disjoint i32 %add571, 2, !dbg !140
  %cmp574.not.2 = icmp sgt i32 %add572.2, %1, !dbg !138
  %fneg.1202.2 = select i1 %cmp574.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1673 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1580, float %fneg.1202.2, i64 2, !dbg !139
  %add572.3 = or disjoint i32 %add571, 3, !dbg !140
  %cmp574.not.3 = icmp sgt i32 %add572.3, %1, !dbg !138
  %fneg.1202.3 = select i1 %cmp574.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1766 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1673, float %fneg.1202.3, i64 3, !dbg !139
  br label %if.end588

if.end588:                                        ; preds = %for.cond533.preheader, %for.cond564.preheader
  %acc_s.sroa.0.4 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1766, %for.cond564.preheader ], [ zeroinitializer, %for.cond533.preheader ], !dbg !86
  %126 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.4), !dbg !141, !call_argsrelate !88
  %127 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.12.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %126), !dbg !141, !call_argsrelate !88
  %128 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.22.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %127), !dbg !141, !call_argsrelate !88
  %129 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.32.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %128), !dbg !141, !call_argsrelate !88
  %acc_s.sroa.0.0.vec.extract1481 = extractelement <4 x float> %129, i64 0, !dbg !142
  %mul623 = fmul contract float %acc_s.sroa.0.0.vec.extract1481, 0x3FB99999A0000000, !dbg !143
  %130 = tail call contract noundef float @llvm.minnum.f32(float %mul623, float 0x4024CB5EC0000000), !dbg !144
  %131 = tail call contract noundef float @llvm.exp.f32(float %130), !dbg !146
  %acc_s.sroa.0.4.vec.extract1582 = extractelement <4 x float> %129, i64 1, !dbg !142
  %mul623.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1582, 0x3FB99999A0000000, !dbg !143
  %132 = tail call contract noundef float @llvm.minnum.f32(float %mul623.1, float 0x4024CB5EC0000000), !dbg !144
  %133 = tail call contract noundef float @llvm.exp.f32(float %132), !dbg !146
  %acc_s.sroa.0.8.vec.extract1675 = extractelement <4 x float> %129, i64 2, !dbg !142
  %mul623.2 = fmul contract float %acc_s.sroa.0.8.vec.extract1675, 0x3FB99999A0000000, !dbg !143
  %134 = tail call contract noundef float @llvm.minnum.f32(float %mul623.2, float 0x4024CB5EC0000000), !dbg !144
  %135 = tail call contract noundef float @llvm.exp.f32(float %134), !dbg !146
  %acc_s.sroa.0.12.vec.extract1768 = extractelement <4 x float> %129, i64 3, !dbg !142
  %mul623.3 = fmul contract float %acc_s.sroa.0.12.vec.extract1768, 0x3FB99999A0000000, !dbg !143
  %136 = tail call contract noundef float @llvm.minnum.f32(float %mul623.3, float 0x4024CB5EC0000000), !dbg !144
  %137 = tail call contract noundef float @llvm.exp.f32(float %136), !dbg !146
  %add639 = fadd contract float %sum_acc.sroa.0.1, %131, !dbg !148
  %add639.1 = fadd contract float %sum_acc.sroa.20.1, %133, !dbg !148
  %add639.2 = fadd contract float %sum_acc.sroa.38.1, %135, !dbg !148
  %add639.3 = fadd contract float %sum_acc.sroa.56.1, %137, !dbg !148
  %138 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %131), !dbg !149
  %139 = insertelement <4 x i16> poison, i16 %138, i64 0, !dbg !153
  %140 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %133), !dbg !149
  %141 = insertelement <4 x i16> %139, i16 %140, i64 1, !dbg !153
  %142 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %135), !dbg !149
  %143 = insertelement <4 x i16> %141, i16 %142, i64 2, !dbg !153
  %144 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %137), !dbg !149
  %145 = insertelement <4 x i16> %143, i16 %144, i64 3, !dbg !153
  %acc_s_cast.sroa.0.6.vec.insert1434 = bitcast <4 x i16> %145 to <4 x half>, !dbg !153
  %146 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %118, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1434, <4 x float> %acc_o.sroa.0.0), !dbg !154, !call_argsrelate !108
  %147 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %119, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1434, <4 x float> %acc_o.sroa.34.0), !dbg !154, !call_argsrelate !108
  %148 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %122, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1434, <4 x float> %acc_o.sroa.66.0), !dbg !154, !call_argsrelate !108
  %149 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %125, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1434, <4 x float> %acc_o.sroa.98.0), !dbg !154, !call_argsrelate !108
  br label %if.end675, !dbg !155

if.end675:                                        ; preds = %if.end588, %if.end525
  %acc_o.sroa.98.1 = phi <4 x float> [ %acc_o.sroa.98.0, %if.end525 ], [ %149, %if.end588 ], !dbg !86
  %acc_o.sroa.66.1 = phi <4 x float> [ %acc_o.sroa.66.0, %if.end525 ], [ %148, %if.end588 ], !dbg !86
  %acc_o.sroa.34.1 = phi <4 x float> [ %acc_o.sroa.34.0, %if.end525 ], [ %147, %if.end588 ], !dbg !86
  %acc_o.sroa.0.1 = phi <4 x float> [ %acc_o.sroa.0.0, %if.end525 ], [ %146, %if.end588 ], !dbg !86
  %sum_acc.sroa.56.2 = phi float [ %sum_acc.sroa.56.1, %if.end525 ], [ %add639.3, %if.end588 ], !dbg !86
  %sum_acc.sroa.38.2 = phi float [ %sum_acc.sroa.38.1, %if.end525 ], [ %add639.2, %if.end588 ], !dbg !86
  %sum_acc.sroa.20.2 = phi float [ %sum_acc.sroa.20.1, %if.end525 ], [ %add639.1, %if.end588 ], !dbg !86
  %sum_acc.sroa.0.2 = phi float [ %sum_acc.sroa.0.1, %if.end525 ], [ %add639, %if.end588 ], !dbg !86
  br i1 %or.cond1294, label %if.end825, label %for.cond683.preheader, !dbg !155

for.cond683.preheader:                            ; preds = %if.end675
  %150 = shl nsw i32 %cond.i.i1212.3, 10
  %mul691 = and i32 %150, 64512
  %add695 = add nuw nsw i32 %add105, %mul691
  %idxprom701 = zext nneg i32 %add695 to i64, !dbg !156
  %arrayidx702 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom701, !dbg !156
  %151 = load <4 x half>, ptr addrspace(4) %arrayidx702, align 2, !dbg !157, !tbaa !63
  %add698.4 = or disjoint i32 %add695, 4, !dbg !158
  %idxprom701.4 = zext nneg i32 %add698.4 to i64, !dbg !156
  %arrayidx702.4 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom701.4, !dbg !156
  %152 = load <4 x half>, ptr addrspace(4) %arrayidx702.4, align 2, !dbg !157, !tbaa !63
  %153 = zext nneg i32 %add695 to i64, !dbg !156
  %154 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %153, !dbg !156
  %arrayidx702.8 = getelementptr inbounds i8, ptr addrspace(4) %154, i64 1024, !dbg !156
  %155 = load <4 x half>, ptr addrspace(4) %arrayidx702.8, align 2, !dbg !157, !tbaa !63
  %156 = zext nneg i32 %add695 to i64, !dbg !156
  %157 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %156, !dbg !156
  %arrayidx702.12 = getelementptr inbounds i8, ptr addrspace(4) %157, i64 1032, !dbg !156
  %158 = load <4 x half>, ptr addrspace(4) %arrayidx702.12, align 2, !dbg !157, !tbaa !63
  %cmp712 = icmp sgt i32 %mul12.3, %invariant.op, !dbg !159
  br i1 %cmp712, label %for.cond714.preheader, label %if.end738, !dbg !160

for.cond714.preheader:                            ; preds = %for.cond683.preheader
  %add721 = add nuw nsw i32 %mul12.3, %mul271
  %cmp724.not = icmp sgt i32 %add721, %1, !dbg !161
  %fneg.1203 = select i1 %cmp724.not, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1489 = insertelement <4 x float> poison, float %fneg.1203, i64 0, !dbg !162
  %cmp724.not.1.not = icmp slt i32 %add721, %1, !dbg !161
  %fneg.1203.1 = select i1 %cmp724.not.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1590 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1489, float %fneg.1203.1, i64 1, !dbg !162
  %add722.2 = or disjoint i32 %add721, 2, !dbg !163
  %cmp724.not.2 = icmp sgt i32 %add722.2, %1, !dbg !161
  %fneg.1203.2 = select i1 %cmp724.not.2, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1683 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1590, float %fneg.1203.2, i64 2, !dbg !162
  %add722.3 = or disjoint i32 %add721, 3, !dbg !163
  %cmp724.not.3 = icmp sgt i32 %add722.3, %1, !dbg !161
  %fneg.1203.3 = select i1 %cmp724.not.3, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1776 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1683, float %fneg.1203.3, i64 3, !dbg !162
  br label %if.end738

if.end738:                                        ; preds = %for.cond683.preheader, %for.cond714.preheader
  %acc_s.sroa.0.6 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1776, %for.cond714.preheader ], [ zeroinitializer, %for.cond683.preheader ], !dbg !86
  %159 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.0.0, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.6), !dbg !164, !call_argsrelate !88
  %160 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.12.0, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %159), !dbg !164, !call_argsrelate !88
  %161 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.22.0, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %160), !dbg !164, !call_argsrelate !88
  %162 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.32.0, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %161), !dbg !164, !call_argsrelate !88
  %acc_s.sroa.0.0.vec.extract1491 = extractelement <4 x float> %162, i64 0, !dbg !165
  %mul773 = fmul contract float %acc_s.sroa.0.0.vec.extract1491, 0x3FB99999A0000000, !dbg !166
  %163 = tail call contract noundef float @llvm.minnum.f32(float %mul773, float 0x4024CB5EC0000000), !dbg !167
  %164 = tail call contract noundef float @llvm.exp.f32(float %163), !dbg !169
  %acc_s.sroa.0.4.vec.extract1592 = extractelement <4 x float> %162, i64 1, !dbg !165
  %mul773.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1592, 0x3FB99999A0000000, !dbg !166
  %165 = tail call contract noundef float @llvm.minnum.f32(float %mul773.1, float 0x4024CB5EC0000000), !dbg !167
  %166 = tail call contract noundef float @llvm.exp.f32(float %165), !dbg !169
  %acc_s.sroa.0.8.vec.extract1685 = extractelement <4 x float> %162, i64 2, !dbg !165
  %mul773.2 = fmul contract float %acc_s.sroa.0.8.vec.extract1685, 0x3FB99999A0000000, !dbg !166
  %167 = tail call contract noundef float @llvm.minnum.f32(float %mul773.2, float 0x4024CB5EC0000000), !dbg !167
  %168 = tail call contract noundef float @llvm.exp.f32(float %167), !dbg !169
  %acc_s.sroa.0.12.vec.extract1778 = extractelement <4 x float> %162, i64 3, !dbg !165
  %mul773.3 = fmul contract float %acc_s.sroa.0.12.vec.extract1778, 0x3FB99999A0000000, !dbg !166
  %169 = tail call contract noundef float @llvm.minnum.f32(float %mul773.3, float 0x4024CB5EC0000000), !dbg !167
  %170 = tail call contract noundef float @llvm.exp.f32(float %169), !dbg !169
  %add789 = fadd contract float %sum_acc.sroa.0.2, %164, !dbg !171
  %add789.1 = fadd contract float %sum_acc.sroa.20.2, %166, !dbg !171
  %add789.2 = fadd contract float %sum_acc.sroa.38.2, %168, !dbg !171
  %add789.3 = fadd contract float %sum_acc.sroa.56.2, %170, !dbg !171
  %171 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %164), !dbg !172
  %172 = insertelement <4 x i16> poison, i16 %171, i64 0, !dbg !176
  %173 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %166), !dbg !172
  %174 = insertelement <4 x i16> %172, i16 %173, i64 1, !dbg !176
  %175 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %168), !dbg !172
  %176 = insertelement <4 x i16> %174, i16 %175, i64 2, !dbg !176
  %177 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %170), !dbg !172
  %178 = insertelement <4 x i16> %176, i16 %177, i64 3, !dbg !176
  %acc_s_cast.sroa.0.6.vec.insert1436 = bitcast <4 x i16> %178 to <4 x half>, !dbg !176
  %179 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %151, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1436, <4 x float> %acc_o_alt.sroa.0.0), !dbg !177, !call_argsrelate !108
  %180 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %152, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1436, <4 x float> %acc_o_alt.sroa.18.0), !dbg !177, !call_argsrelate !108
  %181 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %155, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1436, <4 x float> %acc_o_alt.sroa.34.0), !dbg !177, !call_argsrelate !108
  %182 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %158, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1436, <4 x float> %acc_o_alt.sroa.50.0), !dbg !177, !call_argsrelate !108
  br label %if.end825, !dbg !178

if.end825:                                        ; preds = %if.end738, %if.end675
  %acc_o_alt.sroa.50.1 = phi <4 x float> [ %acc_o_alt.sroa.50.0, %if.end675 ], [ %182, %if.end738 ], !dbg !86
  %acc_o_alt.sroa.34.1 = phi <4 x float> [ %acc_o_alt.sroa.34.0, %if.end675 ], [ %181, %if.end738 ], !dbg !86
  %acc_o_alt.sroa.18.1 = phi <4 x float> [ %acc_o_alt.sroa.18.0, %if.end675 ], [ %180, %if.end738 ], !dbg !86
  %acc_o_alt.sroa.0.1 = phi <4 x float> [ %acc_o_alt.sroa.0.0, %if.end675 ], [ %179, %if.end738 ], !dbg !86
  %sum_acc.sroa.56.3 = phi float [ %sum_acc.sroa.56.2, %if.end675 ], [ %add789.3, %if.end738 ], !dbg !86
  %sum_acc.sroa.38.3 = phi float [ %sum_acc.sroa.38.2, %if.end675 ], [ %add789.2, %if.end738 ], !dbg !86
  %sum_acc.sroa.20.3 = phi float [ %sum_acc.sroa.20.2, %if.end675 ], [ %add789.1, %if.end738 ], !dbg !86
  %sum_acc.sroa.0.3 = phi float [ %sum_acc.sroa.0.2, %if.end675 ], [ %add789, %if.end738 ], !dbg !86
  %or.cond.1 = icmp ugt i32 %mul12.4, 1023, !dbg !60
  %cmp95.not.1 = icmp sgt i32 %mul12.4, %1
  %or.cond1288.1 = or i1 %or.cond.1, %cmp95.not.1, !dbg !60
  br i1 %or.cond1288.1, label %if.end.1, label %for.cond96.preheader.1, !dbg !60

for.cond96.preheader.1:                           ; preds = %if.end825
  %183 = shl nsw i32 %cond.i.i1212.4, 10
  %mul104.1 = and i32 %183, 64512
  %add108.1 = add nuw nsw i32 %add105, %mul104.1
  %idxprom114.11320 = zext nneg i32 %add108.1 to i64, !dbg !61
  %arrayidx115.11321 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom114.11320, !dbg !61
  %184 = load <4 x half>, ptr addrspace(4) %arrayidx115.11321, align 2, !dbg !62, !tbaa !63
  %add111.4.1 = or disjoint i32 %add108.1, 4, !dbg !64
  %idxprom114.4.1 = zext nneg i32 %add111.4.1 to i64, !dbg !61
  %arrayidx115.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom114.4.1, !dbg !61
  %185 = load <4 x half>, ptr addrspace(4) %arrayidx115.4.1, align 2, !dbg !62, !tbaa !63
  %186 = zext nneg i32 %add108.1 to i64, !dbg !61
  %187 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %186, !dbg !61
  %arrayidx115.8.1 = getelementptr inbounds i8, ptr addrspace(4) %187, i64 1024, !dbg !61
  %188 = load <4 x half>, ptr addrspace(4) %arrayidx115.8.1, align 2, !dbg !62, !tbaa !63
  %189 = zext nneg i32 %add108.1 to i64, !dbg !61
  %190 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %189, !dbg !61
  %arrayidx115.12.1 = getelementptr inbounds i8, ptr addrspace(4) %190, i64 1032, !dbg !61
  %191 = load <4 x half>, ptr addrspace(4) %arrayidx115.12.1, align 2, !dbg !62, !tbaa !63
  br label %if.end.1, !dbg !65

if.end.1:                                         ; preds = %for.cond96.preheader.1, %if.end825
  %K_reg.sroa.32.1 = phi <4 x half> [ %K_reg.sroa.32.0, %if.end825 ], [ %191, %for.cond96.preheader.1 ]
  %K_reg.sroa.22.1 = phi <4 x half> [ %K_reg.sroa.22.0, %if.end825 ], [ %188, %for.cond96.preheader.1 ]
  %K_reg.sroa.12.1 = phi <4 x half> [ %K_reg.sroa.12.0, %if.end825 ], [ %185, %for.cond96.preheader.1 ]
  %K_reg.sroa.0.1 = phi <4 x half> [ %K_reg.sroa.0.0, %if.end825 ], [ %184, %for.cond96.preheader.1 ]
  %or.cond1289.1 = icmp ugt i32 %mul12.5, 1023, !dbg !65
  %cmp127.not.1 = icmp sgt i32 %mul12.5, %1
  %or.cond1290.1 = or i1 %or.cond1289.1, %cmp127.not.1, !dbg !65
  br i1 %or.cond1290.1, label %if.end156.1, label %for.cond129.preheader.1, !dbg !65

for.cond129.preheader.1:                          ; preds = %if.end.1
  %192 = shl nsw i32 %cond.i.i1212.5, 10
  %mul137.1 = and i32 %192, 64512
  %add141.1 = add nuw nsw i32 %add105, %mul137.1
  %idxprom147.11323 = zext nneg i32 %add141.1 to i64, !dbg !66
  %arrayidx148.11324 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom147.11323, !dbg !66
  %193 = load <4 x half>, ptr addrspace(4) %arrayidx148.11324, align 2, !dbg !67, !tbaa !63
  %add144.4.1 = or disjoint i32 %add141.1, 4, !dbg !68
  %idxprom147.4.1 = zext nneg i32 %add144.4.1 to i64, !dbg !66
  %arrayidx148.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom147.4.1, !dbg !66
  %194 = load <4 x half>, ptr addrspace(4) %arrayidx148.4.1, align 2, !dbg !67, !tbaa !63
  %195 = zext nneg i32 %add141.1 to i64, !dbg !66
  %196 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %195, !dbg !66
  %arrayidx148.8.1 = getelementptr inbounds i8, ptr addrspace(4) %196, i64 1024, !dbg !66
  %197 = load <4 x half>, ptr addrspace(4) %arrayidx148.8.1, align 2, !dbg !67, !tbaa !63
  %198 = zext nneg i32 %add141.1 to i64, !dbg !66
  %199 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %198, !dbg !66
  %arrayidx148.12.1 = getelementptr inbounds i8, ptr addrspace(4) %199, i64 1032, !dbg !66
  %200 = load <4 x half>, ptr addrspace(4) %arrayidx148.12.1, align 2, !dbg !67, !tbaa !63
  br label %if.end156.1, !dbg !69

if.end156.1:                                      ; preds = %for.cond129.preheader.1, %if.end.1
  %K_reg1.sroa.32.1 = phi <4 x half> [ %K_reg1.sroa.32.0, %if.end.1 ], [ %200, %for.cond129.preheader.1 ]
  %K_reg1.sroa.22.1 = phi <4 x half> [ %K_reg1.sroa.22.0, %if.end.1 ], [ %197, %for.cond129.preheader.1 ]
  %K_reg1.sroa.12.1 = phi <4 x half> [ %K_reg1.sroa.12.0, %if.end.1 ], [ %194, %for.cond129.preheader.1 ]
  %K_reg1.sroa.0.1 = phi <4 x half> [ %K_reg1.sroa.0.0, %if.end.1 ], [ %193, %for.cond129.preheader.1 ]
  %or.cond1291.1 = icmp ugt i32 %mul12.6, 1023, !dbg !69
  %cmp162.not.1 = icmp sgt i32 %mul12.6, %1
  %or.cond1292.1 = or i1 %or.cond1291.1, %cmp162.not.1, !dbg !69
  br i1 %or.cond1292.1, label %if.end191.1, label %for.cond164.preheader.1, !dbg !69

for.cond164.preheader.1:                          ; preds = %if.end156.1
  %201 = shl nsw i32 %cond.i.i1212.6, 10
  %mul172.1 = and i32 %201, 64512
  %add176.1 = add nuw nsw i32 %add105, %mul172.1
  %idxprom182.11326 = zext nneg i32 %add176.1 to i64, !dbg !70
  %arrayidx183.11327 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom182.11326, !dbg !70
  %202 = load <4 x half>, ptr addrspace(4) %arrayidx183.11327, align 2, !dbg !71, !tbaa !63
  %add179.4.1 = or disjoint i32 %add176.1, 4, !dbg !72
  %idxprom182.4.1 = zext nneg i32 %add179.4.1 to i64, !dbg !70
  %arrayidx183.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom182.4.1, !dbg !70
  %203 = load <4 x half>, ptr addrspace(4) %arrayidx183.4.1, align 2, !dbg !71, !tbaa !63
  %204 = zext nneg i32 %add176.1 to i64, !dbg !70
  %205 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %204, !dbg !70
  %arrayidx183.8.1 = getelementptr inbounds i8, ptr addrspace(4) %205, i64 1024, !dbg !70
  %206 = load <4 x half>, ptr addrspace(4) %arrayidx183.8.1, align 2, !dbg !71, !tbaa !63
  %207 = zext nneg i32 %add176.1 to i64, !dbg !70
  %208 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %207, !dbg !70
  %arrayidx183.12.1 = getelementptr inbounds i8, ptr addrspace(4) %208, i64 1032, !dbg !70
  %209 = load <4 x half>, ptr addrspace(4) %arrayidx183.12.1, align 2, !dbg !71, !tbaa !63
  br label %if.end191.1, !dbg !73

if.end191.1:                                      ; preds = %for.cond164.preheader.1, %if.end156.1
  %K_reg2.sroa.32.1 = phi <4 x half> [ %K_reg2.sroa.32.0, %if.end156.1 ], [ %209, %for.cond164.preheader.1 ]
  %K_reg2.sroa.22.1 = phi <4 x half> [ %K_reg2.sroa.22.0, %if.end156.1 ], [ %206, %for.cond164.preheader.1 ]
  %K_reg2.sroa.12.1 = phi <4 x half> [ %K_reg2.sroa.12.0, %if.end156.1 ], [ %203, %for.cond164.preheader.1 ]
  %K_reg2.sroa.0.1 = phi <4 x half> [ %K_reg2.sroa.0.0, %if.end156.1 ], [ %202, %for.cond164.preheader.1 ]
  %or.cond1293.1 = icmp ugt i32 %mul12.7, 1023, !dbg !73
  %cmp197.not.1 = icmp sgt i32 %mul12.7, %1
  %or.cond1294.1 = or i1 %or.cond1293.1, %cmp197.not.1, !dbg !73
  br i1 %or.cond1294.1, label %if.end226.1, label %for.cond199.preheader.1, !dbg !73

for.cond199.preheader.1:                          ; preds = %if.end191.1
  %210 = shl nsw i32 %cond.i.i1212.7, 10
  %mul207.1 = and i32 %210, 64512
  %add211.1 = add nuw nsw i32 %add105, %mul207.1
  %idxprom217.11329 = zext nneg i32 %add211.1 to i64, !dbg !74
  %arrayidx218.11330 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom217.11329, !dbg !74
  %211 = load <4 x half>, ptr addrspace(4) %arrayidx218.11330, align 2, !dbg !75, !tbaa !63
  %add214.4.1 = or disjoint i32 %add211.1, 4, !dbg !76
  %idxprom217.4.1 = zext nneg i32 %add214.4.1 to i64, !dbg !74
  %arrayidx218.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idxprom217.4.1, !dbg !74
  %212 = load <4 x half>, ptr addrspace(4) %arrayidx218.4.1, align 2, !dbg !75, !tbaa !63
  %213 = zext nneg i32 %add211.1 to i64, !dbg !74
  %214 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %213, !dbg !74
  %arrayidx218.8.1 = getelementptr inbounds i8, ptr addrspace(4) %214, i64 1024, !dbg !74
  %215 = load <4 x half>, ptr addrspace(4) %arrayidx218.8.1, align 2, !dbg !75, !tbaa !63
  %216 = zext nneg i32 %add211.1 to i64, !dbg !74
  %217 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %216, !dbg !74
  %arrayidx218.12.1 = getelementptr inbounds i8, ptr addrspace(4) %217, i64 1032, !dbg !74
  %218 = load <4 x half>, ptr addrspace(4) %arrayidx218.12.1, align 2, !dbg !75, !tbaa !63
  br label %if.end226.1, !dbg !77

if.end226.1:                                      ; preds = %for.cond199.preheader.1, %if.end191.1
  %K_reg3.sroa.32.1 = phi <4 x half> [ %K_reg3.sroa.32.0, %if.end191.1 ], [ %218, %for.cond199.preheader.1 ]
  %K_reg3.sroa.22.1 = phi <4 x half> [ %K_reg3.sroa.22.0, %if.end191.1 ], [ %215, %for.cond199.preheader.1 ]
  %K_reg3.sroa.12.1 = phi <4 x half> [ %K_reg3.sroa.12.0, %if.end191.1 ], [ %212, %for.cond199.preheader.1 ]
  %K_reg3.sroa.0.1 = phi <4 x half> [ %K_reg3.sroa.0.0, %if.end191.1 ], [ %211, %for.cond199.preheader.1 ]
  br i1 %or.cond1288.1, label %if.end375.1, label %for.cond234.preheader.1, !dbg !77

for.cond234.preheader.1:                          ; preds = %if.end226.1
  %219 = shl nsw i32 %cond.i.i1212.4, 10
  %mul242.1 = and i32 %219, 64512
  %add246.1 = add nuw nsw i32 %add105, %mul242.1
  %idxprom252.11332 = zext nneg i32 %add246.1 to i64, !dbg !78
  %arrayidx253.11333 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom252.11332, !dbg !78
  %220 = load <4 x half>, ptr addrspace(4) %arrayidx253.11333, align 2, !dbg !79, !tbaa !63
  %add249.4.1 = or disjoint i32 %add246.1, 4, !dbg !80
  %idxprom252.4.1 = zext nneg i32 %add249.4.1 to i64, !dbg !78
  %arrayidx253.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom252.4.1, !dbg !78
  %221 = load <4 x half>, ptr addrspace(4) %arrayidx253.4.1, align 2, !dbg !79, !tbaa !63
  %222 = zext nneg i32 %add246.1 to i64, !dbg !78
  %223 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %222, !dbg !78
  %arrayidx253.8.1 = getelementptr inbounds i8, ptr addrspace(4) %223, i64 1024, !dbg !78
  %224 = load <4 x half>, ptr addrspace(4) %arrayidx253.8.1, align 2, !dbg !79, !tbaa !63
  %225 = zext nneg i32 %add246.1 to i64, !dbg !78
  %226 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %225, !dbg !78
  %arrayidx253.12.1 = getelementptr inbounds i8, ptr addrspace(4) %226, i64 1032, !dbg !78
  %227 = load <4 x half>, ptr addrspace(4) %arrayidx253.12.1, align 2, !dbg !79, !tbaa !63
  %cmp263.1 = icmp sgt i32 %mul12.4, %invariant.op, !dbg !81
  br i1 %cmp263.1, label %for.cond265.preheader.1, label %if.end288.1, !dbg !82

for.cond265.preheader.1:                          ; preds = %for.cond234.preheader.1
  %add272.1 = add nuw nsw i32 %mul12.4, %mul271
  %cmp275.not.11335 = icmp sgt i32 %add272.1, %1, !dbg !83
  %fneg..11336 = select i1 %cmp275.not.11335, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1501 = insertelement <4 x float> poison, float %fneg..11336, i64 0, !dbg !84
  %cmp275.not.1.1.not = icmp slt i32 %add272.1, %1, !dbg !83
  %fneg..1.1 = select i1 %cmp275.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1600 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1501, float %fneg..1.1, i64 1, !dbg !84
  %add273.2.1 = or disjoint i32 %add272.1, 2, !dbg !85
  %cmp275.not.2.1 = icmp sgt i32 %add273.2.1, %1, !dbg !83
  %fneg..2.1 = select i1 %cmp275.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1693 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1600, float %fneg..2.1, i64 2, !dbg !84
  %add273.3.1 = or disjoint i32 %add272.1, 3, !dbg !85
  %cmp275.not.3.1 = icmp sgt i32 %add273.3.1, %1, !dbg !83
  %fneg..3.1 = select i1 %cmp275.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1786 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1693, float %fneg..3.1, i64 3, !dbg !84
  br label %if.end288.1

if.end288.1:                                      ; preds = %for.cond234.preheader.1, %for.cond265.preheader.1
  %acc_s.sroa.0.8 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1786, %for.cond265.preheader.1 ], [ zeroinitializer, %for.cond234.preheader.1 ], !dbg !86
  %228 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.8), !dbg !87, !call_argsrelate !88
  %229 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.12.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %228), !dbg !87, !call_argsrelate !88
  %230 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.22.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %229), !dbg !87, !call_argsrelate !88
  %231 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg.sroa.32.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %230), !dbg !87, !call_argsrelate !88
  %acc_s.sroa.0.0.vec.extract1503 = extractelement <4 x float> %231, i64 0, !dbg !89
  %mul323.11340 = fmul contract float %acc_s.sroa.0.0.vec.extract1503, 0x3FB99999A0000000, !dbg !90
  %232 = tail call contract noundef float @llvm.minnum.f32(float %mul323.11340, float 0x4024CB5EC0000000), !dbg !91
  %233 = tail call contract noundef float @llvm.exp.f32(float %232), !dbg !94
  %acc_s.sroa.0.4.vec.extract1602 = extractelement <4 x float> %231, i64 1, !dbg !89
  %mul323.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1602, 0x3FB99999A0000000, !dbg !90
  %234 = tail call contract noundef float @llvm.minnum.f32(float %mul323.1.1, float 0x4024CB5EC0000000), !dbg !91
  %235 = tail call contract noundef float @llvm.exp.f32(float %234), !dbg !94
  %acc_s.sroa.0.8.vec.extract1695 = extractelement <4 x float> %231, i64 2, !dbg !89
  %mul323.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1695, 0x3FB99999A0000000, !dbg !90
  %236 = tail call contract noundef float @llvm.minnum.f32(float %mul323.2.1, float 0x4024CB5EC0000000), !dbg !91
  %237 = tail call contract noundef float @llvm.exp.f32(float %236), !dbg !94
  %acc_s.sroa.0.12.vec.extract1788 = extractelement <4 x float> %231, i64 3, !dbg !89
  %mul323.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1788, 0x3FB99999A0000000, !dbg !90
  %238 = tail call contract noundef float @llvm.minnum.f32(float %mul323.3.1, float 0x4024CB5EC0000000), !dbg !91
  %239 = tail call contract noundef float @llvm.exp.f32(float %238), !dbg !94
  %add339.11341 = fadd contract float %sum_acc.sroa.0.3, %233, !dbg !179
  %add339.1.1 = fadd contract float %sum_acc.sroa.20.3, %235, !dbg !179
  %add339.2.1 = fadd contract float %sum_acc.sroa.38.3, %237, !dbg !179
  %add339.3.1 = fadd contract float %sum_acc.sroa.56.3, %239, !dbg !179
  %240 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %233), !dbg !97
  %241 = insertelement <4 x i16> poison, i16 %240, i64 0, !dbg !106
  %242 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %235), !dbg !97
  %243 = insertelement <4 x i16> %241, i16 %242, i64 1, !dbg !106
  %244 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %237), !dbg !97
  %245 = insertelement <4 x i16> %243, i16 %244, i64 2, !dbg !106
  %246 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %239), !dbg !97
  %247 = insertelement <4 x i16> %245, i16 %246, i64 3, !dbg !106
  %acc_s_cast.sroa.0.6.vec.insert1438 = bitcast <4 x i16> %247 to <4 x half>, !dbg !106
  %248 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %220, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1438, <4 x float> %acc_o.sroa.0.1), !dbg !107, !call_argsrelate !108
  %249 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %221, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1438, <4 x float> %acc_o.sroa.34.1), !dbg !107, !call_argsrelate !108
  %250 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %224, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1438, <4 x float> %acc_o.sroa.66.1), !dbg !107, !call_argsrelate !108
  %251 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %227, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1438, <4 x float> %acc_o.sroa.98.1), !dbg !107, !call_argsrelate !108
  br label %if.end375.1, !dbg !109

if.end375.1:                                      ; preds = %if.end288.1, %if.end226.1
  %acc_o.sroa.98.2 = phi <4 x float> [ %acc_o.sroa.98.1, %if.end226.1 ], [ %251, %if.end288.1 ], !dbg !86
  %acc_o.sroa.66.2 = phi <4 x float> [ %acc_o.sroa.66.1, %if.end226.1 ], [ %250, %if.end288.1 ], !dbg !86
  %acc_o.sroa.34.2 = phi <4 x float> [ %acc_o.sroa.34.1, %if.end226.1 ], [ %249, %if.end288.1 ], !dbg !86
  %acc_o.sroa.0.2 = phi <4 x float> [ %acc_o.sroa.0.1, %if.end226.1 ], [ %248, %if.end288.1 ], !dbg !86
  %sum_acc.sroa.56.4 = phi float [ %sum_acc.sroa.56.3, %if.end226.1 ], [ %add339.3.1, %if.end288.1 ], !dbg !86
  %sum_acc.sroa.38.4 = phi float [ %sum_acc.sroa.38.3, %if.end226.1 ], [ %add339.2.1, %if.end288.1 ], !dbg !86
  %sum_acc.sroa.20.4 = phi float [ %sum_acc.sroa.20.3, %if.end226.1 ], [ %add339.1.1, %if.end288.1 ], !dbg !86
  %sum_acc.sroa.0.4 = phi float [ %sum_acc.sroa.0.3, %if.end226.1 ], [ %add339.11341, %if.end288.1 ], !dbg !86
  br i1 %or.cond1290.1, label %if.end525.1, label %for.cond383.preheader.1, !dbg !109

for.cond383.preheader.1:                          ; preds = %if.end375.1
  %252 = shl nsw i32 %cond.i.i1212.5, 10
  %mul391.1 = and i32 %252, 64512
  %add395.1 = add nuw nsw i32 %add105, %mul391.1
  %idxprom401.11342 = zext nneg i32 %add395.1 to i64, !dbg !110
  %arrayidx402.11343 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom401.11342, !dbg !110
  %253 = load <4 x half>, ptr addrspace(4) %arrayidx402.11343, align 2, !dbg !111, !tbaa !63
  %add398.4.1 = or disjoint i32 %add395.1, 4, !dbg !112
  %idxprom401.4.1 = zext nneg i32 %add398.4.1 to i64, !dbg !110
  %arrayidx402.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom401.4.1, !dbg !110
  %254 = load <4 x half>, ptr addrspace(4) %arrayidx402.4.1, align 2, !dbg !111, !tbaa !63
  %255 = zext nneg i32 %add395.1 to i64, !dbg !110
  %256 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %255, !dbg !110
  %arrayidx402.8.1 = getelementptr inbounds i8, ptr addrspace(4) %256, i64 1024, !dbg !110
  %257 = load <4 x half>, ptr addrspace(4) %arrayidx402.8.1, align 2, !dbg !111, !tbaa !63
  %258 = zext nneg i32 %add395.1 to i64, !dbg !110
  %259 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %258, !dbg !110
  %arrayidx402.12.1 = getelementptr inbounds i8, ptr addrspace(4) %259, i64 1032, !dbg !110
  %260 = load <4 x half>, ptr addrspace(4) %arrayidx402.12.1, align 2, !dbg !111, !tbaa !63
  %cmp412.1 = icmp sgt i32 %mul12.5, %invariant.op, !dbg !113
  br i1 %cmp412.1, label %for.cond414.preheader.1, label %if.end438.1, !dbg !114

for.cond414.preheader.1:                          ; preds = %for.cond383.preheader.1
  %add421.1 = add nuw nsw i32 %mul12.5, %mul271
  %cmp424.not.11345 = icmp sgt i32 %add421.1, %1, !dbg !115
  %fneg.1201.11346 = select i1 %cmp424.not.11345, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1513 = insertelement <4 x float> poison, float %fneg.1201.11346, i64 0, !dbg !116
  %cmp424.not.1.1.not = icmp slt i32 %add421.1, %1, !dbg !115
  %fneg.1201.1.1 = select i1 %cmp424.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1610 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1513, float %fneg.1201.1.1, i64 1, !dbg !116
  %add422.2.1 = or disjoint i32 %add421.1, 2, !dbg !117
  %cmp424.not.2.1 = icmp sgt i32 %add422.2.1, %1, !dbg !115
  %fneg.1201.2.1 = select i1 %cmp424.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1703 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1610, float %fneg.1201.2.1, i64 2, !dbg !116
  %add422.3.1 = or disjoint i32 %add421.1, 3, !dbg !117
  %cmp424.not.3.1 = icmp sgt i32 %add422.3.1, %1, !dbg !115
  %fneg.1201.3.1 = select i1 %cmp424.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1796 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1703, float %fneg.1201.3.1, i64 3, !dbg !116
  br label %if.end438.1

if.end438.1:                                      ; preds = %for.cond383.preheader.1, %for.cond414.preheader.1
  %acc_s.sroa.0.10 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1796, %for.cond414.preheader.1 ], [ zeroinitializer, %for.cond383.preheader.1 ], !dbg !86
  %261 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.10), !dbg !118, !call_argsrelate !88
  %262 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.12.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %261), !dbg !118, !call_argsrelate !88
  %263 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.22.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %262), !dbg !118, !call_argsrelate !88
  %264 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg1.sroa.32.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %263), !dbg !118, !call_argsrelate !88
  %acc_s.sroa.0.0.vec.extract1515 = extractelement <4 x float> %264, i64 0, !dbg !119
  %mul473.11350 = fmul contract float %acc_s.sroa.0.0.vec.extract1515, 0x3FB99999A0000000, !dbg !120
  %265 = tail call contract noundef float @llvm.minnum.f32(float %mul473.11350, float 0x4024CB5EC0000000), !dbg !121
  %266 = tail call contract noundef float @llvm.exp.f32(float %265), !dbg !123
  %acc_s.sroa.0.4.vec.extract1612 = extractelement <4 x float> %264, i64 1, !dbg !119
  %mul473.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1612, 0x3FB99999A0000000, !dbg !120
  %267 = tail call contract noundef float @llvm.minnum.f32(float %mul473.1.1, float 0x4024CB5EC0000000), !dbg !121
  %268 = tail call contract noundef float @llvm.exp.f32(float %267), !dbg !123
  %acc_s.sroa.0.8.vec.extract1705 = extractelement <4 x float> %264, i64 2, !dbg !119
  %mul473.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1705, 0x3FB99999A0000000, !dbg !120
  %269 = tail call contract noundef float @llvm.minnum.f32(float %mul473.2.1, float 0x4024CB5EC0000000), !dbg !121
  %270 = tail call contract noundef float @llvm.exp.f32(float %269), !dbg !123
  %acc_s.sroa.0.12.vec.extract1798 = extractelement <4 x float> %264, i64 3, !dbg !119
  %mul473.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1798, 0x3FB99999A0000000, !dbg !120
  %271 = tail call contract noundef float @llvm.minnum.f32(float %mul473.3.1, float 0x4024CB5EC0000000), !dbg !121
  %272 = tail call contract noundef float @llvm.exp.f32(float %271), !dbg !123
  %add489.11351 = fadd contract float %sum_acc.sroa.0.4, %266, !dbg !125
  %add489.1.1 = fadd contract float %sum_acc.sroa.20.4, %268, !dbg !125
  %add489.2.1 = fadd contract float %sum_acc.sroa.38.4, %270, !dbg !125
  %add489.3.1 = fadd contract float %sum_acc.sroa.56.4, %272, !dbg !125
  %273 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %266), !dbg !126
  %274 = insertelement <4 x i16> poison, i16 %273, i64 0, !dbg !130
  %275 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %268), !dbg !126
  %276 = insertelement <4 x i16> %274, i16 %275, i64 1, !dbg !130
  %277 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %270), !dbg !126
  %278 = insertelement <4 x i16> %276, i16 %277, i64 2, !dbg !130
  %279 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %272), !dbg !126
  %280 = insertelement <4 x i16> %278, i16 %279, i64 3, !dbg !130
  %acc_s_cast.sroa.0.6.vec.insert1440 = bitcast <4 x i16> %280 to <4 x half>, !dbg !130
  %281 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %253, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1440, <4 x float> %acc_o_alt.sroa.0.1), !dbg !131, !call_argsrelate !108
  %282 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %254, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1440, <4 x float> %acc_o_alt.sroa.18.1), !dbg !131, !call_argsrelate !108
  %283 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %257, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1440, <4 x float> %acc_o_alt.sroa.34.1), !dbg !131, !call_argsrelate !108
  %284 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %260, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1440, <4 x float> %acc_o_alt.sroa.50.1), !dbg !131, !call_argsrelate !108
  br label %if.end525.1, !dbg !132

if.end525.1:                                      ; preds = %if.end438.1, %if.end375.1
  %acc_o_alt.sroa.50.2 = phi <4 x float> [ %acc_o_alt.sroa.50.1, %if.end375.1 ], [ %284, %if.end438.1 ], !dbg !86
  %acc_o_alt.sroa.34.2 = phi <4 x float> [ %acc_o_alt.sroa.34.1, %if.end375.1 ], [ %283, %if.end438.1 ], !dbg !86
  %acc_o_alt.sroa.18.2 = phi <4 x float> [ %acc_o_alt.sroa.18.1, %if.end375.1 ], [ %282, %if.end438.1 ], !dbg !86
  %acc_o_alt.sroa.0.2 = phi <4 x float> [ %acc_o_alt.sroa.0.1, %if.end375.1 ], [ %281, %if.end438.1 ], !dbg !86
  %sum_acc.sroa.56.5 = phi float [ %sum_acc.sroa.56.4, %if.end375.1 ], [ %add489.3.1, %if.end438.1 ], !dbg !86
  %sum_acc.sroa.38.5 = phi float [ %sum_acc.sroa.38.4, %if.end375.1 ], [ %add489.2.1, %if.end438.1 ], !dbg !86
  %sum_acc.sroa.20.5 = phi float [ %sum_acc.sroa.20.4, %if.end375.1 ], [ %add489.1.1, %if.end438.1 ], !dbg !86
  %sum_acc.sroa.0.5 = phi float [ %sum_acc.sroa.0.4, %if.end375.1 ], [ %add489.11351, %if.end438.1 ], !dbg !86
  br i1 %or.cond1292.1, label %if.end675.1, label %for.cond533.preheader.1, !dbg !132

for.cond533.preheader.1:                          ; preds = %if.end525.1
  %285 = shl nsw i32 %cond.i.i1212.6, 10
  %mul541.1 = and i32 %285, 64512
  %add545.1 = add nuw nsw i32 %add105, %mul541.1
  %idxprom551.11352 = zext nneg i32 %add545.1 to i64, !dbg !133
  %arrayidx552.11353 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom551.11352, !dbg !133
  %286 = load <4 x half>, ptr addrspace(4) %arrayidx552.11353, align 2, !dbg !134, !tbaa !63
  %add548.4.1 = or disjoint i32 %add545.1, 4, !dbg !135
  %idxprom551.4.1 = zext nneg i32 %add548.4.1 to i64, !dbg !133
  %arrayidx552.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom551.4.1, !dbg !133
  %287 = load <4 x half>, ptr addrspace(4) %arrayidx552.4.1, align 2, !dbg !134, !tbaa !63
  %288 = zext nneg i32 %add545.1 to i64, !dbg !133
  %289 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %288, !dbg !133
  %arrayidx552.8.1 = getelementptr inbounds i8, ptr addrspace(4) %289, i64 1024, !dbg !133
  %290 = load <4 x half>, ptr addrspace(4) %arrayidx552.8.1, align 2, !dbg !134, !tbaa !63
  %291 = zext nneg i32 %add545.1 to i64, !dbg !133
  %292 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %291, !dbg !133
  %arrayidx552.12.1 = getelementptr inbounds i8, ptr addrspace(4) %292, i64 1032, !dbg !133
  %293 = load <4 x half>, ptr addrspace(4) %arrayidx552.12.1, align 2, !dbg !134, !tbaa !63
  %cmp562.1 = icmp sgt i32 %mul12.6, %invariant.op, !dbg !136
  br i1 %cmp562.1, label %for.cond564.preheader.1, label %if.end588.1, !dbg !137

for.cond564.preheader.1:                          ; preds = %for.cond533.preheader.1
  %add571.1 = add nuw nsw i32 %mul12.6, %mul271
  %cmp574.not.11355 = icmp sgt i32 %add571.1, %1, !dbg !138
  %fneg.1202.11356 = select i1 %cmp574.not.11355, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1525 = insertelement <4 x float> poison, float %fneg.1202.11356, i64 0, !dbg !139
  %cmp574.not.1.1.not = icmp slt i32 %add571.1, %1, !dbg !138
  %fneg.1202.1.1 = select i1 %cmp574.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1620 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1525, float %fneg.1202.1.1, i64 1, !dbg !139
  %add572.2.1 = or disjoint i32 %add571.1, 2, !dbg !140
  %cmp574.not.2.1 = icmp sgt i32 %add572.2.1, %1, !dbg !138
  %fneg.1202.2.1 = select i1 %cmp574.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1713 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1620, float %fneg.1202.2.1, i64 2, !dbg !139
  %add572.3.1 = or disjoint i32 %add571.1, 3, !dbg !140
  %cmp574.not.3.1 = icmp sgt i32 %add572.3.1, %1, !dbg !138
  %fneg.1202.3.1 = select i1 %cmp574.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1806 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1713, float %fneg.1202.3.1, i64 3, !dbg !139
  br label %if.end588.1

if.end588.1:                                      ; preds = %for.cond533.preheader.1, %for.cond564.preheader.1
  %acc_s.sroa.0.12 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1806, %for.cond564.preheader.1 ], [ zeroinitializer, %for.cond533.preheader.1 ], !dbg !86
  %294 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.12), !dbg !141, !call_argsrelate !88
  %295 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.12.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %294), !dbg !141, !call_argsrelate !88
  %296 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.22.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %295), !dbg !141, !call_argsrelate !88
  %297 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg2.sroa.32.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %296), !dbg !141, !call_argsrelate !88
  %acc_s.sroa.0.0.vec.extract1527 = extractelement <4 x float> %297, i64 0, !dbg !142
  %mul623.11360 = fmul contract float %acc_s.sroa.0.0.vec.extract1527, 0x3FB99999A0000000, !dbg !143
  %298 = tail call contract noundef float @llvm.minnum.f32(float %mul623.11360, float 0x4024CB5EC0000000), !dbg !144
  %299 = tail call contract noundef float @llvm.exp.f32(float %298), !dbg !146
  %acc_s.sroa.0.4.vec.extract1622 = extractelement <4 x float> %297, i64 1, !dbg !142
  %mul623.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1622, 0x3FB99999A0000000, !dbg !143
  %300 = tail call contract noundef float @llvm.minnum.f32(float %mul623.1.1, float 0x4024CB5EC0000000), !dbg !144
  %301 = tail call contract noundef float @llvm.exp.f32(float %300), !dbg !146
  %acc_s.sroa.0.8.vec.extract1715 = extractelement <4 x float> %297, i64 2, !dbg !142
  %mul623.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1715, 0x3FB99999A0000000, !dbg !143
  %302 = tail call contract noundef float @llvm.minnum.f32(float %mul623.2.1, float 0x4024CB5EC0000000), !dbg !144
  %303 = tail call contract noundef float @llvm.exp.f32(float %302), !dbg !146
  %acc_s.sroa.0.12.vec.extract1808 = extractelement <4 x float> %297, i64 3, !dbg !142
  %mul623.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1808, 0x3FB99999A0000000, !dbg !143
  %304 = tail call contract noundef float @llvm.minnum.f32(float %mul623.3.1, float 0x4024CB5EC0000000), !dbg !144
  %305 = tail call contract noundef float @llvm.exp.f32(float %304), !dbg !146
  %add639.11361 = fadd contract float %sum_acc.sroa.0.5, %299, !dbg !148
  %add639.1.1 = fadd contract float %sum_acc.sroa.20.5, %301, !dbg !148
  %add639.2.1 = fadd contract float %sum_acc.sroa.38.5, %303, !dbg !148
  %add639.3.1 = fadd contract float %sum_acc.sroa.56.5, %305, !dbg !148
  %306 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %299), !dbg !149
  %307 = insertelement <4 x i16> poison, i16 %306, i64 0, !dbg !153
  %308 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %301), !dbg !149
  %309 = insertelement <4 x i16> %307, i16 %308, i64 1, !dbg !153
  %310 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %303), !dbg !149
  %311 = insertelement <4 x i16> %309, i16 %310, i64 2, !dbg !153
  %312 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %305), !dbg !149
  %313 = insertelement <4 x i16> %311, i16 %312, i64 3, !dbg !153
  %acc_s_cast.sroa.0.6.vec.insert1442 = bitcast <4 x i16> %313 to <4 x half>, !dbg !153
  %314 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %286, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1442, <4 x float> %acc_o.sroa.0.2), !dbg !154, !call_argsrelate !108
  %315 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %287, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1442, <4 x float> %acc_o.sroa.34.2), !dbg !154, !call_argsrelate !108
  %316 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %290, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1442, <4 x float> %acc_o.sroa.66.2), !dbg !154, !call_argsrelate !108
  %317 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %293, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1442, <4 x float> %acc_o.sroa.98.2), !dbg !154, !call_argsrelate !108
  br label %if.end675.1, !dbg !155

if.end675.1:                                      ; preds = %if.end588.1, %if.end525.1
  %acc_o.sroa.98.3 = phi <4 x float> [ %acc_o.sroa.98.2, %if.end525.1 ], [ %317, %if.end588.1 ], !dbg !86
  %acc_o.sroa.66.3 = phi <4 x float> [ %acc_o.sroa.66.2, %if.end525.1 ], [ %316, %if.end588.1 ], !dbg !86
  %acc_o.sroa.34.3 = phi <4 x float> [ %acc_o.sroa.34.2, %if.end525.1 ], [ %315, %if.end588.1 ], !dbg !86
  %acc_o.sroa.0.3 = phi <4 x float> [ %acc_o.sroa.0.2, %if.end525.1 ], [ %314, %if.end588.1 ], !dbg !86
  %sum_acc.sroa.56.6 = phi float [ %sum_acc.sroa.56.5, %if.end525.1 ], [ %add639.3.1, %if.end588.1 ], !dbg !86
  %sum_acc.sroa.38.6 = phi float [ %sum_acc.sroa.38.5, %if.end525.1 ], [ %add639.2.1, %if.end588.1 ], !dbg !86
  %sum_acc.sroa.20.6 = phi float [ %sum_acc.sroa.20.5, %if.end525.1 ], [ %add639.1.1, %if.end588.1 ], !dbg !86
  %sum_acc.sroa.0.6 = phi float [ %sum_acc.sroa.0.5, %if.end525.1 ], [ %add639.11361, %if.end588.1 ], !dbg !86
  br i1 %or.cond1294.1, label %if.end825.1, label %for.cond683.preheader.1, !dbg !155

for.cond683.preheader.1:                          ; preds = %if.end675.1
  %318 = shl nsw i32 %cond.i.i1212.7, 10
  %mul691.1 = and i32 %318, 64512
  %add695.1 = add nuw nsw i32 %add105, %mul691.1
  %idxprom701.11362 = zext nneg i32 %add695.1 to i64, !dbg !156
  %arrayidx702.11363 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom701.11362, !dbg !156
  %319 = load <4 x half>, ptr addrspace(4) %arrayidx702.11363, align 2, !dbg !157, !tbaa !63
  %add698.4.1 = or disjoint i32 %add695.1, 4, !dbg !158
  %idxprom701.4.1 = zext nneg i32 %add698.4.1 to i64, !dbg !156
  %arrayidx702.4.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %idxprom701.4.1, !dbg !156
  %320 = load <4 x half>, ptr addrspace(4) %arrayidx702.4.1, align 2, !dbg !157, !tbaa !63
  %321 = zext nneg i32 %add695.1 to i64, !dbg !156
  %322 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %321, !dbg !156
  %arrayidx702.8.1 = getelementptr inbounds i8, ptr addrspace(4) %322, i64 1024, !dbg !156
  %323 = load <4 x half>, ptr addrspace(4) %arrayidx702.8.1, align 2, !dbg !157, !tbaa !63
  %324 = zext nneg i32 %add695.1 to i64, !dbg !156
  %325 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %324, !dbg !156
  %arrayidx702.12.1 = getelementptr inbounds i8, ptr addrspace(4) %325, i64 1032, !dbg !156
  %326 = load <4 x half>, ptr addrspace(4) %arrayidx702.12.1, align 2, !dbg !157, !tbaa !63
  %cmp712.1 = icmp sgt i32 %mul12.7, %invariant.op, !dbg !159
  br i1 %cmp712.1, label %for.cond714.preheader.1, label %if.end738.1, !dbg !160

for.cond714.preheader.1:                          ; preds = %for.cond683.preheader.1
  %add721.1 = add nuw nsw i32 %mul12.7, %mul271
  %cmp724.not.11365 = icmp sgt i32 %add721.1, %1, !dbg !161
  %fneg.1203.11366 = select i1 %cmp724.not.11365, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.0.vec.insert1537 = insertelement <4 x float> poison, float %fneg.1203.11366, i64 0, !dbg !162
  %cmp724.not.1.1.not = icmp slt i32 %add721.1, %1, !dbg !161
  %fneg.1203.1.1 = select i1 %cmp724.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000
  %acc_s.sroa.0.4.vec.insert1630 = insertelement <4 x float> %acc_s.sroa.0.0.vec.insert1537, float %fneg.1203.1.1, i64 1, !dbg !162
  %add722.2.1 = or disjoint i32 %add721.1, 2, !dbg !163
  %cmp724.not.2.1 = icmp sgt i32 %add722.2.1, %1, !dbg !161
  %fneg.1203.2.1 = select i1 %cmp724.not.2.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.8.vec.insert1723 = insertelement <4 x float> %acc_s.sroa.0.4.vec.insert1630, float %fneg.1203.2.1, i64 2, !dbg !162
  %add722.3.1 = or disjoint i32 %add721.1, 3, !dbg !163
  %cmp724.not.3.1 = icmp sgt i32 %add722.3.1, %1, !dbg !161
  %fneg.1203.3.1 = select i1 %cmp724.not.3.1, float 0xFFF0000000000000, float 0.000000e+00
  %acc_s.sroa.0.12.vec.insert1816 = insertelement <4 x float> %acc_s.sroa.0.8.vec.insert1723, float %fneg.1203.3.1, i64 3, !dbg !162
  br label %if.end738.1

if.end738.1:                                      ; preds = %for.cond683.preheader.1, %for.cond714.preheader.1
  %acc_s.sroa.0.14 = phi <4 x float> [ %acc_s.sroa.0.12.vec.insert1816, %for.cond714.preheader.1 ], [ zeroinitializer, %for.cond683.preheader.1 ], !dbg !86
  %327 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.0.1, <4 x half> %Q_reg.sroa.0.0.copyload, <4 x float> %acc_s.sroa.0.14), !dbg !164, !call_argsrelate !88
  %328 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.12.1, <4 x half> %Q_reg.sroa.11.0.copyload, <4 x float> %327), !dbg !164, !call_argsrelate !88
  %329 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.22.1, <4 x half> %Q_reg.sroa.19.16.copyload, <4 x float> %328), !dbg !164, !call_argsrelate !88
  %330 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %K_reg3.sroa.32.1, <4 x half> %Q_reg.sroa.28.16.copyload, <4 x float> %329), !dbg !164, !call_argsrelate !88
  %acc_s.sroa.0.0.vec.extract1539 = extractelement <4 x float> %330, i64 0, !dbg !165
  %mul773.11370 = fmul contract float %acc_s.sroa.0.0.vec.extract1539, 0x3FB99999A0000000, !dbg !166
  %331 = tail call contract noundef float @llvm.minnum.f32(float %mul773.11370, float 0x4024CB5EC0000000), !dbg !167
  %332 = tail call contract noundef float @llvm.exp.f32(float %331), !dbg !169
  %acc_s.sroa.0.4.vec.extract1632 = extractelement <4 x float> %330, i64 1, !dbg !165
  %mul773.1.1 = fmul contract float %acc_s.sroa.0.4.vec.extract1632, 0x3FB99999A0000000, !dbg !166
  %333 = tail call contract noundef float @llvm.minnum.f32(float %mul773.1.1, float 0x4024CB5EC0000000), !dbg !167
  %334 = tail call contract noundef float @llvm.exp.f32(float %333), !dbg !169
  %acc_s.sroa.0.8.vec.extract1725 = extractelement <4 x float> %330, i64 2, !dbg !165
  %mul773.2.1 = fmul contract float %acc_s.sroa.0.8.vec.extract1725, 0x3FB99999A0000000, !dbg !166
  %335 = tail call contract noundef float @llvm.minnum.f32(float %mul773.2.1, float 0x4024CB5EC0000000), !dbg !167
  %336 = tail call contract noundef float @llvm.exp.f32(float %335), !dbg !169
  %acc_s.sroa.0.12.vec.extract1818 = extractelement <4 x float> %330, i64 3, !dbg !165
  %mul773.3.1 = fmul contract float %acc_s.sroa.0.12.vec.extract1818, 0x3FB99999A0000000, !dbg !166
  %337 = tail call contract noundef float @llvm.minnum.f32(float %mul773.3.1, float 0x4024CB5EC0000000), !dbg !167
  %338 = tail call contract noundef float @llvm.exp.f32(float %337), !dbg !169
  %add789.11371 = fadd contract float %sum_acc.sroa.0.6, %332, !dbg !171
  %add789.1.1 = fadd contract float %sum_acc.sroa.20.6, %334, !dbg !171
  %add789.2.1 = fadd contract float %sum_acc.sroa.38.6, %336, !dbg !171
  %add789.3.1 = fadd contract float %sum_acc.sroa.56.6, %338, !dbg !171
  %339 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %332), !dbg !172
  %340 = insertelement <4 x i16> poison, i16 %339, i64 0, !dbg !176
  %341 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %334), !dbg !172
  %342 = insertelement <4 x i16> %340, i16 %341, i64 1, !dbg !176
  %343 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %336), !dbg !172
  %344 = insertelement <4 x i16> %342, i16 %343, i64 2, !dbg !176
  %345 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %338), !dbg !172
  %346 = insertelement <4 x i16> %344, i16 %345, i64 3, !dbg !176
  %acc_s_cast.sroa.0.6.vec.insert1444 = bitcast <4 x i16> %346 to <4 x half>, !dbg !176
  %347 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %319, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1444, <4 x float> %acc_o_alt.sroa.0.2), !dbg !177, !call_argsrelate !108
  %348 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %320, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1444, <4 x float> %acc_o_alt.sroa.18.2), !dbg !177, !call_argsrelate !108
  %349 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %323, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1444, <4 x float> %acc_o_alt.sroa.34.2), !dbg !177, !call_argsrelate !108
  %350 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %326, <4 x half> %acc_s_cast.sroa.0.6.vec.insert1444, <4 x float> %acc_o_alt.sroa.50.2), !dbg !177, !call_argsrelate !108
  br label %if.end825.1, !dbg !178

if.end825.1:                                      ; preds = %if.end738.1, %if.end675.1
  %acc_o_alt.sroa.50.3 = phi <4 x float> [ %acc_o_alt.sroa.50.2, %if.end675.1 ], [ %350, %if.end738.1 ], !dbg !86
  %acc_o_alt.sroa.34.3 = phi <4 x float> [ %acc_o_alt.sroa.34.2, %if.end675.1 ], [ %349, %if.end738.1 ], !dbg !86
  %acc_o_alt.sroa.18.3 = phi <4 x float> [ %acc_o_alt.sroa.18.2, %if.end675.1 ], [ %348, %if.end738.1 ], !dbg !86
  %acc_o_alt.sroa.0.3 = phi <4 x float> [ %acc_o_alt.sroa.0.2, %if.end675.1 ], [ %347, %if.end738.1 ], !dbg !86
  %sum_acc.sroa.56.7 = phi float [ %sum_acc.sroa.56.6, %if.end675.1 ], [ %add789.3.1, %if.end738.1 ], !dbg !86
  %sum_acc.sroa.38.7 = phi float [ %sum_acc.sroa.38.6, %if.end675.1 ], [ %add789.2.1, %if.end738.1 ], !dbg !86
  %sum_acc.sroa.20.7 = phi float [ %sum_acc.sroa.20.6, %if.end675.1 ], [ %add789.1.1, %if.end738.1 ], !dbg !86
  %sum_acc.sroa.0.7 = phi float [ %sum_acc.sroa.0.6, %if.end675.1 ], [ %add789.11371, %if.end738.1 ], !dbg !86
  %acc_o.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 0, !dbg !180
  %acc_o_alt.sroa.0.0.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 0, !dbg !181
  %add837 = fadd contract float %acc_o.sroa.0.0.vec.extract, %acc_o_alt.sroa.0.0.vec.extract, !dbg !182
  %acc_o.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 1, !dbg !180
  %acc_o_alt.sroa.0.4.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 1, !dbg !181
  %add837.1 = fadd contract float %acc_o.sroa.0.4.vec.extract, %acc_o_alt.sroa.0.4.vec.extract, !dbg !182
  %acc_o.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 2, !dbg !180
  %acc_o_alt.sroa.0.8.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 2, !dbg !181
  %add837.2 = fadd contract float %acc_o.sroa.0.8.vec.extract, %acc_o_alt.sroa.0.8.vec.extract, !dbg !182
  %acc_o.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o.sroa.0.3, i64 3, !dbg !180
  %acc_o_alt.sroa.0.12.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.0.3, i64 3, !dbg !181
  %add837.3 = fadd contract float %acc_o.sroa.0.12.vec.extract, %acc_o_alt.sroa.0.12.vec.extract, !dbg !182
  %acc_o.sroa.34.16.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 0, !dbg !180
  %acc_o_alt.sroa.18.16.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 0, !dbg !181
  %add837.4 = fadd contract float %acc_o.sroa.34.16.vec.extract, %acc_o_alt.sroa.18.16.vec.extract, !dbg !182
  %acc_o.sroa.34.20.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 1, !dbg !180
  %acc_o_alt.sroa.18.20.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 1, !dbg !181
  %add837.5 = fadd contract float %acc_o.sroa.34.20.vec.extract, %acc_o_alt.sroa.18.20.vec.extract, !dbg !182
  %acc_o.sroa.34.24.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 2, !dbg !180
  %acc_o_alt.sroa.18.24.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 2, !dbg !181
  %add837.6 = fadd contract float %acc_o.sroa.34.24.vec.extract, %acc_o_alt.sroa.18.24.vec.extract, !dbg !182
  %acc_o.sroa.34.28.vec.extract = extractelement <4 x float> %acc_o.sroa.34.3, i64 3, !dbg !180
  %acc_o_alt.sroa.18.28.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.18.3, i64 3, !dbg !181
  %add837.7 = fadd contract float %acc_o.sroa.34.28.vec.extract, %acc_o_alt.sroa.18.28.vec.extract, !dbg !182
  %acc_o.sroa.66.32.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 0, !dbg !180
  %acc_o_alt.sroa.34.32.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 0, !dbg !181
  %add837.8 = fadd contract float %acc_o.sroa.66.32.vec.extract, %acc_o_alt.sroa.34.32.vec.extract, !dbg !182
  %acc_o.sroa.66.36.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 1, !dbg !180
  %acc_o_alt.sroa.34.36.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 1, !dbg !181
  %add837.9 = fadd contract float %acc_o.sroa.66.36.vec.extract, %acc_o_alt.sroa.34.36.vec.extract, !dbg !182
  %acc_o.sroa.66.40.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 2, !dbg !180
  %acc_o_alt.sroa.34.40.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 2, !dbg !181
  %add837.10 = fadd contract float %acc_o.sroa.66.40.vec.extract, %acc_o_alt.sroa.34.40.vec.extract, !dbg !182
  %acc_o.sroa.66.44.vec.extract = extractelement <4 x float> %acc_o.sroa.66.3, i64 3, !dbg !180
  %acc_o_alt.sroa.34.44.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.34.3, i64 3, !dbg !181
  %add837.11 = fadd contract float %acc_o.sroa.66.44.vec.extract, %acc_o_alt.sroa.34.44.vec.extract, !dbg !182
  %acc_o.sroa.98.48.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 0, !dbg !180
  %acc_o_alt.sroa.50.48.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 0, !dbg !181
  %add837.12 = fadd contract float %acc_o.sroa.98.48.vec.extract, %acc_o_alt.sroa.50.48.vec.extract, !dbg !182
  %acc_o.sroa.98.52.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 1, !dbg !180
  %acc_o_alt.sroa.50.52.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 1, !dbg !181
  %add837.13 = fadd contract float %acc_o.sroa.98.52.vec.extract, %acc_o_alt.sroa.50.52.vec.extract, !dbg !182
  %acc_o.sroa.98.56.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 2, !dbg !180
  %acc_o_alt.sroa.50.56.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 2, !dbg !181
  %add837.14 = fadd contract float %acc_o.sroa.98.56.vec.extract, %acc_o_alt.sroa.50.56.vec.extract, !dbg !182
  %acc_o.sroa.98.60.vec.extract = extractelement <4 x float> %acc_o.sroa.98.3, i64 3, !dbg !180
  %acc_o_alt.sroa.50.60.vec.extract = extractelement <4 x float> %acc_o_alt.sroa.50.3, i64 3, !dbg !181
  %add837.15 = fadd contract float %acc_o.sroa.98.60.vec.extract, %acc_o_alt.sroa.50.60.vec.extract, !dbg !182
  %add851 = fadd contract float %sum_acc.sroa.0.7, 0.000000e+00, !dbg !183
  %add851.1 = fadd contract float %add851, %sum_acc.sroa.20.7, !dbg !183
  %add851.2 = fadd contract float %add851.1, %sum_acc.sroa.38.7, !dbg !183
  %add851.3 = fadd contract float %add851.2, %sum_acc.sroa.56.7, !dbg !183
  %351 = bitcast float %add851.3 to i32, !dbg !184
  %352 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !196
  %353 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %352) #11, !dbg !201
  %xor.i.i = xor i32 %353, 32, !dbg !202
  %354 = and i32 %353, -64, !dbg !203
  %and.i.i = add nsw i32 %354, 64, !dbg !203
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !204
  %cond.i.i1213 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %353, !dbg !205
  %shl.i.i = shl i32 %cond.i.i1213, 2, !dbg !206
  %355 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %351), !dbg !207
  %356 = bitcast i32 %355 to float, !dbg !208
  %add.i = fadd contract float %add851.3, %356, !dbg !209
  %357 = bitcast float %add.i to i32, !dbg !212
  %358 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !219
  %359 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %358) #11, !dbg !222
  %xor.i.i1214 = xor i32 %359, 16, !dbg !223
  %360 = and i32 %359, -64, !dbg !224
  %and.i.i1215 = add nsw i32 %360, 64, !dbg !224
  %cmp.not.i.i1216 = icmp slt i32 %xor.i.i1214, %and.i.i1215, !dbg !225
  %cond.i.i1217 = select i1 %cmp.not.i.i1216, i32 %xor.i.i1214, i32 %359, !dbg !226
  %shl.i.i1218 = shl i32 %cond.i.i1217, 2, !dbg !227
  %361 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i1218, i32 %357), !dbg !228
  %362 = bitcast i32 %361 to float, !dbg !229
  %add.i.i = fadd contract float %add.i, %362, !dbg !230
  %cmp860 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !232
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !233
  %condval_4.0 = select i1 %cmp860, float %div, float 0.000000e+00, !dbg !233
  %mul873 = fmul contract float %condval_4.0, %add837, !dbg !234
  %mul873.1 = fmul contract float %condval_4.0, %add837.1, !dbg !234
  %mul873.2 = fmul contract float %condval_4.0, %add837.2, !dbg !234
  %mul873.3 = fmul contract float %condval_4.0, %add837.3, !dbg !234
  %mul873.4 = fmul contract float %condval_4.0, %add837.4, !dbg !234
  %mul873.5 = fmul contract float %condval_4.0, %add837.5, !dbg !234
  %mul873.6 = fmul contract float %condval_4.0, %add837.6, !dbg !234
  %mul873.7 = fmul contract float %condval_4.0, %add837.7, !dbg !234
  %mul873.8 = fmul contract float %condval_4.0, %add837.8, !dbg !234
  %mul873.9 = fmul contract float %condval_4.0, %add837.9, !dbg !234
  %mul873.10 = fmul contract float %condval_4.0, %add837.10, !dbg !234
  %mul873.11 = fmul contract float %condval_4.0, %add837.11, !dbg !234
  %mul873.12 = fmul contract float %condval_4.0, %add837.12, !dbg !234
  %mul873.13 = fmul contract float %condval_4.0, %add837.13, !dbg !234
  %mul873.14 = fmul contract float %condval_4.0, %add837.14, !dbg !234
  %mul873.15 = fmul contract float %condval_4.0, %add837.15, !dbg !234
  %363 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873), !dbg !235
  %O_reg.sroa.0.0.insert.ext = zext i16 %363 to i64, !dbg !239
  %364 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873.1), !dbg !235
  %O_reg.sroa.0.2.insert.ext = zext i16 %364 to i64, !dbg !239
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !239
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !239
  %365 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873.2), !dbg !235
  %O_reg.sroa.0.4.insert.ext = zext i16 %365 to i64, !dbg !239
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !239
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !239
  %366 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873.3), !dbg !235
  %O_reg.sroa.0.6.insert.ext = zext i16 %366 to i64, !dbg !239
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !239
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !239
  %367 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873.4), !dbg !235
  %O_reg.sroa.7.8.insert.ext = zext i16 %367 to i64, !dbg !239
  %368 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873.5), !dbg !235
  %O_reg.sroa.7.10.insert.ext = zext i16 %368 to i64, !dbg !239
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !239
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !239
  %369 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873.6), !dbg !235
  %O_reg.sroa.7.12.insert.ext = zext i16 %369 to i64, !dbg !239
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !239
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !239
  %370 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873.7), !dbg !235
  %O_reg.sroa.7.14.insert.ext = zext i16 %370 to i64, !dbg !239
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !239
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !239
  %371 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873.8), !dbg !235
  %O_reg.sroa.12.16.insert.ext = zext i16 %371 to i64, !dbg !239
  %372 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873.9), !dbg !235
  %O_reg.sroa.12.18.insert.ext = zext i16 %372 to i64, !dbg !239
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !239
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !239
  %373 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873.10), !dbg !235
  %O_reg.sroa.12.20.insert.ext = zext i16 %373 to i64, !dbg !239
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !239
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !239
  %374 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873.11), !dbg !235
  %O_reg.sroa.12.22.insert.ext = zext i16 %374 to i64, !dbg !239
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !239
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !239
  %375 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873.12), !dbg !235
  %O_reg.sroa.17.24.insert.ext = zext i16 %375 to i64, !dbg !239
  %376 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873.13), !dbg !235
  %O_reg.sroa.17.26.insert.ext = zext i16 %376 to i64, !dbg !239
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !239
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !239
  %377 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873.14), !dbg !235
  %O_reg.sroa.17.28.insert.ext = zext i16 %377 to i64, !dbg !239
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !239
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !239
  %378 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul873.15), !dbg !235
  %O_reg.sroa.17.30.insert.ext = zext i16 %378 to i64, !dbg !239
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !239
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !239
  %shr915 = lshr i32 %10, 5
  %and918 = and i32 %10, 7
  %mul924 = and i32 %14, 4
  %xor = xor i32 %shr915, %and918, !dbg !240
  %mul919 = shl nuw nsw i32 %xor, 3, !dbg !241
  %add920 = add nuw nsw i32 %mul919, %mul26, !dbg !242
  %add925 = or disjoint i32 %add920, %mul924, !dbg !243
  %add.ptr927 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add925, !dbg !244
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr927, align 8, !dbg !245
  %add916.1 = add nuw nsw i32 %shr915, 2, !dbg !246
  %xor.1 = xor i32 %add916.1, %and918, !dbg !240
  %mul919.1 = shl nuw nsw i32 %xor.1, 3, !dbg !241
  %add920.1 = add nuw nsw i32 %mul919.1, %mul26, !dbg !242
  %add925.1 = or disjoint i32 %add920.1, %mul924, !dbg !243
  %add.ptr927.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add925.1, !dbg !244
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr927.1, align 8, !dbg !245
  %add916.2 = add nuw nsw i32 %shr915, 4, !dbg !246
  %xor.2 = xor i32 %add916.2, %and918, !dbg !240
  %mul919.2 = shl nuw nsw i32 %xor.2, 3, !dbg !241
  %add920.2 = add nuw nsw i32 %mul919.2, %mul26, !dbg !242
  %add925.2 = or disjoint i32 %add920.2, %mul924, !dbg !243
  %add.ptr927.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add925.2, !dbg !244
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr927.2, align 8, !dbg !245
  %add916.3 = add nuw nsw i32 %shr915, 6, !dbg !246
  %xor.3 = xor i32 %add916.3, %and918, !dbg !240
  %mul919.3 = shl nuw nsw i32 %xor.3, 3, !dbg !241
  %add920.3 = add nuw nsw i32 %mul919.3, %mul26, !dbg !242
  %add925.3 = or disjoint i32 %add920.3, %mul924, !dbg !243
  %add.ptr927.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add925.3, !dbg !244
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr927.3, align 8, !dbg !245
  fence syncscope("warp") release, !dbg !247
  tail call void @llvm.mxc.barrier.warp(), !dbg !252
  fence syncscope("warp") acquire, !dbg !253
  %mul938 = and i32 %mul110, 8128
  %xor9441199 = and i32 %mul110, 56
  %call942.masked = and i32 %10, 1016
  %mul945 = xor i32 %xor9441199, %call942.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul938, !dbg !254
  %invariant.gep1285 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul945, !dbg !254
  %add955 = add nuw nsw i32 %add24, %mul110
  %379 = zext nneg i32 %add955 to i64, !dbg !255
  %add.ptr960 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %379, !dbg !256
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr960, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep1285, i64 16, i1 false), !dbg !257, !tbaa.struct !258, !call_argsrelate !259
  %gep1286.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep1285, i32 1024, !dbg !260
  %380 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %379, !dbg !256
  %add.ptr960.1 = getelementptr inbounds i8, ptr addrspace(1) %380, i64 1024, !dbg !256
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr960.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep1286.1, i64 16, i1 false), !dbg !257, !tbaa.struct !258, !call_argsrelate !259
  ret void, !dbg !261
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
!1 = !DIFile(filename: "/tmp/tmppkutkuz_/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmppkutkuz_/tvm_kernels.maca", directory: "")
!42 = !DILocation(line: 28, column: 3, scope: !40)
!43 = !DILocation(line: 29, column: 29, scope: !40)
!44 = !DILocation(line: 29, column: 21, scope: !40)
!45 = !DILocation(line: 705, column: 10, scope: !46, inlinedAt: !48)
!46 = distinct !DISubprogram(name: "max", scope: !47, file: !47, line: 704, type: !7, scopeLine: 704, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!47 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!48 = distinct !DILocation(line: 30, column: 24, scope: !40)
!49 = !{i32 0, i32 -1}
!50 = !DILocation(line: 708, column: 10, scope: !51, inlinedAt: !52)
!51 = distinct !DISubprogram(name: "min", scope: !47, file: !47, line: 707, type: !7, scopeLine: 707, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!52 = distinct !DILocation(line: 30, column: 20, scope: !40)
!53 = !DILocation(line: 30, column: 48, scope: !40)
!54 = !DILocation(line: 29, column: 98, scope: !40)
!55 = !{i32 0, i32 1024}
!56 = !DILocation(line: 33, column: 3, scope: !40)
!57 = !DILocation(line: 34, column: 46, scope: !40)
!58 = !DILocation(line: 34, column: 32, scope: !40)
!59 = !DILocation(line: 49, column: 3, scope: !40)
!60 = !DILocation(line: 54, column: 22, scope: !40)
!61 = !DILocation(line: 57, column: 30, scope: !40)
!62 = !DILocation(line: 57, column: 22, scope: !40)
!63 = !{!26, !26, i64 0}
!64 = !DILocation(line: 57, column: 110, scope: !40)
!65 = !DILocation(line: 60, column: 22, scope: !40)
!66 = !DILocation(line: 63, column: 31, scope: !40)
!67 = !DILocation(line: 63, column: 23, scope: !40)
!68 = !DILocation(line: 63, column: 111, scope: !40)
!69 = !DILocation(line: 66, column: 22, scope: !40)
!70 = !DILocation(line: 69, column: 31, scope: !40)
!71 = !DILocation(line: 69, column: 23, scope: !40)
!72 = !DILocation(line: 69, column: 111, scope: !40)
!73 = !DILocation(line: 72, column: 22, scope: !40)
!74 = !DILocation(line: 75, column: 31, scope: !40)
!75 = !DILocation(line: 75, column: 23, scope: !40)
!76 = !DILocation(line: 75, column: 111, scope: !40)
!77 = !DILocation(line: 78, column: 22, scope: !40)
!78 = !DILocation(line: 81, column: 30, scope: !40)
!79 = !DILocation(line: 81, column: 22, scope: !40)
!80 = !DILocation(line: 81, column: 110, scope: !40)
!81 = !DILocation(line: 83, column: 29, scope: !40)
!82 = !DILocation(line: 83, column: 11, scope: !40)
!83 = !DILocation(line: 87, column: 65, scope: !40)
!84 = !DILocation(line: 92, column: 22, scope: !40)
!85 = !DILocation(line: 87, column: 58, scope: !40)
!86 = !DILocation(line: 0, scope: !40)
!87 = !DILocation(line: 101, column: 36, scope: !40)
!88 = !{i32 -1, i32 3, i32 -1}
!89 = !DILocation(line: 109, column: 32, scope: !40)
!90 = !DILocation(line: 109, column: 43, scope: !40)
!91 = !DILocation(line: 354, column: 10, scope: !92, inlinedAt: !93)
!92 = distinct !DISubprogram(name: "min", scope: !47, file: !47, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!93 = distinct !DILocation(line: 109, column: 27, scope: !40)
!94 = !DILocation(line: 288, column: 10, scope: !95, inlinedAt: !96)
!95 = distinct !DISubprogram(name: "expf", scope: !47, file: !47, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!96 = distinct !DILocation(line: 109, column: 22, scope: !40)
!97 = !DILocation(line: 75, column: 10, scope: !98, inlinedAt: !100)
!98 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !99, file: !99, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!99 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!100 = distinct !DILocation(line: 984, column: 9, scope: !101, inlinedAt: !103)
!101 = distinct !DISubprogram(name: "__float2half", scope: !102, file: !102, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!102 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!103 = distinct !DILocation(line: 133, column: 53, scope: !104, inlinedAt: !105)
!104 = distinct !DISubprogram(name: "__half", scope: !102, file: !102, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!105 = distinct !DILocation(line: 117, column: 34, scope: !40)
!106 = !DILocation(line: 117, column: 31, scope: !40)
!107 = !DILocation(line: 121, column: 36, scope: !40)
!108 = !{i32 4, i32 -1, i32 -1}
!109 = !DILocation(line: 127, column: 22, scope: !40)
!110 = !DILocation(line: 130, column: 31, scope: !40)
!111 = !DILocation(line: 130, column: 23, scope: !40)
!112 = !DILocation(line: 130, column: 112, scope: !40)
!113 = !DILocation(line: 132, column: 29, scope: !40)
!114 = !DILocation(line: 132, column: 11, scope: !40)
!115 = !DILocation(line: 136, column: 66, scope: !40)
!116 = !DILocation(line: 141, column: 23, scope: !40)
!117 = !DILocation(line: 136, column: 58, scope: !40)
!118 = !DILocation(line: 150, column: 36, scope: !40)
!119 = !DILocation(line: 158, column: 33, scope: !40)
!120 = !DILocation(line: 158, column: 45, scope: !40)
!121 = !DILocation(line: 354, column: 10, scope: !92, inlinedAt: !122)
!122 = distinct !DILocation(line: 158, column: 28, scope: !40)
!123 = !DILocation(line: 288, column: 10, scope: !95, inlinedAt: !124)
!124 = distinct !DILocation(line: 158, column: 23, scope: !40)
!125 = !DILocation(line: 162, column: 40, scope: !40)
!126 = !DILocation(line: 75, column: 10, scope: !98, inlinedAt: !127)
!127 = distinct !DILocation(line: 984, column: 9, scope: !101, inlinedAt: !128)
!128 = distinct !DILocation(line: 133, column: 53, scope: !104, inlinedAt: !129)
!129 = distinct !DILocation(line: 166, column: 36, scope: !40)
!130 = !DILocation(line: 166, column: 33, scope: !40)
!131 = !DILocation(line: 170, column: 42, scope: !40)
!132 = !DILocation(line: 176, column: 22, scope: !40)
!133 = !DILocation(line: 179, column: 31, scope: !40)
!134 = !DILocation(line: 179, column: 23, scope: !40)
!135 = !DILocation(line: 179, column: 112, scope: !40)
!136 = !DILocation(line: 181, column: 29, scope: !40)
!137 = !DILocation(line: 181, column: 11, scope: !40)
!138 = !DILocation(line: 185, column: 66, scope: !40)
!139 = !DILocation(line: 190, column: 23, scope: !40)
!140 = !DILocation(line: 185, column: 58, scope: !40)
!141 = !DILocation(line: 199, column: 36, scope: !40)
!142 = !DILocation(line: 207, column: 33, scope: !40)
!143 = !DILocation(line: 207, column: 45, scope: !40)
!144 = !DILocation(line: 354, column: 10, scope: !92, inlinedAt: !145)
!145 = distinct !DILocation(line: 207, column: 28, scope: !40)
!146 = !DILocation(line: 288, column: 10, scope: !95, inlinedAt: !147)
!147 = distinct !DILocation(line: 207, column: 23, scope: !40)
!148 = !DILocation(line: 211, column: 40, scope: !40)
!149 = !DILocation(line: 75, column: 10, scope: !98, inlinedAt: !150)
!150 = distinct !DILocation(line: 984, column: 9, scope: !101, inlinedAt: !151)
!151 = distinct !DILocation(line: 133, column: 53, scope: !104, inlinedAt: !152)
!152 = distinct !DILocation(line: 215, column: 36, scope: !40)
!153 = !DILocation(line: 215, column: 33, scope: !40)
!154 = !DILocation(line: 219, column: 38, scope: !40)
!155 = !DILocation(line: 225, column: 22, scope: !40)
!156 = !DILocation(line: 228, column: 31, scope: !40)
!157 = !DILocation(line: 228, column: 23, scope: !40)
!158 = !DILocation(line: 228, column: 112, scope: !40)
!159 = !DILocation(line: 230, column: 29, scope: !40)
!160 = !DILocation(line: 230, column: 11, scope: !40)
!161 = !DILocation(line: 234, column: 66, scope: !40)
!162 = !DILocation(line: 239, column: 23, scope: !40)
!163 = !DILocation(line: 234, column: 58, scope: !40)
!164 = !DILocation(line: 248, column: 36, scope: !40)
!165 = !DILocation(line: 256, column: 33, scope: !40)
!166 = !DILocation(line: 256, column: 45, scope: !40)
!167 = !DILocation(line: 354, column: 10, scope: !92, inlinedAt: !168)
!168 = distinct !DILocation(line: 256, column: 28, scope: !40)
!169 = !DILocation(line: 288, column: 10, scope: !95, inlinedAt: !170)
!170 = distinct !DILocation(line: 256, column: 23, scope: !40)
!171 = !DILocation(line: 260, column: 40, scope: !40)
!172 = !DILocation(line: 75, column: 10, scope: !98, inlinedAt: !173)
!173 = distinct !DILocation(line: 984, column: 9, scope: !101, inlinedAt: !174)
!174 = distinct !DILocation(line: 133, column: 53, scope: !104, inlinedAt: !175)
!175 = distinct !DILocation(line: 264, column: 36, scope: !40)
!176 = !DILocation(line: 264, column: 33, scope: !40)
!177 = !DILocation(line: 268, column: 42, scope: !40)
!178 = !DILocation(line: 49, column: 34, scope: !40)
!179 = !DILocation(line: 113, column: 40, scope: !40)
!180 = !DILocation(line: 277, column: 20, scope: !40)
!181 = !DILocation(line: 277, column: 34, scope: !40)
!182 = !DILocation(line: 277, column: 32, scope: !40)
!183 = !DILocation(line: 282, column: 36, scope: !40)
!184 = !DILocation(line: 1018, column: 9, scope: !185, inlinedAt: !187)
!185 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !186, file: !186, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!186 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!187 = distinct !DILocation(line: 396, column: 10, scope: !188, inlinedAt: !190)
!188 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !189, file: !189, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!189 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!190 = distinct !DILocation(line: 129, column: 24, scope: !191, inlinedAt: !193)
!191 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !192, file: !192, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!192 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!193 = distinct !DILocation(line: 101, column: 14, scope: !194, inlinedAt: !195)
!194 = distinct !DISubprogram(name: "run<float>", scope: !192, file: !192, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!195 = distinct !DILocation(line: 284, column: 19, scope: !40)
!196 = !DILocation(line: 171, column: 37, scope: !197, inlinedAt: !198)
!197 = distinct !DISubprogram(name: "__lane_id", scope: !186, file: !186, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!198 = distinct !DILocation(line: 990, column: 14, scope: !199, inlinedAt: !200)
!199 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !186, file: !186, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!200 = distinct !DILocation(line: 1019, column: 11, scope: !185, inlinedAt: !187)
!201 = !DILocation(line: 171, column: 10, scope: !197, inlinedAt: !198)
!202 = !DILocation(line: 991, column: 20, scope: !199, inlinedAt: !200)
!203 = !DILocation(line: 992, column: 36, scope: !199, inlinedAt: !200)
!204 = !DILocation(line: 992, column: 17, scope: !199, inlinedAt: !200)
!205 = !DILocation(line: 992, column: 11, scope: !199, inlinedAt: !200)
!206 = !DILocation(line: 993, column: 43, scope: !199, inlinedAt: !200)
!207 = !DILocation(line: 993, column: 10, scope: !199, inlinedAt: !200)
!208 = !DILocation(line: 1020, column: 14, scope: !185, inlinedAt: !187)
!209 = !DILocation(line: 25, column: 14, scope: !210, inlinedAt: !211)
!210 = distinct !DISubprogram(name: "operator()<float>", scope: !192, file: !192, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!211 = distinct !DILocation(line: 129, column: 11, scope: !191, inlinedAt: !193)
!212 = !DILocation(line: 1018, column: 9, scope: !185, inlinedAt: !213)
!213 = distinct !DILocation(line: 396, column: 10, scope: !188, inlinedAt: !214)
!214 = distinct !DILocation(line: 129, column: 24, scope: !215, inlinedAt: !216)
!215 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !192, file: !192, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!216 = distinct !DILocation(line: 101, column: 14, scope: !217, inlinedAt: !218)
!217 = distinct !DISubprogram(name: "run<float>", scope: !192, file: !192, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!218 = distinct !DILocation(line: 134, column: 14, scope: !191, inlinedAt: !193)
!219 = !DILocation(line: 171, column: 37, scope: !197, inlinedAt: !220)
!220 = distinct !DILocation(line: 990, column: 14, scope: !199, inlinedAt: !221)
!221 = distinct !DILocation(line: 1019, column: 11, scope: !185, inlinedAt: !213)
!222 = !DILocation(line: 171, column: 10, scope: !197, inlinedAt: !220)
!223 = !DILocation(line: 991, column: 20, scope: !199, inlinedAt: !221)
!224 = !DILocation(line: 992, column: 36, scope: !199, inlinedAt: !221)
!225 = !DILocation(line: 992, column: 17, scope: !199, inlinedAt: !221)
!226 = !DILocation(line: 992, column: 11, scope: !199, inlinedAt: !221)
!227 = !DILocation(line: 993, column: 43, scope: !199, inlinedAt: !221)
!228 = !DILocation(line: 993, column: 10, scope: !199, inlinedAt: !221)
!229 = !DILocation(line: 1020, column: 14, scope: !185, inlinedAt: !213)
!230 = !DILocation(line: 25, column: 14, scope: !210, inlinedAt: !231)
!231 = distinct !DILocation(line: 129, column: 11, scope: !215, inlinedAt: !216)
!232 = !DILocation(line: 286, column: 32, scope: !40)
!233 = !DILocation(line: 286, column: 7, scope: !40)
!234 = !DILocation(line: 294, column: 32, scope: !40)
!235 = !DILocation(line: 75, column: 10, scope: !98, inlinedAt: !236)
!236 = distinct !DILocation(line: 984, column: 9, scope: !101, inlinedAt: !237)
!237 = distinct !DILocation(line: 133, column: 53, scope: !104, inlinedAt: !238)
!238 = distinct !DILocation(line: 300, column: 50, scope: !40)
!239 = !DILocation(line: 300, column: 47, scope: !40)
!240 = !DILocation(line: 305, column: 122, scope: !40)
!241 = !DILocation(line: 305, column: 150, scope: !40)
!242 = !DILocation(line: 305, column: 77, scope: !40)
!243 = !DILocation(line: 305, column: 156, scope: !40)
!244 = !DILocation(line: 305, column: 40, scope: !40)
!245 = !DILocation(line: 305, column: 199, scope: !40)
!246 = !DILocation(line: 305, column: 93, scope: !40)
!247 = !DILocation(line: 68, column: 3, scope: !248, inlinedAt: !249)
!248 = distinct !DISubprogram(name: "__barrier_warp", scope: !186, file: !186, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!249 = distinct !DILocation(line: 192, column: 3, scope: !250, inlinedAt: !251)
!250 = distinct !DISubprogram(name: "__syncwarp", scope: !186, file: !186, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!251 = distinct !DILocation(line: 307, column: 3, scope: !40)
!252 = !DILocation(line: 69, column: 3, scope: !248, inlinedAt: !249)
!253 = !DILocation(line: 70, column: 3, scope: !248, inlinedAt: !249)
!254 = !DILocation(line: 309, column: 8, scope: !40)
!255 = !DILocation(line: 309, column: 3, scope: !40)
!256 = !DILocation(line: 310, column: 22, scope: !40)
!257 = !DILocation(line: 310, column: 132, scope: !40)
!258 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!259 = !{i32 2, i32 -1, i32 -1, i32 -1}
!260 = !DILocation(line: 310, column: 169, scope: !40)
!261 = !DILocation(line: 312, column: 1, scope: !40)
