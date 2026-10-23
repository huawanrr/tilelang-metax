; ModuleID = 'experiments/20261017_resume/s8_wide_v2_binary/oj12_m2_p1.bc'
source_filename = "/tmp/tmp8ftcujjt/tvm_kernels.maca"
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
define protected metaxgpu_kernel void @kernel_kernel(ptr addrspace(1) noalias nocapture noundef readonly %BlockIndices.coerce, ptr addrspace(4) noalias nocapture noundef readonly %K.coerce, ptr addrspace(1) noalias nocapture noundef writeonly %Output.coerce, ptr addrspace(4) noalias nocapture noundef readonly %Q.coerce, ptr addrspace(4) noalias nocapture noundef readonly %V.coerce) local_unnamed_addr #3 !dbg !40 {
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
  %cond.i.i798 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i, i32 64), !dbg !49
  %mul11 = shl nsw i32 %cond.i.i798, 4, !dbg !52
  %4 = or disjoint i64 %2, 1, !dbg !53
  %arrayidx.1 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %4, !dbg !43
  %5 = load i32, ptr addrspace(1) %arrayidx.1, align 4, !dbg !43, !tbaa !30
  %cond.i.i.1 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %5, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i798.1 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.1, i32 64), !dbg !49
  %mul11.1 = shl nsw i32 %cond.i.i798.1, 4, !dbg !52
  %6 = or disjoint i64 %2, 2, !dbg !53
  %arrayidx.2 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %6, !dbg !43
  %7 = load i32, ptr addrspace(1) %arrayidx.2, align 4, !dbg !43, !tbaa !30
  %cond.i.i.2 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %7, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i798.2 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.2, i32 64), !dbg !49
  %mul11.2 = shl nsw i32 %cond.i.i798.2, 4, !dbg !52
  %8 = or disjoint i64 %2, 3, !dbg !53
  %arrayidx.3 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %8, !dbg !43
  %9 = load i32, ptr addrspace(1) %arrayidx.3, align 4, !dbg !43, !tbaa !30
  %cond.i.i.3 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %9, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i798.3 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.3, i32 64), !dbg !49
  %mul11.3 = shl nsw i32 %cond.i.i798.3, 4, !dbg !52
  %10 = or disjoint i64 %2, 4, !dbg !53
  %arrayidx.4 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %10, !dbg !43
  %11 = load i32, ptr addrspace(1) %arrayidx.4, align 4, !dbg !43, !tbaa !30
  %cond.i.i.4 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %11, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i798.4 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.4, i32 64), !dbg !49
  %mul11.4 = shl nsw i32 %cond.i.i798.4, 4, !dbg !52
  %12 = or disjoint i64 %2, 5, !dbg !53
  %arrayidx.5 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %12, !dbg !43
  %13 = load i32, ptr addrspace(1) %arrayidx.5, align 4, !dbg !43, !tbaa !30
  %cond.i.i.5 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %13, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i798.5 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.5, i32 64), !dbg !49
  %mul11.5 = shl nsw i32 %cond.i.i798.5, 4, !dbg !52
  %14 = or disjoint i64 %2, 6, !dbg !53
  %arrayidx.6 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %14, !dbg !43
  %15 = load i32, ptr addrspace(1) %arrayidx.6, align 4, !dbg !43, !tbaa !30
  %cond.i.i.6 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %15, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i798.6 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.6, i32 64), !dbg !49
  %mul11.6 = shl nsw i32 %cond.i.i798.6, 4, !dbg !52
  %16 = or disjoint i64 %2, 7, !dbg !53
  %arrayidx.7 = getelementptr inbounds i32, ptr addrspace(1) %BlockIndices.coerce, i64 %16, !dbg !43
  %17 = load i32, ptr addrspace(1) %arrayidx.7, align 4, !dbg !43, !tbaa !30
  %cond.i.i.7 = tail call noundef range(i32 -1, -2147483648) i32 @llvm.smax.i32(i32 %17, i32 -1), !dbg !44, !call_argsrelate !48
  %cond.i.i798.7 = tail call noundef range(i32 -1, 65) i32 @llvm.smin.i32(i32 %cond.i.i.7, i32 64), !dbg !49
  %mul11.7 = shl nsw i32 %cond.i.i798.7, 4, !dbg !52
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
  %qr.sroa.0.0.copyload = load <4 x half>, ptr addrspace(4) %add.ptr, align 16, !dbg !57
  %qr.sroa.5.0.add.ptr.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr, i64 8, !dbg !57
  %qr.sroa.5.0.copyload = load <4 x half>, ptr addrspace(4) %qr.sroa.5.0.add.ptr.sroa_idx, align 8, !dbg !57
  %21 = getelementptr inbounds %struct.__half, ptr addrspace(4) %Q.coerce, i64 %20, !dbg !56
  %add.ptr.1 = getelementptr inbounds i8, ptr addrspace(4) %21, i64 64, !dbg !56
  %qr.sroa.7.16.copyload = load <4 x half>, ptr addrspace(4) %add.ptr.1, align 16, !dbg !57
  %qr.sroa.10.16.add.ptr.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %21, i64 72, !dbg !57
  %qr.sroa.10.16.copyload = load <4 x half>, ptr addrspace(4) %qr.sroa.10.16.add.ptr.1.sroa_idx, align 8, !dbg !57
  %mul103 = shl nsw i32 %0, 16
  %mul110 = shl nuw nsw i32 %18, 3
  %add108 = or disjoint i32 %mul110, %mul103
  %invariant.op = add nsw i32 %1, -15
  %22 = lshr i32 %18, 2
  %mul175 = and i32 %22, 252
  %or.cond = icmp ugt i32 %mul11, 1023, !dbg !58
  %cmp101.not = icmp sgt i32 %mul11, %1
  %or.cond856 = or i1 %or.cond, %cmp101.not, !dbg !58
  br i1 %or.cond856, label %if.end, label %if.then, !dbg !58

if.then:                                          ; preds = %entry
  %23 = shl nsw i32 %cond.i.i798, 10, !dbg !59
  %mul105 = and i32 %23, 64512, !dbg !59
  %add111 = add nuw nsw i32 %add108, %mul105, !dbg !60
  %idx.ext112 = zext nneg i32 %add111 to i64, !dbg !61
  %add.ptr113 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112, !dbg !61
  %kr.sroa.0.0.copyload2255 = load <4 x half>, ptr addrspace(4) %add.ptr113, align 16, !dbg !62
  %kr.sroa.10.0.add.ptr113.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113, i64 8, !dbg !62
  %kr.sroa.10.0.copyload2256 = load <4 x half>, ptr addrspace(4) %kr.sroa.10.0.add.ptr113.sroa_idx, align 8, !dbg !62
  br label %if.end, !dbg !63

if.end:                                           ; preds = %entry, %if.then
  %24 = phi <4 x half> [ %kr.sroa.10.0.copyload2256, %if.then ], [ zeroinitializer, %entry ], !dbg !64
  %25 = phi <4 x half> [ %kr.sroa.0.0.copyload2255, %if.then ], [ zeroinitializer, %entry ], !dbg !64
  %or.cond.1 = icmp ugt i32 %mul11.1, 1023, !dbg !58
  %cmp101.not.1 = icmp sgt i32 %mul11.1, %1
  %or.cond856.1 = or i1 %or.cond.1, %cmp101.not.1, !dbg !58
  br i1 %or.cond856.1, label %if.end.1, label %if.then.1, !dbg !58

if.then.1:                                        ; preds = %if.end
  %26 = shl nsw i32 %cond.i.i798.1, 10, !dbg !59
  %mul105.1 = and i32 %26, 64512, !dbg !59
  %add111.1 = add nuw nsw i32 %add108, %mul105.1, !dbg !60
  %idx.ext112.1 = zext nneg i32 %add111.1 to i64, !dbg !61
  %add.ptr113.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1, !dbg !61
  %kr.sroa.16.16.copyload2257 = load <4 x half>, ptr addrspace(4) %add.ptr113.1, align 16, !dbg !62
  %kr.sroa.24.16.add.ptr113.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1, i64 8, !dbg !62
  %kr.sroa.24.16.copyload2258 = load <4 x half>, ptr addrspace(4) %kr.sroa.24.16.add.ptr113.1.sroa_idx, align 8, !dbg !62
  br label %if.end.1, !dbg !63

if.end.1:                                         ; preds = %if.end, %if.then.1
  %27 = phi <4 x half> [ %kr.sroa.24.16.copyload2258, %if.then.1 ], [ zeroinitializer, %if.end ], !dbg !64
  %28 = phi <4 x half> [ %kr.sroa.16.16.copyload2257, %if.then.1 ], [ zeroinitializer, %if.end ], !dbg !64
  %or.cond.2 = icmp ugt i32 %mul11.2, 1023, !dbg !58
  %cmp101.not.2 = icmp sgt i32 %mul11.2, %1
  %or.cond856.2 = or i1 %or.cond.2, %cmp101.not.2, !dbg !58
  br i1 %or.cond856.2, label %if.end.2, label %if.then.2, !dbg !58

if.then.2:                                        ; preds = %if.end.1
  %29 = shl nsw i32 %cond.i.i798.2, 10, !dbg !59
  %mul105.2 = and i32 %29, 64512, !dbg !59
  %add111.2 = add nuw nsw i32 %add108, %mul105.2, !dbg !60
  %idx.ext112.2 = zext nneg i32 %add111.2 to i64, !dbg !61
  %add.ptr113.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.2, !dbg !61
  %kr.sroa.30.32.copyload2259 = load <4 x half>, ptr addrspace(4) %add.ptr113.2, align 16, !dbg !62
  %kr.sroa.38.32.add.ptr113.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.2, i64 8, !dbg !62
  %kr.sroa.38.32.copyload2260 = load <4 x half>, ptr addrspace(4) %kr.sroa.38.32.add.ptr113.2.sroa_idx, align 8, !dbg !62
  br label %if.end.2, !dbg !63

if.end.2:                                         ; preds = %if.end.1, %if.then.2
  %30 = phi <4 x half> [ %kr.sroa.38.32.copyload2260, %if.then.2 ], [ zeroinitializer, %if.end.1 ], !dbg !64
  %31 = phi <4 x half> [ %kr.sroa.30.32.copyload2259, %if.then.2 ], [ zeroinitializer, %if.end.1 ], !dbg !64
  %or.cond.3 = icmp ugt i32 %mul11.3, 1023, !dbg !58
  %cmp101.not.3 = icmp sgt i32 %mul11.3, %1
  %or.cond856.3 = or i1 %or.cond.3, %cmp101.not.3, !dbg !58
  br i1 %or.cond856.3, label %if.end.3, label %if.then.3, !dbg !58

if.then.3:                                        ; preds = %if.end.2
  %32 = shl nsw i32 %cond.i.i798.3, 10, !dbg !59
  %mul105.3 = and i32 %32, 64512, !dbg !59
  %add111.3 = add nuw nsw i32 %add108, %mul105.3, !dbg !60
  %idx.ext112.3 = zext nneg i32 %add111.3 to i64, !dbg !61
  %add.ptr113.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.3, !dbg !61
  %kr.sroa.44.48.copyload2261 = load <4 x half>, ptr addrspace(4) %add.ptr113.3, align 16, !dbg !62
  %kr.sroa.52.48.add.ptr113.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.3, i64 8, !dbg !62
  %kr.sroa.52.48.copyload2262 = load <4 x half>, ptr addrspace(4) %kr.sroa.52.48.add.ptr113.3.sroa_idx, align 8, !dbg !62
  br label %if.end.3, !dbg !63

if.end.3:                                         ; preds = %if.end.2, %if.then.3
  %33 = phi <4 x half> [ %kr.sroa.52.48.copyload2262, %if.then.3 ], [ zeroinitializer, %if.end.2 ], !dbg !64
  %34 = phi <4 x half> [ %kr.sroa.44.48.copyload2261, %if.then.3 ], [ zeroinitializer, %if.end.2 ], !dbg !64
  %add106.1 = add nuw nsw i32 %add108, 512
  br i1 %or.cond856, label %if.end.1897, label %if.then.1890, !dbg !58

if.then.1890:                                     ; preds = %if.end.3
  %35 = shl nsw i32 %cond.i.i798, 10, !dbg !59
  %mul105.1884 = and i32 %35, 64512, !dbg !59
  %add111.1885 = add nuw nsw i32 %add106.1, %mul105.1884, !dbg !60
  %idx.ext112.1886 = zext nneg i32 %add111.1885 to i64, !dbg !61
  %add.ptr113.1887 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1886, !dbg !61
  %kr.sroa.58.64.copyload2263 = load <4 x half>, ptr addrspace(4) %add.ptr113.1887, align 16, !dbg !62
  %kr.sroa.66.64.add.ptr113.1887.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1887, i64 8, !dbg !62
  %kr.sroa.66.64.copyload2264 = load <4 x half>, ptr addrspace(4) %kr.sroa.66.64.add.ptr113.1887.sroa_idx, align 8, !dbg !62
  br label %if.end.1897, !dbg !63

if.end.1897:                                      ; preds = %if.end.3, %if.then.1890
  %36 = phi <4 x half> [ %kr.sroa.66.64.copyload2264, %if.then.1890 ], [ zeroinitializer, %if.end.3 ], !dbg !64
  %37 = phi <4 x half> [ %kr.sroa.58.64.copyload2263, %if.then.1890 ], [ zeroinitializer, %if.end.3 ], !dbg !64
  br i1 %or.cond856.1, label %if.end.1.1, label %if.then.1.1, !dbg !58

if.then.1.1:                                      ; preds = %if.end.1897
  %38 = shl nsw i32 %cond.i.i798.1, 10, !dbg !59
  %mul105.1.1 = and i32 %38, 64512, !dbg !59
  %add111.1.1 = add nuw nsw i32 %add106.1, %mul105.1.1, !dbg !60
  %idx.ext112.1.1 = zext nneg i32 %add111.1.1 to i64, !dbg !61
  %add.ptr113.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1.1, !dbg !61
  %kr.sroa.72.80.copyload2265 = load <4 x half>, ptr addrspace(4) %add.ptr113.1.1, align 16, !dbg !62
  %kr.sroa.80.80.add.ptr113.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1.1, i64 8, !dbg !62
  %kr.sroa.80.80.copyload2266 = load <4 x half>, ptr addrspace(4) %kr.sroa.80.80.add.ptr113.1.1.sroa_idx, align 8, !dbg !62
  br label %if.end.1.1, !dbg !63

if.end.1.1:                                       ; preds = %if.end.1897, %if.then.1.1
  %39 = phi <4 x half> [ %kr.sroa.80.80.copyload2266, %if.then.1.1 ], [ zeroinitializer, %if.end.1897 ], !dbg !64
  %40 = phi <4 x half> [ %kr.sroa.72.80.copyload2265, %if.then.1.1 ], [ zeroinitializer, %if.end.1897 ], !dbg !64
  br i1 %or.cond856.2, label %if.end.2.1, label %if.then.2.1, !dbg !58

if.then.2.1:                                      ; preds = %if.end.1.1
  %41 = shl nsw i32 %cond.i.i798.2, 10, !dbg !59
  %mul105.2.1 = and i32 %41, 64512, !dbg !59
  %add111.2.1 = add nuw nsw i32 %add106.1, %mul105.2.1, !dbg !60
  %idx.ext112.2.1 = zext nneg i32 %add111.2.1 to i64, !dbg !61
  %add.ptr113.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.2.1, !dbg !61
  %kr.sroa.86.96.copyload2267 = load <4 x half>, ptr addrspace(4) %add.ptr113.2.1, align 16, !dbg !62
  %kr.sroa.94.96.add.ptr113.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.2.1, i64 8, !dbg !62
  %kr.sroa.94.96.copyload2268 = load <4 x half>, ptr addrspace(4) %kr.sroa.94.96.add.ptr113.2.1.sroa_idx, align 8, !dbg !62
  br label %if.end.2.1, !dbg !63

if.end.2.1:                                       ; preds = %if.end.1.1, %if.then.2.1
  %42 = phi <4 x half> [ %kr.sroa.94.96.copyload2268, %if.then.2.1 ], [ zeroinitializer, %if.end.1.1 ], !dbg !64
  %43 = phi <4 x half> [ %kr.sroa.86.96.copyload2267, %if.then.2.1 ], [ zeroinitializer, %if.end.1.1 ], !dbg !64
  br i1 %or.cond856.3, label %if.end.3.1, label %if.then.3.1, !dbg !58

if.then.3.1:                                      ; preds = %if.end.2.1
  %44 = shl nsw i32 %cond.i.i798.3, 10, !dbg !59
  %mul105.3.1 = and i32 %44, 64512, !dbg !59
  %add111.3.1 = add nuw nsw i32 %add106.1, %mul105.3.1, !dbg !60
  %idx.ext112.3.1 = zext nneg i32 %add111.3.1 to i64, !dbg !61
  %add.ptr113.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.3.1, !dbg !61
  %kr.sroa.100.112.copyload2269 = load <4 x half>, ptr addrspace(4) %add.ptr113.3.1, align 16, !dbg !62
  %kr.sroa.108.112.add.ptr113.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.3.1, i64 8, !dbg !62
  %kr.sroa.108.112.copyload2270 = load <4 x half>, ptr addrspace(4) %kr.sroa.108.112.add.ptr113.3.1.sroa_idx, align 8, !dbg !62
  br label %if.end.3.1, !dbg !63

if.end.3.1:                                       ; preds = %if.end.2.1, %if.then.3.1
  %45 = phi <4 x half> [ %kr.sroa.108.112.copyload2270, %if.then.3.1 ], [ zeroinitializer, %if.end.2.1 ], !dbg !64
  %46 = phi <4 x half> [ %kr.sroa.100.112.copyload2269, %if.then.3.1 ], [ zeroinitializer, %if.end.2.1 ], !dbg !64
  br i1 %or.cond856, label %if.end218, label %if.then164, !dbg !65

if.then164:                                       ; preds = %if.end.3.1
  %cmp167 = icmp sgt i32 %mul11, %invariant.op, !dbg !66
  br i1 %cmp167, label %for.cond169.preheader, label %if.end218, !dbg !67

for.cond169.preheader:                            ; preds = %if.then164
  %add176 = add nuw nsw i32 %mul11, %mul175
  %cmp179.not = icmp sgt i32 %add176, %1, !dbg !68
  %spec.select = select i1 %cmp179.not, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.0.0.vec.insert1416 = insertelement <4 x float> poison, float %spec.select, i64 0, !dbg !70
  %cmp179.not.1.not = icmp slt i32 %add176, %1, !dbg !68
  %spec.select.1 = select i1 %cmp179.not.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !69
  %scores.sroa.0.4.vec.insert1441 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1416, float %spec.select.1, i64 1, !dbg !70
  %add177.2 = or disjoint i32 %add176, 2, !dbg !71
  %cmp179.not.2 = icmp sgt i32 %add177.2, %1, !dbg !68
  %spec.select.2 = select i1 %cmp179.not.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.0.8.vec.insert1466 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1441, float %spec.select.2, i64 2, !dbg !70
  %add177.3 = or disjoint i32 %add176, 3, !dbg !71
  %cmp179.not.3 = icmp sgt i32 %add177.3, %1, !dbg !68
  %spec.select.3 = select i1 %cmp179.not.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.0.12.vec.insert1491 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1466, float %spec.select.3, i64 3, !dbg !70
  br label %if.end218, !dbg !72

if.end218:                                        ; preds = %if.end.3.1, %if.then164, %for.cond169.preheader
  %scores.sroa.0.0 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1491, %for.cond169.preheader ], [ zeroinitializer, %if.then164 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end.3.1 ], !dbg !64
  br i1 %or.cond856.1, label %if.end218.1, label %if.then164.1, !dbg !65

if.then164.1:                                     ; preds = %if.end218
  %cmp167.1 = icmp sgt i32 %mul11.1, %invariant.op, !dbg !66
  br i1 %cmp167.1, label %for.cond169.preheader.1, label %if.end218.1, !dbg !67

for.cond169.preheader.1:                          ; preds = %if.then164.1
  %add176.1 = add nuw nsw i32 %mul11.1, %mul175
  %cmp179.not.1899 = icmp sgt i32 %add176.1, %1, !dbg !68
  %spec.select.1900 = select i1 %cmp179.not.1899, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.74.16.vec.insert1524 = insertelement <4 x float> poison, float %spec.select.1900, i64 0, !dbg !70
  %cmp179.not.1.1.not = icmp slt i32 %add176.1, %1, !dbg !68
  %spec.select.1.1 = select i1 %cmp179.not.1.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !69
  %scores.sroa.74.20.vec.insert1549 = insertelement <4 x float> %scores.sroa.74.16.vec.insert1524, float %spec.select.1.1, i64 1, !dbg !70
  %add177.2.1 = or disjoint i32 %add176.1, 2, !dbg !71
  %cmp179.not.2.1 = icmp sgt i32 %add177.2.1, %1, !dbg !68
  %spec.select.2.1 = select i1 %cmp179.not.2.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.74.24.vec.insert1574 = insertelement <4 x float> %scores.sroa.74.20.vec.insert1549, float %spec.select.2.1, i64 2, !dbg !70
  %add177.3.1 = or disjoint i32 %add176.1, 3, !dbg !71
  %cmp179.not.3.1 = icmp sgt i32 %add177.3.1, %1, !dbg !68
  %spec.select.3.1 = select i1 %cmp179.not.3.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.74.28.vec.insert1599 = insertelement <4 x float> %scores.sroa.74.24.vec.insert1574, float %spec.select.3.1, i64 3, !dbg !70
  br label %if.end218.1, !dbg !72

if.end218.1:                                      ; preds = %if.end218, %if.then164.1, %for.cond169.preheader.1
  %scores.sroa.74.0 = phi <4 x float> [ %scores.sroa.74.28.vec.insert1599, %for.cond169.preheader.1 ], [ zeroinitializer, %if.then164.1 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end218 ], !dbg !64
  br i1 %or.cond856.2, label %if.end218.2, label %if.then164.2, !dbg !65

if.then164.2:                                     ; preds = %if.end218.1
  %cmp167.2 = icmp sgt i32 %mul11.2, %invariant.op, !dbg !66
  br i1 %cmp167.2, label %for.cond169.preheader.2, label %if.end218.2, !dbg !67

for.cond169.preheader.2:                          ; preds = %if.then164.2
  %add176.2 = add nuw nsw i32 %mul11.2, %mul175
  %cmp179.not.2904 = icmp sgt i32 %add176.2, %1, !dbg !68
  %spec.select.2905 = select i1 %cmp179.not.2904, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.146.32.vec.insert1632 = insertelement <4 x float> poison, float %spec.select.2905, i64 0, !dbg !70
  %cmp179.not.1.2.not = icmp slt i32 %add176.2, %1, !dbg !68
  %spec.select.1.2 = select i1 %cmp179.not.1.2.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !69
  %scores.sroa.146.36.vec.insert1657 = insertelement <4 x float> %scores.sroa.146.32.vec.insert1632, float %spec.select.1.2, i64 1, !dbg !70
  %add177.2.2 = or disjoint i32 %add176.2, 2, !dbg !71
  %cmp179.not.2.2 = icmp sgt i32 %add177.2.2, %1, !dbg !68
  %spec.select.2.2 = select i1 %cmp179.not.2.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.146.40.vec.insert1682 = insertelement <4 x float> %scores.sroa.146.36.vec.insert1657, float %spec.select.2.2, i64 2, !dbg !70
  %add177.3.2 = or disjoint i32 %add176.2, 3, !dbg !71
  %cmp179.not.3.2 = icmp sgt i32 %add177.3.2, %1, !dbg !68
  %spec.select.3.2 = select i1 %cmp179.not.3.2, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.146.44.vec.insert1707 = insertelement <4 x float> %scores.sroa.146.40.vec.insert1682, float %spec.select.3.2, i64 3, !dbg !70
  br label %if.end218.2, !dbg !72

if.end218.2:                                      ; preds = %if.end218.1, %if.then164.2, %for.cond169.preheader.2
  %scores.sroa.146.0 = phi <4 x float> [ %scores.sroa.146.44.vec.insert1707, %for.cond169.preheader.2 ], [ zeroinitializer, %if.then164.2 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end218.1 ], !dbg !64
  br i1 %or.cond856.3, label %if.end218.3, label %if.then164.3, !dbg !65

if.then164.3:                                     ; preds = %if.end218.2
  %cmp167.3 = icmp sgt i32 %mul11.3, %invariant.op, !dbg !66
  br i1 %cmp167.3, label %for.cond169.preheader.3, label %if.end218.3, !dbg !67

for.cond169.preheader.3:                          ; preds = %if.then164.3
  %add176.3 = add nuw nsw i32 %mul11.3, %mul175
  %cmp179.not.3909 = icmp sgt i32 %add176.3, %1, !dbg !68
  %spec.select.3910 = select i1 %cmp179.not.3909, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.218.48.vec.insert1740 = insertelement <4 x float> poison, float %spec.select.3910, i64 0, !dbg !70
  %cmp179.not.1.3.not = icmp slt i32 %add176.3, %1, !dbg !68
  %spec.select.1.3 = select i1 %cmp179.not.1.3.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !69
  %scores.sroa.218.52.vec.insert1765 = insertelement <4 x float> %scores.sroa.218.48.vec.insert1740, float %spec.select.1.3, i64 1, !dbg !70
  %add177.2.3 = or disjoint i32 %add176.3, 2, !dbg !71
  %cmp179.not.2.3 = icmp sgt i32 %add177.2.3, %1, !dbg !68
  %spec.select.2.3 = select i1 %cmp179.not.2.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.218.56.vec.insert1790 = insertelement <4 x float> %scores.sroa.218.52.vec.insert1765, float %spec.select.2.3, i64 2, !dbg !70
  %add177.3.3 = or disjoint i32 %add176.3, 3, !dbg !71
  %cmp179.not.3.3 = icmp sgt i32 %add177.3.3, %1, !dbg !68
  %spec.select.3.3 = select i1 %cmp179.not.3.3, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.218.60.vec.insert1815 = insertelement <4 x float> %scores.sroa.218.56.vec.insert1790, float %spec.select.3.3, i64 3, !dbg !70
  br label %if.end218.3, !dbg !72

if.end218.3:                                      ; preds = %if.end218.2, %if.then164.3, %for.cond169.preheader.3
  %scores.sroa.218.0 = phi <4 x float> [ %scores.sroa.218.60.vec.insert1815, %for.cond169.preheader.3 ], [ zeroinitializer, %if.then164.3 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end218.2 ], !dbg !64
  %47 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %25, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.0.0), !dbg !73, !call_argsrelate !74
  %48 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %28, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.74.0), !dbg !73, !call_argsrelate !74
  %49 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %31, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.146.0), !dbg !73, !call_argsrelate !74
  %50 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %34, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.218.0), !dbg !73, !call_argsrelate !74
  %51 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %24, <4 x half> %qr.sroa.5.0.copyload, <4 x float> %47), !dbg !73, !call_argsrelate !74
  %52 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %27, <4 x half> %qr.sroa.5.0.copyload, <4 x float> %48), !dbg !73, !call_argsrelate !74
  %53 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %30, <4 x half> %qr.sroa.5.0.copyload, <4 x float> %49), !dbg !73, !call_argsrelate !74
  %54 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %33, <4 x half> %qr.sroa.5.0.copyload, <4 x float> %50), !dbg !73, !call_argsrelate !74
  %55 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %37, <4 x half> %qr.sroa.7.16.copyload, <4 x float> %51), !dbg !73, !call_argsrelate !74
  %56 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %40, <4 x half> %qr.sroa.7.16.copyload, <4 x float> %52), !dbg !73, !call_argsrelate !74
  %57 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %43, <4 x half> %qr.sroa.7.16.copyload, <4 x float> %53), !dbg !73, !call_argsrelate !74
  %58 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %46, <4 x half> %qr.sroa.7.16.copyload, <4 x float> %54), !dbg !73, !call_argsrelate !74
  %59 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %36, <4 x half> %qr.sroa.10.16.copyload, <4 x float> %55), !dbg !73, !call_argsrelate !74
  %60 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %39, <4 x half> %qr.sroa.10.16.copyload, <4 x float> %56), !dbg !73, !call_argsrelate !74
  %61 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %42, <4 x half> %qr.sroa.10.16.copyload, <4 x float> %57), !dbg !73, !call_argsrelate !74
  %62 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %45, <4 x half> %qr.sroa.10.16.copyload, <4 x float> %58), !dbg !73, !call_argsrelate !74
  br i1 %or.cond856, label %if.end335, label %for.cond274.preheader, !dbg !75

for.cond274.preheader:                            ; preds = %if.end218.3
  %63 = shl nsw i32 %cond.i.i798, 10
  %mul281 = and i32 %63, 64512
  %add284 = add nuw nsw i32 %add108, %mul281
  %64 = zext nneg i32 %add284 to i64, !dbg !76
  %add.ptr289 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %64, !dbg !77
  %vr.sroa.0.0.copyload2287 = load <4 x half>, ptr addrspace(4) %add.ptr289, align 16, !dbg !78
  %vr.sroa.12.0.add.ptr289.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr289, i64 8, !dbg !78
  %vr.sroa.12.0.copyload2288 = load <4 x half>, ptr addrspace(4) %vr.sroa.12.0.add.ptr289.sroa_idx, align 8, !dbg !78
  %65 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %64, !dbg !77
  %add.ptr289.1 = getelementptr inbounds i8, ptr addrspace(4) %65, i64 1024, !dbg !77
  %vr.sroa.20.16.copyload2289 = load <4 x half>, ptr addrspace(4) %add.ptr289.1, align 16, !dbg !78
  %vr.sroa.30.16.add.ptr289.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %65, i64 1032, !dbg !78
  %vr.sroa.30.16.copyload2290 = load <4 x half>, ptr addrspace(4) %vr.sroa.30.16.add.ptr289.1.sroa_idx, align 8, !dbg !78
  br label %if.end335, !dbg !79

if.end335:                                        ; preds = %if.end218.3, %for.cond274.preheader
  %66 = phi <4 x half> [ %vr.sroa.30.16.copyload2290, %for.cond274.preheader ], [ zeroinitializer, %if.end218.3 ], !dbg !64
  %67 = phi <4 x half> [ %vr.sroa.20.16.copyload2289, %for.cond274.preheader ], [ zeroinitializer, %if.end218.3 ], !dbg !64
  %68 = phi <4 x half> [ %vr.sroa.12.0.copyload2288, %for.cond274.preheader ], [ zeroinitializer, %if.end218.3 ], !dbg !64
  %69 = phi <4 x half> [ %vr.sroa.0.0.copyload2287, %for.cond274.preheader ], [ zeroinitializer, %if.end218.3 ], !dbg !64
  br i1 %or.cond856.1, label %if.end335.1, label %for.cond274.preheader.1, !dbg !75

for.cond274.preheader.1:                          ; preds = %if.end335
  %70 = shl nsw i32 %cond.i.i798.1, 10
  %mul281.1 = and i32 %70, 64512
  %add284.1 = add nuw nsw i32 %add108, %mul281.1
  %71 = zext nneg i32 %add284.1 to i64, !dbg !76
  %add.ptr289.1929 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %71, !dbg !77
  %vr.sroa.38.32.copyload2291 = load <4 x half>, ptr addrspace(4) %add.ptr289.1929, align 16, !dbg !78
  %vr.sroa.48.32.add.ptr289.1929.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr289.1929, i64 8, !dbg !78
  %vr.sroa.48.32.copyload2292 = load <4 x half>, ptr addrspace(4) %vr.sroa.48.32.add.ptr289.1929.sroa_idx, align 8, !dbg !78
  %72 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %71, !dbg !77
  %add.ptr289.1.1 = getelementptr inbounds i8, ptr addrspace(4) %72, i64 1024, !dbg !77
  %vr.sroa.56.48.copyload2293 = load <4 x half>, ptr addrspace(4) %add.ptr289.1.1, align 16, !dbg !78
  %vr.sroa.66.48.add.ptr289.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %72, i64 1032, !dbg !78
  %vr.sroa.66.48.copyload2294 = load <4 x half>, ptr addrspace(4) %vr.sroa.66.48.add.ptr289.1.1.sroa_idx, align 8, !dbg !78
  br label %if.end335.1, !dbg !79

if.end335.1:                                      ; preds = %if.end335, %for.cond274.preheader.1
  %73 = phi <4 x half> [ %vr.sroa.66.48.copyload2294, %for.cond274.preheader.1 ], [ zeroinitializer, %if.end335 ], !dbg !64
  %74 = phi <4 x half> [ %vr.sroa.56.48.copyload2293, %for.cond274.preheader.1 ], [ zeroinitializer, %if.end335 ], !dbg !64
  %75 = phi <4 x half> [ %vr.sroa.48.32.copyload2292, %for.cond274.preheader.1 ], [ zeroinitializer, %if.end335 ], !dbg !64
  %76 = phi <4 x half> [ %vr.sroa.38.32.copyload2291, %for.cond274.preheader.1 ], [ zeroinitializer, %if.end335 ], !dbg !64
  br i1 %or.cond856.2, label %if.end335.2, label %for.cond274.preheader.2, !dbg !75

for.cond274.preheader.2:                          ; preds = %if.end335.1
  %77 = shl nsw i32 %cond.i.i798.2, 10
  %mul281.2 = and i32 %77, 64512
  %add284.2 = add nuw nsw i32 %add108, %mul281.2
  %78 = zext nneg i32 %add284.2 to i64, !dbg !76
  %add.ptr289.2 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %78, !dbg !77
  %vr.sroa.74.64.copyload2295 = load <4 x half>, ptr addrspace(4) %add.ptr289.2, align 16, !dbg !78
  %vr.sroa.84.64.add.ptr289.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr289.2, i64 8, !dbg !78
  %vr.sroa.84.64.copyload2296 = load <4 x half>, ptr addrspace(4) %vr.sroa.84.64.add.ptr289.2.sroa_idx, align 8, !dbg !78
  %79 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %78, !dbg !77
  %add.ptr289.1.2 = getelementptr inbounds i8, ptr addrspace(4) %79, i64 1024, !dbg !77
  %vr.sroa.92.80.copyload2297 = load <4 x half>, ptr addrspace(4) %add.ptr289.1.2, align 16, !dbg !78
  %vr.sroa.102.80.add.ptr289.1.2.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %79, i64 1032, !dbg !78
  %vr.sroa.102.80.copyload2298 = load <4 x half>, ptr addrspace(4) %vr.sroa.102.80.add.ptr289.1.2.sroa_idx, align 8, !dbg !78
  br label %if.end335.2, !dbg !79

if.end335.2:                                      ; preds = %if.end335.1, %for.cond274.preheader.2
  %80 = phi <4 x half> [ %vr.sroa.102.80.copyload2298, %for.cond274.preheader.2 ], [ zeroinitializer, %if.end335.1 ], !dbg !64
  %81 = phi <4 x half> [ %vr.sroa.92.80.copyload2297, %for.cond274.preheader.2 ], [ zeroinitializer, %if.end335.1 ], !dbg !64
  %82 = phi <4 x half> [ %vr.sroa.84.64.copyload2296, %for.cond274.preheader.2 ], [ zeroinitializer, %if.end335.1 ], !dbg !64
  %83 = phi <4 x half> [ %vr.sroa.74.64.copyload2295, %for.cond274.preheader.2 ], [ zeroinitializer, %if.end335.1 ], !dbg !64
  br i1 %or.cond856.3, label %if.end335.3, label %for.cond274.preheader.3, !dbg !75

for.cond274.preheader.3:                          ; preds = %if.end335.2
  %84 = shl nsw i32 %cond.i.i798.3, 10
  %mul281.3 = and i32 %84, 64512
  %add284.3 = add nuw nsw i32 %add108, %mul281.3
  %85 = zext nneg i32 %add284.3 to i64, !dbg !76
  %add.ptr289.3 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %85, !dbg !77
  %vr.sroa.110.96.copyload2299 = load <4 x half>, ptr addrspace(4) %add.ptr289.3, align 16, !dbg !78
  %vr.sroa.120.96.add.ptr289.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr289.3, i64 8, !dbg !78
  %vr.sroa.120.96.copyload2300 = load <4 x half>, ptr addrspace(4) %vr.sroa.120.96.add.ptr289.3.sroa_idx, align 8, !dbg !78
  %86 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %85, !dbg !77
  %add.ptr289.1.3 = getelementptr inbounds i8, ptr addrspace(4) %86, i64 1024, !dbg !77
  %vr.sroa.128.112.copyload2301 = load <4 x half>, ptr addrspace(4) %add.ptr289.1.3, align 16, !dbg !78
  %vr.sroa.138.112.add.ptr289.1.3.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %86, i64 1032, !dbg !78
  %vr.sroa.138.112.copyload2302 = load <4 x half>, ptr addrspace(4) %vr.sroa.138.112.add.ptr289.1.3.sroa_idx, align 8, !dbg !78
  br label %if.end335.3, !dbg !79

if.end335.3:                                      ; preds = %if.end335.2, %for.cond274.preheader.3
  %87 = phi <4 x half> [ %vr.sroa.138.112.copyload2302, %for.cond274.preheader.3 ], [ zeroinitializer, %if.end335.2 ], !dbg !64
  %88 = phi <4 x half> [ %vr.sroa.128.112.copyload2301, %for.cond274.preheader.3 ], [ zeroinitializer, %if.end335.2 ], !dbg !64
  %89 = phi <4 x half> [ %vr.sroa.120.96.copyload2300, %for.cond274.preheader.3 ], [ zeroinitializer, %if.end335.2 ], !dbg !64
  %90 = phi <4 x half> [ %vr.sroa.110.96.copyload2299, %for.cond274.preheader.3 ], [ zeroinitializer, %if.end335.2 ], !dbg !64
  br i1 %or.cond856, label %if.end415, label %for.cond352.preheader, !dbg !80

for.cond352.preheader:                            ; preds = %if.end335.3
  %scores.sroa.0.0.vec.extract = extractelement <4 x float> %59, i64 0, !dbg !81
  %mul360 = fmul contract float %scores.sroa.0.0.vec.extract, 0x3FB99999A0000000, !dbg !82
  %91 = tail call contract noundef float @llvm.minnum.f32(float %mul360, float 0x4024CB5EC0000000), !dbg !83
  %92 = tail call contract noundef float @llvm.exp.f32(float %91), !dbg !86
  %scores.sroa.0.4.vec.extract = extractelement <4 x float> %59, i64 1, !dbg !81
  %mul360.1 = fmul contract float %scores.sroa.0.4.vec.extract, 0x3FB99999A0000000, !dbg !82
  %93 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1, float 0x4024CB5EC0000000), !dbg !83
  %94 = tail call contract noundef float @llvm.exp.f32(float %93), !dbg !86
  %scores.sroa.0.8.vec.extract = extractelement <4 x float> %59, i64 2, !dbg !81
  %mul360.2 = fmul contract float %scores.sroa.0.8.vec.extract, 0x3FB99999A0000000, !dbg !82
  %95 = tail call contract noundef float @llvm.minnum.f32(float %mul360.2, float 0x4024CB5EC0000000), !dbg !83
  %96 = tail call contract noundef float @llvm.exp.f32(float %95), !dbg !86
  %scores.sroa.0.12.vec.extract = extractelement <4 x float> %59, i64 3, !dbg !81
  %mul360.3 = fmul contract float %scores.sroa.0.12.vec.extract, 0x3FB99999A0000000, !dbg !82
  %97 = tail call contract noundef float @llvm.minnum.f32(float %mul360.3, float 0x4024CB5EC0000000), !dbg !83
  %98 = tail call contract noundef float @llvm.exp.f32(float %97), !dbg !86
  %99 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %92), !dbg !89
  %100 = insertelement <4 x i16> poison, i16 %99, i64 0, !dbg !98
  %101 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %94), !dbg !89
  %102 = insertelement <4 x i16> %100, i16 %101, i64 1, !dbg !98
  %103 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %96), !dbg !89
  %104 = insertelement <4 x i16> %102, i16 %103, i64 2, !dbg !98
  %105 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %98), !dbg !89
  %106 = insertelement <4 x i16> %104, i16 %105, i64 3, !dbg !98
  %probs.sroa.0.6.vec.insert = bitcast <4 x i16> %106 to <4 x half>, !dbg !98
  br label %if.end415, !dbg !99

if.end415:                                        ; preds = %if.end335.3, %for.cond352.preheader
  %sums.sroa.56.0 = phi float [ %98, %for.cond352.preheader ], [ 0.000000e+00, %if.end335.3 ], !dbg !64
  %sums.sroa.38.0 = phi float [ %96, %for.cond352.preheader ], [ 0.000000e+00, %if.end335.3 ], !dbg !64
  %sums.sroa.20.0 = phi float [ %94, %for.cond352.preheader ], [ 0.000000e+00, %if.end335.3 ], !dbg !64
  %sums.sroa.0.0 = phi float [ %92, %for.cond352.preheader ], [ 0.000000e+00, %if.end335.3 ], !dbg !64
  %probs.sroa.0.0 = phi <4 x half> [ %probs.sroa.0.6.vec.insert, %for.cond352.preheader ], [ zeroinitializer, %if.end335.3 ], !dbg !64
  br i1 %or.cond856.1, label %if.end415.1, label %for.cond352.preheader.1, !dbg !80

for.cond352.preheader.1:                          ; preds = %if.end415
  %scores.sroa.74.16.vec.extract = extractelement <4 x float> %60, i64 0, !dbg !81
  %mul360.1938 = fmul contract float %scores.sroa.74.16.vec.extract, 0x3FB99999A0000000, !dbg !82
  %107 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1938, float 0x4024CB5EC0000000), !dbg !83
  %108 = tail call contract noundef float @llvm.exp.f32(float %107), !dbg !86
  %scores.sroa.74.20.vec.extract = extractelement <4 x float> %60, i64 1, !dbg !81
  %mul360.1.1 = fmul contract float %scores.sroa.74.20.vec.extract, 0x3FB99999A0000000, !dbg !82
  %109 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1.1, float 0x4024CB5EC0000000), !dbg !83
  %110 = tail call contract noundef float @llvm.exp.f32(float %109), !dbg !86
  %scores.sroa.74.24.vec.extract = extractelement <4 x float> %60, i64 2, !dbg !81
  %mul360.2.1 = fmul contract float %scores.sroa.74.24.vec.extract, 0x3FB99999A0000000, !dbg !82
  %111 = tail call contract noundef float @llvm.minnum.f32(float %mul360.2.1, float 0x4024CB5EC0000000), !dbg !83
  %112 = tail call contract noundef float @llvm.exp.f32(float %111), !dbg !86
  %scores.sroa.74.28.vec.extract = extractelement <4 x float> %60, i64 3, !dbg !81
  %mul360.3.1 = fmul contract float %scores.sroa.74.28.vec.extract, 0x3FB99999A0000000, !dbg !82
  %113 = tail call contract noundef float @llvm.minnum.f32(float %mul360.3.1, float 0x4024CB5EC0000000), !dbg !83
  %114 = tail call contract noundef float @llvm.exp.f32(float %113), !dbg !86
  %add380.1940 = fadd contract float %sums.sroa.0.0, %108, !dbg !100
  %add380.1.1 = fadd contract float %sums.sroa.20.0, %110, !dbg !100
  %add380.2.1 = fadd contract float %sums.sroa.38.0, %112, !dbg !100
  %add380.3.1 = fadd contract float %sums.sroa.56.0, %114, !dbg !100
  %115 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %108), !dbg !89
  %116 = insertelement <4 x i16> poison, i16 %115, i64 0, !dbg !98
  %117 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %110), !dbg !89
  %118 = insertelement <4 x i16> %116, i16 %117, i64 1, !dbg !98
  %119 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %112), !dbg !89
  %120 = insertelement <4 x i16> %118, i16 %119, i64 2, !dbg !98
  %121 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %114), !dbg !89
  %122 = insertelement <4 x i16> %120, i16 %121, i64 3, !dbg !98
  %probs.sroa.22.14.vec.insert = bitcast <4 x i16> %122 to <4 x half>, !dbg !98
  br label %if.end415.1, !dbg !99

if.end415.1:                                      ; preds = %if.end415, %for.cond352.preheader.1
  %sums.sroa.56.1 = phi float [ %add380.3.1, %for.cond352.preheader.1 ], [ %sums.sroa.56.0, %if.end415 ], !dbg !64
  %sums.sroa.38.1 = phi float [ %add380.2.1, %for.cond352.preheader.1 ], [ %sums.sroa.38.0, %if.end415 ], !dbg !64
  %sums.sroa.20.1 = phi float [ %add380.1.1, %for.cond352.preheader.1 ], [ %sums.sroa.20.0, %if.end415 ], !dbg !64
  %sums.sroa.0.1 = phi float [ %add380.1940, %for.cond352.preheader.1 ], [ %sums.sroa.0.0, %if.end415 ], !dbg !64
  %probs.sroa.22.0 = phi <4 x half> [ %probs.sroa.22.14.vec.insert, %for.cond352.preheader.1 ], [ zeroinitializer, %if.end415 ], !dbg !64
  br i1 %or.cond856.2, label %if.end415.2, label %for.cond352.preheader.2, !dbg !80

for.cond352.preheader.2:                          ; preds = %if.end415.1
  %scores.sroa.146.32.vec.extract = extractelement <4 x float> %61, i64 0, !dbg !81
  %mul360.2945 = fmul contract float %scores.sroa.146.32.vec.extract, 0x3FB99999A0000000, !dbg !82
  %123 = tail call contract noundef float @llvm.minnum.f32(float %mul360.2945, float 0x4024CB5EC0000000), !dbg !83
  %124 = tail call contract noundef float @llvm.exp.f32(float %123), !dbg !86
  %scores.sroa.146.36.vec.extract = extractelement <4 x float> %61, i64 1, !dbg !81
  %mul360.1.2 = fmul contract float %scores.sroa.146.36.vec.extract, 0x3FB99999A0000000, !dbg !82
  %125 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1.2, float 0x4024CB5EC0000000), !dbg !83
  %126 = tail call contract noundef float @llvm.exp.f32(float %125), !dbg !86
  %scores.sroa.146.40.vec.extract = extractelement <4 x float> %61, i64 2, !dbg !81
  %mul360.2.2 = fmul contract float %scores.sroa.146.40.vec.extract, 0x3FB99999A0000000, !dbg !82
  %127 = tail call contract noundef float @llvm.minnum.f32(float %mul360.2.2, float 0x4024CB5EC0000000), !dbg !83
  %128 = tail call contract noundef float @llvm.exp.f32(float %127), !dbg !86
  %scores.sroa.146.44.vec.extract = extractelement <4 x float> %61, i64 3, !dbg !81
  %mul360.3.2 = fmul contract float %scores.sroa.146.44.vec.extract, 0x3FB99999A0000000, !dbg !82
  %129 = tail call contract noundef float @llvm.minnum.f32(float %mul360.3.2, float 0x4024CB5EC0000000), !dbg !83
  %130 = tail call contract noundef float @llvm.exp.f32(float %129), !dbg !86
  %add380.2947 = fadd contract float %sums.sroa.0.1, %124, !dbg !100
  %add380.1.2 = fadd contract float %sums.sroa.20.1, %126, !dbg !100
  %add380.2.2 = fadd contract float %sums.sroa.38.1, %128, !dbg !100
  %add380.3.2 = fadd contract float %sums.sroa.56.1, %130, !dbg !100
  %131 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %124), !dbg !89
  %132 = insertelement <4 x i16> poison, i16 %131, i64 0, !dbg !98
  %133 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %126), !dbg !89
  %134 = insertelement <4 x i16> %132, i16 %133, i64 1, !dbg !98
  %135 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %128), !dbg !89
  %136 = insertelement <4 x i16> %134, i16 %135, i64 2, !dbg !98
  %137 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %130), !dbg !89
  %138 = insertelement <4 x i16> %136, i16 %137, i64 3, !dbg !98
  %probs.sroa.42.22.vec.insert = bitcast <4 x i16> %138 to <4 x half>, !dbg !98
  br label %if.end415.2, !dbg !99

if.end415.2:                                      ; preds = %if.end415.1, %for.cond352.preheader.2
  %sums.sroa.56.2 = phi float [ %add380.3.2, %for.cond352.preheader.2 ], [ %sums.sroa.56.1, %if.end415.1 ], !dbg !64
  %sums.sroa.38.2 = phi float [ %add380.2.2, %for.cond352.preheader.2 ], [ %sums.sroa.38.1, %if.end415.1 ], !dbg !64
  %sums.sroa.20.2 = phi float [ %add380.1.2, %for.cond352.preheader.2 ], [ %sums.sroa.20.1, %if.end415.1 ], !dbg !64
  %sums.sroa.0.2 = phi float [ %add380.2947, %for.cond352.preheader.2 ], [ %sums.sroa.0.1, %if.end415.1 ], !dbg !64
  %probs.sroa.42.0 = phi <4 x half> [ %probs.sroa.42.22.vec.insert, %for.cond352.preheader.2 ], [ zeroinitializer, %if.end415.1 ], !dbg !64
  br i1 %or.cond856.3, label %if.end415.3, label %for.cond352.preheader.3, !dbg !80

for.cond352.preheader.3:                          ; preds = %if.end415.2
  %scores.sroa.218.48.vec.extract = extractelement <4 x float> %62, i64 0, !dbg !81
  %mul360.3952 = fmul contract float %scores.sroa.218.48.vec.extract, 0x3FB99999A0000000, !dbg !82
  %139 = tail call contract noundef float @llvm.minnum.f32(float %mul360.3952, float 0x4024CB5EC0000000), !dbg !83
  %140 = tail call contract noundef float @llvm.exp.f32(float %139), !dbg !86
  %scores.sroa.218.52.vec.extract = extractelement <4 x float> %62, i64 1, !dbg !81
  %mul360.1.3 = fmul contract float %scores.sroa.218.52.vec.extract, 0x3FB99999A0000000, !dbg !82
  %141 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1.3, float 0x4024CB5EC0000000), !dbg !83
  %142 = tail call contract noundef float @llvm.exp.f32(float %141), !dbg !86
  %scores.sroa.218.56.vec.extract = extractelement <4 x float> %62, i64 2, !dbg !81
  %mul360.2.3 = fmul contract float %scores.sroa.218.56.vec.extract, 0x3FB99999A0000000, !dbg !82
  %143 = tail call contract noundef float @llvm.minnum.f32(float %mul360.2.3, float 0x4024CB5EC0000000), !dbg !83
  %144 = tail call contract noundef float @llvm.exp.f32(float %143), !dbg !86
  %scores.sroa.218.60.vec.extract = extractelement <4 x float> %62, i64 3, !dbg !81
  %mul360.3.3 = fmul contract float %scores.sroa.218.60.vec.extract, 0x3FB99999A0000000, !dbg !82
  %145 = tail call contract noundef float @llvm.minnum.f32(float %mul360.3.3, float 0x4024CB5EC0000000), !dbg !83
  %146 = tail call contract noundef float @llvm.exp.f32(float %145), !dbg !86
  %add380.3954 = fadd contract float %sums.sroa.0.2, %140, !dbg !100
  %add380.1.3 = fadd contract float %sums.sroa.20.2, %142, !dbg !100
  %add380.2.3 = fadd contract float %sums.sroa.38.2, %144, !dbg !100
  %add380.3.3 = fadd contract float %sums.sroa.56.2, %146, !dbg !100
  %147 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %140), !dbg !89
  %148 = insertelement <4 x i16> poison, i16 %147, i64 0, !dbg !98
  %149 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %142), !dbg !89
  %150 = insertelement <4 x i16> %148, i16 %149, i64 1, !dbg !98
  %151 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %144), !dbg !89
  %152 = insertelement <4 x i16> %150, i16 %151, i64 2, !dbg !98
  %153 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %146), !dbg !89
  %154 = insertelement <4 x i16> %152, i16 %153, i64 3, !dbg !98
  %probs.sroa.62.30.vec.insert = bitcast <4 x i16> %154 to <4 x half>, !dbg !98
  br label %if.end415.3, !dbg !99

if.end415.3:                                      ; preds = %if.end415.2, %for.cond352.preheader.3
  %sums.sroa.56.3 = phi float [ %add380.3.3, %for.cond352.preheader.3 ], [ %sums.sroa.56.2, %if.end415.2 ], !dbg !64
  %sums.sroa.38.3 = phi float [ %add380.2.3, %for.cond352.preheader.3 ], [ %sums.sroa.38.2, %if.end415.2 ], !dbg !64
  %sums.sroa.20.3 = phi float [ %add380.1.3, %for.cond352.preheader.3 ], [ %sums.sroa.20.2, %if.end415.2 ], !dbg !64
  %sums.sroa.0.3 = phi float [ %add380.3954, %for.cond352.preheader.3 ], [ %sums.sroa.0.2, %if.end415.2 ], !dbg !64
  %probs.sroa.62.0 = phi <4 x half> [ %probs.sroa.62.30.vec.insert, %for.cond352.preheader.3 ], [ zeroinitializer, %if.end415.2 ], !dbg !64
  br i1 %or.cond856, label %if.end478, label %for.cond434.preheader, !dbg !101

for.cond434.preheader:                            ; preds = %if.end415.3
  %155 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %69, <4 x half> %probs.sroa.0.0, <4 x float> zeroinitializer), !dbg !102
  %156 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %68, <4 x half> %probs.sroa.0.0, <4 x float> zeroinitializer), !dbg !102
  %157 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %67, <4 x half> %probs.sroa.0.0, <4 x float> zeroinitializer), !dbg !102
  %158 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %66, <4 x half> %probs.sroa.0.0, <4 x float> zeroinitializer), !dbg !102
  br label %if.end478, !dbg !103

if.end478:                                        ; preds = %for.cond434.preheader, %if.end415.3
  %out.sroa.122.0 = phi <4 x float> [ zeroinitializer, %if.end415.3 ], [ %158, %for.cond434.preheader ], !dbg !64
  %out.sroa.82.0 = phi <4 x float> [ zeroinitializer, %if.end415.3 ], [ %157, %for.cond434.preheader ], !dbg !64
  %out.sroa.42.0 = phi <4 x float> [ zeroinitializer, %if.end415.3 ], [ %156, %for.cond434.preheader ], !dbg !64
  %out.sroa.0.0 = phi <4 x float> [ zeroinitializer, %if.end415.3 ], [ %155, %for.cond434.preheader ], !dbg !64
  br i1 %or.cond856.1, label %if.end478.1, label %for.cond456.preheader.1, !dbg !101

for.cond456.preheader.1:                          ; preds = %if.end478
  %159 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %76, <4 x half> %probs.sroa.22.0, <4 x float> zeroinitializer), !dbg !104
  %160 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %75, <4 x half> %probs.sroa.22.0, <4 x float> zeroinitializer), !dbg !104
  %161 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %74, <4 x half> %probs.sroa.22.0, <4 x float> zeroinitializer), !dbg !104
  %162 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %73, <4 x half> %probs.sroa.22.0, <4 x float> zeroinitializer), !dbg !104
  br label %if.end478.1, !dbg !103

if.end478.1:                                      ; preds = %for.cond456.preheader.1, %if.end478
  %out_1.sroa.74.1 = phi <4 x float> [ zeroinitializer, %if.end478 ], [ %162, %for.cond456.preheader.1 ], !dbg !64
  %out_1.sroa.50.1 = phi <4 x float> [ zeroinitializer, %if.end478 ], [ %161, %for.cond456.preheader.1 ], !dbg !64
  %out_1.sroa.26.1 = phi <4 x float> [ zeroinitializer, %if.end478 ], [ %160, %for.cond456.preheader.1 ], !dbg !64
  %out_1.sroa.0.1 = phi <4 x float> [ zeroinitializer, %if.end478 ], [ %159, %for.cond456.preheader.1 ], !dbg !64
  br i1 %or.cond856.2, label %if.end478.2, label %for.cond434.preheader.2, !dbg !101

for.cond434.preheader.2:                          ; preds = %if.end478.1
  %163 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %83, <4 x half> %probs.sroa.42.0, <4 x float> %out.sroa.0.0), !dbg !102
  %164 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %82, <4 x half> %probs.sroa.42.0, <4 x float> %out.sroa.42.0), !dbg !102
  %165 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %81, <4 x half> %probs.sroa.42.0, <4 x float> %out.sroa.82.0), !dbg !102
  %166 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %80, <4 x half> %probs.sroa.42.0, <4 x float> %out.sroa.122.0), !dbg !102
  br label %if.end478.2, !dbg !103

if.end478.2:                                      ; preds = %for.cond434.preheader.2, %if.end478.1
  %out.sroa.122.2 = phi <4 x float> [ %out.sroa.122.0, %if.end478.1 ], [ %166, %for.cond434.preheader.2 ], !dbg !64
  %out.sroa.82.2 = phi <4 x float> [ %out.sroa.82.0, %if.end478.1 ], [ %165, %for.cond434.preheader.2 ], !dbg !64
  %out.sroa.42.2 = phi <4 x float> [ %out.sroa.42.0, %if.end478.1 ], [ %164, %for.cond434.preheader.2 ], !dbg !64
  %out.sroa.0.2 = phi <4 x float> [ %out.sroa.0.0, %if.end478.1 ], [ %163, %for.cond434.preheader.2 ], !dbg !64
  br i1 %or.cond856.3, label %if.end478.3, label %for.cond456.preheader.3, !dbg !101

for.cond456.preheader.3:                          ; preds = %if.end478.2
  %167 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %90, <4 x half> %probs.sroa.62.0, <4 x float> %out_1.sroa.0.1), !dbg !104
  %168 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %89, <4 x half> %probs.sroa.62.0, <4 x float> %out_1.sroa.26.1), !dbg !104
  %169 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %88, <4 x half> %probs.sroa.62.0, <4 x float> %out_1.sroa.50.1), !dbg !104
  %170 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %87, <4 x half> %probs.sroa.62.0, <4 x float> %out_1.sroa.74.1), !dbg !104
  br label %if.end478.3, !dbg !103

if.end478.3:                                      ; preds = %for.cond456.preheader.3, %if.end478.2
  %out_1.sroa.74.3 = phi <4 x float> [ %out_1.sroa.74.1, %if.end478.2 ], [ %170, %for.cond456.preheader.3 ], !dbg !64
  %out_1.sroa.50.3 = phi <4 x float> [ %out_1.sroa.50.1, %if.end478.2 ], [ %169, %for.cond456.preheader.3 ], !dbg !64
  %out_1.sroa.26.3 = phi <4 x float> [ %out_1.sroa.26.1, %if.end478.2 ], [ %168, %for.cond456.preheader.3 ], !dbg !64
  %out_1.sroa.0.3 = phi <4 x float> [ %out_1.sroa.0.1, %if.end478.2 ], [ %167, %for.cond456.preheader.3 ], !dbg !64
  %or.cond.1971 = icmp ugt i32 %mul11.4, 1023, !dbg !58
  %cmp101.not.1972 = icmp sgt i32 %mul11.4, %1
  %or.cond856.1973 = or i1 %or.cond.1971, %cmp101.not.1972, !dbg !58
  br i1 %or.cond856.1973, label %if.end.1988, label %if.then.1979, !dbg !58

if.then.1979:                                     ; preds = %if.end478.3
  %171 = shl nsw i32 %cond.i.i798.4, 10, !dbg !59
  %mul105.1975 = and i32 %171, 64512, !dbg !59
  %add111.1976 = add nuw nsw i32 %add108, %mul105.1975, !dbg !60
  %idx.ext112.1977 = zext nneg i32 %add111.1976 to i64, !dbg !61
  %add.ptr113.1978 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1977, !dbg !61
  %kr.sroa.0.0.copyload18432271 = load <4 x half>, ptr addrspace(4) %add.ptr113.1978, align 16, !dbg !62
  %kr.sroa.10.0.add.ptr113.1978.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1978, i64 8, !dbg !62
  %kr.sroa.10.0.copyload18462275 = load <4 x half>, ptr addrspace(4) %kr.sroa.10.0.add.ptr113.1978.sroa_idx, align 8, !dbg !62
  br label %if.end.1988, !dbg !63

if.end.1988:                                      ; preds = %if.end478.3, %if.then.1979
  %172 = phi <4 x half> [ %kr.sroa.10.0.copyload18462275, %if.then.1979 ], [ zeroinitializer, %if.end478.3 ], !dbg !64
  %173 = phi <4 x half> [ %kr.sroa.0.0.copyload18432271, %if.then.1979 ], [ zeroinitializer, %if.end478.3 ], !dbg !64
  %or.cond.1.1985 = icmp ugt i32 %mul11.5, 1023, !dbg !58
  %cmp101.not.1.1986 = icmp sgt i32 %mul11.5, %1
  %or.cond856.1.1987 = or i1 %or.cond.1.1985, %cmp101.not.1.1986, !dbg !58
  br i1 %or.cond856.1.1987, label %if.end.1.11002, label %if.then.1.1993, !dbg !58

if.then.1.1993:                                   ; preds = %if.end.1988
  %174 = shl nsw i32 %cond.i.i798.5, 10, !dbg !59
  %mul105.1.1989 = and i32 %174, 64512, !dbg !59
  %add111.1.1990 = add nuw nsw i32 %add108, %mul105.1.1989, !dbg !60
  %idx.ext112.1.1991 = zext nneg i32 %add111.1.1990 to i64, !dbg !61
  %add.ptr113.1.1992 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1.1991, !dbg !61
  %kr.sroa.16.16.copyload18572272 = load <4 x half>, ptr addrspace(4) %add.ptr113.1.1992, align 16, !dbg !62
  %kr.sroa.24.16.add.ptr113.1.1992.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1.1992, i64 8, !dbg !62
  %kr.sroa.24.16.copyload18602276 = load <4 x half>, ptr addrspace(4) %kr.sroa.24.16.add.ptr113.1.1992.sroa_idx, align 8, !dbg !62
  br label %if.end.1.11002, !dbg !63

if.end.1.11002:                                   ; preds = %if.end.1988, %if.then.1.1993
  %175 = phi <4 x half> [ %kr.sroa.24.16.copyload18602276, %if.then.1.1993 ], [ zeroinitializer, %if.end.1988 ], !dbg !64
  %176 = phi <4 x half> [ %kr.sroa.16.16.copyload18572272, %if.then.1.1993 ], [ zeroinitializer, %if.end.1988 ], !dbg !64
  %or.cond.2.1999 = icmp ugt i32 %mul11.6, 1023, !dbg !58
  %cmp101.not.2.11000 = icmp sgt i32 %mul11.6, %1
  %or.cond856.2.11001 = or i1 %or.cond.2.1999, %cmp101.not.2.11000, !dbg !58
  br i1 %or.cond856.2.11001, label %if.end.2.11016, label %if.then.2.11007, !dbg !58

if.then.2.11007:                                  ; preds = %if.end.1.11002
  %177 = shl nsw i32 %cond.i.i798.6, 10, !dbg !59
  %mul105.2.11003 = and i32 %177, 64512, !dbg !59
  %add111.2.11004 = add nuw nsw i32 %add108, %mul105.2.11003, !dbg !60
  %idx.ext112.2.11005 = zext nneg i32 %add111.2.11004 to i64, !dbg !61
  %add.ptr113.2.11006 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.2.11005, !dbg !61
  %kr.sroa.30.32.copyload18712273 = load <4 x half>, ptr addrspace(4) %add.ptr113.2.11006, align 16, !dbg !62
  %kr.sroa.38.32.add.ptr113.2.11006.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.2.11006, i64 8, !dbg !62
  %kr.sroa.38.32.copyload18742277 = load <4 x half>, ptr addrspace(4) %kr.sroa.38.32.add.ptr113.2.11006.sroa_idx, align 8, !dbg !62
  br label %if.end.2.11016, !dbg !63

if.end.2.11016:                                   ; preds = %if.end.1.11002, %if.then.2.11007
  %178 = phi <4 x half> [ %kr.sroa.38.32.copyload18742277, %if.then.2.11007 ], [ zeroinitializer, %if.end.1.11002 ], !dbg !64
  %179 = phi <4 x half> [ %kr.sroa.30.32.copyload18712273, %if.then.2.11007 ], [ zeroinitializer, %if.end.1.11002 ], !dbg !64
  %or.cond.3.11013 = icmp ugt i32 %mul11.7, 1023, !dbg !58
  %cmp101.not.3.11014 = icmp sgt i32 %mul11.7, %1
  %or.cond856.3.11015 = or i1 %or.cond.3.11013, %cmp101.not.3.11014, !dbg !58
  br i1 %or.cond856.3.11015, label %if.end.3.11026, label %if.then.3.11021, !dbg !58

if.then.3.11021:                                  ; preds = %if.end.2.11016
  %180 = shl nsw i32 %cond.i.i798.7, 10, !dbg !59
  %mul105.3.11017 = and i32 %180, 64512, !dbg !59
  %add111.3.11018 = add nuw nsw i32 %add108, %mul105.3.11017, !dbg !60
  %idx.ext112.3.11019 = zext nneg i32 %add111.3.11018 to i64, !dbg !61
  %add.ptr113.3.11020 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.3.11019, !dbg !61
  %kr.sroa.44.48.copyload18852274 = load <4 x half>, ptr addrspace(4) %add.ptr113.3.11020, align 16, !dbg !62
  %kr.sroa.52.48.add.ptr113.3.11020.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.3.11020, i64 8, !dbg !62
  %kr.sroa.52.48.copyload18882278 = load <4 x half>, ptr addrspace(4) %kr.sroa.52.48.add.ptr113.3.11020.sroa_idx, align 8, !dbg !62
  br label %if.end.3.11026, !dbg !63

if.end.3.11026:                                   ; preds = %if.end.2.11016, %if.then.3.11021
  %181 = phi <4 x half> [ %kr.sroa.52.48.copyload18882278, %if.then.3.11021 ], [ zeroinitializer, %if.end.2.11016 ], !dbg !64
  %182 = phi <4 x half> [ %kr.sroa.44.48.copyload18852274, %if.then.3.11021 ], [ zeroinitializer, %if.end.2.11016 ], !dbg !64
  br i1 %or.cond856.1973, label %if.end.1897.1, label %if.then.1890.1, !dbg !58

if.then.1890.1:                                   ; preds = %if.end.3.11026
  %183 = shl nsw i32 %cond.i.i798.4, 10, !dbg !59
  %mul105.1884.1 = and i32 %183, 64512, !dbg !59
  %add111.1885.1 = add nuw nsw i32 %add106.1, %mul105.1884.1, !dbg !60
  %idx.ext112.1886.1 = zext nneg i32 %add111.1885.1 to i64, !dbg !61
  %add.ptr113.1887.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1886.1, !dbg !61
  %kr.sroa.58.64.copyload18992279 = load <4 x half>, ptr addrspace(4) %add.ptr113.1887.1, align 16, !dbg !62
  %kr.sroa.66.64.add.ptr113.1887.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1887.1, i64 8, !dbg !62
  %kr.sroa.66.64.copyload19022283 = load <4 x half>, ptr addrspace(4) %kr.sroa.66.64.add.ptr113.1887.1.sroa_idx, align 8, !dbg !62
  br label %if.end.1897.1, !dbg !63

if.end.1897.1:                                    ; preds = %if.end.3.11026, %if.then.1890.1
  %184 = phi <4 x half> [ %kr.sroa.66.64.copyload19022283, %if.then.1890.1 ], [ zeroinitializer, %if.end.3.11026 ], !dbg !64
  %185 = phi <4 x half> [ %kr.sroa.58.64.copyload18992279, %if.then.1890.1 ], [ zeroinitializer, %if.end.3.11026 ], !dbg !64
  br i1 %or.cond856.1.1987, label %if.end.1.1.1, label %if.then.1.1.1, !dbg !58

if.then.1.1.1:                                    ; preds = %if.end.1897.1
  %186 = shl nsw i32 %cond.i.i798.5, 10, !dbg !59
  %mul105.1.1.1 = and i32 %186, 64512, !dbg !59
  %add111.1.1.1 = add nuw nsw i32 %add106.1, %mul105.1.1.1, !dbg !60
  %idx.ext112.1.1.1 = zext nneg i32 %add111.1.1.1 to i64, !dbg !61
  %add.ptr113.1.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.1.1.1, !dbg !61
  %kr.sroa.72.80.copyload19132280 = load <4 x half>, ptr addrspace(4) %add.ptr113.1.1.1, align 16, !dbg !62
  %kr.sroa.80.80.add.ptr113.1.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.1.1.1, i64 8, !dbg !62
  %kr.sroa.80.80.copyload19162284 = load <4 x half>, ptr addrspace(4) %kr.sroa.80.80.add.ptr113.1.1.1.sroa_idx, align 8, !dbg !62
  br label %if.end.1.1.1, !dbg !63

if.end.1.1.1:                                     ; preds = %if.end.1897.1, %if.then.1.1.1
  %187 = phi <4 x half> [ %kr.sroa.80.80.copyload19162284, %if.then.1.1.1 ], [ zeroinitializer, %if.end.1897.1 ], !dbg !64
  %188 = phi <4 x half> [ %kr.sroa.72.80.copyload19132280, %if.then.1.1.1 ], [ zeroinitializer, %if.end.1897.1 ], !dbg !64
  br i1 %or.cond856.2.11001, label %if.end.2.1.1, label %if.then.2.1.1, !dbg !58

if.then.2.1.1:                                    ; preds = %if.end.1.1.1
  %189 = shl nsw i32 %cond.i.i798.6, 10, !dbg !59
  %mul105.2.1.1 = and i32 %189, 64512, !dbg !59
  %add111.2.1.1 = add nuw nsw i32 %add106.1, %mul105.2.1.1, !dbg !60
  %idx.ext112.2.1.1 = zext nneg i32 %add111.2.1.1 to i64, !dbg !61
  %add.ptr113.2.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.2.1.1, !dbg !61
  %kr.sroa.86.96.copyload19272281 = load <4 x half>, ptr addrspace(4) %add.ptr113.2.1.1, align 16, !dbg !62
  %kr.sroa.94.96.add.ptr113.2.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.2.1.1, i64 8, !dbg !62
  %kr.sroa.94.96.copyload19302285 = load <4 x half>, ptr addrspace(4) %kr.sroa.94.96.add.ptr113.2.1.1.sroa_idx, align 8, !dbg !62
  br label %if.end.2.1.1, !dbg !63

if.end.2.1.1:                                     ; preds = %if.end.1.1.1, %if.then.2.1.1
  %190 = phi <4 x half> [ %kr.sroa.94.96.copyload19302285, %if.then.2.1.1 ], [ zeroinitializer, %if.end.1.1.1 ], !dbg !64
  %191 = phi <4 x half> [ %kr.sroa.86.96.copyload19272281, %if.then.2.1.1 ], [ zeroinitializer, %if.end.1.1.1 ], !dbg !64
  br i1 %or.cond856.3.11015, label %if.end.3.1.1, label %if.then.3.1.1, !dbg !58

if.then.3.1.1:                                    ; preds = %if.end.2.1.1
  %192 = shl nsw i32 %cond.i.i798.7, 10, !dbg !59
  %mul105.3.1.1 = and i32 %192, 64512, !dbg !59
  %add111.3.1.1 = add nuw nsw i32 %add106.1, %mul105.3.1.1, !dbg !60
  %idx.ext112.3.1.1 = zext nneg i32 %add111.3.1.1 to i64, !dbg !61
  %add.ptr113.3.1.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %K.coerce, i64 %idx.ext112.3.1.1, !dbg !61
  %kr.sroa.100.112.copyload19412282 = load <4 x half>, ptr addrspace(4) %add.ptr113.3.1.1, align 16, !dbg !62
  %kr.sroa.108.112.add.ptr113.3.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr113.3.1.1, i64 8, !dbg !62
  %kr.sroa.108.112.copyload19442286 = load <4 x half>, ptr addrspace(4) %kr.sroa.108.112.add.ptr113.3.1.1.sroa_idx, align 8, !dbg !62
  br label %if.end.3.1.1, !dbg !63

if.end.3.1.1:                                     ; preds = %if.end.2.1.1, %if.then.3.1.1
  %193 = phi <4 x half> [ %kr.sroa.108.112.copyload19442286, %if.then.3.1.1 ], [ zeroinitializer, %if.end.2.1.1 ], !dbg !64
  %194 = phi <4 x half> [ %kr.sroa.100.112.copyload19412282, %if.then.3.1.1 ], [ zeroinitializer, %if.end.2.1.1 ], !dbg !64
  br i1 %or.cond856.1973, label %if.end218.11059, label %if.then164.11031, !dbg !65

if.then164.11031:                                 ; preds = %if.end.3.1.1
  %cmp167.11030 = icmp sgt i32 %mul11.4, %invariant.op, !dbg !66
  br i1 %cmp167.11030, label %for.cond169.preheader.11038, label %if.end218.11059, !dbg !67

for.cond169.preheader.11038:                      ; preds = %if.then164.11031
  %add176.11037 = add nuw nsw i32 %mul11.4, %mul175
  %cmp179.not.11039 = icmp sgt i32 %add176.11037, %1, !dbg !68
  %spec.select.11040 = select i1 %cmp179.not.11039, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.0.0.vec.insert1429 = insertelement <4 x float> poison, float %spec.select.11040, i64 0, !dbg !70
  %cmp179.not.1.11042.not = icmp slt i32 %add176.11037, %1, !dbg !68
  %spec.select.1.11043 = select i1 %cmp179.not.1.11042.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !69
  %scores.sroa.0.4.vec.insert1454 = insertelement <4 x float> %scores.sroa.0.0.vec.insert1429, float %spec.select.1.11043, i64 1, !dbg !70
  %add177.2.11045 = or disjoint i32 %add176.11037, 2, !dbg !71
  %cmp179.not.2.11046 = icmp sgt i32 %add177.2.11045, %1, !dbg !68
  %spec.select.2.11047 = select i1 %cmp179.not.2.11046, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.0.8.vec.insert1479 = insertelement <4 x float> %scores.sroa.0.4.vec.insert1454, float %spec.select.2.11047, i64 2, !dbg !70
  %add177.3.11049 = or disjoint i32 %add176.11037, 3, !dbg !71
  %cmp179.not.3.11050 = icmp sgt i32 %add177.3.11049, %1, !dbg !68
  %spec.select.3.11051 = select i1 %cmp179.not.3.11050, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.0.12.vec.insert1504 = insertelement <4 x float> %scores.sroa.0.8.vec.insert1479, float %spec.select.3.11051, i64 3, !dbg !70
  br label %if.end218.11059, !dbg !72

if.end218.11059:                                  ; preds = %if.end.3.1.1, %if.then164.11031, %for.cond169.preheader.11038
  %scores.sroa.0.2 = phi <4 x float> [ %scores.sroa.0.12.vec.insert1504, %for.cond169.preheader.11038 ], [ zeroinitializer, %if.then164.11031 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end.3.1.1 ], !dbg !64
  br i1 %or.cond856.1.1987, label %if.end218.1.1, label %if.then164.1.1, !dbg !65

if.then164.1.1:                                   ; preds = %if.end218.11059
  %cmp167.1.1 = icmp sgt i32 %mul11.5, %invariant.op, !dbg !66
  br i1 %cmp167.1.1, label %for.cond169.preheader.1.1, label %if.end218.1.1, !dbg !67

for.cond169.preheader.1.1:                        ; preds = %if.then164.1.1
  %add176.1.1 = add nuw nsw i32 %mul11.5, %mul175
  %cmp179.not.1899.1 = icmp sgt i32 %add176.1.1, %1, !dbg !68
  %spec.select.1900.1 = select i1 %cmp179.not.1899.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.74.16.vec.insert1537 = insertelement <4 x float> poison, float %spec.select.1900.1, i64 0, !dbg !70
  %cmp179.not.1.1.1.not = icmp slt i32 %add176.1.1, %1, !dbg !68
  %spec.select.1.1.1 = select i1 %cmp179.not.1.1.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !69
  %scores.sroa.74.20.vec.insert1562 = insertelement <4 x float> %scores.sroa.74.16.vec.insert1537, float %spec.select.1.1.1, i64 1, !dbg !70
  %add177.2.1.1 = or disjoint i32 %add176.1.1, 2, !dbg !71
  %cmp179.not.2.1.1 = icmp sgt i32 %add177.2.1.1, %1, !dbg !68
  %spec.select.2.1.1 = select i1 %cmp179.not.2.1.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.74.24.vec.insert1587 = insertelement <4 x float> %scores.sroa.74.20.vec.insert1562, float %spec.select.2.1.1, i64 2, !dbg !70
  %add177.3.1.1 = or disjoint i32 %add176.1.1, 3, !dbg !71
  %cmp179.not.3.1.1 = icmp sgt i32 %add177.3.1.1, %1, !dbg !68
  %spec.select.3.1.1 = select i1 %cmp179.not.3.1.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.74.28.vec.insert1612 = insertelement <4 x float> %scores.sroa.74.24.vec.insert1587, float %spec.select.3.1.1, i64 3, !dbg !70
  br label %if.end218.1.1, !dbg !72

if.end218.1.1:                                    ; preds = %if.end218.11059, %if.then164.1.1, %for.cond169.preheader.1.1
  %scores.sroa.74.2 = phi <4 x float> [ %scores.sroa.74.28.vec.insert1612, %for.cond169.preheader.1.1 ], [ zeroinitializer, %if.then164.1.1 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end218.11059 ], !dbg !64
  br i1 %or.cond856.2.11001, label %if.end218.2.1, label %if.then164.2.1, !dbg !65

if.then164.2.1:                                   ; preds = %if.end218.1.1
  %cmp167.2.1 = icmp sgt i32 %mul11.6, %invariant.op, !dbg !66
  br i1 %cmp167.2.1, label %for.cond169.preheader.2.1, label %if.end218.2.1, !dbg !67

for.cond169.preheader.2.1:                        ; preds = %if.then164.2.1
  %add176.2.1 = add nuw nsw i32 %mul11.6, %mul175
  %cmp179.not.2904.1 = icmp sgt i32 %add176.2.1, %1, !dbg !68
  %spec.select.2905.1 = select i1 %cmp179.not.2904.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.146.32.vec.insert1645 = insertelement <4 x float> poison, float %spec.select.2905.1, i64 0, !dbg !70
  %cmp179.not.1.2.1.not = icmp slt i32 %add176.2.1, %1, !dbg !68
  %spec.select.1.2.1 = select i1 %cmp179.not.1.2.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !69
  %scores.sroa.146.36.vec.insert1670 = insertelement <4 x float> %scores.sroa.146.32.vec.insert1645, float %spec.select.1.2.1, i64 1, !dbg !70
  %add177.2.2.1 = or disjoint i32 %add176.2.1, 2, !dbg !71
  %cmp179.not.2.2.1 = icmp sgt i32 %add177.2.2.1, %1, !dbg !68
  %spec.select.2.2.1 = select i1 %cmp179.not.2.2.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.146.40.vec.insert1695 = insertelement <4 x float> %scores.sroa.146.36.vec.insert1670, float %spec.select.2.2.1, i64 2, !dbg !70
  %add177.3.2.1 = or disjoint i32 %add176.2.1, 3, !dbg !71
  %cmp179.not.3.2.1 = icmp sgt i32 %add177.3.2.1, %1, !dbg !68
  %spec.select.3.2.1 = select i1 %cmp179.not.3.2.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.146.44.vec.insert1720 = insertelement <4 x float> %scores.sroa.146.40.vec.insert1695, float %spec.select.3.2.1, i64 3, !dbg !70
  br label %if.end218.2.1, !dbg !72

if.end218.2.1:                                    ; preds = %if.end218.1.1, %if.then164.2.1, %for.cond169.preheader.2.1
  %scores.sroa.146.2 = phi <4 x float> [ %scores.sroa.146.44.vec.insert1720, %for.cond169.preheader.2.1 ], [ zeroinitializer, %if.then164.2.1 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end218.1.1 ], !dbg !64
  br i1 %or.cond856.3.11015, label %if.end218.3.1, label %if.then164.3.1, !dbg !65

if.then164.3.1:                                   ; preds = %if.end218.2.1
  %cmp167.3.1 = icmp sgt i32 %mul11.7, %invariant.op, !dbg !66
  br i1 %cmp167.3.1, label %for.cond169.preheader.3.1, label %if.end218.3.1, !dbg !67

for.cond169.preheader.3.1:                        ; preds = %if.then164.3.1
  %add176.3.1 = add nuw nsw i32 %mul11.7, %mul175
  %cmp179.not.3909.1 = icmp sgt i32 %add176.3.1, %1, !dbg !68
  %spec.select.3910.1 = select i1 %cmp179.not.3909.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.218.48.vec.insert1753 = insertelement <4 x float> poison, float %spec.select.3910.1, i64 0, !dbg !70
  %cmp179.not.1.3.1.not = icmp slt i32 %add176.3.1, %1, !dbg !68
  %spec.select.1.3.1 = select i1 %cmp179.not.1.3.1.not, float 0.000000e+00, float 0xFFF0000000000000, !dbg !69
  %scores.sroa.218.52.vec.insert1778 = insertelement <4 x float> %scores.sroa.218.48.vec.insert1753, float %spec.select.1.3.1, i64 1, !dbg !70
  %add177.2.3.1 = or disjoint i32 %add176.3.1, 2, !dbg !71
  %cmp179.not.2.3.1 = icmp sgt i32 %add177.2.3.1, %1, !dbg !68
  %spec.select.2.3.1 = select i1 %cmp179.not.2.3.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.218.56.vec.insert1803 = insertelement <4 x float> %scores.sroa.218.52.vec.insert1778, float %spec.select.2.3.1, i64 2, !dbg !70
  %add177.3.3.1 = or disjoint i32 %add176.3.1, 3, !dbg !71
  %cmp179.not.3.3.1 = icmp sgt i32 %add177.3.3.1, %1, !dbg !68
  %spec.select.3.3.1 = select i1 %cmp179.not.3.3.1, float 0xFFF0000000000000, float 0.000000e+00, !dbg !69
  %scores.sroa.218.60.vec.insert1828 = insertelement <4 x float> %scores.sroa.218.56.vec.insert1803, float %spec.select.3.3.1, i64 3, !dbg !70
  br label %if.end218.3.1, !dbg !72

if.end218.3.1:                                    ; preds = %if.end218.2.1, %if.then164.3.1, %for.cond169.preheader.3.1
  %scores.sroa.218.2 = phi <4 x float> [ %scores.sroa.218.60.vec.insert1828, %for.cond169.preheader.3.1 ], [ zeroinitializer, %if.then164.3.1 ], [ <float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000, float 0xFFF0000000000000>, %if.end218.2.1 ], !dbg !64
  %195 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %173, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.0.2), !dbg !73, !call_argsrelate !74
  %196 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %176, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.74.2), !dbg !73, !call_argsrelate !74
  %197 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %179, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.146.2), !dbg !73, !call_argsrelate !74
  %198 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %182, <4 x half> %qr.sroa.0.0.copyload, <4 x float> %scores.sroa.218.2), !dbg !73, !call_argsrelate !74
  %199 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %172, <4 x half> %qr.sroa.5.0.copyload, <4 x float> %195), !dbg !73, !call_argsrelate !74
  %200 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %175, <4 x half> %qr.sroa.5.0.copyload, <4 x float> %196), !dbg !73, !call_argsrelate !74
  %201 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %178, <4 x half> %qr.sroa.5.0.copyload, <4 x float> %197), !dbg !73, !call_argsrelate !74
  %202 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %181, <4 x half> %qr.sroa.5.0.copyload, <4 x float> %198), !dbg !73, !call_argsrelate !74
  %203 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %185, <4 x half> %qr.sroa.7.16.copyload, <4 x float> %199), !dbg !73, !call_argsrelate !74
  %204 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %188, <4 x half> %qr.sroa.7.16.copyload, <4 x float> %200), !dbg !73, !call_argsrelate !74
  %205 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %191, <4 x half> %qr.sroa.7.16.copyload, <4 x float> %201), !dbg !73, !call_argsrelate !74
  %206 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %194, <4 x half> %qr.sroa.7.16.copyload, <4 x float> %202), !dbg !73, !call_argsrelate !74
  %207 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %184, <4 x half> %qr.sroa.10.16.copyload, <4 x float> %203), !dbg !73, !call_argsrelate !74
  %208 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %187, <4 x half> %qr.sroa.10.16.copyload, <4 x float> %204), !dbg !73, !call_argsrelate !74
  %209 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %190, <4 x half> %qr.sroa.10.16.copyload, <4 x float> %205), !dbg !73, !call_argsrelate !74
  %210 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %193, <4 x half> %qr.sroa.10.16.copyload, <4 x float> %206), !dbg !73, !call_argsrelate !74
  br i1 %or.cond856.1973, label %if.end335.11090, label %for.cond274.preheader.11078, !dbg !75

for.cond274.preheader.11078:                      ; preds = %if.end218.3.1
  %211 = shl nsw i32 %cond.i.i798.4, 10
  %mul281.11076 = and i32 %211, 64512
  %add284.11077 = add nuw nsw i32 %add108, %mul281.11076
  %212 = zext nneg i32 %add284.11077 to i64, !dbg !76
  %add.ptr289.11079 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %212, !dbg !77
  %vr.sroa.0.0.copyload12692303 = load <4 x half>, ptr addrspace(4) %add.ptr289.11079, align 16, !dbg !78
  %vr.sroa.12.0.add.ptr289.11079.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr289.11079, i64 8, !dbg !78
  %vr.sroa.12.0.copyload12722304 = load <4 x half>, ptr addrspace(4) %vr.sroa.12.0.add.ptr289.11079.sroa_idx, align 8, !dbg !78
  %213 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %212, !dbg !77
  %add.ptr289.1.11080 = getelementptr inbounds i8, ptr addrspace(4) %213, i64 1024, !dbg !77
  %vr.sroa.20.16.copyload12872305 = load <4 x half>, ptr addrspace(4) %add.ptr289.1.11080, align 16, !dbg !78
  %vr.sroa.30.16.add.ptr289.1.11080.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %213, i64 1032, !dbg !78
  %vr.sroa.30.16.copyload12902306 = load <4 x half>, ptr addrspace(4) %vr.sroa.30.16.add.ptr289.1.11080.sroa_idx, align 8, !dbg !78
  br label %if.end335.11090, !dbg !79

if.end335.11090:                                  ; preds = %if.end218.3.1, %for.cond274.preheader.11078
  %214 = phi <4 x half> [ %vr.sroa.30.16.copyload12902306, %for.cond274.preheader.11078 ], [ zeroinitializer, %if.end218.3.1 ], !dbg !64
  %215 = phi <4 x half> [ %vr.sroa.20.16.copyload12872305, %for.cond274.preheader.11078 ], [ zeroinitializer, %if.end218.3.1 ], !dbg !64
  %216 = phi <4 x half> [ %vr.sroa.12.0.copyload12722304, %for.cond274.preheader.11078 ], [ zeroinitializer, %if.end218.3.1 ], !dbg !64
  %217 = phi <4 x half> [ %vr.sroa.0.0.copyload12692303, %for.cond274.preheader.11078 ], [ zeroinitializer, %if.end218.3.1 ], !dbg !64
  br i1 %or.cond856.1.1987, label %if.end335.1.1, label %for.cond274.preheader.1.1, !dbg !75

for.cond274.preheader.1.1:                        ; preds = %if.end335.11090
  %218 = shl nsw i32 %cond.i.i798.5, 10
  %mul281.1.1 = and i32 %218, 64512
  %add284.1.1 = add nuw nsw i32 %add108, %mul281.1.1
  %219 = zext nneg i32 %add284.1.1 to i64, !dbg !76
  %add.ptr289.1929.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %219, !dbg !77
  %vr.sroa.38.32.copyload13052307 = load <4 x half>, ptr addrspace(4) %add.ptr289.1929.1, align 16, !dbg !78
  %vr.sroa.48.32.add.ptr289.1929.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr289.1929.1, i64 8, !dbg !78
  %vr.sroa.48.32.copyload13082308 = load <4 x half>, ptr addrspace(4) %vr.sroa.48.32.add.ptr289.1929.1.sroa_idx, align 8, !dbg !78
  %220 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %219, !dbg !77
  %add.ptr289.1.1.1 = getelementptr inbounds i8, ptr addrspace(4) %220, i64 1024, !dbg !77
  %vr.sroa.56.48.copyload13232309 = load <4 x half>, ptr addrspace(4) %add.ptr289.1.1.1, align 16, !dbg !78
  %vr.sroa.66.48.add.ptr289.1.1.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %220, i64 1032, !dbg !78
  %vr.sroa.66.48.copyload13262310 = load <4 x half>, ptr addrspace(4) %vr.sroa.66.48.add.ptr289.1.1.1.sroa_idx, align 8, !dbg !78
  br label %if.end335.1.1, !dbg !79

if.end335.1.1:                                    ; preds = %if.end335.11090, %for.cond274.preheader.1.1
  %221 = phi <4 x half> [ %vr.sroa.66.48.copyload13262310, %for.cond274.preheader.1.1 ], [ zeroinitializer, %if.end335.11090 ], !dbg !64
  %222 = phi <4 x half> [ %vr.sroa.56.48.copyload13232309, %for.cond274.preheader.1.1 ], [ zeroinitializer, %if.end335.11090 ], !dbg !64
  %223 = phi <4 x half> [ %vr.sroa.48.32.copyload13082308, %for.cond274.preheader.1.1 ], [ zeroinitializer, %if.end335.11090 ], !dbg !64
  %224 = phi <4 x half> [ %vr.sroa.38.32.copyload13052307, %for.cond274.preheader.1.1 ], [ zeroinitializer, %if.end335.11090 ], !dbg !64
  br i1 %or.cond856.2.11001, label %if.end335.2.1, label %for.cond274.preheader.2.1, !dbg !75

for.cond274.preheader.2.1:                        ; preds = %if.end335.1.1
  %225 = shl nsw i32 %cond.i.i798.6, 10
  %mul281.2.1 = and i32 %225, 64512
  %add284.2.1 = add nuw nsw i32 %add108, %mul281.2.1
  %226 = zext nneg i32 %add284.2.1 to i64, !dbg !76
  %add.ptr289.2.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %226, !dbg !77
  %vr.sroa.74.64.copyload13412311 = load <4 x half>, ptr addrspace(4) %add.ptr289.2.1, align 16, !dbg !78
  %vr.sroa.84.64.add.ptr289.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr289.2.1, i64 8, !dbg !78
  %vr.sroa.84.64.copyload13442312 = load <4 x half>, ptr addrspace(4) %vr.sroa.84.64.add.ptr289.2.1.sroa_idx, align 8, !dbg !78
  %227 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %226, !dbg !77
  %add.ptr289.1.2.1 = getelementptr inbounds i8, ptr addrspace(4) %227, i64 1024, !dbg !77
  %vr.sroa.92.80.copyload13592313 = load <4 x half>, ptr addrspace(4) %add.ptr289.1.2.1, align 16, !dbg !78
  %vr.sroa.102.80.add.ptr289.1.2.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %227, i64 1032, !dbg !78
  %vr.sroa.102.80.copyload13622314 = load <4 x half>, ptr addrspace(4) %vr.sroa.102.80.add.ptr289.1.2.1.sroa_idx, align 8, !dbg !78
  br label %if.end335.2.1, !dbg !79

if.end335.2.1:                                    ; preds = %if.end335.1.1, %for.cond274.preheader.2.1
  %228 = phi <4 x half> [ %vr.sroa.102.80.copyload13622314, %for.cond274.preheader.2.1 ], [ zeroinitializer, %if.end335.1.1 ], !dbg !64
  %229 = phi <4 x half> [ %vr.sroa.92.80.copyload13592313, %for.cond274.preheader.2.1 ], [ zeroinitializer, %if.end335.1.1 ], !dbg !64
  %230 = phi <4 x half> [ %vr.sroa.84.64.copyload13442312, %for.cond274.preheader.2.1 ], [ zeroinitializer, %if.end335.1.1 ], !dbg !64
  %231 = phi <4 x half> [ %vr.sroa.74.64.copyload13412311, %for.cond274.preheader.2.1 ], [ zeroinitializer, %if.end335.1.1 ], !dbg !64
  br i1 %or.cond856.3.11015, label %if.end335.3.1, label %for.cond274.preheader.3.1, !dbg !75

for.cond274.preheader.3.1:                        ; preds = %if.end335.2.1
  %232 = shl nsw i32 %cond.i.i798.7, 10
  %mul281.3.1 = and i32 %232, 64512
  %add284.3.1 = add nuw nsw i32 %add108, %mul281.3.1
  %233 = zext nneg i32 %add284.3.1 to i64, !dbg !76
  %add.ptr289.3.1 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %233, !dbg !77
  %vr.sroa.110.96.copyload13772315 = load <4 x half>, ptr addrspace(4) %add.ptr289.3.1, align 16, !dbg !78
  %vr.sroa.120.96.add.ptr289.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %add.ptr289.3.1, i64 8, !dbg !78
  %vr.sroa.120.96.copyload13802316 = load <4 x half>, ptr addrspace(4) %vr.sroa.120.96.add.ptr289.3.1.sroa_idx, align 8, !dbg !78
  %234 = getelementptr inbounds %struct.__half, ptr addrspace(4) %V.coerce, i64 %233, !dbg !77
  %add.ptr289.1.3.1 = getelementptr inbounds i8, ptr addrspace(4) %234, i64 1024, !dbg !77
  %vr.sroa.128.112.copyload13952317 = load <4 x half>, ptr addrspace(4) %add.ptr289.1.3.1, align 16, !dbg !78
  %vr.sroa.138.112.add.ptr289.1.3.1.sroa_idx = getelementptr inbounds i8, ptr addrspace(4) %234, i64 1032, !dbg !78
  %vr.sroa.138.112.copyload13982318 = load <4 x half>, ptr addrspace(4) %vr.sroa.138.112.add.ptr289.1.3.1.sroa_idx, align 8, !dbg !78
  br label %if.end335.3.1, !dbg !79

if.end335.3.1:                                    ; preds = %if.end335.2.1, %for.cond274.preheader.3.1
  %235 = phi <4 x half> [ %vr.sroa.138.112.copyload13982318, %for.cond274.preheader.3.1 ], [ zeroinitializer, %if.end335.2.1 ], !dbg !64
  %236 = phi <4 x half> [ %vr.sroa.128.112.copyload13952317, %for.cond274.preheader.3.1 ], [ zeroinitializer, %if.end335.2.1 ], !dbg !64
  %237 = phi <4 x half> [ %vr.sroa.120.96.copyload13802316, %for.cond274.preheader.3.1 ], [ zeroinitializer, %if.end335.2.1 ], !dbg !64
  %238 = phi <4 x half> [ %vr.sroa.110.96.copyload13772315, %for.cond274.preheader.3.1 ], [ zeroinitializer, %if.end335.2.1 ], !dbg !64
  br i1 %or.cond856.1973, label %if.end415.11126, label %for.cond352.preheader.11094, !dbg !80

for.cond352.preheader.11094:                      ; preds = %if.end335.3.1
  %scores.sroa.0.0.vec.extract1433 = extractelement <4 x float> %207, i64 0, !dbg !81
  %mul360.11095 = fmul contract float %scores.sroa.0.0.vec.extract1433, 0x3FB99999A0000000, !dbg !82
  %239 = tail call contract noundef float @llvm.minnum.f32(float %mul360.11095, float 0x4024CB5EC0000000), !dbg !83
  %240 = tail call contract noundef float @llvm.exp.f32(float %239), !dbg !86
  %scores.sroa.0.4.vec.extract1458 = extractelement <4 x float> %207, i64 1, !dbg !81
  %mul360.1.11097 = fmul contract float %scores.sroa.0.4.vec.extract1458, 0x3FB99999A0000000, !dbg !82
  %241 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1.11097, float 0x4024CB5EC0000000), !dbg !83
  %242 = tail call contract noundef float @llvm.exp.f32(float %241), !dbg !86
  %scores.sroa.0.8.vec.extract1483 = extractelement <4 x float> %207, i64 2, !dbg !81
  %mul360.2.11099 = fmul contract float %scores.sroa.0.8.vec.extract1483, 0x3FB99999A0000000, !dbg !82
  %243 = tail call contract noundef float @llvm.minnum.f32(float %mul360.2.11099, float 0x4024CB5EC0000000), !dbg !83
  %244 = tail call contract noundef float @llvm.exp.f32(float %243), !dbg !86
  %scores.sroa.0.12.vec.extract1508 = extractelement <4 x float> %207, i64 3, !dbg !81
  %mul360.3.11101 = fmul contract float %scores.sroa.0.12.vec.extract1508, 0x3FB99999A0000000, !dbg !82
  %245 = tail call contract noundef float @llvm.minnum.f32(float %mul360.3.11101, float 0x4024CB5EC0000000), !dbg !83
  %246 = tail call contract noundef float @llvm.exp.f32(float %245), !dbg !86
  %add380.11103 = fadd contract float %sums.sroa.0.3, %240, !dbg !100
  %add380.1.11106 = fadd contract float %sums.sroa.20.3, %242, !dbg !100
  %add380.2.11109 = fadd contract float %sums.sroa.38.3, %244, !dbg !100
  %add380.3.11112 = fadd contract float %sums.sroa.56.3, %246, !dbg !100
  %247 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %240), !dbg !89
  %248 = insertelement <4 x i16> poison, i16 %247, i64 0, !dbg !98
  %249 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %242), !dbg !89
  %250 = insertelement <4 x i16> %248, i16 %249, i64 1, !dbg !98
  %251 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %244), !dbg !89
  %252 = insertelement <4 x i16> %250, i16 %251, i64 2, !dbg !98
  %253 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %246), !dbg !89
  %254 = insertelement <4 x i16> %252, i16 %253, i64 3, !dbg !98
  %probs.sroa.0.6.vec.insert1176 = bitcast <4 x i16> %254 to <4 x half>, !dbg !98
  br label %if.end415.11126, !dbg !99

if.end415.11126:                                  ; preds = %if.end335.3.1, %for.cond352.preheader.11094
  %sums.sroa.56.4 = phi float [ %add380.3.11112, %for.cond352.preheader.11094 ], [ %sums.sroa.56.3, %if.end335.3.1 ], !dbg !64
  %sums.sroa.38.4 = phi float [ %add380.2.11109, %for.cond352.preheader.11094 ], [ %sums.sroa.38.3, %if.end335.3.1 ], !dbg !64
  %sums.sroa.20.4 = phi float [ %add380.1.11106, %for.cond352.preheader.11094 ], [ %sums.sroa.20.3, %if.end335.3.1 ], !dbg !64
  %sums.sroa.0.4 = phi float [ %add380.11103, %for.cond352.preheader.11094 ], [ %sums.sroa.0.3, %if.end335.3.1 ], !dbg !64
  %probs.sroa.0.1 = phi <4 x half> [ %probs.sroa.0.6.vec.insert1176, %for.cond352.preheader.11094 ], [ zeroinitializer, %if.end335.3.1 ], !dbg !64
  br i1 %or.cond856.1.1987, label %if.end415.1.1, label %for.cond352.preheader.1.1, !dbg !80

for.cond352.preheader.1.1:                        ; preds = %if.end415.11126
  %scores.sroa.74.16.vec.extract1541 = extractelement <4 x float> %208, i64 0, !dbg !81
  %mul360.1938.1 = fmul contract float %scores.sroa.74.16.vec.extract1541, 0x3FB99999A0000000, !dbg !82
  %255 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1938.1, float 0x4024CB5EC0000000), !dbg !83
  %256 = tail call contract noundef float @llvm.exp.f32(float %255), !dbg !86
  %scores.sroa.74.20.vec.extract1566 = extractelement <4 x float> %208, i64 1, !dbg !81
  %mul360.1.1.1 = fmul contract float %scores.sroa.74.20.vec.extract1566, 0x3FB99999A0000000, !dbg !82
  %257 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1.1.1, float 0x4024CB5EC0000000), !dbg !83
  %258 = tail call contract noundef float @llvm.exp.f32(float %257), !dbg !86
  %scores.sroa.74.24.vec.extract1591 = extractelement <4 x float> %208, i64 2, !dbg !81
  %mul360.2.1.1 = fmul contract float %scores.sroa.74.24.vec.extract1591, 0x3FB99999A0000000, !dbg !82
  %259 = tail call contract noundef float @llvm.minnum.f32(float %mul360.2.1.1, float 0x4024CB5EC0000000), !dbg !83
  %260 = tail call contract noundef float @llvm.exp.f32(float %259), !dbg !86
  %scores.sroa.74.28.vec.extract1616 = extractelement <4 x float> %208, i64 3, !dbg !81
  %mul360.3.1.1 = fmul contract float %scores.sroa.74.28.vec.extract1616, 0x3FB99999A0000000, !dbg !82
  %261 = tail call contract noundef float @llvm.minnum.f32(float %mul360.3.1.1, float 0x4024CB5EC0000000), !dbg !83
  %262 = tail call contract noundef float @llvm.exp.f32(float %261), !dbg !86
  %add380.1940.1 = fadd contract float %sums.sroa.0.4, %256, !dbg !100
  %add380.1.1.1 = fadd contract float %sums.sroa.20.4, %258, !dbg !100
  %add380.2.1.1 = fadd contract float %sums.sroa.38.4, %260, !dbg !100
  %add380.3.1.1 = fadd contract float %sums.sroa.56.4, %262, !dbg !100
  %263 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %256), !dbg !89
  %264 = insertelement <4 x i16> poison, i16 %263, i64 0, !dbg !98
  %265 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %258), !dbg !89
  %266 = insertelement <4 x i16> %264, i16 %265, i64 1, !dbg !98
  %267 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %260), !dbg !89
  %268 = insertelement <4 x i16> %266, i16 %267, i64 2, !dbg !98
  %269 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %262), !dbg !89
  %270 = insertelement <4 x i16> %268, i16 %269, i64 3, !dbg !98
  %probs.sroa.22.14.vec.insert1204 = bitcast <4 x i16> %270 to <4 x half>, !dbg !98
  br label %if.end415.1.1, !dbg !99

if.end415.1.1:                                    ; preds = %if.end415.11126, %for.cond352.preheader.1.1
  %sums.sroa.56.5 = phi float [ %add380.3.1.1, %for.cond352.preheader.1.1 ], [ %sums.sroa.56.4, %if.end415.11126 ], !dbg !64
  %sums.sroa.38.5 = phi float [ %add380.2.1.1, %for.cond352.preheader.1.1 ], [ %sums.sroa.38.4, %if.end415.11126 ], !dbg !64
  %sums.sroa.20.5 = phi float [ %add380.1.1.1, %for.cond352.preheader.1.1 ], [ %sums.sroa.20.4, %if.end415.11126 ], !dbg !64
  %sums.sroa.0.5 = phi float [ %add380.1940.1, %for.cond352.preheader.1.1 ], [ %sums.sroa.0.4, %if.end415.11126 ], !dbg !64
  %probs.sroa.22.1 = phi <4 x half> [ %probs.sroa.22.14.vec.insert1204, %for.cond352.preheader.1.1 ], [ zeroinitializer, %if.end415.11126 ], !dbg !64
  br i1 %or.cond856.2.11001, label %if.end415.2.1, label %for.cond352.preheader.2.1, !dbg !80

for.cond352.preheader.2.1:                        ; preds = %if.end415.1.1
  %scores.sroa.146.32.vec.extract1649 = extractelement <4 x float> %209, i64 0, !dbg !81
  %mul360.2945.1 = fmul contract float %scores.sroa.146.32.vec.extract1649, 0x3FB99999A0000000, !dbg !82
  %271 = tail call contract noundef float @llvm.minnum.f32(float %mul360.2945.1, float 0x4024CB5EC0000000), !dbg !83
  %272 = tail call contract noundef float @llvm.exp.f32(float %271), !dbg !86
  %scores.sroa.146.36.vec.extract1674 = extractelement <4 x float> %209, i64 1, !dbg !81
  %mul360.1.2.1 = fmul contract float %scores.sroa.146.36.vec.extract1674, 0x3FB99999A0000000, !dbg !82
  %273 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1.2.1, float 0x4024CB5EC0000000), !dbg !83
  %274 = tail call contract noundef float @llvm.exp.f32(float %273), !dbg !86
  %scores.sroa.146.40.vec.extract1699 = extractelement <4 x float> %209, i64 2, !dbg !81
  %mul360.2.2.1 = fmul contract float %scores.sroa.146.40.vec.extract1699, 0x3FB99999A0000000, !dbg !82
  %275 = tail call contract noundef float @llvm.minnum.f32(float %mul360.2.2.1, float 0x4024CB5EC0000000), !dbg !83
  %276 = tail call contract noundef float @llvm.exp.f32(float %275), !dbg !86
  %scores.sroa.146.44.vec.extract1724 = extractelement <4 x float> %209, i64 3, !dbg !81
  %mul360.3.2.1 = fmul contract float %scores.sroa.146.44.vec.extract1724, 0x3FB99999A0000000, !dbg !82
  %277 = tail call contract noundef float @llvm.minnum.f32(float %mul360.3.2.1, float 0x4024CB5EC0000000), !dbg !83
  %278 = tail call contract noundef float @llvm.exp.f32(float %277), !dbg !86
  %add380.2947.1 = fadd contract float %sums.sroa.0.5, %272, !dbg !100
  %add380.1.2.1 = fadd contract float %sums.sroa.20.5, %274, !dbg !100
  %add380.2.2.1 = fadd contract float %sums.sroa.38.5, %276, !dbg !100
  %add380.3.2.1 = fadd contract float %sums.sroa.56.5, %278, !dbg !100
  %279 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %272), !dbg !89
  %280 = insertelement <4 x i16> poison, i16 %279, i64 0, !dbg !98
  %281 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %274), !dbg !89
  %282 = insertelement <4 x i16> %280, i16 %281, i64 1, !dbg !98
  %283 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %276), !dbg !89
  %284 = insertelement <4 x i16> %282, i16 %283, i64 2, !dbg !98
  %285 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %278), !dbg !89
  %286 = insertelement <4 x i16> %284, i16 %285, i64 3, !dbg !98
  %probs.sroa.42.22.vec.insert1232 = bitcast <4 x i16> %286 to <4 x half>, !dbg !98
  br label %if.end415.2.1, !dbg !99

if.end415.2.1:                                    ; preds = %if.end415.1.1, %for.cond352.preheader.2.1
  %sums.sroa.56.6 = phi float [ %add380.3.2.1, %for.cond352.preheader.2.1 ], [ %sums.sroa.56.5, %if.end415.1.1 ], !dbg !64
  %sums.sroa.38.6 = phi float [ %add380.2.2.1, %for.cond352.preheader.2.1 ], [ %sums.sroa.38.5, %if.end415.1.1 ], !dbg !64
  %sums.sroa.20.6 = phi float [ %add380.1.2.1, %for.cond352.preheader.2.1 ], [ %sums.sroa.20.5, %if.end415.1.1 ], !dbg !64
  %sums.sroa.0.6 = phi float [ %add380.2947.1, %for.cond352.preheader.2.1 ], [ %sums.sroa.0.5, %if.end415.1.1 ], !dbg !64
  %probs.sroa.42.1 = phi <4 x half> [ %probs.sroa.42.22.vec.insert1232, %for.cond352.preheader.2.1 ], [ zeroinitializer, %if.end415.1.1 ], !dbg !64
  br i1 %or.cond856.3.11015, label %if.end415.3.1, label %for.cond352.preheader.3.1, !dbg !80

for.cond352.preheader.3.1:                        ; preds = %if.end415.2.1
  %scores.sroa.218.48.vec.extract1757 = extractelement <4 x float> %210, i64 0, !dbg !81
  %mul360.3952.1 = fmul contract float %scores.sroa.218.48.vec.extract1757, 0x3FB99999A0000000, !dbg !82
  %287 = tail call contract noundef float @llvm.minnum.f32(float %mul360.3952.1, float 0x4024CB5EC0000000), !dbg !83
  %288 = tail call contract noundef float @llvm.exp.f32(float %287), !dbg !86
  %scores.sroa.218.52.vec.extract1782 = extractelement <4 x float> %210, i64 1, !dbg !81
  %mul360.1.3.1 = fmul contract float %scores.sroa.218.52.vec.extract1782, 0x3FB99999A0000000, !dbg !82
  %289 = tail call contract noundef float @llvm.minnum.f32(float %mul360.1.3.1, float 0x4024CB5EC0000000), !dbg !83
  %290 = tail call contract noundef float @llvm.exp.f32(float %289), !dbg !86
  %scores.sroa.218.56.vec.extract1807 = extractelement <4 x float> %210, i64 2, !dbg !81
  %mul360.2.3.1 = fmul contract float %scores.sroa.218.56.vec.extract1807, 0x3FB99999A0000000, !dbg !82
  %291 = tail call contract noundef float @llvm.minnum.f32(float %mul360.2.3.1, float 0x4024CB5EC0000000), !dbg !83
  %292 = tail call contract noundef float @llvm.exp.f32(float %291), !dbg !86
  %scores.sroa.218.60.vec.extract1832 = extractelement <4 x float> %210, i64 3, !dbg !81
  %mul360.3.3.1 = fmul contract float %scores.sroa.218.60.vec.extract1832, 0x3FB99999A0000000, !dbg !82
  %293 = tail call contract noundef float @llvm.minnum.f32(float %mul360.3.3.1, float 0x4024CB5EC0000000), !dbg !83
  %294 = tail call contract noundef float @llvm.exp.f32(float %293), !dbg !86
  %add380.3954.1 = fadd contract float %sums.sroa.0.6, %288, !dbg !100
  %add380.1.3.1 = fadd contract float %sums.sroa.20.6, %290, !dbg !100
  %add380.2.3.1 = fadd contract float %sums.sroa.38.6, %292, !dbg !100
  %add380.3.3.1 = fadd contract float %sums.sroa.56.6, %294, !dbg !100
  %295 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %288), !dbg !89
  %296 = insertelement <4 x i16> poison, i16 %295, i64 0, !dbg !98
  %297 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %290), !dbg !89
  %298 = insertelement <4 x i16> %296, i16 %297, i64 1, !dbg !98
  %299 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %292), !dbg !89
  %300 = insertelement <4 x i16> %298, i16 %299, i64 2, !dbg !98
  %301 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %294), !dbg !89
  %302 = insertelement <4 x i16> %300, i16 %301, i64 3, !dbg !98
  %probs.sroa.62.30.vec.insert1260 = bitcast <4 x i16> %302 to <4 x half>, !dbg !98
  br label %if.end415.3.1, !dbg !99

if.end415.3.1:                                    ; preds = %if.end415.2.1, %for.cond352.preheader.3.1
  %sums.sroa.56.7 = phi float [ %add380.3.3.1, %for.cond352.preheader.3.1 ], [ %sums.sroa.56.6, %if.end415.2.1 ], !dbg !64
  %sums.sroa.38.7 = phi float [ %add380.2.3.1, %for.cond352.preheader.3.1 ], [ %sums.sroa.38.6, %if.end415.2.1 ], !dbg !64
  %sums.sroa.20.7 = phi float [ %add380.1.3.1, %for.cond352.preheader.3.1 ], [ %sums.sroa.20.6, %if.end415.2.1 ], !dbg !64
  %sums.sroa.0.7 = phi float [ %add380.3954.1, %for.cond352.preheader.3.1 ], [ %sums.sroa.0.6, %if.end415.2.1 ], !dbg !64
  %probs.sroa.62.1 = phi <4 x half> [ %probs.sroa.62.30.vec.insert1260, %for.cond352.preheader.3.1 ], [ zeroinitializer, %if.end415.2.1 ], !dbg !64
  br i1 %or.cond856.1973, label %if.end478.11141, label %for.cond434.preheader.11136, !dbg !101

for.cond434.preheader.11136:                      ; preds = %if.end415.3.1
  %303 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %217, <4 x half> %probs.sroa.0.1, <4 x float> %out.sroa.0.2), !dbg !102
  %304 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %216, <4 x half> %probs.sroa.0.1, <4 x float> %out.sroa.42.2), !dbg !102
  %305 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %215, <4 x half> %probs.sroa.0.1, <4 x float> %out.sroa.82.2), !dbg !102
  %306 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %214, <4 x half> %probs.sroa.0.1, <4 x float> %out.sroa.122.2), !dbg !102
  br label %if.end478.11141, !dbg !103

if.end478.11141:                                  ; preds = %for.cond434.preheader.11136, %if.end415.3.1
  %out.sroa.122.4 = phi <4 x float> [ %out.sroa.122.2, %if.end415.3.1 ], [ %306, %for.cond434.preheader.11136 ], !dbg !64
  %out.sroa.82.4 = phi <4 x float> [ %out.sroa.82.2, %if.end415.3.1 ], [ %305, %for.cond434.preheader.11136 ], !dbg !64
  %out.sroa.42.4 = phi <4 x float> [ %out.sroa.42.2, %if.end415.3.1 ], [ %304, %for.cond434.preheader.11136 ], !dbg !64
  %out.sroa.0.4 = phi <4 x float> [ %out.sroa.0.2, %if.end415.3.1 ], [ %303, %for.cond434.preheader.11136 ], !dbg !64
  br i1 %or.cond856.1.1987, label %if.end478.1.1, label %for.cond456.preheader.1.1, !dbg !101

for.cond456.preheader.1.1:                        ; preds = %if.end478.11141
  %307 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %224, <4 x half> %probs.sroa.22.1, <4 x float> %out_1.sroa.0.3), !dbg !104
  %308 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %223, <4 x half> %probs.sroa.22.1, <4 x float> %out_1.sroa.26.3), !dbg !104
  %309 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %222, <4 x half> %probs.sroa.22.1, <4 x float> %out_1.sroa.50.3), !dbg !104
  %310 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %221, <4 x half> %probs.sroa.22.1, <4 x float> %out_1.sroa.74.3), !dbg !104
  br label %if.end478.1.1, !dbg !103

if.end478.1.1:                                    ; preds = %for.cond456.preheader.1.1, %if.end478.11141
  %out_1.sroa.74.5 = phi <4 x float> [ %out_1.sroa.74.3, %if.end478.11141 ], [ %310, %for.cond456.preheader.1.1 ], !dbg !64
  %out_1.sroa.50.5 = phi <4 x float> [ %out_1.sroa.50.3, %if.end478.11141 ], [ %309, %for.cond456.preheader.1.1 ], !dbg !64
  %out_1.sroa.26.5 = phi <4 x float> [ %out_1.sroa.26.3, %if.end478.11141 ], [ %308, %for.cond456.preheader.1.1 ], !dbg !64
  %out_1.sroa.0.5 = phi <4 x float> [ %out_1.sroa.0.3, %if.end478.11141 ], [ %307, %for.cond456.preheader.1.1 ], !dbg !64
  br i1 %or.cond856.2.11001, label %if.end478.2.1, label %for.cond434.preheader.2.1, !dbg !101

for.cond434.preheader.2.1:                        ; preds = %if.end478.1.1
  %311 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %231, <4 x half> %probs.sroa.42.1, <4 x float> %out.sroa.0.4), !dbg !102
  %312 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %230, <4 x half> %probs.sroa.42.1, <4 x float> %out.sroa.42.4), !dbg !102
  %313 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %229, <4 x half> %probs.sroa.42.1, <4 x float> %out.sroa.82.4), !dbg !102
  %314 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %228, <4 x half> %probs.sroa.42.1, <4 x float> %out.sroa.122.4), !dbg !102
  br label %if.end478.2.1, !dbg !103

if.end478.2.1:                                    ; preds = %for.cond434.preheader.2.1, %if.end478.1.1
  %out.sroa.122.6 = phi <4 x float> [ %out.sroa.122.4, %if.end478.1.1 ], [ %314, %for.cond434.preheader.2.1 ], !dbg !64
  %out.sroa.82.6 = phi <4 x float> [ %out.sroa.82.4, %if.end478.1.1 ], [ %313, %for.cond434.preheader.2.1 ], !dbg !64
  %out.sroa.42.6 = phi <4 x float> [ %out.sroa.42.4, %if.end478.1.1 ], [ %312, %for.cond434.preheader.2.1 ], !dbg !64
  %out.sroa.0.6 = phi <4 x float> [ %out.sroa.0.4, %if.end478.1.1 ], [ %311, %for.cond434.preheader.2.1 ], !dbg !64
  br i1 %or.cond856.3.11015, label %if.end478.3.1, label %for.cond456.preheader.3.1, !dbg !101

for.cond456.preheader.3.1:                        ; preds = %if.end478.2.1
  %315 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %238, <4 x half> %probs.sroa.62.1, <4 x float> %out_1.sroa.0.5), !dbg !104
  %316 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %237, <4 x half> %probs.sroa.62.1, <4 x float> %out_1.sroa.26.5), !dbg !104
  %317 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %236, <4 x half> %probs.sroa.62.1, <4 x float> %out_1.sroa.50.5), !dbg !104
  %318 = tail call contract <4 x float> @llvm.mxc.mma.f32.16x16x16f16(<4 x half> %235, <4 x half> %probs.sroa.62.1, <4 x float> %out_1.sroa.74.5), !dbg !104
  br label %if.end478.3.1, !dbg !103

if.end478.3.1:                                    ; preds = %for.cond456.preheader.3.1, %if.end478.2.1
  %out_1.sroa.74.7 = phi <4 x float> [ %out_1.sroa.74.5, %if.end478.2.1 ], [ %318, %for.cond456.preheader.3.1 ], !dbg !64
  %out_1.sroa.50.7 = phi <4 x float> [ %out_1.sroa.50.5, %if.end478.2.1 ], [ %317, %for.cond456.preheader.3.1 ], !dbg !64
  %out_1.sroa.26.7 = phi <4 x float> [ %out_1.sroa.26.5, %if.end478.2.1 ], [ %316, %for.cond456.preheader.3.1 ], !dbg !64
  %out_1.sroa.0.7 = phi <4 x float> [ %out_1.sroa.0.5, %if.end478.2.1 ], [ %315, %for.cond456.preheader.3.1 ], !dbg !64
  %out.sroa.0.0.vec.extract = extractelement <4 x float> %out.sroa.0.6, i64 0, !dbg !105
  %out_1.sroa.0.0.vec.extract = extractelement <4 x float> %out_1.sroa.0.7, i64 0, !dbg !106
  %add493 = fadd contract float %out.sroa.0.0.vec.extract, %out_1.sroa.0.0.vec.extract, !dbg !107
  %out.sroa.0.4.vec.extract = extractelement <4 x float> %out.sroa.0.6, i64 1, !dbg !105
  %out_1.sroa.0.4.vec.extract = extractelement <4 x float> %out_1.sroa.0.7, i64 1, !dbg !106
  %add493.1 = fadd contract float %out.sroa.0.4.vec.extract, %out_1.sroa.0.4.vec.extract, !dbg !107
  %out.sroa.0.8.vec.extract = extractelement <4 x float> %out.sroa.0.6, i64 2, !dbg !105
  %out_1.sroa.0.8.vec.extract = extractelement <4 x float> %out_1.sroa.0.7, i64 2, !dbg !106
  %add493.2 = fadd contract float %out.sroa.0.8.vec.extract, %out_1.sroa.0.8.vec.extract, !dbg !107
  %out.sroa.0.12.vec.extract = extractelement <4 x float> %out.sroa.0.6, i64 3, !dbg !105
  %out_1.sroa.0.12.vec.extract = extractelement <4 x float> %out_1.sroa.0.7, i64 3, !dbg !106
  %add493.3 = fadd contract float %out.sroa.0.12.vec.extract, %out_1.sroa.0.12.vec.extract, !dbg !107
  %out.sroa.42.16.vec.extract = extractelement <4 x float> %out.sroa.42.6, i64 0, !dbg !105
  %out_1.sroa.26.16.vec.extract = extractelement <4 x float> %out_1.sroa.26.7, i64 0, !dbg !106
  %add493.4 = fadd contract float %out.sroa.42.16.vec.extract, %out_1.sroa.26.16.vec.extract, !dbg !107
  %out.sroa.42.20.vec.extract = extractelement <4 x float> %out.sroa.42.6, i64 1, !dbg !105
  %out_1.sroa.26.20.vec.extract = extractelement <4 x float> %out_1.sroa.26.7, i64 1, !dbg !106
  %add493.5 = fadd contract float %out.sroa.42.20.vec.extract, %out_1.sroa.26.20.vec.extract, !dbg !107
  %out.sroa.42.24.vec.extract = extractelement <4 x float> %out.sroa.42.6, i64 2, !dbg !105
  %out_1.sroa.26.24.vec.extract = extractelement <4 x float> %out_1.sroa.26.7, i64 2, !dbg !106
  %add493.6 = fadd contract float %out.sroa.42.24.vec.extract, %out_1.sroa.26.24.vec.extract, !dbg !107
  %out.sroa.42.28.vec.extract = extractelement <4 x float> %out.sroa.42.6, i64 3, !dbg !105
  %out_1.sroa.26.28.vec.extract = extractelement <4 x float> %out_1.sroa.26.7, i64 3, !dbg !106
  %add493.7 = fadd contract float %out.sroa.42.28.vec.extract, %out_1.sroa.26.28.vec.extract, !dbg !107
  %out.sroa.82.32.vec.extract = extractelement <4 x float> %out.sroa.82.6, i64 0, !dbg !105
  %out_1.sroa.50.32.vec.extract = extractelement <4 x float> %out_1.sroa.50.7, i64 0, !dbg !106
  %add493.8 = fadd contract float %out.sroa.82.32.vec.extract, %out_1.sroa.50.32.vec.extract, !dbg !107
  %out.sroa.82.36.vec.extract = extractelement <4 x float> %out.sroa.82.6, i64 1, !dbg !105
  %out_1.sroa.50.36.vec.extract = extractelement <4 x float> %out_1.sroa.50.7, i64 1, !dbg !106
  %add493.9 = fadd contract float %out.sroa.82.36.vec.extract, %out_1.sroa.50.36.vec.extract, !dbg !107
  %out.sroa.82.40.vec.extract = extractelement <4 x float> %out.sroa.82.6, i64 2, !dbg !105
  %out_1.sroa.50.40.vec.extract = extractelement <4 x float> %out_1.sroa.50.7, i64 2, !dbg !106
  %add493.10 = fadd contract float %out.sroa.82.40.vec.extract, %out_1.sroa.50.40.vec.extract, !dbg !107
  %out.sroa.82.44.vec.extract = extractelement <4 x float> %out.sroa.82.6, i64 3, !dbg !105
  %out_1.sroa.50.44.vec.extract = extractelement <4 x float> %out_1.sroa.50.7, i64 3, !dbg !106
  %add493.11 = fadd contract float %out.sroa.82.44.vec.extract, %out_1.sroa.50.44.vec.extract, !dbg !107
  %out.sroa.122.48.vec.extract = extractelement <4 x float> %out.sroa.122.6, i64 0, !dbg !105
  %out_1.sroa.74.48.vec.extract = extractelement <4 x float> %out_1.sroa.74.7, i64 0, !dbg !106
  %add493.12 = fadd contract float %out.sroa.122.48.vec.extract, %out_1.sroa.74.48.vec.extract, !dbg !107
  %out.sroa.122.52.vec.extract = extractelement <4 x float> %out.sroa.122.6, i64 1, !dbg !105
  %out_1.sroa.74.52.vec.extract = extractelement <4 x float> %out_1.sroa.74.7, i64 1, !dbg !106
  %add493.13 = fadd contract float %out.sroa.122.52.vec.extract, %out_1.sroa.74.52.vec.extract, !dbg !107
  %out.sroa.122.56.vec.extract = extractelement <4 x float> %out.sroa.122.6, i64 2, !dbg !105
  %out_1.sroa.74.56.vec.extract = extractelement <4 x float> %out_1.sroa.74.7, i64 2, !dbg !106
  %add493.14 = fadd contract float %out.sroa.122.56.vec.extract, %out_1.sroa.74.56.vec.extract, !dbg !107
  %out.sroa.122.60.vec.extract = extractelement <4 x float> %out.sroa.122.6, i64 3, !dbg !105
  %out_1.sroa.74.60.vec.extract = extractelement <4 x float> %out_1.sroa.74.7, i64 3, !dbg !106
  %add493.15 = fadd contract float %out.sroa.122.60.vec.extract, %out_1.sroa.74.60.vec.extract, !dbg !107
  %add507 = fadd contract float %sums.sroa.0.7, 0.000000e+00, !dbg !108
  %add507.1 = fadd contract float %add507, %sums.sroa.20.7, !dbg !108
  %add507.2 = fadd contract float %add507.1, %sums.sroa.38.7, !dbg !108
  %add507.3 = fadd contract float %add507.2, %sums.sroa.56.7, !dbg !108
  %319 = bitcast float %add507.3 to i32, !dbg !109
  %320 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !121
  %321 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %320) #11, !dbg !126
  %xor.i.i = xor i32 %321, 32, !dbg !127
  %322 = and i32 %321, -64, !dbg !128
  %and.i.i = add nsw i32 %322, 64, !dbg !128
  %cmp.not.i.i = icmp slt i32 %xor.i.i, %and.i.i, !dbg !129
  %cond.i.i803 = select i1 %cmp.not.i.i, i32 %xor.i.i, i32 %321, !dbg !130
  %shl.i.i = shl i32 %cond.i.i803, 2, !dbg !131
  %323 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i, i32 %319), !dbg !132
  %324 = bitcast i32 %323 to float, !dbg !133
  %add.i = fadd contract float %add507.3, %324, !dbg !134
  %325 = bitcast float %add.i to i32, !dbg !137
  %326 = tail call i32 @llvm.mxc.mbcnt.lo(i32 -1, i32 0) #11, !dbg !144
  %327 = tail call noundef i32 @llvm.mxc.mbcnt.hi(i32 -1, i32 %326) #11, !dbg !147
  %xor.i.i804 = xor i32 %327, 16, !dbg !148
  %328 = and i32 %327, -64, !dbg !149
  %and.i.i805 = add nsw i32 %328, 64, !dbg !149
  %cmp.not.i.i806 = icmp slt i32 %xor.i.i804, %and.i.i805, !dbg !150
  %cond.i.i807 = select i1 %cmp.not.i.i806, i32 %xor.i.i804, i32 %327, !dbg !151
  %shl.i.i808 = shl i32 %cond.i.i807, 2, !dbg !152
  %329 = tail call noundef i32 @llvm.mxc.bsm.bpermute(i32 %shl.i.i808, i32 %325), !dbg !153
  %330 = bitcast i32 %329 to float, !dbg !154
  %add.i.i = fadd contract float %add.i, %330, !dbg !155
  %cmp516 = fcmp contract ogt float %add.i.i, 0.000000e+00, !dbg !157
  %div = fdiv contract float 1.000000e+00, %add.i.i, !dbg !158
  %condval_1.0 = select i1 %cmp516, float %div, float 0.000000e+00, !dbg !158
  %mul529 = fmul contract float %condval_1.0, %add493, !dbg !159
  %mul529.1 = fmul contract float %condval_1.0, %add493.1, !dbg !159
  %mul529.2 = fmul contract float %condval_1.0, %add493.2, !dbg !159
  %mul529.3 = fmul contract float %condval_1.0, %add493.3, !dbg !159
  %mul529.4 = fmul contract float %condval_1.0, %add493.4, !dbg !159
  %mul529.5 = fmul contract float %condval_1.0, %add493.5, !dbg !159
  %mul529.6 = fmul contract float %condval_1.0, %add493.6, !dbg !159
  %mul529.7 = fmul contract float %condval_1.0, %add493.7, !dbg !159
  %mul529.8 = fmul contract float %condval_1.0, %add493.8, !dbg !159
  %mul529.9 = fmul contract float %condval_1.0, %add493.9, !dbg !159
  %mul529.10 = fmul contract float %condval_1.0, %add493.10, !dbg !159
  %mul529.11 = fmul contract float %condval_1.0, %add493.11, !dbg !159
  %mul529.12 = fmul contract float %condval_1.0, %add493.12, !dbg !159
  %mul529.13 = fmul contract float %condval_1.0, %add493.13, !dbg !159
  %mul529.14 = fmul contract float %condval_1.0, %add493.14, !dbg !159
  %mul529.15 = fmul contract float %condval_1.0, %add493.15, !dbg !159
  %331 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul529), !dbg !160
  %O_reg.sroa.0.0.insert.ext = zext i16 %331 to i64, !dbg !164
  %332 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul529.1), !dbg !160
  %O_reg.sroa.0.2.insert.ext = zext i16 %332 to i64, !dbg !164
  %O_reg.sroa.0.2.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.2.insert.ext, 16, !dbg !164
  %O_reg.sroa.0.2.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.shift, %O_reg.sroa.0.0.insert.ext, !dbg !164
  %333 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul529.2), !dbg !160
  %O_reg.sroa.0.4.insert.ext = zext i16 %333 to i64, !dbg !164
  %O_reg.sroa.0.4.insert.shift = shl nuw nsw i64 %O_reg.sroa.0.4.insert.ext, 32, !dbg !164
  %O_reg.sroa.0.4.insert.insert = or disjoint i64 %O_reg.sroa.0.2.insert.insert, %O_reg.sroa.0.4.insert.shift, !dbg !164
  %334 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul529.3), !dbg !160
  %O_reg.sroa.0.6.insert.ext = zext i16 %334 to i64, !dbg !164
  %O_reg.sroa.0.6.insert.shift = shl nuw i64 %O_reg.sroa.0.6.insert.ext, 48, !dbg !164
  %O_reg.sroa.0.6.insert.insert = or disjoint i64 %O_reg.sroa.0.4.insert.insert, %O_reg.sroa.0.6.insert.shift, !dbg !164
  %335 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul529.4), !dbg !160
  %O_reg.sroa.7.8.insert.ext = zext i16 %335 to i64, !dbg !164
  %336 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul529.5), !dbg !160
  %O_reg.sroa.7.10.insert.ext = zext i16 %336 to i64, !dbg !164
  %O_reg.sroa.7.10.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.10.insert.ext, 16, !dbg !164
  %O_reg.sroa.7.10.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.shift, %O_reg.sroa.7.8.insert.ext, !dbg !164
  %337 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul529.6), !dbg !160
  %O_reg.sroa.7.12.insert.ext = zext i16 %337 to i64, !dbg !164
  %O_reg.sroa.7.12.insert.shift = shl nuw nsw i64 %O_reg.sroa.7.12.insert.ext, 32, !dbg !164
  %O_reg.sroa.7.12.insert.insert = or disjoint i64 %O_reg.sroa.7.10.insert.insert, %O_reg.sroa.7.12.insert.shift, !dbg !164
  %338 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul529.7), !dbg !160
  %O_reg.sroa.7.14.insert.ext = zext i16 %338 to i64, !dbg !164
  %O_reg.sroa.7.14.insert.shift = shl nuw i64 %O_reg.sroa.7.14.insert.ext, 48, !dbg !164
  %O_reg.sroa.7.14.insert.insert = or disjoint i64 %O_reg.sroa.7.12.insert.insert, %O_reg.sroa.7.14.insert.shift, !dbg !164
  %339 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul529.8), !dbg !160
  %O_reg.sroa.12.16.insert.ext = zext i16 %339 to i64, !dbg !164
  %340 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul529.9), !dbg !160
  %O_reg.sroa.12.18.insert.ext = zext i16 %340 to i64, !dbg !164
  %O_reg.sroa.12.18.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.18.insert.ext, 16, !dbg !164
  %O_reg.sroa.12.18.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.shift, %O_reg.sroa.12.16.insert.ext, !dbg !164
  %341 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul529.10), !dbg !160
  %O_reg.sroa.12.20.insert.ext = zext i16 %341 to i64, !dbg !164
  %O_reg.sroa.12.20.insert.shift = shl nuw nsw i64 %O_reg.sroa.12.20.insert.ext, 32, !dbg !164
  %O_reg.sroa.12.20.insert.insert = or disjoint i64 %O_reg.sroa.12.18.insert.insert, %O_reg.sroa.12.20.insert.shift, !dbg !164
  %342 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul529.11), !dbg !160
  %O_reg.sroa.12.22.insert.ext = zext i16 %342 to i64, !dbg !164
  %O_reg.sroa.12.22.insert.shift = shl nuw i64 %O_reg.sroa.12.22.insert.ext, 48, !dbg !164
  %O_reg.sroa.12.22.insert.insert = or disjoint i64 %O_reg.sroa.12.20.insert.insert, %O_reg.sroa.12.22.insert.shift, !dbg !164
  %343 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul529.12), !dbg !160
  %O_reg.sroa.17.24.insert.ext = zext i16 %343 to i64, !dbg !164
  %344 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul529.13), !dbg !160
  %O_reg.sroa.17.26.insert.ext = zext i16 %344 to i64, !dbg !164
  %O_reg.sroa.17.26.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.26.insert.ext, 16, !dbg !164
  %O_reg.sroa.17.26.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.shift, %O_reg.sroa.17.24.insert.ext, !dbg !164
  %345 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul529.14), !dbg !160
  %O_reg.sroa.17.28.insert.ext = zext i16 %345 to i64, !dbg !164
  %O_reg.sroa.17.28.insert.shift = shl nuw nsw i64 %O_reg.sroa.17.28.insert.ext, 32, !dbg !164
  %O_reg.sroa.17.28.insert.insert = or disjoint i64 %O_reg.sroa.17.26.insert.insert, %O_reg.sroa.17.28.insert.shift, !dbg !164
  %346 = tail call noundef i16 @llvm.convert.to.fp16.f32(float %mul529.15), !dbg !160
  %O_reg.sroa.17.30.insert.ext = zext i16 %346 to i64, !dbg !164
  %O_reg.sroa.17.30.insert.shift = shl nuw i64 %O_reg.sroa.17.30.insert.ext, 48, !dbg !164
  %O_reg.sroa.17.30.insert.insert = or disjoint i64 %O_reg.sroa.17.28.insert.insert, %O_reg.sroa.17.30.insert.shift, !dbg !164
  %shr571 = lshr i32 %18, 5
  %and574 = and i32 %18, 7
  %mul580 = and i32 %22, 4
  %xor = xor i32 %shr571, %and574, !dbg !165
  %mul575 = shl nuw nsw i32 %xor, 3, !dbg !166
  %add576 = add nuw nsw i32 %mul575, %mul25, !dbg !167
  %add581 = or disjoint i32 %add576, %mul580, !dbg !168
  %add.ptr583 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add581, !dbg !169
  store i64 %O_reg.sroa.0.6.insert.insert, ptr addrspace(3) %add.ptr583, align 8, !dbg !170
  %add572.1 = add nuw nsw i32 %shr571, 2, !dbg !171
  %xor.1 = xor i32 %add572.1, %and574, !dbg !165
  %mul575.1 = shl nuw nsw i32 %xor.1, 3, !dbg !166
  %add576.1 = add nuw nsw i32 %mul575.1, %mul25, !dbg !167
  %add581.1 = or disjoint i32 %add576.1, %mul580, !dbg !168
  %add.ptr583.1 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add581.1, !dbg !169
  store i64 %O_reg.sroa.7.14.insert.insert, ptr addrspace(3) %add.ptr583.1, align 8, !dbg !170
  %add572.2 = add nuw nsw i32 %shr571, 4, !dbg !171
  %xor.2 = xor i32 %add572.2, %and574, !dbg !165
  %mul575.2 = shl nuw nsw i32 %xor.2, 3, !dbg !166
  %add576.2 = add nuw nsw i32 %mul575.2, %mul25, !dbg !167
  %add581.2 = or disjoint i32 %add576.2, %mul580, !dbg !168
  %add.ptr583.2 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add581.2, !dbg !169
  store i64 %O_reg.sroa.12.22.insert.insert, ptr addrspace(3) %add.ptr583.2, align 8, !dbg !170
  %add572.3 = add nuw nsw i32 %shr571, 6, !dbg !171
  %xor.3 = xor i32 %add572.3, %and574, !dbg !165
  %mul575.3 = shl nuw nsw i32 %xor.3, 3, !dbg !166
  %add576.3 = add nuw nsw i32 %mul575.3, %mul25, !dbg !167
  %add581.3 = or disjoint i32 %add576.3, %mul580, !dbg !168
  %add.ptr583.3 = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %add581.3, !dbg !169
  store i64 %O_reg.sroa.17.30.insert.insert, ptr addrspace(3) %add.ptr583.3, align 8, !dbg !170
  fence syncscope("warp") release, !dbg !172
  tail call void @llvm.mxc.barrier.warp(), !dbg !177
  fence syncscope("warp") acquire, !dbg !178
  %mul594 = and i32 %mul110, 8128
  %xor600760 = and i32 %mul110, 56
  %call598.masked = and i32 %18, 1016
  %mul601 = xor i32 %xor600760, %call598.masked
  %invariant.gep = getelementptr inbounds %struct.__half, ptr addrspace(3) @buf_dyn_shmem, i32 %mul594, !dbg !179
  %invariant.gep853 = getelementptr inbounds %struct.__half, ptr addrspace(3) %invariant.gep, i32 %mul601, !dbg !179
  %add611 = add nuw nsw i32 %add23, %mul110
  %347 = zext nneg i32 %add611 to i64, !dbg !180
  %add.ptr616 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %347, !dbg !181
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr616, ptr addrspace(3) noundef align 16 dereferenceable(16) %invariant.gep853, i64 16, i1 false), !dbg !182, !tbaa.struct !183, !call_argsrelate !184
  %gep854.1 = getelementptr inbounds i8, ptr addrspace(3) %invariant.gep853, i32 1024, !dbg !185
  %348 = getelementptr inbounds %struct.__half, ptr addrspace(1) %Output.coerce, i64 %347, !dbg !181
  %add.ptr616.1 = getelementptr inbounds i8, ptr addrspace(1) %348, i64 1024, !dbg !181
  tail call void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noundef align 16 dereferenceable(16) %add.ptr616.1, ptr addrspace(3) noundef align 16 dereferenceable(16) %gep854.1, i64 16, i1 false), !dbg !182, !tbaa.struct !183, !call_argsrelate !184
  ret void, !dbg !186
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

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(none)
declare i16 @llvm.convert.to.fp16.f32(float) #6

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.exp.f32(float) #7

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
declare i32 @llvm.smax.i32(i32, i32) #7

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smin.i32(i32, i32) #7

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare float @llvm.minnum.f32(float, float) #7

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p1.p3.i64(ptr addrspace(1) noalias nocapture writeonly, ptr addrspace(3) noalias nocapture readonly, i64, i1 immarg) #10

attributes #0 = { mustprogress noreturn nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #1 = { cold noreturn nounwind memory(inaccessiblemem: write) }
attributes #2 = { mustprogress nounwind "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="512" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" }
attributes #3 = { convergent mustprogress norecurse nounwind willreturn "denormal-fp-math-f32"="preserve-sign,preserve-sign" "disable-promote-alloca-to-bsm"="true" "disable-promote-alloca-to-vector"="false" "enable-ldg-bsm-opt"="false" "fixed-function-abi"="true" "metaxgpu-bsm-direct-address"="true" "metaxgpu-implicitarg-num-bytes"="80" "metaxgpu-inline-scope"="11" "metaxgpu-max-block-size"="64" "metaxgpu-min-blocks"="1" "metaxgpu-new-streg-abi"="false" "metaxgpu-pk-fma"="false" "metaxgpu-resource-usage"="false" "metaxgpu-sched-select"="default" "metaxgpu-use-dim-intrinsic"="false" "no-trapping-math"="true" "prec-div"="false" "prec-sqrt"="false" "scalarize-global-loads"="true" "shfl-combine"="true" "stack-protector-buffer-size"="8" "target-cpu"="xcore1000" "target-features"="+xcore1000" "uniform-work-group-size"="true" }
attributes #4 = { convergent nounwind willreturn memory(none) }
attributes #5 = { nounwind speculatable willreturn memory(none) }
attributes #6 = { nocallback nofree nosync nounwind willreturn memory(none) }
attributes #7 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #8 = { convergent nounwind willreturn }
attributes #9 = { nounwind willreturn }
attributes #10 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #11 = { nomerge }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "mxcc version 1.0.0 (6477545d4d)", isOptimized: true, runtimeVersion: 0, emissionKind: LineTablesOnly, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "/tmp/tmp8ftcujjt/tvm_kernels.maca", directory: "/data/tilelang-metax/race_tests/nsa")
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
!41 = !DIFile(filename: "/tmp/tmp8ftcujjt/tvm_kernels.maca", directory: "")
!42 = !DILocation(line: 26, column: 3, scope: !40)
!43 = !DILocation(line: 27, column: 21, scope: !40)
!44 = !DILocation(line: 705, column: 10, scope: !45, inlinedAt: !47)
!45 = distinct !DISubprogram(name: "max", scope: !46, file: !46, line: 704, type: !7, scopeLine: 704, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!46 = !DIFile(filename: "/opt/maca/include/common/__clang_macac_math.h", directory: "")
!47 = distinct !DILocation(line: 28, column: 24, scope: !40)
!48 = !{i32 0, i32 -1}
!49 = !DILocation(line: 708, column: 10, scope: !50, inlinedAt: !51)
!50 = distinct !DISubprogram(name: "min", scope: !46, file: !46, line: 707, type: !7, scopeLine: 707, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!51 = distinct !DILocation(line: 28, column: 20, scope: !40)
!52 = !DILocation(line: 28, column: 48, scope: !40)
!53 = !DILocation(line: 27, column: 90, scope: !40)
!54 = !{i32 0, i32 1024}
!55 = !DILocation(line: 31, column: 3, scope: !40)
!56 = !DILocation(line: 32, column: 43, scope: !40)
!57 = !DILocation(line: 32, column: 29, scope: !40)
!58 = !DILocation(line: 56, column: 25, scope: !40)
!59 = !DILocation(line: 57, column: 112, scope: !40)
!60 = !DILocation(line: 57, column: 135, scope: !40)
!61 = !DILocation(line: 57, column: 65, scope: !40)
!62 = !DILocation(line: 57, column: 51, scope: !40)
!63 = !DILocation(line: 58, column: 9, scope: !40)
!64 = !DILocation(line: 0, scope: !40)
!65 = !DILocation(line: 67, column: 25, scope: !40)
!66 = !DILocation(line: 68, column: 31, scope: !40)
!67 = !DILocation(line: 68, column: 13, scope: !40)
!68 = !DILocation(line: 72, column: 68, scope: !40)
!69 = !DILocation(line: 72, column: 17, scope: !40)
!70 = !DILocation(line: 77, column: 39, scope: !40)
!71 = !DILocation(line: 72, column: 61, scope: !40)
!72 = !DILocation(line: 65, column: 32, scope: !40)
!73 = !DILocation(line: 96, column: 37, scope: !40)
!74 = !{i32 -1, i32 3, i32 -1}
!75 = !DILocation(line: 106, column: 25, scope: !40)
!76 = !DILocation(line: 108, column: 9, scope: !40)
!77 = !DILocation(line: 109, column: 65, scope: !40)
!78 = !DILocation(line: 109, column: 51, scope: !40)
!79 = !DILocation(line: 104, column: 32, scope: !40)
!80 = !DILocation(line: 122, column: 25, scope: !40)
!81 = !DILocation(line: 125, column: 49, scope: !40)
!82 = !DILocation(line: 125, column: 75, scope: !40)
!83 = !DILocation(line: 354, column: 10, scope: !84, inlinedAt: !85)
!84 = distinct !DISubprogram(name: "min", scope: !46, file: !46, line: 353, type: !7, scopeLine: 353, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!85 = distinct !DILocation(line: 125, column: 44, scope: !40)
!86 = !DILocation(line: 288, column: 10, scope: !87, inlinedAt: !88)
!87 = distinct !DISubprogram(name: "expf", scope: !46, file: !46, line: 286, type: !7, scopeLine: 286, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!88 = distinct !DILocation(line: 125, column: 39, scope: !40)
!89 = !DILocation(line: 75, column: 10, scope: !90, inlinedAt: !92)
!90 = distinct !DISubprogram(name: "__llvm_convert_to_fp16", scope: !91, file: !91, line: 74, type: !7, scopeLine: 74, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!91 = !DIFile(filename: "/opt/maca/include/common/irif.h", directory: "")
!92 = distinct !DILocation(line: 984, column: 9, scope: !93, inlinedAt: !95)
!93 = distinct !DISubprogram(name: "__float2half", scope: !94, file: !94, line: 979, type: !7, scopeLine: 979, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!94 = !DIFile(filename: "/opt/maca/include/common/maca_fp16.hpp", directory: "")
!95 = distinct !DILocation(line: 133, column: 53, scope: !96, inlinedAt: !97)
!96 = distinct !DISubprogram(name: "__half", scope: !94, file: !94, line: 133, type: !7, scopeLine: 133, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!97 = distinct !DILocation(line: 133, column: 38, scope: !40)
!98 = !DILocation(line: 133, column: 35, scope: !40)
!99 = !DILocation(line: 120, column: 32, scope: !40)
!100 = !DILocation(line: 129, column: 34, scope: !40)
!101 = !DILocation(line: 145, column: 25, scope: !40)
!102 = !DILocation(line: 149, column: 36, scope: !40)
!103 = !DILocation(line: 143, column: 32, scope: !40)
!104 = !DILocation(line: 157, column: 38, scope: !40)
!105 = !DILocation(line: 168, column: 17, scope: !40)
!106 = !DILocation(line: 168, column: 28, scope: !40)
!107 = !DILocation(line: 168, column: 26, scope: !40)
!108 = !DILocation(line: 173, column: 22, scope: !40)
!109 = !DILocation(line: 1018, column: 9, scope: !110, inlinedAt: !112)
!110 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !111, file: !111, line: 1010, type: !7, scopeLine: 1012, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!111 = !DIFile(filename: "/opt/maca-3.5.3/mxgpu_llvm/lib/clang/19/include/__clang_maca_device_functions.h", directory: "")
!112 = distinct !DILocation(line: 396, column: 10, scope: !113, inlinedAt: !115)
!113 = distinct !DISubprogram(name: "shfl_xor_sync<float>", scope: !114, file: !114, line: 395, type: !7, scopeLine: 395, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!114 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/common.h", directory: "")
!115 = distinct !DILocation(line: 129, column: 24, scope: !116, inlinedAt: !118)
!116 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !117, file: !117, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!117 = !DIFile(filename: "/app/tilelang-metax/3rdparty/../src/tl_templates/maca/reduce.h", directory: "")
!118 = distinct !DILocation(line: 101, column: 14, scope: !119, inlinedAt: !120)
!119 = distinct !DISubprogram(name: "run<float>", scope: !117, file: !117, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!120 = distinct !DILocation(line: 175, column: 12, scope: !40)
!121 = !DILocation(line: 171, column: 37, scope: !122, inlinedAt: !123)
!122 = distinct !DISubprogram(name: "__lane_id", scope: !111, file: !111, line: 170, type: !7, scopeLine: 170, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!123 = distinct !DILocation(line: 990, column: 14, scope: !124, inlinedAt: !125)
!124 = distinct !DISubprogram(name: "__shfl_xor_sync", scope: !111, file: !111, line: 988, type: !7, scopeLine: 989, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!125 = distinct !DILocation(line: 1019, column: 11, scope: !110, inlinedAt: !112)
!126 = !DILocation(line: 171, column: 10, scope: !122, inlinedAt: !123)
!127 = !DILocation(line: 991, column: 20, scope: !124, inlinedAt: !125)
!128 = !DILocation(line: 992, column: 36, scope: !124, inlinedAt: !125)
!129 = !DILocation(line: 992, column: 17, scope: !124, inlinedAt: !125)
!130 = !DILocation(line: 992, column: 11, scope: !124, inlinedAt: !125)
!131 = !DILocation(line: 993, column: 43, scope: !124, inlinedAt: !125)
!132 = !DILocation(line: 993, column: 10, scope: !124, inlinedAt: !125)
!133 = !DILocation(line: 1020, column: 14, scope: !110, inlinedAt: !112)
!134 = !DILocation(line: 25, column: 14, scope: !135, inlinedAt: !136)
!135 = distinct !DISubprogram(name: "operator()<float>", scope: !117, file: !117, line: 24, type: !7, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!136 = distinct !DILocation(line: 129, column: 11, scope: !116, inlinedAt: !118)
!137 = !DILocation(line: 1018, column: 9, scope: !110, inlinedAt: !138)
!138 = distinct !DILocation(line: 396, column: 10, scope: !113, inlinedAt: !139)
!139 = distinct !DILocation(line: 129, column: 24, scope: !140, inlinedAt: !141)
!140 = distinct !DISubprogram(name: "butterfly_reduce_scalar<float>", scope: !117, file: !117, line: 121, type: !7, scopeLine: 121, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!141 = distinct !DILocation(line: 101, column: 14, scope: !142, inlinedAt: !143)
!142 = distinct !DISubprogram(name: "run<float>", scope: !117, file: !117, line: 97, type: !7, scopeLine: 97, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!143 = distinct !DILocation(line: 134, column: 14, scope: !116, inlinedAt: !118)
!144 = !DILocation(line: 171, column: 37, scope: !122, inlinedAt: !145)
!145 = distinct !DILocation(line: 990, column: 14, scope: !124, inlinedAt: !146)
!146 = distinct !DILocation(line: 1019, column: 11, scope: !110, inlinedAt: !138)
!147 = !DILocation(line: 171, column: 10, scope: !122, inlinedAt: !145)
!148 = !DILocation(line: 991, column: 20, scope: !124, inlinedAt: !146)
!149 = !DILocation(line: 992, column: 36, scope: !124, inlinedAt: !146)
!150 = !DILocation(line: 992, column: 17, scope: !124, inlinedAt: !146)
!151 = !DILocation(line: 992, column: 11, scope: !124, inlinedAt: !146)
!152 = !DILocation(line: 993, column: 43, scope: !124, inlinedAt: !146)
!153 = !DILocation(line: 993, column: 10, scope: !124, inlinedAt: !146)
!154 = !DILocation(line: 1020, column: 14, scope: !110, inlinedAt: !138)
!155 = !DILocation(line: 25, column: 14, scope: !135, inlinedAt: !156)
!156 = distinct !DILocation(line: 129, column: 11, scope: !140, inlinedAt: !141)
!157 = !DILocation(line: 177, column: 32, scope: !40)
!158 = !DILocation(line: 177, column: 7, scope: !40)
!159 = !DILocation(line: 185, column: 26, scope: !40)
!160 = !DILocation(line: 75, column: 10, scope: !90, inlinedAt: !161)
!161 = distinct !DILocation(line: 984, column: 9, scope: !93, inlinedAt: !162)
!162 = distinct !DILocation(line: 133, column: 53, scope: !96, inlinedAt: !163)
!163 = distinct !DILocation(line: 191, column: 35, scope: !40)
!164 = !DILocation(line: 191, column: 32, scope: !40)
!165 = !DILocation(line: 196, column: 122, scope: !40)
!166 = !DILocation(line: 196, column: 150, scope: !40)
!167 = !DILocation(line: 196, column: 77, scope: !40)
!168 = !DILocation(line: 196, column: 156, scope: !40)
!169 = !DILocation(line: 196, column: 40, scope: !40)
!170 = !DILocation(line: 196, column: 199, scope: !40)
!171 = !DILocation(line: 196, column: 93, scope: !40)
!172 = !DILocation(line: 68, column: 3, scope: !173, inlinedAt: !174)
!173 = distinct !DISubprogram(name: "__barrier_warp", scope: !111, file: !111, line: 65, type: !7, scopeLine: 65, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!174 = distinct !DILocation(line: 192, column: 3, scope: !175, inlinedAt: !176)
!175 = distinct !DISubprogram(name: "__syncwarp", scope: !111, file: !111, line: 191, type: !7, scopeLine: 191, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0)
!176 = distinct !DILocation(line: 198, column: 3, scope: !40)
!177 = !DILocation(line: 69, column: 3, scope: !173, inlinedAt: !174)
!178 = !DILocation(line: 70, column: 3, scope: !173, inlinedAt: !174)
!179 = !DILocation(line: 200, column: 8, scope: !40)
!180 = !DILocation(line: 200, column: 3, scope: !40)
!181 = !DILocation(line: 201, column: 22, scope: !40)
!182 = !DILocation(line: 201, column: 132, scope: !40)
!183 = !{i64 0, i64 4, !30, i64 4, i64 4, !30, i64 8, i64 4, !30, i64 12, i64 4, !30}
!184 = !{i32 2, i32 -1, i32 -1, i32 -1}
!185 = !DILocation(line: 201, column: 169, scope: !40)
!186 = !DILocation(line: 203, column: 1, scope: !40)
